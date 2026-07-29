Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665B4052CC
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365619; cv=fail; b=VRfXk/lcByX9nhmoxqswAJJk2fdWxnIaf7BTYmJCpLMQYKROb0XK6lCJRgXN7Ct30uG8T32c6FTh8Pm9R44ytXSdFuJXS9V+8zK1ht6b/MHGtc/mJxe0Hc8d5+q5WdQ+tNrsc7J7Fb948tD8B9uRVgsnCb4wiGN/scvkH9Hq3No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365619; c=relaxed/simple;
	bh=BY14EAPLg9ufBoOC0yBQtPtdm/PNTnfIao4MoPESTJk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CJTY4vY0fK2Sg2voTaOWuqUbmdP+NKMJWAumSmCGfGmRiNsOvV1/LgAu7P6i1iE6iscOdgdgdVxpXbTfHCqReh9fXSJbWbHk2J/Yn+07k9msJsCng2VyS/VHAiCnFb5yPcRUOa7NWmNOPxn8K0lDWrP4gz5Bsd23mkgJjNsZDAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVAb69vs; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVAb69vs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785365618; x=1816901618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BY14EAPLg9ufBoOC0yBQtPtdm/PNTnfIao4MoPESTJk=;
  b=ZVAb69vsYOhx8daAbLROmcOiX98sOk+tqHfmw7EdSb4MdggwKdklU4Fz
   D6kHCoxulwYM32pRQcMCu6nc/6nlzNC4qUDg3JeyqhP+fJjLfV8k0PhTB
   IqkEwwtLbOxvvK+005xnQlqPv1jfBmzdfBdSPlceMFm7E1Low4CMtnOyu
   pCrZjSvvJChqv5nkWBITyTF+jF/Ru+JDTr38dI+tOxy90uMDVhT9K6N6X
   kHlbWGjZq6LYMpeHm358WMnvSWgrpnJDmr4GDwJFRF+5fZPKrj8ujS2hK
   BK8EBPeQXQr4ojwGhLx79eWDkIExSXMHt9BWzNX9028J/dvo6FBv3pJ8J
   w==;
X-CSE-ConnectionGUID: RZ5NEsUBSxWKkp6DX3Iovg==
X-CSE-MsgGUID: qqayg3M2RIysvJAbGhzP1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103520026"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103520026"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:53:37 -0700
X-CSE-ConnectionGUID: fAdAXTSLSbOqY5iOWckzQw==
X-CSE-MsgGUID: WS3ofc++T7G+ev+xnFEKkA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 15:53:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:53:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 15:53:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuncOlpNrjIaOex4fWLT9bCFdOMUXQzHC7chszawfnLKc29pkPktqe/rM2ahEK4hAM6LhAJoXX0fPqTJovAMqokEr0tz/jD54zyRFkERyDfEW/FcJgKBTnBOgGsjwX9+IYeYZ246qoF5TL7OofjtiinldOExeMWqfq/JxDM3kQdUhPO1i/Lnr+Wgm58L4I3QrmFLPAdBkUxOxPh27GuUBXvCJKH6REvGktp9Oe3VU4GAR9s4xkeX5rqiSRef5FIG/jIhI+tvypZYtV1uDBR0lzBlTpGLd1QacVgPU3TcINoxX0sP0MOXU/DJPGT9ZZ6TdTATiZACQaHwfqCLFONJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbAWylkhsNuabyoDNvVr5jBOwWCSpGGI+uvw2b2h4bc=;
 b=Z5W5pI6kk5g7LS5LXbn+iQgpQABPrYNtenu8oOC6cqtJeXUd3TDAeQxRVtKzYdj1CFIzV5ghSZYvKLfkzEF7ENUVatMCP2CBx47m6xjdYnraVNaHC/wjdZIIY/nbly/Bz8b+1Fml3uYACZYErtmuXkTrIBm7XY8tUSBLkrlCPwO6vWtr+dJ1jKOKYS1Sqy93gyTisVaptDdVo/HyRoXu4xSU6lVraY9zvGM3/PTi1FXib9JMlclq+kuhZZc+9/UfMHTIT09MjRwKkv/UuBLCsMPQQGcOSwAOXzKj98T9GqH0dQGdvLs4ikEzQL87kwMCUjjO4EBeiqkdoB1W9Dm8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 22:53:21 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 22:53:21 +0000
