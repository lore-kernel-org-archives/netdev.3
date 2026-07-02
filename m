Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9633D0939;
	Thu,  2 Jul 2026 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978773; cv=fail; b=XkJIAIFyvV0+2X33SWNf6ogL7xjeHiWG7xBkAy9LvumvU6pg6gK+bHV/p1/exf2DVMyQL6ZFXlPWSA4VxN+qxS8/9AA4GzX6NjMGNQ37xorzi8nkc/5tGMepn2Jb19klpyZyPH1nJBem6eX9L9YQhapuIq0OxrX1Acfzd5GkLpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978773; c=relaxed/simple;
	bh=eV4/PB99bfTXps8GYJvlmTAsov6EdXBOU3We7P4yBvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mSaCNdM68qXK2wHcqSgs2gTqJFyp+Zhy0zzWaFOYU/WXzqHKgpLnflH1umZKVZZVKuhDo+Gbjs7bROKMBuK6a6f8LVxS3ebVPUncTVKNrmZnsoQTscdsv1wi8vRlSHkhBekOviKk0Q7sS5yb+foc51ZhQgtaHEVkcPcCBTEM/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gzd4QUsb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gzd4QUsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782978763; x=1814514763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eV4/PB99bfTXps8GYJvlmTAsov6EdXBOU3We7P4yBvc=;
  b=Gzd4QUsb3i8fCRMEBjPRbpQUqY8MrUUZuV+Z4lPOHjEU5orlSuZW0ofT
   zQthqA533zStwS7U598Q/nazTnltbP1t6vc5LejR0WOot3KdqwP16QZiD
   CVdokcOUZa+volz4Six4uO6x4QzMVZF8w1mOTBWaR2Hv9FBhIMVrPG5A6
   EyC9xsuWsxMZhJnY+jPpiBw6kQbXS/iHn6N0EHtTDubTleyzXsTXWZ9O0
   AMlx26J6xdXIkDmcGAUM797lCX9wyvQdm/eAxVAAhUH6XXpOOgE+D/4lm
   iY2j7MwtI6yDQlYzbvtHMBtSoYpppybA4twksbgtHYRFZYfTHtn/WB57I
   g==;
X-CSE-ConnectionGUID: 9K1LNpxaTbm/6CaSp5xgjg==
X-CSE-MsgGUID: Q4ZynQQiRRiaZrTGMM8Oig==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="109270632"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="109270632"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:52:42 -0700
X-CSE-ConnectionGUID: 1r1Rvcx6RF6+sxWQ2/DkBg==
X-CSE-MsgGUID: pl+CHGhHRSiJA9XYcxdzLA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 00:52:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 00:52:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 00:52:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 00:52:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snswSA0stAwMzLPytTlP71snURAu9XIN2j8yYG0GG0JAjjcw9iDsMoYqNs1wyChn9nJJzU9kAChQYNzY5ZdldgXSS9QupCTzCSNgI87D/PwUwC8oHGIRTDyme7NasYxn/I2DhaWg3LLGprKSXO/yTg2V327GCF6yq5m8rmDG26R4hvfy0h1iRJejPPZPso3sVmxO5r2zPMP1J9lVe5cCIstOv7gi2+xKvvrqgQU4a8Tsx/+sx0H/PgHR7eZBusPI5+m/GQr4dUUgmmd8xGFHGhSEPv4P7NgxcoBi947rX/fwyKLxDmqym0Fx/hPdzMWCGG0W5d8xV9OFZg9XAR/xkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7rGfDYQ4wUTEW0h0lJBvrsrCrTtr8IDS0NmcMtxxlQ=;
 b=zQB6btpYJOZqW+inOin54GncV4Rv/7ISM5cX5pQacx+kV9ekXDO5uZSqxRjHpJnO1sVPHy53mgXf96dGjDI4Vf94WEz289Aad5T3IFGVHod7RdGZbUrDsKxvfdFDjmKhU0QbqBiaxLfyhVwwHYMOjg8qp3z0JUTO2jvndxWfSISJL28GxmTXt/NZ+exNO2aYyZl4jPXZAH57W1ROlQ81/bw6m4XghvH7OyVQONSAWC3PXAMbQoUfzYRwUMkKCRvl3XkUrecbqvXlmyctMnjMn+z2MTMHarza5Tas1W8pOUaHQypwE8ZSvfLUw7p44ySVbdSL6rJVXtUwiOdFpiuJcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 07:52:32 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 07:52:32 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>,
	=?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
CC: "Hadi Salim, Jamal" <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "moderated list:CAKE QDISC"
	<cake@lists.bufferbloat.net>, "open list:TC subsystem"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/sched: cake: reject overhead values that underflow
 length
Thread-Topic: [PATCH] net/sched: cake: reject overhead values that underflow
 length
