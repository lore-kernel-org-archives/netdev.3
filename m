Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799838425D
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587381; cv=fail; b=hySMdvT1xumsOK8CK/rj2Zabp9BbPDV6W6wO/pYcE+lh4Fc0MJb6qoRlxCNFeSi1+Rajp8Dizqs+sOD/sPenksibykv+KnKUJf4IaieL7aCsQxaN69Iy+R2GVVs7LBVDmZNPLOfozAr1ReZTWyUn9zqWyVHfQYm4swBjO+1HSbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587381; c=relaxed/simple;
	bh=xQBfdWRcF0TJx6RE7PBj6rJ4L/tEXwUcxm4471CTpY4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dO54Jrcl+pzhQsSKja8uq9sFmKKB2aSo9nOQ0+NfEZRrctQKlA3vnJpje7dqt0slahasjbRvCnBlyzNu0y8BxA1M4bvE5Cmvp8ChtQgVrAtpBhx48mifQ7lLZNd9o3qir42WmtHLmJYf2v2mT3Jdtntyyg/3PlE3stYTW3qkcVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJwkFN29; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJwkFN29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784587379; x=1816123379;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xQBfdWRcF0TJx6RE7PBj6rJ4L/tEXwUcxm4471CTpY4=;
  b=jJwkFN29xsiunJbnjhNufUIhiCsGhbzE+LVDY2ldmiykkmE3T7ZU56Ty
   +JJMlrl3mV1rUjpfbdNPLmD1asOicTzykROFjlm11eUrN3bO1AP1x44Ap
   kJOevoeSmEN2PN2iayYszON58j8UoqYw+rHHIdBilqdNAVtcDij+XqXcH
   jm+m0sDxezTFKG4CYxW39GnrP4krWVsFaq1DpBSvBqoAaVrlJocltuNX6
   uCXt8QIJcneElq+rqBWryyGocICRHZupAgAM0jmOYfp660qC1HtK+eGu/
   MPOfP6yHOW5bROo9MzgxILA5H1hWaE1b9m3YPH3HB9wxtsR053WRFejJX
   Q==;
X-CSE-ConnectionGUID: GudgvxNDREuLrrXKobEYSQ==
X-CSE-MsgGUID: +YDChsvuQmGNFX/SOkF1jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85383661"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85383661"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:42:58 -0700
X-CSE-ConnectionGUID: 3AHA9MZLQ4SPltoWUHLErw==
X-CSE-MsgGUID: bitoO884Sqmhg7VX73saag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="287634221"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:42:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:42:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 15:42:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.27)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 15:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgjnMxrGusAz5LVuymfHwWaJx4kL63K1/Ys0ZGFOfNigfK1WuA1k10fKxMJq+muVuoqy+8einF7hhCBwn0pkDCCoNke0blvUTLCYSnozWyLr8SfyL1q+12ebcM/h5OEVIBxwdmMqOz5YTiDTrhX6Qm+GCQpN4aXeQ+9p/DytKZMOZAYmdZMPJ2hN43PYpz8HSmpcKnSeEM5ImorLjuOYfjwvbQPAid7izpERmnVDelxfHB8STMf/4kB1yfw6UrITPmy5Dql3Mlfis6vp7lIOplikvYL4oyyZ38+c5DKSyb2rW+GJ5RFJ6Qhgn/wo0ZTlZ5+v5EGOa/KZWFo2Gfi9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gpwJ/Io6dZwOtfISYZGP5bNYOfQ2gP5oNooywyO/MA=;
 b=A8bz6dhRhFxNUI22dOTKZ0VM5dLpDxOwWUpgJIMsafX0LKodMmML5ebE4wOgeFwSCdMZ7ERvtncHT7W5K2YJFObPo7rWnpZj6eA/iIHuXynGvFQ4CBXtM11WTYGjnBuaqNacz0PX3LyKUH8KrOJtzpqocfoLrlhB4Edb/IfGU7CUd+k+/v+QYBr7FogNjxgYCKarO26ubFtxMZ+iwa9jEy2+cHYksasQla1zyKAYwgRfowhbCZROuk4wnlKNWn+saEQaZcddjvv5tSd2Tfxs7mAinI4+m3f9Nlz6S/tVcW/LzS6SE1/mKWwxemFzoHa79OJ0Y80sfdfuDahNEIkejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 22:42:53 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 22:42:53 +0000
