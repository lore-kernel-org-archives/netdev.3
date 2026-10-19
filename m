Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792453807;
	b=1Nzd8R4uDIF6AbW+t84fwOATdWBKY9y1BOlI7WGZGHUb0oPvMcYDEPSSL7d+H+YZwr2+
	 WnruTiEVirdLMtZCduUZtNRmjokyEoqhvse/7/kuKpgvYhU6b6+VbfDvPVez5xLdCCMj3
	 l7+xwiIalaQB7b5hOV02V4daS35XaEeJupU03bor08AnGNLzl0qK2TwgKqphcY3OmuuOI
	 Syk9WTu5SHq5oXInVnoCv9NDyYOy4QgZDvSiRG6PIDyYISq3XQYaGU6rH6irCdFHFKNNt
	 o172Sr1EeEFGtnLDLII5HmJRc+FgEBHPu1/h6JuQZL3W5Ta49ZR5g8ENR7u/RFPQZ4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453807;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=Rg6yom2EHHEiNTix4AXarhh0oOMxqC9nDzZUetPasEI=;
	b=GNTsSVZB5j/ATvvtrv1WaZk3FDSM98RClWLe/TtnOD00wH+NsK5IPx//0oAymgfj58mI
	 8zJzyp3ttk7W/MiCZ4o2ct47TJaYcODHaJubJ9qlDiqentxWxam03hSYQPrQAFqgm7Tau
	 pSMtlTXYSb/iwuXyPvD1OiidFaZ32EqxPibi/zokFUrAFDS7HAP72bmKghF8gi2nQRaSm
	 QReY238qc6gtG7UJyIsDM0eoqcWc+RHyZPV8OmEYgWhM1GpQkifCRHvj/xJv+EybN96o2
	 hVmiD8Em52k0mgsTA8gviLtxWo/YDRrpxQmOG7VPQGfTsV3RgPmFV98BHUPboUDJhxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WEtQXoHy;
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE055606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE055606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WEtQXoHy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792453806; x=1823989806;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DplL8rNzrDP24s+Q0QYuxTz9DQCcRpbN2tArjuzkVx4=;
  b=WEtQXoHyr00/JDsgB9x+M43+wQcjnCLOFTV53LvnopjFRhxhP8FYNewY
   YoQxvajxcNBETtgyveo3Jn+pDm+/jsqbocaVqfViDyuBzB7xrbyS2BRIW
   gW1GSUH7OUR+qlwKCSnE3V5abvzyb70IepHAVL1EQOKoEker1inZAN2hW
   prlVgESHP3y2XZ4nWbz8qxp5D/DALrpxvyXeHg7VkSbJ3AhoTLiySStMi
   dkUCPU5ZdloFHNS2Yb3lX6hrhzsN0LhTiGrO9VHOyDTppMyJ7MUaSd9Vx
   IJv66JQ8WVkkyIuTj3JagJ+o3Z3vX9fSEsTPJZXEimXaaCOOLJTqTMLT5
   A==;
X-CSE-ConnectionGUID: +B72T81+RAeu9W+tnPHnPA==
X-CSE-MsgGUID: uGKCTEPMRtKSbco3L2SXzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1053080"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1053080"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:50:05 -0700
X-CSE-ConnectionGUID: 4JwTc2OET0aFFoHh1KEwCg==
X-CSE-MsgGUID: v3w4uycCQ7u+KKl8cL4mDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3071182"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 16:50:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:50:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 16:50:04 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 16:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2dQlU8eDLVq2G4uZpyJuJbvWZWOv6zF7rYMYLqKn51L8PNoJeoiaD0LMvF+DKpFwpz3on9ZHpn1sLEuQ1VTtUtt+6Q/Guf5enm+KvBzR7ZGGBPxRNnv4UGiLjYWzF43AIqfHmw6/RMdPZnXfBe43yUSOLTNJ05P57wtutGIozy9vXba+vMYp5KmQCuSm6B1X48Eh5UPNA0Qg1xCASYsbHr/osGC3R+dhRotsN7iQFp6Uj4Q2wYaS13BIRW47tJlXwCVdnwm2G2xV5Uf1qa+OsnkeV7jEmY2EF68ixyKn2Bf7i7yl0wfZ3ly6w4tyWNh46X7aNxvZz1T3SvS74wVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg6yom2EHHEiNTix4AXarhh0oOMxqC9nDzZUetPasEI=;
 b=nXr/25e3gMAmq0gS1yfn3KR0q7ReAHK2Z6xucCmtokfTJfeW8895X0aySBxen2YtfQGkmL6pqdnevK10ZWVDKyveKld9HXSPfoW/Xo5opD5yEepBv0sv5vHFXn3ugwmJojvmA8DcQ3Ri/TbeaYa1TkEDe2ddfdT7BFPTtM7Jv7RviXGJxI0V0WiIIvSAJyZak/aTiD+9D+HO8gY97mTU8eLuUjG5GEgFJWRqUXhAHWyBbFbX+5y/Wo5alW13RyRoBgmu31giAg3QirmvA/2BoAVKssUpE+UXw6XNDVGr2K1OBTnk0r9HhY0ML/yL82uIfMeN0Wby8dHZdQWOs/pVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7364.namprd11.prod.outlook.com (2603:10b6:930:87::14)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 23:49:59 +0000
