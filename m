Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFD414425;
	Mon, 21 Sep 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021491; cv=fail; b=Sa/nSVfdlUNgarJmYe7GW1HHejs+vADPKO2ZJv7+BL0SqvMXReSZBcr71xPTjEhebykEDcr1aLP+KoyWJgt6WyTMsA/l7uGFXX/Dgj/CKm25mUknEB0Rupn1uh/jm5+K6bJmFfep2a9Uz9MtEZKjDPzBhSaOXTjAGjimreeMHms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021491; c=relaxed/simple;
	bh=4Ql66dkgbjruQ8gtdbW9HStkXmOusCGGZQc+HTsBSD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BM85zbakH0C99H7NCniyOFiyv+yjTCsl+OaFgAOUcSMjmNOL5LZVJxEHVzABwRvKo4MBzaGa2hlPPV1Vuye+Hy+LsC2M903aWslVEe99PjsuQXL/kXvPn+8DPvXc2P6jEGnQICNHEXU5pXkyqrEF33H5GfrNaGmHP5/d8AdjjiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=nm0dQ/kE; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=rwTYPtWE; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="nm0dQ/kE";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="rwTYPtWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=H/AIKA+D/7+jqQk4R2OAiEow2J+pkhRE0m8WtU05Bl0=;
 b=nm0dQ/kEayPLwK9r1odPMJbMh+j5mmtP6Vqv6mEa51D3y1hvY3asqlu4GSsrWLh1AE9lFMrCTkmhrlTDWndutSzLJ9BmX+J/WhQHlzke98z5SJk2kRPVML5zsrdbl/OxqQpLHxtamxrTn2Xc8kY+DxfR86YaPzWCdK6mW/14VobOp89GrBRECEM/kKOupY5AC5oYWfLNM2Oav4U+HBMt8RtG8ZqAnfclxdp1tooso6DutvM48QhMfCvjyVW97Ak6xqXAVWUoURksrgPjhYJyLwcyNy/gHEs2eNB2wm1n8rlKduOWP/OHb5rIJ0jzPrYBe+Z9rMWTsDpOWYfoxKm2Jw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 95734940088;
	Mon, 21 Sep 2026 20:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqTdTbfnqzldpFhc5jvsUSVuWw4Hjc4hJDMDoQ2uSOgfpetdd2Mt7juJEhEOAt3afU7sPO0DdxcsCPPEzimAETF9TT/qTXiP02STZUREAhwd7AEnQu5TpPer9jXk5SsL7CCd66IlvYn1oNWa4Bi8qMgKHoQeD38UGwGVXF0g5MHE884oy8vVfoX16vbGxaRrgffQ1NS8GbV8Z2KyUs82kqAWhYp/J/gYjugVpoRWgh3yWS6QprGS/Xqu4VairEjdM08YyASjsXvkBkFvzg1s5innDSHVtsmX2+OHS/PUSEOoq6WZQhs5uMBEpcj8O1xFh8pKXNnZyg3yT553pbtjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/AIKA+D/7+jqQk4R2OAiEow2J+pkhRE0m8WtU05Bl0=;
 b=Fq5OnPhYuTj75F5JCwyoNeK/FfJUBolr0bjA8llq4RE/gld1JfjyOhLyDmao8pMe1sjoB9fkNcJrQ86rAsPSAh3dQHzswSxL6BRtgHSfh/3ixIO6gAjwM2Ol4qmFidwBG0WId0TAZkzLEaJripfW4OHO5/3wMsy+FoexoRZZ6cTZqdeXDWnxU9ec0pqSWDH2d6sxFkTCOuOmRw5cZpD1rs3ICzY8SSS9aKIUTenQ+1iStwFntG0JyG/Tw7NLglq1H6sbvHRfUaHKAhTnbeHdJbPHpFjQWQ/LgtCvpMfrdNBqHdEPzoCBvxva9O/AARqcnR7wHz08rd0YC4KBoz9LJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/AIKA+D/7+jqQk4R2OAiEow2J+pkhRE0m8WtU05Bl0=;
 b=rwTYPtWEleI4nbd7CuaCJhEFJohK1k5HyWLZxWWA7eu26qt+k/lpYiWJ/DQR0ncEFnoIZ6Ktd8umu5afPZoPfNzz1Kd15LJxvtYDZVe/ZGi9UXUzIdQmxJzqDAzKzWxmjxiYcLjeIIJVtJkUN7XUmA6xYCWJePIHpC53PXe+5WNoFoMYH4khuk2ReJbZ4qX5fnlED9g1p/y/hbqCJic1z+O6ZxjruOBjdTQt9QsnczmU7qnZYuq3TzQ9kD38opADuPQVWZpXAfvGWwj2pBx5owh8JX7kqg4IUY6taP0YTvRbeLzpdPwlwxti3swQ9W47d8mlV0iFlJGGW3XQO3hQUg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:15 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:15 +0000
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
Subject: [PATCH v10 09/14] dpll: sit9531x: implement output pin state on a
 DPLL
