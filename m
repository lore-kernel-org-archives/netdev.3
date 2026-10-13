Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB1558204
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932692; cv=fail; b=RaaAE8HecjWlcaANGYvmGWHqOToY/rLx2Xn23FQn2L0EbCM611gMwMQSTZUrlia6u3JvqkZDK4ZI2+9WZFrb1i6+0wcPWo0Bt7m3jZEVPb/gsMZ3XZfQGjISuupqc3fMLX8idKzuLq1ypQSPzl8JityaAJ9pY/flYzbnrONv+c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932692; c=relaxed/simple;
	bh=NoF17Qpj6lI/Hu8WAVwoNSxyaxwOVgQ/Q5ZYZFb28Ww=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mbyJ3QNJEfYNYUXGkPlwyOjRcm6LYe5kTyLsUxp89DcqrlkEF2R1NYUeuylvKmRQxhGLS7Y11gSz/hYc0j6GCZML0jUiQyiXWiYlgf2cj/RYbaJvAN5hkuJ3DIB5u7rDWvzcT4S4U42mGeK0CD6LGfdMdGQSYKaNJlKrWn+ppnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWBL0aW9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWBL0aW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791932688; x=1823468688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NoF17Qpj6lI/Hu8WAVwoNSxyaxwOVgQ/Q5ZYZFb28Ww=;
  b=QWBL0aW90LRmZ2VJeuWH+MoKwKtIADsEnr8TO9C1b7OQj4h5tultIMTO
   ltXEc8cN5T1u/68Z80QEXNU1GxzDvHh+aSUok7feUjCYBTU/umR/J4OvM
   NwMBwr7IdX379t1EwVmwvW71A1B/r+FErTW1Nl7ecWFAptBRFDYqnRArg
   WH7rTSi3hpHqNdw2a4a85EnsrEntSV9nwkvAKr2apTKJnUBdAQWES3IbX
   XGQPO5xi6/Q+m9UEvnXYjgqPXmkMI5Oc8SLq4siL3IL07tgz1YjCFFzV7
   GUy/16onUImb8FsPbE9CF9jtZpcLK8XPFS7IYTcQZ4whuBCepBk2WalbW
   w==;
X-CSE-ConnectionGUID: fUfpMwfGQPatY6dvceanYA==
X-CSE-MsgGUID: 1xft30dAToyCw61vOzTviQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="564183"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="564183"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 16:04:48 -0700
X-CSE-ConnectionGUID: smTQZ+58R6m51EaX0a4rcw==
X-CSE-MsgGUID: uySE2y5zTtim4RqhLyCNfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1308845"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 16:04:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 16:04:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 16:04:46 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 16:04:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRgFnp55k6WpG0OIGggrgwjJ5iJKoeo1yuRC5Q3zUxmY3tpzCHyN+0LIxgnOhBtzAodSgVqvIAeV73eN9ECtP0gXUhwIDfKtjKaWecE+xSPYeaY3o2990+PtaugHvJjeGZ6y6O+DmSLQtZcYokFhIwCFzg0me2USVAMW5L3tDk5qztQ69yJO/s5iG42TCZ0AUxHc330T8Y+SYYBmTLUG42yadzPNSSjZgE7rEA76QOtn0I3Um6W9ig/exiT5QZ/lGZ6gD7ueB5m9zO4LQawtW17bO1xGwCjeWfiPJPY8DpUn3nVnOqxLw9K5iOE5ftBEzwmA8WKwPy4XjiFjr4rxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpVUIgsfr2ygFNgTiMhaoEXkbD8NXQUObe9eYwfZsUE=;
 b=UWerzWP6ay9MyBTxqTR9kdTns6WMudcEclHaaLbjvAG+0bqTYfHxziasROdmSjLqWBshzYujLOZEGLDudQk/ZkAU+ynWcQNlB9+PLRm+9eexwdbuGzFyUd080Yj9llWyF4zHuYo7fBvQB6cSoxjLkKeSJAtRz2UQN9YRYkpTd3eEOISgFNyJO3u1V967fIToOgGT91t4lPCQ5Hnq7Az2081sHVup3DnIJwQcxvSudAWC8HI5Lr8dWRwt1bx7q3gcvQqL/8OO01J6BxwvCObf1hJfzYmHkFB4c3/5rV3zdX8WE71OHwOHPsqGe4fVZS2EOEEo2mopUgnxw2sfMbS8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 23:04:41 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 23:04:38 +0000
