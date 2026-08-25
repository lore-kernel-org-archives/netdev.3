Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FF26A0D5;
	Tue, 25 Aug 2026 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662226; cv=fail; b=HaUJheFQSDPgtRYVH+vLbguDrJqpcKLVv4OkGDPoDOvM+AFRG3YZ/gOx05aYeA1m+SRidfork/lRqBu+l3bEeZOs0xaaLgfPxyJVXM9+I9VopsIW6eQqpjSQq5yatlAVEKLU9e5clfbleqZNuWDia3EK85K1Gc5o6b8UusDAkGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662226; c=relaxed/simple;
	bh=imi/Q6wtDHyPqWPw6/qAP8EAPyXwbVPbyNtFBnKqxi8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OH4abmEUGyjVLBMiWp1ihrXU7ojyxulsNNXGSqzeE731lgW+yOcnqD6pCqgYo+irFDb1zodzGLs3jCqEHvFLuDy9RtDrdF/BDb0qWK/65206JyQ86e+GCmH0Zr8wrOaKk1a9CsRXNtDxr9zH/5VZLwtBsLQGJZ26IWGzmyski28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCfRzPtK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCfRzPtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787662224; x=1819198224;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=imi/Q6wtDHyPqWPw6/qAP8EAPyXwbVPbyNtFBnKqxi8=;
  b=dCfRzPtKLBkZn1jHLE7FUm1j627a3LuilZfhX4JZoLrBDDsLC/Y5Zt7l
   ThJc3NDeKusSPE1qFOTMvxRugmP/pvu4LBL/bniZo8lVnrkcg3+vnM6Gf
   L8QIIcaPTKjZBKLWmYqQ/KzcY7Hu4QcpSYQooe/ZBNoAIUWUiziTESQpm
   cl7OfvtvKWTECWj+s+SrqBaXm5c+BmElMDaXexc6OTzeJfaNLPbVdSsS0
   LLtLw5Nnnd3ytKN0ITUZcjzCfHArw81O9JaxrFZDx6Mqr/A8NKOk41nYn
   eYqJsnANaZyAP2ZvNk1ZHWe/26AgnIUWmpTyuDO0VAq9ehjoqFwez9C1V
   Q==;
