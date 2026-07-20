Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F6D432BD1;
	Mon, 20 Jul 2026 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562108; cv=fail; b=T82JoZvnIT0KV6EsqX7+SvUmNNyWInR/gPvt4OoGFrcSobPicfSgnnXBUdp8bSwVXHLbVJhgjYp7THjvRqWh6XofDyNjbTbwZLh5OZqYwcTbwGBbe6N3BfdMXQushMZXv97Dab5APOguyz9zOqcnkDF8pAQ9+Yk7KSIPjUNgIX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562108; c=relaxed/simple;
	bh=WU4Y2fhKwGYf+T+Z4NvoLSwOs/5VhZhdZTgCVfEGHa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CnY6YqeQUQueF8GuYj1l7O2VkKQJmPefy9h0ScZieFCDMhn0J8wMf72QVTlRgh0JzEdhDU+3SavDcP1i8zAKYYKN90XivnqClMClZwgEAwJr419h6UmoSWjRbQhp//g6pVPQqNeUxFe2U0WJDtXx+mQ8J4in+a8osFEIlchv1mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=m7+93/mj; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="m7+93/mj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNPGlIF7U32CCwojlIj7oE7zMn9ljWW2XocmBRStI4qnp351RiWa4sln4m+YQegmYvhSMyUzrVqfCNAp+/a/chYrLgRY6m3Z2VVdy4a9iJloxNncqNmXJnbCt+8R+FjrNdiblUasqplyP+geAjlg9a08Q9ictIuaZIxTZM6Nq++EKQlJMcIWU8UBBsjLwr7GPnvP/r34Ap5vSF3xihuKCKho7uPy1ZlorYULmLH9J8SuSjfPEtjbuepskYqSQMpSMXlOU5lTwJ5ujzKZ2DvjS07puf/cByH7uS3l80nx0JdfiSYbX0vxyRNXsYcC+XRO+bhXD8UuZc2Tr72W/Ff/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G39/Zzxtv5AtOnRWtxP3BY7khLcivR0M9/JnIKxvHBc=;
 b=A/EDzDvItp6XFkxwWBTERolCrXpFQkC7TNw8ymxnTAfDUFXgKmpI8puQp/Rwd4rx/J8J6cFp9ms3gz9kLRm2hPvpFtoTd+MnRplgs0loFJE2wcS9zXLVyP33AFi6Ye3Dr5bhh7KzqFIR5cqfMyO9L5PbCmXEY430gmeb0XPlrtI+qqVKgX+5F60UO34NP1np20X1Rgt8zezxaWHI0cUBGqTUpyyxECzkwa0AcbXfLdeyv9rMF+xCb2pQXflqlg5DCLXOdzdy9PwiIbdIJM4l9vpNpcwkooBWtmvdGSn2rAoF1R+ZjrzZVO/u8CcUcpdjbBPG4o0nuPLzNBh4UTM3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G39/Zzxtv5AtOnRWtxP3BY7khLcivR0M9/JnIKxvHBc=;
 b=m7+93/mjd4z8FFs3umhPMilaAqEghLkWIGAME+R+teS7KLIm1yXrrnwrNhDpdeDXs0KXE09776b7T0LQ9v4WuvesMmby1ZcaqYHFwyz/iUrlBdgJ5SyHzM3PMcq9ZzwO2XxvprIhci8Occb5+DHuxfx5RT90Sph8+wF6AedZnoAtKrQg6m3LT6gwM+WRHX59TSHnczgR6vxykjjEgoxvREDYfsCvSvjGiwyLHbhhtKh+CgK4pN0/Gg6WBENr6paKCnFIafDDAio/Bs4wb01eeezWYWYu1ZVbj2aUHPTde6SnXITYWltM5c0E+9DodQnNtnX2qdItgJmQLdcD8ImpJA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI2P189MB3562.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2dd::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Mon, 20 Jul 2026 15:41:39 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.009; Mon, 20 Jul 2026
 15:41:39 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Xiang Mei <xmei5@asu.edu>, kernel test robot <lkp@intel.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Topic: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
Thread-Index: AQHdFpdz5rod5J9+cEGekGyYwc7wpbZ2jdiw
Date: Mon, 20 Jul 2026 15:41:39 +0000
Message-ID:
 <GV1P189MB1988EC5A7F5CB5DD69F331AEC6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260718092544.785289-1-bestswngs@gmail.com>
 <20260718092544.785289-2-bestswngs@gmail.com>
