Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21FD30E85B;
	Mon,  3 Aug 2026 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723059; cv=fail; b=Ff86mhCLtL00v3ASZTb/yFgZiKphXx9BNhDnySDgvk21HwoL+NOZ2+1OkdnzNL40FTtFpnj/OPKJotplo7swo63yoJaaiVSl6NQBJvKZ6wgt0N3gPYzn0/iq+VtgoScG803/SUiEBOjXPBbi0cI2ltY+utNMdyuihlBZhqkYyXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723059; c=relaxed/simple;
	bh=VIO0jAjE7QQQa1I8nbOGp7phdHMRrUj/UGRTIIOjIIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oSzsFrk/HbZ/u7pQlgKJRP2HJv/lr79GPTpbbvEJDO/joCsyFtD41574ZT5S8pbECssgRlTpDZVZ6Izmw1BrXy9/sMdtTd3k4XhkWVR6bCdmf+GFD6vTaZ2DDFUG/u/eeYi8a42OpsCdfJNsSey0VE3dtjMAWeFoM4YFU5G4Sos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=NE1CcgXq; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="NE1CcgXq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHmdKfAznYWzk6emzTFyXnStlrn3r/de3610mjS+bNrw42XDGTfA5FuJ/oyIzt4RxZdsPcGIqzAyBxXtgAyPxbUHfO8dZsYyGfO4GhB97lUcR9abVBPmJ0o0Ha+EU+jSNx9dR4MVuXgEX9YgrFUMyeq30EeJDyNVHiNY4QGEuK/LJKwISYHLV4JKkf3Hj2Pz6/Z5zyyym07ehBCFAxPLx3I9i8Y8Qr9bbZQe9xdaNnDFfRRMj080auuTxK5nOwRymIwr67zaZwjZoDptbogvqXOnGFn57mJBKy476vhYlnb51rcUyxBZiqmr9M0XxYnOZfCtOmp7YflCipLTOEhYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7YtkKm5Mao8VdicMYuEkdx7rOQPZsmaWB9VxVrBtpY=;
 b=H3uaPKO1iTTze7tK6ZcPoQrIqMvnZpLseKF8bT7BeITLUSpEZKjPn6bn15IayRICsJR2XTI68HftBmxXLRZWL98Bvy17CO9cv5Ir+/Eye6bVi5EPDODrwYMPRzh/6zTjZMsN/mysYNaCVdAYbsPtNSlFOGHAk69hI88sEFOpsSxLBpTz/taqH4wLmm43XBIBdfdc294LC2pBOHF/zPhcaD3LpuDbVKJ5rkuV7R6/P5a4vUgeUlsPGL+nwjV1MDHx24AaASL0FV/p2bSumfraur7FJ2Bhyz7aN3jn7ocvU4wW4FEkFNKLLOtmnjyP1fp0qrtPivtTif/F/VHco/CS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7YtkKm5Mao8VdicMYuEkdx7rOQPZsmaWB9VxVrBtpY=;
 b=NE1CcgXqbTtOBPfEkGTQrVZ1r5xhxnQ0djtAB5OW3GYZT2YC3CCTAwn3oter2MYa4T4KO4ryIDUfCdLuP7vlpqRzQuECy9aHN9OpjkNuAQbBvG4wOzO+jMgnJQhARFkDQ09qY2ZwIpnULFnQm+0v6OO63S9dIlM2mArboNFIyVtD5otZgiWyvsISfKmrrfMI9WHrgSEsbuoUqy/Xifs/SKGLK2kspp2Bq65rATh21wtsjqAXEWGRGff6HQuUdLxLZq1sjzuY2rBPgh36f87JEkAoPCMsTuO6BqrYi6k4L3jMfoBU0baMMs9FQmh7mqHmanSua+OnHi0tlrCkauRPtw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA1P189MB3652.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:504::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.13; Mon, 3 Aug 2026 02:10:52 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0292.012; Mon, 3 Aug 2026
 02:10:52 +0000
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
Subject: RE: [PATCH net] tipc: reject name table updates with invalid origin
 node
Thread-Topic: [PATCH net] tipc: reject name table updates with invalid origin
 node
Thread-Index: AQHdINhDX/sK5ru1HUu9slybUJTejbaLlweA
Date: Mon, 3 Aug 2026 02:10:52 +0000
Message-ID:
 <GV1P189MB19887144315DA4A6AF16FE02C6D52@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260731101657.29119-1-juny24602@gmail.com>
