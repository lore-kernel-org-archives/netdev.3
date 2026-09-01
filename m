Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E92F3C18
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266495; cv=fail; b=JSqr4Ygav7y9yuTaHzuWkJJO0g21yk773BEWN8suriSzv69+zRGjGtCF1IdHXRJollhNbgqJ8y0/aE5oKkBpqzIib85Crxeb0e/HGPFSCG/VUQrS28RdZynhccmiOHizGMCMW+H7nWhGm1Q22HUNnoshg4THTLeJ8lvIyA8XHWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266495; c=relaxed/simple;
	bh=4zYRdq6jGGm1rJcnFmhNYOAUTA30/pablK4AoPSc3Io=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LvwJyrmdiB2/3v1kIxdHGdLTQqKyFlRWvDHthwJSaSq4f8U+hzWFW/ye5UL35yuns5dxBHF2LHC2tauvlNh/IIjA+yc+iVYPJ0S1BiRz3+7OU12q9qNn/pgWNZgfCuvyBBawEGJs3oI6oqir59lEQObVxr7TQC5D4mo7vs6VjJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FCrM+j6O; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCrM+j6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788266493; x=1819802493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4zYRdq6jGGm1rJcnFmhNYOAUTA30/pablK4AoPSc3Io=;
  b=FCrM+j6OnK6SAiOOWqQ6a/kb+EhDFSmn9fPMBlsUmJ4+CT4GQOxwENTv
   IoefHWJDAB6Pi2j+89SvxhczlboyC5VK5rs90R+16SX1IZ0mgUazBnspU
   pkhTR/pNxXE8axdR7N9x+i4jnDvbyjGfHeNjX4kgsL7zQtfm1RWqPLYtN
   tf94lx/oxUaQ9OyBQ22SYX0kveh6J8c6C9Z2WwHYEh6eQSk6YKFhWygdb
   JL6ckQvRUE1Wu0gNMvKVlFkfbqe4nYPPk9SCs/xD5JRhEho6tnV5a4BBg
   ohR38B37gMupv7pcDka+eHglNyGNt9aDkTXGuiXP8bTFm4OusDGv8JFcG
   A==;
