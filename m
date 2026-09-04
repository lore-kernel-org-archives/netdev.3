Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836C18DB1A;
	Fri,  4 Sep 2026 01:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788486759; cv=fail; b=qPFHENhaHPz05hBk3eaDq3pQVPAVAL2IGtzAUe2SAacw9P6rSywGidgZaykynRriuZ2VQoYpxqjct6sdTyW04Zja6m7fm/RiVx+RB7feKFiMgC10lY8SXLgVZtyLll94MpGX6imv2+xaEOOjEZOV0ExXUZNEit3XJ3meUByKMVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788486759; c=relaxed/simple;
	bh=7Yy9Cak01UhTfPt+MDCXrO6AB9h9gwOewQjiWNULW/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2wojCpcuFhwnWhIwFId5NsLqFmACLzj17VhnqQ680xUQCPnSP86w9VESrje+Oq7JhcWh7Fguy8YWqjxadOnX8rAekMxJMdqC3cl5lznjq7abSUl1gSdTNjJHbi9gcHAnQ4AyAC0jf+x5DHLam79ndfNOSs9mF3mqFbwkxt7JeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S4IoeBQO; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S4IoeBQO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd26TO4ZRyXDngNCVwAQ8qmasQCtMkv28d9kJosngtRKac5prvWXWTIw87HBz4IlZ0ZUXds7tKMz9hjWIcpzejzhQaRP66d6OesYEVzclNeDVPyxuCxagmacDC5EJuIAsAt/Hp6PG1ByaekG9HXXaALDnjSjNyllp2vIPgQRoHgVQPY2sg/NcjBaKVCxqa64q0BFfD/twgnxBlj59H9Z1fssnaz+w0i+ghJR81c6OCwGF64RU7Kd/GamklFmXvfXdV22renlJwOeDGRBq/ixo6rqcKyiB6oUIgxuAWK9rSNcEpyfvCkVsrpCpmUfu+ktCFreHs1vta3sDX/H/02yLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Yy9Cak01UhTfPt+MDCXrO6AB9h9gwOewQjiWNULW/4=;
 b=DdrLQ1I8SVAe9OmPyrhiqDwMOyoDSG4QW3EmBYuFCd6oO7csalfonY0WsayTW8TO2bB5bsoU9fmZKfWpSHrVubK4ucQI5BDhVyQGpLi2VTwrOCu6DXaAvoysCOJughWeCvkt1CBhceEPou9vrfi5zobYr8/6FSBx1zAcleab7EB70B+HnALImDLgnChclX7ct+Z0NYXaJ63m+vFVFzTIq2p6aywSsPJMOChBeMcGA5uj3ej55S3Xqs4M+FgmQ5nUHGr5ZKp7qeEbTh+/UOZEH+AkGx72E6/1retKL891kX759nvsN81V6m2RY+kpt938LYXx55h/U5szbRyMUH05+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Yy9Cak01UhTfPt+MDCXrO6AB9h9gwOewQjiWNULW/4=;
 b=S4IoeBQO0vv1+m0rL0DDOsJXVc3m5PbDUcWnA/vbvAweG9ZPbo7uOuleh0sUqDI8X+2wwUJpwNom8xDKyiQUmlnjmIIRLD93z9RECkCiRGsgV1yHCv9VcuZd6IQxxjqlnHDiluqQflT9ouuUYPQCYb764EGBOXfjqlwmohHlZyqscgIe4arOaJTPmsU65mGGdTObOqTB0WKNmT3fPhNpICZ7rB5AV+prW0d+5efCW4DxBoyuipJSf5/WEJoL4EjszNdu2R+iW3jt8faQTfvl7PEwn1+4eNbPmo61xyTAS0QbP0QTG2rzP/dCJCSWuAQy7O3QxZ+bserZA5zS1R0Qlw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB8350.eurprd04.prod.outlook.com
 (2603:10a6:102:1ce::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 01:52:33 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 01:52:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Anson
 Huang <Anson.Huang@nxp.com>, Stephen Boyd <swboyd@chromium.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH net-next v2] net: fec: Propagate PTP initialization
 errors
