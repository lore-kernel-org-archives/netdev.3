Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682832143D;
	Wed, 12 Aug 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565489; cv=fail; b=Go2oh/fVwtyYasXok3thVAd97w2C0N4z3AMl3m/NDly9L21h712dWXlR3vBz6qxNhlGJLT/wnhOiWPO6y/0l7ry1ujf+nr8pSbGEciMBmHXohUgROzess0DFM5T3wIMFVFinqFABgiNnC/dBtHNTkw3qAPg5Tm3ji4sXfNhRUgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565489; c=relaxed/simple;
	bh=lfOOaLMIs7jVgzOH07n0CKAzoj3HM/5wdeIWLfwu6iM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=revUaBUWiPmqfqNIQZWLWFCgzh6YC+MZb+mGjjKE2dck3Xf+iGOZnfrg8mDmnL2/J8tTj7xtTONmfV7rBMnWrsa7WqkIPoMXGx7l6yGUtzAeq2w9fi4DFoLAqcTcgPvgVeF919raTAKovhj9wZsUxuhtajL1q76qCuv5MudZFkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WifV8e4E; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WifV8e4E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsFR/r+Fwk3LpF7aqUEDMXkUXi7q2jGhBAs64V/B47xoxBEGPnEG9lk/AsjNuhgmOrsOZB1opE1rX5RhFobA8fKvTWJwY6VlsTJkdMs+O6HEcXucWe9yy5qzTiR4KtA8fjUYGVCA/3FQdR+uK/qqF9q3MVdSn6NGnRrjuV0Ul1B/n9crgGAp4haIEk+G1uxwgj0SdF9wkzckajGcPWwavs4Xuf8upN2Kj+D8rvj5Qmr6mXx3/OtHqrGlw6WMxz0IpJdU1Z5TSbwLAs91n1AOFkU5Q4BUXmYixGIIPdH1RT8L6UpyewlbCrSVKDVaOF6W8pI6/ZQOT5kFxhK/x4xwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uR9uy5A4p9gXX9WFnVJji5gK7GR6pPNxGhsl/DRolE=;
 b=a938XLVCJnB28Ac0KVCHz3bGGWNEyd2QlcemWXGDGc9WsAOZpcOSXsYQ8JaaWaE0kJVCVw47NNTBuTtwa3Jag9wN+kf0fzu4K5up1BKr62A/va4rzsqNkob+JxmpR3CaXyK7PjgEquI+7ix+LHUVmcWSdzipEhlwhXKIeA3DjnXXyzwUG8ZnUnIQf8+2ldisj23YkAcntYv2r0zWfcJRpV9gh0t+3RRdC7IB5xZVWte1VDC8husa3kUP7G5MOgwg7fC5dCbE5Vc6RnE5IeTpgiBctzAIAGSSIHpPtcsQCzkUiEwt4ukQrya/BN60C+j3lgMt5C4g/viCz1HiSPA0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uR9uy5A4p9gXX9WFnVJji5gK7GR6pPNxGhsl/DRolE=;
 b=WifV8e4E/vr55IKcBog2KAb5RF9zGCu/kgMYONBVzCfMVxNs8RB2+eOrpHy0HgJGTzbNKmtvxI59oF+GMF5eKZSg0+Zve4acHE11mKE5zHCliHj9mqVT6b5HbiVWGjbsXDFnEDuWhZramM0coHh0ZZ/pFe8uJGVdL+e3Eroc4qCsOxQHXtdrV/XqaXCknpteSY4yHwseocVz1a44s/grVMHbkDVbLr5TVvprzpf75h30xHctRKcqHit/70UF+Xl21rOTdbYzd5sAJssFFxHhH2EyoCWKl9kdh/d9sOf4pTvgWIOIJjmKS0OMFkgC8qcrlWk4AUAeckr72FGDFvUnYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PAXPR04MB8159.eurprd04.prod.outlook.com (2603:10a6:102:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 20:11:24 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 20:11:24 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: b53: fix error propagation from b53_fdb_dump()
Date: Wed, 12 Aug 2026 23:11:21 +0300
Message-ID: <20260812201121.2012356-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PAXPR04MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 297e865f-99f4-4420-646b-08def8ade246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EUnYXAng+kh12/WGPu/j5185N0CBak3TSc9Azx/YPGBomiqDdVPqYVNEbLiYUdZGUQrzOPzp0pRa8hGsaUEFPiLqkleqqb4VwbgrYIOyjcVOxnV92AkDLHz/Ce63jVZNVrnoZtP/OJs45t3Z4jBd0+COOZ+zqtBG0ODw0Fva71TnbD6bIlhEiYSDkdT1ngRtJZ2bZ/VwcwbcsVAMdj3Ibfj307tFt+XWx3dFRFHi8SdyLOxYHyvCHuPQgvDd1N8ie8XvQk1B1oniatVyvJFQntBkqk43k/khGuttCw3kqImLJFy0GRURxX7gmAx135BvTty2AXnegbUpopa9y7upOxhk8glDoEmLTJIJssHk/6hjRSgPbTRlu2RWiVbi0Or2xjajR4qP75yMH/+OkKrObkfSNNardVTZh0/GLDG9sFjJudY+nwg56S2eI74qWJ5JYCQvuzqeuw5PtA/anxZwM0rwZNIHa17NnPVXXX7KUNvyjK01VWdQ60htS4J1JvbCxVCEmMDs4gt6e5bqTxD393KHEfyN0lMNJ6D7XD1lTHZlop+Jx6SXPxVMiTa0CuWmm0fz7/JjnBJX8yUrVoUSlQEGVCI6P2wii8X4nBza65T5Fv26j7vO1xB+WTntWi+IQEd+m81JaBq0RhCuZ2zIFXMwIIF4ePpW9oHOvQ4qwDI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1Wqr/T6baLOdXa/WXmg1caBi/2eBxaDiScqETrQosrui9km3aqhveApArcv?=
 =?us-ascii?Q?oLbFhchYUjeDPnvnaZ3giIb38PiMh/PzsUwBBxG8PmLxut71ZQz4RKSsdgA8?=
 =?us-ascii?Q?CZYb5eFvvbqdDm+UxeXER42d/+lOslTWydkjCsIp2z+RiZ3BEAjQbywM2vxl?=
 =?us-ascii?Q?BLRYKDmr2PgR48vyAC4ZrkrE+DRkhOnGtgQWxuLxoPDQCpNJ54+1sQRJumG7?=
 =?us-ascii?Q?lv2DbEI4hQZE/W6wjv+2+FWZWaIjlVlqYVOaOJctu7S6roYukv0YkIwLAis2?=
 =?us-ascii?Q?Xdsp4CN03lFG5drFbFBHtvXIMcIYQQd8dHFVRKOmOxfuC1yTpvfYMusqfj+P?=
 =?us-ascii?Q?+FDEDgrRz0My8pSrTxx4ToyzDW7echL7vbd23A2arh7FFVtHvjlr/V83pgvJ?=
 =?us-ascii?Q?x8IlAP8GKO7Wr6udo58Keb3JQED1T+Fg8gHbjlZG2+PY+Z71ylsakO6Tsg7i?=
 =?us-ascii?Q?eqCGFZNbJyobvCmao6CgXWh0YaJcOlMU/vo0stCvDTVbHmnh0/jZRqQ2xVq9?=
 =?us-ascii?Q?1zTeZO6cf6WF7/n/4Niz8as69ka4II8EFhUSX6kFVnWECQsfaiY7ku42WK9t?=
 =?us-ascii?Q?a3/ojVsqGSt3i6PbaOQIcEB26XJlqyHlhdIbkNTxjE0jFtmaXUvBN/c4crW/?=
 =?us-ascii?Q?dN2/hXcfhca6EZ7YVfUOfA9E6Kcc34lw8xu0FYqEFMX7SDxhbTdltTbY/gms?=
 =?us-ascii?Q?HsGhXjzzcfaOo8dS4eXig85s9/lE1qxL58Mg9N3u8cBI4FBML6SiVUWQsTEo?=
 =?us-ascii?Q?oPqURhHjUQpqlIfkQJ8PL/BakOmS2b7l4x/AX77TylMxZ/NQ4yVUYQLLQjnI?=
 =?us-ascii?Q?Uv2O+zyWaHeAMjgFKerHK8HVkKP1rIC0NRb3do4X+TSnZztmc5WElrOuOzgs?=
 =?us-ascii?Q?d2OwAyZ5pMXAGGpreuAzrnz62j4aX1N5fAvVL4KXKCTMia5/7FUPYjyQ0n61?=
 =?us-ascii?Q?qp9rqT4SPz0EDwOLyJoHmDDskFL3J5aCgd0NXtq/C+r81RM59PYYcsv7epKm?=
 =?us-ascii?Q?qzaXM5922/6uP2Kx5y9mlgljZdWay8jzJpfqbio/Gidz/kOSx4JctLl7L9UO?=
 =?us-ascii?Q?st7h3OckEd6xjhH8S33FbeYtaQfe/6wULM7cg6pxWPaR8me3oXEBW4XV6j2d?=
 =?us-ascii?Q?LKrkUr9nN43LNCVDLK6Ln4VXk67sYUBz1YOUkHdY4K6iJoqQ9DyyUoqO5tKk?=
 =?us-ascii?Q?zpLib5gJR5go2j9pByiWlbSQClvFQLvoiNa3nvhd3kkmFCg7gpgoTNNpsnQ2?=
 =?us-ascii?Q?KkGzbQYF96CBsXb0fq//YZM2uUAstV5Xmqfo0gLJDGH/dUNBbxljisYUSXkX?=
 =?us-ascii?Q?pJ7GVHwsezg4bLs96XyVz6QsnA/yoM/uNIN0IYWUqwNCsAga8a+pR+MVjXgf?=
 =?us-ascii?Q?YxXmvcAB7egL2/JmPy19crxCot11Y7VPURvtVBjz7yzndJOPSQXHkUtdwBpd?=
 =?us-ascii?Q?n0MIKlncIVLy3hHxm3zFmrrX6B79tCiSq60OoN4GWabMgUd14MimwWQDeDFX?=
 =?us-ascii?Q?S1AlLLIonNFou/RAm3pLz1a+c2WQhnN+6LE+p7UUaYeV0wfUA0Px31CAKJSc?=
 =?us-ascii?Q?04SPwjSazLbnj9C6IWcQ1LxeqyYPPUUC2chHCu9xlFULFomBsCNyxohkZjo3?=
 =?us-ascii?Q?C387Mp8ESV8mSV5xcrUBVjjjntcr9ZL+88cdO+jGgc0xul16KXWd3Yls/nv/?=
 =?us-ascii?Q?w2iuORlPeijO7sdqxr48d2E5yTK+0F+qRXZvwXYtxSUYNIhxyBZ/jIKLdIAA?=
 =?us-ascii?Q?SQBg05cm6w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297e865f-99f4-4420-646b-08def8ade246
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:11:24.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xemi1SzAMG3cZ0pXYURJOxlnnwD2W7o4QU6qKU4KonaNmt25CYOa4B+b1qlnL/8/YCrbhB+kBFgntfNQxOMBKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8159

The blamed commit replaced "return ret" statements in b53_fdb_dump()
with "break;" which jumps to the mutex_unlock() -> return 0 section.

This is notably problematic because it swallows errors from the
b53_fdb_copy() -> cb() path, and this will result in FDB dump truncation
when the netlink skb overflows - see commit 21b52fed928e ("net: dsa:
sja1105: fix broken backpressure in .port_fdb_dump").

Let's go back to "return ret". We don't need to preinitialize "ret" with
0, because the "do {} while" block guarantees we cannot reach the end of
the function without at least once calling b53_arl_search_wait(), which
will have initialized ret to some valid value.

Fixes: f7eb4a1c0864 ("net: dsa: b53: serialize access to the ARL table")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Compile-tested only. Noticed while reviewing other things.

 drivers/net/dsa/b53/b53_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index ba1266cd70c3..c4c8513ae486 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2274,7 +2274,7 @@ int b53_fdb_dump(struct dsa_switch *ds, int port,
 
 	mutex_unlock(&priv->arl_mutex);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(b53_fdb_dump);
 
-- 
2.43.0

