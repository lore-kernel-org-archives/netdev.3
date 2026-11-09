Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794228284;
	b=yDPLlEnUEwY4JURSf2UJ11s6TR92gRh/TLn7h5ULz/b7wgPKMpXN6BvbntoP5lb5fWXF
	 /LMt7oXPRPoy30qjhqdSLRYAcwDz46beY54D1ZuRa5uhXqO2F0muTjg7+mOKIg70Xgtfh
	 GIyBjPJzFJsYmxE2w9bw2PWFeCYDV6XI0ZZ9CvD2T8XK5uyOriyxjt36rh2lj1fud9NjJ
	 nrRkGrlrHd0FRd/MuRTXETr5TFyCkYT3mjgVKWCEviKwy8ewl/OQuIIvI3RHcLPnbIcwS
	 NWDsQbrpgsCGkVRjnlziGgAaiZBZKmmkvcimRJBnTUEOhluGfcR0uc3/i9I5g/V+bjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228284;
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
	bh=eojWA9x5wSEqvGy4L9Mph7dvdH44jXjZg0pV4OEDalI=;
	b=2nGkjnDL2GvRVdxom3Niud9IxCe9T++DlasG7V0cYjG/BlLCF9w5KlT/xtd08gBiTc4j
	 Xt/eK2xNebsecWONwJcr/nqzezzpgO4fH58lN6qP20lYteSBdg1tXQKHqbXZ08Lin0XOT
	 3t0co7RqUjM8e6xS+l2baWzXG5yXx/JDJ6I77FPGNkbVLY+8Hvp9Mvd2Ezp56Is5tD8K1
	 Yi6fArcoxSfexifAwDBAgZ3DfvDg+s6TrATJZTLvrPIORsDmU19b2gw0CDhVquHfH2+2j
	 tYFFTyp6p4VDKtiU5rK0H8rZbWugF0qmFvE7oEInutEM1MOPxKGmVWfCe/UAfEAAswA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cEK5D4xX;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC51606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC51606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cEK5D4xX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794228283; x=1825764283;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aUE2d/oxDe7lkuJQeLvPvdVCX6+Qm6iKXh1dtTRdc74=;
  b=cEK5D4xXHhUKoTJcy6j0MqukSszlqevLaYekRXKnwx7nbBlYmb7Nh0Ul
   OcGZD5hD6Fvlj5I+U2jlTGwiomvmhDFqBfSCjK2JI4WYMPKpaxhKp24i/
   SJ8kvR1UVBoOWGwMrfHOKpFP9TXQHldnfqzGEqcskFznCHzyI8WIAenEt
   nrbkSpQjGxoVx4korrQ59eVIGVo+C+5TcZi9PbkFRf4lKvSUb/xyJPPYR
   4U7XRlIe4+90xPT5ie7NXBUTUJx+1jFPHpH8GJfgWBcEIfXrVAVBLCpAf
   ez+Enskq/fecohrmviNAu+rDJy9uL8pBMwnxlXkBc/vaF4AJXaSSMnYFp
   Q==;
