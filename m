Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A23D1A97;
	Fri, 17 Jul 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283669; cv=fail; b=SUv5iU5GsBcwDinuq7UZMS8yeKEMiaDzJs26dU+5EoilHN+i23eXuH26+5vm+w7RMRb464HXR7g1RtC4Bl7TgL/1Rt8tBPj6zxv6/ItGEnTLiYxCA9SD2LflLfzCXpM+dtNVEPEnhY/mfFHTq6x4B3TqFMgRpQjzbHBBUj0qOtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283669; c=relaxed/simple;
	bh=XUk+44MWn2Awp7p4CUniOBnPDzKlv/6tvYs0IRFzoKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J51SFudy6jfGiJzK+Ms9SOAEFpxsUaNuTq00UKaCsHr4Kb136Gp1wRLOuBg0mXKuslcFA56TuRC4WcKnnRGw8NbP3etmNVperX76pG3j2N/TVUkftjRYwI5tFxdjBNMxlYX5KLgwSBAacoK/dCN2BZWFVzV0dVj4OZUDMuipCJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W4pZTVkd; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W4pZTVkd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVFH6+EmX/K6Fde3tK++BQBXum9sMgaoSrVqwfK9RqXNp3clGSRp+bWawF2LcEGg7SRrG0oGCW8a53yCjunhqDDZULlFjveDB9Crn2+T5KettdX6EUzLerJ+X3th+6IITWQRbvADIzZt7BBK2pO9TegZCmdowRFwgyGkVnMlfFa7WVZVHgE45I6s4+jG7l3dyDSayQNhcWJDYXtFrqGhCBvIVssz58u8XN0VoI0tysxwghoH7MwdXRdV9vMJFg+rjq9MlHmdze1iEqWJekE7t1jUxdM4ZdDxOL5q+OFpvaOXmkYDlVCKL9BuFOUXiNEUA11pz8Oyifcc/a+Hbl7qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQgkoMUhLpYJ5bThF2m6WOlYd0vzp5vylngUWvxfjXU=;
 b=uSxvt0++QqDM4i2xjXxQYnXrR5QYEwIU3ZJvFu5Wp/OyVtSHYJI7kyOlh1mbV4pUgNTs9MH+6BYvb2y6inI10fc+MZRRgCR55hyl2i/BsTLBEEGJxgngd+KilVX5VxzKTt0DDvGfJ8PyvgiragTY/GvPNiLOrhbVTV4WRWHgMmzi8iiDRzIlUVYAOfscg1LEqQrQR3Izve4g3c4X8fD3SzIIlTZRO3uTaP1+3wxQtFldTMLV4EMpytUUeOojvz6y3WB/GvoXeQa7A+q6a2ZkxYrIoTeKZgtXfMjPcxy1bHhFbWpWpWj9fj934wKanWVPlUbWe0hSFv7DhZfDx7WICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQgkoMUhLpYJ5bThF2m6WOlYd0vzp5vylngUWvxfjXU=;
 b=W4pZTVkd99wFW+LOGQjumDTyAqp8aV/LRNSfVR362vW/diWrOAhoc+T4jAqPQAi5uJIR6jSSI33j/+OU2mB6OUQgVd9vC0cT9kjdc1ix0C5/jBfC8O++5iTrS9itCw0uaPENsuTYGNm53vy7JNQv36aZRQEN7BM99sEyn0Sr/4p6SVOfFajJ1mkdw2goawqMKtsVCwwcAo178ECCIThTAROnqrN9YMZC2+H4IkbpwOAU22xN4SUC7ITq1jVD+KMyNUNV/dQzs1eCv49dug4+dwx0UPFrN6Li+l0PuLqFFBWViFwZRwTCIfrCRSd6/u1PAmIVRfbIxqQ+lrBZCtiG1A==
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 (2603:10a6:150:336::11) by PAXPR04MB8176.eurprd04.prod.outlook.com
 (2603:10a6:102:1c9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:21:04 +0000
Received: from GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494]) by GV2PR04MB12213.eurprd04.prod.outlook.com
 ([fe80::52ff:eacf:430f:494%4]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 10:21:03 +0000
From: Clark Wang <xiaoning.wang@nxp.com>
To: "Clark Wang (OSS)" <xiaoning.wang@oss.nxp.com>, "Frank.Sae@motor-comm.com"
	<Frank.Sae@motor-comm.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"leitao@debian.org" <leitao@debian.org>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net V3] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Topic: [PATCH net V3] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Thread-Index: AQHdFc0GEZawUmxlBES9wrA9teDb3LZxfplQ
