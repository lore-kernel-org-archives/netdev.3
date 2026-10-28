Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793158726;
	b=foZxqO061K9yLUMxv8h7f8ho7nhJx/RzlbnXl+TZITcDoS3ywPPtzw9xEJfoW6ALVBkg
	 hw/ovyJnoce/PpWJ91FxAhvdGcyaxWXk/cEpEWJhwD23J7QSwtNnwxthMViMPS3zylpcv
	 3Wmhqe1t2qIeF9TS/j77zqMcohN/G6bxUv42Q8JfGwaXfwgOAhFDP+qrZLtxPcb9NRILj
	 82Hoa+jrinmC4mUwzedAvQaj1NMKbnnXtT7evKFGi2H9q2NLZt0TUKSRgTYdCGmI2wTqB
	 eVmfYViMdkT+NB+19AsRPL5zKMDLB9Bx+vzJnbFjLQU2L9qOOlz3TpO1kGK6Inp0/wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158726;
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
	bh=0uCFUZhiT1LkpLKMtZWZ4ohMSFLSgXyQWVYiK/3rUdk=;
	b=amOcoCnXLNugeO3KSqdYKEavrYAN1I3DLjOmDDlu+tmTg3MLdjnZZdTqPbiDiNw+2J7F
	 d9Ao23rtvRV18xZHy9Gyzjavfb2F2LqdRuYtT2kbVi/Uly5HR3JQ28BiYrVi97V0ygBXn
	 Grcl4SybpU8cawYBEq/Z5h47/PNXjnNsrW58L0QXKBhBatb2uKYKwOjPZMFXmp7Svl6Q7
	 xBR+BonSbWS4o0Ox8qwFuF3+n9PWCGj1RxSDdJgzbex4Jj/odoC5kb5yVLSNlbbwF+jqx
	 QJ8JOtZNlBfzbB7Fs1AT55pIi/uVP1/cBY1zLQlLbA/ylo+SRHmC8+WhfZL2Xcocawg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=OLS22VzC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.57
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33D606A323
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E33D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=OLS22VzC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR91nrJs5taaJ69a5Cy5XMmrIyWy7DShI1yhDBP469QW4vy0wt2RLJmUfjO7tUNerwTQAkJNJvu+yKwJVu69Xp+PfkioMgR8Xr1Nn3iY0ihNFgchhBR/7DjY0h7TZtxNkrrUPusPgeuH2WqjNzR/az+c1PgudfglVr75uTI3NTkn5OrVGhHr5PcoQI4HXzL9vPp4c+BraoN3lpKIdzrB+mt4f7Lw9TriVnTGs2lQooGcL3LAf6e7pYNWXIK/UU145d2FgLmo6Eq/GdYRdcftMotfy+FZonAnBwWxKBFYP6WDV7S57Z4BqETeldAFsa24zNMJwPKBbcouujNUI9v20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uCFUZhiT1LkpLKMtZWZ4ohMSFLSgXyQWVYiK/3rUdk=;
 b=iaErr7TImAxwhES44hxzPJf8um8D4E0raMtpoZLuKD9oJsLceF+eRBBfGYdg5R3nCRa88vQ5SshtqWGoYIt+75K4nmsVzxTTIivSshy5UPBYJEYOn8P5OOZerEiWtMtwSIk0blZpVmsHWRFGxVTfplhxx5Y49hIuDBlqCF4CUcXbW/7Pco/je9kiy0dQPFFRou1qwovekPK+KJjNmq1t8l5tp7jZtWMae0dWv4atxfVaYERZOBoTXVRrUisYJtqjDldMEATeCDU6EQZpIROsWaya86gppu7/sNLbT6XAEPOzWb8/hlFX7eSjdhVcgPOtqs11y6IOZFpqhDuQDEMC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uCFUZhiT1LkpLKMtZWZ4ohMSFLSgXyQWVYiK/3rUdk=;
 b=OLS22VzC1zXSLo2m8nflViHzTAVIstW8kpOXl0Bpk3/7leI1ifF01QuLv8FtZibxvd+XuYY43oqRCIybdL4bZzLEMFGEYvoX417ctyYeXKjXzMN9Dc6XJ2x6oD7qc6+wnRv4qTxgJLuJE+YNKiPHMK+w4QVyma6NhnndTCAmHa9n17dxaPyTrUyfGqJznUk5AKL1/TkaweOIjK5QAyRlcyFfzrqWcQnk51z1I3EcmmbzPDXdeb/y09kb7WvkewI98z4au8YcKL3na6gpEZ6Jdwlh1PDSl5QyWCY+AuRjZc+ynr1EHURroARyxpx5jeGih2Vm20vqEUKpisdmfZFgHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by DB9P189MB3693.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:5fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 03:38:41 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 03:38:40 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com
