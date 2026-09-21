Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BD2FFF8D;
	Mon, 21 Sep 2026 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956395; cv=fail; b=KD8l45VvwLiLXRKXFA4WBwGuaz2n+tQKzESeZxeiPJC5Y3ERd06MRjESDfjnVpvi9kUY5sJaGhv9yAHcUW20waVrMj96gBdyuESCi9X8/NQncsnOsvJUYROWyIgzek5lsbbSl+lDxpL+zawo5YVeKiHoQuluOMkUMMLTGcQVviM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956395; c=relaxed/simple;
	bh=gyPlK2hhKirnea4fe/YsqtdUBD/els+sODeF7dHeVk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hw6ZnIRDNm+4gmm4JeGgUWFuPvu2lLzRqeZlDjz/oiFA/M9GH7+/kIT49NQhPL4JRiFTLjcX45tOvmyiYXpZE2rS9lv18xLzFjLDhMm7rCjVfmsu3ur69DIObpF9h3HFS5WqGkW1bUMVnyTgWSBUBn1nsGW4nU48dp+1ivMUCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=N+tR2u+h; arc=fail smtp.client-ip=40.107.162.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="N+tR2u+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWCzpWctAmikK0E5BWH5w8hL5k1f7XCAqZzmzKYBdZ9ZNnM+OWdmo6E19xj8JWUEGwpNVClx4mF4vz8VgUKnDRWsyMM3+JUNGsFIoTpr8UGIIVLJfEzireWeuR5LLjZbltUbBN5cEvgSkAHORXML5r7eDdJYr1jtbLmSrbB9PaUslhToBeNGaF8Jqf7UtxXxGHEkaGOgyp0kbsdWg3PAjJIKQ0XpV9Wxb/FUiuKirwA+FMK9O199C8kxbdnf8aHCfxXsZWqLp6umzGl8wKqZ1F9Hz5z6Tesy+2lPOfjcrZ/7W8iL5TZOoQuo3+9bu0qvAwAh4/HhjLGvEQZAcbHmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaymLsoiANUZy/iHWYtCH50I1GhcXThrrI5CTO9D9TQ=;
 b=qypI0EOeClena2KMFXS3oLjTrQ1pDYbkq6h61VkclLEpxt6x+B788jMd5uKjfSv6n7vA6f64IFaVEv1QKW7ABbIyYSYmPtsFioITZ48oELEtAkniks4etKEjaG3GGa1W4TIpWIHghkdr6UWKppCsWWEAONk0EJNOSJpfXZeLQtH7R9hXsFCcebDltsS1ZXyfRU0WpCM/6x380ZvGcmrPOcjI1FM43Dcc5+c6cVRrZWdBcctoyQI0GmOD7DgAqJPFC2bJ1LKzRPRI9NdnTqvGGHZK4CbrnJLufGSMowsF6/ytyuECicSwpGjWqEyQ/CRBo+V9aU8/lLwY/n00s5Qj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaymLsoiANUZy/iHWYtCH50I1GhcXThrrI5CTO9D9TQ=;
 b=N+tR2u+hKnPVNikqHeDJ4BBFaa5vY1uEiitrS/5VhC+3aTb5YUX5qxbya9cWz17Gz5kfenDPIYxL4nm5LnzaKLcy6hczFRHsOWhwIimVzuumClsM8ebTuvCLZYIBTG0QQW8obEBXe0CKIc24DIb8C6TqGN0Q41o3KNiHdQB9qgL5Q8hG7wk11nQ6K2hCCsBYHmvRbLAhOW4cb/dLPmqpdxTJ8S85dssJtEKblns7+rq6TgQfwBtaPhrNPdYq8Y7RP2MPzwVFldk6yt9A6WHdIlfe5/e1g1aynNOtGW7ZXaxjAXyE12xvC65Zi/buGbQVodzCcVZwWiUWyCPVzG/y5w==
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by AS8P189MB1301.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 02:06:29 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 02:06:29 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Subject: RE: [PATCH] tipc: refuse to attach a second bearer to a netdevice
Thread-Topic: [PATCH] tipc: refuse to attach a second bearer to a netdevice
Thread-Index: AQHdRw3+jmCByXrtN0+dkgDWF1TMtrbYRWsA
Date: Mon, 21 Sep 2026 02:06:29 +0000
Message-ID:
 <DU4P189MB3750BF183DB76F1E3AF58B79C6842@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn>
