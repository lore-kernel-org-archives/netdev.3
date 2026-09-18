Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BE502D59
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746402; cv=fail; b=IPZNN2lWbunEKT8toJjzdFeGgHdffVYwg9RmsINMjp0/hjPfDIvIU707DRYehS7+z32HJoXMsQHbBOVZhxzO/tTwtaFMdqJtKKsW+G/qReWzmbN9jf4Eqsr8tTu58WAN3WjPhAIHbH7ViIgiqsTZHlh1zwt+Gll8/QONSoG8uJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746402; c=relaxed/simple;
	bh=AGL7pZlxsTDieTzhLPXte70skTTmIb8o0HZgksofXg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lLRg7aqrZP0BPceAwUFqlUKiD9YZcOCx3amd22P686+vIAgN26/HB593s2JSKTVL/1Tx29mRrGi9eLLlrL4UGFZd5TFz/q9xCMuQmpSi7GTvt0QWgUS5rhlDtqEuBkEK4jKhBlq6Hh6Mnmny10IpqSRtFm0ykE6kvqyGe+zAjJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INddMe48; arc=fail smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INddMe48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789746401; x=1821282401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AGL7pZlxsTDieTzhLPXte70skTTmIb8o0HZgksofXg0=;
  b=INddMe48d75uuiL648vx4c4fDLkAVEJWRTSrADMcMtXruuliPZn7LLUD
   PlvJBR+hJEaw+ECAOF+bezP+wUXrYaGo8exkl52RK3xJHZ0x/jFPWwIMo
   o0WYNecsEiW5R2vm71LvvA6Ii2sbxVZOtb90jYr1sfSv5H1oTyddD4h10
   lEZZiO6sWQSr+lqWFJXvcvp2aTdgiPkz2R91ePLHgWn82d0jnO83buCm8
   +ICfxYPVCxpPILq5Ys71P89ACQng4db/Rm5d/nsRww9pf4wFrelTMEm3N
   RUoXI8cVLqGZ/90rlcxMRS3m6589GC+i4pR+nM8wsGWqgyFwv4NSYIape
   A==;
X-CSE-ConnectionGUID: +7qxB+Z6TyuVk2W/YuLUWA==
X-CSE-MsgGUID: SDhSl7bYRcmJ74r0HOy+ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="760641"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="760641"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:46:40 -0700
X-CSE-ConnectionGUID: XsOJe29LRduirYcJuOZ3Mw==
X-CSE-MsgGUID: rzb5841gRtWKy+nNEjuqcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2666624"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:46:40 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:46:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 08:46:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 08:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVU8vZLv3PuBa1GHx3i16KgfonvToeLHEQo1dnRGvYWxhYo3/egmIdtfWblOD9rQpz9/BmVX4QmRwTjxaJ7Y9hQekXiGNnfzSu9Sjv6UFi7s32F6GXb1oJdRP0NCII13ygSsZHeuSPkTZ2DvuQksixVhkN5lE62qBgwxunujvNW1L2l8Gqcp6JlziOi1NK3Boe7/XtSLIAM53NKmauPzp9jWImuWbxmotH616O6U+LvUDOPrP85nTowTMOFNkrWBAKIdlNjorszxS26h276gnH2mLx6JHv7kzMmr6COq3/p1OVyUbEH9iJrXrnJqBz7i570YXNc2jBvUxpCxVWSE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uLabEODdpKoc57LF2Eh57tSZv3Y3DFASQTIWjFOlOo=;
 b=lWL+sw50GwB95uu85CcenWeODXyOalRnrhbAmnaOgN40zyLv9aYfyiGksejKcDhiAi9Yz0T218MvOAe0GKwp7tB3PEJDWiUuMHAn61EinDkM8cVJIkb1I6XrbM1iAgTMxlAYv39mfDj8T8EWbQiDsf+pyU1Ch+N2jMG1CSaDxApeWXHpb2B9xr0cOTGY0Prg91+mwccGRP50gf91Z8XBf8fKrRZnCcuMpzYXu7TXP8RyuWz0aj9M8w/P5HHxPqV/wii8DFJsNFbeLT1pKVCPgB/20m/lNXS1B5jdwFg/NWSHIp8OhDJJSN8kqBvxh+dBGpanSzYouwQUDJarNemvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 15:46:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:46:16 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tian Xun Ng <luckilystar08@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Tantilov, Emil S"
	<emil.s.tantilov@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Tian Xun Ng
	<tianxun.ng@bytedance.com>
Subject: RE: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
Thread-Topic: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
Thread-Index: AQHdRr60+XRoKGHE8kGmKqUlul/CQrbUfBtg
Date: Fri, 18 Sep 2026 15:46:16 +0000
Message-ID: <IA3PR11MB898631A5D0F53CCECA20EBF5E5872@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com>
 <20260917105205.37561-3-luckilystar08@gmail.com>
