Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3B3EC80B;
	Thu, 13 Aug 2026 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611008; cv=fail; b=F4wM2OLwZarr+M3kdwOUwZnOYGEcUWBiR/0nQ+UZdRUWR30e9lejvEe2xvI0M0KU4gClbz/JwT0slSL48TvnAF78Rl6LqztozpPQ4uxKCG5px/kxmhWisMcnVPr5EmWR3MdkO5TVBBMm4izoHOYqFLILtkcBgS4xo5Zft1L3f6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611008; c=relaxed/simple;
	bh=XMjSTnK8CxbHp5oniH7mpEv3XpOo+aJxO4V7n9Hehkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpa0f6NHyBOPDl0pbvaNiDyKYlwyHAl9u8JITILtn3IbQGEbJ31FswHZ35G4u+xvubiTcBEsNLY6XaJv+POCguJlp91YYbUBQYT2tlMY9X/BZgM23gnCxhuAjFdTpM9uFEQF3c5ila6Xk3txqirT0t14zBpLXElnamHPzjygiyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=fUs4Pzmk; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="fUs4Pzmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBpV2aRzsbJt5EHXC+pwdPwEUiGlud20YtTyOxawdfjNt1T54EpVYRP7x38stiuUO+TLp8R+Tmy65x7Fi48STCO5v7zkGiwZIcOTpa8/jMJAfWhq0frZAAZjFpF/8cS8zZF0mtUu/DPY3r2mRk3mrtmnOc4FyHIUL0zlHi2hZEjWcEX1zFmuMiBE7u3Qw5V1LBhA11p639GwIneOm4KUHpoezNtZf1gk0tajmIjF8EDLPkQGIV9+J0tChARz7PsKLoAx0yME0XWQG76PIqCV827VEq5PKKQr2dV2aQJO/apIze5rKd9a+1lsfzJPJFQCTH7NpV+A4VqCU1t/uysDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMjSTnK8CxbHp5oniH7mpEv3XpOo+aJxO4V7n9Hehkc=;
 b=GB02G9JYJN4Fr1u7sJgyr+OdQv9+3uOZbNtBn1/RC4xp7WBhFfXHrsWAPtCDqlkadAbysyBM05cemBDhS7yV/kHRIwTxo9mn5KL+z/BhNrQyEr0IP+c2ARtb6tf+iBfJ1p71issr9mWeHURTaqG8gNzqCl8FFzAXXB75tW/ahlW61nSRCdUaGWtU2SZbSRblFYWOFH7meQxVHY5IWsIhxZuWq/PzdBE8Q+2Fc5WfVphauTjzamlhj9aItrI4BKW6TsajJpxlkucJSVf8HyKPiDUKD7JhejQgSQThR4YF+dNbb36pgFQ6hhMqy+9c0+sgGK3ApPO8cIlPl7ox+7bSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMjSTnK8CxbHp5oniH7mpEv3XpOo+aJxO4V7n9Hehkc=;
 b=fUs4PzmkRAIN85e6vzloNKuX7scLSX+orQILZMXyNll7LeVoIS4DEo6bUZC3midl/FzvhKoiDpNwbfiJo6gx+k1zoAJ+mwJA5Ids68vTlh7s41Yff449KzYE7a16sHvCEn/B5u2Y+awomCXV21iZFs+ud1cZQ3JU1a0m5Vm5Bqv2Dc0DiLc+rciVCUcLX6R4V+oAqgH6MaAG04Gi8c/nK0IhfHDJ3ETsWKN0xAKG4PQ4H6a2Lws7cNuvY5UurCMixiWIIfG3icSvHnZd6y7xn3qR+pows40REXFzxKiROu8R0GkivT1aHm5kKLGGHYH4gbB8MgB0/zTNjde8ugXEhA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA3P189MB3329.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4da::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.13; Thu, 13 Aug 2026 08:49:57 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0339.001; Thu, 13 Aug 2026
 08:49:56 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ajith P V <ajithpv.linux@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: RE: [PATCH net-next v2] net: tipc: replace deprecated strcpy with
 strscpy
Thread-Topic: [PATCH net-next v2] net: tipc: replace deprecated strcpy with
 strscpy
