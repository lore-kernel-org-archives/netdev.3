Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB273AEF59;
	Mon, 31 Aug 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146567; cv=fail; b=DjYGp+JWab21SPqaIRz5Nn0SeE1XJ4G8IBp+3vQD5bKctdHlSzK7Zp4Zl6zFtv7hnZXekc1OvM0umb/fy/ObJOOcVzoJVZfjRQ7Xtt82N/KslwbMOg5+OVOQleLSFxpmJoIso8VE9xRXuarPeIwtXbMa7mCGlQA02WBa5C1ajHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146567; c=relaxed/simple;
	bh=JRPYcPFZdnYrsDdV1dOofEQvEB6oekiuphtfkbaT98A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HL6LBAAIzU8Jm8Y/+3OccS6guub05dnHwVZdFK0z7QCvSwXFZVHHkbQWEkSrEm/4IWXKUQd65GP7RCy+VXgut3CpK0o99HwmztvUHbGJEVPyjVBZAI0LHeYDn2yfZczJUB1M9O8V5A1fzGoHowA3PWH+FkbzQIru+2Ry6epQH64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R9m9sbUq; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R9m9sbUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBelpcVintohNCZL6ktrJvjLuS0UbDrF71AFj6Mt8DqozbFn6lZQf2GLY//90J/HHsDyHM2bZ02llLLZr7aNbPI9GPix/wjOQqe17V5GNlKe/gmf6OIX39PQwmy7NOROXLc/W/G3M921mHY4O+1iEtqD1KaN8Puy+Rlb499RApQYkH/nJox2SXZI0qgjel4kNr3BhHjWD6kQrjJ5QKfpV7jHKFxTRsBIQReCq69TA60Idk0lOsceBbr2UR0n3zZ/vzBZsuLQmMB+7AI1jkO7sXD+Z2pQktW/JfjV5+mKJQRwofDJFzVFTkjlVz32UkTCnSC+ueLgOjlK6BD/t9T+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA5ZzXaTQD6fh2RPN6QVhOV/sivatrSYcDRMpNofIi0=;
 b=ebresbJAQQoKsa7T7cFj83ghtEQ4Fbdk4gxm9j8TiE/Qho7KWq+4W02mwfWaVjWetnRrKjwsTFQpgTNzt5YypF6MWg8+jemQjMaCOQJ4GdGZjBtLX8wuVd94YPp9W6hLvvRwtMo92X7Qqjk1BBTPRe64a+w1W/diqiltlyqZtcA6bo6su1B3IMz823GvCWcnRC5DYh/AFhZFStB7VpMVID9y7zgWPUXDZUYwkW7kR01C81+cvV/NSjAwEaBDURotfPySeVTLps1vG3+n9TvLn/KMyY8s9WKONfXICIDIn2eh/KQQDhc39S+Z2kydvZu8HRtnqiJlfmtW+E8rYE8Jmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5ZzXaTQD6fh2RPN6QVhOV/sivatrSYcDRMpNofIi0=;
 b=R9m9sbUqWCOReVsNUbkdmPcbI92Z/+cxaAA32zOWgCaQqLCd06MK06YaXFOUQyEybQKhe8L9I+gXTCIx/n3lWr5fRQS1k9GmCBSGu9Lr5ZRvU92M1bGqsc2Tnj127XsdMGL21+vlXT2UYoa6vxFDyYILYBT4vj41MuYKLUD3SF1h1anv1LDpCpdVjuJI7KVqM1Yw60AjEkm6ariZtE+LaBOGhTM39G3ZEV1gyTqgTHPbuuKKICOLbiA/tDlCTi3JJqlk/D34VkTEOICH4v/yo6XPeDOA1Gi91aNCB22zUOV5nMgAvdrZof23ymsSHCc2S0ICPXOP8nRmFop9aAMTPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:22:43 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:22:42 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 04/15] net: enetc: add link speed message support to PF driver
