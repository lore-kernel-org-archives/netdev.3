Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C923599A26
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890692; cv=fail; b=ib3si1moQNeTSHxNd5/L2l4OTLbEs9pwc6dcnN/NgCaaLVuz0w5GCHBhm67+tUktk9r36nAgDe/EdrqUeVxm5iCEE9Rey4JWvmD8PeKrn48bY6AfEqbmXJZO4n8aDDs79jfX+5lSPiKF6F+sFsa10nZb+0uRBAHgpT9hxP1TkLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890692; c=relaxed/simple;
	bh=73aFohdR4Wol8lhQqQ1qlkr37O5I63/qzZdN6bIO5Uk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lRpsulYkK7NNsDp/qpuQtn+2KsqpzSsqQ8BniowqOAN0/WLMX3/kMSmthK8LJCWVbItCKaMnNPNLMk92tmk9q1EPNKxonuyqF2i/WTR3CJGzsdwVdAsA6IJp88wBpE2Cakma5s2euXsufacwKgiMPW1M8OLNfKkCPqJlwyjL8Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgHW5eta; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgHW5eta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788890691; x=1820426691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=73aFohdR4Wol8lhQqQ1qlkr37O5I63/qzZdN6bIO5Uk=;
  b=CgHW5etahQ093rwA9T5isjuOr3neKS3kBH5BEUm5BBjgek53i0BRhci4
   WbJDWuUGCBz+fM3iCk8M8+r80XpT9YHv8JhVz/HM8EbEPlwH+oXEnpxe1
   o1aWROp/ftw9jWLEyvcPtPbPBr/JCpT6y6cVCgCmnoQDDH1uYxYuHea+j
   mBq120gFYL5M81C2mzInHzqNhz6iaicSPMQWy+2YGl7Di2aisDRoPxuCz
   cBuDz9VFNMvFbUJEmJsXDlwH9dt/AfNnfA3EtF7QRScVk6dg26fWezvDs
   Z6KS0G0PRZ291h6sXuzxTRe3vQVsPKlh1GVFyFAxfM0u3aPya7TX0zdBN
   Q==;
