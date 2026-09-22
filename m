Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D842E40F;
	Tue, 22 Sep 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112900; cv=fail; b=g922fI7ILW7la9w5o0JTtIwwCpELnYFb5UV/n5Zzciik5zIwevHm5ERtaRG8f3ta7eN+FfG0k3/3+zaMvpepDQEzPIt5Qwl4PSi/iAY0c6qAPCgo0GYXtSebclYpOLKXGsvaddcB+7f1IGRwVXnpFg2bq+bWvcn3gPeVb4L/cAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112900; c=relaxed/simple;
	bh=eyn+CERylyd+axxC++rA7RdiC6vhZqUGtbEH8oX4nhU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l8z7ovwi/QTE30dPfI9Rabtnu84/sNLm/iySPkE45Tvd54XRQGW2Q3tAFGsdti//szrPfV2pdSZ5neK9nz+j7Ogi+6P0qvl4NOp5z/HaErk2SYWj0qjRyemw3050C8KZAsm+56xnsZDeOLbUiQ6xxlh3T9rISdC8UoACFXRR83c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp2zqkpS; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp2zqkpS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790112895; x=1821648895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eyn+CERylyd+axxC++rA7RdiC6vhZqUGtbEH8oX4nhU=;
  b=fp2zqkpSL/9vQTwz877bGy8nJHq8HlAUR5AMrMMRjgCGWrpc6ZJb4LrD
   TdKlO6b0IKuwg2mnwc8VqsnVmGiIt7k89pJNOfywZUcc70FjEjy8PTQEA
   GXudE4xrWGcIs1O8MHmfPw/MRF5obmnKZA5UGfmqkqLhueLdEO5rylliC
   8CR94ggaMI4Tsto634kfx+hFw5PwIYE3clduLrP/XnF4tbXPk91bIyK+N
   4EA25iZsSEIs0gqvmLQQSz9AzR9s3CJ7b0JR73vaEpJbhE0uOUMkx9P1q
   jhVMTsD0/QhK903Xhi9x9wNQWv7HFm7kofpyVgt7afUtF7nAOv4c4DgWS
   g==;
X-CSE-ConnectionGUID: m97o/eGyQXelVcw3kpdbbg==
X-CSE-MsgGUID: 5PaKf0SLS6iJGt65lYhcdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90779421"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90779421"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:34:48 -0700
X-CSE-ConnectionGUID: e5h3X9bZTASTSzXWC4+xUw==
X-CSE-MsgGUID: Qw93aqWYT0aumWisWLCPpQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 14:34:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:34:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 14:34:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 14:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe/BkxOLiAjI+FhGXpRB3HWRNDq+rd6EsuPERB/6Uf554EqSXTMCVSvqnn4BfVVVoBTK3CcU7aopqhWJHUMF2YbqeWlFc4eFcx4mdaNsY6leZUfg7YwEE/7wYNy27jtGR+HuotO+rOZV+a6sAKwFnd2jeyX5xQkAKWqf0u2zMhf/RQBFc7070dnCpyCahtoGxrXesMq3fZbnwOb79fkoxrahGL7aIGISQbo40WBO3jaxPWXfOLK2KQLgMEKvfY+171u+AAbjwd6BpatWypX5ZEazavpL3muFbQu4naioZL0AA5gPM7t5dg7j3pZIqj2pZaNNGzLApZPS0dojamBoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LKHllK83mVy9/pd9DSjBI0y/N2hNQKhQaB44hgA/zo=;
 b=RveIP4qh++qngxgpaUsfY7WJD+0Mh2uH0454/PY+wvnvXc0jlgRBpFyUsTrYwU/z2vsoilnIBWolV7ffSxa6i9DstVHKS5WtqaYs4JSxCJJhZvpLL8srUZZ5zQV47JSZJ+rtbKE08beSl35KMXKaH6hd0fHXNvH5SG+Yl0CGo1IeqZTmnXQzlacNj9Z3kKUNqBlHJY/yr+ObyuiLK8pymCSf5kD7itGXz6Shv1sxIawQ9T3l6bKAi+tIrPIaYKSEg2Zu6zcLGBTtEEzYjWL9MVLwdXYlM6LhoOTIE5xGvtMKa6fYtfecI2cxOBHF/Fpm2w3oZ3kQPFC7yD0y8hWqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6984.namprd11.prod.outlook.com (2603:10b6:303:22e::22)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 21:34:10 +0000
