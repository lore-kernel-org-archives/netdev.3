Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6F3E5A07;
	Fri, 17 Jul 2026 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281696; cv=fail; b=BVGXcSRffi/5aymRVKCgy4MvJDKdebMQpGyoPJzsfVTNT+BrSVUmMxu1rEeLeuCUn4b0UXNlRFVT2bzoNeeJ4gk2SrEaBhOSIZ1NFvhWEjJ0pSV67pokV0SA/7oH59vZgR2pYb+L7BFLiN9O37HvjD0vMaRwhWoqvs6Uhm8a8ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281696; c=relaxed/simple;
	bh=cEsmPqCVpLOtHvzj1zrN9x7ZfdkajjLuN0SCltXRNQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mCsi79eA/SKX2i7bwjGFgDBbBzOwncpy9ihxRnb/2AMTDD2k2OY25SaBMCigWCB4ou2IUqT3AtUKUqzYwfGftjbUhNveGrlAo2sPU9V7smMzI9obkc+LzigvNW1+Y/846WN64zWCpRVOl0eHNU6aHkXlc6VV7xd7NR4u8OyByQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=faYEeGff; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="faYEeGff"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nET8hniWpjxRspKUXmopUXU37hfMy6sqPF6dXMErE6nXwQfZYkxqR9IIz51mmZw0DTc+uFmsDDjma0FFxXBAoWEFsfGmZ/c6OQquiy2JdVFxCFB+ZT6/fE6fp6QjH/hLhwZGprLY0RfYME6qkO9S7V6Md4VbZUY6fxKWGjD5NTUtabiG5DfsGD2ybExN3fkEgJKpuXopi5rdHukqK5SaA5XeTyja9PIO/aVY4BbdKrKNvaDZPlMjrGU+asD672/IpW8RrtRW/+sfPKc4TV3yRReEpQNjNDnZR8qXZMI9QR6AyEb0r99hANbhiieimssN9IJjPVgzb2evrPglqATspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBXl5OGGenAEhnd6MZ90b0wuWprTNWp5+KDvv01bXQA=;
 b=oQMZY+8fu3eS4NQUnmAk+bUCrJjuYC5DjtGXp0AJrIjaZrb6F5uyiRA5F5lgFqIsFZX/e7Em+XfFHhUIlXRrXtu5jIZl3AfAAb1cd+gHyw6KkD29oQb0/Nh4c7r1npyHjIadWtIgDoM1MIiS6TDpGp9mWDdgARIWHDFYGjbukFgS2xudoYUWTxhsil6byKGpaUdObaKOb/pCVfGQBY6AOUqKhSyZkv0AJNyU/RziNTwIUi0bN8qbyq8le2Hy3eWK51nDhOV6/SpVaT7ENeyh/V+vkypq9nOUlGz/atN2c1m4qTHa04RY8SzH5Ji7OpXNovJPo+VqgRhoos+iNoquAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBXl5OGGenAEhnd6MZ90b0wuWprTNWp5+KDvv01bXQA=;
 b=faYEeGffCmY43qm743TCA9GL3H4luJn81cvwhzrSZSB99nMRNx39YqB17kbEPYGmlJC6JwTHbRoMwvgKqS7XvpTiCy8a+ksEpwrePpYhmdiDrrZraZ7sXSeZWFPlh/2tgKPzdw8FMv9LzN07bAKEESJBcJGpMePu3lNnBKaREsxsngR+NG4bwHCJENAOnAGEBzaADLcUqD4WbMRykiLKsVnTydkwKjKwah4mr0CG+YZuuc4WN+2LxfldEb/KkkQym9XXVImrkxTicQCc7LAqlbQ+nhsDWb8u8de3UXbu7/ZXE0bG76s8gl9vnSu17yJL0NGgwNmURuVrenr/VkVOUA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM4P189MB3433.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.4; Fri, 17 Jul 2026 09:48:10 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.003; Fri, 17 Jul 2026
 09:48:10 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "xmei5@asu.edu" <xmei5@asu.edu>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Topic: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Index: AQHdFVZMIeC0jDih+kSeOBc8miUklbZxbulg
Date: Fri, 17 Jul 2026 09:48:10 +0000
Message-ID:
 <GV1P189MB1988F91A48BC981B816C2700C6C62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260716190204.100895-2-bestswngs@gmail.com>
 <20260716190204.100895-4-bestswngs@gmail.com>
