Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793649757;
	b=gIHC4+dnRlSXFoAnlWx9yM0gQBtWqi0WL8+If6acKbE9v5VbA6pb4V7Z3XIJEtus3IBR
	 dT4N057LIvuYCNiYoP5qnRiuytX4hZnnTvMvJXImo/UBz1WOPmO1Eq68l+H1SZrueUJcP
	 NMbkocjwdWVnDz5ofCjXKJsX5wUtX7xIfAJGGAIRbQ5nvV4DDT7Sxd4jJKuqUStS3TZTU
	 gFpxRuKyLDc1SaLUBPw+DYiJ1eKlptdOfZFaZtFws3iv9uTKkNI3r8zET9FWVfgAqco4C
	 P0zQZmPh2WaNoEE7y5UhW7UF9yAfXrZs9iu2uL8rYnEdY/h0WIAt2xcoSIVpjUaI45A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649757;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=+Dzq4QSfG/H0QLSXmG8ieKXlzaFoUjiLWP2c53EsZf0=;
	b=mJktIQBdDMdD87cWHrpNrUK1FwQQQ5/WA7Eljs6nxqUqAbMSoVBXx2vyH/tsWS5Tl+IO
	 EAPnkslbF1YQYWpJ5rgGyxQFetzxjvhX1BhvVkoYgX6Mlv4RGqj209z8yYoQed+Vs0TuU
	 WFnRHEZSu27VM1jy+9eNwNrS/2j/TI5see4rcz/9+ljsDscU6OqCoVTeiCDAZs4zDR8Me
	 zf6dCm7qHtuUVjw9kraynuIwDlKccqC4cjYqU1cjnW7EpkveS+EmIyUvt8pDLdSobEdB2
	 m2Mg/gHAuXePEukGuS4fWl8L43DJf8IyHZE0ckp8JO1E2cXkoL5BNK2nS1931/JLLiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EimB8Cbc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB35606A326;
	Mon,  2 Nov 2026 20:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB35606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EimB8Cbc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793649757; x=1825185757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Dzq4QSfG/H0QLSXmG8ieKXlzaFoUjiLWP2c53EsZf0=;
  b=EimB8CbcLqGctyFbZ6kkd9k4vDBnHFZD0Iz7ho8BK9yTr1nHJDAywzRg
   rHQJBPrL+5M3IrPAUFVKHvK0pzHzVTyhj9u/bJdC6bj/+mY+/N0yVL0zS
   l8hs3hgTPNRrqbyG8WmFiwP6YE7oDRTKD7NFi1duVWK7zHG9J4K4gF3ge
   OQH9r1yTxYNUFFRTul2YN0NmGJ5OaQDhLRPBOdftAI6I/DrVpC2cvh+Vy
   NFn9jLrm5vCfSLpWHdkGLMjbR7MZtNYehmoW771p4AkM4hIZidZSxoyqk
   ibqXta5T/tYER5UQwTYqa3xaYVCaEUQvvH90SFCjBByjwoOc1kz0htq/p
   g==;
