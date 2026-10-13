Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31309563281
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930749; cv=fail; b=ueQNiUMAZarAWQyOa2JxrSw/phiRPeYzNbVbxBKNBhyonVkLo/4pfLHFi8tiNzhape/llZ7jGRMIhjWOIRT3j5Ao8wWTAgHQAun0MiXA/eSIzNtMJU1vsnp1vHksVjV0wq0TnZkcscCVtfFRvAB/lK9sBfhEqF7f3dGUcbvd7hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930749; c=relaxed/simple;
	bh=cpUQuXm+Q64Kmm40NthjZNdFKAD/7H7rP33/Wl4u9Xc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qr3TepZpn7UJpB6iHYmO/tfhxe2KOWAMCgx0cVqYu6ICMDAHcwzR6BidS6vVd/mHWuFTIJPa75DMxBGx0pIGfuMIT0ZB6J9oYc291wih2y7fzzgHJKv2boHeE0GwZaN/7ls13wVl6F5UOHWJSb1aHYedAfrw1fYPiN0ACDJr24w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARyH9x2h; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARyH9x2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791930746; x=1823466746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cpUQuXm+Q64Kmm40NthjZNdFKAD/7H7rP33/Wl4u9Xc=;
  b=ARyH9x2h0Bq3z1VETmaxz6loyj8aT3l9//ktkW4dSos0C8rbjg+iSNWT
   L50/5mMM3RVg0KR43O157u/Xc4MPIIn2rTEg6qBKiriCbhAZyMBDN2s5F
   H7enr26UH9h2B9Q18lFLvZIUrQiAyuWzL8YTyH0np7r0FvN7cL7+TyZVO
   ziSQhZ3wBp1AH3C1rBXdOJAZHhFgBeRLasgN9tpaaQIywe3y3LX26iToF
   RzjzDd05Ev68O6fnxDETNQ+6i+RNOz8PVY0pDlk8ZY1jxJJ5Ji1lzPCyt
   2IOOD3Eamgd0o8hjkciA6dbjEwQUkzTAl/JJsQCXWXta0eIy2Z1+Tb8bA
   Q==;
