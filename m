Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB041D204
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970568; cv=fail; b=SumXvNBrQzQpH+/jOXaI1v0OzcfCE+NhRgPsv6t+Hj8o9IKpue5W8Mix5f+hnux8nT/mZ/mxTpazAEPNVO+AAWoHEv6lYMvO0gc7+zjlgUvlTI5Gr2F7ub0cslq/x89TqSsFvxl4MH0Z38Z4nzWGlWnNedSsNeaIprOwSxAVOgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970568; c=relaxed/simple;
	bh=ZhMXPx2/SmQixfOqxuYGSLwNfBHZ0ZuO0pSk4mMohrg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=asXQuTNgDzlrdekH9g1XmUeylHqWq5FqdCDgjRClt8CXlyyn2ho+z6x1wo2+/yJNdvSvgjMPdaBs3LC6ivdjNk5KUVYOnZ5lXqE5nkCnXSCrV92UCvoZGj1cURpu5R2CJn1CrZ0OZoIEqfDm+XHPAnm72SJHTa3PBlEbqf2m5Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bf7BnSxF; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bf7BnSxF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786970567; x=1818506567;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZhMXPx2/SmQixfOqxuYGSLwNfBHZ0ZuO0pSk4mMohrg=;
  b=Bf7BnSxFzWYTAuV4dm6V5GKZh79Nh+ffY8gJiMzXFyvtNrEavu7ZQP67
   hqRvYpHn6LHSOogBBL2cVGSl+wuIrR7QAnZGFvdRh5mPiwW98n5J520Fi
   Khix9awuC8Nb+xcu79hhwf6B7U5XkWZt4/6BOBuiUZQIOtlGZH4UbnIgY
   ARp3IxHtRH76vhCrcK2uSBN+R+KllSKDeqXf921Z1zI0h2REgL3Cv3SUG
   InpwKaq5wn1Y42KtkIlqqii8TpdbPyC2MiMfijIlMi1mqqTtdBdZFnFuH
   yli03242xSocD9Qe/6OXNRJatbwJxlPbvpynboiEw320v/u/yJZREqgKK
   w==;
X-CSE-ConnectionGUID: 5coGBtnNTZOjhqp+Wq7efA==
X-CSE-MsgGUID: cdlWvFcLQ2yZ5/1eJPRKYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104825669"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="104825669"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 05:42:47 -0700
X-CSE-ConnectionGUID: r+bOAhdpRIaf+LfGATrZbg==
X-CSE-MsgGUID: 7NxoIQE4RxGj2vkVYFhqBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="288384274"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 05:42:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 05:42:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 05:42:45 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 05:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5TEg61+8OVZIh/WKJc9t6/47tzrddI2Q+oMX9WmRfaiCzagT798UoyShlV19xYtQQSNU2qzbcPxQmO2kDevjkZI9trAYpmUWQxy2Rx5P59aUSZrtB2Jv2ME+PiY3Lw7tgXSY8b3SyhNNA5dAw77T/oty85AyLthogQFiRrrBFoismxQRiXgXenpgon+v5EmKQKmv0fT3+y1Cll6sxy+qddqthgAmTKDG+srFkYgQYvPd08ITyYxbva9dBrW6UYWERSW4T5nDGgPZ+Vh3kJYE124B+6d5d1MFr7vWNi9ngJbh1hlGX0I5nl1OkGRhgU8d7fOt2evKvBAq+iaHZB5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mB3nZYa68EfaaeYvTcz8VKeyAunxmr01TXatUEUudLw=;
 b=qLm2EYZenvAiUHf3VTBjuPt+GFUnd+d46gZha9/5m5Kaw9L7juAJx6dmxCQls//N4QmpIWRhMsrAcXLm5aT28pVyWD3a+CIAcpQE5hes8+FtQqMKdG3lgmFvKr1xAIp5HC2Za2vO7/BVv0KX0HAFsSVFdNP7MlMxHn/giq3rL+1E9BjyAcZE9RH+B71Vqz93Hbtp+6x9egXtTPr1tiBtFyVphx5DgiIiw3OZXetJBFDTwbz89OYU48j5JQs4gzMUnKRMPt28QpQDN5tZJz9FtnQ8sw8elharGRY9k02XrxubHd7QsX94CTx0mA0KwZiazG8Ekc8QpeW0CVUYTz7YCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by CYXPR11MB8754.namprd11.prod.outlook.com (2603:10b6:930:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:42:35 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:42:35 +0000
