package runners;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "src/test/resources/Features/ModificationRoleMembreSite.feature",
        glue     = "StepsDefinition",
        plugin   = {"pretty", "html:target/rapport-modification-role.html"}
)
public class ModificationRoleMembreSiteRunner {
}
