# weatherapp

Aplikasi untuk fetch API cuaca.

## Struktur Folder Project

- **config**  
  Tempat menyimpan file konfigurasi seperti routes, tema aplikasi, atau constant yang dipakai di banyak tempat. Mudah kalau mau ganti settingan, tinggal ke sini.

- **core**  
  Bagian inti dari project. Berisi response wrapper dan utils yang dipakai di seluruh aplikasi.

- **models**  
  Semua class data atau objek. Hanya merepresentasikan data, tanpa logic yang kompleks.

- **services**  
  Bagian yang berinteraksi dengan sumber eksternal, seperti API.

- **usecases**  
  Berisi Business Logic murni, misalnya “Get Weather” atau “Get Forecast”. Tidak peduli tentang UI, fokus pada aturan bisnis.

- **viewmodels**  
  Penghubung antara UI dan usecases. Menangani state, event dari user, dan update UI.

- **views**  
  Semua tampilan UI, seperti page, screen, atau widget kompleks (`login_screen`, `weather_screen`, dll).

- **main.dart**  
  Titik masuk aplikasi. Biasanya mendefinisikan `runApp`, `MaterialApp`, routing, dan theme.
