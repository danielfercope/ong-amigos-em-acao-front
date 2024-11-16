document.addEventListener('DOMContentLoaded', function () {
    /* Seleciona elementos principais da interface */
    const createEventTab = document.getElementById('create-event-tab');
    const viewEventsTab = document.getElementById('view-events-tab');
    const createEventForm = document.getElementById('create-event-form');
    const viewEvents = document.getElementById('view-events');
    const eventsContainer = document.querySelector('.events-cards');
    const eventForm = document.querySelector('#create-event-form form');

    /* Seleciona elementos do popup de confirmação */
    const confirmationModal = document.getElementById('confirmation-modal');
    const confirmDeleteBtn = document.getElementById('confirm-delete-btn');
    const cancelDeleteBtn = document.getElementById('cancel-delete-btn');

    /* Seleciona elementos do popup de edição */
    const editEventPopup = document.getElementById('edit-event-popup');
    const cancelEditBtn = document.getElementById('cancel-edit-btn');

    /* Armazena o evento que será editado ou deletado */
    let eventToEdit;
    let eventToDelete;

    /* Troca de abas Criar/Visualizar */
    createEventTab.addEventListener('click', function () {
        createEventTab.classList.add('active');
        viewEventsTab.classList.remove('active');
        createEventForm.classList.remove('hidden');
        viewEvents.classList.add('hidden');
    });

    viewEventsTab.addEventListener('click', function () {
        viewEventsTab.classList.add('active');
        createEventTab.classList.remove('active');
        viewEvents.classList.remove('hidden');
        createEventForm.classList.add('hidden');
        loadEvents();
    });

    function loadEvents() {
        fetch('http://127.0.0.1:5000/evento-get')
            .then(response => response.json())
            .then(events => {
                eventsContainer.innerHTML = ''; // Limpa o contêiner de eventos antes de adicionar novos

                events.forEach(event => {
                    addEventCard(event); // Adiciona um cartão de evento para cada evento retornado
                });
            })
            .catch(error => console.error('Erro ao carregar eventos:', error));
    }

    /* Função para adicionar um cartão de evento na interface */
    function addEventCard(event) {
        const eventCard = document.createElement('div'); // Cria um novo elemento <div> para representar o cartão do evento
        eventCard.classList.add('card'); // Adiciona a classe 'card' ao elemento
        eventCard.setAttribute('data-id', event.idEvento); // Define o atributo 'data-id' no cartão com o ID do evento
        eventCard.innerHTML = `
            <div class="card-img"></div>
            <div class="card-info">
                <h3>${event.nome_evento}</h3>
                <p>Data do Evento: ${new Date(event.data_evento).toLocaleDateString()}</p>
                <p>Última edição: ${new Date(event.ultima_alteracao).toLocaleDateString()}</p>
                <button class="edit-btn">Editar</button>
                <button class="delete-btn">Deletar</button>
            </div>
        `;

        // Botão de Editar
        const editButton = eventCard.querySelector('.edit-btn');
        editButton.addEventListener('click', function () {
            // Preencher campos do popup com dados atuais do evento
            document.getElementById('edit-event-name').value = event.nome_evento;
            document.getElementById('edit-event-date').value = new Date(event.data_evento).toISOString().split('T')[0]; // Formatar a data para input de data
            document.getElementById('edit-descEvento').value = event.descricao_evento;
            document.getElementById('edit-event-location').value = event.localizacao_evento;

            // Armazena o evento a ser editado
            eventToEdit = event;

            // Mostrar o popup de edição
            editEventPopup.classList.add('visible');
        });

        // Botão de Deletar
        const deleteButton = eventCard.querySelector('.delete-btn');
        deleteButton.addEventListener('click', function () {
            eventToDelete = event;
            confirmationModal.classList.remove('hidden');
        });

        eventsContainer.appendChild(eventCard); // Adiciona o cartão do evento ao contêiner de eventos na interface
    }

    // Listener para o formulário de edição
    const editEventForm = editEventPopup.querySelector('form');
    editEventForm.addEventListener('submit', function (event) {
        event.preventDefault();

        // Capturar os novos valores dos campos de edição
        const editedEventName = document.getElementById('edit-event-name').value;
        const editedEventDate = document.getElementById('edit-event-date').value;
        const editedEventDesc = document.getElementById('edit-descEvento').value;
        const editedEventLocation = document.getElementById('edit-event-location').value;

        // Atualizar o evento no servidor
        fetch(`http://127.0.0.1:5000/evento-put/${eventToEdit.idEvento}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                nome_evento: editedEventName,
                data_evento: editedEventDate,
                descricao_evento: editedEventDesc,
                localizacao_evento: editedEventLocation,
                ultima_alteracao: new Date().toISOString().slice(0, 19).replace('T', ' ')
            })
        })
            .then(response => response.json())
            .then(updatedEvent => {
                
                const card = document.querySelector(`[data-id="${updatedEvent.idEvento}"]`);
                if (card) {
                
                    card.querySelector('h3').textContent = updatedEvent.nome_evento;
                    card.querySelector('p:nth-child(2)').textContent = `Descrição: ${updatedEvent.descricao_evento}`;
                    card.querySelector('p:nth-child(3)').textContent = `Data do Evento: ${new Date(updatedEvent.data_evento).toLocaleDateString()}`;
                    card.querySelector('p:nth-child(4)').textContent = `Última edição: ${new Date(updatedEvent.ultima_alteracao).toLocaleDateString()}`;
                }

                
                editEventPopup.classList.remove('visible');
                loadEvents();
                window.location.reload();
            })
            .catch(error => console.error('Erro ao atualizar evento:', error));
    });

    
    cancelEditBtn.addEventListener('click', function () {
    
        editEventPopup.classList.remove('visible');
    });

    
    eventForm.addEventListener('submit', function (event) {
        event.preventDefault();

        
        const eventName = document.getElementById('event-name').value;
        const eventDate = document.getElementById('event-date').value;
        const descEvento = document.getElementById('descEvento').value;
        const eventLocation = document.getElementById('event-location').value;

        
        const newEvent = {
            nome_evento: eventName,
            data_evento: eventDate,
            descricao_evento: descEvento,
            localizacao_evento: eventLocation,
            ultima_alteracao: new Date().toISOString().slice(0, 19).replace('T', ' ')
        };

        console.log(newEvent)

        /* Envia ao servidor os dados do novo evento */
        fetch('http://127.0.0.1:5000/evento-post', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(newEvent)
        })
            .then(response => response.json())
            .then(data => {
                addEventCard(data);
                alert('Evento criado com sucesso!');
            })
            .catch(error => console.error('Erro ao criar evento:', error));

        /* Limpar o formulário */
        eventForm.reset();
    });

    /* Deleta um evento no servidor */
    confirmDeleteBtn.addEventListener('click', function () {
        fetch(`http://127.0.0.1:5000/evento-delete/${eventToDelete.idEvento}`, {
            method: 'DELETE'
        })
            .then(response => {
                if (response.ok) {
                    const card = document.querySelector(`[data-id="${eventToDelete.idEvento}"]`);
                    if (card) {
                        card.remove();
                    }
                } else {
                    alert('Falha ao deletar o evento. Por favor, tente novamente.');
                }
            })
            .catch(error => {
                console.error('Erro ao deletar o evento:', error);
                alert('Erro ao deletar o evento. Por favor, tente novamente.');
            })
            .finally(() => {
                confirmationModal.classList.add('hidden');
            });
    });

    cancelDeleteBtn.addEventListener('click', function () {
        confirmationModal.classList.add('hidden');
    });
});
