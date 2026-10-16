Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F86312837;
	Fri, 16 Oct 2026 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112150; cv=fail; b=EZGFwpYvKKKQP+tnM0aCD1gGiooARBeQi3/RHPNmHKjlF5XWw9mrgXyc1AsA/hrTf/wKwW4W1wh1f5cN22uit3dTLemMGeCZdPTkES2ysV+MlV02UZb2ivq9Tz3oJ5lA8dvAfrgziwukGjgzeJ5Ac/XjwxlUqq3X2eKnX+QVKmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112150; c=relaxed/simple;
	bh=SVFA8piqAXjF/9I+LaULg9wq8lCXoi9s+jWdBDZCDFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NLa0m3dS1J/N2W1DjU0yiSq3f+xpGP9lpw1aZ5XTP1Rin+aIk8W59AjYZQCQCVneC0ofMyoQWILjcxQdJazsxIH2KGhiuzlGmYLrTXnetvkGVmrsMgfw9ouDoxzGLeBsCKUQvlZ0cTI/RtRW519k5DmbUfct0L0TNm4n97hYnwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=bHOd6b2z; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=hxof4b/W; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="bHOd6b2z";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="hxof4b/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=SVFA8piqAXjF/9I+LaULg9wq8lCXoi9s+jWdBDZCDFs=;
 b=bHOd6b2zi4TfnJrGbWiHTbbt/O0vrCx0EmFzyGOuH4mCgdznCtLEprBQUfe2TF4Oo6dGTwQKsG/nITewoiCkv8kixj23fXvqUO0D+MJSP9c4RNVp+W61jFV2sQdp7uLsOHHrSDH9vAttAoeoeuRzWty+BFg0mN2WGoNb8+wmCvwGbp38QbqGZJa2EmYqQJdK6O2TPd9ChrXcASOGQ6Xze+oD4Oy7q4Dg7OQHDlsxG4sdVD7huNXTYd3y4KjJQ2+4yHKfLKU4dkq1gLAUBxGnPyN77CIykQgyAz3MCQdsHJidyw0HrAvGRKp4WUZoeNC9kp0vIpCCLehxSLvr8+9tug==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020104.outbound.protection.outlook.com [40.93.198.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1489CC006B;
	Fri, 16 Oct 2026 00:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLfbrmF8vBvp+gNUVlY+LMB/xEuh5WpOmP222+95gMrboKojCp7vkiPxG04BoHUfKntPJvyh4sD6E/jQn4T30HOk9DIvrWADJQpeJnRMR52oKSTpJuxVISQB/sozO1i6wSj/wA220MtrPbmtVAuQdotxZBobmebcM3GrFMu5pmnW8pGT7VxtUiaAt/ItJO7cw10RwXfe0NwCFnF7/aD0ALiAMHMis9A+X7r86ejDsO8SOGk4iA+7FLnbN/80eyPfyoCJnzUipDDnNHISP5+tlQ51QHkbheNhOwrxJBL5EtTcrXjy6QndYNA3kTABUT8TpHeuDgE3PQyiEmjztxARZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVFA8piqAXjF/9I+LaULg9wq8lCXoi9s+jWdBDZCDFs=;
 b=A2+SPpci+6HRm101/9pAgFOok9cQFEDbg8hzm5NfZtaInZUxBqtexsm/5Kc9jEQFd0TiwZb3E5kWC6+Crp++3zyplaN5JtC35PmJAgXneNRnL7rTkOHUCBN6PbLg6EYOGuYD00GAd76iJpAxjogwD8Ew+Uwv/CkqH2i1gNY/hT2Bl9u6lMTINTZp4hznm0tsPAe0BafN5kT19c8jKJUVya/XuXyvLBqQNp6v39DrzXDTdA/MqsSWjQ7NqgUA41ygPWx4urenE8Vp6A7xT8/JnJ+dKsWi4hAi7cS9HVzqUVliiYFxqXf+SwHgNtVDDk8EBMo/RW/kqKbpFPRoDnlfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVFA8piqAXjF/9I+LaULg9wq8lCXoi9s+jWdBDZCDFs=;
 b=hxof4b/WKdcs/c5eUIrksZUnXuFWje+H74n24abqoNx5yRcPPPnzg5LuMIi/gs6p8CKEWbYaMCbhKFIMyGcn+T5jiwysuLtWDs6SNKj74xNbP751WKv39C9j3aSHOLZ49EgXkfx6QRx+Q5mqVYXzZvgKCABaKQhNbNDzVYbadBQQ55/0DMEoThJ+s+474TMg8bsDsh0Ymkj8R2/IiUZ4vmjH2YUCz5w117ARBiwJ4gqJtEIOEi+GHgan1A0SeyMbhFh5KwoQLDXYTu1imDX+EfuHtw21ESr86VyxvktU+T5eRUd3oSehACBRDVSjFdw+Wjx5qZWt4iy2xQbttgpN7w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:55:45 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:55:45 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 10/12] dpll: sit9531x: add support to adjust
 output phase
