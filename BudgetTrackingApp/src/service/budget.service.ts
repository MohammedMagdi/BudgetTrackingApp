import { Injectable } from '@angular/core';
import {
  HttpClient,
  HttpParams,
  HttpHeaders,
  HttpErrorResponse,
  HttpClientModule
} from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { environment } from '../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class BudgetService {
  private URL: string = environment.BaseURL;
  
  private APIUrl: string = '/api/Budget';
  private baseUrl: string = this.URL + this.APIUrl;

  constructor(private _httpClient: HttpClient) {
  }

  create(model): any{
    return this._httpClient.post(this.baseUrl, model);
  }

  GetBudget(): any {
    const url = `${this.baseUrl}/GetBudget`;
    return this._httpClient.get<any>(url);
  }

  GetBudgetType(): Observable<any> {
    const url = `${this.baseUrl}/GetBudgetType`;
    return this._httpClient.get<any>(url);
  }

  GetRecurringCostType(): Observable<any> {
    const url = `${this.baseUrl}/GetRecurringCostType`;
    return this._httpClient.get<any>(url);
  }

}
