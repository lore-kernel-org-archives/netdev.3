Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6DD560AA6;
	Tue,  8 Sep 2026 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873257; cv=fail; b=tsGgNo8ciopkaeM+5T5JEYjRMWq3/eDosDleJUBhOq5ABR4Kd6zIkWcS96MQgIBNG4ejCAA7dS7GBNZEWEhWnUF7ARtR1TkkfheF4ghW94WNh0WRrKUbfSVX3xPIygyzWid2BYVeobZrVzHrE1rUxg+F1Gihgx1ZvQWViRtshHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873257; c=relaxed/simple;
	bh=FLNwgGANxBtkxHwyeXGRwPEJbZsIjV6CNbCnsG2WSb4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qEERUuBw6FP4mxV4T1hVfpxeGuwHn8DvKzigi8E4gL99Sh+FPhxnAnRB6NBsHbxj+8LqaWV7YJhupdG0TP4sNhKqRLrO1cJ7u5A3IhgsQm3AEv5ToCvd0X9ceGDGdDB2A3vQ+yAGMM9et43lG/+efxJc0cbXQuVQKVrtbjsJZAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHY8u+hW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHY8u+hW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788873251; x=1820409251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FLNwgGANxBtkxHwyeXGRwPEJbZsIjV6CNbCnsG2WSb4=;
  b=kHY8u+hWbiMqizbwc3GPLSDbCAmkm9vRrNFSUWhO2uKAc7dXVB+lZ1YJ
   fntMQAii0XcKbi/rvffXjX708ph2nHS2HbiswKgEI6uW5/aqvITKJXJUM
   R2pl7+mjkJhGNp7ii56E8tPisQaJvtnNfodpVJ9MXTH80Hq0ezgIbQsKA
   0Trc33yOmsZZstc2NG3zFk6xufNsDbBekvPHO4gHZrL0bx0/OdbLH4Lp+
   kgZ5qkWIdg8kFl6t13SjjWJ3tkwUyQJ6UUOMDns3qcHhjAsibjxaNhyI8
   oHSTc75yXfdJSg3TY92j2jbYOWYA8cLUTJea3Jru9X/BecbrS5pHkxy46
   g==;
X-CSE-ConnectionGUID: k/ErsxQ4TJCqZuPz8GMlXQ==
X-CSE-MsgGUID: RaPpW7npR32D5W9rmUw+zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="76834530"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="76834530"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:14:04 -0700
X-CSE-ConnectionGUID: eKKLM+xzQja/fNi8VvTuaQ==
X-CSE-MsgGUID: TSPVP0aSQZaO0SwOapNT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="264801487"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:14:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:14:03 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgCiRT5vGz+kfFnJ+BmunCj9MZ3GCrs71YD87cAkcbh3/wiPsHS/f3TCxmWkLDK1wE2VucWCply3MsaFxo6tXDEOFAEugqeBr/7jBXtgZ4rO5T9aDwwFjKrehZzwGLXyRrVR9ScohcKVWzQPQ010LHRky+6IVxDYa4fMzNGW9NhQxTz2WzcswFj2R/vd5fvztC3ObyWkVlEEPXStvacYMP6FMZY2dejC3UoQYHWT/apAcsXW4Lv4kNoeb20LJSsxxBQmFUtqnsuNCQHwV1CupdIpJORLaNbbgxQsipNsq20m/E8rcr97vufOC1O3Wj+X9MD5ZCsDxONWkdFH0oFf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3K4O/aV+zeUG+Poe4jyMfql6XN9p9NLgBNA9b6LD+w=;
 b=ZrXa7xBXieWhLCr+TsmWNYVV3+GEzllOtZ3XpRScrb5StRdy5fADtmCm1gLlpBTkarmcSqn3JJDdGTj/NVzPtA8Sb5U28lUyUDEzM5PqCq7coTz6wBO1a9kk4Ar29h47HIoOhVp1OZmubGYNQ2Y4oBud5d8jO1Gh3qhrWm6xw797upqW4z5SdMHiGt97oOLpAvD+r512gm6YJLT3YZ0t8DNckTEXWj73f6WjGHMfiBEwe9quJ5/HGScZTJrLT8g2WMHQY5+gidrEjzLh3ItiyD4keDb/UqehKfQRRQaqXL3sc/pvXhU0AZRRu0Pqtx1QXKLbuuPd4DHMvSTiXpr+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:13:58 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:13:57 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Aaron Ma <aaron.ma@canonical.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Henry Tieman <henry.w.tieman@intel.com>, "moderated list:INTEL ETHERNET
 DRIVERS" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Thread-Topic: [PATCH v2 2/2] ice: clear Flow Director entries before reset
 cleanup
