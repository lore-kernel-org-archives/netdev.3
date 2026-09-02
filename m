Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17943EC811
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339426; cv=fail; b=BhOZXFyllQ/6sLdz47bxAOlhrWMdF7KORf6hVR+FO405TfOCIdf0jTQns4pW8vgDDKl8WkIIoWIV4F5eEoasEDM5k9smZdqcrvfW9CSvKjE4wsee8cV7FO+UuqT4VU1Z2HJu2IyZx0VpQPRnF0HdNqEw91uDK8j6rL8zgtnZ1yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339426; c=relaxed/simple;
	bh=tVmecpdXJj3cU17r2acqVz2rlw5hOT1/cUwWQbd7Uzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qXv3N7MT7lbnHqJqk4CoGhxVlnyFlOYeNJKR1hLyjDH6qlAXIy4hZSJsruPMC3HZFNqtO3f2H8PqK3R0A9HrTNSe6BKD/fSiDT2KNZcS5fIgwz1QxGCor1B9NWdHtmr/8K9z0wjO1dEwQ+jL2y/NvCjVYxkbeiZQsY9RPDEtHhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qbz8K344; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qbz8K344"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+DN+FFrb7EegVejMualbPV8cwqRfAbFMwhqq1SvraGuEE/7XEQBUaN4LpsYsVzvJW1DvRzIpazZqXgpotIKBT3uXC1NoONCVGSviEFl14qyRH4FBmp8Jnw+F5ViZEYnSElN1aD0qG3FKPNlWwaLJ6lNWcIdm5Xkm/mBKG4yyv+v/w8TkE4fIEEww1/hD/FgvfsxtD9jmsIx3GGkhVUnCt7uTKkjGL5gjnOB1/CYbuS87LY4ojQZtN2dN8g6z5Afh4ooogcUj91qFyruu1NnQJYj1qpW7Q05ZYJ1gc3DtrmJMfY+ziZ1o/w5864UKJelvUS1PkJlYvUR21sI/GPJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZONzLryBlvdasgQFZoMhZKZOlAFYfAxxzEB2MFmWTOY=;
 b=VzrvxmZbGfx9Tm4BPnTmNkcZXyn/F/Es8w5yZDrB9qPtIsvYcpD5Nr5SfBhI6DXzweArTOyWMIBjjSTJTDo+xFR1u3djNkgLmTSRkHaEII+bpsg2g6Rzfgb2a5flV5yi/jz8h5eAFDtFKyYhJ1y5StOHQ7By8oKkiIUlducKBBFbfl2zG5E/fyz7SvWn8vgbdbDIzUVKGOhK4KmZUvb01+3PyLlr9DT1ovCbpWI8mg/GOPFOhEMVIy9wwGp+Xxq6RyUMCX+jxSzTvnzj2Evk4o582NeBXDX14V31vbWtBZZnW3vVn1AjIRdABMfBZ8Tb6GtIfBHIBSyxa4AlqHxoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZONzLryBlvdasgQFZoMhZKZOlAFYfAxxzEB2MFmWTOY=;
 b=qbz8K344Yg0zybiwFGaZkAnZAmpWNPFFCb6a9tZOonB15ZxndgW9gC727OPnuRx3f2QQ1pK7zRe93ka5Pxx1qSAIjQc313+bMglPw4dNhej/rl+Dk30ZadC7lw3PwhxUdpBxDJxeNZTbXZb8e3Bdr/BrVcjVkcO7CwARpRQOf+uO5tKwevQLLQCjFvo/8RjfcLHqzwb+Bwino/calbYAsCuXFtDl0rfCKyl9J2DeREd3LYcCnVUL9t8mciykTM/gtKd/K+TqUYIdVi3DYkhyYrsLNJheMznlgyOJq4ja33o1j+jNkeVPuGBh2rDRfn/PdGy+CSX3jKwIAz3RPCyX0g==
Received: from DS7PR11MB6102.namprd11.prod.outlook.com (2603:10b6:8:85::18) by
 BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:57:01 +0000
