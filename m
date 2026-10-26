Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793050844;
	b=z2cXteWyz0cj/ZfWWfpBIBf5F4+A3Gx2bI57U/eIcLJ0t43AIpVECGuuhi0S+VcFl0pT
	 pn6QnBsB5BXE8YFo0PsjZqBPLYOFgPNmK2p1yAGvsMTeSdneCET+vVbUnQSnxzMYFzMQ3
	 85Raa3GgB/qWZvrQDbCCBuhlHx4sotZTg88mTamGg9aj8oIfG8znhc8NjyEmAc8Ome9p6
	 ++zHXA8bZhOdz0Fap10E0Lt1a3hOjf5wVYlLHiRQhwj3gsfeqBORdnFdMhWwg1I/7rsFS
	 gE8VEl0qmh82jiFbP3qlKCwnc8C/SRIzIENsLcP/5EzOB6IlKsQP+ZwmLfVfUkoVhjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050844;
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
	bh=nb4cGEmIVakrpvwFqu2xnX0M2J3zN9af/3Fka7opCgs=;
	b=QYNC4M01/WFe7ltBt/B7RI98tkbi2j15z9W8vGiL7HbS+rR+zzGDfM8vXaxBikqXuETk
	 Eid9GIQv6Igu6G6BXuv3fNHC/bsRDP3w1IL7N9XsDKGUpt0FFSkVB9SpjWAqsdzyUUbSp
	 UjmRGk1jLBU80571RsVcpznewBRAEXq98baNfWZ/b3heKrTsSRG+5Benz86R8htsPwxd6
	 ZntS4kUls6vZ/7r6UUqQenK83b21PAQOhFFPZm96g4gVbNnkut2WpEvPof0pRHfzjL4zt
	 QX8FKY3+QEm2G0jLG+j2BcSslB1zKgLoLMvmjVPGh6aSYuH6V5vbrMq2eCQj9HqT1iQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUUppLmk;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF378606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 21:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF378606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fUUppLmk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793050843; x=1824586843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=trF5Jcw2rPUU09O4rLAxVvd9v0vrs6YzqJwoMJ4Qw/M=;
  b=fUUppLmkDLWRIJxANS+gmjTCB7vzZHPdbbGttUkrY4IJPOSCv1vTyxzB
   fQ50J0M1xNeSCE2D0b4S2kZrwL97joVkIIG7Q6U8p8QybJif4SJ4JIwux
   r0kP57cP9hTBQmlk894THKnr0W3bTjkOpWKov08dYLej0mzmPVOVBfNWu
   BvUCd9HJWJGCKV8x21yrk/RQ4Hq8Bg/lrUIlb+314e8FrP/7tYKXhOMic
   xo5dB54lvLZxnL8hbaSEULOzHS9YQNcVJbLHePi/jI1cTaWd45Hq4hiUH
   cMQlTud5lwysBmbhfJTeFWa86NIumJQ6QiL0VLuBDl5a5a4Vpr9FZuxfx
   A==;
