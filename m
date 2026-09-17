Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684B4AFE2C;
	Thu, 17 Sep 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638025; cv=fail; b=WVmDwaJEvqsMcpnrmOAXo31JGzflE+xrpgWYKphFyvOVQ76BRx6fNM3J1JnRflccoPAS6hcLKnIGqCu6S5D02PLU4q8urTmEa7wrUf7FLNJmiIRlYSxbcih4YVxtuUUe5WuyNNjvrAr3QqpSK43tgtaecW1zCzNx5CVxGogZSVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638025; c=relaxed/simple;
	bh=LztIpK1/2r122nrRuUAXjR1xClSoSAb3HIsQ8Oh2+7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVpcXJ8zRVoASUhDpeXAY5hy16DdahlWc1dOJRsPSOjyKFVLkdFUktrV0l5Xu+2qVv5FtO6iY+RAkxUytsD3fyyUu8XK/I7Zjzi8pRgXRm3+yto7JdStYln2+bcYAFXzlYrgOwu01zRKoQk+slUW7+07MwruabfhUMeDQtJJVMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVA5GczX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVA5GczX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789638000; x=1821174000;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LztIpK1/2r122nrRuUAXjR1xClSoSAb3HIsQ8Oh2+7Q=;
  b=NVA5GczX5eqRYTWfz3iWzcp8JgZoKxgfGco2vEpdeZ1HT7HaR7PFVysP
   cyGYBdLWHfYAOduV8jAp7BfABwu9pUYR1zmobbQEHfWuMCJKWrFX2z/dJ
   gwKf12Azio1odV3yVm6Zw4wy/bxTI708hpUYMw7iK0wJ+jNuTMUPupfUY
   jl1H1z7mEQQHgo9zS8nzith2590o6O8vCvvrfOfLC3iRU8k+d98wDZ2Gy
   gfmpDRPfZdLQQy4WC9VPvDbR4oCRML268OX1RFdzNz7fnQFMOjeFnyXaa
   ihlIAC0Gj+7uPfAyRxNLSyyuq7Q31Un1uT55jLN8ku5ygxrLWZWImwLZl
   w==;
