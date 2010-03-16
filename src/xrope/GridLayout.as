package xrope
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    /**
     * Grid layout.
     * @author eidiot
     */
    public class GridLayout extends AbstractMultiLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>GridLayout</code>.
         * @param container             Container of the layout group.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param tileWidth             <code>width</code> value of each tile.
         * @param tileHeight            <code>height</code> value of each tile.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param tileAlign             Align of each tile.
         * @param align                 Align of the layout group.
         * @param horizontalGap         Horizontal gap value.
         * @param verticalGap           Vertical gap value.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function GridLayout(container:DisplayObjectContainer,
                                   width:Number, height:Number,
                                   tileWidth:Number, tileHeight:Number,
                                   x:Number = 0, y:Number = 0,
                                   tileAlign:String = "TL",
                                   align:String = "TL",
                                   horizontalGap:Number = 5,
                                   verticalGap:Number = 5,
                                   useBounds:Boolean = false,
                                   autoLayoutWhenAdd:Boolean = false,
                                   autoLayoutWhenChange:Boolean = true)
        {
            super(container, width, height, x, y, align, horizontalGap, verticalGap, useBounds, autoLayoutWhenAdd, autoLayoutWhenChange);
            _tileWidth = tileWidth;
            _tileHeight = tileHeight;
            _tileAlign = tileAlign;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  tileAlign
        //------------------------------
        private var _tileAlign:String;
        /**
         * Align of ecah tile.
         */
        public function get tileAlign():String
        {
            return _tileAlign;
        }
        /** @private */
        public function set tileAlign(value:String):void
        {
            if (value == _tileAlign)
            {
                return;
            }
            _tileAlign = value;
            for each (var atom:* in atomMap)
            {
                if (atom is TileLayout)
                {
                    TileLayout(atom).align = _tileAlign;
                }
            }
        }
        //------------------------------
        //  tileWidth
        //------------------------------
        private var _tileWidth:Number;
        /**
         * Width of each tile.
         */
        public function get tileWidth():Number
        {
            return _tileWidth;
        }
        /** @private */
        public function set tileWidth(value:Number):void
        {
            if (value == _tileWidth)
            {
                return;
            }
            _tileWidth = value;
            for each (var atom:* in atomMap)
            {
                if (atom is TileLayout)
                {
                    TileLayout(atom).width = _tileWidth;
                }
            }
        }
        //------------------------------
        //  tileHeight
        //------------------------------
        private var _tileHeight:Number;
        /**
         * Height of ecch tile.
         */
        public function get tileHeight():Number
        {
            return _tileHeight;
        }
        /** @private */
        public function set tileHeight(value:Number):void
        {
            if (value == _tileHeight)
            {
                return;
            }
            _tileHeight = value;
            for each (var atom:* in atomMap)
            {
                if (atom is TileLayout)
                {
                    TileLayout(atom).height = _tileHeight;
                }
            }
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function createAtom(element:DisplayObject):ILayoutElement
        {
            return new TileLayout(element, _tileWidth, _tileHeight, _tileAlign, _useBounds);
        }
        /** @private */
        override protected function layoutElements():void
        {
            layoutAsLines("width", _horizontalGap);
        }
        /** @private */
        override protected function createLine(oldLines:Array):ILayoutGroup
        {
            var line:HLineLayout = oldLines.length > 0 ?
                                   HLineLayout(oldLines.pop()) :
                                   new HLineLayout(_container);
            line.reset();
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