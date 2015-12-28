using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.IO;
using System.Drawing.IconLib;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

///  <summary>
/// Creates a thumbnail image from a file spec in the calling URL.
/// </summary>
public partial class MakeThumbnail : System.Web.UI.Page
{
    //string size = "";
    //string source = "";

    private void Page_Load(object sender, System.EventArgs e)
    {

        System.Drawing.Image image = null;

        string size = Request["size"];
        string source = Request["source"];
        //size = Request["size"];
        //source = Request["source"];

        try
        {
            if (source == "file")
            {
                image = GetImageFromFile();
            }
            else if (source == "db")
            {
                image = GetImageFromModel();
            }
        }
        catch (Exception Ex)
        {
            try
            {
                image = RenderCantRender();
            }
            catch (Exception ex)
            {
            }
        }

        byte[] imageContent = GenerateThumbnail(image, size);

        // return byte array to caller with image type
        Response.ContentType = "image/png";
        Response.BinaryWrite(imageContent);

    }

    private System.Drawing.Image RenderCantRender()
    {
        System.Drawing.Image image;
        try
        {

            string path = ConfigurationManager.AppSettings["CantRender"];
            // create an image object, using the filename we just retrieved
            //System.Drawing.Image image = System.Drawing.Image.FromFile(Server.MapPath(file));
            image = System.Drawing.Image.FromFile(path);
        }
        catch (Exception ex)
        {
            throw new Exception("RenderCantRender - Path: " + ConfigurationManager.AppSettings["CantRender"] + " - " + ex.Message);
        }

        return image;
    }

    private byte[] GenerateThumbnail(System.Drawing.Image image, string size)
    {
        // create the actual thumbnail image
        //System.Drawing.Image thumbnailImage = image.GetThumbnailImage(64, 64, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);
        System.Drawing.Image thumbnailImage;
        //Modif. para tolerar distintos tamaños de imagen.
        if (size == null)
        {
            thumbnailImage = image;
            //thumbnailImage = image.GetThumbnailImage(64, 64, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);
        }
        else
        {
            if (image.Size.Width > int.Parse(size.Split('x')[0]) || image.Size.Height > int.Parse(size.Split('x')[1]))
            {
                thumbnailImage = ResizeImage(image, int.Parse(size.Split('x')[0]), int.Parse(size.Split('x')[1]));
            }
            //    thumbnailImage = image.GetThumbnailImage(int.Parse(size.Split('x')[0]), int.Parse(size.Split('x')[1]), new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);
            else
                thumbnailImage = image;
        }
        // make a memory stream to work with the image bytes
        System.IO.MemoryStream imageStream = new System.IO.MemoryStream();

        // put the image into the memory stream
        thumbnailImage.Save(imageStream, System.Drawing.Imaging.ImageFormat.Png);

        // make byte array the same size as the image
        byte[] imageContent = new Byte[imageStream.Length];

        // rewind the memory stream
        imageStream.Position = 0;

        // load the byte array with the image
        imageStream.Read(imageContent, 0, (int)imageStream.Length);
        return imageContent;
    }

    private System.Drawing.Image GetImageFromFile()
    {
        System.Drawing.Image image;
        try
        {
            string path = Request.QueryString["path"];

            System.IO.MemoryStream ms = new System.IO.MemoryStream(LoadFile(path));

            if (path.ToLower().EndsWith(".ico"))
                image = GetImageFromICO(ms);
            else image = System.Drawing.Image.FromStream(ms);
        }
        catch (Exception ex)
        {
            throw new Exception("GetImageFromFile - Path: " + Request.QueryString["path"] + " - " + ex.Message);
        }

        return image;
    }

