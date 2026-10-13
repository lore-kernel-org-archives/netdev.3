Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D8518131
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931455; cv=fail; b=j74ooZ+kVVQya3KPd44IJcu0hgs1QJvMaeuUpxjeAl8rFlpVxUIkXhgZDb6lRFM+RkRtepZKXJMTubs1aSnfE5baQFHz0XXGtTELJPDDEnkT7uz8iyyzOZBtg8voRCE0lrii9pkwFrXX28neLGi30BwtIvsjn4ve388D59Dl+4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931455; c=relaxed/simple;
	bh=bRTK6yCS9hbsxSn6mQk9k/F98XuPiOfySn7jrxAV04k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KLtzWdpkwJIHLyAt7rZdggufRoU9agV9qLdqHR4pz181AouKv4tI7w9ELpQw3OKRB3bsEgEhXJPpSineRB5RroyAPGyKE6cd+3l5qusQG0WlTIYlMChxGos4e4SAppnGxjas533w51VEJjFZIMRLfHhQqdgmgEd6x/xLgdQevX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYF8e+46; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYF8e+46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791931453; x=1823467453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bRTK6yCS9hbsxSn6mQk9k/F98XuPiOfySn7jrxAV04k=;
  b=cYF8e+46Hk82iwLrZCqNRq6CqTRPUZJvnx4eXOjwAjDIFWCuXEAs1qIV
   iEMa2jPL0aNWwTryKgL2JsIqEa2AX1hVWkHVzfNF7n5KjjL9RRnzAJ3xy
   +YoZDL79G6t5glnOdF8q2gsI3F+1VUdcX4dc7DoENDr8SPeXk2erLNW7n
   6Td+K5/6Uu6q1o+ljcNjhdppr8OasdtxOLGoeFOzmaYkSV2P0PoaYklfx
   0WL5wZFd6BK5J9QfMN1cIJiKvQEo2T3bI0sHpvqyCzcwELbVl8bXnVEwc
   1i3Gyl/JBsDS6vduhdqI75YZ+bjrCV/dgCu7lOtUkVR8HIWzTDrWDs8UO
   w==;
X-CSE-ConnectionGUID: 2fMgdOalRAydmDOvvbIbEw==
X-CSE-MsgGUID: kuMQmS1kT/mQuRh836c7oQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="677827"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="677827"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:44:13 -0700
X-CSE-ConnectionGUID: EE/6ShQmS+2k4sSTYMsP1w==
X-CSE-MsgGUID: iQZymQxqQOmLMZmrbVbpmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1596849"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:44:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:44:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 15:44:12 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:44:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6oGwtNXJ0fmsnhPEjNeec6DMMnTh/xfritrxkbGdvdlywwv1t40+vOR9k6XVELq1k7Nk4Ht7DaRbXDyUKM3c/KMHNMX9iJKO5CjB6foUap4zzyK14X20Oq+pXo2yzUyAyw2JNh22ecQyKo9u1W+Bgxz4wjSnbRkB+xd8XUcXXTq4eYpNpuFDCkpTn3fd1ajpTRE7IWfhKbgf6XhH0aouh3uHBvdbNLFWRW/Qecpg5F38nUzLBzSyu/21M5GQOgf8MjnJvrjF4LnsKpe/kBTgyn+G5Ob7sNgN8AbwbdZlv3280eDECIfmrdyCNALFu3GYSEuNVrgHkujzag/Xf2dgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf+UcZpBA2JuGZe86mZ4e7p6GAdJNpbQhenYdg0EhfA=;
 b=Y7bsNlUaD0WTAdxNSh8me9//l6ATmJYFt4BGnSjSwy93Q4NWnc75/DluNV2ge05Sfzn4TQ/vsK9BRGcsSlenEA6VHopDyH/d2VIeoxLV6Atz7RCM5G3Cc8gikbh1tR7hixrVsqOo9/E7fiqlLuFYO0zm9BJAC4kO8j+cqPMYKyaAohxtAc3PLyqEtmIjT6/D+WbgQQmx7Xf9GkRl0kjm/JuN23BRwX/d/8KExNNcYTsL6mGzPJWeq9CH6cv5hzjPE+zSaM/bD22OU1i5UpaI0kf3xVO+SSbpWKEzv796+BEcVGpeh11DU4x1GpJDVWAXqyqvbxLn6m/0Kj5+/XzFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 22:44:09 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 22:44:09 +0000
