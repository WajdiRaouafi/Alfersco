import config.ConfigReader;
import org.junit.jupiter.api.*;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.*;

import java.io.FileInputStream;
import java.time.Duration;
import java.util.Properties;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class SuivrePersonne {

    static WebDriver driver;
    static WebDriverWait wait;
    static Properties locators = new Properties();

    static String alfrescoUrl;
    static String baseUrl;
    static String username;
    static String password;
    static String testUserName;

    private static final String TEST_FIRST_NAME = "RQ5";
    private static final String TEST_PASSWORD   = "Test1234!";

    @BeforeAll
    static void setUp() throws Exception {
        locators.load(new FileInputStream("src/test/java/Locators.properties"));
        alfrescoUrl  = ConfigReader.getProperty("alfresco_url");
        baseUrl      = ConfigReader.getProperty("alfresco_baseUrl");
        username     = ConfigReader.getProperty("username");
        password     = ConfigReader.getProperty("password");
        testUserName = "user_rq5_" + System.currentTimeMillis();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--lang=fr");
        driver = new ChromeDriver(options);
        wait   = new WebDriverWait(driver, Duration.ofSeconds(10));
        driver.manage().window().maximize();
    }

    @AfterAll
    static void tearDown() {
        if (driver != null) driver.quit();
    }

    private void click(By locator) {
        wait.until(ExpectedConditions.elementToBeClickable(locator)).click();
    }

    private void type(By locator, String text) {
        WebElement el = wait.until(ExpectedConditions.visibilityOfElementLocated(locator));
        el.clear();
        el.sendKeys(text);
    }

    private void login(String user, String pwd) {
        driver.get(alfrescoUrl);
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("username"))).sendKeys(user);
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("password"))).sendKeys(pwd);
        click(By.id(locators.getProperty("alf_btn_Login")));
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id(locators.getProperty("alf_header_User"))));
    }

    private void logout() {
        click(By.id(locators.getProperty("alf_header_User")));
        click(By.id(locators.getProperty("alf_link_Logout")));
    }

    private void rechercherPersonne(String nom) throws InterruptedException {
        driver.get(baseUrl + "/share/page/people-finder");
        WebElement search = wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.id(locators.getProperty("alf_ppl_inputRecherche"))));
        search.clear();
        search.sendKeys(nom);
        search.sendKeys(Keys.RETURN);
        Thread.sleep(2000);
    }

    @Test
    @Order(1)
    @DisplayName("TC1 - Créer un utilisateur de test (Admin Console)")
    void TC1_CreerUtilisateur() throws InterruptedException {
        login(username, password);
        driver.get(baseUrl + "/share/page/console/admin-console/users");
        click(By.id(locators.getProperty("alf_adm_btnNouvelUtil")));
        type(By.id(locators.getProperty("alf_adm_inputPrenom")),     TEST_FIRST_NAME);
        type(By.id(locators.getProperty("alf_adm_inputEmail")),      testUserName + "@test.com");
        type(By.id(locators.getProperty("alf_adm_inputLogin")),      testUserName);
        type(By.id(locators.getProperty("alf_adm_inputMotDePasse")), TEST_PASSWORD);
        type(By.id(locators.getProperty("alf_adm_inputConfirmMdp")), TEST_PASSWORD);
        Thread.sleep(500);
        click(By.id(locators.getProperty("alf_adm_btnCreer")));
        wait.until(ExpectedConditions.urlContains("admin-console/users"));
        System.out.println("TC1 ✅ Utilisateur créé : " + testUserName);
        logout();
    }

    @Test
    @Order(2)
    @DisplayName("TC2 - RQ5.BF1.2 - Suivre l'administrateur et vérifier")
    void TC2_SuivreEtVerifier() throws InterruptedException {
        // Nouvel utilisateur suit l'admin
        login(testUserName, TEST_PASSWORD);
        rechercherPersonne("Raouafi");
        click(By.xpath(locators.getProperty("alf_ppl_btnSuivre")));
        wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath(locators.getProperty("alf_ppl_btnNePasSuivre"))));
        System.out.println("TC2a ✅ " + testUserName + " suit Raouafi Wajdi");
        logout();

        // Admin vérifie que le nouvel utilisateur apparaît dans ses suiveurs
        login(username, password);
        driver.get(baseUrl + "/share/page/user/" + username + "/profile");
        click(By.id(locators.getProperty("alf_ppl_lnkFollowers")));
        wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//ul[contains(@class,'people')]//a[contains(@href,'" + testUserName + "')]")));
        System.out.println("TC2b ✅ " + testUserName + " apparaît dans les suiveurs de Raouafi Wajdi");
        logout();
    }

    @Test
    @Order(3)
    @DisplayName("TC3 - Ne plus suivre la personne")
    void TC3_NePlusSuivre() throws InterruptedException {
        // Nouvel utilisateur ne suit plus l'admin
        login(testUserName, TEST_PASSWORD);
        rechercherPersonne("Raouafi");
        click(By.xpath(locators.getProperty("alf_ppl_btnNePasSuivre")));
        wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath(locators.getProperty("alf_ppl_btnSuivre"))));
        System.out.println("TC3 ✅ " + testUserName + " ne suit plus Raouafi Wajdi");
        logout();
    }
}
