Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E620541E6A
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702227; cv=fail; b=WllgQyGGQ9xSEnqvPHQ0Br2xV1DadkHHyNfhqUg6D7bdkyRcovZQC9LvpOJxenLuYn1rbnfX2mcJfn+KJRxTAyFHrKOYCK3CglH5i8RUdS52kVUNA1ri+9jEA1mZc7HQbtf+Mwy3kVoEZDgNmsVaPTEInKh6twos3eJOtxL39Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702227; c=relaxed/simple;
	bh=EpneUiRVcRFpIyNrA6cUTfP+s4dJe7Q5KlDyheOuawQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GbQYcfgtlb1GK9zALBlwhbWjtTRG3Hw//FJsh/Ljoi06GvqM3l27VVGdHiMkT6TBIlSBo1seA7WsYsYUOJjCunlO/Eq+Z8jdipEte1Z3zBa7brKQCgFPLVXSpOSCy+cHJ8+nmJBmh480paF1tKtSR/cZOT+JP/OLelc3kGex1i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaLQ1nb3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaLQ1nb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790702226; x=1822238226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EpneUiRVcRFpIyNrA6cUTfP+s4dJe7Q5KlDyheOuawQ=;
  b=EaLQ1nb3UV8+QtuLmjOeHrdBOrxIC5djeoF5xs4oGaYf+OcqXsGEAIrn
   xZE3dnto9zB58+fgsJPBECVRE3WNCa2dh4oGzVEMMktDeeE72ahucdrtK
   xpyvDK69O0a+0hb3rHCLG/W2IIBYmFuzzyzoLytzHWqhyDFYWXqc+tapY
   2+rGzCv5LoJiri4wmcuro1tUdQzg26IVzzHM16p+CH+iX6qdBPK2qKkYS
   S+KDTkgu3Zy9hOyyzXGDK8abf2h/1ahvE5RtY7LhcYWKl0wX7V/Ze7qfJ
   Th6nqRYnunfttTQ/JNVi2tisMS3xjO/3ZoUzUFupJBLbguKrn2ETDMy6v
   A==;
