Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342396;
	b=ynYXaYSzuhGFpJQ9cORiqKh3DmBAbucX+3yz+8nDCBrpmPBYa2nc1aI+WU9BVsJJrsHw
	 sOW5I1USTYBvQQO9BRV5QZw44cDSBG0hn0y9xuYzLI+m+KLrvFsPCjFR4x0jc17CFkLxO
	 0hIFgzOm9fCVN9e4BJjwn9ZDFHsdrIRnnDvpDkNdwC6rnpHALMn4TqtCHSm3YNvIeSRgY
	 ECNffRsRhVqr6D+6lVHqWPcE/CRI66V8jZwUMI4CmMdptvLltHiQmSoHrd2X7PzPPqgUV
	 3EDEjdnINxc0B5ofuIkRX6eshpPFxIzx6ycAFQ6p3+mHhMlFaoXsvpT6Mos4X7nRvrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342396;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MDID:X-PPE-STACK:
	 X-MDID-O:X-PPE-TRUSTED;
	bh=i+V+ddc2PESCdNK1cMLLM3bXLEv+AoAIAx0CVkw7ALM=;
	b=nQnSgkB5JcoSHqj4+sxeJZb+oue8yZjcfO/LiU6/uSF7sJEZLlZu/uDHZ7j/gBGUgadp
	 mF1dLCml0PZFZcbwswzvgKX6eL2RHrm6jw9p7W5H1xrLLSJNEpXTI8MBngCQ9/zU7Nk3K
	 83bfLcJSU5ZX4CFyts5CJNthOqjQntIyxMT0HfYUTtI93wGt/gpAiVWUZGMx45m9dwrsk
	 wBvikY9aTpFmsT8XXskxeuV1soBijpPh58E2B8/r7zNc448U0bcmjsUKgzBmUu6NQT+q/
	 zIQidW4FQa62ajmjVlIzeGQKAkyMnVZCmwrvgTdsG/5TvbtjCC1F+tHeSN+DB0nJtVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=WLczRNDs;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=q9K2WQn1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.48
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F22D606A326;
	Tue, 10 Nov 2026 20:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F22D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=WLczRNDs;
	dkim=pass (2048-bit key, unprotected) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=q9K2WQn1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=i+V+ddc2PESCdNK1cMLLM3bXLEv+AoAIAx0CVkw7ALM=;
 b=WLczRNDsZQfy1V6e3aS5WNl2qc6PGX+N2FqIeFXzU9Qc4iqRbmFOfXWfxkjdUermkEq6ZBty1xB8kyLCHKJMB9cTwIs4JFmM25SRG8l6cZfk//SlD9YMI4q+dM5zybjzTJH35inXeXTYgfFjMwB2l/PrhSUidhfMmgBVKAzdLWRU1LJjdLngNJwnFlSkIEJinFtYsTPk2yW6WMUJkLFXP9yMkOUPgaJs+msUQureae6JW54/4noLPAgpJBburD6QnfEH/ZZWAm8qY5Z9XM5RgrU7JuacU5j3aNb51+w6KYSkxs4YADFSBbKKC/SBAAVZgJGxeGAin8T7oafkVN8i9A==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021098.outbound.protection.outlook.com [52.101.62.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1B8F61C006C;
	Tue, 10 Nov 2026 20:26:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFAAJuF7oD6vmMXggyOutgOHt947p4pLioHjmHlzeVYaQT0pzApClVDnEoLkMLrbYmmc73LpCQ2dU7gFQGhRogLWwl5ZmM3hSHuaFSNmAL5DLsdc3wwG3eJJxOChH0sX8yPu5zBtJerFMGgpHwFe4dYQaCO9TEgGKH6Coy3u7EAX5jzm3iTgf7riZTiSC6l+WHZR0Xo0oNjaCPHmJ1hAVKCN842fYwVBN8Th6K2P+Hk3M9vGB3ZxPHTLTbyIaTWzPTCa/wO0w4QonD0N+yTcBkZ7tvC9bFyoushxwkWlQ4I1J2SLpssLzyzp3OlZmJb8eOEvaMzUJ1JZNxUFlTtwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+V+ddc2PESCdNK1cMLLM3bXLEv+AoAIAx0CVkw7ALM=;
 b=SUQ/+P4vNtQzozR8RhDI+dPEaOX0pIDVu9j6rxNFLZWf5erHGyPME3fGyz2vEKKz2LNbC+GoKt6EZqkFDkfc6TQ5NsjZp29v76dYTyzvAKdDB4PxIB3HMjzfnhP2CdfHi6ifuxcvUTVQwSpAL3g6dF307xOdRk9/YCFHn/sG5NwhKLIO4SEaDODRiGgsNZ0xQvU3N3hewqFgF3qKo+eh6eBi5TKdsSLuuaa+hv0A+8AxM2In+YzKDnXGBfCNyzvJdYV0OtLX/u9zQ6ZA3scZ17X2KyJwYMOOmGbL1o2GYEoNYR5dWhu1//YM7i1q0e+TCtsEqDtLVYNpMP0qP/GQYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+V+ddc2PESCdNK1cMLLM3bXLEv+AoAIAx0CVkw7ALM=;
 b=q9K2WQn1X+0gsBOJwDcs/dOPELkl+C3t/6KSqflFxvW80hYHWyosGszVVAesBdVroVPXbgio9YtcNvdq9G9nmb578ATtkg69Og0GFeaxcawHfqqbZWAk76qa8WLzGnkOI5bWn23O9VaNOYfhZQCEXvWnYG3qQCvj5PoMbWLHpmrd7RqdzGmFybP9USqPulTzxJBoPtvUfLzn9PiqTCZmPmEEr30OIDmYgJRYyoZNvEogszGKBE6jjYxRI+Hw7UpNk6omShjA3o5imHoH+/JdIDo881akZQ/MeW/k8i39lyBCvWUTmg+vF+wbEOKCAJLpGFJrWFhIJsRf+fj2Zk2PoQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB6205.namprd20.prod.outlook.com
 (2603:10b6:510:295::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:24 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:23 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v15 10/13] dpll: sit9531x: implement output pin state
 on a DPLL
