Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1F3AFD16;
	Mon, 31 Aug 2026 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146562; cv=fail; b=Yzu/nem1zSG58IK+z54RqZcVG/f+M5IbowtisKWx4PCe9/eBfbHOoVNyiwzImYrsYofZp7Iwwjm0x5BJoPMNjqcL2p4F8TxxteSKlAft2mj9B0t46JZCWrvL4BKLt71GzeHFciQEDpL2aIs/E0lj1yMxsfF042VdCAID871DE7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146562; c=relaxed/simple;
	bh=ufT7X9Zmj0ZLyjEEgRL6/uQdhr+pLxj4MjrsoHKnZos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SUdO+2okOG1X3Qww2yP4Sk71eFJPnGmHd8fWviKPIqG5uSNWZ5ERzDoPlOSn1lM+ZPQ6NTCheDT/5bE7KkehoaMiP7k5ZtLIOBX0u89AY3MLFTeXfb4kbCmhETu9PqKLq2dLcmmSJj4GTPIt1SnZI5mvywGuVNzUB4zt3Asl2sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kiB6XL6u; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kiB6XL6u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTKfo900eKfqM2yjNlNT0YqwIGF29ZYBu8IOt1G6Qupe61PHbqtZS75q6Qe8259BwIDSdCRVM8K6OCk0ICKYcR75BbBDlPnd/8tl6es3+gQiU2wsC4m+RKD7bBdpbj5LQLLsIi5PaRIhs6dfrNxkUweqEolePd3RnBb7oQ+n8dXn4lI995vvX5ExeTZhNJUqe5h81VgGieTS95GDVa2m9yPltaZRyg35dEbx++gOBrfnECJ7RjpEEkgj+9GyV5Xfu231mxhBEKJFvuAUwsBbSeOhUb7m+YRJ+46JWfjRGRA7djf9VcaYRV1B9XQZb+A2dsbmdMtq7l3AQrqOFs4hmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HZSiZlJkoYYIOCkDco+TJyNAvvhDS4tZNinweOaoZk=;
 b=tm7hVWrELQewG4V4a22zQvpHkz1eulrKwaoSwoo6k32lt1/RfD1CgTX63LeEoChdvv+4KP66yirhaiOWAVYFL1RD7NCoEwPkgMiSNdpe/kbZQfaDGoXy2ouj2bhvX7SRaM22gwIyaRB6Ie9LOfY1G9m/VPyUr+cEXkgGn5N1EB5tBneMz2NzTu1IWlWFe0w7paDQz+2Qs+WajDYLDPhsmL1xZjSHJ/R7vNIg+cAy/r8e3jCOwCUBuRxJ7D/AqQe1BXnKFTQPhLe4CIHWap7Mt2ZaMR4+ZfnPvvrEtBaA4Hh3W6yYlR+23uJX/TQjpn4LxcjuJ2YJ48DsR0nkjHqcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HZSiZlJkoYYIOCkDco+TJyNAvvhDS4tZNinweOaoZk=;
 b=kiB6XL6up9nW8ubxRfkJPpI+k++LaTxmetIAZNtU+BJ20n+/SJsT5IlqmdtPlUfGIx8yCBiHShpScOZL1uNLzHtIGBOalz39CetzTRMhjMvIeRHXjYe50hCv9cTAIYy8Mf2QX/j7H7aXgP6OLwaH+qxv5OCHF6Eikcut/OFjHSFmJrkuPn6YPRLUf/V2NBG6DvIonheRzKfn6Mt24jT3un+cUVxn64mfHFEzqB4LCMGbBYvDNUKBSCNMaAmmc1DoOKzO5RKbBJWVO6kSOR90M/ekmJTn66aqwqQnExxW4QscSrjnib+8SEdltsEQ4xZKT3JMNTZ46TEZ0wbXwi4CXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:22:37 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:22:37 +0000
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
Subject: [PATCH v3 net-next 03/15] net: enetc: add link status message support to PF driver
Date: Mon, 31 Aug 2026 10:54:29 +0800
Message-Id: <20260831025441.635045-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 8663af8e-2daa-4e16-2f08-08df070f1b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|6133799003|18002099003|22082099003|21046099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	HT25HBec9p+VCqDjsRYsW3oKUDvHT+BxF9ydrqFYv/UB3Zi4vhoAjpM8c5UdYw+IpgbMjc8CR1fKrCdFzEW/9Aq28NsgwO6nJ7OyGiY5gapwKdJPEPSxXdOPr5vHzcXEx/jzlUHkIi9eJPT7X5/S+UAKoD89JjB0dsZBOdu0MbgKDG6zbOGEb7PvkWc9CuhewvqNtzWx+PisvDRj4sDj5AnF+Py6xf9TyrCTIN+TNgDVK132iAR43VNzVrWpyMCsPZHq6Oge6N9w+yMayeg3KMN/rCGmzffsZV3aJx2gxlNNoJfosBHVbYNZmlfevaHqq8mSob6HHZ1uWS62/enGoaX10nShiazUynCePuKoLHSteVjtkMXeCGaLoThVmUEbz7HP+IclTcpDH5EJUtKe/a0PsFYmU33sVWidaaBqPB8+5NECF5kW8jSmY8GI/MsCqhLWc7hk1ZyOkFpiOnjJ//A7xrMWpbDj5B8NVT0i53MClTS0bsqzvavldOEMEYNO0EizhjYASGrXcucsQhNzP2NMpQSOJCS7iN48FMNz13W/siz8bTSg/IZUp26NB9uFmPy3HxMeKgRJ6YMzpvtLLZI/pQSfLOAMdIVLuLIGFXIrTArjTwylWAUdNZEWiIE5t+TVu5phmtKIwgsGpOWFR0n+73/UEPT2j83yaQXLgG+ZuVquPH3AjjrgzQHZQZswD2IYibWwlRwhcGE4hnhE6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(21046099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C96gMGnNaQyIEmE6Wfhjh3PkOzkLag6bpF5couNoyWQ9YkjEDguB1me7Kr1v?=
 =?us-ascii?Q?5jv8jjz9+iIyyfNO6Wq0g59Vs/EBvQyod4m8Q3vIOu8E9kuxlBp/zZVaesvB?=
 =?us-ascii?Q?nvjkFWh9phLhtsOIlXMlM26i+nb6Hcwoc+4WHZm6zmCBWXoccm4mSb1pc55W?=
 =?us-ascii?Q?Ye/O5PRAP5R7oHwWlZMeRwwJbHoeUa1u/aiKRgYz0lZbqMRIukqNx88Poxow?=
 =?us-ascii?Q?LIOrBKKZxzkEZIQKIKGlmn4dUJSvY0eoFDCi904EXhl5m1nuvc6kPueUqf3I?=
 =?us-ascii?Q?naWTcY0yBtyWHBlIhRJOeVj/jI+vvXsoGh0xeIJG+99SejsJzidz76SagAZg?=
 =?us-ascii?Q?lDbAi82r2sOfveGHijzzX4E78siOXyK0nQUi5z7SmAbYlafLv8XuqMKjhh7u?=
 =?us-ascii?Q?v/zz97bB/03dGaagV6vxy6yDood+pk3aKXFakQxhPd5xszUqDrGb6m88slQQ?=
 =?us-ascii?Q?mx1p9aYYqkb5xpPXi2lXzYWAaNyXE9yb62zNtZCMzULHHNYbPtrFSic+HTc5?=
 =?us-ascii?Q?OmGnnIu04gp6aisIJODylNn4UaBwOQN3kHGrqVMD9nPfHFqRFMuFyhh67fhj?=
 =?us-ascii?Q?QsTent1COscT1amgA7f/+wnDMKrR1OMkEb23WUrOM34cI1wqbHwIzCovXjcd?=
 =?us-ascii?Q?Ugg4d7X5+tnoeMHaim67sPrDtd2UwwBP7O9vvU4yqhhpokqGe0q0OtF2IqnV?=
 =?us-ascii?Q?yohsqh4hg5Dkzlaa6lwfqc8eJWDH0ZtVWRRJqPm1hPjzYpWaqQehxNSMNA76?=
 =?us-ascii?Q?IfpnIUu1T6oPym1HMQjGOr08cNvhNdCz89RKDv2aD12Y7yE84cMWHUegFsFb?=
 =?us-ascii?Q?CO4SUTppDY8FhVg3rh94K6JnlIJjdnWMBZn3cBBYfzfb2iYjWTB95pUhNf8l?=
 =?us-ascii?Q?zpPnPnOnF3jt4wmX0xJHKVMPiTQku9EHGy0MtO64V4utu42c38TsDMB8C/Zv?=
 =?us-ascii?Q?fcr36xK7wxuGjlKFAWiK+orayedozNB5EpvgDkpzU85c9Jf6FhfvXxW81KmI?=
 =?us-ascii?Q?zDjnG8Mx0aFkNZqcFc/GqBEL8+SGeQbCGq8zvXRr6lBUOjswBHoTZvOEFgnN?=
 =?us-ascii?Q?jOXrUs+OOyrjBa2CbGl+1AnEXtHcboAkK67y/HZe/PSRHikwS/qIV9S3IqQR?=
 =?us-ascii?Q?NIBCLxIGx+OFgxqxg0Hc18oEQ9pzFOOKV4uhdhnn7p73MTE2J3LUQSNegoXr?=
 =?us-ascii?Q?PJXa7XtedgPVQBvdLbfQ2xq764dpsJFqsN03vrP5bGt8n/yVdh+mC0Lx9CSs?=
 =?us-ascii?Q?XfETFWOsPJYQQvHhV0RXrN185XRLenHYfKPRF7d+7sWTKJr5d64aVuHfOWEg?=
 =?us-ascii?Q?9uRR58+4CX47izuUm0F4dRX3PT2s/2/hXCdo8CQEplbVvNUag3DvH3kwACdl?=
 =?us-ascii?Q?gWmcMFy7H6M2I3bMHkWf9tVQaXc8AO75xq8+OBrg34IqincXrWCh9INuP4so?=
 =?us-ascii?Q?GOkCkgUOZD8gj1OhtEc815PV6zfCJO4XRh0VppDOXXPjqNglS1wlWlzujAu4?=
 =?us-ascii?Q?ehPyMVCMi818qFCphMsZUqC6gBI/KVu8s3QQN7dcyscu6sgNni8UgUdXBKaS?=
 =?us-ascii?Q?oyQd/lWZW1spFTx2hMHLljYq5vRncTLq00R1N1gZAdJ4j291scrvRS2MIH/O?=
 =?us-ascii?Q?3o+okTpCl4rxDgKcpPifXcS06I0/Uu2LLzonBBryF+oAdwPPW9SViLSWIBmi?=
 =?us-ascii?Q?wVVWL9I7/fCMMz2l0N8K8zvMcFlSkER/g4Ak7YUqa05TOZ9Xan7kwVkypNTp?=
 =?us-ascii?Q?EWpDcEelEDuVPRg7lCEQqKbTrTDWn2So3WMQaVS0NJbZXQOUJ1gr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8663af8e-2daa-4e16-2f08-08df070f1b3f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:22:37.5432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1QMndhtf4ZtcwGBGYTRE6jZ9rCThshbcpgsDRkpH+YFweCAuSDaGJlA2YIYwMh4l2qbtp2yDmE3fceIdJFxgOY2cChP62KDVat5V2F/ZwghTMcu6y4v+Fa/U5RdkltD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

