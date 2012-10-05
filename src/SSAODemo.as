package {

import alternativa.engine3d.animation.AnimationClip;
import alternativa.engine3d.animation.AnimationController;
import alternativa.engine3d.core.Camera3D;
import alternativa.engine3d.core.Light3D;
import alternativa.engine3d.core.Object3D;
import alternativa.engine3d.lights.AmbientLight;
import alternativa.engine3d.lights.DirectionalLight;
import alternativa.engine3d.loaders.ParserA3D;
import alternativa.engine3d.loaders.ParserMaterial;
import alternativa.engine3d.materials.StandardMaterial;
import alternativa.engine3d.objects.Mesh;
import alternativa.engine3d.objects.Surface;
import alternativa.engine3d.resources.BitmapTextureResource;
import alternativa.engine3d.shadows.DirectionalLightShadow;
import alternativa.utils.templates.DefaultSceneTemplate;
import alternativa.utils.templates.TextInfo;

import flash.display.BitmapData;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Matrix3D;
import flash.system.Capabilities;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.utils.getTimer;

[SWF(width=800, height=800, backgroundColor=0, frameRate=60)]
public class SSAODemo extends DefaultSceneTemplate {

    [Embed("resources/DemoScenaV2.A3D", mimeType="application/octet-stream")]
    private static const SceneClass:Class;
    [Embed("resources/bricks.jpg")]
    private static const WallClass:Class;
    [Embed("resources/roof_ed.jpg")]
    private static const RoofClass:Class;
    [Embed("resources/ground_N.jpg")]
    private static const GroundClass:Class;
//		[Embed ("resources/609-normal.jpg")] private static const NormalClass:Class;

    private var animation:AnimationController;
    private var _animated:Boolean = true;
    private var _animationRewind:Boolean = false;
    private var _animationDirection:Boolean = true;

    private var displayText:TextField;

    private var light:DirectionalLight;
    private var shadow:DirectionalLightShadow;

    private var ssaoVisible:Boolean = true;

    public function SSAODemo() {
    }

    override protected function initScene():void {
        stage.frameRate = 40;
        stage.color = 0x146298;
        mainCamera.view.backgroundColor = 0x146298;
        displayText = new TextField();
        displayText.defaultTextFormat = new TextFormat("Tahoma", 15, 0x0);
        displayText.text = "";
        displayText.autoSize = TextFieldAutoSize.LEFT;
        displayText.selectable = false;
        addChild(displayText);

        var info:TextInfo = new TextInfo();
        info.x = 10;
        info.y = 10;
        info.text = "Alternativa3D SSAO Demo, " + Capabilities.version + "\n";
        info.write("WSAD and Arrows — move");
        info.write("Q — quality low/high");
        info.write("----");

        // Режимы дебага
        info.write("1 — default mode");
        info.write("2 — raw SSAO mode");
        info.write("3 — z-buffer mode");
        info.write("4 — screen-space normals mode");
        info.write("----");

        // Переключение теней, SSAO, проходок
        info.write("U — toggle SSAO on/off");
        info.write("I — toggle shadows on/off");
        info.write("O — toggle SSAO second pass on/off");
        info.write("Space — animation play/pause");
        info.write("R — rewind animation");
        info.write("----");

        // Настройка SSAO
        info.write("+/- — SSAO intensity");
        info.write("PG_Up/PG_Down — SSAO first pass size");
        info.write("Insert/Delete — SSAO second pass intensity");
        info.write("Home/End- — SSAO second pass size");
        addChild(info);

        graphics.beginFill(0x0, 0.3);
        graphics.drawRoundRect(3, 3, info.textWidth + 20, info.textHeight + 20, 20, 20);

        var parser:ParserA3D = new ParserA3D();
        parser.parse(new SceneClass());

//			var texture:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1, 1, false, 0x7F7F7F));
//			var texture:BitmapTextureResource = new BitmapTextureResource((new TextureClass()).bitmapData);
        var wall:BitmapTextureResource = new BitmapTextureResource((new WallClass()).bitmapData);
        var roof:BitmapTextureResource = new BitmapTextureResource((new RoofClass()).bitmapData, true);
        var ground:BitmapTextureResource = new BitmapTextureResource((new GroundClass()).bitmapData, true);
        var normal:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1, 1, false, 0x7F7FFF));
//			var normal:BitmapTextureResource = new BitmapTextureResource(new NormalClass().bitmapData);

        shadow = new DirectionalLightShadow(150, 120, -130, 130, 512, 1);
//			shadow.debug = true;
        shadow.biasMultiplier = 0.99;

//			var defaultMaterial:StandardMaterial = new StandardMaterial(texture, normal);
//			defaultMaterial.specularPower = 0.1;
        var roofMaterial:StandardMaterial = new StandardMaterial(roof, normal);
        roofMaterial.specularPower = 0.1;
        var wallMaterial:StandardMaterial = new StandardMaterial(wall, normal);
        wallMaterial.specularPower = 0.1;
        var groundMaterial:StandardMaterial = new StandardMaterial(ground, normal);
        groundMaterial.specularPower = 0.1;

        var i:int;
        var object:Object3D;
        for (i = 0; i < parser.objects.length; i++) {
            object = parser.objects[i];
            if (object is Light3D) continue;
            var mesh:Mesh = object as Mesh;
            if (mesh != null) {
                for (var s:int = 0; s < mesh.numSurfaces; s++) {
                    var surface:Surface = mesh.getSurface(s);
                    var id:String = ParserMaterial(surface.material).textures["diffuse"].url;
                    if (id != null && id.toLowerCase().indexOf("roof") >= 0) {
                        surface.material = roofMaterial;
                    } else if (id != null && id.toLowerCase().indexOf("bricks") >= 0) {
                        surface.material = wallMaterial;
                    } else if (id != null && id.toLowerCase().indexOf("ground") >= 0) {
                        surface.material = groundMaterial;
                    } else {
                        trace("unknown texture: '" + id + "'");
                    }
//						surface.material = defaultMaterial;
                }
            }
        }

        for (i = 0; i < parser.hierarchy.length; i++) {
            object = parser.hierarchy[i];
            if (!(object is Light3D)) {
                scene.addChild(object);
                shadow.addCaster(object);
            }
        }

        var clip:AnimationClip = parser.animations[0];
        clip.loop = false;
        clip.attach(scene, true);
        animation = new AnimationController();
        animation.root = clip;

//			_animated = false;
        animation.freeze();
        _animationDirection = false;
        animationStartTime = getTimer() + 2000;

        var ambient:AmbientLight = new AmbientLight(0x8bccfa);
        ambient.intensity = 0.5;
        scene.addChild(ambient);

        light = new DirectionalLight(0xffd98f);
        light.intensity = 1.2;
        light.z = 100;
        light.x = 100;
        light.y = -100;
        light.lookAt(0, 0, 0);
        scene.addChild(light);

//			shadow.debug = true;
        light.shadow = shadow;

        controller.speed = 40;
        mainCamera.nearClipping = 1;
        mainCamera.farClipping = 500;
        mainCamera.matrix = new Matrix3D(Vector.<Number>([-0.2912704050540924, 0.9566407799720764, 0, 0, -0.4682687222957611, -0.1425747573375702, -0.8720073699951172, 0, -0.8341978192329407, -0.25398993492126465, 0.4894927442073822, 0, 52.13594436645508, 19.32925796508789, 3.971318483352661, 1]));
        controller.updateObjectTransform();

        mainCamera.effectMode = Camera3D.MODE_SSAO_COLOR;
        mainCamera.ssaoAngular.angleBias = 0.1;
        mainCamera.ssaoAngular.size = 0.6843;
        mainCamera.ssaoAngular.maxDistance = 1;
        mainCamera.ssaoAngular.intensity = 0.85;
        mainCamera.ssaoAngular.falloff = 7.2;
        mainCamera.ssaoAngular.secondPassIntensity = 0.76;
        mainCamera.ssaoAngular.secondPassSize = 0.32;
    }

    override protected function onKeyDown(event:KeyboardEvent):void {
        super.onKeyDown(event);
        switch (event.keyCode) {
            case Keyboard.NUMBER_1:
                mainCamera.effectMode = ssaoVisible ? Camera3D.MODE_SSAO_COLOR : Camera3D.MODE_COLOR;
                updateParameter("Normal render mode");
                break;
            case Keyboard.NUMBER_2:
                mainCamera.effectMode = Camera3D.MODE_SSAO_ONLY;
                updateParameter("Raw SSAO render mode");
                break;
            case Keyboard.NUMBER_3:
                mainCamera.effectMode = Camera3D.MODE_DEPTH;
                updateParameter("Z-buffer render mode");
                break;
            case Keyboard.NUMBER_4:
                mainCamera.effectMode = Camera3D.MODE_NORMALS;
                updateParameter("Screen-space normals render mode");
                break;
            case Keyboard.SPACE:
                switchPause();
                break;
            case Keyboard.R:
                _animationRewind = true;
                animationStartTime = -1;
                break;
            case Keyboard.Q:
                mainCamera.view.antiAlias = (mainCamera.view.antiAlias == 0) ? 4 : 0;
                if (mainCamera.view.antiAlias == 0) {
                    // low
                    mainCamera.ssaoScale = 1;
                    updateParameter("Quality low");
                } else {
                    mainCamera.ssaoScale = 0;
                    updateParameter("Quality high");
                }
                break;
            case Keyboard.EQUAL:
            case Keyboard.NUMPAD_ADD:
                increaseSSAOIntensity(event.shiftKey);
                break;
            case Keyboard.MINUS:
            case Keyboard.NUMPAD_SUBTRACT:
                decreaseSSAOIntensity(event.shiftKey);
                break;
            case Keyboard.INSERT:
                increaseSSAOSecondPassIntensity(event.shiftKey);
                break;
            case Keyboard.DELETE:
                decreaseSSAOSecondPassIntensity(event.shiftKey);
                break;
            case  Keyboard.PAGE_UP:
                mainCamera.ssaoAngular.size += (event.shiftKey) ? 0.01 : 0.1;
                updateParameter("SSAO first pass size : " + mainCamera.ssaoAngular.size.toFixed(2));
                break;
            case  Keyboard.PAGE_DOWN:
                mainCamera.ssaoAngular.size -= (event.shiftKey) ? 0.01 : 0.1;
                mainCamera.ssaoAngular.size = mainCamera.ssaoAngular.size <= 0.3 ? 0.3 : mainCamera.ssaoAngular.size;
                updateParameter("SSAO first pass size : " + mainCamera.ssaoAngular.size.toFixed(2));
                break;
            case Keyboard.HOME:
                mainCamera.ssaoAngular.secondPassSize += (event.shiftKey) ? 0.01 : 0.05;
                updateParameter("Second pass size : " + mainCamera.ssaoAngular.secondPassSize.toFixed(2));
                break;
            case Keyboard.END:
                mainCamera.ssaoAngular.secondPassSize -= (event.shiftKey) ? 0.01 : 0.05;
                mainCamera.ssaoAngular.secondPassSize = mainCamera.ssaoAngular.secondPassSize <= 0.3 ? 0.3 : mainCamera.ssaoAngular.secondPassSize;
                updateParameter("Second pass size : " + mainCamera.ssaoAngular.secondPassSize.toFixed(2));
                break;
            case Keyboard.NUMPAD_MULTIPLY:
                mainCamera.ssaoAngular.angleBias += (event.shiftKey) ? 0.001 : 0.01;
                updateParameter("SSAO angle bias : " + mainCamera.ssaoAngular.angleBias.toFixed(3));
                break;
            case Keyboard.NUMPAD_DIVIDE:
                mainCamera.ssaoAngular.angleBias -= (event.shiftKey) ? 0.001 : 0.01;
                updateParameter("SSAO angle bias : " + mainCamera.ssaoAngular.angleBias.toFixed(3));
                break;
            case Keyboard.PERIOD:
                mainCamera.ssaoAngular.maxDistance += (event.shiftKey) ? 0.01 : 0.1;
                updateParameter("SSAO max distance : " + mainCamera.ssaoAngular.maxDistance.toFixed(2));
                break;
            case Keyboard.COMMA:
                mainCamera.ssaoAngular.maxDistance -= (event.shiftKey) ? 0.01 : 0.1;
                updateParameter("SSAO max distance : " + mainCamera.ssaoAngular.maxDistance.toFixed(2));
                break;
            case Keyboard.NUMBER_9:
                mainCamera.ssaoAngular.falloff += (event.shiftKey) ? 0.01 : 0.1;
                updateParameter("SSAO distance falloff : " + mainCamera.ssaoAngular.falloff.toFixed(2));
                break;
            case Keyboard.NUMBER_0:
                mainCamera.ssaoAngular.falloff -= (event.shiftKey) ? 0.01 : 0.1;
                updateParameter("SSAO distance falloff : " + mainCamera.ssaoAngular.falloff.toFixed(2));
                break;
//				case Keyboard.LEFTBRACKET:
//					mainCamera.depthScale++;
//					break;
//				case Keyboard.RIGHTBRACKET:
//					mainCamera.depthScale--;
//					break;
//				case Keyboard.SEMICOLON:
//					mainCamera.ssaoScale++;
//					break;
//				case Keyboard.QUOTE:
//					mainCamera.ssaoScale--;
//					break;
            case Keyboard.U:
                if (mainCamera.effectMode == Camera3D.MODE_COLOR || mainCamera.effectMode == Camera3D.MODE_SSAO_COLOR) {
                    ssaoVisible = !ssaoVisible;
                    mainCamera.effectMode = (ssaoVisible ? Camera3D.MODE_SSAO_COLOR : Camera3D.MODE_COLOR);
                    updateParameter("SSAO " + (ssaoVisible ? "enabled" : "disabled"));
                }
                break;
            case Keyboard.O:
                mainCamera.ssaoAngular.hQuality = !mainCamera.ssaoAngular.hQuality;
                updateParameter("SSAO second pass " + (mainCamera.ssaoAngular.hQuality ? "enabled" : "disabled"));
                break;
            case Keyboard.I:
                light.shadow = (light.shadow == shadow) ? null : shadow;
                updateParameter("Shadows " + (light.shadow != null ? "enabled" : "disabled"));
                break;
            case Keyboard.B:
                mainCamera.blurEnabled = !mainCamera.blurEnabled;
                updateParameter("SSAO blur " + (mainCamera.blurEnabled ? "enabled" : "disabled"));
                break;
        }
    }


    private function increaseSSAOSecondPassIntensity(boosted:Boolean):void {
        mainCamera.ssaoAngular.secondPassIntensity += (boosted) ? 0.005 : 0.02;
        updateParameter("Second pass intensity : " + mainCamera.ssaoAngular.secondPassIntensity.toFixed(2));
    }

    private function decreaseSSAOSecondPassIntensity(boosted:Boolean):void {
        mainCamera.ssaoAngular.secondPassIntensity -= (boosted) ? 0.005 : 0.02;
        mainCamera.ssaoAngular.secondPassIntensity = mainCamera.ssaoAngular.secondPassIntensity <= 0 ? 0 : mainCamera.ssaoAngular.secondPassIntensity;
        updateParameter("Second pass intensity : " + mainCamera.ssaoAngular.secondPassIntensity.toFixed(2));
    }

    private function decreaseSSAOIntensity(boosted:Boolean):void {
        mainCamera.ssaoAngular.intensity -= (boosted) ? 0.01 : 0.05;
        mainCamera.ssaoAngular.intensity = mainCamera.ssaoAngular.intensity <= 0 ? 0 : mainCamera.ssaoAngular.intensity;
        updateParameter("SSAO intensity : " + mainCamera.ssaoAngular.intensity.toFixed(2));
    }

    private function increaseSSAOIntensity(boosted:Boolean):void {
        mainCamera.ssaoAngular.intensity += (boosted) ? 0.01 : 0.05;
        updateParameter("SSAO intensity : " + mainCamera.ssaoAngular.intensity.toFixed(2));
    }

    private function switchPause():void {
        _animated = !_animated;
        animation.freeze();
        animationStartTime = -1;
    }

    override protected function onKeyUp(event:KeyboardEvent):void {
        super.onKeyUp(event);
        if (event.keyCode == Keyboard.R) {
            _animationRewind = false;
            animation.freeze();
        }
    }

    private function updateParameter(text:String):void {
        var color:uint = (mainCamera.effectMode == Camera3D.MODE_COLOR || mainCamera.effectMode == Camera3D.MODE_SSAO_COLOR || mainCamera.effectMode == Camera3D.MODE_NORMALS) ? 0xFFFFFF : 0x0;

        displayText.defaultTextFormat = new TextFormat("Tahoma", 15, color);
        displayText.text = text;
        displayText.x = (stage.stageWidth - displayText.textWidth) >> 1;
    }

    private var animationStartTime:int = -1;

    override protected function onEnterFrame(e:Event):void {
        if (animation.root is AnimationClip) {
            if (animationStartTime == -1) {
                // check if stopped
                if ((_animationDirection && AnimationClip(animation.root).time >= AnimationClip(animation.root).length) || (!_animationDirection && AnimationClip(animation.root).time <= 0)) {
                    animationStartTime = getTimer() + 3000;
                }
            }
            AnimationClip(animation.root).speed = (_animationRewind || !_animationDirection) ? -0.6 : 0.3;
            if (animationStartTime != -1 && animationStartTime <= getTimer()) {
                animationStartTime = -1;
                _animationDirection = !_animationDirection;
            }
        }
        if (_animated || _animationRewind) animation.update();
        super.onEnterFrame(e);
    }

    override protected function onResize(event:Event = null):void {
        super.onResize(event);
        updateParameter(displayText.text);
    }

}
}