Subject: [PATCH net 2/2] tipc: fix NULL pointer dereference in named_distribute()
Date: Wed, 28 Oct 2026 10:36:46 +0700
Message-ID: <20261028033722.125477-3-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028033722.125477-1-tung.quang.nguyen@est.tech>
References: <20261028033722.125477-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|DB9P189MB3693:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e4836c-fbf2-4560-a0c0-08df34a4f563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|11063799006|56012099006|261022105027099003|261009223027099003|261022075727099003|261022113327099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8ZbcgSp8z3ZodXqPfVGcZh+R28ROV8QG0e8qrishdV18yDR8kIsPAugpqVE13SRlUYhG267xg06psSO88HiGB2MVcThWHU1YLJyLeofKs1bOqPcvafQILCXmJBHLcgGrPJKz4RF8c0F+nR1spspfXrr7eTo7MpC7Jn00tyTHknATT11LkL3Caw/faBN8Mt61DC6e7YxLkUJQbPBm4c4kolp9hZ7RciIzpKg2YHAT+3r+n6PR/6O79bjSciUmL1Vw62L44j5vbOPS0hT/bjk8SOnX3QRYDrGPJRO8CQVZ7PEnkmWIrY2/Bl3mVtcuxqgHRZrQxSrVbsL9KFlTTIGbj8jIiRuJ+HMSD/yFvFMRvCxct9cJrK7E2pXaYDLM9V7QVazzVtNCoSULnjiWpyU6lrPHXnl8cAdFnjCFLVTjNC9BvTsAKIekSdh8SAw6LdiURAf13ZklGy8TYftususZMDc6Xgo7pBQH3knDPgDG44q5fJD1rfH0jtCRazAzwt1NOvIXOFLFyKOWkUFsNuk7Dn+gTvhaf2UuwO0qtZ2XER/HaaZKyiszUFjoqWzMvONfKpm8yKLeCTauB1Qoy7WjfJtlTa0aooRCyLETquSQ8BJdLxkMUs7pSkzr9I6A4v9N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261022075727099003)(261022113327099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ze6PClhv2IJG8XDi92nWOi4PLyCgrVexKQ+iaKvKjwLgq2cf2k01Rq6aj652?=
 =?us-ascii?Q?+4jjUyJz0SCC0M0odzmLgJlwPEKlNmFu2hTXvVR8K5+zrc0NSAvQqW5PF9k3?=
 =?us-ascii?Q?+HHMQGa5q1rkL6et7zGys13ChyGuAktSwkowEdaAdjXSWkz1YB/v0KgAb+Z9?=
 =?us-ascii?Q?9+kIXOfHRPCj+4aonJlDE2TOwvEiYqgz6UAWeMOs8Z3jqL0XAZiKU7xki8fU?=
 =?us-ascii?Q?jD3ADX0qj+HPm80Zyl3foU2HjjmgvRE1KBM1r7zk5d3ukP8nhLoVQ4giHsvL?=
 =?us-ascii?Q?T2I72WZ2OxQgIInrVY/sO11LA64+n2em/m4Mim3reDamjDecB4tzFymvdUkW?=
 =?us-ascii?Q?fzt8JKunACkS2LQIVQ98+UNfAEwXBAjP9nsZ0xCjHf0zm1inpQUfYHoDtiyK?=
 =?us-ascii?Q?mTosxCn8HLDnTA8UMCbRNcNmPBQjxISoC3gOVRRco07+JeZ7y4pxAhpeWfct?=
 =?us-ascii?Q?ZSAG7BnC6Db2IAD94TCDnD04JQJGO1QkKrSr6nVGNrD6yLAqHAgQRmvR2sd0?=
 =?us-ascii?Q?+0lpgl2IJnk5fHiAejj84xWTZt+aO6wSlQNq3YqZ2PdPqrQt2U+frE3UxL1z?=
 =?us-ascii?Q?y/NvbnANCth57AXlmBcZEju+uelJvhyCD966+hb2WHk75yz/qoU0AqVJXp0t?=
 =?us-ascii?Q?1a3FSKSVDJcUrV3kgJWZGEz7TflRlKUXkd6JLdXLDhYwRsgOY5GG+agbHt7N?=
 =?us-ascii?Q?4o121XswgZWeMn6NB5ShpC2djOYAbyb+B5am8pVpHm5MUOIgaBvmzgvmMjMe?=
 =?us-ascii?Q?lbPR64Z9yvTnDEST8iZhsg4GTgEyROpYrS5NEKRNstQuzPphpkzPLNYlEcdn?=
 =?us-ascii?Q?Xx0ThZC+yI6yYLhcTmydgxKD7sDv10EbUzNCk9k+Fe8ng//MhjvOe3YrMTM4?=
 =?us-ascii?Q?Qhm4xoHDr2O+QcSWnpvuC1x/4vp7C+ZsCVW/wAU5nSc/6kt65kZpWNgV7dNl?=
 =?us-ascii?Q?VRmTFTqp+xyZXKjA7Qd2rocKazVc1YaT5Y+MVGhQtKfl5SqGn4VqACOVjuS4?=
 =?us-ascii?Q?H+DOaYyJ5tQplf6KqGaWLCYYYhlgjLY02bsZkEqarI1Li9fnvtF/+nM66AbO?=
 =?us-ascii?Q?4vjDSvnxQ1HKk7zsEtUs5LUlclMOQb13IVUOGPE3s0iUakUOlzjV9qr1X/0R?=
 =?us-ascii?Q?1CDTNFfMr4NxK/31kxmv0Uis7izx56qN12ZXfvlEHV9QtkdXXM8udi+IVQlN?=
 =?us-ascii?Q?vbiu33jthvde5ctpAxm6UJdAhjI6mrLq8Ggpgo/RZuvH6k/N+1SmevZ82pTa?=
 =?us-ascii?Q?A9VIvYcN3czzzOy3Ds55C6cw1TaQxNAnGrMv7VdcmR1MOwfTzJRuOTXPLDEr?=
 =?us-ascii?Q?ncTzFlakRyOwbfh40VX0/Vm4XeP2i9i+wItaVQ8YSu0AKfzn4vGDr6H9I3Gx?=
 =?us-ascii?Q?9YT8V3kRfONf61l73EY4pFzQTaJgPaVxOiz+pK+4VlDYjjP4Jw89lySTBo+b?=
 =?us-ascii?Q?mX7+jLmDHienOqhM4xuqpwkQiTmQyUxs9k6w0IUC76K+A3fQzjHYQbrU2kfQ?=
 =?us-ascii?Q?kodpa/Y7Oijrmf3UL334tVq08T4Kx9ZmDq28YGzNj9sIDH7zTi3otThF1AaS?=
 =?us-ascii?Q?7/fess8sEZrMPPOljttgZEoI/vnLm28Y47rtaVnZW7rUE0DLvVW5bh8hkTId?=
 =?us-ascii?Q?Z6u94KTri1pFTwxmwUR2AY0vyxR38cCpFeFEkMj+tYrvHpf+fWIFvvE5IL0X?=
 =?us-ascii?Q?j6Vlh96ebZe2qUz/xv8BpA08Dt/2L+GiKe2nxc1ERzek2NOXMZa1KuLIfo37?=
 =?us-ascii?Q?YaCb/7b+CasCI0+Vrcy36QiSND6+NLoe+hPrmuExmzjKtHSdt6G1JojdCUBh?=
X-MS-Exchange-AntiSpam-MessageData-1: ket+lXHrn6OcVEEk+7FIaYiSfJMtOJtrNh8=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e4836c-fbf2-4560-a0c0-08df34a4f563
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 03:38:40.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Pjc8vnWFJFvkWLGbH5p4WObP5mIt9aBTMgrY/ei8nwjyekbRNFmoEWVTHHZx39L8EGhtSPMTyZQarjCkuNjndj9a/L5arJPwzaavCDrDoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P189MB3693

Syzbot reports NULL pointer dereference in named_distribute():

...
RIP: 0010:buf_msg net/tipc/msg.h:202 [inline]
RIP: 0010:named_distribute net/tipc/name_distr.c:195 [inline]
RIP: 0010:tipc_named_node_up+0x8e0/0xb00 net/tipc/name_distr.c:221
...
tipc_node_write_unlock+0x2ce/0x4f0 net/tipc/node.c:428
tipc_rcv+0xb55/0x1020 net/tipc/node.c:2196
tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:671

The root cause is racing between tipc_net_finalize() and
named_distribute() as follows:

   Thread 1 (tipc_net_finalize) | Thread 2 (named_distribute)
   -----------------------------|-----------------------------
                                | ...
                                | list_for_each_entry(publ, pls, binding_node) {
                                | ...
                                | __skb_queue_tail(list, skb);
                                | ...
                                | }
                                | ...
                                | hdr = buf_msg(skb_peek_tail(list));
   ...                          |
   tipc_nametbl_publish();      |

If 'tipc_nametbl_publish()' (Thread 1) executes after 'named_distribute()'
, list will be empty. As a result, NULL is passed to 'buf_msg()', leading
to a NULL pointer dereference.

Fix the this issue by checking for the node's self-address publication on
either node-up or node-timeout event. If the publication does not exist, insert
it into the name table and publish it to the other nodes.

To facilitate the implementation, three major changes are made:
- Move the sc->lock acquisition out of tipc_service_insert_publ() and into its
  callers.
- Add an output parameter (*err) to tipc_nametbl_publish() to detect memory
  allocation errors.
- Add three fields (nt_stop, nt_self_node_exist, and node_addr_set) to struct
  tipc_net to synchronize the insertion and deletion of the node's self-address
  publication.

Reported-by: syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=64197f7577a09686ffdb
Fixes: adba75be0d23 ("tipc: fix lockdep warning when reinitilaizing sockets")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/core.c       |   3 +
 net/tipc/core.h       |   6 ++
 net/tipc/name_distr.c | 120 ++++++++++++++++++++++++++++++++++---
 net/tipc/name_distr.h |   1 +
 net/tipc/name_table.c | 134 ++++++++++++++++++++++++++++++++++++++----
 net/tipc/name_table.h |   6 +-
 net/tipc/net.c        |   9 ++-
 net/tipc/node.c       |  61 ++++++++++++++++---
 net/tipc/node.h       |   1 +
 net/tipc/socket.c     |   2 +-
 10 files changed, 314 insertions(+), 29 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 315975c3be81..0f1d3ddeae09 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -61,6 +61,9 @@ static int __net_init tipc_init_net(struct net *net)
 	tn->trial_addr = 0;
 	tn->addr_trial_end = 0;
 	tn->capabilities = TIPC_NODE_CAPABILITIES;
+	tn->nt_stop = false;
+	tn->nt_self_node_exist = false;
+	atomic_set(&tn->node_addr_set, 0);
 	INIT_WORK(&tn->work, tipc_net_finalize_work);
 	memset(tn->node_id, 0, sizeof(tn->node_id));
 	memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..975b1d48186e 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,12 @@ struct tipc_net {
 	struct work_struct work;
 	/* The numbers of work queues in schedule */
 	atomic_t wq_count;
+	/* Flag to indicate that the node's address is set */
+	atomic_t node_addr_set;
+	/* The name table has stopped working */
+	bool nt_stop;
+	/* Node's self address publication is available in the name table */
+	bool nt_self_node_exist;
 };
 
 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index a60f213ed118..345bd767983e 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -142,9 +142,14 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
  * @dnode: node to be updated
  * @pls: linked list of publication items to be packed into buffer chain
  * @seqno: sequence number for this message
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
  */
-static void named_distribute(struct net *net, struct sk_buff_head *list,
-			     u32 dnode, struct list_head *pls, u16 seqno)
+static int named_distribute(struct net *net, struct sk_buff_head *list,
+			    u32 dnode, struct list_head *pls, u16 seqno)
 {
 	struct publication *publ;
 	struct sk_buff *skb = NULL;
@@ -160,8 +165,9 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 			skb = named_prepare_buf(net, PUBLICATION, msg_rem,
 						dnode);
 			if (!skb) {
+				__skb_queue_purge(list);
 				pr_warn("Bulk publication failure\n");
-				return;
+				return -ENOBUFS;
 			}
 			hdr = buf_msg(skb);
 			msg_set_bc_ack_invalid(hdr, true);
@@ -191,6 +197,94 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
+
+	return 0;
+}
+
+/**
+ * __tipc_named_distribute - build a list of publications need to be distributed
+ * @net: the associated network namespace
+ * @dnode: destination node
+ * @head: list of publications
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
+ */
+static int __tipc_named_distribute(struct net *net, u32 dnode,
+				   struct sk_buff_head *head)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+
+	/* Name table has been deleted after namespace teardown or
+	 * TIPC module exit.
+	 */
+	if (unlikely(tn->nt_stop))
+		return 0;
+
+	/* Node's self-address is not set yet */
+	if (!atomic_read(&tn->node_addr_set)) {
+		/* Defer the distribution to node's timer */
+		tipc_node_set_dist_bulk(net, dnode);
+		return 0;
+	}
+
+	/* Previous call to tipc_nametb_insert_self_node_pub() was successful.
+	 * The node's self-address publication was added to 'nt->cluster_scope'.
+	 * So, 'nt->cluster_scope' is not empty now. Go to distribution.
+	 */
+	if (tn->nt_self_node_exist)
+		goto distribute;
+
+	if (tipc_nametb_insert_self_node_pub(net))
+		return -ENOBUFS;
+
+	tn->nt_self_node_exist = true;
+
+distribute:
+	if (named_distribute(net, head, dnode,
+			     &nt->cluster_scope, nt->snd_nxt) == -ENOBUFS)
+		return -ENOBUFS;
+
+	return 0;
+}
+
+/**
+ * tipc_named_distribute - distribute all publications to specified node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ *
+ * Return:
+ * * 0               - Success
+ * * -ENOBUFS        - No buffer space is available
+ * * -EHOSTUNREACH   - Destination node does not exist or cannot be reached
+ *
+ */
+int tipc_named_distribute(struct net *net, u32 dnode)
+{
+	struct tipc_net *tn = tipc_net(net);
+	struct sk_buff_head head;
+	int bearer_id = 0;
+	int rc = 0;
+
+	__skb_queue_head_init(&head);
+	spin_lock_bh(&tn->nametbl_lock);
+	rc = __tipc_named_distribute(net, dnode, &head);
+	if (!rc && !skb_queue_empty(&head))
+		rc = tipc_node_distribute(net, &head, dnode, &bearer_id, 0);
+	spin_unlock_bh(&tn->nametbl_lock);
+
+	/* The link is congested after the list is inserted into
+	 * the link's send queue. Return 0, as this is normal.
+	 */
+	if (rc == -ELINKCONG)
+		rc = 0;
+	else if (rc == -EMSGSIZE)
+		rc = -ENOBUFS;
+
+	return rc;
 }
 
 /**
@@ -217,8 +311,8 @@ int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests++;
-	named_distribute(net, &head, dnode, &nt->cluster_scope, nt->snd_nxt);
-	if (!skb_queue_empty(&head))
+	rc = __tipc_named_distribute(net, dnode, &head);
+	if (!rc && !skb_queue_empty(&head))
 		rc = tipc_node_distribute(net, &head, dnode, &bearer_id, 0);
 	spin_unlock_bh(&tn->nametbl_lock);
 
@@ -289,10 +383,12 @@ void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
 static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 				u32 node, u32 dtype)
 {
+	struct tipc_net *tn = tipc_net(net);
 	struct publication *p = NULL;
 	u32 lower = ntohl(i->lower);
 	u32 upper = ntohl(i->upper);
 	struct tipc_socket_addr sk;
+	u32 type = ntohl(i->type);
 	u32 key = ntohl(i->key);
 	struct tipc_uaddr ua;
 
@@ -303,13 +399,22 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	if (lower > upper)
 		return false;
 
+	/* Not insert or remove duplicate node-up event publication sent from
+	 * remote nodes
+	 */
+	if (unlikely(type == TIPC_NODE_STATE && tn->node_addr &&
+		     lower == tn->node_addr && upper == tn->node_addr)) {
+		pr_warn_ratelimited("Can't update duplicate node-up pub\n");
+		return false;
+	}
+
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
-		   ntohl(i->type), lower, upper);
+		   type, lower, upper);
 	sk.ref = ntohl(i->port);
 	sk.node = node;
 
 	if (dtype == PUBLICATION) {
-		p = tipc_nametbl_insert_publ(net, &ua, &sk, key);
+		p = tipc_nametbl_insert_publ(net, &ua, &sk, key, NULL);
 		if (p) {
 			tipc_node_subscribe(net, &p->binding_node, node);
 			return true;
@@ -426,5 +531,6 @@ void tipc_named_reinit(struct net *net)
 	list_for_each_entry_rcu(p, &nt->cluster_scope, binding_node)
 		p->sk.node = self;
 	nt->rc_dests = 0;
+	tn->nt_stop = false;
 	spin_unlock_bh(&tn->nametbl_lock);
 }
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index 3f41e36efee3..2043096ae967 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -75,5 +75,6 @@ void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 void tipc_named_reinit(struct net *net);
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
 		      u32 addr, u16 capabilities);
