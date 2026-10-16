Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3A54704E;
	Fri, 16 Oct 2026 00:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112147; cv=fail; b=X9wnskdylS49LTX5pv2wXyu4tJlyiqOk3NKFFVsQWNN5kJGsTiHSJ14F1XqVWuqlZvwfid/eAC7PuwO1As9vaC98ie5diDg6/IBQCIm+qY+7RX2L34T1+Qa44f92QcG8gS0+zQV9VUNCQDQjCMT5Szkbdyclxmu4GCmPrsL3+hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112147; c=relaxed/simple;
	bh=aEO/CiodXkWAM/vIvbFr1JLl97ZnSpL48pUmrqDbUcA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YCfn0mrnPekSBqcq/V1OK6EmkUmd13ot6S9O82x027j036+5hw4occahUeXD6tXfhYKNzokHtzHPWIC6lfE9TMZN1AKQvO3PKGKm+7cMMFr48f4f7zaWVPF/Fqz3EQSCVPBzLuvONuShWOQNRrEawcdRmBdFs2yWvwZHksvbUiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=bRF9YbUu; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=OxM5nIDZ; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="bRF9YbUu";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="OxM5nIDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=aEO/CiodXkWAM/vIvbFr1JLl97ZnSpL48pUmrqDbUcA=;
 b=bRF9YbUu8kJ2MZVVEqYtDKXkax9VDgL5Iix9TauX27HT8ONN9r5qPKStOV20FHxRhK+c09boYKMCiaAL17YjOpBg9JMgeLeqq+GkPnClZtKRXu8+cERoRyKFoHrCLNOOZPfG1fnMKDU1Hw9qwv9ifNMeZeDNJ5/Ln+v+vNHdsboQlgOKkkU1KDYWxhyXl2wXM+YS/h+IQ1aCRPnUfN2FibGarrUFlOApcyglQ8D87F+gx4hVF7AMXckvdZbwQzYP1GbaqSp4uFypAlg0K2Gy2tY9CiyVJJkjthK4dBkecQfCm4Qk+A+U8hMqFIZM5EzVnywVFwwjFfz+ROo9U5DXrA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020125.outbound.protection.outlook.com [40.93.198.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BC2B4C0070;
	Fri, 16 Oct 2026 00:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDOR+EJDQ/+d1ZEdIb68NLoJ2sKxwmFuha4M949+f39AANtJIrS9/Qc1vGIEvhQpdyHW3ae4T+8e9lIjfvqzVUIUPEhkVHwdCNUlLfAhgBlFfjFfWBvckDb6FU5JHbR05/3WOANmPyJXsLwt4YzlVHKt6RSyNgN00z9RQO2nVYKtgi5BH6H0z9spYUSMypNN6ryjgu9eAc5fTAUaWX1pIap6oVm42+nJlcqsbzuIV1YG86LZJX/xEvPePWVASRU85x6oY4lKI5kWKKs8L+tc9VeNsuEZIGpR/7Hbg7pab+eDH2ORe4j2H+wwcR7u63JgfUQm/S/2VguHf6C42oquGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEO/CiodXkWAM/vIvbFr1JLl97ZnSpL48pUmrqDbUcA=;
 b=yIFRZINfWE3zskQNz/Bl5yVB04wjka0B940HFKuyxZa+HSP+FMO9/0UtBSTNUlhRSoYfnj91YDfG43kaFRREGSRo0B5lUMhGDuqNqGCEXYqJvILM6EhGF0LLN/cB9vLBvhq0gCkIWvsrF2sJ4Jd3/atutQqO9PUBNF7teAszYT6rYxued72VhLp5U0J+obtunJ0Ibhx/xze5zqosWguRy5MoJeXxfom3Nl1cY4/+KhUugruejPSQbXT5HQiw0/VVxGDPC/6tlFRWs0a9yofRNiarifgPYhkAULc1mZ6Cmi4/oJDSnah1KrSJNN7iyP+UyyTUwJKdFavZ7ed1aX2Fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEO/CiodXkWAM/vIvbFr1JLl97ZnSpL48pUmrqDbUcA=;
 b=OxM5nIDZktJ4Npbi0chFs6wsXgrEyd8HKYzFwHF4UwsoHDiJebmhX7gBcpA0xpCrQif30QfgcTb5rJ5EV65TuJFep/0jfjluGKJ2AVddBCulpsW2OLIZ6DyX8ShxSEJ3hE3R6XrjsaNDG1yDLk+UZVpLvUWcScWjx/zUzF0+doZppFGDovEaY3AzOSKAi55fW2UDGy9/V5zaw+1AsKQXlU7VtINFqVOHLkJKNe0r2xEHWaph/Ycn4wjdOuf4uYt9A4ZboJ+7Ta6wc+0HSOVB1rsF7gqbXrkdidQrFzTruOvWMzluJBCxK02hzht60axaVAGzgD1PYzDuYpE0WK6RfQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:55:43 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:55:43 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 04/12] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Topic: [PATCH net-next v13 04/12] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdW2P/0OEhu8U9dkWPN9oKD82kLLb9o5oAgAG3uoA=
