Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EF4A5C28
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928136; cv=fail; b=gFUBo33vqCjmCnQdFtM73ewFGJvtP/BCRqDgSuNppwSV59A+KAy5vjb7SnCKXbG6CPNYGqcO/vGCKjkYaOaksIim5kfkTc6+pSbtjduNYj2qhPiEhT1GvwfocObYgPIwEms1Hb6GZ9/9XaYFH1qNImEJqf9aBcRPLVpUCrwG6vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928136; c=relaxed/simple;
	bh=mIJFBo5gkpDkXtOzvrl+5b2GQJ6qbFMDR8yUdlP2xKg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pNAvP/tIMdVbnkGOzS5BrU5f1aLKFkYfFJVfFD86Ue9PzVM+ILv7M2BhjOSF3QyIqKjH4+rpryRM0oPg6D5ksEomjV+k3a7kxzKXQTL0/e1ywF9qkXMoZwMyQA7aQoLVR/feeSbV4Q0zKTXeY8oQEhj5PiDx3rImq+P9n8Qlbec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuG6t3PU; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuG6t3PU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791928135; x=1823464135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mIJFBo5gkpDkXtOzvrl+5b2GQJ6qbFMDR8yUdlP2xKg=;
  b=iuG6t3PUUjk0WayfHEX6w2zh7BJ01oKcMPd1veeNL6c1zIWQOFSXwS1q
   YseiUzCilU/nGNaEKtvWw9bQzH8q5DTWTeeBr9bOoZGhlY0oJ0nL9kRYv
   uQ42uoQP7Agfqbj4hlKpR+EIFapI4rwtWGH26KHZpBxO+yJtqPy0LO01J
   pZGtxhUH0E/jM3fFXHOTA+N9BlsTCAr+/rQm2GDa6Pzl1bipZe3PbkHpa
   8H2+Z1gwdgi9Hi942QIdcINBmtbqmtz5k+o8sAJ0GeCwIF2mFLU/zczag
   zFsZLnsYJTVET3Vokpl8C0ITzJ3fhfAJgCM8xrfk7PsEpXPQyL+Bl9/3e
   Q==;
X-CSE-ConnectionGUID: loI+RVi7RXitWXTALKWEEA==
X-CSE-MsgGUID: 1ciwYL1ySladnpuzsCzx3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="769961"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="769961"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:41:51 -0700
X-CSE-ConnectionGUID: vF2WetI1TT6bTo/rGKYxEg==
X-CSE-MsgGUID: QaiiGYWgQCGVvmYPXpEoZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1193460"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:41:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:41:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 14:41:50 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWvQ0oKQmgf2oWBHMfX7SOY7HlYtA7y4ZV1ziouzKrnBS+vwPe2RdKODW8p+l3PoL6S98sCX5QCZA9E3gjAE94WyOcLIeoBT69FJAHOb0D1OeVWzCLlBvyN2PbXvA5NJvx2RtM/EPcPAicUHTgIs/oYyKBOV+yUqRNyiCFdK1+Cs3iJAs/Btf8MrveNBEkPegrS9MAe6Ztel5FmML17m/jvbGwzplSNP3mKb2ETSdKLzgkGR2FrfpHX72jsgltIf2JqcF3CUD8tQbpV/atKvi+UozpfzRjEDmyGCcJqmHbn7OWiR2CnrEVB70/v+VkMO+saGwYNyK6f23FYI93xRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8dgkpYnwVwdWX7j96R4fV2Pd5Bk0v4O6vw69H9ttIo=;
 b=Yb1kb59z3m3rv796+5JMnNbQzU35tZYdKH4nJ/xQ1ol4BsaaKmfC7ymZNGejawidk98xfxcPAjylj16WjTam23DT0A4qZ0aAlEWUOFx9gtT3LRLa5B2LyR6XpAZnj0EqsdssyfYKevrKboxQYqWyC2QPdwdy/LKSY3iizUOiHVm3mcP44Ufd5JDsVOd5fhbKw7/IKSd1nAjyOAUXfcRVVuLKh0SXQqGOOPovPLBaMZn3p8OYKuntkYD8VMAVjKRGb9/adF+xKP8DbmpAZD6dNET72lfvpgoal/As8Pktn5bohr1Co5KnkJoH12zSorRPSN4+2G9uaAqh5Qsg4/dMAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 21:41:45 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 21:41:44 +0000
