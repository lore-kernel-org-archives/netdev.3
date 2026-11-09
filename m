Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794251818;
	b=x4xSu40G1qOa7XhPhk0OYZhg8KkNfR0k+iMEcdQg/bWEJ2paqXdPKgC979uM94kLhkPJ
	 Li4GfXcuI1MO8G5nsnRidQC4aYB402eHLlTyGT4iQs8XbiSEeaoddE6spLjE32wllB8gY
	 GCeyb9vM9Lh/GH4i0VSbbLr+zTAokcbuctcz3HUfjrITZlcYrqahrUVWlFackG6//ZX/3
	 wsYSOlOtMxp8UqDPOF12baHNDiBoqbVDAFmc0rKMmLBhzJkFV/0AuNBUGXm838BaF7yX+
	 PD1jI8OWQiq/2eUycix9r7AmS8u77abshHT/H9gL8yXPSKyWdS7y90tTl+7PFYq0cTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251818;
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
	bh=fZu3qhcpMbmqxoSTfqRRYFgKftIiqsT8M+Br4sjGVqA=;
	b=lvK8uGYq4GwcPzEPB6m/hyrbV64bfM9bXCkt+CMipTjztJUkIwbGDe/JfuZdl/JTLeU8
	 sf2Z3S5S7h3o6GA56VWR+BvK3poMqRk6ivDsY7pnbgR+TfM+9egkUjbvfRQTi9D4BPRWm
	 KhEMmmCaUl0lQHXfG+HidW7NZ44RKLifZ1Lo7dX27/MHr3VAvgHPxmDQFyAk7rw/d+8/o
	 bTJP4ZDrsx36Sp2ad3v3kmYwwDJfbj2Bt0iUaC1HtHf7AVApvVOPhu91WeAp1s4RVta18
	 cfWwTczKJb4skHPfClolu5qumi7I9C8vsB97h6W9cx8cdQL0alhpNT7bWc5MsadzOgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ju5GhIDS;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC433606A326
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 19:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC433606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ju5GhIDS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794251817; x=1825787817;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wTTx8H05yeaXe5Z9TV8tKUjK4Cyr2SCEwQgPdBq1p/w=;
  b=ju5GhIDS9a/qNXvOSc+cLblL5nlTj9vzaBjwSXT257bzckOkx3Kk8wy9
   +gE1n9qjpTBt3D2rmRgu2ZltQJz/k5sxKLrhbptHVNy5ET56Vsfwr8PpX
   umCVZEFGVUFy51owN3/eFoKOMNryoSpGf+6Mhr0LV/8Z7/lYFcbPLZMk8
   y4GKiSQTfkIog1uB+Iwssu71iPD5sYtziJzPIk7ytwlyv0Z3fAoPErgou
   NqgvQFUzctwVrbJVULVqn+POAvdDtNVNW7lB7hF9Zpzw052Nb07X2w2cN
   2N4ShAxQlMFf047YDgf9GTetvVGa6eiX5Tq+iszPLKt69GQguiUjPZT/c
   Q==;
X-CSE-ConnectionGUID: aBpo+FVyTViRwyCxLm413g==
X-CSE-MsgGUID: KqXJDD3ZQi6FR3sLa2Ci0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2902638"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2902638"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:12:41 -0800
X-CSE-ConnectionGUID: 6JJZPvgrT5S15XL4B6aOBg==
X-CSE-MsgGUID: cVo9MwkbRTuTk2haHw5PVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7801690"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:12:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 11:12:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 11:12:39 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 11:12:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0OMRahZ726J1c7YN08eo/5Y5+SJHAEw+4JG6A30dL8z0XJqfKpklSicu8obp0+v1VtxFIkPjhEMN4FUn4O50mJarJFW1g1ZHHdVMHMoZT9JyimFpZTI0oGZk/qbF1ox8doH05Se2LcUqtlEfErDD+t92THiaURfkzenTLsxEfH3ufPqyoOKPCXhocBELYD4raPF7e5faJtt6WWWqKboRl0HgQjejgDNqahYfeKzrxG+J3FY+SHz+yUT+LTpvVLU/U9pTFHZ9Q14RfPVu7ns2HPpL9C4/7XHa7b2Uo1URWOaRGQ0vwuVSeid1DHvZeDBOOThqPRA5wTvUEN2lsxM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZu3qhcpMbmqxoSTfqRRYFgKftIiqsT8M+Br4sjGVqA=;
 b=LKpItyaGRpiM10iM6ZWv8kFBw7s0W6pQeSFdjUExTzAsOsrSTqkg5k8D/sGheeRddOFF61IfS5S14hHzMacXi3vaUYvH2VxaMTqYWnDRArvgg4I0VuLd08d9O5xwDwJ0NR2PHEEenDJ/IVUDEZfL9Q9Rr66q4gY1ZPpoIxGrIaY+/9pfojOxi4H+i5jRuY0SA/meRz8O2ptb382gF1OtUpL1mEBd1BhA4niK4qul/0aHdw5bsaqZj6p64lLbG5axGHEQZfaOIRT5NKOFwJGRlZv1X1UoLK/pCJCytWHcgGMA4JvnERjhdkEmL9j+cKoiOd+IJ7ZaOk7gZM0uOZauxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SN7PR11MB7066.namprd11.prod.outlook.com
 (2603:10b6:806:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 19:12:32 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 19:12:31 +0000
Date: Mon, 9 Nov 2026 20:12:25 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH net-next 0/4] selftests: move the AF_XDP test suite from
 bpf to net
