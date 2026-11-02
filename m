Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793590975;
	b=yx5VTtUsbozSCzXRLnjaN4vAgWXtSbXuZaeP2b9ui8NKreKPuC7zAZVq8CSBhCoyuGMB
	 nC0RTMN7ec8ubctxOXSFieWHPcuNKdGIZH9HuxfBh6lTJXCcxku6kndjiTIOjpgtHO1qI
	 qy0jqdcbFpFv9VLgyICBUvX22pHEC+mgfcNYqkwhqB/E/1DtUvTVYmfXYipspeDLK5+1h
	 2rfND2h/DLLuz0JowJ3HlCo6p4KL5EuONw/0yHYrxxQ13/REiyQgVdrBOob1Ut8YEmYZA
	 dxQTYqnm+QLmOkoahvlj+OoUVEy3CcsEjxbZQayuUBkL9jo875Ba1OTy+0ZC7yE+5gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793590975;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=89RLjfcNgJXHkKyQ8aL5ek6XlXWmD/0WJAEcY8XL2bg=;
	b=MH+DmU0F9Sznwqg3cWeJ3xFBqemOKdkaTjV6roewYfcXjtVCIY3GP9hwEPNJkpZvvG8R
	 K2/CPTjz00sSSgiSmp7fosaTozRb1cBINZTTtnstW6fRL0bLN3IbbTg6ko2zJgEFCSxwq
	 zSL8+7YBDYILSlPH8q8nUSiQS92LXvV/Q+lQIbhRmlxYXGYNO07yci6dOnaMVR88ohsQL
	 Rrw8PGTrF+6xwC3V4PQkjkrg9B9mqg5Lwi8853RMyooIaz3mwBfi8rJm4FBMBf3qg2fv8
	 rk4ov3KAtvEy9oWH+HsFsrubJ4HDKr1vLH79XqOf5MMcWY30Rij5Z5hNSsPQv7D9obg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=GggBQICu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.33
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC518606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC518606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=GggBQICu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe7l8yUm/zOW6MMlnC/R0j03lBdXoqOp4gLk2JZCZFmaa64amY4RjKl2azNaLvs8x52JnqaozE92fycJidFbeXiFq/56cznx1MTZuiUCz3UKv/KDtaR8kuz7hfKQ8J3zImtvvsg/rtaRuC5MWBgTgMBmdAYylKkJF0XePfP9RM7thlxMZAzlFjermvTRCgA0g0wV76O0EJnC4tuAsRuavpKYAgVuC1hEIIr0cPCP3YU5lFvauJ7mCfcSIVvRHk1ELG49rMdyyy61gkvRxMpCiErxaCRqrr/XSo/5JqvpVdE6J4DS55AR09QWYnsTL02trn3FYsKsTCHuXOzDf9XPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89RLjfcNgJXHkKyQ8aL5ek6XlXWmD/0WJAEcY8XL2bg=;
 b=UVNSgqDSN1feFV1CHU8AHmSCZtHyUf27stdgzuemDoWFigycTGaiXa4rFBRXl8Od6bp6R7T92tk5dZ9nNjdAT0ff3Q8e8cENmuoG4Nwns+e+IwHmpMvD+eWY3MR1Y2qSHR6QFPmqlBboCBtTuPkruM+TX7IkHeIuV+b2A1Z5ISP828wh0m4q7lig2VzYk37CpRgPChpgx7+6bZc2FqG9m+op626WdGCx7dG0aoD96Wblzwkd3fy4ZSFjd6JsNPf5yrb/Qn3IzSLzCS3oeHG+XSMNE1GKvOLDZAlWczYioISZuCAid3Xz1LdFruEKydtJ2xfY2XHktCPMQvebKHd+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89RLjfcNgJXHkKyQ8aL5ek6XlXWmD/0WJAEcY8XL2bg=;
 b=GggBQICuNdlSBbNeu8fOTV9Am5uv6dRWHUyfb3feC6UBDtC8oEfQOk42YwQ1reWmtNIWOeW/lIo6QXFChB6cR2NML7FjqFwF2XTO0kauKlVVCKeDe9KZDArE67ME/IVi3JjqQiDUmPpW/MlzXVO1lkxood74rdT1h8YPRjV2X27vDBuFs5tMeuXctYzqB4mO3HfFrhCUTC9FcRjWnz7Acwd2smUyvkP63Smx6SLyw3OChpA259Lk3U3TXahrGU4lPDprCt7z37TBCB5Rr+11idCWIYOu89YJ8gThm6em8SUo4ltet9ngtNYCm/LfeYqGKewSly0S9MdJqNV/39rekg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by GV2P189MB2909.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:267::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:42:49 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:42:49 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH net v2 1/6] tipc: fix memory leak in tipc_node_xmit()
