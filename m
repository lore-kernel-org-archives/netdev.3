Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4E42EEAB;
	Fri,  5 Jun 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644203; cv=fail; b=V1qocpy1W/0SxIs0Q/H/5bKyaJTz/4qz8GLmpnNd+MVyywqy8s73X+zP8SppXh7oVImeQ+FqqTBZ6bBDaYjr1LXvgYq6SI1uSuTujUhftykeiZ5m5yMkRhFMuYjvlPl6U6UwwB0X7mVY9hWfHvgwWaskKXXyEmJ2HOF9L+RrY8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644203; c=relaxed/simple;
	bh=q7JJAKp3LAuYuqD3jNz56djoR5Wedp4JFF7HMHC8Wt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Detds+/QmEOCXvJFRTO2OfeDMXnrMoFjkKpdtPz8QJoQhKkmw81LQ/J7Rj5ak62fF99nGlYl/Mv9Y64JLcZlpx0wKGfmBlTdf0UkmkOd/0rwKTs+mp4twYs+eL7NOzoPhOa/x8kYjrMp/ziolZhLRvg7RNuuYOMGS+pKbFLHvlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iB4am7lK; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iB4am7lK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6h3uuLYsxvy30Col3U6ic1uvksgsu87XX/bYYro4CIyAdDna+TvnOST3eIEENZVNkIMEy2L943RnuOLk5f5fiNfp8E2tD8G0W9ZwzvNYjaq2/2jmrIq8v4R61Vuqj7UEi77UVlpbyuhVE51O3ykSi7T71cNHBtMXeID9EqDht7STmoZFglYZa6sO6COvuXpJHdSyekzxwzSHzFHCEiB1beAX5vVrUnB814LFdMY8858UJN6UJLFzfdX1OE+TXqBeEoFkneCBciIxfSXsekfv6Wd9uWFRSwKLdG82X1PR89c/KCuGzafgfpuO1KXHM3MO/zgYM40T9wMkh7IRtYSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29B6o9RiNPeseFd8xm4Kc+mLVia2vipdb2TPdQB1aS8=;
 b=RVz4H7GXFRDe5cV0ZN8PHzfoCBqWcBCrN8NMuP/5eHHnKuGQ8sSrco4BaF3EACMq+PsaAB4OEVQdbK/WD284qhtkmCQqkIrTDTAxrKDzZeibPUcWdUWJepzm5M4sC1O6/aes7LfDtmI4/uRjBgLJOwnqFcgofc3Cs+QqmLUyopZQdTuBGkjLLcRPI2wMZxYzO543g8/wNbvFlb0ugaWU6PmM/rbevQTS7cQOqwp2nbCys47c9QSjOvPlqhOYtwbShQDyKJJ/Ca7BUN3H6q77tIw+PCYKMaHCemDTAPIC7xJK+VZzHiycY9qn+S4/knQf1bFnAd555fa/QdnZ9scnqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29B6o9RiNPeseFd8xm4Kc+mLVia2vipdb2TPdQB1aS8=;
 b=iB4am7lK2awgHJVX97qgb/sjkFF/SQiavPyLK2U98BynF4kLAe3l5IGWjcLmBgN51QVY9pqmUjq6gF9ZcSAQmLGMARr9GYgiHwG7j948hWO/v2ZKUCHJ3Qp7xu5O/YtAP3lb+c/nQrCuZ0vk4Q6jHeKPKvoCxCJ8lwAAnPSJS3QjkCJXHMpvbYbOEF+nm+/ow26Bb8x0FK2wURqTCw73pTorW0q/vbMjNvX94OLW4StIGDPtC2xn+eZkAUkjG4V3le0KgX6OXIHMzTnBVSe3FOnnFPgIHQETqgIxDqqe/N+XVvOiFzUJAUsYRtfqd/mcaZTxWgY7Ej8euvjjTrgIWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8910.eurprd04.prod.outlook.com (2603:10a6:102:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 5 Jun
 2026 07:23:18 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 07:23:18 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/15] net: enetc: add link speed message support to PF driver
