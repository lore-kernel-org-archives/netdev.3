Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81164C9DF6
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769266; cv=fail; b=Na/ut0yT2dajtn6UUUqBEhnbmfzYD6WXPgctaIWki+v1dIxev2cWLB7UKrIlNGjTw0ezmnognYVavwpMFa7D4tSTgH6ew9zHp3+dtRWpAV9Pd/eK4PKrP5fTmsfx3e15cii1rG4ea1aQvajh4V3M2aiBLmMZe9r8/TyyHvwnBG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769266; c=relaxed/simple;
	bh=kocjY+eWYz1R7bwkxRAM62erOcDXML4SpXwm/UVbYIo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbvqbrVRSogZW4ik6Ked50lM6waMecdcDmJUrXwIMsQkzeF/l7AmsvkmkW/tENHYj/H3RC/wGAYlEAOQBijFmNKVWS96HfFhqVwBr2d+ayMFUBuwtuW68JK6nt5Qm18n/1PMgDIxocoA5NcCMWP2p84PGTXe2xwn3ZEj7acy+9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDIrTAF2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDIrTAF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790769264; x=1822305264;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kocjY+eWYz1R7bwkxRAM62erOcDXML4SpXwm/UVbYIo=;
  b=hDIrTAF24A2M8ASAhlr0P7jKRdBrqHUQ82BKGccyD5zItT9t4cpQgL0u
   sys0wj/Iz3ml8SudeLf4X6qx7mtvVcJpLtIL6JEa1wUNWxIFok+PFHVkP
   X1upCG1GpGs6g5ek9iiPz4vBkAsC5t60CF1P682Hv7nrBQ7Xge7IX3NBA
   4e4YuzQ3rTcL2t/m7X21rqzC7F5MD92NGP5WJrOxnYS5IrySzSVwnkfXy
   JMcGtinlAAU1ghv8b9nfkrdxtFeypeBuxVjPS5XgRuVcXNg8vgFqTsTCG
   6frqxdfF07rhiVTMuzNsczETffrXrD2LYNZRPcfkCakR5abGWvnwNK5uQ
   g==;
X-CSE-ConnectionGUID: 85f8rRF0SeON91QSgDQ4lw==
X-CSE-MsgGUID: QU+mjw1xTTqDO0+/xgYYZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90364259"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90364259"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:54:23 -0700
X-CSE-ConnectionGUID: xZ8rhfB7RfOahEqNIgaIGA==
X-CSE-MsgGUID: ysJOvyrDQs+56DgyiWVSKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="279469186"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:54:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:54:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 04:54:22 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 04:54:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ziv9GDmiBdq0CxMoFmP8sf4eMRzhCw5Z3TQ48sFeuIhJ7B361KP0XDd0DVGzhyhHfK+K2qV7kKzx0Fx3Rql1q0iyd2iRL29id1/J8L0a7ROnovZaiCR7uUq1ZeLux5oiI3ZE6xu3pd2OFFvnvplM/UEbFMID4OAyx7R1ZXz+uIEBPVnbQ7cw5RUgB4Zj1/vcNQPPZIb63vehSw+dvblKkPl7OuY+oPzpF6VleGHdk1yeRrlBytVwbfYtpUTXh4632yZ67C1tMbaWZOLtRNIPKynwKuN+45Ds8vxBYKEtzrDNXO/C8WeZAZEhi/X34ZhdGfidJBs58FsQv2ps0ql8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X84OJ+g6HDkkxyrVR4hlt6L9zLmtreqthGdsOu8WK0I=;
 b=f45i6txpIidcZ+oAe4xU73VDzyt6qhBGFkSqFaE0vKtkNN5RUElPWLu9GVhJYcRxXP9IBo8PioW7pGC3BZf3lrGCPhCQA1LBykXCMGV7dJwfSKmQs+VUmn7HPiIhsBg9CFEVjTksgeIpNoXDfSN1HLBM27RJl9CKA7pslU2UIQr7I6vnhELCgoRplWdo4byMsmPEDV5FBg9kt6Z0NmZtjxQsxC5zrICIhOCY/qzMV7tGNuva2PP5AJfiHa/IdqUneMGUCMGGhPBMBCYRaV423C6RNxcRK3HhxOvdmk2n4SbcVOrN1hcL8lEdD79+MIChzNs0BZ+ooGvD9B0SsRyd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:54:14 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 11:54:14 +0000
