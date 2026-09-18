Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178115038E4
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746274; cv=fail; b=mBOWOyWOWIHsSkPhl1fNYcXhKFktD7l421Tgu9QmqvVwmmn5mMD3cyjNDfPCLvhhP2EvG7OF7aCMagu8HWOgvFbPEFn9NaGy0r6YkIy6BGBINc+xkxekpQYdQdGaEmm2Ty12YedEVgUqe6u/0fOkMVgwzFvTBcCIUsZb1zkkQ8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746274; c=relaxed/simple;
	bh=O2B/y+NHdufQUnfIqMfpXljeneTlP3PR8AcbsDeZel4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTBQy1JNU12KfW5RS/QSBScC5Opz9zowxqWVcxqmzObkPnOuAIiOSYwjxkOFsCjdJ9RRiRfVkuWU38HvFbJ16sQyB5SrxQ5T+tK1O5WZQugCZi15eL4RM3JenT/6slY+aSwgGT4OVdz9+RS/lmNG7UkvIBcz6pmyoaRAgfiMu5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbmrzKth; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbmrzKth"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789746272; x=1821282272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O2B/y+NHdufQUnfIqMfpXljeneTlP3PR8AcbsDeZel4=;
  b=mbmrzKthObxep947+arRDcLHWuHILKsjD8RPXjfLfeoZAIMr61YGEj6A
   VweQCH8caYiunhYFocX6h3z7xRjgyTkOJq+7KC0nqzFASxfTc1LMrvHTu
   k+bMYqx8wpKcZazbiNaWLFWVIR31no5UN9jD3Kk8Iu38a/I37lplrdOmg
   ubOuGJnKM3V0VrSpeBPwzOpQXti+J6PHlcm9iE7mOha5BJKjWG2tIlBeR
   MilVY9GJOuzJNQrNrZGK5PfZlOQ38e5ZCRXXSX/VlATniK1EcRfKgXbYG
   OzOlW3eM00M4uxTdyiOWc90o7kwt/kirZb7iVHqOSFac4KBVSniaYVRe9
   Q==;
X-CSE-ConnectionGUID: sQDjO9rWR3m78LQjaCIs8g==
X-CSE-MsgGUID: SrTl1dYqRMSghkPafnVuLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="101612852"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101612852"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:44:31 -0700
X-CSE-ConnectionGUID: aWtpx1WvRz2mIjL8LbTAPg==
X-CSE-MsgGUID: l+Yp23xKTz6gQvnjgRY/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270156564"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:44:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:44:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:44:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2uwcmI0DplF6pyOuTLT7+/lgL5W4GctajzSu1DQAm2FHG7NqgOLJBQROYHLzDTnT2PFU+VHLZ2r0YLjzDCEfsH9SXo6nY7jiqbWCP1w1hXzSnk8tkhU4EPg4Y5lqpQ5kUTDcR1LFKLyFE2uFIaDQ6zYKMncFl9A5OtV5XMJfIP32KdyhIhx1mr8TF0d2ABNDgZHjhPw5w38sYuGGYnYm0s1yfE9Egj8YMqJizP1LR+lXNXw6Uve/hcI9ows91auRjIsmoHCE7UTu33LByn5tK7cxyPxAEh5GiNKfyLwHgLr5re+us/R+R2fkboZeb2ZZusVLTFIZpA1Q9PPqAAsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvgygobG73hy7zW6S9IQ2wrx0C/k/5jekklUxTpN/RU=;
 b=vVlcc5/Dpqz7CSPgRyZj0eJqcxpMi+n1iAoN7436POrmRQwGapcJBzdw8s3pBDbFsYxe0JzDvt5NG1wCyAHw+KQvWReSnykdqAfYOZ7hi/djx/DbY2/7gRbhzYFwkUzHgBOkCW4muNa5MWwl2aamlPWa/2autobyz31xUCSyL6pomkD1abVByRr0RS3+fUD7JsP90iwFh3IgohFP8iIUAliiOoehdCM5udU4UO64IEjb1w/XEJw64FMU3aROGdoU2se9phm6tpUDX7D3BUGqzJyWqAqdynjxbybk4nCKakqbP4vHw+QEJu9i7GTcH1HQMPsniWsqjgcF9OrUAY13vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SJ5PPF8622363CD.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::83c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:44:27 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:44:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Marcin Szycik <marcin.szycik@linux.intel.com>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Rinitha, SX"
	<sx.rinitha@intel.com>
