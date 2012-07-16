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

		[Embed ("Smoke.00000.png")] private static const smoke00:Class;
		[Embed ("Smoke.00001.png")] private static const smoke01:Class;
		[Embed ("Smoke.00002.png")] private static const smoke02:Class;
		[Embed ("Smoke.00003.png")] private static const smoke03:Class;
		[Embed ("Smoke.00004.png")] private static const smoke04:Class;
		[Embed ("Smoke.00005.png")] private static const smoke05:Class;
		[Embed ("Smoke.00006.png")] private static const smoke06:Class;
		[Embed ("Smoke.00007.png")] private static const smoke07:Class;
		[Embed ("Smoke.00008.png")] private static const smoke08:Class;
		[Embed ("Smoke.00009.png")] private static const smoke09:Class;
		[Embed ("Smoke.00010.png")] private static const smoke10:Class;
		[Embed ("Smoke.00011.png")] private static const smoke11:Class;
		[Embed ("Smoke.00012.png")] private static const smoke12:Class;
		[Embed ("Smoke.00013.png")] private static const smoke13:Class;
		[Embed ("Smoke.00014.png")] private static const smoke14:Class;
		[Embed ("Smoke.00015.png")] private static const smoke15:Class;
		[Embed ("Smoke.00016.png")] private static const smoke16:Class;
		[Embed ("Smoke.00017.png")] private static const smoke17:Class;
		[Embed ("Smoke.00018.png")] private static const smoke18:Class;
		[Embed ("Smoke.00019.png")] private static const smoke19:Class;
		[Embed ("Smoke.00020.png")] private static const smoke20:Class;
		[Embed ("Smoke.00021.png")] private static const smoke21:Class;
		[Embed ("Smoke.00022.png")] private static const smoke22:Class;
		[Embed ("Smoke.00023.png")] private static const smoke23:Class;
		[Embed ("Smoke.00024.png")] private static const smoke24:Class;
		[Embed ("Smoke.00025.png")] private static const smoke25:Class;
		[Embed ("Smoke.00026.png")] private static const smoke26:Class;
		[Embed ("Smoke.00027.png")] private static const smoke27:Class;
		[Embed ("Smoke.00028.png")] private static const smoke28:Class;
		[Embed ("Smoke.00029.png")] private static const smoke29:Class;
		[Embed ("Smoke.00030.png")] private static const smoke30:Class;
		[Embed ("Smoke.00031.png")] private static const smoke31:Class;
		[Embed ("Smoke.00032.png")] private static const smoke32:Class;
		[Embed ("Smoke.00033.png")] private static const smoke33:Class;
		[Embed ("Smoke.00034.png")] private static const smoke34:Class;
		[Embed ("Smoke.00035.png")] private static const smoke35:Class;
		[Embed ("Smoke.00036.png")] private static const smoke36:Class;
		[Embed ("Smoke.00037.png")] private static const smoke37:Class;
		[Embed ("Smoke.00038.png")] private static const smoke38:Class;
		[Embed ("Smoke.00039.png")] private static const smoke39:Class;
		[Embed ("Smoke.00040.png")] private static const smoke40:Class;
		[Embed ("Smoke.00041.png")] private static const smoke41:Class;
		[Embed ("Smoke.00042.png")] private static const smoke42:Class;
		[Embed ("Smoke.00043.png")] private static const smoke43:Class;
		[Embed ("Smoke.00044.png")] private static const smoke44:Class;
		[Embed ("Smoke.00045.png")] private static const smoke45:Class;
		[Embed ("Smoke.00046.png")] private static const smoke46:Class;
		[Embed ("Smoke.00047.png")] private static const smoke47:Class;
		[Embed ("Smoke.00048.png")] private static const smoke48:Class;
		[Embed ("Smoke.00049.png")] private static const smoke49:Class;
		[Embed ("Smoke.00050.png")] private static const smoke50:Class;
		[Embed ("Smoke.00051.png")] private static const smoke51:Class;
		[Embed ("Smoke.00052.png")] private static const smoke52:Class;
		[Embed ("Smoke.00053.png")] private static const smoke53:Class;
		[Embed ("Smoke.00054.png")] private static const smoke54:Class;
		[Embed ("Smoke.00055.png")] private static const smoke55:Class;
		[Embed ("Smoke.00056.png")] private static const smoke56:Class;
		[Embed ("Smoke.00057.png")] private static const smoke57:Class;
		[Embed ("Smoke.00058.png")] private static const smoke58:Class;
		[Embed ("Smoke.00059.png")] private static const smoke59:Class;
		[Embed ("Smoke.00060.png")] private static const smoke60:Class;
		[Embed ("Smoke.00061.png")] private static const smoke61:Class;
		[Embed ("Smoke.00062.png")] private static const smoke62:Class;
		[Embed ("Smoke.00063.png")] private static const smoke63:Class;
		[Embed ("Smoke.00064.png")] private static const smoke64:Class;
		[Embed ("Smoke.00065.png")] private static const smoke65:Class;
		[Embed ("Smoke.00066.png")] private static const smoke66:Class;
		[Embed ("Smoke.00067.png")] private static const smoke67:Class;
		[Embed ("Smoke.00068.png")] private static const smoke68:Class;
		[Embed ("Smoke.00069.png")] private static const smoke69:Class;
		[Embed ("Smoke.00070.png")] private static const smoke70:Class;
		[Embed ("Smoke.00071.png")] private static const smoke71:Class;
		[Embed ("Smoke.00072.png")] private static const smoke72:Class;
		[Embed ("Smoke.00073.png")] private static const smoke73:Class;
		[Embed ("Smoke.00074.png")] private static const smoke74:Class;
		[Embed ("Smoke.00075.png")] private static const smoke75:Class;
		[Embed ("Smoke.00076.png")] private static const smoke76:Class;
		[Embed ("Smoke.00077.png")] private static const smoke77:Class;
		[Embed ("Smoke.00078.png")] private static const smoke78:Class;
		[Embed ("Smoke.00079.png")] private static const smoke79:Class;
		[Embed ("Smoke.00080.png")] private static const smoke80:Class;
		[Embed ("Smoke.00081.png")] private static const smoke81:Class;
		[Embed ("Smoke.00082.png")] private static const smoke82:Class;
		[Embed ("Smoke.00083.png")] private static const smoke83:Class;
		[Embed ("Smoke.00084.png")] private static const smoke84:Class;
		[Embed ("Smoke.00085.png")] private static const smoke85:Class;

		private var resources:Vector.<Resource> = new Vector.<Resource>();
		public function GrenadeSmoke() {
			super(400, 400);
//			alwaysOnTop = true;
			this.originY = 1;

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
			materials.push(createTextureMaterial(smoke42));
			materials.push(createTextureMaterial(smoke43));
			materials.push(createTextureMaterial(smoke44));
			materials.push(createTextureMaterial(smoke45));
			materials.push(createTextureMaterial(smoke46));
			materials.push(createTextureMaterial(smoke47));
			materials.push(createTextureMaterial(smoke48));
			materials.push(createTextureMaterial(smoke49));
			materials.push(createTextureMaterial(smoke50));
			materials.push(createTextureMaterial(smoke51));
			materials.push(createTextureMaterial(smoke52));
			materials.push(createTextureMaterial(smoke53));
			materials.push(createTextureMaterial(smoke54));
			materials.push(createTextureMaterial(smoke55));
			materials.push(createTextureMaterial(smoke56));
			materials.push(createTextureMaterial(smoke57));
			materials.push(createTextureMaterial(smoke58));
			materials.push(createTextureMaterial(smoke59));
			materials.push(createTextureMaterial(smoke60));
			materials.push(createTextureMaterial(smoke61));
			materials.push(createTextureMaterial(smoke62));
			materials.push(createTextureMaterial(smoke63));
			materials.push(createTextureMaterial(smoke64));
			materials.push(createTextureMaterial(smoke65));
			materials.push(createTextureMaterial(smoke66));
			materials.push(createTextureMaterial(smoke67));
			materials.push(createTextureMaterial(smoke68));
			materials.push(createTextureMaterial(smoke69));
			materials.push(createTextureMaterial(smoke70));
			materials.push(createTextureMaterial(smoke71));
			materials.push(createTextureMaterial(smoke72));
			materials.push(createTextureMaterial(smoke73));
			materials.push(createTextureMaterial(smoke74));
			materials.push(createTextureMaterial(smoke75));
			materials.push(createTextureMaterial(smoke76));
			materials.push(createTextureMaterial(smoke77));
			materials.push(createTextureMaterial(smoke78));
			materials.push(createTextureMaterial(smoke79));
			materials.push(createTextureMaterial(smoke80));
			materials.push(createTextureMaterial(smoke81));
			materials.push(createTextureMaterial(smoke82));
			materials.push(createTextureMaterial(smoke83));
			materials.push(createTextureMaterial(smoke84));
			materials.push(createTextureMaterial(smoke85));
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