In-Reply-To: <20260716190204.100895-4-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM4P189MB3433:EE_
x-ms-office365-filtering-correlation-id: d9c9be71-0d2e-4c98-beb4-08dee3e88319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|4143699003|11063799006|38070700021|10067099003|56012099006|6133799003;
x-microsoft-antispam-message-info:
 pFozkHhwJxBwo+PMYgCCgFq5u/1uWwvkLuCGM42oZMcuA8sIAE2izo5c1c16LF9lldPcWbNqhalrjI9bq+0Q6O4JjHE/vFPnTJVN1mEzRLEhKCYYtwwrVfER8Xpkznt7EU6nl7lGjn+QnDhVUowRIaWH/hmvFztHe6A7GPThlqkz9WCL8jmPZBqdF5JMpgJArG9BmqT12V3oUunxt8TtZiM2HIzG/J38PHDcWGUCNv8k6uPTh1B4wBtWfNwFrEpDDdoyE4HcIB45cZ37WDH3ZbhYjmTqVGofYCJ5Q9AukDk9PyB6xM6B95r+qajfTlaWea7lHtPBqf2qdTVskhW1XyPnSq/zLAgu2/3L/2cXjPAYDIf/JliP+ZjTGCmXyk4Elrm+49pdrXsebj+HAKlN/PP/NrzF43Ie1DF7QvuwFmgzffzfUd+EMe8rJisplpubyLzUKC0ReJWaMteYEo2v4TlBh9rsGbWYNxVrZ/UJIPLKKFwLuYHRk4mgbV/k3lcya404CEtlV24UX3zNS7X+QRVUrNuGmmSL/bGbGNovT0ogQ0m8gl3wV5YZ84TWnGKZkLmLwOg3lBknyWFGfUUl/w+08Bu26oHZ1mcoiKGB9pZslx2Jn7+vaJ4IhZZ1H02DoH9dH7z34kM0KMcAcMDGbl0T4N2jkCfabRrgo8XzVgAhYJaUi8Tp6KHtxs45Mv55eWPefGIhU2yP0T6vtmCGlwtUgxmnEfho6yZW8eW6NaM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z6fi6v4SiTK54CESFWC8gZI76qyvmthjtcIyl/f+yPhJL1yYugDZ75/YbOTk?=
 =?us-ascii?Q?gLTpmyvHze8y3iHK33Rrq/GJtM6luo/+/vaMXtIOMtxQD+6F6CYzk9irwGVK?=
 =?us-ascii?Q?US+cLf3ZtldnMu3fQAIJ486UjofiXk0OIXLHqAaty7BKMcSLJc430yeE0Pc8?=
 =?us-ascii?Q?bEzqpvAOAK51ZOAAbE3N4XWLL1grZ5tik92UMj+bd9PmciNxQTj4ICFU8NhK?=
 =?us-ascii?Q?4rZVbCJ3MRDVZvU8FR0UDk3nkqGlFUqsJ7E7/cWaZZs0aAa4iOFVW6CNZMde?=
 =?us-ascii?Q?PWDMCa1YKvMezJ4zuH/67Qu2d6upc7bh3H6nPOUaXnBXcbPchZkVk914qYMc?=
 =?us-ascii?Q?m/0NtLbe0pkoVXh2aHBee6XBHbp07wSmjUIYRRXcTVsL0IeW2OIhDHPkOav0?=
 =?us-ascii?Q?LejnqU7pLxxmM2hyghCgFopKR18tbXtXVUV4MXb6ky3dFyaLMCo3xM6ZPC+z?=
 =?us-ascii?Q?HipEhj4unCJc5VgdONtLf5GoCeo5QwsxEvaWz40iWNdi1hll/k2NS8Z56WmR?=
 =?us-ascii?Q?3Zz7/sDp8Xz+tyUXXIY4CYXw1+zAWnTYH/f7v8nmxRY3hkmEjduTpfhb3idK?=
 =?us-ascii?Q?9B0VG7Z8XvGDaGhd62TckrPZfW1EIRXr1UWQJCOAVcSgyzmmr35GZ2789aqp?=
 =?us-ascii?Q?hPSC4fqKPm7F2t4wvSt+AzFpfaNtrd9fUxQGiXd2KyysJl1iKVsVRJZz+9Aj?=
 =?us-ascii?Q?M+vWzvQG8a2bjvZdM2JP2ZYVuy6oCipnFDGqnt9eS2nYr6YqYBZTS8E/EXtR?=
 =?us-ascii?Q?mHLon5BG8Nr7n0Vi8TWl5o+lYiOd8Ge9MI8mCVsdsxTisRgiMJSPoeksmzyW?=
 =?us-ascii?Q?TtPKx5eGnuY7gcAXBAY/ta3BUMEElGwND0ZZhIsSo/rhZGHV9WZ0Ikut2uug?=
 =?us-ascii?Q?oKZ7dV7zF8qnQ7QwTrymlGsojebK18rmL/li7zyPNqF+/bxNMJIV3Uxxs5ei?=
 =?us-ascii?Q?vo89PhjuxIUup8IIlHFRnYhmPyRbyllJc4A+zMFvxc7Bg/z1cZ4kY4XwiMKF?=
 =?us-ascii?Q?BF6NN0EFZydh+eO5/oAIsYaA7axfgfgZ//bTDrjU1YrUxWmod41rQBxRFaSi?=
 =?us-ascii?Q?zbHk61F0ScYzk0OtbeWzIdV5GPeSYdCOEYsSU1NU8IHn76Lf2Lou2WQNOHrq?=
 =?us-ascii?Q?t1RaQ6TAxsEzdmTh5zv9Opcp/fDtEFL1mcIXM3hmLq/GJLZdCGHRGK773ZdF?=
 =?us-ascii?Q?2r3QNLqtezXGMe1miKGSAa0ZrQE7lKPpdR5lF2LY6ns2Q11W5OoxTWWIeoC4?=
 =?us-ascii?Q?1qNBSAMQpL92TwqZH+FGyUZHZxH/twaWWawo2UULO5cdZnv35JeirK7HwoVS?=
 =?us-ascii?Q?TbTX9GM/ri1GW897EeKBssYMOET1aP7nE2cXCLd4oU5WAYpFKyfSIwM6Ignr?=
 =?us-ascii?Q?xnFc4hWD0ZeJE5E97YWkWU7t3u1yI0TpA7fcRyNzU2UTuBYq7nAZkEx+LE59?=
 =?us-ascii?Q?LFgqLhc1Mc6HlB5H5Kv1j5OQXaYKColTpGwa0ago80qH+14jlWQgizsSaXF4?=
 =?us-ascii?Q?cN6NDsCzl/OVKTTVONkIxKTIZxsMqOWd79zrJkikG+7uAxflDBtI82Ed6g/K?=
 =?us-ascii?Q?MF5ap+yvP/9I0IkIP+8tvBCe+QogULJsCMPBgbiqkaBYHthrrfwZmYQLxXrq?=
 =?us-ascii?Q?h0h52tv1cEsOM7j9GmL9pXNMDmh01eTsXJq3fjHnJPidHYEIoUm6zF5ErmAX?=
 =?us-ascii?Q?hJbvimXXt7CCd2Pec4nzSI1fgRx8eqD15aZlRyb3022hh5JmJN2C312D1eBh?=
 =?us-ascii?Q?CfnyMWog4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c9be71-0d2e-4c98-beb4-08dee3e88319
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 09:48:10.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lqbDElQrx+JI8b3WkMKD2Xr8H3uzLWSMf8mC4U8Oe7RQXOM7w0cX5oyE1hV1PUD81qY42AGMgPNEPc7L7d35nhSIHLUTp2M8keKqHWfW+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3433

