Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDF62E7391;
	Tue, 28 Jul 2026 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238990; cv=pass; b=okJtz4odr3/Ve6JmTwDIKiKZRA9Pa1qIIhfEKfx1ca6uW6ES5rA5NwdDyCfr20wj6lHEBGig87+HjmgHO/r6to7NEIn8YfrLxWjXfkFs0BHjl55RVVhhKZIR+5VzJiAP9LENuA3PJKUIJd3As2Elsxg22vx0qwsyKDQ+8YCh5og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238990; c=relaxed/simple;
	bh=quLaKwiZfERaWmTHxo/ODJ7B/dHApi50Jsm8H15vZak=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=B1FrO8yOKSwGka5G1m1mh4ioVjWuNgwjajpDh+7RqvY+Wa2c3uUh/uQbyQvi5i5w1+M3GZtc7k9uXQGvOXw4mm5SreakZ+jx5h1fECr5+fuTgNuOUnmeOXuKT+PLxlKsdLpRb/AWJwhXbaiHzAhWBCXPpF35fi/L7fItpVQAfuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b=VTmYHSWe; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="VTmYHSWe"
ARC-Seal: i=1; a=rsa-sha256; t=1785238977; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=M3AOSfxVr90KH7f9ZcmegXqhH2qOd+zcrY9JfH9Gbt/q/gxRJ418VQ/tv5n+dU1F5MQU1rQNKNA4IyvmLyt019rTtxjkX0xZKXfJaJZARdc9Pw9uN+jEJ48SnIm5YYZc+FKcewJX6VPSRccWKDLWYUBQ7l2Acb4Ijkr0nRMgEdI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1785238977; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jbI4sr8shz54J9JAmbVVdipbhmm0tldvXywKbn7tmAo=; 
	b=bvNhw6WBfYlnIuMvLT6Brg81J/2JmtTzXqNQZJUEmK1MDyV0hkSyZ6OoDVyYZytBl/P7Jp8zjiH0N0TZvyjv/RyCq1Yq3Pl3evB1OrgbAMq6v614f0g+1UPZdHDTyk39+tXX4GsxjNSJKJhBTUu9Hrs/8uZUIXvFpbLBROphyaM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
	dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785238977;
	s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jbI4sr8shz54J9JAmbVVdipbhmm0tldvXywKbn7tmAo=;
	b=VTmYHSWex1uaRSMEgxUcHbdr8DENvH+5JHMVW4OYMxlrC5yvCJgYfdpghPHOHXD6
	3DyDUNaNr/eOilCU8oFG/uELAb/e+4/6rb1qzjIisSldspQpqzEP3DsVh38lrbhJvLl
	vA75MDwKGhGRleXR3OBv17yRo6ek4sGh97yp9U4Q=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1785238970449474.1843863188993; Tue, 28 Jul 2026 17:12:50 +0530 (IST)
Received: from  [152.59.198.117] by mail.zoho.in
	with HTTP;Tue, 28 Jul 2026 17:12:50 +0530 (IST)
Date: Tue, 28 Jul 2026 17:12:50 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "netdev" <netdev@vger.kernel.org>
Cc: "linux-usb" <linux-usb@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"andrew" <andrew@lunn.ch>
Message-ID: <19fa888e049.512e8c5e24030.7986824281565553606@zohomail.in>
In-Reply-To: 
Subject: [PATCH v2] net: usb: net1080: add error handling to
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

From 8c6ffd0b1a5ac33fb6a81cfd4d7d2c54462233bc Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Mon, 27 Jul 2026 19:34:16 +0530
Subject: [PATCH] net: usb: net1080: add error handling to nc_vendor_write()

The nc_vendor_write() function currently ignores the return value of
usbnet_write_cmd(). This can lead to silent failures when USB
communication fails.

Change nc_vendor_write() and nc_register_write() to return int
instead of void, and propagate the error from usbnet_write_cmd()
back to the caller.

Also fix the callers in net1080_reset() to check the return value
and handle errors appropriately. Remove an unused #if 0 block while
at it.

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



