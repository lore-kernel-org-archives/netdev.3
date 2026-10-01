Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80E3E0097
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870280; cv=fail; b=fkR87mXXOIFGf7FP5G3Rc7ZiwdVI1aogXybsKeukpOv1k8qZPDEuoEtVdAZwacslGo/FFQFiP2TwAMAtAncUOALCt/YPjiVWrAfGEKnWjRIokPRZOX52ePBV2sw91SV1MtlDXrCD0hpvPhMEh71/gJ339iBJuszc0hIVwV8SwWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870280; c=relaxed/simple;
	bh=QbrotJd4fPwm4fRia+zBwuWT2VF9eJ3T4yTDhh/xpmA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r69lwJ/SFpxj82aoMUprwuyS46+GB8O5qtqNWhQUVPGZWhiF9NRIwDlJENfOT3PuYO89C0jX3NvsYepFKzLYOEdDTg2qPfkPqqWkEcZliAgNFPk84dSwkiddlQBjQ94GK4T+UG86lN3ndWjBTo7o1+jf8myfGvtAtnqLL6je4B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bWGZnE77; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWGZnE77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790870279; x=1822406279;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QbrotJd4fPwm4fRia+zBwuWT2VF9eJ3T4yTDhh/xpmA=;
  b=bWGZnE775UUtIvXJB/C1auPuZtucJ/EKh14MCVxgzCDgqS2aY7p/shAy
   FFCF7yVj8avHLJMGN2wLWEJTVVUq92xN+n8GPuvM7fDRJ9pQtrqnU1TcG
   MrkfvdvPREabiIWrGqqb2h8VaHS4x9n6CMHtBO2RTLi7grKBR9eeRX6HF
   rhYSY9UAxzzIzmnZqj+qMhh28aoZmZDpoYJSt2WMItrqaVKkz50DD2RDB
   pa3omdIpd6E6UbJUXobGrKDsOLUZuM60bQjCKhgwEtulcAW5whNKBM8Lp
   hUmzC7Pnn94y7L2/sQc8a+Ty7nMZUlCquli0sAUhrInjNYb3w4c3TqPIx
   Q==;