Message-ID: <avIbGSNuDGGqQtcj@boxer>
References: <20261105134117.977655-1-maciej.fijalkowski@intel.com>
 <auzqcm1YLsTvUU7S@devvm16445.scu0.facebook.com>
 <avHAGLwtyucllh/M@boxer>
 <avH47_V-WbLm35cN@devvm16445.scu0.facebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <avH47_V-WbLm35cN@devvm16445.scu0.facebook.com>
X-ClientProxiedBy: WA2PEPF000008B4.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::68a) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 468feb6d-9372-4ed8-7c5d-08df3e956757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|261028144727099003|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Jo4bll3NYRbLokMtlDwRtigK49YIMY0/cu7aLdda+MEHg8ei7w1Pm5MNWmKK2xKhE1zelVxG30x3Q84xMfwWHA8cKEtkoLpuwa9qR/GIvSXNBE2iyqrvPnlYsXMF5FlgohT3B5Za1U/R9HsHyZ2lVjjoJyMTR6LsH3JKFttSePz2S0nxMybRSBvl0cPeuk0U6+mpJ5bGw6pmBCLjLklt00GgvqS65UV9KI8iEhBAnUMl1JWFwTNCEnCuXBYnTYQoLoHMLrJp0M9IKkm2SivLk7oZ0ZKE99ra/H6ymgpKgFj9HBehcmonjMML0ZfGXgIarA2z9wIQy4vfYkHT4D8ZIo6vDn9if41eLH/byVV13dDltCCXP0XTyMm8l8sqzYWW5LqyPvjkf8n9N+FmRET8N7GARzxKN+rpYKfvCiYb0sWkxKSDs7KPKUdhW4lNZ3kJUbM+NUERkii3tEiyzpnSjyNUAekK/xXE4cEmZ22j5uvDIWbl2ql8dvtunMtQ7XT84amPeRkHT3XaUkH6xXgvaSIjxCibI8T9aTOC8HWfTp5b11etKawMWQImFzQ9KTysg/a0B988G1n+s9rht6eiAzN2rBelUhOLGahtAQVDvFbUrHa2T7ad4ZXo2aZd2Uz1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(261028144727099003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hbxS0oGN8+ONNXYCOaaVWgJieqDjKt8ldkh2YQj6rUtT/VS7ryKH8XSR1Hoi?=
 =?us-ascii?Q?dfBRv4u0Sj8FIRVWyNw99vAbcExSKcxFsbfaPhzvoDt0GMbGw8F4XmY8F+8q?=
 =?us-ascii?Q?cMFOF10cjoVhVzOMscrMSmUViJg6XQdMuvRbkZU9swd0kQlzh5930lVFZPjy?=
 =?us-ascii?Q?pNKwOjCSNmSkj0QXuamrgu3hxiaPbAppHpfc/l9ObVPDAzpePUrQdsfcs9qN?=
 =?us-ascii?Q?hT0/83xcRIGYMmbZwkQSp3LxSejSGE/EMDUB7aWynLkM9j1tD02GxLUj4Oz8?=
 =?us-ascii?Q?ie+uwUs8imUVqkk6xTa10fkmauTeh4Xfx1VGpstVpktnouukLGZ6kf2Nllly?=
 =?us-ascii?Q?ANpxShjCQsBFPRM4+kTcX9HAs1+8J0l1853wjhXHCYMrafQQpn6Rtb4uv2iD?=
 =?us-ascii?Q?jMdmHkSETgbVk3sNJvVAGaF+ibdMHdk+wJDyJFNUfK0yC/kRv77l36/9XE0M?=
 =?us-ascii?Q?QbZ4tTUVgsUzRnMppRDj5pGa19YJIzvjcF0G9/82PClt0oPj5vXG3U1wAZ57?=
 =?us-ascii?Q?Xm0ODcrxoaTZarJZgd/zW/mSLwZfMWH+VzoHp7zb2LF5HV63Vu1hYg2vPBG9?=
 =?us-ascii?Q?4NgiVst4yElnzAsLV4XDDqs3dkOIiiMC4Vif9dsLxY2Rx79brnKsrkfuEZxm?=
 =?us-ascii?Q?4hTMM/m+doXibIQ2bnTd6YDNzRrpZTTCFS2sjRtD7YUjiXo9M5IWpgRDND+E?=
 =?us-ascii?Q?SjFQ5d04OAncIzopkXTmW3GSTiNoAX3dvOc9L9glA32Khz8XEIUO1CdUh5do?=
 =?us-ascii?Q?DWcZIx0K8STRx5usjJzul8Oztfgt70tgG1lO9+UCglDmHYFZWa9t01wGpNRc?=
 =?us-ascii?Q?RkrpeXcH+T3MC45y00Dasdi50ZKlCVJmuhp/FR4dBdWcUb2JipWKOvv7OlBt?=
 =?us-ascii?Q?mw13qjVNGQvTNxS3sFRElHYxzUmZH2Q0yLham055V1IpBZNCuvQXs1EybJhO?=
 =?us-ascii?Q?6SEXZyxixWLKlszhnMUGKp00DMLcD5ZAyIvm3SqtOnUDFV2yuKjUSWknUpdB?=
 =?us-ascii?Q?aJcLPtr3j9q+9Lg6WCuETe6MUSEL/YhZb/z0r8ToF7DToBr4Z7lwGQwvc3hS?=
 =?us-ascii?Q?r0roAEU5EKkR1iew05fos09unK/Xsgy07mDNQf8fVaoZ7yjAclY2OBHa37uG?=
 =?us-ascii?Q?+xUanO61WnsVLxYyWxTb9mCYNbyW/rZrkM90hNvN1FkyARd3W46hI5WPPWOk?=
 =?us-ascii?Q?Jx5dIYnwR2KSoYjmKmKf9lPpz5NSLzhLwMTeeaZ5vi6w2e8XM958ah5RFJxn?=
 =?us-ascii?Q?7pfZUkaDkY9Wh77cny/A7PMwEy2HYo5UgcTYT7ZloPa53q75y/4ofw0isLYZ?=
 =?us-ascii?Q?llp9V/KH1EsydjKNCiDt/WfpJWgIV6ffqPqNnbBL8tkS0Sb7gPYPmKpbsaq+?=
 =?us-ascii?Q?1s4dq8RYaAw/14XxYp8jjY9o7XuzTyUq2Hk7YJrUvPJGSq3HdUnvWLfcrbsi?=
 =?us-ascii?Q?3FH5pg9L8/gftT+vrQEh41ww90gtfX5kM3ud9cdN3MxzHNwWZWjxa8zFvTVG?=
 =?us-ascii?Q?odXuMGro6Gnoh2Gvf7inrn8SN6jVhV+i1VKRZvejAOW8yqTiwTFtraS4heDm?=
 =?us-ascii?Q?p6qftzg60x5RU32np48NOcj7MbnsFcaaOjkm2uEUDkYcOuij6H8d0ei1jXqc?=
 =?us-ascii?Q?y/cJ2HrdnE0HgnygNKoTtVEh+OSlEL3fYfc6rGHcQefYYxketpvCDGjlXQ4F?=
 =?us-ascii?Q?qJugRrEHXMyTlGLBGb/VHmuPGP+3isw4VjPrsHp8FVihRdWubpXOOkeuW98I?=
 =?us-ascii?Q?/8OG5xHm0/Fam017y2etqQUdy0CyyWQ=3D?=
X-Exchange-RoutingPolicyChecked: A8jgjfIQsB7Q5TWPbaRfW0MDpa3pAtgenJ0CX0DuI3xg+Xr9Jur3Yi+KYrovxIPSWiGwShkHSovs/BlXRsXoJEQAsSBlgwnr2r/I5K13Y+4QdNETzdHU5yyg3V8V3yJtTOGdGR1/J0YShyewYwye12o5GchJ6EAiJT8trldZpxVuvonbj24GIERFyjY+rZ2+hkvp6SDNvUUqxeGLAOPXluiG2FnwCUb5J2prOfbwOy5mS/xBjG9OsFMGwEdxlqk8unQ1l2pASovPXpV8vyU8GYHEwUz2gWVtalwyIc+V3VTySbpOXPX6N4KDu4UNt5nQJt65tV18RkjOr11R8ZbX8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 468feb6d-9372-4ed8-7c5d-08df3e956757
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 19:12:31.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bx5tqOIgsfRZ6udiyYqMSMe0c7WJMo99hC/8mVMSbj0QoeYU3aSdvBBkhaEOVoOcgujfKGLOxiUn3LcUljncSswdFGXXDPaTQhvWX3vCvuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com

On Mon, Nov 09, 2026 at 08:52:20AM -0800, Stanislav Fomichev wrote:
> On 11/09, Maciej Fijalkowski wrote:
> > On Thu, Nov 05, 2026 at 12:43:36PM -0800, Stanislav Fomichev wrote:
> > > On 11/05, Maciej Fijalkowski wrote:
> > > > Hi,
> > > > 
> > > > As the maintainers asked, this series is the first step of moving the
> > > > AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
> > > > builds from its new location, without changing what the tests do. The
> > > > rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
> > > > net" (v4) will follow on top of this move.
> > > > 
> > > > Patch 1 drops the test_progs wrapper of the AF_XDP tests, patch 2 adds a
> > > > generic BPF skeleton rule to net/bpf.mk, patch 3 moves xskxceiver, its
> > > > library and test_xsk.sh to selftests/net, and patch 4 (new, not covered
> > > > at [0]) moves xdp_hw_metadata, which is built from the same library.
> > > > 
> > > > The xdp_metadata test stays in test_progs: it covers BPF core
> > > > behaviour, and moving it would mean rewriting it for the kselftest
> > > > harness. It keeps using xsk.c from net/lib/xsk.
> > > > 
> > > > xskxceiver and xdp_hw_metadata are the first users of bpftool at build
> > > > time in selftests/net. NIPA has bpftool, but 0-day and KernelCI build
> > > > net without it, so both tools are skipped with a warning when bpftool
> > > > is missing or does not run.
> > > > 
> > > > test_xsk.sh is installed but not run by run_tests, so NIPA does not pick
> > > > it up: it runs every case, including flaky ones, and some cases leak
> > > > page_pool pages after skb_pp_cow_data() in generic XDP mode on
> > > > veth-based runs. Until a later step makes the suite fit for NIPA, no CI
> > > > runs the AF_XDP tests. test_xsk.sh is being removed by [0] but it is
> > > > kept here as there is no other feasible way to run the test suite (if
> > > > needed) until we come up with an upstreamable Python runner.
> > > > 
> > > > Thanks,
> > > > Maciej
> > > > 
> > > > [0]: https://lore.kernel.org/bpf/20261016174338.787135-1-maciej.fijalkowski@intel.com/
> > > > 
> > > > Maciej Fijalkowski (4):
> > > >   selftests/bpf: drop the test_progs AF_XDP wrapper
> > > >   selftests: net: add a generic rule for BPF skeletons
> > > >   selftests: xsk: move the AF_XDP test suite to selftests/net
> > > >   selftests: net: move xdp_hw_metadata from selftests/bpf
> > > 
> > > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> > 
> > Thanks for acking! However for some reason clashiko missed this set, can
> > someone remind me what could be the case here?
> > 
> > I also see in SUIE that check_selftest failed - is it mandatory to repost
> > in this case?
> 
> ```
> Bad format: tools/testing/selftests/net/Makefile
> ```
> 
> Not super descriptive :-(
> 
> Maybe check on your side if this is complaining about something legit?
> 
> https://github.com/linux-netdev/nipa/blob/main/tests/patch/check_selftest/validate_makefile_format.py

It is upset about redefining TEST_GEN_FILES on patch 4. Will send a v2
that fixes it.

