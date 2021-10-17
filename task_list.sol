pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract task_list {

    struct tasks {
        string taskName; // Имя задачи.
        uint32 timestamp; // Метка времени выполнения.
        bool flag; // Флаг выполнения.
    }

    mapping(int8 => tasks) list; // Упорядоченный массив для хранения экземпляров структуры.

    int8 key = 0; // Ключ для упорядоченного массива.

    modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }

    function addTsk(string nameTask) public checkOwnerAndAccept { // Функция добавления нового задания.
        list[key] = tasks(nameTask, now, false); // Добавляем новый элемент в список, ключ key, имя задачи поступает в функцию как аргумент, ставим метку времени, по умолчанию все задачи false.
        key++;
	}

    function getOpenTask() public checkOwnerAndAccept returns(int8){ // Функция возвращает количество открытых задач, т.е. задач у которых flag == false.
        int8 x = 0; // Используем для подсчёта незакрытых задач.
        for(int8 i = 0; i <= key; i++){
            if(list[i].flag == false) x++; // Если задача не закрыта увеличиваем на единицу.
        }
        return x; // Возвращаем количество не закрытых.
	}

    function getNumberTask() public checkOwnerAndAccept returns(string []){ // Функция возвращает массив с названиями задач.
        string [] s; // Используем для подсчёта незакрытых задач.
        for(int8 i = 0; i <= key; i++){
            s.push(list[i].taskName);
        }
        return s; // Возвращаем количество не закрытых.
	}

    function getTaskInfo(int8 k) public checkOwnerAndAccept returns(string, uint32, bool){ // Функция возвращает все значения полей задачи.
        return (list[k].taskName, list[k].timestamp, list[k].flag); // Возвращаем значения полей.
	}

    function delItem(int8 k) public checkOwnerAndAccept { // Функция удаляет элемент из списка по значению ключа.
        delete list[k]; // Удаляем элемент из списка.
	}

    function taskRedy(int8 k) public checkOwnerAndAccept { // Функция устанавливает значение true в элемент из списка по значению ключа.
        list[k].flag = true; // Устанавливаем значение true.
	}
}
