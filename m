Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B43C3443
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881887; cv=fail; b=R02cu2dPPFDPvF5X3zyPxzw65Xs5kYSDjm8163iEvVgBQey1PgUVTl1N+RoIgtnuYXGTV/bCWQMFkg90yTTrkWj9N72SC9ljPKcQesRGZnrFLMddJyPDi5TOGys5NQfBk32iZJkqYLOu0DkWZa3MzAw7oEqDtlI7bGJFVBMl48o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881887; c=relaxed/simple;
	bh=q5SgDOtlCZ1Rgl7LI1L2T1ZMwnPeZrbRrO8OfAQiy4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3k0K1d5J5iwiBXHsxvlP4jgDcRcTaUqCDF509jKBJrQcIoLl1b19qYkl7Jf1Uak8HsygBd3VOUoapJ5bxqM6o+el3FhBLhrzfVZJFzPbU30PJMR/5dCHcKeiRIt05aj+Eo3lAYjRdkMqa3kZx1HlMgCjcxnZCIFAL4hNoTNgHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=bPB6Xa1U; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="bPB6Xa1U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3Ehji4iggFuFpgo0D3Pg4O8XbUNMuXYtdpR7Xgaa7erNSsfbiAu4YzchvBubWuCMUQuQ6JB/3zvZtBzbFDPcMl+JuzQQlpBY8Xwdbwnw23y3ENmtEwBAkj3tZMcxx5DkFzy5a/nylUDmcttWPWsbC1UpsWi2vM7uC3Eg5G17HVuo2AbnVtLOZnFsZmF/ZP54M9zhuWCjm4fwzUfK5em61ovsB44e3sVD4rAA3EC8a43RyvaF/N+XnnEPEcSbxXHB9ZHq9KO+FgIYpWMnWpeJqRBpfqNd/pz6oiWV3eBx0EayQsggzXL1HI1dVRbusHBXv5jYFHZ4uwP0hi3wfGADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5SgDOtlCZ1Rgl7LI1L2T1ZMwnPeZrbRrO8OfAQiy4Y=;
 b=EKKiYHGMJ6BL3tbNBdIYK9JRJTgMmKEjpmjiKRHiiZ/nF6Bsu790w8glkv46Iu9U6iMWk2VdFnsG+Qj5WBWL6d3z4Tb1qCo/4AOZBl9rnpOEkNmQYUi7n69am5tKlsJfjVwqavCk7PZfOjpb1j65PoP/J2IH2w2nRpTZmcTOdAi9tQi2to8zbVvge8ZuzoijGKLCPD0fl6dOOwOQ93ZOm6LJByy2XjSYxpqvDEwAsc7GR2RS8tpqTKnMYmd1RWYb3l1XRURxYrIscINSjQ5kF2kQf0iskpBpNii+KxVUlW/qVvgMSg/QOFDDhuQW4M7zwOIWG0Fhn71pxsmsTahRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5SgDOtlCZ1Rgl7LI1L2T1ZMwnPeZrbRrO8OfAQiy4Y=;
 b=bPB6Xa1UC4EX+GmtTWCg3zsL24rQdn6mvspi9xQCEdAo/TFYsKhKCxsMseP0Cwe2pg9hwcSNS21I3TC4iZivTtb4M97SQWcG+ea0gKIc7E1dR7iDpt1HI9G9YaoT2EJq+LtSOSS9RPn+gVo3m/F7eYsCxJeHc64zwl1K7dDjaYb7TUeoHYOo5FnkVTw0IYi0M2koyaJTppkCwq7yzLd46tI9Lfne49UkmSlAZU+mPnaYlD+YNju4/0tqr4IxDfcrhksxERsRSio7bs2ft2nVysrJbtugPbd1uDthdJcD7cc7MD//cyZrAb79QVK7vMm2Uq9791M1TC1m6HOGFFAjww==
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA4P189MB1263.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:58:00 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 08:58:00 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Chengfeng Ye
	<nicoyip.dev@gmail.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v2] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
Thread-Topic: [PATCH net v2] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
Thread-Index: AQHdVVLMcOq+qWZKzkyKZQTVV0xjPrb7MXQAgAAFYpI=
Date: Tue, 13 Oct 2026 08:58:00 +0000
Message-ID:
 <AM7P189MB11374FEBA07C2E6AF0FD6914C69E2@AM7P189MB1137.EURP189.PROD.OUTLOOK.COM>
