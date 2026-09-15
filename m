Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AC32ED55;
	Tue, 15 Sep 2026 00:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430438; cv=fail; b=M0IZGKEcvnqAUBjBm/3dbUDE0j3+aAavITGvEmRX94i7mrQ+V0Idmu+qicFvMGhXN1I4TmRPkFtyaPMay7MUu6n6CLoJFIh7QNQsL3+cT3HgEegSusBm1LSliw+bhvHkbP/BFNN9aAvxld38ZiHKTBO9Ijhf9w/zv1uIKnfQCJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430438; c=relaxed/simple;
	bh=SS0VBJ/2Pt6DtwIXAzg/uBxIfAi4dOtLl3A9kpVFeqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i+lXSsXovKK180T3kD75WrN8LkcFPr7TK2f4vtSRnWHPpvWl8gamszR3n/6E0YoYsz1ZKcdsqIOE22Hj8BjR5Dy8v2cg1a+Mk7IV+KMzS53gDP0M28HbTtBiv4Uqm0AdlvOd3Ee4j05C/cNhNpyLjxrwd2aoDZB671diAzSGsO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Y6dIt58F; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=T98o2mVc; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Y6dIt58F";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="T98o2mVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=vs3mNGuursY7lKb4WBM3c/AHyWlsdT7s4bGbPENS7uI=;
 b=Y6dIt58FnHxl/5e8yAcobexdGs8QpuzxqsI8AVlzprzqL35OINpCz6m9nEUcYnfEcUPwYXG7iptv3fEF4igaQP1Q6atB3MLAejXF8FbmNg1zrCqPSzTxytHqqIWw7lqL+DJdoQ/HawnMyMBFMWZm3o0tCy7V45SSjyhGLWWwof8tcLpMzWtMlMDQKpGzjUXVmBa8qhr+Xzkwocx4WWWE7fqBqtivblnYM5ioKvK6Idv3Hwz03kKa71jvQIY6IQScg9rB5uJdmjks0D1PBLNK9aW6xdT84ht3I9ULQdpaBEe0ixLcWgLnIYIBNcYCqrZGrHR0bHtTH4dWemjwPl/rng==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E6DA1100068;
	Tue, 15 Sep 2026 00:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHtfy9c1bU1CHrZ++wnPEbO1CCo7nIqAH9VY2sBOh+XCAnMUvhHuq7VlQI7qR9Vw4jDXqMnvylQK3g3AUE+T+meYtmB1Tu7r2KYD4AONIHKsLhxkoDVJPVXpgHw4Ysi3XPeQP7ddN/xqcuyjBiT3+PMnCrxseisDgzJdMA3blZEuupaY2wvr9/lSofeL8lBzp+u/8om5ZVmVEjDZZnSKSyVsH/6WSyAQyeVfTvqls+BFC3+A648eHgnyR0Uv/6HuVGnyAGYuKDo5ZjQKcVZXmq8FSxQ0fnnTCIOUvv02aTJsdh79EXBqT9cgza5ue96lLnSq8n5+VBYTC+JR0gr2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs3mNGuursY7lKb4WBM3c/AHyWlsdT7s4bGbPENS7uI=;
 b=xPNE9WgiWP3wuo13CGF97k7qai6KpoMiX8sEHagrmyB0nMtO0Mz1877dslWJCOXPLDwsSIwmOF3otC1/T64ny8pi9SX6GHbcauQ+ZhKi/yG3xUOCDwkmNePe7e0Lo/h7i+51F3HDValYoE6mcwtctmt4/L4zz+BJfzy+/NNlwD3mXCLr9J4HpAX+lzxdPzBDU0dI9e7bZUEOccPeNPkG0tncKvc0M9JKXK3iEG9xbcV6R2pvmg92UJcc2tIBWgdyXtcUY1XKMY0egEbyBk6eUiDT4PT6iRZDo3h2R0eL49QrstrUYtsRzsKyHXMUJx84M8iYLMs+Do/wzADF5fD1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs3mNGuursY7lKb4WBM3c/AHyWlsdT7s4bGbPENS7uI=;
 b=T98o2mVcDLauNHWKsujjly7FcpUnhBNdx6eoErka5mMXIi7m04T6bnJ6T27YUVFT36TML9JV3pJoNwNxL7hlmSneNyPP5JJVtOqDzQjoJk8DIIlp/oZceJGMi5KuTPN0B1tXhvqsBzozVv8TKfqz0vEAcf3nIrEjp2j/GjIS9mmr8axgjTrlMBzkCV6mDckqvKGJBGhsJSM2KvRX3fwhPv7ms+GGiYyS60VQiaCw6zYxxcW66t8rnml9lvFdzBI+HLd0HFkTmVB3yqEI5qVNUe6pXH6sTi6U+uNKO+EVwa/VqK0rURvoVYMFgl2131z3x1wE33zV93epDMmVkBqNJA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:27 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:27 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 11/15] dpll: sit9531x: add support to get and set
 esync on pins
