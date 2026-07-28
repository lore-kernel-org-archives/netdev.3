Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE23A381C
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259460; cv=fail; b=hFkbzNW961Gj2XbwOWXBZc9cIgb0jv1Bl48YLmuGHetSJEKhJp/ihm9xwapxiI6VqjmzhfVR1UTN6ulaoxMjmVem+oc2KoYY85p55iubB3sFo+JeKPtgayCws1GWAx6mNQCGHOPSCFGrCBtVdQPU/UDv9amhT0VTQrjSXvSMEvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259460; c=relaxed/simple;
	bh=Lpt0zOn7ukm2aCs+yi2Rd42W418wVx1YlxJNzZgm27o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lCd5euRkqc3Ph85mT4RdHqREic8EjxtzWx1ojgkZfo7lRJJ17nV3gRLk5rQrQqJHqo1l+K23KUQLRP6KfAnnRURgPRUxAMRUgJ0QIGsfgc0bYhAmIXm+zD81uzRlaSFlBEbOGo9nFxttg0yqKxiw27bLe7poyBIxqXmLZOwNEeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+0zEl+c; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+0zEl+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785259458; x=1816795458;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lpt0zOn7ukm2aCs+yi2Rd42W418wVx1YlxJNzZgm27o=;
  b=m+0zEl+cjFEJnYwwBius0jWrx2YvrQTt5C/HGBlo3AYmOTMEBiwT4m2m
   WHJoQTskqn6UBiLVXrq1tXKb2kjrX217zTQ0hNtabxw+eDwwzuJmuOjVc
   S0yHAq0xJRzCgHS1Nvr3DbgkKz1v7pTXjr5t7ucNfNbncW/SwVpgycCHp
   PtxMYT6L+ASxHaI+qPnrXlNSXSWVH1uayCETLg1D2kCFtidlZHX1kuG+u
   b7GrqzINZODXUBU5G0fRKIyaChHMxExQAnuXY6uffjWQTif2ulDlLijKN
   P76uo4zAavEtbER+gh++3wy4xw/1BxAkzXXn2RuRUW4RLfrs+O5G+sGyZ
   A==;
X-CSE-ConnectionGUID: BU3dm1vMS+6GFwA1kTmDUA==
X-CSE-MsgGUID: jY7yOTpkSeSSPoHLFFYN6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96441632"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="96441632"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 10:24:17 -0700
X-CSE-ConnectionGUID: +MahuZ+nTPi1avBZeAwCzA==
X-CSE-MsgGUID: Z5l9m/YxSsCteqB+ZuhRFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="264774099"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 10:24:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 10:24:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 10:24:16 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 10:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8KBg58Pl0tsB8AyzHkEAE7KswPW93EszlFW3S5jixkhonTa6j/oEphpDaYfUHgbjEyHx0EsjrEuljj4LOd2ayVM/RSfPG0zzo8sHdbPtCsxCy2acYoeFjQzIf+0sNIXssLhEfME/i9BVpjmAb/4cBkzu/iZr0LZM/aw49xUGiT36mfpCPZoqwmyg6hZt/YrvI4cgH+uDujdcLS587B7EgpyOVyzLfK6MhYuqbHzFqegZCM/QFfpTzn/BIHPGXX5uY54Fhymru9nyKQq1h3zoc+KkVDet0YNHRu4XtjwYSL1m9V3H+f2XjC5+QEe2d7muRFvY6Dg2bN5yIBUIzz+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3/qqPK1tp3jS4JefB1Gnu8SkBIP+fHLZ77HHKcujBg=;
 b=nCJao6XLBVSZOak0u7lrEWcGWV6/mkTt+D64J4BucLSW5jvxdFC7RymtRADS2V0o5FnTLZjPlrEOz/IScEEdTToZEZNQBO1pEWHhPMUn1a889M+5SSTfeW+RGhFG/a0JWGr8kYviiVRfxkTD+wV43AbhKARCqV3ehOZL6d+W92oaLNRohOfjyskbDBkMjS+XBOf4cGrocwfQkGq6SIHMNqVamopB170gyZRRCqzr7oxrJe9ypxUJx/Fg9OY0G9FD1L4qOJOnEZbssJMjCwbid6O05ESU+jIwq9fvTY1RjbQujgAUx1Lrt+b4iZAGmdSkNGPvfggChiK5OzrtI645Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 17:24:13 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 17:24:13 +0000
