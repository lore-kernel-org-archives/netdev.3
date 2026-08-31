Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39333ADB9A;
	Mon, 31 Aug 2026 03:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146632; cv=fail; b=q1xlUfb7OJAM5tH0Ji5f8fGWxhYp0L0lC6f8PwTX788PGqgUAIAhd7jFjfso88t3LPI/W8JRhTf5JsoacwLqkpgiWO9BMfDdVnohva0UV3RncsPq9EtME348Ws4gfj2Rb0/VF6b9K58Hgy63bfXgaZLNVBR0NAunQoQpPBt8Onk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146632; c=relaxed/simple;
	bh=ggv4CDMuArqxrXszdTxPJoqn7ezzzJfQn/Z3vF3Wqn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxJAqEUyjlBu1M+87Rnmfr/CdWCQYerRhOPEo7Zv4Fk+1p1WMsXeJvEZtO5WJU0guMroNlRm8B1RLXbWhI4V7MdWKbNRn2Z68EAf3WdlS3V69gE+7tKDT4SYqOF5BUBHXdw8j3ciXa0TdjOiupNK0ImAA/Hd3OfvPuWhcHjxlto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=m4UH5tds; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m4UH5tds"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz3aNRBKFmyX4Ua7T3/LJSmsUOaw9SDkkX7+5Dw+DaNgW3G25+0249xzLAx679lHB9vBLVRUiRS4Bwp3U4tlMlCuel8Gufk+SgedtlurG6DGdhZ+eIstvruBZa5O+i0vuFsTW5CFMFB2FsUOAu2Ym0UIpCLnkySupq6/AE/6TqoGw+kHbESpj+V2wEEF9kHV+RK+ymke6cfq6HXRgMa8Jaopg5/DI3mPZ4VJvDNJkbpACQI3BbLLhbyM6fO6ocpcVjadjPUCghRZ5qVfzMdbxlJh5eBuyP2XevQa9mzsKAScbgBI4IN2ORqn655qHwtscOB7yUnLB0OZTLCcblyZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6Z88X5kB0HQKFc4TvChTjFKTuukXhxZuX69lh3VgLE=;
 b=kltX/INBn9tFR+KrhIP7zHu6G6TEQN4BSllHAzS1dOnupK4vXn3DMu7xq+akKvG0jDk7SUQ1NevpFvlM5YVLiyoL5hUo9zROhZ4gTDuu5GdPfI0kOTvrNzHHn4lReCh/uccbZ3dhNmIrI84w0DesgzqUARGfrWO5fQ6Wan1OsNJRfLVll0PxVnfuHNFIORXcsa+YnZr2vhdyo1TEGKB0Oetvy4TgwrD8Yv7RhctD43DM/KSXIgMefzNEZtvLVk5Oca1lM0iBRGop0fTlK2fD4CaDYMhcLs692BNCmKQcJCVJLO2HFScRGQSnEfCGBad0AieNlbN0hRSYZMw8jjVESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6Z88X5kB0HQKFc4TvChTjFKTuukXhxZuX69lh3VgLE=;
 b=m4UH5tdsf6Uq5IAOyg9WxEAzZsMJwtNKi10zDrKxi9YAxbzmh4nj/qNvMGvVggb1ZFxjef2kdSvaa5XhtstBdcOpDLXqPuZqrmzurS+6dv+x/YxwT6IVCXhkTm/4aPVKvomRPdU2K2HNiK5CMf33O0aNdR7Fg+knX4yt7bP/4VCCsY26RrnOD5AJK0CO0rPwlikG6rZrKRSkjZz8J5rqfpFcfQwPszmtQJ4bFbwz80/G4rOpj2sp13Mv51JI+WlchxfAv+TO6obCkTZz7dxHeF0gTtcadTlSvaD8VmkIZ/XzJr4Rh2+comaQ9p6wbTlwRZR5T6Q3sjlRNJaByXQ9eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:48 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:48 +0000
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
Subject: [PATCH v3 net-next 15/15] net: enetc: add ndo_get_vf_config() support
Date: Mon, 31 Aug 2026 10:54:41 +0800
Message-Id: <20260831025441.635045-16-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d9e61d-cf93-4d8c-33d4-08df070f4558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|7416014|56012099006|10067099003|11063799006|3023799007|18002099003|22082099003|921020|6133799003;
X-Microsoft-Antispam-Message-Info:
	M7vsaVZ+RzPkRTYY6FNCqT2wNszypRpUX+aax6+8AZhmcgI6hnj8huoBlqKzrSLMaFf+5VJ4d+CMIZuViJyrbRfCsSYKsvleC/sXkvhdILiifAURTJuEBbojsUBwXQ9tDmms+Xpq8k5w8Hw7ydYrC4AHFd3qmEaxv9buV3RyThmJyP95s2FeWalOm7hhp6+O+nV6yeN0jMaEG6DwIVYkcSmdAYc36TudJPG2TbBPSl9DAEQkJT8wgUfWWKBEc1yPQ1/ryoQTB7TiSeyFUUIxo0KOerOYPDCj6q0JuZhqMDFm8LSc2ILBZyRm2MlgSbQn6GeeXmfFJmV1xVL0EzOacn1fOrmXz9aPIOdEHSGjInMcf35WjDu/PlPNgm/DjqrQ9HfxSSVphC0KzFxEwPsDItet0ysIlGryjxr9SvnZIELh+yOhCeugtaw47ZiBwX0Sr4oJGKgvP3Io1+/gL4SBuH7Ecn8EIaIct1LE/DCG1WDb0rQYQgI861bLyUYE3p+rHNMA/R9bJB6Q6DCf/4L1KBQAJK4QH8Urw0vOyhI8CrmoFGjPUW4x9vGX3uqAGGftgG3ldRrS74TgJBe9sZqYZ8jH47Q7lFaNzAdCBHpIcKurSoWKwW0GbS1e/dK0t6ggyqgkBjqBgddmEEp4n1sgV2a7A30wiUycoyu42XDS3PJH8AyWy2OHSHEBswkUOUtVfAC6iMbzkWrdwI/4UVKvMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(7416014)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003)(22082099003)(921020)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SdEXzPqU04t517+uyE3qTdJlzhvRqfvWXte2jtLMSLgsYexiSbKXLiFiVQyL?=
 =?us-ascii?Q?1VK0yrgi9FjRc/WA83RbgwXofEgTWFHcIq9pIbtsyRIF0f/OZrHxTKVF7+et?=
 =?us-ascii?Q?znMfd5GCM4ypKzZnFZCBzepX9S3oPXW371ekRnk5QRsMu371pUhP+sObFFSV?=
 =?us-ascii?Q?2/jrb8vLwLP8xCY7kZyIet7MtXSW+I8I84m4xnVc0Hl1FneeLKAIoS90SWbh?=
 =?us-ascii?Q?KaaGr8BZBnU87MU4Xoa/KuIUEV19cG4EflrxiBWUTbnjcsC6URRw7iZnZS27?=
 =?us-ascii?Q?vcFi9XGSxgTuw7zmHojVOi/+Hdj/GDldbsiD0WUM1O54i4zse15h9F4ZtP/H?=
 =?us-ascii?Q?j1tU9FT5cbZ3HceCs7VOs5EhIRe4ALBo5DGL53iJ6gZAn61n6QAk1gdvhPyr?=
 =?us-ascii?Q?nhduzuAu8qgievmujB5I6ooxMysggh2UbQT4efMu6ayPcLPdcnCY1ZEtuXu7?=
 =?us-ascii?Q?pwQrKFHu7mYdOqp/eNakBswGDbhzDmLHmxSe7VHPAUJTOCQyJFLbTzZgwwc4?=
 =?us-ascii?Q?9SfP4MiHVLgrWrr1T1S09EagvryK2eqO6T/UcZ38/QKxMRTEx2YOxbWEIUiX?=
 =?us-ascii?Q?yMRtdm2FQRX/APsC76t62zpcxskyc6bOvmsNYLxoWZmZDhJ2bRYsRgMDeAzF?=
 =?us-ascii?Q?CdMDHr9zXMOCGVlH4tuJpPEkRANl8BmcFTbAmAxZ2F4P3aLmJMb9Yt2K+Nfh?=
 =?us-ascii?Q?7MPfJ6nTgGzeLW7IAiRkuEaP6RDGJOomsU3v3tSN5ZZ4ocySZxNszWiPaNz2?=
 =?us-ascii?Q?Cw8pKYWnx3nyyPk0g6/G6CAStL2Efm189AKiW8oxU/y6unWZg0Qej+0i6rth?=
 =?us-ascii?Q?4Wt5AN0RwjVNGr0okfcdLv3Blx519pcgFwAn/b0F7hoHtdEJ7t2yxPFo3ZYg?=
 =?us-ascii?Q?5eL7011aLEKJAZCuIPrQsNrwi6fJ1E+fUeRg4ZF+FS93fNpH8NqTe12IQqQz?=
 =?us-ascii?Q?hcPef0GSEnzpWvh7rz8nqJBfPaEjFsU1vGBZFUPD40hLuEgS5oSKdg+1U/9B?=
 =?us-ascii?Q?gPajMi9YcNkcL9NE9ux+yWFpM1lFtJhJGG7/9Gwor9h0dI/Uo8eaTzxUwPr5?=
 =?us-ascii?Q?wUDH2/ub0JCos0DhMncRhTFMcFkcJHZCqldcLRdzrK7l6J/gxZAdDLfSFK+4?=
 =?us-ascii?Q?yixOgxrWApZYyJSgiXa7tTfaJE/lJYsVDXwxy+dW578yDwtmgPEQSatMfURD?=
 =?us-ascii?Q?JbI4R/lJTi8fh30hyrv1Ft8hbk1VE9gqoRw6k8kYTlzi4ZaZDyCHBIqHJA4W?=
 =?us-ascii?Q?lZL1n4UzbjjNdm17Xu+x2FsYXaK+wqd8eijfD5cjFtgpcRc1K6qTycfhxZbW?=
 =?us-ascii?Q?E0sPpm79KLgwQsNeV785SA6POXKDg2belhJbnK3HGBjnhQQSMFW8FwXNz+K4?=
 =?us-ascii?Q?wlfF4ctY01eMa9YX96D4WA9h6pL9H1EG9GRbHIzP/H42BER5mrMH+VXd1sPW?=
 =?us-ascii?Q?9xP+Q1NS66W/2PemSIfB04tq8qVowSW3LijDEkpBn1VXhfo9NYd9GY3AEX20?=
 =?us-ascii?Q?Zx+mrWcMZKY3MoH01d4dnsr0ZJ9725uuDYQu9/GilggYWlqp/FttvNsgBQbl?=
 =?us-ascii?Q?nJxDGYubjBH72O+ImDuRXYtTzPhTNuR5SdZC1eRpn7P09X9jpn0DPauvEZAR?=
 =?us-ascii?Q?SULUwjTsBr2nQIhGO/gKV0v3Tev7w8PKz41QYM+tu86FYgo3owNouNK70hqX?=
 =?us-ascii?Q?K2Cs+ZYOD3rRbRY8udsRQg/NaepTzTzn1S18xN2hTm2TbhsYf2/0H7vXQy5Q?=
 =?us-ascii?Q?hLr3/A/hDHwa6S6tyN1iKvlosYaR6ExO5TAPBy9y5wzR4UxuO91E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d9e61d-cf93-4d8c-33d4-08df070f4558
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:48.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuGIw+tz8mbWWFOlKBIZfUMndp85lIvkOri+kngzC211mWnH1B9iy7Ouw4mwGx/ml9YwgUs8GyAzCSxhBsdqPW5UebGM8m77gWhwTzHv1+OndpBAtJFG9b9EdRGGMVKR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474

