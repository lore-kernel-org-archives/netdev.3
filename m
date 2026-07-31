Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80D3B6BE5;
	Fri, 31 Jul 2026 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521406; cv=fail; b=ihV5mj8o/a7TVjr8p2AbRr5dmKz1DhgTMuGVc5yjd3MecKNjP0wavku+jEej9DbAuzZi7BflvhYxe8mmnW3QOS1TsW0avi/1j+9oAgVMBVLz6VT9DCvKqm+utOmEBlG4Ne4nbxlDnvA/nGKJkoiZeR1WI0p1UT/EhZoHWGa/QgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521406; c=relaxed/simple;
	bh=AS42jLfCqwb0jJ+wo61aMY0kHHjaaFfRvzMTGPx1soo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OSOHKryn5IH725/AkK3aoFFV6nkM+r0WpwN02avVrsLsEEtxoXOjK1SwNZ6IxiRdro2zzBtAsZtnj4civ0XaJrzEftBZxfe1EISzrgL5fSDS0d5z36d/77WX9dO4xjpW8io+WjDW/GkcdEFYmcFz5PHjnVOET6zL2un0k/Cv+5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=EZAo/O3I; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=TNqbFBTB; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="EZAo/O3I";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="TNqbFBTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=td8ptGwnyVZVAD5tQwpXFx97juuqlmQG/Cv7ETuq1x0=;
 b=EZAo/O3ILXCSFtZZHSitbpp52ax5mx9DEgWbTPv+dEIiqOuyZ+JRvfFGevbaSw4gmd2snh0CcHuzXt6/Q6LTswEq9WHkBBaUKdDnXhlo6jvvUpgITySEt/P9yyVcq6jZgwofFEbHWipvGa6xZQ4euXHWj1Hpxkjq9LS1H6VCyj8FCAFk4DNoPo2IAjcOxpNbN8Ic44ycAidSsNRhWgYDXGeZ+5C51/8WCCzGpHptD3UYg7W48ug0f4cMTnVkwzAFDLUmwxYL0DP5BWBdwUmZeJIxlftSQD8lNJPPi72a/Fs5JE4wGol3jAB0IqbcvRQ5jq0I0IWqgwDE7Q4ExWpcUQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020140.outbound.protection.outlook.com [52.101.46.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AEDF7240075;
	Fri, 31 Jul 2026 18:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWAbFza3ocoTUk6RV/6T1jduzFRU1nFhy6vh75tJ4FfrBLG9kekK5s4YMIAHFbfUgtG2Ote25pSlK1jRHDc6c28ej97CYy89gXReJmRUS0deAk6fuQb9+NTXl2WfMe5Ru2seXKasZT/7CVq02pnhqYFPk4i0f0qAygtV0xtlccH4NMG9VDSqxHG+yDg9t7eX6FU3RyZ8ICGsq+AHWs0H6Di727QHVF86qbf/JJbnJXpziG3yjOGusfPEDuMR3023/QoDTKDGP4XJdH91GONcbqIdX6apceBFoV+rPTZWQzlw/1yMqdnJ1fKKs55Gt1pVd4IRANaeQXu1s5mDjbmUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td8ptGwnyVZVAD5tQwpXFx97juuqlmQG/Cv7ETuq1x0=;
 b=SAE3XGFjxAGlhtV4yHbjc9VvGkz0KvHk0qrwq8XXtLHssacr5Z6Yop5Y9gb14iuGRVREC3+0xg4qoSWPUSFy4D9wyJOc+5toRsBqPhGKxux0azUwon0O9yyXfLs4MjnToLk3qPd8GX+fyviVxmqAGopeEbGkwVk0ty3OAkG5+p0073TdWDoWveZf6ost//XDTqHh8/Dp+LolyLi/sy4IWx5yGLxSkkFxOIzNVDp/XGGOIywMxVV9KEfvo9X3MgIQo94D43giS/zv5z8jXoZ94SUAyGiBYNj1n46ZdOJq/pZPQIHqQmShQRh0Ttj3YYuwroVn7u2uM/nSR3LetfjDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td8ptGwnyVZVAD5tQwpXFx97juuqlmQG/Cv7ETuq1x0=;
 b=TNqbFBTBYbguCVWM5iLSjy7m5Ln/r2GXvaqyqZxe47tqYkTv8hjItMg30RoJtpXBvlHpGG7usgu2/FwgfQwvPEyENXfQNU26R6MNfLB2Fpzis4+eS4WNBYfV8T7t/LaiatW41szhVTFpMc/Df2r+Ev3DBry3ByvZb4kitPMTR1zjAQyectVAibtIiAcIn5G+/VDzml/x2HX3LVlah6c6+KsVUNZqnYZNNdBxgTo837YjnE1u4YhDArs+EPrGPZIAjk2B2LmZhO75Dl9aJtfbf8SoDS/xNyquEpdfdlK0M9MNaQgjCpz1iBO8tsx0K7KcZr962notXODUtZl+y0c4uw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH7PR20MB6618.namprd20.prod.outlook.com
 (2603:10b6:510:278::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:09:54 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:09:53 +0000
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
	<arouhi@sitime.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 net-next 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH v3 net-next 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Index: AQHdIRfJ6o/tf+5fnEqbVNg4fIzugw==
Date: Fri, 31 Jul 2026 18:09:53 +0000
Message-ID: <20260731180951.65725-2-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 9d9c1e5e-62bc-44ff-8d9f-08deef2eebf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|10067099003|56012099006;
x-microsoft-antispam-message-info:
 7HugPp0utmE9QfAl477FxIKSjhFE0skbVpR0ciLDbG0C6j34NK1s40kw+260ZiitD4dgf1Zb1J8ECJ6PaZHqNTjhIg7s8UEvHBzD3M1x21XTNOEKqouWnN0FogboIA9ZsejeGi7WFdcP/g5wOokz3eb/rUA77M3bb5jgafyme+KpDOQd2AlVkV1ykK3gTGn9WpMrxfkwtteReWteg1F4FmOW1Ed7bUgAwBrBo4WhSANTj//s2oIwx9ZSF8EaIGAdrKnNSWqPcMZc6hCk3yCgwT98WL/7F/MRHDllgezovqJ2W8bSFDbohM1IKkDHPEmCUM4GpNoydEtpIXAxRqsh801UyG+/FBx8WxlAd8KmRq3SUQzXJODL6GYO9oldWFhDDFdZJW2ovY8Wg9w5fQ1y4js3nMnUBC5qpeNYYxvHKvIjy1ifECS+XnJ64bCtxHZv/imnS3LPiIC/v3BzPNgTX85XYlSFGw+1wm2xWs+zxlG3EqXsawYBfSaDyTHRaNDMrgpU+SplNtWkRwaQtxHmTr+lmZgZDoVJnz6EuWhetcmve9W9Pvyank0UoAsT6bEgSn7Mhy/wfJUGxcB5fh4WWnvVvq4j2p5lxcwjCEoeiEA01t3xuF09DGQkGLx/Y8RNK1Ygr+O0B4d88IKNC/EgSxXQb4GJQh9iOeAfLPtCxAZPI2nXiVinBJt0KtLVGyh248FimOVy2bvyJlHokd4hasnk6Qt5VxvvyEZ5lGyaLMQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?N77OaJV5poHLxum9B4O9HJgYB3SVT6jNPcogxqv0Gr/KAEF1XoCdNUmCIO?=
 =?iso-8859-1?Q?tgaRb3q3cbFm07tVcvjVSGBknDLOcEPfSmTGXs+XorDdu3N5x1XbHP1vU+?=
 =?iso-8859-1?Q?SCLuGK1NxI15QxQ7T9c4YVHOGsKgg9cca2aIx0M5kCcPltbCIHs+71A/C1?=
 =?iso-8859-1?Q?LnkI0EB66laZsYkUtT7/g3YgXiiUwmPqTGmxcdfVFF+F738Z/AYuyWsOFR?=
 =?iso-8859-1?Q?xhTls0al6u4XadXzdlgHM32kQ0KhXmIovpHBeotiN9oD5fZF/18RwzV8Z1?=
 =?iso-8859-1?Q?8rhZiWktzcO2NdolONzaf+C+J1TeIMmjyeMe3NfimV/XAE7HXQT/6JeUWB?=
 =?iso-8859-1?Q?vXmjgKJWC2yrkMQ+x7lV7j+fd81qlltKUmVtzXfXpNfQ7Bi0w/vCGDPTY0?=
 =?iso-8859-1?Q?ClMIXWt+EUearCrapPu8dVSjKt0Ja38zgJLjb17shttP7XyjzYsnVe78MD?=
 =?iso-8859-1?Q?tmIDxyjhaPZZHMTR6qYBM76stgAyxLWt4UE17lU0tTk26smuXX6zvDezwn?=
 =?iso-8859-1?Q?9VFjjq9dy5bYUBTcToj+Q3xdTYy4DAuB/kYTMWywiP9xTDzLpPtqpXhGXF?=
 =?iso-8859-1?Q?9jhg43KRTWeoM016rVA0PxNQD9EoNyRyD1lgXtXYitOkvUElPewmpICbH4?=
 =?iso-8859-1?Q?HUTuPyAPUmWEk0K9W++WJ84HFZu6zK8zr9/vMN1hE3uiYXJZthQnyhnv68?=
 =?iso-8859-1?Q?oApPZJC7wlUiHNx4XvzSxVcKbYl6cqMCmG9yFaj6eRtBRWpnlfEj6OZOqd?=
 =?iso-8859-1?Q?laFL4H5GP39CP5P1jO9EfJGv7py1R5/TJ3Djsg1uCiQ33pOuWV1EDOljUG?=
 =?iso-8859-1?Q?whln72e7mbjoNow1Pf6sm5gCJJFtuFmTekTbRqQHm4HXVtQamnS6LDx/Rv?=
 =?iso-8859-1?Q?B614MeDHVmpQ0lh58LdYUorEtNvF8fazAV/gcMvF7lzpaxvSgcrMazGIQF?=
 =?iso-8859-1?Q?0hywp/APd09+g3sXyYOocVlQ2DtiNOx/psYJ4Pd0PjZpJUqONeu2uK/byx?=
 =?iso-8859-1?Q?xbzE5n4Di/aNrmQih8eFDIWmoI3i9WA2AOseAZcH/4KO4twhlpAGZl65T0?=
 =?iso-8859-1?Q?F6YgZ+gbZLYGDpcsTtot58OmKt88SV1WTkoL/IMOj+R015jMY9kEgxBUUz?=
 =?iso-8859-1?Q?QNOaPRdk2O7+jT0kYQxkRJ3JHtV7JzWP2lqIuQyDd8rzNX8s/iozdJWIUT?=
 =?iso-8859-1?Q?B5Mxjut2rpLBp1yCNLBYsmIQNNaGGCsGtS0DBgBB+WwKu96lRvSZuF2ajQ?=
 =?iso-8859-1?Q?+EirHi1zcUmvPQ9OU+OyFLGL252kQDUuOg9QkK3N78d41yMDYIHzQDb0Yg?=
 =?iso-8859-1?Q?RQXU3ZsgoquGcmNxEpyjtoe8wx2oFSlo7qAE/ndCqvJbzI/dTwwAjE/tG/?=
 =?iso-8859-1?Q?kz3cv9gmo+YdS920SUysYV6z8BCiE9G1z/efTARllUCVPxC569IRR8jSKm?=
 =?iso-8859-1?Q?MZOWG/CkoadZZH8e2TsgN84Otrzy8T59eqmYkqLvU5yeYcuNfsw9QFUS83?=
 =?iso-8859-1?Q?GRPzRxCiLYEolBdKe1Z7BVuB6tl4YjaOXlw8X5a67GCdnaOveUjq61g+B8?=
 =?iso-8859-1?Q?mC17R4J3IYBdWiZHzbV/mQHCRTMUED02CThclvHRJU7VtzInYiAUSh/BXf?=
 =?iso-8859-1?Q?4cUr0V05JrcjB0245gNvRwxwP3odxmjnb8l+leERb+ltGUl9zI9Cu/zEha?=
 =?iso-8859-1?Q?ty4ThSbd5o2bsEvKrmVG3NdvFttPhOy6wEztzZtiwFwY7eW0ygdqRqLGHe?=
 =?iso-8859-1?Q?KeZSBX1C+XA6cVKOvJbvDlZuyOF3RwZfaCwY5BEG907eOR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mwcQaqtJ/CUdKvgM0pA+sGZmO5bzownClK9wL34eHZy7y2ejUb2F60aMDzijiKqtn8GyUk727iCooGjvdIuWAh7T7yz9xguOcoHquPNLjkBoNw8tnO6Lv6LYY65mk6bl9K7UGDqQBhDhVtROtJvVu1+7SqUKaoV3zLgRZvT2ll4t3D4R453Wdu1rrPfoCg0fbi3ljhQwuKVqTNCwzeHAiplLUEf7J/XBTY2xRn/ZeAMr38T5FXNiVEOmhB70CYd5f9LozpvQZJnmfqSU3mKN3lU25ciMf1/7yrF9SO7oEjNrHL4RkRDhju1ovmtyQU8D+I9fNvPm18/DZOyucYTYeg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9c1e5e-62bc-44ff-8d9f-08deef2eebf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 18:09:53.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwSc90tIg9jhYs7mtQJe+NInX5jB8h/W4HfcKhVlq77iZ9I6XjbcggWyhFcTyfMASWsozlEu1udMQnJfk3H6YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB6618
X-MDID: 1785521397-RlOn8Hc4fsp3
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1785521397;RlOn8Hc4fsp3;<arouhi@sitime.com>;759144a0166431ce015cc972ca6e1055
X-PPE-TRUSTED: V=1;DIR=OUT;

Add vendor prefix for SiTime Corporation, manufacturer of
programmable clock generators and MEMS oscillators.

Signed-off-by: Ali Rouhi <arouhi@sitime.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7..1921718a5f82 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1535,6 +1535,8 @@ patternProperties:
     description: SiRF Technology, Inc.
   "^sis,.*":
     description: Silicon Integrated Systems Corp.
+  "^sitime,.*":
+    description: SiTime Corporation
   "^sitronix,.*":
     description: Sitronix Technology Corporation
   "^skov,.*":
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