Subject: RE: [PATCH net-next v2 10/12] ice: add ACL reset recovery and NTUPLE
 feature toggle
Thread-Topic: [PATCH net-next v2 10/12] ice: add ACL reset recovery and NTUPLE
 feature toggle
Thread-Index: AQHdRtPuxSsjGL0k7E+dg1YcwgP+YbbUe1Qg
Date: Fri, 18 Sep 2026 15:44:27 +0000
Message-ID: <IA3PR11MB8986B96B0927FE2CC4870E61E5872@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
 <20260917183927.2692068-11-anthony.l.nguyen@intel.com>
In-Reply-To: <20260917183927.2692068-11-anthony.l.nguyen@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SJ5PPF8622363CD:EE_
x-ms-office365-filtering-correlation-id: f2c3dcda-9998-4ad6-4588-08df159bb8ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|11063799006|6133799003|5023799004|10067099003|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: IK9ulc5mqim8ER8732G2kqaxx3TvABARCaX7OxkK9Vx3wux7HwU82gca6x6C8K0OnjsxwgLVUUNBMUii+8mABIpb85HnIP9MdhRTtnLCKWr2gj55W9vZ1eDDmLAFtO2JxB0E6IiV8bYrTM2t64m4xoi7dhPQ63A2e7HOqKARS/V0aEZbTq1KNmqaIovplxqL5h+jg09KmT/5GXklImZwlglBUAHvhZ5hElkTYcR1KH4C1PI+/sGQmh3G0OYI9snFiPpH5zHY4+0beZ2MzhJ2DXpM7ftZ8ewwRNtnnPgvBIVF4uPzEQ/a9tkT+tR98leZ5goqzW6kyqYtcjbaZtgrKdOnK6fUDRReZ9N6vL9dOCxhgD3hgkFacrw2bcBclpYBi2DZFsz4omd3V4wrtPt4F+E0Xalqeq/HytZ5yIjvlMQRwv/QG+HDg0B0GbtethQWgNMn1Ss0skpRsxgHbpVZ0qeqYv9AawrnUrv2y25yMOhJtEn7KCvwzkHo4Kn9Xm3Kbd1buVaLW0Am014AhpC+PTEw17k0AzTt+v7yk9UXfAMkHpqvlJ8ZtNeMX0y5dEq+AWoJIuJRyN4y0WPbQbhnnzO2WT/YxB/247GPb+XEi34cvP2b4U1UaYp5rxm/L2i9x1HRy7sIcrKMszjPr2/I3K6eJA4hzV3UpZDr9FAY4Hxx20k5MZB891W7waAhnLELH5DEsesJauoQ84lvs7iB959RKxQj51M/2Ko0xvAZeRA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(11063799006)(6133799003)(5023799004)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fU0ieVHZ9cKkLO8Me/R3xnsEgi6e+Ujp9W5XV638i71N7koZiBmf5wJRGIZt?=
 =?us-ascii?Q?cFIXcF9mKXiy8eutE1PM52wuhTiUIeqABuqK3sXvIhdoc3jg/ZJHA2vj1fKb?=
 =?us-ascii?Q?Cd7HmfWfSEq+1gWYDeCYV1QWYCoe0l4RpaNVqzNzLV57qfAWEMQtkjy7fEoZ?=
 =?us-ascii?Q?OzBuLpeMXBWtm6JenNFwgAug611WkyTE6se3KcdhWVEFIIXsUvVycjdA3NXe?=
 =?us-ascii?Q?qO1MuzHA0jG2x6PWOOTlisaVKjK2bNn2+lIdPTEq/ny1vUEpMrZ1mjVKrn8P?=
 =?us-ascii?Q?kS+G7S3DWGf0l/7HN0IUhLcdLKmlc1StS0qe2QaMgNpL04x/Y3Q4zFkm34cs?=
 =?us-ascii?Q?xrdiiWiAeARCPEldl8jAnjJdFukjnu1xcJmRuoqZ1iiFnaTxRBG8Qyaw3fqf?=
 =?us-ascii?Q?ILRZ/zvHXonh+GQsjOZjnSjsoUm7mJhVnPtYHcKejq+VlsPuOadIHzGdq2pr?=
 =?us-ascii?Q?IwjF6qtP/FWEX1c/NpVxvLElaaRjr6xbH0qtTN4a67pmg2nBBC3GOiy8e51r?=
 =?us-ascii?Q?6p13iczsnEDzQwr1kdttcH0ENBF429+PAjOXqUyX1SiX72fjl5mBaE5GC2JD?=
 =?us-ascii?Q?FtMkeLy4xoHHDrskZG5uYRsPD/u09FbtcUxVMEuBpKgCDR2dH7AFKDobMrQe?=
 =?us-ascii?Q?Nm44BEmS4gOFNsjMBwfiNO/zdkJIizWFM4xAQnvOkuQZQMBzYTlsG4ImLORj?=
 =?us-ascii?Q?qmtqqFZOcNvXt6iz8z3Ie/s0wrBCRohistI5QzQkQv/5s4+vnxtOKEuUySlh?=
 =?us-ascii?Q?EnBFJK93nhzF9Nqr6f7eY0+8jChwhPKncAgT1JJwg3/yj3TQeKE0PrAz5cX3?=
 =?us-ascii?Q?0t21sbAIAILsQf866C4eiMW7R95Y6Avfb30c460dBZTLxhIrHJpbum9iWs4K?=
 =?us-ascii?Q?1c8FupLhvxnq14xQjNeu6WhKXVUwG9fljxKEYH6R/IwijWIF6PI2GlC9O+bL?=
 =?us-ascii?Q?ZhhREcqVMCueg7HaiN8G6V7dNKnJF39syC37vbj1IKlY03QybqZxMCPcbEm8?=
 =?us-ascii?Q?ff86bn1m+qaYCaSKzaw5QEOeMPd11kQO4JiD25VTUvuxW46Hn/eTsYTeNeh6?=
 =?us-ascii?Q?PcBFVvr2IzcAgLZooguZHOcka53AIv6big7gXiZPfh+xVBPRdfcDteCTALFm?=
 =?us-ascii?Q?KSv51oGR5YuaTIElyd6e+AWZVAYJLZHb51K+ilo9K3UJ7unJ6hMTHFGiElcV?=
 =?us-ascii?Q?n5z6VEz+iinETxu5seJNobjFXtNaaq1ZKsMizdsIEqsCgrrnElWoazO8xNKR?=
 =?us-ascii?Q?PMSuIxybEandJEpoHLNS6cq2Ncj0Y6FCqM2THAGUcgB7IUxwSc+3hsIupIqu?=
 =?us-ascii?Q?KkU29TRbvvDWkZqD/ah0FAjjNFKOMBTWsOWtJ9dM9wapviqU2YccR8/bAiye?=
 =?us-ascii?Q?MM53NLpxvD3sRELMAdjz+Jv6Ite+t7oej6E3N5dptySLjS7Y2beoO74FFuR/?=
 =?us-ascii?Q?kFKl6XrEf5Zrm/cJ9vzeT/8oY1NPqP31pbtgdXm87j4gP5MzroOCUCa5ZWpk?=
 =?us-ascii?Q?/Bye15oKz4uV+DdZJx4P2BHu8m/oa8c8g6CLw4KTLUmhCWQwQZho263zWza/?=
 =?us-ascii?Q?8cn5YSosPKarWK56iIv6tgALKB3i1GGNfKFaHHhXM+wYzzwDb0UIqsBBNkSN?=
 =?us-ascii?Q?V9tHhSmMcX568TiwZKuVHLDLRIpSoTZuBAfX/uzVRGpV/Lq7P8AwsqTPi7mm?=
 =?us-ascii?Q?p2j9tkj+gP5mOwIXzdEQKFpmpgPZ65uDcfP2S9AN4h625GLnk6mDQYPBwgK0?=
 =?us-ascii?Q?xnKtNRCRLJ2gqvS2m9x2hfq/P0VEiv4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OudNSBByvWw+eLfRa/KQPvERJdHLKvrjJIASTfCUHiO1LSIitrL3kybXlx5rouOiYXormz72i0b4JzrJHc0eMQLq5stYb4qb61904GSiGHU14D5NYH68kWmZZe6g1Y3pyufsog2Z+xaMGugjH8sjWdW29awWjDI2aEO+LLdswpeSDrlRjipT+cFAidd+EDAvRMCIzwp27tM4KGhD5xWQgo6QRML++MN9fDsFFGWJByg8Aj2p9ZilXtKO4+jS+iP2pCVT2U3ehMv3qLjfsWJHcV+3p3G+6dNTG4ZZxw7FhAZIeM8rZcKW2Ag5gS/bpwxB3dcLwwhsjXGOY5Mx9N9/iQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c3dcda-9998-4ad6-4588-08df159bb8ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:44:27.1893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8j+YLQqT5VYzZO35ifCaQESdIuE+4cbXIwfJFkgHOQsDeTIpaPyNhpOCbMnoJ+dWqo8yrNnwkyvS5CK0v+yoEITwFwE/d/aU3Si689BvakI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8622363CD
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Sent: Thursday, September 17, 2026 8:39 PM
> To: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> edumazet@google.com; andrew+netdev@lunn.ch; netdev@vger.kernel.org
> Cc: Marcin Szycik <marcin.szycik@linux.intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Penigalapati, Sandeep
> <sandeep.penigalapati@intel.com>; S, Ananth <ananth.s@intel.com>;
> alexander.duyck@gmail.com; Rinitha, SX <sx.rinitha@intel.com>
> Subject: [PATCH net-next v2 10/12] ice: add ACL reset recovery and
> NTUPLE feature toggle
>=20
> From: Marcin Szycik <marcin.szycik@linux.intel.com>
>=20
> Extend ACL support to survive PF resets. Add ice_acl_replay_flows() to
> rebuild HW flow profiles from preserved SW state, and
> ice_acl_replay_fltrs() to reprogram TCAM entries from the SW filter
> list. Wire both into ice_rebuild(). On failure, don't fail reset,
> rather delete all ACL filters from the SW list.
>=20
> Reset per-profile HW extraction sequences and range checkers for all
> profiles inside ice_acl_create_hw(). This state is separate from the
> TCAM entries and survives a PF reset. Explicitly clearing it ensures
> that the old configuration is erased.
>=20
> Add the ICE_FLAG_ACL_ENA PF flag to track ACL status. ACL is always
> available, so set it unconditionally in driver initialization. Use the
> new flag to track the NTUPLE ethtool feature flag, alongside Flow
> Director, as both blocks are used to implement ethtool NTUPLE filters.
> Like with Flow Director, disabling the flag deletes all filters, but
> enabling it does not reprogram filters.
>=20
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at
> Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  4 +
>  drivers/net/ethernet/intel/ice/ice_acl.h      |  5 +-
>  drivers/net/ethernet/intel/ice/ice_acl_ctrl.c | 43 +++++-----
> drivers/net/ethernet/intel/ice/ice_acl_main.c | 47 +++++++++++
> drivers/net/ethernet/intel/ice/ice_acl_main.h |  1 +
>  .../ethernet/intel/ice/ice_ethtool_ntuple.c   | 79
> +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 47 +++++++++++
>  7 files changed, 201 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 61a320eaf3c5..fcf1130f511f 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -503,6 +503,7 @@ enum ice_pf_flags {
>  	ICE_FLAG_DCB_CAPABLE,
>  	ICE_FLAG_DCB_ENA,
>  	ICE_FLAG_FD_ENA,
> +	ICE_FLAG_ACL_ENA,
>  	ICE_FLAG_PTP_SUPPORTED,		/* PTP is supported by NVM */
>  	ICE_FLAG_ADV_FEATURES,
>  	ICE_FLAG_TC_MQPRIO,		/* support for Multi queue TC */
> @@ -1019,10 +1020,12 @@ int ice_init_rdma(struct ice_pf *pf);  void
> ice_deinit_rdma(struct ice_pf *pf);  bool ice_is_wol_supported(struct
> ice_hw *hw);  void ice_fdir_del_all_fltrs(struct ice_vsi *vsi);
> +void ice_acl_del_all_fltrs(struct ice_vsi *vsi);
>  int
>  ice_fdir_write_fltr(struct ice_pf *pf, struct ice_ntuple_fltr *input,
> bool add,
>  		    bool is_tun);
>  void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena);
> +void ice_vsi_manage_acl(struct ice_vsi *vsi, bool ena);
>  int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc
> *cmd);  int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct
> ethtool_rxnfc *cmd);  int ice_get_ethtool_fdir_entry(struct ice_hw
> *hw, struct ethtool_rxnfc *cmd); @@ -1040,6 +1043,7 @@
> ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
>  		      u32 *rule_locs);
>  void ice_fdir_rem_adq_chnl(struct ice_hw *hw, u16 vsi_idx);  void
> ice_acl_rem_flows(struct ice_hw *hw);
> +void ice_acl_replay_flows(struct ice_hw *hw);
>  void ice_fdir_release_flows(struct ice_hw *hw);  void
> ice_fdir_replay_flows(struct ice_hw *hw);  void
> ice_fdir_replay_fltrs(struct ice_pf *pf); diff --git
> a/drivers/net/ethernet/intel/ice/ice_acl.h
> b/drivers/net/ethernet/intel/ice/ice_acl.h
> index 0c8163e585d9..65e16ad1c783 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl.h
> +++ b/drivers/net/ethernet/intel/ice/ice_acl.h
> @@ -6,6 +6,9 @@
>=20
>  #include "ice_common.h"
>=20
> +/* Maximum number of ACL HW profiles */
> +#define ICE_ACL_MAX_PROF		128
> +
>  /* Marks a PF scenario slot as unused in the ACL profile extraction
> table */
>  #define ICE_ACL_INVALID_SCEN		0x3f
>=20
> @@ -124,7 +127,7 @@ struct ice_acl_cntrs {  };
>=20
>  int ice_acl_create_tbl(struct ice_hw *hw, struct ice_acl_tbl_params
> *params); -int ice_acl_destroy_tbl(struct ice_hw *hw);
> +void ice_acl_destroy_tbl(struct ice_hw *hw);
>  int ice_acl_create_scen(struct ice_hw *hw, u16 match_width, u16
> num_entries,
>  			u16 *scen_id);
>  int ice_aq_alloc_acl_tbl(struct ice_hw *hw, struct ice_acl_alloc_tbl
> *tbl, diff --git a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> index 0ee86236bc37..4ea08bd9784c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_ctrl.c
> @@ -877,9 +877,10 @@ static int ice_acl_destroy_scen(struct ice_hw
> *hw, u16 scen_id)
>   * ice_acl_destroy_tbl - Destroy a previously created LEM table for
> ACL
>   * @hw: pointer to the HW struct
>   *
> - * Return: 0 on success, negative on error
> + * Continue on AQ errors so SW state is always cleaned up - e.g.
> after
> + a reset,
> + * where the HW tables might be already gone.
>   */
> -int ice_acl_destroy_tbl(struct ice_hw *hw)
> +void ice_acl_destroy_tbl(struct ice_hw *hw)
>  {
>  	struct ice_acl_scen *pos_scen, *tmp_scen;
>  	struct ice_aqc_acl_generic resp_buf;
> @@ -887,7 +888,7 @@ int ice_acl_destroy_tbl(struct ice_hw *hw)
>  	int err;
>=20
>  	if (!hw->acl_tbl)
> -		return -ENOENT;
> +		return;
>=20
>  	/* Mark all the created scenario's TCAM to stop the packet
> lookup and
>  	 * delete them afterward
> @@ -898,44 +899,38 @@ int ice_acl_destroy_tbl(struct ice_hw *hw)
>  		if (err) {
>  			ice_debug(hw, ICE_DBG_ACL,
> "ice_aq_query_acl_scen() failed. status: %d\n",
>  				  err);
> -			return err;
> -		}
> -
> -		for (int i =3D 0; i < ICE_AQC_ACL_SLICES; i++) {
> -			buf.tcam_cfg[i].chnk_msk =3D 0;
> -			buf.tcam_cfg[i].start_cmp_set =3D
> -					ICE_AQC_ACL_ALLOC_SCE_START_CMP;
> -		}
> +		} else {
> +			for (int i =3D 0; i < ICE_AQC_ACL_SLICES; i++) {
> +				buf.tcam_cfg[i].chnk_msk =3D 0;
> +				buf.tcam_cfg[i].start_cmp_set =3D
> +
> 	ICE_AQC_ACL_ALLOC_SCE_START_CMP;
> +			}
>=20
> -		for (int i =3D 0; i < ICE_AQC_MAX_ACTION_MEMORIES; i++)
> -			buf.act_mem_cfg[i] =3D 0;
> +			for (int i =3D 0; i < ICE_AQC_MAX_ACTION_MEMORIES;
> i++)
> +				buf.act_mem_cfg[i] =3D 0;
>=20
> -		err =3D ice_aq_update_acl_scen(hw, pos_scen->id, &buf,
> NULL);
> -		if (err) {
> -			ice_debug(hw, ICE_DBG_ACL,
> "ice_aq_update_acl_scen() failed. status: %d\n",
> -				  err);
> -			return err;
> +			err =3D ice_aq_update_acl_scen(hw, pos_scen->id,
> &buf,
> +						     NULL);
> +			if (err)
> +				ice_debug(hw, ICE_DBG_ACL, "scenario update
> failed, status: %d\n",
> +					  err);
>  		}
>=20
>  		err =3D ice_acl_destroy_scen(hw, pos_scen->id);
>  		if (err) {
> -			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario
> failed. status: %d\n",
> +			ice_debug(hw, ICE_DBG_ACL, "deletion of scenario
> failed, status:
> +%d\n",
>  				  err);
> -			return err;
>  		}
>  	}
>=20
>  	err =3D ice_aq_dealloc_acl_tbl(hw, hw->acl_tbl->id, &resp_buf,
> NULL);
>  	if (err) {
> -		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL
> failed. status: %d\n",
> +		ice_debug(hw, ICE_DBG_ACL, "AQ de-allocation of ACL
> failed, status:
> +%d\n",
>  			  err);
> -		return err;
>  	}
>=20
>  	kfree(hw->acl_tbl);
>  	hw->acl_tbl =3D NULL;
> -
> -	return 0;
>  }
>=20
>  /**
> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> index 171b7bf8519c..d13e8bc1b701 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.c
> @@ -236,6 +236,53 @@ static void ice_acl_set_act_fwd_queue(struct
> ice_flow_action *action,
>  	action->data.acl_act.value =3D cpu_to_le16(queue_index);  }
>=20
> +/*
> + * ice_acl_replay_fltrs - replay ACL filters from the SW filter list
> + * @pf: board private structure
> + *
> + * Reprograms ACL TCAM entries after a reset using data preserved in
> +the
> + * SW filter list. Relies on ice_acl_replay_flows() having been
> called
> +first
> + * to restore the flow profiles.
> + */
> +void ice_acl_replay_fltrs(struct ice_pf *pf) {
> +	struct ice_vsi *vsi =3D ice_get_main_vsi(pf);
> +	struct ice_hw *hw =3D &pf->hw;
> +	struct ice_ntuple_fltr *f_rule;
> +
> +	if (!vsi)
> +		return;
> +
> +	list_for_each_entry(f_rule, &hw->fdir_list_head, fltr_node) {
> +		struct ice_flow_action acts[ICE_ACL_NUM_ACT];
> +		struct ice_acl_hw_prof *hw_prof;
> +		u64 entry_h =3D 0;
> +		int err;
> +
> +		if (!f_rule->acl_fltr)
> +			continue;
> +
> +		if (!hw->acl_prof || !hw->acl_prof[f_rule->flow_type])
> +			continue;
> +
> +		hw_prof =3D hw->acl_prof[f_rule->flow_type];
> +
> +		memset(&acts, 0, sizeof(acts));
> +		if (f_rule->dest_ctl =3D=3D
> ICE_FLTR_PRGM_DESC_DEST_DROP_PKT)
> +			ice_acl_set_act_drop(&acts[0]);
> +		else
> +			ice_acl_set_act_fwd_queue(&acts[0], f_rule-
> >q_index);
> +
> +		err =3D ice_flow_add_entry(hw, ICE_BLK_ACL, hw_prof-
> >prof_id,
> +					 f_rule->fltr_id, vsi->idx,
> +					 ICE_FLOW_PRIO_NORMAL, f_rule, acts,
> +					 ICE_ACL_NUM_ACT, &entry_h);
> +		if (err)
> +			dev_warn(ice_pf_to_dev(pf), "Could not reprogram
> filter %d, status %d\n",
> +				 f_rule->fltr_id, err);
> +	}
> +}
> +
>  /**
>   * ice_acl_comp_rules - compare two ACL filters
>   * @a: first ACL filter
> diff --git a/drivers/net/ethernet/intel/ice/ice_acl_main.h
> b/drivers/net/ethernet/intel/ice/ice_acl_main.h
> index 6665af2e7053..54053954b244 100644
> --- a/drivers/net/ethernet/intel/ice/ice_acl_main.h
> +++ b/drivers/net/ethernet/intel/ice/ice_acl_main.h
> @@ -6,4 +6,5 @@
>  #include "ice.h"
>  #include <linux/ethtool.h>
>  int ice_acl_add_rule_ethtool(struct ice_vsi *vsi, struct
> ethtool_rxnfc *cmd);
> +void ice_acl_replay_fltrs(struct ice_pf *pf);
>  #endif /* _ICE_ACL_MAIN_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> index 0ac44d38fdbd..fef8640d23fb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
> @@ -527,6 +527,37 @@ void ice_fdir_replay_flows(struct ice_hw *hw)
>  	}
>  }
>=20

...

>  	if (vsi && vsi->netdev)
>  		netif_device_attach(vsi->netdev);
>=20
> --
> 2.47.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