X-CSE-ConnectionGUID: 8/rgai84RfOOwb9JorPsyg==
X-CSE-MsgGUID: /C6H1+qKSO+WllLoM7sPMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1737860"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1737860"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:40:39 -0700
X-CSE-ConnectionGUID: pVheNks/RMyN1MqADTlRzw==
X-CSE-MsgGUID: EHF/WsH4TkCWb/idVkGDcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4328928"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 14:40:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:40:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 14:40:38 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 14:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaCdfH7Hr3KQ78igiiUE6ZMBn55bwxoNz44IOSLuDyIhF2LxnQcXe4Ho/kJCs1wd89OCv7TiKSnr/eKkNzLU/MJY+Mk47GqeVTyM1Pr+FCBcr5D6qWzvPTZvTz3lzN+po9YL9I1mVzT+pYfmZxUGKnJ2pS9IPij0z3poSNT7ySudB/Lk3aSjBDs7BQBAKaeEXVsWUM5HlIVQLu/UsCQ8WYexiddftyoQ3DRNuRk3/CxFFzsTncd5daCyGOH5wjDfmxaBYqA8gdaJaGqreELS8Er/3y9bh2eEZ1RlqE1nfi72CLsotErybXXBE262ilH2H2jhkftm/AA7DKd9vy1jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb4cGEmIVakrpvwFqu2xnX0M2J3zN9af/3Fka7opCgs=;
 b=kjBnTc3rAPHW8+32NrpUJ80S49wuHnjuyeC/nK93fMQtRwlZHU1zN+W9zy/4d5l+LaaaJCNSorWDOI9QJHGKXoJSRUqvAa8ZIx4zShSyzQ6iUnQ/XIg5Kek/MhVLl9+ySGONvxemaeUAVWqV01Ea7zcczqR9hQSTumpxFXw5/Klf4w43tjjLJUZrNLGhL5GwnxRyWG/29+cIhlaX/rAN7+BfgdionwflJDKM+XqM6F0Dsvc/3keheVgwthInhufjPajZZF+oM1eQkrCMt9xyzAOisAwFgqvaNZ3LqgTFQ+INsImi1PoxTEEHjeSy/Dw4DuiRSqDvsiU+kiPoH2fYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 21:40:29 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 21:40:29 +0000
Message-ID: <84ed0c60-7d4b-4ce1-ac90-ba3249d213fd@intel.com>
Date: Mon, 26 Oct 2026 14:40:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 05/13] ice: call PTP link change only from link
 events
To: <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <poros@redhat.com>, <netdev@vger.kernel.org>,
	<grzegorz.nitka@intel.com>, <aleksandr.loktionov@intel.com>,
	<alexander.nowlin@intel.com>, <anthony.l.nguyen@intel.com>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<sergey.temerkhanov@intel.com>, <arkadiusz.kubalewski@intel.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>
