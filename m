Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B933B975;
	Fri,  3 Jul 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083853; cv=fail; b=jOg17zcAYWpNB7X8ZDyXva4epco7bBGOJl7TyKOqGyVRJmHJH9dmGmmvMl7cW4brZI3BYdSlUc1giPFkT17aCjxEoBb3BGaZ1jzYTQuHboouvsc4L2N0/cn+hs2dbLdll6OAS0RHlJgZFFefUe0kOTJvuPqTV/c6oXWQmBVU/w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083853; c=relaxed/simple;
	bh=jsWxs8dZydzioeAs1o42bk/ZsXNuC1uiGC9e3Nbmsj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VALGwqD2w6ZlEuhJE7nfYfrCeO1BIyScxnjEnc0X2x2cPH4Y+d8qFkYmyCDGyjkfvUUnt+PtOSSbzhqbgRuKbLZfa2OHBpNZTNOHmlfnVzlqU0nou0nfp58Vdv506bw5ALLwoQQIdx33hXwvZIQM8EZyWk+GYIN6JuMgNfI3dYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noxgY4nM; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noxgY4nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783083852; x=1814619852;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jsWxs8dZydzioeAs1o42bk/ZsXNuC1uiGC9e3Nbmsj0=;
  b=noxgY4nMSWODDkgJB/H6ppR4RdsLZMLrfc91kNgeUUcbrnzIpEuablxA
   YpFag6R67aagqoE6/mt6HZ5FFifru3UIn8UypgFqjGfIPpQuaTvE4GEFU
   Ej2uPRk6eT2ncFBbe0VNDZILeYSpuyi/IRlj3nYEdFn6L9X54f9kRK8B7
   JyFUuNCuUNByNea0pAZIFzPfQq/t5bD6ges4NbkxA516Y71uzTCq9xIyQ
   7/AYmKMUNI5zMckrfb2isjmjquKsC6sYssB0YYya9CowyxOipTNi5cBC0
   tnKyPk0Lg1zeQdlOzGYalLoMscdZOg+TlEo1lEsCtdw+ptsM99MvP2Siw
   Q==;
X-CSE-ConnectionGUID: +Rjze+z8SomKMMqL+DOCUw==
X-CSE-MsgGUID: GRxoENpnSG6Mg0/YkORRVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83930599"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83930599"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:04:11 -0700
X-CSE-ConnectionGUID: Gd92jBzYT0mdF+TVdq6I/g==
X-CSE-MsgGUID: oYTbSDkeR/ekiXk52mcXZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="249754694"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:04:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:04:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 06:04:10 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 06:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjIFLGOij/fcHIAyy7PW9zZ200iByaK1+JofQz6tMaymNVp/y5LeJtrmnDqUcNy2GQ+uXbiofGZMq1oG6MrY5NC++zUssC9pdKlFQnyigQ/Toxi1puFWccxxin39PlJsRzPdvvu2bVpp6l5xjbskQGP+F/w1v1VeuPUW/WV7dl4vS6uQMqePppdmSTy3MbJMjxu/ZdqYp/qTMkgq/E0Z358nNJXaykNqlvqFhFim8fNc5aAPaJ9x34/IUiyVSnYbHjhAXp6FsWkY+ucMwsgTM7zCumUktcqFz/CB/+MOAxJ8zc9tmcdp+eBLHG8qfDwHbXRLo5GKJzBQguhqmS33ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsWxs8dZydzioeAs1o42bk/ZsXNuC1uiGC9e3Nbmsj0=;
 b=uMEMbEPyw5Bzcna72ZJhmS9/qSMf/aT7kLrWL/vSbxlTU/phBk0syKQLBTu8kckMjzgP8qhhFhdBJDFfUV8l0ZoUdq8UJ+BB75/IPVWeMfmZC+J2wmXS1EFjwJrdCT5sx7r0pCqT82GCjWHSAILcBdGeeVlmSYZEO5e87lyBkGMH+vb43oMlkQmVG1M0RgHG+U9gSb9ijycLbkDjUYHZRSiBcb0qYupLLITlTsf3jhsF/bOIsfEVrfoe6883JzKVLSIhjNvf99Cl63fChHjBwaDoTnX2rQTSsEiUiTvw9hIoVizFPxRYmQmNgFT67GL8lK98KeIywDPMht4d3LmQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:04:06 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 13:04:06 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Luke Howard <lukeh@padl.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, "Florian
 Fainelli" <f.fainelli@gmail.com>