X-CSE-ConnectionGUID: 0bLEHftqRXOcCqmnbDuZzg==
X-CSE-MsgGUID: n581qHF9SbG/xCe8RhHGgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98716812"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="98716812"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:50:23 -0700
X-CSE-ConnectionGUID: 2tvMvQBOTDWiR7glIsPyBg==
X-CSE-MsgGUID: SLiUti5hQK2sdvumyKnO7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="269227889"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 05:50:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 05:50:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 05:50:22 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 05:50:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7T3JxgD+8Sghe9bVceQLDqsGKMCgIMouEDZWlB0j2g/F52SUX4hN/sWV1JPy/SHX12OWgRv5vp28qLP1RfngENMNq+p9CJJgF+dsFnQx4ZYO3a3/O0YaeXbVzHW72XopfktI+9lp7zbxSJNpQtnBzFpRFAfBl9rlP58kVRnuXHvDEpLkMAFdOZ3x1TJNGdG2f6qp+d9pirquQ9+VceVrHf9Vy97IwcYZKks/jOn3ID16Hz6Tt1kvj5pSOVJJ7YPrqB+M//VxYB3c813vh5dNfo/wpLA3FJOpVy9c5JHKUI/u7EGG7bkQu6+UnlZ4IqA19BE/Axp7Ovo1Ip1o+/HAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej3zqBbKmS55VAdjamYi+slarfq5bDHfkgFSO0jwAjQ=;
 b=wSEcqIZTnyI3LPCQpQVpeIss/0MvNJfQuQ9E+GdUwHVraJzZO9JeYlfpwky55uUxQFbHD8sm1Hdf4Z5Tes6jY/zpSrXCq9E1jnG++Ba7I4rW3p0LfYT3JhIDSpU4C6sBh90z0wbg0kMSl1PAwbqdaQu67wD1zEYj5rUhXjtH4SlwfjmaG4dvOsguLuTI3/KXXEB6ppvCWspkOJH7f0KE0CTwNmUFQpE8Vxs/52ffUJ8oSCV7/1cNdJ6GnaxMRq5aLnc1X/1ZHx3BPk15aqwz9Q19mTWmH9cl+p1+hBkxKYjqn76TjsaWwcSrE61ubNv0MGb0S5+3n2kKa17NE8I/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB7505.namprd11.prod.outlook.com (2603:10b6:8:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 12:50:10 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 12:50:10 +0000
Message-ID: <ea7bd312-a9b7-402c-bded-42a34b63b167@intel.com>
Date: Tue, 25 Aug 2026 14:44:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
To: <intel-wired-lan@lists.osuosl.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	YiFei Zhu <zhuyifei@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260818155101.2416665-1-aleksander.lobakin@intel.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260818155101.2416665-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::42) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc2b201-bdff-4975-f16b-08df02a76546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MQQRDf9RwYI/xsJZ3A8Qyh3P7ZZqRk8T4FK9KGHlNZGuJzdJ2WZ9EySU97dhC3Bej6u4i2vBKdgVzCf3ubXqPLs3My4HFZn1cqplNpaUF7x3YPUCzAnvVhZx8GFUPxYXuXCVQalM2L7bbuJa/a727Qyv4q+ywjjYLdKR2HtXFbfswa77AT8ynzEHba82cx/uisMUqH2f7vzAT4fdQqGUY1olT3IHoQcG8jZzpzRPaRQGLG+rFQtA5ym+EgKXMkWrCPWA0zef4bgl+bZ15I7cRuOPwC8I4tsPiOMt6eOdltBFxHBkw8fmZYj7pIjmEzHJDv9yn8M6e1C3FN/UqeMrKsNhgsVcxVPCB9x/+MDvj1zM3xfQ1yH7Y3QZsK9j9Up2RtUEByNB6SVNANr66/arHZ3RS3X/oNlI9cE/OVHtgm7hNArfpn/wKO/LMqc6i3zHa010t2HXHQj4Q1HUWMdwn3PY8a3UOAixPy9I69oPDwD4o9YOhQ4HcnOaZLZpThV/IwhlfOqxvMZyyB92C3qKGeR9TDHHzAQ7pbZ/frW60zR2cWydxwb/UoFlq8Q86dqlg4AuAGcy8zQWVYm4WV3763jQA1IbBPeXpj4CsnEoc1AKD6uxSj4P8tolV+h0hkRf3MZjkltP7RH3F68wyaNPCxaDcsYfVyFWxz7s5BIxw1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkN5ZldLRG80a0l0WmFFZzluUXBERnE5ek10NXFoak41TjkzZStjaXE3WGh3?=
 =?utf-8?B?bjNNSGRBa3dXdDdkVnppRUovZVlFUmNvQXJpTDRUdk9wbWpTSU9VOVFiRVBQ?=
 =?utf-8?B?NEVqWUVtcEhlRE5JOHF1TmdWeW9La2VaV0N0aXdKUDdMS2ljNDVZZS9UZklZ?=
 =?utf-8?B?bzJFaWJXTjVJcjJlVFE5MzZzOVE1TWZGNEVHM29DenNLYlJMY0pRNnZZb0ZK?=
 =?utf-8?B?NmNjaVBTbk9NRC9pQ0kwYjlvemt2TlA3SG40QmpJS0ZUQnI5dmJZWmQvbHoz?=
 =?utf-8?B?OVByOVJSdC9BMnRQYS92eEZEZmJzaWlmaXlYUW1tdDFlekNVeFR5VWozbXMv?=
 =?utf-8?B?aDdWVWlwOXZrSkM5MzdzQldMU3IvbXI0VWY0N3BPaFNjaG1rUHFZMFNHYXFY?=
 =?utf-8?B?MjV4c2xrV0NrRFVMOWcva0tDRUcySnhCWEJ0amIzbFc1VTBFVm1mKzJQeHcx?=
 =?utf-8?B?THJZTzh0ZFIzWTNrSGVDdSt5RDBkMlVnSEEyeC9HaUViQmo0L3gyVU41cjIw?=
 =?utf-8?B?N1Q2dHoxajdsN29wSnh4L1hmMXpxUVNsNExxUTBSRllySVI4RGltU09kc2F6?=
 =?utf-8?B?SXptWHlPZ1I2T2RtN3VNeU5McUNzVjV5dGE5RUptWFk2TERwd0FqUHlpZFNV?=
 =?utf-8?B?dktFUW9ENE9MUmVuVGxKdUtUbzZTRWl4VEcxVi9DUnNreUtKS3d5dys1d1Jt?=
 =?utf-8?B?U0crTExkLzI1UUZ1MGtqMHRhOExvaUFQUWZlYVdNR3hHTlVyL2IrazdMNFpv?=
 =?utf-8?B?cFI5eEdyUkJQMFpFQmdsODg1N0IzbkpRZ3hWYkRWNHE1bU9iNDlCd1ZzT2Vt?=
 =?utf-8?B?emVIZjRRYTN0Sk9xbHVYNjl2U0l2YmdMbWxxdnFvS0N3MjJIdFlRYTJnYzNu?=
 =?utf-8?B?QjAza1RSalNtTk54cE1ZQWw1QWNmbEM1dkQ2bFc5WXhXNzBYWDN6QzdhWFA2?=
 =?utf-8?B?QTVnSTduU1hXTHN1N1hpRVNmZmVNNTZZU3JGUElCQ0tvMEQzVmtkazV6SHZm?=
 =?utf-8?B?WmhIMnNGSEhiRGJsZGRlb0dPeTkzeVovZXdYNU8rOE90TkpFM2phK20xVjhP?=
 =?utf-8?B?NEg2eExXNG1jQmd6YllRRVFSTDFsdTlqb2hTMUFPQ2xBSkVEdTMvUUtFUjQ2?=
 =?utf-8?B?c3JNcHFYV3JsaVJFaWswNEhZcU9OWHgvOFVzTlMyKzR4dDByc3JBeUhLbi9H?=
 =?utf-8?B?RERCam9BVklkeWFpUDNJbXl5ZDZiVVl3WGM0WVlqNEpHYk1Icm9FYXh5bGVJ?=
 =?utf-8?B?ZWp0UlBjZStXTjF2NHg1M0w3QWN5R2s4anp1d2tqMVFXem5LbFdBWTBncEF4?=
 =?utf-8?B?a2ZneHBkdjM2cGUzemVUelFxcEJTRkJ1WnZvNW13N3VOMXN0clA3S0NLSXdp?=
 =?utf-8?B?NkJNam5MbUpiS1BCUFFoOVZ0MXgwZWxzUXR3SWV5cjBlOWh3UFlOWlE3MmFz?=
 =?utf-8?B?alJ6SlI4ZU1qSzVuUWdjQXZkbDBRdDVwR3QvRDJCaHZUZVBaYkpMdkljemxJ?=
 =?utf-8?B?YWZCSVEwQ2h4Ym0zV05SdWFQdDEyQ3JIRGZSL3FLV0pqWHdOTlV3dHRXK2t3?=
 =?utf-8?B?bFNReG5IakRmcGxZWW44dkdsRnc3cUdyRmRKcVk5a21LZkhGR1E0Rm5xM0lu?=
 =?utf-8?B?TGxhRGFObm1TVmhVWGNXcUVJRVNLU0c2eU8zVGhTcS9VN0pSTVBCMi9DdlZZ?=
 =?utf-8?B?dWg3L0JLVXNiYjU0VG1HQnFhSmdmVFIvbWNGR2xqbCtQZi9mNXIzbWYwV0g5?=
 =?utf-8?B?LzB4cEJacVlDMlcwTVZ3U3RNNzdFYlBlSVpwRjFOV0xqQng3R2pXcTlQMldF?=
 =?utf-8?B?THM4SmNFMnlpaUdKaXlnSTU3VklTQ1BNMjE2c2o0ZDZ0ejl2WDFZckdrLzl0?=
 =?utf-8?B?WlBnZk02VlE4dlcrdFQvREJYdzJENTlZUjZmZUU4eXkrT29BYndaT0V1N2NX?=
 =?utf-8?B?dzJ0K2d2Ry9rR0MvYlQ0a001MFNDa0FaMmsrZkRlRmxVM0oxZ0hHUnM5SVkx?=
 =?utf-8?B?N0VXTTU3TXI0ZGJYcTZZTmtyemwzUVB0QUFYWElrY3BZQzNsQldVRTFtdVpi?=
 =?utf-8?B?RUhqVnh3b0QwN3I0U3hKcCtLTEk0dHN0R3ZzYTNYbCtCVVJxN3VESmMrdWxr?=
 =?utf-8?B?dlFtK3pENTk4ZngvVS9wVEw4b2xpaXh5RlJQMVJsVlpBdXhackFvUWxjSytN?=
 =?utf-8?B?dVJjT1JVYVhIcHFzMUdSU3F3eXB3dUZUdndMaGpWN3NYUnFnSzR6R3d0Q1RT?=
 =?utf-8?B?ckUvMmRBSEdLSnVGMXRxVmtTRy9XM3BCdmxUQS9CZVU5ajRZWmxkNUJlMDNU?=
 =?utf-8?B?NTAwOHQva2RmM1VqQ21BYjVKS0lKOFFycmR4QzdHQzMzUmh0d0szTGRiT0Nx?=
 =?utf-8?Q?RQCIqHVK2RfCk1CI=3D?=
