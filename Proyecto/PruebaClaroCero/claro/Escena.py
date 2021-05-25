import direct.directbase.DirectStart
from direct.showbase.ShowBase import ShowBase
from panda3d.core import *
from direct.gui.OnscreenText import OnscreenText
import sys


class Escena(ShowBase):

    def __init__(self):
        self.initColisiones()
        self.cargarNivel()
        self.initJugador()
    #    self.efectosIluminacion()
        base.accept( "escape" , sys.exit)
        base.disableMouse()
        #OnscreenText(text="Movimiento", style=1, fg=(1,1,1,1),
        #            pos=(1.3,-0.95), align=TextNode.ARight, scale = .07)
        #OnscreenText(text=__doc__, style=1, fg=(1,1,1,1),
        #    pos=(-1.3, 0.95), align=TextNode.ALeft, scale = .05)
        
    def initColisiones(self):
        #sistema de colisiones
        base.cTrav = CollisionTraverser()
        base.pusher = CollisionHandlerPusher()
        
    def cargarNivel(self):
        #cargar el nivel. Hay que crearlo en blender
        self.level = loader.loadModel('level.egg')
        self.level.reparentTo(render)
        self.level.setTwoSided(True)
                
    def initJugador(self):
        self.node = Jugador()


    #def efectosIluminacion(self):
    #    luzAmbiental = AmbientLight("luzAmbiental")
    #    luzAmbiental.setColor((0.04, 0.04, 0.04, 1))
    #    luzAmbientalNodo = self.render.attachNewNode(luzAmbiental)
    #    self.render.setLight(luzAmbiental)
        
class Jugador(object):
    #atributos del jugador
    velocidad = 15
    ADELANTE = Vec3(0, 2, 0)
    ATRAS = Vec3(0, -1, 0)
    IZQUIERDA = Vec3(-1, 0, 0)
    DERECHA = Vec3(1, 0, 0)
    PARAR = Vec3(0)
    caminar = PARAR
    movLateral = PARAR
    #saltoPermitido = False
    gravedad = 0
    
    def __init__(self):
        self.cargarModelo()
        self.setUpCamera()
        self.crearColisiones()
        self.invocarControles()
        # init mouse update task
        taskMgr.add(self.mouseUpdate, 'mouse-task')
        taskMgr.add(self.movimientoUpdate, 'movimiento-task')
        taskMgr.add(self.gravedadUpdate, 'gravedad-task')
        
    def cargarModelo(self):
        #crear un nodepath para el jugador y cargarlo como modelo
        self.node = NodePath('jugador')
        self.node.reparentTo(render)
        self.node.setPos(0,0,2)
        self.node.setScale(.05)
    
    def setUpCamera(self):
        #agregar la cámara al nodo del jugador
        pl = base.cam.node().getLens()
        pl.setFov(70)
        base.cam.node().setLens(pl)
        base.camera.reparentTo(self.node)
        
    def crearColisiones(self):
        #crear mascara de colisiones y raycasting para el jugador
        cn = CollisionNode('player')
        cn.addSolid(CollisionSphere(0,0,0,3))
        solid = self.node.attachNewNode(cn)
        base.cTrav.addCollider(solid,base.pusher)
        base.pusher.addCollider(solid,self.node, base.drive.node())
        # init players floor collisions
        ray = CollisionRay()
        ray.setOrigin(0,0,-.2)
        ray.setDirection(0,0,-1)
        cn = CollisionNode('playerRay')
        cn.addSolid(ray)
        cn.setFromCollideMask(BitMask32.bit(0))
        cn.setIntoCollideMask(BitMask32.allOff())
        solid = self.node.attachNewNode(cn)
        self.nodeGroundHandler = CollisionHandlerQueue()
        base.cTrav.addCollider(solid, self.nodeGroundHandler)
        
    def invocarControles(self):
        #eventos del teclado
        #base.accept( "space" , self.__setattr__,["saltoPermitido",True])
        #base.accept( "space-up" , self.__setattr__,["saltoPermitido",False])
        base.accept( "s", self.__setattr__, ["caminar", self.PARAR])
        base.accept( "w", self.__setattr__, ["caminar", self.ADELANTE])
        base.accept( "s", self.__setattr__, ["caminar", self.ATRAS])
        base.accept( "s-up", self.__setattr__, ["caminar", self.PARAR])
        base.accept( "w-up", self.__setattr__, ["caminar", self.PARAR])
        base.accept( "a", self.__setattr__, ["movLateral", self.IZQUIERDA])
        base.accept( "d", self.__setattr__, ["movLateral", self.DERECHA])
        base.accept( "a-up", self.__setattr__, ["movLateral", self.PARAR])
        base.accept( "d-up", self.__setattr__, ["movLateral", self.PARAR])
        
    def mouseUpdate(self,task):
        #Movimiento del mouse para controlar camara
        md = base.win.getPointer(0)
        x = md.getX()
        y = md.getY()
        if base.win.movePointer(0, (int)(base.win.getXSize()/2), (int)(base.win.getYSize()/2)):
            self.node.setH(self.node.getH() -  (x - base.win.getXSize()/2)*0.1)
            base.camera.setP(base.camera.getP() - (y - base.win.getYSize()/2)*0.1)
        return task.cont
    
    def movimientoUpdate(self, task):
        #llamar al movimiento del jugador
        #mueve al jugador basado en la tecla de input y multiplicando la velocidad por el deltatime
        self.node.setPos(self.node, self.caminar * globalClock.getDt() * self.velocidad)
        self.node.setPos(self.node, self.movLateral * globalClock.getDt() * self.velocidad)
        return task.cont
        
    def gravedadUpdate(self, task):
        #simula gravedad y permite el salto. El salto actualmente está deshabilitado hasta decidir si queremos que el jugador pueda saltar
        # obtener el mayor Z del raycast hacia abajo
        mayorZ = -100
        for i in range(self.nodeGroundHandler.getNumEntries()):
            entry = self.nodeGroundHandler.getEntry(i)
            z = entry.getSurfacePoint(render).getZ()
            if z > mayorZ and entry.getIntoNode().getName() == "Cube":
                mayorZ = z
        # efecto de gravedad y salto
        self.node.setZ(self.node.getZ() + self.gravedad * globalClock.getDt())
        self.gravedad -= 1 * globalClock.getDt()
        if mayorZ > self.node.getZ()-.3:
            self.gravedad = 0
            self.node.setZ(mayorZ+.3)
        #    if self.saltoPermitido:
        #        self.gravedad = 1
        return task.cont

Escena()
base.run()