Received: from CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3]) by CY8PR11MB7364.namprd11.prod.outlook.com
 ([fe80::1b92:4856:eb86:f7e3%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 23:49:59 +0000
Message-ID: <5e3e381a-b499-4654-817f-e8a46a2e43df@intel.com>
Date: Mon, 19 Oct 2026 16:49:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 09/14] ice: E825: clear PHY_TSTAMP memory prior to
 soft reset
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<poros@redhat.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <grzegorz.nitka@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261015191102.1174111-10-anthony.l.nguyen@intel.com>
 <179244085178.3135.3380160340565302392@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179244085178.3135.3380160340565302392@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0372.namprd04.prod.outlook.com
 (2603:10b6:303:81::17) To CY8PR11MB7364.namprd11.prod.outlook.com
 (2603:10b6:930:87::14)
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7364:EE_|MN6PR11MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c82ebc-0ca4-4c76-da92-08df2e3baf47
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|4143699003|11063799006|5023799004|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dvXEhpPydVqByK7sjSHPPVTMpRuCKR6v8klmQAHDAv4Q0Nd40VpU4VJB8MK6Ylqq3w/wnEaq+hUZ2bAAdlTNjG/c+UtQhlFiMC4FIGPeB+0XXyMofIO3BD9YMcWDnFVo2WsO2X1GW7BzTBI71CXa1E4842BpLQthsOI1NifA2bXJBuGn5JDC2gN1TpGd3ochCAKEX0QVhco6DISASg/bzREQzeY3eQWppf7+HoeGI2BAVvbEyJJqdCO/utSHVEtdJ/yY/0wyultNddsZl89vUY+vzLvxCFsO7PbgA1BFzLlmc09RSlRreGffGprhJ1FBCWkzT7TXiRpceomiyjKJeVfpN8LpLoq1L4My4fPMwfsnB+2yGzuW51z3lG+1KOt7K/fmQAlnwTtuWiiEjEDvXEfwOLmkRs/Pj1MKdjXKTzZMaJFGy0/EIqoNfJDjARbdO8p6mVoRMjye3kLiUr6X1QQ6U5gzO0A52oDaixn8OncTT2ANO1m4bHNGFpoVXieHkL8naF4ZdTIjdpRchJ57wBnmAOMjoiS8BRdKiva15fKT1Dram4FEQ/lUz5WVJWw61cEGRjXaBKJIB6kh2StPjDOYiLmspg4OQVeB5YJq2nO57+sB8cR2IUDHlzlXDgp1TTVdBft/6O+sMGi9MLOMsjc7oCm+16wHYPEvgTnJyNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7364.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(4143699003)(11063799006)(5023799004)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnJaYWJCWDZXajBXMEE0T2JBUFNWNFQ1Y2x3dTVFeXYzWUlCOENhRFlaMlZN?=
 =?utf-8?B?ZE4xR2ZkWElmVU5TWEJEdGlJZGdDVWZtYVJlTU0veHlkS0U5bkNEMEUwQW9p?=
 =?utf-8?B?ekNvSGxsZ0M0d2Q0Q2FoOGx1dVU2KzN4ZEdyUXNSTG9wTE1pYkdUS3RuanVG?=
 =?utf-8?B?bEx0WWxHVjY3QnFsakZiZHFxbVdYYm80c29uLzhOcUtuRjE4YVZ5RjJjd1Q4?=
 =?utf-8?B?Y1VKL21zSVRVL1JYS2pMSEhaSzN4bVRPOGVzUVh2TGxieHgxYzVDMzJndS9T?=
 =?utf-8?B?blh6Z0kwS2dxbEFSVzBqbDMycy82aldOcXBaMW9ycDdBMUdESXFaM2Y1L2I2?=
 =?utf-8?B?cFJrM1RDYzR0cTY0VEhhK05qeVFVOW56SHNtSkFLd0ZCQnl0VG5MMzVwUE9P?=
 =?utf-8?B?NEtrZGtMZFl2Q3lwR3kzZnkzZEFZUFE3TEdoc2ZwYTdyUmpJeXFHWlprUmkv?=
 =?utf-8?B?OGVhZnAxLzc4ODh3ZTFqY1M3RjZka2ZTUGlHcE0zMFRrbnJhWHFvV0pqcnRv?=
 =?utf-8?B?WmV5UHZhZE1jT3RsM042alhUSlhLeXZLd1hybVAwYyttaW5wc3J6NzhCZVF4?=
 =?utf-8?B?Q21IeDNKeU81ZjAwU1JOek16dGVuWG9SaTdMbEtBcHRoUjhlWmZsaEQ3cXBu?=
 =?utf-8?B?d3BOUUhMZHdKTHBCL0ZVbysyeHJmd1dWa0lsZkx4a0FhcUN4bTNIYkdoL25r?=
 =?utf-8?B?ZHFPOWV6SVUvSzVaQlBqOWc0U0FHdnJ3MUxjSmJLWVFQZnBDMkZDbTlZMjli?=
 =?utf-8?B?ZnMvVzJzd0FpYkd1ZVF3bUhkSzRUVjJrMUVCdTZOOXNxMEk2S056Q0dTWFdt?=
 =?utf-8?B?WnVvYnY2aEpUQWtZNWxNRjhJK3pzOWd0UlNjQ3B4VjFDTS9iMWx6VkxySGVX?=
 =?utf-8?B?a2h6MUFJcWVCdnFRUUpwbEJkaUNIZTN1WHQrMnFrZTArNTl6WlZxeDVKTUEz?=
 =?utf-8?B?L2RHMitZejhOK2pHc3M5dnF0Yk52bFViNlE3UVU2cTlHK1hFYWVnOWp0Zmc5?=
 =?utf-8?B?YlJ6NHJLeldCc2RoQW81Y0FiM2cvVTZxK2VLMkNRcDV3NnhINm95WGxpU1Z3?=
 =?utf-8?B?ZWdkRStoMk8vcXVUOXI1VHVVNURqbjhKY0dWMWk5UFI3cHcwMWVpOUdCK1Z3?=
 =?utf-8?B?MTg4anlvZVhkVHBpeUZQODUrMkVOcDRKZ3paREh1Z1FNdkl3ZFF5cmJ5WnBJ?=
 =?utf-8?B?Z2IrSlhTRG5IYjJGZ3cwWUEycDd6Q05wMThteGVuWnF3TE1kWXk2WVFqRUdK?=
 =?utf-8?B?di9pR3djQS8zTUVkN3MzK1ZDWHR6Nzl0czZCbStsU2VtVUxiTXovZWpmbDBi?=
 =?utf-8?B?aklkTFJJSCsyMEtMa002ODErRXlSUXV6YmZmaGZMOW5nRE9BSm9WTHMrZTRq?=
 =?utf-8?B?QnQzajVLdGhxZ1JpcjVtRFFoVE1RZTVrUEh5TUtWYzVmalZ3QzVDQnVvVUgv?=
 =?utf-8?B?dEIwQk12SnlDQWp0TVNnZGdkWmFRWFRIanNoQ0d1Mmx6ZitaTzIrMFJhTUFu?=
 =?utf-8?B?MGdmNWpBSnZ1dlVadThrQlVlLzNkMURPOHBNY1l0Qkp0R0tubUh2WnpndlJW?=
 =?utf-8?B?bXlrcWlDdnMxdERRYWdUS2MvVm5JRDBZRXQrT3BwcE5nUzA3bFFTcHdTNDBT?=
 =?utf-8?B?cm5NTWk4MUFpNXhwdlN5Nm5ROEM1TUNEc2h1TDVuaGR4SEJtYlN6ZWJjdHhj?=
 =?utf-8?B?T3NUQ1BsUGhyRG91bDNKTGFlM0ZSYUJCTXdVR1ZDU3VHOUFsZC9WZE5mOUt2?=
 =?utf-8?B?bFhoQmFjZlBZeGtrY2NFUVg0bGZIUlQyVk1ROS9XS2xNbDgvNm5TUFVjelpZ?=
 =?utf-8?B?TUU4VEE1WHI2MmZXWURrbFc0R2haTWJjU2xHRVhZc0s4VEExWHBpOXdENHQw?=
 =?utf-8?B?R2VpQkMyUVg3djhzTkRnRjZ5NnpSRDVKUnJVVmtLcUwzVi9pT2N4TzFtNzNu?=
 =?utf-8?B?NUlwVU5JSVRvc2orVXpDL2pBZURxRk8wbW5VY21Ud1ZqcExRQW5wdmo1QmV2?=
 =?utf-8?B?c3B2cHRXRXBibjJZa0xNYTBMbzVLdEwrSWtSVDQxck9McUIrRkVjL2p2UlNo?=
 =?utf-8?B?T3Byd1dEU1VKWnN5VXd2OFBWc1BSTG5tcHdnaDU4Q1RIZlJJY3JtaUFiMUkr?=
 =?utf-8?B?dWtkZTc0cVpya05QTCtZKytOditZNWN5ZExZYkxtbEhHS0NjcWFuNzVMRExJ?=
 =?utf-8?B?N1VEdzV1dTFpbit3MkVKODV3OGR0bm9QcCthSnAvSTYwcGJPa05BTWFZUVRX?=
 =?utf-8?B?ZDJsK0NnQzB4MmkrREUrUWN2MWo4V3JxOGtkVzFvcFRJS1NidXV4OEtNanpI?=
 =?utf-8?B?eWdhbklwOHlOek9WaU91QmEydHpzSnhEdDB2VjZIblFzN0l1T1M4dz09?=
X-Exchange-RoutingPolicyChecked: qcry8/LUIRwUG9R538rG1Sc+rQpQGkhkGW9RovuXRCNGAgrlx5c0Dec1xGG2PriiwAwrPC+MIt+wTlHy0aBX7/gNco6sF/56Dv1ytZdR4HxCuiSxZC8vKFGAOhqxFaIc+oEhRDq4vksXceLBlwg0D+RhDEQab6/Cwxf2r2eiCmgUVjweTvp7uwOzdwjnCf5e5sxHuU8I7zWu3rr/CSE3IJjSgs35oupfoNWaaXb5XUThOc3yLB0FFn+VGOJfXELhLc+/93ESWD7DR9le66URFEDyHnyo7noSmm3WT+SEVbAHYPFty8aEsY2ODutptxaTwA7s56MIdvZjYgWhvafZKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c82ebc-0ca4-4c76-da92-08df2e3baf47
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7364.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 23:49:59.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQkUwE08lVdJMt7/uv0jchvAoi1hDufMn2QAw4qZL2kmreDIhIQi8e3/uSuIzAUNAcz5Ro/msqey1/H4PED9VxWVfCAj0yaQmXc0TUvpRsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com

On 10/19/2026 1:14 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] In ice_ptp_phy_soft_reset_eth56g()
>   (drivers/net/ethernet/intel/ice/ice_ptp_hw.c), the patch puts the read…
> - [Low] The concern is that the kernel-doc of ice_ptp_reset_ts_memory()
>   ('Reset timestamp memory for all blocks') no longer matches the code,…
> 
> --
> 
> ice: E825: clear PHY_TSTAMP memory prior to soft reset
> 
> This patch replaces the E825 timestamp memory reset, which wrote
> PHY_REG_TX_MEMORY_STATUS and had no effect, with a sweep that reads every
> PHY_TSTAMP index on the port. The sweep now runs at the start of
> ice_ptp_phy_soft_reset_eth56g(), so the soft reset that follows resets the
> internal counter. ice_ptp_reset_ts_memory() no longer does anything for
> E825.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 07b55fbb88dde..38d0ded1d0cc0 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -2311,6 +2312,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>>  	u32 global_val;
>>  	int err;
>>  
>> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>> +
>>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>>  	if (err) {
>>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
> 
> [Severity: Low]
> The sweep runs before any of the PHY_REG_GLOBAL accesses that can fail.
> What happens to the internal counter if one of those later steps fails?
> 
> ice_ptp_clear_tx_memory_status_eth56g() returns void and always reads
> every index. After it runs, ice_ptp_phy_soft_reset_eth56g() can still
> return early. That can happen at the PHY_REG_GLOBAL read or at any of the
> three PHY_REG_GLOBAL writes:
> 
> 	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
> 	if (err) {
> 		...
> 		return err;
> 	}
> 	...
> 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
> 	if (err) {
> 		...
> 		return err;
> 	}
> 
> The commit message says reading a garbage entry after a cold power-on can
> underflow the counter, and only the soft reset sets it back to zero. If
> the reset pulse is never issued, or only partly issued, is the port then
> left in the state that the new kernel-doc of
> ice_ptp_clear_tx_memory_status_eth56g() warns about?
> 
>     this *must* only be called as part of the
>     ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal
>     counter may become out of sync and prevent new timestamp interrupts.
> 
> ice_ptp_init_phc_e825c() then stops at the first port that fails:
> 
> 	for (int port = 0; port < hw->ptp.num_lports; port++) {
> 		err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> 		if (err) {
> 			...
> 			return err;
> 		}
> 	}
> 
> That port stays swept but not reset, and ice_ptp_init_owner() and
> ice_ptp_rebuild_owner() only return the error. Before this patch, a failed
> soft reset could not cause this desync, because nothing destructive ran
> before it.
> 
> Later in the series, ice_start_phy_timer_eth56g() also calls
> ice_ptp_phy_soft_reset_eth56g() every time the PHY timer starts, so this
> path runs more often.
> 
> Could the PHY_REG_GLOBAL read be done before the sweep? Alternatively,
> could the reset be completed or retried once the sweep has run?
> 

We can't really do the PHY_REG_GLOBAL before the sweep. The sweep could
screw up the counter and we need to do the soft reset in order to fix
any issues the sweep causes. I'm not sure the sweep would do anything if
we did it while the soft reset is in progress either.

In practice, we do not really expect the soft resets to fail at all,
transient sideband failure isnt something we observe in practice, nor do
I believe it is worth effort to try and harden against such failures
when they likely indicate something catastrophic about the device or system.

This really is just part of the fact that register access is indirect
and "technically" the access can fail. But in practice it should not
fail and I don't believe it makes a lot of sense to add a ton of complex
logic to handle such cases.

We already propagate the error up to the PHY restart and log a dev_err
message indicating that the restart failed, and that the user should try
a link reset.

I think thats good enough.

> [ ... ]
> 
>> @@ -5802,8 +5805,9 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw)
>>  		ice_ptp_reset_ts_memory_e82x(hw);
>>  		break;
>>  	case ICE_MAC_GENERIC_3K_E825:
>> -		ice_ptp_reset_ts_memory_eth56g(hw);
>> -		break;
>> +		/* E825 hardware must only reset timestamp memory as part of
>> +		 * the soft reset procedure.
>> +		 */
>>  	case ICE_MAC_E810:
>>  	default:
>>  		return;
> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc for ice_ptp_reset_ts_memory() still
> reads:
> 
>  * ice_ptp_reset_ts_memory - Reset timestamp memory for all blocks
> 
> E825 is now a no-op here, like the E810 and default (E830) branches. The
> only explanation is the inline comment.
> 
> Could the kernel-doc list which MAC types are skipped? It could also say
> that E825 clears its memory through ice_ptp_phy_soft_reset_eth56g()
> instead.
> 
> This doesn't change how ice_ptp_cfg_phy_interrupt() behaves. Both
> ice_ptp_init_owner() and ice_ptp_rebuild_owner() call ice_ptp_init_phc()
> before it.
> 

I can try to clean this up.