X-CSE-ConnectionGUID: GGI8DJUwTPeBi/Y3Vhi5Gg==
X-CSE-MsgGUID: gocU6r7PTT+ehxee+PpBKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90402782"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="90402782"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 08:57:58 -0700
X-CSE-ConnectionGUID: ThvksUVPTr64zBIuk5BJOA==
X-CSE-MsgGUID: dfbsmeUORE2acY7Nsfog/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="284092609"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 08:57:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 08:57:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 08:57:57 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 08:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuR6lH0HSOXHMnjmngELkF+pogh07tVOqMwOCWjkZqq0IVNfCEsbwaUGmcPQcRTZBSCM226VeGs8qjBsFL1+pbQlVzErJzgIIB42PjnJdqFIwYfwddbW4Yh3fViHvaE+WKSpztDlcq4Z/EeD8UHRV5WiLPZ8Ar+1G0AKHCxuuQkx2H8Rg0RZm8hNjub4xnyW7MZuf02TbH9waeVneWYzZMlcOGSCMKMqEsJhPM1zwikNrSx5SISSy3XqP3c2TcD+YpUeo7KYiWqzfsfaWhX7JFsKtToLcNKHPdRHnHUSrlTD7HbetNcpeiWn/ICR0zjtdjAeoEycBJOXf6Ni9akZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GBWxfAcif7PwG5RmcZ1J0HRfKwbr2cZfU54y/n0T60=;
 b=VhmAYENWhTt8qbEQzBTUuCCURxS+AjBPFcjZYal/7hkz8A/OyBWV5Bfku7E2SvIMTfqzxbtEqn/585q3N3TTijoEapwvrpWmslYU7E1MKPgAbeuKO1uM9iXkbV6NL7fB036jgELLmJeG5HLamacUOhquRICSxELW0IrSmjjMKtpr62snLA26RE/yDsYenCsCtGjs5HtqkLyMy3eaYmZ2P3kWrsj0Qr08nljaGWV+StY9NgBRaSYmXwbjzuqSHXRx2HoUBovJYd3sP5d9tt2guwuQEbosKCyigZcELzJjJ05+frepSzeZnXlDH9fyTUx7iMYMbkwiCE3X5ipm7WXLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA3PR11MB9086.namprd11.prod.outlook.com (2603:10b6:208:57b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:57:54 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 15:57:54 +0000
Message-ID: <d6170c1d-d8cf-4fd5-b0f2-361b89902fe7@intel.com>
Date: Thu, 1 Oct 2026 17:57:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: inline eth_type_trans() fast path
To: Eric Dumazet <edumazet@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <edumazet@google.com>
References: <20260930172957.897342-1-edumazet@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260930172957.897342-1-edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA3PR11MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd78040-f57c-4515-ba3f-08df1fd4c08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GEKSEW2i5/CaJsccB4Xgj1LzMTSoSK9SS7d2yrdnQkmpK0uLCvKZQTD32cctXX5K9N3oX9GBzgYQsoq2uKpbmLctrUhukDpgKjYXbIyb22bCL728H7p/AEqF5nkyxQQ95Q+5A/GY0XrW8/EifJSIZRVf6IvGB9kjc8u0iT7JORl9Qp19CAf4kSrhPLLv5giwZZ7PvWIu7L1A91ndtuHijWAXyX3+34vK6ysnAck5Oj9BUUhO4UWZYHcGJpvvyNDD9mlTkjCHSzAQKSbPZpFbcF7tT5RAnhjd51/G2OV37wMjpIxlZ/VAdi6O+yHExWSvABUIaK6Pz0oYEGpiki0lwhWN/xnfv1Beamc2GABheoLypOf3JsD9qKPslr4RnmYgnfHxlxBIC2tHAWgR6fHXEnBOGRGNCIho5pvuczr2Srez0P1pN/V7IEpzgLi58mgghm4GBqj+8P/mfV6lVm6h+Rbwq1awUYzgiPJuAyMEhoUF9OUeHAhxfv/m6pTAoJ9jIKWdsjRI9q5mQDlDHB54DrjzaMdVvHcMb7imvAQHKXF6x9nQY/WO1sY9uReZy9ZgcACSQPvhGdfxDWjk8YqtIJriGvI2gsOH5tPdCKhC0nBDVXYGTT+RAJinwwAN18IYOuUE+uToa0Ql6iSyjmlwyUAYU56TPjqgRfiwqn/gQBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2l6eEVQeG9zcWxpRTNuS0s5NTVhUFpKbFF4NVRNSzRXeUhCbDRaZnhrL3d3?=
 =?utf-8?B?eUNvQ0pPVGZVYVR0VjZaNjgzd0UyTVR2SStJQUI0MU02dldvZDR3L1ZNRU9I?=
 =?utf-8?B?ejRuVm5HMHArRkg3dHE2QWkvZ1VyVE8xRzdodENHSC9hQVg5YndYQTV4VVFC?=
 =?utf-8?B?TDdzcjdabGloaHVGVW1WV1cwQUZONElkcE5BeVpHV3czWlZZbWNVNUlkYXpR?=
 =?utf-8?B?MENkMmdoekJmWjkvd3lJazJJc2cwVlE5eDVaOHp4dndRUGR4S2ZxdG1wR2V1?=
 =?utf-8?B?VjhwTmFVV0R4S1VZaU9UQjZzUnUxdlFVT3piL1daT3paUXYra0pqT3lkZUVX?=
 =?utf-8?B?REFoMllxSDJna3B6aG1rVTBqa3NRT29LWW1nK01scE1pVGZtMmZVb0k2OWNp?=
 =?utf-8?B?c3grcXZWYVRFRzhhM0lQQmc1c3V0T3VIVTFaNUN1MmNPRldvK0Rid2lDZXRs?=
 =?utf-8?B?eWdYOG1ZekgwYjNjSVN5VkhrQ29VVmFEcTEwVUpkU1JYNFU5Y3V0YmdNTFNl?=
 =?utf-8?B?Lzk1OWRpaFl3LzJuQTQrNmRkalZ2N1lPMVU5SjZodWt5Tm9LRk5vc2hpaUhm?=
 =?utf-8?B?UVNzUWJReHNIejZLMEhSMms1bWs0bGFSRTN1bWFkYnU1b1ZlN21SQTNsOUFi?=
 =?utf-8?B?VVVTMUJHRWJRWlBKOUJtb0JicytMZzlPZzIrcUJVZGhpa2JKYTV2a3hDWktM?=
 =?utf-8?B?ZStub3V6aHo3eit5RzdjRlJlZnAwSU9pckxYNEpsOWNJdjNDNDl3ZnN5TkI0?=
 =?utf-8?B?OUxucXpvQXNjaU5mNWRhNVZDR1c5RlVUdStSYnplYjhUdzBpUDQ3VU1mdlBZ?=
 =?utf-8?B?bEdTU3NwQkMzZkdYRzY5TDlSanhLRFgxUkYrVzhNZk4rZ2NUTWdNZ0VZbFZO?=
 =?utf-8?B?U0VoNmNhM2NMMFJnQVQ0MWs5Q2diK3dLcEJVVUVTdVpGUktmYVVXbkZQY09P?=
 =?utf-8?B?WFRDdXozeS9TN3BmRlQ2ZXVPVVNmWENJeVR3L2w2UUEvZXh3UVptcGZCbTNu?=
 =?utf-8?B?ME9YNjhmODZZcStoTW14UDBLUU1QS0lXODQ1cjlkQzRSa1F5elRIZWJHZ0Ni?=
 =?utf-8?B?Ulg0SEtFbkZPcUNxZm1LenY5cmRlYXRQUU1sTXowMTIxZitOYTFqK24zZ1Rt?=
 =?utf-8?B?b01vWWxkUFkyeCt3R2JUVXJQVHdsZkFlUTBBcHNKTmJOZzdzMko3S2NGM3lp?=
 =?utf-8?B?MVJoRGxZNzYvRDViZlFPNVBWbWFjT3R4b3RhOEc1NTFtdkNYS3BOVnZFRkly?=
 =?utf-8?B?czEvRW5JKzJxZnVjVXp3MTNubjRlK2ZsQkJFWjlSQngxUmpPSFpQdnBuSkpT?=
 =?utf-8?B?TktzUUhNbkJXK1FUOUptYWVkbHF2blA0NG1ic00vUFFyZzhLQmh0MzhTcGFD?=
 =?utf-8?B?ODdxcGh1bXFWalhJeVhBdnJ0clU0RjRZYkRDQkMxSXBpVUFYQldoMGZ3VHox?=
 =?utf-8?B?V2NUTmlhdWdweU1MQ09lVDYrU0w5YWxNY1drZXNYRkEzUFg2Q25zdHNDNWth?=
 =?utf-8?B?QmRSOFdJZjhHOGJ2RXErLzFLcUtESHpiWEZXZWlGdEt0OGlVQ21jNHI2akh4?=
 =?utf-8?B?dlVmK3RPT1hXRmc4QzBuV2FIaGQxUEJ0bXRrbXhxTmNBWEVpVUVCSXVWMUtD?=
 =?utf-8?B?UnFwMGpGVFZBYVJEcVY3L01WY3Ayak1tcXBzc1lLczdDNlJYSSs0NHE1WFMy?=
 =?utf-8?B?ekdnVTZkK2xLWERNZ0pCOHlaS1dCZGtVL1FhelRaQlpFYm5IZG01Yi9nMzJi?=
 =?utf-8?B?QklJZnBCdDc0dnFJeS9KbjhURUx4M2FlWHRzdTN2NXhwZk5SU1dNR2tRSi9D?=
 =?utf-8?B?M1huanZZSnBVYXRVSkNsMlh6M0o5OHFFUjVmVEhBQzdsWTJ3QysxWEhEV2ti?=
 =?utf-8?B?TmhYVnFjWDNwR0Y1WTllbi9iL1RNaVNLMzFwdWlyVHVNNy9oQmsxbWxJMDh3?=
 =?utf-8?B?N3VvUUFkK3Y3YWJoMldoSDl1YnF4bnJyM1BETkhvSXRUU1JnOTdMVU1YUHR2?=
 =?utf-8?B?SjJJMnRpN1FKemEyeFBveEtsdm5POXY2dUQvSU9ETmppWFgydE9SdDB3Q3RY?=
 =?utf-8?B?Y2wzOC90SExEbmF5Zy81bzNVUW52aVJJL1UyY1VKU09rUFREQk0rM3Urd1Zt?=
 =?utf-8?B?ZzM1SmsvT0lBaTczVkhmWjBGN3F6Qy9hM1d6S2dmTlhQVXpGeVlIaGtBNnVF?=
 =?utf-8?B?UE5mNWQ1K2ZIbEdLMG9BRXdSZTdGYmZXTEwwREpXbnRxZ01KdThyWDMwZkE2?=
 =?utf-8?B?clVJVEZZYk1oWTRZcE1lUHM0Q2R5V2wyQjFRN3pOMENySDI0R2JXbGJXaUxT?=
 =?utf-8?B?aFh2OHRjRU1Ld0RCMjdtRmdyU1VRcnNrSEY4QkNLRERCdTY3bDhnYkdnVGFQ?=
 =?utf-8?Q?xIekWI+IPG4Nqa8I=3D?=
X-Exchange-RoutingPolicyChecked: 0h55W5UYR382q+6G5fV5dly0mzjA8wC9GNaUDROEfF9tVdmaogSidzwOlgIuG+h+WRjRF4fnikemBE10500M00/jW6bXeSduW5A6I3dh7/qIpULhqU9jkCFQBhrrU5eOJ60DVi7jo4XWDY99Ajbz6iCkHyf58H7TlgaJ2HchS6WFgxjCjK2MKxlCo5O1b4BCsphCf3Iix72zkc05BRQ3V8Fmfv2XfeN6ekbh1q1c50lOWqSl3Up1C4OcHxXX1iDGPmxEudF2F/NDwnQpn8C5gqL3NDY9dWQ5DYZMJUlmD9M6StI/F4SRXjYsuA4VRt2CI9zoI64TwPQ5nFdr8IeadA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd78040-f57c-4515-ba3f-08df1fd4c08b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:57:53.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybdQXkSnlkH7vI9bajr+Zwll4NHWbtuIWstbt+eY9ez89CAOllGLx7Xure8NDerUMJonsyZukCqvWv2qADLsCWy+VT5GOIVsLiszLS3zCWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9086
X-OriginatorOrg: intel.com

From: Edumazet@kernel.org <edumazet@kernel.org>
Date: Wed, 30 Sep 2026 19:29:57 +0200

> eth_type_trans() is called once per received packet by most
> Ethernet drivers, and by core helpers (napi_gro_frags(),
> xdp_build_skb_from_*(), veth, tun, tunnels, loopback...).
> 
> With CONFIG_MITIGATION_RETHUNK / SRSO, the call and return
> are not free anymore.
> 
> Add eth_type_trans_inline(), handling the common case inline:
> unicast frame sent to dev->dev_addr, with a real ethertype,
> on a device which is not a DSA conduit. All other frames
> (multicast, broadcast, otherhost, 802.2, runts, DSA)
> are handled by the out-of-line eth_type_trans().
> 
> eth_type_trans() is now a macro calling eth_type_trans_inline(),
> so that all existing callers get the fast path. The out-of-line
> version remains exported, and can be called with
> (eth_type_trans)(skb, dev). bpf_prog_test_run_skb() uses this

Shouldn't it get renamed to e.g. eth_type_trans_slow() to avoid this
confusion?

> to keep tools/testing/selftests/bpf fentry/fexit tests working.
> 
> The inline part is about 25 instructions on x86_64, and the whole

Nice!

> function would be almost twice as big when fully inlined.
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
>  include/linux/etherdevice.h | 43 +++++++++++++++++++++++++++++++++++++
>  net/bpf/test_run.c          |  3 ++-
>  net/ethernet/eth.c          |  8 +++++++
>  3 files changed, 53 insertions(+), 1 deletion(-)
Thanks,
Olek
