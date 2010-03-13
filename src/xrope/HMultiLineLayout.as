package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class HMultiLineLayout extends AbstractMultiLayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
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
        /**
         * @private
         */
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
        override protected function layoutElements():void
        {
            layoutAsLines("width", _horizontalGap);
        }
        override protected function createLine():ILayoutGroup
        {
            var line:HLineLayout = new HLineLayout(_container);
            line.height = _lineHeight;
            line.align = _lineAlign;
            line.horizontalGap = _horizontalGap;
            return line;
        }
        override protected function createTopLayout():ILayoutGroup
        {
            return new VLineLayout(_container, _x, _y, _width, _height, _align, _verticalGap);
        }
    }
}