Message-ID: <443513c6-b979-423f-81bc-0a3c94c5934f@intel.com>
Date: Tue, 13 Oct 2026 16:04:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 15/15] ice: Recalibrate PHY after settime64 on
 E825-C
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-16-anthony.l.nguyen@intel.com>
 <179184693471.434549.9184447106002765149@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184693471.434549.9184447106002765149@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|CY8PR11MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d57a92-f90e-4607-14ef-08df297e5b60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|3023799007|56012099006|11063799006|4143699003|5023799004|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7BBVRKHzR2AXSw22wFgQl8F9tTFXHQ5gtCOmd0gpNUjr47NmLEmPcm62aSWDlzPMat115jB/9nH4WiF3bFjCnhXdh/WzH9vA9IzniUGsMbHz4XE7z2Y6TDBEypNinAbmCzFo2bDVSsSAkE4rrNwZ2p2xSm35vz6DyF9Pq2H9ffU2Jg6ZKfyHnEc7PNJbFaFoflOY9QKT6J2MzmXKvmzbJPpeAf0x4bXzMsPWfneuRXAriZf/MWrYt2CNtxyyCbalLIyfzoTTAB0dN1CdiMi/HVLqMAxHShe3wC6sxN0fxfmPUUV3JLfcFKJ9ieC6Du2MRS1wWWfamz8b/m4mtHaMLgXaREGlc/oOBr1p0jxwB+ni64LnIMfBJcIp5U3wSLrCFKNDNcLWrImTI06PYFyQP7swRdbnszaoMGhoq5BRATEM3i9yjXq8JB3GIpTRV1A5NF8ojM9ZvRl+sPDPj8fxEVsteKAQ6C0W+6OqO0E8/hcKdwOe/62iKWFq5Zj+WNKBtCbMq8Mn+padQawBc0/WY91EX0hFaH+hZrlsckUgRAB9FzLq70Hbj4aJv6cImGg0hwkvNAq2AyD0JrQEfWyWx9WVffObw6F+alvDHQGjkQ4K2NgKr/D2Gh1lXOOfFnpRFzb8UlTkofNM4iJPFOadc6To2eV3BrPPgUqRINTYdKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(3023799007)(56012099006)(11063799006)(4143699003)(5023799004)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNJcHpMV2tremVhbVdDeFlUNVBQa1F0YzVqUHkrbUpTc3I2Q2h4U1BwcUIz?=
 =?utf-8?B?Vlp6RmJwSU9yTk00Q2JUTjEwQ0RmKzc1UWd4ZzZ6NGhPb2IweHMvWjRhWXkx?=
 =?utf-8?B?dk10aFk5S01sUlA0WjQ2eVVBQnovUld6bG9uWXZkRzU0a1QzQXhlZlZvcUNm?=
 =?utf-8?B?L25CWXNlTUNveWxtcUV0Tmw3alhjbWdZQlFqejZ3b01JcndnOElWVE5MZlFZ?=
 =?utf-8?B?cG9vcSt0eHdEZXFmZTBMUXMwdjJZYmJoVEN1V09zeWhVbldaZ1l6anlTdzJT?=
 =?utf-8?B?QmwzLzJKYzk0aXJqM0dMR0xoaHhKc2RVRSs3SHdHbE5Id1cvRGE2VTFhVUZT?=
 =?utf-8?B?ZVdCeE1UaFhQaFo4aHgveDdSVjBwTjJuc3JkRVBBTWZzSFEyYU9Vd1EyOFNt?=
 =?utf-8?B?RzkrWXovdGY0SWtSY1pVZWtLSXRXSm92YW85eU40Z2R2TWVadjFyVVcrTUJu?=
 =?utf-8?B?QTNCSVk0UnFvaDBERE82T1RMWDBqT1ZQVmRUTllNK2dyWnRPUjlyUFJ2UUxZ?=
 =?utf-8?B?dVhkZEd1RXRLMUJNMUFTQUc3aE9McW44VUduUWpMV3RTVXdGczBuYytPd1Y2?=
 =?utf-8?B?S0VWTkpiV0haNXU1bGNSaU5ZTnNLMHE5cDA4OUxmdXFxRytER1hSSnlMd1Nx?=
 =?utf-8?B?YVM4T1p5cjF6T0pNMGp5WFFtZzl3aVdEYXpqK24zbHpTVkFmZkZkWVduTHp3?=
 =?utf-8?B?Z2xZVUg5M1JGRVU2YnNWWXMyQkhQZ28yeTJrbXZPMHBZa1hKbDcweDVrYnFs?=
 =?utf-8?B?V1JTQU1PWWlCVHRNS2sxa2dDejA1Q3FTVGx3RTJIazJYNWtGdDlMZ1d4aG1J?=
 =?utf-8?B?bnNQenZocjB4bkpZK0diWTAraU9ubzNjeU10UEhEUkxnK2tyVFNaaVlUTGow?=
 =?utf-8?B?MzJRUEVMWVQwMzVMNnB3Vm05VWhKOTZXRS9YbElOVlF0WDYzNVBwSjc4TU5E?=
 =?utf-8?B?TCt4ZWJ4eUwwQmlPVExPWnBUVjdQUmtyREFMY09nMENBTzQ3bWhvRzIxVlhq?=
 =?utf-8?B?V1hJVU1Da25HM3dJSk1US1lqSkhOYWxZYXU0aDQyZ3hjYWFqall4bFhteFdq?=
 =?utf-8?B?YzltL1lwcG4ra1dhcDdCcjZqeGpVUi9SaG13YUs3T0NLeDh5UkcwekRmdDNR?=
 =?utf-8?B?VTNWakhiVXNydDJxL0gxNExITzRVKzZVUnZRWmNSS1c4N2NqQzJtVHF2YWVL?=
 =?utf-8?B?RHpSNDlnUkxORmRRMTF1eGl6bkFyS0RJTXoxL05RVTFJVWlSalNya3hZWnVt?=
 =?utf-8?B?M0Y4T3FYdEZqTE5Za0hjbGxXdmhBWGpzNUM4SnhBTEMzMXZJcHE4NkpVTXMw?=
 =?utf-8?B?NlhBSnZhTnlxL0dGWWl2MTdSY0hlcnQ0N3ZNanVhdHlMWFROSFNRSjZhTzlu?=
 =?utf-8?B?ZGlpbnpiY0VRam1zRDErRGlHWW13eDZ2aDAyRmkvK21sNkFJRzdtWVE1RXpL?=
 =?utf-8?B?MkJEbThEM0NDc1NzT1djc3JHTmx3Y3o3WVVaWFZQMVFuNW9KeGNjM3JRSnho?=
 =?utf-8?B?OGxRdlRxOWpVV2JIaEdPWExhTmhWMS9PVDVvRFJLUXliOFJJSW45YWJ5OWJt?=
 =?utf-8?B?Tm53MklyOHVoVU0zaDNiQUljaUk0NmhWK1licjZCZWpjUlZsbzU0Y1NCQ2hm?=
 =?utf-8?B?aE0xV2RlVC9kYW5NNXlSWWVndVdqNm1uMHBZWCtISEl6STl5cUVwbHZNQk1E?=
 =?utf-8?B?d0pucVYwNS9obVpQQTVGNjUwS3lxbndELzdwTEF5L0xnRUpZT0FVRlZjT0Vt?=
 =?utf-8?B?TkpzcGdXVFF6T3EwVlBlZEpwWW1TUzdwZDhDZi9PN25YQ1JpRWpla0VGNVIv?=
 =?utf-8?B?VUlaUnZvMHlFcVA3dTFQZ0JOeEJwTzIzZXNwVE5Ua0d0em54djh5WG9yV1dt?=
 =?utf-8?B?L1hJenRGb2VKYzNnS1QwbkZjK0duWHNuaUc4anprTk1xRlJMWjBXekdTcFBh?=
 =?utf-8?B?OS8weVFlQlNnRVltU0VyUEZqcEpTdVg1bXFOZkYzelVrWDVON2RMbXN1QkpY?=
 =?utf-8?B?bzgya1g3ODRoaWNYU2J3VmxlT0tHSW1JdXp2OER2dklBdGZwbmtRSlJlamEx?=
 =?utf-8?B?OERPTFRrekErUFdjeURjam9JdXdvVDZGMnEvaWN1YU5xWjArQ2J5WmhvSDF6?=
 =?utf-8?B?OVZWRGYvUU5IZ0g2Qk5UbnlGTVB0YS80UXAwVWhEdnByKzQ0NGlQYllVbjFE?=
 =?utf-8?B?Y0tjZWc1M3FYdTVYKzZtYnVWN3JzK1M4eVJjVG5vZ3cxRmlwa1ZLYmwrMWJS?=
 =?utf-8?B?R0NKcDJreUU1L0hTbjU5YnBmalM2Sm1jWU5Fa0NHMHVJS09PZnkzblNFeUxh?=
 =?utf-8?B?SHo4ODFQZzdZUUc0MzJFY1BHYjBwQ2VtR3RHQ3Rud0dJTGlOY0xYOFQ4KzFK?=
 =?utf-8?Q?nbgwtarH6/IM8ctc=3D?=