In-Reply-To: <20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4P189MB3750:EE_|AS8P189MB1301:EE_
x-ms-office365-filtering-correlation-id: 3fb6ba15-681c-4a5c-529d-08df1784f308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|11063799006|10067099003|3023799007;
x-microsoft-antispam-message-info:
 qqdlfJ1rLAJNu6lFFbFxLYfe5OBeRsD1e/nrhsQk28meZZsKp6Mbz8j9nXl1Uv+A3WScSHB9CitaOcOqSkL2H0yG/YUtTL4iVnYYu8kynhv3p9+qkmpJYTrHHqjSJD6qqmwzCFhBQrLemStsK/+cDnMQJnEa8XI+Co3R1hfj8RtCgEsra4i+kPH7aZux8iu1H7yb6qF2Sz3kL7r4nQ3WlrGjUe1MnFQkNTfLZqY8SzcyPIyZHphsMSvOiYTr39Rr9YuaMkXMBXgzpLlhKNp6UcAoEZECLj32kad68Qn3x5M66Cqkbt6II3ob8X3zj/UxNHzrvs4RzBQ57ZzQtGhPx4nLBT9V9j9V2Drq6/f1Ld3o+rszzM8tERcLPseRhoo/smwrIJAbQXFQQPyn5ShjKY8EK5wb23csNe2fBfYaDTU1/3ETkeK8qUc+1rP94n94gmR7vPBGxAQtTE7X0nrP30p6mt0VuP7K9u8O/lH5OYHs0ztzxp78hcPKsIiKq7A0yTgoK2OeXOvuzHqT+e5eq/aMNj8Qsc/RHKPxWAcZp4RiNQyjuQipQ8kq2AlCqAJMdjuFhcx3YFKs/5tgOFfGbM3oDPnMuU6bK1p3ZzlcN+ZPRsxjHQkXQIHLu22ExkpoxW1zgClsYiGJmAJ1xxBLY2dxyZIIOM24tWcHJW7sEatRSoj96oqjNKlDG/prK7qaXmpxiciSYizOzJymtucvdwoyN/gTq/oceyjtZvSk1hw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aFL7iw5ghLF3e5kwDGMNpfAH/Lehi1sDPoLp1fDvvn6tyJyGxeJAmPoc6lAz?=
 =?us-ascii?Q?HnX7NGe5lZz5IN9Z5eFm5If18KFLxYa8Ld5FxvOXr1kdtOroPvm00iFUtm4/?=
 =?us-ascii?Q?vqXZufJqRp1OfrAcXtMAn3az8JZ2f6o+uoIRWuyLWIomYM8Sp2IQAIcIvfB9?=
 =?us-ascii?Q?DAuN4vW31yTTFt8B2K8FVLAp3nsYxuxhI84pL/wK4g95K0E9DeKxhUAtvVsB?=
 =?us-ascii?Q?3YWGwQuYakcMEG/+PfIHoRr1xdG5d3Qp9yvuRdDt0EDveOnNxYjxzo0+elkJ?=
 =?us-ascii?Q?n1IBKSu9NcrZjvwSoQVoF969syZ4NjCSZxJxFDWTQ4+1hbfuaA6fufmnbiE5?=
 =?us-ascii?Q?l+DAYd3FyVq+umBjEXmluLck1uELIKq1G4gW3pxaZDbN712kbMWfRjATRpCx?=
 =?us-ascii?Q?P/GMuikOQFfYrAeA182R+TiU3otpMnPdZNMq6p1UrRk4gcKyumMOo8cE7Piu?=
 =?us-ascii?Q?N5SQnQktp3q52o3U8fdTIjGZg47pJtfXtZpKu4u1m8FZwWhMcfnNAh/RlD4/?=
 =?us-ascii?Q?jYBKtieVdMmGOX+zCrOdEGxe5lJOHX2emikJPnjNk6duXoBMhX0tvV4AY3GV?=
 =?us-ascii?Q?ukic+Xj8l5LRPtXCzr3xWMu7/9h7yctCi55uGCLApXuEQvZItepVyyfAWLqY?=
 =?us-ascii?Q?JHRuA4o0z2UeYow7vh+s3LkKcAGKSrIN+lXKbavDnFQI2+Tps4tC7An0dMsp?=
 =?us-ascii?Q?Bm4A81E0L4eCiu07ibwz3ZVlLChPGZgzs7+nrmCbyMl6QgORCGFyIX3xmca7?=
 =?us-ascii?Q?/Js1CLKthxEsCpHun2qY9AD7JHl8gjZPTJiI+BaMXMnshZRVphZ94ezroa4J?=
 =?us-ascii?Q?XM0eV43f7n0fh6HKiYF8A6UEAUMyeBsk4fpyuQvSmAaxwid2kwuBOQzTOJeM?=
 =?us-ascii?Q?CcgORw4/mQ1NdazO5KAYOEkqF8D8xKGyHC1vWjO9yl9D+AjMtV0nbELN+bZl?=
 =?us-ascii?Q?RtftacJqhOAWiUOT5cifWW4xwXMgSLcgMfv8xYPuqoMdemwS7RMGxqsPmDoJ?=
 =?us-ascii?Q?dqbUgLKvOu8J8Sm61ZonW08Qozlf7YhfM1pxmnFPcSYodL2tFIZNW8swd1MI?=
 =?us-ascii?Q?FoDj5+oWLbmZNtCcvf0sIRfVOmjWGP2hjFTfQV9K+rtL6eX75PRSbJYEgZie?=
 =?us-ascii?Q?DD0OITTNlR9pTCSyelPCkDYZ/uwyw7y5+cFK4NIQWZGrYPBa1CY21cq+H+mR?=
 =?us-ascii?Q?SzBt0jPUfQPbCDyOB2GUd06sx3dMlnixn+Vxest4DMZ5ij3FyllqQ3+k4tuK?=
 =?us-ascii?Q?KJ8lnifhAPJ1e2NpkYcSWECMbNtYofIGQDDBczvs+ogYzQcH2lpYxeT9pi0n?=
 =?us-ascii?Q?cEF93j+akJYJ7yiZiWQ5yHPoMXcMM2DLj/sZGnlBUr+tQjPUMtbSk0gWMOvx?=
 =?us-ascii?Q?2ZoWEBQhnzAdviE+zCtvHFTkFYltziTou3J451hPnaQMSzdKWwtw245iAq/O?=
 =?us-ascii?Q?cOK0KNZYbOKCM2lRNLfYDMnHtnSOrxMGWFCoaPSSR8T42hLdCu6rF/h/dU0J?=
 =?us-ascii?Q?MTpV40QmAbIBFVvABuScjhBtp2yRIOksnuhUfYrBdwG1q14OL7K5ikyIjisS?=
 =?us-ascii?Q?TZ7oLYW3vjCVXmHNpPQirjqilKgAqWJXFNBWHbcPMqPAHjjvMMck1giRFhOv?=
 =?us-ascii?Q?xYpAP2Ep63Iz3tEnea6S7uzfCKgn8AF5pzle9sgMniMZF+QSr+FeKOXiGFE9?=
 =?us-ascii?Q?1P7KhzGYVvFPWCOj1UxLb0VU1FYv8/d8BbDwzoBXzjmUH/t91jhGqjmOQSHG?=
 =?us-ascii?Q?htb9hSjYuQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb6ba15-681c-4a5c-529d-08df1784f308
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 02:06:29.0323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNHeSs3GAkvX15TWvZEYxZsOUKYbGKUXynL1RrqOubxmOiQj8MBuicD8ml0nqlU30GNPL5r1kMUuuXEdZ7L6Pe6hJ3jX3kswL8p7l001te8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1301



