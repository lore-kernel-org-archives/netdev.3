Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739F44AB60;
	Mon, 12 Oct 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791108; cv=fail; b=hlnMkzKRvYv9+wJlpIuypW0l5z5zm163KHjzekk4sjw5xz9KOdYza8BYhnMchrL4JCC2kp5abutJPWwRO5gOA+tyGj8mx4NGmFnVT0cap00/X8ZjMOIKvyK5FhvXRMEqHWy5gp9E5xJogv1VgvRBKdLqfNGPIrv4nw4/pw4J+ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791108; c=relaxed/simple;
	bh=1ihIOvmTG4yDOEiPv7K2lRqoUuuVUsItFTSF+NNW8Y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIoBwz+0OvFVoo7zNQfWYzAqo9gfXacyMwtWHp5olqywCNgeS/nAme/loNRKITPl3boZm5PNb9dMk0L++VK4Vx0ZWpQiwam6i0Y8oAWrwbqi+gvaBeQw3Nu1N1FUlt857H0RJLkuPmyzSyWNsM8NNswVJt60xA/RH8L7arkF2MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C5htsCSk; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C5htsCSk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV9DMzgrhw0B7ymxrejdF7ld3VZWVANvllfO+2Y2vZoEQGN0g0QkMnff+XIBeA8g1VJik9jWOFkZaGmJyGSPBa8ylZDKVDKFAbRoVwJHNBHFLVvbhZhh+qCs/DpZyr2WbreVt2mV7wDY/TPyDgTd8BQqhPfuVeqMdiTUXD+f9vMupsx99/b3NiBDxg4c0f+u1mmHGhlN0aAN9tY4H6LElpDl9Yi37pDJDQhT/oesc6yjpasbdO2ZXcl0dNNfjd2lMQkQ8LdJv8L/tJcckmZ+OwiFgkn3b1xFfhi8/sjizmukErnasnwHrzw3lsdMlgMpXsOO4M/Pwqjo9qFX9d9Cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ihIOvmTG4yDOEiPv7K2lRqoUuuVUsItFTSF+NNW8Y4=;
 b=mOPqq9a+j7q3dcQ/O96i5KWI6jy+zUnBhYjScgZ8EZuVnDwZNk+6f/kzeYzcO30xgX2WqKV2guj3Yj0oBIBR8poxdXDhCV0IdG45j5x8b1kwubPNOmarF6+g54FTn1tp85AWHkcCvuu/E+HKdu6Niyr+Dl8aUTsGK8N1rvF+s6jAEUJxwfamNiujrh12inIqvr42eRR/IM0KnrSoxWsP21lzYyIxKv6SN70gxKZfEeVmgBjyUoMfC+I6g+1M10bTY6gj0zb07OuOmT34t0gd9P7AS93Ghbd4q2UqXqJ6ifsYu/Z8Q+zhYTic54mvjoMPJmTiYl5qvcwVgN1ZcL2ZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ihIOvmTG4yDOEiPv7K2lRqoUuuVUsItFTSF+NNW8Y4=;
 b=C5htsCSkm9CduTDRWZ0wsP4g4waPVUquoGiNtf6h0LiHZavjPXjBE2bkJ/IFzXLc0lOn/yQhAhZr1NiwpFJ5c8NOmatOI6j+G4BI3orE72i4W4pTtd1R4mkNI+jce0bLbACyxo9kPDgxDf1TGF4eDQvNC/HAiBITwN7R6Qkg79mp6FQYocXy/7gqCeKO/4SC8AjzIEHBA5xoGwgQQL6Xxb+Zl7tEPiDggkJPlpAPmFWy2We1KAB2bD9qihpEMad6H0TDjJ3pKzcDprC/9eWQu6ZJIp3sMkvwIhVxN85v1EXTTB8og2saFRmPuTrLc0OYYAhtilQLwtbue4h3/L4yNQ==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by AM9PR04MB8571.eurprd04.prod.outlook.com
 (2603:10a6:20b:436::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 07:45:03 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 07:45:03 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: dl-S32 <S32@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v1 2/5] net: enetc: Enable probing of version 4.4
 devices
Thread-Topic: [PATCH net-next v1 2/5] net: enetc: Enable probing of version
 4.4 devices
