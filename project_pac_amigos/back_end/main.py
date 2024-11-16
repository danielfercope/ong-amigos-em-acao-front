import base64

from flask import Flask, request, jsonify, render_template
import mysql.connector
from mysql.connector import Error
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

app.config['UPLOAD_FOLDER'] = 'uploads'


def conectar_bd():
    try:
        conexao = mysql.connector.connect(
            host='localhost',
            user='root',
            password='admin123',
            database='N2_BancoDados'
        )
        print("Conexão ao banco de dados MySQL bem-sucedida")
        return conexao
    except Error as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

@app.route('/cadastrar-gestores', methods=['POST'])
def criar_gestor():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    data = request.get_json()
    nome = data.get('nomeGestor')
    email = data.get('emailGestor')
    pin = data.get('pinGestor')

    try:
        cursor = conexao.cursor()
        cursor.execute("INSERT INTO gestorTabela (nomeGestor, senhaGestor, emailGestor) VALUES (%s, %s, %s)",
                       (nome, pin, email))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Gestor criado com sucesso!'}), 201
    except Error as e:
        print(f"Erro ao criar gestor: {e}")
        return jsonify({'error': 'Erro ao criar gestor'}), 500


@app.route('/buscar-gestores', methods=['GET'])
def obter_gestores():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT * FROM gestores")
        gestores = cursor.fetchall()
        cursor.close()
        conexao.close()
        return jsonify(gestores), 200
    except Error as e:
        print(f"Erro ao obter gestores: {e}")
        return jsonify({'error': 'Erro ao obter gestores'}), 500


@app.route('/atualizar-gestor/<int:id>', methods=['PUT'])
def atualizar_gestor(id):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    nome = request.form.get('nomeGestor')
    email = request.form.get('emailGestor')
    pin = request.form.get('pinGestor')

    if not (nome and email and pin):
        return jsonify({'error': 'Todos os campos são obrigatórios!'}), 400

    try:
        cursor = conexao.cursor()
        cursor.execute("UPDATE gestores SET nomeGestor = %s, emailGestor = %s, pinGestor = %s WHERE idGestor = %s",
                       (nome, email, pin, id))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Gestor atualizado com sucesso!'}), 200
    except Error as e:
        print(f"Erro ao atualizar gestor: {e}")
        return jsonify({'error': 'Erro ao atualizar gestor'}), 500


@app.route('/deletar-gestor/<int:id>', methods=['DELETE'])
def deletar_gestor(id):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor()
        cursor.execute("DELETE FROM gestores WHERE idGestor = %s", (id,))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Gestor excluído com sucesso!'}), 200
    except Error as e:
        print(f"Erro ao excluir gestor: {e}")
        return jsonify({'error': 'Erro ao excluir gestor'}), 500


@app.route('/lista-usuario-carente', methods=['GET'])
def visualizar_usuarioTradicional():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT * FROM usuarioCarente")
        tradicionalUser = cursor.fetchall()
        cursor.close()
        conexao.close()
        return jsonify(tradicionalUser), 200
    except Error as e:
        print(f"Erro ao obter usuarios: {e}")
        return jsonify({'error': 'Erro ao obter usuarios'}), 500


@app.route('/cadastrar-usuario-carente', methods=['POST'])
def criar_usuarioTradicional():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    data = request.get_json()
    userName = data.get('userName')
    userPhone = data.get('userPhone')
    userNeeds = data.get('userNeeds')
    userFamilyDescription = data.get('userFamilyDescription')

    if not (userName and userPhone and userNeeds and userFamilyDescription):
        return jsonify({'error': 'Todos os campos são obrigatórios'}), 400

    try:
        cursor = conexao.cursor()
        cursor.execute(
            "INSERT INTO usuarioCarente (nomeUsuario, telefoneUsuario, necessidadeUsuario, descricaoFamiliarUsuario) VALUES (%s, %s, %s, %s)",
            (userName, userPhone, userNeeds, userFamilyDescription)
        )
        conexao.commit()
        cursor.close()
        conexao.close()
        return jsonify({'message': 'Usuario criado com sucesso!'}), 201
    except Error as e:
        print(f"Erro ao criar usuario: {e}")
        return jsonify({'error': 'Erro ao criar usuario'}), 500
# CRUD DOS USUÁRIOS CARENTES

@app.route('/lista-feedBack', methods=['GET'])
def visualizar_feedBack():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT * FROM Feedback")
        tradicionalUser = cursor.fetchall()
        cursor.close()
        conexao.close()
        return jsonify(tradicionalUser), 200
    except Error as e:
        print(f"Erro ao obter usuarios: {e}")
        return jsonify({'error': 'Erro ao obter usuarios'}), 500

