Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936C424D46
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505226; cv=fail; b=jTe6kA8SylLuRLhDxFCvKAygWNqZ7woKOtqYbry2OlupYTVeGWkNI92E+SyhjL2TwCCO/F6wdITa1bm8KHAASncZUkIWeetXPjkkupABKcqSTcvb6MrYxRQWL9F8k317O7usXSkiWsgAbknoJJNLRq5WK3z46VrmrpvNvYAtNkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505226; c=relaxed/simple;
	bh=78NzB/+UjXfMAaK7ZBKk9duYcL4BY4A95wF4zPqB+xQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RHHIFAYo8uqulnYSDvkE3q2L/D5wfLqSGwEU3jvnqG/y/HkZXvrkNqYbyAAgBEkKgShE2zMLui/N9KKY+YH0YRDQEoxC6K/jIsUn6/+Ur8Jvcrql+qhuIhfG+jUGjP8I/CxvlBNT+5Ai4WHYLcl21CLSRfF9Booood81xoQkuNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFJX3fn8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFJX3fn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788505216; x=1820041216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=78NzB/+UjXfMAaK7ZBKk9duYcL4BY4A95wF4zPqB+xQ=;
  b=aFJX3fn8wnN13bl+ZAcbpRsWnX2wvH9uXfrFMc1Dx+qrB3sEq6lnTKQm
   7LuBlUIyQ60VerBJluLTX1oFKsUbz4WKbGfesUmsaMQc+fb59E5Eb9Ey+
   1843nD3DF4M2+hezN6ltJsOjZsBFBwnZxy6JinsG0k/rjcbTSqbpewJTl
   1nrl/Pzl46Lee+IzdZfSPcT5AwrQCGuuP2WXc06pgYEBLbmRp828s2BpJ
   Ol/E/bN0BjhcB1Ltw9J6voSa8yIyIEW2Vj2E7qavDaxXPFmnpVf0q0hUu
   Lkuu4kLS3AhqKFQL/MS4KbGXTV7mnu53a12T8pnGGiLB5m5ASnsv+yZrX
   w==;
X-CSE-ConnectionGUID: nVdETBDzSFCUJVvVlMyzcw==
X-CSE-MsgGUID: b7bJCDP4Sa6Xd81WcbolEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91514490"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="91514490"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:16 -0700
X-CSE-ConnectionGUID: sEA8u7JySnqLXA0nd/a2AA==
X-CSE-MsgGUID: ighUBNwsRge9ilWZJ//z5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294846319"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:00:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 00:00:15 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 00:00:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ivf8VQHR4zoGoQFi56HGOxa1y/1CdTfngjgkOBkm5AgL9FqHkSbiH10GmniMtlXOY+mF8tvqEghyCMrA+gguoWVJ3934Htt3W0Qhl8l/Fx93YJdtirJB7q9W6HG+UV8b4TxBdWJBe7TK10dNgTEbhhVlHtOzMSeHTbIv1Y/ki5Xy68S1KhKmPvbAQzNviVRCCWpDEx+etkpQKdKNVrfcR69hora/RjDdybeLMqYxZXbNQETjIllRlCu9AuKUI1Eam5L88uXFfvqS97ou3s00N2YLxjzgtAVnGdVkfv3SJUafhpGoefkS8Ewnd2qjONZZGjkmV5reahvDKpU66C63ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjvuXGNc1j3wOe/ku2uUd3FrFvXweibQRkpBBGp243Y=;
 b=CmzidXRe/PP0dmUQD8IIsfF86epPnvVIaR3DFTEgOjlTfdw+kAic7GST88eweTjoz9UaXF4DEYtkz7dDSsDvqI2nnZMzxjaqeh3mOt8NLqu1IuLQrtfufNnVogU2Q2+V1m54dQRVCu6pkGuTUs4HsP9a1JGa5pBEA3wBvnansPr+Vb/z/V+28ZaUjUKv/o+ggOAef+Dcdzcyc3MSP5RlCEHovOU3V5Vz8diLW7A6/Dr6idM1DG1gXhZnl+89H/uT2+iSExOfj7vYQi/YDJmHMntvKKOvfjRyiJ8M5sWM/VuVeuoyW+qG+Sa2tOaPUm8w0+jX1uNCu9+Qr5LwT7r6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 07:00:08 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 07:00:08 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Penigalapati, Sandeep"
	<sandeep.penigalapati@intel.com>, "S, Ananth" <ananth.s@intel.com>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v5 02/12] ice: remove unused
 ICE_FD_FLUSH_REQ from PF state
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v5 02/12] ice: remove unused
 ICE_FD_FLUSH_REQ from PF state
