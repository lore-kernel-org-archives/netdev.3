Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9214CA297
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769276; cv=fail; b=eQXrXqyvoGP6ZfCh5hFGUbgNEQr8kNgJdozZIRvdWs+5Xq56EABTFuqjaACB+UA1efH+QMXV1bd7h973WUXyN00J7tmPGUFOHcJibBVGisB7bMkY+EmyfKsWwjC9LW1augFTOQTorpQV1fBwUexZUZ29EmpCwREFBaR5k9RTHVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769276; c=relaxed/simple;
	bh=Blc9ChYeru2uuDFvGEVL0u+iktR/1KGB4EDMB80xwtg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YzWAM/XetBMJcVYF70aedRtrE7FOGTrPHAj0zw2aWbaIJm7r2p85zPaFgj3DBhYX69B1qgPnn8WmwuqzyJLmDqm04rIayIFxNdGgjaKKhZp9l0+FQmbcKAWPiycIQOMzCxZ9Kdx/IfuchUiqe6aDg4p1rUpXeyOSKyEUCfVhhf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaUiXKhZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaUiXKhZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790769273; x=1822305273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Blc9ChYeru2uuDFvGEVL0u+iktR/1KGB4EDMB80xwtg=;
  b=EaUiXKhZyhWTzgDB4ez95I/Grfs+zebifvUuH8+hTh7NLtELyieNoNIQ
   wUwv6irWlpY0WaxEztKRGxLQ3DkJ8X/8NAGgW2m4qLtNyqWjCb1jooCJ4
   ROKrnBVlu13NzUzfAZmyDugK993BZi7E0hVGeJTGdgMI5DA/5iIX5ulkn
   WI40aOJDwRTFGrY0wiNF1snymIBYHN1kmUFJvKaQEUA0BtEz3qjVLEll0
   DsizTXLrlptbR992GeF6SV7+Vaqv+VsECnZena0lKhnwHD0zGdkZKTGUl
   FrJzJF/FeBsTkcRkxamr1SA/Z3n67FWdN2SGoHtTocCEkTC6BvrTbsMZQ
   w==;
X-CSE-ConnectionGUID: fG45oj/TQyq1DgmI5/accg==
X-CSE-MsgGUID: EG1+5eUtSZuKcRrtr8vlIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="95314127"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="95314127"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:54:30 -0700
X-CSE-ConnectionGUID: CUmeg+AiSh+qffIWGGX3CQ==
X-CSE-MsgGUID: 3LYb2FyJTf6ycZdc6uBrJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275224508"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:54:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:54:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 04:54:29 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 04:54:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5VXk989koextU0j9jtyGbktIyiV4TiLQrDUkdEfcwqCvWGTf8jg15u5zyojk2N0q0zgo2wctk/uZy7Vozqfrb2f/R/NkRbwJ6cumNSKEOBntWGJQaO7mx7I+lzM0Jdt2Qtp/ShZGtDyl2Rx46s/W5JJRZ8hjtZvNXO+r7VaNV5lcgQ7ejqxSy5swib+/wbu4Hvebk9x1m8xnwpA7GHPrdVM51UVJZ+dzcZ+cMqv7h9rGJJPSUFZ0ZNEBlBVqfITkJoWqh3ZjXMobatTrQMWIgf4q/NeT9Iexym1nFdX4fg0God2hRG6nIk7cDGhIg1AVqN2VAMptMv3K6vqZcd68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4g35VQ7JzuKNRygAZWYbYfUsjuskx8jU2/xm+n7nq0=;
 b=E+2VZQYxtpIQAt4EnArvHihLVnSbtN04J0DAyKYWUVtehIGbaLLfN9BFzaNPE37GcADUEd/73ohozmtz9o3kTEAZdXxSkXnauLDDwfGaFA13g8z9DzjLE/wg2e5t2choM9VuU23miQY/vg7Pe7ZPFSdCOXEftoodeQHKv/36jz65jDSxGQj6EJYbjxdo/xYS4fr7axtt6wPiOBAlwnELR/0+ri/JFqoxKWZogcjvCPOMNwCTQJhsyqvqG3dkSAj+Pcn/cRLRBgDc7cwp9Ijtmllkk2SZUj9bNTLVWGkyDQDcXHkjbR3RkB7ikQhP0fc2ZN3G4wGvPlu5quy8TrUMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 11:54:21 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 11:54:21 +0000