From: Wei Fang <wei.fang@nxp.com>

Add link status message support to the PF driver using three command IDs
under message class 0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS):

1. ENETC_MSG_GET_CURRENT_LINK_STATUS (cmd_id 0)
The VF queries the current PF link status synchronously. This command is
not used by the Linux VF driver but is intended for DPDK-owned VFs.

2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER (cmd_id 1)
The VF registers for link change notification. Upon registration, the PF
immediately notifies the VF of the current link status via a PSI-to-VSI
message, and continues to do so on every subsequent link state change.

3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER (cmd_id 2)
The VF unregisters from link change notification.

For link status message, the PSI-to-VSI message is 16 bits wide: the
upper 8 bits carry the message class ID, and the lower 8 bits carry the
class code. Bit 0 of the class code indicates the link state (1 = link
down, 0 = link up), and bit 1 indicates whether TX PAUSE is enabled on
the PF (1 = enabled, 0 = disabled).

The TX PAUSE state is included because VF RX BD rings support congestion
mode, but whether the hardware can actually send PAUSE frames depends on
whether TX PAUSE is enabled on the PF. By conveying the PF TX PAUSE state
in the link status message, the VF can determine whether to enable
congestion mode on its RX BD rings.

PSI-to-VSI notifications are sent via the ENETC_PSIMSGSR register. A new
msg_lock mutex is introduced in struct enetc_pf to protect concurrent
access between the phylink callbacks and the VSI-to-PSI message handler.
The bitmask link_status_ms_mask tracks which VFs have registered for
notifications and is cleared when SR-IOV is disabled.

