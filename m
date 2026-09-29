Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F73955DC;
	Tue, 29 Sep 2026 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665691; cv=fail; b=dbLa9aCmYcEDg+JXv4LLXsxIIOHLMH7oo+xMG35FHFuhTVZw8y7lRt+DPLnKg4xVmqxotFefJ5MQfzQ0VUn2HxjTfZG9PEsyZpUxyauvPQZCqriXeV2CXRlwgqCRsOfFYUWkgxaxFdKim2N7pHyax1mbcL9fAOfmCpb74g2LThI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665691; c=relaxed/simple;
	bh=rPP6mmCHnA9/vGm5ZRqPBYbmjf89j2RwHuknlGYoBrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O3TQEeGcXQmCkYfrH9dDgGP3IcAse4B5zZoEE55VMAYJ6mSa6vSgvGmu65K/wdLHlNo0bLl3z7my10Xv42gAUQDahm2JBEbpqRcdEBt2Jh/JWjaJc1uoO0CZxQxsVHcDpZ8eCiLciay94Atxyqc8zCg7gCAF+RTehvnvLvfE4wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3lAinGZ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3lAinGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790665690; x=1822201690;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rPP6mmCHnA9/vGm5ZRqPBYbmjf89j2RwHuknlGYoBrc=;
  b=H3lAinGZpyNBP4EGh4wp0lp0nlIdtQtACJASoqP2NB8DkoHblCJeqFwD
   nOTHNDuQJArVRcVctpeCu2d6sLG5c8HpkZ0mbPX/aVtW3LCBdk4/20Ewe
   xVs44hVufIcBHGxOZkvSl7uaXFxz/EMlH4JSyUpWhYMAgC3aVh2fMM1MX
   8w4yklRi4vVCfAqRRq4Z2mq3bIrpUr47JoLHAI8Lix4GEhbrFVbCePBvu
   h/8Nd8hLkgzvfAvAdx4DTh59QV0args+ZghBrqXBgWpVRfDyjtXKFMpPM
   /BcQhQfLmotoy7Dc36gO6QnZq/zZKuRUuZ2m4lo8TSK9D/cU1sL+MNTBL
   w==;
X-CSE-ConnectionGUID: rhCvoznGRTO2uSIP7d7tMQ==
X-CSE-MsgGUID: vYeW5llfSCOczerln90UKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101542401"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101542401"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:08:09 -0700
X-CSE-ConnectionGUID: be+PZ8pLQfyjHHKT0xbtyA==
X-CSE-MsgGUID: ttiK9VMxRTeyILqf/5/2Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="271771784"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:08:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:08:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 00:08:07 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef1OxdfPTLfPjLoy37riOrPYynXwTq8ZN7Tie93LV78NqIzHZ1qlcHB9JyL1rbvZmK3F3b1xSduW5Vg2xM0MZknBFFnZWv1qMMyQNInMdvKmffFQsGrmDF/TR7RMJRKxdtsbUtAA4x6HEvHGFY4txrwEBu1veHDF3XAJ+K1CYO3GKo7VQhD/dlwF2kVZnT5JI4TP9Y5PKUwG8jZKGDn9Y4zdFJPyf+MLDIsHFqX4SMGZQJipjM/aMUKxIKaiAvtPUDEGXE27bM7FK2l11bDKQ3s5G+jEbcB3jY+VYUjL4RB1r2YNEoN1TPA+cFwBJMPCms4CS4E4BSwo//9/4AuVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bL0RX9E1XrlsSgQFrKJ3BXF6DMxdV7P/hZ5dT83+2M=;
 b=LINQi7dEUUyI2Ub+jHASFhaOzkapfbh6Yv50Gd2iAkiENmm3FQX4P9cFpNGrVks47XrytxisnUaQvOYuRqKJO+hi/PCimliV3/tlJSQ2CxTmb85lzFTQQldI7rI1AZxuS8EWxZz0aZr9fghHanaSi91gBJ0Sgktf90fyoOKngqcNsEv1hHxkn8vyDYu2J5Kh0ZNFoXrX/jZB4DSWd1UZJ5iVoMAa7Ql34nKTwQeT6LkQbJyBIQW80ZkPTZK9tDF+s909da6snBhgAyD6rGsoywj8PH4SPf7KeU46eKAiokt4nQXvKp2KRNCqMgnpaju125fMIXjmO11PId+NW6Kg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8511.namprd11.prod.outlook.com (2603:10b6:408:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:07:41 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:07:41 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Hongyan Xu <getshell@seu.edu.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH net] net: e100: cancel timeout work during removal
