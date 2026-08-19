Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437B442361
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132600; cv=fail; b=qlDZFzUTRD5Y+/Kgm+QgyM2/shjM8/F7SX53Sh9iEPzbYR1O4rYnpMuDT7g7CN1U6AzAMM8uV/rKK7AqlgwwOivPTj/00fqfLQhHShX43dqS2dLKXLtsDlvWwgJvhdlHJrlf1c67lfeAv0aYF5CxvWynQaIqRNJVhwoPJ0ZDzes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132600; c=relaxed/simple;
	bh=mpbH46VzCpERavmVwwr44S2/7KbdZWRDWIqqgFLZyRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gHPZTUE19uPK+9ulmZATHVOqoLaA+7PUd2/K4AwC06/3KvXlLyjXYtBp8zZz+jVNZDt/56J3RQ5QPy/h3iQRYZKuQfAtBDbH8YjaqbS4JxCmrvzOl+n2yCK5P5xofoeQVThHFn+Lh9EJQUBTPN91ue2lQPhUJ8TMuL4Yb+HHaU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iigX0/4+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iigX0/4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787132599; x=1818668599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mpbH46VzCpERavmVwwr44S2/7KbdZWRDWIqqgFLZyRw=;
  b=iigX0/4+ogTKYfvInlUMOgNHTiJZarJuxSniPgnLSlnpaYlwVm3UZOKG
   ezVgi0sIjlPh+YFyiYOIzdB5oGCQJkWp/Mv5TDuE7GX1vJkXEg2qTDkYp
   tdU5h3Ud6Zh3VO/P3+HYY/IJzt8XnyATz54rI68pyuo9cF7I8GXuOSez5
   QxpFxhefa+B1oV34z5NXCynAXr3eGuvliimk3syGnwAhaQKjnBTR4CPqs
   23u0vug5nf/1UkmhIM1qmctu7aj+WrZM1wBoDguUZLLFyRg90DoEqNm7N
   C9c133njWRJsFgAwEvGPb2cGsJvydZD025CfIJzk+K0UDCkf5YVZnnUse
   w==;