X-Exchange-RoutingPolicyChecked: 5HuX9Xk2cwfASqZHgqzzur3Md+vtx1Upa6Nzxqq8J3QvCr6GhVNrcuCQkNzRp32bh7GFa3hnBZxoxZJ0+BkofsdIzxKh1y+NjaOZCbA8z2RPYzFlcBJDeJA/jH+V3vjw3lhegI19JE4s/n5fWr/nN3tv935J+h3WYwSoVCZp9M/8V+H/1XsrY54X0B3FjdF4AmHPDcjzOVeGh6yCzm/mG/Qljg6nvRg3e/X1Z3r1HPdHZDmLwY7cpdmvWJITOhK0UlY815tid63NSgh5j7e78q+3B50R5jcDcMWkw7P6bD0BKPBIU9gyQ+xNCVmTwuiesutH/Px2YhL+2R7yzL3s2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc2b201-bdff-4975-f16b-08df02a76546
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:50:09.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q/pWD2tRG94OeozzPkfGKHWIiQGocpsddyDupS/O+cM0ldV6hRIUQ3BbclPkhdffozCMx33cDbHo7pg73arFiv/LPuVZQz1+PuqRd88eV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7505
X-OriginatorOrg: intel.com

From: Alexander Lobakin <aleksander.lobakin@intel.com>
Date: Tue, 18 Aug 2026 17:51:01 +0200

