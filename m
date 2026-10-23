Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792721287;
	b=1qmBQPLbT8zpiovaK6iTJNIiTcfZMtaKm4HN4MKDvcguOhhYKJr3XdYxSxbX7QGfaFSi
	 aBFyt4v3EiU5/Ef+7Z7qG8IN7gLzAfcvyb5aAVSfKkP51ibF/RK9vsDbCLTbBuS6Efbad
	 LRnWnq7At1wk8faQ+S3bbFLIHDwP+vp9NKIZFaY4eRiliGDoZx4DuehFZyfCqlaQ3/OyA
	 aHC9x8VUnw8WruiIupnOOE7VnhNGdjzEH6I2AoNQx/0bTVGlXfHLNyCjX8VA07uXLCiac
	 Ds9NlC2aMkzf/X6yTX2zNRD+Kb/xi1vNK3H176MEn1UjntmiFjd3O6bhv5ewDU6wjew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721287;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=OnFDdzcsFhUGlEbV4fCnu6y6nIflH25M+KUwOrn7Tpw=;
	b=aQ0GVFMxoKlaAQi8sPFbG0fJvgjRZWoNxa1TMOKv8ZtsCbgANWahmgzMPHUtOLfd9Wc7
	 jb/UZmMvTZkOAzm5vvtQl84XASuiHnyPyQGzJTFrgCqJ0ropgrRXIW/2MrcoqcixXEMS5
	 ZPws//AB+BnorGchAeX67IDXGMsIovz9wEc5A6O/9JOHbD2FzpxJidHM3vW75KtXTjiBN
	 HmMZm7pBnjuJRMlTGaPTMAFouDp0zO4EUQe+zN3uTRHFJ6bcvUxyGn0G3zROXQlkE/mYY
	 jSy/DDQP6n5LSqSifJxb9GxWlPGEumjfL/yZNlyXhIiqylfBddwzRRjLgvt2SOD3OWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CdOqQB+8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.7
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CD606A319;
	Fri, 23 Oct 2026 02:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 845CD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CdOqQB+8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K26wQWKlpF373uWnIgGhsHURYrqBFN9O8n4/pReCtgasnrFEWlXFyjyqgWVbPGplG0kXCT9cjMkEsAWBH/kG82MM8ci4yl9zXJwf97yBHw+/+IWDHUhFzWmnPnmT+w2wQwVnfjPCdFjLgAC+qpcNIxsUYeiOI0wrD1Ku/f8yNQNrELBoR1Z+QJw/ekhpwZfh90OGL+KjPXF8JkzCKtpfn1vKkGSlUxEffMyo3wKaPXR2tZ5XGKmCcrS/ujlWeOhdHfhAaGqt8las/ft8klgOwETfy/AHCph+meP0lCfpC8POOOZ9MD0JZIQFj0XmCijXX843ok1xYIILSARPjX6AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnFDdzcsFhUGlEbV4fCnu6y6nIflH25M+KUwOrn7Tpw=;
 b=JYy2LoFKh30zEvO0I62wQVGu91CINnYpRvGL/tmTKFIcaTQ6P/r2I1/mH6BUITwhdO7Ip33Jt/pVpSLllf7wTW494PCBx3OpG0P/ooelCRyMs+exa+R/VhltknJQq8Yg0mEKXvjR4wnzcZO+0zTne08wlicuTgXT80wa9jvVSYBpt0v5WeBfQF7tYGFajBy87SQ2oQSMt7KWgJeYwa957Q2RCp0EkGF7C6lPQoClTmCkws7ptUiEIYm7mgeSy3nMO7VXqfkxpCyNWIbrtPlBZyUYIicybmAFB5jV7CaQ6rsYI40gVLoP1KIlMtQQYLF01Zkrq5gzx/L+xOWp6TvBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnFDdzcsFhUGlEbV4fCnu6y6nIflH25M+KUwOrn7Tpw=;
 b=CdOqQB+84/3axbF3Oic5TnBxtkNxQLa9/se8yom2EcfBpu7On3t1JclT7h+j4R1vaKWYzE8/KnnFAPxezyxFkDyFtaeJAK45Spf6oMznpDuhFouXCfd16Wtzrm/r2m1HGdI5P1EJIy1PozScZPVJCyZlYSnMf7Xmyzr/JbBDsDnuVcWYyu90H0iOwzrG4svhfk2fbTUgGexzHigkaiIP73BVpep33oX5gEdlLPK5+N/sIqz9qm0dOD3cpcXbmctQfLVopbLje0GVD+i8fs2IDX/awOq7cTd6vad1fcmClHpAijDCVos36MZoaMKqLAVV7o/V9TNg8WJylKKp1Nn1zg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by PA1PR04MB11507.eurprd04.prod.outlook.com (2603:10a6:102:4e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 02:08:02 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 02:08:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Marek Vasut <marex@nabladev.com>, "Frank Li (OSS)" <frank.li@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Christophe Leroy (CS
 GROUP)" <chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Eric
 Dumazet <edumazet@kernel.org>, Frank Li <frank.li@nxp.com>, Jakub Kicinski
	<kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from
 DT
Thread-Topic: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Thread-Index:
 AQHdXaVPTB8CJdKLoUewahs8NUD/ZLcAl7OAgABoBfCAAP9vgIACLV7QgADg2wCAAPzL8IACGJMAgAJF1/A=
Date: Fri, 23 Oct 2026 02:08:02 +0000
Message-ID:
 <AS4PR04MB9338592F92D23CCC59FF181E88642@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com> <atKDNdxl0w65s8yQ@SMW015318>
 <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
 <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
 <AS4PR04MB933821150913BDCF35C4827F88982@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <fe920b05-6d89-4dc1-83d3-0664fbc2e00c@nabladev.com>
 <AS4PR04MB93389CB9849950CFD78411DE88672@AS4PR04MB9338.eurprd04.prod.outlook.com>
 <ucqfjqsvvnxp7csa53lsbtxxeti4n53wdrybzuemargqkt556y@amr6rfv5oq4f>
In-Reply-To: <ucqfjqsvvnxp7csa53lsbtxxeti4n53wdrybzuemargqkt556y@amr6rfv5oq4f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|PA1PR04MB11507:EE_
x-ms-office365-filtering-correlation-id: ec660909-53b8-41d4-a873-08df30aa77bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|19092799006|23010399003|376014|261022105027099003|56012099006|261022075727099003|38070700021|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|261021121427099003|6133799003|10063799003;
x-microsoft-antispam-message-info:
 0lDum8R7jC3a0PL9ikLoHrjs7TmiCZD8Ud94ogKTHSonnJDuTKIXs7SeNK/nLd70zCFHRlcbRLKNrd6pcGjxRDIDGVo+l61N++4gPAWFzZTy4CKlOKti6uyJ5ob58iLLdX9L3PKeo64/Qcc+gjocmd1LCgC7vgBWdw0etM3+a6nPqMGyLshOdlhwNUxmjdIHE1Se5KY0mk4L2WXapqxuhuhsogFjvox3RFR1g6qqH+2cMvgOpwyEXoHfdoeyfVa3y9YJ0dcAgQ9ZeJqVnTRdRIBwIt11tD3TmZvoMXVTSqcAIChYzj2wt/ajez3L+7w3HefNhskMe/YkNZ8vYC65tVLts2tKgKYt3iPMIFsdBQOdN5gPbOdc2d8vbrvsWTIDQ6OJy7VKiJfGSjny5pefKXicKwVs9dta7JZjo6aveFKaut76b+bMeOb8GZ7Fj4DTnEtH7sDe1BPRj9pmsxajrFigk0/puFXKYdXdmlZlcQvSomsepSClDqWsXxIIzIRITCzn4UJ/brKizntCukvEcAkxklx0gsHEPUSZmiBCALnT140gt1g5+6rjsoF5gvarbrZ9O1UcRN+9tJAQDPaHe991yfktaoVqJBf0QiExjIrOdQxazdt5oNoxrDoB8ELHorc4J2eAB/5DmczzLK6JApZWs2HpAQEYQCNiXLAJOpqviDDGz4CPzP2C8+EPdkeY1xWBZri8n/SdtdNHsnd9zxjuVj5ScNF8+aTIOVOzH5o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(19092799006)(23010399003)(376014)(261022105027099003)(56012099006)(261022075727099003)(38070700021)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021121427099003)(6133799003)(10063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZtMvQI/DE62yjCGl4iSrfTvIrU+uj7TngzyEoBmYk2BSW2VladYAjOPW++nO?=
 =?us-ascii?Q?nHOUS95EtwQH8HOBZ5QGtYZyG7DI97z/9PJ5FZkqfEfQvglmvnnbqZH7BMet?=
 =?us-ascii?Q?ITXXwqyM39qxFswQd8bDoKnxfzZ4+RS1NkmnmvKqY7rRvaiYPbQDQUAquS2Z?=
 =?us-ascii?Q?Eh4JQ6g0sciAtTri65v3BQLQFVBiLbJeb+TiMVZM+7LX7KmVWmHC6N1AHnSn?=
 =?us-ascii?Q?KxURmS22aSbjegplSeAiR/3oJVNpvZ6D1qUxe0nmj1aQKMuWOWveeeQmCjW+?=
 =?us-ascii?Q?DDnZkfgntEDDRQskUa0r0/5BBuNO+WRtg+OnBMraulIEJyO+f/HQuT7mBs9+?=
 =?us-ascii?Q?A/FByrZYgUDRVAqqBoanQxwy/rZb4POVMaV9DJA4kd/Gh5et0uI4K0SnJREc?=
 =?us-ascii?Q?ClpaYzSa4DzBF4jtpBRGT5raA8OiuRdamEmR1zzRFhyruJhPcvXSGq/qC7Ym?=
 =?us-ascii?Q?pJaxn6wGfPJar0TABazSlAwtpkMiuKMGmcDttwizfeaNWRlBkxigxenLVyEr?=
 =?us-ascii?Q?NzwQ2AzOhCxQEIVSMN9rgGEWFLNdi9aubi4lkZ84zC3V0YtFUxav6XFOmkSP?=
 =?us-ascii?Q?sxnsoxPJgkhxmY7/5CwbK1wpyCkLgAIRTNR9Ir16+3mdTuDU4ol9Gfzumnl4?=
 =?us-ascii?Q?zTiYCIpMB3k8uwN4T7SW+wii0G3WOVCqkvEyxGERdJrwZq+bAOxC9haboG1E?=
 =?us-ascii?Q?/pWlGWbf3DnlDHR5my9IUlIrEkbc950616D2HngurdM7/zTx6gmVyfFn9gty?=
 =?us-ascii?Q?Vi4hCk5PyBp3MoTJpb8Xeu6+aQ6IXV1RPTfv7fOiXpMoD2QCZFyLmHoDtIdn?=
 =?us-ascii?Q?d4mbm3aZDUaJuljW/nSUZhfzIfNUcR5Cg1n3d/+oE3RRjRzwLxtdvkTg0mmD?=
 =?us-ascii?Q?/cKIMjgu1BD1Wnl1Ox3SjqSkJ/1ufCo8zJiHcZ0ia91yodVc60VeDcZcfFmY?=
 =?us-ascii?Q?H9dIieM5MLRdbjawOH8Tc5Tjnj7vgIqfLd49lfVog5Lc+Qtbi+mW639gj2GK?=
 =?us-ascii?Q?xP/qILx6GHinuQFQsx8IEBUT0jr7+tqOdHw67v4AbtFxwabRZlGOl6NFJJHr?=
 =?us-ascii?Q?Wg2Gkxy1J9YCRPbUCImJ34i/OEUW1np0BR1DmODvilN4UyYxqY+OnQiRIiHI?=
 =?us-ascii?Q?Lt76VRLQermUtmcsR7mo9Dvp7DApFTQrJUdc+Rmp1s9sFdd56DU0Bx9r9a8U?=
 =?us-ascii?Q?6LM5+TZWJ65SRYWUlZ3Eqgr90Mh5pEywYeBD9YI5Y6IbUNzgwvFagB6XRih/?=
 =?us-ascii?Q?4YLsC1JjsivdvDiE4ob0kYu0kMNkEeOgdXOxExIgLBYfroGEstiL4d4ylIVT?=
 =?us-ascii?Q?a0u47TvXbQuvLqQDc3jappYIKFkuELDIvneLE3kwy1QLFw3hJyif8TmD/LGx?=
 =?us-ascii?Q?cSlVMjQzFQzyO4VEG0IROKYXF9dyD0hRF9hy5QuSPDodNv7iy6uLN6FlTgbT?=
 =?us-ascii?Q?G56ffVqR3izDEUcsfsga6Sq0zr24MtnhtQcamr9sUbTrcOkzdxjuuOYx46QQ?=
 =?us-ascii?Q?bc7z8ZGUEFBoRq1VqpWoGXFNgyCT/UClhZWhgWzSQGAQO9BsZLY+Y4JPJd9v?=
 =?us-ascii?Q?Syrty7bTQmXZljw8ZbHDZczJAOielaa3evqG/iklUVIpwbfkflioq48pF35h?=
 =?us-ascii?Q?VqL9y4F2V51EYiy2kAk1UD/GvG5dH7PyU3Iwx/AJ7RegHSyu4Zbcoo4TSxnI?=
 =?us-ascii?Q?Aq6ZnmZjTbxzlIO6isiMEvoMDH+qgj9HTfXXIYNYA+aODr5t?=
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec660909-53b8-41d4-a873-08df30aa77bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:08:02.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ps/KdCnOOBV6UvrdD4yv0zFijhLh8ivXBJdBFXbv0loE42Ohi2LkaSm1YjLJcIPcvzwILopxiWSLA3LAfLrZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11507

> > > > Your first patch only modified the EMDIO binding-doc, not the
> > > > ENETC and switch binding-doc.
> > > So I need to patch also
> > > Documentation/devicetree/bindings/net/dsa/mscc,ocelot.yaml ? Any
> > > other binding document ?
> > >
> >
> > fsl,enetc.yaml and nxp,netc-switch.yaml.
> >
> > However, once again, I don't highly recommend adding a clocks property
> > to the DTS to obtain the MDC source clock frequency. My reasons are as
> follows:
> >
> > 1. The MDC source clock is the NETC system clock, which is a fixed
> > configuration with a fixed frequency for each SoC, hardcode the rate in=
 driver
> is simpler.
>=20
> In the RCW project (https://github.com/nxp-qoriq/rcw), we have for LS1028=
A:
> - R_SQPP_0x85bb/rcw_800_sdboot.rcw and
> R_SQPP_0x85bb/rcw_800_emmcboot.rcw:
>   set CGA_PLL2_RAT=3D8, giving 800 / 3 =3D 266.67 MHz.
> - R_SQPP_0x85bb/rcw_1500_gpu700.rcw: sets CGA_PLL2_RAT=3D14, giving 1400
> / 3 =3D
>   466.67 MHz.
>=20
> Apart from these, yes, the other RCWs do set CGA_PLL2_RAT=3D12, giving 40=
0
> MHz.
> But the statement in general is false.

Okay, it seems that the LS1028A is a special case. For i.MX, we set the NET=
C to
a fixed operating frequency for each SoC and do not modify it. Therefore, i=
t is
more appropriate to leave the LS1028A as is for now.

