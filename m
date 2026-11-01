Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793576021;
	b=jIyFP1CEVjxtrpWQY5UAigMPXK4HQrjIf1oJT0kioFLiXAPpM/MStaTeEJlcFaz/YnY+
	 IFCLeH8Ad84yTC6AA3HwAuPsdOQQgIduS0Dn0qbjKeH7oP6Edv4+X7hLmFOP/N+TUgAHG
	 eEkgrTwEB9zojwDtZtDpuKZuZosFwOfV62qP6wgoKw0RYJ9zgxO3Q0w+2oKpTt7kRfu9t
	 dBt3bEIOwIbVk+c1ZJ6Xv94/DEvac04KC44CArx8C0Af5vELTMdjy3gl6X1ykZYJZtdYF
	 YLI1H74Ip0ufJxPYQT05i6mC/22miGB5S90zLJ69PSdQRqCzhvr39wCAdfbSoeWJL4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576021;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=DkICwKQH4zipvN/2k0hrm+3Z6EIzipERj/r0s4zE6XM=;
	b=FpA2xAigP8kP7RJ2tc2X1XdOIgsprgVKGIjSzcN10Zl6SIDmWhaLT8MTMQ0V7cp9cwjv
	 qIDAnMauEqNm4Ve3hRhiXv4UR3435yzRJMjiacweDzniAX2XpSMZGCMf0Wj+917nV66pp
	 V88q1LFpfYjip2FJ7oJHgwa4clIO3VlDw41N5XGsXWRwydiAWhNTAQTD9jplgwYNN3qVZ
	 prt1ipz7c2f5tgYR9VeUUpqC8jSfZQmleEchwx+gOrh3gNJUFhh38JdBsfwtC3BYPK+7A
	 5u/QZZ6DBmot6Lf/wXRej9J1vjWJVw8GC8IHhgewrlK50cSXPOAzD13zknlJCrBtIFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=ProStaking.onmicrosoft.com;
	spf=pass smtp.mailfrom=ProStaking.onmicrosoft.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.97
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022097.outbound.protection.outlook.com [40.107.209.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42654606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 23:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42654606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ProStaking.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ProStaking.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbDhGSC9rg6I3AX6UcwcHiAHl8faMFHnKAGlQc5mvRFWwHLlYEn9r9GUH63V2TO7Op+0TWztwm74tY4sdJwMJHyj2ywntAlbntPOnEIt3lfI4U8aW5UDhvMphPIBItgsw9ZVzzT/ovpOOfpEbMq+wreVKMu8SkVdlNrjra9vmjlkYK4kVjLxB9raJED0LVr74L/K8xTUD0obft+XjvWRMCW4szhdv+WZNLgb8JE+rMOiDiHnKd9TaDKbYNxxhEQR3mSwUcy+uI46ClDE01D3robtiD1qkRuCko0x+ayC6EUWweatb+XctEVO6zLRMVunWKC99dgOAiv+3h/JePt3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkICwKQH4zipvN/2k0hrm+3Z6EIzipERj/r0s4zE6XM=;
 b=M1qd1/Ak9dLOK2p6mm/tX9m4I3YtK8rVZ3zipdiNSGeI5H7LWkd1zw7lEfwcGFU4QgCgxKikyk0I2A1DxPvd4Q4DCi/UrspBpi4UkU99j359YCgmFuljAvmz1voOOdHIY9tn2LxM5AxjBcCQShlxstS4YOJvXYuk/CoIB+DKS9RUhJlPB9xUTol6H9AgT83J5TkpPFek1eMGjP18J3eKZBwT8yn1k+ty4iJj2/GMEFiORjBATEYmxAZCAdHAUud2bbOfq2dBCTD7Nj5qwZDquXkNaZiJmXRoHOkb5SoqdFVm/0XasDKX6z4Uxmzbgfs2t22dLHlqLwRee3AFU/d4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prostaking.onmicrosoft.com; dmarc=pass action=none
 header.from=prostaking.onmicrosoft.com; dkim=pass
 header.d=prostaking.onmicrosoft.com; arc=none
Received: from LV8PR16MB6422.namprd16.prod.outlook.com (2603:10b6:408:229::12)
 by PH7PR16MB5216.namprd16.prod.outlook.com (2603:10b6:510:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 23:33:36 +0000
Received: from LV8PR16MB6422.namprd16.prod.outlook.com
 ([fe80::1a6b:e6dc:5a5e:ad1e]) by LV8PR16MB6422.namprd16.prod.outlook.com
 ([fe80::1a6b:e6dc:5a5e:ad1e%4]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 23:33:35 +0000
From: Knox Hutchinson <KnoxHutchinson@ProStaking.onmicrosoft.com>
To: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [RFC] bnxt_en: BCM57416 P4 AF_XDP zero-copy results and upstream
 direction
Thread-Topic: [RFC] bnxt_en: BCM57416 P4 AF_XDP zero-copy results and upstream
 direction
Thread-Index: AQHdallq4MjLuC/lSkmUUzNNOx2S6Q==
Date: Sun, 1 Nov 2026 23:33:35 +0000
Message-ID:
 <LV8PR16MB6422A76A84B5F2E45AE86702EB6B2@LV8PR16MB6422.namprd16.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ProStaking.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR16MB6422:EE_|PH7PR16MB5216:EE_
x-ms-office365-filtering-correlation-id: 9e0d244a-5157-4dfe-a4d4-08df38708ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261021121427099003|261022105027099003|261022115727099003|261022075727099003|261009221227099003|261009223027099003|38070700021|261026121527099003|261026140227099003|261028144727099003|10067099003|56012099006|7055299009|18002099003|6133799003;
x-microsoft-antispam-message-info:
 coDeImHAoanh1GT+/VVOvcGNT3zClUExM4SnvlEg1iJZEvFk4zu7qPO4ZSg1iQHHwZQjI8Hp1A+tQNsfR9jWgsR5P+2gLgdg01gjeRP11quY2TZ0/gtxX8PV0d1jP+eo9s8D6X/radGu6MtNQ2u5jW6nEosct32NNwbAf4YSj1ZfVkeCNA5YlH74O7R3tphs0I9Cj/dbjLPOX+LKyoab53pXcGFMM8Ksmj4fVOUh1zfQl1TuFHkuH1S0Z12rQ5eNZm87gHShOIh4YnncCOsAKylkcGSykTlM4oTE+LiX4vDZJzejuJ/ke2qCd3h6/276JShLp2AqZo2bEKxyd74ywswFrKAJ6bIC6mXHgVElxN3E1gOsG57q8vhnMwNXPdirvt2nmqkvyif8G4XOiH7qBhbv0QP22MWSR/FwGxC0sbioiKRPtzW5p/+6BOlj800I0Fl2GIwOg5IZXsWXQjj7S/Zi7Bygv/GZZlAXC5fZ7leQfKUf3ovIDUg5s7t1Yb+oZo0IFfKIYMQjs01ijCZgu0fWqetfaTo5d5rTnx2/umAWbnjYsGZzqbaNA3cITc65gPBl7cmZCRqBaTWAglTm3MEDsrJ86/VVr+zlvUXNTi4cEIxfW4oB3LmSa6F2NqadSu7NVq6RmXIzv+LNVw/DuG1GVpoKoXl1nxrmRKF+EFQECQDSeR0BFPNWnsB3PkkrA9etyHZSqwMJ9hVWqEF2GA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR16MB6422.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261021121427099003)(261022105027099003)(261022115727099003)(261022075727099003)(261009221227099003)(261009223027099003)(38070700021)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(56012099006)(7055299009)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?l5aUNXFPEVWah6fioHeuyORU/YzSg0c0fyDH0TDChTxJofF2Zn7Tz/RW?=
 =?Windows-1252?Q?EPsmaq0E2ziVAdPvqURpG2zdjGfYHtrQCd/ohfjs+SD4JQ4OR0oEnTm7?=
 =?Windows-1252?Q?kROrstwfle5qm/sNILfF5hPCOyy7Gnw81N4JaMjSWUEu++BpH9816JKN?=
 =?Windows-1252?Q?bqZYvg0q8Aw/j4mTA3l0fJAfwipnMynkR1kMnDz2I1gAiidaRbKMlCQw?=
 =?Windows-1252?Q?ouua3Vn3xhqUwhcvvFdUFicEw9h3RWSQ8K8P0eDQrI8FSLgXCmzz0HWv?=
 =?Windows-1252?Q?KJWuZeeSBzg+TDN2/zGQy8rD3hLMlrRBOFYyjqlWkP1PSX9KhTJUSSlw?=
 =?Windows-1252?Q?xbgT5BRtikkuYVgTcfRx8ULZ/TkpO1qcsZWFuPCM0iJnTGeimLI6bULN?=
 =?Windows-1252?Q?g/SPhdiRHGlWQZiaSLAG/5G2l/JTuhUg9kzHFWb7XMOou8kRUY/nEhRD?=
 =?Windows-1252?Q?nmYcRCjhN1qtqevwDoC6nXOphS16NVQBM8vINMRQjYJmTutzOeuHJ7AB?=
 =?Windows-1252?Q?ZeTHak15sAdn2aLyAMQCki4Qu2dZ5OrW06YxjVJ/nZoSXuUlS1zNd1Mn?=
 =?Windows-1252?Q?zDJomfxogpOJt3MOVoNJ3pfuOC+LxdHnpE3Ixcn5SISClCatXies1t0S?=
 =?Windows-1252?Q?vl9GdQuctMFDkEhaBuwt+KSLMOyVT/NveXF3O9EGvoJUpMtbYk07ghUB?=
 =?Windows-1252?Q?nwDP9vhJrM8Qx0kUwpuBXlaqagfkmg7DGqF+a+ZQ/MCJp7P9rd+ue4YF?=
 =?Windows-1252?Q?rJpFWBMIQMEwbure41IkrfYAJ7QE25r40Y/4r8HNV2alXJmKAgf/DSUM?=
 =?Windows-1252?Q?DrXxIBSy7ofKEc8SprwxG5iIFiJ+YDUeJt14QX5GzFza7pgdFAreU2RT?=
 =?Windows-1252?Q?Nt5H8BZ/TAF+N2oUNwGRpR4md1U5BCCaZRPpWEn3s6VbuVM/VdmlUeYZ?=
 =?Windows-1252?Q?wcvE8nOZPFrVR02XNPNbdLYvYM/dg1KIUU6SxB5alhhmrLw5nZeW5d3L?=
 =?Windows-1252?Q?3ftxaPcLqnPBvPblDutNZU5RUkOswiwnkvu0ALhMJ1H5/+j7chwnkwOI?=
 =?Windows-1252?Q?LcmLE1I42qpmb5P8D0mKQiB3VX2Ter2HVVZO/mh2U9jy/ZfuqxE7GsIO?=
 =?Windows-1252?Q?1ZsO1wWmk31XCJFbQpSn1JbLR13PIhMb65nUpSH2W/NRtlDGBlQp37DY?=
 =?Windows-1252?Q?Z2VKvWYNM1uGvBRmv8/mZS+rO6bjqteEPv6AhnzVLDv+NbU+Rrj2wMYx?=
 =?Windows-1252?Q?7iqWxc8iffGJKiJaOCEHxy7Ggf3pkKMjZPySSW2H/psjMF0GBkQbls2p?=
 =?Windows-1252?Q?VjFMt50EuF0C7zdT3ZCpnqEKXjL1oVugNAYDeSIjbnG5C34VqH9ZiKZT?=
 =?Windows-1252?Q?tljnwgM8AC7qGVTVnnQtZjtfGF3cOLSjVz2+90UdzNo9CE8UsYhBMRct?=
 =?Windows-1252?Q?7InByFdf8Qk6zuVEjlnZjF/FAC/LgppYNRYY99YBOLwm2NEZLeS4NKYU?=
 =?Windows-1252?Q?MA+m0+wM1575vhHlqSoaao24HyZLSGHN/gwefOCjZrYOKoyoIFnOzZmn?=
 =?Windows-1252?Q?lQ0yjt1AMZTDKosypvd+VctAbi/zNNpTjERyvMhcMbY2buE9/L4qxYSH?=
 =?Windows-1252?Q?HGektjbtbdHIIfOwXwQheeQxINf59mbFUOTbZXFlOVE5Lza/AGzyFh9L?=
 =?Windows-1252?Q?wOLsy0CBE9pgxrvSmlNvGKMkGW0+gPIkEsvmspZ0gSsK2FB+Ndhp2XxJ?=
 =?Windows-1252?Q?ow6IZuvPEKt8cKFa4VjwKTwXu7DHYZepU7fNtmyGtDduyCV8Bjh5B8o0?=
 =?Windows-1252?Q?MdMzeGJoLLlRSQzSVYrZdtqJ/EwbKwEWnUVeblWYa7SXePHx9FFbBL33?=
 =?Windows-1252?Q?Uf51PEaUNHJvyFyfPUMYU01IPhPwTUn4cSIYJMdhVYRABDCvob28b3/h?=
 =?Windows-1252?Q?s/cIMdgQ?=
x-ms-exchange-antispam-messagedata-1: fBKh7xAT7EcE5g==
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0d244a-5157-4dfe-a4d4-08df38708ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2026 23:33:35.6209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 156e7209-39f0-4875-914e-ba7f08edda2e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foRP+XispCgflDh7fDuqNXDebR9cLG+Y6vkILNronlDf0Xr+E0/EhndoptM7YG1EHjDSHGtamGwlt3wFra/6YI+1L4PRE8nQM/7eCPzUv/+C43jrR4eTlBfd5z3872B0tEItBgLa1UpoKXvtNMC70Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5216

Michael, Pavan, and netdev,=0A=
=0A=
At ProStaking, we have been testing AF_XDP zero-copy with 2 KiB UMEM frames=
 on BCM57416 P4 hardware for Firedancer. We would like to contribute the wo=
rk and get your guidance on the right upstream approach.=0A=
=0A=
Our prototype derives from Broadcom=92s out-of-tree bnxt_en 239.1.170.0 sou=
rce, not current net-next. We tested PCI 14e4:16d8 revision 01, firmware 22=
0.0.59.0/package 220.0.83.0, and Ubuntu kernel 6.8.0-138-generic. A separat=
e Firedancer change publishes reserved FILL buffers before bind while prese=
rving disjoint buffer ownership.=0A=
=0A=
A one-hour Solana testnet voting run produced 361/361 caught-up observation=
s, median slot lag 2 and maximum 6, with no increases in monitored driver d=
rop/error counters.=0A=
=0A=
Later restarts exposed an ENOBUFS rejection in our candidate: the RX produc=
er had advanced to 525 before a post-open check compared it with ring size =
511. We corrected this by recording initial allocation success before packe=
t processing starts, while retaining partial-fill rejection. Three correcte=
d ordinary start/traffic/stop cycles passed.=0A=
=0A=
The measured hour used the earlier compile-time Firedancer opt-in. The late=
r corrected candidate uses the default-off runtime option net.xdp.experimen=
tal_prebind_fill; we have not repeated the hour on that combination. Boot-i=
mage payload is verified, but persistent-voter reboot and exceptional firmw=
are-reset/device-loss/DMA teardown remain unqualified.=0A=
=0A=
Source, patches, configurations, licensing and checkpoint-specific evidence=
:=0A=
https://github.com/ProStaking/af-xdp/tree/627be0b7325501c8e24dce74f29746c42=
877ae88/bnxt-p4=0A=
=0A=
Which upstream direction would you recommend for this 2 KiB use case? We sa=
w Bj=F6rn T=F6pel=92s October 2 page-pool memory-provider RFC mentioning bn=
xt with aligned 4 KiB chunks:=0A=
https://lore.kernel.org/netdev/20261002190018.696925-1-bjorn@kernel.org/=0A=
=0A=
We would welcome guidance on coordination and P4 resource-lifetime requirem=
ents. Our target net-next comparison and pending-series review remain incom=
plete. Generally applicable fixes would need independent verification on th=
at target, separate from feature enablement.=0A=
=0A=
Implementation, tests, review and this report used substantial AI assistanc=
e. This is an engineering-results/design RFC, not a merge-ready patch or pr=
oduction-support claim.=0A=
=0A=
Knox Hutchinson=0A=
ProStaking=