From: Wei Fang <wei.fang@nxp.com>

Without ndo_get_vf_config(), userspace tools such as 'ip link show'
cannot query the current VF configuration from the PF.

To support this, extend struct enetc_vf_state to track the per-VF VLAN
and spoofchk settings, and update the corresponding setter callbacks to
persist their state when the hardware is programmed.

enetc_pf_get_vf_config() reads back the persisted state and reports MAC
address, VLAN parameters, spoofchk, and trust state through struct
ifla_vf_info.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  1 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 24 ++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  4 +++
 .../freescale/enetc/enetc_pf_common.c         | 31 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 ++
 5 files changed, 62 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index a945a120c553..b4d76505bc03 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -597,6 +597,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
 	.ndo_set_vf_trust	= enetc_pf_set_vf_trust,
 	.ndo_set_vf_mac		= enetc_pf_set_vf_mac,
+	.ndo_get_vf_config	= enetc_pf_get_vf_config,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 523c71324780..d77a07cece28 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -195,6 +195,7 @@ static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
 
 	if (priv->si->errata & ENETC_ERR_VLAN_ISOL)
 		return -EOPNOTSUPP;
@@ -207,6 +208,17 @@ static int enetc_pf_set_vf_vlan(struct net_device *ndev, int vf, u16 vlan,
 		return -EPROTONOSUPPORT;
 
 	enetc_set_isol_vlan(&priv->si->hw, vf + 1, vlan, qos);
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+	/* Currently only C-tags is supported, so tpid is always 0,
+	 * which indicates ETH_P_8021Q.
+	 */
+	vf_state->tpid = 0;
+	vf_state->qos = qos;
+	vf_state->vid = vlan;
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -214,6 +226,7 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
 	u32 cfgr;
 
 	if (vf >= pf->total_vfs)
@@ -223,6 +236,16 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 	cfgr = (cfgr & ~ENETC_PSICFGR0_ASE) | (en ? ENETC_PSICFGR0_ASE : 0);
 	enetc_port_wr(&priv->si->hw, ENETC_PSICFGR0(vf + 1), cfgr);
 
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	if (en)
+		vf_state->flags |= ENETC_VF_FLAG_SPOOFCHK;
+	else
+		vf_state->flags &= ~ENETC_VF_FLAG_SPOOFCHK;
+
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -476,6 +499,7 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
 	.ndo_hwtstamp_get	= enetc_hwtstamp_get,
 	.ndo_hwtstamp_set	= enetc_hwtstamp_set,
+	.ndo_get_vf_config	= enetc_pf_get_vf_config,
 };
 
 static struct phylink_pcs *
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 6bf4105ee0e3..25e869d54365 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -13,11 +13,15 @@ enum enetc_vf_flags {
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
 	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
+	ENETC_VF_FLAG_SPOOFCHK		= BIT(4),
 };
 
 struct enetc_vf_state {
 	struct mutex lock; /* Prevent concurrent access */
 	enum enetc_vf_flags flags;
+	u8 tpid; /* SI-based VLAN TPID (0: 0x8100, 1: 0x88a8) */
+	u8 qos; /* SI-based VLAN QOS (priority) bits */
+	u16 vid; /* SI-based VLAN ID */
 };
 
 struct enetc_port_caps {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 10134d7a1f70..264294a0cc23 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -684,5 +684,36 @@ int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 }
 EXPORT_SYMBOL_GPL(enetc_pf_set_vf_mac);
 
