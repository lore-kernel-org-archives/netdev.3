Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793052470;
	b=jrSJae6jQY0qxnz8A1+1WMrgUG022BJYD2x6MOWsdHO7sA/tRmzBLi+eslzGoSISnwA1
	 cGoQe9MGcjW80Tnch8O/K8LtFAio0ux6qGrChJ6p2gBx0KnaEoNQkwmi6Ey2/rdpHfKxL
	 fcXB29znHn+Y5UFmCZ7kRsLveizm2pOihla/CvWbmbh3A+i9L3aXlcIe/3DALYKWmJpvM
	 wDiJicBbposJlio3N07iEYBOx2bRCXtnjS/Nkoo4toKMEOuc75O1c08fQr33BeYmL/umB
	 LGlRILoPC02j6psZtsGQkhAGMzav9nzS/pOlh0yEfNCTlXfBDFQR8qU3JxNslZCtI7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052470;
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
	bh=QrQFd/RP+3DAG/O0D0yXgL7JPW6Fg42jEopdpP10Gxs=;
	b=v7zNS5+3f+ExXT4BnskWF3buRfX9DMXKUQtqakP7fUaU8Y8KOSkoXrsQ9CDAMua/q/Se
	 3YAI8TpfySGSgMU/DO1R4icDdNE/ew8hQj31vlOf/jQTxQfvOZZR+2HO2RcFqlaxjcbdE
	 /lSsaPwDpowf9A+6+oqD54ujyrbvc0AsgWGosELPB88dmQqp1fq7EKtryBvQ7WcHT3hul
	 BEt0oaFoEU6TcAiR21mSFoV3EZZKWG2/uj1x6uIIrH58jxcAPMxjqcwmfx1Qft+2ovFoD
	 LOuVvSoVmyyvAha1lkanX2icg+5OORU2uHZKr+MhCBD5hIOYbE8q8V7bqrHxKKiah/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E2FcuB0h;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF044606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF044606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E2FcuB0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793052470; x=1824588470;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NTHmzPEGOCaDsy7F5Sx4q3quubrK+9yLn8SEMLS/OB0=;
  b=E2FcuB0hXxNU/6QljBC/UOtCppuVMrXGrqj5J1+kpuEN7+ed00mui2XI
   fjBGxLRKslFjRWuTUD7UnPD5ynIYJ389UyifV59uoAyD+qHPDM3Je6JRR
   QUMlZcgjvcW6RXWbzsPhHzDxdWe8eLvkyebynfunjD2endI22+iwRVleG
   pPVu24An3Mm4rGLSgeueQBaDoJGf0NeZ6mlOVIqfjV/8nb7c46lNhwkyk
   VaF0k57ReRcMLJYLK7mc3vqBKIvm6FZHs2xVDjlLshvkJDICLZHno99pu
   925r4u0t/ZjpSQb4E4GRwDCSvRiDTkFSiLCjcDRXZfxQlCdywPW5bh2xf
   w==;
X-CSE-ConnectionGUID: jwpWQqMqT9Sdmqr1ZkrPrA==
X-CSE-MsgGUID: +t5xeRpGThy3LWhAW60C7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1747650"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1747650"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:07:46 -0700
X-CSE-ConnectionGUID: xJw1J4U+T2Simxd8Xc0Zww==
X-CSE-MsgGUID: TwxQsmIJRMmBBF/YZVPsGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6212121"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 15:07:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:07:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 15:07:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 15:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBO/zJA2YnqpP6W4bzHrbLtu6dcgpbTqur/wCbKoBg3WjsHNHi+fk360vWPkMjkeRGSYUKK+X9KUJ/mnms2wLAgV2ujciPbBGY3fQ8hP9QpVwsG3j0SJkXlfz70xxfQt7UQ4CAhHhjKJX71PzcV+skMqgRr2MmwxzjAvGe5UTERJoWRZcSuAw7ZTSYxNrb5MC4lz7+Rv2WfFLsaFqZSq0Pv1xamZbP6Et5dGkmuwwDVl48a/5DLdWKKrS3VOufxk3OylqgPXI7Q0hF+EgAKTaR7j2g0lAS4XoPGy5ixAW2eeEA/gntNUvGXo+AEdC7WtfbFvWwuvnWaOvOu9leW27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrQFd/RP+3DAG/O0D0yXgL7JPW6Fg42jEopdpP10Gxs=;
 b=l4CLJq8NKW81SDU5Y3lrbzSjKuybCghDJ1ujqbDmY/Kjxn792XaHYFTMszA1gHEcPsXvgNbBthHtL4b+6I6F/M/L81knxRIqRljj1zTbqEyZRtUI0Sv4xVq2ZHDF8mceloA1bE3B6bOkzapz3QiJa4jH82+RZf8JxhsP2J5+NWsj1e9gGppTylR27gDkz/L1Rqx2Ada6IDteW4rXd1ouPZnGO+0z5AmCKqIDYaoehAEzwMW1AzNZSZfv5BTRSCmyyRQ/3h00+M9EeDHZLL6htV/VrSkp4RdhC0WW6+CdwlIMkUy8zaPHIMnHGS7woTdxqsJZaXCGj0uDJxtTiENeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 22:07:26 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 22:07:25 +0000
