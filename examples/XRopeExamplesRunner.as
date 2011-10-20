package
{
    import xface.XFace;

    import flash.display.Sprite;

    public class XRopeExamplesRunner extends Sprite
    {
        public function XRopeExamplesRunner()
        {
            super();

            XFace.setUnitPostfix("Example");
            XFace.setSelectorTitle("Select layout groups");

            XFace.run(this, XRopeAllExamples);
        }
    }
}