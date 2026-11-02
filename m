Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793578909;
	b=NJyVELe67gSaGDO8ppZzk2NaYAF/zlqs7sllAjEn2gukGRfxWlRm0kodAqBJAdkwwhJA
	 zjBcTASpFPQ/ILTZXQAlWrfTbwZ351I9C1JWEIDGtfnyVs/QpbBeT5pOrh+Yn+LUiutUA
	 /pDx5fgV/v1kjf7Lswpi3iVrYR3Abh6aLDUEjuUCWMMookHlSauHBlivwZrvz+/7dCale
	 ecCcTXcrG6Kq6F0nY7GSqXUf5+cfWUZFwq+HM8xx/w9lbNQ2hs2NAPGM8x/ge24YF5tFl
	 bKiqSGjLR6G/VSQcwtW84+NyLjGCQFbY5SQXTLGnP/VvH8umXuDwjMAiTcUBjfd0Lrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578909;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=1qmVportw3C0HchCAeh6LvydW41BB3FMyNHb+HdgMBI=;
	b=bxUJbAsBcp/cJ1Csfn5ZcSOU4aW85GfAWR9RGwgCXLUMlMXLsLZZO6+XrJSU/x23jnZs
	 deQUnncMwXfF2dZYi104/fptNI6Hi0Fsgp+74/BENYqzd3nJiFVqOviZi9gXyefjR0DYR
	 TXvEO0W5j9+iunyVK8pO9/SwsYASy6UUmYL0LFlBMphp4TUFxtfSoOxkAd7VkkOXFPiKt
	 /4ZdRJSES+nVajfCcG7vtIaRaTvmbNKPRPtX5Sls+oIp40TIYOu5g7TxBR84orTXgZR4u
	 Y5cPyKnvofLNwCZuetQ0Hhk5Gpql1mbmFJkBNjDVbWTA8mrF8l46Kzo67+etxsDqmug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=ProStaking.onmicrosoft.com;
	spf=pass smtp.mailfrom=ProStaking.onmicrosoft.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.73
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020073.outbound.protection.outlook.com [52.101.201.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50336606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 00:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50336606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ProStaking.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ProStaking.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghFmanf+YNNzpk3SVkHnZV1zRiL8F+c25WlOI0GMkFxpZ6nSUWJ5uZcyS4jG6QuT6OXBCkygXt5Or/wBJpJRzO3f/iMGSdmP4iRbBPKeZ1t9Iij5Bz3pMtMiW71pe3n5NXvwsgmkvpCHHwvP28MIocShWU/CCyBBzkZtwkuIeWJcwQCOwwhzLngC38Off3w2zO7g7297DyT5SA1HcApcCXLOe6MNxboBdWqrNMhFlMkO5L1Gv6+IYOJKpb9/YVufD2c2oVw0Qk8vMcSLml53tVLFxys4jIceqDYF2x7SUdh/ANmTB1GHsMNKVZoC5M+scxOGNfZKPcW6w4e/95yGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qmVportw3C0HchCAeh6LvydW41BB3FMyNHb+HdgMBI=;
 b=mOqwuAEZsXTPf7mMLEfHYhx981YN0GtR187FbnYWYqJxZjgT18babT5f4brgq11aJsq9ti2KE5oDdwCsEokGUPxotx9GDsphNVK4TmEAOyy8DPnU0FNl7aGWONGhMgwDEf/Z/ih5+r2haTj+2VGtgCtmF6rf47IHc5dzARbEqFXDqCfArIDhyyr77NRpbLWLZMrwrs4tIXCBNrTggyOlqzS9amkSdpGXK3BDdHKVCBs+3Fut4zMBA+EJe1w5ufLmw0TQ3OgvwPCPJkKupBjQmhDLQFbraskj1Kp3bWwbwpl51fGMONLu9pcC4SXiD0sjsvt+ju6J0n9kfr1JVHdlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prostaking.onmicrosoft.com; dmarc=pass action=none
 header.from=prostaking.onmicrosoft.com; dkim=pass
 header.d=prostaking.onmicrosoft.com; arc=none
Received: from LV8PR16MB6422.namprd16.prod.outlook.com (2603:10b6:408:229::12)
 by EA2PR16MB6201.namprd16.prod.outlook.com (2603:10b6:303:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 00:21:46 +0000
Received: from LV8PR16MB6422.namprd16.prod.outlook.com
 ([fe80::1a6b:e6dc:5a5e:ad1e]) by LV8PR16MB6422.namprd16.prod.outlook.com
 ([fe80::1a6b:e6dc:5a5e:ad1e%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 00:21:45 +0000
From: Knox Hutchinson <KnoxHutchinson@ProStaking.onmicrosoft.com>
To: John Fastabend <john.fastabend@gmail.com>
CC: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [RFC] bnxt_en: BCM57416 P4 AF_XDP zero-copy results and upstream
 direction
Thread-Topic: [RFC] bnxt_en: BCM57416 P4 AF_XDP zero-copy results and upstream
 direction
Thread-Index: AQHdallq4MjLuC/lSkmUUzNNOx2S6bcZ5weAgAAEj44=
Date: Mon, 2 Nov 2026 00:21:45 +0000
Message-ID:
 <LV8PR16MB642276A0A161388ED3B2083FEB6A2@LV8PR16MB6422.namprd16.prod.outlook.com>
References:
 <LV8PR16MB6422A76A84B5F2E45AE86702EB6B2@LV8PR16MB6422.namprd16.prod.outlook.com>
 <tnulvp.3bw49b6y59iob@gmail.com>
In-Reply-To: <tnulvp.3bw49b6y59iob@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ProStaking.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR16MB6422:EE_|EA2PR16MB6201:EE_
x-ms-office365-filtering-correlation-id: dc0c7726-8c32-4feb-3fe4-08df38774759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|376014|18002099003|22082099003|38070700021|56012099006|4143699003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003|7055299009|10067099003|6133799003;
x-microsoft-antispam-message-info:
 Mydk4F7UJ/AzkZ7r+LyA6ZKaBqTMjgBpOtlzCHDz73Vc1cn1sMtoRHjT/UFLTPFIykZkLSaCFyi2UbF7l1NqQn6SEHyz8cHymOwwjdtCPStHWI+qJNHhdwxPuy+zH3UvlSS0Ota5rpdaMtfkgRjgoWqbV8p99+v5ZhpxYmVUK+exEtFVbUB4hKCJzwR0hyABcwQ/Q0i9mR0N25f08uIP+RuFV+LZ6PTO5tdWyFWz2eTAodaIn3UxY+B8JIc8zWBF7pltb/oI4zvv2P4wvaZI5/NFjbm3EdQqMIQjBtKETgVvGvEV5+uncx2X+o0qgAo53FV/S7r4q8zWuUGDDZ9HgmbuWHoeCesyBW1H08VsKq7Z/Fr72ytIWAllt3QMkeJboOSTGrGaxmd+xtLTZL1pqN2wBUzQRKzRUHFVQEnb4W5nJ6wfD/0bC2XVs6pgbunrFAoMOcKsSjLB+3RfF/6Th80iqWub0GaOT8gnOnC4ePTyLL/vqxaF6XQGVnmJTnyra7zlIUqpq/r2GcDFDPZMvlufAdC0DOvt+p/hij+kk+DyHk42nuPu2p65yBQ4U7vOFjQRPpZXaAVqhTmOM9uISMI7e6GP/Vp+QOmSlRgnrLatrYNmKHpsPThCCERNQSxdLt62ivJT244pYl9cLOlmEGoAydDaQZucPyVBLtdgaoRYe5wzfo4U9V1FZgvhJwVeE1SSR2tGhMR1Fn7DEvFjEXDD55w+7gfemHeDMwzeepHatlcUKo+MGw0Qq1P89MqG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR16MB6422.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(7055299009)(10067099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?wR7gcgl5wXvdpjN12d7oUn9NQGK+Eponksg53hpJ71Fdh15a2McxMDGB?=
 =?Windows-1252?Q?KAwh20EFGpYHA0dPCMkRRF6EmJr1LnVeet1T2uiT4gXRUm5sicwPoP+G?=
 =?Windows-1252?Q?Uq9NZwZQfCl8L7xPMEFGSHu9IuIebMn3fyzttWNpbyzFjzXQvE4Pvl8B?=
 =?Windows-1252?Q?8B9fjC50pfkH5r2934TB8mTnjpHP8x+K1N32wB669XUAlLWx4q7T6Faj?=
 =?Windows-1252?Q?Fgyj4tdAd5aqG14fc8sMBaxbSkAbCiMoxcdp2b5gqUhON/QmeEqErR7M?=
 =?Windows-1252?Q?pbsenKpmXBMg90c5yXqZ86z5vyiPAj7F72pvywopTngvufrRpD0kREjj?=
 =?Windows-1252?Q?otOaYUJae8/zrnZsbV2jTuau8Fl6y9KZKnj55SER4zpiuzBcyF5zaAZ4?=
 =?Windows-1252?Q?HQoxWBbBlCwg5Y0hpMNRuhaF28XpFHi499GF75o3IN0pShYowGZqu/MF?=
 =?Windows-1252?Q?uiV2dh/AtF/oW7qp3tGh1AwyE09CeSY1p9oXpnNTGfnXpZCvtUyH9F46?=
 =?Windows-1252?Q?fK0E2tjRxbq8TNmeO3nzKHPmAkD2gKoEWVVXJEemJVk2I/3a1AmYTq9G?=
 =?Windows-1252?Q?KONmH9BOf+9d6jCT1NejzXuS6rGIG8DtExd7YzPVkzX5dFzUnqBrv4It?=
 =?Windows-1252?Q?ysHYnr4BoT9ExgXV6Bq+ymZMyqgaOY/yCOTkfhRqMTkW8NvxgygGgPHc?=
 =?Windows-1252?Q?zBQtlzYyYvWxpU6R8dgFndTIHSGbYnzfTl/0GlzjlmrQnl7mZsNmvJaE?=
 =?Windows-1252?Q?hSnZETT+o2ULbp7hpAt4kDItrAA8oOtwlFrvfBouNac3MjzWY6wy2v1p?=
 =?Windows-1252?Q?7XuGnyOi/sQRl2c0LAxMnoTn70YUunyJueKIBXQWXZlYU3igBOCiYwyy?=
 =?Windows-1252?Q?Z+dFMoVSF47gRGq01rWfqkcxgtQt/O4xC5rRu4AzgvIn4KfaNDOZzqRk?=
 =?Windows-1252?Q?W7rM1Ex773juJBIJ97dyz59vs/foNl1Aq0YP00EtzyTyYo3nlM3hw9u0?=
 =?Windows-1252?Q?9HrRq567ohhnSV4laf8dTUNSvS7VHBgG6thw9UEZi6zBBSWjobv0H81V?=
 =?Windows-1252?Q?PGBCWdWhF37ldLsTFB6wnPz5Hj7nNAWxQaxSHfl6+0N7OHLeIyQA60Un?=
 =?Windows-1252?Q?qNXySkLsZLxG8qqASDNJbZP6hPUEDTxQ/Y88BTjK+tG7j3XqJTscXlaq?=
 =?Windows-1252?Q?BPbnxm0cK3n5mdTOeXk2Qr2LjoQo0C4vP0VIbg/mGvAGiurNuMJA027U?=
 =?Windows-1252?Q?lVB2zw9GIJjmve1aRLlRDAMpT/T8SNLdSpHbF7rYXsD6x4rfQ9e6nJpX?=
 =?Windows-1252?Q?gsBdVNg+GRk0LFk4VIONOtevQwdYuRp7YleF5k0CaGsxUFtB3E5PLH1p?=
 =?Windows-1252?Q?GmG+M9noCBbKhxfojY43SREhgcF+/4CmQLdtkO7lT8fnZifEHCQXCkRc?=
 =?Windows-1252?Q?bdrvdwaQ2X7/jFBxD9t9bJEQ5uXegzJ4085BpilhaEDNw9gRui3sZQL0?=
 =?Windows-1252?Q?on824Hwq8GusQpTYsOHy8QAir5aH7z5MJoEKBG66SqAou07z3s4SqNUh?=
 =?Windows-1252?Q?nfJlPsvbeDYNuIMLNSW1AJ3lWF4DXF++QvFVEYCKyoFHMAzL/tbY/96b?=
 =?Windows-1252?Q?/pKrDK8yoTz00H14OX5WhOOsRaCvckWo6FIobsLazVX9ktjaAGvNwZ6a?=
 =?Windows-1252?Q?/jfE3MJLczUumei0dqvkXMbTHPOjbfeyS/EP7nbmfv7fnxfck0bEWaAa?=
 =?Windows-1252?Q?68kAPhpzA/lc7FcGNYNemL6ImoHmAzg+AFnVCtFl9O++/Hs5DKo6IWB9?=
 =?Windows-1252?Q?ER7MTX6oBQ1Of0ODaWbzCVyRsbKimhlvcoUi2Vgo5HlsNNoevLDX1NXO?=
 =?Windows-1252?Q?D1yb6Unqb8uMSlgM8PX8U93+TBrT4LrhXv7NKaMRBHvz4KeAsGkaTr0W?=
 =?Windows-1252?Q?vKV3OYSm?=
x-ms-exchange-antispam-messagedata-1: 5Y1lxNj7JO6eag==
Content-Type: text/plain; charset="Windows-1252"
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
X-OriginatorOrg: ProStaking.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR16MB6422.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0c7726-8c32-4feb-3fe4-08df38774759
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 00:21:45.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 156e7209-39f0-4875-914e-ba7f08edda2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqPNMLKyXJtdfukH0z00e8mmPYf7o1qzLcfCKIXPfumD1cFXtvAytOXvIql8xNDJOv4+JeTdA8ZfIfhLfx5BuW4pPKyJI6yIrcH7uePUPyPWHChj/bClFSA754+tyG8QPfT26lqgN4fxWoMLsogtKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR16MB6201

John,=0A=
=0A=
Thanks. I should clarify that =93P4=94 means Broadcom=92s hardware generati=
on here, specifically BCM57416, not the P4 programming language.=0A=
=0A=
We made no changes to AF_XDP core. The changes are in the vendor bnxt_en dr=
iver and Firedancer userspace initialization, which publishes reserved FILL=
 buffers before bind. We tested 2 KiB UMEM frames on an EPYC 9254 server wi=
th Ubuntu kernel 6.8.0-138-generic, firmware 220.0.59.0/package 220.0.83.0,=
 and a driver derived from Broadcom 239.1.170.0.=0A=
=0A=
The workload was a real Solana testnet voting validator, not netperf or a c=
ontrolled traffic generator. We collected CPU, memory, network, disk and vo=
ting/replay counters every ten seconds for an hour. All 361 observations we=
re caught up, with no increases in monitored driver drop/error counters.=0A=
=0A=
Against the prior same-host baseline, validator system CPU went from 0.0851=
8 to 0.06705 core equivalents; total validator CPU went from 37.021 to 35.9=
69. RX traffic averaged roughly 23k packets/s. The layout also changed from=
 two network tiles to one, alongside kernel, driver and topology changes, s=
o we cannot attribute those differences solely to zero-copy.=0A=
=0A=
The source, configurations and measured results are here:=0A=
https://github.com/ProStaking/af-xdp/tree/627be0b7325501c8e24dce74f29746c42=
877ae88/bnxt-p4=0A=
=0A=
By resource lifetime, I meant DMA/buffer ownership through NIC reset or dev=
ice loss. Those exceptional paths remain unqualified. The measured hour als=
o predates the restart correction described in the first email.=0A=
=0A=
Understood on the in-tree driver. An upstream-native port and reviewable RF=
C patches are the next step; the current vendor-derived package is not that=
 submission.=0A=
=0A=
Knox=
