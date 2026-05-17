package StepsDefinition;

import static org.junit.Assert.assertTrue;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;

import config.ConfigReader;
import config.DriverManager;
import config.TestContext;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

public class DemanderRejoindreSteps {

    // --- LOGIN ---
    private static final String BTN_LOGIN = "//button[contains(text(), 'Connexion')]";
    private static final String HEADER_USER = "HEADER_USER_MENU_POPUP_text";
    private static final String LINK_LOGOUT = "HEADER_USER_MENU_LOGOUT_text";

    // --- CREATION SITE ---
    private static final String LNK_SITES_MENU      = "//span[@id='HEADER_SITES_MENU_text']";
    private static final String LNK_CREATE_SITE     = "//td[@id='HEADER_SITES_MENU_CREATE_SITE_text']";
    private static final String INPUT_SITE_NAME     = "//input[@class='dijitReset dijitInputInner' and @name='title']";
    private static final String INPUT_SHORT_NAME    = "//input[@class='dijitReset dijitInputInner' and @name='shortName']";
    private static final String RADIO_MODERATED     = "//input[@name='visibility' and @value='MODERATED']";
    private static final String BTN_CREER           = "//span[@id='CREATE_SITE_DIALOG_OK_label']";

    // --- SUPPRESSION SITE ---
    private static final String BTN_SITE_CONFIG = "//div[@id='HEADER_SITE_CONFIGURATION_DROPDOWN']";
    private static final String LNK_DELETE_SITE = "//tr[@id='HEADER_DELETE_SITE']";
    private static final String BTN_CONFIRM_DELETE = "//span[@id='ALF_SITE_SERVICE_DIALOG_CONFIRMATION_label' and text()='OK']";

    // --- CREATION UTILISATEUR ---
    private static final String LNK_OUTILS_ADMIN = "//a[@title='Outils admin']";
    private static final String LNK_UTILISATEURS = "//a[@href='users' and @title='Gestion des utilisateurs']";
    private static final String BTN_NOUVEL_USER = "page_x002e_ctool_x002e_admin-console_x0023_default-newuser-button-button";
    private static final String INPUT_FIRSTNAME = "page_x002e_ctool_x002e_admin-console_x0023_default-create-firstname";
    private static final String INPUT_EMAIL = "page_x002e_ctool_x002e_admin-console_x0023_default-create-email";
    private static final String INPUT_NEW_USER = "page_x002e_ctool_x002e_admin-console_x0023_default-create-username";
    private static final String INPUT_NEW_PWD = "page_x002e_ctool_x002e_admin-console_x0023_default-create-password";
    private static final String INPUT_VERIFY_PWD = "page_x002e_ctool_x002e_admin-console_x0023_default-create-verifypassword";
    private static final String BTN_CREATE_USER = "page_x002e_ctool_x002e_admin-console_x0023_default-createuser-ok-button-button";

    // --- SUPPRESSION UTILISATEUR ---
    private static final String INPUT_SEARCH_USER = "//input[contains(@id,'default-search-text')]";
    private static final String BTN_SEARCH_USER = "//button[contains(@id,'default-search-button-button')]";
    private static final String BTN_DELETE_USER = "//button[contains(@id,'default-delete-button-button')]";
    private static final String BTN_CONFIRM_DEL_USR = "//button[@id='page_x002e_ctool_x002e_admin-console_x0023_default-remove-button-button']";

    // --- RECHERCHE DE SITES ---
    private static final String LNK_RECHERCHE_SITES = "//a[contains(@href,'site-finder')]";
    private static final String BTN_RECHERCHER = "template_x002e_site-finder_x002e_site-finder_x0023_default-button-button";
    private static final String MSG_SUCCES = "//span[contains(text(),'Succès de la demande')]";

    private final String adminUrl = ConfigReader.getProperty("url");
    private final String baseUrl = ConfigReader.getProperty("baseUrl");
    private final String adminUser = ConfigReader.getProperty("username");
    private final String adminPwd = ConfigReader.getProperty("password");
    private final String usersAdminUrl = ConfigReader.getProperty("adminConsoleUsersUrl");


    // ── Helpers ────────────────────────────────────────────────────────────

    private void click(By locator) {
        DriverManager.getWait().until(ExpectedConditions.elementToBeClickable(locator)).click();
    }