X-CSE-ConnectionGUID: wezkeTXhS0+PNRePBW9BOQ==
X-CSE-MsgGUID: UuLUKvLhQSmPiKWmDgsL9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="766453"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="766453"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:32:25 -0700
X-CSE-ConnectionGUID: YeQw2ZWTR4qfEqe5p3otRw==
X-CSE-MsgGUID: yY9pQai6TkiPji9EF3dn1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1595304"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:32:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:32:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 15:32:23 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nU3Vs4uLNsTDf6hbxUt9QmOtPooZAP/UBFavisH6/JIk6xJl3ldJVEJb0bQ+KRfnSx5ZLPhYktOB4WL0fQhvwTPLb1+vnNPKmYAjCwAYeGJTwiopVXqgJ3ftO/QBCPvrTE+IrinvHDCCwR2AObOGIqdLr/avcJBZyQSWPEZkWQZRMKDiBzZcAJITe1BenHX98OymMXlQEy+IJT+ROMV0k/ibq9pgN2fe+Jou+woZ30crn2/ng9MnnyoDMShp0hDDyPWxAWiRmrDp/vN4SX0kC0WmF5qAEnvrk8BAKHKuJpOIT+8xBqrq8EBDpnbN3lO7eVekqfWA4jxvJWs2hj4v6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFuNl5In9mBxygAw0IdW4elYcT0FGGJEAMbvmcYaW7w=;
 b=C4WWRYZdrBoI8UNYrpj99pzsQ080Pgof8ElJxxqh9bRWMjtjxtDqz2LHQ7t9tKtgGB8nGBYeCx0wVeqBEC+uz2Jsweujr0TBbL9VpCHyw/r+89vKWMJXpjIrQxdQzgv1tGuwARzy4qh2ziqDKFGislrdwpcMB5/6MxLnh0C8bTg8r+n1l0DvpxWbl9qkM2q9UZmpOcStv3ERYO40D1Qp/u26ghQCSGEkqc/j0gxb3QZHvnQC0siEPIkhzMli0JfjWmSwdA2XAhZqdxwVuccEHbz7dGogpknzxnZlCJdokAPzOuE+oHR0sMldkZ2KeIdQ0urll76n95q99xXImv72ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by CH3PR11MB601806.namprd11.prod.outlook.com (2603:10b6:610:365::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 22:32:16 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 22:32:15 +0000
Message-ID: <420bdab0-5222-47e6-bd26-d847ff58876e@intel.com>
Date: Tue, 13 Oct 2026 15:32:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 10/15] ice: E825: perform a soft reset when
 starting the PHY timer
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-11-anthony.l.nguyen@intel.com>
 <179184692867.434549.17457545223529058481@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184692867.434549.17457545223529058481@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::14) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|CH3PR11MB601806:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c502dd2-2bb3-4f75-7b9c-08df2979d55c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|5023799004|11063799006|4143699003|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: JY6J+HPfx1Yqco9WfKFgxMPogN0iTL+RnxFcawW7DFBVLsVhhpAk2kaHmePWo3xh4UNnxYUjTLRcWj8Pt1ZnJk6oCHBi4UTl4SHmlwjQ1VJrWquMziwSSePQg0roG+XyBG1Poo7RYdMT5Vq/9Bm5qsvODTpICTgT7xBzbqZVSnoqPHmYBhrYXiXpB5h15Smz1mUoeLAFOG9zs0KizXE8DcwxpQzhxR4BC3MbPxObTnA5vkuPqS9UU7qQvl/QNMlgQ5C39EBs4UX+hOvBrRE+gpecnTuoLviF0lSV20JAR/6/GXlbdtTydpfwDLaA82jSnCsPDxuYW+clMDacfRrPX56LKMLXObZNQvEDkwir20qotX0Av3Dph3W7JpP0SVD94mNiUi56ndoPs4UH4OcdHRPXyTsUIOq1aMB4NY0hW3hxsdYJA/WWue2Nx3xfYIhTPq7B4Dfp0PX9wnUpCLAy/sAUdtR57Jx4uVhUuRPB3Zwp+ZKRdXd2X+F4PsDvdcHlqWz+FGv8E9HCLwEV9PlESqM3lJywKCHZR+wlcQq+LrEmsM/vQeijxVooultQHF60JNNJZo8jKpUZV9E+YjHNUpPeeT7ryHvmFRuFYwYg126wDLQ0FIXRU45fuGhRjqn9stH81/UJ5gn0zDz4z5VuSVL2aO6fqDwBlbaEsXGO9k0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlQeTV3YjRLQkJZKzB5ZmtrbDByRzJZRkpxYnorWHhYeWVldWR1RkN1bEVP?=
 =?utf-8?B?N1REZ3RUN3R3OXpNUG9mZHNraDNqKzh1VTJWL3haeEFha0tiSWpkQW1hT2NP?=
 =?utf-8?B?ZEpNUXZ4U05IZllPVVpadi9sYjVUMnBHdWxRMWNoRWJUY0xTRVhJWlFwOEFi?=
 =?utf-8?B?VzBSbk51Tkp6c0VqOXpWVkk1UnI2RXpEaFJTc2RPZVNib010YktuV1cwbXcz?=
 =?utf-8?B?cXVPS2RzTkZ6eTExN240cElLL05LL0d5WThVL1dwaDBIczNEYkxzbnAwZThz?=
 =?utf-8?B?Q3VrMXBVL09JM3ZrdEZ1YTJJNjBwY0g3S3VQc2VXTm9WYnE3RjBadWNGSTAw?=
 =?utf-8?B?eXMxRUU4UE9aK0t0UVNWWWJwNWgvVjNlb2M3U2o3bzFtMEtlVVhnVmY2eFdm?=
 =?utf-8?B?dlkyamNHMlYyTnVNZnA2K25HdFI3VWZEVllxTk53NStlSlRIbFVySEZuRG5Z?=
 =?utf-8?B?YkU4KzZWTmlVKzJKczQyR1E4TnhiSVNiL1hReW5OZExDVEFqUTg4UU9Sc2Nx?=
 =?utf-8?B?c2NVK0hydWN3bXI1RW1URmhvdllEYWxOcG5aYU9sdkxmOU16eGk5Q3hJeHZF?=
 =?utf-8?B?MHFMbnpuR1oyWWV3NFlJMFErWDJXOFNlS1BwcTFsT2RNdG1mWjF5TUJRRjU2?=
 =?utf-8?B?YjBnbXgwNllQVUl1aXNRc1pZL1hBZXJab2M2VUhoa3ZHOGUxakpOeENidTU1?=
 =?utf-8?B?YVd0SHlBZzVSNzlOKy8rNWNLbE54ZzJaaEZWZzZxWWhWemdoWUw2RUJyemtp?=
 =?utf-8?B?LzBXSFdQVUt6WW8xZ01KdUxBWU5JckNNT09yZU5NRUdYcXFzVEtwU2FxUklJ?=
 =?utf-8?B?RDV6R0VJa0FzM3Zka3k1ZHRXdk85RnRHWDgvaUI5eUFQelV5N09QVlRtTTBS?=
 =?utf-8?B?bkpMQWU4NFRnL2IwaEtKejRFSjl6OWV4RGlBcVlnaVIyZUxyVkkzb2NUdjA1?=
 =?utf-8?B?T2xyRVhKNXdXWmhYeWRmTGZ5ODhXbVRrSXF5V2MvaVZFeWxBOXJRNWVDbXhL?=
 =?utf-8?B?a1BGWEpYc0w3V0lQNndRcmlZR2hjV3BzY3YvOXUwYnN2RUJRaTIzeGx6NW5t?=
 =?utf-8?B?YVZmRFVIei9wR3pNa2ZtMGtQT1h0dHVaeUU2aVcxR21zMzU4U0FET3RiWnND?=
 =?utf-8?B?Qlh4Nk00ejAxNzczeU1JTE8wblVOY1VrLzZEMFpjcUVIOTUvS2xURFpUWUJk?=
 =?utf-8?B?bk4rdFJnVUQ5N0pOei9ETlBpZU43MnBkOFRTTXhEaUxXbXg5cmljS2IwRUJU?=
 =?utf-8?B?T2VidFRIUExuajk1OXNZNU9aek5OWTVVNFFqb3p0dkFsT3JRK1JzZXFRSm1U?=
 =?utf-8?B?N1dyNWZ5d2VYb0FIZlB3M21XWHJOK0xENUJXNmZHQzVxczhLNlBNUmNGSlNr?=
 =?utf-8?B?ZnVxRjJhcC9nUVZKSG1qdXowYWg2emZHQVhTZ0VacUQ1MWVFQXBuK1BwM3NL?=
 =?utf-8?B?c0xScThKZnU3QnlLWXFLNHZMbjRPTXdNS1RuR2piY3NnQ01mZkFVdk5Eakd1?=
 =?utf-8?B?YjBwRE5mUFE4aVVqcjFjYjQ3RFF6S3ducjFkblZtekNIQ2xUaExOU1Y1NXpV?=
 =?utf-8?B?aGlnODY3UmNueWQ2MkFGS3hBVlBET0ZJSjBwS0ZWcXozZ1NRU1V5b0VpRVdq?=
 =?utf-8?B?QVpYWC9tYW4wcEx4ZDY2SVRtMzFobVZ0WC9hbGxRS1dUZitNK3Y3YlMvaFBD?=
 =?utf-8?B?ZFI5UktFSHYwZGFHeWtnckNmUmgwOW04Mnh4aWpOSDFxMlpEYXQwMUtRZXlp?=
 =?utf-8?B?bHJQamwxRDhEcEowS1NQaFp2QWNvMmNabUFUV1Z3U21UUUtkTWhOcEJHNVJq?=
 =?utf-8?B?dW8ydWI3bEl4MzkrOUJlRnhvUHFrU3NaV295WEMwQjBXTXdZSEFqQWVmRHMr?=
 =?utf-8?B?dnA1UTl2Y2l4UENUVmdhQUtjQkdGYjJxUldtUENNUTFSdzZhTWFKejJCYUJu?=
 =?utf-8?B?OE9CTmsxOGUvWll0em4xaE9kMHlaVU5VYzRSMkRoR3JxYis3YnNhbnNFY1lZ?=
 =?utf-8?B?clp3MXBHcXRveE5FNHg0R2FvaGpTM3B1MUkxemJCendBeEtTZ29RcFNVSGNm?=
 =?utf-8?B?eG5KdnhGdGlwRHhXVkROMlBvSkptSjlVdGdja1h4MWZiVThXdHB5TG1HaWFM?=
 =?utf-8?B?QXlseW5jNkQ0YkVqYUVXbGVnT0U5VVVqc3Q2cnpYMi9ZeEtzbFFFUDdjWlZK?=
 =?utf-8?B?OWw4RnVHaENPMVRpMlF4TjEzZWRNZVRkTWdWTHZHYnMxVi9TNHBKaklOV0Zx?=
 =?utf-8?B?TEdoSnN3dTMzMEI5OVRtdDZHVEFIaHFyb09pOVVZVTE5U3ZzVDhNeGlLaUFH?=
 =?utf-8?B?QkswUThBUHhpL21DL3EyTVQzZ0k1NXB6c0kzMXRRRDZpZmZqT0wrQ1JLcW41?=
 =?utf-8?Q?3MxUh9nWCUVIsTBA=3D?=
