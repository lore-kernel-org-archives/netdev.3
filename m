Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859974A4EEC;
	Mon,  5 Oct 2026 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214574; cv=none; b=fQANnLLsnYXC+WzbUDcIqYFlmE1f7HnZrquk0fgc0NUokHcEP1g/FcFDpdsvRbM5aqmXRoFh3DF/m2dRaxzMe/Mj2pEqoUKvD1xHh3jan1sEXmSiPLklkcrgWgsxu5GKrdV49tCkXMGmdybq6qzmtt24TLrjd9vDMb55Wd/kLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214574; c=relaxed/simple;
	bh=E2eQePaIwWJyy5LbmGTX5tJRU/ZvTPTCk+jry6l++5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCxqZzrAIxra90mlDqCp5J1bdmJGka1FFqsOsyzeDcIeIWr2tuoWHPzLxse3K786THpw3R4PC1eGhKMce764KDudvyqDDK6dhThM7UX7nxPL2y+E8VxsYyNZMkK4fsZwbRjYutd5JMTj5GS9Tc5GkpYtuQgUQU9eqKX9AZAsDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=ShCGhc4y; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="ShCGhc4y"
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id BCE94240172;
	Mon, 05 Oct 2026 17:29:42 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 85526240453;
	Mon, 05 Oct 2026 17:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1791214180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8tbxwlO1Hf7TO92AXk1J/Epolkc2L2uSHkM3q+ZCdg=;
	b=ShCGhc4yc64j2TzwHbK4yVp5xyZ9GCB094py079RHG7W8gRMn9lLXlScFV+nk5ygm4sc8I
	tNCAb8ceEONwex77BAX4NZM6hU5nk+oa12CdWckYB46UkV6XBQqjnYnP/NSzceWBjLMDZ2
	DRM8qJO7Vll1qbh4twuhEqf5WUpakZxQcJpQ7Uifh7mYFTzBkKQoezkPTskKEalC2Cl/Nd
	Mge3xrH2pELbrwT/rn+K6NTYvWU0tY9uFMm1UDuciyf85tqFI5d8sMFfmPUjP4rfGENhai
	rPlQqqTXQ6PbTl0hZp5lt/JMIyvOQdbCjPXgJYELYUtTqsOE3h8D8qARddbV2w==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 0559F240410;
	Mon, 05 Oct 2026 17:29:38 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: Luo Jie <jie.luo@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next 4/4] net: ethernet: qualcomm: ppe: Add IPQ5332 support
Date: Mon,  5 Oct 2026 17:29:15 +0200
Message-ID: <20261005152915.101780-5-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005152915.101780-1-mail@tk154.de>
References: <20261005152915.101780-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: d21fac
X-Rspamd-UID: 986db9

IPQ5332 shares the IPQ9574 PPE architecture, but has only two front
panel ports and uses a different clock rate, interconnect paths, buffer
limits and scheduler arbitration.

Add match data for qcom,ipq5332-ppe: a 200 MHz PPE clock, four
interconnect paths and three PPE ports (the CPU port and two front panel
ports), together with its BM and QM limits and thresholds and its
scheduler arbitration tables. The values come from Qualcomm's QSDK
14.0.1595.1665 qca-ssdk revision 48484d531927b070b996685f1570aff3bccb9c32:
src/init/ssdk_hppe.c and ssdk_appe.c, and src/adpt/hppe/adpt_hppe_qm.c.

Reuse the IPQ9574 scheduler resources for ports 0 (CPU), 1 and 2.
The queue, flow and DRR node ranges for ports 1 and 2 match the
IPQ5332 port_scheduler_resource definitions in QSDK ipq5332.dtsi.
The CPU flow and DRR node ranges also match; retain the IPQ9574 CPU
and reserved queue partition. QSDK assigns CPU unicast queues 0-95
and multicast queues 256-263, while this driver uses 0-63 and 256-271.
The reserved pool is selected from the final resource-table entry
using port ID 3 on IPQ5332.

QSDK uses the same block base addresses and HPPE register offsets
for the common PPE blocks on IPQ5332 and IPQ9574, so retain the
existing regmap ranges and offsets for those blocks.

Document the IPQ5332 port and UNIPHY counts and add it to the list of
supported SoCs.

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 .../ethernet/qualcomm/ppe/ppe.rst             |   9 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c       |  33 +++++
 .../net/ethernet/qualcomm/ppe/ppe_config.c    | 127 ++++++++++++++++++
 .../net/ethernet/qualcomm/ppe/ppe_config.h    |   1 +
 4 files changed, 169 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst b/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
