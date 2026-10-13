Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F89E560ACF
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929529; cv=fail; b=Z9E8xihWhlcMLFmM7DcipGrCUsf6eIoa0nBIm2fWiynLaKmz9U2RBLWWKXQTBnMtZx5hu0N5Q6IgvVnqAwCQVpyXTWEN24Di2olHn1Ce7tmgfgtsPzf3/uhm+VoUG0wbLNOOMJTI3LvPD0ts+4hlmox0nihDJtb+6A49ad/lEyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929529; c=relaxed/simple;
	bh=fCRZxE4aM2XSvDsoDmebwUwcXhnr4XjvsQ4GWCvJ/xM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tzY71m9mnnoDl/T+abQJL/BN+CocNIF+1krRAsLzq1KPZwb6/U2UOd8Ft/Gipm/IQFapOmRu4n4G5BuvtcKSGB/jYCeylD9B9cJA1jR/kQ84Yky1UhLCvrxsVUmGiEVf1aJtVP8xMQX355StuoxSE6UV/3hrSjN9DlQY1VRnoK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTMeNesu; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTMeNesu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791929527; x=1823465527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fCRZxE4aM2XSvDsoDmebwUwcXhnr4XjvsQ4GWCvJ/xM=;
  b=UTMeNesuIsK+OUphvX+sBArmTBTnBGaSp2Us3RMAAC+PcXdS7jdX+iFa
   P9rX/59luZu7Z7/W8HqUWqsOmymguybxMkAl7EG9xrjZFcp1wUgNhKJoP
   GZSgz/qfH3dvsCrxu+gAq+YNYBQIVPDEmaMS/6xRYUMN70BJraeyaCvig
   AFunCiRqfTfVagkwHm37eAxpZB/jfTK/tauJo4lmSiieuuoI9xkhQfftJ
   g57K81FNOpuV31L4IbtpikHR3yy6zMxCxc8+EkcCDaT8v5/f8m36a9hpN
   CKTTOGqL0pngNP2f50ApIuIOJ2G9x8xktOMOTMaBKzXszljp9oGXDyAOs
   Q==;
X-CSE-ConnectionGUID: SD+PmkTDQgSqREjZmQY7qA==
X-CSE-MsgGUID: rErY5AiTSH+GSItACYKInw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="678377"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="678377"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:12:05 -0700
X-CSE-ConnectionGUID: 7CeWgH1WSamWjfVqP5E/Xg==
X-CSE-MsgGUID: BGBjr8gkRqGa67LRorIfGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="3043510"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:12:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:12:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 15:12:04 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRCfSXE3s5gldstv7ly9So8SutZwzrD7MO+GTwZTM+AiFpRKbquIOcAQc8cAuWC3NOwA11iYa8IXOGLU//uEe5OURUHt0oZbEzBiMYLIK1+ANFdk5mI5tbKS3POiWZUT8MNm+JGGmyEi/Ecnqce5E0xXZBwNMoFaNRnNjylmN/j7LQwMGCOL9+rzUzUS2Va5kYimAc7CRtKrekSD1G0299G6zbbvvL2T4GdUe0JguDFOvDAe+OsoFQ2PGWmaSlXYJzau0FE/dDHbpi2MCX5gibWn+ieMoMq952dwL8DkiJNVK2JbM0ZHPGR3apzKC/iO6vGJcyaPho4x7AeWcOtbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ua77e5UsTPTYT69vJGCBYSuAxiYFvZCmYPF54vYdXE=;
 b=Rvk2z+uSNVIpAkwxqHCGZ15cf8TOSY6V/hWtjJCmpsFnT8wZJnY3MUS5b/g6GfYkRTimlzbwnqUyeMXdVNGrgpNWMR0AUWiskF/YHJssh/gau9yO0bcGgeSZdMYMPq5BK61ry/wslsKQIWj1a/ax0snBsGMwLixIuzz7uOf5E0Ry+f/0MbPgmbyvgXaKJayEeA0axSym2qGIoPr/fJ6VWUSjdFh5KcTiZlxlB3CBRGMYJVDni/Msn5Js3TkkUk7WuVfjyiCf+m/YWc4rVBEHSAW36b4jwCGweHPJ+cg8pYvU2rhMQluq+FrDK380vfzz/VGxDuMjxWEuhIPW7PbWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1SPRMB0007.namprd11.prod.outlook.com (2603:10b6:303:274::12)
 by MW4PR11MB8290.namprd11.prod.outlook.com (2603:10b6:303:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 22:11:54 +0000
Received: from CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da]) by CO1SPRMB0007.namprd11.prod.outlook.com
 ([fe80::22c:e511:e167:77da%3]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 22:11:54 +0000
Message-ID: <3cc3c6af-6201-4296-a3f6-ccf958b68bf1@intel.com>
Date: Tue, 13 Oct 2026 15:11:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 09/15] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<maciej.machnikowski@intel.com>, <przemyslaw.korba@intel.com>,
	<grzegorz.nitka@intel.com>, <sergey.temerkhanov@intel.com>,
	<arkadiusz.kubalewski@intel.com>, <poros@redhat.com>,
	<richardcochran@gmail.com>, <horms@kernel.org>, <pmenzel@molgen.mpg.de>,
	<aleksandr.loktionov@intel.com>, <alexander.nowlin@intel.com>