X-CSE-ConnectionGUID: NubDG3/yRumBZatd41VrLw==
X-CSE-MsgGUID: dTYjEURfTwy99M3k9NbPMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99853669"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="99853669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 05:41:24 -0700
X-CSE-ConnectionGUID: ebTu0NBER4qwmBALPmhydw==
X-CSE-MsgGUID: R62VWQirSzeuYbYMMvNIkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="293921064"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 05:41:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 05:41:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 05:41:23 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 05:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEpUeHJI9azFJ6TBFRV2SGbXI/BcWe5s4nBOCqvjIHRY3ZGYapjQW7CLl5bkhLMXC0AnhA0TgnC937PhKLyCHc5kRw1I8GktQXGeBf75pXgY4eL8oUqcPphI5cp2ze0C4FkeuUEFUoBG1vlE4W/NjrSG56O09hqkpfsqsedL3TzB0TDjyL35GO0pSPFsGNLdevkILsh5dZo+xOR2HEzp3eNgzK69fTIp87b7Ex01DhN/pVLKxzl/jHgzWYe9rBq3nSZJjISujRyiVgNh4KOCtgkrrk/IEYbTCGWhormEM9GCvuhPJ0f/vXkS2OFPNa2DthS8twQVgPExZh7QGTE2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4G4cgi+8vs8xfoR5aQxsAFdVHXfm1TzR/WG8az1H0U=;
 b=twYOeQmwSJyahf5j8Jj+k3oAna2LxlUEa204Lbf+Sp+WXboOh5braeqRVpVgfFmDRE/7GeAPNDyb7AtnLBD1M+bSl/XP+O/OTv2aeRryKt6l2Zd8zy7dUCAgqu2u45QYPiHALxCidhgt1I4INW1COxYSOIECX8x++eOVlHYiHcIDHhJjkssX64Fiu8Ckrn1HVc6YMr3REjf+hXeFJcZwlRReOvO71dajHWgk17jM8zcPufD5UQQDA4gMPP2KKPFdE1uU0A+AfQG/TUPmAPZYgch8gE9ZgugWziBEHFQtOrIbLtpyF2Ab+QpnBAoc4zx+uWZV7pZ791M3Vcbn8KyyYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by BL1PR11MB6003.namprd11.prod.outlook.com (2603:10b6:208:387::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:41:17 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:41:17 +0000
Message-ID: <db7fbcb4-743b-4ae6-9893-0e09caca15a9@intel.com>
Date: Tue, 1 Sep 2026 14:43:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v4 1/3] ice: Convert ctrl_pf pointer in struct
 ice_adapter to RCU
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
 <20260831161100.216773-2-sergey.temerkhanov@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260831161100.216773-2-sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0126.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::7) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|BL1PR11MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: ec500ca6-2df2-4ec8-b422-08df0826512d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|4143699003|10067099003|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3teOKJ8vSMNbcR+xT9cPLBGwRWLTuk6CjgomvV0nNb0gkyTgMlYW1fcrUq7toXufNHWAfiT0+gUYQ2WWFiQUzvIB+F+LUVZsISjtEA7676q4kQpjKHqelC8lU1QNZd2PrGfj60ethdg4BvSRNugi/VUuYTG3I/oMsVdXHLJ4RHRhaDLIYA/KV5FkK/7IaaiPjmUsrZNkiaq/DWFqDMmZCUOi08Wfjt7TVTGLOrNBGcOHFhKdN3xnipYS/+IIBuS+CGK0qK0ykYLWOxZCpmLod8C5Gr/xrPptZt3+xyWywybLLLnWMrLSCLXMOqchmGd9DaQ5Q3xBjoLNcLqqQc977hyVFzHgh2kFjkWmO6FLb5NZ0X8XZ6WH1v8OVwSL1qraxLWDO3X5TIlMnG+7xFBHvC3egrwJv+9tK42s0mCuDRtIB0CS1LdTOLvBqRp7zA/824GnPE07RCwkG+2XR0RXvGrwoo8owB/GVCF/B34vXH+upbefWjL6MoFZG3Z+5skNuc+dyOec49UomAgwlwhEMf+QJhyb+QYLrjoqa39xf3itaRaryMlgPVdIZfg4A31qrbl0ZOna6xkPxVTowECit1wI9yUsBSlzm2F7V6tlKtfjFSxvAICFqSgxXtF/KVXdDA1orcPD9AiN+cu8ebOueQQnxMO859yfEwMCgFL4J6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(5023799004)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjUxTGZ4YlV1ZzdEQS9Db1pWbVgvQUhtKzJpL0RWTlJPS29VNGo1dVA3TGN0?=
 =?utf-8?B?UHpPa2pSdkQrT20yRGJTMTVNcmV5aG5zeUpSY3gzM2lsci9BekJRTEF2cVZB?=
 =?utf-8?B?NjdkVXUwdWlDWS9pZjN1OW5wSTZIR3Fqai9yeTRFSndTTGNQSVZUYmRIMnNK?=
 =?utf-8?B?RGxEdXRoOVNoYjhLeGI3WjA3amhnYU4zejltTFdNc2ZVQVdUTVEzT2diYVF6?=
 =?utf-8?B?Y0VuMnI5YlltMGpZY1pVU1ZrSlIvU3BxbURlOUFheW1Bejk3Nmwxa3Z1amNo?=
 =?utf-8?B?MVdLS2VGeGtQUnZGTkFPdldVTitlM3NVand6V0lHZnhUdklIR2JiN2I0N3dD?=
 =?utf-8?B?cDJ2ZVl6dG94aDlFYStTR0w1YjU4cktaMFMxWkpmazNEcVR0eGF2bitHU2pB?=
 =?utf-8?B?Nmd0S043UWZrZ3IwbFozWkhPcTE0bDFDV1kvNnFuZnhzOXJxZG96clYrQVR6?=
 =?utf-8?B?djBVeXYzTUdKWFMrNFJiMkVRTU9xaUFhTkRGU0hGbE1CT0U1Z1docXk2bEZy?=
 =?utf-8?B?dFFKR2dyQnI2SXI3djB6T1BJOUJtZUFsQWhMTnR4bmZ6UjF0d3BWOXppTUpj?=
 =?utf-8?B?TldodldNd3BZeFZPbDh2c0hBYmxGMG0wYlFVdkJWMWdlUGI4QzEvUVpHTTNM?=
 =?utf-8?B?OXBiNEVUQXBzVmdtQTBqSElrMUhpNEVQQUNKSGRkVG5udGxxcStudXVWZlMy?=
 =?utf-8?B?Ulk1VVNEQzJmZkFGaWp4M2daNUV6cW9tN05WR3lETG5sVmxtSXM1WnQzQ0Mv?=
 =?utf-8?B?bisrRzQ1UzE4RHkvNGRya0M0N21mS0RFNGFKK1hvL0VFNjFDR0dEZHJ6dEI1?=
 =?utf-8?B?a0Zqd3pkaVlhSlZ2K0swUjdqbklsb0ZZWjVNUGdqZDRSUFJFUU1NYUVJRmls?=
 =?utf-8?B?bTBDNGlYZnhFbEdPSmp3YU9DOGl3c0xyNGNLbFV1b1NIV2xHbVV6YjA1VS9q?=
 =?utf-8?B?SmxFelkyL3dtK3RtTFpHaUt6ekpTVExYejJ0N2RCZ0pMNXgxWmNXV2g1VDlJ?=
 =?utf-8?B?YnBHMHFRVEw0dlJ5Ni94c0JncjBtZ2JObzVUdURjbUFySmVlcXprTVZmbFQx?=
 =?utf-8?B?VDM2SCs5ajNTYkpTT3lDeUxZaE9TcDBlckVTbXhFYXJRbGExNVJ6NUlRTWZi?=
 =?utf-8?B?a3RQeGZxbW1zYXNobE4zdTdNblA4d21DdWV4c3FWL0JIZ3VUZXo4NkU2Z1dB?=
 =?utf-8?B?MVBQeGl1NGdnUWQzaUNoeGEwK1VFTGtZSHBOdUJmdWhlMlN3ajhhbU9nbnpz?=
 =?utf-8?B?M09UQ1hoOU1kRjZMdVE5aWVXeG5wMlI0R2l0Zkc3L1VFVWg3S0dFR2N2VFJJ?=
 =?utf-8?B?L2cvaGsrYkQvRSt5a2NzNFlKMVNlajM1MTZNMDJQNXhCb2NjaGx2YzdkRVov?=
 =?utf-8?B?R2REeklqUHJ0eTJBcjFadnhybnVlY1VqOFBLR2hLcWhBWmVBY3Fuc2VPbjA0?=
 =?utf-8?B?VDFBRC9NaHR3UE1zMk5HYUNmSm9sd1ZITDFxbXNCQm5pNjlnRWtVR0hENDJz?=
 =?utf-8?B?bnBJbjZrTVBpSjBTQndpN2NSRHdYR3BYOTl1NnBjSzQ0ZjRqWWxEQlNqekpC?=
 =?utf-8?B?OUU2dktEM3pQTEN0S0s1b08raXJ6cHR3cUVqRDhKOGZRQnA4SW8zWmlOUDVX?=
 =?utf-8?B?WUtZMXlJcTlra0I3d2pDNlBoZUxmSzVPNlgxS3hHQUVOMzdLN0FUWXpiVmdB?=
 =?utf-8?B?Z2kyVWFvZnBDRDZkM1d3Ym5vanBFdTM4R0Jua2hoSlVxRndNeXdEaXpFK09q?=
 =?utf-8?B?aytPQW5DNSsvVG5JNDZST0c1SjQ3RzhTQUdNa3g1STB4SjQwekN4SXZUc0M5?=
 =?utf-8?B?a3g0bTZmdFNUUktPZXh6bWZWQ1MvWUhSMGdERUp5ZFlrWEVuSHI0ck82KzNU?=
 =?utf-8?B?UW5VRU82RzZiS1FyNjdZMFpHbVlReDZ4R0tFNDB1bFRqaG8weWpUQUYyV3lo?=
 =?utf-8?B?Z0dLd0FpVUhiemlTT1Y4NWJSWlFWazdDdnVFL1Mrb1oyblBuNFZqZGdaSERz?=
 =?utf-8?B?bVorRlpIUW8yL0tGY3VPcGltekJTTFlzRnpNWU96VFBpU0NEYUxaNHhwQ1dV?=
 =?utf-8?B?cmh1N052eWlCQUgxWmR6Vys0ZE9SSTZ4cy9OUU8yNUpyN3hPNmVJK0NJb201?=
 =?utf-8?B?RytRM3draktwZTVUMForY0xWRmptSU9WU1UzenRIRGNXWVZMS0FrUTNieUJ3?=
 =?utf-8?B?N2tDaHRkSnY3S2pObHJJZ3VxeDBLK1QzcXVKYXhSUGllQnVXbUpsR21RQ1A3?=
 =?utf-8?B?QzFxYUs0ak02YkpZYzNET01NZ1VRYkU2RXFLWkM0TGU3Qyt5RzFFWldqOFFy?=
 =?utf-8?B?WExNemZWN0V2RVZBM256WklYeXhPNTc4TUkxcWIxSjNsWEFGZjBuUllsV25s?=
 =?utf-8?Q?IFqdkcE7wIkrtiIs=3D?=
