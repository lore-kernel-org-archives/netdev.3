Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC944DBD8A;
	Thu,  3 Sep 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449302; cv=fail; b=O6YZyfY5E6/CfICFMEHeoeDe7rf7hvIOyp7HMA99HMGVO+N2QHkZ0ODWl32+GH2ZRwKlu+3Mf1JZHDJjyDwaBjSe152hxMXAO6+no7PsYx7KB2gGru9OSRTNEgtkXylnNISrRckTAbGk2/+2LHP3XUVDm8i/rXlGbwwXFikvTHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449302; c=relaxed/simple;
	bh=xWvfD97h5SyaxAoORhJ6/XaXCqLI1oIKuG9sUVe49/k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLcM4PyES6pXZRLP2Etmd5TnQlnCuCfvufqR9p4dPy+v3RFidgJPzDE+5/mpy7byyIbfuaiJ/idQn4Ze4WHFMHkIzKiOhYv3Az9Olzs3YOCj64kfh3grcKq4UZgrh5tE+L9pAikBOLqMgccQXfyRg7knjPTyQtmjk3eduSaty+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2/ZG8R8; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2/ZG8R8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788449301; x=1819985301;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=xWvfD97h5SyaxAoORhJ6/XaXCqLI1oIKuG9sUVe49/k=;
  b=c2/ZG8R8EodyJUQYmAKLlIas1+LOOEXz81xvjXtmwekun3NwdAh82oSQ
   h5wcCNmhQj3xSe1ZDzsKY0ISuHdWViW0Lqgfjemd/ImlBzG7WG2IXqbp0
   tAAG94Kgc/SNA8bxNSQYeEwo4rMVJg5BMkfmHuVhQjBy80YWBPOPKd8BN
   P0wLhP/o/AZHUDXol59bvhgLWu6Ksd2PdFPj3Gv2n0RbmMWU5awWskCVC
   as8rbvlppRcIlCHPP7W3wXvR+dLJB5nM10PJdtd8wQDkcgDHad1a4jRzv
   ZyBItC6oykJPz6QGOHmilbCOYPYDY8NhIF82voGXJYwOeD6stQ1YbKa5i
   Q==;
X-CSE-ConnectionGUID: /ll8Q2IjTyq6L9ZIimlHUw==
X-CSE-MsgGUID: 7t2FM4kAStqnjPMFUR33AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92635839"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92635839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:28:20 -0700
X-CSE-ConnectionGUID: Y22pLM8JT4y2cCTSw1C1oA==
X-CSE-MsgGUID: gHJiz+IFRX+z5EmTSZ67Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294631040"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:28:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:28:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 08:28:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZdV99IMMUr2GS8adqx9LvK4EZViPX6u4L1izUVpExNwKERXhnJ19PADp7vwFw/jG5qT5iRr5bQ10PbkVovGPfQKqyNoxdwiaVGuiNhcBaYh0I0F3QyX7iu9GWI+6EzwS6jGsANwRmqHy9RuGD9fiIy0S78OBi582c/3fdhbERXg80uoz1sgFQo2osM8n2lrCX9Yhut/g9rS5OKnst9/pczyeLwyxlG4w/E4jQ86NTPLSgD4w21LBbNhStSVHo5hz6diD9CKarsLsDQON4lqnkhyBeADLR/y5UcrOjLOYil6KIARbSp9/Zk3TvCfjDhztWxv0XCj3hUjwG/4J4EMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIpz2gpxyYRyhDCjHw79MocbaiaUOlfelJkDe96yjX4=;
 b=NsKMgvre4qGOu02Kk8NjUiO1KcWrX+9G2nwwrprmeYV67XYn8wkvqAxbmxEuhO55wOpLlBlp4aoXEzPXmU5pdDHBsNBbcgAAeDAqFXapQDyud96ysF4LxqdxcGhq2woNeWJCdyRkrxTxXvg0gK93DUeud6KdC9h3Dw4A5OvGo4AhqEUo6uurrtmkjy3Fr49EHV7/6b90p4+6MLc4Uv12CQLk8EfI3aSCfdK3rqCqh0kkB+ukBy4H05YtUd9AkbE4/vQobfHgnFT///ueZxOSP/fThyRBnwc59ff8P5IS3QGWVvvmub4yHSs2DEEJllOWKG1MHTHDh7dfKztvt/RbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:28:14 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:28:14 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Thread-Topic: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