X-CSE-ConnectionGUID: BSFVr0BoRDu+U0dCeN2xrw==
X-CSE-MsgGUID: cq6ic+y7RQq5g6Uoi1Astg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90647830"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90647830"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 10:17:05 -0700
X-CSE-ConnectionGUID: SYIDXCUTQ4OH8ISKU2a5Lg==
X-CSE-MsgGUID: vLAP6sAFQGqRj3mM1emUCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313371904"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 10:17:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 10:17:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 10:17:04 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 10:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVwru/u2pavl7CdyLUp+wqjBbVZSWYds9yK7E5zVDMgVCTsI8pCJXkCboCoCA16XWMAERKu4+K8miysP45jIlAO+2l5rXYMTIlIlUhPR4Phl8JqNhyH9f2XjAzHeLCzGpTKqsmw/qd5W/Njipub6/ilE90BEm282ZqyV235XdOsJHoJbDxx3QzBDSzrrrTGZ2zxyQT2MxperU4PVVwcKbDqq+pZjZjcAdw84HfkVd19dVvS3gw16CDZYxovxvVquPvIHwJFtJyG3+MqbcM2GcBTZtWH4NSlKaDpHsQDHpjiTfGKecKdHFKEW1OomVnBz271WrnFjd4i6TnKQFxuHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpxCo14tOwMV+EVkek+dBU/TJ1CWAU8SUTVTQfns9DY=;
 b=LGekPTIaIKeCV0La2gbgqEu2+UOkOsbvq73ZbGq5UyTrSe30G5E2P/ZVcQ+p6HVbR4iXk1mDS9sHHwIgW7Qi/jxXJUMKBse+DRuwLk/h+fB42CgSD3WPVbFQIxUJSWVWGygK2/azFaQ/qaOx9rCows8rbQTSI0xfDo56MMUUd3u/LQ57hNF+lwIPpRVGOGYiOoRxsMmJEvii8xy/LDvPI/cZFCTk0g9WAL2uuUUxNRSlorOlYLWFLz4eaUvYwvnvsaAL70J4BUsAxIDJv5TuhdljhmLhulGP9HTytDdr6OwC3WMEzQ6x7TDZG7475RXOiabNyY5G1oy8d5aZYvXgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by BY1PR11MB8005.namprd11.prod.outlook.com
 (2603:10b6:a03:523::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 17:17:00 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 17:16:59 +0000
Message-ID: <ed895d96-c7fe-48ac-aecd-f5c1a1fc29c6@intel.com>
Date: Tue, 29 Sep 2026 10:16:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
To: <netdev-bot+sinfo@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<luoxuanqiang@kylinos.cn>, <bryan.fraschetti@canonical.com>,
	<tristan@talencesecurity.com>, <tomasz.lichwala@linux.intel.com>,
	<david.butler@appgate.com>, <horms@kernel.org>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <179063700944.31693.1912265472568249345@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <179063700944.31693.1912265472568249345@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|BY1PR11MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddd44b6-a703-4b6e-7819-08df1e4d7858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: 5nUmM61G7asAGzlhcQDdZAR7nduxuVuVKpLHa+h3+AYTtkAv/VxsTn3YWxbUjMa106/Rn2y7V4g+oYi+Y9hvsRRONtXH8lvGMZU3q8qg58XxQA7SmALlW6y5zfCyjsmOQvOFfVuWh5wPym/fmSlWj7vSfa6OaE++WEDqJqPAmjxpca2gXwmK0HHq4pTvtb1Cs9DdlchKtRLexWThQlPxQRo0TURaAJLco0d1uP4akeE6cTG9/HfzjSJU3kOActbhiIF2xGNJSrjsk4L3wMpFfzKfZk7QybOKvAVGif1NwDzEvcr2WB7nHh5TTGEWZOaKUFBLLD9EjaCCja/ToNVO9a3GXNNYqAhAMDFWBsfCNEivoXy3KVJ4L38F4TvviSUpqJgR+ifBzo70g7brnueXDJZ0lkLAX9yJReeWzMXye+Bg5L4o/aHixt27DxH2Mv/a7OT3a6TcppvEvJVcoTmrdVp4z/KMHbQeWkg6iEJHz02X4o+5aNpTA3a4SRDnPo4a9Dx1KwmZD7S1HT9Wz25vliBXhzwtZZxX+eAhNpjByglN4WEFzpDxM/2gdQS4QyZoPAub9NoZ7Bz+YWLEbsl7IO7k25SvYObuK27qnaCFjJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTRVT0FqRjEyT2xlNzlnNTZXYkRobzdYQ0dsNWsrb1RLdmtKdnEzSzI5ZVVH?=
 =?utf-8?B?R29uZUFOaUpnMUZacjNzVGZYdThWTUEvaXBtekljc1hDV0U2OU5GY2FoL1Qx?=
 =?utf-8?B?Yk1tUkx0WG1RRFRORnpaZ1MxeEpackZVZ0l0MlJBWHpEanJKNVZ0N2ROOStY?=
 =?utf-8?B?Z3N6eWI0aVJTS083VVVoVGxVajlpTnF6SUpkUkZzYWZjc0FKVm92UXlxQyt6?=
 =?utf-8?B?S0NqTFB1OW44eXV0WDlrclFUR3lXbDVHNmNhQ0c1L0F0WWh3ZEFWdzZmc3ZP?=
 =?utf-8?B?MGNvN09ZRUR4NmZQVHZCM2VNbEpXakxXSWdQVnhudlFqMjUwM3FqQlZIbHVW?=
 =?utf-8?B?RHMxcUh5L0tDUDE1dk5yWW1ueENUVVhpazkxRzhJcGhDakViUEpNNHFXRFk3?=
 =?utf-8?B?TmxLSXRwb2JyY0Q0b0lsS3h5T0hMdkVnUHh0U0s5d3RrRWZhSHF3ZlgyL21w?=
 =?utf-8?B?Vy9vbUNWVlI0NzJ1eVh0dkE3N0FiM1hSYWJibHVGU2Z4cDM0SCszQktYUzFt?=
 =?utf-8?B?ZGZrN2RZYnk2bFdKdDQzVDQwVll6TGtpcUR0T284ZWwvSXJRajUwUnkzL1BE?=
 =?utf-8?B?TDdWZ0NoVm42My9abUc1c3VRMnhGakFJTjR6MTczRkdUaFNvQStXUnZrNHhK?=
 =?utf-8?B?VytDRGZ5ODB4SmxkdEJ1MUhibUhLelgwb2NjRDNzZkp5ZnA4TVRFYjQ5bGk1?=
 =?utf-8?B?QUdnTlk3Q2twWVB6U2pKWDM5U2NXOHk2NkJNaGVlOFBLMEJYRDMvMm9tWHo5?=
 =?utf-8?B?V2MrSUtJaUwwQWVmMmN1cFlhY0tuZHZyRVU3MnRMRnFGZ0hnWXlpNjhRa3kx?=
 =?utf-8?B?S1VObU1zNTB5akUwNmkxZGdTRUNlazdFcEJXUmMwMXI3aDdKRzRQNXBUeGhX?=
 =?utf-8?B?NEpKdUNDY2trYXBsYlBwVzV5emhHNkJMejFkcDVLWGkrTENWZ0xmOVV1Qzl1?=
 =?utf-8?B?NjhGRklZNGtLTGpzbTNVSlE1SG5LdWhlWFExOUtWaWpGK01acVFjWWpVVEpt?=
 =?utf-8?B?R3RHOFhPTzRxSDhKZjVnazlRbnVxcG9TbzlLMi9TdjUxTTkrK05Ocjh1RWlB?=
 =?utf-8?B?UzdaN2tPcS9nY1I5aURLUXQvK0s1TWVPUzVxeEcrZlJlM0NqbjJFOWx1dWFP?=
 =?utf-8?B?NGpTbTZqMFRXNFl4TTBKYUE3czNyVzl0LzNKNWFIWklVbDhkRWFTSXVTVitT?=
 =?utf-8?B?aEU1TUxTYnByVTlST3pvWEZFREtORElwRjBFUEptWGU3eVJxS0RYVHdNY2lr?=
 =?utf-8?B?STIyZlRybTBzeHh4Y3QxL3hJY2ZnQnQ0WVlDY085dHRVN1Z4RGxVMFNrRHAz?=
 =?utf-8?B?WkNoaDEzWGNZRFMyd2JPWkdnQTVVdXg2WlpxZFVvMVJMMVY4bWpPeXlKMklu?=
 =?utf-8?B?QUVvRkV2NkpBL1R5UERBTzJ2N3BjeDRpeTBPSTdmVDEyc3ZwUlhleXRZVWpR?=
 =?utf-8?B?MlIrUkN5U0Y0eW1neUhXV1FQYlJnVThmQkRIallJN1M4R0UxV1pqYngreFNk?=
 =?utf-8?B?RVc1RnpCVHg3TEN0bUVETjdBTWZVZ3FXUGZCVjJZYmJ1K1VvWW96MWt3UTVs?=
 =?utf-8?B?SUF3S2MrQkd3aFlsYys4TjBSWldhZU1MUE53Vnk2RHN1Mm1PYi9VejJCZU40?=
 =?utf-8?B?WTlkWDhEd3ZLbUkyUU5CUjRXZ3FKR0lJME9XUFpuaXdTWTlEc001ZHlIa1BV?=
 =?utf-8?B?aHIrVERGSWU4cm9lWlRxd1lDK05BeGlBVFoyZWVtQWkzLzNpKzhMb3VyRUg2?=
 =?utf-8?B?c1RVaGgraW5idVVwellTSGx2NExWSGVBblIvdDhqME13cmxOM1BZQTgxeWRy?=
 =?utf-8?B?T2lUQVB0S2VrY2pwSzJSTDE3bXpxRjVTalRKNCtMcTNyZEhxM3dBWVA1MGIx?=
 =?utf-8?B?OVdXOTE5ZlhVTG9OOVRqOWhvT0grZ3YxKzY0eVFsdFJtOUtleGI4U0lvaTNj?=
 =?utf-8?B?YU9nYnJXT08rdHFENlFmdGYwMXR3N050eEo4dlF0T2RiUHQwb1lhSjd4Mmo3?=
 =?utf-8?B?ZkVhQnF3VWxjRU1NWk1TNVpnS2xUcWt3Q2MvdUxIVjgwMmt3ZjZvZVdWbDEr?=
 =?utf-8?B?dkNOVUdNSDRTVFhZcmtmem1zb1dDWk12dmNscGFrRnlvWUgxQjZMSUIxRk5E?=
 =?utf-8?B?ditqVDNrZ0pOc1ptNTZvdUZNZlpkQ0o0aEh2K096N01wckxQRC9sdmhjWlhp?=
 =?utf-8?B?dVdML1VPVUpOK0I0Q3RvcEJ6R2QrQmZVRmowSE53NGZ4Y1pBTWo4OGMvWTVJ?=
 =?utf-8?B?b3pieGZhbzk4Sk5wTTlFU0MxUGdNc3hIaFJGRFE2bWF3cnNTaEFZc0hPMWM5?=
 =?utf-8?B?aEx4MStNTFlCOWRZMWxJSjZVN1M5Zy9HSzJGVktZaTMzT2J3RjhQWnorZG1V?=
 =?utf-8?Q?ppv3pHQlOugipmak=3D?=
X-Exchange-RoutingPolicyChecked: g09cefs2F6f9oulKHp9Ygg3VhmcMnJt2MVjPn+GFMxrKp281aZ/ePaNA5dmKFHav43x6YhiJD4LhZ8OGRg0JUQ068FNdbpJsNine9UqzvJfrmLVKj5aIzBRal4TMmjUhmQbjCIp3LGyw5nEoRULCqegNiwEW/qSJuuJsPxlIBr1TqQrrgIP5fHIerCQ8rqm1fUqUwBE8Uf4p9+eKAhUvx/U2nghNX7RWKk5Jx8JBHKxcnOAxtjp5bhRXe3mB+eSZQbX+PzP3DpiLJJNZLgG2ZDukrkus2vQ+AW74el8uuTGN8VS2dKDX3dDd7NaOLV4dFHUSQVDIVpH0x/KidaiRqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddd44b6-a703-4b6e-7819-08df1e4d7858
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:16:59.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgsR4ICAE1GJTMvXiaBMo9DHBFJT0Na1zeshydNj2AwX037HFbJ3DxoLPs0FGfnoITEOGF5GTUoV6dzx5gvhDSNPGZYcdGg+HM4Tdc6U9o0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8005
X-OriginatorOrg: intel.com



On 9/28/2026 4:10 PM, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:

For [PATCH net 1/6] idpf: fix possible race on remove during a reset
https://lore.kernel.org/netdev/20260928230429.495442-2-anthony.l.nguyen@intel.com/#r> 

>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.

Stress testing during development.

> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.

It was triggered, the commands are in the patch description:
modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf

followed by the kernel trace.

> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.

The bug is not HW specific, but it was tested on Infrastructure Data 
Path Function (dev id 0x1452).

Thanks,
Emil

> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

