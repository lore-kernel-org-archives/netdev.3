Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF7403123;
	Mon, 21 Sep 2026 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021487; cv=fail; b=H2PaWEjQwa8nxuLMz08H1M7uD16FyJAkgqggeONLEXqDWFc2aQfVI705+edFodTOPGqXOyX2PkEg84FHO7QqGUD1Q77DS6Kv2UmH/+Py88YF5vREmNP6SofBuK/ePzFfWA7by+1d4UXwMDEbbcsfUAsnoBAIAWTZSVo4ms3LbsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021487; c=relaxed/simple;
	bh=1Vu61sDA3h9rVDQBEIACqIkgc+ZJgu8xGizctvyz0Es=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXDwYimIwsVvKTstoCe8OFr5q0i1LyuCAhjwhgJHY9qmG6tRaO0sgNt82fvtqpbe2Y86jFilB0hlL0QMoUbpDXJFJ1db5DIqdqcQMTfGJgcBl+VZJmgN52uEYgNcMcy33wvVKwXhmouksxVz/9cc+5g8hakX8fr0nWobAcW9W5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=PtjLUJnc; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=kfZQMohk; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="PtjLUJnc";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="kfZQMohk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=5slyZH7m03GTdnXp1i5c/Ow5Ufe4eenqsgbJCsRykIw=;
 b=PtjLUJncbrjfUZbOD+vU3a5cnIxopWw9KMmosdLd8BKbF4Vb/cvorBRN+4JwJTz7OiM0FiuhTxwzV6V00r6qQqNucuUENu0g2pSptho3WvTVUGrgeUD5mTj+RWs8tDVAJQQO334rMiJEjFyXjlIFi3bVl1SaG8lsh1BHOiz33To8XZDtIjm604qUkssZ75LSIcK73InrFO4RFyZFtxfr5RCxhGezhLMisNBnFQpnLKTieker29LPiTqqcYmJhQ4o1m8C5JmWQAxl+/56J3x74/6w2h6clf7dxptQKGvdQGm80+axTz1q7eSJFWQabJ+d+tfH/jHSuWNUtDmgdJIuOw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020109.outbound.protection.outlook.com [52.101.193.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 641DD300077;
	Mon, 21 Sep 2026 20:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0xneayDe0y1yKdRdKDTCpiazGQDWv1U23L8O3zSw/FsOl9gQu7XxxX3/489mniTQ5kUhE4IZQzUhyiX5h2pfHSfsbefTkyspvoerCxagAiXtH1FtZa7S2Ok2kjLGJKnF5JbdVOcV626HrLCN2PLVqHclWc4nUqlKzm+GAqGQieYkaaJ5ESXlEJNRKJvTEL5GOYo85ibZgFChrnWoyKvkSytixp/crcnDHxKKkZ9+BwFZNhbSgPCnyFE+A7f14JtDdfXLZBZUE1du6ew7yGIJovIv+b90esA9tk4rkRTVa1VZGrpSYwdwVu4Ha62QLgZMdkTrMGom7+i2CkpknlZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5slyZH7m03GTdnXp1i5c/Ow5Ufe4eenqsgbJCsRykIw=;
 b=LT6gFTcFVIVwjMxDi7H4myFTb0fVX8btPGykRlEPTaALe2ZTAKhM5Un7L4l0546F36Y4UtT/KtWKRLoR+BLQh4+tHQL+Cj45s5AJGjbCHrmqjb8aqTNq+c5ux19QjGE0hEvGscwIm6qr1ZOLnoNs0gKYdLxD7Q4EBgpF8OHFQN0dVvqd39hNZ1IWEr97D2Q5uNQpKxGTkIvbMUJ2AhuSE4Bokaa8X/F0FUEcTpWjBwIieZBMTyWadRP58hejjm+DDzN57TD4phu+PMFeL4wryt+K7UlbCPWn2rEuTf5OOvne4NdfR5mvUA2r4ZvZvU7xy855ZV3/mBuUX/DrpCBS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5slyZH7m03GTdnXp1i5c/Ow5Ufe4eenqsgbJCsRykIw=;
 b=kfZQMohkIkOkv7SJ25alBufH7KGZVhbwxbFSGGQOWwm+83jvwwp6xbZvqyvZ/Hjjy9GfvqRs6spsfBn0/Qs5whCtUdXLllFJaut75K+4Hh/zPLUNcvg3df4ddhaLak1Blz7tjMVvw+RiO8Np70vE8JRQVyvh/dUnSjLMjy4R/eF7BI2cfuylWtOsVVgplG0ZO5S9RjAHn9mquazScxSA/Rm/3kYBRwo3KRJuRKlFORZYR+v99uESoMT7H2Vlb58bdj6SWeybREmoffzi1fkn//mop0dSk5D1uVdsXWOcRVcx64AJ3G0aGqZ4KvzzG08D59p88CYla1jsJ8zlesAC2w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:19 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH v10 14/14] dpll: sit9531x: allow the device tree to override
 two board facts
Thread-Topic: [PATCH v10 14/14] dpll: sit9531x: allow the device tree to
 override two board facts
Thread-Index: AQHdSgVd/rH+yP+wU02iJ1gELfpGLw==
Date: Mon, 21 Sep 2026 20:11:19 +0000
Message-ID: <20260921201108.42676-15-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: c0e1b6f0-b47f-487f-024d-08df181c802e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 6bsN1BQqdnF1yW2bjWf8N2A7snZ3OsFiFbLu8SedIvpJm/NVetSCNN5QcZq/1k9RuMG+L7uU1n00t1qNqg9HXqZlF9LmrOVjwKy8+bzAbBEfUMEMZxpr+QL4CNLm6s6PA7e6RAK8RbUU0oE/ZhVgY+PLwY2ntJN7auYXOrwHIH+XBWhLDbUaka2u8eQCAud/kdoDbWqfjVzbIG5nAcmM15js5dQdHXS/NppQf46WpT7Bh1F6mueMyuqERVJs1fsXSzGg8+BVfHVa/TbMgQZAYoe7/+oBoqYUa3dHzsqAEd9gzHeSB/ofHBfbsZ6b30gDIfC5Et4Z4g7xsd7lRvgHEZI/RbnQWMBVKfroSY5mHO7mw8AxQ55zZwPVXl6kFf1RS/6CsogI8EjAxcN8GtgyDNDAdQZZxKr7sOZr23JaEWzxdyJg4g3hCMOCPAQTqomqFq9t/yufm0kNY9YzWW5mWlrzM58Oi7b9cWGKH478BS0Z/OGVavPmE4TGYuqYGXTSJlKHN5KAxjvwNaxYvPgfBr7buobJ3F0SxTrtZOTNDOB0Cpw7KLXe0soY4yFrsRrvYI2gd4f2+6sRYXjPmamu9KhgSjLaVjioJ47WzymQkCLgCJuivNljip34mAFc/gA9g/whXc716LeNHUiyYkQINTcT/1royHSDFVWtAQ07q/Z7HfUpJMG410tzmczwUW925uJs60PzpAoUjfTp+A0xDlmRNG7ZRXUjw3vVx09Xz+Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Mhmu4G6oe1ylp7O23rXNkpWocOX57QuiLXmqd4F0P5T1ieY2pWOK1CdIkU?=
 =?iso-8859-1?Q?a+wNlErHems3xgdOcgE1X/iI+y8qWioivRLx89UCTmqbwfp2LQZT5rN4OT?=
 =?iso-8859-1?Q?ByrwtQAiHz/OEz4AtC8RAU0AGtps4WAsiqrBm5Yp5yx+aUzemrBJnmiC3j?=
 =?iso-8859-1?Q?8YHIGp6bW/SqB1bxWlY34Ch9dqudq40vcH370z8y+/W46j0sHixRzurY7x?=
 =?iso-8859-1?Q?o4+ukSFdb2i/3dcyRnj4t5aGkR0/ipjU09F1IyxMtjjPqMnUC7LjG/ESID?=
 =?iso-8859-1?Q?ctYctMRAN3ZwCZNfoimSKJFlK9Al/cQz5yPrIqBj+/FCGIjQ5cUNHsiqjN?=
 =?iso-8859-1?Q?gie828rGYpc+PmfdqP6BjdzGE+zgkZdI4ru1WNiLfzhqoKJM7KxzXTnJSY?=
 =?iso-8859-1?Q?I6tCyqH0KD3mT0DOmp9N9cNqstjII1twgAptoHxCpV+cYnHjXbHYRq3EsL?=
 =?iso-8859-1?Q?TfEOXeoH+RaBANopFTIVptOCe3xaZYTuTL+TM3/60cjVDNMRpZblfrq9BR?=
 =?iso-8859-1?Q?9V5qIh3F2tdeobIto9Uo95PgXBlglMZmgPEaf45dNkGEveV+HbCx4NuAZa?=
 =?iso-8859-1?Q?1kkE18KbydZBN4TTla/GOzeWMXrhD3DWo0HqzmUK6JHXMHN/SSaWtrrAOP?=
 =?iso-8859-1?Q?h4rR6yYmFWX7ZO1mCRj7Gr3xYx63Mb8btMMLjXl2/YOJOBqmdtfyiw2EkG?=
 =?iso-8859-1?Q?117boOkSvZ3n9rdcj6bfwlQJHCPyJkbjWJWoZj6i3RHj3vlNvAJmz9jOZf?=
 =?iso-8859-1?Q?4nQRsRrdo3s+cYcm9ihVCQxqJecO4RFvz+eVCQl1ULiaD/y9zr/GocvJqM?=
 =?iso-8859-1?Q?JmEOk5YOp+3cGHRI/XrGOmQu4EPtRbbPSrJ91zC9XWvpUDHRI5WWP86Zlp?=
 =?iso-8859-1?Q?f/fuHIM4V1VRDIwwf+pgHCQTcuIlkYomgSyfBFYU76CBvWwIGhrKBc8Xgm?=
 =?iso-8859-1?Q?AaG7xDfVyuaDURH1Lb4g8mbU/HHgT7f1xgzem2g718BDSFE84jl+i86UqH?=
 =?iso-8859-1?Q?T5bPKo/8ZP9qi879lVLWwcHTjvuAGkLQgOgL/G/A/+r5A5HfOcxA58CFwG?=
 =?iso-8859-1?Q?xw505F+1ZN1cHEDsiwqs9oIvJEvq9dTVg74FWhW0/TfQ7hXxcpdswY3UZN?=
 =?iso-8859-1?Q?k8hh6L8z+OPY12TYcWWM/MfXknvGDMlHTd8pHM1vAWuwHFfRsOGwlztnHQ?=
 =?iso-8859-1?Q?l3FvkDDo5bK83unePzi8eMo4GadytSK6wsaz6m+ZaauTbynR9bdIWQ49Is?=
 =?iso-8859-1?Q?H/+5YFqxMElPXOVuL0+1HZmT0ATG8r/7H2YRGKbZX9fiD+l17QRSUD0vLd?=
 =?iso-8859-1?Q?jJ7LFLuOXCde31qAQQJPbEOA/6k3iC/lW7z8xfkfY6V+yCV8CWfPTSPbJy?=
 =?iso-8859-1?Q?Kbf/xb/5CXGiGoliVr7YJsGgJNH522ULSc/4rKkzC8SSfXYiV1lntygvPm?=
 =?iso-8859-1?Q?9E/lDx86hOnx8RXFGRSg0/C//RIYbRzXhx0xTqPrVu3/Yukm10YkS5tWd8?=
 =?iso-8859-1?Q?uQwpMtT6wW8/Ubctkd3X90+eaoXw8Xr5JxU//PgWk8MsaM0tMFvG1CZr4M?=
 =?iso-8859-1?Q?4vd9mST3l4ttnopHqIPJ9O9atc2r/dIBLb2wluWao1/YsUYftPt0o7c+i3?=
 =?iso-8859-1?Q?66DxgeDpffoJq8PANksztIh0a/3XFCqEYXRuWpLlpej2z7U/wpmUfY2jJ1?=
 =?iso-8859-1?Q?0tsLnNzFjMGzl2mHHG/LVK8xybheoYuvn1rr2nKJK0oFObZF+gTesM2o9A?=
 =?iso-8859-1?Q?ifdlRXUgejyv1OocUB+VaiGOIdX+O7UYiLePZjsIn/G+sv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	AbEwOX5GIynlgJLVDLpy8Oi0T41OVczUWMUi7TakPND84ow9O3azCzIjkUiosGroqRSJ0olq81rCnZyGyRNqzpaLSIiTBWBr+hRlSc4daK3eV8Cvq/z77H6vXh8kJWduTXqEhWcY7chr0AgmgmpktrMmFPrIE4kiDWSkUIcZwsjVX2LSrJd82uiI43lotqid5zBawr702zAOcmOXpNzgvkVJSKurMPqz93tUl6ki93jA4RlhBHFqdo41up4JB0aWN7vSJlmj6xZsZ8fVWhJ+6JPRcjzlw06qkrQ4rQMiFFRbDmp3numyXNlhZSFfOg4wNo8sAOgT+A9oXfHWEUKwLA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1b6f0-b47f-487f-024d-08df181c802e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:19.0912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWVXtgOuKfT1SJdTIiZ2ORc/Tdy3hFnagvvxJFsHnPJN6SclKViJ+FbRbNSFD7kRTcUdVjrC3HZieRkzq3uxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021483-8vYn5hvkJFfh
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021483;8vYn5hvkJFfh;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Two things the driver reads from the chip can be wrong on a board, and=0A=
neither has anywhere else to come from.=0A=
=0A=
The VCO frequency is derived from the feedback divider, which is exact=0A=
while the loop runs but not while a PLL sits in free-run with a divider=0A=
the configuration never programmed; a board that knows its own VCO can=0A=
state it.  The output-to-PLL routing is read from the output map=0A=
registers, which describe what the loaded configuration did -- and a board=
=0A=
whose outputs are fanned out differently from what those registers imply=0A=
can state that too.=0A=
=0A=
Both are optional.  Absent the properties the driver behaves exactly as=0A=
before, deriving one and reading the other.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Checked the device-tree array lengths against the part: the VCO=0A=
    override needs an entry per PLL, and an output map shorter than the=0A=
    variant's output count is ignored rather than read as unmapped=0A=
    outputs.=0A=
    =0A=
    Updated the accessor's kernel-doc, which no longer described the=0A=
    override path.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 171 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   1 +=0A=
 2 files changed, 167 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index e8d47999f1a9..5316e6bcb338 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -1695,12 +1695,15 @@ int sit9531x_pll_ffo_ppt(struct sit9531x_dev *sitde=
v, u8 pll_idx, s64 *ffo)=0A=
 }=0A=
 =0A=
 /*=0A=
- * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers=0A=
+ * sit9531x_get_fvco - the VCO frequency the driver works from=0A=
  *=0A=
- * Fvco =3D Fref * DIVN, where DIVN comes from sit9531x_divn_static() and=
=0A=
- * Fref =3D xtal_freq << doubler.  DIVN is the steady-state Fvco/Fref=0A=
- * target programmed by the NVM blob and is authoritative in both=0A=
- * free-run and sync modes.=0A=
+ * A board that describes the VCO through "sitime,pll-fvco" is taken at=0A=
+ * its word and nothing is read.  Otherwise Fvco =3D Fref * DIVN, where=0A=
+ * DIVN comes from sit9531x_divn_static() and Fref =3D xtal_freq <<=0A=
+ * doubler.  DIVN is the steady-state Fvco/Fref target programmed by the=
=0A=
+ * NVM blob and is authoritative in both free-run and sync modes; the=0A=
+ * result is clamped to the band the PLL runs in, so every caller divides=
=0A=
+ * the same number.=0A=
  *=0A=
  * Return: 0 with *fvco set on success, -ENODATA when DIVN is not=0A=
  * programmed (dormant PLL), or the register access error.  A bus=0A=
@@ -3238,6 +3241,27 @@ static int sit9531x_out_state_fetch(struct sit9531x_=
dev *sitdev, u8 index)=0A=
 =0A=
 	sitdev->out[index].state_stale =3D false;=0A=
 =0A=
+	/*=0A=
+	 * DT board-config override: the per-PLL OUTPUT_ENABLE bitmaps=0A=
+	 * (0x27/0x28) do not unambiguously express output->PLL routing on=0A=
+	 * every config (overlaps, and some outputs routed outside that=0A=
+	 * path).  When the board supplies an explicit map, trust it.=0A=
+	 */=0A=
+	if (sitdev->out_pll_map_valid) {=0A=
+		u8 m =3D sitdev->out_pll_map[index];=0A=
+=0A=
+		if (m < SIT9531X_NUM_PLLS) {=0A=
+			out->pll_idx =3D m;=0A=
+			out->routed =3D true;=0A=
+			out->enabled =3D !muted;=0A=
+		} else {=0A=
+			out->pll_idx =3D 0;=0A=
+			out->routed =3D false;=0A=
+			out->enabled =3D false;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * The OUT_MAP_LO/HI bitmaps are indexed by the physical slot the=0A=
 	 * output occupies on the chip, not by the driver's logical output=0A=
@@ -4223,6 +4247,126 @@ static u64 sit9531x_derive_clock_id(struct sit9531x=
_dev *sitdev)=0A=
 	return clkid;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Does an Fvco fall in the band the given PLL runs in?=0A=
+ *=0A=
+ * The two bands are disjoint, and which one applies is fixed per PLL, so =
a=0A=
+ * single envelope from the bottom of the low band to the top of the high=
=0A=
+ * one would accept both the ~1 GHz gap between them and a rate belonging =
to=0A=
+ * the other PLL's band.=0A=
+ */=0A=
+static bool sit9531x_fvco_in_band(u8 pll_idx, u64 fvco)=0A=
+{=0A=
+	if (pll_idx =3D=3D 1 || pll_idx =3D=3D 3)=0A=
+		return fvco >=3D SIT9531X_FVCO_HIGHBAND_MIN &&=0A=
+		       fvco <=3D SIT9531X_FVCO_HIGHBAND_MAX;=0A=
+=0A=
+	return fvco >=3D SIT9531X_FVCO_LOWBAND_MIN &&=0A=
+	       fvco <=3D SIT9531X_FVCO_LOWBAND_MAX;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Board-config overrides for fixed efuse/blob routing the chip registers =
do=0A=
+ * not describe unambiguously.  Absent properties leave pll_fvco[] zeroed=
=0A=
+ * (derive from DIVN) and out_pll_map_valid false (use the OUT_MAP registe=
rs).=0A=
+ */=0A=
+static void sit9531x_parse_board_config(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u32 map[SIT9531X_MAX_OUTPUTS];=0A=
+	int n, i, rc;=0A=
+=0A=
+	if (device_property_present(sitdev->dev, "sitime,pll-fvco")) {=0A=
+		/*=0A=
+		 * A fixed-count read rejects a short array but accepts a=0A=
+		 * long one and drops the surplus, so the count is checked=0A=
+		 * here: the property describes four PLLs and an array of=0A=
+		 * any other length describes something else.=0A=
+		 */=0A=
+		rc =3D device_property_count_u64(sitdev->dev,=0A=
+					       "sitime,pll-fvco");=0A=
+		if (rc !=3D SIT9531X_NUM_PLLS) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "sitime,pll-fvco needs %d entries, ignoring\n",=0A=
+				 SIT9531X_NUM_PLLS);=0A=
+			memset(sitdev->pll_fvco, 0, sizeof(sitdev->pll_fvco));=0A=
+			goto out_map;=0A=
+		}=0A=
+=0A=
+		rc =3D device_property_read_u64_array(sitdev->dev,=0A=
+						    "sitime,pll-fvco",=0A=
+						    sitdev->pll_fvco,=0A=
+						    SIT9531X_NUM_PLLS);=0A=
+		if (rc) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "invalid sitime,pll-fvco (%d), ignoring\n",=0A=
+				 rc);=0A=
+			memset(sitdev->pll_fvco, 0, sizeof(sitdev->pll_fvco));=0A=
+		}=0A=
+=0A=
+		/*=0A=
+		 * The override is used verbatim by the divider math, so an=0A=
+		 * implausible value (units typo, wrong cell count worked=0A=
+		 * around with zeros) must not silently misprogram DIVO.=0A=
+		 * Anything outside both VCO bands is dropped with a warning=0A=
+		 * rather than trusted.=0A=
+		 */=0A=
+		for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+			u64 f =3D sitdev->pll_fvco[i];=0A=
+=0A=
+			if (f && !sit9531x_fvco_in_band(i, f)) {=0A=
+				dev_warn(sitdev->dev,=0A=
+					 "PLL%c Fvco override %llu Hz is outside the band that PLL runs in, i=
gnoring\n",=0A=
+					 'A' + i, f);=0A=
+				sitdev->pll_fvco[i] =3D 0;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+=0A=
+out_map:=0A=
+	if (!device_property_present(sitdev->dev, "sitime,output-pll-map"))=0A=
+		return;=0A=
+=0A=
+	/*=0A=
+	 * Any 1..MAX_OUTPUTS length is accepted so the 8-output SiT95317 need=0A=
+	 * not pad to 12; variant detection has not run yet and entries past=0A=
+	 * the detected num_outputs are never indexed.  Trailing entries of a=0A=
+	 * short map must read as unmapped rather than 0 (=3D=3D PLLA), which=0A=
+	 * would mark unrouted outputs active in sit9531x_out_state_fetch().=0A=
+	 */=0A=
+	memset(sitdev->out_pll_map, SIT9531X_OUT_PLL_UNMAPPED,=0A=
+	       sizeof(sitdev->out_pll_map));=0A=
+=0A=
+	n =3D device_property_count_u32(sitdev->dev, "sitime,output-pll-map");=0A=
+	sitdev->out_pll_map_count =3D (n > 0) ? n : 0;=0A=
+	if (n <=3D 0 || n > SIT9531X_MAX_OUTPUTS ||=0A=
+	    device_property_read_u32_array(sitdev->dev, "sitime,output-pll-map",=
=0A=
+					   map, n)) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "invalid sitime,output-pll-map, ignoring\n");=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The binding allows only 0-3 and 255 per entry.  A stray value=0A=
+	 * would silently unroute an output (m >=3D SIT9531X_NUM_PLLS reads=0A=
+	 * as unmapped in sit9531x_out_state_fetch()), so reject the whole=0A=
+	 * property loudly instead.=0A=
+	 */=0A=
+	for (i =3D 0; i < n; i++) {=0A=
+		if (map[i] >=3D SIT9531X_NUM_PLLS &&=0A=
+		    map[i] !=3D SIT9531X_OUT_PLL_UNMAPPED) {=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "sitime,output-pll-map entry %d is %u (must be 0-3 or 255), ignoring =
map\n",=0A=
+				 i, map[i]);=0A=
+			return;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < n; i++)=0A=
+		sitdev->out_pll_map[i] =3D map[i];=0A=
+	sitdev->out_pll_map_valid =3D true;=0A=
+}=0A=
+=0A=
 int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	struct clk *xtal_clk;=0A=
