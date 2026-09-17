Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568A3812DB
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 03:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617083; cv=fail; b=CGvpM4yBs4rdwr2Y+xc7wA3lgMXmdwNcI2yKa4gzMIVNycHY/kg6gL0+RJdi1rRZK8C5BB6FTHBPD7xHNaXmiktcPrkQOPoe1AUPDoaFzVLdSOEEjaDklJ4dPWFM6iBMruj4tz8ROYA3PlYALR4jqCPGaqOj1C/yHLILjchWC3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617083; c=relaxed/simple;
	bh=E4FNfxVt1qnAY3lmmp5iEPaV2vqBFp2/KB4Rx6b75aU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UMQWEN6q6HBJ9axA+DNk8PrjGHqq1alLQINnpqVFQ7l6xaouruIQN1Skoy4FdsL2CXLBxh/dNGqXHJPUubMHaY0C+dXXmG88zlEkFSbPFacOvWYhRwygI2tLaES0/9SH86aOe0BfZemeRN0vFwRrN/hkHrNmLBTGyb0/7t2gnoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=CteivQ1X; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="CteivQ1X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3SA3qdFKra6ecp1qxddK7WU8Jugvccacd9xm+n0/iXYKxtZP+RcXY+8hgCioIsRv3QQotGA+zrP3xDSNAvNqO5TCvd+5TyhQrBAPdLd3+KrQY4czlBkQ+lphCzmwsmSQ/ItDBp5tfLQoNi0vQ+gH19lRQ+P+k6F3z4uaRNpTwz2e6os0Nem2cPoS5t9t2GBdFJcQctYQSte1o2IxfmOGJBwpLjjXRo3jf0f8Iygelijpb9yaRM0Nv0hBIinhL5sF3WHF5jeG5bz7JW5wPPQjX7+rVayT9ne+ha1vHtEoDfnpj6u3GFmURZVSyCjuqlrwsB3CHxCgg1+S6hQycTX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoBhch4itqzYx0SmiDkiNQmsW5jBesztx9ZGkDd7IRY=;
 b=tuL1Y098IO4nzFwV8BPJG9pLj7ApCqncuhYKtAMncI0l2qNro+XFA9ZLk4ivXLJkswZn/9ODchRDg8FeLILCQWgHZ2JqoEy7g7t9AZIrLJHGxfucnn038fg3b7ZLhHhLoJdKNIXD74GGHdPQeBzc/LUkBKq2ajSq4kHNLxEB3Unk9gxBMx0Ktc6xef6Iqjv5YpgXVrTOn5r2wy7XmGy0Yh7qyGWqObaCBklcRXDxZtf8krwqMKWta9mJEOk00usSV441LEBQKfmQIwJshUNmpJaNNxB9E45uWHYqUdFZYT89f/5Il3qqBJF4h6wOQVsY1lXfCussPQ0JW4DTYH+kKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoBhch4itqzYx0SmiDkiNQmsW5jBesztx9ZGkDd7IRY=;
 b=CteivQ1Xcc6xe8ylAIHrPANncMy5rD+P+qArnSKyhCmtDVDhATwpS9Jjj7oa4hKfLNJlsWM8mhcdM4NO+gimiVaDK1hTgCJ9kGQ+inf1BvWo25SXYGIcaS0yFLDJIrAweB7WjO4Q2GYY+k7CXUoBCSrI8QRaKJ3YNeTGZqb480mPDSTON9bbvxzA7WKyZOHkkw4nbClSvtiXcAsAnijacvynLgidyNI4QqpX2iZmtiKn6dLdygb2b9kA4U0kTmkd2VjOPaYGaEYktHS30NCXNjaZFn5SeRzlMyLqChViskHhxMvtQadjIwumrXlH7RxSOgezEaLb6Ly2ai3OH4G/3A==
Received: from GV4P189MB3732.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:2eb::17)
 by AM7P189MB0806.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 03:51:17 +0000
