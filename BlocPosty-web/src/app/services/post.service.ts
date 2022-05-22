import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { BlocResponse } from '../models/interface/bloc.interface';

let token = localStorage.getItem('token');

const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}` 
  })
};
@Injectable({
  providedIn: 'root'
})
export class BlocService {

  constructor(private http:HttpClient) { }

  getAllPosts():Observable<BlocResponse> {
    return this.http.get<BlocResponse>(`${environment.apiBaseUrl}/bloc/`, DEFAULT_HEADERS)
  }
  deletePost(id:Number) {
    console.log(token)
    return this.http.delete(`${environment.apiBaseUrl}/bloc/${id}`,DEFAULT_HEADERS)
  }
}
