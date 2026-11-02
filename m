Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793625532;
	b=BOad9ejTPydnPlKYsSnZ1YGIW9eLlUBUnQyyydspuXbAukGyq12g4H/kwddpI8coyGE8
	 rfin/tFsQti8DOz9ydbLw2M7o3sbXB/D0uVN3qMvBuF5JYI9OR4vc6P8K+ESmTall+lIU
	 cZ8eBPS0FS7yR5/Y7Lo8NBP7bzNrpUbOKTv8mQGuX7nqtuPsFK1ZKIccasu29Xcqx3AmA
	 6zmVDNM5TS6gPhOJ0m67Vrw0t8B3WEw/sFF+ZgnvFH4+6joCT/15daUrmQoPm/k97FlDC
	 OlMIlf7UBqM3WgkUWdPSZiZ2qFQHP4sryAQoJ5fLwwRJFaQbQ9Y0HcrVPRCU/Gci9+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625532;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=h7C2W0+e6x0B4ir5+SsQrO4N7QKb9Ro1xo6NFwQC4Ss=;
	b=NXrNF7aZI/DibZ2dOuwdWxyA6RVP7yzxWLC9oxkL3kl1/NKLzITl4c3kDMvI6DVba/0V
	 kgJqSmNpLXRvngKy5DSIW9B0JwgsJp3J+Nj6Twaj8SPdpn2zaZnc8VaS54J38HVcZA3B5
	 EkFBOdgjzt8PL8cy4yUlOfnU94kcnPAy9Gfamb94eLuVVWWZVnWu93CFg83Ty4VGETfo5
	 eCvG+2AxtrXPh0iGs8x+YljzUk00sd7S8nNsUFqk0LtygW99hMWEnC4ocgnT25H37lJG9
	 Onl+vUFDAk/6V0KczxN55gcQOp3V/ajjks05dC2NXGVnwmjuvYgLeaMqozMiAdpf0UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="C/14R034";
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20457606A32E
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20457606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C/14R034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793625530; x=1825161530;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L5TIcldxMYHFLDRVcICcYdDEJDpMMFz7UXBKvnX7bNE=;
  b=C/14R034b2L6lCaIzBLZfmIjGfr8L14gOBNFs11qLAbZUH+EZNn6yUtd
   pfIk+cp33DtBm8SgiL+5GamnxO51J/N4W8U+mY1F/Mrnjb73S3Wa52EX9
   5MFSbaiHhZSRuJl1Mm4+p9mETLrnstFD4N4OeqVdvLJ2h3/7BtgD567+E
   s5VrwyTKimO+jUTLpXAwP0qYbe3hEZ/YGBNjAZRD2Bu6uXdrlGl9+ahR8
   FjV8EGDDsEvyU4Zi/sp+YFaw02auRkRKyDVlEML5KQ92Qdn4iB7EctUm4
   DIq4+h5n24mhg3kQL6EN15bkLZH+lB3+UJsj7BRoKgA5DltpvX2ZYbwGb
   A==;
