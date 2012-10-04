package {

	import alternativa.engine3d.animation.AnimationClip;
	import alternativa.engine3d.animation.AnimationController;
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

	[SWF (width = 800, height = 800, backgroundColor = 0, frameRate = 60)]
	public class SSAODemo extends DefaultSceneTemplate {
		
//		[Embed ("resources/t2.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/Scena.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/ScenaSmooth.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/Animation1.a3d", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/AnimationTower.a3d", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/AnimationCastl3.a3d", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/castle.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/exportFix1.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/exportFix2.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/exportFix4.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/Scena2.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/1.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/scena.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/DemoScena.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
		[Embed ("resources/DemoScenaV2.A3D", mimeType="application/octet-stream")] private static const SceneClass:Class;
//		[Embed ("resources/wall.jpg")] private static const WallClass:Class;
		[Embed ("resources/bricks.jpg")] private static const WallClass:Class;
		[Embed ("resources/roof_ed.jpg")] private static const RoofClass:Class;
//		[Embed ("resources/ground.jpg")] private static const GroundClass:Class;
//		[Embed ("resources/industrial30.jpg")] private static const GroundClass:Class;
		[Embed ("resources/ground_N.jpg")] private static const GroundClass:Class;
		[Embed ("resources/609-normal.jpg")] private static const NormalClass:Class;

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
			// TODO: планка, которая будет удалять объекты
			// TODO: test context lost

			stage.frameRate = 40;
			stage.color = 0x146298;
			mainCamera.view.backgroundColor = 0x146298;
			displayText = new TextField();
//			displayText.y = 0;
//			displayText.x = 300;
//			displayText.defaultTextFormat = new TextFormat("Tahoma", 16, 0xe4f617);
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

			var texture:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1, 1, false, 0x7F7F7F));
//			var texture:BitmapTextureResource = new BitmapTextureResource((new TextureClass()).bitmapData);
			var wall:BitmapTextureResource = new BitmapTextureResource((new WallClass()).bitmapData);
			var roof:BitmapTextureResource = new BitmapTextureResource((new RoofClass()).bitmapData, true);
			var ground:BitmapTextureResource = new BitmapTextureResource((new GroundClass()).bitmapData, true);
			var normal:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1, 1, false, 0x7F7FFF));
//			var normal:BitmapTextureResource = new BitmapTextureResource(new NormalClass().bitmapData);

			shadow = new DirectionalLightShadow(150, 120, -130, 130, 512, 1);
//			shadow.debug = true;
			shadow.biasMultiplier = 0.99;

			var defaultMaterial:StandardMaterial = new StandardMaterial(texture, normal);
			defaultMaterial.specularPower = 0.1;
			var roofMaterial:StandardMaterial = new StandardMaterial(roof, normal);
			roofMaterial.specularPower = 0.1;
			var wallMaterial:StandardMaterial = new StandardMaterial(wall, normal);
			wallMaterial.specularPower = 0.1;
