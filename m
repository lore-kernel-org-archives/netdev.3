Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792579366;
	b=0R8kZJfGwzZLlCs/KfcqJK4OY9fcB63aUXJzb2PRHS/p4jYmT+FRHo9tnIrp1sM9Y5IB
	 AX2WYKeMpjdj/8SrRIEiVAInfP6SruqnU3NZICh4H4aSUGnx9dJSrUXEOLBzBwxZbucRa
	 lJPZfDllzoNAVhL93EyYuFwmcvnuo3Prv/Cvq8ACUfz5ztgl3z81psZFQZj9RhOVMBfsD
	 bMrgYxAh6qkcVEg8kWH9u3x2DBjsecCThfYVPU9yS1HRYKtgaSK53bcPZw/o0h4/Lkcaf
	 adpJz5FTza1yAAavf5/p0KjZefAaM0cO0jHuxSBH02h9iSnY85+E0onnJ7eeXnpgsvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579366;
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
	bh=6Onam8maLGxmvBPb5HmqjKX+ZrF5mXhuhVDoUBIOg0Y=;
	b=zsw7znj20fl6a/EM2d8JbNwrwSVH5KK7Qnssj8AGJyOADrN8I5eYsAqQe3pI8FkDfpEy
	 WgGCW3XePuVq02dnHWD705LBHM1amD+lsTExpBka+ezchIzbaMIDyEA68Mkb1fQzTyhZR
	 VBqBl2iLF0FdB7KAGVUKSGmMs3feDHuA+wl4y62QsHWBplPJ92lcK8DzE2zqlh1cw9J3z
	 id42F2kZWMiyIB3WwJEnprH9mRNDSRMfMLjSuQYADA/I97EvtredAmxbg2pRElq5rXnJh
	 EQR0xSgaXfTNccK/dZVGp4PP0di5JfrC6Mb8SwHwZg2YEW7jvTUZk28Yke33ZkVQMmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W3ea2wWB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44858606A319;
	Wed, 21 Oct 2026 10:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44858606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W3ea2wWB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792579364; x=1824115364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Onam8maLGxmvBPb5HmqjKX+ZrF5mXhuhVDoUBIOg0Y=;
  b=W3ea2wWBOkKx70DF1L+oLwFOWWmKsBpS+dvBoN6mWJb8JQCarEA8nomM
   /421Uwk+h9L/bot2j4DlJrfS/Jj+SlSffk3y74prWwXwaVhuwFq/GbPOs
   FKJm65ETQ0TNfhpH02o/3LiYRpGUIb/DQHKgkoc4J+pmKDk4Q2Z5KyfvE
   ym7rO3HXN9Vb/+8BTGBj9uUUue1q49aNymhBNc3jO0aGA4Xx7ynZ/S3X+
   u/pJqa6uH8FrFVJcrKBs4vJs44yUu3kFVSclw2m7xRB5l823vq8mTcFuN
   j5W3oO3VWyDYytyRqs5u6eECsPeKKSt9m7PY4SUMrE0oZhl7bt1M2Op5y
   Q==;
