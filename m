Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CD49D588
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664328; cv=fail; b=tbW8rVXivw3pRySHqsoK5h/vGU7of7fbMA18gAV0Juk43d1dVh/wM4miAYXUP1drO82MU2gr7qTgX5AJoJJ3UE9h2MwptlThjogMTXWP6rG/yIFaJBimmmQ/cXum6c4orvbZWVeoeVm2fiGaIInpP4WkMDYBbyJe+OXtW4APlXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664328; c=relaxed/simple;
	bh=8RXx4EvdMZow1XL2ixKr3nODO6Szr1HNsEvvbC1ljGo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evrh038xx60WEprwlZkby1umd75jrcWiAX5exdJZBO/gJB2Jc579R7f2Z/M8Xp20drks0foZs5gq+iv3GaFHjpZKdUWieLsrH4mZTY5LkaFKXCgfvmy/FLaus/MQCr1I8MgCo9NsIbKSQYl539Mp8XYJVK1cqAsoJEHGnQzXJnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/PFuXsY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/PFuXsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789664325; x=1821200325;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8RXx4EvdMZow1XL2ixKr3nODO6Szr1HNsEvvbC1ljGo=;
  b=f/PFuXsYclixqNqMdemzmBBgv+wQ/P5HTIKrRv02qw7BMoFtQsK3V9hj
   KCWwBLHgSdWFChf+YsKJnJ7QaywPNuzKii8q69tpvrsH2WhKoaIoYFx6g
   V9Kf/y/7nAQmII1UvZZgcZRhQE51StsyGqtDonu8YWssaUW1XuUs7w90d
   fqSenKMT4RN5kaXJ4ikprjHgPzt23bRPadSnFOtewO4/sOegf1csyuuiD
   L+Y1vX6QUAQe8nLbtgumiBR2H/9ABFjI3YfdteHLu0VbHGSt8XSZ/z4jk
   z/Z48vatkFavch91fb+ZVKENtIi8gI8HoiJG1Y+2dSUqWSjaufYis5nLZ
   Q==;
X-CSE-ConnectionGUID: fLQufZKVQsmOio82Sp8K4Q==
X-CSE-MsgGUID: ZaN/URO1TxGLSVwYrWjaAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89042034"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89042034"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:58:44 -0700
X-CSE-ConnectionGUID: 66+gujmvRk666aGlO3OC7w==
X-CSE-MsgGUID: 9UQB6x1mQPO5Dgf7YBBU7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2341067"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:58:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:58:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:58:43 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhN/9PJGaWRI203xSOoNa+AQk2J14gN2vjDMcHJyb9/sCDM5Zu9XEMP/a0YmHIZcijKBe3r1I/lg4qGfznT0ob/bgxp7S8vkTpi+HIuD7A3jN5JWkL77+mB6haztK1dZAswdSrXXjOODkTjsMFc0kCY9NjsBv642JegbwkyPM5bdRIcI0eHKI4HT9/qnUqJx15MZjzit1pWIV+jasJhaAWK3rRgqG2tLF+j0evCmQNLQiuEFqdR0NUsdZCDFubUeM+7tw2EcYxL+0N2xFXgFClzwBDAWAggn5e6eOHNQUMXv2Ixe42+vuLL2L1mRaOQfa+8Q9/sYCH8xCxVZSITFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GEtrR1AgnyYqm7AAu2a07O2bG7Ns+X5vNi730R9kZ4=;
 b=pozAUqJLMcpJ92G3SmFe2PZhvsiS4K9RN40HKgq82fkoUVmyrEmwHRil1wLm+ZLJ32pSfM7fpiiv1RhhVhw7+BJmxMryS3IIduH7P+A/M/W4UBdpG9aVhQvkLm049VeVHF38riFzpgSdm1hj7a2IBJ7vYuyczs7zM8jgSmABsydlpdXdnl0Lto7mMCLp73H0rTSgdWJne0sxjiZ6+f/aeD6R3yaQr5yK5yzJTkLSD+i4yaLc0kg2tlhECqCA9rKaI5WULYMkb+qH6Tk90HdYc6KMvX4RHZ40bJ1h/vvDBx/dE1ONK3HzGhzXSyzWfNOjLD0q5gx2ACVkXFgTb1VEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM3PPF31D2DA56C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:58:36 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:58:32 +0000
