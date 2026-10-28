Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793220953;
	b=haHQBtL5Q6wIYEcZNIelbzoHHktdA/cY1SFnisJNgd14OSzaGaP9BgNVVeSbm+QAvnSA
	 HNyD4j9ivUWBjFhQqosSvv52tNi3+lyYEo3DfNtelgvIGEAIvxFOEz9V0ZcDrG41SmIT3
	 QCgvB37Y2Uplfq7dKJmv1T2ePZ3Ez77Ed2TQFFeVl769uC+n1R6kjLwpE3M5+oi83YpQS
	 Iz1D67rlIHtIR+1rstcdiYXG6MZHVImGkJaKr/6VSeUzHYgNyb87FjpDPx23gEE5q/iVS
	 9ZGcuFP2Kje3osaoNdFas0Th9z4P+UFtSq/lWTqKlsk0nPEDR6SgEYinmIe7SEp/lPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793220953;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=aGh9b+HIQur+XApSvn0UliwEBiny/gXyXyYbARqPglA=;
	b=SDE+Px25uP4b6JKYvHcQbgbjljWKLrwMX16eAcDNOoC1k+VZgO4AyzP1O61bKfOycBEz
	 JSqUJGy6ZcpTInB89+arogK32SyEMnI2eqJ8PJRHkXVrZSxsZbfZ/JNCZypH14gCX7UH+
	 wws4FmBvf23kA8GBAY725KPphozHKQVq7rQ0Y1tfJqAerN3IZYUafNp2CkiPx4V9PedFY
	 t115nDW8b+OUIDkCazR+WKlmxijmscKS4ZVaOiZamcT9vunY4dwQSGZc454R0vuXNZIWS
	 XkMdZYcIumqCVt9f0XxBlaXBxXIBsuZyU1JgS431UDdWp2D+taRWr91pBwdwMoR8NIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b="tlh/9Pa5";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.42
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA32606A31D;
	Wed, 28 Oct 2026 20:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA32606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=tlh/9Pa5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF4rp4Zk2VzHiOXRFKQJfY/TKcXkhTPeTChGX5wyg4SXDiY2lcqTVbyqbpajgxr4kDLboQ/PWr6taKJCd6mWEworZ5m4ucXmAaDlZNBYWFlug2hryFpFBcqCJlHBjTAoSraxUvnGd567Zg04OuO2//x11C4LsbVPTUeXAP+q0GlrlkHFhOzeuoIqSCODCldkHP6aNGMEIhxI/PsMIKugHDW92fSjFWxcPfpZzLMjnNihp6NDE7kIl+QHu6mF6TugW8SyZL63/ip2ovJfpO1w7WbmW+Borwy7OnGtQR3jcqXPQtMeBH7PDaNybhcAI9DjrEQps1Zt7Mf5DZwLQpnRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGh9b+HIQur+XApSvn0UliwEBiny/gXyXyYbARqPglA=;
 b=lppuZsyloXPJxBXtaOjjvgNbbQdJQqDV8ST3LaKxWiTs2oZf0Skb4iSJ5UcR3J/YW7xNIUOjPPDjhWcIWgThX1kp6mI2vzcln/P2ep9kHbp+MN6SDnejhGyV6ThScGI+i8mrZ6QqKUpSaVC1q6ykNhOfR3tuBziPY+n9KfxFNR9udFiGrWCcHqwShIuUrx3quuhaH7pp9YIxOXl4K4Kx8dAACu6932rl7fCj0gB5zIkj83RMPy8PWgULwUl1rcCyxxOvRExykk2r8RtDjH5VIkP+ABs4TFjjbtdNjz20Io2ZqEK3mDAkV2tUJlyzKLWlW2suMM9wjeNnOV97pSTi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGh9b+HIQur+XApSvn0UliwEBiny/gXyXyYbARqPglA=;
 b=tlh/9Pa5nCmkjom8kdndz6/7l50j2KUKSwnh6hFiZJ2vbRDLZF4pWBYW/piJGn5Wr47mrOeA7hKyimMA0lMZ2vOeQss7iJxDiadhicrpZlNWG+lBech82T2+xpL2Dt8fh0skmjCfQZXUEsOiXkb0RuHck4wSEhBs/nYBo9gq7aVPUSWnjU8bm4MQV8WiQhFeNlVP2PFER/wBR/i41PTLaYiySF+cuEDob10zaFuwk+aOtj0K9b03CX4NtLP4Levs2/qaeHsW2Qe58Q0X9V5sJjaHPmc75y6R6+hSe8G2HKC/LqQhDy5IPiwJAjateQReg7oxOd1ToQMM/Lr63JE+IQ==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by IA1PR11MB7386.namprd11.prod.outlook.com (2603:10b6:208:422::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 20:55:47 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 20:55:47 +0000
From: <Woojung.Huh@microchip.com>
To: <cbabroski@nvidia.com>, <nb@tipi-net.de>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<Bryan.Whitehead@microchip.com>, <davem@davemloft.net>,
	<davthompson@nvidia.com>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: RE: [PATCH net-next v1 4/5] net: lan743x: reset the device on TX
 timeout
Thread-Topic: [PATCH net-next v1 4/5] net: lan743x: reset the device on TX
 timeout
Thread-Index: AQHdXLZHA83iMUWnwkGwSyu5/xJC4rcErkuAgA03wICAAZozIA==
Date: Wed, 28 Oct 2026 20:55:47 +0000
Message-ID:
 <BN7PR11MB2836D0C348528CFBC6738C7AE76F2@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <5cabe797885011ea204a793557d8639a@tipi-net.de>
 <20261027201413.589706-1-cbabroski@nvidia.com>
In-Reply-To: <20261027201413.589706-1-cbabroski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|IA1PR11MB7386:EE_
x-ms-office365-filtering-correlation-id: 33822570-f182-4a9e-fc92-08df3535d777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|261022105027099003|261022075727099003|261026140227099003|261021135927099003|10067099003|38070700021|261028144727099003;
x-microsoft-antispam-message-info:
 nTNzzsVH6ABogaa9ekkNcKs8M6Jp0GPOM6/MoaKvBsnigpzB3e/5SoVECvDlh/+PRZn02KceTTsBHlm9HUIdspZU6WZHuQAPnfzZVtBPO1axfNrKy6zoFKRoGuwA8E5NwpWhHQnd8XfiJmRByhmsMxSKyzqHP6swI0d/48i8GXHPRpEZl5FwlABFLKg4xViJ3Qbyr/CNayG5/JT3QZ3GF8kJo/aS7N6M5C4MEj3W+XdpHiNB2M8s+6NWTX8TLyUppSqSw5qZP2er54h/fCk6wKl4Lbd6z7aW85JUtgViiJN6tyhGP9IhX8Fgm2Mq4s7IwnNfGprIyOs3ESC7Knph+tv/Q62vQ3Npfo0ICEYLbfl3XiqsXXb4i5OZ28hvg0z/by1zp/SKDZeusBmGAGQ3l197ynZeh63MYNSCpXy1Z0+DsZvn5+H/lUkkqSC0jL0Per6Aah6Oa6N6pY9WEbMVBOi/jVYuqWoyFEPfhNUrhijegy+Tdvfdf3Deryt1gwvZjpgNuxDaGpoLiVjoqh1Er2uFCfUL+4kxiaMSdqsvLhKgmNXmSQsHqNCsEjACPO9H1sNK6NsCsy0QD1lcOKQ2IG4bUq5n/KST+tVUdQtURO1/ZZQs5R+aCW9e7ROQEBMnfpdoDRrDsZqRRfjGlHi4wzRRH6Ws861Thjs+7RvOhQLr7beMXPAjsfTp5eOjom/Oc0GQ9rzVFUNCIYCKfNj3uw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261022075727099003)(261026140227099003)(261021135927099003)(10067099003)(38070700021)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JqjmBNJ78xP6P2YCBMvKmI91qDsT0Xcfck4lHUdt5VMP0HmwFQ4as7hd8UNx?=
 =?us-ascii?Q?Jo6Y8ZigMz6jpYsGgly4C+ml0eMqx/NE78LWnWwkmhtBHVZoyaC5Ap0wxpU5?=
 =?us-ascii?Q?uyNKpYHLOwWE+2HmEx0HBlwrc9li+x5OnRdK82XPnPS7v71OfgFhGdm+k1hp?=
 =?us-ascii?Q?Vf8gst2RTk6wiCHYeD6aTM6yait0s0zubMaU7oO669cWklJHcULVOx3mNveO?=
 =?us-ascii?Q?PxXPuEIFuDkwMdhKaZYP61TY72HUtmcR50Piore/FHZ1AqxP1xK3japa1Yuk?=
 =?us-ascii?Q?4GmWVLS96tQe/vRSeFL4K1LzFeQCHxp417NmD/18YsNveBKQJT5r+xSJN9ci?=
 =?us-ascii?Q?Xs1KpWi9PWN/OeSqCVs6Rzf3ZLKBKouYL+7EJfG373GlOq73ujX1AFFsCHI0?=
 =?us-ascii?Q?50IWq8+qujv5McfhpOsUGWqwN3wgMZcTWRMpoGP5Cih4Mm5SkPghv5BmU7c5?=
 =?us-ascii?Q?rAEe/Zqp3ifLRT0hvKtHE8v+nfv7e/syDV74OQuTnG8kp4BibwhTaM4D1JRA?=
 =?us-ascii?Q?b39wtOhioastA2iyox73OuFXTMMvywBsC8Di/j3o6JOd+AhRKahk9xK2ApPO?=
 =?us-ascii?Q?sOjXh5jegFyjKSKHKs5gj1xFWv1igjhCO6EONDUiRnyyYzqDC5wD0MzUuBpe?=
 =?us-ascii?Q?91cCUJasjVihLo0jxtwlgFr5JjX4WuBBstVdmdszrsBxsJE0a/nv8UamJPCN?=
 =?us-ascii?Q?Q0yYuQ5hbR3cwsGQMmU8MxmBdK70aWfZkmcu1ABacFc9tKOktg0UdFHnkdiK?=
 =?us-ascii?Q?Z/Tzv5K2moPioelaUbDLbeUgO4gdOA71BR9c7Cn4y4YzB4xjVR9w6SNuXRMj?=
 =?us-ascii?Q?geV9HT5lOFst7MlQlOiYH2DUdmXAINj+/jbmB4wgqr+G7ZL2CUihOzqPa7xU?=
 =?us-ascii?Q?1zIre83Q06bG+7mJILOwu79zZ5QFOVsHPZAM6bWI9P1RpbRtNWL324/NnSOQ?=
 =?us-ascii?Q?Dts4iFjZHSs2jaUpAk6EFnVNIW3K7CW+kEyTNsU1fDII6szNI26OVWbPCUoI?=
 =?us-ascii?Q?YWmzG/U2WgK8c/FOiQzXL1qAv7N/hkNDWcyA7tFFqjovLtcd7orjwsvtMQ76?=
 =?us-ascii?Q?v3AF4oApOR49y/LyFBGD5tRIRiTMH1WFWY4mViOgdK7daqZ7KSJiwY0LMh9S?=
 =?us-ascii?Q?vPfu6zrdepoB5FufUSBzI/3xVMNnKZQFitnp+bFCk4X7tERtRvwU3P3SgeW1?=
 =?us-ascii?Q?PnXZRvymT3BpO3+bpNrzvVgq4kFviYTiJQ7wavy1WdVaBdrA/V7JFdWkEB+G?=
 =?us-ascii?Q?zbKCQj1yvkXzjinIp2qWraQwvAHFJ00v/6DoyojygptmJbhGhAO/w/tbQfcI?=
 =?us-ascii?Q?aQwKKH7BRZ6yviqrCJxxZXiX0UabAov0bF1E7L4fQ0r+mhor887H81vLJPxm?=
 =?us-ascii?Q?9Gw6X/daomjqyoVHQzMyF52FhuOIN+cpHIotbox4wWADa+Dx4ahjOEGyaDwF?=
 =?us-ascii?Q?STqHexnbS3yvBHiSxUHPfWJud0KXNZJJCFuUMgkSwhqZ6LULbryyeVzJ6ywQ?=
 =?us-ascii?Q?vahvNuFfGiS+mZO2noZNki/c+yLljqNFmT8z/wMtMDqQ9aexTt3OU4XwvbmD?=
 =?us-ascii?Q?RLMqAKHhX6/TPNCM3ABoIBbiV0OowUlzjbLcslfuXNjgvIF0k01vritcZS3b?=
 =?us-ascii?Q?EIUJeoKbZbVb2oNKIxoISHuxtPXMR5ZebDcvFDDwWMtqBcKLKuPhYIFySFs7?=
 =?us-ascii?Q?d+XKGl68ywe/dR0tRdyfm9kA7OZNZCstfp06FK/xbvPrDkBOGBtfzkT8SWU+?=
 =?us-ascii?Q?OWPiy08yIA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33822570-f182-4a9e-fc92-08df3535d777
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 20:55:47.3785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmharqyVdhDnfOpyrVVzx9KY3s98eDa3txbJsl0NZIm3Xza16ohWUuuL878A8Mcr+ln0vD0YLJuh7HpBY7GtZxWw8D9WAeUjd7B8ptNpc8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7386

