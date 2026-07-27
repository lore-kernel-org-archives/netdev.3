Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFCC379990;
	Mon, 27 Jul 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161863; cv=pass; b=PSqwym56don72O7gfAM8YaWgbDw0Xy1QXO5+K3e5Nl8kYQP8GuSZIIXM5R1eZfLI8SSrSIwdIoDa7eAFE6nkRiF0sRVYg7oDtlfFCKmIq9se7dqbIgSz41rOabkp8pj7b1aRXiwuMH1WMowXyIfXgYrPDEQCPVeV1R9zhM9MuvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161863; c=relaxed/simple;
	bh=9+wN2OP+VN5YRtn4mhF1EF59I/ceBJXoESFcFVuCH8Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lzhvUo5TX6/pcH+u6f4O1BgiiSeBtx0YbSsmi8YmiZdGdp9JNP2Al02V9zyLjjKwbkLE/twzAIFhERavKd3AQToBCHBb13OxV5utqUH8U3D0B0+YFLiZGzJ6ndY6QxWbS71D2C6ITsqEyDp5MyuhK9N9es3mC/S7OykUs79T4sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=v9sGYDEg; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="v9sGYDEg"
ARC-Seal: i=1; a=rsa-sha256; t=1785161855; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=CUWSggHXLqM8E10T1VtM9+98qDHB5d5qyNYILpvD0S7N5O2RFZ3cb6oSz+fcY6AkoIfZsiKYk5d63QsfTCgx0BM1H1f/XuNcKy8ZHK73DG3hRCkefLbs9EhHWp60Bg0XJSVe9GzF9wYsYX2O5vt/H3eUaijna/aawFIjWMoO7Q4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1785161855; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T9hHBHR63j1NMl1lY512Q03I0uaCkxsT4y3nIXMLuR8=; 
	b=JoAIUKuOW6CeNYaup6ma6H4ls0PA4diq6CssG5uT35BcEklXrvMhRQhPs/yR+VIf9PTn/xWgWNSFaCntaSUQZh+JzFjFQFOoreZFi1XILUUeL9d00+JoIcPZMQVIBihuixgMVi+dKyvWV5BcmLhoeD4lbShP9TcVpyx/QKjxVoU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785161855;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T9hHBHR63j1NMl1lY512Q03I0uaCkxsT4y3nIXMLuR8=;
	b=v9sGYDEgaLZAIyL02VmqSYhemBKUA2hc7IkfEVBm4ghzvS28xvS7czUDnwl19Ecu
	1v6+r0lmwLq0VTziq57YWgNOX5h4wqa+YpPl2ubmNWpwWwesTn5+njkBCOedP4lTRuK
	V3SmiBPgObskSg5cZ6EP7UlDw4fDibYb8cWIW5ps=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1785161853152548.8193999763087; Mon, 27 Jul 2026 19:47:33 +0530 (IST)
Received: from  [152.57.173.177] by mail.zoho.in
	with HTTP;Mon, 27 Jul 2026 19:47:33 +0530 (IST)
Date: Mon, 27 Jul 2026 19:47:33 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "netdev" <netdev@vger.kernel.org>
Cc: "linux-usb" <linux-usb@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19fa3f028d9.fe65e7a4540.8296440890414077743@zohomail.in>
In-Reply-To: <19fa3e79cfe.894831784405.7828961255432177577@zohomail.in>
References: <19fa3e79cfe.894831784405.7828961255432177577@zohomail.in>
Subject: Re: [PATCH] net: usb: net1080: add error handling to
 nc_vendor_write()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From 70278069430a8b7d71728bc3c24400dc2bdffb63 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Mon, 27 Jul 2026 19:34:16 +0530
Subject: [PATCH] net: usb: net1080: add error handling to nc_vendor_write()

The nc_vendor_write() function currently ignores the return value of
usbnet_write_cmd(). This can lead to silent failures when USB
communication fails.

Change nc_vendor_write() and nc_register_write() to return int
instead of void, and propagate the error from usbnet_write_cmd()
back to the caller.

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/usb/net1080.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
index 19f6e1222d93..dd9f1361aed6 100644
--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -113,18 +113,18 @@ nc_register_read(struct usbnet *dev, u8 regnum, u16 *retval_ptr)
 	return nc_vendor_read(dev, REQUEST_REGISTER, regnum, retval_ptr);
 }
 
-static void
+static int
 nc_vendor_write(struct usbnet *dev, u8 req, u8 regnum, u16 value)
 {
-	usbnet_write_cmd(dev, req,
-			 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			 value, regnum, NULL, 0);
+	return usbnet_write_cmd(dev, req,
+				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+				value, regnum, NULL, 0);
 }
 
-static inline void
+static inline int
 nc_register_write(struct usbnet *dev, u8 regnum, u16 value)
 {
-	nc_vendor_write(dev, REQUEST_REGISTER, regnum, value);
+	return nc_vendor_write(dev, REQUEST_REGISTER, regnum, value);
 }
 
 
-- 
2.53.0



From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "netdev"<netdev@vger.kernel.org>
Cc: "linux-usb"<linux-usb@vger.kernel.org>, "linux-kernel"<linux-kernel@vger.kernel.org>
Date: Mon, 27 Jul 2026 19:38:13 +0530
Subject: [PATCH] net: usb: net1080: add error handling to nc_vendor_write()

 > From a822037e659f6c13022062b399a96b7d72780090 Mon Sep 17 00:00:00 2001 
 > From: Ashwin Gundarapu <gundarapuashwin@outlook.com> 
 > Date: Mon, 27 Jul 2026 19:34:16 +0530 
 > Subject: [PATCH] net: usb: net1080: add error handling to nc_vendor_write() 
 >  
 > The nc_vendor_write() function currently ignores the return value of 
 > usbnet_write_cmd(). This can lead to silent failures when USB 
 > communication fails. 
 >  
 > Change nc_vendor_write() and nc_register_write() to return int 
 > instead of void, and propagate the error from usbnet_write_cmd() 
 > back to the caller. 
 >  
 > Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in> 
 > --- 
 >  drivers/net/usb/net1080.c | 12 ++++++------ 
 >  1 file changed, 6 insertions(+), 6 deletions(-) 
 >  
 > diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c 
 > index 19f6e1222d93..dd9f1361aed6 100644 
 > --- a/drivers/net/usb/net1080.c 
 > +++ b/drivers/net/usb/net1080.c 
 > @@ -113,18 +113,18 @@ nc_register_read(struct usbnet *dev, u8 regnum, u16 *retval_ptr) 
 >      return nc_vendor_read(dev, REQUEST_REGISTER, regnum, retval_ptr); 
 >  } 
 >  
 > -static void 
 > +static int 
 >  nc_vendor_write(struct usbnet *dev, u8 req, u8 regnum, u16 value) 
 >  { 
 > -    usbnet_write_cmd(dev, req, 
 > -             USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE, 
 > -             value, regnum, NULL, 0); 
 > +    return usbnet_write_cmd(dev, req, 
 > +                USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE, 
 > +                value, regnum, NULL, 0); 
 >  } 
 >  
 > -static inline void 
 > +static inline int 
 >  nc_register_write(struct usbnet *dev, u8 regnum, u16 value) 
 >  { 
 > -    nc_vendor_write(dev, REQUEST_REGISTER, regnum, value); 
 > +    return nc_vendor_write(dev, REQUEST_REGISTER, regnum, value); 
 >  } 
 >  
 >  
 > -- 
 > 2.53.0 
 >  
 >  
 > 

