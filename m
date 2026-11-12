Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794488360;
	b=aKoFkPnMpggtjAQKViqGXP2Z2PbcxkW6bEEN2ZMceEkRZMZ7csrHeWgwCx+Mb6Zzu3zT
	 wV419Hsw2pju/JChS1QPbLT5iNkT10jrtJprvCdYe6EbJ2GMkwjRkgMq8+OREYcwkQGuv
	 coenzYdho67BPLbsOi1PLhjJowi0qwFBXh6Qw/m7wjDlkyZKhR8VXPzp4bEzJQ0KzoAZ9
	 gCOKMlVyq1+C2C2LsPsyC9n0dP3I0X4csUEjWzB1p22O/J+L0eFKp+UaURArZmpyadp8V
	 DgrBgCK1ev3ZJrHtZZMXzTyr66IK4sObMILWfNYKByW4utQwH0kvVHXyCgwXaNcqhug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488360;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=otrPz9KLHoQflFJOYPrmY0DJKWg/ktDMfTNNhxe+Z7U=;
	b=qKzy56rbIsGKWWfFu/L/SCrdKLgqKcB61oIaPcl+YdBPGGU1KtBZ0C6fqO4w3DtkKZh0
	 zpRITKYJLmX/YdlQl4ilMLPLYR1yTX8qsl/heUGOns8NNJ3x7Dd7dQeCVH0vzF6HS2kyv
	 2Zi1FAj7GGl/BBFkp1dpdlFJjbA8ITaXLjv8eAtd/KOtBZieOw4Tp9iyfUrjhh0u4PE08
	 2G+N7n0Z1JRTt1J1xrEvqwYk6sNhh1fJ/Ktq0tlW+doZaOjPAeWS4LoSnuaXyngL/NuU/
	 hFG1zKeZrX14b/wHIisqWjIDWgIyifsg3pMf+DeME9iJDcE6qJzQSM+5f+/R7iPmg3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwnA4mjs;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=auHUyiuQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C726606A321;
	Thu, 12 Nov 2026 12:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C726606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UwnA4mjs;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=auHUyiuQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794488359; x=1826024359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YZv/rjY/CmwHxoxOiyCUIWxMOcjMZJSMz6GH4n4fDr4=;
  b=UwnA4mjs1UBNIpmtnKBWTx8CTxnVDefxZkURccL9D10gN2hu4tppUH8a
   aKiP7DlPVqi/AKBI9VsUmbHgQfHlQ7o0/p3raXeaADqhwWvFHMFojkD/7
   ZXdWOe6H2j86MZl8myNu3eJPQaSTaG51vpX7J9+mEUkX+T7FrpaazEVlj
   JFAt15OKEFs/c1rs3uXCgKmxJgIACmT+LeBtp+hoxf2ZhDFNlWAc6qZfu
   w0e3oDv4faNc+yBdo2F+eAkU+D85G9WbCWFDiAwSN8lIbeO2y5GeGu3sp
   ODC/5SFJ7A9cKC144Cqee8Fg32wCRNSI2xTGS39IB0deZnp9mt3OECJjQ
   A==;
X-CSE-ConnectionGUID: krk9ngZzT5ikS5miHyWVfg==
X-CSE-MsgGUID: afNUNu1hRimkzHQAhOah5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3269279"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3269279"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 04:59:18 -0800
X-CSE-ConnectionGUID: JZt1F2U6S8esqtDSI4KauA==
X-CSE-MsgGUID: 8GBMHZE1TTK4boNSTGQdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8804622"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 04:59:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:59:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 04:59:16 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:59:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmfX7wIEBywxBxnU00XSfYvRMWFI7N7rxt2G/14N5nBO/37pX9p73qipY5F4OIfHJDijfxvV9iNiyYVOmLRNjbeJXcxBXT8cWWg3/wzyiiHCzUsSw9fmKM5B725fY0hONFhEVJGx/orAhw/mpSfEbaa/hRpmnbApcrIcKGyyYk0xKIOCXK/DM2A0O1Al9jZwjpsJP8C8XnW6MZy/L0j70jzzq2Jh7bjz9AeSk8iKCNXljWugyO+WGs4xPXWexGijwXJhOoeJOBFeW2WyTBjPc/lVl0SR5WISM6TQpqitHQ6agWDVi+BhBxrqJ35A6aa5urQhI2rNY1ZnV0JlR2+/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otrPz9KLHoQflFJOYPrmY0DJKWg/ktDMfTNNhxe+Z7U=;
 b=tesbrcih6sxwsC8x/OcbZ1i/bSWTA7l6n3L9DsnUneBULbl3IdjZki04Y2gyZf6rfZUOm0X8LoztKIKxTokTC/A3MEkRESkT+6DHDZ0lIHOzqQFXVVaIOVztUeeasLA8rARPSOWq2N/bWHF2yi6rLTasMHhPgPEkSsLJmH2Oe7viM0CZrxrY5J4n0CMwCvdM+flLGF6TlBM0bv6OeTTVjX9RzN+DboY65HRVDYQ7xy4l7Y1JJetqykdnTi4qmCWW3RlP+k+v/q48P2fmGwAeMzDy+dD3iODsNunfeX7rGS/aQ8FDya8zzILjUmPOPFmrKOs1fdl0udDePYYvqFc0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otrPz9KLHoQflFJOYPrmY0DJKWg/ktDMfTNNhxe+Z7U=;
 b=auHUyiuQ32ZuI5OS//eBuDbwzvgFGy1ROmYXKHNF7I6+NDgin3zvyCwhYf1AvbrlEF4CmLRQLjgbAx6XZXK/XWH/kwVcDixSqMQrTbI8STOmVzzh8fcFe9EcgXkDuDb+K1ly+oINQDA541xiHdI+Ya2/nNud/lrgfppFvz8175k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 12:59:10 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 12:59:10 +0000