Thread-Index: AQHdPr98g1RfQ4eTL0C5c1rNvRca57bEqkVg
Date: Tue, 8 Sep 2026 13:13:57 +0000
Message-ID: <IA3PR11MB8986D2E1B01AC889ADD35448E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260907115221.926007-1-aaron.ma@canonical.com>
 <20260907115221.926007-2-aaron.ma@canonical.com>
In-Reply-To: <20260907115221.926007-2-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: 0d34ffae-3395-4f0b-ff98-08df0dab0a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|921020|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: OgFIQg8GSDxc/Z0lDT5up/EsA6MTMPfeGjMfDPyB3D+XKrRcMjeci6VZTG3vpMfSnGsKwWm50aNbXQU5U1XCt0hoBXaNzspbpbJMf9d9qq3TGT4uDKmEjfuY9KPHqjSyk7jn9cZXi/y0bauLr3QW1ExlSdd25OumMTGJrhX36DhTh9l03XXi681WmR2QcoZtHV9x5EykHLPNM4lWYAyMSlNiykAO95THY5PvRN8vDGLORVF4zeOmQZksmPhOju2PNySGyxvRNUXNx8w3FcShM9DfKrCNPagiOINS08jWgJbw+8sxSGR+ELp78UEOdBFKhCvDa0AJRBjeL6kYf8JmqY4jYIHuzaShAU5YKNH8c8HExTDgq2S1vpoPh5vTQbNB39ceIJEELe7EyisyniYtzFH2SZaj7KKpmN/qws6hCNkzflejsuct9eM/SP9NicDtsKmW7kF4Hw6PEgxwutFlBPsa1HYidbgpNnsXiipuMuEHegxqnf04p5DiI6y5Pma0eXoLp01vk2qw/nhaNNSJtNbEnfK+0emJ9vv/GUBVrjMuy0I/FHD/TAO013/s3/g9smjU0rIYeORP3rCiWnhaQyIrLFgkyTOG8emVl7rZJyX8eU9PbZr8L7KfDb9Za8dqQybHca0es8p98zDwLGMt7n3lud8FpDE0S3gX0z1v1Fs1RprtPrb0uGS1i93jHKKUUxzLv6o97S2PSn6Q38xt3C+8slDpJaDED9VtG2bMXiRj+tXUiU62qvDe341wLao7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?27M6JKkpT9xg1J09QiqlNxl5Bvq+ZTv3Bhe6vIU2U9Nn0dh37Cp7INzxmK8U?=
 =?us-ascii?Q?eSCeehB53ukc9CjT3j8jMhXsxSggLCRmnyBMN5RkpFxSaWuzrFr0WRZnr+t+?=
 =?us-ascii?Q?ZfgEG3JRLbO+Sm1dzmtDe49af5eX/s4RhIOZF7CL9n1oWrqbGSvzLDBES0+s?=
 =?us-ascii?Q?ziF0NhRE434U5ZcsRue7yw0jkDa8ElnxJSN3WONULhzxxO3t0E69zr9jxyrb?=
 =?us-ascii?Q?4qD2yobUbxbSJfThtdeml5O0rvK1Vd7PUDL+bQKtljwPwdbjZlY+Cjc+gyJl?=
 =?us-ascii?Q?yF6RgbA662sKnZ1NpnGUoxgJYmEXJtcuzUMUhr7WwQOYU5BRq2jVa4DaOpjL?=
 =?us-ascii?Q?BVerSP7Swz9OAhPiLerzXbIg1N1ghAJQLxBXNpYFgBzcyfT2CYjDssQJ6OIf?=
 =?us-ascii?Q?/2AROz6Ng0GMiUENFvqu6uo+2T438xMvqwNIxKVn5l5gBySuBTEBg2vDPOY8?=
 =?us-ascii?Q?QSxhVLizis3N0gVQkQU+qadyeqXJsAPq4hhOIa+zyTivJqIip3Nbq3qUGmYh?=
 =?us-ascii?Q?W0HX1aw23aZR1pCHmbr1yLbYWq5GsB7YaPD0xRl+FEiazxTY0VYORO36FIqM?=
 =?us-ascii?Q?XVGNKFu+RX9YBBJaJRoGE3vbjabs3sYdZonbT/50q/QHDFWRMZ4JEFEXmqib?=
 =?us-ascii?Q?JSZRNri3W0q7SxPC6Xru09LFBFtS42bgsP/bP/TeYswbvfuDqsl2buU/hV3s?=
 =?us-ascii?Q?ZDSfUwEBnRd30IBx9Nnvirk1NquEIWhti49P+UkGOsHJ1H+dNsLtmbBHES76?=
 =?us-ascii?Q?q7TqmwgaRjeX8RuonL6r3pnoun/3IZEEIaO1nDWy8Jf3Rmhz995dIpn8t/IP?=
 =?us-ascii?Q?aixRT2b3yJAt5hQxq1C3G8koeoKP5rfJxomD59TPHi+FLSRbAv6oK6o9kUCD?=
 =?us-ascii?Q?dXAmrI+Oafe44xfEOO9zhUjxCl9cdmFJwiz0xQRyD5q9nFkGQdI2HX5te8sq?=
 =?us-ascii?Q?RLZYYvPqM+kebBlHTudByxSjRhK9JG+2MkiK97w/BQahDUAsLePvs5QD4Mhx?=
 =?us-ascii?Q?iqoi/3/6U9ogEbSIkXjHA3bHNZOqg8mduG/56iX1d5lWWV4bjHvsJnLLTIE5?=
 =?us-ascii?Q?yAMQNckJdGHth6PM1d9FVxtwJSzcpIPX6HSJg1a0biX8MDziI2NQYAZqhI4p?=
 =?us-ascii?Q?sUq0r8l7fBQuNdke7l7ekKmJypyM4FRVETHnnZ8CLGH2YvbrlwiG0+CYxnTz?=
 =?us-ascii?Q?Mr46ljR7JgR58txsRAW48MaO8S2f3swyVKe4dA5TIQyKWc7SFcXyYLLFzmQr?=
 =?us-ascii?Q?+DjrF/HoCnYTws4UcNIB9V9K5RDBIaWWC2mbFWWfLIWO5S5CMe3x9glWDxsp?=
 =?us-ascii?Q?bAdFskUXNK18TZVLlga48J67KSGDYyrUQrZkZF63socyZbEbSLfGfMal10JH?=
 =?us-ascii?Q?rTDmGfD9/UqLDDdRnQr1iVlEORgzujnV9hqwvQqmOCT3exHxLCwwdw+d/XEd?=
 =?us-ascii?Q?eLQIXq+yEKbbA397zBj9FJtMrtY9s8v9KwAtINhjor4Abg6MiwDCMtNtHCjH?=
 =?us-ascii?Q?szhGOgUMqy0m4UblXSYUwpLmJUR8CLC66EfcZJaUid2mdmvgol5XNOPQ8u6p?=
 =?us-ascii?Q?bL6GR2g3C8NHtVCZXWNx6QCh2Xu9bdwppdkLJ4/Wi7WO5HZxmWLQ2Xtb6TMG?=
 =?us-ascii?Q?mXbiaS+IaAQ28ndpxYionId/6Lnrl6NhDvSJLcPDziVq1sMxZ3BDuHAEu8vF?=
 =?us-ascii?Q?Ox9ZyFVbBX4S4kfwHecjtJWPQ+rN4jvRqmoZw8BLnBlUXs3l7xQxsUxn6CfA?=
 =?us-ascii?Q?bQyUrYmM7SO7OsZmUhHaRXe7qal3Clw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UcdJXYZxkQXboIFFTwTYlHA8Z+ZUrdXTOsRuk+Wsx7KXgGYxNIfXbkc9Q0BJ4XVwkyTmsPMV58mEW2RvqFVsPQ/2LE6qVi3z/yiSRTQr7ER85QMDV9wZgROiTMe4wbbEGJs2g3YjvmlKLZui7UR39J8//fq9WI+ec3kzE3fXqOxQPXet8aGqtlmsv7+GVzl7BVnNFQwIJDj57AQnUQ9x521aI0ILJMVz3jJNERH5zbXL/xlJ206Rq95GnYX5tMJZr16nFJ2EeA7zRJE9rMmrV05wAh5+UejkpM3wukQoJ/YhzSI+4rKFHxrYdQNr9iyfmS92ImPyk862do1a3wPJOw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d34ffae-3395-4f0b-ff98-08df0dab0a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:13:57.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFvWUeMWS7XuD6ShsAXwKWazRyabOJadkJhDj2KIHCWnGKD0haTcENyvR7R+c8OYgw87+UXDH3fQJiDK8St+llcE4kvI7xf5dHYMIOUBsGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Aaron Ma <aaron.ma@canonical.com>