X-Exchange-RoutingPolicyChecked: CjsoKAnl4UPViNGAynv9+gzWK6t5WSLHR8KuYmGWgDkLMNhc0zG2eOLmk/xoD1WxAaDWf+AKtIP7FxuVK1vFOhwEOYcHF372kTLL0y5JmyEWW5uFTMjnntHKy3b/rL0eKN6Ec/Hmh37ssa/ZnxP9AzqWcEicpXhzbQz0+cvfInUswrKHkDJ3dPxJm9RNdzrrL0kyuwp+/JE0uiHXZcZd+nJEQVnRKfrQrT+0BNIy4PTPBtk1aLnsgCR87ALQRf4XUka3BGJN1mwbSVdCtRP/NyqdiXnkRUtzWw1DT13wANct6QxnqX65BY5PCZ1/3DidJY7YhnxFcypIE+44NZL6+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c502dd2-2bb3-4f75-7b9c-08df2979d55c
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:32:15.8450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7kMaWBzuGZ1gYoAGA7QfQjlC3IVoJEb3Hr8GMrjEflv2ZadkrRp3/qz0k/D3BN67lcd/lVubkdw9blSoPi2jRlURGNXFipcBqqoptnlgzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB601806
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 3 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch adds a call to ice_ptp_phy_soft_reset_eth56g() in
>   ice_start_phy_timer_eth56g() (ice_ptp_hw.c:2155), so every runtime…
> - [Medium] The patch runs the sweep plus soft reset on the live restart
>   path (link-up, rebuild, and at the end of the series settime64) but…
> - [Medium] The runtime sweep and soft reset added by this patch are not
>   synchronized with the Tx timestamp consumer.
> - [Low] ice_ptp_clear_tx_memory_status_eth56g() returns void.
> 
> --
> 


