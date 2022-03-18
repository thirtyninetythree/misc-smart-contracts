// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract TicTacToe {
    address public previousPlayer;
    address [9] public gameState;
    event GameOver(string message, address gameWinner);
    address public winner = address(0);
    address public playerX = address(0);
    address public playerO = address(0);
    uint256 public numberOfMoves = 0;
    
    function play(uint256 number) public {
        require( number >= 0, "inavlid move, negative number" );
        require( number <= 8, "inavlid move, too large" );
        require(previousPlayer != msg.sender, "not your turn");
        require(gameState[number] == address(0), "already filled in"); //checking to see that move wasnt played before
        require(numberOfMoves < 9, "all moves played");
        previousPlayer = msg.sender;
        gameState[number] = msg.sender;
        numberOfMoves++; //numberOfMoves

        if (numberOfMoves == 1) {
            playerX = msg.sender;
        } else if (numberOfMoves == 2) {
            playerO = msg.sender;
        }
        if (numberOfMoves > 2) {
            require(playerX == msg.sender || playerO == msg.sender, "only two players allowed"); //only two players
        }


        if (numberOfMoves >=5 ) {
            checkWinner();
            if (winner != address(0)) {
                emit GameOver("winner found", winner);
            }
        }
    }
    function checkWinner() private{ //1, 3, 5, 7, 9 are player x
        if (gameState[0] == gameState[1] && gameState[1] ==gameState[2]) {
            winner = gameState[0];
        } else if (gameState[3] == gameState[4] && gameState[4] == gameState[5]) {
            winner = gameState[3];
        }else if (gameState[6] == gameState[7] && gameState[7] == gameState[8]) {
            winner = gameState[6];
        } else if (gameState[0] == gameState[3] && gameState[3] == gameState[6]) {
            winner = gameState[0];
        } else if (gameState[1] == gameState[4] && gameState[4] == gameState[7]) {
            winner = gameState[1];
        } else if (gameState[2] == gameState[5] && gameState[5] == gameState[8]) {
            winner = gameState[2];
        } else if (gameState[0] == gameState[4] && gameState[4] == gameState[8]) {
            winner = gameState[0];
        } else if (gameState[2] == gameState[4] && gameState[4] == gameState[6]) {
            winner = gameState[2];
        }
    }

    function resetGame() public {
        previousPlayer = address(0);
        winner = address(0);
        delete gameState;
        numberOfMoves = 0;
    }

}