Thread-Topic: [PATCH net-next v9 11/15] dpll: sit9531x: add support to get and
 set esync on pins
Thread-Index: AQHdRKUzgOlK5wk2p0+O27+g76Fydg==
Date: Tue, 15 Sep 2026 00:00:22 +0000
Message-ID: <20260915000015.80480-12-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 5449d18d-8db3-4cd0-a064-08df12bc59b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 MYEWqwOuaaCUANCtBGXmepkS4r/Lbf2vX4BcvAf9XZ20xizd1r4wZGQh/KMqZm6mJag8BcAiYjzBealnICxx10amaVGwTjuS4mK9gw45lHUQOOUjsu7KUXH4qADUD+eDgPwkn8uUZ8fzznFwPMhZHQRj+Ygvxqdj4xD/UyJTgNS+4F7l6MNfv7s2DDdrMNQ1jug0J7iwnV+PRdtSdTK10TdHoJ+s6krV4kF2wfPGfU2I6aX6g71qezdLSPwc/MzSFZSWADMhNDdF23e4dK4EGv/OafSd5evc6HRdzHQiO+Mhe5wkgfxdzKIrjiiC0LCcCGdpaeLqNTYCADVR679kQDFQmSg6UGqinp4hA+JZKY+XoVtJmjGl3/kRKT980QRSjDlpmWBeka+NZJE1fTycvCR2m7ZIS4t8EVSYgLOzZF2ChKXnTNmNxsCWMS0ZfUlgkNWNjbjZGsInXsjp5JQVCf7cFjhBFjMrZWumE7q1MvUgmzIUmFKttHGpM2SPp9vRB0x1QIkJCfcv5l3Trw+sJUZ0RjbVD9v6wZXa+WNlXGlUZsoPsxCP8IosZGS43ttx3pQwhcXUuLAGso69PdzWokPNRZlWlm/4UzsakDcM4xCKaeLef3FcR3PE1TXpTNURKhpMdrBqaRnawKIJhNXifnXa14u9VtGCM2SQFzwwiIhycymh284PrHIlPHbqdsL9IhLI+aXacJappV59wqjhEwBRznascJFSNaRs27Rqwqc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x5tmE98Q4BFjao1TvGLYJGHrtRqcwa07ZNx1ONYjBGghFE2SXLx6ZmjxSn?=
 =?iso-8859-1?Q?Y4D0HLl6RtHWkDgKR/TEBdzb/emw/qXqBRC7JJy3gckSg6AXPIz5uYEp6p?=
 =?iso-8859-1?Q?1oTR8zrmb3YNfabL+uHlAYER1vnO1qeSuNIMjIs6osOE0qYE8TBDJ6YYcO?=
 =?iso-8859-1?Q?8X3pZXs/fe1p092efum74sGk4QCNb+4kIF0uuBILEZ00sZmm+MMjaAryz4?=
 =?iso-8859-1?Q?duBx4sU/Hp1nywWQuPuNFWElzejPjrZZjEShEswP64n9fdf6Dy0CcnAjXD?=
 =?iso-8859-1?Q?XEOo94J7CnZ1QrkZNMnt4li9/rdnWE7vd6zSqm0IvMk109jytEZWj0Mq7x?=
 =?iso-8859-1?Q?JsyD8IXJm6A+Cjys0zZci9WXWjN+leerLxvVavXLNdEgtLHsl7LJfamjJ0?=
 =?iso-8859-1?Q?JGMVII/Ha1WR5CWmTgkPbrZWQcRIni69Am74uXF+PydilpjWhCT/16KQGb?=
 =?iso-8859-1?Q?Yaf7JbOatcbqtaEGMmS/vgMtMq2HFPBGcVhxrauYZMoEf5yvx3nQ0kTV02?=
 =?iso-8859-1?Q?nv9v4rmmRG6hRmcyg2ol2Q0iV4HG5xzthTufdsqh2clSkv/DRVk+gqxo27?=
 =?iso-8859-1?Q?Qq11mLYyB171kDRm+95xNLVDwM/PZF+og2i9BdV8IE0p3/BebMXjlr2t5P?=
 =?iso-8859-1?Q?hKkJqNDNRK6v3lJ1W+nqIfG6hommW9QfSgDc2EfXfa408Y6cvYpqCxuv35?=
 =?iso-8859-1?Q?guonAWnSHa7liucPPeKHnVn2IdVW1CHvbi+yYO8XYsR/NnNuxwzdBYB3vB?=
 =?iso-8859-1?Q?cAfFwZlASHs4ZQimt/z1//JnKOw3l6YiGiF6EOa/hw/oh975/4dYGkszpK?=
 =?iso-8859-1?Q?xFxFxIoY0u7LvtHu+MX17ViC27gbZm9ijykEeGDH9LUh/w4sOH/ls/NbYl?=
 =?iso-8859-1?Q?37XEbZpckj6mMLo/URbpnv8R/nGlQeTGfU9wFEROEnQfg4FNDXQBciGhs3?=
 =?iso-8859-1?Q?rRIekCBPdbDk/F1H+BmsoSeSIHdiYw5ImC6RA++oWSLxuHIIIGh/l9/aIA?=
 =?iso-8859-1?Q?Ncu6oyJKNqBseuhJ5NOwIj8H15lhi7vBGRBIprpRoDLMCMvzzomr8txi1C?=
 =?iso-8859-1?Q?yVz/oNbX/KpsbnJLq3yaA9YZ/DHGq/nZA+xlCJjr3j1lymyTpN+jh+VJVD?=
 =?iso-8859-1?Q?aoBXjTnGEjqQJr15u6DMjlzXY6Oe4AmS885euyYV2ZZSUGg4zyYyNV/OQm?=
 =?iso-8859-1?Q?BvbFi+ISndHtB5EjdcXR2gPukxtRBQzxhACkw6gFq5swmalQHhX485X7Ug?=
 =?iso-8859-1?Q?uSxG5c/tLfEUZ5W6A9Azn622kembGLDKcYnl7lk6wHe8BXwahd7jHnb5nc?=
 =?iso-8859-1?Q?twlRyBGZsUOQatKvS0Lxy2zu0sPJ1vJMbZ/GXMzi8wFB3BxeRw2Z93Y9Tc?=
 =?iso-8859-1?Q?JGl3lk5ObVEah/q20I8g1k+tjFWh5E5rLCmvCAyHqvPa0vUc4ritGJdHni?=
 =?iso-8859-1?Q?wGvRRSQK2mcxche9KKzzWWH4IvG1cYXD2Y0yXuiZ4NmS3koOgiLHYC+XcO?=
 =?iso-8859-1?Q?FjdSjbZGUjh8I8tyJxbE1ImkWWz91W/UU8nwTdqKdrEWb2PEApFgQnxRvd?=
 =?iso-8859-1?Q?cQ4y7XwEbqV1KMmrswgCGftayYIHIa2RDxhwjUGbHwCnPFfThO1LWPZKqy?=
 =?iso-8859-1?Q?mi/tSMB2VgdfjXyAZK/0TRO0CXurlbplY943ld1+Tg+0e2VQDHjLoZFa15?=
 =?iso-8859-1?Q?Z9p7osQfAcNcTs5rcVj+GDUe9jLEr6vqdtuQv0c9qW/CNrpx4qPTOJXlcJ?=
 =?iso-8859-1?Q?09ohPKuJwF5qPkyiI0efK+zRVTpn378j/y0m4AsR41dS69?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mc0QjRLj4RusDGQlKVuxO/YO4HHmSOqYA6Gy859sKahFQSAtXXNcIQWnhNlvNNVkOQih83J3Oz6V3gYlWYzTHwaTqHPs9vpQQ15yiDentlfsde7cva7IQr/KJxtWzIso7MW/IrVJRGzc6sj89hP9PVPRdj5wMpkO89ZsNZOBo7lESEE4TwK0CqivrEXDnEM9gAzGrn/ku+pHjWYh96zTu4O83XeLHHOD27lzLES/B0H4nC3dSHJdA8HrBwxk27+TP1XxdAJblwsrDSpNTax9OuyHu4qs9knc0/lLREZqdAyM/bAZhsFSighwFnb3CmYoEQc+Z2ypi9//4uuH+Fi9Ow==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5449d18d-8db3-4cd0-a064-08df12bc59b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:22.0124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EECQZKyHfN6l3iGPdtICywyxSwMuaPlavWTCmtMyUalKQAB2FGDZX0FePMm6Xy6WgBcOlZb1hvRppH7lulaC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430432-JEJg79hY3HTb
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430432;JEJg79hY3HTb;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Embedded sync marks a one-pulse-per-second boundary inside a higher-rate=0A=
output by widening one pulse.  On this device that is the same divider=0A=
programming as a frequency change plus the per-output pulse control, so=0A=
enabling it sets the output to 1 Hz and disabling it restores the=0A=
requested rate.=0A=
=0A=
Only outputs the firmware describes as esync-controllable offer it; on the=
=0A=
rest the operations are refused rather than silently reprogramming an=0A=
output whose board wiring does not expect it.  The pulse width is fixed at=
=0A=
half the period, which is what the device produces, and the core is told=0A=
the supported range rather than left to guess.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 141 ++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h |   2 +=0A=
 drivers/dpll/sit9531x/dpll.c | 154 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/dpll.h |   3 +-=0A=
 drivers/dpll/sit9531x/regs.h |   7 ++=0A=
 5 files changed, 305 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 8d857f1a0c89..46179a9e13c3 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1654,6 +1654,103 @@ int sit9531x_output_freq_set(struct sit9531x_dev *s=
itdev, u8 out_idx,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_pulse_write - write an output's PROG0 pulse control=0A=
+ *=0A=
+ * The caller must already be in the programming state.=0A=
+ */=0A=
+static int sit9531x_output_pulse_write(struct sit9531x_dev *sitdev, u8 out=
_idx,=0A=
+				       u8 pulse_ctrl)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u8 slot, page, reg;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+	page =3D (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?=0A=
+		SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;=0A=
+	reg =3D SIT9531X_OUT_PROG0_BASE +=0A=
+	      SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, SIT9531X_REG(page, reg), pulse_ctrl);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_esync_program - set carrier, marker and enable at once=
=0A=
+ *=0A=
+ * Turning embedded sync on means three things to the output system: the=
=0A=
+ * carrier rate, the pulse generator that puts the marker on it, and the=
=0A=
+ * output enable.  The device takes them all inside one programming state=
=0A=
+ * -- our validated divider sequence writes a whole register group=0A=
+ * that way -- so doing them as three sequences would pay the settling=0A=
+ * time three times, with the subsystem's device lock held throughout.=0A=
+ *=0A=
+ * The phase flush stays after the latch: it aligns the output to the=0A=
+ * divider the device is running, not to the one it was asked for.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_esync_program(struct sit9531x_dev *sitdev, u8 out_idx,=
=0A=
+				  u8 pll_idx, u64 carrier, u8 pulse_ctrl)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	u64 fvco, divo;=0A=
+	bool muted;=0A=
+	int rc, ret;=0A=
+	u8 slot;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_divo_calc(sitdev, out_idx, pll_idx, carrier,=0A=
+				       &fvco, &divo);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	slot =3D info->clkout_map[out_idx];=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_divo_write(sitdev, out_idx, divo);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_output_pulse_write(sitdev, out_idx, pulse_ctrl);=0A=
+	/*=0A=
+	 * Keep the mute the user asked for.  Embedded sync changes what the=0A=
+	 * output carries, not whether it is driven, so an output muted=0A=
+	 * through pin-state stays muted.=0A=
+	 */=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_output_hiz_write(sitdev, slot,=0A=
+					       !sitdev->out[out_idx].enabled);=0A=
+=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	if (!sit9531x_output_forced_hiz(sitdev, out_idx, &muted))=0A=
+		sitdev->out[out_idx].enabled =3D !muted;=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_phase_flush(sitdev, pll_idx);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].freq =3D div64_u64(fvco, divo);=0A=
+=0A=
+	/*=0A=
+	 * The delay registers count VCO cycles against the output period in=0A=
+	 * force when they were written, so the carrier change re-times a=0A=
+	 * phase adjust the same way a frequency set does.=0A=
+	 */=0A=
+	if (sitdev->out[out_idx].phase_adj)=0A=
+		return sit9531x_output_phase_adjust_set(sitdev, out_idx,=0A=
+							sitdev->out[out_idx].phase_adj);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_output_freq_get - read output clock frequency from hardware=0A=
  * @out_idx:	output index (0-N for this chip variant)=0A=
