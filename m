Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793201529;
	b=jxQbPrKkwkPCX18QdpMq6Rg5JuRGjFsDXinHfTow61zD906ULpi2ymHbEJ4RtBO8fMcq
	 gfVyuqXiCXS8K8X2wdH6FKpo8iaZdwn0QOAdYVIQRpn69zYd0ZkcV/WuxU+57BjBtHymr
	 799TuQUExwgk51r8J6/han+bDrJXQWWqOgLBWPc9DbrsExSBE6m5i9WRcCJEtPMRYmWrv
	 cKekWQNME8h7UytvJsWAMKDU7hMLzDBavDWC8POVVphRkPLFJe+KF9Hyo7hkHdPs5Dfv0
	 rNPzSZ4vcrG7y2swBlTag9lsQ/sxa7ATjCDr+XehmjJF8CHcyRuP3CQ2J6JmJMhc/LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201529;
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
	bh=Uwlq8n74iq9ZGVSisOQP3UO8Eymj8xbMTmGXLOThcfk=;
	b=fMvvkahYLy08JZuET/VbGxi4VVRHxvG/jEDk5U2JCiQi1dOVyV1y0XJVAS4JzUKLioW4
	 xKAXVkkmrsTO2bzGCM6R47AyJIiILQHt7rJOCvI6+mbjqnDuTJlJHkRFQYA88QkN1ZBuw
	 uvbXtE4w+W3g7X5/xltTZbKbYmT51DJlwCBmE2fKmaYCU5Yf1N0Uba3pd8LGshJhauGOU
	 LMXLyf+mRgeS0nmgGj1/vtc+8hhjSV2IR76sMAu+EVa4WsJ0+XnIURAAt6CQXMuwEp3oB
	 lLzbgqdlmjPxX+1l1ED/S9tWELRJhpVBRWlkl5yCcg9uuyDZ/Xta9CffMX7letW4a7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H5I12in+;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269D606A322;
	Wed, 28 Oct 2026 15:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2269D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H5I12in+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793201528; x=1824737528;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gLq1+LUnQc0OwpFIl/2XJeO9InMePO8aq1V/dL81hw8=;
  b=H5I12in+hdnfcGkAT33KnYplLbRlS+Z7xuK+aegDruq5z2kdis2F533T
   t1dNMCWIF0byfECoiAKzNvQC1VL5MwGjZj3qcmGW2z6jjICJgpLs5iMSz
   N1NLrW7k+NfGLKtFRXGu4Vk4UllIMG+yLyfRayz7oCs1cnC0Tn1ZtliC+
   oyGl34mycFLaljlloiRzo7qDXOY7t+nZswZ98T1Jjsi8REq7qsxu9rnDF
   ClmxuSJMbQY02O0O2qJmv4c18SHFKlhx+qm4oYu/PxN+KWdfwbrcIWtXS
   HYpFTcHc93lzEY1pK+WIknByD1ij6kLSYkJ4KaKOuVUhRZuo6dpQp9yJX
   Q==;