+int tipc_named_distribute(struct net *net, u32 dnode);
 
 #endif
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 8924bdb6a443..3bcb8762bc9c 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -329,7 +329,7 @@ static struct service_range *tipc_service_create_range(struct tipc_service *sc,
 
 static bool tipc_service_insert_publ(struct net *net,
 				     struct tipc_service *sc,
-				     struct publication *p)
+				     struct publication *p, int *err)
 {
 	struct tipc_subscription *sub, *tmp;
 	struct service_range *sr;
@@ -339,10 +339,12 @@ static bool tipc_service_insert_publ(struct net *net,
 	bool res = false;
 	u32 key = p->key;
 
-	spin_lock_bh(&sc->lock);
 	sr = tipc_service_create_range(sc, p);
-	if (!sr)
+	if (!sr) {
+		if (err)
+			*err = -ENOBUFS;
 		goto  exit;
+	}
 
 	first = list_empty(&sr->all_publ);
 
@@ -353,6 +355,8 @@ static bool tipc_service_insert_publ(struct net *net,
 			pr_debug("Failed to bind duplicate %u,%u,%u/%u:%u/%u\n",
 				 p->sr.type, p->sr.lower, p->sr.upper,
 				 node, p->sk.ref, key);
+			if (err)
+				*err = -EEXIST;
 			goto exit;
 		}
 	}
@@ -371,7 +375,6 @@ static bool tipc_service_insert_publ(struct net *net,
 	if (!res)
 		pr_warn("Failed to bind to %u,%u,%u\n",
 			p->sr.type, p->sr.lower, p->sr.upper);
-	spin_unlock_bh(&sc->lock);
 	return res;
 }
 
@@ -478,20 +481,33 @@ static struct tipc_service *tipc_service_find(struct net *net,
 struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
-					     u32 key)
+					     u32 key, int *err)
 {
 	struct tipc_service *sc;
 	struct publication *p;
 
 	p = tipc_publ_create(ua, sk, key);
-	if (!p)
+	if (!p) {
+		if (err)
+			*err = -ENOBUFS;
 		return NULL;
+	}
 
 	sc = tipc_service_find(net, ua);
 	if (!sc)
 		sc = tipc_service_create(net, ua);
-	if (sc && tipc_service_insert_publ(net, sc, p))
-		return p;
+
+	if (sc) {
+		spin_lock_bh(&sc->lock);
+		if (tipc_service_insert_publ(net, sc, p, err)) {
+			spin_unlock_bh(&sc->lock);
+			return p;
+		}
+		spin_unlock_bh(&sc->lock);
+	} else if (err) {
+		*err = -ENOBUFS;
+	}
+
 	kfree(p);
 	return NULL;
 }
