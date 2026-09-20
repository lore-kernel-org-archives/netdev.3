Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021084.outbound.protection.outlook.com [40.107.130.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D96339394;
	Sun, 20 Sep 2026 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925652; cv=fail; b=SJAP9IGSvCk63iIWIoO/IUJfG9EWim80Xu6NKWhsLc/Eby0CWxReCokbSHnpsgJXnCHuWa8Us2G/WaMI7IbWIMn42AOlRGUV1fOSx153BJe73vNY71h9ac5svPOxAc4DyyfJ7lOm6OpS/D1zQWCIeXo4Z+Vi0ZnpMy2rHOKz2q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925652; c=relaxed/simple;
	bh=RBLANW31GdYXM6Kzw7r0xZotRzA74QdnfZXoReQ8LUI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ii59EoCb1Y32xHVTnn/ueDEzrKpDGeAlc5d/1ivKCTg+HAzWfFzGYIJRgvRFiJbKq1YWuN/UkSxLg/dczeToqU0+WeoT8oOdFxLEcYyU4/5W8finJXsMOLJl+gV5mjT/fsyFgEifFjZsuOQ7Mj0Z+De37os8ekUQuOpIbOb1jG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=studio.unibo.it; spf=pass smtp.mailfrom=studio.unibo.it; dkim=pass (2048-bit key) header.d=studio.unibo.it header.i=@studio.unibo.it header.b=yEbPzCUN; arc=fail smtp.client-ip=40.107.130.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=studio.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=studio.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=studio.unibo.it header.i=@studio.unibo.it header.b="yEbPzCUN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k56gmH6M7aQMkANYX7CGAroebW7zPPTM4KARgmiOjoHv1qtLd50m7odaPReKtwwkUA5sdxpmU2HLjSw3A60unTv+Gu8JX90Dd91LeOyVXqXhPpjU7Kpe+h3Ku0JbWL5XNLbFQu62RBK2ieYNp+pIPV3ozUX2JcB5MsgYZT0rpnMtEFM9AerV7ZxnnCa/NOumnhvS+lTJu1QFaW+58RLXu6PKcyeO81P/SaEjOI5aLVvNDe0NVhMdz9kHkpiW/GeXw7AuTZ5g6CQOfNSi+3pi8G289uA3LHldlx36WqTYPZuONQBSnMOpi59ec/W53UFcQDfSSfgvT7+HuaDILJQ2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBUn76pYUfA2qQpAq8ZXaC8j8kYIiVl7Lyqd8bdY2ek=;
 b=BGrNL9oOWQYdsowUhneDhbzMnPx9XKNrop/3dROUOQediqJCq5c6O/KTz0WXhwm6UbP4VBq88gczXMNuIr6PCercPY7fEmtenD1crQhtz8Rin/vrnNxdsRAAQhT0xm0QYWgnFlPK8aogJ9KL6PyQRHj2c8ySpzzTtFVJ6n4hQNGWHxqe9Cjdl9ly7mCV6VNFs98KQUoJjuVGryQi3ueKco0eY4aY/x63rOFWBnePenVah7/yzyLqyTobyXTMFFeZmXTMoST+8u0ubBOKFz3XM3ca8AHFU3XpeXPNmvoRZ868rnL0HYDk0fdaau0CRoOV8fm6A2P9NEKymu3mdfGURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=studio.unibo.it; dmarc=pass action=none
 header.from=studio.unibo.it; dkim=pass header.d=studio.unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studio.unibo.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBUn76pYUfA2qQpAq8ZXaC8j8kYIiVl7Lyqd8bdY2ek=;
 b=yEbPzCUN7RaSGEIZUWKdMFLiZv5LZ+8wVET6C3Uw+LzTVLXh1TxzhZQESEH1vpfDv6rPu3Y9lXMW/dsJh/3FUpD0Bw14wGpzPit6QfECbldSb/u8XLnnzLfwtyEMpAuRRtsIuq69BeSltUE64iKD102oEa6wBEakoWBWougOIejT0hLwlIlgJZwkOLzHIitYDKZUPVT/WdjDvvcSfYCWMbbcbU7jtGD0p2AZWjRL+lrjEw7oLb64IQuwWioFLyZtf0MWfYE6Q6wTJ13lg13pxjZFkcFVEmiAxzxJxwX2NEJVv/2uVEyclkw8VGWam7YqlDliI45sWQTsM3VU5b9D5g==
Received: from DU4PR01MB12163.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:620::18) by GV1PR01MB11033.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:212::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 17:34:02 +0000
Received: from DU4PR01MB12163.eurprd01.prod.exchangelabs.com
 ([fe80::bffd:753f:fbcc:c402]) by
 DU4PR01MB12163.eurprd01.prod.exchangelabs.com ([fe80::bffd:753f:fbcc:c402%6])
 with mapi id 15.21.0428.015; Sun, 20 Sep 2026 17:34:01 +0000
