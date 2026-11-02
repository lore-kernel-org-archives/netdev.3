Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793647174;
	b=RSHF0liCeQ7TN/3bAulijy9GTYirvnARbmuTp8q75N8UrCfv3FtFPiEJOBOzWpjSMvum
	 yhefMOc05aUOvT9VZVD0aGBl3vwuO2ctijlskrDICVjdJ5owO9atJeF9yIzuoqzKWNRVw
	 ZWwFTO4/3tnd3xqvoEJ/yEIRlanSKD9QHbW2C92TXTrFxAALUQqNMJEzbIGauU50O/Ai5
	 ocx6gqUFq8wXg8PfKzX4C8cTex6mdOaeln9zY4jc6I1pDIVERRcog1GyttyvtfdhsQ9Dt
	 U2UD9QGPkW/shlS0YMSFPYoXYcY+f02EewJNS9q7odE30+aToc7A2s03kJuH2c0kHNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647174;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ljzsCKaw4zbKL2kPh3+QrpGXoL1ofryzbpG33tNn7sQ=;
	b=pamfLh/vYsVlMwQxZ8l7754XzSjElSFPZVwu19Qd5DM+RL8aNcB623JizVYUePFhBkPF
	 I/mpPTd4NCZolzUzDI/vU9K6OFwoXlDBqa0uz8hz53HYQleoZJfP0mDaBz/MJUfGFISQ0
	 PPYDE1gzn5mZm2n5I/D0IOxIOkRMkw5C/d6ns5Fsow+EefVtQ2QdUyg2N2OQ9Qj2LGtao
	 TR1YJgDRlYLbgjiwr+8w3kmjOsNXn/uhY3b5xDnpJtxK7krh1fgx4yhpTH8CRYNqU7E+/
	 8XvqT2yrJ1JonNoeUWhIiEBq7uwKf84aECzkPYlyR9Gbv0hupcsTILr5xUo36rC6LVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cnfsVjnp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.0
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA171606A333;
	Mon,  2 Nov 2026 19:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA171606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cnfsVjnp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqsqcAaucKVzbPrcMtE8hlRprS7PoBmmAp3QFRFB/Wq/YR85dEbiYV+eHewTi8mQ4FEsGJDAdEYM1ReadMTkCqiQWlXhpI93+JNgEMbRaL+cWHFoCtjIbAPbhZNKxGMFF0lwNUeOtWPj97N/Z0nhlr7ItecxpnFStkaXs2xZnt9Ai6E96nPrnOn7sfOYazQ6J2o0ZoABb/yGZ8pTw2NfY/UWddYIqky+MPinclAMQD17SGWiLMr4pft67ExmiGq0mg8BZnaB7NyDZbH9fHW3VwHFtMk5zjgnD0cKS952AMrKJBb2FWKvTYgM4Ldp9TAqvVf5SZlOZJOkarCTt1wFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljzsCKaw4zbKL2kPh3+QrpGXoL1ofryzbpG33tNn7sQ=;
 b=ljyR2uMX5eKux/6gYEP3RkzyADaqCA4tosaykhIi1hC8ixF4kIsJoQUau0yISu3HkovjliXZvliAv73BsRF+mrKZUSsiHZb9X/Uf1us7mB+GmCplIEwGVNIyuRiwiSMjdHqtH9Ij+N2WMXSiU9xq3780gBY+CjnJTf3LzpdHPlfJYqSvIQ0N39K5dueMWtL/eSs24qO2dCoXQYoOe4VOeDc4tZQyMM+xTpGJPqinyjwY87I/O9ZHnviglvi57gu40PLjj9qGz1/mRXxY9DprE7QmL1ff0HnPkOBwftF38Gp2o1IKdm7fmXseobWCqRNU3RqUlkwYSgy4RQhopExbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljzsCKaw4zbKL2kPh3+QrpGXoL1ofryzbpG33tNn7sQ=;
 b=cnfsVjnpPPlL0ybmjMkOtqwW3TgbvcF8qZuiKcgDBikw5oAZaLHf+QNM5ITEvlcK1mN8sj0fd2a67Z1bW+/wlfzOZkHmTRftLwCeJ/3XdUOqV3yU9D2C4d1JEtHKHSL1ykoH6ATiAmPVCb7MzdJ5qiA7AzrQEASq/Sh7JlR8H7eHG/qyEAc6h0+6tWSrwqo0BkCdU3FeIMEVO4AlW0qzPb4VS9raqNiPkLPVBxtb9fdm/wY2VqsXpVftrMVNZK7z/zibVY3FwK9oGzX8a26iti6FwjZUUcFMlb3vTgRTKupfucE91aR+gvd3O/rtvpvm2+0pqUuFWDFn+DlIJH4Xeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS4PR04MB9313.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:19:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:19:29 +0000
