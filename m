Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727174D8DB8;
	Thu,  3 Sep 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449384; cv=fail; b=CZoa3wtkyXdbkqdAbiF3DVHJWWRwlCey4sT41Bumd9RJYfNHrQK55CR75ElX6AmfEKLDb5EdHV0LTUX6BDl1M9MOxj4oPy8sJUrMKcY9G1XoYAnlFdlVQBn5tnFPYvcRV9aOGTZcLuOOuj6UdccFqrmh9vvgXz351BDa7lVmHdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449384; c=relaxed/simple;
	bh=YR3tZyX8yMuUhCpnrARZUjoFqmA9e7ObKrkLBF21Bbw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PFrIQyHlicnMd2w3iyYuLdkJ2gB6WYsVrxrB2mW0zGZiqkbDh+uhhTHBotMeBPYVCR4GTpIbaN+MP+y9WqZzx+XzQqraIKxhEeVaNgmixQU0Df9BJDN4HkGJ8gUYRcji4eFWfYdpr1BTH0FswGYaekTa/8vJjIiV/TgVZrx8rMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4a7Dtn9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4a7Dtn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788449381; x=1819985381;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YR3tZyX8yMuUhCpnrARZUjoFqmA9e7ObKrkLBF21Bbw=;
  b=e4a7Dtn9auSI6e5ld3OK3J7d3lJl40b3pf4Sua1kfRE63GOc9+5Upfkm
   uegTrqZ6ZFQJOi+3/Qlvurf4Cz8sAokPXHozbxtENUxYxYg5ehe4ZZulZ
   yU2w2QiMStoKYa1Q+/B2IEstDwiSkaE6F9x4HCHKhT+JpL2Y3JcgyepD5
   fjsvd70CagW5ooUmTmV07da44kFOWkA3ixv/3BLF8ycgZvCHipE0FUOqo
   UyVVsRnpshj7QfG4uAYl7Wd3XVLx4GqtpI1hDF6i9MESxjoyWMa5C/wIq
   v5ksnhjEcRNNqugGGhWH0ROmdsjiVucelRwCSOlbz8UPocHue432iTLAj
   Q==;
X-CSE-ConnectionGUID: +EPq3rWCTTS4gzpu/e4scQ==
X-CSE-MsgGUID: i/93W0xxRA29HquqoJ2QfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100450988"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100450988"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:29:41 -0700
X-CSE-ConnectionGUID: ordnmjVkRbSFiIt9vo0UzQ==
X-CSE-MsgGUID: xU93eZ55T2yNweNRcUG9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270296055"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:29:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:29:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 08:29:40 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 08:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu3Fq0oFZ9aGB7uJUy5jWsVBIeq0StDNiiAYqF2BDosrTtyvic2fjiNjJPAjSnDFMNdyQqJyBLbatAmp4dddnruio0gg82LjK46Hne20/CAEN8oc0h+b1775IXwgl4EZZZ6mi5tOzvakaJGDx12YfFzbkh8wXyVLeQIDTmc66sfVx2JqvcI+/Bh33AiSAXRzFbzJHkVdfsi894VQcH7KWNf2WvNJu+zIM+1/SC5EA9PSGB+6mlHX7OLSlnjPIViCyFkG+lxciPcIB/guIYTYghnbhKY2kjczaN8LoVLrunvbTxPDFyKXTAGnddZfAP7BwP4Yrg0eiI3h72Hd8jJGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0kQL4BDiLlN55IgKiCoBAasdT7UV08qxGlTvTf11Cw=;
 b=zF6SoqONHXs8nxbRuzkq2vQFyGmQsQiZGSduMxGAhKv0uBjlEddzwTkiJSfoKQ993yjwOuPFPZuH1o0fyiR7EBtX4CLS4uynpe3fTpPIzU7Sk6KsiK4AINsMuPFu6wLfvW6YnZmYCBfbG1UuGLVqoVGOHg1WtFP7Y7U1nysI2lr3aqpF8Mj9+O03vJFsaROnW8d4Pj6G/Fgk3ZZ1XaZiHf5mrqVvSxdEx1xMhPP80Q4HvaATB6Ach6dfNn4+BPJJOw8nWW3Pax7xap8/GsnLK6PGeAXcVyqEy3LLY63GNnHEy7R8INKfg1M8zts8tj3GmYa1zrs2c55vI2P4vEkiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:29:35 +0000