From: =?iso-8859-1?Q?Nicol=F2_Giuliani_-_nicolo=2Egiuliani6=40studio=2Eunibo=2E?=
 =?iso-8859-1?Q?it?= <nicolo.giuliani6@studio.unibo.it>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: R: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the TAI
 period is invalid
Thread-Topic: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the TAI
 period is invalid
Thread-Index: AQHdSHBd+pGZ8FgfBki6KEuSlYSfVLbXjVuAgAAtc+U=
Date: Sun, 20 Sep 2026 17:34:01 +0000
Message-ID:
 <DU4PR01MB12163870875DEF21E5C39DD2D80852@DU4PR01MB12163.eurprd01.prod.exchangelabs.com>
References: <20260919-send-net-v1-1-4355c72465ee@studio.unibo.it>
 <66937bde-51a0-49d2-9ae7-f27fb4f8ecde@lunn.ch>
In-Reply-To: <66937bde-51a0-49d2-9ae7-f27fb4f8ecde@lunn.ch>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=studio.unibo.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU4PR01MB12163:EE_|GV1PR01MB11033:EE_
x-ms-office365-filtering-correlation-id: ab752478-77e8-466f-5d07-08df173d5c49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|786006|23010399003|366016|1800799024|6133799003|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 V1lsnytfYz3RdJNhhRGes/Ik4VvY52s9wroVRN0zra0LFih/MiDcFn6pAsP6M2o1gAObOTKa8sQ98mdNVku/5Dj6dkj/muRVSMLMCPmT0R7sgLAqeZS0vRwNeuebQNa/+qhEVWmr8hX4mkiLjXg6A/izd7tSXDlGP2+d7rOhp7jhuZ2XryYcht70KGlQnNbRc48XZeBlco7wyAP64EtIDG6MGYDAtgoaG5EBXQLPfk7KhzTxwgT3AcdR6k1m8IRK7EJNMGo1il5Wu8N7Qi1nBw11x+8UUqLycjHhnDiZilIAxDTPx4R6MZgHMV5FdiTYazZC2Is95Ed9UXiMJJw9HpHnPo8tpCDvR0Z2+Mw2/iVREo1MmDCsJQcU5//yT1b+BuF+LsGUbsxAWSWyffXbbluQnguqru1oidN/HFFwH9PWjpL3G+5USJ6CmanOYImkX4IYgNLRnNIQKW7qa0KwXPfpP4/ZLsAxbYeUBda2R2n9JZWRXOY2Cg9FyurVB3uUElsO0Lti50q2OvZ0K9f6TGGd8/yjQyw2jAzjyM5aqd0XEJAUk6bqtVM1A1WyaHQOv+rVwrvqbDL2+DcRZgx6PHzoR2PTWGHp2ddeaD1pXIeuIFIpERmT7K3UHcrFR/dEg18ZIPRN+UeOuPlOlwBQpXDSlaHKlj1wMR/h3T+sG+FBuew11LI81kpREVMk0B3qoSQ67CF9QQDNXQlqqHTGY4re7lYCv7yndRyzsrsTxcc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR01MB12163.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(786006)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YCL374618CteNDm6v/AjlPbWFg71AYt3wVEn3sLgcbXG7zSPJf/lacdwvP?=
 =?iso-8859-1?Q?+JEVkmvhqU77TsImITwBaUyzr6j8I4cJh4u/sn2fqw34uuOv35MWEXcTPf?=
 =?iso-8859-1?Q?iMqJ8cle7JafEL7O5suqu6U+USxvxFPKSE1DLZTBVy4ASvpyS9dneVwXxi?=
 =?iso-8859-1?Q?qjZLrIHV7YE1zDvEBzF8jQNlNkWl4k7Yp8GNsNQfNBuzsJyOhd1kXImzGH?=
 =?iso-8859-1?Q?zfYjrmb8FLyfM7f8MwPnDXFp25x0clV2g+O0HaocuCO1qWlrl2ekgjAvsS?=
 =?iso-8859-1?Q?hRi06/5nC3gwMkhfAlXkwztxAF9ZQjy71upNp9KeCeP/DIuo1T/NVjrLqw?=
 =?iso-8859-1?Q?VHNoRWS++IeDE2s/JksoipA3dyECEfAYRFlS3nhnYOAitqKP2NKJDJHa9X?=
 =?iso-8859-1?Q?/8ALzu7dlyX4KtxIEbID/1rRayjIpEPjlqgoVnoIUkVEWB0NGLRZw/QNeG?=
 =?iso-8859-1?Q?rPtusjxthCLf8Nfn4C9DwaULcOTXr+SGeuBOGnbyEaSdLueuIerdRvczWT?=
 =?iso-8859-1?Q?1d1VN4JwmYWypHf24uYkbA3uzc6Vrt/XBqXHC95bezwjmI1Mvlz7praSYA?=
 =?iso-8859-1?Q?Hnh9NuJbDMxAL3YwxZZYTBaMXQ7cu3dCr5gtaqM/FyMqiy0a+dPOAxQc3c?=
 =?iso-8859-1?Q?iyfRfCljYjsA2JIUBm8SzfTWqjgluNI9VqBaGbtru6YlVLMt54aJtFNHK+?=
 =?iso-8859-1?Q?gx9YwzWqM/eDNmjPrPHsqshuoRCZtNHK4dr4y8IeKsV6hdX0mN48h3FNpV?=
 =?iso-8859-1?Q?sk3u9QIMEXL0SaJkPKFk9FBQIbDsKyvdsSZsKqA9VLDLDyc5VrLC9YuCjM?=
 =?iso-8859-1?Q?yMwdA/STv+QBWt7ZB79qehk87DdcGWTxlhYSTmd6tm73kZLuxSZQXcDpgl?=
 =?iso-8859-1?Q?pRmhzWapoATtqZeS4T1mL9bKGnpZBzuq0snahSHy+xJEFr3/Mo7pGtT1zA?=
 =?iso-8859-1?Q?Hy6gtwAWCwZT9EhTInBDq42n5SG1Yme3WXYA7/zlLE14o0Zx2ydgutGNGY?=
 =?iso-8859-1?Q?a42B+MlSXia04aLxUWZainpCSgGWtVybQx8BThuJkB8zG68l+18fLK1KOB?=
 =?iso-8859-1?Q?Yb93z8szXDMsry3lmEOba84BR+DU/EgealI1FlwNjVm8lga5RqRZJ9Ww55?=
 =?iso-8859-1?Q?6cI5CsIJoOznCVT85Sa5XflmH7RDmbnYNVL5ch/bfJDw9l7mQiNl1gVxyt?=
 =?iso-8859-1?Q?bRL+Ug+O8gwkXA/e4lrw8QoVjHHCT64NWNr2MoKG74F2zuwduuV7GO7EEk?=
 =?iso-8859-1?Q?Xuzj13ZnI08DE60WhIQOplQnSUvjOunAoevWLAEazREKAkyfoL1iD1qyRx?=
 =?iso-8859-1?Q?vsYYpuYtObrwbO4zO/PB+3KfQtoYjDWXReoKCLNOO4ZqhTFqLj4TA2W2dk?=
 =?iso-8859-1?Q?ZtBebc7foNghRV+MBxzPYcT9R740ewNr5dgAU7TjOu6RJl4l7xAokC9aDp?=
 =?iso-8859-1?Q?ucEjTS4EjCxLrAe7VByEwD+xhvM1Lwqdsal1ib0zv55ipW7THALy5KgT5O?=
 =?iso-8859-1?Q?+9NZ/vJSlu6TmdKe/Ol5rL23wZ8mHuiVSPqeAt6DD3A4Nkdrv1iCROavWF?=
 =?iso-8859-1?Q?kVReEk6aLeyq19I2N6ExXlFgJuKvPUK4XZvsUMXpErO4JizkStKHfohrHL?=
 =?iso-8859-1?Q?kdV8bdJeCWOnngz+biNR149tIaQA6YLr1FoD17NIu1TYurYcCwu2FHfRkx?=
 =?iso-8859-1?Q?67Pp3Zn0TKcniENJcfpWKBYtNOE7r1ybJiC44Z7Z3IAxYAZsAvD08IiOoE?=
 =?iso-8859-1?Q?5VUN5w4K8kGOgAlCajkesI3AgDQIhKEhs0+T3MprzemB/EhpR+vAF2rPS7?=
 =?iso-8859-1?Q?PITycxTx68t5F8RXWey26j3PtE2BMWI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: studio.unibo.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU4PR01MB12163.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab752478-77e8-466f-5d07-08df173d5c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 17:34:01.8640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BreHIYOhcSi+9BtkuNqi7+5iLgHvOyFpsxpGTh7JWKgYufzGVzajjXateQVqWz0BkrgZ1f5pxP0xpbtm7x35BdzrpLxJHoixCzbFwxnHfbaA3M9+H7lWfWDWhcr1dt+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR01MB11033