Thread-Index: AQHdKl2lKTP1KS4UXECvqi1JlPa0oLabq2HA
Date: Thu, 13 Aug 2026 08:49:56 +0000
Message-ID:
 <GV1P189MB1988C6E9E7E3012299F48125C6DB2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260812132203.206939-1-ajithpv.linux@gmail.com>
In-Reply-To: <20260812132203.206939-1-ajithpv.linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA3P189MB3329:EE_
x-ms-office365-filtering-correlation-id: 87c0a038-4654-4c73-bb35-08def917d9b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info:
 1gV7cLtj7goyQ+kCxzNT4cymdoSkrx2OC1eg0jyLAU51DgNjaxXYLYbICgz6n6GXvattuHUMximsk5YqVmCl8/cPvLCnv7zotn0cjSqX3ONIaHPxiegKTdIVqqCVmpORJXjABiRzo7NzWS5HouL13xwxj//um23vMlkp48WyFygEmVKHNDIPMs+gACYhWcbgAGZS4HgYPrVVL3yZxmZTeP+0uC7KnEp9M21VHZis9kCLFZCBJ0lGaECvMddbKDG4aSZwLYQvbQPHD9BR1HQqx425M7fJ28Ptn+DINAHyuTjOv95YohNspFvcoa/XVDmxWWNkIY2bYL9LomrXGxXNLcEFbRU5nLTTMd6wTrHtex03AqzOAzQkN8v7LC3cEWIfuoUaltVyt0lU9v6XhaQjSo2eDjGohWrjlCZzpHYtpJJDEdGlfz0RmO8Cby/BYJ3BgJVIcE2xUroVOX2ixWcV7XhxQpFT9SqMp9ILfYiEcV3a8I2vXN3AM+MJfE+HxE5PDVDVFpxxwOGEXl60RlkgyxrrVeDH+HdzfPbagJdykuxRlV0xS4ldVZJEBS9qZG8z//GraS3A3LB1c1D2/U8so2NOzC86AWKvdaU934LWzk3H6pCdT1C4tfVlUF9CaIjVufenmgmFvQDhLfJcVsoOI6eK1vTVKaTFnWbhro8sJ4vachS3be3OXWPtGQyrZNUF6YELkua5Di6IvINoTPdHCZlXZCcBS6STA+ud2tx9Mvk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gwZQh3OOOqji/jSLlcaIb/iCcWtJQx2B/NPidFVYxMxu7Iwe0G5Id4WieUIH?=
 =?us-ascii?Q?yrmEfYWz5vJ3olD65wokIZeZ1/XnbUMI6dcjZE8SNcruySQkcbKA0SFw5kQf?=
 =?us-ascii?Q?r68So0XJZjjhQp/6LH74WYKcdQ5QsS8ZRKnde2pfHOgjdrriueS9rM+Qzyxm?=
 =?us-ascii?Q?yU6U0in6pLhbCMtWGFKJFQc4JcESIITMmh0mOIez78UvkKoz0uCpA4iEB5k2?=
 =?us-ascii?Q?wOnt13D/PqOpQqTeE5GezSJRfbhk/GrVOoR5tAlGPzgrDETHJfoFXZARhqzu?=
 =?us-ascii?Q?SGtfCsolnyn8EXor1p/FtB0KeInytowmQcTtb8Mng9pF0YQ9Mt4VyEnJv8xS?=
 =?us-ascii?Q?FnuLXcW393u42IcGlYSIp3SrPdn2pw+GdwGNhKx6LZqA90ClNpzoVY19L11m?=
 =?us-ascii?Q?+zK7V42WhYtbSvpu2Jcufwj+zw8FoW9LsDC8Y/TB7h4236fy7LaJQvLmN93U?=
 =?us-ascii?Q?eKZdasToFPGqCdAuUbKAeEQi+B3+8InV1FpMppHKJcMpGo65OPDKxg7H2Plq?=
 =?us-ascii?Q?ypwEpeNcKokCSmjpCZcRwMlbZJ+qM5lmUJC2qkjfle0P3/kA/G0oMDgE186F?=
 =?us-ascii?Q?NPu5YBcm2u6qmySr1P7N4Hq93KfWv6xTGU1aflL/sjmyQ3ej7oSFqDg4QadT?=
 =?us-ascii?Q?c4p/7b1y7Bkv2FUPNYG89e5Z18qs/9gvBPQViBX5AyE4RaiKpRRFw+OIeSjm?=
 =?us-ascii?Q?XywEy2US2/62X2ebSjI131L/ikgwJgusjz3XUQp+yVxrD551Gv6HieoYdSM/?=
 =?us-ascii?Q?tOBYznzHhYHjcLJcCbuC6+PUZ+UKXbp0KypwUaHSMqiV/rKxYgaDt219S55H?=
 =?us-ascii?Q?sgGof+FYkdyh11wMKKyjrk5fRw5PqSS3634/rNM/GgMXZg9op78C24zRXA60?=
 =?us-ascii?Q?kkI6pr8u9yjYe/c/9ywUGhRoTV8JMvkGsGteyXgotGiwdJvd8EAan/iF2eTR?=
 =?us-ascii?Q?RUraRZdganuqA/nvjbzNivd9W5+u/GTXHDL4ljgnFGCRqriK853zEnx0okA6?=
 =?us-ascii?Q?NMf248JWWknEikWgxolOg5nKoRRdReBeG8WpJvSvNhPkI5Huy7z/yW9lXPie?=
 =?us-ascii?Q?8OIVlR8JccxdMuNMH80kLDoacW4V/Z3VOcmjr7qGFb0afJgm+tG0fBExfZEl?=
 =?us-ascii?Q?0LEVDwe3lIPxBraZQJY+julamohm47lOJRps/nV3WcyPhT+DBD3dMoLiTgtr?=
 =?us-ascii?Q?E+7jJ30Pg6nc2tyMg+QBzPvXFmeEJZelA0Fvv2iNI012vvOoiEq1dQcyfvap?=
 =?us-ascii?Q?K4M1bDS+S2YWPCYlleEDtQuTbJy1+9yD+UbQJKJS8F5/m1oufuFQmrQByww3?=
 =?us-ascii?Q?YoCmfC4KkgrBEV7RaiGmYOd4sGEQIDsFDp3BIXYBCOxUIAjfmejWIxrEt6DP?=
 =?us-ascii?Q?NMJ0OvAw0FPDE2Bpt7uTxWOJwuBMQ55N6Os8J+r/U3hqdmNzQK2zxpSJq2wH?=
 =?us-ascii?Q?LzRatx9g5fT3RjSfgkOuak4BD5NcrYhTZAatIJT2QyWjdsm+mZACkMTKuzdX?=
 =?us-ascii?Q?yqNKJM7brr9oy7tDREvfu1D8ZJVzMzsFyy6+2QyvignGUHC/OJdLDONJ+jEH?=
 =?us-ascii?Q?dyyTdn9diXHsd7g+ATkVIwWDzeD3ZIxnHJQzTgyBh/QOiYFz6F3gy+lJV7zB?=
 =?us-ascii?Q?i6gvC25+MjrrkIEWa/Ul4z0/ZhQDxio8Zq7ubOCkBmDbzS/rEX1AGgL4fm4U?=
 =?us-ascii?Q?GTmnEgvGiDFq7OShowfmrPPm4+7APBdjif9STvJ5dIx0GDBzm55w73txoLLA?=
 =?us-ascii?Q?7nX60iu0Sg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c0a038-4654-4c73-bb35-08def917d9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 08:49:56.4703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hG9ZtG87c8JyMbxEdvzWv5Imy//ZF8hrxM7p/WoTCAkj/iBliMpWfr48hcETyFXkox9qkLZ1odZLfRH4qpltjVsC/3H9gTQDo9+fE/m4IRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3P189MB3329

>Subject: [PATCH net-next v2] net: tipc: replace deprecated strcpy with str=
scpy
>

I should have made my previous comment clearer:
Please update your patch title like this:
"[PATCH net-next v3] tipc: replace deprecated strcpy with strscpy in tipc_b=
earer_get_name()"