Message-ID: <c17b59b6-37a7-4f91-95f6-fbb3ea91ebe0@intel.com>
Date: Wed, 30 Sep 2026 13:54:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<aleksandr.loktionov@intel.com>, <mschmidt@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <edumazet@google.com>,
	<horms@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
References: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
 <179069064842.434549.3321384376885392964@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <179069064842.434549.3321384376885392964@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0002.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::33) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4446f5-6afb-4e2c-7c04-08df1ee98c89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V385Rbrxk32MmmL6w7c+l77ZTXi9rB6P6ADRbmC+PV3qn01XnmsUkzJ3ZFvjhpKU/02h7C6Ikf0Cyg1GNd+25TZozUNeg8jBo6f7tk/fB6PXBy0aXusVy/45aZLvxY/M/LTtO2issH/H6oJ4Vl/OCvZZnidZAWPKfyMpiXbP4F8WacX4LxDQJIeP4q1ql4ZbzY1lJEa+bsx8oLTWf36baxbVo5qVpptRGjo+5QevUzB6+bEkYkoc8qEPjzEEYZdv5+d9ZnNsLK+SFx9pVuY7GU9ORVRsYVjaCLGvChGAFhOeGB3IkPZjDSkvoskm+sNKxYnqqZ/ZvAE4sPbK56yzxUKjvLiaS/2GbhE0n53eopfISjenOqUZfVOOMliTvcmkVB1n4s4usArHWGAQXEl2VIOEWppvrC2OQbqV96c48zmpgi3gLNchoAPsiynkLVSl5chNcq5mg3BTe15HTR/IXIPN+DmDEQtRACXLKG38+ihKcdpj4eSnyC4osNiRpzjC5oqEOdxuNq19bnaZN9X3UaZWQp5Uf05kchc6iCjEzQB7SaKLiEGF/z60oxZoZ2//DarPzLJIEOOPFiTM6CRWRhwR45mtd8CebhzX15JqjoecrDFLkm8+JbjK4zyGJX/W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVB2THg2TVNaMmVNTWozRkEzODhDV3hZdGFkVEVkZ3pSSnVEc1BSUW4rLzdW?=
 =?utf-8?B?SWxucEVZMWlQZW5YSm5oelhSSTA0ZHVwTjE1aXl0cE00enJ4OHdRdzh5ZHpI?=
 =?utf-8?B?V0U4b3djV1hVNkc3azVwT2M4cUxUUXNQd3dqeDZaVmdkSzJwZXU3WnNkUVhC?=
 =?utf-8?B?MWhtdWhkamFXbGovRmhYQmxPcnhWOS9vcDR0U0Rkb3RSeVZqK1Z3SHQ3dU0z?=
 =?utf-8?B?c2JMSEdLZmQzYkMzN1ZEdG1qSlBxSE1UeXA5R3llWGJzWmhWaDV4SVJ4MnRF?=
 =?utf-8?B?NmcwL0MwZWJtTmthSUFrNmJadXZYMlVPVktvR1BiMmxrRnVPZGhvRHdlbWpW?=
 =?utf-8?B?U2prUFZyMUNFVkRVK0VGK001aFhxQ2ZyOFpqajVDWXI2N252WExVU3k0cTJj?=
 =?utf-8?B?bVlqdmJuNndxdCtSb3FOUTA3aE9DcFFVWWxaZE9GSXdUUi9nL2l6czluWk9m?=
 =?utf-8?B?eGtUcHRLZ05EQnN6VVVSYUJ3YkwrQ3ByLzAxZERQQUppVXZrMTF5T2xNMUNr?=
 =?utf-8?B?Z3JSUU5hbGpaS0pWYlFpVHB2MEcxK2ZQT2w4YTZkUVlQNndObjVSVitRVDQv?=
 =?utf-8?B?Um1oZXFIbTR2L3hIVi9jbVkwWmg1ajlESVZuMUgwZmRSendpL2FOTUxXRnpT?=
 =?utf-8?B?QzNtRlJhcklrTkNQQW9BTVN1V0xHbDZ1b2JyenVFYTlSeUlYWUxBaGZUV1Jl?=
 =?utf-8?B?TlEyQjZWYW9DV1FENW13dWpCZ1pqcE9NR1RvbE9PMWtUMkRteE9HZVdteVhw?=
 =?utf-8?B?TmkxUzVORnhpM054NXBiQ3ZHWUVWbHRJeUNBcUk3M05lWmp5Zy9USmJHbldq?=
 =?utf-8?B?VUlGY2NpYjNlMjNIL21nb3lMNzFCMC9scnlkMUtIeTVxdithenJzckRxNitk?=
 =?utf-8?B?OXZCbFZuaUpTYjl2T0J0MUw3SytQa0tqZHZLbVRBT1JXQXJHSmhvckk1MkFr?=
 =?utf-8?B?UFJiYitTVi9RVWlEVENRdmhNejZFZWN4a2tqVG9RbGdyUUhaWk40K2pKNVh5?=
 =?utf-8?B?bTZ3RlpBcXplSlRibnBMeFk5UXBJSkJ6SEJtV3ZLcnoyeG5HN0RvMU15NG1m?=
 =?utf-8?B?UUt5M1llSkxLc3ZkVURqSnNkQ0FiMk5idmdoVlpDc2ZPRE9uYVlORGp3MjBq?=
 =?utf-8?B?LzR2eTQxMEpvNUJKZCtLZ2MzZVFINW0zMXZ3elBKMWp2eW5JSklIQU1vdXU2?=
 =?utf-8?B?eDlFMTVyMEFwSnZ4SGlGSDdKbCtmLzdUUHQvb2hGdjljaHlaY1BLai8zbUhZ?=
 =?utf-8?B?dU8ydXdBSnZRdUxIazZVYnQxcjNPNFNWTFBLa2hHbmgzU2tCRGtaTUlRdXht?=
 =?utf-8?B?byt6UDE0bENqbGhiQzJBamtwMWl1NU9UK2lWTDNIcGlUakdZWlhpbEoyN3J3?=
 =?utf-8?B?QzB3bEVYRW5JTjNwelAyUlRBdVJCeDRZL3V4MXlNNFhjRUwwYnIrbDY4YjhB?=
 =?utf-8?B?cEZOVFBIRWc1enozSk9CNEkyWk5SR0lSSERObEVyVm4wVXRCWExsVkV6Q1Np?=
 =?utf-8?B?L1VqaDdPSDE1c3pBR2owS2lTMTRzMEY5MUJsakhCOEJzaDFscTgxRWI3eWFh?=
 =?utf-8?B?a1BqUGc3VXJnaUkwajhQUUM2dmxVWmFsRnordE9KTGhpLzlReXkrRFQ3Qk1a?=
 =?utf-8?B?aE1kbm5VMEtLekh4Mk1GTWpIZlBmOTlzUStlTHFVT3JPOFVjalRTeFV3azlX?=
 =?utf-8?B?SUVSeXN6cEw4TkorUHdxZlVaNE41VVFCS09VVHBOZExWTG1GdGlOaVNHZFBu?=
 =?utf-8?B?cFNKdVE1b0JtUlYvRFFoaW5iRG93VnpveTU4SGtHK2NBNjB6VUE5STRWUFNV?=
 =?utf-8?B?VE5GbFpBdy9kajVJR3RzM1RTNkMva1VMdndqQWluQlpDNXhYS1V3NEY2U1JD?=
 =?utf-8?B?NEJLOXpDM2M5d1VDajkwUnZaTW9QcUdWL05RdndGeGVxemVuWUFMK0syemZU?=
 =?utf-8?B?TmZFMUlzU0xTeitiNlVQSWtiVXQyUHB3Zk5NTENPY0N4TFRvWVZFemNWZVFp?=
 =?utf-8?B?M2ltVW9LN2RrN0ZmTFZsTjc0UUhNK0pHcGoxdEVaN1NRM0NmdVdFVGdmcDlh?=
 =?utf-8?B?R3BFV1R6eHFONUNRN01FWDduZEJ2TWwyOUhtUUdvSExIWVcxelNLRlVUTWxY?=
 =?utf-8?B?L2xFdlZPdmFTZEF2TExHNFFwNDB4bHZJaExsazJwMVpmTk1hTm9rcnl0YjRk?=
 =?utf-8?B?Z2VsYnhwRjNuQzIzL2kwdGNUS05RaG1qeHBZbWgzWkNUYjZXRFVhMzZYdmFh?=
 =?utf-8?B?bmtVeTNxcTM2R0pQL1dxVUVyZ2hwWk1LeDJoVStVRGtOUER6djlZZXVlMEF5?=
 =?utf-8?B?Zjc0ckZmdmowNG5iR2hmbGNOWmEwMUx1VFZsbS9kMllYS3BsYVU3ekF3d0lh?=
 =?utf-8?Q?83qM8zwSRbVekMNc=3D?=
