Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793242184;
	b=PyOhTR/O6+I48NGM0rZ4UwroTtwN3meJ+31mU/BVUKPsDcZQgxq+dUJEMd7ECatj2eXz
	 Xoe/WKTP+0733udLuIldC9RqS4qBb0bHSX6tQXMvnKTtGEacdN/6lYGboiZpEDlEhHe+T
	 x8YPmKCSmldrHqEQrCzBMdLI6Y9a/0LsBgCIfPO+1aIzI9cMzvCmoA/ZohSjCfUr1oUtv
	 SHV4EzleJcRH/lcZ9VzUriXNPALQDUmGkHHZXQrPMdEfSUT4RkpWdDit0Cv64SQlGK7H9
	 j7jBMHGbOSLwaWiRnE/7n6Jpa0m127aHZx9SCe0HkY4rp1f8p/nGyH/ccodQA3NgrAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242184;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=aH0+vORedE4RWEeIidio9sB5DknnPFD79fff0oYlbP0=;
	b=msiSOx0EmflamGop3liQBFVzIvJXcKH5/aeo3tWF15BL89NhGihIFxNimmzyvIb2Uhju
	 IuMurPpQ0FTBmKXzUaLkySA9NjqzQkjra6tPDugAdAJ4vSuGLxJfcI762+CriPRB3TVtm
	 cjrLk/q6uwU1OKSgjgUS6HFhedsU4LvTDafZ0xAMqKbjGSXSr/9uCu8Uopv7sUUBGAFih
	 F67+Pu7XyA81LqCH3lk00HiAbObcF9cUrEQ0ZGvpwDNZhApeSsYBRY2UwO63E2RIT4kus
	 1iXE5B6Ap0zlIKULP/7i4IYdm7jp7PkhYbHzlGjzACCjzS/e139FI7yrvzynj5Ph37A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=gkoqQCa2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.36
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC514606A320
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 02:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC514606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=gkoqQCa2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I49qWKz7cgxz7ZQNesmjJgWvzJmorDApzdKvYqbr6mYdFrMiG2lDsNnyiirPQqdR+5TB/RiquN8YZRhbkmJS1OaXuKhx2SOQ2j3NZUU/NUm1QxIxXIEhERLRR6dYsT1uV4dxvvTXwQluDLjVL6Mjt4zQAUtMz7TZR7PSBQ0Iy+dakmAxhd7GwjF/YDKMr3Z+hu70ZMkscpHkc9n6ka24ikQL7X5nwTbhan8JO+AojpFytDa5I5Q1V8/vfh9QFwRZwGStmA8FcnK3CEYmFEESy1ibL68NgVFFdRDirXl8REu5v04KvTfYArg3r3cKZSRFz7D18YFhDxUsfed4zb6zCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH0+vORedE4RWEeIidio9sB5DknnPFD79fff0oYlbP0=;
 b=lUR/IbkoUKv/GN3n+a/tP6tZOBHkguYRPRR6cyZXSEhy5sOgc0UcRlrLaRMcSwWaKhn9WNExxLa+hA8kwjVRAdEbSg/OdjcKBewJ+IvD3glX6es7HMFjpMrIDas/Z4hQ0HNqH0ZjtAafa9MVkrCSS1/XgCiMEaqjM/J0kzRTeQLP1ZDG8ZZIgUbjFeONde9iImEoAyEsM5dHPDlqILnTDWXlCdnXsOf9rAfxhrdU0O+FOQRz4WCc3CyhScyzomMiKqjRA6onhYsIGUvJG8wkYSRh2KVzZKAqlDUxXUkL6tzFhlNkrVqqAxKOVfrNV6fzXXfk38NMhm25JsHo0FKiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH0+vORedE4RWEeIidio9sB5DknnPFD79fff0oYlbP0=;
 b=gkoqQCa2xvk6hrYtycAtSnGJh6SfbZUhL8w3eO98CtbCuDE+RMjHqOeMyGw7zMrL3QJDFGVrC3Kn6m6i6R/QTsALO5dUowZV4qB1G9KtxDR7Z1ngbtZkEepnmwwl4Fze79/JL4tEWPKKAooISRFmsCCGRIKeLGpI5jXhwqMdi+/xiUlNOKYUa5KSc76bv5kfcTswakpDBVNyn5bPttMPVxSMmTVX19nZ7CNoWh65bnLAYBZIf7ygijUrJMPKO20AIdzReBNUINt3HA0p89xS73Mf/YkrXeK01B3zjQ15gfLCPTPnGFH+Jzkfo3bIGh+VbbpAxIDxC9h4Sf2rfqIfqw==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by GV1P189MB2786.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 02:49:38 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 02:49:37 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: James Sawyer <jamessawyer@outlook.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
	"syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com"
	<syzbot+64197f7577a09686ffdb@syzkaller.appspotmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [syzbot] [tipc?] general protection fault in tipc_named_node_up
Thread-Topic: [syzbot] [tipc?] general protection fault in tipc_named_node_up
Thread-Index: AQHdZy7reKXeIFHsqES7H/Ce1etydrcTwPPw
Date: Thu, 29 Oct 2026 02:49:37 +0000
Message-ID:
 <AM7P189MB11370959038C923A0B43B139C66E2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References:
 <DU4P194MB2971F7B03BF60380FEB6F834A76F2@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
