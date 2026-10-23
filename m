Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792781799;
	b=T4DYi1BtaEckSdyzoN7RUKVDw0etZpdhJWJOzf2iqkzGjCBMg8ngE7hdfuj6TZCPwhbD
	 m81Tz5taajijM98Sm0M9Dre2l3zWVmQmY1ZHcuJW9wDyeSRoT9iAob1syq9bExBIq9X2v
	 2msI86hBvoA+3mxvJtv2Z2G4zsxP50I+JMYqFXACez1QImaU+mYlmRyYkjP5NaLFIlnpt
	 OYW1uwMHzyCxie6hlXkFkTaDw0bNVOtDOsWH3+mlAKC2yZtPmVD+4P/jQfjmpHOee24KK
	 j3/amKofKCZH1ZJ8gvf58l01N9CrUGyNmEaVWNn3U0Otw/AjqJQgiGYdi0sNYDyZ0FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781799;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9ogP4GVp6egTpx8YBJpTfm8UGxEIVrHYqFqcxMgzzCQ=;
	b=K+Eg9FWh172Vm5Pnp4XCEe1GdiJdnid7uNIvQbmD9SlbfJOaL/UmIpqhAp6QJPwdsEib
	 gGLyiYcauOUXnn3ZAcoau/xvv66iPy6evFeQ8nY8zIb37g7F/A4ErezVKqVbnI79si32V
	 9l0VpBWPUfDuEymF7UAVX7DwaxG8nAPpFnbD38VXVDOL4LEZkdM3HkRtDeYvC+CS/aDDr
	 SG/g2tWkUTzUILBsHYJhSKKaR5eEWtMGcnp6ZI1e1d/jOqJXPLXLIWjqw+YAyUjUat6IE
	 tWrR3s285PQGk31oJx2z6tiaN9pvH2q+RD1xozZgd5qfSObp5G0p9HEo9ViHGnFuJ2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b="tn/pdiyk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.71
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D1606A31A;
	Fri, 23 Oct 2026 18:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B29D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=tn/pdiyk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoUvTtXoREtgiBV2Izq5mSx1snxyplH02mMiEe41ygqYLou8nwMWxxD/PbATwaecqJFuD+ERynTciiY9tALBEKkklNaYbImpIj2x8g3eHzVbdNeKT3sd6omkYmklBr5dnOW0kykGghQNHEavO4iSyAaPjTAcRdBYtpyIaIqcbns9HekRn185U/KxePSAEBPobFSdp7yzXvV0lU4Axcdk89Lkfn+I9c7ZfccUdtApx23rFfb4JQvtysPdY2Ye9DnL6sDoVW41bERCjdPmNmsgfo9B28IYaBfIudS77Oojk3d2fjrJgAahayhZbPlYDQRsNXxZYSab3Fo9ux+TGfSmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ogP4GVp6egTpx8YBJpTfm8UGxEIVrHYqFqcxMgzzCQ=;
 b=NY8ToY3KPc8yX47H0GLtiE2SweLHddlw/M6UcTxc9Xt/PbcdI04pagj5SkHrtVzQq+48sfFHC59kwu04qx43NFWaw189I1UAwjEW1X9W8vBtJSonrheaHXW+v7nTIzBgfc0i5aXJ49h/2pohk8bXg+oZt0k56LREisSlKdtUXfh+c4+T3rUnX1jyN/P55RKCmfEXpsS9b1DOm8W5ITT2V7AyN7arYUpHx03dh/h2jrUL18oK/XFUOOOTB5yU1IJJSkDhczAHjbPqCKLx9C3tx0xVEuJD0HQ+GkgNQuOU8XvFyp7YsTGQOsgVPnqiEXBCt8ZX7eAWtUe++ZChd8DwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ogP4GVp6egTpx8YBJpTfm8UGxEIVrHYqFqcxMgzzCQ=;
 b=tn/pdiykvG6MPGSIbmbCXVRQIdefjk6p3m1rKc3kKoSNw7fIlnXklYgtT3uB0VgMig/LbSkOpWsNH1rqypg7kYjFpc1B5Wpvrh6n+HOSVK/CLJpwzr4ZSU8eI0A3mIRlQy8bcwIxMjSSYcDzEsNkhxwWHPVJ321Hj1Xey0hm9P8NPdBoeaF8q4pzXdxYpXR4/9uRMJep297tKzEexgA/Al16BaDrjY8PNm3BHZgIuVEtYqo496Pgjo2qHYPNYCR4L7yeY4a1RLdRPuO26pJ8HI0BZFZNhgLuMddxNv9uNYQ4MVyNPCK9a3YZ4zuWCrE+efsxw8+vApm0dQyxcaOcfw==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 18:56:34 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 18:56:34 +0000
