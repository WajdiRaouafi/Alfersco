package StepsDefinition;

import config.DriverManager;
import io.cucumber.java.After;

public class Hooks {

    @After
    public void tearDown() {
        DriverManager.quitDriver();
    }
}