References: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
 <96105752-63a9-4123-9835-3912c5c6dd37@redhat.com>
In-Reply-To: <96105752-63a9-4123-9835-3912c5c6dd37@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB1137:EE_|PA4P189MB1263:EE_
x-ms-office365-filtering-correlation-id: 4612fe08-31e1-4ddb-12de-08df29081547
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|10070799003|376014|7416014|22082099003|18002099003|10067099003|11063799006|38070700021|56012099006|4143699003;
x-microsoft-antispam-message-info:
 y++MZdocVo+nmM37Ru9f98JRBQW53glNLcavEo757s+jRcyqaFA33gnXen5fUWrgrDPeK8vGYXzk8bdquliZPY46uL6r1HKjWfUhu7LsSXaBmbKhANc7TecopvK3pAdtUB9K2jwRVMBBp68ChelJQSVppMf9wD904080MAHB6xMxLnIHk06zsCz9pIlSKunE+FEhTtr1q1+4U3PV0NCbwo78NaZ8NtbZrvVP8S3EuEvC6FzXUVmS767HFNPkcZ5Bpq5/IYK2QZHOdK/b1H/ffqiwhlEcCiYEhZdRzemaQNVDrWvAP/06YknhqVSvCM2aE8s2f+jY2S/gZT+lC4KhysNcHh3DBHM8j+ClRlUFn5lkSRXef2j6EU8agHIABYoH+wxYg6CR9g+s7mF2ISm/8htt1BA/JReFb0NquLN/FRJNEoC8M4djAsmrSdRAMLHvDblr8YPD8+5RVvOCtMRZTNt8984lPOYun/jwTpUAedr+KwNa1WRvn7ndHIRokNWSqGGZsItYHvdCLUa2SpG3noa6NdvMjG8BPuw0VsaNNp+3wqhScNvym/P4UJbk4fTAYdRQXua0iySR7ELy8K3vC8uPsVKCa+bSwcfzbtr/+Xc5gRSWM7trkMBzg7ljcKSnQdFp2kMNPIypA0d+k4ro7Qhdy9QtxJdqTmJ834EvltUvOIw9thFoqv2Kayo6qAXUU0b8+6k2k9Cu0dFbgUot4Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(11063799006)(38070700021)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DgO64ZEgApvfr9tqrfJxfqEB5Bp8dZ734ZSkLMNlUPN0dCM3FT48ZhmDCZ?=
 =?iso-8859-1?Q?rybbcsdLRMxHAH13tRve72Y6PrKq6bjdEJHmy0YXLaQgcHU4Eec9aOmjVS?=
 =?iso-8859-1?Q?bM6/QTXwPwENQXqXJTQt8fbRiWGeDMJRJkbTnSoCylU9S8vLa5ltm7yxJb?=
 =?iso-8859-1?Q?ZQb++8QxjOF5EHLS1dYQBZIkZ3jNVRQ+ABXlLZc3Ce+I3DQFJN9kWKba8z?=
 =?iso-8859-1?Q?gAQpK/FEOPds4GYMAj/HLdKUfKHXlMsSXUbQyLXEOEQ1sFN5r2KhPPJ0p7?=
 =?iso-8859-1?Q?0KZpUGxQuum6N/+wI7wTgqEFOyRb0A/cvikBEiQwCymZ4IcHibCBK2kjur?=
 =?iso-8859-1?Q?30Pwtbkir1fN84zTDGjacvokW45cYKLUYilKtCMXi9h7eQti8enrVsZj0K?=
 =?iso-8859-1?Q?kjzg0jyGM6/Il67ID7zu+R2BGkeEaoYDfUXc5uhJFPI9dTbVWqxrfpYjRs?=
 =?iso-8859-1?Q?lvck1fYT7zi2WG2Inn8w9vY4zyQqNQaEgQRQNkPWdg6R7HhcFa68w6SrET?=
 =?iso-8859-1?Q?8xowf9CZ/hIz+1Am0JSeRPWO5QQvX3SkLDznT4A+BR8zMEtnGftSXPZFXZ?=
 =?iso-8859-1?Q?zG9WWhbXn2q2OhaUIcaJGmxX8tjbJ2cXaDWccQHrYP1bTEFk3meYoauYz0?=
 =?iso-8859-1?Q?x0OeCPUFIxvB60ATsiy2lt0Ymi3+gjKqLSz2CbO5SBBDLPB52gkzmp3iKo?=
 =?iso-8859-1?Q?QApayM5vMkywttsbqNz9geQDDYJE9L6pzDstbdkYV/AbflFhCubfss64uN?=
 =?iso-8859-1?Q?h/B2a6hi2AH9LUaLj6yvLwjMZ7YWrB8dviY78ahZcfb/UQpMVKCREx8XVT?=
 =?iso-8859-1?Q?lJBPjjz4glSEncUyTsffq0rR8tAl/fQtbGu4X/9ukbJ3UTzVsG5u4BRqz8?=
 =?iso-8859-1?Q?k4HEpL+WWIcLwhX/0IWIa3skqq8kkTipqqU1VXA4UE3MfuQQSECjug/QH8?=
 =?iso-8859-1?Q?npwyY4k6IH2KX5EGmXJ8OQWzFw8J3+YjRm9VPtmlw2VANkdS+qoX/hH+nE?=
 =?iso-8859-1?Q?OOoT3Ox2w2KElH5taWXSTST7WuQyyi+llF7lmH3eQCjw3VJD2YXR26x/FC?=
 =?iso-8859-1?Q?HMvB8trm1+Tzt6zdiBNeyVg7YJmwqDP0uvSt1l2AjLzXRQSqkz98V1Dtui?=
 =?iso-8859-1?Q?uSIskD2+0+U8SAg3OsT8ddqTjv9Bs0PrdWGJOz5l5Mmjlwe6bXol4SaNue?=
 =?iso-8859-1?Q?hf71YdDwX0KtpSXurLf4gCNh2na5IUxZv3+7nmWi0ODAKXLRBneEz4kzze?=
 =?iso-8859-1?Q?R1NwZxPDXu7+In5gkCSwuRereX405ej+Yf8JYH+gq1qYkoS1CL5xpZkli1?=
 =?iso-8859-1?Q?Tmz23OqQri4d6F8IDTj5iuZTASOEz3OX1BQKToKs3lqEqUezH+/m1FjaoL?=
 =?iso-8859-1?Q?cc9etbgGAjE5y4rhkkHYYOWuGbNXK9vho4fFNGzEBPNoRTR/sv67f70cs7?=
 =?iso-8859-1?Q?i3EaNjIjGbbafYq54gK6TVf0DxsylUbHxc0pjSZxWKJyuSR9wNvnhOZorQ?=
 =?iso-8859-1?Q?uRzvR0Xcfkf8sw29/Pl3FeaHwEKfmi+mC3f7tDuiGqRYq1gGfOZ6Q983qC?=
 =?iso-8859-1?Q?i0rMri66gdcMSr8X7PnMf38hidY7XRW5pLF+6zTFsV9Clb9tQ4uPVbqpXp?=
 =?iso-8859-1?Q?Z0KOflhVP5UG4cKDsuSuofqh4yPLrdHtKAw57K/MOKm/3vsQU9Qsc0eXZu?=
 =?iso-8859-1?Q?tPWR4dP9NZro33QJXTmKFDutQmuqLZ4MMH4qbtZhRAL3KN5DevM8iiRp1r?=
 =?iso-8859-1?Q?jAUN91EzOwE+8WAjWl3wY4l5LRmjYqQgS7veOv63lnaTOzBfQlcK0E7C+9?=
 =?iso-8859-1?Q?3O3N7rpkdkKjAgSdepiK82nLPRilGMpKp2fcPd6gOC8S04KJ/FPmHhtkA/?=
 =?iso-8859-1?Q?9z?=
x-ms-exchange-antispam-messagedata-1: UFyLeZgM/g2S2A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4612fe08-31e1-4ddb-12de-08df29081547
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 08:58:00.3054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFU2j/24pzd9qoF3j1tg2uBuiynfnJCs125W6rHIbN2eZm76ByAIOJVIggZg4e8wWSeCuIiG99cW6K86SB0dj+1IzQYin1cco0GPAMqZT0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1263

> Sashiko has many comments, and this is really way too big for=0A=
> a single net patches, specially this late. The above list already=0A=
> hint to some possible split, please convert to a small series.=0A=
=0A=
Yes. That could be a better approach.=0A=
=0A=
