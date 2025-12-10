program SistemLogin;
uses crt;

type
  PUser = ^TUser;
  TUser = record
    username : string;
    password : string;
    next : PUser;
  end;

var
  head, newNode, temp : PUser;
  pilihan : integer;
  inputUser, inputPass : string;
  loginBerhasil : boolean;
  salahLogin : integer;


function cekLogin(u, p : string) : boolean;
begin
  cekLogin := false;
  temp := head;

  while temp <> nil do
  begin
    if (temp^.username = u) and (temp^.password = p) then
    begin
      cekLogin := true;
      exit;
    end;
    temp := temp^.next;
  end;
end;


procedure login;
var
  i : integer;
begin
  salahLogin := 0;

  repeat
    clrscr;
    write('Username: ');
    readln(inputUser);
    write('Password: ');
    readln(inputPass);

    loginBerhasil := cekLogin(inputUser, inputPass);

    if loginBerhasil = true then
    begin
      writeln('Login berhasil! Selamat datang ', inputUser);
      readln;
      exit;
    end
    else
    begin
      salahLogin := salahLogin + 1;
      writeln('Username atau password salah');
      writeln('Percobaan ke-', salahLogin);
      readln;
    end;

  
    if salahLogin = 3 then
    begin
      clrscr;
      writeln('Anda salah 3 kali!');
      writeln('Silakan tunggu 30 detik...');

      for i := 30 downto 1 do
      begin
        gotoxy(1,5);
        write('Countdown: ', i, ' detik   ');
        delay(1000);
      end;

      salahLogin := 0;
    end;

  until false;
end;


procedure daftarAkun;
begin
  clrscr;
  new(newNode);
  write('Buat Username: ');
  readln(newNode^.username);
  write('Buat Password: ');
  readln(newNode^.password);
  newNode^.next := nil;

  if head = nil then
    head := newNode
  else
  begin
    temp := head;
    while temp^.next <> nil do
      temp := temp^.next;
    temp^.next := newNode;
  end;

  writeln;
  writeln('Akun berhasil dibuat!');
  writeln('Tekan ENTER untuk login...');
  readln;
  login;
end;


procedure menuUtama;
begin
  repeat
    clrscr;
    writeln('=== SISTEM LOGIN ===');
    writeln('1. Sudah punya akun (Login)');
    writeln('2. Buat akun baru (Register)');
    writeln('3. Keluar');
    write('Pilih menu: ');
    readln(pilihan);

    case pilihan of
      1: login;
      2: daftarAkun;
      3: writeln('Terima kasih telah menggunakan aplikasi.');
    else
      writeln('Menu tidak tersedia!');
    end;

    writeln;
    writeln('Tekan ENTER untuk melanjutkan...');
    readln;
  until pilihan = 3;
end;


begin
  clrscr;
  head := nil;
  menuUtama;
end.