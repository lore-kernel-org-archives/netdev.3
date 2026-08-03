Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3930D407;
	Mon,  3 Aug 2026 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722617; cv=fail; b=ifV0hQ8sLliqY9PYu2uVhl4LznOrhZjYqjb8QD/tDqs2Kf1FrWFFCsf3OGHBhPsjofkPaAzDBChmzwMDzTsoIHZ8yAJNgDox61/TZahd+t65k3NVBgdDjps0r17Jj8Qb7V8us9e/w4zkSFfkmVf3V4p1P6gw4JXVRXmadxBx/YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722617; c=relaxed/simple;
	bh=Oan2tP66p7uiJxl9W7a9WASkPYRy5AaiOPVT3eOMbns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CBlgogzKLw+iuA042Bdpo1fQ+dQ7+hNQkCNGv4SctI0vMTiy1EJWxGjNvKrPODvXzeDO19ppQSoSUdOP3m7aviTLM8r14Ujq09gFH7/8bpUzwhp9Gz96Hjp7G37tUZx+UkZmEMSDrIPivS1MjVXdaTU1JXdm0zipY3otIn9R2ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=LeqClGMM; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="LeqClGMM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWeshv+HKtPfGsT3jnJB9EPv6Q6nDwA3F3vCxhI91csqcsOcI8Xgc1YyOmYrHsUFZtQYO1sZ7msLjRMVPqAnosh8jLdgvCuJPk8dE3xqmoHPVXcFTGgcUFZ7TFEAJbmnEIhQkQXPl83D0cuijPjgO04lUFswl97egeqadeZD0s9eYKXTC2GeHHqVSto0zlh4Fcl9n5LViM229gXDfyl1TL2ZoEe/43xNVCGsp1q4qPJ28xj5oF4klluIbiFUzEaTrxgf7lZn8JyK93Vo28LdJoUCYSxi+5sos2G4sTrsEnFZ5rGh9UGiqBIdEVaP4JjYcDIXlUyKHFm2QWjnn2vdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaWxyBWlocY/Y/VK6RTpY5H5+5rVi+wgQkOm2pfkfeI=;
 b=ZL1ELYjkUelqf028SarpwevjSXfyReFEVfa9/nM4hb1GlwzpAQYN1Ys6STeA4HRXehtI0sXnn1OcsP+feKi5Clztm0NiyPfBApgwUs6aCAeT3KewNwbfIgn2PQd9ucIiaBEi66VK3mtALZphWC/a8dLzD+bllUYCIOtzY6MqmjN2M+6wyePxh4A83SfVYxwSp69Y9X8WjXiaEcjkUm437tEs3pTVzr5+A/lbTTQ4dc49nAPqZNd+t4pl5q1A4pwULgkIa0koHYoWYXy235Y3pdU9mIoDQeEKs3fBNuCEisPqt7kmtQOUY5TfKAFHrhvNUDE8TTJElF4i6d8MBnn9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaWxyBWlocY/Y/VK6RTpY5H5+5rVi+wgQkOm2pfkfeI=;
 b=LeqClGMMmJ3QQndHmEIbfOGR+UFsG85LuD5QATizs9/5AGfPp3isei0sN4cjXyWMdoGHuHojpWe+SIqnp6kJZG0LZGY23iyl/sQoGVySaEDAxY0llecrg/kUrVjEhmuqr5AvFpWXVX6auEsUOzLNLNRVU8XiK0uTcSk4sIWSygGhtYaZE0nIxJzDFuv2CRoP9B4Isg6k4yp+0Jv9jvYVUIupBqUXOakl3eMBTHNMxyNRbfYyGmmG4P87C7ggw4kEpe3+tSurKq5Hxgvoty0SCgOPlzRvhiLMyMueLuHB7OuIk1iUv7rXuHdlonz7wZ6neDVb2GrDxzl4JT/InzQtBg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU0P189MB1868.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:348::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.13; Mon, 3 Aug 2026 02:03:29 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0292.012; Mon, 3 Aug 2026
 02:03:29 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jun Yang <juny24602@gmail.com>
CC: Jun Yang <junvyyang@tencent.com>, "stable@kernel.org" <stable@kernel.org>,
	TencentOS Corvus AI <corvus@tencent.com>, Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net] tipc: read le->link under the node lock in
 tipc_node_link_down()