From: Frank.Li@oss.nxp.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Frank Li <Frank.Li@nxp.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Li Youhong <liyouhong@kylinos.cn>,
	Joe Damato <joe@dama.to>,
	Arnd Bergmann <arnd@arndb.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Yicong Hui <yiconghui@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC support),
	linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH] net: dma: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 14:19:16 -0500
Message-ID: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::10) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS4PR04MB9313:EE_
X-MS-Office365-Filtering-Correlation-Id: 761be485-122c-404c-6653-08df39163774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|19092799006|921020|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261021123027099003|261026121527099003|10067099003|18002099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	kExhcPpE6OvGrZf0NrZ8UUqQDAuX+P/Teu0P/EgxYAAbM2LUV52JEP3Q+yMKgAPKSgXpzJdneADliIcsXy2oPt2BsWkUAjwTdgflKhi2sdHAL4bfvFt+oEpWEFm45WqGQtBKNmAhK6HNNBLxxWTLKcO+6GweyjpQA/jLSi8YCOEQVokpqwoboJkgfgOQDlV+S2vk0EAYh7+DbW8FOQPgG4xdXTjEZLY/lHtzTK7FGuVUDxb+sC72PY0wdbWGc8a5lWRQfWdd+3KSYMpHb0ZUSbkgFtLdjglCoNTX/Hmw102punmxT6FU7fqTsVrEAeom0S8TlOnz8+00r8pt4p3ol8/0bE0Lb13QW9JYdgyrOCQAyjBX0uydKZJqG0Ic8eXngfD7+WyNI9l5w2hbQLUBLTTSDXZ62X4ZWK5dVzM2ZMH9+N+TKwfK1NC8CYVpB3XX/leRYRF4wskDvBXbNmZ4oCIFz/CkWUfa9bedeikQ4t9h/ugpXdUUn/PSx2DmWCXr4SuThPeIOv/6kOUQ6OlGrLY67AHRDPYM0vJCm6LRIRqrbLJ4pmkJ6mJCSH84q5KDKlN1iRFOZzfO0xeSl486cLIjuXCEgoXzv+jo6HFLymfTc+UTPI5xL/MhtbYWQyH8S9iIWxFjR95jF6/wxtxRnJX0vLeSnS3ZZ1mmF22GHmvf4aj1Q71DF5cOP7W3CcHiwhvL5ruWGGlRE/adWJ+4iA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(19092799006)(921020)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261021123027099003)(261026121527099003)(10067099003)(18002099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6CDIco7R8QVvNHIEE8JMpt4Rr6L/XVDRzcobquekjUd2MMfmrw7ZoMdH2x5D?=
 =?us-ascii?Q?w7FhOTXiAxQy3iVALHKj+vcOJLAQbxDfrZ+8qP49g4sPvQW+99bKk1ns0CPM?=
 =?us-ascii?Q?L66Yn6mqAdFY1Tj5bbIQ36W26POn1tG2id12FM2827Es1OnNP/2tz+txTI/R?=
 =?us-ascii?Q?wZ2ugiNgix6Usm4JVnocBKmsCymwKD/zgvNaP/+FeerPxuN732kUDYAtrerJ?=
 =?us-ascii?Q?ws0UO+GQCfEK+8UeMeKtn3DR07COGBlLmEavI1Nqoo8bTWVak8NzGZiig2A1?=
 =?us-ascii?Q?pts1vpJppzyCO1lZk41F5AXiA3hTYKq5hjrbj0JSPO7+/6o8bk+a7Y058MzX?=
 =?us-ascii?Q?kjso+BBzw1YbhwndoAlRUpVyOmkpeJENk08lNp9trgjAH9N8wa5WQyV5Qr0g?=
 =?us-ascii?Q?TWAU/9P74w6SheyT3RQyYKsD1RePVblEdaaffH/xiaBuK9qyNJZk7+lzsWp2?=
 =?us-ascii?Q?5JH9xHn2rYdDdAEzSphXN7eRYS2COtLGHsMjEEE67HXA6OEdyudLswaTaLLo?=
 =?us-ascii?Q?hgfOEmlZ8n10jgVwbYt9O/+b4yGl8Jcw21SLUvmDQo2ewgo3ARi6a6zcx/ll?=
 =?us-ascii?Q?BvUSSWeC/6RZogDmIVtTQGfHT7Bq/UhHL/zx23LttlBsWpacKPaR3qKbEyQ0?=
 =?us-ascii?Q?6Yde/pv2A5cXjCGgC3FQy6q7BPc59IqNsIVd4N44OGkGKI+fLZnxwNoqRrdj?=
 =?us-ascii?Q?hFK+sNH2RHbdU99SjbMGIHUMxfLoIPvOjWIxZX+gCyhkpomX7cQ6YVKaxs0L?=
 =?us-ascii?Q?0aj6bW9CvA00rrMJbxghj/+/EFXE+1adNc95sEPKVnHqkBQa1pzeCMnWwgov?=
 =?us-ascii?Q?v/3PhbjCp/KYoYacoXJy7XYF9/CnDWzLM0CgDpMdVSAzZZe3D/APeiVQO5g6?=
 =?us-ascii?Q?+CS+EMUoSrH47i/986P/KwFgZm3146w0+Ca5ajmuoqqTE4bi0UxQ9dkGunjt?=
 =?us-ascii?Q?8Vz/UWKyezL1AZm2FoZIjRnU2SyhG2tlaw43uX1f/aG0hHVIZ3jY1AX1brG+?=
 =?us-ascii?Q?DXonUzVR2WhvKi+I5zK4y3pc07abu5WpvRTkCTPeo7++Xmvx4hh7dfD2qP44?=
 =?us-ascii?Q?hOlGtbX47nrOXitmMgh15TffLL+Io6TcmP240qyFfBuw802jpYrnPvDyF35N?=
 =?us-ascii?Q?q4XJsw8CGm/Dg+03W82UgJvcSkYMrnKYSFNcBJ4oN0FXTQ53kNrwJYwaITmd?=
 =?us-ascii?Q?D0gdR3ZS4LFdyvr/79vgfp3HDNQi4F4QAI5EEhpNRkwkUgIgQo6EU8CXN42H?=
 =?us-ascii?Q?nA1wpaZ9JFiLDcjsGjjna5rV4WJ0CV06z4ed6NvuTLx5OP/a9V1c7FNmeVG6?=
 =?us-ascii?Q?hIwU9jUslG2s9EZlzq5UDEQwX+LAUM6I7dkyNzjR1+m5sObff4yLz+/nUcno?=
 =?us-ascii?Q?Bu97+qJWZc4Ll17JHyvsWs4HyJhZWq4FcalFsfJJkIYLUlfISARuxve9qX4I?=
 =?us-ascii?Q?KrixtaUZ+d6et6s1fneZQ2VL0XdeCQc0DcgIpDYH2ok40PmDiRhCiwRByfiZ?=
 =?us-ascii?Q?ZNmLKSbS7uYrCYpcGMyRrPDGUJ/hazjXK8ihjKaKuJqw/SVaU1bNd4pdJSi0?=
 =?us-ascii?Q?HicY4T00poK2jfCjCd9DFU1454PG4sZvJSlkiz82ERcUqZRFw+Qhp6m1bTYS?=
 =?us-ascii?Q?W7WZ/WjpsQJfOThNZ5PTWki4SsjvAMgIIH5syrQo/bJRRL+UpoISQvFWwcCT?=
 =?us-ascii?Q?tG4y9hRAbedOMzDiDzmt+p20J+FSBaXfaswevSsa0Ue+PwaoObDT9iLCIA9R?=
 =?us-ascii?Q?RQxWAmvLSn+DY8Hhr++8ynac6f4Z7sOQIR/6eIPkeslwl5D6McDR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761be485-122c-404c-6653-08df39163774
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:19:29.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR+n8HcyLc1iL8bB7NrUly9k1R8jRO5aYMwN1g8r84oo0ItWpmECeGP6NUhV1Hh8v8QIqa6M5pXYOKXjfUL/WfrYadj8Sc/HMbVXxmzgL9O/v89K8oHZUeBPrfKVrBmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9313

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across net drivers.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c       |  3 +--
 drivers/net/ethernet/micrel/ks8842.c              |  6 ++----
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |  6 ++----
 drivers/net/wwan/qcom_bam_dmux.c                  | 10 ++++------
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 09b2abdfc9e84..d7ee42b2c1976 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -303,8 +303,7 @@ static int emac_dma_inblk_32bit(struct emac_board_info *db,
 		goto prepare_err;
 	}
 
-	desc->callback_param = req;
-	desc->callback = emac_dma_done_callback;
+	dmaengine_desc_set_callback(desc, emac_dma_done_callback, NULL, req);
 
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index f0d6bfc6025ca..c68abd4643e72 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -453,8 +453,7 @@ static int ks8842_tx_frame_dma(struct sk_buff *skb, struct net_device *netdev)
 	if (!ctl->adesc)
 		return NETDEV_TX_BUSY;
 
-	ctl->adesc->callback_param = netdev;
-	ctl->adesc->callback = ks8842_dma_tx_cb;
+	dmaengine_desc_set_callback(ctl->adesc, ks8842_dma_tx_cb, NULL, netdev);
 	dmaengine_submit(ctl->adesc);
 
 	netdev->stats.tx_bytes += skb->len;
@@ -567,8 +566,7 @@ static int __ks8842_start_new_rx_dma(struct net_device *netdev)
 			goto out;
 		}
 
