Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834451CF7B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908797; cv=fail; b=khifWl0UbcZTE/Oz11PsPn5er7iNIizWfZwouuaBIp+miYzdQqplWAW/9FuIRWqtTFRYjmLsiqarCgCY+zNJ7pbbeKSdIT2Ngq5gfUoQrwLSlojTj7yeOR5fuDxRocc5LZ6R/HPjh/e/EyQlb/ySD5MkSXArdZ66I6S1aBqq34s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908797; c=relaxed/simple;
	bh=TuwKUaH45nmjBbvptGA0SgJD16KL+KIxtiAH5ShcJ4A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XrGZYIyizvmy08KY8MZJImoeak/5g15G5B7tv4cBGcNxHKy/Z6oRUBKH3eA9so70nXhpTcohTiqWj8hh1o9YOVZO9TYAf4CUQLz2C8Az6HtzfDaAgNcpLPgDB3dXCKPUE5CoalG4PwTideoBVqCTHqpn63oQaRaRMOD173VtKWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsPWPjlL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsPWPjlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791908796; x=1823444796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TuwKUaH45nmjBbvptGA0SgJD16KL+KIxtiAH5ShcJ4A=;
  b=nsPWPjlL5Ac4ThsUDS9enPysmVM3NfSGcxwUp0YN8WNyMGcTK7gF7SF1
   SM7EjCHy1jy0VFZrZc9yDw995/lfyhi2UHHS3JT3j2DIot+vhYTICiQaF
   NGtggP5cy5fmcuxtN8AgXeOXsw20jHFV21NWUO8XDr+HEfwv0Xi5jtqR2
   lcEB6X3CTk1rbz9mLZhJqivG050/sjUzNJw3uF7a2hibEwk99WFEGET7p
   lLCDE41oIke8MGWbX+cR2+SPxZaI+tUUaRjgtgrJfsyoZwZ208LVV9AiC
   BavXR9UNZCsSUqr9POWvnZg6/am1ZOer5GR6jzLH8iBzEDkJCzK51IOyV
   w==;
X-CSE-ConnectionGUID: U6mxF6AlT0ybU5CPHXa2RQ==
X-CSE-MsgGUID: AfVzN7KISvm62uB9SKA78Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="526535"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="526535"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:26:35 -0700
X-CSE-ConnectionGUID: KG8SwDvPR/S87SeWSk3XnQ==
X-CSE-MsgGUID: /0DvvNNDTFC9S/v/NNxv9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="2971539"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 09:26:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:26:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 09:26:33 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:26:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLrEu5/CJ/qTjR65UdbOjAWNJFksy61lBZX6ds7er9bHQW24H/DSohp+r4sEOpi9pPDSQoV7LQCWj2MPrfg7K/IIE9GY3OzYff/oLLhEuaYHzAavSgEykva3X9msftofODCho/fGzsw5G6+7GSiKuCATbtWFM01VX/XvmOvOpmBz2ptxLO2vdpKIncnq9OVYho3MnUM+hDRjlh6rd9n8FmHNOmmvhb5LVSDa6H7QpXkV5nTBZ/bx90QhjHFw6M00guWJfDcJID7KA/jI0mYURipPSxNC97woeRGj4p/9/9xCcRlqkaY1cFN0IRAHe0AqZmlYreYmCW0D+JrVST2I8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfDTwIfHPgaYZZ8zqKHEuH58b1X4AzUEhFuHawPFkto=;
 b=CxHK7+dZe4MhDmwP2uDbrmnUbHybU0FjnX2TzVInFqS3y9vYT1eAFZprjywYe5WLoCxfijw2qD4tTiYJnoTnihy+0W3kSMsRJy6LEQm8M34L+cktrGwllWsPpOZoE7+NlmSH6WIglJ7xXDAddZghHXybHJVRDd7NPLGMLyI5daj5vNvf1IoOdZHWBCR62kU9qSdcpD4ly0GYS/Ofl8nKhrne3uj5S58jSDtqEtxJk56o7wZK8UBfr2/MvgJkTOjQs2+E6yicyBS+urTh1F+CNn17ImnEWvsTnrH1pShXh4oVSuyf4mnZQEakzsWyHL3UvIXrMQu47QtfKekB2y/Ekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by DS0PR11MB7878.namprd11.prod.outlook.com
 (2603:10b6:8:f6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 16:26:30 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:26:30 +0000
Message-ID: <e060d9c7-f80b-4eb7-bbc2-c0f1e26c4fff@intel.com>
Date: Tue, 13 Oct 2026 09:26:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v5 1/3] idpf: ignore Tx timestamp replies once
 removal has started
