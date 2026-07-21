Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9537755D
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635893; cv=fail; b=myyNIb0VaUNtGStb9zyLGVMLdqPD2nhUBwOvjsXqQj63VLDQswyB+TTjA8SipGjEMskSQPhPANCkeVXHoXZhgx1tp7dqj1nSmDv0n8YC//o+qOFncjb1FGYrBvCDv3q7ngwNBH4Iyx9NiWBrK7fFMILeSsfE0f+lsXwxFePx59s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635893; c=relaxed/simple;
	bh=b5hVXa124YWWQE/zwS2/OpjamXZIsAQthsr2ZrjJjWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDxSa/h9hwRPRn87CVaHKuN2m1mbdPnV4qhCfdDBI3ldMrur5O9dqr550B6QD18ifEmuwFoSkLw1JUdgZk/81IvXBwlhzVhlx96imI8K000oj5sY2lA916oFJY5DsEHBP0s0EthKaE5oQoQsoBzbn7pKxoovDksl+ox2tfAKSGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Srr/A7k8; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Srr/A7k8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLt5/FKxgszHaZ6orL+nNo+6jqYV1WLw2y0/Dw34fq1SwE5J8kXILSyuLso8e/JCQKeEKCjYd6ypHhbg1cuYly0u6Fx3Hb79isdYfVzXDzhBswrl1G92j/kmQ7aQsVNk6SfHAdChTbygTfwUB4kkIBkh83aXAkBn61sO4c7YHzbVV4xmE50zIyvVQqDJMURgydTnzdvkjhn4F1b5gCuWwFggD2M0mod6dhiM7JxRN8LRCojN/ZgHeoc9UFpm+PkSD9HQ7OewNbofW6otc9xjhriuBP1wrlMWFAmdTTV4uMGDcipa3befQ1GY9O2oSWhm9Q2XAAAvHMwb3GLrP43/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD17G38RoYkHHk82iIq0ZFnfBxqL2gQaJQWYLd+/Hlk=;
 b=Z6IIkqk+iNOVeQL1ZzYdVnj2aP4KHt9rZljWTjwuFbze0PDxcxUqkIKcbg4HHMc/0xl4j5xCwROF9usuDRM6jz1tdmTrBD5CLuGkejRSel6zhalbm7oXjLLlzZJhRd95HVenwsSiUH2nuifuXPRm1/wkz0GvHPpBez5e1D6v9pj1yZHSmCERU6EvyyeY4bdARPuVnrf7SnzYpxQSp/UkTxul3DYmESDiYC/fUGMWUewWkHAbwyA8okSbnb1o/Ici1zV2Kkt3IiYllIv/nA33jAz8hK+f7neWXZ8ZMwZeG/hzXuZq8DdUBLhOGi2/+EXXwVbp7B/gbdjOAw6Xytq5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD17G38RoYkHHk82iIq0ZFnfBxqL2gQaJQWYLd+/Hlk=;
 b=Srr/A7k8Je2utSnipHCTTwdHOwfEcZYZG6rqoXlldPIz2M/o6cHlLUpDaUuqEfnZ9aaXrj9q5x/xxzHWgpS6iB0VwuJW5BGyi+2OqeX6iF9D+4zQo3nUxf0rGWCZ/x5wskznwXIOluafmiVsRCsvs2uFm02r4b9LUanb32zuLOM88l3HjPN7Er6ULoLHpQ2ZrpmxTwDkyKkppcWhe1KNggMok627kkftHOS+nqMPENax5DwnKZnLgkcwjLrMpGxl/Kr/Fz5RNsIag7QmEXK79nayCAam+7Dr6BFXTwICGGMdiPhheuEsQfroQiuuvyfOhsS9PZMcmo/foOOou21n3Q==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DB8P189MB0965.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:148::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 12:11:27 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:11:26 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ren Wei <enjou1224z@gmail.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "ying.xue@windriver.com" <ying.xue@windriver.com>,
	"vega@nebusec.ai" <vega@nebusec.ai>, "xizh2024@lzu.edu.cn"
	<xizh2024@lzu.edu.cn>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net 1/1] tipc: avoid use-after-free in trace queue dumps
Thread-Topic: [PATCH net 1/1] tipc: avoid use-after-free in trace queue dumps
Thread-Index: AQHdGBOPL/HwXdFb5EyiifOyRwUzcrZ34j/A
Date: Tue, 21 Jul 2026 12:11:26 +0000
Message-ID:
 <GV1P189MB198890F35A3BBB9C773A5B6FC6C22@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1784443039.git.xizh2024@lzu.edu.cn>
 <b261f5acabf7c07c971e024d0d78aa9ea34f2be6.1784443039.git.xizh2024@lzu.edu.cn>
