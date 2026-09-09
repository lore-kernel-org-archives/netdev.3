Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3352941B;
	Wed,  9 Sep 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950241; cv=fail; b=DZMhJBNWwGgsTkPa+UtNbI0DseJG7s04R3I/ny9l1g3hvv6QTOS84i736fQaUNwBpC7SRMtRSZE1QQAVpLg7QMvSIOcxF/1F1OMOJgVO8sUv5c6CNNGH0NCbYpFbsLizoCkRkjQbfz9qFuS5fkiYRtnBOdj54H/XPrmP8fZhduo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950241; c=relaxed/simple;
	bh=DWadPBeCmVppvUsm2e+AoYJpeAGxax0Epr7A2eiKWpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YH2awkTmJ9mw0tbWnHu6DSLSctaHx0kNqKqsIr0UThoaR+tFLxdote/wc/TiB6PDR/14NoWs+Y430V3yfJaQbIMFp0y1YM174Sor14h6N2zUjhzk895w9jUZltd/ZdM4YjlqfZsKwTqJ74zKtB9d/oBwCJNjnH7FBUeAVOXmyak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MTxmcfE5; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MTxmcfE5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5PGME0o9JNBf51m/mTBUm36RumTHeU61LdcnveVQUEHQ5lgQJhFSPlR+5X4INthM+zF0bi6fm+vs+bESj6NNza71dLehDVYQh1YqsV1v6RvqDo0vfrBBYoo6nYBT9I/UoJ3m+e6l8W+lTnLlWuFAHJLb7VURqqrShlZtD50aQraYHN1Of+XZfZ2zMtrWi2oABqq2M8jw7cLqMYLGGu2pKfGbjgtGzCnNGPOGyb4Rxc1yjHGS3Z2eJMOi6qYsWlGD5IvD3wUuqV7tJ68dsIboCxgWRbbnyz5xRj06zXGPCIisnZV9GVBdCHPItBtUk+7/1RWTFPfvi6GGYIkAiovZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2hl++nnOmqrN9WOhV4kjB0ssgfich5k6ZDwc/Gkz3I=;
 b=sznfFO4Z+OhcO00dll6qo7GkjaUavOCnNz0vPqdDc83pgCpbREchOR56w0K3/opqu8q466XcMwbo1PvPpBaLZaLXMh6vjIPYMfymvMddL4CiITc0Zmzasb8KDSxyRJhaq4wbcgL/yT0HQq8b/woInk7LyDW8fqyKI/0T6H/E4dH20ZkL74l2WfEIjbqGBs5Kf0yK35nuVMw8t7GusUJgh6z5wIE4vdK4R4kGtkTIVi8YpktheLalpmYWaw0rUXjxena/5yrRN4tEz7NHhpkGiWsvNT7gcUl/pqxIZyQhU7+BQ590FP3CIHAit8RrKLx+Irk3s7kk4j5wkNufXV8IoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2hl++nnOmqrN9WOhV4kjB0ssgfich5k6ZDwc/Gkz3I=;
 b=MTxmcfE5CxI6ZRKoRCis/1hwX1eetpQfEZSyascSBoxG6R6X4xnAGPT7Ul41k7JKL0f3KVbMu6WkYLY3IwraZjA3u8WfPQG7X0NKkr6Nm8nL19FQTObqwGhGOw/Z5U+HY8rs6DFxDPfsjOXPAXdTB8tqCxqrVkxfduhP5hThbR0+xZ8PUsxyDhFPYtRHmXocjZesmnKutyJOMkCFXPtIka3uv/HUzilu/Q2OzEg7Qf6SjGpvUroQeLWjLdti4mwPN3FrRDqmylTzYfbmF4F13amwV/FtWDAB2OLn0I/EkG6/mVzpW4Fubm8sb8agvHWBmWx/CsHXVXaOM3dICa/APA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB617387.eurprd04.prod.outlook.com (2603:10a6:20b:7ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 10:37:16 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:37:16 +0000
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
Subject: [PATCH v4 net-next 15/15] net: enetc: add ndo_get_vf_config() support
Date: Wed,  9 Sep 2026 18:07:33 +0800
Message-Id: <20260909100733.1139689-16-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
References: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB617387:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd4cc52-6b7d-45be-f810-08df0e5e5167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|366016|1800799024|10067099003|6133799003|3023799007|22082099003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	h9DoavntkiF0QH0pUVDm9Xu6oyIqGMRHxsn9l25LopKLVylcBQTDJeHgaVw+zoGYxjvJhcb6rdZ1sjNQRV3cVqUE2Auv0lS4oCkyxVE2Xk9cShvwc14rH5mGBOK+CNCai24hsHEncF6mXwD/OC17QZHk2jUt6U5TGL86nSKnGqq1UVzTNnzFAJ+CWYy8wZdqRQrBbP8cXU7CuXZEJyW/Ce8xrMy48A6y36l9L3DsvM7b0DiMtCEeIHRLgSfymy1EFLedpmNrkKkbGd/uMAp1lBtFleIcUM9cIPQyCjfBN7rAUvMWU3/fOmLVvz5WJurEZa3Xg/JrEv4cEQ1qFTKNfEth7Q1a4L8CkUslnOAWNDQhxH0ISGqfRNJ6mYhClNgrko5ekRXQEWY9yTiZl9fHzX8983SxKbuw4m2C0WJkAIwH17jPHubzoMcUGflDiwrVmyIcbArI6PsBU58+0JVWWWbl8EaM6iYXtLab03tw8Im/mhvIe9vSBMcmom7FgRV3IO/221UivBUlywxiGdc8gxN+V2Kz4ZrEvs7O1TV9qEqAAJ7G3EprHh+IVu3ncRXmgcPvb/Si8Rw+xfQsTKMqgk3pJewZZnRwChefPq5Rqnk47roDtbW3kMoe0yKb3QaLGA8RJocyhkqoEsOJxuqpnbG+C5Wc1bHaWpyXHgXO3FqCmEB8Lk/NI4qwQzha0jpK3uvDCwl8hLah6PewF3K07A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(56012099006)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okG97+3uOsYASZZwiXlN0C6RcnlM/9c6G31LiiBiyWgxA50sa4nFKL6hmmmw?=
 =?us-ascii?Q?nHBTejNtVD2b9EkmFbhuMLH2wEIY6wE5aiqpf4phAEZOBZCN0Y9GRRVxpch7?=
 =?us-ascii?Q?JfnapjM5BJSdD5765BqYtOKOdga6lAf+AqXGiyJDRjhIZ5oYZ9o0ji4i7Gcz?=
 =?us-ascii?Q?ALYD9IZ7LBaLPVbwBZGies2sMahFivsd3gKxBqSG56hUlOKZfiwc1bY5CMxG?=
 =?us-ascii?Q?/9fE6aY/h/sbuatHnBwzNyvc7nFL36+nbbAtD5xQ+iQ4t62nydu2/53Ni4YE?=
 =?us-ascii?Q?7W1Tpacg++qDtTZ+sAsk7ALG2ur3L49K9XxaamQ9cBscBO4cj+fdxJNf2HSf?=
 =?us-ascii?Q?9mLV5mreB1BDtLKveUgOW9qf29DbV2dfFEbiGNcBnWtNoTvKp0AWmDIYhtvY?=
 =?us-ascii?Q?fkJnVZsKZDsj1cNZ+IqHO/qtf4F1fk8yPlCdkdIVccVMYBeZG8h5ZXNGV890?=
 =?us-ascii?Q?NH5cdMOXQ7X/NlFamBFiQ/YLkowX/gZGIsvgEdAj764U3GbfXshFYsbdGCjj?=
 =?us-ascii?Q?omSbkOmuKMU8ZieVrfRSqUzmEZd12+jLI+U0mKX5pba8NmjBoM2w0U2PGh9P?=
 =?us-ascii?Q?35c0fGkdwinFZrA8m21bv/2valq9Po4vWYHdR33iMaEHJIyvWgWlVZdBJiP/?=
 =?us-ascii?Q?HuQgbXiK2x7SriAor78Y813v2e8xZuXP9SghwMXgn04qnNU31kCzk1gHaMX/?=
 =?us-ascii?Q?x5AzPbewvn3nRGabMJvyGyWUIGgZ2Ufj8OwhnLOuZ18d7irh1b0ziffvviLz?=
 =?us-ascii?Q?U3xXHqZjum5G/iv+7UzB22jsaXE4/qcH9C9ZfpwJCQJIGjABvgqqhlr4tpwy?=
 =?us-ascii?Q?hjMC3Z0ss7fL0w9D/8/zTHj30v9D59cRRz7ul7tyLbEbkgtxWJYi8YEj2oct?=
 =?us-ascii?Q?o4Bi3tzxZxw5KUjMSNtfTMCplffemHgauLlViwas9nQ9v1wF3Gnpoj+Bqpu9?=
 =?us-ascii?Q?7Q+R2vtHUwsjZghtCybjqDQCmboar5/5m9JLV14kQrs2TuWI3fqPNJZyzpdN?=
 =?us-ascii?Q?7SP5nV2cT7nZkGcu3SavUZmAdTOzKJOArGISHQO8qrRXvVRyT6XsW4q/bdw8?=
 =?us-ascii?Q?KToS6I8+8V8k42nNpHh4MT6RvsB/p2DXgM/j4L1OiqsScEe9e4EnX9LxmSo2?=
 =?us-ascii?Q?BkInp+JHJqiCQx66D5aoX1NEGeoTYWfrJuv5iB/n2OCam3Grndv8IwSetKFB?=
 =?us-ascii?Q?bI/KT3H+AhQTraAQOwIBPoUGleN7NVaaK9MI8oA0hYySgFUpXT/gBSMRqqsC?=
 =?us-ascii?Q?vFxiuZpYdVVD52S8gPKNImGipY+Ce7dF2GpXhz+tPHJEwnsotLSA3E8daoqq?=
 =?us-ascii?Q?gEQ4/HhEV79Ly4aEEVR/LQFbscoSK0q4ovvEHt9Gy74NKe2PPScHSsCCJhEH?=
 =?us-ascii?Q?WdrygfaCwiJra6NP1eNGEauyEojKuD6XFJP3vMg6IvsgN6yY/R2svzaybJr6?=
 =?us-ascii?Q?+1YV6jcCDHooAMceM5UBhNog/WofqGB9Xy9vduMRjjkKy44e9UgIDByotNum?=
 =?us-ascii?Q?s/iWWpPIQa0skotYkKxq1QUF62lGgvmbCoVtQPGrKKeqWSqYwJYY2DCw4xeY?=
 =?us-ascii?Q?ka5QyqV1x+zx7Yy7wZYd5NAVuXtHvv1vNJ3NZAICvjimcDFk5BvV0r5GC2uC?=
 =?us-ascii?Q?s+1OBpSyvqO1ySfBRTpkHorE04cH4iIy0+vbUj/apSbR/FszjRz2M16yLB+t?=
 =?us-ascii?Q?h4rs6MsFuUOZCwg6NrYoGcWnghzHa3Yxd/SqriIHF7bdif1bNt/lDzU1/5nd?=
 =?us-ascii?Q?0jdCyshpgJQMbe6dqBFsEMnZc9zKhbiohXL/DF64ykZpeXT3TvMp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd4cc52-6b7d-45be-f810-08df0e5e5167
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:37:16.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A2Xa+LBXI7SKRjE7uUqaar6ckcPO147nOZYC8M+ZSyByj01/HxCSRJM10E30gZt/CHwFgxO7yPeU8N0yYY5t8M4DcloUlKyx9NXhxEZr8jAR6weUm+DY3YUfsLEjJmp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB617387

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
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 24 +++++++++++++
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  4 +++
 .../freescale/enetc/enetc_pf_common.c         | 34 +++++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  2 ++
 5 files changed, 65 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 24c1fd869c2c..71c971618388 100644
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
index 1a9fa3714c3c..1f92d16d8ca8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -13,6 +13,7 @@ enum enetc_vf_flags {
 	ENETC_VF_FLAG_TRUSTED		= BIT(1),
 	ENETC_VF_FLAG_UC_PROMISC	= BIT(2),
 	ENETC_VF_FLAG_MC_PROMISC	= BIT(3),
+	ENETC_VF_FLAG_SPOOFCHK		= BIT(4),
 };
 
 struct enetc_vf_state {
@@ -20,6 +21,9 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 	/* Number of consecutive failures to send PF-to-VF messages */
 	int msg_fail_cnt;
+	u8 tpid; /* SI-based VLAN TPID (0: 0x8100, 1: 0x88a8) */
+	u8 qos; /* SI-based VLAN QOS (priority) bits */
+	u16 vid; /* SI-based VLAN ID */
 };
 
 struct enetc_port_caps {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 86958f1e9cd3..8206884294a4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -682,5 +682,39 @@ int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
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
+	/* ENETC v4 has not support spoofchk yet */
+	if (is_enetc_rev1(priv->si))
+		ivi->spoofchk = !!(vf_state->flags & ENETC_VF_FLAG_SPOOFCHK);
+
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
index 7d7e67a12278..c9eed879d5a3 100644
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