Message-ID: <d116cef5-9c93-4a04-9168-88bc378a5485@intel.com>
Date: Tue, 13 Oct 2026 14:41:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 02/15] ice: use reference counting and SRCU for PTP
 port access
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-3-anthony.l.nguyen@intel.com>
 <179184691959.434549.12801470720231194166@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184691959.434549.12801470720231194166@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 25af7eee-df7a-46f6-d9ab-08df2972c63b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|18002099003|10067099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 8lD3Em34zF01CPCs+G2ywfDf84IJSum/u3ggVTVdR6CKoDyIvNXh0ws6kyIKAGCZ7VOTK2sy0vNoj1lNYBwZmf++FNsxxE7Rnkiha38liEffLRz/W7A292ktLk370WwsHJe03fufSJmOxsDR82DupwlTDiSmaU5R6NA8KMucpDpvKzPumo6kbTJN2pIMYWDbk4MjsMDU7p6CKKC1jq6qC/GyTtmRhDC1HqVAGVPBvVTsXzvy1sewNlHfK8LkLI6aKs0YRuZRBTab6bbNmYixHzxenClaqsrEpEcETtXxy01MoUErqJyVe28TvpSFfD6IwgtKW3rFRcrCGx0QfjrioRI1+ZdsLLZmentRGsrdALftyCD1pKxS57oTZ2DpJH8EivwHB+19cKzQnqvio4hZuayDyY938Z7gVxceMJOPbLlmzo5VOJKNq7ZE/aPpoEWZ6sNVICEEcullajnEHVgvYcGW5ivy87h+5yUUwAtx41dnVOT8IOyieb/FnhavL/THyGLtYgduHU/CTE6ddqUjChLs8C7MDxT+OOhltb20pm3/DKPzFJqTC3tEhHpLBMsxOUbI08bpQe03nW9mCSurUgcVcPOtBgHHG/ubgR3LeAm95QnFUc/5FyrRrt4ZunsxS5t8U+E23r4AsqQMlnGspT0dtZQJp4Cs8RsuusS4FQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnY2VzlhT1FydGNETFVTY2F3N1pvTGhmOVVYaUZGQm1IUzlWK2MxeG81V1pE?=
 =?utf-8?B?YzZZeFF5bGhFMzAyazJsRTFIamZqTW1XSm1QMThlTzhsam1POGwxOURHZXkw?=
 =?utf-8?B?aFh3bkJEWUJRNmRlM1JJbStqeE9ZQWZqYXM4U0tiNWUrN0RyeHFWRmYvRzBS?=
 =?utf-8?B?YW9hcTJWdWMxNzU3Umh4K25oUmo0amdtL1FBalRPRUduelZnTU9SeGY0M3lq?=
 =?utf-8?B?M2dVVW9GZ0RhVVNqOUdSb0RsblBBenFPa3VwaExVb2FHbWQ1T3JVa1pxMnBh?=
 =?utf-8?B?NktUZE4zOVZBU3VyL1Y5YXdoRVpiZjhjRVh4NFg1bkthN2NHOWxpTllhb1VE?=
 =?utf-8?B?WTNSOHQ2UFNmNkEzSE5kWkRvamUvSnNoNFArYTJ1N1RGWER3QW5VTmFBc0Mv?=
 =?utf-8?B?NmdVbmtmMUhVUUhDVmlEZmZJaDVlb29mODVjQk1hOVVMVE9Fb1B0c2FmQkMv?=
 =?utf-8?B?eW9DR2tjQWNScTRlUnhzcnpwTVBDY01Na2hiSUdyZVdLb3l6Vm4xWDFtYlov?=
 =?utf-8?B?Q1gwRUNGSUJDZzBJZWI1cE0vS2NPWEFPYlpRZktHYTBYdFozV0IzajdXRnJ0?=
 =?utf-8?B?MW1yWUZ1T0owNiszTWF3Q3hiL3A4c1VjUUtUSHNybE50K2hJZnZkYU5JT2hM?=
 =?utf-8?B?SW1hUXc3dDJ6aGhZMlptMCtLUURIK2RuWkFyd0xmVGFUZlVtK3BWaEpyVmxo?=
 =?utf-8?B?R28xdmZWakdYL2lmV3J3YWtJbzhFbGRqRi9pdU1aTldlQ1RMdnRwRzdrTEVk?=
 =?utf-8?B?MGxjMlE4eFpwQVZ0YmMrWnZOQTVvNXQ4YXM2N3RqRHl1Y3RpNGtVYUNEUFNN?=
 =?utf-8?B?bUF3SitNMFpKRk1yRzZ4cFg3ZC8zS1VuWVNSNXptdW90WitGYVU0c0VhaGJy?=
 =?utf-8?B?REZuSVJkdERWaC9nMHhWSHF6UWNkWlI3TU5YL1ppUVViWUs3cXRWNlBLVmlV?=
 =?utf-8?B?WEtMa1F1OU1DMHFvZEgyODIrV2hIYTVXUWxEWWw1ZmRSRmlyTU5HUWhMQ08y?=
 =?utf-8?B?SWY1NlN0emlxakVlcEtYTGNnNi9zYkJmQVVhb05ST1VaRUFoamtsUTFpa0lJ?=
 =?utf-8?B?ODhpYmM3MVJYYjc1ZmJ2bG5LcEFQb1RVZlcxTEhmUzdZZVpGZ2RRc1hLd1lu?=
 =?utf-8?B?V0MwUURBY1ByM1VVS3Y1Z3lKUGw5d1VBeVpxaVJwRXZTd1hHWDJwT1NXdlY4?=
 =?utf-8?B?MW1ra3VCbHpGWTNQTE00Ui9jcDJtNWNQb2I3ZDc5c0hKdUExZkZqZ0pQWmNa?=
 =?utf-8?B?Z1VhRE5CenI5cmc1alM1NzZndGx4c2tqaUZ5VXFWS2R4b1BTMFlNTUVVVlZS?=
 =?utf-8?B?WDhRTlN6SWI5MG5hTFRxWmJxWVNlS2NLTmJpQWVHakovSDdINmF6clN4M1Fr?=
 =?utf-8?B?dkczY3VJZno3YW9KVG5OaG9TMk02YkRFSWN3Q0p6VEFISytvNk9aM2N6M2F4?=
 =?utf-8?B?MWZ2aGUybTg3dE5HLzZGL2ZkUERYcEhURTl5Wk1QZjh4V0xiNUMzZFZJV3Zt?=
 =?utf-8?B?WjRoV2dzVjRJdEJFcmhQUk95QVdScWc1cjNMK2ROcCtIY1h3OU5lYjZuZ05J?=
 =?utf-8?B?YVkrd01GQXFRaG9kdnpaVHFuSzk4RkkvMXJLNVZFYnVUQ1ZiNWxEalpZQzIw?=
 =?utf-8?B?ZHZmQnBBeitVVUJEZWNFMjByKzRZN1pTY000WE1VcHd3UGppbUg3cW90S0JR?=
 =?utf-8?B?V0V3a0xyM3l2R3hab1dtRFg0N29MTytxUEdlN1dhSkdSSjBvODBVOUtJSjl3?=
 =?utf-8?B?YTVRNFRRamlCWlN4S21wUktzWEIwN0dUQmN3WGdYQ3k3ODQ4TGNsYUhLY0Ru?=
 =?utf-8?B?TnpEbFVTZTRnaEJCbitIRUNtdkcwSENyVGdxbEU2cWUxdWF1ZW9GODgwVXJF?=
 =?utf-8?B?aENzQitoSXAvZ3JGSHlIZGdUcHBZL29hVkQ1MG5MdjdrVm9qK1A3YjJYZXhY?=
 =?utf-8?B?a0ZFOG1RZC9TRzB1NnFhNVpndGU3VmpJQ0ZjL1BTMGpTdDdGVFQwbWIzc2dS?=
 =?utf-8?B?TVFTditwMHZ5RDRYL0RiUVlPeWlOd0pDYnVTMURpeW1UU3gvVThQYmhsaFlU?=
 =?utf-8?B?cHpoTi8zMkx5ZFYzMjcyTm9Nbk5KYnAwOVV1YUJWYUZMVXl1OEJMQy9KK1lG?=
 =?utf-8?B?RnR3ak43MWRlRVludHFHZ0t1YXFDdXJhUlpNajZlS2VKZy81ekZ4R1ltbVRk?=
 =?utf-8?B?MzFxRUhLOXE3K3BRNU5vSmluYnBLbkE5TFhMZFBNMFEza3J4cDJqM0tseW01?=
 =?utf-8?B?a0pjWjNuL3NiekFwYmNqWEcvV1Q1TWNCZUlBeDQxS0l0MURvNlNLbXVhLzdU?=
 =?utf-8?B?ZUtqUWVLckFNQ0FZaVNvUDFDSjBpeVJodHBHZThrL3cyalNGTkM4NUFKWWtH?=
 =?utf-8?Q?WTkG6is9Du+i0xkY=3D?=
