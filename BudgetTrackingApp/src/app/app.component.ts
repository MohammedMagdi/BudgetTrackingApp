import { Component } from '@angular/core';
import { Message } from 'primeng/api';
import { MessageService } from 'primeng/components/common/messageservice';
import { BudgetService } from '../service/budget.service';
import { BudgetType } from '../models/BudgetType';
import { BudgetValue } from '../models/BudgetValue';
import { RecurringCostType } from '../models/RecurringCostType';
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'app';
  msgs: Message[] = [];

  budgetTypeList: BudgetType[];
  selectedbudgetType = [];

  recurringCostList: RecurringCostType[];
  selectedrecurringCost = [];

  busy: any;

  BudgetModel: BudgetValue = { ID: 0, BudgetTypeID: null, Amount: null, Date: null, RecurringTypeID: null, Description: null };
  IsRecurringCost: boolean = false;

  data: any;
  options: any;
  dateValue: any;

  NetFlowYear: any = { ID: 2018, Year: 2018 };
  YearsList = [];
  constructor(
    private messageService: MessageService,
    private _budgetService: BudgetService) { }

  ngOnInit() {
    // this.msgs = [];
    // this.msgs.push({ severity: 'success', summary: 'Success Message', detail: 'welcome' });
    for (let i = 2000; i <= 2030; i++) {
      this.YearsList.push({ ID: i, Year: i });
    }
    this.GetBudgetType();


    this.options = {
      title: {
        display: true,
        text: 'My Title',
        fontSize: 16
      },
      legend: {
        position: 'bottom'
      }
    };
  }

  GetBudgetType(): any {
    this.busy = this._budgetService.GetBudgetType().subscribe(res => {
      this.budgetTypeList = [];
      if (res) {
        this.budgetTypeList = res;
        this.GetRecurringCostType();
      }
    },
      (err) => {
        console.log('error: ', err);
      });
  }

  GetRecurringCostType(): any {
    this.busy = this._budgetService.GetRecurringCostType().subscribe(res => {
      this.recurringCostList = [];
      if (res) {
        this.recurringCostList = res;
      }
    },
      (err) => {
        console.log('error: ', err);
      });
  }


  changebudgetType(event, budgetType: BudgetType) {
    if (budgetType !== null || budgetType !== undefined) {
      this.BudgetModel.BudgetTypeID = budgetType.ID;

      if (budgetType.Type === 'Recurring Cost') {
        this.IsRecurringCost = true;
      }
      else {
        this.IsRecurringCost = false;
      }
    }
  }

  changerecurringCost(event, recurringCost: RecurringCostType) {
    this.BudgetModel.RecurringTypeID = recurringCost.ID;
  }

  getStartDate($event) {
    this.BudgetModel.Date = $event;
  }


  save() {
    if (this.ValidateData()) {
      this.busy = this._budgetService.create(this.BudgetModel).subscribe(res => {
        debugger
        this.BudgetModel = { ID: 0, BudgetTypeID: this.BudgetModel.BudgetTypeID, Amount: null, Date: null, RecurringTypeID: this.BudgetModel.RecurringTypeID, Description: null };
        this.msgs = [];
        this.msgs = [{
          severity: 'success', summary: 'Success Message',
          detail: `added successfuly`
        }];
      },
        (err) => {
          console.log('error: ', err);
        });
    }

  }

  ValidateData(): any {
    let messages = [];
    if (this.BudgetModel.Amount < 1) {
      messages.push({ severity: 'error', summary: 'Error Message', detail: 'Enter valid Amount' });
    }
    if (this.BudgetModel.Date === null) {
      messages.push({ severity: 'error', summary: 'Error Message', detail: 'Enter valid Date' });
    }
    if (this.BudgetModel.BudgetTypeID < 1) {
      messages.push({ severity: 'error', summary: 'Error Message', detail: 'Enter valid Budget Type' });
    }
    if (this.BudgetModel.RecurringTypeID > 1) {
      if (this.selectedrecurringCost.length === 0) {
        messages.push({ severity: 'error', summary: 'Error Message', detail: 'Enter valid recurring Cost' });
      }
    }

    if (messages.length === 0) {
      return true;
    }
    else {
      this.msgs = [];
      this.msgs = messages;
      return false;
    }
  }
  update(event: Event) {
    this._budgetService.GetBudget(this.NetFlowYear.Year).subscribe(res => {
      console.log('res: ', res);

      this.data = {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        datasets: [
          {
            label: 'Income',
            backgroundColor: '#42A5F5',
            borderColor: '#1E88E5',
            data: res.IncomeSumByMonthList
          },
          {
            label: 'Cost',
            backgroundColor: '#9CCC65',
            borderColor: '#7CB342',
            data: res.CostSumByMonthList
          }
        ]
      }

    },
      (err) => {
        console.log('error: ', err);
      });


  }


}
