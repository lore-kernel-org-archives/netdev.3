Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C23ACA5D;
	Mon, 20 Jul 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564129; cv=fail; b=gd2LRMu2kFsR1y1y2JFLNJmeW5sfkjAcYzpqXC3gBNdUb6BvlbLSgM0IUWXi3JTywAgDb/UDz+WF4l+OQbjuLQVUaPeIdfcZ1wEFDsOXoc++EYTrXZsmGrE/by837C44Bp8PciOwLVsEk4LQFNwTvDlua7uGTEHNrmZLE4kADAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564129; c=relaxed/simple;
	bh=Oke9M64rk5z+tzWrLGGk4EiSnS0HtbK15uP2c4bTsWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CjKcrKjeNFlt8xeqinTYjLRj8CbLSaHBWTok53NPpeJuxBEcOXv5juKPsPGcC53P8FAyy97f13I9eUKSSxM7FIyDvkwNmuMhJXfuxYmuXc3nNjxBH4G46blnmaOgmf0sJNfgj0mC7BQMcd1PgRNXUM4SYpxj3KE2Fa4qE59HRLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YI5GOmHd; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YI5GOmHd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564096; x=1816100096;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Oke9M64rk5z+tzWrLGGk4EiSnS0HtbK15uP2c4bTsWY=;
  b=YI5GOmHd+s7gKwZCkRl6PkXSfT3t9lp69jQDZbkjajfCb15s2z0hGsOI
   Vga9jc1/CWoDA2ZmTrR4y5lpKFlbtIS31xJGBwjXiwyw+HwvgoPGUzpB4
   cWS2lYKGxBX73Rpr5vKHm4mC/EtNYNZde/9NnnBUzbRqSJr51bTlbkWkM
   a1X2xZoo8lTcROfK5ODMOVFjJCNdHjidwAqTUaZ7vTk4rHikQb8lmXs6+
   6twWUZ17QzrGzT7GYcVHaxEN2lZATmUr93sF1H7NFkD+G4zxeqkVVQCYm
   dyLTQLc4vZVx001yEKffz71K7aQFPxtHLxufVXXPeEKyj166MBi7qSxpc
   w==;
X-CSE-ConnectionGUID: z+cnIyG6RSShKlWW4Y83Jg==
X-CSE-MsgGUID: 6BlfEgszQsuMrVJHeLGktw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85009327"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85009327"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:14:52 -0700
X-CSE-ConnectionGUID: f25bn4riRxqlnuoMQaxFBw==
X-CSE-MsgGUID: 8FaumhvRSFKbBnG7C4kC2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="295701314"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:14:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:14:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 09:14:51 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 09:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdip8AR2Ca9R6VyLNEQyZHKO6Q3AhisbxRCy1J3irBw1Ot0euJVmYxq/Gqe4NbPl78TlNtHLlOLmp0A+t4KkAIoomw/fRdkeD9x0pzDTxbiS10E3bxtbCXFCgIODfLve7GZfz883lcEL6VUFGY9l9CselZtUSI8IDyo/0oP8xXn/IQeVjwREgDhw7Ga9KwQB9hbPzFysNvX8AZlwmvT0rP2L2SpL/Hd4Unr93yY0gDXpxnNu84jk3FOQkSx5NuQ/JMMJISG8mrU8awkBjWIgEIEwy4OFBftuGpm6tfaaliktGTJ2l/lcxwnZwxySNDnekhVAIWbdwS2dNP7yXFkvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhYmTsroAhoRCLkWiR3YmtZo0iTTs4atap9z+Akp0U8=;
 b=AeEy1/U/lyIh64+s3IkKNVHx1Qj4lXxI+GJk5/3AvrlYTW+dMdt1rkPazmUzxAw38A5xq7gKU+kU5yTpwOrjxnmG5zKDeqnmtg1ZK+YpuJwQ+bxm7qBH6IUoZFMhKPG23SgJdbIbLg3fgUyyFAk8Ico69bgXdTZMxKaJfAQxTYlmiz2Vx3Bo/yhtrpKVL9z24SenJo8/ADeudIfpL9S3bHJ5ZBgixH8GUv9gUnj2bumr7gMvay3jb4ZgCl31ttTrp7PV1dfzL7s/n4X6cZX05vatizpywXFx0FUIsNasty9sFjtv92XwUd5FjrxbcsnzYhVg13xDUxDy/rEu9l+RbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 16:14:48 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 16:14:48 +0000
