Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5E34B95CA;
	Wed, 30 Sep 2026 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811456; cv=fail; b=OKXTTq0BLs+PsPaf+ACSbAXkHIonGPFg3h3TWg0wPbHt7m+rOvXKpCx85KuSMCbAnVSMpEguCBGwL1fr8mIMXdZN+zUBBwBTs0dMZn7JqdWX45lPS0tfpG33tHMu41oaRfBK50OTfhvHK9D/1naYuLWO7eHLHesxFsVLcDox5VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811456; c=relaxed/simple;
	bh=Uq/HjCFyqxfk9VDgnbT01Y3bmgiOpLhRAmg06fQzSrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WpzBIM2i+3n3exGbNs4XI+oZ39FmBfHhNrms5/hAVHVk082/vHQoKUR9CEUYLfUUxYqGZw3pZQU/MnBLHT4gnTELdvawSeCpVGIEiLz03rhAESMqwhGCZXrT4dElTCZuvf4Tj1IOk6nm+TJY6K01bMKTwiBKWFCeD1rS4x4fzr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=HWBH4/ez; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=fjZVxBoo; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="HWBH4/ez";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="fjZVxBoo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=RNCoVNcZxDoIDtNmg8rbkxqD0hFKEjnTp031ENdlZfg=;
 b=HWBH4/ezUR165vldfOfQ8T2A9txw1yVi70JS4YAaGY1ogAROIUXklF6pSJnVDmcVBeOaFOusofIReF7gss60g5SOAI3EaBYAe8R5tX738k47rzwU8cr+bNhhdOppZrTEo1fPEjr+z/m+Kn9dZ9LijfY6vXNDcVzeVV8+Jfnp/lia1JchmOIrjia89dPsxO9sFaMCt5cv+gktPa5z8yqeDIF2C+ZAG4UP1wxd75q7fExsjG1D216y/zAzn4qPpozfISesCpT3fNN8CKkIkkMZPidwAkWMgIhdV3Dc/jiOe8Cg+2mbo2xImXCjF2AfqUCCMnml5L+bAEZeOoqO8uApjQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A4080100072;
	Wed, 30 Sep 2026 23:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNOzTNgfYUK6lViZHmcaxBWGmCPCFYsPs5ht/vCXp4CBKStqT4yq7ucVJhAAQ6U+xK6L/DD205MeDmeMjBx2/XAIPm+ysWY/P2dED3zUuZ0/NVCURgHrEMxXLBaGs13/J2SwE6/xSnNkoqilv1UbxqUHQmjSY4tlCjlVKPKCzdobDzdM7wVVYmDiUHsTuwjuPLH196jXvBbktugQ5YEebY3XmWANKwQqdeusNxFFFI/ITtIf+oPwbxvLS0h+R+OFpV3igvRS14FF5MsHhFBC86SVL5AfUyfQrx5FlN1V/rwriHgnw+vrvr602wkzocJlrtxYQk6oD2bb8+yCRKu8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNCoVNcZxDoIDtNmg8rbkxqD0hFKEjnTp031ENdlZfg=;
 b=tIq1USgYf1qAR+d52NAv9q5yuAqTvee9gLDqipF1PRIKynwDeGFh6hr+TZEWwQF3fRrPRPxZ+SGyHq8zQNT5eLKGfWLf8UeLSbIkaPtzrXqELFhD7gcsyBIXQish0giyqEN0jihjSv2wMqhziYbZuO+Ol6uby/CaWhXe6MQarlXSgLOUrYm5BrBgyW1xs2H2Af5hgkl3ECRt7LzEVCFEaRdDLIDjDOuEL6Q8LGVeSrN7+wejTulgMw3qY+hk3lOs2igYPJDH7LzzJCrb29+WrDF4r9FbEnSnBETn+d+CTY/Jwt1LhgsmVwVG3zHULqa1XooKmzgjFjGQk+NvPBN7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNCoVNcZxDoIDtNmg8rbkxqD0hFKEjnTp031ENdlZfg=;
 b=fjZVxBoo+mW7+CrQgohgvdF68RREfjCg3D7Ktx6gaR1FoW6SXFE8JIZzRxm0g8JWFGfcwQJNdkjeQ4oIKQ9vv9zotZ1Vnlof9E50kxFnG5rq/VNDu6p2SSSS+sv8ZpP6waCikqGDByqoBLBQi9f+j7VvEeoISDWyXloBjrPTacG+xvAeekSWN9yGboz0dpxuCdByO3+qfD9u1FpkdiaQshZ0yImFm8qUVWe+1BApMqkUbARDkZBlZfG4BbXiDxc2mQrJsvf3bzieo764vckixxflOvMwRAtWS6pn9TUU97aEQcUzWBQ7lGGAxxS0vjiKR2HeDdXScDwpzWosvnWIBQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5383.namprd20.prod.outlook.com
 (2603:10b6:806:29e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:37:27 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:27 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 13/13] dpll: sit9531x: model the inter-PLL sync
 net as a pair of pins
