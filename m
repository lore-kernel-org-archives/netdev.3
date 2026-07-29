Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E33FBB5E;
	Wed, 29 Jul 2026 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785368292; cv=fail; b=Ch4qtgas8vCfPj14/kt5pmYEtxdlOJ8Euelpg65qQ/Ub9OJWXj8yxAYXnDUwtJrSIA3dPwwAtST4WZRFzS8oEx346T2FNZMhMNba7342Z/tCGSKvm2gUmkcLYnTnbi87mLEAgBrN6/MxgDOwnHYMGRRPbOjQiCpkIrrSYoohwuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785368292; c=relaxed/simple;
	bh=SGr3Splk/DNdIH+orwnMZpoMB1+fJH8M+F/0/HFFusU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LY+5fuNfdiKIiAuTyKQBC3ovpuv61lj5+A6LWWrJ3ee3End1ASU3UNQ9Nz2t1CZg+jHAyaTnCFOWChvl54QASDs1iuQ9Hef8CQtAIfQa2jfLG6p/Q1vFyoM08T2iwsxTFHHSe1i7wNrYLXu3pYVBnvdOFA+Em0VoSDlKvTu4JYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKbmZq2R; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKbmZq2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785368291; x=1816904291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SGr3Splk/DNdIH+orwnMZpoMB1+fJH8M+F/0/HFFusU=;
  b=ZKbmZq2Rj0dItEbOgWdVEcdY8ABuW08gysovH6rcukUIr3GJnIR770k7
   abAbNQ7Fqk6akB3hHW0BA5IFIYRYhxjaNltlwnsvVIJ5BvhMzv6ieFOKS
   80gNgNVupS7mg35OGpRxXh0WVNDbgy+E5BRvXoMt9r6K2HHh8OqHZMbdA
   g3VzTFNAa4Lq+GK6xjMwSvjaWUgl0Ac4K9Zxob8U9uwzd6dTawWCueP3Q
   kRLIAVcr6cZe4O+zBLgmchiAxli9JLBs6hdpEkpR8+w7LRX/PaTIk9UFh
   mAruVvywvm/b5L/+novnBhwWAWs9zlKlsSx54jbR7scRBiapRo4VFOifG
   w==;
X-CSE-ConnectionGUID: QAiZj+P1QiKYOeva+Yqsng==
X-CSE-MsgGUID: mieD7om0Qgu1F6zaVx4YWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103388450"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103388450"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 16:38:10 -0700
X-CSE-ConnectionGUID: um9MxaONQ8Gbar7VbkGIfA==
X-CSE-MsgGUID: tfl+7nJ6SOq+zTCq+g7+fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="257470782"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 16:38:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 16:38:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 16:38:09 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 16:38:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH8C2CpEC/VVy/Wq13x+YXB2GcLmcXwAAbvxd6gXjmHMbHn084ag+cFcTrumP5eMe6logH6pblOQI8CUWCzF2IS1CZEb68Pa3vUtobDsEma9RfTbiFlDMCCSYUeGNlp44slG9KCdLnPZOcCY0wJEDNrBOgW5fj3CoXeMo6RdsY04sbLFy70PREKnC8rSRoqRweE9wbg/yFIK7/7c5OXv1BRZvSbahd6rNA+voRP8YjpZnDFTyf0Ey9AB0S8b06Gy5ZySrrRa4rrAoLvI6NXPdG45/QCI/eUoP6dxq+iNVPVSBV/EjursaGnU1wp05ADEAfUADF1lblq/bDFFMGrugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1RjM9PtwN3ILbWSEKH5FnSrauoq6trim9IgvXXBWfM=;
 b=jfT0tqMmtIri2cS7CazZ8wq58Ugf9sjPMgswzFlRiJPuVLkkb5qnxZyGjF18ilon45NRxkABotxLv0DVZPBalaVC+Y4AxSsuMDay7Ixsszq7c8wMYRQjkjzteOU1iKLtuSXADry4QF0yDRiyvonTyCZLHSl2Um5vA1590IN6AS5xYFZXNxjEI/QNnxWSWmHPr5UDQzd5uq1SzsNuAVluZpztKMZhJYfckNBOrASYAF2zZOnNk2Jj6Qd0YoVvNxRaNJePTGqGGHlsGGzmkPp3Lj5e+HsHLKOFStY2SxYudYjkZvd2H+3sCIReC2+GWGkV2/tT5QvMfU/uUweZ5c1xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 23:38:06 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 23:38:06 +0000