In-Reply-To:
 <DU4P194MB2971F7B03BF60380FEB6F834A76F2@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|GV1P189MB2786:EE_
x-ms-office365-filtering-correlation-id: 7a5abe6c-802e-499b-36b9-08df35674591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|38070700021|261028144727099003|261021121427099003|56012099006|11063799006|261022105027099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 eGsPRcqbIpTE9430ZNd9On+ooswAspDU37PWe0r0U8JZxFBu5Qr/1vDXedT4V9XYygosFZ0yH11RGDtBM0Ke55y97aMNtjFEIRJuCPst+Bliu90gJgKLbbdo8I43PjI1a6pB/G1UPd55QqjIT5ea7UuVZGVLdP8D7tQXOdhrUxnBNi6tYkTxOF3So7qpoijvG/fZO0v5qV25b4ND/VUjZtwXYCfdJCToAXSQPQTEHeqzZ9TvF1vd2Zy5avq1Mtqv2wtGkSZE9J7IvZaly4efm69FWMhN26+HDEBNnMYqqcoS/5A81DVKwJ1cOxKBmOWE9YIhPOarPC6d0n6ZShC7BTM1EUPObH4Sk6SWnZasBLSHRCizxJ81H/T+5k47O3N7IaFLIV5VRyFrLDyL/WeoNs42s6ASAoye9S5OYmvuIdKA1Wq4qYPgAtKh+otD2GZCAQMKJ8HAhxOTiTinDlMX6LrCrH4kh50z5J06oG21TcPeDViA/+ng2I5e3eHMFip2EpQfdvujdttYn1cFiaZi0U3n/zIgat9TiVdbvBgHuCvnmKk1l93EPqqXRH4rhF2wIbZXn4+ZkznkVYgUUsuGZx9tj1XS2wHUdXwxPC/jhVcJBUOgWfS6Kuc0DhIoYyyzYsSNt2ku1B8N/XI4gZT9CIYzOz8AG9c05J0tvPrzWGc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(38070700021)(261028144727099003)(261021121427099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LuOJP0rPbgDb4utlIMad0Qah3MjQT97lPMh0YBfA3NBtgV6kGdQkXFQgWW?=
 =?iso-8859-1?Q?vFJ5KWzMuoJK1dPPSfgV6b6/lPLFFAGMp8wadkwDzaYVjT1oMwKfmaPG6m?=
 =?iso-8859-1?Q?aBNgEZfrXUkJfBTav9mt/iOnoKTptBx/ukEnzgqrnZZTuA8EAPiS3ZS6lr?=
 =?iso-8859-1?Q?YpLjW0Oy7aADmpCM0i1iwvgNzC3WResbiRzewQ2KaVv6tq6U/4qvWdCD1d?=
 =?iso-8859-1?Q?a+Utq4TW4uWcuwFEzZIKMQJxqD9DRaQe8pbcQU4MvzzoYN2E755JDaDPXy?=
 =?iso-8859-1?Q?dm8wjm4WiVbj8BXvHnlCwMiiPP6ohUD8mBnFPSgr1/m42D/hmLSD4kMRvI?=
 =?iso-8859-1?Q?xSGqDrne4+Wdr2wk78j1yBxjhzHKTWWi8Hacu3Eb+0vWXssV4Zx11jFKXN?=
 =?iso-8859-1?Q?RY+Gg+iWrPcm7b/anHxPmLYBxrUmq7tMQny9tQfo5megvo+UBkGyzF/ngO?=
 =?iso-8859-1?Q?Q2oV1qyqqQN5GhRyJ4gZnagR7m9hfdp/hBnimD0BYs2kPtnABs16Q0E57V?=
 =?iso-8859-1?Q?kbAnqki5MV78GZuRvIHmmXZBvoUJHQjcSc5ja2vBx/iNgNfVo/GNJYhnFy?=
 =?iso-8859-1?Q?4DIr3Jt5JkegfXHqhfkc1pxi6EOpbFXwVYrhA3MZ5MglXY2KrlZeZglw8m?=
 =?iso-8859-1?Q?Xq28+bhUboq7NDwLNF12FHGakQvcAAUeOQo8PWLlf9xQhPSmHGOFbyH0qk?=
 =?iso-8859-1?Q?RJJmYHe9pXUneMu/j4Io3bk3R27TRLFJAzw5/vVRm86QNx8ZTJKCqUVxOW?=
 =?iso-8859-1?Q?Hh7nFcE3wlF2y9mwio+UVYoqUYTs0QfIhFK/KeVb5FshqzGDdxl0W+41bw?=
 =?iso-8859-1?Q?A+rU3Aomtlc+JqaRzS/S3S6HbM1cS1n555Ez03malKVmQ5djhBrkezy+1X?=
 =?iso-8859-1?Q?H+I0IFnI98eTt7vMYgQR3HfBDZppfFVM750qtMuJW1IP9NfZEvvMm+fT2B?=
 =?iso-8859-1?Q?ElRuxlkmkp02uU7rkgIaRHJyVtzZr5GLUG0WIpbjhar03GExTSPA0svfyl?=
 =?iso-8859-1?Q?BAdWg5NUqrb1Kf32wJNumyLDfvv+dgF6tUoUMd8Yj716lmOLZ4YdR4o/HF?=
 =?iso-8859-1?Q?qzrl1zHh8lSxMzhkuUvdAngqnlRIZGoCR9JCZ1l0e19ML5+yRisHMv4to9?=
 =?iso-8859-1?Q?NjiMiwUhAPoeHzgq83chB6RL1+Mul+RJZQr5vWVPuKUGQBh+lxfyV+u5NE?=
 =?iso-8859-1?Q?k7s+rg2ATl9qH8p0APSxwB5fB4928Ss5xS+zK2Yjwl4AbdPjm1nJ9xGQJX?=
 =?iso-8859-1?Q?37DYUovYPb0HyoDjiDAJIfzwQ5JQpMvsuNnpmYXuU5RZZ6+fMbvbWonWpX?=
 =?iso-8859-1?Q?oeFTkk7mxiaZ/BHnbvk1mkdJzSDIW33vDQL3cjpPu3MtYkdAGgLF1AM8Vq?=
 =?iso-8859-1?Q?J1uvuAtNa1mL3bpqHPbG8TIgXbloS9k8BFqt8dMRkJX4xP8IbJA9j7so7J?=
 =?iso-8859-1?Q?wIpXrvZmqPsJKM8uLehjb9BTGxnUvUmQy7vw7LkWpHZb714AFzpL44cOuc?=
 =?iso-8859-1?Q?i0Dq3WRJgnRcnFVDsANCg3Uaym0pgzCsaoZtoFQZGASp34JZDi672PUM2p?=
 =?iso-8859-1?Q?OcstqmF3ScerGwUUhPrCtDLXCHNbeZelSgsu7d6H4tLfASjfo2R4T/n3qT?=
 =?iso-8859-1?Q?m8pp2/3ODlefHJ/7hHDfanY0pAFCacmOtl2kHZ5wY+0nMXK+9IzUUHHEr2?=
 =?iso-8859-1?Q?O/Pd2rpBfZZDnrc6m8XTjytDGJsvYvxOvX5IrSCwadyd+g8p5kD7KrkFzq?=
 =?iso-8859-1?Q?TiGuBDDzZItiAmLmdPzW7RvaFlFScpSdoLW5Vry1ztUX1tPXsjJQBcbOso?=
 =?iso-8859-1?Q?Ajkk4zlrY3ekEftlj/YtQYpqKNF2mtQ7rV5t/0Cd7g//rylJ6uN2LAmAvj?=
 =?iso-8859-1?Q?Tx?=
x-ms-exchange-antispam-messagedata-1: 6SuRaM8UplPHzg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5abe6c-802e-499b-36b9-08df35674591
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 02:49:37.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QbyKtMdFp+sRQSOwAO7BEOTCUnyxTbn2hjnDwkEsNK1ubxbIY68TEIYW6ySclrPsDw4+p84xvTqgQ1yDuP1fiLWKMcl5Aq/M9QbumjLpgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2786

> Looking through the source code, I came across this section in named_dist=
ribute():=0A=
> while (item_cnt < ITEM_BULK_SIZE) {=0A=
>=A0 =A0 =A0 =A0if (!skb_peek(list)) {=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_set_link_selector(buf_msg(skb_peek_tail(l=
ist)),=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d=
est & 1);=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;=0A=
> =A0 =A0 =A0 }=0A=
=0A=
Not sure what kernel version you referred to. But the latest kernel version=
 does not have above code.=0A=
=0A=
> Possible fix=0A=
> I tried a NULL check around the problematic access, and syzbot successful=
ly tested that form of change. =0A=
=0A=
It is not a fix. It hides the bug and breaks user applications. User applic=
ations at remote peers  must be informed about node-up event.=0A=
=0A=
> However, I am unsure whether simply avoiding the dereference is the right=
 fix. From reading the code, I wondered whether an empty message might stil=
l need to be sent to indicate that the initial name distribution has finish=
ed. =0A=
=0A=
Sending an empty message is a wrong approach and will break user applicatio=
ns at remote peers.=0A=
=0A=
> Relationship to CVE-2026-98098=0A=
=A0=0A=
> I found CVE-2026-98098 after completing these tests. It reaches the same =
NULL dereference when publication exhaustion prevents the node-state public=
ation from being inserted. =0A=
=0A=
That is one 3 scenarios causing  NULL dereference. I decided to split my or=
iginal patch into smaller patches. One of them to address CVE-2026-98098.=
=0A=
The 2 remaining scenarios (one of them was reported by syzbot) are being ad=
dressed via:=0A=
https://lore.kernel.org/all/20261028033722.125477-3-tung.quang.nguyen@est.t=
ech/=0A=
=0A=
> Does my explanation of the NULL dereference seem reasonable?=0A=
No, it does not.=0A=
=0A=
=A0=0A=