Received: from DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559]) by DS7PR11MB6102.namprd11.prod.outlook.com
 ([fe80::5cb3:77bf:ac73:f559%6]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:56:59 +0000
From: <Divya.Koppera@microchip.com>
To: <15815827059@163.com>, <kuba@kernel.org>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <huhai@kylinos.cn>
Subject: RE: [PATCH] net: phy: microchip_t1: fix NULL pointer dereference in
 lan887x_phy_init()
Thread-Topic: [PATCH] net: phy: microchip_t1: fix NULL pointer dereference in
 lan887x_phy_init()
Thread-Index: AQHdOrXaZ8idTHfQlUSaezkpNojbJ7a6+25g
Date: Wed, 2 Sep 2026 08:56:59 +0000
Message-ID:
 <DS7PR11MB6102A72CBEFA5A8EDE857FCCE2B72@DS7PR11MB6102.namprd11.prod.outlook.com>
References: <20260902083342.221050-1-15815827059@163.com>
In-Reply-To: <20260902083342.221050-1-15815827059@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR11MB6102:EE_|BL3PR11MB6457:EE_
x-ms-office365-filtering-correlation-id: d5d0cb93-a0aa-4c55-e5c7-08df08d02612
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|3023799007|22082099003|56012099006|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 ZnWwXl/nUGCjMhHCUM7JSpAZyRMDzxfpVzJcrD/7CzjiqHXVGHBf8bK/VwWlXVtJEdhcNP2h+JmlRSM7wzrkvmSPZVXuNIcVxAIjok0buFGHSt6o2yzDN1DVSN7yrixmM62jKDM1cnZE7Y9RFebGGGEgaBQUZdUj4BKJjiYPGCC7rlTJbFb7rRE2nNZ1NCHkC3qbUuBIYdv0xVnSKCKzjV4DYGl72O2wBgYjV9h4uPP7xmFAZBbO+/D+hAXUHlA8gZ0uzqa5QwAp5kewW+OboJxDA+pgheTPQR/bxA5X1YFF85TCvLnLk7TK4JStfZdBxWLo4gewaI6Vz3jInkWSVcAuWtHbTroOYKNyaNsBFLXHwTZ2wa4tbPVvwMCL2HJSnSZd0oeOn3aLPUt8x3fzP/jv6dLW1bX4bPVbx93cM8xExfaXO2KfFt5dnNIeMWmIxwmwhkEmZAnDNind6Gq/ILE7uBSPaey+BjQzaZeFJbUJHwe6NkMNfJxD5ME30RxDTO314EK8O8OUdDXkAuH3rYVqIOtZimZbBUhiqnzWHa6iaQYEwGgi8X0mqqvCLf+1oCd1OG8WeWXFEWRUfkm+4GW0al+dIzVAVVyQ3CCY92xfXzcAEtMGDEbymOG4HGa3/ZAIqHULx06wFjltGONoLmY28ECg2h/p+3auVtdQjRZ/vlbDmm4MItvcoXpoMOzbMf3Eyz/ILUpMzrCjlbmzrg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(56012099006)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ItHp6rOVn+I34jFkIF6Uh8U2ZSNQR2RAgCSHv+AaZsxj2XBC9r2K/g6lqLtq?=
 =?us-ascii?Q?dYMJcHc8JetamaeVGjjwHKXv4H0EDeIgdRVwBZHuz4NXnEYCNJpT8hICryIx?=
 =?us-ascii?Q?q/MRkb4SbrH6lAFUV6xF0rxhZ7tPyIz7QNGnB/Qt/HY+RpfRNg0mVLE0tiAa?=
 =?us-ascii?Q?JgHzPc5TlVhat90F0TspGJraBfBD8btM0i3tqLnCT2eDCzcHq0vO3/UuUAfv?=
 =?us-ascii?Q?0AGHSkqwMezVy94vD8kZ6LmMZ/EL2X9IInaUkBkLiINKtpQ72zfq0TLrFPOH?=
 =?us-ascii?Q?vA03bEGOH81/n8BoLpIJpszEh5+NTjXbZGFF0AItb8rVL24ZZ0Ye9vc1kYvD?=
 =?us-ascii?Q?PxfhQObPhi9OYrTStsaB12d1fxr86XeGm+ygXorz33eadL/kT7jUCq2VINed?=
 =?us-ascii?Q?bImIWNTwsW4/b4RzJb/AB9ZrG5uuth5T38DkSaGe7jXmFXP6KIigJCTw2qPd?=
 =?us-ascii?Q?g+UlBcuOiGId2rOl+FtnlmoSLi/2vrF57uBIuPblJtEDxRXFlRh9lx3PwX6f?=
 =?us-ascii?Q?R9N8+IL3zy2QwV+9mH/WdSTJ/lqT3biuHvgRsLnkNfbuIzgsX35PFaTvDNgB?=
 =?us-ascii?Q?sMVMW3EZfg6oUdjNIPuNUp06ztUc1Wq93LRt6vPg+PPWiwLZJzXimtoMV2lK?=
 =?us-ascii?Q?oCOzn22KxfOtULcdGlim0U9ze53MmR5IUVMVmE6G3Gsgs3eNGfiWZH+DiWbh?=
 =?us-ascii?Q?k2+zhJtrUwuKp0vwwXuFdGUej/gGw4h9OXYpOGecimbS8kxr2cskhlqC8XD+?=
 =?us-ascii?Q?Gf4vT6mbYF/PMXYBrexj/QO/BashGPUfbMv6bYV7MlV//bbakpsQ6IYInwPD?=
 =?us-ascii?Q?foT7iVrM4U+DrfpjsTe+zdsssZmcI3NPrWbWb6pVNZU9ZsuInKVYVB7Ew0uE?=
 =?us-ascii?Q?k9JwyX6VXkvsiAXx9SXFfoIndviyd5tSuW0uDNh8nIWtViJul60dGg3lYs7M?=
 =?us-ascii?Q?oJS+ToarcQQ5sFy/wt663W5kpGA56jkN+Oom6th3FbiQ7OiFqQKq5itghRAW?=
 =?us-ascii?Q?jdHKdS3yFbiWMlai/ZcYKFxc7moP/2roQYxjeQKqJy9fCfSDEJkb8xAqA0XD?=
 =?us-ascii?Q?k5SomB7vVNCxxXil8x+pVt1DYYFt4Rja++vHHo1ZBoZWXtX4/h0g+mfXjiS9?=
 =?us-ascii?Q?kbXpZNIdN4EbniKhMVy1dlNqhp+ohNPLzxM09vkzR0mko6+w2AIvXYb89W5H?=
 =?us-ascii?Q?EomK4kF1IQJeZq5LjdOUYaicroTVpk5m8DJ3jy/9PldLIruqXCryZ5fKDM8F?=
 =?us-ascii?Q?w/K4B3oLY7Z+vB/BwlFPAtJ10hAjOOQOncRdSRJ3ZKL8BxVCIlTwZWibG72x?=
 =?us-ascii?Q?BGGXdq41o39K+4Os+UHhhlXydQAl5490+PyaHiFjFwHmHUoYVtvN2pLDcPDl?=
 =?us-ascii?Q?uMEhWFosafi4rEVBM6nZFlACYFDrDOSUWygOkyiEAoW8FQhwqEHEFUsOZYPz?=
 =?us-ascii?Q?+qus/q9c34TYUoyEGURjBQvQwX4zYNhVsJWVZSHR4s/xSH2DqcMHbKBPBX7I?=
 =?us-ascii?Q?Yp9D8GLOlfYOKjwU7kxFXI9PMRmAACJM2LpcckHRRg3e9o9TLRJd+vIMPS+n?=
 =?us-ascii?Q?BwiVFP/CCUYuqMIBd7jKdD7Cgsau6A/LmV3KZOcMAxquX+JFzVlb7GvPd95g?=
 =?us-ascii?Q?JJSlW8Ku8XZkoX3ik/RzR9lZwiCSa2/WsctgBt88BrlbHyOQoD9YsXS97nsr?=
 =?us-ascii?Q?zUV56Yjx2aDd4R2n/P7Q96z/s0PvTITKis0ey+uQFSrNNNsVRTAGYVWFd8ao?=
 =?us-ascii?Q?EqrA1nIWZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d0cb93-a0aa-4c55-e5c7-08df08d02612
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 08:56:59.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YFb7cHnJWs7NtDH0lcANrTZ7Fb5yWOeZQp0ajGxFfmncr4bsBUM7wgbqSaRaD+HE/UU+b86bmh0RSrtDahAXKBhpy51vXoJOvkwtueoPtDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457

 > mchp_rds_ptp_probe() may return NULL when CONFIG_PTP_1588_CLOCK is
> disabled.
> lan887x_phy_init() only checks for an error pointer before using the retu=
rned
> clock to configure the periodic output pin, which can result in a NULL po=
inter
> dereference.
>=20
> Handle the NULL return as PTP being unavailable and skip the event pin
> configuration in that case.
>=20
> Fixes: 8541fc12edcd ("net: phy: microchip_t1: Enable pin out specific to
> lan887x phy for PEROUT signal")
> Signed-off-by: huhai <huhai@kylinos.cn>
> ---
>  drivers/net/phy/microchip_t1.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t=
1.c
> index 3292b2235c8f..e38d20bf6aa4 100644
> --- a/drivers/net/phy/microchip_t1.c
> +++ b/drivers/net/phy/microchip_t1.c
> @@ -1285,14 +1285,16 @@ static int lan887x_phy_init(struct phy_device
> *phydev)
>                 if (IS_ERR(priv->clock))
>                         return PTR_ERR(priv->clock);
>=20
> -               /* Enable pin mux for EVT */
> -               phy_modify_mmd(phydev, MDIO_MMD_VEND1,
> -                              LAN887X_MX_CHIP_TOP_REG_CONTROL1,
> -                              LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN,
> -                              LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
> -
> -               /* Initialize pin numbers specific to PEROUT */
> -               priv->clock->event_pin =3D 3;
> +               if (priv->clock) {
> +                       /* Enable pin mux for EVT */
> +                       phy_modify_mmd(phydev, MDIO_MMD_VEND1,
> +                                      LAN887X_MX_CHIP_TOP_REG_CONTROL1,
> +                                      LAN887X_MX_CHIP_TOP_REG_CONTROL1_E=
VT_EN,
> +
> + LAN887X_MX_CHIP_TOP_REG_CONTROL1_EVT_EN);
> +
> +                       /* Initialize pin numbers specific to PEROUT */
> +                       priv->clock->event_pin =3D 3;
> +               }

Reviewed-by: Divya Koppera <Divya.Koppera@microchip.com>

>=20
>                 priv->init_done =3D true;
>         }
> --
> 2.40.1