Date: Fri,  5 Jun 2026 14:55:39 +0800
Message-Id: <20260605065550.3038579-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
References: <20260605065550.3038579-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc385a1-c973-4db5-3c30-08dec2d350fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|56012099006|921020|21046099003|22082099003|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	4zU/o1Wz1LknofkWrDsokwbnC6yuYg3pxvVTriu1Vcs0bpDtCkwTVuE2zoOuF/CAVdZT+5RLkh0fP9fm+ywN3cDaJ8fISJ0V0MSenDJKY8OZZTb0DLLV4vQpAUny5oIcg6jy4nVtokmvKwVJYuAEsvPrN+egoGpwYC2YtReovErBaGR/HwNQDVWvDFN9CzKn0UtLgilBEhgHy2S+0J1yG/XzDZkb/+n3Pa0LsbB5ln3hf0Y5ALd85MiAyZxqIi2wy07KFexBbaf/uDZ4HEfsCvoJtw//uKbEAJFnMSm0Ag4BfHhidt2PqyKoJvcXqXf7N0wXStoZgC9ofRguew8ZFXy6E89mcuPNaf0031d3JGbqxJhw4yB5jka48KOFL3gQfmI8cyKKk1HzqvRQ5kBlPCzfnk/uV0DMaBHuZiGLAIB36M2BZVm9Umjhek2VpoPZYIBgeXxHu/qKShARGajJvUPsNoYObxUbQj7iLs2v/0M37PH1X8zaijG4UEju6gpvq30i5XVnoDzDQntEFrqZSmJQZqXth5hboXCOmWlPEkVRVD8NPPKFIsdlQjWuUa3ggQO/Vs36eVBdmoW9MTa3qMnm0GA7ITbQFLO86QK+N0OsRjc/1cytLlmasx9PJo1e1NokE16D35W9Kxau4JXfyFOwBO219fDQrr8q4y2q0bNpO/Mee0xozvRIEXOwe4Fk3QHJzoEy51gsVMiqBanoTA2gJ09urKMNAqxoL7zK9co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(56012099006)(921020)(21046099003)(22082099003)(6133799003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MzewLUlmeNKp7tqTBwaaWgSUWfhMtn++ycQ+Ge940a13AYLvL6bXwhOXZZRF?=
 =?us-ascii?Q?cNU/hfpfeaDoP6KuK24TG1SHQMmdRulmZkf/b/zWy/m9vz4h21JlZcVB03JD?=
 =?us-ascii?Q?qYFQyltcVvfBujYX9Py/vbxBFbtcqtTL+EokkRaRgmlnVMYCBEvoqVJHNB1q?=
 =?us-ascii?Q?taORAceogmsWC9HcQLH+nlsuGedmuUqDMMCRrw/2whYtk77cFiTn9HhTcW4f?=
 =?us-ascii?Q?WWqqViTHzKsxIRJaZTcmGdq9HMbA0uYDSKwBWATYZJmzVe0au9bwQTEbcdSn?=
 =?us-ascii?Q?Px415jrr3moZNmLEdd+LbPd/U6aOeGdrAqN2499eqdNBoxDBXPe2kBa/PQKm?=
 =?us-ascii?Q?7PNVmf/ri4ZwBSyDZ9pyJUQgGcxcVOMgxAkc+vxPOt9KEAr7vVJV7iw9Uycp?=
 =?us-ascii?Q?R31iQsDUacUxBuKyUeuuBrWJCuUGlJMlAg57XQWDUPZ0Q/bH9/VYAlgkYN9q?=
 =?us-ascii?Q?lLxZEginVVV4OD4q6SlsLBb2kxsUAGAjMAjaabvG+iBYEzpwQN/qCnPyEnVL?=
 =?us-ascii?Q?gRbgcrI3SwZfo43FCnhnEEcEHjUOEKOmG1+hNddkdpQb9DsOlVP+5AIGgVxo?=
 =?us-ascii?Q?Tbio9LBAhpnDXjSsKLEauwnn5xe/8hrkTlZd9AU4HRnb8EI03znq0q09NmIV?=
 =?us-ascii?Q?X15elZrtXSax7C7D6/Gc3sdhmbxhGdi98kkeq3kkg564FkGwMyHPBrNdTB0h?=
 =?us-ascii?Q?q24+3yoAnX3WjFM88qn3yM8epC2yegcAhi+kUh0B6BAi41Ajw0Q3dZm9VrdI?=
 =?us-ascii?Q?zELoafX3X2sb/i5mJBz8K5H+y4JIvxpizxtufJZsDSRb+NFmE1CVhprDFoww?=
 =?us-ascii?Q?F2biMhvde4nBSx+Bt1uMk74RLo7saW28TRZKd2AiP6JJoBs6wGQpiHTljE5Q?=
 =?us-ascii?Q?Edwna6DOrxfhuuUiAccdv8eVO1DTqpXw3nC7itXuY8jH0V90zcZCZHQsvdUV?=
 =?us-ascii?Q?PialfonCQkYQ6TefQZuqe3H/pvCU8yb4nZeseQqXd/REZ+7i2Q9SSNv4m3Jo?=
 =?us-ascii?Q?vXC6mMBwwCp/ulC6KoHuGUCON18Vp7cgLGrnba+y8xgcnanJTOJpAK4DKZjJ?=
 =?us-ascii?Q?DmamOYM6jdEY/jdFVkuEY1M0EdTnkgEelbVc2ruDqKOLjeiPL5g/kiftueEI?=
 =?us-ascii?Q?hJ2xTLODw6HVBiDWLEkg+9WdhD+mIDp6Q/JCfn8k0Cf6FiHvT5qwYAX2YAM8?=
 =?us-ascii?Q?4Dcp5YmjEnuSwRD2szK15fgcZAVIxAN9aEh2MdnJ3ebOD+nlHDPQ/qmyy+E2?=
 =?us-ascii?Q?sLitT+MNWsATUndBj6ILID6aasYr5UCvg9rB8djYUAUbKvN0nuolWsAzqjqj?=
 =?us-ascii?Q?RMMIe4Xgp7MiQF2VTkZpfCwSfzO2efWm0HvsxkuiGDWE9H6X9WonHL3b7dHT?=
 =?us-ascii?Q?odxkK2Iakh0tgsKSyD07ta7q3SZyCpeFaQ9J+ACNfR7Ov0nUddzqvNPBzDhB?=
 =?us-ascii?Q?rOuXd6db9g5jARdn5A3AfmK36k+k7Yx294pG6LxJ6vt1xUc4ZBL8HoBva9ud?=
 =?us-ascii?Q?phVP+YEBzPBxgquQjW+PCKftzq51phYBe4nQz5OHbTwwafghSrhjvNzo9I9U?=
 =?us-ascii?Q?oQQONr4773DpPhz9qYS/jzrfwPlPbm35qxpPgyoP0rcJOmHu12rYQ8gL18gP?=
 =?us-ascii?Q?LWxHQ6T6AJUscHAUGuqHi1u9W4Ysn+5RFE7zedKjgalb7jjEd+ns/3gTl2cc?=
 =?us-ascii?Q?LjqHtGEXqjhqUE6PVp+BKlofYtoR9WtjT1QGAa0cuVcbTZ+0TU4CT10bOp+0?=
 =?us-ascii?Q?G2XRtMspYtT3ThztYQNZl7ssldAN/Nq+aLe1QIGcboY8P5WNaJil?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc385a1-c973-4db5-3c30-08dec2d350fc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:23:18.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HraMmz8df6GKDVBituRw3nLiewQw0WFhLN3nq7QsFwxeTQVPcRLVRdZ5JtpzvPOuuMJ9KHK4lmrLue888ISiTtN0JDAJEbWhGzuT1rhVVYUMTX1TdQRYZb5QK7o9phB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8910

