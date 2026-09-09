Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17269524AEC;
	Wed,  9 Sep 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950158; cv=fail; b=L2S94NRZgyK5A+MiyfFEVnRDUMxppLbBlzZx9KZM9l9Df65kgObPtxIeYiKYaRyU6ZSiL6Cpk0+UiZ6i+KBbIOX5m856KaoNchnTBR9XnQZN/1+6n+LOTmts1ncn8q/uYEwjsrPPEB4iaTadUQ5nKJPAAZbr5r/fnt99KgmEEQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950158; c=relaxed/simple;
	bh=rHCeskQqnvhivkDTeR+XDHqbkGcPpY9PTpFABF9hpuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GjFrKi7T42Kr7lRjId/safsuGQqK8QUhrmaUTi1tkBc7yyyEKZKTGH1UKB4fHwoWdp9QnwNmxtTxpCll+Bl8ZUQuO7RBaQC1NU4FxLhUAZWB6d6Mjh8tsb1GjjsFBVlmygSdgSJK/LbA5zHiTUklGPNH/gu4UBUNuRjCBVkd6H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OtgDCUUD; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OtgDCUUD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4c7X1W+/nUFqRFsg82lQqysNoN+IEBGREc/+/BzD/1AE2zZwd+xJAWQ7KSapRxGckNNZvT2Lw56cLUxUsEKTtHXzm4HAhg7YCyesJGWk3FyzAX0Jy4QDUCzXOcIk3e1ti2gVO4ZYeBDNEesZgBpoeHFCTwoxqvZXJ6aIYAK5B3pGRZlc7AiufSOKhOsJ/SeyDVIkJMTz1lV21cxYpjHr7VHYajeH4pAWXqwjBaXCjy3tr3wr1KJchv2QE4ro+LRPgFrfgy2V2OoF+H/FSvV+0O+HdmWsJO+pSaWTBFhhO0HwyWOidcNclWaWH5YzKr70irURn89vlmk2OzXZmhozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMm5jesuroz3b+MXnm5r6mcUt6fsk6FgT21Ds9BUmKA=;
 b=Q/CW9U7xuiD2rfq1ODOYSwRkyJ7qT3JIg7+0I5c/HCHg3BRu6rFB8HOSZvDzGmPoUAJqkddbZf18xk/u7ips0puG0I1fJbRtC/olSJpetB+p9/QQw0djEwPSDrmHALkqc5gB9bWobdVmLfZw9tvqdR3IwSnfoPIcMX27N72TmlAL+8ADW6BSHIOf6+kxqwzjC+Uh6XNYMqJY9bBgTaWXS/qV7ltCFC7+vtXc+cB9lYCEYi++COAD403zvXE2ewR57vQp8L3wKio0NuRc3nfXqxQwPFN90zu0N72vSxW0Jm82cdEf/IvTtQJosxm2/PYl3orDwE3V4sLF6X2S0WlTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMm5jesuroz3b+MXnm5r6mcUt6fsk6FgT21Ds9BUmKA=;
 b=OtgDCUUDZ8tEkl2ySoPKEF1cf/VMhun/IY4Za8D/53LonfDvQo6jzkmxX6sNB+SEjlRT3IgFKqtfCvWx38i3JN0wLj9aeZDQboUYtNKo/AaiqjUdvZWy8LAozuiH66qSWNYS318VhkqYBVLDgVqMdkA8+3VaFmNpRjgRYHzXyU37UJylK9Wdd6vJ+PUKiRsV9enOWONLOwOrwEoSUoS3WcTdh7DG4eW67MjH9xBN2z8NG1lXX/aGULX6Xk1Qp22KuLxPeaHlHzQFuPbIlhETnYPOve4MRaRbb4en9nWWyf7W7K/Wh8eug1hOmr9RsX6EhX2cFsbARLinrNoZBIFyAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:35:53 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:35:53 +0000
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
Subject: [PATCH v4 net-next 04/15] net: enetc: add link speed message support to PF driver
Date: Wed,  9 Sep 2026 18:07:22 +0800
Message-Id: <20260909100733.1139689-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfa9d2a-0dae-4d5c-de54-08df0e5e1f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|6133799003|21046099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	4CPQc2Ipmj762I+PpMuwB4AzEFsmH4q1fzJRTJlGHcRztkfDuxU0welWSb/rSdEbrxTWVUcaO46El0477OQ8fIDafIIojso9MJIcP6FVU2OkY6/D+PG3TT8uQVaU2D8DsB2ouiDmahue9B33WD/FE+FEKmndOtw70rni/3oYb0rrBHyTVNMzYvRwBf3UpntR261AUpEbi9q5gh5760UpUf9YsNIOv+EPKmiMp8vKhq5yJYsZz5VMn6UprR1/0go2jnzbn2a7jWyiLCzIZ4Se+PvO6YlBXFfWZR9sinkvAaJ+8OVPGIJegFNvQWkemfoEZgarThw5gqFMRJagKaTLwiylbgr0YVivXIU66fZ+BZNKMw27OTWkxQily5P4poMNbem41Azjwbht6xK1UD0O/nbzQSuX1vb2wHm3Rzt+/iGB6wbVmJsNIUp4PBf0KqXFmHV6QvGmCDJbgxUTNyEeJqKDZ2Z572uPkYY1Sx5r8f9ZrvVKdRHsAAVSsJP8IYIr65BiY+XgHsLxAYMGfClxSd001jbv2TDNdxg8GR+4FatH/fDOdM46cpGQgLDESK23ED8tqJ2iQ1EEYRC0HhNuVDBail/ZDgABHqgwsWjboXftGoLuXsNIYriOExJkidgylAN+QS1+Vgq1a+rIaivJBy9+0sv4iZSAlAcq5p8l4O8yjcsSk5URA9kwmwvJYszZ5LRxtkjQjP8SDEeZtQ6gXQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(6133799003)(21046099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ENtVnIL3i2hkKu845IDnh5B3Kg/AXB5fuO5/uShaVHQBZDN2SwNy1zNnPAYp?=
 =?us-ascii?Q?4ddu3RgG3YGqUdl+iInAke7Y5CHFrCRMWhfSHgSdDI9gIMLmqhv+EEyrOpIT?=
 =?us-ascii?Q?zYTPiN8ifI6GLyGnombgQIoJUHG5GYWJBgk3e3WTv7dOB2WJ9vZ7V1tIVKFO?=
 =?us-ascii?Q?hZtwPqAbfDtfeMOsxC2QjcA7MwKrxQLHzrDly1lKZSqpNThox4JcMVY+ENjX?=
 =?us-ascii?Q?4kxfPGrWpxCQjv/DOLKhPEqxsbtbrHBOtHv5O+pGLlUUusmbxLVkMloW1PAg?=
 =?us-ascii?Q?YtPfBdzjyvSbsIZpL4BPfdF0Lls8DatSVCwxKPRgajWo65YV2bIV7jBNpTFt?=
 =?us-ascii?Q?spm6OROOmnqRPx6KQCZuQHhl6naVCZYax9i61y0XBWF/LteL9cIEaA1tTWH7?=
 =?us-ascii?Q?iZEqO0JegbgMKhjvkX4aXpBZCyGPg8Q8aTNbcKQkQzHbMU9B6xCbQYpHEVpz?=
 =?us-ascii?Q?+wpxBkXObWDQF9UF3zV6CjL6XaNcuwoTLIeNpMBFiF57dsQkyvCcDZLlF28q?=
 =?us-ascii?Q?6oO1EF178tU4VlERqTsyCa/Ptiy6gNiQAqq76SDDPyU9v1pZR9GH9VR7u7Q9?=
 =?us-ascii?Q?nNf0KPE6FzyAt0+ItXO3CpsX9Rp92bjw58fMIYjHwNs/keHVy/I2iECuUyQT?=
 =?us-ascii?Q?XFqtvB76Mu+8ExvUa1VFfD06Jww5bqZUbR0jb246iGRQXf3nQJPu+CnRWkpu?=
 =?us-ascii?Q?kUcSWyrOsLRuL9ITQ0OKkHSi9QqRvg1VuSsMgVSdw+k4w//bs+SOmuyRdfAk?=
 =?us-ascii?Q?3PjHyV2rGq4xzcJw91wEP5icKcjQVgB5BXq1Vpp3PEgKZkYKs37lg2P7aqk2?=
 =?us-ascii?Q?O5ahwbPDIsgp0ExcWKnhCwWjL9meJGE9g+LCveSJ44E4bKN0nPwm9WCXOKf0?=
 =?us-ascii?Q?RR6qOZNTkHxt6RKWR++kfcG9xLl/2OVYejXJCtLAAZ/u0ECTF72f45BBKD1M?=
 =?us-ascii?Q?g7XLa9A/zT+R0/ctT+vma1iq73MQcxzBa1iFCSzNBqO/uBvnUOM8DeqGKUFC?=
 =?us-ascii?Q?TctQS9/eUgR9NsiL6KToOyVGgLBoRWQVw4BxMFaBZAsQbIghrT5HSS7HvZf+?=
 =?us-ascii?Q?dRr4NwKwhSYjU6fiaGOfplQHzPd4uh6LSt26/Gi6zixoohR7ikgV2VE3dQNm?=
 =?us-ascii?Q?OjJ3FPh7URUXvIgJH8hgH1pHgpE6zqnyrrtKzOx0w48FJfY5MmXn5pXm/5ML?=
 =?us-ascii?Q?AQuVuAhCfflfP45NWGdJoTafob49km2rwMPLPaHEfrqmJodVxf98LRKR7eN7?=
 =?us-ascii?Q?UKDStJNCXNEvxE3yOdLEN0RAvYl/ROX/cP10aqOo6jk6SvfiKFLfvc2gtwQn?=
 =?us-ascii?Q?0DptN8Aa69X3+48ZQXZuxcztiyTta7GDa1oyQSiBeNL7+BIk9bD/yO7FtK35?=
 =?us-ascii?Q?WcnNvMx4xykhhYX8qz4V77S9sEwssp1F6GBGxym/W/PJagtem2vM9NFuE5hB?=
 =?us-ascii?Q?sN/6yX7DB6szdHXR68b6XiWma7BQDlTjf0Hx0uDpQAvbJ4gQSiDD9rZoi9KY?=
 =?us-ascii?Q?jw6gjaMA+Mt8Gu1zFZz3xIaBbrr2ctvh79XcIympeREBvFEksQD+J3gTPJA4?=
 =?us-ascii?Q?Wniz0lWlJG6nYBglzojkwgxN1sRkJGRQuYGhgNLjXr9Vtzvlk2afhKq9MxTq?=
 =?us-ascii?Q?eWG2uUB6qIuQzkoMg9NdjC2wacU+6XkVQVs/xW6EreVD+tQ73xGbVOgV+ERD?=
 =?us-ascii?Q?oifYhLUOk23VWikYJDY1Y+8Hlym5de0iIuGSlAvkA9kYKns7JVpj0tzRcy+F?=
 =?us-ascii?Q?pVjjcuA6SJQ7l748iLg5H5JKmZtrJuMRMGOvBCprVj9P3dSsVCnn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfa9d2a-0dae-4d5c-de54-08df0e5e1f94
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:35:53.2206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQUUSA4a2+XkYg4+VsElVIf4cLUOiIT0CWFKzs6KTCuanzhG5XbhbHqB1qlug8XHsc7hnZA6q2/jAl5KEomNr3lwcYIpaOSm/WuknmtG0M4vtCdIRsqvYP9/vSWRhsNw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

From: Wei Fang <wei.fang@nxp.com>

When a VF is driven by DPDK, its user space application needs accurate
link speed information to make correct forwarding and configuration
decisions. Add link speed message support so the PF replies with the
current link speed when it receives a get-link-speed message from a VF.

Use a new message class 0x81 (ENETC_MSG_CLASS_ID_LINK_SPEED). The
PSI-to-VSI message is 16 bits: the high 8 bits are the class ID and the
low 8 bits are the speed code, so up to 255 speed values are supported
(ENETC_MSG_SPEED_MAX = 0xff). Instead of enumerating every speed above
5Gbps, use a formula so future high speeds need no enum or switch
changes:

  speed_code = (link_speed - 5000) / 1000 + ENETC_MSG_SPEED_5G

The speed is read via phylink_ethtool_ksettings_get() rather than the
speed passed to the mac_link_up() callback. When the MAC has a PCS
layer, mac_link_up() reports the PCS link speed, which may differ from
the external PHY link speed; phylink_ethtool_ksettings_get() returns the
actual external link speed.

Unlike the link status message (class 0x80), the get-link-speed message
is only permitted for trusted VFs. Reading the speed requires the PF to
take rtnl_lock(), so an untrusted VF spamming this query could cause
rtnl_lock contention and starve routine network configuration on the
host. An untrusted VF therefore receives a permission-deny response; a
VF can be marked trusted via 'ip link set <pf> vf N trust on'.

Note that link speed change notification is not supported yet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 41 +++++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 90 +++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index 846998f07989..832d2f6ddcd8 100644
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
@@ -181,6 +212,16 @@ struct enetc_msg_mac_exact_filter {
  * cmd_id 0x0: get the current link status
  * cmd_id 0x1: register link status change notification
  * cmd_id 0x2: unregister link status change notification
+ *
+ * Link speed message, class_id 0x81.
+ * cmd_id 0x0: get the current link speed. Unlike the link status
+ *   query (class 0x80), this query is only permitted for trusted VFs;
+ *   an untrusted VF receives a permission-deny response. This is
+ *   because the PF must take rtnl_lock() to read the link speed, so
+ *   restricting it to trusted VFs avoids rtnl_lock contention on the
+ *   host from a misbehaving VF.
+ * cmd_id 0x1: register link speed change notification, not supported yet
+ * cmd_id 0x2: unregister link speed change notification, not supported yet
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 79dbaf72fcff..08a9ffdd3eb0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -230,6 +230,93 @@ static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
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
@@ -312,6 +399,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_LINK_STATUS:
 		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_SPEED:
+		*pf_msg = enetc_msg_handle_link_speed(pf, vf_id, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
-- 
2.34.1

