package particlesdemo {

import alternativa.engine3d.alternativa3d;
import alternativa.engine3d.controllers.SimpleObjectController;
import alternativa.engine3d.core.Camera3D;
import alternativa.engine3d.core.Debug;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.core.RayIntersectionData;
import alternativa.engine3d.core.Resource;
import alternativa.engine3d.core.View;
import alternativa.engine3d.core.events.MouseEvent3D;
import alternativa.engine3d.loaders.ParserA3D;
import alternativa.engine3d.loaders.ParserMaterial;
import alternativa.engine3d.loaders.TexturesLoader;
import alternativa.engine3d.materials.TextureMaterial;
import alternativa.engine3d.objects.Mesh;
import alternativa.engine3d.primitives.Box;
import alternativa.engine3d.primitives.GeoSphere;
import alternativa.engine3d.resources.BitmapTextureResource;
import alternativa.engine3d.resources.ExternalTextureResource;
import alternativa.engine3d.utils.Object3DUtils;

import flash.display.Sprite;
import flash.display.Stage3D;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.display3D.Context3D;
import flash.display3D.Context3DRenderMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix3D;
import flash.geom.Vector3D;
import flash.system.Capabilities;
import flash.system.System;
import flash.ui.Keyboard;

import alternativa.engine3d.effects.ParticleSystem;
import alternativa.engine3d.effects.TextureAtlas;

import particlesdemo.classes.SmokyExplosion;

import alternativa.engine3d.materials.FillMaterial;

import particlesdemo.classes.SmokyShot;
import particlesdemo.classes.FlameThrower;
import particlesdemo.classes.Fire;

import alternativa.engine3d.resources.ATFTextureResource;

import particlesdemo.classes.TankExplosion;

use namespace alternativa3d;

[SWF(backgroundColor="#000000", frameRate="60", width="640", height="480")]
public class Effects extends Sprite {

    [Embed(source="resources/background.jpg")]
    static private const EmbedBackground:Class;
    [Embed("resources/smoky_diffuse.atf", mimeType="application/octet-stream")]
    static private const EmbedSmokiDiffuse:Class;
    [Embed("resources/smoky_opacity.atf", mimeType="application/octet-stream")]
    static private const EmbedSmokiOpacity:Class;
    [Embed("resources/flamethrower_diffuse.atf", mimeType="application/octet-stream")]
    static private const EmbedFlamethrowerDiffuse:Class;
    [Embed("resources/flamethrower_opacity.atf", mimeType="application/octet-stream")]
    static private const EmbedFlamethrowerOpacity:Class;
    [Embed("resources/fire_diffuse.atf", mimeType="application/octet-stream")]
    static private const EmbedFireDiffuse:Class;
    [Embed("resources/fire_opacity.atf", mimeType="application/octet-stream")]
    static private const EmbedFireOpacity:Class;
    static private const smokiDiffuse:ATFTextureResource = new ATFTextureResource(new EmbedSmokiDiffuse());
    static private const smokiOpacity:ATFTextureResource = new ATFTextureResource(new EmbedSmokiOpacity());
    static private const flamethrowerDiffuse:ATFTextureResource = new ATFTextureResource(new EmbedFlamethrowerDiffuse());
    static private const flamethrowerOpacity:ATFTextureResource = new ATFTextureResource(new EmbedFlamethrowerOpacity());
    static private const fireDiffuse:ATFTextureResource = new ATFTextureResource(new EmbedFireDiffuse());
    static private const fireOpacity:ATFTextureResource = new ATFTextureResource(new EmbedFireOpacity());


    [Embed("resources/scena1.A3D", mimeType="application/octet-stream")]
    static private const model:Class;

    private var camera:Camera3D = new Camera3D(10, 10000);
    private var stage3D:Stage3D;
    private var context:Context3D;
    private var controller:SimpleObjectController;
    private var scene:Object3D = new Object3D();
    private var particleSystem:ParticleSystem;

    private var mCoords:Vector3D;
    private var vector:Vector3D = new Vector3D();
    private var pause:Boolean = false;


    private var smokySmokeAtlas:TextureAtlas;
    private var smokyFireAtlas:TextureAtlas;
    private var smokyFlashAtlas:TextureAtlas;
    private var smokyFragmentAtlas:TextureAtlas;
    private var smokyGlowAtlas:TextureAtlas;
    private var smokySparkAtlas:TextureAtlas;
    private var smokyShotAtlas:TextureAtlas;
    private var flamethrowerSmokeAtlas:TextureAtlas;
    private var flamethrowerFlashAtlas:TextureAtlas;
    private var flamethrowerFireAtlas:TextureAtlas;
    private var fireSmokeAtlas:TextureAtlas;
    private var fireFireAtlas:TextureAtlas;
    private var fireFlameAtlas:TextureAtlas;
    private var mode:int = 1;
    private var gun:Object3D;
    private var fireMarker:Object3D;
    private var dir:Number;
    private var parser:ParserA3D;

    public function Effects() {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        stage.quality = StageQuality.LOW;

        stage3D = stage.stage3Ds[0];
        stage3D.addEventListener(Event.CONTEXT3D_CREATE, init);
        stage3D.requestContext3D(Context3DRenderMode.AUTO);
    }

    //"gun", "fire"

    private function init(e:Event):void {
        context = stage3D.context3D;
        context.enableErrorChecking = true;
        camera.view = new View(stage.stageWidth, stage.stageHeight, false, 0x555555, 1, 8);
        camera.view.logoAlign = StageAlign.BOTTOM_LEFT;
        addChild(camera.view);
        camera.matrix = new Matrix3D(Vector.<Number>([3.920599667139868e-8,1,0,0,0.30901700258255005,-1.2115319414363057e-8,-0.9510565400123596,0,-0.9510565400123596,3.728711917005967e-8,-0.30901700258255005,0,271.18048095703125,7.526603698730469,196.44918823242188,1 ]));
        controller = new SimpleObjectController(stage, camera, 500, 2);


        initParticleSystem();
        initParticleResources();
        scene.addChild(camera);


//        initScene();
        initScene2();
        initUI();
        onResize();

        addEventListener(Event.ENTER_FRAME, onEnterFrame);
        scene.addEventListener(MouseEvent3D.MOUSE_DOWN, mouseDownHandler);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.addEventListener(Event.RESIZE, onResize);
        stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
        stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
    }

    private function initScene2():void {
        parser = new ParserA3D();
        parser.parse(new model());
        for each (var obj:Object3D in parser.hierarchy) {
            scene.addChild(obj);
        }

        var box = new Box(2000, 2000, 2000, 1, 1, 1, true);
        box.setMaterialToAllSurfaces(new FillMaterial(0x909090));
        box.geometry.upload(context);
        scene.addChild(box)

        for each (var res2:Resource in scene.getResources(true))
            res2.upload(context);

        gun = parser.getObjectByName("gun");
        fireMarker = parser.getObjectByName("fire");

        var materialLoader = new TexturesLoader(context);
        var resList = new <ExternalTextureResource>[];
        for each (var res:ExternalTextureResource in scene.getResources(true, ExternalTextureResource)) {
            res.url = res.url.replace(/atf/gi, "jpg");
            res.url = "particlesdemo/resources/" + res.url;
            resList.push(res);
        }
        materialLoader.loadResources(resList);
    }

    private function initScene():void {
        var ground:Box = new Box(1000, 1000, 1);
        ground.geometry.upload(context);
        var groundResource:BitmapTextureResource = new BitmapTextureResource(new EmbedBackground().bitmapData);
        var material = new TextureMaterial(groundResource);
        groundResource.upload(context);
        ground.setMaterialToAllSurfaces(material);
        scene.addChild(ground);


        var column:Box = new Box(40, 40, 300);
        column.geometry.upload(context);
        column.setMaterialToAllSurfaces(material);
        column.y = -500;
        column.x = -500;
        column.z = 150;
        scene.addChild(column);
        column = new Box(40, 40, 300);
        column.geometry.upload(context);
        column.setMaterialToAllSurfaces(material);
        column.y = 500;
        column.x = -500;
        column.z = 150;
        scene.addChild(column);
        column = new Box(40, 40, 300);
        column.geometry.upload(context);
        column.setMaterialToAllSurfaces(material);
        column.y = 500;
        column.x = 500;
        column.z = 150;
        scene.addChild(column);
        column = new Box(40, 40, 300);
        column.geometry.upload(context);
        column.setMaterialToAllSurfaces(material);
        column.y = -500;
        column.x = 500;
        column.z = 150;
        scene.addChild(column);
        var wall = new Box(30, 1000, 280);
        wall.geometry.upload(context);
        wall.setMaterialToAllSurfaces(material);
        wall.x = 500;
        wall.z = 140;
        scene.addChild(wall);

        wall = new Box(30, 1000, 280);
        wall.geometry.upload(context);
        wall.setMaterialToAllSurfaces(material);
        wall.x = -500;
        wall.z = 140;
        scene.addChild(wall);

        wall = new Box(1000, 30, 280);
        wall.geometry.upload(context);
        wall.setMaterialToAllSurfaces(material);
        wall.y = 500;
        wall.z = 140;
        scene.addChild(wall);

        wall = new Box(1000, 30, 280);
        wall.geometry.upload(context);
        wall.setMaterialToAllSurfaces(material);
        wall.y = -500;
        wall.z = 140;
        scene.addChild(wall);


        gun = new Object3D();
        scene.addChild(gun);

        var muzzle = new Box(100, 10, 10);
        muzzle.geometry.upload(context);
        muzzle.setMaterialToAllSurfaces(new FillMaterial(0x111111));
        muzzle.x = 50;
        muzzle.z = 75;
        gun.addChild(muzzle);
        var body = new GeoSphere(60);
        body.setMaterialToAllSurfaces(new FillMaterial(0x111111));
        body.geometry.upload(context);
        gun.addChild(body);

        var gun2:Box = new Box(4, 4, 4);
        gun2.geometry.upload(context);
        gun2.setMaterialToAllSurfaces(new FillMaterial(0x441111));
        gun2.y = -300;
        gun2.z = 45;
        scene.addChild(gun2);
    }

    private function initParticleSystem():void {
// Create Particle System - контейнер для всех систем частиц
        particleSystem = new ParticleSystem();
        particleSystem.gravity = new Vector3D(0, 0, -1);
        particleSystem.wind = new Vector3D(1, 0, 0);
        particleSystem.fogColor = 0x6688AA;
        particleSystem.fogMaxDensity = 0;
        particleSystem.fogNear = 100; //camera.nearClipping;
        particleSystem.fogFar = 1000; //camera.farClipping;
        scene.addChild(particleSystem);
    }

    private function initUI():void {
        var info:TextInfo = new TextInfo();
        info.x = 3;
        info.y = 3;
        info.write("Alternativa3D 8 mouse events test, " + Capabilities.version);
        info.write("WSAD and Arrows — move");
        info.write("Drag — look");
        info.write("Click — create explosion");
        info.write("Space — stop/play animation");
        info.write("Wheel and +/- — time shift");
        info.write("Q — quality");
        addChild(info);
        addChild(camera.diagram);
    }

    private function initParticleResources():void {
        smokiDiffuse.upload(context);
        smokiOpacity.upload(context);
        flamethrowerDiffuse.upload(context);
        flamethrowerOpacity.upload(context);
        fireDiffuse.upload(context);
        fireOpacity.upload(context);

        smokySmokeAtlas = new TextureAtlas(smokiDiffuse, smokiOpacity, 8, 8, 0, 16, 30, true);
        smokyFireAtlas = new TextureAtlas(smokiDiffuse, smokiOpacity, 8, 8, 16, 16, 30, true);
        smokyFlashAtlas = new TextureAtlas(smokiDiffuse, smokiOpacity, 8, 8, 32, 16, 30, true, 0.5, 0.5);
        smokyFragmentAtlas = new TextureAtlas(smokiDiffuse, smokiOpacity, 8, 8, 48, 8, 30, true);
        smokyGlowAtlas = new TextureAtlas(smokiDiffuse, smokiOpacity, 8, 8, 56, 1, 30, true);
        smokySparkAtlas = new TextureAtlas(smokiDiffuse, smokiOpacity, 8, 8, 57, 1, 30, true);
        smokyShotAtlas = new TextureAtlas(smokiDiffuse, smokiOpacity, 8, 8, 58, 1, 30, true);

        flamethrowerSmokeAtlas = new TextureAtlas(flamethrowerDiffuse, flamethrowerOpacity, 8, 8, 0, 16, 30, true);
        flamethrowerFlashAtlas = new TextureAtlas(flamethrowerDiffuse, flamethrowerOpacity, 8, 8, 16, 16, 60, true);
        flamethrowerFireAtlas = new TextureAtlas(flamethrowerDiffuse, flamethrowerOpacity, 8, 8, 32, 32, 60, false);

        fireSmokeAtlas = new TextureAtlas(fireDiffuse, fireOpacity, 8, 8, 0, 16, 30, true);
        fireFireAtlas = new TextureAtlas(fireDiffuse, fireOpacity, 8, 8, 16, 16, 30, true);
        fireFlameAtlas = new TextureAtlas(fireDiffuse, fireOpacity, 8, 8, 32, 32, 45, true, 0.5, 0.5);
    }


    private function onEnterFrame(e:Event = null):void {

//        if (mCoords != null) {
//            if (!pause) {
//                var fire:Fire = particleSystem.getEffectByName("fire") as Fire;
//                if (fire != null) {
//                    vector.x = mCoords.x;
//                    vector.y = mCoords.y;
//                    vector.z = mCoords.z + 20;
//                    fire.position = vector;
//                }

                var flamethrower:FlameThrower = particleSystem.getEffectByName("firebird") as FlameThrower;
                if (flamethrower != null) {
                    var shotOrigin:Vector3D = fireMarker.localToGlobal(new Vector3D(0, 0, 0));
                    var shotDirection:Vector3D = gun.localToGlobal(new Vector3D(fireMarker.x, fireMarker.y, fireMarker.z -gun.z));
                    flamethrower.direction = shotDirection;
                    flamethrower.position = shotOrigin;
                }
//
//      }
//        }
//        if (!pause)
//        controller.update();

        camera.startTimer();
        camera.render(stage3D);
        camera.stopTimer();
    }


    private function onKeyDown(e:KeyboardEvent):void {
        //trace(e.keyCode);
        switch (e.keyCode) {
            case  Keyboard.NUMBER_1:
                mode = 1;
                break;
            case  Keyboard.NUMBER_2:
                mode = 2;
                break;
            case  Keyboard.NUMBER_3:
                mode = 3;
                break;
            case  Keyboard.NUMBER_4:
                mode = 4;
                break;
            case  Keyboard.NUMBER_5:
                mode = 5;
                break;
            case 81: // Q
                if (camera.view.antiAlias == 0) {
                    camera.view.antiAlias = 8;
                } else {
                    camera.view.antiAlias = 0;
                }
                break;
            case 84: // T
                trace(camera.matrix.rawData);
                System.setClipboard(camera.matrix.rawData.toString());
                break;
            case 81:
                break;
            case Keyboard.TAB:
                camera.debug = !camera.debug;
                break;
            case Keyboard.ENTER:
                break;
            case 189:
            case 109:
                particleSystem.prevFrame();
                break;
            case 187:
            case 107:
                particleSystem.nextFrame();
                break;
            case Keyboard.SPACE:
                pause = !pause;
                if (pause) {
                    particleSystem.stop();
                } else {
                    particleSystem.play();
                }
                break;
        }
    }

    private function onResize(e:Event = null):void {
        camera.view.width = stage.stageWidth;
        camera.view.height = stage.stageHeight;
    }

    private function mouseDownHandler(e:MouseEvent3D):void {
        var shotOrigin:Vector3D = fireMarker.localToGlobal(new Vector3D(0, 0, 0));
        var shotDirection:Vector3D = gun.localToGlobal(new Vector3D(fireMarker.x, fireMarker.y, fireMarker.z -gun.z));
        var rayData:RayIntersectionData = scene.intersectRay(shotOrigin, shotDirection);
        var coords:Vector3D = rayData.object.localToGlobal(rayData.point);
        if (mode == 1) {
            var shot:SmokyShot = new SmokyShot(smokyShotAtlas);
            shot.position = shotOrigin;
            shot.direction = shotDirection;
            particleSystem.addEffect(shot);
            // Создание эффекта взрыва грома
            var explosion:TankExplosion = new TankExplosion(smokySmokeAtlas, smokyFireAtlas, smokyFlashAtlas, smokyGlowAtlas, smokySparkAtlas, smokyFragmentAtlas);
            explosion.position = coords;
            particleSystem.addEffect(explosion);
        } else if (mode == 2) {
            var shot:SmokyShot = new SmokyShot(smokyShotAtlas);
            shot.position = shotOrigin;
            shot.direction = shotDirection;
            particleSystem.addEffect(shot);
            // Создание эффекта взрыва смоки
            var smoky:SmokyExplosion = new SmokyExplosion(smokySmokeAtlas, smokyFireAtlas, smokyFlashAtlas, smokyGlowAtlas, smokySparkAtlas, smokyFragmentAtlas);
            smoky.scale = 0.6;
            smoky.position = coords;
            particleSystem.addEffect(smoky);
        }
        else if (mode == 3) {


        }
        else if (mode == 4) {

            var flamethrower:FlameThrower = new FlameThrower(flamethrowerSmokeAtlas, flamethrowerFireAtlas, flamethrowerFlashAtlas, 50);
            flamethrower.name = "firebird";
            flamethrower.position = shotOrigin;
            flamethrower.direction = shotDirection;
            particleSystem.addEffect(flamethrower);
        }
        else {
            var fire:Fire = new Fire(fireSmokeAtlas, fireFireAtlas, fireFlameAtlas, 5, true);
            fire.name = "fireMarker";
            fire.position = coords;
            particleSystem.addEffect(fire);
        }
    }

    private function mouseMoveHandler(e:MouseEvent):void {
        gun.rotationZ = - Math.PI * mouseX / stage.stageWidth + Math.PI / 2;
    }

    private function mouseWheelHandler(e:MouseEvent):void {
        if (e.delta > 0) {
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
            particleSystem.nextFrame();
        } else {
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
            particleSystem.prevFrame();
        }
    }

    private function mouseUpHandler(event:MouseEvent):void {
        var flamethrower:FlameThrower = particleSystem.getEffectByName("firebird") as FlameThrower;
        if (flamethrower != null) {
            flamethrower.stop();
        }
    }
}
}

import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

class TextInfo extends TextField {

    public function TextInfo() {
        autoSize = TextFieldAutoSize.LEFT;
        selectable = false;
        defaultTextFormat = new TextFormat("Tahoma", 10, 0xFFFFFF);
    }

    public function write(value:String):void {
        appendText(value + "\n");
    }

}