Hi Chris & Nicolai,

> > Is it ok to re-register the PTP clock on a reset the driver starts by
> > itself?
> >
> > ptp_clock_unregister() makes the open /dev/ptpN return -ENODEV, and
> > since the old index stays taken while ptp4l holds it, the reopen comes
> > back as a different /dev/ptpN. So ptp4l has to be restarted, which is
> > more than "set up timestamping again"...
> >
> > How about moving clock registration to probe instead, so it survives
> > the reset? Then only the hw timestamping config would need to be put
> > back.
>=20
> It may be best to get Microchip's opinion about how this should be
> handled. Woojung, can you answer this?
>=20
> Makes sense that moving clock registration to probe and remove would
> keep the PTP device valid across TX hang reset, but I'm not sure if
> there are other consequences to PTP still being disabled and re-enabled
> during reset.
>=20
> I'll update the commit message to be more clear about ptp4l needing to
> be restarted and try to run some tests to see what the effect is of
> moving clock registration.
>=20

Because TX path is already lockup, I would say that impacted PTP traffic
even though timestamp function still alive.
It could look ok at workaround point of view, my opinion is keeping
ptp_clock reg/unreg at *_open() and *_close().

Also, if moving out to *_probe(), PTP clock is not initialized at *_open()
time, module unload/load is required to reinit PTP clock.

Thanks
Woojung
