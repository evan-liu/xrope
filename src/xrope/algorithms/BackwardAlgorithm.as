package xrope.algorithms
{
    import xrope.ILayoutElement;
    /**
     * Algorithm for backward element value.
     * @author eidiot
     */
    public class BackwardAlgorithm extends AbstractLayoutAlgorithm
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
                return startValue - sizeOf(currentElement);
            }
            return valueOf(previousElement) - gap - sizeOf(currentElement);
        }
    }
}