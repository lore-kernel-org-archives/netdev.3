Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FB38BF7A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327344; cv=fail; b=q3PwEGKpd3AoEBOmyO9fFuj50E/ugx4QyRajLMIfylZBRWJssdXUNP1n1s+kuQUl2Ew4s4VSMGBsItGBkyw4ghRYdyxoMOznov/HeZ0r4HH0qJ/h6496DpNGNZtkQXxiS5ggdN2LvDprmWBER3YPJ15lAN1PdPZfS5Ao+wsgW/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327344; c=relaxed/simple;
	bh=WvnoGjtzfKuOknb5E/JfCRMDsLMdS+mrcoye3i1hm6s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ExuuZKgCP+CUJ62mWjIsSwi3vovEP7UnjSAcOwg6JENppMDJNNSADt2tW0m6XS64IEDiq62pE6EKcvPYAP7+kSFMPZdmzwNPT1hsjtfogLjrjVQIHDd3HyS0qu4kJ7S1lTV4t+o+CXfpQOBJpoPn5xsAzSZTTATYvnRhiBZ+xkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8uzct/9; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8uzct/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791327344; x=1822863344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WvnoGjtzfKuOknb5E/JfCRMDsLMdS+mrcoye3i1hm6s=;
  b=T8uzct/9jTIVf9pM/I5Wn+2C3uc86CXa5u5FyX/meG5RjFmi4vy893wx
   Mwm5zvEI8zrVR6lU+lEpVTJM8Wj/Wk0uFop22fDd9jSIwT/KMd4FN/v90
   yLdXLo79Xo0JVPaEycBtf5CschYibOswPqEjALe5gsXs6hCMG9uFL7VRO
   cp1JNHXT/0N0TgKGZ8+hZPDG3+PVZagWALypkcTClAEk7gQBxgrBpy21p
   f1R0uAOAYGIonrh9mTMdGLQVTNKa0/ScVvACZ/V/fAmwxiVgEKGimwYuL
   fHN3rcperfbAaJXQoIj1Vb4Fq0TuyY9YLFyP3ANGjxM/4lxW2GyAHJJZc
   A==;
X-CSE-ConnectionGUID: /uAJYQHcQciDArojNVdKtA==
X-CSE-MsgGUID: IJ4BMY70Rj+d1XmBMm2ACg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="81735"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="81735"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:55:43 -0700
X-CSE-ConnectionGUID: 8xlVY6jITgictdSWNB5wOQ==
X-CSE-MsgGUID: 15sSOD0fS4GRWZW2VhH2yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="276819093"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:55:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:55:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 15:55:42 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW5+MMDRyK7kNmfNHZuUJEW1eXtmbKLeQnxEfJ86xvGT35ykSr34f/gWaMDsGAR0ZI7MYErk/LTfLyxoQmfSXq9xa2T2R5zwSctcc113D3+wINz3t1drf3uIZsfBJkOsDEhZzAvPIzne1Nn7Opj4pITvW/Wyd35nTJiiE//Rqr9GbgIj/wZ6FC68n90oOcr8oULZffvZhYZEfF6/FDPLNzbhjTadG520ndTWzqVpgvaE5I1JOlBlObvM7Z7mfLUs/JbbDDhwwbB+tFGvsGm+LyZWOI7xkGnVROc1CU/amNh+tVgFj5GYLYXiCxI+rtU/HTmAUasiPzEdV0+pJT3s2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp71WDpxX8qJmq4KXS4nhUDK27vRvomiZvi5LkpNLtc=;
 b=Y6hw016woia805RW4sz0WJPq6P6A6/n0vKLdyPCdeC8VmfcKiV3iV6YJC0SBYe0qPs2hlsvauSj9ed9fORNYct2HJ7/UYNTo3GGDNiI9Cjq2TXERWyPJm35uHycTtad4eN+/Pq2XBfspH9d2DeJRL6t0Y0f64qxLy+x7zfM/b7MPJ/Y2VLGT7zjDfTLECQreCniTD2xmIGNdl+AzVIGFKiWCMt4qzXf72P7XG+/jZBiVTyqR+hPf4iQb066mQp9T6mj2D0LkMrndIbuiHqAD832F6qKGA/MFdcAidpTRerttq/SuDwAOdBS6fl7RTBrU9tU5HWF1eoRXsBC9e5RLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by LV2PR11MB931619.namprd11.prod.outlook.com (2603:10b6:408:417::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 22:55:40 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 22:55:40 +0000
Message-ID: <e1d160d5-7f70-4e41-8632-8a749e356e9b@intel.com>
Date: Tue, 6 Oct 2026 15:55:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] i40e: skip unnecessary VF reset when setting
 trust
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	<netdev-bot+sashiko@kernel.org>
CC: <aleksandr.loktionov@intel.com>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>,
	<rafal.romanowski@intel.com>, <sdf@fomichev.me>