Message-ID: <4f875005-e07c-4366-af8d-b7173d2d3b77@intel.com>
Date: Mon, 20 Jul 2026 15:42:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/3] net: airoha: fix ETS QoS stats counter
 underflow and cross-channel corruption
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
 <20260721-airoha-ethtool-priv_flags-v9-2-9c15d8b71a56@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20260721-airoha-ethtool-priv_flags-v9-2-9c15d8b71a56@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:303:8d::20) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|MN0PR11MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c06df0-229d-4c9e-2c48-08dee6b03c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EAYpmyX9o4T6cQi+rwdff+Iaf5Tgc+dOAHi5fMbSGniZPPbEf+WyLSeT29d/cUQAeh36BFIWrwEcDKwrG1RruzZd84/UpIphtdkYqqDuKGr9Hv1yI9WJHxTGLPe+7DZFpU/XWJUKTSjfan0EQWBCfcpQ43HRLuGx2B66ui4CB67MPoFsRBthPbXjIekozWIlX944idbp0tgUHBMLd6+HC2UeYBitf3C8yjfUiS/EAxTvB2RKbpcYoQzf4H1y5YTicjlBX0xmsLhtU6yWvwMpCQ5w6jJc2IbhGqoBQ2OVOKXZHDtoMn9knaJQ2CeJise2kv3Q0JN70p5RArCN2b+9xKVvfAej5IsgoVcaA4Nj/kMhp7az1TpZ0ncSM/KvQp5BMXt8tp4cx/pwP7DsQN73W07SOXt2ZOMteZ8/za6erhgUItv8kHz+VNTi3uE8CkYJ4CJgEVPysuApXn9Xh/j5wDHOyI3n8R2iaSSXXYmbaHYKT5mc5IYHi4O5jqse7rvvTiUYIIpvNlwUu8eanu4AMC0X2KN3PGOkH6pvBVb4Ot99GbddWCGwTBtDSU7j+0CiY4O1k2ylH1qbaj4UT52V6E/1C0JTyzgIVs1tkktAJuokRO7bjt2y4R+X7GI1mULquGSyN7uwHdFC8HQKNS00EYX6+YBt1gLucu4SpVj98YI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHhzYmhEVXpWMlNaOTFDUnQ0Rngxd1hDUUhQdllwcXhMcmN2MWhHQVJFQyt5?=
 =?utf-8?B?SnZEYzhsQnFsYlVvdk1FczA1a2xpdTlLWXY0NzA0ckpnQk9WUmxQaWVrcGI5?=
 =?utf-8?B?VEFNK1lqNFE1ejZNanFKTFg0dkExd3VSaEdibURUa1VVbkFxS00zaVY3cWpG?=
 =?utf-8?B?alhrTEZpZVdqbmI2L2xkN21YU1VGY1hNSCtKWmdmeDJ2ZWhjdG5ONXdveXc5?=
 =?utf-8?B?OEtzVVdQcnBlaGlKK3BmSVc4U3Q2eHluS3FrUzRuY2tybGI4TzBYWVJ2cDJZ?=
 =?utf-8?B?aXkxT2xGZkxKak5rcXp6MXV2bnVyS2c0clN0SkVRbmI1MFdHQ0lxUStOSmlz?=
 =?utf-8?B?dFVpMHNEOUVrK1J4RS9SRHJabktha0FaeERiRnpuL0UxN0RNWVI1L29BaGFi?=
 =?utf-8?B?ZzZJSDB5MHowUStpbWtHcWdqeDBWVWhjdUNwQnRpZmhqTXB2VGFBQVEvM2F2?=
 =?utf-8?B?emlJVDZRZWJBZ0dIZUFmQXlZL0hyRE41b3pGbEZnUWxFQ2NxV0M3NG8zNHQz?=
 =?utf-8?B?TWJtMkErZTM1bDBxbTJRaGwreFpuSStvV2RnaldoaTg1RFU3NVE0Vk9kQkVQ?=
 =?utf-8?B?b3JHbUJOMy92Z1Q3WE1wRUF5cnFmZEJnVUxvUmduLzZPcS9ZdFlQc252R2d2?=
 =?utf-8?B?V2NVWjN3RkVtVGUrMnlvazJZUkNlOURZbDVSNkw5b1ZJdUlWekU2NEZBbzBj?=
 =?utf-8?B?SkNNRzlkN0NMdk1SMHFJOGRkU0tGYzU2ZHlCcGk3dWI5R2JaUEVqVE5zVjFM?=
 =?utf-8?B?UHQzQ0tjc2EvOVZCQkpkeWw2Z1RIdEdrYnIrbVpZOThSZFgrNlFETVRtVWNX?=
 =?utf-8?B?ZXZkNDR4NGlZMVY3bHZCcUp2YWdqN2ZLVm10MjB1akx5bjVvYnQvRkNSRzJp?=
 =?utf-8?B?WExOSHB2ZGFHQ1lqUVdsUGlzNkNIZWRyUEx4cVdUdzlQYXhCR2VWL3c2dmdQ?=
 =?utf-8?B?ZFU1Q3l3cERBc09IN0xmWUxHS2wwdFdEZ3hwOWJ0ZU1RbEhxeTVTZkd5eWVM?=
 =?utf-8?B?MmJPQXJlbXk4ODdrd0pwRTVXb2h6aHZNOGE3bHNrejRhQk81dUFCWUZwa3lj?=
 =?utf-8?B?a3E2WUJieEJMbUtZeklQR2s3c1JJL0xoejE0dUJ3NzhDemwwcjlMQWRPa0hq?=
 =?utf-8?B?UHJHemJXVlNuQ1dtZzJzbm5Pa3hpWncxMERWV21yak5GSHl2R1JSV1A2Ujhs?=
 =?utf-8?B?R1pXdEc2MWN1M0VYaFlnalJQdEF4TE5RZmp2SWVhSE52amNaRDl4Y01LNjdY?=
 =?utf-8?B?VFRwVTZWNmlJd3pKRVljZjFSSDZldStydU1hMmZtWk5aYm9LcTNTUFMwNnZH?=
 =?utf-8?B?cHZ0Rm9GUndWNUZGL3cvOVA0bFF1WFBGbWl4aGJKSU5SdVAxMm0vOWdOVnMz?=
 =?utf-8?B?VWY4SldDWWU1T0dCQ0VNNmRKZ2UxT2JubHoxcytoeXhrUWxlc2VqclZWSTlR?=
 =?utf-8?B?b2xqRW9sSlFxTm9OcFJmcGU1U0xPODNmZEZVSWhsUnFLZVNwNENDejlvSEZX?=
 =?utf-8?B?TkYxb0lmQ2pKYlBndlV1RjcwN1pETEYveW10cE9MY2N4WG9iRHFrcjV4aEk1?=
 =?utf-8?B?YW9UUVhpaFpSbFQ4ZlYvSGRnaVBBYW8wZFRHMFZQYitlOFRFLzh5aWxFRUdH?=
 =?utf-8?B?bHRxemJpcys5R1B3TTg2d2Jwai9oSFVhRGd3bFZOOTc3SG45cFFGNzhBV2F0?=
 =?utf-8?B?ZGc0L0pKNFBkN1BsVzZwcmM3dlNXTENVU0s5ZXZMaEE1VzkyY3Fyc3YxRFpq?=
 =?utf-8?B?dUtHZ2lWdG1vRFZicERBcWpYRFgyOGdPV0MzcFc0WGZIMi8rTlJLNGNhZXNv?=
 =?utf-8?B?dnFWWEtLMzF5VW14bUpydzFPOHZseWdCL0dzRDd5N2oxTEthd05zTThESWJM?=
 =?utf-8?B?RmlpVTgwUlgzMDFpUDM0TU8xbmF4YlZLTUFTQkRxVmc4SHkzMHZUZFlabk02?=
 =?utf-8?B?cG1nNlFadEVtVUVaYjRROUdKT05KQm1oR0VQaWRzN1F6UGxxUkYrOW9VY01x?=
 =?utf-8?B?VjhnRW1TcVVyN1ZDWTdZUVNVMjRGSndOOFc5ODd0QnMrVDBXdkcxalArY2lQ?=
 =?utf-8?B?d29BZ0NGcHpUZHZXSGsyS1ZxbFRQZDA5Z3FmdXQ5WWxXVjkyQlkzdm1ZcUhT?=
 =?utf-8?B?QTlvdlNmQWVHTUxhSlRtTnhva0dPeE10TFhIc0tWaFozT3dhd2g2dVdaczFN?=
 =?utf-8?B?V2FUQktVSVJ6NkhRNWFnNk1oS1AwbFhESnRrd1hFd2V3Q3pyUzNBRmxRc0pz?=
 =?utf-8?B?bmZTS1JiSEQ5aEs3VGdhdEJ6V2RldXFsVmVqeHNHS3Fic3dQamppUjhkMU0y?=
 =?utf-8?B?ejU5ZFAzN0dZcEtmRG1nempkdG50QnJWM3dxbjBkMWNoT1VrU3oyZz09?=
