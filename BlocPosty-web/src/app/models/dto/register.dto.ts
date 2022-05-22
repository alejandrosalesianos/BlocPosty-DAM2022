export class RegisterDto {
    nick:            string;
    email:           string;
    fechaNacimiento: string;
    telefono:        string;
    perfil:          string;
    password:        string;
    password2:       string;

    constructor() {
        this.nick = ''
        this.email = '';
        this.fechaNacimiento = '';
        this.telefono = '';
        this.perfil = '';
        this.password = '';
        this.password2 = '';
    }
}
