package codeu.controller;

import org.mindrot.jbcrypt.BCrypt; 
import codeu.model.data.Conversation;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.Instant;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import java.util.HashMap;
import java.util.Map;

/**
* Servlet class responsible for user registration.
*/
public class RegisterServlet extends HttpServlet {
/* Consider making this a int, String mapping. Ints are just mapped to array indicies that contain the Strings on each picture*/
  HashMap<Integer, String> registerTest = new HashMap<Integer, String>();
  String [] answers = new String [10];
  //making the keywords and the urls of the asscoaited pictures
  String rPic0 = "czchjiav";
  String rPic0Address = "/images/registrationPics/czchjiav.gif";
  String rPic1 = "dpbaiajz";
  String rPic1Address = "/images/registrationPics/dpbaiajz.gif";
  String rPic2 = "lucytpft";
  String rPic2Address = "/images/registrationPics/lucytpft.gif";
  String rPic3 = "nrtgdkwn";
  String rPic3Address = "/images/registrationPics/nrtgdkwn.gif";
  String rPic4 = "nvhoxdm";
  String rPic4Address = "/images/registrationPics/nvhoxdm.gif";
  String rPic5 = "phxxjdrk";
  String rPic5Address = "/images/registrationPics/phxxjdrk.gif";
  String rPic6 = "udbbgxls";
  String rPic6Address = "/images/registrationPics/udbbgxls.gif";
  String rPic7 = "wvvjcfua";
  String rPic7Address = "/images/registrationPics/wvvjcfua.gif";
  String rPic8 = "yhykemwr";
  String rPic8Address = "/images/registrationPics/yhykemwr.gif";
  String rPic9 = "zagxtwdx";
  String rPic9Address = "/images/registrationPics/zagxtwdx.gif";
  int randomRPic;
  String currentPicAddress;

 @Override
 public void doGet(HttpServletRequest request, HttpServletResponse response)
     throws IOException, ServletException {
      randomRPic = (int)(Math.random()*10);
      String currentPicAddress = registerTest.get(randomRPic);
      request.setAttribute("currentPicAddress", currentPicAddress);
   request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
 }

 @Override
 public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws IOException, ServletException {

   String username = request.getParameter("username");
   String password = request.getParameter("password");
   String confirmPassword = request.getParameter("confirmPassword");
   String humanVerification = request.getParameter("humanVerification");
   String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

   String idPic = request.getParameter("idPic");


   String currentPicAddress = registerTest.get(randomRPic);
   request.setAttribute("currentPicAddress", currentPicAddress);

   if (!humanVerification.matches(answers[randomRPic])) {
    request.setAttribute("error", "Error! It appears as though you're a robot... Try Again");
    request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    return;
  }

 // request.setAttribute(currentPicAddress);
   if (!username.matches("[\\w*\\s*]*")) {
     request.setAttribute("error", "Please enter only letters, numbers, and spaces.");
     request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
     return;
   }

   if (userStore.isUserRegistered(username)) {
     request.setAttribute("error", "That username is already taken.");
     request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
     return;
   }

   if (!password.equals(confirmPassword)) {
    request.setAttribute("error", "Those passwords didn't match. Try again.");
    request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    return;
  }
  if(idPic == null){
    //so they have not chose a picture should make them choose picture
      request.setAttribute("error", "To register must choose a picture");
     request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
   }

   User user = new User(UUID.randomUUID(), username, passwordHash, Instant.now(), idPic);
   userStore.addUser(user);

   response.sendRedirect("/login");
 }
 /**
  * Store class that gives access to Users.
  */
  private UserStore userStore;

  /**
   * Set up state for handling registration-related requests. This method is only called when
   * running in a server, not when running in a test.
   */
  @Override
  public void init() throws ServletException {
    super.init();
    setUserStore(UserStore.getInstance());
    //adding associations
    registerTest.put(0, rPic0Address );
    registerTest.put(1, rPic1Address);
    registerTest.put(2, rPic2Address);
    registerTest.put(3, rPic3Address);
    registerTest.put(4, rPic4Address);
    registerTest.put(5, rPic5Address);
    registerTest.put(6, rPic6Address);
    registerTest.put(7, rPic7Address);
    registerTest.put(8, rPic8Address);
    registerTest.put(9, rPic9Address);
    answers[0] = rPic0;
    answers[1] = rPic1;
    answers[2] = rPic2;
    answers[3] = rPic3;
    answers[4] = rPic4;
    answers[5] = rPic5;
    answers[6] = rPic6;
    answers[7] = rPic7;
    answers[8] = rPic8;
    answers[9] = rPic9;
  }
 


  /**
   * Sets the UserStore used by this servlet. This function provides a common setup method
   * for use by the test framework or the servlet's init() function.
   */
  void setUserStore(UserStore userStore) {
    this.userStore = userStore;
  }
}


