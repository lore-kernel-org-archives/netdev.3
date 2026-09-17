Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC751A13B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663610; cv=fail; b=HqqQ1jMtz8CHUHWWQLuH4021wJ4sJ4mcRZgak9qp29oH7CM6r5jAUFImhqVcqTRpbkil5W+F15vOFFgaQhQ/1pIKFQX7xiSXk+zFmejmJ72hgPr08NV9IrE+XTVy1w+vHoh/wNNnKvKBXS6cURM353VdAg2vLlO5/QfbLgTh5PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663610; c=relaxed/simple;
	bh=j395foNUTgHoXxEZMhpIcauX4m2ttYvwGWxKMEOdntY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DSnvZ5bHeLZ3EhBi90AyrO6jsduLVCoCsXcNXGcoF3d72pqaoBJOyphc/gyOymPEuWkRGF8nA/AIfOPygr0kd5rhc1lXhk1SC14F7PTPIggE5RmW7vuV7MwEmWJBQcDAI2p8lqpexa6gsz5onnAW6bLQDdPPbJTAE0NB7n9yC3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMULIa1U; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMULIa1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789663609; x=1821199609;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j395foNUTgHoXxEZMhpIcauX4m2ttYvwGWxKMEOdntY=;
  b=ZMULIa1UyHo3+dH9tP9LuS1zzGO3Gn7PnhKMwpT0VYN85z3Cg/aGpYXA
   PrtnuSDfc+tV22a5LZXy/eEQDMJZ92GuuAY401Mzmta6qCrLND1JApcqu
   JsxDIZnZGALq5T1iIFQwerMB/NZ4a9RGgR0NmvAco6XvylxfblvO+e0Jn
   6KCSW+xJdhCDYW5e69KVdFPnyC7RA6vxwq5zewVPneZaGNAB1IBhYyGfH
   wXNPTP9oV2sQQfXvq5I+jznPuIQJnka9iECr8zDZk7LJWUDtaGt3NMN30
   2RFpoFWsQV6MPEKpKurftYP9pz7KR5GvuPMAkXxua7EpPLolnuDxBm+xh
   w==;
X-CSE-ConnectionGUID: T3B9nT1IT4Gr4xO6p1AdHg==
X-CSE-MsgGUID: azrFWdBmR/6w8obLfXN6BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107612924"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107612924"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:46:47 -0700
X-CSE-ConnectionGUID: o0Q6Kn8FR3q4ezo/9Z9I2g==
X-CSE-MsgGUID: CuLwanLFS0GAzisNTLERCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2128082"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 09:46:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:46:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 09:46:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 09:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r68APlTfd/S8s8oBon5+fVagWEfdvkIWzIF+bdrr3jfiVeGpgku9ej+8Vg9fmjupOug/NnvzqcGmhBfLj29r1rmLANQa2RuclLa/xfkCYKUftd8Cw2/LXl3qdNRqvTwZYajtPWnrsQG4Lb7xL9Y0KfhJONMcgwh1Oxl4REXl8a5PF1hyBHY7JNGr51jLWCvN5uLegOq32JyVw7hQFLVeWfrd2nxocgZHlYXHzeTsLECaHQeFQGU7dporLzk4H9X6Pynn/4AIvph54DMIw6ph2+lRs1OB7uF/hXRL9pGg8SLjmyaw9yPHYjUxrZeZF0U2JaQSJaqrvddeRRLMFkrqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lb5V4DVip2PVBDDMAmJnlWUClUVa5oKquZPP9DnBE/Q=;
 b=ngHwWH9aZsGNfaJJKZd22tkhE5iQrloFNw20ZAQpNZ6g2S6u3ViM45RpOJDXaVgHrWPjM4HtfftEseuKb7F7XPHfeEO9k2KD9vnhJmGyElXnWTQflhdXwcN5UOvdHeho+D9A20ZsBzfbbxYzru13fM1XfQBn/2TIBsqHtxKZAgPmBtAnvtKKTzLpe0EVV0hN5YTIeAMjh7wiQHvSnwmIWrLEsPYHqyHgyiD+pgBQhfZG1tP0+5GWgUmyjt1W+HNseDr7bbcdwDvMdl1kF94LO5iuwXLL+OLJDhL7DW67i208K/0YIeaDptj8ogqzPJn1bdl1HZlJxjjpZESyQgqYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA2PR11MB4956.namprd11.prod.outlook.com (2603:10b6:806:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:46:43 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 16:46:43 +0000
Message-ID: <6374835b-84fa-4c40-85f4-2c5470cda400@intel.com>
Date: Thu, 17 Sep 2026 09:46:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 08/15] ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior
 to soft reset