Thread-Topic: [PATCH net] net: e100: cancel timeout work during removal
Thread-Index: AQHdT08Lu9l88thpV0KuKLwQXrVYOLblI8HA
Date: Tue, 29 Sep 2026 07:07:41 +0000
Message-ID: <IA3PR11MB898623140BD84D12FE2234D2E58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260928134121.826-1-getshell@seu.edu.cn>
In-Reply-To: <20260928134121.826-1-getshell@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8511:EE_
x-ms-office365-filtering-correlation-id: 918e446f-952e-4dd2-7cb2-08df1df85a22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: x8Q3stj5Z/K7psQji+pp19o4jn2wvMij9buwewfY/6P7ZLJoEC3IZhjahLiPqhiAUPTZnc94SY2pdQZJ3aPBaSfVsaCG1fluLcglgr+FBDDv/SCxb8vy/vQ9yj1ZfYw9rAZmtGdYVJ9B7DFh38x9I9lhcrsJyVQSla8u+3hminQroxwjBSBQRAbNX2V9lxDZwcA7fCwA/EPzLySuM/umgLs+RCzMZW/0qnrr1qv32W3O50O3cLmuYQyW3fc5aMnongP8ObbVLAY7DB9molcGxc+egpgLiDGvkSysfx/fB+67EABdIHnAkdVDI9c7DeOMmBCx8r39i5JklOhWdqHwFIgvVC00UB173RScuhjn1S/T5wyWil7xiOB/Eid5pYKq0FoEVjvM5KugSVlXGdD/95wznF//zrHlGzZTioxuEkWfSJNvw0xeJk6tKXGcAee10NgsxpXiLM5iey8QdkFEpcrjfUOPlcQ9rjLNMD1aq1tlE+KS9uUx+aQjiEWlSj7KrnIVSZiosgAjkNFKX/T+lsormt0AWjz/He9M57Xz6EcLN3YuPzHLrblWoPNUpdyahgFnsiHJNYP5x+IqM81eQOxbmsrwu8XpmnGapOT5F2HCHB5XkEo5de2s01wKknF6fbTFinb+zEUgfrnDahQkovKvDi4/oyOzvKlypaD8SFQM/7vdDYmM1FBkhZb3leDk42TcyouXRY28qxdENfq9c8Zk8JV50EWPjyB+xhD/A7Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YZKApI8EQRgpnWuo5NL9yzjLGT2hzJTozHZKqJUK8Xli4b0m6uSgxMO93s/9?=
 =?us-ascii?Q?DDdrp+WRxb/EyjOMJz2Rdho9YF5aMqucAVKT634SWEYfoHeT+o1btyr3f0QB?=
 =?us-ascii?Q?cyRVmmXsoXDE3uIZ2w4p7SSYVgO2V2ArAfPu2vu6pAyKfPiZJ7Tatx0Yr18n?=
 =?us-ascii?Q?Oub893nRKrEj+KdUbcI+O6jBQdyouNHACHSVKRdVgletwApBeAERPPq9wDfD?=
 =?us-ascii?Q?M1HSi0vmlz3bllVTMnf1Fu0EgeQzvO65sOoC89jxbBkbSuciyzLFL5XMap8T?=
 =?us-ascii?Q?kwRv1x1ABTHTGMleJdOkUpn1QPo5A4lu6mxHjS1F5/yOfKcb4c8bXeihm5tg?=
 =?us-ascii?Q?x9yUk9Nfm9RwoK9iSMd0SDaSDL4lbHwGMuWUesihqj3JL/WPTG7Sk9AUKpC3?=
 =?us-ascii?Q?Jnl4yDQXBmvuG6hSMxOq+D6bClotHmhrURJu8JLeS98NymxKOhkefDkLijKn?=
 =?us-ascii?Q?SXLL1yCF3BHv7g6Bkicvylkog6CW7avQo/WcqRLL7ka5m8L4xRUPRVMzIsjS?=
 =?us-ascii?Q?KTJDtCOHpAFS2ctBUbc+m1wGhMoIEhFCCKeapBbiJiEqTIsffdlD+CYxF5OR?=
 =?us-ascii?Q?FggOWgmPl2CjPgFYvR1JW4b7kpE+ER/YcHHk2fUI6bx22n9MsG9ATy0J0EGd?=
 =?us-ascii?Q?ZUIRgCDouDUUqwSfZJuATA9okY9qqRK88eIKFvUd6+62CPtPJ++hfpJm/K1H?=
 =?us-ascii?Q?cgmdoaUL3XENXt86b5FjWMKhOT40DnHZFQwCMPjzd0HG5P3SukiRvnJ/KyAO?=
 =?us-ascii?Q?WAIML3H+ncbIFKEkVd5sn6sFAgE2BJyLuE8zrW6lV+xMzJalYNzsey8gnc6k?=
 =?us-ascii?Q?g1+6r/4kjFcC2rDUQbBK8EYgTzStrItEGYSgtBy+YoWF/Fd6pgUtsSjoK4mh?=
 =?us-ascii?Q?BKz1RGDiTn/QSbba2E+BkYKKz2gwFsR97W0yu7cHwoNprO9Km2IrfYOERzS0?=
 =?us-ascii?Q?DKnxiawGf4yTJIO3ekvjAGGDGPVYysAZNqrmzhwrifQ5Pyrmk2xCg9hujdFA?=
 =?us-ascii?Q?wgPo5bBN6R0Rd46A1WJLInCJjf4+wJRjg0EOK0k9nCkEaka60e//jtilYf7e?=
 =?us-ascii?Q?IYM1fMtp+3xhgDIjQCuPZvVv58CpavwI2MK6CsP1+sAKnZwzFrVHCvEvbMEv?=
 =?us-ascii?Q?2X+kwy/rF+neWeKAsK3fHbcE0P1A9jiEa69sLPzNyMPCCKAYuXAdPwSyXtzO?=
 =?us-ascii?Q?20JUe8GXrjmaaHxa5+4eYM+7Y2+Gy24/IvNOCX6b7SD044iiVrRgICsDa0yT?=
 =?us-ascii?Q?MnUuhR6KSQQP2SovPvJH0jB78JfDDvoKJVsUtuotg3s8wv6NjzpshDOyMmVc?=
 =?us-ascii?Q?1etomDcdYvxKaX/7QylPWAy4UBXMhDQWyYKj2i2RFXYvv4DT8qtR/A1cz3dq?=
 =?us-ascii?Q?Ce5c0252t8Yq4qbo7BVpJh24CcNHNIQqc7D13p4InAmCiNKA/3V2iQTHR4pr?=
 =?us-ascii?Q?Urh6J79loyWmfKXf9TTXq2nQok6UX0M3gbcDLHJhF9UTyDRe0+fQ1EdsFtsY?=
 =?us-ascii?Q?CpNCViN1gVVuG/26ITJ+sJV3e7Cjf+q+SLbskivd2x7/88Bt34o0h6PiITMZ?=
 =?us-ascii?Q?30Mln7vs2Fmr74/yhHb/aaOlfDIIZryPkreU1+pYCx3Rm07i1Al2x7vyfDRk?=
 =?us-ascii?Q?p6i/iz7nkWEZ62TBChs2r3kRUhzvFdgaJdcgR/yCKd9+MDeoi91jeU6z0RoC?=
 =?us-ascii?Q?xM0Yr2MJKuMFehT24jr2RzeX2AC90K7RqSc7N1S7zxo3YzPo0DSZFrEgRYRC?=
 =?us-ascii?Q?jNOBaf2JSLNNsVFWJ9NcaIB6GHa00VM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3SbubgZO/ztQD6RGPpakmlcYwHSOW4uLdF1xBWkSW8pDPB0SmtkrPdTC6Q346utOuHZPIhUhXQ7GZk7R111Kb7spm/6oNbbIspOOglf+Lcx3wKRDA/+O6Qe3pDPPtJtoO9Ksa3LteZA+k42t0cLHBC6ic+9OgtXSh0rbYvk/Ebdau/hx3TyyJhdpO8Qpc0qLqWltJxjJRgLQ2j2LjkirPQ8GgKb1Nnh3UdLO0c8IDoGDPviVFEFR0ikiLjjTVCW/3YElWHQHV/Hu0G4onO5TwdLD6RMlRKqq6ork5fjJ51RVMW1KhLwwpxMEfJq6VLxA1NFId3ctKsKQmAp68X/XBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918e446f-952e-4dd2-7cb2-08df1df85a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:07:41.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKQoNMkJXyMlWTRJfrXzqkP0Kp+47tkx9Pn/c2cpHwg8xp8xXlVidU7jaxKXdrz1wzAman0iUg2Ibv4iKEVfP/UpOxl7zVwNPfC9S7LLMpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8511
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Hongyan Xu <getshell@seu.edu.cn>
> Sent: Monday, September 28, 2026 3:41 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@kernel.org;
> kuba@kernel.org; pabeni@redhat.com; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> jianhao.xu@seu.edu.cn; Hongyan Xu <getshell@seu.edu.cn>
> Subject: [PATCH net] net: e100: cancel timeout work during removal
>=20
> Transmit timeout and command submission paths can queue
> tx_timeout_task.
> The worker accesses the MMIO mapping and netdev private state, but
> device removal releases both without draining a pending instance.
>=20
> Cancel the work after unregister_netdev(), when the network stack can
> no longer publish it and after any RTNL serialization used by the
> worker has completed.
>=20
> Fixes: 2acdb1e05c1a ("[PATCH] e100: Execute tx_timeout task outside
> interrupt context")
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/e100.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/e100.c
> b/drivers/net/ethernet/intel/e100.c
> index 29960762e64a..710c2c30d9ed 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -2988,6 +2988,7 @@ static void e100_remove(struct pci_dev *pdev)
>  	if (netdev) {
>  		struct nic *nic =3D netdev_priv(netdev);
>  		unregister_netdev(netdev);
> +		cancel_work_sync(&nic->tx_timeout_task);
>  		e100_free(nic);
>  		pci_iounmap(pdev, nic->csr);
>  		dma_pool_destroy(nic->cbs_pool);
> --
> 2.50.1.windows.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