Message-ID: <ccba8112-ff9a-47ea-8b91-a732e28b555d@intel.com>
Date: Mon, 17 Aug 2026 14:42:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/3] net/sched: u32_change() fixes
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>, <netdev@vger.kernel.org>
CC: <anthony.l.nguyen@intel.com>, <kuba@kernel.org>, <jhs@mojatatu.com>,
	<jiri@resnulli.us>, <edumazet@google.com>
References: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0016.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::21) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|CYXPR11MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 87caab5c-bcd1-4f4c-f916-08defc5d035c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hDhX3dA3EHjL4phzCM99gMLHTXL3X11jcfP8l4/7RJo81qQzzOZ7QfQnjoqL6H+hgS+I2ctmKlYGhtmIygS80oY4s/PSH+0pXhxS5Nxcnze0oVuqFrNxkWZO502iaJnrMk06/Fd37P8vSU+FC3APMNpBYQD+gnBebJjl0CliIW999Sz4jegWx1osqxUiYWoPpaG0yiogZ6jIYeNqteiKwAVM/dHDJUrBxH5LvjsTVkDw5V2tBreWb658IKI/Bgi+pRuZ8v3TLzNEPAJSDNTEiIuxZkDsvssp7LcCV4ts1HJpZaz6wjWLwWzgQALZr3DYk2UyVhSlQqylhKLcOXAB5cH9Nb3qbawhivqkBVQTXa0EHMjC214HkC/JkavXKub17D1weWS3G90ymrRW04lHW9BRO/ELjsU0csy5tQmy0DdsSbTe0gwzOWx7KRWbmCi72yGuhEMP94Pg7U+2Ltc+7SATBjzBdqYnTf9gjzfpLwpQmGjz9oN1ThbMxBKkbT6Un+R9lVAtlvIbqpMxmQ/j1v5u8Dc+hw4pLIZFlgOPx7e0wsd6D4elXndRSvLGiFFA9/h/Bme2qowo7JYclkAFw8b8qZdJehhtsX/9iQhexdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhvNWkya1RuUGpoV0xLQjZTWE9mZ2h4ZDRGQ25JekRMMnQveUNrYjVGemxt?=
 =?utf-8?B?Zmx6SXpDeUY3ZjJLUFR5Unl0WHNwcEZLL2ROSVp5MXdGcUFQZzZPRjRNem5a?=
 =?utf-8?B?QUpPNEVMRnEwbzlLUTVHTThQVHBvclZIR0ZRd1IvOFlhNVRyYTk5Mm15SVEw?=
 =?utf-8?B?Q2lIS21XbzIrcXNKUkNjMytINy9qYXlrREtZVkdYTE9yeERPKzNxaEZIczBk?=
 =?utf-8?B?dzhMemdZVWdpNHMwRC9rYURRaWZYNUU5dFBjZVhPcmNVUHBDdW9ZMWJtL0ZC?=
 =?utf-8?B?UHpLejBROVpGaTFnNDI4alNjWCtyMHpPenkrZmswWlN5Z2VHZTN0aUJlc2U4?=
 =?utf-8?B?M1c5dVVhSzl6eUhhM0dRc2EwTVJjN1NXMExyTzg3YVVzd2c3ZG9NYWlmbHBi?=
 =?utf-8?B?T0M4NnUxSWRJY3lhNXd2YTcrWGtJZjZNbVNpK2NMUWZkQk1qRUgrcFBpOHFB?=
 =?utf-8?B?amZYcWNyZVUySWlwYU5vOW84QXZpRkxSZ2UvWWhrZDQ5eGpxY0xCV25xL0lh?=
 =?utf-8?B?dnVvMW5JazdmenBoQk90MUxGdHZDWkIyRDI0TGJ1ejV5OC85T0c0VVJLLzVV?=
 =?utf-8?B?Rk9VdDdSM21UQmk3UWlkU04waE9VSHh3RXRZalF0QVVCVmJtL1oxdk92Q21Z?=
 =?utf-8?B?QkIzSGx5aktJbFpBRjM2ampPWFRNdS9oQStzYjdGL2lWNkxMTHhUSHVTamkz?=
 =?utf-8?B?eDAxVys2d1FPMTh2YTBCUk9OVTgxek90bXZxbXVmZXdHa0FSSW1RUEJTRU1n?=
 =?utf-8?B?WjNkQjRHRnZ5akdYcnYwenNVOEpnRW1rUzVHbUpLeVRaWkhGVHFqblBIb211?=
 =?utf-8?B?anEyN3dURFY2REFuZ2w0SFl2bnZoTFFkNytpT2JrYXBxbmx6eFlQVysyMlhP?=
 =?utf-8?B?SnU2N29HbjFSbnhnRVNMd3VxOFFvM0hxUDlZbnd0bDVEV2lVcFFNdHJDKzRw?=
 =?utf-8?B?YUlYbS9rNkpWcUo2UUhiSExlVEY5eU1PdEVISW5qM0RrQjlTcTlxcUxnNHow?=
 =?utf-8?B?ZzdoSEpHb3B1SE9DQ2NUV2Y1OWNrWXNpN1h6OFNRalJNMUdsRTVNZWVQWUlU?=
 =?utf-8?B?akRYZ01oMGVvU3BILzlvTVVhS2VSYXdIcktSMFNyaExvTUw5UXAvZVE3NnZh?=
 =?utf-8?B?OCtNTkdQSHg1YmthMG5wWHBmeEJKNlF1cHNZVEc4SUNZTWJFT3NNMVc5NXB4?=
 =?utf-8?B?dzVaT0RwZmI2Zm14aDFGQ05WNXB4L1hYOFdNcFRBeW1vaHUzVmM1a1RMQXJa?=
 =?utf-8?B?WGpjSFY2UWhpQ1ZqdHhkWHRlb3B0UzZvWUFQdXIwaVRxVkhRSXBUc0xvMGtr?=
 =?utf-8?B?dE42TU9haEV6YWw3OW1sbGZGU09GUXFJdGVZVUo1d2Z2bkFwU04yNU5YMDF2?=
 =?utf-8?B?WmY0YnJhbUJEWDNmQUQ3VnBhcWd4SHUwblJrbVduVFV4cytZUkI0a3E5S0VN?=
 =?utf-8?B?NmV1M0o2cHVTbEt0ZU9kN0pyQ0R5YjZKQ3hkWUNTRGJydmtJWUxWUEIydDRm?=
 =?utf-8?B?VUFlVGRtZGlSR2ZidFhKcURXWlNDSmdCc0lIM0xZd0pLaXFqcmhWQ3BDNzVT?=
 =?utf-8?B?b1dlQ2VIYjJReUJWL01nVkJVT2t5N251WTJ1M1Z3TUtkNHQyWGJ4NzlTYjJs?=
 =?utf-8?B?TFRxTHZyMnYwZThzNDJRN20wVXFVTE1HWXVIcDZ2UllJYVE3eGZVTWkxNysr?=
 =?utf-8?B?SGsvK3pSeVFOQkVZbFROZEtKTkRBR3kxVFVDR014Um5YcVh5cEp6bWs5UTFS?=
 =?utf-8?B?TTM4Qkhvb0dpWEtrbklEZkJORTl0MGZCR092WVlTWjZsUTU2ZUtUN0pKaDdl?=
 =?utf-8?B?L0llTVU0a3dJSzdNb3grUjU2QUpSWldmN0NxVGFKbE1nNTVRQWoyNTE0WGZM?=
 =?utf-8?B?MmV1b1Y2SXBDV2phQ2FpVkwzWnNVUWRDNXhhZXdrUi9sUEpYem9STzhzVkty?=
 =?utf-8?B?VGNzRmw4T1VJM0tpSHBRV1JNTVMvSTgvQ2U2RGFrOEdvV2FUMGFyUHh0QWRP?=
 =?utf-8?B?TzdEZ21BY2lHaGh4MnNMa2F3OG9jSVIyNUFpMU1jdlZvSnRBaGdvSjNXY2U2?=
 =?utf-8?B?UDVYR2I0c2R1VFdkRlhlRTVEMlIrR3NuRy9PcTdVV0w3M1NSMjVxVW92MVV0?=
 =?utf-8?B?MHRIWG5XSHpzQ0ZuRGorY0VTZTlITjNEcWJXd0RhbTlnYUh1M3Ewb1UyQnJn?=
 =?utf-8?B?UkYxUnNaMGd0Z2VmcmFRcXRnK0cvM3lWOW5DaDl5bVZPY0QrUU5HWFRkT2tY?=
 =?utf-8?B?K2kxdlJZbWRTQWZHOUtQWGNXQWNSeVNjTGYxbklQaHB2WHI1ZzROa1AyaU9a?=
 =?utf-8?B?WVl2Nnd4SVc3LzlCVUhpdkl6ZnFDbmE3SUE0bHJvNHZpZlRndDBRUzBseG1s?=
 =?utf-8?Q?sa7wD+ZY3JQf7cEI=3D?=
