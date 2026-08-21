Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8979330567F;
	Fri, 21 Aug 2026 01:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274373; cv=fail; b=NFiWYJjcq5M07PY8xxd2Ja8ehD7Dxke092AgXeApRACMmRMHTA8TlhSS/Ct5PkrWMbG15BM2eSkmlVKDGOe+PvJCZoH568LOBnqWCdp7fsFU7oPz4tPfZwj/Y1GH0Corx7rRmvu5ACwzTEdqZAGXRG5Mcbe8K+O2jECeyZkpP1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274373; c=relaxed/simple;
	bh=s4PLpyJkgxJTT61ReBjUsAd8vJU2zxvPiIRNhn7oNtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BbFYXfEDKuwuMmTKmLeTnVmXL21yCYfN3+MUChbVX0VLl3Y5TEZwbQkcaIiBj5uvYeRp/NyJcYuOzTAWUhJDXwrXesdfQeruHcGvxszN1s1QvgxhwXpmMsecaIVhcZzvCn8xyc8pq7aUnIMt0JraCmDpljTH/wZj8TVXPhKZwC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=lbI9s009; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=OWtrGuAi; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="lbI9s009";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="OWtrGuAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=s4PLpyJkgxJTT61ReBjUsAd8vJU2zxvPiIRNhn7oNtQ=;
 b=lbI9s009ymyGk13k2MwW64p2NFY60PDXLyArswylHhF895VeQIFvZhcUydI+jluiHMGDrH4Wq4eyLsxJCZatOFQmnyASh83hw1ypSfaz5vV0FYhk4zmJd9XIthJoqYtLoWAKoBd7Mv5vBXJHdkH943JZ6GiGlxm+xM5nQrez3iU9uSkXCmpqqCpgkZjSYsYXsJVGaH6xLw5YtYvRwognm9mU1BS8f4pVgYkeZaW/cWn+eQZyuliYxzMEXuCDZCcgMu42BpJJ9HEeq/QSpWJOSE3ymK7qs5hRTEwDyowjqzoBUne9qQlt/tFP9sFtc7z2kdtmOxGcvBmY/AwkWWlY1g==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020132.outbound.protection.outlook.com [52.101.201.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C551228007D;
	Fri, 21 Aug 2026 01:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/wAhCPp5qKL2IT+S9xv+RiDg2Zt/XTcdwItEwM4hppqXv1ncnlSUxmFFtSZNNIvh9AQ0I+hpC9TFo4Bs9FAvJhaig5kveNj2h2FpB69CBYc6O2O5Kj8hQZZN5xjdC1dTPCBW7HybabkYeFyeL/TdAnubu9L7c3QzgMxswMN1bMoLsXI9DW1i1fi3yjgRTYdvvamsImf0Po3pJXrK0/D1soNB/GNp2LljZnoG1Bhfsut5xg7wpiUAwo8O5ASOwunFjUatozSR4mdZgreBEX56MQ2yfuy8RI+bcDaoCg05hJK4Vi9PNiNYrTQIBxRrc4UVORNdYpaTkjQ8SPuLBF6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4PLpyJkgxJTT61ReBjUsAd8vJU2zxvPiIRNhn7oNtQ=;
 b=G/INs4M9XOaIRkr4K/ATJS6wHGhcH25bwpv8vVLJL0cxzwFGyUBTpTsPIhvnR98plUAz75Vp8yYGP/HhJYpNwMkBBtp57GDMV2K3wnBZXKIHgOE7UOheJvaUf83fKgdFemmhcvnzq18UOktkSL8ZqigeqVeRDi9JyyLaRTE2Nl9xK4j9cf4eMQ05I0trDmh2kzD/6NpkvjXkxRyEbQG+ME7Qtrp2DAJYlrUHf7Zt7E3PaTagq17jX+TCin2JEWeUKQY1NDuX+JVsWIWydEq3ii340Jo52m1yu784vtZzSmDmiViwI6RNPOhCDSKxhpldA+uPgBFZXj6mw61ZT1z8eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4PLpyJkgxJTT61ReBjUsAd8vJU2zxvPiIRNhn7oNtQ=;
 b=OWtrGuAiHP8txz2pYjCP9Zoh2nj2ny07Ik0f/SIHcOvT7hhIP8+G6EVHEAP4C8WtPzNKxDzfbjKT1caji+reWfdDsI1t2x9MUEjFLdtQ2iw/xIDtOMQBLBwLweKz43muuWgAy/zE//Vn5UXLluSJeSygHSYs3oWz94QdMj6OPEvgVjBFN63dTw5Y0ZnVTuwUJYsEnIsVETEk3MBYBLu6R0TfxyOGhvx4F3RMHGKby6clHXiuHlExeIhgCUkBkE68mitwg3IZdEJU/4QX/ai0fGhS1t+e5e45An+DXbVgUDFkjuY2cM7iGt5qONCJx7Vs8MsRCnXA1h/stIc4XCbpMg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CYYPR20MB6737.namprd20.prod.outlook.com
 (2603:10b6:930:c5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 01:05:58 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 01:05:58 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "ivecera@redhat.com"
	<ivecera@redhat.com>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdLQQfSg/FkjsHkkS39O51qCIspbal5eoAgAHSfgA=
Date: Fri, 21 Aug 2026 01:05:58 +0000
Message-ID: <20260821010556.95192-1-arouhi@sitime.com>
References: <20260815221919.64226-1-arouhi@sitime.com>
 <20260815221919.64226-4-arouhi@sitime.com>
 <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
In-Reply-To: <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CYYPR20MB6737:EE_
x-ms-office365-filtering-correlation-id: 91f23c4f-df2d-4521-57e4-08deff205c15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|4143699003|3023799007|38070700021|5023799004|10067099003;
x-microsoft-antispam-message-info:
 8XJpWA9TIN1RKWlOLzhgU+ZrslwkXxDcnZ5CusJQeWJpWlqrAD2dGOFC00sVWw4PbKItYFGiFFJIGGWMfDtoQxcQLFTk0YZXjF1TY2WAjWKiecQpg/qmQPmEhtHjvgSBpuJOpGop6WeumziSE9Rpzin7eTV2Ox5UL7MoowgpWnE1cwjs2AO7ZfOldeLQyZtfk4NAQKtLeN055z11lSIegB0T5n1PkH6/XQ4l6bQ7ZjGw5dQRcymjqgJQLEHn1AImLjifGojOPLUHJAnGHY4O5GAedA+xhfnQnUK/fZrRbCqxGf+SpvJfmsLF3TlnyHBUvWTwUxJPEL3IAm1qrRoik8vvVidH38FtDwMtghr9f/M9mjN13yk5OO3dfuThGTi4uDHVblVE/xRqHFnOOz7hlSqCyWUZs03KL1LiRUC8j0WlihZHddRdXgOw+ziT0x6aA3XVsPd4Beh7E2srVu1esTS6aNsb/BuSQ0AzfmL/pWiDCoDHmtdQokD50as32wOv4oQdi5NREiXc+gHg83M2FJKlYl/Q/xE1Aek2p1QGKsi6/SHDC6No2NDkS9UCfzUMUFxvBmuLTZN+VWRbI/euHjsT0A7cF30uv/hn30qEYoHM4ws3WViBn1UxBQc7zxMmOCtzM8mGnOKcximU0FsdNwaSwjecT+XMkwIBM5pBrCW5bJ0SgP8UjU/4x3q5XMhgY+oAW5yQF0zos2TAML1oxlQEUmpRlERFLCCphA70OL4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(3023799007)(38070700021)(5023799004)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFVjcnBoQk9vTW5kdVhJaVZCSk1PM2xiaDB3R0RuSTFoekc2NnA0NXBsQk5T?=
 =?utf-8?B?bEw1MWJDQUErQ1FYN1JrNFNjK2Rlc3YvR3ZkNXVLd3JWTmZDREhicnpEZHJJ?=
 =?utf-8?B?ZE5rQkcvMTlENlkrQktqdGMvOFhER29YSUhvSDZlUVJvYnRFMXRCSnZETmdV?=
 =?utf-8?B?enVLeTRWUThXRG9HSU5FVXNUOE5sMHYxVG5qRUdraWQrZXJkZFp6c01GaFVp?=
 =?utf-8?B?UW9rMGtvMzBuTVpsZjJ2YnUyL2c4U2hvWVBkUzB3WlplWXg5ZWtZaFp0aTgw?=
 =?utf-8?B?WWFhWmFlZy9EQzdNaVJ0bzMrcXVvVEJSaGxacmg4amVuUXFjWVcxalNNczQz?=
 =?utf-8?B?N1gyVjhoenNKZGpBTlZaaTJnWFRab3M1Q3lRajhOSVhsNGp0YmNCZFBPU1kw?=
 =?utf-8?B?cnVpRmlGMmRCSnpKcURGNEpDQlg0Y3djYjhhbTlyUk9WOFBmdi96NmphRjFG?=
 =?utf-8?B?cDBKdzJPb1QvL1FsRjlQVzhIMUl4ZjJtK0Q3YUZVcWNqTEJLZjltNU1VeXo3?=
 =?utf-8?B?Y05WYVpaNVpYVmJkbmp1dFpiZG5JMWF0T0JOSCtUSUYrMWhCZ1Q5d084L1R5?=
 =?utf-8?B?NmV1cWJTNVFQanFocGhSZTRFVzE5ZFhkL2FXc2JYcnc3WUVrcjl5ZzhqZGtn?=
 =?utf-8?B?S011UHpvb1hxMzlnU01RdEFrdVI4NkgyWmVhK25ITVZ5S0ZQNXpvNlRoTWpv?=
 =?utf-8?B?NjUvemU2OGJwbzdva1lqRy9mU0dNRi9uWlBJUkpFTWtEbjVrZEw0V3pEMWFj?=
 =?utf-8?B?TkZZbzZDdG1VOHhMeVQreDl2K1gyRkc5bGJ4UXpNLzQxQlJwZG4vc1pmSW5O?=
 =?utf-8?B?eGgwZlNZeE5OR2Y0R0loUmZVTzYxNEpzVG1nd3JmeE5rRi9pRi9yTmRyQzNV?=
 =?utf-8?B?c1VZU0Y2bHhnMWF2aE5MVUVBcGtpelB3RlprREpNM2ozS1hYMDZwWnVFbUZ1?=
 =?utf-8?B?TmRYWFhITkdmeEJTM2Jvcy9CanQzQ1NTR296S2hRTlZsZGpBNHpnWTFGT0hr?=
 =?utf-8?B?dWQxbUFGMlVQaC9TekZTK0MxTCsxQ2NLdDlESTFSS2dlZFJUY1Z0azdOemFk?=
 =?utf-8?B?eDNWclFWUC9Cc1REV1p0YnYvSXRHQy9aNjlrNjRwVTlFc0dybW5lYW81TWJS?=
 =?utf-8?B?MXZHQlNpZmZ5YVFaQUVyTjBoM29oNFdnUFZkY3BCYVZiMWNaTlgzMk52MkZM?=
 =?utf-8?B?cWVTR3A4d3ViUit6Zkxra1RmZ0xSVUtZaGt3bHpZWTJHUkpUUGgrOW5lT1hU?=
 =?utf-8?B?elZZZ0dYWU0vMGdTSFNWMUJScEV3NEp4bC9MbkY1S3dxT1VPaVl4a3h5OWdr?=
 =?utf-8?B?UWZ6bXJhTWJ1RUtNQ2RWOWhuMm85K21Ca1M0UEgwZ25xU0FyR1k1VjJnTENQ?=
 =?utf-8?B?RDV3ZFJSMHFUMWVjalkzcnFRZkxaU3RSakMvMUM4WGdoU1ZsRTNWdjU4ZUJm?=
 =?utf-8?B?NnF6OGpEUFB6VHZKTlliSU1nZjlLQkVmcVE2bGpKRzZmUjJUUXNhL01jQ0hE?=
 =?utf-8?B?cTFIb0lyZk5DMG5pUWhPdWgyQWtDMGxYT3VaQWFzWnBZY285eTlpQUpvNUpW?=
 =?utf-8?B?YXpkelJVVlV3cHJBSktEcnhRVi95blZUWWIyYzVSbzhWc2VXT01jc3B6cmRk?=
 =?utf-8?B?dnlsbXB1d091RUxJc2JTT2JEbSszbnJPMUV5VHBSMEtFcitYWUZBVTMrQ3Yv?=
 =?utf-8?B?c2cvbkFZSTV1Q3lPc2NOcTNMQmFPT0FpNU1CZkY3OVA3UHl4dkFESWZJdGhQ?=
 =?utf-8?B?dmN5TmFyeVdjWndrRks3cTl0N095TnVyOWpUNGhKcnVmOHRTaGVBSkNnNVRP?=
 =?utf-8?B?WjVycE5EYk5wZEx1dk80QTM4S1Rub3ZOd0k3YkFOV3hhS0lhbnhtWjc2NVBp?=
 =?utf-8?B?Tm90YzlqaHgydFZoUXRBT1B2dHBVN0k5S2ZDaXIrL1M1SG5tRlR4ejlTTUNK?=
 =?utf-8?B?WmM1ZE1RWWo0ZnZ3OER1UDFTTGEzOTQvbktOM3ZOK085Q2VtbW9rZ1RLTEdL?=
 =?utf-8?B?MUpVV1Z0SnZVSlFpS1ZKc2F1ampRU080eU96ckRaMGpwQXB0WjlmNWdmTXpL?=
 =?utf-8?B?WmtXa3p4and2dmJ1Y3NhMC94K2MyMFFadmZEZUt1aGVYR1l5YkRudTRqVWlR?=
 =?utf-8?B?N1drTGtIbXpLZjNjeFdhOEl6SmgzbktxLzNZajErRzMvKzlLNGRpZ3M0VDUv?=
 =?utf-8?B?YXpUeTRsNThKVDc1aExjc092UlpmOUJOVTRBSTY5cWhjR2dOdXI1U3ozUjJJ?=
 =?utf-8?B?dUdkWkpqNEhkSHlFQ2lnM3F0bktnZ3RucjlmM0Q1bEN1Uzltd0lDUytwRlJr?=
 =?utf-8?Q?UC8uO8PrsqJOjoeCJ9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Bc/AkHKvGXTAbhK5AA1juf8cKGpJfIDYeYJCsComQTJ4hOwOcnSMgpwDaH0jD37j7rjU5K05o4N2vLRUC+zLjovEysYyWo6g0A6f7Ew658QL8GdFRFsx10ReyizG2cAx72dUcN9wsXEM2sHkuw/vHkgli1Noq+D+fhecGkIR13yGsaY0YZaupBOFd8JX7QC6eCdtPOWCn9OqBhVJwiHroqoPikNY1z+6XV73Oev/nIppTtwb+f01o5I5M3yI3OmnPpiIJq5WLWG6WvHSCUXbeJKiA3ukqNQM9ld5Qqf3GIR+immd6yx9izOgD5y9dmrSnyc+1npe5lk/XPm3fOOQaQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f23c4f-df2d-4521-57e4-08deff205c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 01:05:58.2095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8l4NhtvHy8Oj5RLy4EIPoXrj5ZsbISiw2oSdtnea4ELzY2HTwf+egLlJkMRmLAvfPN6lbJSBBRZS6icuGSz8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6737
X-MDID: 1787274363-BmbAMwlyzV4A
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1787274363;BmbAMwlyzV4A;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gMTkvMDgvMjAyNiAyMjoxNiwgVmFkaW0gRmVkb3JlbmtvIHdyb3RlOgo+IGFzIHRoZSBuZXcg
dmVyc2lvbiBpcyBuZWVkLCBjb3VsZCB5b3UgcGxlYXNlIHRoaW5rIG9mIGhvdyBpdCBjYW4gYmUK
PiBzcGxpdC4gcmV2aWV3aW5nIGlmIDUuNmsgbGluZXMgb2YgY29kZSBpbiBvbmUgZ28gaXMgcXVp
dGUgdG91Z2gKCkFncmVlZC4gdjggd2lsbCBiZSBhIHNlcmllcy4KClRoZSBvcmRlciBmb2xsb3dz
IHRoZSBmaXJzdCB6bDMwNzN4IHNlcmllcyB0aGF0IEl2YW4gcG9pbnRlZCBhdCwgd2hpY2gKd2Ug
dG9vayBhcyB0aGUgbW9kZWw6IHRoZSBtZWNoYW5pY2FsIGZvdW5kYXRpb24gZmlyc3QsIHRoZW4g
b25lCmNhcGFiaWxpdHkgcGVyIHBhdGNoLgoKICAgMSAgYmFzaWMgU2lUOTUzMXggc3VwcG9ydCAt
IEtjb25maWcsIE1ha2VmaWxlLCBNQUlOVEFJTkVSUywgcmVnbWFwCiAgICAgIHdpdGggdGhlIHBh
Z2Ugc2VsZWN0b3IsIHZhcmlhbnQgZGV0ZWN0aW9uLCBwcm9iZQogICAyICByZWFkIERQTEwgdHlw
ZXMgYW5kIHBpbiBwcm9wZXJ0aWVzIGZyb20gc3lzdGVtIGZpcm13YXJlCiAgIDMgIHJlZ2lzdGVy
IHRoZSBEUExMIGRldmljZXMgYW5kIHRoZWlyIHBpbnMKICAgNCAgbG9jayBzdGF0dXMsIGRldmlj
ZSBtb2RlLCBhbmQgdGhlIHBlcmlvZGljIHN0YXRlIG1vbml0b3IsCiAgICAgIGluY2x1ZGluZyB0
aGUgb3B0aW9uYWwgSU5UUkIgaW50ZXJydXB0CiAgIDUgIGlucHV0IHBpbiBzdGF0ZSBvbiBhIERQ
TEwKICAgNiAgaW5wdXQgcGluIHByaW9yaXR5IGdldCBhbmQgc2V0CiAgIDcgIHBpbiBmcmVxdWVu
Y3kgZ2V0IGFuZCBzZXQKICAgOCAgb3V0cHV0IHBoYXNlIGFkanVzdG1lbnQKICAgOSAgZW1iZWRk
ZWQgc3luYyBjb250cm9sIG9uIG91dHB1dHMKICAxMCAgcGhhc2Ugb2Zmc2V0IG1lYXN1cmVtZW50
IHRocm91Z2ggdGhlIFREQwogIDExICBmcmFjdGlvbmFsIGZyZXF1ZW5jeSBvZmZzZXQgb2YgdGhl
IHNlbGVjdGVkIHJlZmVyZW5jZQogIDEyICB0aGUgSU5UU1lOQyBzb3VyY2UgYW5kIGRlc3RpbmF0
aW9uIHBpbiBwYWlyCiAgMTMgIG9wdGlvbmFsIGRldmljZS10cmVlIG92ZXJyaWRlcywgcGVyLVBM
TCBGdmNvIGFuZCB0aGUKICAgICAgb3V0cHV0LXRvLVBMTCBtYXAKCnByZWNlZGVkIGJ5IHRoZSB0
d28gZHQtYmluZGluZ3MgcGF0Y2hlcywgd2hpY2ggYXJlIHVuY2hhbmdlZCBmcm9tIHY3CmFwYXJ0
IGZyb20gbW92aW5nIGEgVkNPIGV4YW1wbGUgdmFsdWUgaW5zaWRlIGEgc3VwcG9ydGVkIGJhbmQu
CgpQcm9wZXJ0eSBwYXJzaW5nIGNvbWVzIGJlZm9yZSByZWdpc3RyYXRpb24gYmVjYXVzZSBib3Ro
IGRldmljZSBhbmQgcGluCnJlZ2lzdHJhdGlvbiByZWFkIGZyb20gaXQuIFNpemVzIHJ1biBmcm9t
IHJvdWdobHkgMjUwIHRvIDkwMCBsaW5lcywKbGFyZ2VzdCBhdCB0aGUgZnJvbnQuCgpUd28gZ3Jv
dW5kIHJ1bGVzOiBldmVyeSBwYXRjaCBidWlsZHMgYW5kIHdvcmtzIG9uIGl0cyBvd24gc28gdGhl
IHNlcmllcwpzdGF5cyBiaXNlY3RhYmxlLCBhbmQgdGhlIGVuZCBzdGF0ZSBpcyBieXRlLWlkZW50
aWNhbCB0byB3aGF0IHY3IHdvdWxkCmhhdmUgYmVlbiwgc28gbm90aGluZyB5b3UgZmluZCBpcyBh
biBhcnRlZmFjdCBvZiB0aGUgc3BsaXQuIGNoZWNrcGF0Y2gKLS1zdHJpY3QsIFc9MSBDPTEgd2l0
aCBzcGFyc2UsIGFuZCBhIDMyLWJpdCBidWlsZCBvbiBldmVyeSBwYXRjaAppbmRpdmlkdWFsbHks
IHRoZW4gZ2l0IGFtIG9mIHRoZSB3aG9sZSBzZXJpZXMgb250byBjbGVhbiBuZXQtbmV4dCBhbmQK
ZHRfYmluZGluZ19jaGVjay4KCklmIHlvdSB3b3VsZCByYXRoZXIgc2VlIGl0IHNwbGl0IGRpZmZl
cmVudGx5LCBzYXkgc28gbm93IGFuZCBJIHdpbGwKcmVzdHJ1Y3R1cmUgYmVmb3JlIHBvc3Rpbmcu
CgpUaGFua3MsCkFsaQo=
