Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011004.outbound.protection.outlook.com [40.107.74.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C83EC800;
	Wed, 29 Jul 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337368; cv=fail; b=osLBVQXDatWTgsaMZ2ZwHYX7TPPh2y7k/csXMT4myGaDR0/vjC6ZtWbhG79r15znBZWU6lcMR2K+n+3UQyEcJ+FJj5sq5l941f9Fgj6eZ1U/8wxsnzTlFfpa6oRtmw6I8UruBJeNKBo28HwV0wB4jHo2d6yCqRZVGfRo0KCLVh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337368; c=relaxed/simple;
	bh=yv4sRimf6+tIn4Sp9AhZtYu/csYUr+sG9hcNGsLQpAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=imsH+1tHggKK55dSzDINRkJh79yZR5A5zqMTt967hZH6dbSCFBtT8qR+YZLg2B1rYlI9cSg2X18kBfZX99+IxJ0PdLd1efUGwqKCDeXQ+UM8juI9Jx5v16qy9TLrjhZIAB8YgDCrp3qbx2b6SPAPFhcsRQiu+woi9ZzUhTWC+M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ZVJ68ZP7; arc=fail smtp.client-ip=40.107.74.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ZVJ68ZP7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSkjh/LhT+bELXSTWHYuaDxt2CTRwsAKfRnhylaZfIRCRdmo7MUMMhmxSLjpekZYJnRAWIS+AkhxS0Wme3l4VT45Ex5Ydek04PmgT3urmNiCU1CFBQtg2aNB0RocqPHsUWq1g/Slun546yDP3r85OnBZJbGM93bwoRM9TTaR9U0FMvYGY0X/KMLZiof7qcprFYhzLv+z1n47utuKp0Kk+68eExKvxlT0AaGbFWEhsW2p6KG2yKNyfQCzF4JDOmqDshpJ2P6oOe2KH6EbkEHsb8fSQnDSPiNYY5Qk8cYEVwuQBiP/fKXtA6lVEn1JU2b4NnTvgyg9Qypm9xce2lSV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA6no/avxk+JczDDrrgld7xyoxKF2/uMtpKYD5fKP3U=;
 b=ZOBaxsUMGH6A08FFc7A3gg0WpV1/RkunqRoh5kCC6yH1mvGWQ/tQmu7WRMGg6s0BMc339IIHpD5yk5fi3MroXvzQbY6RmNu7LYcNUi85zOw9cpxVVKGlcrA9wWo7puLqU7/oJUQCs/AGRPoRkiiTSr1G3I2QR9Q9ZoZhhNE2yUGyaQzc7OsVeM9sTC8+j+s+BQ5x/qyzkpQ5tB6hvnHXBlDW4FUKBYxN4bj/UN4GWig6xYDosEjVb7q5he8DP5mmzpUj8rxu0kjJygHZ9Bw3t5HnwuyzHzihxkNl2D35zdPzCzdE/PO70FhZMr0zgZQDx7s2R7OmJUhoNMk/491o7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA6no/avxk+JczDDrrgld7xyoxKF2/uMtpKYD5fKP3U=;
 b=ZVJ68ZP7BJz2sAWiV61Zh0t8sfivU2KkTIJYPfS2kUwQdq+mHmRxRwGCCR8P3eBuyXSsKt+oWRgl8eio+LEm1Q5GPS/dAOlTbq7qwslDMLRzgU2ALd4kQeZJyWSox5LFxNLZL9uWBt9eeKib37nD0W+kZOPh5rdz1EyyTHilTj8=
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com (2603:1096:604:33c::9)
 by TY5PR01MB18434.jpnprd01.prod.outlook.com (2603:1096:405:3e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 15:02:43 +0000
Received: from OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f]) by OSCPR01MB12769.jpnprd01.prod.outlook.com
 ([fe80::aa72:ef1b:2a85:fc2f%3]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 15:02:43 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "jun.ann.lai@intel.com"
	<jun.ann.lai@intel.com>, "yi.fang.gan@intel.com" <yi.fang.gan@intel.com>,
	"boon.khai.ng@altera.com" <boon.khai.ng@altera.com>,
	"matthew.gerlach@altera.com" <matthew.gerlach@altera.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 1/5] net: stmmac: Remove VLAN perfect matching dead
 code
Thread-Topic: [PATCH net 1/5] net: stmmac: Remove VLAN perfect matching dead
 code
Thread-Index: AQHdHz/WF9eFBxnHNEWfPaxQEZPDf7aEXG4AgAAzzwA=
Date: Wed, 29 Jul 2026 15:02:43 +0000
Message-ID:
 <OSCPR01MB12769620094BA8C4DFA8DE361D3CA2@OSCPR01MB12769.jpnprd01.prod.outlook.com>
References: <20260729095110.164157-1-ovidiu.panait.rb@renesas.com>
 <20260729095110.164157-2-ovidiu.panait.rb@renesas.com>
 <dfe9ee00-6a8a-418d-9440-339631b31e52@bootlin.com>
