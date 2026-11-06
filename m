Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793956803;
	b=XhCSnZwuVlRCQKAfyLu0Lps0ssIoToM+LXPNeU/bJk9tV1cCL4WHzM+MMTrsAobQmFbc
	 iZQjNovE3HSwsljP5LbsFm5XcZ/ixdpYKk0h9/6701K7eU3DdvX7fH+s4yH2B4mjFukg7
	 5BFz6/GD3rtOziCSPrTrfZrcVehbtcDFVbIP8/Td1IVvBIkO/EUXD5osoaj+v2TS/rT/G
	 qsAt+3uWi7lyZ2QXpCh2RbL2bOUtQqvBcQRIEJfFMsrFfrP175snPgn+1Ns7lvbC21kAR
	 5gv1l4Nqs9rzZXNsnF/5a0BTPS0qmd04UI/FFhNhinJ4MZg7TepP3/s97RE9NsO06Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956803;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-exchange-messagesentrepresentingtype:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-sharedmailbox-routingagent-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=D9XdajvFO6tAl8xfgibKdqUh65XFW5zZpKzSiWGedjQ=;
	b=gw5ctQJ1s+zmm84l815YQQtIcS4b4Zsgl2TWtgCD/i8/yszfKOoJQRiLNQQW5hn5T7W5
	 /IKUL6EZKgZ7EewnudQiDpJyUMt5MB8zIPQJfaO/3RXFKc4WATKjokXUV+VAovcpF54/x
	 7CDG59bFc2uc8QIAfYxsnyqKdZQG5kiF3Mo957PJMfJ2arGeqdTpWf3oU7QLheR1EZj/S
	 TQmYzeCshAERCK4a3AHtTTIbH6P4w9MLQA4Q1E8I4i3E5nVUFKy6wlWz2bfsR1PZ9XmKJ
	 HxIx2p9UlJL2mjQTHVWbhTdOKiY0mYlhQj6MUnQ2bq57gKjq/1aNfkP6SebJeRovsew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JUYz+4NE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.3
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D7606D805;
	Fri,  6 Nov 2026 09:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 599D7606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JUYz+4NE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StSDKL1GMR7LKgrfwfcnAIc/zgzFVsFqQAVulIt0Kg6fPD7htrZKg94y9NvOPRbDso2Wot/n0582Y+5m9EoUztdHaruRZ96v3yMR9UnBk7+a8f0sWeWorCU5cYOrs92wwzWG25VI5a1YP2GxQPLpEhEMAOnHibLvc7KYA3svdmyQSVt3FXqgf09yGulb52no06c3NM1qpua2PJYgoOaQP26Z5ogrksLCPkDIiLXVOzXn/R+DAvvhi1XsuZNhclggOmQ9iaAs4t9DdjeQr9/PM9MvydDuLdspl7DyzMl/j9LBvvbmD4Ue3zVh8PNP29DPxZo1J8wmdFCJVYY3FOnoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9XdajvFO6tAl8xfgibKdqUh65XFW5zZpKzSiWGedjQ=;
 b=YzUqsHn5PE4mwApRWZR1CtT2YqiXbbz3uJBpKqe7v0JmM0m0Ni0ak6cZ3rNklXkyqI2J9UtixPHpLv9IIcq4KtfHlRciBXMXx7Dn0ZUZK/ON47wHqZ2Le6593Q9e7fOGGS+jZ2tUavASClpBsv6k+WG5phq6mfQgXE7VafHlLCtcv0PLIbNt4ZumvC/bzkawMDGX498rUTMGcqvTJpAz7vHww8qpXEiWMynVP/TbqvF8R9U4YWImsyuX8eSwdhWiOO834jwmRrb3tOABHSOR/v8MXlfgOwQ75/IoJHHw3hXSd+0lJjyKmPmE+beW3g6FotOy+EH5aEeW72gg+RORWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9XdajvFO6tAl8xfgibKdqUh65XFW5zZpKzSiWGedjQ=;
 b=JUYz+4NEORf+LHKRw3AmEEVifmbSU8X2MF7QUmVO+vS30YxX+rkWAO74qiK99m5ojtrA0d/xr6kzrs11vuVVrovenurZqU4vxWIaX2cyu0ZQiTDMgqNT6xRvRzunKAXYShb4l1pPOJexYdcv1o9Q2kSjsrSiLm+RGpRsnqrWMldjDYuRJPmkbhh2a5KDyJGB+KRpK1BPYNoB3RzA9ElAaYYoLzkD0lLNnVz4p+sHR98fcKk3uNqkWa7JeMil4K6AIYTJ3R2TKyJFCAXT083vtNPqbIzMnSDYwJ8KENkVrSZ8KcEYeSk4jxc4ZVIw2JvlKMHqvC8rFgMdQGx3iiUV0A==