Received: from MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b]) by MW4PR11MB6864.namprd11.prod.outlook.com
 ([fe80::3cb9:afc2:1be5:5d7b%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:29:35 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
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
Thread-Index: AQHdO6cpuxzxPOr6nEeiXshlL4xdnra8+orw
Date: Thu, 3 Sep 2026 15:29:35 +0000
Message-ID: <MW4PR11MB6864F8E60A0E8587D6F6590980B62@MW4PR11MB6864.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: MW4PR11MB6864:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: 6b177e2a-e690-446a-76f2-08df09d028dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: t7Pe1Ud0ySvGrhlG1eJYl4qSNOLDozarywQg2nZufldWxeskCEH+iJ3Q+D3V6MHU8J8P1N5WNAwDYq2tAHSjcXHdtCUCZ6cR3FRtk64ST3Xtxj2coV5GQd4h3/mZ37L3/LW4pop0+ndYanVIGQ3nPKaVedOW/3H+CxQjmgehZXka1S/y0XO8DtbrnIo2fodH7n+QdjfxEYNlSpDhVBDndNqELpKchzWJxV90qSKBuzSGho5izkW+fZtQDByGevdbFp5EZCYEa9EuluIun2WlT7YDqcFHuh9Q6vGfdzFs4STj1bCwa64D7+COevboHPw04BpgGnQvYLNcgqCWJi11C8hPGNy97wOTi4t8S/7I7TF7v/6vlbXrlyK2AEePKQ+NGcw5Soap5PQQY8f8gYn1e41qLvj1IgWCqKBjcqBIHKShiUR+J3PjBnKek9UYY+pIhj6agybqS8/00+MfY07LlUTpLePfKQSnVpWqC0F9hNpCeop4I5WhsIwLyDdZNibUrwS1P2Gd3U6+nppbTTi1313KD6YzOh2WBEA0MF893zZ1355bzd4aQailiq053hsJ9f/GLYhth9iSxK1iMeWKa3VcCUx7qDs4viStsT3OIZRXoI8M0j0UyrLEjOFE6nZxLVDcI3CCwHlbquTKLxVM2IxbjXgGWWOuN56OlxxBu8w1LXEyWd2e82/WxSh6P1z0LWArxkTwEO+7bOYnqh+qkLFPM7jRiYmk7aQy1mM26Ss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6864.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tq6ng7L/96K6IENwjBuJ+lvqSEcxHt/jJT1sBVj2aKjVMVkFzET6WIgRBhgs?=
 =?us-ascii?Q?hD33yxA4yxAk2osl/wWNI/pocGYcxI22snXru4T4l+a4rBQzo2I8mmjekuCW?=
 =?us-ascii?Q?kCBrlrdinCJT+V0gvayoMqaDxBHBD6Yh3C7t54vEc5uTEd307p7fuD6lszyL?=
 =?us-ascii?Q?1tGXfuaZoFBJghP1/BDhxGYXCmE+yP0I31dpGqcmwnjoQcrhdBfjvKP/xea+?=
 =?us-ascii?Q?3ohDKdy61JzySsfHb7YcrZqSE4V8e8RdAro5B1fHWXq/LDp2NMt2o7NPNrm6?=
 =?us-ascii?Q?KIBMyju+NgS4iLTm0O7UYC6szCkWWwwfSgY/UM2ADCSYtzcjcyclCi3GsOaw?=
 =?us-ascii?Q?/qcu7qz3fWzTCjHXOu2xGOMMYVZSWipe0x9KUT1HyHEsxByPPOV1X/pnyxJk?=
 =?us-ascii?Q?jAqEYrJehnySbpyImF8JRJ70zg80ng5G5AeL1pilvvcv2Kz7zXjdaHbU54GS?=
 =?us-ascii?Q?MI5mgaNlhfwr5gKRiH7HytYLojGj/6Op9q7uGPsHe1frjByf666bs9DUezHG?=
 =?us-ascii?Q?VDwMf4fd5usxcaVWnVDpUHvz1cDCRvMdMsv725yCE6/v/pWpidWAecDaE3qT?=
 =?us-ascii?Q?oGPrlGDm0VWnb/Uu1T2Du3YHe++jE1s9z3LYUQ6q4/btf8cNAlhL3wHIJIqI?=
 =?us-ascii?Q?HbIoIXaxlZF+7RQvrfpwVSU91nja3g9LSRackrf6n8zuJ72414olwK4I7nNG?=
 =?us-ascii?Q?5T0na+OPGm4FKrxj9wGDhzbeHB0D6s9j9UdEJzGwdpkP0TR/TYILlXcR9B8H?=
 =?us-ascii?Q?fSixbxac8a4T6DmsXt6oXTqLsOqshFdl7j+90ozETzV6JJHbfY+GUecJOYDZ?=
 =?us-ascii?Q?kDHQzVPDdfvwDfVJ3Ozijb5vQB0KTg9xc0wcTAwBDuEEbKvZVffL1sSd2yo0?=
 =?us-ascii?Q?Kj8nSV4e0eoVmAr2WSvLsAggmG5DX4lzDDjDdvJV0tbh48ttQ2Urf+b93Vvk?=
 =?us-ascii?Q?vmoqWPDF/TjGOYrsiLrKxjisXMDLgdwiyjRxIMOjRFGarhwp1XUk5hK8VybH?=
 =?us-ascii?Q?Jk68vCO1DAOuGqoafJ3rUQtHn07uMjxnlYrPFR0daliMf58j1h/L0OuDRCBY?=
 =?us-ascii?Q?Ta1jrH8daMHooTNjqrzC/VLUlScDc7rhHhpVz2r3bmpcRzMFHr/4tKau9FtR?=
 =?us-ascii?Q?vwuTbsQeOUsGlPtuHmwkKySPlDXSYOpHoORkzx9DmWCT/RcloMLI0y6Wfa3z?=
 =?us-ascii?Q?faiNAb0HN+zziWTVQ5bEtQy5IFNHx8MlllqJ2NXVpBqlogNW4si2tG0vUbyy?=
 =?us-ascii?Q?ap1Yg2JEPEd/FHR8CCe3bHIrEnJObfc36VdobSP4mb77sBG8HO5Fzz7CnG1Z?=
 =?us-ascii?Q?u5rGy/mA+DvEFtd9WEGRtw+jEV0d6CWNfEGC2VSpIh6zKiNceyeSR3/cDCbL?=
 =?us-ascii?Q?M0QWQZKafqmCjnX1IDBOojxU5H5GURxoKL4gU0IU5uQtXzyuobDmDvnPZePy?=
 =?us-ascii?Q?M4jpBRBtfzUWQApMe7UvNEOtOgXnQtDXgNevheqTDIK+hBq/UiswyMulPtr9?=
 =?us-ascii?Q?sWyGoYIv6rCKMdpEhsCBatyU0Y3t74FCs2Hkje5mGWThCru3bIJF30MPDisl?=
 =?us-ascii?Q?f140Lbp5T+wYMyBKclLUkbi0KNIWX4CsK8ee+YdUbMETyEx3tNQRL239uisu?=
 =?us-ascii?Q?JPqxLQHIVsEoFgPKn09h12pmHpHEysth1BLI3XszxcuKZYCy94WQ6DFrKijO?=
 =?us-ascii?Q?C/SJzHNvu91Quu0/I241hSJgzkwg8oLEBMkRBb6PBwerCpH6poZnF50f5Ior?=
 =?us-ascii?Q?wMBgxQOjeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AH78OE1loruQifwVU7HSYLlR7CpXaAZ7FvN0TwsSbjniK5dCS81PmtAkayRTbPYBIV6Qy84+amdh/h7V8NLlfEsNU1v2VPLu5WxbPyv/AeN+HjiAN3pU9jScHlcS7BVUnn/vWiunKIDxGKroaDzNYju1Acyvarz3oVByFC0npgVf+uAzk9K+klIMdIstFwq1zegN9JSm4QQYhI8/lmNYWx7uYu665DDROHk32UOtiqRQyFsg6WJLsHH/h16GkuJCKNLYB3PwzmCRW7OtGdKkjetXOxvgCzbySEVcj9EEW40/R8ZaQuQOklXOWo75D/JNoMjdKLid+atxZNJIS9zJSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6864.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b177e2a-e690-446a-76f2-08df09d028dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 15:29:35.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ZADZKD5Z4ryszZnKSgtyj9US7z3ggYK7b8kH5uuxwxbehVzYAKxAS7hg42r5mHGSSGZcvc0l6UPOXmKa+Qm3HTl9iV3jcAjpdxrxx1jXus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Yury Norov <ynorov@nvidia.com>
> Sent: Thursday, September 3, 2026 3:21 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> netdev@vger.kernel.org; open list <linux-kernel@vger.kernel.org>
> Cc: Yury Norov <ynorov@nvidia.com>
> Subject: [PATCH 2/2] ice: drop pf =3D=3D NULL check in ice_pf_state_is_no=
minal()
>=20
> The function has 3 callers, all except one explicitly require pf !=3D NUL=
L. Add the
> corresponding check to the remaining caller, and remove it from the
> ice_pf_state_is_nominal(). It makse the fun function a one-liner.
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
> @@ -1705,9 +1705,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi
> *vsi)
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
>  		dev_err(dev, "Device is not ready, no need to suspend it\n");
>  		return -EBUSY;
>  	}
> --
> 2.53.0

Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