Date: Fri, 17 Jul 2026 10:21:03 +0000
Message-ID:
 <GV2PR04MB1221388D7AC6F8346CB442760F3C62@GV2PR04MB12213.eurprd04.prod.outlook.com>
References: <20260717091652.230617-1-xiaoning.wang@oss.nxp.com>
In-Reply-To: <20260717091652.230617-1-xiaoning.wang@oss.nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12213:EE_|PAXPR04MB8176:EE_
x-ms-office365-filtering-correlation-id: d5f9dfc9-7f0a-4d03-448d-08dee3ed1b32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|366016|1800799024|38070700021|921020|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 wL2s1Ey2DC2wdLhy+A6BBAY8sg+5XKgUMC3hHSP84xXtZs76jdMBcaFFeIGMNd2Lqm1GBTmZATAE6kmPMwuBd+HUt/Q6cJl+GWiYq91NtbcEHopUlokVjt6RwJm8NAnw/rboMv7pd6VPvo7MNLu1EVPh2CIYFHkLmQ1YZ4qK+tFpJTfxqX9KM++X9WrT3XmouQTYDMQqXmvP/Q3H7dtInPAXCV+wfK0kxe8Rrk9gDY0PsmQITxPQpWu3GQkQrjxZDuHYv4zHRvV/uEv/EZgyPcJ53zM2C9vHt7fgQ3HfzaALX9BvZwEV4SDD3W9FtquVI0JVBVkt/ludYFfWnoqtHc2L+w6g6wXy9xjW5oeG2xOIycUxcSiZnjOTm7eWhOEOKAQ+H6Opo0F4VKCsYYDs5oDEt0DYNGCt56vm+Het80o9sv+DSGQxVmwEuNFjwjfPV9c22bjg9GMBDQa+zJpLrl38RubA1X78/aEJrhUr0r0RUR96BfdHZ9cKZwomnmgxbPxxYyNGUfkQxhM8n8HMnbtCg2tIiST+06v8xG+OvZ9CgQkndYvWRDrsFv52aXCaA+R1bVzqNgOmOo3pOsAk4RtoAgOaNc+3VYFX8Q1OljQW5ldcMXsPq4kHpCuB0dAZGTEy7V0tgYNaBDoJTSokmJysX69jRujMnHjBsTgmqGBXbDEKEtPh6rLLe+657D9I
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12213.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(366016)(1800799024)(38070700021)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rBGeBYGjcsnhSr3JaBSw+RD/TotYLnjDKu4NcXTFyt6yaH4wnUDF8zt38NZg?=
 =?us-ascii?Q?yLzvNuio0NYnNY5F1R6Cx94OmcULnZ+bgK1Wej4f1tCfkACQYSF52tPDJ01u?=
 =?us-ascii?Q?sTkyX4WsMtL0NbWcMwrOnvrCZ9cDYE+sbY7l6LV0msdyloCWLtEHZiaL3zjS?=
 =?us-ascii?Q?6kqkaI6BcapWNHXl4ABv6Y0JOtCTLXTztxJqx08QINvtXxoCBnhBdlGmT0YJ?=
 =?us-ascii?Q?omKLN8b4WnBGa29OZmLEdqoz0e4DM2avOr/9WLObQ9X7BuhL3rRVQwlky3Gn?=
 =?us-ascii?Q?HYn04CHCfYWEHED6oua5Q8CHsdAwyW4ZY+9G4tLxyNvWNNvA2acQE63zfavY?=
 =?us-ascii?Q?hXenmjCCPNiybNPdir4Phkfp+NqB/crsIiBdNW3lKtWecF9pdV46wndTFHJ3?=
 =?us-ascii?Q?CwyYpupP6EVuP8rRDSadiuT0lT6z3R6fsdzcINoPFVkhxPFnfW3JtNLE5+cp?=
 =?us-ascii?Q?H79R7Gv9RYCr5/4bMM5Ui5b6cJRO0CiP0tf2WEyIaz2gBSBcsZNdWrBLvP2K?=
 =?us-ascii?Q?uxZp+XegLA209Cs1ekmtr+bqC7FXCPtInKSwGBiPT8hrxhKebb3DnkkEzp5h?=
 =?us-ascii?Q?jKI6n0JxrIPFdv2aQUXQ2SH9QVDXzSSW8nFrbY0vm58w1VAqC/2Bn8ljmxV2?=
 =?us-ascii?Q?Qhnpc3Gws2yXd1Mp828H9bX40ZFY5QLGz99amn0CwfDDoVH58X0Fp2DPxwf4?=
 =?us-ascii?Q?HJw68wCjZ+63zsostJvYLlLizEGJFBgI1tlAuH8aMpGbd+nJ0ZYHPxtzIngU?=
 =?us-ascii?Q?Ma5vQYh2qCSZWj6tsBGmwqZW9fH/L1qh5qfWI3TDEyg5g4tPXbvyDTJCsWw1?=
 =?us-ascii?Q?l4Q78ryTC3GPiS/wjs5EkoYEvXHQjk+1Tg4yihK+0gaHY7KZ6ObOxlOYNpGm?=
 =?us-ascii?Q?P+6YLd5fae+jhrMMPHqCB9m2foMxIhjVf8QGH0AfOi/i70jBgqA317QlGgvl?=
 =?us-ascii?Q?zbvrI/5bhTKQEG8zJYkEPQyj5pohimH1ADb5iyKghu1uG2WQC3sBqlzQeLKh?=
 =?us-ascii?Q?/Qm+K0H9MjVKKqGKE5b97py/d7L4XDtMBaBEgvJabysIUn4VaCeIlkaiBYqm?=
 =?us-ascii?Q?jeGOFcZXejvGUnJrWwNu5j2QyflxocBGOB6rHFkH4FjSTDvCslFBEkCFxlvT?=
 =?us-ascii?Q?nG0nKjzRnUBxJF1qVV9FDeSFN04QuoREnv1ZuUJ+wl5t/nxS8xMCYFkgxCFD?=
 =?us-ascii?Q?7dhmIw6JE1oJ7irRn7tCWjslqvFAcvMXfC+SQ7gisAYnT6d62OnX1jM1GPIG?=
 =?us-ascii?Q?CQMbjrZ8StwxenX+i5wKl2BQjVm4sVtOrej4Uh3Mw2qWNq5ID7UuXyTxJkk6?=
 =?us-ascii?Q?J8lrf0qrUd0z+hQQ5UQKD+/GDWnqftRq+9SU27phknXSUssu03jldi1zQSXT?=
 =?us-ascii?Q?2WVTBUob2iozw67iQ5M3Cf7iqA6ksSf/FPd41qXcp+M9aXfsuwXL/vFq1fTV?=
 =?us-ascii?Q?JkZIJAOfPGotf879CkSeQG4RR/SfN07UXlw4yLd0qB8Yct5Ydvf6G28oXSZd?=
 =?us-ascii?Q?aoEpPTh0RDSL2LWS//pkGoPy/18JeO2hEOja27N0uNEbjq48ZeIZNl/MTxLM?=
 =?us-ascii?Q?CzD4HFGdEWYhPHt9P8o7H+vo6IG4caTQnFlrdcRGQJi5vov8KmJjz8fOehjF?=
 =?us-ascii?Q?yPrQh7jTw3Y+n4uQY1FoXibDQ60JtIMzJWnMvbD7NER9l1AsIz4GuCkF7+Mc?=
 =?us-ascii?Q?2K6jmfkVS0Vtt1EWxwSkUN0TaWLPs8DezRrnu6vsFBxt5tqaizGJM/r2qksm?=
 =?us-ascii?Q?PncquyKo0Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12213.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f9dfc9-7f0a-4d03-448d-08dee3ed1b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 10:21:03.5679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jr38vFSWY7WGicOTSfEkJgkRztrQDJrRpb5d59nVkHW9llNIyKG3uedkBLa/cux26UrYEtuAUre9SLeL+dvhUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176

> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
> driver uses phydrv->features. Drivers that implement .get_features are
> responsible for reading the EEE abilities themselves.
>=20
> yt8521_get_features() does not do this, so phydev->supported_eee stays
> empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
> not supported", even though the PHY has the standard EEE capability
> registers.
>=20
> Call genphy_c45_read_eee_abilities() at the end of yt8521_get_features()
> to populate supported_eee.
>=20
> Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit
> ethernet phy")
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
> V3 changes:
> - Replace the uncommon "ret ? : ..." expression with the usual
>   check, and move the check right after the first
> yt8521_get_features_paged()
>   call, which was the only path missing it.
> - Collect Reviewed tag from Breno.
>=20
> V2 changes:
> - Return the value from genphy_c45_read_eee_abilities.
> ---

Sorry for the noise.
I think sashiko's discovery on V2 makes sense. I will fix the issues mentio=
ned in V4.
https://sashiko.dev/#/patchset/20260710080018.1070789-1-xiaoning.wang@oss.n=
xp.com?part=3D1

Best regards,
Clark Wang