In-Reply-To:
 <b261f5acabf7c07c971e024d0d78aa9ea34f2be6.1784443039.git.xizh2024@lzu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DB8P189MB0965:EE_
x-ms-office365-filtering-correlation-id: 4a7dea08-d965-4773-c40d-08dee721306b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|4143699003|3023799007|38070700021|10067099003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info:
 zIEOuYtZ+R2tP9tPwoGc9x0mxnYrxsHpnzqYKS26wjYTxioe6gkUY9v9rHLLIXeqeV6AQdTuUNWBWbsAYB5E7vSBG4Ayqifg7I3pEpZ0IVCq+W4LOrc5Ycun4kxCNiUKVB1VGJyhWb4NyvKRIf5ePlZr3jv5v4lPQca4D1v5/MIzkPhhH10lHhx6FKJkJYP4ur1MAEHwCAfqfsrALmR/UoPlSxQRXJL0T1oeYALnCCIRrU7T7VozESg1IJ4s7/uElea8XqMt2+d5b51tDi1/Z3m2TaF6Ruukk+d799OhM5P76rDyhwrynSAciCwMMKSZ+ojRB1p0FgV5pUJ47g1sfNj1t2iG3f02ih1f6318GwvfhPKm02HJC1aMdDPhDOunCETA9tfmFRigjLz5s3W+97ohYZhgaynoJn8j7jZKy5jxqIbXpxsFsLF+b8LWosuZEOkXAIWhEvmpuvZePvwkd0bb0ykqTnlfYuS1SSwSKiVhsjmVOFHmWUdkRVGlDX23Cht/2YDrkQuH3sfzpnzFeDBnYqJJWvctT4l5IBYorcZ/xCEvu5Jyv0aEo2Ar7qiR7Y+7NOGwXVSpPM8e612dgetaDoaDLur7LHXv3muv1ftWg78+INVpFryhSvaImgURh+NxNigOdIv6x9DrRFjl4zuUu09XaJTX6Zxtg2pv8F+8aU0Lg8uSUlFPzmU0pXvOSi5g6Glzw6RA6Ov1NuUONil9ygyZsamGJkczMpWoi2U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(3023799007)(38070700021)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dbFwuOKzD1r7Zxif779xftQw9LfB/c/1BV7nJ+DNeMc1K6VHK4uk+znTVbHG?=
 =?us-ascii?Q?CwVyoZICmcWetVt1Xz8KEMrSQ/w3557NXdMo+kEZzB+ybZ1hH+/PukkW2auz?=
 =?us-ascii?Q?rb57SSvswc9fdOi+vQacD4X550t/6HXRb2WMJJYlTV85lvi/XAR5XplHOLoV?=
 =?us-ascii?Q?aVnWk11iS6jDGc8EhQOibXK8RVY4O5yUD+nXIfGLUwc3/m0JmICv9Cv3jLbN?=
 =?us-ascii?Q?Gdyzoz3nAWOOitt2Kt2ybsWaZYBpmCYictxnB15u2Nvk5nyOAliFQJtFTjOc?=
 =?us-ascii?Q?aLznv3neyV9Mui6328KttTSVOpIFIzXA54Mb0Cwx7I82Z2jL1UhF6BrF7K+k?=
 =?us-ascii?Q?ww9Ta60KG4S+ECIJAlNvxYboZm0z1lpSTdKrOkcVvc/4dfLBFhDKHgu/Equm?=
 =?us-ascii?Q?4Q4eZ1LeIP4468wTXm9DlU0VFRCtEf5XooxVgfTPOxOUsNwUDwVtGAdtwYPn?=
 =?us-ascii?Q?H3CEDMoxhbrXNtxvabAaylPGriO/d+LYvW8oDOCZbwLzt+toXlhhos9WlDgs?=
 =?us-ascii?Q?X9eMWFgCoyBAe0hnfOQWToivxXNBC2DHljCSvhmzWkwECSCwjLe/mkEszXCM?=
 =?us-ascii?Q?hxpAF3WkeusYRe7/Fx0NTXpTT78RnIkWQtxGLtEzcAQKUug3LqMG5F0vkMpM?=
 =?us-ascii?Q?/AeyC9ZUwy3zOTB2Aw1AAY0PwGc2V9CowPcCAs7f17fIgS73BkoYQxGRyiM0?=
 =?us-ascii?Q?Z7ApXgNqb5iEGPgWjLZkvJInVwxl8O/48ZyXcgwArbqVSgVtIrMYBmt0UhYb?=
 =?us-ascii?Q?zy+A7agVRObBc8bQ+9fxcX+PTaeftcNkRM+ptl0sd9+iZBn3Gfasn3rAAUOo?=
 =?us-ascii?Q?gecmTvmGbglgBFx848sYxCNxMLHb0/YpK7aaceHG7hgLgPd1/FTnKVrGDLaN?=
 =?us-ascii?Q?UrcTOR32xSvaAoVwdKLiuLGpsWnrdesf+Rg7YX5GychxmYdQKQGtZ6sMpXz0?=
 =?us-ascii?Q?jV4iPxVztnQbKxdZv4DjSo9rGbulgnREX58h77+42zNQJClDx10tZpfn6elA?=
 =?us-ascii?Q?27OfE+b6ZaxfDC9EA9BuQozE6t421aHpFN/gq48qS6jPFTBMmmf6H8LdXv9k?=
 =?us-ascii?Q?9BYFFsrk7a45d+JrwYI+TAQD+xuWH5zYB4QuxfKezDBXFsqG2k2lkoSf3//S?=
 =?us-ascii?Q?rUg3CFgwSOurAQ+M1CY/MIBgGJrZCP2insN1IzuHYeSTCSMqbYtO9EkaKWpj?=
 =?us-ascii?Q?b0ek648UL6Sd/RuKwN09qWghlGvoaIoQLmCwQdl61FlPcwKwXovTOoNmfXAe?=
 =?us-ascii?Q?UME8eiCOgXDhN2+wtW49IAd9KIl+4+DtLK4ff8nckPqeHwWlDsVhOusoPKBm?=
 =?us-ascii?Q?HTJVpwEoeXByOsTk4KzRNdJ5ng7xsl+PFRwJoKAAOebCnBVVf5d2i8saSFfY?=
 =?us-ascii?Q?sBvvRp+dBsXGtcs0xrG7bJAtYtU1De7vF3kWXynrK8bYKQR02Xjd9u9En5sO?=
 =?us-ascii?Q?ceTNx96EmYTVl6bTOUgnFS16lacMaotCCCFPMxijmFuiOd3rRqNyTi/Q2vQ2?=
 =?us-ascii?Q?qfxkDbJHwy+ZXkSqKHoq0BGLR8FHRw+PeU6iHGj7n0ipQMCD6AgJbP/tdFfY?=
 =?us-ascii?Q?gNBcKMZGv0uKGTGCO0tg+7GSJuE/OTsrfTftcUTLw+Dfzs4ibYet24yTobqF?=
 =?us-ascii?Q?3vn2DVcyWdi8WNkcuAQivhr6RYDtI8FnTo9wo71um1zOvnHsTVGF3QK98paD?=
 =?us-ascii?Q?oAA1uQESVA5M/JRHmryIbkeYlcEGcNVoTrdWxhW2isqB1ZMqJ2LvZIK9+bJo?=
 =?us-ascii?Q?m3biE+vZPg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7dea08-d965-4773-c40d-08dee721306b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:11:26.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oLqSuOgT98r71F2/ChhjYNjBJqquWGs/t9icmMozOOqWSz093ICilh6JlN3Gz+icm2Q3qjLlIGUkGimGAIUzrlpCGjF5vxcjvZwff6Uxbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0965