@@ -4267,6 +4411,8 @@ int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=
=0A=
 	if (sitdev->reset_gpio)=0A=
 		fsleep(10000);	/* internal boot after release */=0A=
 =0A=
+	sit9531x_parse_board_config(sitdev);=0A=
+=0A=
 	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
 	if (rc)=0A=
 		return rc;=0A=
@@ -4277,6 +4423,21 @@ int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=
=0A=
 				     "Unknown variant ID: 0x%02x\n",=0A=
 				     variant_id);=0A=
 =0A=
+	/*=0A=
+	 * The map is parsed before the variant is known, so its length can=0A=
+	 * only be checked against the part here.  A map that stops short of=0A=
+	 * the outputs this variant has leaves the rest reading as unmapped,=0A=
+	 * which would drop real output pins; fall back to the routing the=0A=
+	 * registers describe instead.=0A=
+	 */=0A=
+	if (sitdev->out_pll_map_valid &&=0A=
+	    sitdev->out_pll_map_count < sitdev->info->num_outputs) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "sitime,output-pll-map has %u of %u outputs, ignoring map\n",=0A=
+			 sitdev->out_pll_map_count, sitdev->info->num_outputs);=0A=
+		sitdev->out_pll_map_valid =3D false;=0A=
+	}=0A=
+=0A=
 	sitdev->clock_id =3D sit9531x_derive_clock_id(sitdev);=0A=
 	sitdev->intsync_src =3D -1;=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 1fc14eabb621..31a5f49c0253 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -224,6 +224,7 @@ struct sit9531x_dev {=0A=
 	u64			pll_fvco[SIT9531X_NUM_PLLS];=0A=
 	u8			out_pll_map[SIT9531X_MAX_OUTPUTS];=0A=
 	bool			out_pll_map_valid;=0A=
+	u8			out_pll_map_count;=0A=
 =0A=
 	/* Inter-PLL synchronization state */=0A=
 	s8			intsync_src;=0A=
-- =0A=
2.43.0=0A=
=0A=