Date: Fri, 16 Oct 2026 00:55:43 +0000
Message-ID: <20261016005541.11374-2-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-5-arouhi@sitime.com> <sashiko-outbox-171991@kernel.org>
In-Reply-To: <sashiko-outbox-171991@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: d16caff0-f7d3-4fdc-cc75-08df2b2034b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|4143699003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info:
 nhPefpM8UVGuT6TLZDJw5di9P6LwO6yX31InnZCVO0xGzH7fJBqD/4vWd1DP8PflX3seRFxTUbdw1esn8qhVgq9FYb25OaQ2D1exLvDCkTnyJKdyJlLX6b521b6rb+XzkhtpL4pQwapwhaLEMXtT1xFrfdkf9Eo/ilv0pUS9EWTK+OUxed1M8Ba81MBh0vo/DTpmMEzT+LUSjyNmYciLJIc+2SB1QcuNvQUy+qe+y8ZfW/QJH4FUuIirIMoz+itJYtY5XaE1CBVxTTfyMyv24epK1uU8g6xEz8GkYl29LREaSwbonHKbC5SfphJu3DwTyMN6b/Du96RUwmkMnwQbcoQLNDY+yXHOFd6q6tslgYyUewEJqvec4KCxMpGaCsjrjYwFBnQGC3EuTEGKNbLu2JBHfcC128x7yqIDTcf3mUQwmmBpOkmuYw8e06jvKUJUJ6h+FaAFK4WJj7NvIbW8oeYM4wEzOpRDblE03UmwU7bqcqr4ZkZAYadV9YiZYTr9qn06zWKjG3XXnlC/JBu9B0ysZ+cWT9zD0rncNx/8aBUdz2Rk2ZPcdPATenY4lfpO/6WsqEGaxPVrpYWvbKDFKP3Cqq4kGSAh2C4SNMAcSwnGnithstjYk2DacuGx3XNdJeroV6aU0rZ1LiOu6sdRLaTuSCa811h9Q56yiuWff7IY2E+9CXM4p4CCdp7HbLhKRwnI/rElQLjeKV48Cd5rUexde4ZAD2nqd5tiZVdcCJg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUpkbzhGU2RrN2prUndKUzZNT2pLVnFib3NkQnVWMG5CYmFjaE91S3NNcnls?=
 =?utf-8?B?eVNTTXdJQVVicDhvMStaNzVqckNyK0lqUU5qcHViem1tZGlPcGgxRlFJbzAv?=
 =?utf-8?B?N0Vtdy9DVC85eWJHR3NQQUt5SU9SSjdYa0NMOG9VMWg4RDBVNnpaU0dTY2ty?=
 =?utf-8?B?RU5kek04RFBCM3dVcnFhdGdlenpKZE1FMlJLZnAxd2VSNWIvSlhpY1Btc2pE?=
 =?utf-8?B?cGZwMSttWURiVUtQVlJlbCtkczhYbnJWSFRta2oyUFUrRUNUbGdtVXlZbEo5?=
 =?utf-8?B?RDlEYmJxSVE5bHdsU2dBU09hNzNoS1pIT2NoQ0kwakhYeWU0MDdwbHErcXVa?=
 =?utf-8?B?SWcxb1E2WUZVTDI5ZlJhS1U4TjU5RG1DOTRpUnp4VnNRdXdBZ1Y5bm44Z1k1?=
 =?utf-8?B?d3RaeU0wWDVzVW40Zy8wa0Z4dXNSQUNjZEllckdQNW91ZEVVaktNdDhEOFJ1?=
 =?utf-8?B?aWhST281SzFWZ1RpMHFlbjlGNTBtTVAyaWcyUnZkYzdXMjlsc2RPaHZyM1pY?=
 =?utf-8?B?RlZ2UEtJNHdLUlNpTlFIeHZYYWhwZk9sdU1SL01kWEVuKzQ5WGdkS2xhY1VR?=
 =?utf-8?B?NWNCQ2piaHQ2aDZRZDhjenRkVExWcThOOGdDU2tMb1c2eVZsSHdYSHQrZU1N?=
 =?utf-8?B?bEJNVi9iNG1ZT0pGdXVGZEV2K1NwNktSVGlSQ3kveE5yUDF0MCtBU2pQK0Zk?=
 =?utf-8?B?WVlaZnF2aGpuQ1ZJbmY3dlZVU0oyTEpzcTZJL2JvZXM0blZkdzBYSjdHM2JM?=
 =?utf-8?B?dThURVdpV1RzRDBObmJubGh4cGlnak9PdHFhS0IyT04ySVNMWXdLN0p5bWs5?=
 =?utf-8?B?VnZVNGlsNlZGQ2xJWVV2dE14Z1FQb0hseXdoa2ptNXl3YnI1dkcycXQwMGRa?=
 =?utf-8?B?OFNMdzNIUnhXVE5WbXBmaHl6UjBidHlCMWtIaExJU3hFcG4vbWJUK2NBRUVs?=
 =?utf-8?B?eWkyZzJlRXVjL3g2WjZzVFkxaGhUei80MytTZGdVVDhxb25pRlVYK3Q2NjBh?=
 =?utf-8?B?cFFvWTduY0kzSGVlTjR6aXVmc1lZMk1xWlE1bzlXcjIrSEt2MHpWdDB0cWti?=
 =?utf-8?B?RnFoWm4rY3A0eDQ1dVdpaExDcng1dDdkanBVcXBQVkRwM09rWUFLblpmN3FY?=
 =?utf-8?B?ajRGd0VscndIcWluME1jditGZjR2amFzYkwvSUhac0pDb1lVSjRvb2JLWi9O?=
 =?utf-8?B?NXpKdENobkZYN1o5RlNld1hhVnRjVzVaYnoyVnBKSmdaam05Z2VsWFpIV0RS?=
 =?utf-8?B?bi9QRy8yL2tpVUlDU00wNkE4NGVYN3VoK2VyNTlZeG1KR1lRcjJNZThoWnFP?=
 =?utf-8?B?K0hrUkdVSU9IK0lENmZMWlkxMTFlakZscmxPUXp0bTQzaUhKODVMaEZuWWJC?=
 =?utf-8?B?VTVNUmlXZ1c1K1N5YVlpN1E5MzR1bDVHV0ZQZ1pRQUo2Qk4yRUx6VnB6TGM3?=
 =?utf-8?B?eVZnbHZ3MUU1bXJXMitjMGJ5Sjcrc2pPcDBXY1h4V2lQOXBkdkpPYWdaT2c4?=
 =?utf-8?B?ZEozYkZ3TFRPU2Q3RHVHcEVURWQ0WEFWRlFhVmg5Z3AybGJiVlpjWUlVSWNU?=
 =?utf-8?B?SkpBc3FrSVlxTW4rdmkwb3pZWkhTajBxMjNUaE41bCs2dm1VVStrRlJFZCs0?=
 =?utf-8?B?NnJPVEVqQk5UUEpVdVowNURjazF2TU5Hak1KckNJZHpxTkplbGZrMktqNFQ1?=
 =?utf-8?B?TjN4Um90djV5SkFXZFErRHlkb3U0U1h1NTZzTEhTdDlCTTBWTFZJUTFCN3Z6?=
 =?utf-8?B?akhDdFMvR0UycnNMZXN5UXB3K3ZNUlc2TllYeVgwMndBMVJ0K0dvS1h0b2pa?=
 =?utf-8?B?NU50WE1oZ1NZeVdYU2NhUXpjSUR4YnEyU0pna1RXSS9vc0pHZ044UWNacnVp?=
 =?utf-8?B?Z0V0Q2tXWm5obmw5M3FycmI2eVFYdDBQN1NCUFoyY01zUlZpY0RtQms2UmdB?=
 =?utf-8?B?cXBGc0F0cTFVY2NEcUhtdU42NmM4Zk1sUTViUW9EcDFjb3g4aW5EV3R4dXEw?=
 =?utf-8?B?aVpXK0x6QjdFdEpNaks0WTQ4TERCQzJlanR2MkV0QkpnOFJ6ZWpKTHBha0l1?=
 =?utf-8?B?VW95cTJaNGRLVVhncVAzNjZsWUtzMm9DTDlwYkVka2pkL3NFQ1hjZFl2THZ1?=
 =?utf-8?B?RS8yRm10b0NMdEJzWEI4RTJEbzh5eEJDVWNUZHNTa1hoL3ZjSUZ2NlNJNERQ?=
 =?utf-8?B?bHFUTTRiWW9URDF5U0xDU1JFdE5aeHNoSEYzKzNtY1lDTWt6QW5kekdFaDZY?=
 =?utf-8?B?Rm5vbm13cmhnaUJPR1JPZjc2dWhZV3luK3kzZmZ3bVRucjFYbXBnYnFETW1y?=
 =?utf-8?Q?qSD8JArclG3tuprEeG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	vDg/J43/RDsnl6PA8iBxGhBsCqBmfOwLN0KVHF9PHUY500RAGkfRVl5irC5ILzKaTHaUUSOn28Y8lvyp5K+uO6QEGfEuvyYV7Jjdd//SWEp4YdAyKzk0+p6Ieq+MWPGd4U/vh4zAoIrS2Y/N6TkZwLUqCv4K60HDGIVJATRPduxsSe10IhYWYKvBv7LOzanydrXRt8D0vcy/BU66dgdOrT478Gn1YtPIMiWirUkJCNBS7//P+5BRuhuQCeAKcJCkXOz0mYHXsj3tayYtPWI1U7Txso397GvFsXn9DFkrCiu48uNvf2jIrxfnz97eUCgP7MIR9SLJVyCHe1qrSyU0RQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d16caff0-f7d3-4fdc-cc75-08df2b2034b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:55:43.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6bcY32PhA5QW650zwI6B3ck8vECB/Ewn4gGTMPp6lXFx5nPCNrNbaPDoFw3NbDlUHDj39bPXc3WZqPMQyo4wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112145-3EbhzlFHNFmo
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112145;3EbhzlFHNFmo;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gV2VkLCAxNCBPY3QgMjAyNiwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToKClJlcGx5
IGlubGluZS4KCj4gPiArICAgICAgICAgICBzaXRkZXYtPnJlZltpbmRleF0uZnJlcSA9IHNpdGRl
di0+eHRhbF9mcmVxOwo+Cj4gW1NldmVyaXR5OiBMb3ddIERvZXMgdGhpcyBjb2RlIGxlYWsgc3Rh
dGUgaWYgYW4gYWxsb2NhdGlvbiBmYWlscwo+IGxhdGVyIGluIHRoZSBmdW5jdGlvbj8gVGhlIGNv
bW1lbnQgbGF0ZXIgaW4gc2l0OTUzMXhfcGluX3Byb3BzX2dldCgpCj4gZXhwbGljaXRseSBzdGF0
ZXMgdGhhdCB0aGUgYWxsb2NhdGlvbiBmb3IgcmFuZ2VzIGlzIHRoZSBsYXN0IHRoaW5nCj4gdGhh
dCBjYW4gZmFpbCwgYW5kIGEgY2FsbCB0aGF0IHJlcG9ydHMgZmFpbHVyZSBtdXN0IG5vdCBsZWF2
ZSB0aGUKPiBkZXZpY2UncyBjYWNoZWQgcmF0ZSBjaGFuZ2VkIGJlaGluZCBpdC4gSG93ZXZlciwg
aWYgdGhlIGFsbG9jYXRpb24KPiBmb3IgcmFuZ2VzIGZhaWxzLCB0aGUgZnVuY3Rpb24gcmV0dXJu
cyAtRU5PTUVNIGFuZCBsZWF2ZXMKPiBzaXRkZXYtPnJlZltpbmRleF0uZnJlcSBwZXJtYW5lbnRs
eSBtb2RpZmllZCBmb3IgdGhlIFhPIHBpbi4gU2hvdWxkCj4gdGhlIHVwZGF0ZSB0byBzaXRkZXYt
PnJlZltpbmRleF0uZnJlcSBiZSBkZWZlcnJlZCB0byB0aGUgZW5kIG9mIHRoZQo+IGZ1bmN0aW9u
IGhlcmUgYXMgd2VsbCwgcmF0aGVyIHRoYW4gZG9pbmcgaXQgZWFybHkgaW4gdGhpcyBibG9jaz8K
ClJpZ2h0LCBhbmQgdjE0IGRlZmVycyBpdC4gIFRoZSBYTyBicmFuY2ggd3JvdGUgdGhlIGNhY2hl
ZCByYXRlIGJlZm9yZQp0aGUgYWxsb2NhdGlvbiB0aGF0IGNhbiBmYWlsLCB3aGljaCBpcyB0aGUg
b25lIHRoaW5nIHRoZSBjb21tZW50CmZ1cnRoZXIgZG93biBzYXlzIG11c3Qgbm90IGhhcHBlbi4K
CnYxNCBkcm9wcyB0aGF0IGFzc2lnbm1lbnQuICBUaGUgWE8gcGluIG5vdyB0YWtlcyB0aGUgc2Ft
ZSBwYXRoIGFzCmV2ZXJ5IG90aGVyIGlucHV0IHBpbjogdGhlIHJhdGUgaXMgc3RvcmVkIGFmdGVy
IHRoZSBhbGxvY2F0aW9uLCBpbiB0aGUKb25lIHBsYWNlIGluIHRoZSBmdW5jdGlvbiB0aGF0IHdy
aXRlcyB0aGUgY2FjaGUuCg==
