package
{
    import xvein.layout.HorizontalLayout;
    import xvein.layout.LayoutAlign;

    import flash.display.Shape;
    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class HorizontalExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function HorizontalExample()
        {
            super();
            demo();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function demo():void
        {
            var v1:HorizontalLayout = new HorizontalLayout(this, 50, 100, 300, 50, LayoutAlign.TOP_LEFT);
            var v2:HorizontalLayout = new HorizontalLayout(this, 50, 200, 300, 50, LayoutAlign.BOTTOM_RIGHT);
            var v3:HorizontalLayout = new HorizontalLayout(this, 50, 300, 300, 50, LayoutAlign.CENTER);
            fill(v1);
            fill(v2);
            fill(v3);
        }
        private function fill(target:HorizontalLayout):void
        {
            for (var i:int = 0;i < 3;i++)
            {
                target.add(getShape());
            }
            target.layout();
            with (graphics)
            {
                beginFill(0, 0.2);
                drawRect(target.x, target.y, target.width, target.height);
                endFill();
            }
        }
        private function getShape():Shape
        {
            var s:Shape = new Shape();
            with (s.graphics)
            {
                beginFill(Math.random() * 0xFFFFFF);
                var x:Number = 20 - Math.random() * 40;
                var y:Number = 20 - Math.random() * 40;
                var width:Number = 20 + Math.random() * 20;
                var height:Number = 20 + Math.random() * 20;
                drawRect(x, y, width, height);
                endFill();
            }
            return s;
        }
    }
}