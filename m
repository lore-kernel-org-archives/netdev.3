Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B293905E7;
	Fri, 21 Aug 2026 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294289; cv=fail; b=IpGJ/pla6jT4hRYiSjN/3FfV5du8N3+Z0ejKVkJpGgc/tymIg4XEiIxnj/qpbrrc21J5XxXe2GavMjYqq1waQKlN/N2JfLUG7D9uYuuTE+ZFq1IZFo5+ozqxKGjSgYSaqhNzsMrjRXkJtd8iaqSNDKcsR4x6fXSMUc0f3e7DO88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294289; c=relaxed/simple;
	bh=2lrMv9ZkWia8PnM5gzCiV/XdpjWqtKKUIAbne+wmaAA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fhRa5L1xzpyFEZr4wshFNoKK9YRJ7IGHVfJZ7yRmN3drpx0mBQN1vYcs1oHH5nHA48XQnnj1jm1of0UW3GfJ4p0ry/QGOiwt7/TdOTIJ+/jxLdkW7q7tGfV/8BQp+2rIap5gnKDgu+Tdlgen9hnYevemfb42YNWeCgPikBI8K5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KnloBnUW; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KnloBnUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTtDgzn11adaykT+ZQK9KZaMgkbUg4LEwTkdNFH2aGAXzCbnEZf8rEAOU3f3WCHTG9zdv7dEXrVKF6Dei+R2O7hiMVYzaL09gFMLws6QslLWGxL4pBLnLdSwmi7sSPDQdGPe/+x1ucpMgGB8Qp1baJUAHqPFLK4dJA0hSlSGFr+xxoQJpnk6x9Z8tu0F+bQu8iZT9W+uUokkPhn9Xu9XuqyNwJjNRahpmELEMyyKEQwni3dUDmlBBC+a5oin99jY8N0ft69K/2JmTMS1GyW1jvDC+bTif5+lpfPvvxJ2AJ30THxl6VbwyZjnoy4MM9lHUYVeNV0PyqNS/HW6YTiwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHfI+rjmc3CAAenuWxjjB23gnYSlWbuLAibkg71MW6k=;
 b=xhy1yDFev26DQhGI49+6zCUQOZ8xk/2sIEr2K3UfMT/QBJiFsdjRSZDEInwm7Z/+SD9jjiYly3gEyJKGCN6xbUsqGVkYHcGrSDjrdHLksNuDDLhqMAu5bSpBTIsO+Yn4K85T8rVy68Qzojo3uAJonfPB9TmYpqjpvPpER0QNcVw3Ht+lgINlxwBwwK0T5AJ1zY8ZU8xNb5Y2eUvVaU7HS34e7OpSinu/35N2mzDPTqFWRxLPGPl9DUmexUf04LvFMZkKqnMQauRf7Z6PecMvsYW2ls1bJCJK+I9fy5a6q3CtKlPoyfTCgUvHSqzO25Jxd4l2h65OODlZ2eyK0KWCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHfI+rjmc3CAAenuWxjjB23gnYSlWbuLAibkg71MW6k=;
 b=KnloBnUWIlkU3xO+VsGNAOBxZMyd3EsrXxFSbD6MPKsjBYyQS2IpGNVZbZmVSvndvh7C7iiHNboZb9bp3301pIu9ulS53h/+FzwrtySS2MAnEMK6qh7NLbM+W08u93EsP9iXTkMe2wsBWCDeKql7W5iSGKSJIo8O53Px5e+BHzzxQnrAM4AbmlVv8E8/zlePPj8WAD+lT9UbM/sqjFWk47SH3DEFx8q8ImLHovWmMnRsP1+kIgu/WIXHH8gbkDx5xpKTuyRmX/c1RGUbcO8iqXntaw3n/q4nZYjCx/pRzrQkL6/aoiz4lnslf3W3ceWxalJt8s5fbpFhRJfLe1K2ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 06:38:02 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 06:38:02 +0000
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
Subject: [PATCH v2 net 0/2] net: enetc: restore RX ring congestion mode after ring reconfiguration
Date: Fri, 21 Aug 2026 14:41:38 +0800
Message-Id: <20260821064140.1315611-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 01f62ccd-fb83-4dc0-b55c-08deff4ebf70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	KxLC8gjOW6PGpVHRbn+ZLfwo4HDLorBai7GUF7d5m93g4FK4ulD18VhsUZYU9ululg2lfT9v74SZherqwdY4BN/nR82YpovGHxvBjliKmUk1YdBlPdEW+ePaA4TZBRLOD7D6G7ZIkCgU09CdJcyCcdT250+y2w0poHnfQvcL4rNBGX28kuxvsnVtnMk2ufwnOJln3VOpPkvbixx+7vHC+qyXL+yOVhkaCblkVjoJ+24znAF0Dod2bfZhLC5redZzThyHvV74YslMVU83wa/MZIEtmSOiqYTriKzuDlQKSxyPvyuxVRENcomXiy8+NJ6y4Vf/7IaN3eWGsTe9Bf/HVCdNTykJCYzvUbPXqSAS77u10r2dTdj8HFh3LKj/N3zwsdenMQt7BH5Xfow3uPX8ffm3dlKJP4EsFUxODMbIvzgu44EBLsbSIc0w2yKj2ZkOobMRdrV8zDuLttYWxMsXsQoxq/h+rv8wnfs68k4Ht+izvXZ9CJ0d6SKHuvJIGCpjh/Duek3LMxl9Z41halL8DbkKP64pOIN9z2IWC2QWznBZAGj5OiQcow75KJwf4YCAJyzXI5yaQ7glB660jyNw7QlgyMjRJpEUVaHZJGlO7au0SR2KNZ/7e1AyUekdkjEITP3eKO2ZwqCQg+158kKrMhQMExe6Z+wzMtdzatslEIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18092099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aWTmobGgOwvHLmOAkraIweFBoq/HePw7YFM40K04T3Tmqw8KsYleGVl2BRP6?=
 =?us-ascii?Q?v3d10nbfMO6wjG5VI3qClLMuVvu54MolA0M6mixdT9T11huJeGrbQVzrnWj2?=
 =?us-ascii?Q?8fR/1utvEV9vHwBOF+dOkyMGZAZTAU4EWUcDZ9jpKfy7BLMnfCv+P8Uktu0B?=
 =?us-ascii?Q?mQntCND0iBQnRlyfd/dhm9K96pwFxV85tYGcR3+ZkX32Mleu7yF00EJLjzQr?=
 =?us-ascii?Q?VffHJo0H0CTj5we5Zfx8veFU2HNKKFSxFf2s11NGpsb2eI/mIIrjNaHw26YC?=
 =?us-ascii?Q?/GKRcsqCPazwWGPSWzcQuqgn1KOU7qCzZK0WQ6dBS6nPX9AD1r66uY+9a7WF?=
 =?us-ascii?Q?Zvuyah5a9pqERLA8wN80q+SQSYV7D3BzfzQUKaVzM63kyobi3Z5mcF1WER4B?=
 =?us-ascii?Q?TiShVozi2rUi3UyYTNgwi+0Y7Xa0Z2a2lZPD6TJl4tHSEzDbSLTCG5L9seyg?=
 =?us-ascii?Q?U7HWfosiTp2CwwkFXiCGPs/mbZwaaKUwPja3SF94dK8pyDbw+o5gDcR5Kpqd?=
 =?us-ascii?Q?kkkYlwjJxqpAp+W5cHO9VtRk8nuBhmZpPOBGqX+TjgJtIumMdfp+ktJ7k3ED?=
 =?us-ascii?Q?3JZ2D3ycz0/+xzuvL3QvqlgCL1aRFvk2RaV8vGb6HMbiP7cmUok5jTOZ2rsC?=
 =?us-ascii?Q?mr7vpDSJ30L3Kh4/l092HCDhjQJq0k0AfOyIzrRarFn4h/bKUBGMewsMugmI?=
 =?us-ascii?Q?a1u3Ufas1FhBEtqf1OpZO9cuVvukbnBxsJ/chBWEy3Mp4HOwtPvT80mHU4ry?=
 =?us-ascii?Q?rdPF+fcdZirKl9S6s2lTLVydovNK18C6PSSZAlRlYu7dgRtWIZ9Eha7+dqF0?=
 =?us-ascii?Q?nprd3JrU6VLntvk+I6lBlEJag19ehXcekhYRTbe5XUExvNmzVROjMN8NeWh2?=
 =?us-ascii?Q?SFhgskJf9TY2AAwm7AXocllSSMTzmQe5nBeHP1aAC3otnvrsanwboBf+kVPm?=
 =?us-ascii?Q?avFJ3xHQolc2ut6q2PZ0QOEuZVUMtytd4ewACk4pWsAWFdp39iO/l9njTMUS?=
 =?us-ascii?Q?eg7Y4kD20HWL1w23axqfs3jdAqOtZhnnle/WT5vGvbi1xGqG/yXSz+AkcRor?=
 =?us-ascii?Q?Tz0wFl/HmVODGJDgAw6vPC+hnM2vLX27b77hDWuI77bLmBfTg7/CWloCS38B?=
 =?us-ascii?Q?HJjoT5YK3Z60FMhv8U9g12pPEf2PQA8U3BxkItjR8E6LtGW8q6OVI8vzrS7r?=
 =?us-ascii?Q?V2wRHd6wRy2Eappxprgnhf/5578E8AUiItBdzsU8VyA5I5ewa38fcK3T+sAl?=
 =?us-ascii?Q?L/5CYzTrYOcUwAIBSkMLHpLkFhFiJtem/HgcEzvR++MZY1hjjSe0KXhKkVlC?=
 =?us-ascii?Q?PVRxgN6mf2J8eUKuJB9cd74ng8FX0LwOBrHMBQ7F36hFGpzQLklzai6myhQy?=
 =?us-ascii?Q?y+StACJ90l6Rtw/M/KuL1QSy14nJBC+5eVe2SsREACb2IDkE7EL7MVp9CY8u?=
 =?us-ascii?Q?4P0QV3AX20yjveR1l/EcqSnrZM1ZK2jTgLlzXvjtp2GPDgEH8vmlRfRKdylV?=
 =?us-ascii?Q?bDKIjhW8bDIYXf9UlsAVJrqkfAJ7cjHOplASUSFft4BsJV7wbG3uxnG/Uzok?=
 =?us-ascii?Q?n+EeXDss8A5g/Y/23GtDk0g1XSA7nrPFh+bDFxi/lJ1H7EG15ml4UKANPbfq?=
 =?us-ascii?Q?q8Yz9E0XG8tJ7zBJalJ8FNaq+C8vSchhkqAux3/RDMLDFLhr9cnyRFFeJuYt?=
 =?us-ascii?Q?foZsF66DtLlQpP5Po5/BckZUl/uFWxjgzbLForB8qguEBkRVtGg1f7PUNtMN?=
 =?us-ascii?Q?utzmYG4PQD4/1GKvP505ikBEbcRHt40Sq3MbcKYvHH9YsaSO6Z3M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f62ccd-fb83-4dc0-b55c-08deff4ebf70
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:38:02.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm2MSReEHVK1lZiUnhh/lTh3h8Dgn0xK1bWU+xaxf85lX+Y/5mixwA4qv8gWTfHpEwHvGKJTFGizxtuPmzK96B4P7vliMN6iShdDEXbBK79IGcvugCVojxP1ejnghsQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718

