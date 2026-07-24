Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693935F179
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907031; cv=fail; b=df0zYIFhq4UR6tKXlU6SRmK3ixxa5waWojGLR7gMIZ1dVFgRaaLq3d/xINUPCD9v48WhVtcw8DGbGwVMjgSh48JV02upPUYf5sP/VuHn1F0YZOzyTsJoXXsEszL+OK5jerS+N+ukcqcFMlG1EaCsGHds8Vv7vx2UKVwVsfMizmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907031; c=relaxed/simple;
	bh=d+TmzgeEWtPIhZlEr5U+xQr1o1W+6+pZ/3IDBIa3Vvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sHFKi7/tNW5OfcvZtweD5w7mH4iWMdv+pt9CB2YJNeviIFgc4cY0SDAznvKYDrrcCcW+rPOkmO/OELeCzz0Z20yHYAVRBDx28ZyGnqtNgUfM1SK1uAM0YqNmUtSizPnPw4vZi2xjs1J/gWRe6SrA8js3L2Elyb6eaMzgj1IwUKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4g0lGb3; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4g0lGb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784907030; x=1816443030;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d+TmzgeEWtPIhZlEr5U+xQr1o1W+6+pZ/3IDBIa3Vvg=;
  b=P4g0lGb3dZMCgvsT5wmBx7u1h8iKzgpqCo883/tNFAnO74rk2cyNOY4W
   6Eo7UO7gIjjbLATJ2HfBEvDbzkRE+TIAS7o8vTI5czPeD6Lh8rMt477qG
   dcTBLhJAiIpNM/4Roo6oW5uJlnTtbixLqBW0cMqpZsdax/JrmszemDSaa
   Po+6Yjb1yHH8fI913hFsfBcL+KM2ngmHc0dqYbXbgj2jiJijiQKY4/Vjv
   2W6VBvR8VDhayPekmsgiA6BQYV8BwMxbX/neUYMAtHSqbLv4wzkwuR4zv
   uY0iDJTaFwgJSfT/GqcMyusgps6VoCyhWRltxPJb3muf3a9eoqAIioc1/
   A==;
X-CSE-ConnectionGUID: K78ORgvsSG2qVXG37WwKIA==
X-CSE-MsgGUID: 9xGaKCHfTd2yW+IPKxMt5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="97091145"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="97091145"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:30:29 -0700
X-CSE-ConnectionGUID: +bhkRZ4ES0iK2f+RU9+uEw==
X-CSE-MsgGUID: FF5aKPhkT/u7sr2i0U2JjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="263050029"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:30:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 08:30:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 08:30:27 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 08:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ45HmqwVZOisdURWUGH6KiDveQgt3y1zmqiS07Afan+8lNSuHsCAq0OKdUZj9kwyvUKuzowAU/ktQoUS+Ym8fNcu8+FtMKPMvOPn4dy7CjwMYKutY7ROKJrMVdksxs4cugioOyE5k8Nz19ejA19FJDF+NH1U8eB0tBj7pt0zPrKwsetqFFGuvHE4ohs/zrYdWLlZym72AlNVgmFgTFFbLKMv2hzeezRGVohbMiRfhMdACy+qELh06hWTMwFWuw/Fcim5x1pPf0LB/SDvpPz/bT6McmIGUTvJWKkVp0m5HhVg0PSPNEAlUErbsTdsTgnBGY+iatgFY/h/OpKRnvUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClWg5SJuEy7gKdFCg6VNTlz1AsBoerJbR3oKh6WX8pQ=;
 b=jLGf86WCPmtnNRvIKvTMfg9Vl59FfKNPFfRHdSxFuC5qxxop1NqHPPLjuYPtsz8yiBCk+CdgQNSis14mgR9/py+tMcDd0bBbuTXtyuxzvBTCDLZZN77jgG06pGggprFx/y8FMzGsNzgA9lbmzJw3OFZNWINMxCFqgfR2ocnHsmFtkEvU/wDiktt1MmAr/8giVOcrT+Bmvk/YxMlwS5feCjsqISVouLvTu2KEHeQ4VQbhhTFPxFL1KAkvdYIBT5NxIH8IaA/1hv2xFEdXPlIG3RaXKFgEjhNIyMCRDouKM3frM22uLVlW4yw6YT4epBakEbOTrgzsopYvPRqZJsuZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.12; Fri, 24 Jul 2026 15:30:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:30:20 +0000
