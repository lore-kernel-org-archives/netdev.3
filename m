Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEC84F5E04
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667829; cv=fail; b=aiDy0PSVCt8Wzt3a5tQzC4MeOdoczQmWaAkJmrxArRsKej2r52mi9Z/qGFASdT4Ja6dqYIE2o4/dem71gbnGpUiI1TR8YJox0nXAftS+3MQlrlNMtN8Y+3aFcvGDFfg7R9r01UMiJBNY2Vq844HumaM+6Lzgh52a/P1JsFuv/F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667829; c=relaxed/simple;
	bh=Ba/C3bLuF5GqsKrSpb5rzuo2CJMfDVkKqPMbJ5KmNaY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ahf2QT4ZBGXf5WD4inBaRyGMCLxWy6bjcmujK9HkJIGcE8CbTH6P0O7Jdyohw5I4FcxGhBOG6VhvNrxdIAuefByiAUj9Z8E+xCJ7N5brvBrO3CNDDkTkDYNS3IkKE6cX9MsPf+6ou6nLLB9yvITr9Fs3gVR+5CnXGCo6stlAfbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRkrz58o; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRkrz58o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789667827; x=1821203827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ba/C3bLuF5GqsKrSpb5rzuo2CJMfDVkKqPMbJ5KmNaY=;
  b=DRkrz58o/Buuw56oko3gf4xIrcjAjS5YLZtgG9UNivbwUe3cDc1+aTiw
   9uVg3eDQpsSa6weSJTmC/6xQAfJ7q7mSEfMpl+Q0sNDVCs9Ixn6+G1Gk1
   lvFeruW1UMhWxx6C4kkYjcOnxDzjx7Da1jTmNiFfr3chfjRcTe5GKZmKK
   iZZElu1Xs2eMDLM9DG6uGkVlPSrN5XxItCayQy2gQQIPJTFXgc12/kvkS
   DtDgpaTeWdvwmpnmA2pMl/WFki0r4DRXg7nZw3EHDoebi7FfOAtswZnje
   xVCZdxpR0BgXt8EWc2y4gHTItvahXbc0YqzrTTL7jZyAhT0QHlN/q8VKO
   Q==;
X-CSE-ConnectionGUID: DEc/ebHNRu2QDhfpvuxRQA==
X-CSE-MsgGUID: Gk7ga2e2SaijQcQJhSAJJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90139516"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90139516"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:57:06 -0700
X-CSE-ConnectionGUID: fV6QkYY7SXeHR4bSw+kbYw==
X-CSE-MsgGUID: tXlapVfPTvq7+rKR13K3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297426656"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 10:57:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:57:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 10:57:05 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 10:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdD4Kqr72GCJ3+Vi4UqHVQJpCm0rrT8JzD03FtHmNQNDPci0/np3rKgCxl1zKC1tTumv5hyv7ePF4gMvmzojXkgXxm3WZTo3mlJfe3Pf6zs+hpY7aOYGKCU/GoXgBT4UFgCXINwLGO7fMiIZG1ZyGeeerV7qh9dU3GL6ddE8r7APN8JxqbSX8MJJIUcMz/cJ/Z6jCC/lLdfQiiu5LPO9FPPMEMUlRhZVfq+IlQgUw32Kh1U8J7Ug+WatR9UcSrWnaJLPVAnQqhMiaFeTLL8iPyF84yGczSI+uAy02eSIvscyHFcyXW1TQ556PGz5KbyJ3KFJhgs41N+bfAsSfZSjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+6QtAUAsijctYe50FhLoQkY4sKDaupKPFIi+r9H3Rw=;
 b=kG/5vgRahQjC/4HTA2GTjuVo5kh9cznSWpRO9Y91sMsXhu8LruztGU02Dip4GHnEeKP6647JXFGLBGaqBq7WOjMBmgkNJ82C6uawb9qfMAW57InIASCGgXs3Z/l113HPFztSy48xzrL4CYirQt561tbU5zcgxGSm60Jz6BvQ+oOgr9YRLO+V+fk/Y3mp3bHMNgXMkLuGdjj20VIsLAHGpMtYRu5nyvItelP9OZ0EF8C0CoNQWfGOt96JQKsj4Eda3j3tcjFeYcyyUMorxKCuzBNKRSxPRnUUBLyCM+By4HGspBdKNUGCaq9QQYawpAraw9B1uMBLurY2E+ZQjWfB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH3PPFD9B78DE02.namprd11.prod.outlook.com (2603:10b6:518:1::d53) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 17:56:58 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 17:56:55 +0000
