Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011016.outbound.protection.outlook.com [52.101.70.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B7361958;
	Mon, 24 Aug 2026 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538537; cv=fail; b=RrMWy0zUIgSF16U63JfcPXmD1tmRYd8UIs4I3rQoy8Vkd/tS6cWurtkTj9LNq98Xfx8xN9CRTU7m2zQCZjf4oYVrcstj634iLmTRF5fWvPfXuMgbzcEiaGQV276jDZuI0Az0Mti+gR/mp7o7OOeT72lOujavFKy10zml9JpRUrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538537; c=relaxed/simple;
	bh=xcypoIJjSUNuxQAnY+UJBT6aDHGA1XAwwiRGlBt3D8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Is9SAHFJHMkRvQAfVLfBkEYNZXyW8a3o8HZKlD8/825rwDT7Y1zhEQoXX0pfZed44LqXRe5qV6p8BZI+lDGwyEDyoZV/cBt/oE0a2pKACDcJTdSNcRy/gglkSmXXqpiVjp3FWMYKBQK6xmhf32JW++UYb3P7SO7P1IDYhD8UWHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yop0ozIn; arc=fail smtp.client-ip=52.101.70.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yop0ozIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyKifiaqGHboGd2cPIsMqkGVIhU84FtDs9i/iamFf++g5uvuj5yOsgTzTGHXqNmKxXRYBGDDIrios3qm+OK6ywSwI2yzztWtUQa8xkGAI0qi+446eY2wpSE/HbHbGcXNioPPLCts+FV6FZQUyrL8Rv47lVBux6luuWTqt5qEtFP++QGOuAP8VHd72CaQQIQ/gCQ0W7ucEwJG7T6Pl03Ezw4cNEmFtv+VLGC5eqPbS9OqCc8HiVaRRN2fmBVxT2/lfcvUXFjjYEb7CA8AfMvdKadmMjRSLj2xLVsOp2AP9mSNEQQTRyULwduUG5IYC08jZN+aBFLuP2fZXCvvB3mfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtuUbGDrOvyCeQcVY6OJu8vr7YaF1LNXUtK61CM47/Q=;
 b=KxjiLkVy1A3fi/OiJNVBfqe42pJTgoRqSEAVqtoMkC27kez6lFBhd+XORkMlEi19MD9rMe4KLM+REj2j/KAyiwqLSJJAqJk+0uYfNmd31IUGkeuLaAo6MUusEVdIgwSBlCgoEiwmSBMJnVCkp/56R5PouieNSzE5Bll+HwSShZJ0hqMhyRaLaz/XgjRALlIu0ABUUg2Ztop6ldUjDxOTHFMwM7Z/K07OCMAldEZ8TnC0v2HLpxlvtXrdsaMD8Wxsyd0ESVlxnfWhPxR5P3d9y87MDyJ0jox7Na0wouXqJqjqXMXxp12s33n9PpCQ0R9aXLQ93SWBy7bDnnSCOuuG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtuUbGDrOvyCeQcVY6OJu8vr7YaF1LNXUtK61CM47/Q=;
 b=Yop0ozInVHsskskKihHwxgBYUwAQIaZUEEVRVkPmyZJbISfzEnQyF6e+fgsbz8bT1QiXSp8+pY1TXuCGpbQ6pcuJsYHdpBtEyi79E4gpghBW8gZT6TeOVX4O5RCKoQwjSb9jca1tMMjfzfeZFfML7YY+ONZRltRArw1GfZ3iwD3wmduDTAM1UI4cKZpLeUXN0QsSnO9jDjJsXFQy0Rl/xtEGki1lSRgC65AWOKfhsk3qTWS2lv+SbC7dpMPlbWiBYdCsAYLw5PIeDbgFB3d06hgxfjbzhURLVVZZYrTnjasbOQP5Tbw+UNFf5U1s+4OJ3Xq2Ru3b3YTeRnn1SdpT7A==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DB9PR04MB11534.eurprd04.prod.outlook.com
 (2603:10a6:10:5df::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 02:28:51 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 02:28:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 1/2] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH 1/2] net: fec: Propagate PTP initialization errors
Thread-Index: AQHdMJUYdfpMQdRrVUW3XphKu8bQtLaoSD5ggAGCAICAAq06MA==
Date: Mon, 24 Aug 2026 02:28:51 +0000
Message-ID:
 <GV2PR04MB11739998877A19F8B8A66587788A02@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260820111416.97917-1-phucduc.bui@gmail.com>
 <GV2PR04MB1173976A5DA80B2816493C84788A32@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFeaLMzk=2_HGvCktZwU7DmNWsHV-vHSBGwbWU8k-TLfg@mail.gmail.com>
In-Reply-To:
 <CAABR9nFeaLMzk=2_HGvCktZwU7DmNWsHV-vHSBGwbWU8k-TLfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DB9PR04MB11534:EE_
