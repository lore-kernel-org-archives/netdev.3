Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0020438FED
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494745; cv=fail; b=tmyJhp7rmbWytJHhhb4P/BwnYvwuqIS9Ly+Y83pBDQzMyuw44IKK1ZsHQJBHTpW7ARQ4AaBdYBEevXoIKLqSOk9iq2QhsRNL1gFvHEKjCQqHcXPWAfLGf+omGfpAxcoCSyxfEFhaiHf1MoMKTbG99p+TEhvCbLgc2UAb8b6bz6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494745; c=relaxed/simple;
	bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lZ9KKWw2pXlrV1aatwI7aI9f6eDIVMaW2l++gqwPlMb6AehqUgE4nj9uMwHAlnWNwZ5b+wmG/kRR0oEsN1JgS7D5hJCaNROcOKt9Pu6urQTgEap511JTpHY6MBcUrtMEm3l/25sCRogv8OFuhz6hACW4S72zyErUsRe6JrpUNxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EA77wacK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EA77wacK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791494743; x=1823030743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
  b=EA77wacKllVXUz7oXbHqbAcNtVPQFiYw8UGeE1g3Y6nJomiuWnA5vY2N
   OMecOesICr1N/NeALWzj0Y26IWDiHPtWuBb9P2SMDMUZUEAtex9OwB0gO
   rGO2Nl4kUb/u8dBqJtGT7UyObwu5D/S7O2kUGMELmqiJX9F6Kg/cccPlo
   EImGFORi7I/z3TdpJuUGafL6Zm7G9Lx3oYbmhD3yuVoHyYGo1XnNbvwgk
   ZPxe/8DsBLm8VVESVewUAUny0OVCJX43Sz7HsM/HFMHnHcdGMMFc1Y81J
   1/N2KMKgZGUJI+7QU+jDqSvDXUuhESc6MKBe/8FL8yMZyy64hEFhJ3Wo/
   Q==;
