Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006DC3DCD96
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363798; cv=none; b=kjGm0IriytLtaloNNSWSLQiAMAvtFGugur+Vpe6wT28x8wLbV1EYdtkblHj0YZ/ugS8WqelQqq5Q4uS4S76IEvmgbLLxktRm0nMwVEVX8kj1FQunvMY1jKMcYO+16CxP5rB7fAexgoMaPbqmxfR/tAEMw68U0Q8QRGebdEFgA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363798; c=relaxed/simple;
	bh=v1DytLnnmuC60vTrAtyaWqpRstJUKpphBzdSkCJImD4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ0XNYhQncEuTN3GKN3mzqM0JbFU4c0AQizKUwrYNV9cOTBkzcAVWivYlIz/w4+tCTjoqlF27fFB7LfKs8ljGYHDsc27EKoR+eyC58GOWjRgJ+w5Xi5kj5bCmGohe0NULYXUIBwr3wBTmomwcrtin27ogrnVFy42nTWq8YLQFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHR3OJHx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHR3OJHx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84830c774a0so1710595b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785363794; x=1785968594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1+ogkP17FtYlTeowKG3KRYdfjFcezeLELgqaqeFUhbs=;
        b=RHR3OJHxCe1Xmx+OSn2D9OvK61A39r1VL0rZ76ecrZrbBMuwKE2tAMtkwA6BzQBaU3
         eRuvjbCZOUbP49Be7nmeGMcFkqSUkNo5ksz9TLuKmFZOiY5uIgslB6fgCTiowDomyAPW
         +cDqd14Ou7e55fW5NAt+bYy9PHIzV4dpepC0VxJTVZQ4UEpzcRAacFd+mh099BHy6d8g
         8zjyIG+AnpgLmlcU+4r9RLYct3G+m+0accVgPV4P/li3LjwYgxaS4ReIB5Prs+1Z28AG
         bTmyEl3YmCUUg0/ZtXI1mD1qImv2gax2x7Ftcri1QnD7s7nI+QBD9TrGVT6/KmKCsp2d
         wp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785363794; x=1785968594;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1+ogkP17FtYlTeowKG3KRYdfjFcezeLELgqaqeFUhbs=;
        b=nerWT+N7NiDDofQ+0uYO6tKLZqQ7BAz8JpSvBW8Zg2Vw2klnNVwpjSNu+3zm0jKaN7
         DEmCHvn7HrHTvonhYf5GfYJnsX+uqmbAilfRgQCGTGr6F2riWQTFycYbruli/FMjhCXE
         /5mw0oq/QzLyInFffaEcXsSA3bojgFZx6jvN11C5GzgjdZpGvM+kwDI+dluCqTN1ub/o
         q3X6wvz5+1yJ2sSC9l/SsSM7+pvio7TAZjZxQsvTytAWKLbNT4we5cKc7GHGo+TzK4JC
         1Ezrc1aPd+i/olI7HPvC38od3CnfdMS7rLM4YE7J/W1cKyDgbSH7x74xAHM3UktjjhIH
         3nLQ==
X-Gm-Message-State: AOJu0YzjMiCLdd5BrK6nCplUEGKFVzwx1a4nFXcAolhG7amMdkURc85t
	/ljNlf+HOBQ3x48i8dwKTwVd+YFvRzcF0kZnszy0L4IDVpSIgpxVSe2/
X-Gm-Gg: AR+sD12jOLz/sO/ujEGbWn53tMa6rJ8BkSoWYluPWy2GHQ5xgtsG6K6KFUZUsDCZKPM
	4aqSXoONGi8pnk/LEb5KwSUE+N//P3pRaS+TsseOcdE9ppDCJO5hu3gjh7nrwDW6MDWWbRLu6SF
	trO3o3A6i3PTZ9ULLrOaghUqI/VEXUbY7gl6HPFgcVYvBecemjD61OBLO3sMPTN8kJXlvCUrsi0
	vr13X8tMi5WoB4o/gLeNXrtFViAEoL0vVxpkMSBCCeXLKbsnyWt/Jvh6EXzm303CjwexP/Kt32o
	vz7MIRmifTvOv9VzwlbwwNzZ7IOCW5Pelt+C/57f6rxUYyra7Dxuvef294kfrUdJ4Zhc3TuUlpI
	awtsUMo9Hlm5Hfsn6veNC3mTcKE7QrJS18XVAcodTaV+1mxD5QMkrmJRYsdxjIglCV1HIKCw4+R
	DMNv5fH/0OhOtqnHsBqYxYYABerrHgRpIEmIXpt9Rrrq336+cfvbGusWEAz16AkOvK0idy0pcrn
	bU1gw4790kj1EndnG+czCVPVco87AgoaTgdB7zemjCxWXTBi3cz1MGAPCWp15i2QqelzHShLrrf
	Iw==