CC: Cedric Jehasse <cedric.jehasse@gmail.com>, Max Holtmann <mh@rme-audio.de>,
	Max Hunter <max@huntershome.org>, "Tyrrell, Kieran" <kieran@sienda.com>, Ryan
 Wilkins <Ryan.Wilkins@telosalliance.com>, Mattias Forsblad
	<mattias.forsblad@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 02/17] net: dsa: mv88e6xxx: Introduce Marvell dsa
 tagger data operation.
Thread-Topic: [PATCH net-next 02/17] net: dsa: mv88e6xxx: Introduce Marvell
 dsa tagger data operation.
Thread-Index: AQHdCsFu9CrBenNRN0eYojK7REXBDLZbwyzg
Date: Fri, 3 Jul 2026 13:04:06 +0000
Message-ID: <PH0PR11MB5902B205AE515BD59B756312F0F42@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260703-net-next-mv88e6xxx-rmu-v1-0-991a27d78bca@padl.com>
 <20260703-net-next-mv88e6xxx-rmu-v1-2-991a27d78bca@padl.com>
In-Reply-To: <20260703-net-next-mv88e6xxx-rmu-v1-2-991a27d78bca@padl.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH8PR11MB7119:EE_
x-ms-office365-filtering-correlation-id: 2f6957dd-02c8-408c-3d59-08ded903908c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|921020|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: IWjA3FjCq+ZjaK5JgUMD7fUuUhh36jOuUOzhnNWzJPNfXHmmdTSHKhj778gsZtDn3BKFcuNEjc89acgMJyvD5of0v07PkkE4QJZntqNihc8ZZzZwudULAO+w6H7USNVNLw2iLZwbz/wJ2ZpBHrJtetRwvGlub3YNtEdbeRwxdCNErVlz/UZfOhFXhTWa2FA9N0p46Dlz337ycHnKbURe66gXvMNv1u+wS8OFVN6+ZqNccmf7A28hfnu4A1eGSxzprt6vDoQz7GL6V+TrQUbyvMohASYdbdtNCHV3OzRvy8Sd1LTa0UtGcCdQ8y6+VhVY2SZzI8nKDtTE85gVj9/r8NPFPk/0iq9e3rdfnvBznUXd+BCxduMD73mD69h/3ufEltq4mzQ9HF5tALb26A4EzK8RbeDNKo7eeifbV/8Gxomk49jZNMyrxCRUMaxRPAZ6l7jYOqgyWh7ilLOikf8ZuLtpugBNiDBTw0ECOaFVkZomWrsupW1LA9LxraKgkzCbDILoRaYzJ8dGUigJjew7/ib7zh3NaIyYA3qf8eKx1hNKpmdzWVX9lrLGpIfNq6L4IViYpr1lXNeeZcfTabBnJGMGWpkl36OLvPG4rRx6bBcOybDz/+iuGf5+GDQi4eACWW0FZNZx4c3Nd8MSl5Iw9RGEy0wwIPSKbYT6pGITGSorDF2p2gznlI3xYejOO5SbSZ1F+MYKCYK44ehSfgNM70qFPWjpBGPq3aMwrFLIopZEdPeoIs0JyHDYpF8vhvzz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(921020)(38070700021)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWRzYUxWNmlCY095d1RIS3llaTkxU0cyenJPMWh6c1prMERmSlZFTmhJdG5h?=
 =?utf-8?B?ZDN1dU1UaitrbVJjbUFCWTRvTElvZFJ5K21uQTBvcHVHSFRxT2pYdk5pQ0xJ?=
 =?utf-8?B?TVVXOUwxMFdwQ253aUZRZmJpM21wdHJQSDBYc2lpVzhEcjZBZ1dGM1NCVDdt?=
 =?utf-8?B?ZysyUkFwdlFjU0JuWkVQVU9Eb1dITFFrVzdua1NiWHZSQWc4ZGlIdkdialFJ?=
 =?utf-8?B?MFNmdUMrd0ZpQ3V3c280Z21nSHdhYzJkYVFHOU56TWFnUEcyTlY5UXNLTGx1?=
 =?utf-8?B?cjN2akVKMFFNL2wyOUQrelhGeGNtUWNJd1k5aTQxWWJ3KzkxVDRKTjlpL1pS?=
 =?utf-8?B?eVFKTUlyRi9DV0VWeEE1eW1oc0dyV3lIU0tPRW1ZV2JXZXovZC9JcWkyYjZr?=
 =?utf-8?B?ZlpCZC9zMHYySFhvM0xSYzR3bFhpaVNLbWhOZzNsUnVvRWNOM1ZNSm1DZDlQ?=
 =?utf-8?B?c3IxUnlsQWZCb0Z0SzdOSWMrYUJqOVVCTzQ1SUVGTjR0eXZNRyswRVBnQkRC?=
 =?utf-8?B?NS8xeDBYTlpuRVg0cHcvNWUrNVFCUnVyUXhBNS9HL01FdW5xUjA3YmNVRmZq?=
 =?utf-8?B?dVN5MkdkMGErMmxqckRIY2JrclNPUnJJRUVLa0NFWEJPaUNrR3NnN0VOdDJI?=
 =?utf-8?B?azhQRFZHMXRVQTR5Sm5uQXhRRmJuV2h6UUdZMWQ3RUc1YWZUTVZZbWUxQlZX?=
 =?utf-8?B?OVYwdktlSDJxcXo0ZlJIRTBNVXdLUUkxaGNXTlVReTU5U2tNWmpBNEFpR2M5?=
 =?utf-8?B?Wkc3Q0Y0V3prM0hPdG9PT2VXZEEycEs5b1I2bUVKNjI2RVUyT1EwcVA4dVVQ?=
 =?utf-8?B?VlRFTEhOZGdYMEh2VG9jY21xSVNxdEdNK0Q1b096cCtaVlE3NGJBNWVINUNK?=
 =?utf-8?B?anE3RnJ0NWNwM2VPLzVpVEI0cnNhNlZsV1RWQjE0TTFianF6czhwVDgyd1Ux?=
 =?utf-8?B?cmNRRmFaRVVsRjZWSExNUlFSWkgrZHU3SksyM2hCUm9QanVkclFGc0owWXNi?=
 =?utf-8?B?ZmJURnZTeVZna3RhRjVZdEkySGV5eFh6T3NzMFJQd2NsTWI0VThvUmVld3cx?=
 =?utf-8?B?RSsyNzhaZVRwanJDMjRVWFRGb2RYaVpyaGRBZnk1ZGRrdGZBL1B0ekVOaERY?=
 =?utf-8?B?OWpoMWVLUWtYMkx5dTFOek9SZTZURjVVaE5vUm9JNlQ3NldJSHphM1pGTmQ4?=
 =?utf-8?B?ajM5cm1FVXM5N0VNd2ZVVy83N3V5Sy9nSkRSeitJNDJwS1c4R3lJdGhwV0RM?=
 =?utf-8?B?SXBsQWtRNUI5UXZXbFNuYnoyT2Y0dFlFdENLM1o5cHplYnVUOUhTZnR2elJO?=
 =?utf-8?B?T1BqVVd5ZjMreW95N2NTaG1LMWZSMjNQQ1REODRXNDR3L3JLbi9FTzNqS2s2?=
 =?utf-8?B?UXBydjh5U01tRjNMMDZjMlFKN2pucjNwMTlHdHJhSkNRaEhUM2VFR2dJdUZN?=
 =?utf-8?B?c1dXWmhvUTFrNmxESnp5WWhHSFdtRkltUXFYeHVEWkh2RXVGVmdpQ0dUdGhB?=
 =?utf-8?B?dzNnaTRid1BHSWFsOUI2VVhSQkxXbEpKV1JLWkZtc3RpZjFFU0kwaG8rTi84?=
 =?utf-8?B?OFg4RmFOTFk1S005bk1hcEJxd0J0VmhQRC81L1hFMnFSZGZqVWFQUWN1WmRW?=
 =?utf-8?B?NDEzQ1B6Y3FhZlRycExzei9FcDZMSWNnSnJSWjQramRPcW1lTExCU3VWQUY4?=
 =?utf-8?B?ZmNacTN4NjI0dnZ3UFZJNU1JQ21rWEl0MnNIbDJVN3hqTm5GRHlVZExIZm56?=
 =?utf-8?B?QkhmNkNneFB2WlgwaDF3Z3pZTDgxVU1oaldOYTVTRHJVaXNJcXlXT05PVklo?=
 =?utf-8?B?UXh5ViszdUNTeDZ6eWZuSXFCWFF4cXZROEhEcW40Q3pkWTh5SEt4UUZVd095?=
 =?utf-8?B?OFZ6OFoxMXRMalNuaVBoM2RuRW02U0JJaXVpazRiUXA0VTlhZTJ3WGpMMDZD?=
 =?utf-8?B?RG4xMlVhU2RCT21Tb05EZENIbEc4cHVxeVVoREVGZXNPY2ZsSGdHRER6Zzds?=
 =?utf-8?B?TERPMXcySURiZXdlZ2w1YnczQ3VlVnNxaFJxdHBUSXNzMzNaQ2NOR0VwR1hx?=
 =?utf-8?B?SWRMdGp6RnZBeU84ekppaU1BTHRJYnB2bFV6WVd3cnRaZnJFeG1WQUJ0WTh4?=
 =?utf-8?B?eFRvYVk5SDdKN1l6b3RSZE11STZCWGJrV016aVBMcldLd05LeWZtSVF6ekdY?=
 =?utf-8?B?bVBpR2xVL3RPc1ZybXdYNHFCR0RjalZkQklqcDFMMFlaUUYxeTdFN1g2RVNC?=
 =?utf-8?B?bnlHcnphbzVyM1hoOTYzcHlraE81OThIYjRDVWZQcVBvNU4ra3pyMllwc2RU?=
 =?utf-8?B?U1QyZlhWMjhkWTVvdnNyMFdtV2FIa09xK3hSWFBHOWJGektRMWtxdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GVgZJvuba0LjlqQZUqSsTxUnzVdDFy+1dBJYgEkWsDwELD2/gs/GOtrFwPy7CvpLXZR+DIJAIiQhha8vH3FcqSW/K85sGvsbHxX6du4LAf84G6iFyhVSfe12jiS3KM4wR5TVqj9w4CS7a8tois+jfOEjmvQBVTXwZZOwWlvySZ9W5pZmp6g34KBh61n3Rdn1RWHEJ/EVbT6xv8Q5VuCIds8CTPOM37xQB6BoHdSSEo74QKX3vB7bN/fTDEbuyuEEH9jj8QuYGUZTFrePZj6TgQHvCoQuxtxop29qWE+4eESwKp5B0mkdum21CR0hZX+Y0xGgY/IvIBH0mXz7FcuUvg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6957dd-02c8-408c-3d59-08ded903908c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 13:04:06.5881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGYfS9ELH1ABOH85szMJDE6jjEmREcLuXtQDsH5OSoeN13Dx/2+7Mgo7HsGuydLjDmat5ctUGVq4bLje/iSFX1y5u1yx3SQCiPZImCPkBSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-OriginatorOrg: intel.com