@app.route('/delete-usuario/<int:userId>', methods=['DELETE'])
def deletar_usuarioTradicional(userId):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor()
        cursor.execute("DELETE FROM tradicionalUser WHERE userId = %s", (userId,))
        conexao.commit()
        cursor.close()
        conexao.close()
        return jsonify("usuario deletado com sucesso"), 200
    except Error as e:
        print(f"Erro ao obter usuarios: {e}")
        return jsonify({'error': 'Erro ao obter usuarios'}), 500


@app.route('/atualizar-usuario-carente/<int:userId>', methods=['PUT'])
def editar_usuarioTradicional(userId):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    data = request.get_json()
    userName = data.get('userName')
    userPhone = data.get('userPhone')
    userNeeds = data.get('userNeeds')
    userFamilyDescription = data.get('userFamilyDescription')

    query = "UPDATE tradicionalUser SET"
    if userName:
        query += ' userName = "' + userName + '",'
    if userPhone:
        query += ' userPhone = "' + userPhone + '",'
    if userNeeds:
        query += ' userNeeds = "' + userNeeds + '",'
    if userFamilyDescription:
        query += ' userFamilyDescription = "' + userFamilyDescription + '",'

    # Remove the last comma
    if query.endswith(','):
        query = query[:-1]

    query += " WHERE userId = "
    query += str(userId)
    print(query)

    try:
        cursor = conexao.cursor()
        cursor.execute(query)
        conexao.commit()
        cursor.close()
        conexao.close()
        return jsonify("usuario editado com sucesso"), 200
    except Error as e:
        print(f"Erro ao obter usuarios: {e}")
        return jsonify({'error': 'Erro ao obter usuarios'}), 500


# CRUD DOS FEEDBACKS
@app.route('/cadastrar-feedBack', methods=['POST'])
def submit():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    data = request.get_json()
    nome = data.get('nome')
    telefone = data.get('telefone')
    email = data.get('email')
    descFeedback = data.get('descricao')

    try:
        cursor = conexao.cursor()
        cursor.execute("INSERT INTO Feedback (nomeUsuarioFeedback, telefoneUsuarioFeedback, emailUsuarioFeedback, descFeedback) VALUES (%s, %s, %s, %s)",
                       (nome, telefone, email, descFeedback))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'feedBack enviado com sucesso!'}), 201
    except Error as e:
        print(f"Erro ao criar feedBack: {e}")
        return jsonify({'error': 'Erro ao criar feedBack'}), 500


# CRUD DE EVENTOS
@app.route('/evento-post', methods=['POST'])
def criar_evento():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    dados = request.json

    nome_evento = dados.get('nome_evento')
    data_evento = dados.get('data_evento')
    descricao_evento = dados.get('descricao_evento')
    localizacao_evento = dados.get('localizacao_evento')
    ultima_alteracao = dados.get('ultima_alteracao')

    # Imprimir dados recebidos para depuração
    print("Dados recebidos para criação:", dados)

    try:
        cursor = conexao.cursor()

        cursor.execute(
            "INSERT INTO Evento (nome_evento, data_evento, descricao_evento, localizacao_evento, ultima_alteracao) VALUES (%s, %s, %s, %s, %s)",
            (nome_evento, data_evento, descricao_evento, localizacao_evento, ultima_alteracao))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Evento criado com sucesso!'}), 201
    except Error as e:
        print(f"Erro ao criar evento: {e}")
        return jsonify({'error': 'Erro ao criar evento'}), 500


@app.route('/evento-get', methods=['GET'])
def obter_eventos():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT * FROM evento")
        eventos = cursor.fetchall()
        cursor.close()
        conexao.close()
        return jsonify(eventos), 200
    except Error as e:
        print(f"Erro ao obter eventos: {e}")
        return jsonify({'error': 'Erro ao obter eventos'}), 500


# Rota para atualizar um evento existente
@app.route('/evento-put/<int:event_id>', methods=['PUT'])
def atualizar_evento(event_id):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    dados = request.get_json()

    # Imprimir dados recebidos para depuração
    print("Dados recebidos para atualização:", dados)

    nome_evento = dados.get('nome_evento')
    data_evento = dados.get('data_evento')
    descricao_evento = dados.get("descricao_evento")
    localizacao_evento = dados.get("localizacao_evento")
    ultima_alteracao = dados.get('ultima_alteracao')

    try:
        cursor = conexao.cursor()

        cursor.execute("""
            UPDATE Evento 
            SET nome_evento = %s, data_evento = %s, descricao_evento = %s, localizacao_evento = %s, ultima_alteracao = %s 
            WHERE idEvento = %s
        """, (nome_evento, data_evento, descricao_evento, localizacao_evento, ultima_alteracao, event_id))

        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Evento atualizado com sucesso!'}), 200
    except Error as e:
        print(f"Erro ao atualizar evento: {e}")
        return jsonify({'error': 'Erro ao atualizar evento'}), 500