//			wallMaterial.specularPower = 0;
			var groundMaterial:StandardMaterial = new StandardMaterial(ground, normal);
			groundMaterial.specularPower = 0.1;

			var i:int;
			var object:Object3D;
			for (i = 0; i < parser.objects.length; i++) {
				object = parser.objects[i];
//				if (object is Light3D) trace(AmbientLight(object).color);
				if (object is Light3D) continue;
				var mesh:Mesh = object as Mesh;
				if (mesh != null) {
					for (var s:int = 0; s < mesh.numSurfaces; s++) {
						var surface:Surface = mesh.getSurface(s);
						var id:String = ParserMaterial(surface.material).textures["diffuse"].url;
						if (id != null && id.toLowerCase().indexOf("roof") >= 0) {
							surface.material = roofMaterial;
//						} else if (id != null && id.toLowerCase().indexOf("wall") >= 0) {
						} else if (id != null && id.toLowerCase().indexOf("bricks") >= 0) {
							surface.material = wallMaterial;
						} else if (id != null && id.toLowerCase().indexOf("ground") >= 0) {
//						} else if (id != null && id.toLowerCase().indexOf("industrial") >= 0) {
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
//			scene.addChild(new AmbientLight(0xa9d8fa));

			light = new DirectionalLight(0xffd98f);
//			light = new DirectionalLight(0xfffdd9);
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
//			mainCamera.matrix = new Matrix3D(Vector.<Number>([0.9182113409042358,0.3960908055305481,0,0,0.14704886078834534,-0.34088632464408875,-0.9285327792167664,0,-0.3677832782268524,0.8525893688201904,-0.3712503910064697,0,151.55484008789063,-278.99462890625,154.45816040039063,1]))
//			mainCamera.matrix = new Matrix3D(Vector.<Number>([-0.40568453073501587,0.914013147354126,0,0,0.0684163048863411,0.03036656230688095,-0.9971945881843567,0,-0.9114490151405334,-0.4045464098453522,-0.07485264539718628,0,73.39246368408203,34.63690185546875,24.260700225830078,1]));
//			mainCamera.matrix = new Matrix3D(Vector.<Number>([0.4888644218444824,0.8723597526550293,0,0,0.1812659054994583,-0.1015801727771759,-0.9781738519668579,0,-0.853319525718689,0.4781944155693054,-0.20778802037239075,0,63.26726531982422,-31.06317710876465,30.54627799987793,1]));			controller.updateObjectTransform();
			mainCamera.matrix = new Matrix3D(Vector.<Number>([-0.2912704050540924,0.9566407799720764,0,0,-0.4682687222957611,-0.1425747573375702,-0.8720073699951172,0,-0.8341978192329407,-0.25398993492126465,0.4894927442073822,0,52.13594436645508,19.32925796508789,3.971318483352661,1]));
			controller.updateObjectTransform();

			mainCamera.effectMode = 9;
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
					mainCamera.effectMode = ssaoVisible ? 9 : 0;
					updateParameter("Normal render mode");
					break;
				case Keyboard.NUMBER_2:
					mainCamera.effectMode = 8;
					updateParameter("Raw SSAO render mode");
					break;
				case Keyboard.NUMBER_3:
					mainCamera.effectMode = 2;
					updateParameter("Z-buffer render mode");
					break;
				case Keyboard.NUMBER_4:
					mainCamera.effectMode = 3;
					updateParameter("Screen-space normals render mode");
					break;
				case Keyboard.SPACE:
					_animated = !_animated;
					animation.freeze();
					animationStartTime = -1;
					break;
				case Keyboard.R:
//					animation.root.speed = (animation.root.speed == 1) ? -1 : 1;
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
					mainCamera.ssaoAngular.intensity += (event.shiftKey) ? 0.01 : 0.05;
					updateParameter("SSAO intensity : " + mainCamera.ssaoAngular.intensity.toFixed(2));
					break;
				case Keyboard.MINUS:
				case Keyboard.NUMPAD_SUBTRACT:
					mainCamera.ssaoAngular.intensity -= (event.shiftKey) ? 0.01 : 0.05;
					mainCamera.ssaoAngular.intensity = mainCamera.ssaoAngular.intensity <= 0 ? 0 : mainCamera.ssaoAngular.intensity;
					updateParameter("SSAO intensity : " + mainCamera.ssaoAngular.intensity.toFixed(2));
					break;
				case Keyboard.INSERT:
					mainCamera.ssaoAngular.secondPassIntensity += (event.shiftKey) ? 0.005 : 0.02;
					updateParameter("Second pass intensity : " + mainCamera.ssaoAngular.secondPassIntensity.toFixed(2));
					break;
				case Keyboard.DELETE:
					mainCamera.ssaoAngular.secondPassIntensity -= (event.shiftKey) ? 0.005 : 0.02;
					mainCamera.ssaoAngular.secondPassIntensity = mainCamera.ssaoAngular.secondPassIntensity <= 0 ? 0 : mainCamera.ssaoAngular.secondPassIntensity;
					updateParameter("Second pass intensity : " + mainCamera.ssaoAngular.secondPassIntensity.toFixed(2));
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
					if (mainCamera.effectMode == 0 || mainCamera.effectMode == 9) {
						ssaoVisible = !ssaoVisible;
//						mainCamera.effectMode = (mainCamera.effectMode == 0 || mainCamera.effectMode == 9) ? (ssaoVisible ? 9 : 0) : mainCamera.effectMode;
						mainCamera.effectMode = (ssaoVisible ? 9 : 0);
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

		override protected function onKeyUp(event:KeyboardEvent):void {
			super.onKeyUp(event);
			if (event.keyCode == Keyboard.R) {
				_animationRewind = false;
				animation.freeze();
			}
		}

		private function updateParameter(text:String):void {
			var color:uint = (mainCamera.effectMode == 0 || mainCamera.effectMode == 9 || mainCamera.effectMode == 3) ? 0xFFFFFF : 0x0;

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
