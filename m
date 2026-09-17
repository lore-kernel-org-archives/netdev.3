Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383173FFF94;
	Thu, 17 Sep 2026 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633376; cv=none; b=QSHPWU7jVOuMxDNCfHeU0t0Dn1EkySpP4YraK9/PWBN7WkxA2o0X0hRGt2/zPRaQARswmtLlEyTLZsDTvYxVsl823qz5fZ44YjlhOGx4baaDZ3ngjHC1pwBvG5aneTpVHLt1eAruoNlzOdEHlitjGXEHA6L+UciwfpReRrL7JUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633376; c=relaxed/simple;
	bh=ZvjDEUxH4HFn4j4nggBkzAJfY+X/FREvjjj+8bYLkdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWC1JKW/CB37lu2jc28bQ0r3qA+Q+knWIVahBGfuX/XVhSmYznkPm52ZeePl4Zu4ljgaJo7fxQaISS5xsWzsrUuz4KGIpFXB8Sf4ceep0uX41XSp7Is7FNrunj6l2R63l4qdT6pLu7JuGd6Of5UoiKnuRpa03BmDqfBTBH96m0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07608723|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.137994-0.000360551-0.861646;FP=13871053215324903060|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jFhn5xf_1789633362;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jFhn5xf_1789633362 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:22:43 +0800
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
Subject: [PATCH net-next v8 1/6] net: dsa: motorcomm: initialize dsa_switch based on chipid
Date: Thu, 17 Sep 2026 16:22:31 +0800
Message-Id: <20260917082236.3427168-2-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce yt92xx_series structure to hold private data
for different switch families, replacing hardcoded logic
in probe(). This makes the driver more extensible for
future switch support.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 69 ++++++++++++++++++++++++++++----
 drivers/net/dsa/motorcomm/chip.h | 20 +++++++++
 2 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index d663af010f43..564e45ece22c 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4679,6 +4679,63 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.setup			= yt921x_dsa_setup,
 };
 
+static const struct yt92xx_series yt92xx_series_table[] = {
+	[YT92XX_MODE_YT921X] = {
+		.mode = YT92XX_MODE_YT921X,
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
+	const struct yt92xx_series *series;
+	u32 chipid;
+	u32 major;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
+
+	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
+	series = yt92xx_series_lookup(major);
+	if (!series)
+		return -ENODEV;
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
@@ -4727,6 +4784,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	struct yt921x_reg_mdio *mdio;
 	struct yt921x_priv *priv;
 	struct dsa_switch *ds;
+	int res;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -4754,15 +4812,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
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
index 83cd454955dd..c446aea449ed 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -960,9 +960,29 @@ struct yt921x_reg_ops {
 	int (*write)(void *context, u32 reg, u32 val);
 };
 
+enum yt92xx_mode {
+	YT92XX_MODE_YT921X,
+	YT92XX_MODE_YT922X,
+	YT92XX_MODE_MAX,
+};
+
+struct yt92xx_series {
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
 
+	const struct yt92xx_series *series;
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
 	unsigned int port_shape_slot_ns;
-- 
2.25.1

