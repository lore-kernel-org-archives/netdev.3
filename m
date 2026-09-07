Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7631F996;
	Mon,  7 Sep 2026 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759726; cv=fail; b=NL0fHooJCQ/nnVWng69ihS/U8I0sFMryddf590+C+blYiQbcRk+6PSDMZBGmY/aL/+1OnxJM4UnupS3aC0J2weL/bIH+IkLIbHTebjt7ZR8xHHerf5TYgNFd/P4cho0NrwqaQQR2LVinwaVs8v8SPrvfg/pMkdTaJH1XG9jeU2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759726; c=relaxed/simple;
	bh=c51pSBwnwQGWpnJQcMC499gMsVnrpHlYldva79obhBI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TWkm58VxaJ+CpiSJY0kblnynFE5zV08u6vntG5CtPH6I+/dgGMqfandFMeUFhCRL1OEIxF8npAyKSSGfRilbP2aunn2k1qrjBTb99jdMY+V6DMVeNcxl/QTl+msb2O5ZUQzZQS8rJL57ACeW2Q42FxVu5TgfQulS0KYuukb/hns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ChLaoVua; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ChLaoVua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOTv+lW5hmQGA8vAK95s9zvtFMLuZTB3GBZXA7EO4CRCyCGyum2+gtktCrbRahm2TCdogbGffQc6zx7gQ9sHWURIwHU3ETmQh/KOj5ZXmr9WxRGuGZX/6Spo0QlRodxRpENIV9jqzGB6hpUVvyZ/xcWIMEgRw/ies3Ktp2eL/cARCvT2TwhcSqQrXEvNF7fG0J0HOB3ZOfoITSh6cpdzW+WJZ+9YuVxOdj84rPOWV44gtl4jkyVoSVrCFxidfRSu8tqnickBjmQtJU6TxKcsHW/6pDKlPhN/eJPN1MPU4vG7DSvtcUi1HUAGh4zWNt+ZQYfWSAeRMMOdU2jXisEmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUUDZghgG12ujm9R6/iqUc0EVZtTgmBfDL3PIomec4s=;
 b=DwV+GeHSzbETHWDT+eqg7xBIOY+UtLUhGu1jUf3FD7MwDI8DvbV5+v3GaPL66H5ZRvWDpoWOVcy7lTlVdPhBjdTyi90AvSwfdsixYP5fHr/ZgQNCRboYluFuaBY+BvwhqgUsscatvSZ/C3aTlRRh6wB/XjXJ2qn79scsQ1WkLhS5nGuDEwLClSf3/zJ1tEjEGsuI+e+7jHELAzSVS4cOclvj6uPGYg/Rn2qm1Mv07hv8xecmNKN4f5KTaSJc+UQU9fh/FWSzrH36X1ResyAGFYnoPvhDd+owqqxQs+mVOAhJ8gP/wnaZaD27V+GFgDHII81X/SWuhP02s209/08U7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUUDZghgG12ujm9R6/iqUc0EVZtTgmBfDL3PIomec4s=;
 b=ChLaoVuaHV4UrOVX2O7EogBidDZWL7diyMza1shWJ+822TEY/yKSG7aB0oMEDw0Dn7cPMwA9UXBt/isSmbAtVCiXIDo2/thWDJUX2cJLSRvRNbuL0+SfiqR/tTIolGrRmfmuV5w387a46WAqavM/G7kLc1/W4hjatlF8UsfzcoD0cMmWXOLCtFNexie/88v2m1kt2zkKh0xoHDiw4pQhke3ociydT2toxwn+tMjc2/riP5J9YLgXlx4LvOxoBzYXKhWhiA8t5xeTx/X7uB9yUJAoeLHgSH6N+x/rELDzQP+LYPO58LHuedVjVioPWRZAFXOpAUaTdtoudOJ9/hiLgg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM9PR04MB7505.eurprd04.prod.outlook.com
 (2603:10a6:20b:285::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 05:42:02 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 05:42:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "phucduc.bui@gmail.com" <phucduc.bui@gmail.com>, Frank Li
	<frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Stephen Boyd
	<swboyd@chromium.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v4] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH net v4] net: fec: Propagate PTP initialization errors
