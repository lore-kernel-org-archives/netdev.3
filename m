Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545CC542EED
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663311; cv=fail; b=Hyj6NCkCIYPxP9hxUdfVI9N8URlchnEOw6a7eDkwcDlofqVk5vq/Bkql1a+jhuqVREhq76Z+P74l+Xg7HgzccA2LN8xNKMzq+Mw8tCd7LlTVAgas24MrWaNieTHEwL6qtAwcCs0x6mrudJFKMlcpFNZbwOSubQZvmoO9lTC+Zvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663311; c=relaxed/simple;
	bh=iR92sdOZiGruXPs6N+uJS2xGoa6LtKy0t8/Km8aAWNo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cXUdSVWkSaFY/zfukgmUFlceTW2A/5AwfJbAT8sVxURdIrSUhFFWWyYBdzX8Jr9pWVtXKA2XNTHz26VB/Olov60y05zZuT7qD8zhyCtMLQhyr5YutlEF9ldzfIoFTjwlNJlROivUGqIGELtOlYFCdNv5aZMvcbNZupXSRBnAsnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7X5V1lh; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7X5V1lh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789663309; x=1821199309;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iR92sdOZiGruXPs6N+uJS2xGoa6LtKy0t8/Km8aAWNo=;
  b=O7X5V1lhL2oEnY1zN9UmeOCZ5qtT32fI72USoTjoVfJR3vOuKVUg8gg3
   vEzgJ+tsgwuW+ivq8KsiRODi1hRnGflyMIw0qjnpF7LylqLb6qqeFzZIj
   QlUGubH24c0ByLzWJ996xe/73dLij49a9TzjWHTDkomRwyS+DQl2HxiqE
   dR8udbu6YnREys7J6ONBGRm3llpTPNVfCPLM6uAq3+vJHpudmyRRQoPtB
   DQ0oOKHtgs5PE+IqBqTmMTBlUPyzC2u/yMpQHdGVw8vjRLrCAed/OthAC
   m39rYkyfYKX+vcrSAetXFrRVTXA5E/EoAzfq/qNrd90SUJFf9NKTQheW2
   Q==;
