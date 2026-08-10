Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64D356778;
	Mon, 10 Aug 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359714; cv=fail; b=lxaL+wxfJY6OoTwNPmVjJ0BmbnV0OaxYiiDDErKNwQFsWj9IUViLcyJ0KgFLog7P7zwvyGz+/tzvYHkIoWsQcXUd1/bGBeBkS+WBXq7bpGGqU3p9MwUKFtNbd49f1SNfnLBq0pKi/UAjxFFwrHIwmHUydSGri+CBbZ7sNgxTUwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359714; c=relaxed/simple;
	bh=yV4t+HqlD6mX6BwVZzXohRtdjgOFtRwBpdilKkGJ2Ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJhcLxTHfHP5qdLW3Lx8suHiB81SJjPUhB0swvR7Py1qHjjUkYPgBXbCraH1MhO08RRcyWxjmsO+AKQr64ehuGGNUKaffxH2zUib2E+/bL32ifqNGU1VHcOO5EnqZyR3QLZV2Z1h7ja2z9cu8HBpBeQOIVGN8mjetfPXgGHSzds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=eaoaYTXd; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="eaoaYTXd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg+gWLGlLfDkQYxKbuwIABD205HV7cb8YgBOnqOfxRLFdPc2OBlUpQUVtYsQUpPANjEiLVzzMzmPxZlQUlkQb5LigjX5hXelnUPr/FU5ILkUljhXkPfwI3sHkp8JJGtmW/dkrgakbZrJdpPgvYUjyIA2J/f8+D+/cE0eEUMQHguq/ZPlbMUvIJyYRseFxqVgWl+XFbYrxSrf++CxODpPGcewkj0a9N3GE7siwiY8FN2BGwpNg80vKXiLZWgN2e5g7nU7hqe20d1x4zrNVXnqfLHkR1LGe9bRxyajNwqWTWq0J9QrfBWAdYgBkinp+KDl5S1l3qfhgnaZasq19Clveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROilcYe7j/Gxyd7/cdsjfV9aytoZ9JzW/BNtzSmZFpI=;
 b=p/2M8cnb5R3YgtWkcDrOLGhrA2tXINCInc47SxMh5Kw7y3SkWRwNwuBwBbb/u/SQrdF4m8aRlYq11PBM3Tvafc00PLN6uN2hdY5vknH8e8BcMGLmKh/LbQ63Os7liBzwMs5B6P7cNwTz246zxlkMslfiNPDWZWme+vvxq7z0pSbmNg8J+O4yXWUDP1FxVR8dujR/TuZEMjwpR85VPMcSK6LUR+sMgzWN07a+2heM7kXhIinojbE2E+XGTKfpbY+0VcZiT4NxHO2fiJm2QrtRneI1gPuqZgs38P4k/oMu3wWOHOmTahu9mr27BOIB4oeDW3TYOG6cr1fPwDENuo/1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROilcYe7j/Gxyd7/cdsjfV9aytoZ9JzW/BNtzSmZFpI=;
 b=eaoaYTXdtQSmaxXXA3JBufpP2HxwfY9fjgbXqsnK2G1WEHJPC6srPL0wPnrGNXvB40+cJAnjFTdE1R47wjrWZ7VfQDj4SeZyuWTPDD13sy/jRGZFiuxXIsjsO2E8LljWZ4S4/3PCzBFuP1ZrD/0ohvazIubDnXjPlRhUNHsT/hy0v1ULh5Mn96p8axiXz4+dRlqWZepjWqgX2ntYcDmFQ8ZWFCGaMTkAFS9sW/2l12yzVD5jb+ymnkTSLD5rXywDGfHbd5w/E2XvY8DIIvtU+ciNuKrF2gKQZPHilcbThZByIjNUoW0Jl0Xh5BqIFaorDXBhflMfxvnsh6NSegPzOw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM0P189MB3739.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6f9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.11; Mon, 10 Aug 2026 11:01:49 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0315.008; Mon, 10 Aug 2026
 11:01:49 +0000
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
Subject: RE: [PATCH net v2] tipc: read le->link under the node lock in
 tipc_node_link_down()
Thread-Topic: [PATCH net v2] tipc: read le->link under the node lock in
 tipc_node_link_down()
Thread-Index: AQHdKLKcVs/UMqsVFEeFHzPIBeAQ/7aXGong
Date: Mon, 10 Aug 2026 11:01:48 +0000
Message-ID:
 <GV1P189MB1988F1925E201ECA63D49A86C6DE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260810102147.48191-1-juny24602@gmail.com>
