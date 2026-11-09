Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794218330;
	b=mBf9bPdR1lvh7G4Cqnq+01ohiVLd1wVcCBatY0jbw+8voMZ9r85DwrQKUNhSQApAcu7R
	 seuQjwMzDSaE2cxp6y/ceYDRZmxd4hrZL2jjjZfRC7DELrHJipk74FFWblgsV5vR3i9Y9
	 pr83yxw7VQ2iG57B5IzAUqjrBFi/2OTztlfIliOgOV31qAkF2+pNcW6YS+6IVc8CW/HhS
	 3GxxVf6EEvbnsNfFl008mJwUGuJr5QL/9rTwVof3xNtVUTWPNpLKTdvSf9isedEJzG5s6
	 8A9zEfNvsdctt/Bf+cE2nrh6l16ytSuK8mbEdtpCmq9ojAkD4S/0ObY5dCqkOBfrH7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218330;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-TM-AS-ERS:
	 X-TMASE-Version:X-TMASE-Result:X-TMASE-MatchedRID:X-TMASE-XGENCLOUD:
	 X-TM-Addin-Auth:X-TM-Addin-ProductCode:X-TM-Deliver-Signature;
	bh=S6viguT2iVjR8CzqiKapf50amq1z7FOmCOdL3HiJQLk=;
	b=j8HczM9p2e9Eo55SLRCKGEml8CjucXfJbKEjPrU7jWLU9MVHRFRVTuD9wlSUcJtORwXo
	 X0GkpuuJhbpKkkuiZvFPOvl1MT6KGuKxdfdfkPW3uHYSrKWYCMcPxvvYDEL1hFgYfJCeI
	 QyNobJYSRkn5/O8O0fC7ZaHKDRyllgdiDI2EeXrFxQuSDoaJ4mkOaCu0zX2BR5edqIry8
	 57z0lblH4GAzypAwakFQ46aIKfxz0Jh2CK4WHloqRW44gJfX+Ax4IhHVkbaJ7qRCEt6iW
	 R16HcrouXzKYy8R5MlE/ekyRaamQJWSYP5u4FWMXyiar3iB7k/T/ecLFbXUR/QCH5eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=electrifex.com;
	spf=pass smtp.mailfrom=electrifex.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.172
Received: from repost.tmes-in.trendmicro.com (repost.tmes-in.trendmicro.com [3.110.59.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5215606EE97
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 09:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5215606EE97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electrifex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrifex.com
Received: from 52.101.227.88_.trendmicro.com (unknown [172.26.79.22])
	by repost.tmes-in.trendmicro.com (Postfix) with SMTP id 94DD0C000109;
	Mon, 09 Nov 2026 09:58:41 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1794218316.825000
X-TM-MAIL-UUID: 2562eb10-deb5-420f-a28f-19264fb24e51
Received: from MA0PR01CU009.outbound.protection.outlook.com (unknown [52.101.227.88])
	by repre.tmes-in.trendmicro.com (Trend Micro Email Security) with ESMTPS id C99E1C000400;
	Mon, 09 Nov 2026 09:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5otzWyjvpZqow5NNppZ3+Lmii7STPhIZ/B9OvjRaSLFjVqfc7+gN2IrM+Y5GAasBkq9ObPU/7GXYhq+E4Qbxr+2OPzsfdKt/XhmodVUtuDa207OYvVmdl/p4bn04axiigenP4UT+O9HZiuQVA4q8nQ+8O8eSR6moVioDR/2MQU+Mw8urQlSaJV20P7hNEUDzjj7A2xwv0MP5rcDl7ZzvnyXmhw4ZzpBXfUMOEXge9Bf41Yw2nTqbCMKVkQuSIYHQg9l5Zg6wj8C9WD84WoYm8DwmJbF8+j0uTwpyu1c/HxrcMevbVxvXbCzfBBth3JsTi4p/hdtEdnGUpJnODQhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6viguT2iVjR8CzqiKapf50amq1z7FOmCOdL3HiJQLk=;
 b=P/mQyod6DON/nMUqNqRKSUA3HmSVzGwuXddKxqrEsCUWddUUs9icIRzR6+r8FC+G0fD55RUPbjnJKqVOuJP0YAD2gi0TErqeSq1NJ/YWSbz4rBAeXAK2Y6a005z7bz3Br+LogcZXiELFFjT71Eu2kf+FY4wYx117mASmnLe3r2R0cWUPQS1L8Nm/BlzhMLmkhRFJPxyMUP6mFtPfYy9JP9DoCV1mZmThx4yDPA3UeutBuA+lHJTlwiryqTQ86hsYZH6xgWh+4sah7vVf83BJzRtFbh0N9jZ7lOXrr+kE3r5oJpfi79TfRespLlOv2X7+cL97p4lV98OWpVZULT6t1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=electrifex.com; dmarc=pass action=none
 header.from=electrifex.com; dkim=pass header.d=electrifex.com; arc=none
Received: from PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2e4::9)
 by MAUPR01MB11602.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 09:58:34 +0000
Received: from PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b5ca:719e:bc57:e90f]) by PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::b5ca:719e:bc57:e90f%3]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 09:58:34 +0000
From: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
To: Thilo Zirnstein <thi.zirnstein@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v1 1/1] net: phylink: keep initial advertising
 settings