> Sent: Monday, September 7, 2026 1:52 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Henry Tieman <henry.w.tieman@intel.com>; moderated list:INTEL
> ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>
> Subject: [PATCH v2 2/2] ice: clear Flow Director entries before reset
> cleanup
>=20
> Flow Director profiles retain handles to generic flow entries. Reset
> calls
> ice_clear_hw_tbls() to free those entries, but leaves the Flow
> Director handles unchanged until replay replaces them.
>=20
> If rebuild fails before replay completes, later driver removal follows
> a stale handle and dereferences a freed flow entry in
> ice_flow_rem_entry().
> KASAN reports a wild access to list poison from
> ice_fdir_erase_flow_from_hw().
>=20
> The failure is reported as:
>=20
>   KASAN: maybe wild-memory-access in range [0xdead000000000108-...]
>   RIP: ice_flow_rem_entry+0xaf/0x170 [ice]
>   ice_fdir_erase_flow_from_hw+0x1ee/0x420 [ice]
>=20
> Clear the Flow Director handles while holding hw->fdir_fltr_lock
> before the hardware tables free their entries. A successful replay
> installs new handles, while a failed rebuild leaves them invalid for
> later cleanup.
>=20
> Fixes: 148beb612031 ("ice: Initialize Flow Director resources")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
> v1 -> v2:
> - Acquire hw->fdir_fltr_lock in ice_fdir_clear_flow_handles() to
>   synchronize with concurrent ethtool filter add/del.
>=20
>  drivers/net/ethernet/intel/ice/ice.h          |  1 +
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 26
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
>  3 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c4..4739ff882b9ec 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1029,6 +1029,7 @@ ice_get_fdir_fltr_ids(struct ice_hw *hw, struct
> ethtool_rxnfc *cmd,
>  		      u32 *rule_locs);
>  void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);  void
> ice_fdir_release_flows(struct ice_hw *hw);
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw);
>  void ice_fdir_replay_flows(struct ice_hw *hw);  void
> ice_fdir_replay_fltrs(struct ice_pf *pf);  int
> ice_fdir_create_dflt_rules(struct ice_pf *pf); diff --git
> a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> index aceec184e89b2..04510b36aa56b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
> @@ -428,6 +428,32 @@ void ice_fdir_release_flows(struct ice_hw *hw)
>  		ice_fdir_erase_flow_from_hw(hw, ICE_BLK_FD, flow);  }
>=20
> +/**
> + * ice_fdir_clear_flow_handles - clear handles freed during reset
> + * @hw: pointer to HW instance
> + */
> +void ice_fdir_clear_flow_handles(struct ice_hw *hw) {
> +	int flow;
> +
> +	if (!hw->fdir_prof)
> +		return;
> +
> +	mutex_lock(&hw->fdir_fltr_lock);
> +	for (flow =3D 0; flow < ICE_FLTR_PTYPE_MAX; flow++) {
> +		struct ice_fd_hw_prof *prof =3D hw->fdir_prof[flow];
> +		int tun, i;
> +
> +		if (!prof)
> +			continue;
> +
> +		for (tun =3D 0; tun < ICE_FD_HW_SEG_MAX; tun++)
> +			for (i =3D 0; i < prof->cnt; i++)
> +				prof->entry_h[i][tun] =3D 0;
> +	}
> +	mutex_unlock(&hw->fdir_fltr_lock);
> +}
> +
>  /**
>   * ice_fdir_replay_flows - replay HW Flow Director filter info
>   * @hw: pointer to HW instance
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index abb6e850ec09f..164428ba116a0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -601,6 +601,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum
> ice_reset_req reset_type)
>  		netif_device_detach(vsi->netdev);
>  skip:
>=20
> +	if (hw->fdir_prof)
> +		ice_fdir_clear_flow_handles(hw);
>  	/* clear SW filtering DB */
>  	ice_clear_hw_tbls(hw);
>  	/* disable the VSIs and their queues that are not already DOWN
> */
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