Two functions are exported for use by PF drivers:
  enetc_pf_notify_vf_link_up()
  enetc_pf_notify_vf_link_down()

Through this mechanism, VFs can accurately perceive the link status and
report it to upper layers such as the kernel network stack, containers,
and virtual machines.

Note that currently only the ENETC v4 driver supports this feature, while
v1 does not.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   5 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  |  26 ++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 214 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   6 +
 .../freescale/enetc/enetc_pf_common.c         |   2 +
 .../freescale/enetc/enetc_pf_common.h         |  10 +
 7 files changed, 256 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 935a6a03b14f..17fd9ee27942 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -899,6 +899,7 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
 	enetc4_mac_rx_enable(pf);
+	enetc_pf_notify_vf_link_up(pf);
 }
 
 static void enetc4_pl_mac_link_down(struct phylink_config *config,
@@ -907,6 +908,7 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 {
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 
+	enetc_pf_notify_vf_link_down(pf);
 	enetc4_mac_rx_graceful_stop(pf);
 	enetc4_mac_tx_graceful_stop(pf);
 }
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 16da732dc5de..f97602714118 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -80,6 +80,11 @@ static inline u32 enetc_vsi_set_msize(u32 size)
 #define ENETC_SIMSGSR_SET_MC(val) ((val) << 16)
 #define ENETC_SIMSGSR_GET_MC(val) ((val) >> 16)
 
+#define ENETC_PSIMSGSR		0x208
+/* n is VF index, which is less than 15 */
+#define  PSIMSGSR_MS(n)		BIT((n) + 1)
+#define  PSIMSGSR_MC		GENMASK(31, 16)
+
 /* SI statistics */
 #define ENETC_SIROCT	0x300
 #define ENETC_SIRFRM	0x308
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
index d9677da38989..846998f07989 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -66,8 +66,8 @@
  * 2) PSI_TX_control: PSIMSGSR[MC] - for PSI to VSI notification messages
  * (async mode)
  *
