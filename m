Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CCC4322E2
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177473; cv=fail; b=m0OFyDvyQr7y9Yw4FOn+s9TlCtFK3iDNtEqNI9jjjuCCXrm0nY2kE/ILzBZjLxhcA5yg6Rz+JjJg/8Ms+v6MLYdJms4/Zz99FskMMyZ7/H7bTOmSASWxnttmiEojZDlN11elZKZ3GAltxW6wgDJtSzrzTmDVhDrvxP6YqNPnfe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177473; c=relaxed/simple;
	bh=sLr2aUXgJ2iZW//zsuAyZyjCL2HOPsStnWjgEn93Zrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pZ5uXJQyndMtRnZip6j73pTp49ydegUch+YoOfTgt5wCvH+6VR5hIpdVI7//XcvfHqzREaUWmYmL1v14ubVYaB4GobShOYrwDJVX8/cw4huX4H0wHC6NsdbvZzt9hJGp7uBJ5wE+RSbo9DxmLJMYv0C5mgLXBhlzoDFxFmN2oaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrvXDf40; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrvXDf40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785177472; x=1816713472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sLr2aUXgJ2iZW//zsuAyZyjCL2HOPsStnWjgEn93Zrg=;
  b=MrvXDf40fOagCtbR3VNQBc6efgbSMlbgKNWzavEpOYREbYlF/qyJo4mE
   K8tiXuVbZs59f9SIYIYwlEp6RRgclJ1x/Uw9sS+v9YXT6HfepKNaEw991
   d4igGMbAuPYifQKuFgmKUNmsS+DoBwF8svpX0wgRHnPKacdz/MP/xQOJ2
   HHp/LxWFRiBIVvdKuXJYwyUVNuVsjyLsobDXN8UlxlofNqMqCJIDZ8CDf
   XqqVCg2wrGQy26lEJuNEn1itvxZgJUInphY9+9eCwpvPeHNqAfy1aEYOw
   wMNcxUDHo8cMGLFffEn75rs2SFOTDBlnhnwipYDVvQXTL05clQAK4p0iV
   A==;
