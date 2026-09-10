# Nama     : Ilham Zamzami
# Kelas    : DE 15

# Jawaban Reflection
### Menurut Anda, apa manfaat membangun model data secara bertahap melalui staging → intermediate → mart dalam project dbt?

Permodelan secara bertahap mampu memberikan manfaat dalam melakukan organisasi data. 

Kita bisa mengetahui bahwa data dalam schema staging merupakan data yang bersifat mentah (raw data), artinya jika kita ingin melihat data asli yang belum dilakukan transforming dan cleaning maka staging area merupakan lokasinya

Begitu juga dengan tahap intermediate. Ditahap ini kita meakukan transforming dan cleaning data. Artinya disinilah lokasi data yang sudah bisa digunakan secara umum untuk proses selanjutnya, baik berupa bisnis ataupun data modeling untuk machine lerning

Kemudian mart area. Merupakan lokasi menyimpan data yang sesuai dengan kebutuhan dari masing masing divisi atau kelompok tertentu. 

### Apa tantangan yang Anda alami ketika membuat model dbt, dan bagaimana Anda mengatasinya selama proses pengerjaan?

Tantangannya ketika saya melakukan tranforming dan cleaning data. Tahap ini merupakan tahap yang paling lama dilakukan. Dikarenakan pada tahap ini saya harus memahami struktur data yang ada, bagaimana relasi antar data. Ditahap ini juga proses cleaning menjadi sangat penting, saya harus bisa membuat data memiliki konsistensi, akurasi dan kelengkapan yang baik, supaya output untuk proses bisnisnya bisa sesuai

# Assignment DBT

Project ini merupakan implementasi Modern Data Stack menggunakan **dbt (data build tool)** untuk membangun data pipeline dan data warehouse dari database sampel **Pagila** (PostgreSQL).

---
# Screnshoot dbt run dan dbt test
## dbt run
![dbt run](screenshoot\dbt-run.png)
![dbt run2](screenshoot\dbt-run2.png)

## dbt test
![dbt test](screenshoot\dbt-test.png)
![dbt test2](screenshoot\dbt-test2.png)
---

## Project Architecture & Data Models

Pipeline data di dalam project ini dibagi menjadi beberapa layer:

1. **Staging (`models/staging/`)**
   * Transformasi dasar dari source data (casting tipe data, pembersihan nama kolom).
   * Contoh: `stg_customers`, `stg_films`, `stg_payments`, `stg_rentals`.
2. **Intermediate / Dimensions & Facts (`models/`)**
   * Pemodelan data bisnis (Dimensional Modeling).
   * `dim_customers` - Profil lengkap customer beserta agregasi transaksi.
   * `dim_films` - Katalog film beserta performa sewa dan inventaris.
   * `fact_payments` - Transaksi pembayaran detail per sewa.
3. **Data Marts (`models/marts/`)**
   * Datamart siap pakai untuk kebutuhan analytics & reporting.
   * `mart_daily_revenue` - Performa pendapatan harian.
   * `mart_customer_performance` - Ringkasan performa & LTV customer.
   * `mart_film_performance` - Performa pendapatan dan popularitas per film.

---

## Macros & Custom Testing

* **Macros (`macros/`)**:
  * `full_name.sql`: Utility macro untuk menggabungkan nama depan dan belakang dengan penanganan `NULL`.
* **Testing (`tests/`)**:
  * `assert_daily_revenue_matches_payments.sql`: Data test untuk memastikan total revenue di mart sesuai dengan total amount di staging.
  * `assert_customer_performance_matches_staging.sql`: Test validasi integritas data customer antar layer.

