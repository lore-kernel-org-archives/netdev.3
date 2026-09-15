Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF4233924;
	Tue, 15 Sep 2026 00:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430434; cv=fail; b=bVAX1drH+tcnP2YvOK/lwAY9zWXdg9qOGoIgvzQDlK7ufFByP6e/x92Z8iyW/Cj4ORxpAUySy0rYujFUae2VF3nXw5zPb+p2r7K9DAhISJc8/HAuTAzE8l+v6sYj/S/iurvPnCQlwS5zW2gaZ0IDS8FAooTedczYRKFwC6ErjLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430434; c=relaxed/simple;
	bh=9CM4E8jDD8E5SpBna4lQYaTagmtmuqTsTfiD3kSBfnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wd8W1ycharGyWXA5j8c7bqWASvrARFmGTD0SCV+4INcDTCgj15GYp2U6JDFdcKkDkijbDBqwgV3V+RN0FBzix3NjGd0pgxzFtZmAUObFJadIIT9YYDLtejWroX1TEbPk0RRXmwa4fq8rrJuE29a82A6XIKwtlza4PXtGFckf49c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=lKvgi+Mg; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=oacEITiB; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="lKvgi+Mg";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="oacEITiB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ZQcIQ1aoy0pz7roiNVSRHt7QKmeUf3j1wlOT9dFI0Xc=;
 b=lKvgi+MgSRkl4iSwoXT/sTUD2HN2k0Lk8bW8ZOALc+mBa+GFVvp6ygjqMOVyQFDYFYPKiA1xIOe4mcYOj2JH1nmOdqImr2vIIDn5/ZzBHw0QsLd6xU/SNE3xtXNxlQW9J1Orvnz16FQffRoT/LfwiDtKBMZntWESx33HOzUK1wCTAcMqxftEczEjLeG2zIun4AHnxcvHubas3S8H3dbwRPVjQbG8DFuOI488oxf9MUQjr4qC4jj1iQ7Nmmy4jWEAX0SpMZfYbVFIJJ2hN+n7GUG3hdvha9ctxjIvqC60QYUrZIkxLnQGO9AM2t8/C4k6ZbZl5BSmFKmhKPJk4dOOBQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 97BF6100075;
	Tue, 15 Sep 2026 00:00:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H30qscbqtDEemRYMtDTuvmSCwca0nyXfirgVnaoeTJ9m3VzLZWwN6DWAVz6f4yV5z6ay6Uvu41I7d0YzZKHAd2yRkji/M9y9DEtFrKVSq7dCjDGFhglSxWwTWnpLhScyw6hDX9BUM03kp3NCC1GWDm1zGkM5L2QlAx6aHhnQuP4DrdMWFBEXO+ZXPrEPmlnmwXYi5tNvMDA4TKxhxVafU0GYmaFy8ORw/NT4UJ3a24nqWQ47zNcl18kLwRuFkJNo12WpOvZnlNO0BYOiLDPPQXOZwoC62tbQLZHkA210jMA3wBitOm9JCDxM9G8SbjrH/CKBlB86xOWN8SIn5yohsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQcIQ1aoy0pz7roiNVSRHt7QKmeUf3j1wlOT9dFI0Xc=;
 b=SONK/i/tcdd9RWHnVEu82jz/n8eTfzkP/7zXQ+0fbe1E3fNa4e7a25fEVbS2T0bwUdlHkWGsYwaL26HfkJiYaSH1aYqJFLx1O3xUPDlKbFxtcwmAcPXmsQewqACpMsOR8R8tCeKQNL9MrC4SIqtZdGPSaDo1n97MZIUrYMIKDRU/3DBWYo91HCWpaxMDP8omL7SxVVBPJoJYRQcdWRhipyh0UGGZNDT17ZtfiPLDdYPKeS+6Q7HzavnWO5Wqsh3H5VcvPBwxTDcfsaFkh66/D7Bft4/xzUWrsMQVnXm/HHZmvuuaNXNDdxOTDue0xepClLusxp2Rqnlp8EoKCVgNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQcIQ1aoy0pz7roiNVSRHt7QKmeUf3j1wlOT9dFI0Xc=;
 b=oacEITiBGV2cE1KFDRQoF1oc3FtdxVvLb0vb+JHcNSfoWZfVPG6JkqwcsXSziyvAKUsFSz40+tibsqTTlagHKZGS4Cyx6yKf2/zPb1JwrVaPTAzzpKAcrc+5G7aa8hwM9d/3e5dhYNaVwXJeEyAGqP6qEye19/UIMyteuW45qAvqQBA5h1m+ZQFWCzANkKxx0a0mz7Q5J2txW9hD4T4OdnM66Tznh23lZiCqY1/k3GAPzfh0STkGmPxAeqIJcW7ApMFN5jeYPJaabO9ScOAYZEKl/MeT4rJNJv+f+DZEXlKNB0VuijtuUWBEsKmLgW/I7zJFbqqTySjgYyDynpwD4w==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:24 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:22 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 07/15] dpll: sit9531x: add support to get and set
 priority on input pins
