using System;
using System.Collections;
using System.Collections.ObjectModel;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using facebook.Schema;
using facebook.web;

namespace FacebookApp
{
	public partial class _Default : System.Web.UI.Page
	{
        public facebook.API API
        {
            get { return ((CanvasIFrameMasterPage)Master).API; }
        }
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
                
				FriendList1.Friends = API.friends.getUserObjects();
                IList<album> albums = API.photos.getAlbums();
                facebook.Schema.user userinfo = API.users.getInfo(API.uid);
				Label1.Text = "Hi, " + userinfo.first_name;
				Image1.ImageUrl = userinfo.pic;
				foreach(user u in FriendList1.Friends)
				{
					DateTime bdate = u.birthday_date;
					DropDownList1.Items.Add(u.first_name);
				}
			}
		}

        

		protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
		{
			IList<user> Friends = Master.API.friends.getUserObjects();
			// Use the FacebookService Component to populate Friends
			Image2.ImageUrl = Friends[DropDownList1.SelectedIndex].pic;
		}
	}
}