X-CSE-ConnectionGUID: mMFIQUA5Ri+emGwsU+JFhw==
X-CSE-MsgGUID: 2aPgIaczSHagxx6GWIIWGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89334948"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89334948"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:04:50 -0700
X-CSE-ConnectionGUID: tCNCdLIuSDK7iv8fEETl6A==
X-CSE-MsgGUID: tqGY4lSuQduy601bgphrGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="275204730"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 11:04:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:04:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 11:04:49 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 11:04:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrP28MywGqBLZVajF2sIr57/CikwwCBCvL1M/pHmX+S7Yjgm0nsoxYF5CXxWtMGz+9MwYxZ0naO0/EBfir1MVd8TejY/bah8KrB93nax0oQBr3bUccxeAA76WBeY34Xz46xVOLkWmF5tVTOUTLYG9dGBrYYLWtOfWpenh5tQgtB8PB22qN/KHzzRalltP4s1cWkTb6+omU/tO7PAza2pz/kbcy3jVY120IRSpy/9L0oyYO8/d6SLC3kMtb+5P1VBO1tWC8lWQ2mFv3+UANd7jXWRMXNbyE7+bPaTx9smWNkug+XqGNXTcDzQVc/Ha1QN8W1A0sjdmYy/npDYlmp+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73aFohdR4Wol8lhQqQ1qlkr37O5I63/qzZdN6bIO5Uk=;
 b=CVCL4UBWHDXg5eBb1A6t6MrS19bHFfh1k58rvOak6h/4JVJRIP0/n2tYmhX04Ynq5VpKrcAHpwCs1CezcG+EEThPDHFcXrovxYlGMNuZU7OAh0ea4/KbQQ1AqIM/aowoCljzG5U9iANtOgB/fLewfwQGhbLitTO2cnoKZWUzcJEgB1+JNX9NX5aERKEb7wYEWqgT76jXR9El7O9U/efbSM4n9yxvJ80iF4WBJxzOuZu/u1mg6AXkx4UzvYwWM0w5y6eYOxQRJdc45OHul8oPHPz8rd8Y1hlZGoLYUkEdiDSK3NTSeRRYyazNskUC68F1zoKcN1tU+lNh48d12DPTTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS4PPFAC42FDD50.namprd11.prod.outlook.com (2603:10b6:f:fc02::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 18:04:46 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 18:04:46 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Intel Wired LAN
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"Oros, Petr" <poros@redhat.com>, "Bross, Kevin" <kevin.bross@intel.com>,
	"Cavatur, Ranjit" <ranjit.cavatur@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Korba, Przemyslaw"
	<przemyslaw.korba@intel.com>, "Machnikowski, Maciej"
	<maciej.machnikowski@intel.com>
Subject: RE: [PATCH iwl-net v2 06/14] ice: call PTP link change only from link
 events
Thread-Topic: [PATCH iwl-net v2 06/14] ice: call PTP link change only from
 link events
Thread-Index: AQHdNOTP6i1V8vtH6EWIOH9v8DC+5bbFDxcA
Date: Tue, 8 Sep 2026 18:04:46 +0000
Message-ID: <LV1PR11MB8790692C82728262EECBDA2690B12@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
 <20260825-jk-e825c-minimized-fixes-v2-6-8223f95d26e3@intel.com>
In-Reply-To: <20260825-jk-e825c-minimized-fixes-v2-6-8223f95d26e3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS4PPFAC42FDD50:EE_
x-ms-office365-filtering-correlation-id: 65c64285-eed3-4689-b483-08df0dd3aadd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: W9hVt1BzkLrMxDPe9wnUQlkOK97bff3tsqq5vMfg6C3FDf9px8L+EEa+1hkdZfqf00HrX43NmYubhTDj8IefaYAKDZN6BBYFyXB6DdSQo8EFNw9Sx2jjmeyAvM0glVCll9jG5PdewnDH5KJCGk3zSUm2hrX3iihKJLBMUGVGep+ts6SvJHsYCIcG7162LjHZmryBa8Pt23dfjWfpOCDXSfmLBH37Nu/11Te0o3o+y2eu4tZRDEYXbceuwKsCrZ8MdAyVgTWFBxFQyq5O5Ak3Y3r17IxxNE3csckdW4aKLO5476eGwV3WcKKmTTNinnSB20WzssJO5YyS5CmcV3ADoIRMZTyGNRPMPEbto6hVajmhPeOBKIU3J/b2gXwhdRj3bsJTmvPZx//bKtIgj4gFdZSLYUZ8r5KxyLv/0sMuw+sk9py+llDYzHfyeOaewF0OXMLxn5ghJ2Ur7GQBJZk0aC20oKRAcHUoXFX2jmsyyaaLT6AIEra7tmO5NKSwYKmn4e73Q2597aGcuXuUv0Zc8+PcV/u1PuyHaq0TBBzpZj7JicLDc0bKYse66lUfYhPOTFpeOZhOIFQauWkXbm+XXrv6UdM7qSd/oNByOxww6L8tkUOvq3zk/GMratWLvNH6xM3eyQsvtWa5SQQut+BubffvZ/nr09MeD9ct71mxagVxPIzhYPnjBIw4SLvzX3eQ0J95cyy8V81Z5NxXOIVOFfOJT8ApwLpx9sfmHcIsNeQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTBkTUR0VFkwNGdyczhOY25zTGNKNGkyM2NXMFN4bGtHZDRNZlJ6Vy9jOHEr?=
 =?utf-8?B?Q1duRk9qaVhvVXVMZEkvRGRJak94WmVJTDhhWHVvQ0xMTTVaMkNNY05nWHRx?=
 =?utf-8?B?WVBaVWpDazNiOUo4T1Zzd21WQ0U2cXdsaTFzQ1BsaXRoNkhsZWovOVRJNWhU?=
 =?utf-8?B?Vk4yTDd5Z0g2S3RVaFBWQlNPa3psblROaWhRQms4Y2hHMXBHQVBQcWh5Y0d2?=
 =?utf-8?B?WUhXdkhieWliOHBWN0xIMW9JVDRBU2JpTFRkam9YVFZUYTBXVTYwV012UEsx?=
 =?utf-8?B?bnVBZ1VvWDFyV0dYU2EyM1NMWllCKzVFNDVwV1FQZzJwbGlwZ0xXa21hbTlx?=
 =?utf-8?B?amdvVkp2enF2Z3NPQ2gyWER1WHV4T1BaNEV6cEQrQ3RBTVFnc1hZcnhzM1hu?=
 =?utf-8?B?YzJtUDIzdjRKdHZrb0xGazVRaDRPWXpJanFnb09HQU0xN0ZFNlhOeGRDNzd4?=
 =?utf-8?B?S0JMRzlJQUpWR0NmbUV0dXY3amRWYTlCTXArYVprNnRKYXgvSzUzcEhUbG5u?=
 =?utf-8?B?aTBUUEliWkFhbEt3c0R5SDgrNU1SVW5UeXh0OUhidjlseHM2M1I5VGs2QWtV?=
 =?utf-8?B?U1B5VW5ZSUhCNDZRVXlyd2tCMGJLOFZQb0FSS3hNdk9DUmVzMlpTbW1BY0Y5?=
 =?utf-8?B?N1I1QTVnclZhY0Z5cjBmZ0grQkNJVy91cjJRQm12aG12K0FXQTN2NkJybExr?=
 =?utf-8?B?aXFTdFF1OTNXOFB3KzVWZHBNNWpaK2VUZnkySnRPRkxUZWFzcnpzeWgycWFT?=
 =?utf-8?B?aC8zWkFUdWhtV3RnVnN3cE5BTW9BV3VsV0owRUdwb0NnR1VNQ2dmQmhZNTJE?=
 =?utf-8?B?S0VCSzVBempHbGN3ODNvcWF1ZVpUM2FWTjY4Y2ZDMVhjdkJ5T2RKalhsMnJB?=
 =?utf-8?B?MzRUUzMyVUFuc3JnQU43VUUvYlNNbmk1dDVOd1BlYUw2N0VEWUxkZ2VQUVlD?=
 =?utf-8?B?MGw0d1VQdUhqd3ZVWGRCYjRrSUl4Z3hpQkVqelRLWWYvSHpkN3lHd0ZhdWRY?=
 =?utf-8?B?NFFBVmZNb0xjdnAwSXNTZU5rcmthVXgzTmtMVVFYV093ZDNqRDBPNml1aTdX?=
 =?utf-8?B?YkdES3lCQ0JBd01WSDMxclFCMHp5NFdCQk5PaTlyMnNNbEQvS0NzTVBUSDlX?=
 =?utf-8?B?ZzYxVWVZOHBsQ0lXRzF4SytIUks4bmFkSnd5NVFjZXhmaW9zb1g5NzBOQ0Nn?=
 =?utf-8?B?MnhFUlRlLzBGcEVIRDFQZWNLQTR4WURBcDhiaHU1NHlGV1BaMGpTT09LQXBG?=
 =?utf-8?B?ZzgrRjZuRzA4cE9yUWpEdWl5SjZWRmtxYnlmQUdSRitsWTFOK0IxTElxTU9q?=
 =?utf-8?B?M2hSaFY2eHNxMmR1M2JPZDlHVUJwUVRoZ3Fhb3gxZWxHdks1clI3Wi9uak05?=
 =?utf-8?B?YUNCdDRudmRaeHdYTnYzMWFwMUluMCt6R0NmVHlxZTVlelBORlNNcnc3dzl5?=
 =?utf-8?B?V2hHWCthOTNXU0NOV2c3YXR5Y291Zm05TFFUNkRTRmVuNHVwVVBIRVNGak8v?=
 =?utf-8?B?dHZSckZTd1pnZkR6WDhLWE13SmFydGpQN2JudDV0bFl2Z290b2R5WVVsVzIx?=
 =?utf-8?B?QSszeGpTbzdPZ3ExakdFTnFuZUUrNklGNjNHTy84WFJlaGhiZ2t5TUhtS0ph?=
 =?utf-8?B?Uk5sQUs2MnB2Z1VlMEhLd3AyV29JK0FxbUdWOEFxY0pLRU1ZZmQxQStOOGZ3?=
 =?utf-8?B?azhqZy8rK0VlNTNQWVpYV090UGwrNHkvTlZZNzdvUjR1K2tjbTNWYnh5QkVz?=
 =?utf-8?B?ZXE5ZU03c2J0UGc0aHJEajFOWklnSXpCOW5HNUVubWJVNnVCbi9wamJ0aGh2?=
 =?utf-8?B?U0lvdVJ5M1BxTDBMRnlrL0xRMjJUb0U2M1pGaU41WHZobXFBRXNYVE1ZOEZ4?=
 =?utf-8?B?d1FodnJmaXVmUFVDMEg2ak9nWXRLK0ZGVmh3S0pyQjBsUHBhd0NpZTRoYTZE?=
 =?utf-8?B?TGlMY0p4dUF0eUQ3cm04cEI5S2F6YW01YWYzR21Vb1BJWWYzN3NUUk9GUkpu?=
 =?utf-8?B?eWdkZXFoYm9odi91TWRrMzI0UHJaemdxa3ZjYlFlZkk1WHlOeDc4YnVyRHRn?=
 =?utf-8?B?NGIrcFBhZWNxWEE0d3IzZFdOOEJscUJjSGVnRzFoV0hXMVN0TDNRUFJraGVM?=
 =?utf-8?B?NEEwOE9XU1diUVJZTmJUTFR3MDZyc2F0VksralJIN0lpNjFrL3VMdXIxcnBL?=
 =?utf-8?B?KzBBOGdnTHFHTVF3aWxzR2FrVzQyZUwzYVY0OU9lTVUvNTQybGhsTGZDOTdt?=
 =?utf-8?B?UkU3N05wRGZYNFMwVkFvbjVyWnFoUXhJUEdydFVMRmRBcDVaL0krV1VBZnR5?=
 =?utf-8?B?bElJQ09SMXNUQW0wQWFxdi9EdlVNY1B4akZ4TnBvajcvUDNsazhEUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RJtl+9Jrlo6f+xIAVi6r2JmmHcwO9Gjn9l3kJoPlFj6S/1JQh99W/m0DjzzN54wfqAuy1RS4e0k12iETK9b8KfMRrsqBqQ4AOVAx4j/5tJinRzzkjBNqojov8xFPR/ftYvLgI4uGGFJgTXq23Yx0EV81IeoQBgS7Vfoc6uhhQVEzh4pNJ5IBFUcw8Z/3/2kXdC/OldN7A5Mtr5tpXbtilQqt+X3ai/tp7bGKvvoS45X5Xqsgf5ii9Rp29SjoBIG+YNzuQ7raOX2sa2zCJxCR6TTCZkR2ef4hbYXs6G/PEdWq8gnb5wBgPg4ZC3PeQc3xbExZXQPBzQbVIw7EyNPxEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c64285-eed3-4689-b483-08df0dd3aadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 18:04:46.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OC6C3b73+f1SQZfoJN55upzHYtptMiDda1hrz9uo/oKH0ynZp6xbyfdrGvXvD5L0WvEolsgF7RYUHqqU/z/paevbcwmwcy4xEU+rNBTyj6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFAC42FDD50
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZWxsZXIsIEphY29iIEUgPGph
Y29iLmUua2VsbGVyQGludGVsLmNvbT4gDQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyNSwgMjAy
NiAzOjU0IFBNDQo+IFRvOiBJbnRlbCBXaXJlZCBMQU4gPGludGVsLXdpcmVkLWxhbkBsaXN0cy5v
c3Vvc2wub3JnPg0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgTWFjaG5pa293c2tpLCBN
YWNpZWogPG1hY2llai5tYWNobmlrb3dza2lAaW50ZWwuY29tPjsgTmd1eWVuLCBBbnRob255IEwg
PGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS29yYmEsIFByemVteXNsYXcgPHByemVteXNs
YXcua29yYmFAaW50ZWwuY29tPjsgTml0a2EsIEdyemVnb3J6IDxncnplZ29yei5uaXRrYUBpbnRl
bC5jb20+OyBPcm9zLCBQZXRyIDxwb3Jvc0ByZWRoYXQuY29tPjsgTm93bGluLCBBbGV4YW5kZXIg
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPjsgQnJvc3MsIEtldmluIDxrZXZpbi5icm9zc0Bp
bnRlbC5jb20+OyBDYXZhdHVyLCBSYW5qaXQgPHJhbmppdC5jYXZhdHVyQGludGVsLmNvbT47IEtl
bGxlciwgSmFjb2IgRSA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPjsgS3ViYWxld3NraSwgQXJr
YWRpdXN6IDxhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb20+OyBMb2t0aW9ub3YsIEFsZWtz
YW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+OyBLb3JiYSwgUHJ6ZW15c2xhdyA8
cHJ6ZW15c2xhdy5rb3JiYUBpbnRlbC5jb20+OyBNYWNobmlrb3dza2ksIE1hY2llaiA8bWFjaWVq
Lm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV0IHYyIDA2
LzE0XSBpY2U6IGNhbGwgUFRQIGxpbmsgY2hhbmdlIG9ubHkgZnJvbSBsaW5rIGV2ZW50cw0KPiAN
Cj4gRnJvbTogQXJrYWRpdXN6IEt1YmFsZXdza2kgPGFya2FkaXVzei5rdWJhbGV3c2tpQGludGVs
LmNvbT4NCj4gDQo+IFJlbW92ZSByZWR1bmRhbnQgaWNlX3B0cF9saW5rX2NoYW5nZSgpIGNhbGxz
IGZyb20gaWNlX3VwX2NvbXBsZXRlKCkgYW5kIGljZV9kb3duKCkuIFRoZXNlIGR1cGxpY2F0ZSB0
aGUgY2FsbCBhbHJlYWR5IG1hZGUgZnJvbSBpY2VfaGFuZGxlX2xpbmtfZXZlbnQoKSwgY3JlYXRp
bmcgdGhyZWUgcHJvYmxlbXM6DQo+IA0KPiAxLiBEb3VibGUgaW5pdGlhbGl6YXRpb24gb24gbGlu
ay11cDogaWNlX2hhbmRsZV9saW5rX2V2ZW50KCkgY2FsbHMNCj4gICAgaWNlX3B0cF9saW5rX2No
YW5nZSh0cnVlKSwgdGhlbiBpY2VfdXBfY29tcGxldGUoKSBjYWxscyBpdCBhZ2Fpbi4NCj4gICAg
VGhlIHNlY29uZCBjYWxsIHJlLWVudGVycyBpY2VfcHRwX3BvcnRfcGh5X3Jlc3RhcnQoKSwgcmUt
c2V0dGluZyB0aGUNCj4gICAgY2FsaWJyYXRpbmcgZmxhZyBhbmQgcmVzdGFydGluZyB0aGUgUEhZ
IHRpbWVyIHdoaWxlIHRoZSBmaXJzdA0KPiAgICBpbnZvY2F0aW9uJ3Mgb2Zmc2V0IHZlcmlmaWNh
dGlvbiB3b3JrIChvdl93b3JrKSBtYXkgc3RpbGwgYmUgcnVubmluZy4NCj4gDQo+IDIuIFByZW1h
dHVyZSBjbGVhbnVwIG9uIGFkbWluaXN0cmF0aXZlIGRvd246IGljZV9kb3duKCkgY2FsbHMNCj4g
ICAgaWNlX3B0cF9saW5rX2NoYW5nZShmYWxzZSkgZHVyaW5nIGlmY29uZmlnIGRvd24gb3IgcmVz
ZXQgcHJlcGFyYXRpb24sDQo+ICAgIGV2ZW4gd2hlbiB0aGUgcGh5c2ljYWwgbGluayBpcyBzdGls
bCB1cC4gVGhpcyBjbGVhcnMgdGltZXN0YW1wIHN0YXRlDQo+ICAgIHVubmVjZXNzYXJpbHkgYW5k
IGNhbiBpbnRlcmZlcmUgd2l0aCBvbmdvaW5nIFBUUCBvcGVyYXRpb25zLg0KPiANCj4gMy4gT3Jk
ZXJpbmcgZGVwZW5kZW5jeTogaWNlX2Rvd24oKS9pY2VfdXBfY29tcGxldGUoKSBhcmUgY2FsbGVk
IGR1cmluZw0KPiAgICByZXNldCBzZXF1ZW5jZXMgd2hlcmUgUFRQIG1heSBub3QgYmUgZnVsbHkg
aW5pdGlhbGl6ZWQsIGNyZWF0aW5nDQo+ICAgIGVkZ2UgY2FzZXMgd2l0aCBwYXJ0aWFsbHkgY29u
ZmlndXJlZCBzdGF0ZS4NCj4gDQo+IFRoZSBsaW5rIGV2ZW50IGhhbmRsZXIgaXMgdGhlIGNvcnJl
Y3QgYW5kIHN1ZmZpY2llbnQgcGxhY2UgdG8gZHJpdmUgUFRQIGxpbmsgc3RhdGUgY2hhbmdlcywg
YXMgaXQgcmVmbGVjdHMgYWN0dWFsIHBoeXNpY2FsIGxpbmsgdHJhbnNpdGlvbnMuIFJlbW92ZSB0
aGUgY2FsbHMgb2YgaWNlX3B0cF9saW5rX2NoYW5nZSBmcm9tIHRoZSBpY2VfZG93bigpL2ljZV91
cCgpIGZsb3dzLg0KPiANCj4gSW5pdGlhbGl6ZSB0aGUgbGlua191cCBpbiBpY2VfcHRwX2luaXQo
KSBhbmQgZW5zdXJlIHRoYXQgd2UgY2hlY2sgYW5kIHJlc3RvcmUgdGhlIGxpbmsgc3RhdHVzIGF0
IHRoZSBlbmQgb2YgdGhlIHJlYnVpbGQgZmxvdywgZW5zdXJpbmcgdGhhdCB3ZSBpbml0aWFsaXpl
IHRoZSBQSFkgdGltZXIgYXBwcm9wcmlhdGVseSBhZnRlciBhIHJlc2V0Lg0KPiANCj4gRml4ZXM6
IDZiMWZmNWQzOTIyOCAoImljZTogYWx3YXlzIGNhbGwgaWNlX3B0cF9saW5rX2NoYW5nZSBhbmQg
bWFrZSBpdCB2b2lkIikNCj4gUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtz
YW5kci5sb2t0aW9ub3ZAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBcmthZGl1c3ogS3Vi
YWxld3NraSA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQcnplbXlzbGF3IEtvcmJhIDxwcnplbXlzbGF3LmtvcmJhQGludGVsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogUGV0ciBPcm9zIDxwb3Jvc0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogTWFj
aWVrIE1hY2huaWtvd3NraSA8bWFjaWVqLm1hY2huaWtvd3NraUBpbnRlbC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9tYWluLmMgfCAxMCArKysrKyst
LSAgZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9wdHAuYyAgfCAzOCArKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlv
bnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBOb3dsaW4gPGFs
ZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