Hi Andrew,

> The point of the failure is to indicate an assumption in the driver is
> not valid, and we need to examine the assumption.

You are right, and my patch only works around it.

> What does the datasheet for the 88E6193X say about this register? Has
> its meaning changed? Marvell like moving registers around, is it
> somewhere else?

I do not have the datasheet for this chip, so I cannot answer that from doc=
umentation. What I can say from the board: the read of MV88E6XXX_TAI_CLOCK_=
PERIOD in mv88e6xxx_cc_coeff_get() returns 0 at probe on this 88E6193X, bot=
h when the boot loader has reset the switch and when the driver has. The ve=
ndor firmware drives the switch from user space, so I do not know whether i=
t programs this register.

Before I send anything again I will read the register at other points (righ=
t after a hardware reset, before and after the PTP block is enabled) and ch=
eck how the other 6390 family entries in the driver get their TAI period, t=
hen report what I find in this thread. If the period has to be programmed o=
n this family, that is a different patch, and I will drop this one.

Thanks,
Nicolo Giuliani

________________________________________
Da: Andrew Lunn <andrew@lunn.ch>
Inviato: domenica 20 settembre 2026 16:48
A: Nicol=F2 Giuliani - nicolo.giuliani6@studio.unibo.it
Cc: Vladimir Oltean; David S. Miller; Eric Dumazet; Jakub Kicinski; Paolo A=
beni; Richard Cochran; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
Oggetto: Re: [PATCH net] net: dsa: mv88e6xxx: continue without PTP if the T=
AI period is invalid

On Sat, Sep 19, 2026 at 09:52:07PM +0200, Nicolo Giuliani via B4 Relay wrot=
e:
> From: Nicolo Giuliani <nicolo.giuliani6@studio.unibo.it>
>
> Since commit 7e3c18097a70 ("net: dsa: mv88e6xxx: read cycle counter
> period from hardware"), mv88e6xxx_ptp_setup() reads the TAI clock period
> register and fails with -ENODEV if the value is not one of the supported
> periods. mv88e6xxx_setup() propagates the error, so the switch does not
> probe at all, although it is fully usable without PTP. Before that commit
> the register was not read and the probe did not depend on its value.

The point of the failure is to indicate an assumption in the driver is
not valid, and we need to examine the assumption.

>
> The 88E6193X on the Sophos XGS 107w reads 0 in that register, so its
> probe fails with:
>
>   mv88e6xxx ...: unexpected cycle counter period of 0 ps

So the assumption is, all devices have valid values here. So the
correct fix is to refine the assumption. What does the datasheet for
the 88E6193X say about this register? Has its meaning changed? Marvell
like moving registers around, is it somewhere else?

    Andrew

---
pw-bot: cr