X-CSE-ConnectionGUID: esmckifQQayA75hz+kjutg==
X-CSE-MsgGUID: S+PV0yGDRziCeiRkG2Kprw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2331243"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2331243"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 05:18:50 -0800
X-CSE-ConnectionGUID: QiCKrS9BRA6y5M7fLWhoUQ==
X-CSE-MsgGUID: vltBr4/zS06OPygqrVf8Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="5971807"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 05:18:49 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 05:18:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 05:18:49 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 05:18:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF64VOcRZdkWZQHI90FoKqztPH90Krg2DWqZ8jVpxlz3xNWk9mdOWKc5vo3aTDJ5UI4DcaEX31TW4FG0H0JNX1T8PAkp8r0XULhA6ZA8yD2LXv28W5Urx7pAr0fTiDQDAtF6xNCxAX3tVFRpFhHBDdtDBHWQCOUucqUvei1s/IUoijBY32Y/Hhipikc4LORaz4/K8gNYs1CQkufg7XBwQDDCoq4bI/Tp+dqI8Ut2Ywetj12KgJTvCUht7yuCiwUdZTWRRQ3v8uf6tuP/UDzUJ7SrnGKwJVFQStgwWWfLXJC2aH4pVVzPHYvvnXcoToWtauXl9iG9+QZKWcsIi0xFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7C2W0+e6x0B4ir5+SsQrO4N7QKb9Ro1xo6NFwQC4Ss=;
 b=I6tYrHNfrD9VcVXA3wnC72sli5m5wfWUzqqzDO9nirUoRiPAFftA2DG+dftSkttbXYnbXon+JEi6SdwE1wScq3Ur9IGIsFDhrTJY25/JD7VI/j5Bs3/BU4mkZHLdd0LJfnJ1xC6fu/LXU8LwfVH1sKEkLslI7Zz6zbXNYVUI4qMC4oYQMcKD9ZxHGxD6JFWL44nKp13tND7SbesvZ8CtrKgl8xX2N9ng6XEOsds44K1Kozn8iVLPWyFZJVQ9x6m5p0yRg3pY6wk86hR1K3PJVmTCwRGFDvv0lZskOU5B21xgiBQ+4p+FCBGIUPJfsuqPmHv6BVyd5IUx+b18Dc3lsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CC6PR11MB762293.namprd11.prod.outlook.com
 (2603:10b6:170:20c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:18:47 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:18:47 +0000
Date: Mon, 2 Nov 2026 14:18:42 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sinfo@kernel.org>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <zuomao338@gmail.com>
Subject: Re: [PATCH net 0/9] xsk: ZC mbuf fixes
Message-ID: <auiNskjiMPHTHsf4@boxer>
References: <20261102124950.958345-1-maciej.fijalkowski@intel.com>
 <179362404207.3286.3886474571191338888@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179362404207.3286.3886474571191338888@kernel.org>
X-ClientProxiedBy: DUZPR01CA0267.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::10) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CC6PR11MB762293:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b11dc1-5f8c-4c50-3f78-08df38e3d3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|4143699003|11063799006|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261022105027099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6zsz3UP/eAJTl8o5a6qUuJ+uwk3aMjcSiLdnZpCRkFxyXFdjUrAjrCDGuXAhJSmRUosQDCm0pXvNWNnicMTKjmNH4GhZEHvcYX8rw4peKqWa1kP6vCVuj7sEVUW2PE6vn4ztQe6D0kXnOroi3n96dr58hnkqpLodtGRJ+SKZuzhRQPXKZynBz1zroDiAGv8lAB2JIAE5l3TR6EFNSfaPCegbpmcP6GSuh+5y4+oKoLFFjCRR8MLvzaGsN3BKwzefrb4j5d7wREKX6v9WNw3QtJ3Pxy/Ji/AFqWVJurVdQi/gBq9eH50sb5BDgQ7EU/EyVUjvJFRVA5BFHruf5qiwfxOT0/ONECFVrkDCuKvluPmYIXNBlUsUqD4FzlFWJ70Lb+MAvBkStfIgLJe7aFOOy6ReVm2lIH9p5AM7LDQCbAKK4yzhjDpSPvy8BVsi2rTb8SOaTSfOOV3zmJrIIxQfcrEn1SjGe9lJXmw/jXLedj3lc9E9kMEuUvkUt8jPxCMgSl9xzxs9ZU3S1kH95VtcpGtJc8O+C/w6IP9EyvJrxt8yfrvnvy8iWlGIZi/iXIeTAjN48LYNuFH8tpA+yVvRLYOfJ09uJJVC7tS8INCUAO6ZYcoNiXqFEZl/0Ey5b09KRAM3+GZ8277fYaCTya+YlbVyeg0Yy31mIqh9EdjpdKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x4Hwj1wUeoAXegGOUS5YnBTpMjQfBbL2iL6vRQL5oKpp5Rph0ohJMc38k2d8?=
 =?us-ascii?Q?lwGNVPdDHFO3XxG9DCzOmX2KjEjrLpN7XxZmwcSgTdJ8t5LThjcfZXvo02gJ?=
 =?us-ascii?Q?xSe2QUk4HkLeqDbM21rXCe5eS/6ulN6WWCRLa7G7wp8ma6QZcgpjGLnz7VqL?=
 =?us-ascii?Q?YJ50SOOSscsjmtf7UVTmRT1j84sap88Uzm85yfb6JYoOU/5BcsqMvsoLqiDY?=
 =?us-ascii?Q?P5aQ8/++L8Jf8iCFFm2VNjj1f5Wgya8eBBeBA0ctqiTZBdWPOUK3GgJrf8+9?=
 =?us-ascii?Q?EKNHa9aggdoFdIQlkpzaC50VLS19RIon1Aa5jbA82guSsNitgDS3KrBz83on?=
 =?us-ascii?Q?ntme5y2KBeYTF8SgvQzCcC9Q69lPI+aHm2uBOiHVYldso3CDRGAB3K5Ci/rQ?=
 =?us-ascii?Q?2FMSpLsIH+Npzg5VCjV7sm3hjp5Aet3suHQTd8PH3NnxUfJsv6/g4wIwN/0m?=
 =?us-ascii?Q?SMluc9mI6uw61uAtrXstc6DS5joa1U7Ol8iS/DtKVQoU68uM2ofqNKR11e4d?=
 =?us-ascii?Q?TiFq7MlWX4PIeQoNIaJA0hm1yaOgz2hU7mlks7q2x3WtmfMe/emToe+D/RS1?=
 =?us-ascii?Q?gc0LsU1PLix7K5NP/g10DdihafRv2n0PhOltZ64qjc5lBBPdQfYlo7qLRRuX?=
 =?us-ascii?Q?iAmWF1FqFVvdFGKhk74l1icVVDJxjO1Z1lZi2ah4+Cl4l+e+vWX2GaGrGPeg?=
 =?us-ascii?Q?duvg1KduhLD9iV62ReMl0HecplDWwV1V5ZzqAxBljpEEEmrPvfQFDYbPTWgV?=
 =?us-ascii?Q?5wG9SZPMRxipAkJGQQsR5m8d0oU9ugUorbph+dV/deAiKq6Ly6/BCl1iwMMt?=
 =?us-ascii?Q?9OyBvfqXsK7fjprK5yMJpb1cL+3PERJHXb+Px37GmrtE+8T4xNk19EEb8zKK?=
 =?us-ascii?Q?aVLpobxRzqHZwCmaQzSyaquAk3QajUExsF+5UsnAC8jyFhnxtdzWtDNvOJXN?=
 =?us-ascii?Q?32e9bOYISeJBIch+30xmBOWgIGKAz0XWvwXHt9fdU+sT1XjcGfRSxAqPiWdm?=
 =?us-ascii?Q?r8sZaO9yiu1sRIC/PEwHpVeXnjj0NqbHbbuHlWqiLtpvxxGJ+h5usEy8BlHc?=
 =?us-ascii?Q?gRLMxuAyfrfzPoml37IfUDk2Rp06jzxEkuH2Z/WFhwoIQ7vYJHxmPba2KDBd?=
 =?us-ascii?Q?+upeRdrGzN4uAx8NUQ6ySm4/kLFbCq5cDGYpnDhYvGuueRNPj04T9zhuU2go?=
 =?us-ascii?Q?9y4mf/UCUCXJQhzVbr066yoWSroY21j42RXae0VvbxCrMXuZ0CnDJEpsowav?=
 =?us-ascii?Q?bJhR8vidmnVfDouzpDOCtKThcgfuLA1fNEbBSoD6PDvjrWgjJ74jJaAoyIwr?=
 =?us-ascii?Q?wzbbeeLlRBGVirdAd6n2omw7nKOF9qJTTehwxNLgeK6oqACKwiEUO+YCh3gx?=
 =?us-ascii?Q?hKG0VvCD4LFndXM4i4VqUDtpnOAl+0yZJfNgH+cKUqRc3q7YJIIkRxsOedtX?=
 =?us-ascii?Q?Qw5TOcDxDw8bHO5dvIi5jnkaAClCOdkTP5wciq3DwEq+z0a0Rl4zpxwapReX?=
 =?us-ascii?Q?iK8b6q7U8GasDN+OVULqIpy96s3pbmNutDwMSd+2AsVibN7wsu8NoT2u+Fz9?=
 =?us-ascii?Q?n2cFLZLtjDKPOQNBaDZ11lOfw8UnatP2m3Kll0cX4T3kN1B9IEMPLKNaKjqx?=
 =?us-ascii?Q?+ThG58Ss5rUkgmnFOeGULX8joMQhh2SzIZMVToCSc05WJeak7zPpTC3QoE+X?=
 =?us-ascii?Q?5ngjpb/8mYjjuhN3IosOKHLNrJDV/wQm1DcMmD+hpLyxxmgOMnFGPrq7ss+N?=
 =?us-ascii?Q?OhuaiNP7ygQO4K9whcKwyR50lTbf66A=3D?=
