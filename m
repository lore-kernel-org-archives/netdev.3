Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085537C106
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505218; cv=fail; b=c3SnVNBTg7nW1H1MbRsj8MTmmcOhp2vSc3BZiJfAQtFTnZfK0Hh6HcgXXkFvIuUG2F6uqdB8kb6LtEGkh0HEwxyB1bliymOTvC03PyTItixKroHNLSbI3ZSlcSziJFrzRI8dISEDeavvgzA+kT0fklJPjPXypjmawxaLti4bIbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505218; c=relaxed/simple;
	bh=+sJH6FotxTI4MzqijtEcQJ8HoHqfkAWbXtwiPmtXigc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tlfHBxc3Uf9pwk24gDwtSPnt60mqfYLyzE4N3PXKN965DzT6hzIL84+z9HrUlqQGzvTfgJ09qZtqLpf09/uugQYdRpY1WgAjT8wYArlLYxvXRHbQ4jGl4G1+2ND1Jcj84jkjnNWsXZy3AJl7bwC5fer6OV3OK91VnPh2ATVmJ1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcBWTt/A; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcBWTt/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505207; x=1820041207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+sJH6FotxTI4MzqijtEcQJ8HoHqfkAWbXtwiPmtXigc=;
  b=kcBWTt/A0yfEYEgYvE2Oa7e5NA4fL4f/lDYMVNbV0otUAAf3kehMHgCV
   TGrXbXdSIzFaSALepJqukxM/iS60o4aYRqlXrwRzdXsoaOKMRKi2Sk1pL
   ncafJRvTIOuXSki+Jny0cHl+RQe7jJoNHiRooCEYiCaCXsPs87VMqPOJd
   eoWUDnsFAcFpXzP0mSJpBMYumbFCV2Zaw6sirc8K463NkRQf9OLkTlCHu
   GzwcxD7lWlpsXFcIqc+GmkMrUDeIyPPlt1zWqaCWH7nu+3h6rPawaJuvs
   hWCeR9v7eTVk8GDaj6n+s8azWWuSKJo+yTwmLGJg0ndPc3ZjPb2R92Ccl
   A==;
X-CSE-ConnectionGUID: 7agNdY0HT9CJrDdAFcupTA==
X-CSE-MsgGUID: NJ1Ie3/UQimWtD9x1Iu9iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="76556234"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="76556234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:06 -0700
X-CSE-ConnectionGUID: 4LZRKpAgSlKLt6Y28FEj5w==
X-CSE-MsgGUID: AxMcu+HBTOCHHdMCZb3ZGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="265614179"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYtsiNmVVhJkFpJcv27I8vDdOU4An00Yl5W40zWEMpcXEFlaxFvQ4wfM4Nro570bitZXjBgAHvyo1LYiGcEgpT7WcteO4BT+iimf33Iva95xqai9MKHnTnRte4UWs8cRxINuby3l49gAmbXGAm8J48GzPWsRJnwjvlDOSh6OnsRgf+cPeWIxm0XbY9kdORTqPM1hCl38wtX5bGZq/e3MQR7D4aS5M/ZXQpTT2KzRLOi8XEjVhQeexkeqeKdSeoC3//hPH3znZJ/75GM5iRC1/3iyRDgHGJUNdeYKGLjqrUrnuIeg0kXsSVeZd4knELfTKTNOusTiHB53OjOLbbo8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBS+jgPt3oLPamYVbtCKsIO9ZXWBCxETD8VNmaRFah4=;
 b=jpCIH6jlJpNUlQey1FCCkUXcVfauEmp3yGkC410iWN4uROIKv+nIV6wxZ/OcLO5BoxQEc/k+SlLdTa7FQ/X9EjRKRj1CfSQnldnJfNwXkEqm9exloOiBFnItcS155Y3pOURvJkx0NOWump7hJbnMKy2ptSxrZGEcfqCKDyRYiMTi22nM11bF7hMxn5SE6FcqsiwNLrtNWMV4ZuUkidmdo3zbF49jKGhkxMTml7cLoP0JaWO0nliapGQPlm2IgKWCoZ3jXTiFjt4kO8eQI4S1a43fDljvyD8BQUIpbZCFUm6T9SeFj7VixbfuU4JS0F9E7+txVWwgaVtLscUCTLmSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:02 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:02 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 01/12] ice: rename shared
 Flow Director functions and structs
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 01/12] ice: rename shared
 Flow Director functions and structs
