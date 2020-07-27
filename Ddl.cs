using ProcessNorthwindDB_Tyrone;
using System;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace Veneracion_Database
{
    class Ddl
    {
        public SqlConnection CreateDatabase(string path, string dbName,string dataSource,string integratedSecurity)
        {
            try
            {
                string str;
                SqlConnection sqlConnection = new SqlConnection($"Data Source ={dataSource}; Integrated Security={integratedSecurity}");
                
                    path = path.Replace("\\", "\\\\");
                    str = $"CREATE DATABASE {dbName} ON PRIMARY " +
                        $"(NAME ={dbName}_Data, " +
                        $"FILENAME = '{path}.mdf', " +
                        "SIZE = 2MB, MAXSIZE = 10MB, FILEGROWTH = 10%) " +
                        $"LOG ON (NAME = {dbName}_Log, " +
                        $"FILENAME = '{path}.ldf', " +
                        "SIZE = 1MB, " +
                        "MAXSIZE = 5MB, " +
                        "FILEGROWTH = 10%)";
                    SqlCommand myCommand = new SqlCommand(str, sqlConnection);
                try
                {
                    sqlConnection.Open();
                    myCommand.ExecuteNonQuery();
                    //Creates the Table
                    CreateTable(sqlConnection, path);
                    sqlConnection.Close();
                    return sqlConnection;
                }
                catch (SqlException ex)
                {
                    Console.WriteLine($"Execute Creating Database Error: {ex}");
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine($"Creating Database Error: {ex}");
            }

            return null;
        }
        public void CreateTable(SqlConnection sqlConnection,string dbName)
        {
            Dml dml = new Dml();
            dbName = Regex.Replace(dbName, "\\S+\\\\", string.Empty);
            try
            { 
                using (SqlCommand cmd = new SqlCommand($"USE {dbName}\n" 
                    + Resource.VeneracionDatabase.ToString(), sqlConnection))
                {
                    cmd.ExecuteNonQuery();
                }
                //Inserts values in the Table
                dml.InsertRows(sqlConnection);
            }
            catch(IOException ex)
            {
                Console.WriteLine($"Missing File Error: {ex}");
            }
            catch(SqlException ex)
            {
                Console.WriteLine($"Creating Table Error: {ex}");
            }
        }
    }
}
