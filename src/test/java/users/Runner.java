package users;

import com.intuit.karate.Results;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


class Runner {

    @Test
    void runNewsTests() {
        Results results = com.intuit.karate.Runner.path("classpath:users/checkUserCreateFunctionality.feature")
                .tags("~@ignore")
                .outputCucumberJson(true)
                .parallel(1);
        generateReport(results.getReportDir());
    }

    public static void generateReport(String karateOutPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add((file.getAbsolutePath())));
        Configuration config = new Configuration(new File("target"), "myproject");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}


