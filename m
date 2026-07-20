Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE43C3F5C
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587701; cv=fail; b=ckGiRr/DScj5mc5OkgPXG7v646DyB2LttU8B93LKoMn5vf/4ub+pSpPg09rAXRxguzHK4blg/4adKwvKxz40oxqDrf6qRazZlvM32IN/hRqBighS3P/nqGK3SAN5PKIMz9OfS84OE1R8Rbloz4WMl7nMBjKbKy0G6F26mAoZrYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587701; c=relaxed/simple;
	bh=ZeY3c0JMwXEyjiu5MJLEcoOgcKc6NEPAkAX46apFAAY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KXjw1TqVaSJbNBjzRIQsSTqBw/LdYhehOyb6K756Xjeh8FUSpEG3c7MC9FBuwN8+RJ//Y2L/pEHWy+yXnJTjtEFxypBpX16ZmH9Q0qKM5H0rgytdwZilsFLBg1O3Q5ZMp6H+4k5dy4lBm45Q8q0phMvDvJxHzrVGn9cDIwT2di4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkRFp1h3; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkRFp1h3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784587699; x=1816123699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZeY3c0JMwXEyjiu5MJLEcoOgcKc6NEPAkAX46apFAAY=;
  b=AkRFp1h3ORv3uFpFNsVsW2Uqu8TsrxyOyVDH0R+a/Y13WwK/Prt7IxMX
   jrIRdzkg509rgP3KqzJ0yDkLPYKC827MTljCy/zzLtQ40UeC+tdZM6qWi
   9HaPQ313XzmhAWka5wsrbzOI3XJGcsmsMZzmOEdCUFKsV9pfh4q7WsBfX
   6F/vqpPBI+3ztrCj2j035Pr1jeyXDuuv4FkP6v4z8yTPFZcyBWhOASEDX
   G8hJgAes/UdjP5Zk95OxnEOcfMyR08hpsBlyauYRbk1lOCPzPrKMTpYXo
   VoqbyIWcqSMG+8i+pelAmkJGUKqxJTx+n0V1CdIGNHemF85qKBJtRgn3x
   A==;
X-CSE-ConnectionGUID: EX6/Ty5XRp2XWyTUbwvsZw==
X-CSE-MsgGUID: 106IQnY6T3OtHKAt+lwYsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85201433"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85201433"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:48:19 -0700
X-CSE-ConnectionGUID: tFjQZQGjT4+BOvVXDOZJ0Q==
X-CSE-MsgGUID: MZiSv/JYTCK3R4U0qiZDuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="259570393"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:48:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:48:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 15:48:18 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.12)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:48:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im1HAtV93YDq0TfjYvhtMuG3xxcoHnOG6mlvwxqq6YmrWHT6EFmfOAftxDsOCqPnaOXrwZIKsynBYTgv6rDjJZ/9214EmuKgf73igS5MOFJea28Faf2GE/iQ513FjdMQfEtz01FocQdbEQ3q7AXoansdvs8fGDOnT3qrNj/C+VZ5i+3h3s3KLEtrCwYOMDE7IuES5SrYE3hgF3FjBQTtRgaEuXreeZ9ldgT5AQx65FJOKBMWE6aqLUwJ2dUgVXh6pK+dpLZhjSfEDZfIAuuQCCZeSLwNVKdr+0d/MLRnQxdu8+YPlY+F/0HkAksqfkxHYtRIcK/fJh6QupcoIt5M2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m14BpINJb623SiKHt8/tkPmWnRcVuET3vcWE52jiJ9w=;
 b=VGt2kTt0uGkna/dyDEUdAcBkguRsItgHuBX3vlB1GtxwMv712cUx3Xkw2xNIVIyboiqtXEHXBTb244zgMv5Boc4FJuh4Jnhwn/l0V2ykSjuNAuaxiKSDyx13RRg4biGJzOs4FCERG1Rm4q+fP6/jwKNxrlM3pUvrZnaX4K5s5NE5095IHZy8R4XfQZ3q1OeS5MwcivXCywH2COwIBGcZopyg8XAPBChlWEL/mChsuZo2ol/zLjmnXlyadbiP3pPNxWfh0Vh+Cm6TmnRJCsCjuoWLzPlUX6JK8z92GZber08qkVJ1yRhwwQ9Bli4hz4MGCJieKWgJe6hKz5T/Upp9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 22:48:15 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 22:48:14 +0000
