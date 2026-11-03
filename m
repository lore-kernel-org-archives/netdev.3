Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793740049;
	b=ilBpOCxxxQ5/tH3eoKYkrqIAoHH89cO7xuBzepLH4VLHvnpaBVSg+r5uKicE1bKBHbVO
	 UlmgCI59KO62h6APc2bPX+Hgn6uJqRlTaq2D7SgAKW6B3nT2i11cJ/wMO99GDOc1xfiFZ
	 syhNtOz0GNXV9KQMA7JoD0Eo/0LJ/WqOoJXQj1nGsTLt8f9tafquW703cbb4J2HT1Y6wK
	 zoJ2YYdpLMXqJjKPaMG5q51ZP82/lM5680IMiuS2DppECTP6Mwo7GZwdmx4gC3ubLPdq1
	 fCs9a0abbEJuNx2ND3u05bkAB9E5glVkEDmNx9+Ai4FJVKrOooB74C77NcCduM+Hq/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740049;
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
	bh=lKxRkOuytkT2IYu2y21B+/Vg6a54OskaPbyyz5XH/I4=;
	b=c0ypHZqvLla/vVbJkGBtJfHTLGweiK2zPEWJXWo1bl9wUrbV+lKnyi0fGw5XzHuIRsGy
	 06Qig25u0ClHRDnGQa+mjZrOl7YBiT8KOjVSOHICchzhpKW0xBD1HoYFISaytoea8/Nhl
	 iwoX2u1BEFSJ1QnagiDF7DxjQmLo2SxMn+0nl1vjVgwjiM6DUINfkpYdjz8r2+nMQAJ5m
	 voP1GO2h1JTnhS6RUV0WPyRdGSBmn2ysfV+O00bzOfMX5sGmLiByWQ5lWkJyCMYs6pMU3
	 0OW9K5nXCEJyam+lnQsb0TmJdYfSlc73NQ+ChNP6Xc590S9fPPmfTtP/VGTNfune7Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VMVMYHEe;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62D606A31B;
	Tue,  3 Nov 2026 21:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A62D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VMVMYHEe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793740048; x=1825276048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9lb5jKtVHksprCwcQKcbA1uepzeiA+5vnFq4C61qoyU=;
  b=VMVMYHEe2AmeH30qhmc6BbWgMWHL6cSxCGxSPKz144MlDqyIehR8noJB
   Gm55MJ8pmZoMdZxyFKxsw2Z9YaR3J1TdqMdBnElT555lBtQKX+cQdBzfk
   qwZy8h2WxmArEhqyOzP0kuoelVOltR0R8R1qaYzMhSd3QHIVqv0U6D71S
   NHft0FZo5y8Z/fJIb31ltYr9CqxZqEmQ2DDrl3sATDW6olSG2enTATbD+
   e3MUwsv6rOV2CBSaS1QtY7uaNxEbJXGo3BVomWTdV7M3wXXz3F6GxtDRF
   EaITu3XaxHz4ynPEPkHA3nzKDYA+CRrVesSCQVtddewXkahtL2MJ4Fp3w
   w==;