References: <20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-5-72289a4ac8eb@intel.com>
 <179297183738.3134.5666599112368477416@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179297183738.3134.5666599112368477416@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0237.namprd04.prod.outlook.com
 (2603:10b6:303:87::32) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH7PR11MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 384fede9-4fa5-4d51-f6b6-08df33a9c0e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|10067099003|3023799007|56012099006|261026121527099003|22082099003|18002099003|5023799004|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: ytHEkM6xdP3vznWd9VX6wA8S+lqWD91eC1SuFayhe3tBOzYuExi3OeQ+pvcy1BcL24BUKDBv82lcyAKoygFWUz1Z8BTEBfjO8xcWwjolq+UmsOEamLIY84TSzFNkqI50A3yaQ7ReCxRwxI/xUKD+HnZhvqyNmlb8r2z5fnoduJxB+ox4uBRIdeCFPOGiDWreOGZBEAiFYu/oyzeGEUcG41OH/swcMVlo2EPzB+10bsyI5hMhclhpdC74Ecd/atjwgCyFHqwKSgWeqMbBc1jw2eL+9KAWM3aj5TatWq+uaspZDAC/xEfjMjG2nafJlqF+Of7bn2C7ZmeAe18oz6FgMBZ7GyiXSeX/wuB/oJbED0bLUoAk4vqOtPuQG4drRSrdKKbo8bmF48hTyeBZ3x20ZRr/bmGcrtj5iJMxl9KPCoaKnSNbJBuQIUeAph5/s3scQrg8CwrAS526fA76NqOvxicRuezzT4fbTAYU9/LyN84uQhIY3rAu18gE7fFCz9+aBqMvGxzXfJlRtfiLEaHkxkPd0nJZmQjVr+NPfLwj1f0WEucDJrWl1UBuTqtsU8xR1sYuNDooQY7WmJ0SdS2XNgkkeXlZYuQS7wbWW2Ib1ZSjBDT05fa3GUpspimExl3oo4fNv2rwFdzRLmv/a0bua/A2vj1hmQi59Mx5Lv4gBT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(10067099003)(3023799007)(56012099006)(261026121527099003)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnRqMEZOb0lMZjE2U1BWQ0pmdmUwak16VHFmbWNpT1dFNk15UlQrcE5rSmtO?=
 =?utf-8?B?RC9tVFBjS3BxNzB0VVhUSFpaRlR1N29MODVKb3lVajVyTk1GejlXQkFXcmhv?=
 =?utf-8?B?OWVFOFE3YjZXR1Y1S2VzUHFPa0NzUkd6UmhQWE9YSFdkRmFXTjNqV2hHNHFQ?=
 =?utf-8?B?UTd2czdjNmJYU2hKb3F6U0FzbTdYWm1OYjZKdGNOTVI2cVhQWXNQRnVBNkwz?=
 =?utf-8?B?QXcvL2E5aDR2TC8vNmFxV21rV1hUSkozRngrdTVkQ1FxSFp2aGJDSHhSQlI0?=
 =?utf-8?B?UXd5ZlVwOTZESy9ZazNrb2lzZUkvVDM4YXFoY09VTmRUVVFNMFIyUnhTZzZn?=
 =?utf-8?B?cE0yNzFnNmV1amdZTDdKYjZpa0xreVNYcU44QnVIMmFiRG9oaTJ0YzFLNnF3?=
 =?utf-8?B?UVRIbTdoVCtHTFlpTzJlS2pmS3lHcU81RUJTRnlqUjhHaXJXanBsaEpmMkkr?=
 =?utf-8?B?K1dqUTVqV2tIdHlNN3grSDFqa2NodWV6ODcrRWdsUndJTWtLODlIcDQzKzU5?=
 =?utf-8?B?MjF4WUFSYmNPdktpdzQ3WVVYejkxa3NwTXZHQkFURDlmbUd0M0p0bUhxUzY0?=
 =?utf-8?B?TDBDZE9rRkNhdlFKSEJRL2dVaXVLSWtscVBoWjBYR25BRi9Ic081TnFuOStx?=
 =?utf-8?B?YzI1Q3hGWVdYMkx3OFI2WlY2VFlhcUpMdFNHamI2YnQwOE50aUhvbm5JTFIy?=
 =?utf-8?B?NUFuaGdzNGs0MWpkb2hidnduK1BWb2R1UFpPdTZsSEJFK0hsdFZUSVRSbUMz?=
 =?utf-8?B?Q3h6M04rZUpWa1J6UlI3WTRVUS9DNnRNcnN0ZkQrYm1ybWd1WU5oZzVKWXJw?=
 =?utf-8?B?cktlMWxQWGwxUGVWZWZBcHQzMTNYVlhUMG9aLzFnMSs5eWNtczNGV1k3STd1?=
 =?utf-8?B?M01GZWxSc1FjeXZRdUxvd1pxVEo2SFlOWEQ0akJNVzVld1hmK3BsMjRqVmMw?=
 =?utf-8?B?aWtkenJWdE1KSzNtZEhEYWRMU3JVNW0rWjFaSjlBU3VIMHhKRlRoVkZ6ZDQ0?=
 =?utf-8?B?djdHa2ozR1RUUVJSR0RFTmx3MmhOZEhHSEFQZXJnYkhUaTJuMk9oMjY4Yzlt?=
 =?utf-8?B?VkFUK2lFRXpmRmJsb2FEMHluNWhpeHh3ZThyY0o5WndXaUhKV2JUbll0VnFi?=
 =?utf-8?B?Ym4vcVRqZGs0ekJuaC9XVGtQQUszRU41OXVCT0tjbVlnQnUyNStDdWlUZFdm?=
 =?utf-8?B?YnlicWZMSGpDYUJtR2V2bFA5ajdGYk81UlhuYXN6QUFrajZYVjYyMFFPa2RU?=
 =?utf-8?B?RFN5SU8zN1owTUFVVXNJUlhBdy91NDlWZ1F3NkVYNGN3dHhyL09BWFduRDFw?=
 =?utf-8?B?ek5PQUd3WFUwdmpnSzJ2bk01SWoxdVpPU0xIY1crcTVVMU9MY1FJT3RPWVRO?=
 =?utf-8?B?UDhzL0JnSG56QWdoaFRRNktxTlNkMVhVUkFnZk5YcVFDL2pSekNpV0lsQklp?=
 =?utf-8?B?ODluZndsV0lvRHl6RktxUnFUZzVoTzNVWkVmTFlGYnIvQkRIejBLSWpSWTBC?=
 =?utf-8?B?em9MN3ZVcFc1N2JEOU9sYjFuMmprRklxWlpvSXlmbmNDd0NjendianMwN2Jk?=
 =?utf-8?B?Uk5RZTdoUzh5ZDBEZy9iamtXU2NvVnlPQTVvd0IwS0lMb2tMM21vRCttSVMx?=
 =?utf-8?B?dW54UkJvd0ZhTUZ1VWs0d1lTRzJTYWRBN2dBRHJjVGlUVVlYTDRJSHBWTVFD?=
 =?utf-8?B?VjRyR2IxTVVMMGFlTml2MW1BUmRwUnlQUndKWTQ2aFNnY2dNZkhISkRwOWlI?=
 =?utf-8?B?S2ZHbEFhRVJHd1A3c1ZPYkllVUF1cktUcHQralNJMU9TZzJQYStwQjlFT04x?=
 =?utf-8?B?c2xVWGtpRDZoTmJVVDNleGt4VW44VmRLbWtiUEJjSEV6S1MyZXBEMEJLNjIz?=
 =?utf-8?B?aUJpdU5NVGZvdTNuT3FHMklzakxvWEIyeTNiWVduKzRhWktGdms4REhqYUs5?=
 =?utf-8?B?TGdQd3FZdGY1eEdsakN4OGFEdThuZklKYjZvYjN1ZERaQm1yb2M2VEI1UjZn?=
 =?utf-8?B?dGxjZENxZm9aZHgwWXo2cVRkMUd6K2pMMjhDQ2g2S2k2WHZEZW9xV2FVcXo5?=
 =?utf-8?B?RmVYV0FHdytwaEJaYVJXeUQ0aXFNOFdJWUVXUlkydEh1MjNZYjhNb2pTN0xn?=
 =?utf-8?B?VG1xRW5pb2x5eE1NZzY5OTVwV3VEd0w1MVFhRjNxdUJqVnhSNzZsWWZmYTZE?=
 =?utf-8?B?ZU5hTEpWVS9OTkNacTAyR2UyYjFtVjB1RmVnek1CV2NLNHJoYXY0VXBmZUk3?=
 =?utf-8?B?SlI1T1k0UWZrZ0VyYURvTVJYbnlRMVBBRXY2c25lWjhheGFCL0o0ZllwQmdm?=
 =?utf-8?B?YWU0QUNWcFRmZERzMkJMZTFCbThGaXpYL1pXM3BVSng1QXp5Y1NMZz09?=
