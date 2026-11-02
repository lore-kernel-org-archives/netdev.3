Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793591017;
	b=NBSNyaOhak1QK+uzD8i0OUhvMyCP3UqdvCoESy3t8FHZgC9aNN2D7hULwjtWNNX0cPEx
	 thSAdxNph0qh2QoPaNDZ1lYBjIqEDm3uLC1KDFd34OSVuCRB7oZ0+eNDcFUYPJ9Lenfo9
	 RMXAx3SqGUofW1SQ8ZpuOUX9N/9wlPwMaIFZWmvMNzOiPWuiEBLMH/ZEzHsPmaBx9mTNW
	 DJEIeu+rQ4/F1abn+8QyTKsIxWWYZ1M7Gm8K2rXDaig0c2lhU5uWMOscBnQUOMML/DeTX
	 Czcv27rhrIyB3hFXZOlj0azTxGPsWYDKAKGsxv5yAknUTTU9bNgNPlEzXq2Ar30hLJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591017;
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
	bh=Kg/C0/vpyOdl1NeShE1i/xc7/8+2gaXFZrh6B8vMIc0=;
	b=PrGXRa/f+kIwtdxxWu8BYjx07j/oF02/arOcG1xxQzp+RDWzX0OxGPJGTy0SWTw/3CKj
	 qwhscVCr6gdt6YhRYdWYXcIJIeH4iiJ1N/tgO7ZqqsqcfoUG0PSRvxirUM1C8uiV5qYlT
	 j7nwKuzQbO8EYd09N8Bc/tPJ7V2iM89rGqnwvnOwV0dzJLPV9x5+v7P+L4yOk3aijfp7s
	 H8SvmYDC5XFp0tmx37axnhZpUkXO0S9l4bO/KLSLc1sclHEo4eEgxnv9vArBoII3lbAL/
	 ZUfQekiaOxbwAvUY2iZ1gxR/sGygssf9rVYrkBAXysVFHMEnnUr4UOo3DwsWFeQwXWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b="z/AOe7f4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.5
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41C606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A41C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=z/AOe7f4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sypgsUMfA5XTPCiU/ZXZkWx9+jB977kHLfTkw2/d42zdVOQzwA8qNm8ZgMk1CpL1SKXHJ/imi9vFf1jQ0NWsvgsPFRZGfzPnN0pXqmhrP8hV4pZQ38yaOsh1uF3Y8kx/5k0QfkuHcuPwqhKUtgBy3+iOkadSAii9JTU0cVz50DDarV57/HoSRYWDO795VYBAbQbsd0l2kseZ5vwFEydba8KdwtBO99cWgPCKfBypcE6kwkB/jC73glXhilp+JUaOEnIyVmyCOZd68468pPposlv6XQP8v2PbZRdYtQOwoeRxIMHMFEWozVhXI8grGdIHapanzkNR1NqQlCKLlclEfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kg/C0/vpyOdl1NeShE1i/xc7/8+2gaXFZrh6B8vMIc0=;
 b=yczrEwq49OuTsUKotECu3yqvU2zXt5m7cK4A7j3XKI1ZJ7c8CP6wnqfhefcQcdKzodnWjVLaS0Kz3YzF6JEt95zw+kw6e9hijdgEAGn8K4Se+l9dvzRLr4mVRelGIpmguYy7kAnPf7p26umks0wolCITILqt/5CzJjh3F45EuY/zsJRfFei398aCVetIrOVOxXZcUv29AFhlZhmG6B83uLgKblxDVDA4+ZqFns2uYt5msTRxTxdQNcJsn2rtwbkfMzbZB9ifEPmUbqJcyfBE9lAejF8HTG0s7Y9npQ0pIgQc7A8cIVku82j+ID2+AgKjHtU54cvrL/gBdE5da0XyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kg/C0/vpyOdl1NeShE1i/xc7/8+2gaXFZrh6B8vMIc0=;
 b=z/AOe7f4MOljt0w007AgAwSGPpJVlfLcBZH5Lr1Hdj8Pj7Eh//EooQ5RL0e72ir77yADwdPNa6VBz+sj7x9r2h4QQ0mRo8sHdqNv8TyiS482MjUNpJ8NF3wbFYUmkGMdhWQ85/854udIbFDBBeQOMZV7IYnchVITaaokzrO7FJDeDRiTMEBoY5+Ss3zYrs72uL4xw9ZaQZdSrmrqt/P3fe0N/zfXqdfujkCcktcjdka/xBH0pXmrSmK/tzfDe7no2Mfpm//l8oGMu8XpjY+wnD6xAfFYkUWc08gwzJp/C/1lCfs27gtGGW29zyGZS9Lymr6QixNavEMOBCmYHEXx6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA1P189MB3491.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:43:33 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:43:33 +0000
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
Subject: [PATCH net v2 6/6] tipc: fix NULL pointer dereference in named_distribute()
Date: Mon,  2 Nov 2026 10:40:32 +0700
Message-ID: <20261102034207.10639-7-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
References: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:990:5::16) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 1cfb0897-8098-44c7-7c0a-08df389377d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	L7U2gNuEhIMF0yPOheX27Rhzjf45hIahMqFaGsbe/4tnEcveFCVFewdqDSe8QiW+seeFDfP8Kx5Tgqzk++gZR8Od/SSWDOnZUPWAlsUB7jGjpHTFytEslA27hDqB5ZXZAQ9uCp9fsbNaFRKR8t6UsAweewQCQxaHMhc5inzidTwgPBJWm/61HQa3Y8aH4SlhaZxkjL3USqS9zGjiPNUFfQhN8NZG1OWiUoBImyW7hAywHKbvGXcKKyMYadndRkp87bPl1HYs8b5eRvWqhrxD0aasqlAzSGl0d3mYtYIiU3cT5KQlfrRlLOzkIS1lQdLHLTLSt2v4SgyPGRcScWFrvMs306d7o/TyW1aCA++XDH1MJ2N0Kiwvi99ap/JuHicYqUFpf4asT3lbWsNJksgoYDNaOhHSopP7hzC1Qhnf63eBXMf/PBmhSCytHrLAIMrRugYCTzAaMzlD1nu8A6sh4sZBmNOY0GwxD8DWKn2qe1S0VlEHehOnQ4gTsXlkSm4S9fTsndALj/JPqAduu7W/ZbPQhRMqREBATXwhngmlWhhuXYHa73tRd8rGg9liTzxnQxo1tMwpOmiHgkmUkKzkutVpkYgttYYPFg39yPXk5EDE1aQ+OzwHEkjogW4i1z2A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YkI0AutPue+TaCNKyLdNQN6UKFEmb9ttUi/llhOODH3NLvdQCgRK5ItSeD82?=
 =?us-ascii?Q?365n3hZMx+wzh8bEXeaYFlgMIquukbSeCAmDkqJlqomvIhJ/DEdw1CJN7mBr?=
 =?us-ascii?Q?gYSiIU5tOPSSbxJGwtb/H9/7qu8eo/sC2+4NjbI5VNsPprvTp0QvFuYgNF+D?=
 =?us-ascii?Q?9MP3DQnIzJsa2Bd5qxWYZ50neZTkZPexfCAjsrRGqkJ7aPR1GMuy0DLPLQxw?=
 =?us-ascii?Q?8O+Xr7D2IMpOXkkDHhfrvRJcXtVOKvgGBT+qNJbDpCL3gMdq4m9T9DO+AJmu?=
 =?us-ascii?Q?NJ6EQ7egFQtBfPZtDtKlo/cceewU3JojTjoiCmPNF2rB4EAoPxKqY9DRfEct?=
 =?us-ascii?Q?NcDDByHsIiCxdM+zDmQ1V0Sofv+Upr1unkYbtXUv4v9OOel1d5LC3PCBNWx7?=
 =?us-ascii?Q?tpdcKgA9FZZqspD9XqX9bIX9GpmJb44b7EgJdcG4nsjzuf8gSA81zfKmCchi?=
 =?us-ascii?Q?hcRx4efKJ4kOTgoFSQJW8jSNoSdg2SnYi2f8ac4iOMdq5/9i3qT96jJqv/h9?=
 =?us-ascii?Q?FZ7PjfPbBWHfDYDUyGY+tnIT1U17lqKad4/GnfyD5YgouxQc2lW8fAdfdQLX?=
 =?us-ascii?Q?xmcvShdm7aglmT2R5IhwfG1PQR430mWJsvip8QreiT88b+NC5iU2Kjwg8Jp1?=
 =?us-ascii?Q?x/XkMyRIZfBcsxsyq+85IPhxuP76+YcGLd6CtMgxlJJ2yFBEDRV1UpOkeL1N?=
 =?us-ascii?Q?vWG2OMbBis6JMwAX/nj742H672tMTGtarxwauGOADFdbVahfUGsgxtSsXIIa?=
 =?us-ascii?Q?eJETjGy5qn0tEFw+UblfZsky5UvQcFaCDzi36Zuyybj2flywMaY6yKXDHedJ?=
 =?us-ascii?Q?qhevAOUV4Zap6UMxC1cNLHNFL4zFi0L8ww6z/up1gsUKmGyW5DZKjiDXkjCA?=
 =?us-ascii?Q?gKAV64DN5UBlLR8VantKnlfI93qwowREgq3lwun0oY9PovDaPc8xX1ZIbXO0?=
 =?us-ascii?Q?1J1uQ8gkwAfjhFpGajNaSxm9uwUVAnijMjev/x9Cu6HzJnmnDXprwZGru+vl?=
 =?us-ascii?Q?g8ygKVIztziGbgGlOu5RG59WSjYXIEcFDaNMjiuAC894V/kVLghZNCiblZtM?=
 =?us-ascii?Q?Y0kxxNsRiWNowGwmSHUQrZV86Jg+BartFOobLqIqk/axqdby3DwUZg2gJ6ES?=
 =?us-ascii?Q?n1x9hho0XcvDtUCKg3ydwwtpCCk9RI6H1jKiETVjC6RO9fla7Dcjw04KZUEw?=
 =?us-ascii?Q?QNR2xXbKFoz3+erR5+IbneG0zBur5KxqEPIbu+QCUXPVa7gVseYM677Mlq84?=
 =?us-ascii?Q?mkge+eycozdInsCzyNpi4FJVS+EwNO5KuZ0qgvNOPRPn4dr95ycPgJV0w4/R?=
 =?us-ascii?Q?NOFgE7h5Uuo4bUZ8yKfZQN9Qhg0Hl0cDfsCj1IPswD1Cau5OQ3o2jTXBZcyS?=
 =?us-ascii?Q?WaiJ73KixpJPGAlVZMOIK1yAmghnsfu6LYB0bk7GQW7wQNRmqxb0hVaw+9Xm?=
 =?us-ascii?Q?QjfUe+7QzPkWAHMMTeBRYOKYifh37hqHNoqmhDWh2WjHKsQWUbf4R79WAWdV?=
 =?us-ascii?Q?dAiYC+XO/ioyv/2SnJpPzPVecBAVLrkl3Bifvm1CYrmZnmkKNaUM2W5+JTk/?=
 =?us-ascii?Q?ogse5o7xXBqSMjcGVSHM/j8uYbv4qpUhSdN1AP9mdw29hf6BzzvvuiuNA0pR?=
 =?us-ascii?Q?xSN2g9adCguhTOZ+hqFIfQfNG1t1CQXbBe54c9XmR7Z5+VgkKyBnh8btfQjW?=
 =?us-ascii?Q?ZWopEHmGq+UXRk7/sTZ2mA/yu06vu1LbYW6rDCdz9b8Rq5FzsTPJ+LUfsaTh?=
 =?us-ascii?Q?P1u5w0OOTfZ+nxUl6PR7VlS3BVrW4NGPEaro/2IMI46T3wkF9l2hiMQbbXfZ?=
