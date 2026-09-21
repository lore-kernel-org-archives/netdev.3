Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023082.outbound.protection.outlook.com [40.107.162.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15F318146;
	Mon, 21 Sep 2026 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789963171; cv=fail; b=jaVF3Xj0U8QYqYjQmUYGdYy43L4SmZm56f8hNP8dxWtdNrIndx9kP12hxMac1gDHWOQ+IDzwF0UYTKOuqhXmhzg4r92zjj8hjSEwTTelptwzImvkrNpcxWmOq/oKoeIAVqyHU9Qn80Skwapms96uY8zs+U50ylQzzHsQtJvHqNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789963171; c=relaxed/simple;
	bh=Xta23XDIsbEyEzL2u3E+1QkBp3fXbLr8UgU6W+fzSm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4W6QUKakNbioHOvBa9UpvAG9Kxh/0F0oqY7WUI7xD1WT+qkKIwSU4rRHTSPdFM+DsVE7GhTqSCVrJjWERVxABzNqdUhu0JePu/ahinFwBXlRqY7ggvpRzf6YtffJajCwIAWR/t+gfRSL6E8iiLvDebcihuf+jaAHk9VsPYQC4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=studio.unibo.it; spf=pass smtp.mailfrom=studio.unibo.it; dkim=pass (2048-bit key) header.d=studio.unibo.it header.i=@studio.unibo.it header.b=DJGkHVtv; arc=fail smtp.client-ip=40.107.162.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=studio.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studio.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studio.unibo.it header.i=@studio.unibo.it header.b="DJGkHVtv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u96FLUPK0TQvSR+5tDxK30xLQfu8Hz2bQ+kNtfgCcy1Z5xyRYCKus1JFo6G4NmduqkLChoirG0yg9WnHADRYe8zrJ/+/LsGul23wzoktXJWoAnijhRMy871GP9jv6G57yhHBNueG1+NjHZWwvQyCvy63vt+bRUBNqPu9qn1dz+9dXEvamVq6WoGl9U3yyRYQOqWTpdxkP8Xicsieo1FFuW4hEHFHDR/LQg+a+dlOE45aL4tFgNV44/gvmcWJPxvqpMhzxPaIpGUCTcoGRjQ7xUYCz6R9TwwtDM8T8/akKNd7FEor9ZEtjZZVO5Npt9SdZvkWZbQ+TSfo3lD3rx1aDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZAHRiu0PooHTSqhHaLit40v5LxWmxmfilztbQWTAqI=;
 b=fF2UDsRo26P7M7IzqfdsmJ1XrT+LgTlgqfU2fsHs5TVF7+WK8MWNR3b4AZ9r9/jwZcLlhhwHmZmTqRR0hrF5LZ6Ol/UISFsPunUDpKq4G6IMJhDbcdJhXyFpzp5Fg8tUTp5BdWtnCeWwfnCXPBRGhWGCLjS70RNowus6AIcqaugG4SYioiraPT0/jj0WH/6X6+T9LigbrvEGXvylTXrrSNEc7Bp7evLG52oO/tTM+bBkxuEZsOP17UVFaDDtEdwXt6QQH6iNFfSPa35SNPa0EiRj6/QNJb6ioW7Pp4LAmXYGxgJick18GrpWSctBDVpSihZ+7TN1Mi/VXUe9UMoU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studio.unibo.it; dmarc=pass action=none
 header.from=studio.unibo.it; dkim=pass header.d=studio.unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studio.unibo.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZAHRiu0PooHTSqhHaLit40v5LxWmxmfilztbQWTAqI=;
 b=DJGkHVtv8RlvDViDMMeUtkygM7kq6sF5cgYTzRYHAuuOnp4ikAhqaxMUo5GRsVOuXMxSjOjxF0iEHs30ojNB3CG02NKYk4Ybpl19C4qpNvuRJtdw0zqbNWfjjkYLndkKbwwn1swYEYwiRsGl/31oS7G5iDUqlDYietP0Z4lpbf5wHcBO+IvO+cSkYUl8BNDaebj83l4K6PVBqwsvG+DxW+yUphNxApaxhDR5acEG27FP1Nnq/29yXzuqTdo4gYHCZssSo+Zd5sZQ2YgHRBPBASbW6uJ2CQdWYA0RY9CJ3ERSGvlwbyjmewCvGkeFrFe0GtXIGTKkjuQdQSszm2OS6A==
Received: from DU4PR01MB12163.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:620::18) by PR3PR01MB7891.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:14e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 03:58:37 +0000
Received: from DU4PR01MB12163.eurprd01.prod.exchangelabs.com
 ([fe80::bffd:753f:fbcc:c402]) by
 DU4PR01MB12163.eurprd01.prod.exchangelabs.com ([fe80::bffd:753f:fbcc:c402%6])
 with mapi id 15.21.0428.015; Mon, 21 Sep 2026 03:58:36 +0000