Thread-Topic: [PATCH v10 09/14] dpll: sit9531x: implement output pin state on
 a DPLL
Thread-Index: AQHdSgVbZHeGo9ROCEWuBqIba+6NzQ==
Date: Mon, 21 Sep 2026 20:11:15 +0000
Message-ID: <20260921201108.42676-10-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: b71e135c-53f0-42f9-e261-08df181c7d81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 BsEQXlffOsfjCokqOFHAm6lwW2ZexGVCSJga5NwG9fnh7t1Gjq42GS/OFo23mztQogOB3ndbYbREczrfDgRbI6bg3A/rZ8nqdV/CeYvnhJHvhJfdygIJ3W3zGbaayL7jLeqio9kAPItYMYRP+qR8RMTe+SLkNBJgW30xZRJ1MUUz4U6gv9XKYpZwX04EUnh81fBCHOX3rcX9rjD4/zkfcTFc5zgvlElIM3nQCOQGTMdldr2nWeX7wWLp6YM240Vz5m8+nFc8DYD9pWxtKud0yIlvObhaUWShttA8JCsMlGEyJLfzTsJkFpRl/vcwxMWS3oqTSqmuzIspu0IDLg2/ixNtNFEL2Q4c+N46OpKR1dEidtBVwkZCSC1qlIcG6QigwLSUgMRXFS5N2QfBn0XOhOWfOcdW+yEh28HqtU159RQ95QwOPPUCNkbfBned1I/nh5Y0htzlAvYIlWWutrmQ1B0Yfoai7ueJBr76xboG3ZuG2JwsRUJvOIbZOpDI+Ic52EP7gj3AR8YL0EJmnHBKDnzTRx8ViEX+xIEkIdX1Aab2g+luEDh0mqHmvo6/Ybjk1KEulJAH5ypmNN5VX4aJ8NlnGafQnAeI9B9b76JIGDOsQy/3E5rKIpKT2wTtR0Rr58Bt4RLmI/zFc7ElRZG6uyJ4sQgzm/OTdL/ZdB6D6qxWvDZNtJV1sgT9gBqaADLzKC4hHUKcaVDE84nk/L/Dmy0nenX8mtd7F48jOUtQtkg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?C92S9Y/VN8eXCfPfzCwIY03WsIVfDaD8jLX/M2pNWXEvB5X1F/z6pmKGSW?=
 =?iso-8859-1?Q?otwTFzbGK8A/U7625SLPJpTWhYO9T2qigAQ/oO63LtQUIik86l3Tno8ahK?=
 =?iso-8859-1?Q?R727H18cHC8C3GKjpMltgFiEX4l473OA9SsCs6rFN5l2Y+39p+VVoHShFR?=
 =?iso-8859-1?Q?inQ9UB0qpVBkxk6lMfC6XanjhGvDb99N0MX3khCxVznEWF3AwoKvXvj2ri?=
 =?iso-8859-1?Q?uc5PrtvCCk5DmdvUYeWwNA0OO1+wIQTaoa1I4P6deBRNz7vcybjgZ6kw65?=
 =?iso-8859-1?Q?iXDdyd/ntXnCJsjlVSkIRpJwiHOhCmZCEYztgBazACKJ3psTx6tb6685Ny?=
 =?iso-8859-1?Q?7HqTsfzpvrssyhzNZaIa19rznC3ltGtFMm709PYrGiJ/spDZ3w9/ZU/XjK?=
 =?iso-8859-1?Q?uxwSbP/98xSUKVjxueUdBXGp63r4hcS8idiw+xYZPd3W0yO51lTcc8KGnH?=
 =?iso-8859-1?Q?ez3IvZeSouTN2p/ZGwuerLTbt00bfpsViDmQI4BHzNjOK34T6QRPs/j4cS?=
 =?iso-8859-1?Q?n3kLYxnaAzpJjMcPLJDTW4gv68rTBvgL984X11ktu9emMKMlsggJ3Rfsa7?=
 =?iso-8859-1?Q?d16/Xi3D+qbXBV4Craq/fD9OYaEB78NLUa4tNz5JEKduokD7VLugUB0/2a?=
 =?iso-8859-1?Q?irztS7W+Brx5pKfddMUvTl3yC1mb5tAzLlQFCaARgZYDBBRLza1DHIniQz?=
 =?iso-8859-1?Q?hqhQV7l7IEfMcaUn0rw3Bfz4wankfx7vPfo8/lwJEMwx9Iq9sYWYfEczjJ?=
 =?iso-8859-1?Q?EC8Jkkase35Pup2txujti5FyW5qacIsJJVaFOZEkR0DjwstZL4cele8uHd?=
 =?iso-8859-1?Q?eR7uIgP+XPUKsNYY03PNeRaYYo+OEvbvL7n6kVolmAXOuZuauQV6COOxye?=
 =?iso-8859-1?Q?NSdWqlgzWUw7W6LGXoeY5c7tUY1PzcNOhldLxYFegmg2URa5XVWMXrj4Be?=
 =?iso-8859-1?Q?Iufpxzbqin2ML1mwkD+B/OfmQJgncxzoZcBfoDMjpMcRjlDBdKtOCJ5nU3?=
 =?iso-8859-1?Q?5L4SvkBFia1m/mIQdS4P/BoPo44jtfylnsDvqCf3DOoHi/4+JG2bjqK99L?=
 =?iso-8859-1?Q?cK61mz9Y2Wvr9clnOL2mLbjfO3MTyFDNetoI/F1OGnB4IzYwFLPXJFSDMW?=
 =?iso-8859-1?Q?dotREg23vpEB2bhxULyXnFk/Fa5GVxhsEPZo2WcGctJRIWUyLbmFQoPTUl?=
 =?iso-8859-1?Q?j/MBca/awmzS8R0J84Yd2aDkInHeJ+MofBrDJfqJsF4lvqMwJGmRApmKzD?=
 =?iso-8859-1?Q?xxFUvOuTpaxGwumFBCQLgAtIC0m6NB2ynsmxxoGbpg6wP65qTH30k+W0pt?=
 =?iso-8859-1?Q?iOEccZ97b6UxBZTn+NLnck4MHhSQtrzHn1TMuq/JetivQbd/HKDt7Qajr0?=
 =?iso-8859-1?Q?8UFHbuUWoYysLdmo6VrEa8jNALejxvDjxilySzDcv2Jgm0OIPJX3IAZECk?=
 =?iso-8859-1?Q?VJJkjpLQM/Rn9sj/pA+nY58GHp4K5k7KcWPLdMkK9FSsU+fpM0ieICzLTq?=
 =?iso-8859-1?Q?KKD9toGx1Fuhzfirhha1o3q1uXfr2xDxjqp5z5K1/LBsWvhDLhSl8w9VqP?=
 =?iso-8859-1?Q?P4MYSEs5JzpYCoYgUqq98f2E6T0nCW3JVkQ3Y7r17zOOwCs2/zyOqsYyRO?=
 =?iso-8859-1?Q?q/4Ne6QRfSIRd/tGics+XMz+9G9JnZPZC/YmCW4dfuOnv2ezco6BYZkZMO?=
 =?iso-8859-1?Q?AGYIyVvCRgdT06fL+R1GVW7HWFL1kWHHxRtTbNDCTEWThbUFWThjF4h5xR?=
 =?iso-8859-1?Q?L12oCpo/7kXNyoo73EF2CncHwBh0WmtdYfnMjEVRv7Kxhv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Hw9zKKwQfPKOSRYYP8/MzaYdy4GDfLI+iKkF7hkhAa4Es1sxAsxgbPCKG9IPqf5JPeBO1cOzbNmS9TMokJSxLR9LLjxIECZeqJODoZNyUK4EBTRaoxoAmsBhp+hTWqvpx5voefdErW0uNKmuo29Jt66aaeqeqah/Wh1DeiXtPve/g5KfXDEzkE244+dcuneaylEhWFk8/wo9LZOS4N5n/1l7LkDNMZ/2rXPUxzjNbHSeel8VSC4ciChWFfGS0Q40gVnOigRTmFHEQF+wE3ny1uyaPeYJxLKBSGKMDO2dIj4y9hoY9RMdcXkJbzfOwQRNG/D6XmjG25tdf/NxuoyK1g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71e135c-53f0-42f9-e261-08df181c7d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:15.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fH0qYAXvIntJCVSrQfv0Vu4bOw6q44HpN3vJ+N5nMpTNhB/k2KzIIMkYLgjTvQd5iwubhTlW0KynC1RNxiusg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021480-r5B3liEKGN0s
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021480;r5B3liEKGN0s;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
An output is driven by its PLL rather than selected by it, so its state=0A=
says whether it carries a signal: connected while it drives, disconnected=
=0A=
while it is muted.  Setting the state mutes or un-mutes it by forcing the=
=0A=
pad to Hi-Z, the only per-output control the device offers that leaves the=
=0A=
divider alone.=0A=
=0A=
The force bit and the state bit are separate, and a pad follows the loaded=
=0A=
configuration while the force bit is clear, so both are read to decide=0A=
whether an output is muted and both are written to change it.  Which of=0A=
the four register banks applies depends on the slot and on whether the pad=
=0A=
is single-ended or differential.=0A=
=0A=
This is also where output pins start being registered at all: until now=0A=
the registration filter took inputs only, so the output operations the=0A=
earlier patches added -- direction and frequency -- had nothing to=0A=
dispatch on.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Write the forced-Hi-Z pair value first and override second, so the pad=
=0A=
    is never pinned driven between the two, and release the half that=0A=
    reached the device when the other did not.=0A=
    =0A=
    Said in the changelog that this is where output pins start being=0A=
    registered.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 249 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   7 +=0A=
 drivers/dpll/sit9531x/dpll.c |  87 ++++++++++++=0A=
 3 files changed, 337 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 0687ad6de861..8daf0fbf6772 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -418,6 +418,47 @@ static int sit9531x_output_forced_hiz(struct sit9531x_=
dev *sitdev,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_state_refresh - read an output's mute state back=0A=
+ *=0A=
+ * Used when a mute could not be confirmed at the time it was written.  Th=
e=0A=
+ * driver does not poll output state, so without this the cached value wou=
ld=0A=
+ * stand until something else happened to write it.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)=
=0A=
+{=0A=
+	bool muted;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, out_idx, &muted);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].enabled =3D !muted;=0A=
+	sitdev->out[out_idx].state_stale =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,=0A=
+				unsigned int reg, u8 bit, bool set)=0A=
+{=0A=
+	u8 cur, new_val;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &cur);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	new_val =3D set ? (cur | BIT(bit)) : (cur & ~BIT(bit));=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, reg, new_val);=0A=
+}=0A=
+=0A=
 /* Attempts to re-lock the output loops before reporting them open. */=0A=
 #define SIT9531X_LOOP_LOCK_TRIES	3=0A=
 =0A=