In-Reply-To: <20260810102147.48191-1-juny24602@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM0P189MB3739:EE_
x-ms-office365-filtering-correlation-id: b8e3e5c9-2baf-43d9-4858-08def6cec6b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 CjFIyjUPm31JcKkXcdZjoUPPH1ubtGx5qNDFKfXYyn9y9ujoo8OLlJdGF8X2EsWn0OgOKwYOAlmLbA+Jq+uvKYEtxU6p2nK1K5YW/pUTpRRw1/gvu8RPCMVeDWPOXccA7kQTkzA5VZ0EOwk7Vu2dk5hQxArYNnaFBn6mNyliwcrfdspMyDE0Im3KJ4AFIQ6k5OxcYtNQqR5O6GqvQAwQ38yEiZL11OZY25OttaH5eEys5X/0fX1VUbNYk4jxqby3D6Nq8a0czaBghzj5XPM6d7+jL3ti0qd9EKuZV7DQmCObC0dzUYFTEXjiYdA4VQSDa+kojQqazDT9ZDcjy4nI5deCQFQAD5p6GLnfkwT4+NcX7eWl+PskCmSwNGBBC9RKr+1aQLfKxMyQ+Yms+FzpO3KBuZgpMfZOB5nhxdy4RbofWXkLylWix35vjQ+n4EKLcroygSPhB2MVCvaxdN5h4dwmsSnu/Nue9xdBvbBHWqX6a+XLAheK8p4DBuXEA0rZyqsxLO1ITdcFt2R4yQFtKjIJ+Ey5a6agqJ4QkYg1RmUKviEKZZ2NBX4y31tJrQEWvjJ7KcbHn5JVuMtNv2RW7q7AtEOB02BAvIoUqvEJqu/z+u9HKzt+VI+97GKndWIcXqotlM6hykMB3bPEjPG27msHemBrWdxq02dL8Q41TtO9vQ5TMawS/RwsdkGlLmH7XYBUlRVsKjxG8XmRT5E69IwBFZdVm4thjouDK0e+WWE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tl/q2DkFdGz7LEpyDAL1R5cQk0FR9WW86jSx9Tj2wvELlHp7Cldcy20NO8bS?=
 =?us-ascii?Q?P7eAyEJjNq7l7NGnpTYLFHnLqAT+uL2vtCWylAR1qibIGJc8kvegV9NDayFW?=
 =?us-ascii?Q?p8Z407pQh93otQU+F30qFpf2iQbk7uVUWJ594URK+xDsG6OF7H+wn6nvRJD5?=
 =?us-ascii?Q?uMQ20AlOZb3Juh4ShpKawVDGT09vpNCNl1SXE2W54VBrxaMExsO6TiDzWS/Q?=
 =?us-ascii?Q?UluV291rQpSc7IUUSXkiqk4J6fgwzhjFVuBrBUghCbENaH6mw0rdve6YKuSp?=
 =?us-ascii?Q?aaSTNTebI2l9ub2jvDkOeeHLnC3SFj7v0x+x/X4IZmc2pv1UqznezGntq8HR?=
 =?us-ascii?Q?d8ZhHD+mm8sBRMiphOQW90kG5kfC5aQdgR0TuC4Pv7QHRdkZTRaV1fYQ9vbZ?=
 =?us-ascii?Q?C3BvyL6/e2kD764KVUsM5/LJymUS1uYWtgY2d21r3KPV+eMAlv4dlO48kZTB?=
 =?us-ascii?Q?G0kC4aovdgDJGG9qvH4/2uhqoAm2lxAHZeCkluxSRHazqhn707BXb2tsDka6?=
 =?us-ascii?Q?WBpAhEaYJR4e0LQrH87x/y0mV2F+bFHQ1sZpFHurDmhuhXIC4mWErdPoDhMJ?=
 =?us-ascii?Q?NbbPXwEA1ZF9xoEaccTqKsj20Z0xQVPJiN9TQA7zhIRS7hJKz9Q5KuGfbHOo?=
 =?us-ascii?Q?9uLKN460Nvz6r4c4WNFXG1uc5JelOuJfXfDJtHcVIGgDXoICfJTRV4civud/?=
 =?us-ascii?Q?mZ5vYzE6OdyhP+Ykkw5KNfTeauJWwmiT/pG6c28jpk4/hBlpKcX0KehTSTl5?=
 =?us-ascii?Q?fiSztiF5aFCSN3P94iTTlxbBUxdq1N3NXnfH49hGCMTj3oB2b+oxe/ww/i32?=
 =?us-ascii?Q?/RE/KVUWzWl3IHI6M/wQGN8LLCu05mnCGH9KhlcfulqPlm+sTcJC7JNyMiTL?=
 =?us-ascii?Q?A4h/XhawmCnnZWiGmkMRbIqP2TrBY3JjSob+F4e1C2+mEQiJkzEHTrb4dNBo?=
 =?us-ascii?Q?qT9uHwF0NFjeoRCdTWPV0JxuisWOJfugUW8Pgl/3xCWoCry0/DcLX9fxAQV4?=
 =?us-ascii?Q?g+X2xnjTjIzF/JTF9es1QHLX7QKgnGptgGyU4TcBQ3cgvipI7LZ9SGGkgeqR?=
 =?us-ascii?Q?+2J6Kssz9Euq+IBCXLQosfwziIexMEkhuZ44E4EKY5WFufWtUXhU7rWMXEne?=
 =?us-ascii?Q?lm2dAH1RFFS3RoFxJIJdA+Pu3V+yi25xDbiQskfgrvdx+E7jqvvaDBdak6B5?=
 =?us-ascii?Q?YAuZHliy436xyRNP9+ThGAET9oXrylCk62nXXuZTor/kucjkWeyXl/hlXQUL?=
 =?us-ascii?Q?tGac7HlagqhREuLJ7FJPHR6Kl6N4GafaGrcUkgYjKf3qy/2qdH0WOD7EpYCE?=
 =?us-ascii?Q?0h9FXxRsG8D+05O7NZI07zmgmQ55fnBcxJQB7NAX9yPWcvOPWCgY2m6ddtHl?=
 =?us-ascii?Q?GnWUsWzAo3ktDaLmGYkKGLbYDy2Z6PgzqbTtDI+h+DgArTmPflRt3B1BZl23?=
 =?us-ascii?Q?dr8kyuMLldeC1W1+g+agwO83XxqS0suYXWLSrvZfHxc5h1MwyUu7zn1xWtkR?=
 =?us-ascii?Q?K6/i872jvy/CJMzo+dk3SLm4clVrgkoPCnqsZhBSBgLQerJvUsKzBWz6V/QU?=
 =?us-ascii?Q?8+gD7DSVdaea2G3goFHjN+Yj6LxZWUiVTnk8ja4KSOcoKFTWEOPc21f9tJ5c?=
 =?us-ascii?Q?WUmvVrVtYnvwIm+K7za5ssQtQ1zCppNj6hklVRsp9jdM5sxUcWWl8+JxMD6C?=
 =?us-ascii?Q?IjETreRw6dq6QcubFn2qq9XeHYMApBScvEWd0ELd6QQZs0v4Mqv4E9XkokWw?=
 =?us-ascii?Q?lsGavgYDOA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e3e5c9-2baf-43d9-4858-08def6cec6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 11:01:49.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqQ3khQWE+Xr4qSaZcGR+V2wpLfdVmSc3XYo7I59IMOHO6jygTJ1LkzKEV8L6GG6qLcfyocAqeVyk033zlUg9J1fS80ra7CKjp+VM7aOdzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB3739