Thread-Topic: [PATCH net-next v11 13/13] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdUTSl7g3aEHGUEEeWm4NUuXPOYw==
Date: Wed, 30 Sep 2026 23:37:24 +0000
Message-ID: <20260930233714.87679-14-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5383:EE_
x-ms-office365-filtering-correlation-id: 949b05ad-2ea4-41c6-9d6a-08df1f4bc962
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 hbaLu2VoXMLrnqm9XxqSjkdXoRZTx2Iz739+WXURiOajjKFey+RGNkfkNGSx2zy0FDm5Khhf0DwjtwjRWOq/lUuTXSChnCOg6R0KpdN+xz39guDCZDKqde+zjAMz0ISwyCVlq6bwNMTqXHUmjRfc03x9KO4CrbRwBoh7RqFOwOml3438gOJ36gdTTtuF141cnBLn8loDHqIeyBwHdpRJ3GGps9hLrJ/vr8mhyLOm3hWgwIFPIDgbhBLD61rH2hqXrqT2PfbavBNHAKI8zJt4jiJLcZyGWpSLZfN281grol1/Z3Q59cHW7XvEpy2EjpMnvvG+ewOdaEmBYLMYPpojBLdLYAmUOZZtatsCLV+NwrRMd8lKPXks0Dx0dLGqt4OhNdUcBefF5nPCxeW6yxEpAto9CQUQAsgf70tcUXRVAuP/7lIa4J7eZv2JIStjCpTbW4u84CRcZNOorB7m+L/exNX7lIRrrcTjBZpNQIZ0IjliDUU3E5FnYOWGfzH3wa6LfEBMqQcLyvEa+9DrbsOfF2cVzo8fPs2uuSK8XuqSuFTWG5oFVvx9VDhUFf8isqzt7L8k97ZcxJyVPg7wquh1lYdLnsXdR5aGqvcN5ok34ZvmPa8og8TV4+uqb16XFGJx2kLv0MkyHujh2Xwcy4A3WiLLwHxfpxKim18kXhGKP1MAJWcK31tFF9OCz8p/mDhPr9SM+oO9b4o7AByk6XsPdhLj7OuGdifcguzjkSewN28=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3zLoP05IQrQk3w0MS7YTDvtAzrFOUJB1pK1+w8o7XD7fXvB9N2/pZBtrhr?=
 =?iso-8859-1?Q?QJImSW2jxGqlrX44n0mmowf0CrzBvbblO7tzXHkU7jj2c8PzX2fwkNb7Wt?=
 =?iso-8859-1?Q?lDmW5NFTCH+09sv1m//GxPmK/bMg+RR+Tm0N1nuSG87sUasednbGJbb0jJ?=
 =?iso-8859-1?Q?Grimja3FvFcUOD3iy0N/yfgeOHgelBJp/D16P1NmIiM+mJl4cJ3N3qR5JF?=
 =?iso-8859-1?Q?A/IyHFBcTHK6oZ/HTTCWN8dh+sd8R3PLt/7C4LZonNs/RHk6M1QPXfhFPL?=
 =?iso-8859-1?Q?+pmmjObXW30Oj0yQocEZpf0oSwthYVTW351H2r2/hDuph7t9hjYS1YYjif?=
 =?iso-8859-1?Q?exvj8qCglk/XKRUHk5CE395ToiGg/rY2sUGMalj1fO1+xdCDwvVDQIkbG1?=
 =?iso-8859-1?Q?MjTQ+39paB1WJy5kGQpbUSE6XS+XxeQBmKpUxgSq1mX6l468xNBwesPaq+?=
 =?iso-8859-1?Q?XmVs5THzX0SjG4AU9nxfQbnKq+gY/VsPdDxuYHuR45pK3xq2ivqckKIwSc?=
 =?iso-8859-1?Q?ShosXpnY3L3GMI4tyzldOcA0Jzen5XcCXPmGvVlmbNyleDpXjCXqhTLW6a?=
 =?iso-8859-1?Q?hPe1LTsxNL4PCN1eKvw98dUBl0y3Tb5AsLziLLJxRyEa2O9GqVH6A/QsBS?=
 =?iso-8859-1?Q?t+zVdhgt9vUCG2Ta6v1ekt6273qV0Baq5CvI3JoYqyWoBg4Nt8kcrBXJtH?=
 =?iso-8859-1?Q?JiNr4pmwk0WtVgR9gsZHRPwfldUKR9RtBbcGrl/oBsQOrJZeLPIlOaEOGn?=
 =?iso-8859-1?Q?KCFTFhQ1lHAeisxXH0zygzXQZ/bIR+v53b+s/7BS9B3izsvq8vbhEjIi5J?=
 =?iso-8859-1?Q?dwbFJkEnkHpQI4HqHl22riQc5X5pFr2ShHyZtdD000x2sXn6E3ZyFXFhc7?=
 =?iso-8859-1?Q?60quY6iIl9JknMoWxo+XtTvSPsuEzKYZg/0Q4KDQ/PEd0H1mMR1MVw1ntC?=
 =?iso-8859-1?Q?xkEuGB1zRQ0PGZWfrBkQf2RWGIL8FOTEl7nVGnIDOZnAgYfxB3BznLhsOy?=
 =?iso-8859-1?Q?88s+7Q6HDh+yPSOUeInCxTXBvAaeCr90sR24YyYmZUy9A/WAU0HWL3megY?=
 =?iso-8859-1?Q?hfZJ4GvKU51O4rZwpsuE+9MxY7qF3viYYXB3BAM+w4sp9Usi7jWl1HzeEh?=
 =?iso-8859-1?Q?9MsYpPUof+RM8k1lv9zDj7DuA0eaduAUSmNtTVCDF1nEYXWKnMYERBthsx?=
 =?iso-8859-1?Q?E8gxrNPtT5TwKs9ccqsIHtghCgDezZVjfF/2l6DQtArWLxzgo0DWPGHxAd?=
 =?iso-8859-1?Q?bjKKWVllvnutaVCEIwfep55lTa0FiyMLSoDpTggMXnOaO9XVd+NhiKhg3m?=
 =?iso-8859-1?Q?hYQZ3/shqDh0kL1IIAm0tKoqflHjO992lMQ6METJF1mj68aJ7mw1lKlie+?=
 =?iso-8859-1?Q?pj3aoFpWs6OU+Gza0YSU8Floyo6SKkaNJhZ4pRhDtPUqcothypxx4GWnhy?=
 =?iso-8859-1?Q?qPFWdEIp6FK6rmhwZQnJ+ug6pbFvEFWO1lZ3bqYBnh3NrzbmYEAlcRPP0N?=
 =?iso-8859-1?Q?re/torUwzVHXtOdInZVqJS0zrxWEbJSrzLtTJBYYSKfM+KBXIiqrI2c1db?=
 =?iso-8859-1?Q?oKZ293kOn+j8C7NGjuoupFhV/IMpLqZPIdKZ9tSiBIoBHLlTrZqXZCxFEx?=
 =?iso-8859-1?Q?yVpWMl4tF8biBxR/C+bdU+DyvH5PKI7sPSPP7c3hsJMMz913ARU1vDg1Tf?=
 =?iso-8859-1?Q?I/uv2k/rEXcVi+n8rVDl3j0nePeG0iOUQkkzYTsXQQ5hIaph/9JB9yhgQn?=
 =?iso-8859-1?Q?98ZA6NdgyMhpY6z/cnrQ9HPazdoTptycHFAr3kfD3L6kgT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Zz6brCTXmym/sZMNYIrVCYuSTX/d8hODnDCDoJWZMt8lx9IrFWIbiqa9TYJFbJsGWTBHTmij7vrzR1U0I2n6kdWuJ7g0ZVtm1QnJfSZiAWokPHCmm+aqqvTnJjrmt5CRWzuuTFliVXj5wlk6v/y1JWAmTjMmOKdqszU5j2x01qP+YBp3AyVSjLx89qI/iBNC8JLSsCNT8+EY/J7tjpyVALTVqJoQb98e+m7l5ZoQBPmNUg4RvK8XXrnLbakbj2TyIYygTSNeWdtkddVHUBeG8pyHhLd+pNIsDMciuKy1KgY6fVelzOvuO9zlqZ/upgzs2lnD/o/E4ZGobnDgm9ThDA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949b05ad-2ea4-41c6-9d6a-08df1f4bc962
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:24.5910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RP9W8iy++y8+jaNWlbElro0prcQUf4r7ZQL1IuaiER4DBbsYXMlqRZyMsySIYWJQTjn/EzzUXXvKn/83KDcEOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383
X-MDID: 1790811451-5VKOhD9SXHtu
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811451;5VKOhD9SXHtu;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The device has an internal net by which one PLL can drive the others: the=
=0A=
source PLL puts its output on it, and any other PLL can select it as a=0A=
reference instead of an external input.  The two ends are nothing alike --=
=0A=
one is driven, the other is selected -- so they are two pins rather than=0A=
one: an output pin on the source and an input pin on each destination.=0A=
=0A=
That keeps each pin honest about what its state means.  The source pin=0A=
reports whether this PLL is the one driving the net, and setting it takes=
=0A=
the net over or gives it up; a destination pin reports whether its PLL has=
=0A=
selected the net, and behaves like any other selectable input.  A single=0A=
pin would have had to answer both questions at once and could only have=0A=
been right about one of them.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 345 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   3 +=0A=
 drivers/dpll/sit9531x/dpll.c | 272 ++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/regs.h |   3 +=0A=
 4 files changed, 620 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 45baa703aa45..6b607f3d5fc3 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -2760,6 +2760,338 @@ int sit9531x_clear_notifications(struct sit9531x_de=
v *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Close the debug window on a PLL's EXT page.  The key register opens=0A=
+ * every debug register on that page while it holds the unlock value.=0A=
+ */=0A=
+static int sit9531x_intsync_debug_lock(struct sit9531x_dev *sitdev, u8 ext=
_page)=0A=
+{=0A=
+	return sit9531x_write_u8(sitdev,=0A=
+				 SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),=0A=
+				 SIT9531X_PLL_DEBUG_LOCK);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * INTSYNC configuration register values.=0A=
+ * These are written to the source PLL's EXT page to enable/disable=0A=
+ * inter-PLL synchronization (lock frequency PLL to phase PLL).=0A=
+ */=0A=
+struct sit9531x_intsync_reg {=0A=
+	u8 offset;=0A=
+	u8 en_val;=0A=
+	u8 dis_val;=0A=
+};=0A=
+=0A=
+static const struct sit9531x_intsync_reg intsync_config[] =3D {=0A=
+	{ 0x2D, 0x02, 0x00 },=0A=
+	{ 0x50, 0x08, 0x00 },=0A=
+	{ 0x51, 0x04, 0x00 },=0A=
+	{ 0x54, 0x02, 0x00 },=0A=
+	{ 0x55, 0x28, 0x20 },=0A=
+	{ 0x5C, 0x0F, 0x00 },=0A=
+	{ 0x5D, 0xFF, 0x00 },=0A=
+	{ 0x6C, 0xDD, 0x00 },=0A=
+};=0A=
+=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	s8 src =3D -1, partial =3D -1;=0A=
+	u8 global;=0A=
+	u8 pll, ext_page;=0A=
+	int rc, ret, n_en, n_dis;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &global);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {=0A=
+		sitdev->intsync_src =3D -1;=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	for (pll =3D 0; pll < SIT9531X_NUM_PLLS; pll++) {=0A=
+		ext_page =3D SIT9531X_PLL_EXT_PAGE(pll);=0A=
+=0A=
+		/*=0A=
+		 * These are debug registers, which the enable and disable=0A=
+		 * sequences only touch with the EXT page's debug window=0A=
+		 * open; read them the same way.=0A=
+		 */=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    SIT9531X_PLL_REG_DEBUG),=0A=
+				       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		n_en =3D 0;=0A=
+		n_dis =3D 0;=0A=
+		for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+			u16 reg;=0A=
+			u8 val;=0A=
+=0A=
+			reg =3D SIT9531X_REG(ext_page, intsync_config[i].offset);=0A=
+=0A=
+			rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+			if (rc)=0A=
+				break;=0A=
+			if (val =3D=3D intsync_config[i].en_val)=0A=
+				n_en++;=0A=
+			else if (val =3D=3D intsync_config[i].dis_val)=0A=
+				n_dis++;=0A=
+		}=0A=
+=0A=
+		ret =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+		if (!rc)=0A=
+			rc =3D ret;=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		if (n_en =3D=3D ARRAY_SIZE(intsync_config)) {=0A=
+			/*=0A=
+			 * Only one PLL can drive the net.  If a second=0A=
+			 * one matches, the registers are not describing=0A=
+			 * a state this driver put the device in, so say=0A=
+			 * so rather than pick silently.=0A=
+			 */=0A=
+			if (src < 0)=0A=
+				src =3D pll;=0A=
+			else=0A=
+				dev_warn(sitdev->dev,=0A=
+					 "PLL%c also matches the INTSYNC source pattern; keeping PLL%c\n",=0A=
+					 'A' + pll, 'A' + src);=0A=
+		} else if (n_en && n_dis &&=0A=
+			   n_en + n_dis =3D=3D ARRAY_SIZE(intsync_config) &&=0A=
+			   partial < 0) {=0A=
+			/*=0A=
+			 * Every register holds one of the two patterns and both=0A=
+			 * occur: the residue of an enable or a disable that=0A=
+			 * stopped part way, and nothing a profile writes.=0A=
+			 */=0A=
+			partial =3D pll;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * A disable that stopped part way leaves a PLL holding a mix of the=0A=
+	 * two patterns.  Treat it as the owner, so that a repeated disconnect=0A=
+	 * on that PLL runs the disable again and another PLL cannot be=0A=
+	 * enabled on top of the leftover configuration.=0A=
+	 */=0A=
+	if (src < 0 && partial >=3D 0) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c holds a partial INTSYNC source configuration\n",=0A=
+			 'A' + partial);=0A=
+		src =3D partial;=0A=
+	}=0A=
+=0A=
+	sitdev->intsync_src =3D src;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_enable - enable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Enables INTSYNC global bit, unlocks the source PLL's EXT page=0A=
+ * debug registers, writes configuration, and triggers a small=0A=
+ * update on the source PLL.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].en_val);=0A=
+		if (rc)=0A=
+			goto relock_err;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+	if (rc)=0A=
+		goto relock_err;=0A=
+=0A=
+	rc =3D 0;=0A=
+	goto relock;=0A=
+=0A=
+relock_err:=0A=
+	sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	goto err_disable;=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the EXT page debug window the sequence opened.  Nothing=0A=
+	 * else writes the key back, so leaving it open would keep the block=0A=
+	 * unlocked for as long as the device runs.  The net is driven by=0A=
+	 * now, though, so a failure here must not read as a failed enable:=0A=
+	 * the caller would then not record the owner of a net that is=0A=
+	 * driven.=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "PLL%c: INTSYNC enabled but the debug window was left open: %d\n",=0A=
+			 'A' + src_pll_idx, lock_rc);=0A=
+=0A=
+	return rc;=0A=
+=0A=
+err_disable:=0A=
+	/*=0A=
+	 * The global enable is already set at this point.  The caller only=0A=
+	 * records the source PLL when this function succeeds, so nothing=0A=
+	 * else will ever clear the bit: undo it here rather than leave the=0A=
+	 * net asserted with a half-written EXT page.=0A=
+	 */=0A=
+	{=0A=
+		int rollback_rc;=0A=
+=0A=
+		rollback_rc =3D sit9531x_intsync_disable(sitdev, src_pll_idx);=0A=
+		if (rollback_rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "INTSYNC rollback failed after enable error: %d (original %d)\n",=0A=
+				 rollback_rc, rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_intsync_disable - disable inter-PLL synchronization=0A=
+ * @src_pll_idx: source (frequency) PLL index (0-3)=0A=
+ *=0A=
+ * Clears INTSYNC global bit, writes disable values to the source=0A=
+ * PLL's EXT page, and triggers a small update.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)=
=0A=
+{=0A=
+	u8 ext_page, val;=0A=
+	int rc, lock_rc;=0A=
+	unsigned int i;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (src_pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	/* Small update on Page 0 */=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	usleep_range(1000, 2000);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	/* Unlock debug on EXT page */=0A=
+	rc =3D sit9531x_write_u8(sitdev,=0A=
+			       SIT9531X_REG(ext_page,=0A=
+					    SIT9531X_PLL_REG_DEBUG),=0A=
+			       SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {=0A=
+		rc =3D sit9531x_write_u8(sitdev,=0A=
+				       SIT9531X_REG(ext_page,=0A=
+						    intsync_config[i].offset),=0A=
+				       intsync_config[i].dis_val);=0A=
+		if (rc)=0A=
+			goto restore_global;=0A=
+	}=0A=
+=0A=
+	/* Small update on source PLL */=0A=
+	rc =3D sit9531x_pll_small_update(sitdev, src_pll_idx);=0A=
+	if (rc)=0A=
+		goto restore_global;=0A=
+=0A=
+	goto relock;=0A=
+=0A=
+restore_global:=0A=
+	/*=0A=
+	 * The global enable was cleared first, so a failure here leaves the=0A=
+	 * EXT page still holding the enable pattern with nothing pointing=0A=
+	 * at it: the source detector keys on the global bit, would report=0A=
+	 * the net as unowned, and a retry of the disable would then=0A=
+	 * short-circuit.  Put the bit back so the state stays one the=0A=
+	 * driver can describe and the request can be repeated.=0A=
+	 */=0A=
+	if (!sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val))=0A=
+		sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,=0A=
+				  val | BIT(SIT9531X_INTSYNC_EN_BIT));=0A=
+=0A=
+relock:=0A=
+	/*=0A=
+	 * Close the EXT page debug window the sequence opened.  After a=0A=
+	 * disable that took effect, a failure here is a warning, for the=0A=
+	 * same reason as in sit9531x_intsync_enable().=0A=
+	 */=0A=
+	lock_rc =3D sit9531x_intsync_debug_lock(sitdev, ext_page);=0A=
+	if (lock_rc) {=0A=
+		if (rc)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: debug window left open: %d\n",=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c: INTSYNC disabled but the debug window was left open: %d\n",=
=0A=
+				 'A' + src_pll_idx, lock_rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /**=0A=
  * sit9531x_chan_selected_ref_read - read a PLL's active reference now=0A=
  * @sitdev:	device pointer=0A=
@@ -3379,6 +3711,15 @@ static int sit9531x_dev_state_fetch(struct sit9531x_=
dev *sitdev)=0A=
 		return rc;=0A=
 	}=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc) {=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to detect INTSYNC source: %d\n", rc);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
 	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
 		s32 phase_ps;=0A=
 =0A=
@@ -4081,13 +4422,13 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
 			return true;=0A=
 		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
-			return false;=0A=
+			return true;=0A=
 =0A=
 		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 	}=0A=
 =0A=
 	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
-		return false;=0A=
+		return true;=0A=
 =0A=
 	if (index >=3D sitdev->info->num_outputs)=0A=
 		return false;=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index bebdc9f5abce..0b6a787b4afb 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -294,6 +294,9 @@ int sit9531x_output_phase_adjust_set(struct sit9531x_de=
v *sitdev,=0A=
 int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- INTSYNC (inter-PLL synchronization) ---- */=0A=
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
+int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev);=0A=
 =0A=
 /* ---- Phase offset (TDC readback) ---- */=0A=
 int sit9531x_chan_selected_ref_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 6bf4efd3c633..52d5b1a6e36f 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -27,6 +27,20 @@ static bool sit9531x_dpll_is_input_pin(const struct sit9=
531x_dpll_pin *pin)=0A=
 	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
 }=0A=
 =0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_PIN_ID;=0A=
+}=0A=
+=0A=
+static bool=0A=
+sit9531x_dpll_is_intsync_src_pin(const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	return !sit9531x_dpll_is_input_pin(pin) &&=0A=
+	       pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;=0A=
+}=0A=
+=0A=
 static bool=0A=
 sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
@@ -772,8 +786,259 @@ sit9531x_dpll_output_pin_direction_get(const struct d=
pll_pin *pin,=0A=
 				       enum dpll_pin_direction *direction,=0A=
 				       struct netlink_ext_ack *extack);=0A=
 =0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_src_state_on_dpll_set - drive INTSYNC from a PLL=
=0A=
+ *=0A=
+ *   CONNECTED    -> this PLL drives the INTSYNC net=0A=
+ *   DISCONNECTED -> stop driving INTSYNC if this PLL drives it=0A=
+ *=0A=
+ * SELECTABLE is rejected: driving the net is an explicit output routing,=
=0A=
+ * not an automatic-selection candidate, matching the regular output pin.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc =3D 0, detect_rc =3D 0;=0A=
+	bool changed =3D false;=0A=
+	u8 hw_src;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+			break;=0A=
+		if (sitdev->intsync_src >=3D 0) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "INTSYNC is already sourced by another PLL");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * A PLL that already lists INTSYNC among its references must=0A=
+		 * not also drive it: the destination side refuses the mirror=0A=
+		 * of this, and without the check here the net could be routed=0A=
+		 * back into the PLL feeding it.=0A=
+		 */=0A=
+		hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+		if (sit9531x_input_prio_present(sitdev, sitdpll->id, hw_src)) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL selects INTSYNC as a reference; it cannot drive it");=0A=
+			rc =3D -EBUSY;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id);=0A=
+		changed =3D true;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		if (sitdev->intsync_src !=3D sitdpll->id)=0A=
+			break;=0A=
+		rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id);=0A=
+		changed =3D true;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Record what was done before confirming it, and only when this PLL=0A=
+	 * actually changed: the core forwards a request for the state the=0A=
+	 * pin is already in, and a DISCONNECTED on a PLL that never drove the=0A=
+	 * net must not erase the owner.  The refresh below leaves the cache=0A=
+	 * untouched when a read fails, and a cache that wrongly says nobody=0A=
+	 * drives the net would let a second PLL be configured to drive it.=0A=
+	 */=0A=
+	if (changed && !rc)=0A=
+		sitdev->intsync_src =3D state =3D=3D DPLL_PIN_STATE_CONNECTED ?=0A=
+				      sitdpll->id : -1;=0A=
+=0A=
+	/*=0A=
+	 * Re-scan hardware after a transition so the cache follows a=0A=
+	 * partially failed enable or disable as closely as possible.=0A=
+	 */=0A=
+	if (changed)=0A=
+		detect_rc =3D sit9531x_intsync_src_detect(sitdev);=0A=
+	/*=0A=
+	 * The refresh only re-reads what the device now shows.  Failing=0A=
+	 * the request because that read hit a bus error would tell=0A=
+	 * userspace the enable did not happen when it did.=0A=
+	 */=0A=
+	if (detect_rc)=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "INTSYNC source cache not refreshed: %d\n",=0A=
+			 detect_rc);=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc && rc !=3D -EBUSY && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC source state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_src_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_src_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_src_state_on_dpll_set,=0A=
+};=0A=
+=0A=
 /* ---- INTSYNC destination (input) pin ---- */=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_get - INTSYNC reference state=
