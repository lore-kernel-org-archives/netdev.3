Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594916;
	b=wM8s5rFSTmRlT1d5vLjL6iYefuLjy573yZUk8AgfhUIKzDvGKJGTaoYCVJSatPaOP5Kj
	 fOXRn727A2EgxvIF2LKCp5jX1wjrGJ7G06GUhQH62oK3VstOLmla/TfHiDwVDxsH3mcHC
	 uQw2IOviKC30c7uhKsrrcAo9lspfI/7LBnwITzG2umD7m9fkV/6r74JlCr4/+vKBT4Kju
	 aV2kTQugZN4Cyeq+Zv3PRc+cSZienqR9AI+zLOmk3mbsSV3Vh9fv8wC624oaZ2uNiKjKm
	 C8ZzF9txtI4fdTlBzyQkIbb3xqomtalrsumt8ju141NQoN05u0IgkLTBboHFwdgjJcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594916;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=FKtX6p9IDwKKULOXOvEjoiHlqRjmObP3HxAY1uO8o0Y=;
	b=FgtOCDX7DWzCfSXyuS+dIo7gxEqP7kU2CGr2HXzonShIwPk/XPoWjChqRZ5SFoxDxQbG
	 jVue3Gdmw6NJIuyXZEZQ9fHKTh2J1E9kxEjYs4Bc1zWZIpoYAerhJ4go0SYLuqKPW4KBV
	 6BDbWzJvF3uWI4UtXIvfgQoAav8LUsl1t9Fub7ddTBBgRwPgIxgPJ4xx+1gNhx7H8ZAez
	 nXFnTD5IZrETt85wq/Qd5JtJZKZdRxzTURiXXUZ6LV5lwmriX0kn0rmehxGGyezuydkh6
	 b6HQ+7I0QKr6q6PC4Bg8yqiN4dusanAXZRMQsz+3dU9HsyfGPrHGJeRZ3XRPU5d9jCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WpnrQwrz;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VPxIeJeq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46675606AEA9;
	Fri, 13 Nov 2026 18:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46675606AEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WpnrQwrz;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VPxIeJeq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794594916; x=1826130916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iE3t2CxtAQBaQMiNHdWxD5b73Zc+wQ/kxmYHdD5JxaI=;
  b=WpnrQwrzXhTWgQWmlmxO6QY2qXgL5hTNuJ++ZMl4XtkpLE+SQQMPC6WY
   I8rxKUFFuFM3GxYCS4JCrq8qAPnjfxJyDOAJuh0kvJOgbQEioo4W6YzT7
   HMe9+P52UHAxetjQd3wpqYISdYowkewQQgRm+KpJmyOIgw8YRc84qVZ6l
   3+0IZjptfigA0L9hvi2dUOn2oZuO4qhQEUHG0IufRl0y97TLSLunc9jRx
   x8ib3nv6Ioeqnwcra8OUDkN1BVPfIp7eR45YsEqx1VWtmAYN51H3/zt5C
   dh5p6XydzV4Em/j1u47ZEQFe2LPAoZ1jMaS2jezMZuhBJwW1pWSzykTYU
   Q==;
X-CSE-ConnectionGUID: WR7seHYfRC+Qk+iEvODrCA==
X-CSE-MsgGUID: jKx4IHQsQuWEajeS/rX/3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3419359"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3419359"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:35:15 -0800
X-CSE-ConnectionGUID: 0HnF5ovmSCeAtl1pvIXUNQ==
X-CSE-MsgGUID: aNLAHQ/ATle39MSp1P9SOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9003030"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:33:20 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:33:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 10:33:18 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 10:33:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbJoICBWVtRkUJyLCnjdFyq1DDtD7Dd+1I8eeywuVftP9vD4vQ8XaiVmhH/G3yHSrx+PAJ72T+mpk1oEbSF7JV14p57hZ9lzc84CiRKmMZZNm9QEW3IN07DCA7klLWOLMFs0RbrCSlv+x0ZKzgSqPSTTkmM4MNy3KaekQRbZCQ+exM4Y0gJnP+F0krX09+iS3aUpq2lOw+GvJrgrrT7k9ldpnkfxO9iZPOwPw9VESjZqSApjkTeaOM8TfOzLfHOdIrqWanx3U4X9lTH4rtrK0fcaxiQ3NDA2Ova9U0jiFmZo76mCUpamJGGKFNPjzZ1iIvGf4DXgVSyMEtulyN0uHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKtX6p9IDwKKULOXOvEjoiHlqRjmObP3HxAY1uO8o0Y=;
 b=NnE6NYi5KKgQQu7VH+oZf7a3+MmQcej0oje1OnOZfnwVR4d13AB9R2T2THv4zxJ+4Pzu/GLykznPAZaCom+P59Alsl3Nv97aVxFHv5MMOPpHUIWgfGFgHcm43YhIS3YhSuhG3954Al10mVQH/Z/xtc3ymzqQF5lanEHGCJyAbA6AxZZM9qI2A0W+Nv17aNn1Uin/622CNAVLPL6uSZzMqbcbS+l3nosJvKjj5iQEmaS3WDHLnVmFyu9zir1SxGfN8PPcObGtHdZvndUzbQtt8goImnQHTnM6KLvrLuOn44H/vZKYqjNleBcvZ5OterkyvxIuL5LN7Njh5LCdamJwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKtX6p9IDwKKULOXOvEjoiHlqRjmObP3HxAY1uO8o0Y=;
 b=VPxIeJeqLXLRho1OBQwodZ1fqStRLHEM5cBXZj4FWMVOlkRZlyKyBHE+2mWdRlgS7pDBhnTnZ+hKscfC4b8gpLaz5eczf9oe/GZzlg0CVjjTSx0Y7/CDi637oBe4dlvFK16Gu+a1nYfvsJvLr7RxhJ4BmgwSguHEEcVe4Zs2LXA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) by
 PH7PR11MB8478.namprd11.prod.outlook.com (2603:10b6:510:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 18:29:04 +0000
Received: from DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0]) by DS0PR11MB6469.namprd11.prod.outlook.com
 ([fe80::ee3c:8422:6754:29b0%3]) with mapi id 15.21.0592.010; Fri, 13 Nov 2026
 18:29:04 +0000
