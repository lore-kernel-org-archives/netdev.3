Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F114E8DE7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473591; cv=fail; b=Q56r2kQFNeOPcL+O7PWWMlWYyb1IyoyUEGq8uqYo+XczvsJjN1zeYBeJgcJTUP3NOB2+pFnlwCIxFr/iMJNFQ+6BoLXGMuC+HpCTWrzV19KZYNhplBlPv6KIYqpSGrmDpRPEV0kytUlaUZg+XImYL6cQvm0y2pd3x9DsbCuo114=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473591; c=relaxed/simple;
	bh=8Hh8Zh9n+C12NJ+ZR/3sYaxs84U/nTUijkqS9KCYpG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnM7NEgEhdTpMwP3OAfjeDJKunaTG/PlyxpYVs6ybe7DxTwGI5z96/SKbzX4fQJJobb/t4noyiDfA+Rt4x192hbhM1Zx78npAtDcA7bEW0uBHDrM3VSzStqy0EHXH5NXgZVno/V2Auk+VXLWsPctbdQfKEURkYDKpBaH2RnhtE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPmkIHtK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPmkIHtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791473588; x=1823009588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Hh8Zh9n+C12NJ+ZR/3sYaxs84U/nTUijkqS9KCYpG4=;
  b=VPmkIHtKveH3DJgFABhXeageaijriEzro/2gnqmtRWYWEEcspGpl3IBg
   78RUQHRTQ69XhmOcZ/Gwhk9PpzOIjXIQKXlSFZRF/jUQZf6uRnKaI18XZ
   MOvWVwujjZoRfzIaZMAyCr4mss8kfnDHLr3Co1MXHyeXDEVxsFruHTlNH
   O+5pOl1qnzoFKpi15L5jjPTWRd9+untXdFHTXhrKGQyroMQUoXrJJvLPh
   7lKqFRZGy1PsSgKHqQQ0+8DNRnc4hs/HVjz66ml1bPaYk3JnavgCrtkix
   FgNaXEN4Kfq+WZP5NvoiyujNqrCScbKOP+FjyCpTwamcm9ypA3uOOfUxN
   Q==;
X-CSE-ConnectionGUID: S1PE3BiYQt2H7AZPDpK+gw==
X-CSE-MsgGUID: LZARyM0lSpurO3/bDgA+gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="287104"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="287104"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 08:32:42 -0700
X-CSE-ConnectionGUID: X8f9yfJySqiTakhQMEygWQ==
X-CSE-MsgGUID: YJT6P5yISz+t+tK37uBuuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="413585"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 08:32:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:32:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 08:32:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 08:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbmdzR7ARNHwT4vwTrMQ+wnC4Hu92QAHJfnkO7mB3gRi5Nd10+7bYQuegrQ8yOC8agusD17mTYM0IxLCrCtkX8ghszItwVBXRJzd5KwBDX76sFsKugDUaryPUXiqkV7nS9WCnx3PRuouN1e9LnCQLwAP1mpdpRie6c382IbcglpXoWwKWY5mtEyGwmisrNR34RkVHCr6fcTQaHhdSEBMhW2wbbGumW0qrzHXKhag6Pha0U38ftszlUEVYAxZfQIq++WQuG84RD4Da9o8RJxmphZCRu+x45DiLVlfxk7sN+S5dOkCCPkV8JZ0F83f2DPyHV3u9MeSSUHIpVIsL3xu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttU+ZNyOzY3hMYN1TpnBNq6GQ4902yzagtLsvIp40h4=;
 b=nz0Vq646xxLYOxpo/NQ0jBmBuhd7wZHf3qti9B3RBlHAXc1bdX8QnztM0joSCmjXy9l83mub2oazMVL/dtyi6a0jm1DtNduMKtB5lGQiUTmBK0mcxlOLZMDCoLKOhf2A5Gw6oygLoOzdtTl0YNwQQpT7jzD1+aVN90msEAXVeZpPMpxImspXGulmn/UlA6oukFpnZyR4TaXk3syWqgOW1GAg/jDrDqI/yPxmqyvW+n5MK/J5QHi/1UMZWD3jQxd1wb45oquq60NbvG6xZ2qko8UyZzIFakcbupfwNQDOt7XZZxYlAul8ZfF88a1jHwjeG5yOHHvomD3ZoDCsQ6d6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 15:32:36 +0000