@@ -1991,6 +2088,50 @@ int sit9531x_clear_notifications(struct sit9531x_dev=
 *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte=0A=
+ * @out_idx:	logical output index (translated to chip slot internally)=0A=
+ * @pulse_ctrl:	8-bit PULSE_CTRL value (PROG0)=0A=
+ *=0A=
+ * Writes ODRn_PROG0 on the output page (Page 3 for slots 0..5,=0A=
+ * Page 4 for slots 6..11) at offset 0x1B + 16 * (slot % 6).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,=0A=
+				   u8 out_idx, u8 pulse_ctrl)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (out_idx >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * PROG0 lives in the output system, so like the DIVO and=0A=
+	 * PRG_RST_DELAY writes it only takes effect inside the PRG_CMD=0A=
+	 * programming state committed to the NVM shadow.=0A=
+	 */=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_pulse_write(sitdev, out_idx, pulse_ctrl);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD state via prg_commit(), even if the write=0A=
+	 * failed, so the output loops are re-locked rather than stranded=0A=
+	 * unlocked; keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_ref_state_fetch - read input reference status from hardware=0A=
  * @index:	logical input index=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 06df7a91a7c6..1f77ff28ec81 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -281,6 +281,8 @@ int sit9531x_intsync_enable(struct sit9531x_dev *sitdev=
, u8 src_pll_idx);=0A=
 int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);=