Thread-Index: AQHdO6cpnA8pZfPSeE2ORxjJO4E6bLa8+glw
Date: Thu, 3 Sep 2026 15:28:14 +0000
Message-ID: <MW4PR11MB68648B020222346C9EE5BBA480B62@MW4PR11MB6864.namprd11.prod.outlook.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-2-ynorov@nvidia.com>
In-Reply-To: <20260903132037.81346-2-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: 8111a79e-084a-4a2c-0c6b-08df09cff88f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: CTiRyzowf7Qm/80WHdVNIW1CcBsOE+XD8Jz/hJPeQXI5+qh1D4KGEfTWc5SKqmPo3iFgqDzjraLZy9OgCwz/ecTWolVfOBkj/i+0al9vx/C60ZL7XFasO/TQ9r06V1OxHvu5r1lWDB9LlWtP164N9BefZ8ueggsXvyBV7oQr8tBt6RQWAUswoghddu1obnessBePRnz94v6YKKxCvsf0ZmYOKiP6Jb/ut+qc+QdNSFkzT2F7TcWeC3rVGpiq/WD0y1I+vvOaCxlbPuSt95DOUfHQ4pcqezPjuP8vSf9It+mnw+UcrfAX/GUE9GMV+B+OMPRssawmgPSKRZekTFy0KIhZdy4ZKKg+Nkz8P5bBaTFZlZ3k7U9VsGxfM0+vkWifPXjh/+VAOi3ol4zan4kx+aO0lq2xpPUkNKRk1Vmoz9JU/iHPcjPeRyI6JM7gDYpJB3i+VhFe3glDOSBFLZdD7gDLvPSPqmj2vEA0OyGkKXP7/++GTR1CYj5ayfQey+JTSPjE6Kq+Zdy5dEGaJSyMdNngVOoLwYhkLOthZWO9gUdb2US1vcd04g9VtWGvYqKX1f4sFRAQgBjD3crTRvSDs6xwwtZEyfL94cCU0D53q5jEm00Jf+/W6c4wLNDy0dBd+fIJlPlEjbtTkUE1EW21n915zyCPlQbBiWRmbzEJuybZsOElfVgSviJb5GRBVXNfWyl2+ZgDvRP3ogqt15MXgpfmxUd+6xzedDcfaWplmQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6864.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q95Fpu3Or9YOv7K2Zz9djw6lPjyBd0OnZPYKPRxWcHvFN7L6GPHE17+5Xzdy?=
 =?us-ascii?Q?eBmiEqq7KO0JObmoWAdnJlAWnnAzwepTu1jeRuPFiccdS3Eo6zu5Keeir5CA?=
 =?us-ascii?Q?/6zeqzzrlvTA3sw2+qR0jHHZgYSrx3pTcCpe+NkapVw1QKE0OH+vLG8xEd+D?=
 =?us-ascii?Q?jI1lCNzCbslJ8kucPTRHFhKLXNxZEjnVZwqVjIIWm9slPwXBC/14LfuJz/Y7?=
 =?us-ascii?Q?YGV6GMPhffO/laL1qXDR++Rx2bCtEEdD78aMzZetXNlIKb0n3xZxIjUpqbb6?=
 =?us-ascii?Q?3efnPcmKXtIMp4hrZ04NMtUgCkisPwdCVuvQT3+1JOKGICUbj0SjvebVGPFM?=
 =?us-ascii?Q?G4s73Tbicyg0vcHwG9ELaY1KI4ZMGz2vZWqfqqf6dgeV2hlBHx+s6rHunKqX?=
 =?us-ascii?Q?Xtyl5d6jZOKphRLC4LOiTIa7mgk4u/CQptKo7pPJgmdHikUs9ZxS85ZCexxF?=
 =?us-ascii?Q?juPIrsVTg91SYYsWFy1Kz9fROFhqq6FvjdnIwdH/kKUscoEKv3/PUib6zxc/?=
 =?us-ascii?Q?4gS1Xg6vljGQfLDZvT3+Q/5H2ekxT7kQ6GkiyzzDnLB3vYRs9EBc5OM1Rb0v?=
 =?us-ascii?Q?8PnuuFdcZNvhEyZL2zzm7kQhUM6xqIHCrAVdgvqxJGNoyLKwBHxNKANLwdtb?=
 =?us-ascii?Q?tN+hqwkdUMcd7bMHoM/oRD9ULxe6/kWnkqhYkUU5/1i9llH82tmTsnPfFTUY?=
 =?us-ascii?Q?gbgAePGmHSd9KtFVeYxd0dWPoCBieDCdjmvHyI9CsLboOs4M96lEtW6J9Nof?=
 =?us-ascii?Q?APeKqM0Lo9YAfxtNmUBvPvOrOV8jeutEZk3YP174pHLRu18yB6cGN4mowRCz?=
 =?us-ascii?Q?CWF9gxuR5grNCBSFnuLlTCfBUZf5HdEv4WpmivsdKiZlMckMdySqAvnLvOvc?=
 =?us-ascii?Q?POXq/ygWtxbT+YhRYhGipGS6tYKE30/U1KmVfh5lkPntcuxdL26HuV38d2Nx?=
 =?us-ascii?Q?wGPtJf+Rs8Ro4ixl3ysjf0pfQGQGLQydjB5N7BOfhRyEPqkwTiNg5E58KZuD?=
 =?us-ascii?Q?YWcgIcx/cU4MdMMy2HigIIXV6t53ZwKeLo5oPsu17/DXC4hcOJkVYuA2dAbd?=
 =?us-ascii?Q?04bsvW5K9vWye/DFpkCINlZDsZTi2VlWOF+XuS6bxE9JZU1XKzIbRyOsCByq?=
 =?us-ascii?Q?HryKxJlujsQrPhavlXeSGv/cbAbpgKxSY7IZPo2Og4qchZmTBqZvYBABW/yi?=
 =?us-ascii?Q?NtwI4i9BKbJ4OW97Q3T9Zr58i1+WV4W8H0E2DjJ4eHO3LCKFvew2eEmRBnc9?=
 =?us-ascii?Q?nHR43ptXwwsMMny4eHzLHiHHwk8gIBQnr9PCg/U/nFCq5kIs/ilXlDi2n7Kz?=
 =?us-ascii?Q?qMmiilUqWfItccJQaRBPaTpPNWSIJXhale/z7La2oMmSbnz0NHG6YiAe1a6E?=
 =?us-ascii?Q?9wWIhMpXJGPV/c/VyEW9p3pcuS/EaIF8ppkAIUPYP0cIM55M2y6poj+fUVmR?=
 =?us-ascii?Q?qOTSUtiqF+/dPSxrxjXJzAJSCQz3G9jfA/JH8ZdWkzckL4Yct7qjxsOEuQqD?=
 =?us-ascii?Q?5AneA0KBayoVAY/HL/jfyU0LQawz955DQV/Jk/+6K+PXdKPJzy50QNmSn7gq?=
 =?us-ascii?Q?AL2Bg4V8hIgGP7r5Xx1JW7eTy5IQNdKBHMdCfhS3hKRgf85SGn1XWXYgVm6O?=
 =?us-ascii?Q?WwUekDtBPgY87QazoV5C04p9pLDiathxGXiRvfYYhOpbFiOS0e2ADGjSH3Qg?=
 =?us-ascii?Q?SZz9pVEu5FffUGCQ+/uykJhqDzFDHMt/oi9ZBWVfTL1Jj7cP53GQ4I4HUkbc?=
 =?us-ascii?Q?3sk9rb5PxTIwyjjVcWYifjJf8KEEwzI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: APgJTtNsrSngpW8e1F0bxVR7bN18pIkeKP3dw/EXQHt6p8n/CopnqaFFl8ot0Wu5yL1BWkS7+aTs8dUGQISQ33lwM46FBFJ/QXP+coxXVjMBpLxMWmbiFkTMV40h4x/UEdoPX23+mN9us+ZpL13UeC2r+kT6zKJ1o0pqUNnh23y5WjCkgxWitdhXEL0JYz5mgcm3IkUsc8JrFLwPxpxez0Yv2gRZLLEZM8Aunx7zalG42qYbvEyhuMIeWttcekY4jypeNw6gdMPiZRIQCzU9UqOaqsQX25rx6RRkSa7YnOQjDwdVaOinvRPj26NC8Xk6lEvPia8CHsXSl+P8PnZPdg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8111a79e-084a-4a2c-0c6b-08df09cff88f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 15:28:14.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eLCFK1j9rZgcoehmoEiT89z9l7VbznT2PXtf6FZ/H5wSXSRE/bmGyZt0kqqPHUzqd7teolnxHetZyHrjU8GBeij0H83H3uWrQ90zjhoIO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Yury Norov <ynorov@nvidia.com>
> Sent: Thursday, September 3, 2026 3:21 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; open list <linux-kernel@vger.kernel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 1/2] ice: simplify ice_pf_state_is_nominal()
>=20
> The function creates a temporary mask on stack just to check that first
> ICE_STATE_NOMINAL_CHECK_BITS is empty. Simplify it by using the
> ice_pf_state_is_nominal().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 9e08db376d3d..73996e3022ef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,16 +1705,10 @@ static void ice_vsi_set_rss_flow_fld(struct
> ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)  {
> -	DECLARE_BITMAP(check_bits, ICE_STATE_NBITS) =3D { 0 };
> -
>  	if (!pf)
>  		return false;
>=20
> -	bitmap_set(check_bits, 0, ICE_STATE_NOMINAL_CHECK_BITS);
> -	if (bitmap_intersects(pf->state, check_bits, ICE_STATE_NBITS))
> -		return false;
> -
> -	return true;
> +	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
>  }
>=20
>  #define ICE_FW_MODE_REC_M BIT(1)
> --
> 2.53.0

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
