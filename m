Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A683A872D
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505282; cv=fail; b=pgn3WLjs1othkHa9vkYQldIMYPBfpMPslINvjf7S5jYpp+rim82XPEWOfA06UIGQv/RVx8e146kCsaVDJZdRaEKhNqFUMtNrKn/ItYBwwXd3LtaWVy43qNtkFd0eWWDjgPymxV9ASJYWFGvdfTTK5OsrnZ414xAh/Qnu2PH19Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505282; c=relaxed/simple;
	bh=w99922MFiD+HWXW5Yl51/quSzGGQjnkMQ1tp0B8ifIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5+v8kW5mEJMXTTZjJIQd8DGYszHIggKQU4SC3JI60SDGf6NU2p7PNG+qlTFJrTiivqBgX8lFkaffxqmms/3/ThyJouL5nWtwIrLjDvxyS0N32FN1Xe8/sDFHDIEYPxVOUTTUIlsVvZ3XB+Nv5MOer8mhn/oUyLTO5IdF0eF7CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hXVkPYua; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hXVkPYua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505281; x=1820041281;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w99922MFiD+HWXW5Yl51/quSzGGQjnkMQ1tp0B8ifIs=;
  b=hXVkPYuaM3J9b9nypY5yqQ0Rhof1I4zeJuVfyYxZFAHQEftAcUdhBXpz
   NL2RbNafpTFDowQOUsDMtEtjN1raqyCN5fCpSFjZ/vRzVBTPWrs3breOs
   2/XsT1GNxe1dVoIJlQxJcEfUmbUxYDInIqfDd6JAOHOEKDwijn/DsU/bn
   KlqAUa82ZFFP8dCZKp8y2eeWVgrC6+HwAhDYiecNI8YVJkLl9GsT4yEsQ
   9lBOO+iivxB/FAzM9gb1SLrGVtlr4gGbg+BPmbCSMPL/UaSttOnNHbbgz
   1E7ease7k9dupJxb2m9+gV8TP9w/bxH5tLehPkGmCmZXZXgYf5nwmbu15
   A==;
X-CSE-ConnectionGUID: KWRCJqdNQHKy6BU6TXloiA==
X-CSE-MsgGUID: IwXK1j5LT5uiJTDUgUFUzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89023173"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="89023173"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:20 -0700
X-CSE-ConnectionGUID: LkSjzuQYQB232FNEFHr5lA==
X-CSE-MsgGUID: 1345We84S3a4kCXm4//OBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268225748"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:01:19 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaAMayYPCyLT81iKrUyrLGmbwAJqWHKDIWVXec7f4KEpkrg+wHp+2afaJT7h1gUFJWY/6ibsY6tbrFoCHO2rX2HSNH07JAuPkFJozV2C3fCmsAEtaIJhRismaHrCQFY7uexETFd4utS5PSY0MvRdfenejxCqo/+cnVxk1EbSlJi74VQZMunJV0lYviK9iqWtzDPJTkUtsZfLEIF2n8aLCoYsi6bDPQ2h8YiyybfWnEBV+/3PsWeeXnlfG6FirSA/5qujIKJ9D9iaTR2cp/Z730UYKWeA6QdtplYAUBnWCDRJKdg6HXtoXX4Y/PIuSePXVBciJ2yrDRI+zy9tj/pG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSVzlTVSHMFGsIj7jwSiefh49fDkjQaInlYvN0MbJRg=;
 b=zO2+Hu/u7hAF0iE8inCDlgV0oN/M4qy3MFQJCKi24xaI+HoTbb83BHU9Iy25XWSmUZLga5z3osvNWUQWwdGcX4/5QXXzy/GWIV9hrO8F1HXftjZiAh3BCRgRpzAPg3u4gA3JgXO4KZ85nhG9GOoOFuoEXn8rEmMuu+XJbf4sQ0b9gXtcMyIGslht6xbcEg/F0i9rKjEbAQoL/y1R07pUJjVwxKsOZRH+8dQ1ONq29J7fpKTOsfWSh4rDNyh2CG0jO6DsPjhOHLvc/taG9hxRRQM1p+9ZQVhLX3fXdenaoJ7jwFP9QiwtpNZjyWm9p+t7SvU68A4QSfh3N1ETivMgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:01:16 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:01:16 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 12/12] ice: use ACL for
 ntuple rules that conflict with FDir
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 12/12] ice: use ACL for
 ntuple rules that conflict with FDir