Message-ID: <5e0444bf-b258-4a6b-a1dc-fecc3419ebad@intel.com>
Date: Mon, 20 Jul 2026 15:48:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/3] net: airoha: defer GDM3/GDM4 WAN mode and
 GDM2 loopback to QoS offload
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, "Madhur
 Agrawal" <madhur.agrawal@airoha.com>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
 <20260721-airoha-ethtool-priv_flags-v9-3-9c15d8b71a56@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260721-airoha-ethtool-priv_flags-v9-3-9c15d8b71a56@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ0PR11MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 805b59f1-7e53-4164-0650-08dee6b0fbe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dtwKjaE/jYxq/n5eLKxjT8MCp9BuHXhvDGaVs5Hm4sk/ZCmlg3QBb9GrDTH69waUrmZrI/K33DF5Fw+ke1ow30PvQ3CRk8CPpOxFNTiecoGQI+fbBzTw4pIiGHpyROvvoJpGXyc8s60l48fUTTZVGZbSCQv49+SJ1xf6hkT/0PZG+/UZCsPa+iYUD9ViTt2eBkxO//jcb6GsLbIZJCNG9lpHR02p0YrHMKMTYZ0APTIwAG1kHwJCuwhe8ks8GoEo1P8RLb+E/XxXFo11PCx0GXfGpgCZUYH8BsrXGNZ0BGxRQGsYaeoogR+pHG4fWOQKWgj4MSs5b8V14UO9vn0FMV9r1AEQYNNC5Q2sGF9azmhu5S27XnYiINOtcbI02uVJUSnJovm+qMK/O8s7fT9TZPw4lKqe4MYAWKtX1Fdqj1BWDLLeYSjS7yhZRDw5a9T7G1NgVhSHAeDfGzMcDmid1pwRbKL0hSndzcVHnINaclArV+ze7l2lwO8aibOR8OVj6KHaeD6h585lYxFF9jaym8VpDHCMQCtE/jJBOQ7nPdsKIx18T7W5sjwNuFMMJG7JK/CEApI9IP4JshNpfv7MQ95AAQjMbCYeDU1euM+gjE7fYA1zW8JG5MGe69SUGCxc1DXhepMUHAaRtdxSEs1aIr68oWvq3M8lTE5mhph2KJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHVIaTE2RzBocWFMUGFTak9pUm5MdGJXUHZVV1FKcGl1cHNBaHhTcERzM213?=
 =?utf-8?B?eHpOcVdWUHBTdnplKzJodUpBS3J4bmlId0lSbXJUeGN3OXBCL1VGbzBQV0k4?=
 =?utf-8?B?QmJtNit5MmQ0T2JyNUQzbDMyc1dmK2h2U3czeHROZWVRcElzZ3Q0cHRtSzVP?=
 =?utf-8?B?UE94ZjBRWjJGWmZZN0lHS2FsYWVLcnpYbGtlVDBMRGhyM1lkdWo2NGFlenp5?=
 =?utf-8?B?bEZnRFVMZVZZbnlFR0hyN1ZzaHd3NHJHQWVhcDhVU0hsaStqZW5haDAyVmpp?=
 =?utf-8?B?S00ydXRCKzVTUlJGaUNFcWJzZXcxcE5kOXdpQ1J4MmRhczRiZ0xpRktQZVV5?=
 =?utf-8?B?dDlBc29DeUF2UHBPektqeW40YkdPem1lcW5UM1J0NCtOeGNDVkJ5b1NGZEZ3?=
 =?utf-8?B?NVlOYjVUdnM0YkZDeVBqRXJseitCemJUQndvRVordzFUSVRWUExWN0ZnNkN2?=
 =?utf-8?B?dmtyN0JoaWdzeTFnMloyWHpnZ2IxQzU5N1VkMkh2QVpMZVRoSDBOY0dVOWxC?=
 =?utf-8?B?RkhjNElIMVZ3NFRQSW9yNG1wNnJPNzRmUi9LckxpM2lJTmxuM250SHhvSTc0?=
 =?utf-8?B?VkQ5ZE1Zd2lYUWMzdGk3WVQvRzRIQXBzcjhCdXdVWlJncW45NXZHYUhwVzNV?=
 =?utf-8?B?Wis5VXBibVpZMlh2d3RJZ0xwelhXaXNUd0pMWjBRcFJQVk1jZWxrb3Ixalo5?=
 =?utf-8?B?N2Y5dTV4QVNMQmVaekhKQk9sa05hdXZKYmJlRWxULzEzRnNIWGptMzlBOFdm?=
 =?utf-8?B?b2hPQU1xdU1pMTFDbDNjak5mMHl4bkNtbnBac1BCeDgwM1dXYzRUWm5IRFFN?=
 =?utf-8?B?aXEySHovbysvMzIrT0FUMjE5OFFZQWdOUDNYd28wMTBMaFdyNWF0K3FDdUpw?=
 =?utf-8?B?aVpWZmdFTmNmVlBFaU5uVGZDb3RxSEVvR3VNTEhzY3ovQ3hRYWlmVEdkZ2ds?=
 =?utf-8?B?bnRqRlhZVHlDUFRnK3BXOEVvWER1cG5NZDdDOWtlL2Y5Z2M5MnQwNTl4MndB?=
 =?utf-8?B?SXRWaDB2eU9RWHp5dkxBNVhWamQwbG5vOUN2Vklta2pjTzBFZE5Ld2xwSHhi?=
 =?utf-8?B?SmYrb3J3ZGhBaTA1SnJkMW0xTFVFdVBGbndUS2hDNUg1dHgrNTArODJwamov?=
 =?utf-8?B?WWdHczlhNnJ6Z0pLS0JaK2k5bTQxTlg4ZC9wNFE2M1p1VzBPaGFQTlBFNHBj?=
 =?utf-8?B?czVaMW1sT0Q3N3hiWXpSdTlmMTV3ODVHVDk4NkhaNTNVNTQ5bmpjTEF2czA3?=
 =?utf-8?B?bzNXalRVL0ZWSThjTWtzZTFJWmRIdFZ4WmhHNmNyNVpkVHEvMEFFNnpPV1lm?=
 =?utf-8?B?ajNUMFkrZ3N3d0F0VVVFRmlEYW1tYUtQQi9XZ3VhT3U4SFBjVDZoVXN1WG9i?=
 =?utf-8?B?REtYOUtkaUJ6amV2VUN5WUR1VTIxMFd2MEY5bGx6Y0VHZ1NMOGxYWVZOZUc5?=
 =?utf-8?B?RVovVjdpMnJJa1pNSWVGTWtOVkJQNHI0aW5sMVVSQWtzbk5NL25tQ0Q5dm81?=
 =?utf-8?B?QWlpRGlkLzV2VzZQd2E1NTNRSTl0UDRTcmNmRUFnRUZlTktSVVN0VG9DRWlI?=
 =?utf-8?B?SS9UbVRsY1NEaDE3M29FSEk4QzhDY2xuZHZlTGU4MzErMnBldW45eVNoTk8z?=
 =?utf-8?B?OWIyUjBPVG9xcHB1M1R1QVpkREVDVGNKMkh5Y0ZIampCMDgzL1VUempXZFVP?=
 =?utf-8?B?Vi9xcnZSN2xlZnkwU1N2WUM1MG9maS9McUtQWkJBWkJOeHI2YkZOWlFmZ2RO?=
 =?utf-8?B?KzU0V29QMkxkV2dYelRYU3lYd2JuekxMekg5bDV1MVJmYkRhU1hlVUpMQU5U?=
 =?utf-8?B?RDlEdU1lT09jemc4MTB2OHdBZVZYSWhDN2J6TEJBaFhNTnBYcUVCREtXZDR0?=
 =?utf-8?B?eGpwbU4wTC9lRXZCN0dFNnc4bXdBa0o4cFU4SWVBWlZMWWJjRFlYZ3Y0TGZS?=
 =?utf-8?B?bVczcWY1OTdkenFnWUpZWjVnM0Yxd2llV3VNakpUYjhvRzVVcUNLRHYyem1z?=
 =?utf-8?B?NmRzOVZiMDgySHBSMVora3Y3OFgvUWx5c21weWRhT2pFQjAvUk5XZEozU3JV?=
 =?utf-8?B?WkVvRzE3emRRTjRHVTVQUlZsSXR2akFUZGVvajZjay9zZ0NVZHVOWEszNWdz?=
 =?utf-8?B?R3piK1F5R2lQUEJlaGxYZy8vczN0dTk5SE5JaXE2aGZERDFsWmJEazFqM1hp?=
 =?utf-8?B?WHJwYnZqdGczUjh3S0JaYVdFVlhQSFkremdkL1M0ZGpPSEVZeGVQOWx4RzNX?=
 =?utf-8?B?dm1Lcmt6dEpmNXdFL3ZhcXQzYnNJcDJyT0orckNwblhGdGlISENhUnZQd3BJ?=
 =?utf-8?B?V2p0VU56dkRWRGxnSjZTY2lDaHJ5R1IrbXFNSmdoRDl1d3dLYUJsQT09?=
