Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DD3B0590;
	Fri, 25 Sep 2026 07:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321993; cv=fail; b=FF3AhKUCHeWUZafM4jH0iJv3knWXSMkLrg9j+3yLPcX0FwsmOgXoQHFQCgEgB9IHXw9OcFe9LBbQvWiNt6j6qG9GrS1qiMR29A+yNvWzqZobzXmAE/Vi6XgrdqEJthVMJOwVpJK/6muQbgqs7AgNoR9Py/56g5PRk7j2wQWBL6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321993; c=relaxed/simple;
	bh=ywptEh7U7c9LbGBWEROWCKJp3hfrlmrUrDNHdCnFbp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xm0M4xjL0GhfGgPoGLF/WIVs/aLLiA0HlKMCtM+xMfLvWcuLuXATwlul8ApR0JTlXm7jQgfdBtXtbijjxPRp1I3z1NtRV/ApfB5VrO8lVAfZ3vw4aztcjKtky+hp0oJbPylwJzep9jOPZrzvZYJmXdV9UIbPs9sH1HsREQ4Lpw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RP1sdtY+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RP1sdtY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790321991; x=1821857991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ywptEh7U7c9LbGBWEROWCKJp3hfrlmrUrDNHdCnFbp0=;
  b=RP1sdtY+josPoLhy88/jd2B1fYoIEwT+PwvNvirdjJglrZbKvDkSqo9r
   GQUAkO+NvbynD6mCqWr9/MHuc9KsV99RcpXdg/DNqsRW9b4g+iyPpl5It
   Ogqo0KJwbyzgx/iB50qXCgaBIAsaNt/aTndM+XCF9I5Q/thmZNHA6wQNP
   3ezmaNxyaaGXIDi50ihzAVl7nFq/PqPnVK82hpVuivqrkdUm6JTguHTKY
   VWlPeom70C1J2F819OTYz1SbjcgcD8oSsov/n0A5MrebereSM7cesxCOA
   mcW0syhnGZvrXZh26Ncb99joUHhHpSBDu25/hZN1ESxLKbuVSMl3/rWky
   Q==;
X-CSE-ConnectionGUID: i5OHERkuTb685w0KG/52nQ==
X-CSE-MsgGUID: zFcKcKKQQnSQsCNKFYqR7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90324650"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90324650"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 00:39:51 -0700
X-CSE-ConnectionGUID: rVAyGuehQmOw4g8lR7lTbQ==
X-CSE-MsgGUID: jHw1o43cQlaZ82AnK+gQrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="278971123"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 00:39:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 00:39:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 00:39:50 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 00:39:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jnt6987q1ZyYgkkvjzlxGSpaOW+vK2s4HAssi+FZU4/bpTXzVA3Bm081p/VoaW9TBK6RUu8hA+aO1MpNqDjxMimeKEsGfhut7GHk7sTi1HgyVQqMgRQ4G5dZyr7lobIuXx825LJIvpTQUdESj244yJoDj5H9dK/hoPR8maNLJyB6Pjb6tlYPz/d35xz9hGONyVYc50wYGj7JQaW/41x9+z+HT1f8Ff4n49oP+OTnfqWfXUFXT0TcFXSO/LWQjusyU4m/ZN3V609cpBTWQn1NJi/FrQSSf6kCdMdHgAZ2l08Eb+7hjyjUSUgcl5nRHMmFSuoLz1YlHdI5onHFyaZKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbXfvjqmi4RwixhI1j0ZZNmZUwWHpnrQONLGhcWBP4Q=;
 b=eKXio9CksfUsj15BNS555SUdWurdph6497TeIjeMA4GbrZjHNvKYpbzV8xhyFxOEeIE2/BYpYOpx5Nd4Hmq6JXM7FhEij8RhuGozGvgcWUjHuF6DiGNQMv5D6OBiHxUme2uhnRRXMCkzM1zgre3KJ65Sal4sl9XdGbOuRdPNKQFxUMu0FI4bN31ofLGeWyHS8LrUhWe2z2/I4Xnf5ogE0JkH3dfaPBEE6lfl/qH4mbDTgNJkkmZRgJO55foejOvHBJoy/coU+9Y/xfgWwaq4SSCdgI8leAiY1ZswjwXYK3NPEJ9XaeZS9FfgPvAZoDIxGK80XuIxZ6eJ9jdp2ZdRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 07:39:41 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 07:39:41 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, Jori Koolstra
	<jkoolstra@xs4all.nl>, Brigham Campbell <me@brighamcampbell.com>,
	"linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>
