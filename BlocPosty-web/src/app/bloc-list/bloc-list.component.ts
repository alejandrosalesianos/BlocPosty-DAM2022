import { Component, OnInit } from '@angular/core';
import { Bloc } from '../models/interface/bloc.interface';
import { BlocService } from '../services/post.service';

@Component({
  selector: 'app-bloc-list',
  templateUrl: './bloc-list.component.html',
  styleUrls: ['./bloc-list.component.css']
})
export class BlocListComponent implements OnInit {

  blocs: Bloc[] = [];

  constructor(private blocService: BlocService) { }

  ngOnInit(): void {
    this.blocService.getAllPosts().subscribe(results =>{
      this.blocs = results.content;
      console.log(this.blocs)
    })
  }

}
