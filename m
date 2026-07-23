Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82CF30D402;
	Thu, 23 Jul 2026 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784779574; cv=fail; b=TXeMM4jGjkiXNUin7bMZROdWYq/TueHIrHyHWW8tzY+BvIEy4/xUltdNKFriHgGBGz++OVxlD26LeVYIE6Y92CBj0Xkty/bkI9bsvnis0uuyjp8F4oq+WAPG6gnUEg/3wa0yIbPvyKlPwJuZSNcrNRRt+LsoTjMOl16GO5P5fiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784779574; c=relaxed/simple;
	bh=VFMobOBLDlSdemb63KtYZ0mvDPEz0fBqyQwdIb0gG7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTXPNe+zsLZXQAYFEp7Sa3rujLm/JZStsPlhETaDviHwi1bo2YiBLwaZh2xwpgtmcEQpcJiJgx8NChlVJVwi4qWm93U4lUAT4YjWXd1zhyYFK+N/rUTxEr47G9Q8TVA+DzmCgFE3KJBGycTgo7Z2UGCZ52GnsxVbyyRqMe0gDLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GiqIN2/t; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GiqIN2/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRzMdTvyn+osap1AJZK90jWpzqvu+zNR6G0UtSgsSSiSnxb8T+vjOUuClWp/12Pi91I9PgTgnMaQDLsSFP9xT6xc0VuwnFnZNYnssxZR/ojR+ZrJCEo7naRKP9WHao6vD6xH4lBiu2A7Adqm2ki7f6rFTW0MIHN+mDR2IY/pP49Ioipj95FWvBrHY8rXG0YGxXUJnVw6JxgLXsgm5EaEHUSyArshE2ZTXFS5WoWu5nuuQxcdr/AIyBbF8Se7bSyxILitQLsldRqwLeHdJAYjcku/a7aHvfAF3OXO98Aqzi8Et+iZrPyHsRnhGMA9Dn0Wt/oWRkvEKaK6qWvKTI841w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSMWqyYv0zDzCNIInQMZWTZASnrK4PJ82khEA1G0P/A=;
 b=WZ8YnPoFyLrOQZWeSpwq32ZvtuCx7QWfT14Whh7TDuhL3UBAMCuLFzYX80FiFzB+lh6NSRUpNTb79gOXJRFF1ge4QWXVlZ5wqw+92Suqbqkn/4VgDcv52xv3erkMWXGRdghxpALstB5QvLCTzUiO7oexfLSUp4u1pfUJ+2LSoqcY286JTetWptvRtOUT+aq/WUfje+wHveDlIY/8k5J0cuntzh4qWBGEzGa0/wvdSf6oEWTOHGMxgvC/+DRx/O9pPNEm8/xFOaLLDSDfi00/n8MbSAf60+Mr+sIVmEzieSR86d5V2L4s5ntcVyK1tj7cV/oXRmhiO0ydKXJ9KtoAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSMWqyYv0zDzCNIInQMZWTZASnrK4PJ82khEA1G0P/A=;
 b=GiqIN2/tapzcLhPAnKjCBUMlKC0I8a3wdvhw31yY7ShgIXKigk/H3ATrr3RR8OgF9Rk9rufisN1iH5TgE5Wb+5CyR5M5g+BpXBukDf8bdNm6cm6+iFQeE9EoTktWDhIi6O7DoqZImdww1h0Ug5bv6+kXBu0x591RK9D54gZuIEyuZ0DSXmEx1M6qq59m/iwrfQyxXVuJLh7TZ0VaUOFXVc+JqponFM7hijUvCGosfyH/LOgAa95Pnrz/Sw2yBcltlW2l5++it2/HwIAQMpYAYRV+7Y1TWPqig+fla/uTNB3sQ88mr6BBoUbpxK1lFn7X+aKNracQ9elux7rxzVr+Gw==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 04:06:06 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 04:06:06 +0000
From: <Thangaraj.S@microchip.com>
To: <nb@tipi-net.de>, <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] MAINTAINERS: remove Rengarajan Sundararajan from
 LAN78XX
Thread-Topic: [PATCH net-next] MAINTAINERS: remove Rengarajan Sundararajan
 from LAN78XX
Thread-Index: AQHdGd/hcsVQW8BMJkeWbgiz+YJFNbZ6fSIQ
Date: Thu, 23 Jul 2026 04:06:06 +0000
Message-ID:
 <DSWPR11MB971510720770B200DF0B8C97ECC02@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260722134143.4141579-1-nb@tipi-net.de>