X-Received: by 2002:a05:6a00:99b:b0:847:881c:7026 with SMTP id d2e1a72fcca58-84ebc1edc35mr145471b3a.3.1785363794171;
        Wed, 29 Jul 2026 15:23:14 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea037446csm1992285b3a.50.2026.07.29.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:23:13 -0700 (PDT)
Subject: [net-next PATCH v4 2/4] net: pcs: xpcs: Allow for multiple addr in
 creation
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: mike.marciniszyn@gmail.com, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, jiawenwu@trustnetic.com, kees@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, mengyuanlou@net-swift.com, mohsin.bashr@gmail.com,
 pabeni@redhat.com
Date: Wed, 29 Jul 2026 15:21:00 -0700
Message-ID: 
 <178536366014.250758.7525172425951669429.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

The DW channel 10g-100g IP builds the PCS out of multiple addr
mdio addresses.

Add xpcs_create_mdiodevs() and xpcs_create_pcs_mdiodevs calls so that a
driver using the above part can tell xpcs the addr values in one call.

xpcs_create_data(), xpcs_create(), and xpcs_free_data() are extended
to accept a variable number of mdio devices.  Existing singleton
interfaces are re-cast as a having an array pointing to a single
mdio device.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c |    4 +
 drivers/net/pcs/pcs-xpcs.c                      |  106 ++++++++++++++++++-----
 drivers/net/pcs/pcs-xpcs.h                      |    1 
 include/linux/pcs/pcs-xpcs.h                    |    2 
 4 files changed, 88 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
index 09c5225111be..88fc78d55c7a 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
@@ -200,9 +200,11 @@ int fbnic_phylink_create(struct net_device *netdev)
 	struct fbnic_dev *fbd = fbn->fbd;
 	struct phylink_pcs *pcs;
 	struct phylink *phylink;
+	/* See fbnic_mdio.c addr usage */
+	int addrs[] = { 0, 1 };
 	int err;
 
-	pcs = xpcs_create_pcs_mdiodev(fbd->mdio_bus, 0);
+	pcs = xpcs_create_pcs_mdiodevs(fbd->mdio_bus, addrs, ARRAY_SIZE(addrs));
 	if (IS_ERR(pcs)) {
 		err = PTR_ERR(pcs);
 		dev_err(fbd->dev, "Failed to create PCS device: %d\n", err);
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 22246abec948..2e236ff1ad85 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -214,9 +214,18 @@ int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg)
 	return mdiodev_c45_read(xpcs->mdiodev[0], dev, reg);
 }
 
+static int
+xpcs_mdev_write_ch(struct dw_xpcs *xpcs, int ch, int dev, u32 reg, u16 val)
+{
+	if (ch >= xpcs->channels)
+		return -ENXIO;
+
+	return mdiodev_c45_write(xpcs->mdiodev[ch], dev, reg, val);
+}
+
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
 {
-	return mdiodev_c45_write(xpcs->mdiodev[0], dev, reg, val);
+	return xpcs_mdev_write_ch(xpcs, 0, dev, reg, val);
 }
 
 int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)
@@ -1525,16 +1534,21 @@ static int xpcs_identify(struct dw_xpcs *xpcs)
 	return -ENODEV;
 }
 
-static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
+static struct dw_xpcs *
+xpcs_create_data(struct mdio_device **mdiodev, int channels)
 {
 	struct dw_xpcs *xpcs;
+	int i;
 
 	xpcs = kzalloc_obj(*xpcs);
 	if (!xpcs)
 		return ERR_PTR(-ENOMEM);
 
-	mdio_device_get(mdiodev);
-	xpcs->mdiodev[0] = mdiodev;
+	xpcs->channels = channels;
+	for (i = 0; i < channels; i++) {
+		mdio_device_get(mdiodev[i]);
+		xpcs->mdiodev[i] = mdiodev[i];
+	}
 	xpcs->pcs.ops = &xpcs_phylink_ops;
 	xpcs->pcs.poll = true;
 
@@ -1543,7 +1557,10 @@ static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 
 static void xpcs_free_data(struct dw_xpcs *xpcs)
 {
-	mdio_device_put(xpcs->mdiodev[0]);
+	int i;
+
+	for (i = 0; i < xpcs->channels; i++)
+		mdio_device_put(xpcs->mdiodev[i]);
 	kfree(xpcs);
 }
 
@@ -1592,12 +1609,12 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 	return xpcs_identify(xpcs);
 }
 
-static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
+static struct dw_xpcs *xpcs_create(struct mdio_device **mdiodev, int channels)
 {
 	struct dw_xpcs *xpcs;
 	int ret;
 
-	xpcs = xpcs_create_data(mdiodev);
+	xpcs = xpcs_create_data(mdiodev, channels);
 	if (IS_ERR(xpcs))
 		return xpcs;
 
@@ -1628,25 +1645,24 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 	return ERR_PTR(ret);
 }
 
