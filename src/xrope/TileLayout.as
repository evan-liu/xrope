package xrope
{
    import flash.display.DisplayObject;
    import flash.errors.IllegalOperationError;
    /**
     * Tile layout is wapper of a AtomLayout with align and size control.
     * @author eidiot
     */
    public class TileLayout implements ILayoutElement
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>TileLayout</code>.
         * @param targetOrAtom    A <code>DisplayObject</code> or <code>AtomLayout</code>.
         * @param width           <code>width</code> value of the layout element.
         * @param height          <code>height</code> value of the layout element.
         * @param align           Align of the tile.
         * @param useBounds       If use <code>getBounds()</code> for atom.
         * @param x               <code>x</code> value of the layout element.
         * @param y               <code>y</code> value of the layout element.
         */
        public function TileLayout(targetOrAtom:*, width:Number, height:Number,
                                   align:String = "TL", useBounds:Boolean = false,
                                   x:Number = 0, y:Number = 0)
        {
            if (targetOrAtom is AtomLayout)
            {
                _atom = targetOrAtom;
            }
            else if (targetOrAtom is DisplayObject)
            {
                _atom = new AtomLayout(targetOrAtom, useBounds);
            }
            else
            {
                throw new IllegalOperationError("Only DisplayObject or Atom is accepted");
            }
            _width = width;
            _height = height;
            _x = x;
            _y = y;
            _align = align;
            layout();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var atomX:Number = 0;
        private var atomY:Number = 0;
        //======================================================================
        //  Properties: ILaoutElement
        //======================================================================
        //------------------------------
        //  x
        //------------------------------
        private var _x:Number = 0;
        /** @inheritDoc */
        public function get x():Number
        {
            return _x;
        }
        /** @private */
        public function set x(value:Number):void
        {
            if (value != _x)
            {
                _x = value;
                _atom.x = _x + atomX;
            }
        }
        //------------------------------
        //  y
        //------------------------------
        private var _y:Number = 0;
        /** @inheritDoc */
        public function get y():Number
        {
            return _y;
        }
        /** @private */
        public function set y(value:Number):void
        {
            if (value != _y)
            {
                _y = value;
                _atom.y = _y + atomY;
            }
        }
        //------------------------------
        //  width
        //------------------------------
        private var _width:Number = 0;
        /** @inheritDoc */
        public function get width():Number
        {
            return _width;
        }
        /** @private */
        public function set width(value:Number):void
        {
            if (value != _width)
            {
                _width = value;
                layout();
            }
        }
        //------------------------------
        //  height
        //------------------------------
        private var _height:Number = 0;
        /** @inheritDoc */
        public function get height():Number
        {
            return _height;
        }
        /** @private */
        public function set height(value:Number):void
        {
            if (value != _height)
            {
                _height = value;
                layout();
            }
        }
        //------------------------------
        //  useBounds
        //------------------------------
        /** @inheritDoc */
        public function get useBounds():Boolean
        {
            return _atom.useBounds;
        }
        /** @private */
        public function set useBounds(value:Boolean):void
        {
            _atom.useBounds = value;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  atom
        //------------------------------
        private var _atom:AtomLayout;
        /**
         * Atom in the tile.
         */
        public function get atom():AtomLayout
        {
            return _atom;
        }
        //------------------------------
        //  align
        //------------------------------
        private var _align:String = "TL";
        /**
         * Align of the atom in the tile.
         */
        public function get align():String
        {
            return _align;
        }
        /** @private */
        public function set align(value:String):void
        {
            if (value != _align)
            {
                _align = value;
                layout();
            }
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function layout():void
        {
            switch (_align)
            {
                case LayoutAlign.TOP:
                    atomX = centerX();
                    atomY = topY();
                    break;
                case LayoutAlign.TOP_RIGHT:
                    atomX = rightX();
                    atomY = topY();
                    break;
                case LayoutAlign.RIGHT:
                    atomX = rightX();
                    atomY = centerY();
                    break;
                case LayoutAlign.BOTTOM_RIGHT:
                    atomX = rightX();
                    atomY = bottomY();
                    break;
                case LayoutAlign.BOTTOM:
                    atomX = centerX();
                    atomY = bottomY();
                    break;
                case LayoutAlign.BOTTOM_LEFT:
                    atomX = leftX();
                    atomY = bottomY();
                    break;
                case LayoutAlign.LEFT:
                    atomX = leftX();
                    atomY = centerY();
                    break;
                case LayoutAlign.CENTER:
                    atomX = centerX();
                    atomY = centerY();
                    break;
                case LayoutAlign.TOP_LEFT:
                default:
                    atomX = leftX();
                    atomY = topY();
                    break;
            }
            _atom.x = _x + atomX;
            _atom.y = _y + atomY;
        }
        private function leftX():Number
        {
            return 0;
        }
        private function centerX():Number
        {
            return (_width - _atom.width) / 2;
        }
        private function rightX():Number
        {
            return _width - _atom.width;
        }
        private function topY():Number
        {
            return 0;
        }
        private function centerY():Number
        {
            return (_height - _atom.height) / 2;
        }
        private function bottomY():Number
        {
            return _height - _atom.height;
        }
    }
}