Date: Mon, 31 Aug 2026 10:54:30 +0800
Message-Id: <20260831025441.635045-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: ef665b8c-5ec6-4f91-d697-08df070f1e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|6133799003|18002099003|22082099003|21046099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	YluAaP7OW5/mbK9lBXLmRFvJK0E1x15R72WigjO2zDR2c1Q2CksmbizzVNxSdkXZvomYQ7AeVzTp7sY84OZsppjy72muSYCBAHbpGzPAHGaBqeOQXs0ltqTa+V2tL2a8lq798WxQvRSS5IE+aYbSpXCVK70v08bQPYU9Rtgw9+9H/RHNzhqiz2GSkEC4dSfqJ9iKnL5bbLDM8t5kv3X2hRAXQbMxsSzi1u8fetzqWKmbFSFoIPZZhq77kAKKzRQ0+qi0KnTd/ZKZZ7aFkbc3FZAyCK0m62efbBiH7XjWg8OvGel/l7qUnNuPnqMDymzJIJ+7DdvgG4+//7Irn92480dvir8d7sq4we8ZxsuMgvPsd6KxEx3bcClfwpYuWD7OhDBDJb6VtVVEhNr69mFO1q/Ojqt5BT/I6Sed0NjJSM93D24Ypuo2Fc5s7YRhZHRHwPgOc362qPEripDHTg3121yyLMGogFMBrOekZuLBLBJpigHrjh1jE9LZrkZTaTK2Kp709dPlao6xHe5L6FcEiU0H7FvXBrhZe8H6JjotrwtlZNXnRoTcyoNFOPYBaHs6dP4AnQJIU11Qr26ZjbcrQIC5+RYgD+hQiFTf+p15S7tEhLF0CLmKbnerzWshzhyLfyjVZ6HO+XcfP0yC8XtnuWC7cQHjtMMiK2eMN/wO6M254ZfMxYiQR6DAGFGBHBdNwDnZ7oBDrcQ5NgvQqKdMhg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(21046099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fGF6HQlzBVhIJnsTk5xFSyrcM74ERODL1LZqYl2mojqkADkU3VE3sZKiN2a3?=
 =?us-ascii?Q?uooh4ZohYWb7fPiK0HE6L5GvDqRI59X9lPftu6KkrQ30rxw1bqNULAvjCurB?=
 =?us-ascii?Q?xv7BsFcspbgrasAgR/D6Vi7C3lTGVrm1okE0ssfMu0XYUf0ceaJn7hEu+m+W?=
 =?us-ascii?Q?dWbYRpLWhg/OA2xokLEVt1R2EP6ri0morPbmQvP34LeoBaqwqCXDtczx+ArN?=
 =?us-ascii?Q?hhA6D+tkMHGVDEbYYAmHASIXLI4nRMjLTyIypxlBPVj/ymUGOd+pi3Qrvz6h?=
 =?us-ascii?Q?1Jvabm9DgaM9Cnh6bBWY/jCgGKWJOJtxjeCuG6Ti9lu6x+8G/QBucoHws7i6?=
 =?us-ascii?Q?oOmp5YzkVi1uYFqzuCyoYBeltEHkObB0dNAz7XAfdtref//g+DdIAgTG0PSP?=
 =?us-ascii?Q?URdWX0K5AE3M3hXHvGsxLGAGEkqVXPM1Ixa/0a7gSUb0ZvHCe/C7eer7bOCJ?=
 =?us-ascii?Q?P3dQwnJMaYLqxGiPejJv+WrtY9Zvn0DVDe/pyOmhE6ljOayLD3/P5Av1Mhwh?=
 =?us-ascii?Q?+HH29Rq63Jqe9+z+8L+ROHWTnzn2Ry/dFOTqsp9dhug5XkOHrbXqvVXgktVO?=
 =?us-ascii?Q?bWmjarfculDCda7ZPMt93zbJrbjNaj+cl2AjsJm0ILnaeLotdB8Qj0COcKBf?=
 =?us-ascii?Q?v9tHCdCGc1N6Vf4VPFmC/Q2dKQ1u/uhB9f+klDqtqlH7v5coSlXgNQ9kuQi7?=
 =?us-ascii?Q?yszhXPuMTiAqu+2rFSqx2KzIfLs+Gcb90PxUJDY765logQmmYi/sREQ6PYet?=
 =?us-ascii?Q?YNjnNNKeO8DZXVJ3v2ApTfcBLIYvLkKuAlzCn732wDSgElETLtMxhqV8sOWd?=
 =?us-ascii?Q?cKHOcFJr2egMu4wjpmn898S+DRVKJvugvBMKoxGi0TvqIdk1S0G7XXyu1oX3?=
 =?us-ascii?Q?wGocneud6/suuzt8SMKp6mp9hCteNVuAF984WKlAoWsNoyIHmPuhSq3wgUsD?=
 =?us-ascii?Q?e1VcI7BXDYFbAZ9L+nI1iN4OgMyOqB04R3Uo9q2hkp7Skqrc+AmvKcAQRUdR?=
 =?us-ascii?Q?ECczV8Ij3Ds8sZzB3SmFKZb0E7K4iohTHNxNP8aJIuCOqmB/L+wFy0SqNp0N?=
 =?us-ascii?Q?7SR0RJLoOhhCpOqQ6bJFSQ+zlOlpAWUvdbz8kx3HFtBZvBsxyy2YmVYeDPv0?=
 =?us-ascii?Q?UKVMgs7Ujen03lZjBaR7nF0IlaSuuAGdQEbXcoMFvdGR5p54CqSq0JI/+LBE?=
 =?us-ascii?Q?nhfj1O3GT1H49r2xSyCTDXngpVT1jn9zXQ9uea6Ul5JFaMDd1XKokhkV5h7X?=
 =?us-ascii?Q?j7s7l13QFub9sLgLhhGYFlbYRg3NrPEnN0K5wmhZK0+oJb6uL5HvGqbgNUhT?=
 =?us-ascii?Q?kb5xJ1BPPogx4xgmsQq7TKsJotCMIA1qHP1K4I/FxyUrq+AgKmIuKDb5Hd5i?=
 =?us-ascii?Q?97qMC7kC4dWEeXuj5U+i8AwGycyx2uNbH1YJP57eVeauTcXdzsVpRlszmSDP?=
 =?us-ascii?Q?OFRguTb1+5gCm4eynHcU6UW9QdCwhJ8y8fZdUZjCijeIRz/dE0lPPIf0hVIo?=
 =?us-ascii?Q?SYYQclP86TfGnyWGJ3hWF0jBm7cU5EqkJse5iicf8/SXZb0wwXJQSfFp13/i?=
 =?us-ascii?Q?OuZTv90QGxkIM/v2zlmyKeDa/lfgl5jG/j6is4+Dxuddtu2BVJHKP92iQ+8v?=
 =?us-ascii?Q?lr7GdcvcXGhcPXboIyv41TlxgPEiiTEGqvsxkYQcHjAIbgm/JG+BBjbxUpZz?=
 =?us-ascii?Q?HvdKMAM8pZ9ZFB/WAMkpxr3SVEu61rE/hEWJ96s6mg63guO2vHbn9EDOiBrj?=
 =?us-ascii?Q?aYGYpAn6Xz/2zrRgEMlt+dhFnPMBTStLPRNItBaZJBGMRjs/pYil?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef665b8c-5ec6-4f91-d697-08df070f1e89
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:22:42.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQAO++QK/M+tbia29ae5SwQNWWp/kzftr2xVGB7lQ6earpm/IBCr9guOcUKga/yPdKsI+WLK6AcvXbOv6pzD+io8444VjlW5ZuTX7QmFSnbVa0E3H99S4JCeTcIdS/J3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

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