X-CSE-ConnectionGUID: bNinAbJdQCya4X2Xw9ZkbA==
X-CSE-MsgGUID: c35OF9gpS8ulqOyWoylu4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2494518"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2494518"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 13:07:28 -0800
X-CSE-ConnectionGUID: pgadYILCSmqhFAZd5pdbVQ==
X-CSE-MsgGUID: +ASSomcKQiy+3qPFb9eurA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6854509"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 13:07:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 13:07:27 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 13:07:27 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 13:07:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UL9zO0lw7VXGsGwUtlIAlRN1O8l74ob7/vlh4+H1PHc/ElkYrEM6fGb0B/9m0Yw4hbKdHQclFOqUqFWglHrsupO9lHCfmuyjAYzWJoZ8nIcqxkTmA6SmdyzjJzfylV66pQXDpkxUM4ZqN5O5p7rCcTYslbJUyAg9FEVt2P7xscte5o66a/bpfnZ9/c+blw5RBCk3PD1uBOyNdTYpLos/9gyOFbEis2tjS6QrJqDSmWnZ+xjs24KAmmf4zLH4if4FClQZH/Zi3tCHpi6RhIhApytSdE1VQR34tCd+HpAlvYdwYUb4mcO7vVCaKpa8OV9KuZu9fF3z+GZrUmzoAiVU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKxRkOuytkT2IYu2y21B+/Vg6a54OskaPbyyz5XH/I4=;
 b=J8oXxC/6T58HO/EaQEHhXq7JONOn9VP55yXhz6Ruwiqlj1QaXSMVV8vJLT0xOaXaIY0wupKDRTXBGQj/eM16ooiXCbueR0iWAHcaW4RSjscjZWPSb/4Tegk5hZXlnydbdDZIbDYmC9SCK1BuasgBtNNdkLXBugy8jhGhhSb9NLw12hcZd9LIKv8QFL1ps+imoOnc76nNaTYMObNwmkeQh7RnOFa4HUyhUA7IjZ2ifujsC/NmhpGn54TyR85N8AC9gI4+SvZOXmexzKfRJFqIMjSPiLATsz2VHGjjjcaBrq6Bg6ucZmi+EimETDLK53kyFSET7Mz5JhMZzZjXjcyBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA3PR11MB9109.namprd11.prod.outlook.com (2603:10b6:208:572::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:07:20 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 21:07:19 +0000
Message-ID: <373673dc-9eff-4887-b70e-c0d7a17da301@intel.com>
Date: Tue, 3 Nov 2026 13:07:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] genetlink: Reject joining multicast groups no
 family owns
To: <nicolas.dichtel@6wind.com>, Anil Kaushik <anilkaushikwireless@gmail.com>,
	<netdev@vger.kernel.org>
CC: <netdev-bot+sashiko@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Florian Westphal
	<fw@strlen.de>, Mat Martineau <martineau@kernel.org>, XingWang Xiang
	<v3rdant.xiang@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
	<linux-kernel@vger.kernel.org>
