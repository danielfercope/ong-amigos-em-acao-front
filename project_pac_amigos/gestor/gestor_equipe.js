document.addEventListener('DOMContentLoaded', () => {
    const pessoasTab = document.getElementById('pessoas-tab');
    const voluntariosTab = document.getElementById('voluntarios-tab');
    const pessoasForm = document.getElementById('pessoas-form');
    const voluntariosForm = document.getElementById('voluntarios-form');
    const pessoasTableBody = document.querySelector('#pessoas-table tbody');
    const voluntariosTableBody = document.querySelector('#voluntarios-table tbody');

    // Função para trocar de aba
    pessoasTab.addEventListener('click', () => {
        pessoasForm.classList.remove('hidden');
        voluntariosForm.classList.add('hidden');
        pessoasTab.classList.add('active');
        voluntariosTab.classList.remove('active');
    });

    voluntariosTab.addEventListener('click', () => {
        pessoasForm.classList.add('hidden');
        voluntariosForm.classList.remove('hidden');
        pessoasTab.classList.remove('active');
        voluntariosTab.classList.add('active');
    });

    // Função para buscar e exibir voluntários
    const fetchVoluntarios = async () => {
        try {
            const response = await fetch('http://127.0.0.1:5000/listar-voluntarios-controle');
            if (!response.ok) {
                throw new Error('Erro ao buscar voluntários');
            }
            const data = await response.json();
            voluntariosTableBody.innerHTML = '';
            data.forEach(voluntario => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${voluntario.nomeVoluntario}</td>
                    <td>${voluntario.telefoneVoluntario}</td>
                    <td>${voluntario.emailVoluntario}</td>
                    <td>
                    <button class="delete-btn" data-id="${voluntario.idVoluntario}"><i class="fa-solid fa-trash"></i></button>
                    </td>
                `;
                voluntariosTableBody.appendChild(row);
            });
        } catch (error) {
            console.error('Erro ao buscar voluntários:', error);
        }
    };

    // Função para buscar e exibir pessoas que precisam de ajuda
    const fetchPessoas = async () => {
        try {
            const response = await fetch('http://127.0.0.1:5000/lista-usuario-carente');
            if (!response.ok) {
                throw new Error('Erro ao buscar pessoas');
            }
            const data = await response.json();
            pessoasTableBody.innerHTML = '';
            data.forEach(pessoa => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${pessoa.nomeUsuario}</td>
                    <td>${pessoa.telefoneUsuario}</td>
                    <td>${pessoa.descricaoFamiliarUsuario}</td>
                    <td>${pessoa.necessidadeUsuario}</td>
                    <td>
                        <button class="delete-btn" data-id="${pessoa.id}"><i class="fa-solid fa-trash"></i></button>
                    </td>
                `;
                pessoasTableBody.appendChild(row);
            });
        } catch (error) {
            console.error('Erro ao buscar pessoas:', error);
        }
    };

    // Função para deletar voluntário
    const deleteVoluntario = async (id) => {
        try {
            const response = await fetch('http://127.0.0.1:5000/delete-voluntario', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: id })
            });
            if (!response.ok) {
                throw new Error('Erro ao deletar voluntário');
            }
            await fetchVoluntarios(); // Atualiza a lista de voluntários
        } catch (error) {
            console.error('Erro ao deletar voluntário:', error);
        }
    };

    // Função para deletar usuário
    const deleteUsuario = async (id) => {
        try {
            const response = await fetch('http://127.0.0.1:5000/delete-usuario', {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: id })
            });
            if (!response.ok) {
                throw new Error('Erro ao deletar usuário');
            }
            await fetchPessoas(); // Atualiza a lista de usuários
        } catch (error) {
            console.error('Erro ao deletar usuário:', error);
        }
    };

    // Evento para deletar voluntário
    voluntariosTableBody.addEventListener('click', (event) => {
        const target = event.target;
        if (target.classList.contains('fa-trash')) {
            const id = target.closest('button').dataset.id;
            deleteVoluntario(id);
        }
    });

    // Evento para deletar usuário
    pessoasTableBody.addEventListener('click', (event) => {
        const target = event.target;
        if (target.classList.contains('fa-trash')) {
            const id = target.closest('button').dataset.id;
            deleteUsuario(id);
        }
    });

    fetchVoluntarios();
    fetchPessoas();
});
