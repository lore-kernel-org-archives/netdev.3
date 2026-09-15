Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB137A85D;
	Tue, 15 Sep 2026 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430435; cv=fail; b=pvQzMi8qbytIWHlJsqBaiKsnTtBmbMqez7KgXg/SmPa4uNx8qV6wEIRNQyfA+tdUhYNkjOh7oNYaBTQS+dVI4b4YV3Tp3yOvIUdFKjxCF18yPDqXYUbqoHX22GdtzjCxwTD4D1v0ffEZarBMvv5Zz67idP+JetJ8OHLnksvGEsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430435; c=relaxed/simple;
	bh=xRKzKNlU/g2gcvayJSyXJC4d18e1Q0sIlv48oN78+Kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rX2wySJiHOU2uIeIHBqBjvR1DwK4jKVq/VWioqrPJ/8QbTc5eqxfOYtmZexB8YJ+erNeiS2qVoD1G3xesp2q/2ISSN/KcRR9Bl17ePDLZRW4AfLqAiTAQ+gqlgIYY2M/uVVZ+s3Kuw6f8scQWhB+iFn+/TdtSTvSx1faUxMScXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=hizcicbn; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=B6HpE7XC; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="hizcicbn";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="B6HpE7XC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=IURuBoIdtAyykcZBX7GBCL06wGvldyg4J5ovwhcRN54=;
 b=hizcicbn7C0xSQmCvynLLXXAToiqUm+XWKhWvcnsU+J+3Q/uXcoxwuT00ABULkK0xn+Bj2Gl3h5p/Tte+6rLK1xi055WfMMJRrTy9ntMSb8StSBI3cvDtRABYZj++Gl4aK6oZKBgu5MjP5GcQg1DkQTD6vFFLO0jyuPgcZn0/WFwv2kzUQFhCYQEWsdTvSuVkZwED2di47AjNpArfb2sfxCKG9QvCqAcljMPC26y+SIgjOSBLqnJMKCNEkOQJSZsn+dNR0O/vtemirVIKeQG/8X0en6tC6BcKsn3GQPPMDuHj4QbEGNSKbtzNum3WqtLlq3mFUuYhU3gZ1wYLUoSpg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id ADA9410006A;
	Tue, 15 Sep 2026 00:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1A2km8+zSrZ9Z8zZ7Se1cwDNF5iN/MLNebmFnjnNs08lZbdHyPgd7uNFOIqyrEO/uuQqg1KdsKv3UuJV87k7LKQQN15kuh1gRYbez6Sii7rhDknGt5qAYePT0BGMZdzsIUNxlDIT14WYwTNfiKNFSu9Ip8iS80Ynu55DfUuiJZUyORk5H8hf3gyupU9RDqzd8rzedhPxpUZbOi6t2aDkxAIlOaM9EqXDTAVefotLHtVh+e2dAUJcdgQqRDd+Xo3FaoMAhd+S0mJlqX83lsdbVVzjW/A8PtEQ77OQFZMgcx229bOEAw2tEhrfwbuoTUha2tZWeFK0dffF7mb0J7WAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IURuBoIdtAyykcZBX7GBCL06wGvldyg4J5ovwhcRN54=;
 b=xuxU7ZzVuYj0Tml+Z6INJRm9slJT+YyfGVKRHwRAaQTSL+2nPykUAOGllvglKxcsEaXp8rGsSkVMY9lrakIYmXxPunPBznjK05zLMpcaIh1eX1lewnnXc3TL+ovRtZXY2ymXM8u6xJjZlwlNv56AUij2ItiIobogBq8k5CapJYTxHa9iOD64xvOioJIHIzB0/0aB1zoHzjlvuBByaWXEq4hV04XIFk84VN9LerBoPx3mDJEWEtYcOnmYbAG8/opWwLvM3JrI95Duj0+7hNP7zIo2bY/teZZpI2PvIvijBdUV/o6ghz31oFAwkFHZ2k/HmFA8vof/aP4JnE7Zkwo4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IURuBoIdtAyykcZBX7GBCL06wGvldyg4J5ovwhcRN54=;
 b=B6HpE7XCVBrdIUM2vi24JzPJN9Wh2LZXhGFpHBdq/zksD6p4xKCP35hS9YdhztYp75M6SniS85j4nbK7lXvIou/HBZEdh8sGNQmUTd3ZpFE6gJilQpm1FlEjqKx4s/537sULQBR0XE4KvtKA0cldxXFvD3MNJjOGvzrvqjmzPFi0FRN74YUjsiDnHGlUnjV4dOKRWp45hv+vcmeO2l+oZWXQcUbDlmPly0UVoNeApOMZgnvywVdZmBdJcNuX1wFR4lZvk4Z7ChIEuHOd1g2smxQ7ve4xKy2yKm4wP8+OlSMj37hARiihLIrBuF0EmLe5iQdZiM9AbcBYiyVJqLr6RA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:21 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:21 +0000
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
Subject: [PATCH net-next v9 06/15] dpll: sit9531x: implement input pin state
 on a DPLL
