Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F9339389;
	Tue, 13 Oct 2026 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853901; cv=none; b=n/srddOxBmBOa/AHTXDkAmQEk43B/FHrq5lqy8L/+qZl1BW3m8G9M3WjKtSdTiZHD/4gxDrwsTCbGLZIfc+1wWY83i5EYC9gfFfvH+LU33bvHxt02A2QBD2+RvZkxkZYYQfoPUgVUNHZ4S+9BGm2kvEQnEVxdbHEp2fvxOO81No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853901; c=relaxed/simple;
	bh=1zmAliHHlpkUTTRRjn2bbHx7tCRwJu0o5p/8s9/WGlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oy0Cfa/5PILpW/wRsXCY+WKMFwF9v8TgqdypUSwVuOfe0Rhy5gp+AFqHdJCDwfyoIJCAle4w0WyJ2xVivoGs2V9V56BS/IZwGCzIFiQfA/E+HtMsKkHDmkXHEIppKJ9DCgEMVLQgCu4uALss4KVRZb2CGwGMN8V4A2iXOHn2+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0745587|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.13946-0.00046838-0.860071;FP=13861843708078069396|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jatt1GA_1791853887;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jatt1GA_1791853887 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 09:11:28 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v14 1/5] net: dsa: motorcomm: initialize dsa_switch based on chipid
Date: Tue, 13 Oct 2026 09:11:18 +0800
Message-Id: <20261013011122.1889766-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hardcoded chip handling in yt92xx_register_switch() with a
data-driven loopup based on the chip ID.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 73 ++++++++++++++++++++++++++++----
 drivers/net/dsa/motorcomm/chip.h | 19 +++++++++
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 91cc5647f2b6..d4c20658216a 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4078,6 +4078,67 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.setup			= yt921x_dsa_setup,
 };
 
+static const struct yt92xx_series yt92xx_series_table[] = {
+	[YT92XX_MODE_YT921X] = {
+		.name = "YT921x",
+		.max_ports = YT921X_PORT_NUM,
+		.num_lag_ids = YT921X_LAG_NUM,
+		.ageing_time_min = 1 * 5000,
+		.ageing_time_max = U16_MAX * 5000,
+		.dscp_prio_mapping_is_global = true,
+		.assisted_learning_on_cpu_port = true,
+		.switch_ops = &yt921x_dsa_switch_ops,
+		.mac_ops = &yt921x_phylink_mac_ops
+	},
+};
+
+static const struct yt92xx_series *yt92xx_series_lookup(u32 major)
+{
+	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
+		return &yt92xx_series_table[YT92XX_MODE_YT921X];
+	else
+		return NULL;
+}
+
+static int yt92xx_register_switch(struct dsa_switch *ds)
+{
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
+	const struct yt92xx_series *series;
+	u32 chipid;
+	u32 major;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
+	mutex_unlock(&priv->reg_lock);
+	if (res) {
+		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
+		return res;
+	}
+
+	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
+	series = yt92xx_series_lookup(major);
+	if (!series) {
+		dev_err(dev, "Undefined series info for the corresponding major\n");
+		return -ENODEV;
+	}
+	priv->series = series;
+
+	ds->assisted_learning_on_cpu_port =
+		priv->series->assisted_learning_on_cpu_port;
+	ds->dscp_prio_mapping_is_global =
+		priv->series->dscp_prio_mapping_is_global;
+	ds->ageing_time_min = priv->series->ageing_time_min;
+	ds->ageing_time_max = priv->series->ageing_time_max;
+	ds->num_lag_ids = priv->series->num_lag_ids;
+	ds->num_ports = priv->series->max_ports;
+	ds->ops = priv->series->switch_ops;
+	ds->phylink_mac_ops = priv->series->mac_ops;
+
+	return 0;
+}
+
 static void yt921x_mdio_shutdown(struct mdio_device *mdiodev)
 {
 	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev);
@@ -4120,6 +4181,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	struct yt921x_reg_mdio *mdio;
 	struct yt921x_priv *priv;
 	struct dsa_switch *ds;
+	int res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -4146,15 +4208,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 	ds = &priv->ds;
 	ds->dev = dev;
-	ds->assisted_learning_on_cpu_port = true;
-	ds->dscp_prio_mapping_is_global = true;
 	ds->priv = priv;
-	ds->ops = &yt921x_dsa_switch_ops;
-	ds->ageing_time_min = 1 * 5000;
-	ds->ageing_time_max = U16_MAX * 5000;
-	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
-	ds->num_lag_ids = YT921X_LAG_NUM;
-	ds->num_ports = YT921X_PORT_NUM;
+	res = yt92xx_register_switch(ds);
+	if (res)
+		return res;
 
 	mdiodev_set_drvdata(mdiodev, priv);
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 25ff77054de3..85174a51b72d 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -841,9 +841,28 @@ static inline u16 yt921x_info_ports_mask(const struct yt921x_info *info)
 	return info->internal_mask | info->xmii_mask | info->serdes_mask;
 }
 
+enum yt92xx_mode {
+	YT92XX_MODE_YT921X,
+	YT92XX_MODE_YT922X,
+	YT92XX_MODE_MAX,
+};
+
+struct yt92xx_series {
+	const char *name;
+	unsigned int max_ports;
+	unsigned int num_lag_ids;
+	unsigned int ageing_time_min;
+	unsigned int ageing_time_max;
+	u32 dscp_prio_mapping_is_global;
+	u32 assisted_learning_on_cpu_port;
+	const struct dsa_switch_ops *switch_ops;
+	const struct phylink_mac_ops *mac_ops;
+};
+
 struct yt921x_priv {
 	struct dsa_switch ds;
 
+	const struct yt92xx_series *series;
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
 	unsigned int port_shape_slot_ns;
-- 
2.25.1