From: Wei Fang <wei.fang@nxp.com>

The RX BD ring congestion mode (CM) enables the ENETC MAC to generate
PAUSE frames when ingress congestion occurs. It is configured only in
the phylink .mac_link_up() callback, which is invoked when the link
status changes.

However, enetc_reconfigure() tears down and re-creates the RX BD rings
at runtime without any link status change, for example when enabling or
disabling PTP RX hardware timestamping. enetc_setup_rxbdr() rebuilds the
RBMR register from zero, which clears the CM bit, and since the link
status does not change, .mac_link_up() is not called again to restore
it. As a result, flow control silently stops working after such a
reconfiguration.

To solve this issue, track the desired CM state in a software flag
ENETC_RXBDR_CM, which is maintained by the .mac_link_up() /
.mac_link_down() callbacks and consulted by enetc_setup_rxbdr() when the
RX BD rings are (re)configured. Both ENETC v1 and ENETC v4 are affected
and are fixed in the same way.

---
v2:
1. Add a generic helper enetc_set_congestion_mode() to set the
   congestion mode of the SI's RX BD rings
2. Move the setting of ENETC_RBMR from enetc_setup_rxbdr() to
   enetc_enable_rxbdr()
3. Add gen_lock to struct enetc_si to prevent concurrent access to
   ENETC_RBMR and the ENETC_RXBDR_CM bit of priv->flags
v1 link: https://lore.kernel.org/imx/20260728023217.2499420-1-wei.fang@oss.nxp.com/
---

Wei Fang (2):
  net: enetc: restore RX ring congestion mode after ring reconfiguration
  net: enetc: restore RX ring congestion mode for ENETC v4

 drivers/net/ethernet/freescale/enetc/enetc.c  | 72 +++++++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h  |  9 +++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 16 ++---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 14 +---
 4 files changed, 72 insertions(+), 39 deletions(-)

-- 
2.34.1

