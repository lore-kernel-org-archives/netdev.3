Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06E45040C;
	Fri, 31 Jul 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521415; cv=fail; b=nA2R763X3lXRYwr4Q7M+4pAnQUZy7HgG3HFqmZBN9KtX2ApYcFrTEvupZIKKl5Xn01f/0mNen68eCG30TA4T9xnaXLYQgtaNa21+dhrhOWoZpKC069ZNmHLwaG+rlj8isKc4fYjBRZjeOSmtE7QqMz+IYixS4iNIN6a4i5sl500=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521415; c=relaxed/simple;
	bh=9mhc1qEmyDYBkqNh9u7d0caezGA8ZVH67eTSH/OvXLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGm5NP2ksrHnbPd48ODKRQ0fJJFL+7uPBpvpFoba2aQ5V3/WhEo8kn5lMB0q/CyPU+nBgz2UDksduxWkAffuiTfA2S5vTZdRMRIVb2iwGxDFPmDjVz6o405O6TMThPH+4p35Z+5++i0hLoDR1GdLIvtU+krNd7RwIYIINZdrdsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=MFjIIuNi; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=mbMJt6Ij; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="MFjIIuNi";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="mbMJt6Ij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=pqBEJd7horjX8tk+CGq0AWuuIciTUAp9nemg4kpkNeA=;
 b=MFjIIuNiA7JWFgN8kxaxBRA4PE+PUrovSXf7rdRb1Z40HLEHOdMNFkTnW/TRYqZb6SSwCpnlKGneyRm1f3EYnQDgHwO5x3vE9L9sHtZPjTPnbAgzt7V+YT2qMLPs4DUtJnOWdetK9KpTKEoEZpWmFYpHpLCJ8h6OAtf8k/f44u5vvcA6nUWUxXdYl+OUb4pjYArqx1lAb1ziMJ9P3c/bxZ8aNgNRoQdeXVNKi63MG99hD0HZ5WW4UnJLht3InZg1GsGSz5NDPpPWB3B1Lk5M9NOf2nvsw8w1y8aV8hZC5qqikMRP+P4N7ZQnIRvX4dg8G0gf1xLdJ5IzB6wHYmzERA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021127.outbound.protection.outlook.com [52.101.52.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2C6CD400067;
	Fri, 31 Jul 2026 18:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6VQ9SwCX1Jszk7nTO+sGGcNBvO55VQJa/QpglE8InpqsGPh9pBUJCdY7YcUHFi9hsVA/4zCgonpii5xrm7OuzpuFgm9z+3mxKzVRvnwhz3eb5q2jaj0KEYs3/NOzBJ2amCj2pINwl/xCwsbFL8T0QEU1Fv6t50ebdu+GWT35rx8XxWvlLkgnsSVr4XlBlQorqTAyrhLlEOF1uyi0job+DMcsi6C3wi7MW3Lnm4uCvojh/4BDYVLqtiE2XjVU0/vkn3us/Po/bIZYmaJJXZc436wcqIWyrYsJ9hvhfgsfi56qK3HZMu5fYXLsTlTiFqnw5b83T2A1e/Vv4x6OC+zXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqBEJd7horjX8tk+CGq0AWuuIciTUAp9nemg4kpkNeA=;
 b=bcB1gmcSZHCnmjZvrQWEsggaZWIUmGwFAzYW1tYhWuHrDci0RM5kNosRHZEr36ENz/8HrOqkaSgcs+a1U92nulY4mMoB5/a/msgphNBq49PiXya+8PAPR+ydT0bA5M0KpdSX2hcQuF/brEw/HU7LfGpRv1MOC2raOBcVRlc0h84Ut51PL0bv3C82j8o/DGWTz/wnAQGw0XkhcKKkTIYsOIABiZAR9zOp3D9FOU8HHHHg29Z+0YlBYBkhig3mEj4b8b8ppP7jRsfeAk3p3C7Ha7EryN5YuCOMkBmPUq2S9ivnxueqTapZr1uJ6ES/953TPxTlkzskw2MEGmofUFIvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqBEJd7horjX8tk+CGq0AWuuIciTUAp9nemg4kpkNeA=;
 b=mbMJt6IjKwTz32x1AhajTQERvlSPz+7LtZdDxcnBCth2kDqu0CAiH1diR9k47l1RVADABf+WKUaKDly7JjrzOpv3Yb1ZYGy9EK+5tD1/zbmJlpp3LmQr8LrpbHiLRObZMAUBiDYRGDRq1Fab21r/1Ri0R7OfmIPh5AbIZh56USiHTz6Tt1HW8UpznQYYsEWg29M57rco7Fm/8+O6sXstwyiA5t1Qln0hUF3+5TXzOElbQ7T+v8UqJ4gLCU/sXGfrlrkV8STmwoDpw/01FMCGj8tuUG3oVTaD+nVVkfT+uV6LNYVU0uGdzdiL+7inJARqWiYHvzWWePpvvL5oqYDjjQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH7PR20MB6618.namprd20.prod.outlook.com
 (2603:10b6:510:278::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:09:55 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:09:55 +0000
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
	<arouhi@sitime.com>
Subject: [PATCH v3 net-next 3/3] dpll: add SiTime SiT9531x DPLL clock driver
Thread-Topic: [PATCH v3 net-next 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdIRfKTzNqeaJZl0CocabEWYpFEA==
Date: Fri, 31 Jul 2026 18:09:55 +0000
Message-ID: <20260731180951.65725-4-arouhi@sitime.com>
References: <20260731180951.65725-1-arouhi@sitime.com>
In-Reply-To: <20260731180951.65725-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH7PR20MB6618:EE_
x-ms-office365-filtering-correlation-id: a5b9d0b9-6c31-4935-35d2-08deef2eecb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|18092099006|18002099003|22082099003|3023799007|6133799003|10067099003|5023799004|56012099006;
x-microsoft-antispam-message-info:
 RGefuLQJP64w8wYIN8eqstGfQMCTYFpSRKC98L48LJQoea13hGshIEA0UsMEjT5+qIVP0uLLEOrPI0lUznwwhx8dfcOrcr2lIbNZlKFAS9E8t9RlPAZf2RHisbG4yWzOYQYrfvqs/mqtHsNuTdyCa1dvd4tI4BCjIZRpH+tNjGAjMXt1KWNB+KWDTwUmPdIrhBmFwkADacYgJTlVhExGVJQb4sOBhcKEj0+Uu+8he6D9y3en+Yhw7ISKKu+Iez+rnn9eNE5oFzdF+jj+zVQWBxakijJ1XAiDL6RDAlc0L+dD/DOu15pdacAre85hyUfEecT7PX9azu13ujOC6VpU4gMVQdGUFJEKCx/kNrfbpTB2dk3dYuCN2hB0zV85g5yyDxgJ9P/OanSQnIRGy/65n5iS67lqJwLLIalXRUaaASVWrAPNznL/f7tfjieC2LHdQwqBigrNxrl0QEnA6ofAsrfjkHDeifNrv9Umyt9fBYlkN9j4yEshHpCKfKnnbFbUqEeaA5yXIKykjYbchCmztwZB9mwHZ7peN7phciNGd+p8sMYWfxO4CCGjgS66nc+LUOl25CPbltN2q9bCnE07haDSkO6CXMhP1hWt3u2XQZ3Y/G4f4DJFteOlz/9pB6hKWGJguaqWbYDbmDs4gE1MGhBkvDKDn+L4VQUaU0GzPCM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(18092099006)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eM1OP5hgRISmsb+CaewJPiHUNGb5dzlZtBhhMOl+8Wd8THeGrYsIjpc9cS?=
 =?iso-8859-1?Q?tQZxlQlGIcamwd2uhJVQvrbPW/lzbJlnpB6mR9ucJn2RA97csOyeSeL5zg?=
 =?iso-8859-1?Q?B2gXIhvVKe8yrbyGpbCMuGE0WYyN3wUjlFtxUubKXS6ouWu5yMV08YLWoc?=
 =?iso-8859-1?Q?vZUShEUNTFdPg0F+usWSt7Ba3YOkknALZEqot7dcdd0yoo5JshLXwYxkaQ?=
 =?iso-8859-1?Q?AezpwxB85THv0P2b3pSqcR3uPLKg80C8sm9tN0YP4jId5PNRzEBCaabuXX?=
 =?iso-8859-1?Q?/OIvFI+XZA+R/4zMH5VnVWwrgkRH5birEZXJ8G9ABdsm/sUjAfy9Si7nAH?=
 =?iso-8859-1?Q?V/fireU8cQew7NghwakjD2rOrMqQarl7D6DIfGasBC8brqoZPc5czb0nBE?=
 =?iso-8859-1?Q?HjpWczs6Cs/ebONs+Wm0Tsbmqx5wBixKHWXvUDVBaa6uAOVSPv2a2sTchK?=
 =?iso-8859-1?Q?CPw37O4+c7hRI3AyrwxVnRNYQb5A9/Te5B96vK1P4a/g3um9X8veBaRvt/?=
 =?iso-8859-1?Q?Bro/NegaO3Qz44arDZgbXNisNdCmix3Zf1ZrJFRP87DwKFhjxv0G6gbUqq?=
 =?iso-8859-1?Q?wnGb5K/rZ5akEh1SoWqUm5BHa/90O8TMbplgDYW71VdTweT2Am4e8L2rgl?=
 =?iso-8859-1?Q?75zCJ9OYwGVtPLTiuplKzfHBg5C8S2VjL1EFB88YNEeDf6O/Jqpj47j6HV?=
 =?iso-8859-1?Q?hdF2ShjkyF0i7WgpwM4Y3kDsE865D9cETiaTAOpadBK2Vhtik9Y0n29P29?=
 =?iso-8859-1?Q?H587IstlR9dUwyeBbKTrw0GMVVQ1/4OC1Jcty16aIMn/6rh6BuL0OcDsh9?=
 =?iso-8859-1?Q?T8qzq34p6aSOUDYL6HSpfUB6rodV1P1QQ4XrI/xJcrdENR7cSqsoQNVWYP?=
 =?iso-8859-1?Q?v4O03L2k/pH3pf7SGuVXsofy3lTECNhlW/nEPzGEPu+24nE4ZlA5uj/4Ke?=
 =?iso-8859-1?Q?ZH7ii2Xa1AQX/frGkqMpObu0R9w0+ROYVS9IZmhrWcLfcfSMgy1WS+okX/?=
 =?iso-8859-1?Q?45oiz/uhNFFN+zMxfWedp+W1B5nr6pHiI2zR2TdanpAKfeRuiJTClrScpn?=
 =?iso-8859-1?Q?40Vpz/tuxSHdorZhf43c9nsO6n6lSx0dKHyqatNm15qmSRZWEiHDwjDaz8?=
 =?iso-8859-1?Q?vGR9AeR22YLn7+ezUtXz3iFzy4mBWJ9ZZ0/m9115Cpjfr5jmn1zIYdxR8q?=
 =?iso-8859-1?Q?bHuOQ8rgh9c5/ZY8TWAY8T8yWJZJ6iRt9aM7fwwFPTND4fh0tfXkXk9P84?=
 =?iso-8859-1?Q?CAr4o31R6gcFbsTITfWNxtihoyGuPNs+Cfnoj2mKU4Vt2T6Fs4g3t5SsSV?=
 =?iso-8859-1?Q?fKwl6pNP7aZ4Ipa8PUb3A1M//R5smF1nJ5iTQ5NQgmVfIviQ1TmNqMVvQ3?=
 =?iso-8859-1?Q?zcMqWb2ApJX47w20EqiycEtegsWCFNyIrcAsY9/Ftjdk+CAguWsNWVAowd?=
 =?iso-8859-1?Q?6wDxGWtIMCZMiNa2rDwTivpanHzdVMtoRFRcNJ10mYmhTJVUcITLbHsAWH?=
 =?iso-8859-1?Q?xApx9Brrc4EXNhkwPGb4WA70uoRTHSBaqCol1YklOdD06gboUE5w/+f4Fo?=
 =?iso-8859-1?Q?qYE4+OI7FGLBIAi5Jeaa2QWknuVkDUbF+OPwTeHpQrRXGxKD3p1DWU1l/q?=
 =?iso-8859-1?Q?MmWSlPPh5oZsU/HaV2EOLjWiaehVsZ6kZXYHsk4Z38CTu+28/GYMAhzjWG?=
 =?iso-8859-1?Q?SRBKvVq2/d+yFwwCGXpqa8yIEFlOf+H8Eu+DlR0JDu1qWBWIZor+VxFl1Q?=
 =?iso-8859-1?Q?QN5VJTou0eGBGoLKLjT22NJZ8wLljMPR1KY4aA9J29BsrL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nmoa0l6DpBK89uBFCMAOipH97hsyNQ17kwG34bC01sd/MIDlu60f6i7Vh815Ae9htWbCiwtAOd7g4LtV2KZLAb/apT7jZ4NaY+nU6GzzQ2JnLbZuDVkfVCDm5yG4zeD8+RnBdIV9RfovnVkmgxYOmR5DvT+Q2zqmQhtenq2qHJyqSBf4XFbpXU77BOqCFK6sAQFjHVrxXxdoWAQFckvJUoHwuJ6YbspmUoIhpGMR2I0dgBbBWQsIEfyk2PR3cGxhcFvnP+eHGk4GwoxHRMJ9m2wweIpQfzwu/cU/Nvt6cW0LEZz1VSIBbyTbPTt018es/48UO9lSjvDKyvXmC2leAA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b9d0b9-6c31-4935-35d2-08deef2eecb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 18:09:55.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNPY9fS4OXHSkkL2N9F2uvRcjoLGzy0p6EtmrDurz3m0g8A5rJ2I2IQNLnA2DQXU49dtscOzuQvvzHVCYyXfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6618
X-MDID: 1785521402-ut4n7ssHt7lV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1785521402;ut4n7ssHt7lV;<arouhi@sitime.com>;3996c0438aeafc66d5842742ecf5d65f
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317
clock generators. These devices provide low-jitter clock outputs
commonly used in telecom, networking, and data center timing
applications.

The driver exposes all inputs and outputs through the Linux DPLL
subsystem, supporting:
 - Lock status monitoring via register polling or optional INTRB IRQ
 - Input priority management for automatic reference switchover
 - Per-output frequency readback from hardware state
 - DCO (digitally controlled oscillator) frequency adjustment
 - Phase offset measurement via TDC (time-to-digital converter)
 - Phase adjustment for fine output alignment
 - Embedded sync (esync) pulse control
 - SYSREF/SYNCB/Pulser output mode control
 - Optional reset-gpios for hardware reset

The driver reads all configuration from the device's on-chip NVM
at probe time -- no firmware loading is required.

Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
Assisted-by: Claude:claude-4-opus [chat]
Signed-off-by: Ali Rouhi <arouhi@sitime.com>
---
 MAINTAINERS                    |    7 +
 drivers/dpll/Kconfig           |    1 +
 drivers/dpll/Makefile          |    1 +
 drivers/dpll/sit9531x/Kconfig  |   17 +
 drivers/dpll/sit9531x/Makefile |    4 +
 drivers/dpll/sit9531x/core.c   | 3609 ++++++++++++++++++++++++++++++++
 drivers/dpll/sit9531x/core.h   |  388 ++++
 drivers/dpll/sit9531x/dpll.c   | 1580 ++++++++++++++
 drivers/dpll/sit9531x/dpll.h   |   87 +
 drivers/dpll/sit9531x/prop.c   |  415 ++++
 drivers/dpll/sit9531x/prop.h   |   39 +
 drivers/dpll/sit9531x/regs.h   |  419 ++++
 12 files changed, 6567 insertions(+)
 create mode 100644 drivers/dpll/sit9531x/Kconfig
 create mode 100644 drivers/dpll/sit9531x/Makefile
 create mode 100644 drivers/dpll/sit9531x/core.c
 create mode 100644 drivers/dpll/sit9531x/core.h
 create mode 100644 drivers/dpll/sit9531x/dpll.c
 create mode 100644 drivers/dpll/sit9531x/dpll.h
 create mode 100644 drivers/dpll/sit9531x/prop.c
 create mode 100644 drivers/dpll/sit9531x/prop.h
 create mode 100644 drivers/dpll/sit9531x/regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 932ea1db048e..eff783481b2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24912,6 +24912,13 @@ S:     Maintained
 W:     http://www.winischhofer.at/linuxsisusbvga.shtml
 F:     drivers/usb/misc/sisusbvga/

+SITIME SIT9531X DPLL DRIVER
+M:     Ali Rouhi <arouhi@sitime.com>
+L:     netdev@vger.kernel.org
+S:     Maintained
+F:     Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
+F:     drivers/dpll/sit9531x/
+
 SL28 CPLD MFD DRIVER
 M:     Michael Walle <mwalle@kernel.org>
 S:     Maintained
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index be98969f040a..ea77b9c11ab1 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -23,6 +23,7 @@ config DPLL_REFCNT_TRACKER

          If unsure, say N.

+source "drivers/dpll/sit9531x/Kconfig"
 source "drivers/dpll/zl3073x/Kconfig"

 endmenu
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile
index 9e7a3a3e592e..4adc50d748d4 100644
--- a/drivers/dpll/Makefile
+++ b/drivers/dpll/Makefile
@@ -8,4 +8,5 @@ dpll-y                  +=3D dpll_core.o
 dpll-y                  +=3D dpll_netlink.o
 dpll-y                  +=3D dpll_nl.o

+obj-$(CONFIG_SIT9531X_DPLL)    +=3D sit9531x/
 obj-$(CONFIG_ZL3073X)  +=3D zl3073x/
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig
new file mode 100644
index 000000000000..47aea8674327
--- /dev/null
+++ b/drivers/dpll/sit9531x/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SIT9531X_DPLL
+       tristate "SiTime SiT9531x DPLL driver"
+       depends on I2C && NET
+       select DPLL
+       select REGMAP_I2C
+       help
+         Driver for SiTime SiT9531x family clock generators
+         (SiT95317, SiT95316).
+
+         This driver registers each on-chip PLL as a DPLL device
+         and exposes input/output clocks as DPLL pins, providing
+         runtime configuration via Generic Netlink.
+
+         To compile this driver as a module, choose M here: the
+         module will be called sit9531x.
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e
new file mode 100644
index 000000000000..b97d2656a460
--- /dev/null
+++ b/drivers/dpll/sit9531x/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o
+sit9531x-y :=3D core.o dpll.o prop.o
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
new file mode 100644
index 000000000000..fecea4201e4d
--- /dev/null
+++ b/drivers/dpll/sit9531x/core.c
@@ -0,0 +1,3609 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiTime SiT9531x DPLL core driver
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * Core I2C probe, regmap configuration, hardware state management,
+ * and periodic work thread.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "core.h"
+#include "dpll.h"
+#include "regs.h"
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Chip variant table
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \
+       { .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), =
\
+         .name =3D (_name), .clkout_map =3D (_map) }
+
+/* Per-variant output index -> physical slot mapping */
+static const u8 clkout_map_95317[] =3D {0, 3, 4, 5, 7, 8, 9, 11};
+static const u8 clkout_map_95316[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, =
11};
+
+static const struct sit9531x_chip_info sit9531x_chip_ids[] =3D {
+       SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317,  8,  8, "SiT95317", clkout=
_map_95317),
+       SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316,  8, 12, "SiT95316", clkout=
_map_95316),
+};
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Regmap configuration
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+#define SIT9531X_RANGE_OFFSET  SIT9531X_PAGE_SIZE
+
+static const struct regmap_range_cfg sit9531x_regmap_range =3D {
+       .range_min      =3D SIT9531X_RANGE_OFFSET,
+       .range_max      =3D SIT9531X_RANGE_OFFSET +
+                         (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
+       .selector_reg   =3D SIT9531X_PAGE_SEL,
+       .selector_mask  =3D GENMASK(7, 0),
+       .selector_shift =3D 0,
+       .window_start   =3D 0,
+       .window_len     =3D SIT9531X_PAGE_SIZE,
+};
+
+const struct regmap_config sit9531x_regmap_config =3D {
+       .reg_bits       =3D 8,
+       .val_bits       =3D 8,
+       .max_register   =3D SIT9531X_RANGE_OFFSET +
+                         (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
+       .ranges         =3D &sit9531x_regmap_range,
+       .num_ranges     =3D 1,
+       .cache_type     =3D REGCACHE_NONE,
+};
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Register access helpers
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * sit9531x_read_u8 - read an 8-bit register
+ * @sitdev:    device pointer
+ * @reg:       register in SIT9531X_REG(page, offset) form
+ * @val:       output value
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+                    u8 *val)
+{
+       unsigned int tmp;
+       int rc;
+
+       reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +
+             SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;
+
+       rc =3D regmap_read(sitdev->regmap, reg, &tmp);
+       if (rc)
+               dev_err(sitdev->dev, "Failed to read reg 0x%04x: %d\n",
+                       reg, rc);
+       else
+               *val =3D (u8)tmp;
+
+       return rc;
+}
+
+/**
+ * sit9531x_write_u8 - write an 8-bit register
+ * @sitdev:    device pointer
+ * @reg:       register in SIT9531X_REG(page, offset) form
+ * @val:       value to write
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+                     u8 val)
+{
+       int rc;
+
+       reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +
+             SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;
+
+       rc =3D regmap_write(sitdev->regmap, reg, val);
+       if (rc)
+               dev_err(sitdev->dev, "Failed to write reg 0x%04x: %d\n",
+                       reg, rc);
+
+       return rc;
+}
+
+/**
+ * sit9531x_read_pll_u8 - read a register on a PLL page
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @offset:    register offset within the PLL page
+ * @val:       output value
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+                        u8 offset, u8 *val)
+{
+       return sit9531x_read_u8(sitdev,
+                               SIT9531X_REG(sit9531x_pll_page(pll_idx), of=
fset),
+                               val);
+}
+
+/**
+ * sit9531x_write_pll_u8 - write a register on a PLL page
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @offset:    register offset within the PLL page
+ * @val:       value to write
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+                         u8 offset, u8 val)
+{
+       return sit9531x_write_u8(sitdev,
+                                SIT9531X_REG(sit9531x_pll_page(pll_idx), o=
ffset),
+                                val);
+}
+
+/**
+ * sit9531x_update_pll_u8 - read-modify-write a register on a PLL page
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @offset:    register offset within the PLL page
+ * @mask:      bits to modify
+ * @val:       new value for masked bits
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+                          u8 offset, u8 mask, u8 val)
+{
+       unsigned int reg;
+
+       reg =3D (sit9531x_pll_page(pll_idx) * SIT9531X_PAGE_SIZE) +
+             offset + SIT9531X_RANGE_OFFSET;
+
+       return regmap_update_bits(sitdev->regmap, reg, mask, val);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Input enable / disable
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * sit9531x_input_get_regs - get force mask and state register addresses
+ * @sitdev:    device pointer
+ * @index:     logical input index
+ * @force_reg: output force mask register address
+ * @state_reg: output state register address
+ *
+ * Selects the correct Page 0x02 register pair based on the pair's
+ * signal mode and the lane (P/N) the index refers to.
+ */
+static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,
+                                   u8 index,
+                                   unsigned int *force_reg,
+                                   unsigned int *state_reg)
+{
+       if (sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE) {
+               *force_reg =3D SIT9531X_REG_IN_DE_FORCE;
+               *state_reg =3D SIT9531X_REG_IN_DE_STATE;
+       } else if (sit9531x_input_is_n(index)) {
+               *force_reg =3D SIT9531X_REG_IN_SEN_FORCE;
+               *state_reg =3D SIT9531X_REG_IN_SEN_STATE;
+       } else {
+               *force_reg =3D SIT9531X_REG_IN_SEP_FORCE;
+               *state_reg =3D SIT9531X_REG_IN_SEP_STATE;
+       }
+}
+
+/**
+ * sit9531x_input_disable - disable an input reference
+ * @sitdev:    device pointer
+ * @index:     logical input index (0-N)
+ *
+ * Sets the force mask bit and clears the state bit for the given
+ * input, effectively disabling it.  Register selection depends on
+ * the pair's signal mode (SE/DE) and the lane (P/N); the bit within
+ * each register addresses the input pair.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)
+{
+       struct sit9531x_ref *ref =3D &sitdev->ref[index];
+       unsigned int force_reg, state_reg;
+       u8 pair =3D sit9531x_input_pair(index);
+       u8 val;
+       int rc;
+
+       sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);
+
+       /* Set force mask bit: enable override */
+       rc =3D sit9531x_read_u8(sitdev, force_reg, &val);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));
+       if (rc)
+               return rc;
+
+       /* Clear state bit: 0 =3D disabled */
+       rc =3D sit9531x_read_u8(sitdev, state_reg, &val);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));
+       if (rc)
+               return rc;
+
+       ref->enabled =3D false;
+
+       return 0;
+}
+
+/**
+ * sit9531x_input_enable - enable an input reference
+ * @sitdev:    device pointer
+ * @index:     logical input index (0-N)
+ *
+ * Clears the force mask bit for the given input, returning it to
+ * hardware default (enabled).
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)
+{
+       struct sit9531x_ref *ref =3D &sitdev->ref[index];
+       unsigned int force_reg, state_reg;
+       u8 pair =3D sit9531x_input_pair(index);
+       u8 val;
+       int rc;
+
+       sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);
+
+       /* Clear force mask bit: return to hardware default (enabled) */
+       rc =3D sit9531x_read_u8(sitdev, force_reg, &val);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, force_reg, val & ~BIT(pair));
+       if (rc)
+               return rc;
+
+       ref->enabled =3D true;
+
+       return 0;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Output enable / disable (Hi-Z control)
+ *
+ * SiT9531x outputs can be configured as differential (DIFF) or
+ * single-ended (SE) depending on the factory blob.  Each output slot
+ * has TWO Hi-Z force/state register pairs on Page 0x03 -- one for the
+ * DIFF path, one for the SE path.
+ *
+ * We write to BOTH pairs so the function mutes the output regardless
+ * of whether it's been configured DIFF or SE on this board.
+ *
+ *   slot 0-7 :
+ *     DIFF mask=3D0xF2 state=3D0xF3   SE mask=3D0xF8 state=3D0xF9
+ *   slot 8-11:
+ *     DIFF mask=3D0xF4 state=3D0xF5   SE mask=3D0xFA state=3D0xFB
+ *
+ * MASK bit =3D 1  -> driver takes control of that output's Hi-Z state
+ * STATE bit =3D 0 -> output is forced to Hi-Z (muted)
+ * STATE bit =3D 1 -> output is driven (active)
+ *
+ * The output "index" in the driver is logical; the physical slot comes
+ * from info->clkout_map[].
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+struct sit9531x_hiz_regs {
+       unsigned int diff_mask;
+       unsigned int diff_state;
+       unsigned int se_mask;
+       unsigned int se_state;
+       u8 bit;
+};
+
+static void sit9531x_output_get_hiz_regs(u8 slot,
+                                        struct sit9531x_hiz_regs *r)
+{
+       if (slot <=3D 7) {
+               r->diff_mask  =3D SIT9531X_REG_HIZ_DIFF_07_MASK;
+               r->diff_state =3D SIT9531X_REG_HIZ_DIFF_07_STATE;
+               r->se_mask    =3D SIT9531X_REG_HIZ_SE_07_MASK;
+               r->se_state   =3D SIT9531X_REG_HIZ_SE_07_STATE;
+               r->bit =3D slot;
+       } else {
+               r->diff_mask  =3D SIT9531X_REG_HIZ_DIFF_811_MASK;
+               r->diff_state =3D SIT9531X_REG_HIZ_DIFF_811_STATE;
+               r->se_mask    =3D SIT9531X_REG_HIZ_SE_811_MASK;
+               r->se_state   =3D SIT9531X_REG_HIZ_SE_811_STATE;
+               r->bit =3D slot - 8;
+       }
+}
+
+/*
+ * Report whether a slot is currently forced into Hi-Z, i.e. the driver
+ * (or the blob) took control of the Hi-Z state (MASK bit set) and drives
+ * it low (STATE bit clear).  Either register pair muting the slot counts,
+ * mirroring what sit9531x_output_disable() programs.
+ */
+static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev, u8 slot=
,
+                                     bool *muted)
+{
+       struct sit9531x_hiz_regs r;
+       u8 mask, state;
+       int rc;
+
+       sit9531x_output_get_hiz_regs(slot, &r);
+
+       rc =3D sit9531x_read_u8(sitdev, r.diff_mask, &mask);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_read_u8(sitdev, r.diff_state, &state);
+       if (rc)
+               return rc;
+
+       *muted =3D (mask & BIT(r.bit)) && !(state & BIT(r.bit));
+       if (*muted)
+               return 0;
+
+       rc =3D sit9531x_read_u8(sitdev, r.se_mask, &mask);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_read_u8(sitdev, r.se_state, &state);
+       if (rc)
+               return rc;
+
+       *muted =3D (mask & BIT(r.bit)) && !(state & BIT(r.bit));
+
+       return 0;
+}
+
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,
+                               unsigned int reg, u8 bit, bool set)
+{
+       u8 cur, new_val;
+       int rc;
+
+       rc =3D sit9531x_read_u8(sitdev, reg, &cur);
+       if (rc)
+               return rc;
+
+       new_val =3D set ? (cur | BIT(bit)) : (cur & ~BIT(bit));
+
+       return sit9531x_write_u8(sitdev, reg, new_val);
+}
+
+/*
+ * Enter the output-system programming state: unlock the debug
+ * registers on Page 3 and issue the PRG_CMD state command.  Register
+ * writes that reconfigure the output system only take effect when
+ * they are made inside this state.
+ */
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)
+{
+       int rc;
+
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
+                              SIT9531X_DEBUG_UNLOCK_VAL);
+       if (rc)
+               return rc;
+
+       return sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
+                                SIT9531X_PRG_CMD_STATE);
+}
+
+/*
+ * Commit a programming sequence started by sit9531x_prg_enter():
+ * update the NVM shadow and re-lock the loops.  The sleep gives the
+ * hardware its required settling time after the loop-lock command;
+ * it is intentional despite the caller holding multiop_lock, as the
+ * whole NVM + lock sequence must be atomic.
+ */
+static int sit9531x_prg_commit(struct sit9531x_dev *sitdev)
+{
+       int rc;
+
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
+                              SIT9531X_UPDATE_NVM);
+       if (rc)
+               return rc;
+
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
+                              SIT9531X_LOOP_LOCK);
+       if (rc)
+               return rc;
+
+       msleep(100);
+
+       return 0;
+}
+
+/**
+ * sit9531x_output_disable - mute an output (force Hi-Z)
+ * @sitdev:    device pointer
+ * @index:     logical output index (0..info->num_outputs-1)
+ *
+ * Sets MASK+STATE on BOTH the DIFF and SE register pairs so that the
+ * output is muted regardless of its electrical configuration.  The
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence
+ * so the new state is applied by the hardware.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)
+{
+       const struct sit9531x_chip_info *info =3D sitdev->info;
+       struct sit9531x_hiz_regs r;
+       u8 slot;
+       int rc, ret;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (index >=3D info->num_outputs)
+               return -EINVAL;
+
+       slot =3D info->clkout_map[index];
+       sit9531x_output_get_hiz_regs(slot, &r);
+
+       rc =3D sit9531x_prg_enter(sitdev);
+       if (rc)
+               return rc;
+
+       /* Take control (MASK=3D1) and mute (STATE=3D0) on both DIFF and SE=
 */