From: =?iso-8859-1?Q?Nicol=F2_Giuliani_-_nicolo=2Egiuliani6=40studio=2Eunibo=2E?=
 =?iso-8859-1?Q?it?= <nicolo.giuliani6@studio.unibo.it>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: R: R: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the
 TAI period is invalid
Thread-Topic: R: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if
 the TAI period is invalid
Thread-Index:
 AQHdSHBd+pGZ8FgfBki6KEuSlYSfVLbXjVuAgAAtc+WAABhkgIAAAq6SgAAlS4CAAG7CPQ==
Date: Mon, 21 Sep 2026 03:58:36 +0000
Message-ID:
 <DU4PR01MB12163BB705A30C3A2F231F82680842@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
References: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>
 <66937bde-51a0-49d2-9ae7-f27fb4f8ecde@lunn.ch>
 <DU4PR01MB12163870875DEF21E5C39DD2D80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
 <fde8b48a-10ed-46fd-b477-18ac57df8a88@lunn.ch>
 <DU4PR01MB12163D71C8AF5C7695B2FB8BD80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
 <f5d30e0b-9b10-45b4-a158-19c946c0c8bd@lunn.ch>
In-Reply-To: <f5d30e0b-9b10-45b4-a158-19c946c0c8bd@lunn.ch>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=studio.unibo.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4PR01MB12163:EE_|PR3PR01MB7891:EE_
x-ms-office365-filtering-correlation-id: 6ac69491-1644-41ad-473c-08df17949ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|786006|1800799024|376014|366016|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 eU08CvYYxtzeXN2fF3twkd1tCwmTGTpwZ6BmYrwVSLYoR1Rcfme4hK5xBHb3eR8nvmXlKFE7PTtx71phwaxxVcD8Q1ttn0v8MEuPr3iI4b7ikUjTVc6twQ23ODLHJB7skB8zuyB5ScY8n70QI6E8YBZY6sSCYXqf7C1VnXOsjIWwOSnHxLewHDlq2+DsANSL9wJygmItrbjfrk96FvHCU80AGfi7woDZqY5FXqjiYRy153N3PGMGr2S0iGDZwxVTM/RuIhcV8CPm4l9MICwZQXkM33uagk92LGSYEXBQa8LrKwwvIZFTi9/PEY2VJPrDKIUso8Dr+9nwSP3fcyPgDQ1LuTXwJa+FyigtIQ3aEj+gSPaVqTvgYBquF/mwSMftsNWNrWMxQHmg6XpMfoXXd/AyvFCBH1iOd4p/hWzV5okUu2iZCVeVFwxfixTw9+M924kNi8Y6u8On+xsuwt1huC2OJRqAgFxuGoxKmJvhOPFqR0l8SaGcJqf/FOQxJwY4NWzsp7+sc2kUgKTTTcpbJP0ARqDg9lJayIsYiE8hgT1DPPAAAFIf0Y6JvbU1LgPuFuLTIW9ZPkgmwZciKO4fW56D8NuXz/GCr0R7eDujJ8m001obIfRbZFFDKyzMolgdI3gT8J61SK0drTmGK4sTIu95PKl60iCizckIl0ZsH8M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR01MB12163.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(786006)(1800799024)(376014)(366016)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uBscRfoVITbLReiJs1B6bwZgP5iz1PXptYtPBcUNjrfZKOiYZVwMO8bV65?=
 =?iso-8859-1?Q?UKuC70eK+8BReXizJs12GBmu1TDJdVSTqrJJYqHKdgBbENPfQG+qqjB4/A?=
 =?iso-8859-1?Q?y1i3bGxzJKAkBeqegbRoQvRcASniATyWg6uGFPh5XAYR0wDvON992sA91+?=
 =?iso-8859-1?Q?+pRNTwC0bmOyNEIdyC22DsESflvbR5pgnTQ3MvsJvXs3ijmaov5QGG3Rbp?=
 =?iso-8859-1?Q?L/SGXfEJt7pXDypRGGSgGvTkqX2S5j1rsmxjV2JIv5aqbn+0AXT92JltVW?=
 =?iso-8859-1?Q?NwklTaNSCEDi1mZ4r8W9AUQJEV0D3mmktyasTWO/llRGmMHFttevgurzGi?=
 =?iso-8859-1?Q?Lj66DOmRsAC3gG91uOLsvl2Yn2PGkMKITnXqh3pJbtr+eJMM0MCi8NPvjr?=
 =?iso-8859-1?Q?eQgFmOPE5OjhTR0ctNFfeTseLyXSyLF6QHIIHPHhodJnfVbovP8mGeyrhq?=
 =?iso-8859-1?Q?Wcy2/LSvow+hX4H2eoTn+cZt2Qv8Ysv7vm/feGlnrw1wLq6LfY7x7IgT3n?=
 =?iso-8859-1?Q?LOf/lS/txi4Pg4qZYwGqLttZCYaLR/GDV6s91RKkxIAPHUP/CLkr0X0THC?=
 =?iso-8859-1?Q?kFQcR3NMJcsY1pQjmycgk5wUSpxQjgDXQBl/mxUAdlWVIFMXRhHqtc1Vw1?=
 =?iso-8859-1?Q?9R9YzsYkiERzPuZ3gcZRFS41LY513bi1GuEX9gZzE+fhTxMwQguxvKxdJH?=
 =?iso-8859-1?Q?htmNWY8jFdIcaevBTDMVfH/Q/jlP7c8LQiFI04c1FGzufjkV86uRw4caMR?=
 =?iso-8859-1?Q?XfFlCoGFoCpsfkJYiD/jlm++4mDYumN16K6BTVa/D0dM3ti9BanlX2TeGO?=
 =?iso-8859-1?Q?l/IlhGAo3rurPpf0deDfmkfATiZQJFn8IwQxF6wuWShu/MJxqBl1xQrvtZ?=
 =?iso-8859-1?Q?9Y9MdquIiA/JRkInXeZ+p2HcxNQe2fgPbL0RXaqEJn6of4S5WOWjz8A7Y9?=
 =?iso-8859-1?Q?AIdeODBlmTIWAkr5JcOt845vy8kdDYjqtXD7+hYYr25faARuSlUFwh1wfj?=
 =?iso-8859-1?Q?ySwoMDWN2ApTidoVjv1Z0Hh0bUVwmRDtUoBDm4bvTz15+zAbteVt3mezIT?=
 =?iso-8859-1?Q?LU//jDpV5aIHq7A77A7s5nr757Qblg/ZOFc8DUocl7WdhygE8Tz1hGxZHm?=
 =?iso-8859-1?Q?yaJgfUYrtQfhzoJMVppsZj+0jyOG2JVZHHkPJnJN61JcWQkMgsZt8m3RV8?=
 =?iso-8859-1?Q?p8OkdPepa6q/64k19b6AYwr6dQlJBWeHme9uJjEVWGv1lInKrIFo+bVxIW?=
 =?iso-8859-1?Q?gEEB0f3nogVLiGfv72yNhPSVU1uhl/PD14D2GZKic8PEWAleNRcq4V73wk?=
 =?iso-8859-1?Q?7+aXDhpzEM0W1vROHLaGfWIllek+jwinwhYKBaQS/qw97j/oEGb365YCxk?=
 =?iso-8859-1?Q?IsUJGjkXL/JjaCNYqc8KVqb0QMEUl7mYwOQiLtklPGWkCjzNYf66fGcaR3?=
 =?iso-8859-1?Q?AoI3COgDIW/czI/fYlctCq3PBeOmhBDUeGWpgu1ivOzBfXNHFs+CVQIR22?=
 =?iso-8859-1?Q?HcNeF4SKtmrD7c3138VjDZcVHsK2eb7RJK/jr4RDZQrItr8k9BSeQFvDNY?=
 =?iso-8859-1?Q?BvrnVAL+jgjV+g4/ymJWPer2u4KVqWjGgXlNXTx5HsVG0rGQHCbS/TPjtd?=
 =?iso-8859-1?Q?0mDkANBHz1jBylB73xcEAdRio3DcqBhXxrQFF4IONGKe7uCGiDKZE8+en4?=
 =?iso-8859-1?Q?gI5w7z4uMFoFw86r+FLPSLTeztm2/m+p/dqijzaf3PLCJgwa/60FPOVHmz?=
 =?iso-8859-1?Q?Gycm2OWnFcZQvzkjtPn63NkprDwwO7Ah053VQLKyeh2bY8E4wAHG2Za/Hf?=
 =?iso-8859-1?Q?Vsr+xO5xB6qHPf9M3kzi7gM4aENw028=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: studio.unibo.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4PR01MB12163.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac69491-1644-41ad-473c-08df17949ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 03:58:36.2881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMf31VugjUKE0zDW3SmqgbHgrpDyoTClwhx9n8zG9Coy4oOewtjXx1NcgQ/x/RtZuLuUvleljvrj8XwUf685OWsDYb1M+/rdp69umybdaaMIkpQ8rg1hHsiHWDUCfbAq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR01MB7891