To: Jakub Kicinski <kuba@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20260911003430.3386340-9-anthony.l.nguyen@intel.com>
 <20260916011220.1632615-1-kuba@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260916011220.1632615-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA2PR11MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: 16361b8e-c58e-4eba-6df7-08df14db40dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|11063799006|4143699003|5023799004|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: bvz5xBZc3ZjXk/u7s5FjD67Fj6duTty/s97vtZduXpvNFXkKDyN1XUFf+xF8a0FVYn032h2LXkewXk0DHk7+V3se5MdVRi7KuH77b9GTxGmWYArmqSGh/bD8NqvkhZh0zpiAtJGFHknWCI15uABp2FasEBDQoWlG7HOU7Yky4GIvNSJWWxOtedT84tZN87J5ZBbxRw6ICds2fen+wiBLxqJxwLj1X1vOBWopsouTEbyqwiGNUZXcVI/WWjd5RJifT+geVcK+UUaFsl9p5QFMpditrhC0aPDWQJd0YqGa+a68iX1vXwAigzkM8FPeWi37yHGY8Nbvyu2Ute/De0xKUq2qkmWBi+sFXV+RzDBm/EUSDi/TicSrOWggSZGD4aoKVC0YG5ExALQubF2IOMapj0p8jdyBZ9PNWzPlWEbXbpbq00EOf8aGTicTtCHkcvycWEEJfXj9sbVEyMy+43uHnAYV8AvKD+9DWDwZAyQLgrv2rnQ+TzCjSGP4vR1fJ5byb9sOLqULHAtDxKEBfna0nVfqvDDJ1a2q2r2G8PPJ7tIw4v5GaeRbSaYnzYH7xQJX2oGqNfDW5l634NnboGBR6B71aYmds+PqAdcudllBVofcH0dlx0DQkG0K8nwGElHIDz+nGTChj7JNub/yN/K2gNmKcxBt3n10PP8xNHAV9c4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(5023799004)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFVWa1FCSCtkVzZ3SkR4cVgvUXR4L0lCK1dWRGF6cU5ZeDBVRTNrMVM2UGJu?=
 =?utf-8?B?bXV6T3JXRU5obFlPYlFpOWRsdGlYeWd4bWFRRkhEMmxSUDE2Z0o4bjQrYncw?=
 =?utf-8?B?R3F6MXhPNTlESnRxcGZ2TmtuZGhQL2F1UGdUdWNpdVlJRmJ4dWdRK3luQlN4?=
 =?utf-8?B?OEpoZnhPNStXRjZYRWt2RGpJc0lnTnU3QytCMXB4eHZEK3ljc1RCclFjeW8y?=
 =?utf-8?B?bTFoc3NTNjZUVzZQT3pJTHYzQXAwUVRocVZEUHZMeVVkU1lUbnptWjd2UW9t?=
 =?utf-8?B?c2dzMmhtdFpWb3VLejQweThnZ3Fqdlh1SGd0QVI4TmRGQlc2TWJrSHhPVkNj?=
 =?utf-8?B?YkRSWExOWlNJWllGcmVEZ0hVQ2tMYkFuN1Y4dytXTkowTERxdzhYRFF1Q1ZW?=
 =?utf-8?B?QUdTY1Q2QVA2VFF3MCtIVmVkY0hyMGM1NHUrQjhxWnhGbng1TitnUEMxQW1J?=
 =?utf-8?B?cjBlcGJCdTFRRTJ0YThxNjZidE52LzRKMnMzUWVpZ2xKVnBrZ1EzVXVLOGl2?=
 =?utf-8?B?S2pOQVQyeklBMlBDVVNLVnFlVWxOelFldVMzVjZLeGkybHZlQ0VHQmFqejd0?=
 =?utf-8?B?eExkQ0N6enRtYWpzRjEwYWlpdVJTa2lWV2c3MkFxZENqK0h6cmpQbU8wd0R1?=
 =?utf-8?B?L2FJYUV6TzRtTHUzSjFJRTlmWjI5ZWZBRmkxblk2bzlSRHlWU1AzdjlTWFEv?=
 =?utf-8?B?MXJVODJjeDhPTnhubzFsNXlLV1FvdEY1RE8zQTNDZ1BFMkF0VUlmMFAyQ0U4?=
 =?utf-8?B?ZlhndjJzRW4vOERNNGZYQjBWNTlrbXJlMjhpRjgxSVNUNS90OHF5WDBVUXN1?=
 =?utf-8?B?NTBHR0VmQlZLcFRuRE1xNVVZYkMxRG5UaG9FT1E3QW1lTWJHOVNlWDVQLzVK?=
 =?utf-8?B?elV3cWJLNmNIK2l0SUxaT1gwbW5uR0NScDNoaUNmNTd6WHBETlBwaU5oZ0Ju?=
 =?utf-8?B?ZjJFU2tjUS9MYmp1S0wvazRWVHozakJLOTF4bmNQdW5Lc0hpbWVjdWVDa1BC?=
 =?utf-8?B?U3Z2WXpCcDQ3bkNCUkJaWWNERS9VSGR3WCt4OTRqZUxQSXA1UllLdzI0dmc0?=
 =?utf-8?B?U0tNV01Db1JtSjJobTBSK1BldmU1dmRWMjJmSXJVRUNYWVNpN1h6YldrU1R4?=
 =?utf-8?B?QlVHcFlpK1JRL3RaOVByTFRvTXN0QzhWWWhJMHAyWmlFeU45MGFpRk9FQ1hz?=
 =?utf-8?B?UHR2bGNpbG1MYTlWbHNKSkF0MklvVlhSKzM1N285N1NtZDcvcTJpSG00eWxD?=
 =?utf-8?B?VzdsaUxGckpybW5mNTdmSEVMV1FYZENnTUhUaDRGenVncnZiK0kxb1JQWkVL?=
 =?utf-8?B?cDJXb2M2eWZ4cnIyeVIwMTVaVzJIaGFockZ4QW1RNVQ2Um16ZktBUmZXMHA4?=
 =?utf-8?B?aXR5ZnFaUW1xWHRXZjA3Y1FEdStGbUpQdzZ6NEdramVMVFJiRHpqTklkVlNo?=
 =?utf-8?B?czdQUHBKVjNMZ21OWm5YV3hMOUVZUWUxS2dFQnYwdWI5TVovbW04QmpNeHl6?=
 =?utf-8?B?VVhjZXZndnNrNjVRV2VzMGFJNmo2UXhBY2FienVESUt3USt4Uit1M0w3ajk0?=
 =?utf-8?B?OUR4M3ZTOHc3TmNoVS9kWExOanZKME5Kend1YkRCOXIzK3dSZ29JNmpaYTJR?=
 =?utf-8?B?cis5MDV3OFk5Q0xaVTBTVnNoR1Nib3ZMVGt2dmNkK3FDbis0ZFBxdlVhOUVL?=
 =?utf-8?B?U2FZRnMyUklCUXM3K2xhQW1aNU1UVkxlQ29FYzFUUlNGbTZhcFNkRDFnY3BE?=
 =?utf-8?B?S2t5aWRycUVWTnlNR3ZTaWJzTDY4YnhGN3ZZaXh4ejNwT3QraGFzQlpoUE5S?=
 =?utf-8?B?TXdTUi9WU0hrUnY0K1FLRWVKanpPUjJsRlNBd2xPYjBoT2VjY1hSbVJwOXI2?=
 =?utf-8?B?Y25TN1pTREJQZTBaWEc0dnFteHE5L1oyZ0g5RTdXQ1l6QmxqWXhmdVZYL0Uy?=
 =?utf-8?B?ZVpDSHlEaUJMNU11a2JpSWd3ZUs3TzVyL0FjdWVsTVFtZC8vbTlZKy9nVWt6?=
 =?utf-8?B?K1NjS1U5MFRZaHp4MzlNSmNVYkRDUmhFNG1oOUFCZU4zcjVZa2VaQ1A0MnFa?=
 =?utf-8?B?WUlTNXVDRk5vV1ZpSm4yOHM1NnNTV0R3SlJIQm1Ebk5ZTG5idnR2SlU1Qk5N?=
 =?utf-8?B?VFllTTNLSTZ2K1RnRTJUbEFqZEwvb0x2V3RxeFEyTUFMM0dXMytOTWZRTVY3?=
 =?utf-8?B?RkpFc2cvOXRBUm1hU3JUQ2dlSjFic2ZUSlYvYTFnNnVmQ2FoVXk4VVZJQ3RH?=
 =?utf-8?B?R1lMMXFvcDRYTmRWVXpsWUlGZnFjTE81dmhqWHpTRENWRXcvWisxYlo5VWIx?=
 =?utf-8?B?aVAvNkJaUFpRSVVMVGhjMWhJd3BqbUpGRFp2KzNHanJtUzNLTWo0djVOakY2?=
 =?utf-8?Q?wEDxGldLEayQyFsY=3D?=
