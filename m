Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793591008;
	b=MSbHKPdw3Ll50vIrPGWlzApW4rRe0eURte+mC/W83RaJpv0gJK14g2rIJlGL1HusfC4O
	 yG1gVdqPVEMQGgUmZHNyBS7YQ6hwiP9/LTZX2j8Tq3wCri3NDerX25sIgKvQcPEHp4nlC
	 dnbwtcX0ALlzi7UBUJoEBnbcwBqEq7MpQh+da7YBiCncQdnkL+dHFofnelJzyBAKSI4oj
	 ixJfZftS6uvEXuOa9om9K6pii1p5cX8rM2tTxv/sZdpGH+bqtNHwFbmluvoTPAseQE0Kr
	 TZAB3+BIZLDCQBiPtg0qmiCmoELxkw4xo5PUyouE4vQWAwytEEfbS4zvVgLo7uZE7sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591008;
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
	bh=6yg6j0yPfPW6y8R/wu+pYuUURg65HBzH//flzac2LNc=;
	b=3HRhpcp+So+s0M+neJQohV3LNxj4X2jKvwrVQXLhUFBmdFD0AJVj45ZgFARNig1AMY5r
	 vmMbDHHEotfMNQzQtVwVLmzPadbO8GBcCBl938Gk/HbP2uCaEUjsnljw8cocXnz+jloi5
	 twDfOCVFCbviJ6lf5FuURtmW+sLwUyxeV8a5uwo4iO2CvOATZanXvZhUWz+ceA4grZ3jN
	 SEB79rm3jHiV/E8geiZ/MvdiEOAkQt7sirMc67bzN73Q5QxmyvoxrcXIwjtWVq2NQAtIP
	 BGO7IvXPK/jXPVBWJ/5Hl/U9cRMhPX0MuzUq0yyJUutqfE6I9sFxwTKrnQOGMtVz0nQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b="yUFK/fiW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.12
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C9606A329
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1C9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=yUFK/fiW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM/jGDFqB2w/QbXP1zKB0GvwP8aVCKHe3dKJImu3010qZb8X4nBraWwQ7kkSDVKnXaoLUsAjiibxmc7RHlOze2JRwJd6df3/m74yDUTUf2fwK4nJFVIx3Fc42vv6lORPm4HEyYnppwr3HBJQm5488Bv+/R8AQ1rQ8SbDZDBzUoBCkhkCaxL0eJWQFgshIeFfZidT9jcHN/5dYQj4FE5V3eGZiq3jKyY501zd9epWhGt95/VbDm/8m/BKr8egZ7JoeaOhIlcGRbJtm7/dMZLI5FT5e4pks9Mz1FEplN4SiXzVm95QiHl9UpkTU3MDUOGlPlOF4tT8thzjm2DT8NEvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yg6j0yPfPW6y8R/wu+pYuUURg65HBzH//flzac2LNc=;
 b=IitRyhOiRCn8kg+kO2qw6Ymfeh1IsoPTcIKlQu/if9uGPcophElamp0aFlMmeqSST55L1JD8r0AY3HEkBg5sCoekDahsL5F+C/V87KLCU0GsyYUmX0S8QnXRi8dLN5DqKMndwvnoQZEGFGVABnTorkJlhZtLyx8vG7ioo6Oo8jKFoypqGY4CQp6wZk2/uS71fPhkzbnVTaLugQLt7EPGfjjgRe0InHBg1VcWcmLlxzQZkiXK659LameHuS0tWLItPmSHLOX94f2pOhPm0mHaZwLFRBzP5aDQMiVAWPNA8tbJdxgZw9Ieji41fBKAsZjcROQTlwEAS5qQKi4IQMDnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yg6j0yPfPW6y8R/wu+pYuUURg65HBzH//flzac2LNc=;
 b=yUFK/fiWOThX6ls3FTshS7zXQHpuCkK7wD/fwRantEI/yXDwWUxjAi4IF6pdHCGWBLHCEj3wuzYdEcaXZSXavKssGgQRqgSbG3aK0IGSCphDnZey2n830D50t6LVH7mMbMgcQXdtNFpSt09IQDDkvtynFKiK+E+yDWjVjoN46ARdPbl2KuiRTnS/UOmsANBR1fok/n351a4OxMaIdnIVXcVPt7SkhJO9vMMJjqz02oMW9FRQ9iM1tffHBU2CkhwR2lbu4WGz0fSR59SBPtxit7xzYMlfjTE1H/1BzpqIfqN6mfA1rZZWVJmNhmk9bIP154OeDGI1ZA0fOlh2ii2DqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA1P189MB3491.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:43:25 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:43:25 +0000
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
Subject: [PATCH net v2 5/6] tipc: fix self-deadlock in tipc_named_node_up
Date: Mon,  2 Nov 2026 10:40:31 +0700
Message-ID: <20261102034207.10639-6-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
References: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:990:5::10) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|PA1P189MB3491:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3c4d6f-f435-4249-55bf-08df389372d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	oom0mAFCjSdZrmsWVQrsQ/NEyB6Las7vfQtwy6szfHehcgtc77Bd2zLVVAIpuBvMwi/pmYeKQ+wQKokq5TSiovS9RrqXLeC0ENJ6uVdmQY+pfRPtxR5WCvuu5TCNXnTIErnJZHecaYRKnvkJimEi6mdIQUPbOr9z/g6p7+U8H8McYSxPWs3C4LMukioDOQrs6fUxwW9F45Xud81ko2hq36GKl73T1bw8RrF1cuyKZ9QcSZMh+Xj/D4AYq/rS1shUYvCpl4ZahsbiwMbFfJWGiUNDDhyWCKpGrLYDIE1WkepbD0ke4CToy6U44rVf8eWM5YEwBg30EIR3n6utA/nxVV0iffG6ekDyUakAPafwuuQoeCyK1L6uRrYNsKL4bPHzroVv8S4dp3jjVu2y7bhY9SdkVYXjycdVAcw2eNzOa+SQTibNf3rVXBFu+0cSgcEAuOmWEPow2VLFC2UCk6k+Fx6yVMfF+vazUbWwm+aXI/N4CvtNvqaaVzIx487Pq7AEuECgIX33JAZ5EXEWxjc3SVlUvu+EPJYXr/mB5eX+qk6rYRPkLj4foyvyLNnzOn8x/alSwd7FhLVn8s//jA9VMQ2Zd3zbbEH/GkVMsrPcupq3IOZxopL73ysuS4BG/uWB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cby+ubwhd1b49twii9uh1i9Muf7cIQouvpUvMBLaq4rQQplVLXHMpbTQKJYm?=
 =?us-ascii?Q?+X36BjBy+sGzgis9BBst2yzISSXEEu3I2gG+ntvfXyf6TiO7WRcZjIoTmfTk?=
 =?us-ascii?Q?lmnHtTmJXZN463USQBtgBQrNkVA01YJKUyd9RiQtbbW1UIplMox5CUjj6hUF?=
 =?us-ascii?Q?FZqIcbrPGxfC4lUz71+PjfRtuVGyGM3Qpfmwd7I3QBlnDBWB6AtfjccqnIsY?=
 =?us-ascii?Q?amafKiC4cScVH5IwuBHoJ4F/Ow3F5DydYW7pIGQ/ZYbzOw/7QRcU9j0YGoAm?=
 =?us-ascii?Q?TcFdlYJhQfyNxYh3ybLaAkbSx/9IGUj/HRRKVZXDpxgOC3nq5AtAFg0RhVcR?=
 =?us-ascii?Q?4fKybvu/6c/PLKZ3pAp4cD1Sm4FjffLJeX2tvoYSoA3kTv2J0jGDaSgoHvp6?=
 =?us-ascii?Q?skAfvVKD3buJsNVVlaZgtwkTZ7YjBh5WDsRco/6Cj5I0fQTsmfiSTw7zpPAt?=
 =?us-ascii?Q?wkseOZY7C9UZMURhdV/pr4kZgZyuHsLA8PzdPRPwTgNoLY9mKEevHAIraB2/?=
 =?us-ascii?Q?p+U/sKojhhV4x2JOXo6nf51ZqR2sPmmF5VTCK+tDfOivKqWLS9j/ZVGrsbHG?=
 =?us-ascii?Q?hbKe4VTosNbUy7nn1gh9DweiyyqNvKbsHkyHcJqAHtz9mIyVkW2f9WORH+Bp?=
 =?us-ascii?Q?ot0Fax4IFecBtwZ34bizwEsf3JNbj3/9+NTil2JqNJdJLkDvgqFXpRnTyG9R?=
 =?us-ascii?Q?woqwTqi0l+GYWx7HOm80TaYwet00/7I9MtUT/iwyTREWJqXNoD/Pt+3dMYIa?=
 =?us-ascii?Q?SitXW0MqbHdD6/Wk0XVG4+zBPSGthxe3td6h43EuL8HRr70NKwHHdZpdUQVs?=
 =?us-ascii?Q?K0lbJWfye2b81I1BYNYat6TNyco/BU0+oUwfjV313RXS4Sik8cAXi5x5X8ca?=
 =?us-ascii?Q?aCcyYBP/H2fyQpF9GFYoEMz/j/mMhRxb3qGA8ugUYTm2TlLeff6/Vt2wEg45?=
 =?us-ascii?Q?JIDgq3jOdJfjEDYNQVrTgRd5Xb1tRDDffz4zLoVxD7EqEt6s2Yy/iDpWOIJ7?=
 =?us-ascii?Q?kd4eCBpS9pBWQyqainp+gnmC1jcLvw7/dbE+0EUhCRJ/on1lzzZBy1V7E2oQ?=
 =?us-ascii?Q?RFUkgWvY+67OpME8szFgxRPOT9BNTqXVvhrgXzy6bHia0uKJHySN97Pdt2/3?=
 =?us-ascii?Q?xZEHjA1PVKNlbG84ETQnukp8E9JqvlBYwEzCHXm8GKQrvF9GJT/UpF0/EXiR?=
 =?us-ascii?Q?qaIdxkxnFj9Jp0ktOmzweY1bRsRz1KFisKbojCzvjJUuDl4oXEFWB2QFolrQ?=
 =?us-ascii?Q?NkDqPheEIbgzi/xSCXKDBzYTty1vMpsi3H7XcKk8et5c3qTYZLznpM1J76k+?=
 =?us-ascii?Q?Qd8ECsbH0DGooRHZnCO7tycfldbZRbeegFK+TMAvNCDIowfl6mBP72cTL9YF?=
 =?us-ascii?Q?Su96dc6YlZha0nKus/JHnfGP9LlFPzg8gMoIZujyrquaiYg/ud+51plIL7no?=
 =?us-ascii?Q?cVWoLsRPu6ZIRzMlJ98/sf/MfRAv8/Pb/yx5vWr3yoPmDO0khaXIk8Jf0sNm?=
 =?us-ascii?Q?bjkYWG1Kq+N1tbKp6BkvIleLX+g1i1VFZwDL4PcxZqGwLQj/HWXh87UY854f?=
 =?us-ascii?Q?iO0bLZ8e4znJDREKIkM+SL14fezRcsE7tfBJB6xh7CPFUd2aZle1XtYNSsl/?=
 =?us-ascii?Q?5iJZTEgINHV+g8DcgIf9nq5E065t3xPoiTPYcABk40obWUrpQ9+HECDmDaWr?=
 =?us-ascii?Q?V1YMl/Chc5FjydosOcSKZKjnd1aHcn5xLZhasMJHLrFbUwEsxLIfqaOZSJHt?=
 =?us-ascii?Q?YynF0A6TgOwWiEIMVTdi6Ehg8JsLIGYUiztrn9DBtY7virQgfD6vnkEbCa8k?=
