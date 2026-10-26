Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793015215;
	b=T1b72S3MDwJG82/MMMX8IhPHcoc06/PBpQd1gLbKX4GKsw9HGzt0p1/UdioQyI4CL3lE
	 2EKn7berhmsClMeglHuZsl6Mlvn/NdK4hayPj3mPfuPyODskFD0iA1v+CTv4A25jPoeJQ
	 B0TEnxducH/PMkYyun6Ybe1YyOl4AOMX3jsUXxHNJ5g2CxGHhlnixvxzwrr8xLuI5RVVi
	 CDrtFm+Ay9P2YbHFgL1taPh/cECjyhGMtP6miFqfXI/50omMQjwzl8KviAX4fN3YAGUwk
	 6X5U7OVTOynXoT4maN1K5zCdgDQoj4TZdDX8SokuhSjGcbvOH4tOzsYCex7K2JslvFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015215;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Ws9ZlZWiEW8fKpDIwlD/1DmESaGz9GGY03MtT1NMHPY=;
	b=CX9n/iu81a/MBi63rJhQu9N1bx0gFOE+UL+6ZDLhK2yP1unEFADWjstibQ1qm0Nc+TQN
	 yBYtaPlz2WKvj6jQbKW8ZM6krV6H0Xa7lRJSs38ZBrO9/EhSplaLMIyHvW//35G1yINCN
	 mYQiiBsqfOppOfhdNvPlh3H4EdaIKSlT74ujcoxlgBRYv1KkEk3v85J/jwVant8wlRsu3
	 jPjaapKVKXv4bwgenYAw5JRiGh/TU1wy4lj3PdScQj6E6gARk1g1i97q7TAK3WYlf0ued
	 3JbNz5IN1zOiheZkVN2lzlSwqj4Js0iAIt/xKHnYE61t4pCiM4y5eq3FmLjU/M6dW9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0mjAEET;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D16606A32E;
	Mon, 26 Oct 2026 11:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D16606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0mjAEET
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793015213; x=1824551213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hKC3GIijU4NZbDA6tE9n8xaNzJf+w8RiZWZC+RxVPGg=;
  b=j0mjAEET6zmVy33qIQl0QmeebAzWQsdttwIO8ctwk3g9lkCJo0UoTNz0
   APVHI0ZM6YDQ5mocCewdK2r22JOEMtQLTlCywaQjqkqtAKFQNIygjfSnc
   XjtyymqI66DXb9iQBBiJivxmsWG4//KB9yfSeHixRPJnTlCNCrv36TxZz
   u9BgjcD29PA0c/WjAAkwrUoUtfCs3pviicMF9FewLnJwchGI7/AfRJdfT
   B8mRsoK29a+hwUUnZza9JXedEzYRbZ/4cUAUSWbfAOnXGFO6ufYDvGF2g
   XJQKaTTzWMwHgFATCmFmP9Q+KrY3dhlT2HbqLLIXxGViXxA7U6JoF2W8C
   w==;
X-CSE-ConnectionGUID: /csnf6EVRH6lNPbljosg+A==
X-CSE-MsgGUID: qLOcEFpVRa26zHj5WVJR0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1689562"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1689562"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:46:52 -0700
X-CSE-ConnectionGUID: YOk829T4TASj2+SSCLrGyg==
X-CSE-MsgGUID: XT/a8vkARXqBFCmyl/xJow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4149573"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 04:46:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 04:46:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 04:46:51 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 04:46:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n26mmLMTXnFQW0+sG5FruNteBF7/RVS45zL5NPZvURaDLLBIlggzac2T46TZbXnRVPZXAIZAB8UmML1gRI0jZs3/JnvZZaFtOZfktjhj0JWYQybIRju3pXO+l5Ez/VCVCNn/kEMYFiBwDpo8ZkKc7azXF1GMFdMn47ICd93fsc0RRgZ2YD1/5Gl4lG9b3mY7KReGvXfM3G+iPv8nLiVgJTbu6p3JtHRmxrJPnZYeI6/8gh2IXy9mXwZ3QfOXcDVhoi1wGds2uLlsHmtMUcbRmwy3qxL0L2LihXI8KSxm0OvdM0KT7OjzQryQyHooiqThxGW5y+MwObRbYlAjWbnLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws9ZlZWiEW8fKpDIwlD/1DmESaGz9GGY03MtT1NMHPY=;
 b=KoCkRg3C15SFfb8C9bAcNhs2eRymzOZpwn683gmqIPwdSsKxLXvT7kGDMnDSLQl6Dv4JvK7ICDDqFrw04P79HxRzeq0Ac895eQTaS63aQdiITOcGI/F/0rscmA8QjvhSZZEU9UkuOFbiW+/7GnCpLGbC4RqgQgrcZyfnON/j7+fdxy7v0xDAagzMRsfKUyuMPUjeWqgRS4ZtRefAml3DzSTSDvWWJUVekP3t8H9+UVT3qNi03pzYtT6TlMqh0oizLXu+ySdd9mBZ9MLQPFgqOojO6bPTvbtiUt42Casubd/dsjYh6/YuHXkNeoMUnQ+0Nq3j4nbCqAN4qB8iGuAozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8)
 by DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Mon, 26 Oct 2026 11:46:47 +0000
