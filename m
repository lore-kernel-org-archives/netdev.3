Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A32DB798;
	Tue, 25 Aug 2026 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623444; cv=fail; b=bSALoZL/kQbV+YSnkoBNrMJ2KFptdkKT5ZeZUa8Y5dpm5RwmUIafTgA1L8be9a1dhvDyF5TiF+J8qo3pkIJWlvH+7+knLsCIP9+2WHUt2Dr/GwSopNwzusppc2Bb7TOaFRCM9/okmYk/Xu5Mt7YZBsZETygrnzB5HfU5x/BLa0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623444; c=relaxed/simple;
	bh=q2X/nAp2Ht2/ucRD4EzGJQ3AdffRU+R4wAnjQ/634XY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFw3ckhdHHD0+RxIa+lKJBgnmICEy4mrNwY3mKL6oDzfdFLAjoNhMZprdx33NWm3LhUrvz09J5C2c1lxwuVnF8pFy3/LUhbDqjZZUyzUZs1cbHE1HZ312/QBhQFtLt847ZzDAYH64NXdtrl2m6Rk9zqP2lGCP4O8TzsKvmxVWhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mO7yYDqe; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mO7yYDqe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhenBisV34nFnya1VCRSIR2kCEXuvPcb5iSZDPZ4Dl/JtwlSHTGVvg2QKQaTEFzHHRQTLX37MfXeyZbEg3z/12kqXCfHDD4CCD6Oaj6qPdg9gq++ais/BBTp6cpHNrLDoZfFAaHb0DMfiYtReDdnoY9mjuiQ/yzYD8Avfxkgl1s8yZY5JAPNHGu9jdJ+039uOQW2F1rIHjdkEICgUin95donJqSLApm+aDHGivI3Y5IPk/Lbj9nsL5uXF9V538kVXlTI1DmaeXLWG4cfJUihlJ0MBr4T8JlXq7zHwPsVgxSDn6nTsCMREdHHvl69k/o+Df7ROS1asDnLSdfKg9TLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LNmTxWUHQJSQI27pBX/GAVxn37VTPNge6+6l5n/yh0=;
 b=iU/PSvL6wq8btIRhidLB33Vo/ZdGAsr7gB7EK9/olVFrYzf4Za+nAnNJJOh6ACLWSVVNe6ly6RSiG2Vt0Cd+53KVKTsLXJAVfJfZ22flxEZ6d5Estk4/NkdDk8E0ELv1EWnu5nit7fAvRbTkBN00/tKSJU7lY77Z4FDoF6nZUwB543RawtHTkPvoGw9hKt+Saly0P+cfdRyGa2/2+h9dUrMu8WdqxAoWpEZQFMyDcoWSHE10UvNIyBLyv4jnQ0n0dXfMnIYVn5ZI8GW6KFRTvwBjpfkDW/6xiCdl74/X5WEoVtF8WCPbN+8COrHCeuWMDdRbMiIfJ+lbFyXTK/bPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LNmTxWUHQJSQI27pBX/GAVxn37VTPNge6+6l5n/yh0=;
 b=mO7yYDqe2eEXRoOuak/UzS3nMCs+kjfgnQzvHxm4pfoZe8mNv02+kgWDR1MvezuQnJWyeFzzNfIcee22K892PIpGYbI4iPc+UJvVg0UTGb7oJuUjnWJjUGAMg2OOvBUHq6oqGChV+cerAQE8zYXrUDDcIq5Hp/26cyZG3QrkdR2kTiXgNCmuHyWfH7aGmzAzJf0DzYfEqzxDklrqPDjmzatdB3V9k66aL83t3idu4C8O9Wa6g3TaVgBaNR1blhjeN1fCXEAm5NBDjq+hsvIsRB139T4mVjjDm810FSAAM5VqtVbjUVTpOYIvhtSuRUwDMbEmqEUj9q2fgrkpprIHYA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AM8PR04MB7283.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:03:59 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 02:03:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "phucduc.bui@gmail.com" <phucduc.bui@gmail.com>, Frank Li
	<frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: fec: only stop PTP if it was initialized
Thread-Topic: [PATCH net] net: fec: only stop PTP if it was initialized
Thread-Index: AQHdM7CT11Cgo/bQ90GlTvYIf1N7nrauBFoQ
Date: Tue, 25 Aug 2026 02:03:59 +0000
Message-ID:
 <GV2PR04MB11739802F62258CA8CB02BAE088AF2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260824100834.31655-1-phucduc.bui@gmail.com>