Thread-Topic: [PATCH net v1 1/1] net: phylink: keep initial advertising
 settings
Thread-Index: AQHdcC8hUeQ9ey3ymk+M2/EC6CM42A==
Date: Mon, 9 Nov 2026 09:58:33 +0000
Message-ID:
 <PNYPR01MB1144420346F647D64C23775D2FD732@PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=electrifex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PNYPR01MB11444:EE_|MAUPR01MB11602:EE_
x-ms-office365-filtering-correlation-id: a3ed9f70-8a6e-49c3-f2c3-08df3e48044d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|10067099003|38070700021|261026121527099003|261022075727099003|56012099006|261009223027099003;
x-microsoft-antispam-message-info:
 kk7HoLhu+ij9Go9kT8IuLUCGZvckWfdfY+VdZnczIBXRj8H0cziHx7rUSxPdmE23ym/fW3z6JnBYYPc9+RrHGUg06+fhySA60CcSYUO8iocWDR9iwaFfMuK1xLnf5OG63RbrlH4wtlvO9+Svoi5fp3BXgQCTGpQTvR8qLV1NVnsT2W8EDpqWfDAHKEPB7fqrq6s/udXQmMGd6XE5sm5zNZtXGq3R0ZFLQANLq9J4fpHkoBA/h2iqjM5iR022EaPikdC3364LVbgeUrtMM9g5b8bMd6OF0EfTR+dvWUhogR5qwTOl4xN9dKcxABxsBqaoSEub1u4ppWeqCI4n3lfPGGJDnmMyxOGhFRN7+0OXG73W1mxLI8r9Pboq7FyiFGLcgIozrCVkuEi27pVmNqPpxURMIP4MmDpgSYUYjUZAtxxVs9PcR5a44+akLfUZyGZqSZZ38nIyw/QQActjHZzY3CsxoViOXi6RYeUbabSQHqeJj+M23cdX+SkUU7ORnzztuvtUZDVWoCkLLtqP91xBb98cyXZdhLs7TcEQgB1oRzrKIpgz5WXXZUvFaRVeXNmISPixEjhZx3yAKza4CN+eyWyr6D2i3UBloWT7odeNupg4WuJ1wux4TOBzhtd0Bm8DMvpzmcIGNUQMfzZP16CPPDs+aZEzX5mtmHvaUFsSa9vWxuVvbL2TK+B8Yico4pK+PddKQBRwOIepRD0+km81SH7dI/8Zwn2H4DCn1J4kzEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(10067099003)(38070700021)(261026121527099003)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0IvmjHycUb66clqV0lT1Hej7hioomCzTo+IRIC8efQ+V7Dn8HnD8Z4hQHd?=
 =?iso-8859-1?Q?hQ67xpU4Qk7fEbLBiDAJdjEV4xXNPCtoqHjZCwLWVIqrV0UaMDNhWLn4q6?=
 =?iso-8859-1?Q?PV+xPCW97S/s1Goj3eHtMJvsMGSbHloOoynuTj/cMQtByk6KB8BbXHOU9H?=
 =?iso-8859-1?Q?UMEtUP4rBHUz8nCW7GT+2Fuc/anFnYfE5GtfaMjkr98GNFHqe9SqkVXLhg?=
 =?iso-8859-1?Q?thUPwTLJZSFwTvWqROQicNs3Q+CCpTp14Adh6wNr9lCFxJ22coUBM5q2Af?=
 =?iso-8859-1?Q?j4Kbk9KyiMk6T//QWNpyktHIprj7p5XAVb3BqlowXRjLj1r/ao/UoOIZyl?=
 =?iso-8859-1?Q?dhyBVw6gc9h2Q/0jB7utoM++QCv1rhN2IrQ8Om4QavXJTEgWa9NVkIHA1V?=
 =?iso-8859-1?Q?0e25C7oSmTlhwvUfL+UHj5FEJJHG5Hx0yAsOkMG73x7rEcChjdZe+dqUy/?=
 =?iso-8859-1?Q?OFLHHHlgVVPB/F1w19PSh6dnujH0HDtuYVSGQni/WUyQd/UHetnen7gW3y?=
 =?iso-8859-1?Q?kzo/j1xMhcv4hLZ0Uc1PfLtg2JH0Fqg9GEUm0jQ1aaTy6Nssxu5XIR9Kjg?=
 =?iso-8859-1?Q?8zrzrmKn1oijdyW+gPRGbPckQMllHhXgmpjWYHO+luKz6XsUc18Zu3xP0G?=
 =?iso-8859-1?Q?O/x5htB3jnB727h2N6nLo0+95UAQx/hyTGskJrRD9B/jd+9EWS4Zh9JmIu?=
 =?iso-8859-1?Q?SJ/5bFo0/ce6ESQiK234OEeYW94/wIC4yTFvnPI1q83Qdwe/ZjzxN44+if?=
 =?iso-8859-1?Q?zaWizObydLllnfAOkZLESOYbcMDadwyK/yQWRikg8FYKN+Q6mLrOk7nk5q?=
 =?iso-8859-1?Q?TqU531HS2uY6SxAroqCsVfrZyEAX1CPpZiUIjdLWAgk/OMA2zKnQOGrsrU?=
 =?iso-8859-1?Q?WVv7rXNS/xLkL3q3HLStn+ivKfK3G6ZE/3yiMwlq4XRULUGrQy3X/+4Gbq?=
 =?iso-8859-1?Q?JkKBsaOWP5Bzuv7NB3So7zElOUka80NDVxX1GbATCEBzIFC4zQFq2ex6Qg?=
 =?iso-8859-1?Q?c/2ME/QDUc7nRIQK5oan+4wrqMVhOjAK5yd5O/6wrz0AdLxPLE8RJxdn3k?=
 =?iso-8859-1?Q?/qY/IuU1u0T7713hUuj9m4TbkB/C0VpQryOByhNqQ5ySyDmk/rH5yOkcP+?=
 =?iso-8859-1?Q?09OZSH5MPqkVmiNb9lNdRgtxdgxuzyTZkJAy9B2+x09z/a3i5GfzEd+l9s?=
 =?iso-8859-1?Q?VF5VzbGrZN/95qO047r8FDo7fusLtNSPuv+TrlB5q8Mw9XF+uIl/bnG++o?=
 =?iso-8859-1?Q?+4nn8IQe6NuuHBmK7ygFE0xOtEHuygHpbW0q89Go7uYYt9I376ZU0UAjHa?=
 =?iso-8859-1?Q?snyfjSWM3xXs9Z83gYji3S9FLlPIlBlfY/2QbjUlbfvHxlhKRWZuI//kSs?=
 =?iso-8859-1?Q?A8ngfnHPj1zvZNqzxCbenrxBMomJbyKlQgxotloxAYI3izwQ8nNZguwElJ?=
 =?iso-8859-1?Q?yinU2Xxm4Kmepfyz/3H6pQRGSAHmVkZtxGWFDnY9IbcRrEhR5HI7CYE88Z?=
 =?iso-8859-1?Q?cjCqHu5JvpNj9Jdcqsd76sHXt9p2zjUX/qQAe0i5ct0yrogjAIov1o026Q?=
 =?iso-8859-1?Q?Ek7WYBNiRqu8VdFaSSq/GnRfWOpbaJ3UZj/2VI/51UWaTLk3FOVd0xSSSE?=
 =?iso-8859-1?Q?29II+C4sfJNC6b1xDC9S/YNVdRvvHyhKqAJcQ3ILAvPjBtn70uR31febI5?=
 =?iso-8859-1?Q?3o0lWsMFJd5JsO+bRJG4MVNA/aIPGN6TOsEWIzPe5kE7HgYrvUp+pL6P7F?=
 =?iso-8859-1?Q?sF1ELuG5w/Ril/BiCO7ry5UmuKvs38bC4Ub6okFScjPrmKydlHXr2WIP4i?=
 =?iso-8859-1?Q?/ANMg/FXv3okezGqm0Ma5a6Z93ED4V8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-Exchange-RoutingPolicyChecked:
	EHSxYLEpdYL8Df/cfYYfCBAIEGhaLK8g4QmNGELKdZZcqoW/bihlfD/IfO8aQrUEl5TdUAFBv05s1t9GlPj/9aVpwzDj8/doCtUKimJxSww+k0zDO2kU8yFCQiT3ZePMez2qLNodYsQmVsnzxDZ7K2b/vQb1/9kWX3+MttFPmBq1lrLkuNM0XuD9XnuX2Pr7pIdGfIyofGtD63+K14ipt8RV6emLz2gpjHSc1kIzhmXNIEDKMTfIHOh7DmON2YNR0NPIJ1JDTG6bR7HBjm9DygxY52jZf6ssAQJbQIsyLfL34+csiI6eJPkyydjC21xXRfVH5PCkxBhEowuenq+FdA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nevd4YcmHLGTMArGLwVDbKLrY1rih7XUOQH7zICs8FS1bP4aS89kUodJ/5YOdwf6J8EorFIhCC9651dQ5QcpmT7yMIC1W/er0xAV4OcRLvsiQ1bvDXe3d9O9+gJDHTw1FHTL1TN9fdEhbensGbHNnpSRSG/8WNenNdg/Ll+TipPzuZScxOxyB9R+zXsIBUT1H8g/13tuPuQ/L9gvClGVT7riY3SiTaFblB+hLwzv8apNfl0ctOxCfDSjF//kS7knPCEf2gJrvPUiCAJOAzbeIJuOLbbPDpXrIHZcAuIXQPDsmcHnQuWEEIA0meN6s5IaZy+7asS9O47MSg0Nd8N1zY3u7rxOVnHAgcwNZZj74C3fStdNxYtdV4NksCeR8D/Fe5HB9+pylU8GpB5Qu2eibRjywoy3u5/4L1seWhN2iZ9eM6dcm7UWQT6/V+jq3SqyqltuL1Uc8AMBP0p/Pw4EkjgKH463PdjI00Uz96nRZjjoH2rhHsoWDmB9/O5J45Sd9XLY7R50CDlv+krvCUVSxzsSD2IIWqIj5UQvdI+QFk6FB9gJbvW1a9S3iZVkLsoq3Bq76BDnHqfQh4IXUI9CWRbAO6YYIRgdOFFSgkFBPjg=
