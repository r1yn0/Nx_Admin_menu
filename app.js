const menu = document.getElementById('adminMenu');
const closeButton = document.getElementById('close');
const playersList = document.getElementById('playersList');

window.addEventListener('message', function(event) {

    const data = event.data;

    if (data.action === 'open') {

        menu.style.display = 'block';

        loadPlayers();

    }

    if (data.action === 'close') {

        menu.style.display = 'none';

    }

});

closeButton.addEventListener('click', function() {

    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        body: JSON.stringify({})
    });

});

async function loadPlayers() {

    playersList.innerHTML = 'Loading players...';

    const response = await fetch(
        `https://${GetParentResourceName()}/getPlayers`,
        {
            method: 'POST',
            body: JSON.stringify({})
        }
    );

    const players = await response.json();

    playersList.innerHTML = '';

    if (!players || players.length === 0) {

        playersList.innerHTML =
            '<div style="color:#777;">No players online</div>';

        return;
    }

    players.forEach(player => {

        const element = document.createElement('div');

        element.className = 'player';

        element.innerHTML = `

            <div class="playerInfo">

                <div class="playerName">
                    ${player.name}
                </div>

                <div class="playerDetails">
                    ID:
                    <span class="playerId">
                        ${player.id}
                    </span>

                    &nbsp; | &nbsp;

                    Job:
                    ${player.job}
                </div>

            </div>

        `;

        playersList.appendChild(element);

    });

}