X-MS-Exchange-AntiSpam-MessageData-1: xr7aaSlHj4QkFmtb2Qnnlqrw+RzhwjmdAiU=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3c4d6f-f435-4249-55bf-08df389372d4
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:43:24.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUuSifJ/LBItq/VDZ+NQTQyiFb9/ivmm4fNI1U/bAwqD1oV+d+w8Ve+RiY0dnIklJLS9Rf+OaoHP/0EI9LKyfTiteFA+8kuwlEiXoAxNN8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3491

The following deadlock can occur, as observed during code inspection:

tipc_named_node_up()
 read_lock_bh(&nt->cluster_scope_lock) <-- acquire read lock
 named_distribute()
 tipc_node_xmit()
  tipc_node_link_down()
   tipc_node_write_unlock()
    tipc_nametbl_withdraw()
     spin_lock_bh(&tn->nametbl_lock)
     tipc_named_withdraw()
      write_lock_bh(&nt->cluster_scope_lock) <-- acquire write lock

Fix this issue by:
- Removing cluster_scope_lock, which protects the name table's
  cluster_scope list. Use nametbl_lock instead to protect the list
  against races when multiple threads concurrently call
  tipc_named_publish(), tipc_named_withdraw(), and
  tipc_named_node_up().

- Introducing a new function, tipc_node_distribute(), which is similar
  to tipc_node_xmit() but does not call tipc_node_link_down().
  Both functions call the newly introduced tipc_node_build_list(),
  which clones a list of messages in sequence or delivers the list to
  the peer namespace. When tipc_named_node_up() returns -ENOBUFS,
  tipc_node_link_down() is called from tipc_node_write_unlock()
  instead.