> From the first days of XDP implementation in idpf, it relied and
> worked solely on top of the queue-based scheduling Tx mode, which
> basically means simple FIFO. However, turned out not every firmware
> supports this mode and XDP doesn't work there at all.
> 
> Since the flow-based scheduling Tx mode is mandatory and supported
> by every FW, introduce a simple fallback guarded by a static key
> to not hurt the more performant mode. The FB mode generates a
> completion for each Tx descriptor and never guarantees that there
> won't be any out-of-order completions. Serialize that using a
> bitmap of completed descriptors and report contiguous blocks of
> free bits to match XDP and XSk expectations and avoid further
> code complication.
> 
> The usage of a bitmap on hotpath might sound scary, but this
> fallback is able to reach around 70% of the QB mode's performance,
> which is comparable to what ice gives us. The main bottlenecks are
> unlikely()s and one completion per each descriptor, while in the QB
> mode we have one completion per batch (which might contain 64 or
> even 128 frames), plus the size of the completion descriptor is
> 8 bytes in this mode (4 bytes in the QB mode), which means a lot
> of additional PCI traffic.
> 
> bloat-o-meter shows .text increase in about 2 Kb without adding new
> functions or uninlining any of the existing ones. I played a bunch
> with inlining and uninlining certain pieces or the whole fallback,
> but the compiler collapses and optimizes libeth templates so hardly
> so that each additional external call only makes things worse.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Tested-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Comments from Sashiko:

