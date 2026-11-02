Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793590993;
	b=BMM+7U5HAoJSURIpprEEQAKzyoJqluVakEgu4KlXRfljUReVXdT4RPoEnixODQpyHkgr
	 YRwbjBpA6ta+8vs7cXyewrdssTWfoPT0HZynuQdW1NEd8ndzzMFkwZqXCwJ6kfZf427WO
	 VYvAAF1E4DUWJ51DqdCiMYiEp1dk14jTWiMG9SWUb/drmzmLY1QdL0GKRCL62Y1bCJejh
	 KUIsShWvV6393mM7yr6Zce7zY16ytMRpBfEFBqwEluHd3fXlvDpmikxVhEmWMglTBvaEw
	 RgorSm6J4cEjjp8nNVtfj9SkA+PJLkImbB01nmXJ9TpFS0MGGuC/Wz1luQm0oNBG60g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793590993;
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
	bh=d1+qsFgs+XRYV+7AP2NzLWGGLbVJbDWpiaF91KyoQoE=;
	b=vVSxCbmcB42WePmvlFeqRiO/kCjHBgKP+6liwJlSERh09K0mdw3uhf8kGWXJ+EEFgyfr
	 zEe6H1qL/kD91QMlbDJB1xo5UJVBPGksLb9nRKJM4I/Dq6mMYJ8zHzqNApK2/VF7dsP4S
	 9JWfsGeEC3jFOB6GiXtw4lp3C1bl6mPCjeviEGPuTpFkgfS+SZbtga3cBup1lTH4Ak+18
	 YNYDT03rCGvnznG/Vb6hi4yrBPXeJnuiSkygwvQg932IlPpBwC6ZtGInDUWYpydLV5AqZ
	 NbaBNy9Of9eRleZf5kZiz3P0N1wSgyAeK+gsBIGr2DxjfCG7ZRf/Gow+Rf1oK9QQvTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=LI4cVJQq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.2
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A54606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A54606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=LI4cVJQq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQsGPGpanpuqIExCnLMQPYiA7wSdw005iXwfUxQBJ+6Hq96DkZ7S3XqLm81x3qz3Y+FnqCfWsHn3aJ5u97XXZFmh54ok1AeuhxP6KxfkfGUCHrbEIefyEe/WcQvW+z3szzFyl8Dt53QfHkTQE9M9vRn9Fs+uHVIUn1Sy+11EUwLZSst+CFnHTlgcVZSqQAN8QiFwuRdbtjj6OItGuUDkFOYkxLrYODLMMrLo3IluhiO9bBhPHaDDe/POEJttmuy1HZEP8ZaBHkVT0zfc79YqEFKLALFXz2b+Z3muQC7DHO8xB/r3HW4SS/AYulpecYOX8EqS08UxF2AKibQNUrGwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1+qsFgs+XRYV+7AP2NzLWGGLbVJbDWpiaF91KyoQoE=;
 b=K/9DaWEOez179eDKqidX2QwbRPZHaQp7LU0KZG+71hLSttUjBy7bSu25v/CphxVGawgXcjG2jL+g9JtlQJK/MZG/Zc/G9FZ8fAyeTWEbpDFR4k9rwHkxCcUrdUXeNQQfqJKzKSQDL0ayIJudIpR4+Iz+PpFyK99zYPCd0gIvz99lTrDhc+4lIAr3cr6ovCS7fa/bwnvFLX0fnRS5UqgKcyCctY5l80Bts8WU3YTYIZN9uWk9H/PDxyYz71gLu5Yy/UTDqvBOpbgbMdDzswj7UYhBO3MlJuLNtKXT7/nFeziQCqPUL+D/HRTMsYmm5G0r9xTNPh5FvoHCYwsIIcrUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1+qsFgs+XRYV+7AP2NzLWGGLbVJbDWpiaF91KyoQoE=;
 b=LI4cVJQq3ZRK4vo6yj009D1Wq6r4xASBRMW5BcZoXMXN66Qu/Z84KmJeViZjdNfSjttOiGaGNYWmvgwcgJxQc2heRJV/D4xVKTcSUE80V0a0VsQX4n8hJyqj6Cv/w7tFS46XZu4BgPsxeaBqBmcul++OmaUJZ+o9sxcPjypzCD5MrjV3mlEH9A5hF8Tkh+JK8tdpMdkUB/9XTauD40iSOF7N/fcUXcke97BEirQVatZjNQPMLMFWeLyBrU9WIheUNea8eTaI5132VkaBdX3LnhDgEn0qtgSNA7MosEFAEOamsdLjKx+cUHiBhnOVxzUmqV7nrKrn6hK7Rd1R4LjHEA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA1P189MB3491.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:43:09 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:43:09 +0000
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
Subject: [PATCH net v2 3/6] tipc: fix incorrect initialization of replicast node counter
Date: Mon,  2 Nov 2026 10:40:29 +0700
Message-ID: <20261102034207.10639-4-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
References: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::11) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: cdcb36be-a1bb-45bb-1697-08df389369c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7Zd2jGCfajlydjfJLwoSX1DcYGaKu+fzUlYwMcPG+X8+uh2HAEGP7jhjAxt+3dX2iIROjhpkxxZ+c188X2DA37+2mYneWSOUI3/Adw+0NHdEJdOhiMq5dD9LVk3Mrk4DKdeeR8su94VYpQg5gq/FZRwa+2/fhjLN0vJZtnF9aC1lEEYE0F4E/i2uJWlHKeIcocPO1xSyekkBwEFLOOYvdBb5uMcY3wsd1YRTWx2QOAzsuGt3XO+KVZmBlSNUx/PIxerVj/itb25LQabWmk9ZvWLABv6uTexpN1Ka79Yh2uiWHtCZ97Ov46wQ5pSRrIzbqy/SvV1OAGZvscA3XU+5kmJgyoOXPNYieKWxqCqDJ90TTMs/B+g7omSDNKIxkFHNHSfFh3ugmXkH1O8sV6a88jmzZ32Qju7e0iuidyJqdzlT97oJh14VVwPQWGGWNSfZudGLZCMjJgqpTjFPjK7rfmyrpYHOV6x2PFAiaImiBgPkYl7W/GYA2QvBSFCX/dEWChanzDItejk1HILRCv+Hsb2lqJMZ3WROTNjG6svaDvG/yUhOa7G43E5HyezUgZPQQRDZ5sl1VSXNfXFrmFlUnlGL7BINmugukhhbTgv+UN0xS89tJV9RzXcNppvsszeQW3sfxWufdrP7KQS4Ht8PaTzCQiuIMeoA+/e25aeCWoc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pi0vDq99jo5Mb/ROUk6bEAXOR/tpssY8Smzrx9513ENF51a1bAafrhsMdpm7?=
 =?us-ascii?Q?GxcRnrkquBj7lYHWqs/ucDcnG460C7Ij9t1VbG7hbNGeGdnTcEKh8jNvM9re?=
 =?us-ascii?Q?dfTr9DxDtV96br5t5UpbFfy2Vf7uuWk23JzKhf74Y8oPC9TYZI/xz1qd/bCd?=
 =?us-ascii?Q?gaFBQEhcUVQeaZL+3xw6UlRZAh6Sc5wpdtfTA27qznGaPxPFLMHRdS+ASO6A?=
 =?us-ascii?Q?AxPSyBecbE7M+V+yBIH4THZpuJade9tFkGrmwXZvtUvKDE3vvW5k/yc9smxF?=
 =?us-ascii?Q?Q+JDzRUAETN0/QYDOPd6Wa4KU04ImCpbZAQFCzqFBIoT24VC3CiSvPd+nxMZ?=
 =?us-ascii?Q?ox2G3B6J4p4f0Q5YfAM0WvNik+f3iw9E/SP4keTzyLaUZMVNwKXEDGHc+IMd?=
 =?us-ascii?Q?TQbUpXXSrX8QhTsegUvW+lu/f4Hp2F+nDWQXm/XU86TX+RTPKyzOrdliTBkB?=
 =?us-ascii?Q?RgXuE2I6/EuO41XReg7E2jgYwuUIn7Oo7yaryxk3odAv5KEI4eOKrfkeRnWs?=
 =?us-ascii?Q?1fKix+WANTzEbFUcF18+fRmtBNB73XQCMqKmYqPd5DmZahCnTJimaDa76Ap1?=
 =?us-ascii?Q?GOUDiyp6YQU5JVhK1us0f7rAyLodr35x/tWUYSnjOEXTF5+wDxckeuxcGobe?=
 =?us-ascii?Q?MipGrC7gf6BeI3446bcT+B6cSEIOOteQeF5looa9kZEsisW2M7VwS/WouRqd?=
 =?us-ascii?Q?R2uwI1Jwl+lV6iJtZlU3dUBCu/yBxgid8X8kiHa+JtPK746hozawo4KeBVwW?=
 =?us-ascii?Q?SrOaY9Eanhk3B6XwC0+VjLTiC7kQHdXCjS9G5XfjsHRy2IAGyMBJy6KiNNxa?=
 =?us-ascii?Q?3rFKKbpn+EjVC9UKh8i1+TKxXgBzzRUkQxItiFlhWKsoZ6Jf5KppBq945jQd?=
 =?us-ascii?Q?rR66wACb9B+CXviDl6nYhX/2E9Uo3VGGYhtgaaI+2nopuElUkGJgJZtKqwTb?=
 =?us-ascii?Q?gbsdApCCECYamDxke0iUPQifWsGjAXbhkANIW7GnpWXicp5D5zR6oxK9fu80?=
 =?us-ascii?Q?5x1gVcaftTIRCsIm71ZU3hE9NbGQT+Ir1+4IE3hh0Zn2a8CrC78CSoTXZRMe?=
 =?us-ascii?Q?rLnBeHiD6NH8OV1Iw2gO8I1+0YJSF1LxPTrUYhFYSzB0VAoidkuAYUDT6oRc?=
 =?us-ascii?Q?jbH6NZtyshxL1YJPpWkqkYIHQ0+w3bVj9w2FUhauTTc085qIJf0P01C+JxVi?=
 =?us-ascii?Q?A5UQGlkJhXDqq5ugq7y8ReRg5KBMTBehdgNyOZjvyssKL3dcFPDOrgXdKUq2?=
 =?us-ascii?Q?R9ua6QsSX0tCz1lnRd6P49lVW4LDWlT+ztVIxZDVfLMborWmEMyjb0vLBdCF?=
 =?us-ascii?Q?RvlPmC8WdY9mXxsSh567/LhGb+eukYD8GRoKalrjZk6K/tY2SaEcwISnm4Iw?=
 =?us-ascii?Q?QcNCDwl9Ku/JdbcflEkeu0vHbSVFkrnyxwieBvpn/cdYxP0ZQdQ+0sbSxGKq?=
 =?us-ascii?Q?sX1+cnFY9iM4D5L1+ZfNp2RH6TSr9VThIbkcnrLj7EdtggSroDgbfY/iChvN?=
 =?us-ascii?Q?dmAg+PhnTwyPFzqi5i/6hva/zcgz3ZUNMCpA2eW0ORPITJOg9YLtqIvxRRgU?=
 =?us-ascii?Q?eOoNKbBslLV4Z6jBqoHhszWtlHzEvBq9jfEurfYmzuBq5KKH/QowIi7x2EBx?=
 =?us-ascii?Q?D3F75LgzksTa9ZgVZEi0kRWiku83KVffGbnupMF0Ts/PQqV0cGQhgNMOz8kG?=
 =?us-ascii?Q?tag5MpVeqH0s1xraC0yaNPr0Lq738NPXhOx+dkr/zZ8PbIf0mqjJD8pOF9Ju?=
 =?us-ascii?Q?HvKZYn9+yCSW28txUNIP2bx/aYg1S/UOwFvB4R//+9StFDhZv9ono92dHIns?=