Message-ID: <9d6e5352-6a99-45ef-899b-ad48f62ac66f@intel.com>
Date: Thu, 17 Sep 2026 09:58:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 09/15] ice: E825: perform a soft reset when starting
 the PHY timer
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-10-anthony.l.nguyen@intel.com>
 <20260916011222.1632652-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011222.1632652-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1b0a5c-0988-4c7e-81d8-08df14dce7c6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|18002099003|6133799003|10067099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 3IIGvV7QqxvA9Ey4IS7Cwde1QTDIxzrIj3Eu5y4y3DBdkJ9TzK13sZhIOaLqavXEh4kx0niNKs2yAB6ffQFutu49ZlAHdvu0ndQL8evtg1R0UJ4xs7RQMrS+eeHUrBWP8FGhKWS9i6N0fPtQKxt2V6/u+HEJfVUhb/xYjxVq5SHvl6M7no5Fc5PCv8oRgOpoKFV9W9zDsi+hM56wIYvBVpyikFdziRJ05moMv2kFXEJog+ZwWPS2MziFmokyWMz4x/NQEI6o+W8m4ua3FtijaWuYy4OUql4nh5gZKOaLSAumb0HoMgK33dy5WxW+b3HEtj9p+5NLzs7ne7jY3yYV6lpMOygU9NBtWfN9BnihsFOjcoAtvtJQMJpIeDq43ZNalLatgBnh9a3meDxFrFcingH9xQBbWQCoszrlsJnX4FOQE3InpACypdesm7dB0cmxtrGjWKXB44sg9SaKLECcCCQa7nXQUbPdYmjBA9ODQHe9oRcDxupDklMGcsZUqF/CZiAbKzxt0S5uUWObLLulENzruG4R75kjTn2kH/oRU4cBGnIhx0rHJbuxk8U4hzy9VL6Fm2x03hu5WMhtZCkMaWD/a9Wmm+iSXkJbrlJYeMN2DFPYdwzTzscWSlA7yUIg9pdelpQXwZcuD23dvDnNDL1nRM1lLTwsCjVJINx4bNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFA3QXJUMU0yOGRraGdOamFnWkF4TDFWR3dVNGE1bDJKeFdiWmk5MFJBVXk1?=
 =?utf-8?B?UDdvdlJ0Z1QrdGVSaWhxdFFwd1dhWmprdFBYSlJxN1QzeFlZbE1FVG5GL292?=
 =?utf-8?B?dlNGeDBlN3RZd2hhUksvQUlYRW1paGJ4R3JtTHFoMjRYaERWQmZSYk5ndGNO?=
 =?utf-8?B?RFBpakJrSlNxWS9HMW93UEtwNGRLUzh5TnJMVWRFZzFCYkdrVldnMzBEOWNs?=
 =?utf-8?B?bldybStYSWdHbDNKdTNRaEJyM1MzTVdlODNBUFYrSjJ2emZ0cUptcTZSaGp2?=
 =?utf-8?B?bThyNzJBczIxYXZhK0ZSTnJDekdQT2RmT2NjOEwzK0p1K3ZkQmFpc0V3MXNP?=
 =?utf-8?B?MVpTZ2YzVzVEZW43SnBLaG8zM240ZnRBNEwwd29FTGRNZDludmRWaGwrZ1lQ?=
 =?utf-8?B?R1NzN2hsenJZZ0dnajRpaFFhem9MTGsxbldLbHpGUnBwUUJiclpOOFFQNkFx?=
 =?utf-8?B?YmxmZ3JUdC9qQUozQ1kzbndyUzNKazlzOFRuRVBhbUx0M21va3loODIxYmNN?=
 =?utf-8?B?c2tMSXJrRFJPaFhYd1FMdTZycGJiWGowandrQVdHc21MZXJlV25sSytVbDIr?=
 =?utf-8?B?eWUzVmJLaFNLTk1kMFM5cm9pQjRQR3ZUOEliNzNodnYxS1hodkFhRFNkNHFG?=
 =?utf-8?B?cHFJa2ZTVWFJWUx4NVRycG9iaFJ3L2hjTHFPQTlMOUx2aFQ3ek9RcEw5aWFO?=
 =?utf-8?B?MXRYOWtvaGtDd0pVL0U5STQyUENoNmhWOGExSEszaTZWbTNIenpYZ3F4djgv?=
 =?utf-8?B?QnhDQ25lckUzcEVyTFVVSW9ZN1lpK0x0cVNmTGMrMHlyYzhuazJ2RXNzcVov?=
 =?utf-8?B?dzJQN25kVnc0cVhoa295RTQzQ29TOXFQVVpzSDRFRWZQMmFXRlhLZ0t5UzRS?=
 =?utf-8?B?dUJJQW5NQU02L0plUWJkOGM3QllwemFmN3VhU2RjWmR3ZmtxZHlLRkJPdkNo?=
 =?utf-8?B?T3Zlanc5eE9QZndRWDZDVXZlSXNHMFhrSlkxUXd3clhpcC9XVUJvZFExRnI0?=
 =?utf-8?B?aG9EUk9yN0pJNWNoalZFSXhqQ3hFZHZFUThCd0I2bDBCdTJYYUZmaEUrWWUx?=
 =?utf-8?B?cGRyTUUxOWdwV0poZzRCOHoyT0laN2ZrMVJveDFWd3FVME84ejBUL1kzejYy?=
 =?utf-8?B?emRGNkxzdjVaMlZuNGZHMDMzRjN0dXVIVmlSRk5NKzV4VlpoU0xzUEcwVk5Q?=
 =?utf-8?B?d1FPVzVXRis1SDFIWjM2UEVEcVZtUzJOWnU0a05LRHRzdVBaOXFVcjdoMTFa?=
 =?utf-8?B?VGY1b0dmdklxZUJxMTZUdzFsQVZUbzZNSHkxTi9Eb3dRN3BLTEFqemVha1ds?=
 =?utf-8?B?WisyZnpReGpCUHpVRWJ0anZ5MDFXWmNJWWZqZTdhd1B4ZWU2cyttbno0U1ds?=
 =?utf-8?B?WUFoYzkzNDFwOTl2MGFYTnhSRVdlaWpReEZzbjVIWXEva3dpanJTMmdkbmxY?=
 =?utf-8?B?RHpRMGc2enJyaXlab25zNXBFeUdmYjNQNjh0L1FDVE5ldHA0bVdvS2ttdm5m?=
 =?utf-8?B?WGxJMVlEOVU3SWN1WjREYTZ1UFdTQ00rWkkybzAzc2VTWTVTeDNNbkg5OGp2?=
 =?utf-8?B?N2tiVWJSRC9UZm5SZzNZNjhLeXJ2VlMrSzhDTTZiZ21mTzN0TUdSUVdodXlt?=
 =?utf-8?B?QmxSWjg3Z1JyMVg4aWRYTk1qanVPS0x2a2JleG1QcGw4Zklta3l5eG9uK2Nk?=
 =?utf-8?B?RENuQkoxZjNnMzZQL1ZBclIxYzgvTExFdk9PUytQM1MycGhrdXFEaWhZVkpF?=
 =?utf-8?B?ZVo0bFRvY055WVdOdjAvTUl1SlNHSzU4Zk02SklDRDhPZXo4U243ZTNrNWdP?=
 =?utf-8?B?bTFGcjVsNE9RQjUwUFVxc01yMU9QK2NRNHprN21rWWFWQUdzUkJUS2xmZFl6?=
 =?utf-8?B?b05yUzRnZW5kMVBHcTduME5mazB2a3BUTWQ1ajlyZ3NXTFYxaENjRFI0UTd1?=
 =?utf-8?B?UTduVHo2N2J6d242aVZ6VEExMGw5S1F4WFJ3L0F3eHk1TllNNkRRNVRZOVFE?=
 =?utf-8?B?VTUwT0dhT1RRSDYzYmFVQnNlKzJ4MHJvRVBTQVhwT2JGbWc4ZHpjUVN3bFZw?=
 =?utf-8?B?a2lPU1Y1ZWUyVWFGZU1ZeWNXWTVPbFgxbUJTa1locEhWRHFRaEduUkxlQVho?=
 =?utf-8?B?bXQ0cmwwNUpmVFRQeVJlM09zcnMvOWtJdXdiYjVCOG52Z1VaeWx0VnhLQkdl?=
 =?utf-8?B?WHhvVGJTMVFkOTJEaUt4ZmdzWjF0UjFjYi9XLzVOMG9LWWE4Z0R2OThCdzRP?=
 =?utf-8?B?b2l0MUFpVjNMVXBpSTlwbHFUWXNGZDUyZG5saEFXRXBKVVZoczM0K1NseWVY?=
 =?utf-8?B?K1JxNGZtSHV5enpmdkhNQlAxbEhmOXY0TElPb3NWVUhpeHV4ZnFHWSt2dGlk?=
 =?utf-8?Q?f5ZrfHsI9MwQyz3Y=3D?=