> ---
> I know the window is closed, this is to trigger the validation and
> for eventual reviews.
> 
> From v1[0]:
> * rework static key management: move to idpf_xdpsqs_{get,put}() to
>   avoid refcount imbalance issues as .ndo_bpf() is not always called
>   in pairs (hardware reset etc.) (Sashiko, internal Sashiko);
> * don't zero the whole pending window but only the frames sent since
>   the last batch to avoid missed OOO completions (internal Sashiko);
> * micro-optimize idpf_xdpsq_set_rs{,_fb}().
> 
> Regarding the rest of comments:
> 
>> Could this sentinel bit cause a deadlock if the queue is completely full?
>> When full, next_to_use equals next_to_clean. If the hardware just completed
>> the oldest descriptor, its bit would be cleared, but this __set_bit would
>> blindly overwrite it back to 1. The completion would be ignored and the
>> queue might permanently stall.
> 
> Intel HW works that way that we can't fill the ring completely. We need to
> always leave at least one descriptor free, otherwise ntc will equal ntu
> in the HW and the queue will stall. So in all sending routines, our budget
> is limited to `free - 1`, meaning the situation described above can't happen
> (next_to_use never has its bit set to 1, so it's safe to use this bit as a
> guard and reset it after the bitmap search is complete).
> 
>> Is ret bounded before it is used as a bitmap index here?
>> idpf_xdp_parse_cqe() returns upper_16_bits(val) straight from the device
>> completion descriptor, so ret can be anywhere in [0, 65535].  pending_mask
>> is allocated with bitmap_zalloc_node(desc_count), where desc_count is at
>> most IDPF_MAX_DESCS.
> 
> No cards under this driver have ever been seen writing garbage instead of
> the completion tag.
> 
> [0] https://lore.kernel.org/intel-wired-lan/20260708151327.1091570-1-aleksander.lobakin@intel.com
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h      |   1 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h |  18 +--
>  drivers/net/ethernet/intel/idpf/xdp.h       |  73 ++++++++++-
>  include/net/libeth/xdp.h                    |  13 ++
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c |  12 +-
>  drivers/net/ethernet/intel/idpf/xdp.c       | 131 +++++++++++++++++++-
>  6 files changed, 229 insertions(+), 19 deletions(-)

[...]

> @@ -197,12 +229,25 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
>  		xdpsq->pending = 0;
>  		xdpsq->xdp_tx = 0;
>  		xdpsq->thresh = libeth_xdp_queue_threshold(xdpsq->desc_count);
> +
> +		if (static_branch_unlikely(&idpf_xdp_fb) && vport->xdpsq_fb) {
> +			xdpsq->pending_mask = masks[i - sqs];
> +			xdpsq->last_ntu = 0;
> +		}
>  	}
>  
>  	return 0;
> +
> +err_masks:
> +	vport->xdpsq_fb = false;
> +
> +	for (u32 i = 0; i < vport->num_xdp_txq; i++)
> +		kfree(timers[i]);
> +
> +	return -ENOMEM;