From: <Woojung.Huh@microchip.com>
To: <nb@tipi-net.de>, <cbabroski@nvidia.com>
CC: <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<Raju.Lakkaraju@microchip.com>, <davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Topic: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Index: AQHdXLZWKGSR1g1QR0aAGQorZSFDpLcIciIAgAGTgFCAAX2UYA==
Date: Fri, 23 Oct 2026 18:56:34 +0000
Message-ID:
 <BN7PR11MB283662722179019676EFA167E7642@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
 <ad9ebf0ebbb05424676b3d80b935f58c@tipi-net.de>
 <BN7PR11MB28366F837E956013E2C312FFE7652@BN7PR11MB2836.namprd11.prod.outlook.com>
In-Reply-To:
 <BN7PR11MB28366F837E956013E2C312FFE7652@BN7PR11MB2836.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|BL1PR11MB5269:EE_
x-ms-office365-filtering-correlation-id: a4a9eb72-c6c7-4cf6-6dc3-08df31375c03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|4143699003|11063799006|56012099006|261021123027099003|261009223027099003|261021135927099003|261022075727099003|261022105027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 5kYLOm5FBWp+CfUVyVJvvpSYhbk78x1ynoYGf/QNLO9ZM5X6Iyy0Uf/3ivC963TnhROqD9wE1rG9n/Lf5/L7fdyYLRDMNExk/QDhQWY4DZXdBc4hojmlbffwSwK0+yi05Nief+2uhb9iAp8p9wbRtrbij0uH4zsUUOfEUI/v4VskGD4rFSbNwyFMVDWn8Hi9wt+KHuF3QuNYcmHR4/z3PFqvdGqu5RhaUKwMo5otA9sMR3EMNENM0ybzWL1kkK3IwnGUSjMpqMo563JNDa61hfqyyokV6YKfyoyTN+u1mZ8hw9DPA0PR8FiKN4lwHwNSGHOaxmI2dBMXI+rhFsDthEkJ4BOaYjeeA+cgj5795Eb331IcXNpNrXqzHaA0URrvEsfP/jG1tKB5EoZIECao2h8F396hIvf7XFVatr/GrPYs1JuM6BWbqWOlDk6Rt5ydhyQ4WreRF+Z9RG4SUuDCUtOYbtkGbsm+kGwizlsmeZuQe17tgoqoBYZnLGW9z6qIrS465WA0TrodwhEzPbWgEEcc/P2JaHL2Z2lr50Lx15V6y8jl6vUv8eDge67g2U8vMPF9J5mpwgkR3f//psPXS9BF0qK6IXOx2yuJQ4RBILCIUnVgqbF1pbULxKXQnOR3A9m86HErX/of6GlDRGivB/27OVQSnOytYaV2wTK7tleYnwd6WJPczmof72No9ZL5fg0YtIsTanYDNsvVVL7G0I0JWFJ6NnEiupb1cZB0MA4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261021135927099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?91/JLlhtwCkR8StoFbu4DJIZ/9OLvug+aGK8Fpj4h3W+R4sAP0kiTKXy5FmN?=
 =?us-ascii?Q?29Xn9SDf+IU1Ibn4yKHz9BWdGgpj9I7oxYcyGL8bdzQvqf5sR2Rnop7WPHdp?=
 =?us-ascii?Q?k7EonD5u45Dqq5hSZco1RTXU0ity8xhYR7Hx7J2UlDi76FElLkT50dJ83Q7U?=
 =?us-ascii?Q?B0IBhN2NLeIs4wQvOApcM/N130cp9J2P/fduTuFIN+3qbP/foLbLI9WsjYU4?=
 =?us-ascii?Q?JozKEsTVDJfJdrxCC15cofbkGiN2TeQQmRNiAMM9MyVkmYwgAmcgcyMKAJeb?=
 =?us-ascii?Q?3bAHPP2XFqYgYs1Fn8ddOvaiDQ/MgxGaq/K+O2ndM3lQRRKRxCnki4NyQp8P?=
 =?us-ascii?Q?3nOxIMPtpJXfh4M+O6LkxMAROzvK1QJkPK8FIMWzvyLbE00L0GLPPIgdYU1j?=
 =?us-ascii?Q?ZnMpV+zJ98frpWVWnly4XvLJENIty6pR7TNqOtRlvHwwxwSHsTdDNcRvEhlK?=
 =?us-ascii?Q?8aWE8fX3BoHArob7CXJwK15i76qjWRrqq6TLH/2nc/fKRCC8797Yj+4Al61z?=
 =?us-ascii?Q?Vl3L9zvsQdaeiZz1nzscgLQfChsWB+2RVh5s/TwsLnII/3vCWGZTzTNCjQDy?=
 =?us-ascii?Q?SrYKcENqX18bIu5KGkkH3Cakg97pNRNfpBKLvKU4aeA8mWE0kCIG9uTlD52D?=
 =?us-ascii?Q?ocptiap5KSZDK9EWMKUVvRgEUG+ZjGJWRgoAREarhWX4tf3bIpLffDeLAX4I?=
 =?us-ascii?Q?JXJsK11FD6FBLmJuwnpzPy4HpKa2op5OHbIUSL//k6Rrwu2yVrqYhy+EZCJq?=
 =?us-ascii?Q?sz0DkQtviRxMWhO1sZkjpINuQO8gl2RaFD1EkW+syHlHnQKk1mLxukfjBgBk?=
 =?us-ascii?Q?iFfNJ5MJoqTvy78LMVuELECxOYb7VHQMccbSznSQYP/Td5KlHSzkuG4oPcJw?=
 =?us-ascii?Q?SMz22MKbPRDq5EZ+n7lzeFwP+DRu9YnFIq3tvEKqUheSpQxIMm7G0L5C9aY8?=
 =?us-ascii?Q?nIiLSfHhaguAp/mNSLwtKtB6FZMuAVxwzlRP+HslIt27+bvsD3QLNcbMw8Gi?=
 =?us-ascii?Q?07thk0VyW3QlbUSdke4QpDEC9hlvf9GMUIOfXotl1nn09tCI39xL+IUuOxTy?=
 =?us-ascii?Q?1joNN8OXSpxEvfX9KweSfl967I9WMUNX/8C9N5tP0ayCVoQu8366uIyGojcn?=
 =?us-ascii?Q?8oYHaaDT4SXrPVAXFbzo114PLBcxzgJed2NaOvK6IaU5W7dSq77xt4Yp2XoE?=
 =?us-ascii?Q?N6nxb3h8src/LXGniwknkciPUmIHWA9HDuCNRWu964wS5A2kRj8O99Z/NOEr?=
 =?us-ascii?Q?xS3Mb4RhzxHjtfxmCHnFbFtwNIZO5VQD+I2saIQqO2QEoxmgFigym7sfMsa9?=
 =?us-ascii?Q?vOIhuTfHzi5FwlQmAsbZuTE+3tBrj7uNd+bJ+IMiuZVYLEZ4/1YdMynia62T?=
 =?us-ascii?Q?TeegemvtxPFxKCh39m/TdAS2/ezVk5D00YHKB7YQNDW+zZb+BSnCOEW5k+5M?=
 =?us-ascii?Q?NtENtpwTa+sCJwUzMzXAbC4pIUVVv1gHK/6nAJDvPi3v6KHU/z1VUygYMLJg?=
 =?us-ascii?Q?WaW3zyVKNyoNnaJJ1LiHV5K6g2Pz1OKywKg8DrzAtSIQf1uQ9GTTmhp8wYzD?=
 =?us-ascii?Q?eHYpZfDDwY5mdq+fIBBn3qfBJ73vbSaD5W30XD0yVn+jhyVkszPq/xAu7KuV?=
 =?us-ascii?Q?BCdPLRHsveebj1FT4jz/yCrqlxppKbvy6n9Vma/mOUPEr1+D4Xb9gv4APsP5?=
 =?us-ascii?Q?lG8pmCM72SA5jaOVO7sVn9BlUPV3Z/Ame5/o61qfN6/TSrStW8otsKttQh1L?=
 =?us-ascii?Q?7vrQzk4y4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a9eb72-c6c7-4cf6-6dc3-08df31375c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 18:56:34.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mN2HglIH3Uf6TJljwCkxCMv/+TPu0t7U4QvLf70QD6SeR+DIlLl07M1gr/fvIeEXbfx1ltxxpOs2x9ZZnmEWN/l/rSsu+r4qUTFXfhs0ITM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269

