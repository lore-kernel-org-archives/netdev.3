Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.51.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792703499;
	b=odIgJjs9dDGGPTAFaWIE24r/oUUep3vBV4wN6SFAgOlslN6E0GIblnhfaI2AT6PVMgyg
	 je3oTkXhKqHHDseEWzgPBV24LpnCmgMVaAjYNcJ0nFv8at2K8rZ+dzQJ281ubiyzhmOmk
	 8m1m2+pz2/X8W7shrCzn3jaSrN3RWIa9jr2WAKWefEfx/TdJkmhfC1AFYHkGN6/DiDncU
	 RmnQXGlfvvJKKFGJXtW64Wkn39wTKFQbjrNTyXrDtJU+W9lsLRYn5I+mkn8Ce7ZaMfzGK
	 0uhz8mfXLjdOoMpPa7R0jh7yIJy7ubyNXjIGaVQ0zcwmk550gIfV/MRZf28yGgX21Tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703499;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=5bciB1v4Doz7J0qiyv5ocg9EoYHo6IwIFbhA/qT/LyE=;
	b=FTiVtSZ82dasLf2qexZ+hA4WsVIWEbxh0EY0j0Ob6cmrTkxDCuZUNnAdd7O2/oqKTF40
	 Xm5kZkrHxtDebT46yaWOKaqqSyY4KDkxdTvSkWM6EqFv44R/USGxb5T2bgfuCIinI1Qm5
	 k/Nx+3X7XcEF6/RgVwQwlrpK5EbZGa/Xk5203UZa3JUMO0fF6BrRqSc8ZPkgG5H3DyssZ
	 kWPVR/B17QlwrLDWvyVCZ46pCDn7CQVKnaQTU0/oxp9axJknfGdfhxRmWuX3MpNOqwIHX
	 g+O6sOYhq3invReVuzE9HNZtCQIcnDSgVlRod2k4rymnzY2r5Kq65Eu5wUiiPlRQgTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pnnl.gov;
	spf=pass smtp.mailfrom=pnnl.gov;
	dkim=pass header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=o5lDjCkO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.51.1
