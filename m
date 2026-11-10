Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342399;
	b=b7Y7M2DkDFjHOuMuXrEacxy2Kaxm7h9DYzZUbX+RS6YrJGuxaEqixNZju4fAzvKJyQk0
	 LqYWOPlg9D+EygIdukl4nyLTQ5KJVOq4PqL1QHf6C+ZnV6YTe1VJ7L1Ygn+nD18I+FEJD
	 juD3es5Sy+QEQMgvXebL+ml3Xq8IrMSTYmlkuE0uSo2d7i0TW1UFQwuKzCgQro7jsW/12
	 33BjbcNq6wPEqtV4fCOluq2rmov/eAtZEClhem2rcjVX7/YGhXs4NpxXMNh47eL9lVypH
	 HRgsk4H3yltygUIxMspOiQ1KLApJcPpxvMCr0iJQlu79pHmeCgo2/ZHuNbmSVbodKRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342399;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MDID:X-PPE-STACK:
	 X-MDID-O:X-PPE-TRUSTED;
	bh=oCeLEivRcrsoeIbFfoCe65ZzKIc26aQMVP7U7MBf2fw=;
	b=BKJaVQ5XxeM1YHKj72QgC7pzYONUOKFHyFGS64OkrHQ+aUoA0EbGEcoFchwzDIOAnJyV
	 iHYWtCjJpSMKzx47AqhGekSk2VHlg4SimXI69MhVH3T/X6hcraqW/1UQzz3iHJ4gYWUxl
	 SN6NAFTUMGWJEjjxJP1LT5cHYXwoaRVLRfty6+DUw27HlzZiaWI9k9UZkiHNT+VSG6sdT
	 qfOHVu9O0+ocayzVrqEB0FvHJoSmlbWDJLltFy97aw4E1XzpS3uiOAuzNXu6QMYOIjVNe
	 6inpcB46zbeYmMyM56SFEEbR3WOTHtbxuAuHGmyBcZCzUbmqsMxL0GY+CG3GWFJv+0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b="D/PteOrf";
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=ZkD4IoRR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.154.164
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AB60A5BDE;
	Tue, 10 Nov 2026 20:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A02AB60A5BDE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=D/PteOrf;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=ZkD4IoRR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=oCeLEivRcrsoeIbFfoCe65ZzKIc26aQMVP7U7MBf2fw=;
 b=D/PteOrfXzHYhHLQDGZwuv6q9GzkuamFWXVk/YLf6GKfPz29JvH11NGh6Xz+y7Ebqew3CxRdpEdF+dTlmURY0RYKJLfQecG4YVu8cIpnR7XOwXQsxvluiNxR7/jmUZ9kCBXx0D+djgFpPAeClsp1yu6Sp8vPy99gRNAk6jOuoz+ffEg976VCZPS2FegPaiMPe2l7NIfUfZR0H1wVKYcikrgJoLUg8XmIpxnwboYAW4eilKfn1W5c80ZhRVkzZ1vwlO4NoqizCx4P4qSNMYDyDbBiIxvpoNgHPslyJK2eb5f/2FQ7CKUBqgweM3KgZsl4sQPsK4QPXJk0nIhRbIL/eg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023085.outbound.protection.outlook.com [40.107.201.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EC5DE3C006B;
	Tue, 10 Nov 2026 20:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMb+ggN9Ia4J5K8M/aIPSOxpgh3JYgV/GM8BQd4uCu0O82QdeAsuCWCfcNhqIkpQdeGYRbQf5gVJIaXAAhBqC5EH0lg+x7o2jn4yjNChiFtQRDfYZUoJ+Athod7QVQnI/VqmBEs309nWsrLaRlrK109VKIXD+iajnPJy/hV4HT2UjU5aWcabA3zBZz42YWIsVJQLgXYINb4iGzkCvgsjWBva7DlF8ybzIiOvOiU2lsyiLuO052GqNAPVkosBlQnsIBiTGJVpGTEhCMdZmPNIfyt+XscghmjT7RqvIQhPF5CqO+iRbSZCDbpLR7U6El58RKVRahfQSQARFPFCpU0FiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCeLEivRcrsoeIbFfoCe65ZzKIc26aQMVP7U7MBf2fw=;
 b=VPH/oEiskyUzEUHYQF42B12QOqL6jPkV3DmCXHTgXTKzLTCnwZKtiC1cwXsVadSb5pjkVWrkjlC69I3/nJUYHZdFPD3E7pDkey8CaR5mSu6o9I1yE0PP9b0QDmjAEQzqvS20W7Jsfkrply4KJJdWzmM5uFA/bIyeTlIjnjXGZdM6gN3IKuqN/zt7nJKJbv1aTORBzvfxR0I5i+aC7CgHBa+CABbpPiJszbFFtsvhUtaxl37lSzntgWbcGQSjoiu1XlIE6BjA+MuFimd8NFnO88hqXT0ktUViJYQ5QlTIrX5ARMB/5loTqir0FSAbXXn8OxRGpeG1I85HHg3ELaQotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCeLEivRcrsoeIbFfoCe65ZzKIc26aQMVP7U7MBf2fw=;
 b=ZkD4IoRRsZK8+vyQGz8aFZh9LkoINguGNeYKy0O4JdT3nur5BKqjKZWqkckxMdLrDWTkuFweGKpYKRwNidem9cmuWSraUkdn+vdL8IdgXe4QCDVslHPr2ct1jJqkT0n9QgNmhYBY0A8+8KQzRmTIrl3h4P6FINbC8rvYwBd92+0tI1gdkK123ut7iDljV7avGF9NqBbRXxepMYyOLp3T4+zIYz7N7BmPT+oFEI5jLRiBvDPPtV6hC4Jo5xbM8DnV3jyU6hQ+ivK5YLp22D+sMDvN2E0hn6kaOGrSqXvMXT+YzMiEpEq33D9x/J/1S2GUM4F2j8866TRI4d1NhXee/g==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:10 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:10 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v15 01/13] dpll: omit pin phase attributes the driver
 has no value for
