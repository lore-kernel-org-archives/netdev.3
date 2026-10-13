Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2F450415
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929241; cv=fail; b=EBOjh9DMuU2Pg+4SCUiFWxs9XJxtNxzmCZSxkrLFDTbC+4uHfZwvHdnk2WBm1VyaCTx+do5H23kgQEXzVH33k/PlROj9EzSh0epMeWnk6oHxUiStIPm5EOydtYG9SQgt0qKMTZIudy/erTP3fASweF4atyU/sH32dDBHLYa7V4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929241; c=relaxed/simple;
	bh=KhgB7PwxS0UDAc/e5GnbluNkNI8Z9nF4X3UCcWBY4/4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=At8c2tPU+iXJWZ7n631haqq0IQXNLy2/phS1dlPuANrhCCCokJV6ulE1u7zWA1BmoL7eC/mTpLe8LVJNZEUXeza4We7DTLyWxMIy/n6uYoKxrVF/fnN88CitwiHbIUlzK7rI+afYbTIQi3dHdDrYIMfvfOossKmh4ln1TpX3kjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8OhhD5m; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8OhhD5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791929240; x=1823465240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KhgB7PwxS0UDAc/e5GnbluNkNI8Z9nF4X3UCcWBY4/4=;
  b=e8OhhD5mKnE0OUQTQFhVhfZrkw7Octu6yKSbNeUqvTNhTnKpkSYW4Q5E
   Bvtj6nMJm3T6mmPe3+gC7T28vdjY50ZkqKFlng0/8weu8A1g6Kg766Hi2
   LiobGn2+YLuHbhJeZ98A078nXbZTSXYE20G4wCl4jJckPfp4aJE3ceT9H
   yLbyjWDqdLI1+R+XljiRRI3hS3M1dbGnVt3NOOJYuwyMnkAgjmzBrKMBz
   XlSrcvmjpDvSraAF9s6mR4BiyuRPfI5OBn6PxmQOLFSC2fitkHD8zlFKh
   ZOtHm9yxwDhcwFfLpu6piv1oLp37azgQ77TWEcWNkIjNP8s8L8YkhK0h8
   A==;