References: <179072990609.434549.1214110562725821109@kernel.org>
 <20260930103953.76497-1-jtornosm@redhat.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260930103953.76497-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::24) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|LV2PR11MB931619:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0a55fc-5df2-4578-b25f-08df23fcf172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: sHoSgEeV/V5F72ptY3H3OgWpapPAE6tSMU/jB2KJtIzrfDjyATgKdOhdulNdPrFddgXwOYylSTXzSvVGyzyYJkUzr8pqna2Q4ErXE3GtT7uYZMsmWUC34j/af5VwIL4mRONYBi0L9Ks8vxsta7oWJE9z/2iLeNK1gMsX4aksJSZXqVM6jNvJ3MqtvD2tZj5loc9oo14x83ynNX4MZFCNSVw7hJ4QVLy7BPYTXIe4BiKQiA0EWwhM55wgzUQcoOy9nbJS4iyCUGyAiUAv02ndiYURiud1uqcEPb2vGzHqi2cKM1OLTBexatidKmlRiz4FlRCTpbc/wi+axouCE2gIQiUWVv8TLTghNxMTQU67T5b3q5puOAk+7I9ZvWoA9QkjyAsWdClgyIRKo1544gweYGG8HrbxKvlsHR3JnrYJy7QeCfPDPoI6fXIouhX2++emM9O2aRThmnUAvFTci8cy7ptRabD5FhonHAALb6b684COwSdC41/bF4808r3YLZwFXjjpQrLWRzn9FBgOpF205xHRgcceDR8hcib7qng8NFiLAynqWoElaLquZ9j4xqxMoyCGI8XXxutSolPum5uhWTM6TXzwl1RAvmhc/2JgR/r9GU4cfC35hRx863+1IRpmb4gMi8EhS/DM5qqGNtKqBKipFDupNvpu8WQoQEA0xYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThHM3kyV3ZQMjlQTTJ2SlNYaHgrL1IxYWZEWmNrZXgySW5zRXcrTi9Gc2ln?=
 =?utf-8?B?ejZVaGd5Y2NYdVhJQ0I1emU0UjZKZkVSeUgrMnc4MTdMZ3I4RGg3Y25tZERF?=
 =?utf-8?B?bUVZQU9ZN3ExcGJVS3Z3YWl2SDBqcjVDSk9jQWZTYlJKUm1PazJVRlFISnVS?=
 =?utf-8?B?Qm9LaWlKeS9ZdFhnbVF0d3JlZ2tjSXNLeVVaQWVweWdCaWJtY0NQYWNZc3dh?=
 =?utf-8?B?ZzNzdDRTc0hjU21Bd3RLRnQzTy85d3M5MzN4MkFxUlpoTzd1YzhiZmlpK01I?=
 =?utf-8?B?YWxYTHI4amNjTWZGRi9uV1N3dU9uR1dNdHFvMDZrZHBNektLa2N4cGhDaXcz?=
 =?utf-8?B?dEk5R0ZuRFhXajU0Ym1CMVAydm13TjB1aW96Z3pVT0V2WkRWMHlwZ01PRUJv?=
 =?utf-8?B?S0FQM3E3MVZuVENIWDF4Vm1ybzVXMEZuL3hXNjBmd3kvL2hrRnA4T3lTbEFz?=
 =?utf-8?B?ak5nUENDVnJ3K1IvSDVMSkFrekNjbllVK0RzYSs4Z2t4OEt2eklEWjVjdFRG?=
 =?utf-8?B?QzZSdnRHNm1ObzlJN2xZeUU2NFMxUy9hSHI5QUVrN0hnbWZIVHRaa2NxMnEv?=
 =?utf-8?B?Q1NqOG82TWxrWHJ6RXVrV1JjOXVveW1nbTkrVnRWMjFBbGpHTUJLWFdIQ2Fl?=
 =?utf-8?B?RENsQUJTM0hkNTZweUU3d3czTU0xaTdkbWZ0SVB3NDhFdUFZRDdIWGkwQ2lY?=
 =?utf-8?B?VUxjVVFxZjJpZzlOenF0dmR3ZndZUFRqWkZoSU9MTGhOYWg0SE05UG9uRzBH?=
 =?utf-8?B?cndMVUtXbXp2TkFuQTF4WXM1d0cxb2lERktGRGVnRzRGdm9nRWJKNmVyb0pl?=
 =?utf-8?B?YkZRckJYRERCMENST0M5cmJLVkhlTnBSSDEydUtUWnlBMjRkTjYySUprcGIv?=
 =?utf-8?B?d05lTUYwOTk5ZjRjM1VYUEVWTTlMVEs1OXdaRm5wTGl0K1JLb1UrNkx5V05Y?=
 =?utf-8?B?c0hnK2pEWW14cCtaSWIwQXE0Q2Y5NDRDUWJGQjk2OHJwWkRpeThlUWUvS1dI?=
 =?utf-8?B?UlQxa05IbWw5OWNiV3VZUGxKVm9QYmo5N0ltZDNla1dOSHRkSWpqMVpMazNw?=
 =?utf-8?B?UUhMYVNsOUFIZVg3bk96bW5UdXkxbWQ0bzZqYzBuejhwZkZWeTRvMjVhR1JW?=
 =?utf-8?B?OEhNZWh1eUYrT0h2RW8rR1JlSk13Mi9HeDhGK2tONXdjK1FiMHNLYXdpZGll?=
 =?utf-8?B?cmE4Y3BMWlYvSTBNL0VXZUtSMUxhMmUxSjlPN29LaUxnb2NISVgzOHBoWDZC?=
 =?utf-8?B?Z1RKRHVUWjZKSWVpN2NJRkNyMW4wNkhRNHk2YVpVNmozRXczTzdUTXBQYWhu?=
 =?utf-8?B?MHJWMGRjZkoyVVVzeGlKK3p4RWp5a0k0aldaSUhOSlpIVlM3dnNxNVExcHV5?=
 =?utf-8?B?TER6RkR3SkxTRVFpNW5xQjkwYys2Q1FsMmFqcG53V21VdVBYMmhFMWVZTUpK?=
 =?utf-8?B?elU1UnV4bW9MNHRJdTQyZVhocElxNUtiZEVIZHRuREZyTHRvOXczRXcvZWIx?=
 =?utf-8?B?OEgzWEwwQ0pOVDNsaVZXamFtUWFGOC9ZWitKT0dLYnlQZnpxS0ZRYnBKYkJi?=
 =?utf-8?B?QStHRHRWNkRMMDhHWDV6YklWTitPMC9BbmNueVhFd1dXT2k0UUhCZXZDdE96?=
 =?utf-8?B?MlIyU3hOZGs0bXhPSmpraU5zeGE5c2FsbTR1MHFRemoxQ01JMlhLYVpxQ1Zj?=
 =?utf-8?B?MHV1cnFieDZwUXFLNG1DNDV3UVloOXgyNVJ5c0RFYnFaaHdSMVhqNjZ2VUpY?=
 =?utf-8?B?S2RwSHFBQ1A5UHpITDBjcVVNcmFycDdzVG1Jak03YkV1OUI5V0NrKy9oUko2?=
 =?utf-8?B?SERBSWZibk1LT09rMFNsMFhDNjd6M2J5UTEva2hYT01Gd0I4d3psbTFJUFNa?=
 =?utf-8?B?ZmpxYVJEcEdmTXRjcGpYMjJuaDl1eDBTSzdnUXg3WUc5VUhydFVlV1g5dWQr?=
 =?utf-8?B?UEt3Rm5SdjZZYnEvZHl5MFJmZjhhSVNieVJxZkNBd0doRlJBWFVJd1RkdUdt?=
 =?utf-8?B?L1crN2VzVmZXeGJzWGhwWVRMZ3p3b2dwZExNOG5HYmZOUTU0THBrb1ZocXVO?=
 =?utf-8?B?VXFJTGNPSUtXRC9nSWRjNSt4WXpscmx5NlVjcXFWWFRJdXorTlo0ZFpCWUZy?=
 =?utf-8?B?elJtLzFOU241MktNV1ViNVNyOVROcmZneFlrOEdzMklzSVFZTWE2ZHhCajJT?=
 =?utf-8?B?QUZtM2hvR0QvWTV3S2x2Tk1WdlBRZlc1cmZQOG1BRHROZllWMkEwMUJqOGpQ?=
 =?utf-8?B?a0I1cGQ2cGR0cmE4RE9QaVpJa2prRm9sT20rZWxWc0FXMld4TDA2NnpCOURD?=
 =?utf-8?B?UnlDMjdWb1kvblRqcjJXVUxmS3hKelExNnhTelNCWk50b0xvYW5UM3JheFVs?=
 =?utf-8?Q?p0clZp8pMDjSRMl4=3D?=
