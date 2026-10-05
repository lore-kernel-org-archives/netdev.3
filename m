Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010025.outbound.protection.outlook.com [52.101.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B854AEBDA;
	Mon,  5 Oct 2026 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211386; cv=fail; b=hrH9okWDbC7ezc8G0EgMfeWDLXJnIlPfYP6pDl3laPp4ZkU7DaX8q50ygewX5eZSIWlEVu0L3w27Z9U+LqRiYpnTXXbylyuYa6k1iXWkAIvf4UhPLt9v/bI5DolpSaoFfH21/pZKp+7DSHlaKwWqqC7ckKzij5bdsqfvqdFXjfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211386; c=relaxed/simple;
	bh=xDgwtcxrW2COr10i75Of+gd66kBsM+pI32NjgpLcZuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWZYnaBpjgMz94CmC6XlS3KxhU44DC9njjO3R71q2HEgED7RMWuQCarVtsI/y2nt7s7vdEH8u7ITDxCmlPdHjV3A8933JMjfOkDf3C1qoBWwDoh4p2DRIGbdTf4G4ZBbI+ZJKH52HO2v22jeH2KVuaB7jleKHQDHnQskOrx3nww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=GiP78LRp; arc=fail smtp.client-ip=52.101.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="GiP78LRp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbMGfLKHAvPEChVcGJMiACLc6e2kpldL4Z8WRWVS4rnQKFikGtJD8eLbhoyVFgErwi+ogmRjPU7IjNCoq/eH3s9B91rptjJweFYW3xLkTMTR4wcy6/5VsB3xe6dMQVHtBZOc9zD08AK/kbhhAAGj2KbX79lGuAr7Lsfdd/PHzKT3w+u7cbVpKoOPfpVe5T1stuVUgjsaSOe7ZCdlFm5+bYGMW0PPzNMDauG7b3AxwGgrkwCI42E4KodstdTr1jfwyQiX9Cr/Ozl4aCvrFzdizsCjZj71tH+ND1f+KO+kSAqKfuYUszSf394uktzJzMOr25KLcBrJgdzyvAEwAMljHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v1BXPrWQSnK0RLG89Ba6BHtV1K25OzuXRIAdbatblw=;
 b=Cps0tPBamM+vHFdv/m8qnsy9dKB4z/OTY/mRjxo10eU+aOujv6ASCJUUFEnBQOzSLmfqUMlOu/7rXtPzoGXI/QJ+7J0JVgkfq7ZITVpEOEr6ryKqbQJSbaBV/gLEnDGWdjL3AVkHOKwqAuq8oRUDcfXGEC4HTUbPSajZytLpAKwf4DVdmEKcrN0qcOXH3sE64E8LRWJxxxgFm9+bxIB0KMaa1ujELDbclebZl/eZ31Bvlx1m+Kk1b/NLwbbBGEz9FZ19GOMIJTcjtpJdLuqHaj9q2NHS/7yXQHUv82+wIh/4gZaiyBQWeG07I5vDP6PJxtFnKx5fbmqybK8HxjL4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v1BXPrWQSnK0RLG89Ba6BHtV1K25OzuXRIAdbatblw=;
 b=GiP78LRp7IocYmvBJ+OxxPaHEoMW9WnvedogE5TDFZXhjZuXMf8PkNtyC9aHcm2wzy0pO/gPgMESBktzY259Ia3yRp7rQD7/pwQ2fiFAcV149HAsuWtMrR3v12S78lTH9itg5JEBUZvjLQ+YSrbGDmL2iuZWpP46sYVaRMfsuZA=
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com (2603:1096:604:33c::9)
 by TYCPR01MB11606.jpnprd01.prod.outlook.com (2603:1096:400:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 14:42:48 +0000
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f]) by OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 14:42:48 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"recv.jo@gmail.com" <recv.jo@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "jun.ann.lai@intel.com"
	<jun.ann.lai@intel.com>, "yi.fang.gan@intel.com" <yi.fang.gan@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v6 2/5] net: stmmac: Stop toggling the EDVLP bit
