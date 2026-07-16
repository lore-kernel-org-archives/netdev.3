Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECB42466A;
	Thu, 16 Jul 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208860; cv=fail; b=a9FwJz8PkTY8tBaLPs4oKP6i4nSpTMNu9P8OWEA+MovyoTjMTx8y3d0f0Th4MSUCy1avoCgWwiXr5WBSj7honcfH8LRTAo0rrdH6O5WF8hP9h1r11iQRCLUXYoap73uu232ip2EnzikCOF+JnS/j0WA9Pvgadp6toxxlSAFkDUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208860; c=relaxed/simple;
	bh=HXn/senWEE71BvrH+69yzjJOFeS+VeBEJCWRBleD9a0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lalhTSNu7tKMarKFoiSIe5bXV9jlKpmqn9wd1jqv2silMrsmaJU6/LuGHMeEBL3yg6PEEZp+jaWnWxc6OMmcXcAtuBq/Jiey5KnoTlZ1FaaCQoJg7zbruEPTa6mG3IoygTMMCTPADB1c2q8zZRy8pZ7ISzTi5oGK5A4zcm98n+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg3qr/xS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg3qr/xS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784208857; x=1815744857;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HXn/senWEE71BvrH+69yzjJOFeS+VeBEJCWRBleD9a0=;
  b=Hg3qr/xSZkOSQN7Yw5bs2CFxNTuW0APbMpKhvFvztrYwvde4F7A0BV9O
   9bg0iPjFgwji/xg3Qryw1gfD+6tZTI5UKlFD37wi8LrU7fMP0HyOG1CwR
   QGDp3DbNIocB6uktFe2orFeemEH741AXaUqq+X+1L6VubnJpPeiCPHbht
   5of+jZAD1jzTvRBZjXhBl2hwEgQSIkt/435ozp9Q7qNwt2EH1t/tK0qvs
   E1Nf3nWaXw12cPnVXdbsxua1xph3XcyJJKeULU6tRo14Ld1wmeqPicQtW
   ZNhdJR6IXJx8QTQ3TzRgkNb4IIkHqCfg+G8v2AaB45YyJZxwRXsXD04Eu
   A==;
X-CSE-ConnectionGUID: bkOS3fkTRzuFXztG70+ucg==
X-CSE-MsgGUID: fqF6M5FhSna/J0KuqTOOTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88693558"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="88693558"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 06:34:14 -0700
X-CSE-ConnectionGUID: guY6u94DSCCc+vSq8yyqDA==
X-CSE-MsgGUID: kDw0AwJiRhqO8PgH/XYkJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="250141750"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 06:34:14 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:34:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 06:34:14 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 06:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLHdEKiTg7qd0yfgCsWrToFwlUp0KqFwwlj4nxvapxQChN/0WWBp/HFIWY3IodxKrWvt+XrGbjY4ZmL1ohcV4lO/bc30m5NtUmEqIbLQzZ0AEmF6ZXmf1JIrcntzKSYcdi//uvNimihaKi5J6RImP7YlC9DH+e2RFVpwboRxM+8MEB4aQI3yLYziR4FeKk+GX+7AnOl9UE1hll9I8EKiMa/8DOu5JYdbZiK5X++5iMKCFZt/ZHoKMNFlOGStng5ghfAfMqWMXUzxHB0RS64DKHYRdJTJrRfXsnZCeWbJiLxQllWdPDmf2jqWfGYObVa54NKLYLrsPWCmQIH4pL77EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AfmADMhdZRzM5KeEYa5i4Z0d7agElKnsLjOokjf0TM=;
 b=Qy6cgWBeFgatHnXcVt2QAKI51SDUPnpGCdOezrBc7jtEKiALMtEYUPGTDrzimsxiwzAR2ovuwgqem4UhHWgrH3Dphy4i2oiy8IQbUhK0R55f0epNV1ANoR+7JwOMVZhYtzXjtK0rDNMzsbSMhdK5eD0gJyIdrpaUdXxY4aguu9NFkz8td3+EGpwjBqCwK9beLOJv9PGYVTqlwPAW01MwhkBj++FpmDsVHfo41w10FLbZ+Ai/fDwawauxHslLvdDkId+rpYhxZ0QprZhlsihRMA36DA5KwPnMjLz8zaFG0a4nVbcg1f3KLlNP4h+LMzvpE7m2i6nm4o7OP74c7rN3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Thu, 16 Jul 2026 13:34:10 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 13:34:09 +0000