Thread-Topic: [PATCH net-next v15 10/13] dpll: sit9531x: implement output pin
 state on a DPLL
Thread-Index: AQHdcVG8PcKy2YROfU62sz4zCf2FHw==
Date: Tue, 10 Nov 2026 20:26:15 +0000
Message-ID: <20261110202607.55744-11-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB6205:EE_
x-ms-office365-filtering-correlation-id: c2833a30-9d26-48aa-9cef-08df3f68e3ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|261026140227099003|261022075727099003|261026121527099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|10067099003|261102123227099003|5023799004|56012099006|38070700021|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 ADzBP3tnPvo7frRGNdNgTR78rPmUX00CHQHPJixBxt1E8Sjtc40tFxSUG5Ro6Vo71rjIkKgdYsn3Ob1vcAJQ/N5D4InFU930Wp6e0EeGYcsaMq1zcK6RlQUPHNWB5ZEh9kYb3Y0qrQL+QIsr04JA6Z3L9bwT1ULDtT4GBhYx6b6iElCyPuDP0sO4eLHHqXrsbiEg0xPPmn3mZoIYjY9dfAUmbbtRszgL45U2C+Yd6wwMFjHgjcqiaNy8J1eqiF+g76TXgWqHr+RlQyrFFdKk7LoGnDUV4T3+gpJtmcdB+A7iVaktW65azk0zDAMmF4GMX3QZWcgEJagT2Bp1wLO5jhVYv9dkhRuARov5sYBDUlkBLP4erngBnH1g7WvGRDBS1OC33VmQaKj648iYD/mkSEvX/Q02blReuColGHDxWcytnf5GyJYtU9l1X1A7JzJ0pd2ZQwBCXNHexzrEAA5gJ8vzUUj+cDvU5POrR7fXQjnL3MI9FeRwCT2JkwO8T2neGAOimpzJZ1U7RcGkU2bnmoH2+1LNWZ2zNk4wltASaeKAG5PeDCFdI8nmzjg3XZ/oqr3jjQ0/iwAj+5wcQhup7Sj4frTLYtimk5C79cNqM1Xw4KmtdVKp6VTAA/HVskTM/31ODuLwNqLfiWprHD4aEheTC1+TpZu5gmyKUjdrqMiK9/+fHJJlEk5NvlAyB9QseVpFplDFIYJWVG43dP2bhNsMXcvorHldmQAHy6Q2EKY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(261026140227099003)(261022075727099003)(261026121527099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(5023799004)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BcVVNgvLv95akeTrGZL6jgdQf5gBeS1qmSuHHhDQC3fyPpKsefS32/V1Uq?=
 =?iso-8859-1?Q?pstGQKmJg5ZN4zSCwx6yg2zPhDzcUMw9ItF1CQr8a/ye+QlNzf82Gt9dTf?=
 =?iso-8859-1?Q?2vCsK0F4xc8lXYnYAson186GXtvdibGsQgmhyoLedy53kwcOx6Cdm0qwWn?=
 =?iso-8859-1?Q?bS9cwq+wBz3mQyppBut/muVnpVG2jeCLgZh6oSVzd2ZLPdbSuvWWGEb06A?=
 =?iso-8859-1?Q?AWenb9hmcLjVCDLzrxHkN9ZKKo9Fwy0LUvuDPdyyWAu0YShYwNjp3/1VLG?=
 =?iso-8859-1?Q?NspZHk0K9AKUZQbM59QO6cend7XJmHn4g50CnD+8CWDNK2tVp2LY6qdAeg?=
 =?iso-8859-1?Q?rAhguVMEpBgRnuhyPnRe3Sxo0fQgMm//TQCyUHFO+GWep1oth51w/ZoS0E?=
 =?iso-8859-1?Q?SgtYdTZHcRjPrELI8qLRmsJvMArYTHuw0yTu5dQ+C1WsAD0mW2gFBfXL9K?=
 =?iso-8859-1?Q?XQfiC1iRPlSEaHIHRkNqRDyozmcrkndKRn2ZezhWFWXsJRWjP7piLmklfi?=
 =?iso-8859-1?Q?KiCHn7Tmc/WF5A6ih40xc7oSIsrYic7P6ne25VtVeQB4unObz+90id2seN?=
 =?iso-8859-1?Q?iayK1YHXA99nUEiNZH5sdX3ysDAXd4edAHP4kLfJbuzTi3aDStt8dfTGt/?=
 =?iso-8859-1?Q?XofcJwZlsbhiLxWdDZ6H6Ig1o9VuM8VEhDDRQpAlYRYCSAXweYFHoV6buN?=
 =?iso-8859-1?Q?Sfk9KRFn3CvsppOEeY6L+IZ2VK9KV2BcC8gmHNdGGw+12mK9us0N2PLvXd?=
 =?iso-8859-1?Q?CGx6MkwlE+JTxJkQ6aRXzJmt2YN1F3SVIC0tVIe6TejmQ1KM9h46VOzwVD?=
 =?iso-8859-1?Q?KsWpSZuffoUDclPRiYKFDIBwRB9AhLPsrBG40INWzBeAVDybPMNCEN4Y30?=
 =?iso-8859-1?Q?Jq9CkLf/nLu8/o/j7sLuWWcjphxHIrnz5uGCLH2iqyk0BhDRUblFUIZFy+?=
 =?iso-8859-1?Q?EUGaYxqrOWG21A+s+eR7psqmcwe9Xz6T0sXLr0f5UdAbYxqJ00vgmlA3f7?=
 =?iso-8859-1?Q?33X3b5YzLN3QRs6mgtJfMZkdna3hBacc+6z5phYUhO3oKkR7UwnVlD4E9R?=
 =?iso-8859-1?Q?c+7FpJqW88Qs3XYiVdHoguThsSglX6RH1QpW642nsRY8gWJxrelaUCFqfo?=
 =?iso-8859-1?Q?ERfLxUJwpiR55P0LsO0aVIVIIldhY3skI5p35+d4tN0GDInjbeI0fakssm?=
 =?iso-8859-1?Q?HvRydks99I4kMCUX8BFrn+iBXs3aLGctJd05Tu8azuBvIlHzpQMKHgO2V/?=
 =?iso-8859-1?Q?CRKFxENnvD8qFkoXtbjF/blaQdZd9IHj3vZouqENeDDLeq0DvU/x5N8Kf+?=
 =?iso-8859-1?Q?oBSozT8H7/3hX3SSLONU04GabtvchB5Ddsi8fs+t6wKStwrxWyJCT2YHBh?=
 =?iso-8859-1?Q?du8hNCqQ0XwyOG4mvzQKrLNF1Glp2r0oS/pss65Eon4yzr4gKwD1xOLmUu?=
 =?iso-8859-1?Q?dJUT+cS1oVXUmku6HdlZFbsVOllz5euGWXpVQv+MRfqQwMlUgZ191H3100?=
 =?iso-8859-1?Q?sxJTTWmz7ST1yJ1NCA7Gn52cf+x2hr8mMiKb1ibr+BTRwlcd2L8p8QU3bN?=
 =?iso-8859-1?Q?zlryfERDsbodqK+IsNfOzrzbHWTyItv4DcIsKQlrUKCDXNqcRyM3feCicT?=
 =?iso-8859-1?Q?eGbCjyMxzmxv41neFckPiW0M0UwkKRXIpHBaGFVbldnHB8mUx2DFll/KKE?=
 =?iso-8859-1?Q?Wjc3G53nTMu9ZzRqTWiR8MjaFxzvvWdmaKRURTT8N2DUMaseXARMBoSjqI?=
 =?iso-8859-1?Q?JtMhTZ25+9CK1BTDeJp+Oiqvbsdh74Nnt3/1nRB3phUhQt?=
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
	XzSmsuW2h9Z/eSFHj8Efp/jx9u+zz83GM1xxB9bGwf44EIvfmt1hiP3KCEGI5aKSUpjCfUwhKzKTHQLC4cSdUjPlreSxqqNqT4UpWMtemuWZGA5eJ/j6mGQv3K0EvRmKS8oJebePCqCxsXoRYeTtwB4ZPHmJeD1qDgbzfbiL/ssTnkx0jrzlESfbQ5himbIvzsRjIi0WdEun8f84CT8JvupJ8MRU3KMvsDmKPEnuZYEbEPxIN8+KlA/Gl+jAKhL2K4p8Zv9ALCH0As5sv4YRSmdC36oe5tLzu+v8w3EjZ0qFw9SyJxFHxJ18jre6BU/aJ9rna8PLJmzrwjuKGp/FLA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2833a30-9d26-48aa-9cef-08df3f68e3ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:15.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuwEPKbEzxqx0igtILHRYXb/bcqyYT/90/dW73QoddZLbJ3vc+aeOCXs5T50nKyMVF8jK9m7D8k0coi9fM41RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6205
X-MDID: 1794342387-V9pKwi89o06m
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1794342387;V9pKwi89o06m;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
An output's state says whether it carries a signal: CONNECTED while it=0A=
drives, DISCONNECTED while muted. Setting it forces the output's pads to=0A=
Hi-Z, which leaves the divider alone. Output pins are registered from=0A=
this patch on.=0A=
=0A=
A mute forces the slot's three Hi-Z pairs, differential, CMOS OutP and=0A=
CMOS OutN, inside the programming state; an un-mute releases the force=0A=
and the pads return to the loaded configuration. An output is reported=0A=
muted only when both pads are forced off.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 247 +++++++++++++++++++++++++++++------=0A=
 drivers/dpll/sit9531x/core.h |  10 ++=0A=
 drivers/dpll/sit9531x/dpll.c | 139 +++++++++++++++++++-=0A=
 3 files changed, 355 insertions(+), 41 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index c7ab33993c28..458de502bc8f 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -459,53 +459,42 @@ static int sit9531x_output_forced_hiz(struct sit9531x=
_dev *sitdev,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
-=0A=
-/* Close the loops and lock the debug block without committing */=0A=
-static void sit9531x_prg_abort(struct sit9531x_dev *sitdev)=0A=
+/* Re-read an output's mute state. Caller must hold sitdev->multiop_lock. =
*/=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev, u8 out_idx)=
=0A=
 {=0A=
-	int rc =3D -EIO;=0A=
-	u8 attempt;=0A=
+	bool muted, part;=0A=
+	int rc;=0A=
 =0A=
-	for (attempt =3D 0; attempt < SIT9531X_LOOP_LOCK_TRIES; attempt++) {=0A=
-		rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
-				       SIT9531X_LOOP_LOCK);=0A=
-		if (!rc)=0A=
-			break;=0A=
-		usleep_range(1000, 2000);=0A=
-	}=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	rc =3D sit9531x_output_forced_hiz(sitdev, out_idx, &muted, &part);=0A=
 	if (rc)=0A=
-		dev_err(sitdev->dev,=0A=
-			"output loops left unlocked after a failed entry: %d\n",=0A=
-			rc);=0A=
+		return rc;=0A=
+=0A=
+	sitdev->out[out_idx].enabled =3D !muted;=0A=
+	sitdev->out[out_idx].part_muted =3D part;=0A=
+	sitdev->out[out_idx].state_stale =3D false;=0A=
 =0A=
-	sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
-			  SIT9531X_DEBUG_LOCK_VAL);=0A=
+	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Unlock the Page 3 debug registers and enter PRG_CMD; output-system writ=
es=0A=
- * take effect only in this state.=0A=
- */=0A=
-static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,=0A=
+				unsigned int reg, u8 bit, bool set)=0A=
 {=0A=
+	u8 cur, new_val;=0A=
 	int rc;=0A=
 =0A=
-	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
-			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &cur);=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
-			       SIT9531X_PRG_CMD_STATE);=0A=
-	if (rc) {=0A=
-		sit9531x_prg_abort(sitdev);=0A=
-		return rc;=0A=
-	}=0A=
+	new_val =3D set ? (cur | BIT(bit)) : (cur & ~BIT(bit));=0A=
 =0A=