>Subject: [PATCH net 1/1] tipc: avoid use-after-free in trace queue dumps
>
>From: Zihan Xi <xizh2024@lzu.edu.cn>
>
>TIPC trace helpers can dump live socket queues from contexts such as poll(=
).
>tipc_list_dump() walks the write and receive skb queues and dumps the head=
,
>tail or selected skb entries, while tipc_sk_dump() also dumps the socket
>backlog head and tail directly.
>
>Those trace paths do not have a reliable skb lifetime guarantee for every =
queue
>they inspect. TIPC socket queues are serialized by socket or other outer l=
ocks,
>and not all skb lists use the embedded sk_buff_head lock as the mutator lo=
ck.
>A concurrent dequeue/free can therefore leave the trace helper dereferenci=
ng
>a stale skb pointer.
>
>Avoid dereferencing queue members from the socket trace dump path. Keep
>the trace ABI and buffer sizing unchanged, but report only queue lengths f=
or
>the write queue, receive queue, and backlog. This preserves useful queue s=
tate
>in trace output without pretending that the trace helper can safely pin or=
 walk
>all caller-provided lists.
>
>Fixes: b4b9771bcbbd ("tipc: enable tracepoints in tipc")
>Cc: stable@vger.kernel.org
>Reported-by: Vega <vega@nebusec.ai>
>Assisted-by: Codex:gpt-5.4
>Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
>Reviewed-by: Ren Wei <enjou1224z@gmail.com>
>---
> net/tipc/socket.c | 12 +++---------
> net/tipc/trace.c  | 44 +++++---------------------------------------
> 2 files changed, 8 insertions(+), 48 deletions(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>e564341e0216..4b9eb0b401fe 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -4000,15 +4000,9 @@ int tipc_sk_dump(struct sock *sk, u16 dqueues,
>char *buf)
> 		i +=3D tipc_list_dump(&sk->sk_receive_queue, false, buf + i);
> 	}
>
>-	if (dqueues & TIPC_DUMP_SK_BKLGQ) {
>-		i +=3D scnprintf(buf + i, sz - i, "sk_backlog:\n  head ");
>-		i +=3D tipc_skb_dump(sk->sk_backlog.head, false, buf + i);
>-		if (sk->sk_backlog.tail !=3D sk->sk_backlog.head) {
>-			i +=3D scnprintf(buf + i, sz - i, "  tail ");
>-			i +=3D tipc_skb_dump(sk->sk_backlog.tail, false,
>-					   buf + i);
>-		}
>-	}
>+	if (dqueues & TIPC_DUMP_SK_BKLGQ)
>+		i +=3D scnprintf(buf + i, sz - i, "sk_backlog: len =3D %d\n",
>+				       READ_ONCE(sk->sk_backlog.len));
>
> 	return i;
> }
>diff --git a/net/tipc/trace.c b/net/tipc/trace.c index
>7d2931521e0e..399538d0a369 100644
>--- a/net/tipc/trace.c
>+++ b/net/tipc/trace.c
>@@ -158,49 +158,15 @@ int tipc_skb_dump(struct sk_buff *skb, bool more,
>char *buf)
> /**
>  * tipc_list_dump - dump TIPC skb list/queue
>  * @list: list of skbs to be dumped
>- * @more: dump more?
>- *        - false: dump only the head & tail skbs
>- *        - true: dump the first & last 5 skbs
>+ * @more: unused; kept for tracepoint ABI compatibility
>  * @buf: returned buffer of dump data in format
>  */
> int tipc_list_dump(struct sk_buff_head *list, bool more, char *buf)  {
>-	int i =3D 0;
>-	size_t sz =3D (more) ? LIST_LMAX : LIST_LMIN;
>-	u32 count, len;
>-	struct sk_buff *hskb, *tskb, *skb, *tmp;
>-
>-	if (!list) {
>-		i +=3D scnprintf(buf, sz, "(null)\n");
>-		return i;
>-	}
>+	size_t sz =3D more ? LIST_LMAX : LIST_LMIN;
>
>-	len =3D skb_queue_len(list);
>-	i +=3D scnprintf(buf, sz, "len =3D %d\n", len);
>+	if (!list)
>+		return scnprintf(buf, sz, "(null)\n");
>
>-	if (!len)
>-		return i;
>-
>-	if (!more) {
>-		hskb =3D skb_peek(list);
>-		i +=3D scnprintf(buf + i, sz - i, "  head ");
>-		i +=3D tipc_skb_dump(hskb, false, buf + i);
>-		if (len > 1) {
>-			tskb =3D skb_peek_tail(list);
>-			i +=3D scnprintf(buf + i, sz - i, "  tail ");
>-			i +=3D tipc_skb_dump(tskb, false, buf + i);
>-		}
>-	} else {
>-		count =3D 0;
>-		skb_queue_walk_safe(list, skb, tmp) {
>-			count++;
>-			if (count =3D=3D 6)
>-				i +=3D scnprintf(buf + i, sz - i, "  .\n  .\n");
>-			if (count > 5 && count <=3D len - 5)
>-				continue;
>-			i +=3D scnprintf(buf + i, sz - i, "  #%d ", count);
>-			i +=3D tipc_skb_dump(skb, false, buf + i);
>-		}
>-	}
>-	return i;
>+	return scnprintf(buf, sz, "len =3D %u\n", skb_queue_len_lockless(list));

 This patch is wrong because it removes information that we need for tracin=
g.
Could you please test below patch to see if it fixes the issue you reported=
 ?

---
 net/tipc/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..a006fc98a9b8 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -795,7 +795,7 @@ static __poll_t tipc_poll(struct file *file, struct soc=
ket *sock,
        __poll_t revents =3D 0;

        sock_poll_wait(file, sock, wait);
-       trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
+       trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_NONE, " ");

        if (sk->sk_shutdown & RCV_SHUTDOWN)
                revents |=3D EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
--=20
2.43.0
