using BudgetTracking.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BudgetTraking.API.Controllers
{
    public class ApiBaseController : ApiController
    {
        public BudgetTrackingEntities db = new BudgetTrackingEntities(); 
    }
}