-		ctl->adesc->callback_param = netdev;
-		ctl->adesc->callback = ks8842_dma_rx_cb;
+		dmaengine_desc_set_callback(ctl->adesc, ks8842_dma_rx_cb, NULL, netdev);
 		dmaengine_submit(ctl->adesc);
 	} else {
 		err = -ENOMEM;
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 8a50cad1c104f..7e83c4b5f1931 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1014,8 +1014,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 
 	skbuf_dma->skb = skb;
 	skbuf_dma->sg_len = sg_len;
-	dma_tx_desc->callback_param = lp;
-	dma_tx_desc->callback_result = axienet_dma_tx_cb;
+	dmaengine_desc_set_callback(dma_tx_desc, NULL, axienet_dma_tx_cb, lp);
 	/* Claim the ring slot only after the steps above that can fail.  The
 	 * completion callback can't run before dmaengine_submit().
 	 */
@@ -1565,8 +1564,7 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	skbuf_dma->skb = skb;
 	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
 	skbuf_dma->desc = dma_rx_desc;
-	dma_rx_desc->callback_param = lp;
-	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	dmaengine_desc_set_callback(dma_rx_desc, NULL, axienet_dma_rx_cb, lp);
 	lp->rx_ring_head++;
 	dmaengine_submit(dma_rx_desc);
 
diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
index cc6ace8d64371..1479f8362e04e 100644
--- a/drivers/net/wwan/qcom_bam_dmux.c
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -195,9 +195,8 @@ static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma)
 		return false;
 	}
 
-	desc->callback = bam_dmux_tx_callback;
-	desc->callback_param = skb_dma;
-	desc->cookie = dmaengine_submit(desc);
+	dmaengine_desc_set_callback(desc, bam_dmux_tx_callback, NULL, skb_dma);
+	dmaengine_submit(desc);
 	return true;
 }
 
@@ -477,9 +476,8 @@ static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
 		return false;
 	}
 
-	desc->callback = bam_dmux_rx_callback;
-	desc->callback_param = skb_dma;
-	desc->cookie = dmaengine_submit(desc);
+	dmaengine_desc_set_callback(desc, bam_dmux_rx_callback, NULL, skb_dma);
+	dmaengine_submit(desc);
 	return true;
 }
 
-- 
2.43.0