Message-ID: <659396b9-e81b-4ece-aa60-25976ebb0332@intel.com>
Date: Tue, 28 Jul 2026 10:24:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 05/13] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<jramaseu@redhat.com>, <willemb@google.com>, <benoit.monin@gmx.fr>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Nowlin
	<alexander.nowlin@intel.com>
References: <20260717185340.3595286-1-anthony.l.nguyen@intel.com>
 <20260717185340.3595286-6-anthony.l.nguyen@intel.com>
 <20260723085500.71171f3e@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260723085500.71171f3e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::23) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 76566f7d-44a4-4b8a-1b84-08deeccd0ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BhGJSC7zC+RY480/vcEX49CQDp8Clzkw38KXQuATah8rJkntndCILw9dy4dCK+fdXs6HIptl/47DbLFd1Bczt4ltRoAmr32T7bTKgUIfqsVCMUkX8hrZtshsO6Wlky9aair2VvF9gT/v/XIJiDsmLn4RlI55ZgZJWryxDElJYSTxGgJ2Sav3yRaz4S56dWe73GJypzffYFay2Ekhd9MyluB9C5hyaH14EQhMQJbot5nSRuvpW1tdn5rfBm8lxaZlY51lOBc0vj0bKZkDf+rOzSQCW6d2j8wTcekUZOklaviUyw4pxh2olxHZC2XTlmH3tYziyQgViX7BHGrm0ybtqc5b6rWtc3uKT0GGo6wHilsZnn4Da18dCfGxMh13XO7G2PcUOGLKj5sQqkG2M+lJ51y0qNOgYu4bUlMSWDcU1En0gdlnkOQY3RE/Pn276kjR632odaQlH3xfvMsJdn6svMSIixrNdCAOYYdboxt1k2+g8pggt5Up3qUrQV033nAuWyyEUGP8W5VgpYvUK1A7TWTUUIGJ1HELqj2g67EOOA2fF6OWmsxo7g6axhcZ0ekrMy46Al8PQ0omm9qldIP8J/Ns8xaU8mAei15GiryRJV5FqBvHFSPCbwyWaDlUxcBzBiQJ9svm5hmZCtKlEXs4KOE51pSYufBK0Joo8jmkSiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2g2UUsyWXNHRm9mMDV0azU4OTNBZHZmeVNJZnIyUVlWS0ttN015SjFrZHV1?=
 =?utf-8?B?NFNUZFVvTTlPRHBHdUZESFZLT3g2NTBsRUNybWxDNStKeDRmdXBBR3pERlBP?=
 =?utf-8?B?SUNoTmNNV0JnZVlRUU5heEdmSERRN0d2bTd1dkJhb3VoaDlTQi9kQTNkQ0w4?=
 =?utf-8?B?ZXdXbmJUWXgzcTNMVndORXRBc1BTNjNiWkRyT0dMSWJFejhFdy9vZ3k4VVVu?=
 =?utf-8?B?K1RJRExCRDVCZzZmb0h5Q1kvbHd5L241b0ZybUcxUjFxMi9yWEF6bWpQeVNz?=
 =?utf-8?B?cythSWlmc24zZGRIUWthTmEwQjVCdHNVMXFPSnhNSEIxdXBDMUJ1d1pMa0lB?=
 =?utf-8?B?Y2YxV1h5Q0tmYk16b1FybmFRUTZ5WCtYTjg1cmNVOUxFZk5TZjR6VFZGaUlQ?=
 =?utf-8?B?b1k4anNscnhvWEFTWTN0K2ZTMittR3FWNlZxOFMwdEltcjZkZDdHM0FXSHAv?=
 =?utf-8?B?cVpUTFZkY0xZbEhDTXRZOVBFallKL0ZWQWs0K2hIRk9tWHlvc0lzTmxaNjZn?=
 =?utf-8?B?em5iZ2tIMWJHTDhMSFZCVm1kSTlOOWlIT0huUFcxTkw2OHFyYVdBdlIza3RR?=
 =?utf-8?B?alF5azdpcCs1TlBmSVBpWkdtb2RqSHltNmY3cFh5OHgwNENRQkUxamdaNU5y?=
 =?utf-8?B?dGszTkRVNUNLU3A4dFlkUEVHQi9nd0dkTDlwcnRKMFN3MEMrU0s4R1d4dVZj?=
 =?utf-8?B?YldCNlhpOVVZQzNLUGRHSzZIVXkwRFhrSjcrZFU0cGZVYjlWdXZjVEFxWHZ4?=
 =?utf-8?B?K2d5ZTVESTZVbkJwb1FrWWhwZDd2Y2U3UEF3MDR5SFUveE0zS1pIZW9raTRQ?=
 =?utf-8?B?dGEvanUvNTY0Nlp2eHVHcEl4UXFqdm9FVHhVZVhJRVZFSG9FL3Q0L29QZm9D?=
 =?utf-8?B?MjgyVkgxWFhLMkxjT3BXVEpURDJvU3ZvcFdEajJJb0dUZGZRRFhsb3l2TlRN?=
 =?utf-8?B?dnkzYXhlWGU0MmxuK1FoWjU3dnpUdFFWeUlTNVRWZ2VDZXRJTnAvNjdYV2lJ?=
 =?utf-8?B?dTV5cUZzWXNHc2gwRUwxZGpldGFxcUxXdlJTNjVrTEZjbjJPd0tiMll0Z0ow?=
 =?utf-8?B?RVpkS0lMRmJzS0tQYUlZS0pyY1h3YmxCalhxZnBDR2pjZTJkcG1RMXFFRWw2?=
 =?utf-8?B?S25kY2c1dXFjdm1CYXliUWJXVE1PY3QwWEZkYmxkNUN5SjdaZlNLYkxHaTdG?=
 =?utf-8?B?MCtWUkIxSmpudVJPbUJBZ2xoSDZ5RmpCMFFLRTU5bjM4TGNHSHAvMkx6amow?=
 =?utf-8?B?QTczUUhyMTRTaVBTQ09ZQ25kS3VJUXBVSEVsTWhWZ2VGbjdFeFArRUxocHlL?=
 =?utf-8?B?cUZRckVVK2RlQlp0RE9PUk42bGtEc0R6SHgxMWgxc2ZJSXVvek85eE10OHlF?=
 =?utf-8?B?bmkrT1NQdFN3LzhzSzA1OWQ1R0RQNmtUVlovZ08rSFc2KzNUb3U0dmZKZHlX?=
 =?utf-8?B?cll6NkQ3WlhoVHAveTZ5NDBMQnZ0Q3ozdnVXR3oxU1NmZ3Q0UUIxVWV2bldz?=
 =?utf-8?B?UWJlc1lkQW02b0Z5T1hpR1NMVHBHUjMzVzJmUkx5b1JneHlWaUc1b3NYNVd2?=
 =?utf-8?B?aFUvc3NRU0ljSUF4QXZlMTBpRWJZRTJtVktUeWVjcm1ta1dsMzE0UEl5Yjcw?=
 =?utf-8?B?NWR0U0swaUhkOTJ1b1ZCZTJaVEFjdzBERmJkdUdFZDM2TnV5a254K1N0M1Y3?=
 =?utf-8?B?dS9PTkZqM1EvZnZWRUJqODI2R2dESGRaZHJCNU10QmNuU0tvVHNUU2Y3c0Nu?=
 =?utf-8?B?NXJoUFIxTmR2RStKVWttWGVoVlN0VHd3TUxkVE51M083WTl4MUh1eWw2RXY1?=
 =?utf-8?B?SXhtaFMyVXN2Wmo2d1d3dkM1aGVXa09Yay81ajZvVys4dEl4N1RMTTdMdHVs?=
 =?utf-8?B?cmFsZWZ2YWQydEtMQWxFb0xxMTE1Q081ZHVtSDUzNkV1S0MvcW5tR0k3cm94?=
 =?utf-8?B?dmpNQ1BrZWd2ek5kcjdrZVArVVZ2eldHd2pTMXJNSUpmK201MEh4RGlhOFhS?=
 =?utf-8?B?U2xIcHBoYTNQcDFzcjQ4MmVMNmNqbFM0b3dZaDlFbkJtQlhVTExTNXdBWUZu?=
 =?utf-8?B?UlppbHYwZjBldFNjUEVQNnhNb3dPZjdIeS83QXN4WWZZVE5DejdSdGdTZXBI?=
 =?utf-8?B?TG9ZVm5paEY4TnNHSjJucVZXTTlTWitaaFdaV296QWkvOGJXMHhaWlNsbk83?=
 =?utf-8?B?a09DYk83alZkb3pSZlBpZndzTHlKM3lLaEdSakhNaDE1QnB4VUhESHBUc3Mr?=
 =?utf-8?B?QXVlSmtMaUpHcm5NVmtuR3V3U0w5L1V5aWNWWmRhTTlHSnFSdDhzWS9iRmhH?=
 =?utf-8?B?T2g1eWkwMGhuSEI0aXdOa1FpamVjOFFlQ2VQNWtLVzFFS0NhcTVyZndnZjFL?=
 =?utf-8?Q?eJO4Ze3O6WrqSS7Y=3D?=