Hi Andrew,

Thanks, that explains it. I have sent the patch as v2 in a new thread:

https://patch.msgid.link/20260921-send-net-v2-1-031ad720f140@studio.unibo.i=
t

It adds mv88e6191x_ops, a copy of mv88e6393x_ops without avb_ops and ptp_op=
s, uses it for the 88E6191X and the 88E6193X and drops ptp_support for both=
, so the 88E6393X is unchanged. I included the 88E6191X because UMSD descri=
bes it the same way; I only have an 88E6193X, so that entry is untested.

I tested it on the 88E6193X of the Sophos XGS 107w (Linux 6.18.52): with th=
e driver unbound and the module replaced by one built with the patch, and w=
ithout the workaround from v1, the switch is detected as 0x1930, the eight =
PHYs and the 10gbase-r link come up, there is no PTP error and no PHC is re=
gistered.

Thanks,
Nicolo Giuliani

________________________________________
Da: Andrew Lunn <andrew@lunn.ch>
Inviato: domenica 20 settembre 2026 23:21
A: Nicol=F2 Giuliani - nicolo.giuliani6@studio.unibo.it
Cc: Vladimir Oltean; David S. Miller; Eric Dumazet; Jakub Kicinski; Paolo A=
beni; Richard Cochran; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
Oggetto: Re: R: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if=
 the TAI period is invalid

On Sun, Sep 20, 2026 at 07:08:57PM +0000, Nicol=F2 Giuliani - nicolo.giulia=
ni6@studio.unibo.it wrote:
> Hi Andrew,
>

> Thanks, that is what I needed. I checked it on the board (chip ID
> 0x1930, so the driver entry is the 88E6193X, family 6393, which uses
> mv88e6390_avb_ops and mv88e6352_ptp_ops):

Marvell names all there devices 88e6xyz. The x indicates the model
within the family y. The lower the value of x, the less features the
device has.

So i could well be the 88E6193X does not have avb, tsn and ptp.

Marvell has a vendor driver for these devices called UMSD. It has an
open source licence, but it is well hidden.

include/driver/msdSysConfig.h:  MSD_88E6193X =3D 0x193,   /* 88E6193X  - BG=
A package - No AVB, No Routing, No Cut-through*/

So i would say PTP is not available on this device. Please could you
submit a patch removing the mv88e6390_avb_ops and mv88e6352_ptp_ops.

There is also:

        MSD_88E6191X =3D 0x192,  /* Amethyst 88E6191X  - BGA package - No A=
VB, No Routing, No Cut-through, No TCAM, No 802.1BR*/

Maybe you can review that entry as well.

       Andrew
