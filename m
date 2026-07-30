Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B738A70B
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433525; cv=fail; b=KBFJYDJU1vV76fEFbkvq2n/3ZbUXQxeAXs4GB+MV3F+dvBBOHlabZySZYazu6BoAaIiVkQSfwwJ5Kk5JA9ee/J/KpBwUQlzVsvIkI5u117giw3QTqT/fccwFAnXYtk4/sj6YpeCrFZqOvw1ae3NU8z09a7PGGzjJWnMUSZ6qLzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433525; c=relaxed/simple;
	bh=khOvi4d9lXw3+O1q7PmjOS603dQPsliki3WbMoY/Mxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cF5OPn+8T/gahpoW2nVEPXP8KtfqvxynaK42E9BZkpDhFkHPtmTzJn/p0y0zBk+rjVLlHGDRT3uXWkz9ushbhDQWgQ6CcjOBZfgBMDl64zPzfS0cfm9Bj/DnOk9TFvFxQ0DPRpN8h2CWKjVpAglDeekgj850Qs+igQXspc0/IXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+mycpj+; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+mycpj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785433524; x=1816969524;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=khOvi4d9lXw3+O1q7PmjOS603dQPsliki3WbMoY/Mxw=;
  b=a+mycpj+hF1uO9IrqgM+SSCOeSiRl2UVeQ7CgwkeuwSf1HU7aV4eYq4f
   b9SvicXRvW5BLpDw0Rf4+7t7HjNfF6tWwOUydFXMu4e4l87iFE6ti/A44
   QdgYHx26gez9cW9cXwUdmJ5vZdBY+3lqIpyx7gb5Nn0rebd5NMyX89R7M
   CLshM/7hn4TV6iQPb5/KfZxoOU67C5jK0xAkUDwDIdvdg4qt5DFtCKm5A
   d2s6oYfh8MwnnEYUtFaahzrUOrjs0E3tOo5nU6Oi7zw8M6oVBDE77eqQi
   JCl91yIW8avUE44A3yeNh0GqI9AViZ33JrhFNGp36Q2qrnrDvi1aQBQcV
   w==;
X-CSE-ConnectionGUID: pMrASMSBTXWWXl65iHL5nQ==
X-CSE-MsgGUID: OqlQjkZBToqBpehggs79bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89949277"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="89949277"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 10:45:24 -0700
X-CSE-ConnectionGUID: pJrmBAZWQjCyWyuioIGfOw==
X-CSE-MsgGUID: g3ynEcOeRb2/FqcIwGlvpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="263841957"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 10:45:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 10:45:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 10:45:23 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 10:45:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PknyRg5mVzq7AmHEB15NGz1qLmNiivT8vR3USjMQBxjNMZughuHE83nnCLSNoNV94bEOJ1ZXr2t9lePN855DqVERXQvZoEgM4yBEZwQabL128L4HJLR10986jLBZi60cJDadTr7Ix0bxefUF/EqgzxNuiC/nY719jdgKhHAf8QRPDzaFiwDP1VMwkzJGe2eOlMqTSI2Y32iWVr1WxrAtx52KgbCRlxNFnH1LYrQcGLqI3+ReaCk0LnYCXGISyjNCYIh3SMvPwOvZm14DRGXPZt1BNumEPLCFQDAN8q48AjhHersBBuM6iSwBJAvwkP5tY1vmkKF3g7hIFW/R9b0oVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khOvi4d9lXw3+O1q7PmjOS603dQPsliki3WbMoY/Mxw=;
 b=PcmmaUiArAV37f9L8yoPApPD5MlVWEm4KxeFfLqP18PNmDbVsrVVadisglguAPXjpvaOTClMAWPrLpYXZbcLM5o3cdRA/tOHFFl1dupgVvqrqNQHLgkqUapEpRRSX/Y8bLt0ymxgV2yZ4x/PcsBnTikDtoRGo1BvRKcufknepVmLZiqYSKXyJD8umdbAliWdabRcFopgnXrhiMuMKtzpMomfD8/i2cnOh5P9ActGgT+RgtDkSsaAWW3aKLjdq+EN3NUbnUqGXHEY03u0vXkcTM8+w0gcSInXFJNc1UONJCVeBWhpDpg5WUqyr+WuTHBLm7YsX2CQBtdYRwQyE4pVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:45:19 +0000