index 4ab299a28969..caf8ab1431de 100644
--- a/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
+++ b/Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
@@ -96,6 +96,10 @@ The port wrapper provides connections from the 6 GMAC/XGMACS to UNIPHY (PCS) sup
 various modes such as SGMII/QSGMII/PSGMII/USXGMII/10G-BASER. There are 3 UNIPHY (PCS)
 instances supported on the IPQ9574.
 
+IPQ5332 uses the same PPE architecture with two front panel ports and two UNIPHY
+(PCS) instances. Its Ethernet datapath has a CPU port (port0) and two GMAC/XGMAC
+ports (port1 and port2).
+
 Ethernet DMA is used to transmit and receive packets between the Ethernet subsystem
 and ARM host CPU.
 
@@ -118,6 +122,8 @@ PPE driver:
     through the UNIPHY PCS block. Each MAC block includes the GMAC and XGMAC blocks and
     the switch port can select to use GMAC or XMAC through a MUX selection according to
     the external PHY's capability.
+    IPQ5332 has two MACs (MAC0 and MAC1), connected to switch ports port1 and
+    port2 through two UNIPHY instances.
 - EDMA (Ethernet DMA)
     The Ethernet DMA is used to transmit and receive Ethernet packets between the PPE
     ports and the ARM cores.
@@ -164,8 +170,9 @@ CPU code counters and queue counters.
 PPE Driver Supported SoCs
 =========================
 
-The PPE driver supports the following IPQ SoC:
+The PPE driver supports the following IPQ SoCs:
 
+- IPQ5332
 - IPQ9574
 
 
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 0ef72c20364b..69e970db4a78 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -26,6 +26,30 @@ struct ppe_plat_data {
 	unsigned int num_icc, num_ports;
 };
 
