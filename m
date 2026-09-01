Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397D442385;
	Tue,  1 Sep 2026 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234057; cv=fail; b=WBJGK2xgjEbluVoGkFf/wH7mk02f6nFymaIYC80HPdXwuktevwQkNyIZFRh12oa6jdWAgYnirtObV4fnapRQIItWQbPIWZthouCWgFO4CKbCyxRNyYYThIpIL+shZMd2Sz7Hk9D0i7MDfsI6ewbZdYLTu1k/09SFnk/s4mQdorA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234057; c=relaxed/simple;
	bh=gPiGqB73uWW35dfrJ+wPy3XXSroXFMYCnCpTk+bPWx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HTcXmZETYeUhg3AhAxGrvbI2Wq17iQdTB8uYe5xU7HWq8mTSINo/LrvMiKKURtbvAmHo4/Afd0CgYRZI8IxLM+ZdnIRxcyjNCVpwS6uVQxU6cjDa7byoPuo2kQgurdGkJUV/eKFghhR9i1sHN3C1IN3gmXgf3+XEJQPmou2bAm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iy9ezOLR; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iy9ezOLR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJxDGw+3f5wBlVU6rzH4LGgOGPkPn1u4XrkErtGLalHh6ReM9jLN+wM6NZTGI4CDUEEFuHp0FkoneHKHzHNBTonrh+ukH6xvIKsyyG02ZvjbqpJ9PKYewXspaZ8/j9wtj2iWLk4F3bWyW7Zb/gIo5jmRh3Af6Nv+8xa4qkLexLj4hNylkx428hQVAykbvfGdfaNkDU0F0i44mC4QPEVrepJ6hQLs+6GTN5s+r5mY+508sBwMdpou2Blj+p6+JxRfYkF9omVv7S73rRQuWLg+eyHUcgg2/Z3UuIkNtLZdYHJCriDiEUxngGj05g35anz3Gyg52rGKr4DwhUBi0Gfl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPiGqB73uWW35dfrJ+wPy3XXSroXFMYCnCpTk+bPWx4=;
 b=zIzfzRi5MMKAiscCKFbiZT9YGy1kPhCwJvcUp5CFFPTMH/mh/xSSiPWqPdC0j0wAkLMRN/0PcgeyECQqHym7EYGvZe7fa9TDS4vhZfrcQSWP9x9XYbAsH3F6YObOhDttMzx30Q63ZhUifJrTE6MSx3o03Y+uVoiWiwSGxpjd+e06cXUWUU+ZQyrHaIaIxUWbbqUCAziBRsTT+XSS74nyXFo2yZfwoH7pjjFZcw3o8MiDDnbsiPTKXnwdCVpoWCWKtmBdRc0A9ehaxrZd9Q6yYb22QckED4JErBCxC30dQVKddVtT2nTBIG8DWpThGCT44TZbPQWMHdz2pOIPdmBOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPiGqB73uWW35dfrJ+wPy3XXSroXFMYCnCpTk+bPWx4=;
 b=Iy9ezOLRdl4Fl2aqaWI5aQnxd2H9c+WnqVwk1CIxyp09A5wH/GjfKq+dGqJS5ZuvPK9qWn2EiG98JqiIYkig5OOLHKzc76/WKBXjdrDD7xrh0iFuxBuAuIShVSgyQdLnQZowsFDravWFA2hDuA18e+ShiW09e2OACPuSh8yeaV9iQkWCJwv9U4SVyTV0Q2JYBglTn1tDFvZ0HVONRShIg6pJ0d6WG8NeEGX6udDzEZoAXM/wISLVJ9WYB+3Z0KYLBRvr92rRkeRTUeDyd3q3CZMPCY7f6/yUTH+o8+pU+TAk+JQBke9Mj+Kz477raptMpgdTSNCAIDZ0huupSndH3w==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB9470.eurprd04.prod.outlook.com
 (2603:10a6:102:2b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:40:50 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:40:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Topic: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Index: AQHdOPf5rPAr6++Cq0ud6wQBTmAapLa4DqQAgADuDlCAAA7ygIAACHSQ
Date: Tue, 1 Sep 2026 03:40:50 +0000
Message-ID:
 <GV2PR04MB117394708FA31D89E3B7A171F88A82@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260831025441.635045-4-wei.fang@oss.nxp.com>
 <bd07a661-857f-421a-9ff0-e807aade9543@lunn.ch>
 <GV2PR04MB117396D2988C68C961868A8F388A82@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <123a8343-9912-4b57-a402-08bc18748ff7@lunn.ch>
In-Reply-To: <123a8343-9912-4b57-a402-08bc18748ff7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB9470:EE_
x-ms-office365-filtering-correlation-id: 10a22b0f-5d81-44c9-6bcb-08df07dad145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|23010399003|366016|1800799024|38070700021|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info:
 2rzd6Uc7aSZ3SFHgPgsihAxgG1hMWdMz0gWlUPFwZ2yFMHeh/LUQ/JelLVhDmM0Rj8e4Yi/UEOgJbhTX/0psng9LG9Dox/2CVGuukz3CL1o8Cu0mb467taOvso1RD/b9ZJqAepm6pE7EYbWYfEsNniCe32ypCGAA5G7sBvDu/D6RINT1vcAMdCqWmGu6F/YtaR7gv7Ebgz3HmaSQ1ZK+R+jPza/4tDZnDs/oqhqulEn0hftF/EUUf2ZM4oxfaVkSQ/2/uFxOic7veCxgXzOAuecsmdZTRtZhVEsUqMZBWJKZhkpaxq8bQPmxF+PFSO89tVz8mb43gwtkIykfNCXaR+XL9USofX7uj+W4vSPuCwMAirYzKOTP2/sBpFhYnLkKg3y1E2ilsDaSWRAsU9Q1XNMboBZjiKfQEUfkgDAcaFz1RCfDNhh304WbLhLn5o8rXGFMDic2hw+DaivQWB9jRT0dHzQkK35MGMyLWtiUYaKaUEiFS1cY4zHh1p5R/UdX9yTOmGXKSK6cjxYaEUBMyp21ymrDnbGOqATpwNsW9S4Zr9ElidrsVtRZv/6W8g19luBHVV0L2Bbygp1ReK3B8rq98n9Ghgy6GNv2NdAweCm7q5JLmrF3ergMJoQN5HdcCh+CRmAx7IMKQmtHQZUjo8TC1JmmEHtHAzsrlanyZj8BjWpBU/f2PIQ852bpU6l0T/KdcBMXYdOKF1z4gtErEwd0lSqaiTJvu82RTy0ORPE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GYcRUgcx7yFIlmq/sb3bD9NpCfhP9Y28P2oJhMCdr2Jjq/YUA2COqrSMVswR?=
 =?us-ascii?Q?SGFHYso4XHEOe9zHQy03StUK8uzTTYtOOUjsTKydCtLFPZ1pGF/DKjztp/In?=
 =?us-ascii?Q?zGyJFVuj0ugK0cPCYDhQtAb/p5zC2+g8vA0eCxJdsxMvs2COZYKGN1NISnpg?=
 =?us-ascii?Q?6P5dleUZLAOa9W8/APQ8gV1/KN7YWeogv3MhGOGgqb22NL2b58dm4dtshj1J?=
 =?us-ascii?Q?kdaRmwBqHd2Gp7G9Hujbb42gO4SvBEk0GfSALz5vOXcXAIAhbVyYKkjyEzac?=
 =?us-ascii?Q?+cgw+KhPR/kmc57txVcfUxavIDM66IjazdmBFC2eR5rwnXJQICat92iO4qYb?=
 =?us-ascii?Q?9fmzNI7CWZhPUW5QcY6a9F7dePMTeO//t28jEZsImv3qAGJvzyoHFrju8Mxf?=
 =?us-ascii?Q?Zki5+Qz0lN2w3UALrvaZvAPWLWMV+kKZjh02vNQLIGAk8YV3EplGmrjMp7Ws?=
 =?us-ascii?Q?Ue04xCzBwS1UYAqBbKVlnQN3LyC9Fmn6BJ9tABs2zhLHKIS5hEA0IJcRZm5U?=
 =?us-ascii?Q?9hYFDIWXO0HlHkNTcdWDCaKoo+j3cQw28wo3bYKY9v2fGjFEdgaFOQEGb/eH?=
 =?us-ascii?Q?lCKTIUnwC1bZ4AsyLzVv2RP0eJlnYlA4H15NbRWVEHsFq0QePlls6Vs3k9oa?=
 =?us-ascii?Q?16+5NtG524C5KR51ZYnuIYWu7G481EjZLDjqF6zHIXk3fyAoZZhyW1H5Hy0J?=
 =?us-ascii?Q?82OGJZA7HeEppiTjrZ8gvpvXUMTJjH3JvVDbJulyi7Bn2hDTJ6lDyilTrmIR?=
 =?us-ascii?Q?/CMH28urmftF63UAhnKXREOJNTO1/lGMTPUs9U9YCN5timcVC5aEQ/2BJ0dz?=
 =?us-ascii?Q?9J97P04l3qO1fGjBZhKr58e2/MZlIfyOv0+Ulg1MuO8Cgtn/scc8NsD8Ei5T?=
 =?us-ascii?Q?l3vullm9CmeSIran0kmDbKtVPmaGgnszISb/o01InTFSSqRPNI3DLx/bkgVS?=
 =?us-ascii?Q?Y4iC8kLC+6od05k25Ek8jnHQSLDP/0PrOM2WR2xJNQXD63ERz+U7uD4a5UmZ?=
 =?us-ascii?Q?85XWT3hhxIIeyb8WB9N7P1afX9/TT4cSfP5QmMun/VyvCqdwo7Dp7tKqREGt?=
 =?us-ascii?Q?dTVaVCqtrrsqG0FZHCQV0+Cqs695luhI2FwuckC0PRkEGfY9/NFUnNHkYB54?=
 =?us-ascii?Q?X4Pb7TXSLVAu8/9BYXzORwLNAWgbCwKC6hsicT9Xea7DvtTERNa3zn869N8W?=
 =?us-ascii?Q?vl4O9sz6g64qYlDxOlasmWynw1LvM9X+SRW0+ndU9SSzOqL6e8DxyOhrWPbO?=
 =?us-ascii?Q?pnyJdWrBDAVstNCB6uIjfSjwEKOPMWl98acsgI5kW6KHiBnQW3ThALaXAglV?=
 =?us-ascii?Q?xdmMt1ACaKLd7YavVn7eCnNPOn2wtJg6bR9pHSiwObhT1Pd2hMUf/p+dvvgO?=
 =?us-ascii?Q?Z44rkIvOH2nWQCAoi7Uh0vlfl/UtYV7J7CREvZ34GtvgNC1ZmcGk859zQJ65?=
 =?us-ascii?Q?3x8nMkVBbBIjLUfG4gY9fUva0aovZXCQsWUfNkjRDblKIJX4dAyXXVzPDdIw?=
 =?us-ascii?Q?Z0uNt+ljqKzTj5SNk+HaBf0MnxuiXcTlemmJxBRh1//6qVOri/K8GIQa/Uha?=
 =?us-ascii?Q?+xREGN4G3+Pfi6ENVr7IHGuvDFikHhy68JPVCjanD84dRY4R12oTuOOb80pI?=
 =?us-ascii?Q?kEGB1JLi6hFzomLiybOh6N1fwQ49Ut5PKZO3N9e1LX49ti1Yjx9LFtiO+BAr?=
 =?us-ascii?Q?NahIRdtxhYQ34eWQoAt1h1TMNbZHoaJ4Tl/DKjNxdb9tPHXh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a22b0f-5d81-44c9-6bcb-08df07dad145
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 03:40:50.4999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeTGxwVpWf5AQXMDFFP3JaX+UWDeGCliO4nIlOWaiPcWMt7yqOYquA35IWM3tqISxU/SkeYJJRQ4PMZVmEHcGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9470



Best Regards,
Wei Fang
> On Tue, Sep 01, 2026 at 02:31:21AM +0000, Wei Fang wrote:
> > > > Add link status message support to the PF driver using three comman=
d IDs
> > > > under message class 0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS):
> > > >
> > > > 1. ENETC_MSG_GET_CURRENT_LINK_STATUS (cmd_id 0)
> > > > The VF queries the current PF link status synchronously. This comma=
nd is
> > > > not used by the Linux VF driver but is intended for DPDK-owned VFs.
> > > >
> > > > 2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER (cmd_id 1)
> > > > The VF registers for link change notification. Upon registration, t=
he PF
> > > > immediately notifies the VF of the current link status via a PSI-to=
-VSI
> > > > message, and continues to do so on every subsequent link state chan=
ge.
> > > >
> > > > 3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER (cmd_id 2)
> > > > The VF unregisters from link change notification.
> > > >
> > > > For link status message, the PSI-to-VSI message is 16 bits wide: th=
e
> > > > upper 8 bits carry the message class ID, and the lower 8 bits carry=
 the
