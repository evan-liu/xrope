package xrope.examples.lineLayouts
{
    import xface.XFace;

    import xrope.HLineLayout;
    import xrope.ILayoutGroup;
    import xrope.VLineLayout;
    import xrope.examples.helper.ExampleHelpler;

    import flash.text.TextField;
    /**
     * @author eidiot
     */
    public class VLineExample
    {
        [Test]
        public function test():void
        {
            var topGroup:ILayoutGroup = new HLineLayout(XFace.container, 20, 30, -1, 360);
            for each (var align:String in ExampleHelpler.ALL_ALIGNS)
            {
                topGroup.add(new VLineLayout(XFace.container, 0, 0, 35, topGroup.height, align, 5, true));
            }
            topGroup.layout();
            for each (var subGroup:ILayoutGroup in topGroup.elements)
            {
                fillSubGroup(subGroup);
                ExampleHelpler.fillGroup(subGroup);
                titleSubGroup(subGroup);
            }
        }
        private function fillSubGroup(target:ILayoutGroup):void
        {
            for (var i:int = 0;i < 3;i++)
            {
                target.add(ExampleHelpler.getShape());
            }
            target.layout();
        }
        private function titleSubGroup(target:ILayoutGroup):void
        {
            var alignTf:TextField = new TextField();
            alignTf.text = target.align;
            alignTf.width = alignTf.textWidth + 4;
            alignTf.height = alignTf.textHeight + 4;
            XFace.display(alignTf, target.x + (target.width - alignTf.width) / 2,
                          (target.y - alignTf.height) / 2);
        }
    }
}