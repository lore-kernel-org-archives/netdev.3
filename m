Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFE36195E;
	Tue, 15 Sep 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515932; cv=fail; b=uH9rEQ9f0gdxg36z7Fm2uCrQWRxwPOIB3vdvKPgRCGYmk3j+1EH2feLJ/BmUiLewhNh+qps2I30Xmnyf0x7mIfoAfnajccymAldX5qwDaGjaYYy09VZwdYCCuekuH1OwVekqUWrhc5+CIRxG5IyO/SdV1ceg623GL3NfkK0QGdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515932; c=relaxed/simple;
	bh=JLWKzKXfTE8Y7UQ0DCiQDspQY2r2fS3lAGXHEDpR3WQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uTTGfrTrWOoUaYZ/3EF69rZX9GA6e3RfyHWlYm7p7FKFnoGmGwpi/ZyQH3rps4RncxsYSYi0dBIxrLTBiBewfafvDTpcLxTCYii50NN8bHAS3etW6vubCZrRySn7f/UfhUcj3NhDHOJMDZqzomPecduZdud7BIrIOTFIw4F8wOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLeb7KyB; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLeb7KyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789515929; x=1821051929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JLWKzKXfTE8Y7UQ0DCiQDspQY2r2fS3lAGXHEDpR3WQ=;
  b=BLeb7KyBDj9WN2FRZdABPduGgssgllvGbgZWiR4614J6AqYfE9C2H+tP
   bzrHVdAGAFY0MRnNaomcdB7y46f1v6NMmHamZgPxrWUYOnxkLSfyFW5EU
   a0wZK5BsVBzRY6IMJ3HH/eZjZ0JOm8wZoU0/ljIIE1MMZgcQrgtxmeexi
   cb0ySjg17ek+Y8BoEesvYB2DPVHmsuwiuqn1IErI4AizUYTnsF0jiY4In
   AEk5xEgFnWKVtYcidK8Zrbu+TGsDw4y+91uTbE5zGxJkENWoJO0enQ2Yy
   INLOX0Kov3/G2tcreUwlLV26k0tepLecipSNQz8kP2PaxecHjB55/Kvot
   g==;
X-CSE-ConnectionGUID: uxO+YmRSQ1yfEvEf96MEfA==
X-CSE-MsgGUID: unIXJc/GTgiKuQ9oSfJTxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88829005"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88829005"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:45:28 -0700
X-CSE-ConnectionGUID: wFwwECXMTeyiDzriXAU26w==
X-CSE-MsgGUID: cQXgEfReQEqVQBUoBvQzQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269474081"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:45:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:45:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 16:45:27 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:45:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQEvYT65S7LDiJju8xjP0u1NiMs1x21D+FsYYGPfAj7oYpdftIAaYoAf5bGecbgM6xb8lhzOUDAYujy49a3j+mGF924EMZEZPDmekTO8RKZ5DBbc2ArPb0+hjujB/wPvqoE5qUmbFOXKkTRyujNSC0RqCB5bxznXv6+hGsW4vDY6rwnOW1K3YmK4phWq+uHerlvBINT/1/UScPKByQGy5ZLQu0WaWDaSvSYg1U+Og4EhWx4yZnWJI+/2vq2AOhNEpSOyAm1PnjYbNnByplVkwR+OfGTvzS/6wOZb8SYtkYyhLOaYk5E0vLS6nWAI56G8HrmrwLZvfY5myXdlFic6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOIG7s+9HWW5oHewHKM1Da4N83u7g4BwqHz5p1CuZRo=;
 b=OMJGV+gSNhaq2ZCH4S8oh+4lUcX7Ywz5rigId6LWLaxwa/G+PDJ9Sm6vzs7MlETz9p+CnZm8IX1h3NcID1xPfIYx16jmL/u0qYUlpKqYb8HM9IIlmmVfcj79NGtCPmPZy3MrsxkE2sCgzBRaFR/Yx10XDeu0ddma7f/4gBywviojJIW1Qxj8Dq6Yo0yCE7gWALJ7l3V29+5U+XPTZDhziY6BvvAbjjiEKVMXGj4XkBSFwB9BrK1ts+V0bEbY4C7+bF9cGDxQw44fl+Jz+nrEvwmCR98aZXwkG3ck5tOUeX4ZPStb7152pOhxzyE1LiTyZ0Gt7cphrNvM53ZpwniVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 23:45:24 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 23:45:24 +0000