In-Reply-To: <20260718092544.785289-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI2P189MB3562:EE_
x-ms-office365-filtering-correlation-id: a738b837-3f33-4b22-07a1-08dee67563af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|6133799003|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 WvMSGgSEblBxXPIBNyNhSLMjpjjBsEL/mA9V/LSG2VIZl3DoAMF2+vgw+qrWKnmzUbHh1jym+1sjpXH1VKLZOXJFEOBqIBsbk7KpPsMFu8ohG8vUeuvE74fQNjb/BfO5sXJmuIKN87t/WQ5HNPx5mzJS3fz18zS+dESZcTdcDTE1GqMq582FwalG5QPHNBD8vJZ8PATo0vPyTptEeXQf3byPCDaa7goZLx8m4e15nnlYJbGHma4C5oHkD/Fce1ra5LsbjQNS+aPYJVxNh/H8zlKYFzrruUssAGNlfiYZMZJRseYbcaem49kFZF97G2PbJSG4MguM24BUEGbA4Xni4EakscUzrvAwmYUJwfmkSRLZtRi6PEPAcuXBjPhzB8z/6hFPAqrGi57ce9RLL6VGEqhQhuMW1zbOf6AdexqWISwBtL0PekiumtjOL4svhEUTycLEufPk0Ms3/48X5C9tlL+OIhW2o1rTNVX8pRbfwpbFjTxyUoykr7p+GvSbCzHM/uwSaGUP/voozK+tH7S4Nt5X7TDvPRk7Jewih6dxWZOvcaVHNkh+SMtip5inicPYLEZ7tVRr8AuyQnTfb2KT3uIfZLrczvlTN3JmodbFuxk9BvhFcpODaCevF9Cc/hU70Lse0ni1VLDqv7zuCH4b6YwlWWq8dhqkaEXbL/TtrmU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qEBnVW6erDk39wAK9Dr7DOy1A3+6p8v99QP7x6du6MhOaUaCSiP1C1fwxWKV?=
 =?us-ascii?Q?gPGrveVxSA2OHPZ7X70sS8AGbGfBQkQHp7JQeaqFuO+za5Yfwv18rQZ6VSaG?=
 =?us-ascii?Q?zr7fMpjxc+9/YT7HIs43VGyY6lYYnum0aqlFKJxWUQB6LzAgl5yD8J3wn51g?=
 =?us-ascii?Q?tpk0B33x1JGDepBjKetVo02z5QU5HoW53qa+Sn3ePvILbHb74g6oZON0iXPR?=
 =?us-ascii?Q?UuP8p7Tadfuf2LH/Dv55sas5dvJvu6r35uws7wJFPuonLNq0zAQtC44Pw9rz?=
 =?us-ascii?Q?iujE0GkIhsGLi5zLhyDmMpwTrdyKNGjIuxXYBs3DFeZ94rYNcukLx5UUs3pZ?=
 =?us-ascii?Q?ZbKhjPyX9K76NYfaS7FjUv3D9HIIopI9ivvpJnR4IdN0oJZIwv48Q37t3ywc?=
 =?us-ascii?Q?qDv3Bxt8fCHvi4VL4+hwYP/Kg/lBzMk4IUJa9Wfab6Mu2jpjAfM0iCHiHLNR?=
 =?us-ascii?Q?o4LIH1GcpPBPeHk6WFeQjTmojknBbaxvm8pI3frYpXqL8hOXSVAf4JCG14kv?=
 =?us-ascii?Q?tGPjsEapJqVGvR8ozEiHSO0DSW6mbqOMgecf602CWC93/KSIoWZ/b0B0RTWq?=
 =?us-ascii?Q?Id3j6SKb3WVe34+AmEcLepy7aD3l58KpBO6C0Hbf7k1t/RIrk6ZfHIWQeK0P?=
 =?us-ascii?Q?tghzHHocF5GRxaMtmyjcSOxzXVEmYjULyXCS5b4CnfqFsyqkM0GEDZuYkVam?=
 =?us-ascii?Q?+l3gzNGIxJOGGAjm1njgzK3xuM4KLqOxj/rLxVslqL1q0IvjXp48Drgna6Xm?=
 =?us-ascii?Q?7aZrp0QfK0Z18hcxpg9Vt+AaiWu2AkwyW7y55rbTZ7OWNtdWPusrTItuihTu?=
 =?us-ascii?Q?koY9hWvz+/8XlD6jAszt1+/ijgkRKKu/zcXDFfDdqKzeGiLxDs8hv6xIN5AZ?=
 =?us-ascii?Q?Ie5BxtPU5kkr5QcYzOHUlpYTm59J+mua9YAHyXee6hEBivm7VPM96aPHe0yv?=
 =?us-ascii?Q?5WJjyrrCYVlA3ReyfvR4J17oQBVRacxI7oNA/5CrseM/Il0KsvWUITgDmULP?=
 =?us-ascii?Q?dR67rpjT231MqDDoTOQDCA9Jn8QGIPbsjgG4BrI8uqL/WR3ul5KH4xBboscW?=
 =?us-ascii?Q?GR1tHYzfqkNWF/go/JnUudwuz8G2C8bb5H6DXixK459dGyFFpyqUUAMR8lYk?=
 =?us-ascii?Q?yEXgqB9qi3aDcOITeikRWdq/9UNqFKkEr2axlvdaLfbqGO5gxOKVpbLbJZyQ?=
 =?us-ascii?Q?F5V1V3e0q/E5g663KZwby4zehXUv9BGffl0q6dokjUEqGBKa29AllqhsKtmP?=
 =?us-ascii?Q?fvLpIzIA5HEoayAz5c7x+ktk/mng4mls6XeGG8omRw9kHQY6u8AAGGDWryF2?=
 =?us-ascii?Q?LAMUlWic7sLsXglIMxCTkdtJYvRJFRldoBrAKSMdKqNHnQ5wQ6aZAWWEJ+v9?=
 =?us-ascii?Q?5mKHWIO+o+K3Z8DsfHzBphEpiYj3Wf7iegWdM8BHHg0KER/vL7YPpkn4dife?=
 =?us-ascii?Q?hc2uPDo7DEFMgCpFq9kbQEaW/xLbJzAOnPDQIuYf73cIuApoLNGdwUMkciWZ?=
 =?us-ascii?Q?K0KoEUOUnjQ97MFKRH0lkoKvoyzkRNDOPkXanRRnoIQ93Dj/9wlXgCKaFfTh?=
 =?us-ascii?Q?FnrM4SJ2Qi82L3H69OUOEtF5lyXDluIveLeak2kD+yxStAApuxUPc9dFbqvU?=
 =?us-ascii?Q?moCsVaN3dAF23SKPedVevIVr34HajVr3pcQp278/BdNIl01rmdvDKPbgZzmG?=
 =?us-ascii?Q?hg+Ok90cnbPku+9a0YHdWhRVuPPFgoFMIn01znL0BZnLqQeP2Yv64RA7xHH9?=
 =?us-ascii?Q?Pc5ymY9dnw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a738b837-3f33-4b22-07a1-08dee67563af
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 15:41:39.0973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsDBibCXIqHxyuKljbCd3yzMiSeCJTWGjEO1dx6SFnkSVfwnUWAGvFVVoHqF5+ZpIUtwkJB07iCUg7iGx55Ei8gLfMpzIM5bDm/ZdP0hNLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P189MB3562

