Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9C3DE43F;
	Tue, 29 Sep 2026 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680478; cv=fail; b=O7ZCIaDskh9/XB/3HQSqyooAxAUDZZIi6MbndqnQO0boFKxreLxIffA9Upb0TunqVkP8uAKGCsFrNIAOBM2m+8PlGpZiINyAalUZ7mrnTdMW3u49XJFGrZEH1ZQvuui1yfhb0WO/X8EedE9uoN3uDn5E03UV0lU/5vKdV9fpfgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680478; c=relaxed/simple;
	bh=+ksqdNFXadARLVVwSMS1jtoAGMqg2V0csdMyovpt0SI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4OP50XsOB6vdxLUeXJ1L0peVHefFgaxY6j6Z0G8KBCyQ/QCvvKHA+IJbDGhYXYxlzFwx0j8dTCqhDNPiEfvbcJ7D51oBKtWoZEmYtfOiFBICyGuIjjRcyH6cDj1BTIWQDkKshFM8aBWMTfgcLiXZzC5vDpqBGwV4smoXTTHcO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=C4NAmjQz; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="C4NAmjQz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFz/075NoP0qLSPKadTkyyytC3pztdkSsLAi7HA+AHgz8BbHhpxE2KQTyzc89apTqQfWAzzGy9u9mK3BEobOR/j3gOag3Oj9uDlViPjqVDpvcq5W1Dgz88dr3zyD6hSPp9dUNKsvzW9bhCMMgWNL1QM6xdjwMZpG7O/k4JWsOcRYo4+nl5o+LwVl1PhwQWe6BQJ3ATF+y8TJGG6yJNencEKupGSrz0yk3ktUHSsQZxfjjlCuYET20hctm4bxSqD57b33srw7/H1bxGeRIMMH0W72MrE8IOgXxJcyqpWp8lrIgFgiUr9OTHq6JMSis+ubD6oRtxr74OFGhAYYQbtRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqHz/4UlMFANtR+QgzPn/q/x3QAc7zZtFi5BiKxU+DY=;
 b=FJmbJBS8DyBgti1Jk3mt6QFk45TtwJ3ll4ozSheLjovzk3W6sD9KMwUE4oi1HrTY8NV4DJ4DrgRj5Y1YJEOKfWOf6I6ErVUxISPR2gZrklg0xduNoixaKQZHZiykSQnf8y2gacpuyADmapKdxGNlqsWJwUYoz+sWWd9mMnj3acBNoPuQBSM64htGjZxbVe2MI1MbGT5GIxTPnkdXlDXSHbgiXJ0DUPQg4uDlPXkw+ya8/BRnjruVjCx2tXnDBbub4dHP57BuLv5IVjUO3aIn3ahLKEuDD5DEtCw7E+ePfJT1J/TuLZRK0rbsvCjk6dQM6yu3nw8b1r3ETMTdEHvOyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqHz/4UlMFANtR+QgzPn/q/x3QAc7zZtFi5BiKxU+DY=;
 b=C4NAmjQzeNC6Ta0pRbp9ld2lL91jSZmWMcMbLcmKS6c8uT2wukZkO4qqoURfTLO4EXDaz7qo4S+HvsVl1cSsoGDDJJuRV+tejA5Q/mDKBm8XnYttsYfhBOqC3gyR7ZazZWEZPzC9mosNlgf5a1HE19XUg+Ua41kdvE+zTK0ST6a8aBP6eATs3lM5Wl19DKQwJ38rMnGCmLv4Jq2SbwJF7krvaNLgz3Nnlt+TeshUeD/shQIE2/PqLqqcIGsWxO9PiCv7+rr2BaMRPuoKoitjgF68YwTX9/Rk9dVEhjrDi64CaDmCnuZ6qljNFfAhvOSDPIn+QdIq2ZUvHY9xWnVBSQ==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by AM4P189MB3570.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:14:33 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 11:14:33 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: serialize publication purging with name table
 updates
Thread-Topic: [PATCH net] tipc: serialize publication purging with name table
 updates
Thread-Index: AQHdTqszaQ6K/XMP9ESvU4K/Zaba/LblaGUg
Date: Tue, 29 Sep 2026 11:14:33 +0000
Message-ID:
 <DU4P189MB375003EE2AE98DCE267919BCC68C2@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|AM4P189MB3570:EE_
