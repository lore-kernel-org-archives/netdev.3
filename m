Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE23264CC
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505280; cv=fail; b=K4cJoYqIZ+uPnT/i1YL26kQ7HPEZtdHaWj2+WNLR/PwamCKbyCLgq+HYWkKKZXFD9etMSDrd2vAUHavHgJmJOapis7tMBeyV6JK4ukhebrURLaZHN0V3YlWLp03mubQXHs/YUswEhxr96OyY9jqOTWelCKqBNw4D91EP5Oc1qCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505280; c=relaxed/simple;
	bh=ErDeSoLHuu/iQpbGXrR6jQUuwi5P2xZDs3SaCyfPzRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqoOFpEW9ZNTgKaOL/Te/+l7Krb8XbM6vmjTpnq0jGRtEG+67vq5wFFlfepjWUXJqZqLKMjdZcqTkYCdBYo9042rdGjTztC4l69uM75mIt4PdjNQ1O+xRCjpTIYDUi7Fp5rU+YP2RoUxtBQua7V2HJ4TzVJf85tX+wLYjGbjpy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgebDEyG; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgebDEyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505279; x=1820041279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ErDeSoLHuu/iQpbGXrR6jQUuwi5P2xZDs3SaCyfPzRw=;
  b=VgebDEyGM+BkvFQONQohHOOuiAxDKcQE4Cv3obeF/mPExPSPmopqcfVm
   KSpTSSZqTu0foF1+smQlTrMtzKUFDbX6E/rooTLQjeTioxMYbfr/GdLlD
   qZcITAxQHXlmuHvJzhG6tAyNXZu15x41Zm6MdBx8MUyp6GGEsQMjobYd5
   0kkuTZbjDO1Xd03a5WI+6kRauoqvactyf+LR1Hwbi0fC1SMhVrZqF9p9g
   1s0Cj36QN/gxwdJ6qsHPdpTmLUmcnSZNieYn35VW0GpL6ysLL9qjRbse2
   pWMzrybKuQhn2LQOjGSXQFGJobBauy+NRwZJl1+jOtosjbO1Pi4wZfHg+
   Q==;
X-CSE-ConnectionGUID: ptXrLaDERh2QjqfqHVAEjA==
X-CSE-MsgGUID: ugx8ZiV2QGuB8se0wX4D/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="114545774"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="114545774"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:18 -0700
X-CSE-ConnectionGUID: e6LpP2nFRMiEeOg43drLsA==
X-CSE-MsgGUID: KHrhr+syRrO5wronXscWog==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:01:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:01:16 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s21sFlhn036GKkS1cQTa2IFpM4H3T/yWA20K1BOgNw+R95gHGLvNS4Q6uH6PY7VdGeCZiEJ60CyMzRDuu6x94F1tQIVES7L1XEQyQKG2FWwRFZXsvbs98C0WQ3zj6V8Pvb3+HBctSjyWjndHCQ37UkC2x++5IeV1YCQvHuC02Ip4pXGlqi5eoLpWiGe5YlsprEKHP+qOV+w6JuaF1nfBGERPgYRANRUBrnf0eN5r3TJfnJD8U1ttcZAu09cDWbL3ei/sY5m/3MaKAFmFHDQLt+bkE8z40/0pe2b2jVTPKt/OurxgMWkyZYCPmQmlANxclj3ScbwZ7y08c4Ah4b4C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SvjUdMwGIFX0GxOAM/aKV9lBePzoojd067vPyunsgk=;
 b=cNL4gfkjmjiviHRRwWRfUHjjgOxAI9/el4l40TQZtnHtlxRqqfq+4uukuEpj24KjxNesH6rCNwdE2ZeINzt+bl7nG97C8iSF2c+9HTCGTMtFruGWKnsJbjgnMY6MHpLC18di2ts/czvS0bSHxGN5DmNB3CjNIP9P9tPFmN4u0yTBsn987FcmhCxAh/myWlwmljyjR21Ca5W9KoFZhWECnayae/17R/4eYbZEPXS2ShSZIlqZOXLJptXFp7/L5yP69fl2h6L3iBs3FxNDWfg9q69VwFOmXL+fR3DvDJ1WyL/CO3JLsojbB7e/GkdqyMjv2JrepfC8Ivz4OpfiCTs1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:01:08 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:01:08 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 11/12] ice: re-introduce
 ice_dealloc_flow_entry() helper
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 11/12] ice: re-introduce
 ice_dealloc_flow_entry() helper
