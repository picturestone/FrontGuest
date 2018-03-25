package at.fhv.itb4.teamA.view;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.MenuBar;

public class MainViewController {

	@FXML
	private MenuBar _menuBar;
	
	@FXML
	public void handleCloseAction(ActionEvent event) {
		provideCloseAction();
	}
	
	private void provideCloseAction() {
		System.exit(0);
	}
}
