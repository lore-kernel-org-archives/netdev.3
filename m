Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792700220;
	b=olo64vILQ2UaLOopku+/MtQYte2LYhyG04YRnw9+TrTpgTaebTKmAMj68Z+IKzWxYP5k
	 F985ncJZkxyfPfOEVP+zygGcVGFRF5rT0CyrP4EQXpw9ZnN1e6oLwslDvYo8VQVICp2On
	 Ra88JluE7kOc8j62oE/eLikRWH6m1aAVdIRqmMvXX+rm1MKHnwjuzL0ch/ATJnUVQNHc3
	 4UJJm2St+/hT0rXa7c3kGLZwyICgYrQ4Ym/qDboPo7a5ljTnVqYfgIIiFZp3/hMUqjRO3
	 1Qv4M/R/wvVuk8J9sg32klMNKvg5x/lBaIpHkrE4MhNyN0NAoDFOef6qz/jJEVXk3Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700220;
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
	bh=SO+/+RVOStK8D1CrWtBXbYbmrbjHq1R9NV0TWsVH9wA=;
	b=ZSuEbiM+I8yUSoA1OxKX5T5U+UcWk2CXM7Y/iDIvX+eSpxvjc/lTPIEDMiJQIkAK44e/
	 gKa1SjvoLRg0I6e8sDjd9K+7PsYDGPpeifsDEzasgU3nRGED9xJ9rceWW4nsrFtmQ1gSu
	 SV2wmscvGxjA6iv+LKwOiiRHFEBdGvWQxwf959dbGWtwArCX952CX2r/cKQqppvDI7w96
	 LBK+ooKKVzVMPFpTL9fqm5Qs9dTeQ8BZNSn8GTA/b/imFtngS1JH8Q6ptiFVHPg7q+ZYa
	 3zfyLuGq2xt6InXIzJfENSmAsBKI5s5vPOhLcSqKw/3neOm6m7JkRoZGiAaA0Xqpi2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=MPuHmmUU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.21
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012021.outbound.protection.outlook.com [52.101.53.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DC606A320;
	Thu, 22 Oct 2026 20:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6DC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=MPuHmmUU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEig4/ZnJIcQ2NJG6uem92BiAbwQ4XhUhZ24gZpbWur77LT/7WwzYWVPfC/eOksrw7F0C50/ETA+xiWiqdeFT1bpG7i1wlhLgACZhTVoatxzbibe4r1e5jo1YT4zuc6b0/d+ZYaB47gUQwgrlY1PLj/xPFzwzfSAtvblAV0wWcMrDOfdiPFLilbDHYu4i70MR/k4r8IbOUd1r4DvHApNhLc9oJP9is0d+ZJVEpKe4D1scnRoOb31h4au/f/jZlkuLAcB6/L9A+62p+IXbYfzrIlMp1MQfzGEV2uqrHE7SBeeNuuGLLkKaNrI+qRgK7yEgJTa0gB/LPa/a0hBILa/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO+/+RVOStK8D1CrWtBXbYbmrbjHq1R9NV0TWsVH9wA=;
 b=AExL5dY1dSrI5hrXD+TKrpCjpQO4vwftVlWKA97oHJB/+R4/ESZS0BU97EU031w1Tk2QffK9VYcmua5NOMk6kbPBD984MrDGlyH5pPuiaK44m/dpCU2WwUp77fSAa8kzyBubObJVI1fH0moMIM4J16T3PSJmToWAGa7dRU9V71/DP1C0ILsDoLVPz0R5a1E8R0VqHag6WgaL0FokW+6TKBK41EtldncM0d2oKUOKUXjP2ENPdfY4vE2hn2s8bhQG7U7o3rZxu1wSsQ1XTAifR1zUuUbNeN5ErojvbLjGXs72j7dEWwJtpbC2W1T50RycTZ1sw2hyo7XPpTmGu8vIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO+/+RVOStK8D1CrWtBXbYbmrbjHq1R9NV0TWsVH9wA=;
 b=MPuHmmUUwSX1E8N+DxI/p+OEut2sMQPg1TjJo8eMhn/fXabiF6bdVNKSiQJ5BNd7o5OJ/MJ+tPMOkrMItTwzENhvF1io7keMFWdUiM/yRZtrxvGLPSb8UdPk6od3yAbmoh5kOsaK14oDgFxNvE1tYFTT/04gC+La+umWnhnsAtc78GOxp0Zw83Vii8MZAe7uxwOO8GN2OhemxpBLheyoBLKBSIgP5f2iy0ZuIFe+VW/IaDI/1cOMHmtmKXWeCMNJ2rXVqQ7UKKNSFp9zXoqV9Oy9jzOmwxrDoiu87xoRNnDNV8QKG1RQsCTs2PTXCQ7kIBR53LdHVm8pyWkQi9GhcA==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by IA3PR11MB9349.namprd11.prod.outlook.com (2603:10b6:208:571::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Thu, 22 Oct
 2026 20:16:56 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0546.017; Thu, 22 Oct 2026
 20:16:55 +0000
From: <Woojung.Huh@microchip.com>
To: <nb@tipi-net.de>, <cbabroski@nvidia.com>
CC: <Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Topic: [PATCH net-next v1 1/5] net: lan743x: reset DMA channels that
 fail to stop
Thread-Index: AQHdXLZWKGSR1g1QR0aAGQorZSFDpLcErRIAgAVciQA=
Date: Thu, 22 Oct 2026 20:16:55 +0000
Message-ID:
 <BN7PR11MB2836B99696C08DFEA516C8F6E7652@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <bf487e5d01fe6352069d4314087f680fea717cc5.1792008404.git.cbabroski@nvidia.com>
 <3b3ef1c5d926ddeddc3eec1b2388caa8@tipi-net.de>
In-Reply-To: <3b3ef1c5d926ddeddc3eec1b2388caa8@tipi-net.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|IA3PR11MB9349:EE_
x-ms-office365-filtering-correlation-id: 3a607a94-d037-4f09-ff6c-08df30796b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|22082099003|18002099003|38070700021|11063799006|4143699003|261021121427099003|261009223027099003|10067099003|261021135927099003|261022105027099003|56012099006;
x-microsoft-antispam-message-info:
 NscrwlH5k+7JZec3YIHrCXf67f3zlnRdbb5/YAbN85OmvqE5kDue2XjfVhztChsqGduPEDoaKHVkp9Mg7NLFQPkxGe98OacCSePwD/XmYzEbSzdnQR2lfB26QamB8hZk+qqWcgpPZle7zy4RpyOsWUclOvN6TsJfzkKOPewEvsiTpOUBW828VhIVRbY1j63q6BlTwpbhGZfC4sYrEZjGHUuH5c6IScLZl3dnOS6NBYKjlu/zLZpMyApKI+Ly8rkdX6uthlCysE1hDcMCNUu4knKDIt0HhmmD8FLt3+xPZISupFKOkwqhJ4NXXas3RM6g575Ic5e0eN52c27+HgLo5vse69DwWM/Hr26HKUeotRaGnY26MagUDDDzWzhaTqD73dBvq98jt8wdv0FWPC4tSGZEfje39ht/Xoj7qWRXEgD4Tk9oc2m9tzCGHSfSDU3PGDJqa045MIh1xdDOvFznU0ogqzrknRL8S5dRe9uN64Qf7egcPwMmEYW1BMupekS6tkeish9nOurH70L9pdMTOhXYuUSvgtx45AvrsXGER2D5YdcxiHNU0ocm4ya6WgXZ+F0FwWCZeuY4b7jQjdUV/Fodw7HAzWxLmjfZOnG7tyeDR+U+C/fhl6y+SK8hu8ccUBDij4ovImokhS6ELR8rWOiNTEuIPLrhThRn4gnuL8vxbvsU7xg8vewWQ8KxTKKhRpt5mqPpotj1AsFTvSqeedvbZgDakoo4n1TDuPHT/fg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(261021121427099003)(261009223027099003)(10067099003)(261021135927099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tAmZAwkL7EF05X7x78b6/wUPyxQtawaKYZjPR14WUUO1lGSFSXC7a0h0rKuk?=
 =?us-ascii?Q?zxBK1Y/VSC0kUSdupVgwpW6mJnkHJs/+OLVbwS2gLMbt7LONfT1r8t+yAEir?=
 =?us-ascii?Q?ONL6PHIhMyafY+YvVmTm15reUz9ywePc6DiB8J+xFphk/fwmV8/eTOvjSrtV?=
 =?us-ascii?Q?PLcHBrK71VhTVpc5b0U/nf7M61oi1jEzV5T7ymXFdA8RxtjdyobW0RC0ERC7?=
 =?us-ascii?Q?5PgbGmoYjTGPiWURc1gxy3wrCkYhSsEhUxGL2z8NEOi9kvQ0alQRbIq6x/bv?=
 =?us-ascii?Q?Pt+WOGHEUIhVBrzxvb1PcxP8Aa+clTrf1vpcglUltu+hAwiE4nhNodZdsKT1?=
 =?us-ascii?Q?TMT3PYAJRxVRNHWozLe344Dgd7ZKHx3h5EgJ2Yj5bmnX209JC9h6GqBepIQJ?=
 =?us-ascii?Q?3AifRkTfPX7U+42z4IfTEH3E/ysgwWtDuVlgYqsF2CsY9irSsH5GEZfEtGU0?=
 =?us-ascii?Q?8BT9GuTD3wOW4hHLV+w4vQh6exm3j2aSWRGZWFJkbo+bZJEPIJvKIJEWODQw?=
 =?us-ascii?Q?LvrdY+Fhrlqwhw3Lckk+k5JEFtSwN0tixn6kg8cAcyFAVXBkmnnc7bK291H4?=
 =?us-ascii?Q?UjiAk5H1Hg2cBQTI9ENzuKLon1itt4+wuSEr2WL1/4msuUiRq3Vx2vTZ9h7u?=
 =?us-ascii?Q?ncaI2UXLU30BgOkVN7I1JrLbevSx8vmS+YuZ0/lt/P3f6pf6C0M115GJVbpn?=
 =?us-ascii?Q?OhqAqbDXdLIOHdYLaL5o/ZR2desIhLqkCphrx9eEZ/+snlxPXTsHp3FOSJkf?=
 =?us-ascii?Q?3++3BdjHADdN+lagK45HtewrUsDSIUiyeUXoJq3MWWMUoCS7+Imt1IRXF9jU?=
 =?us-ascii?Q?RZk3n52PhdT32eIHX9Nmv92HePpaySJRXMSijzQx0YgkA21CVML038FmEjQ/?=
 =?us-ascii?Q?TAUdQ3gFsnPTjdc+AywwLztDKKSQiwg4kK+fDfSSMfa7NNUa4FpjEBD+asQp?=
 =?us-ascii?Q?FJ8T7PA/mtmToxxy8d43FqVuM+Vua4SUwnOtIXunmpDCG630GB7SUdMi23Qy?=
 =?us-ascii?Q?tjPN140XfucdWJWkiSM8dQ615YO26jh78Vp/hI14KKLig6JboeQbH6kwKJaA?=
 =?us-ascii?Q?U4KroO8klhUMzCCLsyN7pgIJGv17keYIJvXtfSagu4Vl8NTsR9XzgNDM6BlW?=
 =?us-ascii?Q?JjE504v+XpbLbmCNYIqpW7/Q7iey/vpnry87HbF+EEk9tAwBLZ5zWcQ7AKYK?=
 =?us-ascii?Q?lKXx9jqf6W0XW6gFH08C3oKg2lgz+buB/T+WqPTfvPIYtgdwZ3fhS4o5PP0T?=
 =?us-ascii?Q?+25vvZYABRkY10kg++ZlAi4kgCA/UWp8sowBBKADUPRLfwvd5Zw+VTkW6W8V?=
 =?us-ascii?Q?mOxV0Vlgzrmg+LzHnSxt5zmraFeF7qtClyW7y2V/nnOS1xlEJCREKgHWMfsp?=
 =?us-ascii?Q?AWu9RsfSkY/neNovmVGF2AfQKFfsZo5gwuzxNDbL0xQhCbzoSTJKaKv9ItOR?=
 =?us-ascii?Q?RrxRLTjhVU3KCebK0OLYW7K/3ML5JpHPsYICzCwrcJqeEnhqNeIpZ6/MbSJJ?=
 =?us-ascii?Q?WKetu20gsn/upNBXFDQSlTM4oviVeNOir5W/rCj3M3SlOReG55p9cPBjn2zw?=
 =?us-ascii?Q?StagDxYhv53UeaPVgW+RK4N+zevH/ze5g+1LOl7X/fYxYcOLpYBHDbz7Ypsv?=
 =?us-ascii?Q?pTLkt8sxpYDvAKbSPWBhtk3eXfPNwYnGiT6iIYOhGBJ84zLi3sySFcEWKNDQ?=
 =?us-ascii?Q?lntVLsdinGZ3YJewmfSvLA/atCBuLgnkjb51TzeLvU79uRu2Tx/41rjMI9MH?=
 =?us-ascii?Q?f7pd5+YCag=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a607a94-d037-4f09-ff6c-08df30796b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 20:16:55.7497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfnQNt0XcoS35uU/wYTPQGE7zzFSp3kUaoH40eo1qVoYtwB1CoHDQq/XfY4xHkyWO+oUkTlUfifeulu8uEk6peXgG1MtvCDaCYjf1YRraFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9349

Hi Chris & Nicolai,

...

> > @@ -2271,11 +2300,11 @@ static int lan743x_tx_open(struct lan743x_tx
> > *tx)
> >                         FCT_TX_CTL_EN_(tx->channel_number));
> >
> >       /* reset tx channel */
> > -     lan743x_csr_write(adapter, DMAC_CMD,
> > -                       DMAC_CMD_TX_SWR_(tx->channel_number));
> > -     lan743x_csr_wait_for_bit(adapter, DMAC_CMD,
> > -                              DMAC_CMD_TX_SWR_(tx->channel_number),
> > -                              0, 1000, 20000, 100);
> > +     ret =3D lan743x_dmac_tx_reset(adapter, tx->channel_number);
> > +     if (ret)
> > +             netdev_err(adapter->netdev,
> > +                        "TX channel %d reset timed out\n",
> > +                        tx->channel_number);
>=20
> Not a bug, but what's the benefit of keeping going here?
>=20
> If the channel never came out of reset, lan743x_tx_open() and
> lan743x_rx_open() could return the error instead of starting it anyway.
>=20
> With the reset work from 4/5 a failed reopen then ends in dev_close(),
> which seems like the better place to end up. It would also settle the
> open question from the cover letter.
>=20
Agree with Nicolai's comment that returning error at lan743x_tx/rx_open() t=
o
make lan743x_netdev_open() returns with error.

Per Jakub's email, this patch could be a part of net and more chance to be
in stable tree without patch 4 & 5, it would be better to handle eroor case
along with error message.

Best regards,
Woojung