Date: Mon, 20 Jul 2026 18:14:39 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>, Bharath R <Bharath.r@intel.com>
Subject: Re: [PATCH net-next v5 14/15] ixd: add the core initialization
Message-ID: <al5Jb2gx6jrfGF1a@soc-5CG4396X81.clients.intel.com>
References: <20260715180042.1972010-1-anthony.l.nguyen@intel.com>
 <20260715180042.1972010-15-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260715180042.1972010-15-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|PH0PR11MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9581ea-9786-412c-44e0-08dee67a0564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wr508uFHPVhIRS/f9OuY5XKkOOHDCDDnLprBsCPLwUqQH+LVofiAgGpm09BMU308mlNO8IUVroA3hhAnxSR4o6o62wYvEmmsktigIw+xbZQPWurFa0aAS6QRhfp4iEHNfhDp+uwsyx7H4VEM+1EwjabxxvLVugO7TbLTDS1kQqlGR8wrxOyCDDaqWmC+g7RfH85FyBBjRssJKCf0Cb8c1KiIfr2MNVXIYWwfIALOsVVekDs2L+bYawPbYaszq66kHHyoXtbIyKVO9FdwdydXBCmEZ4O5GIHouYFwwbCBNP8pa7Ig4OAQ3YTbsh4xKltUczN7iuC41MvFp+IOn14KGhJamhMmcaqinZx9LApHkIwumeJcLQJWAMkmMQ6w7pG093EUgqUUwlfqQsXV8C4UocPayO2wn1ApBrzXZmt6xDxTlInEvh5698r8kFw/aAihLcKgf++BJZuzL7aUvBR6uQw7ku2O9okunnsFNRgCU8MVGSbEkRXKtDyiqHGfJK9Stb0Wg4TZO76cf4e7S45znG7M7siI4RA4oCsztSWi6fKIK7jMlsBOEj1vtTFEGX7kX1Tf+nehYTRjeeIAZU24uKb27bg6pgn1zWGHi449k/jkFQ6uOSGT66uQgeHELg+iOxGEPuXWDfEvhYtItJ3yqNlz28up/wKp5rY2RPPZgg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+uVTL8eG+G0ji9VnBChWt+qBqGDVNbkdolul2tbg98hBJtC6a9pxckDyOwzm?=
 =?us-ascii?Q?RwImfpnNlLJ/mfU0yz/eWoP1u5KoeamJ1Wl3PQ9rqqScW7dh555pS0fY/fzz?=
 =?us-ascii?Q?VOkucfZGuX6901bIIoU5VKkSgpGuz5j+BbHvCooaNKrVTGXWe3weJhBc1oRm?=
 =?us-ascii?Q?LNI6ejDVetZVANcMg1rP0jhWphXSX/I8zAXVpSnnLtE1ScsA9KaGu95mDvn2?=
 =?us-ascii?Q?Bc2oo8RKorZC+mQCAf2R/WkR+6XraYqID96keEZ4D6Cr7Ij0Y8Lt+4XyxR50?=
 =?us-ascii?Q?4D3ZuwbClPgIi7LiPS/eoMwZD9vf3oIC9Iy4z0EbNQD+walNm5YEJ+gUv18X?=
 =?us-ascii?Q?nUQJ8DRcTkBi9luxkAt7DOEE/+vyWKZmp4thBxBFm/3J7nPc/XwMvB7JpvZW?=
 =?us-ascii?Q?L3O21zk4HToPBTkfSGxTGLSz8v21UxRpOcjvI7+paonTkAISL/2o8sPZc2QH?=
 =?us-ascii?Q?rF1IHRWwwXli32yyKFQs//abty3pJiw5Zlf05zWgfyk3zY5UN5pjBn6509pu?=
 =?us-ascii?Q?r5HNWh/eIIfxWT7+1va4/fHBX2oFrkuxIoHLrFiE9mxpLlbtKuhH5Pr348z3?=
 =?us-ascii?Q?0PRsclL6Hfj21j5NYLvbDcD01WVqvPb+EGHh+viLRVGTp5Imrwn3H+sg0Gl3?=
 =?us-ascii?Q?xHnuZTpa3pFp8e4cztWZ6md4gWl5FurNXI4Rtuq35UzEws5GnfuFNSX4mmOW?=
 =?us-ascii?Q?UAJObMhtAwwYb3roHMCKqb3qj4Bvr6uUsmLz+/Js8kjYqj5U1/hDFVaE/4Yc?=
 =?us-ascii?Q?IvAgKsoGhRZ6YEZibX/Gp4KTfG/8AAwwelhBtWOJgrvuXezQe14NzwoeOnJu?=
 =?us-ascii?Q?sGwE08KSGkJyRUhiFc+ybE3oLrfbt5uLqjfE3OA7aVh30gNmEnaBxXEJ5luH?=
 =?us-ascii?Q?Zt3Mk5c9afgImYxbRUiSo4NOdjZsnxqvyhrhnAWUTbGSPeTt0XfJiCXRmf17?=
 =?us-ascii?Q?Il5D9/HTA2sRfsl1PtSx7Ex4f6jrPudhDBA6U/+cEJ9J+xNMzY3e+o4f9z69?=
 =?us-ascii?Q?ZeT1g8tR4Q++J8IRnLiZxN2c/+q4OoGHS4mL3WplzevhIPz8xoxFGTNYrEvF?=
 =?us-ascii?Q?T7huf+gCti+hdIW5WrEcg307jFzf4E9NQ+n8PgcHq0B4rUAT2TaKHEPtukvz?=
 =?us-ascii?Q?RtItKzzrqguYesvYgTDspv3UTS1sQyEJYuJHytRzq4e8kQCX4IIhvjwUAnrH?=
 =?us-ascii?Q?vLuEOA4Ob5Pe4FPc6xAV4HPGXN03hnoDGP+2njogEzqM0zifGrG0SHRlLa5J?=
 =?us-ascii?Q?cyk6NH7CW6twe6R1UGy5kiwFdm1JFXg+iUyq+yZY/N9hl1jsIC5Wg1Mfgse+?=
 =?us-ascii?Q?+d0BiA0GR2AXhCr7NA+vozlHfX7cNl/diGOdBwStc/wjA1f6JdMjLlI12OQe?=
 =?us-ascii?Q?RLspTVYSZ8Wy3LFFFUpFGxvOAqB1sshppK+n6+c9ck28ZavoXcFqdmWbUI41?=
 =?us-ascii?Q?+9aNfNBObcI9lrp5FD6o2lSBf7BKG5lCnfXGpiEyBl/NrElFBezgQEnLDDab?=
 =?us-ascii?Q?vL15BTaThSmrrqh3xcH6EHl1nzh3axQaxehF7978xtclUiGupMtyoXvilmew?=
 =?us-ascii?Q?yiG80lsHv1gE0F/7YrMiVLyi3lfXbfim7m/KxsD0KrdjCneX4nQmJ/raKW2Q?=
 =?us-ascii?Q?I1cuprDuLxU4FlshP2+xr3k4fBYnwb4qGJULspdh902AOndoBFINwzvFWvq0?=
 =?us-ascii?Q?nW+DB5mYdoeoQVRoCZdp1MofmZgtWeL3nX8V1g7VpTIClGnZRW+Q75B1/tCP?=
 =?us-ascii?Q?V1VXbJkGiRl0Uop/qWbQgN39xrDXCNYPWMgzhEyLai1VNLWuc7cnuPSzxISo?=
