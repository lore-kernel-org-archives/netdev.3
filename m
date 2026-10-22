Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.63.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792709770;
	b=cpWPsAsaRMXeiKy5Pr1yz2wYfc9WLwQNb0/VwBiLEbnnwg9FWpZqZeYO9BpNb6pi8Quj
	 rR94L1lMVoCCfb6xNlBm/Dy6CLZa8c8RVZOwF7O6TbeJH4zu8You9qM2z252fh7u3cPsJ
	 yp+R1fkMxk0L0x5mTzUGhBChVpHLa7Lo1RSybVG82mI66SLP9RVQrU8HvGVREBegYCb8q
	 4yI7fh4qm9znIm43NPdEEFMI8PZbzivonHQMzoJu9p3GP37mRPLQifEF6oyeRS6vqVPOB
	 2zTuitHg7gtPZB5AMwssKQzHcYzp2Q745zkQfb9r0y2gOw8oE8X/qm8JlKg7c79YvmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709770;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Y+gISacI0ghc4CCfS3yP1h1XB8Uq6mRn7+rSvxJ82Qg=;
	b=1QZ5IxowD6mH0FmoV5X0BC5ozhYFwB6WNWyURS9c3djK8a8Zr49/anPK9wAK0H4csTDW
	 +TzXs2d6qmZZ/c3+aw9IVAQY2ab5RCQRfbn77Lt6G9ozV6g7+z2tANRKINoEzcQKygSm+
	 JxOf85e+a+0Zw0papyz2SfkJAjwUvtX3Z9z4BHJutlnQs7RVUOKlc09tX+zp+YR7tfdG1
	 6RoEPkkS59SG0dmTv3WKWxsSvP5vVSY8NddnY8AvLv2wwCdg1Apouexmg9St9yFMO9L56
	 bgMTJQYwOPUW8IXNTWZ/EVgZXxuyID9gsU4OztF/msIk/M2/g2k4QA1GcELd8OAej9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pnnl.gov;
	spf=pass smtp.mailfrom=pnnl.gov;
	dkim=pass header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=noLhLogQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.63.30
