Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703D3BBA1A;
	Mon, 31 Aug 2026 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162423; cv=fail; b=X7oyYh63jlIXHygvj301FZ7mM8MvwZIrtorbe9UzrWO7aL1sc1Dlxgder+x7FXOaGnri7HapX2/Bxdb6Og87hc2ItKf/HLEy4eucmi/+cadzhkFMYo+zcrAkliL6V0bf4vs3z9s4JNJj9X4Y01Win0mKilLTatftMBjI3GUDFJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162423; c=relaxed/simple;
	bh=rXJhxzkbY/c6COehKSOmdWo9PN9qANaxIOHUsfLyZLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lq+McsHLvBa+NSZ6VWXPsSLK3rsdSJs1ndgMbce5gjv3BUPehHD/Q0xnTqJgqC5MUEkmbv+H9K92ZbsZ5DkiegCAqQBsQd45lS6KqsmmZtblpkQ8BPFCkQKGWShk57wtcpxXziYxn2Uh7UcLxsXiwicLYGqmMjjMozt3oCVQcFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=r7Wfgqzg; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="r7Wfgqzg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUx0t9UJ5chLGlZkcd9XQb6NskqPoxnJ7t8lhuZoD44WIsnR37kMYrUymccsVbtIF2lM4tS33MVXYLl9hZ0+mElIsdxqqn9fCqbXu2cQM+L5WiHrrhn6BezkjMKvR8L/FSIPzxWWWllwvPFpyhXS5mQPPSpbhihaM5jWZj3POZkIsJODm3/2iNbrxzGHH6UQZ12UR1vVSpm2XNJnTej24CdjrAqYHnnja/Yydgin9WaFwtmSyqCoz9l6kOn9zvnmW54jX+GGq5+ud/HbQs2AgwFdZzlkm8wWrcjw74X0YW3NI3Jc68c+Ys3y7OO7MSneFUUdULwVByLwImsm2xBSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBdNpBXNuPh1OT5YmLtCXnGeT2qC9KxEAwD/hVil500=;
 b=qG8HlKw3CLP8l+qyeC1nEil1n90yIZAQGhosBSoZkr3zPw4EWiESw6gul1IbuMeILzRHjX8q6uHtcfi0JwT4fueLcNae+4/rOlmI/vPr7OnhOKNo8TtMbGaz7KjBqoPGj4L9dhi7ELehYZX/oHnHCQITBnVeFXjzbBJC+u4u6eIuy45w0tPm5JNQC5CuAd68iZ2lmYgKoaR8pB+1N2BpNxMo6kbgyLvLH9nmHPWvxgWjzeLwIfGpmy2bbP3lJKADS8dM4VoJBQgSm9rxB4lwhvqH3p5p5L9mI6mrAqbWfPXaZpC603hIHB4wx0LtAS0Ybxkvsjk0YCWK65svLSKa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBdNpBXNuPh1OT5YmLtCXnGeT2qC9KxEAwD/hVil500=;
 b=r7WfgqzgF5dL3AsT9mnuUyOrI72tD19DfXeCDsj6VT9SsRaL8w09o3ecZ250EbJLy2wKG+610nKbF60wMj+RWPRv7PTVd1vM3oAhKHMbTq76EtvBJ5nnRZDbdWwNBzWBDwN6AL4GU+9p/b0rKx0asGJqJHCpg8KWvOG9bYc276Gh+uu07mpubDswaMWGxXl4AbOOjRtlqjo2nUtw15qfwKZA16tgCnIJvFQUTKjxJSAEqkUZZ/dTA+FX6W/HhXPaSRygD3NT9yl0oMe03upki/fRmdHSBzeEItmZpln8rNFB/dapixwLojvmusfZWYBLfyulMqtCw4X+9/KmD4Zvhw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM7P189MB0790.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:121::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 07:46:58 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:46:58 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: David Laight <david.laight.linux@gmail.com>
CC: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jon
 Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] tipc: Dont send random pad bytes in RESET/ACTIVATE
 messages
Thread-Topic: [PATCH net] tipc: Dont send random pad bytes in RESET/ACTIVATE
 messages
Thread-Index: AQHdN621JLxzjATqykqDJ7VLHlMHtLa3yCmg
Date: Mon, 31 Aug 2026 07:46:58 +0000
Message-ID:
 <GV1P189MB198870CD8F066C7A17B927F1C6A92@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260829115813.188600-1-david.laight.linux@gmail.com>
