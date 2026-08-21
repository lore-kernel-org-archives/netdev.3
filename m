Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC3310784;
	Fri, 21 Aug 2026 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274390; cv=fail; b=lvaPcIK1wgStdM9nMUj5ZABrEgDnGSK7e93i4YzRz5TtTgw4Ak7nvxOtpWV0Fhcp9vVMikXatMNMXUXlRsl6WxdYFO7JCTA43gLwZcnwb7nAvk2nrFCE4EWe53aQYmmpC/BM69aIfX4A1+PTewc00spD9Xvv19+v4TvoqI+grpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274390; c=relaxed/simple;
	bh=niocQ/n05E4Wmg6zp2JhBUeqNGoD0lrMvJ4V9JAaAKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l7dzONznXCApvhhJAkBW4PYDDu/N4/tqAJ4g+QKwcmQaDdg0x5h8NdM5C8R+XtkKj1X2XTK9GiNl6G+7brX3AC7zDwMKSayj1QX2CzatqMAoZ+c9n0jNYeB1folZa/hmvm2J+WqSMOk+nT0M5c77dQfQxArefIEduq6A4ZN6kEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=MDXC5M29; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=Z8cbJAmH; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="MDXC5M29";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="Z8cbJAmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=niocQ/n05E4Wmg6zp2JhBUeqNGoD0lrMvJ4V9JAaAKU=;
 b=MDXC5M29f4KVgX95O84XFjy1QJtDRFXCR9bsdaRGROIU2AVsDR+BO53RTjt/NKyqW/pevmvvmKzL6Qdvv18HRlMhHhlaUi0Y7v2I4wts/l0hvF7EmUzEANkE1qvOcK9jUvXPzhxaFd4QMECd4PDzrPKOZqgGxLfZQlQbV0mnGSnEac+8mfO0sD7GyW/7CB0F2OmaG6UnKvcX/WLAdkXxz5CEw55QTSt3wqXJJ+NVUi1unaDQveBaPMdjxJKQMfc3ifsgF3biJr63LIsuOPkyu2NCy02UBArm7B/GVFROQqqEnEZEF00IBfCy9vXqZEyiCqMuhz9pZtjSUOv4NQstng==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020081.outbound.protection.outlook.com [52.101.201.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 7DDD7C00063;
	Fri, 21 Aug 2026 01:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hfn3/mD6iJg1HPNTvMNLxL8siK8hJGQig9rPdGb/6s7Bm7wO7yhXgKaaMrNE9LF5g3kPLh8iz5ad+DUggMZyD0ZQBvH/FSg2Y0OaFORTUi6UDdc0PjbbGyt2YLya1Ut7ucPCzgEbvctLU2D9u17hH3hYp9l2qCfhPWlvURUuPP6Hd9TEstQH2n7PkMpnZGgOw3Ig2wh1ofhMuKgOMjoAwa95gqDdHP5t3S1qQPJBukCSkRtZNcnjWu6tuufLxSwce6wbOSoi9hMTWH24ozVWXhRRGko8UNuuf6t40O4GMFR1HogaMiNDvSk7P5p8FPqvkmmNsDexkLMTv05Aq2WUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niocQ/n05E4Wmg6zp2JhBUeqNGoD0lrMvJ4V9JAaAKU=;
 b=cYTs8ej2pWhDvjklUdbWKCmz71vXby35RuAI/ntZxnNP6u25F+JQulTJG7IN/r6x1bOU/DgzSrQggjWealimCy7hVvNBBxm3UjjPbIGeiWpzYbvSrolo45ndgYZP8k0ARx7geyGja6J+8H+FIByaf6sbg1E03xdYFJrFavdZ0ro9YmKMENzIAYEalfYvzxXqUixvHfEzBjdJLjildO9ULhXVtoVV0iXHkha/2HcDkgAg7MWPf58baPpOeWDJOctVbpcXD1RhSG1y/mahimn6iBuvUQxJphx+4l2BiIEv5/5M+igO4Eco32ObiVynOx0cyN9K66s8M8tvRx9+mKHSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niocQ/n05E4Wmg6zp2JhBUeqNGoD0lrMvJ4V9JAaAKU=;
 b=Z8cbJAmHYj1A1noMvIUwD+i9Hbrl0QbElsj6eCWTT2a18XrUAHCSFdB2DZ+hdt8tXLMad6+5KQWHMaCdfE+cr8FgtYzuYVoigiy/2nARLjzazAK8aJ/ARw+YQESxA+AEWf9FTAF6cORJW3dVDdJbpcIHmn8mxB9Yp1f6gBsEprYrAx6nHoNOanlCDy0JBRmQgK25XXycoWi+m8B7ckFOtZOVUp0lm/SNZEOS56Xx9KmhpuU5P0dLFgIvtHy7swN6cnPn+KgQZ6u3ds2y/QL+zYs6fh+DR2ZD0xkpSQh9wm+KEfIo273sG66i1U7G0hThA0vPtYQlsIISvRpCfqwLoA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CYYPR20MB6737.namprd20.prod.outlook.com
 (2603:10b6:930:c5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 01:06:18 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 01:06:18 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdLQQfSg/FkjsHkkS39O51qCIspbanQLCAgAB30gA=
Date: Fri, 21 Aug 2026 01:06:18 +0000
Message-ID: <20260821010618.97324-1-arouhi@sitime.com>
References: <20260815221919.64226-1-arouhi@sitime.com>
 <20260815221919.64226-4-arouhi@sitime.com>
 <1ab30a5b-6c55-4a3a-8e6d-d94c6a64aa87@redhat.com>
In-Reply-To: <1ab30a5b-6c55-4a3a-8e6d-d94c6a64aa87@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CYYPR20MB6737:EE_
x-ms-office365-filtering-correlation-id: 0a0793bd-b8ee-4156-7b6e-08deff20684e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|4143699003|38070700021|5023799004|10067099003;
x-microsoft-antispam-message-info:
 xD9jQ643y+mu9zenmjxj4OSt4GqxuDr6W856TpVYSGv1AI/ZHTr16zTnspP9CXVHuAkNX1zNp1NIn1oWd3uZGERkONO2vGXJIQnktKBjjexOz9glw9K/GTSA8vmDrGv/0mVN4wW9oCNjyUulHJtESQqq1xYdunEUJr7lJtJpYVdZ158nTHyDyKUrc9ZexMsJDC0rEqlHA6GPbJVXFblId7+aVvFwt+MA0gLh3qOgSrT0vPz1KpXLLm1iLi6RNFuhXwzB6UJJ+O4EiLZEemjEVadiUafJeuPZWqe9RiwMuaSwV0iSeVKLourdMiYK41hVPOeQmle9nwVXq1O1yROi9DLGF4AqP/xVk5uw6NItxAuaS0ikQ4bN6c4tXbj067zUVKb+iesRHA0Pd25SdzXiY2gmbAKpIv/RAgrcEgVr/x3uUZ8VPbVJGUAQUyKnse9ncN8f/H2y70e4YGQEEvInN92FVudjuN+BqaKHC4AiufJEzfl3JrxViNTQFY3Pw4uOoBOlOtl83G22e8MQbZYBFqRX8B0VNNaQoMG1ThDFb/uOyTLurH4Y6KljiJr4mcy6r1ua4S4oJe0JTO6ABo3RPHwOawleeuVfkd0EmmGNjiJxUz5mHHgT5xuynQDlvsmSVeteuFIcffD6TGur0JaA83WV1uzOhZSlxMb8wuJXFLeReYlvh2ql7oV+2nV6Nm8OkBoA0dSVIb5Nz4y6dO0i1g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(5023799004)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEF6L0ZOWFREdHAxai9HMzdWUnZ3TDBJWDA3NlB2eG9tOHdMc0JMdjFLUEtk?=
 =?utf-8?B?RDI5QUxTazVXZkdha0hBK01yZ29ua1dKdldST1h4SjF5bjlRc01PSFpkR3hJ?=
 =?utf-8?B?eEhwaDJNOWo3YkRhY2xRczFKV2x5eklpKzFhbkJBenZZdUlidXFDbzBIcWNn?=
 =?utf-8?B?UlhsZTV4VW9xQzFRNk5OQkpQelhsVUg4cHlXVWFBQ1MwK3FzbldjeU5xM2th?=
 =?utf-8?B?cTlOV1lnV3M4NytEUlRCQmNtcUNGNGNGMll4ajVyTk11a1h3NGx5a2hEWjlp?=
 =?utf-8?B?N2k5VFM4c0d1VXRCUFdRR1R4ajR5eVVRWS9aWUoySkVRQ3dnTmR4bW9VUzNx?=
 =?utf-8?B?eHlRRVpPUVRPeWN0WUZzRWE0VlJxUHY0UkZSTFRPZ1RXTzNpTnEzQU5aaTVj?=
 =?utf-8?B?WmgrdDZ6WFRkbzZxZFltMDEvR2ZwZUlKSW1hc3cyN2pTV3Yva2JmaDFTbHAr?=
 =?utf-8?B?R0R2WklNMnpvVnE1RzBPVm9jQVZyRkJHcHJEVVJucGN4cjJ3b2xOUHJ0T1dv?=
 =?utf-8?B?QXEyQVBJSUZ3cXNlY0EyOVNJUTBUSFRySjhrem1VbUFOeHI1ZkhtRC95ZEZM?=
 =?utf-8?B?dUJSNzU2Rk5RS0x4WDhieElvajhMV3Q4TWRLUVI2LzBiaFEzb2ZYZmdjajZo?=
 =?utf-8?B?OEdYQ0R3WlJ0K3E4eUEzUnhqVkk1VEVuSUdvTDlhTElKWUtnbGR4UURSM1ln?=
 =?utf-8?B?Qng0QVIvdGJmRmtKUmhhUGd0Vi9YYWVuUWFhZlNXSjF1Yjl2NXdsekt3TUxL?=
 =?utf-8?B?dUMyaDRTRlU3ZllQWUwwaXd2OFFhQ1JuZ3N1WWVvMjhZdkpvR2g1K3Vkc1Bp?=
 =?utf-8?B?dlAzaG1xZXlzc0toYVRUVG5wRXErSnBjdDJHcWVQUmZBcXBocEtIRGsrWVRB?=
 =?utf-8?B?WTVWckljZDdRdkd0WXRBZnRaUEhDVDUyQ0JFQTdyVTFEVk1TT1V3blNXYnE4?=
 =?utf-8?B?VkhONU0yNGVveTMyT0p4UEE1eXJodzE2NTlpRzVvbm40VlZVazVXWWIwNVgy?=
 =?utf-8?B?QTFvNmFyQzNrWCt0a2J3UTdRZ1VTMnVOVzR4cDFMYWk4elBrTkxySGl4aVV1?=
 =?utf-8?B?MGdnQS9xQ3ZIRXpteXJIZnlaRHIwS0hxdGUveEY2eE9wRWxQRHY0Q2piTzFr?=
 =?utf-8?B?d2Z3TWt4ZzIweTgwcGtFQXd1TkkyVkFKeXlIZG1TUmVvOWtSaXpOTDZ6RFpZ?=
 =?utf-8?B?NW9pKzRERlk0eTYwVTFDRGZ2YWV3TGRrYkd3bEFabGtBejgwVFJPM0RyUlQ5?=
 =?utf-8?B?RlVickdsdzVHaXViT2hFOW5YNCtIWjAyUmhJWkFuRERDVlZMK2xBcmt2ZlVs?=
 =?utf-8?B?ZlB0VWdva0NFQ3BBVjk3RzRsSVFhSVNxWWIwN21FUldQNGRPcjlFUGdBZU9R?=
 =?utf-8?B?V0w2bDg1TXNRZ3hORzkrblVBRXM3RXJIcy8xOE9QY0R3cDE1SjkyS1ZlQVFK?=
 =?utf-8?B?VmU1eTVjSDVJYSt0em9iWkVJRUxHcjJydXhTMG1BSjdEVUEvenBSeGswQmNm?=
 =?utf-8?B?ejBwcEk4bFRuaGlVK1JZV1JUYnZDdC9HKy9qRUlTbGZmUEszQnEvZjFJQVR6?=
 =?utf-8?B?NHB4T1FwUC9lYTB4L1NzQnJsYVFpUnRsMkhYR3c1YzRSZCtmL0xlYkRlNUJ3?=
 =?utf-8?B?dm5nMWVsc25jd3NkaUgrOTJrbWNtaUpOQWNQYk9mZnFoejUvd0N3QUVLYXV3?=
 =?utf-8?B?V1h4OG4zemhyOGhIdzd3WGRwUTNpUEV5WXZreXVVU3hHY00vUlFZT1ViSnB1?=
 =?utf-8?B?WE9BR29aRUwwbDVURy9lNUI1RWFhMmFTbC9lRGlFSUQvdjd0THF5WER3K0FZ?=
 =?utf-8?B?SnlDOWJkR1haZXFSQjcrV0oydTNKa0FaN3dpakVabVpBWmUvQkVzTTAvM3Yr?=
 =?utf-8?B?V3JmcTdvWGVNVHY5ekprRHBJU3MxUGJsazNNZ0FGaUdVT29DSVQzQnNTUkFr?=
 =?utf-8?B?Y2QrY0RuQk5aOFFpc2NXZHJDRFFFeSs5VzRrcHJMU1BoYWJDUmpZdjNRZzhO?=
 =?utf-8?B?Z3B6WGJsZ0N2TWRPWE9PMDBTQnl5aGdlTy9DL2xLZ3c4Wm9CT2NwRVBQcURG?=
 =?utf-8?B?S055N1ptbE5WenE5ZjM3KzFVQzY3b20wNzY2NTVuTGJOaW13UGJ2Q01XQkJS?=
 =?utf-8?B?dUk2UG0xZTdpWlozYnNXU3krMUNzQmo0QVF2dndJY1VDcG9ESk1VTDZ4NndI?=
 =?utf-8?B?MzNNOVI2VGpFL1Zrd1BlNkU2a1FOQmZlalZzaGtRd0crekozSk1XRFgwS1Zw?=
 =?utf-8?B?SEtXdEU3MmgxZmpCdFpuTzJzejZIdTdOVFZwUGZUZ24xbitZZEdsSW1aWi9y?=
 =?utf-8?Q?BtawVz/enbqMsxw9Fb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	smYhZpVBXAFpnIHTHwHxoeXBRVY98PnmD2VpKBHsyltTyfycLAI8JlES9fGpZHTo7QTZpFMDRKAkTYGE6CNz4PJhzegCPOjKOD1ygjHMIPFu+9RX7pzz5ytgLtwNFlnDD1V1kYM/Fb9UGdBYf1R4w1dUMwQfsoaLgEJ5002+Qaz3182Hcm9F+mGpv8oyCvSk/in4Gluc/8rNEVjxZIigrUgkTjFv4uHnqv6ETdpwrg6+gPK1JQnmiDQVwvCwjSWtMU4C0is2u58phdpALxaKjmqgj0SIXAM0eMgFUlxIm5X/rFrtXTtCGy6xzJdnjB3CQeSV3UZIgaOHOsssMbF8tg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0793bd-b8ee-4156-7b6e-08deff20684e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 01:06:18.6521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nVeeBZM1rmXISywNoAlBAAbRUXX05XbUfA2gJxPJlknkd3KigoJqQE5J6MJX2tmulPpG+mMUAW+e+qu8JIPBlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6737
X-MDID: 1787274381-cbfH6qCOM3qO
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1787274381;cbfH6qCOM3qO;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gMjAvMDgvMjAyNiAxOTo1NywgSXZhbiBWZWNlcmEgd3JvdGU6Cj4+ICsJCXU2NCB0X291dF9w
cyA9IGRpdjY0X3U2NCgxMDAwMDAwMDAwMDAwVUxMLCBmcmVxKTsKPj4gKwkJdTY0IGFkdmFuY2Ug
PSAodTY0KSgtKHM2NClwaGFzZV9wcyk7Cj4+ICsKPj4gKwkJaWYgKHRfb3V0X3BzID09IDApCj4+
ICsJCQlyZXR1cm4gLUVJTlZBTDsKPj4gKwkJYWR2YW5jZSAlPSB0X291dF9wczsKPgo+IFRoaXMg
Y2F1c2VzIGJ1aWxkIGZhaWx1cmUgb24gMzJiaXQgc3lzdGVtcy4uLiBZb3UgY291bGQgdXNlIHNv
bWV0aGluZwo+IGxpa2UgdGhpczoKPgo+ICAgICBkaXY2NF91NjRfcmVtKGFkdmFuY2UsIHRfb3V0
X3BzLCAmYWR2YW5jZSk7CgpGaXhlZCBleGFjdGx5IGFzIHlvdSBzdWdnZXN0IC0gZGl2NjRfdTY0
X3JlbSgpIGluIHRoYXQgb25lIHBsYWNlLCB3aGljaAp3YXMgdGhlIG9ubHkgNjQtYml0IG1vZHVs
byBpbiB0aGUgZHJpdmVyLiBKYWt1YiByZXBvcnRlZCB0aGUgc2FtZQpmYWlsdXJlIGZyb20gYSAz
Mi1iaXQgeDg2IGJ1aWxkLCBzbyB0aGUgY29tbWl0IGNhcnJpZXMgaGlzIFJlcG9ydGVkLWJ5LgoK
QSAzMi1iaXQgYnVpbGQgaXMgbm93IGEgc3RhbmRpbmcgZ2F0ZSBvbiBldmVyeSBwYXRjaCBvZiB0
aGUgc2VyaWVzLCBub3QKb25seSBvbiB0aGUgZmluYWwgdHJlZS4KCj4+ICsvKgo+PiArICogSTJD
IHJlZ2lzdGVyIG1vZGVsOgo+PiArICogICAtIFBhZ2Ugc2VsZWN0IHJlZ2lzdGVyIGF0IG9mZnNl
dCAweDAxCj4+ICsgKiAgIC0gRWFjaCBwYWdlIGhhcyAxMjggcmVnaXN0ZXJzICgweDAwLTB4N0Yp
Cj4+ICsgKiAgIC0gU29tZSBwYWdlcyBhcmUgcGFpcmVkIChlLmcuIDB4MEEvMHgxQSBmb3IgUExM
QSkKPj4gKyAqLwo+PiArI2RlZmluZSBTSVQ5NTMxWF9QQUdFX1NFTAkJMHhGRgo+PiArI2RlZmlu
ZSBTSVQ5NTMxWF9QQUdFX1NJWkUJCTB4MTAwCj4+ICsjZGVmaW5lIFNJVDk1MzFYX05VTV9QQUdF
UwkJMzIKPgo+IFRoZSBjb21tZW50IGF0IHRoZSB0b3Agb2YgcmVncy5oIHNheXMgdGhlIHBhZ2Ug
c2VsZWN0IHJlZ2lzdGVyIGlzIGF0Cj4gb2Zmc2V0IDB4MDEgYW5kIGVhY2ggcGFnZSBoYXMgMTI4
IHJlZ2lzdGVycyAoMHgwMC0weDdGKSBidXQgdGhlIGNvZGUKPiBkZWZpbmVzIGl0IGRpZmZlcmVu
dGx5IChzZWxlY3RvciBhdCAweGZmIGFuZCBwYWdlIHNpemUgMjU2KS4KPgo+IE9uZSBvZiB0aGVt
IGlzIHdyb25nLgoKVGhlIGNvbW1lbnQgd2FzIHdyb25nOyB0aGUgZGVmaW5lcyBhcmUgY29ycmVj
dC4gVGhlIHBhZ2Ugc2VsZWN0IGxpdmVzCmF0IDB4RkYgYW5kIGlzIHZpc2libGUgZnJvbSBldmVy
eSBwYWdlLCBhbmQgYSBwYWdlIGlzIGEgZnVsbCAyNTYKcmVnaXN0ZXJzLiBUaGUgcGVyLVBMTCBt
YW51YWwgaW5wdXQgc2VsZWN0aW9uIHJlZ2lzdGVycyBzaXQgYXQKMHhFOC0weEVCLCBwYXN0IHRo
ZSAweDdGIHRoZSBjb21tZW50IGNsYWltcyBhcyB0aGUgZW5kIG9mIGEgcGFnZS4KCkNvcnJlY3Rl
ZCBpbiBvdXIgdHJlZSwgd2l0aCB5b3VyIFJlcG9ydGVkLWJ5IGFuZCBhIENsb3NlczogbGluayB0
byB0aGlzCm1haWwuCgpUaGFua3MgZm9yIHRoZSByZXZpZXcsCkFsaQo=