X-MS-Exchange-AntiSpam-MessageData-1: 1kBfQuwToTYeSLoHWDZU+jguaHvJRV0SqKQ=
X-Exchange-RoutingPolicyChecked: P8LTYooiIAp7pxIbktlYNY16PGQuWLMj5vWRpl7++QRVdrYmdVb90HnmTQGfT2iqs+lcPBn3pNC3a/MdvASuh3P5raRY6NC3IV5QusrnuP+B87RZOlQhpgqHyvr5VaF461PTj+ZIwDnpMzoRpT8NoHT8UJPpkPzaZCvzhXnc1x4XGb5ElG2vcIxke5upQmDBslEiXsfIvLAMIvplVGrrkUmiSyUJJUgb3y0BNy2DGZNRSs4CKkZm2ftxmNZ/4djq3t+yHUFwhshMpN1FI/gtjwwaXhmK5ybZWlewdM9ANIv2PqYLlPlt5NBWDi4W7rPXuIbIfYe/C9MVSUoUiRxkug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9581ea-9786-412c-44e0-08dee67a0564
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 16:14:48.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Hgr2ZDqlPBbcP3cXCJ9uFjgX6tU+xwB01BUY3JFzsiLQYhU5MvDqHFr2oOThoIHDm4WvSXpCWwlfP8Oor7UjPngRQ5xh7yEUJaQNknW8xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com

