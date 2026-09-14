Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D329D37DEB5;
	Mon, 14 Sep 2026 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426854; cv=fail; b=aTbeV8K04KFKdeQAHdJYNKXl1uPDvtXFSwjf2UmZ3vauc75M0NiqipKvtJzYLg0CjZp1BjCEw821dOzAbF68IwAlHr+AtiIhUSvtcSPiPCidSAnD42DbeL3zD9VKQvf7mIxWdvRxW/C77+voRQ6Q6tt4Pjh4Y6318NrhosmR1qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426854; c=relaxed/simple;
	bh=NWbOTUjFUcD1i/Jkq7ZpRmoL5I3d+sWbPBg6a0e2fC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxQRv1SZEghoCDH6LKrnrYeYBFNOIlntWKuPGZ5FabA/xVZ3IOXURWFbwjsd/cG4ornnVipI75xIP42VgEU+YX9m/pl4CVD/9C8EP5WzAVQwHgVLIaM6uU1BV/Nuin6TpG+xoKQPcA1E2srPG+aOeAPt8c6NvJa6RJGq73sTxf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=i488+lps; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=lEIRggY1; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="i488+lps";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="lEIRggY1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=2dHPFmW/dYC1skfZ7HQBJQuH3oFT/7zJOhBQgB5Z7J4=;
 b=i488+lpsPyMNymybNmxhnbkr7c+C8C306Qp226ufvOi6n6XlzIw8eqU2xPR/jIwlMDa07zLXTkDo8JmnWPqyw0+8ol9CZi4fA9QqrNwMIU1Tti6uvbxqmflZRAeQgsxZObUrK0JTXuaZcPpVQn7uTnriL14RdlFB3Hb/ll9eGWrcNLc+MYiLS1UcSxG713xzg9R7Fx0YW1VbZH8e3U/LSqe9/Uv8qTiirKQ09FQb/XAdL3ahcVWr8sYQEDmnojmo4ayouMDXtuCpZSlY/NoB1sCUiEvI/Wxj77EFi+iPqccJ7mB1WJahaz4G4k/m1vpxxArG70zE4Gt/OqmfaonDsw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E8A3FA80087;
	Mon, 14 Sep 2026 23:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5kM8ImC+W0BGQUaTKt9roHKL9j/nRQlvre9aCEQVPOyYYmXVhmwaf+k+sG+Vfgx7M2tRbFr/l0c2OfYwEkPH6OA5nrcZkvBrYWVKePzp8iNU60ytpYBCF0TqBv/wSad/T8CTkrVozgmYYAkmp5kyTRDVoCS/c4zRB+UtOjURYGpW5PX6CLr4obSHyNa3+SgS3mMxvqSKSwtKg52JszGFXnUvLjWX140oOKVBuTha6HByYt6cOJ/qJxFqFoYURgXSpTRmMkaABMgoUZ0xo+yr/Se+1a/qj/6vn0xgnpVUjDABMwvWDR5ddKupVi1li8dmw8eg3ijyqbnDWD96eVVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dHPFmW/dYC1skfZ7HQBJQuH3oFT/7zJOhBQgB5Z7J4=;
 b=AVeEPGLAgyppBerdwhGJ1OUcN0Z/vfRGIwawByoKdgU6h0L6660GcU7n8mwxnvrso8IsyJYn4wZiwkaMEz/TFk1yPYd1fiUHQjJf+2QLT1CsYkKgNbSfGq2cNGMWr99qqezB5ex7JQH4DXY+QRKufaFIesa7cs5ecgq+g0CkgaMt1MnUErb81p4cpsrSg6Pbe1SvcPVGQ4gTzknGOxEXGc+oc4TfFiOSYtGOJkimMGAj3sxaFULzO56P/CA/W4ZAVL030mgS50kjmnOYQWO1NI5rYLGZWss9JOWCgxnl/qzghRCJl3r3jd4OMF6VWM+fnykBhFM3jT2Yzfo0V5nezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dHPFmW/dYC1skfZ7HQBJQuH3oFT/7zJOhBQgB5Z7J4=;
 b=lEIRggY1/06qg+GxRGmVAn3oU6TQkMWsqRo/WqO2+JwBc3UE2mKoZlucu64jZxG+aC7Hs/Sfw2EcrmwX2395hYsFTw1JYrhPFXoIXCeJRL/RmWTcGftSI3lHHn8wtE1mojxZBDKcCTlmeIgXLRe8gq25/wkEEtKAJO5ojaYXQG1MwJ4GgRYIm2YEsWgV+DeR2heL9lGNtUA6kGTltC7KqJoQqtHwZFLcCqnFESOzSd1TYMNlz2hfPekhH9HRwXxf7O1RcUJCfn2UaiLXr27qAVtpR8QJIepmBpDmMfsnvBLdF7OTiGB8k2xmikhW8QTHVK/aTOFrZLRLGOJwQkkXMg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:38 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:35 +0000
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
Subject: Re: [PATCH net-next v8 04/15] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Topic: [PATCH net-next v8 04/15] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdOyOu9Kn1vpfFikmIOKtsbMi1gLbEqX8AgAoZ3QA=
Date: Mon, 14 Sep 2026 23:00:35 +0000
Message-ID: <20260914230034.63861-3-arouhi@sitime.com>
References: <178887151271.219967.11606732852756839857@kernel.org>
In-Reply-To: <178887151271.219967.11606732852756839857@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 49514dc4-2ab7-4ff7-855b-08df12b3fcce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 H9sVAJ/TV6B0PARH8Xeenjrie/wcgHRW6xV7OJ1KW1sicRnBaS7uED4msmSh6mLEG6/ah2BKrz5WQM4VKG9OiaE6kfcv/7HDGLqSfPAUzAmBpdtCn+Yn0eXDU+TpFYLqkABimOevJce7/L1yHrP983i3Uw4zRSe2xMl2yD7FU/k69WA74vGpPc+uUd6LrWRqygcIBZL0amPqsXOqIejlMI6+xprr14m6dMqeTMOf33aJuIph8i/3clmegV5YCZ8/B+ELeBnUJDKh/AkUD5UK2H6ArY8lntq2YjOZTDFfK8oGd8Yhw9KtNvELjm2vmkiyT6x6Vl4TGO+MVmG6Vb+FOqT4AGopjy/elZZG1r66ynw8ijdsGI5dfkn8+fzhDz6a9AHEGMmUrGhDD+kVte25AEfVkSmABH7jQKHZBxvPh3BxZNWW7aNahykgjE69k2wlyX5zrxn2solDKMu8PmQsEbs0IGioemkkfPfAYk4zzQvsZ2WZLwu70J63hXQEHLpvQixaKzdMHR/Dzg2yFcAKFt5zaFh7m74eoiaBK6LbvAmSNgZA5wpS3os54UHL3Ox3DMAxemxWyueC84m9o1d/BEODu8YK6L1OkzYdb6dJ/7AiF3paghKR5/8wffcPF9vNk5WgLyvMe9v3zJeo1lgBeA4F8NBB19zPpFGqvp5pXW/M/Foqk3eWqVX0/tLaBFnNhWZOmL4LP0YPyVCiC1ydxX8WhlIrL3riXdzM2t3XSIc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xm7wI7h3pCZDYsor9gwgiuLVjwobch9V1MAeJA/t5zdgjHQYkHvNIFYeVI?=
 =?iso-8859-1?Q?Z0rkf3U1zBF4R9XdrYyJytpGBqrVzXumwUKWTz9IWckG81q0JY7YywMmzl?=
 =?iso-8859-1?Q?Ybj0kN55ibEPFL24clnFUXOf/+s12feT7rzc+s8ckFa3tQJsb/QMPiW6/e?=
 =?iso-8859-1?Q?gCaRP8BX1FsNSfmqci0FI+82TFpUnEOMHCx0x/Fx8DQgvJM+RSVC7fozjU?=
 =?iso-8859-1?Q?VcUow9JtmjzBHvGXxXkgLSPAiKLeZjQg2Q2w4R9BItYRTmI3uTSeWvRt9Q?=
 =?iso-8859-1?Q?r6604/BKUtXCkbNIoYBOLhZZK0kzf1C2ryw3RNXM+AgsRVJKtnJP2lDtWh?=
 =?iso-8859-1?Q?BtbX+ADG2gzfLyfSTIJHu5g2WH7PwRBwnb8Z3rVlE75fl/Bzjxvztho29+?=
 =?iso-8859-1?Q?/ecvBefl5SpV5ubuPtw1+rvyPV8ofChObrH8kTG5eTfuUU61irj7JoPAoO?=
 =?iso-8859-1?Q?Sbvdcoak2W/sPItMdjfKvTwG+yaoFbbhl8m327VyMHfEIm6+Zi5pqZ+ALG?=
 =?iso-8859-1?Q?Bjx7ZLwJ6fQompJ0elcTCEJtObhhjkmlSAjHTCcKv4heR6Ltlu+K6xeufM?=
 =?iso-8859-1?Q?AF+RPY87d0euxI20/iGxK+K8bg5DIXfIOp+wi2mx7HVdSzf+XZg2cQfl4F?=
 =?iso-8859-1?Q?Wx7uW3vFOIHcuFlBv4u876/HK8/ehELHQmw0bEhOVKj84R36LgAIHchC97?=
 =?iso-8859-1?Q?Xk2i4m/ONDdGAjszZP+j8dprUAH29bnWHaHGWlTujtTxCLkQP7enxvnt0i?=
 =?iso-8859-1?Q?jrWvNXO85jNAKpntoXH7UPa6QzOdV54kT1Grd7DMhi6cK9dHVMxj95m0iF?=
 =?iso-8859-1?Q?Do1ALguQBZTd4KNAO0Y7m0qSHDuwuWBMt4apC/snVqsVR42Vj6rDj0AvC+?=
 =?iso-8859-1?Q?6Xb32yXwcesSVAA1NJxL8FpRKEn0Apy7aYfsFg0WrAwM3qjtP6G0AXuzCZ?=
 =?iso-8859-1?Q?hfIOR90IeVe3aA+Xo2HlQkk6DqwxHAqEHsSelTkcNt5bCtki4yj/YvIGsN?=
 =?iso-8859-1?Q?wYq0tNzPvpsoKhwxJgosrSEtZ9lBYWYlwmPEggcB5BnQYxINM13bkWw5wA?=
 =?iso-8859-1?Q?M/xAlCpynj95Qtm+lIB4h2IN2lKto2QSamRM31mbX7HGIQ0/2aqisXKor7?=
 =?iso-8859-1?Q?Eysy3YIIt6XpZT2cghqd188W6ZAadC3HZCr+HFUh2GblEDP94Tc3YbR2GK?=
 =?iso-8859-1?Q?dk57mN4gyDSUW8SBiR7iotD/Fjzggc+r7COgJ/G1QXGkG71wLHHxhUBSR6?=
 =?iso-8859-1?Q?raTJP/HI+Lxit5oTnRwboeMoQcbRamhpf59v5izedj41wuy+PO79q6hxyY?=
 =?iso-8859-1?Q?FiRQXpx3vxGlZAmI9xQG5xEVnSi3RTO3NFfUMuEHeT8sc+VYtvtKqUeXSp?=
 =?iso-8859-1?Q?ZvdAhd8jqawg8VyMTkocUFGW3Ax+4Ur2cTjpw9Lc+tpQAZvvswg9sD2KEV?=
 =?iso-8859-1?Q?L4NIJ+34VtPl/bwuMzNfL7bMJbV530VOpDazPSuYJwAYzF61ODFDN49vhS?=
 =?iso-8859-1?Q?Hf+/OzsMzdVfr4Nusfi92jvWko3Ny23FUWyVL3vKq29tS6NG1wdklOnNFs?=
 =?iso-8859-1?Q?z28f1bxM0da99JyrXyunuBsDr+xSR3aVHLguscOonyHS89l+0d23xqf03R?=
 =?iso-8859-1?Q?83UzS0jAzAH13AgGbG3n/A2NBEvpBq/uzPOJ78Tm50Toa4BtGrhEHeWhaB?=
 =?iso-8859-1?Q?EWflCipWsoJ+WCsIr8hRyENF40ccQyMCtd8fJxy7joSo8uEjzvFIKtCkXy?=
 =?iso-8859-1?Q?dzA+RRb5sbRN6zNbIhFvpK2ltodPpZUVHLHY+VGuDDhIUY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xY+IBtsUIAjAKPQuM/8Y1gPeoGU2qrtEQbIT5+qcw1z61Wy1neVBYRFuZaOPzu1mnRDhhiIq7XwQsXlDjnUG8hiX9z/jydG+gP85yoj7+ddFeMmAuWZeZoGcqOVWZzaaVKCFQ8W2J0zgoJ7MuDuG16lv3sti/eF4hQQOneUJ3ELcEd28SPaIRWsDqGsUBPimKXvXcCiVLNVg4VALICQcj9E9UA8vnfpFPDMkW5ra1Pvq+tpNj3fyNsWTuK+6uoKXcUzEt6YaVukyGrvoSDphO6ixF7zdIf/KKQp5IBYfE2Mg0hB4/z9gyKRTWUSVMLcyy1xEepHU/J1t4ec2eLD+CA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49514dc4-2ab7-4ff7-855b-08df12b3fcce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:35.9416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7tNUHkTy5ZHr11db69g9zFhARddJ0TXQrwwoC9KjsrPv79aS4Ux4bqX2J6PBGhsm3aKH91VkSE9oIV6Z8T2Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426842-bUg7vsmqPukV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789426842;bUg7vsmqPukV;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> Does the XO pin end up with two sources of truth for its frequency here?=