In-Reply-To: <20260917105205.37561-3-luckilystar08@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA0PR11MB8398:EE_
x-ms-office365-filtering-correlation-id: 0e3b9dac-f428-42cf-79fe-08df159bf9c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: b6+ooelI/y5cghFDWYnsVjUYv8usv3yBkg0cpGvwnoFcfYRWVAIvZR3Z2TlXUEnXvGO4sta+ydjx1uTJQrNx4jOVAZ0AWmWXy565KLjN0mlHm2uP7HUpvFpYvhnOGvu4hzo1Bzk+fgBtVl2Y2eA+/M/DG4BEIVkJx1DPZ1vPZYhAiQoLWxEVEDfteJKQkmd5rSqpgjVhnpmzup2pZEK3BY8fjdM4uu1VHZSUw3A7cZfJ1jylGrV+E/v0Rojt2wUUHDNJFllcCYMrQTeTvZF/csOdiGNlDQ6LIUvyhu4wfdZTqNYgYxchLCbFSzp5pEH/DhLGd2i42rbVzsLXb1o3+tuVxqtjVLIpPq2whllYMbjIESCwewOFYkAgCmFq8KAB+3u1iBV/O17MFaYDC7+q+Z1FixDfgk/UvROWlep3JxRq5jOoxoITmr1w2QByvIhFhYmPPdypHBNsH+I2uf/dc9NwW9YbH020pDw5eyTcK4dLfOBYrWZpYlRblP4IZ0wp+s/flpuk8dBaQKImC2cwR7gBbbbRw8CLCMJtx9LB5hlR6q4yBpg5COWi/BvL2PR0TsQdr7EcTJ6X5ZAGPZlFDL8+pY/Masqy4tm8CSC6GonarihJ0aaMYVdSZ8BDBcQrUPSRy4CeUs/mLyRFYkpicSTis/DSBF9UR49wY3IYbZxZ3gDJk3kg/i2uWXYgBw1SdlLcjf4H6/IPYRESLoNK4C8u0nSDZGOgonbMfVAb58U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m8+IDJAWpX02C6zePiMnJlKWyXxv2pc1uXq5ownXeIJvQ9NCziRhp74Dq+7p?=
 =?us-ascii?Q?JwRwpzL3EpdAcykMI8IZStjPQR4tDQmRxq1rdxZ4hcreYUp/q1k12Z5qU/I6?=
 =?us-ascii?Q?LUEQYqkPg7VdxCzqOq9+If1KTe94rwa6lG4665K9LWXu4WICaZX4C8U6cDYS?=
 =?us-ascii?Q?3/3hn1ctj3cOuoD2828vxKaOIr0585eG4dDNgpCVk7/bBHu2rB6KwOX4t30n?=
 =?us-ascii?Q?oXb8Mg9QR60exJRWF+Vii9mzVLOLW/BfhPOEXXPY/pdlS2mKhj+oVM65nSVe?=
 =?us-ascii?Q?6EmmBxd1Vv32VPjqPuvWGo10/utiqs/mxTUWecNbQAwy6I1n7AM012eg+TaD?=
 =?us-ascii?Q?VosmbW57IOHxO4JWwxCVt4ed647V8TSv0wpAi/SllVWzcn03h5z8RuMDxyq+?=
 =?us-ascii?Q?BjFdPQXpqj37ctOugvlilo9QhO57oggndqMu84j02MByXBMtrlUHqD8Lg9bU?=
 =?us-ascii?Q?J03aHUKAByAiYIQFjw+dlR3eeqi2hmUnJfP6TyW8XgOdpaqIRZHupen3L599?=
 =?us-ascii?Q?6Lj7l29pEX9fSB+NjoquyqUUz+SztIWvz8+uF4cHPqv+q0BDA+thXRHzF2m9?=
 =?us-ascii?Q?j3Ljg/+MCoFkOAqGsCcCT0fIdfwbKbOJ95FLO7wsqYGMya3ii28R74Xvg3kZ?=
 =?us-ascii?Q?SX7VA7nZPwu0pBbhFg1uT+35b/Vfsc/NElvlX2a4+hNgMGR1XBPNF6EDLima?=
 =?us-ascii?Q?8jtLYU2aCwLZBvdgO7GpRsU3hWlsV6s6JkyowRvboUpBegmj5FhpcqxGLcHs?=
 =?us-ascii?Q?yntCyfA3fE50L0pIfmmSt01gWuBu+4RQMgxlHaVhjNMjFZ4X0U3be8R5DDmv?=
 =?us-ascii?Q?0gbHW0dp6+UkHVyJUZplE2g8b33LsHGEeLF2SbzMslFsUe5zCzc3lS6Bo1CU?=
 =?us-ascii?Q?dZbYe+/T38NNY+mHa6mz8Q7vjs/wGbfP4bqoMxs8odWsOtwqRd3UGEqPaOG4?=
 =?us-ascii?Q?IiuIxUVYhRV96Ei3V3hmROb6z/Ks/V4IgjKq5lxNa+6g7cW39aKkswEmDuMj?=
 =?us-ascii?Q?VNXrllWiWbaxkPSHr1QDyk8frVMhR1VzpgOQVXelWl5pMnW3IxeUHyTsmDU1?=
 =?us-ascii?Q?sgVC+QLz6lS6EunzupQ4HYbEaf3SmOWRkMnAnv8rt1oHs8qbVikEpKeDzDSa?=
 =?us-ascii?Q?QFkmjqEDUOyB08Gjxo5jXTSwSwCR7bPU/JxIep5Z7mkf+rOwXxCsNx8ry6R+?=
 =?us-ascii?Q?0lbzakbQjIrk4V4mPlFfnn6aUlk8mUSt0jAteLbjkmg1jIlm8F27kOXk5CNX?=
 =?us-ascii?Q?lgGhkErjvlQu3XikGKD94Cd9IBOZ2PQwjkuSq2A7ieE09F2UhiRulamCAZU7?=
 =?us-ascii?Q?s5yHp2qp5bLUVSd+0jrj71tJ9MgtAiSARUytyD/QgWBoOdqYHfYuFjDXpd0i?=
 =?us-ascii?Q?r1YyG7crdrq8LM5I4HZbvC+ucx7BiLEEIC4XRsGkvtujzGax4z7HF24QQfce?=
 =?us-ascii?Q?6X7PQJKdL/7jSzHgi6gKz2EM2kBTQc3jPj2n8bEh3cuB4/j1IJlxIeN1p2sM?=
 =?us-ascii?Q?B47F9l3EYNMxu3WB2YrF+qQtw1kX5WVC1eGnQCxaNsObotMIqQFO8mJpgR4N?=
 =?us-ascii?Q?SG9IzaUmq7y0djsuhvaC1v10Rwf99mS7jewgs8VQe6QEtETwhApkjm2xuOyo?=
 =?us-ascii?Q?CxErBNWIyGFkYYNuuV+dOeNSaEqkECNOOL/AkOWO90/suVRc7b3dhbUmBqbd?=
 =?us-ascii?Q?25DbBM1Fiwwt5cv9Bh8reO2wnF2HlgZKGWaRCyVfFjiW96CReEdvoGKDUDKK?=
 =?us-ascii?Q?3Eyuusq02khmrqdZ3qaUnWD5a/Y2Q8Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cOURboksTe0w9kd8/gM/RRBeTL+X1+q8rRDB0H/PPOKtFj8IF0gRuaxuSQbkw9RfuZ4FMxjL2dWQbBX60+sG13s39kULkVJYy/z3HdBKuh5YZAKzr3pOJdIKnE66//5W01MHqffeH5jMTDJttiJCv199flzVykIQx7MOZ22XOt480SZkjvRZ5MRMa1R6Bro8VWbo2Dfvy4sRMIcsiboVzEmp8unvAZxIZMwp548501+PREuDZWRjgfGIsPsSokkaXlfrjrworgpw96XzSZ7ejoczY3pQON8jgTH+TscNtfwXFHMgvPY9rHAT5FSyKJipCX3vefvIqeavUZyVZ38D7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3b9dac-f428-42cf-79fe-08df159bf9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 15:46:16.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lrJl8t7Sqk99eCeR9DLAD5nles/3cEcOQ0d1NbeP9RoCmt3AKqATOtI2UBgNKLQhMWPmsWjoXBmQEBBzGr1xzEDT82YdtNt8lO6p/jqYnoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Tian Xun Ng <luckilystar08@gmail.com>