=0A=
+ *=0A=
+ * Selection role, so the contract above decides this exactly as it does=
=0A=
+ * for a physical input: the priority table is the eligibility record, and=
=0A=
+ * whether a source PLL happens to be driving the net right now is no more=
=0A=
+ * a state than a momentary LOS is on an external reference.  The one=0A=
+ * addition is that the PLL driving INTSYNC is never its own destination.=
=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state *state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else=0A=
+		sit9531x_dpll_selection_state_get(sitdev, sitdpll,=0A=
+						  SIT9531X_INTSYNC_PIN_ID,=0A=
+						  state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_intsync_dst_state_on_dpll_set - lock a PLL to INTSYNC=0A=
+ *=0A=
+ * Selection role, so this accepts and refuses what a physical input does,=
=0A=
+ * CONNECTED included: the device pins no reference on request whichever=
=0A=
+ * source is asked for.  INTSYNC is an internal net with no physical=0A=
+ * receiver, so only the per-PLL priority table is touched; the source pin=
=0A=
+ * controls generation.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					    void *pin_priv,=0A=
+					    const struct dpll_device *dpll,=0A=
+					    void *dpll_priv,=0A=
+					    enum dpll_pin_state state,=0A=
+					    struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		if (sitdev->intsync_src =3D=3D sitdpll->id) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "PLL cannot lock to the INTSYNC it drives");=0A=
+			rc =3D -EINVAL;=0A=
+			break;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EINVAL && rc !=3D -EOPNOTSUPP)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_intsync_dst_operstate_on_dpll_get(const struct dpll_pin *pin=
,=0A=
+						void *pin_priv,=0A=
+						const struct dpll_device *dpll,=0A=
+						void *dpll_priv,=0A=
+						enum dpll_pin_operstate *state,=0A=
+						struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_operstate_get(sitdev, sitdpll,=0A=
+					      SIT9531X_INTSYNC_PIN_ID,=0A=
+					      state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Do not add .frequency_get / the generic input state getter here: the=0A=
+ * destination pin id is SIT9531X_INTSYNC_PIN_ID, one past the end of the=
=0A=
+ * ref[] array (INTSYNC is an internal net with no ref[] entry).  The ops=
=0A=
+ * below only ever key on chan[] and the priority table, never ref[id].=0A=
+ */=0A=
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops =3D {=
=0A=
+	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_intsync_dst_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_intsync_dst_state_on_dpll_set,=0A=
+	.operstate_on_dpll_get	=3D=0A=
+		sit9531x_dpll_intsync_dst_operstate_on_dpll_get,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+};=0A=
+=0A=
 /*=0A=
  * XO (crystal oscillator) pin ops=0A=
  *=0A=
@@ -1070,8 +1335,13 @@ static const struct dpll_pin_ops sit9531x_dpll_outpu=
t_pin_ops =3D {=0A=
 const struct dpll_pin_ops *=0A=
 sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)=0A=
 {=0A=
-	if (!sit9531x_dpll_is_input_pin(pin))=0A=
+	if (!sit9531x_dpll_is_input_pin(pin)) {=0A=
+		if (sit9531x_dpll_is_intsync_src_pin(pin))=0A=
+			return &sit9531x_dpll_intsync_src_pin_ops;=0A=
 		return &sit9531x_dpll_output_pin_ops;=0A=
+	}=0A=
+	if (sit9531x_dpll_is_intsync_pin(pin))=0A=
+		return &sit9531x_dpll_intsync_dst_pin_ops;=0A=
 	if (sit9531x_dpll_is_xo_pin(pin))=0A=
 		return &sit9531x_dpll_xo_pin_ops;=0A=
 	return &sit9531x_dpll_input_pin_ops;=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 0ba3c73aa3ed..c0e7c22a3e56 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -324,6 +324,9 @@=0A=
 #define SIT9531X_PLL_REG_ACTIVE		0x02=0A=
 #define SIT9531X_PLL_ACTIVE_BIT		BIT(0)  /* PLL reached active state */=0A=
 =0A=
+/* PLL EXT page INTSYNC configuration registers */=0A=
+#define SIT9531X_PLL_EXT_PAGE(_idx)	(SIT9531X_PAGE_PLLA_EXT + (_idx))=0A=
+=0A=
 #define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)=0A=
 =0A=
 /*=0A=
-- =0A=
2.43.0=0A=
=0A=