X-Exchange-RoutingPolicyChecked: TW9iSPVESyrxc92RbWItVcIsDsQlErn7WTc/ksQAmFX/HTXi6LaNgYjCO67gxj9Nn5US/olySgMfw9L1rkPpUO2YWS43ReajbaYRngOBcVbqS1lchBnNKGv6BKv7fc2AbZVEKLrFoW+Avoz+Oh5glHJTw9jUZsVnAxg7zFkWBhfYhn0NUm5rktSzbBTCjLKtLdtRqGeOdahOyrtPsThkhWqMK2DV9AJzp5ehfNqmeV2cDQrF+WF7jN0li/ghZJTfIrRUhEAtJlCq0/JeDulu3CszLpTeM5pGR22/OzZO3GSUDcGpLEZfe5TykPRE2EFukGghLUxVhbc4vR+M8usT+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c06df0-229d-4c9e-2c48-08dee6b03c56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 22:42:53.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tia4RVZxd8EGX8W5LVp1osQEGPeeYN4FcwmJD+aS/OA9miOB3MUlrHETTw04iy/mcm9YGOwGJeP2qEON8vO0cFgNVCaIKORzrhdlzYU8Z9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com

On 7/20/2026 3:03 PM, Lorenzo Bianconi wrote:
> airoha_qdma_get_tx_ets_stats() has two bugs:
> - The hardware counters read via airoha_qdma_rr() are 32-bit values
>   but are stored in u64 locals and subtracted from u64 baselines. When
>   a 32-bit hardware counter wraps around, the subtraction produces a
>   large underflow value passed to _bstats_update().