+       rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);
+
+commit:
+       /*
+        * Always leave the PRG_CMD programming state, even on a mid-sequen=
ce
+        * write failure: prg_enter() unlocked the output loops, so returni=
ng
+        * without prg_commit() would strand the chip in the programming st=
ate
+        * with the loops unlocked.  Best effort -- keep the first error.
+        */
+       ret =3D sit9531x_prg_commit(sitdev);
+       if (ret && !rc)
+               rc =3D ret;
+       if (!rc)
+               sitdev->out[index].enabled =3D false;
+
+       return rc;
+}
+
+/**
+ * sit9531x_output_enable - un-mute an output (active state)
+ * @sitdev:    device pointer
+ * @index:     logical output index (0..info->num_outputs-1)
+ *
+ * Releases MASK on BOTH register pairs so the output returns to
+ * whatever the initial_config blob programmed.  The writes are wrapped
+ * in the PRG_CMD / NVM update / loop lock sequence so the new state is
+ * applied by the hardware.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)
+{
+       const struct sit9531x_chip_info *info =3D sitdev->info;
+       struct sit9531x_hiz_regs r;
+       u8 slot;
+       int rc, ret;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (index >=3D info->num_outputs)
+               return -EINVAL;
+
+       slot =3D info->clkout_map[index];
+       sit9531x_output_get_hiz_regs(slot, &r);
+
+       rc =3D sit9531x_prg_enter(sitdev);
+       if (rc)
+               return rc;
+
+       /* Release control (MASK=3D0) on both DIFF and SE */
+       rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);
+
+commit:
+       /*
+        * Always leave the PRG_CMD programming state, even on a mid-sequen=
ce
+        * write failure: prg_enter() unlocked the output loops, so returni=
ng
+        * without prg_commit() would strand the chip in the programming st=
ate
+        * with the loops unlocked.  Best effort -- keep the first error.
+        */
+       ret =3D sit9531x_prg_commit(sitdev);
+       if (ret && !rc)
+               rc =3D ret;
+       if (!rc)
+               sitdev->out[index].enabled =3D true;
+
+       return rc;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Input priority selection
+ *
+ * The SiT9531x has a 12-slot priority table per PLL on Page 1.  Each
+ * register holds two slots nibble-packed (even slot in [3:0], odd slot
+ * in [7:4]).
+ *
+ * The procedure:
+ *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)
+ *   2. Enter PRG_CMD state (Page 0 reg 0x0F <- 0x01)
+ *   3. Write priority slots on Page 1
+ *   4. NVM update + loop lock (Page 0 reg 0x0F)
+ *   5. Release holdover
+ *
+ * Caller must hold sitdev->multiop_lock.
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * Commit a priority-table programming sequence: update the NVM shadow
+ * and re-lock the loops through the Page-0 global update register.
+ * This is the priority-table counterpart of sit9531x_prg_commit(),
+ * which drives the output system through its own Page-3 register.
+ */
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)
+{
+       int rc;
+
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+                              SIT9531X_UPDATE_NVM);
+       if (rc)
+               return rc;
+
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+                              SIT9531X_LOOP_LOCK);
+       if (rc)
+               return rc;
+
+       usleep_range(1000, 2000);
+
+       return 0;
+}
+
+/**
+ * sit9531x_input_prio_set - set input priority for a PLL
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @input_idx: input source in hardware encoding (0-11, see
+ *             sit9531x_input_hw_src())
+ * @prio:      priority slot position (0 =3D highest)
+ *
+ * Writes a single priority slot assignment.  The input source is
+ * placed at the requested slot, and all lower-priority (higher-numbered)
+ * slots are filled with the same source to avoid stale entries.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+                           u8 input_idx, u8 prio)
+{
+       u8 pll_offset, reg_addr, val, slot;
+       int rc, prg_rc, ho_rc;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+       if (input_idx >=3D SIT9531X_PRIO_MAX_SLOTS)
+               return -EINVAL;
+       if (prio >=3D SIT9531X_PRIO_MAX_SLOTS)
+               return -EINVAL;
+
+       pll_offset =3D SIT9531X_PRIO_REGS_PER_PLL * pll_idx;
+
+       /* Step 1: Force PLL into holdover */
+       rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                   SIT9531X_PLL_REG_HO_CTRL,
+                                   BIT(SIT9531X_PLL_HO_FORCE_BIT),
+                                   BIT(SIT9531X_PLL_HO_FORCE_BIT));
+       if (rc)
+               return rc;
+
+       usleep_range(10000, 12000);
+
+       /* Step 2: Enter PRG_CMD state (Page 0, reg 0x0F) */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+                              SIT9531X_PRG_CMD_STATE);
+       if (rc)
+               goto release_ho;
+
+       /* Step 3: Write requested priority slot on Page 1 */
+       reg_addr =3D SIT9531X_PRIO_BASE_REG + pll_offset + (prio / 2);
+
+       rc =3D sit9531x_read_u8(sitdev,
+                             SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, reg_addr)=
, &val);
+       if (rc)
+               goto commit;
+
+       if (prio & 1) {
+               /* Odd slot: bits [7:4] */
+               val =3D (val & SIT9531X_PRIO_NIBBLE_MASK) |
+                     (input_idx << SIT9531X_PRIO_HI_SHIFT);
+       } else {
+               /* Even slot: bits [3:0] */
+               val =3D (val & (SIT9531X_PRIO_NIBBLE_MASK << SIT9531X_PRIO_=
HI_SHIFT)) |
+                     (input_idx & SIT9531X_PRIO_NIBBLE_MASK);
+       }
+
+       rc =3D sit9531x_write_u8(sitdev,
+                              SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, reg_addr=
), val);
+       if (rc)
+               goto commit;
+
+       /*
+        * Fill remaining slots (prio+1 .. 11) with the same source,
+        * matching the procedure script's backfill behaviour.
+        */
+       for (slot =3D prio + 1; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
+               reg_addr =3D SIT9531X_PRIO_BASE_REG + pll_offset + (slot / =
2);
+
+               rc =3D sit9531x_read_u8(sitdev,
+                                     SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, r=
eg_addr),
+                                     &val);
+               if (rc)
+                       goto commit;
+
+               if (slot & 1)
+                       val =3D (val & SIT9531X_PRIO_NIBBLE_MASK) |
+                             (input_idx << SIT9531X_PRIO_HI_SHIFT);
+               else
+                       val =3D (val & (SIT9531X_PRIO_NIBBLE_MASK <<
+                                     SIT9531X_PRIO_HI_SHIFT)) |
+                             (input_idx & SIT9531X_PRIO_NIBBLE_MASK);
+
+               rc =3D sit9531x_write_u8(sitdev,
+                                      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, =
reg_addr),
+                                      val);
+               if (rc)
+                       goto commit;
+       }
+
+commit:
+       /*
+        * Steps 4-5: NVM update and loop lock.  These must run even when a
+        * slot write failed: entering the PRG_CMD state above unlocked the
+        * loops, so returning without the commit would strand the chip in
+        * the programming state.  Best effort -- keep the first error.
+        */
+       prg_rc =3D sit9531x_prio_prg_commit(sitdev);
+       if (prg_rc && !rc)
+               rc =3D prg_rc;
+
+release_ho:
+       /*
+        * Step 6: Release holdover.  This must run even when an earlier st=
ep
+        * failed, so its own error is only surfaced when it would not mask=
 a
+        * prior failure -- otherwise a failing release could leave the PLL
+        * stuck in forced holdover while the function reports success.
+        */
+       ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                      SIT9531X_PLL_REG_HO_CTRL,
+                                      BIT(SIT9531X_PLL_HO_FORCE_BIT), 0);
+       if (ho_rc && !rc)
+               rc =3D ho_rc;
+
+       return rc;
+}
+
+/**
+ * sit9531x_input_prio_get - read an input's priority slot for a PLL
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @input_idx: input source in hardware encoding (see
+ *             sit9531x_input_hw_src())
+ * @prio:      output slot position (0 =3D highest); set to
+ *             SIT9531X_PRIO_MAX_SLOTS when the source is not in the table
+ *
+ * Scans the PLL's 12-slot priority table on Page 1 and returns the
+ * highest-priority (lowest-numbered) slot that references the source.
+ * This reads the value the chip actually holds rather than a cached
+ * default, so pin-get reflects the real hardware priority.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,
+                           u8 input_idx, u8 *prio)
+{
+       u8 pll_offset, reg_addr, val, slot, src;
+       int rc;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+
+       pll_offset =3D SIT9531X_PRIO_REGS_PER_PLL * pll_idx;
+
+       for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
+               reg_addr =3D SIT9531X_PRIO_BASE_REG + pll_offset + (slot / =
2);
+
+               rc =3D sit9531x_read_u8(sitdev,
+                                     SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, r=
eg_addr),
+                                     &val);
+               if (rc)
+                       return rc;
+
+               if (slot & 1)
+                       src =3D val >> SIT9531X_PRIO_HI_SHIFT;
+               else
+                       src =3D val & SIT9531X_PRIO_NIBBLE_MASK;
+
+               if (src =3D=3D input_idx) {
+                       *prio =3D slot;
+                       return 0;
+               }
+       }
+
+       *prio =3D SIT9531X_PRIO_MAX_SLOTS;
+       return 0;
+}
+
+/*
+ * sit9531x_prio_table_commit - write a full priority table for a PLL
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @srcs:      array of SIT9531X_PRIO_MAX_SLOTS source codes, slot 0 first
+ *
+ * Programs all 12 priority slots (nibble-packed, two per register) for
+ * the PLL using the same holdover / PRG_CMD / NVM-update / loop-lock
+ * sequence as sit9531x_input_prio_set().  Caller must hold
+ * sitdev->multiop_lock.
+ */
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,
+                                     const u8 *srcs)
+{
+       u8 pll_offset, reg_addr, val, slot;
+       int rc, prg_rc, ho_rc;
+
+       pll_offset =3D SIT9531X_PRIO_REGS_PER_PLL * pll_idx;
+
+       /* Step 1: force holdover */
+       rc =3D sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_=
CTRL,
+                                   BIT(SIT9531X_PLL_HO_FORCE_BIT),
+                                   BIT(SIT9531X_PLL_HO_FORCE_BIT));
+       if (rc)
+               return rc;
+
+       usleep_range(10000, 12000);
+
+       /* Step 2: enter PRG_CMD state */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+                              SIT9531X_PRG_CMD_STATE);
+       if (rc)
+               goto release_ho;
+
+       /* Step 3: write all slots on Page 1 */
+       for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
+               reg_addr =3D SIT9531X_PRIO_BASE_REG + pll_offset + (slot / =
2);
+
+               rc =3D sit9531x_read_u8(sitdev,
+                                     SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, r=
eg_addr),
+                                     &val);
+               if (rc)
+                       goto commit;
+
+               if (slot & 1)
+                       val =3D (val & SIT9531X_PRIO_NIBBLE_MASK) |
+                             (srcs[slot] << SIT9531X_PRIO_HI_SHIFT);
+               else
+                       val =3D (val & (SIT9531X_PRIO_NIBBLE_MASK <<
+                                     SIT9531X_PRIO_HI_SHIFT)) |
+                             (srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK);
+
+               rc =3D sit9531x_write_u8(sitdev,
+                                      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, =
reg_addr),
+                                      val);
+               if (rc)
+                       goto commit;
+       }
+
+commit:
+       /*
+        * Steps 4-5: NVM update and loop lock, run unconditionally for the
+        * same reason as in sit9531x_input_prio_set() -- a mid-table write
+        * failure must not leave the chip in the PRG_CMD state with the
+        * loops unlocked.
+        */
+       prg_rc =3D sit9531x_prio_prg_commit(sitdev);
+       if (prg_rc && !rc)
+               rc =3D prg_rc;
+
+release_ho:
+       ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                      SIT9531X_PLL_REG_HO_CTRL,
+                                      BIT(SIT9531X_PLL_HO_FORCE_BIT), 0);
+       if (ho_rc && !rc)
+               rc =3D ho_rc;
+
+       return rc;
+}
+
+/*
+ * sit9531x_prio_table_read - read a PLL's 12 priority-table source codes
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @srcs:      output array of SIT9531X_PRIO_MAX_SLOTS source codes
+ *
+ * Caller must hold sitdev->multiop_lock.
+ */
+static int sit9531x_prio_table_read(struct sit9531x_dev *sitdev, u8 pll_id=
x,
+                                   u8 *srcs)
+{
+       u8 pll_offset, reg_addr, val, slot;
+       int rc;
+
+       pll_offset =3D SIT9531X_PRIO_REGS_PER_PLL * pll_idx;
+
+       for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
+               reg_addr =3D SIT9531X_PRIO_BASE_REG + pll_offset + (slot / =
2);
+
+               rc =3D sit9531x_read_u8(sitdev,
+                                     SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, r=
eg_addr),
+                                     &val);
+               if (rc)
+                       return rc;
+
+               if (slot & 1)
+                       srcs[slot] =3D val >> SIT9531X_PRIO_HI_SHIFT;
+               else
+                       srcs[slot] =3D val & SIT9531X_PRIO_NIBBLE_MASK;
+       }
+
+       return 0;
+}
+
+/**
+ * sit9531x_input_prio_remove - drop an input from a PLL's priority table
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @input_idx: input source in hardware encoding
+ *
+ * Rewrites the priority table with the source removed: the remaining
+ * sources are compacted toward the highest-priority slots and the freed
+ * tail slots are backfilled with the lowest-priority remaining source
+ * (matching sit9531x_input_prio_set()).  This makes a disconnected
+ * input ineligible for automatic reference selection, not just gated at
+ * the input buffer.  It is a no-op when the source is absent, or when it
+ * is the only source (the buffer disable then drives the PLL to
+ * holdover and the table must not be left empty).
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,
+                              u8 input_idx)
+{
+       u8 srcs[SIT9531X_PRIO_MAX_SLOTS];
+       u8 kept[SIT9531X_PRIO_MAX_SLOTS];
+       u8 slot, count =3D 0;
+       bool found =3D false;
+       int rc;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+
+       rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);
+       if (rc)
+               return rc;
+
+       for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
+               if (srcs[slot] =3D=3D input_idx)
+                       found =3D true;
+               else
+                       kept[count++] =3D srcs[slot];
+       }
+
+       if (!found || count =3D=3D 0)
+               return 0;
+
+       /* Backfill freed tail slots with the lowest-priority remaining src=
 */
+       while (count < SIT9531X_PRIO_MAX_SLOTS) {
+               kept[count] =3D kept[count - 1];
+               count++;
+       }
+
+       return sit9531x_prio_table_commit(sitdev, pll_idx, kept);
+}
+
+/**
+ * sit9531x_input_prio_add - make an input eligible in a PLL's table
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @input_idx: input source in hardware encoding
+ *
+ * Ensures the source appears in the priority table so it can be picked
+ * by automatic reference selection again after a disconnect.  If the
+ * source is already listed the table is left untouched; otherwise it is
+ * placed in the lowest-priority slot.  The original priority is not
+ * restored -- use sit9531x_input_prio_set() to reassign it.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
+                           u8 input_idx)
+{
+       u8 srcs[SIT9531X_PRIO_MAX_SLOTS];
+       u8 slot;
+       int rc;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+
+       rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);
+       if (rc)
+               return rc;
+
+       for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)
+               if (srcs[slot] =3D=3D input_idx)
+                       return 0;
+
+       srcs[SIT9531X_PRIO_MAX_SLOTS - 1] =3D input_idx;
+
+       return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * DCO tuning (inner and outer loop)
+ *
+ * The SiT9531x DCO mechanism adjusts PLL frequency in ppb via
+ * fractional divider manipulation.
+ *
+ * Inner loop (free-run mode):
+ *   - Reads DIVN integer/fraction from PLL page 0x30-0x3B
+ *   - Computes 48-bit DCO fractional word
+ *   - Writes to PLL page regs 0x51-0x56
+ *
+ * Outer loop (sync mode):
+ *   - Reads DIVN2 integer/fraction from PLL page 0x3E-0x4C
+ *   - Computes 24-bit integer + 32-bit fractional DCO word
+ *   - Writes to PLL page regs 0x5E-0x60 (int), 0x63-0x66 (frac)
+ *
+ * After writing DCO codes, a trigger pulse on Page 0 reg 0x64
+ * applies the increment (bit 6) or decrement (bit 4).
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * struct sit9531x_dco_code - computed DCO register values
+ * @dco_frac:  48-bit inner loop fractional word
+ * @dco_int:   24-bit outer loop integer word (signed)
+ * @outer_frac:        32-bit outer loop fractional word
+ */
+struct sit9531x_dco_code {
+       u64     dco_frac;
+       s32     dco_int;
+       u64     outer_frac;
+};
+
+/*
+ * sit9531x_dco_read_divn - read DIVN values for free-run DCO calculation
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index
+ * @int_part:  output integer part
+ * @fracn:     output fractional numerator
+ * @fracd:     output fractional denominator
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dco_read_divn(struct sit9531x_dev *sitdev, u8 pll_idx,
+                                 u32 *int_part, u32 *fracn, u32 *fracd)
+{
+       u8 v, pbyq;
+       int rc, i;
+
+       /* Integer part */
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DIVN_=
INT, &v);
+       if (rc)
+               return rc;
+       *int_part =3D v;
+
+       /* Numerator (4 bytes, little-endian) */
+       *fracn =3D 0;
+       for (i =3D 3; i >=3D 0; i--) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_DIVN_NUM + i, &v=
);
+               if (rc)
+                       return rc;
+               *fracn =3D (*fracn << 8) | v;
+       }
+
+       /* Check P/Q enable bit (reg 0x31 bit 6) */
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_STATU=
S, &v);
+       if (rc)
+               return rc;
+       pbyq =3D (v >> 6) & 1;
+
+       if (pbyq) {
+               /* Denominator (4 bytes, little-endian) */
+               *fracd =3D 0;
+               for (i =3D 3; i >=3D 0; i--) {
+                       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                                 SIT9531X_PLL_REG_DIVN_DEN=
 + i,
+                                                 &v);
+                       if (rc)
+                               return rc;
+                       *fracd =3D (*fracd << 8) | v;
+               }
+       } else {
+               /*
+                * P/Q disabled: integer-only mode.
+                * Set fracd =3D 1 to avoid division by zero.
+                */
+               *fracn =3D 0;
+               *fracd =3D 1;
+       }
+
+       return 0;
+}
+
+/*
+ * sit9531x_dco_read_divn2 - read DIVN2 values for sync DCO calculation
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index
+ * @n2_int:    output integer part
+ * @n2_fracn:  output fractional numerator
+ * @n2_fracd:  output fractional denominator
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dco_read_divn2(struct sit9531x_dev *sitdev, u8 pll_idx=
,
+                                  s64 *n2_int, u32 *n2_fracn, u32 *n2_frac=
d)
+{
+       int rc, i;
+       u8 v;
+
+       /* Integer part (5 bytes, big-endian: 0x42 is MSB) */
+       *n2_int =3D 0;
+       for (i =3D 4; i >=3D 0; i--) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_DIVN2_INT + i, &=
v);
+               if (rc)
+                       return rc;
+               if (i =3D=3D 4)
+                       v &=3D 0x07;  /* only 3 bits in MSB */
+               *n2_int =3D (*n2_int << 8) | v;
+       }
+
+       /* Fractional numerator (4 bytes, big-endian: 0x46 is MSB) */
+       *n2_fracn =3D 0;
+       for (i =3D 3; i >=3D 0; i--) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_DIVN2_FRAC_NUM +=
 i,
+                                         &v);
+               if (rc)
+                       return rc;
+               *n2_fracn =3D (*n2_fracn << 8) | v;
+       }
+
+       /* Fractional denominator (4 bytes, big-endian: 0x4C is MSB) */
+       *n2_fracd =3D 0;
+       for (i =3D 3; i >=3D 0; i--) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_DIVN2_FRAC_DEN +=
 i,
