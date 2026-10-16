Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7D4D90B7;
	Fri, 16 Oct 2026 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164316; cv=none; b=X+VyP4zHwgysyYfXm2cWpWwn3fVL4yFRyTLxkQ8ZdOufwoSiPesjryveijegN40XCuIXRR/gUv0XiYBk5anyzjLwGmVatUOs+lA7UdmqRLUEKouBR83ShOehNvBZDK6QIVm/+vEU1fssqXJ3nrRUU01yVGYMCRYAzxJE6wEIsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164316; c=relaxed/simple;
	bh=zpP7cXL6lJgZ0VXUHjYdSxjPbDi8bSemC9JSNi0suhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djjAYpvzX62khwsUl/wGnx/FcvNScgr0t2bSvD1pQ3xlrqi327iSotyt2OuKPHvZbd3YHtSOjwBS0nwFDwjhQNgfWTMK5gjVYMZp7CdoewtAvKEL3YEQo3byzZ9plc8gTXS/agDTUV/pLca1gE9kYLGYgIq5+PfIKX7wxkKKktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=seolZQT8; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="seolZQT8"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 121C5240AEA;
	Fri, 16 Oct 2026 17:25:07 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id C5501240453;
	Fri, 16 Oct 2026 17:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792164304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvTFsAGrGnjGewZniiLfRZ+2Ex3OeHa4r0dCOmSw8mA=;
	b=seolZQT8tkVoQTr5qabXJzfKiwiNKKff+eyiMvNbM+EvZefrjz6XmrCPr/UD1eJfcC3igA
	qeOxwO4oTzDRW+hq1jtAzJLItgeEcNVxvnlmVFCBXA1ApXWuNU1B9Y2EbcvMjir5Wqju4u
	LS9zG/feh+LA0wvnBsmwS3BDUMZpiiA/DM9sBqtYzi1J+B0b+uqKw5dLW1R8+sVXT33MS5
	WZ9+uowU1af+NmExGwTQ3Ykx9KE2JcFTERpyZVs7FqPUxN3zeEzHvxmgPX/VNiRtO4YVNU
	vNrUx7yU9bR3SggPn1O4BnXH/pw154o3wp+kLquW9+Crqdh5KeFMaphfvB4GZQ==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 642BB2404EF;
	Fri, 16 Oct 2026 17:25:01 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: jie.luo@oss.qualcomm.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: ethernet: qualcomm: ppe: Select hardware configuration by SoC
Date: Fri, 16 Oct 2026 17:24:47 +0200
Message-ID: <20261016152449.934312-2-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016152449.934312-1-mail@tk154.de>
References: <20261016152449.934312-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 279e0e
X-Rspamd-UID: a93555

The PPE driver hardcodes IPQ9574 parameters: the PPE clock rate,
interconnect paths, port count, buffer limits and scheduler arbitration
tables. Other SoCs with the same PPE architecture need different values.

Move these into per-SoC platform match data, and collect the buffer
manager (BM), queue manager (QM) and scheduler tables in a new struct
ppe_soc_config that is passed to the hardware initialization code. The
IPQ9574 values are unchanged; no functional change intended.

The IPQ9574 scheduler resource table has nine entries, with the reserved
pool at index 8. Select that final entry for port ID num_ports, preserving
the IPQ9574 lookup while allowing a smaller port count on other SoCs.

Rename regmap_config_ipq9574 to ppe_reg_config for the shared PPE
register layout.

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c       | 48 ++++++++++-----
 .../net/ethernet/qualcomm/ppe/ppe_config.c    | 58 +++++++++++++------
 .../net/ethernet/qualcomm/ppe/ppe_config.h    | 34 ++++++++++-
 3 files changed, 106 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 3c301e609d3e..0ef72c20364b 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -18,13 +19,15 @@
 #include "ppe_config.h"
 #include "ppe_debugfs.h"
 
-#define PPE_PORT_MAX		8
-#define PPE_CLK_RATE		353000000
+struct ppe_plat_data {
+	const struct ppe_soc_config *soc_cfg;
+	const struct icc_bulk_data *icc_data;
+	unsigned long ppe_clk_rate;
+	unsigned int num_icc, num_ports;
+};
 
