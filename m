Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25B414A13;
	Wed,  2 Sep 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385268; cv=fail; b=rcTjIbVw8r51XQxqrcjuRW49ry2StpwqVWvfLBjM7e63dGwAwE8qaAsAlgtY0UlQmEEV367l9aVRwQG82uOig+P+XtfMOPYgGQiiFUjWC5ZGBuADl3ASiQURAd6RbLL1HeGPYfJe6cRBEYdnG+5t9Wxli9fhgdJbhn8MgHNOzOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385268; c=relaxed/simple;
	bh=j29FwoCzBwyK5ui/DEe9RzLUDS8MVWDQSBSS0Zo2ghI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxC7Ks0VsQF9idFseFNlZRa8832YscflTRYy0sCbv1WrejXF0BjQ64u3CIonnhIztBZ4S59mY8bXvdxOkqgAa8Sql9jtFBqYstQyh+1xUsuHJMcswOdQS4SkgogOKu2FWA8tcWvxSvwspP8ZeUOIssbCXrwd2Y3oHq7m/j7yqUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=gNQJ5Upp; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=0AL28s1o; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="gNQJ5Upp";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="0AL28s1o"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D4A8E1C96E3;
	Wed,  2 Sep 2026 21:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=FPfd4gshYfaU8o60l/bOlnEY1fLPNb/PUJNfUkzAe/k=;
 b=gNQJ5UppP2OLD+JnQSOzw5xUrBxPdvJoXaUwAqKyEK+lGVz4hHnW/gB6shWiJarrjtseRQIvYPRlabmXY52zM7qzFoCXbDXqJ4zbFi+naOJy6BfyLyl89VUVnDFNXKqmxVQWFxdvUYo1qPt0LBkw9w+HrLFHfphY47Krt1ZhT2yXqkClW3nroCZUUdwbhbKMR+Jea6pwXGxLADrJRDVQOpNJLwD27vnEeLG0Kt2biZGsF0KRESoqDtgwVvE2UyeY2nRu3ke1WcdLHNo7eiESm59sGDsthXWh4VdASBnX//ZfUp0TwKsBdl+9ghNeq8CJX5C/5CErTR2jmYs3BPVavw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8E17F3C0067;
	Wed,  2 Sep 2026 21:40:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UysKb+l3SmZ6kp10gB0q3UH/l9LBI5GjoT0Zv7npA5Ikysc97obJ25+QkWbQZu5U+zwz5DqjO2YxM/Nnk/OwKZsd8rsys4162DqM4Pet7IqRsUWxbYOLj9TvXAa2SQajkifoLGk19DzhOitZOWngRjpJzlej55YF0GbR6skxflHu4+9KBe60NlBiQEVwSPazmsW4usnJqSBsCKFNtctqgT/ujzw0I1u2VvKFmbua2KMMjHp90iX5zqCPCm6HhMn0w+qVvb+UC27ozdfVETUWszIHRS/CWf5a7ZnWrjb2lvrQPlXYqQhGJCGis7qQ9OboHxgoo4eDXC9z6hV4i1ib4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPfd4gshYfaU8o60l/bOlnEY1fLPNb/PUJNfUkzAe/k=;
 b=cQTeAIwoxpEPH+Gh1+3sb38aap48qQb/c6KLUWrvXF6+x8luwW0gpuiesBZle3sLwySA/Kk/3Et8RnyV2n9pDBwMXioH87NbHS54E2nioInkDSlwja1klGlVXckh04bAcb6D/+OLfKq4t2TUO6OMCxbgQQ62CjsXAS5obJNLfahliKHeM2iI8YDL3utVZTjbKercuTkgsmcYw6aqMBibmLhieCuURb6GvUJGOGkt1nclZ+vUyr6ILnZJYcmhYHZx0Q13D+pLOPY10CdnefYWpQFiAyVUC4frpYk6JGfoGOVXJXIFjpyzcmTXFuGQO8R6Bj4lcKMpUSD5VJgv7rsg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPfd4gshYfaU8o60l/bOlnEY1fLPNb/PUJNfUkzAe/k=;
 b=0AL28s1oHvU7rstgfw22ll7L8nhHQ+DotvhSuEzrAF+JZlQhiOoY9k8gRvEOj4X8EhxJg+0KovFGDPIaV9a1hdsbcPeoz4fRLQzyy4ShwmzbBqDBbn498XZK/bEahS781Vv+Aqf/4Kjlu+cvYaP5UZQhXJsdMok5G3JBib6gPdn5eZczzQ2xhxFMiOSMlpj0WNm4Z77/QFoIShxXR2q3Ksm6WnFqlGikLb+ir2IqrC/QH2cwUOrBSLV/wbRyinP2R7PBWs6P1euXaSOtVCbZGGBQTjBeIGpFpMa8u44YUWvLOugRYfDwSwN8l8K21i+bFuJoa9751+r2j4sO9NId/g==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:35 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:35 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 09/15] dpll: sit9531x: implement output pin state
 on a DPLL
