Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A64FD7B0
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667257; cv=fail; b=gufRYnVrON7LMMFAYGcB/mD1/X1cYdkg5AFOE4GxgnwF+s/GPoYEbRfxQH+uhEBFUF/Ewq5bReMs0hwgCaQrvlfRFWf5O+PLLtm7mrfE+YEvHrU8G0aUE3Hyf+SRryxfRcVEQfXFwOhE2vHds+HGsSQKAxvVyT48RARjOv9Rcpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667257; c=relaxed/simple;
	bh=nsbwCIYu0XlU2u2Q547++K9HRqKA2i5Elvpem2RHUig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZrIvegz5E8iQJ51Vhj+tWVMF2/D0uHgch209iknsVdORm/P0bl2hc3Crz8K4iVrvzlAU7OIOPskKj+5Kh3wrfHQEEsXTAksqw7QgZo6gqXlGMrz1eYi/kGxXh5cvQA9VNzLVvV2m4SYCU+uDxlQkVuXCt4m+ge1sxcysXcKwNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLnrOv/t; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLnrOv/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789667254; x=1821203254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nsbwCIYu0XlU2u2Q547++K9HRqKA2i5Elvpem2RHUig=;
  b=eLnrOv/tmAhstEcHzaPxQHG5NgW3DsoEmvCm53m3Td0x4RXki5cIsFLj
   vbxE9vJhrgo+43WTi0ssKN0Dch5NVQ+QMl9H99qY/GZBu/ew3HZwNADL2
   DwntzcO8vhm7ojMlozrimwHwbNwCwk+qP+Hu0xhVMS1Th8WGh6kRu7qrW
   sicX55IChEfaR+DO9C1VZJeDi7aUEfsxXoGhRIGrInXCR7OubeQtpnWSY
   d9wQoRfMynd705x2ckaXpmRnEDokgi4dxZ2sJ7vjV6X2grytqjCCjgxnJ
   jRPDPqbytTwR8E+0R+kFarYgODowKI+sQwEN2tgnp5MFeuWmCJXVzpRdh
   g==;
X-CSE-ConnectionGUID: umVqXlFMS3idCK5T2eLhVw==
X-CSE-MsgGUID: rkUxC/XoRVWbEcWRzkjoZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101465534"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101465534"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:47:21 -0700
X-CSE-ConnectionGUID: u28xMOjIQAGYCoxrHyLFyg==
X-CSE-MsgGUID: g2JgcTz4S3y4QWJ8pX7vtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2122408"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:47:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:47:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 10:47:20 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:47:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH8ntZYh3eMBW092J66R2xVsAH4imWDv4HHpF7ZW6QSKNzvcki/NIXv+valJ4jXMM22E9aBD/v+Qr49iFsyQZUKjZB5qGL8Sy/xU1z3ZTkOjarWUr1VofbcvstduBbM8sKjCAa7qX8LpEj1WBG2QsO4V3y8OaZSCLS0NwI3+5qLCSWJmL0hFV6mkerzsmFDQhe/TN8aFhuOx3kUrj1xb68wr7xkGA9MydyWLPVdb8ov+PccwCbrTy1oAqgmVYyUXRYnZbWkkQuQqNcRUVy19/1+9Cj9HNDP5noIBZO0nVIOJLXmb27chSBV4AJBmUWI+M2jxMhrYTBSYxwC1l7YKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWSww+yXYujt1q/JJXMgfzzFm5L7LYjAOuDzwCBryj0=;
 b=dfEhp9/lLse9jgO2dxGuJw+JYEHsA++KN4lRFbuhlw27MkdsrkW8vNccSPlBkkcWC8uFIqKdQfyjuAtVHPGuPc7jgsiAzzzSFXhoYyBALGv/UPjcgRoIeZYmuQQbgaZPAEXAm1rjOyx0pn14GImz40aP5tEa3mpqWswvpsNRcBABpy+7k0UXO8kCDoAKvmCxFTYIJAfqoSbVXUJ9vmojr9j6/8e1FqGblByL7dDIQMqUkpO1CTEOadYRUsvTbuPE1mIOfFSXXIqa+3k8P0kbZTMS9yM00pWeLaR+RggPbllpB7oE5+r13voRBX0FoymK8gPqJ0E8gajBS9c3eYQniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH3PPF37F43E35D.namprd11.prod.outlook.com (2603:10b6:518:1::d16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 17:47:13 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 17:47:12 +0000
Message-ID: <67c6e459-266b-40d8-bd84-772665a518fd@intel.com>
Date: Thu, 17 Sep 2026 10:47:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 11/15] ice: keep Tx timestamp slots tracked until
 completion or timeout
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-12-anthony.l.nguyen@intel.com>
 <20260916011224.1632730-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011224.1632730-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:303:8f::16) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH3PPF37F43E35D:EE_