Message-ID: <d7f44b95-a6f0-451a-968e-b9282626bc7a@intel.com>
Date: Mon, 26 Oct 2026 15:07:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 13/13] ice: don't clear in_use until HW clears
 ready bitmap
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-13-72289a4ac8eb@intel.com>
 <179297184695.3134.4758101348262867336@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179297184695.3134.4758101348262867336@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0312.namprd04.prod.outlook.com
 (2603:10b6:303:82::17) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ede84a8-51fa-413e-69e6-08df33ad847f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|18002099003|261026140227099003|11063799006|5023799004|56012099006|4143699003|261021121427099003|10067099003|261009223027099003|261021123027099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 8tf+HTNiLGok1CeitXd+0WaYeC8U/4koOaMKJuFAChVmWmIccLM4A1wUnNazV8+p2cqtvDVdbjK2v7utUbhgrxpDT93hyld9cEIYICyZd1QeinurF5a30n/8OXkqxd65cbk7lM1dds6qDtjcj68PdULMZxLmJ7iljV0uR02u0Z8NdC7u4R0Ts7MKX+IfuFzIzJ1T6bmC9GHvUHD51tjE+nc7cbvOCDdPDSRWF3ibpCl77IKQVLTZC0OZouXkg2Ws7xsvl7gtWgChb1LnpLnulkyetrRX+iD0C7xtHwzY0SR8NYNdJcRt0VCokezLwgIre5EJk5I7+A+EvAU+PC03fU0oyVOejDm/0Ywh97LiOLBnDw+wrlYeXTdQfLaBwq/4qIWeV5msykp69w1TTRDvidDNXwg0uFILbYCjJHgSDJEdc1JHvyPvvFfKHcVEuEbAxu+W3XhQHTvq2VHQCdT0jjWxJGaPI/6F2RoHpyB9p8wsR1xA5ECUe7f5b7gSeM9QeS8BALz4mfsfrg/nw2V2ySiw7PJYEy3gI9iwx/FELTzt+W5Iwh+iGJqiLkPvcp26OLSKt3nA9AwmdPTVoJ3VvJl6ypv0H87PYY4qcHm80c0hkX3sPemHmTcsPZzG+qhDnB1AWYoPHBOBEhBVUIIFKwDEdE3n7n2eBAEr99S8f/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(261026140227099003)(11063799006)(5023799004)(56012099006)(4143699003)(261021121427099003)(10067099003)(261009223027099003)(261021123027099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFoUnZ3QmFGMjNNakdGYVJJakdMMmxMKzhzdHZDaEtjN1gyUS9YTmVBVDBM?=
 =?utf-8?B?VWNDRjZ0ZDE3U3Z2NFB1Wi9ROTRac2FtR05kZnYwZEZ6eUt1S0dFOERPWlpX?=
 =?utf-8?B?KzVuK3p5RE40SnplU09wYnp3YjZPZ3dSSmxRdXJuVXpEUnoxR0hpaXBsTEpO?=
 =?utf-8?B?UFoyNXJySU5TcmdSOC9aT3BBazkvdllWVm1nUlpSNjRCWVAxSGhuY2lYR3U5?=
 =?utf-8?B?blR1OG5qT09PazYxeFdwYmlGaFBOajBieHB0OTJCYTh4aTBpNFJjRnk1NDlV?=
 =?utf-8?B?Q2lVcHZoNG1LS2ZoUGtKaC9RSm0vdmcyc2x5b1NiSjl5ajRMeUFybllrN3k0?=
 =?utf-8?B?d2ZtbFhkcUJHNFhaVWhjZTBEL1k4RStLUHZDajZpNFFMMEU1NU9qVXR5eGtG?=
 =?utf-8?B?bGEvVGptVE1ObFR6MUJXL0FGUUkyRVpmcmZNL1N4WTlsa3d6YmFzS2RONFNk?=
 =?utf-8?B?WTBwSEp6cmlvaCtRQkUzS3QyMXhPa3lXcHh1Vit0d2RzNVJMR0luNmg1Ynl0?=
 =?utf-8?B?eXFWRU5PWDVaYXhLMzhQeGpPOUpVcVI0WCt1Q29xTk1kMnNCSXNOVVFxejE4?=
 =?utf-8?B?SHowempPMStiZVF4ekdOVmE5K3VoQVJKdURUQ0tCWnNzR1dubzN3V3BkTnkw?=
 =?utf-8?B?V2Z5K2phOWZubzR4VHRUMmtvc2pxQWdhQk16NHJVM2g5WkppUEZFQkhDZmtX?=
 =?utf-8?B?R0lUeFhqblB0UzVid2xIREZqb2FNTUxPVFRUbjgvMHd2aG12ZkhwZkVYWXVG?=
 =?utf-8?B?WUpMdytMd3kwWFc1T2xtVllJR09wcS95aDdyUUh4cUd3TEV6VzNsVURNd3R6?=
 =?utf-8?B?VWM3aTdXd0hqM0lKUzlPbWtteE1qUVRnNTdKTG00NG9xWGVSbjdVVmtxaVRv?=
 =?utf-8?B?Z09pZEc0UHAxaGx1Y2pHQWlWbnYzT0tSUWJRV3dvZk1pd2lYVEpBMmxRSkV6?=
 =?utf-8?B?ZEFGUUdTcDNVaEttMy93c1ZVUFJMUlppVlNQZ3JmQ0k5S05NTlhyVmR2aTVT?=
 =?utf-8?B?dm4yYWFmMHN1Rm5pamUwSXNCOStYcnRETGtteHRhRDk1LzNaeG5WSXVHUHhU?=
 =?utf-8?B?K3hRWURyN3BYTzhva1ppMnh5NnovdXgybWVVczRBbk10SFdLSHN5blVrK0Nw?=
 =?utf-8?B?K1hvWW5CdVpzUEtadXNXajRFTnhkQ0FHTW1pTnlsNUhMODkyNjc0OU91U0FS?=
 =?utf-8?B?K05zQkIyT095RzdTbjluc2MyRVVOVSs4bWlxZkVpM1Vsb01CMWx5S0dYWXpp?=
 =?utf-8?B?eEZibTk0NndwUzYxa1plUWpHUHFJbWt0N3BJcVlpQ3hVYjlxcFEyYmJrYi9S?=
 =?utf-8?B?YWN3SlJjZXh2YVkrRWlvZVY1V1Nla0ZVMWFKY0JWRlhNZGNDQUk0ZzNEcENq?=
 =?utf-8?B?bDY3WCt4WGlkcWtIWXBPVzlmQ1VPVGl3TnBWdkE5Ukw0VlN5T2NSWjZRbCto?=
 =?utf-8?B?WlBGbTVhSjZuME9vbXg5aUtMU0NQZ3BwYkZFY0w4Kzc1M2JVMUpLS3JFTm5k?=
 =?utf-8?B?Qi9TYVBteDZocDRqd2lkTUU3djRXd2xhR3B0bnRVWWNKUWRMYmE4REduM21S?=
 =?utf-8?B?M3V4b0VqOCt3SkdlNXlESVZqRHo2eG4vejAwNC9LM01rMGJpdmJERDJQMm1z?=
 =?utf-8?B?d1hKQ2VQNWZ4Y1NmTWRuV0JEZEl1WnZRRi9KdXlPTDBPdUhLLzFCQzg4akRS?=
 =?utf-8?B?dXpqUkpzU2hiVGJ1aHJCbDNXSDRRUTRjMlo1RnFtMTlabU4wV0xTZmp0WXpo?=
 =?utf-8?B?ZW0rdWRMYVBoOE5QQVlrOC9YdXR2cGNtT0VqN0Q2V0Q2bWw1SzM4cWlNcEJm?=
 =?utf-8?B?ODJwUWtCSy9DR2pVRGhYaERMYU04UHpzMG13U3crS0ZkalBGcERqZHJJWFRD?=
 =?utf-8?B?ZWpmL2JEbGVmcjdHc20zeFNpZVdvTlJiSFUrMThqT1Rya1REOTcrQ25DQ2xu?=
 =?utf-8?B?WmNoR0IvcXJrZTRvTjdBYmd0MVhIb01xdjU3Wkx2UExYL2MrdkdjT1hlRStn?=
 =?utf-8?B?QkV5aGpJRVVwZU5lU2dZeVE5bS9MMW9ROUxFTTFWOGxUaE5iYUQwNUpYQ1Zo?=
 =?utf-8?B?TTRHUnZSMkh1K3ZjNzl3ZFQ3NGJxaFFUM3A1Y1Q4eWxJZGxIaWFId3JDa3Qr?=
 =?utf-8?B?d29FRDI3TXV2c0U4SHF5bVBoNlFUWkpnRXlRY2hya0htdnJRYXRYRjYyVUg1?=
 =?utf-8?B?aFRQNVZKbkNDSjNocVV3RCtLOGRaZEtEdjViL0dGcXQxNncvZXFmWnJTbGQw?=
 =?utf-8?B?WXVCbnE3cHAvSlBqdzV1VitsMDhjZTRSZUZzYi9Hd3k4UW5JWGVVNGhoVmpj?=
 =?utf-8?B?a3Vib2xMK3Vxc3dHOFlzZDBwZVBsR1JiblYxYmZQbDdKdk52M0h6dz09?=
X-Exchange-RoutingPolicyChecked: DaehcCjc4BUqEYBaTZPDge08pHS/54Uml3aTZVhbHA9RaszkyFHmznXQqo6IEh6x49bJ7OQ6UwRk7XI4nInaL59iHtoAIya4LAQOnUU/N530KzMrG1jZGApL5+k7JRd6v4Eo3Qvk5hvH/k4dMh4b+ZUxxpHJduhaKdhaMP9ukLxzSpLl0AVpzZZVs3CRZtOyrlmX1VrkGQw8Xah0y8TLGXu/EiyLHE76NUjiaXDOZnuiPxnDLT3N4JKZ+dFqqY8LR14b3A8yBs1Fe97ZIMySOmBW7oMaVLP/2VZzyy6lgcww7v1fcKdpl33uyVoy6dQeRpCnNjDZjU8mxGY22okA4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ede84a8-51fa-413e-69e6-08df33ad847f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 22:07:25.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP2gzgf4R1MB+AiClPsweoEeBd3FukUmsQnzvyBlA+5DdtqpA6/aTnixg3gGYqFsL3fLx+VeFIhxhWKGwI+ShBoqcKkLgfJlo8ZFN+jjJ7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-OriginatorOrg: intel.com

On 10/25/2026 4:44 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch removes the hardware ready-bitmap check
>   (ice_check_phy_tx_tstamp_ready()) from ice_ptp_tx_tstamps_pending().
> - [Low] The kernel-doc of ice_ptp_process_tx_tstamp() (ice_ptp.c:514-562)
>   no longer matches the code.
> 
> --
> 
> ice: don't clear in_use until HW clears ready bitmap
> 
> After each PHY timestamp read, this patch re-reads the Tx timestamp ready
> bitmap. If the index's ready bit has not cleared, the index is marked
> stale and kept locked, and its SKB is freed. The patch also drops the
> hardware ready bitmap check from the in-IRQ re-arm decision. That check
> now runs only from the periodic watchdog.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index b0ea01cfcc4f..c0d056896825 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -557,7 +557,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
>>   * extremely unlikely that a packet will ever take this long to timestamp. If
>>   * we detect a Tx timestamp request that has waited for this long we assume
>>   * the packet will never be sent by hardware and discard it without reading
>> - * the timestamp register.
>> + * the timestamp register. Note that in the unusual case where the PHY
>> + * continuously fails to clear the ready bitmap index, the slot may remain
>> + * locked for more than two seconds.
>>   */
>>  static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
>>  {
> 
> [Severity: Low]
> Is the rest of this kernel-doc still accurate after this change? The
> numbered list earlier in the same comment still says:
> 
>  * 3) read and copy the timestamp out of the PHY register
>  * 4) unlock the index by clearing the associated in_use bit
>  * 5) check if the timestamp is stale, and discard if so
> 
> Look at the new "verify ready bit cleared" block in
> ice_ptp_process_tx_tstamp(). If the ready bit is still set after the read,
> or the re-read of the ready bitmap fails, the index is marked stale and
> the SKB is freed. in_use stays set, so step 4 never happens.
> 
> The opening line, "loop over each index with a waiting skb", is also no
> longer true. in_use slots with a NULL skb are now visited on every pass
> until the hardware clears the bit.
> 
> This paragraph also still says timed-out requests are discarded "without
> reading the timestamp register". A timed-out index whose ready bit is set
> is still read through ice_read_phy_tstamp(), and with this patch it can
> stay locked.
> 
> Could the kernel-doc be updated to describe the new flow?
> 