Date: Mon,  2 Nov 2026 10:40:27 +0700
Message-ID: <20261102034207.10639-2-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
References: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::19) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::23)
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|GV2P189MB2909:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e85fa1-b9cf-4569-585c-08df38935dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261021123027099003|261021121427099003|261022075727099003|261026121527099003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uRpXaeS796o4aVPUU2L+pVOzbVAWx3y1DTmJIcCThpgkhtME45RabXLkbxuF7pPPF5E/o5QYJWYWgPjJZGZ6gGw6wsaDnNSB9nLpZ+bMSASq+yt1oJIy80jeLev3S0yJSkegMAT/lzlJvcppWkBKtK7epIXtZW5L8p3aUDeJvfgCVeePUF3RIRHANCoh6eIR6lUK0++SBpBBObw08xlSBO5MXu7UKYNH27gXudRwlPIawkm/luVJITQXKWo+VWEm86b9rEuo4VarpiiI3zAkbIcSV3N+Fn1Vzug9LREx2a8wdSlgjeXWCRyiTqgWctwpDjKXu+BbKGI+OOgxCyZpW7dQOzYGrR5YepRLZCVm8He8ocXkcWzNV+BaWhH2Aef5pkKQnNLHTz62criQPjEKO1U56wAZkYSfHZ3+hbSHwZ8k/N1lakqa3ZsRLhBxRE+Z4Ude2tDyIwsbtXjHQ6J4/pmmtbRWKnBnPyyNee1idkwA7IrBVeuo4o6BkpoE58gWVW3x1Ntu0e6o3IKweNpELPUWos9CMZDEJmeLRIP2eeWe6G31Y53VsPQoDrAfCXXbilYP40FDzvweL1on4cEq+ZmPT/35qyt3q6d0E/KszqvQtiJE1KHpu4INH6UjrY2qtHv6YPdnw4wxRQtKnrdsrtwYHvovYvS6aP7tmNh6YYc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261022075727099003)(261026121527099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mRXSk8HYKvpnLChkRIyLyTzBAdP7OPT8SpsIaD90pAhJCKqaD+2qgld/ebwm?=
 =?us-ascii?Q?CY5cI8DmqrlDMwiOGlf98y1SviEJ0DXB2MWqlqZ+rP9/9WJVdwspTaYMkVkC?=
 =?us-ascii?Q?n7j3wW666yxQ4vjuCsu+jJ6RPundIB2uzbrfDo+Wd27Zk03oS8/pqkzb2Rcl?=
 =?us-ascii?Q?+x69Jhf0lWW6rEeMv1YlAYp9ShOAnYd4VXPyH5Ya2VvfhOI3Xia2EhUb7VpG?=
 =?us-ascii?Q?5NDvvXL32pHh6YY3vX9oNTxqZp5Y6xAvesXtwveA0SK5qP9+LLwAkb09RFme?=
 =?us-ascii?Q?/fwoYq7omQFDi18+4gMTYzOtWbnWcXILFkOA+WVVJISishpd5UNlRkLcisw/?=
 =?us-ascii?Q?a2+k29QR1v7IL/27LnqjfzRq/CJQUofl45ICZJNmfF6k4u2JbSsWbmmn3LLK?=
 =?us-ascii?Q?XQz6xYrl9if5zRfTEsRPc0ExuSCnFywON1X8xYno6B2kxWkK7+h8ys7ML/cl?=
 =?us-ascii?Q?Cg5BJkpmkZGIQeHbnLprBSvg6q9qhR56hznXREpI6IGVmufpDiU+71FC9IE1?=
 =?us-ascii?Q?NgA0JMXKO/gDW51IAYyIkiCy+eOXOmd8ARk+F6PJyoR922cESQ+qxsxzoQyS?=
 =?us-ascii?Q?cX8Wjcj+g4bOTLgQcW7Ngvb9Zxzq2l1bphguMj+hYA3zw2XWYoOQInrhlvTZ?=
 =?us-ascii?Q?0JqwFDwDz91DyqxbwDfdVf220dbnAfbQoJpFuF++N4wLUfCscORtbE8b3CBN?=
 =?us-ascii?Q?RmlGjpOa5ckm5mzDHt818FbwP49M7HPoYrgwgnV044zEl/YS7KLmQUr998Sj?=
 =?us-ascii?Q?ZCkD0LveP2/6LD55CL4kmA/6T8x++8SsFFmLgF8v2YmJEfX7XZgO4rTRcE+v?=
 =?us-ascii?Q?MYcj2ORbOHfRCOi7XtpJYGjXNpLLf6VAsNZlelayMG39cvHOlGgS58s4aCb7?=
 =?us-ascii?Q?GHK4xMRNbK6fuwJO0xvlMGavpwRtPmamGe7gWWFOXHh1n8Veq7ezTP8SX0F/?=
 =?us-ascii?Q?s8oJ5o571McMHluQizU2d9wgqOV1gBr98WM4i5kCp/nM4N+it4dj3s/mic/f?=
 =?us-ascii?Q?EC7sKOnVvD4+SDQUw1/pU1PTZbxpNZu3aTcvZD7gqwJVi4ceZI2fhSwYmlml?=
 =?us-ascii?Q?DUGu7Rluq19KWxiRDDl2mqyE0nlLOAqkiuqE7VUyhvoKe2qgAN9pnrt3MdFs?=
 =?us-ascii?Q?E87SyZoSm+rSuYB7ay97BchPmOiJDyJdouBY4G5J8gRUZ7gUWFKyIc5qJ9n1?=
 =?us-ascii?Q?wVUOZoxLwjd/QBQSMG6YsaVg8X7pPmDrAqFGuMVc9NDbUYUWgu3zda8FhmV7?=
 =?us-ascii?Q?+Zj4iTvRBimEkBSAvN6SEYwQIzcuaxjEhAU0pneJpPKVzBSHWMNFgTifLvLS?=
 =?us-ascii?Q?5A9ySSTiDL+WaWaBU7Xx2kRarRCBrOGQuak2/t55Gau5q0fYZlwA0WPuj3SI?=
 =?us-ascii?Q?meQ1mTodX1v6B4149HaEFepuxbyeyB7OPXOhx44RtLEGKz4KrD3gYKzZBDtb?=
 =?us-ascii?Q?0tFQkSxUZ15QVvBMYr4OV+cRkIMDPorUQJLrQDNWhJP3nMuQdMDuZoXuf/5o?=
 =?us-ascii?Q?X/qJZxu1F9ON5jDteujotnD3vsejzSCwMZ43BX2rhfxEIXZg32vdc0xC6FmI?=
 =?us-ascii?Q?lFDZSpyN7rQPEW8F81cZ3LAm2k9JvxfreXK0FI6PAMgq8xftEtNYERv1XL6A?=
 =?us-ascii?Q?VwmbB3i5UrOy7VOfAui3H3I3W4VOQHvm+fHN59A03GDJXe9j5E9206O/+sQ4?=
 =?us-ascii?Q?jsrzqsTL6jd02DNkQFkqSN+gYcpvSDfRpYhsXtHJUVfFNaJDJmyZy/y3mSOF?=
 =?us-ascii?Q?6uvAMmI1bBDyKGBKpcuu7TBjn8U0qVXqgAxcfrcPpBuH6HMJ0lbyAcG1IPhY?=
X-MS-Exchange-AntiSpam-MessageData-1: eyiPznTZcKIPX3kdUasQcmFNovKfRGYIcu4=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e85fa1-b9cf-4569-585c-08df38935dae
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:42:49.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IV0WrSwI1x55WikXD/X6/fhuHD9dtXZiYoYlkYh6CEkjaYvAIXCkf++cVpRcV0gWct4TgMsKWwGh3jxOv5Qh6DGIy7J1GJmtMx/VHxwIdW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2909

The following memory leak can occur, as identified during code inspection:

tipc_node_xmit()
 tipc_link_xmit(le->link, list, &xmitq)
  ...
  __skb_queue_purge(list);
  return -ENOBUFS;

tipc_link_xmit() purges list but does not purge xmitq. tipc_node_xmit() does not
purge xmitq either, resulting in a memory leak.

Fix this issue by purging xmitq in tipc_node_xmit() when tipc_link_xmit()
returns -ENOBUFS.

Fixes: 4952cd3e7b47 ("tipc: refactor node xmit and fix memory leaks")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/node.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 53b0993c2c23..d84b0274fefc 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1747,10 +1747,13 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 	spin_unlock_bh(&le->lock);
 	tipc_node_read_unlock(n);
 
-	if (unlikely(rc == -ENOBUFS))
+	if (unlikely(rc == -ENOBUFS)) {
+		if (!skb_queue_empty(&xmitq))
+			__skb_queue_purge(&xmitq);
 		tipc_node_link_down(n, bearer_id, false);
-	else
+	} else {
 		tipc_bearer_xmit(net, bearer_id, &xmitq, &le->maddr, n);
+	}
 
 	tipc_node_put(n);
 
-- 
2.53.0

