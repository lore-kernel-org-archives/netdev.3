Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793408549;
	b=nZujeIzhYcmAWAdpcwiEgk+NB62iEZSySLS0kug2KJkhwCcdJg9HqDoURcBSqrFKpMKB
	 tBQQC+6oBMr54GrKfFdA/WtBwwtgO6KakNBO4J3y3iOzDei0Ajt+VnP/bjhklIlYkzidB
	 zgM6RkvXYpl3C6Gw8vC5XbfAqaGLM0WnSVXordqeM+wMCouLWPhYbuv1WsP4C4yrOk3Rf
	 Nnp8NGpNJPEeXoyQPL6bSljImPZHmf4U7K1CkUnIw+UoAOB5XwyBVl+hlbqseljWOx8Z/
	 ArXQ7rV0Gt7usL9jPx+sg8KPt9xk8EVuEHBBY3WBr2rD+I9BA63W6wAtu9nbflDtd4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408549;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=JOf6TTB/ys/QsWGE4IIjvhx0vSkDIp4wYN6iZK9qK14=;
	b=N04BPk7eSNzDZFp9jmnloci1fgCtsOw87YpxzXvHN5SuiCpdWeDNFTUax/DobTGHN9L8
	 BKDAAlbA/R0Ifvk7EZ2HZwULMBQgIdP+NEjN5zsmRY1t9jTxoXMMX+jInImlbCijhRbXy
	 wYYnTHtA2mdQmA10xwrTyjxV9FYaBpIhl3uHCgIh9Bcp46o0A2V5b6a6zP1Ox9+ldSwI0
	 +3dU4vRS7FT9ncRrGrA2xq/8h89/TBlyBup0FqK0RgwURcwA9JuQXoSsU7Hxk3o6khiS7
	 5FvBXwC7YB116mi8KNcKud1cthZ7EO6WSXXzrPykH7C8lP4kThLsqIzgKHaTSMiTfhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="JY/n8arx";
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF2606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 01:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DDF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JY/n8arx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793408547; x=1824944547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8zEbTa1G/8yyHZ2plh+tazy3cGmMavA5cdV4cU1AY6A=;
  b=JY/n8arxtiFwWp+9AeodVxz9BYIZkMANJxonfXGnZKA3+1Kj80VfYBAj
   a/YSt7fnnlD4WFSTESvkY/jOr0JMWmMVFabwX+9SkX8m64zliS6cMZJfU
   rK1PbpBzNhzPWw3IMajUg5AZ4SLvwZnDblpwy66JMUrYTThq4Cis7WX38
   3NkCuScxqumhLuv7iFXDKXVDljm+6TTSpRJs0JIoqPr4mCDDO6ukWW0/l
   Ba2lJ4ZigXl8vwRpk+/p1LrsQ2XEW9i+otKRVKL0PLdnVc/VtKcx+8I7A
   1C/Jv2hTDqNWV6GmGFodFD7B6bAEgrSve8/2LThqKfiGX7B+Efq2ZiXa4
   w==;
X-CSE-ConnectionGUID: VZKuEc68Tg6LVj54SoL6fA==
X-CSE-MsgGUID: fntDxjBiTQOrknkYcZEzcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2192326"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2192326"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 18:02:26 -0700
X-CSE-ConnectionGUID: e3CZbxhwR7GLQTQmBCAltQ==
X-CSE-MsgGUID: 646HXgFgTEay8Ale+l+Lng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5678515"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 18:02:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 18:02:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 18:02:25 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 18:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5LXRMjPEXPB7Phr0WPsjz4oPTaEnxreCzDK1U/rFGwJeUy0unm6zu+z8ton7EglUcM7ODq24D0Vi2ZZb3cjJ0yBBpW3+8Tg59w2Jyxk2VRiV1VNXilerPlyseqS+4OMrWoX4XTu7DzKH3XcW6bPFDhd4gVKpvHCAoYk4CrpTKVfR5R74oxAQ+Jftlk5i5qZ9OQ0Wv827Z0WUv+Qx0hRLwn4lK1df9O2D/1SvKrnWSsTdSN2AMAEoOS4xSArvR+vDurThMwXqzRTpUV59ij+tD1DxtVjftEYDYBDbIzcCMKDhYuaR0/CmeoCsHiQY0PLHwi+jh+1XlSKnOSpJ9oBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOf6TTB/ys/QsWGE4IIjvhx0vSkDIp4wYN6iZK9qK14=;
 b=nR1nZC77cxdgkQLdVtAQFfrAXOlESEY979OW4iKGO+Dk1gaBXrkQtfyh4vldTeX28armH3qLRTWNtaM9PhS55v1H7SEXg4XpYiQlhkuMxohhCboYFJzQGEyGkJKQfZ1HdcXy6bZvRwnkmjON3khoeLP5XgLGjVbiZTE3Apxor+OpWbaDmBCRXfRr+oCnpgYD80TtIuLNtVIylhNQrNROIHE+Gk8rjOVorzibYW3u2bARejKP7xV4XJtdIULvpteyCM8sv0B9v/AbVP2HyOeHTIWmZsVvkmWzlVQ9BLm3slfeiYaBbpLzzWHJX5vzxbCqq2bdso1SqhoF+0Vsf1/y/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Sat, 31 Oct
 2026 01:02:02 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 01:02:02 +0000
