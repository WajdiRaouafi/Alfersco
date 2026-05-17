package runners;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = "src/test/resources/Features/DemanderRejoindre.feature",
        glue     = "StepsDefinition",
        plugin   = {"pretty", "html:target/rapport-demander-rejoindre.html"}
)
public class DemanderRejoindreRunner {
}
