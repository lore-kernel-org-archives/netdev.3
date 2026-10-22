Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792653113;
	b=ceBBrWDkjtMXLrMNTfkr51IIKO4KHBy+fa8rPDAK230vVJplZi812BmbioguDsWko+m8
	 mKAQVQHmPAqJisWgN8L0nEajK7WO4j1WuF2OHWfDqFHpRn9I2kJx03tX/QuPWlX8Gid7Y
	 8rgpry0D1e1okfrf4BR86kGpsjxjqRlpRKrHd9hkkiU77RxtaCOHNDcOHJYRrUmgAsKBK
	 YoKGvTd+BaF++Wlpe9MvLrGEVJkq79jgYX6pkC51TD8Lp1ipreR3fVq+6CJs2G3OFeL3j
	 5uma9HREC+jqKOFB0yASQXPYP9YJ9XYMiuy+vkpMd8VJGEIQBpMm1sNG7eAIv0zbDug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653113;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=6Fb6gAiKRZhF3ZLE75++fFKoMpc1PWH+XkeOwlSWLDw=;
	b=nKNN1RRLgrRWuFnzLUV2XYdU4UyygbzjO+CKJ+F5IBGXdKfKO8ML3+nIi3+imbKk9krE
	 NxHUKDbB7g/fceOA3vu8UUik2cgvAO+7wdsKXnr63K+oR2eFxJr2TYm3EFsi8uaSRkia/
	 6Fj2OKEXHJe6NydGrwXAmlfE6+whaa1oMf8m6UfXfdOVCn0wLGTuCrvpinYutT9BdDNLz
	 OaHYInMPy/MxDIi38pfooeMRywhJtIZ8CsXzoga7UsA35ZDP73hBkhZp+MoTRpnoUGu2Q
	 DWOpv7tfrqPKmhrMp/DxwqwRJ7afYvih2xmGYrZ/SrIzCbV7J2owKPeyuFSBCYuh2Ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="kjlg/NAM";
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7588606A319;
	Thu, 22 Oct 2026 07:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7588606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kjlg/NAM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792653113; x=1824189113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vaFOEDwLr7tmpH2ac/KKvcj50CxTJNQcnizUwdh7+hI=;
  b=kjlg/NAMyJ+pzyoqTzE4kWcPvVdcjl7YB/Ab6yeFMZrAuinnMwvzTgf3
   ywpIGwl7mbAmtaGFKENbpyXNdM0LxH1LYL7ozMslIHWqlZSrRi5AuVu6Z
   7ZMsd+3JHe0s9jVlgJuAKCSwz70OdHlSVaMZ6QSXnWwqMlOcH3lwTZA2G
   gLCggrzXlieNGcyqU4R2Sl4yrZz2tLVQqgSp3BUAR1EXf//RRzWPklzZd
   MYmcI/vMNiuUGqqZMdvadvcVtTCYy/0y5OZNsjk6l+9o8JBBM6nocECFD
   QNS9nlBOEoc/3bWZFg9c3d+DfB+igTpJIVtNH8joQw0+14mQfCCOKme/8
   A==;