X-CSE-ConnectionGUID: sISVfqmEQKCyxDtcOUZfPw==
X-CSE-MsgGUID: iccIB9AVSEeqHwDXLHWxFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="676821"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="676821"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:07:19 -0700
X-CSE-ConnectionGUID: NbI9OfE2R56gOB/0lU3gjw==
X-CSE-MsgGUID: zNCwzSQURCWpSLVoWGGWYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1348290"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:07:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:07:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 15:07:18 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:07:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgjXHgWM+t5XzclD9Nynr7EYXwHYURq0lNCqtthPzc6eATnzfJOUOrFLHXIsXvYhIw1Jvcuq2jE22U7QH42vEiIwbw2UuznZAXHB0sz6wEARrQLsEPx5u05PJZcPrVacYucdjlqGFa3op0ALXgtgM0+b+4pFQ/Zmkik6lxPc7e2lmw2q265kTlfCGKPjCy6Nzxe6KM5HOQeFWjDJrAfo4IDyZD9I0LEmjYODi/U48irRpBO7ic3UEo23B9S8pYmwSxThpj44FkHuKEsIyWRRZjU6+4hfenAP8cEj9J0q3shxUz3M4rVXzxEv9QC+81lVdUZQLP639t/rIff1Y4/xYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KHwZXlz89BDyWg5qQWyCQ3/WCA34vThSb9rK6jsR7g=;
 b=IEFlaZ4aPYFy9hOSmwTV4/zdJk97CSufWY19uETyWwtR9WMkpT+JwMR6x4ICRns/JFmim0S2IwO+LCbyKbYaBe88ap6SXi+H7psWu4r4aVt+wHISiwoC6NYK+Nv/JODrDs4aeHfUQHEyiddPpZP0wWEtZXsD2HGZ5iXGeJ/SPNXwSrtcfETMQ53eUCLJFgf40+jjh9ZQknMZFXLvJ6Dj5ckz0EYBHHUwADfENeyYlBKA9Z+CoI2+qVQj/Zcd/ZTTydEjmNRhn8HXBeNgysmMMaxjafBrZ8r9Eij1yaPwAX/yMqI9X+H2gQX3bCsFST2CfLvigArNSzS0x+g1wnW1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by MW4PR11MB8290.namprd11.prod.outlook.com (2603:10b6:303:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 22:07:05 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 22:07:05 +0000
Message-ID: <8efa6c68-9560-4773-b60f-4a2da88f650b@intel.com>
Date: Tue, 13 Oct 2026 15:07:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 07/15] ice: E822: cancel offset verification work
 during reset preparation
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-8-anthony.l.nguyen@intel.com>
 <179184692414.434549.12037498977381126452@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184692414.434549.12037498977381126452@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|MW4PR11MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ab4636-ad8d-4a83-7eee-08df297650df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|18002099003|22082099003|5023799004|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ApueV8XG4OVKhIDKdonZRkfZ7Njs/dJNwqu82mQtIO5iFQIPQ/gg+rL0klB9IbAkK5SJRCYCD/r4/bRL9pGdAhIxIAVXhezaB8/vGE1UWwwFttcjIMK6jQFUzLC8BnVYJOOehAbzetwLumexQZorwOSCf2yafKAJMxu0QzBmmp8Qo7HpFLiqCOjnKrL97nsGBjEhLVpXwH6hYBr3WDpcAHKO3s0OaBLVxUffnHggV/Wcr7nVBaKCqbyvT7ilyuubMWqJX8c9LZTcjDMRAVruuLVc0xhPschg1X8qn5vq1/WQ0fRfK1YPEYQPx5vMuTlkNdb0+fI5VtUn8AlTsmT9Sw7lyYJBiknGJktFOpTN1Lw65dPED9IXjKRiq8NZ73d5cuu26H4lf/v+m/wWYq21xfrtq/xGlmU8YkUapCn6O/tEj+ZtWVY4ZFuJUwA+6sejthLKQNLZYdlZKqn9EId1ltsDL9KL35RtGlIdZMdyvknUcbNAAXUR06sitbMScjvPOmXohfszJ3Ej+jJOPmw3X6gIkb9t1cYJ39iFA/LD4l0P4fXBemRqRaEqmfx5XIJVO8Rkf/+vX5OXIab0bfhzrqRjI2IS3kr0ZNXkZx6wP2nI4bl2J5oYYh/147FF/T3iNN+HgK+U/3HMtYct+xYshFRlWPsSIpbtxN5tcxc4DbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJ2anEyclM2c2lZaXhqREUwdHljNC9SaTRTc0NYc2I0V3d1REQ1SWI5RFk2?=
 =?utf-8?B?U01weVd3akJHemJvSUNzS0hXOFVwTnJOUnZ6aHBPOVI2aU1TZ04zMEZKNHhB?=
 =?utf-8?B?SzdETDV2NjYreVRjR3F4R3F3blNJVUVaRC9na2NNR3d1RnVuWXBDc3NlOXYz?=
 =?utf-8?B?R24yaGFhQmFKSVF6T1hZR3hqNkxLVmFuRWVTTnIrVXJCM2orSHFDMW42Nmcr?=
 =?utf-8?B?K3ZpZ25uNys1dUxZK05kY21Ea3pQdHN1TFVXc0lKa2wyeWprOVlLTU9LTEJW?=
 =?utf-8?B?aVZZRnkrOFQvUGN1UCtOdWEvV0Vva3prVzFjRElBTmVtbElJdmdHc3Fpb2Zr?=
 =?utf-8?B?d2wvUjFrb0w3cFY4cjZPQ1JrMGlLS3hYQ2cwQkEvNURNREo3MFNrRjRQRmF0?=
 =?utf-8?B?YnRMT2xmU2RKd2ZTQjRvT3E5NmpGYkFvcTZRejJubDdXTks4L1lyeVR0dmcy?=
 =?utf-8?B?RlczN3RueFhQcFVJaW1lUGYwcWxYb1BtSHJ1TVFXRE5MU21uVVNBd1NTZlpC?=
 =?utf-8?B?c1BYNWNuWVdYY1ZOTFlnR3QwcVRWUG5vOVdRQi9uUHMzRUhtcG5RcWRiaThY?=
 =?utf-8?B?Q3JpTzRjZDhsQ2JKeklldm5FOEZza0k5cjlEeDdUTG8vZXBnNDF4aHhuN1o5?=
 =?utf-8?B?cjJQd1NCbjYzWG1ic1lSTElrWGhlOExMZDhoM2daY1BmYW5CZko1SU1jbUo5?=
 =?utf-8?B?ckVnWmdEc1JxT3kzWDFJM2xIby9Xb1h4TDNMbnhBTmNBS3VrTTJsOGJKUVZL?=
 =?utf-8?B?WnhFL1dKVW9udWtFb1NETUljYytmaGo5eXVPVHprVEo1Q05zdkpGaGJTWS9u?=
 =?utf-8?B?dGh4M29yT0NVNUNITDJKTVJEYTF1eTRFZWsrUDFUOWgyKzNRTlY4NU0yNjY1?=
 =?utf-8?B?YnlpdG04NHp1blFsWmpJOW9RNWJVenZlSlBxMDNMcHF1TDQ3WFFsbUtjbDlt?=
 =?utf-8?B?V1VXOXA5ZG5KUXgwM2xPazErcnRxcmUxK2EzSVBhbVhhRi9LNmZSejJWaXYz?=
 =?utf-8?B?M1M1UGJiY1VvNEVuMzRsbThhMGZIM3Y3V2RROGp4ZFlPWGJlK2RtV0gvNkFm?=
 =?utf-8?B?ZkdINzVwT2YxaHRwNnQrT3liemE3RkVFVVU5cEZzdllmTmFNcThYT0JVYWRy?=
 =?utf-8?B?a1EzQSs2K1RYdUJHQkdIQkszL1VoNmtlTmN6MmZ4OGVvMVc0c21jS1BSNzJY?=
 =?utf-8?B?ZEtkTFRJdm9oZkRTWVBFYlBxZ2ZEYlNSZGJ1bVUrdVdXSHY1Ny9JRXNCN1BS?=
 =?utf-8?B?VjhVNG9aTjZ1S3Zid013Yzc1NmtyY2VUcjhacnZENnRzbHArOERjd0ViSjI0?=
 =?utf-8?B?aGNNR1BEUkpGbEtnSUt5NGMwSEhuRi8rNWRMWlFORlVlUWJvRGVvYTA1ZTl3?=
 =?utf-8?B?SjlBQWpGZHZoZ0t1bDlpQ1MxdmIwb0xseWRpTDI1K0NPYmpGcjBncHMyRlpP?=
 =?utf-8?B?SjQ5WVlKOWpVcnBQS2R0K0h3dUVRUndzN1VtNGFNTElVZHM2aUxuZE4ycUtK?=
 =?utf-8?B?S0FVRzZheVQvWnJqMTE3Zi9jeFhLU1l5cDYyOGxYUGVwU01na3BKTk92cnV1?=
 =?utf-8?B?WXBaeWlaL0pGMjBqZlNiUml6ZW96cTk5UEU1dHp0cFZGeFBWblltNE1BYStY?=
 =?utf-8?B?VkpZODcvWjhGelp1UlhIWEVJNXgvUkNLeXYyZ1IrL0lxRzYzVG9EYTRSNWtG?=
 =?utf-8?B?RHE1amE4a0VLOHU0Z3ZXbTFvako1RGplcVFGcHdyQUl0QVNXS0o1YzhjQW4y?=
 =?utf-8?B?QVRka3QxT1UzVTRia0UyTEhFT28rSmFzY3JtdVpVbk8vc2J6WE1LMXhKNnNL?=
 =?utf-8?B?YzdBSFZYd1VvU1FYU0ZPbmVuTllYeTNZK2krTlFTeEwyS0RMVUEyOGdudFUw?=
 =?utf-8?B?WEV1ZlVBQ2J6dFVhbTc4Sm9vN1RlaEE1QTNGaUpLaTJOQXAyc1pjWUpSM3Qy?=
 =?utf-8?B?V0VPRXRZVWdZblFwYUhuZDdFcWZ2WEpUU1BSOUdkZWNSa1BRODZ5Y3JVNCtq?=
 =?utf-8?B?aGtaL2RIVCt1UERwN1p6OCtHVlNWMmlGa3Q5cEJHOUFRb3Fzd2RjZWxJNE85?=
 =?utf-8?B?eVBSOTdvWTB6NUU3YUJTQTBqZUliZmhKVGVCeEdxMjFqOWh0a2VWeEtIVG5B?=
 =?utf-8?B?K3pnY3pDd2lPN0gzaHdWUlVQNFZMKzdvRDFaSFRkcFA5dDRpcTl5eWo2UGhZ?=
 =?utf-8?B?QXZaNjZiQzFoNTR1eStIYll5T1UrelZuM3JwSEdleVQ5UWhzS0hOSlZzeUZh?=
 =?utf-8?B?eDVjUXdCS2F5VEtZZ2pUZ0Urdi94eWl5MXJSMms1S2hnTkROVFZLdnFlNHVN?=
 =?utf-8?B?WTNFTVpHV1JlSTQ1Lzh5M01xVEE2R29DYlVUdnhvYnh2ZXZkcThyT0FoVGVE?=
 =?utf-8?Q?iOHdfI2i8BhcjkCs=3D?=