Message-ID: <ca7c26d7-17f1-4967-bd1a-71572f0ee4be@intel.com>
Date: Wed, 29 Jul 2026 16:38:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qlcnic: move notifier error cleanup under CONFIG_INET
To: Can Peng <pengcan@kylinos.cn>, <manishc@marvell.com>,
	<rahulv@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260728032046.121631-1-pengcan@kylinos.cn>
 <20260728032046.121631-3-pengcan@kylinos.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260728032046.121631-3-pengcan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::19) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ0PR11MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3dfe0c-818d-4e3d-a00f-08deedca708c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: oWhAPwr0T84UpkL55S9ZCEorUdLH7CMhr3bVVt4hyM2DZOtGLIMRqRq8xnhFGCcXp16pYO9cmI+fTkQ2zlWN+ApBNtApDCRkd2GH3H0zGZuWe+krJOJMFKX+3c8t5gEGSCTNDXAiHTD2WET9cPriPerLo+nhIteKJvLicdmv2OcrJcPoXjMBiHLZ/z7opXYe8MlG3LwSr+63YPStaLHPlvWh5h9ZuCgKgiFEg7wzZ0yyjgYEvcfV8DTSO0744CK114XpBktcSTdoo4icq0aPnN5rvOhItM6zwObtHNqH8w6ze7iHjhbjOQvfCE7Y6HHFqzsQP7QhX64BifCIzrwqwTumriZ0D5snB4yWwnCmr/6GKnLdGLjIi03d0e/fwqVAIi1r3cGX0h7+l/6AUohG8b7HsddMue40CnYHAajWvsm6gq2sLx5WB2+VaiJ02TYvsTKss51rFx9GxfR9ENakKGQjITbPUEKMp7FLIakLUgSpkK6HsVPRfmELkYKIXo9SbHzspH/u+OLT5OsDOmE2cSiu2WC9KFHOPB43ZVh9YmSDIXWUWyXSidDEXFKQALJHWguLy3Ymkn8+ZGF2U9nY09KrauichILt68Qz7Ehv149w4vQEXc568e2FX5+LFGfEjn4aaYlmO466RFMqDdbsNEWfTiKHE7QhLUYoNwrFQgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndCZ3p1Q2JVUHZMTnJMc2svWmNLTFdYQi93V1R2SHZGNEVQZ05ON1BkTDFP?=
 =?utf-8?B?QWZnWUFJaUVyUlZoVUFMK3JHcjg1RzdiREVWeXhCczZJcTFNdzk2VWZqNFh6?=
 =?utf-8?B?dHlTNmZzaVRJK1hFaUw0Y1NuWitoclhZUVpLckpwRUYrSno0eDBHRmJrSEdR?=
 =?utf-8?B?TVF5QnNocHNiS29xQ0ZpTXp3SldvODRYZnFPbE9idnk0NlhtUkc4Y3QvYWJ0?=
 =?utf-8?B?OHozUFBSQlZSUXRqeGJpWnpDTWtGRXZncWFSYW1kK0s1ZkNBVUdKSUg5dkhD?=
 =?utf-8?B?L0kzK1EzTWhpQ1c3bEZMQkdlTlcra2FpU3pJSXBKekVlMVB4bXFBcHJkazRV?=
 =?utf-8?B?QlhXd3UybE1BQlh6bDlQNHJvMjBLYUppd3E2NHFqamorWnluMGJUSUFhR0FI?=
 =?utf-8?B?YzIvWEU5SWhHaUZrelFxMUxHNTJEcmdJbHpLYzJqTTdjdHpmWVpsYVFxUkxa?=
 =?utf-8?B?UUZMLy9iVDFaYkR3VEthSFJJaGpFRUdtMkh5UHJrbzJpdlVtNmNkUEJuM1Rp?=
 =?utf-8?B?cFdmRU1saitjVkFEN2hUNjd1Z0FtVmFaWnJyRTNXRzQ2bFN5STZlUkhXY3d2?=
 =?utf-8?B?MjB1dHVpdC82TnV6RHNNV2ROM2xCZDY3TWMrVG9LcVFhckhhZ2FzRHQxNTZQ?=
 =?utf-8?B?dEFxZEhadFdoM0lXNUFZaFdXN0hzbzBOZUtHam9LV29FUVYzLzZwd2I5YlVq?=
 =?utf-8?B?NEdPUm1waWJvcXJIc01lOE9SK09CZXdUVzhsTXE5ZjNQY3RtN20zNklSdmcw?=
 =?utf-8?B?NDhFNFpBOU9ZWFBVVWRKT1FSZk9GSmY0cHdsL29VM0RtemtVdVlJWUlOWGIy?=
 =?utf-8?B?bENSVGZZVTNtWlNsVllya29UazVxTm5uWGlnZ1BUVDdzRGRUZHhlTkdMM1R2?=
 =?utf-8?B?RHNLNDhsbllVbElBdmtHZ2VUK0tqVmdxY1U0R0VlREtoalVVaHR6dGV1WkJp?=
 =?utf-8?B?dW1qZ1czQzN6TnhhZUdDK1FickpzbDd2dXlXaC8wOUk2YVl0U3NvTm42QlFB?=
 =?utf-8?B?ZTZldWswQ3RSRFp6aW40ZUJxWDZTVkVoOVNMMzRKWUNML2pjV2VUZkkxd0Yw?=
 =?utf-8?B?VUcvdDlMaEhyY1NicVJCeU9MdEFTSW9QSjlKVlVuSXU2UW80SVJCbE5qcVNP?=
 =?utf-8?B?UXBCNFp3UzEvM2U1MlA5ZzNPRVpQK2RsRisydjcwaE1ZdDRTcUsyaUpvMktL?=
 =?utf-8?B?NzhiZk1Tb3kvZzUwaEJkK2pTZk81OTE1RXV0aHVuT29ZOS9HTVlJbHpkUTBy?=
 =?utf-8?B?MEMvRnZ5aHFrQVFscFRuak9BNEF0ejVDYWUvR0tqUkw0SWdLTldvbko3UDNa?=
 =?utf-8?B?RGtxTVpkMXg0aURaamlFM0Z2cmxPM21XbzJhK3M4VHJlSzZSU0U4NzE2d3JU?=
 =?utf-8?B?QkxhMGVMblpaL1pSUTJvYVkyVXJ4bTI0dzRnZnd3YU40SHhWVm1ad0pCUFBD?=
 =?utf-8?B?Tm1uN3JBbkZoT2JMZGxQa29HR25HU2NpZzJ6dlBqNnYvRytidFE5dThsV0Yx?=
 =?utf-8?B?eW5Sb1F4bk9kaFNnRWZTM3BUSXhpelVydVJtYStkcEtabm5Tc0ZwSWdOajY4?=
 =?utf-8?B?b29BbCtLR2Q1MFoySk4wbzRlL1k4U3FOSUp0aEdlL1JTQkk4bDR5Qm04eWVP?=
 =?utf-8?B?RFRHWmdKcFlYS1FRVTlWSWJVNE50eEJ5dEROdkszazVLT1N2anB3b1VPTTZm?=
 =?utf-8?B?RjRlTW5samhVU0J4ZVFQM1E2LzJiT1JpYmNsYXNoamViVWJMQ3NGZTMvWlFO?=
 =?utf-8?B?WEhMQTZqL3ZIQ2l6N0NFY3ZBeDdLMjJqTWE5OVIzV2xHNU9NRU9qc1djMzNk?=
 =?utf-8?B?RTNBclF6WFlaUGFwdk1XRE1TVVJxcmVNU3E3Skx1TmpLSjhHNnFFWDZycUZN?=
 =?utf-8?B?U2VZZmlPRFY3RVV3N3pNcU9GQld5cERkK1dRejVjM042M1FPSVJZdEhmYU5M?=
 =?utf-8?B?UjZRWWVqK2M2eXI4RG5vdkp1ZzhyR2xJNUo4UUU1WHJpWi9OcmxncWFmQjNE?=
 =?utf-8?B?ZVFMcXhRMGM4dnBVTTFHck9tWSt1bjlqWExqSktBdk1sN0gvZFJxV1hWU0N2?=
 =?utf-8?B?bHpCNFVZMmlDZWU5elVmUktVRlpVL3FWc2IyV2YvUSs2Mkh6KzVQNkgveDBO?=
 =?utf-8?B?cmdkZElLWGR0OXlrYnRQNWZYUjZlQkJobXBtQmlFek94UW83Y1BNTmU1OSt3?=
 =?utf-8?B?L1JHV1MvTFlCcHhEdVNhVUVFYXdSKzZ3Q0pIbXBsZFhncXozd3pEN3lmYnVD?=
 =?utf-8?B?T1pkYi9KeStxZ1ljckhQdlFzejV3cWU4T2t2VFFpRjZPOE9QSUF6M0pwb1JE?=
 =?utf-8?B?aUpIQmxKZ3M3a20waUovalY2ekx5MDFzdGtja3ZmSlZOd2NFVWFwT1NLcVVp?=
 =?utf-8?Q?NP7Lvy8eaNlH3EqI=3D?=
