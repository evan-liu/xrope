package xrope.examples.helper
{
    import xrope.ILayoutElement;
    import xrope.ILayoutGroup;
    import xrope.LayoutAlign;

    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;
    public class ExampleHelpler
    {
        public static const ALL_ALIGNS:Array = [
            LayoutAlign.TOP_LEFT,
            LayoutAlign.TOP,
            LayoutAlign.TOP_RIGHT,
            LayoutAlign.RIGHT,
            LayoutAlign.BOTTOM_RIGHT,
            LayoutAlign.BOTTOM,
            LayoutAlign.BOTTOM_LEFT,
            LayoutAlign.LEFT,
            LayoutAlign.CENTER,
        ];
        public static function getShape():Shape
        {
            var x:Number = 15 - Math.random() * 30;
            var y:Number = 15 - Math.random() * 30;
            var width:Number = 15 + Math.random() * 15;
            var height:Number = 15 + Math.random() * 15;
            var s:Shape = new Shape();
            with (s.graphics)
            {
                beginFill(Math.random() * 0xFFFFFF);
                drawRect(x, y, width, height);
                endFill();
            }
            return s;
        }
        public static function clearGroupGraphics(target:ILayoutGroup):void
        {
            Sprite(target.container).graphics.clear();
        }
        public static function fillGroup(target:ILayoutGroup, color:uint = 0xEEEFF0,
                                         alpha:Number = 0.5):void
        {
            with (Sprite(target.container).graphics)
            {
                beginFill(color, alpha);
                drawRect(target.x, target.y, target.width, target.height);
                endFill();
            }
        }
        public static function drawGroupRim(target:ILayoutGroup, color:uint = 0xBBBBBB):void
        {
            with (Sprite(target.container).graphics)
            {
                lineStyle(0, color);
                drawRect(target.x, target.y, target.width, target.height);
            }
        }
        public static function drawElementsRim(target:ILayoutGroup, color:uint = 0xBBBBBB):void
        {
            var graphics:Graphics = Sprite(target.container).graphics;
            graphics.lineStyle(0, color);
            for each (var element:ILayoutElement in target.elements)
            {
                graphics.drawRect(element.x, element.y, element.width, element.height);
            }
        }
    }
}