X-CSE-ConnectionGUID: hMg0DDHaRSSPsNxU+A80yg==
X-CSE-MsgGUID: SWts08hOR6eXlqgGpt6kog==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1203107"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1203107"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 03:42:44 -0700
X-CSE-ConnectionGUID: ZT5e/rCxReqtK3GbdzoKTw==
X-CSE-MsgGUID: CeDLX5RzSyeDAPc/Q+6dbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="2977734"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 03:42:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:42:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 03:42:42 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 03:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg8PusF9Zisq4zfl4XXVS14Gwdy/aa0MOlwCm6xFRdI6V6SFLs4Nx2PAukdB7cwJwLeIzWlC37c1IsR9l21tALFXb7rlwi+dgYS1TxVI/qff659uUkyK68FS6pvVouMtd6D4nrZJhCO/v4/I8AoT/dx3xxB3TQXiEbC6D+MxCNTpS+bz50EOREmypink3V/A913Pgr4s8FANwdn1qFSw3oqpXnOAGlFWYu28aKKowkLEmzFAQspA8d34UkSfNuolyJMc0G1ewzL+lWDYc0cPn33K4a89mxbezmdqOvqCL5zoyzgJ0h8FkVUDHsV1KLCuZ8MoGxLREm/FVI6eM1iDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Onam8maLGxmvBPb5HmqjKX+ZrF5mXhuhVDoUBIOg0Y=;
 b=pQ3hXh9AhpVaxVh76TzAMQi4/YMXkIBcT8f8yIed1Of0/jmACWgBybQEGyPOBw6gZOj69XoKPfLYUfkOOQKTGebinPVHlTkBTtwpmnLSHWFmyzX8x4VvTm0GW2Qmzr+ARS11WUF9zQPMRxAsUmIA0Tx6UOjh8+UnjmgnF/HLg4TPVpp4GFOIqp1LtlKT3w1ijQItj5ESNAVrkDJnylP+lfmYZPAkCCPv59gr7fmdh6pCduYNwjCw2fFCus23sCIYLoV9mj0k7jV4UbC0LQQRBWIO7LyKrohCLLJ+WvkuPydjtzLjjP9y0wf2vvYMWci6xv+OVu05iMtbgAKILmFxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SA0PR11MB4702.namprd11.prod.outlook.com
 (2603:10b6:806:92::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 10:42:40 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:42:40 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Luigi
 Rizzo" <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, "Hay,
 Joshua A" <joshua.a.hay@intel.com>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 1/2] libeth: add libeth_rx_alloc_gfp() to
 specify allocation flags
Thread-Topic: [PATCH iwl-next v2 1/2] libeth: add libeth_rx_alloc_gfp() to
 specify allocation flags
Thread-Index: AQHdYA2+C2jevByO20WzKVnB9Lk0kbcH0ZPQ
Date: Wed, 21 Oct 2026 10:42:40 +0000
Message-ID: <CH3PR11MB56689594870954B4FC1D31E2D5E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261019210604.2433620-1-lrizzo@google.com>
 <20261019210604.2433620-2-lrizzo@google.com>
In-Reply-To: <20261019210604.2433620-2-lrizzo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: b3897ac0-d4c9-450e-796c-08df2f600801
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|6133799003|18002099003|10067099003|22082099003|56012099006|4143699003|261009223027099003|11063799006|38070700021;
x-microsoft-antispam-message-info: ++hUgfgzGcTgtSiEUPmZYkNZBf5palZuFTP+GOhO60GuHF89cSQCFF3e9Vtqimp3sjJrhq5Pdd+X0Rwv14TiOTAEudFLS8WAyrm8+VH24++hbo0V8fwasXY/r/uX/zSpaX5V9DsOcomyHX9QmaNms6nasMFNF+62A9tJGrCoTaEds1i0XNIkNy4RI959EtLQPdP/0R1K4l2zVF9Xo853g4kozaFy3tnAFzzwqf2XK3o+yV7xQuUE/aC7cZZcOXiBOSqRjSCS0ezK79ucJtlVEz6YlQucGl9shz6ylX75wceWzK4XakO+mc8aCcKAJJS9/VU1umseAYuH9cpItMnJ6/HZUe7PPhDkFPC1GzUoDzScQLXzXMnO8c50FjJGUOIFEHgAjljC/nlT1fzLvAZ60O0k0y5ID6EEIxG8m9yQV1xjozLQ7vGbr0bLFGVTt34oaiFAwq6L/11u/WCEqUTNLiGdOsJd4D5wPeDXLqOY2FPzPdtNaQj07+p9+bHYAPyOfeG0J13PKwD0EhRxrrSwPBZDMg4AUfqn9wCL2sN01xCyvxdWwW8TePxIRegq5bp5ZWj6jcGsrTxyqRflTHnGH9zlO7pNM/zSc1WBQO5oxx2127zVfuh5lm+YE+z20dWL6JrskBUGRIWLFd8Dru5eLbsDYDcYoIO0JvmWOlSk5s1ODz1Rkj1IlKl0rehMRJzoDpNjvM2lrKZXD13KNHC4X14ci8PmrBgLfjjMjf1RwV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(4143699003)(261009223027099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2Z4cVRFblcrWE8ycXc5VlEyT2M0V25WdjR2dnJYZWI3S1NDcjUyeitTUzBZ?=
 =?utf-8?B?VHArZjhoUSs5TWkrR2xlQ2lmZkVVSEV6YjRNMjI2Z1RoRHNzK3RwM20xVjQ4?=
 =?utf-8?B?R3FlQmV2RUpyVktkSDUrOGlLR24yZUMvbjRXQ0U4YWJJYmZZeWc4ekpkZDE0?=
 =?utf-8?B?YlVVTTBIdFgva2hHRmoyNUNCQmZZd3JqM0p3Q0JidkthdWRwODluTjZlaHJx?=
 =?utf-8?B?MkpqdGJsS255ZEs0VnNDU2ZadFBrMU5IbEJMSHhCbHdJTVhnSHQvejZOVVhN?=
 =?utf-8?B?VDdZZlVFM0drUVdudHdMZDR0RzZHNFROVmxnWFBoNGRlTjFuUmhqdXpBSjc1?=
 =?utf-8?B?ZTZldnZMdHlTbmlSK0MrZURsVHhocjFZUittcE1IcURkTDZ3NmNxSU1tUjMv?=
 =?utf-8?B?SE1DNjdQV1hFTktOTzY5Vy9zNG43MXp1cTdTQ1pEMWRidzBEL09Rd1ErNkhO?=
 =?utf-8?B?SEdBS1lKdVNNMnBmcUZCbXYwZGw1akNvR1NMT2trUVhXMjFpYnh4UTRFNEpF?=
 =?utf-8?B?OUNEZGEvSTQrVFZZalAwK0RjK3FYd3FzV3haNDJIT1FYMkdITG9KMjVQWnoy?=
 =?utf-8?B?dkpKTG9IMnVQTGt3RkxqVi8xRDMzVVpQRTBHYjRrZXRaTk1nYldPQWMxdWhr?=
 =?utf-8?B?UFF5Zkxka0xwQTBvODhPRXJPQk5iVXBSL283SkpUSVhGOHFUTUZhQTE5bE1T?=
 =?utf-8?B?Z2NsanQ5UFNXS2JUVE9yKzdPUGR6RGtNKzhab2JmL1RvS0twYTBhMHN6T09v?=
 =?utf-8?B?TGR2ai9WYTM1Z3NMS2c2a2pPaWw1T2t2WDRkQmhUb2xCTWF6LzlHRkR0OHVO?=
 =?utf-8?B?YlA1MnQzMUt5RFJzd1FZdlpCOE5VVk9Na01lbE5xWlB6U0FoQmRRSk9MWWlx?=
 =?utf-8?B?MDR3RjdOYVFwVGFjZDdQQ3ppWjZVdDNZeHdsbnBjSml2L3BGRXRVWU1EUXZa?=
 =?utf-8?B?RHZYYnRqNkdsWjhHZk15My9VVWpmbXVUZFpGRTJpeHo2UE1IUmxBcm5TYjB4?=
 =?utf-8?B?eHBvNDdyVlpubC8yRFNDS05ZbEg2VVJUUTY0SGRvK2UyZDNmTlhBNk9DREhV?=
 =?utf-8?B?QXkxNFUzRUs2dW9FUmZMa2Y4WDJ6NzNHNTFMdHFLOEpmZndCajNsclN5ai9I?=
 =?utf-8?B?eGVQV0VRUGhjUFJjSHVlQnRTczlsQTZiZEV1R3RIdFhXS1ZndFZIWjhiaERV?=
 =?utf-8?B?dGpjYlhtOTR2WmJrb3R3MEhvbzVaT25KN2M2T2xHZDU3bkV5aDVRUEVYM0F0?=
 =?utf-8?B?ZElBcS9Ta3RYQ1ZUSVdtbUNZcFF0WVR0S3hydlhZS2FZNmVTMDk0K2d3V292?=
 =?utf-8?B?QndRRGxiT0k1Z1V0aDdzRHVub1Z5WDJGRDY3MkZ0ZEdwNWdZTmkyMThnUkVp?=
 =?utf-8?B?MUpFNmhHREdxMUUybHordlhaR0xoNGxURVVZS3RNTTBPSkJ6NmF2bk01OHhm?=
 =?utf-8?B?bzNDa3pTK2d0eHJtc0d0cmFiajFXNEF4SjBhNWZ3M2RzeDdtNFk0b2pZaU40?=
 =?utf-8?B?TGpPWURVNVhTQzcvRW1BeUVtR3NNZ2FDTDR3Mkk3ZHJqTThpY0JyclNXSnl1?=
 =?utf-8?B?bkRqNjJwYmRpNkU5enJIZW9BMUZjQno2Q1BJTVc3ZnBvQU9MM0ZNUGNicWJT?=
 =?utf-8?B?WlkraEZYZ29XZ3NRUitBS3NyLzlhMHM3UmoxMWw1aDBaUTNzRGE4c0hTZlVL?=
 =?utf-8?B?bTlHaVVBR0xldW5rTW1RRkpEVVE4aTRON2UrZDBPY1dPcHBRdGZyc3FQT3dh?=
 =?utf-8?B?czBNNWlGa2U4OGNPRFpmUFE0emNjY20xV1VmMDByQU42TGpmYmFxTUdzZi9i?=
 =?utf-8?B?OEI5SXFBeW4vNHZNTlllNGVpdVFKY0FYTUFTeDRaNXFXTjVyR2R3SDlLbnUr?=
 =?utf-8?B?STlHTjZqMk5SN1YxQkVHTlV4ZWRRN2U3SVNkVWpKU2VkUE5GQ3RqQ0RqMUpV?=
 =?utf-8?B?N1hmL2xURjg0L1oxQjEzaTBialNraUhKZGFhaVYxejl6Vld6ZWd5ZUVYMTZJ?=
 =?utf-8?B?SkExU2NXdzNkd3ZVVlFtOWdGWXBSemU2dGJ0WjFoSy9TVVkvbVRxU0g0T2NO?=
 =?utf-8?B?eVJicnpiNWtvUG9KaVhTQVA4M2JqeW5wQlUzS2M3VExzN1ZHUmpxOWZrM2Qr?=
 =?utf-8?B?OXlWVllaa1YwQldFTHlmL3VzVkFYMXlnR0E4STYvZVNaRVkyNlovZi94L1pG?=
 =?utf-8?B?R1lod1BvY2Y4NjBZLzFLSXlTaWkweXdpNDkvOExYS01EZExtYWtncXpXaUZi?=
 =?utf-8?B?YTlLdFlBbWpQRHY2bjFyQW9XWHNkMzcrZmovUm5IbUJJM2UzTDZyYjFJTk5Z?=
 =?utf-8?B?UnllRXJROXQvbWFpcGJJTTc4ZXc3V2tzM3NKWS83UVhTYlF2Z0hMWjZjb3hE?=
 =?utf-8?Q?ESYJC0crpU9jGK4c=3D?=
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
X-Exchange-RoutingPolicyChecked: zwJU9vODrM5cpkalUVl/RstpvB7kpMYfjYNQ0l9OL2GdqFnNW/21Qf5wLjjutr64dZbMaUhsjPPebdgFkszZ8h2GvMpc/twrZNWpdzCHZG4L6io46evHop5Ehkk/0xuiA3Cbu3qF/weZY8xiAQFh45wFz1G7XWDW6+r1VjTJ7D1mQzr9RQZr5nx8b6ItVJ3YNe9kyc3XrSgTuom8Uri2nMRmK+ue04VgOakfuRb8JQBQN5Gt33ER+UwOHTRUV/57iolrykum0T7e8Q6pitIwsQgLXeLqFNSdkXoMXR+jBYmE/UAGvyzz4cumiHy9M2pPSRXS4FwKtcTSaoatjOhS+Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3897ac0-d4c9-450e-796c-08df2f600801
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:42:40.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FEARRUcYUFARtbaqcosj6YMIS4Z6eesnnamX+vL2kElWY2D4h9EBC+0DrOTeEzgivLWd7KybqulEAGE4ynNMxTeiBJNmXXof+JK5ZQHoI+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpZ2kgUml6em8gPGxy
aXp6b0Bnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMTksIDIwMjYgMTE6MDYg
UE0NCj4gVG86IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+IENjOiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBOZ3V5ZW4sIEFudGhvbnkgTA0KPiA8YW50aG9ueS5sLm5ndXllbkBp
bnRlbC5jb20+OyBLaXRzemVsLCBQcnplbXlzbGF3DQo+IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50
ZWwuY29tPjsgTG9iYWtpbiwgQWxla3NhbmRlcg0KPiA8YWxla3NhbmRlci5sb2Jha2luQGludGVs
LmNvbT47IEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTIC4g
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0DQo+IDxlZHVtYXpldEBr
ZXJuZWwub3JnPjsgTHVpZ2kgUml6em8gPHJpenpvLnVuaXBpQGdtYWlsLmNvbT47IEJyaWFuDQo+
IFZhenF1ZXogPGJyaWFudnZAZ29vZ2xlLmNvbT47IEhheSwgSm9zaHVhIEEgPGpvc2h1YS5hLmhh
eUBpbnRlbC5jb20+Ow0KPiBaYXJlbWJhLCBMYXJ5c2EgPGxhcnlzYS56YXJlbWJhQGludGVsLmNv
bT47IEpha3ViIEtpY2luc2tpDQo+IDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaSA8cGFi
ZW5pQHJlZGhhdC5jb20+OyBTaW1vbiBIb3JtYW4NCj4gPGhvcm1zQGtlcm5lbC5vcmc+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMdWlnaSBSaXp6bw0KPiA8bHJpenpvQGdvb2dsZS5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV4dCB2MiAxLzJdIGxpYmV0aDogYWRkIGxpYmV0
aF9yeF9hbGxvY19nZnAoKSB0bw0KPiBzcGVjaWZ5IGFsbG9jYXRpb24gZmxhZ3MNCj4gDQo+IGxp
YmV0aF9yeF9hbGxvYygpIGNhbGxzIHBhZ2VfcG9vbF9kZXZfYWxsb2NfbmV0bWVtKCksIHdoaWNo
IGFsd2F5cw0KPiBhbGxvY2F0ZXMgd2l0aCBHRlBfQVRPTUlDIHwgX19HRlBfTk9XQVJOLiBEcml2
ZXJzIGFsc28gdXNlIGl0IHRvIGZpbGwNCj4gdGhlaXIgUnggcmluZ3MgYXQgb3BlbiBvciBvbiBx
dWV1ZSByZWNvbmZpZ3VyYXRpb24sIHdoaWNoIHJ1bnMgaW4NCj4gcHJvY2VzcyBjb250ZXh0IGJl
Zm9yZSB0aGUgcXVldWVzJyBOQVBJIGlzIGVuYWJsZWQuIFRoZXJlLCB0aGUgY2FsbGVyDQo+IG1h
eSBzbGVlcCBhbmQgR0ZQX0FUT01JQyBpcyBuZWVkbGVzc2x5IHJlc3RyaWN0aXZlOiBpdCBjYW4g
bmVpdGhlcg0KPiByZWNsYWltIG5vciBjb21wYWN0LCB3aGlsZSB0aGUgaW5pdGlhbCBmaWxsIGNh
biBhbGxvY2F0ZSB0ZW5zIG9mDQo+IHRob3VzYW5kcyBvZiBidWZmZXJzIGFjcm9zcyBhbGwgcXVl
dWVzLg0KPiANCj4gQWRkIGxpYmV0aF9yeF9hbGxvY19nZnAoKSwgd2hpY2ggdGFrZXMgYSBnZnBf
dCBwYXJhbWV0ZXIgYW5kIHBhc3NlcyBnZnANCj4gfCBfX0dGUF9OT1dBUk4gdG8gcGFnZV9wb29s
X2FsbG9jX25ldG1lbSgpLCBhbmQgbWFrZQ0KPiBsaWJldGhfcnhfYWxsb2MoKSBpdHMgR0ZQX0FU
T01JQyB3cmFwcGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVpZ2kgUml6em8gPGxyaXp6b0Bn
b29nbGUuY29tPg0KPiAtLS0NCj4gIGluY2x1ZGUvbmV0L2xpYmV0aC9yeC5oIHwgMjMgKysrKysr
KysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2xpYmV0aC9yeC5o
IGIvaW5jbHVkZS9uZXQvbGliZXRoL3J4LmggaW5kZXgNCj4gMGU3MzY4NDZjNWU4YS4uMTRhNTI4
ZWE4YTA3NSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9uZXQvbGliZXRoL3J4LmgNCj4gKysrIGIv
aW5jbHVkZS9uZXQvbGliZXRoL3J4LmgNCj4gQEAgLTk2LDIwICs5NiwyMyBAQCBpbnQgbGliZXRo
X3J4X2ZxX2NyZWF0ZShzdHJ1Y3QgbGliZXRoX2ZxICpmcSwgdm9pZA0KPiAqbmFwaV9kZXYpOyAg
dm9pZCBsaWJldGhfcnhfZnFfZGVzdHJveShzdHJ1Y3QgbGliZXRoX2ZxICpmcSk7DQo+IA0KPiAg
LyoqDQo+IC0gKiBsaWJldGhfcnhfYWxsb2MgLSBhbGxvY2F0ZSBhIG5ldyBSeCBidWZmZXINCj4g
KyAqIGxpYmV0aF9yeF9hbGxvY19nZnAgLSBhbGxvY2F0ZSBhIG5ldyBSeCBidWZmZXINCj4gICAq
IEBmcTogZmlsbCBxdWV1ZSB0byBhbGxvY2F0ZSBmb3INCj4gICAqIEBpOiBpbmRleCBvZiB0aGUg
YnVmZmVyIHdpdGhpbiB0aGUgcXVldWUNCj4gKyAqIEBnZnA6IGFsbG9jYXRpb24gZmxhZ3M6IEdG
UF9LRVJORUwgd2hlcmUgdGhlIGNhbGxlciBtYXkgc2xlZXAgKGUuZy4NCj4gdGhlDQo+ICsgKgkg
aW5pdGlhbCBmaWxsIG9mIHRoZSByaW5nKSwgR0ZQX0FUT01JQyBmcm9tIE5BUEkNCj4gICAqDQo+
ICAgKiBSZXR1cm46IERNQSBhZGRyZXNzIHRvIGJlIHBhc3NlZCB0byBIVyBmb3IgUnggb24gc3Vj
Y2Vzc2Z1bA0KPiBhbGxvY2F0aW9uLA0KPiAgICogYGBgRE1BX01BUFBJTkdfRVJST1JgYGAgb3Ro
ZXJ3aXNlLg0KPiAgICovDQo+IC1zdGF0aWMgaW5saW5lIGRtYV9hZGRyX3QgbGliZXRoX3J4X2Fs
bG9jKGNvbnN0IHN0cnVjdCBsaWJldGhfZnFfZnAgKmZxLA0KPiB1MzIgaSkNCj4gK3N0YXRpYyBp
bmxpbmUgZG1hX2FkZHJfdCBsaWJldGhfcnhfYWxsb2NfZ2ZwKGNvbnN0IHN0cnVjdCBsaWJldGhf
ZnFfZnANCj4gKmZxLA0KPiArCQkJCQkgICAgIHUzMiBpLCBnZnBfdCBnZnApDQo+ICB7DQo+ICAJ
c3RydWN0IGxpYmV0aF9mcWUgKmJ1ZiA9ICZmcS0+ZnFlc1tpXTsNCj4gDQo+ICAJYnVmLT50cnVl
c2l6ZSA9IGZxLT50cnVlc2l6ZTsNCj4gLQlidWYtPm5ldG1lbSA9IHBhZ2VfcG9vbF9kZXZfYWxs
b2NfbmV0bWVtKGZxLT5wcCwgJmJ1Zi0+b2Zmc2V0LA0KPiAtCQkJCQkJICZidWYtPnRydWVzaXpl
KTsNCj4gKwlidWYtPm5ldG1lbSA9IHBhZ2VfcG9vbF9hbGxvY19uZXRtZW0oZnEtPnBwLCAmYnVm
LT5vZmZzZXQsDQo+ICsJCQkJCSAgICAgJmJ1Zi0+dHJ1ZXNpemUsIGdmcCB8DQo+IF9fR0ZQX05P
V0FSTik7DQo+ICAJaWYgKHVubGlrZWx5KCFidWYtPm5ldG1lbSkpDQo+ICAJCXJldHVybiBETUFf
TUFQUElOR19FUlJPUjsNCj4gDQo+IEBAIC0xMTcsNiArMTIwLDE4IEBAIHN0YXRpYyBpbmxpbmUg
ZG1hX2FkZHJfdCBsaWJldGhfcnhfYWxsb2MoY29uc3QNCj4gc3RydWN0IGxpYmV0aF9mcV9mcCAq
ZnEsIHUzMiBpKQ0KPiAgCSAgICAgICBmcS0+cHAtPnAub2Zmc2V0Ow0KPiAgfQ0KPiANCj4gKy8q
Kg0KPiArICogbGliZXRoX3J4X2FsbG9jIC0gYWxsb2NhdGUgYSBuZXcgUnggYnVmZmVyIGZyb20g
TkFQSSBjb250ZXh0DQo+ICsgKiBAZnE6IGZpbGwgcXVldWUgdG8gYWxsb2NhdGUgZm9yDQo+ICsg
KiBAaTogaW5kZXggb2YgdGhlIGJ1ZmZlciB3aXRoaW4gdGhlIHF1ZXVlDQo+ICsgKg0KPiArICog
UmV0dXJuOiBhcyBsaWJldGhfcnhfYWxsb2NfZ2ZwKCkuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbmxp
bmUgZG1hX2FkZHJfdCBsaWJldGhfcnhfYWxsb2MoY29uc3Qgc3RydWN0IGxpYmV0aF9mcV9mcCAq
ZnEsDQo+ICt1MzIgaSkgew0KPiArCXJldHVybiBsaWJldGhfcnhfYWxsb2NfZ2ZwKGZxLCBpLCBH
RlBfQVRPTUlDKTsgfQ0KPiArDQo+ICB2b2lkIGxpYmV0aF9yeF9yZWN5Y2xlX3Nsb3cobmV0bWVt
X3JlZiBuZXRtZW0pOw0KPiANCj4gIC8qKg0KPiAtLQ0KPiAyLjU2LjAuMjEyLmcxMjllZGUyMGQ5
LWdvb2cNCg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0
aW9ub3ZAaW50ZWwuY29tPg0K