X-MS-Exchange-AntiSpam-MessageData-1: qnHCf9ezzslMsbCh0FlZwenmq6PIVgD2tok=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcb36be-a1bb-45bb-1697-08df389369c1
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:43:09.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqAVgEET9aczwrCQiQL/L6VrWMzG1PoS9Rgyapka+Be8rNaR7vUPbyL5pNYlQ7crUIXO0B6fYnS/y46UoK8zTAjAMmkdm4cegEDoUvcfvkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3491

The TIPC name table uses rc_dests to track the number of nodes
available for replicast transmission. This counter is used to decide
whether to use broadcast or replicast links when sending bulk messages.

However, code inspection revealed a race between tipc_net_finalize(),
which initializes rc_dests, and tipc_named_node_up(), which
increments it, as illustrated below:

Thread 1 (tipc_net_finalize) | Thread 2 (tipc_named_node_up)
                             | ...
                             | nt->rc_dests++;
...                          |
 tipc_named_reinit()         |
   nt->rc_dests = 0;         |

If tipc_named_reinit() (Thread 1) executes after nt->rc_dests++
(Thread 2), the counter will be reset to zero. As a result, two
unexpected behaviors can occur:

1. User publications are sent via the broadcast link instead of the
   replicast link:

   tipc_sk_publish()
    tipc_nametbl_publish()
     tipc_node_broadcast()
      if (!rc_dests && tipc_bcast_get_mode(net) != BCLINK_MODE_RCAST)
       tipc_bcast_xmit()

2. nt->rc_dests can underflow to -1 when the node goes down. As a
   result, publications are sent via the replicast link even though no
   replicast nodes are available:

   tipc_publ_notify()
    nt->rc_dests--;

Fix this issue by moving initialization of nt->rc_dests from
tipc_named_reinit() to tipc_nametbl_init().

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/name_distr.c | 1 -
 net/tipc/name_table.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..1dfe8475a75d 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -415,6 +415,5 @@ void tipc_named_reinit(struct net *net)
 		p->sk.node = self;
 	list_for_each_entry_rcu(p, &nt->cluster_scope, binding_node)
 		p->sk.node = self;
-	nt->rc_dests = 0;
 	spin_unlock_bh(&tn->nametbl_lock);
 }
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 73b032ba2f8d..962b82956032 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -922,6 +922,7 @@ int tipc_nametbl_init(struct net *net)
 	INIT_LIST_HEAD(&nt->node_scope);
 	INIT_LIST_HEAD(&nt->cluster_scope);
 	rwlock_init(&nt->cluster_scope_lock);
+	nt->rc_dests = 0;
 	tn->nametbl = nt;
 	spin_lock_init(&tn->nametbl_lock);
 	return 0;
-- 
2.53.0