x-ms-office365-filtering-correlation-id: 37d21a9e-c81f-481c-34a8-08df1e1ad705
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|4022899009|1800799024|10067099003|11063799006|5023799004|56012099006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 c+PKu+N9DPYJNNyDw6RRZGxwTfn9K8q4mZYufVRxQ2uIF3ZNbZIXMASd0pd4IpOP7utMRwUiqOMPo5JprSJRC8ftvFrGMmBLqMyjsF/j7rIzZyg5VNUxqvEsMrxvWqt5wqVJMgLD43Cu19yBXGki0k4IcTo9AoT+aFEbjnO8TAw1JDf94gJxQRKJPWOHd1ePFx5nnf+6sBrrDCyhZZGDctPNRyMF6RCg1kZ03ElDZQjtBJDiyNkl8lPIcOBkOf2/Qr0y2xXY+l8To2+vzUPDW2Bi/7T6hjMGuRHz6Mw8r8Tdbi8F+32fAhGISI5ijH4IDxo1lAts1VFOgusUtc1OMyY89ShwGo6ip9YVn2QrQR1Yqpfue/qISaiLTM3scJHtc+eFtwgCC3giuXtwLQAzLjmwhcP7zSdejC6Q9Za0QZ2+5pTPBjaiEweVqHQ1UBooWFmpfXZu0Cx+rdhjYhs9nFi+Aka1JIP5ttkQtHvmLBPfa8DpNA9tGAenP8ZNl5DzNpau4wUj2RpQdIvCiOKqOctQU1fZQ+e2MPuGh1B5QYSNLAERe8jrdcRdraZnnuy5FdtEnbboMTWO1WTwu4uibyDEOpFrR6IbU+5R7QqZJVHswB36DypIweLG0JHaLl7KkjhGSmjY8Dlprwpoyl2+5WmFOiG14eMLg2eV/iOm5DJGYhZvrU9DjgtVFkc1XerrdqkIUtyJOmTayu+7cTbzzsamAQcr/2rJrfrg87MTO2c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(4022899009)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?duzsL/xsBI/I5522B0QBpXhgreHXOk0Cug5lgJgSWjiTD2IEU2JzkVu1nYlX?=
 =?us-ascii?Q?1WPzfnesQX+HoIJOiVpOURtcMfWC3PSNX++d1aE6cJR04EUuPZp/dFMU7P9u?=
 =?us-ascii?Q?3RhwFDGdBnV2d4ltC0AbB6W2ijXbxD1cWZ4kQ2WryAwaPUKaQjO5XY9qXWhn?=
 =?us-ascii?Q?JnMPMmF+e5Iyu08Q8mFCp3VVIdHrPMDEUnqT3Hz3i3NCVk9ZNqhjaCgvBtLQ?=
 =?us-ascii?Q?0vCoAsbH+IP/4cIzG0oB1TGa7GpsmjBSEA1VHcfMs2bqr0TJ3yBaksHgKHHS?=
 =?us-ascii?Q?DULT8iixzktfX8NOVimcZckjvPwSgMYCHKeVwtDjYNUFjILZoVUytk1Ma30/?=
 =?us-ascii?Q?l7bYqG9sQuZPxyqpawbyMrlggqqJTTNESA1DmiSnWr0Nq13fxLi48fM+Yi7V?=
 =?us-ascii?Q?XsYDmXMuxd1NGVKD8AonEahd1yfr8vQnEbwoo+LLYH+2MOkS/TnIoAXztH5y?=
 =?us-ascii?Q?m7cbn8iyfUPmubC/wdkNwExUXnbcI+yldT4wwNrxvw+JyqDEury97yFq2+fo?=
 =?us-ascii?Q?0cfvMitJv7E6qU/lvkRLUGn3nmuuS312UlMa3LK1HpVhBQpXKsvWYl6J9m3A?=
 =?us-ascii?Q?y15DfxbkNYfEUWzge49hakBVW2iWD5FUZ3j5OMWLSz7VuhmgFS0T0a8P0Y26?=
 =?us-ascii?Q?jjSbBvIz9LMdSW9HqctV0ZBkhH40q3e9N/3gDYeFqsA4SEDjML6X8grsuHXg?=
 =?us-ascii?Q?1OBOcUdPfdU7N6Z3XrIztUTcXCeZkQce+fRVSRzi1TR36Hqd2339pgVyxNhJ?=
 =?us-ascii?Q?mn8wZaL+1x/9u0+oaSqwHzT5708185ZBux+snTAjlBeZsmySD6THmBsR+2HS?=
 =?us-ascii?Q?4Z52CHeV1xl8QW+XWeTgw0Bk9v/YdYdiSmiOwyAj8uziLoTkT0/6rXNb0HuC?=
 =?us-ascii?Q?KnAax5tfz3s6f/6f0xBKsyruY/2Ddjm+YEuBtis5ci0vh0mZklq+8tmWQAyc?=
 =?us-ascii?Q?30wO8VrgQTp4MXQv8JvJZcXOQxc1pa7mzfPkZdWXIdnDR8JXaAv07mAwhQPI?=
 =?us-ascii?Q?HmG0DX96MIz+23DGuR6PkoQa7x21qyHAlvNhe+Hat/lFqpdWc/BHAcidJHZ7?=
 =?us-ascii?Q?3hLMZKJ2hxgE34kmbSCzqy4ZQ6L21XWRnWhF6yvxjwVlHKWR5/m4/LQ/Nc52?=
 =?us-ascii?Q?KCbqpOTKuw4tctvw+Kc7rNP1i0207B91RWrnN9+Jtz1HQhH9qmcIy7jGQ1Vu?=
 =?us-ascii?Q?H+qT5MxyXBFaYv1bcL/3WSfLf0/ri37MgmnY+pZrsfXp/NRJgQzHPcD8rgiE?=
 =?us-ascii?Q?KLbnHBQhsEcc0DU98vIeF/0D6ZPZFJVZAzlXp+Wloictl6r7+RK84y/4uagB?=
 =?us-ascii?Q?VjZ3Nyjwl9TsMpU+60g6uU2cTiaMfEgZ8z6Xxvd1b0zaQfBDcwSrmhQSlNSN?=
 =?us-ascii?Q?IdJ9cmk0BkxTu31Of8YwT9vKQIg5DjE86vRyK76U0vyN/fd07SEAaJctlxc2?=
 =?us-ascii?Q?qB0bb3C5KzhNwOAZDsAlnl5Hh26AvQqGImtWYbpiGEogbAv7GWZMvstx/suO?=
 =?us-ascii?Q?7JlJ+J6mRtrcfAWbOiv1tkhzVKBOfMRzWKa0Pissg+KL/ztSwh5/XuNjfBQZ?=
 =?us-ascii?Q?C0iY+eu5UDf5/qFF3dz2hgK1Nzpuut2jErlyM4Ont6A4RaDTkosiIZnsdv5E?=
 =?us-ascii?Q?CHAJYggp3U02QlHE+vSmKC1vt2Cg4s5bj6lChn23gX2i1ky1CycDo1dCLYJl?=
 =?us-ascii?Q?rJWVg+dRA/ny5o3wuKVHoeCjTfLJOpQw4vqJeCXuYU85EO/VppYS+/NLuU3E?=
 =?us-ascii?Q?KoZqe/JDtg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d21a9e-c81f-481c-34a8-08df1e1ad705
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 11:14:33.5030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8RlirTPk3ED3kKXhWEhMgO1dIlHaF9Gh85Ug6wave4xzFLaOM2k+4h8zyCMj16XRHQZZJLAnRLr1DXfclFCyS3gpHPx8Qz4P+5XO9TLEns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3570