@@ -760,7 +776,8 @@ void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 /* tipc_nametbl_publish - add service binding to name table
  */
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key)
+					 struct tipc_socket_addr *sk,
+					 u32 key, int *err)
 {
 	struct name_table *nt = tipc_name_table(net);
 	u32 max_user_pub = TIPC_MAX_PUBL - 1;
@@ -768,6 +785,7 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 	struct publication *p = NULL;
 	struct sk_buff *skb = NULL;
 	bool protocol_type = false;
+	int error = 0;
 	u32 rc_dests;
 
 	if (ua->sr.type == TIPC_NODE_STATE || ua->sr.type == TIPC_LINK_STATE ||
@@ -788,7 +806,7 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 	}
 
 insert:
-	p = tipc_nametbl_insert_publ(net, ua, sk, key);
+	p = tipc_nametbl_insert_publ(net, ua, sk, key, &error);
 	if (p) {
 		/* Not count node state, link state and topology server types
 		 * so that maximum nt->local_publ_count does not prevent
@@ -798,6 +816,13 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 		if (!protocol_type)
 			nt->local_publ_count++;
 		skb = tipc_named_publish(net, p);
+		/* Local-scope publication is not published (skb is NULL), only
+		 * cluster-cope one is.
+		 */
+		if (!skb && p->scope == TIPC_CLUSTER_SCOPE && err)
+			*err = -ENOBUFS;
+	} else if ((error == -ENOBUFS) && err) {
+		*err = -ENOBUFS;
 	}
 	rc_dests = nt->rc_dests;
 exit:
@@ -809,6 +834,83 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 
 }
 