X-CSE-ConnectionGUID: WUvBMyXGSneGZAbZT+BGRQ==
X-CSE-MsgGUID: Xjl2hoSmRzKln2guyLaXFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="75168019"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="75168019"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:43:18 -0700
X-CSE-ConnectionGUID: UNDJhtwOQ8G0qA1GolYQHQ==
X-CSE-MsgGUID: RTx+O6fLSmWDX0sTaMIErg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="269776381"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:43:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 02:43:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 02:43:16 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 02:43:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xilOOk77YmAdTgbYLWtnfgvGlX6fQpaeYgBjG4I4VzdiarzlHLKFBvYGoV1WNAc7m3XXXyJso4eaLG1uufASOWyWmmqgh25436WAetFjSWj/QUIgrQj3LDJ0f/vkvc5etKq40plK3wroyxcMq5sXRrykvbRRViU6iU+mLuh7Oz1VA29HxCoA43SssBaN1KU+ULYtCDFHzwavrJrErYc1IC+KLPmSFr3Zugcv202/bLagkSFuYxdb6KJtd/3O11D7LR8H/GIA9Ve8CZIZOzADT7liFmxctxPMh1B91pqIbferanXF/MkDva6I+I/B8ftXtiO+YDE2m+HOLW0IyzGNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpbH46VzCpERavmVwwr44S2/7KbdZWRDWIqqgFLZyRw=;
 b=oGNsQnj+4hU7eufyeSWdCY6he+LLS+p43vA2fDZsnyMiyuxnqpPJRZL0cM8o8qfs88AsrFXb0qCBGCQkUNNoDigEnr0+YHF5o/tmyx/c6QnWQgGH1GxXC5qzyP7Q+ONkkoCscQhCMfoRFumXRszzv7MW1aDxjP3M9IijU5L3+b6j4RNhLA37ZvqDKRZDHJUNfwdMGFBjNMkh0R5hhNkDWqihmn9r4Xfm1+gsaKSLte4PQ1Q9witKT0MPugINhFWz+NzHxPitpWQGTA3C7xGSrzsN/Wupfq4xf+ZDxFWN7aX4JESvskZhmQv1zE1nX0jDH9Onj1qsSr/koxGzicGRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH3PPF632600ADB.namprd11.prod.outlook.com (2603:10b6:518:1::d27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:43:09 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:43:03 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "Hadi Salim, Jamal" <jhs@mojatatu.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "edumazet@google.com"
	<edumazet@google.com>
Subject: RE: [PATCH net v2 0/3] net/sched: u32_change() fixes
Thread-Topic: [PATCH net v2 0/3] net/sched: u32_change() fixes
Thread-Index: AQHdKyFDbaeq7rmC8UuThcGOX+Yni7aiNXkAgAE/OkCAACNRAIABjvKw
Date: Wed, 19 Aug 2026 09:43:02 +0000
Message-ID: <PH0PR11MB5902FEEA100F0F797C0D087AF0A52@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
 <ccba8112-ff9a-47ea-8b91-a732e28b555d@intel.com>
 <PH0PR11MB5902885C0E23D5DEED9011C6F0A62@PH0PR11MB5902.namprd11.prod.outlook.com>
 <CAM0EoMm+XqVrSznS4pK_n2X6XGWO-kb001gSwQMDCM20keECKg@mail.gmail.com>
In-Reply-To: <CAM0EoMm+XqVrSznS4pK_n2X6XGWO-kb001gSwQMDCM20keECKg@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH3PPF632600ADB:EE_
x-ms-office365-filtering-correlation-id: cc4db9f8-4b48-4efe-534c-08defdd6437d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|4143699003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: 45297NRtu5cu+LycXFRGcNB21QY1OKwdolMVqsXiiIrpJ3FP7ue36H+HX5TUlZY8hakaxmnOHu8hfq0qg7vlSDhyWgL/qFdaMITkOAeyvP3z6Cb4/UKWcgCs7lpsFwAVwsPAH3Bu+gwhc0jcrLb70t/0b2L8w5Hrr15CNB3vyQ4XfGJbDUNZgngoMkqNbrHEtXJOD/dkLxzbFXfDcLsgIASnMFQrGuCorx7/OC7tUvi4ZoADmVHFJUYfU16g/ufraiSLP1/BsgTV24hpQK6PYDBHbs+ohiZeLRFGFoSLxR4sCtybhd6A335fn6RCRtDJwTn0UcIedpSAE+ClNFwWUFD0oLRssfF3Dndg83SgJcUB5P7rTjyWQCLZJgb7VYIAjJTicT09UctjAdM2fHVYNR5fuN/xSJOx+cxP/BOZuqKv6lM5vXQTMUzZSu6AbKrwwaPZco7+8ZsoK+HivEZtHjkDUZ+LFsk2+PrPI8NVCuDZy91woH6WSYXjI8ktZiIeL4jB9vkvbv9LJzGCIGCE4UTFu2UPI0LiMaPIKwblcojLMPL7ajgpRIbydwgKiZjXJdFTYYdCE/y5ZhylG5qAhfqM457S9J1jLq09Lg23c5/xubPoe4knPsirZwxQENTIVNxXtiULfFWNT7b5ulsbxkZRfDQlV+T5QI8jbfoD/k4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTdMMXRpM3p6bC91WkF4RXFtZ1FVSkp1ZUoycUtjVlhHNDd5eUNHU2VHVTVm?=
 =?utf-8?B?K05KUDJna1BBY3BkdGFWTkJEUDUwV0g0d0s0Y3ZhZXAyL2xyVEM4b1B0ODNv?=
 =?utf-8?B?WEJDZStESUovcDVDVW1kSW1UVHJic2hKYWpLY1E5Y01YU1djYnk5SEFPTlo5?=
 =?utf-8?B?Z3NyUy9SK0ZCbEdNQ0JOQU1EMittQTloTXFONWtkWEUrYTRaOXRvc1hTUDhE?=
 =?utf-8?B?cDJjT25tcHgxcTJpaWo4SHZKRkFtYk41YUk5NVlnekx6MFk3UWdQTVpmV2Vo?=
 =?utf-8?B?aGpQTHJFdnhVK0pKK1ViSVU2Yk9VYjFiUEs4NS9kUFNaSnBSRnUrd0dqb0NZ?=
 =?utf-8?B?QTZyWFZ3MGZjVG04VURwZEIyWnN0SWV1NGlmMUxvd0swNXZLaGI0NVJoa1Z3?=
 =?utf-8?B?TDdsbUZTMEJ3Y3IyakR2VSsvZ1VaV21SWTc4Uzh2MFdjdTJpWTFPd29KWG9S?=
 =?utf-8?B?aEhIZlNVTlkybWZpOUZmNkNiRm9KeFNNVXpOZEtpNzhjRG1SOGtvZm1pMDlI?=
 =?utf-8?B?U3VFRVVtZktxTThmQXh3U0dzSVYvMUNKVzExRW5XWFJ6MDh2RksrMWpBSnZR?=
 =?utf-8?B?Q2dBcFpQb1l6R1hHc0dXczdGLzRoS045SytUbGt6S1pYWWhYU3ZPSkUyQzJv?=
 =?utf-8?B?TVRNZ2NhOFNuazdRcWJMM2RTeThMZnhGUDdlUldiQ1d3UXVCMHdrcldKMUVN?=
 =?utf-8?B?UTRLK2FDS3RsWVFQOUhvekZoeVNYclM1Q3dJdUFmMVpXZzcxcFdRRk1XeVV3?=
 =?utf-8?B?Slo2a1JkalhNZmtvMjBQcG1lckxEVlVySGFUQlNGcHZ1dnhaSWdLQ1c5UzEy?=
 =?utf-8?B?N3hkeitMUXBSbjBzRWkvdG5UYWlJNEVtT0tIWUgrVlUrVjd5ZEdsYnprZTkv?=
 =?utf-8?B?ekZwcS9QNEliVGRRakFyMGZXRHowVFRrU3lkeFFMQU1ySklMMDZ2TUxTcGw3?=
 =?utf-8?B?QjBzR1J2QnR1MXRBTWRCQ0cydlA1cloxWWFwdFM0dEFKL01YMldwTkJwSVN3?=
 =?utf-8?B?QVhzU3hoOUJDYVdLbDhKY2IveHBhb1JyazBxbFdnQk44V0pHZFhOZ2d0S3hB?=
 =?utf-8?B?bFBxN0VSWnZMVEVwTDhnSWtwTTM1aERlK3VRL1pBM0dxcEFId2JyRzVDVFhk?=
 =?utf-8?B?bXc3WDJBK3FEVHhFandMalRBWExEQy9uQ09XM0k1MXVEL2FZamZkMXB3WWVr?=
 =?utf-8?B?V3JyR0ZSeGNLZGJOUm9hNVp5OGk3SUIyQWNRcXZCWnJoK1ZrUldWaGFtbmww?=
 =?utf-8?B?YUJMcHRHOEg2ZFhsMTJBMGpOZkx5YlljQ3NHZ2VTZm1WNXdvMlI3SW1OU2l5?=
 =?utf-8?B?RUtTZ1dyUnVlOE9iNGgySlJYSXcydkJFb2tNWjZZYzIwdDZ3My94WWhKaXpl?=
 =?utf-8?B?U09vQUVIZTRBNkJycjBkZ0lWa3lzOG5vVnV4M3czTjRESzJYeEJDT0hjcXd3?=
 =?utf-8?B?cVNyZmpRWlZnbzBRYVEwam85NlRucHlKbTR1WlJVQUZMTFRNdE5maG5mOVdN?=
 =?utf-8?B?cTlxKzczVEF1RXdsSVRLT1NaWXRVWWRuYzhYZkh2MU1scVpaYjNSMTdCT09R?=
 =?utf-8?B?emRmeEZoVXByWEFWMXFiYUZLZEhaU0FQbUxDWHZYYmc0dnhmNk05YUR5QlY2?=
 =?utf-8?B?cmt5SkNpWm5xQyt0T3R5NTBZQit2eHZtRTJQeXVhK0JZN3VYTnh5OEwrRVV1?=
 =?utf-8?B?eUFqZnY2YUVUQ3MzZGdCRjVzL0ExWUIrVjBURCtXVzFOT1ZTcHBhVWxjN0R3?=
 =?utf-8?B?UlRaK2JiRFhFb0tSbXdlaFF1N0ZLcVhrVXNHV0tGaHZERGY4YklsN1hBSnV2?=
 =?utf-8?B?ODdXNW5tNUt4N2dXemMzNDVLeThEUDd4YjZndUM3RUJRbEhUYVU0NE5YNDBt?=
 =?utf-8?B?QVBKYTM2dTFOdEluak9yemt2UElNd1NSOWkvTWw3Rjl5MVVwSmdqVjdSVk1m?=
 =?utf-8?B?ZTJPMHhLemdnMzlldUF6NmlWNVNkSHA5SkFtNitBV29KcmF3d0hZaVp6MXZK?=
 =?utf-8?B?RExuTFZuajJWRm9UYUhXQk5zMDVhclhuVDgzTndkRmY2Rkc5V1VBenpaYVRp?=
 =?utf-8?B?VnNadG1USFFhN1RJV1lYWnd0RGJrK2JxMUVzanAwRUY0NkhPczM4TGtLUFBL?=
 =?utf-8?B?YW43dGtzQUQ2WEtrMW4xK1ExOHUxRTVEUkc5QkNMT2FXSk93N0NrSmtpeElF?=
 =?utf-8?B?V0tKZmd2cXd3YlhZaDhqYXhpZFRHazdUcnhFZnBWZzBXNjNEUk15cWtkOHQx?=
 =?utf-8?B?Szl5bUlXajg3VHR4d25WeGtTTndQMVh5V0Voc1FxZHVFWFkrbHZFOVluTWpN?=
 =?utf-8?B?dEw2SmQvUjh1dWpRUmk1SkJlMCswbDRXYWZmb3ZRRzJxdEVNV1Budz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E40AyHAb/tUQ/wN/+T/CJrBWLrwbyKgL/J1E8TrXC8czMl5l9jM6aJZT1kXk26kM4HPXgsB3I+EPYoX564ZKFaKL3vH3cjuQD8O87Wvtyatpqe2UxRFhEzSsuJS7WAR2LJe6aFt9e24+XuTQtT3kO71kZg8VXY0U7qqb/PK8tEu5x/qiql/C9Xjl01BzID6I+ojrf2S9A2ITNOxD+WsFR0pSXsO4fdzjeYRu+bMX4ho+9e+7TB2lPHrOSFZJgWlfJ27tvX5p0ONOoIjR5/XAiamZgvWVAJRpy7i3LUIi9mdVTqWWAw3/J5VZYAh2O+T9F/ZKKClxAI1J3GFhu8lJ4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4db9f8-4b48-4efe-534c-08defdd6437d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 09:43:02.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XoSaAQCkDueE5ETxJYyTU4QoKRXaxoqBS4c7b4teQ/AxYx+ErxCYv6dEZj2eSdT5oYy4ZO5SaQvnVb92QA/3RU8LTLEX+kBmgcAmB4c/vA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF632600ADB
X-OriginatorOrg: intel.com

PkZyb206IEphbWFsIEhhZGkgU2FsaW0gPGpoc0Btb2phdGF0dS5jb20+IA0KPlNlbnQ6IFR1ZXNk
YXksIEF1Z3VzdCAxOCwgMjAyNiAxMTo1MSBBTQ0KPg0KPk9uIFR1ZSwgQXVnIDE4LCAyMDI2IGF0
IDM6NDjigK9BTSBKYWdpZWxza2ksIEplZHJ6ZWoNCj48amVkcnplai5qYWdpZWxza2lAaW50ZWwu
Y29tPiB3cm90ZToNCj4+DQo+PiA+RnJvbTogS2l0c3plbCwgUHJ6ZW15c2xhdyA8cHJ6ZW15c2xh
dy5raXRzemVsQGludGVsLmNvbT4NCj4+ID5TZW50OiBNb25kYXksIEF1Z3VzdCAxNywgMjAyNiAy
OjQzIFBNDQo+PiA+DQo+PiA+T24gOC8xMy8yNiAxNDoyMiwgSmVkcnplaiBKYWdpZWxza2kgd3Jv
dGU6DQo+PiA+PiBzb3JyeSBmb3Igc3BhbSwgcHJldmlvdXMgc2VyaWVzIGdldCB0cmVhdGVkIGFz
IGluY29tcGxldGUgc28gcmVzZW5kaW5nDQo+PiA+Pg0KPj4gPj4gQUxSRUFEWSBPTiBORVRERVYs
IFNBU0hJS08gUlVODQo+PiA+DQo+PiA+aGVoZQ0KPj4gPm9mYywgdGhlIGFib3ZlIGRvZXMgbm8g
aGFybSBoZXJlDQo+Pg0KPj4gOkQNCj4+DQo+PiA+DQo+PiA+Zm9yIHRoZSBzZXJpZXM6DQo+PiA+
UmV2aWV3ZWQtYnk6IFByemVtZWsgS2l0c3plbCA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNv
bT4NCj4+ID4NCj4+ID4tLQ0KPj4gPg0KPj4gPlNhc2hpa28gaGFzIGZvdW5kIG9uZSBtb3JlICpw
cmVleGlzdGluZyogYnVnLCBwZXJoYXBzIGl0IGNvdWxkIGJlDQo+PiA+aGFuZGxlZCBieSBvbmUg
bW9yZSBmaXggaW4gZnV0dXJlIHNlcmllcz86DQo+PiA+aHR0cHM6Ly9zYXNoaWtvLmRldi8jL3Bh
dGNoc2V0LzIwMjYwODEzMTIyMjQyLjE2OTAwMjQtMS1qZWRyemVqLmphZ2llbHNraSU0MGludGVs
LmNvbQ0KPj4NCj4+IHllYWgsIGkgc2F3IHRoYXQgYW5kIGkgdGhvdWdodCBhYm91dCBleHRlbmRp
bmcgdGhlIHNlcmllcw0KPg0KPklmIGkgYW0gY291bnRpbmcgY29ycmVjdGx5IHRoZXJlIGFyZSBu
b3cgMyBtb3JlICJwcmVleGlzdGluZyIgaXNzdWVzDQo+dGhhdCByZXF1aXJlIGZvbGxvdy11cC4g
QXJlIHlvdSBnb2luZyB0byBkbyB0aGlzPw0KDQppIHdpbGwgdHJ5IHRvIGFkZHJlc3MgdGhlIGlz
c3VlcyB1bmNvdmVyZWQgYnkgdGhlIGluaXRpYWwgcGF0Y2gNCmhhdmVuJ3QgbG9va2VkIGludG8g
dGhlIHJlcG9ydCBtb3JlIGRlZXBseSB5ZXQgc28gd2lsbCBzZWUgd2hhdCBudW1iZXINCm9mIGZp
eGVzIHdlIHdpbGwgZmluaXNoIG9uDQoNCj4NCj5SZWdhcmRpbmcgdGhlIG90aGVyIGxlZ2l0aW1h
dGUgaXNzdWVzIFNhc2hpa28gcmFpc2VkOg0KPjEpIFBsZWFzZSBkb3VibGUtY2hlY2sgZXZlcnl0
aGluZyBhbiBBSSBjbGFpbXMsIGVzcGVjaWFsbHkgaWYgeW91IHVzZWQNCj5vbmUgdG8gZ2VuZXJh
dGUgdGhlc2UgY2hhbmdlcy4gSXQgaXMgdmVyeSBjb25maWRlbnQgYW5kIF9kb2VzXyBtYWtlIHVw
DQo+c2hpdC4gRXhhbXBsZSwgYmFzZWQgb24gd2hhdCBpIGhhdmUgc2VlbiBiZWluZyBwb3N0ZWQg
aXQgd2lsbCBtYWtlIHVwDQo+Zml4ZXMgdGFncyB0aGF0IGxvb2sgc2VyaW91cyBidXQgZG9udCBl
eGlzdDstPiBzbyB5b3UgbmVlZCB0byBmaXggdGhhdA0KPmlkLg0KPkFsb25nIHRoZSBzYW1lIGxp
bmVzOiBNeSBhc3N1bXB0aW9uIGlzIHlvdSBhcmUgYWN0dWFsbHkgdGVzdGlnbiB0aGlzDQo+YWdh
aW5zdCBzb21ldGhpbmcgbGlrZSBpeGdiZSBhbmQgYWRkaXRpb25hbHkgIGEgZGV2aWNlIHRoYXQg
Y2FudA0KPm9mZmxvYWQ/IEFkZGluZyBhIHRlc3RlZC1ieSAoaWYgcG9zc2libGUgYnkgc29tZW9u
ZSBlbHNlKSB3b3VsZCBiZSBhDQo+cGx1cy4gQW5kIGEgdGRjIHRlc3QgIHdvdWxkIGJlIGFwcHJl
Y2lhdGVkIGFzIHdlbGw7IHRoZSBza2lwX3N3IHJlamVjdA0KPnBhdGggaXMgb25seSB0aGUgdXNl
ci12aXNpYmxlIGhhbGYgdGhhdCBzZWVtcyBwb3NzaWJsZSB0byBjcmVhdGUgYQ0KPnRlc3QgYmVm
b3JlIHdoZW4gdGhpbmdzIGp1c3QgcmV0dXJuZWQgc3VjY2VzcyB0byBub3cgcmV0dXJuaW5nIGFu
DQo+ZXJyb3IuDQoNCnllYWgsIGltIHdvcmtpbmcgd2l0aCBjdXN0b21pemVkIHZlcnNpb24gb2Yg
aXhnYmUsIHdpdGhvdXQgdG91Y2hpbmcgSFcNCmp1c3QgY2hlY2tpbmcgU1ctZW5kLCB0aGVuIGkg
ZW5jb3VudGVyZWQgdGhlIGluaXRpYWwgaXNzdWUNCg0Kd2lsbCB0cnkgdG8gc29sdmUgdGVzdGVk
YnkgY2FzZSBpbnRlcm5hbGx5IHdpdGggb3VyIHZhbGlkYXRpb24NCg0KPg0KPjIpIENhbiB5b3Ug
cGxlYXNlIGFkZCB0aGUgY29tbWVudCBpbiB0aGUgY29tbWl0IGkgYXNrZWQgYmVmb3JlIHRvDQo+
ZXhwbGFpbiB0aGUgdXNlciB2aXNpYmxlIGNoYW5nZXMuIEluIGNhc2UgbXkgb3IgU2FzaGlrbyBt
ZXNzYWdlIHdhc250DQo+Y2xlYXI7IGJlZm9yZSB3aGVuIHlvdSByYW46DQo+InRjIGZpbHRlciBh
ZGQgZGV2IGV0aDAgLi4uIHUzMiAuLi4gc2tpcF9zdyIgaXQgdXNlZCB0byBzdWNjZWVkIChleGl0
DQo+MCkgYW5kIHRoZW4gdGhlIHJ1bGUgd2FzIGluc3RhbGxlZCBpbiBzb2Z0d2FyZSB3aXRoIGEg
c2tpcF9zdyBmbGFnIGJ1dA0KPndhcyB1c2VkIGJ5IG5laXRoZXIgcy93IG5vciBoL3cuDQo+QWZ0
ZXIgeW91ciBjaGFuZ2VzIHRoZSBvbiBhIGRldmljZS9ibG9jayB0aGF0IGNhbid0IG9mZmxvYWQs
IHRoYXQgc2FtZQ0KPmNvbW1hbmQgX25vdyBmYWlsc18gd2l0aCAtRU9QTk9UU1VQUCBvciAtRUlO
VkFMLg0KDQpvaCBzb3JyeSwgaSB3YXMgZ29pbmcgdG8gYWRkIGl0IGJ1dCBpdCBkcm9wcGVkIG91
dCBvZiBteSBoZWFkLi4uDQoNCj4NCj5Tb21ldGhpbmcgYWxvbmcgdGhlIGxpbmVzIG9mOg0KPkJl
Y2F1c2Ugc2tpcF9zdyBpcyBub3cgaG9ub3JlZCwgInRjIC4uLiB1MzIgLi4uIHNraXBfc3ciIGFk
ZC9yZXBsYWNlDQo+Y29tbWFuZHMgdGhhdCBwcmV2aW91c2x5IHN1Y2NlZWRlZCAoYW5kIHdlcmUg
c2lsZW50bHkgc2tpcHBlZCBieSB0aGUNCj5zb2Z0d2FyZSBwYXRoKSB3aWxsIG5vdyByZXR1cm4g
LUVPUE5PVFNVUFAvLUVJTlZBTCB3aGVuIHRoZSBibG9jayBvcg0KPmRyaXZlciBjYW5ub3Qgb2Zm
bG9hZCB0aGUgZmlsdGVyLg0KPg0KPmJhc2ljYWxseSB5b3UgbmVlZCB0byByZXNlbmQgd2l0aCBh
IHYzLiBBZGQgYXQgbGVhc3Qgb25lIHRkYyB0ZXN0Lg0KDQpzdXJlLCBzbyBJIHdpbGwgZXh0ZW5k
IHRoZSBzZXJpZXMgDQp0aGFua3MhDQo+DQo+Y2hlZXJzLA0KPmphbWFsDQo+PiA+DQo+PiA+ID4g
QEAgLTkzOCwxNCArOTM4LDYgQEAgc3RhdGljIGludCB1MzJfY2hhbmdlKHN0cnVjdCBuZXQgKm5l
dCwgc3RydWN0DQo+PiA+c2tfYnVmZiAqaW5fc2tiLA0KPj4gPiA+ICAgICAgICAgICAgIGVyciA9
IHUzMl9yZXBsYWNlX2h3X2tub2RlKHRwLCBuZXcsIHVzZXJmbGFncywgZXh0YWNrKTsNCj4+ID4g
PiAgICAgICAgICAgICBpZiAoZXJyKSB7DQo+PiA+ID4gICAgICAgICAgICAgICAgICAgICB1MzJf
dW5iaW5kX2ZpbHRlcih0cCwgbmV3LCB0Yik7DQo+PiA+ID4gLQ0KPj4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgaWYgKHRiW1RDQV9VMzJfTElOS10pIHsNCj4+ID4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHRjX3VfaG5vZGUgKmh0X29sZDsNCj4+ID4gPiAtDQo+PiA+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgIGh0X29sZCA9IHJ0bmxfZGVyZWZlcmVuY2Uobi0+
aHRfZG93bik7DQo+PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChodF9vbGQp
DQo+PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVmY291bnRfaW5j
KCZodF9vbGQtPnJlZmNudCk7DQo+PiA+ID4gLSAgICAgICAgICAgICAgICAgICB9DQo+PiA+ID4g
ICAgICAgICAgICAgICAgICAgICBfX3UzMl9kZXN0cm95X2tleShuZXcpOw0KPj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+ID4gPiAgICAgICAgICAgICB9DQo+PiA+VGhp
cyBpc24ndCBhIGJ1ZyBpbnRyb2R1Y2VkIGJ5IHRoaXMgcGF0Y2gsIGJ1dCBsb29raW5nIGF0IHUz
Ml9jaGFuZ2UoKSwNCj4+ID50aGVyZQ0KPj4gPmFwcGVhcnMgdG8gYmUgYSBwcmUtZXhpc3Rpbmcg
aXNzdWUgd2l0aCBob3cgbWFudWFsIGhhc2ggdGFibGUgaGFuZGxlcyBhcmUNCj4+ID50cmFja2Vk
IGluIHRoZSBJRFIuDQo+PiA+V2hlbiBhIHVzZXIgY3JlYXRlcyBhIHUzMiBoYXNoIHRhYmxlIHdp
dGggYSBtYW51YWwgaGFuZGxlIChmb3IgZXhhbXBsZSwNCj4+ID4weDgwMTAwMDAwKSwgdTMyX2No
YW5nZSgpIGluc2VydHMgdGhlIGZ1bGwgaGFuZGxlIGRpcmVjdGx5IGludG8NCj4+ID50cF9jLT5o
YW5kbGVfaWRyOg0KPj4gPm5ldC9zY2hlZC9jbHNfdTMyLmM6dTMyX2NoYW5nZSgpIHsNCj4+ID4g
ICAgIC4uLg0KPj4gPiAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+PiA+ICAgICAgICAgICAgICAg
ICAgICAgICBlcnIgPSBpZHJfYWxsb2NfdTMyKCZ0cF9jLT5oYW5kbGVfaWRyLCBodCwgJmhhbmRs
ZSwNCj4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGFuZGxl
LCBHRlBfS0VSTkVMKTsNCj4+ID4gICAgIC4uLg0KPj4gPn0NCj4+ID5Ib3dldmVyLCB3aGVuIGRl
c3Ryb3lpbmcgdGhlIG5vZGUgbGF0ZXIsIHUzMl9kZXN0cm95X2hub2RlKCkgcmVtb3ZlcyB0aGUN
Cj4+ID5tYXBwZWQgSUQgcmF0aGVyIHRoYW4gdGhlIGZ1bGwgaGFuZGxlOg0KPj4gPm5ldC9zY2hl
ZC9jbHNfdTMyLmM6dTMyX2Rlc3Ryb3lfaG5vZGUoKSB7DQo+PiA+ICAgICAuLi4NCj4+ID4gICAg
ICAgICAgICAgICBpZHJfcmVtb3ZlKCZ0cF9jLT5oYW5kbGVfaWRyLCBoYW5kbGUyaWQoaHQtPmhh
bmRsZSkpOw0KPj4gPiAgICAgLi4uDQo+PiA+fQ0KPj4gPkZvciBhIGhhbmRsZSBsaWtlIDB4ODAx
MDAwMDAsIGhhbmRsZTJpZCgpIHJldHVybnMgMS4gRG9lcyB0aGlzIG1lYW4gdGhlIElEUg0KPj4g
PmVudHJ5IGF0IDB4ODAxMDAwMDAgaXMgcGVybWFuZW50bHkgbGVha2VkLCB3aGlsZSBpbmRleCAx
IGlzIGVycm9uZW91c2x5DQo+PiA+ZnJlZWQ/DQo+PiA+SWYgaW5kZXggMSBpcyBhbHJlYWR5IGlu
IHVzZSBieSBhbiBhY3RpdmUgYXV0by1nZW5lcmF0ZWQgaGFzaCB0YWJsZSwgY291bGQNCj4+ID5m
cmVlaW5nIGl0IGhlcmUgYWxsb3cgZ2VuX25ld19odGlkKCkgdG8gaXNzdWUgdGhlIHNhbWUgaGFu
ZGxlIGFnYWluIHRvIGEgbmV3DQo+PiA+aGFzaCB0YWJsZSwgY2F1c2luZyBjb2xsaXNpb25zPw0K
Pj4NCg==