X-CSE-ConnectionGUID: PSNoyPfqTyuzizcxL/cZ7A==
X-CSE-MsgGUID: TUlHkIWITQ2AwQKqbMJaWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="185033"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="185033"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:25:42 -0700
X-CSE-ConnectionGUID: 7K4IzhZLS7uPDjgu1/NodQ==
X-CSE-MsgGUID: Zhl/iX+PTzmSuipxHEIuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="145934"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:25:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:25:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 14:25:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUfVY12jnHm0s0pxbPLmBTzCrQZIbycNsbylXb5QSY7cHHC0TpTuS+aNpYIJz2bm9oSKud+HkK+RO997t2MDN4LuNPwgOOssxEqw5vwWNG8ld4QpNueq+VPs2srqofo+c92hsYzl8XW1KAEZ2BVB1ugK0gY9484qx982suAxz+5nhPqvO1hAy0xAXtj448Hb86XON9o+P4VcIiyy1HkDfa5Vwaw2mH9bOW/Fqwkg4tpojWQirUZL4L+rQyYB3uarYZv/OZv1CBh+tGqhbZTw32kl/LcdSwRqY96oUKTjAGi18VCBZiBUZ2jrm12oFpA0tRX/EvuTTjl1hQMgVZqttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7rVc28W6HqDuSFAycaJIa5KWSfNiJujxKcW66RGO+w=;
 b=CQHWjHT4HUcfwGrPTdsMHclWi+tHkOCl7WduS1hGe6IKtK303b+GQO+/WLuuhgjitXBnSt9K0ExBeqaLA8bfxO3LWvapk6/4MsyySmf9tR0Lwqcp7m1n1++GTZ7D3VZdGshBGJ3DQ7sQclSRZ9H4F6w137qIk+mNgdFPsMTVwoXFySt6enJFmzpIWoPLgfR1ScLak7oB9j3qt+DohqU1gaR3LOaLJ3nHxckQFLrZRXUcgD9guBgnSiu7d8IBR2DKsevhB3+MgXC6/cOeDbb+AiJYr36qz+6hcpIYJPtK7UEFF/2G6DJRnOHYY7IC6Fl3d13E8G2/l0MQ9JIh5QzNSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) by
 DS4PPF8ECAFAD61.namprd11.prod.outlook.com (2603:10b6:f:fc02::3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 21:25:39 +0000
Received: from DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7]) by DS0PR11MB6422.namprd11.prod.outlook.com
 ([fe80::d257:46d9:13f4:adb7%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 21:25:38 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Zaremba, Larysa"
	<larysa.zaremba@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector
 structure
Thread-Topic: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector
 structure
Thread-Index: AQHdQfHZRAUmlEiXz0WRopp7LK/K+7b0Uyeg
Date: Thu, 8 Oct 2026 21:25:38 +0000
Message-ID: <DS0PR11MB6422A2D727FEE9CA6A697D5C9B932@DS0PR11MB6422.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-5-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-5-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6422:EE_|DS4PPF8ECAFAD61:EE_
x-ms-office365-filtering-correlation-id: 9b018498-7bd8-40db-2e29-08df2582b2da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: CXT9kh0YomVF/hM7d0DKlsVITpBOZWHtPOALKhSlHviiGkBDA62efEDBcHzD5NPrYqIADO+3kJydZOAahwZTCXvHkKucy/iBMs5nnrlJDWKugohjwUs8hmE7PWbH9zdgPpwel3jbSCiUOJIYeihKrZY6inG6eQK110teJK5IIM0YV24jy07iLAchgiLcphPT40cs5x+wD9hNjNZ/ahB4PLMxqXD9m/UhHttfDN+CyI+Nj0LzOtdlMSemTpy5YFnFKHWJ1A7BtO0+xkPJw28+TWiCXaeHSBgS/D4eYEUK/f9jMcITivLqowTgCjJ3Ri9AXUbQfY0TR/WsqnfxTzGxA6xoC7QLwVz5EmvTTcXpV/bZmxYj5QwDsyu0gi/U8WaQ3F8kbC8ZqBobOAzIg2RgXf6+Ei2SJOmvNctVU9KkZRSeCLrq065fxlHo23U+kKoGJVzx7+X2r6+2keKTNJwVPo2qW12+UOZl0dvcL/WG+OrdTF/wqGw+ZcafDEDy9zvDKzbLg1b79iFkQiAGUiWEIFKrUvydg8MY8YunfD25coxnLmogtbwCKb+DCZ4sxd8s3DVceY5eKQIjGjmnRyFw9kZ5ScPJWg2lAD3Xfsv2o0TLZOH+Ik73NAf75UF8qRQn0VfTwC5IuXsZ0iZvIr9ob/6POYtm/3+2D7AlCAvf9KJF/NYKsGhIbEbhvp+U+V4kzuTHGnZpirpAc37/rXxCRph9RcNPJcpZYmDt5hUXf0I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6422.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GT8jdMgG/MDVIN6p5ZmKRk/aeCzAxhJGoByixIxgq8jxCHBy/UTdL2po3szT?=
 =?us-ascii?Q?L+GQurnJtcf0IGMXkv8Qtcg4DtDOnhFnlox+FbjWagC+cgrWo4YIEI9JlnRS?=
 =?us-ascii?Q?bF5DFfX4bdtdFsBBSqZh15pmSHTj5F8aKAmemFxHdMoEs6rS7BRy4SExdXGu?=
 =?us-ascii?Q?zhODfxcWg6yq/ETHs14CJpMwlPjGV6+2XCZDhDait8TD/g5LtrQia19R1Cdz?=
 =?us-ascii?Q?MBOT4g/nIm0tQusb/UH+zPDfga11TpSnOg1QWPI+FkKUZxz8obhMRYH/wgoG?=
 =?us-ascii?Q?yRZAtwyob4mX79vA9/n5wEPIqWKxJkJryXzL9Mjmx633R8PjUMeegWrLbDeL?=
 =?us-ascii?Q?X0WHG4sQWmDJostAbHqIUp/RMrzPr5RwiRuSNKZohpic63NZMxbkwHQbF6i6?=
 =?us-ascii?Q?LrfYWC/X8UBs8kU5Hb/7kC4ZMQJZFulTSHYXrnNI2U+mBIybscNT+mpJjarw?=
 =?us-ascii?Q?AJv+MGk4nsHZb8Xddp7nyCmpJ3rh6ahpvMAqXCrc6KaWa+3FNNlv88/cPd1F?=
 =?us-ascii?Q?vQjBKAUkCuuneWiBA+RALWT2RVQ5wXv11fRqmI9FOn/1q7vVQyLTQ5LXdH2B?=
 =?us-ascii?Q?nt62eQEBmwGCKI2ePFY/abvvfoQ3okEdDpo0icb6jABMZvXqg6n4KAdqMRI1?=
 =?us-ascii?Q?7glM/CW885Pen8a9xMg/56dtM5jMWjlmmKVFir4OCpDRDjiLv3SSVA1SO6dw?=
 =?us-ascii?Q?NwjYBpQaLaU+ASrDs11xWKJGIrnKKk9AS5TcT8LiRafGNjFI1cXcKIBIMyqj?=
 =?us-ascii?Q?UumMRqPDSkutlvFwjYxHUtaIGwAL+cWLAoqdIhRgmq2KRSKd4+P0VWyNG4Y2?=
 =?us-ascii?Q?WNjsPTEHx0pomGQZQkD0A/zrvweIVYNyR3ZdJf/d7o1vIRO3qHNHmv16bAUs?=
 =?us-ascii?Q?F76Z5fsvHexl65S1juoxl2SNPgTcckTyhVYT7nFTC4nmHTue7Xca5qAL7zKc?=
 =?us-ascii?Q?Fn4VTqrxktUYFNHzuXcB2MAnBFsHPp8qiWAiyOr6G3Qiq6Ry8up8b5vlBQcP?=
 =?us-ascii?Q?ThqlbfYZsMuGEqAPRJM9NvphV5LCFflSEYy76AmiAAoUO+udbpufO/l1J3Ai?=
 =?us-ascii?Q?iahsXXSU001ln0I64bfMOdPND/KKMQjBIYbd6x0ivPfIBwEDHpk8mQHi3bXj?=
 =?us-ascii?Q?JcFF4OVieZTuH0rJ5nXtIIFH29Zw0Jw+t0mnk2oYTpoO3FVB1leyItcoX51Y?=
 =?us-ascii?Q?mJ6zGC99A1MHs4j2oRnDYP7A4yRJnzWm17agPy2DHn1OPrVn56UlYYmx+C2R?=
 =?us-ascii?Q?lCkxJ26UQam7EEanrtDeSqQioa2aOIQyqB8+2Jtr15Wb8aeFrBLmG2Z8trD8?=
 =?us-ascii?Q?7wBpl/YFNowtPzIVRa9uYtOTHChWutAeI/488cgbPWvpZdQ32jzQHVu12qQQ?=
 =?us-ascii?Q?oTE5orhNDrlo0s+jDHn22bX/A9YM3Jpk2bgrj/IGj2YFfiz/uV2eJ4JlCSgC?=
 =?us-ascii?Q?1yDO/EOQUtKKCVKHfS7kn3uFMwMFySHhhI9pYZD44zy7JX0Q0qPpr8kX0C96?=
 =?us-ascii?Q?/CaDgEW8UCRm8J9ZmZncDWdwQNjTFAQwhitoG3+U8R/N3kJQiqp0iT7I+HRF?=
 =?us-ascii?Q?hwJcLCqLa1H/JsPtC/InbXms5Z0vXHsoKNQOo5psu4xrhJmDLVyIzVWy3SI7?=
 =?us-ascii?Q?Q1lCIytwFiaOvOzC4v25sMjueber5xb4n0T6D7W6vRqJGEmPPI/0uj7AKpw0?=
 =?us-ascii?Q?Hmqo588PYv5hU7n7QEGSJSlsk5reK4SScXITFKpwFPWN/ejb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pXvMy4qT+71NdTGFDycHAOMnKmMDK1DuAhAUyz6yJA51/mDkHbAghSwJzC/qCN0YU59rjFBaHVE6ETw+T19hvozzd+sHiVjDrwqfbTBSeTErEDWZkKXigEkn/+TcW+2/tDMaCPdOMjI8I4q6lILPjj5C7r872sn6zFBWhh4lF9unJ4E2LwrdtE1Un4/6XLKymqIIybZSyXl2PBJQHOMkwjeCLVCMcwXr+8/Ldp0lTfGlwVqC0R0AxY0KCoiaDPtI5wdGEFpkoBzQnogmCeOIuAvdMOmQc+szxzqazgXMp5rqaJwGoF8XyAKarLIAm0p7NYte0hVLRnj/XihRo5HPow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6422.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b018498-7bd8-40db-2e29-08df2582b2da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 21:25:38.5859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCUiK8jyxeeTrNk1rxDBTJ192nXrYf61reVvVdeEV4oM6FtxD1dwk9lSY1oEt5QIMR5lTzt7wMxBKkg3ea6wpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF8ECAFAD61
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, September 11, 2026 5:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: [PATCH iwl-next v2 04/10] idpf: drop v_idx from q_vector structu=
re
>=20
> Storing another index related to irq in q_vector can be misleading. It is=
 only
> used when matching q_vectors with queues. It can be obtained using 0-base=
d
> software irq index.
>=20
> Use irq.index (from q_vector) and get the hardware irq index (q_vector->v=
_idx
> earlier) from irq_info structure.
>=20
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
Tested-by: Samuel Salin <Samuel.salin@intel.com>
