Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF483911AA;
	Thu,  3 Sep 2026 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427756; cv=fail; b=CEU0nENdbF5FQuU8uxIPrOszspLjZ8mPkbZ0TOZZOGPUl8LBnasLKwjP1r0VSMN9vQ0Z/Qu/fLCRb1sadlQLmceXFqPbQH9CAP0ctySaL4Uk2ehdLwUUnaN1JcIfS6bFs4J2u5WYEAmuK7davIGUYSjzloPrDZALk9/kXpCZ1jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427756; c=relaxed/simple;
	bh=+zSN0NkrjUkVSDqdLRL6SvqjC27fBH0beCQTyK5k5L8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VHY9xbtADCUUJBnGIvW/FSw6YJmc7hCFu9rw3jnNWawHJQFpW5HSiNS773GqXJ1zqwSaNvtV/HBQT027RDPvVS9xe0399Y6fekW+OrPNT/xYSVuv7KPM0PK76m79ENTc0KDv+Q8Bk60OGg+eZjRNEmDysIQTl3Yf92JX4p6Ry4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lfeDLeU4; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lfeDLeU4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+8pCqevQ8X3aTEecbUqdgFMSh5/O0V3PKS73PXy1H5iuuSstpSc9wfZC/4qkGbMnfI+bRXpGS72YZPpANHz5VhrBgoATUqGFZTo0GAwLSRPk5z4w+44iQMNpN9JR19H3Can0BF3pbYcOA8hUFXnCoeCkWBBuDxc6gtzOtvni08uBigH3zTyF+JN2tHiCFnhGQsB8hCG6RFMWW0Yx3A5VAZSJu0ZxyDQVSV3oZuWHivOYz+rcBsvarD73Fbj36O5TAUGbGMFRYNlcN3GPvW9n3YRdFA7Pt1ImQMSQE+u7XnZ8KhqAvOc7b0tRtUaWOg1L6pJt1IX3h5xXhI9CjTdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zSN0NkrjUkVSDqdLRL6SvqjC27fBH0beCQTyK5k5L8=;
 b=YxnL2wpNxks7pxcJ6VSb0JEdJx4y26ULTUVpC8bEqmTwSDXNRPb6I8Ztw4GZCx7dyULoumbar9mfeXuDDZRX3jFhPgNzH4dA/NmHw/+Mkfs/kn7gGTUWXECM4cEyxMcKiG9jJx5UnCLqyfvDKBFYWWZl4O4ygUdEwF7RCJ0K1GEQ2nD/dRWqw3N1u2nySdVtGtAEagUqqtpMxtwUPHlJUW5wGr5QGJe+xmLBTrFbBuK5wfHMdPm3xp3eV27vuKyRIRropuAwfq97Z6cO+tXT6KcbloJnWl/9HfUJUlpO5YsHHxzQAZmKiIW7CtxCNW9R9Ansi/RRxOEtzehLatFeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zSN0NkrjUkVSDqdLRL6SvqjC27fBH0beCQTyK5k5L8=;
 b=lfeDLeU4yByxWg+LBPO8Q4GVJXzbQCAvz19ZkouxGULV+vdrx/E3FagPZ+4c67LyvbzQjfwXJL9ZP/JHRIuraaV/mvKVjrmuekTEId0ahlhhsql3KUhbIDmDlpiP8UrX8HdY/FF3aGJosoXNXnowd3erw/Yu3OCtLPswCMgYi80MKrrJ+L1myEp7dDBsvGorK7gp+2T92aUnRWdXKYVWaMeFK50Ur3xtLaGfnSPB1VKskC9y0bJcMUdy3CKBQuFSkxTUPhAgUw4+Z+cBD2ikwS7RmH1TxJkxOGAMWw4EGXER/d9z1dTrqKNfKM/3w/d7TUqVrDehHsSwIKgP49UwTg==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by GVXPR04MB9780.eurprd04.prod.outlook.com
 (2603:10a6:150:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:29:11 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 09:29:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "phucduc.bui@gmail.com" <phucduc.bui@gmail.com>, Frank Li
	<frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Fugang Duan <fugang.duan@nxp.com>, Anson Huang
	<Anson.Huang@nxp.com>, Stephen Boyd <swboyd@chromium.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH net-next v2] net: fec: Propagate PTP initialization
 errors