X-Exchange-RoutingPolicyChecked: CNThRi8FWkLHLVa5oclAymolDAE+r32sPPECoyWqmGv2MqkCltMp3Kjeu5ZK8Lf3hhvMDKjsoQhkB4+KxZ7j6ReMLgDo8hcx6ZVj/Yk7hnS0GvIYjmgGURDp/hkJ5k08ODiYYvwTmvl+EmTs+EkvlUCFQo83BLBC/wNPzYr6lz9BoaQOIWgTW7SrtxeJ2r3iH9UKjRict4sd1xBYCJc8XoA9T8m75KKj9t6YQ+jVtwYCKmchwJDpqTeWG8zQrARYIjd1+xRnuUdfMoRT5JR6ehEJLmG//UAaNcALUX4QLDVQaf3m44SySDptyEI6BuNK3vKm5geQaGaV2wCTsFnYIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 805b59f1-7e53-4164-0650-08dee6b0fbe0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 22:48:14.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPkY18lL1qyyZUK30HTRwLMKdeNR04Wah4/WvDZXzF1qB5TP/XSwX2sUV9WMyL3KYjR1awN8Rl66dYJlvdDFVTOiBG07d9y67xOu5aMPyfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-OriginatorOrg: intel.com

On 7/20/2026 3:03 PM, Lorenzo Bianconi wrote:
> GDM3 and GDM4 ports require GDM2 loopback to be enabled for hardware
> QoS offload to function. Without it, HTB and ETS offload on these ports
> do not work.
> Previously, GDM3/GDM4 ports were automatically configured as WAN with
> GDM2 loopback enabled during ndo_init(). Add the capability to configure
> GDM3/GDM4 as WAN/LAN on demand when QoS offload is created or destroyed.
> Hook airoha_enable_qos_for_gdm34() into TC_HTB_CREATE so that requesting
> HTB offload on a GDM3/GDM4 LAN port switches it to WAN mode and enables
> GDM2 loopback, with proper rollback on failure. Introduce the
> AIROHA_DEV_F_QOS flag to track whether a device has an active HTB
> qdisc; clear it on TC_HTB_DESTROY. The device keeps its WAN role after
> qdisc teardown so that its configuration is preserved until another
> device explicitly needs the WAN role for QoS offload.
> If another GDM3/GDM4 device already holds the WAN role without an active
> QoS qdisc, demote it to LAN before promoting the requesting device. Skip
> the demotion when the requesting device is itself already the WAN device.
> Since airoha_dev_set_qdma() can now be called on a running device to
> migrate between QDMA blocks, make dev->qdma an RCU pointer so the TX
> path can safely dereference it without holding RTNL.
> Hold flow_offload_mutex in airoha_enable_qos_for_gdm34() and
> airoha_disable_qos_for_gdm34() around the dev->flags update,
> airoha_dev_set_qdma() and GDM2 loopback configuration, serializing
> against concurrent airoha_ppe_hw_init() in the TC_SETUP_CLSFLOWER
> offload path.
> Introduce airoha_qdma_deref() helper that wraps rcu_dereference_protected()
> with a lockdep condition accepting either rtnl_lock or flow_offload_mutex,
> and use it across all control-path dereferences of the RCU-protected
> dev->qdma pointer.
> Add airoha_disable_gdm2_loopback() to disable GDM2 hw loopback.
> 

A minor nit which may just be my personal preference/style:
I had trouble following this commit message since it goes through a lot
of detail about various problems with dereferencing and other changes
related to allowing the defered configuration of WAN mode.

I do appreciate this detail as it helps understand the changes and
motivations. However.. It might benefit from some additional line breaks
for spacing to help readability.
