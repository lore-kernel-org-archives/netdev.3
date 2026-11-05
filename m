Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848502;
	b=CYZTy3k2PvTAlbBv7Xm8OsYoxR5IXK77Pp9SGIH7ctTnnD/s1ozCkhzbIOuqGwv4e8lN
	 TNe62Ln9DPzL/6hccF2dBzd8l2YpCQr1N/mSeL1nMOjeCrCXsdsTzUjoaH0eZVBBjCP7d
	 UGFml8kwzyj8uRd+c7vTByE4b/WdOoWU7Q0y2Om2EMXrSVYkH78Z1+J9i0VLjdTqGJIV3
	 HI/641EsWltX1ZaVO4e+WXV3CByHBl5oHsYoq80CHwSdEdrk2aVjpvcuDX3UIFwTFaL1M
	 e5u6OGqwHlO8EkjCz5rqFcCCHl3fX1xVX9UQB1JMkwtgfJOd3Th7G3QX2n+MmKz6ZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848502;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x9iSpbhGIj8JBA245J5cxgtHj7UMy2YV69ktT0NZPQU=;
	b=I39g6h19ueFGtb+CiPeXprTol6q7CrPje33m1rlJxHHY9o9Aa3GdGN4gaE3RWbI57fP9
	 0Mq009LtVCBfrzpnI7aWVYgyrUBX38CI/83dc+Tvv5TEy7pkcgEewpQKz3qkcyZIP80rl
	 1rPSiahXWdj1TwVivytmb+AoTZD2SzjqWXDtLHaArifVNEf+fHI2q/8oRH+uiHsxrWy8n
	 VszqQzBLlsa0M4uy4rxnSIsRv7rOwG0DL6wouHbWOMbMAo5YDHLTgjBVG+tnY1yW60Qo3
	 Dyg5xcxt+59LFVE0cUTOJwzr93HeGNX4GeJO5LmA+vpc1Jrnjc6DLC4D6aqfkzLBbEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.217
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA8606A329;
	Thu,  5 Nov 2026 03:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91EA8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07452728|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.138644-0.000463989-0.860892;FP=13861984445566424724|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jx7-i05_1793848490;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jx7-i05_1793848490 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 11:14:50 +0800
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
Subject: [PATCH net-next v17 1/5] net: dsa: motorcomm: initialize dsa_switch based on chipid
Date: Thu,  5 Nov 2026 11:14:38 +0800
Message-Id: <20261105031442.4164960-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
References: <20261105031442.4164960-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
index 33e5fc127244..2dd4240ee246 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -2574,6 +2574,67 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
@@ -2616,6 +2677,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	struct yt921x_reg_mdio *mdio;
 	struct yt921x_priv *priv;
 	struct dsa_switch *ds;
+	int res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -2642,15 +2704,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
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
index fc315f1d8f87..fd6a0021e98e 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -503,9 +503,28 @@ static inline u16 yt921x_info_ports_mask(const struct yt921x_info *info)
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

