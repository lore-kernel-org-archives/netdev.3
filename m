Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB23F8ED3;
	Fri, 21 Aug 2026 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294299; cv=fail; b=Pkp6HP9QnjV6lFBLI5nhqwTVImOO0oVsRcFkcjg2gNM0ZBiDG965gckX1kvdzk2qc2l+/TUQ5H49FszOXzSVcRCAwiaDwGk+ZAh5RPkLscevYenC5Z+fFhonl/ceztnVbXUYqtQScLDKMkhOITW75PMELIebO1hqgRAPjvOAqCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294299; c=relaxed/simple;
	bh=FIOMF0wtmq6xKxm0T+aqdGQAX0mLeYQbkiRmDvl5hPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DROxDfF9UR2yeZezi36WCJOWoUY4RuZaX3AqG2BYS09jY7EBfmNPAKRYbaJMSgXO8eQhJEUoDnK0zHssskjOISeG4zE+X8ifdLyCWM3szprMEST9dfGLei+PPA5ivfud2XWE+bCgLDLk5oHoRMqCueSRkfBLxLJoR8gbO/ppSuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gmUjXBGf; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gmUjXBGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tR61QeVSOLXfzdTLaxgeAQsk8EKqAfL3VEMrurVXyXoiMJTCs5FpfXpCSyheSYaXyPtOlZO5J2aIWMm3AYcJwOXhYnf9Rz0xacCkIXHZRxdGfGJNZ255DuDDnSS3qPy4AP27QNsh3l+LkEkVu5YYRlWU4+zcc2+Kve3VJoknYmjAEIOHjGy4JGXawiq6pSukq91M0eDXNItp/JjJhpnzs4VQacSzdDQ5PWiSEBqvSdCMT5cknlROK0SAdHxAPiBonTa8KuXQG37eyM69wgtFKAXGrPZPdBclth2xevCmQqAv4yup60c1RpOWyxFT2oPLPdj2WNl7o4NSzXqBKGjY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfA7v0c+tXUzObifbzlH7SFhJYlqygu+W+RXtgtP7w8=;
 b=sOIRi/tVM5Q2XEtnjMOjpmcusg85AnwhgodWF1byopeZliV4RWPa2ETMIuLXo4lHWOwprgOnqxdIKYexbvjB9fT5A2jM+ORpqhPRLsg1eIgiwra1njuaVG0x8uepesS2gLklOcWADAfbzReYuljZD4ILJebgBZWSX067OroSPZM48fHyxOtglCQuzU2wThmW+ULkdHKImOcJr5K1zB3O/WFiyXER0Ot2UhacW+c5DiSukPDMLjDoaHJdZeL5vj4e3WCX0Rkqa/osyh60BMHH3UrfQQCF7qbF0oXbw5wg8yYMEfloUD099uoha85xBkwkYqWFBiAUzKrTjl7Y60W5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfA7v0c+tXUzObifbzlH7SFhJYlqygu+W+RXtgtP7w8=;
 b=gmUjXBGfHjUXnLs6gkpVzUf5+vW0QiYy7q9bmbWEjq9MV5h9c0D0lIZ6TzKWJrxOfxfMDmnvYTlu1BMtMzZbTpnomOs1v6AhxiQdyZ4tGfKvTmZJhlhzXm8Pgtg1iWFyKUnJCnkpa/wYP/pPYHuqP4CHTHZd0qubPdedpEJYcDHYrxvYwd4DNw6RtWUBeKz7yQu9BMyR1k/uF7InOOpaet2rC7AA/so3TimJUJeoscLzxa7TkPRBwj7HEPDi1qA7x2cItzEfBOMEOGryEFeSYqC1eEFa2QdSaBtCBs40G2JCPws9cEZMWBiKymrQFdvGdDBLt6hz5ICsBQTyGFMYZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 06:38:14 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 06:38:14 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 2/2] net: enetc: restore RX ring congestion mode for ENETC v4
