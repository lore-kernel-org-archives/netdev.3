Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689624FC35F
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664437; cv=fail; b=ZX0j8/GydrgIEUDmK14qNHPeoPBAIR8AkzpydtoRpw7kDWYyy1S5Qa31li6uVmY5jFq1Jy0n+8rop4D4JTpXfdY+hARcbPrU51sD7nYpXLLA0LXGL88v1/vhZ2bS0QiSTPZFkRiH45lm1LOJdAqhgOYLl72DH1KSNrrWBLH0Pnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664437; c=relaxed/simple;
	bh=gCaxjpg7P1Ntel8sTYWYKn5EFnGVxn3B/XfqAVknDyg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9q7Yj3BRnYFgJOiWckgj4FiY0kxbtyaBP1fwk22alVIytsEyYfYwv4Fsy1Y7uOMeEDHwZAfRVxCdYkrL3DnGa1Lw1GpHQ6GE/H8pXHSCtlAMTwuVrFrIvr5SbXFBy/tvG2RsjghFPgC5sh4YY8/G3THHe9f0TOWdyMUYWBVTfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGtDch2J; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGtDch2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789664435; x=1821200435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gCaxjpg7P1Ntel8sTYWYKn5EFnGVxn3B/XfqAVknDyg=;
  b=aGtDch2JOZvxOsD0fD8ClHQMjl9ipMkDWC6IW2xuQuQO9h1t6nPwj8pi
   b6hb5H5xaD5AwE0WTV0fu9RcH0u1bGtlctf2OVI0xKw8iBGHckYrI2aYP
   40tYD/Y2qoJlaAEgQrinU9/xJO2/NTnmny8PekvAuCBqxYZwzwZITDQuS
   a21cNCFJq2OWINhMwmknCwFFJDqszTQUzbbXkEGjpcZ2/KCijBclG7+DK
   s527etRz+F9tz2mlg1LktTA9P5w9b8FO08JUv84ls4UPsITk3iTYvKs25
   f1gV9ghNndE1Etxw5SIE4Ga0nwCofCoDPtkitlrWN2vWQ1LncvlmJYkLx
   A==;
X-CSE-ConnectionGUID: ++hl2shdQO+baudEjfekUQ==
X-CSE-MsgGUID: Yop/JLt7S6a75x8+bOOb0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89042503"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89042503"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:00:26 -0700
X-CSE-ConnectionGUID: 1ySa6x/uScObwhEJyn1i4g==
X-CSE-MsgGUID: n1H8y2JcQSOiPqTK+9yGjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2341883"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:00:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:00:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 10:00:25 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:00:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btvevtBGwFfbab5LWXTlzA919I9gnkEUN4VKqbRM7kvzGG3qhSwVOaCRf/c1me+FK4QK916Ja0e4LZp8HAcAfML8ZhjR03nUK6UuDX/02BWodJMYGZc11kBKhUZnlb8VsHVZuSaR1veGDZ6ZHRL4HM0J6xTWAIusPT7kp8JMChrnEzFU4LlbeRk4D+ZsUtqG2AK/Ymh1O+5Edxgzf+LdDe9VsDrdMDBwLlPoi277ZUst/5zc8FFsDlztGQbLaiBk7Qny+VYR7fWE/ev3YVHsCkXTbZ8P1EBKf/8zOa9vwFBDbrwCJoiJp2IZ2lyVNtqtthjAgA6dDaxDgUzJP8Y7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nK6fR0+TGWUP4V//+LEzBdS8Mjp0k0OBvzLao9D7QI=;
 b=Gdnf0+Cx1n2eXV00jtTyFihRNdbrcgh2karILARfSRKx6OsnFlP+zT3QxyUugmRE8PwJ+vVtNJK3/1CWmkWwh2axiA8q5Lp3jo1g8G/Nrh/qq08CD/Lkx63+12pKTw5NqFkq++0ZhQ525p5a0RJcCZFQv7Absb4CGquulmelk/Yr5jiKQs4NycHxo+kWV9+CrYZXPq6uxbtgzMbBx9KFls2oJtxlRntuUMQqdYFCeQzRMgOR/zffPsmsZXhSY6v2vX7Ck1avEVeonKYvBmio/fLNyk0PnwSMwz6LlgzO7lDoK2EHSMd8xs2gXllZLojUMrlBkjwpjLvPYRSts+W0Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by DM3PPF31D2DA56C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 17:00:20 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 17:00:20 +0000
