Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E23351C35
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262339; cv=fail; b=S1HUvcbzw54h+A2n+L1vrOrokkDfeueHrHMTpMF6pBrgXE8MNAPROXO1JDTiA1zTT7ga2Jn60obgPN5p3LGVBN+k0ZJOSjHJB0nbfJU+tSuY4A15XTuU+X0LzVgzd7Ffc0lNEOzuS1A3ZDjwgFKCQuSMTjcKBcJgi8KE4/Wuefs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262339; c=relaxed/simple;
	bh=R5snK44FK4IohM9bWMhnK3Wl/EBxk0cjERRVIjT+o88=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cZwG+0UP5IX5bj7gZ3Ap+p5WevP2vkUrjMP5TjMK0esGdWxS1rvtvGrKZmdYLKYQowMOkLn8R7KFTajJbUbltzqO+8IV42PLyLNbPZS/Vn/wA1F4/luV5p5QwbA7D2aU3xS7oORWft3XY87tgMevVAZTREp/3r40lFkbn4mjZFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glRoI/4J; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glRoI/4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788262338; x=1819798338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R5snK44FK4IohM9bWMhnK3Wl/EBxk0cjERRVIjT+o88=;
  b=glRoI/4JMnecviMHYZKtFzarLsAgzmpF0rParBp5MHCX0tvuChGqEckz
   /nD4+aXA2uMy4l51KHexHC/gX4UxwtjcgxPmRjzmdCPldg64cEyBMETZN
   IxqvmqWfXZ0u2Rag2PH1+8NFQho/IKE0tfxJ2NCLc2iYYvnKeXRect8VW
   qUUvKPafuxgkpDMFt7Dz/IHMQFH1FWyP7bDmjiCcPC3EEmfA8mONMZh4D
   +k6yeDWnUMsOepgzqDw3IxbqWTUcC6QdaF8YG1EugLBJ29GeFtLD8phLq
   hVpBJVHJeno2W3y+T6DA5aRAmhUozxZC9YoTsAJQq2PPH3VKGuzV4woFa
   Q==;