In-Reply-To: <dfe9ee00-6a8a-418d-9440-339631b31e52@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB12769:EE_|TY5PR01MB18434:EE_
x-ms-office365-filtering-correlation-id: 9dbc63ee-7587-4e52-b449-08deed827122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|38070700021|921020|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Wl6v+te5llxbtR8sm27tA3xDXUUt5kfNvypdBrrJm2tVgX1l+ElJDt4d157LYOFCDAO3yGdKONBk/6D4n1iK1cGUILG0LtF+4L3+QT5tsuuMDfVeD8shcxfj5y/fYs3kAf0kkBjPW2aeBDhcLELWw113qXlGeTrlj54J7P9wpIAbmoDroOSGJ9BJBwY9l2+tKPf3hwZ4/bMXjLV52wVNPU7sJ7Sx/oBK6ktBXO0MgiOOveHHVyRzkfu6dvJiaMHvyLqe05FjVnPIF87tKqLM4HqoD4h4Nb4q3o1xxqfBfrKi6bbsJWd9sTwcmQGMrAgADuYzWQrBAjIzzwrFP4g6T7drzk9fCsyRl3B5fL+2Sp2C7+t86Odbb1Cx4+3SeVPL5TU7DUa7InmMa2L5R4jqF3cVWtlKICXvB2q7UnG/npPu3ZlCZGN8zcVCXxAQSXcgShetNK5pgl3rYtzQLxGzGAWgX4mFo4esCRjkk0KbSB5kJqnuT3TdtNSxNTaBlclGivr2/m520VH9awF8zk9+gf+d3xDdDz6i9GnbCLfeIwU48NWH0mLmg9kLdxXT2uReQG48qPwhBNe6dcTdIhQ8nKgc6ihiOpVGzVG/2N8pWusy3CL/684qYG8UCzeUllaCeAo3Yg3HfVTrID18J2lie6ioIDJwQDTV+X+CUGWpxDWUl5WiE2E3MkZrMRwbmwq6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB12769.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(921020)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t/UIP5wTPK/0ORWzaIifrsYBJxYZsjo++Geyl6q6ZuWf6Ob0+/2OwmJ2q/+p?=
 =?us-ascii?Q?dljUWiX0BVGffIn74y7wX6jaTLcPTJnl085Swd01rHSBLFa3Kij/j5jO3yei?=
 =?us-ascii?Q?aTc8K2xyZkSgQj0I2E46XCumdfKdbCpbmX1WaDAd7iP4c9240TZZs3U3F0y1?=
 =?us-ascii?Q?kSldHa+tHvYuSjdUyiLIZie2eLIqXLqfPf3ZH2NN0lPQfSarXE6Yelr4YJk9?=
 =?us-ascii?Q?4u6h3KDHvpBIMQuR7LxFjWof+8cEl/eTtvKyI/FzwEsEDFBGqjT06JEj/xq6?=
 =?us-ascii?Q?0/Bv8KmGWVAGPlUBv9w9OVzn4AhoL+eXk7gJacbMQTlTNIGWqdOKMBW57mBN?=
 =?us-ascii?Q?DGuzFfnTa5yrnz0sOmBTJGRniB4unhoExeqFW9wxgO3hMi6egWrB0H1Z5SqJ?=
 =?us-ascii?Q?7hx5HvoRv2ENOkTREADvTynuVj9wTqQxzGmK4wbJfamA4h+QaxSaL1ncvOIT?=
 =?us-ascii?Q?g/ghdsaEJ4/0thufRobOT1M5OGc/fcjo/Ga3qCcwg8gFgEkvOZA9k8QfRjkp?=
 =?us-ascii?Q?ANXDI7tNYZSFqPlXRFsX8FYs3dIn2BJn/8eSCxUV4n9fo+BlWZwBB83OvaJm?=
 =?us-ascii?Q?0hDLTtcKIczOmKXUIUhdKzXiTDnlpvlaNdGZG/78s3VrzOZOWnf9Y6CCapmB?=
 =?us-ascii?Q?Flt9m/m8P2pT2LbNt99vG+vmYx8rPeqTKx83fR2/yYhdAZKF3dNwEFRqnjOm?=
 =?us-ascii?Q?G1Bf3DlpkWtO1pSV6AXW9aCq7VlOXrynV0Kima6NEiJYqAGbw8p8m34vtZXH?=
 =?us-ascii?Q?N6CB5mXaMRo0gsy7BZCKm579kOW7TImNE2UmddCVGgfThumE7DDdvJpnpudT?=
 =?us-ascii?Q?PiB7vtG7Jxl53jD8Zdl8BE4xwwKElpAdqZZnKfM9abu6KNjRH/iWHMQyjg1v?=
 =?us-ascii?Q?i6HR83HqeMzg9Au/cWWhOkthrf5keGgzKCInwqPJUw7yq8BV4fB+bcbhZwsS?=
 =?us-ascii?Q?UdJxaQ5CVxxJPeC56nqHNvxfzE+r6BZe80BoBoe9hzG4Mimu7eZtpf8PazVZ?=
 =?us-ascii?Q?KiED3v6HYRd3Dn+SFwfsVNUcxfpG6QGMkBbsW5tIaaCddyFC4HIQ8HXLn/sH?=
 =?us-ascii?Q?qH5g+Q4s5cXa8mdaTf/wX5d1m9C1O20+XHU7YyXJ+1CF5+KjTAq9hJd7FpiA?=
 =?us-ascii?Q?J9ZRrH2uSdbWCx79TnDfKcL8xsCy79hWmfkBO0Vz1aL53Zu6AIY4dLSZfCx9?=
 =?us-ascii?Q?SgTfPYPwni6UgnEArbySIGn9eMkYOqMsu7JntO5crmLfpiJEekMPZCURmoVy?=
 =?us-ascii?Q?NbX42vD45yjnM09JjsT1Rn59T6E1GeOlDn0/ZPZnYFOu0bXONCEzbX8OSDVT?=
 =?us-ascii?Q?MuTkxL1UY6SUPttbw6fEZLfhtoIO4h5wNgak6I10pVoDnvO6SOMaVmtRwMEH?=
 =?us-ascii?Q?IfdfwYonGs2W2ABUDyXWBbydfwtro6FuO3QF4DDnfwl9jNJAa1i07iKRZSMd?=
 =?us-ascii?Q?sPVqnOvkcSohoKJXn09wTA2PT4nqNOPVUIcToD+/UtAV2XUtJH5V2J1qRo78?=
 =?us-ascii?Q?qfD0rngcsFnNkUpOYA+YGow0ghHVV0OJOHc3p2PE5D5oMDD0qltgVT4GdB8H?=
 =?us-ascii?Q?GQogo5Fp5GJLG+TF61l/wo5DCkL8fO5RSTqvDh1P6gT3pCRqhh6lbKL+Qj1P?=
 =?us-ascii?Q?9kIP0h7E5TMiUT1FhhjR0fnVDTAKHk2UL3UOSp0k9Og6K0vyB0pFgSHVEKgG?=
 =?us-ascii?Q?egr4u3KTVCYuMAHeUdpjFISvIjD2NCmrmUnjQkCGyM7gBLhCqIJiQoy575RZ?=
 =?us-ascii?Q?lVYiQe73MlLkECXOMKtmHxeaf3Vei0A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbc63ee-7587-4e52-b449-08deed827122
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 15:02:43.2582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n541kjoulzry53bbC/SwAPCei8tumEWwqNw9zsnywPsbVbxyClYlpdgHoIXZvN9T4CnWA4uJMl7kpWii9zmr7SxcqMGiX+eHpEM5SdNS61E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18434