> Sent: Thursday, September 17, 2026 12:52 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Tantilov, Emil S
> <emil.s.tantilov@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Tian Xun Ng <tianxun.ng@bytedance.com>
> Subject: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
>=20
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
>=20
> idpf_remove() ends with a function reset to leave the device clean for
> whoever binds it next. Commit 4c9106f4906a ("idpf: fix adapter NULL
> pointer dereference on reboot") replaced the idpf_remove() call in
> idpf_shutdown() with idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(),
> and the reset was lost along the way.
>=20
> Restore it, so that the kernel started by a warm reboot or kexec finds
> the device in the same state as after a module unload.
>=20
> The reset alone does not stop the stray completion writes fixed by the
> previous patch: the next kernel's load-time reset already performs a
> reset and stale queue state was observed to survive it. It complements
> the previous patch, which makes the device tear its queues down first.
>=20
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on
> reboot")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c
> b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 129bccaa6..d7cd449fc 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -197,6 +197,9 @@ static void idpf_shutdown(struct pci_dev *pdev)
>  	cancel_delayed_work_sync(&adapter->serv_task);
>  	cancel_delayed_work_sync(&adapter->vc_event_task);
>  	idpf_vc_core_deinit(adapter);
> +
> +	/* Leave the device clean for the next kernel, as idpf_remove()
> does */
> +	adapter->dev_ops.reg_ops.trigger_reset(adapter,
> IDPF_HR_FUNC_RESET);
>  	idpf_deinit_dflt_mbx(adapter);
>=20
>  	if (system_state =3D=3D SYSTEM_POWER_OFF)
> --
> 2.50.1 (Apple Git-155)

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
