Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DE441611
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363659; cv=none; b=baKn+QDrlstnUwSmW8gzmBLPrfYjUEhxQm9JKoJAy61oOct6JT54s9IHtmFTmjHnRtDLIfjwDlo+aRTlVNcopX5bIOOC7F5Pb2EkqfjSFYlUKV/H8YB37W1AwPl6ShpAEIlCJBWEBL9Lmbexm5evZgcHcOg1YlI5o/UqrtfEHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363659; c=relaxed/simple;
	bh=gP562E48CuWnqs4CMhqtSHWNVh24aNhbk6ZXfihqv5k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JR5E/hiPEBhYllMI3+hXeF/4AXxRAsE6wpMsONDWczZUoW9cjLBB7MePIgiiF/qA49o3MogjpK5tgSwijnJ4xQCHVbLyd28DwRWSgV32R1hW8zhA17Nnqj9qPvjjVeUB5Q6g1AtOkh5Iw8CYd9/8DAo8WTgzBsjqNq9TZyC3S2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPIEklRb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPIEklRb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8485b358552so1677595b3a.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785363655; x=1785968455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AYXNNFqRWMppFvRpucp1dEJE1IGIqXaozr9ZqqZJwJ8=;
        b=TPIEklRbiK4OdeSQt2s3gse1bWAJi8cTC2S5ZN6KC5Y5t0O7mwQBCo1/9d7I0YAly3
         t8n8E0u/phDGS1YGsYnUxd80Yz8B6WUBmHyOJjYkn2+lnIg2iZhE0KZhiM8hnnQUFp9V
         heqzs30f3Mt2CSkAWSqeb48UK3Sw6If4iNeQIDE7Ha45NbOi76Ope3B7oqPgLvA3CDxG
         QHSAVJHKB3SpRHFstl6HgHd8PtXw8pgJ41Av+BD0vpM68flKS+unDkuRUXAQg8oUPkxV
         wXoo5mTra3Go/PcSTO/SPDxSJBrWQQL4u0kUuAL2SnwgGAMfW7E4nkJQ6sKP8/1qyNas
         P0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785363655; x=1785968455;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYXNNFqRWMppFvRpucp1dEJE1IGIqXaozr9ZqqZJwJ8=;
        b=TRSebN+utKIKbuPiXVIv5ep36gx4GVJCbGs/sEJEPpO/NkhQE+ecHnRgymNlvTzAFe
         L8g1XeL6xhgUo2TjNZA24PQq/S1WJTAtAC2N/+1bWuwCesoXUBgT5dXVZxaO3+tBVuFC
         f8NsvMLnMsl1Sdt+kS5YQxRaGPRZ//qE7W/gl+79IY1fvDdx9Auo1FmZyYhuPffAjEIk
         gNfVp7AME6QPxy4HeCMpZQCGSpGGvLzQ5es3yDcIOxG84F5jnPV3ijWhfLZfKq2YOVSr
         Oc1EEiLKCywmXjK1usHpP940skK+twEZxDjzyJLrj/eAssQmt/eFnhlyvUsPyrP4F11M
         WWKA==
X-Gm-Message-State: AOJu0YxIZdmnyfEy9O0lSfYnWzIHKS1GhzGe+GO4V6lo5JJ1gkOftiRo
	sHp2MhZciZC2J5U14uE87oqKeKTz0pBMQdyh4a4uXtj3h9v+KIjRU6W7
X-Gm-Gg: AR+sD10PaDUWwISw/NALQpDdXXxN5Id6f1Gn9gHUgPq4ynTHiTqrtp8Fq+fWKmBUw0N
	E2UaFihqUaa0SQaTbBHmz01kJOplu5ual50hrHAx6I7pLjqjFkNL+joZRQ0EyM6U39VcXaXgF/l
	5Qj0u5qtf8Pw3Se+2qyDJn/2X0ZyBFo3iOkeJ7l4I7lWNvTe2LcKCPBBNUUpkqkSp13bjwPZTy9
	/4XJMqXJQkJ9yuSBjU0N8UrbJqsCJe5ixmiHqQ41UkUB1BbM92XEAo6EiPTVj/rDbGte/2v2y3K
	F61C+6zvvadgNrMv/X3HOfXcfZcFElJJv3TPVCa6C+ivmZwCtPRGBi1DJXkec+bHnxRrNoBXb5W
	ip21hPh26SW+ART81PQ6n6r65TlNR629oEVwTgTUz40BpAKkEV2skGsDdYcOBmw4WS/qDmUmpsU
	W0sMBMRJRAtACPbDPT751iisMl8MJ8S7t19aIpb/s2y1LnyqIoTYUIHm+TWtfDD/AS1wfz6Szkq
	ePPVbCQmgJdyx6Dht93Qm3i7+ypWZt4GKQjiwaInLWZVqK84Yai5nbqt525hMt+/L5ZGbgNPpH6
	UA==