X-CSE-ConnectionGUID: OLv+++pmTGmPOTW64w3txA==
X-CSE-MsgGUID: anaChF5uRdWam8Iwh8J4og==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1823039"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1823039"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:32:06 -0700
X-CSE-ConnectionGUID: zmr0Jcg+RmS8F63hjFg3fQ==
X-CSE-MsgGUID: uFWvC6KwQ3q5KI8rbyLFqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5262848"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:32:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 08:32:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 08:32:05 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 08:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak8WrTgIlHsGtu5asduVbUQG7VUkstaGt2lW2j3as4Pws3z5GIJLNt7J6IHXcpNGHNrLfhQjzK2vNnY2qdJHAant/KxBUOWHyJB+nfpYUxM2AzO0vJfuwGoOLWM1hr3uEQlh6CwTOgosEF4oIA5hNhKJ1ishzl3ndvVJ1zTgkeHF+fmTeImtdl/tsYXA0qv1wu05Nr7kO4uW+B+FgV4r9bDT/qFBnqBB/+e5DgPXsnZh4sv5yxcbO5nColxhffpmtzQghKxIcOAeKLVJlrzbgDmbmwNbTcvd/pDvD0FYGHVuuEwEmPrgahyyF7EIsbVzUDGV8NmDJW7uZnBKxhBtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uwlq8n74iq9ZGVSisOQP3UO8Eymj8xbMTmGXLOThcfk=;
 b=s7cMpSeqIOJXnX0moNIgpusebt71r7rYYhatpVKvZ7Ypm3lwAxXYqcBU6wVo7ZctyKKeKr7g8eDVXWln1OWfACd+IMCzwo5EZarsj53CGrpZlC3Gv0BWj1QK40fJqUKAysKQP/zLt6Z+vYRZZ3haWXvtBqvIWYQe0AaLtr4TPf36Xy75j+z400Z7sBQRppS7rnHmVrm1f99IA3TVl6EfVqX6A5B6ehmhqnkl/b50QN8PG2x4GGDLg4ezqc/PQnKuXDkcBodR97mrfTG4Aowu6qxknwyHQbgBO7mjkbXVyeKglnck+c7XP5ZHHZOIKEQPr5jKiZummt4jEEV+c/7C2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by PH7PR11MB7051.namprd11.prod.outlook.com
 (2603:10b6:510:20e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 15:31:48 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:31:48 +0000
Date: Wed, 28 Oct 2026 16:31:41 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <aleksandr.loktionov@intel.com>,
	<chwee.lin.choong@intel.com>, <faizal.abdul.rahim@linux.intel.com>,
	<horms@kernel.org>, <vinicius.gomes@intel.com>, <sasha.neftin@intel.com>,
	<matthew.vick@intel.com>, <aduyck@mirantis.com>
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
Message-ID: <auIVXcu4Mb8WGLd4@boxer>
References: <20261026091549.605810-1-p@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261026091549.605810-1-p@1g4.org>
X-ClientProxiedBy: DU7PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::27) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|PH7PR11MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cab887-0e9e-4c26-5cb1-08df350894a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|5023799004|11063799006|56012099006|261022105027099003|261009223027099003|261021121427099003|261026121527099003|261026140227099003|261021123027099003|10067099003|22082099003|18002099003|261028144727099002|3023799007;
X-Microsoft-Antispam-Message-Info: fOAMyomwjMQ6nnsdgAvYbzyGOcrzPeZJsZDcXEkPxQCR9X7mkso+JBa7y9HxdYlNC6nNG1+HmfQQDXfXpKqWxPGWulNHfCiNAIo60HO6U6tGoSwu+LhYszdQdunDhwNzeOfchLJh2Bks19j+/dKRkeQDk+L9JPZTFxt87BE52hERmuootBFLa3kSEDlHyN0F6x+gdr/YmjaZsPo1IAeIeSa0A1Sb1RIyNW11Sgmn4lcjMgc8DhHMs0nolhhU7tE7Bcp2UKItoiNg0hElY14V0uVW+pEU7YI1LyK41WkBcDR5p9npivMKPm/CbaEk9SDhTuvthLX1Vo9SEubSPsIL3mc1zqtg6cJiw+PoU36ww3XFXB5DPM09aYS0dyl78QoJMgFIzW39OUyTSmSiawX8h5cHsWbWQMMUm2j/HyjeZcX/Te8KdHkwkbJwtFUVeXN3gGWgqSwZesrQy5TdSv3iR1FOk4lmO6dW5SPzf4hYx88pm3a5OUStIKfugHbT7/S1tOvmKlb2gCoHFIR3ngV7Li4QQJPyzHX0B9XTM8ZITsnVW/kCc415VDS4KAQVv/Or5yLgUsWSsucunizBVnCZf7mbjGt4FHTFiP6oEBZRqxyD4x3BBdNKeANMuvggoN7eXFdzNJE/GqFpw37CPEhApplU2vxfEB96X9H8bYVWiEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(5023799004)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(261028144727099002)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jb/uEp2964jCL4tJ1TOkLi/PpA0YTpKrOlEwmIUYJVfVV2je7NOtKPNCSmyf?=
 =?us-ascii?Q?lOr2aDzWixfV4KxUI34gdaRGfR//kgG8UVq782b1wBMF2jrr6lYtOEc45jjH?=
 =?us-ascii?Q?WWT83mxVqyaweozaBdRlSEb6KJn4dgmlMSPQRb9YShoxQ44A/85i3d9EoQ9o?=
 =?us-ascii?Q?K7bbtyKbVLh57Sjo83ukANtSW8u0HMp9NnOSFWmVZztkmah0aO3aSfH34CwN?=
 =?us-ascii?Q?hGLkNPVr80Tk5xTnMDXezQGFnwPg/encAEc/OoZPXunvDr/yaHIdEdL8PSwy?=
 =?us-ascii?Q?k28tOc6bbi1+34JZJTp9H5sZLsFfW+0kGi6jXc3mQWqq3Cp7Yt+UD5g7dtXp?=
 =?us-ascii?Q?qYx0x4g4G94CvYoV+S3UxPHbIPBE3j151pUuajIVZLJjlE25dv9n8UUIMlmO?=
 =?us-ascii?Q?N3NToZnJ98LtNBXoHFDWfvhItOI1nfXTC0X/fXbW5Wot7Fdo7wglrrhxAvz2?=
 =?us-ascii?Q?2UB7nwwi+8qvkb1vKMtQ5I+M6Mq57d7dvPG4qmPxRSZG4pbXL4ciTQD+ACxm?=
 =?us-ascii?Q?C1HtmWjQwbcr2GoMgFN/RYDWd5TcO1J6fU217mWKuU4+nQF6GNfdCN1kHlpB?=
 =?us-ascii?Q?HCy84cZTtWCF6zqz43s+kvmMNbqWMQXyUhocxUEw/uGo0PKkZ7K3AimQETtd?=
 =?us-ascii?Q?6kK+IeX3p9wpJn9RnEAhV2MzNfB5iwvPMcGRZzag+FbMCxkv/FKNNoxyvJ2R?=
 =?us-ascii?Q?DLoUvd1ZvIbZwDBYalxnSMzKUZ4F6g492x4JgkYLhcUkMtuy5S6x60fVNwSd?=
 =?us-ascii?Q?n61Xx23xY1Iv2ObIli0KFVxc5miXMGoHGbZmOhOJ0sz9s+jUp5jQRGQuog+d?=
 =?us-ascii?Q?Vf13pNYzJTOpfiCn6prgR4i44RBqvcGfk6OU+haW7KuccWaSxpTVVK94d4ro?=
 =?us-ascii?Q?M7fWHF3y9cohhozRdIlkw/doiDu0+LWAYVEBkLSX8FZOq7M6CWJKZ/S+y9gw?=
 =?us-ascii?Q?DuHWBriAbVF4r8sCVto2010TpkJUEi2Ad4UEtxjwoWfNd8gi46YnWbsj6OFw?=
 =?us-ascii?Q?MRak2M8NhWN5Cch7bN5BCwrsWT9LMWe+2y9vnsnnD+3dRTd0em9KK6PadkXV?=
 =?us-ascii?Q?F3QNaq0BdkaernLvgfYk4YMErEcRZH/3i++d5kZyMSJfSousgUjBahEYDjSW?=
 =?us-ascii?Q?mOjspNZghehO748gnGlBhI51L2aTqVLqAMD9cPSGvd5umVQvb1ADl6mJsbOa?=
 =?us-ascii?Q?44WmXwim8GahlL38qCoBA+pVa4TazI1GAVX7/NV8Fr/533xpuJxJCHJmo0e1?=
 =?us-ascii?Q?hW3CRx2epvl8+gXN0mU2dNiBD9fD/fdceANhcevqOwu80XECvm60QfkFuCVR?=
 =?us-ascii?Q?kZXVDwZBuSEncjfIo9QgySXm/6wR6CC9SWwQla4iq9DLRxpItoj81PmuL9Gw?=
 =?us-ascii?Q?srWZml1W7c8koHVrCmus72ovwvnmW8Noqgt2CyK/DxE8ycN7LYTA/53Mopxv?=
 =?us-ascii?Q?96R37nesEPa+szDiMsve2qGZHna+yvlCItKhUd/FVzrpDL9/hgAfIJyjQjZV?=
 =?us-ascii?Q?BMbJ9VXXeatb1x9lPgoNANxaiYYkUSKlV9pnjRZ0ZNuE87kUDR3f+gWh2K0f?=
 =?us-ascii?Q?zluUOnRLmlxOQaZLvgA083iSuDjFHmf5Yh81f0l13Gz1LkHYeg3QEg216ksB?=
 =?us-ascii?Q?RC01YoMQYfglN/IPRfVibvssxhpS32n/zDRcRnG/v5LDos04r/nFSdvciruW?=
 =?us-ascii?Q?+N+Jnz2zUSO5SRDj1vN1HxXNDA8C1sMS0tt7r8ilWBHNty7zLuCE17pQy26y?=
 =?us-ascii?Q?hMfGA86qg3BaO0h4c/BVMG+cuGJTH2k=3D?=