X-CSE-ConnectionGUID: uFQK2/aFQ0W/Pt0Di2+k+A==
X-CSE-MsgGUID: Nmn329L2QLa1wiG1Ma34zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="111297968"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="111297968"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:37:50 -0700
X-CSE-ConnectionGUID: VD2S5weES8uamqaMVh7iLA==
X-CSE-MsgGUID: q4OaWYS/ROO6lHJ2t72QBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256813075"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 11:37:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:37:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 11:37:48 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 11:37:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTsKtsjDPbWijQ02/5iKF2IahPsAmK60PH2JAEhCBiaRdUuAdRESMHamNaQsMEQwKA48YCcrgAU1q/JJOlUTtNcsy5Fa6B14olS9kFJqW7bNsVHqzWQOptoIUjBgs0dLKIe8JRHmXR/NQkD5yuqaMJMS7/tgSHotl+s2BqLn5DPU/MCzANP1G1Tfc5gPOw5vQ9jVmFkiq8lqPbR+fiYzDBJsthRLDObXwfJzAafTzkfdJ2e5gXax3VDXLqqFa8EETEeL+S2fghQvhV5kTSDAQmKuNKqmpfc0qIaviemyZfCZPSp1P5Ax6zEHjbRJUtDJA6WTqZUJipmvj2tRUjCe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLr2aUXgJ2iZW//zsuAyZyjCL2HOPsStnWjgEn93Zrg=;
 b=rNkZqxn29QNc3mcmsd6TyDQXNxvONEWHTW+lE/QPqkhtHSWBfI9QVt8y6AXhXsGcDmKgxtExuLjSZJMl6QmL5Q2AuLSlHj8m4z5KZfbU+9O+2FJoEBg+dNImhcYAtGngcE4Aq3emZSz6m1YKQ6Rosogk8PedZas6B22IZyp36PfNQY4GgzQ40mLJe6PETYb6nme783MIw6XGGNQ3ZG9yQhu9zH9oxMRtlGw1Wbw6dIGoRe1TYsK0xhnhGKS0Kzb5jvVgQ63P6hUFynq4v+hv/RVC/9xCHDRJmHAXC4Gi06e4QRMjMb0tqJ+IOd7XPE0+4iRrxv+ebkEJDJ9GpkmAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by PH7PR11MB8276.namprd11.prod.outlook.com (2603:10b6:510:1af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 18:37:40 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:37:39 +0000
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
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAGW4BSAAJtcogAAPdBwAABO0owAAG26fAAD6e9ZgAAPKZQAAFsd4YABPDrYAAAbkChIAAZiPgAAA8RcAAAL+94AAAJsL6wEGjQLQAFwMWQABSmmV8AG6PMLwABUxooAAk180gA==
Date: Mon, 27 Jul 2026 18:37:39 +0000
Message-ID: <SN7PR11MB8109B6F350AE2E5BC02C6E1EFFCC2@SN7PR11MB8109.namprd11.prod.outlook.com>
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
In-Reply-To: <CAKgT0Ucz8FT0EvdUMm=dUS-Q171ZuT-i-n+mahJV3OvQnOMkyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|PH7PR11MB8276:EE_
x-ms-office365-filtering-correlation-id: f344afb0-0222-480a-89d0-08deec0e2349
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: k29F88VixGyr2wXR2tyO57+GyaMOPx8k2jz9+7CRGWaGT/Pu8ovB/aFModfFQ40nKGrdBp0l/LbrBB94wvT3M4ORrHhdJiEpREjv2LKl39qCsvB82SboLj8CYosMEDzAs4dtlBD0Ye9yO8mMiwekU9Rhh7J4otcrw8wE4ZUkuDj+dOE83OeX1UGuPivXwEWVpubkmJGy7K9KsXr+t2VF4fQUofkAdwtymlYpLn5Nx7B4vStlz/qLM/FyA6kT+hcDjGxrUhiOm9AUBUrJ/dAu9TozAhQ87Pj2o7NPP8eOv/S95V0jUI6+dudcfknVqi0/c+IQcvplIlRSBcLo8FRNs5yvjrkYt6PpkSw5rOgkovKVoFmtgFDDVxs05YbrHEFXQTiMTAq9lRZ3DGVo/MHozQQ9hi/NBBZ1beb4D+/lwv45UOSOHc10fDSGZ4FFxTgqPjrfNZcpqroY8uZQGnEG61VPtMG0P3vg9JSiHzX7+srnAKe4ecGvDEQvG/XXfniP7qAwpzPN2LDh0r2RtKsCxUllPaL7TfNZBJU+Wxw9kxokIMkBzksZ1tSgazyEouKKxHM6Lvi5IPwYg++65dHvLMShLXsZXXUPaM+vJvN3+dvEdnd3tu66Npw3j6b2GHOk73h75vFnJfoX1lw+RVIgN33V2baLlZqX7X1ZU8SFyznUbIPTze884rPPgVmKotEz8ZBCvGhyhsqb0jTSV/wMwS5At839Ozucn2pfRIaN4IA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enhYOHZmMzNFOEJTR0xCdTdCNk9Vekc3UkxxMWYwR0dUT25SR2N1LzJwV2gv?=
 =?utf-8?B?ejNPcHhkZGtKYWhJb29Vei81aUt2RXJPZTdjQVNzc3liVU5sVm0rYm01NVVt?=
 =?utf-8?B?ZkZRQmhHOEVKaHFpVnY0ZjR0MWx5RXdUZTVPOXh0cXBqN21zSEJ2dVBBUVpj?=
 =?utf-8?B?NHVKSkNLWVdJV0N1QVFqVExMYXJJNTZXYWtOYXVYMm9IWkVCRjVSaGZsQTE2?=
 =?utf-8?B?eTJUVUdXYWJEdllKSmUxclNrNEFNQ0lGcDFtMUlVK3lScU9kVmsxR2pCbzg4?=
 =?utf-8?B?a3BOUHJEUlRKQ1VWdTVobDdFYXRFL2NMUTdjK2w0VTNXZkpwMks4NVRYYlJB?=
 =?utf-8?B?dGk2WDBDcEZhS0pWemZTWE5nR2laTElKVjQ1K3NjZW9HbVVXQ3BjODJhMWJz?=
 =?utf-8?B?S1lmWmNLTlNBbDhENTJ2SUdTOUpnbzlzQ0FlZGhocGtrMGtoNVdFbEZqYm9z?=
 =?utf-8?B?Mnc3amRCN2VoRThnbE5VZWlYS0t0b3o0UFNoQWN1WS9ENndkanFFK1pNUlFn?=
 =?utf-8?B?ZmxuYmxhQURHUm01c0hCcmpVZjVLYmdlVE9TQU9jYVpaa1htUWZVY202dW41?=
 =?utf-8?B?MnNFUG8rVmhhYVoxbUpDYUZMM1dXanFXRGd0VkEyc1ZQdUJ6MmJYZEd5U0k1?=
 =?utf-8?B?UVJlNC9iR00vOW52UXJuZmNibVZtQ1RtNmpmLzcyOVJubEpMZ2JHbGd6YnRv?=
 =?utf-8?B?dC9iVjJweEkyQWQ1VmlmdkhZYTI0SFExMlluRldKb0FTVGZEZk4rbHlsQVpZ?=
 =?utf-8?B?Qld3Uk9vdnQ1TnB6dytIZGRIc3g3M2lwQzFmd2srR1VhYzZ4N3grV2lGOXJq?=
 =?utf-8?B?UzJOZmJGc2lheHYyU3ppNFlhM2RXaVJ4WkhhR0QvdVpTaXR2ZklFbmNSa1po?=
 =?utf-8?B?VGpkRWhnLzRUT3B5RXBXVkxteUpXY0pQdEFkdlJnblgzOG1ZUTc5TFJMRExB?=
 =?utf-8?B?VVh3VXZVbTg4MkJBTExVTG5MRDhrRHVXcGhYRjV4OFpTY0FnSHk3YXplemVv?=
 =?utf-8?B?dWkxZ0tyWExMT2FIbDlKdWtTVThzRjMxNHBZZVpTSXZaYVJjcDZadlRyOUxE?=
 =?utf-8?B?Qm9wMHVXNDM0WXA0N0hoOFFXNWE4RFZhYUNHU0ZQdEl3OHRqci9kaEM5ZnFi?=
 =?utf-8?B?dC9oWnE0TGdmZCtiQUFrZ212UWlLTnJvU1FUS3o1dDYxaGNvOGM3ZUl3eUt0?=
 =?utf-8?B?Uk5XT0I1cWlqd09wU1V0bEVERWFCNGxsTm16YXQ3dXFSdUY4MHYyRDg5WXFF?=
 =?utf-8?B?aS9lcXN5bVpla3cwdEF2a0RHU2lzeExqcEV0dEpuUWNSRmM4Mjh0Z0w1Ukl5?=
 =?utf-8?B?VW40eFhVQnpXT1Bvd1FmT3RZYnIrNjEwRFlOQXliSTVOMzBzOFJqMUc4dVVq?=
 =?utf-8?B?VldYMjFCVEhLTGVXZ1AzY2M3aFhteGlyb3I4bDRvVy9KSGtVaGtrTEhsQjBy?=
 =?utf-8?B?cmsrRGMxdk5DTzQ2Q1BScXV2dmE0ODl0Vmo2dkZXWUNWREs2OU1FZjgrUjNR?=
 =?utf-8?B?amJnSENKQ3AvUUJSMVlLY3p2V0Z2ZXUrSkQ1TVpBWkdCZ080cGEvMXFHWDZh?=
 =?utf-8?B?VEdqSUJLY2hndXkxWlhvU2JOb3FWQmEzQkFPQnM0ZUd1K2dtcUc1bDlBZGtN?=
 =?utf-8?B?N2FTYkRXUnA4Tkh5VmNpdDJESG9Mb2RGV3lJZnpYMUF2Q3VnN2ZNZlJFb3JX?=
 =?utf-8?B?ckJzVFU1VkVxbE1XT1JBL1dnTjFVYWYvYklmZ2Q1WDZSZ3ArOHF5ZkE0Ulov?=
 =?utf-8?B?TGw3aHg0aDc5K3NFSnZLSGFwRW9zVFpvWmpuK2Q2QVZhUDBidzVMUjdjQmpG?=
 =?utf-8?B?aHB3d1Q1MDQvTmhXUUtXSnBScU1LTTdKRmhWeGpScEFla3pKNUkzQ2hKd1ZI?=
 =?utf-8?B?dExsdUVyMU9USWxSSDdKZzJROW1Cb2tjVVlKcFBWM3Nhb09GYVdQQ1N6OFpq?=
 =?utf-8?B?aGVMWU5JL20wWGpPVHZHcTQzc0Z6aS9RRUp6bzlnNDRDL0pZeWo0RkVJblJN?=
 =?utf-8?B?TmtOUENvUzd6bnZpRTAyUjcrZTVsVkUrdkQzTlcrVThrUUVjSWU1Z2dlUG80?=
 =?utf-8?B?Qy9xV3daNFhSdyt5UUd3b2JPUVlIQzRhNHZPVyt6Q1Z6NDlmb3B5aFVDTGFM?=
 =?utf-8?B?cFpJTlR0V0xMN3lFekdiQkk2TDJkUWs0MFJmTm0wbGlLdUxRS1QzVlFiN0JT?=
 =?utf-8?B?M3c1QnpHeWRpTWZlTC91MnZ2cDNmUlJZV2NiNXBsWTNBVnBoKzduRFB3YUFL?=
 =?utf-8?B?bTcvTTRFeHV1WDc0MmZ4QVo4KzdScnN5UFVmSXF2RkppWjBnN3hxUVM4RzNU?=
 =?utf-8?Q?66kxwbTlzb1X7lhxn4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Rp4XItM0xrWWsugvWsyuTimq2URkFKZEsHBJ18TMRVY/G6UWVZb5Y5cufqsenkbZjMsp40gEUqPzhBtECLuv60K0v/yJH8IzbRAAk0wfhD7ZasGEioqzSQfgqBlcdNxS1SLrtnhYAb6BWvHNmn6pCQTYW5ioMVLINtB2ETV7aGPdQ2Lm4loPOTakKe1oKrOlGMdqrbp8rgpWgSVo/pht4TgnZUXLdIy+eKrUTYOGV6lxvF22scES8jh7SZDifDWPcGIA1b/A+0bFGgm3CF7BMo3o8d7QjTkZ8tn73SFWA4z0UQ1LLmy6DewqyefNCiPjuTh58LPUn5YaoUNFn/5x+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f344afb0-0222-480a-89d0-08deec0e2349
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 18:37:39.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARUvmeuUHUJbz4RY7QXTEnpZ9ry22xE0WyAgUvMhGRyk+QldJ7WPEOU+yvbP1reqOhhrK91YEWwKjUbgcOfwkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8276
X-OriginatorOrg: intel.com

PiBIb3cgZG9lcyB0aGlzIGRlYWwgd2l0aCBsYW5lcyBvciBjYXNlcyB3aGVyZSB5b3UgaGF2ZSBt
dWx0aXBsZSBQSFlzIGluIHBhcmFsbGVsDQo+IHN1Y2ggYXMgdGhlIERTQSBzZXR1cHM/DQoNCldl
IGFscmVhZHkgaGF2ZSBhIGxhbmUgcGFyYW1ldGVyIGZvciBzZWxlY3RpbmcgcGFyYWxsZWwgbGFu
ZXMgd2l0aGluIGEgZ2l2ZW4gYmxvY2suDQoNCkNvdWxkIHlvdSBlbGFib3JhdGUgb24gdGhlIERT
QS9tdWx0aXBsZSBQSFlzIGluIHBhcmFsbGVsIGNhc2UgeW91J3JlIHJlZmVycmluZyB0bz8gDQpN
eSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgKG5ldGRldiwgYmxvY2ssIGxhbmUpIHNob3VsZCB1bmlx
dWVseSBpZGVudGlmeSBhIHRlc3QgcG9pbnQuDQpJZiB0aGVyZSBhcmUgdG9wb2xvZ2llcyB3aGVy
ZSBhIHNpbmdsZSBuZXRkZXYgY2FuIGV4cG9zZSBtdWx0aXBsZSBpbnN0YW5jZXMgb2YgdGhlDQpz
YW1lIGJsb2NrLCB0aGVuIHdlIHdvdWxkIGxpa2VseSBuZWVkIGFuIGFkZGl0aW9uYWwgaW5zdGFu
Y2UgcGFyYW1ldGVyIHRvIHVuaXF1ZWx5DQppZGVudGlmeSB0aGUgdGFyZ2V0IGJsb2NrIGluc3Rh
bmNlLg0KDQo+IFRoZXNlIHRlc3QgcGF0dGVybnMgYXJlIGdvaW5nIHRvIGJlIHRoZSBiaWdnZXN0
IHByb2JsZW0gd2l0aCB0aGlzIGFwcHJvYWNoLiBJDQo+IGFsbW9zdCB3b25kZXIgaWYgd2Ugc2hv
dWxkbid0IGxvb2sgYXQgaGF2aW5nIGVzc2VudGlhbGx5IDIgc2V0cy4gT25lIGZvciB0aGUNCj4g
c3RhbmRhcmQgcHJicyB2YWx1ZXMsIGFuZCB0aGVuIG9uZSBzZXQgb2Ygc3RyaW5ncyB0aGF0IHdv
cmsgc29ydCBvZiBsaWtlIHRoZSBwcml2YXRlDQo+IGZsYWdzIHdoZXJlIHlvdSBjYW4ganVzdCBz
cGVjaWZ5IHlvdXIgb3duIHN0cmluZyB0byBpZGVudGlmeSBpdCBhbmQgYWRkIGl0IGFzIGEgb25l
LQ0KPiBvZmYgdW50aWwgaXQgY2FuIGJlY29tZSBzdGFuZGFyZGl6ZWQuDQoNClRoYW5rcyBmb3Ig
dGhlIGZlZWRiYWNrLiBKdXN0IHRvIGNsYXJpZnksIHRoZSBwYXR0ZXJucyBsaXN0ZWQgYWJvdmUg
YXJlIG5vdCBjdXN0b20NCm9yIHZlbmRvci1zcGVjaWZpY+KAlHRoZXkgYXJlIGFsbCBzdGFuZGFy
ZCBJRUVFLWRlZmluZWQgdGVzdCBwYXR0ZXJucy4gDQogDQpUaGUgcHJvcG9zYWwgaXMgdG8gZXhw
b3NlIHRob3NlIHN0YW5kYXJkaXplZCBwYXR0ZXJucyBvbmx5LiBQUkJTIHBhdHRlcm5zIGNhbiBi
ZQ0KdXNlZCB3aXRoIGEgY2hlY2tlciwgd2hpbGUgdGhlIHJlbWFpbmluZyBJRUVFLWRlZmluZWQg
cGF0dGVybnMgKHNxdWFyZSwgc2NyYW1ibGVkIGlkbGUsDQpUWCBsaW5lYXJpdHksIEsyOC41LCBL
MjguNywgZXRjLikgYXJlIFRYLW9ubHkuDQoNCklmIHRoZXJlJ3MgYSBmdXR1cmUgbmVlZCB0byBl
eHBvc2UgdmVuZG9yLXNwZWNpZmljIG9yIGN1c3RvbSBwYXR0ZXJucywgd2UgY2FuDQpjZXJ0YWlu
bHkgY29uc2lkZXIgYSBzZXBhcmF0ZSBtZWNoYW5pc20sIHNpbWlsYXIgdG8gcHJpdmF0ZSBmbGFn
cy4gDQogDQpGb3Igbm93LCBJIHRoaW5rIHN0YXJ0aW5nIHdpdGggdGhlIElFRUUtZGVmaW5lZCBw
YXR0ZXJucyBpcyBhIGdvb2QgYmFzZWxpbmUsDQphbmQgd2UgY2FuIGV4dGVuZCBpdCBsYXRlciBi
YXNlZCBvbiBhZGRpdGlvbmFsIHVzZSBjYXNlLg0KDQotIFNodWJoYW0NCg==