X-CSE-ConnectionGUID: SE8WEpWjSFWkPaV4xt7Apg==
X-CSE-MsgGUID: w1nhOu2WQIuntm7iFGQhPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2981657"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2981657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:44:42 -0800
X-CSE-ConnectionGUID: La6VMIviS4CNVosR5su/5A==
X-CSE-MsgGUID: NcVdk+Q4RDOc/N5jOzGa8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8207722"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:44:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 04:44:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 04:44:41 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 04:44:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsxiNTtOAW9Ihf3zjHeA16GgL9xG72N8Vse8VNVI1HyUf6FHQTUKJ4BuP89nyVKyybT3DO011cRedtLbM5cakSZEsRHX6JBDi2QrwUbTesJ3ccxK6QZvMpQOo4ovhaZbq+zy+8s31pQzy8uRIGAZgeV8B4n8EBkw8CkK+D9vXcIdoJkFISDu12uBWohj2cW6Sxjuqce6DGyl2S5uZfyKoHak/QuYoDO6F8EEM0hmVbXQiV7P8UmC2wx1S0IHoLIJ3L3dAIkChQWK2p1CZ/yVzTkVptVIpcfgk4UXKJrVNVUcNV2pLwzn16fnHBxW6DUsVaBlnstsT0IJsbxyAneBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eojWA9x5wSEqvGy4L9Mph7dvdH44jXjZg0pV4OEDalI=;
 b=PgFa03B+p7NMppNKrP4bEkogAuvx5EAF0r7wnK7qeseyPiSpzUf1l/JenifG51Cj+P4U4vslkXZ54quATHQDS26E4F3K3aIf/fw7y6KHSeIXTdjXkGLyMY4+Z36f1Z8IHGoVYGWQn4JXCjRa6/yBGYQdCzn4pbpQhV1s/nU4QvzwAMJhdYdf7r50zi+X20NLdS5e3VrUrVtazxMTE8W+Yy+1I1O7bnxAnogE9ahb4zb/dT44yEfs9oq1STbb8Z7xc3KVhJVn/QH6Y8TSnujRd3e1/QmOrQUNFsR8/+a+nxHIgOCUkJhzupb6aKEPfKiSL8TBG6rpAvFeER1QbqFccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA2PR11MB5211.namprd11.prod.outlook.com
 (2603:10b6:806:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:44:14 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:44:14 +0000
Date: Mon, 9 Nov 2026 13:44:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH net-next 0/4] selftests: move the AF_XDP test suite from
 bpf to net