Thread-Index: AQHdChZJDh7YNnXfEUylNicMNG3eura+WjFw
Date: Fri, 4 Sep 2026 07:01:16 +0000
Message-ID: <IA1PR11MB6241EBEF55403E74840E60C38BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-13-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-13-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: d4ec5d87-bdfd-4c05-35a3-08df0a5250a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 9KVUqqJA8xxRyHch9fxAZQrdBCqSG4afUiXIhurp5ruljOWPZ0N21c2DmWUJwW+4yrbaAdF3m3N7Vn05e4fFvTGMFni0wn+ShnRd+EiOC/RKiv7mAd5aeSknWStQCIJTLqASLb3EPJgh8t2BHPihRhPFtBrHNpJ1j4jj8CyEncXLAiJtuoq9c9MqJGyZWjXAwCj2tqWoObS7eTJSdpaetnzLfl92SPRXtqKw9A5Z+P8ftTD95p0W0M/EYWMWPIDlfk1Oh+K6e/7669fSKRMUDb/Z4A41JaTeWa/nFLlLeAFVdj8d4/ZvCtjCvJSzQc9ALjTNwSB2Y3F6W6q32xl6wp6QnaqouYBI3CwrtmnoNU0T1DTlRRf+5CBosRvbDfn/skIw2fC1rBbQ6rz5uU0VaiwHUpvqiwYaD4FUSRe0c4IfsDt9XgcUanPKcyI7Tx7Kgck+/YhVKWGSIfHROtk1sMvV7QGzpq4YpW8t2vHZbexGzVJNeG4JmL4xdtimPK9tzyKgmbmKqENJAR69KomUJ+W2BSgUQoapZMn39oEmCEkTqHe3EIDVjSR6lIAUbOVYcjqUNxAkS4ysrm9OZlBFbWjEL9M6EbYD9oyQNMCnsIAJnrkTuL19Wuz4zynAFBp6jp+V2afdnElGzGXBN2z8/gNdg0cCiGIeeJvAcoOZ8/fVe1HyvJUDaLa8/HWvCM5SOYhdZgauflv2qzW5x6Gtvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?prU1ub0ikQtvaaFVxqAHwJBy2jSQ9148a4QwE8Ru4oOFw2Ew7gYntU48gyVJ?=
 =?us-ascii?Q?QxdvBiolY0W8zF70XuFXO70rojMZmXb2gAV4l3LU/lz09927a06GNA5yagYP?=
 =?us-ascii?Q?ysTOJ+zBUz0pyPGDaF5dN6wvKrPdHuPLfOdbv/DUg/hWEq1Q0P7d/G6Kjn7g?=
 =?us-ascii?Q?buMCrrFqibVWhQvGya3CWj0Y6vnWQUvOBbM+Hy+kVCgD9zF8hnQiswIMvPBV?=
 =?us-ascii?Q?himm5sfKyy1pPWmJp49QNb51Ak7fsFQj5sCeTyHQF7IOQ+QDYmOrcKcLDjMl?=
 =?us-ascii?Q?3cZuslkIh4tmZRa8H/aE/5/68Pg4HrI4Zy6O0LsIc0e1ug6MH4CFtP0BhbBP?=
 =?us-ascii?Q?6WdAdEo5CL6ZDPRa+eY2aw2ilwI4Sx4K/2ZE435pqIoQKZ3rW4BsHQ2N4l31?=
 =?us-ascii?Q?gbYItP1VabcTS5aGN3ZuC5r8xzIDM6Z3faKZcVtxaKTWyequ6Q5pL5Qxtpc1?=
 =?us-ascii?Q?LSsJz0+M5dtLTwHhwFeNCND9nIWIx3XJb0amYDWHvHLyIiGp9sBfAh8Y++V7?=
 =?us-ascii?Q?m7ahwra8Ou3Mom4QFiZG/ez23eLrR37WMxOCN8USre0br+Hg45C8vcl1U3FO?=
 =?us-ascii?Q?qtXVizAR/GsXqVu3GUnRuSRIm9RY+dmujEAdXr9lImVErLmJn/FrSZbg67kl?=
 =?us-ascii?Q?rWwQW79jKg3zJhQ5bbUDfnYHPLcguCSj6l0+loFZVqT/uoVbrs0LHFDdHSw8?=
 =?us-ascii?Q?xblfdh7UHHDGLJrzGl0ORmlk5SWt3npRGtFU0oGI/BTPg5YS/hTLIQ8bTg4r?=
 =?us-ascii?Q?mtTICk7o7qtNdC+YhEvu8l1iICVZSXdp+2UVDV81blyzT877nCCslFCXDKhJ?=
 =?us-ascii?Q?ONy+5R+RnJDn7vffsiNBFNEF3x6B55Z3oLmUmDeSSGiug7nMtS9OD1Afjypj?=
 =?us-ascii?Q?PPpBZoSixCt8yAnoDPt1RNLUsgjC71Cr++x4RK5SSYUV41EBLwBz9Fucs7pP?=
 =?us-ascii?Q?D9P0si1YnqS16VpfmJJjAZG1s+2qdSo0KPS5OBpGaLvJbF+7v27pAqVGMVTK?=
 =?us-ascii?Q?SXIElLONZKLJldyRhK+zXkPkhCJPODi8sluaPHwpCqse/C16UjMBsDsVn81O?=
 =?us-ascii?Q?LopOwQuRJq+xuKg/TxPPrDW2ulCTw9CmYipvG6Fsp773lV+NT0i3QPaVAvXl?=
 =?us-ascii?Q?2KUjFTTMi7hkp009ca47oa+6UwZI2wzIf5MFzmDqNaMarLP/qmIilPR0noYL?=
 =?us-ascii?Q?1hMWNcoM0nDRbkPY/2rfB0J+Sc8mcDtwmX+VwX36436WKLzAW01T6zB87lx4?=
 =?us-ascii?Q?Y3ZL83PuLlviHDeSCvDmWV/fvUKe+wQiZOgJPZG3UFwAIMuqVm+YpRhqFBaw?=
 =?us-ascii?Q?5OUwjBQBYWVJziIPBRleSjrITg866WNqcsTpUbxlJgtNLZ+QjsVkmJDgHOWB?=
 =?us-ascii?Q?pIiNm5ZSTj8FHsVZ+ONZuUXaGBmgIROfJoWXrtn7LJjxYmcioZAyyNdA22Wq?=
 =?us-ascii?Q?faim33L9IZi7LBWnRbpSKE4d5Ahp89JXNEGKZubGy5CSZUtYU99GY0vwJ6yp?=
 =?us-ascii?Q?JGKNbtrk4WO40GMdEI5SDA7+XsR3/yKFcl/bpBA3uvkGpR0R6AFN3qNatoVu?=
 =?us-ascii?Q?uepfwoi0CXkRvTntdhc1gQHW8E6oKlSjwdK/6kqQ5q54VEbyYrDoP7Lt4Fvc?=
 =?us-ascii?Q?Ry06wt2mSPDuaUS+b04Nd9+lR3oO1U1KB62bYnuAlyyaArptBPs2j0lvF35z?=
 =?us-ascii?Q?oUZhZMWoI+fzAks+cCdAmwDfA+07JhMxIFA4PsCkjtWFKuID?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CnPwBK2QNcB1LunSuekAQL5FDR+W4CormoLaQyu0p+sF3qdi8JUA4b0WCm47pxntVJjcLJfUt7g1QBepUg/TKy1g8RmJggnUZhg3YQHiFJ+fYyVGO+6cII3PWsgvYFW4wAtCwgaor3ixN2uKgM9436LK4Hp+WkXcmUGZ26E7POD9eA5uuuEJL/mUu03GsQg3ZWfmlE/DWBrAT2h/NXQu5vta1cLBKBV8UYAs2E0VX0NamRegq12gbAV3bclHG4eLi1xwTDVx6jDQIx2OIJa3WrrWcASZHQn9HejEafZJxlT05DkjUQXqDN6jTPr/dvOyINFcoAZ/4fTAj4EU3IYbdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ec5d87-bdfd-4c05-35a3-08df0a5250a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:01:16.6046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xePPI+KfXXEjM3rsckD3H4OTlnzh35/ya3ht42walzDEBF0i1cc9ZWBgYNKlteBZ5ON/J1CrHkx+CvArfxzfbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Czapnik, Lukasz <lukasz.czapnik@intel.com>; Loktionov, Aleks=
