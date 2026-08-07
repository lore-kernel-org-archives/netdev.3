Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4D41A785
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101506; cv=fail; b=j19bk635E/WZUIFQN0Kgn3yJcHhxKlk//A01eo8UPDcJU6EklhqcSxsmWiJG18jSYiKgnya6PStzrWe63UaQVjD7XWkt9RBMyhpc2iOiHuyM3JJkZNyA46PQQGTpj77ixcpvlE1X4BajFfDPfxA+j6tTwRy4oV9J1BzVQV03NJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101506; c=relaxed/simple;
	bh=yDuwQs7E+6T9D9/+0nXvA/9QodI/Jjwzwpk3PVT2FHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SCUVQFnOHw47qC10B+u3ZZwNNOlkoqfIHVVNAF4rNLlVnfQ3aqMVujP6hytp9m4iZdQpn79/dwTv3Fa5y6RZgO9NA75khdjS4CKR06ETpcvN/dR9beSD12Vrte8vDfjKVozxjsuF1C/a+qdMP3MZmO0RuZ+TrJnTvJlUW3GDOgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpOprg80; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpOprg80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786101505; x=1817637505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yDuwQs7E+6T9D9/+0nXvA/9QodI/Jjwzwpk3PVT2FHU=;
  b=BpOprg80EuB4kpiBVv89y68f1ZM9O2vXJijJ761CTeNbljO188oYVgtP
   6Yhmnb+usrB2spb3ACpS9zRhdxtShG4j+wwytoeaAgirmvmjDeKhhSLHx
   ve2r/sUiZyIq4GVul7bOLEHP0AY535pdI7RYxY4t2A6lfCui+kyGfo33V
   hHCuiYUpGgL09b5K2aG99qL2QaoUxdk1o6yb0PXiMgdcZBMUJj1lA+yD8
   iZo4BW1svo4hVm54Co7WshdKwziZKBX6u28MvTz1ge6ZSE2JpxmrpmB/u
   0TAWEbY/VDtGw1Ei2xsuaZ/y71grPu/W83jlrV9THt9ScHADpwDUIZzj4
   g==;
