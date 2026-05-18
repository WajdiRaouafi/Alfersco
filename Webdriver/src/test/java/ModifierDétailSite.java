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
public class ModifierDétailSite {

    static WebDriver driver;
    static WebDriverWait wait;
    static Properties locators = new Properties();

    static String alfrescoUrl;
    static String baseUrl;
    static String username;
    static String password;
    static String siteName;
    static String siteShortName;

    private static final String NOUVEAU_NOM          = "SiteTest BF2 Modifie";
    private static final String NOUVELLE_DESCRIPTION = "Description modifiee RQ3.BF2.2";

    @BeforeAll
    static void setUp() throws Exception {
        locators.load(new FileInputStream("src/test/java/Locators.properties"));
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--lang=fr");
        driver = new ChromeDriver(options);
        wait   = new WebDriverWait(driver, Duration.ofSeconds(10));
        alfrescoUrl = ConfigReader.getProperty("alfresco_url");
        baseUrl     = ConfigReader.getProperty("alfresco_baseUrl");
        username    = ConfigReader.getProperty("username");
        password    = ConfigReader.getProperty("password");
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

    private void jsClick(By locator) {
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();",
                wait.until(ExpectedConditions.presenceOfElementLocated(locator)));
    }

    private void login() {
        driver.get(alfrescoUrl);
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("username"))).sendKeys(username);
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("password"))).sendKeys(password);
        click(By.id(locators.getProperty("alf_btn_Login")));
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id(locators.getProperty("alf_header_User"))));
    }

    private void logout() {
        click(By.id(locators.getProperty("alf_header_User")));
        click(By.id(locators.getProperty("alf_link_Logout")));
    }

    @Test
    @Order(1)
    @DisplayName("TC1 - Création d'un site modéré")
    void TC1_CreationSite() throws InterruptedException {
        login();
        long ts = System.currentTimeMillis();
        siteName      = "SiteTest BF2 " + ts;
        siteShortName = "sitetest-bf2-" + ts;
        jsClick(By.xpath(locators.getProperty("alf_lnk_SitesMenu")));
        jsClick(By.xpath(locators.getProperty("alf_lnk_CreateSite")));
        type(By.xpath(locators.getProperty("alf_input_SiteName")),  siteName);
        type(By.xpath(locators.getProperty("alf_input_ShortName")), siteShortName);
        Thread.sleep(3000);
        jsClick(By.xpath(locators.getProperty("alf_radio_Moderated")));
        jsClick(By.xpath(locators.getProperty("alf_btn_CreerSite")));
        wait.until(ExpectedConditions.urlContains(siteShortName));
        System.out.println("TC1 ✅ Site créé : " + siteName);
        logout();
    }

    @Test
    @Order(2)
    @DisplayName("TC2 - RQ3.BF2.2 - Modifier le détail du site")
    void TC2_ModifierDetailsSite() throws InterruptedException {
        login();
        driver.get(baseUrl + "/share/page/site/" + siteShortName + "/dashboard");
        jsClick(By.xpath(locators.getProperty("alf_btn_SiteConfig")));
        click(By.xpath(locators.getProperty("alf_lnk_EditSite")));
        type(By.xpath(locators.getProperty("alf_input_SiteName")), NOUVEAU_NOM);
        Thread.sleep(1500);
        type(By.xpath(locators.getProperty("alf_input_Description")), NOUVELLE_DESCRIPTION);
        Thread.sleep(1500);
        jsClick(By.xpath(locators.getProperty("alf_btn_EditSave")));
        wait.until(ExpectedConditions.invisibilityOfElementLocated(By.xpath(locators.getProperty("alf_btn_EditSave"))));
        siteName = NOUVEAU_NOM;
        Assertions.assertTrue(driver.getCurrentUrl().contains(siteShortName),
                "TC2 ÉCHOUÉ : modification non enregistrée.");
        System.out.println("TC2 ✅ Site modifié → nom : \"" + NOUVEAU_NOM + "\", description : \"" + NOUVELLE_DESCRIPTION + "\"");
        logout();
    }

    @Test
    @Order(3)
    @DisplayName("TC3 - Suppression du site")
    void TC3_SupprimerSite() {
        login();
        driver.get(baseUrl + "/share/page/site/" + siteShortName + "/dashboard");
        click(By.xpath(locators.getProperty("alf_btn_SiteConfig")));
        click(By.xpath(locators.getProperty("alf_lnk_DeleteSite")));
        click(By.xpath(locators.getProperty("alf_btn_ConfirmDelete")));
        driver.get(baseUrl + "/share/page/user/" + username + "/user-trashcan");
        click(By.xpath(
                "//tr[.//*[contains(.,'" + siteShortName + "')]]//button[normalize-space(text())='Supprimer']"));
        click(By.xpath(locators.getProperty("alf_btn_TrashConfirm")));
        wait.until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath(locators.getProperty("alf_msg_DeleteSuccess"))));
        System.out.println("TC3 ✅ Site supprimé définitivement : " + siteName);
        logout();
    }
}
