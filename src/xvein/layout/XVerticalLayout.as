package xvein.layout
{
    import xvein.core.IXLayoutElement;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class XVerticalLayout extends AbstractXLayoutGroup
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
        public function XVerticalLayout(container:DisplayObjectContainer,
                                        x:Number = 0, y:Number = 0,
                                        width:Number = 100, height:Number = 100,
                                        align:String = "T", gap:Number = 5)
        {
            super(container);
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
        override protected function layoutElements():void
        {
            var direction:Number = 1;
            var currentX:Number = _x;
            var currentY:Number = _y;
            var widthOffset:Number = 0;
            var heightOffset:Number = 0;
            switch (_align)
            {
                case XAlign.BOTTOM:
                    direction = -1;
                    currentY = _y + _height;
                    widthOffset = 0.5;
                    heightOffset = -1;
                    break;
                case XAlign.BOTTOM_LEFT:
                    direction = -1;
                    currentY = _y + _height;
                    heightOffset = -1;
                    break;
                case XAlign.BOTTOM_RIGHT:
                    direction = -1;
                    currentY = _y + _height;
                    heightOffset = -1;
                    break;
                case XAlign.CENTER:
                    var totalGap:Number = _verticalGap * (_elements.length - 1);
                    currentY = _y + (_height - getTotalHeight() - totalGap) / 2;
                    break;
                case XAlign.TOP:
                case XAlign.TOP_LEFT:
                case XAlign.TOP_RIGHT:
                case XAlign.RIGHT:
                case XAlign.CENTER:
                default:
                    break;
            }
            for each (var element:IXLayoutElement in _elements)
            {
                element.x = currentX + element.width * widthOffset;
                element.y = currentY + element.height * heightOffset;
                currentY += (element.height + _verticalGap) * direction;
            }
        }
        private function getTotalHeight():Number
        {
            var result:Number = 0;
            for each (var element:IXLayoutElement in _elements)
            {
                result += element.width;
            }
            return result;
        }
    }
}