+                                         &v);
+               if (rc)
+                       return rc;
+               *n2_fracd =3D (*n2_fracd << 8) | v;
+       }
+
+       return 0;
+}
+
+/*
+ * sit9531x_dco_calc_inner - compute inner loop DCO code (free-run)
+ *
+ * Formula:
+ *   divn_code =3D int_part * 65536 + fracn * 65536 / fracd
+ *   dco_frac  =3D divn_code * ppb * fracd / 1e9
+ *
+ * Caller guarantees ppb >=3D 0; sign handled by trigger pulse.
+ */
+static void sit9531x_dco_calc_inner(u32 int_part, u32 fracn, u32 fracd,
+                                   s64 ppb, struct sit9531x_dco_code *code=
)
+{
+       u64 fracd_eff, frac_scaled, divn_code;
+
+       /*
+        * A zero denominator is the chip's implicit-denominator mode: frac=
n
+        * is a binary fraction over 2^32, not over 1 (matching
+        * sit9531x_get_fvco()).  Defaulting to 1 would scale frac_scaled u=
p
+        * by 2^32 and overflow it.  Keep it in a u64 so the division canno=
t
+        * truncate.
+        */
+       fracd_eff =3D fracd ? fracd : (1ULL << 32);
+
+       frac_scaled =3D div64_u64((u64)fracn * 65536, fracd_eff);
+       divn_code =3D (u64)int_part * 65536 + frac_scaled;
+
+       /*
+        * The triple multiply (divn_code * ppb * fracd_eff) overflows u64 =
in
+        * realistic ranges (divn_code ~ 2^21, ppb ~ 2^30, fracd_eff ~ 2^32=
 =3D
+        * ~2^83).  Use mul_u64_u64_div_u64() to carry out the multiply in
+        * 128 bits internally.
+        */
+       code->dco_frac =3D mul_u64_u64_div_u64(divn_code,
+                                            (u64)ppb * fracd_eff,
+                                            1000000000ULL);
+}
+
+/*
+ * sit9531x_dco_calc_outer - compute outer loop DCO code (sync)
+ *
+ * The previous formulation computed divn2 with truncating integer
+ * division (n2_int + n2_fracn / n2_fracd), silently dropping the
+ * fractional part of DIVN2.  Mirror the inner-loop scale-then-divide
+ * pattern by keeping the un-divided numerator:
+ *   divn2_num =3D n2_int * n2_fracd + n2_fracn       (exact)
+ *   divn2     =3D divn2_num / n2_fracd               (conceptually)
+ *   dco_int   =3D divn2 * ppb / 1e9
+ *             =3D divn2_num * ppb / (n2_fracd * 1e9)
+ *   outer_frac =3D (divn2 * ppb / 1e9 - dco_int) * n2_fracd * 65536
+ *              =3D divn2_num * (ppb * 65536) / 1e9 - dco_int * n2_fracd *=
 65536
+ *
+ * Caller guarantees ppb >=3D 0; sign handled by trigger pulse.
+ */
+static void sit9531x_dco_calc_outer(s64 n2_int, u32 n2_fracn, u32 n2_fracd=
,
+                                   s64 ppb, struct sit9531x_dco_code *code=
)
+{
+       u64 fracd_eff, denom, a, b, ra, qa, c, quot, rem;
+
+       /*
+        * Conceptually dco_int =3D floor(divn2 * ppb / 1e9) and outer_frac=
 =3D
+        * floor(frac(divn2 * ppb / 1e9) * fracd_eff * 65536), where
+        * divn2 =3D n2_int + n2_fracn / fracd_eff.  Forming the numerator
+        * divn2_num =3D n2_int * fracd_eff + n2_fracn directly overflows u=
64:
+        * n2_int is the DIVN2 feedback integer read from a 35-bit register=
,
+        * so for a low-frequency outer reference (e.g. a 1 PPS input) it c=
an
+        * approach 2^35, and with fracd_eff up to 2^32 the product reaches
+        * ~2^67.  (The earlier "well under 2^20" note held only for the
+        * inner loop's high-frequency XTAL reference, not the outer loop.)
+        *
+        * Avoid ever materialising a value wider than u64 by expanding
+        * divn2_num * ppb =3D a * fracd_eff + b with a =3D n2_int * ppb an=
d
+        * b =3D n2_fracn * ppb, then reducing a modulo 1e9 first:
+        *   a =3D qa * 1e9 + ra           (ra < 1e9)
+        *   NUM =3D qa * denom + (ra * fracd_eff + b), denom =3D fracd_eff=
 * 1e9
+        *   dco_int    =3D qa + (ra * fracd_eff + b) / denom
+        *   outer_frac =3D (NUM mod denom) * 65536 / 1e9
+        * Every intermediate stays under 2^63; the final 65536 scaling use=
s
+        * the 128-bit helper.  Caller guarantees n2_int >=3D 0 and ppb >=
=3D 0.
+        */
+       fracd_eff =3D n2_fracd ? n2_fracd : (1ULL << 32);
+       denom =3D fracd_eff * 1000000000ULL;
+
+       a =3D (u64)n2_int * (u64)ppb;
+       b =3D (u64)n2_fracn * (u64)ppb;
+
+       qa =3D div64_u64(a, 1000000000ULL);
+       ra =3D a - qa * 1000000000ULL;
+       c =3D ra * fracd_eff + b;
+
+       quot =3D div64_u64(c, denom);
+       rem =3D c - quot * denom;
+
+       code->dco_int =3D (s32)(qa + quot);
+       code->outer_frac =3D mul_u64_u64_div_u64(rem, 65536ULL, 1000000000U=
LL);
+}
+
+/*
+ * sit9531x_dco_write_inner - write inner loop DCO registers
+ */
+static int sit9531x_dco_write_inner(struct sit9531x_dev *sitdev,
+                                   u8 pll_idx,
+                                   const struct sit9531x_dco_code *code)
+{
+       u64 frac =3D code->dco_frac;
+       int rc, i;
+
+       /* Enable DCO with dither mode */
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_FUNC,
+                                  SIT9531X_DCO_DITHER_MODE | SIT9531X_DCO_=
EN);
+       if (rc)
+               return rc;
+
+       /* Write 48-bit fractional word (LSB first: 0x51->0x56) */
+       for (i =3D 0; i < 6; i++) {
+               rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                          SIT9531X_PLL_REG_DCO_FRAC1 + i,
+                                          frac & 0xFF);
+               if (rc)
+                       return rc;
+               frac >>=3D 8;
+       }
+
+       return 0;
+}
+
+/*
+ * sit9531x_dco_write_outer - write outer loop DCO registers
+ */
+static int sit9531x_dco_write_outer(struct sit9531x_dev *sitdev,
+                                   u8 pll_idx,
+                                   const struct sit9531x_dco_code *code)
+{
+       s32 dco_int;
+       u64 frac;
+       int rc;
+
+       /* Enable DCO with dither mode + outer loop */
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_FUNC,
+                                  SIT9531X_DCO_DITHER_MODE | SIT9531X_DCO_=
OUTER_EN |
+                                  SIT9531X_DCO_EN);
+       if (rc)
+               return rc;
+
+       /* Write 32-bit fractional (shifted >>16, LSB first: 0x63->0x66) */
+       frac =3D code->outer_frac >> 16;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_OFRAC_7, frac & 0xF=
F);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_OFRAC_15,
+                                  (frac >> 8) & 0xFF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_OFRAC_23,
+                                  (frac >> 16) & 0xFF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_OFRAC_31,
+                                  (frac >> 24) & 0xFF);
+       if (rc)
+               return rc;
+
+       /* Write 24-bit integer (LSB first: 0x5E->0x60) */
+       dco_int =3D code->dco_int;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_INT_7, dco_int & 0x=
FF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_INT_15,
+                                  (dco_int >> 8) & 0xFF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DCO_INT_23,
+                                  (dco_int >> 16) & 0xFF);
+       if (rc)
+               return rc;
+
+       return 0;
+}
+
+/*
+ * sit9531x_dco_mask - mask a PLL's DCO (prevent updates)
+ */
+static int sit9531x_dco_mask(struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+       u8 val;
+       int rc;
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_DCO_FUNC, &val);
+       if (rc)
+               return rc;
+
+       return sit9531x_write_pll_u8(sitdev, pll_idx,
+                                    SIT9531X_PLL_REG_DCO_FUNC,
+                                    val | SIT9531X_DCO_MASK);
+}
+
+/*
+ * sit9531x_dco_unmask - unmask a PLL's DCO (allow updates)
+ */
+static int sit9531x_dco_unmask(struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+       u8 val;
+       int rc;
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_DCO_FUNC, &val);
+       if (rc)
+               return rc;
+
+       return sit9531x_write_pll_u8(sitdev, pll_idx,
+                                    SIT9531X_PLL_REG_DCO_FUNC,
+                                    val & ~SIT9531X_DCO_MASK);
+}
+
+/*
+ * sit9531x_dco_trigger - trigger DCO increment or decrement
+ * @sitdev:    device pointer
+ * @neg_adj:   true for decrement, false for increment
+ *
+ * Pulses the appropriate bit in Page 0 reg 0x64 (1->0 edge).
+ */
+static int sit9531x_dco_trigger(struct sit9531x_dev *sitdev, bool neg_adj)
+{
+       u8 val, bit;
+       int rc;
+
+       bit =3D neg_adj ? SIT9531X_DCO_TRIGGER_DECR : SIT9531X_DCO_TRIGGER_=
INCR;
+
+       /* Set trigger bit */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, &val);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, val | bi=
t);
+       if (rc)
+               return rc;
+
+       ndelay(SIT9531X_DCO_TRIGGER_PULSE_NS);
+
+       /* Clear trigger bit */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, &val);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, val & ~b=
it);
+       if (rc)
+               return rc;
+
+       return 0;
+}
+
+/*
+ * Largest DCO pull accepted, in ppb (1e7 ppb =3D 1%,
+ * far past any physical DCO range).  ppb is the only unbounded factor in
+ * the outer-loop products (divn2_num * ppb and dco_int * fracd_eff *
+ * 65536); the DIVN2 feedback divider read from the chip is a small
+ * physical value, so bounding ppb keeps those products inside 64 bits and
+ * rejects a bogus value instead of letting it wrap silently.
+ */
+#define SIT9531X_DCO_PPB_MAX   10000000LL
+
+/**
+ * sit9531x_dco_adjust - adjust PLL frequency via DCO
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @ppb:       frequency adjustment in parts per billion
+ *
+ * In free-run mode, adjusts the inner loop only.
+ * In sync mode, adjusts both inner and outer loops.
+ * Masks all other PLLs' DCOs during the operation.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, -ERANGE if @ppb is out of range, <0 on error
+ */
+int sit9531x_dco_adjust(struct sit9531x_dev *sitdev, u8 pll_idx, s64 ppb)
+{
+       struct sit9531x_dco_code code =3D {};
+       bool neg_adj =3D false;
+       int rc, i;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       /*
+        * Bound before the negation below so S64_MIN cannot overflow, and =
so
+        * the fractional multiplies downstream stay within 64 bits.
+        */
+       if (ppb < -SIT9531X_DCO_PPB_MAX || ppb > SIT9531X_DCO_PPB_MAX)
+               return -ERANGE;
+
+       if (ppb < 0) {
+               neg_adj =3D true;
+               ppb =3D -ppb;
+       }
+
+       /*
+        * Mask all other PLLs' DCOs so the global DCO trigger (Page 0 reg
+        * 0x64) only steers @pll_idx.  They are restored on every exit via
+        * the unmask_others label -- see the note there.
+        */
+       for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {
+               if (i =3D=3D pll_idx)
+                       continue;
+               rc =3D sit9531x_dco_mask(sitdev, i);
+               if (rc)
+                       goto unmask_others;
+       }
+
+       /* Unmask target PLL */
+       rc =3D sit9531x_dco_unmask(sitdev, pll_idx);
+       if (rc)
+               goto unmask_others;
+
+       /* Unlock debug registers */
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DEBUG, SIT9531X_PLL_DEB=
UG_UNLOCK);
+       if (rc)
+               goto unmask_others;
+
+       /* Determine mode and compute/write DCO codes */
+       if (sitdev->chan[pll_idx].mode) {
+               /* Free-run: inner loop only */
+               u32 div_int;
+               u32 div_fracn;
+               u32 div_fracd;
+
+               rc =3D sit9531x_dco_read_divn(sitdev, pll_idx,
+                                           &div_int, &div_fracn, &div_frac=
d);
+               if (rc)
+                       goto unmask_others;
+
+               sit9531x_dco_calc_inner(div_int, div_fracn, div_fracd,
+                                       ppb, &code);
+
+               rc =3D sit9531x_dco_write_inner(sitdev, pll_idx, &code);
+               if (rc)
+                       goto unmask_others;
+       } else {
+               /* Sync: inner + outer loops */
+               s64 n2_int;
+               u32 n2_fracn;
+               u32 n2_fracd;
+               u32 div_int;
+               u32 div_fracn;
+               u32 div_fracd;
+
+               /* Inner loop */
+               rc =3D sit9531x_dco_read_divn(sitdev, pll_idx,
+                                           &div_int, &div_fracn, &div_frac=
d);
+               if (rc)
+                       goto unmask_others;
+
+               sit9531x_dco_calc_inner(div_int, div_fracn, div_fracd,
+                                       ppb, &code);
+
+               rc =3D sit9531x_dco_write_inner(sitdev, pll_idx, &code);
+               if (rc)
+                       goto unmask_others;
+
+               /* Outer loop */
+               rc =3D sit9531x_dco_read_divn2(sitdev, pll_idx,
+                                            &n2_int, &n2_fracn, &n2_fracd)=
;
+               if (rc)
+                       goto unmask_others;
+
+               sit9531x_dco_calc_outer(n2_int, n2_fracn, n2_fracd,
+                                       ppb, &code);
+
+               rc =3D sit9531x_dco_write_outer(sitdev, pll_idx, &code);
+               if (rc)
+                       goto unmask_others;
+       }
+
+       /* Set trigger register base value, then pulse increment/decrement =
*/
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_DCO_TRIGGER,
+                              SIT9531X_DCO_TRIGGER_BASE);
+       if (rc)
+               goto unmask_others;
+
+       rc =3D sit9531x_dco_trigger(sitdev, neg_adj);
+
+unmask_others:
+       /*
+        * The other PLLs were masked only to isolate @pll_idx for this
+        * adjustment.  Their DCO mask bit is otherwise always clear (this
+        * function is the only writer of it), so unmask them again on ever=
y
+        * exit -- leaving them masked would freeze the outer loop on all o=
ther
+        * PLLs and silently break their reference tracking.  Best effort: =
the
+        * first real error is preserved.
+        */
+       for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {
+               int err;
+
+               if (i =3D=3D pll_idx)
+                       continue;
+               err =3D sit9531x_dco_unmask(sitdev, i);
+               if (err && !rc)
+                       rc =3D err;
+       }
+
+       return rc;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Output frequency set
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/* Per-slot DIVO base register offsets (6 slots per page) */
+static const u8 clkout_odr_divn_base[] =3D {
+       0x14, 0x24, 0x34, 0x44, 0x54, 0x64
+};
+
+/* XO doubler register */
+#define SIT9531X_REG_XO2_GENERIC               SIT9531X_REG(0x00, 0x2D)
+#define SIT9531X_XO_DOUBLER_ENB_BIT            7   /* inverted: 0 =3D enab=
led */
+
+/* VCO frequency bands (Hz) */
+#define SIT9531X_FVCO_LOWBAND_MIN              4915200000ULL
+#define SIT9531X_FVCO_LOWBAND_MAX              5898240000ULL
+#define SIT9531X_FVCO_HIGHBAND_MIN             6875000000ULL
+#define SIT9531X_FVCO_HIGHBAND_MAX             7812500000ULL
+
+/*
+ * sit9531x_is_xo_doubler_enabled - check if Fref doubler is active
+ * @sitdev:    device pointer
+ *
+ * Register 0x2D bit 7 is active-low: 0 =3D doubler enabled, 1 =3D disable=
d.
+ *
+ * Return: 1 if enabled, 0 if disabled, <0 on error
+ */
+static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)
+{
+       u8 val;
+       int rc;
+
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_XO2_GENERIC, &val);
+       if (rc)
+               return rc;
+
+       return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;
+}
+
+/*
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ *
+ * Fvco =3D Fref * DIVN, where DIVN =3D int_part + fracn/fracd is read fro=
m
+ * PLL page regs 0x30 (int), 0x32-0x35 (numerator), 0x38-0x3B
+ * (denominator), and Fref =3D xtal_freq << doubler.  DIVN is the
+ * steady-state Fvco/Fref target programmed by the NVM blob and is
+ * authoritative in both free-run and sync modes; the previous split
+ * between free-run and sync formulas returned 0 on chips that didn't
+ * have a sync input populated, which broke the TDC phase readback.
+ *
+ * The numerator and denominator are unsigned 32-bit values.  When the
+ * denominator reads as zero (the chip's "implicit denominator" mode for
+ * pure-fractional DIVN), the convention is fracd =3D 2^32, so fracn is
+ * interpreted as a binary fraction over 2^32.
+ *
+ * Return: Fvco in Hz, or 0 on error
+ */
+static u64 sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+       u64 fracd =3D 0, fref, divn_temp;
+       u32 int_part, fracn =3D 0;
+       int doubler, rc, i;
+       u8 v;
+
+       /*
+        * DT board-config override: some configs (e.g. an INTSYNC PLL)
+        * run a VCO that Fref*DIVN does not reproduce.  When the board
+        * supplies the measured VCO, use it verbatim.
+        */
+       if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx])
+               return sitdev->pll_fvco[pll_idx];
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_DIVN_INT, &v);
+       if (rc)
+               return 0;
+       int_part =3D v;
+
+       for (i =3D 3; i >=3D 0; i--) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_DIVN_NUM + i, &v=
);
+               if (rc)
+                       return 0;
+               fracn =3D (fracn << 8) | v;
+       }
+
+       for (i =3D 3; i >=3D 0; i--) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_DIVN_DEN + i, &v=
);
+               if (rc)
+                       return 0;
+               fracd =3D (fracd << 8) | v;
+       }
+
+       /*
+        * Implicit denominator: fracd=3D0 means fracn is a binary fraction
+        * over 2^32 (the chip uses this when no explicit denominator is
+        * programmed).
+        */
+       if (!fracd)
+               fracd =3D 1ULL << 32;
+
+       doubler =3D sit9531x_is_xo_doubler_enabled(sitdev);
+       if (doubler < 0)
+               return 0;
+
+       fref =3D (u64)sitdev->xtal_freq << doubler;
+
+       /*
+        * Fvco =3D fref * (int_part + fracn/fracd).  Split the multiplicat=
ion
+        * to avoid 64-bit overflow on the realistic fref/DIVN range.
+        */
+       divn_temp =3D fref * int_part + div64_u64(fref * fracn, fracd);
+
+       return divn_temp;
+}
+
+/*
+ * sit9531x_output_phase_flush - flush the output phase of a PLL
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ *
+ * Fires the chip's on-demand phase-flush (PHFL) so every output divider
+ * of @pll_idx restarts aligned to the PLL phase.  Without it a rewritten
+ * DIVO keeps counting from an arbitrary point and the output edge lands
+ * with a persistent offset against the tracked reference (only a power
+ * cycle realigned it).
+ *
+ * The sequence mirrors the vendor procedure: arm the on-demand PHFL and
+ * latch it with the PLL-page small-change update, then select the
+ * in-register phase trigger on Page 0 and pulse it.  The Page 0 trigger
+ * register is touched read-modify-write so the unrelated OEb bits are
+ * preserved.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_output_phase_flush(struct sit9531x_dev *sitdev, u8 pll=
_idx)
+{
+       u8 ctrl, orig;
+       int rc, ret;
+
+       /* Arm the on-demand phase-flush on the PLL page. */
+       rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                   SIT9531X_PLL_REG_PHFL_CTRL,
+                                   SIT9531X_PLL_PHFL_ON_DEMAND_EN,
+                                   SIT9531X_PLL_PHFL_ON_DEMAND_EN);
+       if (rc)
+               return rc;
+
+       /* Latch it with the PLL small-change update. */
+       rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                   SIT9531X_PLL_REG_SMALL_UPDATE,
+                                   SIT9531X_PLL_SMALL_UPDATE_CMD,
+                                   SIT9531X_PLL_SMALL_UPDATE_CMD);
+       if (rc)
+               return rc;
+
+       /*
+        * Select the in-register phase trigger, preserving the OEb bits.
+        * Remember the original register value (with the trigger de-assert=
ed)
+        * so the trigger-source select can be restored once the pulse has
+        * fired.
+        */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, &ctrl=
);
+       if (rc)
+               return rc;
+
+       orig =3D ctrl & ~SIT9531X_DIVO_PHASE_TRIG;
+       ctrl =3D orig | SIT9531X_DIVO_PHASE_SEL_REG;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ctrl=
);
+       if (rc)
+               return rc;
+
+       /*
+        * Pulse the phase trigger.  No explicit delay is needed between th=
e
+        * set and clear writes: each I2C transaction takes far longer than
+        * any minimum pulse width.
+        */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1,
+                              ctrl | SIT9531X_DIVO_PHASE_TRIG);
+
+       /*
+        * Restore the original trigger-source select.  The pulse above has
+        * already latched the flush, so a one-shot flush must not leave th=
e
+        * phase trigger permanently pinned to the in-register source.  Thi=
s
+        * runs even when the pulse write failed, otherwise a failed flush
+        * would keep a hardware trigger source hijacked; the restore error
+        * is only surfaced when it would not mask the pulse failure.
+        */
+       ret =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GPIO_FUNC_CTRL1, ori=
g);
+       if (ret && !rc)
+               rc =3D ret;
+
+       return rc;
+}
+
+/**
+ * sit9531x_output_freq_set - set output clock frequency
+ * @sitdev:    device pointer
+ * @out_idx:   output index (0-N for this chip variant)
+ * @pll_idx:   PLL driving this output (0-3)
+ * @frequency: desired output frequency in Hz
+ *
+ * Computes DIVO =3D Fvco / frequency and writes the 34-bit output divider
+ * to the output system registers on Pages 3/4.  The write sequence is:
+ *   1. Unlock debug registers (Page 3)
+ *   2. Enter PRG_CMD state
+ *   3. Write 5-byte DIVO to the correct page/slot
+ *   4. NVM update
+ *   5. Loop lock
+ *   6. Wait for lock to settle
+ *   7. Flush the output phase so the new divider starts aligned
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error.  Actual frequency may differ
+ *         due to integer division; the output state is updated with
+ *         the effective frequency (Fvco / DIVO).
+ */
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
+                            u8 pll_idx, u64 frequency)
+{
+       const struct sit9531x_chip_info *info =3D sitdev->info;
+       u8 slot, page, base_reg, divo_bytes[5], msb_old;
+       u64 fvco, divo, fvco_min, fvco_max;
+       int rc, j, ret;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (out_idx >=3D info->num_outputs || pll_idx >=3D SIT9531X_NUM_PLL=
S)
+               return -EINVAL;
+
+       if (!frequency)
+               return -EINVAL;
+
+       /* Determine VCO frequency band limits */
+       if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3) {
+               /* PLLB, PLLD: high band */
+               fvco_min =3D SIT9531X_FVCO_HIGHBAND_MIN;
+               fvco_max =3D SIT9531X_FVCO_HIGHBAND_MAX;
+       } else {
+               /* PLLA, PLLC: low band */
+               fvco_min =3D SIT9531X_FVCO_LOWBAND_MIN;
+               fvco_max =3D SIT9531X_FVCO_LOWBAND_MAX;
+       }
+
+       /*
+        * Read current VCO frequency.  When the board supplies an explicit
+        * Fvco via "sitime,pll-fvco" the override is the source of truth
+        * (e.g. a chip variant that runs out of the documented band, or a
+        * mode like INTSYNC where Fref*DIVN does not reproduce the VCO), s=
o
+        * skip the band clamp in that case.
+        */
+       fvco =3D sit9531x_get_fvco(sitdev, pll_idx);
+       if (!fvco) {
+               fvco =3D fvco_min;
+       } else if (!sitdev->pll_fvco[pll_idx]) {
+               if (fvco < fvco_min)
+                       fvco =3D fvco_min;
+               else if (fvco > fvco_max)
+                       fvco =3D fvco_max;
+       }
+
+       /* Compute output divider: DIVO =3D Fvco / freq */
+       divo =3D div64_u64(fvco, frequency);
+       if (!divo)
+               return -EINVAL;
+
+       dev_dbg(sitdev->dev,
+               "out%u: Fvco=3D%llu freq=3D%llu DIVO=3D%llu (effective %llu=
 Hz)\n",