Received: from BL0PR0901CU002.outbound.protection.outlook.com (mail-eastusazon11010001.outbound.protection.outlook.com [52.101.51.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982FD606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 21:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 982FD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pnnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=pnnl.gov header.i=@pnnl.gov header.a=rsa-sha256 header.s=selector1 header.b=o5lDjCkO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8+NgTeP1K2UsJzsN3kzgaIKrVdxJ0fOo+5g+OIjSExUVH6+ieVQIpCw8WAA5zsDGVZPzlOWFUhFoe7xYrRHu5x2cUyPWsBWCH7nIsCK5lZkTSb6W1lF41GHjYqRybqTBgazHksm5BMmv9899lSklV3tOrLtyOsKc0v7i/jjMCTrA/dHmpAt/a9n5U4b3qT4RyGvQWIjW7QqYuLrvsxE++FdtC1OkobVcQoJItonaokGBjtp4DI4D6JImyBW+y58Ya+e/zdbWuyD4WINKVeFGywhk5BwgvreGUV8GinvZ4Kd76iKVxh0CW/LpvOWdBBxc+eQAl24VBOo7ovbMyV4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bciB1v4Doz7J0qiyv5ocg9EoYHo6IwIFbhA/qT/LyE=;
 b=lXIP8EGeAY53W9yEVxiSKoZatpOGFjaKdEOvrIJuwYSNwXOziNZMMmvBA0InNWbnh4eVsZjPYy4Ry1EDBVaouHVuTh/Dxan6nC2xBubqTXUJPPceZBIHoipDBkOgWaPC7tLQnuh0AS7weRm0A7CRpQHDVXF+r9hbSerVuv+Dhx6zYDAEpyeKaFw7vYCpKu3DiDoQ04ngqVG8Lfk9BNVxGeBE0U77VoSJlQft065LP+yuoJ9ikyYmW0R6f3u8yjx6aw5M3vkY+UC7MT4vDmA5V4GT0mY35O0WGs9rLibOJX/T21QpT3W+2tiqTlC0YTco/AuMhsKxyqzYIW2N8vlAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pnnl.gov; dmarc=pass action=none header.from=pnnl.gov;
 dkim=pass header.d=pnnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pnnl.gov; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bciB1v4Doz7J0qiyv5ocg9EoYHo6IwIFbhA/qT/LyE=;
 b=o5lDjCkO+mr6I/ElKxe4OZTk/n/CejG+4PdpPipw5nTN9lfygnLAiKLs6jb9gFQkFo4xl0+oHdGDEEuof73K8McARJc4rpxY0N4lrz5nyDHmXiAl4QeBPYWIOKsWT8C4dMh8l6Z4t/Qi3l/ouRKlz1HWWwUiPQl0aM4lWPcwRhA=
Received: from SJ0PR09MB11450.namprd09.prod.outlook.com
 (2603:10b6:a03:516::19) by SA1PR09MB11740.namprd09.prod.outlook.com
 (2603:10b6:806:362::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 21:11:34 +0000
Received: from SJ0PR09MB11450.namprd09.prod.outlook.com
 ([fe80::d828:ce30:a3da:3e5d]) by SJ0PR09MB11450.namprd09.prod.outlook.com
 ([fe80::d828:ce30:a3da:3e5d%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 21:11:33 +0000
From: "Smith, Cameron T" <cameron.smith@pnnl.gov>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Smith, Cameron T" <cameron.smith@pnnl.gov>
Subject: MAC Privacy Protection Protocol Driver Announcement
Thread-Topic: MAC Privacy Protection Protocol Driver Announcement
Thread-Index: AQHdYmnqRcJYa8ItfUa5fakbDl3tuA==
Date: Thu, 22 Oct 2026 21:11:33 +0000
Message-ID: <B6D98237-9AD5-479C-AC69-4D3F51C8D0A2@pnnl.gov>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.114.26102031
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pnnl.gov;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR09MB11450:EE_|SA1PR09MB11740:EE_
x-ms-office365-filtering-correlation-id: 23b464fa-317f-499f-76dc-08df30810cce
x-ms-exchange-atpmessageproperties: SA
x-ld-processed: d6faa5f9-0ae2-4033-8c01-30048a38deeb,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|10070799003|19092799006|1800799024|261021135927099003|261021123027099003|10067099003|56012099006|261022105027099003|3023799007|261022075727099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 xb7JGeCxpFxRGrOF29Hs9NEQNUNxULLtLd49UXBTeKycwE0LAVohpvHK/BAnaZTKkW/dyleWY4cKVKPJ2W6fYS9r86Xh6PZVBzSCZ+d+0YKG/+wT1CFH/UeqRYoJoX6NzewR0r5VDigsE2dWt1/B0ppW2iO0GWtj+L6If9mWWBquyo1B3iIvlripDcOB2eDSNnYP/YZRDabT+0GNG205kIk82H3UcxkMt8kh0jT2pJRsXg54i95nCpDsCqZ5P1HkGaclweO9T2X5z9fhM5H+57QExahgcuvAS4Z8luH2HJ6jhhPeU3zJxFYdQcsjQ3AEth+P2OYSqd8eUFzlZF4YhOgjRvEkuJdatung1nPGG5MJew95sUSEgAqJ2yze5p3zKJ36R+cAeTWfpTMDSOi2+lAPjLA1i0QGDRbPW9dHOvpapXqLVM1EiO8YEySsIBUAIMgogK+XZ6U8sE9VxN/J+ANvT/9FhMCIKTmdeXtSpzVD/znMR1kwZGVznjpis3uiX8glUQSRTdbIyAI0o6fSKqoLMc58y07FrZhv5ctDl8th9YvwvX090qbuADZ1FeZbfbX/muKp5YRZjjEmsO6NoGGYdXV44JWJTN6XSn/hll9y4VKTU8KlwSTWM3dY3qNRp2/aef2m2ZoJB5kcDqkAF0La+zI4oyW8CEctjArbvDvB4rLm429eJyi7sVE3R5VlC7ui0cGkNEx69N667A69CvOjtduB+QEPuBKcKXvGpB0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB11450.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(19092799006)(1800799024)(261021135927099003)(261021123027099003)(10067099003)(56012099006)(261022105027099003)(3023799007)(261022075727099003)(18002099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QS9CVEU3dSsvOWpCOHNQOGJWdmZuUVlaT2dUd3M5M0lUZlFFdXdRZUhEeDBs?=
 =?utf-8?B?RUZBWEhuMzA3bG1JY3VDbWNPcVhrZk9Yd01aOHQ4Q1djVUpPZERiUG9PbUVY?=
 =?utf-8?B?S0k0bnpRMHBwdVhxZDR3cWE1Z3prNmxRMkFNdnZzcmNSZC9lZHBsK1NqckY2?=
 =?utf-8?B?NVFDQXd0TTFHYlF2bFVka1BpbDNBNmp5bGJuSXRFdkJXSzBnd2ZkS2VmZE1q?=
 =?utf-8?B?NVdyMEE0YlEySm9Uc3N3WVRsUFh3Uk8zZ2ZQUkJ0QnFIUElJeFpkNFhXL0M0?=
 =?utf-8?B?THNCQTBmYjBPemJzbUtabW45MTZIRTBiSWtiT3RCVEFGSlJqOW5GQkxub3ht?=
 =?utf-8?B?dkFQMVgxcDhROXB6MDVVbVJ6cThZRGZBakpZQXhJb0lKaXNjMWk3dmRiVzhY?=
 =?utf-8?B?a1RVMzJNcUtwa25Qa0kyekZaWExrQ3o3QVk3blFiQmczSnp2OGpJd0JLK2ts?=
 =?utf-8?B?UTRiR1VtRWNwRURORlMwb081RDZFYk53TURBRXlXdkNPcHllMHF3b2dHSXpy?=
 =?utf-8?B?TFlrY29qSVlaSkZaa1lDekwvbncrbG9iMUNpTUNacnBGT01SUE5yWUdYN0F5?=
 =?utf-8?B?dDA4Y1V6SXJ0bWRjb251TytGNFMzN2NLYXZZV1R5enpzVGlEV1lpVXpjWDhl?=
 =?utf-8?B?eFR4RHN6TVhtaTlIak4vYWlQd2RNK2hNckZDWHFZMG5LZm12VTNxSjBZK3JI?=
 =?utf-8?B?UjhOS1lyeFlqNzVMZ1JtbTRLVjJyVGt4UUx4aGFXVnlqaEV1YlkxUTE0dXc4?=
 =?utf-8?B?MDlXYXltL0EvOGV0aC9sZDBoSXZWYzRNSWFva3dUU1BxZmVZZFJWanBpUE8r?=
 =?utf-8?B?SzJyeXpiNUVHMHpoME5XbXpDZFlCbklpSm84WlFHVExaYUVVUVFrWHVFbk1o?=
 =?utf-8?B?N2RBSCtRbmpUeStEdmZxMThHbnJRUUFXVGU5b0ZGamI5MmxrVDF0M2l2WUpx?=
 =?utf-8?B?SnlQMmZlRHRyVml1SVNBamZPY1pkQjMyYlBna3ZTRWkwV3IxazQrSHpQWVA3?=
 =?utf-8?B?NTQ5K25JM28wU2todTdDalVWQlNRWkZPTm9ZYWd4YzkraE93WittOWowa0pk?=
 =?utf-8?B?dTdlTVhsYlN5dHBFUUduSDE3T3ZLMCthQWovZHg4WnpZV2dDVXdyS01zVW9t?=
 =?utf-8?B?ZTA1Y0FNbDI2bCtycklrbkQ0R2g5NEdkV3dRaEk2M0NQWUREbjdMVnhtYWI1?=
 =?utf-8?B?UHNtYkNPcFhqTSszT3BBdUFKaW5KT1Fjbk9kdFhlaXdXeUlyYm9rTGlsVExJ?=
 =?utf-8?B?VGhOSHhWZzdXdC9mYXV5S0RraHFqb2x2TTdOVFpjKzJKbzNvWTJaRmhucDBy?=
 =?utf-8?B?djYrQWx1MXFmcUp0VkJjTGlWU2M0S1JXVDRkMG4wNXR4Z25lZ0JnSWV1NzhJ?=
 =?utf-8?B?VFIwTVdpVVN5ZDR3R1lHR1c1RFhGRk1YTk16U0tmcFFjTXI4dURFL0gxRStx?=
 =?utf-8?B?c2N3Vlgvc1Z3UUVQWTVFdVVlQXF5aTZjcTkzWjFuZlBhTDNnMVFORlcySEt4?=
 =?utf-8?B?M1ZEZmN4bHo0b1E5Wk5kSjIwcTJWamQrRFpPemFXQkpLWDd6MnhZbCtZZG8v?=
 =?utf-8?B?L0xuNmsxMjc1bXp4WllseURPandnUkttN2ZUK2hUTkJjc2FHeWExazNvYmdI?=
 =?utf-8?B?REhjQldZWmtybFpMK1dtd2tXOVhGYkNITVVLT1FpZ1lncGd4TlJUYTdYeDBS?=
 =?utf-8?B?QmlOV2doOWdMU2RHcTl6SS9lcXBwVWtBd2tpSHFQMW5tMThiYmJUQ0ZLeEJC?=
 =?utf-8?B?VWxpeU50bjRYTjI3R2JKVEJQRXc5VDJuKzhiV2ZWUmIrQXNsckxwYnF1aTNs?=
 =?utf-8?B?NTFmZnJhSUZnSlJQSktRWko2U1VvRlFPTFlDU2dYVERNbXAzTFdoM2xLVE5R?=
 =?utf-8?B?NlRPa0kxYzdYMERqdTRSamZyaDRhL0draUZUMVFQQWRnL0VHSEVkamU1UnUx?=
 =?utf-8?B?MzdBL1hKRWhVMHdFbGFmYnBGeW5RUm9aWHVlSWxuY082aDFCbGhoMmRaM0pK?=
 =?utf-8?B?YTRreUxxajhZaTRFeEY3ZUpSemVESlZid1UyRzd1dnJSZlV6bmdLTmhrN3c0?=
 =?utf-8?B?YWhwVDQ4STF3UTlFTUdWaU5tc3BLd2ZuV3JRMWo5aElZcHlCeERnUndwbk5i?=
 =?utf-8?B?MGhHM3VIbWo2SVBTYUpjQmFjeTM2VTZ2NTNSSDAvKzlPb0pWd1hlc0hMTUNt?=
 =?utf-8?B?RHMwQUhZSnVFNGhWWUk0cVVxa0FDR0tybHVRU2U5NVVtcmdrWFRDY2Y4YUN3?=
 =?utf-8?B?T092bHJOb25QQ3ZVSy9tUVBWbXpkVk9DaWtMdGVUOTU3N1ltbWF2TmZNczZ0?=
 =?utf-8?B?RzNaWlNNSG1Gakk0RXVYS09EU3BrWEllRFAxdnVEeDhSTXNsdi9ySlptSEdC?=
 =?utf-8?Q?+IPIcMnyTf/BVFA+B5l7gdhsJZefMpBDzGfvODU4rnRdR?=
x-ms-exchange-antispam-messagedata-1: Pna30e9t0Kr8tw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <496760BD2E154E4A8AF1B8027271C042@namprd09.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB11450.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b464fa-317f-499f-76dc-08df30810cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 21:11:33.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6faa5f9-0ae2-4033-8c01-30048a38deeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR09MB11740

DQpIZWxsbyBuZXR3b3JraW5nIGFuZCBSdXN0IG1haW50YWluZXJzLA0KDQpJJ20gd29ya2luZyBv
biBhIFJ1c3QgbmV0d29yayBkcml2ZXIgZm9yIE1BQyBQcml2YWN5IFByb3RlY3Rpb24gcHJvdG9j
b2wgKElFRUUgODAyLjFBRWRrKS4gVGhlcmUgYXJlIGEgbnVtYmVyIG9mIFJ1c3QgYWJzdHJhY3Rp
b25zIHdpdGhpbiB0aGUgYG5ldGAgc3Vic3lzdGVtIHdoaWNoIG5lZWQgdG8gYmUgYWRkZWQgdG8g
bWFrZSB0aGlzIHBvc3NpYmxlLiBUaGVzZSBhYnN0cmFjdGlvbnMgd2lsbCBuZWVkIHRvIGJlIGlu
IHBsYWNlIGJlZm9yZSBteSBkcml2ZXIgY2FuIGJlIHVwc3RyZWFtZWQsIGJ1dCB3aWxsIGFsc28g
YmUgaGVscGZ1bCBmb3IgYW55b25lIGVsc2UgaW1wbGVtZW50aW5nIG5ldHdvcmsgZHJpdmVycyBp
biBSdXN0LiBJIGludGVuZCB0byBzdWJtaXQgbmV3IGFic3RyYWN0aW9ucyBpbiBzZXZlcmFsIGNo
dW5rcyB0byBwcmV2ZW50IHBhdGNoIHNlcmllcyBmcm9tIGJlaW5nIHRvbyBsYXJnZSBhbmQgdG8g
c3VibWl0IHBhdGNoZXMgdG8gYG5ldC1uZXh0YC4gSSB1bmRlcnN0YW5kIHRoYXQgaXQgbWF5IGFs
c28gYmUgaGVscGZ1bCB0byBzdWJtaXQgYW4gUkZDIHBhdGNoIHNlcmllcyB3aGljaCBpbmNsdWRl
cyB0aGUgZHJpdmVyIGFuZCB0aGUgYWJzdHJhY3Rpb25zIHRvIHByb3ZpZGUgc29tZSBjb250ZXh0
IGZvciB0aGUgYWJzdHJhY3Rpb25zLiBUaGlzIHdpbGwgYmUgbXkgZmlyc3QgY29udHJpYnV0aW9u
LCBzbyBJJ20gc3RpbGwgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgdGhlIHByb2Nlc3MuIFBsZWFzZSBs
ZXQgbWUga25vdyBpZiB0aGlzIGlzIG5vdCB0aGUgb3B0aW1hbCBhcHByb2FjaCBvciBpZiB0aGVy
ZSBpcyBhbnl0aGluZyBlbHNlIEkgc2hvdWxkIGtub3cgYmVmb3JlIHN1Ym1pdHRpbmcgbXkgZmly
c3QgcGF0Y2ggc2VyaWVzLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdGltZSwNCg0KfiBDYW1lcm9u
IFNtaXRoDQoNCk9uIFdlZCwgT2N0IDIxLCAyMDI2IGF0IDA2OjMzOjU4UE0gKzAwMDAsIFNtaXRo
LCBDYW1lcm9uIFQgd3JvdGU6DQo+IEhlbGxvIG5ldHdvcmtpbmcgYW5kIFJ1c3QgbWFpbnRhaW5l
cnMsDQo+DQo+IEknbSB3b3JraW5nIG9uIGEgUnVzdCBuZXR3b3JrIGRyaXZlciBmb3IgTUFDIFBy
aXZhY3kgUHJvdGVjdGlvbiBwcm90b2NvbCAoSUVFRQ0KPiA4MDIuMUFFZGspLg0KDQpIaSBDYW1l
cm9uDQoNCltHb2VzIGFuZCBsb29rcyBhdCA4MDIuMUFFZGtdDQoNCiAgQWJzdHJhY3Q6IFRoaXMg
YW1lbmRtZW50IHNwZWNpZmllcyBhIE1BQyBQcml2YWN5IHByb3RlY3Rpb24NCiAgZW5jYXBzdWxh
dGluZyBwcm90b2NvbCBhbmQgaXRzIHVzZSBpbiBjb25qdW5jdGlvbiB3aXRoIHRoZSBNQUMNCiAg
U2VjdXJpdHkgcHJvdG9jb2wgKE1BQ3NlYykgdG8gaGlkZSB0aGUgc291cmNlIGFuZCBkZXN0aW5h
dGlvbiBNQUMNCiAgYWRkcmVzc2VzIG9mIHVzZXIgZGF0YSBmcmFtZXMsIGFuZCB0byByZWR1Y2Ug
YW55IGNvcnJlbGF0aW9uIGJldHdlZW4NCiAgb2JzZXJ2YWJsZSBmcmFtZSBzaXplcyBhbmQgdHJh
bnNtaXNzaW9uIHRpbWluZy4gVGhpcyBoZWxwcyB0bw0KICBwcm90ZWN0IHVzZXIgYW5kIGFwcGxp
Y2F0aW9uIGlkZW50aXRpZXMgYW5kIHRvIGhpZGUgdGhlIHB1cnBvc2UgYW5kDQogIGNvbnRlbnQg
b2YgY29tbXVuaWNhdGlvbnMuIE1hbmFnZW1lbnQgb2YgTUFDc2VjIGFuZCBwcml2YWN5DQogIHBy
b3RlY3Rpb24gaXMgc3VwcG9ydGVkIGJ5IFlBTkcgbW9kZWxzIGFuZCBTTk1QIE1JQnMuIFByaXZh
Y3kNCiAgY29uc2lkZXJhdGlvbnMgZm9yIGJyaWRnZWQgbmV0d29ya3MgYXJlIHJldmlld2VkLg0K
DQpTbyB0aGlzIGlzIHBhcnQgb2YgbWFjc2VjPw0KDQpZb3UgcHJvYmFibHkgd2FudCB0byBpbmNs
dWRlIFNhYnJpbmEgRHVicm9jYSA8c2RAcXVlYXN5c25haWwubmV0PiBpbg0KdGhlIGRpc2N1c3Np
b24sIHRoZSBtYWNzZWMgbWFpbnRhaW5lci4NCg0KTGV0cyBzdGFydCB3aXRoIGFyY2hpdGVjdHVy
ZS4gSG93IGRvZXMgdGhpcyBpbnRlcmFjdGl2ZSB3aXRoIG1hY3NlYz8NCklzIGl0IGEgbGF5ZXIg
b24gdG9wPyBJcyBpdCBpbnRlZ3JhdGVkIGludG8gdGhlIGV4aXN0aW5nIG1hY3NlYw0KZHJpdmVy
PyBJcyBpdCBsYXllcmVkIGJlbG93PyBBcmUgdGhlcmUgZGV2aWNlcyB3aGljaCBzdXBwb3J0IDgw
Mi4xQUVkaw0KaW4gaGFyZHdhcmU/IFRoZXJlIGFyZSBQSFlzIHdoaWNoIGNhbiBkbyBtYWNzZWMg
YW5kIHRoZXJlIGlzIGFuIEFQSSB0bw0KcGVyZm9ybSB0aGlzIG9mZmxvYWQuIERvIHdlIG5lZWQg
dG8gZXh0ZW5kIHRoaXMgQVBJPw0KDQpXZSBzaG91bGQgZmlyc3QgbWFrZSBzdXJlIHRoZSBhcmNo
aXRlY3R1cmUgaXMgY29ycmVjdC4gVGhlcmUgaXMgbm8NCnBvaW50IGRpc2N1c3Npb24gcnVzdCBh
YnN0cmFjdGlvbnMgdW50aWwgdGhlIGJhc2ljIGRlc2lnbiBpcyBjb3JyZWN0Lg0KDQogICAgICAg
IEFuZHJldw0KDQo=