In-Reply-To: <20260731101657.29119-1-juny24602@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA1P189MB3652:EE_
x-ms-office365-filtering-correlation-id: 45a6822d-444c-4bf8-ec0c-08def1047196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|4022899009|23010399003|7416014|376014|22082099003|18002099003|5023799004|11063799006|3023799007|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info:
 AK5cyiA3zAuMSDQQqV/vQ3I/fEoLVsHM5NDCYb3urvhWyA41UdGjch0T9QGYI9D8KPAj4Zh+LmGCjhqhD+HFzZk8UrSGWv+4Ys1ssyWkSGDC5v09qt4z8ZgYlCQjNn+ycr7vJK2cJxaK9D12lGSuFaZwEic0lcVcQT1/GjLAJyBF90bbtxjOGaoVT4Af2C1wDj+r/Sf60nN798G1UiNq6wWwDfRJHkGnNuInJjQRckia4bKoAVUK3sxfrHl+6kJjmr2oWe0CHht4wFBessSfswHcBhnQKO3JOyCeAsjJxmgNmvRkbMbQu3dqrbdccgT3W+PpVRaOt5pDiL+m0qYTMQi9nOK+MdUSSTXE8BzOoqbX9HB5U4i+7hm/LuMtl67Efh9DPcyx3uTFub9HzRrl8rW5gnDVWW0OmeNZM0yK9ER/XLMUitcwa57oDCLjN+g5PMMHBcK7j67XhllRE0CBjPNDfLnTdaPSFOOB5/BJ9UScwOhZ1G5dP1IBMkgTwtcLjpsJCW+6i93YhEqBhqeBJUod0yCxxl1kB+NzPTA/RSCN4GyDgybfzCV1HJk+CNPQIyJWcO5FPe4og+mOSHg1O5Uh9FQfxQOkzOXzrB3UFP3hYhbWGQrrowHQyTTpQMcyDBmUusSocCW9LfC/qgFG7VMWd2Cgduj1XQjallai6sxlLYG56VEZiPdzitpXa7HdWVy1kOW+fJF0AO51MyvNzYBtTiHNEMm3da7Pb8CwcXc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(23010399003)(7416014)(376014)(22082099003)(18002099003)(5023799004)(11063799006)(3023799007)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dCUBfW88hzn7VCcaw1txQeyoHZYoovfCzdxJer3KLKLbC5E9Ff8GeKNqtHjE?=
 =?us-ascii?Q?IgW7/ajA3AwJFvoIaDcsxszF6edCWJtq3Xe7/56/juv/DL7wL8EORkdSQfK4?=
 =?us-ascii?Q?VpMY+q+WvWMroWqSJP77hUBnwta9/mzRKWJeyZM6yMLKV1izH99J7e1FQXy1?=
 =?us-ascii?Q?flPxyE+8LWpd6FHHEJuq+fqZxA/rv72Uhr5gtVSht7PpNvqx8OtisueiP3h8?=
 =?us-ascii?Q?hGEuzBvmmiuJVXk7wpYPjmItKeZS2atSLbHjwOXEHsXc+4MJyO5s7fRPLvdo?=
 =?us-ascii?Q?Q896/dxscKOp/AJRI8ICe/iwHHBiIYsx7Oys3jCW/CFAwPFBGqELy3NeKnX5?=
 =?us-ascii?Q?fCcwSIsHOpZO5bbO4XQpI8SW3XfHwrkvUxUODm9mfEdUEMGA7ikKZtoDSrgh?=
 =?us-ascii?Q?cZgOUfelvFTOMYcGlcdXMmSDBZ+O43f1ZOdm0cbwr3zlZTdAgs6lva5u9Aq+?=
 =?us-ascii?Q?NzY35CNE6bijcSy0aoAIESuMXqwQCmK6NZxn1mgzQswaS95YYesz9TkmNAsy?=
 =?us-ascii?Q?3zhCt2Z1PlnB+xUZooIWOFUYlWm3XFJG5fwNmcNeoBUCNTqjYHl5zdYM8Cpx?=
 =?us-ascii?Q?a3T3yHzdM53/0coPrOdsJB2PbpyJ0ohnAyMZHYEQZx097/qjQBbGeJ/T07gU?=
 =?us-ascii?Q?JQOD51T7Iy8ttVW3L10i0vutX+iqR4D6mkw8H74k2+o+MMeRAKhRir34EKTY?=
 =?us-ascii?Q?lZByoaP1AoN5nfh3Yna0HwNscq56TZ54iPfrOIgljPvC4weLOVFgLhBIExwt?=
 =?us-ascii?Q?7rHJRdxjReq2tN7k69Ux2RFns94rWKwLu44zSsWHAk2RfsmYWonT5SZ595jo?=
 =?us-ascii?Q?uKy3c50vsXIGbrQg5smoP9QWnTamMIMp5URRTjI5zpHUz3vp68pyXSiddy4Z?=
 =?us-ascii?Q?jQc2XMhw4ndk8MH2RrrPHTuewRyVFOGgMdfj69y9fquIbewSwvjkyLWStCjU?=
 =?us-ascii?Q?A+nQ4RAllVW1knejVuITPW5rHxdpX8NOBd1IRZXzaXU6S87ye4eW5aQNJua7?=
 =?us-ascii?Q?XJ6aMbXEF4pIYhrgKsyBHSILsTXXFtNpPqEdbRlL4SfVukH7jRsPlsgbdCFE?=
 =?us-ascii?Q?cMdVCNLLx1CL7DzqohEXhwIlfb5QE+b7TYk3ci77z2qnvgPOd/raQx+2cj//?=
 =?us-ascii?Q?aDQBeof1mDbVS4Qm6ScnABjrADnm4kppmAzaL+DqXATtAXypO21Y3Dusvfhg?=
 =?us-ascii?Q?xqhm93WTulP/Qs+L5HQmU5aYGTqKCqKJFA9IHgGdBvjLrxfWpeIx33pr73/S?=
 =?us-ascii?Q?t9CQpbJeU/657CGTkgTBj96iA7SjLFAEnWlTI1XLuxVrkYmXl0Lk6ttOvZFx?=
 =?us-ascii?Q?cCYv6J0nO4rAKynpQYLfsUJPk/wLypNt4sBQxF4lEgLw7Tj1c1UmJ1RDQiZO?=
 =?us-ascii?Q?g4iFoIwwOQNKv99lzg1vkgpPCNo0yDSm1IgH4heQRaoOoKvdhQuUd5IvNtDi?=
 =?us-ascii?Q?ABLGpEvlePxPgERBzjfQ6gCoeZnI/2F9f20Rr6jw5ftSa4mmhLIw+e08lZZh?=
 =?us-ascii?Q?7s3ak5vYlM3LKCo+If3y3nMbTtZABPEFp/H83u8PxHfuFWCZ+QHegX8AFhpj?=
 =?us-ascii?Q?LFJYNNEkGHp706fzzAv67243cOQN4SoMVBZM+UzPz8ISbylFOY0ouMJ+REnT?=
 =?us-ascii?Q?160AN9MUrB/GTbQ009j3xXWZduU3GsenLnTXFUQu/dUtLmT76acxVfS/4XDu?=
 =?us-ascii?Q?lGkGXFmLE8GwYy0rka/FwNyqXcReh9+pbbv40CFyaKeo0zQWdbFnyCTI8Hug?=
 =?us-ascii?Q?XiYrp0YQ3g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a6822d-444c-4bf8-ec0c-08def1047196
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 02:10:52.0696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZQVhXTfaLo5nbJtKa7wtdwqBI4uLzt5gkMmJ6ZtSght6crfiXAF1Qs/94dOS14RIEiY1l//kMPZnnNrxwKhh9jdgGMFaSfuCv3EuPJ8M8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3652

