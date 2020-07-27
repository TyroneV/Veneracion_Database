using ProcessNorthwindDB_Tyrone;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace Veneracion_Database
{
    class Program
    {
        // Gets connection string data from the config
        private static string dataSource =
            ConfigurationManager.AppSettings.Get("DataSource");
        private static string dataDirectory =
            ConfigurationManager.AppSettings.Get("DataDirectory");
        private static string integratedSecurity =
            ConfigurationManager.AppSettings.Get("IntegratedSecurity");
        static void Main(string[] args)
        {
            StartSql();
        }

        private static void StartSql()
        {
            string dbName = Regex.Replace(dataDirectory, "\\S+\\\\", string.Empty);
            Ddl ddl = new Ddl();
            Dml dml = new Dml();
            using (SqlConnection sqlConnection 
                = !File.Exists(dataDirectory + ".mdf") 
                ? ddl.CreateDatabase(dataDirectory, dbName, dataSource,integratedSecurity)
                : new SqlConnection($"Data Source={dataSource};" +
                $"AttachDbFilename={dataDirectory + ".mdf"};" +
                $"Integrated Security={integratedSecurity}"))
            {
                //Opens the sql connection
                OpenConnection(sqlConnection);
                //Reads and prints the table's date
                dml.SelectRows(sqlConnection,dataDirectory,dbName,Resource.SelectEmployees.ToString(),false);
                Console.WriteLine("\nTable of Grand Total\n");
                dml.SelectRows(sqlConnection, dataDirectory, dbName, Resource.GrandTotal.ToString(), true);
                Console.WriteLine("\nSorts by Job Title and Monthly Salary\n");
                dml.SelectRows(sqlConnection, dataDirectory, dbName, Resource.SortJobTitleMonthlySalary.ToString(),false);
                Console.WriteLine("\nSorts by Job Title and Total Compensation\n");
                dml.SelectRows(sqlConnection, dataDirectory, dbName, Resource.SortJobTitleTotalCompensation.ToString(),false);
                //Closes the connection
                sqlConnection.Close();
            }
            Console.WriteLine("\nPress <ENTER> to quit...");
            Console.ReadKey();
        }
        private static void OpenConnection(SqlConnection sqlConnection)
        {
            try
            {
                // Open Connection
                sqlConnection.Open();
                Console.WriteLine("Connection Opened");

            }
            catch (SqlException ex)
            {
                // Display error
                Console.WriteLine("Error: " + ex.ToString());
            }
        }
    }
}