X-Exchange-RoutingPolicyChecked: PsplRMvyK90fTPdDSSa1Rim1uCxbqmjlozI67yQuGdXyeJS3aNzQbapxQAQx1yuTEo0XTtC++WW8SKcJggE5u3kw34ZPBQJnT98N3LC6UDKooiC0/eOmaVGDAA8pExfQ/FOYQMozT85nByyCMcIfNpLPOxlfXg48XQxPS7HcNLrczSajpSuKq9xvmjA9ErdR/7cwC5zRW80WbsnaZVMeuM4dgashScHSyJZGL81PY5O0TNCGHAC7iBg3dKR1AORMxqxSpCord/x/f5VYaas4VvWmjIeEdBrZxmOul1b5AF02+bZQlaxj6hc5DbPPp6lqy+2dtr9jnHEM4YFAK/h4rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3dfe0c-818d-4e3d-a00f-08deedca708c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 23:38:06.2773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxKjZJOynIyj4Jzctg5XxeFc540UaX5bLsgUI/1DqzAPSJxLb44UX1bQ6Tnf5v8iQuCoyUKm20GCFOvDtKGd8iILDkh7Xr9fGaAuhwHArUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5037
X-OriginatorOrg: intel.com

On 7/27/2026 8:20 PM, Can Peng wrote:
> qlcnic_init_module() registers the netdevice and inetaddr notifiers only
> when CONFIG_INET is enabled, but the pci_register_driver() error handling
> block is outside that guard.
> 
> Move the error check under CONFIG_INET together with the cleanup it
> protects. This avoids an empty if statement when CONFIG_INET is disabled
> and keeps the cleanup code structured like the guarded registration path.
> 
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> index ff4f7cd20c79..46d07faa24fd 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
> @@ -4221,12 +4221,12 @@ static int __init qlcnic_init_module(void)
>  #endif
>  
>  	ret = pci_register_driver(&qlcnic_driver);
> -	if (ret) {
>  #ifdef CONFIG_INET
> +	if (ret) {
>  		unregister_inetaddr_notifier(&qlcnic_inetaddr_cb);
>  		unregister_netdevice_notifier(&qlcnic_netdev_cb);
> -#endif
>  	}
> +#endif
>  
>  	return ret;
>  }

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