Message-ID: <706e0153-f2a9-4103-8529-2f706f9e998c@intel.com>
Date: Tue, 15 Sep 2026 16:45:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: 8390: pcnet_cs: release PCMCIA window on
 setup_shmem_window() error
To: Myeonghun Pak <mhun512@gmail.com>, Dominik Brodowski
	<linux@dominikbrodowski.net>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>, Ijae Kim
	<ae878000@gmail.com>
References: <20260913204104.53408-1-mhun512@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260913204104.53408-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:303:8f::14) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CY8PR11MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7d63f8-5f21-4d4c-2aaf-08df1383695b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: eCTBRCQJWdMusvOBLv10yoFhhfGsP1skdx60CKYevw9h69M7DFmcucG+8sW/aDmbEQqRDXUz8is0fSwJqMIMpKeF/lImx178Zllh2RsoyE89wIEogC1ZcWUZGOFnljm3Qh05hAfbEvTtBhyUysLnrcyxgKYLcvidFJQR+cGwPqsS13MiRx0JsvF3oAhec3/fshqT1GBumDIuHHuihzxN/jSLVesZiU6G6s+5/xgBEYnX/2zhTI9E6lZoHVrJWpYKRc5d7EwkX8KXkw37EzV7SPY6dSKlBABRcrtCMAml2a/GRYIuzMgCWnq2ymbqJimTjCY7Jd5qIg6g1cDluR8HR892tr3mMdn6pHn/FbNSUisUXOHUfntMSnjXpWtlegewZaApaaolhmU979VBP3M9IqhMX0bR1WFVkfCdvaYIFRRmojRXptKwb+cMR8en5muWrh/hzlrjAOLRPYN5WdTbGuaUwYBQ/F9zAFkAWBhwt/u/ss84LqxbAyZ4GUtY1HZ6KXSnNABZjOqInZtGIOJlKufYmG80IRuJisz1eBP6jTqEJzEsEORTBJ6juV4I+FULZDzy70seyntjZ1+vGtwT0HgQXZsRxtRkX4vjBpB0y4BwjLjlTZLYPbzQOQ2bVgdq0yXoXQERf1izj5IjYYjJLNONzfdMvFooOPat2w6z9MQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGZvMEd1aTNRQXVDQmRYVlVnV2t2MWdqR2o2Z0prSS9SS09EUTFRSk9TeGxi?=
 =?utf-8?B?TmdSdjF0MXJyeDdUdDk4ZFY2bnJOdCtRb0ZzMTZYQ2p0ZkhrM2VUc01zMWIy?=
 =?utf-8?B?eTlZYlppL1NTa2kvbldNbjlpN0drSWhlek1Pbml1TUpZUU8wdkxSMjlJdWFS?=
 =?utf-8?B?WE1XWTZhMWRVSU5DaTMrRm45OVlEb2lVSU16RmIvM2ZDVXFnWFlUTDdmUUUy?=
 =?utf-8?B?SlpKTjAva2QvN2g4MzJPTzdCUE5uMHFQdWxpRlIxc2hRcWxkR25pUjZBSVhx?=
 =?utf-8?B?ZE55WjhGU2tiK0RZYWN0dzJzOThSZmZrWGxaVXJxMlVKYnl4azJlNk9XQ0dq?=
 =?utf-8?B?ODZwZytHeW5PbTlPK1VleExCVENxSi9mUE8rSzE1SmtBdkZmODZDRXN6NnFj?=
 =?utf-8?B?RmRQNzl1L2VkdjBPNThpSnEvd0NQZFpmcXVpM2RGckFNYnJOTmxVU0lqOXo4?=
 =?utf-8?B?dHNqVFJwMEVCc0dtUEdKdmJHRm5DanlCU3JTc0RIbUpwZ1ZkOEtNTk14dTlp?=
 =?utf-8?B?aUtSR25lbDZUVnVkSUZJUVlLNlIxODFna1VJbDJQY1dwUXpnL0wxWFRMRW5m?=
 =?utf-8?B?OHJHdTYrWHRsM294cWVYcUcvaStSeVFuWmc4eXAxbTk1dUZYVkJKQzl6ZHg4?=
 =?utf-8?B?YzZyWUVvbFR6Unk1blp1cjQ3a1l6V0lZc1lkQzBFTGVEQk1UZzI5cHZkSDJN?=
 =?utf-8?B?SDlaM3huS01tYkZYSnlTZ1I5ODJtbmcwYk5PcGViUG12Z09aNE5mM29HL2M0?=
 =?utf-8?B?V0R1N3hiaEp4QXRwbDA1OGhQSUJwbllSUmZYMXpFWkNla3RRNmdWbnlONHFw?=
 =?utf-8?B?Qno4cDZNajFGRCtyc3Y0M0hPQUF4SmZyK1NwT0dYYjJMb1pzQXJGMlJKZzNO?=
 =?utf-8?B?U1AvdlcvbXlrVXdLTElzWVR1SmtpWHN1NUQwZnkyRVgvZWc4MmJ5aW1nUlBN?=
 =?utf-8?B?RTVUdGVMR0ZIejJQY0MwaTZId3VPeUZvbWx3UndyTXhuQXJtNXhUaHR4V1l2?=
 =?utf-8?B?alpuejZhcWZuVFVod2NXY1J4SlJTQkh6UDRpeUsvK0llZU1IN1JDUUVaVCsy?=
 =?utf-8?B?K1dwNjdrS1FkQUREZFZ6Qi9WVElFM2FTbDZ2QW5TbGJSczR3RHp4Wk1PQjVN?=
 =?utf-8?B?TGdsQlJhUU13SFNYNHU1a05kdzhKWXV0RVpXUXpoNm05UGh4SHB5VWgxUUV6?=
 =?utf-8?B?RzNwK2wzTUtnL1BITExuOFN4MkNKUU41V3ZPU1hVRjdUeDhQNk1ua1BUQ1hW?=
 =?utf-8?B?V0lBc2tXOHdHMmZJU1E1QnBWYVVoWkxtcEx0QkxIcDEzRzZNajZOLzE2eGt2?=
 =?utf-8?B?WGVQY1ZkNlAxeGV5aGZWTnc5Q0NRUXh2WTM4NklKaTlIZThJdFc5SkpoZnJ3?=
 =?utf-8?B?S3BHU01LKzRKcy9rcVo0UFI2ZEJzNFFSOVFYQVNsZyt4YjBBRk5pSHZJMWw5?=
 =?utf-8?B?bWpIV1RqQ3c1bVdVUjBWb01YVVk1U2dKTW9ZWkdjckltUGNXZy96NlZidlBu?=
 =?utf-8?B?S3dhQ0Vmc3VhV1pRTGVnRmNJQXpqVWlMY2s0dHpqMm1Nbmx5YTQ4eUMyUmYv?=
 =?utf-8?B?ZXl5blNyNVd0Wk9PQTYyWjNuYVYrY3NucWNPWUY2eHBOeGd5c1o4M2ZHeSsw?=
 =?utf-8?B?aDVYQmJFYWlIRHA5OURCU2RWWEZGUWxVNmVJTzYzaHBhRUwrU1JoV3R4RTlT?=
 =?utf-8?B?MDVycnR3REtGelRwOTcrZ2srNnV6NlVQQ295MWVrYVhFUE9tZE80b0xOYnBC?=
 =?utf-8?B?T2hSQ0d5ditSVmc5M250RkZLeXFjNWVpSVJCVmZPWFZzT1RWMDVuYjdnbHFo?=
 =?utf-8?B?b0tVOWNHM1I5M2hMMDNoMnFEWTFRd0J3YU10ejJBT2p4M2lKdHpVWkRPSDBw?=
 =?utf-8?B?MmtWQ1E0VlBGU3J2OTdYaU5pVExzM3JxKzJqZjRtdDNkNldYSmFDQjVuZisr?=
 =?utf-8?B?S3dpc2JUaUVRYitzSlRmbnVDcm8zRm1QT3RTTTJYQkZ6ZjU4eHZ6ZDBrbUQ1?=
 =?utf-8?B?WnZpaWNnbytuVTY1aytQQWlFWHd5UFpMRi9IcGZDWGdqWk1vK0J1TWhRZjBG?=
 =?utf-8?B?TGk1SlBGTDY4Rm1RbW1HdnBuR1IyUUhBaUJTZzlIay9SNzMvN0J4dTBYQkVU?=
 =?utf-8?B?RExRVlM2V1I1VDBWMDI0Wkh4akVCcERWL0lRQ2ptMjRtRnVaV1ozSExRaWZs?=
 =?utf-8?B?Vi9Pdmd3R2R0ZEZDS1NVTkNNVVVYRStPU0xVL3A0emxSZVpFL1F5NitrUHZ3?=
 =?utf-8?B?MHI2d09QQ3JnSXduYWExbWY4b0pXS2JtUnpwWTBJTGdqQjhGK0htZmRlbngz?=
 =?utf-8?B?ZlBYZzRGaHlRK09DSEZWMEU0eTF3V0pMNFBMZWd4c25vcmEzV0xGdz09?=