In-Reply-To: <20260829115813.188600-1-david.laight.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM7P189MB0790:EE_
x-ms-office365-filtering-correlation-id: c4e01a48-fb6d-49a3-8064-08df07340922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|6133799003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 uLe6ZdaP2pisRcqPseOWWlYcr9YVfeMftSIvWBMggzieJ3i3aNAxaNcDt25syOolASmr9xvEh5o21AXShDPSweFTttizndUAliiec2UTOlWnCE7pbfE3ujLPLMnH5agbuZL/rO0xbh3Zml80sZWK9bWGjhIcg3NZiWl2O+H68MuYrept7BqHCFdE/bBylAbNct8H+Qg/nG6Pzn4l4mcDfDgDiNghrtfWvzHb24tWr+vl8+8HMhN7xbKZAB1bJfxahFR1VP8fhNa28CzV7tr5hza3p6woDvOGtSiChLxmC5V7jUSs7nvgVKH+yYxa/rwkPlyaRLmgYNuVrwVuJQEBpgyAL2KyUSk2/M9tibNnxwMWyQMpy7uS/Nq4RZs/NxAmCid2tuJ4H8PemmMrmoNH+eo3CegeQ8ALFSrW82mcrHonTyfH/AtRbCfFZsjoqeE++rvM0xuoluNx/KNilA/pD/uvbqXeLSET9y3Z3fsUzKb6XouGe8eNyit3rd+uQsp7VbJKYAUlwyK8qoDHPnDsHXzb69kwX8ubOzQCeyu4xzWN2fOgW/VtLsUCcmN4JB3U5SI2YD/d9YZij3s4mE0Gp38JM1JivAfQcSFpXbZMys2lvwJmax9vYIdXk8O+LPC4oszNbPx8FR1IF1XiIbRrvuKe3nRdC9rnpMnEq59x5N/4mkf32VfWUAjuv4/nBs0mMHKYA8NPP4oYs+GqAlwf7stacCMt2p0V+BZH31Yh/88=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rUD88C7+sexFVn7bcdjW+Unu3pf9QjVH9A/wWGmvw0Gn8aKP+PVxoOGgP2rn?=
 =?us-ascii?Q?qyF5vMS/rah81r7zusNuesl1n6bGUGkSm6jGoopR5lMOzyrbmISz3KR1eFx/?=
 =?us-ascii?Q?JqYA9eQMytqx1zVry5Ox+0rgngBtNcBbmta/yEBoWRLPxYlHymOWM8k0NrBw?=
 =?us-ascii?Q?GmJUTNfYZENrB0OiNzKM7GBcjGAlV0jg7TxoaitBd4PvQzQ+T58ZqkJj/ySC?=
 =?us-ascii?Q?MWaGHCyLBUahpDqsO1rTUez9tZW5HU0UBI3geFVyvCWZ5QPCGEdjc55nbEHH?=
 =?us-ascii?Q?R7pmKbdbBDg/81fJXqOFZI7gtVZNj6LDqxNlWxzz9aBZu/nhP8SLn0Z94IN1?=
 =?us-ascii?Q?PETyaq/Fxoo0LcE6BIOVo4X1MS915h6UeMnn+Mi3aykrRU0VSsLY+W5KTkzp?=
 =?us-ascii?Q?7CCXGMGVbOZJObSOOKwLBEJopggXBtcP/hzu9TfzlZCoZC9Ekb/EzqazxIut?=
 =?us-ascii?Q?bAsxXTy8jgJulcLFO6gIcj2yBqws2xfBll9reCalhXKsB9AYvlmxzlk90xWW?=
 =?us-ascii?Q?LGXtMF4Gf3L5Lg2R7w+KTYWGc5jGGm2ezYzS9lLnfIaCX/dWhYgaLs8X+xe2?=
 =?us-ascii?Q?xX/h5Y8xV1tORUnRSlmPhiIEclcE94NOA1NOau6fB9vZzYdcuHM7Ce065zmC?=
 =?us-ascii?Q?8LeALfwqt2vyln/KQ9NddqdGFqUROl7v5jwIWXLQMj9MV/JYjKb4pRk68/TK?=
 =?us-ascii?Q?OuZBt9M9gIStl4mCaScklI43JD4DWDwSq4xJ5hcXOcIUPA72x0v3ZlT8CYnr?=
 =?us-ascii?Q?cN6iOv8U5VzwnDyQGPhog/okA4cqQBIRqHZvHlZ/lFN6B+aXux+vl9avvR2c?=
 =?us-ascii?Q?YC0gSRcn+bvZS3kDAEVx4dcQNDYBkZP8AfZ5tMu1Hzy4ClMPD+bhkRK6NXed?=
 =?us-ascii?Q?Hs49GN5hLtcnzC4FA2BUqN3i4Xd9QuwhAz6klHVQ2E5tNICE2DVuNl9zr1HG?=
 =?us-ascii?Q?lI1TM/ILidX7Qe2lnX798xEPwKow4RcJktiRxi2Kz61QT5YtaRcG9jWzCIeN?=
 =?us-ascii?Q?WwkiqWBnbYc4zlVM31qMq+z0aJ3isXDQzbUAPcviS4J0NWCcDF3eDmDCa9J1?=
 =?us-ascii?Q?VluRL12xPo8tF48LRY+IjcL7hlFSTakPwayf/3ilBANM9XRXAy4xesJ2dl7B?=
 =?us-ascii?Q?Y4W6sxf1JrzmvEN8iqbriJyP5VHMeCSmsIxb6h/kO+LM9VR7oJR4s5cCcxJ9?=
 =?us-ascii?Q?XbgC2yy+dW1ryjUmVUKuessyDFN7WXwXmZaQY3niBB4TIooWoZV6kTcE2o/g?=
 =?us-ascii?Q?yIiLU32IOtoEUwUJfb2MPc4OA5oo15pg1Qo7aG3IWR4aQPww22LOFLGIBBhC?=
 =?us-ascii?Q?8Phgm6oylylWMQ0rG/BmtYZ85jsSGK7kZrlFGxsaM5TlQdyGqt1Sjhjz4W7Y?=
 =?us-ascii?Q?qBlCS0xU4soxO0UgFoGjKf9CWd1abdLp29BNyh4Rr2nk+pB9ru0+k3eBxqWb?=
 =?us-ascii?Q?A9Yjs3Etu72laxo2BtbPULJm0oA9Pbb7zBqUo7AOr6QDFdo8htIJjU9jIlRj?=
 =?us-ascii?Q?RbPdmWagyfTlO5+VRCaDt1ehWHe3AJ8BtHLHF+ObKlNU8BO7k+CB9GhvVOMq?=
 =?us-ascii?Q?Z2483n9HpS85V1gQI2nPizsGuCCHDg/sAAlPvgYN+jW6YDtiZEhtTKPmzx6o?=
 =?us-ascii?Q?Oik6DUiZh7xqQEf/gVrW6IuqI4uT9x0QGrCSZIWCvzdA4H+uHlws9URb88O0?=
 =?us-ascii?Q?v9TIrBY1Cyh5OUMkPUAFIZoGSZwhFhyWbvML4MeHiRpY3L5A0N21Ln/Dy5ZI?=
 =?us-ascii?Q?draeIL5hZg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e01a48-fb6d-49a3-8064-08df07340922
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 07:46:58.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4vbwJN0UaAPou4ISWOJb539668eTYYGyU3pdyxrj3jV1tqNPW46D1OlnIO9gIutbRUOhrz+d2ghLq7PWeoYee802ptqALCjYD05YCku6Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0790