Thread-Topic: [PATCH net-next v9 06/15] dpll: sit9531x: implement input pin
 state on a DPLL
Thread-Index: AQHdRKUyXT9IMPH6lU2+DzaRibNoXQ==
Date: Tue, 15 Sep 2026 00:00:19 +0000
Message-ID: <20260915000015.80480-7-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 2821d38f-6703-475c-0d18-08df12bc5611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 YkQh4q3OPA/VFLp0XKlNXpDWYr0qrmrAXUO3ILikeucCsT3LPviHRfe0gL9O9zw0YuDJyqyCYuKXGo20wWJavAmfGX+/+x21zc8bRKrc3XW8nY8Chen9cWnO9JqX2f4FjHnbHOUq+ogQ0jrKtv/B3lErrPpZPyHHGyM50dDQxPbzNrFIvFxIbi48t9a8ot7JmoPLeS10LR98Z7Wfqhd7iP+bDCEo+m3BYLZtOlqqQZ5qIZhPs+WSA+1ervbDTqk0nApvaFiziPQc/Wz4xx5NyOmi6QcvrTHwPZbmCi1NgOBhopIJ5gtzfVaSMalkWp2T7SxWldktSD5AFLhOKMFXLye9kIjQwe8pqsdLvr3ZJ9PYCOjKsIJqvhMBq9ywtVWzW3Fkraxn+L8XYzlehoiWcEVvCfbFSireSO84//gEhHcPvZVcBsMB0zXePbdSxUO/d2yyiD07wfRK9HQFERfgdxAnB5O2oi8QQ0ggbZVsMTKrSfG9MZMSUqAzZFZ13BFC64rqme6hG9KOuBVtAb5w7lZCf7igNc919cSzk44n8IiKNnpd1aHhZynqm+qXGrkX4kEcjWDq0uI7w8qNRgjDmBMvQ9WC+IPUWm9DTm2C789MI3EnpmD9EUb8IWAl8NqLZqmh07XQNPfvjTQNt7n+zB6sNihV4kBTGdk1zbkKTdm9EFa7IBzuNHA3QhpgzSvzrXYBjClQYvXNnQ0bpQzJdPfudl8IXvhdmA4pjNxLK2s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ru1HlA67bdaMJSQKAv8kn8hOBdDTXPCX1nq/jGRjNK6j3oR34GvWzxwZ2v?=
 =?iso-8859-1?Q?GehpVB+FWlU+wA0Xehni9dAi2EFV1ampZfgo1G1KcjXRFRP8g6eVEJ7W6i?=
 =?iso-8859-1?Q?HiLeQHiOfqwXWdm1tci7/qJYLrOBIdkRrWt3/7F5LBR2gOT9LAyYzyz5HA?=
 =?iso-8859-1?Q?xIAnS6JyVgDtkQFMMvgIiKHW/BuX2jsHQ6/QJW/2GEizBsgbWIJmxXiaDB?=
 =?iso-8859-1?Q?4WwKZsdgtg7IxCY50V10zOubmximlPf2r58DJSZ9LsXD8OmqcBZRoaOYCi?=
 =?iso-8859-1?Q?Sd6tJQ5xTQ0SQFtLDQUqoCmWbOhNbPX0pjTiaHMbpg3HIe4ryyKzwElTdd?=
 =?iso-8859-1?Q?tn81T8BfNlE2uYygYnoJ7ZZHP/F2pStenG6MgUiFY9YiIdX0RH551K8Jxi?=
 =?iso-8859-1?Q?crHWUoI8Hz3R+Xm5Ly8Aher4zosGVE3GenlS6noW5L1KLnU0LSIEp7oNJS?=
 =?iso-8859-1?Q?xRsZO9WW3w2BPQYTtMbLOUwiCJZTxky2XELIegN9mc0d9Rq5/l/NSjC293?=
 =?iso-8859-1?Q?brImCl7eok0BrkuokepizXaqDunnSicJfglHJQn2LCJmMfkErAzkBL2Frx?=
 =?iso-8859-1?Q?NJLQI5Az01D6xfR8iEby+lBbwEwyofX/jJr0mXbM/U717jKAWqGHp21L6/?=
 =?iso-8859-1?Q?/9/GBpAmJs1Y0c5cl86IeyttWqTT0HP5taBSS1TdwK1reUSF7mKIpbhKK+?=
 =?iso-8859-1?Q?5aRuCVb/7gzfQcTHiJOiv6O/HNMRdhhEhJZPDFK4gVBf9p5D2vBHz++ecX?=
 =?iso-8859-1?Q?/+AEYXOqhOt4Rn3je+tL2gc27k1KC4gHjODrKdP3AUFsI5cBO0/M7vrjxG?=
 =?iso-8859-1?Q?tRXvHrehQu076Fe/ur1fOzNpGPaH/xL69soGlfwWOrt9KR8nxRGZmkXRU1?=
 =?iso-8859-1?Q?za4xeXDV2KCb0S85dRrWtt7cURfP7Re6cuJe3EbVWE8reA6XerDcSspkfl?=
 =?iso-8859-1?Q?eCqh8z64R8gor+GgIvyTDcQgk1+RfbQyyVPhfbUqPM7AAomsK51ENXDEqH?=
 =?iso-8859-1?Q?z0VggS8a4D1AgGU3ynN5luC2O43nmJnX3bnAzpY+2qN3IVJ5iAebX4dZs4?=
 =?iso-8859-1?Q?Ghhp+5k8PD+tXuCCjlXb4wbfussLVfzEyca3iU6E069pd9iNbLsffGngBZ?=
 =?iso-8859-1?Q?RP+e50Sa90oHAoHjwtmD/9zFFR94FDaEk+ylv4tneBEkUCGFth6Gq9wrlh?=
 =?iso-8859-1?Q?tsbD75HAIXcld8N07CGvF1GbP32KnIMncGezNb9Yd0yQzLHnWTnReNVMb2?=
 =?iso-8859-1?Q?bxB2hcqjzKM7yfjquUQTgjR6uezVTrQqKA5SUda/uNJVS1mgXSf+/wzH0X?=
 =?iso-8859-1?Q?6KnlkpR2TI4L3MzJBWZh8+yWAmujpK+PlKd/CJafNqpn3+T0tc1K8FEXvd?=
 =?iso-8859-1?Q?C/htFzzqfiAYSnJSi0l5m5DF8SxjQV1iFRN9wytN2arjbEhPJx68NFSiyl?=
 =?iso-8859-1?Q?6J1IlLEViEa4XFm6XAc64I43KR40y/xPYKgde8BewtnbwOHnE0baM/26pR?=
 =?iso-8859-1?Q?Ar9J1z4WZs7IWmi2eoDATYNxRLuI9sFsDcPJuys4MzH84eub67Ne87p9nS?=
 =?iso-8859-1?Q?fAblEs35x5kiSkvBxqcwIZo3XIPwzKFXtRMLOtZg4DNre0U/pdgimhDXmv?=
 =?iso-8859-1?Q?kEHNC2JhhN311M96UmCcsxWcXG73dKNFb4RBoI4oaXrUV4eVG04++4Ut9K?=
 =?iso-8859-1?Q?YjDcXBavH2NhF3YDyg4aBJXO7GvQPqGDU7IOJyC4gYWqMIQhxNIT/kLCTU?=
 =?iso-8859-1?Q?/etmD+ukxhf0qKAEuB0OYokUa8hSZhp6fV5Yro3+4N/wAk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RWnO/+oBmfeotKNZVWsjnONa/s022Qu144lxFL1AwZUNoEskdE1C0xwrtQv5Z/KcUMhMB4tVVHiaJqNIjFvDJlLuQg7DuoyTXbMoebIhZsE8B4FIKcJLth1mxH8oNZbnZuGgBaIv64z4b89sF5okCmR0TfGtcJuQujBKt4P12ml0x3FrLtjawMeJ9filo3FgsG1sJ/j8mbi4JlHwApfz17zCwoH6XXRSdC507bbDroay3zo7diNK5QDM5mVCuUWtdkdZJaRw94Btb96RLqVskpq7H4NGKj9TIks+sJ2R3QPofPp133sI2uCJ0nDn1unSrohgnb/tYjX7xvYvVCPL+g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2821d38f-6703-475c-0d18-08df12bc5611
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:19.7494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpJOkhFNrQie3setzmBMMUCDd6A5H8FB6OXNr4/V7HmGWuhlbmVsrg8aDTGG65I10Q6Wd6Ibj+m/vhyj1V5WbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430430-c4cKwp7AVdO3
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430430;c4cKwp7AVdO3;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report and set whether an input feeds a given PLL.  The device selects=0A=
its reference itself from a priority table, so membership of that table is=
=0A=
what "connected" means here: an input in the table is selectable, the one=
=0A=
the PLL has locked to is connected, and an input absent from the table is=
=0A=
disconnected.  Setting the state therefore adds the input to the table or=
=0A=
removes it, and the table is read back rather than remembered.=0A=
=0A=
The pins fall into three roles and only the first answers this question,=0A=
so the contract for all of them is written above the operations rather=0A=
than left to be inferred: inputs and the inter-PLL sync destination take=0A=
part in selection; an output and the sync source are driven by the PLL and=
=0A=
report whether they carry a signal; the crystal is fixed and always=0A=
connected, since a PLL cannot be told to stop using it.=0A=
=0A=
Rewriting the table means forcing the PLL into holdover, waiting for it to=
=0A=
take, writing every slot and releasing holdover again, all under the=0A=
device lock -- ten to twenty milliseconds.  The device has no way to=0A=
change one slot in isolation, and holdover is what keeps the loop from=0A=
chasing a table that is momentarily inconsistent, so the sequence is the=0A=
cost of doing it correctly.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 501 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |   2 +=0A=
 drivers/dpll/sit9531x/dpll.c | 171 ++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |   4 +=0A=
 4 files changed, 669 insertions(+), 9 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 6dfb1b31d491..25418485e975 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -185,6 +185,93 @@ static void sit9531x_input_get_regs(const struct sit95=
31x_dev *sitdev,=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_disable - disable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Sets the force mask bit and clears the state bit for the given=0A=
+ * input, effectively disabling it.  Register selection depends on=0A=
+ * the pair's signal mode (SE/DE) and the lane (P/N); the bit within=0A=
+ * each register addresses the input pair.=0A=
+ *=0A=
+ * Both writes are attempted even when the first fails, and the first=0A=
+ * error is returned: the force and state bits only mean something=0A=
+ * together, so a half-programmed override is not left behind on a=0A=
+ * transient bus error.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));=0A=
+=0A=
+	ret =3D sit9531x_read_u8(sitdev, state_reg, &val);=0A=
+	if (!ret)=0A=
+		ret =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_enable - enable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Clears the force mask bit for the given input, returning it to=0A=
+ * hardware default (enabled).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Output enable / disable (Hi-Z control)=0A=
  *=0A=