X-Exchange-RoutingPolicyChecked: MGfWaldGcRBHsfclhK0BGYKxOMgTm6NSnI8Fz2XTyxl02OfdE6Jo6YwBIJn6Lt844zEe2EobqY/vXt/2nf9srtPe3SX8FclL6wPNl624rbD/CIUeLUY01c0KB2onH9jXupQsrbDRzHE89IC6MUfYN027IF3tRYJI8QX9b9KMoXZhw8ap5UF6M94EMOWcNQil48Ul32a9UQTchfapmqeFHRrYmjX/pM0pDR59sytkFGlGSEd9Cw8vG1DHjT2QSLbNrySk7SGdsnlPLinA5qty583n6a1gufH1wOuPB29ExRBxrXl36uWOzvrbWNLUP4l1N3W2Dyf5SDFpx+c59lpOFg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16361b8e-c58e-4eba-6df7-08df14db40dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:46:43.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfbSd/G/iNAciLDKubiZh4s2GIKdqP8CceKvWUnQqwKJ1DRC2cQD3pha/mjkilhVGkVPc4wGV27XLS+bAJumWnEvVYqV2gmvl54IuQ3AkIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4956
X-OriginatorOrg: intel.com

On 9/15/2026 6:12 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
> 
> This replaces the register-write based ice_ptp_reset_ts_memory_eth56g()
> with a read of every Tx timestamp memory entry for a port, and moves that
> clearing into ice_ptp_phy_soft_reset_eth56g() so it always happens right
> before the PHY soft reset. ice_ptp_reset_ts_memory() now does nothing for
> E825.
> 
> Two questions below.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index d48eb3c618231..a3a9f7ce04d2b 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -1139,8 +1121,8 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>>   * internal PHYs of the 56G devices.
>>   *
>>   * To directly clear the contents of the timestamp block entirely, discarding
>> - * all timestamp data at once, software should instead use
>> - * ice_ptp_reset_ts_memory_quad_eth56g().
>> + * all timestamp data at once, software should instead perform a PHY soft
>> + * reset via ice_ptp_phy_soft_reset_eth56g().
>>   *
>>   * This function should only be called on an idx whose bit is set according to
>>   * ice_get_phy_tx_tstamp_ready().
> 
> [Severity: Low]
> 
> This isn't a bug, but should the rest of the kernel-doc for
> ice_clear_ptp_tstamp_eth56g() be refreshed too?
> 
> The summary above still says "Read and then forcibly clear the timestamp
> index", and the return list still says "%other - failed to write to PHY",
> but the ice_write_port_mem_eth56g() call is removed below, so the body only
> performs two PHY reads and no write can fail.
> 
> The retained line
> 
>   * This function should only be called on an idx whose bit is set according to
>   * ice_get_phy_tx_tstamp_ready().
> 
> is also the contract repeated by the exported wrapper ice_clear_phy_tstamp(),
> yet the new ice_ptp_clear_tx_memory_status_eth56g() calls this helper for
> every index regardless of the ready bitmap. Since reading an index whose
> valid bit is set is exactly what triggers the internal counter decrement
> described in the commit message, is the precondition still meant to apply,
> or should the doc say the unconditional sweep is allowed only when paired
> with the soft reset?
> 

