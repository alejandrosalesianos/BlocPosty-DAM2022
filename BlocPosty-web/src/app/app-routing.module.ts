import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { BlocListComponent } from './bloc-list/bloc-list.component';
import { RegisterComponent } from './register/register.component';

const routes: Routes = [
  {path: "",pathMatch: "full",redirectTo: '/login'},
  {path: 'register',component: RegisterComponent},
  {path: 'login',component:LoginComponent},
  {path: 'blocs',component:BlocListComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
