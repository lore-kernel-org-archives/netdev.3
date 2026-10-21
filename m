Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792605262;
	b=LKIrHCXrEsKKfdGzumvr8WtWg4HiI74ZQeBzS9P5Roy1XGROOC385x7dQ2SSV0GxfUyG
	 M9+xwA/6Z22OK5VyXnT03D/Rs+HE9oyHP0kC6gqlZlfGccoVPcLznZaN4xWc0nwgq5xez
	 ZQsnJAcQ30igHQ4pyEiCE9syKwq+jN624MTtjF3Rf9zvQPZebsNSLF1OjuMtV3rCA6Bj8
	 YjZM2a1bTMjJMQ2kt7n7r0gdG3QJ9MaKmius5n2RdGZ7+cbBrdvRkZP0nFsPCk1LT0CFS
	 jl7KO+pezzHkjPwDXaLZHJdbmWThsZODZW7Pj9XdcjPOnBev1Eai7DbdyDmNMJVVecQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605262;
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
	bh=8reURGg89Cw4PDJKuYEZD3wk+fooIE07d4b7KbatlDw=;
	b=o5bvmPZriVmo15aQgf9uCuCh0z0uLVThZ7rj09s+aRQeZvk1xtEpx4y6Q9eKCYYzra45
	 LafnOf4k/mYZOjuuL0CMgmKXM0zW1E1zcRVgFBstrkyfMEyel9rZ1M2btOfPjQyo9pXvI
	 HXT+FJPp9lj6NSIIaI+0xjbREP7tl/BsX+Tr8dE/47x42L1M/hMtOZ2ZEeW5zHUnIpCZc
	 K8XOP9UUYym47eppb+nDxOcnYh8Hc2+Rt5fGlBBeZ7PGc5nFw3t9m+BVBbIvveDuoe84X
	 kGKAQHG4BXD/Y4xcTYcyrZnDFwQtGuWtXcB58bCYR2mKAnlV2OE0jm0v6HV+KFQ/vdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kLJE0aSx;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA87606A319;
	Wed, 21 Oct 2026 17:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACA87606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kLJE0aSx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792605256; x=1824141256;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wWkMcMOMNLFuLDPVxdV85lqtPUj2l1MjH+zQDSyzceQ=;
  b=kLJE0aSxR1YsSwbZFzOXFOyl1ADd4fxzIFpLtY0tUzKnO5sI8SxIQWxL
   qpHDINe93Qo0psfrDSHDb6Qil7i9TwfMMd5V768/A6ftzzQGWIy3EpiDO
   5Vcepl079J/MfwpsL386tb8CjHIIyOUecVC1pP6qzxNL3vZqheLNkRP/Q
   rNpReoLZFujdNoRZVioxYp2ZFPT6SOug1Q3GoBiniNvagolfV2ibwu/xA
   IlgEJBykBPQeT6yPdjX1BBF6Ct9D8m7fN3v8Vt+OKLxLoC85Bqy9WqagQ
   5qOdYmxvjCFGrBd1rZD+VId2ocBxjtUTCn9jElnxNAYe+ZEf1OZ6KXmRy
   A==;