To: Tian Xun Ng <luckilystar08@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<aleksandr.loktionov@intel.com>, <decot@google.com>,
	<milena.olech@intel.com>, <joshua.a.hay@intel.com>, <alan.brady@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, Tian Xun Ng
	<tianxun.ng@bytedance.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
 <20261013121224.84482-2-luckilystar08@gmail.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <20261013121224.84482-2-luckilystar08@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: ff75a6ac-eab5-4050-9bae-08df2946bcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|261009223327099003|4143699003|11063799006|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: A2Fq4HDAiEYaP2/0AI2wkg7/44UxrIzqnQLryg7U2BYVB2cSrDPHpGY9S5Lqb8SOdXgFKG6IveQWFLGsWMR/3TWQxFP1+2OoKfvHqXoCeeE6dOYkJK9uzZUXRvgXnZuPuUlMRf5oJVeVbaWieNvdSQU5x0Bt5c/jWpehOg7LEVDdYvZiC0lnYmBoSImtwalohNTKAzEnQOnVdW0yyFvwYK1cr5sht7cZBXcegPY10zSoQCGvv8YnbrUiJwLz8o6VXw/IWbXaRoMyJQMBCaH9D0Ku88/8kRIMZ+fqhVPLFPjGzI0mMjCRZqnPUYud+7281ilYDUxT81l+tdhTYGDBkKonU4VqyneOG8eJQkNY50VNT+4qv5rSnS2TTgFsdqYlDjg2/2AMjob54Ca/qLk3jpnfnioZWugDrJRwD458XLslr+ySj6aB32jfNotJijkemSRgT5BHRMiCvaLBr7UHTUNFP+MJD2+SDDRkkkYLMAaXW6mPNPa9j9BOPNh5hIa/Df2aVkDMpxrZisv//OgcOpwXs209+4MkXWeBrVjBUrPgwfA2QyZpNA7fk+1WjNZQ90novE+knXfK3SAmMaObIgDhdJqFC1YRvENoROm5PLwnkkvG2Eu6GBiEEiiQaivZoInqw1aa4i/A67uc+ti4l7T20rZJyrRBAJ8WPQCwwRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(4143699003)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pWMUx5U29FYUZwcVBXZjFDZTQvVlJBSlJGc3h6R1pjRUdiSTBRbUd6RVBu?=
 =?utf-8?B?dVFncWJyOFk5bGR2cXJnWHJ0WTZOZVd2WU95Q2FDQ1k1YUtZL0lxVjJmd0hk?=
 =?utf-8?B?eVA3Q29NZU5CVjFGTCtOb3U1NDJ1WnQ1ZS9kOENMZjNFa1pyU1YxdG11VjdN?=
 =?utf-8?B?NXQyZmdVTkpyQXFTbk5LTGQyeUFuM1VzWWlFcXp3cFlDSTRHMzF2M3pRK2Rs?=
 =?utf-8?B?R2dKMmdDM2hGUGNjNVliNjlyeStYNEZuamc3VmpITldSeVpsa1dFOElhQmlB?=
 =?utf-8?B?OEYwQzRVNW03NEJtUEhyb1JxTzdrRXFHZ1FhOG4yMU5YbytYb3ZFZkI3bDFk?=
 =?utf-8?B?aFNmSnNwRnltK0VCcGN4bkRxenFtNFc1ZEFpVU1BZXR0bitETEVqK0s3UGx6?=
 =?utf-8?B?aERJL3JXRjJLbU5QaW03WC8wTW9zWi9VaWxybGZ5Rk41SEhpN0tBWFF5M2Zi?=
 =?utf-8?B?czNpMEM2c0l4K1hkSGNxZnh2TFRkUzRaR3M2S0V0MDJEZkhFa2ZueHBoTi9W?=
 =?utf-8?B?cllCLyt2OXZCOEhnK2txZU9HQnIyT0p4TUpZcUl2b0hwbEExZHpqa2duZVZL?=
 =?utf-8?B?a01UR01VbXk3ak1vSEtmdVdsaGtwbyt3bi9RK0FkMTFUR3E0cnZadGxTUjFP?=
 =?utf-8?B?UUt2REs4TVIxMDNYaVZhQ3BYTkFsWFQyMlQ3bUJPa0dXVmJIU09ZcW5sOUJq?=
 =?utf-8?B?V0pCeG9PNFFvcnNsTGlTbUYxUjlROUZYZDQzd3I5RjJMN3NLNythS25TVXZE?=
 =?utf-8?B?VFBGOVc5cHZROE1hcm9JK1hGVGdMUElZS3ZUVnZ4WXFxS2pMc3dVVGNpR29i?=
 =?utf-8?B?ejlSaVluL2orK3FiUzFjQWFsT1lXTWtrQWhEQmNvSWVqWGRrUlBYR0x5d3VV?=
 =?utf-8?B?Z3ZEdnFxS0xIK21xZlA1Q1hsZWFqejZHUTJFT0JuMm1BaWJPSENlU2VuakZ6?=
 =?utf-8?B?NnNMQjlKV2hSQ1VzVlQ1S0x1TFZndVRiUTc5QXZOdlVad2JTQkN6VzhOMzZQ?=
 =?utf-8?B?WFBTMExWOTA4TThaSmxPVC9zVkNTWlZ0V0xWVE9IcTIxbEk1MDVXdkJrcFZr?=
 =?utf-8?B?cWRpbEJ4YWgzM0RoWUxMbzkyTTBKakJtR0JLb3BLaEs4MCtNdTZERlVGODVD?=
 =?utf-8?B?VDI5VHBQeDhhSUVnaXJ4czUveTlFaFhSK2lDY0dFd2RibS9CVGxBN251dWdy?=
 =?utf-8?B?aWdCQWU5TzNmR2JVbFprMUxqRW12RThmdjJmNG1vWCtrVW9RdlFXNjVST0Rm?=
 =?utf-8?B?M2o0ZiswS0thV2xWUkcyWWJJYk5qK3hWVS8ycFhsVG5meHgzYnh0RTRrQm0y?=
 =?utf-8?B?dzZibXM0SnZRWGFHaXZlUzBmMnc3Y21jL1NINFRjWXl6NVJVbFlZeitvVFZm?=
 =?utf-8?B?UUs3UThzaVVUWnhQYkIzWkpQbVhBTXN5eDZaRXhTbUN1TkNDZ0g3TWkyc1ZS?=
 =?utf-8?B?ZkV5NElMbFY1aXVwRkJZcVZXSUlGS2FxT291ZDhTeGMvZ2YvUjMwVi91OHR1?=
 =?utf-8?B?SS9mSTZ6NDNFbFplM0FyQ1hUNlZaMU15aElhTkpMKzFINlBOUmhyU2VlZXg0?=
 =?utf-8?B?RzAwSUxIT0FjcUFBd01IdFcvSHpmQjBqVW9yaEdMa2x4NTBoMkpzV3laUnlL?=
 =?utf-8?B?d2l3VWp0aG1Db0EyemZRU3BPQi9XYmUzRXJRRUFrWGxac2ZkVjhFZWg4V0tm?=
 =?utf-8?B?WkUvOTJBWGs1dkJBYnI4b21aVVdUaUhlUlR5dk9IVWwyTUE1eFBjbDQwbU1N?=
 =?utf-8?B?YWc0Qk5LYXlYR0VuaXUrYkg3dkEyUSt3UzVCZ1VjeGVHZE9uUVA4ZWtCL0Fq?=
 =?utf-8?B?SkFDaHZsazc3OHgrdjFPd0FXU2JCNEhIOUc4bXg4R3ZYYWIxdThUaWU0eWFF?=
 =?utf-8?B?eU4zTUJZOFM0czV3UjNEcUJ0dHpxcTRIZXdsemFXVkU5dXhSM2RpbXlzNmRE?=
 =?utf-8?B?NWZoVXo4aitCNitURFRjZ2lUUmlpMWFSeVNlVVpxejltVDB4dVNrWWIrMkRW?=
 =?utf-8?B?RENmUzl6UGhyN2gwYjF3Y0hYOFJQVTMvRmtaYmRYd1IxNnNCWEgzdVR6cHRB?=
 =?utf-8?B?K0FYMjBucStzOFhPZmlZazlCekhKMXdvL05uR04vYno2Wi9KUjBjNUhOenZr?=
 =?utf-8?B?amVZaEpWdm13VkRjaHFkeHFMd0w1RHNXaUt2L2thSER4OFZtbGxSMjF6alNK?=
 =?utf-8?B?RldwQWNwQjZLc2hRWHRYZXEzRU8rbVhRTDFwT0tlVlZvbHhEdm1oWkZxY2gx?=
 =?utf-8?B?cERGSE9FN0hCNmZoRW1hNjlsMW41K0Z6QnJROERYUjBKZ2wzWGNJSDFxRUZn?=
 =?utf-8?B?ZThPZGRFWkkySzBnRWRDOEoxdFgyQk1XS1ZBWjFTVEJxUFNIWERMMFczOEFr?=
 =?utf-8?Q?e8WftB3o4SlQY+dk=3D?=