Yes, I'll update this.

>> @@ -1152,24 +1134,16 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>>  static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>>  {
>>  	u64 unused_tstamp;
>> -	u16 lo_addr;
>>  	int err;
>>  
>> -	/* Read the timestamp register to ensure the timestamp status bit is
>> -	 * cleared.
>> +	/* Per the PHY spec, reading the timestamp memory location is what
>> +	 * clears the entry's valid bit and its corresponding (read-only)
>> +	 * ts_memory_status bit.
>>  	 */
>>  	err = ice_read_ptp_tstamp_eth56g(hw, port, idx, &unused_tstamp);
>>  	if (err) {
>>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read the PHY timestamp register for port %u, idx %u, err %d\n",
>>  			  port, idx, err);
>> -	}
>> -
>> -	lo_addr = (u16)PHY_TSTAMP_L(idx);
>> -
>> -	err = ice_write_port_mem_eth56g(hw, port, lo_addr, 0);
>> -	if (err) {
>> -		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for port %u, idx %u, err %d\n",
>> -			  port, idx, err);
>>  		return err;
>>  	}
>>  
> 
> [ ... ]
> 
>> @@ -1177,19 +1151,36 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
>>  }
>>  
>>  /**
>> - * ice_ptp_reset_ts_memory_eth56g - Clear all timestamps from the port block
>> + * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx timestamp memory
>>   * @hw: pointer to the HW struct
>> + * @port: port number to clear
>> + *
>> + * Fully reset a single PHY port's Tx timestamp memory. Per the PHY spec, the
>> + * only way to clear a timestamp valid bit (and its read-only ts_memory_status
>> + * bit) is to read the timestamp memory location, so read every entry for the
>> + * port (two 32-bit reads each). This discards all timestamp data on the port,
>> + * so it must only be used for a full reset; callers that must preserve
>> + * in-flight timestamps clear individual indices via ice_clear_phy_tstamp().
>> + *
>> + * Due to interactions with an internal HW counter for the number of
>> + * outstanding Tx timestamps, this *must* only be called as part of the
>> + * ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal counter
>> + * may become out of sync and prevent new timestamp interrupts.
>> + *
>> + * Return: 0 on success, negative error code on failure to read the PHY.
>>   */
>> -static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
>> +static int ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
>>  {
>> -	unsigned int port;
>> +	int err = 0;
>> +	u8 idx;
>>  
>> -	for (port = 0; port < hw->ptp.num_lports; port++) {
>> -		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_L,
>> -					 0);
>> -		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_U,
>> -					 0);
>> +	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
>> +		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
>> +		if (err)
>> +			return err;
>>  	}
>> +
>> +	return 0;
>>  }
> 
> [Severity: Medium]
> 
> Can this fail-fast return leave the internal timestamp counter underflowed
> for this port?
> 
> The reads are the side-effecting operation: each read of an entry whose
> valid bit is set clears that bit and decrements the PHY's outstanding
> timestamp counter. If ice_clear_ptp_tstamp_eth56g() fails at, say, idx 30,
> the decrements for idx 0..29 have already been applied, and this function
> returns before the soft reset that is the only thing which re-zeroes the
> counter.
> 
> The read path goes through the sideband queue:
> 
>   ice_clear_ptp_tstamp_eth56g()
>     ice_read_ptp_tstamp_eth56g()
>       ice_read_port_mem_eth56g() -> ice_read_phy_eth56g() -> ice_sbq_rw_reg()
> 
> so a transient sideband failure is enough to hit this.
> 
> Would it be better to log the failing index but continue the sweep, and
> still drive the soft reset before propagating the error?
> 