=0A=
 =0A=
 /* ---- Output pulse control ---- */=0A=
+int sit9531x_output_esync_program(struct sit9531x_dev *sitdev, u8 out_idx,=
=0A=
+				  u8 pll_idx, u64 carrier, u8 pulse_ctrl);=0A=
 int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,=0A=
 				   u8 out_idx, u8 pulse_ctrl);=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 78034b7f089c..0cad081eb599 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -22,9 +22,21 @@=0A=
 #include "prop.h"=0A=
 #include "regs.h"=0A=
 =0A=
-#define SIT9531X_ESYNC_FREQ_10MHZ	10000000ULL=0A=
+#define SIT9531X_ESYNC_FREQ_1HZ	DPLL_PIN_FREQUENCY_1_HZ=0A=
+#define SIT9531X_ESYNC_FREQ_10MHZ	DPLL_PIN_FREQUENCY_10_MHZ=0A=
 #define SIT9531X_ESYNC_PULSE_DEFAULT	50=0A=
 =0A=
+static const struct dpll_pin_frequency sit9531x_esync_ranges[] =3D {=0A=
+	DPLL_PIN_FREQUENCY(0),=0A=
+	DPLL_PIN_FREQUENCY(SIT9531X_ESYNC_FREQ_1HZ),=0A=
+};=0A=
+=0A=
+static bool=0A=
+sit9531x_dpll_esync_pin_supported(const struct sit9531x_dpll_pin *dpin)=0A=
+{=0A=
+	return dpin->esync_control;=0A=
+}=0A=
+=0A=
 static bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_pin *pin=
)=0A=
 {=0A=
 	return pin->dir =3D=3D DPLL_PIN_DIRECTION_INPUT;=0A=
@@ -726,6 +738,12 @@ sit9531x_dpll_output_pin_frequency_set(const struct dp=
ll_pin *pin,=0A=
 	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
 =0A=
 	mutex_lock(&sitdev->multiop_lock);=0A=
+	if (dpin->esync_freq) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Disable embedded sync on this pin before changing frequency");=
=0A=
+		return -EBUSY;=0A=
+	}=0A=
 	rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,=0A=
 				      frequency);=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