X-OriginatorOrg: electrifex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ed9f70-8a6e-49c3-f2c3-08df3e48044d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 09:58:33.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f2626450-e675-4872-bae6-db17376f7643
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYdoY1jl/nw5ucQNV0kTRSRNOdCAXYLT1hHUnIL0VHMU7fxCv+zN/TJnHf/OSeVNj5oUXQlqjKfnlcvnXQvmNcuv8kR9JpAu+81JI/LPB4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB11602
X-TM-AS-ERS: 52.101.227.88-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30308.006
X-TMASE-Result: 10--19.507500-7.000000
X-TMASE-MatchedRID: oTBA/+sdKaaEmpKn97lgFU/r2dwKUEWnvokUuaCKnfVPf1fwH5k1uw2J
	SRqdWmN4SJqIey5Slrm9+h/ihlMCmtFt5Ts1+uT6oXieF+7O0ppR3UkpERYmZK3hlzDKLny5a2G
	3QSaayYzG+qFYTpe1rhyHG6hcCoyDBGz25vXAHoRlR9QcDYtqLG7LP1mg3g7ZpzpRNQw+t5HRVa
	CKvzOY2+Sazff4fhF1SO5SKxwRGEEPm15xyht8leM+sx6lVvqCVj8ed+k2TEAp455z5BQf9NvIA
	MT/07OiOvT30G5nOJt+3BndfXUhXQ==