-	return 0;=0A=
+	return sit9531x_write_u8(sitdev, reg, new_val);=0A=
 }=0A=
 =0A=
+#define SIT9531X_LOOP_LOCK_TRIES	3=0A=
+=0A=
 /*=0A=
  * Update the NVM shadow and re-lock the loops after sit9531x_prg_enter().=
 The=0A=
  * sleep is the settling time after loop lock.=0A=
@@ -554,6 +543,174 @@ static int sit9531x_prg_commit(struct sit9531x_dev *s=
itdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Unlock the Page 3 debug registers and enter PRG_CMD; output-system writ=
es=0A=
+ * take effect only in this state.=0A=
+ */=0A=
+static int sit9531x_prg_enter(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+			       SIT9531X_DEBUG_UNLOCK_VAL);=0A=
+	if (rc) {=0A=
+		sit9531x_write_close(sitdev, SIT9531X_REG_OUTSYS_DEBUG,=0A=
+				     SIT9531X_DEBUG_LOCK_VAL);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,=0A=
+			       SIT9531X_PRG_CMD_STATE);=0A=
+	if (rc) {=0A=
+		sit9531x_prg_commit(sitdev);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Mute or unmute every Hi-Z pair of a slot. Caller must already be in the=
=0A=
+ * programming state.=0A=
+ */=0A=
+static int sit9531x_output_hiz_write(struct sit9531x_dev *sitdev, u8 slot,=
=0A=
+				     bool mute)=0A=
+{=0A=
+	u8 mask[SIT9531X_HIZ_PAIRS], state[SIT9531X_HIZ_PAIRS];=0A=
+	struct sit9531x_hiz_pair p[SIT9531X_HIZ_PAIRS];=0A=
+	int i, rc, undo_rc;=0A=
+=0A=
+	sit9531x_output_get_hiz_regs(slot, p);=0A=
+=0A=
+	if (!mute) {=0A=
+		for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  false);=0A=
+			if (rc)=0A=
+				return rc;=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].state, &state[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		rc =3D sit9531x_read_u8(sitdev, p[i].mask, &mask[i]);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * STATE before MASK: enabling the override first can drive the pad for=
=0A=
+	 * one I2C transfer.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_HIZ_PAIRS; i++) {=0A=
+		rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state, p[i].bit, false);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+						  true);=0A=
+		if (rc)=0A=
+			break;=0A=
+	}=0A=
+	if (!rc)=0A=
+		return 0;=0A=
+=0A=
+	for (; i >=3D 0; i--) {=0A=
+		u8 bit =3D BIT(p[i].bit);=0A=
+=0A=
+		undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].mask, p[i].bit,=0A=
+					       mask[i] & bit);=0A=
+		if (!undo_rc)=0A=
+			undo_rc =3D sit9531x_hiz_set_bit(sitdev, p[i].state,=0A=
+						       p[i].bit,=0A=
+						       state[i] & bit);=0A=
+		if (undo_rc)=0A=
+			dev_err(sitdev->dev,=0A=
+				"slot%u: Hi-Z override left part applied (%d)\n",=0A=
+				slot, undo_rc);=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	int rc, ret, state_rc;=0A=
+	bool muted, part;=0A=
+	u8 slot;=0A=
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
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	/* Read back the Hi-Z state */=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted, &part);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].part_muted =3D part;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/* Caller must hold sitdev->multiop_lock. */=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const struct sit9531x_chip_info *info =3D sitdev->info;=0A=
+	int rc, ret, state_rc;=0A=
+	bool muted, part;=0A=
+	u8 slot;=0A=
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
+	ret =3D sit9531x_prg_commit(sitdev);=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	state_rc =3D sit9531x_output_forced_hiz(sitdev, index, &muted, &part);=0A=
+	if (!state_rc) {=0A=
+		sitdev->out[index].enabled =3D !muted;=0A=
+		sitdev->out[index].part_muted =3D part;=0A=
+		sitdev->out[index].state_stale =3D false;=0A=
+	} else {=0A=
+		sitdev->out[index].state_stale =3D true;=0A=
+		if (!rc)=0A=
+			rc =3D state_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Procedure:=0A=
  *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)=0A=