>Subject: [PATCH net] tipc: reject name table updates with invalid origin n=
ode
>
>From: Jun Yang <junvyyang@tencent.com>
>
>tipc_update_nametbl() trusts the origin node carried in a received
>NAME_DISTRIBUTOR message. For a WITHDRAWAL it removes and frees the
>matching publication with tipc_nametbl_remove_publ() (a {key,ref} wildcard
>match that ignores the node), then calls
>tipc_node_unsubscribe() to unlink the publication from the advertising nod=
e's
>publ_list.
>
>tipc_node_unsubscribe() is a no-op when in_own_node(net, node) is true,
>and in_own_node() treats node 0 as "own" (addr =3D=3D own || !addr). So a
>WITHDRAWAL with orignode =3D=3D 0 frees the publication via kfree_rcu() wh=
ile
>the paired unsubscribe silently does nothing, leaving the freed publicatio=
n
>linked on the owning peer's publ_list through its binding_node.
>
>A subsequent legitimate WITHDRAWAL for a neighbouring publication that the
>same peer advertised then performs list_del() across the freed object, wri=
ting
>a kernel pointer into freed memory (use-after-free
>write) and corrupting the live publ_list head. The whole sequence is attac=
ker-
>driven from received packets and is reachable by an unprivileged local use=
r,
>who can gain CAP_NET_ADMIN in a new network namespace via
>unshare(CLONE_NEWUSER|CLONE_NEWNET), enable a TIPC UDP bearer, and
>emulate a peer over loopback UDP.

Please do not create fake TIPC protocol message in insecure environment.
In insecure environment, IPSec needs to be used: https://datatracker.ietf.o=
rg/doc/html/draft-maloy-tipc-01.txt#section-6

>
>A name table update must always originate from a real peer node, never fro=
m
>our own address or from node 0. Reject such updates up front:
>in_own_node() already covers both cases, so a single guard at the top of
>tipc_update_nametbl() drops the malformed update before any publication is
>removed or freed.
>
>Fixes: 37922ea4a310 ("tipc: permit overlapping service ranges in name tabl=
e")
>Cc: stable@kernel.org
>Reported-by: TencentOS Corvus AI <corvus@tencent.com>
>Signed-off-by: Jun Yang <junvyyang@tencent.com>
>---
> net/tipc/name_distr.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
>ba4f4906e13b..a496e2e9ef62 100644
>--- a/net/tipc/name_distr.c
>+++ b/net/tipc/name_distr.c
>@@ -286,6 +286,9 @@ static bool tipc_update_nametbl(struct net *net, struc=
t
>distr_item *i,
> 	u32 key =3D ntohl(i->key);
> 	struct tipc_uaddr ua;
>
>+	if (in_own_node(net, node))
>+		return false;

This is redundant because ' tipc_update_nametbl()' is called when receiving=
 messages from other nodes.
=20
>+
> 	/* A peer-advertised binding with lower > upper can never be
>matched
> 	 * or withdrawn and would leak the publication; the local bind path
> 	 * rejects such ranges, so reject ranges learned from the network too.
>--
>2.55.0
>

