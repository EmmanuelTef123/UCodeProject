// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.controller;
import org.mindrot.jbcrypt.BCrypt;
import codeu.model.data.Conversation;
import codeu.model.data.Message;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.MessageStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import java.util.HashMap;
import java.util.Map;

/** Servlet class responsible for the chat page. */
public class ChatServlet extends HttpServlet {

  HashMap<String, String> keyWords = new HashMap<String, String>();
  //making the keywords and the urls of the asscoaited pictures
  String dog = "dog";
  String dogUrl = "https://www.aspcapetinsurance.com/media/1064/mountain-dog.jpg";
  String cat = "cat";
  String catUrl = "https://i.pinimg.com/originals/19/2d/68/192d6886a2ef123406c1786c56ebb1be.jpg";
  String beach = "beach";
  String beachUrl = "https://i.ytimg.com/vi/PFYXdyLs57o/maxresdefault.jpg";
  String plane = "plane";
  String planeUrl = "https://i.pinimg.com/originals/b2/58/cc/b258cc8976aafff5b8919409cc828e4d.jpg";
  String pool = "pool";
  String poolUrl = "https://thumb1.shutterstock.com/display_pic_with_logo/76168/705108763/stock-vector-cartoon-illustration-of-six-kids-in-a-pool-705108763.jpg";
  String birthday = "birthday";
  String birthdayUrl = "https://i.pinimg.com/736x/d4/2a/d1/d42ad11452465993a13b561383efb2e2--birthday-wishes-happy-birthday.jpg";
  String congrats = "congrats";
  String congratulations = "congratulations";
  String congratsUrl = "http://misspeggysmusic.com/wp-content/uploads/2011/03/congrats.jpg";
  String hungry = "hungry";
  String hungryUrl = "https://thumbs.dreamstime.com/b/cartoon-hungry-man-illustration-holding-knife-fork-48224781.jpg";
  String food = "food";
  String foodUrl = "https://i.pinimg.com/736x/7e/57/5f/7e575f92a9fb1d31ee0d1d9e33bf730b--kraft-foods-i-love-food.jpg";


  /** Store class that gives access to Conversations. */
  private ConversationStore conversationStore;

  /** Store class that gives access to Messages. */
  private MessageStore messageStore;

  /** Store class that gives access to Users. */
  private UserStore userStore;

  //will be the vairable tht represents the image url to send to frontend
  private String image;

  /** Set up state for handling chat requests. */
  @Override
  public void init() throws ServletException {
    super.init();
    setConversationStore(ConversationStore.getInstance());
    setMessageStore(MessageStore.getInstance());
    setUserStore(UserStore.getInstance());
    //adding associations
    keyWords.put(dog , dogUrl);
    keyWords.put(cat, catUrl);
    keyWords.put(beach, beachUrl);
    keyWords.put(plane, planeUrl);
    keyWords.put(pool, poolUrl);
    keyWords.put(birthday, birthdayUrl);
    keyWords.put(congrats, congratsUrl);
    keyWords.put(congratulations, congratsUrl);
    keyWords.put(hungry, hungryUrl);
    keyWords.put(food, foodUrl);
  }

  /**
   * Sets the ConversationStore used by this servlet. This function provides a common setup method
   * for use by the test framework or the servlet's init() function.
   */
  void setConversationStore(ConversationStore conversationStore) {
    this.conversationStore = conversationStore;
  }

  /**
   * Sets the MessageStore used by this servlet. This function provides a common setup method for
   * use by the test framework or the servlet's init() function.
   */
  void setMessageStore(MessageStore messageStore) {
    this.messageStore = messageStore;
  }

  /**
   * Sets the UserStore used by this servlet. This function provides a common setup method for use
   * by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }

  /**
   * This function fires when a user navigates to the chat page. It gets the conversation title from
   * the URL, finds the corresponding Conversation, and fetches the messages in that Conversation.
   * It then forwards to chat.jsp for rendering.
   */
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {
    String requestUrl = request.getRequestURI();
    String conversationTitle = requestUrl.substring("/chat/".length());

    Conversation conversation = conversationStore.getConversationWithTitle(conversationTitle);
    if (conversation == null) {
      // couldn't find conversation, redirect to conversation list
      System.out.println("Conversation was null: " + conversationTitle);
      response.sendRedirect("/conversations");
      return;
    }

    UUID conversationId = conversation.getId();

    List<Message> messages = messageStore.getMessagesInConversation(conversationId);

    request.setAttribute("conversation", conversation);
    request.setAttribute("messages", messages);
    request.setAttribute("image", image);
    request.getRequestDispatcher("/WEB-INF/view/chat.jsp").forward(request, response);
  }

  /**
   * This function fires when a user submits the form on the chat page. It gets the logged-in
   * username from the session, the conversation title from the URL, and the chat message from the
   * submitted form data. It creates a new Message from that data, adds it to the model, and then
   * redirects back to the chat page.
   */
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
      throws IOException, ServletException {

    String username = (String) request.getSession().getAttribute("user");
    if (username == null) {
      // user is not logged in, don't let them add a message
      response.sendRedirect("/login");
      return;
    }

    User user = userStore.getUser(username);
    if (user == null) {
      // user was not found, don't let them add a message
      response.sendRedirect("/login");
      return;
    }

    String requestUrl = request.getRequestURI();
    String conversationTitle = requestUrl.substring("/chat/".length());

    Conversation conversation = conversationStore.getConversationWithTitle(conversationTitle);
    if (conversation == null) {
      // couldn't find conversation, redirect to conversation list
      response.sendRedirect("/conversations");
      return;
    }

    String messageContent = request.getParameter("message");

    // this removes any HTML from the message content
    String cleanedMessageContent = Jsoup.clean(messageContent, Whitelist.none());

    //here i split the message around spaces
    String[] splitMessage = cleanedMessageContent.toLowerCase().split(" ");
    //going through the message and seeing
    //if there is nothing in picture then make it image null and override it if there is
    image = null;

    //check and see if there is anything in the message
    for (int currentWordCount = 0; currentWordCount < splitMessage.length; currentWordCount++){
      if (keyWords.keySet().contains(splitMessage[currentWordCount])){
        image = keyWords.get(splitMessage[currentWordCount]);
        //break;
      }
    }



    Message message =
        new Message(
            UUID.randomUUID(),
            conversation.getId(),
            user.getId(),
            cleanedMessageContent,
            Instant.now(), image);

    messageStore.addMessage(message);

    // redirect to a GET request
    response.sendRedirect("/chat/" + conversationTitle);
  }
}