X-CSE-ConnectionGUID: I3xmJtkcQoW3Pc2dsxCF+A==
X-CSE-MsgGUID: 8HPGv1zOQuS7QTuhvTPL2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98067814"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98067814"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 04:18:23 -0700
X-CSE-ConnectionGUID: B0bE3uFMQNWL8fRz6HV+RA==
X-CSE-MsgGUID: 5LzYkeogTsK0Ek2yzOyvPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287055130"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 04:18:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 04:18:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 04:18:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 04:18:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4cyxlPSZT8YVw1FlOphkBu107SYEBHD7eVwQiszK4Gd9UeAoWThwgg0oBju7AO+p9JH3SKxk6AJZ82NVUG3yWeWkPlaROOtZtekJDnbUEFtkXslykt0SY4TuL5ZodJ+T5+2AGPWXRLJULU6/NDdoeoTow1pwnOyZ8EvefQpqKq3rGHGOK4XQ2bw85UZ1EkpRlqN7QcwnUz+taeqfoSJGrH/TnUfjysJGSHf9JsHN376cRGsOvolFWm8WL4+phTmBS6n8CdrLu0W5yBZ1RSdUlZqz1FSJAGBV40+OTkxZqH0X/k2wA+090vJDBqeB/OevCeMo0NbfRSoxB16HVb8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDuwQs7E+6T9D9/+0nXvA/9QodI/Jjwzwpk3PVT2FHU=;
 b=dNgIjkTV+TIsMSp7HGVwK+0uboSnB5nEwup3SCv6AXMCH8nGkYMhu/cSyNrTF6k+8Ohi/QXBv17ir1+CibAiO84JoyG6iPz59W5HlnKhsfK4MHK0klz/aD7EZ+IKoGtQTkhMxIHmmbwPXn9hK6G83OeKvJr+DBn8dy2wdVFtqzlbhSe4aJDKcEc2y651Xa9iMLe/epDcAesPDI6vkMyZNO+bf6olV83bEQOpv3abS1eB7w0P5zSOscGIUPGNNG7l3p3+tlNGyX01lgz+MNpNkxDQdBLz97sVUyyu/wgBJoyejFZjPqr434CvL4vz6oWS4gOmI/hj+4lR6GU9iWgWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by DSVPR11MB9693.namprd11.prod.outlook.com (2603:10b6:8:34c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 11:18:00 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 11:18:00 +0000
From: "Das, Shubham" <shubham.das@intel.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: Lee Trager <lee@trager.us>, "Srinivasan, Vijay"
	<vijay.srinivasan@intel.com>, Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>, "D H,
 Siddaraju" <siddaraju.dh@intel.com>, "Chintalapalle, Balaji"
	<balaji.chintalapalle@intel.com>, "Lindberg, Magnus"
	<magnus.k.lindberg@ericsson.com>, "niklas.damberg@ericsson.com"
	<niklas.damberg@ericsson.com>, "Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: RE: Ethtool : PRBS feature
Thread-Topic: Ethtool : PRBS feature
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAGW4BSAAJtcogAAPdBwAABO0owAAG26fAAD6e9ZgAAPKZQAAFsd4YABPDrYAAAbkChIAAZiPgAAA8RcAAAL+94AAAJsL6wEGjQLQAFwMWQABSmmV8AG6PMLwABUxooAAk180gABa//TwAb/Se/A=
Date: Fri, 7 Aug 2026 11:18:00 +0000
Message-ID: <SN7PR11MB8109BF8590FC789586C326F5FFD12@SN7PR11MB8109.namprd11.prod.outlook.com>
References: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
 <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
 <CAKgT0Ufpp+AVrW4raMw=_PEWQdu+dkp+9xhrt1se2G7=CS83iA@mail.gmail.com>
 <SN7PR11MB810921E7DA70DB3F6FD1C41DFFE82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
 <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>
 <SN7PR11MB81091D62922BAC1AF7A553ECFFF82@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB810996F17CD8513F4CD57371FFCF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <CAKgT0Ucz8FT0EvdUMm=dUS-Q171ZuT-i-n+mahJV3OvQnOMkyw@mail.gmail.com>
 <SN7PR11MB8109B6F350AE2E5BC02C6E1EFFCC2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <SN7PR11MB8109AD2F25C4DE21C048C9CBFFC92@SN7PR11MB8109.namprd11.prod.outlook.com>
In-Reply-To: <SN7PR11MB8109AD2F25C4DE21C048C9CBFFC92@SN7PR11MB8109.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|DSVPR11MB9693:EE_
x-ms-office365-filtering-correlation-id: 63b85e39-323f-4041-fecd-08def4758a58
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|18002099003|22082099003|56012099006|4143699003|11063799006|38070700021|10067099003;
x-microsoft-antispam-message-info: 59Oy2ro9hWC/PoFD2PU59ep/56gLKdhGcCbY+xm1hElh13NKtGvsfygVv+i4vCp+eNMtFf6iFyWzCvq0/yknRvBJXqODerPasjK2K8YlUgZC/BI3acSGcUuL7yMUPQ0QF4UTPwo6eXwZEEDku62HyicZqo2qU4e4+i68hYwNjGAOSOZDGu6GfU0C+HqFzVHgJyKcxhPWsnWe+a552Wd2DF2tf9yNXoK0gy5zT7z6eDEakSaEUULUZbqKxmDmQoB8XhQA/A4d03nFRYQDfgDydOij6pLI86oRY5ZuIN2r46TPHE1dJS9Xn16bawdXRHFd7KDMAb3cmIH/ZRmh4qqey1enEhK5c+554hqJq9g0f6IfcjyYMZ1ntfUVzE3tLdph3Wa/OswZw2RCuG1o6uvQR82NbO9PoiaciOltywJIPMvkPtJYazD7hJsuERuiIk00EZKD581rKHcVGI7Q9kXv7fx1XgN7SgHKytG4azEYMAoEWzqgzZJSXY7BODkE9Qmb6vab1BeWtSSa43nDtehzw2UnUErxQoEKfvq/lF/2r2FBPelZOMbh+Bu2wEGMd7vdHXW9oevuXt1gV65GKnUaX0+f9R1OFmsDiVghZz7gb+4fghtZeU7dbo0PUYunsRuZfLwE4KGECV9xBl3t+noDYG++MXTN5YhUK0GVYxSV9SBXGxDKgv7bNYe+eT9t8MXKe9lBq+Y//CMzMsOsIFCj7uf7dT7srm9SVRlYQJQEIGI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0RNaVVkTmcyaER3TzEwZTNKMGFRSTRTWlBraWlaOWRNMkFoTE0zQ21XckQ5?=
 =?utf-8?B?b0pHSHBJUG5PZlFjRnMvZVphd0ovR2FXRmxmWTJOV2NCa1JwNzJiTlJwdjlD?=
 =?utf-8?B?czdtMmNhblNFRm9RMXBodlRmR1dCajhxVG0wSkl0ZmgwdnM3Njl0UDhseEZW?=
 =?utf-8?B?Z0R6Q0ZHYzdtYjkyQ0Q0ZWsvSGczSFJWTFR2WEtBN1BlTTU4WGdRa2g2dERz?=
 =?utf-8?B?Ni9TN1FtZzBnMkFlRHdZbXZyY3Iza0Z5YUorQ2QwRnVBRytmRFVydWxYRUJw?=
 =?utf-8?B?bEd5WmVFdE9SZEpzSU1oR1FLSW14OVdMUnpRRHZETTFHQkxNcG1iUDQzcVpY?=
 =?utf-8?B?eHBHVGEyNHJvYm9McWIvR0hlOGVtZy9YaWlrNmlRTlhoMnllc0Uvb0M3b1Jo?=
 =?utf-8?B?VHdwU3ZrdmtMdjVCZlNDNVl5bitiQjhjVExENG1ESUZuVkYvZi9wVFBvU3kv?=
 =?utf-8?B?eXhBeHVBbmU3WFFPYW5Ma2wxTGl3cUt1bWtxazR2cVFGVVFuL2VPR2RkU1Z1?=
 =?utf-8?B?a3NmbDE5R3NuMmR2WUtwZ1U5blNhZkp1QzY2UVVWNm4zYnhFaTVkeG1qL1Jw?=
 =?utf-8?B?djg1dG82STZyRGtuRzN2RDVWRWNzWTg3dGdXcC8zVC8xbE1tT0ZkbS9hQWtD?=
 =?utf-8?B?Z3RScG4vSHd0NytoUlhUd2tBNjJyVy8yTVdkYlJDTWlSZzhBREpmMVFWOE9p?=
 =?utf-8?B?YU43Q1l5c2dmM2tjdmI3T1U5aTIvTkk5cTBEYVlROFp1VmlXbUFxbEl6ajFT?=
 =?utf-8?B?S0RITWVGa0tWZENhaSszWFMyTVpTdllGb05QazBEUjlXNjUvb2NnYm1QbmFp?=
 =?utf-8?B?MmgweFZQVlNpNVFaSW52eUpqSnN6QXE3eDdaK0w3dnMySXN6bEFPWjZXZmlj?=
 =?utf-8?B?OHRQdFlic3hjaDNDNXR3V2REM0NwTFViYlZad3FMQ0NOVnZZeUlyRlFBZk0r?=
 =?utf-8?B?ajJHYjZwT3JOVlFjRW5MOU01SWcwYkM5SytOd3dpS2NnaVQyd2phL2tNWXlZ?=
 =?utf-8?B?S2Q0UHpTM1lUd1lSU25Ed0JwVHd5WENmNWRrQzRsUHpxN1FxZlVVSWJjMGpY?=
 =?utf-8?B?eW52NE0waC9GRHQxOGcrK1ZhM0JBNGNXUzZ2SE9va2RLd3gyWEgxNDdFQ2N4?=
 =?utf-8?B?YU1CNFZSQ0NLbExBTm5kRHlxcTIyRWN2V0hTcEVMMDBiSExCYWZHVmY1YUpa?=
 =?utf-8?B?SDZCZTByNHZKVDJyVnVGbU9yVnpvTDc4d2ZBTnhFaFphNnd1RU5nU0lhTS9l?=
 =?utf-8?B?bmdHZnFteGNMb3IwTHBWMCt0RHQ4KzdUNCtLYkV5cEpaWlNKZG4zVm55c2Qx?=
 =?utf-8?B?OWdJS3VUQzRUOStidFJDdWdPekMrUi84QWlEaUZydkRHbVozS0tBZGlXL3Iw?=
 =?utf-8?B?NWgrNkZac3F6UnQrb2w0bm43Z01jUkNoaE1kUzVMYU5icDVvL1d3YzF1R0ZI?=
 =?utf-8?B?cGdMK3N6MldOeGM2SHQvNjRQZ1A0N2J4WW80WFdvaGxWbjExbVN2QkJmcGZa?=
 =?utf-8?B?aHJpY2k5OGxiSjhFQnZsWjRyYmF3WEY0OHEwUEVKNlNKZy90YWZSanhyYUxa?=
 =?utf-8?B?NmYzTlVLRjNzRng0MFY1cE15czk0b3M5RC92NDRtNWVQZjRKNHVvbVoybVRM?=
 =?utf-8?B?dnF2MW8vVW1DUDhKVVN2RTVjQVpUS2p1NHRpYWx6OWZ4MllaWGNiU1Y4L0Zm?=
 =?utf-8?B?WGFydGg1aXc1UlZ4L0tZTDl3QStvODZRRHUwdVVlcWQwOGhyendZNzVRUjV4?=
 =?utf-8?B?SUJVNVB3dVUrdXlSQ3pSWStNQ0o3OHBsWWthNnJHVHJWeEpIQ21kZTczcGti?=
 =?utf-8?B?ZkZnNlZheGZWSkdycWZyejM4Q3NrTnZSV2IzVFh1S3BSSkNheWFwUThQL1JM?=
 =?utf-8?B?aGtPdWhmOHVwQ1ZlbTdORXE3VGdMTFRsQ1k0cE9JSjEyYVl3akFSK29ITEFq?=
 =?utf-8?B?RU1BMU9MZ21jMjZscFBNSEs0NnRWRktjVHZENVdoQVZYK1p3d2FEQTYwNkRN?=
 =?utf-8?B?cXUxT29VZjRqdUN6TldvejVHTGdqSkNLT1M4SjFoQVB5NXI4L3pGeDBFZDgy?=
 =?utf-8?B?UmtXWGdxSVE2NUcrNWVMTXpKd2ZaNUJadk9ZMHFtdGMvUXZaU2JLa3ZQcEhV?=
 =?utf-8?B?Q000S0FHalJUMlFCS1hBNjRVUzBJVCtvM3NpdFRsSXBidGZMczFhMjFHNTVm?=
 =?utf-8?B?SjFqdHlWNGNLclNUTTkwR1J0ZTdmMmlGdTNZWGVkUlpCanZNSzNDV2ZacUpW?=
 =?utf-8?B?Qnoyb3ZZNy9QSFhTK2xZdnAxd1BnaWhwMUdPaXhpeU1vcnlmelJEMUwzRFBD?=
 =?utf-8?B?N2lrTFA5QURyblhUUWllNzZXMXJvakp3OXNyTzVxTFNDMzBjUE96TGdkRWhS?=
 =?utf-8?Q?7thWYe35prc4KprY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PeqJyUhLSgzaGWrVF3EFJG6Rw070CzAh/WT+sPWwRMHddCg6feKRd7T0rwT5D8rQJwSZoPZVn11cuMJO/tlQ2LjDQBdIKfCvIV6S/MfFOj0IAyNIvZNCo1/32ZA228vr66Hq+QT3H/7xSjS8nl5zX/yHyJ34LwGry//5pKOcG2UxhlUY3YsDgc3xahRbXap7RBdw47dp64dsez94qkNeZkaBUaaJcsMJ0JdVLFn5joEs6Zgsn2kdOMmkrmmfJTohPaXVZrztA98OYQ3H6VYizwTWzPy4C79zDaNhCHyyTMLrgcszRtv+R8mpCvNC4ZMO1VOkHXqIQJmSkI6oZ6Nd5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b85e39-323f-4041-fecd-08def4758a58
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 11:18:00.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u12v3CTgyXPxwXmOGCxD2NEKAC2HBBWux/hU3G0S5x9IJkMgMUhpwyx1k6IaLNRi+mXH8Pvi57XsnOkLuoffJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9693
X-OriginatorOrg: intel.com

SGkgQW5kcmV3LCBNYXhpbWUsIEFsZXhhbmRlciwgTGVlLA0KDQpKdXN0IGZvbGxvd2luZyB1cCBv
biB0aGlzIHBvaW50Lg0KDQpXZSd2ZSBhZGRlZCBhbiBpbnN0YW5jZSBmaWVsZCB0byBoYW5kbGUg
bXVsdGlwbGUgUEhZcy9jb21wb25lbnRzDQp3aXRoaW4gYSBuZXRkZXYgYW5kIGluY2x1ZGVkIGV4
YW1wbGVzIGluIHRoZSBsYXRlc3QgcmV2aXNpb24uDQoNCkknZCBhcHByZWNpYXRlIHlvdXIgZmVl
ZGJhY2sgb24gdGhpcyBhcHByb2FjaC4NCg0KVGhhbmtzLA0KU2h1YmhhbQ0KDQo=
