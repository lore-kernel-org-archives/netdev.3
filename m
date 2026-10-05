Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA73323D7C2;
	Mon,  5 Oct 2026 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195728; cv=fail; b=Feeratvl2UedSX9R4SSNkE6LyTJ0JonUrF7jfYmIlfqRMjvuz6sJ4nKWkeS04sVtJ6myoavFtVZ0CtgOV+fWypZGACxg3ZyFvhkLhzHLv9voyCLznpBCDRg4c64UOFKhAMnHBscJtes2vpYCYcgjANDEt66dVy0ie7kNU1HOV7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195728; c=relaxed/simple;
	bh=8//gZpu+WtGJp3px1C9EdBLQciNG3xUcva/i0xRez78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXbhwq2x5oBm3tPNjS5DbxOxFrF4VMRkfej//mFMGcYwyCkYfV3P59jpGtGdw/QuFiifcZlgfKi3RvNBJFywYjdXm1HFV3sWxS3NSJw33J9Q062KhsrZXVpVcbSocD6EGbSlh5x4E+msejustPgNxWavWT3U5cOu48/PBrVfMxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou7Gz1Ll; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou7Gz1Ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791195726; x=1822731726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8//gZpu+WtGJp3px1C9EdBLQciNG3xUcva/i0xRez78=;
  b=Ou7Gz1Ll29DK6rdNDMswL/ig99HB5e+g4e1ZPXzJpoZGtpn3uo4QMgQN
   xj+ugdQx06OYG8IWJ1qPNs7bW+9HpIOb5A69pmpdpzLiNylo0teEf5Kv5
   D1f8fsqd2dnfOoiWjaGE/DlTSV567qWNM/shAfTWAGPXlwdffjAWXGdf9
   A8Tm+f+NiCLYmf5ZF9QMIR90R06/1xAYzcBTFoMz3BBREgi4kdOcnZxeS
   7JO2ri9BeBvVEwD7zdJ3EX+3csTqAs02RpP/sxocug3vHFz5H9s+mw/ff
   77cruh00picOoX/Z8UKwkOzaFKsZG0pDuGMPalKaWk2m/SiNtya/lqVQn
   A==;
X-CSE-ConnectionGUID: 6IYV3tVNSeGWOUrFkTEQXg==
X-CSE-MsgGUID: MaNmr+C5SxqLwEaL+ibNaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91887435"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="91887435"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:22:05 -0700
X-CSE-ConnectionGUID: YhO5rviUQ/iARyEv+5jHYA==
X-CSE-MsgGUID: WZX8nt4lT6Gwlj6/UPrQTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="276877236"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:22:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:22:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:22:04 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.51)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o60+GQet+zSpUjCD/oTbtX6Iy13P+3nzSA8i0LvSSnMFW/JGni9fNGR9ogVTlg/vl2TTxKm9CgL74qoo9ENzuQqGBNYqoNVFayvWOOL1/Vg3kTbXP5z+W+II048Khl1QH/Pl9F+7k50Ub+NnN2oCjUid6kYv4bVr+U+izB7QfnUVcxtWC1HxioAwLfgNbMtEJCu97FbE9ckoSfRLPjOX3phNQLOmR/NYvYzCT1OqBYnIUBgVAYP0iA5KhLAiu0IcW4pgiklljRgr4Pmqx95wcbrXKNt2DWnSmZG7MNWyErbTKTiVrGzjyfu0zvDXM5bjsMyMZEi67qcKqq27KnhBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8FvGX65SFCcJH06X69kaXd+KjiSqTYGXxfk3WppfDw=;
 b=WIOA6aKOcv5NURdrFHKg7GvWkwtkmdB5wGIWhHbQStRo0YOtPk/wv5SeSrlH182wqtaTGSEaFPHmk1EQHxoU8ejdVjW8zZAACcOOVrDmbj2px25WXruHnwVPq6eM+S9UU7045Cs7+gpxuubz3p5E3ZQLFsttRYv3OLsticnGPZgKDSSul2o7AUbUj9Np+jNswSf26UNZlVPdtJO8Mk7rLnwdmaxezu+ONeMHaxITsOfIrTqDrVRS6GxGnx1i10Z7MtepHn8Ktafrd442EqRHQU0xXR/EFRUaF3Bic3FYvviWOey7BXwUpnjwWtRuREhUBrrh2WqXbGkWTa6Fnwv82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:22:02 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:22:02 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Yuho Choi <oss.patchbox@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Simon Horman <horms@kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Hay, Joshua A" <joshua.a.hay@intel.com>,
	Alan Brady <alan.brady@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "Burra, Phani R" <phani.r.burra@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Thread-Topic: [PATCH net v2] idpf: Fix vport IRQ name leak on request failure