From: Wei Fang <wei.fang@nxp.com>

When a VF is driven by DPDK, the VF relies on the PF to provide accurate
link speed information so that the VF-side user space application can
make correct forwarding and configuration decisions.

Therefore, add link speed message support for DPDK-owned VF. The PF will
reply the current link speed when it receives the get link speed message
from VF.

With this enhancement, VFs controlled by DPDK can obtain real-time link
speed information from the PF, improving overall link state visibility,
synchronization between PF/VF, and enabling more accurate performance
adjustments in VF-side applications.

Note that currently the link speed change notification is not supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 29 +++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 77 +++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 43b9ee2ab3e4..44c8196accaa 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -108,6 +108,7 @@ enum enetc_msg_class_id {
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
 	ENETC_MSG_CLASS_ID_LINK_STATUS		= 0x80,
+	ENETC_MSG_CLASS_ID_LINK_SPEED,
 	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
@@ -125,6 +126,13 @@ enum enetc_msg_link_status_cmd_id {
 	ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER,
 };
 
+enum enetc_msg_link_speed_cmd_id {
+	ENETC_MSG_GET_CURRENT_LINK_SPEED,
+	/* The following command IDs are not currently supported */
+	ENETC_MSG_REGISTER_SPEED_CHANGE_NOTIFIER,
+	ENETC_MSG_UNREGISTER_SPEED_CHANGE_NOTIFIER,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
@@ -136,6 +144,22 @@ enum enetc_link_status_class_code {
 	ENETC_LINK_STATUS_CLASS_CODE_DOWN,
 };
 
+/* Class-specific notifcaitons/codes of link speed */
+enum enetc_link_speed_class_code {
+	ENETC_MSG_SPEED_UNKNOWN,
+	ENETC_MSG_SPEED_10M_HD,
+	ENETC_MSG_SPEED_10M_FD,
+	ENETC_MSG_SPEED_100M_HD,
+	ENETC_MSG_SPEED_100M_FD,
+	ENETC_MSG_SPEED_1000M,
+	ENETC_MSG_SPEED_2500M,
+	ENETC_MSG_SPEED_5G,
+	ENETC_MSG_SPEED_10G,
+	ENETC_MSG_SPEED_25G,
+	ENETC_MSG_SPEED_50G,
+	ENETC_MSG_SPEED_100G,
+};
+
 struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
@@ -179,6 +203,11 @@ struct enetc_msg_mac_exact_filter {
  * cmd_id 0x0: get the current link status
  * cmd_id 0x1: register link status change notification
  * cmd_id 0x2: unregister link status change notification
+ *
+ * Link speed message, class_id 0x81.
+ * cmd_id 0x0: get the current link speed.
+ * cmd_id 0x1: register link speed change notification
+ * cmd_id 0x2: unregister link speed change notification
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index c93b4e6913d8..49c1ca14735c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -9,6 +9,7 @@
 					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
 #define ENETC_PF_MSG_PERM_DENY	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
 					   ENETC_MSG_CLASS_ID_PERMISSION_DENY)
+#define ENETC_PF_MSG_SPEED(s)	FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (s))
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -235,6 +236,79 @@ static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
 	}
 }
 