@@ -347,6 +434,92 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
 	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
 }=0A=
 =0A=
+/* Place source @src in priority slot @slot of a register value. */=0A=
+static u8 sit9531x_prio_slot_set(u8 val, u8 slot, u8 src)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return (val & (SIT9531X_PRIO_NIBBLE_MASK <<=0A=
+			       SIT9531X_PRIO_HI_SHIFT)) |=0A=
+		       (src & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	return (val & SIT9531X_PRIO_NIBBLE_MASK) |=0A=
+	       ((src & SIT9531X_PRIO_NIBBLE_MASK) <<=0A=
+		SIT9531X_PRIO_HI_SHIFT);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a priority-table programming sequence through the Page-0=0A=
+ * programming directive register.=0A=
+ *=0A=
+ * A small change update is all the table needs.  The NVM-bank and=0A=
+ * loop-lock directives that the output system issues do not belong=0A=
+ * here: the former programs non-volatile storage from the efuse and=0A=
+ * the latter only means anything after an escape to the PRG_CMD=0A=
+ * state.  This matches the documented input_priority_sel() procedure.=0A=
+ */=0A=
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(1000, 2000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Fold a source code to the lane a DPLL pin actually represents.=0A=
+ *=0A=
+ * Differential input pairs expose only the P lane as a DPLL pin.  A=0A=
+ * priority table entry encoded as an N lane for such a pair must map to=
=0A=
+ * the P-lane source for pin-facing operations (membership, priority slots=
,=0A=
+ * add/remove/set lookups), matching sit9531x_ref_pll_mask_fetch().=0A=
+ */=0A=
+static u8 sit9531x_prio_src_canon(const struct sit9531x_dev *sitdev, u8 sr=
c)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return src;=0A=
+=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return sit9531x_input_hw_src(index - 1);=0A=
+=0A=
+	return src;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_present - is a source listed in a PLL's priority ta=
ble=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ *=0A=
+ * Answers from the membership mask that every table write and every poll=
=0A=
+ * refreshes, which is what the pin state getters test.  The priority slot=
=0A=
+ * cannot answer this: a source that is not in the table reports the lowes=
t=0A=
+ * slot, so the slot value alone does not separate absent from last.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 u8 input_idx)=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return false;=0A=
+=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return false;=0A=
+=0A=
+	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
+}=0A=
+=0A=
 /*=0A=
  * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
  * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
@@ -365,6 +538,90 @@ static void sit9531x_prio_mask_build(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
 	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
 }=0A=
 =0A=
+/* Attempts to release a forced holdover before reporting it stuck. */=0A=
+#define SIT9531X_HO_CLEAR_TRIES		3=0A=
+=0A=
+/*=0A=
+ * sit9531x_prio_table_commit - write a full priority table for a PLL=0A=
+ * @srcs:	array of SIT9531X_PRIO_MAX_SLOTS source codes, slot 0 first=0A=
+ *=0A=
+ * Programs all priority slots (nibble-packed, two per register) for=0A=
+ * the PLL using the same holdover / small-update sequence as=0A=
+ * sit9531x_input_prio_set().  Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      const u8 *srcs)=0A=
+{=0A=
+	u8 val, slot, attempt;=0A=
+	int rc, prg_rc, ho_rc =3D 0;=0A=
+	u16 reg;=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=
=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(val, slot, srcs[slot]);=0A=
+=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+	}=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Latch unconditionally: slots written before a failed write are in=0A=
+	 * the table regardless, so the latch keeps hardware and the mask=0A=
+	 * rebuild below consistent with what was actually written.=0A=
+	 */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc)=0A=
+		rc =3D prg_rc;=0A=
+=0A=
+	/*=0A=
+	 * Refresh the mask from the table just written so a get that follows=0A=
+	 * a set does not have to wait for the next poll.  Slots written=0A=
+	 * before a failed write are in the table too, so this is closer to=0A=
+	 * the truth than the pre-write mask either way, and the poll read-back=
=0A=
+	 * corrects whatever a partial write left behind.=0A=
+	 */=0A=
+	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+=0A=
+	/*=0A=
+	 * Release the forced holdover.  Nothing else in the driver clears=0A=
+	 * this bit, so a PLL left with it set reports holdover until the=0A=
+	 * next table write on the same PLL happens to clear it, which may=0A=
+	 * never come.  Retry before giving up, and say so if it stays set.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_HO_CLEAR_TRIES; attempt++) {=0A=
+		ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					       SIT9531X_PLL_REG_HO_CTRL,=0A=
+					       BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+					       0);=0A=
+		if (!ho_rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (ho_rc) {=0A=
+		dev_err(sitdev->dev, "PLL%c left in forced holdover: %d\n",=0A=
+			'A' + pll_idx, ho_rc);=0A=
+		if (!rc)=0A=
+			rc =3D ho_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_prio_table_read - read a PLL's priority-table source codes=0A=
  * @srcs:	output array of SIT9531X_PRIO_MAX_SLOTS source codes=0A=
@@ -389,6 +646,208 @@ static int sit9531x_prio_table_read(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_prio_set - move an input to a priority slot=0A=
+ * @input_idx:	input source in hardware encoding (0-11, see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	priority slot position (0 =3D highest)=0A=
+ *=0A=
+ * Reads the PLL's table, takes the source out of wherever it sits and=0A=
+ * reinserts it at @prio, shifting the entries in between.  The rest keep=
=0A=
+ * their relative order: a priority change asks about one input, so the=0A=
+ * fallbacks configured behind it have to survive it.=0A=
+ *=0A=
+ * The table is what makes a source eligible for this PLL, so this only=0A=
+ * ever reorders sources already in it.  A source that is absent is=0A=
+ * disconnected on this PLL, and inserting it here would make it a=0A=
+ * selection candidate again behind the caller's back; that is a connect,=
=0A=
+ * and it belongs to the pin's state setter.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -EINVAL if the source is not in the table,=0A=
+ * <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio)=0A=
+{=0A=
+	u8 orig_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot, from;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	memcpy(orig_srcs, srcs, sizeof(srcs));=0A=
+=0A=
+	for (from =3D 0; from < SIT9531X_PRIO_MAX_SLOTS; from++)=0A=
+		if (sit9531x_prio_src_canon(sitdev, srcs[from]) =3D=3D input_idx)=0A=
+			break;=0A=
+=0A=
+	if (from =3D=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (from =3D=3D prio)=0A=
+		return 0;=0A=
+=0A=
+	if (from > prio) {=0A=
+		/* Moving up: push the entries in between down one slot. */=0A=
+		for (slot =3D from; slot > prio; slot--)=0A=
+			srcs[slot] =3D srcs[slot - 1];=0A=
+	} else {=0A=
+		for (slot =3D from; slot < prio; slot++)=0A=
+			srcs[slot] =3D srcs[slot + 1];=0A=
+	}=0A=
+=0A=
+	srcs[prio] =3D input_idx;=0A=
+	if (!memcmp(srcs, orig_srcs, sizeof(srcs)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_remove - drop an input from a PLL's priority table=
=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Rewrites the priority table with the source removed: the remaining=0A=
+ * sources are compacted toward the highest-priority slots and the freed=
=0A=
+ * tail slots are backfilled with the lowest-priority remaining source,=0A=
+ * since the 4-bit slot encoding has no "empty" value.  This makes a=0A=
+ * disconnected input ineligible for automatic reference selection, not=0A=
+ * just gated at the input buffer.=0A=
+ *=0A=
+ * Removing a source that is absent is what the caller asked for already,=
=0A=
+ * so it succeeds without touching the table.  Removing the only source=0A=
+ * would leave the table empty, which the device does not accept; that=0A=
+ * fails with -EBUSY rather than reporting a success the hardware never=0A=
+ * carried out.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -EBUSY if the source is the only entry, <0 on=0A=
+ * error=0A=
+ */=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 kept[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot, count =3D 0;=0A=
+	bool found =3D false;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) =3D=3D input_idx)=0A=
+			found =3D true;=0A=
+		else=0A=
+			kept[count++] =3D srcs[slot];=0A=
+	}=0A=
+=0A=
+	if (!found)=0A=
+		return 0;=0A=
+=0A=
+	if (count =3D=3D 0)=0A=
+		return -EBUSY;=0A=
+=0A=
+	/* Backfill freed tail slots with the lowest-priority remaining src */=0A=
+	while (count < SIT9531X_PRIO_MAX_SLOTS) {=0A=
+		kept[count] =3D kept[count - 1];=0A=
+		count++;=0A=
+	}=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, kept);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_add - make an input eligible in a PLL's table=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Ensures the source appears in the priority table so it can be picked=0A=
+ * by automatic reference selection again after a disconnect.  If the=0A=
+ * source is already listed the table is left untouched; otherwise it=0A=
+ * replaces a duplicate at the tail.  A table that contains only unique=0A=
+ * sources cannot accept a new one without evicting another, so that=0A=
+ * case fails with -ENOSPC.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 seen[SIT9531X_PRIO_NUM_SRC] =3D { 0 };=0A=
+	u8 replace =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+	u8 slot, src, src_canon;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) =3D=3D input_idx)=0A=
+			return 0;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (src_canon >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+			continue;=0A=
+=0A=
+		seen[src_canon]++;=0A=
+	}=0A=
+=0A=
+	for (slot =3D SIT9531X_PRIO_MAX_SLOTS; slot-- > 0;) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (src_canon >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+			continue;=0A=
+=0A=
+		if (seen[src_canon] > 1) {=0A=
+			replace =3D slot;=0A=
+			break;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (replace =3D=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -ENOSPC;=0A=
+=0A=
+	srcs[replace] =3D input_idx;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -1308,14 +1767,38 @@ static void sit9531x_dpll_pins_unregister(struct si=
t9531x_dpll *sitdpll)=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_pin_is_registrable - check if an input pin is registrabl=
e=0A=
+ *=0A=
+ * Split out so input-model changes stay local to this helper.=0A=
+ *=0A=
+ * Return: true if the input pin should be registered, false otherwise=0A=
+ */=0A=
+static bool sit9531x_input_pin_is_registrable(struct sit9531x_dev *sitdev,=
=0A=
+					      u8 index)=0A=
+{=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * The N lane of a differentially-configured pair is not a=0A=
+	 * standalone input and is skipped (zl3073x model).=0A=
+	 */=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_pin_is_registrable - check if a pin should be registered=
=0A=
  * @dir:	pin direction=0A=
  * @index:	pin hardware index=0A=
  *=0A=
- * Only the XO pin has a complete pin-op table in this patch, so only=0A=
- * the XO pin is registrable here.  Other pin classes are registered=0A=
- * once their state callbacks land in the following patches.=0A=
+ * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
+ * For output pins: the pin is registrable if this DPLL is routed to it,=
=0A=
+ * whether or not it is currently driving.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -1323,15 +1806,15 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 					     enum dpll_pin_direction dir,=0A=
 					     u8 index)=0A=
 {=0A=
-	/*=0A=
-	 * Only the XO pin has a complete pin-op table in this patch.=0A=
-	 * Other pin classes are registered once their state callbacks=0A=
-	 * land in the following patches.=0A=
-	 */=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
 	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
 		return false;=0A=
 =0A=
-	return index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return true;=0A=
+=0A=
+	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 5ead3811e14b..f628bd5b7a97 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -231,6 +231,8 @@ int sit9531x_input_disable(struct sit9531x_dev *sitdev,=
 u8 index);=0A=
 int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
 =0A=
 /* ---- Input priority ---- */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev,=0A=
+				 u8 pll_idx, u8 input_idx);=0A=
 int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx, u8 prio);=0A=
 int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index b4984335e6bf..ab9aa7db1839 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -288,6 +288,41 @@ const struct dpll_device_ops sit9531x_dpll_device_ops =
=3D {=0A=
  * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.=0A=
  */=0A=
 =0A=
+/*=0A=
+ * Report a selection-role pin's state on this DPLL.  @pin_id is a logical=
=0A=
+ * input index, SIT9531X_INTSYNC_PIN_ID for the INTSYNC destination.=0A=
+ *=0A=
+ * Membership comes from chan->prio_mask, which is the priority table read=
=0A=
+ * back from the chip -- not a record of what the driver asked for.  The=
=0A=
+ * getter runs on every poll for every input pin of every DPLL, so it take=
s=0A=
+ * the mask the worker refreshed rather than rescanning the table over I2C=
=0A=
+ * each time; table writes refresh it too, so a get right after a set does=
=0A=
+ * not report the old membership.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void=0A=
+sit9531x_dpll_selection_state_get(struct sit9531x_dev *sitdev,=0A=
+				  const struct sit9531x_dpll *sitdpll,=0A=
+				  u8 pin_id, enum dpll_pin_state *state)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	bool active_input;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+	active_input =3D !chan->mode && chan->locked && !chan->inner_lol &&=0A=
+		       chan->selected_ref =3D=3D pin_id;=0A=
+=0A=
+	if (!(chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id))))=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else if (active_input)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+}=0A=
+=0A=
 static int=0A=
 sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
 				      void *pin_priv,=0A=
@@ -300,8 +335,144 @@ sit9531x_dpll_input_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
+ *=0A=
+ * Selection role; see the pin-state contract above.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state *state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state=0A=
+ *=0A=
+ * Enables or disables the physical input receiver via Page 0x02=0A=
+ * force/state registers (sit9531x_input_disable/enable()) and updates=0A=
+ * this DPLL's Page 1 priority table so the state is honoured by the=0A=
+ * PLL's automatic reference selection, not just at the input buffer.=0A=
+ * Selection role; see the pin-state contract above for the states.=0A=
+ *=0A=
+ * The priority table is per PLL, so it is always updated for this DPLL.=
=0A=
+ * A single physical input feeds every DPLL, so the hardware receiver is=
=0A=
+ * only cut off once the last DPLL has released it: ref->pll_mask tracks=
=0A=
+ * which DPLLs currently claim the input, and the physical disable=0A=
+ * happens on the transition to an empty mask.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[dpin->id];=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(dpin->id);=0A=
+	u8 pll_bit =3D BIT(sitdpll->id);=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		/*=0A=
+		 * The table write, the latch and the holdover release are=0A=
+		 * three steps behind one return code, so ask the table what=0A=
+		 * actually happened rather than reading the errno as "no=0A=
+		 * change".  A source that is gone from the table has been=0A=
+		 * released whatever else failed.=0A=
+		 */=0A=
+		if (rc && sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						      hw_src))=0A=
+			break;=0A=
+		ref->pll_mask &=3D ~pll_bit;=0A=
+		if (rc)=0A=
+			break;=0A=
+		if (ref->pll_mask)=0A=
+			rc =3D 0;	/* another DPLL still uses this input */=0A=
+		else=0A=
+			rc =3D sit9531x_input_disable(sitdev, dpin->id);=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		/*=0A=
+		 * CONNECTED asks for this input and no other, which the=0A=
+		 * device cannot be told to do: it selects by priority and the=0A=
+		 * manual-active-select path is not wired up (see mode_set()).=0A=
+		 * Refuse instead of quietly behaving like SELECTABLE.=0A=
+		 */=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		if (!(ref->pll_mask & pll_bit)) {=0A=
+			rc =3D sit9531x_input_enable(sitdev, dpin->id);=0A=
+			if (rc)=0A=
+				break;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc && !sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						       hw_src)) {=0A=
+			if (!(ref->pll_mask & pll_bit) && !ref->pll_mask)=0A=
+				sit9531x_input_disable(sitdev, dpin->id);=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * Claim the input for this DPLL only once it is both enabled=0A=
+		 * and present in the priority table.  Setting the mask before=0A=
+		 * prio_add would leak the claim if prio_add failed, keeping the=0A=
+		 * shared input receiver powered even after every DPLL released=0A=
+		 * it.=0A=
+		 */=0A=
+		ref->pll_mask |=3D pll_bit;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Leave the messages the switch already set in place; only a failure=0A=
+	 * that came from the hardware path still needs one.=0A=
+	 */=0A=
+	if (rc =3D=3D -EBUSY)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Only source left in the priority table; it cannot be emptied");=
=0A=
+	else if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EOPNOTSUPP && rc !=3D -EINVAL)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index a892948da38d..da61a65ac2d2 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -135,6 +135,10 @@=0A=
 #define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
 #define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
 =0A=
+/* PLL holdover control (PLL page offset) */=0A=
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F=0A=
+#define SIT9531X_PLL_HO_FORCE_BIT		4=0A=
+=0A=
 /* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
 #define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
 #define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
