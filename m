Received: from out198-4.us.a.mail.aliyun.com (out198-4.us.a.mail.aliyun.com [47.90.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166BF4F1;
	Wed,  2 Sep 2026 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317286; cv=none; b=Q3oeEG68L8QE+hVJIX5c5fmi2+ZaN1tfQY0kY9AWhncAmQxUFrgmx9GM3uhme3B3IZO+Gx6UV/JtUSop4BFJasYve3lSV3sqxXhBt7VjrmR3Mh8zJ0D21zlX46q3U9HAw+7+2sfb47Kcwwso1mLcXaJiPumun8rymWWSx/fBe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317286; c=relaxed/simple;
	bh=Uqa9gkizaulzr2GkBJfJ1H30g6wcFX3f8BFL8bEoxuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFBkjrYqnXpCKvmjMrTDVwfOJSj6L2U+yGwvQYrT2Bl8mh/TfpKgWkDgqh+a+gVVvcWF6R0HCPDEEDeU9CfpGZm0Q1mUaPpTzLNSfY3IH+lD74CKPHcVeN+LXPv+yaySES02CGBsCbFAfpbEwd2yDisQ+21YwlOZRQT4nE3Cxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0463333-0.000178527-0.953488;FP=16245952157201342130|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.j33T-Rs_1788317257;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j33T-Rs_1788317257 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 10:47:43 +0800
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
	jianmin.wang@motor-comm.com
Subject: [PATCH net-next v4] net: dsa: yt921x: Optimize driver for better generality.
Date: Wed,  2 Sep 2026 10:47:37 +0800
Message-Id: <20260902024737.587386-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace fixed macros with values defined in series_info
for port validity checks, in order to facilitate future
adaptation to more switch series.

Replace all fixed values for DSA switch attributes with
values defined in series_info, to enable better scalability
across different switch families.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---

v4:
1. Split patch into multiple patches
2. Optimize existing code for better switch family scalability.

v3: https://lore.kernel.org/all/0c8024bc-c444-42ea-83fc-88446c8c560e@motor-comm.com
1. Post the driver as a patchset.
2. Remove unnecessary macros.
3. Add mib_working to indicate whether the MIB has been initialized.
4. Fix any errors found

v2: https://lore.kernel.org/all/20260820080542.2017118-1-kyle.switch@motor-comm.com
1. Seperate tag_yt922x into an individual file.
2. Fix the issues from the previous version.
3. Optimize the code style to keep it consistent with the existing code style.

v1: https://lore.kernel.org/all/20260813104137.55550-1-kyle.switch@motor-comm.com
1. Add basic functional interfaces for the YT922X DSA driver.
2. Although the DSA driver supports both YT922X and YT921X simultaneously,
   the original file names are still maintained for now;
   the file naming may be optimized in the future.
3. Currently, the dsa_switch_ops structure is employed as the operational interface.
   In future phases, as functionality expands, the architecture will be refactored
   to introduce yt922x_dsa_ops, where chip-specific operations will be distinguished
   between YT922X and YT921X, following a design pattern commonly adopted by other
   existing multi-series DSA drivers.
4. A new thread(patch series) is created. Although a previous version was submitted,
   the changes are substantial, so the old version is not relevant for reference.

 drivers/net/dsa/yt921x.c | 78 ++++++++++++++++++++++++++++++++++------
 drivers/net/dsa/yt921x.h | 16 +++++++++
 2 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 159b16606f6c..9bea42b61847 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -151,6 +151,8 @@ static const struct yt921x_info yt921x_infos[] = {
 	{}
 };
 
+static const struct yt92xx_series_info yt92xx_series_info_table[];
+
 #define YT921X_NAME	"yt921x"
 
 #define YT921X_VID_UNWARE	4095
@@ -563,7 +565,7 @@ static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
 	u16 val;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	if (port >= priv->series_info->max_ports)
 		return U16_MAX;
 
 	mutex_lock(&priv->reg_lock);
@@ -581,7 +583,7 @@ yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
 	struct yt921x_priv *priv = mbus->priv;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	if (port >= priv->series_info->max_ports)
 		return -ENODEV;
 
 	mutex_lock(&priv->reg_lock);
@@ -596,6 +598,7 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 {
 	struct device *dev = to_device(priv);
 	struct mii_bus *mbus;
+	u32 max_port;
 	int res;
 
 	mbus = devm_mdiobus_alloc(dev);
@@ -608,7 +611,8 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 	mbus->read = yt921x_mbus_int_read;
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
-	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
+	max_port = priv->series_info->max_ports;
+	mbus->phy_mask = (u32)~GENMASK(max_port - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
@@ -4430,8 +4434,36 @@ static int yt921x_edata_read(struct yt921x_priv *priv, u8 addr, u8 *valp)
 	return yt921x_edata_read_cont(priv, addr, valp);
 }
 
+static const struct yt92xx_series_info yt92xx_series_info_table[] = {
+	[YT921X] = {
+		.chip_mode = YT921X,
+		.max_ports = YT921X_PORT_NUM,
+		.num_lag_ids = YT921X_LAG_NUM,
+		.ageing_time_min = 1 * 5000,
+		.ageing_time_max = U16_MAX * 5000,
+		.dscp_prio_mapping_is_global = true,
+		.assisted_learning_on_cpu_port = true,
+	},
+};
+
+static const struct yt92xx_series_info *yt92xx_series_lookup_info(u32 major)
+{
+	enum chip_mode mode = YT_MAX;
+	int i;
+
+	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
+		mode = YT921X;
+
+	for (i = 0; i < ARRAY_SIZE(yt92xx_series_info_table); ++i)
+		if (yt92xx_series_info_table[i].chip_mode == mode)
+			return &yt92xx_series_info_table[i];
+
+	return NULL;
+}
+
 static int yt921x_chip_detect(struct yt921x_priv *priv)
 {
+	const struct yt92xx_series_info *series_info;
 	struct device *dev = to_device(priv);
 	const struct yt921x_info *info;
 	u8 extmode;
@@ -4447,6 +4479,11 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 
 	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
 
+	series_info = yt92xx_series_lookup_info(major);
+	if (!series_info)
+		return -ENODEV;
+	priv->series_info = series_info;
+
 	for (info = yt921x_infos; info->name; info++)
 		if (info->major == major)
 			break;
@@ -4740,6 +4777,20 @@ static int yt921x_chip_setup(struct yt921x_priv *priv)
 	return 0;
 }
 
+static void yt92xx_register_switch(struct dsa_switch *ds)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+
+	ds->assisted_learning_on_cpu_port =
+		priv->series_info->assisted_learning_on_cpu_port;
+	ds->dscp_prio_mapping_is_global =
+		priv->series_info->dscp_prio_mapping_is_global;
+	ds->ageing_time_min = priv->series_info->ageing_time_min;
+	ds->ageing_time_max = priv->series_info->ageing_time_max;
+	ds->num_lag_ids = priv->series_info->num_lag_ids;
+	ds->num_ports = priv->series_info->max_ports;
+}
+
 static int yt921x_dsa_setup(struct dsa_switch *ds)
 {
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
@@ -4786,6 +4837,8 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	if (res)
 		return res;
 
+	yt92xx_register_switch(ds);
+
 	return 0;
 }
 
@@ -4913,11 +4966,16 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 
 static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 {
+	const struct yt92xx_series_info *compat_info = NULL;
 	struct device *dev = &mdiodev->dev;
 	struct yt921x_reg_mdio *mdio;
 	struct yt921x_priv *priv;
 	struct dsa_switch *ds;
 
+	compat_info = of_device_get_match_data(dev);
+	if (!compat_info)
+		return -EINVAL;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -4932,6 +4990,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 	mutex_init(&priv->reg_lock);
 
+	priv->series_info = compat_info;
 	priv->reg_ops = &yt921x_reg_ops_mdio;
 	priv->reg_ctx = mdio;
 
@@ -4944,15 +5003,9 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 	ds = &priv->ds;
 	ds->dev = dev;
-	ds->assisted_learning_on_cpu_port = true;
-	ds->dscp_prio_mapping_is_global = true;
 	ds->priv = priv;
 	ds->ops = &yt921x_dsa_switch_ops;
-	ds->ageing_time_min = 1 * 5000;
-	ds->ageing_time_max = U16_MAX * 5000;
 	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
-	ds->num_lag_ids = YT921X_LAG_NUM;
-	ds->num_ports = YT921X_PORT_NUM;
 
 	mdiodev_set_drvdata(mdiodev, priv);
 
@@ -4960,8 +5013,11 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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
 
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 5f3b99e189c4..cc8223ea5f29 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -945,9 +945,25 @@ struct yt921x_reg_ops {
 	int (*write)(void *context, u32 reg, u32 val);
 };
 
+enum chip_mode {
+	YT921X,
+	YT_MAX,
+};
+
+struct yt92xx_series_info {
+	enum chip_mode chip_mode;
+	unsigned int max_ports;
+	unsigned int num_lag_ids;
+	unsigned int ageing_time_min;
+	unsigned int ageing_time_max;
+	u32 dscp_prio_mapping_is_global;
+	u32 assisted_learning_on_cpu_port;
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