X-CSE-ConnectionGUID: hh1sY7XNRn+1ta3b1ggumQ==
X-CSE-MsgGUID: w/oJgESIQlGMk183NgxV6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77606973"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77606973"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:39:57 -0700
X-CSE-ConnectionGUID: zhNQ5vYoQvSF5NITrPJXRQ==
X-CSE-MsgGUID: v0sq76/oSUeYEZIfNmuvbQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:39:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:39:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:39:56 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VISBZjO2LsIFt+d+padWQNYz6g4EfXdbgVSvOeEDvkUN/IMRFF/v2CCgb8GCfiw1Ywa+O2Z2BYpjvKoKYsmqkRh5bUg92GLAfKroEl5FKseNbgPec5QlzoKSlea+yvKDZtCXEhJClvGx2+6vuwL0EPsDpS+nd+RcTSf604EYzGV++fOp6K9TCKorvL1KB1KxO0mksWWLO+ILw3JYYIoxi/XXNsCCjXaoqxh4553N2po1+bh4hyfk16LtUWe5jivR9vn71MtQ/tP8gXrGYgfglQps/qgN58dgeVJcdEunExd6tq9pIiohv18THJBrjt6zMZyWzZjUk5FbCeeE1HU2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQDw3S2bPVZLEnsaonduQw1rtUpf7wAJdpwxBRBW6n0=;
 b=cqZmazFaXz7mRdZWrnyANjl45WZwN9C8ku3hIpNgusD93vIOUa6zh2a1iPeJdMw0BjLAqoegvdPmvfU8bObPrgsYAxdXFERcxHt9Ka40OVUF0sJqFe0aO2QBGJfxmbsXBf2Ca5aMf4USvGRH8E2IiTR2po0PXLOl7hUCpc+Wpbd7f6nisX0r2DMG5hlR8N9Rpa6ivTocZMcezslW8ONxUFlhAbyqERTqzYALXnDRNyrSiICZQW5KBpS/6Iu3VmApIfRNX6n3ViEkhAIRM5xJHB4GwVtLfTpYrBtDbZMqS4d2+zEI8kbIPdfDhIdapKsWPkXvZxWRIlvzPwGAebde4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DSWPR11MB9798.namprd11.prod.outlook.com (2603:10b6:8:3c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:39:47 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:39:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "kees@kernel.org" <kees@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>
Subject: RE: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset
 timeout constant
Thread-Topic: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset
 timeout constant
Thread-Index: AQHdRnGwJp2KQgNESkePUelUh5pfhbbShAGg
Date: Thu, 17 Sep 2026 09:39:47 +0000
Message-ID: <IA3PR11MB8986514D94996F468E6344B4E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917065436.1181073-1-xiaolinkui@126.com>
 <20260917065436.1181073-2-xiaolinkui@126.com>
In-Reply-To: <20260917065436.1181073-2-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DSWPR11MB9798:EE_
x-ms-office365-filtering-correlation-id: 20549ff7-ce23-4486-91ab-08df149f9d0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|22082099003|18002099003|921020|38070700021|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: ky0MFsjckZfLk2noIJ3jqNhsuPv0/OKNWYlfetpBdD41HdlObgr2nGWNyhu1V3BXTfoJPvl4gYRKWalDsX4zuY2abV1c3VLihAF5dGNBsxY2aJGv1/N+QG/ows8lDtIWtL162/MZlAIdNK89JV5mNSZw8ar8Ylusbf1I9gPBypCQNzoBq3Ll87XU0pjc/010lBhyK37Acwxg4IX36GY6EFSWf+HYTVYZq5qx1cV2ypG1VZJlkE1qhbpmGrhHBYoHO2tnrccfudGdE7OA8De1zxhFxzvytT3BNxFW98BhxaiL3JGsPPkjfw8F0LgxHuHHXX5mT3E0E8cumoggNz65njG9c3/5d8p2VnMJ/hh8d44ZIkWr9Oo55qRsPYWxDKLY9A+2uxpogTn+3nNtWjvt4j53E495FhVPUIAyxEwZTgbSE5QX9S9LwAfS8geZzcgH8BuP3tQNoQ4OmnUeFlSPWyN2L431aNOhaDchasklQ9Yuy2n06QT6WH58TGo+L4MVvSVw7/E79zaEWppgIoU2r2ImgzDMhhke8fMfURGK4s3HrnjmVaNW+Fl6ufFDyf85WdBZVgy7wKBlNN5FEsYtKNPlhHBBDh1gdhjTagh3dHf++whuEdS7AzOWKW1UQG2kJNr67tlSvbrrTi6orek+IR2ZhiNQKpk2gZTSU67+y98uPdjoQanEupcdFepD12ZHGsDz4u0F504yyhOybfLa30tU5vBdwLwVOMh7dbX8rpvNOrjs1oGYbfD6CP34iTdE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(22082099003)(18002099003)(921020)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DIKXqYW2D6BOCu2ELXGdGuVkKSR0GrG8/PxVD2LtxD6C5QA0j7MO9p7ZpKmS?=
 =?us-ascii?Q?mGJCEo+6y/gNnbTyZE/SBvRJeR5HTysjTO4bwZFglQ48Q/HLd9p+ILyYMOIF?=
 =?us-ascii?Q?A/M2JSVz+dRs1jqxfSZTHXg79cvX0Qs/4M0d27Q8VFzjZ8r5Fvs5AK0K2KBv?=
 =?us-ascii?Q?j7dIEMPmQkZMrTjmOuILeNebRM1G8mORnBHAfyIWRYoti6DDq5bxOXkxP2K1?=
 =?us-ascii?Q?AhBm0JfBvA/INCmKfqiaqn32vhWCQUpeEZAaCK+6xGy2WR/DkCvXJ7Sdf4zL?=
 =?us-ascii?Q?hWXfcXDExaT0CDcQzTzaCguB/Y9HtPww5yY/4xdgL/IQI0mVYm18LAlq55mK?=
 =?us-ascii?Q?b7ztfm7G2TkBo4Sb1f74Xa2CvPoQ9Xb+2S0BtDwcevJgzpcrAyjylMMy6Q7K?=
 =?us-ascii?Q?nZRwN6/hcUxWvNZdW0gPYnj02SXr225l1UTqf/EMu8Bud/79CWzxFrxtmFUr?=
 =?us-ascii?Q?SANMT2nV/b1fp7F6J2A3ALJaXhbWD7Ju1TUVDCZejVtxHzIjV5quNZDefWlB?=
 =?us-ascii?Q?OMX00+ghnNNXTwqdlXEgavGc64dvkijlridt2eZYbSTHY4lUKNzUbEDKOlO3?=
 =?us-ascii?Q?gI3zX99lE3Qbtr8wusqF6yoNxev/Z1X4Z8Q3DfwB+zbjBQWnR/EgLZ5k182j?=
 =?us-ascii?Q?tLroHHwPuCgHEDoc0CjuA0LxRZcK7Gi42+Z9VZr7lt46vishC7avIP9eeqXH?=
 =?us-ascii?Q?+xMDPAK6TKINDpd62NgefKuAkNdMf5r9ta4p9c6jH7RS27F1c7v73tDAiqVT?=
 =?us-ascii?Q?AjQM3IGIOqOncDn0c4cqEoL4DAsLmnflOdLGpbNN4MqnwDd4W/JGauLUs1AD?=
 =?us-ascii?Q?NlTTP7P09Q0sv4alK/vxXtAYCsaisoxWK/GRG595/w94c6z6ZMpju+kbZwEW?=
 =?us-ascii?Q?j5YsJZzgLadk29cy9wf/Kt4hj+N/Ddysq2Hm3suLht0q9uqQbzOuJl0S1SCJ?=
 =?us-ascii?Q?WVmH1iWIIqX3WNpHj3X8rikv/OXbkGsyP7FEUbTQV246TgXgyZwanid5efEc?=
 =?us-ascii?Q?KIlRREi+YeM/eKwR5IcmfhY39YpfVC6pAVHUO+7oGXCyJuf3alAIn9RJlKWG?=
 =?us-ascii?Q?Uh6O0Etq09AzZ/k7zObBKGQ8VwSuRGgy2aziD+tr2pty0zL1qRV9ku8nXtTM?=
 =?us-ascii?Q?spEomSBZxdf1VCKeijumFP417AmsgdhCZujfxzPSEogXejRz+SXd+c4p5mGj?=
 =?us-ascii?Q?rh5Yqrj6Fe9KTXIJEmLNlfMPEC+duflepPahuACtNtcPjY2r+FyEIIBemkvo?=
 =?us-ascii?Q?fYyk45v29X4cUoiRxsNVKaZLP2A0K/RO7nbg0KOcfuG3G2ywA9rkiVTp6VsM?=
 =?us-ascii?Q?1WyfEMKEbHvSf/7NJaNlkBxxPvD3kU6lD4JMfOA+D0XKpqYnTLp4AQt5Nhxu?=
 =?us-ascii?Q?S7YOv6iBNlnvKc7cgva6fUm3MO93FPSKqKKu+Ua6E/RqIZ8/zHyMPJqb0hbH?=
 =?us-ascii?Q?rzCV/CNl11UBJjbNsAxDeYMeQUCKEufs7tjiwFa5F5ZHXfiixO322vzLV2Tu?=
 =?us-ascii?Q?WIWLsdj44VF5kEXK1cOmsBqhnH/eryXT39NJZ8CVcD+RCBRlKS+yuqsc8QMJ?=
 =?us-ascii?Q?7dn7+d7twS96NEpyxc0+LqSQmZJEoUpPCptIvhNvhYhpWMylBb+w2QosJ23U?=
 =?us-ascii?Q?I54Nj3dEXDZEYdl7PfOFRMNQ9/l0ijfZojn2gyc2Z+JYBgjXQXpPDQxbLIdf?=
 =?us-ascii?Q?hDQhrxL4NApWQBDVf7bF5As1/QZE5uF8HQ/Tuny/YH1UfBelNVxtq20xYGuG?=
 =?us-ascii?Q?xMJ0pWH6wvDsdXKPAU8MeQmr+FcUvFc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OpLC5Bhe76oKisL6hP82gpmrssAPt+Pt4tA7kI/iWTCg4p92C1ZvBdHf04KXqfVVvX5O9k7KRPA2DNkmfOfDjiTg7mlRjsai2P7tZ01nJIsLFOzx2z8p2oiHghACVmpTnz3vPzhIXva8hReb+6osp0CgpBIxjlH79DB9pwLw+CRHM46oVFJsYehf5w6x5WrxyBsTDDP8AGIfOsDV+82snnReYWppoKVah4VmwfPtyIbGl++hZwa+ighiJszkzHZGN7FBFpvVe1U2gHIicfxknDPGFoNNCgxTschUvEfDaaAVsNN+NTOlOs2hvQ1TBSh2aL8+aBD4obH5F8zeE2wKVQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20549ff7-ce23-4486-91ab-08df149f9d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 09:39:47.6269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NaL7t+rvvX+HexhQgIDsNfucSTYnILuTRehFsMJOV8TmpuMCqcQe+haCUWoRZiFZ37bEmndSXS+yPAuBD/tl/Q4KW6crEYnK2fgwjWaYDhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9798
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Thursday, September 17, 2026 8:55 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; horms@kernel.org; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>; kees@kernel.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>
> Subject: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP
> reset timeout constant
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC is misleading: the value counts 0.5 s
> poll iterations, not seconds, as the comment right above it already
> explains. Rename it to IXGBE_DEVLINK_RELOAD_MAX_ITER, which says what
> the value actually is.
>=20
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index 781f13240a0d..15b14c5a7c4e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct
> devlink *devlink,  }
>=20
>  /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a
> sec */
> -#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
> +#define IXGBE_DEVLINK_RELOAD_MAX_ITER	20
>=20
>  /**
>   * ixgbe_devlink_reload_empr_finish - finishes EMP reset @@ -464,7
> +464,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink
> *devlink,
>=20
>  		fwsm =3D IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
>=20
> -		if (i++ >=3D IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
> +		if (i++ >=3D IXGBE_DEVLINK_RELOAD_MAX_ITER)
>  			return -ETIME;
>=20
>  	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