X-CSE-ConnectionGUID: U/9MB9QxQfec5Q4CVTKaNQ==
X-CSE-MsgGUID: NKx20EDdTtSto3ZlQgBgKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1269984"
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="1269984"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:10:41 -0700
X-CSE-ConnectionGUID: 3RzH3+ieRlKjsPKIoiWPZA==
X-CSE-MsgGUID: qPJupiGBTIG5TPHUDW6hgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,171,1787036400"; 
   d="scan'208";a="5050799"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 00:10:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 00:10:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 00:10:39 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.51)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 00:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObimnIDJXnPSqa7GAjkpWWvkqw+YmrtBKuKcdKFq7uLkbz3aFdtvT6WGbNv1JXBOId4VBg0PjxL6aW2zG6D7udnozX3GCLbMmq7YogagbxcDQ1HsG+Cz7WUJFyoP4xNFFh6hgmlHYjWlGjjgoZMCCiMv5t710ASDhh8vSrZFZv/9QcqOzzjIFXhICZTivIxB8ONignOe7NxPysGmG1kQp1ap42XaRniII+NDZMA7aEVj0RKJjCWh6zk5dmaFRgzhetLagXu2M9KFHctL4GshtBm4M0SLyEACYpgozCXk4DhZEajEOBLBjgUw106ROEu+wat7T/bb8Ax0WNNW5jERWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fb6gAiKRZhF3ZLE75++fFKoMpc1PWH+XkeOwlSWLDw=;
 b=YqKf1PnE3duSsEnmlZI6DzWKKSxr5qGayzaw9ClGZfCjdT7ocolzEkr/9OCd8Z0l7mNZOA/2nR9yghUI+YDv/AmsE3Q+1mYdyGJc0xVZdxT6bDq1UhK2kmLGERmZ2Tbo2IviWeERTZDZdfukw2+dqzcsNjpLBrzIUyDw4UTZ035RzrTHNqRiqlgzVuv/dsNyFILrh4IavJBicjtU3aLNi9Hbk0lvd9mqtFbJA53h+BMjiv/vNnfYVgXT84UqTwsQpavbmDlW6PMyXelQXz+rJpNgXfIz5kSjqsjtYwC4ij0l5BoRhD9vX1p9fJEHcshsz6rtovLAzcSssED9RHapmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW3PR11MB4617.namprd11.prod.outlook.com (2603:10b6:303:59::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 07:10:32 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 07:10:32 +0000
Message-ID: <a71ec0bd-bbce-4801-b79e-8b7d648aba6c@intel.com>
Date: Thu, 22 Oct 2026 00:10:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] ice: ptp: serialize E825 PHY timer start with
 PTP lock and incval
To: Simon Horman <horms@kernel.org>, Grzegorz Nitka <grzegorz.nitka@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<andrew+netdev@lunn.ch>, <przemyslaw.kitszel@intel.com>,
	<anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, Maciek Machnikowski
	<maciej.machnikowski@intel.com>, Marc Neustadter <marc.neustadter@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>, Milena Olech
	<milena.olech@intel.com>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-2-grzegorz.nitka@intel.com>
 <20260926170543.GA13925@horms.kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260926170543.GA13925@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW3PR11MB4617:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a4dfce-c3a0-4173-a066-08df300b8f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|261021123027099003|56012099006|4143699003|11063799006|261009223027099003|18002099003|10067099003|261021121427099003|22082099003;