Date: Thu, 16 Jul 2026 15:33:56 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
CC: Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
	<sedara@marvell.com>, Satananda Burla <sburla@marvell.com>, Shinas Rasheed
	<srasheed@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Guangshuo Li
	<lgs201920130244@gmail.com>, David Carlier <devnexen@gmail.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v5 0/3] octeon_ep, octeon_ep_vf: fix RX skb frags
 overflow and page leak
Message-ID: <aljdxFID/08xcUS+@boxer>
References: <20260716063432.2908100-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260716063432.2908100-1-maoyixie.tju@gmail.com>
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB4787:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e27469b-8b98-4262-90de-08dee33eea83
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cTR89CiaPHE8hZwN03RfWM9yKVWuVwaHl1y6V7IQAicSMJ5gS7LM6aZ15YU7sR+lBcQnimdqKTijPJDp3yRWBHpd4ThnhppwMRTE3UDVmOrTN3ecygORNuCjB0l0hfk/PPQmHQ6X+yWFeS0gR+mUyhfDQMs2a3zPHBW2LTkN5y/yP25xTNxqDPFbhLMYW2oF1fpxZBDWI82+EkG1kk/QFOWfqbNCs2FkGWrhFrziRd69CwDyn0iLBbDpV+3cG4fZxVUttPPcnHFbDouHeXDS2z0uqOAsVpk/xu2QPf6Bdt9u1AcAjsRzojio4IneZJ7HWkIJ0WPgIp+lTu4f55Z3MNhRcGkDMr0LvM8jbUZ0bMB4OGaN3YIVEdk9rHPTu8dd6trWToQLHtxGxYRzDB/lJfxAIvJ+Ftouqe5UHsSbJQEsZYlgL8WgL9z6GCQefh7yMF66vsgYljyYKIAwN5lK9TffB+0IaR0/fQ8GS3SHJ4IcyVUCyg2XYN674zimxBGTiktEyzkbtaBjfjX3mvoocBvimj/OkHn0XG9ZXAaqLBRgyBKl4ef6xZCjU0U++MqfeZkfcqhD0WwlrhcRLVq4LRFtTosareOBIgc7wOk30YPp5vUGefw1IjCYULhZionOmdCqmUwkEYQRdR12YxzxaJ/2cDQ7NWQw4SjfB/KiFEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ujQcjuUUw3Gg0L8LaGItlU8srw9xw9TI7+0Whvc7Whw8zprozCqbXvjRHg12?=
 =?us-ascii?Q?6G1+JlARAOEm9/g7yUOVBthjntyY1DL859wSIacJzCEBzOL92GBU/Kw/T/mF?=
 =?us-ascii?Q?b36qvqqCHzRvI4NXuPYY1tdaSHK2WtefFmr/9EoYqz9S9s8Klh7MFu2gvRP6?=
 =?us-ascii?Q?VkbHIgvIK3zqLc9lNfDAc7IzziTlZ2B3fkf5/Cl1XUK81SEThqXp2uscNV+K?=
 =?us-ascii?Q?ZCrZLYe2gp4shQqdHAO8SaGDFmYrtNgZkm3mIVZeQ0wsUplQQh5QeaV0znMY?=
 =?us-ascii?Q?wInrqMHcuyPTF7ulL0x8UyawEvwC7oObl/c/7OA7g8OMVko4TAR7AgOy6Cpi?=
 =?us-ascii?Q?U+qgNqRr6G6kH1ba27PtyK52COKuAnKvWGYWgWeM6BzVV6dkatx1ODsjxsVl?=
 =?us-ascii?Q?MOMv+i8S6ILke7fvQ29tezDd44qq9USsmX0puLsTfflvSKtQYROuauljlL5K?=
 =?us-ascii?Q?H+vf2F1glNcrgpCHT6q8ayAS4TcHTEQVo6QGC5As8YXX4UeMreCSYk/w5Ulq?=
 =?us-ascii?Q?ZosyUoYZrfpNc43Cg87XtxZA0piBkSwN7vD+/jBdW+17j1xND4e0kFn+VMYR?=
 =?us-ascii?Q?NDYoNbD10NE4QabXiGIJSzoyTSAmwSZprzNNSPnqJZ9SOJ82wulj5A1mXLs2?=
 =?us-ascii?Q?6jFV8sl4xcJ05+Z+EXYAW8sF5PBRDwIBdsZV1DjZLDS1wTv5EozSTkPQQHQ0?=
 =?us-ascii?Q?Evbiur4S4jgfhgfglT+SjDdNumxzqfzwiRJn+V/PLU87BRtXWUHQGJhq1lbe?=
 =?us-ascii?Q?9ZNDs7rUxqlazARqMjyn8iMEzby/ngru2yrkEcu+Q2OErFk6DcLkFJ3yimzZ?=
 =?us-ascii?Q?721SRxEEw0cTS6Wd03Serz92cbgmsjAN7KroX04Odxe/eKfJ9e0Srwo40r1c?=
 =?us-ascii?Q?zM0iDiO7EiLCsi7DbZC8y6v0pzLJi0/kfxRgEeSTCprweDd7RKOJ01pzdbYD?=
 =?us-ascii?Q?OmFdWMwtfprtzoeuHbVgQlPki7SUZiYz+TjIOJ8GUgGAe/ECGPWsMOEplqyw?=
 =?us-ascii?Q?Xpc+jq/YTsNUXSq7l8w8P+mp2lqSs10lccnaQd3RcKhmRm+OW0iTCGpUaIKg?=
 =?us-ascii?Q?a5JymiOSMJ5VyPTvt2oHWqE3cEGt8/Ba9crlvmg9wmG6SvNfyvXcOhbeJ/E5?=
 =?us-ascii?Q?J60c+O8pB4WR7lCrYI24ZVmRTEWUP8zE07z3D7u7Wowim1np4Lz+ZBo3B1Rf?=
 =?us-ascii?Q?xyO+F87+zHYqBkDtGobYZDQkx9y/qjLLHrfpkg1bAPgNAYy8u19sWIwj626b?=
 =?us-ascii?Q?uqF1YetTf1db0RMFO7uep91hwZb90rxaAd/l+lD9+9oza4bJs6hkZlu307PX?=
 =?us-ascii?Q?ia0ykFLXBHZhShqNupGncaDI7e1iJUxlq2mY5FhB8LYArJS/ns2A4y5oS9AV?=
 =?us-ascii?Q?GOS8dLUa6j7rCWY+AsLuxtS83zA6/bIaQJ6mQCYo1KFE+mguYMnOAHxQw9TD?=
 =?us-ascii?Q?8ecMRxSVh2qLNTlrUAV8cdtV5YPlc4Zu9JI3yaAMjU7lLusX8A53bWCwOR+o?=
 =?us-ascii?Q?PmJ+bE4RTVAYOEgAkLYNYx6k44Y+egzgcU8Iq8fkWIUQYmGNed/tfSROE1Tz?=
 =?us-ascii?Q?Qoot8kSey3/2k0kb2fzKL6GPXeQeDnYV9sTzDhSzOaoNvagWxqTf7cx/tXNu?=
 =?us-ascii?Q?ap8pCF/pWJoENU4PCS+jOEfpPc5BQdtgocrNel+/GNYQtGk/9/csPPTkUJWP?=
 =?us-ascii?Q?/6mzVU9Idps7QRXfRw4uByJKgiGJHWGMd5vTLXmPcyIb1KUW2xtTPacXUCw8?=
 =?us-ascii?Q?A8fW0JBBswB0Lv8Pow3Zckr41XFprgc=3D?=