Hi Nicolai & Chris,

> > > lan743x_tx_close() and lan743x_rx_close() ask the DMA controller to
> > > stop
> > > the channel and wait for it, but ignore the result. If the channel is
> > > still stop-pending when the wait gives up, the descriptor ring, the
> > > head
> > > write-back buffer and the packet buffers are unmapped and freed while
> > > the channel may still be fetching from or writing to them.
> > >
> > > A TX channel has been seen to stop making progress, with its head ind=
ex
> > > no longer advancing while DMAC_CMD still reports it as started. A
> > > channel in that state may not honour the stop request either, and
> > > closing the interface would then free memory the engine can still
> > > access.
> > >
> > > If the channel is still stop-pending after the wait, or still reads a=
s
> > > started, issue a channel soft reset and wait for it before anything i=
s
> > > freed, and log when that happens.
> > >
> > > Use the same helpers for the channel resets that lan743x_tx_open() an=
d
> > > lan743x_rx_open() already open-code, and log there too if the reset
> > > times out.
> > >
> > > Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x
> > > driver")
> > > Assisted-by: LLM
> > > Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> > > ---
> > >  drivers/net/ethernet/microchip/lan743x_main.c | 64 +++++++++++++++--=
--
> > >  1 file changed, 52 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > > b/drivers/net/ethernet/microchip/lan743x_main.c
> > > index 82d3ec20ba25..9e1276cf313c 100644
> > > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> >
> > > [...]
> >
> > > @@ -2221,11 +2239,22 @@ static int lan743x_tx_ring_init(struct
> > > lan743x_tx *tx)
> > >  static void lan743x_tx_close(struct lan743x_tx *tx)
> > >  {
> > >       struct lan743x_adapter *adapter =3D tx->adapter;
> > > +     int ret;
> > >
> > >       lan743x_csr_write(adapter,
> > >                         DMAC_CMD,
> > >                         DMAC_CMD_STOP_T_(tx->channel_number));
> > > -     lan743x_dmac_tx_wait_till_stopped(adapter, tx->channel_number);
> > > +     ret =3D lan743x_dmac_tx_wait_till_stopped(adapter, tx-
> >channel_number);
> > > +     if (ret < 0 || ret =3D=3D DMAC_CHANNEL_STATE_STARTED) {
> > > +             netdev_warn(adapter->netdev,
> > > +                         "TX channel %d failed to stop, resetting it=
\n",
> > > +                         tx->channel_number);
> > > +             ret =3D lan743x_dmac_tx_reset(adapter, tx->channel_numb=
er);
> > > +             if (ret)
> > > +                     netdev_err(adapter->netdev,
> > > +                                "TX channel %d reset timed out\n",
> > > +                                tx->channel_number);
> > > +     }
> >
> > While looking something up in the registers for the other thread I
> > stumbled over this in AN2948 about TX_SWR_x:
> >
> > "This is an immediate reset and will cause any, in process, PCIe reques=
t
> > to [be] aborted. This may likely result in a corrupt PCIe packet."
> >
> > A channel that did not stop is the one case where a request is still in
> > flight, so this resets right when the datasheet says not to. Is there a
> > sanctioned way to recover a channel that ignores STOP_T?
> >
> > Woojung, maybe you can say?
> >
>=20
> Understood your question.
>=20
> Talking to hardware engineer whether there is a way beside hitting TX_SWR=
_x
> in this situation. Will update when getting answered.
>=20

Recommended way of setting TX_SWR_x is after stopping and flushing FCT to a=
void
in-flight frames during TX DMA reset.

lan743x_dmac_tx_reset() is already called lan743x_tx_open() with proper=20
sequence of initializing FCT at lan743x_netdev_open().

lan743x_reset_work() in the patch 4/5 is doing lan743x_netdev_close(), ... =
and
lan743x_netdev_open(), I think no additional lan743x_dmac_tx_reset() may be
needed at failure of lan743x_dmac_tx_wait_till_stopped() in lan743x_tx_clos=
e().

Hi Chris,
Did you see calling lan743x_dmac_tx_reset() at lan743x_tx_close() is a nece=
ssary step
in addition to lan743x_dmac_tx_reset() at lan743x_tx_open() when lockup hap=
pened?

Best regards,
Woojung
