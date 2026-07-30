Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011042.outbound.protection.outlook.com [52.101.125.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5A489881;
	Thu, 30 Jul 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401849; cv=fail; b=lgmebjZLQQO/+yiFPrZefamq8wxay9291yRMTVlF9rZ8BZbWxRtwXfwkcCE1fZzs8+B3FtShKyVhKc4mBwQTBrPRIKBDZuhbrV9kOAFSae0w0pmjnHaXf/zyUXUqu4jm5p0vTxxP5KsvntelNLvAV+1/r9J6Je2CVmFv4sNKJe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401849; c=relaxed/simple;
	bh=VCgWZAi629NQYAm45AjK2wSNx5Qnj/c0iHeaiGAyiL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aIf9DRLmx/khIuGSS7dae9ebQkEHsYqGcFCy4ohMfxXkxvpC/Gc6oZUQGE0wWgFJSKDTwStnZnOHyif4Y/Tn4JT+hyzxzsvdjLSE390bExJimcTRX1WxDVs/Jn3yKdPuIQhPBbsoLBBgm+7lk7K82maTMdc8sTh1eCV0oMThQ4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PsVBomj4; arc=fail smtp.client-ip=52.101.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PsVBomj4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijvBeaJygERwY/7DzzGRsSQPb6H3EqJ1xyw1ogbIVRXSLpdm+SKMcPwPHUDA794XyfSbk0vjGVbRVF9oXj5WYG6TO2eXUX1aKl8lq/HuporRzJ7UqNw7CVFP0cJnzvmj/VZ0ggR0jFJgnsZskgNIs8VheB7FxMGUgBF6BSj9PDFZNXEfVTZje9FLGTO6L/9/2U5EMv26BL3+VY6QMZU/hsh2lQrUC/+smr5aL56xdzjH4SOW8v8vdSDFo5YkRijcnTKQLIAC6gWhi/E78RZD+ID4IzRhGgpaI9C4ikBv6ABgKFg5NpBY8/JfM7F4gWdc260+LKrTreKl4mK3hFnZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oETrMNNLvq8rW+mHubbIKBoCX5ysWoTEbLHhCxFdGs=;
 b=cTVR8tRfe05ElNe1FpiIXGVesSHbGM59tiRhksVPmuxEW7AJnDBVi4svddGwf44zVM8HakhXkBy3mxWey6np/AIHzKEl/fTxTt4gETukDrrhf2Z8d05vqQjdWZZfo3hwslgUwELbjcTTmXwhuHE8kZl8z9Mic3iEeQ324H5UaYPtC9opmY4yUXbGNDZlgoQlXWapjfRwOvschuY7mUU88KwJVQ9WNeLWSPnPHPPNjTC7DRcxm4wmy17rfqkFaH9udJtUKFQZBc3YWOQFu/vXzkoMezNbzGtO1qc3ZwXlljj5PCuk3UDZITWC+5QG82SLwPcheJY8EwF1ern+LN67Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oETrMNNLvq8rW+mHubbIKBoCX5ysWoTEbLHhCxFdGs=;
 b=PsVBomj4VjiTH2X9TAgOlDLKAzqXvnL+QIKKkx1RgffbpCUg9hx9qFDjKUnb8JpkO/jCOJoF+F0Xi+/tNigIzYM+AuR3Duo/0UUZfVLeTh7xMcZ/Q7VSFmt0vxbTbVo8i7BeQNP3PnSrX7SfOVc8x0e9oOYl5K05tDV8vVFYPZs=
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com (2603:1096:604:33c::9)
 by TYWPR01MB11379.jpnprd01.prod.outlook.com (2603:1096:400:3f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 08:57:23 +0000
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f]) by OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 08:57:23 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "jun.ann.lai@intel.com"
	<jun.ann.lai@intel.com>, "yi.fang.gan@intel.com" <yi.fang.gan@intel.com>,
	"boon.khai.ng@altera.com" <boon.khai.ng@altera.com>,
	"matthew.gerlach@altera.com" <matthew.gerlach@altera.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag handling
Thread-Topic: [PATCH net 0/5] net: stmmac: Fix double VLAN 802.1ad tag
 handling
Thread-Index: AQHdHz/RntRPJl+oQEefyqoj3xFOEraEsD0AgAESgeA=
Date: Thu, 30 Jul 2026 08:57:23 +0000
Message-ID:
 <OSCPR01MB12769B66B3A1316E8B05AE8CAD3C92@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <d39c7b4c-04b4-4bfd-8a4b-821a8a32a885@lunn.ch>