=0A=
> [...] Would it be simpler to skip the frequency-seeding path for index=0A=
> SIT9531X_MAX_INPUTS the same way both INTSYNC pins already are?=0A=
=0A=
Yes -- fixed in v9: the seeding path now skips the XO index, so the=0A=
clk_get_rate()/clock-frequency value read at probe stays the only source of=
=0A=
the XO rate.=0A=
=0A=
> Can the "int-oscillator" and "synce-eth-port" comparisons ever match?=0A=
> [...] Should they just be dropped, or should the binding gain the aliases=
?=0A=
=0A=
Dropped in v9.  Only the enum values the dpll-pin.yaml binding allows=0A=
are compared now.=0A=
=0A=
> Should the return value of fwnode_property_read_u64_array() be checked=0A=
> before freqs[] is consumed?=0A=
=0A=
Yes -- fixed in v9: the return value is checked, the failure is=0A=
logged, and the frequency list is skipped rather than publishing kcalloc=0A=
zeroes as supported rates.=0A=
=0A=
> Does the appended catch-all range make the firmware-declared frequency li=
st=0A=
> meaningless, and does it publish a capability set the driver cannot honou=
r?=0A=
=0A=
Reworked in v9: pins now advertise only the concrete firmware-listed=0A=
values plus the current rate.  The wide fallback range remains=0A=
only for output pins whose firmware node lists no frequencies, because thos=
e=0A=
pins genuinely do support frequency_set and would otherwise advertise nothi=
ng=0A=
settable.  The XO pin and input pins no longer get the catch-all, and a pin=
=0A=
with no known frequency no longer advertises 0 Hz.=0A=
