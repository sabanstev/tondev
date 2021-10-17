pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract queue_to_the_store {

    string [] public queue; // Массив строк в котором будет храниться очередь, делаем его публичным чтобы можно было посмотреть что в нём.

    constructor() public {

        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

    }

    function addNew(string value) public{ // Функция добавляет новое значение типа string в конец массива qeue.
        require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
        queue.push(value);
    }

    function callNext() public{ // Функция удаляет значение с индексом "0" из массива qeue.
        require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
        for (uint i = 0; i<queue.length-1; i++){ // Перезаписываем все элементы массива на один назад.
            queue[i] = queue[i+1];
        }
        queue.pop(); // Удаляем последний элемент из массива т.к. он теперь записан в предпоследний. 
        
    }

}
