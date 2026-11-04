Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793826596;
	b=5WxApImcfcwBIZZYoWsUykHpaoTp0FKuRuI2453XT0NAhVuQVes8+pbxJTgxzobJu2pa
	 Ipalt1UJOIkbK0ZATrxmvyG7YoJLs6k0olHJwLzq4IzTcoNpCWS2lpmZE2NzbLQ5edw9H
	 wieEg8o3nUJB25nbgIVrs3ApSFqrniJ0RWfsdFsjTOreT7q/CcAkFc7jeydi4s2ZHe18e
	 +YHmF4CbA6UIkHORpT60X0LrGb3YasW7TeiQ2R7CC/yWesAmiZ8LIZaDptHhzptH6oGuc
	 YXjEQy588tkw84e9Do+y+od0+iWsWn9IZc19E1mYmu0rHCmYSvn/4Emv1kIqmofgxFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826596;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=UyyRgGAwYQjrx2tTgOIpxYys3yk2F88CdRd5GBHFeW0=;
	b=mCKLVibcrjYlTYAonxxcEDjgPrk9Dl7H7RgwUZEImlkCtPl9k0TpkNP+kIy7z5mnd68n
	 4dtV2grHupW+jlxNPVMiGhGbZ+x8KMk81/vEao/0MT4PNNuILTY0i5/kKAxgLfIWWNbtO
	 S01+jAjhA9h7mi+hbEneE+eV2iIExlZfz0SlKhwCPf2RofYXImpEcksH1t1TaVfff3Z3d
	 eYgLReXlcNcPu+COR8HAgqBesrlTgrpIZ4MdvRSdNO9KJfYInfhP3vfOPMF+yVf4RVvEO
	 v/e68XHhJvaWuSocqrSOtMGu/rq3cYnzyQrXNBJBlYWxw1vlmEjQqBXgCMJ9OnRa5LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AIkVji1f;
	arc=fail smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5A607D640
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE5A607D640
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AIkVji1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793826596; x=1825362596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8yXS0J0HCpPdd46btqOH72i3mMmmnSuB3qXrvC9W22c=;
  b=AIkVji1f2hr4Fw/pMO0nN3IR8uDgEotVihi5IKHL88rPrfYQWCPmDttR
   P5ZKK/iQiIHkugahH2ByY6hQomzW9rVQGfQpAQJWGeSJAVc0xaAWR2ZGH
   dsN9NOVwA0LK64eH/4LvCl3Z1RX8E+TSxslaBxO4qQotA+ezUkravllC+
   AxO1b9qZVZP030kwOm+LHtTzJpwVl0zUXgwqsGWtlNRjWLXmepmYh6WLj
   fnL4D5s6npI2p514b7+2xKrIiERUPzs/KpEqW0EmDzf/cdp8Gs4z/ny6t
   BGTq/mPEOa/vi45khvLFjPC3S/Ndtvu9ihFdAlY+FqbM65F3UwbHDLNn3
   Q==;
