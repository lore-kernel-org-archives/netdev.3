Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046701;
	b=W+I4YHWpKr2DpZiWGgIRLRseUEDvRG0d4hS1hDz8yZuOIobi/PTh7r4j7tJtPuuSskjh
	 /hob5GSyLD82+MvSXXdw7504Js755KXpugOUEMQPUvxXgMBRrCzRyc8xQGopkOpM52XlR
	 EXiGn97nLHpcjvq1SB05RgKZPUOeDztFAqoovCevGXCPGVZeBDc90s3nTPIv0Z0Mp1p57
	 23jIObcvPxVt1NIVwqE2XvBTrmznEaOQVKWN4nBjD2aljbUoqM+GrRQS3KQ4F4S8ozqBH
	 cW1uKMaBIsdh2+fgS2MuYOY3ii+TzPyB2A58C8DJ0Uz0myeNbwpOTQ4QW5qrolw1p2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046701;
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
	bh=B0Tpg02rWVh77UxHasrvLTC0mtBrwXx6d3ABXV5YaWQ=;
	b=QAaeuhJj0HknY64B767m/jcDAFwCwOgzaKA6NGhDxS1RvI5bcaFunCkwxgvOVT0CejIT
	 11NxkWEy/lpoHOP8YoDhjOINaUO6c2q+MN6J0m3b2PbDBb8dLT4PdyhM2uXxHJPQ10LpS
	 LRMvxlMJQ1PON/zDyee5rflEKlUwGDa6gtHEVrA3AEE+/EmZH19sCvEYiGZCpBDII5wUX
	 byQ0e1eS7P7fdn7MneTvBR3DCRIKqg4liEkaAhEFMdLZ5rXsLRtoJvZTJ2JSwQSlIoDzD
	 s2qzBv784k/jobzHCqK0luOP17/sVHNOWY7ct6/OnWJdBgQevMFZqHlAQZqmPtZDOoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=yo3sGaO9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.12
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D4A606A31B;
	Mon, 26 Oct 2026 20:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D4A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=yo3sGaO9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te520p4uYRLk5fVXNyxSHOzijmRmv3zbBuMI1pa/LtIOgL7eFzjum61zlUKeamwrHecukHzmF7QU25htXSi/gQtF2/x6RbWeAe6X1Wpzcs1LfC+pCM5NSW+xYitdTPIELxo0edjxDJB+AZ/aPupZEOUiJoNTV9/0+zo254jWLNScVunmlSG9Oh0OtbsoN+7DhhQoE1LIHCTYux45YkhJkpBkX/bSmqbfBGXtT9iJWKdhrk3uesInjcSfWqeXcMSPXxpZqrNJus1VSSNdrA9jx6jqr5wT19tXr0NgJD+wlXX49XRPKjdYX2KxdlmEX9Rr8TWTMsTH5KRP22O2LQIW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0Tpg02rWVh77UxHasrvLTC0mtBrwXx6d3ABXV5YaWQ=;
 b=bh4s3E3a7/olXVrsGxF02TTPGu3nZVVWx/6yMCLhQGvSc5rl1nHdy3EI5rNGawm3DMumyHrw5XZxzWkVIUkZeB/qcNci1GEaBHqwNzCHdj9KHd0ahmwWQOzUJuOnYgMrNj0pCYVndvV13fRcYZlBavhXkW7ngYxfoRsPDdNaPHvedOFMrfOYeyOTSHIy4p8YXzc4gX9O46we5AO1spxVoICRguOkb2HBXoKlbipMbX8oQJ+R0f29hu7wZwGcEWJsGkNWT+veKpBIaDVb9St1MsHPTynZ9hDha/2lm9Gkv24MS0Wq951lqgaTkCH/uu59RTGcG6fgdxOXWprOuJgtOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0Tpg02rWVh77UxHasrvLTC0mtBrwXx6d3ABXV5YaWQ=;
 b=yo3sGaO9kbdkA4/Fl+weJ7tR5VupPTweFE2fcfbfxPtVo22sCGLWx4IUS10kMzEoNQpo/9D+YYxaJMqt/64N69GLJPao4P7hAsLxHYTUJZ7fpQtsf3aTW9lCS2m+h/Uc9bPFdibH969qg5RJ7M8sNdt3686m16mbFgpeILcL0c91bXsWSwKw6x8LPvDP6udh85/fcvuGJbagJQOnAhUyyDAzl8/mOmkCXxQQ+B/mJYlKqwlqCbnODSs+MgFjUPASnO6YF2+8T4hsB5rTjFpF8kXcZBxzhcQ+6m5OaFagqWt0CmehxYv5lb+R2ZBJdmHKxeuJwfhJDzKvzti7O7uYaA==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Mon, 26 Oct
 2026 20:31:36 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 20:31:36 +0000