> > > > class code. Bit 0 of the class code indicates the link state (1 =3D=
 link
> > > > down, 0 =3D link up), and bit 1 indicates whether TX PAUSE is enabl=
ed on
> > > > the PF (1 =3D enabled, 0 =3D disabled).
> > > >
> > > > The TX PAUSE state is included because VF RX BD rings support conge=
stion
> > > > mode, but whether the hardware can actually send PAUSE frames depen=
ds
> on
> > > > whether TX PAUSE is enabled on the PF. By conveying the PF TX PAUSE
> state
> > > > in the link status message, the VF can determine whether to enable
> > > > congestion mode on its RX BD rings.
> > >
> > > I see you have hit the 15 patch limit. Do you have a patch in the nex=
t
> > > series implementing ethtool get and set pause?
> > >
> >
> > No, we do not have the patch to support ethtool get and set pause for V=
F.
> > The link is controlled by the PF, including TX PAUSE-related configurat=
ions
> > (ON/OFF/refresh threshold and PAUSE Quanta). The VF can only passively
> > decide whether to enable congestion mode based on the actual link statu=
s.
> > Adding an ethtool set pause interface to the VF is meaningless because =
it
> > cannot control the link or configure TX PAUSE, , or rather, it shouldn'=
t control
> > these.
>=20
> Well, get will return what is actually happening. That could be
> useful.

You are right, I will consider adding a get interface, but that should be d=
one
after this series is received. Thanks.

>=20
> And from what you described, it sounds like the VF has the option to
> not enable congestion mode, i.e. not send pause frames. So you can
> implement a limited set, returning -EOPNOTSUPP under many conditions,
> but still allow some control. But it might not be worth it.
>=20

