Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013019.outbound.protection.outlook.com [52.101.72.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE343B28D;
	Fri,  4 Sep 2026 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492210; cv=fail; b=IwJM4loYg7NUKYYD43C3yIIn8GeNIr9IhZMsnXvW10Ctck8s9ltf/QvGEnVP4TbKlJTqlKsLris5cVPTBFhVygYFVT9X9SJNULTeQwaIJDznqxr3siUe2LUbN23ByEwnYKXkLAWHkxB0sJ00wFp94RAN2UvWTf3Zt33uB8L5/d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492210; c=relaxed/simple;
	bh=zsoVSSLcPwTJlMcxRPac+uoqrz0R2621WEFlf0QRQB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxWRO4pvK5X78XhIP/AwV2+8yBws7XqaRt7J9yaWfRRaaCsDBBqt6x9R/mmvVFsfeV35s65W5B73qpXoD5pS6ki+3YDEjFyi0UOj3RSE5GfeLeUw6kooLRr8Ncq6yYNDoXyxy1Zw59Nq/ft52axUlcXKUCrSyWYLkVhfmlNl91k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aSWvVSp9; arc=fail smtp.client-ip=52.101.72.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSWvVSp9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9af/ExtBt0M3kYJwZ2Dma+na+hUJdWMkOaAld6oxaDrSbVwFaMYeS+r9Ohz5X95DmK5v0cjBybm4dPnadb+xA5pfEugS+BQwriASeZdX0TtrzcS4k24q38Gm37Td95LIPXX3IK3Oqxs0dkoJcmg6dbKtuP0C29l73VX0azuYh5dlJUA7ySGrNZnmY3cUgvgBsnwoCYfyUGxmfh41pf8fRVYgcKWmPKBWDS/TVIc9cptisNUXxbwiICKWPXrqzDEUSeOepiN5phmH0xMFAseunDS8QRVXBos/F4Xdvq10dVqDG71DHdBJL2yrS1ODeUNpSizgBBHbFLlW2zvPLevUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsoVSSLcPwTJlMcxRPac+uoqrz0R2621WEFlf0QRQB8=;
 b=dY6YMJ402DnHV5IxTNbll07SY1uEZiizfsbsMbTj9LmAZKR+b888uuJqyxrwJDU2CfZyImk451lAOgS6Cjxjdd5DfbU8ZdI6hSJ2t5XcIQncgYEvr7wFgey4awj9OGfOO/4iadBy6dslnym1XZSdH0k4LUM9OikBL0RopsfLDAmCG2cWQt0R/epOHIJRG9461WiVzAiWAYEp0CiSLLY7oAltXhZ/Sn/ryGQvwYBSjqQE8fFicL6BfAFpCBvHeQvLtpbxQOh9qyHPiGr4zGAJQ6NuGIMuySrFDtTq1yCAAkibDACeYLCNUYQpA8UX9Ue3qbZENNvm/3nAK8shLwOEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsoVSSLcPwTJlMcxRPac+uoqrz0R2621WEFlf0QRQB8=;
 b=aSWvVSp9cZubFanfVLG4B7dYh18fqcdt2K0NnvjLH4LXuMzGME5W5ddEF3UQWZZyeQgejC8gmm2YuHu4DiINpFNZnhzg8pVmPGK1HaKmLlaWTwJtljR4N7RB1yIiCH7HZ7zSN+oe0mcn4pzzMRD0E43HTSMhYMXwvprZhZHTICbnCd5Mu4nrTAxjtLIoQK8wRKgVYZSH7bv0TZAJLXc9qlSD2Fok1WrVA7XWM67a807MVWUd+sfv+7CWAUEyLaKWdymQEkXtTuCVqrVeBX5V5jKEnaqA7Q8SF1DMFt5LFzJxsAtGRGW4ilA/rCJ4Xujwf3fKpj0sLveJaLG1/HDPPw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by VI0PR04MB10782.eurprd04.prod.outlook.com
 (2603:10a6:800:25d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 03:23:24 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 03:23:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Anson
 Huang <Anson.Huang@nxp.com>, Stephen Boyd <swboyd@chromium.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: fec: Propagate PTP initialization errors
Thread-Topic: [PATCH net-next v2] net: fec: Propagate PTP initialization
 errors
Thread-Index: AQHdO4YioAnO3amvG0aIHgRDjya4dLa8lc+AgAAVsYCAAPvFsIAAFaoAgAAE8kA=
Date: Fri, 4 Sep 2026 03:23:24 +0000
Message-ID:
 <GV2PR04MB117399ABD55B1D65AAB8EA42E88B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260903092430.354186-1-phucduc.bui@gmail.com>
 <GV2PR04MB117394049F412AAAC59FE93FE88B62@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFD1+GJiWdyxiuGVRzKjpCUfu3TQHYOLnOym3hHzOM2tg@mail.gmail.com>
 <GV2PR04MB1173931CA07AEAB48339FF71588B52@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <CAABR9nFi06-7=uHmOBFGZv1eUYCskv8WspOdUxbDuQ6vMk68Dg@mail.gmail.com>
In-Reply-To:
 <CAABR9nFi06-7=uHmOBFGZv1eUYCskv8WspOdUxbDuQ6vMk68Dg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|VI0PR04MB10782:EE_
x-ms-office365-filtering-correlation-id: 8bfe5008-4908-42e8-d213-08df0a33e0c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|23010399003|38070700021|56012099006|4143699003|11063799006|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 H1WdDboXqek92dW0/Un4sNVCqRbhGi7M5DS8ZQ24pM5IzLF/4oKI7p0XhohosKXCGkg0zYZ2IRfIG46uCXi2VE6oddYYXZm8y/uEzr4e+EOWyDyyCO+vRkXWureLoFZltU9VsWkWLMWUazkWsuyXyeljOvoiIHn+HOBlYaQtDgH2PEMBgMGlYvlXzVqIvnN6cfNLfZlw3BG20fAzRYuCOeEQVLz6B5MOO+pJOgKDYA164RddenCVKLTGCvNsUoSeHCrPTYjZoa+zhRGTmWbWZ5NwBqVkmu92niECT3C42zwojpA9qCvkA50kRb14osn6AUOp21mT8WCCG/4MXnoixjX7PXhpoxly2kArNyrg+M45McdGlQZbcZilmzldfzaC+n90AKPLML7mkcfT/CUt64Io9eVqPWJOnav9qcz2CgNwpEEWl4eVRFUks1VSFLd9sKemsswYxhhaVnDorT+hnZsZ4kqPXUsz+i72rkrgS+F8eXAUmpcbK1UlX/jAeg3OGVXqQ+038hkGAmmfaGVW80NOPx0Gnvq82puO6KLjX9PW020fzp+xqcWvu9YpyEm04wcSF6igfC6l3O4DiDpI5i6wHKfAN+6ysmxU6mhAmTbYC+X6krXCg1AMDAoOPt7BLbjcbIcF1QuhKDfU8ZhNSPFWfDLyaHddfcjLQxkZLZX8iVSUnB+9rDqo1J7PxFlpaeUUM6V5X8NFdB3JB1PQXsmzVEJPybvnIcLPOZSgNY0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1NkWldpaXcrczZadldoRVVrZDMzN05JMW01YitjWmREWGQvbWZjRE9HTG5l?=
 =?utf-8?B?M3lEUlZscjRVZndWYlhSV2lsMUQvdll1WkkzcGpSNkdWL0dSSGpxM3F6ajdw?=
 =?utf-8?B?Sk1MU0lBNkhvRCtkQ2MzRTl3T1hiTlNVUkQ0Z2duUUVMUVJCZ1VidGJQTTc1?=
 =?utf-8?B?NlI3SFNNdkpoc0VjTTIrOVAwNHRBQ2xmemlBRU4rOHZQL3RSZ0dKVlNuQzl3?=
 =?utf-8?B?NEpwT3hkTU93dTZxTXZnM21Oa25mNXBiajZSREl2dlpURlNyM3YyVDZWRzR6?=
 =?utf-8?B?UHZwd1p2N1QyWVA4VVVXVDFwK2M4bSthd1ZqZGJXYzRIQjNaREhFMDRiU3FI?=
 =?utf-8?B?Vll6M0F2SVBwZ1A2TGdTcklqU1dUQkt5L01lNElLMTRCd0MxTDVCNTliNlJH?=
 =?utf-8?B?bGZkakxmRVpmSHNIUnY4a3QvUFEyVTJSMlQ2VTIyNzJFaklmcW9nM3BMaTRn?=
 =?utf-8?B?a2F1M0lsdFliMGRkanZwZ0M5NDdzWjJOYmJ4QmUvZ1VrMzV2dk1OdnFqdmVr?=
 =?utf-8?B?Z3BiWjllekpRTnVYbVRTbzVrcENnUlFTbHJzV3N5QWVwdGVJRzlHVldMR2tP?=
 =?utf-8?B?M3FkNGw5L2c0R2tIb2o0ZWtQeEFuVktoZGxYdmNZZkRZSUd1b1Y2NFdqQzU5?=
 =?utf-8?B?dVlTNlVnaTJZa0t0dXp0OGZPODJFRHdKM2svdW92Ni93NjRReThZTnlxTk4v?=
 =?utf-8?B?NDFyRTRWSW01SkxLVm8rbE5lZlQvUjNkcEJFd0UxT3JVdEJKdHNDTHNWaFpE?=
 =?utf-8?B?eEtJbkt0TmY1ZG9WeUw3MWY0S2xPZnp3bTdsciswWlcraDJESFpGeFNsUVRr?=
 =?utf-8?B?dXFnMDRzNi9LYkxhZkFPaUVTYXZ0L0VDMVpYVzVLQ244SHArbXhtTGlUU3ZN?=
 =?utf-8?B?OE1YTjhnZVVpZW15ekRvRlBPaUtSQktjaWc4dm9INUVRVlhOOUlzSDBTZ3FU?=
 =?utf-8?B?Vk9sdjIwdGxKK0RqUW4xNDM4MFlubXZHZit6VDdrOXEwaDRjZXYzVmpBYm9p?=
 =?utf-8?B?THNnYm5NQ1hVcTRYd2dQNFRTRm5xRERlYzhDbXgvbEE5L05zekprTERLTXNW?=
 =?utf-8?B?N29tZGIyVWlFcG8rMk1DY0lhNUdmUDVsSDR1RDR3YmVGMm9wWTFXenp1T3BS?=
 =?utf-8?B?VjVLQVQ0c3B1QXo3RU5lWFdFNzh5Tm5VOUFGNTR3TzBSbEZiVk5IczVFTVFk?=
 =?utf-8?B?b0I2VEFMSTdvK0dmOGozL2gwUVVvTy9BREFRZ2ZwK0RIR2poWmU5QnU3WlVM?=
 =?utf-8?B?dXR0QnYyanJkS1RHanNWTmp0R2wwdmRXU1JSbjhkZGxxQnBoSW0ySk5PTGVw?=
 =?utf-8?B?QXZKZVRQVlFhVmZ4UGtJS25VcVFNbVgwQnBCaUF6R0E2NXIwNHU2VHpsMmRq?=
 =?utf-8?B?VTYwSVFHUEsybU1qMjRWWndPWkQ3UTUvUUZQdkR6OEcyb2FQS3ZHNVpoL2wz?=
 =?utf-8?B?eUdweVhtV2FDMXRtRVZWdS9KenRuSk9PMWhOVXprNHFmQTlpVGs4MmduTEVM?=
 =?utf-8?B?MnZ0NHZaNnJ4OUlHaHFmZUc3Y2FpcFd6R3B0djZaL1JIR1dKU1N3WWozYWE2?=
 =?utf-8?B?ZHgwdUU0aHdPYWN1NVphMWMvUzlaS2Rybm15RDNZWU1DMzVScUluWVhLVnJM?=
 =?utf-8?B?WnZZcFlCblRCQXFqWjhCbVAyeUlac2sxWGFXOWdndy9oVGFGL3JjV1lzeWVO?=
 =?utf-8?B?Y1hSajFya3RrMHJCbmpoalBqSC9zS1ZOTTdkU2h1NlVuWXduZ2VMZnhPL1Zj?=
 =?utf-8?B?OE5ORG9uWnVadENPblpYejdLVVNZZTNPclFGbW9ERjVVY1JjV0duMEMvR2gv?=
 =?utf-8?B?SmczY2c4a3FzaFQrdDZNQXgwbzhjNTl6VHJkM09WbUs3NWFRODF4eE56Qml0?=
 =?utf-8?B?TUZ3Nkw4U0lnTDQwM3V6UThMK1h1SmRRTkVYTEVGZ0d6YUlQWHVQN200Wnov?=
 =?utf-8?B?U1J6czcxbUxFOUFFNjlTYTFibEI4NDBITXlmSEg2RktMeTc0V1VRUkxBcjJ2?=
 =?utf-8?B?RG4rNkpFS2QyaHBrRXFkeW9OQVRwS2lMckNtTHp3eUc2Q20wb0J5K3pqQlMr?=
 =?utf-8?B?V04yaExET1dkZlNLUnJhS2NEcDJMRWY0S3FxZ2NvdUs4a2FJcUY5b3ZIdUx1?=
 =?utf-8?B?Ty9QTEhuQ0p3cGhjRU9OazRiL21oVzdmeFhmbWtEcllKbzFwTE52TlI4TG1L?=
 =?utf-8?B?M1dvSWtKblRrVGZVOFJrbndLdDZPRXBXRTJLcUIyUGlZdERGNCt0Z0h6d0xJ?=
 =?utf-8?B?dWNmY2ZOL1c5dHBmOHZmUzJ0SHFBdXhMUnhyc3VLbVRWS2ZvdTVZVVV6NTJU?=
 =?utf-8?Q?pA7gb5Tl5APt2EGPbs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfe5008-4908-42e8-d213-08df0a33e0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 03:23:24.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvxBo1YeUmjYA2ShCxxRlWCKcBEtyFLYdAfxfHd9CdO7mZrrNRo5wIkSAhSyeEMPGPzGlTd5UcgN4D8strPEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10782

PiA+IElzIHRoaXMgYSByZWFsIGJ1ZyB0aGF0IGJvdGhlcnMgcGVvcGxlPyBvciBqdXN0IGFuIGlt
cHJvdmVtZW50Pw0KPiA+IEZvciByZWFsIGJ1ZywgSSB0aGluayB0aGUgcGF0Y2ggc2hvdWxkIHRh
cmdldCB0byBuZXQgdHJlZS4NCj4gPg0KPiANCj4gSSBjb25zaWRlciB0aGlzIGEgcmVhbCBidWcg
cmF0aGVyIHRoYW4ganVzdCBhbiBpbXByb3ZlbWVudCwgZm9yIHR3byByZWFzb25zLg0KPiANCj4g
Rmlyc3QsIGNvbW1pdCBiODZiY2IyOTkwOTIgd2FzIGEgYnVnIGZpeCBhbmQgd2FzIGFsc28gYmFj
a3BvcnRlZCB0byBzdGFibGUuDQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGVycm9yIGhhbmRsaW5n
IGluIHRoYXQgY2hhbmdlLCB3aGljaCBpbmNvcnJlY3RseQ0KPiB0cmVhdHMgZXJyb3JzDQo+IG90
aGVyIHRoYW4gLUVOWElPIGFzIGFuIGFic2VudCBvcHRpb25hbCBJUlEuIFRoZXJlZm9yZSwgSSBi
ZWxpZXZlIHRoaXMNCj4gZml4IGlzIGFsc28NCj4gcmVsZXZhbnQgdG8gc3RhYmxlIGtlcm5lbHMu
DQo+IA0KPiBTZWNvbmQsIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGNhbiBzaWxlbnRseSBp
Z25vcmUgLUVQUk9CRV9ERUZFUiBhbmQNCj4gY29udGludWUgcHJvYmluZyBpbnN0ZWFkIG9mIGRl
ZmVycmluZy4gT24gYW4gYWZmZWN0ZWQgcGxhdGZvcm0sIHRoaXMNCj4gY2FuIHJlc3VsdCBpbg0K
PiB0aGUgUFBTIElSUSBub3QgYmVpbmcgc2V0IHVwLCBjYXVzaW5nIHRoZSBjb3JyZXNwb25kaW5n
IFBQUyBmdW5jdGlvbmFsaXR5IHRvIGJlDQo+IHVuYXZhaWxhYmxlIHRvIHRoZSB1c2VyLg0KPiAN
Cj4gSSBkb24ndCBoYXZlIGhhcmR3YXJlIHRvIHJlcHJvZHVjZSB0aGlzIHNwZWNpZmljIGNhc2Us
IHNvIHRoZSBpc3N1ZQ0KPiB3YXMgZm91bmQgYnkNCj4gY29kZSBpbnNwZWN0aW9uIHJhdGhlciB0
aGFuIGEgdXNlciByZXBvcnQuDQo+IElmIHlvdSB0aGluayB0aGlzIGZpeCBpcyBhcHByb3ByaWF0
ZSBmb3IgdGhlIG5ldCB0cmVlLCBJJ20gaGFwcHkgdG8NCj4gcmV0YXJnZXQgYW5kIHJlc2VuZCBp
dCB0aGVyZS4NCj4gDQoNCkl0IGlzIGEgcG90ZW50aWFsIGlzc3VlLCBzbyB0aGUgdGFyZ2V0IHRy
ZWUgc2hvdWxkIGJlIG5ldC4NCg0K
