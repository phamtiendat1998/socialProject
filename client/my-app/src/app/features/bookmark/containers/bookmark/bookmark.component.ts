import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-bookmark',
  templateUrl: './bookmark.component.html',
  styleUrls: ['./bookmark.component.scss']
})
export class BookmarkComponent implements OnInit {
  bookmarks = ['Bookmark 1', 'Bookmark 2'];
  constructor() { }

  ngOnInit(): void {
  }

}