X-MS-Office365-Filtering-Correlation-Id: 15304867-ea88-4f52-65aa-08df14e3b43f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|4143699003|56012099006|5023799004|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ge+WVOuX/Isro4h4l8mqAUTk7zdh0ZRtifSikszCtp7dAxyhTfsZf6oSpEnf8Zz2Y75lxyn9p+URzTzOauiiEziFIpEna2p3CyC9t05y8BbJLewWVFGKql04GJnzOrekc+XMdQjBfx7hrpjTLT/oXwjuWLF5tWnUlQtzdONFgdGc5lOugEC4ddhb3gCIAl3xOj0b12G1Shig9SwySdm2BtgDXJBTvbQee5vE4v/2xumHK70LtaB96EBdAqdnauL3qh2nIK9PRETbgMrvkt63Y1DMoyWuSWJRMVYkyYXUGS9C5Ok6y7aqQDAaokBWJEFf6Q4Vw5HJXh43bjLyhWkJCEivd33ViMjiiWh02BuvarrfCxw37k5IG2J6WuSKCijfA6rvolUwut2/kmsNVfecewHdz2ehGQ3pnI2Ycm/qZicHbwsjpLqHE5A2EijVkgiSLWVpreo54rQu+Xo/OBRUlwb6ykK70Hh85tJYW3WE10QbpgyyZ0U1bH8Q4wHaCP91NsT2lWC4dxt0B+GSaQGTVECwi+qIAQtghH+qnCBFO9y2DV+xJjLoqyEoQPe8ZVamK1yfDk5kznJ05rCWnKzT+8FIHcBQzrQVfrhGxvTe61NwPdpc8zaRHV+c8BO6S6fu+Kj1yYEv0RZyaxcQnzzBsRAD3fLq9+9rduyX0TUrQ5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(4143699003)(56012099006)(5023799004)(11063799006)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZMR1RBcGE5bVJuWENsVjJ6WTJwV3FZdFFlcWh4Y1VORVcxM3FQSXlUNTV2?=
 =?utf-8?B?N0RlanNHYnBJY3V5R0JSLzBFM1FJT3JRbDU5c1lqd0xwWExJRFd0bkloU1k1?=
 =?utf-8?B?OHdRNzQ4bi9lbEorNlFiU2xFYVUwcHQ3OHkwaEhBWHB3a2NGekExR1YyRGU1?=
 =?utf-8?B?MmlnWDRjQ0p4YVJoaWxDYmpHNVFSYUt1S1hvTkRlODZ2a3ZDK1BydzM4Um1S?=
 =?utf-8?B?VGwxWmhNRW9zam1QajBEa2s2c0hSQjI4SEtWWjNYcDFCRkZhUHFDVFBZOGZM?=
 =?utf-8?B?YURaYmswS1hjSUJiV3ZtN3gzMUVtaWFHaGViVlRreUY5NXV2N0JScCtWMUNi?=
 =?utf-8?B?Wnl4aWxmYWh6NTJTRXd4OWxTN2JUQi9ZMGczR1lkS014eWV1ejA2NThVQkpk?=
 =?utf-8?B?UkdGbVo5OERaaDlTUG43Z2NlVkQrZ0JvNE1KU2pmMVRWVzFXSEx6ZWUwRkxI?=
 =?utf-8?B?Z2JvMGFkUTBZZGxxSndCVDI4OVJ2UXUrQmxZcnlOaTk5TmZhM2k4Y3BrNlJW?=
 =?utf-8?B?SUZnN1Y0V3A0Yzk4MHdSWmNPYURwSDJCTWp0OUlVWjltMmxWKzYyS1VuMFAv?=
 =?utf-8?B?VnRHejBXd0xJY1RhRWNJZXFUYjJVSm5BYVR1VVBPRldtSjJwcjBnZ1Z6TEFj?=
 =?utf-8?B?MUJMOFVRY0dPbUhvcnFFUXVyMGNFVGxxZ0c4N3NWb1FCV0xHLzlxSHhva3d4?=
 =?utf-8?B?S0RVSHNJODNQZ202cGV2c2xld0pIWnJNbUJBNkl4THR6YjNBaUZqN3hRNzRw?=
 =?utf-8?B?QlFMTElBcXlJb0ZScG5pNTZiRHErSmJhaC94VjQ1bTNXLytNNkU1R2VwYWMy?=
 =?utf-8?B?QndreUZhb3JmUUo2cnViY3RGbmdCOTNaVUhWczNoemlpUVJ2V3VkL0d1bjVQ?=
 =?utf-8?B?OXBXTTBkV2lQanZCSTFGZUJndENlQUZGN2Z3V2FqQ0tHSFZmeDIrWUJ2dFRi?=
 =?utf-8?B?dHY0eGxVR0J1bnNOWFByaGl3WUI1dHJqaHhzQ0F6L0szNW1waXYvY1NXWWtr?=
 =?utf-8?B?WWd2N3FzL1VUU3VTYTk4bHlFMlRNSzN3UXc1K0JFUHRYQUtXUUVYb3JRWEMw?=
 =?utf-8?B?ME1XRllHdkI1VHdXWjdRVnN5OSt5c2tVL3VTVnJEaFU2WkNwTTlVRzQvRElD?=
 =?utf-8?B?OGZHLzIyaHB2N2wyWGFrem85LzdYcktQOXA3NkxnNVFiRllrNzRKTnRSaFpS?=
 =?utf-8?B?V3lsNElBQWJsTzJNK1hVeVNzY0w3STRhYmMzMXRGZjdUSm5xWmZWK0JvRTZL?=
 =?utf-8?B?NkplNVFzSUppU2h0dG1tbzI3U2lmbWJ1SXdad09CVTFsMkJLOXFVMXg4Mlpm?=
 =?utf-8?B?YXhQTWVjam4xa0crT3pKdkNkUjJSaXlXZTJzL3JnOVJvWXFZUVBPalUvS0hj?=
 =?utf-8?B?VTFwcWlSazFXQW0wbVBIZXo1VFlWUXJsdmFyWk5xanFsejYyNTczZVZ6Q2l6?=
 =?utf-8?B?QXI3Y0FmYjNuOElzN1N1NzJBZ2VJSDl0cjFyMEcyV01CSHpXM0ZQN1BSUUpK?=
 =?utf-8?B?bElHaFhYdjFlektua0JiUzJ1NDNEYkV2ZFZ4VTNTcUVUR215WDZHVmwvckNL?=
 =?utf-8?B?YzRDWCswTDJYMFE3M1ZKVWN4WVJ0cUlObStabmQ0UnNJMjdsVFJrWEE3S0d2?=
 =?utf-8?B?cUNyMlgrbERDUTYvQjgyaTZidjN4NWdzK3Bxb0VISXhSMXdaNUhNMnlocFRi?=
 =?utf-8?B?WUpwTGRFZmU5TGluNlhLTEtja093T0lXbWY1Q1Z5L0s2T1FhUzBGT09OL1Zx?=
 =?utf-8?B?YkZ6NkNRdGw2TUpXTnZ2Y1pNZUJ4YlU3b3NIaU5Sbk5PUXJURU9WV1NmVkVE?=
 =?utf-8?B?cWxRRkV4NDE1KzVOZHZSQng3cDZIYmw0cm53OVA5clNNOWQ3aDQwRzQ3ZDcz?=
 =?utf-8?B?RUhRLzNyM1BuVWZjQUFyZnpzdlV0aHlFWjk3YXZlWHU4eXBmYUpUSHVBWGM4?=
 =?utf-8?B?N0tpMmQ4N3Z2QUlyK0NKZUpGUU11SmJKL240Uk41blpYN2dMZzNlM2M5WVhF?=
 =?utf-8?B?SnJDWDZJRk1vNzh5cml3cmxkYm01U3Z0bVcyU3VpUW1IYzRrUytQTUxCK1Nm?=
 =?utf-8?B?QWVRYndNellZT1ZCektkSDhCeVo1MldObDFEWXg4cHI3KzZvU0l4Zis0aWpE?=
 =?utf-8?B?YXlleVhRaGIrZm0reEhRdWJadzlyL0NjS0VuK0M5a0pTK0libDBkNnI2azZy?=
 =?utf-8?B?c3hjVGRCYk9tTk1tc0Z4VzFpd2I5QXFwbUJWWnpWS0VMZGg5anh2SVp4dkVi?=
 =?utf-8?B?aWpPY0FFamtsRm9HZTdVbDdZaXhLa3hwbUNVaXJiZWJFL3IxdTdGb3RxTENq?=
 =?utf-8?B?MUdlczZiUHZvNzVpSmNmT2d1eEtYTFNmNjdHTHZncmdaREFpTWxXZUJKN1h5?=
 =?utf-8?Q?k/7LUj9XzKz3Rtes=3D?=
