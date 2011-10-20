package xrope.utils
{
    import xrope.ILayoutAlgorithm;
    import xrope.LayoutAlign;
    import xrope.algorithms.BackwardAlgorithm;
    import xrope.algorithms.CenterAlgorithm;
    import xrope.algorithms.ForwardAlgorithm;
    import xrope.algorithms.MaxAlgorithm;
    import xrope.algorithms.MinAlgorithm;
    public class LineLayoutUtil
    {
        public static function getXAlgorithmForHLayout(align:String):ILayoutAlgorithm
        {
            switch (align)
            {
                case LayoutAlign.RIGHT:
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new BackwardAlgorithm();
            }
            return new ForwardAlgorithm();
        }
        public static function getYAlgorithmForHLayout(align:String):ILayoutAlgorithm
        {
            switch (align)
            {
                case LayoutAlign.TOP:
                case LayoutAlign.TOP_LEFT:
                case LayoutAlign.TOP_RIGHT:
                    return new MinAlgorithm();
                case LayoutAlign.BOTTOM:
                case LayoutAlign.BOTTOM_LEFT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new MaxAlgorithm();
            }
            return new CenterAlgorithm();
        }
        public static function getXAlgorithmForVLayout(align:String):ILayoutAlgorithm
        {
            switch (align)
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
        public static function getYAlgorithmForVLayout(align:String):ILayoutAlgorithm
        {
            switch (align)
            {
                case LayoutAlign.BOTTOM:
                case LayoutAlign.BOTTOM_LEFT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new BackwardAlgorithm();
            }
            return new ForwardAlgorithm();
        }
    }
}