X-Exchange-RoutingPolicyChecked: 1sLnDyRF5Nglz9VE4ZvyAgI8aaGF24e3ELoZPYZMc+UcT4lHFEGoe98UAxCR5ZnfVtYbhftDp0lbMzBBIQu9qZImu7Nb/FKfsuLDwDajXuKiWzJfQFDXiiLcNd1JD6EYDVf3PPn/x92qCUg18v9hggOpaTICS/oo2cppyJiAUkEhoppCP71JTK6hekznifnBo3h84ICPkesqX39nRnW74IDPWBzwXxRiQZe/VVUrr951/SBoazZwxgeHGQCvQNn40Qn/R5B1vEis0tTgjpSuq7VicKcrrhjGzzkzu+Ws3Oq8ixdoBheSVvBT5tNaIYWgYlyeZCLYBiD/1iyIqpfZIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d57a92-f90e-4607-14ef-08df297e5b60
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 23:04:38.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpW58AYuFgig519KYI3w4Vqw4cN6YcIGSd8MTcTkvClewZsBne/SXO1JOlCaIKT4EywYwUeG2INnoi6yAzbCcSvBvyhjNM4PRPxFAmObcxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The fix only partly ports the E82x settime recalibration
>   sequence to E825-C.
> - [Medium] The new E825-C recalibration call in ice_ptp_settime64() runs
>   ice_start_phy_timer_eth56g() after the PTP hardware semaphore has been…
> - [Low] On E825-C, ice_ptp_settime64() can return 0 even though PHY
>   recalibration failed, and the port is left unable to take Tx timestamp…
> 
> --
> 
> ice: Recalibrate PHY after settime64 on E825-C
> 
> This patch makes ice_ptp_settime64() call ice_ptp_restart_all_phy() on
> E825-C (ICE_MAC_GENERIC_3K_E825), as it already did on E822/E823, so the
> PHY is recalibrated after the clock time is set. Without this, ptp4l
> converges slowly after large time jumps because the PHY timestamps are
> incorrect.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 8d302b500a399..a5fe05d704617 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -2086,8 +2086,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
>>  	/* Reenable periodic outputs */
>>  	ice_ptp_enable_all_perout(pf);
>>  
>> -	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
>> -	if (hw->mac_type == ICE_MAC_GENERIC)
>> +	/* Recalibrate and re-enable timestamp blocks for E822/E823/E825-C */
>> +	if (hw->mac_type == ICE_MAC_GENERIC ||
>> +	    hw->mac_type == ICE_MAC_GENERIC_3K_E825)
>>  		ice_ptp_restart_all_phy(pf);
> 
> [Severity: Medium]
> Does E825-C get only half of the E82x settime sequence here?
> 
> On E82x, ice_ptp_settime64() marks timestamps invalid before it writes
> the new time:
> 
> 	if (hw->mac_type == ICE_MAC_GENERIC) {
> 		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
> 		...
> 	}
> 
> That check is still E82x-only. On E825-C, PHY_REG_RX_OFFSET_READY stays
> set and tx.calibrating stays false through ice_ptp_write_init(). They
> only change later, one port at a time:
> 
> ice_ptp_restart_all_phy()
>   ice_ptp_port_phy_restart()
>     tx.calibrating = true; ice_ptp_mark_tx_tracker_stale()
>     ice_start_phy_timer_eth56g()
>       ice_stop_phy_timer_eth56g()
>         PHY_REG_RX_OFFSET_READY = 0
> 
> The window between INIT_TIME and that point covers
> ice_ptp_reset_cached_phctime(), ice_ptp_enable_all_perout(), taking
> ps_lock, and the full restart of every earlier port in the adapter list.
> 
> Each restart calls ice_ptp_phy_soft_reset_eth56g(), which has two
> usleep_range(5000, 6000) calls plus a sync. Later ports therefore wait
> 10 ms or more for each earlier port.
> 
> The commit message says the PHY timestamps are incorrect until
> recalibration. During this window the cached PHC time has already moved,
> and ice_ptp_get_rx_hwts() only checks the valid bit:
> 
> 	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
> 		return 0;
> 
> Could uncalibrated Rx timestamps that still have the valid bit set reach
> the stack here?
> 
> Tx timestamp requests made in the window could also complete before
> that port's ice_ptp_mark_tx_tracker_stale() call.
> ice_ptp_reset_cached_phctime() only marks pf->ptp.port.tx stale, not
> the other ports in the adapter.
> 
> Would it make sense to clear RX_OFFSET_READY and set tx.calibrating on
> all E825-C ports before ice_ptp_write_init(), as the E82x path does?
> 