X-Exchange-RoutingPolicyChecked: FEAXs0NADemn58EomwQCeRxRxL/kAH2cAgqTpLC3fhjyqeLQxc1n2XegHGYNOHJI7wq6aAYsmWxgzswXXoxAI7v4fTHz96Of5QJjjPW2E+6Q+HQfOjz/VPdhOoqByhvhJ3bQinrVGUjIBbyreIZ9XYvszhejJst8YcRMCbC+yRdrtE9BfquS0vk6fpnDt3zI3EKksXuRCKDWecEj4B+rJ1dfHyLv0NoF8Z0a3y4/rQCf5EAAMy5HfSNJFMFh9/ppSFuHgm6B1j388xB+jywAe4wzEAlpfMco+TUm3YaXwAL2bNUCn0juStObsv2kEkNnOlBAx9op45SzswaSNfWD9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25af7eee-df7a-46f6-d9ab-08df2972c63b
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:41:43.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjdHtAAz7r/XcvaqkLh1zXHM3KxYvJJyMJdO72aqvinKzKNqC3eo4/NCu9y8Xa4zKJi3DseOalknM04IJ4tYqjlp/f+1jK9T+4Z3pXolL28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 (2) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] In the non-READY branch of ice_ptp_release() (state
>   ICE_PTP_RESETTING or ICE_PTP_ERROR), the PF cancels its work, calls…
> - [Medium] Lost-wakeup hang in ice_ptp_cleanup_pf()
>   (drivers/net/ethernet/intel/ice/ice_ptp.c).
> 
> Pre-existing issues:
> - [Medium] ice_ptp_cleanup_pf() cannot safely run twice, and the non-
>   READY branch of ice_ptp_release() can run it twice.
> - [Medium] ice_ptp_prepare_rebuild_sec() (E825 clock owner, non-PFR
>   reset) calls ice_ptp_prepare_for_reset(peer_pf) while holding only…
> 
> --
> 
> ice: use reference counting and SRCU for PTP port access
> 
> This patch replaces the mutex that protects the ice adapter PTP port list
> with an SRCU-protected list and adds a kref to each ice_ptp_port. Readers
> skip ports whose kref has already dropped to zero.
> 
> ice_ptp_cleanup_pf() unlinks the port, drops the initial reference, waits
> for the count to reach zero with wait_var_event(), and then calls
> synchronize_srcu().
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index fe21cee4f9dee..94a66e9d8c05d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -673,20 +676,33 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  	pf->ptp.tx_hwtstamp_good += tstamp_good;
>>  }
>>  
>> +static void ice_ptp_release_port_srcu(struct kref *ref)
>> +{
>> +	wake_up_var(ref);
>> +}
> 
> [Severity: Medium]
> Is a full memory barrier needed before this wake_up_var()?
> 
> The kernel-doc for wake_up_var() in kernel/sched/wait_bit.c says:
> 
>   In order for this to function properly there must be a full memory
>   barrier after the variable is updated ... If the variable was updated
>   by a fully ordered operation such as atomic_dec_and_test() then no
>   extra barrier is required. Otherwise smb_mb() is needed.
> 
> kref_put() goes through refcount_dec_and_test(). That is
> atomic_fetch_sub_release() followed by smp_acquire__after_ctrl_dep() on
> success, so it gives release ordering plus acquire on success. It is not
> fully ordered. __wake_up_bit() then checks waitqueue_active() without
> taking the waitqueue lock.
> 
> Can this interleaving happen on a weakly ordered architecture such as
> arm64?
> 
> CPU1 (last reader, e.g. ice_ptp_tx_tstamp_owner)
> kref_put()
>   refcount_dec_and_test()      /* refs 1 -> 0, release only */
>   ice_ptp_release_port_srcu()
>     wake_up_var(ref)
>       waitqueue_active() sees an empty queue
> 
> CPU2 (ice_ptp_cleanup_pf)
> wait_var_event(ref, !kref_read(ref))
>   adds itself to the waitqueue, set_current_state()
>   kref_read(ref) still returns 1
>   schedule()
> 
> If so, the remover sleeps in TASK_UNINTERRUPTIBLE with no timeout.
> var_wake_function() filters on the key, so an unrelated wakeup on the
> same hashed queue would not wake it.
> 
> Would adding smp_mb__after_atomic() before wake_up_var(), or using a
> fully ordered decrement, avoid this?
> 