> ice: E825: perform a soft reset when starting the PHY timer
> 
> This commit makes ice_start_phy_timer_eth56g() call
> ice_ptp_phy_soft_reset_eth56g() right after the PHY timer is stopped.
> The E825 PHY timer block is now soft reset, and its Tx timestamp memory
> swept, before the PHY is reprogrammed. ice_start_phy_timer_eth56g() is
> used by the runtime restart paths, so the sweep and reset now also run on
> live ports.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index e83ad2bb8d420..e5bfede904314 100644
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
> Does this discard Tx timestamps that the software tracker still treats as
> outstanding?
> 
> ice_ptp_phy_soft_reset_eth56g() starts by calling
> ice_ptp_clear_tx_memory_status_eth56g(). That function reads all
> INDEX_PER_PORT entries, which clears every valid/ready bit on the port.
> 
> On the E825 branch of ice_ptp_port_phy_restart(), the tracker is only
> marked stale before this runs:
> 
> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
>     ...
> 		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
> 
> 		err = ice_start_phy_timer_eth56g(hw, port);
>     ...
> }
> 
> So outstanding entries keep their in_use bit and their skb reference.
> 
> Suppose hardware has captured a timestamp, but the IRQ thread has not
> consumed it when the sweep reaches that index. Its ready bit is then gone
> and will not be set again. ice_ptp_process_tx_tstamp() skips the entry
> until the 2 second timeout:
> 
> 	if (tx->has_ready_bitmap &&
> 	    !(tstamp_ready & BIT_ULL(phy_idx))) {
> 		if (drop_ts)
> 			goto skip_ts_read;
> 
> 		continue;
> 	}
> 
> When the timeout expires, it increments pf->ptp.tx_hwtstamp_timeouts.
> Before this change the timestamp memory survived the restart, so the
> stale entry would have been read and dropped quietly.
> 
> At this commit, ice_ptp_tx_tstamps_pending() also sees in_use as
> non-empty. It keeps re-arming PFINT_OICR_TSYN_TX for those 2 seconds.
> 
> A later patch in the series stops counting stale entries in IRQ context.
> The 2 second slot/skb hold and the timeout count are still there at the
> end of the series, though.
> 
> The final patch, "ice: Recalibrate PHY after settime64 on E825-C", makes
> ice_ptp_settime64() call ice_ptp_restart_all_phy() on live ports without
> flushing, which makes this easier to hit. The rebuild path is not
> affected, because ice_ptp_rebuild_owner() calls
> ice_ptp_flush_all_tx_tracker() first.
> 
> Would it make sense to flush the tracker with ice_ptp_flush_tx_tracker()
> before the soft reset, instead of only marking it stale? The commit
> message also does not mention that in-flight timestamps are discarded on
> every restart.
> 