Message-ID: <avHAGLwtyucllh/M@boxer>
References: <20261105134117.977655-1-maciej.fijalkowski@intel.com>
 <auzqcm1YLsTvUU7S@devvm16445.scu0.facebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auzqcm1YLsTvUU7S@devvm16445.scu0.facebook.com>
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA2PR11MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fa1277-ae12-43d7-8e25-08df3e5f291e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261028144727099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 5zB3bzA1Bs+hzm6vtH40IVnNOkH4Ce6WM0e/K04Tn8FvGoGHFDaIcvwVpAalUp67LhkDeIKHoSQpFYtlFHSYkM4yt45htXeUnHSf2HBGL2CnrwCyvoS+meApb3BfHkevkShV3XJ4EQlZdLEURiXTWZL62c1H9j25vdGDouj6sXOKExYBun3vsdTYE8/o3y0tBhEheujCzbzWUacyfRe/uBxj2ae5Kx0sgf5j1r/VfcnPXX2aqv1XJ3BfsWC+e9OzG/TSWNRRoHuhlWhVYUe+685ICZyiSJSAgzZPD3nP4NdW+jH4zdPTxIgWD09uBPxR4VcyAMqmI7iWsthnfQ+fb0cKlsStwm91ZQ0TmhgTErSQ76/MAgWUCIImnSRFqsSRM9+ib8+i/qEkxCVRq3QaqJnHcvyt2jpQqVvNzvIDnh+XqdSlEsFDklXO5vI3ng5m2ojV2w/ngzmc93Tv59vaZcKjbUKxiONC+GHUT047OHdVZohxYBXsi235zZcYWELo1B9Hq6fQScGLlwhU6c4X88MSDJogjt1tnlufPwJ4C7DyaL01bFnY+JJZSLrW+QisvbVe/GO0VnthGgJWRMoUg/EUxZClsIYjytRzzjYyH/8V4YmWeqoD0MSqdzHnxjVf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7NZCySbdnoaqvZhFGVdubZ1CuStfH6Ksb4iJ10LOEPzlGpsS8nLYMU/h0qTw?=
 =?us-ascii?Q?cW69hOOtvuJfTWZFYnUuAKyxakgYkdGrpFNWXIa6lzZMvzkF2xWP6WYvznXT?=
 =?us-ascii?Q?i8MnMS755rumNHx8N4TjuAWwZLnsBwL1yGYk9mKrb7Aepo3nGor/sx8j3yb6?=
 =?us-ascii?Q?t42eokFnEYE9GEEwvSbgt4AlBPKMR1ED8WW08zb1udzozFFpmKMO1o/wbmmc?=
 =?us-ascii?Q?t7UGH4DQb712d4rJBelLE3ScyCn/+liMTA/sO77zCCbMv8YFbFtHRqkLnBbl?=
 =?us-ascii?Q?o+JCwqycg7Kcib1e4PXhYHlA58YqUfRRszz97SxDHoPinQPwhT6Zqv+aDd4D?=
 =?us-ascii?Q?oeJx9410stpWV9thJEnEen+r7WYn/u6QKfJYNy19cS6b86ShnZrPskJOw4zm?=
 =?us-ascii?Q?y+9VvpiA2JpIBLsDs3UtFofHdVOfH/TUFMi3dgg4TnsFjWHNW3G8pD7pFRuN?=
 =?us-ascii?Q?7U0EkeDjB1WRqGSnU0IhT9x3NsonvCDDs9/JRWuBswiU3FXMEX0EexRJ7nbY?=
 =?us-ascii?Q?nkp/U5mmw7QgCj3elJjPatvpD9/zaLZs0T2q/oOOnLUIMLq2YNpAqyjbkCbz?=
 =?us-ascii?Q?MYOovEWuWi2PUA3BaWOIg2W+R57nV/6IA6rlmLq4FJWS92ZrHsPC7kN5zcPH?=
 =?us-ascii?Q?F/1PoOWS7NbH7pjWaK8LUtHCyRxhGu0iVwGvKS+qu5B1lw0hX8WsiG32B9l1?=
 =?us-ascii?Q?fK0xe2Fd9RxyhZgCS2Qrqmw3wN7GpnmaJVFsHsyaEbd5p98FBEHg1Syc0A99?=
 =?us-ascii?Q?fZffP+vMax6ujgWMLSwXCEmjdf4Kcf0gPWXCnj55Zy8AP6td3D2nx/sgY+Zm?=
 =?us-ascii?Q?NYBil6TGvzrpdBD00k2nRyzjB/G3smXsKPf5V23Jym7sNiNX2w/h/UaXwYj/?=
 =?us-ascii?Q?HT7xR8NrVoAflVsnpGjgKRzeCYiJ+HfIG5SMqCaFLJStcwdXLNucc5s95lad?=
 =?us-ascii?Q?GXPT7rQz3HL1l4GKbUnV1ZVLoCg8cyzvZ40sGhDuyVeeejYu/Hx7ZPLftq0s?=
 =?us-ascii?Q?OljT4sTwEkGtfGggqynmv2lUCNaEdyf1KBdjPYpe2pzgZ02D5OaaT8nsMsoX?=
 =?us-ascii?Q?JgR5aFpq/Q77xcMWMdKdntKMLBizRT9LwJAPCHXMxGM1UiwwA5jxyZF8CeZ4?=
 =?us-ascii?Q?zF4D0V6lERwHyrwy1Xd6+RWLks0dSCeVcaP02kl1+b9JR44AaJYQ5bJZWWCa?=
 =?us-ascii?Q?8+DfWASTvjTlmJxFZTJOrJ4d72UDRAjkvrHGRT+s1UC71IfJ8WNtIGpnZhcX?=
 =?us-ascii?Q?6LlO9wkfyKrZ/iyb/iRovQ/wLQpKMkJrbuqatSFZ9NkFvKX+tBJ4tq/AqYNU?=
 =?us-ascii?Q?MsGq1GIChaPZdyI5yk5fX8NlVa5nrCmaMxb2YzxzeHDhYj6AeuDc3OjNmrh/?=
 =?us-ascii?Q?OMELINPBcf8G4v1fifapJR/5IrrxXi867vk+7ttiyxK9jf93xSywhUkwXjGF?=
 =?us-ascii?Q?7Za0Qnst8KOnMHBaeIwKRdX+rhx9LkGG46xYI75kjNue5Mppt5Um32B1HcjJ?=
 =?us-ascii?Q?cMO8KUQBdppjHEkCRLQssWWaL+NetY5MMwPMFmi6Mww3eFqpa5O5lPRBOdvC?=
 =?us-ascii?Q?jb5KzcCqy9NW2BLchFwjcjKtdEEVYMJ1I8LvzZeUSX02N/77nY/p1ctkq+SI?=
 =?us-ascii?Q?Tr5Wknq4yWcwdGiiFeH7M9oqPgjc8aQV/nLHoMCgkFB1h8qmwioI4xlCGF1f?=
 =?us-ascii?Q?idbE6FLQ6TnntMVNyQXywVUU8OS635tgjtck68Tqd+cwFyLtL3thtazfIhgd?=
 =?us-ascii?Q?Tqfz7e31kRFbf7vfqxtZGXfhNteHARk=3D?=
