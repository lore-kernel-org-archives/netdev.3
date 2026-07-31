Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA02C15A5;
	Fri, 31 Jul 2026 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521407; cv=fail; b=d6jV37LlSeRoCWyv8p+gehbwmcb/KwTFuh6Rnq878f4Um97MMGmO5brRLVsLFUKQebqnb/GbdN0cXejqHWXcEwTzH5NpFna9vhdjM+Kj8VGAYlMAPjtmh23In4QwyMf59GeDNK7YZAz3OgWYMjXTdBUpK2MUVSYqOtu5kPTl0CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521407; c=relaxed/simple;
	bh=RwG4EHNO7LGehQqgkQnPGH3Y5Op0tuEKWNsS8Y17sHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0XQB4+gln1Jh7yUXwriYvdB1BBvpNev2dD/ycNoF5riOdRWgJS7j9TV7nbvB8HKvUJ1iuCrpUytkwPc42euOfZTDei8E0ffdj5mM0uMBUH/JRgbG/7NMq5ZjebA9IOcdCyhSnUSqMRhMjK9ln5QIK7wdwQDeGKvaIUPFfLZGe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=nDsEpXLA; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=U/fw7Pbf; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="nDsEpXLA";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="U/fw7Pbf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=/s95kjNxvuUycAdXksS+dqoDBcGcbvQF0tHTnHmfiq0=;
 b=nDsEpXLAhaozye1j0mpryw0UwwCrqaJla0abQIXFV5fVnzGp2CIoPKDEEiHFbC9yRIwYtM0khVmxOOqRISoxeJ1m0UlkKUYiNMddWpGIxJTd0Hp5Eu7xmGCd1VxzJh3/AXY5NzVe/JeBCUVB4Fw/q2zXXs1tICYrQqQ7afEhIiKt8gwRZHiOAXYgEso3dvQQgETeTyn31xhBrYU8j+OgaTUfvFAr69wvyOXnxZSFRHCF8km5EwGnGrZxKCssWTU7bK2P6pchH+KmFKqZQAULS3vVlTUquS3g6krUSI4N8a/8X3WFsYvLUTfuZnJm0U1mw96nKFlrYg3ycz7lDjIwuA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020140.outbound.protection.outlook.com [52.101.46.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F0A3F240061;
	Fri, 31 Jul 2026 18:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8cdmLJT28eEN/bst9FWoO9AslZ0QQ4s9zAx4zrKbdwKt93xnr+KUNo1BBYVLghN/c2EqwI30yoSdZl75a1OPJjP9NQfvzeAEaNyxzHNB6I64dSoj4NeT6L44BlLMKK+i8lo9q2QVV3jH5/33SKTsuNRTXhPWnbulRBVjA8E4lOVhJyiat9RdeOM3fytj4Rw7bwBOBDLU5ZheUUiw+SVXQh3ZJgYz1WSbfxcvKDCN1Lh+H/4hXAEfCJFht+buKycRnzAD2fLfMPmTQf9Gt/WGDO3CYnyCtvNRPVqX/uaZy17gedahhhZpQ/5VLs2QfH6Y0Co3FVq+X+vDsH1dcPJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s95kjNxvuUycAdXksS+dqoDBcGcbvQF0tHTnHmfiq0=;
 b=nm8BVyYvi3wD7G3WFoTLTKlH+xqvf//Kn0BwvV1u41GF1u4ptjFhxbJFaRoixgHGq34UwNrkOsAb8/Wfw9Uvv4hSPW7dSz6E6QIVUjbod6+j5IE2EY4TbJ90z2p7FJJ8V5wS90nToBGUyp6C3THhfrcYN9H67SxUwTKB+950eoyAQ1BmLpNYUxgxX4REbAtxdqF7JzVvBs6jyvqBnm2pdW79QktQwyDsD9tOkCotw31RwKSvrDaXMvK7WHxTqExuLnnmF8wLJYN8AJ9sxsxxIuKWPhXM9fQtxMdpjFh1h24xUWEZralCdt/8tkZcEB1oxOK3PGgl2x8j/OOLgBQonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s95kjNxvuUycAdXksS+dqoDBcGcbvQF0tHTnHmfiq0=;
 b=U/fw7PbfmBh9Cjy301PCjZD966UlqtEd+8Wcr9vTP68rZZR53wwLNoc95GHVsOFAGWkmrJ0iTD5r0pJXeVya24YPxlX+fh6bRJ0WBL0jHnk+tZA0pej91e1onOlRIHY9Oggh/37UIQC/bzNHSx2EBf3Dn5ZDER37y6KN797UDzimQOktHU6KZxv7fWoCcSJxlMpMlwTquyk+lo6hXad33NkK3AmoZX2o2I0ys9L2uID/2mUTVIOKXUyNSYfvlzXJ/dxl9edB2qKtNg/GgxX9JmA2qfnVnmVdGsK9135vfX9V3EHnKemp0+QTm2eLLvY60w8wd+JEA2BQ7b7mhKPC6Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH7PR20MB6618.namprd20.prod.outlook.com
 (2603:10b6:510:278::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:09:54 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:09:54 +0000
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
Subject: [PATCH v3 net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x clock
 generator
Thread-Topic: [PATCH v3 net-next 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
Thread-Index: AQHdIRfJjc+vN5LrO0qo+kpOG0Tc7g==
Date: Fri, 31 Jul 2026 18:09:54 +0000
Message-ID: <20260731180951.65725-3-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 8ff0d272-834c-4063-1f48-08deef2eec46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|3023799007|6133799003|10067099003|5023799004|56012099006;
x-microsoft-antispam-message-info:
 xXsSx0TeGYXxgCTmMUKmiKj5i+9SfLolmsCERlnLxtzDi/EnkILprpPMBVuQoivCFaIhnwCRLvtnBhEvQAQGqWj1UyXrYCrcuXk5dMF4Da5vLUPStlB8n01LFGiJLAJ5JyU/t7IZo6+fHvkRSUoIVdTgWxr2li/QN4wUMAO28akQRGxlMlaA3PMUZuJbh27HehWhhRQsUvU/DusU7uEgzyBVzWLRwSAgGSzq0pWjkvtCV7SUPEhu6iiuKxNofVWMNPBSSV4YIfeEZn0tgKg5w8juc6JX7nFdomYkxu2AaFUSgxjVw8doWplOsii7ToEHiWSOpEThNcrlunZ+PHjfEK3yJer2RWQ6aOtOa5WjGM7ilDTRmH/AQ+LFDlIQLqXXqTtCBE3DA1dNFiXvUZdTxfsZqGNXwKfkRlZhFtiJtJOx2XDxD178nulV4cTTsUfCWth8nrTuawA4+HGx35W62Wmdd1yCr/+lo6rmZCFjVmzGPK6aU1TF+KsF9Fg1KwVsQWr3tykD/INOaEjPzqsbhLetiso5KSqZbbX09U7DhgVGEnwbZlvMFpbtNpWtf3MR32fTCVky+jSCihRmbaASr6LD2xMs3bo4fumhKlwfIFsFhW5wjI2mCuDlv80O6VklO3UncTXSm31exFrtChRSlPXkuGWacHYsr51eNzilr7I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5fqUcYeyVrxR9Bd2VVHz2MT/QmQvS6Ve+BP0G9/PuDAGnxW4WL3bMCfMeT?=
 =?iso-8859-1?Q?UUVaJbqSJTJtCanF2RXaw/VKCRvNwQOwXZJPfSwfLmWDMrHdsva3k51FB+?=
 =?iso-8859-1?Q?vXObhvLKGnA5ft/3yVwnZ1VAtr6SHE8GdNnbZrvlz58hVcL52WaxaURcHp?=
 =?iso-8859-1?Q?wTrHax+wjrhyXR6tqo8c76KosbQkA+baphLDze6VZEGsmuQogolGLcKjId?=
 =?iso-8859-1?Q?YySeoc98HOYdSwMyvOPnL6bWCyAWGRL7Xj96b9rLPUFeQ7KspABS18ZqyJ?=
 =?iso-8859-1?Q?0jtlbuiuHOLMHsYize+E27KG+CQzL9oMRxEu1ykI56x0gKdn0W6RBkQaPm?=
 =?iso-8859-1?Q?/sdRUcDdG/1Gc0Ljx+WXjd/0LQ1sZD8+Y9IOhJpZo0Zr6ryS6P5N9XDNpf?=
 =?iso-8859-1?Q?Ilrcj3MIPFwdYn8mNgL8kE5bS/HGrT5D04P3KrKTs1OQ9QcLeUIv1QPDMh?=
 =?iso-8859-1?Q?uWlxey7Z/rGRNUBhrpMA7ltK31yspOLDfZPXsTtpH1Y69ghas2TDSX8mq/?=
 =?iso-8859-1?Q?hg4AmkYKluGpZJU7biuQ3+Yo96ws5+9mYhrvYN1aVgsUK/bXAA58yUurDO?=
 =?iso-8859-1?Q?HLiDFc/IcrKB5AoIxPKAzw6vmqXC5idRiIyLmjjWiMWS4IxMt10ZypT5Uv?=
 =?iso-8859-1?Q?T5x1KEdEVi3kauhBTuOVWROquUbMtp6gj21DEBD/Wpw9ifgdYQrlg/eg6p?=
 =?iso-8859-1?Q?lOmkG2drQ8t0xbYlcWRwD1oo0rKzGotNBfAxbCGWY09GsexvFY3eVSj2hp?=
 =?iso-8859-1?Q?lxjfZDtikVul39yeWxsf55y0wdLJ3PS99V8P2CpiRv9pVm6n/zhjIY904H?=
 =?iso-8859-1?Q?47CPS8I9cdKXJsY4mhJeIzBOhgJ/ZR6UgpjK1/yuQbN51TW8ezXlTxKcN9?=
 =?iso-8859-1?Q?LMykGvl3CrbLs5KzSM+L7aGMFUXykMcWUeW2/zXVz1TsHPUieGm4YLxu4G?=
 =?iso-8859-1?Q?3r3jIgH7FAEA3oSkwOpNb8V0vFK2OumPbwXdpf/G+CkgtVa5/nB8FvemSJ?=
 =?iso-8859-1?Q?ezMQWI+yBrCWUJ5EGVveZiADEkN715JKC34GVtT5H3SSddqjn1o1uILmJ3?=
 =?iso-8859-1?Q?sPMyWgafkmxDMdHCBP5tHdisawj4Us0ovPufsNhnv/AFJ8rvfVmaqxH9Tr?=
 =?iso-8859-1?Q?XKkuaWrI5jqZrl757JqKivWMncedVSk+tWYh98f29dkXUUJIxF4C0V8K2l?=
 =?iso-8859-1?Q?ntgkFe7m0XjyvS22eADBbTPXZqpnwNrl+BZE2r/qZo31mWxcvu72DzQWJw?=
 =?iso-8859-1?Q?qrFZVsKzCY8sA+XcRXj+tQ15kFIbrouwOxFUT7edjkewoyOBdKKlqer1YT?=
 =?iso-8859-1?Q?LzviIBVmv8aga69E0M20s3RLS/d9i/QWBaFig3Cdxtq3YZf7yhliAYxuQR?=
 =?iso-8859-1?Q?Ad/qvgWWQn58NwoiVo+VCETCQqPTa6EiyhlH3aqlAPqQvNDvEvy0rWPrEs?=
 =?iso-8859-1?Q?rtiXw94blF1bdpY7TrWa+01lu+pg2tSt0NSj2nisRfFRTbK3AajpNeRTTi?=
 =?iso-8859-1?Q?4XhjaUt+ltLjtpnm+sWANf7ril9EUR6bJWmBu/qIPP+5ifnsxn4/qHooTF?=
 =?iso-8859-1?Q?nJ0HT8Hrjo0yJoU7GTL0NnDvW+8EJR9KH7iS8EsoKyvQEDlqn4YYssiCwE?=
 =?iso-8859-1?Q?A1DFekYnHV7K3chbBzvVasXMcRUJaRvIY1obUrqKSVKtSqMwJ2g4ZYvn8Y?=
 =?iso-8859-1?Q?QEXkNBvxuPBuFQnCPPBdBAIy0vn/FtAKuhRGpLe+fsO+PYpQYC3kepAAU/?=
 =?iso-8859-1?Q?suuz6pHIzF6NBgcqCYdovq8nkEH5W7ec0ifKB1NLfTaFMM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mC4mgl4uWUQxSjXkmicCkaWdIP3CBf2rfO0Tw/jZWB9NEcRUzsWzlnuW11hYA2letYgi7SZqDD7z6XVBccZnRBCzjBEZIgTUhwzNpcljrjHDrbNy/FxqYjmtcXAA3vkqkDG3Vmte9fp8LIEHgzBAFRhu1Wj7vpiZh8i7Pck8TvpQVqGsQffwTAIbH4PboGTDf8bAZw+XAPrr84tZgFU9OxVyDkdY/i93MVj8RbZmk2sSd/wVNBZ8pRO4rAU/UfLJlu+FJT4L5HKdXp1qfG28J3meEVW8oL/KbHeHmMr347efTQ7Hh1gBt8jrbdWA6yoXFcc7bbXWWILMV/gtZucf5w==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff0d272-834c-4063-1f48-08deef2eec46
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 18:09:54.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TyFdbl2rleZYBObCKpWrPpQUGf+PLHLlKITlYIhylLlt0w71JwNvNZBl8fWGIWh69TKKqT87zGP5YgylWm3hbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6618
X-MDID: 1785521397-nL4KalGXwMXq
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1785521397;nL4KalGXwMXq;<arouhi@sitime.com>;3996c0438aeafc66d5842742ecf5d65f
X-PPE-TRUSTED: V=1;DIR=OUT;

Add device tree binding documentation for the SiTime SiT95316
and SiT95317 DPLL clock generators.

Signed-off-by: Ali Rouhi <arouhi@sitime.com>
---
 .../bindings/dpll/sitime,sit9531x.yaml        | 203 ++++++++++++++++++
 1 file changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.=
yaml

diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
new file mode 100644
index 000000000000..56a4f5135fb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
@@ -0,0 +1,203 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiTime SiT9531x DPLL Clock Generator
+
+maintainers:
+  - Ali Rouhi <arouhi@sitime.com>
+
+description: |
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock
+  generators with integrated DPLL for synchronization applications.  Both
+  variants contain four PLLs with automatic/manual reference selection,
+  DCO frequency adjustment, and phase offset measurement via an on-chip
+  TDC (Time-to-Digital Converter).
+
+  SiT95317 provides 4 inputs and 8 outputs; SiT95316 provides
+  4 inputs and 12 outputs.
+
+properties:
+  compatible:
+    enum:
+      - sitime,sit95316
+      - sitime,sit95317
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: xtal
+
+  clock-frequency:
+    description:
+      XO/xtal input frequency in Hz.  Fallback for firmware that does not
+      expose the oscillator through the clock framework; prefer the
+      "clocks" phandle when the clock is available.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the chip's active-low reset pin (RESETB).
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt from the chip's active-low INTRB output.  Asserted when
+      the device detects a status change such as lock acquisition or loss.
+
+  sitime,pll-fvco:
+    $ref: /schemas/types.yaml#/definitions/uint64-array
+    minItems: 4
+    maxItems: 4
+    description:
+      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  The values
+      exceed 32 bits, so this uses a uint64-array and does not carry the
+      "-hz" unit suffix (which implies a 32-bit cell).  Override
+      for configurations where the standard Fvco =3D Fref * DIVN derivatio=
n
+      does not match the running VCO -- for example a PLL operating in
+      INTSYNC mode, or a chip variant whose VCO falls outside the
+      documented PLL_FVCO band.  A value of 0 keeps the register-derived
+      computation for that PLL.
+
+  sitime,output-pll-map:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 8
+    maxItems: 12
+    items:
+      enum: [0, 1, 2, 3, 255]
+    description:
+      Source PLL index (0=3DPLLA .. 3=3DPLLD) for each output 0..11.  The
+      value 255 (0xff) marks an output as unmapped and prevents the
+      driver from registering it as a DPLL pin.  Override for
+      configurations where the chip's per-PLL OUTPUT_ENABLE bitmaps do
+      not unambiguously describe output-to-PLL routing.
+
+required:
+  - compatible
+  - reg
+
+oneOf:
+  - required:
+      - clocks
+      - clock-names
+  - required:
+      - clock-frequency
+
+allOf:
+  - $ref: /schemas/dpll/dpll-device.yaml#
+  # SiT95317 exposes 8 outputs, SiT95316 exposes 12.  Bound the
+  # output-pll-map length to the variant so a SiT95317 node cannot
+  # describe more outputs than the part has.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sitime,sit95317
+    then:
+      properties:
+        sitime,output-pll-map:
+          maxItems: 8
+  # SiT95316 has 12 outputs.  When the map is supplied it must describe
+  # all of them, otherwise the trailing outputs are left ambiguous.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sitime,sit95316
+    then:
+      properties:
+        sitime,output-pll-map:
+          minItems: 12
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        dpll@68 {
+            compatible =3D "sitime,sit95317";
+            reg =3D <0x68>;
+            clocks =3D <&xo>;
+            clock-names =3D "xtal";
+        };
+    };
+
+  - |
+    /* XO rate from a property when the clock framework cannot provide it =
*/
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        dpll@6d {
+            compatible =3D "sitime,sit95316";
+            reg =3D <0x6d>;
+            clock-frequency =3D <96000000>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        dpll@68 {
+            compatible =3D "sitime,sit95316";
+            reg =3D <0x68>;
+            clocks =3D <&xo2>;
+            clock-names =3D "xtal";
+            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
+            dpll-types =3D "eec", "eec", "eec", "eec";
+
+            input-pins {
+                #address-cells =3D <1>;
+                #size-cells =3D <0>;
+
+                pin@0 {
+                    reg =3D <0>;
+                    label =3D "clkin0";
+                    connection-type =3D "ext";
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;
+                };
+
+                pin@1 {
+                    reg =3D <1>;
+                    label =3D "clkin1";
+                    connection-type =3D "synce";
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;
+                };
+            };
+
+            output-pins {
+                #address-cells =3D <1>;
+                #size-cells =3D <0>;
+
+                pin@0 {
+                    reg =3D <0>;
+                    label =3D "clkout0";
+                    esync-control;
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;
+                };
+
+                pin@1 {
+                    reg =3D <1>;
+                    label =3D "clkout1";
+                    supported-frequencies-hz =3D /bits/ 64 <25000000>;
+                };
+            };
+        };
+    };
+...
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
