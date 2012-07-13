/**
 * Created with IntelliJ IDEA.
 * User: shoo
 * Date: 7/13/12
 * Time: 2:13 PM
 * To change this template use File | Settings | File Templates.
 */
package bloodsplash1 {
import alternativa.engine3d.core.Resource;
import alternativa.engine3d.materials.Material;
import alternativa.engine3d.materials.TextureMaterial;
import alternativa.engine3d.objects.AnimSprite;
import alternativa.engine3d.resources.BitmapTextureResource;

import flash.display.BitmapData;

public class BloodSplash extends AnimSprite{
    [Embed ("Blood_2.00001.png")] private static const blood01:Class;
    [Embed ("Blood_2.00000.png")] private static const blood00:Class;
    [Embed ("Blood_2.00002.png")] private static const blood02:Class;
    [Embed ("Blood_2.00003.png")] private static const blood03:Class;
    [Embed ("Blood_2.00004.png")] private static const blood04:Class;
    [Embed ("Blood_2.00005.png")] private static const blood05:Class;
    [Embed ("Blood_2.00006.png")] private static const blood06:Class;
    [Embed ("Blood_2.00007.png")] private static const blood07:Class;
    [Embed ("Blood_2.00008.png")] private static const blood08:Class;
    [Embed ("Blood_2.00009.png")] private static const blood09:Class;
    [Embed ("Blood_2.00010.png")] private static const blood10:Class;
    [Embed ("Blood_2.00011.png")] private static const blood11:Class;
    [Embed ("Blood_2.00012.png")] private static const blood12:Class;
    [Embed ("Blood_2.00013.png")] private static const blood13:Class;
    [Embed ("Blood_2.00014.png")] private static const blood14:Class;
    [Embed ("Blood_2.00015.png")] private static const blood15:Class;

    private var resources:Vector.<Resource> = new <Resource>[];
    public function BloodSplash() {
        super(100, 100);
        alwaysOnTop = true;
        var materials = new <Material>[];
        materials.push(createTextureMaterial(blood01));
        materials.push(createTextureMaterial(blood00));
        materials.push(createTextureMaterial(blood02));
        materials.push(createTextureMaterial(blood03));
        materials.push(createTextureMaterial(blood04));
        materials.push(createTextureMaterial(blood05));
        materials.push(createTextureMaterial(blood06));
        materials.push(createTextureMaterial(blood07));
        materials.push(createTextureMaterial(blood08));
        materials.push(createTextureMaterial(blood09));
        materials.push(createTextureMaterial(blood10));
        materials.push(createTextureMaterial(blood11));
        materials.push(createTextureMaterial(blood12));
        materials.push(createTextureMaterial(blood13));
        materials.push(createTextureMaterial(blood14));
        materials.push(createTextureMaterial(blood15));
        this.materials = materials;

    }

    private function createTextureMaterial(asset:Class):Material {
       var bdata:BitmapData = (new asset()).bitmapData;
        var resource = new BitmapTextureResource(bdata);
        var materia = new TextureMaterial(resource);
        materia.alphaThreshold = .5;
        resources.push(resource);
        return materia;
    }

    override public function getResources(hierarchy:Boolean = false, resourceType:Class = null):Vector.<Resource> {
        var res:Vector.<Resource> = super.getResources(hierarchy, resourceType);
        var out:Vector.<Resource> = res.concat(resources);
        trace(out)
        return (out);

    }
}
}
