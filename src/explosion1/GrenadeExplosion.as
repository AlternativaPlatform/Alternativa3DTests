package explosion1 {

	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.AnimSprite;
	import alternativa.engine3d.resources.BitmapTextureResource;

	import flash.display.BitmapData;
	import flash.system.System;

	public class GrenadeExplosion extends AnimSprite {

		private static function formatFixedInt(value:int, size:int):String {
			var result:String = value.toString();
			var prefix:String = "";
			for (var i:int = result.length; i < size; i++) prefix += "0";
			return prefix + result;
		}

		public static function generateMaterials(fileName:String, className:String, endIndex:int):void {
			var resultEmbeds:Array = [];
			var resultConstructor:Array = [];
			for (var i:int = 0; i <= endIndex; i++) {
				var currentClassName:String = className + formatFixedInt(i, 2);
				resultEmbeds[i] = '[Embed ("' + fileName + formatFixedInt(i, 5) + '.png")] private static const ' + currentClassName + ':Class;';
				resultConstructor[i] = 'materials.push(createTextureMaterial(' + currentClassName + '));';
			}
			var s:String = resultEmbeds.join("\n") + "\n\n" + resultConstructor.join("\n");
			System.setClipboard(s);
			trace(s);
		}

		[Embed ("Explosion00000.png")] private static const explosion00:Class;
		[Embed ("Explosion00001.png")] private static const explosion01:Class;
		[Embed ("Explosion00002.png")] private static const explosion02:Class;
		[Embed ("Explosion00003.png")] private static const explosion03:Class;
		[Embed ("Explosion00004.png")] private static const explosion04:Class;
		[Embed ("Explosion00005.png")] private static const explosion05:Class;
		[Embed ("Explosion00006.png")] private static const explosion06:Class;
		[Embed ("Explosion00007.png")] private static const explosion07:Class;
		[Embed ("Explosion00008.png")] private static const explosion08:Class;
		[Embed ("Explosion00009.png")] private static const explosion09:Class;
		[Embed ("Explosion00010.png")] private static const explosion10:Class;
		[Embed ("Explosion00011.png")] private static const explosion11:Class;
		[Embed ("Explosion00012.png")] private static const explosion12:Class;
		[Embed ("Explosion00013.png")] private static const explosion13:Class;
		[Embed ("Explosion00014.png")] private static const explosion14:Class;
		[Embed ("Explosion00015.png")] private static const explosion15:Class;
		[Embed ("Explosion00016.png")] private static const explosion16:Class;
		[Embed ("Explosion00017.png")] private static const explosion17:Class;
		[Embed ("Explosion00018.png")] private static const explosion18:Class;
		[Embed ("Explosion00019.png")] private static const explosion19:Class;
		[Embed ("Explosion00020.png")] private static const explosion20:Class;
		[Embed ("Explosion00021.png")] private static const explosion21:Class;
		[Embed ("Explosion00022.png")] private static const explosion22:Class;
		[Embed ("Explosion00023.png")] private static const explosion23:Class;
		[Embed ("Explosion00024.png")] private static const explosion24:Class;
		[Embed ("Explosion00025.png")] private static const explosion25:Class;
		[Embed ("Explosion00026.png")] private static const explosion26:Class;

		private var smoke:GrenadeSmoke;

		private var resources:Vector.<Resource> = new Vector.<Resource>();
		public function GrenadeExplosion() {
			smoke = new GrenadeSmoke();
//			smoke.x = -10;
			addChild(smoke);

			super(400, 400);
			alwaysOnTop = true;
//			this.originY = 1;

			var materials:Vector.<Material> = new Vector.<Material>();
			materials.push(createTextureMaterial(explosion00));
			materials.push(createTextureMaterial(explosion01));
			materials.push(createTextureMaterial(explosion02));
			materials.push(createTextureMaterial(explosion03));
			materials.push(createTextureMaterial(explosion04));
			materials.push(createTextureMaterial(explosion05));
			materials.push(createTextureMaterial(explosion06));
			materials.push(createTextureMaterial(explosion07));
			materials.push(createTextureMaterial(explosion08));
			materials.push(createTextureMaterial(explosion09));
			materials.push(createTextureMaterial(explosion10));
			materials.push(createTextureMaterial(explosion11));
			materials.push(createTextureMaterial(explosion12));
			materials.push(createTextureMaterial(explosion13));
			materials.push(createTextureMaterial(explosion14));
			materials.push(createTextureMaterial(explosion15));
			materials.push(createTextureMaterial(explosion16));
			materials.push(createTextureMaterial(explosion17));
			materials.push(createTextureMaterial(explosion18));
			materials.push(createTextureMaterial(explosion19));
			materials.push(createTextureMaterial(explosion20));
			materials.push(createTextureMaterial(explosion21));
			materials.push(createTextureMaterial(explosion22));
			materials.push(createTextureMaterial(explosion23));
			materials.push(createTextureMaterial(explosion24));
			materials.push(createTextureMaterial(explosion25));
			materials.push(createTextureMaterial(explosion26));
			this.materials = materials;
		}

		override public function set frame(value:int):void {
			super.frame = value;
			smoke.frame = value;
		}

		private function createTextureMaterial(asset:Class):Material {
		   var bdata:BitmapData = (new asset()).bitmapData;
			var resource:BitmapTextureResource = new BitmapTextureResource(bdata);
			var material:TextureMaterial = new TextureMaterial(resource);
			material.alphaThreshold = 1.1;
			resources.push(resource);
			return material;
		}

		override public function getResources(hierarchy:Boolean = false, resourceType:Class = null):Vector.<Resource> {
			var res:Vector.<Resource> = super.getResources(hierarchy, resourceType);
			var out:Vector.<Resource> = res.concat(resources);
			return (out);
		}

	}
}
