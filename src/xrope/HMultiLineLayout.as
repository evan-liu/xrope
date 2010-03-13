package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * Horizontal multi-line layout.
     * @author eidiot
     */
    public class HMultiLineLayout extends AbstractMultiLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>HMultiLineLayout</code>.
         * @param container             Container of the layout group.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param lineHeight            <code>height</code> value of ecah line.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param align                 Align of the layout group.
         * @param horizontalGap         Horizontal gap value.
         * @param verticalGap           Vertical gap value.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function HMultiLineLayout(container:DisplayObjectContainer,
                                           width:Number, height:Number,
                                           lineHeight:Number,
                                           x:Number = 0, y:Number = 0,
                                           align:String = "TL",
                                           horizontalGap:Number = 5,
                                           verticalGap:Number = 5,
                                           autoLayoutWhenAdd:Boolean = false,
                                           autoLayoutWhenChange:Boolean = true)
        {
            super(container, width, height, x, y, align, horizontalGap, verticalGap, autoLayoutWhenAdd, autoLayoutWhenChange);
            _lineHeight = lineHeight;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  lineHeight
        //------------------------------
        private var _lineHeight:Number;
        /**
         * Height of each line.
         */
        public function get lineHeight():Number
        {
            return _lineHeight;
        }
        /** @private */
        public function set lineHeight(value:Number):void
        {
            if (value == _lineHeight)
            {
                return;
            }
            _lineHeight = value;
            isChanged = true;
            checkLayoutAfterChange();
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function layoutElements():void
        {
            layoutAsLines("width", _horizontalGap);
        }
        /** @private */
        override protected function createLine():ILayoutGroup
        {
            var line:HLineLayout = new HLineLayout(_container);
            line.height = _lineHeight;
            line.align = _lineAlign;
            line.horizontalGap = _horizontalGap;
            return line;
        }
        /** @private */
        override protected function createTopLayout():ILayoutGroup
        {
            return new VLineLayout(_container, _x, _y, _width, _height, _align, _verticalGap);
        }
    }
}
