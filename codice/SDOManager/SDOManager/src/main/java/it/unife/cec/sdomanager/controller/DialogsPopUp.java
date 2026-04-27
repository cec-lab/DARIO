/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.unife.cec.sdomanager.controller;

import java.util.Optional;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;

/**
 *
 * @author utente
 */
public class DialogsPopUp {
    
    public static boolean confirmPopUp(String titolo, String messaggio) {

    Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
    alert.setTitle(titolo);
    alert.setHeaderText(null);
    alert.setContentText(messaggio);

    Optional<ButtonType> result = alert.showAndWait();

    return result.isPresent() && result.get() == ButtonType.OK;
    }
    
    public static boolean warnPopUp(String titolo, String messaggio) {

    Alert alert = new Alert(Alert.AlertType.WARNING);
    alert.setTitle(titolo);
    alert.setHeaderText(null);
    alert.setContentText(messaggio);

    Optional<ButtonType> result = alert.showAndWait();

    return result.isPresent() && result.get() == ButtonType.OK;
    }
}