Thread-Index: AQHdChZQN0LsgTyhWEKYz/rwjtsOyra+WIeA
Date: Fri, 4 Sep 2026 07:01:08 +0000
Message-ID: <IA1PR11MB6241AACAF5869C6353EA29C78BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-12-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-12-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA0PR11MB7355:EE_
x-ms-office365-filtering-correlation-id: 993eba64-cf6e-47b7-43a1-08df0a524b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: FhZzvS9+M3kiXq3aFOsRrauC4J39rjCvyVOVRSBtW766SLnUPcxUFe176ZtuQLkFY/yEv/bzr0qzEsW2RA774fcgcynZu7v2piylYnpqXtlazrieJqrvYlv8uJZtRZJF0xEmuGQDs+gNxQI71TmIFmFHRofWQUggqGfbM0I47yv7h9xQOloyuATqsCTjPMtjwAQfUMcEcG4yUR/XeAtvAf6Gt7bEFYUAZus/Fik1iLueV8s3VmYBI/VmS4CFzZscw7SCrY8/AEZT/q21H0zBUr5FuzkFRQONfdnWcY2Hv5B1CQ7Ehv3rNB+PWrdiBVIgl6/xqFOmjLonBaPupaZBEPnpVKiGs7fpVWuBnjzVR/8jdwre+ocL0QWFnTHezsxtN6cUH6WlbaCMYBOkUYKRYFUKKG7pDLusaHLO8S+ExKQtrFZAlVlW8UC9BffDorEAbanvF7sPWnx9cnOF7kGD0Gs3I06P9NCHBhKEcN22z+7OvK37JxaUr/46QLYniQg7X7ZNNXctO383Pxqv41CUvwyaby30kSCZsul1/t9IL+jAzT+rxb8C2xH8aQOi4xL4icvRSVhOZJG80KA+B3jub00PAmLpc9koPYAfWT0Z8ZEQPsgOywq/Q6OiElFeet1A+ze+Tk4eMi+rY92CbA3A7IxjwSDKNS+p9BCiV3T/POt4xkZTpkbZm+uyIyOfDHgBu0mwtVYItBDe5ESJmywU6azbE7B+WrtSCR3zNou1M3g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8YE4YU6GJDjPEEsE+oQkA04QplNzZOkl0roqfwlVi6mwGCIC+8y11LfzX8j?=
 =?us-ascii?Q?EjdgQtmSRY0SwU4zTJuyRDfraMC2HgIGJ6nzXqnW1PvvGBbCQ/LXq4C5w0lU?=
 =?us-ascii?Q?rqb5Ekl5S0j0zrDCvnn3STEf/AxdUa4JP8sqJhym8il6p+e0gD9wtJbPz+t/?=
 =?us-ascii?Q?UOHbh9L/m43tij+XM/rx3cTXGU7/l+BxzPB1KrqB9Y+9xO9qv1ZbT24kWGpW?=
 =?us-ascii?Q?Y1s9oXgfxEhbvd7RaldgkQA7hYxjY4+EuVATs0rdDrY77EW2pCPp4YHvxpJ8?=
 =?us-ascii?Q?kDFtmALDKkXXQT0FJ4xiNj9DG+1ZHgF0qWb3LkzQoGjXSb5VxfGPVYgDAGiG?=
 =?us-ascii?Q?MG8eTWbZSewlr6gMTz01LUUK3y5oAoCiQZHbt6NrpLP+VwaKYXRJ94w+EiE3?=
 =?us-ascii?Q?8qRFtqcU2JmP34bv0swRYjq/YDFIVn/blRs8G9DrXY3UJpGI2FJiHM9Aj3jy?=
 =?us-ascii?Q?JrXzXobaQ9A+gP12Amq9ZyZ5SAB0xUsyYZb1vMnZ4MdQoleSm0ETczm7YiI7?=
 =?us-ascii?Q?X4keDVsrc1nh8Ro6wr6XVRI7QsgYVQ0OedwEmkWl5s1MZuGQHYU2tlPkS6ZO?=
 =?us-ascii?Q?myzr4xUgNkDSZqVfBPaK4u+pRat4PIA0Bo2mh0vkJkRK7KdM+cRldgxMEtkk?=
 =?us-ascii?Q?ccxnn1rZtOZGjC0w6XhO4SNQjAN2ADwRbWp6RGpKErosr2x4RAL/XDlzyKXb?=
 =?us-ascii?Q?9DReOiy0/QnJuIZUEPBQz3cZGcCC049gT7SdNf2jp71NnqdGROBwpzMtHz/T?=
 =?us-ascii?Q?6lv+WPIYR88jqhIP/PQTz3n3Sq/Pz2lfHmdbiqJ5nqaGazidsoRh6Mh415qZ?=
 =?us-ascii?Q?64nw8BwjM6XJieeFABL2ZbNGjKSS4M+SGQSNfJgOusOnerA6aSlu4ur9kFGe?=
 =?us-ascii?Q?+eLrrnwoeKvzS47ZGa+WOQ+H5WWr/8eCLLzNBD7R5nFdi5fm7HOTCETb6exJ?=
 =?us-ascii?Q?9L5SyP0CwOWtUQfx6KRatSORxlOaWDNNjlw4Y++SYsiUi+sBuK1JTXGciQRz?=
 =?us-ascii?Q?+niExUGhLAJJ6h9Xyv48gQDZRb96RuVWFeyCROaR/zFHSOo8KM7u19wSzGLd?=
 =?us-ascii?Q?eO2JT0X65uAGH+AIep8obujM1B1hlYpJ6b58MMEqIjHNMr57E5L9J6STAfsY?=
 =?us-ascii?Q?TsK0Rw1Dc9+XDSo6zk/Gtgyxm69fjh4zFIP/2MdzPp9rWzFBEiezKk37uPR6?=
 =?us-ascii?Q?fdNPlsoEYEgBsC84p96oyW6u7ladE2SFYLfMZgpDMAcEhWKYkiPIO99JHapW?=
 =?us-ascii?Q?HNwk/eEXk32LHI7lJelNxEP3jK/4TaGzKhnCBD2JzPuP0GIT+zFqX95m6m0o?=
 =?us-ascii?Q?rMM6mFEFeviSbK5Ir6LqxYZaP4qqkbx0MADmrgwGpmcvv54I2Esz/i7R0gnu?=
 =?us-ascii?Q?HAK7AFUGDnHLLrrY0cHyKexUWwlBwFhKJ4b/NXxkYGcEVBfn4rvsgQ+L6ol2?=
 =?us-ascii?Q?t0i0AxwInQz/HGs1h2WUVYbV8tnIxrS5SnI+BDhl5EIhhxQVWpwmWntSBneM?=
 =?us-ascii?Q?yoo0dRItMKkpFGMAPytxR7uwPKAQiFcIXiEZ+ZgmTFs8OMFF9X8wksuBGLyp?=
 =?us-ascii?Q?me155J60sfOT0IsjDOXHJVNx+yMtvYIxlKD9EbCN9yWfk707yR1aDhRQck+H?=
 =?us-ascii?Q?7P2eqXKB/6WhMS5UgLDLq+pZGKgllbTt4MVt5pzCFXZmFaBUxXLK2Nx/Dmsz?=
 =?us-ascii?Q?i/mm5DtFqJK/mGEm76D8Ob0EHgo8lS0xwpGZukUdQw2Qp6qf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OUQtbBmU4ij5FpGL+DCYHzFoL0NouSIRvnsGXrOuYLUo8xuaIlw2HEH2yQ+fRfyIG3UG6EJLdDe3/a1Papb8dICkwsDb/VqFPrOr/z5va7s1Ce3k1KmLw6SJG+PGCzfK2wLO87d3LBXfF+9wHQBfcIRvJpOiNA6Nk//EQT1XSzYYRvQpJVuJTP1v2SSlmbpQodE18YeAcvW3i8B5mf251oZ82DDdy7xnVjcYsyV80mj3WkHj8nzeVe2LOiEUprGNy2Db4lae+WJqPd/fcZ/tUpOJ8HNCAUklF5AxjJGm+hzUgFk65nl87NOsv9GpCCMljeWRULFHtsT6s66g9jlPXA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993eba64-cf6e-47b7-43a1-08df0a524b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:01:08.0238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ji18PCJnAuzBCxr9rLicJL5gIXGlT3UNqRb8nliNOPyPjLl0i79AresmZgZdE74DzSIB8WuLVAlXCUJ6/QbVew==
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
ux.intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Kitsze=
l, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 11/12] ice: re-introduce ic=
e_dealloc_flow_entry() helper
>
> It was removed in commit ad667d626825 ("ice: remove null checks before
> devm_kfree() calls"). Now it's useful again.
>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v5:
> * ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry():
>  ice_flow_acl_free_act_cntr() additions make more sense in patch adding
>  this code, move them to that patch. Now this patch is a pure refactor.
> v3:
> * ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry(): call
>  ice_flow_acl_free_act_cntr() in unroll
> v2:
> * Add this patch
> ---
> drivers/net/ethernet/intel/ice/ice_flow.c | 35 +++++++++++++----------
> 1 file changed, 20 insertions(+), 15 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