@app.route('/evento-delete/<int:id>', methods=['DELETE'])
def deletar_evento(id):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor()

        # Exclui o evento do banco de dados
        cursor.execute("DELETE FROM evento WHERE idEvento = %s", (id,))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Evento excluído com sucesso!'}), 200
    except Error as e:
        print(f"Erro ao excluir evento: {e}")
        return jsonify({'error': 'Erro ao excluir evento'}), 500


# CRUD DOS VOLUNTÁRIOS
@app.route('/listar-voluntarios', methods=['GET'])
def listar_voluntario():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT * FROM voluntario")
        voluntarios = cursor.fetchall()
        cursor.close()
        conexao.close()
        return render_template('index.html', voluntarios=voluntarios)
    except Error as e:
        print(f"Erro ao obter voluntarios: {e}")
        return jsonify({'error': 'Erro ao obter voluntarios'}), 500

@app.route('/listar-voluntarios-controle', methods=['GET'])
def listar_voluntario_controle():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT * FROM voluntario")
        voluntarios = cursor.fetchall()
        cursor.close()
        conexao.close()
        return jsonify(voluntarios)
    except Error as e:
        print(f"Erro ao obter voluntarios: {e}")
        return jsonify({'error': 'Erro ao obter voluntarios'}), 500

@app.route('/listar-voluntarios-edit/<int:id>', methods=['GET'])
def listar_voluntario_edit(id):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT nomeVoluntario, emailVoluntario, telefoneVoluntario FROM voluntario WHERE idVoluntario = %s", (id,))
        voluntario = cursor.fetchone()  # Obter apenas um resultado

        cursor.close()
        conexao.close()

        if voluntario:
            return jsonify(voluntario), 200
        else:
            return jsonify({'error': 'Voluntário não encontrado'}), 404

    except Error as e:
        print(f"Erro ao obter voluntário: {e}")
        return jsonify({'error': 'Erro ao obter voluntário'}), 500

@app.route('/editar-formulario-voluntario/<int:id>', methods=['POST'])
def editar_formulario_voluntario(id):
    dados = request.get_json()
    nome = dados.get('nomeVoluntario')
    email = dados.get('emailVoluntario')
    telefone = dados.get('telefoneVoluntario')

    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor()
        cursor.execute("""
            UPDATE voluntario
            SET nomeVoluntario = %s, emailVoluntario = %s, telefoneVoluntario = %s
            WHERE idVoluntario = %s
        """, (nome, email, telefone, id))
        conexao.commit()

        cursor.close()
        conexao.close()

        return jsonify({'success': 'Voluntário atualizado com sucesso'}), 200

    except Error as e:
        print(f"Erro ao atualizar voluntário: {e}")
        return jsonify({'error': 'Erro ao atualizar voluntário'}), 500


@app.route('/cadastrar-voluntarios', methods=['POST'])
def criar_voluntarios():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        data = request.get_json()
        nomeVolun = data.get('nomeVoluntario')
        telefoneVolun = data.get('telefoneVoluntario')
        emailVolun = data.get('emailVoluntario')
        pinVolun = data.get('pinVoluntario')
        # descAjudaVolun = data.get('descricaoAjudaVoluntario')

        with conexao.cursor() as cursor:
            cursor.execute(
                "INSERT INTO voluntario (nomeVoluntario, telefoneVoluntario, emailVoluntario, senhaVoluntario) VALUES (%s, %s, %s, %s)",
                (nomeVolun, telefoneVolun, emailVolun, pinVolun))
            conexao.commit()

        return jsonify({'message': 'Voluntario criado com sucesso!'}), 201
    except Exception as e:
        print(f"Erro ao criar voluntario: {str(e)}")
        return jsonify({'error': 'Erro ao criar voluntario'}), 500
    finally:
        conexao.close()

@app.route('/listar-gestores-edit/<int:id>', methods=['GET'])
def listar_gestores_edit(id):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT nomeGestor, emailGestor, senhaGestor FROM gestorTabela WHERE idGestor = %s", (id,))
        gestor = cursor.fetchone()  # Obter apenas um resultado

        cursor.close()
        conexao.close()

        if gestor:
            return jsonify(gestor), 200
        else:
            return jsonify({'error': 'Voluntário não encontrado'}), 404

    except Error as e:
        print(f"Erro ao obter voluntário: {e}")
        return jsonify({'error': 'Erro ao obter voluntário'}), 500

