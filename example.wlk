object depredador {
  method iniciar() {
    game.boardGround("depredador3.jpg")
    game.addVisual(mario)
    game.addVisual(cohete)
   
    keyboard.space().onPressDo({mario.caminar(1)})
    keyboard.enter().onPressDo({mario.correr()})

    game.onTick(500, "COHETE", {cohete.moverse()})
    game.onCollideDo(mario,{elemento=> elemento.desaparecer() } )
  }
}


object mario {
  var energy = 100
  var pasos = 0
  var desplazamiento = 1

  method energy() = energy

  method caminar(minutes) {
    energy = energy - minutes * 3
    if (pasos == 5)
      desplazamiento = -1
    if (pasos == -5)
      desplazamiento = 1
    pasos = pasos + desplazamiento
 

  }

  method correr(){
    3.times( {i=>self.caminar(1)} )
  }
  method position() = game.center().right(pasos)

  method image() = "mario.png"
}

object cohete{
  var position = game.at(1,9)
  method position() = position

  method moverse(){
    position = position.down(1).right(1)
  }
  method image() = "coheteR.png"

  method desaparecer() {
    game.removeTickEvent("COHETE")
    game.say(self, "AUCH!!!")
    game.schedule(2000, {game.removeVisual(self)})
  }
}