X-MS-Exchange-AntiSpam-MessageData-1: Buw8Rk+Cf8fLFKSGbksel0bqFH3icf4AZ3A=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfb0897-8098-44c7-7c0a-08df389377d4
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:43:33.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SGBU2AIfeZ6Z3BznKpqvvMOcZgDTIFdAuHR0p3n0uGJQ+KY9gd5Yze3RblB9+aMkIsqZczY6jNObCG/WaeuyLrjPpmjfPJQi9oD9D+n4O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3491

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
(Thread 2), list will be empty. As a result, NULL is passed to 'buf_msg()',
leading to a NULL pointer dereference.

Fix the this issue by checking for the node's self-address publication on
either node-up or node-timeout event. If the publication does not exist, insert
it into the name table and publish it to the other nodes.

Reported-by: syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=64197f7577a09686ffdb
Fixes: adba75be0d23 ("tipc: fix lockdep warning when reinitilaizing sockets")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v2: Set node->dist_bulk to true when the node comes up, remove an unnecessary
    publication insertion in tipc_update_nametbl().
v1: https://lore.kernel.org/netdev/20261028033722.125477-3-tung.quang.nguyen@est.tech/

 net/tipc/core.c       |  1 +
 net/tipc/core.h       |  2 +
 net/tipc/name_distr.c | 93 ++++++++++++++++++++++++++++++++++++++++---
 net/tipc/name_distr.h |  1 +
 net/tipc/name_table.c | 86 +++++++++++++++++++++++++++++++++------
 net/tipc/name_table.h |  4 ++
 net/tipc/net.c        | 19 ++++++++-
 net/tipc/node.c       | 52 ++++++++++++++++++++----
 net/tipc/node.h       |  1 +
 9 files changed, 231 insertions(+), 28 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 315975c3be81..351ced173866 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -61,6 +61,7 @@ static int __net_init tipc_init_net(struct net *net)
 	tn->trial_addr = 0;
 	tn->addr_trial_end = 0;
 	tn->capabilities = TIPC_NODE_CAPABILITIES;