In-Reply-To: <d39c7b4c-04b4-4bfd-8a4b-821a8a32a885@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12769:EE_|TYWPR01MB11379:EE_
x-ms-office365-filtering-correlation-id: 33058523-cbdf-4db2-7861-08deee18927c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|6133799003|56012099006|4143699003|11063799006|10067099003|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 2w/r9pzRvU4mN+1acbofsvjXz7h2Voc56lvDnzG+mWrlm+ljNMgE+Z5ThWDEiW752v9kiE39JgHHZjn1UnQLhjNY8Sszbjf1UqIihHTgZDos3NHhVk/IrS1BbIZi2NJq8L20+0f9H6AENEXUAmjs7lCPoUmg2qqGGTGGUgyND+A+2D9jNee1K9AsQt5tDzzX86D9j6sJ0AsDbJFP42KOm1Rbj5jzhepzg7iNLav/C8RY6N8GYyNPS/eMBQIaSKXZGkelPKLTHu5j+ZY+IQhbL6rVLrSdzGUm0oCfwRo9gXaP0nTAONLN73AWr/ihWfXXL/2XDp358i9mmt4oquzG3TRE3n9niwV0WiNEL3bQt3TI2zjQnzumI7a0f0v7wEPxig9m5wXWkmgZmJQwVibgzhlLO9ycIwZo3VJbJxNLz9dUSU13GiPCsIkOnXNMy+EoYqmEFwxS92c3ejZs97pCWlD/Efz5IpTZcpoH00Mx8VWsI45n/sI84DTbOTwdaGPLH93vbfLLkHdXsAvQu9dgEobE6KwBKCudOznsspVp7f1YLYbsk7Z3xpsKadoA70OcgYH9Aeke0Iswftg+4Tr0p9u9xHGSjftYdZUENyUMM1fI76POlUt32fh4EWMV5QLWU0QU9g+j1zRxEguFue0DBF+SvJlwzVXyiMGJbfvr6wYCT0V2JKnSmgFygG1MLD/ODYcASOlkn7asWlxqTtkjpW/hw2vO6n7YbyRnzPI1YmA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12769.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0vPpUThSx++xuD3GeMpChYJMC/8H2dKrmN8Hc+MjkpisBwaOCYVJKo7c+5SS?=
 =?us-ascii?Q?MzQIxAqzZfASuY1B9iOfjhDdpzFzb2UereNrOgK4otdcntWyXwB7Es6JaiC9?=
 =?us-ascii?Q?38P4mrJh3oxzuKY4+J7DjIRijU7za5xwV+GSBrg9XyuBMN9GyU2ICWyyvj6Z?=
 =?us-ascii?Q?83+4VNPAofzPER7zLcdy98Q5kUCTveT2rxw2fTQvLixqQZDDkVcgHTorux1z?=
 =?us-ascii?Q?QFGX5GcB88+tDjLDrZJk1GAanuuBld9CGhqfVJnnyJcKDYZQ0IY+yMkpKeQI?=
 =?us-ascii?Q?JtnTzpZWsShnsCN7gUkFrPHKfdhtIxE1ij0NOYN7L9VyM/0dKbxz9esjlNC4?=
 =?us-ascii?Q?yJHRe+ut531s8gjnepdiUvuGqOPjWKCGxQB/OS6Vnrhf7HIBYquwv5R/NYTP?=
 =?us-ascii?Q?uTVU5c3UYQrP2ko/C1D3stf7BBFmX345odx26bS4mDys4JHHpvf7a5hjdG+5?=
 =?us-ascii?Q?e21Gu0yKwF4+Xe6yKDv1ZZqGrZF7ntbtiOuQwYxtEorRDRoQXrOqCorxZ8Um?=
 =?us-ascii?Q?v8lcS11PM0aYjU9+sa+MAIJUlEmVqGkUl62Rl5gPMMNoxnPDGZx5wWzprZ+1?=
 =?us-ascii?Q?iQZk6A0dt1IZClustNEd02KSbQOqIrwuLZ+KYDw86D36A2YNlk3DPvm4bQ0e?=
 =?us-ascii?Q?WeYd9AKFw63M2nAzjHMkx+3veY2bH4OZFQCVDxl/fw6Fc59YKOUtBDtubFeC?=
 =?us-ascii?Q?88CNZjGtLPdbl0M3eQgOpt9k2eDfnHN1JZAVk6/3ZFbUReGOCN1dJwo6pPPp?=
 =?us-ascii?Q?CNFNAsyzCWzE3+yZ5Ri3Gq64DhzOR0JtTGfdvNiyPBSuXtPMxy7MqgaL7Ud5?=
 =?us-ascii?Q?Qi0zX2/DalYO5FwAs6JqJulwvh+CAjTdZxd5FhtnIfb4WmqxFqGyiK0K99nu?=
 =?us-ascii?Q?BjsOuOUcHIFynJ52bEpUf+O92w/Shr+GN9xGcRq3x7plT7JTqpi2ZS/0++e5?=
 =?us-ascii?Q?KWs3NZsFQfEtJ67YZSEJdv7xQliLb28wyFT05yhIyfUWKl/WqqCkhnZ2PW5f?=
 =?us-ascii?Q?wNjgd/J2lb+6Moplr6+jneL/BxnQSzlV6gOzX0xcWdqObi9AdIbjWDri0JcP?=
 =?us-ascii?Q?LsAmL6ghovPtYG0TaxFDg4wwoBcLaMihkSx9BbRpERYsyTHPuJr6NntWRgSU?=
 =?us-ascii?Q?Yw8ySvb0bec1wSHixTyqKbuXHabfxFZIkMa5+FzL0ejs9CT/6UrK+/1g0g3b?=
 =?us-ascii?Q?Se8BhHX9X+J45fnRzobvIc/EBo7cx4gGUAWvmKFRNesCAvnD3h6Lyyz7nS32?=
 =?us-ascii?Q?vfK8I/TnUB19wRls0A5JZ0Kg9CTUGO1HAiATJlydwb7Y56z9vpnzHbioyVxQ?=
 =?us-ascii?Q?yGnQi8Ha0fOppEjXTbZLADqgvaMiRYd2RIQYGHN96n2mBDOeDdZKE8nKL7Ie?=
 =?us-ascii?Q?dE3pvuY2C4RKNihaFvlO3RjU5krB97VDySWBQMsEKe/s7tsuTOhi8TMjfyMm?=
 =?us-ascii?Q?jiGRt5j2HfVdTFZTFk7Z1y1hsLRjYZcjQz6Abg0xjAFQXdp6ggt9AHkTtzHE?=
 =?us-ascii?Q?D9d8pBXs7xMY9AkM4s+wpuhSYoV7Uim8ESmfiSzYTVJ2pBBsKpPvxNbZ13u5?=
 =?us-ascii?Q?M+lRXrLO2QIjzE+L35qHhwTzMjeNoR4iRB3tsV7eZqpULcf39QwsbxfO38FS?=
 =?us-ascii?Q?oerrDSipC+D1S7rtTqLeGRtuJF9WhrbsT/F+p94aJxgDD//Vlzh0VslbHWKt?=
 =?us-ascii?Q?cy7YkZclJQPKCaPvijw4IemSPUgpU+8+OpSu3w3IDx7PCizXPVntEU7X3B++?=
 =?us-ascii?Q?dk9MCXmS96mWB5YIiPMgT6aYQlrPKk8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB12769.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33058523-cbdf-4db2-7861-08deee18927c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 08:57:23.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqHG2hBX3DZ4unxPk6Rk6wMO2XBEtREo+B2FgfxR55cv8gA9P8t/KCtVWyJ5TC5DaOh1JGKijTRtmPNYEj5CV6ub/043SHcpkeoMUS+B9wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11379