X-Exchange-RoutingPolicyChecked: BaPEKUvzlzXe2EpOMZO3ZQ69pfg48lG2B09y/hyDopy6Brz2PgZFfqsC4YqP9vUeNcO+aglCw1jkmXJgFcnOI/nk0EKcc/QMjYbU8GcnbQKg9R33TI8rr5LQ152t3ajdb0SarYuc+Dyob03hmsWnJzwdFD5vz9TO4uDRt67A/4uORoVfgvHXATZrdNDdMFVkrlJunVqPnJSEagEDuXZ3WfCZQ+suVzWX05ADE77TPSXauPPDbAS+4z5Oez3I/E+FO2s2548XYS4WbIzkqGcK2m/0fFJGTSv10629IklqKH3uHAiisih6qDyg5b7bvDZZ/lcNxhqkijJ0AXU3ALkoeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fa1277-ae12-43d7-8e25-08df3e5f291e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:44:14.3426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZlQKZqsYipPNWnyUeClu7m7UoLl6Jog9r8fAMl0aKd6Z84odnINmOPgQZZfhzWPpQq0QT8Q8Law94nYFjb7roYBd7ojHXWsUb9BJbyVL7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-OriginatorOrg: intel.com

On Thu, Nov 05, 2026 at 12:43:36PM -0800, Stanislav Fomichev wrote:
> On 11/05, Maciej Fijalkowski wrote:
> > Hi,
> > 
> > As the maintainers asked, this series is the first step of moving the
> > AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
> > builds from its new location, without changing what the tests do. The
> > rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
> > net" (v4) will follow on top of this move.
> > 
> > Patch 1 drops the test_progs wrapper of the AF_XDP tests, patch 2 adds a
> > generic BPF skeleton rule to net/bpf.mk, patch 3 moves xskxceiver, its
> > library and test_xsk.sh to selftests/net, and patch 4 (new, not covered
> > at [0]) moves xdp_hw_metadata, which is built from the same library.
> > 
> > The xdp_metadata test stays in test_progs: it covers BPF core
> > behaviour, and moving it would mean rewriting it for the kselftest
> > harness. It keeps using xsk.c from net/lib/xsk.
> > 
> > xskxceiver and xdp_hw_metadata are the first users of bpftool at build
> > time in selftests/net. NIPA has bpftool, but 0-day and KernelCI build
> > net without it, so both tools are skipped with a warning when bpftool
> > is missing or does not run.
> > 
> > test_xsk.sh is installed but not run by run_tests, so NIPA does not pick
> > it up: it runs every case, including flaky ones, and some cases leak
> > page_pool pages after skb_pp_cow_data() in generic XDP mode on
> > veth-based runs. Until a later step makes the suite fit for NIPA, no CI
> > runs the AF_XDP tests. test_xsk.sh is being removed by [0] but it is
> > kept here as there is no other feasible way to run the test suite (if
> > needed) until we come up with an upstreamable Python runner.
> > 
> > Thanks,
> > Maciej
> > 
> > [0]: https://lore.kernel.org/bpf/20261016174338.787135-1-maciej.fijalkowski@intel.com/
> > 
> > Maciej Fijalkowski (4):
> >   selftests/bpf: drop the test_progs AF_XDP wrapper
> >   selftests: net: add a generic rule for BPF skeletons
> >   selftests: xsk: move the AF_XDP test suite to selftests/net
> >   selftests: net: move xdp_hw_metadata from selftests/bpf
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks for acking! However for some reason clashiko missed this set, can
someone remind me what could be the case here?

I also see in SUIE that check_selftest failed - is it mandatory to repost
in this case?