@@ -2084,6 +2241,7 @@ static int sit9531x_out_state_fetch(struct sit9531x_d=
ev *sitdev, u8 index)=0A=
 		return rc;=0A=
 =0A=
 	sitdev->out[index].part_muted =3D part;=0A=
+	sitdev->out[index].state_stale =3D false;=0A=
 =0A=
 	/*=0A=
 	 * Each PLL page holds a 12-bit output-enable mask: OUT_MAP_LO bits 0-7=
=0A=
@@ -2854,7 +3012,7 @@ static void sit9531x_dpll_pin_unregister(struct sit95=
31x_dpll_pin *pin)=0A=
 	 * Clear before unregistering: callbacks test it under the DPLL device=0A=
 	 * lock, which dpll_pin_unregister() also takes.=0A=
 	 */=0A=
-	pin->dpll_pin =3D NULL;=0A=
+	WRITE_ONCE(pin->dpll_pin, NULL);=0A=
 =0A=
 	dpll_pin_unregister(sitdpll->dpll_dev, dpll_pin, ops, pin);=0A=
 	dpll_pin_put(dpll_pin, &pin->tracker);=0A=
@@ -2890,20 +3048,33 @@ static void sit9531x_dpll_pins_unregister(struct si=
t9531x_dpll *sitdpll)=0A=
 	}=0A=
 }=0A=
 =0A=
