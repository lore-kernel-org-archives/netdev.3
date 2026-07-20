Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E913E02A;
	Mon, 20 Jul 2026 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586920; cv=fail; b=qh9no+fwD7c1ngFAUC7urb4UWI0NQe/d6PTPbIOLb+m+c2S7q8ZyrhDjYe/R8Q83AzuWfuDq6bxOYHFKyEOzS5qztxLnJpVg9Pc0KrRKMtKthe+ZJSiwcoW9RVqfcda5S8z8t6FnUCos8c4ya1HHvGcl12XZK7dmz8jjeyKLK2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586920; c=relaxed/simple;
	bh=Nkg3LddMxZwKcyxNym+vWPPowEorFSET01HQzMOQMHc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1v+S8rHoEZLGXVmRXOQk0cfvfuK6H+jXc3OZKahxOFDy5O2RIBcDNQxvq75LsvYThJktXBs1aCpOhte1MT688tgvX9i76mll8bpRyDmw1KyQ/myuy/Wi8LPzAGXBeyas6QbuXIFieSv3gsEOBgU5QQFezQBVgm9TNM9dLxQ8k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ix0xPdW1; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ix0xPdW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784586919; x=1816122919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nkg3LddMxZwKcyxNym+vWPPowEorFSET01HQzMOQMHc=;
  b=ix0xPdW1AbRhiFKsxjzYTbn/JoJmZdRmfsK+POqucxZxv+PcYIRlo3TU
   b3ZjNc5nMSpRPRvqUiHdO65Lhnyc+EhBJMLcxS8oESnJPlL+caXcvE1k8
   2zXw6HAAJShzvkYM045QOyA90kVqc3AAMntQ7SlyRfJtGg9TKnQYSw1jv
   VjobcH8QFDvFLVmx14zOVbZgbme5EN+V1ha1wVUPLdTAspaLkgXjZ6iwU
   kzAUrlED/sRVilBshGOI7orvRHHHNnl7O8TpGSly+s8dw6ySCTZnVXvwt
   F/SL7CZDFZqwnpGiJwTFFfK7tdeW+urXg2Jp5iOXkREVqVkjjJqq4zE09
   g==;