@app.route('/editar-formulario-gestores/<int:id>', methods=['POST'])
def editar_formulario_gest(id):
    dados = request.get_json()
    nome = dados.get('nomeGestor')
    email = dados.get('emailGestor')
    senhaGestor = dados.get('senhaGestor')

    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor()
        cursor.execute("""
            UPDATE gestorTabela
            SET nomeGestor = %s, emailGestor = %s, senhaGestor = %s
            WHERE idGestor = %s
        """, (nome, email, senhaGestor, id))
        conexao.commit()

        cursor.close()
        conexao.close()

        return jsonify({'success': 'Voluntário atualizado com sucesso'}), 200

    except Error as e:
        print(f"Erro ao atualizar voluntário: {e}")
        return jsonify({'error': 'Erro ao atualizar voluntário'}), 500

@app.route('/buscar-voluntarios', methods=['GET'])
def obter_voluntarios():
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT * FROM voluntarios")
        voluntarios = cursor.fetchall()
        cursor.close()
        conexao.close()
        return jsonify(voluntarios), 200
    except Error as e:
        print(f"Erro ao obter voluntarios: {e}")
        return jsonify({'error': 'Erro ao obter voluntarios'}), 500


@app.route('/atualizar-voluntario/<int:id>', methods=['PUT'])
def atualizar_voluntarios(idVoluntario):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    nomeVolun = request.form.get('nomeVoluntario')
    telefoneVolun = request.form.get('telefoneVoluntario')
    emailVolun = request.form.get('emailVoluntario')
    pinVolun = request.form.get('pinVoluntario')
    descAjudaVolun = request.form.get('descricaoAjudaVoluntario')

    if not (nomeVolun and telefoneVolun and emailVolun and pinVolun and descAjudaVolun):
        return jsonify({'error': 'Todos os campos são obrigatórios!'}), 400

    try:
        cursor = conexao.cursor()
        cursor.execute(
            "UPDATE voluntarios SET nomeVolun = %s, telefoneVolun = %s, emailVolun = %s, pinVolun = %s, descAjudaVolun = %s WHERE idVoluntario = %s",
            (nomeVolun, telefoneVolun, emailVolun, pinVolun, descAjudaVolun, idVoluntario))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Voluntario atualizado com sucesso!'}), 201
    except Error as e:
        print(f"Erro ao atualizar voluntario: {e}")
        return jsonify({'error': 'Erro ao atualizar voluntario'}), 500


@app.route('/deletar-voluntario/<int:idVoluntario>', methods=['DELETE'])
def deletar_voluntario(id):
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor()

        # Exclui o evento do banco de dados
        cursor.execute("DELETE FROM voluntario WHERE idVoluntario = %s", (id,))
        conexao.commit()
        cursor.close()
        conexao.close()

        return jsonify({'message': 'Evento excluído com sucesso!'}), 200
    except Error as e:
        print(f"Erro ao excluir evento: {e}")
        return jsonify({'error': 'Erro ao excluir evento'}), 500


# Rota para validar o usuário
@app.route('/validacao_usuario', methods=['POST'])
def validar_usuario():
    dados = request.get_json()
    email = dados.get('email')
    pin = dados.get('password')
    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT idVoluntario, emailVoluntario, senhaVoluntario FROM voluntario WHERE emailVoluntario = %s AND senhaVoluntario = %s", (email, pin))
        voluntario = cursor.fetchone()

        cursor.close()
        conexao.close()

        if voluntario:
            return jsonify({'authenticated': True, 'idVoluntario': voluntario['idVoluntario']}), 200
        else:
            return jsonify({'authenticated': False}), 401

    except Error as e:
        print(f"Erro ao validar usuário: {e}")
        return jsonify({'error': 'Erro ao validar usuário'}), 500


@app.route('/validacao-gestor', methods=['POST'])
def validar_gestor():
    dados = request.get_json()
    email = dados.get('email')
    pin = dados.get('password')  # Pin é o nome do campo de senha no formulário

    conexao = conectar_bd()
    if not conexao:
        return jsonify({'error': 'Erro ao conectar ao banco de dados'}), 500

    try:
        cursor = conexao.cursor(dictionary=True)
        cursor.execute("SELECT idGestor FROM gestorTabela WHERE emailGestor = %s AND senhaGestor = %s", (email, pin))
        gestor = cursor.fetchone()  # Obter apenas uma linha (um gestor)

        cursor.close()
        conexao.close()

        if gestor:
            return jsonify({'authenticated': True, 'idGestor': gestor['idGestor']}), 200
        else:
            return jsonify({'authenticated': False}), 401

    except Error as e:
        print(f"Erro ao validar gestor: {e}")
        return jsonify({'error': 'Erro ao validar gestor'}), 500

if __name__ == '__main__':
    app.run(debug=True)
