import { Component, Input, OnInit } from '@angular/core';
import { Bloc,  } from '../models/interface/bloc.interface';
import { BlocService } from '../services/post.service';

@Component({
  selector: 'app-bloc-item',
  templateUrl: './bloc-item.component.html',
  styleUrls: ['./bloc-item.component.css']
})
export class BlocItemComponent implements OnInit {

  @Input() blocInput!: Bloc;

  constructor(private blocService: BlocService) { }

  ngOnInit(): void {
  }

  getPostImage(bloc: Bloc){
    return bloc.multimedia;
  }
  getAvatarImage(bloc: Bloc) {
    return bloc.userImg;
  }
  delete(id:Number){
    this.blocService.deletePost(id).subscribe(() => {
      location.reload();
    });
  }

}
