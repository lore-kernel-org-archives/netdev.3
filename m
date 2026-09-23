Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E237C93F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130013; cv=none; b=aDBUGfYR+CvAoYl+TOcvHfpSYWb+KTi9L2uIS8phH2LG6iUg05BDFTCeVJmMLZY3wIZXeVrDtGAXupVgWyDQNoXldNe9YL3MzlBqZi8c992reuuwdujrGmh+VvbumKJmZydk8qjEqhTvgapVVhLCIMaLd0z0Njnc7kTojKoZx9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130013; c=relaxed/simple;
	bh=mWRv0fUewWtvfdIm/iZol6Zv6zLYlS1qtrgbRxlFKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpuEO3tcDdGYbcwPce36Gc1ELd6JRg0m4cIsEHTuMFFN7Jbi2SC4TLGboLNnV9tTN4O0KGfpg/5k+9fkTQ48ehvAt+k5GVY/8ZFLvGfxO7U6tcpvz5chOq+VB2aTDbEch/wk/7XHw8m8AuJ2X9YqPGixDQs4fZrj3HbwXkyUcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNMLdo1J; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNMLdo1J"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c4so388026b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130010; x=1790734810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BXcSdB4eMNtobBEIQ28OELyVE1Use551bMoEsfYuMdA=;
        b=lNMLdo1JjZ1Ns9fxOlRdf5w0EdvtqZRs1b1vb5k5iHzZM7c1ATCiOK3bnUwdFU6nMt
         Vma56uodJZMfsNCLCJTnw2gnmONL4tzf9gjuIrPD6uP8zf8r5daMjx5kUVyH6U7qBC9z
         0BmfwVjFGTMZ1afKebagdH4W7kgvZ2Zj0qvqqYol2YHtDY3fHgZeXhj3wmBh6ljdSdFc
         ttkLDuznAtoBbtnw2cMBBZ2X9B5qhLqeMZ6FgsFjSBfatt7LJvpvezOGsGdoqAl2meeN
         xuBl4dublWfxy8LPngMsVaPohPCEGY+vB+pemh0tHkHpc/B4cGgsKo0vzgo+2CDArJU1
         aY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130010; x=1790734810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXcSdB4eMNtobBEIQ28OELyVE1Use551bMoEsfYuMdA=;
        b=0NhLbkoBR36x3DEHEZdgtU/N5Oj10QsZIhUHOIeLxQQRUrzNusBUUFiP52NZ6BipV+
         46VVP7Sfci/O1Vk/g1J8sLzx5bC9wJF67i8QF49zveB3UD9KLTB6LK/w+76B170x0KUj
         Xy5cjSNBDjT6azoGFJbWVt96Xnmo3Kd1s9DFU/D62ync/hJfaaZqwRy/yW6Vn1e2wUfN
         /zG4uw/wkfRxzdyQY62SEri6FVJ6cxhrOp8z5Hd3WUUvH+Iytdq6e4pyqvxq0zxrwKJa
         rPkwkhX/sEVLyWU+T0SaGZGe3SH2nPvXXybq+DuCnL1+X/pp90lEm6YjydpsP3VzH3SA
         mMDw==
X-Gm-Message-State: AFuF++lOfd9JIYmFavSnR+F9HspAKMV+7g+SLIoVts7Sqoi1hnmEMbCp
	mhAYTvFZwsW62UG091Q38d4Q1LiVgzIi5KtcTtWhg9EHIPuoQIVRm7HSkU3hmQ==
X-Gm-Gg: AYBFou38LcWy3SVh+h1Wdbfq8Wj3J/1lniLPphFTc6tVMzC52LVIt6zR6lpur36XPzS
	nOCpdjCBCVYhu3/ov5Vld5+rJOzaEY/P2G4Of2YgBtdXH1eBsx9BAIezCIGEFmKjvl6ZTFtrdBN
	OF63qJY6L6C1vAQVouRjc978JLCAyR7nt2LF++XStH6a9WHVBwA7moI59MeOxLMQlAMl9FJJ2rw
	VDev41Ymhc8rkQFaMozn8i/nEXtiU0KTos7XtWTNsKyLJZlXX/L5mJtzpROxi96oZLr3xipEaaa
	R2k5EnFct9Kzvu2PG2eSFYlnVJYB/l04Jw7Fr5k6LuDstSq2sLGyhHD/7nfUP9rzBUnnXkGHMfv
	4YgwbTYo4ldi7l0klKHQMBmAqmepckPCeIIVvVKCZx7fJ3ntyQdrRegP1gpfDDeEG9yNiw2uukl
	xKCNyc9XBVNejM8l/wRGM1Lukk7aFjNVO3nhmgh7Omi675gosYhHdviZo41R0ZPCULTlyV8b0mZ
	73a341NUadmqjuc14e+j1bW
X-Received: by 2002:a05:6a00:ab0f:b0:874:706d:8570 with SMTP id d2e1a72fcca58-87d1c3b6b7amr1124034b3a.33.1790130010269;
        Tue, 22 Sep 2026 19:20:10 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fe8sm502924b3a.51.2026.09.22.19.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:20:09 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/8] net: dsa: motorcomm: Identify port type at runtime