X-Exchange-RoutingPolicyChecked: rYBZl2JWsBURYkiAH2GOyqnAJG+BeFQ8u9WbolGnVewCNM4L+jnBD89RJdVsaVQR+5zg8dVwK6xub2q0vxgZS1f9icKphdZixQHdnsoAlydaiGmqSRKrGqcDaf0IfnVPkoX35+M/FFlsQcmOTJzDK4zhumTiMInB4XdNri+77Cb1Krn0r7qlfLlTgWwkNEtKkGAWR/f2Zpt5l1/gerJSqrbvSV4xhzw1mNusOvk+HF2k9XGVunTZJgRq5WV89v8mrQi0RT7ndAftIPEZ6BRgW3/F2zDa/W9P5EEtMrl3Ytm0mWkzpDs9iAXcuq/4cnMeOv5izIxlSIcmNbNCGQm9Jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ec500ca6-2df2-4ec8-b422-08df0826512d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:41:17.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vP54Vlw5b0DXXG8wzkJgAQIQUvXht5U9tLV7sI/THnnH2r5ueyYwd4eFJaC0QOxps2AX+AQ1CfiqYYqgwTQvEy1X7rVqvyN3Z7X1jXVhGwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6003
X-OriginatorOrg: intel.com

On 8/31/26 18:10, Sergey Temerkhanov wrote:
> Use RCU to ensure the consistent state of the control PF global
> pointer contained in struct ice_adapter. Enforce RCU usage on
> the callers.
> 
> Fix a potential invalid pointer return due a TOCTOU issue