Thread-Topic: [PATCH net-next v9 07/15] dpll: sit9531x: add support to get and
 set priority on input pins
Thread-Index: AQHdRKUyb5Vpa2oZJ0mAfndxS1/vGQ==
Date: Tue, 15 Sep 2026 00:00:20 +0000
Message-ID: <20260915000015.80480-8-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: d8580ce8-a837-4cbd-b97e-08df12bc5666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|3023799007|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 r5PJKhicc4LosaQrXIxCqnqBpoh4nHLIULDpvpSKQDKpyd9ioW9S/3ulo8jDC3TYPrYJXUnFKvKftlmpisrW39HcD/U+tQqi4MnDXRjZvmotnAJbnYVeeeg6JBTl4VT6cSszRYrLPKD4HU3s6ISuOt6jumS1u3e5rMzHUolGfC/lYUbwtH6LuB7OVHeybQn+5mh/nqBi5JW7FeixMYDdU3FmdIe8RCtQ3gqMbhFtAFUkWSz2ihEIfQ1yQhpKBlFZPdUatVJH2G88NjoVh9PzwN4Atta5wuxwlXzWcK2wquOq/Qm9QU1mk7DxwuRy4tJwpRlrBTljqMiZCt0Fczwww9LWNjBY18PlLkUIEhIXgOJ/21rurSfdIjVycnMPl7cIlomKectQJc7eoKdE3HM1w91V4Enehg4AxOhfVHU/VVQy5D78daI9afJsq5x6L+oRj1eTXx2wF9Mbv3V2ljws0CQgntzsRhlWBMMeEQ5VelEJ61iqbbB4qkTjbsXUQGoiVsequQavUtrzGHKHZjiKxmM709IFmQJneOxyqh1GX8zOv1+4Q1yJIvB5sqkUfU4OMss5xaOHM25lahBGYaYDaco7XBcAGLRPMVluO+NUeRZa4xsdV9AOzmN14LlecPW3T+UQZ+M/KsStGDVW5eQ5WhJfVD0+wZUJ2o5OBAzVenNJF20fWXclVxEyRqAHLyDlrJ1udwYgOViU2tkziNRZ4LM0Dxbnclc8SQ0FupTu6sU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(3023799007)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xonUnUlUvB1Efem8ltHRoy+1j1EN8Ds5qSgBmjBYsrk84pU17pUVT9vdv8?=
 =?iso-8859-1?Q?d85EV+LZBfeQ4XLyh1g6NPEEf6/BFJ74c64wRIJscUjNLxRrev1OYeBGPj?=
 =?iso-8859-1?Q?H4pz39NxZOJoJh/xESdzjZg+jZC9JaMyb5kRNGdJtZDYZ4gCh6Ldl3kkKW?=
 =?iso-8859-1?Q?y3KD6Ae3C+TaBmgjUCKA/u7vi/cIGP2EvPx9mmE2MluYgIHXZy6EyKbZNP?=
 =?iso-8859-1?Q?mS1/MntwwXWV7rR4/5+PQKPe1MeQndYAY5UT4ElBFORnbay8TNYXY9Qe0b?=
 =?iso-8859-1?Q?y1BA0Wq15l0ZcWJOgOPJEhg0AKqs6VOYFfyPTrRPqiQTketeMeu78i3Z3P?=
 =?iso-8859-1?Q?v+yydHGtjhgf8k0izhWEinrWFwfI84/XAHO90tewPJHOjCLPwSYvlmZT26?=
 =?iso-8859-1?Q?ueHnLsi5yD2KvoYZjc2yA0uS3+9i9GxQVGZWATl2Au/FU/4i8FtrSlEg2B?=
 =?iso-8859-1?Q?6czskq4G7dBrFL2tWZonUi7Uprx4kqyF0cTjUiBf8LpP+1fyRrVkNoXPj2?=
 =?iso-8859-1?Q?f+QQjRRm8uA6hvTSRn+0rX6LyPNyiOC7QOe2vvJ1iL5+91xh5qBEW0sPKe?=
 =?iso-8859-1?Q?TX6ecd4XAx/exhIV1w+oF9FbApXysElMMlDtG7blqlB8Cs/de9T90mPDD9?=
 =?iso-8859-1?Q?1dXRGyY/yie5gBypS+1Oiq2H2sP4md6V2V9nudA4tsb85rkb7hbuvKLoEJ?=
 =?iso-8859-1?Q?MzxwpdgHM/DBaeNZO/K7vT+LPq5IB1jLz1FFmcfk3/OrnoGsVZfPKmNhWx?=
 =?iso-8859-1?Q?0X8zb1VAjt3k7ZppH/hvSxGxLvuFtaWrZyWC4/ecvMJgWJ3SABUJZJpD8c?=
 =?iso-8859-1?Q?x0TGaVnL4iJUeS1PTGVEEQEjgo2SN/HutbM/vaGUqXIGY/51cocY+aEMqY?=
 =?iso-8859-1?Q?LKTGlGoTuiui0PhD2F5xDfQOuXlHfzmCbIv25KlxxzoLj973j3lfJP+/At?=
 =?iso-8859-1?Q?q/On03/vuu5kjYoRHAqdQDgRiuceezJQNTgRkNE7Ke5lfVV3BUHwM7yx+P?=
 =?iso-8859-1?Q?twcTxeowHjiph58H1To0dU1Dh2aKTw/jSbo4giKftwS8+IINcMbFOiRHeV?=
 =?iso-8859-1?Q?IUQH3A42dDIs1DJZoRHqp+ma+4t/qcygaiZQMgYcKhvlN1CUb/Zde+reHP?=
 =?iso-8859-1?Q?5H72GKcgXVndSGa46vBGvF3S5dW3H+4wC2+DQ01xniG/VJMZDLJXEfY3tS?=
 =?iso-8859-1?Q?S0ZaJBADsVT+3vmGymb0aZa+fRM+jeSYeZIuAWpzSM59gveFlwOxQe0zTk?=
 =?iso-8859-1?Q?RlNyC4ej5GdvZmSk/G51mgSzVKUjfl36SpgM745EFyMnthGEhXDLRUWlHi?=
 =?iso-8859-1?Q?4YT69+Ju3Za5nN2+KCpAIfCRCRZ0s6rDQU+nl3qSx9kQBjQkssYqXUWWeh?=
 =?iso-8859-1?Q?Fr41+833EF/VvVCMRNbj2JXSWlJeSAPAythzgeMuTzIhsBGPDkOy7v+l3I?=
 =?iso-8859-1?Q?hZ+AnLaJ10yOG5VnDeHoXNBv4uKD/jTdN5lDUbdFNjvIpav30oNEx1crCI?=
 =?iso-8859-1?Q?wT1DzyKaxAFPjge4GjzQ3Ljv0Nku4fZ1qzHy9sh8bw5SItFxTmU2ArkKNU?=
 =?iso-8859-1?Q?UnyOri7e1A0hq1n8i/XefsLO4gktsKEQiTv4zS4XkPe9ZFJxMKsExFfUtO?=
 =?iso-8859-1?Q?ZgFtUQg1gNVM/WPZ/tg4hwz/Ey5bXRbeT3S67mGXZcln5lCFUp+IzOdWPO?=
 =?iso-8859-1?Q?qXTly1j6UY831WDgZ8sP2j6gRsgzmz6YpDQKv9GRxYJ9rSvWFCjksjl1Xz?=
 =?iso-8859-1?Q?rTuf0zSfH3WuX5cN4DdJzOYDWfEpWZZYMx+ctsAzob5N2Q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	s87NWDSC3Z1kJUGsN5Uue64wbnilEL/ZjyE3Brf6+PBiOiSLYqoW8bE1GcgPGGTyooRY8rBP5tjacq7Tk25A6wME2Gp06uLwaPVZ00+ujWuOhpWNajBdioo6c5+ilHmrL2WCq9VYnm3Oz+qK1uHnEBP8rPbCMdf7TX/dWXJ7wfb05iQfEgBTnEq+p14mX9TyKLhw1I19O4giKUcVKnUeZyroxYChAmkyIdU/NWTfK05T4RORvlts/GQeTR91BB50XCAxsC11whZPA4pNe3sPA5Ukhh4PUqRl8yZRbDat3/UPWoPbAa7SnZK0dqRH/jeKvLBFlzoQO0wRBUafTvUC/Q==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8580ce8-a837-4cbd-b97e-08df12bc5666
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:20.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5oiP6ihhK2NM3CFifNpg6kYJ3PbeRB/w6AVajHg4ptsas0/ING2GqPpBJ9vJv3lG7qe05UZRqyCCU9s7NvsrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430431-KWO8D5sN5Rom
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430431;KWO8D5sN5Rom;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The priority table is ordered: the slot an input occupies is its=0A=
priority, and the device selects the lowest occupied slot whose signal is=
=0A=
qualified.  Getting the priority is therefore a search of the table for=0A=
the input, and setting it moves the input to the requested slot.=0A=
=0A=
An input absent from the table has no priority to report, and the core is=
=0A=
told so rather than handed a made-up number.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c |  76 +++++++++++++++++++++++---=0A=
 drivers/dpll/sit9531x/core.h |   8 +++=0A=
 drivers/dpll/sit9531x/dpll.c | 102 +++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 178 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 25418485e975..484c94def578 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -521,21 +521,81 @@ bool sit9531x_input_prio_present(struct sit9531x_dev =
*sitdev, u8 pll_idx,=0A=
 }=0A=
 =0A=
 /*=0A=
- * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
- * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
- * from exactly the values the table holds -- here after a write, and once=
=0A=
- * per poll from the read-back in sit9531x_chan_state_fetch().=0A=
+ * sit9531x_input_prio_get - read an input's priority slot for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	output slot position (0 =3D highest)=0A=
+ *=0A=
+ * Reports the last slot this source occupied on this PLL.  The value is=
=0A=
+ * cached from the hardware table read at startup and refreshed after ever=
y=0A=
+ * table write and poll read-back, so pin-get reflects hardware state with=
out=0A=
+ * issuing synchronous register reads per pin.  A source with no known slo=
t=0A=
+ * falls back to the lowest-priority valid slot.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	u8 slot;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	slot =3D chan->prio_last[input_idx];=0A=
+	if (!slot)=0A=
+		slot =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+=0A=
+	*prio =3D slot - 1;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Refresh a PLL's cached view of its priority table from the source codes=
=0A=
+ * the table holds -- here after a write, and once per poll from the=0A=
+ * read-back in sit9531x_chan_state_fetch().=0A=
+ *=0A=
+ * The membership mask is what the pin state getters test; the per-slot=0A=
+ * copy and the last-slot-seen array are what priority get answers from,=
=0A=
+ * so neither costs a register read per pin.=0A=
  */=0A=
 static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
 				     const u8 *srcs)=0A=
 {=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	u8 first[SIT9531X_PRIO_NUM_SRC] =3D { 0 };=0A=
 	u16 mask =3D 0;=0A=
-	u8 slot;=0A=
+	u8 slot, src, src_canon;=0A=
 =0A=
-	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
-		mask |=3D BIT(srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		chan->prio_srcs[slot] =3D src;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (src_canon >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+			continue;=0A=
+=0A=
+		mask |=3D BIT(src_canon);=0A=
+		if (!first[src_canon])=0A=
+			first[src_canon] =3D slot + 1;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Assign unconditionally: a source that has left the table has no=0A=
+	 * slot, and leaving its old one behind would keep reporting it as=0A=
+	 * listed for as long as the device runs.=0A=
+	 */=0A=
+	for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++)=0A=
+		chan->prio_last[src] =3D first[src];=0A=
 =0A=
-	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
+	chan->prio_mask =3D mask;=0A=
 }=0A=
 =0A=
 /* Attempts to release a forced holdover before reporting it stuck. */=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index f628bd5b7a97..1ab8ebfd78da 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -129,6 +129,12 @@ struct sit9531x_out {=0A=
  * @ho_freeze:		holdover freeze active=0A=
  * @ho_valid:		holdover memory acquired, i.e. the holdover window=0A=
  *			holds a valid estimate to fall back on=0A=
+ * @prio_srcs:		cached copy of the priority table, one source code=0A=
+ *			per slot; refreshed together with @prio_mask, so=0A=
+ *			priority reads generate no register traffic=0A=
+ * @prio_last:		slot each source occupies, plus one (0 =3D the source=0A=
+ *			is not in the table); refreshed from the same scan=0A=
+ *			as @prio_mask, so the two never disagree=0A=
  * @prio_mask:		bit per hardware source code present in this PLL's=0A=
  *			priority table, i.e. the sources it may select.  Read=0A=
  *			back from the table by the periodic worker and=0A=
@@ -143,6 +149,8 @@ struct sit9531x_chan {=0A=
 	bool		inner_lol;=0A=
 	bool		ho_freeze;=0A=
 	bool		ho_valid;=0A=
+	u8		prio_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8		prio_last[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		prio_mask;=0A=
 };=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index ab9aa7db1839..e2ff21adfdb2 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -469,10 +469,112 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const stru=
ct dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority=0A=
+ *=0A=
+ * Reports the cached slot from sit9531x_input_prio_get().  The cache is=
=0A=
+ * refreshed from hardware at startup and by periodic read-back, so pin-ge=
t=0A=
+ * reports hardware priority without synchronous per-pin I2C reads.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll, void *dpll_priv,=0A=
+				 u32 *prio, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id), &slot);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	dpin->prio =3D slot;=0A=
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority=0A=
+ *=0A=
+ * writes input priority table on Page 1 via=0A=
+ * core.c sit9531x_input_prio_set().  Forces holdover during update.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll, void *dpll_priv,=0A=
+				 u32 prio, struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct dpll_pin *changed[SIT9531X_MAX_INPUTS + 1];=0A=
+	struct sit9531x_dpll_pin *sibling;=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 changed_cnt =3D 0, hw_src, slot;=0A=
+	int get_rc, rc;=0A=
+=0A=
+	if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-10)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	if (!rc) {=0A=
+		list_for_each_entry(sibling, &sitdpll->pins, list) {=0A=
+			if (!sit9531x_dpll_is_input_pin(sibling) ||=0A=
+			    sit9531x_dpll_is_xo_pin(sibling))=0A=
+				continue;=0A=
+=0A=
+			hw_src =3D sit9531x_input_hw_src(sibling->id);=0A=
+			get_rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id, hw_src, &slot);=
=0A=
+			if (get_rc)=0A=
+				continue;=0A=
+=0A=
+			if (sibling->prio =3D=3D slot)=0A=
+				continue;=0A=
+=0A=
+			sibling->prio =3D slot;=0A=
+			if (changed_cnt < ARRAY_SIZE(changed))=0A=
+				changed[changed_cnt++] =3D sibling->dpll_pin;=0A=
+		}=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -EINVAL) {=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Pin is not a reference of this DPLL; connect it first");=0A=
+		return rc;=0A=
+	}=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	while (changed_cnt--)=0A=
+		dpll_pin_change_ntf(changed[changed_cnt]);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 };=0A=
 =0A=
 /*=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