>A KASAN reproducer for this issue is available if requested.

Yes, please send me the reproducer.
It would be good if I can verify the fix at my side.

>
>v2:
> - Take &n->links[bearer_id] under tipc_node_write_lock() as well.
> - Use tipc_node_write_unlock_fast() on the NULL link path.
> - Decode the KASAN report with scripts/decode_stacktrace.sh, re-taken on
>   7.2.0-rc5-00284-gaf39eb111ce6.
>
>v1: https://lore.kernel.org/netdev/20260731102145.33622-1-
>juny24602@gmail.com/
>
> net/tipc/node.c | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
>8e4ef2630ae4..683a136e53ef 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1061,18 +1061,23 @@ static void __tipc_node_link_down(struct
>tipc_node *n, int *bearer_id,
>
> static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool
>delete)  {
>-	struct tipc_link_entry *le =3D &n->links[bearer_id];
> 	struct tipc_media_addr *maddr =3D NULL;
>-	struct tipc_link *l =3D le->link;
> 	int old_bearer_id =3D bearer_id;
>+	struct tipc_link_entry *le;
> 	struct sk_buff_head xmitq;
>-
>-	if (!l)
>-		return;
>+	struct tipc_link *l;
>
> 	__skb_queue_head_init(&xmitq);
>
>+	/* Synchronize the link lookup with bearer teardown. */
> 	tipc_node_write_lock(n);
>+	le =3D &n->links[bearer_id];
>+	l =3D le->link;
>+	if (!l) {
>+		tipc_node_write_unlock_fast(n);
>+		return;
>+	}
>+
> 	if (!tipc_link_is_establishing(l)) {
> 		__tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
> 	} else {
>--
>2.55.0
>

