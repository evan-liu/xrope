package
{
    import xvein.layout.XAlign;
    import xvein.layout.XVerticalLayout;
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
            var v1:XVerticalLayout = new XVerticalLayout(this, 100, 50, 50, 300, XAlign.TOP);
            var v2:XVerticalLayout = new XVerticalLayout(this, 250, 50, 50, 300, XAlign.BOTTOM);
            var v3:XVerticalLayout = new XVerticalLayout(this, 400, 50, 50, 300, XAlign.CENTER);
            fill(v1);
            fill(v2);
            fill(v3);
        }
        private function fill(target:XVerticalLayout):void
        {
            for (var i:int = 0; i < 3; i++)
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