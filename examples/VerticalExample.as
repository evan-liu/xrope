package
{
    import xvein.layout.LayoutAlign;
    import xvein.layout.VerticalLayout;

    import flash.display.Shape;
    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class VerticalExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function VerticalExample()
        {
            super();
            demo();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function demo():void
        {
            var v1:VerticalLayout = new VerticalLayout(this, 100, 50, 50, 300, LayoutAlign.TOP_LEFT);
            var v2:VerticalLayout = new VerticalLayout(this, 250, 50, 50, 300, LayoutAlign.BOTTOM_RIGHT);
            var v3:VerticalLayout = new VerticalLayout(this, 400, 50, 50, 300, LayoutAlign.CENTER);
            fill(v1);
            fill(v2);
            fill(v3);
        }
        private function fill(target:VerticalLayout):void
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