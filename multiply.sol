pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract multiply {

	uint public mult = 1; // Переменная в которой хранится значение.

	constructor() public { 
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

	function times(uint value) public checkOwnerAndAccept { // Функция умножения.
        require(!(value < 1 || value > 10), 400); // Если меньше единицы или больше десяти, то генерируется ошибка.
		mult *= value;
	}
}