    private System.Drawing.Image GetImageFromICO(MemoryStream ms)
    {
        System.Drawing.Image theIcon = null;

        //System.IO.MemoryStream ms = new System.IO.MemoryStream(LoadFile(path));
        MultiIcon multiIcon = new MultiIcon();
        try
        {
            multiIcon.Load(ms);

            foreach (IconImage iconImage in multiIcon[0])
            {
                MemoryStream msSrc = new MemoryStream();
                iconImage.Icon.ToBitmap().Save(msSrc, ImageFormat.Png);

                if (!iconImage.PixelFormat.ToString().Contains("Indexed"))
                {
                    System.Drawing.Image imgIco = System.Drawing.Image.FromStream(msSrc);
                    System.Drawing.Image icoImage = new Bitmap(iconImage.Size.Width, iconImage.Size.Height, System.Drawing.Imaging.PixelFormat.Format24bppRgb);

                    Graphics g = Graphics.FromImage(icoImage);
                    g.CompositingQuality = CompositingQuality.HighQuality;
                    g.SmoothingMode = SmoothingMode.HighQuality;
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.FillRectangle(System.Drawing.Brushes.White, -1, -1, iconImage.Size.Width + 1, iconImage.Size.Height + 1);
                    g.DrawImage(imgIco, iconImage.Size.Width, iconImage.Size.Height);

                    MemoryStream memStream = new MemoryStream();
                    imgIco.Save(memStream, System.Drawing.Imaging.ImageFormat.Png);  // can output different formats here
                    theIcon = System.Drawing.Image.FromStream(memStream);
                }
                else
                {
                    theIcon = System.Drawing.Image.FromStream(ms);
                }
                //break;
            }
        }
        catch
        {
            theIcon = System.Drawing.Image.FromStream(ms);
        }

        return theIcon;
    }

    private string GetRawBitDepth(System.Drawing.Imaging.PixelFormat pixelFormat)
    {
        switch (pixelFormat)
        {
            case PixelFormat.Format1bppIndexed:
                return "1";
            case PixelFormat.Format24bppRgb:
                return "24";
            case PixelFormat.Format32bppArgb:
            case PixelFormat.Format32bppRgb:
                return "32";
            case PixelFormat.Format8bppIndexed:
                return "8";
            case PixelFormat.Format4bppIndexed:
                return "4";
        }
        return "99";
    }

    private byte[] LoadFile(string filepath)
    {
        try
        {
            FileStream fs = new FileStream(filepath, FileMode.Open, FileAccess.Read);
            byte[] buffer = new byte[(int)fs.Length];
            fs.Read(buffer, 0, buffer.Length);
            fs.Close();

            return buffer;
        }
        catch (Exception ex)
        {
            throw new Exception("LoadFile - filePath: " + filepath + " - " + ex.Message);
        }
    }

    private System.Drawing.Image GetImageFromModel()
    {
        System.Drawing.Image image;
        try
        {
            int id = int.Parse(Request["id"]);
            string type = Request["tipo"];
            bool isICO = false;

            System.IO.MemoryStream ms = null;

            if (type == "Foto")
            {
                FotoView foto = FotoHandler.FindById(id);
                isICO = foto.Nombre.ToLower().EndsWith(".ico");
                ms = new System.IO.MemoryStream(foto.Imagen);
            }
            //else if (type == "Concept")
            //{
            //    ConceptSizeView conceptSize = ConceptSizeHandler.FindById(id);
            //    isICO = conceptSize.Name.ToLower().EndsWith(".ico");
            //    ms = new System.IO.MemoryStream(conceptSize.Data);
            //}

            //image = System.Drawing.Image.FromStream(ms);
            if (isICO)
                image = GetImageFromICO(ms);
            else image = System.Drawing.Image.FromStream(ms);
        }
        catch (Exception ex)
        {
            throw new Exception("GetImageFromModel - Id: " + int.Parse(Request["id"]) + " - type: " + Request["type"] + " - " + ex.Message);
        }

        return image;
    }

    /// <summary>
    /// Required, but not used
    /// </summary>
    /// <returns>true</returns>
    public bool ThumbnailCallback()
    {
        return true;
    }

    private System.Drawing.Image ResizeImage(System.Drawing.Image image, int sizeHeight, int sizeWidth)
    {
        int iNewSize = sizeHeight < sizeWidth ? sizeWidth : sizeHeight;

        float fScale;
        float fsHeight = (float)image.Height;
        float fsWidth = (float)image.Width;

        if (fsWidth > fsHeight)
        {

            float fiNewSize = (float)iNewSize;
            fScale = fiNewSize / fsWidth;
        }
        else
        {

            float fiNewSize = (float)iNewSize;
            fScale = fiNewSize / fsHeight;
        }

        float iNWidth = fScale * fsWidth;
        float iNHeight = fScale * fsHeight;
        System.Drawing.Size newBmpSize = new System.Drawing.Size((int)iNWidth, (int)iNHeight);

        return image.GetThumbnailImage(newBmpSize.Width, newBmpSize.Height, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);
    }

    // ... non-applicable infrastructure code removed for clarity ...
}