RnJvbTogTHVrZSBIb3dhcmQgPGx1a2VoQHBhZGwuY29tPiANClNlbnQ6IEZyaWRheSwgSnVseSAz
LCAyMDI2IDk6NDcgQU0NCg0KPkZyb206IE1hdHRpYXMgRm9yc2JsYWQgPG1hdHRpYXMuZm9yc2Js
YWRAZ21haWwuY29tPg0KPg0KPlN1cHBvcnQgY29ubmVjdGluZyBNYXJ2ZWxsIGRzYSB0YWdnZXIg
dG8gdGhlIHN3aXRjaCBkcml2ZXIgZnJhbWUycmVnDQo+ZnVuY3Rpb24gdG8gZGVjb2RlIHJlY2Vp
dmVkIFJNVSBmcmFtZXMuDQo+DQo+KE5vdGU6IGR1cmluZyB0ZWFyZG93biBvciBmYWlsZWQgc2V0
dXAsIHRhZ2dlcl9kYXRhIG1heSBiZSBOVUxMIHdoZW4NCj5hIGxhdGUgRlJBTUUyUkVHIGZyYW1l
IGFycml2ZXMuKQ0KPg0KPlNpZ25lZC1vZmYtYnk6IEx1a2UgSG93YXJkIDxsdWtlaEBwYWRsLmNv
bT4NCj5TaWduZWQtb2ZmLWJ5OiBNYXR0aWFzIEZvcnNibGFkIDxtYXR0aWFzLmZvcnNibGFkQGdt
YWlsLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQoN
CkhpLA0KDQppIGJlbGlldmUgeW91ciBzb2IgdGFnIHNob3VsZCBiZSB0aGUgbGFzdCBvbmUNCg==