X-Exchange-RoutingPolicyChecked: oglh/FivQrC9FnDydzixCAQS46NNpqpWu0SnOYWty3WZ6cnfJ7s4g+Qf2hfNJ0r+t+u1UR7uk3fkwL2SyjhQsyslwYvA5S1/HGl+Qyhkx5qCdDsZvdW8cDmikH0/ffHNJ1dmMti39le+1EXyNEHJdnJwM+HrStXu+R0xnk4pBK4TmndHBgH0Bjq5EPQT3CMYymH+4qoL1nm0mORznpdUYVo8jGfVQXVDEbPwGneSmZEiyGi4Th+FxHRsB2M6YAihfjkauB7i4zlArquRadNHggdHz9CAatEWLSCiJuI5tmCsZGHFzU8edq2SKFHmBtLFzjXDeBXIPyi8KPjqpc0GMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87caab5c-bcd1-4f4c-f916-08defc5d035c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:42:35.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaWT2RBFKKu+vJQQIuM9tQFUl/asSEkTwIFP/KWCfgONOSdoYk9E7VZZSo+bOnPy2PRenz5liZvT8QG9xuJod6gztV7t3l2bEX6yf6Jt/pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8754
X-OriginatorOrg: intel.com

On 8/13/26 14:22, Jedrzej Jagielski wrote:
> sorry for spam, previous series get treated as incomplete so resending
> 
> ALREADY ON NETDEV, SASHIKO RUN

