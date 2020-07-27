using System;
using System.Data.SqlClient;
using System.IO;
using Veneracion_Database;

namespace ProcessNorthwindDB_Tyrone
{
    class Dml
    {

        public void SelectRows(SqlConnection sqlConnection,string dbDirectory, string dbName,string sql,bool grandTotal)
        {
            try
            {
                using (SqlCommand cmd = !File.Exists(dbDirectory + ".mdf") ? 
                    new SqlCommand($"USE {dbName}\n" + sql, sqlConnection)
                    : new SqlCommand(sql, sqlConnection))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (grandTotal)
                        TotalPrinter(dr);
                    else
                        Printer(dr);
                }
            }
            catch (SqlException ex)
            {
                // Display error
                Console.WriteLine("Read Error: " +
                ex.ToString());
            }
        }
        public void TotalPrinter(SqlDataReader dr)
        {
            string strMonthlySalary = "Monthly Salary";
            string strSalesAmt = "Sales Amt";
            string strCarAllowance = "Car Allowance";
            string strBonusAmount = "Bonus Amount";
            string strTotalCompensation = "Total Compensation";
            Console.WriteLine("{0} | {1} | {2} | {3} | {4} ",
                strMonthlySalary.PadRight(15), strSalesAmt.PadRight(15),strCarAllowance.PadRight(15),
                strBonusAmount.PadRight(15), strTotalCompensation);
            Console.WriteLine("==========================================================================================");
            while (dr.Read())
            {
                //reading from the datareader
                Console.WriteLine("{0} | {1} | {2} | {3} | {4} ",
                dr["MonthlySalary"].ToString().PadRight(15),
                dr["SalesAmt"].ToString().PadRight(15),
                dr["CarAllowance"].ToString().PadRight(15),
                dr["BonusAmount"].ToString().PadRight(15),
                dr["TotalCompensation"].ToString());
            }
            Console.WriteLine("==========================================================================================");
        }
        public void Printer(SqlDataReader dr)
        {
            string strEmployeeID = "ID";
            string strFirstName = "Last Name";
            string strLastName = "First Name";
            string strJobTitle = "Job Title";
            string strDOB = "DOB";
            string strHireDate = "Hire Date";
            string strMonthlySalary = "Monthly Salary";
            string strSalesAmt = "Sales Amt";
            string strBonusRate = "Bonus Rate";
            string strCarAllowance = "Car Allowance";
            string strBonusAmount = "Bonus Amount";
            string strTotalCompensation = "Total Compensation";
            Console.WriteLine("{0} | {1} | {2} | {3} | {4} | {5} | {6} | {7} | {8} | {9} | {10} | {11} ",
                strEmployeeID.PadRight(10), strFirstName.PadRight(10), strLastName.PadRight(10),
                strJobTitle.PadRight(25), strDOB.PadRight(10), strHireDate.PadRight(10),
                strMonthlySalary.PadRight(15), strSalesAmt.PadRight(15),
                strBonusRate.PadRight(10), strCarAllowance.PadRight(15),
                strBonusAmount.PadRight(15), strTotalCompensation);
            Console.WriteLine("====================================================================================================================================================================================================");
            while (dr.Read())
            {
                //reading from the datareader
                Console.WriteLine("{0} | {1} | {2} | {3} | {4} | {5} | {6} | {7} | {8} | {9} | {10} | {11} ",
                dr["EmployeeID"].ToString().PadRight(10),
                dr["LastName"].ToString().PadRight(10),
                dr["FirstName"].ToString().PadRight(10),
                dr["JobTitle"].ToString().PadRight(25),
                dr["DOB"].ToString().PadRight(10),
                dr["HireDate"].ToString().PadRight(10),
                dr["MonthlySalary"].ToString().PadRight(15),
                dr["SalesAmt"].ToString().PadRight(15),
                dr["BonusRate"].ToString().PadRight(10),
                dr["CarAllowance"].ToString().PadRight(15),
                dr["BonusAmount"].ToString().PadRight(15),
                dr["TotalCompensation"].ToString());
            }
            Console.WriteLine("====================================================================================================================================================================================================");
        }

        public void InsertRows(SqlConnection sqlConnection)
        {
            //Insert Rows processing
            //Create Command object
            using (SqlCommand cmd = new SqlCommand(Resource.InsertValues,sqlConnection))
            {
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    // Display error
                    Console.WriteLine("Insert Error: " + ex.ToString());
                }
            }
        }
   
    }
}