Date: Fri, 24 Jul 2026 17:30:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, Chenguang Zhao <zhaochenguang@kylinos.cn>, "Jason
 Xing" <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next] i40e: xsk: use xdp_build_skb_from_zc() for
 XDP_PASS
Message-ID: <amOFBsiX8IWTBvPH@boxer>
References: <20260724020125.246333-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260724020125.246333-1-chenguang.zhao@linux.dev>
X-ClientProxiedBy: AS8PR04CA0185.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL1PR11MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: e9ee8d55-1595-44c9-6693-08dee99878b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: aIastmTye1/762ANua40zPoPnQS8c/xUBUZ1l4UfIQrum0GU/vsf66MlCLxJMZSdA2GQozPjDxWP9DpilDYunOxL/5rerH/ThdTcefqNTcLe04tREfKx2GAxgwmMime3FZI3Ss6KsYsU4hw6c8cc0bbkKx7q5LebgxU/sNft+AM6QE5p8dRWspquRUeXnH4EYFPCnu643GShpKuHEQ1Y4Xt3o89daKUsJJotlkvdNSQpo4k94n+2eQWxhUYajtzepjhPdR2EaxrqpuUvfnNjURCk4inDwamGOIDzFxacJJDFF/qA/PZl3nShIekP744XCHGYquGcuHZxvjqr8GhHt4GmcChjENMjPzXQLT0SlF8CWLa4ZfxOk+ZRMHxEADUMifrH1RVtA/8xclMLrr6jItbOU66gvHcdFIzFhVwDZPwGmkroC2ErjYqBJ4VbSdhCHGNTzE5QlbSx1OVQ0O7ihQFXa11rRqddraGHD0ap3Q+wXgk2COajdsearePzUfokZnA+x1wfvHUV0AvgMOW5lq1BNnnfWWRvwUAWJOKppLF3JK+HyHNwqdYv8aj2YoOaNSSHMQklTffC7Tsdt9UJKHmjsNqJ+3zSqUIN6DeuY4Ql0sBYhvYvJhRq0U1kkJMi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gSL+JCmgJORJawOROnYAEXoCcnTC2Nnr7lNJCg6fl4i2YnmBUprQhRhUbJNZ?=
 =?us-ascii?Q?//FfHMvP6plMj2FWUaYOAEH0blpiXGnUfY9/EwBsoE8X9g5ATdo/VS3tNn2Q?=
 =?us-ascii?Q?Ti/gGd9cTCV+KvZPgqWmpVUcmVnUIWDM9cImwSHCgFheguxIUuF8ttcW7izf?=
 =?us-ascii?Q?f3mjRyhmlYmSS3tQ2dsS8GNelhlskzpbPy22n35BYtFsiy9IcdwgieRSQB+L?=
 =?us-ascii?Q?P1v56y83ZmzzrHgZSepNaM0mnoL9U+6kpRy1CTXSIp03k1sTFBxNSHTYRcEj?=
 =?us-ascii?Q?8C/nr5zDfb1L9yWe3ArFGtEC6CXMcfOlGRr2+K2VsaVY5AMVaQdycC0+6ZI+?=
 =?us-ascii?Q?ugod+pIsR6nC8Xs7DFzhsAQNv6K3uS1ZXdUrJjFj53vNoBd069OktyT8fOIN?=
 =?us-ascii?Q?JD4uO/MdiKea7tfgShn4CGMQxmi6nTt7Aw+N8QEhMZdWqmRP3KtH7MZQf9Dy?=
 =?us-ascii?Q?SqTojzRFB1VYXaX774KlVXV65CoXBViShJycWozo7nboADYg5mXQO8cQUzbg?=
 =?us-ascii?Q?s4T7lubNsAk8CcU8UQYD4F/lY7F3NLXaHj7iTzIAH+2A7ATrYGzX2oa0iHfc?=
 =?us-ascii?Q?8g153oonnq76s/9B2UTdyUzkWUMEOg5meMSuFjEq+lZtfF+0ogf76rClCuQA?=
 =?us-ascii?Q?GwP2Elq8NqFl8cspa1E+5WgRSLLTOWSyoJS9rlBaxYtUC1oxViEXM/RWktKn?=
 =?us-ascii?Q?hNsnZSvACFbXOVQ/iSiCr1HUrnEvNtPtu+WwD7k+RuKMVNxrbxj9bx0ZQRqv?=
 =?us-ascii?Q?5AjgzbUZ8C6iy7ieBMhdMuYThhkhNug9oZMZDDI68xnWhdeniK99XoZj4HlU?=
 =?us-ascii?Q?jNI81VMd0cPSJJJQvRiV1wdthpCrrMIUAu0FDXFrXkt2TAWFXUlLibmaGPMi?=
 =?us-ascii?Q?ggFsnkn9348u8UXfpj8mNceZ2eASEcor3qt96+Q7pcxWIV8+ZOk7fY9lpLy5?=
 =?us-ascii?Q?t9nU/vIPQW1sYsEBq3b5sKDWx/6bUZnqiRDgXHzlEY6yAolxWjBDtprarB3/?=
 =?us-ascii?Q?YRx7s63JsDVYlvCiFAKXRzJYCPK76EU3PMT5wK04jyyV3R4wjG/pGcLIB4K8?=
 =?us-ascii?Q?2+wN9sKo8q4ORyQgrg94k8IfNkJgEsGbhaeGp1qaTjOT4GIr6TNxacGjBpfo?=
 =?us-ascii?Q?VVtPjMaZdFmx8qbl7YN1aXhJTTQrN+Vjus/WRhKaDVdpKsybYz64yVDB0Iri?=
 =?us-ascii?Q?PNZ8xY3pM7OVWj3nJlqBscFYPPd542LfbxoMQ/aq+aqK7FZRhkNkRXFvk3Ma?=
 =?us-ascii?Q?52l69v3M/B+Q0U0JtfZbEb+Dskhyvq6aIijObVHCaZi28wKtCXq9A//fWvVx?=
 =?us-ascii?Q?wEi9Lte7ptMZ06wXGBG1bcbE/TZquuwroc7e7tuznQ+Ho81/UNmv2po2gonW?=
 =?us-ascii?Q?vGFn6cwXFMqliY/d1PwN1amcAkM2u5Sp9OwnyZ/ZZsU4KQYxPrhWhE9mmsya?=
 =?us-ascii?Q?Sap5nk8uWLF9qDk4c/SPeIruaQR/8AmYKF5YxIZWH9QQ/nRb5QgQ78+4gfxL?=
 =?us-ascii?Q?EmxsMLS1SRYo9n8occ5FmRkh8UGSdwUnYYtwEySMGxbIeiKAIQOY3iR066Wh?=
 =?us-ascii?Q?Qe+tNfjAt3t6HEWCvMRMQLkUXw+A7lrEN7F5+VIDxF3chsXP2VJ98lVrpOUV?=
 =?us-ascii?Q?f7iLaJ7NNwaklrkXzvEB7wzEFYpS7ARLVUVI2fvMezHYn2+DmnowqTqJSDL2?=
 =?us-ascii?Q?ago3Mpvm5y+rW6MZLEhu6zrTOqPm5oul3LQnt+qLxkdJ7eUqDgYD7OOJY+MK?=
 =?us-ascii?Q?kt33jPVS/39kM18GK8s87jVlxL5QCYY=3D?=