Message-ID: <f8454b4b-e54a-407b-8fe5-cc69ddaabc5b@intel.com>
Date: Thu, 17 Sep 2026 10:56:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 14/15] ice: don't clear in_use until HW clears ready
 bitmap
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-15-anthony.l.nguyen@intel.com>
 <20260916011227.1632810-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011227.1632810-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH3PPFD9B78DE02:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2b4a42-765a-4bfa-bfd7-08df14e50fc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|4143699003|11063799006|56012099006|6133799003|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: P9K4ZIaKrun7re4U9vAFauxY3QAOixFlyRAUam7vzbppVQ9gpRaMhzgxLJmSGJVTz0kolAXqS1/hyDMwXPvaQ9APpi8dL9lBcSf4q04WzbzqwtmGQFZovxtaxHeVw6ISWB9v+SFz9Ms3cVn63mbhyZoWigntepnc07iszyQ3NpBfU35msvUxeufcy7lzICHMKXJPmRtHf7FxBBKcPn4i8hhTLkinJES+cnwWD3BWYR4fpzjryEq0/dkmdELkVtTKgYJvew/+BBgoW2rZ7ENUu63ULXFOlDqVhj/0cFeHv/XwT6h0AvbcaLeDcHaBGWc+DZhU9XkIGKEDAoNRXL2t2VS0CZGURcIwqVEhATQsDjLY4xD59Q3OgqMOID1hLIHbvHWoWJ3l/Wo7B2JgZdV2mp9cE0F2f8MvY8hEOEgB4PU7IOOdlE4A5inKS0WLed40PEdJtkXYnupvrxmgZeSCIPoyFDwFNolfSThMrTUflw4jBdt9hXFeKAQM6crywf8bmvhvRCgcvZRUt3OD+SObhNGFkSqsI5uhiovKQSrki95JeqsxLTRNqozppOHAAWt1NNKGEXz4B4/MWkQjnCrJWEalqZMkiEZuVRGjcSNcWEbFbW5XkDMMWjc4YQLSD61ytHD71DGp4rwS2jp5qBRbBzG5ltkdhtNCdQgMm+XdWS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(4143699003)(11063799006)(56012099006)(6133799003)(5023799004)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU51bnNnRngyVnFyQStRL3FhcU00WFBnZnJ5Y2ZLTURvczlybEpBMEVUNzVp?=
 =?utf-8?B?Tko2UTJjblpTZG5IZWRwWDBHK1ZncGo5aFVOS2RzaGt1NEVXelZuR0duWFZo?=
 =?utf-8?B?UVVZSkJQYk9VOXFEVHBvN293bFZ6ZGhXNWJjdTE5QkJSem1IMFl3SWhqT2pU?=
 =?utf-8?B?Z3MzZFI2WVdvQVowK1c4SWZ3U1ExcG8xTS81dlg0N0JxY01WL3F3NVRqcjdw?=
 =?utf-8?B?a3B3bHNtczhVV0NjdHJUK3V4blM5L0gzN0NGaFpWbk9ObWhEazdUSThRdDRH?=
 =?utf-8?B?UHAydG5zK1VDRW5Xc1R2UUlpT01MTmJJMW1OT0d0NzNMSjZjWVk0YmJGdEg4?=
 =?utf-8?B?bUYzYk8yWlk1OEg2eFFWUHRTNlBwRENUc2l6c3RYRmxQRmZSNUNxRzRGL2U3?=
 =?utf-8?B?Y3VCZEpBQ0hnM2NCMWlFTVE3UzhHMTFqejloVWpVb05mTytGZklncFNoVWN0?=
 =?utf-8?B?M2pGT2QydTRKaTNhMlhJRjM3T3JvUkVpTVcxRnBjVmhLc0hvK0xKeXE5Nkpq?=
 =?utf-8?B?bEFsUGVSNEp1L1h6VmxZekM0WllGMzlLdjJMUXUvNmZRaW5HTzFHZDBHWXEy?=
 =?utf-8?B?WU84U0NKLzhHRyt0Y09Vc0drbkhxWjY3NkFWazQrVE5kWW5NcnIzQkJRQ0I4?=
 =?utf-8?B?cWViSFJXcnVYZWZjSVNZTXgrdk9GU2t2dHVhRVhwdjlhWXd3VTRvVTcyME9P?=
 =?utf-8?B?MXRZWmprTFQvYmg2QlRONkY0dFFKcjN6NVorUG44ZXFrVjB3bEpJUXYvSUZn?=
 =?utf-8?B?S2l6b3lhcHJmN1FXZXVLbVFVVmNyUnA4Vi9hUXcyRGM0bG9RWU01bDQ0S3ZU?=
 =?utf-8?B?Z3NaTjc2aitLZkVXOGlGUXFkeWlGeXI0REhWYitIMSsvQnFLcTlORzB1eU5w?=
 =?utf-8?B?dFZxaml1THIvdUtvc3I1clZ4K3FUZlJ1eWJ2MHR3MVBrUGdBaWhFRkRWSEJQ?=
 =?utf-8?B?ZkxQWHE2clVORE1IWlRrU2xzdjdwMjlUYnFsemJKMUNEQTlrVkJqTGZxWHNP?=
 =?utf-8?B?ejJQVmZZRzJnY1JCejI3U016eVg0K1hwOTBOL0xBSTFoTzdFNG1hNXlJWUlO?=
 =?utf-8?B?bDVtSDZZVldHVXJKTzNyRkZhODlQZmJ6SDZJb0g2YUIvbDh3MmJHaFQwQXcw?=
 =?utf-8?B?eUxXOG1Cbm5pUEZubmhsUG5ERjFVcjNPU3BxZE4yVG1QVWxSYjNkOGhsbGNX?=
 =?utf-8?B?bUhqeXZUcjhleGptdTFOUnorMXRUZkZ0TVRKOWxYUC9CR0wvVEp6T3I4L0Zn?=
 =?utf-8?B?VnJ6UWd2akFZSGlvQ3dFUStUWkhwMUhFYkdsbkVsZGJaUWZLWGtBa29HZzdP?=
 =?utf-8?B?KzFMUUpqQzFLdkhFRGFabll0OXQrY09QVjRySkQwMVJwcTZtN3ZoVGs0T3Ba?=
 =?utf-8?B?d0g0Y1BqTzl3aEwvRWkzQVZHWHNiNmZMaWRYTWlVakgreldZanN4OVdFTU1B?=
 =?utf-8?B?bVQ5WWFaaCtJRGl3c3prWGg5SFB6OHhMWEhPVmxINzFGaWVxcDhoZnhPcjVj?=
 =?utf-8?B?ZkVGek5PNGF0NHVsSk0rU0pWZHhRTlc4bFZTaFNabm50VHAyTXRWcGpFQkFt?=
 =?utf-8?B?MWRNSm5yc3RkeHY0S1JIcWdGTTZBM3V1NmFJcjJuWm8vQjRGeGpsWDZuZjlS?=
 =?utf-8?B?a1UzekZjS29TYnlzS1JISStNOXI3aURDSEZTa1djUmVPTFpWbmZNTDQzbDc3?=
 =?utf-8?B?QndZSnV0OGl6QmFvVEZiM05NTWRaWjNtOFU0c1pVYUpqSDZEbnVqYlQrdHlM?=
 =?utf-8?B?Qm1acXh2Mit4eHFJWm1EbE1tL2IyeWhaRXlGYkVhZytQckZZc2hNU3hPc2FT?=
 =?utf-8?B?UGk5c0tCcHhJZ1VyQUpGM1JFbEdzUkgraVZuUWJGVGVjRVNzRGNFcXNicllX?=
 =?utf-8?B?NE1NSTR1L3psUnJacytyQm00dG1hUHRKaHhnZFVHODJ1aWkxdndMQzVMNWRK?=
 =?utf-8?B?UXRwMUNtM0hGNGhDWlpzUmVXaHFwUGtjcXJIa3R0OGUySHloOWxNRkQyb0Vx?=
 =?utf-8?B?a2lVTkl3a2VRSE9OSlBtVWZ2bUFkUjYwWkk0MGYyMHN1SitaT1lBdlMvdUYr?=
 =?utf-8?B?OUo0d0puUXBETHhFdGwwL3o0bjdzNnJpMCtwMXpxU0Y0aXlUSVJMMjc5RUdk?=
 =?utf-8?B?ekkwY21SZXErcHd6MlNsTityRmxNYWwxbUptcERZbm9CSWtBRVRQZTRzTUtv?=
 =?utf-8?B?N3hiVnFPK0JObzRsUlErdmd5dnlrMXZrNTZCV2xZMmhDTVpwczdIM0hZZWZs?=
 =?utf-8?B?VDQwbHUvUU9hQmptbWdHZTgzR2tIdXFINFFqcGk4M2l3SG5nTXlvTFMvdWFN?=
 =?utf-8?B?cTh2VEJQei91cHRFV2dEdkZEbzBOLzNobHZIMURUWUVlWFdkTWRXanQ1VS9V?=
 =?utf-8?Q?MOmZB2EWn8d3tzN4=3D?=