From: <Woojung.Huh@microchip.com>
To: <cbabroski@nvidia.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>, <Yuiko.Oshino@microchip.com>
CC: <maxime.chevallier@bootlin.com>, <davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
Thread-Topic: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
Thread-Index: AQHdXLZJRDal+7y/lUO1u0C2MYCT0bcFOV+ggAsew1A=
Date: Mon, 26 Oct 2026 20:31:36 +0000
Message-ID:
 <BN7PR11MB2836B1C7BA745AA99EC3F3F0E7612@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <BN7PR11MB283630E3A3DAFE8C50751201E7982@BN7PR11MB2836.namprd11.prod.outlook.com>
In-Reply-To:
 <BN7PR11MB283630E3A3DAFE8C50751201E7982@BN7PR11MB2836.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|SA2PR11MB5082:EE_
x-ms-office365-filtering-correlation-id: c9ffc7ea-f64e-4cac-3600-08df33a021bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|261026121527099003|56012099006|4143699003|261021135927099003|261022075727099003|261022105027099003|11063799006|921020|261021123027099003|261021121427099003|261009223027099003|10067099003|38070700021|6133799003|22082099003|18002099003|261026140227099003;
x-microsoft-antispam-message-info:
 6uGUgmm0mj7J0ZYW+KiZ6BCs1wpTj0Ql+CwyQBMr6WRUMJDp6L3fdweVAdr15nJ5S1bPRe4lJqIk8EiW66cvnfxwhAKdDZohfp3a+7gWyDZtPpp7kaM091WoiqTXw6+KSydRu3YeNcC0BQMbN1OMxnhk0RN9658fHx56IiXxfJMp0fYmxH6DoXBhtFkMtt5cGx4cYitxYNpBgFDXDdXjb9a6qRG7tBzZ3C26shIhlE8YLN5OOWcnPf6KaqsApb45BTfW0D7Q6731xSKHMJMpTisD5ej0rxH39+UWh0x57Tuibk/2hpGViSUidULlW0fvlk0V8+AFIbHAELMeiR6sh42nW8aBZpp7/jnYXxoin0aDijF3nXbPmqpo/2IehPfDAvBsK6Zeg2h3EHAUkmSg7th+jktoRI1KmrgTMKIqJY9VQQG8Tl6QAiGcfE/CygEuLJtDNWpxN7sZglGhgg5ZLgS1VypAakZEqoYRqTXfq4h9M+IdQ3bNdtI9p3mEZ7IRVfqpmT7+Rq5C+mNHo1oRiDYQdCXWtGCdPp/eEl/EHR3Sh4EFyzMxVa3rE3a/L/XX0PoLNJL/wJp6XlU74sL8avY0Ax2Cl2mBrqXAMmR7Y9ymD4WvHa3KK9cP2WI4rGTZV+piwGcEBGCOWtxzQNIqg3i6ziiulcjzfQnU/N2FQ4RxD95PhYV7e8NaiP7gtaow3lkRQoLdOfLR5BrCJxbEjUKvdvuiJqQ80Dl0kRjpCAS/GV0og7RW2Wc4IQjegQJo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261026121527099003)(56012099006)(4143699003)(261021135927099003)(261022075727099003)(261022105027099003)(11063799006)(921020)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(38070700021)(6133799003)(22082099003)(18002099003)(261026140227099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f9RxqkTnW/+T31GfpfmYGxidHKSzHAxjU602UPmuXL8bziDGDwCASWLlWbau?=
 =?us-ascii?Q?cHUd08S2JrO9tXPcF/f49/v0Ot+AILhk9AgBW/w81vJa1bKKu6AJA/RvelQQ?=
 =?us-ascii?Q?gQFxEDOZzgKwWovwCdzqDKZK9ar3FHWyMt+BbwEYno60xko/IvMa1JjLDsmm?=
 =?us-ascii?Q?rzpkjogF/w2EosBqfitmI6aUgz8i8P8Y+vnRVcCx9eyvLl4rVkfEfzBBO+Y9?=
 =?us-ascii?Q?MeV53HkehgOOj1oXEzOGUjiFVOvg/pjf3K3q5VH6Bc/Xqmw83Bh6lU0RqXTt?=
 =?us-ascii?Q?58ETL0G01COoqQterwYMB8B6C1yxijZTW4cJx24L3StiU44nCuX+d3IcDd8L?=
 =?us-ascii?Q?njg4sSKTGQYllNVMRUztWgVtP3kd/rZTZgiQy2KQYEv2tEwX0Iu94cdzSdGQ?=
 =?us-ascii?Q?2glvxcyVUyzCs/fK1KLvAL1Z4gNxRXDuWyJdfO7oisKmz8h0byWw4BSS+P5a?=
 =?us-ascii?Q?XrfDnXCgnbpRhCfGrA9ebYC+IyR8b0WXPUPzYRm/1zMDx5lvjXdmGFeSewia?=
 =?us-ascii?Q?Xs9KtummWXan8tZ/i1LrTo7A5wSBD8y42Mpapx4i8SVn3mYs+8HAMInX9BTX?=
 =?us-ascii?Q?Adg/OTAOZ/67LHpikMjR86NqhogfMpIPkfudCGzIYf6NHHTSdyGFYQ2lNhWI?=
 =?us-ascii?Q?NZbzuaLNYdjcpGlpGWFhe0tkdJR8GsHGX4N08xaSljM7gOzQDxJ3JqyefgJ5?=
 =?us-ascii?Q?oRmjLizWxcw2eFPB2OndL71OEpvm4zdEDrgMNYPzx8TVsVMWO3VA3AeXT+GR?=
 =?us-ascii?Q?aJlR3Zm02v3IQ0+kdTIBvW4CDVMag70jTgcwhZycnAcNxe25O01icNz8IaDd?=
 =?us-ascii?Q?R1t25Du84EjU7s9n/hzvodYJrD0+cbmzfuIvCZkXtZmB8JerTGx5dRq286Wi?=
 =?us-ascii?Q?+oygbdLt7KqvLbtaBJZVn7Wg2u8oDZBwW7n83qh6FJAHxHAG86KIVEEN9f7t?=
 =?us-ascii?Q?5mxZ0G2aYISMY07cScAMCHTHWbrezrXHHdpx1BHg0XxF/GM95IT4bpiNk1j4?=
 =?us-ascii?Q?lsnQi8jgn8FjuM+LpTqNbZ8SO30Kqk+rkzuuV7aLuB9b46USYFkhZNsmY/5H?=
 =?us-ascii?Q?2lJtGI0203yXeMW9flHzKByMjgQDu3+H9CVI4qrm+xsvE8U5AyYUZBlAZTAr?=
 =?us-ascii?Q?9s3EKkhbXr52M+pg2xwm14ko47rVQ2Q5MeoZO8FSIKQiRzbaSr+GpZajJGXE?=
 =?us-ascii?Q?JbQXO/dHeg7wXnoec3CLQknKFvkFTKw5HAHp7P6pwZ/rdVTLFXBpeG1VgFMW?=
 =?us-ascii?Q?nbmkv/iAOOg3DVeD/PBNGnhlzhUqU+tj0oJge6h1Fxm0cd3HKAPwsAyITqyl?=
 =?us-ascii?Q?f7UUdypCYGNdLtUyqTFyk5pU++DmGegdWNTWfAqB5vY65fjFANZcyWJkCBym?=
 =?us-ascii?Q?ZPKMhgD3korPdZOYodFN8txZWqrnTjFGFSg75mttHZDGnx6WqCkctzEGGyQD?=
 =?us-ascii?Q?SlhAB1qkK/kLbd9nUm23Y0LUehCP8tfJ22RkdW9BPoAs7vyOtZ58s+mQ/JWh?=
 =?us-ascii?Q?5zCZDXTews87YxDDsZIS4cCsU8iv/3cwTHPzXth3S6sve0L215fsAPeKB036?=
 =?us-ascii?Q?h7kkcYbesZhS06JpAzKwG4r4IaKr5pQV4qvcdgxjWdPi0imzRF7yTeg2YQM/?=
 =?us-ascii?Q?1SOxI0IJgfM7jnN2dinPOmO7IDBb62BXwT2U87s04l+/ms43GCcbVu+hcKfR?=
 =?us-ascii?Q?cUpkDhvBS+wxMXNQfuNukR1cmPRcIiErFOz0j6/hpXpmshYI63ZizbB115AR?=
 =?us-ascii?Q?dIakRrrUPQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ffc7ea-f64e-4cac-3600-08df33a021bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 20:31:36.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhVCReMxh96pHt4xS16rHEBmSs4KlbrY0vXmsn4oGHBkxPB7znNdabN0BkxtQfefBMgUQvSF/hW/yCqs2Kem2oQXBBuVlodIFVe3a0WRArA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082

Hi Chris,

>=20
> Hi Chris,
>=20
> Thanks for the patch.
> We (UNGLinuxDriver@microchip.com) are under review and
> plan to test with our devices of different configurations.
>=20
> Best regards,
> Woojung
>=20

This series is tested with LAN7430, LAN7431+external PHY and PCI11414.
No regression is observed by tests including traffic tests, sleep/wakeup,
link up/down, cable in/out and etc.

Will retest when revised series is ready.

Tested-by: Yuiko Oshino <Yuiko.Oshino@microchip.com>

Thanks
Woojung

> > -----Original Message-----
> > From: Chris Babroski <cbabroski@nvidia.com>
> > Sent: Thursday, October 15, 2026 11:01 AM
> > To: Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.com>;
> UNGLinuxDriver
> > <UNGLinuxDriver@microchip.com>; andrew+netdev@lunn.ch; davem@davemloft.=
net;
> > edumazet@kernel.org; kuba@kernel.org; pabeni@redhat.com;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > richardcochran@gmail.com; linux@armlinux.org.uk
> > Cc: maxime.chevallier@bootlin.com; Raju.Lakkaraju@microchip.com;
> > cbabroski@nvidia.com; davthompson@nvidia.com
> > Subject: [PATCH net-next v1 0/5] net: lan743x: automatically recover fr=
om
> TX
> > hang
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the
> > content is safe
> >
> > Background
> > ----------
> > On a custom HW platform that uses the LAN7430 NIC we have been able to
> > reproduce a scenario where the SoC stops receiving TX completion
> > interrupts, appearing as a TX hang. After dumping and decoding the
> > LAN7430 registers we see that the TX channel reports that it is in
> > started state with no error, but TX_HEAD stops advancing. TX MSI-X stop=
s
> > incrementing while RX interrupts continue to increment.
> >
> > This scenario has most often been reproduced in large server cluster
> > environments, but it's also been seen locally during repeated SCP and
> > iperf testing.
> >
> > The root cause of this issue is still unknown and we are continuing
> > debug. It was found that bringing the interface down and up recovers th=
e
> > network. This issue has not been reproduced with the LAN7430 EVB
> > connected to a standard Linux server.
> >
> > What this patch series does
> > ---------------------------
> > This patch series attempts to implement automatic recovery of the
> > network interface after a TX hang is detected. It does not fix the
> > underlying root cause of the TX hang.
> >
> > At a high level, the patches implement the following:
> > 1. ndo_tx_timeout support to reset and recover the interface when the
> >    netdev TX watchdog triggers.
> > 2. BQL support to decrease the amount of time it takes for the watchdog
> >    to trigger.
> > 3. Stability improvements and error handling around the open/close path=
s
> >    that now get executed more frequently as part of the TX hang recover=
y
> >    flow.
> >
> > Potential issues and concerns
> > -----------------------------
> > * One of the patches adds new lan743x_dmac_tx_reset and
> >   lan743x_dmac_rx_reset helper functions. There is no cleanup handling
> >   introduced if these return an error, only a new error log. This
> >   matches pre-existing behavior: if a reset timeout occurs then it is
> >   possible to DMA freed memory. The datasheet states that these resets
> >   are performed immediately in HW so I'm not sure if these will ever
> >   time out, but I'm open to suggestions on how we should handle an erro=
r
> >   in these cases.
> > * The TX timeout reset flow does a full lan743x_netdev_close followed b=
y
> >   lan743x_netdev_open instead of individual TX channel reset. If the
> >   stall is happening inside the NIC DMA engine then the theory is that =
a
> >   full reset may be needed to recover. For internal use we also wanted
> >   to reduce risk by putting the NIC into a clean state after recovery
> >   with full reset. It would be great to have Microchip/LAN743x experts
> >   confirm the best reset flow.
> > * LLM review tools flagged several possible bugs during development
> >   that resulted in the inclusion of three "Fixes:" tagged patches in th=
is
> >   series. They are included in this series with the ndo_tx_timeout
> >   support because lan743x_netdev_open and lan743x_netdev_close are now
> >   called more frequently as a result of TX hang recovery.
> >
> > Testing
> > -------
> > Testing was performed on a 7.0 based kernel using the same driver code.
> > Please let me know if you would like me to run any other tests.
> >
> > Tests:
> > * Verified the TX timeout watchdog triggers and recovers the network
> >   interface when TX hang is reproduced. This was done as part of
> >   repeated SCP loop testing and is also being tested in a server cluste=
r
> >   environment. dmesg was inspected for "NETDEV WATCHDOG" to verify that
> >   the watchdog is being triggered. No errors were seen in dmesg after
> >   reset.
> > * Performance tests using iperf3 to measure RX and TX throughput show n=
o
> >   noticeable difference with the patches applied.
> > * Repeated module load and unload cycles produce no errors in dmesg.
> >   Network appears to function as expected when module is loaded.
> > * Repeated ifconfig down and up cycles produce no errors in dmesg.
> >   Network appears to function as expected when interface is back up.
> >
> > Chris Babroski (5):
> >   net: lan743x: reset DMA channels that fail to stop
> >   net: lan743x: start phylink last and stop it first
> >   net: lan743x: quiesce TX before freeing the rings
> >   net: lan743x: reset the device on TX timeout
> >   net: lan743x: add byte queue limits support
> >
> >  drivers/net/ethernet/microchip/lan743x_main.c | 177 +++++++++++++++---
> >  drivers/net/ethernet/microchip/lan743x_main.h |   2 +
> >  2 files changed, 155 insertions(+), 24 deletions(-)
> >
> > base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
> > --
> > 2.34.1