Received: from PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572]) by PH8PR11MB8013.namprd11.prod.outlook.com
 ([fe80::26a5:58f7:7e5d:5572%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 11:46:47 +0000
Message-ID: <7950cdc8-d896-4ee5-8e1d-2a1b96373971@intel.com>
Date: Mon, 26 Oct 2026 13:46:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/2] igc: Fix Tx stop threshold to cover empty
 frame descriptors
To: Benoit DE RANCOURT <b2rancourt@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Vinicius Costa
 Gomes" <vinicius.gomes@intel.com>, Sasha Neftin <sasha.neftin@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20261004152840.61222-1-b2rancourt@gmail.com>
 <20261004152840.61222-2-b2rancourt@gmail.com>
Content-Language: en-US
From: Avigail Dahan <Avigailx.dahan@intel.com>
In-Reply-To: <20261004152840.61222-2-b2rancourt@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To PH8PR11MB8013.namprd11.prod.outlook.com
 (2603:10b6:510:239::8)
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8013:EE_|DS0PR11MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e4b809-cd8b-460b-7cc6-08df3356d054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xU6+9fxW4sFCxtGQ/iq+YVqWhmTLFdnBNQCLwbo0a02ly4QNw1rZnCbqswAaCqV3WQH8En+HgMjVQsiDGuNgr2Ul3TAtjKq3UYL2MUaCcxZ1tDhMPQetvmAHYC/ETxH4B3Z3/3yrCGUrSht8FsrU3IktjGZzaDNXyKX5NkLeNolFFHFhPaPjZyJIAJG4xbzrwM4hez4Rvjjq+KYhQnDdKNskNVGgh2Qhfe9V9HENlrUOLk5RpaRyfBmVi2wMvJuzI5mMCpJjokX2IvBaNxyf2V3kMOsZ34n+/Et1IvnxRNVgk/ZTp1duH+/S35WSsC8oTrKJFOVcNygCcQAH38ic9nf8Ky1/BVh+ZqDZZssjaeQxhqqluRvaC+0edqcH+NKAcyQeD+FHTf4AODiOX3cSz25R7XsmzRHtDRiLQs5KQmzUn2nD7OeMBsJl+jhHBiF+ASdCs1+952qOBW7oVtgcxdEn3vx6J0J9ZBLATMl0pGbLP0hYGk4fyIlE9MzFlJ9kNC62/vnGf9rS2jyvTnU5t7DRORr1pBUxPSySRaEle6fQRgolvx752pdLx0xjehXN6x2vm2de0B3uiwgO6s/7p83yVrbDHQ1KA8CQWpAtj6kd22hqW79UJbGBe1naINAFsQMSfaxq7NTogaNgrXmuCBoNqIATx+ZRII/+u0fe1/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lsVWtMTnVhUFZRdTdsR2p4SGxLRThmcWpka3NoM0l1NHpnU1dCdEJQcVdv?=
 =?utf-8?B?N3BtaTBkZzl3VlRDcitjemlhRlU5bTRPaEVTdGU0NVIyYjkxU2t1eFBSSFMr?=
 =?utf-8?B?OS96UW5TZmRrTXMrdTlmc2JEYW5xZS9Ub256RUJTUytwQ1BnSzNjZFl4Ui9P?=
 =?utf-8?B?cjFHUjdzRlU1ekJQYUV3RTRmMGtGTXlQeGdQMDZrUXNoVlZINmNoS1AvbVRj?=
 =?utf-8?B?OXdNVEJGdXhXbEttM1lEU3h2SWltd2JFTFoycmdLVTl4aDl5QUhhU09sOXdF?=
 =?utf-8?B?dGNkQ2RZKzB2Wm5QV2xtZ292dGpuMTNTUjNoaDQvRWxTRlVsQStpOU5SLzNy?=
 =?utf-8?B?ckxhblJibGswVlV1VmVvdzNHL2xKcDlvc2Naa202akxKcU5PV082eWhkWmpn?=
 =?utf-8?B?Ym0xMVZaSUFnU2QzVUxKRkxMT3ZLOXRpdUZTUkd0TDVsVUJ5SUpTQyt5djd1?=
 =?utf-8?B?WlZ0Y0R1TGtDNVJwcDZPb0ZSZUZTT1VBLzY1c2VLNTdiNGNyOW1xdDRTejk2?=
 =?utf-8?B?emVRTUo2aGx5NkxIb1Z1aEkvOE1CbU01bytpTVVTdkNoU2tzc1RLTlhZVzVU?=
 =?utf-8?B?Q2FiMGFjSXVySkpOV2FDVDBTeWE0RFNNQUtNZytUM2dOUWJGK2FLTlU0czJw?=
 =?utf-8?B?ZS9yWDNMWVVxSnBsNHZJQjI2djk5Q1ZXL1dFUG1OcUt5MG5VMCtWZVR2V0Q2?=
 =?utf-8?B?TVJId0libVo2UCt2bGpyd3FsZjVuMmhLZzIrNTBudXhDWllMdzRrVlhzVGlK?=
 =?utf-8?B?Z0tDTGdNU3NHM2xpT0diUUdQSjlhbkgwRnJHazJZNXVWYWtMUGhCKzIxcVJv?=
 =?utf-8?B?WHFHNUd1eElyZXdUWmJhdmRxbUF0bFJPR0pvTHJEOGRCanlWU3BhZ0hRRE9m?=
 =?utf-8?B?WjZqZ2N1L2Q5bjFrWEU4dWRobTRyL1QxVGptN0xlc0JrM2NueGZVQUlVWUE4?=
 =?utf-8?B?WDRTbmRONkFZUVAzc1Y4OFF4bEhVeS9vdjloYWtJRWVYTGQxOWQxMW9aWTU0?=
 =?utf-8?B?Ni8xUUExL21rQzczeU1uWUkvVVZsZDYzcEpZZnJLcjZGbGZwNkRKem5DSEFZ?=
 =?utf-8?B?UTlxUndzc0pnQ25WUU1icGlXYS9YODQ0eFgvT1hOTHFmNERkQXRTOENMc2Z2?=
 =?utf-8?B?Qjl6aGM3V05YQW5lVVZtVVJVOTVndTlJZXRDdjMvaWpmT3FNUkN6eTRGWUdD?=
 =?utf-8?B?dGtKS3U3dWl3NTZLMDhSUXU4VlVZQ2R1MFNhOW5mdHJTUHFzclMrbGJLRGZj?=
 =?utf-8?B?aVltcndkZWRwaXJyVjhYeFIrODVEZVh1WVlkSnlBdzFoNU9TaEhVMk5WalBn?=
 =?utf-8?B?T3RCNk1INHhSbFMzNTRBUlVKaW0zdjBFOFpNMG9qS1dYbWF2U3JkY3REUGxr?=
 =?utf-8?B?bUJScjdPcXZMQmZGMnJ4L3dySk9vNEk3MXpoY29ZeUFTam42cmxxOXo5SDIx?=
 =?utf-8?B?TSt1UzJnbnhqMFF2Q3NGZTdLTEtsUG4vVXBLRlMzV1ZGZGV2TnJ5UExaRkZE?=
 =?utf-8?B?WGN5RWpRQUlWV3VYa2dpaEFyWHdQSFByZVA4Q0ZFemQreHVVUU1lc2ExTysx?=
 =?utf-8?B?WThNaFRCSG1YSHY3Z0dBTXZqS2NaMXJZL0U0Y3hRcU5sRXljcmZKSE9sTUZj?=
 =?utf-8?B?K3o4eURSU3huYXNtWHNJd3p6Vnl6Tld2Z3RuTDg5MVh1VmJOM3pvaEJaaDRK?=
 =?utf-8?B?VzlpdS9TVm9xYWwvM05mbktoMGFLWjlXaFR4dXFPQjNkOGN2Z0dlZVZFaWtJ?=
 =?utf-8?B?YXZqci8rMEhRZFFNa08vV3lOaVdHYnJ5dzVRUVpKdzNxRER5ZDZsRVdZNGFL?=
 =?utf-8?B?RFZJT1ArZ3NRc21jSkk1NlJmWXJPSUx2ekx5cStVWGlvR0loUmZUcE8rUGNx?=
 =?utf-8?B?cFpkQ1hhcDlLcHRjL3JiNEY0K1ljaTZBdjYyaHIzQk5qQmpCSy9IbjhLclUr?=
 =?utf-8?B?bGcvOVlhaFdvSmFFdzAwdko2REFtTXlPK2p3VTExZEpmbTJLTWcwZ0FZWDRt?=
 =?utf-8?B?bE96TndFNllvZnpSZVVPcDBaUVZhdXUyaTNsT3B4aHNZc1d1Q2hnQVhUdmhY?=
 =?utf-8?B?c1BoVGhwbkFMdXVOV2Y3RWMyVUpud2hvZDJwNXhhN1NobUNZVEIrWkhsa2Zy?=
 =?utf-8?B?aVN4U284cENBWm90Q0FXUmtFRkdJNURvTE8xaVFQVDlIUGVBbkZua2xmNEVQ?=
 =?utf-8?B?TWZHMUtESWNTRlJUdjlkMUZJelN1OFNTSW82UXZ0aXp0Y21TQk9lcVFpdUpG?=
 =?utf-8?B?NmZYYzhOazd0VlZzUTRsMzE1aDlaR0Ftck53MUJ3ZEFDTXM3eGdZOUR5QkVi?=
 =?utf-8?B?UUhnVUNwOXNCc3VSa2l6TXQ5UFZJdHdJMzA0ZUdENDVxalhwZ1V3aTRPK0kr?=
 =?utf-8?Q?BqRqFJOXu7mhD2K4=3D?=
X-Exchange-RoutingPolicyChecked: 3nbBuJ6e3bZluLIqD/tTHKMpdTtnGPxdwltJ90QGKbdgJVTFWN5uh5uFFIUU5lLYmV3o/NKbgkRq0OqJCrL7fRYmjC0TjLagSms9dUNhed+BRhAdLbR3iqeHYHOAKy0D0FQ6hK+rJ5YpJWB8LoEJdz5LWNt2h3x2DWMvxlpgKqd+ehYonu2/AmGVKW9ZpchdXyN6VMfFWk9ez4CHIe5ChD6WwWgQD9+GO9+pdzjx3APPfMJtFNR+4cIgsatwWRM33QQYbN3zqddxqps/vuZvN+vKhX3SjVOHhpMk4oj6/spcP4WuUB06MivgdTS8XhiHTW40yjgaBUJCrwqYXcj2Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e4b809-cd8b-460b-7cc6-08df3356d054
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:46:47.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sj2Ra+uqIRYjCzjKwvf9aJobD+eS7jekiHKp75FLRTwjmnOSIPe7jZwZePJyZaogDIPdKcZfx5DXqlCb/37XEwnTNt88GIpg2NSKHxly53s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
X-OriginatorOrg: intel.com



On 04/10/2026 18:28, Benoit DE RANCOURT wrote:
> Commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag
> bit") raised the number of free descriptors that igc_xmit_frame_ring()
> requires before mapping a packet from count + 3 to count + 5, to leave
> room for the empty frame (one context and one data descriptor) that may
> be inserted ahead of a launch time packet. DESC_NEEDED was left at
> MAX_SKB_FRAGS + 4. igc_tx_map() uses it to stop the queue in advance,
> and TX_WAKE_THRESHOLD is derived from it.
> 
> A queue left running after a transmit therefore only guarantees
> MAX_SKB_FRAGS + 4 free descriptors, while the next skb with a linear
> part and MAX_SKB_FRAGS fragments, each fitting in one data descriptor,
> requires MAX_SKB_FRAGS + 6. igc_xmit_frame_ring() then returns
> NETDEV_TX_BUSY, which the queue stop logic is meant to prevent.
> 
> With TSO this happens routinely. On an I226-V (8086:125c) running 7.2.8
> with MAX_SKB_FRAGS = 17, routed and locally generated TCP traffic on a
> CPU-saturated router produced 10890 NETDEV_TX_BUSY returns in three
> runs of 180 seconds, all for TSO skbs with 16 or 17 fragments, with
> 21 or 22 free descriptors in all but 5 cases. Together with deferred
> tail writes (xmit_more), these returns led to 25 Tx timeouts and
> adapter resets in the same runs:
> 
>    igc 0000:08:00.0 terra: NETDEV WATCHDOG: CPU: 1: transmit queue 2 timed out 5353 ms
>    igc 0000:08:00.0 terra: Reset adapter
> 
> The following patch addresses the lost tail write itself.
> 
> Raise DESC_NEEDED to MAX_SKB_FRAGS + 6 to match the admission check.
> The additional reservation is currently unconditional, including when
> launch time is disabled; match that existing admission policy in the
> proactive stop threshold. With MAX_SKB_FRAGS = 17, the queue is now
> stopped below 23 free descriptors instead of 21. This also raises the
> completion-based wake threshold from 42 to 46 free descriptors,
> preserving the existing two-times-stop-threshold policy. Throughput
> and latency effects were not measured.
> 
> With this change alone, three runs of the same test on 7.2.8 produced
> no NETDEV_TX_BUSY and no Tx timeout over 8.8M NETDEV_TX_OK returns,
> including 613k TSO skbs with 17 fragments.
> 
> As before commit db0b124f02ba, an skb whose linear part or fragments
> exceed IGC_MAX_DATA_PER_TXD may still need more descriptors than
> DESC_NEEDED accounts for.
> 
> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM bpftrace
> Signed-off-by: Benoit DE RANCOURT <b2rancourt@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 

Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
