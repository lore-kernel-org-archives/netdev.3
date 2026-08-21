Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F073ACA7B;
	Fri, 21 Aug 2026 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307217; cv=fail; b=UVyH105E+P3kwkb/LoVL6UTLd8tZ8C0g83vCGyJMhhwXsqZ3aeNPmID03mIvHeB0MMpIQRNJGBOiTcky+JEvFtWp3jUNEdTzWcGECcgHaEUyECUOjfXsJP8yHsUbg2NyDOnhTk8fFTA0gcddHqJqK7inr54SvUIslRdisRaRRmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307217; c=relaxed/simple;
	bh=18nA4IghxFGPqkqm7OnOBm0nEWwOfl9xsrcUIAdY+6I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N/bxASEwJFCl7Cn2Zn9XTb79O8n9gp7qmWBB/EA6mCaQnIASp+Ajc9GRTW5f14shSgTUPXtAAThgtQdeiJXhG/pxVD0DbGzZGqsQ7AVYx9MxJWFx0oWXRwJj0xV4zoxy/whisfmb6Tr4iX1ZBN649afJ3BObrQbv04v9sWhd1ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UQup86k/; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UQup86k/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUW//4pjA2DS9Pg3mdVd6scuAVKo0DVaRkAX6xtfinLZgbWDCLD7JNf1+rZdDq40fPgfl1ToxvOlQgyoe+Q77eQEF9Ber+WCQUXlhUGfIvTSyy8WRrrFwE7aW5PoxZS1exV+Ip8IdU8WnRzPo9pcgjxgiYxJzLnNQCjUj6r21g05aoWSIXx2NyxB/zI6IzKmmsO4q0f362878w+ydHosOVnMk4uhGjmxKqFnhinsLzPggy6P8S8w10Uu8/kCZy08OApsVyvXoOwIWfXTX4B0I6p0uLAmbZJzBGhV2cXL/qZHtFyMntGMnIUtobsIu6D/nCMW0PaoRVLeN2Sh1Yv6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clywFrwMcHYQeOH5JDZxDJWKe1cKng3qnk0vCrHM3oA=;
 b=tX2/xOwQwgAhH+pCP5tWtIk4P5avlpqlG0Z+u9R7m/y9Yk4lLTfL3PJsutvlM2OAKI5do9h6M0LFr2KZNhi1Kkwcwey2visg1LskTdPN1UBcB83YpFQuR3kt2WVU7qlc5KvAXhje6O+WDtjU7/U/9pwEYBPXXXF4oM+WwLyOJ1E52Kz2iEpR7EnLsDHmJxRq8FxVtTmc13mChITic2wjCqnd8jyOPl7zuYtbX7Phff9B8cicY/28CyhU1uV8UXPxapXye5NWGcFazDDlEoQ2I++ldlkVHVLVEcGw7vjpXOOCpifhGIB/wpezH2+EYvPqfd9r5X043NYICAwEF06SJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clywFrwMcHYQeOH5JDZxDJWKe1cKng3qnk0vCrHM3oA=;
 b=UQup86k/ODn8SPQTvNyQJZ1R/J2j3kXAWVXJk+AJJPqfxed+hje+EnAFzPEw6NK+u1o9FqmQQfJ3kxtiw1LAmDy+NpigZpJS+hVLJ6kdmUmRQ2D7mm7KVOM6AvLbxtLWuZ42tVf3tQ0VpZeXD87t+lsC2XUBt78L9+I7ReV3e5L2+u/BQaQTXZ/M9awa51HYwfEZyAtLGM5AfWLh2GBdYWxUpnYGDXJBS1/o6aL/toPxWT3dUHSIhACTFJ+4ibm9ftmxPIwEY3gs1vwaioXocfNlXw2wCqRa/LOFQ3Au+a6/WLtp5UMiN+wbq7SngOcPTY4Hf+1nqdvUHLGSRbrQTA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA4PR04MB8030.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 10:13:21 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 10:13:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "phucduc.bui@gmail.com" <phucduc.bui@gmail.com>, Frank Li
	<frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH 1/2] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH 1/2] net: fec: Propagate PTP initialization errors
Thread-Index: AQHdMJUYdfpMQdRrVUW3XphKu8bQtLaoSD5g
Date: Fri, 21 Aug 2026 10:13:21 +0000
Message-ID:
 <GV2PR04MB1173976A5DA80B2816493C84788A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260820111416.97917-1-phucduc.bui@gmail.com>