Sashiko says:
> --- Patch [14]: [PATCH net-next v5 14/15] ixd: add the core initialization ---
> commit 43763d63c75ee5bcdd9189c20cf8b272997bdfec
> Author: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> ixd: add the core initialization
> 
> This patch initializes the core when the mailbox is set up. The driver
> confirms the virtchnl version, requests necessary capabilities, and sets up
> the message handling framework.
> 
> > diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
> > index 0000000000000..6d658be0695d4
> > --- /dev/null
> > +++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,146 @@
> 
> [ ... ]
> 
> > +void ixd_ctlq_rx_task(struct work_struct *work)
> > +{
> > +	struct ixd_adapter *adapter;
> > +
> > +	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
> > +
> > +	queue_delayed_work(system_unbound_wq, &adapter->mbx_task,
> > +			   msecs_to_jiffies(300));
> > +
> > +	ixd_ctlq_recv_mb_msg(adapter);
> > +}
> 
> Does queueing the delayed work before executing the main logic create a race
> condition? If cancel_delayed_work_sync() is called (for example, during
> teardown in ixd_deinit_dflt_mbx()), try_to_grab_pending() could successfully
> delete the newly queued timer and return immediately, assuming the work is
> fully cancelled.
> 
> This would bypass flush_work() and allow the teardown path to free
> adapter->xnm and set adapter->arq to NULL while ixd_ctlq_recv_mb_msg() is
> still running, potentially causing a use-after-free or NULL pointer
> dereference. Should the re-arming be moved to the end of the task?
> 

I assume the process of cancelling delayed work is more robust.

> > diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> > index afc413d3650fb..ce870aba143d4 100644
> > --- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
> > +++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
> 
> [ ... ]
> 
> > @@ -136,8 +145,27 @@ void ixd_init_task(struct work_struct *work)
> 
> [ ... ]
> 
> > +	libie_ctlq_xn_shutdown(adapter->xnm);/
> > +	ixd_trigger_reset(adapter);
> > +	ixd_deinit_dflt_mbx(adapter);
> 
> Is it safe to trigger a hardware reset before cancelling the mailbox polling
> task? ixd_deinit_dflt_mbx() is responsible for cancelling the mbx_task, but
> calling ixd_trigger_reset() first means the polling task could run while the
> hardware is resetting.
> 
> During reset, MMIO reads or DMA ring memory might temporarily contain invalid
> states, and the still-running mbx_task might process corrupted descriptors.
> Should the polling task be cancelled before asserting the hardware reset here,
> as well as in ixd_remove() in ixd_main.c?
> 

Yes, this is safe, we just won't receive anything at this point.