Received: from DM4PR09CU001.outbound.protection.outlook.com (mail-centralusazon11012030.outbound.protection.outlook.com [52.101.63.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D0606A31E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 029D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=noLhLogQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzcr7f7AerI2vo5sC+jebqYrg9BY8LH1zx+r27GhdA+7u4YgmI/XoKc8i8keP4Nbzmcqe3ySPnZW7y7ysCaU1LfsElfJ2NbS3KZ+jWirgxsJ4sBJ9uOJLMby5r9s+jundruna0uVP33mWDGDHI1MhvfMxNh6iED7WjsHLDYMX/+sbRowvhcMmf2oYDJAtyyu9sBOyiugjuqx2jCivn0CoeASO7zNnI33bzMv0h46b1QbPH/4MwSS+9VQB+1zvgEhXc15Ou3XR+jxrl86pZBbj7P0Ta6WAe+R0svPbNwiMH/63KyOZOVqLwoD4wIAeLLN50UXMzbOWb8VmbT7Ximaag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+gISacI0ghc4CCfS3yP1h1XB8Uq6mRn7+rSvxJ82Qg=;
 b=kmRB2KQjQ+N6WYBZ9T4lBlGebRethXIK+OHf3ny61BgvNJ0GOHVGVB0z1b8k9JX4B9aupDpUmr30DG3ToR4sqqefHetGcuUEJavb3A7A58Iqo1mqoYWK9PNQqU5r69C7uhMMZn3eJJz6kI8QYqNAdENoM6BM/dsRyij5cO8aNlci9vWmOnyROeOTxXCXBMHbILCIhSfaEmDPm4c6b3RnbocEalcOxxDhx97SuayCU674F3DPbF52eAkwTzlYNCD8i3Kjp+hqg3eObKPb1gw04WQi9hjDJfJE+3b60dTeVY/BdmkT3e04MWzhXY+nm7SLy67ons03dIbxdKwiUC+eMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pnnl.gov; dmarc=pass action=none header.from=pnnl.gov;
 dkim=pass header.d=pnnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pnnl.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+gISacI0ghc4CCfS3yP1h1XB8Uq6mRn7+rSvxJ82Qg=;
 b=noLhLogQIhAvLaFWLccH8EkLJj/0+Wx69QmWt1xuyVzZTvUP1VH6dhkYclFpmR+Lf3CBIbMQbK2JRF0KKDZ1VDcog82RGQG8HK0EHINT8gqFqt/ZFbmIJhPWfxHnKeocp18203TKyEtZ+MK9gp0pNoBl8cdpgDXBllvkxic0I4M=
Received: from PH0PR09MB11456.namprd09.prod.outlook.com
 (2603:10b6:510:2c3::12) by DM6PR09MB5032.namprd09.prod.outlook.com
 (2603:10b6:5:260::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 22:56:00 +0000
Received: from PH0PR09MB11456.namprd09.prod.outlook.com
 ([fe80::855f:d47c:28ba:4821]) by PH0PR09MB11456.namprd09.prod.outlook.com
 ([fe80::855f:d47c:28ba:4821%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 22:55:59 +0000
From: "Smith, Cameron T" <cameron.smith@pnnl.gov>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"boqun@kernel.org" <boqun@kernel.org>, "gary@garyguo.net" <gary@garyguo.net>,
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "lossin@kernel.org"
	<lossin@kernel.org>, "a.hindborg@kernel.org" <a.hindborg@kernel.org>,
	"aliceryhl@google.com" <aliceryhl@google.com>, "tmgross@umich.edu"
	<tmgross@umich.edu>, "dakr@kernel.org" <dakr@kernel.org>,
	"daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
	"tamird@kernel.org" <tamird@kernel.org>, "acourbot@nvidia.com"
	<acourbot@nvidia.com>, "work@onurozkan.dev" <work@onurozkan.dev>, Sabrina
 Dubroca <sd@queasysnail.net>, "Griswold, Richard L"
	<richard.griswold@pnnl.gov>, "Phillips, Aaron R" <Aaron.Phillips@pnnl.gov>
Subject: Re: MAC Privacy Protection Protocol Driver Announcement
Thread-Topic: MAC Privacy Protection Protocol Driver Announcement
Thread-Index: AQHdYYdZ8RJuNPBMiUOi2J1usWg9T7cIXLWAgAFb44A=
Date: Thu, 22 Oct 2026 22:55:59 +0000
Message-ID: <B0D3346C-ACAD-4938-8B3A-501F9CD52C64@pnnl.gov>
References:
 <PH0PR09MB114568347F3E0622F9102AF628A662@PH0PR09MB11456.namprd09.prod.outlook.com>
 <c9f7ba83-ab92-4b2a-915a-1513c90a49a4@lunn.ch>
In-Reply-To: <c9f7ba83-ab92-4b2a-915a-1513c90a49a4@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.114.26102031
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pnnl.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR09MB11456:EE_|DM6PR09MB5032:EE_
x-ms-office365-filtering-correlation-id: 00f63c6a-6b1b-4370-f655-08df308fa378
x-ms-exchange-atpmessageproperties: SA
x-ld-processed: d6faa5f9-0ae2-4033-8c01-30048a38deeb,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|19092799006|10070799003|7416014|366016|55112099003|18002099003|22082099003|3023799007|4143699003|38070700021|10067099003|261022105027099003|56012099006|261022075727099003;
x-microsoft-antispam-message-info:
 9BvVI8+48EWG9xYmzPf8hf1zEAomJw1bl7PE24l5WRAScwe1HFHdI+5wZ5je99emalD1oNh5pVi31otQA/txU/6I1O76QfH7ZotyRMaLratmr2KuEHtzVKBdkcvLa0pLPH2wzvZu+1JEDIRaOEuSdQN7AubxsDf5XyocaLqnP4pdfNVkKBV3H/4caaYhy7eAG5NmXM+TtD+Vs+NQ24ykJdSq0vEhq1jP6QgTxsMgvlVtwihwdDBCShtyMb/PtJsgGG1ZCdIlalfusJ1uoPLXNSz6HVEhMyFdH8AWnswx+xGgwc/Gbl9iFDf6EoJr/FL6zWHg+V4UjFiompAsbFbf4P+JBds2RticoCxaCxxUVjCJqVj3Xo/i/CWex9lobQeM/XOSX2jArCK5WFTs/eVu+zmZXBmSm6iSKX/KpurDH7CBR7MkLFxq0+cMaDvXNj71SI8w33MVJzx102+t0zj8rXRqf7wtTLNB0ewoKoEs5QcMvYGaNo6jAhg6ZSD+lwJBMafw3XEtdk7/yJapmc1SdnRG+/XPI1mLi48BTFUa/iXBhrES/nfaWeDmfJ3Ti9zY+hHP5DzRNDuB7nZFGlNGf2hdLZenRI8NW4ChvwtyEA9P4iwwlwHQNJPNdYw0sLsR8rGXwUmyo4hhvJcJGOfeDMiWbPMjyD2eCuRAFXUQsBCehg28TvlwWaH805Gg2aPrxzh0RiiqWAiEeuFGxl1tvGtXMcm8ms9iAvTwFKgwA8c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR09MB11456.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(10070799003)(7416014)(366016)(55112099003)(18002099003)(22082099003)(3023799007)(4143699003)(38070700021)(10067099003)(261022105027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rk1PY21EeGFjRHRUZm1pRVJvZkx3UFVLRHNTU1JiMnJEMUg3TjdQUjVqSEsv?=
 =?utf-8?B?bGJQQ0cvcDR3WGVJaC9Iem4zUkkyVXBJRW9ickw3RUdLZDFDSnBRZkdpZXFo?=
 =?utf-8?B?Y0xreUp0cVEyR1BNdWdNRUFIM3EzZGlYL0JkY0FjQXFxK1NKMnQzTlZYcGZU?=
 =?utf-8?B?WWlqc25KVCtWdjhzcTR2QVdXOWlXYTlySVlTdlFWY3kxRk03bC8xR090enN5?=
 =?utf-8?B?U3BZZSt2SkV1NTBIdDR6N0ZjNFBvRCtTSDEyNU01SmJxbFQrSzkrKzdjZTR6?=
 =?utf-8?B?TnNsUnFJYnBobnhSU2RKWFR6ZmcxemFPajBQRW9BcWF5eTFkM3BjZEJ4K0xm?=
 =?utf-8?B?YzVxd2E5U3lPdzdyR29tSGovUm5TbklFVHVFcjNpZUtNSUdHTldTYW83dkNH?=
 =?utf-8?B?cmVIeGc5UFR2dGE1WXU5NVB4OWhpL2hzMHh1NU5zbUREYkZFQ25UdHRsaXVG?=
 =?utf-8?B?SFUzMU96QXlGblRLRGZNOVpCMG51Z0lNOURpWkJ2K2tIeER1Qkk0NGZwUnBF?=
 =?utf-8?B?QXJpT2psRUc4RzgrVmM4UjFLVGkwbE1CUm1lOEZENVBqNXpEMkJnNnFzMVpn?=
 =?utf-8?B?SGdiN0g0YUVhclM0bmRVeTg3SlhNbVJQeWZQb29Qa052bFl5QmJIVkNkWGRY?=
 =?utf-8?B?VDlkYXkwS1QxdUpjNWU5Y3ZITmoxWnlDZ3NMWWJvVXNxZGxKSGZXL1pZc3da?=
 =?utf-8?B?dW5taFpXeSsvU0NpTzUrQTNKWG5oZ0JmV2RMa3RaNnpzcnNkTU0zUjRUR1Vs?=
 =?utf-8?B?MkNPNGpkcVo0Q2NTNCtOR1RFRkdQekQ0cXRPdU9GZ2FwbTN4MnA1Mk55S0dj?=
 =?utf-8?B?SXpSY2xWQmZObVJLdmxpdDZSREU3MmtNNzF2cUtZUkVBZVAzd3RzVHR4cHRV?=
 =?utf-8?B?R25PQzMxcEZuWE1pQU0rL0xUais1cmNoRWNOQktPWWwvUVdiNFd0b1FIRjNR?=
 =?utf-8?B?VWRWWVM3cEg4NWJKanZHZU9YMlBxVjcyRG1DQ2RORXgwRHhUN1l3UVpGbXNW?=
 =?utf-8?B?MVhUVE5HQ1hXSXR4OGRYYXFwWlRHK2xISXIzOWxDNzRCSFlGT2hJZ28va1cz?=
 =?utf-8?B?NTg3UFJ2N2QycUNlVXJxaEN2NTZaU0VKQjUwSUZqbERxZ3RxM0lva0JUQ1lP?=
 =?utf-8?B?MjRVWkpLalF5VXdndFJRYVBPRFltS09MbEhzYWFWeVVqckh4Vnd5TG5zSWJN?=
 =?utf-8?B?QjlQYmtkdG9GOTNkMWdOUUJidjVPbnNGOEpYeDlnQW85WEdTM01MaTVhU201?=
 =?utf-8?B?dE8xamZ0NVVJT1FoeUEray9HWVR5V0RKMStoeUVhV2xydFRwakxtTGlBYy9O?=
 =?utf-8?B?a3I0aC90eDZDdmU4L1N0VnBTN253TVp1RTVWd0sva3VpK2U4SnluZkRUaTlW?=
 =?utf-8?B?QUpGZ2xVbUw4KzV3RUtwdXZWYWNHMkRwd1R1QVpITzgyeVlRWDlyQWtNNmNK?=
 =?utf-8?B?MDAzT1BpelhsZDR2WEFnWW9rWnpHbHNkR3o2Yi8rVDg3MGVhQlVKL0x6b21X?=
 =?utf-8?B?QStiRXprYTJJK2NaYUN1dUNCZEIxOWZ3dTBtZXlpUXQwRFZiWmFyR1Q3R1I5?=
 =?utf-8?B?SmQ2R3gxbWVaUkxIQks4LzZqK0hlOFlkZlQzT1lEOHY3Wjh2NXNvMVpWMllq?=
 =?utf-8?B?SGlVcmw0a1VSeUsxOUtESThsMkM1eHNIanR1YWlDa1QzUjM3eE1tVXhHeXBN?=
 =?utf-8?B?dDYwWVBUdUpUazdoVDA4NURTQlVpVFN2d0ZSb1R3UjNwVDJBQmZQQ3FLT1Zs?=
 =?utf-8?B?NlZaYnhKdGFYZnN1T2M5T29MNDZnb2lsSkxTb0xxOHoycHdrcjJSNWNtbGlU?=
 =?utf-8?B?S1Zyb1dWRlVlZFhHRG4wQmtRcTd2NGVvUUNJc25UTmRlemZBcTNVZWQ3aEhQ?=
 =?utf-8?B?R2ZHRGZBTFYweTFOdzlmVmZ6K2ZZVDl2YW1hQ25CYmtFc3VVMFVsRzhDUW15?=
 =?utf-8?B?M1F6amFJREk5VlFnMFUzNkp4czUxVEN1bmpjVDd3Nm1OeVhwb2JvMjZJbG9H?=
 =?utf-8?B?Uy9vRE5pL05QTU84anNBLzFWUmJHdk1aU3ZrcW9rbTM4OE5pSTB6OVlVWmN1?=
 =?utf-8?B?M3laUGVoK1JrQXAyWENnb3NIOXVtb05kNjltR3RCeUhSTmZyZ3FJRW8zMWQx?=
 =?utf-8?B?aFRxcVZvV0VKenloRlNoS0FWYjNzYWx0SmZ0Ny9iZU9nQnF4ZWJjcVBCNXBI?=
 =?utf-8?B?MHJDZTJBNUhYUS9MUGdUYjNORncwdmdBTTZlNnljTTZXZk1nRVNnamF4S3lq?=
 =?utf-8?B?NFZyajRxckxZMkxpeVNCWGoxaWRpeW5hZ3VsMmcxMG1vUmI1bThjYkNUYk9x?=
 =?utf-8?B?N3FNRHFuTmVNWVJkTW5YdE9TeHlmMEtDbFRieVBKcXVodmhhTDFTeEtzRGpo?=
 =?utf-8?Q?GWChUF48ySnaFhvSmKkDjtXiTJ1JaoAT94dOkPh6zN0h6?=
x-ms-exchange-antispam-messagedata-1: URGF1nrY6G3+Iw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55D6DFC2AA5B248A1872FF38EA206ED@namprd09.prod.outlook.com>
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
X-OriginatorOrg: pnnl.gov
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR09MB11456.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f63c6a-6b1b-4370-f655-08df308fa378
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 22:55:59.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6faa5f9-0ae2-4033-8c01-30048a38deeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR09MB5032

SGkgQW5kcmV3LA0KDQpUaGFua3MgZm9yIHRoZSByZWNvbW1lbmRhdGlvbiB0byBpbmNsdWRlIFNh
YnJpbmEgRHVicm9jYS4NCg0KT24gMTAvMjEvMjYsIDEyOjEwLCAiQW5kcmV3IEx1bm4iIDxhbmRy
ZXdAbHVubi5jaCA8bWFpbHRvOmFuZHJld0BsdW5uLmNoPj4gd3JvdGU6DQo+IFNvIHRoaXMgaXMg
cGFydCBvZiBtYWNzZWM/DQoNClllcyBhbmQgbm8uIEl0J3Mgc3RhbmRhcmRpemVkIGJ5IElFRUUg
YXMgYW4gYW1lbmRtZW50IHRvIDgwMi4xQUUgYW5kIA0KaW50ZW5kZWQgZm9yIHVzZSB3aXRoIE1B
Q3NlYy4gSG93ZXZlciwgaXQncyBkZWZpbmVkIGFzIGEgc2VwYXJhdGUgcHJvdG9jb2wgDQp3aXRo
IGEgZGVkaWNhdGVkIGV0aGVydHlwZSwgYW5kIHRoZSBzcGVjaWZpY2F0aW9uIGFsbG93cyBpdCB0
byBiZSB1c2VkIA0Kd2l0aG91dCBNQUNzZWMuIA0KDQo+IExldHMgc3RhcnQgd2l0aCBhcmNoaXRl
Y3R1cmUuIEhvdyBkb2VzIHRoaXMgaW50ZXJhY3RpdmUgd2l0aCBtYWNzZWM/DQo+IElzIGl0IGEg
bGF5ZXIgb24gdG9wPyBJcyBpdCBpbnRlZ3JhdGVkIGludG8gdGhlIGV4aXN0aW5nIG1hY3NlYw0K
PiBkcml2ZXI/IElzIGl0IGxheWVyZWQgYmVsb3c/IEFyZSB0aGVyZSBkZXZpY2VzIHdoaWNoIHN1
cHBvcnQgODAyLjFBRWRrDQo+IGluIGhhcmR3YXJlPyBUaGVyZSBhcmUgUEhZcyB3aGljaCBjYW4g
ZG8gbWFjc2VjIGFuZCB0aGVyZSBpcyBhbiBBUEkgdG8NCj4gcGVyZm9ybSB0aGlzIG9mZmxvYWQu
IERvIHdlIG5lZWQgdG8gZXh0ZW5kIHRoaXMgQVBJPw0KDQpXaGVuIHVzZWQgd2l0aCBNQUNzZWMs
IGVhY2ggTUFDIFByaXZhY3kgcHJvdGVjdGlvbiBQcm90b2NvbCBEYXRhIFVuaXQNCihNUFBEVSkg
aXMgcGxhY2VkIHdpdGhpbiB0aGUgcGF5bG9hZCBvZiBhIE1BQ3NlYyBkYXRhIHVuaXQuIEFsc28s
IGFzIA0KbWVudGlvbmVkIGFib3ZlLCB1c2Ugb2YgTUFDc2VjIGlzIG5vdCByZXF1aXJlZCwgYW5k
IG9uZSBjb3VsZCB1c2UgYW5vdGhlciANCnByb3RvY29sLCBzdWNoIGFzIEV0aGVybmV0LCBpbnN0
ZWFkLiBCZWNhdXNlIG9mIHRoaXMsIEkgdGhpbmsgaXQgbWFrZXMgDQpzZW5zZSB0byBpbXBsZW1l
bnQgTUFDIFByaXZhY3kgYXMgYSBzZXBhcmF0ZSBkcml2ZXIgZnJvbSBNQUNzZWMuIA0KDQpUbyBt
eSBrbm93bGVkZ2UgdGhlcmUgYXJlIG5vdCBjdXJyZW50bHkgYW55IGRldmljZXMgd2hpY2ggc3Vw
cG9ydCA4MDIuMUFFZGsNCmluIGhhcmR3YXJlLiBJbXBsZW1lbnRpbmcgTUFDIFByaXZhY3kgYXMg
YSBzZXBhcmF0ZSBkcml2ZXIgbWVhbnMNCmhhcmR3YXJlIG9mZmxvYWQgZm9yIE1BQ3NlYyBjYW4g
YmUgdXNlZCB3aXRob3V0IGNoYW5nZXMgd2hpbGUgYWxsb3dpbmcNCkxpbnV4IHRvIHBlcmZvcm0g
TUFDIFByaXZhY3kuDQoNCn4gQ2FtZXJvbg0KDQo=