This issue would only be a problem during rollover, which depending on
how fast the counts increment may not be a big problem. I could see this
not being worth going to net since it could be rare enough that it isn't
considered a widespread issue...

> - The baseline counters (cpu_tx_packets, fwd_tx_packets) are stored as
>   single per-device fields, but airoha_qdma_get_tx_ets_stats() is
>   called with different channel values (0-3). Each call reads a
>   different channel's hardware counter but overwrites the same
>   baseline, corrupting the delta computation for other channels.
> 

However, this issue seems like its going to cause a problem every time
you read because any time you use a mix of channels you will get
corrupted values?

> Fix both by:
> - Narrowing the counter locals and baselines to u32 so that 32-bit
>   unsigned subtraction handles wrap-around naturally.
> - Grouping the baselines into a per-channel qos_stats array so each
>   channel tracks its own previous counter value independently.
> - Splitting the delta addition into two statements so the first u32
>   delta is widened to u64 on assignment and the second is added in
>   u64 arithmetic, preventing overflow when both deltas are large.
> 
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")

This targets a commit which merged in v6.14, but the patch is part of a
series aimed at net-next. Could you explain why this shouldn't be
separated out and put as a fix in net? It seems pretty obvious that
users can easily reproduce problems by requesting stats from each
channel? Or is this not really possible to trigger from userspace until
patch 3/3?

> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 18 +++++++++++-------
>  drivers/net/ethernet/airoha/airoha_eth.h |  7 ++++---
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 41c1a0ffbdd8..aaf2a4717d12 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2482,16 +2482,20 @@ static int airoha_qdma_get_tx_ets_stats(struct net_device *netdev, int channel,
>  {
>  	struct airoha_gdm_dev *dev = netdev_priv(netdev);
>  	struct airoha_qdma *qdma = dev->qdma;
> +	u32 cpu_tx_packets, fwd_tx_packets;
> +	u64 tx_packets;
>  
> -	u64 cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
> -	u64 fwd_tx_packets = airoha_qdma_rr(qdma,
> -					    REG_CNTR_VAL((channel << 1) + 1));
> -	u64 tx_packets = (cpu_tx_packets - dev->cpu_tx_packets) +
> -			 (fwd_tx_packets - dev->fwd_tx_packets);
> +	cpu_tx_packets = airoha_qdma_rr(qdma, REG_CNTR_VAL(channel << 1));
> +	fwd_tx_packets = airoha_qdma_rr(qdma,
> +					REG_CNTR_VAL((channel << 1) + 1));
> +	tx_packets = (u32)(cpu_tx_packets -
> +			   dev->qos_stats[channel].cpu_tx_packets);
> +	tx_packets += (u32)(fwd_tx_packets -
> +			    dev->qos_stats[channel].fwd_tx_packets);
>  
>  	_bstats_update(opt->stats.bstats, 0, tx_packets);
> -	dev->cpu_tx_packets = cpu_tx_packets;
> -	dev->fwd_tx_packets = fwd_tx_packets;
> +	dev->qos_stats[channel].cpu_tx_packets = cpu_tx_packets;
> +	dev->qos_stats[channel].fwd_tx_packets = fwd_tx_packets;
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index bf1c249255bd..bf44be9f0954 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -553,9 +553,10 @@ struct airoha_gdm_dev {
>  	struct airoha_eth *eth;
>  
>  	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
> -	/* qos stats counters */
> -	u64 cpu_tx_packets;
> -	u64 fwd_tx_packets;
> +	struct {
> +		u32 cpu_tx_packets;
> +		u32 fwd_tx_packets;
> +	} qos_stats[AIROHA_NUM_QOS_CHANNELS];
>  
>  	u32 flags;
>  	int nbq;
> 