X-Exchange-RoutingPolicyChecked: dhSjXpur2yoMxm0XWYn8JSxIdTBpqKVvBKozgFq66ZJ83z4jqjdA6FXYu402Xi5kNS9ptFHzdocP3jtnAFBWxAo/F/GFBLDWRAwYTh6k+oVWyUvN8H6mRP8XuCGowFDvU2CHcR6jjtIdH8I6giJKM1Sy0K4BUJKgqxaG/GHdBiHv9tHE2okHP1DcEjALq5D0FTtbQLtt+BCfHsE+sECOGlWB4gF9ww+h2f+wZvcdO6DuQFSZw3mIjaNZVWlBHn69WzarOi7d4m1T4gDLFceTVMMh4HfqolDlIHXysQdL0pafRa6cuJtA8JK0P/AbSnNVDUQpjfCdMvK1aKVTHwq5og==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7d63f8-5f21-4d4c-2aaf-08df1383695b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 23:45:24.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITl4GG3ruACuz8LCBpdWwOR5R/hjqRDdKx33yrJ+VzQwDoh00I1r+FF1DhkZj9hVFIV1Y8zGEdKI4aC6vs6776/WWzzzwRiaeLIeVpolecE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-OriginatorOrg: intel.com

On 9/13/2026 1:41 PM, Myeonghun Pak wrote:
> setup_shmem_window() acquires a PCMCIA memory window using
> pcmcia_request_window(). If pcmcia_map_mem_page() or the subsequent
> ioremap() fails, the function returns without releasing the requested
> window.
> 
> pcnet_config() treats shared-memory setup failure as non-fatal and falls
> back to setup_dma_config(). Probe can therefore continue while socket
> window 3 and its reserved iomem range remain unnecessarily held for the
> rest of the bound lifetime of the device. pcmcia_disable_device()
> eventually releases the window during teardown.
> 
> Route error paths after a successful request through a new release label
> that calls pcmcia_release_window(). Fold the existing buffer-verification
> cleanup into the same path, keeping iounmap() before the window release
> when a mapping exists. Leave the request failure path unchanged.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> Changes in v3:
> - Drop Fixes and stable Cc as suggested by Simon Horman.
> - Add Simon Horman's Reviewed-by tag.
> 
> Link: https://lore.kernel.org/netdev/20260910231400.31919-1-mhun512@gmail.com/
> 
> Changes in v2:
> - Clarify that the window remains reserved only until device teardown.
> - Make the DMA fallback and continued probe description conditional.
> - Avoid claiming that every request failure leaves no resource held.
> - Restore the surrounding indentation for the new goto statements.
> 
> Link: https://lore.kernel.org/netdev/20260731161740.44955-1-mhun512@gmail.com/
> ---

