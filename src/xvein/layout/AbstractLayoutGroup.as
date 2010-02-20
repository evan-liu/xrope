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
        public function AbstractLayoutGroup(container:DisplayObjectContainer,
                                            autoLayoutWhenAdd:Boolean = false,
                                            autoLayoutWhenChange:Boolean = true)
        {
            _container = container;
            _autoLayoutWhenAdd = autoLayoutWhenAdd;
            _autoLayoutWhenChange = autoLayoutWhenChange;
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected var atomMap:Dictionary = new Dictionary();
        protected var isLayouted:Boolean = false;
        protected var isChanged:Boolean = false;
        //======================================================================
        //  Properties: IXLayoutGroup
        //======================================================================
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
            if (value == _x)
            {
                return;
            }
            if (isLayouted)
            {
                if (_autoLayoutWhenChange)
                {
                    var change:Number = value - _x;
                    for each (var element:ILayoutElement in _elements)
                    {
                        element.x += change;
                    }
                }
                else
                {
                    isLayouted = true;
                }
            }
            _x = value;
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
            if (value == _y)
            {
                return;
            }
            if (isLayouted)
            {
                if (_autoLayoutWhenChange)
                {
                    var change:Number = value - _y;
                    for each (var element:ILayoutElement in _elements)
                    {
                        element.y += change;
                    }
                }
                else
                {
                    isLayouted = true;
                }
            }
            _y = value;
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
            if (value == _width)
            {
                return;
            }
            _width = value;
            isChanged = true;
            if (isLayouted && _autoLayoutWhenChange)
            {
                layout();
            }
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
            if (value == _height)
            {
                return;
            }
            _height = value;
            isChanged = true;
            if (isLayouted && _autoLayoutWhenChange)
            {
                layout();
            }
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
            if (value == _align)
            {
                return;
            }
            _align = value;
            isChanged = true;
            if (isLayouted && _autoLayoutWhenChange)
            {
                layout();
            }
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
            if (value == _horizontalGap)
            {
                return;
            }
            _horizontalGap = value;
            isChanged = true;
            if (isLayouted && _autoLayoutWhenChange)
            {
                layout();
            }
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
            if (value == _verticalGap)
            {
                return;
            }
            _verticalGap = value;
            isChanged = true;
            if (isLayouted && _autoLayoutWhenChange)
            {
                layout();
            }
        }
        //------------------------------
        //  autoLayoutWhenAdd
        //------------------------------
        protected var _autoLayoutWhenAdd:Boolean = false;
        /**
         * @inheritDoc
         */
        public function get autoLayoutWhenAdd():Boolean
        {
            return _autoLayoutWhenAdd;
        }
        /**
         * @private
         */
        public function set autoLayoutWhenAdd(value:Boolean):void
        {
            _autoLayoutWhenAdd = value;
        }
        //------------------------------
        //  autoLayoutWhenChange
        //------------------------------
        protected var _autoLayoutWhenChange:Boolean = false;
        /**
         * @inheritDoc
         */
        public function get autoLayoutWhenChange():Boolean
        {
            return _autoLayoutWhenChange;
        }
        /**
         * @private
         */
        public function set autoLayoutWhenChange(value:Boolean):void
        {
            _autoLayoutWhenChange = value;
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
            isChanged = true;
            if (_autoLayoutWhenAdd)
            {
                layout();
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
            isChanged = true;
            if (_autoLayoutWhenAdd)
            {
                layout();
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
            if (isLayouted && !isChanged)
            {
                return;
            }
            if (_elements.length > 0)
            {
                layoutElements();
            }
            else
            {
                layoutContainer();
            }
            isLayouted = true;
            isChanged = false;
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