X-CSE-ConnectionGUID: 3Yz9uqhuRMO22RnzeHxe0w==
X-CSE-MsgGUID: 2HJ3YLWwTuew7i5E+M8yQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87718730"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87718730"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:35:17 -0700
X-CSE-ConnectionGUID: u1zMwI3aTB6HwCdEdGJYGw==
X-CSE-MsgGUID: 9Lz2wl8KTL+aWiR2PAoAdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254173840"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:35:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:35:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 15:35:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK9p5K6KmFk0wA5zwxmwgBxVMk+tYHjDQ+Xma+uRGxH0PnRUqMFE69+pC0ToVZuRUtp2z/QrmNS9wDrTkilH0NP8euzILOJ4b3IVB3dqCiKEr59xMyq61wNhnI/PGnTC5zw1bRsJhS6HiW4iYAwoeZsFl3gkpmPTtVX2uPye1tvnrMmBbHW+HgyMWk0cqwziaF9zZrA6pHzrFb6YqZYPiglIJuh/n8DSeefrREPBw8X0HdnIm/r71xpza4o2+0XVObvBQo0NUWQjY8frQZXUDW7FXkWN/zMIWmARVDN8taf78Jud38yuHh2GTcr6blyXIdj3UTnsklmcH8iKNC8ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjZOtb0fKXfGx51oL6za2/vF/ac+2tEMNH9Ms12Ecx4=;
 b=FrtluSgyvKxgh9sHz/39Dj2jdfjU/lZ/A0Clh+l1m83qp+2aoxO0g45V/743zW6xxT5hLJ4UchiMlRlFhV/1YIEz5QoNludO/HVN3bkCOIeMh8DestcCaTf3cDKAFfYun1c5rM5BBeh96M4UCQTK+7llpVxI3Ay17qPRac4XzICNZ7fW4w5V2Fg+0FFyIob/Mu8kO7snDABaJrWdMlF/pV1B+C+GfuI/liH7FG4+iw9IgxwuPQNBjZbqJO0EUica8S+/byPh1iGb58p4IXPi9r1leEq+osSKZXxjDgTYSDjjKfUHyhts4BYnTfQSlV0oI9excYLJwO5CclF8M7rXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by BL3PR11MB6459.namprd11.prod.outlook.com (2603:10b6:208:3be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 22:35:13 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 22:35:13 +0000
Message-ID: <e1e391ca-7085-4151-832f-bf187491089e@intel.com>
Date: Mon, 20 Jul 2026 15:35:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 0/6] net: Move system_long_wq to
 system_dfl_long_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Haren Myneni
	<haren@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, "MD Danish
 Anwar" <danishanwar@ti.com>, Michael Ellerman <mpe@ellerman.id.au>, "Mika
 Westerberg" <westeri@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, "Nick
 Child" <nnac123@linux.ibm.com>, Petko Manolov <petkan@nucleusys.com>,
	"Richard Cheng" <icheng@nvidia.com>, Rick Lindsley <ricklind@linux.ibm.com>,
	"Roger Quadros" <rogerq@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260720100902.155605-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|BL3PR11MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a96a188-42d1-4703-d9c4-08dee6af2a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pyk+HlQJqy7eKbjR9+/Tt4f/YH2aGvemZmhuoQKq8Bsll9LHsZMg6WaVw8AUAgN+JnOpgJjAQQthNx1pANphLAV8m0ealrTfK8J6pGaP/XHVapx8PIZ0RbfeXrifHHnM0DrXgbw+gHDD3E3T6dF3WDiIErqEHPlFiG5qrM53PvI7fkxRWxzqsMw8OhZR0LPpqWb0rKoOqAhTivYSt6GF0Hhy2bTn/3ES9jEpmJoignkThvMNNzaScRTO4OLjtcvWbBjkRYp/b2FFenXnZCJXmD+Ql+lgDCohxdAdtm1oCmeuEwGdaW9SVJdcHbG6HtFKtoDDWu0IiJ0SfJyze1cg7sxcs5mcm9/pa1MtVoe9pN2mH9sPekmZxUyxr8WjaFWMXZ6TBKzqpDL3ZBHF3l/UDkvm1DAb44ZCdeE+MvPyZQQpEIqnvKgXB6zSQfvyd9GETMSBv6shxcJXhIm4BPs2Njns32mfTihWHERVi+a0+0sp6lulZsuFUsMrwmkyCd9NyPnYgba/ocJ/BcsucQVKN/rybJ7p4Kq8uHy5Wf6M/H3kp8wA6aNyYNF2LdA40+xgatHwxM2e2MaHdHtmwu3y5zSzhM6ybr5yqL4rYQF7jcwOw1S+/tF5t56750J3DXwTH8HBKMTFAYhUlA4Z1YdPLcVir9trfGdjgqJL3fsFRTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3VmTVFIYjVjRkZWSUxtZ2xnUkNLSmJ5cXd4K2N5RGw4eDIzTW5QaVhrQXVU?=
 =?utf-8?B?ZXZlNkhXZysxeUpyekQ1SGJkdEd0bXB4Y05zTGpXT2tuVEhId1ZhdFNNakFr?=
 =?utf-8?B?dFVUdXNCYUVQT0VyYlFSeUx6ZUlJN2c0S1F1bTlmWkRDVUJsMXFNZXRyekFj?=
 =?utf-8?B?OTR5TWNoOXJLdWVaNTRYUlpoaE16alFGMTRobCtKRUZMbXIzVkJxNU16MG5X?=
 =?utf-8?B?bWtpNzZlSXdOUEpQSUR0Wm9RckZnTWNqWXhRcHN5QUdXY3BCeDlFSDA4b3Q4?=
 =?utf-8?B?L3JSb1VuYTlwRldzN0E4dDlwamc2bktKOUdKWWVXZ0svM2xZZlRncUNDOGl5?=
 =?utf-8?B?ZFZKY2tWKy9jdEd3SHBTYzZhV01QWDdtb0h1b3NvR29SaGpMRHlNd0g0dldV?=
 =?utf-8?B?Q3ExbHlpU2R3RE5xeWdqbEtvU0o5Q2tSZ3JXL2k1ZmVoRXhWUWwwaTkyeXBi?=
 =?utf-8?B?TmZNOVZXM1FkbGhYUlhUUE5qNisySlNpTWpqNFVtdXM4ajYvWEd5Vkx1K3BF?=
 =?utf-8?B?SWp4Tm9GMVlMRlNxaVhtT1RjZW9qQnlweGdQU1RkTVBEODBONCtrYTcySkht?=
 =?utf-8?B?ZEl4Y2p4TDQ5K3lWQ3dnOHB0amdKdUJ3YXZKMlV4TXI1RWJxTUdXMXUvVFJI?=
 =?utf-8?B?Qy80c3U3N0tvckhZNGFYdkFnVFcrTGs3QVJGU1BVNng5S0xNdzJRT0ZmaTFq?=
 =?utf-8?B?dEpRait5ZzJZU0lnMjdWbU1IRWgrZFcrb05YeXVsSG56R2lpTU5sdlVldEsw?=
 =?utf-8?B?a0J0UFVJQ2o2R1U2YXdmaFdQM1JLbjV0eUNIbjZoZE16N3YrbHBMNVV5cW1z?=
 =?utf-8?B?akI1eTNOdmJzTHVOdjBSL05hOVhGNUVHR1VBRGtBTGtYbHRGTzc2Z0NGT2FS?=
 =?utf-8?B?Y0ZMV2RYOWd1SC9GSXVSL1A4Vzkra1BqaGhXQkttazljYmQzdStpTTk0SFdK?=
 =?utf-8?B?MXA4Z1RrQVZZa3hKYlA3cmFVMG9IejdlOXdWV0hFZ2E4Q2Y0TWVQMEFpK1Nl?=
 =?utf-8?B?cjBhS3JGU0FubWtmRWRVQVp3K1JrYWgyQ1h3OUU1bGxGdjdNSEt3YjEzUCtG?=
 =?utf-8?B?alMweEJiWTcxR1dTcUtxa0k4ckJjVExhQWlDNTRBVkFqS2lta3U3TkJCdmJS?=
 =?utf-8?B?cjFjcHRiYlQ5cWgxaEtFQkdLMHU0VDZjMUM0VENFNzN4SFRuZmdCTTZsTnpU?=
 =?utf-8?B?dDZsWlJ1VzkyU2dGZDJMcHN2UnM5dEhHYjRtQUY5dm41b01CUEIxZm5FU1VT?=
 =?utf-8?B?MFpUVFdiZVF0WEpXMHpuUDFtZFFXNnZNd041L0FHYjU4MWFnN0k1MkZKLzJz?=
 =?utf-8?B?b1JXQks1TkYvd1oyRWdIM2Izd2k1OEhtYkNSZHVuNC9BOFFoQkE2QjQzclBK?=
 =?utf-8?B?UGZLRUxoWHZESyt2RTVsS0J4SXBYU1hLN0hBdUpkUFZ3N3hrWXdKTVdWNFBT?=
 =?utf-8?B?amkwUHZkODFaNllnazZ1NlhjTG5uOEh2cXdockYyMEJsR0ZCQ3FvRE1CQnov?=
 =?utf-8?B?MXhta2MvYzBZMmpNcE1ZOWFjcTBmMnh5Z1lXMW9Tb3h1SEN1R2ZaWXVnbzZH?=
 =?utf-8?B?VXp0U3pKZlV4NmNGRW5OMWJVMlRTZ3NLZ1phNGlwL3BwL2J0ZU1kQ1FFR042?=
 =?utf-8?B?VlRwYnMwOWpsekVZcm1NMUF0T3Jzc05NNFNKRzB0Q2hxZ2hIUTE3ZnhXdElw?=
 =?utf-8?B?cnlZYmhTMHVxNDBSM1IwSEkreU9Id2FnSWlNYnprOUpKRUlZdy81bTZoL2JB?=
 =?utf-8?B?NW9VL1JoWG04WUpFV0wrS2lseGFuODlGOE5FTUdsYnc0ajRxaHBjQnUrL2Er?=
 =?utf-8?B?ZkJNWHd0SGcrM00wL0FYRWtjd2pBMmR3UHFMbmZ4VXdWdHdlYVBSYm8rSjE1?=
 =?utf-8?B?ckppelFXTmtqZUlKcmxWVWtERDZmU09ReE9UdTZZUm5tN2Nmc0FkWEJDRjZZ?=
 =?utf-8?B?VGJUTTVPS1Q1VytIMWxLSkFLa1ExYTN1NVV4b2kxQlNIYXJscmIwbUp6SzVD?=
 =?utf-8?B?bTNvaUhlUVY2Q1VKSDcwMldDQmZNZWFaL3JqcnB6THJBNE5MTk91VGlnczZG?=
 =?utf-8?B?S2lJZDVuK3VZL0tyajVvbldDYlJjU0pWdWgvL1BJWmRoeDkxRUZXWGdzQldo?=
 =?utf-8?B?bVUvM1p5WTFhb3RtUjNhWUYvbUFFMzhKdlhtdVlxSVVmY3hEODg4SkZOTmcz?=
 =?utf-8?B?TnpmOUVRb0F2YjEwZENnQmtpbk1zVEEwU0RDc3dSSlNBWTJKcWdTZ3NQYVBo?=
 =?utf-8?B?bGg3Y3YrVmVoS2ZvZEtqSElIRk9tM05xZGh0RXBTQklONmxzUXV4SytDNWxV?=
 =?utf-8?B?eml1dHZlM2RMc3N5K0hyL1NGSXBkUlBvOEp0UVFGZDlhNlYxR3NCQT09?=