X-Exchange-RoutingPolicyChecked: cOdq3V3JZaApBTEUIwFSi2o72x/QlDlV/sH2a2R/4gP1nRxD+60usOeJerBgsL6ARcvSqR9pVBf7me6Lc4ifWa8eWM7CCPtVSTNXGvdBhgtErEScwSRqebjLOp9OEC0vqPc6T/v/3iQ8a/osdq21y4eK/qd63eXy4t27AXcU6dFaNiNr+kCacTx/TpPEygDouB1hG2Ef4AGFzN3znRLuZSu6F1VLyAi2wWovVgadgwihHkQn8qJUdfFwIPBmpDs1dqILriL/Qdq8RRqnmrcLe8hpEV7lmwIIGK5CZ6Zn/OF9x7cy22bTWt2EktpfDGfOeNnHB3iojznVFHaOBgqjww==
X-MS-Exchange-CrossTenant-Network-Message-Id: 76566f7d-44a4-4b8a-1b84-08deeccd0ae3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:24:13.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPHOK6l/S6t5t0OGUj0mYKntN2On9utdNOcCjuW39bpLt5Hca6RCeQ6ypc3HU+UIkXhwNe2cBGLiO5uo8u5RDUJ1EU0uKvZvNIgb0WeP0YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com



On 7/23/2026 8:55 AM, Jakub Kicinski wrote:
> On Fri, 17 Jul 2026 11:53:27 -0700 Tony Nguyen wrote:
>> The hardware is capable of calculating checksum for IPV6 packets with
>> extension header. To not drop such packets switch from IP/IPV6 checksum
>> to HW_CSUM.
>>
>> HW_CSUM is also used in previous generation (i40e).
>>
>> Previously HW_CSUM was used to indicate that hardware supports general
>> checksum. Drop it assuming that if the hardware supports it, it is used.
>>
>> Disabling offload for E830 in case of TSO isn't needed anymore as the
>> check for TSO is done in Tx path just before preparation of the special
>> GCS descriptor.
>>
>> The commit from Fixes didn't introduce a bug, it just shown that the
>> driver is doing sth wrong with the checksum features.
> 
> This really reads like net-next material :/

In certain cases this can cause packets drops which is why we routed to 
net; we can submit it to net-next though.

Thanks,
Toy