I can try to reword this doc flow (again..)

> [ ... ]
> 
>> @@ -2766,10 +2787,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
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
>> @@ -2801,41 +2826,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
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
> [Severity: Medium]
> Can removing this hardware fallback leave the PHY Tx timestamp interrupt
> blocked until the watchdog runs?
> 

Theoretically? Yes. But we don't really have a good alternative. If we
keep it, we end up with a storm of IRQ retries because the IRQ sees a
ready timestamp and retries but its stuck so it keeps retrying and
burning CPU for 2 seconds. I don't have a mechanism to properly rate
limit this to try more frequently than the watchdog but not at insane
rates that re-triggering the IRQ does. Unfortunately the hardware
interrupt throttling doesn't apply to software-triggered IRQ like we do
here. I guess I could try a timer but.. at some point this just becomes
"why not rip out the IRQ stuff and just poll for timestamps to begin with".

> ice_misc_intr_thread_fn() and the E830 path in ice_ptp_ts_irq() call
> ice_ptp_tx_tstamps_pending(pf, true) to decide whether to re-arm:
> 
> drivers/net/ethernet/intel/ice/ice_main.c:ice_misc_intr_thread_fn() {
>     ...
> 	if (ice_ptp_tx_tstamps_pending(pf, true)) {
> 		/* If any new Tx timestamps happened while in interrupt,
> 		 * re-arm the interrupt to trigger it again.
> 		 */
> 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
> 		ice_flush(hw);
> 	}
>     ...
> }
> 
> This change, combined with the new ice_ptp_is_tx_tracker_up() check in
> ice_port_has_timestamps(), means the re-arm only looks at non-stale
> in_use slots on trackers that are up.
> 
> The kernel-doc of ice_ptp_maybe_trigger_tx_interrupt() says the PHY "will
> not interrupt again until all current timestamp data is read". So if a
> ready entry is still unread at the end of an IRQ pass, nothing
> retriggers the interrupt. It stays blocked until the 500 ms watchdog,
> ice_ptp_periodic_work()->ice_ptp_maybe_trigger_tx_interrupt(), runs.
> 
> A few ways such an entry can be left behind:
> 
>  - a stale request whose timestamp lands mid-pass, after the ready
>    bitmap was read
>  - a late completion on a port that is link down, or (on E82x) in
>    Vernier calibration with tx.disabled set until
>    ice_ptp_wait_for_offsets() succeeds
>  - an index this patch keeps locked on purpose because its ready bit
>    did not clear
> 
> Before this patch, the in-IRQ ice_check_phy_tx_tstamp_ready() call
> retriggered the interrupt right away and drained these entries.
> 
> On E82x, timestamp memory and the interrupt are per quad (see
> ice_phy_cfg_intr_e82x() and the quad split in ice_ptp_init_tx_e82x()).
> In ICE_PTP_TX_INTERRUPT_ALL mode the clock owner services every port.
> 
> Could one leftover entry on a port that is going down or calibrating
> then delay Tx timestamps for healthy link-up ports in the same quad by
> up to about 500 ms? That is far beyond the 10 ms ptp4l default the
> commit message cites. The race window looks narrow, but link flaps and
> E82x recalibration happen in normal operation.
> 
> The commit "ice: keep Tx timestamp slots tracked until completion or
> timeout" in this series also says an orphaned ready bit "blocks the
> port interrupt".
> 

This entire mess is frustrating. If I try to fix one problem I create a
new theoretical problem, and I just am not sure there is a clean way to
handle all of the @#$%! corner cases these PHYs have boxed us into...

Implementing a polling routine kicked off by the Tx path on a timestamp
request that just checks and re-triggers with some form of back-off
polling so that it will try less and less frequently until a new request
kicks it back into higher gear seems like the most ideal solution to
bypass the complexity of all this broken IRQ nonsense.... But I don't
have a good tested implementation of that available right now.

Suggestions on how to make progress on fixing this are welcome....