+/* IPQ5332 interconnect paths. Zero bandwidths use the PPE clock rate. */
+static const struct icc_bulk_data ipq5332_icc_data[] = {
+	{
+		.name = "ppe",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "ppe_cfg",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "qos_gen",
+		.avg_bw = 6000,
+		.peak_bw = 6000,
+	},
+	{
+		.name = "timeout_ref",
+		.avg_bw = 6000,
+		.peak_bw = 6000,
+	},
+};
+
 /* IPQ9574 interconnect paths. Zero bandwidths use the PPE clock rate. */
 static const struct icc_bulk_data ipq9574_icc_data[] = {
 	{
@@ -65,6 +89,14 @@ static const struct icc_bulk_data ipq9574_icc_data[] = {
 	},
 };
 
+static const struct ppe_plat_data ipq5332_ppe_data = {
+	.soc_cfg = &ipq5332_soc_config,
+	.icc_data = ipq5332_icc_data,
+	.ppe_clk_rate = 200000000,
+	.num_icc = ARRAY_SIZE(ipq5332_icc_data),
+	.num_ports = 3,
+};
+
 static const struct ppe_plat_data ipq9574_ppe_data = {
 	.soc_cfg = &ipq9574_soc_config,
 	.icc_data = ipq9574_icc_data,
@@ -237,6 +269,7 @@ static void qcom_ppe_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_ppe_of_match[] = {
+	{ .compatible = "qcom,ipq5332-ppe", .data = &ipq5332_ppe_data },
 	{ .compatible = "qcom,ipq9574-ppe", .data = &ipq9574_ppe_data },
 	{}
 };
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 65ac6c0841d5..91e6ee9524a6 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -174,6 +174,9 @@ struct ppe_port_schedule_resource {
  */
 static const int ipq9574_ppe_bm_group_config = 1550;
 
+/* IPQ5332 BM group0 shared buffer limit. */
+static const int ipq5332_ppe_bm_group_config = 360;
+
 /* The buffer configurations per PPE port. There are 15 BM ports and
  * 4 BM groups supported by PPE. BM port (0-7) is for EDMA port 0,
  * BM port (8-13) is for PPE physical port 1-6 and BM port 14 is for
@@ -230,6 +233,34 @@ static const struct ppe_bm_port_config ipq9574_ppe_bm_port_config[] = {
 	},
 };
 
+/* IPQ5332: BM ports 0-7 serve EDMA, ports 8-9 serve ports 1-2. */
+static const struct ppe_bm_port_config ipq5332_ppe_bm_port_config[] = {
+	{
+		/* Buffer configuration for the BM port ID 0-7 of EDMA. */
+		.port_id_start	= 0,
+		.port_id_end	= 7,
+		.pre_alloc	= 12,
+		.in_fly_buf	= 40,
+		.ceil		= 30,
+		.weight		= 7,
+		.resume_offset	= 5,
+		.resume_ceil	= 20,
+		.dynamic	= true,
+	},
+	{
+		/* Buffer configuration for the BM port ID 8-9 of PPE ports. */
+		.port_id_start	= 8,
+		.port_id_end	= 9,
+		.pre_alloc	= 12,
+		.in_fly_buf	= 128,
+		.ceil		= 48,
+		.weight		= 7,
+		.resume_offset	= 5,
+		.resume_ceil	= 20,
+		.dynamic	= true,
+	},
+};
+
 /* QM fetches the packet from PPE buffer management for transmitting the
  * packet out. The QM group configuration limits the total number of buffers
  * enqueued by all PPE hardware queues.
@@ -240,6 +271,9 @@ static const struct ppe_bm_port_config ipq9574_ppe_bm_port_config[] = {
  */
 static const int ipq9574_ppe_qm_group_config = 2000;
 
+/* IPQ5332 QM group0 buffer limit. */
+static const int ipq5332_ppe_qm_group_config = 500;
+
 /* Default QM settings for unicast and multicast queues for IPQ9754. */
 static const struct ppe_qm_queue_config ipq9574_ppe_qm_queue_config[] = {
 	{
@@ -264,6 +298,30 @@ static const struct ppe_qm_queue_config ipq9574_ppe_qm_queue_config[] = {
 	},
 };
 
+/* IPQ5332 unicast and multicast queue thresholds. */
+static const struct ppe_qm_queue_config ipq5332_ppe_qm_queue_config[] = {
+	{
+		/* QM settings for unicast queues 0 to 255. */
+		.queue_start	= 0,
+		.queue_end	= 255,
+		.prealloc_buf	= 0,
+		.ceil		= 300,
+		.weight		= 7,
+		.resume_offset	= 18,
+		.dynamic	= true,
+	},
+	{
+		/* QM settings for multicast queues 256 to 299. */
+		.queue_start	= 256,
+		.queue_end	= 299,
+		.prealloc_buf	= 0,
+		.ceil		= 50,
+		.weight		= 0,
+		.resume_offset	= 18,
+		.dynamic	= false,
+	},
+};
+
 /* PPE scheduler configuration for BM includes multiple entries. Each entry
  * indicates the primary port to be assigned the buffers for the ingress or
  * to release the buffers for the egress. Backup port ID will be used when
@@ -372,6 +430,44 @@ static const struct ppe_scheduler_bm_config ipq9574_ppe_sch_bm_config[] = {
 	{true, PPE_SCH_EGRESS,  7, false, 0},
 };
 
+/* IPQ5332 BM arbitration. The invalid final slot is included in the
+ * 32-slot scheduler depth.
+ */
+static const struct ppe_scheduler_bm_config ipq5332_ppe_sch_bm_config[] = {
+	{true,  PPE_SCH_INGRESS, 2, false, 0},
+	{true,  PPE_SCH_EGRESS,  0, false, 0},
+	{true,  PPE_SCH_INGRESS, 1, false, 0},
+	{true,  PPE_SCH_EGRESS,  1, false, 0},
+	{true,  PPE_SCH_INGRESS, 2, false, 0},
+	{true,  PPE_SCH_EGRESS,  2, false, 0},
+	{true,  PPE_SCH_INGRESS, 0, false, 0},
+	{true,  PPE_SCH_EGRESS,  0, false, 0},
+	{true,  PPE_SCH_INGRESS, 2, false, 0},
+	{true,  PPE_SCH_EGRESS,  1, false, 0},
+	{true,  PPE_SCH_INGRESS, 1, false, 0},
+	{true,  PPE_SCH_EGRESS,  2, false, 0},
+	{true,  PPE_SCH_INGRESS, 0, false, 0},
+	{true,  PPE_SCH_EGRESS,  0, false, 0},
+	{true,  PPE_SCH_INGRESS, 1, false, 0},
+	{true,  PPE_SCH_EGRESS,  1, false, 0},
+	{true,  PPE_SCH_INGRESS, 2, false, 0},
+	{true,  PPE_SCH_EGRESS,  2, false, 0},
+	{true,  PPE_SCH_INGRESS, 1, false, 0},
+	{true,  PPE_SCH_EGRESS,  0, false, 0},
+	{true,  PPE_SCH_INGRESS, 2, false, 0},
+	{true,  PPE_SCH_EGRESS,  1, false, 0},
+	{true,  PPE_SCH_INGRESS, 0, false, 0},
+	{true,  PPE_SCH_EGRESS,  2, false, 0},
+	{true,  PPE_SCH_INGRESS, 2, false, 0},
+	{true,  PPE_SCH_EGRESS,  0, false, 0},
+	{true,  PPE_SCH_INGRESS, 1, false, 0},
+	{true,  PPE_SCH_EGRESS,  1, false, 0},
+	{true,  PPE_SCH_INGRESS, 0, false, 0},
+	{true,  PPE_SCH_EGRESS,  2, false, 0},
+	{true,  PPE_SCH_INGRESS, 1, false, 0},
+	{false, PPE_SCH_INGRESS, 0, false, 0},
+};
+
 /* PPE scheduler configuration for QM includes multiple entries. Each entry
  * contains ports to be dispatched for enqueueing and dequeueing. The backup
  * port for dequeueing is supported to be used when the primary port for
@@ -439,6 +535,22 @@ static const struct ppe_scheduler_qm_config ipq9574_ppe_sch_qm_config[] = {
 	{0x98, 6, 5, true, 2},
 };
 
+/* IPQ5332 QM arbitration. The enqueue bitmap is zero in every slot;
+ * ensch_port identifies the enqueue port. Backup dequeue ports are disabled.
+ */
+static const struct ppe_scheduler_qm_config ipq5332_ppe_sch_qm_config[] = {
+	{0x0, 0x2, 0, false, 0x0},
+	{0x0, 0x1, 2, false, 0x0},
+	{0x0, 0x0, 1, false, 0x0},
+	{0x0, 0x0, 2, false, 0x0},
+	{0x0, 0x1, 0, false, 0x0},
+	{0x0, 0x2, 1, false, 0x0},
+	{0x0, 0x0, 2, false, 0x0},
+	{0x0, 0x0, 1, false, 0x0},
+	{0x0, 0x0, 2, false, 0x0},
+	{0x0, 0x0, 1, false, 0x0},
+};
+
 static const struct ppe_scheduler_port_config ppe_port_sch_config[] = {
 	{
 		.port		= 0,
@@ -732,6 +844,8 @@ static const struct ppe_scheduler_port_config ppe_port_sch_config[] = {
 
 /* The scheduler resource is applied to each PPE port, The resource
  * includes the unicast & multicast queues, flow nodes and DRR nodes.
+ * Entries 1 and 2 serve ports 1 and 2 on both IPQ5332 and IPQ9574.
+ * The reserved pool is the last entry.
  */
 static const struct ppe_port_schedule_resource ppe_scheduler_res[] = {
 	{	.ucastq_start	= 0,
@@ -835,6 +949,19 @@ static const struct ppe_port_schedule_resource ppe_scheduler_res[] = {
 	},
 };
 
+const struct ppe_soc_config ipq5332_soc_config = {
+	.bm_group_config = ipq5332_ppe_bm_group_config,
+	.bm_port_config = ipq5332_ppe_bm_port_config,
+	.bm_port_config_cnt = ARRAY_SIZE(ipq5332_ppe_bm_port_config),
+	.qm_group_config = ipq5332_ppe_qm_group_config,
+	.qm_queue_config = ipq5332_ppe_qm_queue_config,
+	.qm_queue_config_cnt = ARRAY_SIZE(ipq5332_ppe_qm_queue_config),
+	.sch_bm_config = ipq5332_ppe_sch_bm_config,
+	.sch_bm_config_cnt = ARRAY_SIZE(ipq5332_ppe_sch_bm_config),
+	.sch_qm_config = ipq5332_ppe_sch_qm_config,
+	.sch_qm_config_cnt = ARRAY_SIZE(ipq5332_ppe_sch_qm_config),
+};
+
 const struct ppe_soc_config ipq9574_soc_config = {
 	.bm_group_config = ipq9574_ppe_bm_group_config,
 	.bm_port_config = ipq9574_ppe_bm_port_config,
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
index 0dafab264743..b42731aa3e7e 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
@@ -316,6 +316,7 @@ struct ppe_soc_config {
 	unsigned int sch_qm_config_cnt;
 };
 
+extern const struct ppe_soc_config ipq5332_soc_config;
 extern const struct ppe_soc_config ipq9574_soc_config;
 
 int ppe_hw_config(struct ppe_device *ppe_dev,
-- 
2.56.0