X-Exchange-RoutingPolicyChecked: YWc2Ft2pnDGrlGrMOjzweoYsPmx2OvbeCO3nUx9okGvHTVjjdigtx0yrL5XAF7ah/CsdgZChkZYzlv/SqhoUnUjVAKTLQI8Gvdkyy5ZogFfL+gG/DOSAAPHQEwD/aDFsaneYV02ScJcKIFCdrT5uTm6XNKNgFUOrml/8ApfizxwX0kMRjmnA4CYPZtU6BrEySBcoxkyFyMl+a3GOFik124vCbDv+E3/eYhO9j8RK8DjsQKF1y6JhIfRKs37qAV+nmcOxXeo+NN+DggdLzCNXXjblVuKjXi3WjDUbaKkO1SkWVQqbfnCSE70VWo/qREopCjue/4fm6zrRlvzLy0cEMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b11dc1-5f8c-4c50-3f78-08df38e3d3ca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:18:47.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hmp6ow/fV09zqTt4o07OWCl9DnetP7go1CLZRmU6ROj12L8lclrekpma1CcSH76Zu981G48wB0hLy1kU+1ekSvwIgZPXWwzrNS54VdQ6uNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB762293
X-OriginatorOrg: intel.com

On Mon, Nov 02, 2026 at 12:54:02PM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

whole series started from report at security ML which included KUnit
reproducer and I verified the issue is real and could be hit with ZC
driver. Part of oops is included in commit message in patch 1.

> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

Ran xskxceiver's test suite via xsk.py runner on Intel E810-C (ice driver
fw revision 4.70). It does not cover the duplicate fill ring entries but
given the changes based on code inspection this run was to make sure I did
not introduce any regressions around multi-buffer logic.

> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
