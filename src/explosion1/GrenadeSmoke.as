package explosion1 {

	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.AnimSprite;
	import alternativa.engine3d.resources.BitmapTextureResource;

	import flash.display.BitmapData;
	import flash.system.System;

	public class GrenadeSmoke extends AnimSprite {

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

/*
		[Embed ("Expl_Smoke00000_00000.png")] private static const smoke00:Class;
		[Embed ("Expl_Smoke00000_00001.png")] private static const smoke01:Class;
		[Embed ("Expl_Smoke00000_00002.png")] private static const smoke02:Class;
		[Embed ("Expl_Smoke00000_00003.png")] private static const smoke03:Class;
		[Embed ("Expl_Smoke00000_00004.png")] private static const smoke04:Class;
		[Embed ("Expl_Smoke00000_00005.png")] private static const smoke05:Class;
		[Embed ("Expl_Smoke00000_00006.png")] private static const smoke06:Class;
		[Embed ("Expl_Smoke00000_00007.png")] private static const smoke07:Class;
		[Embed ("Expl_Smoke00000_00008.png")] private static const smoke08:Class;
		[Embed ("Expl_Smoke00000_00009.png")] private static const smoke09:Class;
		[Embed ("Expl_Smoke00000_00010.png")] private static const smoke10:Class;
		[Embed ("Expl_Smoke00000_00011.png")] private static const smoke11:Class;
		[Embed ("Expl_Smoke00000_00012.png")] private static const smoke12:Class;
		[Embed ("Expl_Smoke00000_00013.png")] private static const smoke13:Class;
		[Embed ("Expl_Smoke00000_00014.png")] private static const smoke14:Class;
		[Embed ("Expl_Smoke00000_00015.png")] private static const smoke15:Class;
		[Embed ("Expl_Smoke00000_00016.png")] private static const smoke16:Class;
		[Embed ("Expl_Smoke00000_00017.png")] private static const smoke17:Class;
		[Embed ("Expl_Smoke00000_00018.png")] private static const smoke18:Class;
		[Embed ("Expl_Smoke00000_00019.png")] private static const smoke19:Class;
		[Embed ("Expl_Smoke00000_00020.png")] private static const smoke20:Class;
		[Embed ("Expl_Smoke00000_00021.png")] private static const smoke21:Class;
		[Embed ("Expl_Smoke00000_00022.png")] private static const smoke22:Class;
		[Embed ("Expl_Smoke00000_00023.png")] private static const smoke23:Class;
		[Embed ("Expl_Smoke00000_00024.png")] private static const smoke24:Class;
		[Embed ("Expl_Smoke00000_00025.png")] private static const smoke25:Class;
		[Embed ("Expl_Smoke00000_00026.png")] private static const smoke26:Class;
		[Embed ("Expl_Smoke00000_00027.png")] private static const smoke27:Class;
		[Embed ("Expl_Smoke00000_00028.png")] private static const smoke28:Class;
		[Embed ("Expl_Smoke00000_00029.png")] private static const smoke29:Class;
		[Embed ("Expl_Smoke00000_00030.png")] private static const smoke30:Class;
		[Embed ("Expl_Smoke00000_00031.png")] private static const smoke31:Class;
		[Embed ("Expl_Smoke00000_00032.png")] private static const smoke32:Class;
		[Embed ("Expl_Smoke00000_00033.png")] private static const smoke33:Class;
		[Embed ("Expl_Smoke00000_00034.png")] private static const smoke34:Class;
		[Embed ("Expl_Smoke00000_00035.png")] private static const smoke35:Class;
		[Embed ("Expl_Smoke00000_00036.png")] private static const smoke36:Class;
		[Embed ("Expl_Smoke00000_00037.png")] private static const smoke37:Class;
		[Embed ("Expl_Smoke00000_00038.png")] private static const smoke38:Class;
		[Embed ("Expl_Smoke00000_00039.png")] private static const smoke39:Class;
		[Embed ("Expl_Smoke00000_00040.png")] private static const smoke40:Class;
		[Embed ("Expl_Smoke00000_00041.png")] private static const smoke41:Class;
*/

		[Embed ("Expl_SmokeBlack00000_00000.png")] private static const smoke00:Class;
		[Embed ("Expl_SmokeBlack00000_00001.png")] private static const smoke01:Class;
		[Embed ("Expl_SmokeBlack00000_00002.png")] private static const smoke02:Class;
		[Embed ("Expl_SmokeBlack00000_00003.png")] private static const smoke03:Class;
		[Embed ("Expl_SmokeBlack00000_00004.png")] private static const smoke04:Class;
		[Embed ("Expl_SmokeBlack00000_00005.png")] private static const smoke05:Class;
		[Embed ("Expl_SmokeBlack00000_00006.png")] private static const smoke06:Class;
		[Embed ("Expl_SmokeBlack00000_00007.png")] private static const smoke07:Class;
		[Embed ("Expl_SmokeBlack00000_00008.png")] private static const smoke08:Class;
		[Embed ("Expl_SmokeBlack00000_00009.png")] private static const smoke09:Class;
		[Embed ("Expl_SmokeBlack00000_00010.png")] private static const smoke10:Class;
		[Embed ("Expl_SmokeBlack00000_00011.png")] private static const smoke11:Class;
		[Embed ("Expl_SmokeBlack00000_00012.png")] private static const smoke12:Class;
		[Embed ("Expl_SmokeBlack00000_00013.png")] private static const smoke13:Class;
		[Embed ("Expl_SmokeBlack00000_00014.png")] private static const smoke14:Class;
		[Embed ("Expl_SmokeBlack00000_00015.png")] private static const smoke15:Class;
		[Embed ("Expl_SmokeBlack00000_00016.png")] private static const smoke16:Class;
		[Embed ("Expl_SmokeBlack00000_00017.png")] private static const smoke17:Class;
		[Embed ("Expl_SmokeBlack00000_00018.png")] private static const smoke18:Class;
		[Embed ("Expl_SmokeBlack00000_00019.png")] private static const smoke19:Class;
		[Embed ("Expl_SmokeBlack00000_00020.png")] private static const smoke20:Class;
		[Embed ("Expl_SmokeBlack00000_00021.png")] private static const smoke21:Class;
		[Embed ("Expl_SmokeBlack00000_00022.png")] private static const smoke22:Class;
		[Embed ("Expl_SmokeBlack00000_00023.png")] private static const smoke23:Class;
		[Embed ("Expl_SmokeBlack00000_00024.png")] private static const smoke24:Class;
		[Embed ("Expl_SmokeBlack00000_00025.png")] private static const smoke25:Class;
		[Embed ("Expl_SmokeBlack00000_00026.png")] private static const smoke26:Class;
		[Embed ("Expl_SmokeBlack00000_00027.png")] private static const smoke27:Class;
		[Embed ("Expl_SmokeBlack00000_00028.png")] private static const smoke28:Class;
		[Embed ("Expl_SmokeBlack00000_00029.png")] private static const smoke29:Class;
		[Embed ("Expl_SmokeBlack00000_00030.png")] private static const smoke30:Class;
		[Embed ("Expl_SmokeBlack00000_00031.png")] private static const smoke31:Class;
		[Embed ("Expl_SmokeBlack00000_00032.png")] private static const smoke32:Class;
		[Embed ("Expl_SmokeBlack00000_00033.png")] private static const smoke33:Class;
		[Embed ("Expl_SmokeBlack00000_00034.png")] private static const smoke34:Class;
		[Embed ("Expl_SmokeBlack00000_00035.png")] private static const smoke35:Class;
		[Embed ("Expl_SmokeBlack00000_00036.png")] private static const smoke36:Class;
		[Embed ("Expl_SmokeBlack00000_00037.png")] private static const smoke37:Class;
		[Embed ("Expl_SmokeBlack00000_00038.png")] private static const smoke38:Class;
		[Embed ("Expl_SmokeBlack00000_00039.png")] private static const smoke39:Class;
		[Embed ("Expl_SmokeBlack00000_00040.png")] private static const smoke40:Class;
		[Embed ("Expl_SmokeBlack00000_00041.png")] private static const smoke41:Class;

		private var resources:Vector.<Resource> = new Vector.<Resource>();
		public function GrenadeSmoke() {
			super(400, 400);
			alwaysOnTop = true;
//			this.originY = 1;

			var materials:Vector.<Material> = new Vector.<Material>();
			materials.push(createTextureMaterial(smoke00));
			materials.push(createTextureMaterial(smoke01));
			materials.push(createTextureMaterial(smoke02));
			materials.push(createTextureMaterial(smoke03));
			materials.push(createTextureMaterial(smoke04));
			materials.push(createTextureMaterial(smoke05));
			materials.push(createTextureMaterial(smoke06));
			materials.push(createTextureMaterial(smoke07));
			materials.push(createTextureMaterial(smoke08));
			materials.push(createTextureMaterial(smoke09));
			materials.push(createTextureMaterial(smoke10));
			materials.push(createTextureMaterial(smoke11));
			materials.push(createTextureMaterial(smoke12));
			materials.push(createTextureMaterial(smoke13));
			materials.push(createTextureMaterial(smoke14));
			materials.push(createTextureMaterial(smoke15));
			materials.push(createTextureMaterial(smoke16));
			materials.push(createTextureMaterial(smoke17));
			materials.push(createTextureMaterial(smoke18));
			materials.push(createTextureMaterial(smoke19));
			materials.push(createTextureMaterial(smoke20));
			materials.push(createTextureMaterial(smoke21));
			materials.push(createTextureMaterial(smoke22));
			materials.push(createTextureMaterial(smoke23));
			materials.push(createTextureMaterial(smoke24));
			materials.push(createTextureMaterial(smoke25));
			materials.push(createTextureMaterial(smoke26));
			materials.push(createTextureMaterial(smoke27));
			materials.push(createTextureMaterial(smoke28));
			materials.push(createTextureMaterial(smoke29));
			materials.push(createTextureMaterial(smoke30));
			materials.push(createTextureMaterial(smoke31));
			materials.push(createTextureMaterial(smoke32));
			materials.push(createTextureMaterial(smoke33));
			materials.push(createTextureMaterial(smoke34));
			materials.push(createTextureMaterial(smoke35));
			materials.push(createTextureMaterial(smoke36));
			materials.push(createTextureMaterial(smoke37));
			materials.push(createTextureMaterial(smoke38));
			materials.push(createTextureMaterial(smoke39));
			materials.push(createTextureMaterial(smoke40));
			materials.push(createTextureMaterial(smoke41));
			this.materials = materials;
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