Message-ID: <7b5a13d2-6ddf-417f-a8a9-a75ece393823@intel.com>
Date: Thu, 12 Nov 2026 14:06:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: do not classify EAPOL MAC address as LLDP
To: Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>, Larysa Zaremba <larysa.zaremba@intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20261104220042.1421735-1-poros@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261104220042.1421735-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0130.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::25) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA1PR11MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5bab55-dd75-4343-b508-08df40bcbe7d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|261009223027099003|11063799006|261026140227099003|261028144727099003|261022105027099003|261102123227099003|10067099003|56012099006|261021123027099003|261026121527099003|261021121427099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: Edn8sKDenzF1CcLGq7HJYs4V35HtExtT+EyaeoOj63+gFC1T08QnKRpP7BxtHaqZrdtAlOr8sbiNMJQC4aXLzVL+uAZs/xEXqcjI01Edapzqo/+ZIzPJqPHjBSWzf5USeVlp0ZpSkRV500OBoJXfhwhp/DyNfCdjf18zI/xrSa2PTFaaBMYHGHbGhP7UQNW8wlPkJGLy9bQRw7wYE26pLAgY1emqKOE/EpusxWvYoART6FhyHVbFtUb5J6naOYkAkekSmF/8v08ziCmKFMOgL8j7HfG3bU3JEZyNuN9aOx7CifiQalGTD3paonYqoUI/DwpOQzkfE+D7esCobNq39rnf+A0RMPEqiHKA0rzQvO/hYT+cQjJzs448FvA4oGqz+9bmN5kwajikFCoc/ipRrxfHzBUm2Wj/xg5sPNq9YVTvt8doW+4r7Sxudcj7uOCyQ/13LwbZRu/ouqR5PGJFRuOdZCEiJOJyvksQida72EuBnQbseSv9u6Wc48lSsRjTRUaXiufqSNLlCvxAOhieSJ9SReLOfrtrrDVWB73tXWB1/0ON7XQorHygC7GdnLftlMIa8Q5lwGwV8MYugv/I/PnRDesYKD9pITg7gy90l7XuDHgKUo9UsQwidsBWYv3Z/t0YK49TgXCwNq1wE0lgFCnCQcdgD6v5HlgBt7/2YBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(261009223027099003)(11063799006)(261026140227099003)(261028144727099003)(261022105027099003)(261102123227099003)(10067099003)(56012099006)(261021123027099003)(261026121527099003)(261021121427099003)(260925021311599003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlBLWXVob2JZcmJ0NTU2VjFTTlFEdzlsQ2ZXcU5jU2M0UkZtYllwMG1NK1lL?=
 =?utf-8?B?TEZrVmFhRXNpTFJxNmZWYVE2c0tXeEwzcS9rTG5hamVSWmkvWFZXQlZnRDdL?=
 =?utf-8?B?UGRUckZId09TSDNxdmYwNHJXQTlHLzBYRXVJV2oyaWJtRndkSG5DM2F2WnVi?=
 =?utf-8?B?OTd2NUxvbFV5VTJNeXhxOUl5azIrZmMzSTRvanZQSDJpd1ovY3BEaFByOVY0?=
 =?utf-8?B?T0VkdExKa282dExzelpQOVFQVEJXclRqcFFPYm52bTAxWHQySDJ6TkRVWjN4?=
 =?utf-8?B?TEVrT2FNc3JkcktEVlpZSnREM0RZNVozUExFd2FTWE16dWViamNGd1V6UmRq?=
 =?utf-8?B?RExKY25mNXlPenJHcXZnQ2lJVnZlQkc2a2Zsdms3K3N2MXNNWTJac01FWFdQ?=
 =?utf-8?B?alhjelpEMHpPaXpEeG5TSEtNcUpvS2xHZlArYlJMQ1FOcXhtQjdiWWZMS2Rv?=
 =?utf-8?B?cFBCRGVML1cyaFZSMzUyM2dvVkYxQ2FlUk9vTDdCbVpkQTZkbjZ4NW9TbVNM?=
 =?utf-8?B?MVM3MjhHYjN4Uy9ZTThINGEvWGlEZ04zakp3UlYwMXpMZEsrbVFzRDZ1dDFo?=
 =?utf-8?B?OHJiVnNSend2emxDVlRWdUJYZHFiN2dsRGkrV3dVcGlhN2RpU0tWSTZWN2Rv?=
 =?utf-8?B?NWs0RVRob05RQTRSc3YxSmM4dlR0cVRibjZjWWRXbmk2ajZzeDdPSEc2VmE4?=
 =?utf-8?B?bDJzS1BrdlJYdS9jUkkvZU00U3BFeU5MNVZ4amErc3VOSzdEaDNQb0RsQ0k0?=
 =?utf-8?B?M2ZnZWhpR0hFWkdaNVhkS0lxVzRWMS9pY2FVY0RIbEp0K3I5U1ZNTVhIRy8y?=
 =?utf-8?B?bDFyUjhXN2xKdW11N3lXQzQwRDZ4UityeHQwUHJaZ2VkVDFva0dFelNlM0VH?=
 =?utf-8?B?ek54WjhPUGg5Sk5oTXlvYldWeUxyNkZkSjM2ZEZLZFk3ajl2QURJZFFzeFRa?=
 =?utf-8?B?NyswNmRDSlBwVVd1SWdSTUhnT24wZ0hmVlhXNThublQ4dXJrd1J3eUxzNERN?=
 =?utf-8?B?T3VxR2dTQ1NiZVZMUmZITmJlU0RPTmkvQ3BkT1hZK2YrRVRmWUl1RUpBaE5S?=
 =?utf-8?B?TDFxenJkS05RcHRQL2x5cWpZOVAxYno1MFpieVgwRWNKbHBTRHo2b1N6Tk1U?=
 =?utf-8?B?SThETUk4SnkxcTNid0QyN2R3eXJYRmU5dVlBU0Z5RjFUbXlzazRVZ3Z6a05p?=
 =?utf-8?B?dlRFMm5NL2UzM1ZBdEJqT0ErWU1OR0t4ZDR1Z0JLSGsxQ0R5UnZuazNlQzVS?=
 =?utf-8?B?eHdRaEFwMTYvTHRhTXhjd0VHK05MRkVIaHZYUDVZQndIcXN4dDZjV0wwSy84?=
 =?utf-8?B?RUNock9CT2pQT21pQVhBY3ZNalhXSSszZjRnY2lMbzdyRnNCSzhqendpUmpD?=
 =?utf-8?B?eUt4MmpaUlI4NnF6Ulo4SlMyem9mV3hXSXFVK2hqQkgzRnpGL0hTTnJyWThY?=
 =?utf-8?B?ajc2V3VxRHNpK291RUhsc1dJNHNFa3BWM1ZWRHZ1WTJJQUV0NE1iTU03dUhP?=
 =?utf-8?B?aVMzYm9hYi8zRnVCYlYxcjIwT3htcGkxWUZPLzlLd2FtTXdDSm0rR21vWXhQ?=
 =?utf-8?B?RzdPS1V4VTY3cHZsNk9GZmQwRWVZYytFVFlMQk0wcXUrUUd0T3B0dnFpd21O?=
 =?utf-8?B?Vk9wMFhqMnVXaWo1TTFJNCsrc01ORlhPY3VDTDFibFNCbXRrRHc5S1h1REVs?=
 =?utf-8?B?NmZwOE1sZGVJQVJKOXpLaHVuUHUxSktSQ05yTUZKaERRcFM1K1YvVEFpczN0?=
 =?utf-8?B?SGN6U3BoUVplNnpXSXUzMlFiYmtJYXdhTkZKZ3ZJT3VLZ3lsSGprNjRoanlm?=
 =?utf-8?B?TUgvdzM3TlY2SHpweW5LT1B5UFlZUWlCYVVrdHVKRFNUM05DQnF1YVgxZURU?=
 =?utf-8?B?bi9lK0dxRGZSOWRYVVRiVGZBZit4dlo1YzNPTlc0QUUxTzhMR0k1UHV5a2t1?=
 =?utf-8?B?aU5ZRWRkOWRONTE5am1LdW5nWnkvaG0yOGpnYS9CNWFKeXlZSHdGSFc5R3k1?=
 =?utf-8?B?djc0YjVoUEFuT3pDejlEcWpMTTBWdnhhc2xpL2dOMjRtTVI1UnJLT0laZWg2?=
 =?utf-8?B?cFVqVTVkTGhuUFZEMVVIWlZrbWpadDBGd3RDZUt5VEVVM0NjZUZia0xSR1E5?=
 =?utf-8?B?eEFIUE5lNVVudzVlQm9FWDY4bWk0bXNDazFXUzgzamlRZ2xCSmx3cUtZSlEr?=
 =?utf-8?B?a2hXeGhiNjQwR3B6WWpsQUo5RlIzYU14SUlOVHV2UDFxTFpzYWl6VGJ0T0pa?=
 =?utf-8?B?Y0FsWFNldHY1aDNyLzh0bWtLRG9jNjU0aFRrWHNpakl0YU5Idk5JVDZwVXZZ?=
 =?utf-8?B?OHMxY2FRSXZoOTJJK0wvbmEyTVdpNEJXNFpnVEgwbjlKTmpVZXpRbWxNRU9Q?=
 =?utf-8?Q?XyW4SYuIh0072jbQ=3D?=
X-Exchange-RoutingPolicyChecked: FVY76Lj4bQ8yF0M5TkD6mOZryhdC/aEoovdxJ98q1WaAC1j/akEutqwoQUDBDvESDqBitHxvwnF4auKeJB0Q8ThAgg/AwhglAsU2z5ETJYYLIpL90TRoOSKFlaA8TZbtoIRHGLSfgaOaOKwQBaliLkHw1fkQFtqVHXmwM0M4u7hZzP92dXGddDlBmT6f3B/7um17GmRU4xa90sVqaGolFKhxs8aNPhnS19azQM3sC9/yrBZi+ofsJ/6J4JF1R1P9tVk96nxyV+3Y9X1Ei021EP0aMu9wYUT6HIZuggSa2A/k59Gb4nTFV5fHAEtHVqiMzmXhY+vG2l1e/GsGN8YjnA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5bab55-dd75-4343-b508-08df40bcbe7d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:59:10.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mk73Jep35JxjO1kv+gmz5HCjyZXlmhnV+5fD+afRkDX5OobGNQgIQHwIJy/UU0UbnMvFcKyFAqXyQc9sm2dpiWvwOrCnA+4rGcieuMnbocI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7198
X-OriginatorOrg: intel.com

On 11/4/26 11:00 PM, Petr Oros wrote:
> 01:80:c2:00:00:03 (Nearest Non-TPMR Bridge) is also the 802.1X PAE
> group address used by EAPOL, and the virtchnl MAC filter API carries no
> ethertype to tell the two apart. ice_vc_can_add_mac() therefore rejects
> it on untrusted VFs, which fails the whole ADD_ETH_ADDR request and
> breaks 802.1X authentication:
> 
> [  128.447213] ice 0000:17:00.2: An untrusted VF 0 is attempting to configure an LLDP multicast address
> [  128.447301] iavf 0000:17:11.0: Failed to add MAC filter, error IAVF_ERR_ADMIN_QUEUE_ERROR
> 
> Drop 0x03 from ice_is_mc_lldp_eth_addr() and treat it as a regular
> multicast MAC. Trusted VFs still get the ETH_P_LLDP forwarding rule
> through the other two LLDP addresses and the rule does not match on
> the destination MAC anyway.
> 
> Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
> Signed-off-by: Petr Oros <poros@redhat.com>

Thank you!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> ---
>   drivers/net/ethernet/intel/ice/virt/virtchnl.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> index ca8018e3dd4288..27f0e1dee24642 100644
> --- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
> @@ -744,8 +744,9 @@ ice_vfhw_mac_add(struct ice_vf *vf, struct virtchnl_ether_addr *vc_ether_addr)
>    * ice_is_mc_lldp_eth_addr - check if the given MAC is a multicast LLDP address
>    * @mac: address to check
>    *
> - * Return: true if the address is one of the three possible LLDP multicast
> - *	   addresses, false otherwise.
> + * Return: true if the address is one of the LLDP multicast addresses
> + *	   handled by this driver (Nearest Bridge or Nearest Customer Bridge),
> + *	   false otherwise.
>    */
>   static bool ice_is_mc_lldp_eth_addr(const u8 *mac)
>   {
> @@ -754,7 +755,7 @@ static bool ice_is_mc_lldp_eth_addr(const u8 *mac)
>   	if (memcmp(mac, lldp_mac_base, sizeof(lldp_mac_base)))
>   		return false;
>   
> -	return (mac[5] == 0x0e || mac[5] == 0x03 || mac[5] == 0x00);
> +	return (mac[5] == 0x0e || mac[5] == 0x00);
>   }
>   
>   /**