X-Exchange-RoutingPolicyChecked: 4dkDyMydfV9gwf1DrvujOmm5642a5GxS/OKKIEuNEulzuX70/spdDtTozHKufQfcdor7EnDAfheigPPryfOrgL1ejyUKBXIrq7YkYf3A8V4bZkHjtiRQKU79izI0LUFavnWBtko04CEE16WOdAx5gHh+xbCifxbWLQV7GaJ5SjPp+q7f9mYfiiCZIm+61y7gjUSGsNhwm4QGFDYrETMzWt4rHgj8Jv8QdwzdiypxfiNNv5kvEMzgen/nBVuZBcqbTYKxR32g2dcC28JZFsyKzxgNvTI3Dw/I8uwTl+C04j/DWb0HemxlPUR+kqUl3HGZMUoQrKDHVG/hMK6gP2BTPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 384fede9-4fa5-4d51-f6b6-08df33a9c0e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 21:40:29.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6/qeSCg6lrndSrwdblv0irZWzGyTPGYmFzPfOROuZMNSN3rKh8FWkg/zGLAsqJIbtdV9Iec9LewN/ziA3rt46PjyxQ6/r63EJixntJTPmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
X-OriginatorOrg: intel.com

On 10/25/2026 4:43 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 4 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] A link speed change while the link stays up no longer re-
>   calibrates the PHY timestamp block, and on E825 it no longer…
> - [Medium] After a CORER/GLOBR/EMPR reset, non-owner ports' PHY timestamp
>   blocks now depend on a single unordered restart from the clock owner,…
> - [Medium] The post-rebuild resync in ice_rebuild()
>   (ice_main.c:7801-7807) relies on ice_ptp_link_change() to bring the…
> - [Medium] After a devlink reload, pf->ptp.port.link_up is stale and can
>   leave the PHY timestamp block in the wrong state indefinitely.
> - [Low] If ice_ptp_port_phy_restart() fails, an administrative down/up no
>   longer retries it.
> 
> --
> 
> ice: call PTP link change only from link events
> 
> This patch stops calling ice_ptp_link_change() from ice_up_complete() and
> ice_down(). It seeds the PTP link_up field in ice_init_link(), adds an
> early return in ice_ptp_link_change() for when the cached link state
> already matches, and adds a resync call at the end of ice_rebuild(). It
> also makes E825 call ice_ptp_port_phy_restart() on link down.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index d88835482d3a..910ebdcdde19 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -1144,6 +1144,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>>  		ice_set_link(vsi, false);
>>  	}
>>  
>> +	ice_ptp_link_change(pf, link_up);
>> +
>>  	/* if the old link up/down and speed is the same as the new */
>>  	if (link_up == old_link && link_speed == old_link_speed)
>>  		return 0;
>> @@ -1151,8 +1153,6 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
>>  	if (!link_up && old_link)
>>  		pf->link_down_events++;
>>  
>> -	ice_ptp_link_change(pf, link_up);
>> -
> 
> [Severity: Medium]
> If the link speed changes while the link stays up, does the PHY timestamp
> block still get restarted?
> 
> Before this patch, an up->up event with a new link_speed got past the
> "link_speed == old_link_speed" check. It then called
> ice_ptp_link_change(pf, true), which always ran ice_ptp_port_phy_restart().
> 
> On E82x, that restart reprograms the speed-dependent lane, UIX and PAR-PCS
> settings and requeues the Vernier ov_work. On E825 with DPLL enabled, the
> call also ran ice_tspll_cfg_synce_ethdiv_e825c(), which computes the CGU_R10
> divider from phy.link_info.link_speed.
> 
> The new early return in ice_ptp_link_change() only compares up/down:
> 
> 	if (READ_ONCE(ptp_port->link_up) == linkup)
> 		goto out_unlock;
> 
> ice_link_event() also forces link_up to true whenever the refreshed link
> info reports the link as up:
> 
> 	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
> 		link_up = true;
> 
> Say a down LSE is processed after the link has already retrained at a new
> speed (ethtool speed change, AN restart). That event is treated as up->up,
> and so is the up LSE that follows.
> 
> Would the PHY timer keep the calibration for the old speed, and the E825
> SyncE output keep the old divider, until the driver next sees a link
> toggle? The kernel-doc for ice_start_phy_timer_e82x() and
> ice_start_phy_timer_eth56g() says this must be done "whenever the clock
> time is initialized or when link speed changes."
> 
> This also seems to conflict with the commit message:
> 
>   "This sequencing should ensure that any link transition will properly
>   update the PTP state to reflect the new mode"
> 
> This still appears to be present at the end of the series.