X-CSE-ConnectionGUID: PKxiVY7vRgiXtbzY2K+iOw==
X-CSE-MsgGUID: 7ebR9dnPRFuQ9fYwA1kGJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1348558"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1348558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:54:15 -0700
X-CSE-ConnectionGUID: FCVCn/LPSqOKmkQ+ZfnhYQ==
X-CSE-MsgGUID: N6dLOmZSSMu7gYLwHhVyxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3503573"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:54:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:54:14 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 10:54:14 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 10:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeNkThPWZw5uSlmwkg9/3EL23OCeQyMosJ2KWWn5VGpDdhRSbE6MTlNL7KcgNivlTRFPHb8HlAVYP2DRryFA5vFsLur9BSLik3jzt4EZwe1VRQetpTib7AveGojtOlMs9gDIHpRi2KvNujTf/G3fGxvqxy/O0+1qNmwj+3XWXTyzGx5Nokp/AcMpHW18WTXqdLf54xWOlreoKbvyUOossqbsEGBsbCBeKgG/68sDE8fjrqUL30sa0QXQuFAsb72eCQvC+YuhZ8GjPYdAMkEMoqzYFFfbZQvMAsASRFzMJv06de8DsAwjRv/TW3K2qvmubZ5ZlIXhUNrivNR8b7kn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8reURGg89Cw4PDJKuYEZD3wk+fooIE07d4b7KbatlDw=;
 b=KGjn9G3tP0jxmFkB052+iV1x1EteTMnIoBpaEPlomLh7bSSzhk54kX/QjRAVT5kdnBqP/WlM45F6Ss1ryizzVd2AwU3wvG1NJIHrG91uTOMJ2cGts3Yiw+3NCG9u6j/JbbsRrzLnWPzhher9Jc1mg3kDyfCoevtA/xIEiUXz9MgN1I+PabAUntAqfR5gkLCuFv/Uu5qJBecfieOGO3NKFXGu8H0cCt2cXTk3e29/gjBuYn20FVt5tF/X3X8iJknds9KHmv4AdTZM4pJqlgTvhM34gvoR4Ox/S17uI6J8jG8qIfAu05g8bquPZAocrygwn/k3SYM9mmOM8uasMWt6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 17:54:09 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 17:54:09 +0000
