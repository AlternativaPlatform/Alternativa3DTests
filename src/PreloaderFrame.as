package {

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;

	/*
			  * In the Project Structure -> Modules -> Flex Compiler Settings, set PreloaderFrame as Main Class
			  */
	[SWF (width = 800, height = 800)]
	public class PreloaderFrame extends MovieClip {

		[Embed(source="resources/preloader_alternativa.jpg")]	static private const EmbedPreloader:Class;
//		[Embed(source="resources/progress.jpg")] static private const EmbedProgress:Class;
		[Embed(source="resources/progress.png")] static private const EmbedProgress:Class;

		private var back:Shape = new Shape();
		private var picture:Bitmap = new EmbedPreloader();
		private var progress:Bitmap = new EmbedProgress();

		public function PreloaderFrame() {
			// TODO: change preloader text to Alternativa3D
			// TODO: create context from begining

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, updateProgress);
			// show loader

			addChild(back);
			addChild(picture);
			addChild(progress);
			progress.scaleX = 0.025;

//			back.alpha = 1;
//			progress.alpha = 1;
//			picture.alpha = 1;

			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}

		private function onResize(e:Event = null):void {
			picture.x = Math.round(stage.stageWidth/2 - picture.width/2);
			picture.y = Math.round(stage.stageHeight/2 - picture.height/2) - 30;
			progress.x = picture.x + 2;
			progress.y = picture.y + 221;
			back.graphics.clear();
			back.graphics.beginFill(0);
			back.graphics.drawRect(0, 0, picture.x, stage.stageHeight);
			back.graphics.drawRect(picture.x, 0, picture.width, picture.y);
			back.graphics.drawRect(picture.x + picture.width, 0, stage.stageWidth - picture.width - picture.x, stage.stageHeight);
			back.graphics.drawRect(picture.x, picture.y + picture.height, picture.width,stage.stageHeight - picture.height - picture.y);
		}

		private function updateProgress(e:ProgressEvent):void {
//			graphics.clear();
//			// update loader
//			graphics.lineStyle(0, 0xFFFFFF);
//			graphics.drawRect(50, 50, 200, 50);
//			graphics.beginFill(0xFFFFFF);
			var value:Number = e.bytesTotal == 0 ? 0 : e.bytesLoaded/e.bytesTotal;
//			graphics.drawRect(50, 50, value*200, 50);
			progress.scaleX = value;
		}

		private var counter:int = 0;

		private function checkFrame(e:Event):void {
//			counter++;
//			counter = counter % 1000;
//			updateProgress(new ProgressEvent(ProgressEvent.PROGRESS, false, false, counter, 1000));

			if (currentFrame == totalFrames) {
				updateProgress(new ProgressEvent(ProgressEvent.PROGRESS, false, false, 1000, 1000));
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onGetContext3D);
				stage.stage3Ds[0].requestContext3D();
			}
		}

		private function onGetContext3D(e:Event):void {
			stage.stage3Ds[0].removeEventListener(Event.CONTEXT3D_CREATE, onGetContext3D);
			stage.removeEventListener(Event.RESIZE, onResize);
			startup();
		}

		private function startup():void {
			// hide loader
			stop();
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, updateProgress);
			var mainClass:Class = getDefinitionByName("SSAODemo") as Class;
			stage.addChildAt(new mainClass() as DisplayObject, 0);
			stage.removeChild(this);
		}

	}
}