+	tn->nt_self_node_exist = false;
 	INIT_WORK(&tn->work, tipc_net_finalize_work);
 	memset(tn->node_id, 0, sizeof(tn->node_id));
 	memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..8f5a94dbc1fc 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,8 @@ struct tipc_net {
 	struct work_struct work;
 	/* The numbers of work queues in schedule */
 	atomic_t wq_count;
+	/* Node's self address publication is available in the name table */
+	bool nt_self_node_exist;
 };
 
 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 82684bc7399a..cc0c17a67863 100644
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
@@ -191,6 +197,82 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
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
+	/* Node's self-address is not set yet */
+	if (!tipc_own_addr(net)) {
+		/* Defer the distribution to node's timer */
+		tipc_node_set_dist_bulk(net, dnode);
+		return 0;
+	}
+
+	/* Node's self-address publication does not exist */
+	if (!tn->nt_self_node_exist) {
+		if (tipc_nametb_insert_self_node_pub(net))
+			return -ENOBUFS;
+
+		tn->nt_self_node_exist = true;
+	}
+
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
+ * * -EMSGSIZE       - Message's size is too big
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
+
+	return rc;
 }
 
 /**
@@ -219,8 +301,9 @@ int tipc_named_node_up(struct net *net, u32 dnode,
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests++;
-	named_distribute(net, &head, dnode, &nt->cluster_scope, nt->snd_nxt);
-	if (!skb_queue_empty(&head))
+
+	rc = __tipc_named_distribute(net, dnode, &head);
+	if (!rc && !skb_queue_empty(&head))
 		rc = tipc_node_distribute(net, &head, dnode, bearer_id, 0);
 	spin_unlock_bh(&tn->nametbl_lock);
 
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index 767f9f69624d..6bec8b2100c1 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -76,5 +76,6 @@ void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 void tipc_named_reinit(struct net *net);
 void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
 		      u32 addr, u16 capabilities);
+int tipc_named_distribute(struct net *net, u32 dnode);
 
 #endif
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 739450204e5e..206fcbef8d61 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -374,8 +374,8 @@ static bool tipc_service_insert_publ(struct net *net,
 	res = true;
 exit:
 	if (!res)
-		pr_warn("Failed to bind to %u,%u,%u\n",
-			p->sr.type, p->sr.lower, p->sr.upper);
+		pr_warn_ratelimited("Failed to bind to %u,%u,%u\n",
+				    p->sr.type, p->sr.lower, p->sr.upper);
 	spin_unlock_bh(&sc->lock);
 	return res;
 }
@@ -772,26 +772,34 @@ void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 	rcu_read_unlock();
 }
 
-/* tipc_nametbl_publish - add service binding to name table
+/**
+ * tipc_nametbl_insert - insert service binding into name table
+ * @net: network namespace
+ * @ua: the service range is binding to
+ * @sk: address publishing socket
+ * @key: target publication key
+ * @skb: buffer containing the publication
+ * @err: error code
+ *
+ * Return:
+ * * 0          - Success
+ * * -ENOBUFS   - No buffer space is available
+ *
  */
-struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk,
-					 u32 key, int *err)
+struct publication *tipc_nametbl_insert(struct net *net, struct tipc_uaddr *ua,
+					struct tipc_socket_addr *sk, u32 key,
+					struct sk_buff **skb, int *err)
 {
 	struct name_table *nt = tipc_name_table(net);
 	u32 max_user_pub = TIPC_MAX_PUBL - 1;
-	struct tipc_net *tn = tipc_net(net);
 	struct publication *p = NULL;
-	struct sk_buff *skb = NULL;
 	bool protocol_type = false;
 	int error = 0;
-	u32 rc_dests;
 
 	if (ua->sr.type == TIPC_NODE_STATE || ua->sr.type == TIPC_LINK_STATE ||
 	    ua->sr.type == TIPC_TOP_SRV)
 		protocol_type = true;
 
-	spin_lock_bh(&tn->nametbl_lock);
 	if (protocol_type)
 		goto insert;
 
@@ -814,24 +822,76 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 		 */
 		if (!protocol_type)
 			nt->local_publ_count++;
-		skb = tipc_named_publish(net, p);
+		*skb = tipc_named_publish(net, p);
 		/* Local-scope publication is not published (skb is NULL).
 		 * For cluster-cope one, skb is NULL when named_prepare_buf()
 		 * returns NULL in tipc_named_publish().
 		 */
-		if (!skb && p->scope == TIPC_CLUSTER_SCOPE && err)
+		if (!*skb && p->scope == TIPC_CLUSTER_SCOPE && err)
 			*err = -ENOBUFS;
 	} else if ((error == -ENOBUFS) && err) {
 		*err = -ENOBUFS;
 	}