@@ -539,6 +580,190 @@ static int sit9531x_prg_commit(struct sit9531x_dev *s=
itdev)=0A=
 	return rc2 ? rc2 : rc3;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_hiz_write - mute or unmute an output=0A=
+ *=0A=
+ * Muting takes control of the pin (MASK=3D1) and drives it low (STATE=3D0=
) on=0A=
+ * both the differential and the single-ended register pair, because the=
=0A=
+ * output must go quiet whichever way it is wired; unmuting hands it back=
=0A=
+ * to the device's own state machine.  The caller must already be in the=
=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,=
=0A=
+				     bool mute)=0A=
+{=0A=
+	struct sit9531x_hiz_regs r;=0A=
+	int rc, undo_rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(slot, &r);=0A=
+=0A=
+	if (!mute) {=0A=
+		rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+=0A=
+		return sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Forced value first, override enable second.  Muted is decoded as=0A=
+	 * MASK set with STATE clear, so enabling the override while STATE=0A=
+	 * still holds whatever the loaded configuration left there can pin=0A=
+	 * the pad driven for the width of an I2C transfer.=0A=
+	 */=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);=0A=
+	if (rc)=0A=
+		goto undo_diff;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		goto undo_diff;=0A=
+=0A=
+	return 0;=0A=
+=0A=
+undo_diff:=0A=
+	/*=0A=
+	 * Only one half of the pair reached the device.  Release the=0A=
+	 * override that did: that leaves the pad on the state the loaded=0A=
+	 * configuration gave it, which is where the request started, rather=0A=
+	 * than driven by half a mute that nothing afterwards clears.=0A=
+	 */=0A=
+	undo_rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);=0A=
+	if (undo_rc)=0A=
+		dev_err(sitdev->dev,=0A=
+			"slot%u: Hi-Z override left half applied (%d)\n",=0A=
+			slot, undo_rc);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_disable - mute an output (force Hi-Z)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Sets MASK and clears STATE on BOTH the DIFF and SE register pairs so th=
at the=0A=
+ * output is muted regardless of its electrical configuration.  The=0A=
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence=0A=
+ * so the new state is applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, true);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/*=0A=
+	 * Keep the software state aligned to what hardware now drives even=0A=
+	 * when one write in the sequence failed. The commit above may have=0A=
+	 * applied a partial mask/state combination.=0A=
+	 */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_output_enable - un-mute an output (active state)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Releases MASK on BOTH register pairs so the output returns to=0A=
+ * whatever the initial_config blob programmed.  The writes are wrapped=0A=
+ * in the PRG_CMD / NVM update / loop lock sequence so the new state is=0A=
+ * applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	bool muted;=0A=
+	u8 slot;=0A=
+	int rc, ret, state_rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_output_hiz_write(sitdev, slot, false);=0A=
+=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/* See sit9531x_output_disable(): commit can apply part of it. */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		/*=0A=
+		 * The writes may well have landed; what failed is the proof.=0A=
+		 * Mark the cached state for a read-through rather than=0A=
+		 * reporting the value it had before this call.=0A=
+		 */=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
@@ -1997,6 +2222,8 @@ static int sit9531x_out_state_fetch(struct sit9531x_d=
ev *sitdev, u8 index)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
+	sitdev->out[index].state_stale =3D false;=0A=
+=0A=
 	/*=0A=
 	 * The OUT_MAP_LO/HI bitmaps are indexed by the physical slot the=0A=
 	 * output occupies on the chip, not by the driver's logical output=0A=
@@ -2655,8 +2882,8 @@ static bool sit9531x_input_pin_is_registrable(struct =
sit9531x_dev *sitdev,=0A=
  * @index:	pin hardware index=0A=
  *=0A=
  * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
- * A pin class whose state callback the tree does not have yet is not=0A=
- * registrable: the core refuses a pin without one.=0A=
+ * For output pins: the pin is registrable if this DPLL is routed to it,=
=0A=
+ * whether or not it is currently driving.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -2666,13 +2893,23 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 {=0A=
 	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
 =0A=
-	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+			return true;=0A=
+		if (index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+			return false;=0A=
+=0A=
+		return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	}=0A=
+=0A=
+	if (index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
 		return false;=0A=
 =0A=
-	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
-		return true;=0A=
+	if (index >=3D sitdev->info->num_outputs)=0A=
+		return false;=0A=
 =0A=
-	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
+	return sitdev->out[index].pll_idx =3D=3D sitdpll->id &&=0A=
+	       sitdev->out[index].routed;=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 91b84b420011..3b35bf1c4cd5 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -97,6 +97,8 @@ struct sit9531x_ref {=0A=
  * @enabled:		output is driving, i.e. not forced into Hi-Z=0A=
  * @cmos:		output is wired single-ended; the Hi-Z pair that=0A=
  *			speaks for it is the SE one, not the differential=0A=
+ * @state_stale:	the cached mute state could not be confirmed against=0A=
+ *			hardware and has to be read back before it is reported=0A=
  * @routed:		output is mapped to @pll_idx by the initial=0A=
  *			configuration; an unrouted output has no DPLL pin=0A=
  * @pll_idx:		PLL driving this output (0-3)=0A=
@@ -106,6 +108,7 @@ struct sit9531x_out {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	bool		cmos;=0A=
+	bool		state_stale;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
 	const char	*label;=0A=
@@ -253,6 +256,10 @@ int sit9531x_input_prio_add(struct sit9531x_dev *sitde=
v, u8 pll_idx,=0A=
 			    u8 input_idx);=0A=
 =0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev,=0A=
+				  u8 out_idx);=0A=
 =0A=
 /* ---- Output frequency ---- */=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 9f0678ddfe0e..c1ab202bf297 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -783,10 +783,97 @@ sit9531x_dpll_output_pin_frequency_set(const struct d=
pll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state=0A=
+ *=0A=
+ * reports CONNECTED when the output is driven and=0A=
+ * DISCONNECTED when it has been muted via sit9531x_output_disable().=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state *state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	const struct sit9531x_out *out;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * A mute whose read-back failed left the cache unconfirmed; there is=0A=
+	 * no poll of output state to correct it, so read it here rather than=0A=
+	 * report a value that may predate the request.=0A=
+	 */=0A=
+	if (sitdev->out[dpin->id].state_stale) {=0A=
+		mutex_lock(&sitdev->multiop_lock);=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, dpin->id);=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		if (rc) {=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Output mute state could not be read back");=0A=
+			return rc;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	out =3D sit9531x_out_state_get(sitdev, dpin->id);=0A=
+	*state =3D out->enabled ? DPLL_PIN_STATE_CONNECTED=0A=
+			      : DPLL_PIN_STATE_DISCONNECTED;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output=0A=
+ *=0A=
+ * forces Hi-Z on the output pin via the Page 0x03=0A=
+ * force/state register pair.=0A=
+ *   CONNECTED    -> enable (release force, back to factory default)=0A=
+ *   DISCONNECTED -> disable (force Hi-Z)=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set output pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_output_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_output_pin_frequency_get,=0A=
 	.frequency_set		=3D sit9531x_dpll_output_pin_frequency_set,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_output_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_output_pin_state_on_dpll_set,=0A=
 };=0A=
 =0A=
 const struct dpll_pin_ops *=0A=
-- =0A=
2.43.0=0A=
=0A=