hehe
ofc, the above does no harm here

for the series:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

--

Sashiko has found one more *preexisting* bug, perhaps it could be
handled by one more fix in future series?:
https://sashiko.dev/#/patchset/20260813122242.1690024-1-jedrzej.jagielski%40intel.com

 > @@ -938,14 +938,6 @@ static int u32_change(struct net *net, struct 
sk_buff *in_skb,
 >  		err = u32_replace_hw_knode(tp, new, userflags, extack);
 >  		if (err) {
 >  			u32_unbind_filter(tp, new, tb);
 > -
 > -			if (tb[TCA_U32_LINK]) {
 > -				struct tc_u_hnode *ht_old;
 > -
 > -				ht_old = rtnl_dereference(n->ht_down);
 > -				if (ht_old)
 > -					refcount_inc(&ht_old->refcnt);
 > -			}
 >  			__u32_destroy_key(new);
 >  			return err;
 >  		}
This isn't a bug introduced by this patch, but looking at u32_change(), 
there
appears to be a pre-existing issue with how manual hash table handles are
tracked in the IDR.
When a user creates a u32 hash table with a manual handle (for example,
0x80100000), u32_change() inserts the full handle directly into
tp_c->handle_idr:
net/sched/cls_u32.c:u32_change() {
     ...
		} else {
			err = idr_alloc_u32(&tp_c->handle_idr, ht, &handle,
					    handle, GFP_KERNEL);
     ...
}
However, when destroying the node later, u32_destroy_hnode() removes the
mapped ID rather than the full handle:
net/sched/cls_u32.c:u32_destroy_hnode() {
     ...
		idr_remove(&tp_c->handle_idr, handle2id(ht->handle));
     ...
}
For a handle like 0x80100000, handle2id() returns 1. Does this mean the IDR
entry at 0x80100000 is permanently leaked, while index 1 is erroneously 
freed?
If index 1 is already in use by an active auto-generated hash table, could
freeing it here allow gen_new_htid() to issue the same handle again to a new
hash table, causing collisions?

