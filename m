Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754C56853F;
	Tue, 13 Oct 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931320; cv=fail; b=NSZahTTQughRub/UJygS1CSfh4PuWMeNGF8ROlvNdL4VK2qQrF0+c+0hwliZGH7Izg4t2Qi0Z6ysTURRWwRUv6LVKxlj5YdfHrkYYG1gc8x37j3np+bgV9lk/HNu7zdh6YylyedILAhL9jseqAE3FAaFkQYOT1DO1m9IU621SiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931320; c=relaxed/simple;
	bh=A61CkcTCuiTNETpNJgLAUJ1SF5msJEmXZX1aJHQwTAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgFoWZxGamhj9iRIXOKHuS1UE8dx7ef/SHIi983Kt2++0smK5y0RkLXjCXHeG5yTJVBIBhdILPhADu9rexolO6M3We/zABNjrpx1mR4rdU3M30FkxhVQ+hf9laQkVYLu2MhbqdvgVSoEGwydQWq5c7xSHHS0H4fpcH1D0ZlJY3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=fUGTDnyo; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=nFjzTJnH; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="fUGTDnyo";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="nFjzTJnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=XVbXaklplnXNkomSorWluSMiPZElcCzURU3X4PzqQ1A=;
 b=fUGTDnyoqeQFumFR3Ilr+t9Z0oAcOUNriR/DwOHAJrgaMprXgTQy06LCzO0bTNJOvwwaQVUj+sY786x4CW21VXGsRFz++CReoeMm5NWhDvq/AyI+PMBCsms4+Fm9kZWp/jbrOgI8/pdjXSqqzn+ru3i+n9OjyEZLgojJjrc3rkspTtBzIOjV1DPE69NxdvaTiJN1g2lljg2+dzyk3WHE6OKvd2JVSVptZ1bzkNycdREtHh+xEm+/u9+U6Y+P6OTHjsyyEW783fW42xQQgX3wOEpcOTVlpi2xb8Qu52dimByxjhVlHDTDjZkVP/P5tClqzUd1GeltzGgOOfEnzWsEUw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021141.outbound.protection.outlook.com [52.101.52.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AC99680007E;
	Tue, 13 Oct 2026 22:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjUpXD2SQtiuc9SZMUMipWEpqD6o6/1OU1A5Nr8bXrq0315dUX0ihIpQ0ayuFa5mgqKxDvc5pd21rqkdyeXqsgX3KX5h/yOZU600xz0r18ouAB5YHnFwNmVRjWJLnbsYdiSFUIjHm9VPMm5FGOMIkGOiyjZU4k/WZ/UJqOyEkf2WbxVoYZoyh55IqXYRlPZmI71upZe8XuGJdp5mhqVuQ72/bULBsjYOB+nPFaFjdRedC/fC+SW0dQQIuacR4NWExu28UW6FD7IwWG0o+X5laud3cAXiaW/1YTM+mrmj9uckUPvwTsngpnafFhy+ay/Nm+IFmrREQG3xJ0smzca4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVbXaklplnXNkomSorWluSMiPZElcCzURU3X4PzqQ1A=;
 b=sj33m54fwWKXz6De4oQ8O2rO6TgbBGtI3oTlhxBLaYy3EtTWDmf7cxowlUHlkqNJ93F9ao0Xj8awsEVP3rJIsVpwhewNDVePvE/ptv6rCPkSeCylm7OuxUAVC67rNQmbYlgvsu5bZVApHgv5ivMnmFnif4Z3TV8uzzFFgN1gUsuv46gx4j32MLU3olI58KHJwrRhbtrnBD8VB5bmoAOT4irzlbAB8Vv7QrANRyn1+rpRTw7pMrxKdB4bxKXlyBhkPqbezQIi6wGn9XCSykc4ahFaThV/5hPf7gccrGmMPyHkz1TpUFAwSTypW8tfqJMqZ0StL42u7ZGZ77mJq67pFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVbXaklplnXNkomSorWluSMiPZElcCzURU3X4PzqQ1A=;
 b=nFjzTJnHOoqtF2A8Gb5yxMLGkf6L+d7RHqgb+ixNgwmbDLFjRfJ4z9KIVRXp7bO6nMRT7Og6rcBfSpHmnRFsgN6HvsUrEbzT23ASGWvxVmhBsTZQneioLkldVyCulVwsKCcZBu4mfZHoHKZHH0bYG47Yh1xdP/bXEh6nBvMGSnWqTXHspCbxJls0frOciw3KyzlybzjOWdd/+O+oPYAD26xB6cqV3t+koUfr2kAfPWB3kJ4OvPPmXsTRZ8ILfqJ5KthhRbLd718WBqQS9EgyBVJHY8Wd5SjzAOJTTvUEKKcRND5OuHhgiTlUBU+yxeUtQ/gZWt+aksRsE1Pfykqy3Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by LV2PR20MB995388.namprd20.prod.outlook.com
 (2603:10b6:408:36d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:34 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:34 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 04/12] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Topic: [PATCH net-next v13 04/12] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdW2P/0OEhu8U9dkWPN9oKD82kLA==
Date: Tue, 13 Oct 2026 22:41:34 +0000
Message-ID: <20261013224131.27149-5-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|LV2PR20MB995388:EE_
x-ms-office365-filtering-correlation-id: 3d5f91f9-75e9-4132-8654-08df297b226f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|5023799004|56012099006|261009223027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|10067099003|260925021911599003|260925021311599003|260925022911599003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 NRr2XiZZPj1IanXkYlubBgnnEm+38JWDESYQix/vLaOxE1oqfj/rM3jm740ol14pLKDU4UXNcSABgCcroRw+ZAwZdZOYG+aLW++GaKnrc4Ciu4BqVwX8+bHX4qsYt/h3T3Buu+Fbr2nODhN57fGh6pSxwTju8GIT0IefBdJvphv7enx85+pRgw4MQgpIvztwC3xl8m2nXwcZGSO7As8yJIA/9mJhFABSAxZ20JjVK/1QVebcORz3YTc2vSWut0GrlykUvynmYN/gJGBnYMBEtyyrg4ykAXhcwl0/lyidpjYjXCDPkITn61M9kPyf00CPyZZ67J5qIarFd+SRcnJ3gYd5G6rKR5Yo4/lWRt3it9HHBDIRRzdBISG5d5xNHErYT+Ht6QAtciq7g+n8ig9YTKYUU2RsNB1tYKGMK6/qaHYLp8VBzMuqyu3WQMkHaNa6jzb6Qd+cMespL8/2IA1NpysvBqEuiEh8JCeN0Rud3C+Y4lEdX0IWMEpVLwHqA72DFMpxshUDB3NiiSXhOTxyw8DvyECTOW/yDkfW87otwWTQ5YjDSeistLvuZ4j8/JzWyTG+IKRfrf/uMra8wQi+e1QsmnP73j3+VwayS2EFjJpPqFnXfm9uc4J9ltzvwNuMw/3MtrTRrfFAJVPS+ppqQGn0vxeAq1jXp+L+LMjyM/hiY509Gg1Vot0s+1PPceVnj88ovG169icEdT974aTrUAuIjVASLYK+GiaGAoIS9/Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(5023799004)(56012099006)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?l59yqTD4VIpLYRr6KTmail1Pc6VoStde4vFLTuVNADQ4rA1Eqr/eGJCZHf?=
 =?iso-8859-1?Q?RuvSqs0DrfbiiD5NoL+UuuFDx3Y1sELbiwLW9CKzDVotLU144C1DdhB/c/?=
 =?iso-8859-1?Q?kbP7xtJTHAQ1Kk5KTq0Z6SZrd3XV7QROamFU74/KIYsdN1glGZsur9ZoRR?=
 =?iso-8859-1?Q?sln1MRwjRCBKflHgCtLnayyVnopgas4Hm6M+wNOdXuyDUdPSTiXEOK6PO3?=
 =?iso-8859-1?Q?cWUhVmmuuoaXhuJuptaN9cXVU/RK9oOKrR9GVb+7yZLfnULUFByU4iP6h5?=
 =?iso-8859-1?Q?sj12gDpp1JCs5LIbBgyWOqgVG2qNeEqU4JA8cDAikuD9WswTPfHBbNWHDG?=
 =?iso-8859-1?Q?MYrLX5FVgKpzFHpxis1rMsBxnXjAsk6ptDRkDEw6hkkEk1NIRdOyk8O03i?=
 =?iso-8859-1?Q?xmjJ7pFEoXIvgEA1zI1XWAYne0yG+/u/t4iORv17bfyKNs/615KxMt+lVF?=
 =?iso-8859-1?Q?XWCQz3tZWWuk0O/aRczuRLfsG+EmRGmHrPtlAbAMF+JzowHZwEidnSrdR7?=
 =?iso-8859-1?Q?y/hzOmaCiYf0ptdwoa0++EoZ5K5GgeqPMEiIEYUb8IDj12oiJfe+30hLj3?=
 =?iso-8859-1?Q?jEd1TDYRHTQmoWfNvVlVkXjJKKG+JIVUrZwp9U4+ApnUOtQ4baaNhCPMw7?=
 =?iso-8859-1?Q?KvHmXZdK9StvDX7ezGDbLSTOnR/cNBU2O7f3+VADhWMaHCoZWemnDTOGCH?=
 =?iso-8859-1?Q?6qzC4Rrgxvo08gKpSX6mootC78E80vUfRiQZtJMV+AHNI/+inaBn/XgZJj?=
 =?iso-8859-1?Q?YB8Pj7F8MD0zlKC7XSpxMz3D5tmXEAl6HDOZi81HA6TqwnLdf3I5a7vstc?=
 =?iso-8859-1?Q?eg2bXFuNgUiaoxfv8Jd+glf1ecZpfZjd70q05Te4yTGK940/eoTn4OTWSI?=
 =?iso-8859-1?Q?79Z5YeRqQ0Jo/HcIZbCyk31UGTnLFULUJ3qe3AuhCeqyRA4BSMOfaMKEUl?=
 =?iso-8859-1?Q?e/sutNN/V4MfEhfQxzjwJJZzO4UEjUQyRwxo1eQ5tFQIcynbQgB7/x52yC?=
 =?iso-8859-1?Q?4XM5rJhbaznNoMeh3iZo5CWCFmGjlNoei1MLaDhx+2/B0he84c9fnOaMwR?=
 =?iso-8859-1?Q?d0iGJkpHkDd4kkYTHXNUYvYVccRnbkDau4iqgYy85kL/tymEErf9nZpdyF?=
 =?iso-8859-1?Q?sKcw96J0rcI+SHH3WboCTkGXDnVyxq++cnDgJWyqkuKf3UvawX/I6tiZ0a?=
 =?iso-8859-1?Q?6vHMKW4tb6wky5NmEjvNFeCsBfGhODT79kHpVVm4ODNhPYOrYb383vWK6e?=
 =?iso-8859-1?Q?XJTuI5CNqwVo3F0/GylnywVDH9gdc6Bpv4Nqq8X6KMq1k3BKggqRk9dUxT?=
 =?iso-8859-1?Q?9S36qLM+1duM35asj4Lau1wSI0Oad7XuJiea4oxeVG1XPgcOqTpmC73EYc?=
 =?iso-8859-1?Q?tbdDCok7SAO+C8Pkyjy3KOQ6TFRfeFl19DuJij5utFwP0O6okD+g4ipLLE?=
 =?iso-8859-1?Q?rJeVHVuWAkTV5A9wm7LWuHiM0Ho3DiGwDn2JojXNtu6L2kj78krzaoGrXa?=
 =?iso-8859-1?Q?aCUlcNOhUxYhn/thBAh8dIJLVHRMqUFhahAJppk9AcDqjjTnSxIMFXfTA7?=
 =?iso-8859-1?Q?K9220wcol6xW+oJpyqxpURnz6ASmeDJpFO5W0cdipNNE3A1OBjE5vATeug?=
 =?iso-8859-1?Q?t3GBO+81otKp0XMHFgsisO9LBNY2LUF8+H2cZrmu8Kel1v30nybefYQCO3?=
 =?iso-8859-1?Q?r/1+aDecY/Z/Y3HTC4QJcUKt50kq7sz7r5rpn+KA2xDeTCR6AUL7noUGF4?=
 =?iso-8859-1?Q?+jRfzHhphCz7TA1INhYrdd++xAvKJjtQjrqQIrzmUtt1Eq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	yPmeUzIBBkhgzzVyZFLRjSDrGDUBmkeA3IxFy8bk6D1X1TNQ2na7FKHkar9iyT+88blHIDREjflTuZ9viWh6oTCjpVohH3cBGr0VQ+EYE+Nl/ljehA8RWBzjKtRJHZThZjQ/eavD3aKcWM71PAghxajy1mp2zdUungwXfxXBKakanlMAESPgdBR28zaBfaliMviAG71olATIplkzhMG0knOwDeqLaekjPF605RWabTjNHBYtwMssdFHeaGzo+NZBtyEFEIX/aho2W3ZZSBvNJeJFoQdc9poJ9Zeh3YRIrIa7nNLNC682xNYLgYXItlNiKRasaET0E2GxVluBXQZ4KA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5f91f9-75e9-4132-8654-08df297b226f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:34.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GATykb7B/2yLok85jvtz5AuAqxLVNhlcXxaEBQs2VrwCeoQAttbobaif0tp0v0wtLCy+Ms4CL8xlsqVtxnWMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB995388
X-MDID: 1791931296-vyPqZzo-NPcS
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931296;vyPqZzo-NPcS;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The DPLL core wants a type per device and a property set per pin: a=0A=
label, the direction, the capabilities, and the frequencies the pin=0A=
supports.  None of that can be read from the chip -- which frequencies a=0A=
board actually presents on a given input is a board fact -- so they come=0A=
from the firmware node, with defaults for a node that does not describe=0A=
them.=0A=
=0A=
Input pins are interleaved P and N lanes of four differential pairs, so a=
=0A=
logical index maps to a pair and a lane, and a pair configured=0A=
single-ended presents two independent inputs where a differential one=0A=
presents one.  The labels follow from that, and the two extra input=0A=
positions -- the crystal and the inter-PLL sync net -- are named=0A=
separately.=0A=
=0A=
One of the advertised properties is worth naming.  An output whose node=0A=
lists no supported frequencies is advertised as a continuous range rather=
=0A=
than nothing at all, since those pins do accept a frequency set; a=0A=
request inside the range that the integer output divider cannot produce=0A=
is refused when it is made.=0A=
=0A=
Kept in its own file, and introduced before anything is registered, so=0A=
the registration code that follows has nothing to say about firmware.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: LLM=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Reviewed-by: Ivan Vecera <ivecera@redhat.com>=0A=
---=0A=
 drivers/dpll/sit9531x/Makefile |   2 +-=0A=
 drivers/dpll/sit9531x/core.h   |  68 ++++++=0A=
 drivers/dpll/sit9531x/prop.c   | 427 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/prop.h   |  37 +++=0A=
 4 files changed, 533 insertions(+), 1 deletion(-)=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
index a221fe55386a..819af61123f5 100644=0A=
--- a/drivers/dpll/sit9531x/Makefile=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -1,4 +1,4 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-only=0A=
 =0A=
 obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
-sit9531x-y :=3D core.o=0A=
+sit9531x-y :=3D core.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index a263adf0ef35..6e37601c8c59 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -23,7 +23,17 @@=0A=
 =0A=
 #define SIT9531X_NUM_PLLS		4=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/*=0A=
+ * INTSYNC (the inter-PLL sync net) is modeled as two pins.  The=0A=
+ * destination PLL that locks to INTSYNC sees an input pin=0A=
+ * (SIT9531X_INTSYNC_PIN_ID, in the input id namespace after the physical=
=0A=
+ * inputs and the xtal); the source PLL that drives INTSYNC sees an output=
=0A=
+ * pin (SIT9531X_INTSYNC_OUT_PIN_ID, appended after the physical outputs).=
=0A=
+ */=0A=
+#define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
+#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
 =0A=
 /*=0A=
  * struct sit9531x_chip_info - chip variant identification=0A=
@@ -41,6 +51,35 @@ struct sit9531x_chip_info {=0A=
 	const u8	*clkout_map;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * enum sit9531x_signal_mode - input signal electrical mode=0A=
+ * @SIT9531X_MODE_SE: single-ended=0A=
+ * @SIT9531X_MODE_DE: differential=0A=
+ */=0A=
+enum sit9531x_signal_mode {=0A=
+	SIT9531X_MODE_SE =3D 0,=0A=
+	SIT9531X_MODE_DE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_ref - input reference state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ * @sig_mode:		signal mode of the pair this lane belongs to=0A=
+ *			(detected from CLKINx_INPUT_MODE at probe)=0A=
+ */=0A=
+struct sit9531x_ref {=0A=
+	u64		freq;=0A=
+	enum sit9531x_signal_mode	sig_mode;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_out - output state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ */=0A=
+struct sit9531x_out {=0A=
+	u64		freq;=0A=
+};=0A=
+=0A=
 /*=0A=
  * struct sit9531x_dev - SiT9531x device instance=0A=
  * @dev:		parent device=0A=
@@ -48,6 +87,8 @@ struct sit9531x_chip_info {=0A=
  * @regmap:		paged register map=0A=
  * @info:		detected chip variant info=0A=
  * @multiop_lock:	serializes multi-register sequences=0A=
+ * @ref:		array of input reference states=0A=
+ * @out:		array of output states=0A=
  * @xtal_freq:		crystal oscillator frequency in Hz=0A=
  * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
  */=0A=
@@ -59,11 +100,38 @@ struct sit9531x_dev {=0A=
 	/* Serializes multi-step register sequences */=0A=
 	struct mutex			multiop_lock;=0A=
 =0A=
+	/* Hardware state */=0A=
+	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
+	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
 	u32			xtal_freq;=0A=
 =0A=
 	struct gpio_desc	*reset_gpio;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Logical input pins are interleaved: even index =3D P lane, odd=0A=
+ * index =3D N lane of pair index/2 (IN0P, IN0N, IN1P, IN1N, ...).=0A=
+ * Index SIT9531X_MAX_INPUTS is the XO input.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pair - get input pair number for a logical input index=
=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline u8 sit9531x_input_pair(u8 index)=0A=
+{=0A=
+	return index >> 1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_is_n - check if a logical input index is an N lane=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline bool sit9531x_input_is_n(u8 index)=0A=
+{=0A=
+	return index & 1;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_pll_page - get register page for PLL index=0A=
  * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
new file mode 100644=0A=
index 000000000000..3635ea497e41=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -0,0 +1,427 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Retrieves pin properties from Device Tree firmware nodes (or=0A=
+ * applies defaults when no firmware node exists).=0A=
+ */=0A=
+=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/fwnode.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "prop.h"=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pin_label - fill the package label for an input pin=0A=
+ *=0A=
+ * Split out so input-naming changes stay local to this helper.=0A=
+ */=0A=
+static void sit9531x_input_pin_label(struct sit9531x_dev *sitdev,=0A=
+				     struct sit9531x_pin_props *props, u8 id)=0A=
+{=0A=
+	u8 pair =3D sit9531x_input_pair(id);=0A=
+=0A=
+	if (sitdev->ref[id].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u", pair);=0A=
+	else=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u%c", pair,=0A=
+			 sit9531x_input_is_n(id) ? 'N' : 'P');=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_package_label_set - generate package label=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Generates a package label string.  Output pins are named "OUT0",=0A=
+ * "OUT1", ...  Input pins are named after the physical pair and lane:=0A=
+ * "IN0P", "IN0N", "IN1P", ... for single-ended lanes, or "IN0",=0A=
+ * "IN1", ... when the pair is configured differential (the N lane is=0A=
+ * not registered in that case).=0A=
+ */=0A=
+static void=0A=
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,=0A=
+				    struct sit9531x_pin_props *props,=0A=
+				    enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	/* The internal INTSYNC pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		strscpy(props->package_label, "INTSYNC",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal XO reference has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT && id =3D=3D SIT9531X_MAX_INPUTS)=
 {=0A=
+		strscpy(props->package_label, "XO",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal INTSYNC source (output) pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		strscpy(props->package_label, "SYNCOUT",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		sit9531x_input_pin_label(sitdev, props, id);=0A=
+	else=0A=
+		/*=0A=
+		 * Name the chip pin, not the driver's index for it.  The=0A=
+		 * two differ on the variant whose outputs are bonded out=0A=
+		 * from a subset of the twelve slots, and a package label=0A=
+		 * that named the index would point at a pin that is not=0A=
+		 * the one being driven.=0A=
+		 */=0A=
+		snprintf(props->package_label, sizeof(props->package_label),=0A=
+			 "OUT%u", sitdev->info->clkout_map[id]);=0A=
+=0A=
+	props->dpll_props.package_label =3D props->package_label;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_fwnode_get - find firmware node for a pin=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Searches for input-pins/output-pins child nodes in DT, looking for a=0A=
+ * child whose "reg" property matches the pin.  The binding describes reg=
=0A=
+ * as the hardware index, so an output is matched by the chip slot it=0A=
+ * drives rather than by the driver's index for it: on the variant where=
=0A=
+ * the two differ, a board describing the pin it wired would otherwise=0A=
+ * have its properties applied to a different one.=0A=
+ *=0A=
+ * Return: 0 on success, -ENOENT if no firmware node exists=0A=
+ */=0A=
+static int=0A=
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,=0A=
+			     struct sit9531x_pin_props *props,=0A=
+			     enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct fwnode_handle *pins_node, *pin_node;=0A=
+	const char *node_name;=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		node_name =3D "input-pins";=0A=
+	} else {=0A=
+		node_name =3D "output-pins";=0A=
+		if (id < sitdev->info->num_outputs)=0A=
+			id =3D sitdev->info->clkout_map[id];=0A=
+	}=0A=
+=0A=
+	pins_node =3D device_get_named_child_node(sitdev->dev, node_name);=0A=
+	if (!pins_node) {=0A=
+		dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_name);=0A=
+		return -ENOENT;=0A=
+	}=0A=
+=0A=
+	/* Enumerate child pin nodes and find the requested one */=0A=
+	fwnode_for_each_child_node(pins_node, pin_node) {=0A=
+		u32 reg;=0A=
+=0A=
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))=0A=
+			continue;=0A=
+=0A=
+		if (id =3D=3D reg)=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	fwnode_handle_put(pins_node);=0A=
+=0A=
+	props->fwnode =3D pin_node;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",=0A=
+		props->package_label, pin_node ? "" : "NOT ");=0A=
+=0A=
+	return pin_node ? 0 : -ENOENT;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_get - get pin properties for a given pin=0A=
+ * @dir:	pin direction (INPUT or OUTPUT)=0A=
+ * @index:	pin index=0A=
+ *=0A=
+ * Allocates a pin properties structure, generates a package label,=0A=
+ * looks up the firmware node if available, and reads optional=0A=
+ * properties (label, connection-type, supported-frequencies-hz).=0A=
+ *=0A=
+ * Call sit9531x_pin_props_put() to free the returned structure.=0A=
+ *=0A=
+ * Return: pointer to pin properties on success, error pointer on error=0A=
+ */=0A=
+struct sit9531x_pin_props *=0A=
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
+		       enum dpll_pin_direction dir, u8 index)=0A=
+{=0A=
+	struct dpll_pin_frequency *ranges;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	int i, j, num_freqs =3D 0, rc;=0A=
+	u64 *freqs =3D NULL;=0A=
+	const char *type;=0A=
+	u64 curr_freq;=0A=
+=0A=
+	props =3D kzalloc_obj(*props, GFP_KERNEL);=0A=
+	if (!props)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
+		 * reference, so it can be connected.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+		   index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC source pin: a PLL drives the INTSYNC net.  It can be=0A=
+		 * connected/disconnected but carries no priority (driving the=0A=
+		 * net is not a reference selection) and no frequency.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+		   index =3D=3D SIT9531X_MAX_INPUTS) {=0A=
+		/* The XO reference is fixed: no state or priority control. */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D 0;=0A=
+		sitdev->ref[index].freq =3D sitdev->xtal_freq;=0A=
+		curr_freq =3D sitdev->xtal_freq;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->ref[index].freq;=0A=
+	} else {=0A=
+		/*=0A=
+		 * A synthesized clock output is an external connection with=0A=
+		 * no more specific meaning; a board that knows better says=0A=
+		 * so through the pin's connection-type property below.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->out[index].freq;=0A=
+	}=0A=
+=0A=
+	/* Generate package label */=0A=
+	sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);=0A=
+=0A=
+	/*=0A=
+	 * Both INTSYNC pins are internal to the chip and have no board-level=0A=
+	 * wiring, so they take no properties from the firmware node.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    (index =3D=3D SIT9531X_INTSYNC_PIN_ID ||=0A=
+	     index =3D=3D SIT9531X_MAX_INPUTS))=0A=
+		goto skip_fwnode_props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	rc =3D sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);=0A=
+	if (rc)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	/* Look for "label" property -> board label */=0A=
+	fwnode_property_read_string(props->fwnode, "label",=0A=
+				    &props->dpll_props.board_label);=0A=
+=0A=
+	/* Look for "connection-type" property -> pin type enum */=0A=
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",=0A=
+					 &type)) {=0A=
+		if (!strcmp(type, "ext"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		else if (!strcmp(type, "gnss"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;=0A=
+		else if (!strcmp(type, "int"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		else if (!strcmp(type, "synce"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;=0A=
+		else if (!strcmp(type, "mux"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Unknown pin type '%s'\n", type);=0A=
+	}=0A=
+=0A=
+	num_freqs =3D fwnode_property_count_u64(props->fwnode,=0A=
+					      "supported-frequencies-hz");=0A=
+	if (num_freqs <=3D 0) {=0A=
+		num_freqs =3D 0;=0A=
+		goto skip_fwnode_props;=0A=
+	}=0A=
+=0A=
+	freqs =3D kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);=0A=
+	if (!freqs) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_freqs;=0A=
+	}=0A=
+=0A=
+	rc =3D fwnode_property_read_u64_array(props->fwnode,=0A=
+					    "supported-frequencies-hz",=0A=
+					    freqs, num_freqs);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "failed to parse supported-frequencies-hz for %s: %d\n",=0A=
+			 props->package_label, rc);=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Seed an input's runtime ref->freq with the first DT-listed=0A=
+	 * supported frequency: for an input the board lists the rate that is=0A=
+	 * physically wired to it first.  An output's current rate is what its=0A=
+	 * divider produces, not an entry of the list it may be set to.=0A=
+	 */=0A=
+	if (num_freqs > 0 && dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index !=3D SIT9531X_MAX_INPUTS)=0A=
+		curr_freq =3D freqs[0];=0A=
+=0A=
+skip_fwnode_props:=0A=
+	/* Neither INTSYNC pin carries a frequency attribute */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		return props;=0A=
+=0A=
+	/*=0A=
+	 * Advertise only concrete values from firmware plus current runtime=0A=
+	 * value. For outputs without a firmware list, publish one wide range as=
=0A=
+	 * an explicit fallback because those pins do support frequency_set.=0A=
+	 */=0A=
+	ranges =3D kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);=0A=
+	if (!ranges) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Publish the seeded rate only once the pin is certain to be built.=0A=
+	 * The allocation above is the last thing that can fail, and a call=0A=
+	 * that reports failure must not leave the device's cached rate=0A=
+	 * changed behind it.=0A=
+	 */=0A=
+	if (curr_freq) {=0A=
+		if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+			sitdev->ref[index].freq =3D curr_freq;=0A=
+		else=0A=
+			sitdev->out[index].freq =3D curr_freq;=0A=
+	}=0A=
+=0A=
+	j =3D 0;=0A=
+=0A=
+	/* Current frequency first, when known. */=0A=
+	if (curr_freq) {=0A=
+		struct dpll_pin_frequency f =3D DPLL_PIN_FREQUENCY(curr_freq);=0A=
+=0A=
+		ranges[j++] =3D f;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < num_freqs; i++) {=0A=
+		struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs[i]);=0A=
+=0A=
+		if (freqs[i] =3D=3D curr_freq)=0A=
+			continue;=0A=
+		ranges[j++] =3D freq;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT && num_freqs =3D=3D 0) {=0A=
+		ranges[j].min =3D 1;=0A=
+		ranges[j].max =3D 1000000000ULL; /* 1 GHz */=0A=
+		j++;=0A=
+	}=0A=
+=0A=
+	if (j > 0) {=0A=
+		props->dpll_props.freq_supported =3D ranges;=0A=
+		props->dpll_props.freq_supported_num =3D j;=0A=
+	} else {=0A=
+		kfree(ranges);=0A=
+		props->dpll_props.freq_supported =3D NULL;=0A=
+		props->dpll_props.freq_supported_num =3D 0;=0A=
+	}=0A=
+=0A=
+	kfree(freqs);=0A=
+=0A=
+	return props;=0A=
+=0A=
+err_alloc_ranges:=0A=
+	kfree(freqs);=0A=
+err_alloc_freqs:=0A=
+	fwnode_handle_put(props->fwnode);=0A=
+	kfree(props);=0A=
+=0A=
+	return ERR_PTR(rc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_put - release pin properties=0A=
+ * @props:	pin properties to free=0A=
+ */=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)=0A=
+{=0A=
+	kfree(props->dpll_props.freq_supported);=0A=
+=0A=
+	if (props->fwnode)=0A=
+		fwnode_handle_put(props->fwnode);=0A=
+=0A=
+	kfree(props);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_dpll_type_get - get DPLL channel type from firmware=0A=
+ * @index:	DPLL channel index (0-3)=0A=
+ *=0A=
+ * Reads the "dpll-types" string array property from the firmware node=0A=
+ * and returns the corresponding DPLL type enum.=0A=
+ *=0A=
+ * Return: DPLL type for the given channel (default: DPLL_TYPE_PPS)=0A=
+ */=0A=
+enum dpll_type=0A=
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const char *types[SIT9531X_NUM_PLLS];=0A=
+	int count;=0A=
+=0A=
+	count =3D device_property_read_string_array(sitdev->dev, "dpll-types",=0A=
+						  types, ARRAY_SIZE(types));=0A=
+=0A=
+	if (index >=3D count)=0A=
+		return DPLL_TYPE_PPS;=0A=
+=0A=
+	if (!strcmp(types[index], "pps"))=0A=
+		return DPLL_TYPE_PPS;=0A=
+	else if (!strcmp(types[index], "eec"))=0A=
+		return DPLL_TYPE_EEC;=0A=
+=0A=
+	dev_warn(sitdev->dev, "Unknown DPLL type '%s', using default\n",=0A=
+		 types[index]);=0A=
+=0A=
+	return DPLL_TYPE_PPS;=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h=0A=
new file mode 100644=0A=
index 000000000000..a65efdfd9ef8=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.h=0A=
@@ -0,0 +1,37 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_PROP_H=0A=
+#define _SIT9531X_PROP_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/fwnode.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_pin_props - pin properties from firmware=0A=
+ * @fwnode:		firmware node handle (NULL if no DT node)=0A=
+ * @dpll_props:		DPLL core pin properties=0A=
+ * @package_label:	pin package label (e.g. "IN0", "OUT3")=0A=
+ */=0A=
+struct sit9531x_pin_props {=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	struct dpll_pin_properties	dpll_props;=0A=
+	char				package_label[8];=0A=
+};=0A=
+=0A=
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,=0A=
+					   u8 index);=0A=
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sit=
dev,=0A=
+						  enum dpll_pin_direction dir,=0A=
+						  u8 index);=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);=0A=
+=0A=
+#endif /* _SIT9531X_PROP_H */=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