X-Exchange-RoutingPolicyChecked: ikYGhBucLqCKzumZ4jpo6k1UGy2Kf6e1YjyGQhEeJGU2Sky/7GMm8KXSKY3VUCaZw9di9tufbT4Xlz6od2/LKjoI/PmNlA+iucC8ZW1bG+miN/w/xI/W0UD6z43YwoSi8vcjYiWs381KQvVfepEaK7AiKb8ccEqk5FFbOmslzzrz1nhFhtGziWc8Ix5Zm/ANyRfm9QeADzDqObeCnp2STgk244KSS/dde7cyQ9wU6oSY6gBUZOv9ZO1gqWTUE4Kj1wxBTnPD1d3N7GGz0bGZq8EUyz3Gp6Q35VtEjL80auKl3xeo0Qd050dNievpZlgBr2h/DRJdfwALn5JECPtF1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2b4a42-765a-4bfa-bfd7-08df14e50fc7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:56:55.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7fZXycQwP7blIHulUa2Non4lrMOXjg1QW4KrsUadp0D7dEcnFEtp/cvEDkUxqPjT9j/G4IVCpOjVE9KsDZZbn4I5jjhaP2JgDhIZprOCik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD9B78DE02
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: don't clear in_use until HW clears ready bitmap
> 
> On E825 the PHY can leave the Tx timestamp ready bit and valid bit set
> around a link down transition, so this change re-reads the ready bitmap
> after each PHY timestamp read and marks the index stale if it is still
> set. It also moves the hardware ready bitmap check out of
> ice_ptp_tx_tstamps_pending() into the watchdog and stops re-arming the
> interrupt while the tracker is calibrating or link is down.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index e060de5026621..832cc6ad2f90c 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -620,6 +620,19 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  		if (err && !drop_ts)
>>  			continue;
>>  
>> +		/* verify ready bit cleared */
>> +		if (tx->has_ready_bitmap) {
>> +			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
>> +			if (err || tstamp_ready & BIT_ULL(phy_idx)) {
>> +				spin_lock_irqsave(&tx->lock, flags);
>> +				if (!test_and_set_bit(idx, tx->stale))
>> +					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
>> +						ptp_port->port_num, phy_idx);
>> +				spin_unlock_irqrestore(&tx->lock, flags);
>> +				continue;
>> +			}
>> +		}
>> +
> 
> [Severity: High]
> Should this new gate honour drop_ts the way the ready-bit gate just above
> it does?
> 
> The earlier gate in ice_ptp_process_tx_tstamp() jumps to skip_ts_read when
> the 2 second deadline has already passed:
> 
> 	if (tx->has_ready_bitmap &&
> 	    !(tstamp_ready & BIT_ULL(phy_idx))) {
> 		if (drop_ts)
> 			goto skip_ts_read;
> 
> 		continue;
> 	}
> 
> The new block instead does a plain continue, so for an index whose ready
> bit stays set the skip_ts_read block is never reached:
> 
> skip_ts_read:
> 		spin_lock_irqsave(&tx->lock, flags);
> 		...
> 		clear_bit(idx, tx->in_use);
> 		skb = tx->tstamps[idx].skb;
> 		tx->tstamps[idx].skb = NULL;
> 
> That is the only place in this function that clears in_use, detaches the
> SKB and later calls dev_kfree_skb_any() on the reference taken by
> skb_get() in ice_ptp_request_ts(). Does this mean the 2 second timeout
> reclaim no longer works for exactly the stuck-ready-bit case the patch
> targets, holding up to INDEX_PER_PORT (64) SKBs per port, each with
> SKBTX_IN_PROGRESS still set and each pinning its socket, for as long as
> the condition lasts?
> 
> On this path ice_ptp_link_change() only calls
> ice_ptp_mark_tx_tracker_stale() for ICE_MAC_GENERIC_3K_E825 and does not
> flush, and ice_ptp_flush_tx_tracker() is only reached from
> ice_ptp_release_tx_tracker() and ice_ptp_flush_all_tx_tracker(), so is
> recovery dependent on a link-up event that may never arrive while a cable
> stays unplugged?
> 
> There is a second effect from the same continue. Because the entry is
> never released and tx->tstamps[idx].start is never refreshed, this block
> in the same loop runs again on every pass:
> 
> 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
> 			drop_ts = true;
> 
> 			/* Count the number of Tx timestamps that timed out */
> 			pf->ptp.tx_hwtstamp_timeouts++;
> 		}
> 
> With the watchdog seeing ice_check_phy_tx_tstamp_ready() > 0 and
> re-triggering the IRQ every 500 ms, does tx_hwtstamp_timeouts grow by
> roughly two per second per stuck index without any SKB actually being
> discarded? That counter is user visible both as ethtool -S
> tx_hwtstamp_timeouts in ice_gstrings_pf_stats and as the standard
> ts_stats lost field filled in by ice_ptp_get_ts_stats(), and it is
> documented as the number of Tx skbs discarded with no time stamp.
> 
>>  		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
>>  
>>  		/* For PHYs which don't implement a proper timestamp ready
>> @@ -2768,10 +2781,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
>>  		if (!tx->init)
>>  			return false;
>>  
>> -		if (in_irq)
>> +		if (in_irq) {
>> +			if (!ice_ptp_is_tx_tracker_up(tx))
>> +				return false;
>> +
>>  			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
>> -		else
>> +		} else {
>>  			return !bitmap_empty(tx->in_use, tx->len);
>> +		}
>>  	}
>>  }
>>  
>> @@ -2794,41 +2811,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
>>  
>>  bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
>>  {
>> -	struct ice_hw *hw = &pf->hw;
>> -	int ret;
>> -
>> -	/* Check software indicator */
>>  	switch (pf->ptp.tx_interrupt_mode) {
>>  	case ICE_PTP_TX_INTERRUPT_NONE:
>>  		return false;
>>  	case ICE_PTP_TX_INTERRUPT_SELF:
>> -		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
>> -			return true;
>> -		break;
>> +		return ice_port_has_timestamps(&pf->ptp.port.tx, in_irq);
>>  	case ICE_PTP_TX_INTERRUPT_ALL:
>> -		if (ice_any_port_has_timestamps(pf, in_irq))
>> -			return true;
>> -		break;
>> +		return ice_any_port_has_timestamps(pf, in_irq);
>>  	default:
>>  		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
>>  			  pf->ptp.tx_interrupt_mode);
>> -		break;
>> -	}
>> -
>> -	/* Check hardware indicator */
>> -	ret = ice_check_phy_tx_tstamp_ready(hw);
>> -	if (ret < 0) {
>> -		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
>> -			ret);
>> -		/* Stop triggering IRQs if we're unable to read PHY */
>>  		return false;
>>  	}
>> -
>> -	/* ice_check_phy_tx_tstamp_ready() returns 1 if there are timestamps
>> -	 * available, 0 if there are no waiting timestamps, and a negative
>> -	 * value if there was an error (which we checked for above).
>> -	 */
>> -	return ret > 0;
>>  }
> 
> [Severity: High]
> After this change, which code path still consults the hardware ready
> bitmap for an E830 PF that does not own the source timer?
> 
> ice_ptp_init_tx_interrupt_mode() assigns ICE_PTP_TX_INTERRUPT_SELF to
> E810 and E830 PFs in the default arm of its switch, owner or not. The
> hardware check has moved into ice_ptp_maybe_trigger_tx_interrupt(), which
> returns before reaching it:
> 
> 	if (!ice_pf_src_tmr_owned(pf))
> 		return;
> 
> 	ret = ice_check_phy_tx_tstamp_ready(hw);
> 
> So for a non-owner E830 PF, both remaining re-arm sites,
> ice_ptp_ts_irq() (case ICE_MAC_E830) and ice_misc_intr_thread_fn(), now
> decide purely from the software tracker, and that decision was further
> narrowed by the new ice_ptp_is_tx_tracker_up() early return and by
> masking stale bits with bitmap_andnot().
> 
> The commit message says:
> 
>     Continue to check the hardware ready bitmap from the watchdog to catch
>     cases of unexpected timestamps.
> 
> Does that hold only for clock-owner PFs? The kernel-doc of
> ice_ptp_maybe_trigger_tx_interrupt() states the hardware will not
> interrupt again until all current timestamp data is read, so does a valid
> bit that software never reads block all further Tx timestamp interrupts on
> that PF until a reset?
> 
> Two ways such an orphaned bit looks reachable on E830:
> 
>   - link down runs ice_ptp_mark_tx_tracker_stale(), which ORs stale over
>     in_use and clears link_up, so the in_irq check returns false while the
>     hardware bits for in-flight captures get set and are never read.
> 
>   - ice_ptp_flush_tx_tracker() clears in_use for an entry whose capture
>     completes after the 10 ms drain wait, and ice_clear_phy_tstamp() has
>     no E830 case (-EOPNOTSUPP), so the valid bit stays set with no
>     software owner.
> 
> E810 looks unaffected since ice_check_phy_tx_tstamp_ready_e810() always
> returns 0, and E82x uses the ALL/NONE modes where the owner still runs the
> watchdog.
> 