In-Reply-To: <20260722134143.4141579-1-nb@tipi-net.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|SJ2PR11MB7573:EE_
x-ms-office365-filtering-correlation-id: 2725b13e-f9d6-4661-8b84-08dee86fb855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info:
 e14lAExIrht/e0d9fvE7GkpzRbcnu/zWdDT7/M1z73m35+TsSI+cWlOwZJmDpE4NkJs6tTS2UA2N2HE5wsq3vGVRAx5uZuh62sfL3EGAZOVsJVcsFuivhFOS1PPtlo2F2X7ceTYsnTmllznInzHWEFVSjtbl76E6z/fDp+EGVBrCFIozs58INvbANoyyJskL14peGrui30v4RZkj1jely9p9LDnNfV2ENMeUuY/+fQFvO5iGpBcj8Ffx7RivMhbPgmYayiwmwELazZMFwl/J8pGtHFQhKP1mav/qFH3dg2Wpm3FwkPRgYccWgKqlju/H1efNm/CWsg/R6hkycxgKWHiUFlbpvcjtglhn3/FMrjo6UVVQs0Zlz63WX8pgEd6udNpNB8BCeT/gRLRpFknRv1QVXTQaF//wA1WcOVp9fccQy+c/fKJOxDgJthYA+cvRsdyGaa8r8ArtTsk+i+3LWGoXmckLT/+ELcf0wKJzf0pPSteQ2usmSvMzWc6lzrwwyj65J81nqPpIOcV5jk1JjJsLIx5/PuJrDSgoPjLZX2Y+cs7SSxi8T0Pjy5P4xA3OECV6lf5hilZIs7NxagAh+cF/7G+YNKMIQeTQqoeAoYOObADE8jpSsnHK6IVhEOG0A+Tvn9VgioND4Zz5e0gXTfy2MH5IdPreO/MmsOQsOF59XoAOYhuuxL6OTSiw4g7LkmJt0ctIg2r5OZXuP4fuvZWFfVZ7l6UFOXxtVpJ0Dis=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jXeYr6Molnk/Znws3pM99NbKywWCbdmS5SXD/+WbnuPbc1iWzKo5Nlu5j37Z?=
 =?us-ascii?Q?9/GIihOVp+Uumxf7IqoPOyerW4rqP2+YeclmoNM2+eWCO+J1Fz7of24YVmSS?=
 =?us-ascii?Q?mQzPVklbjmeN4mopAB9RLNUQj9c9eZCfLIhWjV5RC8v4hgJGZXt3uOdImRUY?=
 =?us-ascii?Q?/pHkP4uY2RTbvbJ2+tzJicN1NKIgz6sHCzC292HZYZZmrBSfomblfc8zVH3k?=
 =?us-ascii?Q?f7mhl5XWxB5Z3PHQQ1v+zf+tkSXvnbGRi5Qe4a5Rl0DnzH9viXbzdIESgUnj?=
 =?us-ascii?Q?smpERSbKRORP95c4Ti9LAtigiLWYbT67J6iQM6lw2UD8qczS1vKAFGFOSOYo?=
 =?us-ascii?Q?ChMvzIyIEsy1h3TsgNro93VQUYCOOvCHDa8/LCbwEYtMzo+Zwib4UueczzZy?=
 =?us-ascii?Q?Dap2U3S8GANkDLFA6nDn3NqTg6bHtNoyZQS6mkg7f+9pXQyQQjQ3mDo4OPEs?=
 =?us-ascii?Q?1DJPAKv/LtEGSZafJ34LbBzvTvllLw37GqigcGN9QyLsd+SF4DQi8LjgDJu3?=
 =?us-ascii?Q?6+CmcrWfE+Hm8pSTd0RNXrjiJpVHNYJ+QebgbvZzUoKlKfCTxQ7uieY15zwb?=
 =?us-ascii?Q?lHp9vGoYTDPItS88iEn8E9cn0Yd/8yV+eW8VvzXJcELVDqMQpLVaHUG/PH9v?=
 =?us-ascii?Q?4A5C1N5iCdQF60t1FFnPljV+kAiL/eQ8RFkHK5GvTrjpZMEked9y85ett7TO?=
 =?us-ascii?Q?HEYh2+w6D+xhC4eNHW0yGV2w5j8E9XCrDlVEmX/c+OrflLEK+8zhtqJ1gKHK?=
 =?us-ascii?Q?x119NlslhF0eqOGoqKbMvOoRJtiPArzcpoWmsuiBvGzhTkYdUpMjANAip0F9?=
 =?us-ascii?Q?UIElKcPvmpleJAdWx7vBy1Jw9RYYHWE0tN1TQFGV95D4rP2KnU8sH1JrbQpw?=
 =?us-ascii?Q?Six9hYkIT1XyiIQUV/TSJnnQKnD5qdmF1Iv+1yXdsVaAlj9jK6lsKL8X+L3v?=
 =?us-ascii?Q?56u154/f4oENuNhQCkFxBujFBu7e+N/NRHwYobOkbzWUUjGFC0uR3JNkcZ+P?=
 =?us-ascii?Q?+qSXp0yvrGVUCUV0/z+llTyntzIATOgT0+lM4BIAy39bHq/Vsdhljpry5SCr?=
 =?us-ascii?Q?RSDyb6DjVtVZDsmyR5c/Hs7g838ItQYbhSaxk96jSLSx6KlJrgTPnxBzmMyg?=
 =?us-ascii?Q?EpQcbtRc1zeW9iQjWzRGqfYxpeOq3fsp5zrtIPbsHS/s2+Vk5ejlyrUq260c?=
 =?us-ascii?Q?bd+aLaN3VTdk7p9QWJOO2+Cnbh1Q1/mw2iKWMUPLj7O/ebwtt9vUlpjuTybg?=
 =?us-ascii?Q?YVNBshSFT9E5hE+w2b7opbJgqsDKylwAslcuOxqa6ynnWjy4ylcqviNHT68f?=
 =?us-ascii?Q?+SAyvYq5quchXY2wEOSeWIoOsdsoyaZc0fcDimryXGqXe/QFSFQmgDENxssT?=
 =?us-ascii?Q?KssAs1XXRxm+6Mf15DvbLmfzoxBvWLOkrngNjvEC4rE8+iaakSMC/d/13BLQ?=
 =?us-ascii?Q?956bpA4nKOXxE9C01SO0bXU6sy/VVoDgKA1Y2UR1I+lay4EWpcspQQ7R42RV?=
 =?us-ascii?Q?JcUD9ukws5VJLrTrODJl9EIQFtFehPLq6nDBh4t8en0lWsRdjai+qs/r2eXt?=
 =?us-ascii?Q?lczeVsDPny3Snj29lO9bymd562N/JluAnL1qJNHS8+fX9QajUmZ5+kHIlmnP?=
 =?us-ascii?Q?08+L4w1V+53RiwpingwQyXUJSjjzXeLuZiK3FETt08tQpCq5BWKbDrVNsWxO?=
 =?us-ascii?Q?WdhLziTEc4jcGtD9gBxkHB/oAGTOxJC1ucqiXn2lm5Dci2RiC4ojExOP2sKJ?=
 =?us-ascii?Q?AfwOi2ugUQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2725b13e-f9d6-4661-8b84-08dee86fb855
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 04:06:06.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxPK8VzUH5+yDYqZqAQgaSEPPoSnxK4CQwCUi4wY+Kx1ig05OVV+Yp2+o/5i1RZP7hKiThgdbJfp0BSXWtLWsrtPXKQQ/ugOuHLyaJ+lLz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573