Thread-Topic: [PATCH net] tipc: read le->link under the node lock in
 tipc_node_link_down()
Thread-Index: AQHdINd+XsVb/aMoek6+cgQY0I4qUbaLk7zw
Date: Mon, 3 Aug 2026 02:03:28 +0000
Message-ID:
 <GV1P189MB1988E2D270907F4D65EA2999C6D52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260731102145.33622-1-juny24602@gmail.com>
In-Reply-To: <20260731102145.33622-1-juny24602@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU0P189MB1868:EE_
x-ms-office365-filtering-correlation-id: a6e5c80d-665f-4083-c58d-08def1036967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|11063799006|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info:
 2//48yM4IKBaFiz8Cuxlf7IODIMOIPTi6op4uBSpySQi/Jbc/OwoOe//TFAkYMOdY1yp1Xinj2HvfKutMgSrMKyy1go0dKb3py+Qa/ItyCKL8AYfbRPnzQPRDePKakYNLoGtM2GTPt8MAWm0m38zZC2lo1yKDwaYuYe5tm+7tpKGt4yDjg2yi+actNu06ICzEGtkTi8oX1VmgosDYwKYj4NpouFvklNMrsKkR41Y/jwAqWpeLKivpUI4FcwKKvuPHNhWZrjfCxS9jtefJ1noLKYQVRcW2EU9xIBz5rjmzK07hABTR5PV+jWuBeg9MXNJQVdn8q3QO9f2fsd9yaIM+ftlRGddxY5l5dCNtv7JISO1BjsZ8BZ+YSv5PMKtoEBpeIciSchdnaPBRYdOMDIHbrMu+VvH4I5EwUK0OxWpEj8Aqrd1Bu8rgousksXKNfvrm+lsve30X1p7ph67vQXjPNyi8Ri36JhP881RL81R/WTGUoY2Z6n1fqlvSWk4wWlaH4xZoQPoEi+05x4Q0fLQr8iURgDSKDplvWzoy3UMgwSJ86wiqo1YhiOCunojXdTzgyjQRrDEfKa8NG3I7MiG+Kx28K52ut/+WkUSo2kDTfnQau6vpTxOXmzY2Du09hvIqJElGnPvBYfZMBuwjqNygb95xvKzDyNCWCx+UtCAW7sxgMVQBGaNfHKI5HYW4YENj1XiMQ/KMCGq0WyOKTXD3lbWkOs+GWL65HAMfotomZE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(11063799006)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EdJ8+CpxwnRvqECTq/jWP9vJVyPUqjFPyrTM250PaQSiOZamoApQQt20ECSN?=
 =?us-ascii?Q?4XWc/hJDJgGV3Q0TKLKQtmBlnajBWDOB1SStu9fBKqB+nQV49UlHIn/0lKlC?=
 =?us-ascii?Q?S5Cwd/R55x1iH2TWdW5vi3+wT91ZRNyOlmrnhn99htInptOFO3yPJGewWGue?=
 =?us-ascii?Q?yagD8ey+q5OqXxpi46x/ALFlZEPpaYhFoQxPOol/q/ZVA8c4buAg+hMGang7?=
 =?us-ascii?Q?JvUMnZHTZfzbv5OATRSciAXAizmeVFnclOxM4P/3yMtPVbV3AdO/oL1swbUc?=
 =?us-ascii?Q?mNB915prFO+GwYPJoM+P7kI4PbKGm5Lmz6vdPbkPxjhg75EhWK2Df/If5dhC?=
 =?us-ascii?Q?otprpnRNHFSsUWr5wP6T5ecohkXrltwumwObgkf7+AqtF8BZ0ahA6H18PP4y?=
 =?us-ascii?Q?GJKsXFKiBCSCVsgnGW9Z9LddO/MApmRqHrvpJrF7jRcHU2Ht8fSKrYNAtKIF?=
 =?us-ascii?Q?2EAhM4LEQhuM/WtNh+7h7+uWAasxcOfVlyUEI3HcEW5WYHLOGF1VygPCRhF3?=
 =?us-ascii?Q?gV+QXf+s0L8YCy6631hIlk8MTgefDL8yKB23RYjpzBEwKHajl8kMmiuZBmyp?=
 =?us-ascii?Q?y07c7ak4Hj/3d19aJsvQ9ldXrfAYo9Ob0x7YE+KSBeq3xXi8D7BjRAsid4y3?=
 =?us-ascii?Q?jZb/FwkTGLz5poBjpeC4izCZQPY3Tz1SY8HZMwg9qAFT/whoNVFi6YSTDuoA?=
 =?us-ascii?Q?Tl6HmnCrp5t353V7pkXHl/TXz/uvjWSia/MZxJKZoUEJufGDfvKhA/6bAnFH?=
 =?us-ascii?Q?eJehAlebmqsQ6mSN1hLsq3LPYqOuqKsrYWorfHyowK2IHpwIOuYFgaK3n8XX?=
 =?us-ascii?Q?q1MeOhcSDlO5nTqxqf5OAzpYy5aJnvxl4yPXpg9PT9HQEvRxTg0Y1EVKxKpl?=
 =?us-ascii?Q?4H7XHlbL2piUOlib/qWmPuQlF+zkn86TaW3GgBsK94pEUPJJgGw4rwDkhBUe?=
 =?us-ascii?Q?n0/HulGKTHRJUViebeicyHeFI16E6SBTTKjuVU/jkFiks73pFAKlsxKdbSUY?=
 =?us-ascii?Q?uiMImG0WGO83gPzBr6/BdL1cHRsRnoYGAN109Cgn6rxO+gzPFY31Vyh/CL3F?=
 =?us-ascii?Q?Wci4BizjblzDtzMvl0noWWhmeR6oldBS4zs49tEs/cNXITpqR7t03rfzBGo2?=
 =?us-ascii?Q?LRj3rcnJ7em90dhcFucbRXuUPYphXIt/D4vB2BKWO9HlcJuEA+sMj2zJYsU/?=
 =?us-ascii?Q?wu4QGMiOO1V5RVQTabAEBfUArCFvzG/gQMQ52ogGBNlO5MkHZXB4vyXGrcdo?=
 =?us-ascii?Q?3J2i2cCNHnoK1GrLkO/rR2kVBfvVn+hqkwfuNsolS5ZHCHT4rT1SlAqy42zl?=
 =?us-ascii?Q?/eW1QrwCWTa6iqhAerMrm/Y1qXxS+4c3lPJjXdylUEobdgw4UWAOIrMVQWh6?=
 =?us-ascii?Q?ABdm1UmqlUUxq4jPfv6TEEPO7XdAFfP/4yA/dMERreE57mjkdWcZKO07+xuH?=
 =?us-ascii?Q?ZuVRdyYtuo25STg0uCKDYiebRL8yh5h7c5xfmzLEgOIO8Qv40ocnrIAIWzSz?=
 =?us-ascii?Q?vG3+fdI9pFvgHZVRi8bwUVi19EO2ndn0obnvg5NBNXYJYj4aR8XrTC6/09sC?=
 =?us-ascii?Q?8pkXKscMfeItKhBa1JEM+gOtH2I6qsILW3710k0MnDFqPFzMMqvr4PYK2x30?=
 =?us-ascii?Q?4bUT4XR+YLESzHsSOFOLcpVyVuNRfcFQ5x7WDye7UZiBuvwChJL6JJYKFgu3?=
 =?us-ascii?Q?Bj3W9GEhxUHlBZgKljRtY8mnf5MrZ0qB5CTUxo9CvZU+q2Rk/qeP/ifhOgvz?=
 =?us-ascii?Q?vxbPDA5Qog=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e5c80d-665f-4083-c58d-08def1036967
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 02:03:28.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwQpus7ig916R92P/9fRmJtTINKd96mat7VzRMRkK9ZMD4mwD4MXCXl/p29YP8xS+XsozkiGO/3eF1b8uggEgUO3wChUAJV1S/26VaNPknk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB1868