Received: from SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde]) by SN7PR11MB8109.namprd11.prod.outlook.com
 ([fe80::3f36:413c:bede:ddde%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 17:45:18 +0000
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
Thread-Index: Adz5hWg21MQs/VUaTJGfYpUI2lYKsQAM6bGAAOssNkAAEWE/gACW3a0AAAT6GYAAKCJlgAAB15QAAGW4BSAAJtcogAAPdBwAABO0owAAG26fAAD6e9ZgAAPKZQAAFsd4YABPDrYAAAbkChIAAZiPgAAA8RcAAAL+94AAAJsL6wEGjQLQAFwMWQABSmmV8AG6PMLwABUxooAAk180gABa//Tw
Date: Thu, 30 Jul 2026 17:45:18 +0000
Message-ID: <SN7PR11MB8109AD2F25C4DE21C048C9CBFFC92@SN7PR11MB8109.namprd11.prod.outlook.com>
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
In-Reply-To: <SN7PR11MB8109B6F350AE2E5BC02C6E1EFFCC2@SN7PR11MB8109.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8109:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: 188f4c63-f2e5-49e6-dcd8-08deee62523f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|38070700021|3023799007|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: pmxjt+kZqAh2mkuu1qOnbEmJTE+rggaqc44cJ/h8KcMw3A9ctoNixHghTsJA5DgiBmmP4ANQ3PyoBa2csjpKYhMlJwdi9oudUzMIix7tpB6TuMHoIBjxCgIZD5nYjinejS+sgBpAWS6VBqS5kUH7WbMro+1/9ngoPcsn+TOU7pzz29++t0U2pVAejANrH6y97deJcobrot2HGryqcruGnMfXglOS5ZO7so1IUoak1PKIqlsTBWCgo57R1bqILv4nBOHsfW3QRth29Rl+Xybrc+xGZWBxVN88wRsPZc/18iT8891nhyXXDt9M/heQp/VMUvcBMOisseT2Yp+21FOtlpV5Yub0MQao2rSc0w6XZx/OfoVUNpEAyRYi4qVhFA02kGk8IaYfbvfCN5kwNB8pFSCXYu0az2YkJhykRIv9oMGDeb8ueJ4fbGdgqSxlNDtkYTsIExs5n5uHRJnfrEgkMNIo7AVKZQgeWjDtofabsgoWjbVqaYvJTRy+iwZagnuVwmjdHqZ5t4QHX83eiFDnB8JImFZs9ASXEPJMTDn6cJ+qQ7thTUpr4y5SzmK8q2aeZKmd7ZRgPSzlVzMOIkIAakxAJSeAm9/FAjpFaLOznFP5sMgJVXEsA8KpAu12CI5lgLzSvCkUo+lMBlpRT711Vz1rEegF31eVDEIzkgpvfu8yrnCjIHCccGF8ehkIoYkiQRegU7HRGUkhkAXyEOGiePvlzq8hB10lSKwzxpmUorE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8109.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(38070700021)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVN4QVhjblZvVEZJK1BWR0Y2cm9zNGY2RGhwVWtRTU9rNmk1WUZjRlFNVXdB?=
 =?utf-8?B?R09lU21HSWtVc21PcjVseGJiWmRtV2p2SG5zYWZqdjhNbzhVeWdSa1ZmV0Rk?=
 =?utf-8?B?dnh0dGxEK2Q2TVF3cm1BekNqQVZHQUFINzFWRWYzTXFqeXV6K2N6aWs3TTc3?=
 =?utf-8?B?bWNkSjIreVdlenQ4dG54ZnMzdm54NUVOS2Y0SUdGSUx3eGE1bEFySHVHN05y?=
 =?utf-8?B?d3hvZVdOakFDS1JjbjlsMzRZQTluWlh2bnZzSWdiZHFTbGQwZ0E4ZFFmMGlY?=
 =?utf-8?B?S01EVk9zSTRiejY1VFovNkNXQzRjYzlNWWJSOTZ6VDFQQUFybjltSEdiWDJW?=
 =?utf-8?B?TzFMNXl0azF5WWZ2VEJDeDhtSGY1Z3ptVVFlSXNNNU9HZ2RGdmIzSnlkYnhR?=
 =?utf-8?B?eHlQTmtIZlgwM3VibTFBajdsOTNOb2JuY0hralgxU3hmaXBHTldVRDFwK3lp?=
 =?utf-8?B?MkxxakppczlWejkvUzRYYm9tc0hkRGluZ3RHOUxRbkEvdjlDKzlVaFFIT3JG?=
 =?utf-8?B?cHFzcFowZm8vdlg3TTgwU3hBQVV1Z2dqVzRINUd0d2kwQmxhbCtZYUE1QUNx?=
 =?utf-8?B?SXlNc2V0NnE2YUpYeEk1ZXd1U0VzbFRwN2pSeGk4WHYwL1MyVzRMdy9DOUlW?=
 =?utf-8?B?ZmVubUVOTEdXSXdHVjRzSi9HTHZxTm1kT2ZIMnRGRWZsRmNnN0MxRGdPdjls?=
 =?utf-8?B?My9OWnhsdzJhcW5tWHFvd1ZqWjdiUXAxVVRCbUg0U3pkWkYwK3lzcmNlQXc0?=
 =?utf-8?B?ZUcyN0NULzFiNlVleGVKcm1jVWxmb3BSeWFZOUEwQVJPTTMzY1pNNjBCcDdv?=
 =?utf-8?B?ZmltOEVLZHNFU1dWOUd4d3pwRFFUeFR2SHNaM3BWL29lL0VOdlBqOHpSVmVK?=
 =?utf-8?B?RUliYXhkQkZFUVFHc1BiYUc4VmJPU05Na0pTemN1aGhtQXJ6dytuY0MyZjBp?=
 =?utf-8?B?ejJnME91eiszTVZBMzhYOHp2bzVtdmpCdkNJTXo5eStpV0d1NWRWaVlyeWYx?=
 =?utf-8?B?cUFlTGxtd05NY2xQMHZyejV1d1NmODQ1VG5SeEZ1S3djWVB2L0JlZ1RCL0RF?=
 =?utf-8?B?c1VJNlhVYkQ3VXVyWHViaGJ4M1FDQ05BZ1UvVS82eHJSVXJjSFJzQ0hNQWxM?=
 =?utf-8?B?bEl2YVgycnpVWFBsaUY0alorN01ETnBCczBXYTZFcDBoUUlmSm9zeExiTUFT?=
 =?utf-8?B?bmFqSWx1RVI0R3h2WVE4WDhqZXJWSmkxdmQrRlZnT2NQTUpDWTJFR0Z4K0VO?=
 =?utf-8?B?ZW1yTStwSkdDTXdhNUFXQm5sY0dpcnhKTjZ4ZWprcXh3U2lNV0FTRTZMR205?=
 =?utf-8?B?SmlYMjN2eVIrYXR4ZlJJZE5qbUdOR1FqMGhNRFY1eExUUGJlRnh4YktURnB1?=
 =?utf-8?B?OGE1bXEvNURreGJscUk1Q2F5MGxMTFBTaXBpRFR5UzFCSzJmdjQ2U1Nzc25S?=
 =?utf-8?B?U096c2VnUHpvOFU0dXhOdk9rdFpMVEFva3dsR2JVWjBDR2xLN01jSUt4eHBq?=
 =?utf-8?B?c2lqRDk2cmtocWpMdHAzeFFpS3lQc0V5UVVHVDdRT2VhSDB2MkxGZm9hNEVQ?=
 =?utf-8?B?b0g5ZlBudm1RVWdpV2Z4eTNMZUhubjFMaUhMUlYwUGppL2tCdFJseVlJSzgv?=
 =?utf-8?B?TElWVXd2YlhwVWQ0RzVJbWcvR2RETTgwcGlBMHJ2SzhMYVFuaHZRMnVuQW5H?=
 =?utf-8?B?SkpjRlFUQVlXWVhKeEJpSW8xcm9ocDZpZ2ZhWTQwS05pYmR1R0toTE9ZSkpj?=
 =?utf-8?B?TVd1UVdmeHN2YkliRnErMEZUektxZU4yQTBBd3pFdEM4ejlHZFh2MmduWm1m?=
 =?utf-8?B?QTVWcHhhSENYQk56QjZXaHdtQXcwRmFBSnpPZmt4TDlXc2YyZjhIM0xBSEJI?=
 =?utf-8?B?ZGdMVWtsbjRpOFdDTzJ5a3lkdE5iQkI2Ty9GSWkwNUJvdzFYY3B5TVBVWnV1?=
 =?utf-8?B?dEJSdEdqVEZhVFlNMmt1UUxOMDJBTTdkR2pSemFFbUs2RHdyUWZuQ1FqRU5t?=
 =?utf-8?B?K3crVXdwTnRtaXhRcnNVMzNvY29RNVdlVUNwS1REU2wxYTBsdjZPalVLWEht?=
 =?utf-8?B?ajVoZkxDNG55WW54ZU5DN1RGcklRTGFxT0ZhSU44bWh5akdRaitLVGV4Wkwv?=
 =?utf-8?B?aHFVcXR6amhYaWRVUmE0TWJqc0dIM3dsNDVXRENKM0taOW5qN1h4U0dOOVFS?=
 =?utf-8?B?dzQwTE1wYzRCUjhrVlJaS0Z6Z0dXUDJ4Z1l0bk93NjFhaTduOUdBZlpDcGhP?=
 =?utf-8?B?b1JEbmprdkN6eEtBc0s0eEFCam5wazZ4SnFTQjB4eXo1VjAySDBsNzM1aURi?=
 =?utf-8?Q?DtIqwsa+qFk2XTyXF5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XWbl4Pc87a4K4Q4QAcsj6gB4eQQjREo4XD/tPlK/g+2nTcGH2w8Do3wc2yu6UBADL0lnn62E1aNbWKKAK5WHk4KHkqhl1sVHoLnShaHyZJOlIqK1mlqWXsPXSl6XEmCvsoxv9BQvJWrDjwe27ZYGID85xElxFFSro8fPMj9grZvlz7z+eSTxPx93bnAedf6oEhDaPsxwj+2aqJtV0BuK4XTK/meklG7axNCs4l1WJPTZfxJuoJLYK/xr2xQgzSfZS7qH+p5l7qqkOBV6gZFp+4gwtNl+morLsEwZIGngpfhuu/KkRRGax+xCpB18y7D1r63h71z1fX0AfuFVBuYuyA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8109.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188f4c63-f2e5-49e6-dcd8-08deee62523f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 17:45:18.7183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rTfi0BU7XDAPJ/tOmOIcz2U316rXaK0HIhoETIfWvg79yCeu+VLShOsgljUqQt3/q2Fa9ME5PNgl1mNDG/sGng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com

PiA+IEhvdyBkb2VzIHRoaXMgZGVhbCB3aXRoIGxhbmVzIG9yIGNhc2VzIHdoZXJlIHlvdSBoYXZl
IG11bHRpcGxlIFBIWXMgaW4NCj4gPiBwYXJhbGxlbCBzdWNoIGFzIHRoZSBEU0Egc2V0dXBzPw0K
PiANCj4gV2UgYWxyZWFkeSBoYXZlIGEgbGFuZSBwYXJhbWV0ZXIgZm9yIHNlbGVjdGluZyBwYXJh
bGxlbCBsYW5lcyB3aXRoaW4gYSBnaXZlbg0KPiBibG9jay4NCj4gDQo+IENvdWxkIHlvdSBlbGFi
b3JhdGUgb24gdGhlIERTQS9tdWx0aXBsZSBQSFlzIGluIHBhcmFsbGVsIGNhc2UgeW91J3JlIHJl
ZmVycmluZyB0bz8NCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IChuZXRkZXYsIGJsb2NrLCBs
YW5lKSBzaG91bGQgdW5pcXVlbHkgaWRlbnRpZnkgYSB0ZXN0DQo+IHBvaW50Lg0KPiBJZiB0aGVy
ZSBhcmUgdG9wb2xvZ2llcyB3aGVyZSBhIHNpbmdsZSBuZXRkZXYgY2FuIGV4cG9zZSBtdWx0aXBs
ZSBpbnN0YW5jZXMgb2YgdGhlDQo+IHNhbWUgYmxvY2ssIHRoZW4gd2Ugd291bGQgbGlrZWx5IG5l
ZWQgYW4gYWRkaXRpb25hbCBpbnN0YW5jZSBwYXJhbWV0ZXIgdG8NCj4gdW5pcXVlbHkgaWRlbnRp
ZnkgdGhlIHRhcmdldCBibG9jayBpbnN0YW5jZS4NCg0KV2UgaGF2ZSBhZGRlZCBhbiBpbnN0YW5j
ZSBmaWVsZCB0byBoYW5kbGUgdGhpcyBjYXNlLiAgSW5zdGFuY2UgZGlzdGluZ3Vpc2hlcw0KTXVs
dGlwbGUgaGFyZHdhcmUgZW50aXRpZXMgb2YgdGhlIHNhbWUgY29tcG9uZW50IHR5cGUgd2l0aGlu
IGEgc2luZ2xlIG5ldGRldi4NCg0KRm9yIGEgc2ltcGxlIE5JQzogb25seSBpbnN0YW5jZSAwIGV4
aXN0cyAoaW50ZXJuYWwgUEhZKQ0KRm9yIE5JQyArIGV4dGVybmFsIFBIWTogaW5zdGFuY2UgMCA9
IGludGVybmFsLCBpbnN0YW5jZSAxID0gZXh0ZXJuYWwgUEhZDQpGb3IgTklDICsgZXh0ZXJuYWwg
UEhZICsgcmV0aW1lcjogaW5zdGFuY2UgMCwgMSwgMg0KDQorLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSsNCnxCbG9jayAgIENvbXBvbmVudCAgIEluc3RhbmNlICAgU3VibGF5ZXIgICBEZXB0aCAgICAg
ICAgIE5hbWUgICAgICAgICAgICAgICAgICAgICAgICAgRGVzY3JpcHRpb24gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KfCAxICAg
ICAgICAgICAgICAgTUFDICAgICAgICAgICAgICAgMCAgICAgICAgICAgICAgICBSUyAgICAgICAg
ICAgIDAgICAgICAgICAgaG9zdC1tYWMgICAgICAgICAgICAgICAgICAgICBNQUMgcmVjb25jaWxp
YXRpb24gICAgICAgICAgICAgICAgICAgICAgIHwNCnwgMiAgICAgICAgICAgICAgIFBIWSAgICAg
ICAgICAgICAgICAwICAgICAgICAgICAgICAgUENTICAgICAgICAgICAwICAgICAgICAgIGhvc3Qt
cGh5LXBjcyAgICAgICAgICAgICAgIEhvc3QgUEhZIFBDUyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCnwgMyAgICAgICAgICAgICAgIFBIWSAgICAgICAgICAgICAgICAwICAgICAg
ICAgICAgICAgUE1BICAgICAgICAgMCAgICAgICAgICBob3N0LXBoeS1wbWEgICAgICAgICAgICAg
SG9zdCBQSFkgU2VyRGVzICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KfCA0ICAgICAgICAg
ICAgICAgUEhZICAgICAgICAgICAgICAgIDAgICAgICAgICAgICAgICBQTUQgICAgICAgICAwICAg
ICAgICAgIGhvc3QtcGh5LXBtZCAgICAgICAgICAgICBIb3N0IFBIWSBvdXRwdXQgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQp8IDUgICAgICAgICAgICAgICBQSFkgICAgICAgICAgICAgICAg
MSAgICAgICAgICAgICAgIFBDUyAgICAgICAgICAgMCAgICAgICAgICBleHQtcGh5LXBjcy1ob3N0
ICAgICAgICBFeHRlcm5hbCBQSFkgaG9zdCBQQ1MgICAgICAgICAgICAgICAgICB8ICANCnwgNiAg
ICAgICAgICAgICAgIFBIWSAgICAgICAgICAgICAgICAxICAgICAgICAgICAgICAgUE1BICAgICAg
ICAgMCAgICAgICAgICBleHQtcGh5LXBtYS1ob3N0ICAgICAgRXh0ZXJuYWwgUEhZL3JldGltZXIg
aG9zdCBQTUEgfA0KfCA3ICAgICAgICAgICAgICAgUEhZICAgICAgICAgICAgICAgIDEgICAgICAg
ICAgICAgICBQQ1MgICAgICAgICAgIDEgICAgICAgICAgZXh0LXBoeS1wY3MtbGluZSAgICAgICAg
IEV4dGVybmFsIFBIWSBsaW5lIFBDUyAgICAgICAgICAgICAgICAgICB8DQp8IDggICAgICAgICAg
ICAgICBQSFkgICAgICAgICAgICAgICAgMSAgICAgICAgICAgICAgIFBNQSAgICAgICAgIDEgICAg
ICAgICAgZXh0LXBoeS1wbWEtbGluZSAgICAgICBFeHRlcm5hbCBQSFkvcmV0aW1lciBsaW5lIFBN
QSAgfA0KfCA5ICAgICAgICAgIE1PRFVMRSAgICAgICAgICAgIDAgICAgICAgICAgICAgICBQTUEg
ICAgICAgICAwICAgICAgICAgIG1vZHVsZS1wbWEtaG9zdCAgICAgTW9kdWxlIGhvc3Qtc2lkZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgfA0KfCAxMCAgICAgICAgTU9EVUxFICAgICAgICAgICAg
MCAgICAgICAgICAgICAgIFBNQSAgICAgICAgIDEgICAgICAgICAgbW9kdWxlLXBtYS1saW5lICAg
ICAgTW9kdWxlIGxpbmUtc2lkZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCistLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKw0KDQpCbG9jayBsYXlvdXQgaXMgcmVwb3J0ZWQgdmlhIC0taW50ZXJm
YWNlLWNhcGFiaWxpdGllcy4gVGhlIGJsb2NrLWlkDQpmcm9tIHRoaXMgb3V0cHV0IGlzIHRoZW4g
dXNlZCBhcyB0aGUgYmxvY2sgcGFyYW1ldGVyIGluIC0tcGh5LXRlc3QNCmFuZCAtLXNldC1sb29w
YmFjayBjb21tYW5kLg0KDQorICAgICAgICBuYW1lOiBpbnN0YW5jZQ0KKyAgICAgICAgdHlwZTog
dTMyDQorICAgICAgICBkb2M6IHwNCisgICAgICAgICAgSWRlbnRpZmllcyB0aGUgaGFyZHdhcmUg
ZW50aXR5IHdoZW4gbXVsdGlwbGUgaW5zdGFuY2VzIG9mDQorICAgICAgICAgIHRoZSBzYW1lIGNv
bXBvbmVudCBleGlzdCBpbiB0aGUgaW50ZXJmYWNlLiBUaGUgZHJpdmVyDQorICAgICAgICAgIGFz
c2lnbnMgaW5zdGFuY2UgbnVtYmVycyBzZXF1ZW50aWFsbHkgYmFzZWQgb24gcG9zaXRpb24gaW4N
CisgICAgICAgICAgdGhlIHBoeXNpY2FsIHBhdGguIERlZmF1bHRzIHRvIDAgd2hlbiBvbmx5IG9u
ZSBpbnN0YW5jZSBvZg0KKyAgICAgICAgICBhIGdpdmVuIGNvbXBvbmVudCBleGlzdHMuDQorICAg
ICAgICAgIEZvciBQSFk6IGluc3RhbmNlIDAgaXMgdGhlIGludGVybmFsL2hvc3Qtc2lkZSBQSFks
DQorICAgICAgICAgIGluc3RhbmNlIDEgaXMgYW4gZXh0ZXJuYWwgUEhZIGZ1cnRoZXIgYWxvbmcg
dGhlIHBhdGgNCisgICAgICAgICAgdG93YXJkIHRoZSBsaW5lIHNpZGUuDQorICAgICAgICAgIEZv
ciBNQUM6IGluc3RhbmNlIDAgaXMgdGhlIGhvc3QtZmFjaW5nIE1BQywgaW5zdGFuY2UgMSBpcw0K
KyAgICAgICAgICBhIHNlY29uZGFyeSBNQUMgZnVydGhlciBhbG9uZyB0aGUgZGF0YSBwYXRoIChl
LmcuLCBiZWhpbmQNCisgICAgICAgICAgYW4gZW1iZWRkZWQgc3dpdGNoKS4NCisgICAgICAtDQor
ICAgICAgICBuYW1lOiBuYW1lDQorICAgICAgICB0eXBlOiBzdHJpbmcNCisgICAgICAgIGRvYzog
fA0KKyAgICAgICAgICBEcml2ZXItY2hvc2VuIGxhYmVsIGZvciB0aGlzIGJsb2NrLiBOYW1pbmcg
Y29udmVudGlvbjoNCisgICAgICAgICAgPGluc3RhbmNlPi08Y29tcG9uZW50Pi08c3VibGF5ZXI+
Wy08ZGVwdGg+XQ0KKyAgICAgICAgICB3aGVyZSBkZXB0aCBxdWFsaWZpZXIgKGhvc3QvbGluZSkg
aXMgaW5jbHVkZWQgd2hlbiBtdWx0aXBsZQ0KKyAgICAgICAgICBkZXB0aHMgZXhpc3QgZm9yIHRo
ZSBzYW1lIChjb21wb25lbnQsIGluc3RhbmNlLCBzdWJsYXllcikuDQorICAgICAgICAgIEV4YW1w
bGVzOiAiaG9zdC1tYWMiLCAiaG9zdC1waHktcGNzIiwgImhvc3QtcGh5LXBtYSIsDQorICAgICAg
ICAgICJob3N0LXBoeS1wbWQiLCAiZXh0LXBoeS1wbWEtaG9zdCIsICJleHQtcGh5LXBtYS1saW5l
IiwNCisgICAgICAgICAgInJldGltZXItcG1hIiwgIm1vZHVsZS1wbWEtaG9zdCIsICJtb2R1bGUt
cG1hLWxpbmUiLg0KDQpyb290QHNldHVwOn4jIC4vZXRodG9vbCAtLWludGVyZmFjZS1jYXBhYmls
aXRpZXMgZXRoMTUNCkludGVyZmFjZSBjYXBhYmlsaXRpZXMgZm9yIGV0aDE1Og0KDQogIEJsb2Nr
IDM6IGhvc3QtcG1hDQogICAgY29tcG9uZW50OiBQSFkNCiAgICBpbnN0YW5jZTogMA0KICAgIHN1
YmxheWVyOiBQTUENCiAgICBkZXB0aDogMA0KICAgIGxhbmVzOiA0DQogICAgU3VwcG9ydGVkIGxv
b3BiYWNrOiBsb2NhbCByZW1vdGUNCiAgICBTdXBwb3J0ZWQgVFggcGF0dGVybnM6IHByYnM3LCBw
cmJzOSwgcHJiczExLCBwcmJzMTMsIHByYnMxNSwgcHJiczIzLCBwcmJzMzEsIHNzcHJxDQogICAg
U3VwcG9ydGVkIFJYIHBhdHRlcm5zOiBwcmJzNywgcHJiczksIHByYnMxMSwgcHJiczEzLCBwcmJz
MTUsIHByYnMyMywgcHJiczMxDQogICAgU3VwcG9ydGVkIHRlc3RzOiBiZXJ0IGVycm9yLWluamVj
dA0KDQpTaW5nbGUgbGFuZSBvbiBob3N0IFBIWSAoaW5zdGFuY2U9MCwgYmxvY2sgMyk6DQogICAg
ICAgICAgZXRodG9vbCAtLXBoeS10ZXN0IGV0aDAgYmxvY2sgMyBsYW5lIDAgdHgtcGF0dGVybiBw
cmJzMzENCg0KRXh0ZXJuYWwgUEhZIG9yIHJldGltZXIgKGluc3RhbmNlPTEsIGUuZy4gYmxvY2sg
Nik6DQogICAgICAgICAgZXRodG9vbCAtLXBoeS10ZXN0IGV0aDAgYmxvY2sgNiBsYW5lIDAgdHgt
cGF0dGVybiBwcmJzMzENCiAgICAgICAgICBldGh0b29sIC0tc2hvdy1waHktdGVzdCBldGgwIGJs
b2NrIDYgbGFuZSAwDQoNCi0gU2h1YmhhbSANCg==
