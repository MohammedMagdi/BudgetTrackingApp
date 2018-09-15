using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BudgetTracking.DAL;
using BudgetTraking.API.DTO;
using BudgetTraking.API.Utilities;

namespace BudgetTraking.API.Controllers
{
    [RoutePrefix("api/Budget")]
    public class BudgetController : ApiBaseController
    {
        #region add new
        public IHttpActionResult Post(BudgetValue model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                db.BudgetValues.Add(model);
                db.SaveChanges();
                return Ok();
            }
            catch (Exception e)
            {

                return BadRequest();
            }

        }
        #endregion

        #region GetBudgetType
        [HttpGet]
        [Route("GetBudgetType")]
        public IHttpActionResult GetBudgetType()
        {
            try
            {
                List<BudgetType> budgetTypesList = db.BudgetTypes.ToList();

                if (budgetTypesList.Count > 0)
                {
                    List<BudgetTypeDTO> result = ConfigMapper.MapList<BudgetType, BudgetTypeDTO>(budgetTypesList);

                    return Ok(result);
                }
                else
                {
                    return NotFound();
                }

            }
            catch (Exception e)
            {

                return BadRequest();
            }

        }
        #endregion

        #region GetBudgetType
        [HttpGet]
        [Route("GetRecurringCostType")]
        public IHttpActionResult GetRecurringCostType()
        {
            try
            {
                List<RecurringType> recurringCostTypeList = db.RecurringTypes.ToList();

                if (recurringCostTypeList.Count > 0)
                {
                    List<RecurringCostTypeDTO> result = ConfigMapper.MapList<RecurringType, RecurringCostTypeDTO>(recurringCostTypeList);

                    return Ok(result);
                }
                else
                {
                    return NotFound();
                }

            }
            catch (Exception e)
            {

                return BadRequest();
            }

        }
        #endregion

        #region GetBudget
        [HttpGet]
        [Route("GetBudget")]
        public IHttpActionResult GetBudget(int model)
        {

            try
            {
                int NetFlowYear = DateTime.Now.Year;
                if (model > 0)
                {
                    NetFlowYear = model;
                }

                List<int> IncomeSumByMonthList = new List<int>();
                List<int> CostSumByMonthList = new List<int>();

                List<int> EmptyMonths = new List<int>();
                for (int i = 1; i <= 12; i++)
                {
                    EmptyMonths.Add(i);
                }

                List<BudgetValue> income = (from value in db.BudgetValues
                                            from budgetType in db.BudgetTypes

                                            where budgetType.Type == "Income"
                                            where value.BudgetTypeID == budgetType.ID
                                            where value.Date.Year == NetFlowYear

                                            select value).OrderBy(x => x.Date).ToList();

                List<BudgetValue> costs = (from value in db.BudgetValues
                                           from budgetType in db.BudgetTypes

                                           where budgetType.Type != "Income"
                                           where value.BudgetTypeID == budgetType.ID
                                           where value.Date.Year == NetFlowYear

                                           select value).OrderBy(x => x.Date).ToList();

                int MonthlyID = db.RecurringTypes.Where(x => x.Value == "Monthly").FirstOrDefault().ID;
                Dictionary<int, int> recurringCostByMonth = new Dictionary<int, int>();

                foreach (var month in EmptyMonths)
                {
                    int incomeSum = income.Where(value => value.Date.Month == month).ToList().Sum(x=>x.Amount);
                    IncomeSumByMonthList.Add(incomeSum);

                    int costSum = costs.Where(value => value.Date.Month == month).ToList().Sum(x => x.Amount);

                    List<int> amount = costs.Where(value => value.Date.Month == month && value.RecurringTypeID == MonthlyID).Select(x=>x.Amount).ToList();
                    if (amount.Count > 0)
                    {
                        recurringCostByMonth.Add(month, amount.Sum());
                    }

                    foreach (KeyValuePair<int, int> entry in recurringCostByMonth)
                    {
                        if (entry.Key <= month)
                        {
                            costSum += entry.Value;
                        }
                    }
                    
                    CostSumByMonthList.Add(costSum);
                }

                var response = new { IncomeSumByMonthList, CostSumByMonthList };
                return Ok(response);
            }
            catch (Exception e)
            {

                return BadRequest();
            }

        }
        
        #endregion
    }
}