    private void type(By locator, String text) {
        WebElement el = DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(locator));
        el.clear();
        el.sendKeys(text);
    }

    private void jsClick(By locator) {
        ((JavascriptExecutor) DriverManager.getDriver()).executeScript("arguments[0].click();",
                DriverManager.getWait().until(ExpectedConditions.presenceOfElementLocated(locator)));
    }

    private void login(String username, String password) {
        DriverManager.getDriver().get(adminUrl);
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(By.name("username"))).sendKeys(username);
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(By.name("password"))).sendKeys(password);
        click(By.xpath(BTN_LOGIN));
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(By.id(HEADER_USER)));
    }

    private void logout() {
        click(By.id(HEADER_USER));
        click(By.id(LINK_LOGOUT));
    }

    // ── Steps ──────────────────────────────────────────────────────────────

    @Given("le navigateur est ouvert")
    public void le_navigateur_est_ouvert() {
        DriverManager.initDriver();
    }

    @Given("l'administrateur se connecte sur Alfresco")
    public void l_administrateur_se_connecte() {
        login(adminUser, adminPwd);
    }

    @Given("l'administrateur cree un nouveau site modere")
    public void l_administrateur_cree_site_modere() {
        long ts = System.currentTimeMillis();
        TestContext.siteName      = "SiteTest RQ3 " + ts;
        TestContext.siteShortName = "sitetest-rq3-" + ts;

        jsClick(By.xpath(LNK_SITES_MENU));
        jsClick(By.xpath(LNK_CREATE_SITE));

        type(By.xpath(INPUT_SITE_NAME),  TestContext.siteName);
        type(By.xpath(INPUT_SHORT_NAME), TestContext.siteShortName);

        try { Thread.sleep(3000); } catch (InterruptedException ignored) {}

        jsClick(By.xpath(RADIO_MODERATED));
        jsClick(By.xpath(BTN_CREER));

        try {
            DriverManager.getWait().until(ExpectedConditions.urlContains(TestContext.siteShortName));
        } catch (TimeoutException e) {
            DriverManager.getDriver().get(baseUrl + "/share/page/site/" + TestContext.siteShortName + "/dashboard");
            DriverManager.getWait().until(ExpectedConditions.urlContains(TestContext.siteShortName));
        }
    }

    @Given("l'administrateur cree un nouvel utilisateur")
    public void l_administrateur_cree_utilisateur() {
        long ts = System.currentTimeMillis();
        TestContext.newFirstName = "Jean";
        TestContext.newUsername  = "user_rq3_" + ts;
        TestContext.newEmail     = "user.rq3." + ts + "@test.com";

        click(By.xpath(LNK_OUTILS_ADMIN));
        click(By.xpath(LNK_UTILISATEURS));
        click(By.id(BTN_NOUVEL_USER));

        type(By.id(INPUT_FIRSTNAME),  TestContext.newFirstName);
        type(By.id(INPUT_EMAIL),      TestContext.newEmail);
        type(By.id(INPUT_NEW_USER),   TestContext.newUsername);
        type(By.id(INPUT_NEW_PWD),    TestContext.newPassword);
        type(By.id(INPUT_VERIFY_PWD), TestContext.newPassword);

        click(By.id(BTN_CREATE_USER));
        DriverManager.getWait().until(ExpectedConditions.urlContains("admin-console"));
    }

    @Given("l'administrateur se deconnecte")
    public void l_administrateur_se_deconnecte() {
        logout();
    }

    @When("le nouvel utilisateur se connecte sur Alfresco")
    public void le_nouvel_utilisateur_se_connecte() {
        login(TestContext.newUsername, TestContext.newPassword);
    }

    @When("le nouvel utilisateur ouvre la Recherche de sites via le menu Sites")
    public void le_nouvel_utilisateur_ouvre_recherche_sites() {
        new Actions(DriverManager.getDriver())
                .moveToElement(DriverManager.getWait().until(
                        ExpectedConditions.visibilityOfElementLocated(By.xpath(LNK_SITES_MENU))))
                .click().perform();
        click(By.xpath(LNK_RECHERCHE_SITES));
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(By.id(BTN_RECHERCHER)));
    }

    @When("le nouvel utilisateur clique sur le bouton Rechercher")
    public void le_nouvel_utilisateur_clique_rechercher() {
        click(By.id(BTN_RECHERCHER));
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//button[contains(.,'Demander à rejoindre') or contains(.,'Demander a rejoindre')]")));
    }

    @When("le nouvel utilisateur clique sur Demander a rejoindre pour le site cree")
    public void le_nouvel_utilisateur_clique_demander_rejoindre() {
        click(By.xpath(
                "//tr[.//a[contains(@href,'" + TestContext.siteShortName + "')]]" +
                "//button[contains(.,'Demander à rejoindre') or contains(.,'Demander a rejoindre')]"));
    }

    @Then("un message de succes de la demande est affiche")
    public void un_message_de_succes_est_affiche() {
        assertTrue(DriverManager.getWait()
                .until(ExpectedConditions.visibilityOfElementLocated(By.xpath(MSG_SUCCES)))
                .isDisplayed());
    }

    @And("l'administrateur se reconnecte sur Alfresco")
    public void l_administrateur_se_reconnecte() {
        logout();
        login(adminUser, adminPwd);
    }

    @And("l'administrateur supprime le site cree")
    public void l_administrateur_supprime_le_site() {
        DriverManager.getDriver().get(baseUrl + "/share/page/site/" + TestContext.siteShortName + "/dashboard");
        click(By.xpath(BTN_SITE_CONFIG));
        click(By.xpath(LNK_DELETE_SITE));
        click(By.xpath(BTN_CONFIRM_DELETE));
    }

    @And("l'administrateur supprime definitivement le site de la corbeille")
    public void l_administrateur_supprime_site_corbeille() {
        DriverManager.getDriver().get(baseUrl + "/share/page/user/" + adminUser + "/user-trashcan");
        click(By.xpath(
                "//tr[.//div[@class='name' and contains(text(),'" + TestContext.siteShortName + "')]]" +
                "//button[normalize-space(text())='Supprimer']"));
        click(By.xpath("//button[normalize-space(text())='OK']"));
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//span[contains(.,'Suppression réussie')]")));
    }

    @And("l'administrateur supprime le nouvel utilisateur cree")
    public void l_administrateur_supprime_l_utilisateur() {
        DriverManager.getDriver().get(usersAdminUrl);
        type(By.xpath(INPUT_SEARCH_USER), TestContext.newUsername);
        click(By.xpath(BTN_SEARCH_USER));
        click(By.xpath("//a[normalize-space(text())='" + TestContext.newUsername + "']"));
        click(By.xpath(BTN_DELETE_USER));
        click(By.xpath(BTN_CONFIRM_DEL_USR));
    }
}
