from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from dotenv import load_dotenv
import os

load_dotenv()  

app = Flask(__name__)

db_username = os.getenv("DB_USERNAME")
db_password = os.getenv("DB_PASSWORD")
db_name = os.getenv("DB_NAME")
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")

app.config['SQLALCHEMY_DATABASE_URI'] = f'postgresql://{db_username}:{db_password}@{db_host}:{db_port}/{db_name}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)  

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/index')
def index():
    return render_template('index.html')



@app.route('/arama', methods=['GET', 'POST'])
def arama():
    if request.method == 'POST':
        search_id = request.form['search']
        query = text('SELECT * FROM "Hayvan" WHERE "HayvanID" = :search_id')
        result = db.session.execute(query, {'search_id': search_id}).fetchall()
        return render_template('arama.html', users=result)
    return render_template('arama.html', users=None)

@app.route('/ekleme', methods=['GET', 'POST'])
def ekleme():
    if request.method == 'POST':
        print(request.form)
    
        query = text('SELECT "TürAdı" FROM "Türler"')
        turler = db.session.execute(query).fetchall()
        turler_listesi = [tur[0] for tur in turler]

     
        ad = request.form.get('Ad')
        tur = request.form.get('HayvanTürü')
        konakno = request.form.get('KonakNo')

        if not all([ad, tur, konakno]):
            return "Tüm alanları doldurun!", 400
        
        query = text('SELECT public.kapasite_kontrol(:konakno)')
        result = db.session.execute(query, {'konakno': int(konakno)}).fetchone()

        if not result[0]:
            return "Kapasite dolu, hayvan eklenemez!", 400
        
        query = text('INSERT INTO "Hayvan" ( "Ad", "HayvanTürü", "KonakNo") '
                     'VALUES ( :Ad, :HayvanTürü, :KonakNo)')
        db.session.execute(query, {
            'Ad': ad,
            'HayvanTürü': tur,
            'KonakNo': int(konakno),
        })
        db.session.commit()

        return render_template('ekleme.html', turler=turler_listesi)

    query = text('SELECT "KonakNo" FROM "Konaklama" WHERE "KonakDurum" != \'Dolu\'')
    konakno_listesi = db.session.execute(query).fetchall()
    konakno_listesi = [konakno[0] for konakno in konakno_listesi]

    query = text('SELECT "TürAdı" FROM "Türler"')
    turler = db.session.execute(query).fetchall()
    turler_listesi = [tur[0] for tur in turler]

    return render_template('ekleme.html', turler=turler_listesi, konakno_listesi=konakno_listesi)



@app.route('/guncelleme', methods=['GET', 'POST'])
def guncelleme():
    if request.method == 'POST':
        try:
            print(request.form) 
            hayvan_id = request.form.get('HayvanID')
            yeni_ad = request.form.get('Ad')
            
            if not hayvan_id or not yeni_ad:
                return "Kayıt ID ve Yeni Ad alanları doldurulmalıdır!", 400

            query = text('UPDATE "Hayvan" SET "Ad" = :yeni_ad WHERE "HayvanID" = :hayvan_id')
            result = db.session.execute(query, {'yeni_ad': yeni_ad, 'hayvan_id': hayvan_id})
            db.session.commit()

            if result.rowcount and result.rowcount > 0:
                return "Hayvan başarıyla güncellendi!"
            return "Hayvan bulunamadı!"
        except Exception as e:
            return f"Hata oluştu: {str(e)}", 500

    query = text('SELECT "HayvanID" FROM "Hayvan"')
    hayvan_ids = db.session.execute(query).fetchall()
    hayvan_ids_list = [hayvan_id[0] for hayvan_id in hayvan_ids]

    return render_template('guncelleme.html', hayvan_ids=hayvan_ids_list)


@app.route('/silme', methods=['GET', 'POST'])
def silme():
    if request.method == 'POST':
        try:
            print(request.form)  
            hayvan_id = request.form.get('HayvanID') 
            if not hayvan_id:
                return "HayvanID boş olamaz!", 400
            
            query = text('DELETE FROM "Hayvan" WHERE "HayvanID" = :hayvan_id')
            result = db.session.execute(query, {'hayvan_id': int(hayvan_id)}) 
            db.session.commit()
            
            if result.rowcount > 0:
                return render_template('silme.html')
            return "Hayvan bulunamadı!"
        except Exception as e:
            return f"Hata oluştu: {str(e)}", 500
    
    query = text('SELECT "HayvanID" FROM "Hayvan"')
    hayvan_ids = db.session.execute(query).fetchall()
    hayvan_ids_list = [hayvan_id[0] for hayvan_id in hayvan_ids]  
    
    return render_template('silme.html', hayvan_ids=hayvan_ids_list)



@app.route("/doluluk", methods=['GET', 'POST'])
def barinak_doluluk_orani():
    if request.method == 'POST':
        barinak_id = request.form.get('barinakid')  
        if not barinak_id:
            return render_template('doluluk.html', error="Barınak ID'si girilmelidir.")
        
        query = text('SELECT public.barinak_doluluk(:barinak_id);')
        result = db.session.execute(query, {'barinak_id': barinak_id}).fetchall()

        if result:
            doluluk_orani = result[0][0]     
            return render_template('doluluk.html', doluluk_orani=doluluk_orani)
        else:
            return render_template('doluluk.html', doluluk_orani=None, error="Barınak bulunamadı.")
        
    query = text('SELECT "BarinakID" FROM "Barinaklar"')
    barinaklar = db.session.execute(query).fetchall()

    return render_template('doluluk.html', doluluk_orani=None, barinaklar=barinaklar)


@app.route("/istatistik", methods=['GET'])
def ziyaretci_istatistikleri():
    query = text('SELECT * FROM public.ziyaretci_istatistikleri()')
    result = db.session.execute(query).fetchall()
    return render_template('istatistik.html', ziyaretci_istatistikleri=result)

@app.route("/saglik", methods=['GET', 'POST'])
def saglik_gecmisi():
    
    if request.method == 'POST':
        hayvan_id = request.form.get('hayvan_id')
    else:
        hayvan_id = request.args.get('hayvan_id')

    query = text('SELECT "HayvanID" FROM "Hayvan"')
    hayvan_ids = db.session.execute(query).fetchall()
    hayvan_ids_list = [hayvan_id[0] for hayvan_id in hayvan_ids]

    if hayvan_id:
        query = text(''' 
            SELECT * FROM public.saglik_gecmisi(:hayvan_id)
            ORDER BY "Tarih" DESC
            LIMIT 10
        ''')
        result = db.session.execute(query, {'hayvan_id': hayvan_id}).fetchall()
    else:
        result = []

    return render_template('saglik.html', saglik_gecmisi=result, hayvan_id=hayvan_id, hayvan_ids=hayvan_ids_list)


if __name__ == '__main__':
    app.run(debug=True)