I think we need to change the flow to re-run a check from watchdog. We
really cannot continue to drop and release the index until we get a
proper clear from hardware, otherwise we could open up to that index
appearing valid for another timestamp. At least on E825 we have
confirmation that timestamps get "stuck" even before the software knows
link is down so we could accidentally re-use such an index.

I'd rather block the index indefinitely until we get a clear from
hardware. But that only works if we actually re-check from watchdog
which needs to be done properly for all devices.

I believe this will be addressed by one of the changes to address
comments from the other patches

>>  
>>  /**
>> @@ -2912,6 +2906,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>>  {
>>  	struct device *dev = ice_pf_to_dev(pf);
>>  	struct ice_hw *hw = &pf->hw;
>> +	int ret;
>>  
>>  	if (!pf->ptp.port.tx.has_ready_bitmap)
>>  		return;
>> @@ -2919,7 +2914,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>>  	if (!ice_pf_src_tmr_owned(pf))
>>  		return;
>>  
>> -	if (ice_ptp_tx_tstamps_pending(pf, false)) {
>> +	ret = ice_check_phy_tx_tstamp_ready(hw);
>> +	if (ret < 0) {
>> +		dev_dbg(dev, "Unable to read PHY Tx timestamp ready bitmap, err %pe\n",
>> +			ERR_PTR(ret));
>> +		/* Don't trigger an IRQ if we are unable to access the PHY */
>> +		return;
>> +	}
>> +
>> +	if (ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)) {
>>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>>  
>>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> 
> [Severity: Medium]
> One more question on a related patch in this series rather than on this
> hunk. The patch "ice: fix removal of PTP timestamp tracker during reset"
> dropped the ice_ptp_release_tx_tracker() call from
> ice_ptp_prepare_for_reset(), so the tracker now survives a reset.
> 
> If ice_ptp_rebuild() then fails, it takes the err label:
> 
> err:
> 	ptp->state = ICE_PTP_ERROR;
> 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
> 
> A later ice_ptp_rebuild() cannot recover, since the state is neither
> READY nor RESETTING and it returns -EINVAL. On unload, ice_ptp_release()
> takes the abbreviated branch:
> 
> 	if (pf->ptp.state != ICE_PTP_READY) {
> 		mutex_destroy(&pf->ptp.port.ps_lock);
> 		ice_ptp_cleanup_pf(pf);
> 		if (pf->ptp.clock) {
> 			ptp_clock_unregister(pf->ptp.clock);
> 			pf->ptp.clock = NULL;
> 		}
> 		return;
> 	}
> 
> which never calls ice_ptp_release_tx_tracker(). Does this leak the
> tstamps array and the two bitmaps allocated in
> ice_ptp_alloc_tx_tracker(), along with any SKB references still held in
> tx->tstamps[].skb, since ice_ptp_flush_tx_tracker() is not reached
> either? Would releasing the tracker in the non-READY branch of
> ice_ptp_release(), or on the ice_ptp_rebuild() error path, be
> appropriate?

I am going to clean this up on the error path of ice_ptp_rebuild().