X-CSE-ConnectionGUID: 9Qj0EnyuSJ2Jy9lk2s7xOA==
X-CSE-MsgGUID: AOBzApJ2Qf2ghgageeTNNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92616026"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92616026"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:41:46 -0700
X-CSE-ConnectionGUID: IP5wlzV+Q++UoFII7Ry8tA==
X-CSE-MsgGUID: BuwaaWSgSkqQJuuu5SlVTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270217700"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:41:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:41:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:41:44 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:41:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNRZKRSz9PJl6aUzKuBEJhHFa8L8ls25YgGNlnI5cWrc4pCPH2tjyAFryp4pNfuJcIDw5WTPchX9f6ANJgWvUNDCqEjCNQzGjiHx5tGmdPzmBsQ4M/snohoXoztHv2SNYPbq4OBnUiHOMUZzEbKNbbmumm3e+b3izp14JSEY1zStCnHRR1Z0RK38tSCCiOiuwbdETBJvWgFKyKlkhcWNjxsd7IwHBpAAtMO7fo2rIQd7dex2UpkTudN52QaLDkFy4G02W5gi4G6y9yedC90HVOL6raaboN149+HqfQqEhBDvFkh6Ep9KYXHSlHHtXtouLGgSX4kX5FJLYGDsoZ9ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RvoN+eFo6M4f+YJg8U52NcyEesgrrt1NsclSadFlEM=;
 b=sBf2Pm7B53UrkMjdZEU1YtqP9o0DqbB1Crb67vz5A3eFoQRgTneo2gNDrXDRsmiM7VJr5sdpIzZaSaHN988XpQICrhk5gEZkNLNlv40GqSbeC5LjC5IjYVbzCJ+9mMPYeP1xM2HSG9gCTB9hmMJiiXzUGVdkr/yBF8TINLnxp1datEYHooo8SF3i87i2roVj11u1342mQ3NhNQtH0CV0kaYgyUUdsAxcjLLvxh3j0Z4eiIr12lHnebM8Ku7acNk0s8kDjTSGKc9QuUdEOPLJvoTnWz0lAonL2HahSwaJHzkL2w+xOx3b2atFVnAgQmsHhyEQ/1jymXfR8wTSedTASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CO1PR11MB5138.namprd11.prod.outlook.com (2603:10b6:303:94::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:41:39 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:41:39 +0000
Message-ID: <698bb677-473a-411f-997e-bef7ae59506a@intel.com>
Date: Thu, 17 Sep 2026 09:41:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 07/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-8-anthony.l.nguyen@intel.com>
 <20260916011219.1632582-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011219.1632582-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CO1PR11MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ce35bb-c4f5-4a43-444d-08df14da8bb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|6133799003|4143699003|18002099003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: Q1e6XG2FUA1Fdk0FZk/gSDcESfJ8CzZDrvUShosRyz9BnNelKxzN2okVaaIM3ewpSpmpYL3QOw5dVNwaIFAmZbi5cc4alwuMMC0vXjDDqGfZaMqoALrehaIxznY3TXItRlz5meA1Ll9YIYjfmorswPP+0PbjARakZJrQQJbxK+EN81o1fycy/+NriMuLdqqB+UAV3Hd0JWt/K4+Y6rfVlJKCDx2u+/3FrXvp/8Ovm1z+4u9pQS75G0up45RFmUryYOFlqyX6S+aeXR3NXSC9eXbvtYMpxU3VrxpzarGPiaxM/k4F/bvR7YxwuhpVatmoi4g5au5pJcX64VKw+/56BslIQ2IW74ftrVP7YsoyrF2SqS7XT7iRuSVUex4+tQD5EKWdRAeFHmeYA/e7bF12ozopW5K0Bhf9UKDG/FnLUtG6KHoutuuqCM+pd76wXgbQZZNJ19rDjOrLtcIlwYIlYPFqFjnsGQITcfl5VXUch+A8rOS0EuuL1KB1KEMsjDJq6Vx/5gqng0SB9chfqMzxCCnQcQUSOuvUDjQ+bWv+kQVxCVXkhtHXDqNZ2DnCXxFNhvD6hxUESVGH8dl6nRrR2w3M3h23z7XXuDDgBBVM1SCscLxbyh4/wDOA86+lJD5BHbve9UULL2dr4WFZ/tx8yDJcXweu9q6Nwr9fj6bvwXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUEvRmpSSHJjMmVxd0REc2pTYVAvN3c1d1YvOHB6UHRkYW5tQmpDTkVzYjZw?=
 =?utf-8?B?Sml3NVNvKzBQWEVBUTdxQ0ttNWVDcDFLTGJiNTY2dFZDN3c0Ynl1K0Fkc2pC?=
 =?utf-8?B?aDg3MG10b1FKM2thZnVFekhtWW9rRkY2ZndjL0lkRzZ0RXd3cjRMTFdCMTIv?=
 =?utf-8?B?b1dRR0d5ZWxycE9JdFQ2WHdwWXdYVkpqdmhWREVhVzVmcWpwOG9ISlFuR3F0?=
 =?utf-8?B?eVZ0Nzg2S2R6UTlVRW5FNkdXN21vNGZhTDFaRnJUdEV2WXo2bU40MnU0em9R?=
 =?utf-8?B?TzVKQVNYeDRicUlNY0xwVDZtZ3BaL203WkR0VSt6aUZKMTF4NTBSbzVFTHhI?=
 =?utf-8?B?WkxEQ3RlUkMveUs1SUE2N3M3N290cHUzQW1qVkgzOVo4T25Mb3FRR2pjWUNW?=
 =?utf-8?B?Y1h1UXZNMjRmYVZkclVRNUc0OTVaOHYvSmMwYldkSUJTdG9OOW9CN1BJY003?=
 =?utf-8?B?VFZYU0J5MVJlQmFPQ1lkQWFyREJjNkNGQzgzeTIxbE5XazUrR1hndGk5bU0y?=
 =?utf-8?B?Zi9wTzlKbTdCN2lQYnl2WTQxdUU5cjhxc2U1VUs1SUdPMWRBek5tK0txZ3hB?=
 =?utf-8?B?QmdaK2hNN0hLSmEwZ0I3bzloM2s3S0VMS0FYdHVmN1BCdnhkTm1nYVpBNGk1?=
 =?utf-8?B?MTZhdnVHUzdjcU5LWFZ3VGwyeE9mNk9mUjRVb2pIRVI3YXJkelNMdmtmODlK?=
 =?utf-8?B?LzBmb0E2c1IwM0dtb2pNYVVBTnFoSzRoR21SWWdudThPUXFwS2dHWXVkY3da?=
 =?utf-8?B?dmxzSUM5UG81TFdxWTUvQXlUWjlDOVVDUVdRYk96eGpLTkVycWZub0Nmb095?=
 =?utf-8?B?K1FSMmozM2ZRNXNHVVEzdGJVdHNCQlZmRi8wVkJ3cVZjK0QzaFd3dVhCQVdz?=
 =?utf-8?B?YmY4a0N5ZVFQWDR2d0hMZG1TSGpaZDEyY2YvVUlOZWk3SUhlc011SFdoMkRD?=
 =?utf-8?B?YUJkcmw2bXYrRWZaZlBnQmluRDU3cHpGaTUwTm9uWDI3MUw2ajdiMjdwT3hJ?=
 =?utf-8?B?K2JmV2hyQzZXb1pXVkpyZlVXZWE2UGR3ajNST0dDNnBFa1RJcEhMMVEzN0lP?=
 =?utf-8?B?YS9ONmlnMmZ1YWx0T21RWU9sSGMyWjJIcVR6S0tIWUxzZ1FOdGVhRXAxSUcx?=
 =?utf-8?B?VjZhc1ZORm9BekZ5c2ROaC9OQVpIeTVlWlpUWHpVcUxKMzRRREtvTys0cjFy?=
 =?utf-8?B?eTRodEcycjY0WVhwRUFzbzl0bGRtS1UzY09BOEJlL1RCQWtPaWJVM3V6ZjEx?=
 =?utf-8?B?eUFOSGVmWXJYNnFHOUJaeVBHWUNTb0ZuTFpkSDc3ejk3MURyU2hqWUl0d1Q1?=
 =?utf-8?B?aG14TWxHcWRicEpEbU9hMi9BbEdiYlhqMGVtenNkMXpBK2tDZUF3TWN3RGJm?=
 =?utf-8?B?SGxjaVh2NXhQMVFNSjluZVBjSXg4TWRRRSttNVpFN1pIU1A4QTJQNG92L1Zn?=
 =?utf-8?B?bjZ1cDJ0b3FjcC9LTVpFY2IzKzE1WjNFeFBuVGJXZXhSSkpKNUszcnJrdzVj?=
 =?utf-8?B?c3hhdGZWbUdXNytxcjNQQmJ4dkJUeTQrbDNRVlZER05RUGo0dTZHVmRjTE84?=
 =?utf-8?B?Rzc1cE1BcXhwSGRNeWgrS0Q3d1g5aVVEWDJmUERrcTgxOGhHZlA2aG9Sdll0?=
 =?utf-8?B?aU9MNGJwOVRnTkI3d2Ntd1FJS1BZOStXVlRmbDZ2SnIzVE1qbkZrd0F2UlJC?=
 =?utf-8?B?aDRWSnpiT1g1SFJweHIrYklpc2htZjR5T1pWVk5xQ09mNU85Si8vWVowVGJE?=
 =?utf-8?B?eDBueUpTYnRTRi82V25yME9wMnNDb2FDV1dSYlNWOUNyYVJKMHQ4QktOZUxZ?=
 =?utf-8?B?SllxbmwwSkFJbUcxNGEza1BnYnRYQ3JlbmFtRGtkMjFDb3QzQjI3OWNKUXE3?=
 =?utf-8?B?SWVCU2dKZnZuQVpDendMSFVCVVI2UUlHLzlzQ05iN1cxaDZMQ2k0QlhOM0Rr?=
 =?utf-8?B?anNTK0IxQmtldlVkSVp3d29IT3dpQ1dqbnkzdHVQd3pOWndRSlJXMTl2RmI4?=
 =?utf-8?B?Wldnd1hZT0J1ekhMSmlCZ0swMVJuTVFJbk5GRTJzajBVZFRISVJPc1F5NW44?=
 =?utf-8?B?MFBJRGtJRDBheDU4V1Z0R21oYVhQVnBSNFlNcmhuaW4xd3hiNDVMS1NFUTFl?=
 =?utf-8?B?azlWVitSNXFNOVJic0dzQ3F5Tk0wdjFxb0xTdG9LZDhrL3JqNGVmRnJHYXNq?=
 =?utf-8?B?cVNOL2piS1RYUEJhYXAzSDk3dWlNeDh3NXN6ZHlpS2pmKzlwS2ltSGZiKzFt?=
 =?utf-8?B?Z25IcXFncHozbU5ISmpOb1cwNWtBQ2h3TzhaUzBBL2RPT2pTNlY1eGNxWjA5?=
 =?utf-8?B?YjMzR2hQQ1NXVG1XZXpWZlJ5c3lPQWtjNWRvc2hSbnAwNjNvcXFHa3VNaksr?=
 =?utf-8?Q?2UzXNtITFb0ozZvg=3D?=
X-Exchange-RoutingPolicyChecked: JVw7VrFbCKtafzDro1FopT5TMdf6XdeYL6WWPXMh66XQZlPfXr9LHydMFrY5c4AycaRtDE9plS9tajlDOZlbYnmgu7Y4NEUiC0PEjhBBQl8lX4N0ZjMQoGgKKB11yNbomkSZ58cGI2/OYBZsPAasQuYlRmgrLY7DedzaCb12MogwRIkore8Clh7gu+STmmV71OREsMD87ZKdkIRAIBE8Mn/KCKLJPwy1uCMBAkjfsd15zv+9wID7vAMVKQoMKmcsfWaOKdOwkvaPorOuooQzFIcAnOcscbVkhqo02Jj44MgxQE/Mtk+txvQ0CyxQX8gAUR0S8unNuy6QdrhL374UxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ce35bb-c4f5-4a43-444d-08df14da8bb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:41:39.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfKyESzdtl5FhsXrxAbQLbJuFQCY5PRJ5qXoZeii3/eswHB/HB4BoElx3pL22HpRFTZzZ5Kdd5SFIswKvhG0Dchac+e8CuL7Id6lYWZ6zzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5138
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
>     ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
> 
> This drops the PHY_REG_TX_OFFSET_READY = 0 write from
> ice_stop_phy_timer_eth56g() on E825 devices. Clearing that bit left hardware
> capturing Tx timestamps without the valid bit, which desynchronized the
> internal outstanding timestamp counter until a PHY soft reset. Only
> PHY_REG_RX_OFFSET_READY is cleared now.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 3a41c711e751b..d48eb3c618231 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> @@ -2115,10 +2115,6 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
>>  {
>>  	int err;
>>  
>> -	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 0);
>> -	if (err)
>> -		return err;
>> -
> 
> [Severity: High]
> With this write gone, is anything left that suppresses Tx timestamp
> reporting while the E825 PHY is being re-calibrated?
> 
> ice_start_phy_timer_eth56g() begins by calling the stop helper and only
> asserts Tx readiness at the very end:
> 
> 	err = ice_stop_phy_timer_eth56g(hw, port, false);
> 	...
> 	err = ice_phy_cfg_parpcs_eth56g(hw, port);
> 	err = ice_phy_cfg_ptp_1step_eth56g(hw, port);
> 	err = ice_phy_cfg_mac_eth56g(hw, port);	/* PHY_REG_TOTAL_TX_OFFSET_L/U */
> 	...
> 	err = ice_write_40b_ptp_reg_eth56g(hw, port, PHY_REG_TIMETUS_L, incval);
> 	err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
> 	...
> 	err = ice_sync_phy_timer_eth56g(hw, port);
> 	...
> 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 1);
> 
> Across that whole window the Tx offset registers are being reprogrammed and
> the port timer has not yet been re-synced to the PHC, but per the commit
> message hardware now marks captures valid, so this check in
> ice_ptp_process_tx_tstamp() no longer drops them:
> 
> 		/* Discard any timestamp value without the valid bit set */
> 		if (!(raw_tstamp & ICE_PTP_TS_VALID))
> 			drop_ts = true;
> 
> The E82x branch of ice_ptp_port_phy_restart() gates this in software:
> 
> 		spin_lock_irqsave(&ptp_port->tx.lock, flags);
> 		ptp_port->tx.calibrating = true;
> 		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
> 		...
> 		/* Do not clear calibrating flag here. Tx timestamps remain
> 		 * disabled until ice_ptp_wait_for_offsets() has verified
> 		 * that the Tx and Rx offset calibration has completed.
> 		 * Clearing it here would allow Tx timestamps to be reported
> 		 * before the PHY offset registers are configured, leading
> 		 * to incorrect timestamp values.
> 		 */
> 
> while the E825 branch does not:
> 
> 	case ICE_MAC_GENERIC_3K_E825:
> 		err = ice_start_phy_timer_eth56g(hw, port);
> 		break;
> 
> Since ice_ptp_is_tx_tracker_up() only tests tx->init && !tx->calibrating,
> new requests keep being accepted during the restart, and the restart path
> holds only ps_lock while the reader takes tx->lock, so the two do not
> exclude each other. Should the E825 case set tx.calibrating around
> ice_start_phy_timer_eth56g() to replace the removed hardware gate?
> 
> The same exposure looks unbounded on the early-return paths of
> ice_start_phy_timer_eth56g(), for example the ice_ptp_lock() failure:
> 
> 	if (!ice_ptp_lock(hw)) {
> 		dev_err(ice_hw_to_dev(hw), "Failed to acquire PTP semaphore\n");
> 		return -EBUSY;
> 	}
> 
> because PHY_REG_TX_OFFSET_READY is only re-asserted on the success path.
> The reachable trigger is a link up or link speed change
> (ice_ptp_link_change() -> ice_ptp_port_phy_restart()) concurrent with any
> SO_TIMESTAMPING application. Could the commit message also mention this
> change in reporting behaviour during calibration?
> 