+               out_idx, fvco, frequency, divo, div64_u64(fvco, divo));
+
+       /* Map output index to physical slot */
+       slot =3D info->clkout_map[out_idx];
+
+       /* Determine page and per-page slot register */
+       if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)
+               page =3D SIT9531X_PAGE_OUTSYS1;
+       else
+               page =3D SIT9531X_PAGE_OUTSYS0;
+       base_reg =3D clkout_odr_divn_base[slot % 6];
+
+       /* Step 1: Switch to Page 3 and unlock debug */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
+                              SIT9531X_DEBUG_UNLOCK_VAL);
+       if (rc)
+               return rc;
+
+       /* Step 2: Enter PRG_CMD state */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
+                              SIT9531X_PRG_CMD_STATE);
+       if (rc)
+               return rc;
+
+       /* Step 3: Prepare DIVO bytes (34-bit, LSB at base reg) */
+       divo_bytes[0] =3D (divo >>  0) & 0xFF;
+       divo_bytes[1] =3D (divo >>  8) & 0xFF;
+       divo_bytes[2] =3D (divo >> 16) & 0xFF;
+       divo_bytes[3] =3D (divo >> 24) & 0xFF;
+       divo_bytes[4] =3D (divo >> 32) & 0x03;  /* only bits [1:0] */
+
+       /* Read existing MSB register and preserve upper 6 bits */
+       rc =3D sit9531x_read_u8(sitdev,
+                             SIT9531X_REG(page, base_reg - 4), &msb_old);
+       if (rc)
+               goto commit;
+       divo_bytes[4] |=3D msb_old & 0xFC;
+
+       /* Write 5 DIVO bytes (base, base-1, base-2, base-3, base-4) */
+       for (j =3D 0; j < 5; j++) {
+               rc =3D sit9531x_write_u8(sitdev,
+                                      SIT9531X_REG(page, base_reg - j),
+                                      divo_bytes[j]);
+               if (rc)
+                       goto commit;
+       }
+
+commit:
+       /*
+        * Step 4: NVM update + loop lock.  Always run prg_commit() so the =
chip
+        * leaves the PRG_CMD state with the output loops re-locked, even w=
hen a
+        * write above failed; keep the first error to return.  It also car=
ries
+        * the required post-lock settling sleep.
+        */
+       ret =3D sit9531x_prg_commit(sitdev);
+       if (ret && !rc)
+               rc =3D ret;
+       if (rc)
+               return rc;
+
+       /*
+        * Step 5: flush the PLL's output phase so the new DIVO starts
+        * aligned instead of keeping the arbitrary phase the divider
+        * happened to be at.
+        */
+       rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);
+       if (rc)
+               return rc;
+
+       /* Update cached output frequency */
+       sitdev->out[out_idx].freq =3D (u32)div64_u64(fvco, divo);
+
+       return 0;
+}
+
+/**
+ * sit9531x_output_freq_get - read output clock frequency from hardware
+ * @sitdev:    device pointer
+ * @out_idx:   output index (0-N for this chip variant)
+ * @frequency: output frequency in Hz
+ *
+ * Reads the 34-bit DIVO divider back from the output system registers
+ * and computes the live output frequency as Fvco / DIVO.  This stays
+ * correct even when the divider was reprogrammed behind the driver's
+ * back (e.g. by a direct-I2C userspace tool), where the cached value
+ * would be stale.
+ *
+ * The cached output state is refreshed with the computed value.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, -ENODEV when the output divider or VCO rate
+ *        is not resolvable, <0 on register access error
+ */
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
+                            u64 *frequency)
+{
+       const struct sit9531x_chip_info *info =3D sitdev->info;
+       u8 slot, page, base_reg, pll_idx, v;
+       u64 fvco, divo =3D 0;
+       int rc, j;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (out_idx >=3D info->num_outputs)
+               return -EINVAL;
+
+       pll_idx =3D sitdev->out[out_idx].pll_idx;
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -ENODEV;
+
+       fvco =3D sit9531x_get_fvco(sitdev, pll_idx);
+       if (!fvco)
+               return -ENODEV;
+
+       slot =3D info->clkout_map[out_idx];
+       if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)
+               page =3D SIT9531X_PAGE_OUTSYS1;
+       else
+               page =3D SIT9531X_PAGE_OUTSYS0;
+       base_reg =3D clkout_odr_divn_base[slot % 6];
+
+       /* Read 5 DIVO bytes (MSB at base-4, bits [1:0] only) */
+       for (j =3D 4; j >=3D 0; j--) {
+               rc =3D sit9531x_read_u8(sitdev,
+                                     SIT9531X_REG(page, base_reg - j), &v)=
;
+               if (rc)
+                       return rc;
+               if (j =3D=3D 4)
+                       v &=3D 0x03;
+               divo =3D (divo << 8) | v;
+       }
+
+       if (!divo)
+               return -ENODEV;
+
+       *frequency =3D div64_u64(fvco, divo);
+       sitdev->out[out_idx].freq =3D (u32)*frequency;
+
+       return 0;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Phase adjust (PRG_RST_DELAY register-based)
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ *
+ * The chip exposes a per-output 34-bit coarse delay measured in VCO
+ * clock periods plus a 3-bit fine delay in fixed 30 ps steps.  The
+ * five bytes PROG6..PROG2 hold the field across registers:
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved via RMW)
+ *                    [4:2] PRG_RST_FINE_DELAY
+ *                    [1:0] PRG_RST_DELAY[33:32]
+ *   base + 1  PROG5  PRG_RST_DELAY[31:24]
+ *   base + 2  PROG4  PRG_RST_DELAY[23:16]
+ *   base + 3  PROG3  PRG_RST_DELAY[15:8]
+ *   base + 4  PROG2  PRG_RST_DELAY[7:0]
+ *
+ * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each
+ * output's block at base =3D 0x15 + 16 * (out_idx % 6).
+ *
+ * The chip only supports unsigned positive delay.  A negative phase
+ * adjustment (advance) is wrapped to (T_out - |phase|) modulo one
+ * output period, which is identical for a periodic signal.
+ */
+
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
+                                    u8 out_idx, s32 phase_ps)
+{
+       const struct sit9531x_chip_info *info =3D sitdev->info;
+       u64 abs_ps, fvco, coarse, coarse_ps, rem_ps;
+       u8 page, base, prog6_val, fine =3D 0;
+       u8 pll_idx, slot;
+       u32 freq;
+       int rc, ret;
+
+       if (out_idx >=3D info->num_outputs)
+               return -EINVAL;
+
+       pll_idx =3D sitdev->out[out_idx].pll_idx;
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+
+       freq =3D sitdev->out[out_idx].freq;
+       if (!freq)
+               return -EINVAL;
+
+       fvco =3D sit9531x_get_fvco(sitdev, pll_idx);
+       if (!fvco)
+               return -EIO;
+
+       /*
+        * Convert to unsigned absolute delay.  Negative phase (advance)
+        * is rendered as T_out - |phase|, modulo the output period.
+        */
+       if (phase_ps =3D=3D 0) {
+               abs_ps =3D 0;
+       } else if (phase_ps > 0) {
+               abs_ps =3D (u64)phase_ps;
+       } else {
+               u64 t_out_ps =3D div64_u64(1000000000000ULL, freq);
+               u64 advance =3D (u64)(-(s64)phase_ps);
+
+               if (t_out_ps =3D=3D 0)
+                       return -EINVAL;
+               advance %=3D t_out_ps;
+               abs_ps =3D (advance =3D=3D 0) ? 0 : (t_out_ps - advance);
+       }
+
+       /*
+        * coarse_cycles =3D abs_ps * Fvco / 1e12 ps/s.
+        * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches
+        * one second of 1 PPS wrap-around.
+        */
+       coarse =3D mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);
+       if (coarse >=3D (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))
+               return -ERANGE;
+
+       /* Fine delay =3D round((abs_ps - coarse * vco_period_ps) / 30 ps) =
*/
+       coarse_ps =3D mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
+       rem_ps =3D (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;
+       if (rem_ps) {
+               u64 steps;
+
+               steps =3D div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS =
/ 2,
+                                 SIT9531X_OUT_PRG_FINE_STEP_PS);
+               if (steps > SIT9531X_OUT_PRG_FINE_MAX)
+                       steps =3D SIT9531X_OUT_PRG_FINE_MAX;
+               fine =3D (u8)steps;
+       }
+
+       /*
+        * Map logical output index to the chip's physical output slot.
+        * On SiT95317 the eight logical outputs land on chip slots
+        * {0, 3, 4, 5, 7, 8, 9, 11}; on SiT95316 the map is identity.
+        * Page/base must address the slot, not the logical index.
+        */
+       slot =3D info->clkout_map[out_idx];
+       page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
+              SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
+       base =3D SIT9531X_OUT_PRG_DELAY_BASE +
+              SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);
+
+       /* Caller (dpll.c) holds multiop_lock around the whole sequence. */
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       /*
+        * The PRG_RST_DELAY bytes live in the output system, so the writes
+        * only take effect when made inside the PRG_CMD programming state =
and
+        * committed to the NVM shadow, exactly like sit9531x_output_freq_s=
et().
+        */
+       rc =3D sit9531x_prg_enter(sitdev);
+       if (rc)
+               return rc;
+
+       /* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG(page, base),
+                             &prog6_val);
+       if (rc)
+               goto commit;
+
+       prog6_val &=3D SIT9531X_OUT_PRG_OPSTG_MASK;
+       prog6_val |=3D (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &
+                    SIT9531X_OUT_PRG_FINE_MASK;
+       prog6_val |=3D (u8)((coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MAS=
K);
+
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base),
+                              prog6_val);
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 1),
+                              (u8)((coarse >> 24) & 0xFF));
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 2),
+                              (u8)((coarse >> 16) & 0xFF));
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 3),
+                              (u8)((coarse >> 8) & 0xFF));
+       if (rc)
+               goto commit;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 4),
+                              (u8)(coarse & 0xFF));
+
+commit:
+       /*
+        * Always leave the PRG_CMD state via prg_commit(), even on a
+        * mid-sequence write failure, so the output loops are re-locked ra=
ther
+        * than stranded unlocked; keep the first error.
+        */
+       ret =3D sit9531x_prg_commit(sitdev);
+       if (ret && !rc)
+               rc =3D ret;
+       if (rc)
+               return rc;
+
+       /*
+        * Restart the output divider phase so the freshly programmed delay=
 is
+        * applied against a known edge instead of the divider's arbitrary
+        * running phase.
+        */
+       return sit9531x_output_phase_flush(sitdev, pll_idx);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Notification clear
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * sit9531x_clear_notifications - clear all notification registers
+ * @sitdev:    device pointer
+ *
+ * Clears all write-1-to-clear notification registers:
+ *   - PLL outer LOL notification (Page 0, reg 0x07)
+ *   - PLL holdover freeze notification (Page 0, reg 0x0B)
+ *   - PLL inner LOL notification (Page 0, reg 0x93)
+ *   - Clock monitor XO/PLL notification (Page 0, reg 0x9E)
+ *   - Clock input notifications (Page 6, regs 0x03/0x07/0x93/0x97)
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)
+{
+       int rc;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       /* Page 0x00 W1C notification registers */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTER_LOL_NOTIF, 0xFF=
);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_HO_FREEZE_NOTIF, 0xFF=
);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_NOTIF, =
0xFF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_CMON_NOTIF, 0xFF);
+       if (rc)
+               return rc;
+
+       /* Page 0x06 clock input monitor notifications */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_01, 0xFF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_23, 0xFF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_01, 0xFF);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_23, 0xFF);
+       if (rc)
+               return rc;
+
+       dev_dbg(sitdev->dev, "All notification registers cleared\n");
+       return 0;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * INTSYNC (inter-PLL synchronization)
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * INTSYNC configuration register values.
+ * These are written to the source PLL's EXT page to enable/disable
+ * inter-PLL synchronization (lock frequency PLL to phase PLL).
+ */
+struct sit9531x_intsync_reg {
+       u8 offset;
+       u8 en_val;
+       u8 dis_val;
+};
+
+static const struct sit9531x_intsync_reg intsync_config[] =3D {
+       { 0x2D, 0x02, 0x00 },
+       { 0x50, 0x08, 0x00 },
+       { 0x51, 0x04, 0x00 },
+       { 0x54, 0x02, 0x00 },
+       { 0x55, 0x28, 0x20 },
+       { 0x5C, 0x0F, 0x00 },
+       { 0x5D, 0xFF, 0x00 },
+       { 0x6C, 0xDD, 0x00 },
+};
+
+/**
+ * sit9531x_intsync_enable - enable inter-PLL synchronization
+ * @sitdev:    device pointer
+ * @src_pll_idx: source (frequency) PLL index (0-3)
+ *
+ * Enables INTSYNC global bit, unlocks the source PLL's EXT page
+ * debug registers, writes configuration, and triggers a small
+ * update on the source PLL.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
+{
+       u8 ext_page, val;
+       int rc, i;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (src_pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+
+       ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);
+
+       /* Set INTSYNC global enable bit (Page 0, reg 0x40 bit 6) */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
+                              val | BIT(SIT9531X_INTSYNC_EN_BIT));
+       if (rc)
+               return rc;
+
+       /* Small update on Page 0 */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+                              SIT9531X_PLL_SMALL_UPDATE_CMD);
+       if (rc)
+               return rc;
+
+       /* Unlock debug on EXT page */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PL=
L_REG_DEBUG),
+                              SIT9531X_PLL_DEBUG_UNLOCK);
+       if (rc)
+               return rc;
+
+       /* Write INTSYNC configuration */
+       for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {
+               rc =3D sit9531x_write_u8(sitdev,
+                                      SIT9531X_REG(ext_page,
+                                                   intsync_config[i].offse=
t),
+                                      intsync_config[i].en_val);
+               if (rc)
+                       return rc;
+       }
+
+       /* Small update on source PLL */
+       rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,
+                                  SIT9531X_PLL_REG_SMALL_UPDATE,
+                                  SIT9531X_PLL_SMALL_UPDATE_CMD);
+       if (rc)
+               return rc;
+
+       dev_info(sitdev->dev, "INTSYNC enabled on PLL%c\n",
+                'A' + src_pll_idx);
+       return 0;
+}
+
+/**
+ * sit9531x_intsync_disable - disable inter-PLL synchronization
+ * @sitdev:    device pointer
+ * @src_pll_idx: source (frequency) PLL index (0-3)
+ *
+ * Clears INTSYNC global bit, writes disable values to the source
+ * PLL's EXT page, and triggers a small update.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
+{
+       u8 ext_page, val;
+       int rc, i;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (src_pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+
+       ext_page =3D SIT9531X_PLL_EXT_PAGE(src_pll_idx);
+
+       /* Clear INTSYNC global enable bit */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
+                              val & ~BIT(SIT9531X_INTSYNC_EN_BIT));
+       if (rc)
+               return rc;
+
+       /* Small update on Page 0 */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+                              SIT9531X_PLL_SMALL_UPDATE_CMD);
+       if (rc)
+               return rc;
+
+       /* Unlock debug on EXT page */
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PL=
L_REG_DEBUG),
+                              SIT9531X_PLL_DEBUG_UNLOCK);
+       if (rc)
+               return rc;
+
+       /* Write INTSYNC configuration */
+       for (i =3D 0; i < ARRAY_SIZE(intsync_config); i++) {
+               rc =3D sit9531x_write_u8(sitdev,
+                                      SIT9531X_REG(ext_page,
+                                                   intsync_config[i].offse=
t),
+                                      intsync_config[i].dis_val);
+               if (rc)
+                       return rc;
+       }
+
+       /* Small update on source PLL */
+       rc =3D sit9531x_write_pll_u8(sitdev, src_pll_idx,
+                                  SIT9531X_PLL_REG_SMALL_UPDATE,
+                                  SIT9531X_PLL_SMALL_UPDATE_CMD);
+       if (rc)
+               return rc;
+
+       dev_info(sitdev->dev, "INTSYNC disabled on PLL%c\n",
+                'A' + src_pll_idx);
+       return 0;
+}
+
+/**
+ * sit9531x_pll_sysref_mode_set - configure SYSREF / SYNCB / Pulser output=
 mode
+ * @sitdev:            device pointer
+ * @pll_idx:           PLL index (0=3DPLLA ... 3=3DPLLD)
+ * @mode:              one of sit9531x_sysref_mode (DISABLE, SYSREF, SYNCB=
, PULSER)
+ * @target_outputs:    12-bit one-hot mask selecting which physical chip
+ *                     slots (0..11) are driven by this PLL's SYSREF/SYNCB
+ *
+ * Programs PLL_CONFIG47_PLL bits 6/5/4 (DIVO_PULSER_MODE / DIVO_SYSREF_MO=
DE
+ * / DIVO_SYNCB_MODE) and bits 3:0 (DIVO_SYS_REF[11:8]) plus
+ * Sysref_sel_PLL (DIVO_SYS_REF[7:0]).  The per-PLL small-change trigger
+ * enable on Page 0 reg 0x19 is set when mode !=3D DISABLE and cleared whe=
n
+ * mode =3D=3D DISABLE.
+ *
+ * The mask is one-hot per physical slot.  Callers needing to convert
+ * from logical output index must do so via info->clkout_map[].
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error.
+ */
+int sit9531x_pll_sysref_mode_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+                                enum sit9531x_sysref_mode mode,
+                                u16 target_outputs)
+{
+       u8 mode_bits =3D 0;
+       int rc;
+
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+       if (target_outputs & ~0x0FFFU)
+               return -EINVAL;
+
+       switch (mode) {
+       case SIT9531X_SYSREF_DISABLE:
+               break;
+       case SIT9531X_SYSREF_MODE_SYSREF:
+               mode_bits =3D SIT9531X_PLL_SYSREF_MODE_BIT;
+               break;
+       case SIT9531X_SYSREF_MODE_SYNCB:
+               mode_bits =3D SIT9531X_PLL_SYSREF_SYNCB_BIT;
+               break;
+       case SIT9531X_SYSREF_MODE_PULSER:
+               mode_bits =3D SIT9531X_PLL_SYSREF_PULSER_BIT |
+                           SIT9531X_PLL_SYSREF_MODE_BIT;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       /* PLL reg 0x47: mode bits [6:4] + DIVO_SYS_REF[11:8] in [3:0] */
+       rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                   SIT9531X_PLL_REG_SYSREF_MODE,
+                                   SIT9531X_PLL_SYSREF_MODE_MASK |
+                                   SIT9531X_PLL_SYSREF_TARGET_HI_MASK,
+                                   mode_bits |
+                                   ((target_outputs >> 8) &
+                                    SIT9531X_PLL_SYSREF_TARGET_HI_MASK));
+       if (rc)
+               return rc;
+
+       /* PLL reg 0x48: DIVO_SYS_REF[7:0] */
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_SYSREF_SEL,
+                                  target_outputs & 0xFF);
+       if (rc)
+               return rc;
+
+       /* Page 0 reg 0x19: enable small-change (SYSREF) trigger for this P=
LL */
+       {
+               u8 trig_bit =3D BIT(SIT9531X_DIVO_SYSREF_TRIG_BIT(pll_idx))=
;
+               u8 val;
+
+               rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_DIVO_TRIGGER_E=
N,
+                                     &val);
+               if (rc)
+                       return rc;
+               if (mode =3D=3D SIT9531X_SYSREF_DISABLE)
+                       val &=3D ~trig_bit;
+               else
+                       val |=3D trig_bit;
+               rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_DIVO_TRIGGER_=
EN,
+                                      val);
+               if (rc)
+                       return rc;
+       }
+
+       /*
+        * Gate the SYSREF output buffer (PLL-page 0xD5/0xD6 bit 7).  The m=
ode,
+        * target and trigger above are not enough on their own: with the
+        * buffer disabled the pad stays silent.  Enable both for any activ=
e
+        * mode, clear them on disable.
+        */
+       {
+               u8 oe =3D (mode =3D=3D SIT9531X_SYSREF_DISABLE) ?
+                       0 : SIT9531X_PLL_SYSREF_OE_BIT;
+
+               rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                           SIT9531X_PLL_REG_SYSREF_OE0,
+                                           SIT9531X_PLL_SYSREF_OE_BIT, oe)=
;
+               if (rc)
+                       return rc;
+               rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,
+                                           SIT9531X_PLL_REG_SYSREF_OE1,
+                                           SIT9531X_PLL_SYSREF_OE_BIT, oe)=
;
+               if (rc)
+                       return rc;
+       }
+
+       dev_info(sitdev->dev,
+                "PLL%c sysref mode=3D%d target_outputs=3D0x%03x\n",
+                'A' + pll_idx, mode, target_outputs);
+       return 0;
+}
+
+/**
+ * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte
+ * @sitdev:    device pointer
+ * @out_idx:   logical output index (translated to chip slot internally)
+ * @pulse_ctrl:        8-bit PULSE_CTRL value (PROG0)
+ *
+ * Writes ODRn_PROG0 on the output page (Page 3 for slots 0..5,
+ * Page 4 for slots 6..11) at offset 0x1B + 16 * (slot % 6).
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error.
+ */
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,
+                                  u8 out_idx, u8 pulse_ctrl)
+{
+       const struct sit9531x_chip_info *info =3D sitdev->info;
+       u8 slot, page, reg;
+       int rc, ret;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (out_idx >=3D info->num_outputs)
+               return -EINVAL;
+
+       slot =3D info->clkout_map[out_idx];
+       page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
+               SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
+       reg =3D SIT9531X_OUT_PROG0_BASE +
+             SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);
+
+       /*
+        * PROG0 lives in the output system, so like the DIVO and
+        * PRG_RST_DELAY writes it only takes effect inside the PRG_CMD
+        * programming state committed to the NVM shadow.
+        */
+       rc =3D sit9531x_prg_enter(sitdev);
+       if (rc)
+               return rc;
+
+       rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG(page, reg), pulse_ctr=
l);
+
+       /*
+        * Always leave the PRG_CMD state via prg_commit(), even if the wri=
te
+        * failed, so the output loops are re-locked rather than stranded
+        * unlocked; keep the first error.
+        */
+       ret =3D sit9531x_prg_commit(sitdev);
+       if (ret && !rc)
+               rc =3D ret;
+
+       return rc;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Phase offset readback (TDC)
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * sit9531x_phase_offset_read - read phase difference via TDC
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ * @phase_ps:  output phase difference in picoseconds
+ *
+ * Reads the Time-to-Digital Converter (TDC) 40-bit code from the
+ * PLL page registers, then converts to picoseconds using the VCO
+ * frequency: phase_diff =3D tdc_code / fvco.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
+                              s64 *phase_ps)
+{
+       u64 fvco, fvco_mhz;
+       s64 tdc_signed;
+       u64 tdc_raw;
+       int rc, i;
+       bool sign;
+       u8 v;
+
+       lockdep_assert_held(&sitdev->multiop_lock);
+
+       if (pll_idx >=3D SIT9531X_NUM_PLLS)
+               return -EINVAL;
+
+       /* Unlock the debug page so the TDC registers are accessible. */
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_DEBUG,
+                                  SIT9531X_PLL_DEBUG_UNLOCK);
+       if (rc)
+               return rc;
+
+       /* Configure TDC */
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_TDC_MODE,
+                                  SIT9531X_TDC_MODE_ENABLE);
+       if (rc)
+               return rc;
+       rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,
+                                  SIT9531X_PLL_REG_TDC_CFG,
+                                  SIT9531X_TDC_CFG_DEFAULT);
+       if (rc)
+               return rc;
+
+       /* Trigger TDC sampling by reading the trigger register 3 times */
+       for (i =3D 0; i < 3; i++) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_TDC_TRIGGER, &v)=
;
+               if (rc)
+                       return rc;
+       }
+
+       /* Read 40-bit TDC code (5 bytes: 0xB5-0xB9) */
+       tdc_raw =3D 0;
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_TDC_DATA_4, &v);
+       if (rc)
+               return rc;
+       sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));
+       tdc_raw =3D (u64)(v & 0x07) << 32;
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_TDC_DATA_3, &v);
+       if (rc)
+               return rc;
+       tdc_raw |=3D (u64)v << 24;
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_TDC_DATA_2, &v);
+       if (rc)
+               return rc;
+       tdc_raw |=3D (u64)v << 16;
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_TDC_DATA_1, &v);
+       if (rc)
+               return rc;
+       tdc_raw |=3D (u64)v << 8;
+
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_TDC_DATA_0, &v);
+       if (rc)
+               return rc;
+       tdc_raw |=3D v;
+
+       /*
+        * Apply sign.  Per the vendor reference the sign bit is active-hig=
h
+        * for a positive offset: bit set -> +code, bit clear -> -code.
+        */
+       tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;
+
+       /*
+        * Get VCO frequency for conversion.  Fvco=3D=3D0 means DIVN is not
+        * programmed (PLL unused on this board) -- skip silently rather
+        * than spamming the log on every poll cycle.
+        */
+       fvco =3D sit9531x_get_fvco(sitdev, pll_idx);
+       if (!fvco) {
+               dev_dbg(sitdev->dev, "PLL%c: Fvco unknown, skip TDC\n",
+                       'A' + pll_idx);
+               return -ENODEV;
+       }
+
+       /*
+        * phase_diff (seconds) =3D tdc_code / fvco
+        * phase_diff (ps) =3D tdc_code * 1e12 / fvco
+        *
+        * To avoid 64-bit overflow:
+        *   phase_ps =3D tdc_code * 1e6 / (fvco / 1e6)
+        */
+       fvco_mhz =3D div64_u64(fvco, 1000000ULL);
+       if (!fvco_mhz)
+               return -EIO;
+
+       *phase_ps =3D div64_s64(tdc_signed * 1000000LL, (s64)fvco_mhz);
+
+       return 0;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Hardware state fetch
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * sit9531x_ref_state_fetch - read input reference status from hardware
+ * @sitdev:    device pointer
+ * @index:     logical input index
+ *
+ * Reads LOS and OOF status for the given input lane from the Page 0x06
+ * clock monitor registers.  P and N lanes have separate register banks;
+ * each register carries two input pairs nibble-packed (even pair in
+ * bits [3:0], odd pair in [7:4]).
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)
+{
+       struct sit9531x_ref *ref;
+       unsigned int reg;
+       u8 pair, status;
+       int rc;
+
+       /*
+        * The XTAL/XO reference (index SIT9531X_MAX_INPUTS) is the on-chip
+        * oscillator that feeds every PLL.  It cannot be routed or deselec=
ted,
+        * so its pin is modelled as permanently connected (see
+        * sit9531x_dpll_xo_pin_ops) and its LOS/OOF flags are never consul=
ted.
+        * Only the routable per-lane inputs (0..num_inputs-1) are polled h=
ere.
+        */
+       if (index >=3D SIT9531X_MAX_INPUTS)
+               return -EINVAL;
+
+       ref =3D &sitdev->ref[index];
+       pair =3D sit9531x_input_pair(index);
+
+       if (sit9531x_input_is_n(index))
+               reg =3D pair < 2 ? SIT9531X_CLKMON_N_STATUS_01
+                              : SIT9531X_CLKMON_N_STATUS_23;
+       else
+               reg =3D pair < 2 ? SIT9531X_CLKMON_P_STATUS_01
+                              : SIT9531X_CLKMON_P_STATUS_23;
+
+       rc =3D sit9531x_read_u8(sitdev, reg, &status);
+       if (rc)
+               return rc;
+
+       if (pair & 1)
+               status >>=3D 4;
+
+       ref->los =3D !!(status & (BIT(SIT9531X_CLKMON_CLK_LOSS) |
+                               BIT(SIT9531X_CLKMON_CLK_LOSS_FD)));
+       ref->oof =3D !!(status & (BIT(SIT9531X_CLKMON_FREQ_FINE) |
+                               BIT(SIT9531X_CLKMON_FREQ_COARSE)));
+
+       return 0;
+}
+
+/*
+ * sit9531x_input_mode_fetch - detect SE/DE configuration of an input pair
+ * @sitdev:    device pointer
+ * @pair:      input pair number (0-3)
+ *
+ * Reads CLKINx_INPUT_MODE and stores the detected signal mode on both
+ * lanes of the pair.  A pair with neither SE lane enabled is running
+ * differential.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_input_mode_fetch(struct sit9531x_dev *sitdev, u8 pair)
+{
+       enum sit9531x_signal_mode sig_mode;
+       u8 mode;
+       int rc;
+
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_IN_MODE(pair), &mode);
+       if (rc)
+               return rc;
+
+       if (mode & (SIT9531X_IN_MODE_SE_P_EN | SIT9531X_IN_MODE_SE_N_EN))
+               sig_mode =3D SIT9531X_MODE_SE;
+       else
+               sig_mode =3D SIT9531X_MODE_DE;
+
+       sitdev->ref[pair * 2].sig_mode =3D sig_mode;
+       sitdev->ref[pair * 2 + 1].sig_mode =3D sig_mode;
+
+       dev_dbg(sitdev->dev, "CLKIN%u mode reg 0x%02x -> %s\n", pair, mode,
+               sig_mode =3D=3D SIT9531X_MODE_DE ? "differential" : "single=
-ended");
+
+       return 0;
+}
+
+/*
+ * sit9531x_chan_state_fetch - read PLL channel status from hardware
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ *
+ * Reads lock status and mode from the PLL status register.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_i=
dx)
+{
+       u8 status, holdover, input_sel, inner_lol, ho_freeze, activesel_reg=
;
+       struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];
+       int rc;
+
+       /* Read PLL lock/mode from PLL page */
+       rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                 SIT9531X_PLL_REG_STATUS, &status);
+       if (rc)
+               return rc;
+
+       /* Read holdover status from Page 0 */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_HOLDOVER_STATUS, &hold=
over);
+       if (rc)
+               return rc;
+
+       /*
+        * Read the input source the PLL has currently selected as its
+        * active reference.  This lives in the low nibble of the last
+        * register of the PLL's page-1 priority block (CLK_ACTIVESEL_PLL),
+        * not on the PLL page -- PLL-page 0x29 is a config register.
+        */
+       activesel_reg =3D SIT9531X_PRIO_BASE_REG +
+                       SIT9531X_PRIO_REGS_PER_PLL * pll_idx +
+                       SIT9531X_PRIO_ACTIVESEL_OFF;
+       rc =3D sit9531x_read_u8(sitdev,
+                             SIT9531X_REG(SIT9531X_PAGE_PRIOSYS,
+                                          activesel_reg),
+                             &input_sel);
+       if (rc)
+               return rc;
+
+       /* Read PLL inner loop loss-of-lock */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,
+                             &inner_lol);
+       if (rc)
+               return rc;
+
+       /* Read holdover freeze status */
+       rc =3D sit9531x_read_u8(sitdev, SIT9531X_REG_HO_FREEZE_STATUS, &ho_=
freeze);
+       if (rc)
+               return rc;
+
+       /*
+        * Holdover bit set means the PLL is in holdover -- i.e. NOT locked
+        * to its input.  Invert the polarity so chan->locked reflects the
+        * intuitive sense (true =3D=3D locked, false =3D=3D holdover / fre=
e-run).
+        */
+       chan->locked =3D !(holdover & BIT(pll_idx));
+       chan->mode =3D !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);
+       chan->selected_ref =3D
+               sit9531x_hw_src_input(input_sel & SIT9531X_PRIO_NIBBLE_MASK=
);
+       chan->inner_lol =3D !!(inner_lol & BIT(pll_idx));
+       chan->ho_freeze =3D !!(ho_freeze & BIT(pll_idx));
+
+       return 0;
+}
+
+/*
+ * sit9531x_out_state_fetch - read output status from hardware
+ * @sitdev:    device pointer
+ * @index:     output index
+ *
+ * Reads the output PLL association from the PLL page output map
+ * registers into out->routed / out->pll_idx, and the current drive
+ * state from the Hi-Z force bits into out->enabled.  The two are
+ * separate: routing decides whether the output gets a DPLL pin at all,
+ * while a muted but routed output keeps its pin and reports
+ * DPLL_PIN_STATE_DISCONNECTED until it is un-muted.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_out_state_fetch(struct sit9531x_dev *sitdev, u8 index)
+{
+       struct sit9531x_out *out =3D &sitdev->out[index];
+       u8 map_lo, map_hi, slot;
+       int pll_idx;
+       bool muted;
+       int rc;
+
+       slot =3D sitdev->info->clkout_map[index];
+
+       rc =3D sit9531x_output_forced_hiz(sitdev, slot, &muted);
+       if (rc)
+               return rc;
+
+       /*
+        * DT board-config override: the per-PLL OUTPUT_ENABLE bitmaps
+        * (0x27/0x28) do not unambiguously express output->PLL routing on
+        * every config (overlaps, and some outputs routed outside that
+        * path).  When the board supplies an explicit map, trust it.
+        */
+       if (sitdev->out_pll_map_valid) {
+               u8 m =3D sitdev->out_pll_map[index];
+
+               if (m < SIT9531X_NUM_PLLS) {
+                       out->pll_idx =3D m;
+                       out->routed =3D true;
+                       out->enabled =3D !muted;
+               } else {
+                       out->pll_idx =3D 0;
+                       out->routed =3D false;
+                       out->enabled =3D false;
+               }
+               return 0;
+       }
+
+       /*
+        * The OUT_MAP_LO/HI bitmaps are indexed by the physical slot the
+        * output occupies on the chip, not by the driver's logical output
+        * index (translated above via the chip-info clkout_map[]: identity
+        * on SiT95316, non-contiguous on SiT95317).
+        *
+        * Determine which PLL drives this output by checking each PLL's
+        * output map registers (0x27 =3D slots 8-11, 0x28 =3D slots 0-7).
+        */
+       for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_OUT_MAP_LO, &map=
_lo);
+               if (rc)
+                       return rc;
+
+               rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,
+                                         SIT9531X_PLL_REG_OUT_MAP_HI, &map=
_hi);
+               if (rc)
+                       return rc;
+
+               if (slot < 8) {
+                       if (map_lo & BIT(slot)) {
+                               out->pll_idx =3D pll_idx;
+                               out->routed =3D true;
+                               out->enabled =3D !muted;
+                               return 0;
+                       }
+               } else {
+                       if (map_hi & BIT(slot - 8)) {
+                               out->pll_idx =3D pll_idx;
+                               out->routed =3D true;
+                               out->enabled =3D !muted;
+                               return 0;
+                       }
+               }
+       }
+
+       /* Output not mapped to any PLL */
+       out->pll_idx =3D 0;
+       out->routed =3D false;
+       out->enabled =3D false;
+
+       return 0;
+}
+
+/*
+ * sit9531x_ref_pll_mask_fetch - seed the input-to-PLL usage masks
+ * @sitdev:    device pointer
+ *
+ * ref->pll_mask is the refcount the disconnect path uses to decide when
+ * an input receiver may be powered down: the physical input is only
+ * disabled once the last DPLL has released it.  It therefore has to
+ * start out matching the hardware.  Without this pass every mask starts
+ * at zero, and disconnecting an input from one DPLL drops the mask to
+ * zero and disables a receiver the other DPLLs are still locked to.
+ *
+ * An input is counted for a PLL when it appears in that PLL's Page-1
+ * priority table, which is exactly the condition the connect and
+ * disconnect callbacks maintain.  Sources that are not physical inputs
+ * (OCXO, INTSYNC) and reserved codes are skipped.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_ref_pll_mask_fetch(struct sit9531x_dev *sitdev)
+{
+       u8 srcs[SIT9531X_PRIO_MAX_SLOTS];
+       u8 pll_idx, slot, index;
+       int rc;
+
+       for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {
+               rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);
+               if (rc)
+                       return rc;
+
+               for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
+                       index =3D sit9531x_hw_src_input(srcs[slot]);
+                       if (index >=3D sitdev->info->num_inputs)
+                               continue;
+
+                       /*
+                        * On a differentially configured pair only the P l=
ane
+                        * has a DPLL pin, so that is the lane the connect =
and
+                        * disconnect callbacks account for.  Fold an N-lan=
e
+                        * table entry onto its P lane, otherwise the count
+                        * would land on a lane nothing ever releases.  The
+                        * signalling mode is already known here:
+                        * sit9531x_input_mode_fetch() runs first.
+                        */
+                       if (sit9531x_input_is_n(index) &&
+                           sitdev->ref[index].sig_mode =3D=3D SIT9531X_MOD=
E_DE)
+                               index--;
+
+                       sitdev->ref[index].pll_mask |=3D BIT(pll_idx);
+               }
+       }
+
+       return 0;
+}
+
+/*
+ * sit9531x_dev_state_fetch - read all hardware state at startup
+ * @sitdev:    device pointer
+ *
+ * Called once during probe to populate the initial state cache.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)
+{
+       int rc;
+       u8 i;
+
+       /* Detect SE/DE configuration before any per-lane access */
+       for (i =3D 0; i < sitdev->info->num_inputs / 2; i++) {
+               rc =3D sit9531x_input_mode_fetch(sitdev, i);
+               if (rc) {
+                       dev_err(sitdev->dev,
+                               "Failed to fetch CLKIN%u mode: %d\n", i, rc=
);
+                       return rc;
+               }
+       }
+
+       for (i =3D 0; i < sitdev->info->num_inputs; i++) {
+               rc =3D sit9531x_ref_state_fetch(sitdev, i);
+               if (rc) {
+                       dev_err(sitdev->dev,
+                               "Failed to fetch input %u state: %d\n", i, =
rc);
+                       return rc;
+               }
+       }
+
+       /*
+        * The priority-table read walks the Page-1 registers, so it runs
+        * with multiop_lock held like every other multi-register sequence.
+        * Nothing can race with it here -- the DPLLs are not registered an=
d
+        * the monitor is not running yet -- but the page handling stays
+        * serialised the same way as at runtime.
+        */
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_ref_pll_mask_fetch(sitdev);
+       mutex_unlock(&sitdev->multiop_lock);
+       if (rc) {
+               dev_err(sitdev->dev,
+                       "Failed to fetch input priority tables: %d\n", rc);
+               return rc;
+       }
+
+       for (i =3D 0; i < sitdev->info->num_outputs; i++) {
+               rc =3D sit9531x_out_state_fetch(sitdev, i);
+               if (rc) {
+                       dev_err(sitdev->dev,
+                               "Failed to fetch output %u state: %d\n", i,=
 rc);
+                       return rc;
+               }
+       }
+
+       for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {
+               rc =3D sit9531x_chan_state_fetch(sitdev, i);
+               if (rc) {
+                       dev_err(sitdev->dev,
+                               "Failed to fetch PLL%c state: %d\n",
+                               'A' + i, rc);
+                       return rc;
+               }
+       }
+
+       return 0;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Periodic work thread
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * sit9531x_dev_ref_states_update - update all input reference states
+ * @sitdev:    device pointer
+ */
+static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)
+{
+       int i, rc;
+
+       for (i =3D 0; i < sitdev->info->num_inputs; i++) {
+               rc =3D sit9531x_ref_state_fetch(sitdev, i);
+               if (rc)
+                       dev_warn(sitdev->dev,
+                                "Failed to get REF%u status: %d\n", i, rc)=
;
+       }
+}
+
+/*
+ * sit9531x_dev_chan_states_update - update all PLL channel states
+ * @sitdev:    device pointer
+ */
+static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)
+{
+       int i, rc;
+
+       for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {
+               rc =3D sit9531x_chan_state_fetch(sitdev, i);
+               if (rc)
+                       dev_warn(sitdev->dev,
+                                "Failed to get PLL%c state: %d\n",
+                                'A' + i, rc);
+       }
+}
+
+/*
+ * sit9531x_dev_periodic_work - periodic hardware state polling
+ * @work:      kthread_work pointer
+ *
+ * Polls hardware state at SIT9531X_STATUS_POLL_MS intervals.
+ * Updates reference and channel states, then delegates change
+ * detection to sit9531x_dpll_changes_check() for each registered DPLL.
+ */
+static void sit9531x_dev_periodic_work(struct kthread_work *work)
+{
+       struct sit9531x_dev *sitdev =3D container_of(work, struct sit9531x_=
dev,
+                                                  work.work);
+       struct sit9531x_dpll *sitdpll;
+       int rc;
+
+       /*
+        * Update the cached ref[]/chan[] arrays under multiop_lock so the
+        * fetches are serialised against the DPLL callbacks that read
+        * these fields and against the chip's page selector.
+        *
+        * The lock is then dropped before sit9531x_dpll_changes_check(),
+        * which calls dpll_pin_change_ntf() / dpll_device_change_ntf().
+        * Those notification helpers take DPLL-subsystem locks that are
+        * already held when our callbacks are invoked from netlink
+        * context, and nesting multiop_lock around them would invert the
+        * lock order.  changes_check() reads the cache published above,
+        * which is already consistent.
+        */
+       mutex_lock(&sitdev->multiop_lock);
+       sit9531x_dev_ref_states_update(sitdev);
+       sit9531x_dev_chan_states_update(sitdev);
+       mutex_unlock(&sitdev->multiop_lock);
+
+       /* Check for state changes on each registered DPLL */
+       list_for_each_entry(sitdpll, &sitdev->dplls, list)
+               sit9531x_dpll_changes_check(sitdpll);
+
+       /*
+        * Acknowledge the chip's notification latches after the tick has
+        * read and acted on them.  Without this, the W1C bits remain set
+        * and -- on boards that wire INTRB -- the line stays asserted,
+        * re-firing the threaded handler back to back.  The helper writes
+        * W1C bits across page 0 and page 6 and must run under
+        * multiop_lock to serialise the page selector against userspace
+        * dpll ops.  Failure is non-fatal: status was already consumed
+        * for this tick and the next tick re-processes whatever stayed
+        * latched.
+        */
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_clear_notifications(sitdev);
+       mutex_unlock(&sitdev->multiop_lock);
+       if (rc)
+               dev_warn_ratelimited(sitdev->dev,
+                                    "Failed to clear notifications: %d\n",
+                                    rc);
+
+       /* Run twice a second */
+       kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,
+                                  msecs_to_jiffies(SIT9531X_STATUS_POLL_MS=
));
+}
+
+/*
+ * sit9531x_irq_thread_fn - threaded IRQ handler for the chip's INTRB line
+ *
+ * Triggered when the chip asserts INTRB (and only when DT wires up the
+ * client interrupt; absent property =3D=3D handler never installed).  The
+ * action mirrors a periodic-work tick: queue an immediate run so status
+ * registers are read and DPLL changes_check fires without waiting for
+ * the next poll deadline.  Polling continues to run as a fallback.
+ */
+static irqreturn_t sit9531x_irq_thread_fn(int irq, void *data)
+{
+       struct sit9531x_dev *sitdev =3D data;
+       int rc;
+
+       /*
+        * Acknowledge the chip's notification latches from the threaded
+        * handler itself.  With IRQF_ONESHOT the line is unmasked on
+        * return, so deferring the W1C clear to the async kworker would
+        * let a still-asserted INTRB re-fire immediately (interrupt storm)=
.
+        * Clear here, then kick the poll worker to read state and run
+        * changes_check.
+        */
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_clear_notifications(sitdev);
+       mutex_unlock(&sitdev->multiop_lock);
+       if (rc)
+               dev_warn_ratelimited(sitdev->dev,
+                                    "IRQ: failed to clear notifications: %=
d\n",
+                                    rc);
+
+       kthread_mod_delayed_work(sitdev->kworker, &sitdev->work, 0);
+       return IRQ_HANDLED;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Device lifecycle -- start / stop / dpll_init / dpll_fini
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * sit9531x_dev_start - start normal operation
+ * @sitdev:    device pointer
+ *
+ * Fetches initial hardware state, registers all DPLL devices and
+ * their pins, and starts the periodic monitoring thread.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_dev_start(struct sit9531x_dev *sitdev)
+{
+       struct sit9531x_dpll *sitdpll;
+       int rc;
+
+       /* Fetch device state */
+       rc =3D sit9531x_dev_state_fetch(sitdev);
+       if (rc)
+               return rc;
+
+       /* Register all DPLLs */
+       list_for_each_entry(sitdpll, &sitdev->dplls, list) {
+               rc =3D sit9531x_dpll_register(sitdpll);
+               if (rc) {
+                       dev_err_probe(sitdev->dev, rc,
+                                     "Failed to register DPLL%u\n",
+                                     sitdpll->id);
+                       return rc;
+               }
+       }
+
+       /* Start monitoring */
+       kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);
+
+       return 0;
+}
+
+/**
+ * sit9531x_dev_stop - stop normal operation
+ * @sitdev:    device pointer
+ *
+ * Cancels the monitoring thread and unregisters all DPLL devices
+ * and their pins.
+ */
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev)
+{
+       struct sit9531x_dpll *sitdpll;
+
+       /* Stop monitoring */
+       kthread_cancel_delayed_work_sync(&sitdev->work);
+
+       /* Unregister all DPLLs */
+       list_for_each_entry(sitdpll, &sitdev->dplls, list) {
+               if (sitdpll->dpll_dev)
+                       sit9531x_dpll_unregister(sitdpll);
+       }
+}
+
+static void sit9531x_dev_dpll_fini(void *ptr)
+{
+       struct sit9531x_dpll *sitdpll, *next;
+       struct sit9531x_dev *sitdev =3D ptr;
+
+       /* Stop monitoring and unregister DPLLs */
+       sit9531x_dev_stop(sitdev);
+
+       /* Destroy monitoring thread */
+       if (sitdev->kworker) {
+               kthread_destroy_worker(sitdev->kworker);
+               sitdev->kworker =3D NULL;
+       }
+
+       /* Free all DPLLs */
+       list_for_each_entry_safe(sitdpll, next, &sitdev->dplls, list) {
+               list_del(&sitdpll->list);
+               sit9531x_dpll_free(sitdpll);
+       }
+}
+
+/*
+ * sit9531x_devm_dpll_init - allocate DPLLs and start the device
+ * @sitdev:    device pointer
+ *
+ * Allocates one DPLL per PLL channel, creates the monitoring thread,
+ * starts normal operation, and registers a devres cleanup action.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_devm_dpll_init(struct sit9531x_dev *sitdev)
+{
+       struct kthread_worker *kworker;
+       struct sit9531x_dpll *sitdpll;
+       unsigned int i;
+       int rc;
+
+       INIT_LIST_HEAD(&sitdev->dplls);
+
+       /*
+        * Initialize the monitoring work before anything that can fail int=
o
+        * the error path: sit9531x_dev_dpll_fini() -> sit9531x_dev_stop()
+        * calls kthread_cancel_delayed_work_sync(&sitdev->work)
+        * unconditionally, which must not run on an uninitialized work.
+        */
+       kthread_init_delayed_work(&sitdev->work, sit9531x_dev_periodic_work=
);
+
+       /* Allocate all DPLLs */
+       for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {
+               sitdpll =3D sit9531x_dpll_alloc(sitdev, i);
+               if (IS_ERR(sitdpll)) {
+                       dev_err_probe(sitdev->dev, PTR_ERR(sitdpll),
+                                     "Failed to alloc DPLL%u\n", i);
+                       rc =3D PTR_ERR(sitdpll);
+                       goto error;
+               }
+
+               list_add_tail(&sitdpll->list, &sitdev->dplls);
+       }
+
+       /* Start the monitoring thread worker */
+       kworker =3D kthread_run_worker(0, "sit9531x-%s",
+                                    dev_name(sitdev->dev));
+       if (IS_ERR(kworker)) {
+               rc =3D PTR_ERR(kworker);
+               goto error;
+       }
+       sitdev->kworker =3D kworker;
+
+       /* Start normal operation */
+       rc =3D sit9531x_dev_start(sitdev);
+       if (rc) {
+               dev_err_probe(sitdev->dev, rc, "Failed to start device\n");
+               goto error;
+       }
+
+       /* Add devres action to release DPLL related resources */
+       return devm_add_action_or_reset(sitdev->dev, sit9531x_dev_dpll_fini=
,
+                                       sitdev);
+
+error:
+       sit9531x_dev_dpll_fini(sitdev);
+
+       return rc;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Chip identification
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * sit9531x_read_variant_id - read chip variant ID byte from hardware
+ * @sitdev:    device pointer
+ * @id:                output variant ID byte
+ *
+ * Reads the single-byte variant identification register from Page 0
+ * reg 0x02 (95317 =3D 0x17, 95316 =3D 0x31).  Reg 0x03 holds a separate
+ * revision byte and is intentionally not consumed here.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)
+{
+       return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);
+}
+
+/*
+ * sit9531x_match_variant - match variant ID against known variants
+ * @id:        variant ID byte
+ *
+ * Return: pointer to chip_info on match, NULL on unknown ID
+ */
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {
+               if (sit9531x_chip_ids[i].id =3D=3D id)
+                       return &sit9531x_chip_ids[i];
+       }
+
+       return NULL;
+}
+
+/*
+ * sit9531x_derive_clock_id - build EUI-64 clock identifier
+ * @sitdev:    device pointer
+ *
+ * Generates a deterministic 64-bit identifier from the SiTime OUI,
+ * the chip ID, and the I2C address.  This provides a stable clock_id
+ * across reboots.
+ *
+ * Return: 64-bit clock identifier
+ */
+static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)
+{
+       u64 clkid;
+
+       clkid  =3D SIT9531X_OUI << 24;
+       clkid |=3D (u64)sitdev->info->id << 8;
+       clkid |=3D (u64)sitdev->client->addr;
+
+       return clkid;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Probe entry point
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * sit9531x_dev_probe - initialize SiT9531x device
+ * @sitdev:    pointer to device structure (caller-allocated)
+ *
+ * Common initialization: read chip ID, match variant, generate
+ * clock_id, initialize synchronization mutex, and register DPLL
+ * channels.  Called from the I2C probe function.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)
+{
+       struct clk *xtal_clk;
+       u8 variant_id;
+       int rc;
+
+       /*
+        * Read the external reference (XO) feeding the chip's XIN/XO_CLK
+        * input.  Required: Fvco computation does
+        * Fvco =3D Fref * (DIVN + frac/2^32) with Fref =3D xtal_freq << do=
ubler,
+        * so without a populated xtal_freq every freq_set/phase_adjust pat=
h
+        * dividing by Fvco fails with -EIO.  The rate normally comes from =
a
+        * "clocks" phandle (clock-names =3D "xtal").  As a fallback, when =
the
+        * firmware does not yet expose the XO through the clock framework,
+        * take the rate from a "clock-frequency" device property instead.
+        */
+       xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");
+       if (IS_ERR(xtal_clk))
+               return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),
+                                    "Failed to get xtal clock\n");
+       sitdev->xtal_freq =3D xtal_clk ? clk_get_rate(xtal_clk) : 0;
+       if (!sitdev->xtal_freq) {
+               u32 freq;
+
+               if (!device_property_read_u32(sitdev->dev, "clock-frequency=
",
+                                             &freq))
+                       sitdev->xtal_freq =3D freq;
+       }
+       if (!sitdev->xtal_freq)
+               return dev_err_probe(sitdev->dev, -EINVAL,
+                                    "no xtal rate: provide clocks=3D<&xo> =
+ clock-names=3D\"xtal\", or a clock-frequency property\n");
+       dev_info(sitdev->dev, "xtal_freq=3D%u Hz\n", sitdev->xtal_freq);
+
+       /*
+        * Optional DT-described reset line.  Requested in the deasserted
+        * state so any prior chip programming is not torn down by the
+        * request itself.  The driver deliberately never pulses reset at
+        * runtime: the chip configuration (filter coefficients, output
+        * routing, priority tables) is loaded from efuse or an NVM blob
+        * before probe, and a hardware reset would discard it.  The line
+        * is held deasserted only to guarantee the chip is out of reset
+        * for I2C.  Absent DT property =3D=3D descriptor stays NULL, no
+        * behaviour change.
+        *
+        * Must run before the first I2C access: if the board wires reset
+        * and starts with the line asserted, the chip is held in reset and
+        * variant-ID reads return -EIO/-ETIMEDOUT.
+        */
+       sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset"=
,
+                                                    GPIOD_OUT_LOW);
+       if (IS_ERR(sitdev->reset_gpio))
+               return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpi=
o),
+                                    "Failed to request reset gpio\n");
+       if (sitdev->reset_gpio) {
+               dev_info(sitdev->dev, "reset-gpios: present (held deasserte=
d)\n");
+               /*
+                * If the board powered up with RESETB asserted, requesting
+                * the line deasserted above just released the chip.  Wait =
for
+                * its internal boot to complete before the first I2C acces=
s so
+                * sit9531x_read_variant_id() below does not race chip
+                * readiness and return -EIO/-ETIMEDOUT.
+                */
+               fsleep(10000);
+       }
+
+       /*
+        * Optional board-config overrides for fixed (efuse/blob) routing
+        * that the chip registers do not expose unambiguously.  Absent
+        * properties leave pll_fvco[] zeroed (derive from DIVN) and
+        * out_pll_map_valid false (use the OUT_MAP registers).
+        */
+       device_property_read_u64_array(sitdev->dev, "sitime,pll-fvco",
+                                      sitdev->pll_fvco, SIT9531X_NUM_PLLS)=
;
+
+       if (device_property_present(sitdev->dev, "sitime,output-pll-map")) =
{
+               u32 map[SIT9531X_MAX_OUTPUTS];
+               int n, i;
+
+               /*
+                * Accept any 1..MAX_OUTPUTS length so the 8-output SiT9531=
7
+                * can supply an 8-entry map instead of being forced to pad=
 to
+                * 12.  Variant detection has not run yet; entries beyond t=
he
+                * detected num_outputs are simply never indexed.
+                *
+                * Default every entry to "unmapped" first: when a shorter =
map
+                * is supplied for a variant with more outputs, the trailin=
g
+                * entries must not read back as 0 (=3D=3D PLLA) and falsel=
y mark
+                * unrouted outputs as active in sit9531x_out_state_fetch()=
.
+                */
+               memset(sitdev->out_pll_map, SIT9531X_OUT_PLL_UNMAPPED,
+                      sizeof(sitdev->out_pll_map));
+
+               n =3D device_property_count_u32(sitdev->dev,
+                                             "sitime,output-pll-map");
+               if (n > 0 && n <=3D SIT9531X_MAX_OUTPUTS &&
+                   !device_property_read_u32_array(sitdev->dev,
+                                                   "sitime,output-pll-map"=
,
+                                                   map, n)) {
+                       for (i =3D 0; i < n; i++)
+                               sitdev->out_pll_map[i] =3D map[i];
+                       sitdev->out_pll_map_valid =3D true;
+               }
+       }
+
+       /* Read variant ID byte */
+       rc =3D sit9531x_read_variant_id(sitdev, &variant_id);
+       if (rc)
+               return rc;
+
+       /* Detect chip variant */
+       sitdev->info =3D sit9531x_match_variant(variant_id);
+       if (!sitdev->info)
+               return dev_err_probe(sitdev->dev, -ENODEV,
+                                    "Unknown variant ID: 0x%02x\n", varian=
t_id);
+
+       dev_info(sitdev->dev, "VariantID(0x%02X), %s (%u in, %u out)\n",
+                variant_id, sitdev->info->name,
+                sitdev->info->num_inputs, sitdev->info->num_outputs);
+
+       /* Generate deterministic clock ID */
+       sitdev->clock_id =3D sit9531x_derive_clock_id(sitdev);
+
+       /* No PLL sources inter-PLL synchronization until requested */
+       sitdev->intsync_src =3D -1;
+
+       /* Initialize mutex for multi-register atomic operations */
+       rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);
+       if (rc)
+               return dev_err_probe(sitdev->dev, rc,
+                                    "Failed to initialize mutex\n");
+
+       /*
+        * Register DPLL channels and create the kworker first.  The IRQ
+        * handler dereferences sitdev->kworker via
+        * kthread_mod_delayed_work(), so it must be live before any
+        * INTRB assertion can land on the request_threaded_irq path.
+        */
+       rc =3D sit9531x_devm_dpll_init(sitdev);
+       if (rc)
+               return rc;
+
+       /*
+        * Optional INTRB IRQ from DT.  The I2C subsystem populates
+        * client->irq from the node's "interrupts"/"interrupts-extended"
+        * property; if no IRQ is wired client->irq is 0 and we keep
+        * relying on the periodic poll.
+        */
+       sitdev->irq =3D sitdev->client ? sitdev->client->irq : 0;
+       if (sitdev->irq > 0) {
+               rc =3D devm_request_threaded_irq(sitdev->dev, sitdev->irq,
+                                              NULL, sit9531x_irq_thread_fn=
,
+                                              IRQF_ONESHOT,
+                                              dev_name(sitdev->dev), sitde=
v);
+               if (rc)
+                       return dev_err_probe(sitdev->dev, rc,
+                                            "Failed to request IRQ %d\n",
+                                            sitdev->irq);
+               dev_info(sitdev->dev,
+                        "INTRB IRQ %d wired (threaded handler kicks period=
ic poll)\n",
+                        sitdev->irq);
+       }
+
+       return 0;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * I2C driver
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+static int sit9531x_i2c_probe(struct i2c_client *client)
+{
+       struct sit9531x_dev *sitdev;
+       struct regmap *regmap;
+
+       regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);
+       if (IS_ERR(regmap))
+               return dev_err_probe(&client->dev, PTR_ERR(regmap),
+                                    "Failed to initialize regmap\n");
+
+       sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);
+       if (!sitdev)
+               return -ENOMEM;
+
+       sitdev->dev =3D &client->dev;
+       sitdev->client =3D client;
+       sitdev->regmap =3D regmap;
+       i2c_set_clientdata(client, sitdev);
+
+       return sit9531x_dev_probe(sitdev);
+}
+
+static const struct i2c_device_id sit9531x_i2c_id[] =3D {
+       { "sit95317" },
+       { "sit95316" },
+       { }
+};
+MODULE_DEVICE_TABLE(i2c, sit9531x_i2c_id);
+
+static const struct of_device_id sit9531x_of_match[] =3D {
+       { .compatible =3D "sitime,sit95317" },
+       { .compatible =3D "sitime,sit95316" },
+       { }
+};
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);
+
+static struct i2c_driver sit9531x_i2c_driver =3D {
+       .driver =3D {
+               .name           =3D "sit9531x",
+               .of_match_table =3D sit9531x_of_match,
+       },
+       .probe          =3D sit9531x_i2c_probe,
+       .id_table       =3D sit9531x_i2c_id,
+};
+module_i2c_driver(sit9531x_i2c_driver);
+
+MODULE_AUTHOR("Ali Rouhi <arouhi@sitime.com>");
+MODULE_AUTHOR("Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>");
+MODULE_DESCRIPTION("SiTime SiT9531x DPLL subsystem driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
new file mode 100644
index 000000000000..48adeaa8453e
--- /dev/null
+++ b/drivers/dpll/sit9531x/core.h
@@ -0,0 +1,388 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x DPLL core driver
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * Device structure, register access helpers, and core function
+ * declarations.
+ */
+
+#ifndef _SIT9531X_CORE_H
+#define _SIT9531X_CORE_H
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "regs.h"
+
+#define SIT9531X_NUM_PLLS              4
+#define SIT9531X_MAX_INPUTS            8
+#define SIT9531X_NUM_INPUT_PAIRS       (SIT9531X_MAX_INPUTS / 2)
+#define SIT9531X_MAX_OUTPUTS           12
+/* out_pll_map[] entry meaning "this output is not routed to any PLL" */
+#define SIT9531X_OUT_PLL_UNMAPPED      0xFF
+/*
+ * INTSYNC (the inter-PLL sync net) is modelled as two pins.  The
+ * destination PLL that locks to INTSYNC sees an input pin
+ * (SIT9531X_INTSYNC_PIN_ID, in the input id namespace after the physical
+ * inputs and the xtal); the source PLL that drives INTSYNC sees an output
+ * pin (SIT9531X_INTSYNC_OUT_PIN_ID, appended after the physical outputs).
+ */
+#define SIT9531X_INTSYNC_PIN_ID                (SIT9531X_MAX_INPUTS + 1)
+#define SIT9531X_INTSYNC_OUT_PIN_ID    SIT9531X_MAX_OUTPUTS
+#define SIT9531X_NUM_PINS              (SIT9531X_MAX_INPUTS + 2 + SIT9531X=
_MAX_OUTPUTS + 1)
+#define SIT9531X_STATUS_POLL_MS                500
+
+/* selected_ref value when the active source is not a registered input */
+#define SIT9531X_REF_INVALID           0xFF
+
+/* SiTime IEEE OUI for EUI-64 generation */
+#define SIT9531X_OUI                   0x0090C2FFFEULL
+
+struct sit9531x_dpll;
+
+/**
+ * struct sit9531x_chip_info - chip variant identification
+ * @id:                variant ID byte read from register
+ * @num_inputs:        number of input clock pins
+ * @num_outputs: number of output clock pins
+ * @name:      human-readable variant name
+ * @clkout_map:        per-output slot mapping (output index -> physical s=
lot)
+ */
+struct sit9531x_chip_info {
+       u8              id;
+       u8              num_inputs;
+       u8              num_outputs;
+       const char      *name;
+       const u8        *clkout_map;
+};
+
+/**
+ * enum sit9531x_signal_mode - input signal electrical mode
+ * @SIT9531X_MODE_SE: single-ended
+ * @SIT9531X_MODE_DE: differential
+ */
+enum sit9531x_signal_mode {
+       SIT9531X_MODE_SE =3D 0,
+       SIT9531X_MODE_DE,
+};
+
+/**
+ * struct sit9531x_ref - input reference state
+ * @freq:              configured frequency in Hz
+ * @enabled:           reference is enabled for monitoring
+ * @los:               loss-of-signal detected
+ * @oof:               out-of-frequency detected
+ * @pll_mask:          bitmask of PLLs this input feeds (bit 0 =3D PLLA)
+ * @label:             board label from DT or default
+ * @sig_mode:          signal mode of the pair this lane belongs to
+ *                     (detected from CLKINx_INPUT_MODE at probe)
+ */
+struct sit9531x_ref {
+       u32             freq;
+       bool            enabled;
+       bool            los;
+       bool            oof;
+       u8              pll_mask;
+       const char      *label;
+       enum sit9531x_signal_mode       sig_mode;
+};
+
+/**
+ * struct sit9531x_out - output state
+ * @freq:              current output frequency in Hz
+ * @enabled:           output is driving, i.e. not forced into Hi-Z
+ * @routed:            output is mapped to @pll_idx by the initial
+ *                     configuration; an unrouted output has no DPLL pin
+ * @pll_idx:           PLL driving this output (0-3)
+ * @label:             board label from DT or default
+ */
+struct sit9531x_out {
+       u32             freq;
+       bool            enabled;
+       bool            routed;
+       u8              pll_idx;
+       const char      *label;
+};
+
+/**
+ * struct sit9531x_chan - per-PLL channel state
+ * @locked:            PLL is locked (raw status register bit)
+ * @mode:              0 =3D sync (outer loop enabled), 1 =3D free-run
+ * @selected_ref:      logical input index of the currently selected
+ *                     reference (the INTSYNC net maps to
+ *                     SIT9531X_INTSYNC_PIN_ID), or SIT9531X_REF_INVALID
+ *                     when the hardware source encoding is reserved
+ * @inner_lol:         PLL inner loop loss-of-lock detected
+ * @ho_freeze:         holdover freeze active
+ */
+struct sit9531x_chan {
+       bool            locked;
+       u8              mode;
+       u8              selected_ref;
+       bool            inner_lol;
+       bool            ho_freeze;
+};
+
+/**
+ * struct sit9531x_dev - SiT9531x device instance
+ * @dev:               pointer to device
+ * @client:            I2C client
+ * @regmap:            regmap for register access
+ * @info:              detected chip variant info
+ * @multiop_lock:      mutex for multi-register atomic operations
+ * @ref:               array of input reference states
+ * @out:               array of output states
+ * @chan:              array of per-PLL channel states
+ * @xtal_freq:         crystal oscillator frequency in Hz
+ * @dplls:             list of registered DPLL devices
+ * @kworker:           kthread worker for periodic polling
+ * @work:              delayed work for periodic state checks
+ * @clock_id:          IEEE 1588 EUI-64 clock identifier
+ * @reset_gpio:                optional reset line (DT "reset-gpios"), NUL=
L if absent
+ * @irq:               optional INTRB IRQ number (from DT "interrupts" via=
 the
+ *                     I2C client), 0 if no IRQ is wired
+ * @pll_fvco:          optional per-PLL VCO in Hz from DT
+ *                     "sitime,pll-fvco"; 0 means derive from DIVN
+ * @out_pll_map:       optional per-output source PLL (0-3, 0xff =3D
+ *                     unmapped) from DT "sitime,output-pll-map"
+ * @out_pll_map_valid: true when out_pll_map[] was populated from DT;
+ *                     false means use the chip's OUT_MAP registers
+ * @intsync_src:       PLL index currently sourcing inter-PLL
+ *                     synchronization (INTSYNC), or -1 when disabled
+ */
+struct sit9531x_dev {
+       struct device                   *dev;
+       struct i2c_client               *client;
+       struct regmap                   *regmap;
+       const struct sit9531x_chip_info *info;
+       /* Serialises multi-step register sequences */
+       struct mutex                    multiop_lock;
+
+       /* Hardware state */
+       struct sit9531x_ref     ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xta=
l */
+       struct sit9531x_out     out[SIT9531X_MAX_OUTPUTS];
+       struct sit9531x_chan    chan[SIT9531X_NUM_PLLS];
+       u32                     xtal_freq;
+
+       /* DPLL channels */
+       struct list_head        dplls;
+
+       /* Monitor */
+       struct kthread_worker           *kworker;
+       struct kthread_delayed_work     work;
+
+       /* Device identity */
+       u64                     clock_id;
+
+       /* Optional DT-described GPIO / IRQ lines */
+       struct gpio_desc        *reset_gpio;
+       int                     irq;
+
+       /* Optional DT board-config overrides */
+       u64                     pll_fvco[SIT9531X_NUM_PLLS];
+       u8                      out_pll_map[SIT9531X_MAX_OUTPUTS];
+       bool                    out_pll_map_valid;
+
+       /* Inter-PLL synchronization state */
+       s8                      intsync_src;
+};
+
+extern const struct regmap_config sit9531x_regmap_config;
+
+/* ---- Core lifecycle ---- */
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);
+int  sit9531x_dev_start(struct sit9531x_dev *sitdev);
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev);
+
+/* ---- Register access ---- */
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+                    u8 *val);
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+                     u8 val);
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+                        u8 offset, u8 *val);
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+                         u8 offset, u8 val);
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+                          u8 offset, u8 mask, u8 val);
+
+/* ---- Input enable/disable ---- */
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);
+
+/* ---- Input priority ---- */
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+                           u8 input_idx, u8 prio);
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,
+                           u8 input_idx, u8 *prio);
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,
+                              u8 input_idx);
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,
+                           u8 input_idx);
+
+/* ---- Output enable/disable (Hi-Z control) ---- */
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);
+
+/* ---- DCO tuning ---- */
+int sit9531x_dco_adjust(struct sit9531x_dev *sitdev, u8 pll_idx, s64 ppb);
+
+/* ---- Output frequency ---- */
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
+                            u8 pll_idx, u64 frequency);
+int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
+                            u64 *frequency);
+
+/* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
+                                    u8 out_idx, s32 phase_ps);
+
+/* ---- Notification clear ---- */
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);
+
+/* ---- INTSYNC (inter-PLL synchronization) ---- */
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);
+
+/* ---- Per-PLL SYSREF / SYNCB / Pulser output mode ---- */
+enum sit9531x_sysref_mode {
+       SIT9531X_SYSREF_DISABLE,
+       SIT9531X_SYSREF_MODE_SYSREF,
+       SIT9531X_SYSREF_MODE_SYNCB,
+       SIT9531X_SYSREF_MODE_PULSER,
+};
+
+int sit9531x_pll_sysref_mode_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+                                enum sit9531x_sysref_mode mode,
+                                u16 target_outputs);
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,
+                                  u8 out_idx, u8 pulse_ctrl);
+
+/* ---- Phase offset (TDC readback) ---- */
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
+                              s64 *phase_ps);
+
+/* ---- State helpers ---- */
+
+/**
+ * sit9531x_pll_page - get register page for PLL index
+ * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)
+ */
+static inline u8 sit9531x_pll_page(u8 pll_idx)
+{
+       return SIT9531X_PAGE_PLLA + pll_idx;
+}
+
+/*
+ * Logical input pins are interleaved: even index =3D P lane, odd
+ * index =3D N lane of pair index/2 (IN0P, IN0N, IN1P, IN1N, ...).
+ * Index SIT9531X_MAX_INPUTS is the XO input.
+ */
+
+/**
+ * sit9531x_input_pair - get input pair number for a logical input index
+ * @index: logical input pin index
+ */
+static inline u8 sit9531x_input_pair(u8 index)
+{
+       return index >> 1;
+}
+
+/**
+ * sit9531x_input_is_n - check if a logical input index is an N lane
+ * @index: logical input pin index
+ */
+static inline bool sit9531x_input_is_n(u8 index)
+{
+       return index & 1;
+}
+
+/**
+ * sit9531x_input_hw_src - translate logical input index to source encodin=
g
+ * @index: logical input pin index
+ *
+ * The priority table and CLK_ACTIVESEL registers use a non-contiguous
+ * source encoding: 0-3 =3D CLK0P..CLK3P, 5 =3D OCXO, 6 =3D INTSYNC,
+ * 7-10 =3D CLK0N..CLK3N.
+ */
+static inline u8 sit9531x_input_hw_src(u8 index)
+{
+       if (index =3D=3D SIT9531X_MAX_INPUTS)
+               return SIT9531X_PRIO_SRC_OCXO;
+       if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)
+               return SIT9531X_PRIO_SRC_INTSYNC;
+       if (sit9531x_input_is_n(index))
+               return SIT9531X_PRIO_SRC_N_BASE + sit9531x_input_pair(index=
);
+       return sit9531x_input_pair(index);
+}
+
+/**
+ * sit9531x_hw_src_input - translate source encoding to logical input inde=
x
+ * @src: 4-bit hardware source encoding
+ *
+ * Return: logical input index (INTSYNC maps to SIT9531X_INTSYNC_PIN_ID),
+ * or SIT9531X_REF_INVALID if @src is a reserved value
+ */
+static inline u8 sit9531x_hw_src_input(u8 src)
+{
+       if (src < SIT9531X_NUM_INPUT_PAIRS)
+               return src * 2;
+       if (src =3D=3D SIT9531X_PRIO_SRC_OCXO)
+               return SIT9531X_MAX_INPUTS;
+       if (src =3D=3D SIT9531X_PRIO_SRC_INTSYNC)
+               return SIT9531X_INTSYNC_PIN_ID;
+       if (src >=3D SIT9531X_PRIO_SRC_N_BASE &&
+           src < SIT9531X_PRIO_SRC_N_BASE + SIT9531X_NUM_INPUT_PAIRS)
+               return (src - SIT9531X_PRIO_SRC_N_BASE) * 2 + 1;
+       return SIT9531X_REF_INVALID;
+}
+
+/**
+ * sit9531x_ref_state_get - get reference state by index
+ * @sitdev:    device pointer
+ * @index:     logical input index
+ *
+ * Return: pointer to the cached input reference state
+ */
+static inline const struct sit9531x_ref *
+sit9531x_ref_state_get(const struct sit9531x_dev *sitdev, u8 index)
+{
+       return &sitdev->ref[index];
+}
+
+/**
+ * sit9531x_out_state_get - get output state by index
+ * @sitdev:    device pointer
+ * @index:     logical output index
+ *
+ * Return: pointer to the cached output state
+ */
+static inline const struct sit9531x_out *
+sit9531x_out_state_get(const struct sit9531x_dev *sitdev, u8 index)
+{
+       return &sitdev->out[index];
+}
+
+/**
+ * sit9531x_chan_state_get - get channel state by PLL index
+ * @sitdev:    device pointer
+ * @pll_idx:   PLL index (0-3)
+ *
+ * Return: pointer to the cached per-PLL channel state
+ */
+static inline const struct sit9531x_chan *
+sit9531x_chan_state_get(const struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+       return &sitdev->chan[pll_idx];
+}
+
+#endif /* _SIT9531X_CORE_H */
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
new file mode 100644
index 000000000000..668d25b3c47a
--- /dev/null
+++ b/drivers/dpll/sit9531x/dpll.c
@@ -0,0 +1,1580 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiTime SiT9531x DPLL subsystem callbacks and registration
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * DPLL device ops, pin ops (separate input/output), pin registration,
+ * and periodic change detection.
+ *
+ */
+
+#include <linux/dpll.h>
+#include <linux/err.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/netlink.h>
+#include <linux/slab.h>
+
+#include "core.h"
+#include "dpll.h"
+#include "prop.h"
+#include "regs.h"
+
+/* Number of input + output pin positions for pin index allocation */
+#define SIT9531X_NUM_INPUT_PINS                (SIT9531X_MAX_INPUTS + 2) /=
* +xtal +INTSYNC */
+#define SIT9531X_NUM_OUTPUT_PINS       (SIT9531X_MAX_OUTPUTS + 1) /* +INTS=
YNC src */
+#define SIT9531X_NUM_PINS_TOTAL                (SIT9531X_NUM_INPUT_PINS + =
SIT9531X_NUM_OUTPUT_PINS)
+
+#define SIT9531X_ESYNC_FREQ_10MHZ      10000000ULL
+#define SIT9531X_ESYNC_PULSE_DEFAULT   50
+
+static const struct dpll_pin_frequency sit9531x_esync_ranges[] =3D {
+       DPLL_PIN_FREQUENCY(0),
+       DPLL_PIN_FREQUENCY(SIT9531X_ESYNC_FREQ_10MHZ),
+};
+
+static inline bool
+sit9531x_dpll_esync_pin_supported(const struct sit9531x_dpll_pin *dpin)
+{
+       return dpin->esync_control;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Pin direction helpers
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+static inline bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_p=
in *pin)
+{
+       return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;
+}
+
+static inline bool
+sit9531x_dpll_is_intsync_pin(const struct sit9531x_dpll_pin *pin)
+{
+       return sit9531x_dpll_is_input_pin(pin) &&
+              pin->id =3D=3D SIT9531X_INTSYNC_PIN_ID;
+}
+
+static inline bool
+sit9531x_dpll_is_intsync_src_pin(const struct sit9531x_dpll_pin *pin)
+{
+       return !sit9531x_dpll_is_input_pin(pin) &&
+              pin->id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID;
+}
+
+static inline bool
+sit9531x_dpll_is_xo_pin(const struct sit9531x_dpll_pin *pin)
+{
+       return sit9531x_dpll_is_input_pin(pin) &&
+              pin->id =3D=3D SIT9531X_MAX_INPUTS;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * dpll_device_ops callbacks
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * sit9531x_dpll_lock_status_get - report PLL lock/holdover state
+ *
+ * reads holdover register (Page 0 reg 0x06), PLL
+ * status register (PLL page reg 0x31), inner LOL (reg 0x92), and
+ * holdover freeze (reg 0x0A) to determine lock status and error.
+ */
+static int
+sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_p=
riv,
+                             enum dpll_lock_status *status,
+                             enum dpll_lock_status_error *status_error,
+                             struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       const struct sit9531x_chan *chan;
+
+       if (status_error)
+               *status_error =3D DPLL_LOCK_STATUS_ERROR_NONE;
+
+       chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       if (chan->locked) {
+               if (chan->mode)
+                       *status =3D DPLL_LOCK_STATUS_LOCKED;       /* free-=
run */
+               else
+                       *status =3D DPLL_LOCK_STATUS_LOCKED_HO_ACQ; /* sync=
 */
+       } else if (chan->ho_freeze) {
+               *status =3D DPLL_LOCK_STATUS_HOLDOVER;
+       } else {
+               *status =3D DPLL_LOCK_STATUS_UNLOCKED;
+       }
+
+       /* Report inner LOL as an error condition */
+       if (status_error && chan->inner_lol)
+               *status_error =3D DPLL_LOCK_STATUS_ERROR_UNDEFINED;
+
+       mutex_unlock(&sitdev->multiop_lock);
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_mode_get - report current PLL operating mode
+ *
+ * reads outer loop disable bit (PLL page reg 0x31[5]).
+ * Free-run -> MANUAL, sync -> AUTOMATIC.
+ */
+static int
+sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
+                      enum dpll_mode *mode, struct netlink_ext_ack *extack=
)
+{
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       const struct sit9531x_chan *chan;
+
+       chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);
+
+       mutex_lock(&sitdev->multiop_lock);
+       *mode =3D chan->mode ? DPLL_MODE_MANUAL : DPLL_MODE_AUTOMATIC;
+       mutex_unlock(&sitdev->multiop_lock);
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_mode_set - switch PLL between free-run and sync mode
+ *
+ * writes PLL page reg 0x31[5] to enable/disable the
+ * outer loop, then triggers a small update via reg 0x0F.
+ *
+ * The driver maps AUTOMATIC to sync mode (outer loop enabled; the PLL
+ * selects its reference automatically from the priority table) and
+ * MANUAL to free-run (outer loop disabled via bit 0x31[5]). The chip
+ * also has a separate manual-active-select path (MANUAL_ACTIVE_SEL_PLL
+ * plus the per-PLL man_in_sel registers) that can pin one reference
+ * while still syncing; that path is not wired to a DPLL callback here.
+ */
+static int
+sit9531x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
+                      enum dpll_mode mode, struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       u8 val;
+       int rc;
+
+       /*
+        * Outer loop disable bit:
+        *   0 =3D sync mode (outer loop enabled)  -> AUTOMATIC
+        *   1 =3D free-run (outer loop disabled)  -> MANUAL
+        */
+       val =3D (mode =3D=3D DPLL_MODE_MANUAL) ? SIT9531X_PLL_STATUS_OUTER_=
DIS : 0;
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       rc =3D sit9531x_update_pll_u8(sitdev, sitdpll->id,
+                                   SIT9531X_PLL_REG_STATUS,
+                                   SIT9531X_PLL_STATUS_OUTER_DIS, val);
+       if (rc) {
+               NL_SET_ERR_MSG(extack, "Failed to write PLL mode register")=
;
+               goto unlock;
+       }
+
+       /* Trigger small update to apply without full NVM cycle */
+       rc =3D sit9531x_write_pll_u8(sitdev, sitdpll->id,
+                                  SIT9531X_PLL_REG_SMALL_UPDATE,
+                                  SIT9531X_PLL_SMALL_UPDATE_CMD);
+       if (rc) {
+               NL_SET_ERR_MSG(extack, "Failed to trigger small update");
+               goto unlock;
+       }
+
+       /*
+        * Keep the cached mode in step with the register.  The periodic
+        * monitor refreshes it too, but sit9531x_dco_adjust() picks the
+        * inner- or outer-loop path from this cache and would otherwise
+        * act on the pre-switch mode until the next poll.
+        */
+       sitdev->chan[sitdpll->id].mode =3D !!val;
+
+unlock:
+       mutex_unlock(&sitdev->multiop_lock);
+
+       return rc;
+}
+
+/*
+ * sit9531x_dpll_supported_modes_get - report which modes the PLL supports
+ */
+static int
+sit9531x_dpll_supported_modes_get(const struct dpll_device *dpll,
+                                 void *dpll_priv, unsigned long *modes,
+                                 struct netlink_ext_ack *extack)
+{
+       __set_bit(DPLL_MODE_AUTOMATIC, modes);
+       __set_bit(DPLL_MODE_MANUAL, modes);
+
+       return 0;
+}
+
+static const struct dpll_device_ops sit9531x_dpll_device_ops =3D {
+       .lock_status_get        =3D sit9531x_dpll_lock_status_get,
+       .mode_get               =3D sit9531x_dpll_mode_get,
+       .mode_set               =3D sit9531x_dpll_mode_set,
+       .supported_modes_get    =3D sit9531x_dpll_supported_modes_get,
+       /* temp_get not available -- SiT9531x has no on-die temp sensor */
+};
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Input pin ops
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+static int
+sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,
+                                     void *pin_priv,
+                                     const struct dpll_device *dpll,
+                                     void *dpll_priv,
+                                     enum dpll_pin_direction *direction,
+                                     struct netlink_ext_ack *extack)
+{
+       *direction =3D DPLL_PIN_DIRECTION_INPUT;
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_frequency_get - read input pin frequency
+ *
+ * returns cached frequency from DT or last set.
+ */
+static int
+sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,
+                                     void *pin_priv,
+                                     const struct dpll_device *dpll,
+                                     void *dpll_priv, u64 *frequency,
+                                     struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       const struct sit9531x_ref *ref;
+
+       ref =3D sit9531x_ref_state_get(sitdpll->dev, dpin->id);
+       *frequency =3D ref->freq;
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state
+ *
+ * determines pin state from channel state: connected
+ * if this input is the selected reference on a locked PLL, selectable
+ * if enabled in automatic mode, disconnected otherwise.
+ */
+static int
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,
+                                         void *pin_priv,
+                                         const struct dpll_device *dpll,
+                                         void *dpll_priv,
+                                         enum dpll_pin_state *state,
+                                         struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       const struct sit9531x_chan *chan;
+       const struct sit9531x_ref *ref;
+
+       chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);
+       ref =3D sit9531x_ref_state_get(sitdev, dpin->id);
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       /*
+        * Report CONNECTED only when the PLL is genuinely locked to this
+        * input: not in holdover AND inner loop locked.  Gating on the
+        * holdover bit alone let an idle PLL that happens not to be in
+        * holdover (e.g. an unused PLLD) falsely claim its default source
+        * (IN0P) as connected right after probe.
+        */
+       if (chan->locked && !chan->inner_lol &&
+           chan->selected_ref =3D=3D dpin->id)
+               *state =3D DPLL_PIN_STATE_CONNECTED;
+       /* In auto mode, enabled inputs with good signal are selectable */
+       else if (!chan->mode && ref->enabled && !ref->los && !ref->oof)
+               *state =3D DPLL_PIN_STATE_SELECTABLE;
+       else
+               *state =3D DPLL_PIN_STATE_DISCONNECTED;
+
+       mutex_unlock(&sitdev->multiop_lock);
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state
+ *
+ * Enables or disables the physical input receiver via Page 0x02
+ * force/state registers (sit9531x_input_disable/enable()) and updates
+ * this DPLL's Page 1 priority table so the state is honoured by the
+ * PLL's automatic reference selection, not just at the input buffer.
+ *   DISCONNECTED -> drop the input from this DPLL's priority table and
+ *                  release this DPLL's claim on the input
+ *   SELECTABLE   -> claim the input for this DPLL and make it eligible
+ *                  again in the priority table
+ *   CONNECTED    -> same as SELECTABLE (the PLL auto-switch logic does
+ *                  the actual selection)
+ *
+ * The priority table is per PLL, so it is always updated for this DPLL.
+ * A single physical input feeds every DPLL, so the hardware receiver is
+ * only cut off once the last DPLL has released it: ref->pll_mask tracks
+ * which DPLLs currently claim the input, and the physical disable
+ * happens on the transition to an empty mask.
+ */
+static int
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,
+                                         void *pin_priv,
+                                         const struct dpll_device *dpll,
+                                         void *dpll_priv,
+                                         enum dpll_pin_state state,
+                                         struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       struct sit9531x_ref *ref =3D &sitdev->ref[dpin->id];
+       u8 hw_src =3D sit9531x_input_hw_src(dpin->id);
+       u8 pll_bit =3D BIT(sitdpll->id);
+       int rc;
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       switch (state) {
+       case DPLL_PIN_STATE_DISCONNECTED:
+               rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_s=
rc);
+               if (rc)
+                       break;
+               ref->pll_mask &=3D ~pll_bit;
+               if (ref->pll_mask)
+                       rc =3D 0; /* another DPLL still uses this input */
+               else
+                       rc =3D sit9531x_input_disable(sitdev, dpin->id);
+               break;
+       case DPLL_PIN_STATE_SELECTABLE:
+       case DPLL_PIN_STATE_CONNECTED:
+               rc =3D sit9531x_input_enable(sitdev, dpin->id);
+               if (rc)
+                       break;
+               rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src)=
;
+               if (rc)
+                       break;
+               /*
+                * Claim the input for this DPLL only once it is both enabl=
ed
+                * and present in the priority table.  Setting the mask bef=
ore
+                * prio_add would leak the claim if prio_add failed, keepin=
g the
+                * shared input receiver powered even after every DPLL rele=
ased
+                * it.
+                */
+               ref->pll_mask |=3D pll_bit;
+               break;
+       default:
+               rc =3D -EINVAL;
+               break;
+       }
+
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc)
+               NL_SET_ERR_MSG(extack, "Failed to set input pin state");
+
+       return rc;
+}
+
+/*
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority
+ *
+ * reads the PLL's priority table on Page 1 (via
+ * sit9531x_input_prio_get()) and returns the slot the input
+ * occupies, so pin-get reports the real hardware priority rather
+ * than a software default.
+ */
+static int
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,
+                                const struct dpll_device *dpll, void *dpll=
_priv,
+                                u32 *prio, struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       u8 slot;
+       int rc;
+
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,
+                                    sit9531x_input_hw_src(dpin->id), &slot=
);
+       mutex_unlock(&sitdev->multiop_lock);
+       if (rc)
+               return rc;
+
+       dpin->prio =3D slot;
+       *prio =3D slot;
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority
+ *
+ * writes input priority table on Page 1 via
+ * core.c sit9531x_input_prio_set().  Forces holdover during update.
+ */
+static int
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,
+                                const struct dpll_device *dpll, void *dpll=
_priv,
+                                u32 prio, struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       int rc;
+
+       if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {
+               NL_SET_ERR_MSG(extack, "Priority applies only to input pins=
");
+               return -EINVAL;
+       }
+
+       if (prio >=3D SIT9531X_PRIO_MAX_SLOTS) {
+               NL_SET_ERR_MSG(extack, "Priority out of range (0-11)");
+               return -EINVAL;
+       }
+
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,
+                                    sit9531x_input_hw_src(dpin->id),
+                                    (u8)prio);
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc) {
+               NL_SET_ERR_MSG(extack, "Failed to set input priority");
+               return rc;
+       }
+
+       dpin->prio =3D (u8)prio;
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_phase_adjust_get - read phase adjustment
+ *
+ * returns cached phase adjustment value (in ps).
+ */
+static int
+sit9531x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *pin,
+                                        void *pin_priv,
+                                        const struct dpll_device *dpll,
+                                        void *dpll_priv, s32 *phase_adjust=
,
+                                        struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+
+       *phase_adjust =3D dpin->phase_adjust;
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_phase_offset_get - read phase offset
+ *
+ * reads the TDC (Time-to-Digital Converter) hardware
+ * to measure the phase difference in picoseconds via
+ * sit9531x_phase_offset_read().
+ */
+static int
+sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,
+                                        void *pin_priv,
+                                        const struct dpll_device *dpll,
+                                        void *dpll_priv, s64 *phase_offset=
,
+                                        struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       s64 offset;
+       int rc;
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       /*
+        * The on-chip TDC is a per-PLL resource that always measures the
+        * phase difference between the VCO and the PLL's currently
+        * selected reference; it cannot be pointed at an arbitrary input.
+        * For any input that is not the active reference there is no
+        * meaningful per-pin phase offset, so report 0 instead of the
+        * active reference's value.
+        */
+       if (sitdev->chan[sitdpll->id].selected_ref !=3D dpin->id) {
+               mutex_unlock(&sitdev->multiop_lock);
+               dpin->phase_offset =3D 0;
+               *phase_offset =3D 0;
+               return 0;
+       }
+
+       rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);
+       mutex_unlock(&sitdev->multiop_lock);
+
+       /*
+        * -ENODEV means the PLL has no programmed DIVN (unused on this
+        * board); report phase_offset =3D 0 so a full pin-get dump does no=
t
+        * fail just because one DPLL is dormant.
+        */
+       if (rc =3D=3D -ENODEV) {
+               dpin->phase_offset =3D 0;
+               *phase_offset =3D 0;
+               return 0;
+       }
+       if (rc) {
+               NL_SET_ERR_MSG(extack, "TDC phase readback failed");
+               return rc;
+       }
+
+       /*
+        * The ABI reports phase offset in units of 1/DPLL_PHASE_OFFSET_DIV=
IDER
+        * picoseconds: the integer part of the attribute is the value divi=
ded
+        * by the divider, the remainder is the fraction.  The TDC resolves=
 one
+        * VCO period (hundreds of picoseconds), so the fractional digits a=
re
+        * always zero here, but the magnitude still has to be scaled or ev=
ery
+        * reading would be reported a thousand times too small.
+        */
+       offset *=3D DPLL_PHASE_OFFSET_DIVIDER;
+
+       dpin->phase_offset =3D offset;
+       *phase_offset =3D offset;
+       return 0;
+}
+
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {
+       .direction_get          =3D sit9531x_dpll_input_pin_direction_get,
+       .frequency_get          =3D sit9531x_dpll_input_pin_frequency_get,
+       .state_on_dpll_get      =3D sit9531x_dpll_input_pin_state_on_dpll_g=
et,
+       .state_on_dpll_set      =3D sit9531x_dpll_input_pin_state_on_dpll_s=
et,
+       .prio_get               =3D sit9531x_dpll_input_pin_prio_get,
+       .prio_set               =3D sit9531x_dpll_input_pin_prio_set,
+       .phase_adjust_get       =3D sit9531x_dpll_input_pin_phase_adjust_ge=
t,
+       .phase_offset_get       =3D sit9531x_dpll_input_pin_phase_offset_ge=
t,
+};
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * INTSYNC pin ops
+ *
+ * INTSYNC is the chip's inter-PLL sync net: one PLL drives it and other
+ * PLLs may lock to it instead of to an external reference.  The two
+ * roles are exposed as two separate pins so neither overloads the other:
+ *
+ *   - a source (output) pin registered on every DPLL.  Connecting it on a
+ *     DPLL makes that DPLL drive INTSYNC; only one DPLL may drive it at a
+ *     time.  It has no priority ops -- driving the net is not a reference
+ *     selection.
+ *   - a destination (input) pin registered on every DPLL.  Connecting it
+ *     on a DPLL makes that DPLL eligible to lock to INTSYNC as a
+ *     reference, so it carries the priority ops.
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/* ---- INTSYNC source (output) pin ---- */
+
+/* The INTSYNC source pin is an output; its direction_get is defined below=
. */
+static int
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,
+                                      void *pin_priv,
+                                      const struct dpll_device *dpll,
+                                      void *dpll_priv,
+                                      enum dpll_pin_direction *direction,
+                                      struct netlink_ext_ack *extack);
+
+static int
+sit9531x_dpll_intsync_src_state_on_dpll_get(const struct dpll_pin *pin,
+                                           void *pin_priv,
+                                           const struct dpll_device *dpll,
+                                           void *dpll_priv,
+                                           enum dpll_pin_state *state,
+                                           struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+
+       mutex_lock(&sitdev->multiop_lock);
+       if (sitdev->intsync_src =3D=3D sitdpll->id)
+               *state =3D DPLL_PIN_STATE_CONNECTED;
+       else
+               *state =3D DPLL_PIN_STATE_DISCONNECTED;
+       mutex_unlock(&sitdev->multiop_lock);
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_intsync_src_state_on_dpll_set - drive INTSYNC from a PLL
+ *
+ *   CONNECTED    -> this PLL drives the INTSYNC net
+ *   DISCONNECTED -> stop driving INTSYNC if this PLL drives it
+ *
+ * SELECTABLE is rejected: driving the net is an explicit output routing,
+ * not an automatic-selection candidate, matching the regular output pin.
+ */
+static int
+sit9531x_dpll_intsync_src_state_on_dpll_set(const struct dpll_pin *pin,
+                                           void *pin_priv,
+                                           const struct dpll_device *dpll,
+                                           void *dpll_priv,
+                                           enum dpll_pin_state state,
+                                           struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       int rc =3D 0;
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       switch (state) {
+       case DPLL_PIN_STATE_CONNECTED:
+               if (sitdev->intsync_src =3D=3D sitdpll->id)
+                       break;
+               if (sitdev->intsync_src >=3D 0) {
+                       NL_SET_ERR_MSG(extack,
+                                      "INTSYNC is already sourced by anoth=
er PLL");
+                       rc =3D -EBUSY;
+                       break;
+               }
+               rc =3D sit9531x_intsync_enable(sitdev, sitdpll->id);
+               if (!rc)
+                       sitdev->intsync_src =3D sitdpll->id;
+               break;
+       case DPLL_PIN_STATE_DISCONNECTED:
+               if (sitdev->intsync_src !=3D sitdpll->id)
+                       break;
+               rc =3D sit9531x_intsync_disable(sitdev, sitdpll->id);
+               if (!rc)
+                       sitdev->intsync_src =3D -1;
+               break;
+       default:
+               rc =3D -EINVAL;
+               break;
+       }
+
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc && rc !=3D -EBUSY)
+               NL_SET_ERR_MSG(extack, "Failed to set INTSYNC source state"=
);
+
+       return rc;
+}
+
+static const struct dpll_pin_ops sit9531x_dpll_intsync_src_pin_ops =3D {
+       .direction_get          =3D sit9531x_dpll_output_pin_direction_get,
+       .state_on_dpll_get      =3D sit9531x_dpll_intsync_src_state_on_dpll=
_get,
+       .state_on_dpll_set      =3D sit9531x_dpll_intsync_src_state_on_dpll=
_set,
+};
+
+/* ---- INTSYNC destination (input) pin ---- */
+
+/*
+ * sit9531x_dpll_intsync_dst_state_on_dpll_get - INTSYNC reference state
+ *
+ * CONNECTED when this PLL is locked to INTSYNC as its reference,
+ * SELECTABLE when it runs in automatic mode and a source PLL is driving
+ * INTSYNC, DISCONNECTED otherwise.  The PLL that drives INTSYNC can never
+ * be its own destination.
+ */
+static int
+sit9531x_dpll_intsync_dst_state_on_dpll_get(const struct dpll_pin *pin,
+                                           void *pin_priv,
+                                           const struct dpll_device *dpll,
+                                           void *dpll_priv,
+                                           enum dpll_pin_state *state,
+                                           struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       const struct sit9531x_chan *chan;
+
+       chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);
+
+       mutex_lock(&sitdev->multiop_lock);
+       if (sitdev->intsync_src =3D=3D sitdpll->id)
+               *state =3D DPLL_PIN_STATE_DISCONNECTED;
+       else if (chan->locked && !chan->inner_lol &&
+                chan->selected_ref =3D=3D SIT9531X_INTSYNC_PIN_ID)
+               *state =3D DPLL_PIN_STATE_CONNECTED;
+       else if (!chan->mode && sitdev->intsync_src >=3D 0)
+               *state =3D DPLL_PIN_STATE_SELECTABLE;
+       else
+               *state =3D DPLL_PIN_STATE_DISCONNECTED;
+       mutex_unlock(&sitdev->multiop_lock);
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_intsync_dst_state_on_dpll_set - lock a PLL to INTSYNC
+ *
+ *   CONNECTED/SELECTABLE -> add INTSYNC to this PLL's priority table
+ *   DISCONNECTED         -> drop INTSYNC from this PLL's priority table
+ *
+ * INTSYNC is an internal net with no physical receiver, so only the
+ * per-PLL priority table is touched; the source pin controls generation.
+ */
+static int
+sit9531x_dpll_intsync_dst_state_on_dpll_set(const struct dpll_pin *pin,
+                                           void *pin_priv,
+                                           const struct dpll_device *dpll,
+                                           void *dpll_priv,
+                                           enum dpll_pin_state state,
+                                           struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       u8 hw_src =3D sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID);
+       int rc;
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       switch (state) {
+       case DPLL_PIN_STATE_DISCONNECTED:
+               rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_s=
rc);
+               break;
+       case DPLL_PIN_STATE_SELECTABLE:
+       case DPLL_PIN_STATE_CONNECTED:
+               if (sitdev->intsync_src =3D=3D sitdpll->id) {
+                       NL_SET_ERR_MSG(extack,
+                                      "PLL cannot lock to the INTSYNC it d=
rives");
+                       rc =3D -EINVAL;
+                       break;
+               }
+               rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src)=
;
+               break;
+       default:
+               rc =3D -EINVAL;
+               break;
+       }
+
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc && rc !=3D -EINVAL)
+               NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state")=
;
+
+       return rc;
+}
+
+/*
+ * Do not add .frequency_get / the generic input state getter here: the
+ * destination pin id is SIT9531X_INTSYNC_PIN_ID, one past the end of the
+ * ref[] array (INTSYNC is an internal net with no ref[] entry).  The ops
+ * below only ever key on chan[] and the priority table, never ref[id].
+ */
+static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops =3D {
+       .direction_get          =3D sit9531x_dpll_input_pin_direction_get,
+       .state_on_dpll_get      =3D sit9531x_dpll_intsync_dst_state_on_dpll=
_get,
+       .state_on_dpll_set      =3D sit9531x_dpll_intsync_dst_state_on_dpll=
_set,
+       .prio_get               =3D sit9531x_dpll_input_pin_prio_get,
+       .prio_set               =3D sit9531x_dpll_input_pin_prio_set,
+};
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * XO (crystal oscillator) pin ops
+ *
+ * The XO is the chip's internal reference oscillator that feeds every
+ * PLL.  It is exposed so userspace can see the on-chip reference, but it
+ * cannot be routed or disconnected, so it is reported permanently
+ * connected and offers no state_on_dpll_set / prio ops.
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+static int
+sit9531x_dpll_xo_pin_state_on_dpll_get(const struct dpll_pin *pin,
+                                      void *pin_priv,
+                                      const struct dpll_device *dpll,
+                                      void *dpll_priv,
+                                      enum dpll_pin_state *state,
+                                      struct netlink_ext_ack *extack)
+{
+       *state =3D DPLL_PIN_STATE_CONNECTED;
+       return 0;
+}
+
+static const struct dpll_pin_ops sit9531x_dpll_xo_pin_ops =3D {
+       .direction_get          =3D sit9531x_dpll_input_pin_direction_get,
+       .frequency_get          =3D sit9531x_dpll_input_pin_frequency_get,
+       .state_on_dpll_get      =3D sit9531x_dpll_xo_pin_state_on_dpll_get,
+};
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Output pin ops
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+static int
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,
+                                      void *pin_priv,
+                                      const struct dpll_device *dpll,
+                                      void *dpll_priv,
+                                      enum dpll_pin_direction *direction,
+                                      struct netlink_ext_ack *extack)
+{
+       *direction =3D DPLL_PIN_DIRECTION_OUTPUT;
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency
+ *
+ * Reads the DIVO divider back from the chip and computes the live
+ * frequency as Fvco / DIVO.  Falls back to the cached value when the
+ * output is not resolvable through the divider chain (e.g. not mapped
+ * to a PLL), so a netlink dump never fails on such pins.
+ */
+static int
+sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,
+                                      void *pin_priv,
+                                      const struct dpll_device *dpll,
+                                      void *dpll_priv, u64 *frequency,
+                                      struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       int rc;
+
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_output_freq_get(sitdev, dpin->id, frequency);
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc)
+               *frequency =3D sit9531x_out_state_get(sitdev, dpin->id)->fr=
eq;
+
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_frequency_set - set output pin frequency
+ *
+ * computes DIVO =3D Fvco / frequency and writes the
+ * 34-bit output divider to the output system registers via
+ * sit9531x_output_freq_set().
+ */
+static int
+sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
+                                      void *pin_priv,
+                                      const struct dpll_device *dpll,
+                                      void *dpll_priv, u64 frequency,
+                                      struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       u8 actual_pll;
+       int rc;
+
+       /* Use the actual PLL that drives this output (populated by
+        * out_state_fetch from the chip's OUT_MAP registers), not the
+        * DPLL device id -- in our current registration all outputs are
+        * bound to DPLL 0 for convenience, but physically they may be
+        * driven by PLL A/B/C/D with different Fvco.
+        */
+       actual_pll =3D sitdev->out[dpin->id].pll_idx;
+
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
+                                     frequency);
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc)
+               NL_SET_ERR_MSG(extack, "Output frequency set failed");
+
+       return rc;
+}
+
+/*
+ * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state
+ *
+ * reports CONNECTED when the output is driven and
+ * DISCONNECTED when it has been muted via sit9531x_output_disable().
+ */
+static int
+sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,
+                                          void *pin_priv,
+                                          const struct dpll_device *dpll,
+                                          void *dpll_priv,
+                                          enum dpll_pin_state *state,
+                                          struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       const struct sit9531x_out *out;
+
+       out =3D sit9531x_out_state_get(sitdpll->dev, dpin->id);
+       *state =3D out->enabled ? DPLL_PIN_STATE_CONNECTED
+                             : DPLL_PIN_STATE_DISCONNECTED;
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output
+ *
+ * forces Hi-Z on the output pin via the Page 0x03
+ * force/state register pair.
+ *   CONNECTED    -> enable (release force, back to factory default)
+ *   DISCONNECTED -> disable (force Hi-Z)
+ */
+static int
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,
+                                          void *pin_priv,
+                                          const struct dpll_device *dpll,
+                                          void *dpll_priv,
+                                          enum dpll_pin_state state,
+                                          struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       int rc;
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       switch (state) {
+       case DPLL_PIN_STATE_CONNECTED:
+               rc =3D sit9531x_output_enable(sitdev, dpin->id);
+               break;
+       case DPLL_PIN_STATE_DISCONNECTED:
+               rc =3D sit9531x_output_disable(sitdev, dpin->id);
+               break;
+       default:
+               rc =3D -EINVAL;
+               break;
+       }
+
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc)
+               NL_SET_ERR_MSG(extack, "Failed to set output pin state");
+
+       return rc;
+}
+
+/*
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustmen=
t
+ *
+ * returns cached value.
+ */
+static int
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,
+                                         void *pin_priv,
+                                         const struct dpll_device *dpll,
+                                         void *dpll_priv, s32 *phase_adjus=
t,
+                                         struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+
+       *phase_adjust =3D dpin->phase_adjust;
+       return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment
+ *
+ * Programs the per-output PRG_RST_DELAY registers for deterministic
+ * phase offset; see sit9531x_output_phase_adjust_set() in core.c.
+ */
+static int
+sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,
+                                         void *pin_priv,
+                                         const struct dpll_device *dpll,
+                                         void *dpll_priv, s32 phase_adjust=
,
+                                         struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       int rc;
+
+       mutex_lock(&sitdev->multiop_lock);
+       rc =3D sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adj=
ust);
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (rc) {
+               NL_SET_ERR_MSG(extack, "Phase adjust failed");
+               return rc;
+       }
+
+       dpin->phase_adjust =3D phase_adjust;
+       return 0;
+}
+
+static int
+sit9531x_dpll_output_pin_esync_get(const struct dpll_pin *pin,
+                                  void *pin_priv,
+                                  const struct dpll_device *dpll,
+                                  void *dpll_priv,
+                                  struct dpll_pin_esync *esync,
+                                  struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+
+       if (!sit9531x_dpll_esync_pin_supported(dpin))
+               return -EOPNOTSUPP;
+
+       esync->range =3D sit9531x_esync_ranges;
+       esync->range_num =3D ARRAY_SIZE(sit9531x_esync_ranges);
+       esync->pulse =3D SIT9531X_ESYNC_PULSE_DEFAULT;
+       esync->freq =3D dpin->esync_freq;
+
+       return 0;
+}
+
+static int
+sit9531x_dpll_output_pin_esync_set(const struct dpll_pin *pin,
+                                  void *pin_priv,
+                                  const struct dpll_device *dpll,
+                                  void *dpll_priv,
+                                  u64 freq,
+                                  struct netlink_ext_ack *extack)
+{
+       struct sit9531x_dpll_pin *dpin =3D pin_priv;
+       struct sit9531x_dpll *sitdpll =3D dpll_priv;
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       u8 actual_pll;
+       int rc;
+
+       if (!sit9531x_dpll_esync_pin_supported(dpin)) {
+               NL_SET_ERR_MSG(extack,
+                              "Embedded sync not enabled for this pin");
+               return -EOPNOTSUPP;
+       }
+
+       actual_pll =3D sitdev->out[dpin->id].pll_idx;
+
+       mutex_lock(&sitdev->multiop_lock);
+
+       /*
+        * This output is a dedicated embedded-sync pin.
+        * Treat freq=3D0 as a request to disable the entire output.
+        */
+       if (!freq) {
+               rc =3D sit9531x_output_disable(sitdev, dpin->id);
+               if (!rc)
+                       dpin->esync_freq =3D 0;
+               mutex_unlock(&sitdev->multiop_lock);
+               return rc;
+       }
+
+       if (freq !=3D SIT9531X_ESYNC_FREQ_10MHZ) {
+               mutex_unlock(&sitdev->multiop_lock);
+               NL_SET_ERR_MSG(extack,
+                              "Only 10 MHz esync frequency is supported");
+               return -EINVAL;
+       }
+
+       rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
+                                     SIT9531X_ESYNC_FREQ_10MHZ);
+       /*
+        * Program the pulse generator (PROG0 PULSE_CTRL) so the embedded-s=
ync
+        * pulse is actually emitted; without it the output carries the clo=
ck
+        * but no esync marker.  SIT9531X_ESYNC_PULSE_DEFAULT is the same d=
uty
+        * the esync_get callback advertises.
+        */
+       if (!rc)
+               rc =3D sit9531x_output_pulse_ctrl_set(sitdev, dpin->id,
+                                                   SIT9531X_ESYNC_PULSE_DE=
FAULT);
+       if (!rc)
+               rc =3D sit9531x_output_enable(sitdev, dpin->id);
+
+       mutex_unlock(&sitdev->multiop_lock);
+
+       if (!rc)
+               dpin->esync_freq =3D SIT9531X_ESYNC_FREQ_10MHZ;
+
+       return rc;
+}
+
+static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {
+       .direction_get          =3D sit9531x_dpll_output_pin_direction_get,
+       .frequency_get          =3D sit9531x_dpll_output_pin_frequency_get,
+       .frequency_set          =3D sit9531x_dpll_output_pin_frequency_set,
+       .state_on_dpll_get      =3D sit9531x_dpll_output_pin_state_on_dpll_=
get,
+       .state_on_dpll_set      =3D sit9531x_dpll_output_pin_state_on_dpll_=
set,
+       .phase_adjust_get       =3D sit9531x_dpll_output_pin_phase_adjust_g=
et,
+       .phase_adjust_set       =3D sit9531x_dpll_output_pin_phase_adjust_s=
et,
+       .esync_get              =3D sit9531x_dpll_output_pin_esync_get,
+       .esync_set              =3D sit9531x_dpll_output_pin_esync_set,
+};
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Pin allocation, registration, and cleanup
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+static const struct dpll_pin_ops *
+sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)
+{
+       if (!sit9531x_dpll_is_input_pin(pin)) {
+               if (sit9531x_dpll_is_intsync_src_pin(pin))
+                       return &sit9531x_dpll_intsync_src_pin_ops;
+               return &sit9531x_dpll_output_pin_ops;
+       }
+       if (sit9531x_dpll_is_intsync_pin(pin))
+               return &sit9531x_dpll_intsync_dst_pin_ops;
+       if (sit9531x_dpll_is_xo_pin(pin))
+               return &sit9531x_dpll_xo_pin_ops;
+       return &sit9531x_dpll_input_pin_ops;
+}
+
+/*
+ * sit9531x_dpll_pin_alloc - allocate a DPLL pin
+ * @sitdpll:   DPLL device this pin belongs to
+ * @dir:       pin direction
+ * @id:                hardware pin index
+ *
+ * Return: pointer to allocated pin on success, error pointer on error
+ */
+static struct sit9531x_dpll_pin *
+sit9531x_dpll_pin_alloc(struct sit9531x_dpll *sitdpll,
+                       enum dpll_pin_direction dir, u8 id)
+{
+       struct sit9531x_dpll_pin *pin;
+
+       pin =3D kzalloc_obj(*pin, GFP_KERNEL);
+       if (!pin)
+               return ERR_PTR(-ENOMEM);
+
+       pin->dpll =3D sitdpll;
+       pin->dir =3D dir;
+       pin->id =3D id;
+
+       return pin;
+}
+
+/*
+ * sit9531x_dpll_pin_free - deallocate a DPLL pin
+ * @pin:       pin to free
+ */
+static void sit9531x_dpll_pin_free(struct sit9531x_dpll_pin *pin)
+{
+       WARN(pin->dpll_pin, "DPLL pin is still registered\n");
+       kfree(pin);
+}
+
+/*
+ * sit9531x_dpll_pin_register - register a DPLL pin with the subsystem
+ * @pin:       pin to register
+ * @index:     absolute pin index for clock_id namespace
+ *
+ * Gets pin properties from firmware, creates or gets a dpll_pin,
+ * and registers it with the parent DPLL device.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dpll_pin_register(struct sit9531x_dpll_pin *pin,
+                                     u32 index)
+{
+       struct sit9531x_dpll *sitdpll =3D pin->dpll;
+       struct sit9531x_pin_props *props;
+       const struct dpll_pin_ops *ops;
+       int rc;
+
+       /* Get pin properties from firmware nodes */
+       props =3D sit9531x_pin_props_get(sitdpll->dev, pin->dir, pin->id);
+       if (IS_ERR(props))
+               return PTR_ERR(props);
+
+       /* Save package label and firmware node */
+       strscpy(pin->label, props->package_label, sizeof(pin->label));
+       pin->fwnode =3D fwnode_handle_get(props->fwnode);
+       pin->esync_control =3D props->esync_control;
+
+       /* Create or get existing DPLL pin */
+       pin->dpll_pin =3D dpll_pin_get(sitdpll->dev->clock_id, index,
+                                    THIS_MODULE, &props->dpll_props,
+                                    &pin->tracker);
+       if (IS_ERR(pin->dpll_pin)) {
+               rc =3D PTR_ERR(pin->dpll_pin);
+               goto err_pin_get;
+       }
+       dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);
+
+       ops =3D sit9531x_dpll_pin_ops_get(pin);
+
+       /* Register the pin */
+       rc =3D dpll_pin_register(sitdpll->dpll_dev, pin->dpll_pin, ops, pin=
);
+       if (rc)
+               goto err_register;
+
+       /* Free pin properties */
+       sit9531x_pin_props_put(props);
+
+       return 0;
+
+err_register:
+       dpll_pin_put(pin->dpll_pin, &pin->tracker);
+err_pin_get:
+       /*
+        * On the dpll_pin_get() failure path pin->dpll_pin holds an ERR_PT=
R;
+        * clear it so the caller's sit9531x_dpll_pin_free() does not mista=
ke
+        * it for a still-registered pin and emit a spurious WARN().
+        */
+       pin->dpll_pin =3D NULL;
+       fwnode_handle_put(pin->fwnode);
+       pin->fwnode =3D NULL;
+       sit9531x_pin_props_put(props);
+
+       return rc;
+}
+
+/*
+ * sit9531x_dpll_pin_unregister - unregister a DPLL pin
+ * @pin:       pin to unregister
+ */
+static void sit9531x_dpll_pin_unregister(struct sit9531x_dpll_pin *pin)
+{
+       struct sit9531x_dpll *sitdpll =3D pin->dpll;
+       const struct dpll_pin_ops *ops;
+
+       WARN(!pin->dpll_pin, "DPLL pin is not registered\n");
+
+       ops =3D sit9531x_dpll_pin_ops_get(pin);
+
+       dpll_pin_unregister(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);
+       dpll_pin_put(pin->dpll_pin, &pin->tracker);
+       pin->dpll_pin =3D NULL;
+
+       fwnode_handle_put(pin->fwnode);
+       pin->fwnode =3D NULL;
+}
+
+/*
+ * sit9531x_dpll_pins_unregister - unregister all pins on a DPLL
+ * @sitdpll:   DPLL device
+ */
+static void sit9531x_dpll_pins_unregister(struct sit9531x_dpll *sitdpll)
+{
+       struct sit9531x_dpll_pin *pin, *next;
+
+       list_for_each_entry_safe(pin, next, &sitdpll->pins, list) {
+               sit9531x_dpll_pin_unregister(pin);
+               list_del(&pin->list);
+               sit9531x_dpll_pin_free(pin);
+       }
+}
+
+/*
+ * sit9531x_input_pin_is_registrable - check if an input pin is registrabl=
e
+ * @sitdev:    device pointer
+ * @index:     input pin index
+ *
+ * Split out so input-model changes stay local to this helper.
+ *
+ * Return: true if the input pin should be registered, false otherwise
+ */
+static bool sit9531x_input_pin_is_registrable(struct sit9531x_dev *sitdev,
+                                             u8 index)
+{
+       if (index >=3D sitdev->info->num_inputs)
+               return false;
+
+       /*
+        * The N lane of a differentially-configured pair is not a
+        * standalone input and is skipped (zl3073x model).
+        */
+       if (sit9531x_input_is_n(index) &&
+           sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)
+               return false;
+
+       return true;
+}
+
+/*
+ * sit9531x_dpll_pin_is_registrable - check if a pin should be registered
+ * @sitdpll:   DPLL device
+ * @dir:       pin direction
+ * @index:     pin hardware index
+ *
+ * For input pins: delegate to sit9531x_input_pin_is_registrable().
+ * For output pins: the pin is registrable if this DPLL is routed to it,
+ * whether or not it is currently driving.
+ *
+ * Return: true if pin should be registered, false otherwise
+ */
+static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll=
,
+                                            enum dpll_pin_direction dir,
+                                            u8 index)
+{
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {
+               /* The internal INTSYNC and XO pins are always registrable =
*/
+               if (index =3D=3D SIT9531X_INTSYNC_PIN_ID ||
+                   index =3D=3D SIT9531X_MAX_INPUTS)
+                       return true;
+
+               return sit9531x_input_pin_is_registrable(sitdev, index);
+       }
+
+       /* The internal INTSYNC source pin is always registrable */
+       if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)
+               return true;
+
+       /* Output -- check if driven by this DPLL */
+       if (index >=3D sitdev->info->num_outputs)
+               return false;
+
+       /*
+        * Routing, not the current drive state: an output the initial
+        * configuration muted still gets a pin, so userspace can see it an=
d
+        * un-mute it.  Only outputs no PLL drives are left unregistered.
+        */
+       return sitdev->out[index].pll_idx =3D=3D sitdpll->id &&
+              sitdev->out[index].routed;
+}
+
+/*
+ * sit9531x_dpll_pins_register - register all registrable pins
+ * @sitdpll:   DPLL device
+ *
+ * Enumerates all possible input and output pins, checks registrability,
+ * and registers each one.  Input pins come first, then output pins,
+ * with input pins first, then output pins.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dpll_pins_register(struct sit9531x_dpll *sitdpll)
+{
+       struct sit9531x_dpll_pin *pin;
+       enum dpll_pin_direction dir;
+       u8 id, index;
+       int rc;
+
+       for (index =3D 0; index < SIT9531X_NUM_PINS_TOTAL; index++) {
+               if (index < SIT9531X_NUM_INPUT_PINS) {
+                       id =3D index;
+                       dir =3D DPLL_PIN_DIRECTION_INPUT;
+               } else {
+                       id =3D index - SIT9531X_NUM_INPUT_PINS;
+                       dir =3D DPLL_PIN_DIRECTION_OUTPUT;
+               }
+
+               if (!sit9531x_dpll_pin_is_registrable(sitdpll, dir, id))
+                       continue;
+
+               pin =3D sit9531x_dpll_pin_alloc(sitdpll, dir, id);
+               if (IS_ERR(pin)) {
+                       rc =3D PTR_ERR(pin);
+                       goto error;
+               }
+
+               rc =3D sit9531x_dpll_pin_register(pin, index);
+               if (rc) {
+                       sit9531x_dpll_pin_free(pin);
+                       goto error;
+               }
+
+               list_add(&pin->list, &sitdpll->pins);
+       }
+
+       return 0;
+
+error:
+       sit9531x_dpll_pins_unregister(sitdpll);
+       return rc;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * DPLL device registration
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/*
+ * sit9531x_dpll_device_register - register a DPLL device
+ * @sitdpll:   DPLL to register
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dpll_device_register(struct sit9531x_dpll *sitdpll)
+{
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       int rc;
+
+       sitdpll->ops =3D sit9531x_dpll_device_ops;
+
+       sitdpll->dpll_dev =3D dpll_device_get(sitdev->clock_id, sitdpll->id=
,
+                                           THIS_MODULE, &sitdpll->tracker)=
;
+       if (IS_ERR(sitdpll->dpll_dev)) {
+               rc =3D PTR_ERR(sitdpll->dpll_dev);
+               sitdpll->dpll_dev =3D NULL;
+               return rc;
+       }
+
+       rc =3D dpll_device_register(sitdpll->dpll_dev,
+                                 sit9531x_prop_dpll_type_get(sitdev,
+                                                             sitdpll->id),
+                                 &sitdpll->ops, sitdpll);
+       if (rc) {
+               dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);
+               sitdpll->dpll_dev =3D NULL;
+       }
+
+       return rc;
+}
+
+/*
+ * sit9531x_dpll_device_unregister - unregister a DPLL device
+ * @sitdpll:   DPLL to unregister
+ */
+static void sit9531x_dpll_device_unregister(struct sit9531x_dpll *sitdpll)
+{
+       WARN(!sitdpll->dpll_dev, "DPLL device is not registered\n");
+
+       dpll_device_unregister(sitdpll->dpll_dev, &sitdpll->ops, sitdpll);
+       dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);
+       sitdpll->dpll_dev =3D NULL;
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * DPLL allocation and top-level register/unregister
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * sit9531x_dpll_alloc - allocate a DPLL device structure
+ * @sitdev:    parent device
+ * @ch:                PLL channel number (0-3)
+ *
+ * Return: pointer to allocated DPLL on success, error pointer on error
+ */
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch)
+{
+       struct sit9531x_dpll *sitdpll;
+
+       sitdpll =3D kzalloc_obj(*sitdpll, GFP_KERNEL);
+       if (!sitdpll)
+               return ERR_PTR(-ENOMEM);
+
+       sitdpll->dev =3D sitdev;
+       sitdpll->id =3D ch;
+       sitdpll->lock_status =3D DPLL_LOCK_STATUS_UNLOCKED;
+       INIT_LIST_HEAD(&sitdpll->pins);
+
+       return sitdpll;
+}
+
+/**
+ * sit9531x_dpll_free - deallocate a DPLL device structure
+ * @sitdpll:   DPLL to free
+ */
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll)
+{
+       WARN(sitdpll->dpll_dev, "DPLL device is still registered\n");
+       kfree(sitdpll);
+}
+
+/**
+ * sit9531x_dpll_register - register DPLL device and all its pins
+ * @sitdpll:   DPLL device
+ *
+ * Registers the DPLL device with the subsystem and then registers
+ * all input and output pins that are connected to this PLL.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_dpll_register(struct sit9531x_dpll *sitdpll)
+{
+       int rc;
+
+       rc =3D sit9531x_dpll_device_register(sitdpll);
+       if (rc)
+               return rc;
+
+       rc =3D sit9531x_dpll_pins_register(sitdpll);
+       if (rc) {
+               sit9531x_dpll_device_unregister(sitdpll);
+               return rc;
+       }
+
+       return 0;
+}
+
+/**
+ * sit9531x_dpll_unregister - unregister DPLL device and its pins
+ * @sitdpll:   DPLL device
+ */
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll)
+{
+       sit9531x_dpll_pins_unregister(sitdpll);
+       sit9531x_dpll_device_unregister(sitdpll);
+}
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ * Periodic change detection
+ * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ */
+
+/**
+ * sit9531x_dpll_changes_check - check for state changes and notify
+ * @sitdpll:   DPLL device
+ *
+ * Called from sit9531x_dev_periodic_work().  Compares current hardware
+ * state against cached values and sends netlink notifications on changes.
+ */
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll)
+{
+       struct sit9531x_dev *sitdev =3D sitdpll->dev;
+       enum dpll_lock_status lock_status;
+       struct sit9531x_dpll_pin *pin;
+       int rc;
+
+       /* Get current lock status */
+       rc =3D sit9531x_dpll_lock_status_get(sitdpll->dpll_dev, sitdpll,
+                                          &lock_status, NULL, NULL);
+       if (rc) {
+               dev_err(sitdev->dev, "Failed to get DPLL%u lock status: %d\=
n",
+                       sitdpll->id, rc);
+               return;
+       }
+
+       /* If lock status changed, notify DPLL core */
+       if (sitdpll->lock_status !=3D lock_status) {
+               sitdpll->lock_status =3D lock_status;
+               dpll_device_change_ntf(sitdpll->dpll_dev);
+       }
+
+       /* Check pins for autonomous state changes */
+       list_for_each_entry(pin, &sitdpll->pins, list) {
+               const struct dpll_pin_ops *ops;
+               enum dpll_pin_state state;
+
+               /*
+                * Poll input pins whose state can change autonomously: reg=
ular
+                * references and the INTSYNC destination pin.  Outputs (in=
cl.
+                * the INTSYNC source) change only through their own set
+                * callback and the XO is permanently connected, so skip th=
ose.
+                * Each pin's own state_on_dpll_get resolves to the right g=
etter.
+                */
+               if (!sit9531x_dpll_is_input_pin(pin) ||
+                   sit9531x_dpll_is_xo_pin(pin))
+                       continue;
+
+               ops =3D sit9531x_dpll_pin_ops_get(pin);
+               rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,
+                                           sitdpll->dpll_dev, sitdpll,
+                                           &state, NULL);
+               if (rc)
+                       continue;
+
+               if (state !=3D pin->pin_state) {
+                       dev_dbg(sitdev->dev, "%s state changed: %u->%u\n",
+                               pin->label, pin->pin_state, state);
+                       pin->pin_state =3D state;
+                       dpll_pin_change_ntf(pin->dpll_pin);
+               }
+       }
+}
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h
new file mode 100644
index 000000000000..76b3c5e2b95a
--- /dev/null
+++ b/drivers/dpll/sit9531x/dpll.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x DPLL subsystem interface
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * DPLL device and pin structures, and function declarations for
+ * the DPLL registration and callback layer.
+ */
+
+#ifndef _SIT9531X_DPLL_H
+#define _SIT9531X_DPLL_H
+
+#include <linux/dpll.h>
+#include <linux/list.h>
+#include <linux/types.h>
+
+struct sit9531x_dev;
+
+/**
+ * struct sit9531x_dpll_pin - per-pin DPLL state
+ * @list:              linked list entry within dpll->pins
+ * @dpll:              back-pointer to owning DPLL
+ * @dpll_pin:          registered dpll_pin object
+ * @tracker:           reference count tracker for dpll_pin_get/put
+ * @fwnode:            firmware node handle (from DT)
+ * @label:             package label string (e.g. "IN0", "OUT3")
+ * @dir:               pin direction (INPUT or OUTPUT)
+ * @id:                        hardware pin index (input 0-N or output 0-M=
)
+ * @prio:              current priority for automatic input selection
+ * @pin_state:         last saved pin state
+ * @phase_adjust:      current phase adjustment in picoseconds
+ * @phase_offset:      last measured phase offset
+ * @esync_control:     esync/sysref control allowed for this output pin
+ * @esync_freq:                last requested esync frequency (0 means dis=
abled)
+ */
+struct sit9531x_dpll_pin {
+       struct list_head                list;
+       struct sit9531x_dpll            *dpll;
+       struct dpll_pin                 *dpll_pin;
+       dpll_tracker                    tracker;
+       struct fwnode_handle            *fwnode;
+       char                            label[8];
+       enum dpll_pin_direction         dir;
+       u8                              id;
+       u8                              prio;
+       enum dpll_pin_state             pin_state;
+       s32                             phase_adjust;
+       s64                             phase_offset;
+       bool                            esync_control;
+       u64                             esync_freq;
+};
+
+/**
+ * struct sit9531x_dpll - per-PLL DPLL device state
+ * @list:              linked list entry within sitdev->dplls
+ * @dev:               back-pointer to parent sit9531x_dev
+ * @dpll_dev:          registered dpll_device object
+ * @tracker:           reference count tracker for dpll_device_get/put
+ * @ops:               copy of dpll_device_ops (per-instance)
+ * @pins:              list of registered pins
+ * @id:                        PLL channel number (0 =3D PLLA, 3 =3D PLLD)
+ * @lock_status:       cached DPLL lock status
+ */
+struct sit9531x_dpll {
+       struct list_head                list;
+       struct sit9531x_dev             *dev;
+       struct dpll_device              *dpll_dev;
+       dpll_tracker                    tracker;
+       struct dpll_device_ops          ops;
+       struct list_head                pins;
+       u8                              id;
+       enum dpll_lock_status           lock_status;
+};
+
+/* ---- DPLL allocation and registration ---- */
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 =
ch);
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll);
+int  sit9531x_dpll_register(struct sit9531x_dpll *sitdpll);
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll);
+
+/* ---- Periodic change detection ---- */
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);
+
+#endif /* _SIT9531X_DPLL_H */
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
new file mode 100644
index 000000000000..6fafac92a16a
--- /dev/null
+++ b/drivers/dpll/sit9531x/prop.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiTime SiT9531x firmware node property parsing
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * Retrieves pin properties from Device Tree firmware nodes (or
+ * applies defaults when no firmware node exists).
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/dpll.h>
+#include <linux/err.h>
+#include <linux/fwnode.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "core.h"
+#include "prop.h"
+
+/*
+ * sit9531x_input_pin_label - fill the package label for an input pin
+ * @sitdev:    pointer to device
+ * @props:     pointer to pin properties
+ * @id:                input pin index
+ *
+ * Split out so input-naming changes stay local to this helper.
+ */
+static void sit9531x_input_pin_label(struct sit9531x_dev *sitdev,
+                                    struct sit9531x_pin_props *props, u8 i=
d)
+{
+       u8 pair =3D sit9531x_input_pair(id);
+
+       if (sitdev->ref[id].sig_mode =3D=3D SIT9531X_MODE_DE)
+               snprintf(props->package_label,
+                        sizeof(props->package_label), "IN%u", pair);
+       else
+               snprintf(props->package_label,
+                        sizeof(props->package_label), "IN%u%c", pair,
+                        sit9531x_input_is_n(id) ? 'N' : 'P');
+}
+
+/*
+ * sit9531x_prop_pin_package_label_set - generate package label
+ * @sitdev:    pointer to device
+ * @props:     pointer to pin properties
+ * @dir:       pin direction
+ * @id:                pin index
+ *
+ * Generates a package label string.  Output pins are named "OUT0",
+ * "OUT1", ...  Input pins are named after the physical pair and lane:
+ * "IN0P", "IN0N", "IN1P", ... for single-ended lanes, or "IN0",
+ * "IN1", ... when the pair is configured differential (the N lane is
+ * not registered in that case).
+ */
+static void
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,
+                                   struct sit9531x_pin_props *props,
+                                   enum dpll_pin_direction dir, u8 id)
+{
+       /* The internal INTSYNC pin has a fixed label */
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&
+           id =3D=3D SIT9531X_INTSYNC_PIN_ID) {
+               strscpy(props->package_label, "INTSYNC",
+                       sizeof(props->package_label));
+               props->dpll_props.package_label =3D props->package_label;
+               return;
+       }
+
+       /* The internal XO reference has a fixed label */
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT && id =3D=3D SIT9531X_MAX_I=
NPUTS) {
+               strscpy(props->package_label, "XO",
+                       sizeof(props->package_label));
+               props->dpll_props.package_label =3D props->package_label;
+               return;
+       }
+
+       /* The internal INTSYNC source (output) pin has a fixed label */
+       if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&
+           id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {
+               strscpy(props->package_label, "SYNCOUT",
+                       sizeof(props->package_label));
+               props->dpll_props.package_label =3D props->package_label;
+               return;
+       }
+
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)
+               sit9531x_input_pin_label(sitdev, props, id);
+       else
+               snprintf(props->package_label, sizeof(props->package_label)=
,
+                        "OUT%u", id);
+
+       props->dpll_props.package_label =3D props->package_label;
+}
+
+/*
+ * sit9531x_prop_pin_fwnode_get - find firmware node for a pin
+ * @sitdev:    pointer to device
+ * @props:     pointer to pin properties
+ * @dir:       pin direction
+ * @id:                pin index
+ *
+ * Searches for input-pins/output-pins child nodes in DT, looking
+ * for a child whose "reg" property matches @id.
+ *
+ * Return: 0 on success, -ENOENT if no firmware node exists
+ */
+static int
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,
+                            struct sit9531x_pin_props *props,
+                            enum dpll_pin_direction dir, u8 id)
+{
+       struct fwnode_handle *pins_node, *pin_node;
+       const char *node_name;
+
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)
+               node_name =3D "input-pins";
+       else
+               node_name =3D "output-pins";
+
+       /* Get node containing input or output pins */
+       pins_node =3D device_get_named_child_node(sitdev->dev, node_name);
+       if (!pins_node) {
+               dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_nam=
e);
+               return -ENOENT;
+       }
+
+       /* Enumerate child pin nodes and find the requested one */
+       fwnode_for_each_child_node(pins_node, pin_node) {
+               u32 reg;
+
+               if (fwnode_property_read_u32(pin_node, "reg", &reg))
+                       continue;
+
+               if (id =3D=3D reg)
+                       break;
+       }
+
+       /* Release parent node */
+       fwnode_handle_put(pins_node);
+
+       /* Save found node */
+       props->fwnode =3D pin_node;
+
+       dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",
+               props->package_label, pin_node ? "" : "NOT ");
+
+       return pin_node ? 0 : -ENOENT;
+}
+
+/**
+ * sit9531x_pin_props_get - get pin properties for a given pin
+ * @sitdev:    pointer to device
+ * @dir:       pin direction (INPUT or OUTPUT)
+ * @index:     pin index
+ *
+ * Allocates a pin properties structure, generates a package label,
+ * looks up the firmware node if available, and reads optional
+ * properties (label, connection-type, supported-frequencies-hz,
+ * esync-control).
+ *
+ * Call sit9531x_pin_props_put() to free the returned structure.
+ *
+ * Return: pointer to pin properties on success, error pointer on error
+ */
+struct sit9531x_pin_props *
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
+                      enum dpll_pin_direction dir, u8 index)
+{
+       struct dpll_pin_frequency *ranges;
+       struct sit9531x_pin_props *props;
+       int i, j, num_freqs =3D 0, rc;
+       u64 *freqs =3D NULL;
+       const char *type;
+       u32 curr_freq;
+
+       props =3D kzalloc_obj(*props, GFP_KERNEL);
+       if (!props)
+               return ERR_PTR(-ENOMEM);
+
+       /* Set default pin type and capabilities */
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&
+           index =3D=3D SIT9531X_INTSYNC_PIN_ID) {
+               /*
+                * INTSYNC destination pin: a PLL locks to the INTSYNC net =
as a
+                * reference, so it can be connected and re-prioritised.
+                */
+               props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;
+               props->dpll_props.capabilities =3D
+                       DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
+                       DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+               curr_freq =3D 0;
+       } else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&
+                  index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {
+               /*
+                * INTSYNC source pin: a PLL drives the INTSYNC net.  It ca=
n be
+                * connected/disconnected but carries no priority (driving =
the
+                * net is not a reference selection) and no frequency.
+                */
+               props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;
+               props->dpll_props.capabilities =3D
+                       DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+               curr_freq =3D 0;
+       } else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&
+                  index =3D=3D SIT9531X_MAX_INPUTS) {
+               /* The XO reference is fixed: no state or priority control.=
 */
+               props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;
+               props->dpll_props.capabilities =3D 0;
+               sitdev->ref[index].freq =3D sitdev->xtal_freq;
+               curr_freq =3D sitdev->xtal_freq;
+       } else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {
+               props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;
+               props->dpll_props.capabilities =3D
+                       DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
+                       DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+               curr_freq =3D sitdev->ref[index].freq;
+       } else {
+               props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;
+               props->dpll_props.capabilities =3D
+                       DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+               curr_freq =3D sitdev->out[index].freq;
+       }
+
+       /* Allow phase-adjust over +/-1 ms window.  The subsystem rejects
+        * pin_set(phase-adjust, X) when X falls outside [min, max], so
+        * leaving these at 0 silently blocks every netlink call.  1 ms is
+        * well beyond the DCO dynamic range but costs nothing.
+        */
+       props->dpll_props.phase_range.min =3D -1000000000; /* -1 ms in ps *=
/
+       props->dpll_props.phase_range.max =3D  1000000000; /* +1 ms in ps *=
/
+
+       /* Generate package label */
+       sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);
+
+       /*
+        * Both INTSYNC pins are internal to the chip and have no board-lev=
el
+        * wiring, so they take no properties from the firmware node.
+        */
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&
+           index =3D=3D SIT9531X_INTSYNC_PIN_ID)
+               goto skip_fwnode_props;
+       if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&
+           index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)
+               goto skip_fwnode_props;
+
+       /* Get firmware node for the given pin */
+       rc =3D sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);
+       if (rc)
+               goto skip_fwnode_props;
+
+       /* Look for "label" property -> board label */
+       fwnode_property_read_string(props->fwnode, "label",
+                                   &props->dpll_props.board_label);
+
+       /* Look for "connection-type" property -> pin type enum */
+       if (!fwnode_property_read_string(props->fwnode, "connection-type",
+                                        &type)) {
+               if (!strcmp(type, "ext"))
+                       props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;
+               else if (!strcmp(type, "gnss"))
+                       props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;
+               else if (!strcmp(type, "int") ||
+                        !strcmp(type, "int-oscillator"))
+                       props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILL=
ATOR;
+               else if (!strcmp(type, "synce") ||
+                        !strcmp(type, "synce-eth-port"))
+                       props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_=
PORT;
+               else if (!strcmp(type, "mux"))
+                       props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;
+               else
+                       dev_warn(sitdev->dev,
+                                "Unknown pin type '%s'\n", type);
+       }
+
+       /* Check for embedded sync control */
+       props->esync_control =3D
+               fwnode_property_read_bool(props->fwnode, "esync-control");
+
+       /* Read supported frequencies property */
+       num_freqs =3D fwnode_property_count_u64(props->fwnode,
+                                             "supported-frequencies-hz");
+       if (num_freqs <=3D 0) {
+               num_freqs =3D 0;
+               goto skip_fwnode_props;
+       }
+
+       /* Read frequency list into temporary array */
+       freqs =3D kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);
+       if (!freqs) {
+               rc =3D -ENOMEM;
+               goto err_alloc_freqs;
+       }
+
+       fwnode_property_read_u64_array(props->fwnode,
+                                      "supported-frequencies-hz",
+                                      freqs, num_freqs);
+
+       /*
+        * Seed the runtime ref->freq / out->freq with the first DT-listed
+        * supported frequency so the netlink frequency_get callback report=
s
+        * a sane initial value before any pin_set occurs.  DT lists the
+        * physically-wired reference frequency for each input pin and the
+        * default output frequency for each output pin.
+        */
+       if (num_freqs > 0) {
+               if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)
+                       sitdev->ref[index].freq =3D (u32)freqs[0];
+               else
+                       sitdev->out[index].freq =3D (u32)freqs[0];
+               curr_freq =3D (u32)freqs[0];
+       }
+
+skip_fwnode_props:
+       /* Neither INTSYNC pin carries a frequency attribute */
+       if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&
+           index =3D=3D SIT9531X_INTSYNC_PIN_ID)
+               return props;
+       if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&
+           index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)
+               return props;
+
+       /* Allocate frequency ranges list -- DT discrete entries + current
+        * freq + one catch-all wide range so the subsystem never pre-
+        * rejects a frequency_set call.  The chip's real admissible set
+        * is bounded by VCO / divider math in sit9531x_output_freq_set().
+        */
+       ranges =3D kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);
+       if (!ranges) {
+               rc =3D -ENOMEM;
+               goto err_alloc_ranges;
+       }
+
+       /* Current freq as first entry */
+       ranges[0] =3D (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_fr=
eq);
+       j =3D 1;
+
+       /* Copy DT-listed freqs (if any), skipping curr_freq */
+       for (i =3D 0; i < num_freqs; i++) {
+               struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs=
[i]);
+
+               if (freqs[i] =3D=3D curr_freq)
+                       continue;
+               ranges[j++] =3D freq;
+       }
+
+       /* Always append a wide catch-all range */
+       ranges[j].min =3D 1;
+       ranges[j].max =3D 1000000000ULL; /* 1 GHz */
+       j++;
+
+       props->dpll_props.freq_supported =3D ranges;
+       props->dpll_props.freq_supported_num =3D j;
+
+       kfree(freqs);
+
+       return props;
+
+err_alloc_ranges:
+       kfree(freqs);
+err_alloc_freqs:
+       fwnode_handle_put(props->fwnode);
+       kfree(props);
+
+       return ERR_PTR(rc);
+}
+
+/**
+ * sit9531x_pin_props_put - release pin properties
+ * @props:     pin properties to free
+ */
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)
+{
+       kfree(props->dpll_props.freq_supported);
+
+       if (props->fwnode)
+               fwnode_handle_put(props->fwnode);
+
+       kfree(props);
+}
+
+/**
+ * sit9531x_prop_dpll_type_get - get DPLL channel type from firmware
+ * @sitdev:    pointer to device
+ * @index:     DPLL channel index (0-3)
+ *
+ * Reads the "dpll-types" string array property from the firmware node
+ * and returns the corresponding DPLL type enum.
+ *
+ * Return: DPLL type for the given channel (default: DPLL_TYPE_PPS)
+ */
+enum dpll_type
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)
+{
+       const char *types[SIT9531X_NUM_PLLS];
+       int count;
+
+       count =3D device_property_read_string_array(sitdev->dev, "dpll-type=
s",
+                                                 types, ARRAY_SIZE(types))=
;
+
+       if (index >=3D count)
+               return DPLL_TYPE_PPS;
+
+       if (!strcmp(types[index], "pps"))
+               return DPLL_TYPE_PPS;
+       else if (!strcmp(types[index], "eec"))
+               return DPLL_TYPE_EEC;
+
+       dev_info(sitdev->dev, "Unknown DPLL type '%s', using default\n",
+                types[index]);
+
+       return DPLL_TYPE_PPS;
+}
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h
new file mode 100644
index 000000000000..d0f5cccb435c
--- /dev/null
+++ b/drivers/dpll/sit9531x/prop.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x firmware node property parsing
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ */
+
+#ifndef _SIT9531X_PROP_H
+#define _SIT9531X_PROP_H
+
+#include <linux/dpll.h>
+#include <linux/fwnode.h>
+
+struct sit9531x_dev;
+
+/**
+ * struct sit9531x_pin_props - pin properties from firmware
+ * @fwnode:            firmware node handle (NULL if no DT node)
+ * @dpll_props:                DPLL core pin properties
+ * @package_label:     pin package label (e.g. "IN0", "OUT3")
+ * @esync_control:     embedded sync is controllable
+ */
+struct sit9531x_pin_props {
+       struct fwnode_handle            *fwnode;
+       struct dpll_pin_properties      dpll_props;
+       char                            package_label[8];
+       bool                            esync_control;
+};
+
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,
+                                          u8 index);
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sit=
dev,
+                                                 enum dpll_pin_direction d=
ir,
+                                                 u8 index);
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);
+
+#endif /* _SIT9531X_PROP_H */
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
new file mode 100644
index 000000000000..3c527ca4aaf6
--- /dev/null
+++ b/drivers/dpll/sit9531x/regs.h
@@ -0,0 +1,419 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x register definitions
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ */
+
+#ifndef _SIT9531X_REGS_H
+#define _SIT9531X_REGS_H
+
+/*
+ * I2C register model:
+ *   - Page select register at offset 0x01
+ *   - Each page has 128 registers (0x00-0x7F)
+ *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)
+ */
+#define SIT9531X_PAGE_SEL              0xFF
+#define SIT9531X_PAGE_SIZE             0x100
+#define SIT9531X_NUM_PAGES             32
+
+/* Helper macros for page:offset addressing */
+#define SIT9531X_REG(_page, _offset)           (((_page) << 8) | (_offset)=
)
+#define SIT9531X_REG_PAGE(_reg)                ((_reg) >> 8)
+#define SIT9531X_REG_OFFSET(_reg)              ((_reg) & 0xFF)
+
+/* ---- Page definitions ---- */
+#define SIT9531X_PAGE_MAINSYS0         0x00
+#define SIT9531X_PAGE_MAINSYS1         0x01
+#define SIT9531X_PAGE_INPUTSYS         0x02
+#define SIT9531X_PAGE_OUTSYS0          0x03
+#define SIT9531X_PAGE_OUTSYS1          0x04
+#define SIT9531X_PAGE_CLKMON0          0x06
+#define SIT9531X_PAGE_CLKMON1          0x07
+#define SIT9531X_PAGE_PLLA                     0x0A
+#define SIT9531X_PAGE_PLLA_EXT         0x1A
+#define SIT9531X_PAGE_PLLB                     0x0B
+#define SIT9531X_PAGE_PLLB_EXT         0x1B
+#define SIT9531X_PAGE_PLLC                     0x0C
+#define SIT9531X_PAGE_PLLC_EXT         0x1C
+#define SIT9531X_PAGE_PLLD                     0x0D
+#define SIT9531X_PAGE_PLLD_EXT         0x1D
+
+/* PLL index to page mapping */
+#define SIT9531X_PLL_PAGE(_idx) \
+       (SIT9531X_PAGE_PLLA + (_idx))
+
+/* ---- Page 0x00 (Main System) registers ---- */
+/*
+ * VARIANT_ID is a single byte at page 0 reg 0x02 (95317 =3D 0x17, 95316 =
=3D 0x31).
+ * Reg 0x03 carries an unrelated revision byte and must not be combined in=
to
+ * the variant identifier.
+ */
+#define SIT9531X_REG_VARIANT_ID                SIT9531X_REG(0x00, 0x02)
+#define SIT9531X_REG_HOLDOVER_STATUS           SIT9531X_REG(0x00, 0x06)
+#define SIT9531X_REG_SYNC_STATUS               SIT9531X_REG(0x00, 0x07)
+#define SIT9531X_REG_STATUS_1          SIT9531X_REG(0x00, 0x06)
+#define SIT9531X_REG_STATUS_2          SIT9531X_REG(0x00, 0x0A)
+
+/* DCO trigger register (Page 0x00) */
+#define SIT9531X_REG_DCO_TRIGGER               SIT9531X_REG(0x00, 0x64)
+#define SIT9531X_DCO_TRIGGER_INCR              BIT(6)
+#define SIT9531X_DCO_TRIGGER_DECR              BIT(4)
+#define SIT9531X_DCO_TRIGGER_BASE              0xAE
+
+/* DCO trigger pulse timing: minimum 6 ns required by hardware */
+#define SIT9531X_DCO_TRIGGER_PULSE_NS          167
+
+#define SIT9531X_REG_HOLDOVER_HISTORY  SIT9531X_REG(0x00, 0x58)
+
+/* Page 0 -- PLL inner loop loss-of-lock */
+#define SIT9531X_REG_PLL_INNER_LOL_STATUS      SIT9531X_REG(0x00, 0x92)
+#define SIT9531X_REG_PLL_INNER_LOL_NOTIF       SIT9531X_REG(0x00, 0x93)
+
+/* Page 0 -- Clock monitor PLL / XO status */
+#define SIT9531X_REG_CMON_NOTIF                SIT9531X_REG(0x00, 0x9E)
+
+/* Page 0 -- PLL outer-loop loss-of-lock */
+#define SIT9531X_REG_OUTER_LOL_STATUS  SIT9531X_REG(0x00, 0x06)
+#define SIT9531X_REG_OUTER_LOL_NOTIF           SIT9531X_REG(0x00, 0x07)
+
+/* Page 0 -- PLL holdover freeze status */
+#define SIT9531X_REG_HO_FREEZE_STATUS  SIT9531X_REG(0x00, 0x0A)
+#define SIT9531X_REG_HO_FREEZE_NOTIF   SIT9531X_REG(0x00, 0x0B)
+
+/* Page 0 -- INTSYNC (inter-PLL synchronization) global enable */
+#define SIT9531X_REG_INTSYNC_GLOBAL            SIT9531X_REG(0x00, 0x40)
+#define SIT9531X_INTSYNC_EN_BIT                6
+
+/* ---- Page 0x01 (Input Priority Table) registers ---- */
+/*
+ * Priority table: 6 registers per PLL, each holds two priority slots
+ * nibble-packed (even slot in [3:0], odd slot in [7:4]).
+ *
+ * Base registers for PLLA: 0x16-0x1B (slots 0-11).
+ * For PLL N:  base + 6 * N  (e.g. PLLB starts at 0x1C).
+ *
+ * Input source encoding (4-bit value):
+ *   0=3DIN0P, 1=3DIN1P, 2=3DIN2P, 3=3DIN3P, 4=3DIN4P,
+ *   5=3DOCXO, 6=3DINTSYNC,
+ *   7=3DIN0N, 8=3DIN1N, 9=3DIN2N, 10=3DIN3N, 11=3DIN4N
+ */
+#define SIT9531X_PAGE_PRIOSYS          0x01
+#define SIT9531X_PRIO_BASE_REG         0x16
+#define SIT9531X_PRIO_REGS_PER_PLL             6
+#define SIT9531X_PRIO_SLOTS_PER_REG            2
+#define SIT9531X_PRIO_MAX_SLOTS                12
+#define SIT9531X_PRIO_NIBBLE_MASK              0x0F
+#define SIT9531X_PRIO_HI_SHIFT         4
+/* Input source encoding values (see table above) */
+#define SIT9531X_PRIO_SRC_OCXO         5
+#define SIT9531X_PRIO_SRC_INTSYNC              6
+#define SIT9531X_PRIO_SRC_N_BASE               7
+/*
+ * The last register of each PLL's priority block holds, in its low
+ * nibble, the input source the PLL has currently selected as its
+ * active reference (CLK_ACTIVESEL_PLL, same 4-bit encoding as above).
+ */
+#define SIT9531X_PRIO_ACTIVESEL_OFF            5
+
+/* Page 0 -- Global update register (PRG_CMD / NVM / loop lock) */
+#define SIT9531X_REG_GLOBAL_UPDATE             SIT9531X_REG(0x00, 0x0F)
+
+/* PLL holdover control (PLL page offset) */
+#define SIT9531X_PLL_REG_HO_CTRL               0x6F
+#define SIT9531X_PLL_HO_FORCE_BIT              4
+
+/* ---- Page 0x02 (Input System) -- input disable control ---- */
+/* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */
+#define SIT9531X_REG_IN_DE_FORCE               SIT9531X_REG(0x02, 0xE8)
+#define SIT9531X_REG_IN_DE_STATE               SIT9531X_REG(0x02, 0xE9)
+#define SIT9531X_REG_IN_SEP_FORCE              SIT9531X_REG(0x02, 0xEA)
+#define SIT9531X_REG_IN_SEP_STATE              SIT9531X_REG(0x02, 0xEB)
+#define SIT9531X_REG_IN_SEN_FORCE              SIT9531X_REG(0x02, 0xF2)
+#define SIT9531X_REG_IN_SEN_STATE              SIT9531X_REG(0x02, 0xF3)
+
+/* ---- Page 0x02 -- CLKINx_INPUT_MODE (per input pair) ---- */
+/*
+ * One register per input pair at 0x1B + 0x10 * pair
+ * (CLKIN0 =3D 0x1B, CLKIN1 =3D 0x2B, CLKIN2 =3D 0x3B, CLKIN3 =3D 0x4B).
+ * SE_P_EN/SE_N_EN set means the corresponding lane is configured
+ * single-ended; both clear means the pair runs differential.
+ */
+#define SIT9531X_REG_IN_MODE(_pair)            \
+       SIT9531X_REG(0x02, 0x1B + 0x10 * (_pair))
+#define SIT9531X_IN_MODE_SE_P_EN               BIT(0)
+#define SIT9531X_IN_MODE_SE_N_EN               BIT(1)
+
+/* ---- Page 0x03 (Output System) registers -- Hi-Z control ---- */
+#define SIT9531X_REG_HIZ_DIFF_07_MASK  SIT9531X_REG(0x03, 0xF2)
+#define SIT9531X_REG_HIZ_DIFF_07_STATE SIT9531X_REG(0x03, 0xF3)
+#define SIT9531X_REG_HIZ_DIFF_811_MASK SIT9531X_REG(0x03, 0xF4)
+#define SIT9531X_REG_HIZ_DIFF_811_STATE        SIT9531X_REG(0x03, 0xF5)
+#define SIT9531X_REG_HIZ_SE_811_OE_MASK        SIT9531X_REG(0x03, 0xF4)
+#define SIT9531X_REG_HIZ_SE_811_OE_STATE       SIT9531X_REG(0x03, 0xF5)
+#define SIT9531X_REG_HIZ_SE_07_OE_MASK SIT9531X_REG(0x03, 0xF6)
+#define SIT9531X_REG_HIZ_SE_07_OE_STATE        SIT9531X_REG(0x03, 0xF7)
+#define SIT9531X_REG_HIZ_SE_07_MASK            SIT9531X_REG(0x03, 0xF8)
+#define SIT9531X_REG_HIZ_SE_07_STATE           SIT9531X_REG(0x03, 0xF9)
+#define SIT9531X_REG_HIZ_SE_811_MASK           SIT9531X_REG(0x03, 0xFA)
+#define SIT9531X_REG_HIZ_SE_811_STATE  SIT9531X_REG(0x03, 0xFB)
+
+/* ---- Pages 0x03/0x04 -- Output divider (DIVO) registers ---- */
+/*
+ * Output divider registers in Pages 3/4.  Each output has a 34-bit
+ * integer divider mapped to 5 bytes (LSB at base reg, MSB at base-4).
+ * Outputs 0-5 are on Page 3, outputs 6-11 are on Page 4.
+ *
+ * The base register for slot N within a page is:
+ *   clkout_odr_divn_base[slot] =3D { 0x14, 0x24, 0x34, 0x44, 0x54, 0x64 }
+ *
+ * Layout: base=3DLSB, base-1, base-2, base-3, base-4[1:0]=3DMSB.
+ *
+ * Per-chip clkout_map[] translates output index to slot position.
+ */
+#define SIT9531X_PAGE_OUTSYS0_SLOT_MAX 5   /* slots 0-5 on Page 0x03 */
+
+/* Misc output system registers */
+#define SIT9531X_REG_PRG_DIR_GEN               SIT9531X_REG(0x03, 0x0F)
+#define SIT9531X_PRG_CMD_STATE         0x01
+#define SIT9531X_UPDATE_NVM                    0x10
+#define SIT9531X_LOOP_LOCK                     0x40
+
+/* Debug register (same offset, per-page) */
+#define SIT9531X_REG_OUTSYS_DEBUG              SIT9531X_REG(0x03, 0xBD)
+#define SIT9531X_DEBUG_UNLOCK_VAL              0xC3
+
+/* ---- Pages 0x03/0x04 -- Output PRG_RST_DELAY (per-output phase delay) -=
--- */
+/*
+ * Per-output programmable phase delay: 34-bit coarse (in VCO clock
+ * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output
+ * has a five-byte block PROG6..PROG2:
+ *
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserve via RMW)
+ *                    [4:2] PRG_RST_FINE_DELAY[2:0]
+ *                    [1:0] PRG_RST_DELAY[33:32]
+ *   base + 1  PROG5  [7:0] PRG_RST_DELAY[31:24]
+ *   base + 2  PROG4  [7:0] PRG_RST_DELAY[23:16]
+ *   base + 3  PROG3  [7:0] PRG_RST_DELAY[15:8]
+ *   base + 4  PROG2  [7:0] PRG_RST_DELAY[7:0]
+ *
+ * Outputs 0-5 are on Page 3, outputs 6-11 on Page 4.  The block base
+ * within a page is 0x15 + 16 * (out_idx % 6).
+ */
+#define SIT9531X_OUT_PRG_DELAY_BASE            0x15
+#define SIT9531X_OUT_PRG_SLOT_STRIDE           0x10
+#define SIT9531X_OUT_PRG_OPSTG_MASK            0xE0    /* bits [7:5], pres=
erve */
+#define SIT9531X_OUT_PRG_FINE_SHIFT            2
+#define SIT9531X_OUT_PRG_FINE_MASK             0x1C    /* bits [4:2] */
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK                0x03    /* bits [1:=
0] */
+#define SIT9531X_OUT_PRG_FINE_STEP_PS          30
+#define SIT9531X_OUT_PRG_FINE_MAX              7       /* 3-bit field */
+#define SIT9531X_OUT_PRG_COARSE_BITS           34
+
+/* ---- Pages 0x03/0x04 -- Output PROG0 (PULSE_CTRL, 8-bit) ---- */
+/*
+ * Per-output pulse-count control byte used in SYSREF / SYNCB modes.
+ * Slot N within a page sits at 0x1B + 16 * (slot % 6).  Same page
+ * mapping as PRG_RST_DELAY: slots 0-5 on Page 3, slots 6-11 on Page 4.
+ */
+#define SIT9531X_OUT_PROG0_BASE                0x1B
+
+/* ---- Page 0 -- per-PLL DIVO trigger enables (NVMSPARE1_GENERIC, 0x19) -=
--- */
+/*
+ * One bit per PLL (A=3D0, B=3D1, C=3D2, D=3D3) for the small-change (SYSR=
EF
+ * trigger) path; bit n+4 enables the large-change (DIVO restart)
+ * path for the same PLL.  See SiT95316 register map p.6.
+ */
+#define SIT9531X_REG_DIVO_TRIGGER_EN   SIT9531X_REG(0x00, 0x19)
+#define SIT9531X_DIVO_SYSREF_TRIG_BIT(_pll)    (_pll)
+#define SIT9531X_DIVO_LARGE_TRIG_BIT(_pll)     ((_pll) + 4)
+
+/* ---- Page 0 -- GPIO_INPUT_FUNC_CTRL1 (0x65): register phase trigger ---=
- */
+/*
+ * On-demand phase-flush fired from a register rather than a GPIO pin.
+ * DIVO_PHASE_SEL_REG selects the in-register trigger source and
+ * DIVO_PHASE_TRIG flushes the output phase when pulsed high then low.
+ * The unrelated OEb trigger pair in bits [7:6] must be preserved.
+ */
+#define SIT9531X_REG_GPIO_FUNC_CTRL1   SIT9531X_REG(0x00, 0x65)
+#define SIT9531X_DIVO_PHASE_SEL_REG    BIT(5)
+#define SIT9531X_DIVO_PHASE_TRIG       BIT(4)
+
+/* ---- PLL_CONFIG47_PLL (per PLL page reg 0x47) ---- */
+/*
+ * Mode bits 6/5/4 select the SYSREF/SYNCB/PULSER variants; bits 3:0
+ * carry DIVO_SYS_REF[11:8] of the 12-bit one-hot output select that
+ * continues into reg 0x48[7:0].  See register map p.84.
+ */
+#define SIT9531X_PLL_REG_SYSREF_MODE   0x47
+#define SIT9531X_PLL_SYSREF_PULSER_BIT BIT(6)
+#define SIT9531X_PLL_SYSREF_MODE_BIT   BIT(5)
+#define SIT9531X_PLL_SYSREF_SYNCB_BIT  BIT(4)
+#define SIT9531X_PLL_SYSREF_MODE_MASK  (SIT9531X_PLL_SYSREF_PULSER_BIT | \
+                                        SIT9531X_PLL_SYSREF_MODE_BIT | \
+                                        SIT9531X_PLL_SYSREF_SYNCB_BIT)
+#define SIT9531X_PLL_SYSREF_TARGET_HI_MASK     0x0F
+#define SIT9531X_PLL_REG_SYSREF_SEL    0x48
+
+/*
+ * SYSREF output-buffer enable.  Per-PLL-page registers 0xD5/0xD6 bit 7
+ * gate the SYSREF/pulser output buffer and must be set in addition to the
+ * mode bits in 0x47; with the buffer disabled the mode/target/trigger are
+ * programmed but the pad stays silent.  These are not in the public
+ * register map (debug registers); the enable sequence is from the vendor.
+ */
+#define SIT9531X_PLL_REG_SYSREF_OE0    0xD5
+#define SIT9531X_PLL_REG_SYSREF_OE1    0xD6
+#define SIT9531X_PLL_SYSREF_OE_BIT     BIT(7)
+
+/* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */
+#define SIT9531X_PLL_REG_SMALL_UPDATE  0x0F
+
+/* On-demand phase-flush enable (PLL page reg 0x3D bit 7) */
+#define SIT9531X_PLL_REG_PHFL_CTRL     0x3D
+#define SIT9531X_PLL_PHFL_ON_DEMAND_EN BIT(7)
+
+/*
+ * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +
+ * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must =
not be
+ * reprogrammed at runtime; the register map flags them as
+ * "GUI generated configuration should not change manually".
+ */
+
+#define SIT9531X_PLL_REG_OUT_MAP_HI            0x27
+#define SIT9531X_PLL_REG_OUT_MAP_LO            0x28
+#define SIT9531X_PLL_REG_STATUS                0x31
+#define SIT9531X_PLL_REG_NVM_UPDATE            0x3F
+
+/* DIVN registers (free-run divider readback) */
+#define SIT9531X_PLL_REG_DIVN_INT              0x30
+#define SIT9531X_PLL_REG_DIVN_NUM              0x32  /* 4 bytes (0x32-0x35=
) */
+#define SIT9531X_PLL_REG_DIVN_DEN              0x38  /* 4 bytes (0x38-0x3B=
) */
+
+/* DIVN2 registers (sync divider readback) */
+#define SIT9531X_PLL_REG_DIVN2_INT             0x3E  /* 5 bytes (0x3E-0x42=
) */
+#define SIT9531X_PLL_REG_DIVN2_FRAC_NUM        0x43  /* 4 bytes (0x43-0x46=
) */
+#define SIT9531X_PLL_REG_DIVN2_FRAC_DEN        0x49  /* 4 bytes (0x49-0x4C=
) */
+
+/* Inner loop DCO word registers (48-bit fractional) */
+#define SIT9531X_PLL_REG_DCO_FRAC1             0x51
+#define SIT9531X_PLL_REG_DCO_FRAC2             0x52
+#define SIT9531X_PLL_REG_DCO_FRAC3             0x53
+#define SIT9531X_PLL_REG_DCO_FRAC4             0x54
+#define SIT9531X_PLL_REG_DCO_FRAC5             0x55
+#define SIT9531X_PLL_REG_DCO_FRAC6             0x56
+
+/* DCO function register */
+#define SIT9531X_PLL_REG_DCO_FUNC              0x57
+#define SIT9531X_DCO_MASK                      BIT(0)
+#define SIT9531X_DCO_EN                        BIT(1)
+#define SIT9531X_DCO_OUTER_EN          BIT(4)
+#define SIT9531X_DCO_DITHER_MODE               BIT(6)
+
+/* Outer loop DCO integer registers (24-bit) */
+#define SIT9531X_PLL_REG_DCO_INT_7             0x5E
+#define SIT9531X_PLL_REG_DCO_INT_15            0x5F
+#define SIT9531X_PLL_REG_DCO_INT_23            0x60
+
+/* Outer loop DCO fractional registers (32-bit, shifted <<16) */
+#define SIT9531X_PLL_REG_DCO_OFRAC_7   0x63
+#define SIT9531X_PLL_REG_DCO_OFRAC_15  0x64
+#define SIT9531X_PLL_REG_DCO_OFRAC_23  0x65
+#define SIT9531X_PLL_REG_DCO_OFRAC_31  0x66
+
+/* Debug register unlock */
+#define SIT9531X_PLL_REG_DEBUG         0xBD
+#define SIT9531X_PLL_DEBUG_UNLOCK              0xC3
+
+/* TDC (Time-to-Digital Converter) phase measurement -- PLL page */
+#define SIT9531X_PLL_REG_TDC_CFG               0xB3
+#define SIT9531X_PLL_REG_TDC_MODE              0xB4
+#define SIT9531X_TDC_MODE_ENABLE               0x80
+#define SIT9531X_TDC_CFG_DEFAULT               69
+#define SIT9531X_PLL_REG_TDC_DATA_0            0xB5  /* [7:0] */
+#define SIT9531X_PLL_REG_TDC_DATA_1            0xB6  /* [15:8] */
+#define SIT9531X_PLL_REG_TDC_DATA_2            0xB7  /* [23:16] */
+#define SIT9531X_PLL_REG_TDC_DATA_3            0xB8  /* [31:24] */
+#define SIT9531X_PLL_REG_TDC_DATA_4            0xB9  /* [39:32] + sign */
+#define SIT9531X_TDC_SIGN_BIT          3
+#define SIT9531X_PLL_REG_TDC_TRIGGER           0xD0  /* read to latch TDC =
sample */
+
+/*
+ * TDC phase-difference measurement setup (PLL page).  Per the vendor
+ * PhaseDifferenceReader reference procedure, a valid TDC reading needs
+ * the digital loop filter frozen (so the VCO does not track out the
+ * measured offset mid-sample) and, on PLLA (the 1PPS phase DPLL), the
+ * automatic phase/frequency-lock helpers held off.
+ */
+#define SIT9531X_PLL_REG_DLPF_FREEZE0  0x8A
+#define SIT9531X_PLL_REG_DLPF_FREEZE1  0x8B
+#define SIT9531X_PLL_DLPF_FREEZE_BIT   BIT(5)  /* freeze DLPF (hitless HO)=
 */