Thread-Topic: [PATCH net v6 2/5] net: stmmac: Stop toggling the EDVLP bit
Thread-Index: AQHdT4jYgEghVCXHXEO1UdZtyhQ6J7bp84GAgAUaQ9A=
Date: Mon, 5 Oct 2026 14:42:48 +0000
Message-ID:
 <OSCPR01MB1276954618F55AE81A4FB5AB2D3962@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20260928203441.34876-3-ovidiu.panait.rb@renesas.com>
 <179093026198.434549.6427889648540734554@kernel.org>
In-Reply-To: <179093026198.434549.6427889648540734554@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12769:EE_|TYCPR01MB11606:EE_
x-ms-office365-filtering-correlation-id: e5ba0a64-daac-445e-86d3-08df22eeecea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 JpfJ4A1lAa89rzHtfEXPeyAsF3EiJxbcA7orJMPeQLH3AE9W9SVPbDe6Zsi9euAKHD27qtmmEH0Ph4sukSUsV8RxU1VdSIByu4p7coPx+rSKZFeBajO3YB3dBfZW5FZ8TFKwl1VPm5r0twLhwrY+d0pP4EQquyxkvkIH+f1YqBvcvrHYv64D6Jrnx1lhJH4rlZ7vyjwsJNvYmYekP/F4f3IhmoilFsh8dNpqOxYZdqv1nGsk4BNkvkADXSm4t/WVjD5eggnVnQcFZ+5MhuoIJuQ1I6hKk5O3Qt8Zk0xSkviI9UdyjcUNmrAzvCQSlNR+V4mV7ZlHlljOzCOMcelrikXjyBctjKB5OTEIFiempZppS8SRsu4vpr6+z8aiL53UwReDKwrTV4iD+0WPOZYiT3VzwZ9nLwLQDyQPu4o2kSe+bS+2Sv22/ZHod3ZXbuVciAel2sbyIBaloEpimKji1/VROhSAXXAvSsXPNRX/U6LJN4TaOeaabanqell4HzuEGpfcatAR4JcReVwkw/VNLW7gu/rifTvftk5YtlcK3UcUYYZDnwML9M/iLfwS5wksqV1ZOJyWKMgcDSZNa3BSKvLOC1C1fnaJkSAlfWc0tnwR1q4pT1VbD54CSXsgNnhSJdhdQWsr5yZLt6R3P2+ywimDsZBDgiVFEHMZtZsEwlk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12769.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4JlqXgD/zGS8/1nDey1l6nLoQuptL52pZvA2BodyNqqblO0bFjJLTvEz2a5G?=
 =?us-ascii?Q?x5+HcMYpFatH+X9t72y1zDB/9ZN0oj1v+i463h5cUle9RCQAcFRMyZVoRlfu?=
 =?us-ascii?Q?q9toyUGRQmpFO4ySM9LVeBU7wL4HD8q40o4PUvaYMg+rKkMEC0iO3uTLnkpo?=
 =?us-ascii?Q?/JbKxgnZBGlScXdXDEtHjSuuLRhq6ubQLe8XF3iE/S56NN6+ArT5UCZJxfQg?=
 =?us-ascii?Q?oju5/Y4jvWFZGLYMb/wn0ftOE3yifc8erWPjXQcDmLf93F6zyrojTAl6fhHP?=
 =?us-ascii?Q?DJYwm10A3EYQWUS67o1BsMs/UrZVyk2UIUaA2SphNk2/C1VY9M1pa71b5E1P?=
 =?us-ascii?Q?braCyGa+crdDrt76py1ymEe8xHU47EcH1rHwsJKurw5J3Bl4A70L0jZt1qp4?=
 =?us-ascii?Q?Ro2FUXiqeFQxNdsk+c5eCejbowU36o6baGbCCzY+OW7EdguFPUCOpm7/2j7i?=
 =?us-ascii?Q?OiobFtD08yOhq7lRlbIQptYnI3X/vsVTgMy/VA8kJ3TXz2xQqbzKxM+fV3us?=
 =?us-ascii?Q?VLLVU33qnI/n5XkLv1kPMj3tE9PMrwI0kdnAO6QWEPiLTzQ+6SNN9gMDJix4?=
 =?us-ascii?Q?6b4gD+gBewRjV+6Fzn0GwQf+QgiuUADk+JMa39GPEyosrFqfpOyOWv4k7Cxp?=
 =?us-ascii?Q?XpbCrw/mbUjqkLHQRJL6WP+xotHmCD/OwsVDtOuAvpxL2lWtoKF2nXWEsNt+?=
 =?us-ascii?Q?vTQQbyq2A3mL9bIVedNyEI5441S7d5yE+Ig3LUI3a8h1WVIIHnCAa7C9E6a1?=
 =?us-ascii?Q?NDDPHymytJMFQ11eyxDmbSvNQzCO7CZU9b8xXiOqkeS4G0CooYfyqDr71dQ3?=
 =?us-ascii?Q?q1Xqs0MZoqP41oq9u3kqPF3694v0ZeO5P1zfXBJvf0eQbvtMxNrSuWRE8DI7?=
 =?us-ascii?Q?3Dd/Vnuh0zK/cWP0aI16926JTvnBWDrLED9eyDySN2Uo3rrCZoJMI9KYGvuU?=
 =?us-ascii?Q?gcRWH+RtAMji9knHknr4E6K9dy6S/ig9pDWNE3oKV/afOdttAne5YDbgGs7s?=
 =?us-ascii?Q?jzx2FdvuD3CJJSntDlnzeKTrR/XQs3aVmgQ090Pt8ZvojBmLqeHFgPxjzION?=
 =?us-ascii?Q?tRlnWZWC+P9Takj5leN+S2k+3nji5RE4rzzBb6iN3KJzrkVUCVTSTCqHnfhB?=
 =?us-ascii?Q?pzdIAXiP3xljMvm41BctLmVHF79XdCatBpFP9iTem3r1f/+oG/79qelJ8kD2?=
 =?us-ascii?Q?6lnmWuxis4ODAKbGFqYMdCmjPrNH1x+UwwSE59xePl4rR20YB8vleHl81Utj?=
 =?us-ascii?Q?hN0/x9Ih35ymfZcr16aEEQKuLgiu1/Fo/KDb326LC31i2q0xCkX5gqp14Tgo?=
 =?us-ascii?Q?8RUxP3LGQT/ID1ANUvfRAnnsUmGiTlOPdMRj8n9D01QCbvnKWX+PzvvrV1UR?=
 =?us-ascii?Q?l+/KooZNSw1NdAvJoGHAf0/vJjRXlQl1B7hXbk3hnE/cO8WC3NXPSm+csB8B?=
 =?us-ascii?Q?GyiOO9YYQ5A0cbNbg4amnKyg/vusVICe/z5fvZ502Wpr2BsMe1zAm0mrdxAx?=
 =?us-ascii?Q?W32kEHDQojr3z3jsmdRofIEUN8S/m+Cr9EDXOlAlS439UtopLD03hNHuFJ6G?=
 =?us-ascii?Q?Z95bVXZGyRtl8ZSOENUwuJz9vbmMYVZmSAlFuyeK7xXyemhzsgefd+30PStI?=
 =?us-ascii?Q?HXwqCH464GjcC2W8UGSI1pPBUqDFYDhLviyG+1JaBDFLut/NodkslmXZLEN4?=
 =?us-ascii?Q?XifjrI/CdlFID0k+tWmY0OcFCA9/rUT4ooYtDJqRH95w7ogwU2Goa7GQPfE7?=
 =?us-ascii?Q?ZB4ZRgzU5QCAiImDvkMPthZgQoc27uI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ba0a64-daac-445e-86d3-08df22eeecea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 14:42:48.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ci71xIE5yHQjTd2r8YPrfAFUrSa54eC9uRzAjpbe+nhYYEYAl0T4aRVA1uYa73bMUgeDLWeTMktwAkwgo4O21xK5mosdp+wk/vzoDAYDFZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11606

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 * High: 0 (1) * Medium: 1 * Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The COE benefit that the commit message gives as its reason
>   for this change never shows up in this tree.
>=20
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is still
>   there at the end of the series for XGMAC 2.10.
>=20