Thread-Index: AQHdPntQqjO8VRJ7PUik+O14Mb/yyLbCkrXw
Date: Mon, 7 Sep 2026 05:42:01 +0000
Message-ID:
 <GV2PR04MB11739E45D1562C9063E05D77788B22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260907034502.12619-1-phucduc.bui@gmail.com>
In-Reply-To: <20260907034502.12619-1-phucduc.bui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM9PR04MB7505:EE_
x-ms-office365-filtering-correlation-id: 724dcd79-7dac-465d-eba9-08df0ca2bdda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|19092799006|23010399003|1800799024|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 TkKzQ1SoHcjNUnJgKIOnDsUOWpeoLfFp6RfOs1+kyO6mB9Zddz9NXbwQfEyCx7iUgLDyifN4w8J7rBxcOcdFlCVtZt9gi1lCeCjkB7rmjhwsQORwHjlLy9d8Hy3NJQTFSIekLiTtVJp60ZkumpUJH4RuRkl4GS/j60KRJ8MTdClqHLAZuQ6w6fL0lnJfkfZN8JmBJWIr0gDMPfZGv/8B4EcnAkKfim4xDPIS2t6DO5+MahBLxbzLrJdmZGhMuY6gLHsaxrXTTN9TukmudTalZ33WocUgxVbTTCAEAqGepMDYStA6+q7ENdAyVF06HpeXTIe17sHan9nFW31hHB79eGHPj7DfGJIQbH42Rz9zkJhoZ58+Zb8ifWIT1E1CLxKcrd9NvWWnyFHvARiQwecpgYlniRjhtxYV51GyoOkGvzy4UwLswhDCxi5lT6gn21O+/sgMW7G41roDcAaD6IfoZYqaydezMlEsesEU34MFAzEeSmyyheGTR35TQPOYdevC1uSb9r3e8OGIXfMF3Xuz2yPU9OKbM623ahWfJdlbMNYrvVs/tLrwGxvscRQD6Cp1UbG7WlLMCLWiatmdDBIPy2S5qPEm4ejFoPgcWvmhDx2lhbKyKFrktQdlFQ+3b+5zy4rNfswf1X7nFoGRovtw0OQHPqF8MNJxb+E3hM/TpZJ7y+yAkq/pZ9L6PQJnquFbSP9b02h78swAwv5ucSTKshLmQMLaxbTh/ZPrCZE7UFc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(19092799006)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4kyD8EHouWFnG3x8/EtUihHlrSBP958p75hXZQklj63QR7lP5OVTv8siHY41?=
 =?us-ascii?Q?y1rl3z5CmhOF6RRGCojx7F5g3mVUtCovN2yL3qijnmDegOKvtW4PyFEU2lzo?=
 =?us-ascii?Q?8ZhGkcuy0aaYEtzNlqU/O4+q8nfg8uTPkBn4DgB6fER2d8C9rF0Ap72ESFv+?=
 =?us-ascii?Q?vvAmfU8yGMImkddOz8PPnDvFpwnJNXPll96UdnQMkzPCKzbEGu7cDcFjWWVc?=
 =?us-ascii?Q?aG0YDMmNg+naGEjSIUcAg3c5P8W5KfbLrSBCbE7u4Q9BzKaRnjXStrGmW8QY?=
 =?us-ascii?Q?w8HCRcS8/Hc/PStVpcoUK1FQ6h5zaJch+ZbMx7kwimWJU9KLPgArqJeeFCjp?=
 =?us-ascii?Q?Fd92q3YoZFH6yiRYIwgA+reUSTjQLcjSQAh1c4DgAUK6GUVOClaga55D0F6L?=
 =?us-ascii?Q?b+gEPaPiWwWKxq8zhjaFVJ17yC8Q0GYmCPOSXg3YXNSMLlixbNwNN8p3MzDQ?=
 =?us-ascii?Q?0H+YBXxOx3UL4252ak8KYS6hPVpzQw3GICycySqwp/ja2x2tbYFvZtMEJ1Aq?=
 =?us-ascii?Q?r8zAQGLECPvqjXGZLGwekNaVU9eV+2XQc0aowrxMEiz81WlSTzei/6URjZEZ?=
 =?us-ascii?Q?7LzV4r9wMi5lflMTIUdNLQSvybSjRb+GWsmx45Rti1bsxP8n4DyHskr+xOg/?=
 =?us-ascii?Q?Ny0VB1Wprk3bRQQwo7ehE6wWvJwKtNZcyoD774FHf+O4otdA3pdJts3kIqGZ?=
 =?us-ascii?Q?FK/zjTFkA5mF7hbc5ckzmidA3MTOxdQ5P5pOTG01KuyPgEfhpZvemBLUpGpa?=
 =?us-ascii?Q?yShUx5vhxqlWg0VRI+zgW+auHTzO2ttJYER7Ybg6UCE9/Oxy9TNhFw3ePwvw?=
 =?us-ascii?Q?fTHNCMGucfuhpgwGyE3hOYquOW5S/uhTliKX7RztTq6F47SQBobFNcUH5UGQ?=
 =?us-ascii?Q?Dz1P4U0sqJEtp0f45c7ayh9HB3MAiRsaBhUk2CfOFW61bATIBhHpshbucHxD?=
 =?us-ascii?Q?SysJmgHTCyDrT6D8ql21VGZq/7BwnEwY4Dwll9M55wCE7En1i7kHE4kyl8+p?=
 =?us-ascii?Q?Mp2VrohNZO9gi/dOOy8ehsD5fp98VwpCj4VNDGFV8nE0QOLQ3+vH3IuVTrZw?=
 =?us-ascii?Q?JnKgdm3ZsJxziaf8X6NQ7TAoJSIzOyOtxMgRWPpgK1jgcRltxnBw2PPugnvb?=
 =?us-ascii?Q?FlPaIlRaHzLd+q4bDjoKzQ3OcQ+0csa+aGO7bJMNr6BDOVMStcrOOQYuuLij?=
 =?us-ascii?Q?K3Zxvf5IuJ2yfhVOaEgbJJWJi9WBnpD/KjvjAY1d2lrrmrV0TjITRda1qpPt?=
 =?us-ascii?Q?ef9r0zIzQGN6g5x0LkpVfWXISbF0/fpa0ovuTcEyxIMoiCggUEIZGqE27rQR?=
 =?us-ascii?Q?HoIh11s1rYdYoLdla8A82WaFu7UBGpGxZ1eh3kw4tTOWHrpjiWMVeDmQ2WZP?=
 =?us-ascii?Q?YAJAt5OfEAyFGohL5dMj3Zp8qJJJaInajLqb6yImrDE5PuIyyz6RAYJelQ2u?=
 =?us-ascii?Q?CJZX8Ou/8ZZG9iy9qRHooAW1MO0KYydJih7ciz+MOQ3Ijur6ymO8uoFU0mBM?=
 =?us-ascii?Q?AULccUAEytvaWD1l6XJtLGGj4JCGSGuXEzUfALuon9D/qJOt30iwQ9EeRIO+?=
 =?us-ascii?Q?YIEvXOS7Twp4MoyUpC7oiXb61QtYlg05prLxVER7Thk4yzuV7gr+8zjBqAyA?=
 =?us-ascii?Q?cApzRzrqqQdvDg3LT803M/r9SsqFcgqZ+VgxBgP4TMHH0OvVEpaBSjenL1K1?=
 =?us-ascii?Q?740WAtlB3M2lpge+6lqHAHpL+qDJC3RtCtklQiT8pe2JF94Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 724dcd79-7dac-465d-eba9-08df0ca2bdda
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 05:42:01.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1zM98pLwNWUH1l36pClspvXuCw4gWcZ1QMGUx5/WtUFdS9CIFr93rVZFWBPOnIiBYsd+OXUILPIz+Lrn14bxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505

> @@ -5394,12 +5397,17 @@ fec_probe(struct platform_device *pdev)
>  	for (i =3D 0; i < irq_cnt; i++) {
>  		snprintf(irq_name, sizeof(irq_name), "int%d", i);
>  		irq =3D platform_get_irq_byname_optional(pdev, irq_name);
> -		if (irq < 0)
> -			irq =3D platform_get_irq(pdev, i);
> -		if (irq < 0) {
> +		if (irq < 0 && irq !=3D -ENXIO) {
>  			ret =3D irq;
>  			goto failed_irq;
>  		}
> +		if (irq =3D=3D -ENXIO) {
> +			irq =3D platform_get_irq(pdev, i);
> +			if (irq < 0) {
> +				ret =3D irq;
> +				goto failed_irq;
> +			}
> +		}

This part is unrelated to PTP and inconsistent with the subject, it should =
be
added to a separate patch.

