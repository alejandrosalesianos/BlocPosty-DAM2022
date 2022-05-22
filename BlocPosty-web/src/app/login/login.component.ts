import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { LoginDto } from '../models/dto/login.dto';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginDto = new LoginDto();

  registerForm = new FormGroup({
    email: new FormControl(''),
    password: new FormControl(''),
  })

  constructor(private loginService: AuthService,private route:Router) { }

  ngOnInit(): void {
  }

  navigate(){
    this.route.navigate(['/blocs']);
  }

  doLogin() {
    this.loginService.login(this.loginDto).subscribe(result => {
      localStorage.setItem('token',result.token);
      this.navigate();
    })
  }

}