This entire flow is frustrating and I have no idea how to properly fix
this garbage to actually successfully get everything lined up without
also causing the issues we had with other changes. If I don't move this
call, then we end up missing link events. If I move it, we end up
missing other events.

I've now had to respin this series so many times and each time I get a
complaint that something is wrong and I can't reproduce or test any of
the paths reliably, so I have no idea which way is right.

> 
> [ ... ]
> 
>> @@ -4810,6 +4810,14 @@ static void ice_init_link(struct ice_pf *pf)
>>  
>>  	ice_init_link_dflt_override(pf->hw.port_info);
>>  
>> +	/* Seed PTP link status from current PHY status, since link may
>> +	 * already be up (e.g. after PXE boot) without a link-change edge to
>> +	 * catch it later.
>> +	 */
>> +	WRITE_ONCE(pf->ptp.port.link_up,
>> +		   !!(pf->hw.port_info->phy.link_info.link_info &
>> +		      ICE_AQ_LINK_UP));
>> +
> 
> [Severity: Medium]
> Can pf->ptp.port.link_up go stale across a devlink reload? This seeding
> runs only from ice_init() at probe time.
> 
> ice_devlink_reinit_up() calls ice_init_hw(), ice_init_dev(), ice_init_pf()
> and ice_load(), but never ice_init_link().
> 
> Before this patch, reload-down went through
> ice_unload() -> ice_unregister_netdev() -> ndo_stop -> ice_down(), which
> wrote link_up = false. The next ice_open() then wrote link_up = true via
> ice_up_complete(). Neither write happens now.
> 
> ice_load() -> ice_init_features() -> ice_ptp_init() then calls
> ice_ptp_port_phy_restart() using the link_up value from before the reload.
> 
> Suppose the link was up before the reload and is down after it. The PHY
> timer is started on a down link. When the link comes back, the up LSE hits
> the "link_up == linkup" early return in ice_ptp_link_change(), so the PHY
> is never restarted for the negotiated link.
> 
> Now suppose the link was down before the reload and came up while LSEs were
> not yet re-enabled. ice_ptp_init() stops the PHY, and no LSE edge arrives
> to start it again.
> 
> In both cases, would PTP timestamping stay wrong or disabled until a
> physical link toggle? This still appears to be present at the end of the
> series.
> >>  	ice_check_link_cfg_err(pf,
>>  			       pf->hw.port_info->phy.link_info.link_cfg_err);
>>  
>> @@ -6745,7 +6753,6 @@ static int ice_up_complete(struct ice_vsi *vsi)
>>  		ice_print_link_msg(vsi, true);
>>  		netif_tx_start_all_queues(vsi->netdev);
>>  		netif_carrier_on(vsi->netdev);
>> -		ice_ptp_link_change(pf, true);
>>  	}
> 
> [Severity: Low]
> Every administrative up used to retry the PHY restart from here, and this
> removes that retry.
> 
> If ice_ptp_port_phy_restart() fails because ice_start_phy_timer_e82x() or
> ice_start_phy_timer_eth56g() returns an error, Tx timestamps stay disabled
> and ov_work is not queued.
> 
> Before, an ifdown/ifup, MTU change or ring change called
> ice_ptp_link_change(pf, true) again and retried the restart. That call is
> gone now. Any later call hits the "link_up == linkup" early return while
> the physical link stays up.
> 
> A later commit in the series, "ice: E825: stop clearing
> PHY_REG_TX_OFFSET_READY", says a link reset (e.g. via ethtool) is the
> intended way to recover. The dev_err() in ice_ptp_port_phy_restart() also
> says "A link-toggle may recover". So this looks deliberate.
> 
> Could the commit message mention that an administrative down/up no longer
> retries a failed PHY restart?
> 
> [ ... ]
> 
>> @@ -7794,6 +7798,14 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
>>  
>>  	ice_update_pf_netdev_link(pf);
>>  
>> +	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) && pf->hw.port_info) {
>> +		bool link_up;
>> +
>> +		link_up = !!(pf->hw.port_info->phy.link_info.link_info &
>> +			     ICE_AQ_LINK_UP);
>> +		ice_ptp_link_change(pf, link_up);
>> +	}
>> +
> 
> [Severity: Medium]
> After a CORER, GLOBR or EMPR reset, does this call restart the PHY on
> non-owner ports?
> 
> Before this patch, each PF's VSI rebuild called
> ice_up_complete() -> ice_ptp_link_change(pf, true). That restarted the
> PF's PHY after its own control and sideband queues had been reinitialized.
> 
> Also, ice_down() no longer clears ptp_port->link_up during
> ice_prepare_for_reset(), so link_up stays true across the reset.
> 
> The only restart left comes from the owner PF's rebuild:
> 
> ice_rebuild() (owner PF)
>   ice_ptp_rebuild()
>     ice_ptp_rebuild_owner()
>       ice_ptp_restart_all_phy()
>         ice_ptp_port_phy_restart(port)
> 
> This path uses ptp_port_to_pf(port)->hw, which is the non-owner PF's own
> sideband queue. Each PF handles the reset on its own from its service task
> (ice_prepare_for_reset() shuts its control queues down and ice_rebuild()
> brings them back up), and nothing orders one PF against another.
> 
> If the owner gets to ice_ptp_restart_all_phy() before a non-owner has run
> ice_init_all_ctrlq(), the PHY access fails. On E82x, tx.disabled has
> already been set by then and ov_work is not queued.
> 
> The non-owner's own call here then returns at the "link_up == linkup"
> check, because the link was up both before and after the reset. Would
> timestamping on that port stay disabled until a physical link toggle?
> 
> This still appears to be present at the end of the series.
> 


