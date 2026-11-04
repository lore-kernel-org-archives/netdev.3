Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793805405;
	b=pEtXgtFd3ALwwRPQELe78PGOd/ZbniSKQsd2Br4hwkBv8H6/WDMbdm/mukCOBBpBZMsM
	 Iu8tc8Wpvye+X6PQW/tQCLzgpiQyCz1NUsFGXCiGwMCkqb+MTtb6cBduEmQLqCpzo+DP5
	 2Pv6H3JlO/az05aXAE0Gzb/PGVh6xKraHGWawesD41KAqcILyD9wpkOKDKHWd2P2OUA5y
	 1oGVhW3l4wvmNjRTZnVvIxw1zWvZIAw8nhWjaz1hm1RQRsF9ALyPgB2Emeo4gDL84cp5r
	 fhamhsttYnqIBc5VCDptILB0GlUeYbfl0QjHMn0ASFq/YSes9F9wvOXdEcoHFl4rncQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805405;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AzOlhW3F+r2+cDMcRhcJIqg7UkfC1BPHz+b+Ewx1/jI=;
	b=Zmyl22Ng2tHMY9mRUey1zYPE+YpfvmRy2yGKB7WAxRr8DGC61VWWNM8Vz/e9/EWCC+aI
	 B5rR5fuJZ72SuM+MKH7l1ttaZwEupb2JEQG13ArkJJP8tGw9qlzwlv1QYyjXxgY7CrVS4
	 fLZrUlk3/ZBamYnULArtUrM1CbuWgqdfWNSKnU/HaqeuMcFcqJ/VcAE3YOfxWCHw5ARku
	 JszAEJBw5eB15hiAOi/yt7fokb3OXPwFd6I2ic1l9ex+h1CPwycmf7aER1ND1JrxaQRxP
	 k8Fk6tLnZ+ib2mvM3RMQoGeVvoTyoIB2p4p5WYfX2G5E/LlRmPvvFWCVxK+J/TvXjfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=sjtdxHnW;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HEvW8x3a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC560A6F70;
	Wed,  4 Nov 2026 15:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5EC560A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=sjtdxHnW;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HEvW8x3a
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4EQ1pC983403;
	Wed, 4 Nov 2026 10:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=AzOlhW3F+r2+cDMcRhcJIqg7UkfC1BPHz+b+Ewx1/jI=; b=sjtdxHn
	WSgZTGnkqPRu6aZ7SAFnEqkNOTwlluH/mx5K/UzaVkYRVyOfJFmobtwySQMTfx6P
	0f/aS3uHNTrW2QpxPHOYHk30GNpW1DCXMDsYeFhjQ9R7q7fjc7tUs1CBcrgVUOlE
	u9+zIkjcN8IFmdwYRqXTWKnhssB6LHb75RXFJR1a06VcspyJjeZP0bAInr0A2/s3
	h0wnOuJy2HujHtt2NbIv7Q+rx/U0//qK4JC1dACP8JfPIywiR1chJMENkLQMB8V0
	OzBMKdYkxMb2T1hjg52/iVJ549hSVIpkn7tFRE5T+1BLot13eV/x8LHgS7M/zpYr
	WcPTxbFxkbQlp3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AzOlh
	W3F+r2+cDMcRhcJIqg7UkfC1BPHz+b+Ewx1/jI=; b=HEvW8x3aZ2owaSsJIaSWK
	8m9ryExb/n+y4aoG6il5tYMki4QN4Yq4am+SxtcMxlvYe2Q0YFTF1L8qJDA2HTzt
	yVxEAHQmUdUMGRxAa6lSDhvw24F0rWZXzVzR03EpT8/WjmunpG6VwFWKNBfsom0W
	rHQWhL/4QJLVL9WasWGzx9ElXtctehUWz/HZy95g+jTjA3KIqosTwc22AJhkDDx8
	W2LwfARoIgxoqNTVzDC92DrOaxu4CFzk6Dt0vbvSaF2H+OLeHUQkWHTsO0pOCcdM
	tjpja2BP9GNnXDDL277vqDv4Ol0AHpIZEUJCjqK/91spsrKl1xYYHvlvPcDw4bxC
	g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hqkb264ua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 10:16:32 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz+AlLPVKeFS6Le5k9Zk76s0WL5q1YK0+BQg3XRpfyiflgy2QMqmQ9J9oa9Q88ebVC7T9N2WHHKRSFMTrSVbEXxAE9Un/QVzx+JXplLogfZz6zOQmxeBIXmlu/msP1yaJlPw1dO2d5Y8oc/MCjIh1d0vCXCr1LGH2V3ld1Nk3yVtiqNeaZMUHi3X+TMzyu+BfNNB5HUdBuHxuTVR38hJlc4dQpJ5cHW7C62n/rsYqmQffNT0hZVm1Clx8q1VPMPVBj0g+irYCFyptLjcnLIDTamFdEzMYHXQSIrFb1DRoNQo0+iT8MWZ3X/jdZqMubREkZFK627RKSeUfwJhcHggvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzOlhW3F+r2+cDMcRhcJIqg7UkfC1BPHz+b+Ewx1/jI=;
 b=JF2KX1ULEi8oSEa8DHOWppPGkujrsowP3/MibtulJvklPhKEBgDxyiyWPwMiIYp2W8GidXcArfQoumu6S7JCxJhlgt/1zMz1h+7maS6vJCZxSA7UXOkx0WMIOCfSXZ8RYQN94liep2a1jwn0J1vtR4sst5It7xrXlppoJB8YkOI1djNA3awvHt1wcrDUKcWvk9J+Fr51PfqwCeJaSCotJPBZDMERI/CZI2R7gSLnlZNBr+D1JdE9EFzWJC7B9aYjqv32CxAX9ztkILKcmNm8cZezUGLaYUUYrQ3SyCK0u3C1HfiqUjmFmmRY8/yIYslVN3rObeg2q3uI2n0IgQDLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from IA3PR03MB8453.namprd03.prod.outlook.com (2603:10b6:208:540::16)
 by PH0PR03MB989355.namprd03.prod.outlook.com (2603:10b6:510:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 15:14:37 +0000
Received: from IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9]) by IA3PR03MB8453.namprd03.prod.outlook.com
 ([fe80::6e03:3221:b921:9c9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 15:14:37 +0000
From: "Stolniceanu, Iustin" <Iustin.Stolniceanu@analog.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Schmitt,
 Marcelo" <marcelo.schmitt@analog.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "Regus, Ciprian" <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN
 Alliance TC6 support
Thread-Topic: [PATCH net-next 0/5] net: ethernet: adi: adin1110: Add OPEN
 Alliance TC6 support
Thread-Index: AQHda63FFPYRb0b+CkKBWRg5PRQUArcc0jKAgAC7AoKAAHXBAIAAAiOg
Date: Wed, 4 Nov 2026 15:14:37 +0000
Message-ID:
 <IA3PR03MB8453DA30566170E08238B1D2F2682@IA3PR03MB8453.namprd03.prod.outlook.com>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <49b292c4-c0e9-4b19-aa4d-d15dd20d25b6@lunn.ch>
 <IA3PR03MB8453F2E91946AE59A9818B9AF2682@IA3PR03MB8453.namprd03.prod.outlook.com>
 <c1747691-2c2e-4a7a-af04-92c94cb041b2@lunn.ch>
In-Reply-To: <c1747691-2c2e-4a7a-af04-92c94cb041b2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8453:EE_|PH0PR03MB989355:EE_
x-ms-office365-filtering-correlation-id: 8937e716-e91c-4dae-aa56-08df3a86572a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|3023799007|38070700021|11063799006|4143699003|261026121527099003|261021135927099003|56012099006;
x-microsoft-antispam-message-info:
 FvAJ7k51KI6ZKQquwPon7hrgh3hE2tDK3voxUhw3qX6Kpx/0lPSZDTskpOjMLO6hQxM4ZHW8AvVkqn1xTF/o4Mf0K6xf7m+d2uf7p9rHRSbWvs3q136faffQZX4LZQnyxTEblBCfF7ggYCh+trBJ1IXdbzeWpHuUFBBwVQXXtHUNrm96rti/W4zSqshSeK9HnauU/aTq+xC6Q9eQZcw8f4E16miG8/yLjUmXGs3gdBVTMB92GxBRBgCWoLTggdjCECo2+BKfY2BHyyDW85nNm4AaHATzy1j+TdZsBCQOAP+jr6Eb0I2LLluun/vJS8pIEdTvD5GK4yehUTksce5614dnoD7thIXcSp8D3QwEVCY6Y0C8dOUlOTE+IW8gCcRLtL0ql3uXwyCDZZsRSdRNmd3iAyyGBwCSR2+2vZ9lKs+xH/5m0q8LJQn9lklc7MSrcBjfPzF2M4ssDHIFJRY72akM+9vrJu2AarYkvOC6L9iUK2M8ADvpg2tnDi45qrAeOeYtwLz0Gxgd1ffq+0vQDsSHZkByWqNAVMH2+iZmWfC7RwiHfNqI78FLBqQmcUR/zyyDW6asb6COLWMz2n4SjeDWhnbM7QZrhvMruR3wwFz444aKz6/bxRD/7P5XAeiEB0i4FAAGeUK6kEOEhQwieGbAGWlIEjVrvC46adUUo8ba7vfy0b5mnuscr9xtq7FAS1t2/LqKvUZ5LeHINpUNIfy6T7ujYmXK+vjIo+o5JV4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR03MB8453.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(3023799007)(38070700021)(11063799006)(4143699003)(261026121527099003)(261021135927099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oQcZC7iKPvSLkT4dgFenc+iwJuWeaXqHg1QAuKFLakLypp6Hf4WaOEb8zf?=
 =?iso-8859-1?Q?t/iis4APxFNvTWHISmTQ81z7acCPo1+q6LIaOpfFfWJo9BHek4RyeDSPRo?=
 =?iso-8859-1?Q?6kcereYpehUOjfwXYAO/gEWPi7GXGQhlGFAeCNvHlVlOJocMQxwepmQfR9?=
 =?iso-8859-1?Q?zqYqQSNJdh66LgMFucwAMWGb/YxbmI6c27nivLiLhRwVTMAucZvx1dn10g?=
 =?iso-8859-1?Q?yrszlzzh1rYJskiu6NTUyDiotSA9+S95/TAwx+ThuivgpmJJZE9I2WoaDs?=
 =?iso-8859-1?Q?uS/nT5MVryaoHVGtEx6BWzf218Bo4vKlejeq+MJBgLRap18IC/7RBVoCzP?=
 =?iso-8859-1?Q?2FpPB2m7vvqAKFrRPxwQhNHix50a5l+wQM6kZpTtWJOl2iuPl85Arbb1iM?=
 =?iso-8859-1?Q?TQIk1lxR8fio+wp0rBhb1pyF0B6huYlQ0Fkz4TdbOTW1UwMaZ/AGBXpLBN?=
 =?iso-8859-1?Q?P1S0rIwyypF7QqK8CBylxBDiVrwYUTd1rDWVAUCpMe/mvlvGP1KZDH2poz?=
 =?iso-8859-1?Q?4RN0PVT7s77T1EO3/He225cngvyBNW7vBR9PGr8puLLYwVjly/YL8OQDJc?=
 =?iso-8859-1?Q?0k8yysnwTx8Ut9z8ixCHZF+UJV2w5IaufEQMl12c0LbV2qN8jktZ00UjJz?=
 =?iso-8859-1?Q?2CBuKZxxy9SKo/iTvsvKvDzjMMvxyC3/myNSuTYYWqRtIUv2CAaKzaVC6X?=
 =?iso-8859-1?Q?eNoApVz3wfss46fb2xqN6RlvKFLYUTbd7glCWoM7CuHXJRCyFTc4EI60eh?=
 =?iso-8859-1?Q?R482eGmfT/LBbHj6cNgaRCc/DtZt5D5RtFXK8lZ/ot+d7TXRb2AbSN3Exs?=
 =?iso-8859-1?Q?f0YNGAI0U0ex8m188b919kxGqxxwHoXAzC+oK+leRZMon3MMQh/keVUDUn?=
 =?iso-8859-1?Q?98lFJCeXuKPx7TSWSWABt6UVgNafQigKX+TbAlgb2iJEsKCVa5vGfENlJL?=
 =?iso-8859-1?Q?7imFhbI6MP7Wbb+ewGvYExX0avAOftXWsQxL1x7d4RxdPHHQ1pfWDjhPjL?=
 =?iso-8859-1?Q?ot8ZZpQvfevNCrDi2AJrMB0iIPd4fVndcwlrLyj6WyM+7QQOaUXL4nQZwG?=
 =?iso-8859-1?Q?xga3uPTEF1UmtLw4OFuy4vVVpVd9nK/bJEBPgKJh2Vtp4HqJol4q5ihklQ?=
 =?iso-8859-1?Q?Rwy77COhGETgF7aFCVvb0hov2v7qXpyptUNHtJL/2XOL0yDqfoXYVMfbe+?=
 =?iso-8859-1?Q?26Bouvq552LRCSrLtyAmoD5REFLs4m6835J9sgSRTk8rHVKDOndvcLCLVU?=
 =?iso-8859-1?Q?hiYQiEu7sRiLnSalS7VUX83bBdLKcpF9otF/faXk3J8yeoO0oTZRYgvlvP?=
 =?iso-8859-1?Q?VBUCU5ppDWiRJpm05sVSZJYi9yl6MrkJ8W0UOWxnFP/34nyCTiDR7je6I/?=
 =?iso-8859-1?Q?6/5PZxdx/BFUR4cr6wNBAcdeGqeJG4etKJRWXXyuAV6hrTSl8XdUHdLqKZ?=
 =?iso-8859-1?Q?qqxVtajt1Afztyv7FobwuqqigYtmWX02DFLojzFAbKq8HnZZnb7WzEFHDe?=
 =?iso-8859-1?Q?mGMQTxOngRWK2x+TKvFB3j1G0Fh0stkkGQ5ChoQvmnLjJNZj9UbiVloejd?=
 =?iso-8859-1?Q?5gKIv5+k+OMCfImrdsuSvi4CRO+oz1mHaLYAz7rR7MGajVp7mQ1B7LBl/b?=
 =?iso-8859-1?Q?0VLcaOsnRMRBjbGc9zbYpvsdMQfNwo3ZrOBPKvKmUxa/cO0Kp2Md8Bu6XG?=
 =?iso-8859-1?Q?7a4Jca4fDUb9oJAfutJrU9u4EAb0EQciAD3LRp82hLDLwmA636iSsTcFVJ?=
 =?iso-8859-1?Q?wOnvbokKTmMmWA6Kkd0kYv0G2Tip3ttm+zuKl1caxfzyanjnH34br6W5ZB?=
 =?iso-8859-1?Q?Jnvrc8nK1A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	h+G1Fny+lyaMwAMiqcB74UGQpiHGWx0CnYdDoB2Q+MkLoBBn5leEtSMi6hb0LPa1W5zTm1tqbjJuK7lothG6im9PYX+1Yz3jKJghIiyaxnXbZlUQa1idyXgQ+iKUER50Z7NlTsidG42H74kLyFhGuCvYyotmbz/bKJCW6P3TbaEA0nZsaogzj4Eb3VFdS/5U/6zXrR6o4PGcf+j9L67QxW+kLJrX+m39/M60YzBYwsqyx+/TZqeyO0Y47Z1I2kJSmxnMylBjIDy1JrWtxSFSh76RboaVSUjVUvgLpYcirsA1VjVIuMtKvKcdQwGQABlqNNPAOUiIPvCcukBjsckgKw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8453.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8937e716-e91c-4dae-aa56-08df3a86572a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 15:14:37.1973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: meH7yonC+7Gv05zcUR5VuXR7q9AH/mlSdXKqKlnHXN3DTcALPXAU9xVAp9C4w/XFMWUPxxwBzjKmqg5l32gb5VNYzLvLUI7S/pvurIOxHrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989355
X-Proofpoint-GUID: WoLaJrTsZiIaKLIJFdfz8ZJ9sAIi5Kfa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MCBTYWx0ZWRfX+xEjHAsNfxV4
 qVrlkFRHUYAS0bRAUEr2QksxGFBbzAfgPEF3XR+2cKwjX7LxCC01KebNTDnj7VTfGVAkZ8eldbY
 8MpUZJz1sh/h/uLt9TwCEe2iBUdkDoEbsX/0bAa8ul1VUQ5yJb+W
X-Authority-Analysis: v=2.4 cv=EOOTQFZC c=1 sm=1 tr=0 ts=6aeb4c50 cx=c_pps
 a=GYEwMlAgQavT3rNqZldEpA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=Jn2tOlbJ-nUxCgaAjYYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: WoLaJrTsZiIaKLIJFdfz8ZJ9sAIi5Kfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MCBTYWx0ZWRfX8lzSOpr1YGJ1
 Y/JqJlOXOgUatyOJS8cfXLLbG3jWSQ/mKOY7SdnOr1HajycXYdRjHY8J6gkaEPU171w6ljlBp8W
 5eAky6cfAeHjAE1aRXGi4cRZKlVcWcA+eoMDh3ViysIWMyXK6cUXUC1yJ+K4QnztAL20q7aFFSk
 ZrmcFCleLy+J3Ns8J9JwvSaADM+t/e8xSJtc9yIkyGMwnk8tzLv/3avIKn3p0THdqFxKICCz7Px
 v+WFhUFM/FyY2Ut/Hhif65IoQyKz2yPVhFV3dOqvXxxPDtpWVp3nEL5oWyLO03jJ6a4Twc8yOa3
 4iMrDx4VGls67x0a9JRj2ovVpJ2tM5Kllfxr4BFydAU2a+ugbOL4RxC1YkUMX7Fe1TsYtoecGZL
 6/E8aIhEHwRlPHYyGK/xto4rfMsecZqdInYEP24+0O6N3WpESYfIxU965xB+PrMIt4UUqCaTUkn
 70ej/43J4C7Cj7/BhNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040060

On Wed, Nov 4, 2026 at 4:59 PM, Andrew Lunn wrote:=0A=
> On Wed, Nov 04, 2026 at 08:06:56AM +0000, Stolniceanu, Iustin wrote:=0A=
> > No, not for SPI_CFG1. The ADIN1110 has no register that reports the=0A=
> > SPI_CFG1 level or the selected host protocol.=0A=
>=0A=
> Seems like a badly thought out hardware design.=0A=
=0A=
Agreed, it is inconvenient indeed.=0A=
=0A=
> Do you have an reference design using a jumper, so you can try all=0A=
> combinations?=0A=
=0A=
Yes, I do have a reference board and I am able to test all combinations.=0A=
I will check what the device does when it is accessed with the wrong framin=
g=0A=
and report back.=0A=
=0A=
> At minimum, it would be good to probe the chip, print an error=0A=
> message, and return ENODEV, if the property and the hardware don't=0A=
> match.=0A=
=0A=
Will do. In V2, probe will read the PHYID using the framing selected=0A=
by the property. If it does not match, it will print an error saying=0A=
that the adi,spi-oa-tc6 setting does not match how the board is=0A=
strapped, and return -ENODEV.=0A=
=0A=
If accessing the device in the wrong framing turns out to be harmless,=0A=
I can look at autodetection and either drop the property or keep it=0A=
only as an override. I would rather decide that after testing than=0A=
commit to it now.=0A=
=0A=
Best regards,=0A=
Iustin=