-/* Check if the pin class has a state callback, which the DPLL core requir=
es */=0A=
+/*=0A=
+ * An output is registered when routed to this DPLL, whether or not it is=
=0A=
+ * driving.=0A=
+ */=0A=
 static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll=
,=0A=
 					     enum dpll_pin_direction dir,=0A=
 					     u8 index)=0A=
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
 static int sit9531x_dpll_pins_register(struct sit9531x_dpll *sitdpll)=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 6b50b5b64b75..4f3f74ac8d7c 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -101,6 +101,9 @@ struct sit9531x_ref {=0A=
  * @freq: output frequency in Hz=0A=
  * @enabled: output is driving, not forced into Hi-Z=0A=
  * @cmos: single-ended; the CMOS pad Hi-Z pairs apply, not the differentia=
l one=0A=
+ * @state_stale: cached mute state must be read back before it is reported=
=0A=
+ * @ntf_pending: pin change not yet notified; the poll notifies once the s=
tate=0A=
+ *   is read=0A=
  * @part_muted: single-ended with one pad forced and the other not; report=
ed=0A=
  *   as driven. The driver's mute forces both pads.=0A=
  * @routed: mapped to @pll_idx by the initial configuration; an unrouted=
=0A=
@@ -113,6 +116,8 @@ struct sit9531x_out {=0A=
 	u64		freq;=0A=
 	bool		enabled;=0A=
 	bool		cmos;=0A=
+	bool		state_stale;=0A=
+	bool		ntf_pending;=0A=
 	bool		part_muted;=0A=
 	bool		routed;=0A=
 	u8		pll_idx;=0A=
@@ -281,6 +286,11 @@ int sit9531x_input_prio_remove(struct sit9531x_dev *si=
tdev, u8 pll_idx,=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx);=0A=
 =0A=
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_output_state_refresh(struct sit9531x_dev *sitdev,=0A=
+				  u8 out_idx);=0A=
+=0A=
 int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
 			     u8 pll_idx, u64 frequency);=0A=
 int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index a450a81d02f4..a32d37a396b1 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -184,8 +184,9 @@ const struct dpll_device_ops sit9531x_dpll_device_ops =
=3D {=0A=
  * NO_SIGNAL on loss of signal; QUAL_FAILED on frequency drift; STANDBY=0A=
  * otherwise. The routed reference is used because on loss of signal the d=
evice=0A=
  * falls back to another listed source and leaves the selection naming the=
 lost=0A=
- * one. On manual input select, the routed input is CONNECTED. The XO pin =
is=0A=
- * always CONNECTED.=0A=
+ * one. On manual input select, the routed input is CONNECTED. An output i=
s=0A=
+ * CONNECTED while driven and DISCONNECTED while muted; SELECTABLE is refu=
sed.=0A=
+ * The XO pin is always CONNECTED.=0A=
  */=0A=
 =0A=
 /* Caller must hold sitdev->multiop_lock. */=0A=
@@ -638,10 +639,114 @@ sit9531x_dpll_output_pin_frequency_set(const struct =
dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * DISCONNECTED while the output is forced to Hi-Z, by a mute request or b=
y the=0A=
+ * loaded profile.=0A=
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
+	int rc =3D 0;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	out =3D sit9531x_out_state_get(sitdev, dpin->id);=0A=
+	if (out->state_stale)=0A=
+		rc =3D sit9531x_output_state_refresh(sitdev, dpin->id);=0A=
+	if (!rc)=0A=
+		*state =3D out->enabled ? DPLL_PIN_STATE_CONNECTED=0A=
+				      : DPLL_PIN_STATE_DISCONNECTED;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Output mute state could not be read back");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Force Hi-Z through the slot's Hi-Z force/state register pairs: differen=
tial,=0A=
+ * CMOS OutP and CMOS OutN.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					   void *pin_priv,=0A=
+					   const struct dpll_device *dpll,=0A=
+					   void *dpll_priv,=0A=
+					   enum dpll_pin_state state,=0A=
+					   struct netlink_ext_ack *extack)=0A=
+{=0A=
+	bool enable =3D state =3D=3D DPLL_PIN_STATE_CONNECTED;=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	bool was_enabled, changed;=0A=
+	int rc;=0A=
+=0A=
+	/* An output is routed explicitly, not a selection candidate */=0A=
+	if (!enable && state !=3D DPLL_PIN_STATE_DISCONNECTED)=0A=
+		return -EINVAL;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Skip a request for the current state: the programming sequence=0A=
+	 * unlocks the output loops for its 100 ms commit. One CMOS pad forced=0A=
+	 * and the other not is neither state.=0A=
+	 */=0A=
+	if (!sit9531x_output_state_refresh(sitdev, dpin->id) &&=0A=
+	    sitdev->out[dpin->id].enabled =3D=3D enable &&=0A=
+	    !sitdev->out[dpin->id].part_muted) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	was_enabled =3D sitdev->out[dpin->id].enabled;=0A=
+=0A=
+	if (enable)=0A=
+		rc =3D sit9531x_output_enable(sitdev, dpin->id);=0A=
+	else=0A=
+		rc =3D sit9531x_output_disable(sitdev, dpin->id);=0A=
+=0A=
+	changed =3D sitdev->out[dpin->id].enabled !=3D was_enabled ||=0A=
+		  sitdev->out[dpin->id].state_stale;=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		struct dpll_pin *dpll_pin;=0A=
+=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set output pin state");=0A=
+		/*=0A=
+		 * The core notifies only a request that succeeded. Teardown=0A=
+		 * clears dpll_pin without the core's lock, which is held here;=0A=
+		 * read it once, as a set handle stays valid until this returns.=0A=
+		 */=0A=
+		dpll_pin =3D READ_ONCE(dpin->dpll_pin);=0A=
+		if (changed && dpll_pin && __dpll_pin_change_ntf(dpll_pin)) {=0A=
+			mutex_lock(&sitdev->multiop_lock);=0A=
+			sitdev->out[dpin->id].ntf_pending =3D true;=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+		}=0A=
+	}=0A=
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
@@ -703,6 +808,31 @@ void sit9531x_dpll_pin_baseline(struct sit9531x_dpll_p=
in *pin)=0A=
 				   &pin->operstate, &pin->prio);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Re-read an output with a pending change notification; return true once =
the=0A=
+ * read succeeds. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static bool=0A=
+sit9531x_dpll_output_ntf_pending(struct sit9531x_dev *sitdev,=0A=
+				 const struct sit9531x_dpll_pin *pin)=0A=
+{=0A=
+	struct sit9531x_out *out;=0A=
+=0A=
+	if (sit9531x_dpll_is_input_pin(pin) ||=0A=
+	    pin->id >=3D sitdev->info->num_outputs)=0A=
+		return false;=0A=
+=0A=
+	out =3D &sitdev->out[pin->id];=0A=
+	if (!out->ntf_pending)=0A=
+		return false;=0A=
+	if (out->state_stale && sit9531x_output_state_refresh(sitdev, pin->id))=
=0A=
+		return false;=0A=
+=0A=
+	out->ntf_pending =3D false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Send notifications for changed lock status and pin state; called from=
=0A=
  * sit9531x_dev_periodic_work().=0A=
@@ -744,8 +874,11 @@ void sit9531x_dpll_changes_check(struct sit9531x_dpll =
*sitdpll)=0A=
 		bool changed;=0A=
 		u8 prio;=0A=
 =0A=
-		if (!sit9531x_dpll_is_selection_pin(pin))=0A=
+		if (!sit9531x_dpll_is_selection_pin(pin)) {=0A=
+			pin->ntf_pending |=3D=0A=
+				sit9531x_dpll_output_ntf_pending(sitdev, pin);=0A=
 			continue;=0A=
+		}=0A=
 =0A=
 		sit9531x_dpll_pin_snapshot(sitdpll, pin, &state, &operstate,=0A=
 					   &prio);=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