I think this needs to remove the check against what the current value is
and just unconditionally restart the PHY on every link change. :\ But
I'm not sure if that wouldn't cause any other issues...


>>  	/* tell the firmware we are up */
>>  	err = ice_send_version(pf);
>>  	if (err) {
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 1e6ba6bbf6c2..f43918f334e8 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1319,6 +1319,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>>  
>>  	mutex_lock(&pf->adapter->ps_lock);
>>  
>> +	if (READ_ONCE(ptp_port->link_up) == linkup)
>> +		goto out_unlock;
>> +
>>  	WRITE_ONCE(ptp_port->link_up, linkup);
>>  
>>  	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
> 
> [Severity: Medium]
> Can the cached link_up drift away from what was actually applied to the
> hardware?
> 
> link_up is written before the READY/reset_ongoing check, so an event that
> skips the PHY action still updates the cache. Nothing on the reset path
> (ice_ptp_prepare_for_reset() or ice_ptp_rebuild()) invalidates it.
> 
> The first case is an LSE handled while hw->reset_ongoing is set (it is set
> without ps_lock in ice_misc_intr()) or while PTP is in ICE_PTP_RESETTING.
> link_up is updated but the PHY is not touched.
> 
> If the owner's ice_ptp_restart_all_phy() has already run or skipped this
> port, the ice_ptp_link_change() call at the end of ice_rebuild() returns
> early. The PHY then stays stopped while the link is up.
> 
> The second case is PFR. ice_ptp_rebuild() skips the owner restart for
> ICE_RESET_PFR:
> 
> 	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR) {
> 		err = ice_ptp_rebuild_owner(pf);
> 
> So if the link does not change, nothing restarts the PHY after a PF reset.
> 
> Later in the series, "ice: E822: cancel offset verification work during
> reset preparation" adds an unconditional
> kthread_cancel_delayed_work_sync(&ptp->port.ov_work) to
> ice_ptp_prepare_for_reset() for ICE_MAC_GENERIC, before the PFR early
> return. Its justification is "the ice_ptp_link_change() call at the end of
> the rebuild".
> 
> Also, "ice: E822: keep Tx timestamps disabled during offset calibration"
> makes ov_work the only place that clears tx.disabled.
> 
> With both of those applied, a PFR while Vernier calibration is still
> pending cancels ov_work. The rebuild call then returns at this check
> without requeuing it. Would Tx timestamps and the Rx offset stay disabled
> until a physical link toggle?
> 
> [ ... ]
> 