>Subject: [PATCH net] tipc: serialize publication purging with name table u=
pdates
>
>tipc_publ_notify() walks a failed node's publication list after the node l=
ock has
>been released. Its list iterator is not protected by the name table lock, =
which is
>only acquired inside tipc_publ_purge().
>
>CPU A can save the next publication before entering tipc_publ_purge().
>CPU B then takes nametbl_lock in tipc_named_rcv(), processes a
>WITHDRAWAL for that publication, unlinks it with list_del_init(), and queu=
es it
>for freeing with kfree_rcu(). CPU A advances to the removed publication an=
d
>loops on its self-linked binding_node, stalling the CPU.
>
>The kernel reported:
>
>  rcu: INFO: rcu_sched self-detected stall on CPU
>  Call Trace:
>   tipc_publ_notify+0x3b5/0x650
>   tipc_node_write_unlock+0x49d/0x5d0
>   tipc_node_link_down+0x15c/0x4a0
>   tipc_node_delete_links+0xfc/0x190
>   bearer_disable+0x111/0x270
>   __tipc_nl_bearer_disable+0x1db/0x2f0
>   tipc_nl_bearer_disable+0x1c/0x30
>

Please update your changelog with decoded stack trace.

>Locking the entire traversal would also prevent the race, but would hold
>nametbl_lock with bottom halves disabled while purging every publication.
>A node with many publications could therefore cause excessive lock hold ti=
mes
>and delay other name-table operations.
>
>Move the failed node's publications to a private list under nametbl_lock, =
then
>select and unlink its first entry under the same lock before purging it.
>Concurrent withdrawals can still unlink entries from this private list, wh=
ile
>publications arriving after node recovery stay on the node's live list. No
>publication pointer is carried across an unlocked interval.
>
>Unlink before the table lookup to make progress even if the lookup fails, =
and
>acquire and release the lock for each publication. Check the private list =
under
>the lock on every iteration, since concurrent withdrawals can still remove
>entries. Keep withdrawal notifications and the final rc_dests update in th=
eir
>existing order.
>
>Remove the failed-node address argument from tipc_publ_notify() and its
>purge helper since unlinking no longer needs a node lookup.
>
>Fixes: 9db9fdd1983e ("tipc: avoid to asynchronously notify subscriptions")
>Cc: stable@vger.kernel.org
>Assisted-by: GPT-6-Astra
>Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
>---
> net/tipc/name_distr.c | 34 +++++++++++++++++++++++-----------
> net/tipc/name_distr.h |  2 +-
> net/tipc/node.c       |  2 +-
> 3 files changed, 25 insertions(+), 13 deletions(-)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>ba4f4906e13b..34867b69044c 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -227,38 +227,50 @@ void tipc_named_node_up(struct net *net, u32
>dnode, u16 capabilities)
>  * tipc_publ_purge - remove publication associated with a failed node
>  * @net: the associated network namespace
>  * @p: the publication to remove
>- * @addr: failed node's address
>  *
>  * Invoked for each publication issued by a newly failed node.
>  * Removes publication structure from name table & deletes it.
>+ * The caller must hold nametbl_lock and unlink the node subscription.
>  */
>-static void tipc_publ_purge(struct net *net, struct publication *p, u32 a=
ddr)
>+static void tipc_publ_purge(struct net *net, struct publication *p)
> {
>-	struct tipc_net *tn =3D tipc_net(net);
> 	struct publication *_p;
> 	struct tipc_uaddr ua;
>
> 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, p->scope, p->sr.type,
> 		   p->sr.lower, p->sr.upper);
>-	spin_lock_bh(&tn->nametbl_lock);
> 	_p =3D tipc_nametbl_remove_publ(net, &ua, &p->sk, p->key);
>-	if (_p)
>-		tipc_node_unsubscribe(net, &_p->binding_node, addr);
>-	spin_unlock_bh(&tn->nametbl_lock);
> 	if (_p)
> 		kfree_rcu(_p, rcu);
> }
>
> void tipc_publ_notify(struct net *net, struct list_head *nsub_list,
>-		      u32 addr, u16 capabilities)
>+		      u16 capabilities)
> {
> 	struct name_table *nt =3D tipc_name_table(net);
> 	struct tipc_net *tn =3D tipc_net(net);
>
>-	struct publication *publ, *tmp;
>+	struct publication *publ;
>+	LIST_HEAD(purge_list);
>+
>+	spin_lock_bh(&tn->nametbl_lock);
>+	/* Leave new publications on the node's list during the purge. */
>+	list_splice_init(nsub_list, &purge_list);
>+	spin_unlock_bh(&tn->nametbl_lock);

After this lock is released, new publications can be inserted into node->pu=
bl_list. Does this defeat the purpose of current publication release ?

>+
>+	for (;;) {
>+		spin_lock_bh(&tn->nametbl_lock);
>+		if (list_empty(&purge_list)) {
>+			spin_unlock_bh(&tn->nametbl_lock);
>+			break;
>+		}
>+		publ =3D list_first_entry(&purge_list, struct publication,
>+					binding_node);
>+		list_del_init(&publ->binding_node);
>+		tipc_publ_purge(net, publ);
>+		spin_unlock_bh(&tn->nametbl_lock);
>+	}
>
>-	list_for_each_entry_safe(publ, tmp, nsub_list, binding_node)
>-		tipc_publ_purge(net, publ, addr);
> 	spin_lock_bh(&tn->nametbl_lock);
> 	if (!(capabilities & TIPC_NAMED_BCAST))
> 		nt->rc_dests--;
>diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h index
>c677f6f082df..8debe23469b2 100644
>--- a/net/tipc/name_distr.h
>+++ b/net/tipc/name_distr.h
>@@ -74,6 +74,6 @@ void tipc_named_rcv(struct net *net, struct sk_buff_head
>*namedq,
> 		    u16 *rcv_nxt, bool *open);
> void tipc_named_reinit(struct net *net);  void tipc_publ_notify(struct ne=
t *net,
>struct list_head *nsub_list,
>-		      u32 addr, u16 capabilities);
>+		      u16 capabilities);
>
> #endif
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>bd91378b7540..9a218d137c45 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -422,7 +422,7 @@ static void tipc_node_write_unlock(struct tipc_node
>*n)
> 	write_unlock_bh(&n->lock);
>
> 	if (flags & TIPC_NOTIFY_NODE_DOWN)
>-		tipc_publ_notify(net, publ_list, node, n->capabilities);
>+		tipc_publ_notify(net, publ_list, n->capabilities);
>
> 	if (flags & TIPC_NOTIFY_NODE_UP)
> 		tipc_named_node_up(net, node, n->capabilities);
>--
>2.43.0