X-Exchange-RoutingPolicyChecked: 4xdv8E4eeYSz6v9WjrQfgeue2NivUWNRG5mWzh0T5ZlGMW5roS0/dXu8vsMwREspxwCwb8nn502k8C2ODfyGjd/k5ApgzDqUrHjiWOnz3F2e1dz9UhQEFA6exR2rpZL21HVzmSBKrtrP2lMyVJQi/MtqUZ1FzJZVxEsXgS5FpQqEkkKJfepzOC/mb2pSWExnVLANetyCiHr1aNbdVZ4UAIDToUQTFu5BWzpGdTkvCZR0sq7SZfm1Rv3wPYP9yVrc5/VYAwIYSafq3Fo+QVVM+tHw3zldw5bmyxb4Z6v+8kJShsDXAb+lViVbHCTwY1Utdk8H/VN6gpxnI+pTptIVPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cab887-0e9e-4c26-5cb1-08df350894a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:31:48.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQFxegqxONJsCHGh4Cr8FkITFFsKzR1Z8jbvo9xfo9DD4IoecTFT4gSG00aRWXSPvpGtdc5M6pWIq8dayl3SCH5f1Q48dVF5oS1Wr5h40jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7051
X-OriginatorOrg: intel.com

On Mon, Oct 26, 2026 at 09:16:07AM +0000, Paul Moses wrote:
> Preemptible queues require software padding so hardware includes the
> padding bytes in the mCRC. Padding currently runs after TX timestamp
> reservation takes an extra skb reference. If padding needs to expand
> the skb, pskb_expand_head() rejects the shared skb.
> 
> Commit c7d8bc3dd511 ("net: skbuff: don't BUG() on bad arguments to
> pskb_expand_head()") replaced the BUG_ON() with -EINVAL, exposing the
> padding error path. skb_padto() drops one reference on failure, and
> out_drop drops another. This can free the skb while the pending TX
> timestamp still holds its pointer.
> 
> Move padding before TX timestamp reservation and use __skb_put_padto()
> with free_on_error set to false so out_drop handles the skb release.
> Preserve the VLAN flags in first->tx_flags when adding timestamp flags.
> 
> Fixes: 17643482e9ff ("igc: add preemptible queue support in taprio")
> Signed-off-by: Paul Moses <p@1g4.org>

I skimmed thru clashiko output and nothing major stands out to me. For
your future contributions - multiple patches sent as change set require to
have the cover letter.

For the series:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 39 +++++++++++------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..f1bf4e462a51 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1661,6 +1661,23 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  		goto out_drop;
>  	}
>  
> +	if (skb_vlan_tag_present(skb)) {
> +		tx_flags |= IGC_TX_FLAGS_VLAN;
> +		tx_flags |= (skb_vlan_tag_get(skb) << IGC_TX_FLAGS_VLAN_SHIFT);
> +	}
> +
> +	/* record initial flags and protocol */
> +	first->tx_flags = tx_flags;
> +	first->protocol = protocol;
> +
> +	/* For preemptible queue, manually pad the skb so that HW includes
> +	 * padding bytes in mCRC calculation
> +	 */
> +	if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
> +		if (__skb_put_padto(skb, ETH_ZLEN, false))
> +			goto out_drop;
> +	}
> +
>  	if (unlikely(test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags) &&
>  		     skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>  		unsigned long flags;
> @@ -1669,10 +1686,10 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  		spin_lock_irqsave(&adapter->ptp_tx_lock, flags);
>  		if (igc_request_tx_tstamp(adapter, skb, &tstamp_flags)) {
>  			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> -			tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
> +			first->tx_flags |= IGC_TX_FLAGS_TSTAMP | tstamp_flags;
>  			if (skb->sk &&
>  			    READ_ONCE(skb->sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC)
> -				tx_flags |= IGC_TX_FLAGS_TSTAMP_TIMER_1;
> +				first->tx_flags |= IGC_TX_FLAGS_TSTAMP_TIMER_1;
>  		} else {
>  			adapter->tx_hwtstamp_skipped++;
>  		}
> @@ -1680,24 +1697,6 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  		spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
>  	}
>  
> -	if (skb_vlan_tag_present(skb)) {
> -		tx_flags |= IGC_TX_FLAGS_VLAN;
> -		tx_flags |= (skb_vlan_tag_get(skb) << IGC_TX_FLAGS_VLAN_SHIFT);
> -	}
> -
> -	/* record initial flags and protocol */
> -	first->tx_flags = tx_flags;
> -	first->protocol = protocol;
> -
> -	/* For preemptible queue, manually pad the skb so that HW includes
> -	 * padding bytes in mCRC calculation
> -	 */
> -	if (tx_ring->preemptible && skb->len < ETH_ZLEN) {
> -		if (skb_padto(skb, ETH_ZLEN))
> -			goto out_drop;
> -		skb_put(skb, ETH_ZLEN - skb->len);
> -	}
> -
>  	tso = igc_tso(tx_ring, first, launch_time, first_flag, &hdr_len);
>  	if (tso < 0)
>  		goto out_drop;
> 
> base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
> 
> 