Thread-Index: AQHdChZKg6Rwj4116kOFBvTjLeDHQ7a+MlpA
Date: Fri, 4 Sep 2026 07:00:02 +0000
Message-ID: <IA1PR11MB62412F58038EA6943477AF9F8BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-2-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-2-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: 16c0b277-a028-4091-af68-08df0a522483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|56012099006|38070700021|4143699003|11063799006|6133799003|10067099003;
x-microsoft-antispam-message-info: wuaDeGXFBfmWLLD1kb6Rf3FrXt/8EF69RsYjn1Im9MxcRE6wZTnEmZ5WkraRbhj17fwfs8c6CPW/2SeYKoTHB2VyER4DN55czWs/Y3oQXL3yHAxAML+cUEXPvehax47SrGzUcvRyVNwcAKy5uvgvSwM+Kelv22kXXT4v806/RvaOpnU1S7rEnTP8nMYiWhevkO9NudZhAC9dS6JlbTVZJE6LqjrV6UJRVHOOOsjYKzFAiqMLsiCGW0YC19yY7YNmxEH6Ud2S4g+qvBH6QDru8JDNCC6yBa6I2X6yuXlcpf7HNsbENfOtbogyGawDe2IDTTJ21YTE0K42d/F7s8XAlYA3DxgfwkvgS2KtscRkKY4sZxykp6FZeEZYvgYEki9+MloAz+eTe3CnEEFDy9+cwbjInKrxL9Y2ucD6Tn21ZFN/Z440Mp4SUpQf83zMYpRNDg7lQkqFQ+kAuKn9kMsv1GH01hDwpg+IfCIvHgFB4BWNX8kvN0O2IbgOU2L2DwVcOlsvb/bjc3zpTvECrCYdtT96ZGmsc1bS7V5yuxO/rsWIZb+5XAC9h+mYG0S4womG7pMQn6PsWRIFbT2e/mbiWKc0wDrUPMLqPIJaWiOLqFxE+Bp5lwhX6e5ewiHruTZqHPaGCQBDchelrJCFaBuTg8GMqUChcbKXtSknxuYNIUuzvj5R8nJO0hV7YbfoAdvquHoLFBmfiQDnPXNRoppg9y52XXI7nKe+LZZ6vU8EAMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(4143699003)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1T/d0jxq1eiJqqOBt68SLOMtN6grvJDZmLWKZ3MujLgXBIU4OmZyxWtNlTpm?=
 =?us-ascii?Q?DjAlPaN7yN2JPELXih4vgiBIX8Ju+vK/uie326TjsIjVi1l5QcSTkmvBDFxB?=
 =?us-ascii?Q?2p+f50N6O6hyPEksqdw4KD847nygiFFFwa7bLzrbAI++5bzoTodRLCZTYahk?=
 =?us-ascii?Q?yEPAQpZdoqliXWhJh9mZf5v9FZ8mfF8PFYasOl8ahvu7HoVj5Q69z4/ZtCuU?=
 =?us-ascii?Q?fnAFF0tIZ6TLpJ0GdyIQ8bZS1HtNQlZQPpZFOYBsJVUp0EwnLOf9/J6T8itk?=
 =?us-ascii?Q?a0ylo21yBwtPqxa932c9uItxZQKNq4Zb8gv/zm/C8blSHfFjYLNIR5rEUKxO?=
 =?us-ascii?Q?YeQ3Q6FYsuF5QlSGHtE1LDwARLjGJojTLlJHQ+e9W0N4VSM1hGkvqDVCav08?=
 =?us-ascii?Q?odI+ja5uB+ADkeX7mYmfjpKSIIuPdR9ha/cudpnzIKnlFfLeM4Tg6MLJRobF?=
 =?us-ascii?Q?SPOI3S1Ygw19/XUyqQj4XN/bcrMXHPCVeg+gqT1Sl/u5J+aj/NVnqrxyQCXF?=
 =?us-ascii?Q?9uMkXJ/OBrVe6W6URkolRo6NOEinvI+IcLDqQidRk/4ijZAYxQUZ6WxZ7yzz?=
 =?us-ascii?Q?wZMCsX9q+D53u6U0QjSzhYsu4SpUGZKzYGHngNKriz+SiDaL1aCKI2N/UzcO?=
 =?us-ascii?Q?PPu+Hd4lpQpJh5PHgUJhIszrcfeULqhdr5uslnaNbGq9ssBd8w0jRCBeEpAN?=
 =?us-ascii?Q?cOoeBmbcb5tVKoYt5w66CbI7bCZdXG7Bgwt/pK9lcaZn9FFHNM3NnuJBr1n1?=
 =?us-ascii?Q?3aNeuxisKmdf8Nu2soN9Ttb3itJxD4LHWRaLNoGJkdFf8ZlQxy+LF4m1telJ?=
 =?us-ascii?Q?64lxeX7oI++8ErgBvpL3tg66PenuZCElM32EpcnR5xeUT6cEtxd8PfOGLMoW?=
 =?us-ascii?Q?SJ2gza+zv22ClsI5eaBuWBGijSkfQoqQxwlW1gK5hYe7A/dt1NbzMAH82hHW?=
 =?us-ascii?Q?/AQyWz6+2dkqFnf6eygOi5wso5UZWHkfdXdn8MTass/gcCJRbISlN6VQlpdh?=
 =?us-ascii?Q?VfBJwAIT5FJPEzb8WUZEm4nsC5xd4GP5wT6GcuikuIQeYkn3tx4kSCAJBEPT?=
 =?us-ascii?Q?rduUfe6i3pUBQ2ZsfRFllWxQoAsF2qULU1P9R8bLjshf0UjLC1/fBglOY7A0?=
 =?us-ascii?Q?v33Ecd1WDQXwL08S6L7Fn/XKFJqlbZHj4NDoAJtdI6Cey07h9wPAmfI2BR/f?=
 =?us-ascii?Q?x9mjVgVhUNWIaN/5OVxUVajcEjUzhDYFnkS7v6LDDE2+xGACr7tVdPg/fGBZ?=
 =?us-ascii?Q?N92MnT9oLlDkJdI5+SzsCcNAVlCHAfTZrdKb+au9HkX1lAEImIFeeXJteoIC?=
 =?us-ascii?Q?IjF4sjMRGGVfr0ICLsC3p5xH6BqSka06Tp6SrfkFehRpD3pKievcGs/sXqrD?=
 =?us-ascii?Q?GSEK65WDHImtcNz2WYpW1thxwFhVn6bCmLgFnSXA76eigIOqM595ad5gyxbK?=
 =?us-ascii?Q?Ee4owyfELHuHOTl/SzimvEW5U2Yzd76BmB0K7xNW+vgVASnS0RNHwlaKzbmc?=
 =?us-ascii?Q?GEzmKtwvOfTzFag0U/eZGLnMpazj33DwFsn45BRKIGZetxQLQx7rcuFvaVqC?=
 =?us-ascii?Q?lSlgC33POCBrKarudhgZLk29xni0XMRQbX5i0RLlplt8jNaMOsROfRky/ngg?=
 =?us-ascii?Q?sJ6uTzafOAbeb6CjIEoRjqjSKbbDKc5vhbR7TKfWx+uWcuNAVlrowMR1RVDJ?=
 =?us-ascii?Q?D41VbmlC2EoIp/FmWIjaivequ0tNfrUCnvdkPRYA9fOuRBws?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h5n7sl2X2Wub9bQLQXTFh4NCX+W6XVKy/YJ6Uom1hBflAl/3VUwnlmyIkDzNwauOVpDL2k8gt4HvwMclXSLqppj+aRmp8WVPicSjqlCdJl2Otj2U3X4N6OdXR+cyfZgGCPKFL79yOewj5pGkyKHCKlLbUneOriVrqTrI7SOLZY+mumTDzyMcjQa6wHUfGfySe31XRWHf2QTKcCxmk4To746utPCZ3bLrs+stSF0O4ZQeVQmjBaRB52VD+XCseY+eWkquT6Scz3wA8z2M34g6mJQeb+46Y1N2/m11ji9VTGyUs4l1bxBRxOfx7mjhVNn6xm13C25Ub5KZS1MTg1RWzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c0b277-a028-4091-af68-08df0a522483
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:02.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoI0e/ZtxEs4sGsMcTsVyYQaNmG2MGi9SiXewH97qqFf/IvLaoiBLsuUBDAF/It2zmIkOavDmCXIyFjoxrhDZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 01/12] ice: rename shared F=
low Director functions and structs
>
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
>
> Rename shared Flow Director functions and structs. These entities are cur=
rently used to add Flow Director filters, however, they will be expanded to=
 also add ACL filters. Rename the functions and struct, replacing 'fdir' to=
 'ntuple', to reflect that they are being used for ntuple filters and are n=