-	rc_dests = nt->rc_dests;
 exit:
+	return p;
+}
+
+/* tipc_nametbl_publish - add service binding to name table
+ */
+struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
+					 struct tipc_socket_addr *sk,
+					 u32 key, int *err)
+{
+	struct name_table *nt = tipc_name_table(net);
+	struct tipc_net *tn = tipc_net(net);
+	struct publication *p = NULL;
+	struct sk_buff *skb = NULL;
+	u32 rc_dests;
+
+	spin_lock_bh(&tn->nametbl_lock);
+	p = tipc_nametbl_insert(net, ua, sk, key, &skb, err);
+	rc_dests = nt->rc_dests;
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	if (skb)
 		tipc_node_broadcast(net, skb, rc_dests);
 	return p;
+}
+
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
+	struct publication *p = NULL;
+	struct tipc_socket_addr sk;
+	struct tipc_uaddr ua;
+	int err = 0;
+
+	sk.ref = 0;
+	sk.node = tn->node_addr;
+	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
+		   TIPC_NODE_STATE, tn->node_addr, tn->node_addr);
+
+	p = tipc_nametbl_insert_publ(net, &ua, &sk, tn->node_addr, &err);
+
+	if (p) {
+		list_add_tail(&p->binding_node, &nt->cluster_scope);
+		return 0;
+
+	} else if (err == -EEXIST) {
+		return 0;
+	}
 