Thread-Index: AQHdO4YioAnO3amvG0aIHgRDjya4dLa8lc+A
Date: Thu, 3 Sep 2026 09:29:11 +0000
Message-ID:
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
In-Reply-To: <20260903092430.354186-1-phucduc.bui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|GVXPR04MB9780:EE_
x-ms-office365-filtering-correlation-id: 5764e092-0898-43b1-591e-08df099dcfd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 7ELGowrGir4RnnBOBN2WgLtmP4Q6paO54/SGmhOo5z4Hy+mSaVNtoKv7AxILUeTS67E73aul4IQ8mRpCGQA8AcPn+yz/PIGLQPeuGf2TDMAJy0iGyiBqECUyjelPJ+yx1AmjLuyFa/bvlosaxNSmpojWJlkNzexW4aw7FFAYbV01VtjTOqDUvbPhzXBHGlF+IWpzqV+s+WZugz57L8ACUAuw5bSa1Yva+IW4SjYzXx075V9Jhu8yDdnIBFjw2NycorTaeHUmmUlZnwIj99NKyOFJv0i5vrU/2dcrDcJ1o3GWYwXpeP3zo1OrgxlKoc5ErzQY2HfPWFzgLLg6CVpeWd7jRxHefvS8PZB8BkZTvoaXmEaRXxSlgbIemnXt1r8hP59PJ5l2k0VVuqQ9zC3hdZuNC2bx6MYmUh0XT3wem+lBzVK5rT64b9zT/43MBiVvFv3C6Sqlu2g8IJ2XnBFzyRIz9bHPa07oAE0z36M0KTGh+1e2aeZVeWwq6sLauFkPIZ+QhsfiwOK+SMK5n4oaYmDyIep5iaD/8zTpFn39eLQ579jMzBBmHjbYK20+INWQGUgvUq0/sJRZJLq2iMoHR2j5lKURd4oSoCAS/476Y4HQ7qMTOPfoSUJczo0K4dxt6MPOku7CmNaoegCIkBsp1/2z4CD+HqBkvLaqWamnVY5Gyy/oU3yD6tjsYUDMUYpjpkECyJIH0GnF8fl1o2kczVKzhk8K67PRi9utKHi1tMo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4zdl6SdmpQ1lD4iW0AhdbGMCjxjkFJW7XDRdjTNvDecghlypYRk1Ruog15S2?=
 =?us-ascii?Q?EgFRnkQLhh0NyLk5yvcdKqr47gudBbRk5+aOHo1fI1GQ/G9MQ4Ihe5NbXsEC?=
 =?us-ascii?Q?M7h8ZxsV54IwmXheBVzm6fepZpQzXVaPwk5UipKbjcLENjmbhLVQdNIAKqi7?=
 =?us-ascii?Q?H5sprsOAMyUcwmQY1ErtKAZBtpzOPxveuFNRHgOeF4+4BsU1jDwp613tmruB?=
 =?us-ascii?Q?kwm1cJU/oJzQ5SWo3pCkYNJW3nCcRphUxdWuHiM5ZFUuAKRkynGm4NefNyBe?=
 =?us-ascii?Q?NCvdoBF1n8nDwSnS3Emk+c3V/zy1L65JAVdnsFd5Xf8oh9iLiGXJur3/BAig?=
 =?us-ascii?Q?5g/8xe8vSQJDCCy6QkEUHDTKndus9Lo7bloLsUIUrTk34SpCHjKx5k8Hng1q?=
 =?us-ascii?Q?gNGeNvr8NlYbbPsbhctF/qwmq/exYecm73i9EChnVRwbR5Fsjr2+qp/7E+kS?=
 =?us-ascii?Q?SqvoYSYXUIMgMoo9W8z3A2crpg/oIUy4mosF0m+JCmJ7zh9xS6nuc41BouW7?=
 =?us-ascii?Q?aKxsms9JWX7Z3+eNzPtv6eeee8Yfv23OvGwIusOt5vA6Xwx/nIK0/PBdNAZe?=
 =?us-ascii?Q?49nUBYR2MEU4/SRoXg6aBdGhZ3N1QD4S+b15bcAfEwPI4QjXlQMGTU4jZLkn?=
 =?us-ascii?Q?ImXR5BS9qEz1OCsXjXzH72nrm3zvIO/1TxNAbCIKctSiVOFM71WzVaXnWPAz?=
 =?us-ascii?Q?bTNuLfG1aX6D25udhA9hzwKGA0lUikkUG471R9DsGuve2oMdsCSEe67SibPc?=
 =?us-ascii?Q?FnwTG8u1VBVPasU9Whcg0KbAv4wvq8rMHRNE04pCyVQLf5dqS3dgHrFKXTNJ?=
 =?us-ascii?Q?sBAObK8RPzGYM3GUN2Grk+9U6Ezj1deEoGTA77ZIrKkPp9ZN4dIri5kTfoiJ?=
 =?us-ascii?Q?K1BpcdTDqOg8yOMITGjdklm5GF+K10EMVXyoxY1u3et3d+wiCHRQZruQVZOO?=
 =?us-ascii?Q?RHNeILTlXN9xkhcAQJz7/odK/dMJwEK4tzGTkqOJwnXkxugLexspDbsQ82wG?=
 =?us-ascii?Q?1ODq7gG4RiVBw1nJZJSo/CrHzsEedNTyteG1URIWPvm8Gj+0PrRxml9SObvK?=
 =?us-ascii?Q?OtQ84N8ekVChdj/shNBteu9XpCuGJjXL4kUXmfQH0z2G0NzHxN/3lMkk6M9o?=
 =?us-ascii?Q?Y1/zZ4imtJ2VaQ7lIZHkYbW0ajnoBVqZu41tNoKLpOHCnxbqwSUSPtrmbfK1?=
 =?us-ascii?Q?7abLW/NjnidjeBQEU9DfeY4JJBKOOjTLxlr2rh0hrAOl/pKRB2m3rVDzb/ej?=
 =?us-ascii?Q?TPkmnVHR7ksUw0U3I2OzCoZhzgq48E6JtcirbBssmddJZd42dJlxmAyxnUW8?=
 =?us-ascii?Q?i03Y30sNnjIk94AsdkvF9bnnW6+XzjTMXlZxxHJWVpls/H+6bwAZa9j6X66o?=
 =?us-ascii?Q?G02pCscH41mPZzkqUrmN6eTie9GUg06So6HsFvml5nSZWmEwYRTC+vHmeegw?=
 =?us-ascii?Q?MrEpp4Ee/HH0TnKQfPUBfrtJHtg7PE4MI1eiFku3j2g7rswrWJe2rg7chCLd?=
 =?us-ascii?Q?8MJ0X8P/FscJaHMUUh/tdH7gU9C8fqasghYR0uRgyvf8hEAHloJIDEaxzIv5?=
 =?us-ascii?Q?y10STvQXaK76LobPULB/n00mnj1lOVqL5LmMSsHroKRD2C8hknl3pe0cLDQZ?=
 =?us-ascii?Q?zvQhJnkEywiydbLWmey15i+zwoZe5escGRdqwRyHS/FIjvreVazwTgMDFIb3?=
 =?us-ascii?Q?rfH0TviKnHEbXCYON9bPQPZruX6AzqnA0xJ451Q+blY6i9QU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5764e092-0898-43b1-591e-08df099dcfd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 09:29:11.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Lw4dWfP0+XHKO8UdbtbFnH6/+KI8VfP+tlj2ODNV9gc3y4/894MKSX+tHH0qqUXtlucCXL1SwyZ6FhAtBO0Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9780

> Change fec_ptp_init() to return an error code instead of silently
> ignoring failures during PTP initialization.
>=20
> The PPS IRQ is not required for the FEC/PTP functionality, so its
> absence should not make the probe fail. However, an unavailable
> optional IRQ should be distinguished from an actual error returned
> during the IRQ lookup.
>=20
> If a platform does not support the PPS IRQ, it can omit the IRQ from
> its device tree and the optional lookup will return -ENXIO. Propagate
> other errors from the IRQ lookup instead of silently ignoring them.
>=20
> Also propagate failures from devm_request_irq() and ptp_clock_register().
>=20
> Update the function declaration in fec.h accordingly.
>=20
> Found by manual code inspection.
>=20
> Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional() t=
o
> avoid error message")

If this is a bug fix, it should target to net tree rather than net-next.

