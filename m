Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792606951;
	b=Y6DR4q12vA+Sa5KhMUqjGrpy/ScBy078NoTirrw6J9FEdQ45Y2okEd3aB4Vhu3ies8ht
	 MT+7zOwcj6MXHf/RhgW0lAGrj0K9bzDu1TSntSlFuaA2h03reZXczbpXlK/TeOM1d/iKD
	 RWuhGrLDyLZuztqY6xPMV3HyU6Og0t1+QcQfGKB75uXDo0mdrZ8LztUGkGV2Kf8PWq+VP
	 M3vbeLf2iZtjANUKbluxuzZ7wEqREdd6qalbyj47vGNZzVLRF+SJgBtqa2r0wJJ8vD0Y9
	 v9VrLoYQBvCFMtAlDFO+evAGrArdTcMgwG78dfAhZ1iw/i5WJ/KR66uCHmI4KhAu3Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606951;
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
	bh=OyViApvm9AHon7azsUc215yAd4oGw/BCIiBQZEut6HM=;
	b=ql0/Rra4lpcZXxEpJhOjdrdK29sihKVjnsQe+MY1Mf3Y+eK4DIL/qE9Or+pgfdwEVvaO
	 2hGw0VIqLhW+6Tr63QmSdA+aNNOcvctR/CWc4CMolt7yU3+fFLxCP/bbqDZjtAX5gL+v2
	 Jb4FOFM9QstDb5oZKAsyPkh454HeVy8qAr7D/RGA0+SnlfX/zQv1Rd1OM5Y9tuZHvGnFi
	 2oEeV1pc0x8hCYnmN3tIul2NaExus10KTcKYQ+/PRs09z0Mm3lZIQ7XTA7nAQrYlshZ4H
	 y417weGKWwBL3QK1F3ixL7MjJlSzLxwKiSxFVrGdqTd6qgba7qVgx9c394iHEbHxCxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=vCdk1Kso;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.71
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010071.outbound.protection.outlook.com [40.93.198.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83375606A319;
	Wed, 21 Oct 2026 18:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83375606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=selector1 header.b=vCdk1Kso
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2oBYksxTu4JramsMuS32Fdgu/T7WJu9HQcQmKMSjBYMvLbr58KTVDltokpQ2RT8R+vtmNtAY64EXdZfPF8vIGRVLjTJCRlF8NJp5TKeMs90Tqwhe0JStA3t0wTMrr54dvtaJ0S3pmu4qsMkAdnkJWWPmDxDYhptj4utuK7a3putFWEsG6IlskYLVja+6GyNvOZ47oz55taNwTxaHsSgH/LFYZpN9OjwTG8lcWFjnMolBGu68bu0iydj4AbUuSQYAkcSWHkDnVktGD8VwY/cJSQFCdHfNWFyT9a579RGotk0ekBlTePHoVQITKs4wF7YzX2YatcZ7j+lsk/X5K+qnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyViApvm9AHon7azsUc215yAd4oGw/BCIiBQZEut6HM=;
 b=hDtW5VeI6c/wz1W3hxyNYVf/1R4TTnxSENmsPCwV51IYp/3vPAFkKFa7NwJ+l+/QSNxayrhJz5K5R0nvZszdnuv0+Zy7o0Z10ZXzPtBNr7CMFIxDXbeVAQDnkIt1yEYlXJSQkMz+f96ESQDM5k5p7IQe4UcKcnepjeM/6hWbtgMG3KUeiDrIJz6PViqMHyFqhPtGc0hJjGNmfPyXPldZ1+QjHzgc0TBaZZStvvKcddOMIb8qQQg+qP8W41omFD6+WsAqDF0XM3AvCAAw5oYK+VUvLK4DEDIuM3EdNGrHj0WADx9nqSm7x1BbU31RTaFfnBkwAmT48uIE/Fd7+hyMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyViApvm9AHon7azsUc215yAd4oGw/BCIiBQZEut6HM=;
 b=vCdk1KsozGuhz7ENusdw4USqT3n7N2+7+3Quv+wrWNsUr/0jGAJjRK7ZnJj24r+XC/Pk6+FK0jOcDW6wLrFkVgC2a/DMOHCYxMRmvX0YL+KFmb0tGhwkDxOy2ryq/Gh3Xvje3eatq8NMoDBfWVMHYf7pW3nwpRk2gIRqEEpujCF37M8hQ0SX3F7JjrPoNpHMnBda0miEkL0X4p0lfyeuAZP8KU0NRfCryLgTr+dxqnf2QZlQcOpS8660IYFOWK5t8OBhRYE3NmMIXUKZsTjyX5fHYp0JeCHPDW0xFvj16Dy+7Xpy6Ghgqs+C2aevx2eeWw32+KlhImE6G50muDzYlA==
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by IA3PR11MB9159.namprd11.prod.outlook.com (2603:10b6:208:57e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 18:20:25 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 18:20:24 +0000
From: <Woojung.Huh@microchip.com>
To: <cbabroski@nvidia.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<davthompson@nvidia.com>
Subject: RE: [PATCH net-next v1 3/5] net: lan743x: quiesce TX before freeing
 the rings
Thread-Topic: [PATCH net-next v1 3/5] net: lan743x: quiesce TX before freeing
 the rings
Thread-Index: AQHdXLZHoeFb/LnUBUqI+TLbogNxR7cIVwUA
Date: Wed, 21 Oct 2026 18:20:24 +0000
Message-ID:
 <BN7PR11MB2836EB5375FADA5AAB831982E7662@BN7PR11MB2836.namprd11.prod.outlook.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <9e3d980f9853cd73ce4e845f9c3e5b5cb93fd2f5.1792008404.git.cbabroski@nvidia.com>
In-Reply-To:
 <9e3d980f9853cd73ce4e845f9c3e5b5cb93fd2f5.1792008404.git.cbabroski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2836:EE_|IA3PR11MB9159:EE_
x-ms-office365-filtering-correlation-id: 98a31769-2129-4952-207e-08df2f9ff9bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|10067099003|22082099003|261021123027099003|921020|4143699003|11063799006|261009223027099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 HJD+CyxyI1u1veUu/V6OJ6QutGLAApXpaASpFZtpyfU9F61lZQMXrPn2LpUyhhLpkKmUkMesqllmSwwlOPkvd+ydUpyIe79ESKCgXeAPkJ2HgZcoEWhexbgxASpg+bl1hFS0knk+kV5Ca4H23HsLL2mgXSSKs/4kN3bZLy9jehM07qywaQQDl3DDRz2zOlyC3V65vEp1N4Cr6j37Hdbta+qcJ0xyeJGkj9rAPIQuAkPR+Vag04gJgWkop7xzy6REh3vugvwcMzl6q66B/h+ZLuSMF9bfLnolRX9OdikhfF3AikoYIteWasObFsi62XGzxvwNAWvwD0QzEO50hEfhNjotBBB0lwZvNhf53zzaEhWryAhkSAgrxaKG1O5/tt418K3IuERPOot0YtK1T4Fc0EHAhcmk2Ac7rsePUct52HtBWPkAkMXxx4lI7YMaL6LUBxouAGL3y9hNG4dEOh2yOHfa+2mB6kB/0uf/fiDFW21XHNraqXSxCbgdVM00Oa872K8BXR/kLKaWlqFpOY92wmXSQBrmPp0doK1kxZyy0r6xFMTa3mkzS9Byv+1fQFF/QD0TTvX05Ncwq3Ou9CaU48Wvunp8YTmHZ6+j3J+y+PD0x8gM/IEcXtigcokMRwSTrHJtqlyQQ+Buyp5NqBvpeGcX9pKaW9csaZWFr/LoqvxJS+HEaPzsD6R/hxj4SPu99ZPD8TP7nrvMxHMv1yk8y1jAC06Zx5i++aL/UbyOzOzTjyjRO55Fodi11r6smc2H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(10067099003)(22082099003)(261021123027099003)(921020)(4143699003)(11063799006)(261009223027099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2xhmbbfDkMMy8lChKPgbPRYWOku179tReixAxXfqrPQ2W297W2d4BmXfFk35?=
 =?us-ascii?Q?yeAonyveX5FvpAkD1yY33pXHv8tEVwhkoAknc3TIk0lyHDOoirj0R8BtD9eh?=
 =?us-ascii?Q?lY1+W537KhZUA/BgFZJWPSC4RyWBrBLgihQYWD/uJar9L5x1gt38O+bVGBAE?=
 =?us-ascii?Q?AzcL4b0G7bvOmOI5oOk8dPmmrXByZJkGZUVhynzwvN7ixvCj0f3zIXvBy7xu?=
 =?us-ascii?Q?3b9CUkhGzvCcnHq2R2wLNlgtdmcS/yIsMzMFjbs/dr0XhvcNg6gafH/+MJqF?=
 =?us-ascii?Q?0NGDS49Cd78DwCaRquZbUton4KcC7zTb1saqhLxnTbVjxZfcBZcrFE/EKjTW?=
 =?us-ascii?Q?RmmrV+MtmGXBMUk3uueVR2w7i+O1z0r5VCUpFIcbRnQrM4WX3hVKq5HVp5vZ?=
 =?us-ascii?Q?7W9AeoW3AAU18Ig8/nFE4kgeqVmzp/RpMF/NlXtl2iA3aXiC1EDcZ8aDAaSR?=
 =?us-ascii?Q?4QAa1DWXI2y5MMu6pFBvPRjiuMvqKi6cpkDh3GXM2w3fczMk4H56YGx4yQ+9?=
 =?us-ascii?Q?S6fnxLzmrwpFqyVguqeNg4CVWS9uExM5A9w+Dj/xyLTlpb5chUZAqIUhsFbv?=
 =?us-ascii?Q?Y1tYQ8gjQ8bQ9j0Cq6xoQAQqhzp08asH5NcwpBg9D1puJQIx7tXRyaxKjQYt?=
 =?us-ascii?Q?Ut07cYyu/vBtIo8uYUqQKxo8u3JQJU1p8mg8Q5dZoK4wR30SMFiD8ZRacOB8?=
 =?us-ascii?Q?m4NemhzluOpy5eY52mp7vsS3QG1PMqMxzPMTC6FScCcy7AdQ9ll2ZTsmjs6o?=
 =?us-ascii?Q?duwsZCLH35cja3z9GkRViJAol1d8gXdBqqTbnMEVFgLe2ysQeyhpMKlI4Udb?=
 =?us-ascii?Q?e62hd0xkOFp9f1BFSJ+HSHlunUdYjqSpyp3gSP14cOSxd08Kq+c8nEWrc/vw?=
 =?us-ascii?Q?pzVr0qo9xQ+rX8ImrE9HlWGzTGePjdNj5he7BZMHsZ48ZA5wlOfhQIB67T1Y?=
 =?us-ascii?Q?29Oh8yfRnvqqfvYL0Oaowtg6AQQdMThvloFt82gCmEX92pGvJqn37FgIevM2?=
 =?us-ascii?Q?oNjygCA9GvRhupUzwLKo06oYArXe16iFc5V/0TizgL8v4t+Z/W+at8XWrlpF?=
 =?us-ascii?Q?XngnjnFgQjqGa3IhX+c9wZmX+JWWxuyANph3L5OOTpfRrhiHyfG9yrx3Acxf?=
 =?us-ascii?Q?hzK5gLQt0WD2tquSPReoJKH6hHsubwMxl6ZYro53+0S4Qyw/qfcvRQIdMC9l?=
 =?us-ascii?Q?zTg1ND8knsw/cooSsw9Yi6YA3U9ghbyJVKXaxFtsTllJkF3+WDaTX8fn24M5?=
 =?us-ascii?Q?VkZDqxRutiELoQ+vkeOuXePQ0yLHOQgtrWt7M1Cew8SVVaywi8wSWywjH65I?=
 =?us-ascii?Q?mo7i7b3SI2QQ37LA25EAPi+gitVe7JhiINZvgSEicJOm17C+ameNowYj5lF1?=
 =?us-ascii?Q?GI3wshkmbF/zC4fM+NmUHVTYP0ManXI1sm7jIZr3eSSlvJeAWdCE+pz85Uwd?=
 =?us-ascii?Q?PzF61hwMpqD2sPxsx4a7NyBeV34CgxU2La2JRNcUMvwwyWeKoG8eW9cpFnwp?=
 =?us-ascii?Q?1bFZyKX/twM1Oo/Y/Jj2qGr5ByGdhc7wWHLkjTiY8Ib/e+jl38bqhAGvPpFD?=
 =?us-ascii?Q?r7fH2OcowPjOGJDH+kyv0uMMC06NEpo4kkgKrxgtXN5dmKj520iOCoBeUQJK?=
 =?us-ascii?Q?dhDeyLvJ5jNXcXfmsO1BLcrbjwImtOP4DaQkUfntZwgOOSdD3tWccN4CM5C1?=
 =?us-ascii?Q?On+IaGJVgSoGEUAQ+AcEFZAG7mUpMmQ9fxsMvCKwkDhSKHjNF5hU1Zo2tZBJ?=
 =?us-ascii?Q?ti759RUGWQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a31769-2129-4952-207e-08df2f9ff9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 18:20:24.5565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCBbXEQUbTpY5wWIe25Nq3wZvnj3MMFmqMOy2z1QSXWsm8W3XtusOmN4WrjZ4ODJYmsHLWQozA9UExOH/h+CF4QdEpLrtmJ4gy/rsHFy5B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9159

Hi Chris,

..

> @@ -3336,6 +3337,9 @@ static int lan743x_netdev_close(struct net_device
> *netdev)
>=20
>         lan743x_phylink_disconnect(adapter);
>=20
> +       synchronize_net();
> +       netif_tx_disable(netdev);

synchronize_net() is called inside of lan743x_tx_close() and lan743x_rx_clo=
se()
via netif_napi_del(). Do you see current order of calling is an issue?

> +
>         for (index =3D 0; index < adapter->used_tx_channels; index++)
>                 lan743x_tx_close(&adapter->tx[index]);
>=20
> --
> 2.34.1

Thanks
Woojung