andr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 12/12] ice: use ACL for ntu=
ple rules that conflict with FDir
>
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>
> Flow Director can keep only one input set per flow type. After ACL suppor=
t was added for ethtool ntuple rules, the driver still only selected ACL fo=
r rules with partial masks.
>
> That leaves a gap for rules with full masks that still require a differen=
t input set than the one already programmed for Flow Director. Such rules g=
o through the FDir path, build a different extraction sequence and then fai=
l because the existing FDir > profile cannot be reused.
>
> Detect this case before programming the rule. Build the candidate IP flow=
 segment, compare it with the active non-tunneled FDir profile and, when th=
e input sets differ, offload the rule through ACL if ACL is available.
>
> Refactor the IP flow segment setup into a helper so the same logic can be=
 used both by the extraction-sequence configuration path and by the conflic=
t check.
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * ice_fdir_has_input_set_conflict(): add a check if aRFS is using perfect
>  filters that may cause a conflict
> * ice_add_ntuple_ethtool(): add a guard that rejects flex-byte (user-def)
>  filters when they would be routed to ACL (since ACL ignores the flex
>  constraint, it would silently offload a broader rule)
> * ice_add_ntuple_ethtool(): join subsequent conditions that call
>  ice_acl_add_rule_ethtool() for clarity
> v3:
> * Include flex fields in test_seg to avoid false conflict detection
> * Skip conflict check early for ETHER_FLOW
> v2:
> * Add this patch
> ---
> .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 189 +++++++++++++-----
> 1 file changed, 140 insertions(+), 49 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
