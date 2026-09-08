Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AC231829;
	Tue,  8 Sep 2026 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873224; cv=fail; b=b/oMS1aA/lCw2mZhCEoUw3Tm9BOfsu3hqxUZ3ItZlzp3ejDWWVH6nBdll9lvi1bYVgl9wfwNe1wh2/Dzu52xD4wR5qo/fX4wRGGBG5gFlRaLyY7k/tIXi8sr+8iXuXvsuys4zyOY25U6Z8oBy9SyQ5BxhX6f0iS2omo9Ug5c+9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873224; c=relaxed/simple;
	bh=YTLHq7YrJo5cR2VkCBpdcC5xpbQ4fASI3VXq6SUBFZ8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZfRszsNfTo0jdpfJDCxSaVqZilzCJY0CBaxVdyJ5s9AvLZ+JtkIC0qFGZW27Uq7T6AZrRvn7V3uufGS4gKyly7BIaMfrs38NDq5Kn4np+lc+/KHVsaBVZxat0sNlCo1liMCm1KEBZ019vRFfL02MzKZlghfbCTszdfEdor4wxtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxgS1Ts8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxgS1Ts8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788873218; x=1820409218;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YTLHq7YrJo5cR2VkCBpdcC5xpbQ4fASI3VXq6SUBFZ8=;
  b=lxgS1Ts88k+l5KSMEX/tDaBIb0MZFVPCS+lMIKiKeyW6XkflWLXjuPrt
   wk4E28dAuekXiHDEQ5RR0pUdxq8JhICoViJJhsVx8ib4NAvlFgzQLs+6f
   SU+w6oJ6LuISbZ3aqddm17RGPFkbbI8t4O96ebryekD52I9F9vPxetyrh
   4cETMVGA/bCq8+ht7bMLV8zCZyuUwyo1p1i5QLJ04+CiZd1PKVUvd8IYN
   Y3IOyKvWieI9JW3+bbQ7fcDFoogku0DTRl56LTNGNHc5fWyQQo8S15xIK
   iCf806QbNEp894xKs1QKEgay3hbCElVepCIQqyuE4KCxZ9e79j+JVxGPe
   g==;
X-CSE-ConnectionGUID: Yx9L/wstRlmTG7NO6gGa8g==
X-CSE-MsgGUID: vtZv77wiS5yxv2jI7AqkAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91785584"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91785584"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:13:33 -0700
X-CSE-ConnectionGUID: OMXibpCLQXuAu+NwBsQa9A==
X-CSE-MsgGUID: ATvLTIZYSb+EtQ0n4UIezw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="294498830"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:13:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:13:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:13:32 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:13:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSyGeUVg0WmO5OOw1KsFjm9ZoYOj9xEOzRsqJVa7CioxZcyNOSXWMGlN4yfAt6y1+gETGOK4AtkeOqw2mWgf/t70BI6qzPgf5JbiMKdgWILZuoiifBlhT2hd8zWySkgNkDO20GGOkV3RaSaehv8ohsAg67uEGDhD2Gj9mikHLdscMNBqd3Mq147XUbiqyPDzvl8dOdarf+fBRaZOlMuo9nGaQxdjM/lQVZGd1nJl7YlX0JkJ85czR1+R6CJoHJc/ui8h7GiSsQy7HomWXnoAvXd6fVqBBVccogUxLMHhuBohwDx4pahoLqUF8iI5E7sai75+31AcUni5l4ZcVRc8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hZEq+BQKLH50KT0lC81r1+G2VNWEIc8j9bf6fj/w0w=;
 b=OYLu/T6AejOUG7qlveJvPQ9zjYH4QGqdx4DTBJ+Ewnfx+WvD2L67sP4QLj0RrRqLrHcIfo31WvRmDNKz7hHiwhh5PGJO9u+JHaObOqy39QHAkdhNFVwQpNfp9dWPauVTAJIktd/k9ku2me6fuTJ3zJ9ESVT21Om8AdXGtLqHXJW+91USaskjbuhX8ZyCz9FQzLwHlFMLJ4H+M+nrgcDS07n4dWKflpRb2NBdKe6u9il5bo/7wM04rCkZRYvb5bEQlWjY9DxN2/199H56AHAl4mi9mjxa+OdfHFCrKjb3iwezHwNNDy+42mJJxaWA1AOsspylOG/gW813zbj1TtvZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:13:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:13:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yury Norov <ynorov@nvidia.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Topic: [PATCH 2/2] ice: drop pf == NULL check in
 ice_pf_state_is_nominal()
Thread-Index: AQHdO6cdIKKIa/TNbkathCm0zhQM+7bEsE7w
Date: Tue, 8 Sep 2026 13:13:25 +0000
Message-ID: <IA3PR11MB89868D0C0C656B1D2A771A70E5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260903132037.81346-1-ynorov@nvidia.com>
 <20260903132037.81346-3-ynorov@nvidia.com>