Message-ID: <b42bf038-8bd3-4cae-9b5b-408772edc595@intel.com>
Date: Tue, 13 Oct 2026 15:44:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 12/15] ice: keep Tx timestamp slots tracked until
 completion or timeout
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-13-anthony.l.nguyen@intel.com>
 <179184693169.434549.6103061809341882810@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184693169.434549.6103061809341882810@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0221.namprd04.prod.outlook.com
 (2603:10b6:303:87::16) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|DM6PR11MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d7d620-aacb-4aed-5398-08df297b7eb8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|10067099003|261009223027099003|11063799006|4143699003|5023799004|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 1E94jfuI7MuGj9AnuGp4wa7BvQEDyu2/nZXt6YOuIO1DAPabev0YjpPS4kRsjQew9GWo/48nKq50WcZVcjr0yY/x2df4spUKJmLlhdBAFSogVNzYSZDcoG91y0kuGh8P5DNZswdb6H0XC8e8nWPwB+uJvrxLRYXjIAZ+CM5W9X9a50bN4W50BktWfemz7GqjnEtbFsDJ797OwYkzF6ed26oFrEOW4QxidAXWGHMvCaPlS0tLMFQ8HQOYXcjWDoxZIjyk28dFoLpSET9vLWSEc+HNYj5fg4EcrjlAi1b1eSARjzdnOURxY+z3Fs+IewtNmybcr7MOt4R0hYlcXOJ62LfR9xXib8BRuGTQq94MGDzcxwssTo2EnZyIvbu0i+Xgipa/hj1Jg6/6Yt6ojkjV9OVTvIxq9zTiBoJJSbKFFPlNMZEBQI3kR9awcsSoO5Wt8e3sEVTZilINEFzetkmDMQdoUSJSJ/n2g+n8dGwph27u3HGTeWdbnplsO5Zktoom6QTfDnn2HzKeAkYEtPwbibjcPpV4B/DDFwctAykMXMObQVecm6bG/XD8cjl4X6moD4AuQiFYMxbM0orPoR9mwttm9XMa39Qzuf9w2F9tugcC4FEUbhg+NMqdfYJZK4/h7cRFf5b9vukNSZN1bzB06850MKSCLnobkIIOKcLwhKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(10067099003)(261009223027099003)(11063799006)(4143699003)(5023799004)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFoNk5QdTVvU1k4emJ6cVFpMXdKTGZnM1hCNzIwL3JDeC9jSzh6dzkyemdN?=
 =?utf-8?B?OHNhSE14VmF0bkgzWnhqU29wZWkrMUZWVmQzNy9NTnBiZjFPTndWd0ptSFlU?=
 =?utf-8?B?bjJPSlNjbGZuUjdtRFgwQ0tlMjlHQWVraHhvVS8xNGhUeDEzUVRydnMvcE5Q?=
 =?utf-8?B?NHpBQUFENDFaWDRTYTVLZkM4bWNQcXREalN6d01LaDJLcEt3bHlqZXhYSmpR?=
 =?utf-8?B?cGRCSGE0dk9DTDZ4ZThSSUs5c3VLRTJNSGF2cytxUXZYTWkxTUxZTHZpZjcx?=
 =?utf-8?B?V1dVdWhHYlMzdlB4OVUzU3dHQnB2MG14WjdxZ1pKZTh5d0t2eWRyc1lldm1s?=
 =?utf-8?B?UlFtU1JkTnpDYWx3aG1nS1FaYjFOYnJ3WUtta0Y4TUU1bGw2YjBuWGhydnpz?=
 =?utf-8?B?dEdoZXgyRDFWYXhuTUZwVVBqbk90bWdYWmlkUDlUZ241V1RBVllSYlZJMHhP?=
 =?utf-8?B?VDRMRVY2WVVhNHE5RFRpOEpTaHhYU3JRdXNtSFZyTWZiRXRTSEVYekRvL3RI?=
 =?utf-8?B?UExaY2g4SUtESG16MWYwNjMvSHZtcW1FZHlSUG9meGxoSnp4TkpRTHliejR2?=
 =?utf-8?B?NTJkNVEzN2o1Ui9BVnJMTWV2YUJFYUYvbm1JYU51bmcvK2RKUkhhTXVKVzR0?=
 =?utf-8?B?ZkFMMWlza2xEV3pwMkI2TThkRjk5QklpRHloWTJXUmx6YytWREdhYlNHajN4?=
 =?utf-8?B?MzVaWTIxbVk2cXNrTWxqa1ozM2lXQjRRT0lVdkpMbFhDWnI2MGJVV2Zjam5u?=
 =?utf-8?B?OUdHUFRMbDUwa2dKRzZXSS9BZjJodUcwU0dRaDFPck1scDdkd3pabzArRVEx?=
 =?utf-8?B?V1RKbXo2UXZSa25ETWRHM2hxMUxyczNiRHBRKzMwZ1lIM3N3eDVQVm1aR1pO?=
 =?utf-8?B?WUYxWmdrb0dLdjFuTGZSQkhpRlJWUzRWYm83eUh3UG9Ja1lidDV0U25ycjlB?=
 =?utf-8?B?R01pMjVYbGp6bFZvNndJcGxRTmhqZEovQnhwaWtoSXlQTE9FLy9BRjY2MmtP?=
 =?utf-8?B?ZGp5cGxVdThSMmRUTkxjS2V6cTZ2TFVDM08wQ2plRml1VEFCYVFTdUxhZTdn?=
 =?utf-8?B?OVRDOUhxUWh4WFpvdHdVdnN0cDF3MGNiT1VwNVFWYy93QUxGa1pxVmIra20z?=
 =?utf-8?B?em1FN29YMUNMMkVKTmQzT0xkc1oyeHhab1p5c05wenl4RDBGQUZUbmZrdkFo?=
 =?utf-8?B?RGVTTzFMVndFZVNOeDcyKzUxQVZLeVFBNnZTNDBsbGFQZXZaN1RtemdzM3o2?=
 =?utf-8?B?WlY1NHRVV3g5cEJmR2h1NCthSTc3Z3FJY1FVWERzSzMrOFZOVGVqVmtLeVJ5?=
 =?utf-8?B?WnVndm1BWVV2YU90dy9jUzNweGJURnFwMDdBbVdsMnRJRVlGdXA1WXIrNGhM?=
 =?utf-8?B?ay9YREk2NGRWU0VjaTJoMEZoV0lwSFU5N2lMZTJqRE5lRDlwM1hXbjRVaFhH?=
 =?utf-8?B?K3VTTFhEUDJHNm5ndjhUUWVpQ04va3hyMHB4TTZrTTY4b1RLOWhpUU4xZTly?=
 =?utf-8?B?di9raWFpcjVhNkx5R0dvN3h0SEprOVNvbndPN1d6L3ZIQURsU0EzUTVMTHFN?=
 =?utf-8?B?Q1lMYWtaYnBVcVFTV1J5MXZHbjc0QWhndmd5bnpBQTJKV29pRlJkRTY1bHI1?=
 =?utf-8?B?WitETXVMemZOajJlOEZPcnM1cTNweFFQeG9oZ3hxbVNYRWZjU3dUYTdvd2ls?=
 =?utf-8?B?QU1zYmk2Q3dYb2w3UW8wajlQR1BRb1c2NkJnMHRubXB1UEJaS1UrbldpbWFu?=
 =?utf-8?B?L1JnL0ZtZkRVYzJqaDVTN2J6blRBK1ExYTVZNldidWNNV1dNOHlXZTNwVXFa?=
 =?utf-8?B?Tks3ZEFMQ2xJU2tjU3RuVGp6RFROTTNXaWRwVzdtTHlUeDdhalVWeWc4aEls?=
 =?utf-8?B?a1FMVVQ2WERFUmNwb29RYlMvVkZTOTJYOGE5elpPbUV4Vm1LOVpabENnRk1O?=
 =?utf-8?B?M1pmZVRjVEw2b0dRWDVpZWJBSnJhc2ZLUFJGVjBkR1JEckZYN0NGdWtSUytK?=
 =?utf-8?B?SmRQL0dSTmcrRWRzdHdhNWlSWS9SRU1vS3E2MDRpSXZXaDlxdzhLVXcxaStD?=
 =?utf-8?B?MDFibERXTUR6MzRrV005cDcvVEc3QlUwZFgzTWIwUkJWT2FJaXVaSmp0aHZy?=
 =?utf-8?B?Q1JTT3BNNUZQUzQ2bjc5RTNEZ0RCa0IwY0pNY0svMDdqT3ZTNnYvTHpIc0dC?=
 =?utf-8?B?NkF2Znl1QjFxSkt5cnFJSDZ0Vk5LSStvQnBTK3JjVHljR1dHNzVUYjRPaEhW?=
 =?utf-8?B?UEVBNjF2cjBUYmhpbkJxNHk3TE5sTFRIVkVGQmtFMms4VFpBdy9jWDZDQS9y?=
 =?utf-8?B?MTd0MG5KeVo1d0Ywb3Y1ZndrbVBabWJ6ZEk5NnUrcStOR25LdWxjVW92Z0Iz?=
 =?utf-8?Q?7ONwqDrwzpFBug2w=3D?=