+	return -ENOBUFS;
 }
 
 /**
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index a66975ef8546..4d421548705c 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -123,6 +123,9 @@ bool tipc_nametbl_lookup_group(struct net *net, struct tipc_uaddr *ua,
 			       u32 exclude, bool mcast);
 void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 			      struct tipc_uaddr *ua);
+struct publication *tipc_nametbl_insert(struct net *net, struct tipc_uaddr *ua,
+					struct tipc_socket_addr *sk, u32 key,
+					struct sk_buff **skb, int *err);
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 					 struct tipc_socket_addr *sk,
 					 u32 key, int *err);
@@ -132,6 +135,7 @@ struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
 					     u32 key, int *err);
+int tipc_nametb_insert_self_node_pub(struct net *net);
 struct publication *tipc_nametbl_remove_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
diff --git a/net/tipc/net.c b/net/tipc/net.c
index c4b274320c9c..c15d8ecf784d 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -125,9 +125,14 @@ int tipc_net_init(struct net *net, u8 *node_id, u32 addr)
 
 static void tipc_net_finalize(struct net *net, u32 addr)
 {
-	struct tipc_net *tn = tipc_net(net);
+	struct name_table *nt = tipc_name_table(net);
 	struct tipc_socket_addr sk = {0, addr};
+	struct tipc_net *tn = tipc_net(net);
+	struct sk_buff *skb = NULL;
+	struct publication *p;
 	struct tipc_uaddr ua;
+	u32 rc_dests;
+	int err = 0;
 
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
 		   TIPC_NODE_STATE, addr, addr);
@@ -138,7 +143,17 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr, NULL);
+	spin_lock_bh(&tn->nametbl_lock);
+	if (!tn->nt_self_node_exist)
+		p = tipc_nametbl_insert(net, &ua, &sk, addr, &skb, &err);
+
+	if (p || err == -EEXIST)
+		tn->nt_self_node_exist = true;
+	rc_dests = nt->rc_dests;
+	spin_unlock_bh(&tn->nametbl_lock);
+
+	if (skb)
+		tipc_node_broadcast(net, skb, rc_dests);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 95f4284cc434..50d26f537599 100644
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
@@ -421,6 +423,8 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	n->action_flags &= ~(TIPC_NOTIFY_NODE_DOWN | TIPC_NOTIFY_NODE_UP |
 			     TIPC_NOTIFY_LINK_DOWN | TIPC_NOTIFY_LINK_UP);
 
+	if (flags & TIPC_NOTIFY_NODE_DOWN)
+		n->dist_bulk = false;
 	write_unlock_bh(&n->lock);
 
 	if (flags & TIPC_NOTIFY_NODE_DOWN)
@@ -438,8 +442,12 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
 	}
 
-	if (rc == -ENOBUFS)
-		tipc_node_link_down(n, bearer, false);
+	if (rc == -ENOBUFS) {
+		/* Force the node down to retry distribution */
+		for (bearer = 0; bearer < MAX_BEARERS; bearer++)
+			tipc_node_link_down(n, bearer, false);
+		return;
+	}
 
 	if (err == -ENOBUFS) {
 		if (rc == -ENOBUFS && bearer == bearer_id)
@@ -449,6 +457,20 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	}
 }
 
+void tipc_node_set_dist_bulk(struct net *net, u32 addr)
+{
+	struct tipc_node *node;
+
+	node = tipc_node_find(net, addr);
+	if (node) {
+		tipc_node_write_lock(node);
+		if (node_is_up(node))
+			node->dist_bulk = true;
+		tipc_node_write_unlock_fast(node);
+		tipc_node_put(node);
+	}
+}
+
 static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
 {
 	int net_id = tipc_netid(n->net);
@@ -576,6 +598,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 	INIT_LIST_HEAD(&n->list);
 	INIT_LIST_HEAD(&n->publ_list);
 	INIT_LIST_HEAD(&n->conn_sks);
+	n->dist_bulk = false;
 	skb_queue_head_init(&n->bc_entry.namedq);
 	skb_queue_head_init(&n->bc_entry.inputq1);
 	__skb_queue_head_init(&n->bc_entry.arrvq);
@@ -815,9 +838,11 @@ static void tipc_node_timeout(struct timer_list *t)
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
@@ -832,13 +857,22 @@ static void tipc_node_timeout(struct timer_list *t)
 #endif
 	__skb_queue_head_init(&xmitq);
 
+	tipc_node_write_lock(n);
 	/* Initial node interval to value larger (10 seconds), then it will be
 	 * recalculated with link lowest tolerance
 	 */
-	tipc_node_read_lock(n);
 	n->keepalive_intv = 10000;
-	tipc_node_read_unlock(n);
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
@@ -847,11 +881,13 @@ static void tipc_node_timeout(struct timer_list *t)
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
-- 
2.53.0

