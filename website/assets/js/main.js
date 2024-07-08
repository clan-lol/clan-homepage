

const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

let interval = null;

function hacker_effect(target) {
	let iteration = 0;
	clearInterval(interval);

	interval = setInterval(() => {
		target.innerText = target.innerText
			.split("")
			.map((letter, index) => {
				if (index < iteration) {
					return target.dataset.value[index];
				}

				return letters[Math.floor(Math.random() * 26)]
			})
			.join("");

		if (iteration >= target.dataset.value.length) {
			clearInterval(interval);
		}

		iteration += 1 / 3;
	}, 30);
}

document.querySelector("span").onmouseover = event => hacker_effect(event.target);
	window.onload = function () {
		var delay = 250;
		setTimeout(function () {
			let target = document.querySelector("span");
			hacker_effect(target);
		}, delay);
	};