x-ms-office365-filtering-correlation-id: 22cbd7d3-6b3f-47d3-8c56-08df01876fc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|23010399003|366016|38070700021|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 tywYf9lOmqVrG1K6LujfBUoch7EuzoNJCEzi4DgskHRf8QFIOsb8WcH1CtJi8YAxUnkaSoVTCldiNWOjN17LUkJjGCeSlhH5xe/Vm5G/T+u+Wij6I8Z2/gZwMBy26C+/UhNBGByXnQle9vp6GEa3Je8AXysq6dQ9GtOKW0/fj6IVTQUX6ymBnXn9mHYbQOsR1XvZk/KIr3YYEKi1X1THkdW2AFcpIJ7BQTPPnb7o1Flq0emnulW6FPn9gm4Ufc0xD0PYHqSNkldf+Do5Z5ltxuVr8Cx9bFE+u460pZvYRpmd12pQeHWwuCFhMB4LRZ/dv5j0LAQXlkqxMksqTO8d42Op2QYM7FXIUShEsaCHM9fOMRc9mSnAjbksNCSsis1OFn5xwSWNEEIu7S+KkZ3z3sQ+j5JVDr5gRM/NxmWnjA9zhRIqC86H3rbowCqVztHllUCNU6SiHedB4GEFTDKHXKAJM0jqoR02bD9awHU3rFIqMo6wcYQnCNhtiCczc+hujMuX8PFFlE1z0lVCbBWVdHVqBcBhfgbHgOfjmtgg9cZbZwV1n2yL8F/RgHrqYXL9cijWh/1BSkh+ImN1ydi1ohcoDLawzlIGrtf7oMqB0IBin7oafp6pB086qb7tGqWb/A7bsQU7+Ot0JPrz+stgX/yNhp6EZ1CcV6ob5jjfYAk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9D1PvUafTZ7ESV+8AY/UGUyTlXxeHFIppnx3b/P4PAwxU6WVlkLXxV1Y1Nip?=
 =?us-ascii?Q?nhosdoGp1duD/gslfk1KOMuZHZNrDmidqCeYVXe10M9h9IrZMrCOa6bOlTb3?=
 =?us-ascii?Q?FoCr5qvNrvsUlTMl2LYWORqXYA5IRoE5HSWG7Fk6qaijKbyAxIhbfbzIqgWU?=
 =?us-ascii?Q?Ac3C39knuoIQQzQAJbn/p8UuTGzEuGLYvSzgDr0jJOgLyGR+p6vLtuMuidl3?=
 =?us-ascii?Q?++HcdJlclSGPQGeDBhPY8c8zmC/6tIg8JRIL22z0xi1ZgV5oEyoPgt/f5ikh?=
 =?us-ascii?Q?EfFX/azxZG75TQoVwX/xORZ9nclXdtezJmHv94HzHj+n7E1FTzSbmesb9ksB?=
 =?us-ascii?Q?jR7AOX66B9fc9ZH9lJDIStn/t9tAZe63W9Cz8Z0nrkvMf0Fgz3nRgB9JQ73/?=
 =?us-ascii?Q?vj9IjmeuuHOpxpkFGHmGLHACB4ydFQK6lmkezQdiHD22z4B6mlvnGdPS6JT9?=
 =?us-ascii?Q?3Pj4z2RkmqtM+tVwTo+T+9dS3IJ2bOGeIqi+DE0/Pm8xxduvsRuo09NL7ob6?=
 =?us-ascii?Q?XHjQHNrFFALBDtpRxwvU1r1XVQd5LYm518/lYi3BpmxSumVg2eaDf46+E6ZG?=
 =?us-ascii?Q?TLy/J9jHOL5oqXnp52TnClXNEFfDeGoCEXmM02b5RnYrGwGW/aGlCR7Xw+KA?=
 =?us-ascii?Q?nRSxbl5hRuJ/MLA3apDO29M3SCxkpfW5+x1HK/9/y3zw13xKzj+I34WhxVTi?=
 =?us-ascii?Q?XWI/ywChMHi4OBAPNvKAzFy5C2EUj4J171yLb6o9F1Ws4mXYXLuDJ1zXOcAG?=
 =?us-ascii?Q?0kQmzuBM0pLhwCrQCTsT0C6MvHnaB4MPxAX9o9cyNBGcRXoYkNP5ykXf7O9Z?=
 =?us-ascii?Q?y3zej5qUzHqIQvL4QknMMAxxKwlCADNoh0cbInHIphtF7pZvn1Xzoou7XQax?=
 =?us-ascii?Q?XcdprpWvgEvANR4u5pyARKdtRQOQi9f3t0+YWLqpDdx6iQ0CRBte9d8v4B4z?=
 =?us-ascii?Q?PADUWGNU2Gy5WiRfgFVk0/pjdZ3YMt475PMZrayU/OkEcS9f+DmZ+W/eKBYD?=
 =?us-ascii?Q?tUbfWiY5tQmJKqdXM4ddges3Fg6jdLQJDPz7fBnMr+DdFyYfstjB5istl/Zk?=
 =?us-ascii?Q?mvLD1oZSVUEWcHl5qYsmoIBqr7x317VSQKrTe6G7eqcZczKzkUhY9IeMZUeQ?=
 =?us-ascii?Q?w19pgEDaYfRan5A3ILJIr84jRbQCJ9SVJfwrOx3YVV10N2FBGi/kKOr7jl5u?=
 =?us-ascii?Q?GTO0Bl85v5vubkq9M5qLjLbF6IVApuHFYljJ3ICAxfHl7BFKb2A5KsJbU/UY?=
 =?us-ascii?Q?kH02TE0I3zlThdWrFyWpnDwAQ5z7rDocinWoV2PcGQXwTOpAPRCqKY3qOVO0?=
 =?us-ascii?Q?vFV5crtwJa/2K3W1NjqVWyVSlEYzt1SZwbSFkXThei/5oTkqNfXRZEq26nr+?=
 =?us-ascii?Q?+Y2zGANZCeKzhTml1LIDU7K/0/1Fmuudf6Mq/851MAll7Qowyaa4M+E5PgRb?=
 =?us-ascii?Q?kGP3fwzxFOMwlfVNAKQR8uWOD7QFU7lRndgFnPYzH8cIELPxQnaZSkaNjsj7?=
 =?us-ascii?Q?5ANtHas0QYYG6sYZLF/f5mmd2v/nvohQuXJ8pqBJdx28YtZw2YxBfHrywwby?=
 =?us-ascii?Q?AhJkJmaEN2Bg8y7wBIlEz4Jzv9awXPuL6TWhYAuYA1qb0rk+3+AMs5ZIo0ML?=
 =?us-ascii?Q?NM1F+pVIUpBP6e8aqxq9JJEDOEWv7PzxUHzmP+KMWzDzPP/7mGxoAi4bSd7C?=
 =?us-ascii?Q?/zrpVD7Dq0hmQmDgM+8chZXrDWEYFi06CY5HDAp/tY4rQZSR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cbd7d3-6b3f-47d3-8c56-08df01876fc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 02:28:51.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaX+Pz4ChvhFXLcUlPmOyLfQ/SCzP8plpQ3mV1E0gwZV1rhrJKcyFln1tc66sTOX03tDSBBkZvBVNu/EYe6qRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11534