X-CSE-ConnectionGUID: xPXTgeXiT3KbAg1obIq9mA==
X-CSE-MsgGUID: +pXwfJN2S/28YoRbZ5pk9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2261666"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2261666"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:02:23 -0800
X-CSE-ConnectionGUID: ASCYsg2jQfabzut/mNl+Sg==
X-CSE-MsgGUID: rCbxIipzTjiF+RSb1nKSKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6338565"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:02:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 12:02:21 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 12:02:21 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 12:02:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNiuFA/ptiR9tmtVyXdVNFt1JqiYlFHQtmDvMsztvslTA8AYeEmYLhx5Kd+M/X7i30qSq9rWPevIFpP4f/7tQ6wjmx/V+cTM0QE4+y+N7sqPQriMknqrfqomUoX98XTKpNiDWOOS6UsaFsATboip8uHT5744RMDyIz70q+HhAnRRdj853D/BTnwwc3oJ2DOOp26Yd5A0QHE0ag+3vrePwC1E37R3FMqAoCQMZgytMa0usc7vKnN+GRozr6U1Ms5W1GOw5nS0nTycfXuli/YukpMBL96/Dk3DDNipIUTkQ5rOky3emrjUHhni+BdaD2jdCEnw2V8V5kXmr1863mXfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Dzq4QSfG/H0QLSXmG8ieKXlzaFoUjiLWP2c53EsZf0=;
 b=CmNif4opF5aUtyEJiSW8FTp258+gKCENP8Ahg/tZA+pPTZecZq2zPBRcNgFPUUP5Yt9GZLfY2EoV1LgFsMxFsDsSojtMHirsoAl+XVVwrvzYv6ahdvO5FXcnJw/iuhNqD1sIvbWGN4eW+cbNumUFCdWS615cnvW3mKDLsaVFXwTwbOSxLhMeKUNRSlmHVcC2RIZm9Tht0wxGyeJ0/TfW9Zr65Gr9vvY+eO77Y3fZKe3vJ5pB79EJJ6ZYdtSY+pK+AHlx/33xwdZeCVM7Y695IRcpkea0dXwuiUNl7HGQTx/xSJnZvXhEn4YB9Ka5C4Wim7y02tzQOoCJMDSh5YniMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH7PR11MB7074.namprd11.prod.outlook.com (2603:10b6:510:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:02:15 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 20:02:15 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: James Clark <jjc@jclark.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Kory
 Maincent <kory.maincent@bootlin.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Martin Kaistra <martin.kaistra@linutronix.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>, Aksh Garg <a-garg7@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: ethernet: ti: am65-cpts: adjust perout genf
 following ptp changes
Thread-Topic: [PATCH net] net: ethernet: ti: am65-cpts: adjust perout genf
 following ptp changes
Thread-Index: AQHdZ61EU767iv56ekaGYa/f2CtVIbcUN8aAgAFFeoCABbzuEA==
Date: Mon, 2 Nov 2026 20:02:15 +0000
Message-ID: <DS0PR11MB7381F7B0221DB11E3790E227D66A2@DS0PR11MB7381.namprd11.prod.outlook.com>
References: <20261029135556.2508688-1-jjc@jclark.com>
 <c139c5e2-c791-46a2-8e60-556aa6402e12@intel.com>
 <20261030042241.2736240-1-jjc@jclark.com>
In-Reply-To: <20261030042241.2736240-1-jjc@jclark.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7381:EE_|PH7PR11MB7074:EE_
x-ms-office365-filtering-correlation-id: efaa4746-7718-4480-21e1-08df391c30f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|11063799006|4143699003|5023799004|56012099006|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003|261102123227099003|3023799007;
x-microsoft-antispam-message-info: JIHs9kRqbGX1Dy3n1qvRQv7OtBieYosilNxz/YfiyVCn6GMderpbTlxnZ3F8BJhF0jZcJZ/26cpAyOeXVAETxyg7Lv+KfyC78sKEWJNagbcSRIyfYzgbE35QLX+bZoCpL3cjqbNySpHUPE5OFRP1APc0wWO030ncCT+gLN0/MSw42tCmzZeXFepuIgDtp8NKKlUghQzNaJWQxeuz0aw/hOmtQdnV03FpSFUoLQROzRwc//tTHWD/qkF5gF1/wR+DC2TZAhzkhKy3Xo1SmRH6570dg6MLFpfeJtY+yTpk9dJSsnIEtQ24r2gsgYyfcZs9h9I7KjV0Xdq9xoVqvCTzYSlmO4C9xGNnwPEWq+v+s83f4YwbpRYK5fWuP4NAKO462wzNTkewv3VkdUoL+mOAgNnu0aWhRBQl8uT6vHeF2Pg6B0iEIadSL/fnCtrktLVze7bsEz/KysExc3baa2QY46yL9ALOgd2E81gPpe+vE3oMNGX1evi5FIYvuXrdCDoIeS6tlZjH9X6sGiCjNJq0kfQkds8+AwSz/u7x+X1shJU2uM/iUYs0GWeUG6JQSUobcG5lGmCGB56MH5SdLn4CdGpC8WbAQQwPxq4gqxfgACK3pTFQ/xmp+jRklyyjOLyLy6AGzwZLx+ADAUKIN2Xj2CinV/73Ppdfk72Bp+VDL6GQGbard6g7RwZNmuIwCXigqFGwA3fJuVZEewR8YXRsqrb53VyZsEpYlQ1lCnGqxdk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFdXd3RndHJvVjV4Y25PekNqVmlNOERZR1NEdjZQdjFzRFZsczNEMlZzaUlJ?=
 =?utf-8?B?OW1yZ0xhNVFkUW9MNDRaeWorYjVFS1pRQXlrZ0dRQTRZbUpPa2pXZWxOMlZH?=
 =?utf-8?B?UGZyMjI0TUU0ZnM5OWpUWHBWbnUreXYyaVAwUlI2c3VtUnhsdFdZNVAzRzNv?=
 =?utf-8?B?eU9sWG9aTmdhdjloS0FTaG44aXdYSlBvd2t3N09qK2UwUE0wckJ5cXEvdmZv?=
 =?utf-8?B?MG1ERkFqSi9yRlZnYUUrcEdBNGVTMEdMdlEzUjJ1NmZWeTR6R0NnRnVTeCsw?=
 =?utf-8?B?NFkrT2NJSmQweUI5U2RGTGNLcExnbTNXZ0x2Wk9mNXZ4bHRlV25MTzNUV2FU?=
 =?utf-8?B?NWlTMjVTQWhYdWRvd3hPK21uZDlscGxmOGZPSXFFZDBIYU9BTkdrb3I1L01D?=
 =?utf-8?B?UFJ1eE9PS29VRXJJYWFJN3owOWxiRzJxWEZrbmI0bTZMT3RxZTMrRGIzY3dM?=
 =?utf-8?B?UkpkR2pCTXBHaDJoQ3pVLzlES2lMcFlNci9DZEtpMGp5NjRjd1FDOGFoNTg5?=
 =?utf-8?B?RDNtUkM4bSt0WFk5dThOY3BJWE1EU1hrdzNtTVNsVzFHZ2JSQ0NYcG1jdUlO?=
 =?utf-8?B?NnRxeHhnd3FvM1RjYmVXS05remRHY1JFemRxOUxQUEVzMzA4Yzg0S05iUGFN?=
 =?utf-8?B?aVl5Tk1qMEpRZVIvNkUrZmdYaFlpRXhKUk9Zd0I2eTFmT2ZpYXlBWmRYRDFG?=
 =?utf-8?B?Nm1WT09yWUIybnFCL0dJMjhlMnRBdFVvdDlWNEtkbXhPbzgvMzJ3d3N6OURE?=
 =?utf-8?B?c1R6eTR3dng2OC9pQ1V0SHF6QnZNU1FHZU5NWE5CcktJVzZzSXVOTXJpLzdw?=
 =?utf-8?B?Q3NHeWNvcDk0dDFaTXFmSjN0VjVlT2F5MGpTRVpya1ZwaGo3NkJSTFB4N21S?=
 =?utf-8?B?NjcxMnowbmtocXQwYmt0bXlGbzdKelBsb0tZWWNOdThFMzRrK0htVnZtMEpj?=
 =?utf-8?B?Q000YWs4a3NiVHIyTksxQk1lUWg1ampibXY3RG9nM2VhSDVnRi96Z2c1YnY4?=
 =?utf-8?B?MWZVRU5OMUdWekl0aTRFTHhNM01HUHhGTTMyUXM0U21lUUFzVHJKTUdpbUNX?=
 =?utf-8?B?VFhOZ1VONTJqQks1WTZ3czhGR0UwVHp1VWpmZjhYSE5PZ0FETkdhNXJzTncz?=
 =?utf-8?B?UHNkY2kzRitZeE5HaXV5M1lXNUR6RTJuQkMvdklwRWt5T2NrT3kyeDA3Z2ZB?=
 =?utf-8?B?bGVjdWhKT3VBK29Pb3IyUUVKQ3hkajR4cWJ5YWg1TlZEb1k4Y0R0RWlJVkpk?=
 =?utf-8?B?OHhuTm5FcUVPZEFBdnlQZyt4Uy95QjlzcW9VU2xWT2dFcGU0Vkx6aHQ5TFly?=
 =?utf-8?B?aHJadXFtTEpQYnR4TmcyTkhaOXNjQ3FBbTM3ZmRITCt2TkJwOXBIOUZJWkxl?=
 =?utf-8?B?Q3NMR0F2bmdlSXNDV0lFTlNkbjE5bHpqQUhVblYzSC9FQllGL29oUVcxdERy?=
 =?utf-8?B?OHBHaGZZdjZTQVVTcWhTMlBFUHYxV3pPalhaZG5jaDRZMDE1SHQ4SDQ1amF6?=
 =?utf-8?B?LzBseWI0UE5hSEN6K0QrZGkveXV0MEtlenFUdllnaXY1OXFpTVNCRXVnM3Ra?=
 =?utf-8?B?ak5vaW44RFJVU3hSMTUrUnBSZXhRbzlocDVCbXhFR3lWNnNSTUprZTQ5Vkl6?=
 =?utf-8?B?R1NYaUVVbGowNWZNNC9NdE9Fc1pVODVEK2hxUVhuNUNDQUlGbSszcGpreDc3?=
 =?utf-8?B?L0E4MWN0TGpmNE05QW4yNFBKK2ZCbWh5UUMwcUxITk1adWZPTUo3UlMwcmV5?=
 =?utf-8?B?b3UvY01BUU9vZVhxL1dSc1VCSndPNG9zS3hYeHpBb2N5OThRRXFkSTlUeXBC?=
 =?utf-8?B?ZkcyYWt3Tk5CaGdNUWYyUWJPaEdjNitzdkNwbk82ZWl3SXBjaTdLQnJIVDNW?=
 =?utf-8?B?UWN2dVBpM3lOajJCTWtYWFVueDlVL0pEU0Y5NXV4MkpQM3dMT0haaURHTmI3?=
 =?utf-8?B?bjV6TktFYWllejJ1OWpMNnh6My9sZ2RaVE83WFVOL2VSYkN4eURwOG1scU9x?=
 =?utf-8?B?Y0Y5V1JwaUxMZTJsSmJJNmdTeHMxWmtpelc1ZExCeGhjeC8rSjUxZ0s4SlJZ?=
 =?utf-8?B?Z0ZtRS90MjhaSjdyQmY5MExlRmNsNUFKYVRORGFsTThORE9kdWFvUW1ZSnhx?=
 =?utf-8?B?SWpWczRpVHhmMzdtUXhzdHNUYmVrWGxPVkNOZFBoR203aFE2TlFXMjJrcXZI?=
 =?utf-8?B?NkpwTGxKQkp0VjJER3A4QnhseTQzZjdla24vbGNTWldwcHJ0STNKZkMwR1h3?=
 =?utf-8?B?QjQwSjEySndqYWFaYU54WVFraHMvQytCTEpjRmpzTnJlejQ5M09qKzFBeWxl?=
 =?utf-8?B?L0d1Uk9WT013dUNncDY3UEdyaWYvTXhCL2tldXFYdkhvRVJCeGZoQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wykqjBKsEVwBWIL7a9CCGDGp6skc2i/ropJ13njpuxYIHJ08vimYSWo8s57XY+2G38IKETn+ucevEvgYcf8/wzlVyYIzHaz4A0nZsLQ6soMDlzxUczWkA3AAFeaZEDDiBL6R90zX79arcXYqwaG0doqwzE5OSgB7z1fVN3lypABc9BkSSrmOI0qW68Va/Uw/m60gRmBZ9qWg5bOMEg2W+mTfoeDeA2e8EEpsCQH/Rj4CVq5nF58R+rc1ZAZ+FqpByGHo1FEBG40JvSkrxiASslSg1ecg7J/4BT9w27056sMEGz6dweufxPDeIEQiCNi/VEZ6JKCZQ7RXzV1SFLfsbg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efaa4746-7718-4480-21e1-08df391c30f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 20:02:15.3107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFgIq9MwvBWqxN6Mi58sLkYUXie4sjRPSum6Sdzn/+rfrDoNzHBj9ngCNWnutnnUrDI2rfz+nBUHj+yoFvQU5wT5JwRD2FqgtS9JrPpgnS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7074
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQ2xhcmsgPGpq
Y0BqY2xhcmsuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyOSwgMjAyNiA5OjIzIFBN
DQo+IFRvOiBLZWxsZXIsIEphY29iIEUgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4gQ2M6
IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTLiBNaWxsZXINCj4g
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGtlcm5lbC5vcmc+
OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVu
aUByZWRoYXQuY29tPjsgUmljaGFyZA0KPiBDb2NocmFuIDxyaWNoYXJkY29jaHJhbkBnbWFpbC5j
b20+OyBWYWRpbSBGZWRvcmVua28NCj4gPHZhZGltLmZlZG9yZW5rb0BsaW51eC5kZXY+OyBLb3J5
IE1haW5jZW50DQo+IDxrb3J5Lm1haW5jZW50QGJvb3RsaW4uY29tPjsgU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvcg0KPiA8YmlnZWFzeUBsaW51dHJvbml4LmRlPjsgTWFydGluIEthaXN0cmEgPG1h
cnRpbi5rYWlzdHJhQGxpbnV0cm9uaXguZGU+Ow0KPiBHcnlnb3JpaSBTdHJhc2hrbyA8Z3J5Z29y
aWkuc3RyYXNoa29AdGkuY29tPjsgQWtzaCBHYXJnIDxhLWdhcmc3QHRpLmNvbT47DQo+IG5ldGRl
dkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBuZXRdIG5ldDogZXRoZXJuZXQ6IHRpOiBhbTY1LWNwdHM6IGFkanVzdCBw
ZXJvdXQgZ2VuZg0KPiBmb2xsb3dpbmcgcHRwIGNoYW5nZXMNCj4gDQo+IE9uIDEwLzI5LzI2IDIy
OjU3LCBKYWNvYiBLZWxsZXIgd3JvdGU6DQo+ID4gTWFrZXMgc2Vuc2UuIE15IG9ubHkgY29uY2Vy
biBpcyBob3cgbG9uZyBkb2VzIGl0IHRha2UgdG8gZmluaXNoIHRoZQ0KPiA+IGFkanVzdG1lbnQg
dG8gZml4IHRoZSBQUFM/IENvdWxkIHRoYXQgaW1wYWN0IHRoZSByYXRlIGF0IHdoaWNoIHlvdSBj
YW4NCj4gPiBwZXJmb3JtIGZyZXF1ZW5jeSBhZGp1c3RtZW50cz8gSW4gdHlwaWNhbCBkZXBsb3lt
ZW50cywgZnJlcXVlbmN5DQo+ID4gYWRqdXN0bWVudHMgaGFwcGVuIGF0IGV2ZXJ5IFBUUCBzeW5j
IGV2ZW50LCB3aGljaCBjb3VsZCBiZSBtYW55IHRpbWVzDQo+ID4gcGVyIHNlY29uZC4NCj4gDQo+
IEhpIEphY29iLCB0aGFua3MgZm9yIHRha2luZyBhIGxvb2sgYXQgdGhpcy4NCj4gDQo+IFRoZSBy
ZWdpc3RlciByZWFkcyBhbmQgd3JpdGVzIGhhcHBlbiBvdmVyIHRoZSBTb0MgaW50ZXJjb25uZWN0
IGFuZCBzbw0KPiBhcmUgZmFzdDogSSB0aW1lZCBjbG9ja19hZGp0aW1lKEFESl9GUkVRVUVOQ1kp
IG9uIGEgQmVhZ2xlWS1BSSBhbmQgZWFjaA0KPiBlbmFibGVkIEdlbkYgYWRkcyAwLjg0IHVzLiBJ
IGFsc28gdGVzdGVkIHdpdGggUFRQIHN5bmMgZXZlbnRzIGF0IDEyOA0KPiBzeW5jcyBwZXIgc2Vj
b25kLCBhbmQgaXQgd29ya2VkIGZpbmUuDQo+IA0KPiA+IEFsc28sIGlzIHRoZXJlIGFueSBsb3Nz
IGluYmV0d2VlbiB3aGVuIHRoZSBjb3JyZWN0aW9uIGNvbWVzIHRvIGVhY2ggR2VuRg0KPiA+IHRo
YXQgY291bGQgc3RpbGwgY3JlYXRlIChhIG11Y2ggc21hbGxlcikgaW5hY2N1cmFjeSBiZXR3ZWVu
IHRoZW0gdGhhdA0KPiA+IGNvbXBvdW5kcyBvdmVyIHRpbWUgd2l0aCBlYWNoIGZyZXF1ZW5jeSBh
ZGp1c3RtZW50PyBPciBkb2VzIHRoaXMNCj4gdXBkYXRlZA0KPiA+IGNvcnJlY3Rpb24ga2VlcCBl
dmVyeXRoaW5nIGFsaWduZWQgYnkgdGhlIG5leHQgcHVsc2U/DQo+IA0KPiBUaGVyZSBpcyBhbiBp
c3N1ZSBoZXJlIHdpdGggaG93IHRoZSBoYXJkd2FyZSB3b3Jrcywgd2hpY2ggSSB0aGluayBtZWFu
cw0KPiB0aGF0IGl0IGlzIG5vdCBwb3NzaWJsZSB0byBndWFyYW50ZWUgdGhhdCB0aGUgcGVyaW9k
aWMgb3V0cHV0IGlzDQo+IGFic29sdXRlbHkgaW4gc3luYyB3aXRoIHRoZSBQSEMgaW4gYWxsIHNp
dHVhdGlvbnMuIFRoZSBoYXJkd2FyZSBoYXMgdHdvDQo+IHNlcGFyYXRlIGNvdW50ZXJzOiBhIHRp
bWVzdGFtcCBjb3VudGVyIHVzZWQgYnkgdGhlIFBIQyBhbmQgYSBHZW5GDQo+IGNvdW50ZXIgdXNl
ZCBieSB0aGUgcGVyaW9kaWMgb3V0cHV0LiBFYWNoIG9mIHRoZXNlIGhhcyBpdHMgb3duIFBQTQ0K
PiBjb3VudGVyIHVzZWQgdG8gYXBwbHkgZnJlcXVlbmN5IGNvcnJlY3Rpb25zLiBFYWNoIFBQTSBj
b3VudGVyIGlzIGENCj4gZG93bi1jb3VudGVyOiBpdCBsb2FkcyB0aGUgcGVyaW9kIGZyb20gdGhl
IFBQTSByZWdpc3RlcnMsIGNvdW50cyBkb3duIHRvDQo+IHplcm8sIG1ha2VzIGEgb25lLXRpY2sg
YWRqdXN0bWVudCBpbiB0aGUgZGlyZWN0aW9uIHNldCBhdCB0aGF0IG1vbWVudCwNCj4gYW5kIHRo
ZW4gbG9hZHMgdGhlIHBlcmlvZCBhZ2FpbiAoYXMgZGVzY3JpYmVkIGZvciBHZW5GIGluDQo+IDEy
LjIuMS40LjcuMTEuMiBvZiB0aGUgVFJNKS4gYWRqZmluZSgpIGp1c3Qgd3JpdGVzIHRoZSBQUE0g
cmVnaXN0ZXJzOw0KPiB0aGUgaGFyZHdhcmUgZG9lcyBub3QgZ2l2ZSBhY2Nlc3MgdG8gdGhlIFBQ
TSBjb3VudGVycy4gVGhlIFBQTSBjb3VudGVycw0KPiBhcmUgbm90IGluIHN5bmMsIHNvIHRoZXkg
Y2FuIHNhbXBsZSB0aGUgZnJlcXVlbmN5IGZyb20gdGhlaXINCj4gY29ycmVzcG9uZGluZyByZWdp
c3RlcnMgYXQgZGlmZmVyZW50IHRpbWVzLCBhbmQgdGhlIGNvcnJlY3Rpb25zIGFwcGxpZWQNCj4g
dG8gdGhlIHRpbWVzdGFtcCBhbmQgR2VuRiBjb3VudGVycyBjYW4gYWNjb3JkaW5nbHkgYmUgZGlm
ZmVyZW50Lg0KPiANCj4gSSB0ZXN0ZWQgdGhhdCB0aGUgaGFyZHdhcmUgYmVoYXZlcyBjb25zaXN0
ZW50bHkgd2l0aCB0aGUgVFJNLiBBcyBiZWZvcmUsDQo+IHRoZSBHRU5GMCBvdXRwdXQgd2FzIGxv
b3BlZCBiYWNrIHRvIEVYVFRTIDAuIFdyaXRpbmcgYSBjb25zdGFudA0KPiBmcmVxdWVuY3kgZXZl
cnkgMTAgbXMsIHRoZXJlIGlzIG5vIGRyaWZ0LiBCdXQgYnkgd3JpdGluZyBhIGZyZXF1ZW5jeQ0K
PiB0aGF0IGFsdGVybmF0ZXMgYmV0d2VlbiArMC4xIGFuZCAtMC4xIHBwbSBldmVyeSAxMCBtcywg
SSB3YXMgYWJsZSB0bw0KPiBwcm9kdWNlIGEgZHJpZnQgb2YgMTAwIG5zL3MuDQo+IA0KPiBCdXQg
aW4gcHJhY3RpY2UsIHRoaXMgZG9lcyBub3Qgc2VlbSB0byBiZSBhIHNpZ25pZmljYW50IHByb2Js
ZW0sIGF0DQo+IGxlYXN0IG9uIG15IHBhcnRpY3VsYXIgYm9hcmQuIEkgdGVzdGVkIHdpdGggcHRw
NGwgbG9ja2VkIHRvIGENCj4gR1BTLWRpc2NpcGxpbmVkIGdyYW5kbWFzdGVyLCBhdCAxLCAxNiBh
bmQgMTI4IHN5bmNzIGEgc2Vjb25kLCBmb3IgNjAsIDEwDQo+IGFuZCA1IG1pbnV0ZXMsIGFuZCBk
aWQgbm90IHNlZSBhbnkgZHJpZnQuIEkgc2hvdWxkIG1lbnRpb24gdGhvdWdoIHRoYXQNCj4gdGhp
cyBib2FyZCdzIGNyeXN0YWwgaXMgMTAgcHBtIHNsb3csIHNvIHRoZSBhZGp1c3RtZW50IGlzIGxh
cmdlIGFuZCB0aGUNCj4gUFBNIGNvdW50ZXIgcGVyaW9kcyBjb3JyZXNwb25kaW5nbHkgc2hvcnQu
IFRoZSByZXN1bHRzIG1pZ2h0IGJlIHdvcnNlIG9uDQo+IGEgYm9hcmQgd2l0aCBhIG1vcmUgYWNj
dXJhdGUgY3J5c3RhbC4NCj4gDQo+IEluIGFueSBjYXNlLCBhcyBmYXIgYXMgSSBjYW4gc2VlIHRo
aXMgaXMgaG93IHRoZSBoYXJkd2FyZSBpcyBkZXNpZ25lZCB0bw0KPiB3b3JrLCBhbmQgSSB0aGlu
ayB0aGlzIHBhdGNoIG1ha2VzIGl0IHdvcmsgYXMgZGVzaWduZWQuDQo+IA0KDQpNYWtlcyBzZW5z
ZS4gRXZlcnkgc3lzdGVtIHdpbGwgaGF2ZSBlcnJvcnMgYW5kIHRoZSBkcmlmdCBpcyB1bmZvcnR1
bmF0ZSBidXQgbm90aGluZyB0aGUgZHJpdmVyIGNhbiByZWFsbHkgZG8gdG8gY2hhbmdlIHRoZSBo
YXJkd2FyZSBkZXNpZ24uIEl0IHNlZW1zIGxpa2VseSB0byBiZSB2ZXJ5IHNtYWxsIGFuZCBiZWxv
dyB0aGUgZXhwZWN0ZWQgdXNlIGNhc2VzIGluIHByYWN0aWNlLg0KDQpSZXZpZXdlZC1ieTogSmFj
b2IgS2VsbGVyIDxKYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoNCj4gPiBPYnZpb3VzbHkgdGhp
cyBpcyBzdGlsbCBiZXR0ZXIgdGhhbiB3aGF0IHdhcyBoYXBwZW5pbmcgYmVmb3JlIHdoZXJlIHRo
ZQ0KPiA+IGNvcnJlY3Rpb25zIHdlcmVuJ3QgZXZlbiBhcHBsaWVkLg0KPiANCj4gSW5kZWVkLg0K
PiANCj4gSmFtZXMNCg==