Thread-Index: AQHdCbWZTpgc6gsrz0aCMyLhW+JXWrZZ2/Og
Date: Thu, 2 Jul 2026 07:52:32 +0000
Message-ID: <PH0PR11MB590235CEC237E01385185AE1F0F52@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260701235656.296208.68e320e0746d.cake-overhead-underflow@trailofbits.com>
In-Reply-To: <20260701235656.296208.68e320e0746d.cake-overhead-underflow@trailofbits.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|PH0PR11MB4999:EE_
x-ms-office365-filtering-correlation-id: 001faeb2-61fb-4509-ce4b-08ded80edf6b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|18002099003|22082099003|38070700021|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: ajEItNrX97q08D+y8Q8x+7p/U6U8rJsJ8ZMS5EZv71L0Ggm1+WEc4fTSBzr5CrptTBYPq+JesnxLjbHJxoGTpoAYLxw344O29iI532+Sc1v1EDcoTvFx2Dx6dcoLTq43pxHvzmSsM1BCtb+AHgLORBvYffk/chG9kFkLo3QMteTKYfeUF1QhSLnJSV1wDwQniQ5aBjK1gXCrDpNVJK9xlG4GQW5/oyv+0iL3bHPYK40F2VjNVYupBGiey5LIuEAS/KLORwUOuwRpz8UyvRrsJdfUFNiHaM7iFrN90WgiqObv/V0kWFLry2uZJ7mIvcnSohkMuuFRqI+yU/RaPysJ64KTcp/UMM1AYQDoTFkX4P1UM8Tq/SZNv/RFRIbpPv06Aux+46gToBBF/d/hQ6WU6lKEAZkCwvoPOc3FIqtl9vOSjqErupbjGBu6FDTxpO7umGbNNS19TQZkCwh2uWe0/fLvs1ybLwl1d7yyEPPSmTgPiKpcv8hT9RPzSmcTWnUCLSuNUzAN3h8e1ie9qqR6pLGOIi9lQ7sVnwWWubWwWa/AZDRqjVzjZCfQmu7Q00OZAEhvL8EEbXK3i1n3YTjgxhqq3d9nufl0l/XywcBi/xjhwLmY9ME6joxbA554m9w+H2A/GIcAuL5hKPiRdCKrYm+tqnw1DC4yZjnnyrxEDAWPy11LRgmOsvfCm4/K4yyOK6TE4oMORAaPN6w2a3lLLRbCcwRD8RDrzac1m2qpgG4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4T3s5VatfxdS/dcybq0kX/lHe1gv43taw9j6EM2xhSZbjuJfNeY7vx85nH?=
 =?iso-8859-1?Q?dIwg3bGlNrxGEg56gtldBl2++fqjiVevEGJQiC5T7ecLoN+/ZOIDwq5MKb?=
 =?iso-8859-1?Q?mlofCVN1P+cCGcmQldzGTO46YPsooG1pYu7poMw7tMbfF4anAjX76XiWlp?=
 =?iso-8859-1?Q?+GbYMxYqez8UM0lpXiTj4pltY6DzK4YOoEGQLlcUgHjPUhmzhf2buM/TpS?=
 =?iso-8859-1?Q?n2agbba378Q7X0U5P4KYkTzCgj/o6kFQNBe+1Wlxtr7b0s8AtqLShrM7l0?=
 =?iso-8859-1?Q?ErQCok6zesw7xYQP3Bj+e/5dzvtbZ3TZP1gXPf6GnVFb0sLBP+Qv/yUZtr?=
 =?iso-8859-1?Q?sdmrlpyX2Opt6dSlUTSlQsBAlOFyXi7Npgjf/LMn7sP4/Dcpm2mQBzBX7p?=
 =?iso-8859-1?Q?bnN9Lsn/acseuJfbrUIZ3pIbwWJI95Cy06zgmoPRNpaS/ZjKLBF5p2b2As?=
 =?iso-8859-1?Q?dKokQ8FAQq7k52dUPPEVM++gSQ7WfDHdiMN26nUYG8xpxwaDD9LanSaTOn?=
 =?iso-8859-1?Q?+qtXuvAwNLMPkGIvbL3Sezs2e6LK0B/+kp3NwVdtn+BKT2KtLtsUIYIG/0?=
 =?iso-8859-1?Q?Ia58qv+SeWvuFdSdc/QxX0YumXSg+0xXmzn/hl4OjuYG/eUp/bF9zt+4zG?=
 =?iso-8859-1?Q?Zj0lGCvrlRVHZmW6mrJMQJz/Bssvtk2GdR9O/650CYaF/pG1Wtpey9VQAo?=
 =?iso-8859-1?Q?YmpT6VQuxSb74Bzxlm+PYiah4oe8pQEWAUJmHj6F0Qi70zZR1geGlluGUU?=
 =?iso-8859-1?Q?tN/ub8qx68STMoKTanDy4VeaAEg4ww9WEcVlMd7rEOSeIhS9j5IICP2Dp3?=
 =?iso-8859-1?Q?EPGxxOesj7L238FT6NdtDdbJtiZKu7WYJw88Cg4ca3p/uBUysjq0wK2BtB?=
 =?iso-8859-1?Q?mp7nd0beN/c52SAEd410HuHV8zPwis0kR8m2K5nM1a2C3Jl5l9GMUOTDLL?=
 =?iso-8859-1?Q?Zxkd9h18vPqWqOku9Kv3VukZHrkS/FaH0faXfJRTxDWqnBHBc1dhzwqdCs?=
 =?iso-8859-1?Q?bacTuZBmVItyl4aKiiDK21HLIam8gpqKzPSYeU4KNB7Gtg1hB8eO9nYGdH?=
 =?iso-8859-1?Q?j59fC/ACTYQ+ZYUe1kfT4SGUwFevpVmEsVba3lz339AyuE5Jy1wF1fG1FK?=
 =?iso-8859-1?Q?KOKJonwOKQOsC8j8NlV5G8naman98iJCMfTiI7H3JQ/ezNT77yqWqqb5+K?=
 =?iso-8859-1?Q?ac/neqfxsSZOe0oCmoo7wrjuFs5nisiljvXsQq2kRQaCj+QXJS2+TGpp0o?=
 =?iso-8859-1?Q?InxOvHQsYnhlA3AU2ZWSpSeo3G7SI4Nio307Xm/f/SKGAHw68XmAOSA5HG?=
 =?iso-8859-1?Q?CX09i+wYVyk0BKGR4G4L5WPu3RZrpA3jBHULedLgoDJyAWrPCpHDg6JYdh?=
 =?iso-8859-1?Q?LeONz3qnPCEqKyHFeq2iBUh0gzgKThxG8mIjcMZeH6Y2eNIPRlJQVFdiGT?=
 =?iso-8859-1?Q?nJeavjhM7hQjpfIRWDv4ZraVFLBEI4m1qJfcnfgvnL2irFrisqMuxnrfcB?=
 =?iso-8859-1?Q?wiU7EZ0BwIRDNyHBDWLg8MFQNOx6k8ktHlfzJ2ydvWX93UMacQqg2I/6/k?=
 =?iso-8859-1?Q?rEhBIPeEh0XWIfEM58K8ESb9WyvH3wD9v8srL9jikTECEscJ6Iaxbh48nI?=
 =?iso-8859-1?Q?pKGQ0MpDiXkjfGQnSJp30zh7U1o60TKBz2t/5pIKCTvAQR+bEQlvZiga8r?=
 =?iso-8859-1?Q?D1XP893gGp/D4mkC7Jeqs7G0teAOpOyCcrv2n3CpCQcpNaPIyoC/fGlnjF?=
 =?iso-8859-1?Q?t8j/fTtE4MQzOEFXCsLv3XgqPz6JDB4pso0+zGEgpbu55SAhfUGaDF+XiO?=
 =?iso-8859-1?Q?KxIrLLxrXw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BleG5GORPFSPPv/JcRHugf60Eq4Vp1kEAOR8c7T47LA8nge/2jxmg51kYSwliVdmH0n2tqCglEbEjTm9rto3X+El5emkzI07dgbGpuIzyQ/YkNIEAWzi1h0GMhLRqMXR8OY9/9oZh0c2SmO3LRGZ1UIEJ4jUeDAxdUT1D1NFBkUHe99A7ilrbsKu1ppCglrMSZn4TCsIuOx8fqgK7S7Sjo5w9QF0PtAe3mQgi+9wBWZW5fVL962W+eqse4VJ/Zs0kdAZxzTpTvCqaP2JSRVYhh9fsYcXSzd1PBy/qEMoVKHNncnOQWI5vd7ONqm9i6DIZ2Rv5DEN5z+xZLKglnFwMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001faeb2-61fb-4509-ce4b-08ded80edf6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 07:52:32.2356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UyeMpN50TEBLiBb1vQ0Vj59n58EBBqfc4FXDhaOyeXwJIuHaec9Eic/uIrLhUUFgb69hEA05aq0MOAIGac+M+xAdTx8lQiPtpUyRFzkAEss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
X-OriginatorOrg: intel.com

From: Samuel Moelius <sam.moelius@trailofbits.com>=20
Sent: Thursday, July 2, 2026 1:57 AM

>CAKE accepts signed overhead values and stores them in an s16, but the
>adjusted packet length calculation uses unsigned arithmetic.  A negative
>effective length can therefore wrap to a large value.
>
>Such configurations make rate accounting depend on integer wraparound
>rather than on the packet size userspace intended to model.  A static
>netlink lower bound is not enough because packets reaching CAKE can be
>smaller than any reasonable manual-overhead allowance.
>
>Fold the signed overhead adjustment into the existing datapath MPU clamp
>so negative adjusted lengths are clamped before link-layer framing
>adjustments.
>
>Fixes: a729b7f0bd5b ("sch_cake: Add overhead compensation support to the r=
ate shaper")
>Assisted-by: Codex:gpt-5.5-cyber-preview
>Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
>---
>Changes in v3:
>  - Adjust how check is performed
>Changes in v2:
>  - Add fixes tag

Hi,

just for the future - please mention the revision number in the
mail subject