X-Exchange-RoutingPolicyChecked: b8BLVh+HWgEi8EHD2Pjgg3LEI2PCitqlRg6iQMgFe8OolmjZYq/m5ApkVAQRXep2txFuaqovehbZLUKHGTY2hG1tKyLlDB5GHhr12/S/3L4aH+tEpYFdvMDBHM3VrXhhW8El+EmXIjayBOsihg2ddhHYD8aJiSfAov3sVNAIdzEfTRaO6BwUEEecWCeBc2SypEcsHItkiVujduPeHvYxny/2YTDoFrH6I/CFuVrfrfF5IT+PEwp+loLr27Uh41sRTQJkqdlY8xAWZyM/92tVG3Gmmo/wCwzoLm/bPN6myfEDiCF9L7SzNztVRp7UnbqbwIu5J/ACV+xb+Ulo5VNIIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1b0a5c-0988-4c7e-81d8-08df14dce7c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:58:32.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKNvRELve8aymOhqWc4G9+jTGMIkL6Xks7L0bU93Pados4imnZOUWZP+sMqlekLQptJ25c1vethmthtarQIX+GRiDHiD0CySNGvgYoCMT+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: E825: perform a soft reset when starting the PHY timer
> 
> This adds a call to ice_ptp_phy_soft_reset_eth56g() at the top of
> ice_start_phy_timer_eth56g() so that the E825 PHY PTP block is reset before
> it is reprogrammed. The kernel-doc for the function is updated to mention
> the reset.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index a3a9f7ce04d2b..64e18fe1176b1 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -2138,6 +2140,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>>  
>>  	tmr_idx = ice_get_ptp_src_clock_index(hw);
>>  
>> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
>> +	if (err)
>> +		return err;
>> +
> 
> [Severity: Medium]
> Should the software Tx timestamp tracker be reconciled here?
> 
> ice_ptp_phy_soft_reset_eth56g() calls
> ice_ptp_clear_tx_memory_status_eth56g(), whose kernel-doc says:
> 
>   * for the port (two 32-bit reads each). This discards all timestamp data on the port,
>   * so it must only be used for a full reset; callers that must preserve
>   * in-flight timestamps clear individual indices via ice_clear_phy_tstamp().
> 
> This now runs on an ordinary link-up path:
> 
>   ice_ptp_link_change(true)
>     -> ice_ptp_port_phy_restart()
>       -> case ICE_MAC_GENERIC_3K_E825: ice_start_phy_timer_eth56g()
>         -> ice_ptp_phy_soft_reset_eth56g()
> 
> The ICE_MAC_GENERIC branch of ice_ptp_port_phy_restart() sets
> ptp_port->tx.calibrating under tx->lock, and ice_ptp_rebuild_owner() does:
> 
>   /* Flush software tracking of any outstanding timestamps since we're
>    * about to flush the PHY timestamp block.
>    */
>   ice_ptp_flush_all_tx_tracker(pf);
> 
> The ICE_MAC_GENERIC_3K_E825 branch does neither, so indices still set in
> tx->in_use keep their skb references while the hardware timestamp memory
> and ready bits are wiped underneath them. Those entries are then only
> resolved by the 2 second timeout in ice_ptp_process_tx_tstamp(), bumping
> tx_hwtstamp_timeouts. Later patches in the series ("ice: keep Tx timestamp
> slots tracked until completion or timeout" and "ice: don't clear in_use
> until HW clears ready bitmap") make the periodic work reap those slots, so
> the effect is bounded rather than permanent, but should the E825 branch
> still gate or flush the tracker around the reset?
> 

Hmm. My goal had been to make the E825 only ever release an index from
the Tx timestamp thread. Its quite difficult to figure out what the PHY
actually does in various cases and the consequences of blocking a
timestamp for 2 seconds seemed safer than potentially allowing some gap
that results in blocking all interrupts indefinitely.

> [Severity: Medium]
> Can this leave the PHY parked in soft reset?
> 
> ice_ptp_phy_soft_reset_eth56g() asserts the bit and then has several
> error returns before the final de-assert:
> 
>   global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
>   err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
>   if (err) {
>           ice_debug(...);
>           return err;
>   }
>   usleep_range(5000, 6000);
> 
>   global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
>   ...
> 
> If a sideband access fails after the assert (queue full, timeout, or a
> concurrent device reset returning -EBUSY/-EIO/-ETIMEDOUT), the new early
> return here skips ice_stop_phy_timer_eth56g(),
> ice_phy_cfg_parpcs_eth56g(), ice_phy_cfg_ptp_1step_eth56g(),
> ice_phy_cfg_mac_eth56g(), the incval programming, the timer sync and the
> TX/RX_OFFSET_READY writes.
> 
> ice_ptp_port_phy_restart() only logs the failure:
> 
>   if (err)
>           dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
>                   port, err);
> 
>   mutex_unlock(&ptp_port->ps_lock);
> 
> There is no ov_work retry for ICE_MAC_GENERIC_3K_E825, and
> ice_ptp_link_change() only calls the restart on a link-up transition, so
> the port stays with SOFT_RESET asserted and stale offset-ready bits until
> the next link-up or a rebuild. Would it be better to de-assert the bit on
> the error paths inside ice_ptp_phy_soft_reset_eth56g()?
> 