X-Received: by 2002:a05:6a00:852:b0:848:67ca:c03 with SMTP id d2e1a72fcca58-84ebc3f9d69mr122244b3a.58.1785363654981;
        Wed, 29 Jul 2026 15:20:54 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm2034154b3a.15.2026.07.29.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:20:54 -0700 (PDT)
Subject: [net-next PATCH v4 1/4] net: pcs: xpcs: Expand mdiodev member as an
 array
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: mike.marciniszyn@gmail.com, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, jiawenwu@trustnetic.com, kees@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, mengyuanlou@net-swift.com, mohsin.bashr@gmail.com,
 pabeni@redhat.com
Date: Wed, 29 Jul 2026 15:18:40 -0700
Message-ID: 
 <178536352090.250758.5722921302651565959.stgit@ahduyck-xeon-server.home.arpa>
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

This allows for support of 50GR2 and 100GR2 by extending the
current singleton mdiodev to an array.

DW XPCS can support 25GR1 and 50GR1 using just a single group channel. To
operate at 50R2 or 100R2 we need both halves of the channel combined into
one group channel device.

Adjust current use of singleton mdiodev to use the 0th element.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs-wx.c |    4 ++--
 drivers/net/pcs/pcs-xpcs.c    |   43 +++++++++++++++++++++--------------------
 drivers/net/pcs/pcs-xpcs.h    |    5 ++++-
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-wx.c b/drivers/net/pcs/pcs-xpcs-wx.c
index fc52f7aa5f59..38c980f974b4 100644
--- a/drivers/net/pcs/pcs-xpcs-wx.c
+++ b/drivers/net/pcs/pcs-xpcs-wx.c
@@ -123,7 +123,7 @@ static int txgbe_pcs_poll_power_up(struct dw_xpcs *xpcs)
 				10000, 1000000, false,
 				xpcs, DW_VR_XS_PCS_DIG_STS);
 	if (ret < 0)
-		dev_err(&xpcs->mdiodev->dev, "xpcs power-up timeout\n");
+		dev_err(&xpcs->mdiodev[0]->dev, "xpcs power-up timeout\n");
 
 	return ret;
 }
@@ -139,7 +139,7 @@ static int txgbe_pma_init_done(struct dw_xpcs *xpcs)
 				100000, 10000000, false,
 				xpcs, DW_VR_XS_PCS_DIG_CTRL1);
 	if (ret < 0)
-		dev_err(&xpcs->mdiodev->dev, "xpcs pma initialization timeout\n");
+		dev_err(&xpcs->mdiodev[0]->dev, "xpcs pma initialization timeout\n");
 
 	return ret;
 }
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8..22246abec948 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -211,23 +211,24 @@ static bool __xpcs_linkmode_supported(const struct dw_xpcs_compat *compat,
 
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg)
 {
-	return mdiodev_c45_read(xpcs->mdiodev, dev, reg);
+	return mdiodev_c45_read(xpcs->mdiodev[0], dev, reg);
 }
 
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
 {
-	return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
+	return mdiodev_c45_write(xpcs->mdiodev[0], dev, reg, val);
 }
 
 int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)
 {
-	return mdiodev_c45_modify(xpcs->mdiodev, dev, reg, mask, set);
+	return mdiodev_c45_modify(xpcs->mdiodev[0], dev, reg, mask, set);
 }
 
 static int xpcs_modify_changed(struct dw_xpcs *xpcs, int dev, u32 reg,
 			       u16 mask, u16 set)
 {
-	return mdiodev_c45_modify_changed(xpcs->mdiodev, dev, reg, mask, set);
+	return mdiodev_c45_modify_changed(xpcs->mdiodev[0], dev, reg,
+					  mask, set);
 }
 
 static int xpcs_read_vendor(struct dw_xpcs *xpcs, int dev, u32 reg)