-/**
- * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
- * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
- * @addr: device MDIO-bus ID
- *
- * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
- * the PCS device couldn't be found on the bus and other negative errno related
- * to the data allocation and MDIO-bus communications.
- */
-struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
+static struct dw_xpcs *
+xpcs_create_mdiodevs(struct mii_bus *bus, const int *addrs, int channels)
 {
-	struct mdio_device *mdiodev;
+	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS], *rval;
 	struct dw_xpcs *xpcs;
+	int i;
+
+	if (!addrs || channels <= 0 || channels > DW_XPCS_MAX_CHANNELS)
+		return ERR_PTR(-EINVAL);
 
-	mdiodev = mdio_device_create(bus, addr);
-	if (IS_ERR(mdiodev))
-		return ERR_CAST(mdiodev);
+	for (i = 0; i < channels; i++) {
+		rval = mdio_device_create(bus, addrs[i]);
+		if (IS_ERR(rval))
+			goto out_nomem;
+		mdiodev[i] = rval;
+	}
 
-	xpcs = xpcs_create(mdiodev);
+	xpcs = xpcs_create(mdiodev, channels);
 
 	/* xpcs_create() has taken a refcount on the mdiodev if it was
 	 * successful. If xpcs_create() fails, this will free the mdio
@@ -1654,9 +1670,51 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
 	 * anymore, and putting it here will allow mdio_device_put() in
 	 * xpcs_destroy() to automatically free the mdio device.
 	 */
-	mdio_device_put(mdiodev);
+	for (i = 0; i < channels; i++)
+		mdio_device_put(mdiodev[i]);
 
 	return xpcs;
+out_nomem:
+	while (i--)
+		mdio_device_free(mdiodev[i]);
+	return ERR_CAST(rval);
+}
+
+/**
+ * xpcs_create_pcs_mdiodevs() - create a DW xPCS instance with multiple @addrs
+ * @bus: pointer to the embedded phylink PCS instance
+ * @addrs: an array of int
+ * @channels: the number of addrs items or channels
+ *
+ * Return: a pointer to the phylink PCS if successful, otherwise -ENODEV if
+ * the PCS device couldn't be found on the bus and other negative errno related
+ * to the data allocation and MDIO-bus communications.
+ */
+struct phylink_pcs *
+xpcs_create_pcs_mdiodevs(struct mii_bus *bus, const int *addrs, int channels)
+{
+	struct dw_xpcs *xpcs;
+
+	xpcs = xpcs_create_mdiodevs(bus, addrs, channels);
+	if (IS_ERR(xpcs))
+		return ERR_CAST(xpcs);
+
+	return &xpcs->pcs;
+}
+EXPORT_SYMBOL_GPL(xpcs_create_pcs_mdiodevs);
+
+/**
+ * xpcs_create_mdiodev() - create a DW xPCS instance with the MDIO @addr
+ * @bus: pointer to the MDIO-bus descriptor for the device to be looked at
+ * @addr: device MDIO-bus ID
+ *
+ * Return: a pointer to the DW XPCS handle if successful, otherwise -ENODEV if
+ * the PCS device couldn't be found on the bus and other negative errno related
+ * to the data allocation and MDIO-bus communications.
+ */
+struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr)
+{
+	return xpcs_create_mdiodevs(bus, &addr, 1);
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
@@ -1694,7 +1752,7 @@ struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode)
 	if (!mdiodev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	xpcs = xpcs_create(mdiodev);
+	xpcs = xpcs_create(&mdiodev, 1);
 
 	/* xpcs_create() has taken a refcount on the mdiodev if it was
 	 * successful. If xpcs_create() fails, this will free the mdio
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 5c804cfd47d3..36f4906e689a 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -114,6 +114,7 @@ struct dw_xpcs {
 	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS];
 	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
 	struct phylink_pcs pcs;
+	int channels;
 	phy_interface_t interface;
 	bool need_reset;
 	u8 eee_mult_fact;
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 36073f7b6bb4..d36904ae7cc9 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -57,6 +57,8 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr);
 struct dw_xpcs *xpcs_create_fwnode(struct fwnode_handle *fwnode);
 void xpcs_destroy(struct dw_xpcs *xpcs);
 
+struct phylink_pcs *
+xpcs_create_pcs_mdiodevs(struct mii_bus *bus, const int *addrs, int channels);
 struct phylink_pcs *xpcs_create_pcs_mdiodev(struct mii_bus *bus, int addr);
 void xpcs_destroy_pcs(struct phylink_pcs *pcs);
 