+static u16 enetc_msg_get_link_speed(struct enetc_pf *pf)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	struct ethtool_link_ksettings link_info = {};
+	u16 pf_msg;
+
+	pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+			    ENETC_MSG_CLASS_ID_LINK_SPEED);
+
+	rtnl_lock();
+	if (phylink_ethtool_ksettings_get(priv->phylink, &link_info)) {
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_UNKNOWN);
+		rtnl_unlock();
+
+		return pf_msg;
+	}
+	rtnl_unlock();
+
+	switch (link_info.base.speed) {
+	case SPEED_10:
+		if (link_info.base.duplex == DUPLEX_HALF)
+			pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_10M_HD);
+		else
+			pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_10M_FD);
+		break;
+	case SPEED_100:
+		if (link_info.base.duplex == DUPLEX_HALF)
+			pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_100M_HD);
+		else
+			pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_100M_FD);
+		break;
+	case SPEED_1000:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_1000M);
+		break;
+	case SPEED_2500:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_2500M);
+		break;
+	case SPEED_5000:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_5G);
+		break;
+	case SPEED_10000:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_10G);
+		break;
+	case SPEED_25000:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_25G);
+		break;
+	case SPEED_50000:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_50G);
+		break;
+	case SPEED_100000:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_100G);
+		break;
+	default:
+		pf_msg |= ENETC_PF_MSG_SPEED(ENETC_MSG_SPEED_UNKNOWN);
+	}
+
+	return pf_msg;
+}
+
+static u16 enetc_msg_handle_link_speed(struct enetc_pf *pf, void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_CURRENT_LINK_SPEED:
+		return enetc_msg_get_link_speed(pf);
+	case ENETC_MSG_REGISTER_SPEED_CHANGE_NOTIFIER:
+	case ENETC_MSG_UNREGISTER_SPEED_CHANGE_NOTIFIER:
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+}
+
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 				   u16 *pf_msg)
 {
@@ -313,6 +387,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_LINK_STATUS:
 		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_SPEED:
+		*pf_msg = enetc_msg_handle_link_speed(pf, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
-- 
2.34.1

