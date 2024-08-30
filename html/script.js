let events = {};
let isAdmin = false;

window.addEventListener('message', function(event) {
    if (event.data.action === 'openCalendar') {
        const date = new Date();
        const month = date.getMonth();
        const year = date.getFullYear();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        const calendarGrid = document.getElementById('calendar-grid');
        calendarGrid.innerHTML = '';

        isAdmin = event.data.isAdmin || false;
        document.getElementById('global-event-container').style.display = isAdmin ? 'block' : 'none';

        fetch(`https://${GetParentResourceName()}/getEvents`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            }
        }).then(resp => resp.json()).then(data => {
            events = data;

            for (let day = 1; day <= daysInMonth; day++) {
                const dayDiv = document.createElement('div');
                dayDiv.textContent = day;

                if (events[day]) {
                    dayDiv.style.backgroundColor = '#ffdd57';
                    dayDiv.title = events[day];
                }

                dayDiv.addEventListener('click', function() {
                    document.getElementById('event-date').value = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
                    document.getElementById('event-modal').style.display = 'block';
                });

                calendarGrid.appendChild(dayDiv);
            }
        });

        const monthNames = [
            'january', 'february', 'march', 'april', 'may', 'june',
            'july', 'august', 'september', 'october', 'november', 'december'
        ];
        const monthImage = `images/${monthNames[month]}.jpg`;
        document.getElementById('calendar-image').src = monthImage;
        document.getElementById('calendar').style.display = 'block';
    }
});

document.getElementById('close-btn').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/closeCalendar`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        }
    }).then(resp => resp.json()).then(resp => {
        document.getElementById('calendar').style.display = 'none';
    });
});

document.getElementById('add-event-btn').addEventListener('click', function() {
    document.getElementById('event-modal').style.display = 'block';
});

document.querySelector('.modal .close').addEventListener('click', function() {
    document.getElementById('event-modal').style.display = 'none';
});

document.getElementById('save-event-btn').addEventListener('click', function() {
    const date = document.getElementById('event-date').value;
    const title = document.getElementById('event-title').value;
    const isGlobal = document.getElementById('global-event').checked;

    fetch(`https://${GetParentResourceName()}/saveEvent`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8'
        },
        body: JSON.stringify({
            date: date,
            title: title,
            isGlobal: isGlobal
        })
    }).then(resp => resp.json()).then(resp => {
        document.getElementById('event-modal').style.display = 'none';
        location.reload();
    });
});