>Subject: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_up() o=
n
>empty publication list
>
>named_distribute() ends by stamping the last_bulk flag on the tail skb via
>buf_msg(skb_peek_tail(list)). When the publication list is empty no skb is
>enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is dereferenced.
>
>tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
>configuration cluster_scope is populated only later by tipc_net_finalize()=
, so a
>peer link that comes up first reaches named_distribute() with an empty lis=
t. It
>is reachable by an unprivileged user (TIPC genl ops use
>GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:
>
> KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
>  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
>  tipc_node_write_unlock (net/tipc/node.c:428)
>  tipc_rcv (net/tipc/node.c:2185)
>  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not syncing: Fa=
tal
>exception in interrupt
>
>The peer holds back this node's later name updates until it sees a bulk wi=
th the
>last_bulk flag, so simply skipping the send would stall it. Emit an item-l=
ess bulk
>when the publication list is empty, so the peer still receives the last_bu=
lk flag
>and opens.
>
>Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/tipc/name_distr.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>ba4f4906e13b..a8bb7bd101ea 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, struct
>sk_buff_head *list,
> 		skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> 		__skb_queue_tail(list, skb);
> 	}
>+
>+	if (skb_queue_empty(list)) {
>+		skb =3D named_prepare_buf(net, PUBLICATION, 0, dnode);
>+		if (!skb) {
>+			pr_warn("Bulk publication failure\n");
>+			return;
>+		}
>+		hdr =3D buf_msg(skb);
>+		msg_set_bc_ack_invalid(hdr, true);
>+		msg_set_bulk(hdr);
>+		msg_set_non_legacy(hdr);
>+		__skb_queue_tail(list, skb);
>+	}
As I explained before, this approach is wrong because=20
1. It does not handle memory allocation failure.
2. It breaks receiving peer by  sending non-data message to that peer in ca=
se skb is not NULL.