Message-ID: <b172f10a-837c-4adc-b7d5-dd34ed544fb5@intel.com>
Date: Thu, 17 Sep 2026 10:00:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/15] ice: wait for in-flight Tx timestamps before
 flushing the tracker
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-11-anthony.l.nguyen@intel.com>
 <20260916011223.1632696-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011223.1632696-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|DM3PPF31D2DA56C:EE_
X-MS-Office365-Filtering-Correlation-Id: 00675bbe-e509-47fd-fab6-08df14dd2844
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|4143699003|10067099003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WjE1SOLbiZuRVBEJpQcqQXHobj+n4yFXM25a8KZWpE7fFKLBnWJZXbQvXta9Ae//kJCB9tr6OfxnqxK7PjMF3gxu+ZgaJrD4BA+kkYc3bPC2g9cBJ5gnWRd8d7EM2E9sF7y7s9wW+Xa+sfBOVRpZ1dbf0limj5u1FgjHr8eg4iGluC6okvBrlmQJRcgiMjhJV/nfy4aao3A4As6v2iICGTEWPxIYXIYOznsNbZz7ArUXGrfGFluln3wAGx6X/sUaXoBFqCrC/kaFTxGGkHTPOQ8/BTlZfq9JXOuTJU2Q4igIcd8L1kOav+iu29mkLYJjEbBCO3N/0HbmO28NLFbU1hHF3HvXGf/U2y/FCmQLJJmIDe4poY4sMlXDhNJ4OTeZlRixnkV4Wl3LMr1DSlE79B8YIZfLGxnnY8vmUiWjlyWkeZ/5IXJs4f5u6+1KhlMk09DpPZZiK9/vUftr8mxQ3TPMRNjhO8KKYDIKf1pVkVOJ3LRR2pAUuTmO/a5TAh2wmv3EbSLzfCX1RKebi412kzHv9IX12rznraezyttKE3RNWx1ef9l2zNK148mkvBHfNa9IfaN5h8ehJiioF1P2Tje/VJaPde2AznvWs9sfeY0srBdGQ46FjDAtw1tTOfn+r8Dyv9Mr/NN7r+E9wJ6CRhEyWcVmwzpPw0ZjpBqMEb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5GMnZjK2JuYS9MQlI0YlhQWG5sWmRKa0Y3OU4zMHhwRFJTVVFKRHVJYTls?=
 =?utf-8?B?ZWc1SEd2eWI5RXZqK0Q3L0c3ZzF5OEl2ZmlXQTgxQXlrcENWSTZiWWdaY2J1?=
 =?utf-8?B?TzB1TVBIQTRMQVhRUDJTRTRuVXdDMzVnOGI0TlRtZE4rVkQxTmFHbHd1OEpx?=
 =?utf-8?B?TFpxT0lhRDZNeUM0bDdySEZhUGk3UzJpOWU2UW5mbHQ0QUdreXdsVHd5RlZs?=
 =?utf-8?B?eVdmTDh0TW9UZExYSi9RTm9sVkZ5L1M1dVh5dFduTmxlSlJKWmQ2eGFBbmRo?=
 =?utf-8?B?dncrZ2pzbFpvQkVDOW00Vnh4VlhtbVBjZFNCb0g2QWducXBHUlBkWm9PQTF1?=
 =?utf-8?B?TlFRZCt2WXFjUS9oZys4bzZJZFlmMEluTUt0Q2VlYzBwdFRVcGF0L1k3aEd6?=
 =?utf-8?B?M3pCck56VXV1S0kwV0h4UWkyUSs2OVZXbFljZEswYXRweTVDODM0eStrT3NK?=
 =?utf-8?B?SDRPcTRLS1MxcTVsRXBEM3poOFFiSTRrRVZPSEFXNUpkckRpYitKWDcydG1V?=
 =?utf-8?B?b015OWhMRVBBQjlxOVdhRFpEUEZSeHdGUnN0TTlVQVNqemhNNFlvK0krNmxL?=
 =?utf-8?B?eENnN2pvNHRwZ3BXQlFudzJWNWpKdWthOE5HK2FtaEg1dVBsWDJnSitOLyt2?=
 =?utf-8?B?WVJOakk2TjBLWmFNOEpiNE5MUnk2Q3pOMjkzS1UyMVhKNDJqSzNJeEY5OWRx?=
 =?utf-8?B?V3MrTElJS3dJdllQUkUrWDBXWmxwaStYQnpEWW9jaGhVSzlLeXBMWjZKSTVn?=
 =?utf-8?B?b1hxcU9qRm1vdWVzeEI5Y3hwOUpyWWxhTVRUdnU4ZDhnVWxwQ0lHZkhjRmU5?=
 =?utf-8?B?L01ENUxoMGxsUk15S3JtdmVsU1E1SlB2aDFqN3VOY0JadU9jYWJUcWpYQjVx?=
 =?utf-8?B?dHhtUGZlSXhXMGo5UHpPTVNrd2wweG5QdFUyK2R6ZmdhY1d2bk1MQVhZRDRY?=
 =?utf-8?B?b2c1bHpEQ1RJV2JUQUpJdnZZenRZdk9GWTBxTGllbkRvQ3JSdXMzbWVSY3BT?=
 =?utf-8?B?Rk1DeEhhcVZkZU1XTkxZT1loMEFDTEtjZnhLcUNrekoxbEJCNDQzcXVEZzJk?=
 =?utf-8?B?N3hPUlZRV3ZlOTNUdm5iSlIxbnpBSTlRTTM2WnREVXA1akd4ZDNud0JlMWpL?=
 =?utf-8?B?MjBEbnNuRDNvSWNtV2loWmo3L0dMMW4wb25IR2hydFBZL0J2Sk9UcnhVbVNy?=
 =?utf-8?B?K0hYa3MweVplWHplSnB1YjFlTVdoc044bG9JSUlxZ1lpaTZhLzh5Yzl4aWp2?=
 =?utf-8?B?R0M0QXRaZExVejNmQXQ4L1FwVTRBUFZPNUpta2V0STZqTjdPYWtBMnphbllj?=
 =?utf-8?B?aG9PMStxbmpzcGsvNUlLc1prMzd2QXdGb00rbWNKVEZWQXVVZkFtd2ZiN0R3?=
 =?utf-8?B?bDQxUmRzZHR3R0hVTTQxQzQ3WjRVQ1FtRHAwNGNEQndOSjg0ZFk5MUF3V1FN?=
 =?utf-8?B?c0ZGTkVrSDRyTG1RY2lFRVZGWWJGR213ZGpGM3prT2dtc1d6R25ocUxublV1?=
 =?utf-8?B?cmxqai8yTnJqdUhHY1RUM0FqYmF2cUhaTk8wWEc5L2RLVm14U29pVFhUQVVW?=
 =?utf-8?B?d1liQkFNWXBwSFRobzBveE4yTFBMWFZvQnlMaEtCQm1KZzFkUFlQL0hYckd4?=
 =?utf-8?B?VzdCSU1NeXAzRGorMnpFTTRFbXRoZlFFTEdQalFjVWxXZWtmdHdaOVdKVjNr?=
 =?utf-8?B?S3NkUU9MZkVudjl0Uk1EQURjRlFZQ1ZPWjkreFYxeCtwUjRBNTMvSGJnK0lo?=
 =?utf-8?B?elNDNXdsTGVMNTViNlFUVHYvTlNITElQSUJDbzN1OHZOL2ErWExueUFXR3NB?=
 =?utf-8?B?bnhKSTV6TXdibjFnL0xDOFczZk1DS1FaN0dBbHFLS3c5Yk5lWmFiUG1tSVZa?=
 =?utf-8?B?R0xBTjVEVmxJTWs1SVRXVVl3TkJwd3ExSUlteHVrdlk1QURITDZQcjFEa2tN?=
 =?utf-8?B?S3c4cDBKaC9JazFvREUvSjU0K2pZQnFoL1VOeWVjV2dpblZIckErVy9lcHRK?=
 =?utf-8?B?YW9CbmZFVHJjNHAya2hob1R2S0ZnK3JxeUJ4RzJ6UFNjZ25hTldzK0J1N0Za?=
 =?utf-8?B?Z0JjVFJKRnlBdXhteGh1eDJML2didDNjSHA4U3k4R0R5RzdHQllrMTRrZ2Ev?=
 =?utf-8?B?enVrekliY0xDbzR3OWg1blUrUzJzUkVBakdxR2pSMDY4Zzhxam5JWHBsWHRY?=
 =?utf-8?B?b09SV3NNWGVzMkpWVHVjVEhOSjJ0VVdrZ3VlaTB4YWZhR1l5ZW8rd1owRHJi?=
 =?utf-8?B?Q0liYTgySmVTYUROV1BudDdzdGduMTBKekxneGJqOWp2UmxCQ0owU1BjMHRx?=
 =?utf-8?B?YU1BT3ExQVVlTytzMEhpNGJwMGxZUHdqYVJqeGsweTcvWDlBT0tqOXM0MzVH?=
 =?utf-8?Q?KFnrcwNQPVbnHMEU=3D?=