- * Note that for some GET messages, there is no COOKIE field, and the CLASS
- * CODE field is expanded to 8 bits.
+ * Note that for some PSI-to-VSI messages, there is no COOKIE field, and the
+ * CLASS CODE field is expanded to 8 bits.
  */
 
 #ifndef __ENETC_MAILBOX_H
@@ -87,7 +87,11 @@
 /* The fileds of PSI-to-VSI message, the message is only 16-bit */
 #define ENETC_PF_MSG_COOKIE			GENMASK(3, 0)
 #define ENETC_PF_MSG_CLASS_CODE			GENMASK(7, 4)
-/* Extend the class code to 8-bit for GET messages without COOKIE */
+/* Extend the class code to 8-bit for PSI-to-VSI messages without COOKIE
+ * The class code for the following messages is 8-bit.
+ * 1. Get IP revision messages
+ * 2. Link status messages
+ */
 #define ENETC_PF_MSG_CLASS_CODE_U8		GENMASK(7, 0)
 #define ENETC_PF_MSG_CLASS_ID			GENMASK(15, 8)
 
@@ -107,6 +111,7 @@ enum enetc_msg_class_id {
 
 	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
 	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+	ENETC_MSG_CLASS_ID_LINK_STATUS		= 0x80,
 	ENETC_MSG_CLASS_ID_IP_REVISION		= 0xf0,
 };
 
