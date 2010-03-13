package xrope.algorithms
{
    import xrope.ILayoutElement;
    /**
     * Algorithm for forward element value.
     * @author eidiot
     */
    public class ForwardAlgorithm extends AbstractLayoutAlgorithm
    {
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @inheritDoc */
        override public function calculate(currentElement:ILayoutElement,
                                           previousElement:ILayoutElement = null):Number
        {
            if (!previousElement)
            {
                return startValue;
            }
            return valueOf(previousElement) + sizeOf(previousElement) + gap;
        }
    }
}