this is rather convincing/self explanatory
but the rule is "Fixes tags are for actual bug fixes, not theoretical
ones". (same comment for other patches).

Would be best if you could describe how to trigger the bug.
Or just drop the tag (since you target next- anyway).

> 
> Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Tested-by: Frederick Lawler <fred@cloudflare.com>

[...]

> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (C) 2021, Intel Corporation. */
>   
> +#include <linux/cleanup.h>
>   #include <linux/delay.h>
>   #include <linux/iopoll.h>
>   #include "ice_common.h"
> @@ -335,6 +336,8 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
>   	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
>   	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
>   
> +	guard(rcu)();
> +
>   	if (!ice_is_primary(hw))
>   		hw = ice_get_primary_hw(pf);
>   
> @@ -353,6 +356,8 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
>   {
>   	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
>   
> +	guard(rcu)();
> +
>   	if (!ice_is_primary(hw))
>   		hw = ice_get_primary_hw(pf);
>   
> @@ -2004,6 +2009,8 @@ static int ice_read_phy_and_phc_time_eth56g(struct ice_hw *hw, u8 port,
>   		zo = rd32(hw, GLTSYN_SHTIME_0(tmr_idx));
>   		lo = rd32(hw, GLTSYN_SHTIME_L(tmr_idx));
>   	} else {
> +		guard(rcu)();
> +
>   		zo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_0(tmr_idx));
>   		lo = rd32(ice_get_primary_hw(pf), GLTSYN_SHTIME_L(tmr_idx));
>   	}
> @@ -2173,6 +2180,8 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>   		lo = rd32(hw, GLTSYN_INCVAL_L(tmr_idx));
>   		hi = rd32(hw, GLTSYN_INCVAL_H(tmr_idx));
>   	} else {
> +		guard(rcu)();
> +
>   		lo = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_L(tmr_idx));
>   		hi = rd32(ice_get_primary_hw(pf), GLTSYN_INCVAL_H(tmr_idx));
>   	}

guard() looks well suited for your use cases

> @@ -215,15 +221,18 @@ int ice_txclk_set_clk(struct ice_pf *pf, enum ice_e825c_ref_clk clk)
>   void ice_txclk_update_and_notify(struct ice_pf *pf)
>   {
>   	struct ice_ptp_port *ptp_port = &pf->ptp.port;
> -	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
>   	struct dpll_pin *old_pin = NULL;
>   	struct dpll_pin *new_pin = NULL;
> +	struct ice_pf *ctrl_pf;

RCT rule counts whole line length, including assignement.

>   	struct ice_hw *hw = &pf->hw;
>   	enum ice_e825c_ref_clk clk;
>   	bool notify_dpll = false;
>   	int err;
>   	u8 phy;
>   
> +	guard(rwsem_read)(&pf->adapter->ctrl_pf_lock);
> +	ctrl_pf = ice_get_ctrl_pf(pf);
> +
>   	phy = ptp_port->port_num / hw->ptp.ports_per_phy;
>   
>   	/* Hold txclk_notify_rwsem for read across the entire critical

