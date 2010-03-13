package xrope
{
    import xrope.algorithms.CenterAlgorithm;
    import xrope.algorithms.MaxAlgorithm;
    import xrope.algorithms.MinAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class VLineLayout extends AbstractLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLineLayout</code>.
         * @param container     Container of the layout group.
         * @param align         Align of the layout group.
         * @param gap           Space of the layout elements in the group.
         */
        public function VLineLayout(container:DisplayObjectContainer,
                                        x:Number = 0, y:Number = 0,
                                        width:Number = -1, height:Number = -1,
                                        align:String = "TL", gap:Number = 5,
                                        autoLayoutWhenAdd:Boolean = false,
                                        autoLayoutWhenChange:Boolean = true)
        {
            super(container, autoLayoutWhenAdd, autoLayoutWhenChange);
            _x = x;
            _y = y;
            _width = width;
            _height = height;
            _align = align;
            _verticalGap = gap;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function fixWidth():void
        {
            _width = getMaxWidth();
        }
        override protected function fixHeight():void
        {
            _height = getElementsAndGapsHeight();
        }
        override protected function getStartY():Number
        {
            switch (_align)
            {
                case LayoutAlign.BOTTOM:
                case LayoutAlign.BOTTOM_LEFT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return _y + _height - getElementsAndGapsHeight();
                case LayoutAlign.CENTER:
                case LayoutAlign.LEFT:
                case LayoutAlign.RIGHT:
                    return _y + (_height - getElementsAndGapsHeight()) / 2;
            }
            return _y;
        }
        override protected function getXAlgorithm():ILayoutAlgorithm
        {
            switch (_align)
            {
                case LayoutAlign.LEFT:
                case LayoutAlign.TOP_LEFT:
                case LayoutAlign.BOTTOM_LEFT:
                    return new MinAlgorithm();
                case LayoutAlign.RIGHT:
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new MaxAlgorithm();
            }
            return new CenterAlgorithm();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getElementsHeight():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.height;
            }
            return result;
        }
        private function getGapsHeight():Number
        {
            return _verticalGap * (_elements.length - 1);
        }
        private function getElementsAndGapsHeight():Number
        {
            return getElementsHeight() + getGapsHeight();
        }
        private function getMaxWidth():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                if (element.width > result)
                {
                    result = element.width;
                }
            }
            return result;
        }
    }
}