Message-ID: <6bcd0c58-7110-480d-9fc1-0abe0dd5a354@intel.com>
Date: Fri, 13 Nov 2026 10:29:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] idpf: reset mb_wait_count once the mailbox is up
To: Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Madhu Chittim <madhu.chittim@intel.com>, Emil Tantilov
	<emil.s.tantilov@intel.com>, Joshua Hay <joshua.a.hay@intel.com>, Alan Brady
	<alan.brady@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Willem de Bruijn <willemb@google.com>, Shailendra Bhatnagar
	<shailendra.bhatnagar@intel.com>, Pavan Kumar Linga
	<pavan.kumar.linga@intel.com>, Phani Burra <phani.r.burra@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
References: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
 <20261113174251.GA18859@horms.kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20261113174251.GA18859@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To DS0PR11MB6469.namprd11.prod.outlook.com
 (2603:10b6:8:c3::19)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB6469:EE_|PH7PR11MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c2ffaf4-07b3-4e32-043c-08df41b3fe95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|18002099003|6133799003|22082099003|10067099003|11063799006|261028144727099003|56012099006|261021135927099003|261026121527099003|261021121427099003|261022105027099003|261026140227099003|5023799004|4143699003|261102123227099003;
X-Microsoft-Antispam-Message-Info: sIWLQlgzC3q56sZcEdoilMxvnv3Fmlm1cemUP8IACM0qQLA+uvnILKVUWcN8ZNQakkEZio+PhPdT7GstvKR6CralzwKwhQ4NSCAjBPt1oDdkMg1wNrxBDdf3Pb3wk8AupMO5QqEEk/OQdDiTQx5VJvJe4jtybNK7D9XLGbnb62L/8LRC9rvm0+YDMiFcdTDmJ8saeJmj68QplvINKRZszFdom+lnr7OiDIVxbM80HFPmQ8yjsWFRHmmHFzLdRzcbFzDZQXj1Fao4bi5FCT28yy2tbhEJ9PKDfUlgaZ9H5jxoBMaV+8eG5m49Y/0YKrf7XGJWk6/DSMsJpVH0yL4TXC1hbKFnVBDA9Bj2fYMr6SdQy20slOx+0hoM8+1KSqxuZZ/U/9YV3mJ5LmPFUdKSdtYbUjVxCzZeEVe4sQ4P3+irx0Z9V54wW1Ae1snlk+k4ULp3a9wscwFyCQ0lg7RrgiSf+uqga/7niO8uIPeRV9+1wyVk9Yk5wmd1cLCeic529BdKvZ899zgBAZWlLm/yEerLi0CpddysPaxcn2jGK7LatLnjX5Kr7jNmrEKbeF+vqoFX9YsMhFhQdDu2MIU2cXJsgk+3541inq1KKHfZbMRgwc76Wu9cGyNu+14zX0SIFhwT5fR7MslUHiyFAmnj5gDU4TZ98iSo7U/6a7riCKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(10067099003)(11063799006)(261028144727099003)(56012099006)(261021135927099003)(261026121527099003)(261021121427099003)(261022105027099003)(261026140227099003)(5023799004)(4143699003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Z6c1hLM2tHNTYxdlhqcURFMDJBNXYrc3YrWC91SUdaaEFWS3JaZ0JnVk1L?=
 =?utf-8?B?WWwrSUJjcmQ4MHEvOUYvRk9RKzBrNi9YdStTRjNpWUxDbnZSakRCQlB0QSti?=
 =?utf-8?B?c29jb0tjRDkyaEcxUGpWVUxUSHppTGhLUzNEWUxDYVBhOVJyRUNjNkYwOHJZ?=
 =?utf-8?B?VVgyeUJhSmlsMC9kSHBmblNnbWtudmVEMytacTRKZlVpejZjZVRtdVVNQWxr?=
 =?utf-8?B?azJjRGFmYk9SN1d4amRwc0tyVnBNUmxNbngrUXZrazFFdUE0OWN5UHpJVkJG?=
 =?utf-8?B?VjF1U2JEN1YreWdHOVNkLy9FUmo2ZFNEOWk0VjU0eE04aTFKdXdiQXdXbkIw?=
 =?utf-8?B?enFvMUpoWnNxNEFPdWVhaHNzbWswWlBoT01NVERYQlZXaTBFR0ptOTJYeHJX?=
 =?utf-8?B?aEFISHVPUDk1OXFyRXhTRG1IbHZYaUVwbzFJVjliYUF1YUtpdDJaSlFBTmxF?=
 =?utf-8?B?d0dlUXRCVS9aOTNoTmpyYW1YTklUcGhVejRpejlvOTlKS2ZTc2JGTE5xZEpM?=
 =?utf-8?B?TUFHZ0VVaG1LNzFuRWdiVis4Vmw3Vmw0NHREVEV2QTU4djMrcG44M2dJdWxa?=
 =?utf-8?B?N2dmMTN0a0hYaFJxa2RQRzN1QnRJS0t4NmF6SGNvTGZiV2ZJR1JFQ1Q5OThV?=
 =?utf-8?B?TFBqWEdDK3BXeC9sd0dHbTF4dEQydGJxcWZUQ3Q0ZnJIcmp2ZzU2K2dESStx?=
 =?utf-8?B?dlFIK3FUcWp2TlBaQWs5UDZJQmhXUWJJeWJlL0hlcGNZQ3hQSUtWa3BjWUtt?=
 =?utf-8?B?RW9PemFiMXZkRHI2N2Q0Z3IzcGFQeXN2ZWdTQnZNSlVxWEZBeUVhSktXaDR3?=
 =?utf-8?B?TDJUM0ZQN3RmQzg0SWduV2ZmNVZwL2IzWFRVc2xvTFhreW1ONFEzYU90c1pC?=
 =?utf-8?B?bXhteU82c28wU2lvOEFCT01ZRjFNYmViREhqUSsrc05sSGpzc3MxcURIVWg1?=
 =?utf-8?B?OHgxbjZlM3JQVG0vSE1YNkw2NVAzQjNORzg4eU9VaENYcHM4WFZPOUpnZnNj?=
 =?utf-8?B?RDRSV0k4ZXAwYW41Rkt3ZmhTaldXUWEvbk1pT01KV1NpSDI1emhWVHdkV3py?=
 =?utf-8?B?UXZIUzcwT2VQTEJRV2lwd3Y5ai9tU3krNURYU1RjS2N5czlmdDR2QnhLRFFS?=
 =?utf-8?B?czcwSzErdWMxRXdZNzlHeE8vdkZ0by9qdnIxeFpudEpPSFVrTm5Jcm5EWjRp?=
 =?utf-8?B?cnkyVktLUlhtZ1pkUzZNdFRoMEpsbkdrYTdjVHY4WElRVzVza01Qa0Vqaldo?=
 =?utf-8?B?RUs0bGJGNCtPSFhBdVpFYzNxeG05NytwVUtJd1IyNGFSWncyUXJFMVZpeTY2?=
 =?utf-8?B?bG9JdnJBNFFhR1k3dHRYeHVzZHd2S3dDSzFSYUdHMmtUZldZU3o2NFNBaTMw?=
 =?utf-8?B?WVpzMFA4MEppVHFGRksvUU1xSUp1UFY1M2lhQWNWVkwvNXYrd25LdEFxeGFa?=
 =?utf-8?B?YXN6c3Y3UnVwZnlYYVVBSUdXcWQ5RytJTkhQZi9xMlRpelY0YmJTR0J1QXBZ?=
 =?utf-8?B?MWk3MHZwcHdlcTVIWHlDT0FiNEdlTm1yaUNESXdiVzlzZTFDdUNwOG5ienho?=
 =?utf-8?B?M2ZRWUJwSEtzQm9YWGIva3ZubThLbFRWS1V0aWtkUWdaZUVlMG5qNVFXVkVt?=
 =?utf-8?B?Z3dMWS9aU1BxSlplN2Vsa3U0SHF1TVU3YXRLTWQ0TmRlOHlaTkh0bUtRdVhq?=
 =?utf-8?B?UE1hcWhRZVlPdTlFMXQ5aTRUako4Y2RkTGd1cEYzVjBDclNDaFp1WUVJc3lo?=
 =?utf-8?B?RWtta3kxTlVVSlhHTlJZUnZOSUYva2RsOVRzVkJvOVoweC9WSWdmMThLMEpX?=
 =?utf-8?B?UGcxbStmYXFTdXRhNlM0UWI1bVVoV0JJb3ZhNkphWjh2N0llYjR0VDMyanN0?=
 =?utf-8?B?cXRTS2JlSzNWUmFYV2hKd0NMVHBuWTFpcHNnMVU3RHJZT1ZHNW1tU1A3Zy9z?=
 =?utf-8?B?ZkpRWFVac2tsZG9GdVVrdGtyT21vZytzVDU2cEJkUURJWTlLNkZnUngrYU5a?=
 =?utf-8?B?Sm5iZ0x6K1BoMGVKV2hHakRjenRUQ2hteXNFenZMUW5OWWxDdEx5d3NRRjZq?=
 =?utf-8?B?Zzg4bG5jNXlxQWJTMWl0b2VURWNYVENZVG1TL0QrUkxOVG9sMnlpRVo1Mm1C?=
 =?utf-8?B?eUY4NGxMRU5rYmlrYUtpWFhNWVB3cVdkSUViZWU5T1VtY0FvYVcyUWxKVncz?=
 =?utf-8?B?OGJZcnhIT3EzU2Z5QjRhRWVWaTV0N2tjS1pFRVZVckRTOWtRckVUSEFuQ092?=
 =?utf-8?B?ZVdEa05icmpLVC85bHJ6YlJpR3dPbkxmcmQ5VU5LeHRaQnZuSGw4R3ZNVjhX?=
 =?utf-8?B?R3YrTlpVUnpRNUpZaFhEWk9aU2Q3M1ZQc3NqemdvMWRCellXOEZOSzRIajZl?=
 =?utf-8?Q?iGCPfZ3KOVCjXcDk=3D?=
X-Exchange-RoutingPolicyChecked: Up2BxQJ/WFbQ3YGw1UuYe66r564NexZRb2Q8fJKgq2OrmWXSWm5qvzZ9T8vwGtzezpnkNtd7gyPO+txAb4TPWRvENUWbI2Pj2+76xQ1aDKMsMTncqIB2gxHfbZKz4nJ+IYvvmDF8i7dUpLfj0+nIjG/bC1KvMj4aBQtv2HtdVyGO1q/FCQMoiqYeSqjTckoUxIpQURBqifIh/pqShDrw7bbLjThEC4s31cLEToWLQMOkr0W3B//LmxHp/yZQsRdEILomeR2wbnLTWWlnU63PNaXrnWY/KAVyT+NvkD/xo0mawrS0N8luXaoeD7SnElpW98O6XXueAyNV9AUvG53ebQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2ffaf4-07b3-4e32-043c-08df41b3fe95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:29:03.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av204z9TOnXD1ha7USJ58GOLxS/Oe7b+TZO/cBISlijZFin/LRdi2RMGzRoc23BCcGlDzdsmT/KgIPoIWI1hGTCFm//RldnuyJCsFluEBe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8478
X-OriginatorOrg: intel.com



On 11/13/2026 9:42 AM, Simon Horman wrote:
> On Mon, Nov 09, 2026 at 06:43:27AM -0800, Breno Leitao wrote:
>> idpf_vc_core_init() retries a failed virtchnl version and capabilities
>> handshake up to IDPF_MB_MAX_ERR times before it gives up on the device.
>> Each failure increments adapter->mb_wait_count, but nothing ever clears
>> it, so the limit is shared by every initialization in the lifetime of
>> the adapter, including the one done by each reset.
>>
>> A device that fails the first handshake after a reset, and then
>> recovers on the retry, leaves one count behind per reset. Once 20 have
>> accumulated, the next failure is final, and the device stays down until
>> the driver is reloaded. This is seen in Meta's fleet on hosts with
>> recurring Tx timeouts:
>>
>>    [ 2176.496801] idpf 0016:01:00.0 eth1: Detected Tx timeout: Count 21, Queue 11
>>    [ 2176.508763] idpf 0016:01:00.0: Device HW Reset initiated
>>    [ 2237.412541] idpf 0016:01:00.0: Transaction timed-out (op:1 cookie:9800 vc_op:1 salt:98 timeout:60000ms)
>>    [ 2237.412578] idpf 0016:01:00.0: Failed to establish mailbox communications with hardware
>>
>> Clear mb_wait_count once the handshake succeeds, so the limit applies
>> to consecutive failures only.
>>
>> Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
>> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Tony, maybe this should be routed via the iwl tree?

Hi Simon,

Yea, I'll take this through IWL.

Thanks,
Tony