X-Exchange-RoutingPolicyChecked: wVyMqciyaWlfMWTRHnzHUfhUjAdlK5CAW2WbMikfWL8HxY+OpKoX7bVSf1kYGh0/ePYQw+hubFdrzb+RklGaFPgYS7HZvG/1X6H6R+K/MUFV69lSpp5FSG4KzIiYGHojWcFPHWIKMBPgorDIMYX4QO8UpisKe4oxHqPVaQL6te52c8HAaMRgHoYsTCn2sT6m+I5BiEmbkM2eVUQQ8pwkBFCaBPTGh68CWyt4lxrC1JCdEX2KYTtu4scbvtk0DoMTVxSKRXcbFsMldZ4tukeiWJLO+8+FH+gndORVTga4s0Ru+g6NDyvKfgNX2R6dK6UJGcfO/qYUwJRc6+NL7HjosQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4446f5-6afb-4e2c-7c04-08df1ee98c89
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:54:14.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOkbUmiExZpm1msTsWch0S1Qx+N7VQC+8Pp4eDgJoNh/qJuQvNmh+hf+0MRmGcSaz9nscdmL4J8b96thSPCGOeVhpkPhUTrTWqM2FZ2tSOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
X-OriginatorOrg: intel.com

On 9/29/26 4:04 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.

Summary: Ignore.

> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit message understates what the change does and the patch
>    has no Fixes: tag.

does not matter, it will be pulled as dependency by @stable maintainers

BTW, I have no idea if we should add Fixes tag for "smaller half" of the
fix if it belongs in the same series (and does something a tad better
than before).

If that would be a preference, the fixes tag is the same as for last
patch (with 3 more patches not carrying that exact tag)

> 
> Pre-existing issues:
> - [Critical] Heap out-of-bounds write in ice_vsi_alloc_ring_stats()
>    (drivers/net/ethernet/intel/ice/ice_lib.c).
> - [Medium] The shrink loops in ice_vsi_realloc_stat_arrays()
>    (drivers/net/ethernet/intel/ice/ice_lib.c) still use…
> 

pre-exisiting: for another time, and must compete with other driver
hardening ideas in our backlog

critical one has even a note:
The last patch in the series, "ice: size ring stats arrays from the
final queue count", fixes this

 > Sashiko AI review · 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