It may make sense, as long as we're going to perform a soft reset to
ensure the internal counter is placed back in sync.

> [Severity: Medium]
> Is Tx timestamp capture still enabled while this sequence runs?
> 
> ice_stop_phy_timer_eth56g() only clears PHY_REG_RX_OFFSET_READY. Its
> kernel-doc says PHY_REG_TX_OFFSET_READY is left set, and that "Tx
> timestamp requests should be disabled by other means".
> 
> In ice_ptp_port_phy_restart(), the only other means are setting
> tx.calibrating = true and calling ice_ptp_mark_tx_tracker_stale(). These
> block new ice_ptp_request_ts() reservations. Descriptors already posted to
> the Tx ring with a timestamp request are still outstanding in hardware.
> 
> Inside ice_ptp_phy_soft_reset_eth56g(), the memory sweep happens first.
> Then come a PHY_REG_GLOBAL read/write and a sleep, and only after that is
> the reset asserted:
> 
> 	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
> 	...
> 	usleep_range(5000, 6000);
> 
> 	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
> 
> A timestamp might be captured after the sweep has passed its index but
> before the assert. The memory entry would then stay valid while the reset
> zeroes the internal outstanding-timestamp counter.
>
> Wouldn't that cause the counter/memory mismatch that the comment on
> ice_ptp_clear_tx_memory_status_eth56g() warns "may become out of sync and
> prevent new timestamp interrupts"?
>

This doesn't cause the issue with timestamp interrupts. Instead, what
happens is the timestamp is in the memory bank with its "valid" bit set,
but the soft reset will clear the ready bit in the memory status
register. That is the critical piece that matters, and the stale valid
bit can only cause a problem if some flow reads the register *without*
validating the ready bitmap first. The series attempts to clean all of
those flows up and the reading here is more of a defensive measure.
> On the rebuild path, ice_ptp_flush_all_tx_tracker() has already freed the
> software index. A new request that reuses the index could then read the
> leftover ready entry.
> 
> Previously the soft reset only ran at PHC init, with no traffic. Later in
> the series, "ice: wait for in-flight Tx timestamps before flushing the
> tracker" adds drain logic, but only to ice_ptp_flush_tx_tracker() and not
> to this restart path. The window is still there at the end of the series.
> 