@@ -869,6 +887,138 @@ sit9531x_dpll_output_pin_phase_adjust_set(const struc=
t dpll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int=0A=
+sit9531x_dpll_output_pin_esync_get(const struct dpll_pin *pin,=0A=
+				   void *pin_priv,=0A=
+				   const struct dpll_device *dpll,=0A=
+				   void *dpll_priv,=0A=
+				   struct dpll_pin_esync *esync,=0A=
+				   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	if (!sit9531x_dpll_esync_pin_supported(dpin))=0A=
+		return -EOPNOTSUPP;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	esync->range =3D sit9531x_esync_ranges;=0A=
+	esync->range_num =3D ARRAY_SIZE(sit9531x_esync_ranges);=0A=
+	esync->freq =3D dpin->esync_freq;=0A=
+	/*=0A=
+	 * The hardware PROG0 byte is programmed with the same literal that the=
=0A=
+	 * ABI reports as pulse percent for the supported 1 Hz mode. When esync=
=0A=
+	 * is disabled, report pulse as zero to avoid implying an active marker.=
=0A=
+	 */=0A=
+	esync->pulse =3D dpin->esync_freq ? SIT9531X_ESYNC_PULSE_DEFAULT : 0;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int=0A=
+sit9531x_dpll_output_pin_esync_set(const struct dpll_pin *pin,=0A=
+				   void *pin_priv,=0A=
+				   const struct dpll_device *dpll,=0A=
+				   void *dpll_priv,=0A=
+				   u64 freq,=0A=
+				   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 actual_pll;=0A=
+	int rc;=0A=
+=0A=
+	if (!sit9531x_dpll_esync_pin_supported(dpin)) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Embedded sync not enabled for this pin");=0A=
+		return -EOPNOTSUPP;=0A=
+	}=0A=
+=0A=
+	actual_pll =3D sitdev->out[dpin->id].pll_idx;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (!freq) {=0A=
+		u64 prev_freq =3D dpin->esync_prev_freq;=0A=
+		u8 pulse =3D SIT9531X_ESYNC_PULSE_DEFAULT;=0A=
+=0A=
+		if (!dpin->esync_freq) {=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+			return 0;=0A=
+		}=0A=
+		rc =3D sit9531x_output_pulse_ctrl_set(sitdev, dpin->id, 0);=0A=
+		if (!rc && prev_freq)=0A=
+			rc =3D sit9531x_output_freq_set(sitdev, dpin->id, actual_pll, prev_freq=
);=0A=
+		if (rc)=0A=
+			sit9531x_output_pulse_ctrl_set(sitdev, dpin->id, pulse);=0A=
+		if (!rc)=0A=
+			dpin->esync_freq =3D 0;=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (rc)=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Failed to turn embedded sync off on this output");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (freq !=3D SIT9531X_ESYNC_FREQ_1HZ) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Only 1 Hz embedded-sync frequency is supported");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (dpin->esync_freq =3D=3D SIT9531X_ESYNC_FREQ_1HZ) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	if (!dpin->esync_freq) {=0A=
+		/*=0A=
+		 * Remember the carrier to restore.  The cached rate is zero=0A=
+		 * for an output whose firmware node lists no frequency and=0A=
+		 * which has never been set, so read the divider rather than=0A=
+		 * leave the output parked on the esync carrier at disable.=0A=
+		 */=0A=
+		dpin->esync_prev_freq =3D sitdev->out[dpin->id].freq;=0A=
+		if (!dpin->esync_prev_freq)=0A=
+			sit9531x_output_freq_get(sitdev, dpin->id,=0A=
+						 &dpin->esync_prev_freq);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Carrier, marker and enable go into the device in one programming=0A=
+	 * sequence.  Without the pulse generator (PROG0 PULSE_CTRL) the=0A=
+	 * output would carry 10 MHz and no marker at all;=0A=
+	 * SIT9531X_ESYNC_PULSE_DEFAULT is the duty esync_get advertises for=0A=
+	 * the 1 Hz embedded-sync signal.=0A=
+	 */=0A=
+	rc =3D sit9531x_output_esync_program(sitdev, dpin->id, actual_pll,=0A=
+					   SIT9531X_ESYNC_FREQ_10MHZ,=0A=
+					   SIT9531X_ESYNC_PULSE_DEFAULT);=0A=
+	if (rc) {=0A=
+		sit9531x_output_pulse_ctrl_set(sitdev, dpin->id, 0);=0A=
+		if (dpin->esync_prev_freq)=0A=
+			sit9531x_output_freq_set(sitdev, dpin->id,=0A=
+						 actual_pll,=0A=
+						 dpin->esync_prev_freq);=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Failed to program embedded sync on this output");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	dpin->esync_freq =3D SIT9531X_ESYNC_FREQ_1HZ;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
@@ -877,6 +1027,8 @@ static const struct dpll_pin_ops sit9531x_dpll_output_=
pin_ops =3D {=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
 	.phase_adjust_get	=3D sit9531x_dpll_output_pin_phase_adjust_get,=0A=
 	.phase_adjust_set	=3D sit9531x_dpll_output_pin_phase_adjust_set,=0A=
+	.esync_get		=3D sit9531x_dpll_output_pin_esync_get,=0A=
+	.esync_set		=3D sit9531x_dpll_output_pin_esync_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
index 901aec238f4f..0b8b24cadcbb 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.h=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -34,7 +34,8 @@ struct sit9531x_dpll_pin {=0A=
 	/* in 1/DPLL_PHASE_OFFSET_DIVIDER picosecond units */=0A=
 	s64				phase_offset;=0A=
 	bool				esync_control;=0A=
-	u64				esync_freq;	/* 0 =3D=3D disabled */=0A=
+	u64				esync_freq;	/* 0 =3D=3D disabled, 1 Hz =3D=3D enabled */=0A=
+	u64				esync_prev_freq;	/* carrier to restore on disable */=0A=
 };=0A=
 =0A=
 /* Per-PLL DPLL device state. */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index f40762f06403..9d515e109feb 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -230,6 +230,13 @@=0A=
 #define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */=0A=
 #define SIT9531X_OUT_PRG_COARSE_BITS		34=0A=
 =0A=
+/*=0A=
+ * Per-output pulse-count control byte used in SYSREF / SYNCB modes.=0A=
+ * Slot N within a page sits at 0x1B + 16 * (slot % 6).  Same page=0A=
+ * mapping as PRG_RST_DELAY: slots 0-5 on Page 3, slots 6-11 on Page 4.=0A=
+ */=0A=
+#define SIT9531X_OUT_PROG0_BASE		0x1B=0A=
+=0A=
 /*=0A=
  * On-demand phase-flush fired from a register rather than a GPIO pin.=0A=
  * DIVO_PHASE_SEL_REG selects the in-register trigger source and=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