X-CSE-ConnectionGUID: HTjLZ0GCS4uky7DvlF5D8g==
X-CSE-MsgGUID: SjEhVfTgSpu08DZ2eKEK7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2634042"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2634042"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:09:55 -0800
X-CSE-ConnectionGUID: EzuuPkxIQxm+CKoQCzzsfQ==
X-CSE-MsgGUID: cgB5OuixT32rNt1BGQcNZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6655649"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 13:09:55 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:09:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:09:54 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:09:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJl1q3/hHEiMqrxyPBPomk5HRrUEXSKbZRhG6EKum7a3Bg1+7OLfeY6dY8DwlSGqYzcaIFRiGUhhirOa2YVn8sUdE7b6SkFvYtXUpD0dXde2jpbjl71SM7dexuJSfT9SlXrtirgTrQXJqX8AoEkHWtpgptmQc65FJZ1ZcrekRRFcRsMp4U1lM4JsP6lrmDe3s0qJpUWVVExtQEmCjzB0EwAoNRCOmt4lHu845qJBu1O/KlkTHaH1vg2dTs0uk3uDyKadKLaAuJ0IuvnkoHnCrr2gClhaTxWqAZirU0kxgAo5Kx4+SKlESHmz8Vu37QUPlSO65tTmgTd1+XQe/XRcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyyRgGAwYQjrx2tTgOIpxYys3yk2F88CdRd5GBHFeW0=;
 b=OwQDa3Ubi/wT3GM+1qaqptmf6TVtvpsRdZGj3Dtlq0Bv54A4bm/IUZ5gn4J36LfXJmZromz2v8VNBlNzZwR4EhbF/HFMPtiK1OAym4RnxozYBphIHUsY19h/vmnhkVhiEkJSGVNHNbYXaBB98n9OPlhGVGGYClMAsKRlEFEixOKT1HAKMVS48TQJxnMSt8RIVHbHKcLV1Qu8de2zGpsN11i7AV7qihryI0FkUmT5dL7B5whpdlqct5xZKx4S6vIGThkO153MytfLzLRfGLM5ImahxJw1gUh56gcBmPyOJTjC4ygM2Go1N224fd/tNRmyUk4+X7H5lezA/MiCCP1CMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by CC6PR11MB058488.namprd11.prod.outlook.com (2603:10b6:170:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:09:41 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 21:09:41 +0000
Message-ID: <b1300fcc-a994-4962-b460-142ee9210734@intel.com>
Date: Wed, 4 Nov 2026 13:09:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ice: E825: clear PHY_TSTAMP memory prior to soft
 reset
To: Paolo Abeni <pabeni@redhat.com>, <netdev-bot+sashiko@kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<poros@redhat.com>, <netdev@vger.kernel.org>, <grzegorz.nitka@intel.com>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>,
	<anthony.l.nguyen@intel.com>, <maciej.machnikowski@intel.com>,
	<przemyslaw.korba@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>
References: <20261029-jk-e825c-critical-timestamping-fixes-v1-2-72128d1dd928@intel.com>
 <179339643733.3131.11053424586570802270@kernel.org>
 <4239c9d0-734a-4a58-82b3-6663ba90123a@intel.com>
 <0315bf5d-582e-4e8b-8630-9c83be2c7bb4@redhat.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <0315bf5d-582e-4e8b-8630-9c83be2c7bb4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To DS0PR11MB7381.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|CC6PR11MB058488:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4f7f61-9ca2-4f71-2f9f-08df3ab7f106
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|4143699003|261028144727099003|261026140227099003|261022105027099003|261009223027099003|261021121427099003|261102123227099003|261026121527099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: yb4rnm6SUiesq4D5gPs8kBii0lU/J8Pic6XMSlWKvrJJpIhHWp8zGcB5o4uC1bwFtw26oNc58uS/kJ4z6ilOow9i8zzZ24g0RFmlequDEEmIuNsBNVrVxfMK0dFuMTDW4WWersYP/oNlCvmfdVNfPDQ9q09hLq/hqptW1p5XGXcoQmxC5vYzAaCjEaMWK2dJlBpZA9XsA9wxZBxrfjUwaqhvGsRqOm0sLPhieahhGRoOL+05nJ0kO/R9i6Yd7JFnTH19YZEJNKtolXAvS3nc/gA2dy5//9zNOsyJw9Q/O3IvO26zBc7Qf8K5mggpUwpttToojZcKLYvNJgzrlE5W6KR0kVLl6L/TjAxBz+tzc3ueQOuby5eYGfdDKtO2xbysjSd0jPE6jricWxjDvMHrH3WaMjxK/31ReBMxqwM8veObL5mumrhqDxPRH7+kY6KwZJEA5x7cbTxUn2drYFgniLG9LuH6oYpB7M1HMXRNSS1tfzt70oygees4wLCRxMniIMutTeQFuFnVcX68y7HqnSK9OMLHR3+8KHnWMeAxnzbByIVKzCxd0UuhxrkYo7LUVf2rHzkKX+15fzVjFI5k8UdTFSkzXSPqWOVDIcla99ZW7ATmrsimXtO4H7s1mqVqslhvT13MGfG9cOEAe0lBofSkZiOw+bDcoEpbNMQ3Pzc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261026140227099003)(261022105027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzI1d0VHV2doYkRRUHZpaGRXTmRWUVp0Tks0ZEdXeHRRaXk3QWpOSDdmZmJP?=
 =?utf-8?B?RSsyS3JVSDdiOFJWWkw5aitreEFxU29udTZJaXVsbnRKWVBPYkNjdnZqaFls?=
 =?utf-8?B?K3JPRi9PM01lZC9TK1RTRTF4UEtrQ3JPYkdJdmZCcWhYRE9tRzhaNE9ySkEx?=
 =?utf-8?B?YkRnSTRmV1BGWUJkdlIzQmNlT04zOEx0T1RpcjJQTVl1L1QzazVXSUdwdkUz?=
 =?utf-8?B?OEQ5b2dHVXI0SDhLQkRkeU1aaHlhMWRITVMvOUZSc1plOStaOWtDTThhSEdi?=
 =?utf-8?B?NlBEc25DZ2llc2MwTTJpeWlUV3ZmQlJwSkJYeUo4OWV1MG9VMlBmWE5nTCtS?=
 =?utf-8?B?MzRSSElEazVOd1d4a2xFakRBek4rTk0xY3hmNFpQcDNNT3NsYzNYTHlDaFli?=
 =?utf-8?B?SVBlYkVhQmdacC9CZUgyOXBlRUg3SnpCaVlRY0Ftems2U3plZ2VjV0p2Sk9C?=
 =?utf-8?B?N0dySDZzaWs1WmU0UC9HZVdjM05jMUV4K0xQQit4MmdDRnB3NlNubE54akhM?=
 =?utf-8?B?OTJSWWF6bVEwaVpjTzArcmlpU0FvTTI0eE1hUHMvTzFmN09pbUdrNktWekFm?=
 =?utf-8?B?NWxHT0hhMVpveVR6MXo5NytLWjdQZDRmWFVjWHFPTHBibS9iTGQwOFNBVEpY?=
 =?utf-8?B?NEJadFVXai9jWExFZ2cvTTRUTDFOTmtGaUlmRWIwcG1kMGl0VzFhUkpsVndz?=
 =?utf-8?B?OVBVV3o4RXkwMGdoSlMxQjl2WXFFaG9UM0JhOXVkbWl0Q1RCeUI5Sy9RbFZ2?=
 =?utf-8?B?QmNSdXdEWHRudlcrWFJYSStkV2FTbXI2Y0w3aExGdUZWUThoKzhVdnhWSmxS?=
 =?utf-8?B?a1JVeDZ2N2dhQmlmVXpMdm83RzVQclB2LzhIOTRUejV0YkoxVm9lYnJkekpa?=
 =?utf-8?B?VVRXdVlXMkNRMlRVMGF6U2xaaGNpSjZ2QVkwM282dXNNTTd3QzVtbGxIalNO?=
 =?utf-8?B?NGdPcTlSeDk3RjNZTzJJTmF6SytRTWp1ZFBVZHJxTkJJSlNidVBWSUxDY1BM?=
 =?utf-8?B?bnBHWGNYYnNSMlZ5U2RaQ1I5Q2NFNmZ6VGxQZzZ3Rkt4Yk5vNGphc1lESXRP?=
 =?utf-8?B?U3BTUFl1QzlYOFJ1cmlXNXJKQVB1aXJOM2lRdk1XdmlzSWdJdnV4NVJMY0xW?=
 =?utf-8?B?Q210bWM0OWF6TFJFMjk1dHVOOWZMOXRKRHNkMi9Gb2VHdTdBQWdFSE9PcUFI?=
 =?utf-8?B?RFZBRzhmZE5tMzRjMkc0VndtWGFvYS9qOFFocXQwVEFBanY3eUxTNkwyTXF1?=
 =?utf-8?B?enY5N1E2L0dRK2xMZkFMdHFPQkRacURrWkdxNDJnRmxERHVLK01VVTJXb0ph?=
 =?utf-8?B?RVcwaU5QN2Z1VHZYTWpPVzcrTkhTTjZLUSs2ckp6TmZCWGx6eVBTQUN3M211?=
 =?utf-8?B?NEhmbEpPWDBNZEFwaVo3a1FOck9DSWsyUWYxeWdEUmh4UlR3amduTDlXSVdP?=
 =?utf-8?B?YkJmOWsxWmVNZ1J2R3NVVktFeXVaaUhZaFNtcW9lZEttSSsyTTVkVDg1QURl?=
 =?utf-8?B?ZU4wYThLZ0ZzUks4Q3ZPR1ZOUG1yM3lCcnhLU25TMGJ3RzczTjc0SHdXNzJa?=
 =?utf-8?B?L1JoZWJHVnY0OWlvSEErSzh1Y1hsaXZZS3JZS0dhRDZoZm5GVzJNYTk3MGVi?=
 =?utf-8?B?UmtKSWxlTWVpZE1XQi9LYW1TdkRCMHhMSHF0U0F3eVZTSFJEUDMrR0tTcmxG?=
 =?utf-8?B?S3gwUUZVR01KbzE1NHMxM1ZGUHZxZ05wM2ptUW1yQk1heHZ0UUxGVWJTbkcw?=
 =?utf-8?B?OURQRW1EWXpFUDBUd1pNZTJCT2ZmU3hJYXpaUW1pbHlVbWtKZWR2U2RYSWd4?=
 =?utf-8?B?MUt5UXdjdkhSRTIwSDlKMTFJandER1MxWTAvR2Z3RDRBNUVET25nVm52cUp2?=
 =?utf-8?B?Z0o0YWc2MU1kRDdLeDU4bmE4KzJqOTlCWUU1eldDVFQ1ZTZmaDM4bVJNTFYr?=
 =?utf-8?B?aTVMM2xKSGFZZ1dQT1JlNWIySUVrbGY5S2Y2V0czV3ZBb1V3amdmMDc2bWFi?=
 =?utf-8?B?bGg1N0pzVEp3cjM4MXBnUi84VmVuM1ZNQUx4SVlHTmMzQUdVcmdvL0VQOEpV?=
 =?utf-8?B?d0tuN1NOUVYrWEk0K29YZTIwUEFUbS8vNUZsWDE5SUFYUDFva294RCtPTXVD?=
 =?utf-8?B?YkdTVTAyZmc2Q09jSmlyNXZFT0dYRWtwdVhKUHI5WlJxZXZzSWVEcWJISWdw?=
 =?utf-8?B?RlJqTnRqcEp6VDhVS1VzN1hrTkVhbENyYkVJSmIxRTNyb2lJd0pzSk15ZlJt?=
 =?utf-8?B?eTZmTTBNSkpzSTV6Q0dwcHZZRk51RHJzSm5vLzdKSDRpb0JZeUVDeVdpMGJ0?=
 =?utf-8?B?VVRQaHlLSXkrMUhvTCs3cVFxY01WTlErVFNROWMrVXkxdGZSUmNxYkZqdXI4?=
 =?utf-8?Q?lceWCQBnxGQFAbjY=3D?=
X-Exchange-RoutingPolicyChecked: Vv8iq5UdlWSOl9hNAFmKYse6m7q1x7090D77qkEamfbU61P8q0SzmzfglaBehi0CaZO/BWsOq7vhfdcgAfxPN3MV7zbdLX7zFXEM0Y5BEat/p6Onpp6rTvzmsQf3C87Ur0xz9OqSdDo5Z44DZMsGTc/QmvwkgTw8sMq3vcA8qfgxxcqacwTLre6Yzfg0c8LBhEBsT2BBDyTHWv0LHnxF1FaBtFBl611pxvO1XrOC8DqsGq65Z9w8VlVp8xTTuFykVWnCthsm9UAPJr4bYn1/oie+LNB80iG8Fsv14cy2pLn+D2Vo54rmhhWCFRGmpaWxwrdn65f7M4V2VZA4dlg5ZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4f7f61-9ca2-4f71-2f9f-08df3ab7f106
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:09:40.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMjBeUHcP3j4JUCR0JkUxpV3KIXDSwH6rDb9ekUeXYSRLgrY+ykrIDPt4L7kCBIXN39mpOLmgLWOvVEJLQ4wpl/v63RnJ+Kyhoj01xg+yEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB058488
X-OriginatorOrg: intel.com

On 11/3/2026 1:50 PM, Paolo Abeni wrote:
> On 10/31/26 01:54, Jacob Keller wrote:
>> On 10/30/2026 2:40 PM, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found more severe
>>> issue(s) in other patches of this series. This mail is only an FYI,
>>> in case
>>> you want to address the nit picks below when you respin.
>>>
>>> Low priority / nit picks for your consideration:
>>>
>>> - [Low] The loop in ice_ptp_clear_tx_memory_status_eth56g() (`for (idx =
>>>    0; idx < INDEX_PER_PORT; idx++)`, INDEX_PER_PORT = 64) only counts…
>>>
>>> -- 
>>>
>>> ice: E825: clear PHY_TSTAMP memory prior to soft reset
>>>
>>> This commit replaces the E825 timestamp memory reset with a sweep.
>>> The old
>>> code wrote zeros to PHY_REG_TX_MEMORY_STATUS. The new code reads every
>>> PHY_TSTAMP index on the port, and the sweep only runs from within
>>> ice_ptp_phy_soft_reset_eth56g(), so the soft reset puts the internal
>>> counter
>>> and ready bitmap back in a consistent state. Read failures during the
>>> sweep
>>> are counted and reported with a warning but are not treated as fatal.
>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/
>>>> net/ethernet/intel/ice/ice_ptp_hw.c
>>>> index 07b55fbb88dde..ef59b34ba52dc 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>>
>>> [ ... ]
>>>
>>>> +static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw
>>>> *hw, u8 port)
>>>> +{
>>>> +    int err, failed = 0;
>>>> +    u8 idx;
>>>> +
>>>> +    for (idx = 0; idx < INDEX_PER_PORT; idx++) {
>>>> +        err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
>>>> +        if (err)
>>>> +            failed++;
>>>>       }
>>>> +
>>>> +    if (failed)
>>>> +        dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY
>>>> timestamp registers for port %u\n",
>>>> +             failed, port);
>>>>   }
>>>
>>> [ ... ]
>>>
>>>> @@ -2311,6 +2320,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct
>>>> ice_hw *hw, u8 port)
>>>>       u32 global_val;
>>>>       int err;
>>>>   +    ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>>>> +
>>>>       err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL,
>>>> &global_val);
>>>>       if (err) {
>>>
>>> [Severity: Low]
>>> What happens here if the sideband queue fails persistently instead of
>>> transiently?
>>>
>>
>> On a previous version I got asked to change to this method because of
>> possible transient failures. I think this is best since these reads and
>> side effects aren't entirely critical to functional device.
>>
>> I would rather leave this as-is and not waffle back and forth about such
>> read/write failures that are entirely unexpected in practice.
>>
>>> The loop in ice_ptp_clear_tx_memory_status_eth56g() runs for all 64
>>> INDEX_PER_PORT entries. It counts failures and never stops early. It
>>> also
>>> runs before the PHY_REG_GLOBAL read, and that read is the first
>>> access in
>>> ice_ptp_phy_soft_reset_eth56g() that would catch an unreachable PHY.
>>>
>>> Each index takes this path:
>>>
>>> ice_clear_ptp_tstamp_eth56g()
>>>    ice_read_ptp_tstamp_eth56g()
>>>      ice_read_port_mem_eth56g()
>>>        ice_read_phy_eth56g()
>>>          ice_sbq_rw_reg()
>>>            ice_sq_send_cmd()
>>>              ice_sq_done()
>>>
>>> ice_sq_done() polls with ICE_CTL_Q_SQ_CMD_TIMEOUT, which is
>>> USEC_PER_SEC.
>>>
>>> If the sideband queue head stops advancing, each low read waits the full
>>> 1 second and then returns an error. A failed low read skips the high
>>> read,
>>> so this costs one timeout per index. Fast -ENOSPC failures only start
>>> once
>>> the 64 entry ring (ICE_SBQ_LEN) fills up.
>>>
>>> That could mean about a minute of stall in the sweep before the
>>> PHY_REG_GLOBAL read fails and the error is returned. Before this
>>> patch, the
>>> same condition was caught after a single timeout on PHY_REG_GLOBAL.
>>>
>>> ice_ptp_init_phc_e825c() calls ice_ptp_phy_soft_reset_eth56g(). That
>>> makes
>>> this reachable from both ice_ptp_init_owner() during probe and
>>> ice_ptp_rebuild_owner() during reset rebuild.
>>>
>>> After the later commit in this series, "ice: E825: perform a soft reset
>>> when starting the PHY timer", it is also reachable from
>>> ice_start_phy_timer_eth56g() via ice_ptp_port_phy_restart(), which holds
>>> ptp_port->ps_lock.
>>>
>>> Because the sweep runs before PHY_REG_GLOBAL is checked, its read side
>>> effects can also land on a port whose soft reset then fails. The new
>>> kdoc
>>> does tell callers to treat a soft reset failure as a non-functional
>>> timestamp block.
>>>
>>> Would it make sense to stop the sweep after consecutive failures, or
>>> on a
>>> timeout class error? Another option is to read PHY_REG_GLOBAL before
>>> starting the sweep.
>>
>> I will change this if the maintainers demand, but otherwise I would much
>> rather see my actual issues fixed than continue to be stalled endlessly
>> by this AI looping me between different versions.
> I haven't parsed the walls of text completely, but so far the saskiko
> feedback does not look blocking.
> 

Thanks, and apologies on so much walls of text for each of these... It
has been difficult for me to trim this for fear of losing too much
context in understanding (given how long it took me to uncover what was
actually going wrong with the original software logic and hardware
behavior). I've been trying to find a balance but I think these patches
did end up on the side of "too long".

The AI feedback also a lot to parse for sure.

> Somewhat related: I think all the changes here could/should be redirected
> to net-next as per Linus guidance. Would that be ok for you?
> 
> Thanks,
> 
> Paolo
> 

Go ahead with net-next.