Message-ID: <72b63460-f1ac-4705-a5e2-afaeb512dbfe@intel.com>
Date: Wed, 30 Sep 2026 13:54:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 6/6] ice: size ring stats arrays from the final
 queue count
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <anthony.l.nguyen@intel.com>,
	<aleksandr.loktionov@intel.com>, <mschmidt@redhat.com>,
	<intel-wired-lan@lists.osuosl.org>, <edumazet@google.com>,
	<horms@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>
References: <20260925132636.123300-7-przemyslaw.kitszel@intel.com>
 <179069065074.434549.14633015707889876251@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <179069065074.434549.14633015707889876251@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0002.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::33) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: fbcb058c-3fe9-488e-3ef3-08df1ee990bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: D8O44DBF35EaTh03xI/7fRTa9fMa3tFmB0qRxVWlhWQGziqsBl7B7fQWao3LflM622vjnNKK3iYTGR888qhKX/c5w8NezFBXDIQhXhj0y0HXBnPUWif1evhaKQRmPPCDVnNdeCGwKJ8rRGNv0taBgyRWRXkNOahfb/vPaz6LX2QGrRqPwCiQ+A1ssQBBMZC0yUxXoidROLSxIuCSnhO73BXuCj2kCWSOnfM/DR0lF/UBbe5Wi/BMX9clg+6LLS8hpBfhPJZfXFDwrxbtP88XwmKe1MW+M7R9WieLqjqItHinJWZAzam71bKsJupuy/ZRGE3a0VWn/RZ+Rx8WnuVRFZxre4MOySV/ZRSjxcG4ir6WJ0f+s4ndahYxgfqW4irKX07lgOrH6Ji3UGN0M0SzXMmmMYoMQzJT6hLkHk4fstg4ZyOwM9qa1j5HUk0HA/1gpWshA4/yz7lHrmGYHLERlwfdQqDRWoqfYQ8//TXc/B1g0/IJ4EPJo+DeXcsxba4ahhLQLPaNOVt6pAxntfOv5IK3Cc++D0xKs8A3GG4RO2+bLuNhg5zt8TF0Imn0MPvqoDLiUMNnIEUwcTzXwVetHkW3HKshQLlZxM/eWPATD26RdE57wwCcTF1kaLfa+DlM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVqaG5NK2lMUlVvdkJGRStVZnlENlJoUHFNNHBvUHk4Y0w0UmdxcXRlRXZm?=
 =?utf-8?B?TjlwNHZoOE9ZbzM5RW9GYVNCU3hHekllZ0pVZUZXaldLaFhEOVNZZWR6ZUdn?=
 =?utf-8?B?T2lXOTliOUVPcEJwUGY3dHo0OGFHcnJmTGlvY1BRcDRXY2NadnQzS2dNL3M0?=
 =?utf-8?B?bmFvaUozWEdlb2VMT0R1cnF4ZFJkMFVQcTgyMnR4eUhjRzFFbjlOUFcwOTVx?=
 =?utf-8?B?UWc4Z1ZHd3N2VkhCUWdMdjJIZzUxR2tyWUF6VXRtK0F5YkVXeVVLbGFrSW1Q?=
 =?utf-8?B?MXBucnljNWRRQ3Q1U2VhV3RSaFhKSTZLbmxsVDlNelRsd2RWQ00rL1pRWEww?=
 =?utf-8?B?amNLcGUzbWFqSEk1OXFNZkt5Q2NVN3F2L0drWjd0MFlkWVdsaEZ2WDNIMnVt?=
 =?utf-8?B?dWtCeGNqQ01COU04UEpHYWNOSnplMm5qWlA2NHBPUjlYenpTTDJwVWZnYWNU?=
 =?utf-8?B?SFJoNHN2WkNPK0tSdW02QllwaVl2b2o5QThWWFZEWHYzakp4cERzRXBSRVJW?=
 =?utf-8?B?S0I4MkhsU2M0Sk5zUG40QUpyek9MTElIb3JKdy81YVBieS9XS0JWYWoxczdv?=
 =?utf-8?B?ODJMcm5OQTFlRzI4YmZ2VW1GWGE3MmptNTlsM1NXTVpEUEdTTlcxVDJ1aEhx?=
 =?utf-8?B?WWpneGVLckZvMzR2TmpESThGbXN5cEJxbUkrb0dURHZoQlpPYk5mQVZOVTNq?=
 =?utf-8?B?OEtmbmpZa2ZvaDQwREhoY1hUemh0a1hlWmhLZjlJWmxOZmlhZTRXaCtYbTlP?=
 =?utf-8?B?eGtTUm5JdFZpS2hGQS9vYjJNOGdLUk1OQ3ZiTUFNVGlEbTFWd3lEWHJXSWpk?=
 =?utf-8?B?SzFCaGpLSklaQVVzaEF1UUZJcnJ4TVBVaVkyRUxJbW4veDhXTUUyUlRlQ0tX?=
 =?utf-8?B?d1FYWHc5RG16aFJnMDhlZTJJTmVpT1lGZHFkeTZ4WkRuZXdtODZRT1o4WDRz?=
 =?utf-8?B?VWIyNWpIdWJhOHFlcjdjUDkxcjQ0QjZPZnM4SHl2RFM0cUl4UUdiZVJuM1Nx?=
 =?utf-8?B?bUpMY2tsRlNZMjNXMXFxRzN1T3FtTlpCSWU5U0ZKL1EwbS83eGRudGxDckY3?=
 =?utf-8?B?SUlER0JLRUhOSDQrNFBsMW0vVlByTnliaWZhWExYYnZjcXZmL01KRTNWaVhK?=
 =?utf-8?B?WExBVEFUeG5YTHZZL2FvVUJyWDdPWDFKYWE3VVRIdXd0QlljWUZXYlN6QU9h?=
 =?utf-8?B?cklXZnQ2aW9kOWQ1WTNjK2pDNVdIK2YwUWQxclpWUzAyNE1sL3BTZStWU2FH?=
 =?utf-8?B?NUZzVlRGbGdFeGhzeDZtMUw1RS81OHpIS290YWxVMXdaNlNZenZaRWxMa3Fh?=
 =?utf-8?B?NzBLWWx4QWs0TGhuc3BNencrZTdhelhsdFZPZFBxd0kzN1hTZVBtaTE4RnBl?=
 =?utf-8?B?Q3RLWXFGVUY4VHBjT1NuM1d1Qk5teFhxR3pFK1I0SG1hWWpGOXVBUksrQnVR?=
 =?utf-8?B?VUlPN2p6bEJEQjZnMWlkSzhDLzZSUE83eFI1bGVTdjh6d054Zm1HdjBwRGY5?=
 =?utf-8?B?SGpEMC9wRnJvV2lKODh3VjNib0Rqakc4UFMxVkJYL3cyUGtjRk5XSXlyeEFo?=
 =?utf-8?B?Skl4UDhJNVk3OHhMOFh2VGswc3JVdkZtNGFQUGdwZFlieGtqV1BET3h3Yy8z?=
 =?utf-8?B?UEZDZ1p3dzZFbVJuUE85citFckxmYUpQQUV2OC9pVGZVdjlsM0luakY0TTJ6?=
 =?utf-8?B?VEtSODd1Y0RNZlZMaGxkT25tbTZJZE9iMU5WNjMrTHozUW9wWDlqZ0VKUWkw?=
 =?utf-8?B?VEFLUVdDbnNrcmN2eDgwendpQ1NqempOK1haeU1tMTE4VGhmd0pqaW1iZTNv?=
 =?utf-8?B?WEtZTW5SQ1pBQXVVb21XNUZjYzdwdFFpWVRBNGhSejNQUTFJMlhQSlhpSjg1?=
 =?utf-8?B?N1RnTmZENEZCc0plTWtrb0Y2YjFWa2ZaUTBtamhQbUNCRUlLTDc4MkpRZE5N?=
 =?utf-8?B?VkRabHd3djRpOEhRVXpEM01HYTRpZUcyeExmM1BCc3RubHVIdU9LVUNIMmE1?=
 =?utf-8?B?TDBCUGMxdUEzVEJSV01lVHBobjlmUloxTzRGcVNiRUlMUVVVT3QvOEJoa3VN?=
 =?utf-8?B?S3lza3U4SmxKTmxMUmMwajU1bXdWZ1B3NEFFdFAxUkNnVm5zQUxWTTNSaUZO?=
 =?utf-8?B?WU1XbDIvTS9ocVFuS1huZlp4YkFPb21Cdk1uSVVrbnlCaW42SXFCMVJaYVdv?=
 =?utf-8?B?ZFFQSGhwYWRpcnFXOUtFOGR5ckNHbnFURTlZRVBEMXhGYkREVEpUNThVN3gy?=
 =?utf-8?B?QkdqQ1FJOW53NzM0QVd1b2dPUFh6VWs2VU0wWGVkVW5sUXJHK1puSk1zNVQv?=
 =?utf-8?B?R1dQdGJYcjVEeldVVlNzT0x5ZjlrbFlndUJCUVNaZlNLem11MnBVbkM2M1g1?=
 =?utf-8?Q?EP4s5xiVpFDk5f0I=3D?=