Ya that likely makes more sense.

> [Severity: Low]
> Can a failed E825-C recalibration go unreported here?
> 
> In ice_ptp_port_phy_restart(), the ICE_MAC_GENERIC_3K_E825 case does:
> 
> 		ptp_port->tx.calibrating = true;
> 		...
> 		err = ice_start_phy_timer_eth56g(hw, port);
> 		if (err)
> 			break;
> 
> ice_start_phy_timer_eth56g() clears PHY_REG_RX_OFFSET_READY first and
> can fail after that, for example with -EBUSY when ice_ptp_lock() fails,
> or on a sideband read/write error. On that path tx.calibrating stays set
> and RX_OFFSET_READY is not restored.
> 
> ice_ptp_restart_all_phy() returns void and drops the per-port error, so
> ice_ptp_settime64() still returns 0 to the PTP core. The only record is
> a dev_err() that says "on link-up", even when the call came from
> settime.

I'm fixing the on link up wording in v3.

> 
> After that, ice_ptp_is_tx_tracker_up() refuses Tx timestamp requests on
> the port:
> 
> 	return tx->init && !tx->calibrating && READ_ONCE(ptp_port->link_up);
> 
> This lasts until a later restart succeeds, for example after a link
> toggle.
> 
> The ignored return value already existed on the E82x path. This change
> makes the failure reachable from clock_settime() and from large
> clock_adjtime() calls on E825-C.
> 
> Should ice_ptp_restart_all_phy() pass the error back to
> ice_ptp_settime64()?
> 
> [Severity: Medium]
> Can the new E825-C restart from settime race with a concurrent clock
> update on the shared source timer command register?
> 
> ice_ptp_restart_all_phy() runs after ice_ptp_unlock(), and
> ice_start_phy_timer_eth56g() writes GLTSYN_CMD before it takes the PTP
> semaphore. On secondary PFs that write goes to the primary hw:
> 