X-Exchange-RoutingPolicyChecked: s/qxZ4EOjPD34SoPhlHPaE4i4z0JW2OAR5Sjumi8f7pNGMSLW7Z94uD5qFv0+yQW7wvK47lMjMRuqpZ6D1mYVxnLQSEuksDMpCYyphxBHMVz0Dy67tXbbm905/yS4HHdkfNifaPVN+LpnoO0HAC8/3/+ow4wHwFAnVqnOuH7xxFIpsYcRWOPjP/jLXhb+4Br4ozAxt5IBXhHYdjT9WHheFDvSgV39haFJQdM3AQ/EcOM/tsb8p2PG/dIJZ7yzmk3LtEqIBz381ZeGX3Q12H+enYd+PKmRr83C2KiBZqqkFc1U/PQH9MNPbk+ff/EMYCSXBbIvPZid3iPImts0a/HXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a96a188-42d1-4703-d9c4-08dee6af2a0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 22:35:13.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTCn89tSsAOOQvjorHzkPGj6Y667VPfGXmyWJjRN4z8yI8tOQRiNPlSGvjzvHqOv+nwsqgALWvxVHYJGA64XvfE2dCzHZ+6Q+AUrCWUcw9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6459
X-OriginatorOrg: intel.com

On 7/20/2026 3:08 AM, Marco Crivellari wrote:
> Hello,
> 
> Currently the code uses the per-cpu workqueue system_long_wq to schedule
> long running works.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Another good reason to have this unbound,
> is the "queue_delayed_work()" function, used to enqueue the work item.
> More details on this will follow in the next section.
> 
> Recently, a new unbound workqueue specific for long running work has been
> added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> ~~~ Details about queue_delayed_work ~~~
> 
> system_long_wq is a per-cpu workqueue and it is used as a parameter of
> queue_delayed_work(). This function schedule an item that it will later
> be enqueued (once the timer will fire). __queue_delayed_work() does the job
> receiving as "cpu" WORK_CPU_UNBOUND:
> 
>     if (housekeeping_enabled(HK_TYPE_TIMER)) {
>     //      [....]
>     } else {
>             if (likely(cpu == WORK_CPU_UNBOUND))
>                     add_timer_global(timer);
>             else
>                     add_timer_on(timer, cpu);
>     }
> 
> The timer is global, so can fire everywhere, and the work item will be
> enqueued where the timer fired.
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change the
> workqueue with the new system_dfl_long_wq, so that the used workqueue is
> now unbound and can benefit from scheduler task placement.
> 


Ok. So if I am understanding this correctly, the current code uses
system_long_wq which is per-CPU, but is fired using an unbound timer. As
a result, whichever CPU the timer triggers on will be the one which
selects the work queue. From there, the work item will be enqueued to
that work queue and remain on that work queue until resolving with no
way for scheduler to adjust it?

With the new change, we schedule on the system_dfl_long_wq which *isn't*
per CPU, so the scheduler is free to move the task around and
reschedule. As a result we get better overall behavior with more input
from the scheduler, instead of effective randomness from the timer which
is then forced so that such long running task cannot migrate?

That sounds like a pretty good improvement for the cases where the
queued work doesn't depend on any per-cpu behavior. Nice!

I am not sure I can speak to any of the individual drivers here since I
wouldn't know whether moving that particular work item would be
affected.. so feel free to take this review with a grain of salt :)

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
