import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.sql.PreparedStatement;


import java.io.FileReader;
import java.io.BufferedReader;
import java.util.Scanner;

public class SQLServerDemo {

    // Connect to your database.
    // Replace server name, username, and password with your credentials

  private static String connectionUrl = "";
  private static ResultSet resultSet = null;


  public static void main(String[] args) {
    initDB();
    runConsole();
    // numberOfType();
  }

  public static void initDB(){
    Properties prop = new Properties();
    String fileName = "auth.cfg";
    try {
        FileInputStream configFile = new FileInputStream(fileName);
        prop.load(configFile);
        configFile.close();
    } catch (FileNotFoundException ex) {
        System.out.println("Could not find config file.");
        System.exit(1);
    } catch (IOException ex) {
        System.out.println("Error reading config file.");
        System.exit(1);
    }
    String username = (prop.getProperty("username"));
    String password = (prop.getProperty("password"));

    if (username == null || password == null){
        System.out.println("Username or password not provided.");
        System.exit(1);
    }

    connectionUrl =
            "jdbc:sqlserver://uranium.cs.umanitoba.ca:1433;"
            + "database=cs3380;"
            + "user=" + username + ";"
            + "password="+ password +";"
            + "encrypt=false;"
            + "trustServerCertificate=false;"
            + "loginTimeout=30;";
  }

  public static void runConsole() {

		Scanner console = new Scanner(System.in);
		System.out.print("Welcome to the Pokemon 4th Generation Database! \nType h for help. ");
		System.out.print("db > ");
		String line = console.nextLine();
		String[] parts;
		String arg = "";

		while (line != null && !line.equals("q")) {
			parts = line.split("\\s+");
			if (line.indexOf(" ") > 0)
				arg = line.substring(line.indexOf(" ")).trim();

			if (parts[0].equals("h"))
				printHelp();
			else if (parts[0].equals("all")) {
				listAllPokemon();
			}
			else if (parts[0].equals("s")) {
        try {
          if (parts.length >= 2)
            searchPokemon(arg);
          else
            System.out.println("Require an argument for this command");  
        } 
        catch (Exception e) {
          System.out.println("id must be an integer");
        }
				
			}
      else if (parts[0].equals("listType")) {
        numberOfType();
			}
      
			else
				System.out.println("Read the help with h, or find help somewhere else.");

			System.out.print("db > ");
			line = console.nextLine();
		}

		console.close();
	}

	private static void printHelp() {
		System.out.println("Library database");
		System.out.println("Commands:");
		System.out.println("h - Get help");
    System.out.println("all - Authors that have read all their own books");
		System.out.println("s <dexNum> - Search for a name");
    System.out.println("listType - Number of Pokemon for each type");
		System.out.println("");

		System.out.println("q - Exit the program");

		System.out.println("---- end help ----- ");
	}

  public static void listAllPokemon(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT dexNum, name FROM POKEMON";
      resultSet = statement.executeQuery(selectSql);

      // Print results from select statement
      while (resultSet.next()) {
          System.out.println("Pokemon "+resultSet.getInt("dexNum")+ " : " +resultSet.getString("name"));
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void searchPokemon(String dex){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      ) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT dexNum, name FROM pokemon WHERE dexNum = ?;";
      PreparedStatement statement = connection.prepareStatement(selectSql);
      statement.setString(1, dex);
      resultSet = statement.executeQuery();

      // Print results from select statement
      while (resultSet.next()) {
          System.out.println("Pokemon "+resultSet.getInt("dexNum")+ " : " +resultSet.getString("name"));
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void numberOfType(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT typeName, count(typeName) as pokeAmount FROM pokemon JOIN pokemonHasTypes ON pokemon.dexNum = pokemonHasTypes.dexNum GROUP BY typeName;";
      resultSet = statement.executeQuery(selectSql);

      // Print results from select statement
      while (resultSet.next()) {
          System.out.println("Type "+resultSet.getString("typename")+ " has " +resultSet.getInt("pokeAmount") + " many Pokemon of this type");
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }
}