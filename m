Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB83A6B71;
	Tue,  1 Sep 2026 02:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229888; cv=fail; b=YJdNuAzAwX8rEH6odBsT2SI8HnAnyM4z9dLGh9hVarihVYKsU4FC0RqigoM4THhtyaZVSQKyn0AUAakPpFrFkZDxdtNsP8+XkAKF9YOOLWuqjmH6FQg7GXgdcDrgQ1AkneoJkeAaDeGheOZX/4Al034PoYTxWq0JTIW2C0SG7Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229888; c=relaxed/simple;
	bh=SkLpcUxm6dLGLmTdHEly1kwTZ2cKbx+N8n0o+4g8JrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WRSmApMN9bTMJThauTq3LW0eQaBvMPGI7bASlf8w+P9JA5LQtfmUaxNN5ofJljrp9aLo4JhfqpMxwGesr4wMzD261E8cve1NE1/1Hy2LqQEh25YRgLsyjQ0aTs8kXc1CF3UuvUD7cBpWqCXdynQpo0vJPbfxl8X6qhcvY4Qnx+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e3f+NcDA; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e3f+NcDA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKquj42+MzIg83hZCXD40ryhxOXQCUQV4a9ddpO1+gzh7I3PlJXRDAbMEbau2v7hn+QV5RnioDGfND+y+SNMaTDy5FWhbPG0uVr0zUcu0B24oudySxQWcxoKE+jfjrojfS6p9tAU+BXAPKWV4h8DVmk1yk2GeDcP6F7X+9AMxMKn3eUQmPgTZbxSU4BNnujLvvHy8FtvauUYfv5xOjNiWsSNFqnpBptVot1fyULlJ+ckGAbpgzQevWyWfJlVjk9I+bZ8ADqTFDK4gh6Fp859pHCIlEzVKt1ikHqbD+L+J4EJ+pWZRvrXmnEMVHPzVThjP0Yo8jeS1+/tIPRDcHo2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkLpcUxm6dLGLmTdHEly1kwTZ2cKbx+N8n0o+4g8JrE=;
 b=v++Aei9C5bkanSWiafuaNsmI6xE7wT+n42Fb0JjvWzHVlvnBOcYUnh+KAR+xiSCVhnFJAbqSG6pR/YN7zSsViC6KXpCYADfZuiFHQhtth7qE9OePSplVymgl3FdNqQzZOiUvyOC+xpO3oZ0WcJoV9Zh8DybA6VOSVC6empzj0O62iXcChvclGADU4A7iqCeWeav88XICsDHCRbsVg/bVSJeKQpjgFy59P/SOxl5mtTK3G2xEoUWdXWDWOShl1aN2Y/QLQiyE34XvmzPySEdKvJjVRFGPcir1lnnbmpf3oRJ4tuY3OapB+OPeHY88ilKOMJLPAtsOUWAzQtiGLc/VMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkLpcUxm6dLGLmTdHEly1kwTZ2cKbx+N8n0o+4g8JrE=;
 b=e3f+NcDAA2T7imA5Q96hMh9E8sLWp78Boe4lXnpEakEGtM9dPlIsQaUIa5ZHDN40hqgMzHFpORJYZKHCBrImydS4Q3yf6s0gzzWqRjqBFRJw2vhm7eVdbVv7fKrRdmGvlb48/gq4oLbuPgvQWkAhBFAiwhaYXSZsXmju4MJPmpvMVq/dGKvxYrHtXHceYmtCf9/BCOp7diIAI71EKMdYMhzY43KtU/SOcgolC92DSUZn4p/RZvy+seq8zsgKc2uDhChI3/Tdq2n/2PHK+9aEGos8moyL++4fl7M9899JsFrCK7R0NI5Mkaqey5ez+xcvSolLX5vv2MnJvTX4pK4S0A==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by MRWPR04MB12329.eurprd04.prod.outlook.com
 (2603:10a6:501:86::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 02:31:21 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:31:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Topic: [PATCH v3 net-next 03/15] net: enetc: add link status message
 support to PF driver
Thread-Index: AQHdOPf5rPAr6++Cq0ud6wQBTmAapLa4DqQAgADuDlA=
Date: Tue, 1 Sep 2026 02:31:21 +0000
Message-ID:
 <GV2PR04MB117396D2988C68C961868A8F388A82@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
 <20260831025441.635045-4-wei.fang@oss.nxp.com>
 <bd07a661-857f-421a-9ff0-e807aade9543@lunn.ch>
In-Reply-To: <bd07a661-857f-421a-9ff0-e807aade9543@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|MRWPR04MB12329:EE_
x-ms-office365-filtering-correlation-id: 8db0e36c-7896-4c0c-b6dd-08df07d11c24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|22082099003|18002099003|11063799006|38070700021|6133799003|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info:
 awp7Zw5ko4ISoYy2Cl/7ykptyxOFa2vHQUgPJ9BWSGTrCNf0zPYYxlZ2wtRnkkRWml2U+gHcaat5lt4hH5SVfUUzjREz3yBqwdIm6//1PX+ni03Jns4ie27mdStzX7Mf0QPqPJ357FIGpjg7wrr+cgnNAn+RICRr4KbSMIhH6MLyescdciu6NKR3NnWEjDKo+LoBMTe/1q2wSdCbheZVuebntmLWYjq9PtqW2H66UaZAg11TRMcD7CzPM/D0wb6EYPQKctMb9mWqryu3MfdgyLo85G25Ahu4Zu1Kp3ZmP6jrdIE8oISEElTF3OiGHdVL00IaJpmWwZCZGpDcmUET4J2XXVjFzboc13NBz4uAL/FsQbd6ysR8yeS0BLJC//OM31jrieDlV7q1Tizw/dT7ckTbvlzKVorvTOk2YHcmIcTLlWxvOZRueoi9N7MSjTOccZHdNi/9PluaM6kGF1sZZuMr3Pmnk/MHOuPnF/QN4ce7U+RqN2pcZ1DVOLYYMaCzUyLrfCQ5eY76CXnFPJWatBwTJAfu0slvPi79uRsqqFhzxiKSaxSAQR69g2SS2lEmBvC78fTAdW3oHI5ajgfE/d594C/XPUkzS29UfmUC6UXu1jaXPCfRyDJB6w4BwajkodNY70fz+vQ2JnfpaD6GdP8+A/17LHllblwrOlFFLclpHT7EX6lrq7iJMeCpkGdUx7vsqFW9kgIRNddBNIm90g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(38070700021)(6133799003)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NkQA0Rzqk5Rbf7MI5oSw+5+P8Vbycvmm5Yj3cI7LxGoRVUdPvBUvoBJPNA8A?=
 =?us-ascii?Q?ihdSqCphNe4zqrcS8SPBdlXb6NKMsSsAklmOm1zzLikZAHCPb4hhRoyOTQ5F?=
 =?us-ascii?Q?iMbm5fu9iQ8z2Ti+LaT6LHHtImt9ZlIYyEJ4orFoRQGurU6jnJvzv8X2sSfR?=
 =?us-ascii?Q?x8JcFkf8KiH1s8xvRmPjZ2xldLK1O+exgogZkfGlmRsI0cOPXUY93tRi3v8K?=
 =?us-ascii?Q?uu/4oe/FQo+ROcIfnkvMcaFw/8Sr3kROFQpLL/dZjUSLmyRt3HQGws94qOWK?=
 =?us-ascii?Q?0tNASYe/aqvaAXsl0FzsHFpgPUD1qpNYvhrLYvhXVzjrM3vUyKBMKfGswmR9?=
 =?us-ascii?Q?0NySoNBrQQTZuDQvX4y0D7xHCYguykCzHoKTIlgm20fWzHv9CyFGhrfC+J49?=
 =?us-ascii?Q?mjzevkmNqiyvSdTcWNKnSXaoAMhFuRqSH6bFl8bjdcvIFfYNJ37rPWOqgZRE?=
 =?us-ascii?Q?mn/Xkpwunv8sTkEuMYVvIkWMvPpwoqcSVudEYXLdJkSEt8k7sFLPrnT89FYX?=
 =?us-ascii?Q?2JjHgEQ4sHQhRiNMBv6sQn6cMXiZmiReXtIVpoUWE9C0Zy6PuHlMAcR4l9kK?=
 =?us-ascii?Q?eD5lqdy/Crme87JFXlS6d012It2CETmN/+mkUhjAOvJ/mK333CUZpmx4fIDK?=
 =?us-ascii?Q?2MgqzpovhcGDIO0UQo/hm9m56/7PyS6ZwgE9aUISHoAj6cVdlQgoZ37OkLZb?=
 =?us-ascii?Q?Op33dyhUP+b6TCmJTv5pluS4z1VzkOUjuu88R7d73YQqviQ7FLTVXyGnTZ7/?=
 =?us-ascii?Q?S6Vtb9d2FCt5qoC1Jk4gBuoDfP3Wll/JCex/PwMz6WD+TRFW25k5tHgzBTdO?=
 =?us-ascii?Q?bA7NndQpRUGfNXUGqARkPRknrK0yYzETkNQC+JD2+m6s1sfP5qeXwK4c02ve?=
 =?us-ascii?Q?47d2TRJ3EeTEdxoxe9lt4usGii4tnKqegzMZfPTU9xo7WUYPJDZ0p3jEquTx?=
 =?us-ascii?Q?MF72zUjGFFw3Sd2JmsMmOsYFNl9/YeD0kBReVxjA2tkdUN9gNWjBsTgHAwI1?=
 =?us-ascii?Q?mSWSqG9bV4iW+L8Gf8PqRdO+0TwpGh5Ag88XUU3xCRGQWc0imtG75+AqlIiP?=
 =?us-ascii?Q?iaNzz+ClDKKOkvlJR4d6oQWj6zAwVE/YkHmZ1BKlL7NIqXhZi4RQMoFPyeKf?=
 =?us-ascii?Q?9zZz6KOG8C2xaw+bzAzt0+XZg88E8hpATIL67+RntO63kyVRjkeGGLd3TiyA?=
 =?us-ascii?Q?NUJdoFl22KDCmhUCnlWrrrEmXIPrXM5iqMlPy6Uk5C3DMzr39p2hMrNkLyn/?=
 =?us-ascii?Q?p+KSMkWt19dmGBQbBJ2/hVIxrDoteyjn9VM5zf0Hbp1gi5Egm5bDMAqpr5tn?=
 =?us-ascii?Q?shjELSB1Pnw+uwJY79mMqoWFs/c2xIxa5+pnpxoW6DjZce90C/PKDMDPvV/t?=
 =?us-ascii?Q?A/vcen77jhZ+axY9OMvc6riHIMTSLWdf9uldaflgAE6R63ZtLpKIaIcDL2up?=
 =?us-ascii?Q?bd+37tWye9CCNeynhtk+AY3eYmxXSivw8lcw3POAZp7wdB2k5YoIIHWLjCAl?=
 =?us-ascii?Q?XJD39NNB+Ber3QlmkbeDGN9h1QMkqt3Feb+T9Dmzd5VbBvKvHUzXhVYBp9w9?=
 =?us-ascii?Q?R4TUkCyYPGoPAB8kfryCygS4SpW1FfBm0/TASgDZEGcueVd9Eme/HhZNwz8I?=
 =?us-ascii?Q?XoCtWoOafkWQvupcvpmHLS57CUkqDo1hSAv0T18SpfTKBzNL3sxardJqLrfa?=
 =?us-ascii?Q?mrOq4x6rz2vWNiLUqbruMmqehddZOHl03gfY4Dvh3n8psiLE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db0e36c-7896-4c0c-b6dd-08df07d11c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 02:31:21.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GIyZWyVvoJT89zGff+6WiLN/Loxl6tjXpBqy4Dtd+heae5QvrXcY15dwirDa4bEhkwymAfwtHm/4pu3GilSxFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12329

> > Add link status message support to the PF driver using three command ID=
s
> > under message class 0x80 (ENETC_MSG_CLASS_ID_LINK_STATUS):
> >
> > 1. ENETC_MSG_GET_CURRENT_LINK_STATUS (cmd_id 0)
> > The VF queries the current PF link status synchronously. This command i=
s
> > not used by the Linux VF driver but is intended for DPDK-owned VFs.
> >
> > 2. ENETC_MSG_REGISTER_LINK_CHANGE_NOTIFIER (cmd_id 1)
> > The VF registers for link change notification. Upon registration, the P=
F
> > immediately notifies the VF of the current link status via a PSI-to-VSI
> > message, and continues to do so on every subsequent link state change.
> >
> > 3. ENETC_MSG_UNREGISTER_LINK_CHANGE_NOTIFIER (cmd_id 2)
> > The VF unregisters from link change notification.
> >
> > For link status message, the PSI-to-VSI message is 16 bits wide: the
> > upper 8 bits carry the message class ID, and the lower 8 bits carry the
> > class code. Bit 0 of the class code indicates the link state (1 =3D lin=
k
> > down, 0 =3D link up), and bit 1 indicates whether TX PAUSE is enabled o=
n
> > the PF (1 =3D enabled, 0 =3D disabled).
> >
> > The TX PAUSE state is included because VF RX BD rings support congestio=
n
> > mode, but whether the hardware can actually send PAUSE frames depends o=
n
> > whether TX PAUSE is enabled on the PF. By conveying the PF TX PAUSE sta=
te
> > in the link status message, the VF can determine whether to enable
> > congestion mode on its RX BD rings.
>=20
> I see you have hit the 15 patch limit. Do you have a patch in the next
> series implementing ethtool get and set pause?
>=20

No, we do not have the patch to support ethtool get and set pause for VF.
The link is controlled by the PF, including TX PAUSE-related configurations
(ON/OFF/refresh threshold and PAUSE Quanta). The VF can only passively
decide whether to enable congestion mode based on the actual link status.
Adding an ethtool set pause interface to the VF is meaningless because it
cannot control the link or configure TX PAUSE, , or rather, it shouldn't co=
ntrol
these.