Thread-Index: AQHdV+toM4heoR/OyUSjS2DByV80E7b2BsQAgAOD1pA=
Date: Mon, 12 Oct 2026 07:45:03 +0000
Message-ID:
 <GV2PR04MB11740B17401171A7F3876B6E0969F2@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
 <701f38d08f9ea371877645223e6ac919af7870b5.1791548316.git.claudiu.manoil@nxp.com>
 <AS4PR04MB9338CC6990BCB8781706AAD088912@AS4PR04MB9338.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS4PR04MB9338CC6990BCB8781706AAD088912@AS4PR04MB9338.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|AM9PR04MB8571:EE_
x-ms-office365-filtering-correlation-id: 74b89a5a-22f6-4c22-4979-08df2834ba20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 j4+IMvWTR0y0hkiIc1dPhqa1ooVYXCZphRHha9Eh/6keMuzKWVDJBIa+X8fMFu/Bb13Iu9kAI0OmgKMDm+mlq4QjW0IanRoLV1p4d1VncsMuOVBYHdFuLPX6wvqmtLPJ80XwpeCC1h0Fe+e9OOtHGf5fuZCkvv954rqVar0UtzcdGRGcafZky6gLYQq5Svyf9CL28ZBYUvKuEY3+Fwr4Qc9455lGeDlf/6HN0G+ZtIT06lHn/XcsaJKuu/XWqtmPOskbFqszdDJ42A1aWx7DsHZ7kgXWpBFpr/+5VfZjSlo0RUl250PEWwWTgRhsOnVRj9eiZBbUqYBmWth9X5rEZEONwogaPReFCuXYF4enPHTF4oxkUvC+rvaI6iCHkCO2Bq8u2YvrGX0ck+AYTZ69JTHdFJoh0cyhhvn0FiWCEC7Jt5UcLYsp+xpBJcSCbYNlUqlq1188AeZ0Vj8JNNuKdZ+c9ZO9+sk4drM8RYpmrEEuT2TkMmo6u2mTB17fpr+FxXZ2MFP1erySy32iZs/hUCULtQM2G4EO0ZkSS3/pZU+50fJ9kLr7AmHYp/LjEOlv30U32VXxviOSYOoI8/AHa3yOfTvIbiSMRP9TMX3RR4rO2v+MMk5pv29MPP068Iy2+/y/jrPLHx0K9qneZZ5FUDHHQqZXk+f2pHDjhTH94YZkGfg6RQH5xu7KuoS9sJZXwBbJCghD5tdoVDpg2t1JDZcSiR9xM5AqYai3zlgnySY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?k+RBLv4eYxxcYWKRGXqV8ohx7blgfGl5Od+druE3SW6Jl6GdMeq25XRcflSV?=
 =?us-ascii?Q?eUyfwWtqlDzhkwWk7w/q8oQLBQzPlCsNzwq8I30d0sRWTSxpSLxxQokxUVEI?=
 =?us-ascii?Q?ZwQh21JVV5PNHwz0UQp4eWYzK3p/FPGsBEGR+/cmAkGh//YgyzUiok9xMWqW?=
 =?us-ascii?Q?5/+ZgeX4tvemAIDZbOm41DL2yaMRmHiW21ShLeXYNcezKB38IiDhqktaOgZT?=
 =?us-ascii?Q?ftCFQvJBQqTRTqmsJGLuYCyrUXUi+jmDFdFCDKFpT+HF3EgbblxD9Qn2NR0D?=
 =?us-ascii?Q?kWyHuDjdYNDUFSFj4DSsPITsAivcLBqk73BjbfwNzfYrKrA7BN5FkTqMkQW4?=
 =?us-ascii?Q?c/LwKta8+VyhwNgsy+DDHT76/L/K+DHbzpKCuoXuHCZoYq+JsTNtcTweudkU?=
 =?us-ascii?Q?vg1BglfJYNdanfXj8/Ls/AVaK+v6SGQxyVvd5sJmrN0oeqgXXFfWiLuB4Iun?=
 =?us-ascii?Q?E8mHiuYFoG7d95Vz7H1/L/9HSFd89aZks4cfYrFrEwOcFiXz0y0liqWv/T8J?=
 =?us-ascii?Q?KKBoJn83vgo8YYENAec9mN1H3qDXg3nyUbv26Q2/ICcdEf//B4JvdHwsYugy?=
 =?us-ascii?Q?if1pAwE/REYpnNEbWqAbQbMxHE7/TKD7yNnKjmK+05yK5ChfEDukRJ+/2kzR?=
 =?us-ascii?Q?vOrq2txwEQPdOcpuH7oEsH4icIZR9tx7aLBRZ7r8VINZ/A4SJ4kv2PR5lSrP?=
 =?us-ascii?Q?znXCM4GqOWV4X37afiUK375zrWegWzGiC1t9BSIOx01Mcx5DjInVW4QERz7d?=
 =?us-ascii?Q?MEyy8SW3UVt/s9ar0r+9ZRanznxTsqAenYzTVDKC84MpgNbFFzZHCWhBoJRD?=
 =?us-ascii?Q?vwu/+krGisXgctPTzv9NoLPizRqDHgOq4lhwoRCFKEAYtjOW/zEXB+S+VbNa?=
 =?us-ascii?Q?F9WWF0cDhnSGf1h0WLKy8UjUYUY9vTGXs0D/kzG4Sg9YxEsiiArtVHRHapRe?=
 =?us-ascii?Q?LOJYwPptbDXvOg9GADsZWqnYlsJdOfEa8dB03aGOmsBdz88dCpSlqsDPn11f?=
 =?us-ascii?Q?hN+OpFrg+dmEaj0Cy06a8PLqWEghTsLELIPywx50k0bSh34oKNPqJnCE8SJK?=
 =?us-ascii?Q?fz1QhLKIMqi+qmfjY2DzK1WeU1BC+UcdaraI5Py8QmRKznWxnwRLGXMLPesU?=
 =?us-ascii?Q?li+nLume0tKAB3INhHbHKkiHZpiNhJZF6NZYRpwdJT9NB8DbACgr/uAf/L+A?=
 =?us-ascii?Q?X7GfSmlKFYhvhDMty/a661pgQyfzxnaDz5O9ncSbLVGOeMAOBudn9d19QHc5?=
 =?us-ascii?Q?N1EERLhpJCme3ptbMrOK0GRta/URpm7oIEIW5UkKL7Gmj6f+HmNqZwlkOX45?=
 =?us-ascii?Q?GuHiauGSnxzGhzfLTjSNg80m0gTIGxu1AFjFKKme6QB01G/ErqKTayh5Rqc/?=
 =?us-ascii?Q?mEL4wnZz+lriyCS6X95Fw400SYRE8ljTQ639gs9EUYgIOTBXuxQ6gkuYFbWM?=
 =?us-ascii?Q?3fN/uD6z1CdWsd+CSnKhU1K9+gywMSCXzEI+h8T2rLpSVXU9a75TkPod52vR?=
 =?us-ascii?Q?/vqMDR6mRvuUvWwchaPXhmj+3VfNjgNyJ4b1ZCX/XjA8GM1W6+df/wXijzGL?=
 =?us-ascii?Q?KQtZgPDhfX+iiO9rpbLaZIb5pIi3HyWiSDEfKq+HKx/wYbQ5g3CYsve8eUWs?=
 =?us-ascii?Q?BXfpu5NZH3Txai/8EVeyfAZwOWwzD6DU0HDWXTzLaIkNGN3zb5i0523Ms4t4?=
 =?us-ascii?Q?K9k0UTFNDOLr4kqyKlbgxDsmIbJeuz/yuB/LMliU+mxIeePhDEz1XS+f1vbL?=
 =?us-ascii?Q?KCKqLzX5gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b89a5a-22f6-4c22-4979-08df2834ba20
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 07:45:03.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuz8h6yAhPZCg7KOz4PRfcZw23UL9Nf+vkAcTnk7YlE0s8O8xYqw8MlKp+U7dpqwE4+vaHbr0pmbi35Zqdzhiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8571

From: Wei Fang <wei.fang@nxp.com>
Sent: Saturday, October 10, 2026 5:02 AM
[...]
> Subject: RE: [PATCH net-next v1 2/5] net: enetc: Enable probing of versio=
n 4.4
> devices
>=20
> > The ENETC v4.4 devices are present on S32N79 SoCs and feature only
> > Pseudo-MAC ENETC ports, whose PFs expose both the 0xe101 and 0xe110
>=20
> I think the device ID of the ENETC PF with the pseudo MAC should be 0xe11=
0.
> The device ID 0xe101 should be only used for the standalone ENETCs (witho=
ut
> pseudo MAC). Is this a hardware issue? If so, a workaround is to set thes=
e PF's
> device ID to 0xe110 in IERB module. Then the device ID 0xe110 will be pre=
sent
> in the PCIe ECAM space.
>=20

Ok, will consider going forward with 0xe110 exclusively, in v2.
Thanks.
