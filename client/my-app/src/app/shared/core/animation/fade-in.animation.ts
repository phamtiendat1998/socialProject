import { style, animate, transition } from '@angular/animations';

export function fadeIn() {
    return [
        transition(':enter', [
            style({ opacity: 0 }),
            animate('200ms ease-in', style({ opacity: 1 }))
        ])
    ];
}
