Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090C23C8A0;
	Sat,  1 Aug 2026 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565103; cv=pass; b=lQL5n8ERfkj/nWLch7lPgQB49vGVM2JTi5B/tKibQdHaWV5NsIljkwt/0g7IdOq35FeCxn6XpwLEgap36+HFUV7ON64MXmWE/JvP96uuFWhKmMxtmJoD+vYWvWPPRt1Ci1XEYi4AULwC8ll5NRctBE4hW5BTGD83rOKE1MwdBR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565103; c=relaxed/simple;
	bh=oGYvvQikBH14ZONijqlO3Jbf9L0KrsfpRvWgu28KQCk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=TWu0Dz7tyRgxyKP3RGJNSxI83bGfkwiFJMddfr+ELCE0od+56Y3NnkfLKr23jkhUNv82/mNEluWztcfjXHeeFQD4u19pTdeMH0wuPEidDZzT64w4OYByZ41I9/iHvRdBtYIm4hwWCD9QSS0bmMaSCPRGfUA4SqXbiAxZUYIGQV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=KrbcLu5x; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="KrbcLu5x"
ARC-Seal: i=1; a=rsa-sha256; t=1785565084; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=LVCTN7/xVGiHVl136YjHpN8aasz1Z9aT4W1CQRZF6Jz75Fas29XQCcPGGi2wBcivIt61pWrAS8XjdEY0qII2L/No1SF+YYRBmKkmiLX128S92IzwfLte7PNabE+0PUyAJqHAFyokWUGy3k8OK0c+O5Mq/7Ko86NQYzy7BDi3yoo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1785565084; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CdMtqZTTqOu7lA+oaN9MwhF3m0vVaz/0NXiEodKQB3I=; 
	b=TOr0DLq/H5jg9z5blUbLlmcO9ftfVBdowp+7NKQuQo1gU10w9DoNkUcBtGRwYs8Dqh0z453G0P4jjaJoIdkV8n+OrqFsEQyev7UAqkPd+xdoCpLOcFez7xPgGdvTuSSu8bFRPkSsB0kTT2NNfoi3dH/zK8u+JpZpZtL9KW0e1M4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785565084;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CdMtqZTTqOu7lA+oaN9MwhF3m0vVaz/0NXiEodKQB3I=;
	b=KrbcLu5xJ/4VjEnkuuTm7GeR/E2MkfLXKE17043wWR7ENHvGwM/KOAhSJcf6F9SI
	73N5vr+XjuXel2tsErmk10KC3ntz8VLWgpTHGc0kP6l+MkrYsQpWRxVHzMu2G70KDja
	zfv0kLC1T3S0A2sOy9JQjXSyD/EJUaf57iKs0yv0=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1785565080878496.60349065102923; Sat, 1 Aug 2026 11:48:00 +0530 (IST)
Received: from  [152.59.198.84] by mail.zoho.in
	with HTTP;Sat, 1 Aug 2026 11:48:00 +0530 (IST)
Date: Sat, 01 Aug 2026 11:48:00 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "netdev" <netdev@vger.kernel.org>
Cc: "linux-usb" <linux-usb@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"andrew" <andrew@lunn.ch>
Message-ID: <19fbbf8ed26.728dd0e313328.44864015181634544@zohomail.in>
In-Reply-To: 
Subject: [PATCH v3 1/2] net: usb: net1080: cleanups and error handling
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

From 9be346e3f926ada0af0714edbadb34b192b98891 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Sat, 1 Aug 2026 11:45:28 +0530
Subject: [PATCH 1/2] net: usb: net1080: remove unused #if 0 block

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/net/usb/net1080.c | 55 +++++++++++++--------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
index 19f6e1222d93..87848f6e8e01 100644
--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -113,49 +113,22 @@ nc_register_read(struct usbnet *dev, u8 regnum, u16 *retval_ptr)
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
 
 
-#if 0
-static void nc_dump_registers(struct usbnet *dev)
-{
-	u8	reg;
-	u16	*vp = kmalloc(sizeof (u16));
-
-	if (!vp)
-		return;
 
-	netdev_dbg(dev->net, "registers:\n");
-	for (reg = 0; reg < 0x20; reg++) {
-		int retval;
-
-		// reading some registers is trouble
-		if (reg >= 0x08 && reg <= 0xf)
-			continue;
-		if (reg >= 0x12 && reg <= 0x1e)
-			continue;
-
-		retval = nc_register_read(dev, reg, vp);
-		if (retval < 0)
-			netdev_dbg(dev->net, "reg [0x%x] ==> error %d\n",
-				   reg, retval);
-		else
-			netdev_dbg(dev->net, "reg [0x%x] = 0x%x\n", reg, *vp);
-	}
-	kfree(vp);
-}
 #endif
 
 
@@ -279,8 +252,12 @@ static int net1080_reset(struct usbnet *dev)
 	usbctl = vp;
 	nc_dump_usbctl(dev, usbctl);
 
-	nc_register_write(dev, REG_USBCTL,
-			USBCTL_FLUSH_THIS | USBCTL_FLUSH_OTHER);
+	retval = nc_register_write(dev, REG_USBCTL,
+				   USBCTL_FLUSH_THIS | USBCTL_FLUSH_OTHER);
+	if (retval < 0) {
+		netdev_dbg(dev->net, "can't write USBCTL: %d\n", retval);
+		goto done;
+	}
 
 	if ((retval = nc_register_read(dev, REG_TTL, &vp)) < 0) {
 		netdev_dbg(dev->net, "can't read TTL, %d\n", retval);
@@ -288,8 +265,12 @@ static int net1080_reset(struct usbnet *dev)
 	}
 	ttl = vp;
 
-	nc_register_write(dev, REG_TTL,
-			MK_TTL(NC_READ_TTL_MS, TTL_OTHER(ttl)) );
+	retval = nc_register_write(dev, REG_TTL,
+				   MK_TTL(NC_READ_TTL_MS, TTL_OTHER(ttl)));
+	if (retval < 0) {
+		netdev_dbg(dev->net, "can't write TTL: %d\n", retval);
+		goto done;
+	}
 	netdev_dbg(dev->net, "assigned TTL, %d ms\n", NC_READ_TTL_MS);
 
 	netif_info(dev, link, dev->net, "port %c, peer %sconnected\n",
-- 
2.53.0