Received: from ZR6PR04MB587880.eurprd04.prod.outlook.com
 (2603:10a6:910:e5::15) by GVSPR04MB157375.eurprd04.prod.outlook.com
 (2603:10a6:150:71d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:19:58 +0000
Received: from ZR6PR04MB587880.eurprd04.prod.outlook.com
 ([fe80::2452:9c28:cc23:daeb]) by ZR6PR04MB587880.eurprd04.prod.outlook.com
 ([fe80::2452:9c28:cc23:daeb%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:19:58 +0000
From: "Clark Wang (OSS)" <xiaoning.wang@oss.nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, "Clark Wang (OSS)"
	<xiaoning.wang@oss.nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Clark Wang
	<xiaoning.wang@nxp.com>
Subject: RE: [PATCH net-next 4/4] ptp: netc: use 133MHz as the default
 reference clock rate for i.MX952
Thread-Topic: [PATCH net-next 4/4] ptp: netc: use 133MHz as the default
 reference clock rate for i.MX952
Thread-Index: AQHdbD6tWf0KyIuLg0+fdG7qoOeinLcdqU+AgAMeLCA=
Date: Fri, 6 Nov 2026 09:19:58 +0000
Message-ID:
 <ZR6PR04MB58788099B26D95DC32A967ACA3F3762@ZR6PR04MB587880.eurprd04.prod.outlook.com>
References: <20261104092217.1730351-1-xiaoning.wang@oss.nxp.com>
 <20261104092217.1730351-5-xiaoning.wang@oss.nxp.com>
 <80a22fef-2ed7-405d-b48b-75ec4316f6fe@oss.nxp.com>
In-Reply-To: <80a22fef-2ed7-405d-b48b-75ec4316f6fe@oss.nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR6PR04MB587880:EE_|GVSPR04MB157375:EE_
x-ms-office365-filtering-correlation-id: 80130aec-0047-4fea-3738-08df3be720a2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006|261009223027099003;
x-microsoft-antispam-message-info:
 mHjVbFuPuDvXi6xB1N+K+kCUNl5wzJRgF74FazgxCv0SqVAoBdNwIdq2EGUketvRokNsoo5CUZQ7jLhUTCAcG+pGBrhBvl0WZ40lDBXIPFnT32vFKRdIkkqT3tqTSSr6VaPhQ22QZ+7pn3kY3ClRtdQiufGcMW+c22Ta8/FvIBljrsLVSMQXOWdtGuz5rOa7qbR4RMztoMh+NNovi2VsDA/wsrLo2C8zsq5BSE6I3pJ7y3hG83JIb0N9W50T3NX5RHktmbaDHixrQgV7p2EJCmgsbeEzBqzfP316p3RlOvBvc71NO8EFebZGPmq2eNG6Tie/RsLry3q467JyBFG+lGPPYZAqSZ/TeLw9G1klnLgCoraEAoUEAhcceb2gT2X1a8catucG9vsj+I0U/YoP9lEHAEDuCjwdk3CUEL1g5T0efeniarPJBoSXNcRwT8Nz0JZ0kRsKV3Jo36c+1pUsd3wC99Uc2PEnysdzUPMD09Cq4CV/eqngiyV/oTzlrKVYODMGnJ3RJD2xcgR93RWA+IMqY8y4uQHK8hRkEPcGqxwC5v76vsXYo7zQIgjTr12ZyEe1R6hV3FbDMzMgBECHYvNRaG52Fi6fyes6HUzDEkDpKTMmNNOvv/okDgyF6PC4EGiRg+XYIfAhajQcXw1md5bqpPCK52bFDGmGEmsKLcHDG+cyU3681MSPemYeJWxshnzsdjoMO74OFcd3vTw3le6okMkHVuH7A0kNt90TQd0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR6PR04MB587880.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlVCMm0xaTdvWllHdk5RQjJUbmVHV3RlM3BQK1hvOE9qRHNvdjF6cVZGY0NN?=
 =?utf-8?B?R25QNVI4NFRPV1BFc0s0TUlzL0ViVVhhSmZrbGo0cEdUYWQzVTVCeTZmdUFo?=
 =?utf-8?B?WmFMRWpDMlkyNjhFdDZyOHFJT2pPMXJVc3NxMjNNN28wY1ZaOC9YMzhSZDZM?=
 =?utf-8?B?RHlHQkxyc0MrOWIrTllKUVlsbUZQdWNweExGMXJCdWlGZHA2dVM2aTV2eG9I?=
 =?utf-8?B?enNIQm0vY2kzQUR0aDdlamhjY1hwZUFZdzBsdW9xcnd0cGZUTER4cWhESi9W?=
 =?utf-8?B?cXhTVWtQYkVVVzFlMG5LUjVOR1hUNGdQc2lYRkNNc201Y3c2Nm4vWnkwajVY?=
 =?utf-8?B?R3h4NVFvNGpDVVNCV0ZsWG9lSyt0Z1JHeW5xcXhVSjJZL081MFp2anA4Wko0?=
 =?utf-8?B?ZEo4MytFeEtrUTVkcHpVS3cvWUZCOVBPcWNsZmN4NzQwWFU3T09qZkVyYkdO?=
 =?utf-8?B?OVRSdHdwYjlhZk1xeEFxT0lKTGd4ai9PWFROUElTVUtxNFRydU9IRFoxakNz?=
 =?utf-8?B?clh4TlYvM2ZFYU5FWnBUSVUxWHZUZW5WeDNkNm9BN0ZNTXUwYUI3WFMrOUNi?=
 =?utf-8?B?L0RWMTd0bC91WVUwUXc2YllseUVSSnpIZi9nU29hWTZsRWUza2IxbE1ZU1Vn?=
 =?utf-8?B?aG9COXd0UFZ2bDRIbG9ib2d6bGpxTTBvY1QvMHByTlhFT1AwT2ppZmgxYkla?=
 =?utf-8?B?WEs5M29rcFZFR2Z1MFp6RG8zUVJGWXhzWUhiR09NMnFjTTFMTFFDM2NFNTQx?=
 =?utf-8?B?TTlZUE9pNThYL0poV2ZOWVNKMkUvb085aVlOclFoNTdVYWdzdmcyRU1zRk53?=
 =?utf-8?B?SmloazBLRHBEWUMxRXNDZWFkYmRhVFM1T200WkxFR0pxUXk5cjlOcDNQNDN1?=
 =?utf-8?B?SW1hbWduYWlXNzdlRmR2Mm1udkVBdWxlQUp3ZExYN2FCeUplaXNkWTdWd2tD?=
 =?utf-8?B?VGtHQTlYUXNlejZQbnJ5cWEyYzhKdjNYTkJvdmxUQ1VXMGJJMlMzTXcvZk9C?=
 =?utf-8?B?c3dkVXMrbThDbm13c1liOTlZR1lyck9QOGlydVc5TTc5UU9peTN4MWJteXdO?=
 =?utf-8?B?UGlCbEZJakxTa3B4MWdIYjBsRGI1bHp0N3BkYUdpUGxTOTB0T0djZzBDakJw?=
 =?utf-8?B?ZjNGc2tnUWhtR0plbXN1c1VnbktIelNLZjBaOTI2OEhINUhOZTBTWGg3U3VL?=
 =?utf-8?B?ZWdMdmtUM3RUVTUvWU9MQkhiSmxzNWVMNS9hRWxNbm9LMUdRYkN6MUFET2x3?=
 =?utf-8?B?YWl3NmdMZUtWMHRMRGxTY2ROMzFIdnZnZU9udWsrUWMvR1U1SUl6aTh1cVdv?=
 =?utf-8?B?K09qWEFsNmdFb3MrUFJpS0FjSlpNLzFpL2VEVEdQd3N2Rmsra2syRCtMNzUz?=
 =?utf-8?B?VWVINXk1TkN4ejBqK0tjaWViZUhTVGJFalRQMndBSEw0R0tldWFrSXhTRThT?=
 =?utf-8?B?ajdTYklxdVEwY2tVQ3FMS0Y2QVFzMVNpMmFJZDN3cFRXYlNvNmcxVDFrRmdH?=
 =?utf-8?B?WER1NXpjZkk2TmhtTWhKaEIwbWp0azdGUE5sbkFGU3hYU2lBcWtLeWFGVUx0?=
 =?utf-8?B?ZVU3VW9SQTRBdjBTYkx4R3VFTFdZaVpFd2FWeTQzVkFxWXNhM2NHa2FYaG5a?=
 =?utf-8?B?VFdka2wrR1JKc1BYOXdMNUlOaDZZZlJvV1V1T0srYmNDTTlGZFBidnh3YVgy?=
 =?utf-8?B?MGEyTE9HbGpKUXdlZEtlTUdsR1RWTEVEenNSS2xVM2oza25rUVBRck5jVU1y?=
 =?utf-8?B?eTFqU0xMWmZKb0xOS3pwQTVUOEtHUTVDSWtFTTJ2VHlqZTRrTDJIRHdTR2JR?=
 =?utf-8?B?NDhZOU14Qi8yRFdabzN3THk4M2RVa0g0cTZQc20rMDJ6eW1ZenZaUGp3dUQx?=
 =?utf-8?B?cnIrSEF4K0xSN3lSWHBnK2p2OWJCM3V0SWE4YXdrWmhwYUhsMUtoQXh2THp2?=
 =?utf-8?B?TWhMV2JmWUxUdWo2dmVaRCtJaGlxNVlLTFhnU25FSDVwbm9MSnp6S0JuTlA0?=
 =?utf-8?B?QVVBcTgvdlhzOFZWT2FFYkpUbXg3TG5SdnBpbEZiQ2hWUndWa0pldUZ1Z3d2?=
 =?utf-8?B?SWpZOUxTd3BxKzRveHVHdDc3WDFTUTRrbmpadG9hRVcxbi8yK3NUL2RaTXgz?=
 =?utf-8?B?L0VLbldiUkwzQ1ROM2FNUEZGR3dKVXBxaE4zK2hYV2JObmJQdG1xVXkwUTEx?=
 =?utf-8?B?dHgzWnVyT3NOS0hLUGZueVpHSFBOWDZpTXJKUlV4S3lzOXBubDdlQm1uTkQ2?=
 =?utf-8?B?QWc1bTMyczZuckVaSEFqTXA1MndQMCtOWVQ2cVoxZm13NzVkQnlybFkvZ1Ba?=
 =?utf-8?B?Nk5oNVBQWjcwaVhNQVQ2blJRNHVwaTVTUmFrRzVqQWRSQzNjMWg0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR6PR04MB587880.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80130aec-0047-4fea-3738-08df3be720a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 09:19:58.0866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0I9E/YhVaSaLY+cwJwZ0RknxEeiIz/6hIvZsWXouSLiK4YUofI2qTINZVW5pGqdIJayPuszTZbgp9veELDn+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR04MB157375

PiA+DQo+ID4gICNkZWZpbmUgTkVUQ19UTVJfRklQRVJfTlVNCQkzDQo+ID4gICNkZWZpbmUgTkVU
Q19UTVJfSU5WQUxJRF9DSEFOTkVMCU5FVENfVE1SX0ZJUEVSX05VTQ0KPiA+IEBAIC04OCw2ICs4
OSw3IEBADQo+ID4gICNkZWZpbmUgTkVUQ19UTVJfRVhUX09TQwkJMiAvKiB0bXJfMTU4OF9jbGss
IGZyb20gSU8gcGlucyAqLw0KPiA+DQo+ID4gICNkZWZpbmUgTkVUQ19UTVJfU1lTQ0xLXzMzM00J
CTMzMzMzMzMzM1UNCj4gPiArI2RlZmluZSBORVRDX1RNUl9TWVNDTEtfMTMzTQkJMTMzMzMzMzMz
VQ0KPiA+DQo+IA0KPiBJIHdvbmRlciBpZiB5b3Ugd2FudCB0byBrZWVwIHRoaXMgc29ydGVkIHNv
IHRoYXQgeW91IGFkZA0KPiBORVRDX1RNUl9TWVNDTEtfMTMzTSBiZWZvcmUgTkVUQ19UTVJfU1lT
Q0xLXzMzM00NCg0KVGhhbmsgeW91IGZvciBwb2ludGluZyB0aGlzIG91dC4gSSB3aWxsIG1ha2Ug
dGhlIGNoYW5nZXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KQ2xhcmsg
V2FuZw0K