Thread-Topic: [PATCH net-next v15 01/13] dpll: omit pin phase attributes the
 driver has no value for
Thread-Index: AQHdcVG4rpCqv+y1wUaqsUhtvrCr3w==
Date: Tue, 10 Nov 2026 20:26:09 +0000
Message-ID: <20261110202607.55744-2-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH3PR20MB5745:EE_
x-ms-office365-filtering-correlation-id: b1fd0d0f-1681-44e4-cd29-08df3f68db8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003|261021121427099003|261028144727099003|261021123027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info:
 +KKNiCjWErjO8POEdeEBN0DtVpuz7PUh2w2mKvpE84hI2uhsMkKJOT3km9CIPD3ziZ860Vc9x0Qkg0YIRNtuYmQzugz4QxdrHjlyQxSf7crgN+d0lu0FK3We6qqjR0NxYxP/YBq3kVS9Hdoejr/s7Q9gPb0OwCuRo4BhO0chqhP3m5e6DRI6nk972iEhmyEEtF03Fy9serdJ5ZNo8cxlLOq8WAOoVEAKs4RsDNFGmOalC5cAD7dtOXwyh+HeQ4Hwb0UBMbjtztvWMZtq0OpcMWL2YhHXrHjwqZ8ZK7aFrTm+icIsLNxkOZkPsRgjcIogSZIW+hINmjFQTdgjEi/VqN3/JdU174lwR0JLPhdRb518Hacj8dPIejMpmfQ+CeXorw6jrF4U6Ov10nS7OfC2hSgeYyqMuAbaCrX0xu/UoeXYGLP9Nl9pJMBS7M8tnri4qIBlmjX8iG8jBy2eIzOMPqMK1o2qIE3yfeWbbLcUZ96bbcR9eaRN+oFfIli1r7X8XvxDsuuA2P8bLTlPAMqOOY9jyOLpcMCx2XHGMlyFfpZklC0in7CXh6bATWvF5AAZYCjFCI6mVcq7mdGlw71XGw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261021123027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?pSkaK6pQE1ITxNWeK0Do70GupNqfl7pd3r7KAqG4OeQaCScI2ouFOp7AdQ?=
 =?iso-8859-1?Q?MbR1Pdsd5xZPWNo2pUAqQNLaw1CLORKbyQ7KyTS6R9hRQxFGnd8qWi5zea?=
 =?iso-8859-1?Q?gRZSV7o0p4mAVPA/phj9aQ+Cte8JIK4eb4j24kg8wzb2ZaQrZy8+Kvpfl3?=
 =?iso-8859-1?Q?0jxwaI2007IKPzSvlz7kTcLZCMG5sK3WPZJHt3+3NcB6lDXqdSHEdJxxTl?=
 =?iso-8859-1?Q?tBJCXUlzoWNNaJcuJtiX2D8QQGzedtRwJL0AJahn1Ji+WUayc68sTeBcid?=
 =?iso-8859-1?Q?djnZ8RZ1GIhuC5sqNUwP5HxR+pVj+RM4HTeOHCgqONlovVlkiuEBx6he4I?=
 =?iso-8859-1?Q?dk77X19oMMqUvZnHH+llkTQ3vWOMNbLCPFIqBHvN8vyh9cDTrxv3dNOLkS?=
 =?iso-8859-1?Q?0TB30Lz4BxpsFukcxXutz0x0dP8vyqZMv9/iw7twee9Gwb+L/8lIDCvhht?=
 =?iso-8859-1?Q?kySCifKD+ShHWmtwGmm/beAv3TauhUlsaw7xJ0gJkSwwbwmQo+JNResHSJ?=
 =?iso-8859-1?Q?zLxRtiw28xHeOLKdOnYgaRqqWKRu5tpC4cTQo7eriO6ZFzlhVsNQGril0R?=
 =?iso-8859-1?Q?+EadsWEX6j8HMlLQ6yMoIPdQGpjV2KYSYqXo5n6iIJ8kkkQErsk+680x2E?=
 =?iso-8859-1?Q?8lviPA5mrJWv6qfV/p/N93XJW8BmDh8NC4kkIJoBU1X3+vljfCkZRtUCKz?=
 =?iso-8859-1?Q?son6+2MEXr8YAVvmaCja05C99O6vZCcfp7udZmsOskwa0DiWliN7/F3K56?=
 =?iso-8859-1?Q?Kk2zFgQbg+QXtC+WRfYFvhBIjz90etumgOfwh04ldmMWNA8cttULEhP0+h?=
 =?iso-8859-1?Q?8d/w2BNCDT3FTLzS6DNop39Q5Paz2/iAul9b2lBI/nCzDl0ENOWK3ShmLO?=
 =?iso-8859-1?Q?5tp1vPDRCUeNXEJficv6HIsNn+/XoKSfOQ/d3nQZxYCbk5ZvNRxp12IC0i?=
 =?iso-8859-1?Q?/2ciMEB+LzAfj2e28dUQnPYMBSM4yhch188Hp6Exva8HFDyvqahhY/8yKU?=
 =?iso-8859-1?Q?5T/6o6Ww3W4jf4oLqGCN9Jhw6s2k6YjhXevu6J03IPkXwXVbAAjn1VJA2e?=
 =?iso-8859-1?Q?wb5lEwQqFd3xMw9HSF0XKwc/Ig1mnogXbOocZWFT62Rn7KasVeKwtXWyrB?=
 =?iso-8859-1?Q?87baXp3zM3TpsTKl7hQeaG0lfyuAUEa0mGO8B5AXrwXIUAJi/wZJBE57w8?=
 =?iso-8859-1?Q?+094sex+oEi6BUyuU0j4dVNKm0OF7Kj+P7ucgHPKW6NZEQMCVNZqSEGv/i?=
 =?iso-8859-1?Q?jmAGY868P9rOaHP9R7zKyjTFegpMp16I7LBQT4Uc9UZvTLuoSV58LjntNB?=
 =?iso-8859-1?Q?kspJOwxa5fbZOK22qrALoP/RtbRRpB+MfUWLMehARpVgtYqpwoAEsCq+Pl?=
 =?iso-8859-1?Q?6qt3jgV0Ghr33mGQ4My/JVuy0yOK2ayu1cU1+ZKW1I9AzrtRRbZjSgyhC7?=
 =?iso-8859-1?Q?PIR/St5bfejtn73pifigtEsvbnFfGhjzwJKACVTPxdcy2vGjy4Pz1fhMJA?=
 =?iso-8859-1?Q?mHD33celOdKqphoBna3RBAT3Mb6uqsT/54bsWg2TPvd4xh16F4XL6eQQM0?=
 =?iso-8859-1?Q?RoWfufjHZd/uQa0YRLWPoILOIMFvoM/y1epxd4K98NdElcwj7yQ2nKVBh7?=
 =?iso-8859-1?Q?hpJKdc1rEx6wObyMHXhjNenS3BKr/7O8Tv9iyGCopMYw2rVQ3fGYd+VZpL?=
 =?iso-8859-1?Q?dGg0Awupg2ApITOX84KYd0KOjXftYQlgQi2sBgihQ//4FfsRofkSclTDb2?=
 =?iso-8859-1?Q?m4jxXmWgQvjnquJBMPOv6tX/yZPZofUMwL6ovKAQuWOgx2?=
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
	hp0A7AQMVoWhgHQaobdUjZXiiZoqZPvWZj7QLyzsBAana1ar1ueZk5qqUswUFjR0dcjZsqTGpb7AGIlls1RDxJ8MfQG67KlVRtTPXI8cUcHFdbulqAqWgStWYfsmpa0+nRkdip9DupfrSX1muRxb8m+Ig2CdKnL7tco2EsY0sttZwK495IXPoO2NPxF7zJ7xnzF7kgy9bV7Wl0JSanzJ12zRk4ru1PEn7NJmTYilgjDN2Q4W4udtvFbe+sBeYMC7kd/zL7zdrwVi70gqiSEmVANGt/RCHcG6D7NWDRxtQChYZoarE0sga74Nus0RsManFXqMDWNGimzKb/vjIzOshw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fd0d0f-1681-44e4-cd29-08df3f68db8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:09.9412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtcoxGxmiWbkc/Pkg0lKOHkha1gn1IdCOpxp/kp0hO2uxNdaQ3maWG3EMScMMg59ud0UaKJHtEuNrhd7xiETKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342391-451eY3fYpZ00
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1794342391;451eY3fYpZ00;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Let phase_offset_get and phase_adjust_get return -ENODATA for a pin the=0A=
driver has no value for, and leave DPLL_A_PIN_PHASE_OFFSET and=0A=
DPLL_A_PIN_PHASE_ADJUST out of the message in that case, as=0A=
dpll_msg_add_ffo() already does for the fractional frequency offset.=0A=
Today any error from either callback fails the whole pin dump.=0A=
=0A=
A driver that measures the phase offset only on the input its PLL=0A=
tracks, or whose part holds a delay larger than the s32 the adjust=0A=
attribute carries, has no value to report for the pin, and a zero=0A=
cannot be told from a measurement.  A phase adjust request on such a=0A=
pin is passed to the driver without the comparison against the old=0A=
value, so the delay can still be set or cleared.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/dpll_netlink.c | 14 ++++++++++----=0A=
 1 file changed, 10 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c=0A=
