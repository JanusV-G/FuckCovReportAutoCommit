package entity;

public class User {
    private String user_name;
    private String student_number;
    private String password;
    private String email;
    private String api_key;

    //无参构造方法
    //用于应对BeanListHandler的构建
    public User(){}

    public User(String username, String studentNum, String password, String email, String api_key){
        this.user_name=username;
        this.student_number =studentNum;
        this.password=password;
        this.email=email;
        this.api_key=api_key;
        return ;
    }
    public User(String studentNum, String password, String email, String api_key){
        this.user_name="匿名";
        this.student_number =studentNum;
        this.password=password;
        this.email=email;
        this.api_key=api_key;
        return ;
    }

    public String getUser_name() {
        return user_name;
    }

    public String getStudent_number() {
        return student_number;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getApi_key() {
        return api_key;
    }

    public void setUser_name(String username) {
        this.user_name = username;
    }

    public void setStudent_number(String student_number) {
        this.student_number = student_number;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setApi_key(String api_key) {
        this.api_key = api_key;
    }
}