Date: Fri, 21 Aug 2026 14:41:40 +0800
Message-Id: <20260821064140.1315611-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
References: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 00554c52-34cb-43b8-403c-08deff4ec6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VeKJixxSN11I9dh4wckkdUXclX9uFNu9buL1UsDkv9VFPOge4BDqUJma01p/NT++8lUO+R9qWHlGhfXmhBBP3zRCKw8u1eA3Qz8pcYyZwIiLjyf0kYKrcurfhE3KTPtJI5szRSpUgQ3nT+fs+pb0tlf9CcHydo7137pOocavhnK0Wd0QC1v/j4bPYx0oka3ktHfoJR8Lp5OzDCV2raVr1QBKsFnl6XzJKs5OXPfS0Sc/51/EiVGnqM+6oxwyVldk+kRP083Ofvm7YuGuQcnhKSfvMaH4/lx0qzyOd8GNSfz0MJuejNkRcesk+5cLMMPX3oIPVtUz3NZ+5G+oRZPh8M8lPOAir3zwN4lX2kTgiDq8M2xrR9oa5mPlPx/j7H8axfAm1uFV9F/NQo9rHvBYbKqqFYV/ucLZR+o4MjpaDlCC452n84T8QrnkvoQx7ruQxxHjpie6Li3nd6Yh5ENQrkxFXAGqFcz7X7hL2q2timJRYKxUT49GH6H7Tw2+ACNQDUVylACXmaKZyYNrDZPVjI2aApEyrlPibWFsOmM2eSIM7M1GOhswon4/oJeQ6PxVu1VsUpVvBu2COklvdf30IhCHHn7TPAmgaGJBuBNEzClm7X5W/lmJiWR9GUKMsrzqvJjMeGBRolpxUjFzhVDj8sfVc7SOXoU6ggsPCVjAYYo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dYyN3EnzF5wJG9gyOhX0jwCOXArs8nicgwVznK7mSdfycXHIq/jccNGa6Vk?=
 =?us-ascii?Q?nGr8RpfmvJJ8DZXZi/JD5Q6vla9ZA0WMnZ/b3GICAqXk5ZNI2JnkLDEjYQ2p?=
 =?us-ascii?Q?9du/bfZaeiO4IrCOPuiPV6PudE+cuhqd3zXCwfNKbdOZfiRT/5Xwk08gnQuM?=
 =?us-ascii?Q?xcleWVXqQKKBozR1GML48DD5GCU633i5GyEcRyKL57qchi0w+7JiFibwEqnU?=
 =?us-ascii?Q?ukpeR5HIYk8+Uqc98mfkuFkZpb8Q/lLX/T4ncDGVjMykKMD7bhNMqreNs6j0?=
 =?us-ascii?Q?IWkV2bndYG9yItK81XV5KriczW7VunEMzod4y5ubvnUljpuH7HieL6tRLBJE?=
 =?us-ascii?Q?It+zg5kuktX+PREwf/KFatAkl0Az5vHSBy94RCT/Av0jEY1oVgIOqQ8whtyO?=
 =?us-ascii?Q?IZv0HXH1sHQzClRCkmeKuKQ7Kh68oZx5ZX0JwQ5TSjW/qYvZzPvSd6wUma+H?=
 =?us-ascii?Q?ZXdTG/Etq6Oo6FCHugiqDynAxUhoA8Voi/mi+Hqm+51Jncoy1j5OTZStj6It?=
 =?us-ascii?Q?qA/Vy5GjSRsj2f/r/viPbIzk6lcr3dWZXCpwX4SBTGXHVGDgTfl44sqvIfJA?=
 =?us-ascii?Q?5MBRDXHd6GJWTuDlg/TKbTFn1rJ1M1/IC4+iotZ51EBjkhHFVkv5pZwVg0jr?=
 =?us-ascii?Q?0QdVgCi1g3wxfASXJ/8/lQo3mOQ89/xg7PCed27sxceCbgO/KdzGLWA0FAZ6?=
 =?us-ascii?Q?puHgenBpjYBkBvy4b8roYJaNCsN74qHFG9NuYGGWDXbzb/ea96ViC4IokxRk?=
 =?us-ascii?Q?vujEaHAzeZXnSerW06N1pSZJzXF8ma9LpBiWEkiBI40JEwEYMPmBF+/Zu55t?=
 =?us-ascii?Q?QUTovsjcXAwripCw4hkkojJ+Ohi6yPyc1vHGTbNPeukqrnFw/dHDk1Zw3t35?=
 =?us-ascii?Q?0V8Bc4mgieshCJ+b5FS4wt8Ws1tpPYp0Bk2lF/6DteTqdRTGrQul4HkzQgEx?=
 =?us-ascii?Q?idrG3WE9pF8J80LP1WyVIDSaycyuoiKjWz09QUqqi310+lt9IRbJFecUJv0N?=
 =?us-ascii?Q?N7z9YQ3IJuA6x50A7oU6STp8OI3bbifVPf2llCz3QqpHp0JyTJHDUImLfHhE?=
 =?us-ascii?Q?5IIK3zq39DYEQql930JyjTSAy14VG3b0boHFohnyD3nzdbkvlCTmHEdXrSfm?=
 =?us-ascii?Q?BuHZy/baVfyZ0HbITE8JgOfeEPOXureLYlw1VZi4kXN3Do5cpGydx9tFF2j0?=
 =?us-ascii?Q?SFpOj1ck3BN+tBPcQOZL+zykFhTaEp4zR+rOPSnKxfNBH/xabgbJwBvk7kZ8?=
 =?us-ascii?Q?xEkNBrKkN5iPj7xklAqBvDAtRLEdw0VP02J/QMY1j9cqXEk3KuMi0Z+Y+j13?=
 =?us-ascii?Q?Rk2a5tpdYznbp8JnyS+CDgpRGVGM2s+B5GFf0U3j9FtOYovKIyNjNiwvEpw8?=
 =?us-ascii?Q?OSmJNh73p1ItL6Il1W0P+9miXtpafLVjzJiBCmeod27xhvM5dFIuuEaSWQiD?=
 =?us-ascii?Q?WTDFCKgxErNV6AuMDILSFkNDKhFALIizHOaVi1DWJK0O251l6svlChAjwX8M?=
 =?us-ascii?Q?5lgtT1G4uyTfmbxw5LxmIKp69NTVBHTlpDw4mp2e6F60pQ8+mSKvIHhZIJdw?=
 =?us-ascii?Q?fQ8CnXXakdU3FYFpMc41MyDmVHJ3XDOCs7xdIvDIhwqsbToBoLmSYbHhtLLm?=
 =?us-ascii?Q?GzdhvxICMeQIaiE3LK67n6JLHjArFWleYCUfNwrrx69hRGpGsa5xijBVeEmJ?=
 =?us-ascii?Q?nUahNQm77GGmrGzffTobhaQCAuOHdA+7V8xhVKeW1mOuR3wPKwusxpp14NPg?=
 =?us-ascii?Q?BriHVyXSXaDUYlKf12x2jWrRJK7nLYEAAjuXrKBqhcxWhF9oBh/H?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00554c52-34cb-43b8-403c-08deff4ec6ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:38:14.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7mkSpmxc3eIhHW/zlzpt098zDKuMMMFVY4WEgncjXUEwNDENU++jMJF0HSo6hxKCL3EpqHqQ/AxCyxrJ+Op45irGah15sv7PjeStMBbF5hCwCzFXpAk/2D6RMj1GTvY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718