X-Exchange-RoutingPolicyChecked: yrWbf2lAUh6lclX7MMjV0fQx9gVmXtWXDM4m+K3lTp1TAOzvhvN/T5YtEyZXvJkO7AGZwYdymhAtrKj8yoBz86/nrOFc+Qd/UVJyQm7hzTQQ0UZMmCDPlPrSKpAikI5Ovn1SggI+D36M8xbNBiVRtSPlF/lT1Dl6e4uCt82Q0JhskCa7ibaNqOl+YrNc64Uc2UXlf6XsQ5hSqQMEdnQAmArudwJ4oE7oWcqnhAYjfV+2EOHEqUZ6/p4mleUW8Z4CGJTQc8jbShkDBRqmV5y795SKTfoPQO9oqADXDIUG2m9xReMaL9e0jyPhdZRuvLiXuLR938PmdqzvcZ24tTnUBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0a55fc-5df2-4578-b25f-08df23fcf172
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 22:55:40.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV+dRgs1rYKAYwsTDsakUlPy9czT/8r12PYzFf90Nj0FSIZPpbxLIlx6ES3TUHwqapcGvqYDKtrnu52jADWEZSLXw7ODoWYNkAtoEipqUts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB931619
X-OriginatorOrg: intel.com

On 9/30/2026 3:39 AM, Jose Ignacio Tornos Martinez wrote:
>> [Severity: High]
>> Should this condition also cover MAC and VLAN filters that the VF could
>> only add because it was trusted?
>>
>> Trust is only checked when a filter is added. In
>> i40e_check_vf_permission(), a trusted VF skips the admin MAC restriction
>> and gets a higher limit:
>>
>>     if (!vf_trusted && !is_multicast_ether_addr(addr) &&
>>         vf->pf_set_mac && !ether_addr_equal(addr,
>>         vf->default_lan_addr.addr)) {
>>     ...
>>     if (!vf_trusted)
>>         mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
>>     else
>>         mac_add_max =
>>         I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
>>         hw->num_ports);
>>
>> i40e_vc_add_vlan_msg() only applies the VLAN limit when the bit is
>> clear:
>>
>>     if ((vf->num_vlan >= I40E_VC_MAX_VLAN_PER_VF) &&
>>         !test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
>>
>> Before this patch, the reset went through
>> i40e_reset_vf()->i40e_cleanup_reset_vf()->i40e_free_vf_res()->
>> i40e_vsi_release(). That removed every filter on the VSI and set
>> vf->num_vlan = 0, so the VF had to add its filters again under the
>> untrusted limits.
>>
>> Now a VF with no ADQ, no cloud filters and no promisc bits takes the
>> else branch, which only clears the bit. These filters stay in hardware:
>>
>>   - extra unicast MACs that differ from the admin-set MAC
>>   - MAC filters beyond I40E_VC_MAX_MAC_ADDR_PER_VF (18)
>>   - VLANs beyond I40E_VC_MAX_VLAN_PER_VF (16)
>>
>> The VF keeps receiving on them. With spoofchk on, it can also still send
>> from those MACs.
>>
>> The __I40E_MACVLAN_SYNC_PENDING work only reaches
>> i40e_correct_vf_mac_vlan_filters(). That function rewrites the VLAN ids
>> of existing entries and never deletes a MAC filter.
>>
>> There is also a functional side effect. When mac_add_max drops back to
>> 18 while i40e_count_active_filters(vsi) is still above 18, this check
>> fails even when mac_add_cnt is 0:
>>
>>     if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
>>
>> Does every later VIRTCHNL_OP_ADD_ETH_ADDR from the VF then fail with
>> -EPERM, for example a new multicast subscription, until the guest
>> deletes filters itself?
>>
>> The notes on this version say this is fine because an untrusted VF can
>> delete its own filters. Doesn't that rely on the guest cooperating, which
>> can't be assumed when the admin revokes trust?
>>
>> The bonding case this patch targets is also a typical case for extra MACs
>> being installed. Are the "clean state" wording in the commit message and
>> the "no advanced features configured that need cleanup" wording in the
>> i40e_setup_vf_trust() kernel-doc accurate for that case?
> 
> The no-reset path is only reached for VFs with no ADQ, no cloud filters,
> and no promiscuous mode, a basic configuration where having excess
> MAC/VLAN filters beyond untrusted limits is extremely unlikely. In the
> bonding use case targeted by this fix, trust changes happen during setup
> and VFs typically have 1-2 MAC filters, well within the untrusted limit
> of 18.
> 

Since the usual case is going to be a situation where we don't expect to
exceed these limits, couldn't this check be expanded so we would still
reset in the case where the filters need to be removed? I guess its
overkill and maybe we accept the extra filters.

> Even in this rare scenario, the consequence is minor: the VF cannot add
> more filters until it deletes some. No crash, no data corruption, no
> security breach. Existing filters keep working. This does not rely on
> guest cooperation, the PF enforces the limit at the virtchnl level. The
> VF simply cannot add more filters beyond the untrusted limit, regardless
> of its behavior.

This doesn't address the case where filters have MAC addresses different
from the admin-set MAC? I am not sure if that still leaves a security
hole or not.

> 
> For the functional side effect (later ADD_ETH_ADDR failing with -EPERM):
> untrusted VFs can delete their own excess filters without trust checks
> (i40e_vc_del_mac_addr_msg() and i40e_vc_remove_vlan_msg() have no trust
> checks in the deletion path). Deletions reduce the count via
> i40e_count_active_filters() immediately.
> 
This is an intentional change that I think should at least be called out
in the commit message. This *does* mean a VF which was previously
trusted could remain exceeding its untrusted limit in perpetuity until
it resets or self-removes the filters.

That does mean the VF will technically violate the trusted boundary, but
it can't get worse, and it was previously accepted while under trust. I
think.

I think this is acceptable, but we may want to clarify the functionally
changed behavior here so that it is clear.