X-Exchange-RoutingPolicyChecked: X4nYsBNYWyvN4NSnPQA2UTPoQ702BkICtWYwqUqg3kCs/s3bW78E//Ctfh29d6OugDQ9mT8vxfpu0EMu8Y7B1WlrUCoQ0PE/YbAFvU5dCoZaoli5mB5yP9k5xtAK/oTQYQOcYVv4DShZMDJlodTMAsi8w5H+v3ygQbYYPIH1Ew60DR+CvUGPSYe32fNiNPO6Du0Q0tUY6m+E5/YsxAZxFxOMs9DoGIcIDiMbhdllyEw01pqfRCq5pdrCwKCx/NBgTAdyNgkAbpxC5jRhvtf/k5uUET4bfT/cnBu86a4ViDfLZi48z/XMGg8i3IjYYmUWRJZHrxwoeYAw0HyNm70/KA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d7d620-aacb-4aed-5398-08df297b7eb8
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:44:09.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bzJZ4mRllP6yZ2zeGu/5rhMgFj2QyYksb4ih4w5OVf3l5ta8kjBePWsO7I04zenYx15pykVxqyzFZsUD4CImtRJSy+TAtIrcl6g3Byofns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] This patch adds a sentence to the ice_ptp_process_tx_tstamp()
>   kernel-doc: "in the unusual case where the PHY continuously fails to…
> - [Low] The ice_ptp_maybe_trigger_tx_interrupt() kernel-doc still says
>   the function will "periodically check if the PHY has outstanding…
> 
> Pre-existing issues:
> - [Medium] ice_ptp_init() sets link_up from port_info under ps_lock but
>   sets ptp->state = ICE_PTP_READY only after dropping the lock.
> - [Low] Because the has_ready_bitmap gate is removed from
>   ice_ptp_maybe_trigger_tx_interrupt(), the periodic worker on non-LL…
> 
> --
> 
> ice: keep Tx timestamp slots tracked until completion or timeout
> 
> When the link goes down, outstanding Tx timestamp requests are no longer
> dropped. They are marked stale instead, new requests are rejected while
> the link is down, and a slot that is not ready yet is freed only after the
> two second timeout. The patch also changes ice_ptp_tx_tstamps_pending() so
> stale entries are ignored when deciding whether to re-arm the IRQ, and lets
> ice_ptp_maybe_trigger_tx_interrupt() run on devices that handle their own
> Tx interrupt.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 5220de274819a..a5ee8c8edf3d6 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> 
> [ ... ]
> 
>> @@ -554,7 +557,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
>>   * extremely unlikely that a packet will ever take this long to timestamp. If
>>   * we detect a Tx timestamp request that has waited for this long we assume
>>   * the packet will never be sent by hardware and discard it without reading
>> - * the timestamp register.
>> + * the timestamp register. Note that in the unusual case where the PHY
>> + * continuously fails to clear the ready bitmap index, the slot may remained
>> + * locked for more than two seconds.
>>   */
>>  static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  {
> 
> [Severity: Low]
> Does this new comment describe what the code does at this commit?
> 

This is likely correct after the whole series and a rebase error made it
squash into the wrong change. I'll try to fix that.

> In ice_ptp_process_tx_tstamp(), nothing re-reads the PHY ready bitmap
> after ice_read_phy_tstamp() and before the slot is released:
> 
> 	err = ice_read_phy_tstamp(hw, tx->block, phy_idx, &raw_tstamp);
> 	if (err && !drop_ts)
> 		continue;
> 	...
> skip_ts_read:
> 	...
> 	clear_bit(idx, tx->in_use);
> 
> Suppose the PHY does not clear the ready bit, for example for an entry
> with VALID clear that was captured while P_REG_TX_OR=0. Then the index is
> freed and the skb released, which leaves a set ready bit with no in_use
> owner. The slot does not stay locked.
> 
> At this commit ice_ptp_tx_tstamps_pending(pf, true) still falls back to
> the hardware check:
> 
> 	/* Check hardware indicator */
> 	ret = ice_check_phy_tx_tstamp_ready(hw);
> 
> That would re-arm PFINT_OICR_TSYN_TX for a bit the processing loop never
> visits.
> 
> A later patch in this series, "ice: don't clear in_use until HW clears
> ready bitmap", adds the "verify ready bit cleared" re-read. That re-read
> keeps the index in_use and marks it stale. The same patch also removes the
> hardware fallback from ice_ptp_tx_tstamps_pending(). After the full series
> the comment matches the code.
> 
> Could this comment move into that later patch so each commit is consistent
> on its own?
> 
> [ ... ]
> 
>> @@ -1426,6 +1428,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  
>>  	WRITE_ONCE(ptp_port->link_up, linkup);
>>  
>> +	if (!linkup)
>> +		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
>> +
>>  	/* Skip HW writes if reset is in progress */
>>  	if (pf->hw.reset_ongoing)
>>  		goto out_unlock;
> 
> [Severity: Medium]
> This is a pre-existing issue and this patch did not introduce it. This
> patch does make link_up more important, though.
> 
> ice_ptp_init() seeds link_up while holding ps_lock, but it publishes
> ICE_PTP_READY only after dropping the lock:
> 
> ice_ptp_init() {
>     ...
> 	mutex_lock(&pf->adapter->ps_lock);
> 	if (pf->hw.port_info)
> 		WRITE_ONCE(ptp->port.link_up, ...);
> 	ice_ptp_port_phy_restart(&ptp->port);
> 	mutex_unlock(&pf->adapter->ps_lock);
> 	ice_ptp_cfg_tx_interrupt(pf);
> 	ptp->state = ICE_PTP_READY;
>     ...
> }
> 
> ice_ptp_link_change() checks the state without holding the lock:
> 
> 	if (pf->ptp.state != ICE_PTP_READY)
> 		return;
> 
> ice_init() starts the service timer, and the netdev is registered before
> ice_init_features()->ice_ptp_init() runs, so link events can arrive during
> this window. Any link event in that window is dropped.
> 
> With this patch, ice_ptp_is_tx_tracker_up() and the link-down stale marking
> both depend on link_up. A stale link_up=false now means every new request
> is rejected until the next link flap. The race itself came from the
> earlier commit "ice: call PTP link change only from link events".
> 
> Should ptp->state be set while ps_lock is held, or should link_up be
> re-seeded after the state becomes ICE_PTP_READY?
> 

I'm still trying to figure out how best to address that sequencing.
Perhaps it makes sense to re-check firmware and handle link state after
we set ICE_PTP_READY.

> [ ... ]
> 
>> @@ -2984,19 +2990,16 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
>>  {
>>  	struct device *dev = ice_pf_to_dev(pf);
>>  	struct ice_hw *hw = &pf->hw;
>> -	int ret;
>>  
>> -	if (!pf->ptp.port.tx.has_ready_bitmap)
>> +	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
>> +	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
>>  		return;
>>  
> 
> [Severity: Low]
> This is a pre-existing issue and was not introduced by this patch. It is
> a kernel-doc wording problem.
> 
> With the has_ready_bitmap gate gone, the periodic worker on non-LL E810
> now reaches ice_check_phy_tx_tstamp_ready_e810(). At this commit it gets
> there through ice_ptp_tx_tstamps_pending(). Later in the series it calls
> it directly. The kernel-doc of that helper says it "should not be called
> for E810 hardware", but the body is only:
> 

I'll try to clean up the kdoc here.

> static int ice_check_phy_tx_tstamp_ready_e810(struct ice_hw *hw)
> {
> 	return 0;
> }
> 
> ice_misc_intr_thread_fn() already reached it on E810 before this patch,
> so nothing changes at runtime.
> 
> Should that kernel-doc be updated, now that this is a regular call path?
> 
>> -	if (!ice_pf_src_tmr_owned(pf))
>> +	if (pf->ptp.tx_interrupt_mode != ICE_PTP_TX_INTERRUPT_SELF &&
>> +	    !ice_pf_src_tmr_owned(pf))
>>  		return;
>>  
>> -	ret = ice_check_phy_tx_tstamp_ready(hw);
>> -	if (ret < 0) {
>> -		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
>> -			ret);
>> -	} else if (ret) {
>> +	if (ice_ptp_tx_tstamps_pending(pf, false)) {
>>  		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
>>  
>>  		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> 
> [Severity: Low]
> Should the kernel-doc of ice_ptp_maybe_trigger_tx_interrupt() be updated
> to match the new trigger condition? It still says:
> 
>  * To avoid getting permanently stuck, periodically check if the PHY has
>  * outstanding timestamp data. If so, trigger an interrupt from software to
>  * process this data.
> 
> With in_irq=false, ice_port_has_timestamps() returns:
> 
> 	return !bitmap_empty(tx->in_use, tx->len);
> 
> That is true for any outstanding software request, including stale
> requests and requests the PHY has not captured yet. So the interrupt now
> fires on every 500 msec tick even when the PHY has no data. The commit
> message describes this ("one extra IRQ every 500 msec until the timeout"),
> but the function comment was not updated.
> 
> At the end of the series the condition is
> "ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)" and the comment text is
> the same, so the mismatch remains.
> 

I'll try to reword this.

