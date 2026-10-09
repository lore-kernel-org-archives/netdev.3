Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3384E0B6E;
	Fri,  9 Oct 2026 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548944; cv=none; b=UrjXygjEXjYlCbX0jPt7JyZF+OM126N2KOcy/Cpx99LcaG8zA26eFB0XomUUHXaOUbJ1Wc0YV5sZvij/grcHQ2d4doL38Aq2T07MvNA4hfHwVY6EqSUPcbKHFI1WzStDbh89UlaA5leEU7bYqqm/vnVRPDB6Iq8AREv5P0HD8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548944; c=relaxed/simple;
	bh=uNVlQxA0kcIGPIelViqthoJL7udgvHLY/tdqc5PnYr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLWRR++2srPm11X91miDGs8xYZBTIj9qh5V120l90Od9BlraifuZPFPBvGp9/kgJ2nonu6/Z0IgUFS8c5QXAGzvHq5620YUCALF+C9yI/mSThaGHPCoLCqvZziX4bFvhlNdofiD15iiiFGJIUWE3Cgpv1N0yF0G+P25hVh3sK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07458515|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.13946-0.00046838-0.860071;FP=13861808523705980564|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jXj4ZxQ_1791548923;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jXj4ZxQ_1791548923 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Oct 2026 20:28:43 +0800
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
Subject: [PATCH net-next v12 1/5] net: dsa: motorcomm: initialize dsa_switch based on chipid
Date: Fri,  9 Oct 2026 20:28:32 +0800
Message-Id: <20261009122836.1534400-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261009122836.1534400-1-kyle.switch@motor-comm.com>
References: <20261009122836.1534400-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hardcoded chip handling in yt92xx_register_switch() with a
data-driven loopup based on the chip ID.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 73 ++++++++++++++++++++++++++++----
 drivers/net/dsa/motorcomm/chip.h | 19 +++++++++
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 91cc5647f2b6..76bf68af8915 100644
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
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
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