Date: Wed, 23 Sep 2026 10:19:35 +0800
Message-ID: <20260923021945.2203368-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923021945.2203368-1-mmyangfl@gmail.com>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The yt921x_port_is_internal/external() macros hardcoded the port layout:
they treat ports 8 and 9 as external on every chip and count the dummy
ports as internal.

Identify the actual port capabilities using chip info and track
configuration of external ports (although only SerDes is supported now).
This is a hardening and cleanup step ahead of the SerDes PCS support, no
behavior changes intended.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 40 +++++++++++++++++++++++---------
 drivers/net/dsa/motorcomm/chip.h | 11 +++++----
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 54881856b796..ea4b29882b5c 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -3738,6 +3738,7 @@ yt921x_dsa_port_set_apptrust(struct dsa_switch *ds, int port, const u8 *sel,
 
 static int yt921x_port_down(struct yt921x_priv *priv, int port)
 {
+	const struct yt921x_info *info = priv->info;
 	u32 mask;
 	int res;
 
@@ -3746,12 +3747,13 @@ static int yt921x_port_down(struct yt921x_priv *priv, int port)
 	if (res)
 		return res;
 
-	if (yt921x_port_is_external(port)) {
+	if (BIT(port) & info->serdes_mask) {
 		mask = YT921X_SERDES_LINK;
 		res = yt921x_reg_clear_bits(priv, YT921X_SERDESn(port), mask);
 		if (res)
 			return res;
-
+	}
+	if (BIT(port) & info->xmii_mask) {
 		mask = YT921X_XMII_LINK;
 		res = yt921x_reg_clear_bits(priv, YT921X_XMIIn(port), mask);
 		if (res)
@@ -3766,6 +3768,8 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 	       phy_interface_t interface, int speed, int duplex,
 	       bool tx_pause, bool rx_pause)
 {
+	const struct yt921x_info *info = priv->info;
+	struct yt921x_port *pp = &priv->ports[port];
 	u32 mask;
 	u32 ctrl;
 	int res;
@@ -3800,7 +3804,10 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 	if (res)
 		return res;
 
-	if (yt921x_port_is_external(port)) {
+	if (!(BIT(port) & (info->serdes_mask | info->xmii_mask)))
+		return 0;
+
+	if (pp->serdes) {
 		mask = YT921X_SERDES_SPEED_M;
 		switch (speed) {
 		case SPEED_10:
@@ -3836,7 +3843,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
 					     mask, ctrl);
 		if (res)
 			return res;
-
+	} else {
 		mask = YT921X_XMII_LINK;
 		res = yt921x_reg_set_bits(priv, YT921X_XMIIn(port), mask);
 		if (res)
@@ -3876,17 +3883,16 @@ static int
 yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 		   phy_interface_t interface)
 {
+	const struct yt921x_info *info = priv->info;
+	struct yt921x_port *pp = &priv->ports[port];
 	struct device *dev = to_device(priv);
 	u32 mask;
 	u32 ctrl;
 	int res;
 
-	if (!yt921x_port_is_external(port)) {
-		if (interface != PHY_INTERFACE_MODE_INTERNAL) {
-			dev_err(dev, "Wrong mode %d on port %d\n",
-				interface, port);
-			return -EINVAL;
-		}
+	if (BIT(port) & info->internal_mask) {
+		if (interface != PHY_INTERFACE_MODE_INTERNAL)
+			goto err;
 		return 0;
 	}
 
@@ -3896,6 +3902,9 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 	case PHY_INTERFACE_MODE_100BASEX:
 	case PHY_INTERFACE_MODE_1000BASEX:
 	case PHY_INTERFACE_MODE_2500BASEX:
+		if (!(BIT(port) & info->serdes_mask))
+			goto err;
+
 		mask = YT921X_SERDES_CTRL_PORTn(port);
 		res = yt921x_reg_set_bits(priv, YT921X_SERDES_CTRL, mask);
 		if (res)
@@ -3906,6 +3915,11 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 		if (res)
 			return res;
 
+		/* The order is quite arbitrary - we can't return to a safe
+		 * state on IO errors.
+		 */
+		pp->serdes = true;
+
 		mask = YT921X_SERDES_MODE_M;
 		switch (interface) {
 		case PHY_INTERFACE_MODE_SGMII:
@@ -3931,10 +3945,14 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 		break;
 	/* add XMII support here */
 	default:
-		return -EINVAL;
+		goto err;
 	}
 
 	return 0;
+
+err:
+	dev_err(dev, "Wrong mode %d on port %d\n", interface, port);
+	return -EINVAL;
 }
 
 static void
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 83e76cefbccd..fd552f7dced4 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -858,9 +858,6 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_NAME	"yt921x"
 
-#define yt921x_port_is_internal(port) ((port) < 8)
-#define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
-
 struct yt921x_mib {
 	u64 rx_broadcast;
 	u64 rx_pause;
@@ -936,8 +933,12 @@ struct yt921x_acl_blk {
 struct yt921x_port {
 	unsigned char index;
 
-	bool hairpin;
-	bool isolated;
+	/* SerDes in use */
+	bool serdes:1;
+	/* BR_HAIRPIN_MODE */
+	bool hairpin:1;
+	/* BR_ISOLATED */
+	bool isolated:1;
 
 	struct delayed_work mib_read;
 	struct yt921x_mib mib;
-- 
2.53.0

