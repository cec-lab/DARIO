module it.unife.cec.sdomanager {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;
    requires com.opencsv;
    requires org.kordamp.ikonli.javafx;
    requires org.kordamp.ikonli.fontawesome;
    requires org.xerial.sqlitejdbc;

    opens it.unife.cec.sdomanager;
    opens it.unife.cec.sdomanager.controller to javafx.fxml;
    exports it.unife.cec.sdomanager.controller to javafx.fxml;
    exports it.unife.cec.sdomanager.database;
    
}