Seems reasonable to me. No reason to hold that memory indefinitely.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/8390/pcnet_cs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
> index 19f9c5db3..0cf3c0f3c 100644
> --- a/drivers/net/ethernet/8390/pcnet_cs.c
> +++ b/drivers/net/ethernet/8390/pcnet_cs.c
> @@ -1434,14 +1434,14 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
>      offset -= offset % window_size;
>      ret = pcmcia_map_mem_page(link, link->resource[3], offset);
>      if (ret)
> -	    goto failed;
> +	    goto release;
>  
>      /* Try scribbling on the buffer */
>      info->base = ioremap(link->resource[3]->start,
>  			resource_size(link->resource[3]));
>      if (unlikely(!info->base)) {
>  	    ret = -ENOMEM;
> -	    goto failed;
> +	    goto release;
>      }
>  
>      for (i = 0; i < (TX_PAGES<<8); i += 2)
> @@ -1452,9 +1452,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
>      pcnet_reset_8390(dev);
>      if (i != (TX_PAGES<<8)) {
>  	iounmap(info->base);
> -	pcmcia_release_window(link, link->resource[3]);
>  	info->base = NULL;
> -	goto failed;
> +	goto release;
>      }
>  
>      ei_status.mem = info->base + offset;
> @@ -1475,6 +1474,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
>      info->flags |= USE_SHMEM;
>      return 0;
>  
> +release:
> +	pcmcia_release_window(link, link->resource[3]);
>  failed:
>      return 1;
>  }

