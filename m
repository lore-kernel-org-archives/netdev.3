Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F73218BA;
	Sat, 15 Aug 2026 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786832375; cv=fail; b=X3o6AIbwCZy4m0v2X2yfgykqHW/6+c8zXuIcBP14GT6IUGP3ghAd1kyc+3BuUg+nmX2wbJ2vNZLS1RNgseyg1tvfb84GUJEI12VSjZZ7ptZOE93gLvt7zKvL9RS1GJwApmD8Upq7/xFBi7u61qOnV08OVeEeTntZR69I0gnzF2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786832375; c=relaxed/simple;
	bh=OS7ssmK13Zzn8x0KCbP7FWd7bvgxkw0woQ2cX3ZTJxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iybaMjH/y+JWsN7GeTRBeVPvBv1bANyiPeDVTpDIpJb51l9FiRFJQCS+N0tv7TVci9Lef9P0ERE0yn1ZDobrRw2m3HCnQDVIsHwd6pU+cnEBImlpZFSK8JqRFxi+5xRMgK8yzYaQx/nJ+VDwDDCVhUrEsjBVT6ehYEnVf54CIbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=aH5j5J7x; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=WCGTnP7V; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="aH5j5J7x";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="WCGTnP7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=OS7ssmK13Zzn8x0KCbP7FWd7bvgxkw0woQ2cX3ZTJxM=;
 b=aH5j5J7xF0vF+RU+vENpOYcRVV7S2z+cd52tWNKLugaoHVeEaQ4XlcknYQ+ZjsKr/jZHRhxtkOW3eTOAUr5GXcYz81DHAAOiX88fujDXariut2mRPypnhd1H+GG9D04r5vOo+htKW5FRof7OQERfiwk8T+7AtDpCkJwiNS/hO92sDWGAoxtnIXJrvnVvo9WHPa11NgSLk8o6Zbb2AiiMciBZyqWBzO9sYmCqokkxQnFgN7mLWlpiCBM5fyqJVt4sx0JK1rQoJ0uSJjoef5TORBlDpouMAHEN5OHOgi1LIDmZM3EuOd8YxWvtVDTBbB/urZ4pH1NmeHSLpm/9chvkUQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023089.outbound.protection.outlook.com [40.107.201.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EF5B7340068;
	Sat, 15 Aug 2026 22:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRKt1WEnksPfsI2irtQwgsBuxbFwlZRfiUEt2awggYGGXoepwZHmE2mGAm84sDEYAB8uzEHzO22S7bsRDSRLN9zamO3u2yA7KbiDK/dEGJ54NeUPgIDiydo6kJguElHYO+qPfVqxN3lqBIgdhxRG7tnYfp0auwMobNBFW74kNdsYHSJEjleVTnN9YPD1x+z9piSdguJ5OHg/OylWI4P/YYk6UBoyGjD0jiCw92qkmQhTmwYMu9MNyzw0w9FIiLyQbf+Zgs1bOC+cYLXSPyq5Za8sRw2SSkOilr3Lyg0XA11mxN7EUfgpuA2MTD/Ym0SV+RT+2Cw6375JQBJ7PRDDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS7ssmK13Zzn8x0KCbP7FWd7bvgxkw0woQ2cX3ZTJxM=;
 b=Hgc12qDUcTdcPgxdusDFOvShv5ldRKKnQm0RLvn4a2bAitGIIQzCW/iO8jJHuv0Gs/DFeOeA+8KlXHb+5nZI6TfMBu7BFYWCe/NlgfRyfoCY3qSfb0ZCo93QRKtdkoZ2jo1bmkHWzlCLE3+e2WXgTkJiMVmpcVpYdyIg2PODsF7ohakPbh1F3vWWY8DXy4dglV5FhyFgV/DIcMxQ+kClIqJgKDa8fsxR5btT+MNL8wELjeIh4OMUyq/zXtQvcevxcP4K+LNGKWzBUo6GOjzyB+Gzdx9Nu6TxpUqXNPzQh/7WRvMAUIc/P7ruO4oyAUAuVRrRxgqfOUdHbvVa3fJ21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS7ssmK13Zzn8x0KCbP7FWd7bvgxkw0woQ2cX3ZTJxM=;
 b=WCGTnP7VlrfAw1yUL29Bk8edppxFrwbu/VgEQw3pf0HDhwS+hxn2jddSAbqjl7GQK0PEu0+qW5DrAl8n5I7WcDo15qGopxiOjeHJ89QMATtS40q9Nn0bsBYt/t742VsZ6MiZOOYvkp9yCZTEF2BfMQDNDHgKtZx8VUydgwBzkmKjmFl7CS/eXlXaLGMuTrC/IZ4cFoUvd2ujn4PuGErcyXmGvWeufeuj796m4zTa8YA5Sm8F/3U0pAwK7aho0J1y4gqCKTnRs/o3hvP8tV/rYfIIuRKaiayMGxdXW64fQV59Bp9ssubUCK4GbWOsabzSCROYQCWaOaZ2R6WjI9r/oA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5128.namprd20.prod.outlook.com
 (2603:10b6:806:254::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Sat, 15 Aug
 2026 22:19:21 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0315.014; Sat, 15 Aug 2026
 22:19:21 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v7 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v7 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Index: AQHdLQQeGaxciuf/skOeKIC1+mfLdw==
Date: Sat, 15 Aug 2026 22:19:21 +0000
Message-ID: <20260815221919.64226-2-arouhi@sitime.com>
References: <20260815221919.64226-1-arouhi@sitime.com>
In-Reply-To: <20260815221919.64226-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5128:EE_
x-ms-office365-filtering-correlation-id: 7ca3c503-2cdb-456a-a65d-08defb1b416a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 hELUojJmkx7+lM5nTWFeW9XDxYfOVkQXg+hV0i3TAxsP1bXSWHcscah1DxPXw0aTS5NR3tlQqF4COjS3MFD/fObu3J9wubTwr0EiAzJWuyalBMJ+CerTeqMfYdAv3sVEGpJi3yeF1timsQKL0YLt5eTmiYVTPZsryd4+mcYp3E5Fkn2rf39DSkAHllCPlUWrPy8AUlNaq/UuTf0HJN6sxTGEPE9YU0YcPgaImQnhw0nqa2I5Hx9xy+XKVFlBNkzSDa6QZJyyApRIocRB18q3P2RhWtG6pTqwCs0YGSCUZN3turUkQ9ufukKJfzfzfDZzFFdlLBEPBAhmSNd1/BcQDb71xyeNV3fXRAdOSy//Er0zdq6O49UvsqL69GLVqzBZxainCFJCB7bmezyE/7meQpqtsoyoo8U/AcMOMYgo/Cv6sXUtBYN/Ngph8gdqxTFQp37X6KOXbcpaEG38ihVSbNox5DZVeRVFj+YbsXqqKbDFYXQKrSZejfT3QarrdKBedYFCSFIcGgfntgHUJMM8MFWsJ3Q6TWZhOMS88MA5ZpSnAcqK3OUEttiI8+eKbjzhROILEUtL7MSXZcPWAaADqdY/Q6sj/k/VGG2EdZyyVtFYevbUigf6EJMupSidylZpaY6Ej8o051D4xh3SK0abJex+NT7GzXQqMFHuNvCuLV9mLD/kxr2+/ADFVz5fDz5qXKdevCRBHnZ49uTsxmWfbUPQwPVioLTq1P0zq2M/xDM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vmk5WFI4TW90bmU4dUVreGV6NnhjalVrY3NoMGRTeE9XV21DTnBiWkRqRGIz?=
 =?utf-8?B?Nit2ZXRmb1oyNlhscUR5bFltL04yV3hxaDZQZGhmeDllMnk2UXpDNjdrRklH?=
 =?utf-8?B?aVhVdVFJVEpCdldScHhrV1lsMExJZ1RPcWo0U0QvNEVITXlqWS9PSmU1TlJm?=
 =?utf-8?B?QTAvb2I1THBwZ3NNYkEzUi92c1pYOEkzaDN4b3A3OUd5L3E4MzdreWtIYm9q?=
 =?utf-8?B?cTRkYXJZb1VpMlBLWDhlWkN6bXB1MEcxNFNwSWkxT2xzQ3FkQWxXTmFLRnM1?=
 =?utf-8?B?dVFiV1J3MDYrTCt4M0ZCMmQwWU14RXZwQmQrVTRDK2RhSnVmRmRhbXl2czVJ?=
 =?utf-8?B?em80ZVYxQWFLclBxNENuLytteDFCc3didUV4MFQ4eDEvVlNCaHBrL29oY21E?=
 =?utf-8?B?Y3FEQ1ozL3h5d0VNR1d0WVluMG1BWXl2Nm8wM1RRejdYVXkvV29CckllUE1v?=
 =?utf-8?B?dktTbXNKR0ZYNFloV1JiTHRQT0g2WjRHc2Z5NjNvNy9RWGlWQ3ZCVkNWSkJy?=
 =?utf-8?B?aGFubjhNT1RHM3VMM3plTEliUzVtUDZla3h6V3c5K2k3MUw1Z3pKb1RiS3ZH?=
 =?utf-8?B?YlZJbkZxeEdmRXRjelVaaVd0dmtiVkVwak05YXREZkJEVzdRRnBhbGUyVkxO?=
 =?utf-8?B?VUtrMmo2THFZZEJhR1lIM0NiVmtiSGZUOU9SVHhoSW9CY2MvV0lGcjF6T0lj?=
 =?utf-8?B?dVljc0FtOUNVcCsxbnc1anpSekNoMTloOC8rNFFJeUJLNzBIL3ZZczJ4SGVP?=
 =?utf-8?B?a1RDbnU5dk5YQU8vR0hzeDZVRTlyNDc2QVA1amhoeVBCVGhpaWNma0MxYlh5?=
 =?utf-8?B?S2xBS2RVWXZQeVp3Rm1Fd3luSE1HeWs4QlhYUXZ0NFZzZlc1T0gxWko0V2dU?=
 =?utf-8?B?WHN5L0pSZndhSFM0b0E4TmtrU0tlMHhnaW0vY05mMUpaQmhUUmQ3WVVmS3B6?=
 =?utf-8?B?dXpibktjd3NWZmxHUEVCYkhITW43TmhQSW5qRXpZa2pHSHZzZDBJVE9BWFR1?=
 =?utf-8?B?NHJxRFZTd0ZwcGNQRTk4all6MnJrTUJPeUtVWE5aT0VITmxMNlR0UVZhQ2xz?=
 =?utf-8?B?VG81USsvUXpwSUFKS3dTa3p0RUZzWVc3RjF3cjVFdzBoTFlQM0dWTzhzSkNE?=
 =?utf-8?B?NFBLaitWbkc4cEtYdlNxLy9UUEVHQ21YRU95UXVwVU56NnhpVDV2T09EZWxN?=
 =?utf-8?B?V2NSenNzdzRuNkFsK253OFZTcjRPeGx4MGhrNUc4NUtMVFRxeitkWThGK042?=
 =?utf-8?B?VnNqSDMvNm4xTWFpQmpwSjVBVGtFUkFpeXl0UE1jV3dXTFB0VGduM1c0UmRh?=
 =?utf-8?B?clFxMjZFSVJhRVRzTUFObys4Unk5cTc1Q1V5c1JpcVVSOEZDN1JQMlo3M1Fv?=
 =?utf-8?B?eEhmSUJ1amZLcE1LMWFWOGczVjhhUUFEQ1hTVGV3Y21iWmFMYXZSRU5BZTV5?=
 =?utf-8?B?MllJc0hMRHdENU14eXdvdCt6OFRRTEViaS9yV0hmZVc3dXlSTWtFUlI2dG9q?=
 =?utf-8?B?Y0JucjdVS0g0WTFQWi9DZzNsYXAwUVJVbXJXdStHSUIweWNDMFVTajFpL1JN?=
 =?utf-8?B?OHJMOE5FcE1nZis1VEFBdHZGaGF3NFdRdnlZMU9leE93c2RycjZxSmd3SDZR?=
 =?utf-8?B?Ukt4VE9IQ0xLRWFUNksyWUFxWFJvcUE5VzhpaTN5dnBZTjZlU252TklNVGty?=
 =?utf-8?B?NWFwZEgzenpmOGZOWTVsUzFNcjdHWTE3Mk5EWkRpQ0dKejNZRkR3bGxnbjhD?=
 =?utf-8?B?SmZ3TmRNQm9LZWMveGlVRjRadk9kMDA0UjZMTnBlQXpxTXVzcW43QkpvbXFl?=
 =?utf-8?B?TXNpd3lES3dDOVpRcHlWdFNYbnBZTTRxUTVJditaMDcwQWhiRVRQSnJnMzdU?=
 =?utf-8?B?VnFMcmFsa0wwbjh4UUFDUXZsZWYwSlZrMFdqYm1SQmJhbmtqQlRaMGEvWFlX?=
 =?utf-8?B?MXhNQXhHbjB4M1NqcDdhTVVHdUUyVGU2azFJNVlPVWlBV3o4a0tYRTk4SEk2?=
 =?utf-8?B?VTIxWGMxTW04UVUybFJWdlhuSHB6Mms1dlloSnR3Z2M2ZU5YK0U3OVFjZnZu?=
 =?utf-8?B?T2pjSHk1alJDWi9aZTZ3NjdOZlk2eE9MT2g5QzZlYWFtMkwvUFIxZVVlQ0JY?=
 =?utf-8?B?bkVCaTJQWkVHOERMQ3h3Mk9neGxZVGtQK29IQW5hbHdNVWlTRUlVSHhmYTcv?=
 =?utf-8?B?TDdYc01odEpqL1B0SUVNcCtxOC9BQjBMblBYQU9sVnhRVHNabjVZTDNFQldP?=
 =?utf-8?B?eVpzTDdKeEd4Mk9FUVRJTE1NYW0rRE1lT0J3VmJnZWxXSloxMnRrM0JTRkdu?=
 =?utf-8?Q?QMB6Y75iqgEtbcSKeF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ifu0ypo9Sz77bzS09JRy5fzilpBE4A3uhxbb2ehaLJLkLffc4rbeFXHIx2+BtvZsIQpyYqcl1J5muw8tlUgbK6iJN5B0QgDd7/CRnmdmV2qMyGHssvej9+krdBhTSSuf1VXcxwZbXy5OcQ3mz6L/f0j8nIVxVYa6VzEUbOSZNdCDaTgKmBgl+2gdavrNf+4/QurHLUk2rCNAPD1KI0doqYJfHBoTwE5q1Y1sH+eArrwatGQMKHpe2kmHqmA0aG2munCQl1DhUyVmjH+o/Ctq/XJ/w2dg5yXYs0CD8p026BIlbiPPW9HhZIHYS6sbTJ8/sVr/DZdodQ1D7XmcaMPWfA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca3c503-2cdb-456a-a65d-08defb1b416a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2026 22:19:21.3159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cp6u95uPz1iJznGc7PX9mYDthU+lQ0YHDncHblFxgAjXeoUm5g6H0igc4TYiEGhs7nw0YuCQN1NqqblXQqmN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5128
X-MDID: 1786832365-mwL8S8b7K2SV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1786832365;mwL8S8b7K2SV;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

QWRkIHZlbmRvciBwcmVmaXggZm9yIFNpVGltZSBDb3Jwb3JhdGlvbiwgbWFudWZhY3R1cmVyIG9m
CnByb2dyYW1tYWJsZSBjbG9jayBnZW5lcmF0b3JzIGFuZCBNRU1TIG9zY2lsbGF0b3JzLgoKU2ln
bmVkLW9mZi1ieTogQWxpIFJvdWhpIDxhcm91aGlAc2l0aW1lLmNvbT4KQWNrZWQtYnk6IENvbm9y
IERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+Ci0tLQogRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1sIHwgMiArKwogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbAppbmRleCAzOTYwNDRmMzY4ZTcuLjE5
MjE3MThhNWY4MiAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3ZlbmRvci1wcmVmaXhlcy55YW1sCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy92ZW5kb3ItcHJlZml4ZXMueWFtbApAQCAtMTUzNSw2ICsxNTM1LDggQEAgcGF0dGVyblBy
b3BlcnRpZXM6CiAgICAgZGVzY3JpcHRpb246IFNpUkYgVGVjaG5vbG9neSwgSW5jLgogICAiXnNp
cywuKiI6CiAgICAgZGVzY3JpcHRpb246IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIENvcnAu
CisgICJec2l0aW1lLC4qIjoKKyAgICBkZXNjcmlwdGlvbjogU2lUaW1lIENvcnBvcmF0aW9uCiAg
ICJec2l0cm9uaXgsLioiOgogICAgIGRlc2NyaXB0aW9uOiBTaXRyb25peCBUZWNobm9sb2d5IENv
cnBvcmF0aW9uCiAgICJec2tvdiwuKiI6Ci0tIAoyLjM0LjEKCg==
