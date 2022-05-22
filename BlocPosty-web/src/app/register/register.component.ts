import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import { RegisterDto } from '../models/dto/register.dto';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  registerForm = new FormGroup({
    nick: new FormControl(''),
    email: new FormControl(''),
    perfil: new FormControl(''),
    fechaNacimiento: new FormControl(''),
    telefono: new FormControl(''),
    password: new FormControl(''),
    password2: new FormControl(''),
    avatar: new FormControl(''),
  })

  filePath = '';
  registerDto = new RegisterDto;
  

  constructor(private authService: AuthService) { }

  ngOnInit(): void {
  }

  doRegister() {
    console.log(this.registerDto);
    console.log(this.filePath)
    this.authService.register(this.registerDto,this.filePath).subscribe(rResult => {
      (response: any) => console.log(response);
      (error: any) => console.log(error);
      console.log(this.registerForm.value);
      localStorage.setItem;
    })
  }
}