Could you please test below patch to see if it fixes the NULL dereference i=
ssue you reported ?

---
 net/tipc/core.c       |  1 +
 net/tipc/core.h       |  2 ++
 net/tipc/name_distr.c | 48 +++++++++++++++++++++++++++++++++++++++----
 net/tipc/name_distr.h |  3 ++-
 net/tipc/net.c        |  2 ++
 net/tipc/node.c       | 34 ++++++++++++++++++++++++++++--
 6 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 315975c3be81..9e81be4f01cf 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -61,6 +61,7 @@ static int __net_init tipc_init_net(struct net *net)
        tn->trial_addr =3D 0;
        tn->addr_trial_end =3D 0;
        tn->capabilities =3D TIPC_NODE_CAPABILITIES;
+       atomic_set(&tn->finalized, 0);
        INIT_WORK(&tn->work, tipc_net_finalize_work);
        memset(tn->node_id, 0, sizeof(tn->node_id));
        memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..76768844c808 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,8 @@ struct tipc_net {
        struct work_struct work;
        /* The numbers of work queues in schedule */
        atomic_t wq_count;
+       /* flag to indicate work has finished */
+       atomic_t finalized;
 };
=20
 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba5f4906e13b..8a1692dbd243 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -147,7 +147,7 @@ struct sk_buff *tipc_named_withdraw(struct net *net, st=
ruct publication *p)
  * @pls: linked list of publication items to be packed into buffer chain
  * @seqno: sequence number for this message
  */
