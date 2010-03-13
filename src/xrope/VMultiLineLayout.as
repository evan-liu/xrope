package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class VMultiLineLayout extends AbstractMultiLayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
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
        /**
         * @private
         */
        public function set lineWidth(value:Number):void
        {
            _lineWidth = value;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function layoutElements():void
        {
            layoutAsLines("height", _verticalGap);
        }
        override protected function createLine():ILayoutGroup
        {
            var line:VLineLayout = new VLineLayout(_container);
            line.width = _lineWidth;
            line.align = _lineAlign;
            line.verticalGap = _verticalGap;
            return line;
        }
        override protected function createTopLayout():ILayoutGroup
        {
            return new HLineLayout(_container, _x, _y, _width, _height, _align, _horizontalGap);
        }
    }
}