Maybe? I guess the issue is that if we fail this we don't really know
what the hardware state is in. I think the only real recovery here is to
reset or link toggle. Even if we de-asert the soft reset bit if we don't
get a clean soft reset we can't reliably guarantee the timestamps and
interrupt will work... I guess it may make sense to deassert the bit but
still report error so we don't re-enable timestamping until we get a
clean link reset.

> [Severity: Medium]
> What serialises this reset against the Tx timestamp reader on the other PF?
> 
> The reset holds the block in reset across two settling windows:
> 
>   usleep_range(5000, 6000);
> 
>   global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
>   ...
>   usleep_range(5000, 6000);
> 
> The writer side holds only its own ptp_port->ps_lock:
> 
>   ice_ptp_link_change() -> ice_ptp_port_phy_restart() -> ice_start_phy_timer_eth56g()
> 
> The reader side runs on the source-timer-owning PF:
> 
>   ice_ptp_process_ts() -> ice_ptp_tx_tstamp_owner() -> ice_ptp_process_tx_tstamp()
>       ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
>       ...
>       ice_read_phy_tstamp(hw, tx->block, phy_idx, &raw_tstamp);
> 
> and for E825 that PF processes all ports, including the peer PF's port:
> 
>   if (ice_pf_src_tmr_owned(pf))
>           pf->ptp.tx_interrupt_mode = ICE_PTP_TX_INTERRUPT_ALL;
> 
> ice_ptp_process_tx_tstamp() takes only tx->lock around the bitmap/skb
> update, never ps_lock, and the E825 branch of ice_ptp_port_phy_restart()
> does not set tx.calibrating. So can ice_read_phy_tstamp() land on a PHY
> PTP block that another PF is holding mid-reset, and if such a read returns
> a word with ICE_PTP_TS_VALID set, would it be extended with the cached PHC
> and reported to userspace as a real hardware timestamp?
> 