X-TMASE-XGENCLOUD: 60ebb322-e597-4dd0-bcfc-eee2b2086275-0-0-200-0
X-TM-Addin-Auth: pulDwqzchR6nNoYEc8sffykZIiXRAKlUml2hmKEWVZ6eQaYuca+pixjnMp1
	/sxiKGMlSZYzeQVjAB705NJ9/7maHqsOzzKgQ37GYipG/q6H1Cr1ew9eYxdfy0Ho+niYxKL/lRx
	X15v5sNoyOmsSOs3pnGWYEB28fQ6oiac8R0u3XvYu4FWpU3aejSWzrlqGSN2Kl7mtskfG3Jg0XA
	sGdMJQO34bJY7fOQZlbKD/gUo2ixPkTRZighJ1KefGYtpkd8rHvS3CqlTJT2RbqYItUdAcmuAea
	8/lW+RSG9rMQ95th/EN9iX+EGVkFpwJxjzdx4NciOrEqkjWe8P24NQD6eA==.HeR2H4qZVdFSP4
	YSdJKsPmi3ZGkU7+kGg++bgLJpBEgOnY6X4lMneQWLMTg2qu5sQ45zytSx+f1y8BkDZQ3vdS3D6
	k+DetUBUZ7m8YZHzflFqfbMDDdtzTXkR08Nc+QKZeoJwGMuyiHe4OjpZ+CDM1iquaAXSXrBENS7
	IvJyENR/8NNa6FERtZWDKoPe85nRyI7WYmFn5uEnXD15i1r8cl5QquKe674EMAK/ibQquLlj/Cn
	45Ulq7du8gerksT9EdGsuJr0+RKEbVZm5l/PGYDw0sOck/5cKuQHeMkAbWf1tWHqFPsYdlixxSO
	sktff8j2t/0QPAIbQpJio+B2GDHg==