@@ -304,7 +305,7 @@ static int xpcs_soft_reset(struct dw_xpcs *xpcs,
 #define xpcs_warn(__xpcs, __state, __args...) \
 ({ \
 	if ((__state)->link) \
-		dev_warn(&(__xpcs)->mdiodev->dev, ##__args); \
+		dev_warn(&(__xpcs)->mdiodev[0]->dev, ##__args); \
 })
 
 static int xpcs_read_fault_c73(struct dw_xpcs *xpcs,
@@ -400,7 +401,7 @@ static void xpcs_link_up_usxgmii(struct dw_xpcs *xpcs, int speed)
 	return;
 
 out:
-	dev_err(&xpcs->mdiodev->dev, "%s: XPCS access returned %pe\n",
+	dev_err(&xpcs->mdiodev[0]->dev, "%s: XPCS access returned %pe\n",
 		__func__, ERR_PTR(ret));
 }
 
@@ -726,7 +727,7 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 
 	ret = xpcs_switch_interface_mode(xpcs, interface);
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "switch interface failed: %pe\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "switch interface failed: %pe\n",
 			ERR_PTR(ret));
 
 	if (!xpcs->need_reset)
@@ -734,14 +735,14 @@ static void xpcs_pre_config(struct phylink_pcs *pcs, phy_interface_t interface)
 
 	compat = xpcs_find_compat(xpcs, interface);
 	if (!compat) {
-		dev_err(&xpcs->mdiodev->dev, "unsupported interface %s\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "unsupported interface %s\n",
 			phy_modes(interface));
 		return;
 	}
 
 	ret = xpcs_soft_reset(xpcs, compat);
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "soft reset failed: %pe\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "soft reset failed: %pe\n",
 			ERR_PTR(ret));
 
 	xpcs->need_reset = false;
@@ -1189,30 +1190,30 @@ static void xpcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 
 	switch (compat->an_mode) {
 	case DW_10GBASER:
-		phylink_mii_c45_pcs_get_state(xpcs->mdiodev, state);
+		phylink_mii_c45_pcs_get_state(xpcs->mdiodev[0], state);
 		break;
 	case DW_AN_C73:
 		ret = xpcs_get_state_c73(xpcs, state, compat);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_c73", ERR_PTR(ret));
 		break;
 	case DW_AN_C37_SGMII:
 		ret = xpcs_get_state_c37_sgmii(xpcs, state);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_c37_sgmii", ERR_PTR(ret));
 		break;
 	case DW_AN_C37_1000BASEX:
 		ret = xpcs_get_state_c37_1000basex(xpcs, neg_mode, state);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_c37_1000basex", ERR_PTR(ret));
 		break;
 	case DW_2500BASEX:
 		ret = xpcs_get_state_2500basex(xpcs, state);
 		if (ret)
-			dev_err(&xpcs->mdiodev->dev, "%s returned %pe\n",
+			dev_err(&xpcs->mdiodev[0]->dev, "%s returned %pe\n",
 				"xpcs_get_state_2500basex", ERR_PTR(ret));
 		break;
 	default:
@@ -1232,14 +1233,14 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
 		if (speed != SPEED_1000) {
-			dev_err(&xpcs->mdiodev->dev,
+			dev_err(&xpcs->mdiodev[0]->dev,
 				"%s: speed %dMbps not supported\n",
 				__func__, speed);
 			return;
 		}
 
 		if (duplex != DUPLEX_FULL)
-			dev_err(&xpcs->mdiodev->dev,
+			dev_err(&xpcs->mdiodev[0]->dev,
 				"%s: half duplex not supported\n",
 				__func__);
 	}
@@ -1247,7 +1248,7 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
 	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
 			 mii_bmcr_encode_fixed(speed, duplex));
 	if (ret)
-		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
+		dev_err(&xpcs->mdiodev[0]->dev, "%s: xpcs_write returned %pe\n",
 			__func__, ERR_PTR(ret));
 }
 
@@ -1533,7 +1534,7 @@ static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 		return ERR_PTR(-ENOMEM);
 
 	mdio_device_get(mdiodev);
-	xpcs->mdiodev = mdiodev;
+	xpcs->mdiodev[0] = mdiodev;
 	xpcs->pcs.ops = &xpcs_phylink_ops;
 	xpcs->pcs.poll = true;
 
@@ -1542,7 +1543,7 @@ static struct dw_xpcs *xpcs_create_data(struct mdio_device *mdiodev)
 
 static void xpcs_free_data(struct dw_xpcs *xpcs)
 {
-	mdio_device_put(xpcs->mdiodev);
+	mdio_device_put(xpcs->mdiodev[0]);
 	kfree(xpcs);
 }
 
@@ -1552,7 +1553,7 @@ static int xpcs_init_clks(struct dw_xpcs *xpcs)
 		[DW_XPCS_CORE_CLK] = "core",
 		[DW_XPCS_PAD_CLK] = "pad",
 	};
-	struct device *dev = &xpcs->mdiodev->dev;
+	struct device *dev = &xpcs->mdiodev[0]->dev;
 	int ret, i;
 
 	for (i = 0; i < DW_XPCS_NUM_CLKS; ++i)
@@ -1580,7 +1581,7 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 {
 	const struct dw_xpcs_info *info;
 
-	info = dev_get_platdata(&xpcs->mdiodev->dev);
+	info = dev_get_platdata(&xpcs->mdiodev[0]->dev);
 	if (!info) {
 		xpcs->info.pcs = DW_XPCS_ID_NATIVE;
 		xpcs->info.pma = DW_XPCS_PMA_ID_NATIVE;
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 929fa238445e..5c804cfd47d3 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -105,10 +105,13 @@ enum dw_xpcs_clock {
 	DW_XPCS_NUM_CLKS,
 };
 
+/* 2 channels per group DW PCS devices */
+#define DW_XPCS_MAX_CHANNELS 2
+
 struct dw_xpcs {
 	struct dw_xpcs_info info;
 	const struct dw_xpcs_desc *desc;
-	struct mdio_device *mdiodev;
+	struct mdio_device *mdiodev[DW_XPCS_MAX_CHANNELS];
 	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
 	struct phylink_pcs pcs;
 	phy_interface_t interface;