-static void named_distribute(struct net *net, struct sk_buff_head *list,
+static int named_distribute(struct net *net, struct sk_buff_head *list,
                             u32 dnode, struct list_head *pls, u16 seqno)
 {
        struct publication *publ;
@@ -164,8 +164,9 @@ static void named_distribute(struct net *net, struct sk=
_buff_head *list,
                        skb =3D named_prepare_buf(net, PUBLICATION, msg_rem=
,
                                                dnode);
                        if (!skb) {
+                               __skb_queue_purge(list);
                                pr_warn("Bulk publication failure\n");
-                               return;
+                               return 1;
                        }
                        hdr =3D buf_msg(skb);
                        msg_set_bc_ack_invalid(hdr, true);
@@ -195,6 +196,8 @@ static void named_distribute(struct net *net, struct sk=
_buff_head *list,
        hdr =3D buf_msg(skb_peek_tail(list));
        msg_set_last_bulk(hdr);
        msg_set_named_seqno(hdr, seqno);
+
+       return 0;
 }

 /**
@@ -203,7 +206,7 @@ static void named_distribute(struct net *net, struct sk=
_buff_head *list,
  * @dnode: destination node
  * @capabilities: peer node's capabilities
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 {
        struct name_table *nt =3D tipc_name_table(net);
        struct tipc_net *tn =3D tipc_net(net);
@@ -218,9 +221,46 @@ void tipc_named_node_up(struct net *net, u32 dnode, u1=
6 capabilities)
        spin_unlock_bh(&tn->nametbl_lock);

        read_lock_bh(&nt->cluster_scope_lock);
-       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
+       /* tipc_net_finalize_work() has not finished inserting self address=
 to
+         * name table yet.
+         */
+       if (unlikely(list_empty(&nt->cluster_scope))) {
+               read_unlock_bh(&nt->cluster_scope_lock);
+               return 1;
+       }
+
+       if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno))=
 {
+               read_unlock_bh(&nt->cluster_scope_lock);
+               return -ENOBUFS;
+       }
+
        tipc_node_xmit(net, &head, dnode, 0);
        read_unlock_bh(&nt->cluster_scope_lock);
+       return 0;
+}
+
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
+{
+       struct name_table *nt =3D tipc_name_table(net);
+       struct tipc_net *tn =3D tipc_net(net);
+       struct sk_buff_head head;
+       u16 seqno;
+
+       __skb_queue_head_init(&head);
+       wait_var_event(&tn->finalized, atomic_read(&tn->finalized));
+       spin_lock_bh(&tn->nametbl_lock);
+       seqno =3D nt->snd_nxt;
+       spin_unlock_bh(&tn->nametbl_lock);
+
+       read_lock_bh(&nt->cluster_scope_lock);
+       if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno))=
 {
+               read_unlock_bh(&nt->cluster_scope_lock);
+               return -ENOBUFS;
+       }
+       tipc_node_xmit(net, &head, dnode, 0);
+       read_unlock_bh(&nt->cluster_scope_lock);
+
+       return 0;
 }

 /**
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..cadf4e8c3e66 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -69,7 +69,8 @@ struct distr_item {

 struct sk_buff *tipc_named_publish(struct net *net, struct publication *pu=
bl);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p=
ubl);
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode);
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
                    u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..4c144e720ac1 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -139,6 +139,8 @@ static void tipc_net_finalize(struct net *net, u32 addr=
)
        tipc_sk_reinit(net);
        tipc_mon_reinit_self(net);
        tipc_nametbl_publish(net, &ua, &sk, addr);
+       atomic_inc(&tn->finalized);
+       wake_up_var(&tn->finalized);
 }

 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..c5b0a98324c3 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -145,6 +145,8 @@ struct tipc_node {
 #ifdef CONFIG_TIPC_CRYPTO
        struct tipc_crypto *crypto_rx;
 #endif
+       /* Work item for bulk distribution of cluster scope publications */
+       struct work_struct work;
 };

 /* Node FSM states and events:
@@ -303,6 +305,7 @@ static void tipc_node_free(struct rcu_head *rp)
 #ifdef CONFIG_TIPC_CRYPTO
        tipc_crypto_stop(&n->crypto_rx);
 #endif
+       cancel_work_sync(&n->work);
        kfree(n);
 }

@@ -393,6 +396,19 @@ static void tipc_node_write_unlock_fast(struct tipc_no=
de *n)
        write_unlock_bh(&n->lock);
 }

+static void tipc_node_dist_bulk(struct work_struct *work)
+{
+       struct tipc_node *node =3D container_of(work, struct tipc_node, wor=
k);
+
+       if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0) {
+               u32 bearer_id =3D node->link_id & 0xffff;
+
+               tipc_node_link_down(node, bearer_id, false);
+       }
+
+       tipc_node_put(node);
+}
+
static void tipc_node_write_unlock(struct tipc_node *n)
        __releases(n->lock)
 {
@@ -424,8 +440,21 @@ static void tipc_node_write_unlock(struct tipc_node *n=
)
        if (flags & TIPC_NOTIFY_NODE_DOWN)
                tipc_publ_notify(net, publ_list, node, n->capabilities);

-       if (flags & TIPC_NOTIFY_NODE_UP)
-               tipc_named_node_up(net, node, n->capabilities);
+       if (flags & TIPC_NOTIFY_NODE_UP) {
+               int rc =3D 0;
+
+               rc =3D tipc_named_node_up(net, node, n->capabilities);
+               /* Defer bulk distribution to work queue */
+               if (rc > 0) {
+                       tipc_node_get(n);
+                       schedule_work(&n->work);
+               } else if (rc < 0) {
+                       /* Bring the link down to start over bulk distribut=
ion
+                        * when the link is up again.
+                        */
+                       tipc_node_link_down(n, bearer_id, false);
+               }
+       }

        if (flags & TIPC_NOTIFY_LINK_UP) {
                tipc_mon_peer_up(net, node, bearer_id);
@@ -564,6 +593,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32=
 addr, u8 *peer_id,
        INIT_LIST_HEAD(&n->list);
        INIT_LIST_HEAD(&n->publ_list);
        INIT_LIST_HEAD(&n->conn_sks);
+       INIT_WORK(&n->work, tipc_node_dist_bulk);
        skb_queue_head_init(&n->bc_entry.namedq);
        skb_queue_head_init(&n->bc_entry.inputq1);
        __skb_queue_head_init(&n->bc_entry.arrvq);
