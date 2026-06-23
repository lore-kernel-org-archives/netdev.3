Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C8311C38
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782200882; cv=fail; b=eQ1q2fq2YJIKu2KJhGcP4HqwZODpSpIr5cOSgAr8TqSpxeYcWuWovGr8ThgmPFDzDB4muh+OybukKU2VeVCCJwyvjhjuDtvfYrvngXdQX+4z6xt0zG/Jyr3uENaKQ47acOhXijmPaiuamJMMmph8HxOtCcI6LArpbAeGXKdpEGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782200882; c=relaxed/simple;
	bh=zJv6e+1elYSFpGXgEWOieHZRGUxvqduUX1vZ/GKUOeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cEfzKwsWSXfDxRm3ZPQ0r5X+KMg/a9kRNUecW5/SJwcyKP12F4t3z616d82VfHrpkvkKI5skfKbUCQVNirL/QQVWf/0sXbT042+efVkWG5MpuZ8T1hCULC5q9Y88LMWxHYnuQ18TJVdRGLM/KB/Dz03JgT9Cz8xyf+SUb4qXQ0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdAhsE8z; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdAhsE8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782200881; x=1813736881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zJv6e+1elYSFpGXgEWOieHZRGUxvqduUX1vZ/GKUOeU=;
  b=OdAhsE8z6vNDT235JRP013TNGe/tSG4oY5xgC7IdngIMotYJ3cg71+SW
   iqo3ArKg23nBVJWkGNuwoS642fLNUcRCRpjr5SUJOZApHJmMKshSgaIN8
   IJJSzqG54yNA9Ki08w2BydrEuOgipkWx/H1Sn+lifbwqjZAZ6UwIjllzh
   gmmIHfMIRm9C4ZGJqCq0IzpoOB2NW8ldn2s8xOxmJOelENQwJmCw6GL1F
   hlt1UhTurroxRgE+VGGnvHNHxzBdE/wlzW7Vc+lPrMeONeB4KTbtqJGmw
   G1vGPgSBkhE9tdNioID0zpKvY4Sj3Bp0XvalqQn8QbfcR1y/LnU63fsin
   g==;