Received: from GV4P189MB3732.EURP189.PROD.OUTLOOK.COM
 ([fe80::b76b:e0a5:9be0:fb34]) by GV4P189MB3732.EURP189.PROD.OUTLOOK.COM
 ([fe80::b76b:e0a5:9be0:fb34%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 03:51:16 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: "xiaoshoukui@gmail.com" <xiaoshoukui@gmail.com>
CC: "edumazet@google.com" <edumazet@google.com>, "w@1wt.eu" <w@1wt.eu>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "tung.quang.nguyen@dektech.com.au"
	<tung.quang.nguyen@dektech.com.au>, "xiaoshoukui@ruijie.com.cn"
	<xiaoshoukui@ruijie.com.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
Thread-Topic: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
Thread-Index: AQHdRaM/5s16wXYOHEyHInlRwNizWbbSEy6Q
Date: Thu, 17 Sep 2026 03:51:16 +0000
Message-ID:
 <GV4P189MB37321B67712A8B2906F2DC2DC6B82@GV4P189MB3732.EURP189.PROD.OUTLOOK.COM>
References: <20260916061220.798324-1-xiaoshoukui@gmail.com>
In-Reply-To: <20260916061220.798324-1-xiaoshoukui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV4P189MB3732:EE_|AM7P189MB0806:EE_
x-ms-office365-filtering-correlation-id: da611885-484d-45b6-b308-08df146eed03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|3023799007|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 9y5bpt8Hd81+MI85fRyfqSckLz1ZQBqdHksk+naloxX+DRvPjcJ7D0CnfXcPUI6RmpUBk+H60Y179bAbhUQoKqccImlcpgFHRNlA035VaM8/qFclssDpLoa6AayTrl7LHHZyN/84g61Qsa9kwbp/fqnPAXeDvmEMMxaR10XoJ7bb/4W26ZClN6trcg5M5fYr/+pM17ktUilU7V9AiLE6lBnAsvxSGejcVq6vscSb5otMa/dYUEICyWtQyKKQWMe9ykf/fhlGrbxcYMGXaHWAX4ajiQCjrtWZWepKfdQNtDy/IN10egT19am5Dq362QVqGAOC2hvqhwJn4UdlVfaR2JjI37KxOyNmDhBlhPHm5/Tps/TqZZtvbmbHgy+zKy10Z+/XkmFMM1eQniqc5yenmEovz8M5/jxk34Vfy+2Li/BrQso6CtA6B74BjAnKK2LR52S1KzetwsXKYB2EGbJJd1r9J5RPEl0wwkA2NqQEQ5HOtwYyxQ/1ioDfPSBuo+sh9VmJ1naRFyAhy/j8ElFtmC1i0wUQLIURSBO/qe2WpkgyPulf5+HUY1TW11m23ykXtnXp9+ZujF0+Q5N2GstnG1Dd3+3yPN9NuH4AE2RLBItTbzACrlbzWLlYQRbKp65UTMKMK7u5oXxPyj8IbiP7GgU4wTQzuAYjA3pAmNnxAcs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV4P189MB3732.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qR/SmnRyA2mOXuNLrQCGjyjd0Hd6PvnvHWlKaoPw16WVQoJl75Gp36Yk5AES?=
 =?us-ascii?Q?vCWKXCKTbDmFj1hsbzIj+OxjhrfG/S/RkaQHsU+Z5PbbYmpu+lvyRoNZM8bi?=
 =?us-ascii?Q?hjxmfI6/UUVneT9jUcR2hmCmRBk8PaSGo3ehdL0c4E+Yf7j5mAvsJkKBdpci?=
 =?us-ascii?Q?DcugGl83B/PW7usaNgVzlio+QrxoWwi5orhwv7YgUUjN1nuM8NeVCKAA3hE5?=
 =?us-ascii?Q?zp7f0bI40HD4uZzmiUndtUPvfgwY+jCWYDma2VRGt4NwUxwOFtxl2fmvPzjz?=
 =?us-ascii?Q?iQgJpjn7HkBqiblfVBt1yD9P+nVu3irl8e4TS/D3MHO3ANq/+rnjClZNSYrr?=
 =?us-ascii?Q?D7i913xP3O2t/QOV0lMJC2h944WxWcBwXz1bs8qqH1UWaqEi4KRNxxdLY/zL?=
 =?us-ascii?Q?oRjlrvjqfGAAATEZx8gy3+L/S2qPKHVFCeOmRU7kRqoFau0E1uUcbsGrHk1R?=
 =?us-ascii?Q?W43i7AfVk6ue8IB5C0nzqI4t3YsCNvFqKKnd7lSzWxQXTWQaGa1hwUXC2MSD?=
 =?us-ascii?Q?dqLasUn5JM2YdhHorq7VvM6ttDaYdnMjsW6PupEiFbS8KTn2z+S9C6EoH6W2?=
 =?us-ascii?Q?R6yNHyQn36h1tHmRmPmICjqMvYDohFFQagzSysrrnVUUm3rCphq7/syuO8kF?=
 =?us-ascii?Q?lK+wqKrisB9SCTIDcIXXMusGEFmwKwBGnMUXNiKHAD1FLAX4N/TokQCh1jyB?=
 =?us-ascii?Q?bi5lrPWsAGTbZHugmxZplHwY//equgZsR4wBBhIbaO9a64VVk9rUtMGYlGaN?=
 =?us-ascii?Q?ZeFj72TRhcTvS8mzzfIw3j7dq8rRqQsAeMnkXrdoh06LLjZP2AH87VfdyT7u?=
 =?us-ascii?Q?484NgDsAjmRXMFs4kYrvHXNjcB4wNfxaCcofaCzAtNW+q6Ann1s7i2YA6SSP?=
 =?us-ascii?Q?AKVkw5muYXZVbomXizyUdudtbaJP9ExeQF5+GzT5lnAziKUyCYIhrJjE/Xum?=
 =?us-ascii?Q?qPq0xZEfix66lCrIFpIvDVLWJB8r3/J1x3xMb/0tb2t3qrksr+bHdF70v85T?=
 =?us-ascii?Q?05TB3mwGd9IglDnDvTSonTPW0zXyis831XwU/oG3ckqIdJdAiYW7iKFTu6Se?=
 =?us-ascii?Q?lJVfIGbfJwrNfKOnCSA7BUgL+yjiYIGS+P8e1qtHaWxwk/s5Rc808SU/rv28?=
 =?us-ascii?Q?KGLnXVW54NzbRuoeOThqjdXZptvUZ0PN9dvK/1il88XLbY84wV7u+ZPaydKr?=
 =?us-ascii?Q?qdA+lU0CZouFU0TzXN0c0xuoLDHDw+o2k/27DBNHOZ/P6MoR3CPUo6/tI2eX?=
 =?us-ascii?Q?snbIMP0nF7hzyYW60vPSmkxAU2Pj85qrnb9v+u276p5B5nT766HuOALuWrpi?=
 =?us-ascii?Q?bEksL97Divs9GrjAuI0d/EpkvGLllGBNh+gJp+BI5TH3+JQf+2UfYlkFyzK6?=
 =?us-ascii?Q?ix1C4LGuazbQ7/Hsocmzm486WGgRDE4sP9xqxgsqMRcJAWDOh8t3gSyVQiEb?=
 =?us-ascii?Q?pGxleqKB7TA/ldY6fhWv3iwNTqXfjx1QZiBFNEVs+U3oFqMlv/LbXlr36c51?=
 =?us-ascii?Q?NMIU6DrV+HOSFEupukPfvYjeIXD7fWr8n99haHBGX6GElZlRyyx14Kze2p1n?=
 =?us-ascii?Q?tc5IsHTlVbPc4lGeoVSHhiwnP9JUOW7wFCMDrlj89F0fMUZoTNiqO3mXzgOZ?=
 =?us-ascii?Q?R9wwI57O76TZRgmNgs9M3U2Vvgn57tAPEg5Gc2m7qZHjr3Nj4/EhZmyKdGuH?=
 =?us-ascii?Q?7PS2XKMnxkBE+AkNsykYgKrI5/ZXypYFnG0B9YvyW3hxhsfDC3c8vpxGe++o?=
 =?us-ascii?Q?UhZsA1NDqw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV4P189MB3732.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: da611885-484d-45b6-b308-08df146eed03
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 03:51:16.4927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Acqz7CkQk0zRwTJXNqUqoOfCK68yipsPage8S5TnGJUScoVDJCVew/jI/cpweWHjG3nRc8Lo6doODB99yD089VwXs2GtrTse/aA0oogEGro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0806

>Subject: [PATCH net] tipc: fix memory leaks in bundle and fragment paths
>
>From: xiaoshoukui <xiaoshoukui@gmail.com>
>
>tipc_data_input() returns false when an extracted inner skb or reassembled
>fragment is not consumed (e.g. unhandled protocol user types).
>
>The bundle extraction loop and fragment reassembly path in
>tipc_link_input() both ignore this return value, leaving unconsumed skbs
>unreachable and leaking SLUB memory.
This cannot occur because the sending side already does sanity check to mak=
e sure that no invalid protocol type exists in bundled and fragmented messa=
ges.
This only occurs when you create fake TIPC messages or tampering with exist=
ing messages. This is an invalid use case because TIPC is being used in an =
insecure
environment. In such environment, IPSec or TIPC encryption must be used as =
mentioned here https://datatracker.ietf.org/doc/html/draft-maloy-tipc-01.tx=
t#section-6

>
>Fix this by freeing unconsumed skbs with kfree_skb_reason() and setting th=
e

This approach can break user applications as explained below.

>drop reason to SKB_DROP_REASON_UNHANDLED_PROTO.
>
>Fixes: c637c1035534 ("tipc: resolve race problem at unicast message
>reception")
>Signed-off-by: xiaoshoukui <xiaoshoukui@gmail.com>
>---
> net/tipc/link.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 49dfc098d89b..3278a55=
9347b
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -1306,15 +1306,18 @@ static int tipc_link_input(struct tipc_link *l, st=
ruct
>sk_buff *skb,
> 		skb_queue_head_init(&tmpq);
> 		l->stats.recv_bundles++;
> 		l->stats.recv_bundled +=3D msg_msgcnt(hdr);
>-		while (tipc_msg_extract(skb, &iskb, &pos))
>-			tipc_data_input(l, iskb, &tmpq);
>+		while (tipc_msg_extract(skb, &iskb, &pos)) {
>+			if (!tipc_data_input(l, iskb, &tmpq))

This check is redundant because bundled messages do not contain message typ=
es that can make tipc_data_input() return false. The only exception is tamp=
ering with TIPC messages.
If that is the case, a fake valid message type can be inserted into the bun=
dle message and tipc_data_input() returns true but user applications are br=
oken by corrupt messages.

>+				kfree_skb_reason(iskb,
>SKB_DROP_REASON_UNHANDLED_PROTO);

Compiling  warnings: https://netdev-ctrl.bots.linux.dev/logview.html?f=3D/l=
ogs/build/1166117/14820384/checkpatch/stdout

>+		}
> 		tipc_skb_queue_splice_tail(&tmpq, inputq);
> 		return 0;
> 	} else if (usr =3D=3D MSG_FRAGMENTER) {
> 		l->stats.recv_fragments++;
> 		if (tipc_buf_append(reasm_skb, &skb)) {
> 			l->stats.recv_fragmented++;
>-			tipc_data_input(l, skb, inputq);
>+			if (!tipc_data_input(l, skb, inputq))

This check is redundant because fragmented messages do not contain message =
types that can make tipc_data_input() return false. The only exception is t=
ampering with TIPC messages.
If that is the case:
- dropping the invalid fragmented message will cause the reassembled messag=
e corrupt (For example: sending a 65KB message but dropping/truncating 1500=
 bytes). As a result, user
  applications receive corrupt messages.
- a fake fragmented message can ben sent and tipc_data_input() returns true=
 but user applications are broken by corrupt messages.

>+				kfree_skb_reason(skb,
>SKB_DROP_REASON_UNHANDLED_PROTO);
> 		} else if (!*reasm_skb && !link_is_bc_rcvlink(l)) {
> 			pr_warn_ratelimited("Unable to build fragment
>list\n");
> 			return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
>--
>2.34.1
>