@@ -118,11 +123,21 @@ enum enetc_msg_ip_revision_cmd_id {
 	ENETC_MSG_GET_IP_MN			= 1,
 };
 
+enum enetc_msg_link_status_cmd_id {
+	ENETC_MSG_GET_CURRENT_LINK_STATUS,
+	ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER,
+	ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER,
+};
+
 /* Class-specific error return codes of MAC filter */
 enum enetc_mac_filter_class_code {
 	ENETC_MF_CLASS_CODE_INVALID_MAC,
 };
 
+/* Class-specific notifications/codes of link status */
+#define ENETC_CLASS_CODE_LINK_DOWN		BIT(0)
+#define ENETC_CLASS_CODE_TX_PAUSE_EN		BIT(1)
+
 struct enetc_msg_swbd {
 	void *vaddr;
 	dma_addr_t dma;
@@ -161,6 +176,11 @@ struct enetc_msg_mac_exact_filter {
 /* The generic message format applies to the following messages:
  * Get IP revision message, class_id 0xf0.
  * cmd_id 1: get IP minor revision
+ *
+ * Link status message, class id 0x80.
+ * cmd_id 0x0: get the current link status
+ * cmd_id 0x1: register link status change notification
+ * cmd_id 0x2: unregister link status change notification
  */
 struct enetc_msg_generic {
 	struct enetc_msg_header hdr;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index a89a5a418a23..e21414acdc0d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -136,6 +136,154 @@ static u16 enetc_msg_handle_ip_revision(struct enetc_pf *pf, void *vf_msg)
 	}
 }
 
+static void enetc_pf_reply_msg(struct enetc_hw *hw, int vf_id, u16 pf_msg)
+{
+	/* w1c to clear the corresponding VF MR bit */
+	enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(vf_id));
+	enetc_wr(hw, ENETC_PSIMSGRR, ENETC_SIMSGSR_SET_MC(pf_msg) |
+		 ENETC_PSIMR_BIT(vf_id));
+}
+
+static u16 enetc_build_link_status_msg(struct enetc_ndev_priv *priv,
+				       bool link_up)
+{
+	u8 status = 0;
+
+	if (link_up) {
+		spin_lock(&priv->si->gen_lock);
+		if (test_bit(ENETC_RXBDR_CM, &priv->flags))
+			status |= ENETC_CLASS_CODE_TX_PAUSE_EN;
+		spin_unlock(&priv->si->gen_lock);
+	} else {
+		status |= ENETC_CLASS_CODE_LINK_DOWN;
+	}
+
+	return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+			  ENETC_MSG_CLASS_ID_LINK_STATUS) |
+	       FIELD_PREP(ENETC_PF_MSG_CLASS_CODE_U8, status);
+}
+
+static void enetc_msg_get_link_status(struct enetc_pf *pf, int vf_id)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	u16 pf_msg;
+
+	mutex_lock(&pf->msg_lock);
+	pf_msg = enetc_build_link_status_msg(priv, pf->link_up);
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
+	mutex_unlock(&pf->msg_lock);
+}
+
+static int enetc_pf_send_msg(struct enetc_pf *pf, u32 msg_code, u16 ms_mask)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	u16 old_ms_mask = ms_mask;
+	u16 ms_status;
+	u32 val;
+
+	/* The MS bit is set, indicating that the corresponding VF has not
+	 * read the last message, PF cannot send new message to the VF. To
+	 * avoid sending messages to such a VF, the bit corresponding to VF
+	 * is cleared from ms_mask. Because the MS bit can only be written
+	 * as 1, writing a 0 has no effect. Writing a 1 when the bit is
+	 * already set is undefined.
+	 */
+	ms_status = enetc_rd(hw, ENETC_PSIMSGSR) & 0xffff;
+	ms_mask &= ~ms_status;
+	if (!ms_mask)
+		return -EIO;
+
+	if (ms_mask != old_ms_mask)
+		dev_warn_ratelimited(&pf->si->pdev->dev,
+				     "PF cannot send message to VF(s) 0x%x\n",
+				     ms_mask ^ old_ms_mask);
+
+	enetc_wr(hw, ENETC_PSIMSGSR,
+		 FIELD_PREP(PSIMSGSR_MC, msg_code) | ms_mask);
+
+	return read_poll_timeout(enetc_rd, val, !(val & ms_mask), 1000,
+				 200000, false, hw, ENETC_PSIMSGSR);
+}
+
+static void enetc_msg_notify_vf_link_status(struct enetc_pf *pf, u16 ms_mask)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	u16 pf_msg;
+
+	pf_msg = enetc_build_link_status_msg(priv, pf->link_up);
+	if (enetc_pf_send_msg(pf, pf_msg, ms_mask))
+		dev_err_ratelimited(&pf->si->pdev->dev,
+				    "PF notifies link status failed\n");
+}
+
+static void enetc_msg_register_link_status_notifier(struct enetc_pf *pf,
+						    int vf_id)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
+
+	mutex_lock(&pf->msg_lock);
+
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
+
+	/* SR-IOV is being disabled if pf->sriov_enabled is false, so no
+	 * need to set link_status_ms_mask and notify the link status.
+	 */
+	if (!pf->sriov_enabled)
+		goto msg_unlock;
+
+	pf->link_status_ms_mask |= PSIMSGSR_MS(vf_id);
+
+	/* Notify VF the current link status */
+	enetc_msg_notify_vf_link_status(pf, PSIMSGSR_MS(vf_id));
+
+msg_unlock:
+	mutex_unlock(&pf->msg_lock);
+}
+
+static void enetc_msg_unregister_link_status_notifier(struct enetc_pf *pf,
+						      int vf_id)
+{
+	u16 pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				ENETC_MSG_CLASS_ID_CMD_SUCCESS);
+
+	mutex_lock(&pf->msg_lock);
+
+	pf->link_status_ms_mask &= ~PSIMSGSR_MS(vf_id);
+	enetc_pf_reply_msg(&pf->si->hw, vf_id, pf_msg);
+
+	mutex_unlock(&pf->msg_lock);
+}
+
+static u16 enetc_msg_handle_link_status(struct enetc_pf *pf, int vf_id,
+					void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_GET_CURRENT_LINK_STATUS:
+		/* Currently, this message is intended only for
+		 * DPDK-owned VFs.
+		 */
+		enetc_msg_get_link_status(pf, vf_id);
+		break;
+	case ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_register_link_status_notifier(pf, vf_id);
+		break;
+	case ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER:
+		enetc_msg_unregister_link_status_notifier(pf, vf_id);
+		break;
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
+
+	return 0;
+}
+
+/* If *pf_msg is set to 0, it means that PF has responded to VF in
+ * enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(), which also
+ * clears the corresponding VF MR bit in PSIIDR.
+ */
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 				   u16 *pf_msg)
 {
@@ -211,6 +359,9 @@ static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
 	case ENETC_MSG_CLASS_ID_IP_REVISION:
 		*pf_msg = enetc_msg_handle_ip_revision(pf, msg);
 		break;
+	case ENETC_MSG_CLASS_ID_LINK_STATUS:
+		*pf_msg = enetc_msg_handle_link_status(pf, vf_id, msg);
+		break;
 	default:
 		dev_err_ratelimited(dev,
 				    "Unsupported message class ID: 0x%x\n",
@@ -236,7 +387,6 @@ static void enetc_msg_task(struct work_struct *work)
 		goto out;
 
 	for (i = 0; i < pf->num_vfs; i++) {
-		u32 psimsgrr;
 		u16 msg_code;
 
 		if (!(ENETC_PSIMR_BIT(i) & mr_status))
@@ -244,12 +394,14 @@ static void enetc_msg_task(struct work_struct *work)
 
 		enetc_msg_handle_rxmsg(pf, i, &msg_code);
 
-		/* w1c to clear the corresponding VF MR bit */
-		enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIMR_BIT(i));
+		/* If msg_code is 0, it means that PF has responded to VF
+		 * in enetc_msg_handle_rxmsg() through enetc_pf_reply_msg(),
+		 * which also clears the corresponding VF MR bit in PSIIDR.
+		 */
+		if (!msg_code)
+			continue;
 
-		psimsgrr = ENETC_SIMSGSR_SET_MC(msg_code);
-		psimsgrr |= ENETC_PSIMR_BIT(i); /* w1c */
-		enetc_wr(hw, ENETC_PSIMSGRR, psimsgrr);
+		enetc_pf_reply_msg(hw, i, msg_code);
 	}
 
 out:
@@ -367,6 +519,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	int err;
 
 	if (!num_vfs) {
+		mutex_lock(&pf->msg_lock);
+		pf->sriov_enabled = false;
+		pf->link_status_ms_mask = 0;
+		mutex_unlock(&pf->msg_lock);
+
 		pci_disable_sriov(pdev);
 		enetc_msg_psi_free(pf);
 		pf->num_vfs = 0;
@@ -379,6 +536,11 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 			goto err_msg_psi;
 		}
 
+		/* As PCI SR-IOV is not enabled at the moment, there is no
+		 * concurrent access to sriov_enabled. So no need to use
+		 * msg_lock to protect sriov_enabled.
+		 */
+		pf->sriov_enabled = true;
 		err = pci_enable_sriov(pdev, num_vfs);
 		if (err) {
 			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
@@ -389,6 +551,15 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return num_vfs;
 
 err_en_sriov:
+	/* If pci_enable_sriov() fails after partially creating VFs, a VF
+	 * driver that successfully bound to one of the created VFs could
+	 * have sent a registration message, setting its bit in
+	 * link_status_ms_mask.
+	 */
+	mutex_lock(&pf->msg_lock);
+	pf->sriov_enabled = false;
+	pf->link_status_ms_mask = 0;
+	mutex_unlock(&pf->msg_lock);
 	enetc_msg_psi_free(pf);
 err_msg_psi:
 	pf->num_vfs = 0;
@@ -396,3 +567,34 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return err;
 }
 EXPORT_SYMBOL_GPL(enetc_sriov_configure);
+
+static void enetc_pf_notify_vf_link_status(struct enetc_pf *pf,
+					   bool link_up)
+{
+	/* pf->msg_lock is initialized when pf->total_vfs is not 0 */
+	if (!pf->total_vfs)
+		return;
+
+	mutex_lock(&pf->msg_lock);
+
+	pf->link_up = link_up;
+	if (!pf->link_status_ms_mask)
+		goto msg_unlock;
+
+	enetc_msg_notify_vf_link_status(pf, pf->link_status_ms_mask);
+
+msg_unlock:
+	mutex_unlock(&pf->msg_lock);
+}
+
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, true);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_up);
+
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{
+	enetc_pf_notify_vf_link_status(pf, false);
+}
+EXPORT_SYMBOL_GPL(enetc_pf_notify_vf_link_down);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 142c911f1dfc..fb48a06e6c42 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -54,6 +54,12 @@ struct enetc_pf {
 
 	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
+
+	/* Message lock, prevent concurrent access */
+	struct mutex msg_lock;
+	bool sriov_enabled;
+	bool link_up;
+	u16 link_status_ms_mask;
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 519fc90d2647..345cb940aaa3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -582,6 +582,8 @@ int enetc_init_sriov_resources(struct enetc_pf *pf)
 	for (int i = 0; i < pf->total_vfs; i++)
 		mutex_init(&pf->vf_state[i].lock);
 
+	mutex_init(&pf->msg_lock);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(enetc_init_sriov_resources);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 96a4dc63da57..693aee3c64b8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -31,9 +31,19 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 
 #if IS_ENABLED(CONFIG_PCI_IOV)
 int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+void enetc_pf_notify_vf_link_up(struct enetc_pf *pf);
+void enetc_pf_notify_vf_link_down(struct enetc_pf *pf);
 #else
 static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	return 0;
 }
+
+static inline void enetc_pf_notify_vf_link_up(struct enetc_pf *pf)
+{
+}
+
+static inline void enetc_pf_notify_vf_link_down(struct enetc_pf *pf)
+{
+}
 #endif
-- 
2.34.1

