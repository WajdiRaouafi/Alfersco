package StepsDefinition;

import config.ConfigReader;
import config.DriverManager;
import config.TestContext;
import io.cucumber.java.en.*;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.ExpectedConditions;

import static org.junit.Assert.assertTrue;

public class ModificationRoleMembreSiteSteps {

    // Add-users page
    private static final String INPUT_SEARCH_USER_SITE = "template_x002e_people-finder_x002e_add-users_x0023_default-search-text";
    private static final String BTN_SEARCH_USER_SITE   = "template_x002e_people-finder_x002e_add-users_x0023_default-search-button-button";
    private static final String BTN_SELECTIONNER       = "(//button[normalize-space(text())='Sélectionner'])[1]";
    private static final String BTN_ROLE_MENU          = "//button[contains(normalize-space(.),'Sélectionner un rôle')]";
    private static final String BTN_AJOUTER_USERS      = "template_x002e_invitationlist_x002e_add-users_x0023_default-invite-button-button";
    private static final String MSG_AJOUT_SUCCES       = "//div[contains(@class,'added-users-list-tally')]";

    // Site-members page (role change auto-saved on click — no update button)
    private static final String MSG_ROLE_CHANGE_SUCCES = "//span[contains(.,'Succès du changement')]";

    private final String baseUrl = ConfigReader.getProperty("baseUrl");

    // ── Helpers ────────────────────────────────────────────────────────────

    private void click(By locator) {
        DriverManager.getWait().until(ExpectedConditions.elementToBeClickable(locator)).click();
    }

    private void jsClick(By locator) {
        ((JavascriptExecutor) DriverManager.getDriver()).executeScript("arguments[0].click();",
                DriverManager.getWait().until(ExpectedConditions.presenceOfElementLocated(locator)));
    }

    // ── Steps ──────────────────────────────────────────────────────────────

    @Given("l'administrateur ajoute le nouvel utilisateur au site avec le role Collaborateur")
    public void admin_ajoute_utilisateur_au_site() {
        // Naviguer directement vers la page d'ajout d'utilisateurs du site
        DriverManager.getDriver().get(
                baseUrl + "/share/page/site/" + TestContext.siteShortName + "/add-users");

        // Rechercher l'utilisateur
        DriverManager.getWait()
                .until(ExpectedConditions.visibilityOfElementLocated(By.id(INPUT_SEARCH_USER_SITE)))
                .sendKeys(TestContext.newUsername);
        try { Thread.sleep(1500); } catch (InterruptedException ignored) {}
        jsClick(By.id(BTN_SEARCH_USER_SITE));

        // Sélectionner le premier résultat (bouton "Sélectionner")
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath(BTN_SELECTIONNER)));
        jsClick(By.xpath(BTN_SELECTIONNER));

        // Ouvrir le menu de rôle et choisir "Collaborateur"
        click(By.xpath(BTN_ROLE_MENU));
        click(By.xpath("//a[@class='yuimenuitemlabel' and text()='Collaborateur']"));

        // Confirmer l'ajout
        click(By.id(BTN_AJOUTER_USERS));

        // Attendre le message de succès d'ajout
        DriverManager.getWait().until(
                ExpectedConditions.visibilityOfElementLocated(By.xpath(MSG_AJOUT_SUCCES)));
    }

    @When("l'administrateur navigue vers la page des membres du site")
    public void admin_navigue_membres() {
        DriverManager.getDriver().get(
                baseUrl + "/share/page/site/" + TestContext.siteShortName + "/site-members");

        // Attendre que la liste des membres soit chargée
        DriverManager.getWait().until(ExpectedConditions.visibilityOfElementLocated(
                By.xpath("//span[contains(@id,'roleSelector-" + TestContext.newUsername + "')]")));
    }

    @When("l'administrateur change le role de l'utilisateur en Gestionnaire")
    public void admin_change_role_gestionnaire() {
        // Cliquer sur le bouton de rôle de l'utilisateur (ex: "Collaborateur ▾")
        click(By.xpath(
                "//span[contains(@id,'roleSelector-" + TestContext.newUsername + "')]//button"));

        // Choisir "Gestionnaire" dans le menu YUI
        click(By.xpath("//a[@class='yuimenuitemlabel' and text()='Gestionnaire']"));
    }

    @Then("le role de l'utilisateur est Gestionnaire")
    public void verify_role_gestionnaire() {
        // Le changement de rôle affiche un message de succès immédiatement
        boolean succes = DriverManager.getWait().until(
                ExpectedConditions.visibilityOfElementLocated(By.xpath(MSG_ROLE_CHANGE_SUCCES))
        ).isDisplayed();
        assertTrue("Le message de succès du changement de rôle doit être affiché", succes);
    }
}