Message-ID: <b0f30a78-4f23-47c4-9ea1-dedc45abf2c5@intel.com>
Date: Fri, 30 Oct 2026 18:01:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] ice: E825: perform a soft reset when starting the
 PHY timer
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261029-jk-e825c-critical-timestamping-fixes-v1-3-72128d1dd928@intel.com>
 <179339643889.3131.9026864983755179552@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179339643889.3131.9026864983755179552@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e55f9c-4d86-49cb-b0dc-08df36ea9298
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|261021123027099003|261028144727099003|261022075727099003|261022105027099003|10067099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: iC4/tSGj33mtgfr6hC7YCPZrATbXoozuMElvNVXGzg++J7qMxCO1vxzZ0idHLDKc/agDOWtYq8YFNvqd5kjTXKD4ZcmbKpuEOr3hY8yT3+5SZG4QGDn9mhCi78BfIbC+re13PndHHurBnVUxi4862UTuw27tuV55T/bNGIao/7jQGYFgcDAyLw5RVXckFxPuPJmB8B9OfPboFOKyfDr5ZK+Pv4UXF7vNA19p9U6asov0ozdYkU1oW39k6XQaOrxdLeehvQ4fxCmQZb+56/yEQRs4dqjgtpjI7g5jC0SaAwGWgYdv0hfhAm4hgRMzFxnRDCU0eY4/+aKmdvGaLP5N9uma4oVTllC/hnAM2KjbS4dgblyQ3h7mIXkR5D3OgPkzbRaKmNdoe/y6+37f+Mzz8A2Qb8VjxYUxbsNMXWb1zVoEoe8hyR2HXW3UPbOscMYgIHmH8zGuxdegSmo/69+RQPFn7OqOJAF+uPZzV2L/k9iwt0GOO1WJdTNagvN3L83ktxO4nvgWr/DXYLXGFBnNwkryEKv7TzG4NSLGj+bYaG2Jgh6NlU494j+pHEzfMsJm5JfnV0Yqh11iwDzeHLMN5xd/imSzOAmAWNvuReAi6OdvPjS41SMnmS1H80rDZ/F175lX63YXxNmhPYd2naNI8dUuoo+65S/9E5bXnIrSlfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(261028144727099003)(261022075727099003)(261022105027099003)(10067099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0tadnAydFNnV0tXWmlsaFJjaytkWUE2WkZwdE5CVUZ4d2pxdXkxWlNMeHgv?=
 =?utf-8?B?aEFaLzZoeklaeDB2TUs3djdGeEZCeXpWcUtEemZNOUFJb1pCck5aOFpxdW5r?=
 =?utf-8?B?dzNCaW5IYUtxVHQvWnFGOElIMGlPdStWbWs4VmlOU0pDb2h6dUo4eU1aQzc0?=
 =?utf-8?B?bmMrQVpKRENOK2VnZVhNM0FuT245Y01sT0p1NzBXSm1EdXRyVlZmdWlRSVN4?=
 =?utf-8?B?dWZmSkJBb2o3b0F5a3ExMFgrVVJXZDN1bTZDRXhrdFhXWnlhS0JpWi9KYUsr?=
 =?utf-8?B?TXl0QnNoczZnaFREZkVsM1ZuS1M0SXBLemxsSmQyV0dCM3RYKzhPTC90V0NP?=
 =?utf-8?B?OHB6QUZkeXdrRGw5d2FuZjMyYXNCaUYrTmlIRERrOE9nSTk4Y2ZKbHVRaGV5?=
 =?utf-8?B?VzFsbGxnTmxVaGVwbVNuN0svQVhnNGhoU0RwNFEyU3JSb3F6cHgzVkk5NVZB?=
 =?utf-8?B?a3ZBMEhZTlZtdFdnUVQzUDZtWVRoN0ZXeXBuU3ZwUHhDMmFTRWFobmJZWTNo?=
 =?utf-8?B?M1BTVEkrRDZhSmpxZHFoTFp4RW9YWFByL1R6UjhSbTJWVERnYXlRTm5Dait3?=
 =?utf-8?B?U24rR3VDUDBCRHU3U3R3WUt3cG9mOVpJZElPYVNFREhoTFRXTmlyT3JOS2R0?=
 =?utf-8?B?VDBPdkVmK2xmc0pIeXJzVDAxQVNEN1VNY3BlRUJqeVNiTm9hZWlvN0hJL3J3?=
 =?utf-8?B?WHNUd3NCZnBSZFFpSFNsazRmVEJwa3g2NmFCcWZ5Yk9aU2RIR2JFS0djTERy?=
 =?utf-8?B?c0FJMjFkc3ZaUS9JS2hkUjYvSmhKTXErL0NaVDZQbEtwOFpBWlN3OXMveGg2?=
 =?utf-8?B?b1JFMFREa0wvci9lK1Y3SDdsbDFVK0U2cmFsL0lITmIwUGhnSVROTTNScFBB?=
 =?utf-8?B?MEhNM2tmQWgxQnN2V2VUSFpGek1TbmxQTG5qejMvY3ViMlMvVVUzNlBWRWh5?=
 =?utf-8?B?TzlNSTQ4d1ZMemhibXRjLzFuVjhkdDFxbUxOaDYxYW95U2x0Q1NqRkpNRUlw?=
 =?utf-8?B?eGR4YVVDcG9TZjg3UkJJa3RMYUpNYlVheTBkT01KRFZRY2NBRXowb2NBV1U5?=
 =?utf-8?B?a3R5SU1WT20yK2N5ajFrUVNPUWUxUVBoZytlUTVyWC9paWVaTnpXdldyS2Rl?=
 =?utf-8?B?YVZQeWZZQmxLRGsvMkVmTitXSVZnQmZMR1pYdEdJVDZVZjlSUXJhclc1cDRX?=
 =?utf-8?B?SVpKSTc0OElZSDJQZHppRFI3ZnNyOGJ0ZDFXazRUY2Y1djIxZVdRRUx0WUxp?=
 =?utf-8?B?RDJodkluN2NweXlpU2NubW9ES3NXamRuUkw3bS9rZkhhaHpFTlBZZnRDRUsr?=
 =?utf-8?B?MzFkN2RwZ0Y1alJqMVIzckRTZ1grNjNRU3lUMHgvSjdvMndGZktqemhvVE5y?=
 =?utf-8?B?dWlucVEvSlBkc2Z0Y0ZNRjltUnYydDZZbFdzRHQzaHhYbnFqelI3Q1kwTTdo?=
 =?utf-8?B?QVpuek95a3Q4UUE1cnJabDJLV3hqK0oxYitqT055NEw1VXdNaUszaEkvM3pJ?=
 =?utf-8?B?ZFBTbUVMQ0h4NjVWeWtyT3N0cEkzaXBlUDBlcEJOZ2VuOEJ2ZUxKcFlFYUxs?=
 =?utf-8?B?RWhUN0w1L3B5MndpVnhaN2RPMEN2b0NxZEVvajArbmV1elJGQmZpQndnVmM2?=
 =?utf-8?B?K09DOFc1Y3Y1M2NuMFF1VTlTM2pSMmtaWHlmRGxNRDQ5Z244dkRDVFhrZDhy?=
 =?utf-8?B?cjZCTDlPZVlNQXFDcVBMc3FnZEtqM2ZLU085U3ViKzUreHZlQkg1Wk9JZEEw?=
 =?utf-8?B?VXVqT2MrQnkyTnBaQ1NGK3pvUjlmUnJQNmxVSmF0aEk2eDJ6S2xTN3hpSkJX?=
 =?utf-8?B?QmIvYjMrbFZKNnduRVBXdXMxT3k3UGhsRWZQYzdCc3NvQVE4V2xYRWxlZS8v?=
 =?utf-8?B?Zk4zbk5CNmxzbm8zMERPSFV5V0ZHVXlsMjRaMDBOS1FBZGdPVmgrUzlETnRz?=
 =?utf-8?B?di90M3FEWGE0bVNpcXJBYzhIZ0pVVkVrdG9USjg4U2tlKy9RSG11K0R0YXNj?=
 =?utf-8?B?enk0ellMNVF3bWhEVTVZeTBOUTFXL0w4QnV0eTduVWoxMjVmenhiQ0tKZkpM?=
 =?utf-8?B?OUFXcXhRR3VDV2VFb0hlUXJFOW1FRVV6MVFBNERFQ3FVRXA3SWhOVzdwU2pv?=
 =?utf-8?B?QkdTQjB1blZ4NGVheHptd0tSRWt3R2dEOTlBWUxxZjNJTjg2WW9vVStrbDNL?=
 =?utf-8?B?clRRQTNPN0RBWUlNdTN0VEVneGpBUmRxZit4Q2M1OWdoSFJlaGZnYnR6M2Zj?=
 =?utf-8?B?WHRRdmEweFhIZVZkeitnRy9iQUpiZHBVZndQY1NiM1JCRHk4aHNLQnhCVVlL?=
 =?utf-8?B?VEU4eXJJNnIrUUpXQjNnUHFNYjc1VTVvZXZOVWE3Uk5Rb3NsN2Erdz09?=
X-Exchange-RoutingPolicyChecked: VymiXuqEVc6MI9kBOBeynfk2acVLZR8kUIcEvlhS3obI6uhVGUuW0aAWrrvMLXA/XiPclufqYlo8SPnrJntcpYUVqNufyKEvmb/OP4eC0N4sRa9PdTc8MrYBo57g0NwUVjKoGYmMHCGggUItMaHPL8oO/WaD/o7LUmA/dh416r9XHxPoa93W8zva9ocBB7/Ji/6gyZ6D5d5Ct2UzYSm6BwI3DVK9dr8px+KHcBb9Gt2wZ2q/+MOZpIqYjro8cH5u1aKJ+srK2DIAP0+vumvgiZQyPLBp6QuI2mFk6PbKyO4gFBKRB6tg0Ch0bzUW80AEwDpLDrWpLmvzv4ZjZ8NXCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e55f9c-4d86-49cb-b0dc-08df36ea9298
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:02:02.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKtd037zew0Lmvsk9Uu0VGXcq6eTc6eyECXituZxVCLFXZaA5tPyZ0uO5irgNBf4Qa8oYfqhQxg7elsU+BqVKc7kP+DA3135dw3nPUTPNzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
X-OriginatorOrg: intel.com

On 10/30/2026 2:40 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In the E825 link-change restart path, the software Tx
>   timestamp tracker is not flushed, yet the PHY timestamp memory it…
> - [Medium] ice_ptp_phy_soft_reset_eth56g() now runs on every E825 PHY
>   restart, including while Tx traffic is live, but in-flight timestamp…
> 
> --
> 

I believe these remaining issues are not realistic, or minor and not
something that should be holding us up from getting these fixes landed.
I had originally tried to mitigate some of these but have gotten so many
complaints and run in circles by Sashiko here. I do not know how to
modify this so that it won't complain....

Trying to break things into smaller pieces seems to get complaints about
the things that we had planned to fix with the full series. :\

> ice: E825: perform a soft reset when starting the PHY timer
> 
> This commit adds a call to ice_ptp_phy_soft_reset_eth56g() in
> ice_start_phy_timer_eth56g(), so the E825 PHY timer block starts in a
> clean state. The soft reset sweeps the Tx timestamp memory and resets the
> PHY timestamp counter before the PHY is programmed.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index ef59b34ba52dc..ee945ce08eb72 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>>  	if (err)
>>  		return err;
>>  
>> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
>> +	if (err)
>> +		return err;
>> +
> 
> [Severity: Medium]
> 
> On the link change path, should the software Tx timestamp tracker be
> flushed before this runs?
> 

I tried that in a previous version and the AI pointed out all kinds of
possible races that might occur then.

> ice_start_phy_timer_eth56g() is also called at runtime. The chain is
> ice_link_event() or ice_up_complete() -> ice_ptp_link_change() ->
> ice_ptp_port_phy_restart(). For E825, that path only marks the
> outstanding entries as stale:
> 
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
>     ...
> 	case ICE_MAC_GENERIC_3K_E825:
> 		...
> 		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> 
> 		err = ice_start_phy_timer_eth56g(hw, port);
>     ...
> }
> 
> ice_ptp_mark_tx_tracker_stale() only ORs in_use into stale. Both in_use
> and tstamps[idx].skb stay set.
> 
> With this patch, ice_ptp_phy_soft_reset_eth56g() then calls
> ice_ptp_clear_tx_memory_status_eth56g(). That function reads all 64
> entries of the port, which clears their valid and ready bits. The soft
> reset then clears the ready bitmap and the counter.
> 
> Take an in_use index whose timestamp the PHY has already captured but the
> IRQ thread has not yet read. Its ready bit is now gone, so
> ice_ptp_process_tx_tstamp() skips that index on every pass:
> 
> 	if (tx->has_ready_bitmap &&
> 	    !(tstamp_ready & BIT_ULL(phy_idx))) {
> 		if (drop_ts)
> 			goto skip_ts_read;
> 
> 		continue;
> 	}
> 
> This continues until the 2 second timeout fires, and the timeout also
> increments pf->ptp.tx_hwtstamp_timeouts.
> 

