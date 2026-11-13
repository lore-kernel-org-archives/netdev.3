Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571721;
	b=Syd5VP0VUPL0XSoCWv5RcfDAw1LbfQeUIvXjKELgY0glu0+VCjYJN/tSZIGYyV865uEA
	 0rGyJ8h1KbVISB4JK/ZYNdPBu3siumCXcTQjq+xmuzbHfscU4V1OBzgBwtIDHEFJv6LFH
	 yw/pqeUbRHuFBRncgDYiwfVmv6g270hxK3sn8e2Rby2aKUtfTma3BBDuyLWxnbJkhZ+2B
	 mxIBpDJmGcRu7MdjKDCXqpdkbtIW4357eps8nWPj3qjWAi0MobCuveBW66Wsa2V79Lq/l
	 x2AtqKFpTsMFPdnoFOcSnqv1Kk+60GYvNSPqllaBER+jiEkJEuAqfBqFGPrVMEPam4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571721;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=f8C+tEOn3AkLigFFtnuFf8epAklcLF2g4HEAKBTF4qY=;
	b=r1qYTjH30NbUcUvuM+Lyat4wBFRll2gofpenv00XNx19ntAG31e2RadajnV14aALZuUp
	 lx7sjD4IYNoB0IIpbeSHM2Xx5YZmCHGiz2vFp3iMRUqwWp4bZuaK6T8hTst1sp24XSZMw
	 iek9kLIywyBlEIhKGbN3OHqw5ynK2IjLn1saG7rjSClGWb3ADQNQOJwVpFgAt+ZCuajmz
	 hYi1KIiSTAIXMlnQB+0gRh4F5AtVGzq0KEG7qHgjIrZ/QCqhKRDrYsJ5mEgdXtt0mibG4
	 igryouyCWe0ABhdexsi0qgvf5ywwxLvFHSU1/2CTq6u83roMGQKe1y3RbouBUL3hB9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cINz6qyE;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Q8R5k3Rt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA56606A888
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BA56606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cINz6qyE;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Q8R5k3Rt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571720; x=1826107720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mY4XIyQ79mc+2kjDRo7WpkmElstzl/djkcrswX9rdz8=;
  b=cINz6qyEKW2cLK51HmISJxFimrnk0Vsm4xbMyj9KJA8oeilO+ktLk/ll
   eD5LE+ZmyDLM3axFRES5LgB3dOmU5dfa1mU+joII2Sg9OXI2O6iW8Ihmb
   e1EaUzWn0KqE7OIk24HeQvSOdqwdi2LAjL8BWUfVXaASabfcet4uiNYQl
   XMfy/sjRu0PnlG/06mgbWGwLymad3kgxo4Aj82KrR2xFWD9eI/x6sFGYW
   vN/mDycvmFKh7z75J17YoGNJKC49j8BcDRHL3WfDuCH03yao7O9y9AZRU
   L/ZEt8zvt8H2SkYbKsbIlB2lsREPWLL8AJVOXX7lvDO1FFxB5P41tIWFc
   Q==;
