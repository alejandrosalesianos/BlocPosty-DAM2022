import { Component, OnInit, ViewChild } from '@angular/core';
import { Bloc } from '../models/interface/bloc.interface';
import { BlocService } from '../services/post.service';
import {MatTableDataSource} from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';


@Component({
  selector: 'app-bloc-list',
  templateUrl: './bloc-list.component.html',
  styleUrls: ['./bloc-list.component.css']
})
export class BlocListComponent implements OnInit {

  blocs: Bloc[] = [];
  displayedColumns: string[] = ['userImg', 'usuario','id', 'titulo', 'acciones'];
  dataSource: MatTableDataSource<Bloc>;

  constructor(private blocService: BlocService) { 

    this.dataSource = new MatTableDataSource;
  }

  ngOnInit(): void {
    this.blocService.getAllPosts().subscribe(results =>{
      this.blocs = results.content;
      console.log(this.blocs)
      this.dataSource = new MatTableDataSource(results.content);
    })
  }
  
  getAvatarImage(bloc: Bloc) {
    return bloc.userImg;
  }
  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.dataSource.filter = filterValue.trim().toLowerCase();

    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }
  deleteBloc(bloc:Bloc ){
    this.blocService.deletePost(bloc.id).subscribe(results => {
      console.log('Bloc Borrado')
      window.location.reload();
    })
  }

}