In-Reply-To: <20260903132037.81346-3-ynorov@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: fdadafb6-2589-4d83-0f0e-08df0daaf72c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|921020|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: olTEpKD7C5BOJy5d21ZKxvUUkje/bOusk+Xt/7WLyYp9PgAldaikGMEfLj824yatmcKv6AZHCxTJ4DoS3rgLyb3LoShX4hAqscDCgrKLR8w2m8yEx7ZJpE2Z19C+sCKb9nK0O5ZwvmdMMHNsUA/tpXt4RX2L2ESU3bnEmWjnfJvTS/gYS+xz8gROlMs3qLq7xtUcY13H30PhldstSBacTIvOGFOoVOzKFx2eTWDIRwbXUiSEBVyc6dC+ZeW2oHqiBtq/eKz5Nta8sqWQM4AYaX/Yvk+xkQXuyEXcj4XQaShIZxs1u6RRYeFVMHxcgMQPlqyRzqMFA4q2hu+VDTMMrMgkNzgQqO9RGWlEGLGNdYmCuWE+3lTrFmGhlxJARRBgNAT0o/8JqFuI55SUXXi7uAx/LfifbpSmqaAS9etCAoCOC8yM3lpCo15Y92VkbiCxolpOwHexXNTU/vDpE1lZiyuVK8JQ+wf1QTTaIRt+ztUiljqFxX0U5KhHMMJcIc8u5IlRMXmIL+l/VPZK4ir8UASs84nTqMy/VuRqv2p0KzkP+vE+h2Nh/HOmL6rdVo/yvIZirDaNBCMm+dSMCzyc3THllUQ+xgtoEwS2pxC5LlOlSXojKeJHJQJ1jOEHlBbIAVfP48GETzoAQyrYAqd9spp/VchbIM1tuJ61H18NVHQtmIvYZ2Ew5UlFHiq2A/LwY4XWBOJyvlMsS7jyktM3h27tpVNw0tuzJW0etO4qOJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(921020)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nmxzkoB7T7wYY3Zt8AAWMac0lDFWTV5Rg86sQ4/KKrUDEGB246IQuV1JlszY?=
 =?us-ascii?Q?P0Ggo6+dNODK7zDyP61Gx9Jv8QNDpOA2Q3HuzA9t15cLeTjj7QL/g9STiInD?=
 =?us-ascii?Q?iEAYaGJwtRocSJMPZ+IaaBUKeCg8cHMVHGW0HEruBGhVGg6/iHFpXc36Mp8F?=
 =?us-ascii?Q?w16lsQ8r6FsRkj3lY9XNfMhwfGwDGIvMHJ0XLjPaoIx/2CjnDBgr1+KSZEQA?=
 =?us-ascii?Q?006mXcCibZNRrfnhWdafkDBhQqu4ragKp0YJH89T3aNAjs3edIlZrFRlb/wr?=
 =?us-ascii?Q?aH4C2ZT/subCP23dT/XYS38Aixj1a1SKfHeYo58X/SlkLmwLLK4hTiXyixHC?=
 =?us-ascii?Q?E5j69Ay3XZRPN7t4oD9ZzC+6eQWTm3ZTWsFoL7avs2x897XJINEahVASDrqe?=
 =?us-ascii?Q?N+SKVhGgIMv8gYzZ3EJHE1IpbMKfheXqPv40W8vgvYljkjtLz8TyEdmROf8Z?=
 =?us-ascii?Q?ChDwd+ZJCsS0JHvFsha3Jr2l+ASb+mu97ivSgJb3AnrR+w1sdgD0Vwy6CRNR?=
 =?us-ascii?Q?DaxrY1x2jsJWKDRiofI4GDjT5K3dIlyBVm3I5UnKcS+ZcXL1yOMo9TWfaTQy?=
 =?us-ascii?Q?b//Mu81WbcF/z4yBqg9NO/zVHGjdBLr14hAyXsLBpBGQozqmHAAzoICscAin?=
 =?us-ascii?Q?agchvBFIoAS1+Z6Zfx/+VNszzXb+hNRsv9qRmS81ACoMertn3+bOZI8mFJdJ?=
 =?us-ascii?Q?wdMKjlS4x1dHcrzkGASfVnYmeg5i81i2OBqShVUm+zkIStKlC480CaswNjsj?=
 =?us-ascii?Q?G6koEjeMd7dBm/OHA3BEB4mMLHmIV0zvtUhdWkv4zVCJ/VPJK12gBWu5I4aI?=
 =?us-ascii?Q?x941yc4KZSBwDzWu4T9hvANhca1A6v2SCrLaoVo1ONYFfgnnTI10RyxQtaDV?=
 =?us-ascii?Q?4ODUn2zLZ1kI1LEFP9OnIwLCbpnUKCHHFFSdGE3Jhn/Q498PvB/Ufbj3GoDn?=
 =?us-ascii?Q?Hl6ZaBzwMootQBr/n5zN7A5QYM664sz3KWwhzFaOF86IFcCE4gbBOIl9oGc2?=
 =?us-ascii?Q?wpg4Wj+q5rP43Dtx+UupENLUoEu0H8EFGwHm7spAyaVEiSlgLzxMwrXfFP2I?=
 =?us-ascii?Q?xZm5cl2qQ3HEGF6icw8WrW9LtZXHhZ69DVHfIN1Tks7ueZwKDP2+j8/Z7mtV?=
 =?us-ascii?Q?E2JeM3xgvlRutkLa/coc4BmNB84546WwfegJyxCWdOZk78KDaZOHCtzjK6N2?=
 =?us-ascii?Q?u5J/ttbtkTEcoqQu/saMnt3kFgqu2GdYp0aEDpDP5F554wpkBJ1TB6Ak22Fq?=
 =?us-ascii?Q?hPSOwtEmyryuWm1EszniuFnM8x84fJvTiBPhPAr4/ybHmnyZVaJWjXcjwsga?=
 =?us-ascii?Q?0ACSiCM9NKtIKHorRWoxvS4GvKezmtOqa4SeYRDuP0/qgTGeQA9Gp+qWpJ5L?=
 =?us-ascii?Q?3aciGtu9LrStCWpP5b309nNoVDgc2NX5XL1nLIivW/RlbziS8h5CUOVGfIH+?=
 =?us-ascii?Q?cpP1QN6yFLiVd5NwTA9x8l0AIhcaB0QaoWOrG25gornL4gmWWdKPaXax55qF?=
 =?us-ascii?Q?SIUyl3ncmr86HD2zWOkpggdQyCF7jmSyV3N25Ks2bvdJEPrRsYNHJANlzRfK?=
 =?us-ascii?Q?JxQ/2nvW0RkQsv/Bk2ZeCEwN4DR8wXUlmb4pdEoNZQa/kix32NKt2udNvrfP?=
 =?us-ascii?Q?Xn2UQMeJ/lLwDOoMeL+xW51qu/eOMxN2jFueFipZxja51pbs1rprFXzvi+v+?=
 =?us-ascii?Q?YsfSTMorM8AXo8V+pxTrb5SxbvDaeJvnVJfhX1Kw3yKtla+ynoHI03l2o7jl?=
 =?us-ascii?Q?z0qYVK8CcMaMVFmNw0Me59kWlYBh74I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KCvJ+aG9aZQHgsXSbCpoQ7yqY5LKAwdEEmeOgOIXE07W1JmRo9/8FVmPAe10wI36Ph377PTmWQXTjttHnk+V37xd7Cc+FK3O2PdTzsA5Bz2JcRj6DBbzmNGwEaIVzhQoov2wZTqNAL/TQxhGtPhvqcq52f0LWsyIQctgzniKoHijSnPtfjAqUAaRENYn4audY4SpYJDticG/Aqs0GuCWCuclXX5MN6PxyffJxYmWfGp1HKVlYiEp3VIkhALzThMeM8SNlAw6aS6GYVb5/OhulFeOpZZoUeprqiRPbb1vkxSHfR74GbQQpRZI8J4xkSStWNWB/K2fwxPMK13BdDaiPw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdadafb6-2589-4d83-0f0e-08df0daaf72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:13:25.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9R2cDNrvC0ykHOOSrPfTtyr6nBXzY9jWkNdhAlTY7rU9V3/LAYHcqHgGHiHIw8y73Re6CqzDtoJKlTxlHs6wHGBa4SLkTeUeQjGpFwRlpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Yury Norov <ynorov@nvidia.com>
> Sent: Thursday, September 3, 2026 3:21 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; open list <linux-kernel@vger.kernel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 2/2] ice: drop pf =3D=3D NULL check in
> ice_pf_state_is_nominal()
>=20
> The function has 3 callers, all except one explicitly require pf !=3D
> NULL. Add the corresponding check to the remaining caller, and remove
> it from the ice_pf_state_is_nominal(). It makse the fun function a
> one-liner.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 3 ---
> drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 73996e3022ef..6d5b8acc4764 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct
> ice_vsi *vsi)
>   */
>  bool ice_pf_state_is_nominal(struct ice_pf *pf)  {
> -	if (!pf)
> -		return false;
> -
>  	return bitmap_empty(pf->state, ICE_STATE_NOMINAL_CHECK_BITS);
> }
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..168d85f9477f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5521,7 +5521,7 @@ static int ice_suspend(struct device *dev)
>=20
>  	pf =3D pci_get_drvdata(pdev);
>=20
> -	if (!ice_pf_state_is_nominal(pf)) {
> +	if (!pf || !ice_pf_state_is_nominal(pf)) {
>  		dev_err(dev, "Device is not ready, no need to suspend
> it\n");
>  		return -EBUSY;
>  	}
> --
> 2.53.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

