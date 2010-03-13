package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * Vertical multi-line layout.
     * @author eidiot
     */
    public class VMultiLineLayout extends AbstractMultiLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>VMultiLineLayout</code>.
         * @param container             Container of the layout group.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param lineWidth             <code>width</code> value of each line.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param align                 Align of the layout group.
         * @param horizontalGap         Horizontal gap value.
         * @param verticalGap           Vertical gap value.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function VMultiLineLayout(container:DisplayObjectContainer,
                                           width:Number, height:Number,
                                           lineWidth:Number,
                                           x:Number = 0, y:Number = 0,
                                           align:String = "TL",
                                           horizontalGap:Number = 5,
                                           verticalGap:Number = 5,
                                           autoLayoutWhenAdd:Boolean = false,
                                           autoLayoutWhenChange:Boolean = true)
        {
            super(container, width, height, x, y, align, horizontalGap, verticalGap, autoLayoutWhenAdd, autoLayoutWhenChange);
            _lineWidth = lineWidth;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  lineWidth
        //------------------------------
        private var _lineWidth:Number;
        /**
         * Width of each line.
         */
        public function get lineWidth():Number
        {
            return _lineWidth;
        }
        /** @private */
        public function set lineWidth(value:Number):void
        {
            _lineWidth = value;
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
        override protected function createLine():ILayoutGroup
        {
            var line:VLineLayout = new VLineLayout(_container);
            line.width = _lineWidth;
            line.align = _lineAlign;
            line.verticalGap = _verticalGap;
            return line;
        }
        /** @private */
        override protected function createTopLayout():ILayoutGroup
        {
            return new HLineLayout(_container, _x, _y, _width, _height, _align, _horizontalGap);
        }
    }
}