The PSI-to-VSI message is 16 bits and the high 8 bits are the message
class ID. For link speed message, the low bits are the speed code, so
the message supports up to 255 speed values (ENETC_MSG_SPEED_MAX = 0xff).

Instead of enumerating every speed value greater than 5Gbps explicitly,
introduce a formula-based approach:

  speed_code = (link_speed - 5000) / 1000 + ENETC_MSG_SPEED_5G

This removes the explicit enum entries for 10G, 25G, 40G,50G, 100G and
so on. Making it easy to support any future high speed without modifying
the enum or the switch statement.

Note that currently the link speed change notification is not supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 36 ++++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 91 +++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 846998f07989..bd669543e96c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -91,6 +91,7 @@
  * The class code for the following messages is 8-bit.
  * 1. Get IP revision messages
  * 2. Link status messages
+ * 3. Link speed messages
  */
 #define ENETC_PF_MSG_CLASS_CODE_U8		GENMASK(7, 0)
 #define ENETC_PF_MSG_CLASS_ID			GENMASK(15, 8)
@@ -112,6 +113,7 @@ enum enetc_msg_class_id {
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
 	ENETC_MSG_CLASS_ID_LINK_STATUS		= 0x80,
+	ENETC_MSG_CLASS_ID_LINK_SPEED		= 0x81,
 	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
@@ -129,6 +131,13 @@ enum enetc_msg_link_status_cmd_id {
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
@@ -138,6 +147,28 @@ enum enetc_mac_filter_class_code {
 #define ENETC_CLASS_CODE_LINK_DOWN		BIT(0)
 #define ENETC_CLASS_CODE_TX_PAUSE_EN		BIT(1)
 
+/* Class-specific notifications/codes of link speed */
+enum enetc_link_speed_class_code {
+	ENETC_MSG_SPEED_UNKNOWN,
+	ENETC_MSG_SPEED_10M_HD,
+	ENETC_MSG_SPEED_10M_FD,
+	ENETC_MSG_SPEED_100M_HD,
+	ENETC_MSG_SPEED_100M_FD,
+	ENETC_MSG_SPEED_1000M,
+	ENETC_MSG_SPEED_2500M,
+	ENETC_MSG_SPEED_5G,
+	/* Do not add enumeration values for any speed greater than
+	 * 5Gbps. For any speed greater than 5Gbps, its speed class
+	 * code should follow the formula below.
+	 *
+	 * SPEED = (link_speed - 5000) / 1000 + ENETC_MSG_SPEED_5G
+	 *
+	 * The unit of link_speed should be Mbps, the max SPEED
+	 * should <= ENETC_MSG_SPEED_MAX.
+	 */
+	ENETC_MSG_SPEED_MAX = 0xff,
+};
+
 struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
@@ -181,6 +212,11 @@ struct enetc_msg_mac_exact_filter {
  * cmd_id 0x0: get the current link status
  * cmd_id 0x1: register link status change notification
  * cmd_id 0x2: unregister link status change notification
+ *
+ * Link speed message, class_id 0x81.
+ * cmd_id 0x0: get the current link speed.
+ * cmd_id 0x1: register link speed change notification, not supported yet
+ * cmd_id 0x2: unregister link speed change notification, not supported yet
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index e21414acdc0d..c3ae4c024f34 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -280,6 +280,93 @@ static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
 	return 0;
 }
 
+static u16 enetc_build_link_speed_msg(int speed, int duplex)
+{
+	u32 speed_code = ENETC_MSG_SPEED_UNKNOWN;
+
+	switch (speed) {
+	case SPEED_10:
+		if (duplex == DUPLEX_HALF)
+			speed_code = ENETC_MSG_SPEED_10M_HD;
+		else if (duplex == DUPLEX_FULL)
+			speed_code = ENETC_MSG_SPEED_10M_FD;
+		break;
+	case SPEED_100:
+		if (duplex == DUPLEX_HALF)
+			speed_code = ENETC_MSG_SPEED_100M_HD;
+		else if (duplex == DUPLEX_FULL)
+			speed_code = ENETC_MSG_SPEED_100M_FD;
+		break;
+	case SPEED_1000:
+		speed_code = ENETC_MSG_SPEED_1000M;
+		break;
+	case SPEED_2500:
+		speed_code = ENETC_MSG_SPEED_2500M;
+		break;
+	case SPEED_5000:
+		speed_code = ENETC_MSG_SPEED_5G;
+		break;
+	default:
+		if (speed < SPEED_5000)
+			break;
+
+		speed_code = (speed - SPEED_5000) / SPEED_1000 +
+			     ENETC_MSG_SPEED_5G;
+		if (speed_code > ENETC_MSG_SPEED_MAX)
+			speed_code = ENETC_MSG_SPEED_UNKNOWN;
+	}
+
+	return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+			  ENETC_MSG_CLASS_ID_LINK_SPEED) |
+	       FIELD_PREP(ENETC_PF_MSG_CLASS_CODE_U8, speed_code);
+}
+
+static u16 enetc_msg_get_link_speed(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct ethtool_link_ksettings link_info = {};
+
+	/* A malicious or malfunctioning VM could potentially spam these
+	 * messages in a tight loop causing global rtnl_lock contention,
+	 * which may severely starve other processes on the host that
+	 * require rtnl_lock for routine network configuration, resulting
+	 * in a system-wide control-plane denial of service. Therefore,
+	 * we expect the VF query for link speed to be trusted. There's no
+	 * need to consider the transition from trusted to untrusted here,
+	 * as this won't cause rtnl_lock() to be called frequently.
+	 */
+	mutex_lock(&vf_state->lock);
+	if (!(vf_state->flags & ENETC_VF_FLAG_TRUSTED)) {
+		mutex_unlock(&vf_state->lock);
+
+		return ENETC_PF_MSG_PERM_DENY;
+	}
+	mutex_unlock(&vf_state->lock);
+
+	rtnl_lock();
+	phylink_ethtool_ksettings_get(priv->phylink, &link_info);
+	rtnl_unlock();
+
+	return enetc_build_link_speed_msg(link_info.base.speed,
+					  link_info.base.duplex);
+}
+
+static u16 enetc_msg_handle_link_speed(struct enetc_pf *pf, int vf_id,
+				       void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_CURRENT_LINK_SPEED:
+		return enetc_msg_get_link_speed(pf, vf_id);
+	case ENETC_MSG_REGISTER_SPEED_CHANGE_NOTIFIER:
+	case ENETC_MSG_UNREGISTER_SPEED_CHANGE_NOTIFIER:
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+}
+
 /* If *pf_msg is set to 0, it means that PF has responded to VF in
  * enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(), which also
  * clears the corresponding VF MR bit in PSIIDR.
@@ -362,6 +449,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_LINK_STATUS:
 		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_SPEED:
+		*pf_msg = enetc_msg_handle_link_speed(pf, vf_id, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
@@ -546,6 +636,7 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
 			goto err_en_sriov;
 		}
+
 	}
 
 	return num_vfs;
-- 
2.34.1

