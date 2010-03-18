package xrope
{
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    /**
     * Atom layout element for one DisplayObject.
     * @author eidiot
     */
    public class AtomLayout implements ILayoutElement
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XAtomLayout</code>.
         * @param target        Target display object.
         * @param useBounds     If use <code>getBounds()</code> for layout.
         */
        public function AtomLayout(target:DisplayObject, useBounds:Boolean = false)
        {
            _target = target;
            _useBounds = useBounds;
            if (useBounds)
            {
                targetBounds = _target.getBounds(_target);
            }
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var targetBounds:Rectangle;
        //======================================================================
        //  Properties: IXLayoutElement
        //======================================================================
        //------------------------------
        //  x
        //------------------------------
        /** @inheritDoc */
        public function get x():Number
        {
            return _useBounds ? getXUseBounds() : _target.x;
        }
        public function set x(value:Number):void
        {
            if (_useBounds)
            {
                setXUseBounds(value);
            }
            else
            {
                _target.x = value;
            }
        }
        //------------------------------
        //  y
        //------------------------------
        /** @inheritDoc */
        public function get y():Number
        {
            return _useBounds ? getYUseBounds() : _target.y;
        }
        /** @private */
        public function set y(value:Number):void
        {
            if (_useBounds)
            {
                setYUseBounds(value);
            }
            else
            {
                _target.y = value;
            }
        }
        //------------------------------
        //  width
        //------------------------------
        /** @inheritDoc */
        public function get width():Number
        {
            return _target.width;
        }
        /** @private */
        public function set width(value:Number):void
        {
            _target.width = width;
        }
        //------------------------------
        //  height
        //------------------------------
        /** @inheritDoc */
        public function get height():Number
        {
            return _target.height;
        }
        /** @private */
        public function set height(value:Number):void
        {
            _target.height = height;
        }
        //------------------------------
        //  useBounds
        //------------------------------
        private var _useBounds:Boolean;
        /** @inheritDoc */
        public function get useBounds():Boolean
        {
            return _useBounds;
        }
        /** @private */
        public function set useBounds(value:Boolean):void
        {
            if (value == _useBounds)
            {
                return;
            }
            if (value && !targetBounds)
            {
                targetBounds = _target.getBounds(_target);
            }
            var currentX:Number = x;
            var currentY:Number = y;
            _useBounds = value;
            x = currentX;
            y = currentY;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  target
        //------------------------------
        private var _target:DisplayObject;
        /**
         * Target of the atom layout.
         */
        public function get target():DisplayObject
        {
            return _target;
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getXUseBounds():Number
        {
            return _target.x + targetBounds.x * Math.abs(_target.scaleX);
        }
        private function setXUseBounds(value:Number):void
        {
            _target.x = value - targetBounds.x * Math.abs(_target.scaleX);
        }
        private function getYUseBounds():Number
        {
            return _target.y + targetBounds.y * Math.abs(_target.scaleY);
        }
        private function setYUseBounds(value:Number):void
        {
            _target.y = value - targetBounds.y * Math.abs(_target.scaleY);
        }
    }
}