>-----Original Message-----
>From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
>Sent: September 18, 2026 08:35
>To: netdev@vger.kernel.org; Jon Maloy <jmaloy@redhat.com>; Tung Quang
>Nguyen <tung.quang.nguyen@est.tech>
>Cc: David S . Miller <davem@davemloft.net>; Eric Dumazet
><edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
><pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Ying Xue
><ying.xue@windriver.com>; Paul Gortmaker
><paul.gortmaker@windriver.com>; tipc-discussion@lists.sourceforge.net;
>linux-kernel@vger.kernel.org; Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
>Subject: [PATCH] tipc: refuse to attach a second bearer to a netdevice
>
>tipc_enable_l2_media() associates a bearer with a netdevice by
>unconditionally overwriting dev->tipc_ptr.  The duplicate check in
>tipc_enable_bearer() only compares full bearer names, so two bearers of
>different media types over the same device (e.g. "eth:team0" and
>"ib:team0") can both be enabled successfully.  The second one then silentl=
y
>replaces dev->tipc_ptr.
>
>Each successful enable holds one device reference obtained with
>dev_get_by_name().  Since the device notifier tipc_l2_device_event() only =
sees
>the bearer pointed to by dev->tipc_ptr, NETDEV_UNREGISTER disables only th=
e
>last attached bearer; the other bearer is never disabled and its device
>reference is leaked for good.  The leaked bearer keeps sending periodic
>discovery requests on the unregistered device, producing endless "selects =
TX
>queue" warnings and stalling the device teardown (unregister_netdevice:
>waiting for ... to become free).  This was observed by syzkaller with team
>slaves.
>
>Fix this by rejecting the enable with -EBUSY when the device already has a
>bearer attached.  The caller tipc_enable_bearer() already rolls the new be=
arer
>back on any enable_media() failure.
>
>Fixes: 37cb0620073c ("tipc: remove TIPC usage of field af_packet_priv in s=
truct
>net_device")

This does not seem to be the patch that introduced the issue.

>Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
>---
> net/tipc/bearer.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c index
>05dcd2f9e887a..b15a67429fe5a 100644
>--- a/net/tipc/bearer.c
>+++ b/net/tipc/bearer.c
>@@ -454,6 +454,13 @@ int tipc_enable_l2_media(struct net *net, struct
>tipc_bearer *b,
> 		return -EINVAL;
> 	}
>
>+	/* Only one TIPC bearer may be attached to a device at a time */
>+	if (rtnl_dereference(dev->tipc_ptr)) {
>+		dev_put(dev);

This API is deprecated.

>+		pr_warn("Device %s already used by another bearer\n", dev-
>>name);

Line exceeds 80 columns.
Accessing dev->name after calling dev_put() is not a safe thing to do.

>+		return -EBUSY;

This error code suggests that it is possible to attach the second bearer af=
ter some time.
By the way, the sanity check should be performed earlier like below. Can yo=
u help test this patch ?

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..1fb54a588c8d 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -258,6 +258,7 @@ static int tipc_enable_bearer(struct net *net, const ch=
ar *name,
        int bearer_id =3D 0;
        int res =3D -EINVAL;
        char *errstr =3D "";
+       char *if_name;
        u32 i;
=20
        if (!bearer_name_validate(name, &b_names)) {
@@ -296,6 +297,15 @@ static int tipc_enable_bearer(struct net *net, const c=
har *name,
                        goto rejected;
                }
=20
+               if_name =3D strchr((const char *)b->name, ':') + 1;
+               if (!strcmp(if_name, b_names.if_name) &&
+                   strcmp(b->media->name, b_names.media_name)) {
+                       errstr =3D "same device for different media";
+                       NL_SET_ERR_MSG(extack,
+                                      "Same device for different media");
+                       goto rejected;
+               }
+
                if (b->priority =3D=3D prio &&
                    (++with_this_prio > 2)) {
                        pr_warn("Bearer <%s>: already 2 bearers with priori=
ty %u\n",
