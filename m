Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950D37C0E2
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140228; cv=fail; b=ETniLwq5LgtLjeNIIsx/AH3E546B61nxKGCPTfDDyRIayKo6KW/38ce7OW5gvAS9uVjVO0AIRSb+Eu5UltAQjjR1mEiDn3RhL+H0OR27UFcq8U3TaZk8/zBYTde+LaTwBfTB9rfmKg78WnWnABL+zc1UZl0DBJbR6mA3PcvbO4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140228; c=relaxed/simple;
	bh=dO+uPPip/Z4W83kS/NdBuueNLo/cGZHLi8+pMAOUzT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sOJKmeheLQFXiVg/1oJVLSDbpuc9jQTWrtiqCYv3w5cG15omPz3oAG76H8RL7rpGp6PTSvbKCobimz3l8G5x6843pCgd2XSm/ZAanbl6idqb+SjqWSZQ+m9zUGJsb3Viq609da5OPO22iR8qsPLxae/ikKPn5zckHul8mgKEGzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niI2ExJ2; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niI2ExJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789140226; x=1820676226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dO+uPPip/Z4W83kS/NdBuueNLo/cGZHLi8+pMAOUzT8=;
  b=niI2ExJ2Wn9goL3w2qwXiHsQ50S5AqAYGFGcTaogNZGcuGYhOGoKoc90
   +mGZYxMoiRFG7cg9pD9P0tZMJGvIgr943d7HVegwvmKXLi/jGTy+j5/Lz
   SVbKPh7ezTUXgp/ilzwESpgBFr6zU4p+2N6APuw1VVYjcAMNau63BUXVt
   iwM8rA+ttRRHm9TKkH1CRm2L2fl5i8F4qlY2WJOuOnlygSiJgU47IWZhz
   UEzkm772Y4nhgFk+6Xgg53p7hQ1khYyf4F6GSmPJVDlKYOPSYPxkS6utX
   i0n2PJy1o74u3bytKBwy7I5QHiRobqTy4jObneKmpO5dUlGHZ/K4O5VIH
   w==;
X-CSE-ConnectionGUID: Bcc3+AvLRlS1bAlwC36cQg==
X-CSE-MsgGUID: kf3xN2l/QYWJnVFDJJT2IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="99933495"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="99933495"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:23:45 -0700
X-CSE-ConnectionGUID: i55yxfNLR1+4y8N0vmpCgg==
X-CSE-MsgGUID: 77grWWBzRGOMJZs6gJ7+PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="267653025"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 08:23:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 08:23:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 08:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fs1XP8Ro0Qc7Y1uUaVo6tQzlPWjD8QyqS8f+WH55HKNELsHkUOt/UV/nqyIc0g0GqNameH5eukovqF3Aj/Ik4hHSlFc0OKYzUxHdXEhTsosQY8dRhp6vFeFi4Up12wcySMKb9VrUVoL7ZTZMVZA5K5895sICj/1Rsr5Z1eGLox4ZrpwIFavSetXQOkxhkUSQKsiPaTUMEpswW3COfcIO+jJOHmk6K2nYQn/1ZwAeNXnCIiuHo7ouCXKGf6xRuzk9mT3QPF/dmwRjarB6Pe963iwzHFQdLOUWSfrHAgXm5iC03zD1ByE8QWY0UhZG3WMFAgrhDZZKKT32VgjhRSyPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO+uPPip/Z4W83kS/NdBuueNLo/cGZHLi8+pMAOUzT8=;
 b=fBB/U1phBsJk9++nEEUowN2Ig5+/lLNGgTLo97as0hZcCuL1l8gIpTzhVZcbiAcFQ/Gh46uZ/GV4K/hFFNDDn+IUeYtAYlPS1iI9JlhgVg0VmIdK/Gvedcy+iDfteHaFN2qlg/ey51RbXS1ZhDWAknJQrRVraT8JHJMdgN7c4+qZDlqsoqrCf6/bIPjHN2SA4rATz0QifAoLxFRXpqF9LUlozVJiAam21lkzU11lAHs+IeRSPnR10NJEeKerf3mFhPA7v/YGLKtXTFrODs1KjUkLmLrpo4yXSJ8XTwF4mQQmfnrPDGSnWqvCSjeeWRhUFbtq++8V7Rb8z1oUrVC7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:23:32 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 15:23:32 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "mheib@redhat.com" <mheib@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v4 3/3] i40e: trigger PF reset
 when re-enabling ATR via ethtool
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v4 3/3] i40e: trigger PF reset
 when re-enabling ATR via ethtool