Yea, I think that makes sense.

>> @@ -2306,6 +2304,13 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>>  	u32 global_val;
>>  	int err;
>>  
>> +	err = ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>> +	if (err) {
>> +		ice_debug(hw, ICE_DBG_PTP, "Failed to clear PHY_REG_TX_MEMORY_STATUS for port %d, err %d\n",
>> +			  port, err);
>> +		return err;
>> +	}
>> +
>>  	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>>  	if (err) {
>>  		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
> 
> [Severity: Medium]
> 
> Same concern at this early return, and at the two error returns that follow
> it. Once ice_ptp_clear_tx_memory_status_eth56g() has consumed entries, a
> failed ice_read_ptp_reg_eth56g(PHY_REG_GLOBAL) or a failed first
> PHY_REG_GLOBAL write also returns without ever asserting
> PHY_REG_GLOBAL_SOFT_RESET_M, so the clear happens without its paired reset.
> 
> Isn't that the exact condition the new kernel-doc warns about?
> 
>   * Due to interactions with an internal HW counter for the number of
>   * outstanding Tx timestamps, this *must* only be called as part of the
>   * ice_ptp_phy_soft_reset_eth56g() procedure.
> 
> The error also propagates out of the per-port loop in
> ice_ptp_init_phc_e825c():
> 
>   for (int port = 0; port < hw->ptp.num_lports; port++) {
>           err = ice_ptp_phy_soft_reset_eth56g(hw, port);
>           if (err) {
>                   ...
>                   return err;
>           }
>   }
> 
> so the remaining ports get neither the clear nor the reset. A later
> successful soft reset would repair the state, but should the reset still be
> driven for the port that already had its entries read?
> 
> This was checked at the end of the series and the fail-fast return and the
> early return here are both still present, so no later patch in the series
> changes this.

When paired with a soft reset, readings only purpose is to ensure that
we have a cleared memory bank after the reset. If the rest of the
software is behaving correctly it shouldn't strictly matter if we left a
state bit or not, because we shouldn't be reading it. The logic is
supposed to ensure we do not read the register until we are certain its
already been overwritten by hardware. These writes are intended to
ensure that we've cleaned the state properly in the event that we
somehow have another bug that triggers such a read. I'll try to mention
this in the commit message and update this to log a message but not
produce an error. It should be non-fatal.

Thanks,
Jake
