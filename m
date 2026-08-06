Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512A383C92;
	Thu,  6 Aug 2026 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786058695; cv=fail; b=sNhNiEJT/UObR1JEtccrDmOwHoK7+C2rz9PEc93L69CsRgAz/UtlfnZTgw8mnNE4v4jB1KMBGqE57tfXdjbCAAiz/xXookT/HRFn8R9mpMLNYnCqqzhE+t6WJBlrGr1EF5kHrNBCKdmO26Ua9Qb3Mldll5Y5yrieFb6rjFQQOaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786058695; c=relaxed/simple;
	bh=PidFk/FA7nrcljWcHsx+OEvwboSvGG/ZFxlkMe+Wkoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P+jcHB9/MeeYKAss2CHLxrVO1YPuol7s+ZeSyRP82juyjrRt85pudx2UL0WQL1JXA06W2nYxZDlvbwCaw1T/343F8CVAHf2IEl9RF4fq+UqvkPHMnAUEQ+UZCLo8wYM8ldZQj1oujLG4uR+4bZczaB0yLMXhU2DVxKv4flBDV8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=IijHkhle; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=yY5ujmAg; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="IijHkhle";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="yY5ujmAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=fCEenb7kbIBrEI/vZSvIYXaOSsdyPabxw6KSomy1/Hc=;
 b=IijHkhleyDELq0TFb0i/HnEqcYMY5tE8v/3QuV48fWi/vBBwB1z9N3QdYhvcFm/DANdbsN+mJLMweXs9Eygg52QmDq3xjRHliHPkp39Z8TUtW7tkId8Aj4X3EdTeIp1yqVs3RLewOXaT1veAmeuqeipEGHCEimcElwjN2gPYIt+BtpAxFSifo0RLwlgBtb/uTItZ5eqzV8mOvcrbmscIO5VCdBzekeadQkqXYWi0octcU0C4XZ8p8GfJ9njGr8UnoD4zRYCitks+i5wgNFG+xLbUmqbvg4MxVKFqF+IZvMRJHS72qTPZCRr1dAEMiLsCsNVhNnnrKrreKDKoR7SvsA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022118.outbound.protection.outlook.com [52.101.48.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9B05A8006A;
	Thu,  6 Aug 2026 23:24:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bd/IRmhfhfIoswrnCuYCItkK0qXblrIB+IPAB8U78PVlODm6lICQOOYKrNwGfFc1QpMNCDLrLMUPUlOrae/dBVpUGMXv46GxCZHV5drAww/rO77nojks18pt87baAZaeIHdJtHAIE6D1PVVNfNzoPrEkho/uQ79el9AU/48XJWn7EsSfbRWIBDZBxBapX7WEgfYonujeomRVZz6Zp8OWLq3B4AizVYQa1BimKNlbvE3cZYWL9s0MYKFrBRq+oHzPnubHoRbgkf9HPkFu0no0k1dc4tUVGi78gjDFx8iz2jEp0AvRLndheh6Yc6ICPjyipqlmw/xghh7cuTcjLmb0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCEenb7kbIBrEI/vZSvIYXaOSsdyPabxw6KSomy1/Hc=;
 b=kl5BWjlZx+IchCqkqvjqtU6R1Lv5znh5wYFFEpTkDEQGcd6f/fDDpvqmYoj76oO35snkcb1enfRprVgfCvmeLlNA2DM/Aco/qPb+1vBXQbYDu874rX/OUyyAJnML0/4W0617gO3Vg4/g6SZ5W8XF2Sql+lOBU5dz69b5Xdm7mvylnWgRMKPfBKsFT1gPru12njKgLCix/n7o9bQ13oq8XIBlLKtMOCxyiVYtzGDIScOkdKRNZUhATEuugLqFbWyQfTCbk6ieEC3YBNtjO1GcjCOVRmZ0h+LnG1K2E4IXC8c5CR5CLJ9zI5wfwpbCiSflvYhviTaYapIvWKrmoGBY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCEenb7kbIBrEI/vZSvIYXaOSsdyPabxw6KSomy1/Hc=;
 b=yY5ujmAgmjaFRf55eX6LAVpnC3VL/49L5E1Y3UzxSrIhgmjPOfyFpxycQ+5z+rs5yUPGW6GDS8msJEJp52liBgzsFYgW9wX1j0cA3Q7Nhoupti+qnmJF/+Di5sd8Ah+ZPMZs5WKNkq7okPos8yQMl9T5AmwDu2Zj4gsVn9/P7yvydJ3bIytRmisqBJ3GORt2C25NEEqt1I/7t1QSktXKkFGx4tSjt62b8EKQ6yhfNA4TodR4WkyvBp51CPfnFus+GW6c8KOODs3nwlNc9G5E9yOwVztaabWn5L1UJBfPzjIDA/LfINWb8sm5Iff0M23h6IjFLVkX38s9Z80AG52x+A==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CY5PR20MB5045.namprd20.prod.outlook.com
 (2603:10b6:930:33::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:24:43 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0292.015; Thu, 6 Aug 2026
 23:24:43 +0000
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
Subject: [PATCH net-next v4 2/3] dt-bindings: dpll: add SiTime SiT9531x clock
 generator
Thread-Topic: [PATCH net-next v4 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
Thread-Index: AQHdJfrCMPB2BCmRZEKfTsomLaJwOA==
Date: Thu, 6 Aug 2026 23:24:42 +0000
Message-ID: <20260806232439.27551-3-arouhi@sitime.com>
References: <20260806232439.27551-1-arouhi@sitime.com>
In-Reply-To: <20260806232439.27551-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CY5PR20MB5045:EE_
x-ms-office365-filtering-correlation-id: 45c73467-cc4e-4e93-2932-08def411e537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|3023799007|6133799003|10067099003|18002099003|22082099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 kckH5z/9f5M4k6yD5HczwFLRVnenWo7/hpDq7yt1mmPvwZYPuEoxvNBfxm9WgswxBFuQsEHG1svgalFTQND7m+QQ9v998ZlfvutG9fuIVoHcORrXkNnijVKrt2hJ1ywY7v4+VnOg8gDjJTjaCb18hGqgnhQ9UvIhicvKJnVOqxBUB+/L+PTLwcaV2NYGlrX/iSZKo6IdXe0QdNz+yU3vNfv4P37W5NMYHt6J4KMZe40HNfIVFyNyh7gvpY/jo3SJ6Z/mMiy8rkWAzJXMlYcmG1hUd4hi1F5VeWeC/OYOfyn9lgJe4MQUj2fy6J6B6kP6fBvOFsSTm3AH3pEu3rtxlD8NiT8gVCdko4bqJlA1ZNkhtZejbenIJHalzEXI+FUq85coCNbOOtbu/9Eql0PnY+ueyRBReu+HmNF1Z+w/Y8EFTTUMa9lTP2EL9A4vz4bdrgAuAikYlkQ8Tex5zd6Vg+s0UCrbs4EkqLDIVFA8tB0ZfEU5fhxI9HuINOJ9uAQ1QbNF4kZ600T0x0/Od69f40cCRns6tx6CPqB2Y+1Qj2CaU8U5UOMNwMzLL3jXpPGPDH7wJeHER/KdZ1lLR+34nqncMyJpHo71VhoOgYx8DhsFX/VbHLdpa9k2HvhBF6TKZn7OF/kM85OUqT8/w8Ayc4gN0qjPXir5goV7IH1rZ5X7ZhPx8c6XKn0mIcdXja+r+ywr8hxPAMNm0bjgVwBniVdfzq5GRBrqotbNy44cTOo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p/xCE3ki88M2Bm3V15oypttFgZ/3UQo39/mkRAbhXVVc7mo/vCBsGq1Y+x?=
 =?iso-8859-1?Q?OjDSqRj2Fsnp3fTaTWnzU65NoqiaA5el+0BaSU61kpM8zGARAoehh7lfln?=
 =?iso-8859-1?Q?3kYNcLIaPi0HfUctp5EZdgkURhqdISvkg53GwTESNhIsUJokDSmsdLUiDm?=
 =?iso-8859-1?Q?OqcSh3x/4b1ywdXcI8onZVMcM/xfHSkY/kl2BY1IePFc6ffQCPzg2EBBZs?=
 =?iso-8859-1?Q?eIvzyPMEOpbl0N958LTZSqPQq/iXRhZiJhlHfhmJZoAIYGwxpSgFPmHDFa?=
 =?iso-8859-1?Q?19bsQ8vptE5BjwB4EFp3Y95hI92dMv0n8+rvndwc+T077IdXZ2S04Xoff3?=
 =?iso-8859-1?Q?zGoCoE/61mchKc8IIP/yO2u3wE2k9+gtthy4TXW/Q6IBvtsohAQ/JzIQSY?=
 =?iso-8859-1?Q?S4leZqhEoR/0OV3KJ2+6GXCTrwER9p7f1dSjrRlW8SqTH8bP1tMWJMsJg3?=
 =?iso-8859-1?Q?QIsX5aI4whYNGSkDqBjY8ROehsoMQTuGULQImzDD3eSZg1UFwpQwDjm1qy?=
 =?iso-8859-1?Q?5fnZ3m1cdMY8I/iXUR5GUe9602wSfDPRu2KC8BNOif++2WeFXAuN1eikIj?=
 =?iso-8859-1?Q?luXGCOT6c1OWeUGG19A/s0q6v0oH7RzweUe0Hh/Pngy5w8jqX4ck/opqvU?=
 =?iso-8859-1?Q?Et20F715LDTiH900J0aPSSAb4hfvq/NTFeWANjwfqFQY2X3Mzo6SzZJWCU?=
 =?iso-8859-1?Q?VyyRC9jy8K17rUkLJCW/Ung0qFtQ03LgHmbjo1oWBR6yWuzD7sMMr6sYxt?=
 =?iso-8859-1?Q?YhZgfK135V6Sn23PC5KIcxxZsZQL73KJ1gLWpwPvb3rvc+JQFR1LBgE2lv?=
 =?iso-8859-1?Q?XsCg/0jVKHiUUyjW7l34YXSkdakujH6SZlNuMEKbHiqg1bQHxgOXJGfUSb?=
 =?iso-8859-1?Q?eHxwZc+XSJSZM7ewYmfn595NkySCZ17QBvyfA8SPk4ez/YrHEkFfRaivk5?=
 =?iso-8859-1?Q?zTpNqFb5LHCWK/oYTAl0CGtpMaAfEqJThcnw+oggT8MzZspCEuvPlK9GXb?=
 =?iso-8859-1?Q?t4Am/sQJE3RcFI2sqMVoKGpn0MTuZYm3BtKuRtCRIosoQPw8llfgIT1oN4?=
 =?iso-8859-1?Q?uEWUJ0mUuTC8xzsjhYzIms0ZmLidiCFJ2TUyvvf3pIiS6QKgmQCPi0DyjT?=
 =?iso-8859-1?Q?B8b9/yeL+dxxtja9FY0OZreO77gF+0o5bP99fHGRXE7g2Toxi2kdTCfumD?=
 =?iso-8859-1?Q?uxCgIf4sMwel9bYd4HlH9HUTa7I7SHV8Ygak6n8VUaucMn3mcwJR7Okved?=
 =?iso-8859-1?Q?sbH92Tyt5Pr9v6LyzbwZiJYw8SDD8+usAA7iVjz1EWDGRkjveDGgtGxfqs?=
 =?iso-8859-1?Q?xSU8C0rUDyST/fB6J8TeG5YyHIi5Cn8eoGQ3ueyOZo0BXECGIEJadnf31J?=
 =?iso-8859-1?Q?sCVw5PJPyRVGDNlynPJs9orH9GILL9HbFfGX8pttftRd6D2h44Pea6fELt?=
 =?iso-8859-1?Q?rHQ2zaaqbOnTzP67e9n7Gsjht5w+eKQZYus5NqBBK7QkvLgjYpzX2XpTNa?=
 =?iso-8859-1?Q?LaDHzxI0Rmk/3KBNPjoqbpROkA30OowvqidkB4auOAA7xQgJCZoTNyuiD3?=
 =?iso-8859-1?Q?Rp3bYDkiptJXYarEcCQLlCpeOVrk8kDO7Jh9AkmpnfZnag5Ei5zCjGTVA7?=
 =?iso-8859-1?Q?3HIxnlNOX9vQIbrPioP5SEhZXKnPPEUtiGrBN7jv6TUHbUB1N5fk3FuqAn?=
 =?iso-8859-1?Q?tiknZORI5LUDRoWNV3X4ZYimMHwKOUHofbcFZHXA2H34fgrmyh2j2nuF29?=
 =?iso-8859-1?Q?DfgWGAff9h4JVGyVlEHiF9HPOmmoll9H5uffcI7OsyXzS/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TylYgCGmSc0BykU7I7Zg/0qHLNtcI2yAfYj8GRT/b6Xpq8LF1JpBwcXqgc2hc/Y7NZ8rQdJXpP+mIs8E6zvZWXqLo4Ke7hdaY5+RsHLj8UegM+hyD7EIZyYdGE5N70DBpkPnm4tQHj4opoNd2ErYt6Aw0M6l7ex7sold4MRzYlv3I9r7EtCcpl/5QDqTw9qjP2tJlYYjQMqDVBHAowUL/p4o6yCimJNAQKA6nEpE3/Cl8l/2asJXtmVkhEL8331+dUli/ofGk3FQIbor13XTtMPLc/4tyGI+0B/wR5akPjCVKT6EDCu/0LeEC75piOKel+XVGXD17H6HlyQaa34AwA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c73467-cc4e-4e93-2932-08def411e537
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 23:24:42.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgtoG8mmnzmCVQWEm6n2EfZWcr5oostUBtd/Jkdmj4w/zDDxS2kys4+yj20LGupz7X4HoH93MXxJst6bVudeWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB5045
X-MDID: 1786058686-2_9uAVM4052w
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1786058686;2_9uAVM4052w;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add device tree binding documentation for the SiTime SiT95316=0A=
and SiT95317 DPLL clock generators.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 .../bindings/dpll/sitime,sit9531x.yaml        | 203 ++++++++++++++++++=0A=
 1 file changed, 203 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml=0A=
new file mode 100644=0A=
index 000000000000..56a4f5135fb9=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml=0A=
@@ -0,0 +1,203 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: SiTime SiT9531x DPLL Clock Generator=0A=
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
+  SiT95317 provides 4 inputs and 8 outputs; SiT95316 provides=0A=
+  4 inputs and 12 outputs.=0A=
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
+  clock-frequency:=0A=
+    description:=0A=
+      XO/xtal input frequency in Hz.  Fallback for firmware that does not=
=0A=
+      expose the oscillator through the clock framework; prefer the=0A=
+      "clocks" phandle when the clock is available.=0A=
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
+      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  The values=
=0A=
+      exceed 32 bits, so this uses a uint64-array and does not carry the=
=0A=
+      "-hz" unit suffix (which implies a 32-bit cell).  Override=0A=
+      for configurations where the standard Fvco =3D Fref * DIVN derivatio=
n=0A=
+      does not match the running VCO -- for example a PLL operating in=0A=
+      INTSYNC mode, or a chip variant whose VCO falls outside the=0A=
+      documented PLL_FVCO band.  A value of 0 keeps the register-derived=
=0A=
+      computation for that PLL.=0A=
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
+=0A=
+oneOf:=0A=
+  - required:=0A=
+      - clocks=0A=
+      - clock-names=0A=
+  - required:=0A=
+      - clock-frequency=0A=
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
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@68 {=0A=
+            compatible =3D "sitime,sit95317";=0A=
+            reg =3D <0x68>;=0A=
+            clocks =3D <&xo>;=0A=
+            clock-names =3D "xtal";=0A=
+        };=0A=
+    };=0A=
+=0A=
+  - |=0A=
+    /* XO rate from a property when the clock framework cannot provide it =
*/=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@6d {=0A=
+            compatible =3D "sitime,sit95316";=0A=
+            reg =3D <0x6d>;=0A=
+            clock-frequency =3D <96000000>;=0A=
+        };=0A=
+    };=0A=
+=0A=
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