-/* ICC clocks for enabling PPE device. The avg_bw and peak_bw with value 0
- * will be updated by the clock rate of PPE.
- */
-static const struct icc_bulk_data ppe_icc_data[] = {
+/* IPQ9574 interconnect paths. Zero bandwidths use the PPE clock rate. */
+static const struct icc_bulk_data ipq9574_icc_data[] = {
 	{
 		.name = "ppe",
 		.avg_bw = 0,
@@ -62,6 +65,15 @@ static const struct icc_bulk_data ppe_icc_data[] = {
 	},
 };
 
+static const struct ppe_plat_data ipq9574_ppe_data = {
+	.soc_cfg = &ipq9574_soc_config,
+	.icc_data = ipq9574_icc_data,
+	.ppe_clk_rate = 353000000,
+	.num_icc = ARRAY_SIZE(ipq9574_icc_data),
+	.num_ports = 8,
+};
+
+/* PPE register access ranges. */
 static const struct regmap_range ppe_readable_ranges[] = {
 	regmap_reg_range(0x0, 0x1ff),		/* Global */
 	regmap_reg_range(0x400, 0x5ff),		/* LPI CSR */
@@ -99,7 +111,7 @@ static const struct regmap_access_table ppe_reg_table = {
 	.n_yes_ranges = ARRAY_SIZE(ppe_readable_ranges),
 };
 
-static const struct regmap_config regmap_config_ipq9574 = {
+static const struct regmap_config ppe_reg_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -108,7 +120,8 @@ static const struct regmap_config regmap_config_ipq9574 = {
 	.max_register = 0xbef800,
 };
 
-static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
+static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev,
+				    const struct icc_bulk_data *ppe_icc_data)
 {
 	unsigned long ppe_rate = ppe_dev->clk_rate;
 	struct device *dev = ppe_dev->dev;
@@ -172,12 +185,17 @@ static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
 
 static int qcom_ppe_probe(struct platform_device *pdev)
 {
+	const struct ppe_plat_data *plat_data;
 	struct device *dev = &pdev->dev;
 	struct ppe_device *ppe_dev;
 	void __iomem *base;
 	int ret, num_icc;
 
-	num_icc = ARRAY_SIZE(ppe_icc_data);
+	plat_data = device_get_match_data(dev);
+	if (!plat_data)
+		return -EINVAL;
+
+	num_icc = plat_data->num_icc;
 	ppe_dev = devm_kzalloc(dev, struct_size(ppe_dev, icc_paths, num_icc),
 			       GFP_KERNEL);
 	if (!ppe_dev)
@@ -187,20 +205,20 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return dev_err_probe(dev, PTR_ERR(base), "PPE ioremap failed\n");
 
-	ppe_dev->regmap = devm_regmap_init_mmio(dev, base, &regmap_config_ipq9574);
+	ppe_dev->regmap = devm_regmap_init_mmio(dev, base, &ppe_reg_config);
 	if (IS_ERR(ppe_dev->regmap))
 		return dev_err_probe(dev, PTR_ERR(ppe_dev->regmap),
 				     "PPE initialize regmap failed\n");
 	ppe_dev->dev = dev;
-	ppe_dev->clk_rate = PPE_CLK_RATE;
-	ppe_dev->num_ports = PPE_PORT_MAX;
+	ppe_dev->clk_rate = plat_data->ppe_clk_rate;
+	ppe_dev->num_ports = plat_data->num_ports;
 	ppe_dev->num_icc_paths = num_icc;
 
-	ret = ppe_clock_init_and_reset(ppe_dev);
+	ret = ppe_clock_init_and_reset(ppe_dev, plat_data->icc_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "PPE clock config failed\n");
 
-	ret = ppe_hw_config(ppe_dev);
+	ret = ppe_hw_config(ppe_dev, plat_data->soc_cfg);
 	if (ret)
 		return dev_err_probe(dev, ret, "PPE HW config failed\n");
 
@@ -219,7 +237,7 @@ static void qcom_ppe_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_ppe_of_match[] = {
-	{ .compatible = "qcom,ipq9574-ppe" },
+	{ .compatible = "qcom,ipq9574-ppe", .data = &ipq9574_ppe_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_ppe_of_match);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 125b73be92b1..65ac6c0841d5 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -835,6 +835,19 @@ static const struct ppe_port_schedule_resource ppe_scheduler_res[] = {
 	},
 };
 
+const struct ppe_soc_config ipq9574_soc_config = {
+	.bm_group_config = ipq9574_ppe_bm_group_config,
+	.bm_port_config = ipq9574_ppe_bm_port_config,
+	.bm_port_config_cnt = ARRAY_SIZE(ipq9574_ppe_bm_port_config),
+	.qm_group_config = ipq9574_ppe_qm_group_config,
+	.qm_queue_config = ipq9574_ppe_qm_queue_config,
+	.qm_queue_config_cnt = ARRAY_SIZE(ipq9574_ppe_qm_queue_config),
+	.sch_bm_config = ipq9574_ppe_sch_bm_config,
+	.sch_bm_config_cnt = ARRAY_SIZE(ipq9574_ppe_sch_bm_config),
+	.sch_qm_config = ipq9574_ppe_sch_qm_config,
+	.sch_qm_config_cnt = ARRAY_SIZE(ipq9574_ppe_sch_qm_config),
+};
+
 /* Set the PPE queue level scheduler configuration. */
 static int ppe_scheduler_l0_queue_map_set(struct ppe_device *ppe_dev,
 					  int node_id, int port,
@@ -1080,7 +1093,12 @@ int ppe_port_resource_get(struct ppe_device *ppe_dev, int port,
 	if (port > ppe_dev->num_ports)
 		return -EINVAL;
 
-	res = ppe_scheduler_res[port];
+	/* Port ID num_ports selects the reserved pool in the final entry. */
+	if (port == ppe_dev->num_ports)
+		res = ppe_scheduler_res[ARRAY_SIZE(ppe_scheduler_res) - 1];
+	else
+		res = ppe_scheduler_res[port];
+
 	switch (type) {
 	case PPE_RES_UCAST:
 		*res_start = res.ucastq_start;
@@ -1427,7 +1445,8 @@ static int ppe_config_bm_threshold(struct ppe_device *ppe_dev, int bm_port_id,
 }
 
 /* Configure the buffer threshold for the port flow control function. */
-static int ppe_config_bm(struct ppe_device *ppe_dev)
+static int ppe_config_bm(struct ppe_device *ppe_dev,
+			 const struct ppe_soc_config *soc_cfg)
 {
 	const struct ppe_bm_port_config *port_cfg;
 	unsigned int i, bm_port_id, port_cfg_cnt;
@@ -1440,7 +1459,7 @@ static int ppe_config_bm(struct ppe_device *ppe_dev)
 	 */
 	reg = PPE_BM_SHARED_GROUP_CFG_ADDR;
 	val = FIELD_PREP(PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT,
-			 ipq9574_ppe_bm_group_config);
+			 soc_cfg->bm_group_config);
 	ret = regmap_update_bits(ppe_dev->regmap, reg,
 				 PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT,
 				 val);
@@ -1448,8 +1467,8 @@ static int ppe_config_bm(struct ppe_device *ppe_dev)
 		goto bm_config_fail;
 
 	/* Configure buffer thresholds for the BM ports. */
-	port_cfg = ipq9574_ppe_bm_port_config;
-	port_cfg_cnt = ARRAY_SIZE(ipq9574_ppe_bm_port_config);
+	port_cfg = soc_cfg->bm_port_config;
+	port_cfg_cnt = soc_cfg->bm_port_config_cnt;
 	for (i = 0; i < port_cfg_cnt; i++) {
 		for (bm_port_id = port_cfg[i].port_id_start;
 		     bm_port_id <= port_cfg[i].port_id_end; bm_port_id++) {
@@ -1470,7 +1489,8 @@ static int ppe_config_bm(struct ppe_device *ppe_dev)
 /* Configure PPE hardware queue depth, which is decided by the threshold
  * of queue.
  */
-static int ppe_config_qm(struct ppe_device *ppe_dev)
+static int ppe_config_qm(struct ppe_device *ppe_dev,
+			 const struct ppe_soc_config *soc_cfg)
 {
 	const struct ppe_qm_queue_config *queue_cfg;
 	int ret, i, queue_id, queue_cfg_count;
@@ -1485,15 +1505,15 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 	if (ret)
 		goto qm_config_fail;
 
-	PPE_AC_GRP_SET_BUF_LIMIT(group_cfg, ipq9574_ppe_qm_group_config);
+	PPE_AC_GRP_SET_BUF_LIMIT(group_cfg, soc_cfg->qm_group_config);
 
 	ret = regmap_bulk_write(ppe_dev->regmap, reg,
 				group_cfg, ARRAY_SIZE(group_cfg));
 	if (ret)
 		goto qm_config_fail;
 
-	queue_cfg = ipq9574_ppe_qm_queue_config;
-	queue_cfg_count = ARRAY_SIZE(ipq9574_ppe_qm_queue_config);
+	queue_cfg = soc_cfg->qm_queue_config;
+	queue_cfg_count = soc_cfg->qm_queue_config_cnt;
 	for (i = 0; i < queue_cfg_count; i++) {
 		queue_id = queue_cfg[i].queue_start;
 
@@ -1625,7 +1645,8 @@ static int ppe_node_scheduler_config(struct ppe_device *ppe_dev,
 /* Initialize scheduler settings for PPE buffer utilization and dispatching
  * packet on PPE queue.
  */
-static int ppe_config_scheduler(struct ppe_device *ppe_dev)
+static int ppe_config_scheduler(struct ppe_device *ppe_dev,
+				const struct ppe_soc_config *soc_cfg)
 {
 	const struct ppe_scheduler_port_config *port_cfg;
 	const struct ppe_scheduler_qm_config *qm_cfg;
@@ -1633,8 +1654,8 @@ static int ppe_config_scheduler(struct ppe_device *ppe_dev)
 	int ret, i, count;
 	u32 val, reg;
 
-	count = ARRAY_SIZE(ipq9574_ppe_sch_bm_config);
-	bm_cfg = ipq9574_ppe_sch_bm_config;
+	count = soc_cfg->sch_bm_config_cnt;
+	bm_cfg = soc_cfg->sch_bm_config;
 
 	/* Configure the depth of BM scheduler entries. */
 	val = FIELD_PREP(PPE_BM_SCH_CTRL_SCH_DEPTH, count);
@@ -1664,8 +1685,8 @@ static int ppe_config_scheduler(struct ppe_device *ppe_dev)
 			goto sch_config_fail;
 	}
 
-	count = ARRAY_SIZE(ipq9574_ppe_sch_qm_config);
-	qm_cfg = ipq9574_ppe_sch_qm_config;
+	count = soc_cfg->sch_qm_config_cnt;
+	qm_cfg = soc_cfg->sch_qm_config;
 
 	/* Configure the depth of QM scheduler entries. */
 	val = FIELD_PREP(PPE_PSCH_SCH_DEPTH_CFG_SCH_DEPTH, count);
@@ -1995,19 +2016,20 @@ static int ppe_bridge_init(struct ppe_device *ppe_dev)
 	return 0;
 }
 
-int ppe_hw_config(struct ppe_device *ppe_dev)
+int ppe_hw_config(struct ppe_device *ppe_dev,
+		  const struct ppe_soc_config *soc_cfg)
 {
 	int ret;
 
-	ret = ppe_config_bm(ppe_dev);
+	ret = ppe_config_bm(ppe_dev, soc_cfg);
 	if (ret)
 		return ret;
 
-	ret = ppe_config_qm(ppe_dev);
+	ret = ppe_config_qm(ppe_dev, soc_cfg);
 	if (ret)
 		return ret;
 
-	ret = ppe_config_scheduler(ppe_dev);
+	ret = ppe_config_scheduler(ppe_dev, soc_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
index 60493e51e0a4..0dafab264743 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
@@ -287,7 +287,39 @@ struct ppe_rss_hash_cfg {
 	u8 hash_fin_outer[PPE_RSS_HASH_TUPLES];
 };
 
-int ppe_hw_config(struct ppe_device *ppe_dev);
+/**
+ * struct ppe_soc_config - SoC-specific PPE hardware configuration.
+ * @bm_group_config: Buffer Management (BM) group configuration.
+ * @bm_port_config: Pointer to the BM port configuration array.
+ * @bm_port_config_cnt: Number of entries in the BM port configuration array.
+ * @qm_group_config: Queue Management (QM) group configuration.
+ * @qm_queue_config: Pointer to the QM queue configuration array.
+ * @qm_queue_config_cnt: Number of entries in the QM queue configuration array.
+ * @sch_bm_config: Pointer to the BM scheduler arbitration array.
+ * @sch_bm_config_cnt: Number of entries in the BM scheduler arbitration array.
+ * @sch_qm_config: Pointer to the QM scheduler arbitration array.
+ * @sch_qm_config_cnt: Number of entries in the QM scheduler arbitration array.
+ */
+struct ppe_soc_config {
+	int bm_group_config;
+	const struct ppe_bm_port_config *bm_port_config;
+	unsigned int bm_port_config_cnt;
+
+	int qm_group_config;
+	const struct ppe_qm_queue_config *qm_queue_config;
+	unsigned int qm_queue_config_cnt;
+
+	const struct ppe_scheduler_bm_config *sch_bm_config;
+	unsigned int sch_bm_config_cnt;
+
+	const struct ppe_scheduler_qm_config *sch_qm_config;
+	unsigned int sch_qm_config_cnt;
+};
+
+extern const struct ppe_soc_config ipq9574_soc_config;
+
+int ppe_hw_config(struct ppe_device *ppe_dev,
+		  const struct ppe_soc_config *soc_cfg);
 int ppe_queue_scheduler_set(struct ppe_device *ppe_dev,
 			    int node_id, bool flow_level, int port,
 			    struct ppe_scheduler_cfg scheduler_cfg);
-- 
2.56.0

