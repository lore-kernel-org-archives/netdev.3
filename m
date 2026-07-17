Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37620357D0D;
	Fri, 17 Jul 2026 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279192; cv=fail; b=Njr78KD+O8Vhsz6jBLoLm8N+Aw6nBemar+57IFimU8FqtZXQfW0AWDGsIRgjsnKBO2aAdhg93mQwyD1MsWpeHhftqkHc23IJQFHsSiHVmv6ir0tLvfI6LUf3H5J5u6ufp9qUAIJ1fpSeW0JMhMWJCy9Nlf938iNba8pN0tCsEYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279192; c=relaxed/simple;
	bh=ho5l2UaytbXQoGBru5rE4lnFV5iiFLOQnB/fzXoFTO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jDL8O3oigfjMKFxmgUmhsSKyNPAHQ1NNzIBsg1pdwH0/+Q1f1cyTtOeikDgXLaEpz/f2yprofLrj2n5GTJoIG8VSy1RQpKglVB69gy3eG+4pBUDkfLGISG/m4um6CHsSuvHT8xGaFs96dFXod3D1zkjoF5KMn43KGIgXTVu7JrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZVINynNW; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZVINynNW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC2ZQJUuyhi92tVR75aNom95TSoQVLAsiibsClXfQZqIm0uRaItYJizmDi10Z7hbwQpVn7YKnEEeslnRcY7r89alu+FpwQksoyOBNRQdqmYnkmN2jM1iEwB7DehVwnznJcxqp3iGwFy2AI3ZKXkzR+KT2lXz+No562jdmGxt4+MVGNpZkik0UcWct23BsNMBUI9elhjBKtLJrstpI/px1UBhnlc+p3nyXwCNfoaaA3xb1cla5i+4sUJP+NACyorze7aGDMN2ozZ3UfqB8Wx/kVLvN2/YqjQpHdlh29pS3Xj02nrh99XOxrgYz3j4D7IFP16t3ZxsUuc4IJMOqvrsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoKfsai1PApuljIuKcAXQrkgXZ+HGOuaiUyZhgv/Is4=;
 b=sBa/95vE4nygktrKEDknd0gnyvPYwMLI/BHj1QH6oSQpe4E4Y1vKwFhfObG+mCtF8VAtsnC6IkfyBIWJ0EU7JU5grfx9bl51/FmHyrChe+a4950Qv0S+45tPSex4fl4wNHewEctQmZqp4+BCdqZ4fIK4wljrYkualsKFX29GN6vP+mOgLV9MzDYxZ8bIimPgpj3/p0yn76tIYLEFvoW1Z+6OeDIejzgW16SlbAQQcnowTRYCk9+7EH/i0EKmLtGjLau04beDs8JpmPBzd2Dte0Rsam84YAxsil1rj9K8G70LMd8EQAovGkh7tl8qyJIE7SkxCgBIxa10stKZRFC9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoKfsai1PApuljIuKcAXQrkgXZ+HGOuaiUyZhgv/Is4=;
 b=ZVINynNWqe5uBssgDmhVbJka6/TF+llbKonn2MPOsjWgURBwIHelvQHHyfYf58WOMlmCIZR4+4nWaM6SJEmGuqVyL2aq8heWjdAzyhLFZUId1RQa9MdQmkR+OJ1ElnxBIIiD6l4u30JwD/GdimFzrhjM33disrC0/fL1faaWdnb7EIjhvnbUdLEioE12zV21VJlLHn6OvYfEmA3+DgqYOgqvRRcosXonVxQZxMWgApKU2udxS0rewqvL0ELdTDpaGI8ZSIvzXl8Z1KC1wH/G+6igMmZ4Sn8B/b1uwLghwxeOTUPkoWifKcZoxEME3FiAegmUcir7u7uW6DPYRAumJQ==
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 (2603:10a6:150:336::11) by PAXPR04MB8863.eurprd04.prod.outlook.com
 (2603:10a6:102:20e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 09:06:24 +0000
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494]) by GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 09:06:23 +0000
From: "Clark Wang (OSS)" <xiaoning.wang@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "Frank.Sae@motor-comm.com" <Frank.Sae@motor-comm.com>, "leitao@debian.org"
	<leitao@debian.org>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Clark Wang
 (OSS)" <xiaoning.wang@oss.nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH net V2] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Topic: [PATCH net V2] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Index: AQHdEEIrvaLPtoaBk0WHVNUWHRL36bZmuySAgAq7ZwA=
