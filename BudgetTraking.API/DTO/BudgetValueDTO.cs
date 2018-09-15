using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BudgetTraking.API.DTO
{
    public class BudgetValueDTO
    {
        public int ID { get; set; }
        public int BudgetTypeID { get; set; }
        public int Amount { get; set; }
        public System.DateTime Date { get; set; }
        public Nullable<int> RecurringCostTypeID { get; set; }
    }
}