>Subject: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up() o=
n
>empty publication list
>
>[The defer-to-workqueue approach is by Tung Nguyen. He posted it  on the
>thread and asked us to test it, as the replacement for the  item-less bulk
>approach. Since the RFC only exists as an inline  diff in the thread, it i=
s folded
>into this series so the fix is  self-contained.]
>
>named_distribute() stamps the last_bulk flag on the tail skb of the public=
ation
>list. When the list is empty no skb is enqueued and the tail access derefe=
rences
>NULL. tipc_named_node_up() hits this on an empty cluster_scope, which
>happens with a node-id configuration where cluster_scope is populated only
>later by tipc_net_finalize(). It is reachable by an unprivileged user over=
 a UDP
>bearer in a user+net namespace. The reported crash:
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
>When cluster_scope is empty at node-up, defer the bulk distribution to a
>workqueue and wait for tipc_net_finalize() to publish the node-state name,=
 so
>named_distribute() always runs on a non-empty list. On allocation failure,
>purge the partially built queue and bring the link down so the bulk distri=
bution
>restarts when the link comes up again.
>
>Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Reported-by: kernel test robot <lkp@intel.com>
>Closes: https://lore.kernel.org/oe-kbuild-all/202607180730.TwVgASDI-
>lkp@intel.com/
>Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
>Tested-by: Weiming Shi <bestswngs@gmail.com>
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
sashiko reports many critical/high issues: https://sashiko.dev/#/patchset/2=
0260718092544.785289-1-bestswngs%40gmail.com

I address all in below patch. Could you please test it ?