X-Exchange-RoutingPolicyChecked: h411woZPYufAT08Tw8gZgG7LMZfjdPpuUcSIDKjB1RcxAic4Po5RmOe0c0hHPS62gu8GzbNAcwRWaxUV/VJZtdjBU+CR2ndhNfmbfjffwqh2H5Y90Ol85P8aHxSBKGn1+7qjytizuWZ0ZK8OI7arbLnFK9nkzUqZsXM6a9XImu6B5sUSgvL7vMgWJ34eVeWMgpNKYzwFri4q8dgeDS96uRw7MI/ly0kGf+0BcizkXyc871BQT6Nt4EgJE2SNCroQGaHMpdnzybmAuQJzt+VtHps6VkwVeUw+fMBKaIdmZ/ubmdxDIO3PykKzRQeHyiEK9eyMbiO/NObIvZBgC6+/pg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00675bbe-e509-47fd-fab6-08df14dd2844
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:00:20.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jpXp34rdtBAZyGqbkJNTejyjtiINXC+ZMDFviSLcRwONXHs+/haHJHL1eoEDDU3HpYAWxzUfnHEt+RCWg0J9MDHDxbvo4OYNfl5FDz5+QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF31D2DA56C
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> Here is the report:
> 
> commit fea79aeeb67734d73dbd19b0b88b152cd016c86e
> Author: Petr Oros <poros@redhat.com>
> 
> ice: wait for in-flight Tx timestamps before flushing the tracker
> 
> This adds ice_ptp_wait_for_tracker_drain(), called from
> ice_ptp_flush_tx_tracker(), which polls the PHY Tx timestamp ready bitmap
> for up to 10 ms so that in-flight captures publish their ready bits before
> the tracker entries are freed and the ready bits are cleared.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 4dec728e219d8..b142b779dc105 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -740,6 +740,37 @@ ice_ptp_alloc_tx_tracker(struct ice_ptp_tx *tx)
>>  	return 0;
>>  }
>>  
>> +static void
>> +ice_ptp_wait_for_tracker_drain(struct ice_pf *pf, struct ice_ptp_tx *tx)
>> +{
>> +	unsigned long deadline = jiffies + msecs_to_jiffies(10);
> 
> [Severity: Low]
> Is the 10 ms budget the commit message describes actually available at every
> HZ setting?  With CONFIG_HZ=100, msecs_to_jiffies(10) is 1, so the deadline
> is a single tick ahead and the remaining fraction of the current tick is
> arbitrary.
> 
> Since the loop body only sleeps 500-1000 us before re-testing
> time_before(jiffies, deadline), can the whole wait end after one poll of
> roughly 500 us?
> 
> Would a microsecond-resolution deadline (ktime_get() plus ktime_add_us(), or
> read_poll_timeout()) match the documented budget better here?
> 

I'll see about switching to read_poll_timeout().

>> +	struct ice_hw *hw = &pf->hw;
>> +	u64 tstamp_ready;
>> +	bool pending;
>> +	u8 idx;
>> +
>> +	if (hw->reset_ongoing)
>> +		return;
>> +
>> +	do {
>> +		if (ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready))
>> +			return;
>> +
>> +		pending = false;
>> +		for_each_set_bit(idx, tx->in_use, tx->len) {
>> +			if (!(tstamp_ready & BIT_ULL(idx + tx->offset)))
>> +				pending = true;
>> +		}
>> +		if (!pending)
>> +			return;
> 
> [Severity: High]
> Should this read of the ready bitmap be gated on tx->has_ready_bitmap?
> 
> On ICE_MAC_E810 the flag is cleared in ice_ptp_init_tx():
> 
> 	/* The E810 PHY does not provide a timestamp ready bitmap. Instead,
> 	 * verify new timestamps against cached copy of the last read
> 	 * timestamp.
> 	 */
> 	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;
> 
> and the backing helper in ice_ptp_hw.c is a stub:
> 
> 	static int
> 	ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
> 	{
> 		*tstamp_ready = 0xFFFFFFFFFFFFFFFF;
> 		return 0;
> 	}
> 
> With every bit set, doesn't the for_each_set_bit() loop above leave pending
> false on the first iteration, so the helper returns immediately without ever
> sleeping?  That would make the wait dead code on E810, which is the device
> named by the Fixes tag ea9b847cda64 ("ice: enable transmit timestamps for
> E810 devices").
> 
> The other consumer of the same register in ice_ptp_process_tx_tstamp() does
> gate both the read and the per-index test:
> 
> 	if (tx->has_ready_bitmap) {
> 		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
> 		if (err)
> 			return;
> 	}
> 	...
> 		if (tx->has_ready_bitmap &&
> 		    !(tstamp_ready & BIT_ULL(phy_idx))) {
> 
> and the kernel-doc in ice_ptp.h states the register is only valid when the
> flag is set:
> 
>  * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
>  *                    bitmap register. If false, fall back to verifying new
>  *                    timestamp values against previously cached copy.
> 
> Would it make sense to either skip the wait when
> !tx->has_ready_bitmap and use the cached-timestamp fallback on E810, or
> adjust the Fixes tag and commit message to describe which devices are
> actually covered?
> 
> Also, a device with has_ready_bitmap == 0 whose stub returned zeros instead
> of all-ones would make this loop burn the entire budget on every flush,
> wouldn't it?
> 

Yes, this really shouldn't be done on E810 device without the ready
bitmap. Will fix.

>> +
>> +		usleep_range(500, 1000);
>> +	} while (time_before(jiffies, deadline));
>> +
>> +	dev_dbg(ice_pf_to_dev(pf), "Timed out waiting for in-flight Tx timestamps on block %u\n",
>> +		tx->block);
>> +}
>> +
> 
> [ ... ]