Yes. This is the expected path in the current logic.

> Until then, ice_misc_intr_thread_fn() keeps re-arming the interrupt,
> because ice_ptp_tx_tstamps_pending() sees a non-empty in_use. Each pass
> does a sideband read of the ready bitmap. The skb reference taken in
> ice_ptp_request_ts() is also held for that whole time.
> 
> Before this patch, those entries stayed ready in hardware. They were read
> and dropped right away through the stale bit, and were not counted as
> timeouts.
> 
> ice_ptp_rebuild_owner() already flushes the tracker before
> ice_ptp_restart_all_phy():
> 
> 	/* Flush software tracking of any outstanding timestamps since we're
> 	 * about to flush the PHY timestamp block.
> 	 */
> 	ice_ptp_flush_all_tx_tracker(pf);
> 

Yes, but I am now certain that if we added this today it would get
rejected because the flushing appears to be problematic at run time. In
fact part of the other areas of the previous series was done to help
prevent this, but was undergoing its own challenges.

> Does the link change path need the same flush? The timeout does
> eventually release these entries, so the slots are not lost for good.
> 
> [Severity: Medium]
> 
> Could a timestamp captured during the soft reset window leave the PHY
> counter and the timestamp memory out of sync?
> 

I do not believe that the hardware will actually perform timestamps
while the soft reset is active.