Thread-Index: AQHdChZIpmLKxDnjYkS/8ImzeT6AP7a+Mvjg
Date: Fri, 4 Sep 2026 07:00:08 +0000
Message-ID: <IA1PR11MB6241ADB039F3D90BB6A9EA098BB52@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260702103007.97020-1-marcin.szycik@linux.intel.com>
 <20260702103007.97020-3-marcin.szycik@linux.intel.com>
In-Reply-To: <20260702103007.97020-3-marcin.szycik@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: b397a214-a9f9-425a-4c3e-08df0a5227fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|22082099003|18002099003|56012099006|38070700021|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: d7fwRCXuFi4dB936LbgEmi/pJOfZ6LqpSls0Drjm7uOvzjwALg2poYfcPF+e4BBCEtv1yC8BSHgAnb/kbOSVs5qTPz7vedDu9w3L2nXU+lejlyVlFv6N6Ob1t6CWjyMhp8DZ8HgF5TJVcST3r80R5lj6Y62XqJICTtWaVx7q0QqTOYL62N/qMCcfs+k/I73jJ5IsMBHkZxMjIEwJ4xdvcFcOzj46i3ZufmNCquKSOiuWCIxDHIzVNuG9dXwtrV++pSaQwzcIIr4t+KK+xAkngvZ+Ichfa+/gLeQmv2zze68ne1EHjBJr/nWHotVpRY70ReSZwDLj9XiO4hMoAni9xHUKSfO62J+5RG7pumKpLbhssoxNW3CP/8ewd6LDi3kbiGNwpYlfBfCeDoWrOT6svQy+sr31yAX3tUW+cxoHTiEgnIRhKj0CuK4Y1C1Cp0ITsUPRL5RvauwvAITAYXbbEfQiZikqIesLBd4GAcuPnPD49OonYeS6UTnDby78TcUrCt/mJrvrtsdWJGALZEjYOX8qgykL1ei1CJ3pfNj1LoAaYq+WB03ZkWpIdDEIrbWAAOE+IRtkJexbZrIO+VtUN3/Co6oEd842skUBUQTR07ZAVQQFe88Hq3sgA8O/u1RKZJTg3llJIGNYXzkvrSsrKMfA83BUPwcUWb+rVigMuXGDCLL3Vr1O0quYZLTCuZaP9m577/6WHyTQT6WOciO16sOOL0DLAyus2PW46/LfE8Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1DXPKrAoYH5ZYhaVaqr0ru29TP1YjjcfIwi9vrdNBKRlUDmIjH6/kdXz10D5?=
 =?us-ascii?Q?M02UbervNWr3gLPeXnu6fv99PAgFveWz59ocrYfBEHHwgXB6OxznyHreL8Bm?=
 =?us-ascii?Q?y7M442tq5MyahJ+cjWR+b359ugJpRAYxW5IELGotldLZJbJV3PsyqeFYSwYf?=
 =?us-ascii?Q?CLxY+yMTgiqJlQLOFosmjVib1oBOwAQJ59ZRIvXljiZHiMgy6Bov3X8G731i?=
 =?us-ascii?Q?TL+FzU6S0HewaeQfWSWz7zExqOLrun92UEvjO4OybNyNBl7cvWBoM2S+1D4z?=
 =?us-ascii?Q?Xl1B8gnXdYeHfnnJyy04YHu/eavLywG6pFJeLxJTLV2yyBgNXGkuI2GBKLsA?=
 =?us-ascii?Q?cCSCUcVWtvzIKMU98dxIge77hWqnpCX8pciEFOXAMkdEyK1+VgjwnqsnlD0+?=
 =?us-ascii?Q?4VIATMhx/5mGXiTgMebRsIqrSfwK3v/4pJpK3R1HqMCaFhp2PDLuZrfxwJFT?=
 =?us-ascii?Q?4Nd5GBM67k2PMIXrYQe/50gqrbSd034QwvLl8bhC85yHu07Nue1gnU5xO4i+?=
 =?us-ascii?Q?hg906Lh33n92D38C8ApuE/VCsNPA0cPsCDvLTfyMp1xGi1aTm9YMjaBEHNNs?=
 =?us-ascii?Q?07APdclJtYDbJ+CBNfMxW8jRKIEkTpzZmt1Ql828J4t54+bzWL4dlvDIuXEr?=
 =?us-ascii?Q?uUlld4rOZ1U/nq0ePdwFu6WUO7vLtFBCyWRxNGU91cojS7egIyDhxMo4YVTT?=
 =?us-ascii?Q?gWnpKZfEEUQd9NO+3rHTJC6HFTVcEenTKS7xvD6q3poUGr+ABmYrszvhJcbp?=
 =?us-ascii?Q?nioifNnJ9IYrgHso5S7uJjFdOgi2x9JB+p0AGwS1QPyBsKHKZ1stueCHnayJ?=
 =?us-ascii?Q?fK151HzxpPRGQ6QvjbLE30kUTRD1PrEV36Lr+DaxKG7zFC55l7Rd/98hsyo7?=
 =?us-ascii?Q?/H1bCpTYYrLZRG8Y//dKNFvjs7Ff6IWCfCyRiZqaj0XniqdY6H5cHA/2hnbm?=
 =?us-ascii?Q?X9JeMz8aH8dVuDldiC2/PhI7VVzioyzYq5oRn172Aq5v6L30c/rQWgI6zpP/?=
 =?us-ascii?Q?qedV6Sc/gkUBbAbW32vI1vYoQyRR5F5rudPPgJqoctsvfIBg07Plpjbv7XKt?=
 =?us-ascii?Q?gdAe4MkLyLe1LXiuipwM0rmIBCjFER7aI2E2m1iiqfhxb+pEyt5sRMxsyfZs?=
 =?us-ascii?Q?VSF6hOxu6KrrWBhoUsh5e3oK5rtlEz86J2dDeq0rJxmnE/7xHH7HNF5U6Gdg?=
 =?us-ascii?Q?yrc2gOKfgjVqqe+YDI8VeIETD1TdkofUmgHtjz9ZD8fKlAJrQkwGGSyvVdGt?=
 =?us-ascii?Q?F8DDYgELbtNCuOZUVsJY6ebkj9EkS12kQuo0mP5RBduJHWWeXuiKGNzewIf9?=
 =?us-ascii?Q?syU0lakyzQuxs8jJRRCkVbKAvWV8EayfVtwsW3B842kevWxoJPtS8tzdB0Z/?=
 =?us-ascii?Q?bRxfgoWuqWrOxBpiTT4Wsyfbza+dMuK8ZF4lsuSy5QveyDty0hpKK2rQqFqG?=
 =?us-ascii?Q?27s1Mb7xHrBPCSkKaHpOMp2aU9fRdFT5/1DGOeAHxfGWEdhbzCU7hPRReFOH?=
 =?us-ascii?Q?GoF9T8B4WBj1ynPwLV06XeiIqPpVfTf48EZ4ldLpNYlCzvPh8as3jt4IRmfH?=
 =?us-ascii?Q?OX1yljf1uDFSQrI6rXEkdUhDpotLPD8s19cFVObXcVkyfVyWUc8ccqX4/Elk?=
 =?us-ascii?Q?l9XLm6ZAOuEirdRMVkN4sgiFtxWfhxNIdNn+PcLuHjZyiSSJDF7S+PT18mmF?=
 =?us-ascii?Q?lbjUwlcOz1VRc1g0P5hzSxvazd/Xn5EHB5aRAG6NLdZR2dbD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YbNFB9i2+JL7N1HXMhB3UBgabOu7H+uHleMb1p2zi/lwoHSBC/QSeE+CqvwnSGyPnq2+bFGsiqze2FM6gT5Sh5KvL/T8zHfmNpuC16CGZGezaKN6Aq4EXkklCkNetrpPIHVh0Dxdn8BOxe+uObcsWQhTV4xkes1yqgCTbgB0f6vhk44/FP1mDssfu6h/afpkInc5CI07tDCYxBert6Qxo/57l6TyWPno+UhlqdalJ8mbYXtxOId1SAUHP+/G/sVFI48WetI3yLn/UcK8NIeMLeNbBjD6oxgcY/Q2jks7QCSzwFU/RGrgyXPtzTKVlS5a0VuhbnJlPl571IgJAJJMaQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b397a214-a9f9-425a-4c3e-08df0a5227fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 07:00:08.4201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uu942yi+pBfH6swvmNXTowPA4stVqnb22qsUUNmmkT4EInY9VCeyjEj7LwwwHGqm40yfNLrFVVU/XpP3fFPZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
arcin Szycik
> Sent: 02 July 2026 16:00
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Penigalapati, Sandeep <sandeep.penigalapati@i=
ntel.com>; S, Ananth <ananth.s@intel.com>; alexander.duyck@gmail.com; Nguye=
n, Anthony L <anthony.l.nguyen@intel.com>; Marcin Szycik <marcin.szycik@lin=
ux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v5 02/12] ice: remove unused I=
CE_FD_FLUSH_REQ from PF state
>
> It's hard to tell what this flag was intended to represent. The commit ad=
ding it only added a check that was always false, because the flag is never=
 set. There is no relevant comment and commit message doesn't mention it. T=
herefore, it looks like it has always been unused. Remove it.
>
> Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v5:
> * Add this patch
> ---
> drivers/net/ethernet/intel/ice/ice.h                | 1 -
> drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c | 3 ---
> 2 files changed, 4 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