X-TM-Addin-ProductCode: EMS
X-TM-Deliver-Signature: 9755D35173AE913EB555E23AC0A98944

On Wed, Nov 04, 2026 at 01:55:09PM +0100, Thilo Zirnstein wrote:=0A=
> Connecting the phy while ndo_open callback seems to be a common pattern,=
=0A=
> affected drivers are:=0A=
>=0A=
> * macb=0A=
> * r8169=0A=
> * stmmac=0A=
> * tn40xx=0A=
=0A=
Hi Thilo,=0A=
=0A=
Results from an ADSP-SC598 board (stmmac, RGMII, TI DP83867 PHY) with=0A=
a 6.18-based kernel, with and without this patch.=0A=
=0A=
1. The case in the commit message is fixed, with both the dp83867 and=0A=
   the generic PHY driver:=0A=
=0A=
     ip link set eth0 down=0A=
     ethtool -s eth0 speed 100 duplex full autoneg on=0A=
     ip link set eth0 up=0A=
=0A=
   Without the patch the link comes up at 1000 Mb/s; with it, at=0A=
   100 Mb/s.=0A=
=0A=
2. In that same case the pause bits are lost: with the patch the link=0A=
   comes up with flow control off; without it, pause stays on. Same=0A=
   with both PHY drivers. While the interface is down, ethtool shows=0A=
   no advertised modes and no pause, before and after the=0A=
   "ethtool -s" (phylink_ethtool_ksettings_get() reports none when no=0A=
   PHY is attached), and the AND then drops the pause bits the PHY=0A=
   advertises.=0A=
=0A=
3. Sashiko's sequences (a) and (b) both reproduce with the dp83867=0A=
   driver:=0A=
=0A=
   (a) advertise 100baseT/Full while up, ifdown/ifup: 100 Mb/s.=0A=
       advertise 10/100/1000baseT/Full while up: 1000 Mb/s.=0A=
       ifdown/ifup: back to 100 Mb/s, advertising only 100baseT/Full.=0A=
=0A=
   (b) continuing, advertise 1000baseT/Full while up: 1000 Mb/s.=0A=
       ifdown/ifup: "Advertised link modes: Not reported", and the=0A=
       link stays down (NO-CARRIER).=0A=
=0A=
   Without the patch, both keep the last setting: (a) comes back at=0A=
   1000 Mb/s, and (b) at 1000 Mb/s with 1000baseT/Full advertised.=0A=
=0A=
Happy to test a v2 on this board.=0A=
