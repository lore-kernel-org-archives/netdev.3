Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F32471240;
	Fri,  7 Aug 2026 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099571; cv=fail; b=JZtXf43kem3UJPNK/5OP7xmxRtFHLyQVdhgbdjfvQNDbAmIq5WIrctffNcUK7Vfi18lr6Hbldd43lr0hr2o1Ce8tMtAbMLZlsgKeuot71XQY3kQneHITCcVDUdVX3Au0O52BDFCE9mgqoVuTeqW+4MOGh1gSBOt6IcFD+sZLrmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099571; c=relaxed/simple;
	bh=QHs49KGKTYlza0U1ClVTX3bgwWX1mF9H2H6rThosWQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+ASyvmJJtk+ayIiX63aiwlDXxPls+mzu2zNvJ5jCfmgNJKdLqM0zbLifTcbC9bUpyQhbauIsszK3jzBIyDqR50t+0Ucn89NNyewkFO69wSsLc2hIbsBdKYhSASZzT0KbmhcVC5JfZnQMlQH4vKcWEwVz2yh0FFjbQrJOP/aeUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eikyHUGS; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eikyHUGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXsQSe1n6FR9ScnBvV0xyP+vLUzrMfRUo0lAHI/XeOq1Ransgp/aqqc0xcKADLH8P7Ta2tmhoS49C+L5e82bExK6xIngLhRD296OLLA4e8Bhtac+bzm/DKF5zO1bwUG9UrU+QtPBUlfPnOZOCmfTpMxYZhVBoA0vKkCrlbjoL/46KVzPd7ZmqjgmCaRJwPxfDvpzavxpXhf+g2ivyKirdXiFJQRvE3eZXSvNeT0ssxqLTjicERKM9CmCSJziTNlWAgDTzYoqrEBl0rgkYilX31+X3NzIuoG1ZEVbqF3IaXkAwjvc7udHsnEKkUH1bPgx0PA/r5mMOiXdoAs0ooz+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU90HtZcndDjdkSJRpzeTbHZEKz4/7SHX4H2UMaTe3g=;
 b=L+u8T/5YPP6yb8CQuOmTc8CsXBOkXwwMRSuiqMaPjIf0pBIKF/w+C/WXDW5u+nPD3T4WcxiNpTphdKaro5hpe0/+MWLtEtiJYEoWxzWMK0ARW0lrFe3exZOT7O+WvQdbwSbS5dtOOoGOv+A7/81d2vtOBbCUnY4lB2Kd/t8fze9NcZU6ypPG/tvtLnfBst55XUZPzIR0EdXDwyHmIpEgMNbznVPRjw0sDLkea8Ngh5BaPFh9EWBWLQjQHZiLv9ymaZxAaTq+nczEbjJFOoXUZ0GmDw6w+zMPzaFb+mIaaQZOyDzcKyHEG2b1MPFPZ8OZVUdNwpVH8wpeGOHUIWnlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU90HtZcndDjdkSJRpzeTbHZEKz4/7SHX4H2UMaTe3g=;
 b=eikyHUGSSXD1MRJSk1lYb0pOz12p38FJgH0KgEtQAVftTjyKfFpoTIwJCC537dwy87aNTTlHt8WsAP5l2oU8Nno0x9B+/hXsid18xeml2k5zkOYEViFVO0G+rZ0HRGXT/wwuQZSUWDXZA5WPCV+wmpafemyD1FNWz1EMF1ouE6E=
