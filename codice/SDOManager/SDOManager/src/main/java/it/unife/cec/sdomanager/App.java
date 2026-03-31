package it.unife.cec.sdomanager;

import it.unife.cec.sdomanager.controller.DialogsPopUp;
import it.unife.cec.sdomanager.controller.MainAppController;
import it.unife.cec.sdomanager.database.DbOperations;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;
import java.io.IOException;
import java.sql.Connection;
import javafx.scene.image.Image;

/**
 * JavaFX App
 */
public class App extends Application {
    
    private static Scene scene;

    @Override
    public void start(Stage stage) throws IOException {
        
        Image icon = new Image(getClass().getResourceAsStream("crm.png"));
        
        Connection conn = DbOperations.getDbConnection();
        DbOperations.initDatabase(conn);
        
        scene = new Scene(loadFXML("mainAppForm"), 640, 480);
        stage.setScene(scene);
        stage.getIcons().add(icon);
        stage.setTitle("SDO Manager");
        stage.setMaximized(true);
        stage.show();
        
        stage.setOnCloseRequest(e -> MainAppController.handleExitAction(e));
    }
    

    public static void setRoot(String fxml) throws IOException {
        scene.setRoot(loadFXML(fxml));
    }

    private static Parent loadFXML(String fxml) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(App.class.getResource(fxml + ".fxml"));
        return fxmlLoader.load();
    }

    public static void main(String[] args) {
        launch();
    }
    
   

}