Thread-Index: AQHdGqxzlbpi3FI1MEK1KQjzQ2xDBLbJbtfA
Date: Fri, 11 Sep 2026 15:23:32 +0000
Message-ID: <IA1PR11MB62410B7BB20E8EDAF4AE646A8BBE2@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260723140510.184819-1-mheib@redhat.com>
 <20260723140510.184819-4-mheib@redhat.com>
In-Reply-To: <20260723140510.184819-4-mheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|PH7PR11MB7569:EE_
x-ms-office365-filtering-correlation-id: a1b9760f-00fe-4439-6bb9-08df1018a3a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|38070700021|56012099006|4143699003|6133799003|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: BSzj2qEo8SPJfozZ1+UPc2WhFpPNxqjsD/rEQtzKEkdpnz5i+gLadQqgvk9g7HaljYG4b/yM9XYSQX9sFqGjOY+wd6SQocl/LqlHJB3Tp3pDB3SuiBAh6So79vCkJCzmkjpqNb8C9qczxiLm1BFbcYp+Rzeq3XBj4qbiWkSJi/wF4/2bDJw7IJri8Was2byshZePjtalAdA/GzgumHoRPEzsYlfHZgnHk0BmMv4IBbaJxbo6082OeCwFlR76BjgSo88DYizIIhR9b8a3DSEuGkfw4EIXu/ykb2gAQ7HJWGMnd4vU7vHLxmTHNjFYJmbuXjinYfdG6WMqrqUcQDMenAXBwreQ8KWVliTsF9p2bEZwPHbyVTDTdvpwoYOcPGhvcT01glFnOQHzNGjQ9USATykgknlit9im7EatA0d2+jcz+C0G3c9lQNikCp1OlZfAG9jTs1/4+zxyr5Qfu1XFx+t4ViYUKYu14rQwG+HQDLjyu78o+RN6FKtDRj1r0p1D7Ag9o6ziFayLk9vGGsNv6ErLjFzxC9UhuQYeGvHhu6WAodfTCmBkw9A4K6TusHcV3E2BgCefrYqm0jLFw6bbUEo/U2D0QTNbuI7TkDA/n46pDspPCZ/Fe4jmT7+Nvv7ytAKy3oIsN/MCzOAboKOiiQLJN44jApIy4a2fc52PKt5MO1LgRGiSShgTOexx1tZcF+/2dDfZIv/lrqT3/8JuJnC/zekHlfh6ZpkbBMEvTxQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x1qYfRvUw1wmamGMP4n5Kduc1/cH7VvmTbjJg5QtLI8Qe8KFpA3Ycc0tznAj?=
 =?us-ascii?Q?EbFEnfHsWyB1ae1PtD60eemBARa5OGoGmdYkrGvasHZ8MzeUFy6wrdjg3xfi?=
 =?us-ascii?Q?Wg5zkXTznFkM9ZctwZe4aV1rTFZJTa6Lr6YH+UWPPQs1Cquwac2lvDPIChkL?=
 =?us-ascii?Q?Knc+L26FkIlt86DG4nbnuHSUhxdyrAikPboPtRKruqcf9TzCQ0ATiAhgMv3O?=
 =?us-ascii?Q?h6uVWK/sX6h/qW75engPda9AnwOMuCvK4U4/GIkAufJgTIzgYzMUlRz7lZyV?=
 =?us-ascii?Q?GxMfsPP+nQEux85+mIIjAtH0OQYGlwQKfSf6B7GJGtVxubz9yr0ItbXJxSQI?=
 =?us-ascii?Q?uUeSDeZ2m4LcV2sOh/ObICGo0O1D40GiAHik55RxvIDmVJ2qxm7R8MrxMD7T?=
 =?us-ascii?Q?c2+x+AW90x2fjYNxvLBsmjrrp46jUPGcJlaBI6CI5qQd16e9j3tlA6JKSnJn?=
 =?us-ascii?Q?G9o135xQCunT52cRUlQrGygMEUSOXg+SaviNOTicie3pQ9vNmBwJXWIb4ilE?=
 =?us-ascii?Q?pOK6fwyHjZPfNL0WsfXYVkpEaRfBi9JAfPT4eHyYbvFgF8URUnWcLUEsObNO?=
 =?us-ascii?Q?1hm33Dalvp49g2EMzqLdiyOTaKV6i84OhMkGYGsqC+3HF4W4caiK+DOiSRDu?=
 =?us-ascii?Q?RkcDGS3DT9Ipj0V9Cr/kKlZrP+hDIci5kRt0bg4ISFz/chCmGSuQ2ubWWAxy?=
 =?us-ascii?Q?dHgBPz/edoNQHyRWk5hxqN5K1y9OjxcAG4RUjpeBjhLOYfgz6UTRv7hRq3ku?=
 =?us-ascii?Q?dWtAS/qbzV9cEd+bUna8NaY5vu9hzguVAg9RKM5HVj/1F6QdYsExY0WyKoUF?=
 =?us-ascii?Q?i0uZb1slRYoc/F5Zh1XxKWWTnTs2Oia+HT1UmVcz75pNgjYfqmn6WZVZdMXL?=
 =?us-ascii?Q?MVPRFIOhhTHwlyrBeIpuJhd04pDA6PwvQilWUkt0XbGF2W4vgg2Ft9SHwdUf?=
 =?us-ascii?Q?5eXuoWjv9R6xYVdumvojuBHQQg29vxDKl1Hq+FnrmZhHdU0cqOdVhqn+ALLh?=
 =?us-ascii?Q?MeVvQQ1HKx8yEih7evo1hTNQtw6egWyR/t+wB2rGK/KafrEYykHGMRN1M6d+?=
 =?us-ascii?Q?d4UZH8SAypEgslCwALEJLdc02nW5pWCRAG9L852/Yeu5wOmTm1XtahLHX6n5?=
 =?us-ascii?Q?wkLXQCC3HQ46PMztfIo5T1X+dfoZufK13hyAoeG9LwQpRSg0i2yqAdexPs7w?=
 =?us-ascii?Q?XQN8GtbwV0ByVenfCTdL3qjgHcyhbTjtjDuSUewElk32qKunpH6EG6omyTDx?=
 =?us-ascii?Q?mFY6hGKgz7fZ7HNOkEt0FVR7NKNW5ukiM7I2YwIFCeb6Ze3gD63KCjX8I4AY?=
 =?us-ascii?Q?UN9ussnqZ5pAPGLDOICV3nJn3LBlBXLf3Rb6r1vvZDMWTcGvZCd0CUsHVM+0?=
 =?us-ascii?Q?ZIRyV2smn5sjj9iE7iaH0/omvaqjpe7hwl4E848SWvFJXxTaeUGY1Q9qa6yk?=
 =?us-ascii?Q?Up8OM4SyeFfkuaVCsOr5Ly9onf2MSR+/fgBCV5HIB8UIzLsM0np29h0Y0DIf?=
 =?us-ascii?Q?eDjINk3yciNI7U1ZeunbDbIW8PTb+hk2TNRP3QS9M3sNfja7WpXtiN+zs3zv?=
 =?us-ascii?Q?usJKCvrMUW7TDvHvsn6dsNCbPQFWCx3+mxGE0YtysYjd8FXuRFr7BUjvGYnK?=
 =?us-ascii?Q?JGNrSAg7fvMphw7XNisp6euqG4oHhRV6kwlYSyi+YqLkONw75XquaBMDYB0R?=
 =?us-ascii?Q?ImkrrkYgvVhhTsjBlBYIXBFnRJowJf77EuHK3JivpgJ6CBAn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4503YYgt3Cy4lODK93Qx2llYdaT3w+iv1lMDDob9d93+7uORiUbqfhcRS9pXbJFKJRC685cCAyscb6Mriq90i0qOnR7/xpLoHuo2u8L/agzEARe69JSJwFuC4cAAzDtP1ZTYacgyzFJ7VI/T0w5QIs90O3vgq4xPylRo9gYuDFBTli7emgZj2EVfC4+YYQPK4fskHHmKxUlIsax+LnYM0PVsc0RDxiimhhfMp/IBfYaFhyu0XoAG3/punrHzRca80aT2Oc32Y19g8ILWUpiWhEkU6s8Toiv86IspomOEmGADCfSMmV77eijczeFrix07xqbrnzo0GfMHrBF/Jiyc5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b9760f-00fe-4439-6bb9-08df1018a3a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 15:23:32.0469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qy7hKoeXfSKD/UJYNuAbjQZS677IAI3PoZbvV2OUzeYdbG4bPcTrj/eypv/BUbfiopUE3YKoHXOMkArghJbmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of m=
heib@redhat.com
> Sent: 23 July 2026 19:34
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; kuba@kernel.org; pabeni@redhat.com; corbet@lwn.net; Nguyen, =
Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kit=
szel@intel.com>; andrew+netdev@lunn.ch; horms@kernel.org; Mohammad Heib <mh=
eib@redhat.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v4 3/3] i40e: trigger PF reset=
 when re-enabling ATR via ethtool
>
> From: Mohammad Heib <mheib@redhat.com>
>
> Toggling flow-director-atr via ethtool private flags does not trigger a r=
ing reset. If ATR was disabled while fd_ena was cleared in the TX queue HW =
context (e.g. after a ring reset with both ATR and ntuple off), re-enabling=
 ATR causes i40e_atr() to inject FDIR descriptors into a queue where fd_ena=
 is still 0.
>
> Trigger a PF reset when ATR is re-enabled so that fd_ena is re-evaluated =
based on the current flag state.
>
> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> ---
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