I believe this is a preexisting issue I pointed out in the cover letter,
slightly exacerbated by the new call to restart. We should fix it, but
this series is already quite full. I guess I could try to break the
series into parts? :\

> 	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> 	if (err)
> 		return err;
> 
> 	ice_ptp_src_cmd(hw, ICE_PTP_NOP);
> 	...
> 	if (!ice_ptp_lock(hw)) {
> 
> ice_ptp_tmr_cmd_to_src_reg() maps ICE_PTP_NOP to GLTSYN_CMD_READ_TIME.
> 
> At the same time, another caller can hold the semaphore inside
> ice_ptp_tmr_cmd(): a second settime, adjtime through ice_ptp_write_adj(),
> or adjfine through ice_ptp_write_incval_locked():
> 
> 	ice_ptp_src_cmd(hw, cmd);
> 
> 	err = ice_ptp_port_cmd(hw, cmd);
> 	...
> 	ice_ptp_exec_tmr_cmd(hw);
> 
> Suppose the unlocked NOP write lands between ice_ptp_src_cmd() and
> ice_ptp_exec_tmr_cmd(). Wouldn't the source timer then run READ_TIME
> while the PHY ports still apply INIT_TIME, ADJ_TIME or INIT_INCVAL?
> 
> The concurrent caller would return success but its PHC change would be
> lost. Later ice_sync_phy_timer_eth56g() calls would then align the PHYs
> to the unchanged PHC.
> 
> Nothing serializes these two paths. ptp_clock_settime() and
> ptp_clock_adjtime() hold only the posix-clock read-side rwsem, and the
> time-write part of settime/adjtime does not take ps_lock.
> 
> The unlocked write is older than this patch and could already be reached
> from the E825-C link-up restart in ice_ptp_link_change(). This change
> adds a path to it from userspace clock_settime() and large
> clock_adjtime() calls.
> 
> [ ... ]
> 