Subject: RE: [PATCH] ice: dpll: fix kernel-doc parameter descriptions
Thread-Topic: [PATCH] ice: dpll: fix kernel-doc parameter descriptions
Thread-Index: AQHdTIW84EGz/COH+kiRud9H4tfTXLbe6Pgw
Date: Fri, 25 Sep 2026 07:39:41 +0000
Message-ID: <IA3PR11MB89869762329B21649271ECBDE5802@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260924232138.69492-1-ayush37735@gmail.com>
In-Reply-To: <20260924232138.69492-1-ayush37735@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA1PR11MB6195:EE_
x-ms-office365-filtering-correlation-id: cfba952f-719f-426a-8efd-08df1ad82932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: QtQ41VhWZiNQd54mMJf+CErnkcZ1lnQjPq7MkinfvcnaenmwcakTgjNRb9fcLmikJJBll6Gy9SgydSMLOzIpkHHkK/b+In75UuPCf2k+yU8h3n+JcmiUihbmKtFOc3lYjTV7lh042e5KLsTQ4eX3oFzHbQ6wAWtENRUZoczsYQDZxesSRoArEx1RGbA7J4BRXphyJg/AOak1xHMOZnCaCVg9O2fZI9a9dXvwg9IJ2tBtXbVVOOjOV3QpN7lpGg+t5p36dbjngej0WuoQHucjhuxmduQVlG4ZP8xu6hAu5mn6q7OcDKpYCuRFLPCGjFn4JCcsZsfm9QlxfwmjDQ7QVyDp/vE4S5Dkt5KfabZSY97KF4/liRW4tVtLUZh85uxJEsRd1zL25XQT1wujacGfDe2pLNOwUEC7KiDBpwxLrslak0s6FcYzdRZRD+kgPRMOtIyWg8DKia+ut2jY1VhZv3yA27gdUxVEYrWPVnOQmRbO5olBopXx18SOrTj6whb8JervK1u1xSop9spyHoC5QNdMuk4XagRO8dnXwKt05meBPEPtGGjJpufqFRv4kGXGq+j/iujgEasoBeXmk6B05lwmOjRG+1/CsMkaM/oVkGAJ8v+CTYw1ZlSoHQhmsePbQkj+7LPHNSdr1ibFV/6001VNt3p89Exc3mTOBTIDEqDH39p5h6jkX1cTBTJESVHBW9w68ZaCoobDrPHiNTbh3lycWR/OO/Ryxk7guLG4uqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0n/CJIQs8WgnS+vPtDmKdhrP+53O8Hs7exqSe9u7yP7QQwov5nvDuiG7V/OY?=
 =?us-ascii?Q?EkeXpmzTGykvbjnkmNlAeRyj6gQqKVm3GFg0SyaVp4rk6u13ttkHNLuedmba?=
 =?us-ascii?Q?MNzADjKNYvS2qofysW/TuwLt+3hsAdCl9KUiZuWD/1a9nuIKFL6nedQQKc7p?=
 =?us-ascii?Q?6QDxDap6wNyPKteV7KH0Q6UO7HnvLZkrEVDy2m+XG1AMATI5Y3vndfBNAupw?=
 =?us-ascii?Q?sQBhwiSwXy3bcdXOH+LJIX+OgMcwL9QMKfFGgyxGsEKL2GsptQ2xoFhjYwC3?=
 =?us-ascii?Q?z9TE1QgVGmM1YtdLQGXWAYWW2pOY29pXmeunH/44l6hYJrMQsWz1V2K1uHcm?=
 =?us-ascii?Q?GWk0VKGQ+fcnyckXhv7LcZx60c3hbsaOOBfuketpOzLVrK0gIB1oCVRxmLAn?=
 =?us-ascii?Q?upzmTup6ZN3VJ8+Dum4Hxdd38mv8TXPOxxBs3BZ0OFShEZmP3u+a+/8F7y7k?=
 =?us-ascii?Q?c3LIQffTb10mQ0xZ6zNYsAf96lJBiRZ7IaPeNPCWmjij73r9faxT1c1uKtYM?=
 =?us-ascii?Q?9Q0iSCdItLsgwMulEA+XibRVlg4JTptHR2jtEO/AN3K2C/W0rRR0HvaL0J6V?=
 =?us-ascii?Q?VLEl45Nw80azJr+hXLS9xJ/wyB5aOqH/1BrGQe5TYiFJTURSFy8pMyyDEXdg?=
 =?us-ascii?Q?s4G2uZHigjGBxVf6bvYsh+kBIq7leLai64T4TFU7bmfJ+QzX26vKBPlfTc0n?=
 =?us-ascii?Q?jrFacN0HD5OQxO4EhkA8/4KcB+MYQzPprdtH2/9GgVjcuJ4waFY/7CHk0j4W?=
 =?us-ascii?Q?+LtdDrF0c9pEAA7sT6WT1iUw5Vw38+scYQ4G2RJpA/sR0GzDIayS7dmP5Nrq?=
 =?us-ascii?Q?jACZLn9mVvnRAP/O7TIRNZ2gghPHMXGq64hRYrLQZa3FYsnrMXoZNI7JS7aD?=
 =?us-ascii?Q?rXytKbkdt6lSl1UT2ykc/00pG2xKI9hiZDvBtN9sg8zYxawvxg1fH9+D7YhZ?=
 =?us-ascii?Q?bRje9pIxumC8F2UBwlWmahJfazQ8xU6WdOPk61L3gAhL7mmd0KYs4cCUnBne?=
 =?us-ascii?Q?jRsOoZTDRtSbIVGz/RBCcz8P5Ll4313llVEsn1Yz8sDHBsPFkrdd5QNZWiUE?=
 =?us-ascii?Q?nh30FYWUKOtWGNTBB+ooSrjrhXuWrBQggrhwpJMnM2B9UbkGy9EImYD8XcB4?=
 =?us-ascii?Q?wFlaVh9G/sY7hMIyO17s7JK3F66FLk7q+a9SObqNVkdPHDLtOyuZ5AXHL7op?=
 =?us-ascii?Q?GCD24e/RPSXSZ1hMQq1oQnt7xJQR7OVvXnl9TyGzmNxfEJRjIrd6aXenJmnB?=
 =?us-ascii?Q?Xi4usZAW69L0mpo4u32yc2gJi1bYHOXO9Och/AcEPIcNSXb0QlC2dvpjQLcn?=
 =?us-ascii?Q?/Nq+FpPNIxAAhsScOCKCFIBRtyOMJXJfYQCaFJ2rNIvkkguZZG2aY7Z+rqcX?=
 =?us-ascii?Q?IXOtbJNPDP3JeLPJSKVUnyz36h7QawFFgjbeNeCY1jQY1yYL2mE/3OSTbZ+i?=
 =?us-ascii?Q?ugdm9xjEx6vl66kgXNloygPocfVX8PqyEd5OIoc9cJ/vf3CoKh0HDJZ569is?=
 =?us-ascii?Q?9Os9veF8/LGY8q0VEyD7q1mrBrlmaV8x1VVk5uuDb1PGni7e5XgAXTg5FsSi?=
 =?us-ascii?Q?J30kIr2YJe4QzrQIQ1GyEbwewLE5xgkaVIbBw/96GmWc5KB0pZJssaxLJHSr?=
 =?us-ascii?Q?pYqBePUdPy9B9ynpmko0C1omC6kMbSgwNRsdifJHEezVIzQjCAmCfPfN+rZh?=
 =?us-ascii?Q?Z5dm89NWazziceJCQvwOjP0eF6lIBCWrTjv7/1uVmHcHOT2KnEmwbZR+ABhf?=
 =?us-ascii?Q?hlzwfRuU6Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4Exj4elkcI5AejVmw89fW45JrDSI/RqgztVygIz1wiuHy7yg4VJibWXVI2mc4RkijWgTk2FQBZlAt+O3JNG0w9kYj8dDVCYNrKb7GEm8ng8TA25A4xiAe+ESSbiXsawCE9IVvsM16W7JkCEVfPH3qgL2oGltASG+RQ1KG7Xs3ihCHM2W2CeAigT20seX1iscZhTtkRhGwHIjNdt8f9cPrTSd054xQLXMGQoaNY81aJ8bZf0mFe+gAG8FUeEBLBdZWrcVSuUFZrFMpQMe4FsKzyG9wtJmKgZfToXZFsb1FY4j86dSYbwRmCgRD3HP1zduOPCwVhx6+JIaFmKOIxB5vQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfba952f-719f-426a-8efd-08df1ad82932
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 07:39:41.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkgEmjo9pAyMHWsHYYXQGo1Kkk6wOMpl3PrSJvDwdxXHZixmi3tNpDtHYap1HJil5PlstpB8Tor4s9U27TbAeZ3MIiCZvXBTkvfHLJTWPPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6195
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Ayush Yaduvanshi <ayush37735@gmail.com>
> Sent: Friday, September 25, 2026 1:22 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Andrew Lunn <andrew+netdev@lunn.ch>; David S .
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> Shuah Khan <skhan@linuxfoundation.org>; Jori Koolstra
> <jkoolstra@xs4all.nl>; Brigham Campbell <me@brighamcampbell.com>;
> linux-kernel-mentees@lists.linux.dev; Ayush Yaduvanshi
> <ayush37735@gmail.com>
> Subject: [PATCH] ice: dpll: fix kernel-doc parameter descriptions
>=20
> Remove stale @count and @cgu parameter descriptions from
> ice_dpll_init_fwnode_pins() and ice_dpll_init_pins_e825().
>=20
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c
> b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 85a74cd6ea1f..d00a2fb683d1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
> @@ -3919,7 +3919,6 @@ ice_dpll_init_fwnode_pin(struct ice_dpll_pin
> *pin, const char *name)
>   * @pf: board private structure
>   * @pins: pointer to pins array
>   * @start_idx: starting index for pins
> - * @count: number of pins to initialize
>   *
>   * Initialize input pins for E825 RCLK support. The parent pins
> (rclk0, rclk1)
>   * are expected to be defined by the system firmware (ACPI). This
> function @@ -4025,7 +4024,6 @@ static int
> ice_dpll_init_txclk_pins(struct ice_pf *pf, int start_idx)
>  /**
>   * ice_dpll_init_pins_e825 - init pins and register pins with a dplls
>   * @pf: board private structure
> - * @cgu: if cgu is present and controlled by this NIC
>   *
>   * Initialize directly connected pf's pins within pf's dplls in a
> Linux dpll
>   * subsystem.
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