+/**
+ * tipc_nametb_insert_self_node_pub - insert publication of node's self address
+ * @net: network namespace
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
+ */
+int tipc_nametb_insert_self_node_pub(struct net *net)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+	struct tipc_socket_addr sk;
+	struct service_range *sr;
+	struct tipc_service *sc;
+	bool sc_created = false;
+	struct publication *p;
+	struct tipc_uaddr ua;
+	int err = 0;
+
+	sk.ref = 0;
+	sk.node = tn->node_addr;
+	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
+		   TIPC_NODE_STATE, tn->node_addr, tn->node_addr);
+	sc = tipc_service_find(net, &ua);
+	if (!sc) {
+		sc = tipc_service_create(net, &ua);
+		if (!sc)
+			return -ENOBUFS;
+		sc_created = true;
+	}
+
+	spin_lock_bh(&sc->lock);
+	sr = tipc_service_find_range(sc, &ua);
+	/* 1. tipc_net_finalize_work() is not scheduled because of namespace
+	 *    teardown.
+	 * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has failed
+	 *    to insert node self address publication into nt->cluster_scope
+	 *    due to memory allocation failure.
+	 * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
+	 *    executed yet.
+	 */
+	if (!sr) {
+		p = tipc_publ_create(&ua, &sk, tn->node_addr);
+		if (!p)
+			goto error;
+
+		if (!tipc_service_insert_publ(net, sc, p, &err)) {
+			kfree(p);
+			goto error;
+		}
+
+		list_add_tail(&p->binding_node, &nt->cluster_scope);
+		goto exit;
+error:
+		if (sc_created) {
+			hlist_del_init_rcu(&sc->service_list);
+			spin_unlock_bh(&sc->lock);
+			kfree_rcu(sc, rcu);
+			if (unlikely(err == -EEXIST))
+				return 0;
+			else
+				return -ENOBUFS;
+		}
+
+		spin_unlock_bh(&sc->lock);
+		if (unlikely(err == -EEXIST))
+			return 0;
+		else
+			return -ENOBUFS;
+	}
+exit:
+	spin_unlock_bh(&sc->lock);
+	return 0;
+}
+
 /**
  * tipc_nametbl_withdraw - withdraw a service binding
  * @net: network namespace
@@ -933,6 +1035,7 @@ int tipc_nametbl_init(struct net *net)
  */
 static void tipc_service_delete(struct net *net, struct tipc_service *sc)
 {
+	struct tipc_net *tn = tipc_net(net);
 	struct service_range *sr, *tmpr;
 	struct publication *p, *tmp;
 
@@ -940,6 +1043,15 @@ static void tipc_service_delete(struct net *net, struct tipc_service *sc)
 	rbtree_postorder_for_each_entry_safe(sr, tmpr, &sc->ranges, tree_node) {
 		list_for_each_entry_safe(p, tmp, &sr->all_publ, all_publ) {
 			tipc_service_remove_publ(sr, &p->sk, p->key);
+			/* tipc_nametbl_withdraw() does not delete
+			 * 'p->binding_node' with type TIPC_NODE_STATE and
+			 * range [tn->node_addr, tn->node_addr] from
+			 * 'tn->cluster_scope'. So, delete it here.
+			 */
+			if (p->sr.type == TIPC_NODE_STATE &&
+			    p->sr.lower == tn->node_addr &&
+			    p->sr.upper == tn->node_addr)
+				list_del(&p->binding_node);
 			kfree_rcu(p, rcu);
 		}
 		rb_erase_augmented(&sr->tree_node, &sc->ranges, &sr_callbacks);
@@ -970,6 +1082,8 @@ void tipc_nametbl_stop(struct net *net)
 			tipc_service_delete(net, service);
 		}
 	}
