package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * Vertical box layout.
     * @author eidiot
     */
    public class VBoxLayout extends AbstractMultiLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>VBoxLayout</code>.
         * @param container             Container of the layout group.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param align                 Align of the layout group.
         * @param horizontalGap         Horizontal gap value.
         * @param verticalGap           Vertical gap value.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function VBoxLayout(container:DisplayObjectContainer,
                                   width:Number, height:Number,
                                   x:Number = 0, y:Number = 0,
                                   align:String = "TL",
                                   horizontalGap:Number = 5,
                                   verticalGap:Number = 5,
                                   useBounds:Boolean = false,
                                   autoLayoutWhenChange:Boolean = true)
        {
            super(container, width, height, x, y, align, horizontalGap, verticalGap, useBounds, autoLayoutWhenChange);
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function layoutElements():void
        {
            layoutAsLines("height", _verticalGap);
        }
        /** @private */
        override protected function createLine(oldLines:Vector.<ILayoutGroup>):ILayoutGroup
        {
            var line:VLineLayout = oldLines.length > 0 ?
                                   VLineLayout(oldLines.pop()) :
                                   new VLineLayout(_container);
            line.reset();
            line.align = _lineAlign;
            line.verticalGap = _verticalGap;
            return line;
        }
        /** @private */
        override protected function createTopLayout():ILayoutGroup
        {
            return new HLineLayout(_container, _x, _y, _width, _height, _align, _horizontalGap);
        }
        /** @private */
        override protected function fixLineAlign(value:String):String
        {
            switch (value)
            {
                case LayoutAlign.TOP_LEFT:
                case LayoutAlign.BOTTOM_LEFT:
                    return LayoutAlign.LEFT;
                case LayoutAlign.TOP:
                case LayoutAlign.BOTTOM:
                    return LayoutAlign.CENTER;
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return LayoutAlign.RIGHT;
                default:
                    return value;
            }
            return value;
        }
    }
}