> > > +     if (irq > 0) {
> > >               ret =3D devm_request_irq(&pdev->dev, irq,
> fec_pps_interrupt,
> > >                                      0, pdev->name, ndev);
> > >               if (ret < 0)
> > > -                     dev_warn(&pdev->dev, "request for pps irq
> failed(%d)\n",
> > > -                              ret);
> >
> > Why remove the diagnostic log?
> >
>=20
> The reason is that the error is already logged deeper in the call chain,
> after devm_request_irq() goes through several layers, with sufficient det=
ails:
>=20
> -------------------------------------------------------------------------=
----------------
> return dev_err_probe(dev, rc, "request_irq(%u) %ps %ps %s\n",
>                                     irq, handler, thread_fn, devname ? :
> "");
> -------------------------------------------------------------------------=
----------------
>=20
> Therefore, I removed the diagnostic in this function to avoid duplicate e=
rror
> messages.
> If you prefer, I can keep it.

That makes sense, you'd better add a description for removing the log in th=
e
commit message. :)

> >
> > Additionally, the second patch can be merged with this patch. There is =
no
> > need to use two separate patches.
> >
>=20
> The error propagation part in the second patch is directly related to
> the first patch :
>=20
> ------------------------------------------------------------
> -       if (fep->bufdesc_ex)
> -               fec_ptp_init(pdev, irq_cnt);
> +       if (fep->bufdesc_ex) {
> +               ret =3D fec_ptp_init(pdev, irq_cnt);
> +               if (ret)
> +                       goto failed_reset;
> +       }
> ------------------------------------------------------------
>=20
> So I agree that this part can be merged into the first patch.

Yes, this patch and the above part should be in a patch. And it should
target to net-next tree.

> However, the change in failed_init is an independent pre-existing bug:

You should add a separate patch to fix the pre-existing issue, and the
patch targets to net tree. Patches to net tree are welcome at any time.
And you need to add the target tree in the subject so that netdev
maintainers know which git tree the patch should be applied to. For
example:
    [PATCH net]        -> net tree
    [PATCH net-next]    -> net-next tree

See: https://elixir.bootlin.com/linux/v7.2/source/Documentation/process/mai=
ntainer-netdev.rst#L61

>=20
> -------------------------------------------------
>  failed_init:
> -       fec_ptp_stop(pdev);
> +       if (fep->bufdesc_ex)
> +               fec_ptp_stop(pdev);
> -------------------------------------------------
>=20
> Therefore, I think it would be better to keep this part as a separate pat=
ch so
> that the Fixes: tag can correctly identify the commit that introduced the=
 bug.
>=20
> What do you think?

I do not see the Fixes tag in the second patch, please add the Fixes tag an=
d
send a separate patch to the net tree.