Received: from MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2]) by MW4PR11MB6984.namprd11.prod.outlook.com
 ([fe80::924e:9c6d:73ec:27f2%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:34:10 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net 2/2] ice: skip the SW pin description on boards
 with generic DPLL pins
Thread-Topic: [PATCH iwl-net 2/2] ice: skip the SW pin description on boards
 with generic DPLL pins
Thread-Index: AQHdRtdLYaMsW0p2A0Omab//FNh7GbbbJjnw
Date: Tue, 22 Sep 2026 21:34:10 +0000
Message-ID: <MW4PR11MB6984BC38C5D4E47699D7B3C59B832@MW4PR11MB6984.namprd11.prod.outlook.com>
References: <20260917190258.3239282-1-poros@redhat.com>
 <20260917190258.3239282-3-poros@redhat.com>
In-Reply-To: <20260917190258.3239282-3-poros@redhat.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6984:EE_|CH3PR11MB7300:EE_
x-ms-office365-filtering-correlation-id: a56f9eb8-c39d-462d-2ca7-08df18f13d37
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|38070700021|10067099003|5023799004|11063799006|4143699003|3023799007|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: KReX6AyzPdfxEiJQVEZBjKWpw6bq1Clw2fioaXWlJPAqTwHkOfe0BDb7tyflsTUEYTZ7pKnGjmRXuJCiUeD3jkeqxzxoOaXoeiy6nanU92ZnA09S07kM9FJEcf0pQcABaTrjq4dlW2GcMZUMsriQt+mi/1E0jAyU0fxoc61GlHozhU7KheEd+tTItDrOsdLy7ovvAECBZjvL5M/HYXoHqEdEJwJrB8jUGStMIZAtKg6K1IigQ0LZ36Srad058gay7PlM+SeS56kIgyMEfl8AYNJYRfWeOQmuoA/saVSWSAh1ugG26toBImccweP5V+PEGlYRvNYXU5NVvSvObhzayyb8PhsCzkX4kg3cYLAA8JygtqU8g0t8Ej7pIF7/3QcGb3j0owJRIhsLCkjI+AHIntuFFKdjArMldNuXW+ApI/x+H7T0Fbk7Dnez6HSlfAyDkrCQDXOyehANsVjL8GZyEWoHcx+/YCTcFSTwgIJk8MYWr6FOoqjb6FnLjEKo3YbJfDsoq/tsAZDjcUYUsNcupdpmL1ledR0lRIKdb2xK5ubP9e6pBQ2ja4ssNdfFpGAbyvi/zf7rbyLg4Js0jJN5zVrcqMP65gv01sfANi2H3PSkSUl2Q0VV0wRU0GEvzTIg8SUgtnmCjH18pXj4Jh4WDI5lLLPONC/qx0XcgJnk1Qr2SvpcNDLkV3unRH2c3OpU3vt58PFeQzUN+Ag7DjWnzWWL66KhPrAsG1sEU93R+/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(38070700021)(10067099003)(5023799004)(11063799006)(4143699003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YK1DhfNXMYXKD1uey+/cWsRIkgZ97PnP+yh/AJDQSSsNhzIctn864xjh395M?=
 =?us-ascii?Q?hs70UaTjKoEgCcGWD/KY/EsZ2OepLrtQd1SlcpArH0tSeiK6ZEmfjs7Cxnjm?=
 =?us-ascii?Q?YRnYhWxg2XZqxSYxzHHU55IhbTrHZBmSW1BvgnAmECVyuYG6RILa4zORbsds?=
 =?us-ascii?Q?3Dp3Pnr7RIvXXkcdfAOdOjJ11i0/Mk8XYuqQ9f7e8vZiIGAqpDMgTXwp3wrU?=
 =?us-ascii?Q?sBAcwyS1bHhrpWHWxBr2OaulikKCb5awSgIxmrPncDmDKBg2Sj+my4c/Y9Lo?=
 =?us-ascii?Q?ml4TrQoOBkx+oF1f8waElPjgy8fOfSxkKgyG42+ZLK9DMueTqOAhTfdyanJb?=
 =?us-ascii?Q?oZE/YKcTUBUSWIRg44GomsTxLJUmAfFbRLYbiIzJesBwzIuVk+c3cQZU09B6?=
 =?us-ascii?Q?bntubiitQ9faaX7fMN8pblf+g06Az+PnVtkz3u99yj5bc3e0T+uYLxhdTwEr?=
 =?us-ascii?Q?Kc4rdjDtpoJwQWy9VEjKPxp8HMy1a85yhnhyf2H/KwICCsNnSBBugmyiPu0Q?=
 =?us-ascii?Q?xW8n2r60ERCfUl2zIAxuMGD/MGrSxOSaDPaIVRRLyI/QHo0y+kVHCzQQ9N1H?=
 =?us-ascii?Q?eId5nNYFjEEdN4Jq3UordTU3OS/OYaYzbD+xJ0ECGo1/JtsuU32/jx5+Xqc3?=
 =?us-ascii?Q?pj9wROsQ/nd1rYxlSbmzLNl1r0715bv4D3OYt7KQS1I77cTDMRTYEV34+Qdd?=
 =?us-ascii?Q?qQG/z8vNYJqysve/MwYZIfElD37fGd8ifBCP/FfscJ9mrvOkU8yNzasH17Wz?=
 =?us-ascii?Q?whnGrT9/RDp6FDczg7YEQ88rsLwM+S/2AO4KpZQP1rV1/p0xRm8XCxBK2ZbB?=
 =?us-ascii?Q?03ltdq/mVMkMKRK2pwk35c9+//dndpTlO1fr2fSsxVHH5wJfucietFkB/u5q?=
 =?us-ascii?Q?59rPlu0rxQV3gEXOIkgXlXdjyHxtTj1oYZRAyaKlOAkdE9bYUfWOzw83hTe5?=
 =?us-ascii?Q?Wdki2gSI67TZ7MEeYyea0jeIhq/Ee21HW2diPDtFZZAzTou6DfyWY4w/LxvX?=
 =?us-ascii?Q?MrQ4CVAyDsJn2mm3hOSldXtYL9rRoxtqJMo5UfVN8M0WymYBtJ19py3R4twD?=
 =?us-ascii?Q?MI6oTzUSM1iLYdilENP0jbc7GAsxiTA9KUtH5vzeFKPu5gZqzyKo4/35+k5K?=
 =?us-ascii?Q?3Swao9cfevLdJy5RgJA1lcrk9mdG6/1WFRV7EVQk28AE4cbvRN+Lhnztk6SA?=
 =?us-ascii?Q?cXESBh6E/gMYzWQtLg/vXsc8nRF+49DJUb4WwFza+EyRIWSJU3pVy0k1zkOt?=
 =?us-ascii?Q?zZS1bc1/sbGmOOwjHJGhOs1jbFj3Hi1jACQvMhrksVzMxPrNU9AtYke7JHDP?=
 =?us-ascii?Q?XT3MzhBa5c3gRADbnWFmxYIEW35Advy5cCK4uY5KVVPI+ePoDY5NeLFhAhYn?=
 =?us-ascii?Q?kmZddxnSC9K74manblIxxgqTPd7F87u408SOdlJW8FAwi6jOYKUIdfP9DOnK?=
 =?us-ascii?Q?ji6+5LMez4l0Lj5QxCc2VE6nZgPQYiobuHDS9SVsxU4o5SeuQgScTsmeSXgE?=
 =?us-ascii?Q?IjV1oz/L0HbmE5+7MQnbFix4XweinEok7kpfSXUL4yjYG8PlznNoUaRRfGfl?=
 =?us-ascii?Q?QU79g/VXim9DGg/+RvYF/zH6AKm2TPEzC7RJ3wqBl/JXdb4PSNDn43Hq8Kes?=
 =?us-ascii?Q?tXotBCoNZpLQUmflyjCZFuITOew5zBF/2d3BE1tDJtHRvtbZYGgSZ6ORMQ0q?=
 =?us-ascii?Q?/9dfVLP93VdP/xP/oEF19/Cofs0MaBNoEWKwtLPoPnGm8SHwnYfVJ1huq7Vm?=
 =?us-ascii?Q?lLIkdoyABJIBW8lJtPdi+6Uht0Tu36M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LUOX6CPHulGAirwrrLVIjk2PBc0Mg3hq8c8PYYqhcUNRlCJgqNSisQXYl4NfwzIkE5YwiVTLONrrGVh82OgmQZTVjgWrcPkjsbjgZnkuYWRN0fz70ETQE3txPPXFF9In00GyZMKGPjrc5q/jDv2gIkZ1yBXxI6c1aBhrLUHp74KEobLlDaki5eE2/mYvGcb2eWkGKowmY4U2Lu83mK90AUphkZXHKAhn2nIMIpcDb/cfGhE28Wy4KXotu50LEd24SyyAvT0DzP5w13Zb0WXdqzxpnImFitx8w7uQw5iPIGtm0hlcjF0Wyk0k+V9QyRrYqd2yEcULSDwH0+dMkVn1pw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56f9eb8-c39d-462d-2ca7-08df18f13d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 21:34:10.3015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMCToE257Fx1iQm/uwUvKrDNDEQ5FfYxqj8cxvd4e3r98BibvAfEUfx1PmmZyuy5y2Re/X99Kmh/HUdA18G5NI+SKF4ba85ODoXDf226B2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com

>From: Petr Oros <poros@redhat.com>
>Sent: Thursday, September 17, 2026 9:03 PM
>
>ice_dpll_init_info_sw_pins() describes the SMA and U.FL wrappers by
>pointing them at fixed positions of the input and output arrays, inputs
>4 and 5 and outputs 0 and 1 on an E810-C SFP, and reads the ref-sync
>partner of the input it picked. The arrays are sized by the pin counts
>firmware reports. On a board that does not match the Intel reference
>layout the driver has already fallen back to generic pins, and when
>such a board reports fewer pins than the reference the reads run past
>the end of the arrays.
>
>The wrappers are never registered on a generic board, but
>ice_dpll_init_pins() still calls ice_dpll_pin_ref_sync_register() on
>them, so a stray nonzero partner from the out of bounds read would pair
>NULL pins.
>
>Describe the wrappers only when the static pin table is in use and keep
>their ref-sync registration under the same condition. The default
>programming of the PCA9575 clock mux stays on the generic path, a board
>that has the mux still needs its SMA connectors switched to inputs.
>
>Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
>Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

>---
> drivers/net/ethernet/intel/ice/ice_dpll.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
>b/drivers/net/ethernet/intel/ice/ice_dpll.c
>index e0362b6bf332e5..81bb32d2b23012 100644
>--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>@@ -4124,15 +4124,15 @@ static int ice_dpll_init_pins(struct ice_pf *pf,
>bool cgu)
> 			if (ret)
> 				goto deinit_sma;
> 			count +=3D ICE_DPLL_PIN_SW_NUM;
>+			ret =3D ice_dpll_pin_ref_sync_register(pf->dplls.sma,
>+							     ICE_DPLL_PIN_SW_NUM);
>+			if (ret)
>+				goto deinit_ufl;
> 		}
> 		ret =3D ice_dpll_pin_ref_sync_register(pf->dplls.inputs,
> 						     pf->dplls.num_inputs);
> 		if (ret)
> 			goto deinit_ufl;
>-		ret =3D ice_dpll_pin_ref_sync_register(pf->dplls.sma,
>-						     ICE_DPLL_PIN_SW_NUM);
>-		if (ret)
>-			goto deinit_ufl;
> 	} else {
> 		count +=3D pf->dplls.num_outputs + 2 * ICE_DPLL_PIN_SW_NUM;
> 	}
>@@ -4501,6 +4501,8 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf
>*pf)
> 	int i, ret;
> 	u8 data;
>
>+	if (d->generic)
>+		goto init_sma_ctrl;
> 	if (pf->hw.device_id =3D=3D ICE_DEV_ID_E810C_QSFP)
> 		input_idx_offset =3D ICE_E810_RCLK_PINS_NUM;
> 	phase_adj_max =3D max(d->input_phase_adj_max, d-
>>output_phase_adj_max);
>@@ -4566,6 +4568,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf
>*pf)
> 		ice_dpll_phase_range_set(&pin->prop.phase_range,
>phase_adj_max);
> 	}
>
>+init_sma_ctrl:
> 	if (!ice_is_feature_supported(pf, ICE_F_SMA_CTRL))
> 		return 0;
>
>@@ -4584,7 +4587,7 @@ static int ice_dpll_init_info_sw_pins(struct ice_pf
>*pf)
> 	if (ret)
> 		return ret;
>
>-	ret =3D ice_dpll_pin_state_update(pf, pin, ICE_DPLL_PIN_TYPE_SOFTWARE,
>+	ret =3D ice_dpll_pin_state_update(pf, d->sma,
>ICE_DPLL_PIN_TYPE_SOFTWARE,
> 					NULL);
> 	if (ret)
> 		return ret;
>--
>2.55.0

