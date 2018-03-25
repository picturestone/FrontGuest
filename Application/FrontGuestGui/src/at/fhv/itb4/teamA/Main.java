package at.fhv.itb4.teamA;
	
import java.io.IOException;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;


public class Main extends Application {

	private Stage _mainWindow;
	private BorderPane _mainView;
	
	@Override
	public void start(Stage primaryStage) {
		try {
			_mainWindow = primaryStage;
			_mainWindow.setTitle("FrontGuest v0.1");
			
			loadMainView();
			
			//show the scene containing the main view
			Scene scene = new Scene(_mainView);
			_mainWindow.setScene(scene);
			_mainWindow.show();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private void loadMainView() throws IOException {
		FXMLLoader loader = new FXMLLoader();
		loader.setLocation(Main.class.getResource("view/MainView.fxml"));
		_mainView = (BorderPane) loader.load();
	}
	
	public static void main(String[] args) {
		launch(args);
	}
}