ot solely used for Flow Director.
>
> Rename the file to also reflect this change.
>
> Co-developed-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * Also rename fdir_active_fltr to ntuple_active_fltr_cnt, as it will
>   track the sum of fdir and ACL filters in future patches
> * Also rename ice_fdir_update_cntrs() to ice_ntuple_update_cntrs(),
>   move it to ice_ethtool_ntuple.c, and make it static. In future patches
>   it will handle both fdir and ACL
> * ice_ntuple_update_cntrs(): join variable initialization and declaration
> v2:
> * Also rename struct ice_fdir_fltr and file
> ---
> drivers/net/ethernet/intel/ice/Makefile       |  2 +-
> drivers/net/ethernet/intel/ice/ice.h          |  6 +-
> drivers/net/ethernet/intel/ice/ice_arfs.h     |  2 +-
> drivers/net/ethernet/intel/ice/ice_fdir.h     | 14 ++-
> drivers/net/ethernet/intel/ice/ice_type.h     |  4 +-
> drivers/net/ethernet/intel/ice/ice_arfs.c     |  8 +-
> drivers/net/ethernet/intel/ice/ice_ethtool.c  |  9 +-  ...ce_ethtool_fdir=
.c =3D> ice_ethtool_ntuple.c} | 85 ++++++++++++-------
> drivers/net/ethernet/intel/ice/ice_fdir.c     | 38 ++-------
> drivers/net/ethernet/intel/ice/virt/fdir.c    | 28 +++---
> 10 files changed, 98 insertions(+), 98 deletions(-)  rename drivers/net/e=
thernet/intel/ice/{ice_ethtool_fdir.c =3D> ice_ethtool_ntuple.c} (95%)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