In-Reply-To: <20260820111416.97917-1-phucduc.bui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA4PR04MB8030:EE_
x-ms-office365-filtering-correlation-id: 0b4b9a77-7992-48e9-0774-08deff6cd45e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|23010399003|22082099003|18002099003|56012099006|38070700021|11063799006|10067099003;
x-microsoft-antispam-message-info:
 bUgmL6MVbc8exKgcBzddIU9kEgm1XdzrldYNvEx4qZDTqi6chTNNnRFty8RkfBn4BjDfH6o6zW2cHMIhCJduciqM18rJWlxZlPtBZH3Ju6pYxQdglaqFmxCtMhBT28MNrd9fPel5b9QkNUk/9tfNav47aU1GVM8Fdx/NWWhvtZ+XK5ZdVZdxSEHu85f/p3jggHQGmpnnwbeAqi8RiJdTtGqsZdAGcFq9VhC4TPhpHMTQK3sym02P+Ck6hZtp1zNVlvX1lbQp45hUEIXesR8YLNhrDXBMUaGoLx0irsXEr7JBg83il5dNg3WXqh0APerj6+0WO1LxgGZs2JWXIRxwB4GHG/rTom6FX3JjzcDhcN/iDFxVscCvQZvwzFw6TgcwjAiLSc5TVy+FawGWobRndnjUwDD1jqoA+xA8yr/8gdruLaisFrI/aOmonhw6iehbUbEAhiR+AMv+kN3UuKNkbTmZ4jroO8HQCobcXqh1k+JraPDXVDsFCSlIBQKOekwPLjWfFRLHpSd46KPWqHjNjK4LyADDcrY412isZMdECzdcHkgFx1LcODOConngBCKzEd8nBPE8iEkE/VSuauv+idl/F0fbz8GUTPKxX9+wO497kU+wPuQDPo9g0LFdo75ZItS0nOzZHHI1pn97ou5I4rXZMQkXpevD5V5c5Ty/Z/34JS8/vrHAIRa1xNhgAVVNJVYaRRrJHu1x1f+29gbUPlH+Gaben6u7PAhLmzwXelE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SVUcLAlhuprSQIsDBpoTgVxQRNyiaPiVEkIpSZ9tWVqcdX/2xrPe6uNWtYqO?=
 =?us-ascii?Q?UONcqg/vG7VTqFoCkSpsALIpvldMhs+089Cohj4oFdDzgVU/B0KdNd8UPSDj?=
 =?us-ascii?Q?KLDzxxHWQefxwXyU6kFHlLVFpXAgsVwUjwYbuzYSUtrBuGHSrSYz7f8eneOJ?=
 =?us-ascii?Q?MsArBp7pW5GpRNIR0sXVJgF4aHolDiSvii6Mgq3bM69xT6/FtmNh486cVDgd?=
 =?us-ascii?Q?WZDpIpt1uKibij6k/cIHL6GhBiOeDb7m521OPNmp969NdIHkS/JBCJkuehmK?=
 =?us-ascii?Q?mJh4fLlhfGXRT7IApl6zEG5tkFhs+WFScdZp9dIO3Ezg2/w8u5p475qRbkXA?=
 =?us-ascii?Q?PDdXOzQqDm6I7R+EMipH+2gmbw3+FmKbiuvf+BGJFEeUxuxU6FvZhGLQR5aA?=
 =?us-ascii?Q?jtAbKtDQo7cisWXTRJofvt20ki23OK/XqVWAv9q8aV8SluGcUT1bsF+oxpds?=
 =?us-ascii?Q?aucQ7dxU6g1lUzZnlj9khPZwsXCOxHUF5+ZGR0yeBgDtWQCiXB3P9bv7OBDa?=
 =?us-ascii?Q?G+9uN+yjj/s9RyYS18sY79EW6b9ALXym1suAgB7E1qA8wgWh0ZPkGxdnomts?=
 =?us-ascii?Q?7HKBTgRN7acN/ym0were5dPXx0pYXHSZpoe31t4NMw3Lle6aDXhS9Ro5z9Vw?=
 =?us-ascii?Q?Bgjtby1yHTwnv3CsKgVFat+vfqpndAKXAUd0MWorR32/D2B2To3JujnQHsSC?=
 =?us-ascii?Q?pl7pZ8frwjw0Ye1TMJLzo5XvTBDskj0PrKBjG15fRabz22OFshLnccQcwlIZ?=
 =?us-ascii?Q?6LDjJ07Teseqfj5gXYwTyOLCNfhUFUMXnAMucHZXTGTFNApIPj+oyc8ACyQc?=
 =?us-ascii?Q?MbUQ0xU/7YV7Vw94XCFgcKV1INnWZPRk3uWcUVzF+YW9frbENMhZw19fBjzG?=
 =?us-ascii?Q?UfDqwgRnesv2P5m+JeMdK/eLXKihirD5OuunEZYI43FVxrpfgnzHA2Pj+APG?=
 =?us-ascii?Q?mG6QyTO62pCcloTIq4cbr/U4ccamHCd1peSnVhg50k5MZPk0jhZ3R8YXIGUi?=
 =?us-ascii?Q?e+/va1hEWzQyVJ1OJtUdrj2YjKtkhoozgFV9JormEzuu/ivIlDjrAZJuBETh?=
 =?us-ascii?Q?ohIYKquCWwPwef0VJDoLM4g5FLkh33g8yVMa9Mcw1/s8ZB0JU+Oub0bQHW2d?=
 =?us-ascii?Q?qMUSKvmeAyELzUr3GHSNp7FcCvDRtzrJ0nmDsp9fXc/fCFm15wyKmxylg9qb?=
 =?us-ascii?Q?QAv2OS/N7S02/adoZSgXjq9zjjBoJc/yUMyau8MjLmynSeRYovqBZnEcJoIB?=
 =?us-ascii?Q?WnET/UzT9Dc0YPfPr0Aoa2nK8XR3JdfpDhWWBknyNMEne5ZJDjIYm0Fu8soL?=
 =?us-ascii?Q?DPsnJcHx4T123lN/TsNxBSDdW1EIUtzB7sLoleVpqMQoik+ObQWDKHXRuAJe?=
 =?us-ascii?Q?gWgjmXcQ6rz0YE4sZfIR7NYFeMMGYxskv6y1r6pUrSQlZuDadseZEbekx2R3?=
 =?us-ascii?Q?/673jffvfYZ2i1/2bHrbPz+IYiZDW7pgOs7iij52br8RoB47uGCEJOGuumP3?=
 =?us-ascii?Q?lBJcJhQ5ZN4VmrCed79NIyha2nsiw1vewREQwXlANmsPKVt05w6DpTlqs2Xj?=
 =?us-ascii?Q?zLkh4ya9+9UYSUfK+OJ+flXxxj4WVRMrRzLNltYGpttfm4L04OiTgSbnJJrh?=
 =?us-ascii?Q?3fzFuQWynGbe/y+nGeLDyYShif1z+XUVQwf56jeqMCDoHa5Xu8zTPAASxmsN?=
 =?us-ascii?Q?3j1E1r4Ccy2O+gqkSnfIkAKE/UudCoZIq22R0uMP7jLpIHCP?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4b9a77-7992-48e9-0774-08deff6cd45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 10:13:21.7393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iY7otwOnR1ONKt2CTKwcE0yoXD7RdZMA1Y7T0CU6EIfitZBRI7T7xh/LVUfQnob4AavAXXP0N1GJgWpPEyRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8030

