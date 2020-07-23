import { Component, OnInit, Inject } from '@angular/core';
// Rxjs
import { mergeMap } from 'rxjs/operators';
// Mat
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { snackBarConfig } from 'src/app/shared/core/config/snackbar-config';
import { MatSnackBar } from '@angular/material/snack-bar';
// Serivce
import { PostService } from '../../services/post.service';
// Store
import { Store, select } from '@ngrx/store';
import { AppState } from 'src/app/core/state';
import { selectUserId } from 'src/app/core/state/user-auth/user-auth.selectors';
import { DeleteReplyComment } from '../../state/post.actions';

@Component({
  selector: 'app-dialog-delete-reply-comment-post',
  templateUrl: './dialog-delete-reply-comment-post.component.html',
  styleUrls: ['./dialog-delete-reply-comment-post.component.scss']
})
export class DialogDeleteReplyCommentPostComponent implements OnInit {
  loading = false;
  textMainBtn = 'Xóa';
  constructor(
    public dialogRef: MatDialogRef<DialogDeleteReplyCommentPostComponent>,
    @Inject(MAT_DIALOG_DATA) public replyCommentId: string,
    private _snackBar: MatSnackBar,
    private postSerivce: PostService,
    private store$: Store<AppState>
  ) { }

  ngOnInit(): void {
  }
  /*
    @ Close dialog
    */
  onNoClick(): void {
    this.dialogRef.close();
  }
  /*
  @ Delete comment
  */
  onDeleteReplyComment() {
    this.loading = true;
    this.store$.pipe(select(selectUserId))
      .pipe(
        mergeMap(userId => this.postSerivce.deleteReplyComment(userId, this.replyCommentId))
      )
      .subscribe(res => {
        this.loading = false;
        if (res) {
          this.store$.dispatch(new DeleteReplyComment({ replyCommentId: this.replyCommentId }));
          this.openSnackBar('Đã xóa bình luận');
          this.onNoClick();
        } else {
          this.textMainBtn = 'Thử lại';
        }
      })
  }
  /*
  @ Open snackbar
  */
  openSnackBar(message: string, action: string = null) {
    this._snackBar.open(message, action, snackBarConfig);
  }
}