X-CSE-ConnectionGUID: P6Vq8QBLRT+G3yL+oLoQnQ==
X-CSE-MsgGUID: w3/j/bN+Qwiw51eUGUuL9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3385356"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3385356"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:08:40 -0800
X-CSE-ConnectionGUID: jZoEN71FQUuMoXYVMOdBlw==
X-CSE-MsgGUID: uVQlnXGVQPCM75ageHopHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8986568"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:08:40 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:08:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 04:08:39 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:08:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFieoDfAGp5Z4gWED9bVfM0pscvF42SX+psSf4Q1Miq9GkJL8V2g4tspbT1BtJUBeSduSefQPhdCHMNsirfVRFdYKIzI92GOpCCIBX+jt983nFv3ipQhwieZIFCFiykCXgM8+vKl6M3268OLVX3nPtl6jdKI+FspsDaBLaH+G0kg4L1VFefRgdP1cJH3q69iPJCJ+pDDjsWtEyExdyd/NxrUyEAM9sCiZBji+wZPb409IsCfBMBETgh6rDOfsTa+m47E8w7SZQJpsS98227kY0LiskdTKUx42j1PprbY44PiJ+IZ3PCzKZzYPnrf1gXEI1RcgBiO8L0XNqS5nnEwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8C+tEOn3AkLigFFtnuFf8epAklcLF2g4HEAKBTF4qY=;
 b=GJxztMlt+inwF+G3XOMflpKseyZxtK9fBwLsrgIzwrKco1wWK8oSD/dcCf3LZ+9a6H4JlVoueo+V1GOWjhfGGTFLaVKqr8pY3/13BU0DkIVytpg6oNBuVv7WDGaWkvueEUurHrlU/kmLmdhyqrgrzxml5ZPgyq5U44kmz4nm/SYAsQpfmwNHm8It2Xshh8oqHRUs60n7bGLR7TSOIN8DmQCs6hujVTB2UG/FJWQTLkaReWi68hHmUjDKRBKC1zENRFVFczSx7n2mL6xUkqpi7yZRPJJcaAbtwqgNKGACxmeCplZIPz/U8naoA3nJX6dae4okvRUxZgxrhQVdmOsF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8C+tEOn3AkLigFFtnuFf8epAklcLF2g4HEAKBTF4qY=;
 b=Q8R5k3RthCNgRIA9EPJNThZS8/XBccm+Q6/H7LtyEnKx3dE1zbj4SfCE6Lnj/fFx6iDgCrbBkK3vPDUgIAf2bx1ffbT40tdH4elhlx4zEh7wrPiHGXZO3fYvNybfbXNBZVuMOaYsro94gftfCRY1HEBBd7/Oxu1ss7DdeQcdg1s=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA2PR11MB5003.namprd11.prod.outlook.com
 (2603:10b6:806:11e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 12:08:35 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:08:35 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Schmidt, Michal"
	<mschmidt@redhat.com>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "anzaki@gmail.com" <anzaki@gmail.com>,
	"brett.creeley@amd.com" <brett.creeley@amd.com>, "ohartoov@nvidia.com"
	<ohartoov@nvidia.com>, "Oros, Petr" <poros@redhat.com>
Subject: RE: [PATCH net-next v5 12/15] devlink: give user option to allocate
 resources
Thread-Topic: [PATCH net-next v5 12/15] devlink: give user option to allocate
 resources
Thread-Index: AQHdcR4OAdwRIUvrkEu0Gp1sf8ii/rcr7RQw
Date: Fri, 13 Nov 2026 12:08:35 +0000
Message-ID: <CH3PR11MB56689589762D7BF6A52B012588E57F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
 <20261110141534.95614-13-przemyslaw.kitszel@intel.com>
In-Reply-To: <20261110141534.95614-13-przemyslaw.kitszel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA2PR11MB5003:EE_
x-ms-office365-filtering-correlation-id: abe1f85f-7192-49b3-ec52-08df417ed807
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|4143699003|6133799003|261026121527099003|261009223027099003|10067099003|261028144727099003|261102130727099003|261026140227099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: Uoo6xpovJOLafnWv4I7jaw1G/X4k36b64gDH2Tr2ScRoO7QvbbozYR6V9umngGYRlVgZEuv7ztfkLyBrtyipdt+Ov1NI+B8msc5hiGo5fxMfKGel8b4LYq0qvsMhjE/bePQHb6u4wLd0/PpKaxPAag2/5fxfREZVs8kd0BYI7JOx1IhLVG6Y1vxvD5PB6nXd619ee/cITT63DMLuH0veyjyoienQKR6GqLy0m1RfV1mu5YFVOiKLIm3e4BK94+cT2XmLwFdnptMMslB3/1FKlAESWo+j5/RxP7j/r1BnPXGbIawY+Hys8SOyF6ur1sQvjBXH2NF8/erhcKwNVTTsb0RwXIiKJEFGbHZ3IEmoA6w50uhJQb4VlXAmhotw2Fo99NkEDwYDkf9wKwQB8OtpJ+yfZOeeNjU44PbWNRIMYDK5MLTaHd70juCoByg2uZRmiw9Mi38Eu9p5M0IAS3jt7vCBdvERX+Wq0bwG0m+NqDHttRm79zFjlbpPpGX8gEQLDgqSUfv8L+Snm5rE+qt7dG98LadgbB2cNyWkIx835hYYUnnvwS0duh4AN/yw++UpgsKMknW3BSQaY7Fr9B4OeK0cLeltNb7ryz60yWxLzwKzsmp5oFN8yias03nbjlpFnJSUWar0eIXwXJxQQOyFqSLLVmG08R7aSCk22ran2v4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(4143699003)(6133799003)(261026121527099003)(261009223027099003)(10067099003)(261028144727099003)(261102130727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FY/viLo2ceOBbwTFQ1TUhNgaV/yuKRPU5oxeC6LSEQKq+ZBhD2aqDDV3q9GR?=
 =?us-ascii?Q?aeqNUh5vl8EG6RLo/iCIx6f/hqydX9CEApF5RA76xmN2kZMeP1hGqqs2Xf/w?=
 =?us-ascii?Q?+ul2k6VCmj0PpLkKc4bhI2E/4+yMtP2UZP5yHi4gfdFDC5+d484VBXTuegA+?=
 =?us-ascii?Q?2lPhxvxwDk7iAWsRTEVScTG9J/UEDHCMRP+g+bSMF19C/5M4C5NVVw6GOTkS?=
 =?us-ascii?Q?6B8rwqSs8PFdAvW67i+4TNSH80AsdwsH0wWIKrPzkfXZT5ZQnx4vH+g7xEEM?=
 =?us-ascii?Q?y91EkrICVnBHgryHflzvgbPPyT9HVLDvzW4lOf/Ukf5DyK1PwbjEV7+v4TNI?=
 =?us-ascii?Q?Au67qCJRJoEh0F20aM6aNB1BMKPdTsxqTbxTl5oYDLBHUxUvcrF7t0nmVEgj?=
 =?us-ascii?Q?VTJxbcfFxbsIUA3XMTWepYYpYirftRgO8xe+FbWKeCZNLkxz3fEs0V3Vy/BQ?=
 =?us-ascii?Q?F5j3cNmv5NwmyRHkH3x503eTxaF/FaVkNgZFHYXOFpD4aufWnyEgTCGeXMfZ?=
 =?us-ascii?Q?h0lyWwVxHKegvaYQj10m27LVWDEUMKSIdRERdxaARUlorg69NR8intxIfGqp?=
 =?us-ascii?Q?zcsoqvWqSnZXCkppI+XCownQXjwTVd6OkDd/Kg5w5LAwCIB2k2HfSmpCDaex?=
 =?us-ascii?Q?NSb8TU+7MTASgmlkJbs997bpTFoEQ/yQZdnSDJ+skuTrDrK22cX92K1UOr3V?=
 =?us-ascii?Q?W0YvhCNo3Dmm1eNP+ZPLzNOQWSEbSQkqdExF1bAFcDaisEzqWx3wX35yb7t7?=
 =?us-ascii?Q?cCjTVSzW6iCvyt2yrx7UnYZjrJQ8DSmssptaxm7khHpbPJ4YRW/N1Ye30WOR?=
 =?us-ascii?Q?hXmcNasuVdL0FjaCphmtdAYcAG0uzqpoTUsaC9fKXE9kDNq0GfLj7H4rCuFr?=
 =?us-ascii?Q?i+AGyzjxF3ipgoZCM4tFOfnYO7arUdLZJEHdGLAUnEl3SKsvcwzBLV6NMVLj?=
 =?us-ascii?Q?ay238deIp4LAGLOK0mwzElw0CPWpTJ9TqnAAup22CCg46Ai+cc3tQlWv3eKj?=
 =?us-ascii?Q?FI8fLGjzkSWLqhFug3/kQSqOs1fpq2Z3KFd5hWHIEIGpHVdXbART6Ztfqhsp?=
 =?us-ascii?Q?+nDKCa56/krXAwbn8rgA7exCRgVS8mXfg19Yk/X0a/iuMGBeFelmrOZor9M4?=
 =?us-ascii?Q?LioRQGCADQHBG22NbleklOobqg4tMKYoKnZKfFK6oUogkR79pOcuBXrCAJeg?=
 =?us-ascii?Q?BIRDu8BM6USxDtrgsdREgwPiouPZz8X84DERagDKpITv8x4OII5FEpJ4qLhy?=
 =?us-ascii?Q?+Dh2n/+PB2EfHVl4OPCNq7Wc4MZ3YSTlrZ/yaLlMlJtFiGgDar0LVJlR9LWt?=
 =?us-ascii?Q?5HVFmZE0uzEnfZunkVqesaQHnNKywFlIOMzkvIp84b4V7KEvujaAgimCxh81?=
 =?us-ascii?Q?LZdvjFsPe60S1sJTCEzKQxkVqqmGuKztDopRkyqiDnjh6Piz86dp5j6DHan9?=
 =?us-ascii?Q?nYno/vt+GBjUY0QJwPF11yl/kD+aMWh4+LYg2o/Re9hboLvu6SevHEbRrl/x?=
 =?us-ascii?Q?SVl8GguxIm2jXjKAAwqUbXMVuJWMl/E/jfmoGN6uWY7YWeruA6k8c1aWalli?=
 =?us-ascii?Q?gAy+qFFlSbjKLPI4ZugVF3NosaDnaw6YgddLlY+HLklY59DIqNxgsZGHE/si?=
 =?us-ascii?Q?2etI5wKJmeEgNaExGCym74N42EQQcOwFPA6GWVLV2ltwkgaYwrvEVH0Vqnt3?=
 =?us-ascii?Q?kMUPGSBRETrUWMH2z3AT9zFiaGzLeh/sAMQzcw2BcrYLRX1haM+7wzGRxyZV?=
 =?us-ascii?Q?tTlOOXNQEQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
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
X-Exchange-RoutingPolicyChecked: hkv5lvWBT0jknfLbc8nCDApxgDXuHI8fSt3fA7Qu+zKhWSjj8bSwdi5g87XSOyKnZfmQakDEWWYPDEgAp7A7T0xqeFv5BaOxavWqzWOqEFmZeQKj1kZBUsKGwqrX0q2+LCLMeqEGW0ApK/+H5kmrV8hCrPHb3uh49vktxUkzhqUh95omPc9IOAdZBFKXudWYpqgyv9vKB/gdVqBSbICgI70ZcX2dEFXqQfXg294lQvsVxsCPpqVHHvDGBCHAZHKcpiTbeB1pkyReaNjznzgftB0JD5rPj9K/bYstZmil7IRWz+NnCWstyMUab/O68Xx3ULTJoVW+YYz3oyKxN8Y4+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe1f85f-7192-49b3-ec52-08df417ed807
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:08:35.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3/6QEN2cDI5mY5d+p7T1G7wSCeFa1ivK/PbqLOB5o1LLqXxgHOxQh6v3jlP+G6LROBbK97RRvJZjsqGFg4UWbmrJHAFx+3zl2IqZhpxcTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Sent: Tuesday, November 10, 2026 3:07 PM
> To: netdev@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Schmidt, Michal <mschmidt@redhat.com>;
> edumazet@kernel.org; horms@kernel.org; pabeni@redhat.com;
> davem@davemloft.net; Jiri Pirko <jiri@resnulli.us>; Jonathan Corbet
> <corbet@lwn.net>; skhan@linuxfoundation.org; rdunlap@infradead.org;
> andrew+netdev@lunn.ch; saeedm@nvidia.com; tariqt@nvidia.com;
> leon@kernel.org; mbloch@nvidia.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; anzaki@gmail.com; brett.creeley@amd.com;
> ohartoov@nvidia.com; Oros, Petr <poros@redhat.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [PATCH net-next v5 12/15] devlink: give user option to allocate
> resources
>=20
> Current devlink resources are designed as a thing that user could limit,
> but there is not much otherwise that could be done with them.
> Perhaps that's the reason there is not much adoption despite API being
> there for multiple years.
>=20
> Add new mode of operation, where user could allocate/assign resources
> (from a common pool) to specific devices.
>=20
> That requires a new .occ_set() driver callback, called on
> DEVLINK_CMD_RESOURCE_SET with the requested DEVLINK_ATTR_RESOURCE_SIZE,
> instead of staging the size until the next reload. Driver registers it
> together with .occ_get() by devl_resource_occ_set_get_register(). For
> such resources the getter value is reported as
> DEVLINK_ATTR_RESOURCE_SIZE, as opposed to DEVLINK_ATTR_RESOURCE_OCC
> (current occupation) in the "legacy" mode, and there is no
> DEVLINK_ATTR_RESOURCE_SIZE_NEW.
>=20
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> RFC, Feb '25
> https://lore.kernel.org/intel-wired-lan/20250219164410.35665-3-
> przemyslaw.kitszel@intel.com
>=20
> I have structured code to just choose "the mode" of operation based on
> the presence of .occ_set callback, instead of naming the mode, what,
> even if not the most clear code, avoids the need of naming the modes.
>=20
> v4:
>  * return -EMSGSIZE directly on devlink_resource_occ_size_put_legacy()
>    failure (Jakub)
>=20
> v3:
>  * keep size and size_new of .occ_set() resources in sync with the
>    getter, after a successful set and in devl_resource_size_get() (me)
>  * WARN on registering .occ_set() without .occ_get(), or vice versa
>=20
> v2:
>  * avoid setting DEVLINK_ATTR_RESOURCE_SIZE_VALID for leaf resources
>    (Sashiko)
>  * minor kdoc update (Sashiko)
>  * add more WARN_ONs (Sashiko)
>  * document the occ_set mode in devlink-resource.rst
>  * commit message: describe the .occ_set() callback and how the reported
>    attributes differ from the "legacy" mode
> ---
>  .../networking/devlink/devlink-resource.rst   |  5 +
>  include/net/devlink.h                         |  7 ++
>  net/devlink/resource.c                        | 97 ++++++++++++++++---
>  3 files changed, 93 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/networking/devlink/devlink-resource.rst
> b/Documentation/networking/devlink/devlink-resource.rst
> index b7172d94b2c6..9c48155fcb1e 100644
> --- a/Documentation/networking/devlink/devlink-resource.rst
> +++ b/Documentation/networking/devlink/devlink-resource.rst
> @@ -75,6 +75,11 @@ attribute, which represents the pending change in
> size. For example:
>  Note that changes in resource size may require a device reload to
> properly  take effect.
>=20
> +Resources registered with ``devl_resource_occ_set_get_register()``
> +behave
> +differently: the new size is passed to the driver and applies
> +immediately, there is neither ``size_new`` nor ``occ`` reported, and
> +``size`` is the value returned by the driver's getter.
> +
>  Port-level Resources and Full Dump
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/include/net/devlink.h b/include/net/devlink.h index
> 98bdde4f72ca..d01128ef393d 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -420,6 +420,8 @@ devlink_resource_size_params_init(struct
> devlink_resource_size_params *size_para  }
>=20
>  typedef u64 devlink_resource_occ_get_t(void *priv);
> +typedef int devlink_resource_occ_set_t(u64 size, struct netlink_ext_ack
> *extack,
> +				       void *priv);
>=20
>  #define DEVLINK_RESOURCE_ID_PARENT_TOP 0
>=20
> @@ -1959,6 +1961,11 @@ void devl_resource_occ_get_register(struct
> devlink *devlink,
>  				    void *occ_get_priv);
>  void devl_resource_occ_get_unregister(struct devlink *devlink,
>  				      u64 resource_id);
> +void devl_resource_occ_set_get_register(struct devlink *devlink,
> +					u64 resource_id,
> +					devlink_resource_occ_set_t *occ_set,
> +					devlink_resource_occ_get_t *occ_get,
> +					void *occ_priv);
>  int devl_params_register(struct devlink *devlink,
>  			 const struct devlink_param *params,
>  			 size_t params_count);
> diff --git a/net/devlink/resource.c b/net/devlink/resource.c index
> c3cfda7ea070..c4502c480a6b 100644
> --- a/net/devlink/resource.c
> +++ b/net/devlink/resource.c
> @@ -19,7 +19,8 @@
>   * @list: parent list
>   * @resource_list: list of child resources
>   * @occ_get: occupancy getter callback
> - * @occ_get_priv: occupancy getter callback priv
> + * @occ_set: occupancy setter callback
> + * @occ_priv: occupancy callbacks priv
>   */
>  struct devlink_resource {
>  	const char *name;
> @@ -32,7 +33,8 @@ struct devlink_resource {
>  	struct list_head list;
>  	struct list_head resource_list;
>  	devlink_resource_occ_get_t *occ_get;
> -	void *occ_get_priv;
> +	devlink_resource_occ_set_t *occ_set;
> +	void *occ_priv;
>  };
>=20
>  static struct devlink_resource *
> @@ -137,6 +139,16 @@ int devlink_nl_resource_set_doit(struct sk_buff
> *skb, struct genl_info *info)
>  	if (err)
>  		return err;
>=20
> +	if (resource->occ_set) {
> +		err =3D resource->occ_set(size, info->extack, resource-
> >occ_priv);
> +		if (err)
> +			return err;
> +
> +		resource->size =3D resource->occ_get(resource->occ_priv);
> +		resource->size_new =3D resource->size;
> +		return 0;
> +	}
> +
>  	resource->size_new =3D size;
>  	devlink_resource_validate_children(resource);
>  	if (resource->parent)
> @@ -162,13 +174,31 @@ devlink_resource_size_params_put(struct
> devlink_resource *resource,
>  	return 0;
>  }
>=20
> -static int devlink_resource_occ_put(struct devlink_resource *resource,
> -				    struct sk_buff *skb)
> +static int
> +devlink_resource_occ_size_put_legacy(struct devlink_resource *resource,
> +				     struct sk_buff *skb)
>  {
> -	if (!resource->occ_get)
> -		return 0;
> -	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
> -				  resource->occ_get(resource-
> >occ_get_priv));
> +	if (devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource-
> >size))
> +		return -EMSGSIZE;
> +	if (resource->size !=3D resource->size_new &&
> +	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
> +			       resource->size_new))
> +		return -EMSGSIZE;
> +	if (resource->occ_get &&
> +	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_OCC,
> +			       resource->occ_get(resource->occ_priv)))
> +		return -EMSGSIZE;
> +	return 0;
> +}
> +
> +static int devlink_resource_occ_size_put(struct devlink_resource
> *resource,
> +					 struct sk_buff *skb)
> +{
> +	if (!resource->occ_get || !resource->occ_set)
> +		return devlink_resource_occ_size_put_legacy(resource,
> skb);
> +
> +	return devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE,
> +				  resource->occ_get(resource->occ_priv));
>  }
>=20
>  static int devlink_resource_put(struct devlink *devlink, struct sk_buff
> *skb, @@ -183,14 +213,9 @@ static int devlink_resource_put(struct
> devlink *devlink, struct sk_buff *skb,
>  		return -EMSGSIZE;
>=20
>  	if (nla_put_string(skb, DEVLINK_ATTR_RESOURCE_NAME, resource-
> >name) ||
> -	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE, resource-
> >size) ||
>  	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_ID, resource-
> >id))
>  		goto nla_put_failure;
> -	if (resource->size !=3D resource->size_new &&
> -	    devlink_nl_put_u64(skb, DEVLINK_ATTR_RESOURCE_SIZE_NEW,
> -			       resource->size_new))
> -		goto nla_put_failure;
> -	if (devlink_resource_occ_put(resource, skb))
> +	if (devlink_resource_occ_size_put(resource, skb))
>  		goto nla_put_failure;
>  	if (devlink_resource_size_params_put(resource, skb))
>  		goto nla_put_failure;
> @@ -634,12 +659,50 @@ int devl_resource_size_get(struct devlink
> *devlink,
>  	resource =3D devlink_resource_find(devlink, NULL, resource_id);
>  	if (!resource)
>  		return -EINVAL;
> +	if (resource->occ_set)
> +		resource->size_new =3D resource->occ_get(resource-
> >occ_priv);
>  	*p_resource_size =3D resource->size_new;
>  	resource->size =3D resource->size_new;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(devl_resource_size_get);
>=20
> +/**
> + * devl_resource_occ_set_get_register - register occupancy getter and
> +setter
> + *
> + * @devlink: devlink
> + * @resource_id: resource id
> + * @occ_set: occupancy setter callback
> + * @occ_get: occupancy getter callback
> + * @occ_priv: occupancy callbacks priv
> + *
> + * Setter will be called when the user wants to change the resource
> +size,
> + * getter is called to show the user what is current size of the
> resource.
> + */
> +void devl_resource_occ_set_get_register(struct devlink *devlink,
> +					u64 resource_id,
> +					devlink_resource_occ_set_t *occ_set,
> +					devlink_resource_occ_get_t *occ_get,
> +					void *occ_priv)
> +{
> +	struct devlink_resource *resource;
> +
> +	lockdep_assert_held(&devlink->lock);
> +
> +	if (WARN_ON(!occ_set || !occ_get))
> +		return;
> +
> +	resource =3D devlink_resource_find(devlink, NULL, resource_id);
> +	if (WARN_ON(!resource))
> +		return;
> +	WARN_ON(resource->occ_get || resource->occ_set);
> +
> +	resource->occ_set =3D occ_set;
> +	resource->occ_get =3D occ_get;
> +	resource->occ_priv =3D occ_priv;
> +}
> +EXPORT_SYMBOL_GPL(devl_resource_occ_set_get_register);
> +
>  /**
>   * devl_resource_occ_get_register - register occupancy getter
>   *
> @@ -661,9 +724,10 @@ void devl_resource_occ_get_register(struct devlink
> *devlink,
>  	if (WARN_ON(!resource))
>  		return;
>  	WARN_ON(resource->occ_get);
> +	WARN_ON(resource->occ_set);
>=20
>  	resource->occ_get =3D occ_get;
> -	resource->occ_get_priv =3D occ_get_priv;
> +	resource->occ_priv =3D occ_get_priv;
>  }
>  EXPORT_SYMBOL_GPL(devl_resource_occ_get_register);
>=20
> @@ -684,9 +748,10 @@ void devl_resource_occ_get_unregister(struct
> devlink *devlink,
>  	if (WARN_ON(!resource))
>  		return;
>  	WARN_ON(!resource->occ_get);
> +	WARN_ON(resource->occ_set);
>=20
>  	resource->occ_get =3D NULL;
> -	resource->occ_get_priv =3D NULL;
> +	resource->occ_priv =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(devl_resource_occ_get_unregister);
>=20
> --
> 2.51.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