X-Exchange-RoutingPolicyChecked: NDNvknfNa8Z48i9FwZAxmIRjBGvKYNVCBsfUKxWiNtdFCXEJE6T1i529+BMeeIHziN7Fq0UFOc15O/XIEFqVdnBAi8IWtqLbCIgKW43suLb4JWRu4ljau5NkJF8OSHXDlEyrSEQBDZSc2mceRY0y2JNwq2hfiObgqKxB8THE2aY9X9VpS4n3Rfy0WXTpu5HANPpSnI7H88l34afAW+Nrsai2MF17AQuwzJPwahn/o0Mt/MqcknjHJjiloPP8UePmdVVdTgxauYG45nIAVwN3v4q4O82IU9K7KAPfAFg5OCOnLjunzkpvtsBt+UBqVwqQnwAc2Zpq7t8adCp88Q1mbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ab4636-ad8d-4a83-7eee-08df297650df
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:07:05.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIrZ+1bHYrQaFZgNfJhIet7MT7PHBUsoWA2jqfxd2zblekAw8xVO6hs62VdNpuZXW/t5TPIb0aEfjcCLZFnR6YY7nMRNQcK6BCX5vbclSDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8290
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message gives a false reason for leaving PF resets
>   out of the new cancellation.
> 
> --
> 
> ice: E822: cancel offset verification work during reset preparation
> 
> This patch cancels the E822 offset verification work (ov_work) in
> ice_ptp_prepare_for_reset() for CORE, GLOBAL and EMP resets, so the
> work does not keep polling while the PHY is restarted. PF resets
> return early and skip the cancel. The commit message says this is
> because nothing else would restart the task after a PF reset.
> 
>> The larger resets will restart the PHY, canceling any outstanding vernier
>> calibration and forcing a restart. Preemptively cancel the task for non-PF
>> resets to avoid doing unnecessary checks while resetting. The task is not
>> canceled for a PF reset, otherwise nothing would restart the task to finish
>> vernier calibration after the reset.
> 
> [ ... ]
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 7f82439c47ee5..7cc151b01a13e 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -3006,6 +3006,9 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  	if (reset_type == ICE_RESET_PFR)
>>  		return;
>>  
>> +	if (hw->mac_type == ICE_MAC_GENERIC)
>> +		kthread_cancel_delayed_work_sync(&ptp->port.ov_work);
>> +
> 
> [Severity: Medium]
> Is the statement "nothing would restart the task to finish vernier
> calibration after the reset" accurate for this tree?
> 
> Near the end of ice_rebuild(), ice_ptp_link_change() is called for
> every reset type, PF reset included:
> 
> drivers/net/ethernet/intel/ice/ice_main.c:ice_rebuild() {
>     ...
> 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
> 		bool link_up;
> 
> 		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
> 			     ICE_AQ_LINK_UP);
> 		ice_ptp_link_change(pf, link_up);
> 	}
>     ...
> }
> 
> ice_misc_intr() sets hw->reset_ongoing only on the OICR path for
> CORER/GLOBR/EMPR. For a PF reset, ice_ptp_link_change() therefore does
> not skip the hardware writes. On ICE_MAC_GENERIC it reaches
> ice_ptp_port_phy_restart(), which cancels ov_work and queues it again:
> 
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
>     ...
> 	case ICE_MAC_GENERIC:
> 		/* Start the PHY timer in Vernier mode */
> 		kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
> 		...
> 		kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
> 					   0);
> 		break;
>     ...
> }
> 
> When the link is down, the same function calls ice_ptp_port_phy_stop()
> instead, which also cancels ov_work.
> 
> The call chain for a PF reset looks like this:
> 
> ice_do_reset(PFR)->ice_rebuild()->ice_ptp_link_change()
>     ->ice_ptp_port_phy_restart()
> 
> If that is right, cancelling ov_work for PF resets would also be safe.
> With the early ICE_RESET_PFR return placed before the new cancel, PF
> resets still go through the 100 ms reschedule loop in
> ice_ptp_wait_for_offsets(), because ICE_PFR_REQ makes
> ice_is_reset_in_progress() return true.
> 
> Could the cancel be moved above the PFR early return? If not, could the
> commit message give the actual reason for exempting PF resets?
> 

I can move the cancel and update the commit message.

>>  	if (ice_pf_src_tmr_owned(pf) && hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>>  		ice_ptp_prepare_rebuild_sec(pf, false, reset_type);
>>
> 