Thread-Topic: [PATCH net-next v13 10/12] dpll: sit9531x: add support to adjust
 output phase
Thread-Index: AQHdW2QBMpf/Nfqgokq9o7XSBNs1Arb9o5wAgAG3vAA=
Date: Fri, 16 Oct 2026 00:55:45 +0000
Message-ID: <20261016005541.11374-5-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-11-arouhi@sitime.com>
 <sashiko-outbox-171998@kernel.org>
In-Reply-To: <sashiko-outbox-171998@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: 2ef92afc-ccd5-4d1a-3fe2-08df2b2035f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|5023799004|56012099006|261009223027099003|4143699003|18002099003|10067099003|6133799003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 CGdpiWcQDPJqT4vLRAgMIXYuxKbvVHlylVE3YAjbA5lbPtBHOsazEqQ0qSfWW9SxvRCYKOzaxnUFAfnO3aR1bOx2oyvyo6q0EHxmrDroVyLPI/ewic9L+Xx0xwZggW57amfpUKI0cO14x/Q4CEY2YxX3wVSOCvWy0Qp3/1NsWF+qhxxWLtV+5tDTWE81HhpYR2vCszXwLCpD9NAqb7Li8zb3RYw1pbAubGeTxkwqXczSv/KuzNMsfItFPimMhp8KC2FA7F3DF0JRf5hsILsOca+YQCsS57o05er9kwZRR4Mvc1rji6hVFi14PeVqb0kLuZ0J4ffng0KPhVU8AXBzp3Cghw2VHfTsg5hTzAKu1wgLBmwm5zXzfxacN/N6odZbOg+eUU6XvOLT0Ec3rEtBBfuxZwiYydqYlbiy3D4iJmAoWzYT/kr7o2Mwr6pZe5LzhKpkKYLU5/ZC+2Hz+CfzHL7rrZ9uuZjGTtddheCYo6qzDwUHGc1ubc9KupzmEYzXAcOQhLF2nKEQyEuUGcpY8xly7jJ6Pc7m3r7R2eK7eMZo3yB0eJ1V1i66cCegvI7xA5QK37yR11H279fTAl925V8oaq/qr/ItBh7kJ21qstgjqt6QlBOD9v7OMcxCmah4fH0jZmkB1PCZ++uZLUj4SVf0V0S8mkK5Ycjc2hP5FENywTXiSuq7zFxh7TG1z07m+uuE8OCXrjRdMk7/PPWKt075IYFLbba01prLmwhtZ50=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(5023799004)(56012099006)(261009223027099003)(4143699003)(18002099003)(10067099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHlxYjFHR1ZhdElTVndUbjNGQTYvWEdHZFVQWmw1RXoyVk03Wm1qNFc4dDc2?=
 =?utf-8?B?b1dPVTk3YjdUL3FmUENIWFBYQlJxV0p4NklPZUJPMVppd2sxMHRSV3YyY0sr?=
 =?utf-8?B?NStPemJvRURicjRJRFNmRU1Ba2U3OHI5Q3hQUERtYjlsSFd1QjdLMS9iNVlZ?=
 =?utf-8?B?N2NiVWtSSkJ2MCttaTZ5MEtHNUZZazJ2eGxkc3NXYk5raHJPb001bVhGUnlG?=
 =?utf-8?B?eUdZcGY2K1hlMGdmbCt3Q3doNk5DM3lVQmdLc2V4R1JURkRiUHF2eGtaTUZF?=
 =?utf-8?B?ekE2UkRGZkViWHJub0hDMWU2YU1ySGdzNjlLUFlzNGNmKzh6MHYrbDB2UGFH?=
 =?utf-8?B?WEwvcjUrS0ppUE13aGhETWNtYnBJTEZoNG5pNGIvdll5UkNVVDhZTnFCZHI0?=
 =?utf-8?B?aXlpU2hCcjFWNW1LY3BuNnluZUpSMWg0OENiRmZRd2YvTlZ6ZHJqUGFGbXVw?=
 =?utf-8?B?RkU1TWpEMzh3SkNoMjhlcWF5b0JOMHBxMkM3emV5VXM0elFhQkJiVFVGaTBN?=
 =?utf-8?B?ZmFaOWNadDdRWGhFUmFhWlorL3FpRlU3L3J5M29kU01Xdk8rdnUyWXVUU1Fa?=
 =?utf-8?B?UGRTdjdTK0NHOXd4Vll4dmtlNUcvdVZScFRyZWNxV2U3ZW5lTm5XRW1LcDRt?=
 =?utf-8?B?bHhsOTZvajlrM09OMTlaMG53ODVLK0xELzVwcGdLc2RBOXcxeHlyTmZad1p1?=
 =?utf-8?B?R2dhVzdGaVR4ODNqbG54MW1wTkFVR090Z05GcnpDYVpHOXpOblJraTJwM003?=
 =?utf-8?B?NzVCYmhPYk9pNHZKUFJadnhWNE01ejRwbmkxeURJaVBTc041NjhXTUZJWkFq?=
 =?utf-8?B?bGFnL0lPRm50aS8zelZGTmVUa2pnT1k4M05McVVJNk1RS29TOGZTempnZW1J?=
 =?utf-8?B?UVUxeXlKeXg4OUNabTlHZkx0eVNYMTB1WXlCN0x5MTlMZlpURmhKeENzUXh5?=
 =?utf-8?B?a0hXbVIwYnhFUzN3clVGZ3lLWktLYngyMTNic3BvZ01RbU9rL3dYZHFkTlhm?=
 =?utf-8?B?ckRvU1k5bzBjWnBpei9HcjlLc1JraENScUlrR1Nob3hkOUc5by96ZU5OLzVL?=
 =?utf-8?B?K0krcDZGbGw5UEk5b2tXZFpnNmRKc2NRZjh3UFBjcTRyQ2Yyb0oxSTloV21W?=
 =?utf-8?B?bThyWjRrQUlSb1h0bGNKR2pTeFJoYSs5M0cxK1UzNUlycnVYVHV1ZWViYytG?=
 =?utf-8?B?d2lRMDBISzRXV2dRY1YvcmkwMHJ5L2FqSFYzVkhjNkxDNnVyL29XWUYyUUM4?=
 =?utf-8?B?djZiNmR2Sm5uMW5GSklBWEhzWHMzMDRuMFkrbGJ5WFhuSkpBc2RJSHBBM0NI?=
 =?utf-8?B?UHd5WHJ0UlRSYWFUb0w0MXRqYktBa1lvT0t3QTgwVUU3YklrMnhuVXFLUGdV?=
 =?utf-8?B?dUw0QXcyQWM1Q1VDdktWbWZHVUlzN2VMTVZWSVlyeEVKUm95VjVLa1FEQmlD?=
 =?utf-8?B?RXl2enY1NzJSOXYzWi9Zc013bEtya1ZlditvLy9YcXhkMnZTc05VeWJsWDFr?=
 =?utf-8?B?aUZ5b0VBOGFRdFBYdlkwbEduZGJKRFU2UGJUNEkvRXlKbUlTZndta3c4UzRX?=
 =?utf-8?B?Ly9lWDQ3eGpNcnhVREtSYjV0YTNVTFBiQjBzeFVHZTRid2JpZVA2QlVXNzZO?=
 =?utf-8?B?MlhjSEVyeFVKOE1IajRSWTMxMnlVYnIvbzFvZWwrUmx6VjY0eXBMZDQ5ZmxW?=
 =?utf-8?B?eml1bGhaazhXd0N6VVovb3FGNERQM01zeDNrTjVPTkpQRHlBZDdScFR0WG1F?=
 =?utf-8?B?aFQ3UWh3Nk1aaXYwTEk2ZldlaUcwaTFoRkx3MTVuMDB5QXJwOGp2NktVSktX?=
 =?utf-8?B?WUJWdWdhQTdEL0NIcHN3ZWt0UW5hQ3h5bmFjRExhWGRoOXdBa0Q2OU9MaGhN?=
 =?utf-8?B?ZEtsYWZCWS84aE11TXRJVnhIY1MzcHl3NU1tWjVZeDhmNUlCU1g2Vzc1M24z?=
 =?utf-8?B?SnpUTS93MitxbmN0b2J2VW0vb1BEMzdLbEdRUHhkeWZiY2RXTTl2Sm1jeFNZ?=
 =?utf-8?B?b1B5KzkyNklSZnE1MHJ0VFZqR2VCOFdES0x2QTNGdUkzdnIwem9MK2loWVA0?=
 =?utf-8?B?STBiN3Z1djVKNWY4aEprN1BGQkNJNVhCcWhQY1V2OE5BbThjbHVXQlZ6MDRl?=
 =?utf-8?B?K0psR3FETktDMWo1d3hmR0dqSEY0bjRIb3QvcVEyQzdRNDZMQkFsV0NwTGM5?=
 =?utf-8?B?LzZaMjBDMXdZZkh0QXBoWWVUa3h3dHNDQ0R3NlRCV0oxaktWTWtDY2lFU3BQ?=
 =?utf-8?B?YjQ2Sjl3RE5mQ243ZTdDT0tqME0vNFZKdVcwOGhmd2twa25iTnVjN2c1RHhm?=
 =?utf-8?Q?5y03Mtnc7zHp/BsiJb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	N0yMca6mJm8RxD2EaXeJcPKrvcNomV3CRP49ifJ5GCOZuClr9UqSMQbvSrv0TbG0yMRqPshUqBcmsC96TSG1WlmYJZCGKIag9ryZwBV0Quh8nrQg4Ai2Ih4g5XOwmLcsaIjKZM3+Zh++3STV8xpKC2xSShOcoTZoeeTBwKSIQrGL7LV4E1NNoHL/yEjOSo+/RvdbetLjyzYfRWTCEoohO+51Di1SEahluhUVKymr/anbiAvJJvMy7wxs8vOlZha5UEu0lhHbfLQYahSOaIIqhUj9mzpC8sfT+15zT9FBoe2XLASX5lxrYZaKlQlNbYaz430vSK9uTsVgBOh68U/VJA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef92afc-ccd5-4d1a-3fe2-08df2b2035f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:55:45.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/yJYTzE4XKbHPD4oItqJTNyOuECiaXj4/qnd1CD9DIS0ZHkRDXLiqvNL8IPNIkSkfcwn0zrjxbs9YO7oEpDUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112147-86aILELrUyad
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112147;86aILELrUyad;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gV2VkLCAxNCBPY3QgMjAyNiwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToKClJlcGx5
IGlubGluZS4gIFRha2luZyB0aGUgdGhyZWUgSGlnaCBmaW5kaW5ncyB0b2dldGhlciBmaXJzdCwg
c2luY2UKdGhleSByZXN0IG9uIHRoZSBzYW1lIHByZW1pc2UsIHRoZW4gdGhlIHR3byBNZWRpdW0u
Cgo+IFtTZXZlcml0eTogSGlnaF0gRG9lcyB0aGlzIHRyaWdnZXIgYW4gdW5pbnRlbmRlZCBwaGFz
ZSBmbHVzaCBvbiBQTEwgMAo+IHdoZW4gYSBmcmVxdWVuY3kgY2hhbmdlIGlzIGFwcGxpZWQgdG8g
YW4gdW5yb3V0ZWQgcGluPyBXaGVuIGFuIG91dHB1dAo+IHBpbiBpcyBub3Qgcm91dGVkIHRvIGFu
eSBQTEwgYnkgdGhlIGJvb3QgY29uZmlndXJhdGlvbiwKPiBzaXQ5NTMxeF9vdXRfc3RhdGVfZmV0
Y2goKSBpbml0aWFsaXplcyBpdCB3aXRoIHJvdXRlZCA9IGZhbHNlIGFuZAo+IHBsbF9pZHggPSAw
LiBTaW5jZSBzaXQ5NTMxeF9vdXRwdXRfZnJlcV9zZXQoKSBkb2VzIG5vdCBjaGVjayBpZiB0aGUK
PiBwaW4gaXMgcm91dGVkLCBwbGxfaWR4ID0gMCBpcyBwYXNzZWQgdG8KPiBzaXQ5NTMxeF9vdXRw
dXRfcGhhc2VfZmx1c2goKSwgd2hpY2ggd2lsbCBmb3JjZWZ1bGx5IHJlc3RhcnQgdGhlCj4gZGl2
aWRlcnMgZm9yIGFsbCBhY3RpdmUgb3V0cHV0cyBkcml2ZW4gYnkgUExMIDAuCgo+IFtTZXZlcml0
eTogSGlnaF0gRG9lcyB0aGlzIGxvZ2ljIGZhaWwgdG8gdmVyaWZ5Cj4gc2l0ZGV2LT5vdXRbb3V0
X2lkeF0ucm91dGVkIGJlZm9yZSBwcm9jZWVkaW5nIHdpdGggcGxsX2lkeCA9IDA/Cj4gR2V0dGVy
IGZ1bmN0aW9ucyBsaWtlIHNpdDk1MzF4X291dHB1dF9waGFzZV9yZWFkKCkgY29ycmVjdGx5IGNo
ZWNrCj4gIXNpdGRldi0+b3V0W291dF9pZHhdLnJvdXRlZCBhbmQgYWJvcnQgd2l0aCAtRU5PREFU
QSwgYnV0IHRoaXMKPiBmdW5jdGlvbiBwcm9jZWVkcyB0byBjYWxjdWxhdGUgYW5kIHdyaXRlIHJl
Z2lzdGVyIHZhbHVlcyBhZ2FpbnN0IFBMTAo+IDAgZm9yIHVucm91dGVkIHBpbnMuCgo+IFtTZXZl
cml0eTogSGlnaF0gU2luY2UgdGhlIGhhcmR3YXJlIGxhY2tzIGEgcGVyLW91dHB1dCBmbHVzaAo+
IG1lY2hhbmlzbSwgdHJpZ2dlcmluZyB0aGlzIHBoYXNlIGZsdXNoIHdpdGggcGxsX2lkeCA9IDAg
Zm9yIGFuCj4gdW5yb3V0ZWQgb3V0cHV0IHdpbGwgZm9yY2VmdWxseSByZXN0YXJ0IHRoZSBkaXZp
ZGVycyBmb3IgYWxsIGFjdGl2ZQo+IG91dHB1dHMgbGVnaXRpbWF0ZWx5IGRyaXZlbiBieSBQTEwg
MC4gQ291bGQgYSB1c2VyIGludGVyYWN0aW5nIHdpdGgKPiBhbiB1bnJvdXRlZCwgZGlzY29ubmVj
dGVkIERQTEwgcGluIHRyaWdnZXIgdmlzaWJsZSBlZGdlIGp1bXBzIGFuZAo+IGhhcmR3YXJlIGRp
c3J1cHRpb24gYWNyb3NzIHVucmVsYXRlZCBhY3RpdmUgb3V0cHV0cz8KCkFuIG91dHB1dCB0aGUg
bG9hZGVkIGNvbmZpZ3VyYXRpb24gcm91dGVzIHRvIG5vIFBMTCBpcyBuZXZlcgpyZWdpc3RlcmVk
IGFzIGEgcGluLCBzbyBuZWl0aGVyIHNldHRlciBjYW4gYmUgY2FsbGVkIGZvciBvbmUuCm91dFtd
LnJvdXRlZCBpcyBzZXQgb25seSBieSBzaXQ5NTMxeF9vdXRfc3RhdGVfZmV0Y2goKSBhdCBwcm9i
ZSwgYW5kCnNpdDk1MzF4X2RwbGxfcGluX2lzX3JlZ2lzdHJhYmxlKCkgcmVxdWlyZXMgaXQgYmVm
b3JlIGEgcGluIG9iamVjdCBpcwpjcmVhdGVkLiAgVGhlIHBpbiBjYWxsYmFja3MgYXJlIHRoZSBv
bmx5IGNhbGxlcnMgb2YKc2l0OTUzMXhfb3V0cHV0X2ZyZXFfc2V0KCkgYW5kIHNpdDk1MzF4X291
dHB1dF9waGFzZV9hZGp1c3Rfc2V0KCkuCnBsbF9pZHggMCBpcyB0aGVyZWZvcmUgbmV2ZXIgcmVh
Y2hlZCBvbiBiZWhhbGYgb2YgYW4gdW5yb3V0ZWQgb3V0cHV0LAphbmQgbm8gZmx1c2ggaXMgaXNz
dWVkIG9uIFBMTCBBIGZvciBvbmUuCgpUaGUgYXN5bW1ldHJ5IGlzIHJlYWwgYXMgYSBtYXR0ZXIg
b2Ygc3R5bGU6IHRoZSBnZXR0ZXJzIHRlc3Qgcm91dGVkCmFuZCB0aGUgc2V0dGVycyByZWx5IG9u
IHJlZ2lzdHJhdGlvbiBpbnN0ZWFkLiAgQWRkaW5nIHRoZSB0ZXN0IHRvIHRoZQpzZXR0ZXJzIGhh
cyBubyBjYWxsZXIgdGhhdCBjYW4gZXhlcmNpc2UgaXQsIHNvIGl0IGlzIGxlZnQgZm9yIGEgbGF0
ZXIKc2VyaWVzIHJhdGhlciB0aGFuIGFkZGVkIGhlcmUgdW50ZXN0ZWQuCgo+IFtTZXZlcml0eTog
TWVkaXVtXSBXaGVuIHByZ19jb21taXQoKSBmYWlscywgdGhlIGRyaXZlciBtYXJrcwo+IHBoYXNl
X3N0YWxlID0gdHJ1ZSBidXQgb21pdHMgc2V0dGluZyBmbHVzaF9wZW5kaW5nID0gdHJ1ZSAodW5s
aWtlIHRoZQo+IGVxdWl2YWxlbnQgZXJyb3IgcGF0aCBpbiBzaXQ5NTMxeF9vdXRwdXRfcGhhc2Vf
YWRqdXN0X3NldCgpKS4gQ291bGQKPiB0aGlzIGxlYXZlIHRoZSBvdXRwdXQgZGl2aWRlciBwZXJt
YW5lbnRseSB1bmFsaWduZWQ/IElmIHRoZSBkcml2ZXIKPiBzdGF0ZSB0cmFja2luZyBsb3NlcyB0
aGUgcGVuZGluZyBmbHVzaCByZXF1aXJlbWVudCwgYSBzdWJzZXF1ZW50Cj4gbWFudWFsIHBoYXNl
IHNldCByZXF1ZXN0IGNvdWxkIGJlIGZhbHNlbHkgdHJlYXRlZCBhcyBhIG5vLW9wIGFuZAo+IGRy
b3BwZWQsIHByZXZlbnRpbmcgcmVjb3Zlcnkgd2l0aG91dCBzZXR0aW5nIGEgZHVtbXkgcGhhc2Ug
Zmlyc3QuCgo+IFtTZXZlcml0eTogTWVkaXVtXSBTaW1pbGFybHkgdG8gdGhlIGNvbW1pdCBmYWls
dXJlIGFib3ZlLCBpZgo+IHNpdDk1MzF4X291dHB1dF9waGFzZV9mbHVzaCgpIGZhaWxzLCB0aGUg
Y2FjaGUgaXMgbWFya2VkIHN0YWxlIGJ1dAo+IHRoZSBwZW5kaW5nIGZsdXNoIHJlcXVpcmVtZW50
IGlzIG5vdCByZWNvcmRlZC4gIFdpbGwgYSBzdWJzZXF1ZW50Cj4gcmV0cnkgd2l0aCB0aGUgc2Ft
ZSB0YXJnZXQgcGhhc2UgaW5jb3JyZWN0bHkgaGl0IHRoZSBjYWNoZSBwYXRoIGluCj4gc2l0OTUz
MXhfb3V0cHV0X3BoYXNlX2FkanVzdF9zZXQoKSBhbmQgc2tpcCB0aGUgcmVxdWlyZWQgZmx1c2g/
CgpBZ3JlZWQgb24gYm90aCwgYW5kIHYxNCBzZXRzIGZsdXNoX3BlbmRpbmcgb24gYm90aCBwYXRo
cywgYXMgdGhlIHBoYXNlCnNldHRlciBhbHJlYWR5IGRpZC4KCk9uIHRoZSBmYWlsZWQgZmx1c2gs
IHYxNCBhbHNvIHN0b3JlcyB0aGUgZGVsYXkgdGhhdCB3YXMgY29tbWl0dGVkCmluc3RlYWQgb2Yg
bWFya2luZyB0aGUgY2FjaGUgc3RhbGUuICBBIHN0YWxlIG1hcmsgd291bGQgaGF2ZSB0aGUKZ2V0
dGVyIHB1Ymxpc2ggdGhlIG5ldyBkZWxheSBhbnl3YXksIGFmdGVyIHdoaWNoIHRoZSBjb3JlIHdv
dWxkIHRyZWF0CmFuIGlkZW50aWNhbCByZXRyeSBhcyBhIHJlcXVlc3QgZm9yIHRoZSB2YWx1ZSB0
aGUgZHJpdmVyIGhhZCBqdXN0CnJlcG9ydGVkLCBhbmQgdGhlIHJlYWxpZ25tZW50IHdvdWxkIG5l
dmVyIHJ1bi4K