X-Microsoft-Antispam-Message-Info: HtLlJwDIVmEwfz2pkDxi2VNXjglfs6RnY75AXYrH2rwzem1uGeytRgTJibVb0Zb5zc8I13HG9prKq7ih5kSJ5SXIpaf4IMbtbJheG9ok1eYM5tdaHZoNid+tGhU7y7FcXYfkKWhqQ2CcjZ2XGyhZY/8mC2TdY4LuedEPaXRl1oP4rzt13g2SgbuJifWOXyw7fceO/H3iceiPBBddfHU/GSIEEq0IzEz0BA8ef7HkhBO8of9qNTaszpfWtTP03eM++I0Y58xq2cAfqIrxCzW274pmkC8yBPmV/Lk1hQ5pGB3rjY9egvQUkbseFJmbpNV6MnmqNl367RFreWi6Et2lx37PXrVsfzxs/ei2H024Wu2TkdCkUuRQH4NHbqtJ+ePNLsPhi3r7vMx1B09HHD9YmhUiIcxmorhJe7Mfn8dmZ7i+Tge/gBN1oFsCuhLJ79jlkxb8+Gwpb+jR0VWxrwYPWT+pbt+sejVmmZuoqGF3wfkF9WAEEaLEXgTJ0aCfe5XVVekTqXbE9w9sGMwlHBx8NSPBBnTtfBtcqNvz/++xUC/oBCyz2LCfgX1FCHk8XwtPPSYzpGuS4nSQftA+vVUskitqGzqcrN5H7roxggJLao+RW8ijEvSAWsq+VQWouX/ST18U575KDyTyh+bWiskcUhDaSKU2BBXhC2NGZjN8lTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261021123027099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(10067099003)(261021121427099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGovUXRrMmVRZmZyM3Z1TTJrTGVUbWo5U3QzRDVoSHBMR3UzbDJ3bUdKS0Jw?=
 =?utf-8?B?MzdxejVieUoxcHFGTlJZR1JwSWpqV0ZZMk0xS2w2L2pzRmg4VjVPL2tDTXo5?=
 =?utf-8?B?cUFsWlhXN2VsWU43UTJGTFF5M3VoYnpLeVd6WXNGU0hRVjRvTTdmbjljZnE1?=
 =?utf-8?B?M3FxMkpZYmxaK0lXOXF3NVBFYXY3ZzZEMDFUOFFIWldvMHFXQ3lhRmhSN2t1?=
 =?utf-8?B?MU9GTHZBUFdNU1RMOFpBZC8vMi9IaERKWTBSb0VxcmQ5YzZLR2g4MU9KSFcz?=
 =?utf-8?B?dFhDVTRXNkZqc1Bjeld0dVcrWk1LSnhhL3hORzczN1U1eGkwUDRqeDI3c3Ri?=
 =?utf-8?B?TTRJa1lXQVErdkt4L2s1dmUrRHFwWmdKNExROHN3T3dUSkhLVUl6MTEzbkVr?=
 =?utf-8?B?OVlGcXFKbUQzYzFKMDhOT0FJTm1PdGVGRXU2TGUzcyttTmI5WVZnbG90U2VH?=
 =?utf-8?B?RjVPVW1PRXdlSkZLaEVvaVJOejBzQkQxd0NacXRBKzNwYng3cVJxNUFPN0tj?=
 =?utf-8?B?M2llMHV5TVhXcnhFNFRjaGhQNWxvVkhvc2g1SU5vTlV4Z3JPZjFtazY3MHdx?=
 =?utf-8?B?dlk2MkNvN1o5MWpQMCt4VmdwUkN3dXcyWlpsSFpTWm56dTk3RWhpTHpwcEcv?=
 =?utf-8?B?eDN4U0xkUGdkN0pnWnJ2byt4U2FmRFRsRHRZaFpVZ0dXZ1ovYnFsR1gzcE9q?=
 =?utf-8?B?VnlKRWZMKzlndlpteEdGYUJTYVZYclJMblBSMitLU2hnM2dpbUl4dGVES1Vj?=
 =?utf-8?B?ZUNpN3dJcm55R1A5SkhhWkc2M252Y2JPK0hzOWQraFhJMlJLL05pcDlNRzZt?=
 =?utf-8?B?OWt6Rytld2pPRlQ2c0ZuQVFiWXZuYkVTOWJiNHF6M2xtM3hKVjhUbVMyWW9j?=
 =?utf-8?B?ZmZVMFBlRUdydTlJZEVJVGg0QXMxck1RaGhTMEdYdU9Objl4TnBSOW9qZnE1?=
 =?utf-8?B?djU1UHNvVlhDZHcreXdJTDFTa1BBRDk3SDBUY3kvK3BVRWhreHlsLzcrT2JC?=
 =?utf-8?B?a2tYTGRVeHhKSy85RElxRHowOEQ3WnJrSUJGek5mcTVmalRXMEpEZ1FvNWtF?=
 =?utf-8?B?YmFyZnNXQjlOblROWDhMQWZ3SWhVTVpSSS9uMnIwbEFYNHd2T2gyM2JMbmkr?=
 =?utf-8?B?eVhnZUhId01EWFV1aWF5UDR4c0kvLy9tRldBaTFyUXUxeXNZeTA5QU9PejRv?=
 =?utf-8?B?bWFROVo0QlJoeUo1VmFqUHhpaEFMZHEwbzNOOVY0Nm9tdWc4Zmd0Wk95Snpi?=
 =?utf-8?B?bUpxSGlaQkI2RnlsRkdUSXQxb25BSXBFb1g4b1BIcTNZdHJNOUpDVG0xczhY?=
 =?utf-8?B?dG5FRi9lWExnYmc2VmpKaEk1NE8wTUVIbFF1V3BoU2IyQWlLT25yQkJ6d204?=
 =?utf-8?B?STNjOXBsZSsyb1U5TG5YZDREK29XU1BiR1lFVmpaUUt4bk9ObE5nMVM0QUtn?=
 =?utf-8?B?U3BMbzl0bVQvOEtoT0JDMUszL0w3Yk9kTjVFKys0U2E5VG1mT1RZbHFZbUEy?=
 =?utf-8?B?VUlZR0UyMW91ZFZJakswNzdCOGkwN082OXVMLy8zOGE5dllnYU1DOHdXSW1X?=
 =?utf-8?B?NThtN0dVUmlQZEw0MnV1QzliU21YV0dSVGZVV2x0dzhHd3EwcnJ3WCtaNXRa?=
 =?utf-8?B?TmNmbUpoVnh4bmhqbzBiOE5UeUlwclUwWlFLWDlRNGtpbnd3TVh5aXpBeUJs?=
 =?utf-8?B?WmhXUFRBNEpFQnNLY3k0eTc4R0wrMmdudEZtTkNWNmJCVThsMmt2MHl1bzQ2?=
 =?utf-8?B?dGhJQWI5dEhGNDd4cFhzUFVFUTNYTHpVZ0poZU5SQmtid1cydmxCR2o3WUlk?=
 =?utf-8?B?REJsSHQ3VFdobkM5RTJhYXBzUVZqTHFkUFloNEU4RTVxZGMrb1BHRmNHQ0M4?=
 =?utf-8?B?VU1oR0p4OEMwZUpjUkUwdzNxNms4OHlZQTJqdzhiUVUrbytPcERQTG1VMzZL?=
 =?utf-8?B?NXhvaWhNRDZqZXExRjNRTGtiTWMyZnE4TGhuZ0JjdWhxYXBDSng4SG9QUHBT?=
 =?utf-8?B?d3E1MitwbnFwZ2ppTkczM1BPdlgxLzhNVTU0S1lwRy9jQWR3T1lnQnFVTHJO?=
 =?utf-8?B?WlRjN1Bzei9yWjdURjRMQ2QxM3N5RlU2SjBGNGI5bHVrazRCMTdNd0kxdENm?=
 =?utf-8?B?UmtBRTZvTVErZVdGN1YrUFYwWC95bTZwVFdFWWRybURKVnZ2VnhqNGdkNncz?=
 =?utf-8?B?MFcxU2d6ekRKWk8wa2JzWHhOeUtLUXA2VllDRjl2TWErczVVcm1YaDlLdVFJ?=
 =?utf-8?B?QWw2MGVLZVhneWRyNFJkOXpNRFd6cXpLMm1UWGQ0dHIxUEZ2MVhZQkV0ZVh2?=
 =?utf-8?B?a1dzVzQrQ0FjQ2doWVQ1cCtBSHJKc0Urd2dMcDcvSTN3cmthQ3V4dz09?=
X-Exchange-RoutingPolicyChecked: Pk4roM1hzuWnlcDpYK4ViwI0CvI0jLO/Flb3WLwd8DPvYHX1BIOP5ThtWVshcXKgTlKH7FL725W5g4R16JEsFTJUZo5DEEhUSQmhJX6VQb9784JKK1JW4iJvrtApmTKkES4b26JY5sj+t8fJ2i9qfPuKDiSEuVZHw0zoxMhvbyLRdebWattqgdaXbvKbpISwTAx74yVLM7pe6WcAmn9/GnNbo/UYQVRX4s74ho3s74LFDN1UQe0CV3EOs67eRLbM7cdozumgyhRilrrBQWfMPt0pZXqRLHmciZhUXeMSrHgeJul0iIDxbZ8q/ku6JPWah+C4EwBNOGF6XZLyhXs9jQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a4dfce-c3a0-4173-a066-08df300b8f81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:10:32.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSGe0XEANCQqSBvZixP1ZD1TtvnSJWGbMZvqYJTHd6G2FytwE6jopFPJFPXT4U3z8rfXVpZg1LCGywcl/4r4J3cfxwoviJKUXlFgpJb2W50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4617
X-OriginatorOrg: intel.com

On 9/26/2026 10:05 AM, Simon Horman wrote:
> On Sat, Sep 26, 2026 at 12:28:23AM +0200, Grzegorz Nitka wrote:
>> From: Maciek Machnikowski <maciej.machnikowski@intel.com>
>>
>> ice_start_phy_timer_eth56g() programmed the PHY increment value and
>> performed the PHY-to-PHC phase synchronization in two separate PTP
>> semaphore critical sections, and touched the shared source command
>> register (GLTSYN_CMD via ice_ptp_src_cmd()) and read the source incval
>> before acquiring the semaphore at all.
>>
>> Because GLTSYN_CMD is a single global register latched for the source
>> timer and all PHY ports by GLTSYN_CMD_SYNC, a concurrent adjtime (small
>> offset, <= S32_MAX) or adjfine could clobber the source command between
>> the incval-init and the phase-sync steps. In the worst case the source
>> timer command written by ice_ptp_adj_clock() (ICE_PTP_ADJ_TIME) was
>> overwritten by the unlocked ICE_PTP_NOP from ice_start_phy_timer_eth56g(),
>> so the adjustment was applied to the PHY ports but not to the PHC. This
>> left the E825 PHY clock permanently offset from the PHC, showing up as an
>> intermittent clock drift.
>>
>> Hold the PTP semaphore across the entire start sequence: acquire it
>> before the first shared-register access (ice_ptp_src_cmd()), keep it held
>> through the incval read, PHY incval init, and the phase synchronization,
>> then release it once. Since the hardware semaphore is not recursive, split
>> the phase-sync helper into ice_sync_phy_timer_eth56g_unlocked(), which
>> assumes the caller already holds the lock, and call it directly from
>> ice_start_phy_timer_eth56g(). The locking wrapper is removed as it no
>> longer has any callers.
>>
>> Fixes: 781ff8f2d575 ("ice: ptp: serialize E825 PHY timer start with PTP lock")
>> Signed-off-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
>> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>> Suggested-by: Marc Neustadter <marc.neustadter@intel.com>
>> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>> Reviewed-by: Milena Olech <milena.olech@intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
>> ---
>>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 48 +++++++++------------
>>  1 file changed, 21 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 20bd1813650f..d3e4aeb7e496 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> @@ -2045,7 +2045,7 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
>>  }
>>  
>>  /**
>> - * ice_sync_phy_timer_eth56g - Synchronize the PHY timer with PHC timer
>> + * ice_sync_phy_timer_eth56g_unlocked - Synchronize the PHY timer with PHC timer
> 
> nit: I'm not entirely sure renaming the function is warranted.
>      But it's your call.
> 

I agree, renaming this is unnecessary, and I think slightly confusing as
usually "unlocked" should mean "this will take the lock" while "_locked"
means "the caller is already locked.

>>   * @hw: pointer to the HW struct
>>   * @port: the PHY port to synchronize
>>   *
> 
> ...