> -void fec_ptp_init(struct platform_device *pdev, int irq_idx)
> +int fec_ptp_init(struct platform_device *pdev, int irq_idx)
>  {
>  	struct net_device *ndev =3D platform_get_drvdata(pdev);
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> @@ -779,26 +779,29 @@ void fec_ptp_init(struct platform_device *pdev, int
> irq_idx)
>  		      HRTIMER_MODE_REL);
>=20
>  	irq =3D platform_get_irq_byname_optional(pdev, "pps");
> -	if (irq < 0)
> +	if (irq < 0) {
>  		irq =3D platform_get_irq_optional(pdev, irq_idx);
> -	/* Failure to get an irq is not fatal,
> -	 * only the PTP_CLOCK_PPS clock events should stop
> -	 */
> -	if (irq >=3D 0) {
> +		if (irq < 0 && irq !=3D -ENXIO)
> +			return irq;
> +	}
> +
> +	if (irq > 0) {
>  		ret =3D devm_request_irq(&pdev->dev, irq, fec_pps_interrupt,
>  				       0, pdev->name, ndev);
>  		if (ret < 0)
> -			dev_warn(&pdev->dev, "request for pps irq failed(%d)\n",
> -				 ret);

Why remove the diagnostic log?

> +			return ret;
>  	}
>=20
>  	fep->ptp_clock =3D ptp_clock_register(&fep->ptp_caps, &pdev->dev);
>  	if (IS_ERR(fep->ptp_clock)) {
>  		fep->ptp_clock =3D NULL;
>  		dev_err(&pdev->dev, "ptp_clock_register failed\n");
> +		return PTR_ERR(fep->ptp_clock);

fep->ptp_clock is set to NULL on the line immediately before
PTR_ERR(fep->ptp_clock) is evaluated, so PTR_ERR receives NULL rather
than the original ERR_PTR value.

>  	}
>=20
>  	schedule_delayed_work(&fep->time_keep, HZ);
> +
> +	return 0;
>  }
>=20
>  void fec_ptp_save_state(struct fec_enet_private *fep)
> --
> 2.43.0

Additionally, the second patch can be merged with this patch. There is no
need to use two separate patches.