References: <179372164269.488856.17448970060747076034@kernel.org>
 <20261103161254.56922-1-anilkaushikwireless@gmail.com>
 <a62aabdc-aa69-4ee1-bf91-606539c6637e@6wind.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <a62aabdc-aa69-4ee1-bf91-606539c6637e@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA3PR11MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: c3992cbc-0cf5-4594-0d49-08df39ee7296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10067099003|22082099003|261102123227099003|18002099003|261026121527099003|56012099006|4143699003|11063799006|261021121427099003|5023799004|261026140227099003|261022105027099003|261028144727099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: T2bhPMkFzI4bPanJLlIccEz9IZBT47M0GBt99gyCYhNWMgGzYXHWOvAYLqzCv74XKm6cBhxZceH7ew3MbEVbWIRMLUBwUg+tTOJVbH+SCwuP2Tf/N240aUombNpxRpsiz7obBRXjWdXO4er3/yEvTd3vDjc5vPeHDkcaIdC5AB1Du+p2C/gvqj8EqUOq1r5mNcfPRCDbtmwVowOi3Y0KwYLofJYn7Rkj91TIFsVUFsubpMmwmvoWYvfq3LC7TtTmWe6OLvwLGleDZEX22BR9fTCRyFOeQXyMJgbcOiUb/RxJNL+nvqg0Weg/T8L4ThrieWumkdiR27N2T9nGY727XOSuicVb8w+7oVbuqH/dJuHqN+mpU6lMZlK2WLVLhzEYj4WJOkC2AFpPi/mjLZynmUKt+8G+2H5ur5DVzNwUyzCRoR8EyjC1zMQJvlZHaU2URgDW+0zXhLs2FudL+YKYtmRZVNm+e5/jRXuBT0wuuoJ7CeN7MJsdJeI4y9e4jWtrGIMLyCowliSgVoyx6W14A8jIEMw1omxyK0uc8gIaEAEIcGUj0wtTCMDh8vvyCxobagekkSkrrWE/6HL+ZQmm+hEBNmvXVt/d8vdu270w3En7r7iJIaMnHJdubaKgaFX61M36XC/0ZumZMZisg7EOfQtP2bN9mjhhSHwQWXZm/VA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10067099003)(22082099003)(261102123227099003)(18002099003)(261026121527099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(5023799004)(261026140227099003)(261022105027099003)(261028144727099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNXeGIvWXc2MHcveTFxMFFWbnZ4UUt2WmttKzRteVFyR1FGMHg1RnVPcS9M?=
 =?utf-8?B?Z2FNcSsxVXJCVXlhb3dYWEtWSWhIMjR2VkZEODFFVWNjWk1iQmM2WXNCVkhB?=
 =?utf-8?B?RE1RRXMyYXhjeExPMUtVeGE4YjFSa21JZUpXS1ljSzhrbnQxejNIZ0w2UXQx?=
 =?utf-8?B?MlpGUGptcXo3WERPTXREZFlKT1lxK2h3Zm9MRlhhSHlKaVkwZ3RLRks2Yjds?=
 =?utf-8?B?SWFSeGFFcFFUdnFmMTNsVjNKUlN5L0JDdkFTM1hUUHlnQzhUZnFzOGNuZ1NZ?=
 =?utf-8?B?Z1h4a1JNUmZsRVhuM09KTGdVdUQ5eGRvbkZONkJENXkyUktvaE1HbmZlaC9V?=
 =?utf-8?B?YUp2N3ZDNEJRUVROVjRuV3ZtK2EyZGNCeW5aUWFjM2IxZlJQOHlzOVZFaTJO?=
 =?utf-8?B?Smk3Mk1MbkhDeDMzTjNEV1BjT2pZK3d0ZEsva2RXTE0zVnFHK1E2U1BYQTlv?=
 =?utf-8?B?MWhpb0lLcCswbkZtdmpGUVF0WFBDMllIYWJoT0ZNWEpXc2FZbUxrUm1JTDNk?=
 =?utf-8?B?dUhiUVRhZWc2VzFpeXdsNG9sV0hFd0hnUUZGNnhCSjhSMUR3MWxKdndkMWZx?=
 =?utf-8?B?cERSeVlabjMyVDZ2MzhYNHdidmx5R0lQcjd1cStGMDRRSHRpUDJZNmlWcTcx?=
 =?utf-8?B?dTNrVDJyNlZ4SDNmcDl6MlNOS1FZK1hHZU9KUDRhcUQvMHNTa3FJQkhleTdE?=
 =?utf-8?B?YkQ0M0pITzNoanZkL0liSDkxVFAvdmxBQzd2Ym5mVkxFSFlhMjhTdXRIdGhL?=
 =?utf-8?B?YTMrQW8yRzR5YzZQMDVoeG1UVWE0bzBPMWhkZGJ3M0VYWTU3Qlc1L2F4VUh1?=
 =?utf-8?B?d0FqRTlQSk5YWjl5OUJkTkQ3c09LandTOWt6dUtwaWdxWEJXVnhFSnJBRUI5?=
 =?utf-8?B?b3F6WXRZdGJYRWorM0o3eDA5V0NobnoyelVzTVdjK2IvSFVEN21ObDBXMWRC?=
 =?utf-8?B?YlpocUFpWWxUSTl6OXhPd2JBOGI3d1RVVE11cmJwNHpQTUIwUDNISnYrWWl5?=
 =?utf-8?B?ZHplRitJcDN1YkVkRTZPTWRoMkh4QlEyVkV4NndkY1BuOFV3dFdFOXkySGh4?=
 =?utf-8?B?cFhNcXhUMGtoSWEyamlMTDNIRjF5WHZRY1R0aXhISk50MDZET0gwa2I0Nzl4?=
 =?utf-8?B?RDVNaERhY0xsQndrcWhUYjFYTHp5aXFxL0dwVHhIQ0M2a3VjZzBEK1JuaEpv?=
 =?utf-8?B?dmpFK3d2TVpydVl2VmJ4N2hqWG5vbFFSbDM3ckRabndKNDQxWEdDdFA2a2U2?=
 =?utf-8?B?dzN0eWFLS2NxeEF2bFVtU1RNTlBEb0VzTkxBWjNFcFpZb3Y5VmdqZGxRMS9p?=
 =?utf-8?B?dVgxbUFPY1NEYlhXMVZObGZtaFI0cjNtUm85OSt5bTNMQXFJVVZxUTBYdzZh?=
 =?utf-8?B?SHJ6aGRFbHpWWW5ubUdBUWtROTBsNk5tRlJGcWpDQlFWVFR1WWlNWHd3R1hW?=
 =?utf-8?B?dzdXSWt5WWorZXJKeko2ZVpac2tWSmNKSlVsVG1SOGZVSGd5YVREQzcrTWNo?=
 =?utf-8?B?cS82RDNzc3VudnhqcThiZlZuMnFLTkxoU3d0MFRncjMwa0N4TDNnMnVQS0NS?=
 =?utf-8?B?Y3dLTkh3Y1FZSStmcWl0Z1BSN3dIa3R5Y1JWT0NtRnZGd0xTQU1IV3JaUG5q?=
 =?utf-8?B?cjRpZjNjUWNjT2dMczRjT0hiemdGSzc3UkVjWDhudFhlM1MxSEZaRHMvUjE3?=
 =?utf-8?B?aGpleGFXaW5UVmZha0lMWkhEa3dITnF5d0h1ZnhRZXNTNzMwT0wxcFJBZlF2?=
 =?utf-8?B?U2lJK0JZMUp5QkpscU55MUlHWEl4T2JFS0htVzNzTjhERG1KOVNvZmNxSjBN?=
 =?utf-8?B?Qk9xdGpDOTBkWXpzcTRPN0tsYnp2QkEyRytQaWtDZDMvVDhqaWV6eEtiNGpx?=
 =?utf-8?B?dHhBZE1WaDFRSjkxdERGV0JUK0hTM2lTZTZQdkVsV01VT2FqQ2t0YktkM1c4?=
 =?utf-8?B?akFYT0tMQmdJNWhEZEkwRkR2T0xwR2VVUzFJNExQc21PUWdtWloyZzZVOUE2?=
 =?utf-8?B?KzZiaUVlY3FMZ1J6a0N5SytXTy9vUW8xMTNySUUyMkVkT3Z1M1N6a29xeStr?=
 =?utf-8?B?dXVMbU9QcHkvTlR4UzQwN3h4anpQUk1Iakk3WTJDTWs4QzlUOEFRVjF4NnNm?=
 =?utf-8?B?QVNIczFMTFVmeEJiOVlVeVB6WUp5eHY5MWttOG5mZ2Z0WVVJTldMcFBRaC9t?=
 =?utf-8?B?SUk5aWN6dy8zLzhNWkZSSHVJZ3BNMXpVNTZLR0QwOXoxa3RVdVJCRk40dTI5?=
 =?utf-8?B?MW4xKzNTVHBkb2U3UE5jOXhHNC9MWkJ5RXFUQmV1T2pmTjRZaXZpTVJKMEZw?=
 =?utf-8?B?Tkh1MDgyNDNQVHFRUWVGVXRsU2N4eUJSWERlWmdud0FBRTZqR0N1Zz09?=
X-Exchange-RoutingPolicyChecked: fgQge8qncsjXVyzSE525nEpj+kj5aKKI7V7ZydIo477tputlnXfcRR7umrg8Y06i2iIo3YXHnkHBoVdQz6LpfC1QhOu5pTuOV7Ak9FO7nhrr6Q1M/p4BcmOUNG/ru3EHKn6FPwZ8crixLfhRM86g/CmbG5WRCbNmmVD0od0aJbgeoHLxIRVoVgkvEH5HfTTw6Vk5/0lY+I7mNE3oR6KxikOyqkCjqTFuThouE3wsCVJSPE9hAmQc5woRw7MPs/jjRL4DBlZ68flrZahFEXpVFXtBDsvY2u+JEwWaiXzU6SXpsTYiO0c3xNfNiULAUYmybas+sPXppCNIcW63uiqVzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3992cbc-0cf5-4594-0d49-08df39ee7296
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:07:19.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/ZhD1y78ci8HbZwN6+OFvaH15dX/7z8fUQQSB0UhiWQSi5E9rBHsuOf5b0ziY7VFvEWLkdJ/EZHNlD+8lOyNW2YJjx1Nxj8w/lf3zR5Dp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9109
X-OriginatorOrg: intel.com

On 11/3/2026 9:54 AM, Nicolas Dichtel wrote:
> Le 03/11/2026 à 17:12, Anil Kaushik a écrit :
>> Yes, this is a behaviour change, and I missed it in the commit message.
>> A bind() mask with an unowned ID now fails with -ENOENT and joins
>> nothing. I don't know of a program that does this.
>>
>> Ido, Nicolas, is this OK to keep, or should bind() skip unowned IDs?
>> I can send a new version if needed.
> It's ok for me, but if a regression occurs, a fix will be needed.
> I let others speak.
> 
> Nicolas

This sounds like it might fall under the "no breaking user space" even
if its quite silly... But I am not an expert here so I am not sure.

Thanks,
Jake