index e5380d95f238..acf71a93f230 100644=0A=
--- a/drivers/dpll/dpll_netlink.c=0A=
+++ b/drivers/dpll/dpll_netlink.c=0A=
@@ -388,8 +388,11 @@ dpll_msg_add_pin_phase_adjust(struct sk_buff *msg, str=
uct dpll_pin *pin,=0A=
 	ret =3D ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),=0A=
 				    dpll, dpll_priv(dpll),=0A=
 				    &phase_adjust, extack);=0A=
-	if (ret)=0A=
+	if (ret) {=0A=
+		if (ret =3D=3D -ENODATA)=0A=
+			return 0;=0A=
 		return ret;=0A=
+	}=0A=
 	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST, phase_adjust))=0A=
 		return -EMSGSIZE;=0A=
 =0A=
@@ -411,8 +414,11 @@ dpll_msg_add_phase_offset(struct sk_buff *msg, struct =
dpll_pin *pin,=0A=
 	ret =3D ops->phase_offset_get(pin, dpll_pin_on_dpll_priv(dpll, pin),=0A=
 				    dpll, dpll_priv(dpll), &phase_offset,=0A=
 				    extack);=0A=
-	if (ret)=0A=
+	if (ret) {=0A=
+		if (ret =3D=3D -ENODATA)=0A=
+			return 0;=0A=
 		return ret;=0A=
+	}=0A=
 	if (nla_put_64bit(msg, DPLL_A_PIN_PHASE_OFFSET, sizeof(phase_offset),=0A=
 			  &phase_offset, DPLL_A_PIN_PAD))=0A=
 		return -EMSGSIZE;=0A=
@@ -1452,11 +1458,11 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct=
 nlattr *phase_adj_attr,=0A=
 	ret =3D ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),=0A=
 				    dpll, dpll_priv(dpll), &old_phase_adj,=0A=
 				    extack);=0A=
-	if (ret) {=0A=
+	if (ret && ret !=3D -ENODATA) {=0A=
 		NL_SET_ERR_MSG(extack, "unable to get old phase adjust value");=0A=
 		return ret;=0A=
 	}=0A=
-	if (phase_adj =3D=3D old_phase_adj)=0A=
+	if (!ret && phase_adj =3D=3D old_phase_adj)=0A=
 		return 0;=0A=
 =0A=
 	ret =3D ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll, pin),=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