I guess this would require the memory barrier.. despite the name
refcount_dec_and_test() doesn't provide the necessary barrier and there
is no equivalent kref_put() call, so I suppose a full memory barrier is
required.

:\

>>  static void ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
>>  {
> 
> [ ... ]
> 
>> @@ -1424,16 +1449,22 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
>>   */
>>  static void ice_ptp_restart_all_phy(struct ice_pf *pf)
>>  {
>> -	struct list_head *entry;
>> +	struct ice_port_list *ports = &pf->adapter->ports;
>> +	struct ice_ptp_port *port;
>> +	int srcu_idx;
>>  
>> -	list_for_each(entry, &pf->adapter->ports.ports) {
>> -		struct ice_ptp_port *port = list_entry(entry,
>> -						       struct ice_ptp_port,
>> -						       list_node);
>> +	srcu_idx = srcu_read_lock(&ports->srcu);
>> +	list_for_each_entry_srcu(port, &ports->list, list_node,
>> +				 srcu_read_lock_held(&ports->srcu)) {
>> +		if (!kref_get_unless_zero(&port->ref))
>> +			continue;
>>  
>>  		if (port->link_up)
>>  			ice_ptp_port_phy_restart(port);
> 
> [Severity: High]
> Can this loop reach a port whose PF has already destroyed its kthread
> worker?
> 
> When the state is ICE_PTP_RESETTING or ICE_PTP_ERROR, ice_ptp_release()
> takes its non-READY branch. That branch tears down the worker and the
> clock before the port is removed from the list:
> 

This was pointed out on the previous patch and we need to re-order
teardown to fix this.

> ice_ptp_release() {
>     ...
> 	if (pf->ptp.state != ICE_PTP_READY) {
> 		if (pf->ptp.kworker) {
> 			kthread_cancel_delayed_work_sync(&pf->ptp.work);
> 			...
> 			kthread_destroy_worker(pf->ptp.kworker);
> 			pf->ptp.kworker = NULL;
> 		}
> 		if (pf->ptp.clock) {
> 			ptp_clock_unregister(pf->ptp.clock);
> 			pf->ptp.clock = NULL;
> 		}
> 		ice_ptp_cleanup_pf(pf);
>     ...
> }
> 
> ice_ptp_cleanup_pf() is the only place that unlinks the port, so
> kref_get_unless_zero() here still succeeds until it runs. port->link_up
> can also still be true, because only ice_ptp_link_change() rewrites it,
> and only in the READY state.
> 
> For ICE_MAC_GENERIC, ice_ptp_port_phy_restart() then does:
> 
> 	kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 	...
> 	kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
> 				   0);
> 
> kthread_destroy_worker() frees the worker but does not clear
> ov_work.work.worker. The cancel would therefore take the lock of a freed
> worker. The queue call would then pass a NULL pf->ptp.kworker.
> 
> The clock owner can hit this through ice_ptp_rebuild_owner(). Because
> ptp_clock_unregister() can sleep, the window is wider than it looks.
> 
> The same window seems to affect ice_ptp_prepare_rebuild_sec(). It calls
> ice_ptp_prepare_for_reset(peer_pf), which runs
> kthread_cancel_delayed_work_sync(&ptp->work) on the peer.
> 
> The READY branch already calls ice_ptp_cleanup_pf() before it cancels
> any work. Should the non-READY branch also call ice_ptp_cleanup_pf()
> before destroying the worker?
> 
> The commit message says the kref "ensures that a PF will have a valid
> lifetime and not be removed until the reference is released". It also
> lists ice_ptp_restart_all_phy() as one of the iterations being fixed.
> 


> 
> [Severity: Medium]
> This is a pre-existing issue, but does anything here serialize the peer's
> ptp->state against the peer's own ice_ptp_release()?
> 
> ice_ptp_prepare_for_reset() checks and sets the peer's state without a
> lock:
> 
> 	if (ptp->state != ICE_PTP_READY)
> 		return;
> 
> 	ptp->state = ICE_PTP_RESETTING;
> 
> 	/* Disable timestamping for both Tx and Rx */
> 	ice_ptp_disable_timestamp_mode(pf);
> 
> 	kthread_cancel_delayed_work_sync(&ptp->work);
> 
> At the same time, ice_ptp_release() on the peer reads this field and
> writes ICE_PTP_UNINIT to it.
> 
> If the owner writes RESETTING after the peer has written UNINIT, the
> peer exits release in a non-READY state. A later ice_ptp_release() would
> then repeat the cleanup.
> 
> In the opposite order, the peer takes the non-READY branch and destroys
> its kworker while the owner is about to cancel work on it. That is the
> same ordering problem described above for ice_ptp_restart_all_phy().
> Calling ice_ptp_cleanup_pf() first in that branch would fix this case
> too.
> 
> The kref and SRCU here protect the port memory and the list linkage. They
> do not protect the PF state machine. The commit message notes that the
> change "focuses solely on the port list".
> 

Yep. This likely needs to be handled as part of the work on the
ctrl_pf/ctrl_ptp.

>> +
>> +		kref_put(&port->ref, ice_ptp_release_port_srcu);
>>  	}
>> +	srcu_read_unlock(&ports->srcu, srcu_idx);
>>  }
> 
> [ ... ]
> 
>> @@ -3110,13 +3157,23 @@ static int ice_ptp_setup_pf(struct ice_pf *pf)
>>  
>>  static void ice_ptp_cleanup_pf(struct ice_pf *pf)
>>  {
> 
> [ ... ]
> 
>> +	spin_lock(&ports->lock);
>> +	list_del_rcu(&ptp->port.list_node);
>> +	spin_unlock(&ports->lock);
>> +
>> +	ref = &ptp->port.ref;
>> +	kref_put(ref, ice_ptp_release_port_srcu);
>> +
>> +	wait_var_event(ref, !kref_read(ref));
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but what happens if
> ice_ptp_cleanup_pf() runs twice for the same PF?
> 
> The non-READY branch of ice_ptp_release() calls ice_ptp_cleanup_pf() and
> returns without setting ptp.state to ICE_PTP_UNINIT. This sequence seems
> to run the cleanup twice:
> 
> ice_devlink_reinit_down()->ice_unload()->ice_deinit_features()
>   ->ice_ptp_release()
>     (state is ICE_PTP_ERROR or ICE_PTP_RESETTING, cleanup #1)
> 
> ice_devlink_reinit_up() fails before ice_init_features()
>     (ice_ptp_init() never resets the state)
> 
> ice_remove()->ice_unload()->...->ice_ptp_release()
>     (cleanup #2)
> 
> Before this patch, the second list_del() on a poisoned node either
> faulted or, with LIST_HARDENED/DEBUG_LIST, warned and was skipped.
> 
> With this patch, the second kref_put() runs on a kref that is already
> zero. refcount_dec_and_test() warns and saturates the counter without
> calling the release function.
> 
> kref_read() then never returns zero. wait_var_event() would block
> uninterruptibly forever while devl_lock is held. On hardened-list
> kernels, the result changes from a warning to a hang.
> 
> Should the non-READY branch move the state to ICE_PTP_UNINIT, or should
> ice_ptp_cleanup_pf() be made safe to call twice?
> 

I suppose setting to ICE_PTP_UNINIT makes sense. This is the same issue
as reported on the previous patch.

>> +
>> +	synchronize_srcu(&ports->srcu);
>>  }
> 