X-Exchange-RoutingPolicyChecked: uHp8+xFBri5pIBkbFc/iMBRJ/RbjCHW7raZNzXFUET45GXxtOeltQ9gn/podE5LZBbZ5r1Lg8DZ0kbo6Uljkn9iIrV6GteOlCi+veoNg5Z2hqOPDStfLUfomHIGsdicK4ZMX++JKoeG4xNov3Z0tfH3TBXUFVsTdSNkgsRsoNzHE8hCDQPT3Hq3dQrsf/PcfUcnjxTsYDVkIKH/hKb5n5Iat3qYWNt8wcWGPf7sy7VxT89e1yB9MQRSCPJN81BUXlP0VZNKsAoSCBqI4Voskjrf0iROCYDdBHcyD1moxZ6vEqdsRbnjtkqbBH4hrUSnyVBx5Qi6GEGHkwtJKEaf1xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 15304867-ea88-4f52-65aa-08df14e3b43f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:47:12.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVmsYavA1osJeUzYCUdeLuiMTeTrYcCaY7iY8rEtYmAOeDDPB0FKAkWmMTqRg3KRToHdnJuZkJ0s6kFWWZlH/wtduO5kNOu5tb1VYrLN9ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF37F43E35D
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: keep Tx timestamp slots tracked until completion or timeout
> 
> Instead of dropping every outstanding Tx timestamp request when the link
> goes down, the outstanding requests are marked stale, new requests are
> rejected while the link is down, and a not yet ready slot is only released
> by the two second timeout in ice_ptp_process_tx_tstamp().
> ice_ptp_tx_tstamps_pending() gains an in_irq argument so the interrupt
> re-arm path ignores stale slots while the periodic worker still sees them.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index f32041dd8b274..d12952171a991 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -3248,7 +3248,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
>>  	ice_irq_dynamic_ena(hw, NULL, NULL);
>>  	ice_flush(hw);
>>  
>> -	if (ice_ptp_tx_tstamps_pending(pf)) {
>> +	if (ice_ptp_tx_tstamps_pending(pf, true)) {
>>  		/* If any new Tx timestamps happened while in interrupt,
>>  		 * re-arm the interrupt to trigger it again.
>>  		 */
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index b142b779dc105..299de9d494233 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -364,9 +364,12 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
>>  static bool
>>  ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
>>  {
>> +	struct ice_ptp_port *ptp_port =
>> +		container_of(tx, struct ice_ptp_port, tx);
>> +
>>  	lockdep_assert_held(&tx->lock);
>>  
>> -	return tx->init && !tx->calibrating;
>> +	return tx->init && !tx->calibrating && ptp_port->link_up;
>>  }
> 
> [Severity: Medium]
> With link_up now part of the tracker-up test, is the E825 PHY restart path
> still covered?
> 
> ice_ptp_link_change() sets ptp_port->link_up = true before it reaches
> ice_ptp_port_phy_restart(), and for ICE_MAC_GENERIC_3K_E825 that function
> calls ice_start_phy_timer_eth56g() without setting tx.calibrating:
> 
> 	case ICE_MAC_GENERIC:
> 		...
> 		ptp_port->tx.calibrating = true;
> 		...
> 	case ICE_MAC_GENERIC_3K_E825:
> 		err = ice_start_phy_timer_eth56g(hw, port);
> 		break;
> 
> So during the E825 restart ice_ptp_is_tx_tracker_up() returns true
> (tx->init && !tx->calibrating && ptp_port->link_up), and
> ice_ptp_request_ts() keeps handing out indices while
> ice_start_phy_timer_eth56g() walks the Tx timestamp memory and soft resets
> the PHY.
> 
> The window is also reachable while the carrier stays up: ice_link_event()
> continues past
> 
> 	if (link_up == old_link && link_speed == old_link_speed)
> 		return 0;
> 
> on a speed-only change and calls ice_ptp_link_change(pf, link_up) while the
> netdev is transmitting.
> 
> Are the captures requested in that window simply lost until the two second
> timeout, and should tx.calibrating be set around the E825 restart as it is
> for the E82X case?
> 

Yes, I will switch E825 to hold the calibrating field over the restart
which should fix this (and other comments mentioned).

>> @@ -563,7 +566,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  	struct ice_pf *pf;
>>  	struct ice_hw *hw;
>>  	u64 tstamp_ready;
>> -	bool link_up;
>>  	int err;
>>  	u8 idx;
>>  
>> @@ -581,14 +583,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  			return;
>>  	}
>>  
>> -	/* Drop packets if the link went down */
>> -	link_up = ptp_port->link_up;
>> -
>>  	for_each_set_bit(idx, tx->in_use, tx->len) {
>>  		struct skb_shared_hwtstamps shhwtstamps = {};
>>  		u8 phy_idx = idx + tx->offset;
>>  		u64 raw_tstamp = 0, tstamp;
>> -		bool drop_ts = !link_up;
>> +		bool drop_ts = false;
>>  		struct sk_buff *skb;
>>  
>>  		/* Drop packets which have waited for more than 2 seconds */
>> @@ -1371,6 +1370,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  	if (pf->hw.reset_ongoing)
>>  		goto exit_kref_put;
>>  
>> +	if (!linkup)
>> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
>> +
> 
> [Severity: High]
> Who runs the processing pass that applies the two second timeout on E810,
> and on PFs that are not the source timer owner?
> 

In theory the idea is that we would clear the timestamps once link is up.

> After this hunk the stale slots are only released from inside
> ice_ptp_process_tx_tstamp(), by
> 
> 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
> 			drop_ts = true;
> 
> which requires something to schedule another pass. The candidates all look
> closed on those configurations:
> 
> ice_misc_intr_thread_fn() re-arm now passes in_irq = true, and
> ice_port_has_timestamps(tx, true) returns
> bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len), which is 0 for an
> all-stale tracker. The hardware fall-through in
> ice_ptp_tx_tstamps_pending() does not help on E810 either, since
> ice_check_phy_tx_tstamp_ready_e810() is:
> 
> 	static int ice_check_phy_tx_tstamp_ready_e810(struct ice_hw *hw)
> 	{
> 		return 0;
> 	}
> 
> The replacement periodic sweep is not reached on those devices, see the
> early returns in ice_ptp_maybe_trigger_tx_interrupt() quoted in the last
> hunk below.
> 
> No hardware TSYN_TX interrupt can arrive either, because the packets whose
> captures are outstanding were not transmitted, and
> ice_ptp_is_tx_tracker_up() now rejects new requests while link_up is false.
> 
> Does this mean the index and the skb reference taken in
> ice_ptp_request_ts() by
> 
> 		tx->tstamps[idx].skb = skb_get(skb);
> 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> 
> stay held for the entire link-down period?
> 
> There is a second effect worth checking. Requests are still accepted
> between the physical link loss and the firmware link event, so the tracker
> can fill up (tx->len is INDEX_PER_PORT, 64, on E810). If every index is
> in_use and stale, does ice_ptp_request_ts() then return -1 for every packet
> after link-up, so no timestamp is requested, no TSYN_TX interrupt is
> generated, no processing pass ever runs, and Tx timestamping for that port
> stays dead until a PF reset or driver reload? ice_ptp_flush_tx_tracker() is
> only reached from ice_ptp_release_tx_tracker() and the clock-owner rebuild
> path, and ice_ptp_link_change() returns early for E810 and E830 without
> flushing.
> 
> For reference, the E810 low latency read sub-path does not appear affected:
> ice_ll_ts_intr() -> ice_ptp_req_tx_single_tstamp() keeps walking in_use on
> every LL_TS interrupt, so the timeout still fires there.
> 

The intention here is that we effectively block new reqests once
software knows about the port being down, and any old requests remain
stuck until the link is restored. The tricky part is that we really have
to be careful about making sure we do not release an index until
hardware is either done or we are (relatively) certain it will not
happen i.e. because of the 2 second wait.

The watchdog should be triggering an IRQ, but if we exit the timestamp
processor function because link_down then we won't trigger the check.

Given how complicated it is to track the PHY time counter behavior, I
think its important to wait, and I think its acceptable to hold those
until link comes up, at which point the watchdog timer should be
re-checking and arm the IRQ to drop timestamps.

>>  	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
>>  	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
>>  		int pin, err;
> 
> [ ... ]
> 
>> @@ -2767,28 +2769,29 @@ void ice_ptp_process_ts(struct ice_pf *pf)
>>  	}
>>  }
>>  
>> -static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
>> +static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
>>  {
>> -	bool more_timestamps;
>> +	DECLARE_BITMAP(tstamps, INDEX_PER_PORT_MAX) = {};
>>  
>>  	scoped_guard(spinlock_irqsave, &tx->lock) {
>>  		if (!tx->init)
>>  			return false;
>>  
>> -		more_timestamps = !bitmap_empty(tx->in_use, tx->len);
>> +		if (in_irq)
>> +			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
>> +		else
>> +			return !bitmap_empty(tx->in_use, tx->len);
>>  	}
>> -
>> -	return more_timestamps;
>>  }
> 
> [ ... ]
> 
>> -bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>> +bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
>>  {
>>  	struct ice_hw *hw = &pf->hw;
>>  	int ret;
>> @@ -2808,11 +2811,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
>>  	case ICE_PTP_TX_INTERRUPT_NONE:
>>  		return false;
>>  	case ICE_PTP_TX_INTERRUPT_SELF:
>> -		if (ice_port_has_timestamps(&pf->ptp.port.tx))
>> +		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
>>  			return true;
>>  		break;
>>  	case ICE_PTP_TX_INTERRUPT_ALL:
>> -		if (ice_any_port_has_timestamps(pf))
>> +		if (ice_any_port_has_timestamps(pf, in_irq))
>>  			return true;
>>  		break;
>>  	default:
> 
> [Severity: Low]
> This is a pre-existing issue and is not introduced by this patch, and on
> closer reading it looks like a non-issue here, but it is worth noting for
> completeness.
> 
> The commit message says the in_irq filtering avoids an IRQ storm, while
> after the switch above ice_ptp_tx_tstamps_pending() still falls through to
> the unconditional hardware check:
> 
> 	/* Check hardware indicator */
> 	ret = ice_check_phy_tx_tstamp_ready(hw);
> 
> A PHY ready bit with no in_use owner would therefore still make
> ice_misc_intr_thread_fn() and the ICE_MAC_E830 branch of ice_ptp_ts_irq()
> re-arm PFINT_OICR(TSYN_TX) regardless of in_irq. Such an unowned ready bit
> can be produced by the timeout path in ice_ptp_process_tx_tstamp(), which
> clears in_use without reading or clearing the PHY slot:
> 
> 		if (tx->has_ready_bitmap &&
> 		    !(tstamp_ready & BIT_ULL(phy_idx))) {
> 			if (drop_ts)
> 				goto skip_ts_read;
> 
> That release-without-read is unchanged from before this patch and is
> described as intentional in the ice_ptp_process_tx_tstamp() kernel-doc. For
> the case the commit message actually describes, a stale packet that is
> never timestamped, no ready bit is ever set, so the hardware check returns
> 0 and the stated goal holds. The remaining hardware check is also removed
> later in this series by "ice: don't clear in_use until HW clears ready
> bitmap", which makes ice_ptp_tx_tstamps_pending() consult only the software
> tracker.
> 

Right. I can try to clarify this. There is always "in principle" the
idea that HW could hold a packet for >2 seconds and then complete a
timestamp. In practice this should effectively not happen and if it does
we have other bigger problems.

Ultiamtely, we have to choose some cutoff to allow restoring indexes for
timestamps that hardware never completes. Without some mechanism to
check, there is really nothing else we can do but wait.

However, the original "drop when link is down" does not work because it
leaves open too many ways we can re-use an index.

>> @@ -2918,7 +2921,6 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>>  {
>>  	struct device *dev = ice_pf_to_dev(pf);
>>  	struct ice_hw *hw = &pf->hw;
>> -	int ret;
>>  
>>  	if (!pf->ptp.port.tx.has_ready_bitmap)
>>  		return;
>> @@ -2926,11 +2928,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>>  	if (!ice_pf_src_tmr_owned(pf))
>>  		return;
>>  
>> -	ret = ice_check_phy_tx_tstamp_ready(hw);
>> -	if (ret < 0) {
>> -		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
>> -			ret);
>> -	} else if (ret) {
>> +	if (ice_ptp_tx_tstamps_pending(pf, false)) {
> 
> [Severity: High]
> Is the new in_irq = false check reachable on the devices that need it?
> 
> ice_ptp_init_tx() sets:
> 
> 	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;
> 
> so the first early return above skips every E810 PF, and the
> ice_pf_src_tmr_owned() return skips PFs that are not the source timer
> owner, including ICE_PTP_TX_INTERRUPT_SELF PFs on E830. Combined with the
> suppressed re-arm in ice_misc_intr_thread_fn(), does anything on those
> devices ever call ice_ptp_process_tx_tstamp() again so the two second
> timeout can release the stale slots?
> 
> Would moving the ice_ptp_tx_tstamps_pending(pf, false) check ahead of the
> has_ready_bitmap and ice_pf_src_tmr_owned() early returns give the
> software tracker a guaranteed sweep on all configurations?

Yes, I think that would address this and the above comment.