>Subject: [PATCH net] tipc: Dont send random pad bytes in RESET/ACTIVATE
>messages
>
>The interface name is passed in a fixed length (TIPC_MAX_IF_NAME) buffer.
>Replace the strcpy(data, l->if_name) with memcpy() so that the pad bytes a=
re
>actually written (l->if_name[] is zero padded) rather than sending random
>bytes from the skb to the remote system.
>
>Replace two other strcpy() with strscpy().
>
>Fixes: e74a386d70c7 ("tipc: remove pre-allocated message header in link
>struct")
>Signed-off-by: David Laight <david.laight.linux@gmail.com>
>---
> net/tipc/link.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 49dfc098d89b..6427c69=
f8929
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -504,7 +504,7 @@ bool tipc_link_create(struct net *net, char *if_name,
>int bearer_id,
> 	snprintf(l->name, sizeof(l->name), "%s:%s-%s:unknown",
> 		 self_str, if_name, peer_str);
>
>-	strcpy(l->if_name, if_name);
>+	strscpy(l->if_name, if_name);
> 	l->addr =3D peer;
> 	l->peer_caps =3D peer_caps;
> 	l->net =3D net;
>@@ -574,7 +574,7 @@ bool tipc_link_bc_create(struct net *net, u32
>ownnode, u32 peer, u8 *peer_id,
> 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
> 			 peer_str);
> 	} else {
>-		strcpy(l->name, tipc_bclink_name);
>+		strscpy(l->name, tipc_bclink_name);
> 	}
> 	trace_tipc_link_reset(l, TIPC_DUMP_ALL, "bclink created!");
> 	tipc_link_reset(l);
>@@ -1898,7 +1898,7 @@ static void tipc_link_build_proto_msg(struct tipc_li=
nk
>*l, int mtyp, bool probe,
> 			msg_set_dest_session(hdr, l->peer_session);
> 		}
> 		msg_set_max_pkt(hdr, l->advertised_mtu);
>-		strcpy(data, l->if_name);
>+		memcpy(data, l->if_name, TIPC_MAX_IF_NAME);
> 		msg_set_size(hdr, INT_H_SIZE + TIPC_MAX_IF_NAME);
> 		skb_trim(skb, INT_H_SIZE + TIPC_MAX_IF_NAME);
> 	}
>--
>2.39.5
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>