Date: Fri, 17 Jul 2026 09:06:23 +0000
Message-ID:
 <GV2PR04MB122132713A09EEE7BBC529188F3C62@GV2PR04MB12213.eurprd04.prod.outlook.com>
References: <20260710080018.1070789-1-xiaoning.wang@oss.nxp.com>
 <5d55cc0f-4b9f-42df-880a-290faf201cc8@lunn.ch>
In-Reply-To: <5d55cc0f-4b9f-42df-880a-290faf201cc8@lunn.ch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12213:EE_|PAXPR04MB8863:EE_
x-ms-office365-filtering-correlation-id: 101ca5fe-9b09-4789-e657-08dee3e2acb5
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|19092799006|18002099003|22082099003|38070700021|10067099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 XWDedP2RQfQvSDDHL8+966RkzBRTbsUbJWVzhCEiCCwiQERtXSJ2IraNcBNRg54xD06/D/1SdHVyOtPK8OUAlMVPtcxma3hPy7Hdc9h8yYih37WRV0MvEYp4bxC99ctekrkgM2oeSfhPxoVClyYwuulCdw/JzpyFNEZEIdFaGvacE24J+3LYtzTCXbXa1Aw4XwiIAFz+bFH1q2z/nXbyqiUwzZ2E1WPSg0OJorEJ2cA5sOlMSj39xJKFB/AVZBmDjPRfb+lV3gi2jzDxz3cvvG5xm5teYf6dlio7i75X8QwZLt5r1a//udKCFogpzyDjlflhiy/NFsCaaU995D790qttBEOXwp2mjtu/QGZtA3yQLjxP236NnGuy4KV+qt5NaGOABChAi1/kHbxCKOY2jCcLJtH1bFEnzCUtbd7IWSVUQ0aC2KFPrZvnnJij0V6OsVaZ1BU6C8rEG+l4HwJ2qgO/1e5WqCGTyjnmflDQTbJXnHryq32FQhkB2lTIibz13gIaN6BOhAqhAdHhj0bexDz2M1EtdOucoonA1g5PerRo1lebw4YU+4PfDvYGZIfmtFieCMgorSpQ1fvdF4KJ0s/53OP9vTDHFZ9hFlzNQAyatXpPJ6QWI975K9A+2RF3+vtXyysLfn//LEB3yeuRToqp1sSZhXBLq/MFAXyz4O4MVCtTr8plQbn8tRrJE8zjCzAFyNMIk9waal1TWio02wbiFM7HvqpKMwMRNZhmp5s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(19092799006)(18002099003)(22082099003)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4kvq1r0MWZLCKfz5TF3lPCL+TbmMb8f2auSRUM/Hvk6TKyMHcZXJihxE5twe?=
 =?us-ascii?Q?v/ZtPbhO6SMV4uq8VfuszEX8Swp52z/alaYapk/LX43E6EEd27YVSQuUXBm0?=
 =?us-ascii?Q?rviCpqiiYhb6le+utTTsC5tJ/NN56Yc0ysvnyrCXNfy84HoObi4bO7flESbb?=
 =?us-ascii?Q?cTm+aFsZDnlkrYC/vsp5NomP5nOxrsdw2aWBx/W5jAZpzj3gaRsy7WRnNkd/?=
 =?us-ascii?Q?teirEC1DI9XyxuxC99x+2agxekCmwTSopxdg4ZT/91Yj4N2A9elmWL4JkG4v?=
 =?us-ascii?Q?V8F9vVWd9FH2HK67rcsx3fEzUr82KoNI3AD8cxkfXSN24pN4DbE00C4W+dnK?=
 =?us-ascii?Q?+t0/wx96AS/4vzZm/IbpbBs+Cv9T0JgH5oBxoBHeTqCk70CY55+MUwJlKKKH?=
 =?us-ascii?Q?XqsMX6sAcIYlRi8KDbx4G/z5rlDv98I+gYdZ/XiQeybDrTAtE30DjLSq6uwZ?=
 =?us-ascii?Q?sMHDHzB7HRULT3jVmrerBgsRJw9HZLg72p6K2UhR5hCbibjRtF0iOno2Ei5w?=
 =?us-ascii?Q?DHvzK7XNzynGreB17GFDFyitu7Vn+xI1Cvecs5UF6OHOQ4rhhAY+aasI/lD8?=
 =?us-ascii?Q?by1L8Xb9qv5oEgrsfGqeyUrPJnKOC2cHyjUaqHEQHTyXVMNnW/kPXpkcm3PP?=
 =?us-ascii?Q?Xc0uQrMUv0yVf3VBES46wW9UfSnc95j7YfSuMZz4cq7Au/ZUUKaosNEGpX6/?=
 =?us-ascii?Q?x2s+PEAMSmcspp75TWAUDV9iYH3XUWY0jcUStlRjr8UTg+kik4YLcdGXrbcb?=
 =?us-ascii?Q?uiahYj2fHZ/FjSDiQSDdfRHDnRuUB4ZsNuZ3jLoYti5NZzvsOCVN6WZhaLfC?=
 =?us-ascii?Q?M6vs4QCA6B/CQtdOLYoFEdzGGf0RL3Mr5jBWnVNK+ckAyymyiGoEIVAavvfe?=
 =?us-ascii?Q?7BSqLKZEWQN4DVEOOBozbkch641ylCkut8n5cwH8noXeruJzQcLqw+Jif2bI?=
 =?us-ascii?Q?llNe2JNo3XBQVxi+kYMEpkk9unUBSXiAoWMZITmqMGeevwCs5aICK7TNq0pi?=
 =?us-ascii?Q?eHhzWHLg7OnIhU3W89gmKAvjZLge7/S6iaNahZ3vNMoG0FG3KzgZphyoTy0Q?=
 =?us-ascii?Q?Cp/qdXlUKuJs5ScRlvE0TtmSGMWci0BfN9irq2jdYb+Ex7L/o2a+Izv1HR1F?=
 =?us-ascii?Q?u0P+Tu8Aa05mpS6iH1hVKm0VMEwI2cUy9JYHoKrltJbV/R7jb4VHo3WKY5Xp?=
 =?us-ascii?Q?C46mUQW5kra3HHW7DnwJGbFwswsTpNTcgzu4d8ZMQiLNhFhAR8RO7/nMrzKf?=
 =?us-ascii?Q?H2NZbhRi06gYlK0F/1rWp7S7s/UUEny7555WPAh9QezuruuOzqTcdbkusLGN?=
 =?us-ascii?Q?6jE/tGxf+vwSYl/euA3GTR7/ehvzorgMgo+vTjSW6e/2Z1/4vJv4cZzkQhs2?=
 =?us-ascii?Q?3j4/25ZXQ7q7eVUjpbBbgdk1ZO5zxMc1U4KdPaOV1yEz7L91EK7ZBKYu1YoI?=
 =?us-ascii?Q?xqpWHaTQvhbnzuKyGxK+JghznpqaEJyRm+IRAuTNU9PxVtwKfNxlzNsf+zQO?=
 =?us-ascii?Q?Yq7JO2WDP6Ur2ifr3sSPrmXKqM0Z5+0btuthZGHqEB5lEKE+Wd7I0IgjWtDz?=
 =?us-ascii?Q?FLsHK/nRB/mD/xExvAFmcdeqAYdoZfmpURy97YPYMfbJY8l0itspNyqy8Ieg?=
 =?us-ascii?Q?N1U9kO4HfD9egdUD5n2ntNk3licbVkhnt3zRIX4Nb45supZUTw2bTKMR5E5v?=
 =?us-ascii?Q?hEyzYjJ+CYZb52ZiRO7Wio75bx/8nRZnPRAL5/1yqYx9TxUU9o2dTWpJ3gJ/?=
 =?us-ascii?Q?jd4tVF/ceQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101ca5fe-9b09-4789-e657-08dee3e2acb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 09:06:23.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4pw0nbEnJhtkVMqMJC73AcGz9tX8bNqg3Y5pWIt/cNSMDhYRzy1V/odiCgN3R7ubW5Zrmk/R9KlgkkzQ9gmCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8863

> > @@ -2490,7 +2490,8 @@ static int yt8521_get_features(struct phy_device
> *phydev)
> >  		/* add fiber's features to phydev->supported */
> >  		yt8521_prepare_fiber_features(phydev, phydev->supported);
> >  	}
> > -	return ret;
> > +
> > +	return ret ? ret : genphy_c45_read_eee_abilities(phydev);
>=20
> Using a ? like this is very uncommon.
>=20
> Please change it to the usual
>=20
>         if (ret < 0)
>                return ret;
>=20
> 	return genphy_c45_read_eee_abilities(phydev);
>=20
> It might also be better to put the test after
> yt8521_get_features_paged() call, since that is the only place missing th=
e
> test.

Hi Andrew,

Sorry, I missed your email. Yes, your suggestion is good, it looks more usu=
al that way.
I will send V3.
Thank you very much!

Best Regards,
Clark Wang

