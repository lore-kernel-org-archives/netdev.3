Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A34C10CA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671138; cv=none; b=prcLqweO6T2pisWMB65Lyj4nIFgItqSPd2frdGz3FgZRnMn8Dxq1ENJ3416RjrVssDEHyp4DL/riLHn9jLB4rwKBXcSLYwE+4V6nL/Gp0k1aEcEyxovrnNb4qOaGbcEBD5/sw8QZH0rcS785K87vxWTH9MEJQy9pu5YbNTioD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671138; c=relaxed/simple;
	bh=njI0Vg2kOdmWdWb4y8lHpI6W6+rIKolqjl46KofA73Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbPOJOgsz7FhI/WoVeVX7pvGTimubgpQIgY0KYhgyPvB7V9DkNC4+rDPFilY6MIMmTCS9w12C1XHcKfMPAwKIxkcv/2Eg9TqT6phhdc2EJHt3xVvmmoGrwsAe0g8OtAOsglltB1I39nVaQfXloxyFmavnHGAWoSYHoSac9C5Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUagOhPu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUagOhPu"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fb334ddcso10878195ad.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671136; x=1790275936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y81t7BgQ+dtg+VKzZrcT7SMjZASx7AevuRrRDGaFD9s=;
        b=pUagOhPuMrXTUOYk0NtcEkNe2Z17yHwLqkt6sQLmSBErvDuoi/RGmho+FvsGUiWSSs
         xPnvmlMpU3V0YH13fF5l9OMkaExXf+AXsP1CkWV+HiokkG/E4UwpyrTPPbpnSHAyj4dy
         ylO3gbJ+0txTkBgjZQfAS0QLuQljHsOMWypYiVUZZpM2HyCS2zKLgvrISD3yqLT5Te2x
         oJBEXRUO8c+kl7KE5T9HqXtPD+4OxhLkJk9UIMjxBh+EitYi3sOfPE4MkFesd6lWknqR
         C14MgLW4RfdrjrD76FILXxvrFTQBJA2TfYNk4k/jp3fbpnFbQX7CUdIJuLB49s3vTKNq
         oU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671136; x=1790275936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y81t7BgQ+dtg+VKzZrcT7SMjZASx7AevuRrRDGaFD9s=;
        b=agwLil4N6kPtDW1C6BLozWtwoK8p3qhJLEARDE/m+HahKhFlMB+bon3R9jkO7uxpx9
         vb+G9+GjU5N3D1MrXPB+pMve45PzO3tMYeY6QOH5Wh+7HdlldqjUlcHDdmlywLVYYCLC
         I7x9EIhnA0GSYRwi5/PRcscT1yX06hjNgasMOQshVHyBCm2c0aBaYS6PIjtKh/CRGhKh
         Bg3l58LDU+LBQ40semgybJeignNDoIAVmEpXaBlDE4LMBsxn1+JeIFy6ZgAun/lcFdtP
         dYetE0Jay/ZzdqC8okZynlr9lU1JiHI1LPlpVrtY3FBjFfJPc8sbGUXlQ2Ytqx5z5FKV
         0wtA==
X-Gm-Message-State: AFuF++l5DRfxk+KtusfzajeUggOk+clC7MiO2qb69ZwYO+So0Kf2Hn6E
	DD0YuJXTJh3UKTuWUkGu6t1TPUhKLtyPs+i7tGG8ZmVFb6SbCnSM/M3Zfo4oLSuw
X-Gm-Gg: AYBFou3mRiadPK+Z4NSr8S0lonvjNwDDknjk7px1XPmvMmlZvJgQcY2iH+0U4IWGKfE
	6mWwWxEpGmPswPgelIhzcKaQKuF1ayElW8rh3ZJz3wq6n1TRvKkfBU25j8Ww/dX5EyNDE89TPt1
	ZV+jjIEKSTWWGn+H93KanSkdpEA+Ak3Tu/XjqN7jSC6fGIZikkd10Ny6rzeOjcK4aaBM+spsi7E
	QAj8NaA4tJKQgNqYkyl3Xq/9HGIb5FKU4XzYIX3vOajjY4hhWACdXvDg+c/wxGwjy4F8OrKpxRh
	7REvMNaC1csYOmL/iNqhybZXHV0kGFFl19lsMUWFs0k5iIubDA9mbsAFQQiQKdHN/z6OEETqvaG
	Ixyf4/vxz1fcvYTRRlqxJlH+EVdn6Yjqsxk19fvxBoMigUjI4UrK4KKjfYRZXxYlxF8YFwcg9j1
	l2NMPxCEkfPyh1VgdPTpsd3HDfl620/9fuka959RM5wRsTQACvVjp9L2TtOTuyZXofW6U2o+K1D
	sqVorTd1WBNvd/XenruYaJgqA==
X-Received: by 2002:a17:903:32c5:b0:2d9:2fc9:5706 with SMTP id d9443c01a7336-2ddb1ab3aabmr3003155ad.2.1789671131159;
        Thu, 17 Sep 2026 11:52:11 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:10 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/8] net: dsa: motorcomm: Check port type with runtime info
Date: Fri, 18 Sep 2026 02:49:50 +0800
Message-ID: <20260917185010.3189199-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The yt921x_port_is_internal/external() macros hardcoded the port layout:
they treat ports 8 and 9 as external on every chip and count the dummy
ports as internal. Drop them and identify the port type using chip info
and runtime configuration.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 39 +++++++++++++++++++++++---------
 drivers/net/dsa/motorcomm/chip.h | 11 +++++----
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index b527a9cfd3e8..bcc9542370c2 100644
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
@@ -3928,13 +3937,21 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
 		if (res)
 			return res;
 
+		/* The order is quite arbitrary - we can't return to a safe
+		 * state on IO errors.
+		 */
+		pp->serdes = true;
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