References: <20261008215614.1987250-10-anthony.l.nguyen@intel.com>
 <179184692717.434549.6585696302155195497@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <179184692717.434549.6585696302155195497@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To CO1SPRMB0007.namprd11.prod.outlook.com
 (2603:10b6:303:274::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1SPRMB0007:EE_|MW4PR11MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: f25e8b8f-1dec-4cd2-1f00-08df2976fd4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: T7rZBn4MwZZOA3aAVW89PZikATKCryO+R9s8ptN3W2N79BoLNVxp/4+1XTsA4ox/O+MgWEp3AAgEmh+ZudxtG8Jax8hMqBt8sonilvHssgQXWw+2hoFq5vR2ceiKRCOxUxTKtw6sd3CVvk15nWRblilx+rpQzk6688++70hf8rC+bPAuuM86OHbgztV1UBT8RCIYDVl2FaEh2pFi0hAhWW17cMI8rO7Of06gsFeiyiWnXwOLPooBsOlvn+r6sdktKSeQW512jQBn0wpkNiuQwtDzzpcKcuPZ6qGioIo5nh4jTC224IXfgegNuF6/HyJbqT2Weop1xAVA7HAngaeK+t0UOxZ+9HxWB1+pFqKWcvbLwRerkZqH/B5sCbTmVVUgl3OA6i+ZoakO4f0P5adRLY8Ve8/qgKckXSGGItjR3xCgUl4H9uyBRbbZthws/l+DGFEtb+6brrfHNj94u++qJOKFbnqsHGkrWkUFBIRd42p3q/7QXJiyKKNdsHD+wY+0q/b/oqoBG0YITZLlMD+KWo5Ez3UJTSsKhBQnQzEDTRIqZjCezgZLjmnQyJVwsEHHubNf8zvwZxBarNGF0WQzCyvWK3Xd82gAN7y0dxYeoWnabPY3SvuCBCPRkfZBE99lt/9SyrEQvFjzdy9+/3SZurYHsXvjkJx6wLzzHc3yUmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1SPRMB0007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1Vwd3QwNmE3d3IzZXVoQ2pVc2U2ajRMbnI5T3VjaEtzbWp5MjI1V3BPYUFJ?=
 =?utf-8?B?Nzl6dExhbUUya1hDc2tkN1A0bG1rdTRIZHdLbGFWT05oR09WYUd1RERGU1oy?=
 =?utf-8?B?NlpsbTlzUW0vZDFOc3I0MmQwSDJEaVpXMjQvNlJxTVhuUlJMaDhxVVZuK25m?=
 =?utf-8?B?Kzh3eG5DL2I4RnoweFZJck9POGV5cjkyWnl0QnBvWHlqODVQQkphcTg3blhW?=
 =?utf-8?B?Q0FtdzE5TlNBTkFuelY1d2g1ZllwTGsrS000RkdHOHVvSTdIbVU2eDFKQnBi?=
 =?utf-8?B?RmNjQlFKNWR4WW55ZDFqSTB0R2I4ZEEvYnpmWll0WjJsTVNhSkthOVBJVm9j?=
 =?utf-8?B?RTVmQUJDa01kc2hvOURnTWZhVENINVpqZ3hhR0lCaWUwaTA2ckYwdTllODZw?=
 =?utf-8?B?b1I4OFk1Ui9sK21VKyt5MUhyZ0trUk85eUNKeDlINHRSdUh1VHE1ckd0NThP?=
 =?utf-8?B?Sk1KZjUxSU0wU3hGblhtcm52aWRBTnU0NWxzZ2JlV0dyY3FMM2hBRm9jOS9K?=
 =?utf-8?B?eEdQd29SL1FyZGVVSVFPN3N0cU9UQi80aW1TRkVLRHZUbU1rd2xZNGZWTFlX?=
 =?utf-8?B?WFQ3TmplR2gwZFpXRkhxa1JaMFpQVHZBZkM2QUhBRE1FNlR0SFVTL3BOc2J0?=
 =?utf-8?B?UjhXRDFUTFoxWmZiak9xQzBsK252ZFRJMmI3V2J0MG9tRDlDWDRkUUZLaldV?=
 =?utf-8?B?NGphbmVoOXh1RUlXL1ovVDV4UHFxVkdqT2JQVk9aWWpJY0VFV0R4bEJOU1Ro?=
 =?utf-8?B?aEVva1RyZzR4dHp0cVdtMkxKY2g3UW0rYXlyRkFFdERvNnNVRGJXMGs4anNu?=
 =?utf-8?B?WDZhT3hlZEljSzJHZEE2a1k4b2E2WDkzODE5aGR1KzgzUWJiem5naTg1a3Bs?=
 =?utf-8?B?TG05WUd5VktlRzNMOWMvcHZjQXdKSlV6eFlld01MNGo3ZmlVY1hmNWpnQ292?=
 =?utf-8?B?azNha3dPMXNscXlQOFEvRXQ0K1Z4dlRWL3ZvcGViektTS0RocXVJS05EM2Jr?=
 =?utf-8?B?VHRZeExnandQdU0zNGx6VFNDbEdHckh5QzBEczlBSVRSbkxZMEk3S1JJTmRr?=
 =?utf-8?B?T2FFLzFPWXEvdE9wWjRtVjRxYUZncEdkRng3SFdVSUtkbXcrNmVzdW5TTDFM?=
 =?utf-8?B?bThYNVFsdkQrSy90YXBlN3d1UDh0TUl0NVQvc3FKZWw1RlhPZFdLUE5sck4v?=
 =?utf-8?B?ck1ONFdrdXEzbGp2azlmcENTTS9DZ2QvNEx0V3E2eStzamNTR3R5aElyUlZU?=
 =?utf-8?B?Q0h1V0VSOHFuOUlmaDMxQ1poU3laemtESktZS2RUdlpoTlpYWERteFREVGFj?=
 =?utf-8?B?eWlnbzBOVXpoV0ZwQk5ucmJVTnp1ZDBpVlcrV0N3UUtyeXNOZktmcWc5QzZy?=
 =?utf-8?B?bjFXdXZyVWdpZmNER01RWklyZHR1VDRNUm9BNENmQlUrNDMrL2FRcXRoQUkw?=
 =?utf-8?B?cUdaSDlGcTNPVGdnaFUyUXFPOHd1Z3BFQ09USnN2dWtWdENjenBoSzVkT0V3?=
 =?utf-8?B?bzVXQkhkWWh5bjlEeExMeE1ieklodVRlbnFka0x2VzRpN1U0OFNKemVTLy9Y?=
 =?utf-8?B?WExYVVBSMkdmSEdzWEVsQVZEUDJVLzZCamhZcjliamV4bUtldWRzUFdYZEd3?=
 =?utf-8?B?Y3U4OFpIWmY1L0hVMlp6VDVDZThyS1c2T0ZnM2tyK0VBWWtEaDNid1JUM1h3?=
 =?utf-8?B?eFEyRnhYaTdPaDFHZ1VobkpZWUpLN0VBSG5nTG8rbnF2ZDFWVHhpaVBoNEVl?=
 =?utf-8?B?RHRvem1WeVZFb1dsS3pMdkJlMjBzMjV1bGQxbXhUbkdKdENBR0ZCKzNSUGlr?=
 =?utf-8?B?Z1ZNVHN2M3dObmN6eEovQiswWVBOaVc1SjJNdWRJTEo5VTg0eWNUVGMzZ1Z0?=
 =?utf-8?B?cFlvWUR3WHNleEYySGVNYjRUTlQya1NyTjZoTHVIU0hERTQ4QitQZjlMOWhT?=
 =?utf-8?B?V1ZBZU5RY21MRG1HWFFLNUgvMXZJMDR1U05aeGNqYW5aTGF2SncvdkpQQm82?=
 =?utf-8?B?ZGZyaU9DU3F0SE56YVF1WVhOTHJIdG1HTStXaUQ0SC9yUCt1V0RVaGQrVk00?=
 =?utf-8?B?K0pBU2FYb2tkL3oya2x5N3ZldjBteTM5L01KMW9kVWpyMjh6YytFVnBvb3BF?=
 =?utf-8?B?b3pqWHVSZDZvZkFTVkJrMmNrajJReU0yNEY4dmdaWGp1VzIwem14TUVBWG0r?=
 =?utf-8?B?NHRpdVlYTk5JVmM3MHh2M2ZxRkVadWlFUjRwendsU2Ird0NuRmZZQkxnYW5u?=
 =?utf-8?B?YWhuYkdnVnVqNzlaWFM2MWtiUUFpeU5vN3puRXZvcXZrN2tVMGxpRzRENkZ4?=
 =?utf-8?B?eE0rV0lNR0FKTk1VZ2h2MjhEUVBVdkEzWFZBRDBsS3dYWm90Vm5WWW1rUUFp?=
 =?utf-8?Q?aOlzhf1EbRsihSDE=3D?=
X-Exchange-RoutingPolicyChecked: N92bm3myhDvytso3EAaisGQsr9vFoT0+tmL9ypahNT7UMlPGTmSrm5dS2gKmoMx3+bENsr09ZU0VKKKCcnYhtx+QE7cIlQBCQTZOhwAFS+IY6S9QxJXlqLAyR/F8/PNcbm0nuofIQpslb6nDB+WQW81QE+X3aqWySyVUoTKsVRz9wozGviSQZlkf6Vmtk0sngSsTbZMmUPftakEesgxPJVrObHyZP66SRGAlcHvG/PUpzLYHavPevADYuzGSJjBvFCLlviqNnYefmGnTSK8fouPwrLLtP+yk2NnYCAlnDoMdRG8utV9V5L8YXSESgldDP/qgLIMiLld79wteRq1mIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f25e8b8f-1dec-4cd2-1f00-08df2976fd4a
X-MS-Exchange-CrossTenant-AuthSource: CO1SPRMB0007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 22:11:54.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SynMAk5iTKH3rbu0Dg0nseLnZpuj9+5Sr2AdsTXKqH2WIeArpYjlz/TQbqe5UoNajelgkgDBTszb+jgSAlUI4P+oYcW1qOU3F6Zmh9XkRNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8290
X-OriginatorOrg: intel.com

On 10/12/2026 4:15 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The kernel-doc for ice_clear_ptp_tstamp_eth56g() in
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c no longer matches the code.
> - [Low] The new kernel-doc for ice_ptp_phy_soft_reset_eth56g()
>   (ice_ptp_hw.c:2301-2305) says 'The PHY_REG_TX_MEMORY_STATUS reads…
> 
> --
> 
> ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
> 
> This commit removes ice_ptp_reset_ts_memory_eth56g(), which wrote zeros to
> PHY_REG_TX_MEMORY_STATUS. It also drops the write from
> ice_clear_ptp_tstamp_eth56g(). In its place, every timestamp index of a port
> is now read just before the PHY soft reset in
> ice_ptp_phy_soft_reset_eth56g().
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index 07b55fbb88dde..e83ad2bb8d420 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> 
> [ ... ]
> 
>> @@ -1134,16 +1116,12 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
>>   * @port: the quad to read from
>>   * @idx: the timestamp index to reset
>>   *
>> - * Read and then forcibly clear the timestamp index to ensure the valid bit is
>> - * cleared and the timestamp status bit is reset in the PHY port memory of
>> - * internal PHYs of the 56G devices.
>> - *
>> - * To directly clear the contents of the timestamp block entirely, discarding
>> - * all timestamp data at once, software should instead use
>> - * ice_ptp_reset_ts_memory_quad_eth56g().
>> + * Read the timestamp index to ensure that the valid bit is cleared and the
>> + * timestamp status bit is reset in the PHY port memory.
>>   *
>> - * This function should only be called on an idx whose bit is set according to
>> - * ice_get_phy_tx_tstamp_ready().
>> + * This function should only be called on an index whose bit is set according
>> + * to ice_get_phy_tx_tstamp_ready(), or as part of a full sweep when paired
>> + * with a PHY soft reset via ice_ptp_phy_soft_reset_eth56g().
>>   *
>>   * Return:
>>   * * %0     - success
> 
> [Severity: Low]
> This isn't a bug, but the kernel-doc for ice_clear_ptp_tstamp_eth56g()
> now looks a bit out of date. The Return section just below this hunk still
> says:
> 
>  * * %other - failed to write to PHY
> 
> After this patch the function does not write anything. The only error it
> returns comes from ice_read_ptp_tstamp_eth56g(). That is either a sideband
> read failure or -EINVAL from the port range check in
> ice_read_port_eth56g().
> 
> Since this block is being rewritten anyway, could the summary line and the
> @port line be updated too? They still read:
> 
>  * ice_clear_ptp_tstamp_eth56g - Clear a timestamp from the quad block
>  * @port: the quad to read from
> 
> On ETH56G the timestamp memory is per port. The new sibling helper uses
> "Reset one port's Tx timestamp memory" and "@port: port number to clear".
> 

Will fix.

>> @@ -1152,24 +1130,16 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
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
> 
> [ ... ]
> 
>> @@ -2303,6 +2298,12 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
>>   * to settle. This provides a controlled way to reinitialize the PHY
>>   * without requiring a full device reset.
>>   *
>> + * To ensure that the internal counter matches the contents of the
>> + * PHY_REG_TX_MEMORY_STATUS, read every timestamp index prior to performing
>> + * the soft reset. The PHY_REG_TX_MEMORY_STATUS reads ensure that the region
>> + * is cleared, while the soft reset procedure ensures that the timestamp
>> + * counter is reset to zero.
> 
> [Severity: Low]
> Does this comment name the wrong register? The sweep never reads
> PHY_REG_TX_MEMORY_STATUS. The reads go through this path:
> 
> ice_ptp_clear_tx_memory_status_eth56g()
>   ice_clear_ptp_tstamp_eth56g()
>     ice_read_ptp_tstamp_eth56g()
> 
> ice_read_ptp_tstamp_eth56g() reads the per-index timestamp memory words via
> the ETH56G_PHY_MEM_PTP resource:
> 
> 	lo_addr = (u16)PHY_TSTAMP_L(idx);
> 	hi_addr = (u16)PHY_TSTAMP_U(idx);
> 
> 	err = ice_read_port_mem_eth56g(hw, port, lo_addr, &lo);
> 
> PHY_REG_TX_MEMORY_STATUS_L/U is the ready bitmap in ETH56G_PHY_REG_PTP. It
> is only read by ice_get_phy_tx_tstamp_ready_eth56g(), and reading it does
> not clear anything.
> 
> The commit message has the same wording:
> 
>     We must read the PHY_REG_TX_MEMORY_STATUS in order to clear stale
>     timestamps.
> 
> and:
> 
>     The reads to PHY_REG_TX_MEMORY_STATUS will reset the region valid
>     bits ensuring that no stale data is left behind.
> 
> Could the comment and commit message say the timestamp memory entries
> (PHY_TSTAMP_L/U) are being read? Otherwise a later change might "fix" the
> sweep by reading the status bitmap, which would not clear any entries.
> 

Will fix.

>> + *
>>   * Return: 0 on success, or a negative error code on failure when
>>   *         reading or writing the PHY register.
>>   */
> 
> [ ... ]
> 

