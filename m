Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE13B27E3;
	Mon, 10 Aug 2026 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403444; cv=fail; b=pA5A3ihO6nIKpUiZ2nSMrGTmD8x/0zJ60V8uViC+0mSQOFlHTdRU/gDp/owXjWvjjbSPEeAP3S/ETX4LxgkvnWkXfUllWcvN0SODvt2kqBHfk/sgbSEt1i50VfhhWlSQQMlFkJYNynCHHTUjuU6uKjCNz3nAaIT5TxSw4ZmzEVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403444; c=relaxed/simple;
	bh=WHZSSOWn3k7Ipu0+PllcCwUpDcANdcNSMk0M1X8FNr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERaAVoPuDiTNuV1w7vHLNuU2Jej8bzOM0FHD3zOhxVXVJG8FSCVxQFIR0ePieVcMUPhbChuYbQSecy6xvFfByKda75bkLUyFCNvFrqx3bdoI2thTcolxFbl13EXoqCMCKmSCLPpHd4dfqaj7EhLh1SvYLFR6eGl+owl+s/7Zf14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=MLqosQxE; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=08bmDNkG; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="MLqosQxE";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="08bmDNkG"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8D9D044550D;
	Mon, 10 Aug 2026 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=LOhgnxK7d/5T2zA0esQCNUAXaBG60FcvFit8wV8TfB4=;
 b=MLqosQxEsdVrkoRIpkAuRS9jcV4+4OGXT/3is8mwNmkgBBXhWI5pJ/hf0go8l7HZaKIplCEij2bABano9MvxgLMFH5xOF2meJIAIrbv97IjEX9Upy4nHoTpBcvbJLWkrZ1zlMR1gYzi3xyLqpgdsy/MskyPyb0DwVpoNzY929MbkyCYTlBg5xZm6RiLkxAZABOu029h3U5ZnT++67bXQxQssgxu4WsPLbcN3ypsyp0lRKKuif7WrIiv5/RBFBBX1sz53yRFoDb+cWtjo8+xgwq3+22eV5bfFfl4IadOdq28LaHIYdH9EeTo75jyKj0taLvq0U4Fdm4JvSKD0hfQa5Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022098.outbound.protection.outlook.com [40.107.209.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2E0CFAC006A;
	Mon, 10 Aug 2026 23:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjgAqGJlgCcXRzj/0yOZu6zitP4cqBJc53nN77znP2Kya3G+P/n2MT7/O690bk8kG2dYkhHU9xr6iHyeSKP+82t4F/sR8JGQLtawlEo+NM8MAdd340YOK4qR0X3LRuCJnDnVBCtiTEOCxV/ZwfzU4uqm0CLiE/NxQFf4Aa6wy8wKhE2aecVTyInCeR0lpkvQlbjIyXDdziLOcnt6322r37LDVeXmwIIKU1gRGY95bg65iWFt+DTeeyThf6AGNaXSMTC+wTD0R0yS9TbiZAHBwfOX/P2USkJAb/kFvvdQcqHU4stROQ+DFWoeRR8j7QtawIz4iFpmD5ToSOFN37bdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOhgnxK7d/5T2zA0esQCNUAXaBG60FcvFit8wV8TfB4=;
 b=xQ1NKFLjjjq/e4vLnLIKb4WuSQpV9psRLydug9RlheCumw3N+uqlc0HeUmXBCqoQzyh3ZERHp5zNffJEb7OKPqlgPB2ihyxCPTuVvAtIAR7cE87/aPwmx4cIPJuljgmSIdYxUQmsws1NKFRJQA6Be2T64cZUUZGyEiYoSX08uPN4ZQiB7Em+X7kMjCmKQ+EJYqQRi3Cdt++MQtMn1HYZwB6FYAtqVQGsPcpaUAHWzHqzQcDE+Q9WVtVTscr95qtvxlofkLHekXaWyTI6ZKIjyMegMWg3N+PtubKTBh1//yENq3KaHIR4r6ryEHQmvr1v9yGbwxjQK9w5caf0xTFz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOhgnxK7d/5T2zA0esQCNUAXaBG60FcvFit8wV8TfB4=;
 b=08bmDNkGPi98GjFV+Xj3gQbhhtpJt9ulit01cZTHFNWIyWRT214W3RoCrMvQi4qczTvG5DpB0MWiOH4so3eew74SQ7WXNSCzkj7ihwHU5/lHVdW16DWOYirOs/wwckrD592uxQOP32R840mz9zzKWMXdeMnAeD5bHASyt2KKNI2ZC+622cuTI4CNFcESl7AgNXom/3Mlo4sgqBk67z7ZkKIvW5t2dRXf5R92SPPDH+W8jM1D0bjPH0DGmw7G/hnYJTTiYf/nmJivATRDzw0b9iuf6YbJyJi8Pzhp/PjxpAVRVGak6+gQR5RVSyZtTnDQfkKYwoWZ3ny94zuQZX3PKQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB4516.namprd20.prod.outlook.com
 (2603:10b6:806:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 23:04:41 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 23:04:41 +0000
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
Subject: [PATCH net-next v5 2/3] dt-bindings: dpll: add SiTime SiT95316 clock
 generator
Thread-Topic: [PATCH net-next v5 2/3] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Index: AQHdKRyglyLM+yb3KkyHRi1nmjQMEg==
Date: Mon, 10 Aug 2026 23:04:41 +0000
Message-ID: <20260810230439.22866-3-arouhi@sitime.com>
References: <20260810230439.22866-1-arouhi@sitime.com>
In-Reply-To: <20260810230439.22866-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB4516:EE_
x-ms-office365-filtering-correlation-id: 5daee0e8-edd1-49dc-3da4-08def733c2d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|10067099003|5023799004|38070700021|6133799003|3023799007;
x-microsoft-antispam-message-info:
 7QN/cqcQkIo5yiKv1ywdwx2qFF0M+f7+JoFxBozneEvy52NPbnHq807G/kpFj46elq0+pCWp1pMQxloph8/2NlNkNcLZu2RJIiCjfDKcHcZvaX/ufTBTNOlCfqRF8PlJ7njWLkGrlVbcWrMCYlOAQINZPd9VcklJ2MWK5t8kkX7ZHQ9IEvidxiDsPJTCAiY0VcV1zrLyUZ94ZH0LCuev5i7aX8ZKwoHrBrWiPXpjJsbrl7BpCqCkJX2OrW8DHyMnyw4DtkplZ8vlhdigXwyQ6jWG8l5GF2h3A045MWB93mBiO1Hn+qK9GCF7HhPzskbBjtcc2G+ShkeOzX+wrBZ1Kjby2kanAgk+6lJQ11EaOpwxoEi13y/24pxazQov9rFlgjhDgt0pt2pY/ISsMK9ePLtRWTIMtULyLY2aAYhwmuOnuzWBYtsZ9l5Nxo1cN1fxKa8yRNte9K54Nf9CQm/4gkcDRc+I6vTW9+o6+KphaOmQ0xSubxUE0+HODCfG2zIUgjK0+PxNoipoJun6UaeIPkziJn+96cKYQyrfUvRFvH7d3ZlYZi/v3jsk2jvay3Z1k6ky4BB57KVFELAVJjwQcx6chSjWMVSkX6wt8FnmR8OTJ6spCRW8TkvyF+B/5gpU3coWh2hmsGXIUc1dyQq6xc06NXZx9uq46ouQ2CMv9S4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(10067099003)(5023799004)(38070700021)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qQoCGUwz2OldCsKwpyEW67PnJl4VRl1ec4itUO4nN+Y33nKgDO+jthMq7L?=
 =?iso-8859-1?Q?zI0Smkji+bT95vI4wDGgDjXEbCEezwbLdLOubJ2foNr/v9TFUP24gr7h9k?=
 =?iso-8859-1?Q?CsfiOLtxgyqR6PFac9Qskfe76IcaMlkNHcMx86XiT3f49MxVFYfAbVm9ev?=
 =?iso-8859-1?Q?zHya/lkfhXFN29MNoA6oc8a95voAA6rSm2v3YwCudE8WPrwlw8TdoWlrbw?=
 =?iso-8859-1?Q?X72Rh7NMMR3KQylL0Q1Z6VAtCeVpwoJlmgbuJ2/qY9a1dqy8x6wLNSv3hG?=
 =?iso-8859-1?Q?Fx7Mhxs+9AP4gxP86Dglzwd/pePHxzciXfjKTuO560i8x8mO2g2a2l4POw?=
 =?iso-8859-1?Q?hIR5GdVbJn78V6Z2MpSxH/hP7YmJt4HCnLA76bz4TWIj/x8FoabEO+beV4?=
 =?iso-8859-1?Q?0OUlCRV/o573GScefB/F5lZ5fuI0RgJcc7XkE8iQ6aAjAzp2a7WIoJNCHr?=
 =?iso-8859-1?Q?s23lZvlO7heer80buRquGNppkhK4t0OcLflM6jRENepEkODuV83AlqKMQe?=
 =?iso-8859-1?Q?K1snQpbGHsi5scLLO3tlhMqKnM8ZZUIef2575mioSZyHUc9YFv02o1lf2I?=
 =?iso-8859-1?Q?UleY7EfOkIJRm+v5tabHqlmvvDnHogZ0aXFNOcnApSIYyr/A+ONXdPQG6l?=
 =?iso-8859-1?Q?OX5qsnCYgQw6xnK6ItjwPNubO4OtnE4tkxY7z3HFtQ5uYikI3YhbdZLFoY?=
 =?iso-8859-1?Q?9xyw7si3/X4I2y7jACCFa1JsIF4bLPcINu4Ajrt/dFj+41MVnrYY03CoA9?=
 =?iso-8859-1?Q?TbpeqzvW1NTS5L/70xewzd4LblJ8mQAVaJWG+xJUjITg5fZYo7/Y6L4Dhm?=
 =?iso-8859-1?Q?+o+WuFlYN5wzN0+PoU5vBIRDBODs9YMSjXpPI6HlGje/0CTlXjYf48bSPM?=
 =?iso-8859-1?Q?UlQyxMXy7nAJHZJjDwCP9S9/2fBU/oluGH92MvV4g+qxKDKahlkhyhqR0m?=
 =?iso-8859-1?Q?WAMJX+Sf5oF0DHQi49p61sGYyS+3S47Y+CS/asGB+ixMDEoY4UCXQjUETI?=
 =?iso-8859-1?Q?OpB+iONgdpIcwsFlsmN/ua5MPwaVl9PfcDwJKhcHVt1t6/OGfRXFaa44TN?=
 =?iso-8859-1?Q?7fRsOXM2le17mikCLy61OvzSPyOqQlobhBXS60sHuYB+226VbKTDVg91/c?=
 =?iso-8859-1?Q?KLG+u/7O92oK5oSDLGJ3vTgIfMMUNp+5r81Qa1b+C2LoyQ4opjilze+FEi?=
 =?iso-8859-1?Q?dzpStC6drm7nZZ+lmGRSH5MnMlXAq1p8p/uX25BMlwMPppeoK6RSL4Ulo/?=
 =?iso-8859-1?Q?TzekBfQyeFu9WhE3boQUvAAdhEvPAMiRUZVAR7pi4nb5QkGYR3KJ8KfYIW?=
 =?iso-8859-1?Q?1gZ4AZ+psnvZ4CqDPBj8ZXtSbDS9PunVk4ZkBPH8pHaZBZe5zhPzDa4CD8?=
 =?iso-8859-1?Q?2U00zelqrbjl/nuj0r4EbPJf5e2GltBYzOQCQ2JzATvUHCk41vByCk/8lY?=
 =?iso-8859-1?Q?AFeugW49l/7SUyY3dDNj34FXjlATl5dLkQ5T3TFPRiHy0+2netmxhNlSC4?=
 =?iso-8859-1?Q?BeZhdm5k24AxmeMN3zAK/BBU1lFFb7P7hiinExwwjAS0n9mNBcgzxSA30j?=
 =?iso-8859-1?Q?JsJsthlmteVkzRCFc0JeC2npbzxhqLSK5JoEEuaFF4ckANL7ggO/x/Do1v?=
 =?iso-8859-1?Q?aDe5tKFr7WNu2KdpoHtMzPvY8z/MLkjrRJVyRNodACgZ9gs1wM9SwEWufd?=
 =?iso-8859-1?Q?ei8zYi45FYrMAe8uZVl0dyC84PIEci40dYgYWWsOoax72nOKYIc0rKlssX?=
 =?iso-8859-1?Q?0FYZ6ygqDRHZUFzyNuRm6DHlXLF2LQsi0cPZFYVy05jMEE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YaHs5QtW1gRAegn/YwlpJ1+cHDQK73c/olVbOdMmAHF3ykxS4r+drB+dXEY1gyEUFCVWAfuDn4Ao1ziyuCMh2xZ6IQuaISp+Nknoenlwz/fQOqDc12CPtNPvI6PwuCwBrDAw1kB9WrDZlGeSmCZX+5giACuY1Od6Mv9fA8uhleQDWSQT2+hscPHeBUQ2Drtl0i1HvCw7B+78MU6uBdyKXVJ2Z54xdcrEu2O+2/DodXbE39uxhnqZhoKFT19pdcqY6+0Lq7m4kXbFEmJgXeCedwQMtXd59czByhr8GF3eVhsmmZco7u1EAb5KSM1itb6ACYD/t3OHLy7cRhtVIcLhMA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5daee0e8-edd1-49dc-3da4-08def733c2d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 23:04:41.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAw4WtR3Yci3hKTL7Jfn49OdjTHUfRA8Bsov+e3ekjcXNrkfu5yEXfFC2W7MEjkjpO8gpHaxIPyy0O5WwPOpjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB4516
X-MDID: 1786403091-36BM-NOnpfAl
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1786403091;36BM-NOnpfAl;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add device tree binding documentation for the SiTime SiT95316=0A=
and SiT95317 DPLL clock generators.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 171 ++++++++++++++++++=0A=
 1 file changed, 171 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..591a8c0d7bbf=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,171 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/dpll/sitime,sit95316.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: SiTime SiT95316/SiT95317 DPLL Clock Generator=0A=
+=0A=
+maintainers:=0A=
+  - Ali Rouhi <arouhi@sitime.com>=0A=
+=0A=
+description: |=0A=
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock=0A=
+  generators with integrated DPLL for synchronization applications.  Both=
=0A=
+  variants contain four PLLs with automatic/manual reference selection,=0A=
+  DCO frequency adjustment, and phase offset measurement via an on-chip=0A=
+  TDC (Time-to-Digital Converter).=0A=
+=0A=
+  Both parts have 4 differential input pairs whose lanes can also be=0A=
+  driven independently as single-ended references, so 8 inputs are=0A=
+  individually selectable.  SiT95317 drives 8 outputs, SiT95316=0A=
+  drives 12.=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    enum:=0A=
+      - sitime,sit95316=0A=
+      - sitime,sit95317=0A=
+=0A=
+  reg:=0A=
+    maxItems: 1=0A=
+=0A=
+  clocks:=0A=
+    maxItems: 1=0A=
+=0A=
+  clock-names:=0A=
+    items:=0A=
+      - const: xtal=0A=
+=0A=
+  reset-gpios:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      GPIO connected to the chip's active-low reset pin (RESETB).=0A=
+=0A=
+  interrupts:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      Interrupt from the chip's active-low INTRB output.  Asserted when=0A=
+      the device detects a status change such as lock acquisition or loss.=
=0A=
+=0A=
+  sitime,pll-fvco:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint64-array=0A=
+    minItems: 4=0A=
+    maxItems: 4=0A=
+    description:=0A=
+      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  Neither=0A=
+      standard frequency suffix fits.  The VCO bands are 4915.2 MHz to=0A=
+      5898.24 MHz and 6875 MHz to 7812.5 MHz, so every valid value=0A=
+      exceeds the 32 bits "-hz" allows, and the band edges are not=0A=
+      whole megahertz either, so "-mhz" cannot express them.  Hence a=0A=
+      plain uint64-array.  Override where the standard=0A=
+      Fvco =3D Fref * DIVN derivation does not match the running VCO --=0A=
+      for example a PLL operating in INTSYNC mode.  A value of 0 keeps=0A=
+      the register-derived computation for that PLL.=0A=
+=0A=
+  sitime,output-pll-map:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint32-array=0A=
+    minItems: 8=0A=
+    maxItems: 12=0A=
+    items:=0A=
+      enum: [0, 1, 2, 3, 255]=0A=
+    description:=0A=
+      Source PLL index (0=3DPLLA .. 3=3DPLLD) for each output 0..11.  The=
=0A=
+      value 255 (0xff) marks an output as unmapped and prevents the=0A=
+      driver from registering it as a DPLL pin.  Override for=0A=
+      configurations where the chip's per-PLL OUTPUT_ENABLE bitmaps do=0A=
+      not unambiguously describe output-to-PLL routing.=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+  - clocks=0A=
+  - clock-names=0A=
+=0A=
+allOf:=0A=
+  - $ref: /schemas/dpll/dpll-device.yaml#=0A=
+  # SiT95317 exposes 8 outputs, SiT95316 exposes 12.  Bound the=0A=
+  # output-pll-map length to the variant so a SiT95317 node cannot=0A=
+  # describe more outputs than the part has.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95317=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          maxItems: 8=0A=
+  # SiT95316 has 12 outputs.  When the map is supplied it must describe=0A=
+  # all of them, otherwise the trailing outputs are left ambiguous.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95316=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          minItems: 12=0A=
+=0A=
+unevaluatedProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    #include <dt-bindings/gpio/gpio.h>=0A=
+    #include <dt-bindings/interrupt-controller/irq.h>=0A=
+=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@68 {=0A=
+            compatible =3D "sitime,sit95316";=0A=
+            reg =3D <0x68>;=0A=
+            clocks =3D <&xo2>;=0A=
+            clock-names =3D "xtal";=0A=
+            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;=0A=
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;=0A=
+            dpll-types =3D "eec", "eec", "eec", "eec";=0A=
+            sitime,pll-fvco =3D /bits/ 64 <6251500000 0 0 0>;=0A=
+            sitime,output-pll-map =3D <0 0 0 0 0 0 0 0 0 0 0 0>;=0A=
+=0A=
+            input-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkin0";=0A=
+                    connection-type =3D "ext";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkin1";=0A=
+                    connection-type =3D "synce";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+            };=0A=
+=0A=
+            output-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkout0";=0A=
+                    esync-control;=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkout1";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <25000000>;=0A=
+                };=0A=
+            };=0A=
+        };=0A=
+    };=0A=
+...=0A=
-- =0A=
2.43.0=0A=
=0A=