Received: from PH7PR11MB8012.namprd11.prod.outlook.com
 ([fe80::71b7:7099:a6b4:4bbf]) by PH7PR11MB8012.namprd11.prod.outlook.com
 ([fe80::71b7:7099:a6b4:4bbf%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 15:32:35 +0000
From: "R, Bharath" <bharath.r@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory
 regions
Thread-Topic: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory
 regions
Thread-Index: AQHdQfHX0ljn80Ncyky/8O38RCreI7bz6ymw
Date: Thu, 8 Oct 2026 15:32:35 +0000
Message-ID: <PH7PR11MB8012DC7C8029CC93C16B97FCF7932@PH7PR11MB8012.namprd11.prod.outlook.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
 <20260911124921.2881348-10-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20260911124921.2881348-10-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8012:EE_|CY5PR11MB6318:EE_
x-ms-office365-filtering-correlation-id: 363cb283-e95c-4f5d-4040-08df255160c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|38070700021|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: J1CzDYwLS6WKB75Ofm5dm+nP5Qk5vpbKBKWZ53E5jqn8LTXKiUQykW6DMARvtJcld6XvT1pXANWX9N1FgrsGOtWurcVpEvBmE5/6gjLh1j/baAGzHDP92opueqEe3UrRRoN3AIj6R+OmIh7U+608M4zSRYwtlYHkw1EPuLWgRltcC2alvvvW4IYkb05M1wIwQWMmz0HlCBt8WLsYeDFiT2CUiJfF6vlzqAPxwdUQEAmcEM6nxyKvJSalq0KjrM2O6OGHqmnySf+GjhgBroNK2d+l9+E1e86VHM3udjDwm895omdEcNrEnGJpFiSzf0wpFFsz5bVcl1A4vNhR6VOBUFprtb884ubV0tFondxDcvLZKYOXkmiku48odbvQc0weWfuZ+r5AXSZSxlxHcOzBJ8EOJYlimi2zxkkjwL8bpsoY0TnMQEUc/4cUHpVgjrH0Pk2YUekZvnO1NrqmIGVAgJ7RsuT2C1EDpXO8sVuNypCNw0cxqtjyKQKD4z8FH0ybK8GOFCglzRKrtYy4L3tZwzKbwQcXJrbsLRLIJnf2Qr4KE3roCh1YZpquPtI0XK8dvCIO3bYpxysh9cABbalFFCaRKZAhWqCCtQAT4gXuO3TC/9KltsMWJhU9Yecu4G4iKMH+5xMTXuiHTyYB4OTXgNMt2JibMwFKL4SwSu/a/WmzEa3XoC+LTXSvkBrQJ5KEFWpERvJ0GKhjrAv+9Kr5og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(38070700021)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OpoBH1xVdX/Vpzj4blRdyVNCHToRNYxSAbcib0zhGR4kmZfFkVBy9X6ryyKy?=
 =?us-ascii?Q?BSUYpd932ldlDrZIXs2DVFWMtksps0eHqxeitLzfAgPJd4cBUKBo6+j4PO5+?=
 =?us-ascii?Q?cU7HUMK2gGGnHSxHQpejlLMvVAtL0aA7kmsaCTbDvgMhUpMGoOHIGkelsY6d?=
 =?us-ascii?Q?THowA5CxNWYLi5KJ9zFbW2Rrarsxs9dxCBiG2bIhlrwNg8wgyvgaBx1w/L6H?=
 =?us-ascii?Q?QLu37+qilHXNILUxtSnu3l4Z0fPM77QypRvrZIaIN+9C2bsOlEnZZrowU6S1?=
 =?us-ascii?Q?YSLqJLM014/lkgFZwSZBmTbdBwIfol5UExlPONgt1e3nwNBr4MDxQg5SKumG?=
 =?us-ascii?Q?sBeOAlFMdbr5+sRNoL4nAgREF1IJpWOxH/klun8wkEVOowcg/O7SBb4Brvgw?=
 =?us-ascii?Q?pdqiRYlZQrHWEDAXfABFZvTq5wpKJDNnCbXAkc4B2n11ryp2yA5fNanjGJ8Z?=
 =?us-ascii?Q?xCYDTXzxiJv5JwyP0hTW0X9ygYWGZLUFYxMXGXgBcc0Tm2v561tfVAMTqG8K?=
 =?us-ascii?Q?Uf8J5fMqPVSTr82XjBf0IxDaDG3HX8QBmYAbd6yBGsONu4f9Dm2UpfiC61kU?=
 =?us-ascii?Q?WpPzv/h16rLTdAH55z/4AOr6MNGT5BYS9EeCSyx2v2c5K2qpGiwS67pZ0MQr?=
 =?us-ascii?Q?7aAkXAiVig8+IgHmD0j0qk+Nk/cEgJwRUWapLThthCB4OGgUZ3R1G6XgaKRh?=
 =?us-ascii?Q?2uM9BMfAq4VIi9KGutEfZMTfu1d0VnI6jRxypHd4zzLiO2hmvkJT1AqW/RmQ?=
 =?us-ascii?Q?rRIzqZobViDfhhmxN+p+6gmJZf45IA74kl4A+8TU5InESYx3lMz8U4Cmwvsw?=
 =?us-ascii?Q?2TWHW6Skr3L8foKNxgjVF4NG8kcaEkzzUSjDYRfu7A0Sun8LHMG6GwqwfbIy?=
 =?us-ascii?Q?NInokV4I4UhOoGBaCkVPfw0gIGNE2/WRURybP04JJ1mBPvRgJiQ4zAbCzLDg?=
 =?us-ascii?Q?DZ7g1RGMkMi8e6tytHebRbSd3BwnxUtkthB/N3d66ZlGw5oDcoqvPFIEzyqQ?=
 =?us-ascii?Q?i2KjXKlXx/IYpD0StEh6kyESRJSItoz/QSkU7JwSl+q8FcRM7qCuTNVjV7BL?=
 =?us-ascii?Q?vLx5BNXxcmt+TawVPQgp3Bmy7qMAAmXvMkklNKT9mz5ZCTVXSG72MLaM72l2?=
 =?us-ascii?Q?Pp2gdeXoExE49ygT2mcACIOR07KsoES/hF9ERwiIP/0EFyk9JCJ0AWCtco1d?=
 =?us-ascii?Q?vE5L0jvo1sGdXerAg5ziOUn1ycMufC4m8sO7+sw61EkKBOPIaTwDrDIYpxzw?=
 =?us-ascii?Q?mWyxSFs7kLRxnT3SJi7BW97sQ9ixc17ktTue5qSaQT7PiROY11bU+VNVJvsH?=
 =?us-ascii?Q?aDNBy/jLA3WLY4TbSSeNyE7cUP+wfSCeTuaMFtqrsQXVFG3SN73f4LaJqpNj?=
 =?us-ascii?Q?R//klK26DXrgYcrKmyyabpPHcjgkQRVhmr6lHRBXuO10SXY8+KagM4dy0G0T?=
 =?us-ascii?Q?7rEFJ84W+LZoRTJ8fQYXx8otZlECa+PqPn5V4rJOaDaBhLxliFV66BjaM992?=
 =?us-ascii?Q?EJtouAcdT3DPlrUur7jC+KQdWOMxVjx7+GTvAbbelW+TwNRuvOOXjOHQyJRT?=
 =?us-ascii?Q?kHib6UQHA5DbVWCxaQXhZ5Z08ocl11w9csnlKdwU9d//drhAnWL66S7ZoYf4?=
 =?us-ascii?Q?5s4FeaOnaFnu63wYaMqR0OVRUSa+XaTZjFr9JCX+MSOKhGXvyiNCtgkPn5rv?=
 =?us-ascii?Q?o9U0XxXIIZf9KRf4S7jCKmA053deCwso2SVcZIu7OsAnaTSz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U4eO8By14iGkCtI0grdD3XJt6aC8BAfOJAufTjtEulFTdYFQvnA0zpPZ1UobW853XcEe8wsjkPERxU7qLKHXFRu6c01wCdVEkTnczztZDm6Trj8nZmULY6HjcbO8+kJqkFWgpj/nJoVKaXF7tbjCIdFQdY/1YycYJmj8nKeM6zjvf5U3TerVjrZq8AW27tso2B/GhpY+g6BN5OTr0dCg0xJ+c2wZX4jhEf4bGAYY91cbzQVA/4pFKu8CCZdUipvT5aiD0dsQ4iEiMxHlwAVXDJJj75vhL6qnyIRPl8+TZrZhIdeGFCVqYZ84pidcZvqkTV2EDFmpmnUrDWNFhL2fzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363cb283-e95c-4f5d-4040-08df255160c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 15:32:35.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACs7WfH/YOGgTanYxb1KCm/aH4RQ97zxpAaC2m/VcDjf98QDczyu6E9mI7axYeFBiF64TLMtU+MHpzU8FcwIZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: 11 September 2026 18:19
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory
> regions
>=20
> Send and parse get lan memory regions command. Map the regions from the
> command response.
>=20
> It is needed to set number of regions to not zero value even when just se=
nding
> the command. Set it to 1 and add comment about that.
>=20
> It is possible that get lan memory regions isn't supported. Driver should=
 cover
> this situation by mapping regions needed for running.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ixd/ixd.h          |   3 +
>  drivers/net/ethernet/intel/ixd/ixd_main.c     | 131 +++++++++++++++---
>  drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  90 +++++++++++-
>  3 files changed, 201 insertions(+), 23 deletions(-)
>=20
Tested-by: Bharath R <bharath.r@intel.com>