Hi Andrew,

>=20
> On Wed, Jul 29, 2026 at 09:51:04AM +0000, Ovidiu Panait wrote:
> > Currently, hardware VLAN stripping is broken for 802.1ad tags.
> vlan_rx_hw()
> > hardcodes ETH_P_8021Q when putting the hardware tag into the skb, rathe=
r
> > than using the actual protocol from the packet. Because of this, packet=
s
> > that contain an 802.1ad outer tag are incorrectly passed up the stack a=
s
> > having an 802.1Q tag.
> >
> > This issue was observed on the Renesas RZ/V2H platform (which has a
> dwmac4
> > IP), when testing QinQ ping:
> >
> >   # DUT
> >   ip link add link end0 name end0.100 type vlan proto 802.1ad id 100
> >   ip link add link end0.100 name end0.100.200 type vlan proto 802.1q id
> 200
> >   ip addr add 172.16.3.2/24 dev end0.100.200
> >   ip link set end0 up
> >   ip link set end0.100 up
> >   ip link set end0.100.200 up
> >
> >   # Peer
> >   ip link add link eth0 name eth0.100 type vlan proto 802.1ad id 100
> >   ip link add link eth0.100 name eth0.100.200 type vlan proto 802.1q id
> 200
> >   ip addr add 172.16.3.1/24 dev eth0.100.200
> >   ip link set eth0 up
> >   ip link set eth0.100 up
> >   ip link set eth0.100.200 up
> >   ping 172.16.3.2
> >     -- FAIL --
>=20
> I stretch goal, if you are interested and have time. Can you turn this
> into a test somewhere in tools/testing/selftests/net ? If one MAC
> driver has it wrong, there are probably other MAC drivers which are
> also wrong.
>=20

Sure, I can add a test for this in tools/testing/selftests/net. I'll includ=
e it v2.

Thanks,
Ovidiu

> 	Andrew