X-CSE-ConnectionGUID: 8sJmBL8LTiaQdUJDlTDUiw==
X-CSE-MsgGUID: Ix5O/TbjRQSnPCxnRsyEyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88540706"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88540706"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 04:32:18 -0700
X-CSE-ConnectionGUID: kt9R9jajRtWBqtShDj+iHw==
X-CSE-MsgGUID: 23ou9YQZRhqfjxOEHkTrOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="271010473"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 04:32:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 04:32:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 04:32:16 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 04:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=om+CQYqyfFLChKgCsQpOXzakMZu3qVhZpHYdcRpLLjNK/qWL4odP3YtqN0hpvOUbImhT0EgbtMwzdeDgHsSqvsshET9YwYeO30kw5/OPaF2/NrfZUXRTy4gnBsCr4My1kqp2DbYBNFTCmVjmBugAsfuRIFgYy7+ti2LMQpXOCTOWsPHhjcduCnJSjswJLzAIF3yKT9Ad5m+rSpAbhdy84mkLP57ogRk8gAm2cPpbpnBG2+NjBAQSablqEo0gR1HzCRrp08UnRNo64xN4wPx96QcxiO2jkhDVhW84yp8qGTG+2Eeu6+RUQIvyosMOvITq2xuGlh5NfQ1sYaP9VAgvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYdzfeyHbZIqu4fO5rFuvYsVdYmaRDbDt6ne8wti7UM=;
 b=iHK0AU35fA6eGtOVLnM2Yd17RZfXrV8LXhSUI/Mwd0dVD8W00qJfN3LiWBZw9ZWyAfGYa0S2wa5azWPKK3YnMBmSkcDQjEp72Xtc/d5g9RUfvVynHeAY/DClPXeKtQZJusQvgTlBVkCmhQJ3wIR4wq9EpeI8wjwLHBTLKuWhnhQ5yxwWElAekVwUCSLynZauai7SVcN6NL82I+quSp59c93Cp7x4+gImmMQ+gULrM/jA82UDDS6U/q0gM+Yc/3LsPDsFmSDCD4G/a5PZZGpoz7pb20I+pmEbVwjmNw+zr+vrxuR2XFktB+bugETdW1zNEM3hiw95gTWfQIeH05EJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DSWPR11MB9713.namprd11.prod.outlook.com (2603:10b6:8:356::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:32:06 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:32:06 +0000
Message-ID: <d423e711-a38d-4d68-9395-60c371e8e8ff@intel.com>
Date: Tue, 1 Sep 2026 13:34:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5] ixgbevf: fix link speed reporting for Hyper-V
 E610 VFs
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Marcin Szycik <marcin.szycik@linux.intel.com>
References: <20260826143950.2385891-1-tomasz.lichwala@linux.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260826143950.2385891-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0213.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::34) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DSWPR11MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: fff91741-68bd-4edf-aee7-08df081ca6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1Y/qqyiHE+8F/yh51gHuqZUQQzSgGh0Vclhw9D0JZbTGIiCsHlrQTxHwQSpVmcp9pOfN+eL+gjEdBGLv1DFQFrcrAqNfh7YoRn7mbTA8Tk6oEu+lxJiNoSdLo8SXLwxENSVrPH1C4JIoe7rDNaX04cT2I7CeJiAbV5XkKGbNgAWOSkPBOc/yjpcjZcxVz+YUTV36Wd66Ugj888lKRnhsEkva0kyw3h398uwQ3Uiy20u53rLy3Xkjs3is5cUGGyYgtgqcbIgHC358KKsZqIUNYWeZVazqGkVH8QHXVpnaL8lIR4HcXyoqxyGEsBHQi1MM2ju3A74SLmV3mbGXbxbY3OkJ2NFzMuGQuj0B8TyIfitDivjGfQmW9DMR8aZ8YGuyV64Crrw1g4Bzv/RT4c3vvvCZQvP5S/ASWKH4mr+yGEnBVfGkpqMxSwaLkI7YZ6li214zi7gkbhu3KpAATkcJZnIbRSL0VAMDwfWJUjECNmHp1pmrPHCB+UayZoo53IcYDznscim8qsilyt/dYpjXNitW3Pdp7XM+GBC+yBhZitJmcAPQsRtU9yDgI0kEqI+vT1AP6YwSDYozNI2Set41ZpAJXG+aHTOUiQCcwy8EmcOhhWHjiUg+zJ6zZ1Sx4mdxEtbFCfmkKxQ9kaPXqMz9v8TYsGw9uKZfbVXdre7E7oU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdseFBZcmJ6clRPZGFjNk0rM3FST0dRcmdDMDhwL3l1RjYxdmFGS3g5UXl3?=
 =?utf-8?B?Z200c3h3OXJJUC9qeURJYXZXUzlsMnhZUzNBN0JGOXRoSXFpZHB6d0xvVk5K?=
 =?utf-8?B?TkpBRlNjS0RCcjNQZFI3N1dwRENJeG5id0l6Zk1hVStNSVBoWmFUYzhuckNG?=
 =?utf-8?B?YVpiVWkvckZ5dFU0ZHNBRnRBRDVyKy8zTyt6THVKdkNoYm1nRlZIMXVpMHd2?=
 =?utf-8?B?OTAvNXBVZVRjdThqTFdqWUpmUmEzbUNpK0pCcEFsMFF5cS9rS1FMdlhwTm5N?=
 =?utf-8?B?eWgwMlRUNXRSWEhjNHg3bkhhK2lzTWNwQldGNVdHT1NDdnhwcnYvMVpNN1RO?=
 =?utf-8?B?WFZqWTByRzlxMFhaL0tXK0ZsUGgzOFBFZENFbGVwMkFuNzFaNkNDSUZzckVl?=
 =?utf-8?B?MlZDOUIxdW1YT1Zoa29nT2ZOS1ZQdXdDTkNlZnRiZGRObGl3bnZWejhTbVJN?=
 =?utf-8?B?WDM2QnF5NlF3dmxIam85SVMvMlQ1Q1hOenVjZW9Od2ltaCtlM09PamloelJs?=
 =?utf-8?B?QlZveDJKNEdYcTBUdzFkd0Q0SEpPemtwZUZtUWZOVmdhdytPQmVEeVR3K052?=
 =?utf-8?B?TGtBcDVnRjBDK1ZTRXFLMnQ0dmwrTUVzeUd5L3ZZVHMva3AvZ1hScTNoQUdX?=
 =?utf-8?B?Uyt0d0diN3RQZ1V6OVZjV3dqV2luanEzK241QVZZQjIrTldhemZWMmRNbUx2?=
 =?utf-8?B?dHl3OXl3ZElyelpBQy9BZUFwTzlldkc4VjBLU0NVNnhRRFo4U09yOGdaVEc1?=
 =?utf-8?B?SzVFZDNlMWQ4WXQwQkRwNVZoNVpPTTVvQVpiUTBlL2JGUUlyTU5pdjAxUzN3?=
 =?utf-8?B?b3FNUFM4cDBFS2tYZGtNTFV3anhtYm9TMkFOMmkvT3VpanpFMzhqUDlLaHlJ?=
 =?utf-8?B?VnRoTUp2dThIV2dVRU9HMmZmdmNKK0pvRDdqUkdxZ1RWR1huNmZKSUlOWDB0?=
 =?utf-8?B?WjhISmhDcDhqN09XR3BFU0Q2NDJLQ1lIOWFRN3lpRTZLQXdOa2pkMEs1RVI0?=
 =?utf-8?B?V24vWWNtY0JMRGcyOGVqaks5V2twVXg4bmJKamZLeFNwdGFSRUc0UTZ3cUMr?=
 =?utf-8?B?MUhwbzFuSWJhZHo3ZndLV1JBN1RjWVdrN0JTdTNqRFlLUjcvQ1RlZ28vSEVE?=
 =?utf-8?B?U3RaMEJ4QWFMUVdFU2NRS285Ky9LMm85c2RKOC9WeXYzbGRQRmNINFRSRFl4?=
 =?utf-8?B?b2F1ZG5FUGdZTVl5RU9KUEd6RVJCa3YrNnlUNmhVeGlWRFluLzRaZ25NTEVN?=
 =?utf-8?B?RVE1VFBOTklMeGEzanlvSWNHQXZLaXhHeldQMy9JOGJWdVBsVkdhNjU3aW4y?=
 =?utf-8?B?ZWIxS2lTYXNhbFlPQlhmcTNBaFhuZXFnWVZJeklRaC8zVXZJakJPSkpoeHNX?=
 =?utf-8?B?aFpOcjJMTzNoSEM5QURWemkyem9JK0M3UCtQdENrUDlsRCszVG9EOEt3VG41?=
 =?utf-8?B?azNpQVRNUFh2aUErV3IzYmdIVXpmZm9DYXpmRU5OUHdxYU0yR2lIZ0FIdFRY?=
 =?utf-8?B?WW1QcmgyWWZmb3NmUkhRSmZqUnBZa0xpd2YydlpheVh3aHlFQnpCSUNXSCtD?=
 =?utf-8?B?MnlXQUgxaVJ5eDYvS0ZhQzlGbEw1NTZvNlhUaTdyNTZ5Wm0xdzMvTis0UENW?=
 =?utf-8?B?c250UlQwQzFNcW1tNzBKTGFqV0ttTG42OThCODUvSGZNRlRzYU4yT2pPZ3JU?=
 =?utf-8?B?SWRxendYeVRZUWd3Yks0a3pjMHpqaklRR2RhdjRWSmQxNEhwbFNaZ205dllY?=
 =?utf-8?B?dng3c00xZEVzOVlpQjQzaUNkNFY3d1NRellZL252cEJ5c2hVR0VCbHFZTHlu?=
 =?utf-8?B?bERwdWVjc2FtblkyWE9VZUEzNkxQTFVtUDBydHJRY1NhSTR2WDBoOWJWNHhv?=
 =?utf-8?B?K2NUTzBvWHdxVE5RMzFXdUJWS2x5Q1huVUhGcWFyL0xoL1c4L1JzNkMrN1Zt?=
 =?utf-8?B?UWxCcGtYWTdrWjFpZU40QnZvbE1xazFpazVaclE2TFI1TVZDelc2dER1ek5C?=
 =?utf-8?B?UEhxWFg2R2hQYkJMRkJvMjVKZVpCVnZ3a1VTVkx3WnlCMEJTTjRGYktwaUlX?=
 =?utf-8?B?WFYybEdLTkh3V1ZsZE8yWlZkajJnbmdiZGpsbFhZTy9oaG0wQ0N1U3FBREdk?=
 =?utf-8?B?OTduQVB1ZitKb1BnV3FXY0xkeFZaU2pza1V3SjRaQnltc24xblBJT2VKU2JF?=
 =?utf-8?B?dk93SDE3UmgwVFordkN4OGVhRFhHcjJpZGlkaysrNGgrcXBCS0J3TE5FRFBj?=
 =?utf-8?B?aGtJczIxVmlxWnBjYzJreG1CY3o5djRBRjJJOU5KWnA2NDRhZkpFUUpBVzBj?=
 =?utf-8?B?T280aFlGRUNuOE5aNzBlTm1SaFFRZmlGVmIyb2dqQjlCZWZPUzVyMU56eWdk?=
 =?utf-8?Q?g/3u6/ql1nG3rrZo=3D?=