X-Exchange-RoutingPolicyChecked: q5H+81+NWOP5/vTjZmYJWui6yIXYmOj85S1FrsxSFtYw7Ayj9/+/5pNZtdC+3D2zn0z/DHl2/zbI7K7WFMcunwpLuDSBU4JKVqlCdaL+1zcKXZeuHBt17pCQN11MSXm5T5ufzF9cRrWn4Lyd+ujYqljCCgafw3lZAYwILEXLrz4+aOVUsvDQLpVzolNeGOZPLMQTfUEAlsIKQiy8yWG+7gQctNfHX/btMIybj7621VAcqfEiQzr5ir99CseWtnTR4zqAv0B7gjAyTO5JnO/VQFhR83hLfYqaH540QTqDcx2SE3SrWuqECOaaTdLDFKnx4zI6WmjMm93uB1wd9cwbCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff75a6ac-eab5-4050-9bae-08df2946bcf3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:26:30.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mltYd95lYKWoiq69MzBtSRiLawzNUJFWPQwI+NYwACVC2CR/dQufo5BwKTOGsucv5Jc+p8KSm6u1Oqwj2aoJcCb1XRbXChDqYUresLZjODo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
X-OriginatorOrg: intel.com



On 10/13/2026 5:12 AM, Tian Xun Ng wrote:
> From: Tian Xun Ng <tianxun.ng@bytedance.com>
> 
> On remove, idpf_vc_core_deinit() keeps the virtchnl transaction manager
> up until the vports have been torn down, so mbx_task keeps processing
> replies while idpf_ptp_release() frees the Tx timestamp trackers. An
> async VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP reply handled in that window
> reaches idpf_ptp_get_tx_tstamp_async_handler(), which reads
> vport->tx_tstamp_caps and takes its lock after
> idpf_ptp_release_vport_tstamp() may already have freed it.
> 
> Once IDPF_REMOVE_IN_PROG is set, wait for a mailbox task that may be
> running a callback before releasing anything, and make the Tx timestamp
> callback return when the bit is set. Matched replies to synchronous
> transactions are not affected, so the vport teardown still receives
> them; mbx_task is requeued straight away for that.
> 
> The last patch of this series sets IDPF_REMOVE_IN_PROG on shutdown too,
> which would otherwise expose shutdown to the same window.
> 
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl.c     | 12 +++++++++++-
>   drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c |  3 ++-
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf52706..d0db60647 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3204,8 +3204,18 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
>   
>   	/* Avoid transaction timeouts when called during reset */
>   	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
> -	if (!remove_in_prog)
> +	if (!remove_in_prog) {
>   		libie_ctlq_xn_shutdown(adapter->xnm);
> +	} else {
> +		/* The transaction manager stays up for the teardown below, so
> +		 * async replies can still arrive. Wait for a mailbox task that
> +		 * may be running an async callback; callbacks that run later
> +		 * see IDPF_REMOVE_IN_PROG and leave the state released below
> +		 * alone.
> +		 */
> +		cancel_delayed_work_sync(&adapter->mbx_task);
> +		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
> +	}
>   
>   	idpf_ptp_release(adapter);
>   	idpf_deinit_task(adapter);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> index 14dba40a9..1422b30d0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
> @@ -550,7 +550,8 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
>   	u16 num_latches;
>   	u32 vport_id;
>   
> -	if (status)
> +	/* The Tx timestamp trackers are released on remove and shutdown */
> +	if (status || test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
>   		return;
>   
>   	recv_tx_tstamp_msg = mem->iov_base;

Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>

