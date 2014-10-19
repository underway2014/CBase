package core.baseComponent
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import core.tween.TweenLite;
	
	public class LoopAtlas extends Sprite
	{
		private var viewArr:Array;
		private var currentPage:int = 0;
		private var canClick:Boolean;
		private var SCREEN_WIDTH:int = 1920;
		private var autoMove:Boolean;
		public function LoopAtlas(_viewArr:Array,_autoMove:Boolean = true)
		{
			super();
			
			viewArr = _viewArr;
			autoMove = _autoMove;
			len = viewArr.length;
			viewContain = new Sprite();
			addChild(viewContain);
			
			init();
		}
		private var viewContain:Sprite;
		private var len:int;
		private var leftView:Sprite = new Sprite();
		private var midView:Sprite = new Sprite();
		private var rightView:Sprite = new Sprite();
		private var leftIndex:int;
		private var rightIndex:int;
		private var manger:Array;
		private var dataViewArr:Array;
		private var timer:Timer;
		private function init():void
		{
			manger = new Array();
			manger.push(leftView);
			manger.push(midView);
			manger.push(rightView);
			
			dataViewArr = new Array();
			
			if(autoMove)
			{
				timer = new Timer(1000 * 7);
				timer.addEventListener(TimerEvent.TIMER,autoMoveHandler);
				timer.start();
			}
			getView();
		}
		private var dir:int = -1;
		private var isMoving:Boolean =false;
		private function autoMoveHandler(event:TimerEvent):void
		{
			isMoving = true;
			var endX:int = viewContain.x + SCREEN_WIDTH * dir;
			TweenLite.to(viewContain,.4,{x:endX,onComplete:moveOver});
		}
		public function next():void
		{
			if(isMoving) return;
			if(timer) timer.stop();
			autoMoveHandler(null);
		}
		public function prev():void
		{
			if(isMoving) return;
			if(timer) timer.stop();
			dir = 1;
			autoMoveHandler(null);
		}
		public function gotoPage(index:int):void
		{
			currentPage = index;
			getView();
		}
		private function moveOver():void
		{
			currentPage -= dir;
			if(currentPage > viewArr.length - 1)
			{
				currentPage = 0;
			}
			if(currentPage < 0)
			{
				currentPage = viewArr.length - 1;
			}
			if(dir == -1)//left
			{
				
			}else{//right
				
			}
			dir = -1;
			getView();
		}
		private function getView():void
		{
			while(dataViewArr.length)
			{
				dataViewArr.shift();
			}
			if(currentPage - 1 >=0)
			{
				leftIndex = currentPage - 1;
			}
			else{
				leftIndex = len - 1;
			}
			if(currentPage + 1 > len - 1)
			{
				rightIndex = 0;
			}else{
				rightIndex = currentPage + 1;
			}
			dataViewArr.push(viewArr[leftIndex]);
			dataViewArr.push(viewArr[currentPage]);
			dataViewArr.push(viewArr[rightIndex]);
			
			reLayout();
		}
//		private 
		private function reLayout():void
		{
			viewContain.x = 0;
			var n:int = - 1;
			for each(var view:CImage in dataViewArr)
			{
				view.x = n * SCREEN_WIDTH;
				viewContain.addChild(view);
				n++;
			}
			while(viewContain.numChildren  > 3)
			{
				viewContain.removeChildAt(0);
			}
			isMoving = false;
			if(timer && !timer.running)
			{
				timer.start();
				trace("restart timer.runing = ",timer.running);
			}
		}
	}
}