---
 net/tipc/core.c       |  2 ++
 net/tipc/core.h       |  4 +++
 net/tipc/name_distr.c | 67 +++++++++++++++++++++++++++++++++++++------
 net/tipc/name_distr.h |  3 +-
 net/tipc/net.c        | 15 +++++++++-
 net/tipc/node.c       | 61 +++++++++++++++++++++++++++++++++++++--
 6 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 315975c3be81..52544b805dcc 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -61,6 +61,8 @@ static int __net_init tipc_init_net(struct net *net)
        tn->trial_addr =3D 0;
        tn->addr_trial_end =3D 0;
        tn->capabilities =3D TIPC_NODE_CAPABILITIES;
+       atomic_set(&tn->finalized, 0);
+       atomic_set(&tn->work_rescheduled, 0);
        INIT_WORK(&tn->work, tipc_net_finalize_work);
        memset(tn->node_id, 0, sizeof(tn->node_id));
        memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6cc0..52fdb9189cc3 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -145,6 +145,10 @@ struct tipc_net {
        struct work_struct work;
        /* The numbers of work queues in schedule */
        atomic_t wq_count;
+       /* flag to indicate work has finished */
+       atomic_t finalized;
+       /* flag to reschedule work */
+       atomic_t work_rescheduled;
 };

 static inline struct tipc_net *tipc_net(struct net *net)
diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..3e32445cfbd0 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -147,8 +147,8 @@ struct sk_buff *tipc_named_withdraw(struct net *net, st=
ruct publication *p)
  * @pls: linked list of publication items to be packed into buffer chain
  * @seqno: sequence number for this message
  */
-static void named_distribute(struct net *net, struct sk_buff_head *list,
-                            u32 dnode, struct list_head *pls, u16 seqno)
+static int named_distribute(struct net *net, struct sk_buff_head *list,
+                           u32 dnode, struct list_head *pls, u16 seqno)
 {
        struct publication *publ;
        struct sk_buff *skb =3D NULL;
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
@@ -195,15 +196,16 @@ static void named_distribute(struct net *net, struct =
sk_buff_head *list,
        hdr =3D buf_msg(skb_peek_tail(list));
        msg_set_last_bulk(hdr);
        msg_set_named_seqno(hdr, seqno);
+
+       return 0;
 }

 /**
- * tipc_named_node_up - tell specified node about all publications by this=
 node
+ * tipc_named_distribute - distribute all publications to specified node
  * @net: the associated network namespace
  * @dnode: destination node
- * @capabilities: peer node's capabilities
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+static int tipc_named_distribute(struct net *net, u32 dnode)
 {
        struct name_table *nt =3D tipc_name_table(net);
        struct tipc_net *tn =3D tipc_net(net);
@@ -212,15 +214,62 @@ void tipc_named_node_up(struct net *net, u32 dnode, u=
16 capabilities)

        __skb_queue_head_init(&head);
        spin_lock_bh(&tn->nametbl_lock);
-       if (!(capabilities & TIPC_NAMED_BCAST))
-               nt->rc_dests++;
        seqno =3D nt->snd_nxt;
        spin_unlock_bh(&tn->nametbl_lock);

        read_lock_bh(&nt->cluster_scope_lock);
-       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
+       /* 1. tipc_net_finalize_work() is not scheduled because of namespac=
e
+        *    teardown.
+        * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has failed
+        *    to insert node self address publication to nt->cluster_scope.
+        * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
+        *    executed yet.
+        */
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
        tipc_node_xmit(net, &head, dnode, 0);
        read_unlock_bh(&nt->cluster_scope_lock);
+
+       return 0;
+}
+
+/**
+ * tipc_named_node_up - tell specified node about all publications by this=
 node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ * @capabilities: peer node's capabilities
+ */
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+{
+       struct name_table *nt =3D tipc_name_table(net);
+       struct tipc_net *tn =3D tipc_net(net);
+
+       spin_lock_bh(&tn->nametbl_lock);
+       if (!(capabilities & TIPC_NAMED_BCAST))
+               nt->rc_dests++;
+       spin_unlock_bh(&tn->nametbl_lock);
+
+       return tipc_named_distribute(net, dnode);
+}
+
+/**
+ * tipc_named_dist_cluster_scope - distribute all publications to specifie=
d node
+ * @net: the associated network namespace
+ * @dnode: destination node
+ */
+int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
+{
+       struct tipc_net *tn =3D tipc_net(net);
+
+       wait_var_event(&tn->finalized, atomic_read(&tn->finalized));
+       return tipc_named_distribute(net, dnode);
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
index 7e65d0b0c4a8..78418515277e 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -132,13 +132,26 @@ static void tipc_net_finalize(struct net *net, u32 ad=
dr)
        tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
                   TIPC_NODE_STATE, addr, addr);