In-Reply-To: <20260824100834.31655-1-phucduc.bui@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-25T02:03:04.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AM8PR04MB7283:EE_
x-ms-office365-filtering-correlation-id: 6aff9964-def8-4b73-4e98-08df024d20ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info:
 hwVowtX6UjqspkPMnHsHbsrbMLBuRDJfdlqvzen6PpLCmXx28kqMkNxQ6I1k8U5MVMFwNt6i5KjC1md4soqvU7i0Ag0FL+SkXwR1Xi2pi1K7OBl6kbO6zLmlfV0uhQeJcFAlMGXL7OXxyuHTy/CbZa6pnE5IY+QFs0teTTJoh88xTkmKA9X4pzVGd++pWyNTMh0ZgHuqD3zA9Tn80AyCaB92iuByop58wlC9ILmnJaZrXwip6vtPfhcuV/xQy62vScP1xaYgHqfgAPc6K03dGvBGKhW0SidFoqTW1I6MieHMinRXuwbte/pw3S+yaytL2iWCgz/0Q7npFcxPEqoi2SPRFNAOIFHZ3XdqM2j7HZ/+l8P4VIYQdpBwnyBp6jOqy+jTfif9xfdGZAsmRCVUleZPR+VghALnucRlW8a/PbML13sjJ//bVp9qdcfmUySZq56cHz2LiGfRy46TROtOmBS9QlAo44jTIWW9n3HUuGqyRbdKOqYcPRSIGXIkzk63INGPm8hgJ0Qk/NNaNrPsRnXx2fCvDh3UljvaM9UVpW08M23s/WajCLVfk75iVLes3ZjZ1ltHuuIMZEBsdoqu/qhrNlm54L8b/Q9QMpzv7yL8aPIlADECdQVfIu2YQGE+TNBEFh/bPf40aovBcUEz1rw6QP41NtsfIA8qs59Zz6rQVLM4ekFkoGR5EzEmacvGH/tIumNrEX7JNP4KHLaTaL8nk7lFoCUZA2EUG3hgJkw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?106HRr0hKhATNMM8yD2VJvAIwN2WDy8Xx5NrJie6coC/9z+gEhyUxfo8Lr1w?=
 =?us-ascii?Q?/wM3RF8//s/EmpPbB3+3cLNeddenIyWZ8DlkEMue+/4fI6dvXrQxa6hdOcVc?=
 =?us-ascii?Q?4tu4Le+d3By2i1gWkaS8VaKXgzC6EZ4PnZMOP1ZDYTMt+fTU6PCXgtx6e3uy?=
 =?us-ascii?Q?uz+3JDWuEol4cbAuDuLi+EvB7JIud2mINxrn8/EHkoaPf+0tmwMhTd5cvGzG?=
 =?us-ascii?Q?BkC4A9Kh+C+2Krt7MpK8jcMJchSnG++EMxoJVuUYu4S7fCfVXECNfC0qtSb6?=
 =?us-ascii?Q?LIi2m0NE8v00+QJ/c2AMLiCGgYWvdIthcMuvGGcAc++BN3EefUJWgKhfqg54?=
 =?us-ascii?Q?5LvrHkFv+FXNU2ZhCq2ix8wA9bVeFTH1jxcjQsXtIc1zLUcWapf7F0x439Co?=
 =?us-ascii?Q?eZ/7DaVGZoSgT49GHsINUzVboCdAcmOYhmGtnVGZvvMr7TgWdX2yvZlWO+7O?=
 =?us-ascii?Q?xIEONZLtI7bb9XX40cEEgZb7GXGRlYj8SfWsa3ZkKEqe9wyRn+T2/1bt/zD3?=
 =?us-ascii?Q?YITi+sQYOr9ASIykTyr6Ltv9HI6h16c4lPBq2SWRjIYBCCpPLAK4WEERJNsW?=
 =?us-ascii?Q?CnRjWPeKP2/V6SB8B3+w7h7ZKFi190DvvFJl1lo3ern/mGCIW/xU6APAPwvn?=
 =?us-ascii?Q?R0/JANQJUiML+roU3J1nSBXJswH6rbYZXntEBRYTOcN86Rzv1LcB25elmFlP?=
 =?us-ascii?Q?03cTMpvcPNiNuoA3kct3KAdQG05to5b6o8Ep8w004kJ514P6Haeuuj+UhkPC?=
 =?us-ascii?Q?gYFmFs7sQ1p0ExiO/UMDQkTeTAv2bf4u0BhyJig5IWRaog8DjqWhSheEdg8j?=
 =?us-ascii?Q?aI54troRKjv6BZXCk+z494wynRAZPIeUM4R6op24FXXkazpm9md0CpL95qmy?=
 =?us-ascii?Q?QQJQRgNbmJRYz7oYXgdeB39EIUyHfnqDGMGgo/cu7E9JB49N0vbMcKXPQ2MA?=
 =?us-ascii?Q?Snmhz6lXUh2mGDWBEVUkhfDyEIIk0qefAvzHI+Wz0kTQyUJUAaAQeh+wl/Af?=
 =?us-ascii?Q?AlQRBVTRICkrew5/YI2R5vfuU91lq5EwI0sGSAeamlUyzyWHoL3w9X1TGJQY?=
 =?us-ascii?Q?bV1PbdFxgdG31lEaM6ssrcpyjb9zWF0esCVCN4+40lYv6gsO2S2KGukfUftX?=
 =?us-ascii?Q?TmjAj/DzWDzeKYdfdd7xg/238MwoP4/4/oDlXMUs4uBcdLt02uc31XVeTqmk?=
 =?us-ascii?Q?hL6IGvO2YHf4AJ5YC46ZyGqyfQqFGTrzKUg1P6rXz+7/fT9O7wetN/c0nDAb?=
 =?us-ascii?Q?SxP2GEvUT/h+oMBzetbblJBQFn0SELVX7TNugxousFP1W2jEiYlid1onzxag?=
 =?us-ascii?Q?V1I7CvQx3BgJSMdtqBW1Y49BAg0WCBZgABgpgP2URJj13attyKGsSM0sIWxv?=
 =?us-ascii?Q?f/eHkdZXqvXkCKOSJdvJuWgSbCvqjegKNBAqlg/Tlp9fqOEk8gmNM6ZZj9jd?=
 =?us-ascii?Q?Dia4Y/ioIbCGBqFd6X6TJi6/KCC5ttZw+CPmrzBvS74Pt16+KqKmhF9un8T/?=
 =?us-ascii?Q?KLT880DqKxdU5GbYlWSpcJRU63kZosb7iW4+L2/nXgMLqC1k2zN9M6NHbxLR?=
 =?us-ascii?Q?A71HDsOw33yG8OJBx9Is1k7bxkWfPfBBrGgaQfJPZvDInB5LwUHRrBzPeAdG?=
 =?us-ascii?Q?Cuk97ldtsq0Zmug520LxmuMqYIgzCto/DQQT1KOOcrx4lVIDqJR25VTZBzo6?=
 =?us-ascii?Q?ufCE1VPGo6ugEi7cVim2LRVt13NFwaR1ThJSqxjawbYR5q/1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aff9964-def8-4b73-4e98-08df024d20ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 02:03:59.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvZpu9HalXT0cdyFwJceCByOUBUcpwfn4+WlMD4PfoKzIVLjx7DuBBZxhO5Ar5T3VPxLtXAKhiTtr3OMyBO76g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7283

> fec_ptp_init() is only called when fep->bufdesc_ex is available.
> However, fec_probe() unconditionally calls fec_ptp_stop() on the failed_i=
nit
> path.
>
> Check fep->bufdesc_ex before calling fec_ptp_stop() to avoid stopping PTP=
 when
> it was not initialized.
>
> Fixes: 32cba57ba74b ("net: fec: introduce fec_ptp_stop and use in probe f=
ail
> path")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index ced4dbf8cd90..7a87f40d12d9 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -5457,7 +5457,8 @@ fec_probe(struct platform_device *pdev)
>  failed_irq:
>       fec_enet_deinit(ndev);
>  failed_init:
> -     fec_ptp_stop(pdev);
> +     if (fep->bufdesc_ex)
> +             fec_ptp_stop(pdev);
>  failed_reset:
>       pm_runtime_put_noidle(&pdev->dev);
>       pm_runtime_disable(&pdev->dev);
> --
> 2.43.0

Thanks for fixing this issue.

Reviewed-by: Wei Fang <wei.fang@nxp.com>


NXP Confidential
