package codeu.controller;
//needed to import to make compile when making new user
import codeu.model.data.User;
import java.time.Instant;
import java.util.UUID;
import codeu.model.store.basic.UserStore;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
  * Servlet class responsible for user registration.
  */
public class RegisterServlet extends HttpServlet {
  private UserStore userStore;

  void setUserStore(UserStore userStore) {
   this.userStore = userStore;
  }

  @Override
  public void init() throws ServletException {
   super.init();
   setUserStore(UserStore.getInstance());
  }

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException {

    request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
  }
  //this functions is so that when the register clicks submit button we are routed here
  @Override
  public void doPost(HttpServletRequest request, HttpServletResponse response)
     throws IOException, ServletException {
      //now we want to store the username and password
      String username = request.getParameter("username");
      String password = request.getParameter("password");
      String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());

      //checking to make sure that the username entered is only letter,numbers,spaces
      if (!username.matches("[\\w*\\s*]*")){
        request.setAttribute("error", "please enter only letters, number and spaces.");

        //now that they wntered it wrong we want to go back to the register page
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);

        return;
      }

      //check what to do if user is registered
      if (userStore.isUserRegistered(username)){
        request.setAttribute("error", "That username is already taken.");

        //redirect to the same register page but with attribute
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);

        return;
      }

      //now when weve made sure that unique & proper username
      User user = new User(UUID.randomUUID(), username, passwordHash, Instant.now());
      userStore.addUser(user);
      //was: User user = new User(UUID.randomUUID(), username, password, Instant.now());

      response.sendRedirect("/login");

     }
}