> On E825, the Tx queues can be live when this runs. ice_up_complete()
> starts the queues before it restarts the PHY:
> 
> 	netif_tx_start_all_queues(vsi->netdev);
> 	netif_carrier_on(vsi->netdev);
> 	ice_ptp_link_change(pf, true);
> 
> ice_link_event() also restarts on a speed change while the link stays up.
> 
> ice_ptp_port_phy_restart() sets tx.disabled, but descriptors already
> posted with ICE_TX_FLAGS_TSYN can still be sent.
> ice_stop_phy_timer_eth56g() also leaves PHY_REG_TX_OFFSET_READY set, so
> such a packet is captured as valid.
> 
> Inside ice_ptp_phy_soft_reset_eth56g(), the memory sweep runs about 5 ms
> before the reset is asserted, and the reset is deasserted about 5 ms
> after that:
> 
> 	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> 	...
> 	usleep_range(5000, 6000);
> 
> 	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
> 
> Suppose a packet is captured after the sweep but before the reset is
> deasserted. The kernel-doc of ice_ptp_clear_tx_memory_status_eth56g()
> says "the soft reset does not clear the timestamp memory", so that valid
> entry stays in memory. Meanwhile the reset zeroes the counter and the
> ready bitmap.
> 

Again, this is working on the assumption that hardware will actually
perform a timestamp while the soft reset is asserted.

> Only the 2 second timeout would free that software entry. The entry could
> still be read, for example by a concurrent reader, or depending on how the
> hardware handles reuse of an index that is already valid. Would that read
> underflow the counter and stop Tx timestamp interrupts, as that kernel-doc
> warns?
> 
> Should in-flight timestamp requests be quiesced before the soft reset?
> Packets captured after the reset but before ice_sync_phy_timer_eth56g()
> look like they are dropped safely through the stale bitmap.
> 

We did have changes in the rest of the full series to address this by
having the driver stop new requests while the timer was stopped, and
marking things as stale ensures that the indexes won't get released. I
had also tried to make sure that stale packets didn't increase the
timeout counter unexpectedly, and to change so that the skb was freed
earlier. Those were all delayed because of other issues on the full series.

>>  	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
>>  
>>  	err = ice_phy_cfg_parpcs_eth56g(hw, port);
> 