Received: from PH7P220CA0082.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::17)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 10:46:02 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::98) by PH7P220CA0082.outlook.office365.com
 (2603:10b6:510:32c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 10:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Fri, 7 Aug 2026 10:46:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:01 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 7 Aug
 2026 05:46:00 -0500
Received: from xhdnrottela40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 7 Aug 2026 05:45:55 -0500
From: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
To: Srinivas Neeli <srinivas.neeli@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>, Andrew Lunn
	<andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Simon Horman
	<horms@kernel.org>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git-dev@amd.com>, <nagadheeraj.rottela@amd.com>
Subject: [PATCH 15/20] net: dsa: xilinx: register PHC backed by the RTC timer block
Date: Fri, 7 Aug 2026 16:14:26 +0530
Message-ID: <20260807104431.157230-16-nagadheeraj.rottela@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: ffee11da-aab9-456f-ce97-08def4711312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|921020|18002099003|22082099003|10067099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	K0E8LjlXAH+pErEOm+OjZlfepsrV2giR+YKra1YVKGqV4vzXHzUHjSg1ckwLPgLLBvAm6qveaNPgs7NnghpZtdG36QcdDxtYMW4GEQ3A3XEXa7zvJkngbo6VSSDJCe4XGD9clwU6bV87qmflwVgGweGEGHWvqOjc0T48lGM2M09Fd/e+7yTRQ+oO0wtyiuM77C5ti3n/H1b2MjssWAQSQOYK5wibpGYwIHhWgcBOXTokvlLiuKXO+VdAUDQTVUsBwiW0uRhnQTOvQko0XFCedfZoht9ROaOhMvGDJ1K6H5mY/zH+zapiGHLq8XpcvKDOnFUvdi97tQvvqcoqIJklROC4AM+xfjicFocbxv7Fx1pW7yl+e9QyZsUnjDcXXDvQa+PDX1mvmIqLhNeYaHCNM4b4wHGd550qCx7usaiV+KKbrdyQTL/NsVR3Ga9N8/+P/BofAQsTJ41gip9Acr+Ynjo9b6CP+kieaQARyZAFDOgVesxOjRlxt0eEB7vzbxRgsS7MOONqSkkYZFaUYbymeBIbuRdZr62EwgVswXARiugr+HZqFiXveSF0CbqenZrLDs4KLAzMAq6jQWTR4G9qbfUAPbYhRBHvobGE7BMlPIG7YepjSLi6+goyMNUswn7un02hq662UknGJds6cbrn6SNc/sDPEAGkkvOfsXW77aaa6VtE5+TiJ8ckqcPfZ4SJePwuKLmSBJPUmQlqSxsgmy8dmJrTyE3e4VQ4NXmOSkEIAMhVvhYC4Ty6vpg2dqIq
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(921020)(18002099003)(22082099003)(10067099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GjS3t30NO+j2S6XVqLOOy+rc9NnS7EV6FrkHyBL/wnfB2/GERROwJhNDas0ZnC2X8jD0WVY/irFaa2WzIrucFOgnqEQknuBdw4Mr18YEfYdRqBSYNi/wPgDcSFoxWbHSVrMl+zrmLCJiJs9NmJaW61okCyXis78Xw/9LxqED9BX37gCOt+9sog99Zrsw6CAMxLakFPSiHTx0RIKM6APGuJKJ9ziMF/CbjtCR0V3OVqz2PnV3JfooUc04KFtccKv4tYTVult/Q93yWdupCsaXkAdrwOWKw+CDfMyxJuclRDevJ1KJbcVr7Hpv49Nj8tCzF3OK+7rHz0jp6wOqFE0XXr1HO+yar1i48qskoFWj2W15wrv3LXJ2trDZ8Tlz7DG+CQt5pOMVyh9l0Xu1R+LwTHvTR5DTVyq28FbU6yw6B5Qg7ebWn8Mz30AWD/Mt4D+m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 10:46:02.0421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffee11da-aab9-456f-ce97-08def4711312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

Bring the IP-wide RTC timer block up under the switch driver and
expose it as a PTP hardware clock. The timer block sits at a fixed
offset inside MAC1's per-MAC register window, which the switch driver
already owns via the "mac1" reg-name. Map it in probe() and register
the PHC in setup(). A per-switch spinlock serializes concurrent PHC
operations, since gettime/settime/adjtime can run concurrently from
different file descriptors.

Reading the nanoseconds register latches a full RTC snapshot, so
gettime reads nanoseconds before seconds. The timer block fires 128
ticks per second. The ISR delivers PTP_CLOCK_PPS on every 128th tick.

Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
---
 drivers/net/dsa/xilinx/Kconfig          |   1 +
 drivers/net/dsa/xilinx/Makefile         |   2 +-
 drivers/net/dsa/xilinx/xilinx_tsn.c     |   7 +
 drivers/net/dsa/xilinx/xilinx_tsn.h     |  43 +++++
 drivers/net/dsa/xilinx/xilinx_tsn_ptp.c | 235 ++++++++++++++++++++++++
 5 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/dsa/xilinx/xilinx_tsn_ptp.c

diff --git a/drivers/net/dsa/xilinx/Kconfig b/drivers/net/dsa/xilinx/Kconfig
index 0bd5efe8490b..0e675295914b 100644
--- a/drivers/net/dsa/xilinx/Kconfig
+++ b/drivers/net/dsa/xilinx/Kconfig
@@ -3,6 +3,7 @@ config NET_DSA_XILINX_TSN
 	tristate "AMD/Xilinx TSN Endpoint Ethernet MAC switch support"
 	depends on OF && HAS_IOMEM
 	depends on NET_DSA
+	depends on PTP_1588_CLOCK
 	select NET_DSA_TAG_XLNX_TSN
 	help
 	  This enables DSA switch support for the three-port switch
diff --git a/drivers/net/dsa/xilinx/Makefile b/drivers/net/dsa/xilinx/Makefile
index 334f0f979276..8d63749104a4 100644
--- a/drivers/net/dsa/xilinx/Makefile
+++ b/drivers/net/dsa/xilinx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 obj-$(CONFIG_NET_DSA_XILINX_TSN) += xlnx_tsn_dsa.o
-xlnx_tsn_dsa-y := xilinx_tsn.o
+xlnx_tsn_dsa-y := xilinx_tsn.o xilinx_tsn_ptp.o
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.c b/drivers/net/dsa/xilinx/xilinx_tsn.c
index 9826f006b078..318d8b332208 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.c
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.c
@@ -675,8 +675,14 @@ static int xlnx_tsn_setup(struct dsa_switch *ds)
 	if (ret)
 		goto err_mdio;
 
+	ret = xlnx_tsn_ptp_init(sw);
+	if (ret)
+		goto err_nb;
+
 	return 0;
 
+err_nb:
+	unregister_netdevice_notifier(&sw->nb);
 err_mdio:
 	xlnx_tsn_mdio_unregister_all(sw);
 	return ret;
@@ -687,6 +693,7 @@ static void xlnx_tsn_teardown(struct dsa_switch *ds)
 	struct xlnx_tsn *sw = ds->priv;
 	struct dsa_port *dp;
 
+	xlnx_tsn_ptp_exit(sw);
 	unregister_netdevice_notifier(&sw->nb);
 	xlnx_tsn_mdio_unregister_all(sw);
 
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn.h b/drivers/net/dsa/xilinx/xilinx_tsn.h
index a228a7bebd53..6063763b5c17 100644
--- a/drivers/net/dsa/xilinx/xilinx_tsn.h
+++ b/drivers/net/dsa/xilinx/xilinx_tsn.h
@@ -10,6 +10,8 @@
 #include <linux/if_ether.h>
 #include <linux/io.h>
 #include <linux/notifier.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <net/dsa.h>
 
@@ -103,6 +105,28 @@ enum tsn_port_state {
 #define TSN_SPEED_CFG_100		BIT(30)
 #define TSN_SPEED_CFG_1000		BIT(31)
 
+/* PTP RTC timer block: a single block per IP, physically housed
+ * inside MAC1's per-MAC reg window. Owned by the switch driver
+ * because the PHC it backs is IP-wide, not per-MAC.
+ */
+#define TSN_TIMER_RTC_OFFSET_NS		0x00012800
+#define TSN_TIMER_RTC_OFFSET_SEC_L	0x00012808
+#define TSN_TIMER_RTC_OFFSET_SEC_H	0x0001280c
+#define TSN_TIMER_RTC_INCREMENT		0x00012810
+#define TSN_TIMER_CURRENT_RTC_NS	0x00012814
+#define TSN_TIMER_CURRENT_RTC_SEC_L	0x00012818
+#define TSN_TIMER_CURRENT_RTC_SEC_H	0x0001281c
+#define TSN_TIMER_INTERRUPT		0x00012820
+
+#define TSN_TIMER_MAX_NSEC_SIZE		30
+#define TSN_TIMER_MAX_NSEC_MASK		GENMASK_ULL(TSN_TIMER_MAX_NSEC_SIZE - 1, 0)
+#define TSN_TIMER_MAX_SEC_SIZE		48
+#define TSN_TIMER_MAX_SEC_MASK		GENMASK_ULL(TSN_TIMER_MAX_SEC_SIZE - 1, 0)
+#define TSN_TIMER_INT_CLEAR		BIT(0)
+#define TSN_TIMER_RTC_NS_SHIFT		20
+#define TSN_TIMER_PULSES_PER_PPS	128
+#define TSN_TIMER_GTX_CLK_FREQ		125000000U
+
 struct mii_bus;
 struct xlnx_tsn;
 
@@ -134,6 +158,15 @@ struct xlnx_tsn_mac {
  *	to refresh the shared prefix
  * @mac: per-MAC state, indexed by user-port number (index 0 unused;
  *	 MAC1 at [1], MAC2 at [2])
+ * @ptp_timer_irq: 1 PPS / RTC-overflow interrupt
+ * @ptp_clock: registered PHC; NULL until setup() succeeds
+ * @ptp_clock_info: PHC capability + ops descriptor
+ * @reg_lock: serialises RTC offset / increment register accesses
+ *	      from process context and the PHC ops
+ * @rtc_value: base RTC increment word for the GTX clock frequency,
+ *	       used as the starting point for adjust_by_scaled_ppm()
+ * @pps_enable: user requested PPS event delivery
+ * @countpulse: timer-tick counter, reset to zero every TSN_TIMER_PULSES_PER_PPS ticks
  */
 struct xlnx_tsn {
 	struct dsa_switch ds;
@@ -143,6 +176,13 @@ struct xlnx_tsn {
 	u8 mac_prefix[ETH_ALEN];
 	struct notifier_block nb;
 	struct xlnx_tsn_mac mac[XLNX_TSN_NUM_PORTS];
+	int ptp_timer_irq;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_clock_info;
+	spinlock_t reg_lock; /* serialises RTC offset/increment registers */
+	u64 rtc_value;
+	int pps_enable;
+	int countpulse;
 };
 
 static inline void mac_iow(struct xlnx_tsn_mac *m, u32 off, u32 val)
@@ -155,4 +195,7 @@ static inline u32 mac_ior(struct xlnx_tsn_mac *m, u32 off)
 	return ioread32(m->regs + off);
 }
 
+int xlnx_tsn_ptp_init(struct xlnx_tsn *sw);
+void xlnx_tsn_ptp_exit(struct xlnx_tsn *sw);
+
 #endif /* _XILINX_TSN_H */
diff --git a/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
new file mode 100644
index 000000000000..75c177f752f1
--- /dev/null
+++ b/drivers/net/dsa/xilinx/xilinx_tsn_ptp.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD/Xilinx TSN Endpoint Ethernet MAC DSA switch driver:
+ * PTP hardware clock.
+ */
+
+#include <linux/cleanup.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/ktime.h>
+#include <linux/math64.h>
+#include <linux/of_irq.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/spinlock.h>
+#include <linux/time64.h>
+#include <net/dsa.h>
+
+#include "xilinx_tsn.h"
+
+/* Reading the nanoseconds register latches a full RTC snapshot
+ * (ns + sec_low + sec_high). The subsequent seconds reads return
+ * those latched values, so nanoseconds must be read first.
+ */
+static void xlnx_tsn_tod_read(struct xlnx_tsn *sw, struct timespec64 *ts)
+{
+	struct xlnx_tsn_mac *m = &sw->mac[XLNX_TSN_PORT_MAC1];
+	u32 secl, sech, nsec;
+
+	nsec = mac_ior(m, TSN_TIMER_CURRENT_RTC_NS);
+	secl = mac_ior(m, TSN_TIMER_CURRENT_RTC_SEC_L);
+	sech = mac_ior(m, TSN_TIMER_CURRENT_RTC_SEC_H);
+
+	ts->tv_sec = (((u64)sech << 32) | secl) & TSN_TIMER_MAX_SEC_MASK;
+	ts->tv_nsec = nsec & TSN_TIMER_MAX_NSEC_MASK;
+}
+
+static void xlnx_tsn_rtc_offset_write(struct xlnx_tsn *sw,
+				      const struct timespec64 *ts)
+{
+	struct xlnx_tsn_mac *m = &sw->mac[XLNX_TSN_PORT_MAC1];
+
+	mac_iow(m, TSN_TIMER_RTC_OFFSET_SEC_H, upper_32_bits(ts->tv_sec));
+	mac_iow(m, TSN_TIMER_RTC_OFFSET_SEC_L, lower_32_bits(ts->tv_sec));
+	mac_iow(m, TSN_TIMER_RTC_OFFSET_NS, ts->tv_nsec);
+}
+
+static void xlnx_tsn_rtc_offset_read(struct xlnx_tsn *sw,
+				     struct timespec64 *ts)
+{
+	struct xlnx_tsn_mac *m = &sw->mac[XLNX_TSN_PORT_MAC1];
+	u32 secl, sech, nsec;
+
+	secl = mac_ior(m, TSN_TIMER_RTC_OFFSET_SEC_L);
+	sech = mac_ior(m, TSN_TIMER_RTC_OFFSET_SEC_H);
+	nsec = mac_ior(m, TSN_TIMER_RTC_OFFSET_NS);
+
+	ts->tv_sec = (((u64)sech << 32) | secl) & TSN_TIMER_MAX_SEC_MASK;
+	ts->tv_nsec = nsec & TSN_TIMER_MAX_NSEC_MASK;
+}
+
+static int xlnx_tsn_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
+	u64 incval;
+
+	/* adjust_by_scaled_ppm() returns u64 but the increment register is
+	 * 32 bits, so clamp to U32_MAX to avoid overflow.
+	 */
+	incval = adjust_by_scaled_ppm(sw->rtc_value, scaled_ppm);
+	if (incval > U32_MAX)
+		incval = U32_MAX;
+
+	guard(spinlock_irqsave)(&sw->reg_lock);
+	mac_iow(&sw->mac[XLNX_TSN_PORT_MAC1], TSN_TIMER_RTC_INCREMENT,
+		(u32)incval);
+
+	return 0;
+}
+
+static int xlnx_tsn_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
+	struct timespec64 now, then = ns_to_timespec64(delta);
+
+	guard(spinlock_irqsave)(&sw->reg_lock);
+
+	xlnx_tsn_rtc_offset_read(sw, &now);
+	now = timespec64_add(now, then);
+
+	/* Stepping time backwards is fine and just lowers the offset. In
+	 * practice the offset never goes negative. Reject it only as a
+	 * safety net, since the offset register cannot store a negative value.
+	 */
+	if (now.tv_sec < 0)
+		return -ERANGE;
+
+	xlnx_tsn_rtc_offset_write(sw, &now);
+
+	return 0;
+}
+
+static int xlnx_tsn_ptp_gettime(struct ptp_clock_info *ptp,
+				struct timespec64 *ts)
+{
+	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
+
+	guard(spinlock_irqsave)(&sw->reg_lock);
+	xlnx_tsn_tod_read(sw, ts);
+
+	return 0;
+}
+
+static int xlnx_tsn_ptp_settime(struct ptp_clock_info *ptp,
+				const struct timespec64 *ts)
+{
+	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
+	struct timespec64 delta, tod, offset, counter;
+
+	guard(spinlock_irqsave)(&sw->reg_lock);
+
+	xlnx_tsn_tod_read(sw, &tod);
+	xlnx_tsn_rtc_offset_read(sw, &offset);
+	counter = timespec64_sub(tod, offset);
+
+	delta = timespec64_sub(*ts, counter);
+
+	/* A real wall-clock time is always far above the free-running counter,
+	 * so this never triggers in practice. Reject it only as a safety net,
+	 * since the offset register cannot store a negative value.
+	 */
+	if (delta.tv_sec < 0)
+		return -ERANGE;
+
+	xlnx_tsn_rtc_offset_write(sw, &delta);
+
+	return 0;
+}
+
+static int xlnx_tsn_ptp_enable(struct ptp_clock_info *ptp,
+			       struct ptp_clock_request *rq, int on)
+{
+	struct xlnx_tsn *sw = container_of(ptp, struct xlnx_tsn, ptp_clock_info);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		WRITE_ONCE(sw->pps_enable, on ? 1 : 0);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static irqreturn_t xlnx_tsn_ptp_timer_isr(int irq, void *priv)
+{
+	struct ptp_clock_event event = { .type = PTP_CLOCK_PPS };
+	struct xlnx_tsn *sw = priv;
+
+	sw->countpulse++;
+	if (sw->countpulse >= TSN_TIMER_PULSES_PER_PPS) {
+		sw->countpulse = 0;
+		if (sw->ptp_clock && READ_ONCE(sw->pps_enable))
+			ptp_clock_event(sw->ptp_clock, &event);
+	}
+
+	mac_iow(&sw->mac[XLNX_TSN_PORT_MAC1], TSN_TIMER_INTERRUPT,
+		TSN_TIMER_INT_CLEAR);
+
+	return IRQ_HANDLED;
+}
+
+int xlnx_tsn_ptp_init(struct xlnx_tsn *sw)
+{
+	struct timespec64 ts;
+	int ret;
+
+	spin_lock_init(&sw->reg_lock);
+
+	sw->ptp_timer_irq = of_irq_get_byname(sw->dev->of_node, "ptp_timer");
+	if (sw->ptp_timer_irq <= 0)
+		return dev_err_probe(sw->dev, sw->ptp_timer_irq ? : -ENXIO,
+				     "failed to get ptp_timer IRQ\n");
+
+	sw->ptp_clock_info.owner = THIS_MODULE;
+	snprintf(sw->ptp_clock_info.name, sizeof(sw->ptp_clock_info.name),
+		 "TSN PHC");
+	sw->ptp_clock_info.max_adj = 999999999;
+	sw->ptp_clock_info.pps = 1;
+	sw->ptp_clock_info.adjfine = xlnx_tsn_ptp_adjfine;
+	sw->ptp_clock_info.adjtime = xlnx_tsn_ptp_adjtime;
+	sw->ptp_clock_info.gettime64 = xlnx_tsn_ptp_gettime;
+	sw->ptp_clock_info.settime64 = xlnx_tsn_ptp_settime;
+	sw->ptp_clock_info.enable = xlnx_tsn_ptp_enable;
+
+	sw->ptp_clock = ptp_clock_register(&sw->ptp_clock_info, sw->dev);
+	if (IS_ERR_OR_NULL(sw->ptp_clock)) {
+		ret = sw->ptp_clock ? PTR_ERR(sw->ptp_clock) : -ENODEV;
+		sw->ptp_clock = NULL;
+		return dev_err_probe(sw->dev, ret,
+				     "failed to register PTP clock\n");
+	}
+
+	sw->rtc_value = div_u64(NSEC_PER_SEC, TSN_TIMER_GTX_CLK_FREQ) <<
+			TSN_TIMER_RTC_NS_SHIFT;
+	mac_iow(&sw->mac[XLNX_TSN_PORT_MAC1], TSN_TIMER_RTC_INCREMENT,
+		(u32)sw->rtc_value);
+
+	ts = ktime_to_timespec64(ktime_get_real());
+	xlnx_tsn_ptp_settime(&sw->ptp_clock_info, &ts);
+
+	ret = request_irq(sw->ptp_timer_irq, xlnx_tsn_ptp_timer_isr, 0,
+			  "xlnx-tsn-ptp-timer", sw);
+	if (ret) {
+		dev_err_probe(sw->dev, ret,
+			      "failed to request ptp_timer IRQ %d\n",
+			      sw->ptp_timer_irq);
+		goto err_unregister_clock;
+	}
+
+	return 0;
+
+err_unregister_clock:
+	ptp_clock_unregister(sw->ptp_clock);
+	sw->ptp_clock = NULL;
+	return ret;
+}
+
+void xlnx_tsn_ptp_exit(struct xlnx_tsn *sw)
+{
+	if (!sw->ptp_clock)
+		return;
+
+	free_irq(sw->ptp_timer_irq, sw);
+	ptp_clock_unregister(sw->ptp_clock);
+	sw->ptp_clock = NULL;
+}
-- 
2.34.1

