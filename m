Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE43909A6;
	Wed, 12 Aug 2026 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557337; cv=fail; b=DZ0w7AfHvncMmQx6g0T+joWoODf2vO+Li7CjVWGkvXvDJKVBB7vcrsJ9NtApSPZqi3ydCXmyQoifB+NyF67ejzEI79a9JEt051evFTnUGuA5uK8ePBK3NsOb/CA3E5HJ7POEN7E18V9oZzNMhHQS5oFKLjOQky7mz1x1rA5odlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557337; c=relaxed/simple;
	bh=R8+uL7P6uw3rAGQufColdF3g35vZy4vuiAUc0sipjrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uHZ/LOh7+t/mrO/aeS2nU7ir/HdfQEXpEAJWBqMnz5/6PAPPm1NPRLgxPLnR/DjnhWH6LNmQK0jPVsoyYZaSicRgJ0KUivySnWfcv3c2Aw/o9fBdSRiAMThuqT+0Y6AcmRfG6RyR8d/SuJHmpg/2BvyikWqtIRGQEjNlZ5UqIMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=PilIlsYG; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=wLaJyC1+; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="PilIlsYG";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="wLaJyC1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=eiz6hXlY5CnX6O3FQ0VjVy+W4q8mWVBAxJASEb5+zXI=;
 b=PilIlsYGauaqtJr+jxgIB68X8j4nSYFN20TrgVFfVxi0hJVq9mvqvU1zZTsTu5u1OjsWV0mHle3/j7JptTgcFntI5hb7+TQodtq1mgLzEhlnCsKKwkhRdyYonub+wwDWih2he3EYLLuE9zE3hy7fdj1Rqbr01f/J6ZjBUlR7uASUk3aforopj3UFg7TWwUFDPcrXvCWbzcLu9gyqFakvI8Fx1pbhRlWyX+XuNlNJM4zDevovKmeQZV9PxTxBH7yx6E6Sfn9aZlI6+9R7hjKkuEC9wy8tyrjw6x7qSR14s5AX5Vug62y0xrw9XHnuER/SovxFst/A5VcICUSVNn35Jg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020110.outbound.protection.outlook.com [52.101.56.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 32ED434006E;
	Wed, 12 Aug 2026 17:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcJUFNABzC8IMj3m/NzSX8kXahtBu9XJBm4S8iYOOw7QpMUpV41a/G5rO69FhIVEyWCNUaWn7OIQvQbZ/pGSvStLa4iqkq8w/BIPECykgMPEFDjg2x9YeRvZX0PT40mMDqhKYrs8R2e/Bqy/MBnZIpSLOtMY+cD5wJyqZ7MV5ROcikR6fZgPX7PReTy/gVwO5JdPpUeubFYugNOU0aIp52aOxafuKU8slaU40/OIYfViGbn3knKleoQzfoAbQcYq4Qlvvi8vaCQkLYX7XeERNfkRCVaySDUCVKownytpREdy9ROlLjMcGrGVR7QwU/y3gRMKfyhG4ElI/GNWDmG9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiz6hXlY5CnX6O3FQ0VjVy+W4q8mWVBAxJASEb5+zXI=;
 b=Ls9g1ryuG4dunlWHj3Ixo+EjHmXPTAjYq/ADxaicUhNuNGkNcdfhASz8IuQlHwT5yBc2M5WWP2PkXGCfFlUUO/BJqWvNTs94HxVCmAk0D7MNg/jX4dLM5s74+LoXxbZfWrcixPNjQWUAvlwJgobZRNJjV0VxLKKorYETNCExberVGqOW9oX00j04m3H60CqYR5tU4birgnQJeb1Q5CVmBe0C7SFfaev26YqCCWxLEmaK06vfs4eyCY5ZkaSTu89bb+oWGnl7q9FaLnPTAVZxCzKtWmcs48YbIrv7br5WwnjMa28SYWCjzsHlq0jFZ1jZU/MbnRDcFDcXsoKwKqdVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiz6hXlY5CnX6O3FQ0VjVy+W4q8mWVBAxJASEb5+zXI=;
 b=wLaJyC1+CGhfhEL95lILTfeUFRHbftT2oGC0f11MTQHIppaMsxrDMr/5XGMn8dGSCZjgJ9HD9dUQpQRyUcToVJESlkNrfTrctn1VFHr8omiP3GHmLGa2/XMzDz3vRggVLk4wLtZFYWVonkr8EyHlFlmkTa95s+ypFTle7yBbWRjVXMFcec57U5gHNhc3W6cY1c7isFHcRF3Wa4YjgHDSesEjAQXBZtKY3/TU1l+DWt3GvQXKBiGTz/vhRO5h22MA9SxjMieMvbyNeJvi19RQBeOCHxNF8fyMSqjHfaDxfzcnhEu7ylCOXeMUAiF5UP9GH5kYiDfuCz9EQxdJFWIJEQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DM6PR20MB3282.namprd20.prod.outlook.com
 (2603:10b6:5:2a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 17:55:25 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 17:55:25 +0000
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
Subject: [PATCH net-next v6 2/3] dt-bindings: dpll: add SiTime SiT95316 clock
 generator
Thread-Topic: [PATCH net-next v6 2/3] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Index: AQHdKoPAAs3QDwnm9E2nEEyzR2U3fA==
Date: Wed, 12 Aug 2026 17:55:25 +0000
Message-ID: <20260812175337.18155-3-arouhi@sitime.com>
References: <20260812175337.18155-1-arouhi@sitime.com>
In-Reply-To: <20260812175337.18155-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DM6PR20MB3282:EE_
x-ms-office365-filtering-correlation-id: 9ca0262f-14e1-4e7f-f332-08def89ae36c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|6133799003|3023799007|10067099003|56012099006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 V4w51cdvoCzevImlP2qvMK6Av45IkNHRoLwKYqhICuzPrMkZU99TWmIkXky+JTVqxg+bZYfkqTi09LVjowBSL4XgZRH9oU7W1q8MiOsuQt9Owfy1G+pAjwVxlLHopxOL23Cc8XfYoKYStgsmNeqOjvtcSw0PgvGGHEUfOqbFbtDC+tuA+WDhsuNK6tsKz8x9W3r7FkDw5k4uOjLlalZSAYq7iIxqoSBy265n2LQQnBFbocIA7D2ygYwkxLr/ifJgOIxgWxvE9bERG8SvX/B2abGJ4b9sovF3X0aCZNTb4UgFa3RZrIy7Sx3uBqcydiJ9e+AMuIyLzxPWalfy+wpK+BQJ+0mE7dTRpMD7wZf7zoY5vPFtiW/Jjf8EfUIgtMfttvKvCHFpoE1Gh0iFsA48Ax6/ITFJDFwXcZaMzuCwkStz6jx1IDkxPrqmG03HkExVgyeGj0thrGsyHhggl6bh02m8529qT9PUFm9Sl3HpEOAHGeoN0gV7zTdFJ3XgvjWdD4/qCfvVlyZY2CKIg4tWLfS6ViL84MRqVgMT6jEZ0Mgbmo7bBAFU5K9/da304BrF43qLkMN5eWZW5v33VA5KblceJdn10ELtOv2TSrGhZ//YQBMV71IobmMzY3c9OZPU2/D4XTzLTag6iqGzUvXi87Icl2Nl6PDk2SeB/QzHBMU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZrR03/vAkumkubNqD6mT5NTiBlGsIsMhs3mJa8ivjsQA2sGBms8uzbRugH?=
 =?iso-8859-1?Q?xYzjfH/UDhJ7nUzLJ/Ej4dsTU1QNKVDfLYjFxwYIG98Uq06H/ok1J69xVx?=
 =?iso-8859-1?Q?h2zvovGxqg4VDbjTB0IQHdbRNQUaRjWN3k5LJeLwL/RptuwPwkPrPbl9Hi?=
 =?iso-8859-1?Q?2pLu25YhPCMK8OAZxPmxjJaJIkSSB9BkqeLKO7I41Sfma3iAzDwyEFTyNg?=
 =?iso-8859-1?Q?Vc2CsE/VhCxnkEy/S3eUnfbwuV2AbbojbpHpIXaoy/NYWOk4WGnShBrIko?=
 =?iso-8859-1?Q?U+4WCejFKpr6Xle1NtgaFVs1xdyJRkR1sFQLeRsKykJ7arLRzQXoeJQHHq?=
 =?iso-8859-1?Q?cYIAW9i6/pNCYTFK+bUWNSG+JGOXPn2vRbxzYDuJCPhWVFWL07GrDe7hg/?=
 =?iso-8859-1?Q?CLV19A+2lspT3kA/haePd71XLXe1hyKQesLTsurVIo6tArigeUfFxcKNUW?=
 =?iso-8859-1?Q?OMpAUihfNGxL74yfUHqeUJIE4sW4jquUqhHz6EUlOdtrS1pcOJISIFD1ZC?=
 =?iso-8859-1?Q?1GHmT8hHaj+Z0TBkqrym+Wg70D/GGiqkvEzjhHFRJyI6jBHWFEQYvzyOK5?=
 =?iso-8859-1?Q?TdgvU1wWhPmVKuENeQ5WX8ZrJn9yeXTkgH4eobVzc5UH+x+FgkEw8h67kO?=
 =?iso-8859-1?Q?4GccF25+YKOtYf/W5tvIXwbMCQaOmS/ap78z07nrvriU3ts2oB102qkcyE?=
 =?iso-8859-1?Q?ZzWFmYwaMqjSJIsc0v7rOQVAd/qHnbuw6vQSI2UHlYllSCpy4uhV8tATyb?=
 =?iso-8859-1?Q?+BOVbb5Dgs73rEjxMiiueZSLZwTgsWWjWQD6tUuPg4PSX1rYPQv9VvdS1g?=
 =?iso-8859-1?Q?f1Jh2soA3BfGsXs6WjMim3Zemzp5DUNqs5BGGAbV3OnoP4JCKQNPKtyZYs?=
 =?iso-8859-1?Q?u7VIz6QvML2XXhXHlCoxAHdsjo2bezRu4h2iw4vcEOtWPIl4sGxg5ozsi/?=
 =?iso-8859-1?Q?ePa6iOuUOUlIf9WNBIUrZlnY2jiqhkv3Av/67Oiw6AKsX5qbH8KeomLDhe?=
 =?iso-8859-1?Q?+lU+I32b5MN80bsgQsG2BErQ3IaYU7rXS/j9ZyPMbu/wrjDr6SU8luILFI?=
 =?iso-8859-1?Q?HZrjCcQd4qRC/v3bf+O4ApQVRtGBZdPQt9U+0JLhIrNB6O8HZLXtto2Ed7?=
 =?iso-8859-1?Q?qAjJTzQ2UlZTTsnFk04sOaaGdhRdM0z61HCbrtQ/DXDQNgT+3FzWZN0GJq?=
 =?iso-8859-1?Q?pnUbUK22yEG8s0RDyW6dJK+88+69GmnATigrey46lZtM7zNXFvCcRE0EaW?=
 =?iso-8859-1?Q?Or1xlLAi4wcWC68OzUXv48XTmV0i1MSqZRnSZS8SI9p9qs6nbeYO3gSP04?=
 =?iso-8859-1?Q?y18eXINLcRyGSZIGZkevan/y7oSh6BwM5vlUiBm+hY+xRo5Ctt3SycVf/P?=
 =?iso-8859-1?Q?5V5MeiF8QS2h+x7OsdXNRGGxWsCcYOR7viaqIXqBWcQ3qcDqhZ1i1TT5pK?=
 =?iso-8859-1?Q?X/qjmThkA33yfuBYdJVVxJbR8yrPp092NAFVX0yNafQjpDWDauZZphZ3Xb?=
 =?iso-8859-1?Q?heArua618JUP2pqXhgmConKsckYueyY8FRIft1pYOcsyOoQknSxIHvPpBN?=
 =?iso-8859-1?Q?AZ88STMIn+Vy/APNvPZ1Z7ZLs3oR9D+J4EURDeqUtQ5o1GjEtkaoR2J42V?=
 =?iso-8859-1?Q?u+EI2OAgkykd0ZeBQV6EC9eIptzWnHwVMXYUKZaCA/IzElpeOGHpQnpjqs?=
 =?iso-8859-1?Q?AYBdFJKfAtS7NPMALSQnv9uifV7nID6rKtSUcj8IYelgvTBBzdZCl4eAQ0?=
 =?iso-8859-1?Q?RTtCuFQiNXkBoVyfT4ZBr/nAerjMOPmJvoQ+CzYpOeplDP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TdvWUzUI4PMfpYYGPJwvUfXDg0yVFTNA3Ajnjkf26goTha8ckEAqIqPD46kPL7zRZ3djzG9C+ip6JJWzxJUi/PsgVOr+iT9eatOUiTfEXiinzxohCoQwipKR+PldIhZuyesZuxMrkGb57in8eyA795U6Ed0MHMYaSky3bzLq+PeUx66a0mcZNONFwXYVpOTX0AZzb0NQuJ5m3vxZKHdmE75oAdArw/8vaSH2hXVqxE8Lw08ntRQTOuR6IbGjNKDeiHfiaAI3Bj+dU3FRdWs9seC3Naz536zMe6zkgMHO0MlOGMJ683ojYPn9TZdhmWtRJDKJrVsl8TkFtObrblLVJg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca0262f-14e1-4e7f-f332-08def89ae36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:55:25.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzSMR5ngTsBVCc4RKZPaQHiZSFtgstZZZartbJVDPHx9Gu+WlmvlUDp52PLGGrz/Io0zzcQXBCuKm1h5k4aW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB3282
X-MDID: 1786557328-lOeyLnnTCpJJ
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1786557328;lOeyLnnTCpJJ;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
2.39.2 (Apple Git-143)=0A=
=0A=