+int enetc_pf_get_vf_config(struct net_device *ndev, int vf,
+			   struct ifla_vf_info *ivi)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_vf_state *vf_state;
+
+	if (vf >= pf->total_vfs)
+		return -EINVAL;
+
+	vf_state = &pf->vf_state[vf];
+	mutex_lock(&vf_state->lock);
+
+	ivi->vf = vf;
+	ivi->spoofchk = !!(vf_state->flags & ENETC_VF_FLAG_SPOOFCHK);
+	ivi->trusted = !!(vf_state->flags & ENETC_VF_FLAG_TRUSTED);
+	enetc_get_si_hw_addr(pf, vf + 1, ivi->mac);
+
+	if (vf_state->vid) {
+		ivi->vlan = vf_state->vid;
+		ivi->qos = vf_state->qos;
+		ivi->vlan_proto = vf_state->tpid ? htons(ETH_P_8021AD) :
+						   htons(ETH_P_8021Q);
+	}
+
+	mutex_unlock(&vf_state->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_pf_get_vf_config);
+
 MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 91a9c339245a..f36f45450733 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -24,6 +24,8 @@ void enetc_set_si_mc_hash_filter(struct enetc_si *si, int si_id, u64 hash);
 void enetc_set_si_vlan_promisc(struct enetc_si *si, int si_id, bool promisc);
 int enetc_pf_set_vf_trust(struct net_device *ndev, int vf, bool setting);
 int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac);
+int enetc_pf_get_vf_config(struct net_device *ndev, int vf,
+			   struct ifla_vf_info *ivi);
 
 static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
-- 
2.34.1