X-Exchange-RoutingPolicyChecked: rx5QhOm1be7e2JVM7PJCcaFSA6e/wMkwvCOGDfGjPppsnHRraV8Xvf207OdSok2z0yjXV9QBdSpTRP7JvN6CO9+H/tmkcUUxnCcMjd4DgZ5JKew8jA2dX2xLhioiNnoIkYTlNxQ41A65+RAc0v17a/ZmbngBe82rOQplyw8ktOdIAoVInHVM/3KBSBxYgpZ3btn3cDxkx41Glgl302zsojLeJliXEuXfGT+bslO51sh8lbuaxgYu5O+eNyR8xlLcdVVu0Pxr7vl57znsO+xLTdKNd7i3RMR8tk5LUI348y+K+XyASbcRli7q/Gp0goKzyUlXoRnUEDmOsrLOD2S24g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ee8d55-1595-44c9-6693-08dee99878b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 15:30:20.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yK2fPG2hHq4uOgsVUcJvPWuC7tyOOyD9kl5Mjsrgb10ntknOt1tJ59KNqnMmyERbPpmVPdtS5VUvSczmcyvTg9TpW03NYXYie4Znpja7meA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287
X-OriginatorOrg: intel.com

On Fri, Jul 24, 2026 at 10:01:25AM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Replace the driver-local i40e_construct_skb_zc() with the common
> helper xdp_build_skb_from_zc(). On failure, free the xdp buff in
> the caller. Push the Ethernet header back before eth_skb_pad()/
> i40e_process_skb_fields() because xdp_build_skb_from_zc() already
> called eth_type_trans().
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
> The earlier patch was discussed on the net tree.
>     v2:
>     https://lore.kernel.org/all/20260717012416.168107-1-chenguang.zhao@linux.dev/
>     v1:
>     https://lore.kernel.org/all/20260714025112.284724-1-chenguang.zhao@linux.dev/
> Because older kernels do not have xdp_build_skb_from_zc(), only the bugfix goes
> to net; the refactor lands on net-next.
> 
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 74 +++-------------------
>  1 file changed, 9 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 9f47388eaba5..13932b36142d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/bpf_trace.h>
>  #include <linux/unroll.h>
> +#include <net/xdp.h>
>  #include <net/xdp_sock_drv.h>
>  #include "i40e_txrx_common.h"
>  #include "i40e_xsk.h"
> @@ -277,70 +278,6 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
>  	return count == nb_buffs;
>  }
>  
> -/**
> - * i40e_construct_skb_zc - Create skbuff from zero-copy Rx buffer
> - * @rx_ring: Rx ring
> - * @xdp: xdp_buff
> - *
> - * This functions allocates a new skb from a zero-copy Rx buffer.
> - *
> - * Returns the skb, or NULL on failure.
> - **/
> -static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
> -					     struct xdp_buff *xdp)
> -{
> -	unsigned int totalsize = xdp->data_end - xdp->data_meta;
> -	unsigned int metasize = xdp->data - xdp->data_meta;
> -	struct skb_shared_info *sinfo = NULL;
> -	struct sk_buff *skb;
> -	u32 nr_frags = 0;
> -
> -	if (unlikely(xdp_buff_has_frags(xdp))) {
> -		sinfo = xdp_get_shared_info_from_buff(xdp);
> -		nr_frags = sinfo->nr_frags;
> -	}
> -	net_prefetch(xdp->data_meta);
> -
> -	/* allocate a skb to store the frags */
> -	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> -	if (unlikely(!skb))
> -		goto out;
> -
> -	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> -	       ALIGN(totalsize, sizeof(long)));
> -
> -	if (metasize) {
> -		skb_metadata_set(skb, metasize);
> -		__skb_pull(skb, metasize);
> -	}
> -
> -	if (likely(!xdp_buff_has_frags(xdp)))
> -		goto out;
> -
> -	for (int i = 0; i < nr_frags; i++) {
> -		struct skb_shared_info *skinfo = skb_shinfo(skb);
> -		skb_frag_t *frag = &sinfo->frags[i];
> -		struct page *page;
> -		void *addr;
> -
> -		page = dev_alloc_page();
> -		if (!page) {
> -			dev_kfree_skb(skb);
> -			return NULL;
> -		}
> -		addr = page_to_virt(page);
> -
> -		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
> -
> -		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
> -					   addr, 0, skb_frag_size(frag));
> -	}
> -
> -out:
> -	xsk_buff_free(xdp);
> -	return skb;
> -}
> -
>  static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  				      struct xdp_buff *xdp_buff,
>  				      union i40e_rx_desc *rx_desc,
> @@ -372,14 +309,21 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  		 * BIT(I40E_RXD_QW1_ERROR_SHIFT). This is due to that
>  		 * SBP is *not* set in PRT_SBPVSI (default not set).
>  		 */
> -		skb = i40e_construct_skb_zc(rx_ring, xdp_buff);
> +		skb = xdp_build_skb_from_zc(xdp_buff);
>  		if (!skb) {
> +			xsk_buff_free(xdp_buff);
>  			rx_ring->rx_stats.alloc_buff_failed++;
>  			*rx_packets = 0;
>  			*rx_bytes = 0;
>  			return;
>  		}
>  
> +		/*
> +		 * xdp_build_skb_from_zc() already ran eth_type_trans();
> +		 * restore the header for eth_skb_pad()/process_skb_fields().
> +		 */
> +		__skb_push(skb, skb->data - skb_mac_header(skb));

This feels a bit counter-productive. We would end up calling
skb_record_rx_queue() and eth_type_trans() twice. Maybe we should open
code the bits from i40e_process_skb_fields() excluding the two above?

Or pull it out to internal function and make i40e_process_skb_fields()
call it.

> +
>  		if (eth_skb_pad(skb)) {
>  			*rx_packets = 0;
>  			*rx_bytes = 0;
> -- 
> 2.25.1
> 
> 