Message-ID: <d8d1397e-db58-4027-b325-9333e01ef9c7@intel.com>
Date: Wed, 29 Jul 2026 15:53:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] pds_core: keep the health thread stopped during
 reset
To: "Nikhil P. Rao" <nikhil.rao@amd.com>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>
References: <20260727164548.359562-1-nikhil.rao@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260727164548.359562-1-nikhil.rao@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:303:8e::18) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MW4PR11MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c26e2be-2f6e-462d-733f-08deedc4303e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g2BXkNazy+21U+7B6nd59obZjwPy7a+uHIDb05YkaJ7r6OPL3Fm8heg8URMrdUKuHFP4OcdU5EH0WplEar3nOhdhDu7JrLUI0adhwfR5Z9B7ulAdlqsPykk2pu3DYrPa7n7djfmTCn3zbhioodKQaFBA72QzBJfj0uoU/abY1ULh/+Bnwgt7VBcsI4AcE5bZitqDgi11ZFpzrebXICogxSjmmwk9T/tOzvLJcaAIxJ6+yO7zg4tOcPQNmjeYkcPG2GnfCUrM1pAi5ZuuQ+002bvfrEcDnislgVWa+Hx0mhY4RLTJ1NRyKYq14Ulmu6nxtQUJPLgB614GVIi/Mu4Jj623fG7jKy12BW1xYXb9oLYVuC54+G9txlSxG/o5iqN4ldhES2ADcdwRodW7pJcSWoFtJH1v+Dlw5zqc8riyZgbpvJbhKMm3ZpyFFfaYSCH0apz4IBDZKJ2ihpaEJIM//q/e5QkATCgWwoqQQ8K8BuT+xRS/Cwm2J2Ch4rARBjRePtb7cnJXZZ82uLFq7rXRw8xjr47fE4+Ox4la6S6GEE8IAk1nMySTxxlTAv4FzH01yFwcDm7vQZgf2l9ZfiKi2bJIhG6VOuNQQVzzRnQj2tQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEw0dW5Xc2FBRjJUQWNOM0htMEdyREIzMWE4UDd2UW1NVWJiUGFxVzAwL1p1?=
 =?utf-8?B?UW4zd1NvZGxDN3hKM2J4K3djbGpqOXlWdFlmdUFrRWxuYmJSSXhVUzNLbm5n?=
 =?utf-8?B?eitlNW54VG5JRkVZeGpKaTI1TGNsTlVqcXVLaU9NWis5L1ZVT1lRbWlwOWR1?=
 =?utf-8?B?YVNZQnBtZEFyS3doM3ZMZUtjL1h1MXg1b2duMmVGbHcwQlRWK2ZvOHJzcjVu?=
 =?utf-8?B?KzdPMStSbHVUUm9WM0dZMzE2SWxOa3lEeFdidE0zZkRJN2dxUzhIQWRBUXgw?=
 =?utf-8?B?YlVWK2ZwKzExZmlEamRqQ0sxZHdQQUVYMlRkZlBHTUJuU2RSMlRCOFhoRW0w?=
 =?utf-8?B?Q1N1SkxPM1d6WnpsT01mMENqdysrcnFmeWFOVnppeGMyRDBmaHZRMkppQlFq?=
 =?utf-8?B?cHFRbmVRanRvdGplbE9pM1A3b1g5M0FQNEhJK0VPWndwajlMYmQvaU00bGJQ?=
 =?utf-8?B?Y2FIMlAzdlFzc29aTTJ3WXRpS0dFMnFhdHRWdHF0WEZXdHNMWXY0UGhKNitt?=
 =?utf-8?B?N2pYV0VsbVl0Y3VvVlphTmVqT2lUdWprRFI5VXA0SFRPWG1JU1RCVnVqd2xq?=
 =?utf-8?B?eEpOWk1jTUNQd0FlbkF3ZVo3RVNWL2ZoeTd6dUtBSGpwVU1KY0V5TnhwRFdw?=
 =?utf-8?B?dkZhRjhZaU16alUvem1tQzhhTGhzNWswWWplNFZjeWV3OWNNMU1wcEdLN3Ux?=
 =?utf-8?B?Z21EN095cGgwZVB2ME5sWTRFTmkwSWRkOUxjV1h6UUFkZlBnSHNUZ1BKWjdp?=
 =?utf-8?B?Q3BJUUNtRlJOVGdkeGRaUDVTUDNGamJUMWJKVjVxNHlFTDgvWFlMckpBS25n?=
 =?utf-8?B?VS85UUpNZGRacWVhZnVDLzZsUXBJc3M4V3VzSXI2STA4czRSZ1ovRVZQYUZv?=
 =?utf-8?B?OVZhUk94RTN2TVl3UitNYU1GZUpneWl3V2Jua2plNFpvSlUxc2g3RE5sWWdB?=
 =?utf-8?B?U2ozNXZjVVNXWkMreUhCTUdpOHR3Z2RjbEZVdXVWd001eDREUTZiM3o1T1Na?=
 =?utf-8?B?NnFOd2l3Z29Fd0lteHhRV2Q0eGF6RERudHBjNG9vNDdQTi9GcEJxaGdaV0sr?=
 =?utf-8?B?bGJPeHBOeVpZT1lKT1Y0dTJUMnlUa3FGb1RDMitvMUJxNVpTdWtHUHFBQjEr?=
 =?utf-8?B?OXRtQ2pzV1ZidFJPamsxb054L1dRczFsM3B4QzVyMitSRjhkU09wVWlQQ2R5?=
 =?utf-8?B?ZUpnQ2xHRDJEMFpacXdaeEk5TVY4TVJCaHZkWXA1OS9QcGkxaEZLWTB0Zlh0?=
 =?utf-8?B?bVEvZVQyWitBaEpKNUR5RytlekY4OEZ4dngxWkVpbUlSbzNyd1lLejIvYWVT?=
 =?utf-8?B?N2NOWU5ibDJFZUVqYjhVR1QzTndBS0RlMHhFMG5ualRTWGV6RGUxUU9FakVn?=
 =?utf-8?B?NmVJVUQ4VDA2N25wZGlZSkdJdTRsaXdUK3NPcHN2WTJzYTJ6MU5LeVR0WlRn?=
 =?utf-8?B?R1Q4L1QrTHoxYWovQXNuOFJJWGxCbFk1Sk5nNUtpb3Y5QlN0UEhVUmVpckVI?=
 =?utf-8?B?THFDK1ZvdWJKTGdvTjFqRW9nL0pPRTYrVEV4cStrREdxUFBuNzA1UkVxOFBG?=
 =?utf-8?B?L1hFZ3o3MVNqU2daV3hPUE9BbEFidHRYTDVKSEduTnVlYmRKT0g4RUE5c1Nw?=
 =?utf-8?B?eXMyOFgrTGJ2VXdKT2xFclpZdUYwUDMwdTU3SmwwVUhSWUpibTBldUU3WFJk?=
 =?utf-8?B?RkZaeUhtTWpZYkg5N0JpWHB5anl5NktrRDMwbnNTdzhUZ0xWM3J4MUFhbTEv?=
 =?utf-8?B?VXdFUlBSOTcwNkROOWJrdGpWVExyTUNQc1Axcys2eUFVTDhIb3hRV1o0OHM5?=
 =?utf-8?B?aTFicXVVRWM4ZnNpOC9odmVzV2tOaHVKVHRYdnV5ck95Zm1JaGg3am5TMitl?=
 =?utf-8?B?OVZ0UmV2MEd0dDZYNjZuU2xEempvRkU5YW40eWlES01PeDNGaDRtQzVqQ0xj?=
 =?utf-8?B?ZkRKcUJMSjdrNXBKbHI1NzQrdysxRFF2Z1FaTTFOOXZwUUV0LzR4ZWtIbjJj?=
 =?utf-8?B?dTkyVm5WUENXZ1R5dFpaOXMxU1FzLzc2VjFnL093dTBQaWZrOFNjYUQvZ3Bt?=
 =?utf-8?B?SnJac2hBZjdZSG8xbFZsVk5BTDhPNnZjZG9KcmFmdm00cW9zK204Q0UvTFYz?=
 =?utf-8?B?eGlZUFhaTE53MjQ4VWFweHRLUmdwZkxSYnB1dzUyMndVRHRPSlZ3SUlNVmpV?=
 =?utf-8?B?YjQydDN2U05VUUpLdFhhNTl1OGJDMzBSNTQ3dXpBRFpJckttSExyZmdaSGRR?=
 =?utf-8?B?MlJubzk0eURxSi9ITEhZbzJrdk5SWWFyTVFNT3pCL2NlVVI0YlY0dG5haVhw?=
 =?utf-8?B?dWVuNWR0NDJnWG9aV0p4SnUxU24xSThNOEJKU0FoNjlSN2hFdTZmaU9NUGdR?=
 =?utf-8?Q?q1XWjx8dLZk8E+O8=3D?=