Thread-Topic: [PATCH net-next v8 09/15] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdOyOw8Je2u6mSS0KzqzUNkg+/AQ==
Date: Wed, 2 Sep 2026 21:40:35 +0000
Message-ID: <20260902214030.20955-10-arouhi@sitime.com>
References: <20260902214030.20955-1-arouhi@sitime.com>
In-Reply-To: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: 57a1ee86-00b9-4327-899e-08df093ad2c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 hgwond4Cx7+jfN5e46P8qTDmsnWOob3+EtCqgjwmJjXe+FlLApE+9imdF/6ChA68X8OJwQOTquAuJbydNI0zdWtZTga7KtwVDwnLFBY8iZ1LMJTN4WSjPJAeWm5prcU/UCq8kk2KBfd9Q4w/54OPxNFE/sfiRNr/gG2nmqc/CSn5eNDOlBN0BDnK7gLitHs+l6Y2PBrgubYhYL/cq6Gr/TbIti96UJRmGGjs5B6yveXF5jpbFJ2i0Leb0XPihmfal0PyNa0Z4zzhakvnlWYeuAUU3mtfSQosqKYf1coyZKiFRSvlhoZPTCiQQlu4WO7A5meXzF/LWPR0Y6tbGtUbmh9edivMgVTpdrCh6Okgvf0bCvLuOGUdCmvDxIs/W6puoyew+/80tLi+ZPxWdnt9Ck093HfPb0ZolKwGScGhRZrCbVcsyRwgjC2ZUDXc0+IycjMHnU3yfWdr/s3EV1W0BwV8luMmBdixkQjTSlgE4yQ9uMPxQMqvwvdZF2+66eDUrSfpdMKIwJDKSg6Xq9Z+6YAXyemJTgx1dDWEvdj+i9j3wIIqGljBQTB8wZNuxxABvPUu9ICxxnBUZwrQHev5tYVjtX1r1I3MQr8v9qNDbmgCPLl8xf/kTputhxu503fnVMqwgTiqkK3ArcIWB+sf2uTL0Up/9v3etPsQrsGHMvb1F4qIB68oSVQrwjQwQdkza1xYdbA2g4RMInfRibYs5oH4g/ZAee02r+2pmPQbbwk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3gT6cJ5Sm1azJvvBghDfkPvC8miiT740radBpa8A354oOOGLh27XB9wnuz?=
 =?iso-8859-1?Q?hr/VDzFwE4snWEGanNlv19ZATmYcgbFKVrVngpMWGqTrcbBVc+ndSDSTlL?=
 =?iso-8859-1?Q?DcB4g17YPrQR2R0m0buLhdpf1k4SxQcUYSbtHsywRj5TnQOjkZJBr6x1ds?=
 =?iso-8859-1?Q?mBmayzgoOknXeaMLnER0pykCSm9V9xmNAT8txMmA2RVjNl/Fm9Wt2pJr4R?=
 =?iso-8859-1?Q?GbCuRHF/0/Us9C937jg6FjEgHwPoKRnFNMknbSdCoj6xp1gLE7dAJDd403?=
 =?iso-8859-1?Q?ldj2p42oVl/D3Vg1zkOWuZBJp5hQrjAZjYL5oQ1p3cnOGGr0VNMPunS8g+?=
 =?iso-8859-1?Q?6XwnGUrll1Ym1FF9RI2Y8tgBlVLkA5dLAqImsCmMG/ZyrgdXUPDZswvkBk?=
 =?iso-8859-1?Q?Ni3CZT8wPhUOi55v5fBmIO2/4ESNYHqb2w5RU/3SJ/60+rTSmDthDj4U+/?=
 =?iso-8859-1?Q?N59IKsEes5hxWTBXXkhp9f45+TxYf7WYU77UQ6uMmSX4o20ifwHOhbU5VZ?=
 =?iso-8859-1?Q?DlG2V6NTB6cGe9IfzW9zuzIzut4BFnMewzzRa5fv61Ri9Merw2JPneItwy?=
 =?iso-8859-1?Q?IhllECcgbYaKr9tDn4b4bXb/wc261k6Lhwl0xhIwjWRUrfAzwCToer+He8?=
 =?iso-8859-1?Q?kri+brPbpqlE9wj9F5YML910Bk56ncKeHk/6+hNAiRHODH5kdfE/BYVW6J?=
 =?iso-8859-1?Q?C773mt/2TCt9oostDLW4X7n2GAYvQqLKYqUgUYvAPkcIQiB5EHqvzq52bw?=
 =?iso-8859-1?Q?dpnlvSZtY8MfWXz4rZRLHLmLXpvaG+Gc/g1KNk3fd4cNOkpdMLobfbNvNL?=
 =?iso-8859-1?Q?U+vqTfmZlABErTCVmSc4xbDb6gxUOI10KA15w2c5Q0TEOT7TtlzZWR4Vcq?=
 =?iso-8859-1?Q?6gzD6VWnKKOYgkaLIBCq7KPBHi7EkY/LGvjS4+NV7N8V08K0haCOZnQ18G?=
 =?iso-8859-1?Q?toED3yPN3EKfB06HtZJH0FSQ6IkIcsWc66LBEUgGSw4xtqBoCB6nObVWGJ?=
 =?iso-8859-1?Q?N2LVmYSabo7Jie2p+1xs6egZ+zcqy6Sd1JDGwhb544ztiDfzSPVxsZ38a1?=
 =?iso-8859-1?Q?t/VsGezz3K1HiCkHxelrhzS9x/oRIzrUq6BPn2lNqZgx1ndlLZo/gL6JvB?=
 =?iso-8859-1?Q?HwrZuQTyJSm0GXv2hSMQN877ZGAvrOkRuj26yrJrX177kQeEWKsIeG2isC?=
 =?iso-8859-1?Q?YwesJCMC243IHTuaqcJ6Tub3Xa6V1YDDOeN4kAI00YJE3JJAkz1VmdGclW?=
 =?iso-8859-1?Q?mbV0IrSifdzY89ZvIJ693DEEsIJxZAG1MN/hJTSLKfsln9s9+Od5lUFxvx?=
 =?iso-8859-1?Q?UzRxpb+G0pkLBKQcenUee1V7Mn7q3uUrP3AzfsbniTq55O94Ct5rQhd1M0?=
 =?iso-8859-1?Q?smNpeZHj352JAA0BDQIjbkaD5eXxqG0JvCH9VnvX8LnQ8GViV620zzaSaT?=
 =?iso-8859-1?Q?zNZ/XZ9GWyAr01p/gLRTaFtWgkEVEHNGWy73Nh4QL6za6dwr9ZXNfpjyWH?=
 =?iso-8859-1?Q?FAFiriMhDLMAl4/61x5GPwOVzas2WR1cfCkv0ogLT6zPPXZXwNwz0lj8Vm?=
 =?iso-8859-1?Q?GzlDSKwFFMQ7xeMuYl8d4bcPzhdNG/TnNCJCssN8MkOzmAkzasrZcXk4nw?=
 =?iso-8859-1?Q?XU+NO2O8ToiXtu1w2GMLW2aHRTEbjUcbGe6W2OWg0VIJlElnYmbPZaDw/p?=
 =?iso-8859-1?Q?kVdE99SZmc77xJPFtm5aQSKW2OsBb3Un6F0hfAq6OUYrQEaoNsvQLcRsPC?=
 =?iso-8859-1?Q?CC9r82J0TrA9nuzq2407X63oBvxH1zmjWEAH9Pb4oOCqG4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DfM9MnVIHEbgXR5OfuAHwVHDdwSkuGh8fLMCMkff88ke71wJlRxlSsAYIdyu+dWd2oaxfUl0ozgJaOGaSPTVtiRNwKXrwpAya7j8OIRjdWGODp09vm21jwHgZw8sOSPewpNF8lkywK2VgzEC/cJxdKtPYzuCHp8B/SW/smHJomuuNhgZkTGUkyRaTsgB+7egmZSIX/UAJT18vnOIGMwFmLQLylVeAO/bm80hYWf6/98pR1Mq9RYpqAKqCkC+tVm/8HDFJ09gqVVeT4vu7LwBJp+kvbCPa5XqaGGlNEUND1vXovkt19o7jCGHBegtyC/OZ9kXXlV3hOor3djP/4j7kg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a1ee86-00b9-4327-899e-08df093ad2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:35.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndCN/Ru/hmVuWy/nSisUspkb4jP9iZTnrx+v1Ylw9FQRgJiVCx56WCm+HIJQi39mQZFWZF88ViAg3IVcfw4IKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385243-DzRE0IfktJyc
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385243;DzRE0IfktJyc;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 143 +++++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/dpll.c |  69 +++++++++++++++++=0A=
 2 files changed, 212 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 721b2c451d59..0f886cfd1401 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -339,6 +339,40 @@ static int sit9531x_output_forced_hiz(struct sit9531x_=
dev *sitdev, u8 slot,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
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
+/*=0A=
+ * Enter the output-system programming state: unlock the debug=0A=
+ * registers on Page 3 and issue the PRG_CMD state command.  Register=0A=
+ * writes that reconfigure the output system only take effect when=0A=
+ * they are made inside this state.=0A=
+ */=0A=
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+				 SIT9531X_PRG_CMD_STATE);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Commit a programming sequence started by sit9531x_prg_enter():=0A=
  * update the NVM shadow and re-lock the loops.  The sleep gives the=0A=