X-Exchange-RoutingPolicyChecked: O3I0uvEKTRusGg3VLyPRjNGq7rNVHsbFTdavcAE7vh9VTwbx/2MCJDMLPjFQtFVbTFe40DXR9S7X6Eeo3ds9vuah1reWPhrtgvjm3AP4ScgPzbPxnAH9g++2+g9nnA9TGUiKlZ9h3XNriA4EGgsvHTTAfPAbh1hk51qsOm6fZbp77TjpioSAcThcFLXf9RihKUazOEyZBhlUlUfebXmYCSuMDXuCNiNrupnZ6isU0lXuhXqedI8POAQzBWUCS18jJoA1jhzwevUDUOz7EdzA8YCzlsyD2MTFHzV5w9IYA7LLTt6xCcaLI5jxmPP9Ri2Nlz6s34g6VKL9Zs94lAUWOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcb058c-3fe9-488e-3ef3-08df1ee990bd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:54:21.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ea6Mur6cMEsgTLYwCKlf3BU7PRRI9zhD0ZO+fT1JB0FMqBzlQjZH912g+5qscprSMm6FmVenLGF7xGaFQfJzH86G5uBfnkRkSDPGEhjN4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
X-OriginatorOrg: intel.com

On 9/29/26 4:04 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

Summary: Please merge. One not-pre-existing issue to dismiss.

> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The commit message says ice_vsi_alloc_stat_arrays() becomes
>    "the only authority" on the size of the ring stats arrays.

the commit message and code comment describe intuition/logic/reasoning
for the source/methodology of the size calc

AI tells that, as computed multiple times, it could be different by
principle, but only really weird cases (which were most likely not
working before). So, keeping in mind that this was meant to fix issues
observable via normal usage, fixing "but when you hotplug a CPU during
rebuild" cases is simply out of scope.

Also points out that we loose some stats counters when shrinking, then
re-growing queues - this is pre-exsiting behavior.

> 
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>    ice_vsi_rebuild() calls ice_vsi_resize_stat_arrays() before…
> - [Medium] This problem wasn't introduced by this patch, but in
>    ice_vsi_cfg_def(), if ice_vsi_alloc_ring_stats() fails after…
> 
> --
> 
> ice: size ring stats arrays from the final queue count
> 
> This patch changes ice_vsi_alloc_stat_arrays() so it no longer returns early
> whenever a stats container already exists. It now checks the existing ring
> stats arrays against the final vsi->alloc_txq / vsi->alloc_rxq, and grows
> them with ice_vsi_install_stat_arrays() when they are too short. This fixes
> out-of-bounds accesses in ice_vsi_alloc_ring_stats() that are reachable
> through devlink reinit after CPU hotplug and through VF queue count requests.
> 
> Closes: https://redhat.atlassian.net/browse/RHEL-164321
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> index 448d3c7780adf..c393d913d0379 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -634,10 +634,15 @@ static int ice_vsi_install_stat_arrays(struct ice_vsi *vsi, u16 txq, u16 rxq)
>>   /**
>>    * ice_vsi_alloc_stat_arrays - Allocate statistics arrays
>>    * @vsi: VSI pointer
>> + *
>> + * Runs after ice_vsi_set_num_qs(), so this is the first point where the queue
>> + * count is final. Grow the arrays if an earlier sizing guessed too low.
>> + *
>> + * Return: 0 on success, negative error code otherwise.
>>    */
> 
> [ ... ]
> 
>> @@ -645,16 +650,13 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
>>   	if (!pf->vsi_stats)
>>   		return -ENOENT;
>>   
>> -	if (pf->vsi_stats[vsi->idx])
>> -	/* realloc will happen in rebuild path */
>> +	old_stat = pf->vsi_stats[vsi->idx];
>> +	if (old_stat && old_stat->tx_ring_stats_len >= vsi->alloc_txq &&
>> +	    old_stat->rx_ring_stats_len >= vsi->alloc_rxq)
>>   		return 0;
> 
> [Severity: Medium]

[...]

> 
> This needs netif_get_num_default_rss_queues() to change between the two
> sizing points, for example CPU hotplug during a rebuild. The sriov_numvfs
> race described in the commit message only makes the resize grow too little,
> because held_txq already covers the VSI's own queues. The out-of-bounds
> access itself does look fixed.

this is the only not pre-existing thing that I'm arguing to ignore

 > Sashiko AI review · 
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925132636.123300-1-przemyslaw.kitszel%40intel.com