>Subject: [PATCH net] tipc: read le->link under the node lock in
>tipc_node_link_down()
>
>From: Jun Yang <junvyyang@tencent.com>
>
>tipc_node_link_down() caches the link pointer before taking n->lock:
>
>	struct tipc_link *l =3D le->link;		/* unlocked */
>
>	if (!l)
>		return;
>	tipc_node_write_lock(n);
>	if (!tipc_link_is_establishing(l)) {	/* deref l */
>	...
>		tipc_link_reset(l);		/* write into l */
>	if (delete) {
>		kfree(l);
>		le->link =3D NULL;
>
>The delete=3Dtrue caller frees that very object under n->lock, so the lock=
 does
>not protect the cached pointer against it:
>
> - CPU A, delete=3Dfalse: tipc_rcv() on TIPC_LINK_DOWN_EVT, or the link
>   supervision timer via tipc_node_timeout(), reads l unlocked and then
>   dereferences it under n->lock;
> - CPU B, delete=3Dtrue: netlink TIPC_NL_BEARER_DISABLE -> bearer_disable(=
)
>   -> tipc_node_delete_links() -> tipc_node_link_down(n, bearer_id, true)
>   -> kfree(l).
>
>The link is freed with plain kfree(), not kfree_rcu(), and for UDP bearers
>disable_media() only schedules the asynchronous cleanup_bearer() work, so
>its synchronize_net() runs after the links are already gone.  An in-flight=
 CPU A
>that has read l therefore dereferences freed memory once B frees it:
>a use-after-free read in tipc_link_is_establishing(), and a use-after-free=
 write
>via tipc_link_reset() on the establishing branch.
>
>  BUG: KASAN: slab-use-after-free in tipc_link_is_establishing+0x3f/0x50
>  Read of size 4 at addr ffff888111f90868 by task swapper/3/0
>   tipc_link_is_establishing+0x3f/0x50
>   tipc_node_link_down+0x1a0/0x450
>   tipc_node_timeout+0x63d/0xca0
>  Allocated by task 7903:
>   tipc_link_create+0x17e/0xf20
>   tipc_node_check_dest+0x98b/0x1150
>   tipc_disc_rcv+0x9f3/0x10c0
>   tipc_udp_recv+0x42a/0x7e0
>  Freed by task 7903:
>   tipc_node_link_down+0x301/0x450
>   tipc_node_delete_links+0xf5/0x240
>   bearer_disable+0xc0/0x240
>   __tipc_nl_bearer_disable+0x21f/0x380
>

Please update the commit message with decoded stack trace (using linux/scri=
pts/decode_stacktrace.sh).

>Move the le->link read inside tipc_node_write_lock(), so it is serialised =
against
>the kfree() in the delete path.  A racing teardown now either has not run =
yet,
>and we see a valid link, or has already run, and we see NULL.
>
>Fixes: 73f646cec354 ("tipc: delay ESTABLISH state event when link is
>established")
>Cc: stable@kernel.org
>Reported-by: TencentOS Corvus AI <corvus@tencent.com>
>Signed-off-by: Jun Yang <junvyyang@tencent.com>
>---
> net/tipc/node.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>8e4ef2630ae4..918e59362d07 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1063,16 +1063,23 @@ static void tipc_node_link_down(struct tipc_node
>*n, int bearer_id, bool delete)  {
> 	struct tipc_link_entry *le =3D &n->links[bearer_id];

Above node access also needs to be moved to below ' tipc_node_write_lock()'=
.

> 	struct tipc_media_addr *maddr =3D NULL;
>-	struct tipc_link *l =3D le->link;
> 	int old_bearer_id =3D bearer_id;
> 	struct sk_buff_head xmitq;
>-
>-	if (!l)
>-		return;
>+	struct tipc_link *l;
>
> 	__skb_queue_head_init(&xmitq);
>
>+	/* Read le->link under n->lock: the delete path below kfree()s it while
>+	 * holding the same lock, so an unlocked read here could be raced by a
>+	 * concurrent bearer teardown and leave us with a freed pointer.
>+	 */
> 	tipc_node_write_lock(n);
>+	l =3D le->link;
>+	if (!l) {
>+		tipc_node_write_unlock(n);

Please use 'tipc_node_write_unlock_fast()' instead.

>+		return;
>+	}
>+
> 	if (!tipc_link_is_establishing(l)) {
> 		__tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
> 	} else {
>--
>2.55.0
>