I think with the suggestion to block using calibrating in one of the
other comments will fix this.

> [Severity: Medium]
> Does PHY_REG_TS_INT_CONFIG survive this reset?
> 
> Everything else in the per-lane PTP block is reprogrammed below this point
> (PAR/PCS, 1-step, MAC/XIF, TIMETUS incval, timer sync, TX/RX_OFFSET_READY),
> but PHY_REG_TS_INT_CONFIG (Tx timestamp interrupt enable plus threshold, in
> the same per-lane block as PHY_REG_GLOBAL) is not. Its only writer is
> ice_phy_cfg_intr_eth56g() via ice_ptp_cfg_phy_interrupt(), reached only from
> ice_ptp_init_owner() and ice_ptp_rebuild_owner(), and it is a
> read-modify-write, so a value returned to defaults cannot be recovered.
> 
> The existing ordering in ice_ptp_init_phc_e825c() is reset first:
> 
>   /* Soft reset all ports, to ensure everything is at a clean state */
>   for (int port = 0; port < hw->ptp.num_lports; port++) {
>           err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> 
> whereas ice_ptp_rebuild_owner() now configures the interrupt and then
> resets every port:
> 
>   err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
>   if (err)
>           return err;
> 
>   ice_ptp_restart_all_phy(pf);
> 
> Given the commit message says the reset "ensures that the PHY internal
> state has been completely reset", could this disarm the port's Tx timestamp
> threshold interrupt after the first link-up while software still believes
> it is enabled? The software fallback ice_ptp_maybe_trigger_tx_interrupt()
> only runs on the source-timer-owning PF. Commit 3ec46e157c7f describes the
> reset's effects without mentioning configuration registers, so this may
> well be fine; could the commit message state whether
> PHY_REG_TS_INT_CONFIG is preserved, or should
> ice_phy_cfg_intr_eth56g() be re-applied after the reset?
> 

I'll clarify this in the commit message. Experimentally we confirmed
that PHY_REG_TS_INT_CONFIG doesn't get reset by the PHY soft reset. I
will try my best to explain my understanding (I really do not like this
PHY and how limited my access to information on it is).

As far as I understand, the soft reset affects the PHY timers (resetting
them to zero, resetting the increment to 0), and the internal timestamp
counter. Experimentally I have proven it does not clear this
PHY_REG_TS_INT_CONFIG. I'll try to address this in the commit message.

>>  	err = ice_stop_phy_timer_eth56g(hw, port, false);
> 
> [Severity: Low]
> This is a pre-existing issue, not introduced by this patch, but the new
> juxtaposition makes it more visible. ice_stop_phy_timer_eth56g() documents
> a parameter and an action it does not implement:
> 
>   * @soft_reset: if true, hold the SOFT_RESET bit of PHY_REG_PS
>   *
>   * Stop the clock of a PHY port. ...
>   int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
>   {
>           err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
> 
> soft_reset is never read, so ice_ptp_port_phy_stop() passing true gets no
> soft reset:
> 
>   case ICE_MAC_GENERIC_3K_E825:
>           err = ice_stop_phy_timer_eth56g(hw, port, true);
> 
> Now that the soft reset is done explicitly right before a call that passes
> false, could the parameter be dropped and the summary line corrected?
> 

Yes, that will be fixed in one of the other comments on the series.

>>  	if (err)
>>  		return err;