I believe we accidentally get the correct behavior through other changes
in the series, but we should make this explicit. We cannot clear the bit
because the hardware behavior for "invalid" timestamps is problematic.
However, the software must gate this period. Later patches in the series
make it gate by link down, which effectively achieves a similar result.
However, a more explicit clearing is likely preferable. Will investigate
and fix.

>>  	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
>>  	if (err)
>>  		return err;
> 
> [Severity: Low]
> The kernel-doc and the debug print of ice_stop_phy_timer_eth56g() now
> describe more than the body does:
> 
>  * Stop the clock of a PHY port. This must be done as part of the flow to
>  * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
>  * initialized or when link speed changes.
> 
> 	ice_debug(hw, ICE_DBG_PTP, "Disabled clock on PHY port %u\n", port);
> 
> After this change the body only clears PHY_REG_RX_OFFSET_READY, so no Tx
> offset is invalidated and no clock enable bit is touched, while
> ice_start_phy_timer_eth56g() still asserts both PHY_REG_TX_OFFSET_READY and
> PHY_REG_RX_OFFSET_READY. ice_ptp_port_phy_stop() is likewise documented as
> "Stop timestamping for a PHY port" while Tx timestamping stays enabled for
> ICE_MAC_GENERIC_3K_E825. Should the comment and the log message be updated
> to say only the Rx offset-ready bit is cleared?
> 

I'll update this.

> [Severity: Low]
> This isn't a bug introduced by this patch, but with the body reduced to a
> single register write the unused soft_reset parameter becomes quite visible:
> 
>  * @soft_reset: if true, hold the SOFT_RESET bit of PHY_REG_PS
> 
> ice_stop_phy_timer_eth56g() never reads soft_reset, and PHY_REG_PS appears
> nowhere in drivers/net/ethernet/intel/ice/ outside this comment; the E82x
> counterpart ice_stop_phy_timer_e82x() does honour the flag via P_REG_PS and
> P_REG_PS_SFT_RESET_M. Both call sites are therefore equivalent:
> ice_ptp_port_phy_stop() passes true for ICE_MAC_GENERIC_3K_E825 and
> ice_start_phy_timer_eth56g() passes false. Would it make sense to drop the
> parameter, or to document that it is ignored on ETH56G?

I'll drop this. The soft reset parameter was likely a copy from the E822
device and done when there was hope of merging the paths with a function
table. That never materialized, and is not worth doing at this point.
