import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { LoginDto } from '../models/dto/login.dto';
import { RegisterDto } from '../models/dto/register.dto';
import { LoginResponse } from '../models/interface/login.interface';
import { RegisterResponse } from '../models/interface/register.interface';

const DEFAULT_HEADERS = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token'
  })
};

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  authBaseUrl = `${environment.apiBaseUrl}/auth/`

  constructor(private http: HttpClient) { }

  register(registerDto: RegisterDto,filePath:string):Observable<Object> {
    let requestUrl = `${this.authBaseUrl}register/`
    var fd = new FormData();
    var filePath2 = filePath.split('\\')[2];
    console.log(filePath2)
    fd.append('file', filePath2);
    fd.append('nick',registerDto.nick);
    fd.append('email',registerDto.email);
    fd.append('fechaNacimiento',registerDto.fechaNacimiento);
    fd.append('telefono',registerDto.telefono);
    fd.append('perfil',registerDto.perfil);
    fd.append('password',registerDto.password);
    fd.append('password2',registerDto.password2);
    console.log(fd)
    return this.http.post(requestUrl,fd,DEFAULT_HEADERS)
    //return this.http.post<RegisterResponse>(requestUrl,registerDto,DEFAULT_HEADERS);
  }
  
  login(loginDto: LoginDto):Observable<LoginResponse>{
    let requestUrl = `${this.authBaseUrl}login`;
    return this.http.post<LoginResponse>(requestUrl,loginDto,DEFAULT_HEADERS);
  }

}