Hi Maxime,

>=20
> Hi Ovidiu,
>=20
> On 7/29/26 11:51, Ovidiu Panait wrote:
> > stmmac_vlan_update() falls back to "perfect matching" when the VLAN has=
h
> > filter is unavailable (!priv->dma_cap.vlhash). This fallback has been
> > unreachable in normal operation since its introduction in
> > commit c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering i=
f
> > HASH is not available") because the NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER
> > features are advertised only when priv->dma_cap.vlhash is true.
> >
> > The fallback is also duplicating the code in vlan_add_hw_rx_fltr(),
> which
> > is always available since stmmac_get_num_vlan() returns at least 1.
>=20
> It's not exactly dead code, there's an stmmac selftest for that, see :
>=20
> https://elixir.bootlin.com/linux/v7.2-
> rc4/source/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c#L973
>=20
> It does exactly what you say, it fakes the fact that we don't support
> vlhash,
> then exercise the perfect matching path.
>=20
> But is it correct to drop that feature altogether ? Or should we just
> relax the conditions for NETIF_F_HW_VLAN_{CTAG,STAG}_FILTER to be
> advertised ?
>=20

We are not dropping the perfect matching feature by removing this code.
Basically, there are two perfect matching code paths that duplicate the
same logic and which diverged over time:

- vlan_update_hash() has the "if (perfect_match)" path that has never run o=
n real
  hardware (unless running the selftest) because NETIF_F_HW_VLAN_{CTAG,STAG=
}_FILTER
  is only advertised if the core supports VLAN hash filtering.

- vlan_add_hw_rx_fltr() also has a perfect matching codepath, which calls i=
nto
  vlan_write_single(). This runs unconditionally and overwrites what
  vlan_update_hash() did anyway, as it runs after stmmac_vlan_update():

stmmac_vlan_rx_add_vid():
...
	ret =3D stmmac_vlan_update(priv, num_double_vlans);
	if (ret) {
		clear_bit(vid, priv->active_vlans);
		goto err_pm_put;
	}

	if (priv->hw->num_vlan) {
		ret =3D stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
		if (ret) {
			clear_bit(vid, priv->active_vlans);
			stmmac_vlan_update(priv, priv->num_double_vlans);
			goto err_pm_put;
		}
	}

This path is also more correct because it takes into account cores that sup=
port
extended VLAN filters.

Therefore, I think removing the perfect matching code in vlan_update_hash()=
 is
the right choice here.

Ovidiu

> Maxime