Thread-Index: AQHdVCuqbh/bp+z5aEWZluHJiVH7l7buvk2A
Date: Mon, 5 Oct 2026 10:22:02 +0000
Message-ID: <IA3PR11MB89862E926E53936B2C669FCDE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261004180954.163789-1-oss.patchbox@gmail.com>
In-Reply-To: <20261004180954.163789-1-oss.patchbox@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: a91dc329-de54-47e5-5b0f-08df22ca7f10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 6t39FStagQyP3Hezmy4hIb7zVArxwhozwKczEbgibarVvokwwreQs29CbJaX64ct2kAF9810vQYfzR5XpPiBBi8G068qC6YwpK6eN6jAnel6tX5YzNkpOXspG8QeaKw693Ngr4F+AkDplciwkuNrRRVveeaVhswxhh9y1nl9sxPZEdNtCvV1o8sh7YJG1H5dfGJX3REVG85joOJ3uA+WqcJUdNDtQhttjVwX3XyKcsIRr8+PU++yHIcSJ28uxal6t2uOHKgyO4xGS3x4a4MYNUmMyGMdU0MX9gQTyYvErQHw3EGQIHpXyL1J63mRGb1A+nvBxKnFpLeIvq1ba+frkDRR4HHmKyjDqglWwaPTVArVjt6Y2Wqms4au5stFzZiTYFoF0VYI7wDwtVhEZgiu5D0lWH/deS3IU6Z1KzdTK6H19t0PG2Ajf/7c6oZEQWAptoAjUsnPClP3XR8NEscG6ecPpRCKuF0hQO8wE8ipGbnCjXunhNSm6X1awlGNE9k72Cs9pNmFbia3V4FU6g/+e5nUWNGN4PlRzHmoF5560h/IDWAUAPVCeor8VmbwAGEm7X/CMmPjvrRRM3AAsn8Sqj5HFJ3yDcmlyNsigbfHgI7AygZXTQlWxPMiWljZUPxd54hh5vP7GrfrNbN1DbCded/SX/f2DbbymSoJhkmGug3suYKFwTz4ytU/SxloaUM6laj4Xc5sAiLGRzkqn739f8BZFXZEFWH+JA77zhFmJuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lg1vnatv6PO4EzcaUShrHkfHuqNdmJgrduxfzXT7hekXwvrKBMIHTw9jFOfI?=
 =?us-ascii?Q?rJI7u+wfQ/Z54hxn9xMPbrhDB8vlfvO8jFMiMfnAreP4780Sc4hH1Yr0ykr7?=
 =?us-ascii?Q?uKNOhUsUP+E7OpbmndsNDv+dkhTzib6UuxlR5VtaQagb6U5e57ixV82uBCO1?=
 =?us-ascii?Q?DJ65oCsI4yQY/2bnyo7yAL70eYWAlXVISYC20gPICi/lkGiRUAQ4xbSCx9zA?=
 =?us-ascii?Q?AyioPmwfkxFN801bGTrMFTeIfOppRq94iQLVhTaCYe/Gi2LMp9Qhm6cq+ufe?=
 =?us-ascii?Q?5Ad81wuiGc4ljmiI9rA111M5Wa3rMUZGOu+sVpeGAvvCMMFD7U9lFMyClbXj?=
 =?us-ascii?Q?xF6HzgskePhPrhCx9laA1ETBvfw4noonA58KyVCB/dml8pAr1U+SFjle4uff?=
 =?us-ascii?Q?NGgch+8oS/bp76oE62y/BeheQYiX9GwjqRTvAKu0dAqmBUjvrNWFjDPBTwWH?=
 =?us-ascii?Q?GayGEdk02ERg2uAWff9R4xs4juArff/CFi+ePgy8gMI/qkrbnNpPEbtKsCCq?=
 =?us-ascii?Q?KsCwsW/B7+47UiDI+T8FDe9gr+0yhriDHc4DYtMzA/NU65IByrltmmtKebT9?=
 =?us-ascii?Q?M1L7B1t5j9UZK5UWOeP14Xe8Zsv7Igt4YapAm+drSc43Zzf/BzDWjiBX4qwz?=
 =?us-ascii?Q?76poqUizl/KroSZdiyedD80QVO1p/V+b7Iz6kplBbl497nJF1DCOfCb+TLc2?=
 =?us-ascii?Q?cF4DelmwOdF28xW4twErhwI4lTLUYcJY3OfY/KHS4n05sXVBjMF+O9ABEydE?=
 =?us-ascii?Q?+HA98O66IFgFDdPYTFJ5b2U8vlB0UitkSzmcy61Pomm4NtdHMKuVmSoTKMEi?=
 =?us-ascii?Q?Xj0bkMMF4I9vAyPfG8XrfCckPL1aMOWlbjI+/TP8KGlrvjUOG11vo6N/wpFt?=
 =?us-ascii?Q?7ok2eX7tggggge2x/tqSwS19YTicnrbjDosWPLWyT2pU5L6SCgzoi6je4c5O?=
 =?us-ascii?Q?NdDGk8F/fhsVKDEpdOoAu9Ak7Gxr9qYO9EKZAsITG4DZ011La9UUUqSzwcm0?=
 =?us-ascii?Q?IvNOUzQJSmViRJo+WlWfOEv7SL0oJswXt9LtXo/IT2f94Dobtq9ZAy5BYp9j?=
 =?us-ascii?Q?jvNrdRzsFbgd51FSsRcng2QTWKwW9VV6jpKxiN7bhYJCqG/exkmCvweydjxT?=
 =?us-ascii?Q?P0kC4vOvG0oORb+cyhwzgpWzNrUlGbVb6PVHEZ4l+mgVQtpH/kDi0rbbF41s?=
 =?us-ascii?Q?9X13LMaNwEufb4Sn4c/WlA89chm2Rbubj/DKsOf07+K3uzpKavLSBJkWXvhp?=
 =?us-ascii?Q?Bkzf9pj81B/3JZ/hKG6Xlt6MSwIR2Mve0e86K+gPqBuJwOp2n+fEJQdnrtKn?=
 =?us-ascii?Q?fRXtsCD11zIF2dpjCSZnwE8TPTY0TrqqCt0gq8rzB2Ec2m8Jf8u3EfFEcYlG?=
 =?us-ascii?Q?B45UDkxIQf9kT2tvXAcWkr1jkFHLihJLtpF/SwAMtbnBqCm1Z4RNbRqPbd1j?=
 =?us-ascii?Q?3EbQyjUOE1Ld8/PYfvwM7/30eGO+uI+U4KC8FE2SyqdST0xBdwESMwUnm6qY?=
 =?us-ascii?Q?VpRYGganzAcmKtOrQPnXsj7tb6LvLY/O5+GbMC4NtcLcUCMh+y2ztaREAFHg?=
 =?us-ascii?Q?pslkNOW+OCBiR6+MIM972U9wbWX5KbZZD7qxaQBawpB3dSFZyn9fr3m9Gu5O?=
 =?us-ascii?Q?758jdHLuSXobTaRQ4MuaTz8QjoLyWJtcBGFPjlJl8k5zhabZtizt9mLWwIcn?=
 =?us-ascii?Q?APDJjQ8PXNBajoVcjLT2muw5PRP9THNPJA20Wus+v/6x6KWdF1AsvU1sHUIm?=
 =?us-ascii?Q?XRnGPCxCfVhUPM4gUj3p70m/vL5JaGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: txqxJqFk1nh0fFuMRk/0EZ0lNP9yah1XMoFng4bDfRT/Z+7PbI4/jbZkxvX2xygmLADsLOdovt5cRMryD77nHPbdW2l+BEu4DZl+lr717YGO6WmnLaAioJjhOuxQ4hE5vpF26/w3zcroQIf99eDmalXBcQ5AcRnbM+U9J9VYH0/zJxJvDOnOv4X0b71hvmZYQcxCHbfg4QiHt5zT79DvHXl08AZtgAWd/O6oAbTOMrGtUfpxOiSKH7R+u79o8jGIcKPlLijAJ9dMQd1jJxAOgdLjkUflW2zOpkLhdeiWQGRm6cIo31goZtArSvqN4kuUkFl1MKqG3Y6So5BNOkkfZQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91dc329-de54-47e5-5b0f-08df22ca7f10
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:22:02.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pan0CKDyHSShpBLYatG2XUzKeaTnKqu1uM9kYXr8/Lz/0r9K+TO/GhT3CdAz4WGAtO+8UHI6YuJZ5YQs+xOu/q18Y5/vV1c+67ZEjUjAWsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Yuho Choi <oss.patchbox@gmail.com>
> Sent: Sunday, October 4, 2026 8:09 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Simon Horman <horms@kernel.org>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Hay, Joshua A
> <joshua.a.hay@intel.com>; Alan Brady <alan.brady@intel.com>;
> Samudrala, Sridhar <sridhar.samudrala@intel.com>; Burra, Phani R
> <phani.r.burra@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David
> S . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Yuho Choi <oss.patchbox@gmail.com>
> Subject: [PATCH net v2] idpf: Fix vport IRQ name leak on request
> failure
>=20
> idpf_vport_intr_req_irq() allocates a name for each vector IRQ before
> calling request_irq(). On success, the name is released later through
> kfree(free_irq()), but when request_irq() fails, the error path only
> unwinds the previous vectors and the name for the failed one is
> leaked.
>=20
> Free the allocated name on the request_irq() failure path, as done for
> the mailbox IRQ in commit 9bff30482c10 ("idpf: Fix mailbox IRQ name
> leak on request failure"). While at it, fail with -ENOMEM when the
> name cannot be allocated instead of requesting the IRQ without a name.
>=20
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Changes in v2:
> - Correct the Fixes: tag (Simon Horman)
> - Handle kasprintf() failure (Simon Horman)
>=20
> v1: https://lore.kernel.org/all/20260923234819.702327-1-
> oss.patchbox@gmail.com/
>=20
> Compile-tested only (x86_64 defconfig + CONFIG_IDPF=3Dm, W=3D1).
>=20
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 4311ffa30bb1..af3213eae393 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4067,12 +4067,17 @@ static int idpf_vport_intr_req_irq(struct
> idpf_vport *vport,
>=20
>  		name =3D kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name,
> if_name,
>  				 vec_name, vector);
> +		if (!name) {
> +			err =3D -ENOMEM;
> +			goto free_q_irqs;
> +		}
>=20
>  		err =3D request_irq(irq_num, idpf_vport_intr_clean_queues,
> 0,
>  				  name, q_vector);
>  		if (err) {
>  			netdev_err(vport->netdev,
>  				   "Request_irq failed, error: %d\n", err);
> +			kfree(name);
>  			goto free_q_irqs;
>  		}
>=20
>=20
> base-commit: 551c722f40809618230001baccf219193e22fc5a
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