That said, having the flush_tx_tracker() call during a restart after we
block new requests seems reasonable. We're going to discard them via
soft reset anyways.

> [Severity: Low]
> What happens if one of the sweep reads fails here?
> 
> ice_ptp_clear_tx_memory_status_eth56g() returns void and only warns:
> 
> 	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
> 		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
> 		if (err)
> 			failed++;
> 	}
> 
> 	if (failed)
> 		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY timestamp registers for port %u\n",
> 			 failed, port);
> 
> ice_ptp_phy_soft_reset_eth56g() then toggles the soft reset anyway. Next,
> ice_start_phy_timer_eth56g() sets TX/RX_OFFSET_READY and returns success,
> and ice_ptp_port_phy_restart() clears tx.calibrating.
> 
> The comment justifies this by saying software only reads indices it
> already knows are ready. If the failed read was on a valid entry, though,
> the reset zeroes the outstanding-timestamp counter while that entry stays
> in memory. That is the same counter/memory desync the comment warns can
> prevent new timestamp interrupts.
> 

No it is a related issue, but not the one that causes the interrupt
stuck case. Specifically, after a soft reset the counter is reset and
the ready bitmap is reset.

These stale values should never be read unless another driver bug
results in reading the value without first checking the valid bit. The
rest of the series closes gaps that could cause that reading. Clearing
the value is intended to be certain we've cleared state but it is not
critical for proper functioning hence the warning here.

> Before this patch the sweep and reset never ran at runtime, so a
> transient sideband failure during a restart could not cause this.
> 
> The commit message says "This ensures that we clear any outstanding Tx
> timestamp memory", which does not hold when a sweep read fails. Should
> the sweep failure be propagated to the caller?
> 

The decision not to propagate to the caller is because this is non-fatal
unless something else goes wrong. The point of the reads is more to help
in cases where something else has gone wrong and the logic accidentally
double-reads an index or otherwise incorrectly reads the value without
checking the ready bitmap.

> [Severity: Medium]
> Does anything keep the Tx timestamp IRQ thread out while the sweep and
> soft reset run?
> 

Nope.

> ice_ptp_port_phy_restart() holds adapter->ps_lock. The consumer path does
> not take ps_lock, or anything else that excludes the restart:
> 
> ice_misc_intr_thread_fn()
>   ice_ptp_process_ts()
>     ice_ptp_process_tx_tstamp() / ice_ptp_tx_tstamp_owner()
> 
> tx->lock only covers the in_use/skb bookkeeping.
> 
> ice_ptp_process_tx_tstamp() reads the ready bitmap once with
> ice_get_phy_tx_tstamp_ready(). It then calls ice_read_phy_tstamp() for
> each in_use index that bitmap marked ready. Those reads can interleave
> with ice_ptp_clear_tx_memory_status_eth56g() and with the roughly 10ms
> PHY_REG_GLOBAL toggle.
> 
> Suppose the bitmap snapshot is taken before the sweep, and the per-index
> read happens after the reset. The IRQ thread then reads an entry that was
> already cleared, against a counter that was just zeroed.
> 
> The comment on ice_ptp_clear_tx_memory_status_eth56g() says reads outside
> the soft reset procedure can put the counter out of sync and prevent new
> timestamp interrupts. The IRQ thread could also issue sideband reads to
> the port's timestamp block while the reset is asserted.
> 
> ice_ptp_restart_all_phy() runs this sequence on every live port on the
> adapter, including other PFs' ports. It is called on rebuild, and on
> settime64 at the end of the series. Nothing in the series adds
> synchronize_irq() or similar to keep the consumer out during this
> sequence.
> 

I'm not sure this is actually a problem, though the comments and commit
message could clarify. The soft reset will complete and reset the
internal counter so any duplicate reads that got it out of sync in that
window will be fixed, and if the Tx IRQ path is slower than the drop
path it will see a timestamp with a valid bit cleared.

In either case, if we add the flushing as suggested above then this may
be a non issue since we'd flush any existing in_use bits first and stop
new requests until the restart completes which in combination should
ensure that no outstanding bits will be set in the in_use tracker to
cause this issue. Will hopefully fix in v3.

pw-bot: cr