Message-ID: <105bb3b8-7c9e-45d1-bbd9-b35134c969e4@intel.com>
Date: Wed, 21 Oct 2026 10:54:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261012082910.283229-1-xiaolinkui@126.com>
 <2b9f2117-1bc0-4d83-a30d-1c8f7b295ab2@intel.com>
 <62b3a378-f911-4c2f-85c7-53aa3f51ee43@126.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <62b3a378-f911-4c2f-85c7-53aa3f51ee43@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:303:86::23) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 956299f5-6720-422d-e94c-08df2f9c4ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|261009223027099003|261021121427099003|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: AdGEWXUXjpcBIwqRGRubDFgsUSXSZ0g+MfvJbNNUHOk+4KNbSxDuoScGnRzRt4UJlrORh9DVf23RbN02rbMQXPzU41A2FF5fQ4Om3MfaX9CMulwmAoW5LGz6DWR+hDqOLpypUNASJahbAsFkRfLAq0rxKhd21pkrp2ngcnAzlb/NaeFOYVMVqyoCC1TgbUfS6qo0ojp7VVnaYzMZdduschXP8ivv5Mp3poGgjvC+flUCWCmiQVEspfqe2fRlxssl6UV1jRgSTfsvs6HL+G7NMqb4rPGq83SvlMhI/VN6QclETy/Sl2ElNxibX2Scr7M7lVryJWJnu1spfI7+AEH9rTpn88ny/u8fDCDzkcUGcOKF/T2Rk1GdB9YxrdIpPavaOZ0ZFAykNVDd5cQMajdQMqZqvyxft6Vn4c2RlGHHJq1HEyxzMwI9NzdgfA63PnpM3J0yV4aLlIsfY70GpO3hIAjD3RFkkMnMUmDSpq2QazNym0Ec1uIrm5ANwk6sWd1pA6iTzHYuaGm3IXOw+QJRbzfaucFrlT4mWRwsGFAGNXCzfdYaNLoKHDpPWv6cBg48fZ0D4KW2tlpyXIOx3JW+hassBWHOg7K3nZ0jusHSUy2v9TiJwGJTTGF30gkHgcel
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(261009223027099003)(261021121427099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTVYajJXSUFKNzMxN3EyZCtCWlh5dnRFdlhLUFZ6MTRDbG1Ra0srV2tjWHpE?=
 =?utf-8?B?bUc2S2R4c1E3eFdSOUNOejdDMFFxWU5ISmZzT0VYZ05EbmltTVpMakU0LzJx?=
 =?utf-8?B?OUM3NnM4ekllb2dNMGJWU1FlQXYyN0VlRzFKQlRoQXluNjhZeWtRZWtvaWo1?=
 =?utf-8?B?TlJ3YTl0MVY2OUlVSTM1N0hOKzl0S0s4UzVESzQ0RmpVby9QeDZGa3o1bUhT?=
 =?utf-8?B?Tzh2UGJVZ2tkd29BSFJFVnlKbStQUnkyYmFIWGNpV2p0VDBIKzcrcGRMaXNY?=
 =?utf-8?B?RUxwdHlQVFVPaWFicUhlUGpnR2dhSjNkY3VtYWdDVWN3VzJ5NGM5RzZXMG5E?=
 =?utf-8?B?bWJPd29hZWdnd1ptVURodkJlQjVlb0hoSis3ajdzQ1lPZ2V0K2RjRlRmbkFh?=
 =?utf-8?B?cXFpWmNReXZSNnhUMElMd0NWak5yMEFxTVo4QkhKS2VpcjVKN1FPUEw3Sk5D?=
 =?utf-8?B?VzJJK0NoclJjQXUwb1c3QzBxWS9ZRHQyQU1lc0FUWWQ0UGhzQml3UFBmL2h3?=
 =?utf-8?B?K3Ryam1lQkprQ05DUWpUNTRxVkM3dVU1RE4zWmJCVE41NE4yaXlueHB4QUVV?=
 =?utf-8?B?ekNING1EeUY0SU8xUHcvQlFFeEZjZnkvNDhWWUtSWk5QTDVrZUsweHBlM1U1?=
 =?utf-8?B?dC9jR1R3ME5kVENWdTIxaHlYWGNpNkVTanQ3SEU3MjZVc2xBSTFNeDUzLzhM?=
 =?utf-8?B?S0ZIWkQ3WHErTmZQcExTclB3cE1kMktBSTJ5eUl4Qm10TDcyNVkyaUlGczJM?=
 =?utf-8?B?SWMwNi8xQjlxVjQzTVpkeDBPa3VxZCttZnRLSzZRcENrUHVURVVqNXRISjMr?=
 =?utf-8?B?T1IwNHl0dUJiSDgwbzdyWnUwVWlQcEp1SEVuQ0VFREg1cjhPa0tNcnBKYjR6?=
 =?utf-8?B?cU41b0JlRHBFeHVNbkpOZUJsQ054T0hjY2FEVS9xWTd0MHZSdWhDeUY4Ykkz?=
 =?utf-8?B?Z0Q0VGJjQ3VueE9QemRvdFJBL2dLNUFKTVJGMDBPeFlwOTBCTXFGQUxjMFVK?=
 =?utf-8?B?ODFhRm4xWEp5ekFDSmE1cUVTMi8zWFl5eC9SN0taVWozRjRqeFF6NVZBaW0v?=
 =?utf-8?B?eGV3MDFINExYd3NxNVJEVVdlcTgzSzFsRDNNODVOVW5pLzhLTFBBclNlaUkr?=
 =?utf-8?B?U1FqbXl0bXVtSzQ0QlUxNjM1WkszZzNXRW56dU8zZ0V6QTQ3SU4wMkliNmY2?=
 =?utf-8?B?N1pqcGRQQWllV29ZUnpURDVEb09DZ2Q3ZU9KWDl6c2cxS1RPcGdCZlhHcXRz?=
 =?utf-8?B?ZVBydGVCVmdYRUhKRjhGWGYxb0JmR1ZrT21BRGgxUVlyWFNESlNMNmlFdUkw?=
 =?utf-8?B?MXhKMml2NDFvNjdQNjNKSm90emV3NFpKZnA5SDBjSlM4cVc4cXVPUS9nejdL?=
 =?utf-8?B?VVdQaEh4aXBUTmU3aitPZ0VxMlh2eFhGMDhpTTkxakR5VERhTDdyS2JyK3Ro?=
 =?utf-8?B?NU5EeGtoWXNrbTM1SDJTZTZQNmh4bFV6bzFhL1F3UGRLRXZwWVhuZ2xjb1U3?=
 =?utf-8?B?eTBUdlR6ekt4bnNWN3VZcS8wa3o3SE1qVTRwS3dTaUJkcXVBY2JCdTFISmU5?=
 =?utf-8?B?WFRNdGdtcUFTZDZTK2tDK3ZnNmtvSDJ5cEZZMmJqQlYzclNZVFZONmtyemNy?=
 =?utf-8?B?bXdBdHVtKzNxSmRzMWlTV2RPV3U5VmpWZGlncGdnKzVYcGpNQ3dsdkpXU3BH?=
 =?utf-8?B?RjdwbkFIMmRsUFY3enM5SHV5Q3ZNMXljSHJvZjRJc2RaQjM0UkRFTlJySG1E?=
 =?utf-8?B?dFo0dzV0akpuUHlHT2E2RDRKUXVDRHpvS1hGeGd0MHhZSFg2Znl3L016Mnh5?=
 =?utf-8?B?QW9FMjNqWTJSUnhYbDl2aW11MUQzK1FNZ0ZUbXZzMDVFMlF5MzNKTllreTNB?=
 =?utf-8?B?Vi9pYnllc2dLZUM1b2ZpLzlTZmxmYUVIM0g3MmVlNEdiTi9jM1lKNXdibGRk?=
 =?utf-8?B?UnZqM0VHS3lqeWtPcFE3YVlJZk5sMkN6WEkzZ2VSOThHcFp6SVlDU1M3N28z?=
 =?utf-8?B?WmZWVmFiNDYvZC8wRXRCU0p0UXAvcDd3S09xNFNrZHpFMFFiQWw0ODRVRGZp?=
 =?utf-8?B?b1ZubDRYSW9nZjBCUDdTdVptUXlKb0VCeTRsN2J0ZFozYTkwcm9FTktOL1cx?=
 =?utf-8?B?WW1BNUlhVjJjNG1BcFAzT0g3bDlqYXgrM2kyRnNrYTMreHp1OGU2cXBib0hi?=
 =?utf-8?B?ZnQ0Q05ra0dBRXNlWEc5NkN0WUxDRW1Fc0dDcnZVR0g2Q2VaeVNKQ1pIbExh?=
 =?utf-8?B?c09GL0Mvd3NnNG41Yk04eDZJcFQvUEZLYXBKOFFuS2ExRCs4QnBCNzRpdUFa?=
 =?utf-8?B?YWtjNzJ0bHJYRmN1WjRwMXZOQ096T2lCVmhXZEwrbk85UU5Od3JvQT09?=
X-Exchange-RoutingPolicyChecked: YyFrBR5/3aPnFVjqBpvL752AHw8lgBGAj5NkxMcEs1g/w1r+Gw5iJeKntBcNDPk2VCI45Gw5UpKgs744gVmwgwW7Og7jj7SZ3dpHkV7JbiV53QwjcGmwJwV6RZKjtFPIgh42vExLFZ8Eg0bfLTK/gbeRlgjIbKd89YytE+vYrLMAy3AflHcZQy5U9eJijJhvmP1cjGxWWAO95TCdWFISz8Vicowpyp4G4caPPrjlhrs/kUx9Zih1/IveUtN8S5GvnxAc7oVSyQxZVb76Wbzhh/KOSXgqgzHge6hOYAeHHVVGBKmYVLZPasIYuQaGABe0SiRdbcBRA4MJCCmwMhM9qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 956299f5-6720-422d-e94c-08df2f9c4ebe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 17:54:09.5157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: td9vdNHtzxDSqmpU/ixqdtgo9IodEkFI+RdWLc/JIlwPNRwhTz471h4S+xwUfodubxC6svQ7xDG5JRwoDOPEvu1UmzeGDNz47C7Nd9pFZzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com

On 10/21/2026 1:20 AM, Linkui Xiao wrote:
> Hi Jacob,
> 
> thanks for the review. v2 follows your suggestion, with one adjustment.
> 
> On 2026/10/21 03:10, Jacob Keller wrote:
>> On 10/12/2026 1:29 AM, Linkui Xiao wrote:
>>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>>
>>> __ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() all
>>> check that the VF is ready for configuration, take vf->cfg_lock and then
>>> call ice_reset_vf() to push the new setting into hardware. The result of
>>> ice_reset_vf() is not looked at, and it could not be: it returns 0 both
>>> when the reset ran and when it bailed out because the VF is disabled.
>>>
>>> The check runs before the lock is taken, so a reset can disable the VF
>>> in between. ice_reset_all_vfs() raises ICE_VF_DIS in pf->state before it
>>> walks the VF table, rebuilds every VSI and clears the bit again. An
>>> ndo_set_vf_mac() that passed ice_check_vf_ready_for_cfg() just before
>>> that then waits for cfg_lock, stores the new address in vf->dev_lan_addr
>>> and vf->hw_lan_addr and calls ice_reset_vf(), which sees the VF
>>> disabled, stops its queues and returns 0 without reprogramming anything.
>>> __ice_set_vf_mac() reports success, so ip link and the devlink port
>>> function now show a MAC address the hardware never got, and the switch
>>> keeps enforcing the previous one until something else resets the VF.
>>>
>>> ice_set_vf_trust() and ice_set_vf_port_vlan() have the same shape: the
>>> port VLAN lands in vf->port_vlan_info and the trust flag in vf->trusted
>>> before the reset is skipped.
>>>
>>> Re-check ice_is_vf_disabled() once cfg_lock is held and fail with
>>> -EINVAL, the same code ice_check_vf_ready_for_cfg() returns for a
>>> disabled VF. The VF is being reset or removed at that point, so the
>>> caller should retry rather than be told the setting is in place.
>>> Changing what ice_reset_vf() returns on that path is not an option, too
>>> many callers rely on it meaning "nothing to do".
>>>
>>> The race was found by code inspection of the ndo VF handlers, it was not
>>> reproduced at runtime and no error message was observed.
>>>
>> Hm. My recollection is that we should set something on the PF side that
>> stores the new address so that the VF would get that value when next
>> configured.. But I guess that isn't how ice works.
> 
> It is how ice works, and that store is why one of the two interleavings
> is harmless. __ice_set_vf_mac() already keeps the address in vf-
>>dev_lan_addr / vf->hw_lan_addr, and every rebuild replays it through
> ice_vf_rebuild_host_mac_cfg(). The bug needs a window where nothing
> configures the VF again: ice_reset_all_vfs() rebuilds VF n under its
> cfg_lock, drops the lock, moves on, and only clears ICE_VF_DIS after the
> last VF. If the ndo handler takes cfg_lock in that gap, it stores the
> setting, its own reset is skipped, and the PF-wide reset is already past
> this VF, so no rebuild ever replays it. If the handler instead wins the
> lock before the rebuild loop reaches this VF, the follow-up rebuild does
> replay the store. That is why v2 fails the request rather than trying to
> re-arm a reset of its own.

Makes sense.

> 
> Worth noting the ICE_VF_STATE_INIT half is not what catches this window:
> ice_vf_set_initialized() has already run for the VF by then, only the
> PF-wide ICE_VF_DIS bit shows the reset is still in flight.
> 
> Two things I would like your opinion on:
> 
> -EINVAL is what ice_check_vf_ready_for_cfg() returns for a disabled VF,
> so v2 keeps it, but -EBUSY would say “retry” more clearly. Easy to
> switch if you prefer.
> 
> ice_repr_ethtool_reset() has the same shape and also reports success
> when the reset was skipped. It stores no setting, so I left it out of
> this patch, but happy to fold it in.
>>
>> Why not just move ice_check_vf_ready_for_cfg() inside the mutex though?
> 
> v2 moves the flag tests inside cfg_lock, but not the sleeping half.
> ice_check_vf_ready_for_cfg() starts with ice_wait_on_vf_reset(), 40 x 20
> ms of msleep polling for ICE_VF_STATE_INIT, and the resets that clear
> that bit set it again from ice_vf_post_vsi_rebuild() with cfg_lock held.
> Under the lock the wait could never observe the transition, it would
> burn the full 800 ms and still return -EINVAL, while stalling the reset
> and the VF mailbox that ice_vc_process_vf_msg() serves under the same
> lock. So the wait stays outside, and the flag tests are repeated inside
> by ice_check_vf_ready_for_cfg_locked(), which replaces the three ad-hoc
> ice_is_vf_disabled() tests of v1.
> 

Oh. I didn't realize the check_vf_ready_for_cfg() would sleep! Should
have read it more carefully :\ Do we even need the checks outside the
loop then? I guess they aren't harmful.

> v2 is posted as “[PATCH iwl-net v2] ice: do not report success for a VF
> setting that was not applied”, rebased on top of 0a01e1df137f (“ice:
> skip unnecessary VF reset when setting trust”):
> 
> https://lore.kernel.org/netdev/20261021081248.261762-1-xiaolinkui@126.com/
> 

Thanks for educating me :)

> Thanks,
> Linkui
> 


