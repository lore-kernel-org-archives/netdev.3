Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D644F68B4;
	Fri,  2 Oct 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962647; cv=none; b=Ozc9xxrtJD1OUODze9ZIC0getMPGOBSowVUEawdsHdfkAPJmorIc5iXB5tCTgWI54kamJdrhKdxLlcJVmtJsNscmsodu2HuKeWumYWvRCDRuqVPITZR8BfTWF8+GgHdBkZdMhpWtBWx0DEoj+ioO5OUv0suJPt6A6bWnr7khMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962647; c=relaxed/simple;
	bh=skYdvOLGQGoYeecM6YQoKVmb/gcvLXRIZoaa5JiKbIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oo30/R5QTRHTUmVQyDUeZOvTRLixfZ7YyyyjHEN2uKlh02Qae4sZ6gSVQNU5HdDL05Mt+HOJuHnyyF6LSVTeVYVXVFxVjo6LtiYsU1MpF5ysjDx5AqJFx0NZuiB0XKsIBp7kaEYeQaG9hxXdD+VjQPpgg+yzmkzYrMuZV8oQ6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07464526|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0642012-0.000283312-0.935516;FP=13861984445566424980|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jTk7nQP_1790962633;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jTk7nQP_1790962633 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 Oct 2026 01:37:14 +0800
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
Subject: [PATCH net-next v11 1/7] net: dsa: motorcomm: initialize dsa_switch based on chipid
Date: Sat,  3 Oct 2026 01:37:00 +0800
Message-Id: <20261002173706.1225502-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261002173706.1225502-1-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-1-kyle.switch@motor-comm.com>
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
index 3ff2de383157..79422def16ff 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4397,6 +4397,67 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
@@ -4445,6 +4506,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	struct yt921x_reg_mdio *mdio;
 	struct yt921x_priv *priv;
 	struct dsa_switch *ds;
+	int res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -4472,15 +4534,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
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
index 28e4f26f9cc4..69176995090a 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -955,9 +955,28 @@ struct yt921x_info {
 	u16 serdes_mask;
 };
 
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