X-Exchange-RoutingPolicyChecked: TMgm1vahhrD4IGIXX3pgoK9aHa16FdX8A8UDy7l2KuEMC9MkALrodcO0am73WLi2T3uxBR+XGjSLg2WC6+9/q7Sme/v+zjqHxZU3VSK8M0GZ8akr2PnrTFi/uMyJIQOQETYYNXTDi09VosXQGPMd5E5oZkDzObgfoXlEtgZFmxc3PCxpkO1Hd/bggPere/0RQTHPu2MnP14obNJ4AMVxsPVNgNNX1qnZAEcSV83xu0aeiCGx1m9bRQQGuKS3QHXnwnFL7N9H3NQorEH81u+yG0lQAYZWuUctd3ZDe5AlD2lsTZwLUcEeulcL6c8mrxkiaomtAL+5lLiCkSXwGcDApQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c26e2be-2f6e-462d-733f-08deedc4303e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 22:53:21.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glYXWZ8oWoVGZSu3NBg+KKkn8YxlaMf4qP4cyN0yr/hbzDUOLuWGYHI8aa+YJxtn47y+Ux8B33OzsOiYlkO3LKW0PGE4tUJyVbxT+V2IXzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com

On 7/27/2026 9:45 AM, Nikhil P. Rao wrote:
> Commit d9407ff11809 ("pds_core: Prevent health thread from running
> during reset/remove") stops the health thread with cancel_work_sync()
> before a reset, but a devcmd timeout during pdsc_fw_down() re-queues
> health_work, so pdsc_health_thread() runs again mid-reset and double
> allocates the core DMA queues via pdsc_fw_up().
> 
> Only the reset path is affected: on remove PDSC_S_STOPPING_DRIVER gates
> the health thread and the workqueue is destroyed.
> 
> Use disable_work_sync() to cancel health_work and block further
> queue_work() on it, and enable_work() in pdsc_restart_health_thread() to
> re-allow it after the reset.
> 
> disable_work_sync() keeps a disable depth, so every disable must be
> matched by one enable. pdsc_reset_prepare() stops the health thread and
> pdsc_reset_done() restarts it. On the AER path pdsc_pci_error_detected()
> calls pdsc_reset_prepare(), then pdsc_pci_error_resume() re-inits via
> pci_reset_function_locked() (pds_core has no .slot_reset handler), which
> runs the pair again - stopping the thread twice but restarting it once.
> Gate the disable and enable on a health_stopped flag so each fires at
> most once per stopped/running transition.
> 
> Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260629200358.2626129-1-nikhil.rao%40amd.com?part=2
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> ---

This version looks good and has no complaints from Sashiko. Might be
nice to include a changelog, from what I can tell v3 includes the
health_stopped flag now to avoid issues with double-enable? Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/amd/pds_core/core.h |  1 +
>  drivers/net/ethernet/amd/pds_core/main.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
> index b7fe9ad73349..a1d41329209f 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.h
> +++ b/drivers/net/ethernet/amd/pds_core/core.h
> @@ -171,6 +171,7 @@ struct pdsc {
>  	struct timer_list wdtimer;
>  	unsigned int wdtimer_period;
>  	struct work_struct health_work;
> +	bool health_stopped;
>  	struct devlink_health_reporter *fw_reporter;
>  	u32 fw_recoveries;
>  
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 8d94a4d70395..71a1d4b001c2 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -470,8 +470,10 @@ static void pdsc_stop_health_thread(struct pdsc *pdsc)
>  		return;
>  
>  	timer_shutdown_sync(&pdsc->wdtimer);
> -	if (pdsc->health_work.func)
> -		cancel_work_sync(&pdsc->health_work);
> +	if (pdsc->health_work.func && !pdsc->health_stopped) {
> +		disable_work_sync(&pdsc->health_work);
> +		pdsc->health_stopped = true;
> +	}
>  }
>  
>  static void pdsc_restart_health_thread(struct pdsc *pdsc)
> @@ -479,6 +481,10 @@ static void pdsc_restart_health_thread(struct pdsc *pdsc)
>  	if (pdsc->pdev->is_virtfn)
>  		return;
>  
> +	if (pdsc->health_stopped) {
> +		enable_work(&pdsc->health_work);
> +		pdsc->health_stopped = false;
> +	}
>  	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
>  	mod_timer(&pdsc->wdtimer, jiffies + 1);
>  }

