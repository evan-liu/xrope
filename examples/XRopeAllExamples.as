package
{
    import xrope.examples.AlignExample;
    import xrope.examples.FormExample;
    import xrope.examples.GridExample;
    import xrope.examples.boxLayouts.BoxLayoutSuite;
    import xrope.examples.fillLineLayouts.FillLineLayoutSuite;
    import xrope.examples.lineLayouts.LineLayoutSuite;
    import xrope.examples.multiLineLayouts.MultiLineSuite;
    [Suite]
    public class XRopeAllExamples
    {
        public static function suite():Array
        {
            return [
                GridExample,
                MultiLineSuite,
                BoxLayoutSuite,
                FillLineLayoutSuite,
                LineLayoutSuite,
                AlignExample,
                FormExample,
            ];
        }
    }
}