Hi,

> -----Original Message-----
> From: Nicolai Buchwitz <nb@tipi-net.de>
> Sent: Wednesday, July 22, 2026 7:12 PM
> To: netdev@vger.kernel.org; Thangaraj Samynathan - I53494
> <Thangaraj.S@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org; Nicolai Buchwitz
> <nb@tipi-net.de>
> Subject: [PATCH net-next] MAINTAINERS: remove Rengarajan Sundararajan
> from LAN78XX
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Rengarajan has left Microchip and mails to his address bounce. Remove him
> from the USB LAN78XX entry.
>=20
> Link:
> https://lore.kernel.org/netdev/DSWPR11MB971547088066C2CA91638F3BEC
> F42@DSWPR11MB9715.namprd11.prod.outlook.com/
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3218abefd0c..81f30ad3d616 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27922,7 +27922,6 @@ F:      drivers/usb/isp1760/*
>=20
>  USB LAN78XX ETHERNET DRIVER
>  M:     Thangaraj Samynathan <Thangaraj.S@microchip.com>
> -M:     Rengarajan Sundararajan <Rengarajan.S@microchip.com>
>  M:     UNGLinuxDriver@microchip.com
>  L:     netdev@vger.kernel.org
>  S:     Maintained
> --
> 2.53.0
Reviewed-by: Thangaraj Samynathan<Thangaraj.s@microchip.com>