Thread-Index: AQHdO4YioAnO3amvG0aIHgRDjya4dLa8lc+AgAAVsYCAAPvFsA==
Date: Fri, 4 Sep 2026 01:52:33 +0000
Message-ID:
 <GV2PR04MB1173931CA07AEAB48339FF71588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com>
In-Reply-To:
 <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB8350:EE_
x-ms-office365-filtering-correlation-id: 7903dc02-67c4-4cde-07a1-08df0a272fc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|19092799006|376014|11063799006|22082099003|18002099003|38070700021|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info:
 dggaUXAQiD1dkkdk5YEApszIIlt7KiFQQsmoTA3TheyU55Wv7O3z3vFXYDVWybXoSnsQiTJsFe3qYircHNDUJU3sQ1AVugbADYZDEVFzNgRAb+h0zVk2XativGFACTXkn7QqDCTDI30wZgQS3GFKsBcQsZgLrtoV6hrIDUixJi6tTdHt14wQKwTAvTLFhxMArlUpnYohlL1STvUw9xl7TTIcK4NhCfmw+Bs2Ez2UwAlG51g1VyYyJfYQIGqQu899fy9ru/pYFW1eeK04/l7XZnM2BjbHfaKN92weZXc4+S6gaacX5XUoPPy+ISrzjaJU/Iad4Iu5LBy3H8SACsuFI5M6U46tZ8wbUs+OwfVqMPCVMVzLoI7bZmjVnGHaO0oOTu6p76JJrMgNDiSluUEacpr1n/5h6IeMoZNiKhB+wLjuhjvzrKwa2IHYc1nM1d8OJODrpXExs3V5IX0IAQCqXECBo+NuSiVE3oSKil/sxu2gx2Ov8Y3DrDgU258S2xTlFncWw4gwkK88wrxddz16mmHRrMQovwC/I4u1PSXodac9e0Mpe0ljSCUQ+j0Nvm0VE9F2WC00fOiyE/cU0uiDOxUS1R8FLNH0kxnBojCIT02DcxSubevFcDb9fDSSNjcq/XdYhKwvCVOjMMRWGoiEnA+rdXKqG1Q04yPvGUCsIgNFMtOYU53UWkRL9Z3jBzgYuXuknzgmyUcqkQ6LPTFIXukwPpoOJxAsCGtFzMeadmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(19092799006)(376014)(11063799006)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ugEVR90yxRfkHzAOeM7JXBfSE9MgauioA5fPbNJxoE3pRjlW1gbKQxHZQDy+?=
 =?us-ascii?Q?N5QKPvbJpgUzoz21QIhBmZ7w+d9Vu4e+0sqzoC8ctURT9wiioQJFIyMovLJs?=
 =?us-ascii?Q?qOfL9fJn+JZKWhodC/NYI1ep2SqP2DUyXyAQC03hEV0toxYzNJCG+cVN5k3M?=
 =?us-ascii?Q?a6ad2BtFC7N9PfNO5IHIXIXITuPXFFmrjvAuIB88H00fdMlQF6eN6LI+S3dV?=
 =?us-ascii?Q?EIJHL1xxe0+9cWppkg7uZAMRXXPd22JHTWbM3cjTbInj036lPtnoszE+stZN?=
 =?us-ascii?Q?piWIzzB2Xn22AxkGMzhJ93mLuBje1gilYz+fuacBo6aMT9M1ZgrPul1PyoSY?=
 =?us-ascii?Q?7A1xTImOadnb+ivUoFH/202BBy8m+A/VXpImkzYdaYr/3ufBI0G1U6xo1Td2?=
 =?us-ascii?Q?qxXl07AlTK2YaJSbhzDqrX3Frt+3wf3jg9L72SG+pbOD+YrOiDkVR4N62Cz8?=
 =?us-ascii?Q?s4No2ov3FUaVocuFz+ebETSJfTTDD/FOec/Jk47KDVD6h/3y/XRfw4Nogn7f?=
 =?us-ascii?Q?Bm1v/Uvjvf1FFaB2Vn6TZw5NeooRr5s0tdsB4GLMt/PFq2Y+4FO5lGM2h324?=
 =?us-ascii?Q?0/1cV3blA13OS9fxehSyllOk/fLPYFfL1BKsDph84B3EwA1MRrRPYcxyKJZO?=
 =?us-ascii?Q?djQZoBeB9AbTHIM9k3B0oQgVJr0KZl5VO5oh/1RpCy0ndZgpkGsSs+k3FHN5?=
 =?us-ascii?Q?60jPd7rBPzc0XL0yp7WaQJuL8JLQVrVYpf6eHcZDFB+SkHJugpsMeu9bwN1P?=
 =?us-ascii?Q?OL8gKuX0D9DHejbBmpTG/EalGVmA+SxZbbHp+uz2QbHZdPwoc1qfRFZvd3uz?=
 =?us-ascii?Q?yPaot3YJd99vbDEz3jrZ8VtP/NiThsIzVSPyDcV1/7w0yDoM7RJoEO3qjHGi?=
 =?us-ascii?Q?6kxi3ofVfkPWIuBLDms9MT9luhwDPXlw9+LEQOHHpf58ls1gQf0zk45AfFm/?=
 =?us-ascii?Q?Fl50Ohj4znICVZJi9Q0h/BQjJwXCamilRp72Uf566kHkNqLUL1qwZUsIfE7N?=
 =?us-ascii?Q?Z9k373fG4QGHTgqNY9nN18z699vBYvduak68B3lhWxhPO5CEe2INQHLG5RkV?=
 =?us-ascii?Q?bJMBffoz+Mv4tIICwfKy6Dd4zDpwpp4jz3hsuRwKEiGtJoCQS/WVxwiojfCK?=
 =?us-ascii?Q?oXQB9OifCdH34+bDHfFEWUO+IN+ZiqcfXutPCbzneUIwCarxerRue18Ga/gT?=
 =?us-ascii?Q?dV3pSQjectPSxLnsxgFSDho2tRvUtEPkS6uqpFLXn5A2jQaTVs6taTxIqCki?=
 =?us-ascii?Q?hZkHDHfrLZjfH6AUs59Kpgz1EZj2mQJGPgw5NPkve2mfdJtkwiSRJz+/t2lL?=
 =?us-ascii?Q?DW+vMSLOL7JKAiFpGeLexKZ9q0DOfVoypp1d3mDHc+LWNJ2XA7CRRChwXRe0?=
 =?us-ascii?Q?4tUsGiTPFxSo2JwyaGgiPrGAAklTb/ZEpWTlQ2lApnx61mPjLV/zwC3hxmWu?=
 =?us-ascii?Q?Cy2Gy+rMT/0Rs53/f8K0GawzUUMpKpcpbZ1Is7/CwTzEAzAzMcQUHAS4pAm8?=
 =?us-ascii?Q?VtgKnupp2XkAW9GGb4QosWtt6xy6zCN6kVzRjoSWE5Av3wqzgQfMNHNpo7QW?=
 =?us-ascii?Q?OJLZsmL4bjAc1J+VjoD+3ocfDiInWOh4+k9+eZUxxf93AH660CNi/aRxImIK?=
 =?us-ascii?Q?jv65C0H/K+1CCUD1zAtMB2paoXWwgA8qfqI+E98B8N/zP7U4mgOCv26MvREY?=
 =?us-ascii?Q?YI9WPuPTH9ErAi8Zvad5bSg/I3Hn0LmxltSBpuuLdVAHR+j8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7903dc02-67c4-4cde-07a1-08df0a272fc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 01:52:33.0988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2RIOmduAZ8C0dz2cWUuhR1K+MJaj06QAniAlgdpsTNI5SKtRAqXSCNuzrq53aOr5hDgj60t4OpHRep3klk+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8350

> > > Fixes: b86bcb299092 ("net: fec_ptp: Use platform_get_irq_xxx_optional=
() to
> > > avoid error message")
> >
> > If this is a bug fix, it should target to net tree rather than net-next=
.
> >
>=20
>=20
> On a previous (different) patch with a Fixes tag, I was advised to
> target 'net-next' instead,
> so I submitted this one to 'net-next' first to be safe.
>=20
> If you think this fix for commit b86bcb299092 belongs in 'net', please
> let me know and
> I will resubmit it as a v2 targeting the 'net' tree.
>=20

Is this a real bug that bothers people? or just an improvement?
For real bug, I think the patch should target to net tree.