+	tn->nt_stop = true;
+	tn->nt_self_node_exist = false;
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	/* TODO: clear tn->nametbl, implement proper RCU rules ? */
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index afe665e68bb1..4b411b6e9e40 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -124,13 +124,15 @@ bool tipc_nametbl_lookup_group(struct net *net, struct tipc_uaddr *ua,
 void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 			      struct tipc_uaddr *ua);
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key);
+					 struct tipc_socket_addr *sk,
+					 u32 key, int *err);
 void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 			   struct tipc_socket_addr *sk, u32 key);
 struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
-					     u32 key);
+					     u32 key, int *err);
+int tipc_nametb_insert_self_node_pub(struct net *net);
 struct publication *tipc_nametbl_remove_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..6e8bf0c5ebde 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -110,11 +110,14 @@ static void tipc_net_finalize(struct net *net, u32 addr);
 
 int tipc_net_init(struct net *net, u8 *node_id, u32 addr)
 {
+	struct tipc_net *tn = tipc_net(net);
+
 	if (tipc_own_id(net)) {
 		pr_info("Cannot configure node identity twice\n");
 		return -1;
 	}
 	pr_info("Started in network mode\n");
+	atomic_set(&tn->node_addr_set, 0);
 
 	if (node_id)
 		tipc_set_node_id(net, node_id);
@@ -138,7 +141,11 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr);
+	atomic_set(&tn->node_addr_set, 1);
+	/* Redistribute the node state publication via node-up event
+	 * or node's timer if tipc_nametbl_publish() fails.
+	 */
+	tipc_nametbl_publish(net, &ua, &sk, addr, NULL);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index b19d6652dc73..f566472a411f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -111,6 +111,7 @@ struct tipc_bclink_entry {
  * @peer_net: peer's net namespace
  * @peer_hash_mix: hash for this peer (FIXME)
  * @crypto_rx: RX crypto handler
+ * @dist_bulk: flag to redistribute cluster-scope publications
  */
 struct tipc_node {
 	u32 addr;
@@ -145,6 +146,7 @@ struct tipc_node {
 #ifdef CONFIG_TIPC_CRYPTO
 	struct tipc_crypto *crypto_rx;
 #endif
+	bool dist_bulk;
 };
 
 /* Node FSM states and events:
@@ -393,6 +395,14 @@ static void tipc_node_write_unlock_fast(struct tipc_node *n)
 	write_unlock_bh(&n->lock);
 }
 
+static void tipc_node_down(struct tipc_node *n)
+{
+	int bearer_id;
+
+	for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++)
+		tipc_node_link_down(n, bearer_id, false);
+}
+
 static void tipc_node_write_unlock(struct tipc_node *n)
 	__releases(n->lock)
 {
@@ -402,7 +412,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
-	int rc = 0;
+	int rc = 0, err = 0;
 
 	if (likely(!flags)) {
 		write_unlock_bh(&n->lock);
@@ -420,6 +430,8 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	n->action_flags &= ~(TIPC_NOTIFY_NODE_DOWN | TIPC_NOTIFY_NODE_UP |
 			     TIPC_NOTIFY_LINK_DOWN | TIPC_NOTIFY_LINK_UP);
 
+	if (flags & TIPC_NOTIFY_NODE_DOWN)
+		n->dist_bulk = false;
 	write_unlock_bh(&n->lock);
 
 	if (flags & TIPC_NOTIFY_NODE_DOWN)
@@ -430,17 +442,35 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 
 	if (flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
-		tipc_nametbl_publish(net, &ua, &sk, sk.ref);
+		tipc_nametbl_publish(net, &ua, &sk, sk.ref, &err);
 	}
 	if (flags & TIPC_NOTIFY_LINK_DOWN) {
 		tipc_mon_peer_down(net, node, bearer_id);
 		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
 	}
 
+	/* Memory allocation has failed. Bring the node down to start over bulk
+	 * distribution when the first link is up again.
+	 */
 	if (rc == -ENOBUFS)
+		tipc_node_down(n);
+	else if (err == -ENOBUFS)
 		tipc_node_link_down(n, bearer_id, false);
 }
 
+void tipc_node_set_dist_bulk(struct net *net, u32 addr)
+{
+	struct tipc_node *node;
+
+	node = tipc_node_find(net, addr);
+	if (node) {
+		tipc_node_write_lock(node);
+		node->dist_bulk = true;
+		tipc_node_write_unlock_fast(node);
+		tipc_node_put(node);
+	}
+}
+
 static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
 {
 	int net_id = tipc_netid(n->net);
@@ -568,6 +598,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	n->dist_bulk = false;
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
@@ -807,9 +838,11 @@ static void tipc_node_timeout(struct timer_list *t)
 	struct tipc_node *n = timer_container_of(n, t, timer);
 	struct tipc_link_entry *le;
 	struct sk_buff_head xmitq;
-	int remains = n->link_cnt;
+	bool dist_bulk = false;
+	int remains = 0;
+	int dist_rc = 0;
 	int bearer_id;
-	int rc = 0;
+	int rc;
 
 	trace_tipc_node_timeout(n, false, " ");
 	if (!node_is_up(n) && tipc_node_cleanup(n)) {
@@ -824,13 +857,23 @@ static void tipc_node_timeout(struct timer_list *t)
 #endif
 	__skb_queue_head_init(&xmitq);
 
+	tipc_node_write_lock(n);
 	/* Initial node interval to value larger (10 seconds), then it will be
 	 * recalculated with link lowest tolerance
 	 */
-	tipc_node_read_lock(n);
 	n->keepalive_intv = 10000;
-	tipc_node_read_unlock(n);
+
+	remains = n->link_cnt;
+	if (n->dist_bulk) {
+		dist_bulk = true;
+		n->dist_bulk = false;
+	}
+	tipc_node_write_unlock_fast(n);
+	if (dist_bulk)
+		dist_rc = tipc_named_distribute(n->net, n->addr);
+
 	for (bearer_id = 0; remains && (bearer_id < MAX_BEARERS); bearer_id++) {
+		rc = 0;
 		tipc_node_read_lock(n);
 		le = &n->links[bearer_id];
 		if (le->link) {
@@ -839,11 +882,13 @@ static void tipc_node_timeout(struct timer_list *t)
 			tipc_node_calculate_timer(n, le->link);
 			rc = tipc_link_timeout(le->link, &xmitq);
 			spin_unlock_bh(&le->lock);
-			remains--;
+			if (dist_rc != -ENOBUFS)
+				remains--;
 		}
 		tipc_node_read_unlock(n);
 		tipc_bearer_xmit(n->net, bearer_id, &xmitq, &le->maddr, n);
-		if (rc & TIPC_LINK_DOWN_EVT)
+		/* Force the node down in case the redistribution failed */
+		if ((rc & TIPC_LINK_DOWN_EVT) || dist_rc == -ENOBUFS)
 			tipc_node_link_down(n, bearer_id, false);
 	}
 	mod_timer(&n->timer, jiffies + msecs_to_jiffies(n->keepalive_intv));
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 775a8ec240fb..b312cefd4d41 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -130,4 +130,5 @@ int tipc_nl_node_set_key(struct sk_buff *skb, struct genl_info *info);
 int tipc_nl_node_flush_key(struct sk_buff *skb, struct genl_info *info);
 #endif
 void tipc_node_pre_cleanup_net(struct net *exit_net);
+void tipc_node_set_dist_bulk(struct net *net, u32 addr);
 #endif
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 65cc0c4964b3..4f204bdcaf21 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2929,7 +2929,7 @@ static int tipc_sk_publish(struct tipc_sock *tsk, struct tipc_uaddr *ua)
 		return -EADDRINUSE;
 	skaddr.ref = tsk->portid;
 	skaddr.node = tipc_own_addr(net);
-	p = tipc_nametbl_publish(net, ua, &skaddr, key);
+	p = tipc_nametbl_publish(net, ua, &skaddr, key, NULL);
 	if (unlikely(!p))
 		return -EINVAL;
 
-- 
2.53.0

