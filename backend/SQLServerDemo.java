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
		System.out.println("Welcome to the Pokemon 4th Generation Database! \nType h for help. ");
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
			else if (parts[0].equals("allP")) {
				listAllPokemon();
			}
      else if (parts[0].equals("allA")) {
				listAllAbilities();
			}
      else if (parts[0].equals("allL")) {
				listAllLocations();
			}
      else if (parts[0].equals("allEgg")) {
				listAllEgg();
			}
      else if (parts[0].equals("pAtk")) {
				pAtk();
			}
      else if (parts[0].equals("sAtk")) {
				sAtk();
			}
			else if (parts[0].equals("sID")) {
        try {
          if (parts.length >= 2)
            searchPkmnByID(arg);
          else
            System.out.println("Require an argument for this command");  
        } 
        catch (Exception e) {
          System.out.println("id must be an integer");
        }
			}
      else if (parts[0].equals("sName")) {
        try {
          if (parts.length >= 2)
            searchPkmnByName(arg);
          else
            System.out.println("Require an argument for this command");  
        } 
        catch (Exception e) {
          System.out.println("Incorrect Pokemon name");
        }
			}
      else if (parts[0].equals("sAb")) {
        try {
          if (parts.length >= 2)
            searchAbility(arg);
          else
            System.out.println("Require an argument for this command");  
        } 
        catch (Exception e) {
          System.out.println("Incorrect ability name");
        }
			}
      else if (parts[0].equals("listType")) {
        numberOfType();
			}
      else if (parts[0].equals("foundAt")) {
        try {
          if (parts.length >= 2)
            foundAt(arg);
          else
            System.out.println("Require an argument for this command");  
        } 
        catch (Exception e) {
          System.out.println("Incorrect location name");
        }
			}
      else if (parts[0].equals("notFound")) {
        notFound();
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
    System.out.println("==================== COMMANDS FOR LISTING ====================");
    System.out.println("allP - List of all Pokemon");
    System.out.println("allA - List of all Pokemon and their abilities");
    System.out.println("allL - List of all locations");
    System.out.println("allEgg - List of all Egg groups");

    System.out.println("pAtk - List of all Physical Attacks");
    System.out.println("sAtk - List of all Special Attacks");

    System.out.println("==================== COMMANDS FOR SEARCHING A SPECIFIC THING ====================");
		System.out.println("sID <dexNum> - Search for a name");
    System.out.println("sName <pkmn name> - Search for a name");
    System.out.println("sAb <pkmn name> - List Pokemon with this ability");

    System.out.println("==================== COMMANDS FOR COOL QUERIES ====================");

    System.out.println("listType - Number of Pokemon for each type");
    System.out.println("foundAt - Pokemon that can be found at a location");
    System.out.println("notFound - Pokemon that cannot be caught normally");
		System.out.println("");

		System.out.println("q - Exit the program");

		System.out.println("---- end help ----- ");
	}

  // Lists of tables
  public static void listAllPokemon(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT dexNum, name FROM pokemon";
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

  public static void listAllMoves(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT moveName FROM moves";
      resultSet = statement.executeQuery(selectSql);

      // Print results from select statement
      while (resultSet.next()) {
          System.out.println("Move Name "+resultSet.getString("moveName"));
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void listAllAbilities(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT name, ability FROM pokemon INNER JOIN pokemonAbilities ON(pokemon.dexNum = pokemonAbilities.dexNum);";
      resultSet = statement.executeQuery(selectSql);

      // Print results from select statement
      while (resultSet.next()) {
          System.out.println("Pokemon: "+resultSet.getString("name")+ " Ability: " +resultSet.getString("ability"));
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void listAllLocations(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT locationName FROM location";
      resultSet = statement.executeQuery(selectSql);

      // Print results from select statement
      while (resultSet.next()) {
          System.out.println("Location Name: "+resultSet.getString("locationName"));
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void listAllEgg(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT DISTINCT eggGroup FROM pokemonEggGroups";
      resultSet = statement.executeQuery(selectSql);

      // Print results from select statement
      while (resultSet.next()) {
          System.out.println("Egg Group Name: "+resultSet.getString("eggGroup"));
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void pAtk(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT moveName, basePower, accuracy FROM move WHERE CONVERT(NVARCHAR(MAX), category) = 'physical';";
      resultSet = statement.executeQuery(selectSql);

      // Print results from select statement
      System.out.format("%20s %10s %10s", "Move", "Base Power", "Accuracy");
      System.out.println();
      while (resultSet.next()) {
        System.out.format("%20s %6s %10s", resultSet.getString("moveName"), resultSet.getInt("basePower"), resultSet.getInt("accuracy"));
        System.out.println();
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void sAtk(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT moveName, basePower, accuracy FROM move WHERE CONVERT(NVARCHAR(MAX), category) = 'special';";
      resultSet = statement.executeQuery(selectSql);

      System.out.format("%20s %10s %10s", "Move", "Base Power", "Accuracy");
      System.out.println();
      while (resultSet.next()) {
        System.out.format("%20s %6s %10s", resultSet.getString("moveName"), resultSet.getInt("basePower"), resultSet.getInt("accuracy"));
        System.out.println();
      }
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void searchPkmnByID(String dex){
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

  public static void searchPkmnByName(String pName){
    try (Connection connection = DriverManager.getConnection(connectionUrl);) {
        
      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT hp, atk, def, spa, spd, speed FROM pokemon WHERE CONVERT(NVARCHAR(MAX), name) LIKE ?;";
      PreparedStatement statement = connection.prepareStatement(selectSql);
      statement.setString(1, "%"+pName+"%");
      resultSet = statement.executeQuery();

      // Print results from select statement
      while (resultSet.next()) {
        System.out.println("Base Stats: HP: "+resultSet.getInt("hp") + " Atk: "+resultSet.getInt("atk") + " Def: " + resultSet.getInt("def") + " SpA: " 
        + resultSet.getInt("spa") + " SpD: " + resultSet.getInt("spd") + " Spd: "+ resultSet.getInt("speed"));
      }
      
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
  }

  public static void searchAbility(String ability){
    try (Connection connection = DriverManager.getConnection(connectionUrl);) {
        
      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT pokemon.dexNum, pokemon.name FROM pokemon INNER JOIN pokemonAbilities ON(pokemon.dexNum = pokemonAbilities.dexNum) WHERE CONVERT(NVARCHAR(MAX), ability) LIKE ?;";
      PreparedStatement statement = connection.prepareStatement(selectSql);
      statement.setString(1, "%"+ability+"%");
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

  public static void foundAt(String location){
    try (Connection connection = DriverManager.getConnection(connectionUrl);) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT pokemon.dexNum, pokemon.name from Pokemon INNER JOIN locatedAt ON(pokemon.dexNum = locatedAt.dexNum) WHERE CONVERT(NVARCHAR(MAX), locatedAt.locationName) LIKE ?;";
      PreparedStatement statement = connection.prepareStatement(selectSql);
      statement.setString(1, "%"+location+"%");
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

  public static void notFound(){
    try (Connection connection = DriverManager.getConnection(connectionUrl);
      Statement statement = connection.createStatement();) {

      // Create and execute a SELECT SQL statement.
      String selectSql = "SELECT pokemon.dexNum, name, locationName FROM pokemon INNER JOIN locatedAt ON( pokemon.dexNum = locatedAt.dexNum) WHERE locationName = 'Pal Park';";
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
}