+       if (atomic_read(&tn->work_rescheduled))
+               goto publish;
+
        if (cmpxchg(&tn->node_addr, 0, addr))
                return;
        tipc_set_node_addr(net, addr);
        tipc_named_reinit(net);
        tipc_sk_reinit(net);
        tipc_mon_reinit_self(net);
-       tipc_nametbl_publish(net, &ua, &sk, addr);
+
+publish:
+       if (!tipc_nametbl_publish(net, &ua, &sk, addr)) {
+               tn->trial_addr =3D addr;
+               atomic_set(&tn->work_rescheduled, 1);
+               schedule_work(&tn->work);
+               return;
+       }
+       atomic_set(&tn->work_rescheduled, 0);
+       atomic_set(&tn->finalized, 1);
+       wake_up_var(&tn->finalized);
 }

 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 8e4ef2630ae4..afed72894722 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -111,6 +111,8 @@ struct tipc_bclink_entry {
  * @peer_net: peer's net namespace
  * @peer_hash_mix: hash for this peer (FIXME)
  * @crypto_rx: RX crypto handler
+ * @work: work item for bulk distribution of cluster scope publications
+ * @work_scheduled: flag to indicate the work has been scheduled
  */
 struct tipc_node {
        u32 addr;
@@ -145,6 +147,8 @@ struct tipc_node {
 #ifdef CONFIG_TIPC_CRYPTO
        struct tipc_crypto *crypto_rx;
 #endif
+       struct work_struct work;
+       atomic_t work_scheduled;
 };

 /* Node FSM states and events:
@@ -393,6 +397,27 @@ static void tipc_node_write_unlock_fast(struct tipc_no=
de *n)
        write_unlock_bh(&n->lock);
 }

+static void tipc_node_down(struct tipc_node *n)
+{
+       u32 bearer_id, bearer_cnt;
+
+       tipc_node_read_lock(n);
+       bearer_cnt =3D n->link_cnt;
+       tipc_node_read_unlock(n);
+       for (bearer_id =3D 0; bearer_id < bearer_cnt; bearer_id++)
+               tipc_node_link_down(n, bearer_id, false);
+}
+
+static void tipc_node_dist_bulk(struct work_struct *work)
+{
+       struct tipc_node *node =3D container_of(work, struct tipc_node, wor=
k);
+
+       if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0)
+               tipc_node_down(node);
+
+       tipc_node_put(node);
+}
+
 static void tipc_node_write_unlock(struct tipc_node *n)
        __releases(n->lock)
 {
@@ -424,8 +449,23 @@ static void tipc_node_write_unlock(struct tipc_node *n=
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
+                       atomic_set(&n->work_scheduled, 1);
+                       tipc_node_get(n);
+                       if (!schedule_work(&n->work))
+                               tipc_node_put(n);
+               } else if (rc < 0) {
+                       /* Bring the node down to start over bulk distribut=
ion
+                        * when the first link is up again.
+                        */
+                       tipc_node_down(n);
+               }
+       }

        if (flags & TIPC_NOTIFY_LINK_UP) {
                tipc_mon_peer_up(net, node, bearer_id);
@@ -564,6 +604,8 @@ struct tipc_node *tipc_node_create(struct net *net, u32=
 addr, u8 *peer_id,
        INIT_LIST_HEAD(&n->list);
        INIT_LIST_HEAD(&n->publ_list);
        INIT_LIST_HEAD(&n->conn_sks);
+       INIT_WORK(&n->work, tipc_node_dist_bulk);
+       atomic_set(&n->work_scheduled, 0);
        skb_queue_head_init(&n->bc_entry.namedq);
        skb_queue_head_init(&n->bc_entry.inputq1);
        __skb_queue_head_init(&n->bc_entry.arrvq);
@@ -635,10 +677,25 @@ static void tipc_node_delete_from_list(struct tipc_no=
de *node)

 static void tipc_node_delete(struct tipc_node *node)
 {
+       struct tipc_net *tn =3D tipc_net(node->net);
+
        trace_tipc_node_delete(node, true, " ");
        tipc_node_delete_from_list(node);

        timer_delete_sync(&node->timer);
+
+       /* Wake up node work queue if tipc_net_finalize_work() is not
+        * scheduled yet.
+        */
+       if (atomic_read(&node->work_scheduled)) {
+               if (!atomic_read(&tn->finalized)) {
+                       atomic_set(&tn->finalized, 1);
+                       wake_up_var(&tn->finalized);
+               }
+
+               cancel_work_sync(&node->work);
+       }
+
        tipc_node_put(node);
 }

--=20
2.43.0
