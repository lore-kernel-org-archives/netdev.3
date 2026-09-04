Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D137B020;
	Fri,  4 Sep 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516009; cv=none; b=ulDkIpfFKvzNq+DMLDT3BDPVldwHZTkhpLOzWtGFLsDksWJY0sYMOMUcLNJTcZDd85RYYD5f7l67P8Ap1DhAhOpnYRFgd5Ka6I7/eT/tjEWY6CFOFROfLQWB43Ft2oIngpkEZqbRDVdFfb0MBUQDSzVlonzLbPy9aM/8o7Lli6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516009; c=relaxed/simple;
	bh=m8LKCUeJQGJ/rd1Z19dkaxMiLp3hcb1dNvb5MsNkW60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MvukmDFCdvJpQxPuxAw/ydjORVFVfD7qr5/FKhjLpwsHEZ1J8mZDHfL7S/BuIczHO4uXbF9N2VwDWkZI8f+gAslSOdgMzAOC+zKKWX/xIO6UftWnY4VeunJbF8bMM0guRYGon+OcsoL2/SwswFCE/DN+7mGCRj9GBNCZaTleUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07459826|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.10695-0.000477078-0.892573;FP=13862050413042734804|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j5Qgpj7_1788515656;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j5Qgpj7_1788515656 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:54:35 +0800
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
Subject: [PATCH net-next v5 1/6] net: dsa: motorcomm: refactor registration path for upcoming switch families
Date: Fri,  4 Sep 2026 17:54:11 +0800
Message-Id: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce yt92xx_series_info structure to hold private
data for different switch families, replacing hardcoded
logic in probe(). This makes the driver more extensible
for future switch support.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 82 +++++++++++++++++++++++++++-----
 drivers/net/dsa/motorcomm/chip.h | 20 ++++++++
 2 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d663af010f43..557a0e07d8d7 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4679,6 +4679,68 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.setup			= yt921x_dsa_setup,
 };
 
+static const struct yt92xx_series_info yt92xx_series_info_table[] = {
+	[YT921X] = {
+		.mode = YT921X,
+		.name = "YT921X",
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
+static const struct yt92xx_series_info *yt92xx_series_lookup_info(u32 major)
+{
+	enum yt92xx_mode mode = YT_MAX;
+	int i;
+
+	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
+		mode = YT921X;
+
+	for (i = 0; i < ARRAY_SIZE(yt92xx_series_info_table); ++i)
+		if (yt92xx_series_info_table[i].mode == mode)
+			return &yt92xx_series_info_table[i];
+
+	return NULL;
+}
+
+static int yt92xx_register_switch(struct dsa_switch *ds)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	const struct yt92xx_series_info *series_info;
+	u32 chipid;
+	u32 major;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
+	if (res)
+		return res;
+
+	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
+	series_info = yt92xx_series_lookup_info(major);
+	if (!series_info)
+		return -ENODEV;
+	priv->series_info = series_info;
+
+	ds->assisted_learning_on_cpu_port =
+		priv->series_info->assisted_learning_on_cpu_port;
+	ds->dscp_prio_mapping_is_global =
+		priv->series_info->dscp_prio_mapping_is_global;
+	ds->ageing_time_min = priv->series_info->ageing_time_min;
+	ds->ageing_time_max = priv->series_info->ageing_time_max;
+	ds->num_lag_ids = priv->series_info->num_lag_ids;
+	ds->num_ports = priv->series_info->max_ports;
+	ds->ops = priv->series_info->switch_ops;
+	ds->phylink_mac_ops = priv->series_info->mac_ops;
+
+	return 0;
+}
+
 static void yt921x_mdio_shutdown(struct mdio_device *mdiodev)
 {
 	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev);
@@ -4727,6 +4789,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	struct yt921x_reg_mdio *mdio;
 	struct yt921x_priv *priv;
 	struct dsa_switch *ds;
+	int res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -4754,15 +4817,9 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 	ds = &priv->ds;
 	ds->dev = dev;
-	ds->assisted_learning_on_cpu_port = true;
-	ds->dscp_prio_mapping_is_global = true;
-	ds->priv = priv;
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
 
@@ -4770,8 +4827,11 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 }
 
 static const struct of_device_id yt921x_of_match[] = {
-	{ .compatible = "motorcomm,yt9215" },
-	{}
+	{
+		.compatible = "motorcomm,yt9215",
+		.data = &yt92xx_series_info_table[YT921X],
+	},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, yt921x_of_match);
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 83cd454955dd..65f9e6234678 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -960,9 +960,29 @@ struct yt921x_reg_ops {
 	int (*write)(void *context, u32 reg, u32 val);
 };
 
+enum yt92xx_mode {
+	YT921X,
+	YT922X,
+	YT_MAX,
+};
+
+struct yt92xx_series_info {
+	enum yt92xx_mode mode;
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
 
+	const struct yt92xx_series_info *series_info;
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
 	unsigned int port_shape_slot_ns;
-- 
2.25.1

