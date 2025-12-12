program SistemLoginSederhana;
uses crt;

type
  PData = ^TData;
  TData = record
    nama : string;
    sandi : string;
    next : PData;
  end;

var
  awal, baru, bantu : PData;
  menu : integer;
  inputNama, inputSandi : string;
  berhasil : boolean;
  salah : integer;

{ ========== CEK LOGIN ========== }
function cekLogin(nama, sandi : string) : boolean;
begin
  bantu := awal;
  cekLogin := false;

  while bantu <> nil do
  begin
    if (bantu^.nama = nama) and (bantu^.sandi = sandi) then
    begin
      cekLogin := true;
      exit;
    end;
    bantu := bantu^.next;
  end;
end;

{ ========== PROSES LOGIN ========== }
procedure login;
var
  i : integer;
begin
  salah := 0;

  repeat
    clrscr;
    write('Masukkan Username: ');
    readln(inputNama);
    write('Masukkan Password: ');
    readln(inputSandi);

    berhasil := cekLogin(inputNama, inputSandi);

    if berhasil then
    begin
      writeln('Login berhasil!');
      writeln('Selamat datang, ', inputNama);
      readln;
      exit;
    end
    else
    begin
      salah := salah + 1;
      writeln('Login gagal! Percobaan ke-', salah);
      readln;
    end;

    { ========== COOLDOWN 30 DETIK ========== }
    if salah = 3 then
    begin
      clrscr;
      writeln('Anda gagal 3 kali!');
      writeln('Tunggu 30 detik...');

      for i := 30 downto 1 do
      begin
        gotoxy(1,5);
        write('Countdown: ', i, ' detik');
        delay(1000);
      end;

      salah := 0;
    end;

  until false;
end;

{ ========== DAFTAR AKUN ========== }
procedure daftar;
begin
  clrscr;
  new(baru);

  write('Buat Username: ');
  readln(baru^.nama);
  write('Buat Password: ');
  readln(baru^.sandi);

  baru^.next := nil;

  if awal = nil then
    awal := baru
  else
  begin
    bantu := awal;
    while bantu^.next <> nil do
      bantu := bantu^.next;
    bantu^.next := baru;
  end;

  writeln;
  writeln('Akun berhasil dibuat!');
  writeln('Tekan ENTER untuk login...');
  readln;
  login;
end;

{ ========== MENU UTAMA ========== }
procedure menuUtama;
begin
  repeat
    clrscr;
    writeln('=== SISTEM LOGIN SEDERHANA ===');
    writeln('1. Login');
    writeln('2. Daftar');
    writeln('3. Keluar');
    write('Pilih menu: ');
    readln(menu);

    case menu of
      1: login;
      2: daftar;
      3: writeln('Terima kasih!');
    else
      writeln('Menu tidak tersedia!');
    end;

    writeln;
    writeln('Tekan ENTER...');
    readln;
  until menu = 3;
end;

{ ========== PROGRAM UTAMA ========== }
begin
  awal := nil;
  menuUtama;
end.
