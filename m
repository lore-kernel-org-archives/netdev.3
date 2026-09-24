Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011067.outbound.protection.outlook.com [40.107.74.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891A44606D;
	Thu, 24 Sep 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240362; cv=fail; b=E29An4AAXt4rJDRSq3W1M16m2AVuo8RmLIDStnkGXPw5wae6zvZEkWgBJxcc8TJUpiciVop4NWDcPkBarAv+fzaL8ezuqVODleciZymq4jgvkLMR+nGCvcQcpb7/TGFW3b3GjnT+paBLMZn8gvFB4A+buGfAkueJgA/w7tczGfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240362; c=relaxed/simple;
	bh=KPT9WjJbQr4gOd6zbZgiHpyib2BjuupsTjX0SEkgeLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xt+7fAOgbEXtgVU3avDcuTg5Kew6TTqirqn2XTvFbXA167u/AZvbAvH1Nq56+6z9bBQjrJt1gEdBPPzUfBxiU/MykdJIdjeK7Q8WpilU9+DJ7cg1Yc1Vx1C+3BmoGYzfDGPExqjl8AN2KgGeJm+J81R00rZYrMaD6ZJ5Jy1pPjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=FlwhQ45P; arc=fail smtp.client-ip=40.107.74.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="FlwhQ45P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeRKUTQoZUtQBqIP6upbqKa1Ait8LR9xqgT44cJQA0f9SVRBOEhQXrbFUfG/aQkD/w3uYbRLoQAalRZJkoVU9UzJm0wHI4a3G228p0q0sdIbp8Z5eKOQiCUDHGw81kPuCFkFmhGbR5TnMfZYzVKzLIQu0aXrVkaPSZ1Wtffjsmdu1RscV6li68S4O6AkiJAwu2/yAArQj0WmvKcu9odThpQf7uJYyO3pysISg75h38eTDi22xlxsYHvnCOOqgggCeaOhkjlU/sTE6nYQ3X+DFUH3qVUmXfnJpUY6cwjlP45ymnG11H2lbcvYBiBwgDkWPg2bQqX7IRvjdLGLqr5CoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPT9WjJbQr4gOd6zbZgiHpyib2BjuupsTjX0SEkgeLA=;
 b=DaisHbbRh6pEzRlwPdpCly2jGOMCN746OhzPPREmU8rB4JQgPqRS4wnd9yovPCReBjvcZwsOF+JpxQELJq56BXoga7CkzxWK0LvvJYH5lJg5D7dM2Sn+HZGxR4OwV/XK40Plwz2oY5bxr2fqsAEGoIGsWGjVTit6iAFRTsVprTS/0yOqt9ehNa3UyyLtw5xbaUHG9Sb1KT+dVqlEqsjTkgrM6IFPBR3cOc+iM3PmLDALF4Oir3E85Y+C8hL+j4kovuIgv1ptzYmzcgWoxglIjKpDvgF4u1A9yofI4jCMGEL6QmTH9vFIT8zdzU1dt931gtX2K5QNyhshtmAWziJS1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPT9WjJbQr4gOd6zbZgiHpyib2BjuupsTjX0SEkgeLA=;
 b=FlwhQ45PdG16KvbzhzTfDc8U3ZLXYZ2E1b2fl1kQo84PKjaqzBTU6I0Nd0tdbO/kXnT7zVfRoQgFkidpQfIDWefiKn5OvRXLyWj44FYPtVAIuOUpT3LVqxJhJ09tbRZPGnplz7zW9iBfSHrrFZWxPCurnyYI001gS9Orr8eAUdo=
Received: from OS3PR01MB7479.jpnprd01.prod.outlook.com (2603:1096:604:14d::9)
 by OS7PR01MB14986.jpnprd01.prod.outlook.com (2603:1096:604:39b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:59:17 +0000
Received: from OS3PR01MB7479.jpnprd01.prod.outlook.com
 ([fe80::1ddb:79b8:584:4fc]) by OS3PR01MB7479.jpnprd01.prod.outlook.com
 ([fe80::1ddb:79b8:584:4fc%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:59:17 +0000
From: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "clement.leger@bootlin.com" <clement.leger@bootlin.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Topic: [PATCH net v3] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
Thread-Index: AQHdSk3QskULaBVyuka57WHyJfzw9rbdQFdw
Date: Thu, 24 Sep 2026 08:59:16 +0000
Message-ID:
 <OS3PR01MB747905659EDBA4273A3485EFA4812@OS3PR01MB7479.jpnprd01.prod.outlook.com>
References: =?utf-8?q?=3CTYCPR01MB7481CE8351FDB2CDCA229955A4872=40TYCPR01MB7?=
 =?utf-8?q?481=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
 <179005258996.2160803.11359360903588205993@kernel.org>
In-Reply-To: <179005258996.2160803.11359360903588205993@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB7479:EE_|OS7PR01MB14986:EE_
x-ms-office365-filtering-correlation-id: be080c47-8757-4549-9e0c-08df1a1a1d1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 MHC18bjDuPhDjFwU2ijFbeCpEU7WigyHXJSXwl0h6AeHwYvoG2jjuQweN2wvcAjXb+kasmToAImySsu0m2Xk8G1Z9ud/d3vSyf++SHTkMV6SO+UbI2RlXUm5/Pa71rL77ENVxQo27vmE5dX1f87aT/zP9E8Vg5YMyo+imT5cW3ql7Vbm6/KQt3KDYMQFO3NGO5LUL/Is0nxloT1ASsMtsajXs0j9c7EsM7VdmaFMPNnHtF7u/r6wOveNJB+z6MXAtPqr/WPhvpzu1KacOnsu+BNSvOGBIE6JsPnr1MWGqN/hua7rqZ3ZChSkkOqs8k0zLY8X9gbnob+HlgrFUhF19psv4FwGuAHkWCQyZ0tPk6XMLSrpqL4N3Elpd0JY+5U+7gJZ435EE+6QVd0p+fSpYNruQPfxTWHhcrhx5W0ldyhPg9lhrDCeUdhUF2g+54P2qupWlQIudEnAdlNf0O2HVNEOp7KtuvjLDTdl/GZgaY0Sch6qCKPBVZK+OB39nd36QUS+zqq6GKk7ByIhMbGzW+eDx90kWBtYp2Lkg0k4WRA3mJ8sSnG7lztm8oEmLgoQ8R0u30uqgpceOI4KEOxoxhcLbCUiJtdUinsbMv5aBm+zJ0IawCAR+fIMuo2U59AXzk8QMz79Gesi3UvVpxSzoG5dGTuVs54tXremXhN174rsyNHUuOZP1aXkgjJlgU/qu6t0Yc+qqVzgpIVVqbgktdlbY8pG1+kT3ImZaUlGoXU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7479.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?reGEmNxgMv60UuFzr72682OojAJZj0MjteNXT1NmBSzjbUz03Uh6BQgFjCCT?=
 =?us-ascii?Q?Nxxj+9ew9ulSHlpEee/T28BQUK3MwBit8ti7m1l9GaMOyzGb0krwJPXLJ5e2?=
 =?us-ascii?Q?wU1L+qyjjR0KA5sQvfYWq6uTRu4BEbRGoS6k6VLqey56OwH1YBb93hQub1Xi?=
 =?us-ascii?Q?vLnQb6EaPa0oZnRnJBeXUOF8eXN9yev6Vsu7i6/uAcjZqkNQ1uUM+ywq0o/w?=
 =?us-ascii?Q?Ofmo51hdUVzWSETna64CdcqaX3/YYmmHbODivhIZn68+8G0iMeLtWC0R3eIY?=
 =?us-ascii?Q?ACBT15axgszS6vzL60cZbiOYVswuntVhmTu+byJGfWiiVj42UYD4lN1kh6LF?=
 =?us-ascii?Q?nBlrVYnmnXYSFZ/C5WhWmmh6GHoXcSgiymUvS8C38XYB2lkm08ncZk5ZkgsE?=
 =?us-ascii?Q?NAJZ80Y4rLudgLfhze7kj5+qxc1Bjf6EWK0KVVdO05iR9LlgnO4T7EDRQiXs?=
 =?us-ascii?Q?vaUeoIm0tg9a5G7FvuPQd9pS5b32xmt7q9065lZkbxufHgdTL3D2+4adFShV?=
 =?us-ascii?Q?RLD3jZ1AfpNj4Y4lpuwM5WPzXEdN0EaUFWOap1ogiNkAcFkw6LMnIEmjuTnz?=
 =?us-ascii?Q?fh/ofqgB+qxj3htIa6MN/xWJfrM+bUSdLRhJ1YbyNQL0GLwEGoJzUS28pgGA?=
 =?us-ascii?Q?gE3Fg7KWvfblU8gWDN2mN4zyHiiHnH6gdJy3MgOwe1Q7pKlXfAmyHd4LMjGf?=
 =?us-ascii?Q?aFUoBIvoIifyCD+9S4Yb1VUtE0eMuUJa0Ol/dNWbGmuW+JGtMtNtGsKlqnAG?=
 =?us-ascii?Q?+3ekZDrDd7HwOlTKtZrBe3w75BtZFJSH4BOXGkYKV5OFs7cT0nlKdlsLztTr?=
 =?us-ascii?Q?Mn4iNGv+ucUhQUmcHF6VpIcd7n7VoHFMuyK3zwE+iqqKbR3PeXodSz/2/Nx6?=
 =?us-ascii?Q?X0r12s31S+OWQ/hV/Dk/8HXmzSlgWbWkbxLw5BpCfuPxyl3rgy/L7CxJNmRn?=
 =?us-ascii?Q?SLVoeFxDfybhhd5uyK0aUXsoGZoqUsL+CfXtjHJuy0BJN8LO5sDw3WYDcbdv?=
 =?us-ascii?Q?M9lvEBEmelWLqYgPFJZB5RQ/6iBrSOwDQIrmYBAGZMwqIWA8AIVLLsMK1Czy?=
 =?us-ascii?Q?S00ldiSjFZALKhkSz1qDh1Vrp3U7mZCCt94Rf6uJ/8QGDjhfCPk2IknUOyC4?=
 =?us-ascii?Q?OxNl7vGxz7a6WbqDTA06Bj8ycFHTcjIr9d2EFKTVhnlhgTz3XAPFGXoe1+RB?=
 =?us-ascii?Q?LBZ7Yzx3TLgjubXYyN8U7RM8diznBZYSwMg6/8YEAf/hMvuYPXTJ531Yo3RX?=
 =?us-ascii?Q?lLKzYFu67YLmJ2w+5q3fbrk4PFf0l40ng/ZqPmzDSnoUDUaivHZOMGenXWmS?=
 =?us-ascii?Q?Ooh79Lpn6RKgSaDYEMN/tuR99+RanPd8lRsOzD0cYxcJeFiPdZYc7r88SruF?=
 =?us-ascii?Q?xZl4PO9zfffyY6yUrZgmu8eSOE2wHx6vj31b2Rijg8/GbwjPMTVopWuX6kkw?=
 =?us-ascii?Q?Wf0eauq9QziUHa+pkAr/mD/qGYpU/1wSsP0JTb9+C1H2259KNJq2WBmOR45T?=
 =?us-ascii?Q?355DQ609kUud6gLYaDwyUxQMkbL5XTHrL/0M1SrWiCczcIUGsez4tEmPuXNS?=
 =?us-ascii?Q?tzt86R105Oazt8nYhXjgKAXIX6no49YmvI/MKwxTU+2lFRyhHQdK9kELfsRD?=
 =?us-ascii?Q?RUlkPs+QNod86/ZUT37SmswO6Zvv/Rv0WyzLrVqefSLEqQmCEs6GhfRDHHj1?=
 =?us-ascii?Q?WGb4Zmfq62oFx4nKnRJ36qvyM9Fzijhy7ULymnH4EDL0LVo10uMgUQQSF+/y?=
 =?us-ascii?Q?RjuLS+jkHFlGOkAWlQgvQzc3oA4jZUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7479.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be080c47-8757-4549-9e0c-08df1a1a1d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 08:59:16.9510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hg25coy/bayM/tlVWh4oC8hmb2ZUk4A9qOmV/nG5sLWQSpMGTq7cOE3rAQfJRxDm6cKCAmtkOE4hFqqyhy7dR0vhcM6unIG92031XwupQJDYCLTgYsZ/CL6FzkOWCBRP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14986

Thank you for the review.

> - [Medium] Fixes-tag mis-attribution and a changelog that names no
> failure mode.

Even when the intended policy is to unlock register protection
only once during initialization, the initial MIIC protection
state cannot be assumed to be constant because it may be
influenced by prior firmware activity.

I'll update the commit message to clarify this point as well.

The same failure scenario can also occur on RZ/N1D, so the issue
is not limited to the RZ/T2H-specific additions.

I'll update the Fixes tag to point to the original implementation
commit (7dc54d3b8d91) in v4.
