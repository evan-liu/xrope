package xvein.layout
{
    import xvein.core.ILayoutAlgorithm;
    import xvein.core.ILayoutElement;
    import xvein.core.ILayoutGroup;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.utils.Dictionary;
    /**
     * @author eidiot
     */
    public class AbstractLayoutGroup implements ILayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLineLayout</code>.
         */
        public function AbstractLayoutGroup(container:DisplayObjectContainer)
        {
            _container = container;
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected var atomMap:Dictionary = new Dictionary();
        //======================================================================
        //  Properties: IXLayoutGroup
        //======================================================================
        //------------------------------
        //  x
        //------------------------------
        protected var _x:Number = 0;
        /**
         * @inheritDoc
         */
        public function get x():Number
        {
            return _x;
        }
        /**
         * @private
         */
        public function set x(value:Number):void
        {
            _x = value;
            // TODO Set x for all elements.
        }
        //------------------------------
        //  y
        //------------------------------
        protected var _y:Number = 0;
        /**
         * @inheritDoc
         */
        public function get y():Number
        {
            return _y;
        }
        /**
         * @private
         */
        public function set y(value:Number):void
        {
            _y = value;
            // TODO Set y for all elements
        }
        //------------------------------
        //  width
        //------------------------------
        protected var _width:Number = 0;
        /**
         * @inheritDoc
         */
        public function get width():Number
        {
            return _width;
        }
        /**
         * @private
         */
        public function set width(value:Number):void
        {
            _width = value;
            // TODO Relayout.
        }
        //------------------------------
        //  height
        //------------------------------
        protected var _height:Number;
        /**
         * @inheritDoc
         */
        public function get height():Number
        {
            return _height;
        }
        /**
         * @private
         */
        public function set height(value:Number):void
        {
            _height = value;
            // TODO Relayout.
        }
        //------------------------------
        //  container
        //------------------------------
        protected var _container:DisplayObjectContainer;
        /**
         * @inheritDoc
         */
        public function get container():DisplayObjectContainer
        {
            return _container;
        }
        //------------------------------
        //  elements
        //------------------------------
        protected var _elements:Array = [];
        /**
         * @inheritDoc
         */
        public function get elements():Array
        {
            return _elements.concat();
        }
        //------------------------------
        //  align
        //------------------------------
        protected var _align:String = "L";
        /**
         * @inheritDoc
         */
        public function get align():String
        {
            return _align;
        }
        /**
         * @private
         */
        public function set align(value:String):void
        {
            _align = value;
        }
        //------------------------------
        //  horizontalGap
        //------------------------------
        protected var _horizontalGap:Number;
        /**
         * @inheritDoc
         */
        public function get horizontalGap():Number
        {
            return _horizontalGap;
        }
        /**
         * @private
         */
        public function set horizontalGap(value:Number):void
        {
            _horizontalGap = value;
        }
        //------------------------------
        //  verticalGap
        //------------------------------
        protected var _verticalGap:Number = 0;
        /**
         * @inheritDoc
         */
        public function get verticalGap():Number
        {
            return _verticalGap;
        }
        /**
         * @private
         */
        public function set verticalGap(value:Number):void
        {
            _verticalGap = value;
        }
        //======================================================================
        //  Public methods: IXLayoutGroup
        //======================================================================
        /**
         * @inheritDoc
         */
        public function add(...elements):void
        {
            while (elements.length == 1 && elements[0] is Array)
            {
                elements = elements[0];
            }
            for each (var element:* in elements)
            {
                addOne(element);
            }
        }
        /**
         * @inheritDoc
         */
        public function remove(...elements):void
        {
            while (elements.length == 1 && elements[0] is Array)
            {
                elements = elements[0];
            }
            for each (var element:* in elements)
            {
                removeOne(element);
            }
        }
        /**
         * @inheritDoc
         */
        public function has(element:*):Boolean
        {
            if (_elements.length == 0)
            {
                return false;
            }
            if (element is ILayoutElement)
            {
                return _elements.indexOf(element) != -1;
            }
            if (element is DisplayObject)
            {
                return atomMap[element] != null;
            }
            return false;
        }
        /**
         * @inheritDoc
         */
        public function layout():void
        {
            if (_elements.length > 0)
            {
                layoutElements();
            }
            else
            {
                layoutContainer();
            }
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected function addOne(element:*):void
        {
            if (has(element))
            {
                return;
            }
            if (element is ILayoutElement)
            {
                _elements.push(element);
            }
            else if (element is DisplayObject)
            {
                addAtom(element);
            }
        }
        protected function addAtom(element:DisplayObject):void
        {
            if (element.parent != _container)
            {
                _container.addChild(element);
            }
            var atom:AtomLayout = new AtomLayout(element);
            atomMap[element] = atom;
            _elements.push(atom);
        }
        protected function removeOne(element:*):void
        {
            if (element is ILayoutElement)
            {
                var index:int = _elements.indexOf(element);
                if (index != -1)
                {
                    _elements.splice(index, 1);
                }
                return;
            }
            if (element is DisplayObject && atomMap[element])
            {
                removeOne(atomMap[element]);
                delete atomMap[element];
            }
        }
        protected function layoutContainer():void
        {
            const N:int = _container.numChildren;
            if (N == 0)
            {
                return;
            }
            for (var i:int = 0;i < N;i++)
            {
                addAtom(_container.getChildAt(i));
            }
            layoutElements();
        }
        protected function layoutElements():void
        {
            var xAlgorithm:ILayoutAlgorithm = getXAlgorithm();
            xAlgorithm.beReady(this, "x", "width", getStartX(), _horizontalGap);
            var yAlgorithm:ILayoutAlgorithm = getYAlgorithm();
            yAlgorithm.beReady(this, "y", "height", getStartY(), _verticalGap);
            var previousElement:ILayoutElement;
            for each (var element:ILayoutElement in _elements)
            {
                element.x = xAlgorithm.calculate(element, previousElement);
                element.y = yAlgorithm.calculate(element, previousElement);
                previousElement = element;
            }
        }
        protected function getStartX():Number
        {
            return _x;
        }
        protected function getStartY():Number
        {
            return _y;
        }
        protected function getXAlgorithm():ILayoutAlgorithm
        {
            return null;
        }
        protected function getYAlgorithm():ILayoutAlgorithm
        {
            return null;
        }
        protected function getTotalWidth():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.width;
            }
            return result;
        }
        protected function getTotalHeight():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.height;
            }
            return result;
        }
    }
}