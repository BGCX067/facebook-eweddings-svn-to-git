using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Xml;
using facebook;
using facebook.Schema;
using facebook.web;

public partial class FQL : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
			if (!IsPostBack)
			{
				// Add a sample query to the textbox
				TextBox1.Text = String.Format("SELECT name,pic_small,timezone,birthday,sex,hometown_location,current_location,political FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = {0})", Master.API.uid);
				// Display a list of friend's uid's so they can be used in sample queries.
				IList<facebook.Schema.user> friends = Master.API.friends.getUserObjects();
				foreach(user u in friends)
					ListBox1.Items.Add(u.uid + " "  + u.name);
			}
    }

	protected void ExecFQLBtn_Click(object sender, EventArgs e)
	{

		facebook.fql q = new facebook.fql(Master.API);
		facebook.feed f = new feed(Master.API);
		q.UseJson = UseJson.Checked;
		string result = q.query(TextBox1.Text);
		result = result.Replace("<", "&lt;");
		result = result.Replace(">", "&gt;");
		qresult.Text = result;
	}
}