Fixes: 988f3f1603d4 ("tipc: eliminate message disordering during binding table update")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v2: Correct the bearer id that needs to be reset.
v1: https://lore.kernel.org/netdev/20261028033722.125477-2-tung.quang.nguyen@est.tech/

 net/tipc/name_distr.c |  32 +++++----
 net/tipc/name_distr.h |   3 +-
 net/tipc/name_table.c |   1 -
 net/tipc/name_table.h |   2 -
 net/tipc/node.c       | 149 ++++++++++++++++++++++++++++++++----------
 net/tipc/node.h       |   2 +
 6 files changed, 140 insertions(+), 49 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 22c29b187daf..82684bc7399a 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -95,9 +95,7 @@ struct sk_buff *tipc_named_publish(struct net *net, struct publication *p)
 		list_add_tail_rcu(&p->binding_node, &nt->node_scope);
 		return NULL;
 	}
-	write_lock_bh(&nt->cluster_scope_lock);
 	list_add_tail(&p->binding_node, &nt->cluster_scope);
-	write_unlock_bh(&nt->cluster_scope_lock);
 	skb = named_prepare_buf(net, PUBLICATION, ITEM_SIZE, 0);
 	if (!skb) {
 		pr_warn("Publication distribution failure\n");
@@ -121,9 +119,7 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
 	struct distr_item *item;
 	struct sk_buff *skb;
 
-	write_lock_bh(&nt->cluster_scope_lock);
 	list_del(&p->binding_node);
-	write_unlock_bh(&nt->cluster_scope_lock);
 	if (p->scope == TIPC_NODE_SCOPE)
 		return NULL;
 
@@ -202,25 +198,39 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
  * @net: the associated network namespace
  * @dnode: destination node
  * @capabilities: peer node's capabilities
+ * @bearer_id: id of the bearer
+ *
+ * Return:
+ * * 0               - Success
+ * * -ENOBUFS        - No buffer space is available
+ * * -EHOSTUNREACH   - Destination node does not exist or cannot be reached
+ * * -EMSGSIZE       - Message's size is too big
+ *
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+int tipc_named_node_up(struct net *net, u32 dnode,
+		       u16 capabilities, int *bearer_id)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
 	struct sk_buff_head head;
-	u16 seqno;
+	int rc = 0;
 
 	__skb_queue_head_init(&head);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests++;
-	seqno = nt->snd_nxt;
+	named_distribute(net, &head, dnode, &nt->cluster_scope, nt->snd_nxt);
+	if (!skb_queue_empty(&head))
+		rc = tipc_node_distribute(net, &head, dnode, bearer_id, 0);
 	spin_unlock_bh(&tn->nametbl_lock);
 
-	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
-	read_unlock_bh(&nt->cluster_scope_lock);
+	/* The link is congested after the list is inserted into
+	 * the link's send queue. Return 0, as this is normal.
+	 */
+	if (rc == -ELINKCONG)
+		rc = 0;
+
+	return rc;
 }
 
 /**
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..767f9f69624d 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -69,7 +69,8 @@ struct distr_item {
 
 struct sk_buff *tipc_named_publish(struct net *net, struct publication *publ);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *publ);
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_node_up(struct net *net, u32 dnode,
+		       u16 capabilities, int *bearer_id);
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 		    u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 0b03d407242f..739450204e5e 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -946,7 +946,6 @@ int tipc_nametbl_init(struct net *net)
 
 	INIT_LIST_HEAD(&nt->node_scope);
 	INIT_LIST_HEAD(&nt->cluster_scope);
-	rwlock_init(&nt->cluster_scope_lock);
 	nt->rc_dests = 0;
 	tn->nametbl = nt;
 	spin_lock_init(&tn->nametbl_lock);
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 3a15dcfcc2cd..a66975ef8546 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -97,7 +97,6 @@ struct publication {
  * @cluster_scope: all local publications with cluster scope
  *               - used by name_distr to send bulk updates to new nodes
  *               - used by name_distr during re-init of name table
- * @cluster_scope_lock: lock for accessing @cluster_scope
  * @local_publ_count: number of publications issued by this node
  * @rc_dests: destination node counter
  * @snd_nxt: next sequence number to be used
@@ -107,7 +106,6 @@ struct name_table {
 	struct hlist_head services[TIPC_NAMETBL_SIZE];
 	struct list_head node_scope;
 	struct list_head cluster_scope;
-	rwlock_t cluster_scope_lock;
 	u32 local_publ_count;
 	u32 rc_dests;
 	u32 snd_nxt;
diff --git a/net/tipc/node.c b/net/tipc/node.c
index d99049e67033..95f4284cc434 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -400,6 +400,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct net *net = n->net;
 	u32 flags = n->action_flags;
 	struct list_head *publ_list;
+	int rc = 0, bearer = 0;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
 	int err = 0;
@@ -426,7 +427,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		tipc_publ_notify(net, publ_list, node, n->capabilities);
 
 	if (flags & TIPC_NOTIFY_NODE_UP)
-		tipc_named_node_up(net, node, n->capabilities);
+		rc = tipc_named_node_up(net, node, n->capabilities, &bearer);
 
 	if (flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
@@ -437,8 +438,15 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
 	}
 
-	if (err == -ENOBUFS)
+	if (rc == -ENOBUFS)
+		tipc_node_link_down(n, bearer, false);
+
+	if (err == -ENOBUFS) {
+		if (rc == -ENOBUFS && bearer == bearer_id)
+			return;
+
 		tipc_node_link_down(n, bearer_id, false);
+	}
 }
 
 static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
@@ -1686,6 +1694,51 @@ static void tipc_lxc_xmit(struct net *peer_net, struct sk_buff_head *list)
 	}
 }
 
+static int tipc_node_build_list(struct tipc_node *n, struct sk_buff_head *list,
+				struct sk_buff_head *xmitq, int selector,
+				struct tipc_media_addr *maddr,
+				int *bearer_id, bool *lxc)
+{
+	struct tipc_link_entry *le = NULL;
+	bool node_up = false;
+	struct net *peer_net;
+	int rc = 0;
+
+	rcu_read_lock();
+	tipc_node_read_lock(n);
+	node_up = node_is_up(n);
+	peer_net = n->peer_net;
+	tipc_node_read_unlock(n);
+
+	if (node_up && peer_net && check_net(peer_net)) {
+		/* xmit inner linux container */
+		tipc_lxc_xmit(peer_net, list);
+		if (likely(skb_queue_empty(list))) {
+			rcu_read_unlock();
+			*lxc = true;
+			return 0;
+		}
+	}
+	rcu_read_unlock();
+
+	tipc_node_read_lock(n);
+	*bearer_id = n->active_links[selector & 1];
+	if (unlikely(*bearer_id == INVALID_BEARER_ID)) {
+		tipc_node_read_unlock(n);
+		__skb_queue_purge(list);
+		return -EHOSTUNREACH;
+	}
+
+	le = &n->links[*bearer_id];
+	*maddr = le->maddr;
+	spin_lock_bh(&le->lock);
+	rc = tipc_link_xmit(le->link, list, xmitq);
+	spin_unlock_bh(&le->lock);
+	tipc_node_read_unlock(n);
+
+	return rc;
+}
+
 /**
  * tipc_node_xmit() - general link level function for message sending
  * @net: the applicable net namespace
@@ -1693,17 +1746,16 @@ static void tipc_lxc_xmit(struct net *peer_net, struct sk_buff_head *list)
  * @dnode: address of destination node
  * @selector: a number used for deterministic link selection
  * Consumes the buffer chain.
- * Return: 0 if success, otherwise: -ELINKCONG,-EHOSTUNREACH,-EMSGSIZE,-ENOBUF
+ * Return: 0 if success, otherwise: -ELINKCONG,-EHOSTUNREACH,-EMSGSIZE,-ENOBUFS
  */
 int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 		   u32 dnode, int selector)
 {
-	struct tipc_link_entry *le = NULL;
-	struct tipc_node *n;
+	struct tipc_media_addr maddr;
 	struct sk_buff_head xmitq;
-	bool node_up = false;
-	struct net *peer_net;
-	int bearer_id;
+	struct tipc_node *n;
+	int bearer_id = 0;
+	bool lxc = false;
 	int rc;
 
 	if (in_own_node(net, dnode)) {
@@ -1719,44 +1771,73 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 		return -EHOSTUNREACH;
 	}
 
-	rcu_read_lock();
-	tipc_node_read_lock(n);
-	node_up = node_is_up(n);
-	peer_net = n->peer_net;
-	tipc_node_read_unlock(n);
-	if (node_up && peer_net && check_net(peer_net)) {
-		/* xmit inner linux container */
-		tipc_lxc_xmit(peer_net, list);
-		if (likely(skb_queue_empty(list))) {
-			rcu_read_unlock();
-			tipc_node_put(n);
-			return 0;
-		}
-	}
-	rcu_read_unlock();
+	__skb_queue_head_init(&xmitq);
+	rc = tipc_node_build_list(n, list, &xmitq, selector, &maddr,
+				  &bearer_id, &lxc);
 
-	tipc_node_read_lock(n);
-	bearer_id = n->active_links[selector & 1];
-	if (unlikely(bearer_id == INVALID_BEARER_ID)) {
-		tipc_node_read_unlock(n);
+	if (lxc) {
 		tipc_node_put(n);
+		return 0;
+	}
+
+	if (unlikely(rc == -ENOBUFS)) {
+		if (!skb_queue_empty(&xmitq))
+			__skb_queue_purge(&xmitq);
+		tipc_node_link_down(n, bearer_id, false);
+	} else {
+		tipc_bearer_xmit(net, bearer_id, &xmitq, &maddr, n);
+	}
+
+	tipc_node_put(n);
+
+	return rc;
+}
+
+/**
+ * tipc_node_distribute() - distribute list of messages to specific destination
+ * @net: the applicable net namespace
+ * @list: chain of buffers containing message
+ * @dnode: address of destination node
+ * @bearer_id: id of the bearer
+ * @selector: a number used for deterministic link selection
+ *
+ * Return:
+ * * 0              - Success
+ * * -ELINKCONG     - Link is congested
+ * * -EHOSTUNREACH  - Host is not reachable
+ * * -EMSGSIZE      - Message's size is too big
+ * * -ENOBUFS       - No buffer space is available
+ *
+ */
+int tipc_node_distribute(struct net *net, struct sk_buff_head *list,
+			 u32 dnode, int *bearer_id, int selector)
+{
+	struct tipc_media_addr maddr;
+	struct sk_buff_head xmitq;
+	struct tipc_node *n;
+	bool lxc = false;
+	int rc;
+
+	n = tipc_node_find(net, dnode);
+	if (unlikely(!n)) {
 		__skb_queue_purge(list);
 		return -EHOSTUNREACH;
 	}
 
 	__skb_queue_head_init(&xmitq);
-	le = &n->links[bearer_id];
-	spin_lock_bh(&le->lock);
-	rc = tipc_link_xmit(le->link, list, &xmitq);
-	spin_unlock_bh(&le->lock);
-	tipc_node_read_unlock(n);
+	rc = tipc_node_build_list(n, list, &xmitq, selector, &maddr,
+				  bearer_id, &lxc);
+
+	if (lxc) {
+		tipc_node_put(n);
+		return 0;
+	}
 
 	if (unlikely(rc == -ENOBUFS)) {
 		if (!skb_queue_empty(&xmitq))
 			__skb_queue_purge(&xmitq);
-		tipc_node_link_down(n, bearer_id, false);
 	} else {
-		tipc_bearer_xmit(net, bearer_id, &xmitq, &le->maddr, n);
+		tipc_bearer_xmit(net, *bearer_id, &xmitq, &maddr, n);
 	}
 
 	tipc_node_put(n);
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 154a5bbb0d29..775a8ec240fb 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -100,6 +100,8 @@ int tipc_node_get_linkname(struct net *net, u32 bearer_id, u32 node,
 			   char *linkname, size_t len);
 int tipc_node_xmit(struct net *net, struct sk_buff_head *list, u32 dnode,
 		   int selector);
+int tipc_node_distribute(struct net *net, struct sk_buff_head *list,
+			 u32 dnode, int *bearer_id, int selector);
 int tipc_node_distr_xmit(struct net *net, struct sk_buff_head *list);
 int tipc_node_xmit_skb(struct net *net, struct sk_buff *skb, u32 dest,
 		       u32 selector);
-- 
2.53.0