[...]

>=20
> [Severity: High]
> This problem was not introduced by this patch. It is still present on
> XGMAC 2.10 cores at the end of the series, though.
>=20
> Registering an 802.1ad VID follows this call chain, with is_double set:
>=20
> stmmac_vlan_rx_add_vid()->stmmac_vlan_update()-
> >dwxgmac2_update_vlan_hash()
>=20
> That sets ESVL and DOVLTC. With hw_vlan_en, which is the default on XGMAC=
,
> vlan_set_hw_mode() also programs EVLS=3DSTRIP_ALL and EVLRXS. The MAC the=
n
> strips 0x88A8 outer tags and writes the TCI into RDES0.
>=20
> dwxgmac2_wrback_get_rx_vlan_valid() accepts the S-tag packet types:
>=20
> 	return et_lt >=3D XGMAC_ET_LT_VLAN_STAG &&
> 	       et_lt <=3D XGMAC_ET_LT_DVLAN_STAG_CTAG;
>=20
> However, vlan_rx_hw() always reports the stripped tag as a C-tag:
>=20
> drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c:vlan_rx_hw() {
> 	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
> 		u16 vid =3D hw->desc->get_rx_vlan_tci(rx_desc);
>=20
> 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
> 	}
> }
>=20
> Won't S-tagged frames then go to an 802.1Q upper device with the same VID=
,
> or be dropped, and never reach the 802.1ad upper device? The software pat=
h
> in stmmac_rx_vlan() does tell ETH_P_8021AD apart, so the two paths
> disagree.
>=20
> The last patch in the series, "net: stmmac: Disable S-Tag processing on
> dwmac4", stops advertising STAG_RX/STAG_FILTER only on dwmac4. Its commit
> message says the XGMAC tag type can be derived from ET_LT. Yet
> vlan_rx_hw()
> is unchanged, and XGMAC still advertises the S-tag features in
> __stmmac_dvr_probe():
>=20
> 	if (priv->plat->core_type =3D=3D DWMAC_CORE_XGMAC)
> 		ndev->features |=3D NETIF_F_HW_VLAN_STAG_RX;
>=20
> On XGMAC, should vlan_rx_hw() use ET_LT to report ETH_P_8021AD, or should
> XGMAC also stop advertising the S-tag features?
>=20

I tried to address this in the initial version, but since I do not have
access to a board using XGMAC, the fix was only compile tested:
https://lore.kernel.org/all/20260729095110.164157-6-ovidiu.panait.rb@renesa=
s.com/

However, Nazim tested it and noticed that it doesn't fix the issue on
on dwxgmac2, so I dropped the patch from the series.

I think someone with access to a dwxgmac2 platform should be continuing the
investigation.

Note that the other "High" finding from Sashiko is referring to the same is=
sue.=20

Thanks,
Ovidiu

> S-tag recognition appears to be controlled by ESVL/DOVLTC, not EDVLP.
> Setting EDVLP unconditionally here does not seem to make this worse.
>=20
> [ ... ]
>=20
> --
> Sashiko AI review * https://netdev-
> ai.bots.linux.dev/sashiko/#/patchset/20260928203441.34876-1-
> ovidiu.panait.rb%40renesas.com
