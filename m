Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597A419FBE;
	Fri,  2 Oct 2026 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969437; cv=fail; b=tnuCbbxwN+pQEW6H8VYSennJzE8D9jAiGkOCNdzfRhS1rGd8lYABjpQVSqcwpxagWWYqK2DN3xHAvcIHGi7uiukhgKNbseMEwCVfMXuYJjePS7o6zeYCLtdGjXWgnoWNQf39TKVyH8sZqD3nEZmRwNa4/eFHmVYqNXgdzWfckP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969437; c=relaxed/simple;
	bh=r2JNlxOKP/5WEzU+jG06pNihJs04FVQrdMV+ugAYWXI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ShPF8DatWLpQU2sOXN2tKJgPnXjpOTrt3TUztam5ZrWO6m0LaxLTA8ZVdyWY+uQkBtfW2TbvPJzN7MpwZOvi62hFko10BmjkQfyPeuMKFM+dLTS9GvOTSBwdnhvJhYdLaJl6S9C9NMSMKFPoFcQjz3IJoUZiqLzQ04kYT0P4sM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hPYqW40d; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hPYqW40d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ojjnigc3YE6kSYxKGYY3f4SA3ArGbHKjDFsCdfR8cvVKLwpOLQUo6gycjHHlRTy4M7dr6rbYa0J3DObMXQwn1qJ11hDdBGXY0/abfqEVfyMglC69FRXx8jl6HGgPo5UR2Ee9Ie4WQJLpdcGCcw4I4SZgHCd7HIQH+0z3iElhUi4M6Vmkc9ea0yVjDEE5g7QW4lPWGn/7t99jbSqvibkkgG6iN65jsGKsapZYWUQrDF2myCWOUUt6KSHU95LjGjmVNN3uZyaSWnzIyd63WP3k6Ck+C+vi6hXQkfcUPkr5MTQFR8K4Nc1TCfPZnyjYfxIXozrAk3RNeKzoS60QcNu7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt4+epuybLE2pXnr+nTLZKI2lp3vePE88/sCXLXVG2M=;
 b=SuIeKKKS2EFtguZ+0B5by9iwRDgAWMiFU1XQyMpFQNN+bpIMnePjJg0UOW3Pobhogfd4NHP1kf8yQBX1TjLihTcT1ZCyT6yeN6rwJuVG3kRysgQJRIvVP92iJsmUPP4jwZvmTGvX4XjoYFbcU9dvkJtbBHDGpxNfbvpIY4gpiMOMgBeTLW8PfIr7fuSeT/kamptVe6UtwEu/zEGeQ0GetmxYaVUnI6rISSZkopFWKDP5fxJW5fUsIw1lvitMVXXzfZDRjYDIleqTAY/UYV4byh9QRoF1gayCkGE4YPrJPMtyf7DSKHB66oP66qoN3IbGpRqvd4okcyB8r7Ci+V2BDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt4+epuybLE2pXnr+nTLZKI2lp3vePE88/sCXLXVG2M=;
 b=hPYqW40dINP+zYjpc+Bi+gjpVlQ4+k9i5kMoMXj/DrAozrdtyffrnW9XUnwFUK8tfYllUR/PpAlPePufJsLXfWrgXvnsxRek8Q66qQugSlMKXtXdX3OcRUIJcjsPsIJJ8ZlNNR5vbJd1Qy2I/WOFSEklkSAv+Vpecxvxolz+W0rGP3eO3hsXSK7tMGmhssfnHLeG+PAfqz+RTxaPZ3pdUWlirB/slJ3yQplDryw2xPamJ7R3RSFks0VYAIRgmmI6q6vRs74I85vVCDopMx96Jo9ZnccNygQsbJotblwFkRtgKCYNrDbjTskl393OZFbFHMUvqIPG5ztcxbftUcxGcg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by DBAPR04MB7447.eurprd04.prod.outlook.com (2603:10a6:10:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 19:30:30 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 19:30:30 +0000
From: Frank.Li@oss.nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank Li <Frank.Li@nxp.com>,
	Yicong Hui <yiconghui@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: vkoul@kernel.org,
	imx@lists.linux.dev
Subject: [PATCH 1/1] net: ethernet: micrel: ks8842: use dmaengine_submit() instead of ->tx_submit()
Date: Fri,  2 Oct 2026 15:30:19 -0400
Message-ID: <20261002193022.168248-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0081.namprd07.prod.outlook.com
 (2603:10b6:510:f::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|DBAPR04MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 73619144-02b1-4040-56cd-08df20bb9e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	SJt7DFwBIJseL3Mw8tG8auJETrjKuk9Y8UtS+vSxgqQWeVbnQn+Tg0yekEKBAyuJujqnQpo+znApbH/LYYUw2ZNurkVcScfdFpzAkAU9dQNMY8zN6wq6Z3bOBUogg1wrPH2ZQSuoIJwOvt4PiZR06/icOOFJP60g5fg/o/IPP8x2TUq5n/aoqxhkmpRWaMCB2CFhmrKZh4poRHk7voLevo7+U19xJhfwZ4S7b3HWrRUIdGpGcCXHuCdVEgxIDCzTUMCUmS9rqoC6kCtzB9GUPAfEBfRZ9xLL5UEgVzyxcHL+lXaH3NjdkpCZKil1A9F0tM0lpVnO62juJVRy9PSdKbyXgAZCN9KnpWbqzJe4XPfNnCnz6aLXsA/X2R4q8rIUw2jC5SQm+8cwYxf1AUOSNEOvRvTrI+MIv/75op+rjGll7Dh8ogZ4Val+Yu8qsdfP6m1ngw1cJDT8D32j67WXDKlP2WQmeCKY+Jf8weYtj+TFToml9LCvlLtx/w7Xh2ucctZI8m086rymIsmv/v3jt/6r2sQIPr1EawcznYF52iCiKJQfcFwSiPvXwWTivyJWs+/Yce5mKn053x3uAgiMsvVaz6cv6aBlTR5G0mkNZFtjJeb7ovZ3ljiRDcezXV10nwg/KyNqsOEmFwtJN1Akz1ZdXm00GWZ2WAfsCAkQSrs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z3LPGDPLqGVdxDGtEB7DDkiX+pphEqhJB1CZVGpugxatbCP5hZ0AdQe1/a/K?=
 =?us-ascii?Q?8fG4CqYzSiau6mB1QBCNDnwJTPDa6Fl/lVYtGHBQ0aJlPn1k1x7vt2OdBu1e?=
 =?us-ascii?Q?tyy4EVmG0ki+E5B3SF0Nss88RK/gaRPxhEU2s6F0toQFQ4Lx5+QwrRZDs0hd?=
 =?us-ascii?Q?bFc4lWnZyuKnC0J888SiUxLAwWJZ4XPlbeRJE5qPj8uuGi7ZzJnVC8yIt6w0?=
 =?us-ascii?Q?Qe00cFCLSOJre2lzNuE3zdWhj3k57X+Wp5Zp3wYMhsHTmY0quEZ7/5J+PHW1?=
 =?us-ascii?Q?XyLqAQKrBTrarpkqF2zN+LFWPNsJmiaM9F1httYLhgaR3okHROQn7Sf6CNgs?=
 =?us-ascii?Q?ThfrNu6CkqfVAOnxZMK1PmynpsU6h493x1wtTRNVOvIQ+s4GJKKY0vr3RScC?=
 =?us-ascii?Q?qIR0mWWrBR+HrMmiO8QCkqQSkFwHo20qQliOiHFImW8XyZWF+CDq/UMq3WXG?=
 =?us-ascii?Q?B0pe5vH8+VBOEDO2vQOzG40su7pfIjKZzU2nhvbdc0i1rqUMxa9RCqOrzPdY?=
 =?us-ascii?Q?Ni6l3kPlXQ/WmSvSYPmVjFXN/79lww2wqlKXA99OgEmPnHhRv280W4RJA3k6?=
 =?us-ascii?Q?gwaQyCcXpfvwO4MTEH9PYUA+CjL3W5JRqArTtClD91klVPmL7u0SP2yRftXS?=
 =?us-ascii?Q?5hVAd511rzS9T7o/8/D8ssu1YdoqTheDQjZAckPoHc0GPnmRnQnfjJY+5Q9n?=
 =?us-ascii?Q?mt7dEuIXnDF+mW/pFpCuvWUL8Gv9q4ixhbDGy0ZlR/b8VPuR5mfJxy9F7pRB?=
 =?us-ascii?Q?yePtXBAqqsGHJoFFY4foiIy/XoprsDsZ+6Am0xIZExejvZJZFAv/LZzMqJqb?=
 =?us-ascii?Q?1XOOjqZdqOIyyZPfdvAqZ/VUrSusWXfoWVOVoL+GRIX3gwVNTJyU8hgY1gUm?=
 =?us-ascii?Q?gFz5otdMiI5FR1i2kwttnPwFbJYZwpSAA2kz/c1mYInrs8M3DZT8nMl+Mpe2?=
 =?us-ascii?Q?qTGC0IT2r4hGDrDSGnJwi3UOPDeDbhub4VcDhxQSZISONaT0MDSkOBOYvqwR?=
 =?us-ascii?Q?jeyHkKWvivjTb/ZLMP4/2rCKrRpRbKYvSKgJuoZt2wuvKUJgGPwCFbZXIonk?=
 =?us-ascii?Q?0QRGZ6mZujRYcisD4hvXjbvJbPCznkaSBC9/RTYDNUyYSUlNUxbXhha13OBz?=
 =?us-ascii?Q?HCpn2rgF7K2G6K8c5kjNixE+8oA1u3TFqu17ofOxENq++rbJYcNyn1npj4xF?=
 =?us-ascii?Q?bJD5t7dXMwtFaL5bpDYX8mq4lpRaaQr6kosB8shh/SzEkEF3bEq5revnuNFh?=
 =?us-ascii?Q?yeVO2psXgYCADD0Ct+Hylv8Rhu+pMxSrRhfcr+D6slQJCXWTNs7J7/plryib?=
 =?us-ascii?Q?c4ud52GmubyHup7lct5PXFnzCD7xA24F29qUgLKlUg7gyHQnNqNqr5xGKbbG?=
 =?us-ascii?Q?/u62wYvj11Ae2Imy87Hqf5F1rv3I8+tWsGB9RhGyseZ5eMK8Sx0gJwA55uUn?=
 =?us-ascii?Q?EdrwUDYpxNuD8kspxOgNw2wlUSzEKw1MCEIBE+NSdUU//OR4Z+5aS/t1GAO3?=
 =?us-ascii?Q?SWRb11PotEwn8amvLzYphr6UiyMpLYo24vbxCUZoUwFDk0pJ7zne3vGfS/JW?=
 =?us-ascii?Q?QaZSI411LF4B5qA0mHxKgPknG9qTeiQIPFO+CiY2zEDe/JN6wBHmSepG5yNH?=
 =?us-ascii?Q?bFfw//HQhBIndWtaJSMWKr1aiY2cgic6P7MhISBAS6zlboHQHj+v+WP1ERCv?=
 =?us-ascii?Q?uqqK++l6R2WRb8RpVNf0mhp3I4XUxJhwMxlK1WFCY+j6kN6bwbgdWw/Rc9n4?=
 =?us-ascii?Q?9mCXsMMyHRRfN/JwYx5YUjSJyWCdoA7ne1DiCz4+Ze4zZx0SiHJG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73619144-02b1-4040-56cd-08df20bb9e22
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:30:30.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLXgldHw9Zv5s6Dz9rlPE/jk5OGUEwMLphqH+XTZRC5/Xs2vCsyd3I+sH3OdOx2/QMNf8msMANZBApD6T+0TIuOodo/zpi1RJaNi58kJJEKRS2R66CPja21weQ8GoSCh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7447

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_async_tx_descriptor->tx_submit() calls with the
proper dmaengine_submit() API wrapper.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/micrel/ks8842.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index b7cf2ee9115fd..f0d6bfc6025ca 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -455,7 +455,7 @@ static int ks8842_tx_frame_dma(struct sk_buff *skb, struct net_device *netdev)
 
 	ctl->adesc->callback_param = netdev;
 	ctl->adesc->callback = ks8842_dma_tx_cb;
-	ctl->adesc->tx_submit(ctl->adesc);
+	dmaengine_submit(ctl->adesc);
 
 	netdev->stats.tx_bytes += skb->len;
 
@@ -569,7 +569,7 @@ static int __ks8842_start_new_rx_dma(struct net_device *netdev)
 
 		ctl->adesc->callback_param = netdev;
 		ctl->adesc->callback = ks8842_dma_rx_cb;
-		ctl->adesc->tx_submit(ctl->adesc);
+		dmaengine_submit(ctl->adesc);
 	} else {
 		err = -ENOMEM;
 		sg_dma_address(sg) = 0;
-- 
2.43.0