X-Exchange-RoutingPolicyChecked: nFbSabNtCAghwYOXTUHuEKYjNjwS7cP7KiAKJgkQRrTNwiK1I2l9r9TloUm51QZAdCWuTJFH8jHFcHhsIoE9KoEBG1e5WIcTSOg4dCBAKETPRPzoMxwi+wC4RKHtVSmNno4Hk9HYPtYdcMXKzAllL6xJ+22aDAGa5ytW0V0N98PStx/G8mlcS7WK1XRxaM1uu5lLRfX6buO43skFHkuA+0Z4jcJKjzeN5n+CPxtZS94z2PoU7mfvpCPes8/K7BJ51N8a1iTuccmlyU/4BTud4hTMY8AwAsu+YIJgeAMDK5nTFhMGkhdQuCt/uF7um0qk7TydOjJHa2RAZRavGo9Lqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fff91741-68bd-4edf-aee7-08df081ca6a0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:32:05.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VR3lGn8c0oAkrH8mg9/iR/NcBSn95m0x8gbKPlrpM/MHPVqRxdS+rc4cJ4jQz623IM599TuG/GwUVKN5fOWuFdbN0T6ZdE16nAZX8tSeqr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9713
X-OriginatorOrg: intel.com

On 8/26/26 16:39, Tomasz Lichwala wrote:
> When an E610 VF is running under Hyper-V, the VFLINKS register does not
> carry valid link speed. The existing code reads speed from VFLINKS, which
> does not reflect the actual negotiated speed. This results in ethtool
> reporting a stale or incorrect link speed.
> 
> The Hyper-V synthetic NIC exposes the actual link status through
> emulated PCI config space at offset 0x209 in VFLINKS register format.
> Read and decode link status from there when checking link on E610 VFs.
> 
> To avoid generating unnecessary VMBus transactions on every watchdog
> cycle, read the PCI config register on demand when ethtool or sysfs
> queries link speed, rather than polling it periodically. The cached
> value is used by the watchdog and link state notifications as before.
> 
> Guard the PCI config space read with IS_ENABLED(CONFIG_PCI_MMCONFIG),
> since accessing offsets above 256 requires MMCONFIG support.
> 
> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---

next time please add something like "Notes for AI reviewer:" before such
notes :)

> Note on IS_ENABLED(CONFIG_PCI_MMCONFIG): this guard is kept intentionally
> for consistency with ixgbevf_hv_reset_hw_vf() which uses the same pattern
> to access emulated PCI config space at offset 0x201. Both functions read
> extended config space offsets (>256) that require MMCONFIG on x86. Hyper-V
> E610 VFs are currently only deployed on x86 where CONFIG_PCI_MMCONFIG is
> always enabled. If ARM64 Hyper-V support becomes relevant, both functions
> should be updated together.
> 
> Note on watchdog race: the mbx_lock serializes concurrent check_link calls
> so ethtool and watchdog cannot execute check_link simultaneously. The
> ethtool response reads adapter->link_speed immediately after check_link
> returns (same function, same thread) and always reports the fresh value.
> The watchdog's pre-existing pattern of caching adapter fields into locals
> before the lock applies to all HV VF types and is not introduced by this
> patch.
> 
> v5:
>   - Use subsystem device ID check instead of mac type to ensure the
>     on-demand ethtool read only triggers for Hyper-V VFs, not bare-metal