> Does this mix goto-based cleanup with __free() declarations?
> The kernel cleanup guidelines mention that the expectation is that
> usage of goto and cleanup helpers is never mixed in the same function.
> Could this be converted entirely to scope-based cleanup to avoid
> violating the cleanup subsystem rules?

Yes it does, BUT. While you can you __free() for pointers on the stack,
you can't use it for pointers in the dynamically allocated array.
So the arrays themselves are cleaned up automatically, while the
pointers inside them are freed manually.

The sole alternative solution would be to free everything manually, but
this would complicate already quite sloppy code even more.

>  }
>  
> -void idpf_xdpsqs_put(const struct idpf_vport *vport)
> +void idpf_xdpsqs_put(struct idpf_vport *vport)
>  {
>  	struct net_device *dev;
>  	u32 sqs;

[...]

> @@ -250,6 +308,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
>  	return upper_16_bits(val);
>  }
>  
> +static u32 idpf_xdpsq_poll_fb(struct idpf_tx_queue *xdpsq, u32 budget)
> +{
> +	struct idpf_compl_queue *cq = xdpsq->complq;
> +	unsigned long *mask = xdpsq->pending_mask;
> +	u32 done_frames, tx_cnt, new_ntc;
> +	u32 ntc = cq->next_to_clean;
> +	u32 cnt = cq->desc_count;
> +	bool gen;
> +
> +	gen = idpf_queue_has(GEN_CHK, cq);
> +
> +	for (done_frames = 0; done_frames < budget; ) {
> +		int ret;
> +
> +		ret = idpf_xdp_parse_cqe(&cq->comp[ntc].common, gen);
> +		if (ret >= 0) {
> +			__clear_bit(ret, mask);

> Is it possible for a buggy or malicious firmware to return an out-of
> bounds completion tag here?
> While it was noted in the commit message that cards have not been seen
> writing garbage, firmware is considered an untrusted source by kernel
> security standards. Could a large value in ret bypass the size of
> pending_mask and cause an out-of-bounds write?

Tags are written by HW, not FW. If we needed to verify everything that
HW writes, our best would be 20 Mpps instead of almost 100 :p

> +			done_frames++;
> +
> +			goto next;
> +		}
> +
> +		switch (ret) {
> +		case -ENODATA:
> +			goto out;
> +		case -EINVAL:
> +			break;
> +		}
> +
> +next:
> +		if (unlikely(++ntc == cnt)) {
> +			ntc = 0;
> +			gen = !gen;
> +			idpf_queue_change(GEN_CHK, cq);
> +		}
> +	}
> +
> +out:
> +	cq->next_to_clean = ntc;
> +
> +	if (unlikely(!done_frames))
> +		return 0;
> +
> +	tx_cnt = xdpsq->desc_count;
> +
> +	/* Don't go past next_to_use */
> +	__set_bit(xdpsq->next_to_use, mask);
> +
> +	new_ntc = find_next_bit(mask, tx_cnt, xdpsq->next_to_clean);
> +	done_frames = new_ntc - xdpsq->next_to_clean;
> +
> +	if (new_ntc == tx_cnt)
> +		done_frames += find_first_bit(mask, tx_cnt);
> +
> +	__clear_bit(xdpsq->next_to_use, mask);
> +
> +	return done_frames;

> If out-of-order completions are processed, could this cause the XDP Tx
> cleanup timer to permanently stall?
> If completions are processed in the loop above (so done_frames > 0)
> but the descriptor exactly at next_to_clean is still pending, the new
> done_frames calculated here will be 0. Returning 0 back up the call
> chain will reach libeth_xdpsq_run_timer() in include/net/libeth/xdp.h:

The timer is cold path for cleanup only (as hotpath only cleans 1/4 of
the ring at most) and is run in 1 second after the last completion
polling, meaning no traffic at all. Hotpath will still try to complete
descriptors each time a new batch is to be sent.

> +}
> +
>  u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
>  {
>  	struct idpf_compl_queue *cq = xdpsq->complq;

I hope that explanation is enough.

Thanks,
Olek