From: Wei Fang <wei.fang@nxp.com>

ENETC v4 has the same problem as ENETC v1: the RX BD ring congestion
mode (CM) is only configured in the phylink .mac_link_up() callback, so
it is cleared when enetc_reconfigure() rebuilds the RX BD rings at
runtime (for example when enabling or disabling PTP RX hardware
timestamping) without a link status change, and it is never restored.
As a result, the MAC can no longer generate PAUSE frames on ingress
congestion and flow control stops working.

Fix it in the same way as ENETC v1. Track the desired CM state in the
software flag ENETC_RXBDR_CM. Route enetc4_set_tx_pause() through the
shared helper enetc_set_congestion_mode(), which sets or clears the flag
according to tx_pause and updates the ENETC_RBMR_CM bit under si->gen_lock.
When the RX BD rings are (re)enabled, enetc_enable_rxbdr() consults this
flag and restores the CM bit accordingly, so flow control survives ring
reconfiguration even when the link status does not change.

Fixes: f5b9a1cde0a2 ("net: enetc: add PTP synchronization support for ENETC v4")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index fcfbabb29d22..9bb1004548ab 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -718,22 +718,14 @@ static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
 }
 
-static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_pause)
+static void enetc4_set_tx_pause(struct enetc_pf *pf, bool tx_pause)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
 	u32 pause_off_thresh = 0, pause_on_thresh = 0;
 	u32 init_quanta = 0, refresh_quanta = 0;
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 rbmr, old_rbmr;
-	int i;
 
-	for (i = 0; i < num_rxbdr; i++) {
-		old_rbmr = enetc_rxbdr_rd(hw, i, ENETC_RBMR);
-		rbmr = u32_replace_bits(old_rbmr, tx_pause ? 1 : 0, ENETC_RBMR_CM);
-		if (rbmr == old_rbmr)
-			continue;
-
-		enetc_rxbdr_wr(hw, i, ENETC_RBMR, rbmr);
-	}
+	enetc_set_congestion_mode(priv, tx_pause);
 
 	if (tx_pause) {
 		/* When the port first enters congestion, send a PAUSE request
@@ -898,7 +890,7 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 			tx_pause = false;
 	}
 
-	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
+	enetc4_set_tx_pause(pf, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
 	enetc4_mac_rx_enable(pf);
-- 
2.34.1