@@ -368,6 +402,115 @@ static int sit9531x_prg_commit(struct sit9531x_dev *s=
itdev)=0A=
 	return rc ? rc : rc2;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_output_disable - mute an output (force Hi-Z)=0A=
+ * @index:	logical output index (0..info->num_outputs-1)=0A=
+ *=0A=
+ * Sets MASK+STATE on BOTH the DIFF and SE register pairs so that the=0A=
+ * output is muted regardless of its electrical configuration.  The=0A=
+ * writes are wrapped in the PRG_CMD / NVM update / loop lock sequence=0A=
+ * so the new state is applied by the hardware.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	struct sit9531x_hiz_regs r;=0A=
+	u8 slot;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	sit9531x_output_get_hiz_regs(slot, &r);=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/* Take control (MASK=3D1) and mute (STATE=3D0) on both DIFF and SE */=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (!rc)=0A=
+		sitdev->out[index].enabled =3D false;=0A=
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
+	struct sit9531x_hiz_regs r;=0A=
+	u8 slot;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D info->num_outputs)=0A=
+		return -EINVAL;=0A=
+=0A=
+	slot =3D info->clkout_map[index];=0A=
+	sit9531x_output_get_hiz_regs(slot, &r);=0A=
+=0A=
+	rc =3D sit9531x_prg_enter(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+	rc =3D sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Always leave the PRG_CMD programming state, even on a mid-sequence=0A=
+	 * write failure: prg_enter() unlocked the output loops, so returning=0A=
+	 * without prg_commit() would strand the chip in the programming state=0A=
+	 * with the loops unlocked.  Best effort -- keep the first error.=0A=
+	 */=0A=
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+	if (!rc)=0A=
+		sitdev->out[index].enabled =3D true;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Input priority selection=0A=
  *=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index a7510ca721b6..6365a83e4c52 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -669,10 +669,79 @@ sit9531x_dpll_output_pin_frequency_set(const struct d=
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
+	const struct sit9531x_out *out;=0A=
+=0A=
+	out =3D sit9531x_out_state_get(sitdpll->dev, dpin->id);=0A=
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