+#define SIT9531X_PLL_REG_APL_CTRL              0x4D
+#define SIT9531X_PLL_APL_WAKEUP_DIS_BIT        BIT(7)  /* disable APL at w=
ake-up */
+#define SIT9531X_PLL_APL_SWITCH_EN_BIT BIT(5)  /* APL on switchover */
+#define SIT9531X_PLL_REG_AFL_CTRL              0x4E
+#define SIT9531X_PLL_AFL_WAKEUP_DIS_BIT        BIT(5)  /* disable AFL at w=
ake-up */
+#define SIT9531X_PLL_CONFIG47_PHFL_BIT BIT(7)  /* PHFL enable (reg 0x47) *=
/
+#define SIT9531X_PLL_REG_ACTIVE                0x02
+#define SIT9531X_PLL_ACTIVE_BIT                BIT(0)  /* PLL reached acti=
ve state */
+#define SIT9531X_PLL_REG_RESTART               0x05
+#define SIT9531X_PLL_RESTART_BIT               BIT(0)  /* restart the PLL =
*/
+#define SIT9531X_PLL_REG_ZDB0          0x2B
+#define SIT9531X_PLL_REG_ZDB1          0x1E
+#define SIT9531X_PLL_ZDB_EN_BIT                BIT(4)  /* zero-delay buffe=
r enabled */
+
+/* PLL EXT page INTSYNC configuration registers */
+#define SIT9531X_PLL_EXT_PAGE(_idx)            (SIT9531X_PAGE_PLLA_EXT + (=
_idx))
+
+/* PLL STATUS register bits */
+#define SIT9531X_PLL_STATUS_LOCK               BIT(0)
+#define SIT9531X_PLL_STATUS_OUTER_DIS  BIT(5)
+
+/* Small update command */
+#define SIT9531X_PLL_SMALL_UPDATE_CMD  0x02
+
+/* ---- Clock monitor registers (Page 0x06) ---- */
+/*
+ * Per-input clock monitor status registers.  Each register holds
+ * status for two inputs (even input in bits [3:0], odd in [7:4]).
+ * P-polarity and N-polarity inputs have separate register banks.
+ *
+ * Bit layout per input nibble:
+ *   [0] freq_fine_drifted   -- fine frequency drift detected
+ *   [1] freq_coarse_drifted -- coarse frequency drift detected
+ *   [2] clk_loss            -- clock input loss (LOS)
+ *   [3] clk_loss_fd         -- clock input loss with freq drift
+ *
+ * Status register is at base offset, notification at base+1.
+ */
+
+/* P-polarity status registers */
+#define SIT9531X_CLKMON_P_STATUS_01            SIT9531X_REG(0x06, 0x02)  /=
* inputs 0,1 */
+#define SIT9531X_CLKMON_P_NOTIF_01             SIT9531X_REG(0x06, 0x03)
+#define SIT9531X_CLKMON_P_STATUS_23            SIT9531X_REG(0x06, 0x06)  /=
* inputs 2,3 */
+#define SIT9531X_CLKMON_P_NOTIF_23             SIT9531X_REG(0x06, 0x07)
+
+/* N-polarity status registers */
+#define SIT9531X_CLKMON_N_STATUS_01            SIT9531X_REG(0x06, 0x92)  /=
* inputs 0,1 */
+#define SIT9531X_CLKMON_N_NOTIF_01             SIT9531X_REG(0x06, 0x93)
+#define SIT9531X_CLKMON_N_STATUS_23            SIT9531X_REG(0x06, 0x96)  /=
* inputs 2,3 */
+#define SIT9531X_CLKMON_N_NOTIF_23             SIT9531X_REG(0x06, 0x97)
+
+/* Per-input bit offsets within clock monitor nibble */
+#define SIT9531X_CLKMON_FREQ_FINE              0  /* bit 0 / bit 4 */
+#define SIT9531X_CLKMON_FREQ_COARSE            1  /* bit 1 / bit 5 */
+#define SIT9531X_CLKMON_CLK_LOSS               2  /* bit 2 / bit 6 */
+#define SIT9531X_CLKMON_CLK_LOSS_FD            3  /* bit 3 / bit 7 */
+
+/* ---- Debug / NVM unlock registers ---- */
+#define SIT9531X_REG_DBG_UNLOCK1               0x24
+#define SIT9531X_REG_DBG_UNLOCK2               0x25
+
+/* ---- Variant ID values (single byte read from SIT9531X_REG_VARIANT_ID) =
---- */
+#define SIT9531X_VARIANT_ID_95317      0x17
+#define SIT9531X_VARIANT_ID_95316      0x31
+
+#endif /* _SIT9531X_REGS_H */
--
2.43.0

This email message and any attachments are for the sole use of the intended=
 recipient and contain proprietary and/or confidential information that may=
 be privileged or otherwise protected from disclosure. Any unauthorized rev=
iew, use, disclosure, copying or distribution of the information included i=
n this message and any attachment is prohibited and may be unlawful. If you=
 are not an intended recipient, please contact the sender by reply email an=
d permanently delete and destroy the original message and any attachments, =
and any printouts or copies of the message and attachments to the original =
message. Thank you.