X-CSE-ConnectionGUID: XJya/jVlQgmREUg0IdqyVw==
X-CSE-MsgGUID: ppf6ZGbqScOo6NiLCnf8Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93301543"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93301543"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:48:01 -0700
X-CSE-ConnectionGUID: eNIMusFXQoGYtp0C7RkAfQ==
X-CSE-MsgGUID: 0EPvWCz6RNSxMHY1+JBUZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="249572952"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:48:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 00:48:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 00:48:00 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 00:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEtxabvArpcuo0xKg8Pd2akhRR48cn5zRDb5lRdU99QX4vmXoaX8xIe8YIHqaNfSrWG7m1ixfuVmdqr6z91ALw4NUk+XKf7sk/O2To6SrPIxcGcY9xCaDwVYU7+aVeyrRdNygql/FGJenuKi6sLBza3yhjmJWfDn1P4BQiW/U2ddY8lUDoMCdYsgiU3VWop6IPPqBHJWdWHPU8WnG/fFwS8iJNIjg1dimtpr9mC6KYjholFR5lDx54ZBxtJOnYirRU4+t2qj9+eGAp+I+XtQs/sSALWNtdmd54DQuOn15LLyLrGwco05m0Bpsl4Q6YvAjyIwWk85dqh8U6ahiDSJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJv6e+1elYSFpGXgEWOieHZRGUxvqduUX1vZ/GKUOeU=;
 b=aOnGvmzL9CzfkHRShzsRH8dAI8rXncUkiNWf1zHaIJTuFTW0wS4u0aVTvtZj9DGqQ592Lg9aTFB9L6Lf22RIhAE4DLdqehAhrhIQ12Ar8llL3LvNAuQ+DpghYul6T/Ky1trjOxi2GyA3JpTBoedw+/XV2jeykagIrdctCD0L8YDw3QUD1ZXJSzM6eClFRJVgO+Ohbz/K2SnNmUczV2+67oHwWDPWVqTqVfsr/rZGIGWOUVl8fw6jz96Lxgers5Bj772HsdTjxVmeM57NkOOHJB4cVu5Nqu+FYbdyTyKfxszRvs0iimZQIJdq5NRjHmMKt/wqXMe8Hk/o81Uen0tbQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by IA1PR11MB8829.namprd11.prod.outlook.com (2603:10b6:208:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 07:47:55 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:47:55 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Knitter, Konrad"
	<konrad.knitter@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: fix autoneg disable
 when link partner doesn't support AN
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: fix autoneg disable
 when link partner doesn't support AN
Thread-Index: AQHczjO1zNpAmPqjAUWwDVjBmzgIwLY5Gj8Q
Date: Tue, 23 Jun 2026 07:47:55 +0000
Message-ID: <IA1PR11MB62412E61E842290428F7AE8A8BEE2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
 <20260417062954.1241900-3-aleksandr.loktionov@intel.com>
In-Reply-To: <20260417062954.1241900-3-aleksandr.loktionov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|IA1PR11MB8829:EE_
x-ms-office365-filtering-correlation-id: 4cac5a1a-e5f3-42bb-ca98-08ded0fbbcc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: BQgbPUgAjvX7BuW301mlgNCpA8TOK3Hc6EjthD7kEvEGjsKZQ/dBkIJL86hoaEn73a/+ldBuVjYi+sdam8JB/7RxfslWpcJQ0whej1FmH6n/XN5aGyaXrgEErvoO3AUOAG+92x9OCIY7rDQaTltqC9CpEQuNHPullwp/VZhw1jRNCNFZo3QIwLbt77tdItw1AjSgTw5/g/aJrk1P1XLxP/eCDGvQpiTa9ElunR//iZB2Lbypau2tVpJcKSM4rIqgVf+b+HS11nUjMwuPZQKq8qdH64fTaB6d6fwDiu0soQ7i20TcUlcWCodNxnMtTDEcushW9LsYNujldpehJIzXFxMgycEeYbpl5ORjpovlWJ4lrJr9wOVASrttWaSWm66k1XcSE8prQj86Gj8he4m6PMFI1L4p6bZVpDca9DQ+2Hgd/g8Qt+5wsMTM2xuDcOOOM8chr8zWlDdDSIY/d7FvzCWGT4srjNNXtTABUAEu2fQ78ZGPE9VamnnUmi0gA8nkVLcbn5KgEK4YCpL3pXLPSc8ETtU2LqAGTW9Kt+CqwkHtCx62GLmEmtlUmsBaab5oElGGT11DgOIo2T0HP5MxbYk1OUe8qKZ+5NY2jLlzlRE98D3rLft6cOSz9MrPXOiOhJEQLPuwKf2+SLcnW2PBEaoR/XETkfU72DK+Z50Vofz6JS8rXJxabXM/OPg1ArpIJo+I5rLvEbE8ZgxUF2zhCpXWkeJ+vg6QJWjIGG+822g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X9AADGbnq+yNoAdykbjYHc/V2vmcxS1h7se5V4hAODjBynxZlnYrwT7au+Ok?=
 =?us-ascii?Q?LraWHgMv4ivFbr1PrmrtSDnrhVghpJMz5+08U4yCNCh0CIJpRU/qc/CyIDgO?=
 =?us-ascii?Q?/Vc0ldi61ejlqmJY4OZxiCAEyV5fbdfpMdqBx2G/dJv7RJ8UpxkebZLfb7bk?=
 =?us-ascii?Q?meG2jyKswlAJn/M1Dsj6nZ2lKM+Sw0vxvqRMwc3uvVCDkEMnVGrUqAPrWhHl?=
 =?us-ascii?Q?aeURcnThjGkoZJwi/fHrafUlLb0t3/nG/gQ8qPFgSjm9VTA4kzYAQjoqeagJ?=
 =?us-ascii?Q?hxanmC4la8TgDn3O+djtxC7qeTr8eDMwSdPVohbVtUfSLuFjgJ1+9ZywhVHM?=
 =?us-ascii?Q?iewYnhHn/02OQpNOt1afFtv7VL/gX68vc1nWYc8SGlqFM5oXdEtcV7q9aHOr?=
 =?us-ascii?Q?/cbYv6tCfzpMyR5dYx07beJa1prZNDlTTkSMh2OKpLgIkkjJ891FbKCO5vH6?=
 =?us-ascii?Q?12lCkZ8ny1SN1Kl4F6xwWcFwl83DEGdFYvBdiDwnsPQ/CoKE6Q22YkwhNG++?=
 =?us-ascii?Q?DzrRT/TRiQcz3PpcKSZwUu4LwwnbNHUSURSznA8pC9fsFEoJMcMh4jXz6Ue8?=
 =?us-ascii?Q?b3UfRyrRpItg/l9Rmtp2MlPsCtfgSx07YO2sjVJc0mBHkpbWDz8tCCRpwaZA?=
 =?us-ascii?Q?lsN/mtUEfQpwxYUEBetNL46vvXj5LAJgaB4pi5y08rc4Sl2H73rEjmmi1LkI?=
 =?us-ascii?Q?xvaPCzxvJI5Tc+CtK2wQ7yd2X8bEn10yyl8dUi1SrtN9CYBeTVripJnJHQUe?=
 =?us-ascii?Q?gOCVoDRrTHQrE5AO9ztq9YJzQeKZGTZ3qQdjeWWalfBJBVz8Ov5a9YQQwW1T?=
 =?us-ascii?Q?wKJXnFcaCYGOfDTRzaHcJw8el0QdzmX7/u9MgJtIe8TBSOa+Rgrmv5c+o/2j?=
 =?us-ascii?Q?ZtYqs7xze3Qm0QCLqmwJh8fslaJvli+Ej75yMBVmOsm03PVIVaYAqUpao/GW?=
 =?us-ascii?Q?rujMHXdHMLcopWsjEiOLe45QOoWrV2h3uokfRbcdX1PbbYVXw1iUQP2nxhgE?=
 =?us-ascii?Q?DnklFGMqMm7uBrqMFfy8JFS23eU/guVef7WG98GXxz6ql6Lt6bz+ZwEjKy5R?=
 =?us-ascii?Q?CEfNbp1xXxclWNz55AphzF/brTVHS4oyY23pkuYO8gNsNrQ5izQQ1MCmhRI7?=
 =?us-ascii?Q?SIpVEoXgEiSTXIRFGb2AmZxHimU2KgjGgdjhpP5xlfWwxcv3zLjH5Qy6wwi0?=
 =?us-ascii?Q?T2GwferItyMuwH5KALxtDvMo9QIqWinYoENBDCGkffhsHS2qbZM46zyg3vha?=
 =?us-ascii?Q?fZp4kQcpWHyafaZfqli+3iOEl7u/FIc+bVACUEMu+sbdELC2ayqPkIWMyot+?=
 =?us-ascii?Q?CCB+CvP80NS8e9NZZn4avZZJTn9OzL39U0qQ2QGKp+/Y43Mtap3EwQ9eEs/1?=
 =?us-ascii?Q?Cr2+6MSkilKqaC/miVhZIRzx1x2fW99zV5aWRZeGkDUauqj5+HqVsLVdLcGt?=
 =?us-ascii?Q?317Dt1lYtVd0Kb6Fp6hQgq6mdoYy7UQuZmU09ss+dUddYtCgZBR+Q+/TRct5?=
 =?us-ascii?Q?DFj7+zwktBqd4FtHC60R6IANDKuu4M2SE37uxSuJACYsX57MJb/sW4rD1oYS?=
 =?us-ascii?Q?8sBhCQ05WHltmIKbKmfn413Z2GYGKGDcfIK+/Xv6WgL4JNjluZXTvwh+O81k?=
 =?us-ascii?Q?4yAm3SRSwtAa25h/zkQNkP2XZrb3TGgsk8DOgILCKvuyhSOpAnx16PAomNJd?=
 =?us-ascii?Q?pj8twBToFQIEywUt8Pubmk8hjQWg0WGRdKbqbp/e/SgN0Srt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jALdjvROozEFsgTjMkuGrBBtJ+ZW1qzrVB7jN3SoS44ovBvv42sVRFWGC+Hs22uvgbYrR+gzIoo5GwybO5G3O+yed+VJXO3s1Y/YfDtWKZbk/5WrWGCgyA9AVnGhq20UBgmABJaN4oHYTeyfzFJhMFOIRcWSsJFHP0HGa6q4rUSeUN3agDhFsTgAkhCOKvSMC9tv3S+05L0QgdmTmV6761+lRFyCd5DqyNUAT/r77RRzqMbkr5Y0I2h2hNGUyB/4eEakE8Q7KMF5qsQNyzRQclUFOwGIfqkRdu/0bLuWmrBG9Hq8i5oDVrKnGtJrADdmsDgvQO6DJWPr3GWJTrRvJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cac5a1a-e5f3-42bb-ca98-08ded0fbbcc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 07:47:55.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9Is1DVWyo0YNJMa3XbBSle6c55dtkzaN0JYTFUPVF9h8cr/QsvqPyIjvt2kPGiOC7beA26fw/sR2YEATKF88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8829
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of A=
leksandr Loktionov
> Sent: 17 April 2026 12:00
> To: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Cc: netdev@vger.kernel.org; Knitter, Konrad <konrad.knitter@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: fix autoneg disable w=
hen link partner doesn't support AN
>
> From: Konrad Knitter <konrad.knitter@intel.com>
>
> Disabling autonegotiation was silently ignored when autoneg had not yet c=
ompleted (ICE_AQ_AN_COMPLETED was not set), leaving the configuration uncha=
nged with no error. This could prevent link from forming if the link partne=
r requires non-autoneg mode.
>
> Extend the condition to also allow disabling autoneg when the link partne=
r reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the ICE_AQ_LP_AN=
_ABILITY check on the link being up so that stale or zeroed an_info when li=
nk is down does not produce a false positive.
> Introduce the helper ice_autoneg_disable_allowed() to make the check expl=
icit.
>
> Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
> Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 ++++++++++++++++++--
> 1 file changed, 24 insertions(+), 2 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