X-Exchange-RoutingPolicyChecked: GZbDDlU5JKApuyaomHXZ6oJU1edoj1GQTCRK1P/35YFjaaptadC59V+dyP16bOksO5Re+rHh+b2fmhklc+2r3l3EF7I7nBptBHzjAg8+jFaR2kiGJijMZznO1SuqHyljl5wj0nOVXFK/gW0kZ/btdVI8oLikUbmBbAv0Z1wnbigadCORqA/TtXvlvniQCt31oZbQNUX9zFxTUDERasZmvEps7JdhUpW7Hg7E7M5x9b0lx77onCr8CavrEJXfOAed910L6Ag7c5tIsgqtfnsnupKacQnxai2ypinAvZU7GVJ9oqocAdtPYDHg8pdL3HnEiyOXTLUh2kW2fcDAfthMBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e27469b-8b98-4262-90de-08dee33eea83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 13:34:09.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhq9hTLyDYL5uSZQrWxoWntIl+mTIo3/j/74nTSx00XWSFpIMrQzuyvLSumT/WwBbU+NSQFhPN3E7zxkNRkWZzDdZXGg9MgDQCkY1ZLZOaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4787
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 02:34:29PM +0800, Maoyi Xie wrote:
> The octeon_ep and octeon_ep_vf RX paths add one skb fragment per buffer
> with no bound against MAX_SKB_FRAGS. buff_info->len comes from the device
> response header. A long packet needs about 18 fragments. That is one past
> the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
> shinfo->frags[]. Patch 1 bounds octeon_ep. Patch 3 bounds octeon_ep_vf.
> 
> Patch 2 is Guangshuo Li's fix for an octeon_ep_vf RX page leak on the
> napi_build_skb() failure path. It touches the same drop code as patch 3.
> I carry it here so the series applies without conflict, per Maciej. Patch 3
> moves that drain loop into a helper. The helper carries the page frees from
> patch 2, so the overflow drop path frees its pages too.
> 
> octeon_ep has the same leak on its drop path. A separate patch will fix it
> once this series lands.
> 
> v5:
>  - octeon_ep, octeon_ep_vf: widen data_len to u32, per Simon Horman.
>    buff_info->len is a u64, a u16 could truncate a long length.
>  - octeon_ep: dropped Maciej Fijalkowski's Reviewed-by, the check changed.
>  - octeon_ep_vf: the drop helper drains the length in a u32 too.

The check changed however I provided certain suggestions that are included
in this set (checking frags before build_skb, wrapping common code to
helper), so I feel I still can have my review here.

For the series:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> v1: https://lore.kernel.org/r/20260701112825.1653044-1-maoyixie.tju@gmail.com
> v2: https://lore.kernel.org/r/20260702180518.2013324-1-maoyixie.tju@gmail.com
> v3: https://lore.kernel.org/r/20260704061511.2350737-1-maoyixie.tju@gmail.com
> v4: https://lore.kernel.org/r/20260706150208.2944898-1-maoyixie.tju@gmail.com
> 
> Guangshuo Li (1):
>   octeon_ep_vf: Fix RX page leak on napi_build_skb() failure
> 
> Maoyi Xie (2):
>   octeon_ep: fix skb frags overflow in the RX path
>   octeon_ep_vf: fix skb frags overflow in the RX path
> 
>  .../net/ethernet/marvell/octeon_ep/octep_rx.c |  9 ++++
>  .../marvell/octeon_ep_vf/octep_vf_rx.c        | 51 ++++++++++++-------
>  2 files changed, 43 insertions(+), 17 deletions(-)
> 
> --
> 2.34.1
> 
