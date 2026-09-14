Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF03ABD9F;
	Mon, 14 Sep 2026 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426859; cv=fail; b=oIEquFXuTWqICzBZGxuPrncUpsWZ0QK5IoSiT/0nAeV2Xa4YSNGKPzyWj59ytom5P6w4alsoOQ91j5nhqxaWZsQw2FinBZIy3q1SDACrT0KXg0qDnAvvUwJ0KIA7yXrXO+kC7lZlz7Y03fDiPFyzp3wXDxbPQ+pO64HVUeJgFwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426859; c=relaxed/simple;
	bh=h61CTxX8MHLwngY2S6C1E7yMNqdhp6pS9GdkoB5mXFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bO5KJpTtGtOiJLA4YswQBfGxJpNl0/tgVoigpsk8BnvpdMMTVPRwpDXM5vtZrC53bdJLZ9rnqsnU5wtRVLQV9p4cevgOc93hcyG9Xuqwzd3549B2QY1pe6sn4hbaoBeRvKfBUh59QS85VImoAfrMUYRyNSbKdP0AY6SBiUyByVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=LLl6YWM9; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=r3o0RH9n; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="LLl6YWM9";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="r3o0RH9n"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D6CBE1C6260;
	Mon, 14 Sep 2026 23:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=1E2eImVxLk4yBdGytFKW3/0mNJxa1QB2yNx2cx7Lfyc=;
 b=LLl6YWM9pOhOSegokyZUXJ9XzLoU5UMYgo25iEbFSK7S8soQ+FNBXAtGmE+LOqMvnLHVTiGtgu3i1zVSXDEVklUC+NTNnYYtgOTdAP0k+igBb2pST6PLGFDU3FCkqh9AKVYo9soC0QutIsLLZ5nrF6jGDQ/k1DTQQ2zdHSsQGr8MDx3h8sqzhTFIdtpxu66coXvHLVSYLNBRpdseFS+URg4s4RdXtYGjy6zArwMcC25kFeWoRENqAP9uDVpaHV1A+KXxFuuIx/VGwZO0J5JIzZT4QvU0pLMyoppv8RklkCt13HYu5W/gZNzlTawSLh+bBr/4zRglBf6qHk9kjkdBHg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021091.outbound.protection.outlook.com [52.101.57.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 0F2DF9000A9;
	Mon, 14 Sep 2026 23:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqharICvP7Wgy+NUMtKs8G/1Eo/3Aok8bZHWrsOoBXgKnNrDTUMHv3HG15knYY+E9/GiTG2O3LyEqp6XzDYBQ4mnslKLsAzdLmfTHZXQ5R9Yx6hap+TNO9hNrTzw643FUEOgnVaJ/wQg+9dHRswc67ywhJ3BvKlA9AwuJBRo9qdVD83to6Y898iAAxAt8c9cKjN032kyIjRxIlkLIuqANNU5YF83M2K+BOJZyDUhZByC3d+O3MdYwle1JRucze1u9KY8Ql5bMxPPRHSjAztJE9hDw8EVcWjw4Z4hvFIdY3gTHUvAShrwWqrSFihPc/j3sjlXUyByyFpqzEjbAuYIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E2eImVxLk4yBdGytFKW3/0mNJxa1QB2yNx2cx7Lfyc=;
 b=rR8BYmjWg1zFfMr13vS38LD+C3U6hVD+F+w4wawKkftym3XQJRP8cnFkxRiWddUaYpbv6I21eW+IKtbnA3UxQKwdUb4atNgy4+4p05UCU1GqjWNJeamb5wwSw8qMEnbXFbZYFT+PkH1fWsBX1ZXKzyrJVDqPLJUdSsY9G5JM/xGy+3QGksGnZXxPrRhKtlCQQsqMRbXueF6CFw7xzlGgVHTFJcyz8xltyJps6qfxswS2xXt3GHMIb5SIc1NMz8ao29fK7kDEbx0Kro/UGe/41YPQw6MJlpSj404bPf9+NklzpEHqY7QMRZwHWtebg8gT6D166oUXCZcQs5EJTMVOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E2eImVxLk4yBdGytFKW3/0mNJxa1QB2yNx2cx7Lfyc=;
 b=r3o0RH9nFxHdzLl8kHe049pRPpOkaVeyYlWpv6cPRFgbX7L1XFOu5cuv0fKTEpzt2NLzSfb/nn9O4FByxk9QxHc+vXm0Pjq6WOer4FkoYLgMiUWiz18bQLqqz/+ig8CcdmfkMnGtV/voiQzMoNU+dFNtA5ztIE007ONiiaVZm1fxRgtoyCCtDAZrpDCtLBX3huOtD2yszQcaP0f16ZKJE0OsetaqtNLUk9FPSufRK2dBFWJMYEFI9p9Fn26vAju9AnHJGxfPLs0LnKsPJveFISDUPpP1at7Zv4DOUo0ZQGPYghzQ58VFLI1aYcjrNh/q61A5O4n8tCK89zqyHZH7Nw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB7131.namprd20.prod.outlook.com
 (2603:10b6:806:3b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 23:00:44 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:43 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
Thread-Topic: [PATCH net-next v8 13/15] dpll: sit9531x: add support to get
 fractional frequency offset
Thread-Index: AQHdOyOxG3yjaFbvnkyfK1qvIjRTJ7bEqY0AgAoZ2oA=
Date: Mon, 14 Sep 2026 23:00:40 +0000
Message-ID: <20260914230034.63861-12-arouhi@sitime.com>
References: <178887152468.219967.5120035728263161680@kernel.org>
In-Reply-To: <178887152468.219967.5120035728263161680@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB7131:EE_
x-ms-office365-filtering-correlation-id: 087bb105-220c-4329-77b1-08df12b4018c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 nAR0ItD5lP2EK7Bby4NW6s93vDBonbIK2XSlPGqF/ZARvnyjfqwRjRMYfr5aKbRxGuNBJbAirAzF0PkxK2HrdkZZnWx9PAxnXrTOLNsM3qn2t/qHi5nd438ziWXYwwXKi1Z0QL3oZskeP6ccsPyTzEULtXjB0NKOtQ3XRKhGfeTFMHIXknEHBKSo9sQ24QMc86zKl3joVud3jFvQeFctDrUVSdYWaWvVDONYC08Zlc0GOxSBdGUDNh5gLcBeuND0je0FeeBwlDoR8HIPSqST7qBBuPirp3GKk3GtOMtxx+6Pn+Hzj9aRG0FeA0mGMkNhtb449hTjq+2o0BEvopLaE+3YcDf+e7+U0ZV9dIkb3Mq2kNoVjXMmgV+dTX0U0m9SnKCws4w5kjbRYHzTLfI+vM8c9vwdOb9uP3qduQFFKaOjeXrAnKMMmdn5GGxYb3sl0tx9GAb2mk/sekm+o7QKdEyohtHoAPFQnoNtXGX/cUy50txLQE/PHbUiLz3tBjgskCvKOrAdNpkKT8MnhaLRxuHAlWsg2i7mN8nuJeKW3Gx/UmovMi3eyCSt7srPyoYIPqmGf5bNjfDne50mRpNPGcnsJygQr2of/J+drMjXpJIRj5ataYjR/WXiC7VNgBreQzp0ud8P2Hbf5VqjqasJbD/E7BqMqvOAuT5GiwNwEXO+pfDmhnh0XrRDPivMrEWdDAf55uIUqRLxU6OOTKGJJH4KRxrKCSg+H0mpIYGrspE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qJfCCp7b+smUgJhK+yYNHdX2KtTMlmpUtteyYNJIJweI/lZh7leSc4Z5Gt?=
 =?iso-8859-1?Q?uUImSIXXfwpr1JYeyIfBosuhkdetO6qQO0qtq6kHl1jSvZHs69fzBPf8ON?=
 =?iso-8859-1?Q?xkuAV28c6AvleJlLjQ9UbrsveyFiyia65duSzUOPyaHd9yNwojP4w7qbvM?=
 =?iso-8859-1?Q?S5BOsmfEeEIl4tXG+5uIvc9S74OLmwsl/yGIyrkFk97958BESu4zusNShO?=
 =?iso-8859-1?Q?6MApnkB7Wju84D/IOhhKFjlUiZu7iOKXI7/YnfezkrJ6FZ5z2wY1KWHOkL?=
 =?iso-8859-1?Q?kcx+WevvhK2CgNERAzI8SR/5X3z9jTyl4Vcfmf0B4NRS7YyHZWMCdhY6J4?=
 =?iso-8859-1?Q?MYXK4gCX0z7OtQvvrg5sjf2HBM68yybgDsQlhvti6UL/tnW16HUTsxIsog?=
 =?iso-8859-1?Q?qBqRUWEFrIcYmP3k+kIq0MRvj2Js7bnAFRnIDA9YRwicDvLleP5TcrBZRL?=
 =?iso-8859-1?Q?5VrTJLYk00N2qpR6Jte0Qop0Pry6WJojmdEQ2P8oVdyMERKCoK21eL7qkq?=
 =?iso-8859-1?Q?5ceX44yE5UUwwJfh9ox4Jq+v7tVmkImAjr4U05z7hPfZJ+uyGL3su1taHn?=
 =?iso-8859-1?Q?g/WHuOfR0Ml1yoC75Kdb3zc3pP2gO3QsMU2IJInZQjBw9QPDDwRtP29z0C?=
 =?iso-8859-1?Q?L16JXKgnPQExKlrLul3cPm8Om4adV2LE+Hqrs4PKYzWmO6SUktSsSuQOgp?=
 =?iso-8859-1?Q?1n4+bkIcuV6LTLBqfRE+pdBLRXc7WQ/TDXLkHOLjwNH/9h1wFj9oi7McBc?=
 =?iso-8859-1?Q?KcLaZ26QeffhnF578YJG8JgLaUMQAk689J6TmQJIJX5DDHrvDrEgCIUV2O?=
 =?iso-8859-1?Q?1yKiruv8cFBUP7rIUAjz/MEqpugKfUvecP9ihkYsTS96Ba85Bnw+3gFgsd?=
 =?iso-8859-1?Q?XFG3oJ3aj2jZ3gkJC9/Cwn6HAtbVvbwQF6b/8RHW6ugc1ZU4RT3yJsC+7k?=
 =?iso-8859-1?Q?xXQslY0jTZCjkZfiiXRY7qk7VkFyUBafvlkDEgdfYvXNEDpPTnRtJBQINc?=
 =?iso-8859-1?Q?O09XalDU6FQqcVpqubkfq4PwPkp5W0VFpGpzr7Mqyga5316JFaRDtw6y9Q?=
 =?iso-8859-1?Q?9L0XKbLrxJyc6NUf0/wWJoLk6beV+P3ORZ+YrKR/JuZfg0eu3Boz7j584U?=
 =?iso-8859-1?Q?CL2qAFqqE6qJSwAUHyYdfGasqqgK/YeBMkiAueJC3ALhnJMZ1FIQpf46qJ?=
 =?iso-8859-1?Q?eTc/cCcoRyCWM5+/7fQkrtvZEru5kjL35lV4cZXc1uDsZQjk9/wgRn+koS?=
 =?iso-8859-1?Q?jP2tXJ0mn0XrEL7N6yTfT2nXjEflqfTRxArxpUQ3Ja51oIvKWC57RPoXu2?=
 =?iso-8859-1?Q?LEPhPCUlwNoADeDfjpHl6MxhwrE7HrixdH2+Jz4r7ClqAtrJvn1vSpnioZ?=
 =?iso-8859-1?Q?mjDVNPkI+h+mCEq2oDsUlVT3z2Sek2wXMjEUjZvVKdk4h4Ym4t/rxpdcVX?=
 =?iso-8859-1?Q?iELiqZM8FGEFj4lHQ18z7ibVDZFDwVoG2OgzjtvXAtd5yC81/hVJm3331J?=
 =?iso-8859-1?Q?wNZj9jAmsUUHbMgEfj11Cx9epjl7c+O9rC0M2ABo3WFDTn/xECOH6IFJm4?=
 =?iso-8859-1?Q?nirC/Hqx4aE2PKijv1zt50fqdPJn6+x7ZJBtcN8ljTqRC3pHc2yfIOA4hM?=
 =?iso-8859-1?Q?GI3EpWiZrVqOeVLyxU5K+kFzh2Jt+aFUySQiPLDQTdPyEeETodxrOaieAZ?=
 =?iso-8859-1?Q?ClaXlF9MJz9+tEjAFFibL5sslBEOEh/Kzq7iMBMdtNI9ElQk2G3aHDtFKK?=
 =?iso-8859-1?Q?hRk5pEAf5o4eYfPgTD1Eygixqwn5BFEPjSqyITJtuL2RHp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0fJUzA3oz7NfcCPNkcsUj22m7ZCR1cTNbI+erT/uFcAjhg3GM1xQGDM4O4pv+iOkNxcf5XrEGmip748+V6lKj6FbHJ//ib+m3+Vj246iSAdmk+aABEQQqlGzemsNNwr2z3+SLpqJuXhE3xnUrKy8LxdEf2SOiNSb1eLAdGdmjf6i3mXG6I2oIVTo1qCbDoNIfd4b0qeHLhs4yT5UkHRK375qijB8ZqlERPXUXbZtLPUjysP+CrBXrOUrnqXFtY839eEZhGMufbm5BpJ27mNTt+SId6pheiNWuanR/YVRtIFuDR2ShhZBYiE0RFdciuAJL+3lwuVmzyAdzHcRNvHFDw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087bb105-220c-4329-77b1-08df12b4018c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:40.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dpy2fKZcYkayGqevr4uvmwltNunPL4aBaFjTJETxiWkyzF3SLNltC4epPgMVxauLHqD8sjRM7LjpQ1sgho8lqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7131
X-MDID: 1789426846-UoG3RU-QkeGB
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426846;UoG3RU-QkeGB;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> is this comment block a leftover?  [names phase_offset_get above ffo_get]=
=0A=
=0A=
Yes -- removed in v9; the FFO getter carries its own doc block and=0A=
core.h files the helper under its own heading.=0A=
=0A=
> Does multiop_lock really give the guarantee described here?  [chip can=0A=
> switch reference on its own]=0A=
=0A=
Same answer as the phase-offset attribution on patch 12: the=0A=
staleness bound is one poll period, uniform with every other cached attribu=
te,=0A=
and the comment in v9 no longer overstates what the lock provides.  The=0A=
-ENODATA path means a misattributed value can only appear for a pin that wa=
s=0A=
genuinely selected within the last poll period.=0A=
=0A=
> Should this gate also require the outer loop to be closed and locked?=0A=
=0A=
Yes -- fixed in v9: the FFO getter now gates on the full selection=0A=
state (mode, lock, inner LOL), not on selected_ref alone, and returns -ENOD=
ATA=0A=
otherwise so the attribute is omitted -- the same shape zl3073x uses.  A=0A=
free-running or holdover PLL no longer publishes a DIVN delta as a referenc=
e=0A=
offset.=0A=
