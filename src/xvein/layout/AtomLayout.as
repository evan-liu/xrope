package xvein.layout
{
    import xvein.core.ILayoutElement;

    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    /**
     * Atom layout element for one DisplayObject.
     *
     * @author eidiot
     */
    public class AtomLayout implements ILayoutElement
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XAtomLayout</code>.
         */
        public function AtomLayout(target:DisplayObject)
        {
            _target = target;
            targetBounds = _target.getBounds(_target);
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
        /**
         * @inheritDoc
         */
        public function get x():Number
        {
            return _target.x + targetBounds.x * _target.scaleX;
        }
        public function set x(value:Number):void
        {
            _target.x = value - targetBounds.x * _target.scaleX;
        }
        //------------------------------
        //  y
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get y():Number
        {
            return _target.y + targetBounds.y * _target.scaleY;
        }
        public function set y(value:Number):void
        {
            _target.y = value - targetBounds.y * _target.scaleY;
        }
        //------------------------------
        //  width
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get width():Number
        {
            return _target.width;
        }
        public function set width(value:Number):void
        {
            _target.width = width;
        }
        //------------------------------
        //  height
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get height():Number
        {
            return _target.height;
        }
        public function set height(value:Number):void
        {
            _target.height = height;
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
    }
}