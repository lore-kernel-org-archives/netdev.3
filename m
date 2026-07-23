Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E720438000;
	Thu, 23 Jul 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802548; cv=fail; b=ogk49LHv5GLBKhRfeaxx5HcsNvXr2hmesz4TrRyHMh60XrSr9RmB2OJQb+3gqG8QYPlg5Ox8SHMhBfMnNT/9YjhrI0Cw6fO2jPqLMzqzdl5Sw5lMypTiWyv/TbzPP2ein5TcfKrR+buNofBiz9iKijZL0Ta2PpoVDUzWcF/CuyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802548; c=relaxed/simple;
	bh=nzi1U0ifFRHdEkTZYHSyFr775fMJbPvaSdhx3QHaBuI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gT7y+aECL+7cDfZQyJO3ihne8cCIUTeVn21E6A6e88l3458LmMyxlXDwWxtBfErWaRm3K5wbhwq9madbhhP6NQERnyFAnDi1JMzd5eMV+fFjGD/9XfwcozIFmL21fXljPzn0GUbDhCzgO2SiyICmUlvGp7Z5ZNxFwCzaD1F89ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLNg0+++; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLNg0+++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784802546; x=1816338546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nzi1U0ifFRHdEkTZYHSyFr775fMJbPvaSdhx3QHaBuI=;
  b=CLNg0+++8WzCPx2cmF5I991OhmTV5MGje1KX5zgZdlyiOyqfq41zXr4C
   qHo4FioeMOXY/9KPVi0fkZXVV+MiWWS21ciupsUbmVKyi15P17mNlF4nn
   3eU2QPOCmATAZW6MMNYjEEh4F9WCZInu7YzO2fNNSuT/nkdjv+sVIJVM4
   C4X6cHiFEqkgL9GF0z+KFA1jm2msb5hv4Q2siiX7vF/R7h2/pKiSutXwI
   xKw1bh/lJNkjpE5lQa4zW8jstmhK4eIRooNjo2R1UiGDy2CDxxPS71ceS
   cUqmnih+bR7Pqp25xp8mfZkEhZUXI+ub6K7YK81DmzQkM/AUxhtmdzWbj
   A==;
X-CSE-ConnectionGUID: FSEpThODSIO9JyPTUilNWA==
X-CSE-MsgGUID: GUOVvM4rRbOCDaaeLDbziA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="95809209"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="95809209"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:28:16 -0700
X-CSE-ConnectionGUID: DeLgHuQVTfiY3Tm3LiDqvg==
X-CSE-MsgGUID: +W9f9MUERiu0Y9PuON+mCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="263343539"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:28:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:28:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:28:15 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlLTYmnwOPsxnI9l0uXNX/tJzt2s06ui8wgW1qmjB3UnizOSVMDbJkXpW9+hO33BhNU0bi29XAhJk01qI/S1nLhImR52vEqS1GP0qmTE0wJoh+yAHYPOGiLgYFnOx0MHg4gTdmk7oGvjDXFiKY2T/5naZ7zw429CK8magIoA26WJINZQD8Ya/uZfcpWkvZhI/mLxkgIpyCjKGvkIOrxCkipxdgX7oGW/cHuS9Ew51ppfhVHnMuAQBg/5i2njZOTR4/smTjdiCWVJIEWW09IvL+MVXm/EWgCCWzKUseLSPGqAnHltcLjs/RZiBQusiiSdh7Jnbo1i7vZyqYnFaf5spg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8KG598RyQrXXWX+kFmHpzIobL887iwnFjV5PrxSHSs=;
 b=eCd9YifP9fjV7cA2pk1UlCCOX7gia4MsUWXBcpZHlyjXVFJLmsFSSakM2ujMf/6NQin5u4O23GEXDg1OC/TeP7rhl6ku8J98aMr+fgram6iKTJMyub59Abb1tHlevMe/GEvl1kIxGBnUbUhFRXzX/lCFCXrH493PwGrdyYpI+rMGXAHPMxhyQwynQQLLD1HnmET+dUL0VWDXSd+TZBjac1DXhMLU2DL4bl5gTJQJ73HuEfEA/PMA5Diw9Uqc+Om//ppw5S5VhrtTmnJP0XHEt5ISQlM9tf9lIMgQ2Y/hq6zEIm2bsxB+Mmm6X0sU1D4Qk/IyZCWabibSDXtdlqPdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DSWPR11MB9738.namprd11.prod.outlook.com (2603:10b6:8:353::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 10:28:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:28:08 +0000
Date: Thu, 23 Jul 2026 12:28:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <larysa.zaremba@intel.com>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>, <Bharath.r@intel.com>
Subject: Re: [PATCH net-next v5 14/15] ixd: add the core initialization
Message-ID: <amHssLjVOoOz7FbB@boxer>
References: <20260715180042.1972010-15-anthony.l.nguyen@intel.com>
 <20260722161836.544694-1-horms@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722161836.544694-1-horms@kernel.org>
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DSWPR11MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: eacab681-4114-4ce7-4a18-08dee8a51684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|3023799007|4143699003|5023799004|11063799006|22082099003|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: hMTAOdlwnfRK3eQqmvoEziF6cZms3RJd88K22c54znu3C26NWo7I5jN17nan9u1m5CSKGMK7brlHYzxuswJqR46+Q4AupOLsgV7VXGi9G2+QEoIgSwPw4aaI2mUXggjgUFYPdMYoqyRkIVkhVtyHX2T1YiEJaqFDwOliTctL7rc5TYT15vQPtr/XQpJJzk/qiMoOAqJh4xToPeAPMGR/pI8ucgJwOGz5sIDjuUFkT1kErxRlXLEDvra7dLvWpAHm509tA+1q96SBo7/mpcrma7AYRwsnPGQbiymIFXjn3bo4ZthiRKGs6KUynJfjuqdCqcVX6en9NfOrIN9C23NstumzHrOoXfwMCg5HveX5pDJ1/XB/n4qcT9ZXmOWFHbQCSsyrLc60snIqIBnjMT1Bm7TyGVunc/oAdcGgsYBKLvmmOOeoAyOCy3e/qnOo5dfhKPFcZsAco9LBCPVcU6jLJGeeY9D1mxbxOgf6RC5gLu6Sv739+/MBfbSV6A548dpYHgwdBfEg+OVHA855+unhWhLHv7eiEKdkAUETS6Gys3DTP38AsqVv374QO2F8JQaOc3FkG1nJYS6b4NjTJmr5Yw6Uyj5x0Q+NOXx6N0iZZ6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(3023799007)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mJIKeoT5MbrTHznK9WpVBEQ8yA8uJRGRD+lVoy7IVXX+vsYu7CAQlJgjsJh/?=
 =?us-ascii?Q?iIMj1iWI6ryVNpzD5WsYVbCrFdA2hFKyFwp4YbQrpw4DvxD5v2385QvXksvD?=
 =?us-ascii?Q?31Psu0Rm2/H+k5F/TJcO8qrO4W1beqpV16U3yi3TncrVfsck35tCLdE8l7wz?=
 =?us-ascii?Q?+RAWFSkbubbNmHXv2zSb8sUruB+Tn6ClkZl52Z3PK2wgbAtrGR+C1CruenUe?=
 =?us-ascii?Q?Qo0rf5TTRTAkVwxV8WPu5UedbWl8MfjvuQR4jkXQHPphBR54XIlp+5bP1jrV?=
 =?us-ascii?Q?9gcy9i5Ilo/RDsumnioZip5RO9OSdcNcyzw/cR18fKMZQhIqG0g4Jr6NZxpl?=
 =?us-ascii?Q?qw9AwU27yNcRxJzuEsxyDZU40SniVee+gWFlGhLokew+RiooaY7RqLYe16m9?=
 =?us-ascii?Q?Ntkp9y2v4WmcINuF//31EgZ82qOy2NQdXtKRviBEPGJXDOYvfU+q5c3taLik?=
 =?us-ascii?Q?4GSDU2WavPkGpIbYHw1FzFy4bLtPadD+oP6thOEpG/Wa9Q5wOpBFzBLH8V9J?=
 =?us-ascii?Q?b71u2Xb+8r/4QSVBDKbq56yesuPQh6hOTA5P6PqETnMDm5zt9mtTcpxubsU4?=
 =?us-ascii?Q?2vtpEolvskndG+FcMT9Jw4uL/qCFB6nyhWMh3SKlt/c7cFsuvdIIhGcE+8sY?=
 =?us-ascii?Q?bhNQQCko2jG12EzSuSL/Zaeyx6sYkdlSlOh24t9XFejN1jZa3tecYHLKoOXk?=
 =?us-ascii?Q?ONBdxzCeyRiRDHvAcFdORCEBND8ni/vwPeFDzvwWQRoG2zy/U8a4l/zUd8+l?=
 =?us-ascii?Q?F7/rUpPEr+KWXo2CneojTWLZiKgc1R616PgdDA6brAUmUH+Do3368O74kdNN?=
 =?us-ascii?Q?eOTK3ui7HD9B2lYz2ljnC7VkenCkmhyTu6L+oczIr4w2i/HXhN6xQmo0wfTb?=
 =?us-ascii?Q?4sR4k0Z5gR8+a/0nBiJEpt8hcepejFfRjjhf3t9thL+ztEUhFD59dZKtRXk/?=
 =?us-ascii?Q?EWLoP4VPDJMDooxD+nFLZkLv58vYuc06CEF0Y3Ix7uanw2NlXJ9dnvAvL9+G?=
 =?us-ascii?Q?mEqvSLO6VI2NdoprTe9tYqTSIkWXA62TM5BX+fRBlr46viD3JxbtiLT0v28+?=
 =?us-ascii?Q?YbU8EYdLPjSorspKe4KTdxP4ssH5Uy26Zewr17ttb8393i2z8ywQ8+NrrheV?=
 =?us-ascii?Q?zshOpGzZ8Wnfo4RM2c0nA+L8pfZYJ5WoJHIVXKKjBWxpq/JtY/QRCWRR3/EJ?=
 =?us-ascii?Q?QuPYEYZh2C/NK58lg47Y9DEaCQOQP06xgvzDOTJiMmtK70cly+wfX/ZomkoY?=
 =?us-ascii?Q?9MNo2VQJS1T5+PiY2uIZ31ni8ETe9v2aWa98qwh5dA7xTSbE4TGyibv1mUs2?=
 =?us-ascii?Q?2MGG75qH0WOMmmJWM6kVZpjf6HMeGmjX4h55REwLzLY4+2dJmWhMUYaCCf6A?=
 =?us-ascii?Q?c0M+6iXfAQu96ezUxO8u/ggUi7ZE20Q3X9gmh0LE2+vnUKEhwA/pS5xyISXI?=
 =?us-ascii?Q?07AfI3vVspikYkc8GhNW34npWoKJ0gFVatqlYoP4B7uTMSG9/hvQhCVB67Pf?=
 =?us-ascii?Q?Ol/d7qcxtSPiZpKUA1HVBJGoK2ryZLUZX7OpeaGxlAWuQBQG4r2/sNtxRLQG?=
 =?us-ascii?Q?pRQFIYoMT442muXnbC9ROkN2gy10iwQ3kBqMg19ABGadtzc/p3AOmiz/LU0q?=
 =?us-ascii?Q?QzNH/Wo4vvcHezDhT1fkeL99rcUpwiO0Sgud+7Zf8bI/emKewNBHNI8PBoH3?=
 =?us-ascii?Q?HDQaXZp3z0cbt9r7asoKbT0Y8LwrpZBr/2nCE/Vy/rgKU5tQKMmIWYvFoW3F?=
 =?us-ascii?Q?2girnN/Jhq59hMQrHknANDwIbPJtRHs=3D?=
X-Exchange-RoutingPolicyChecked: RVruNVJhWGFqAyZM9udSKn477cuTA9WWHp2dMj+sPGH2obzEdEdD1JqDW+BuZHO8GJ23gHevkiiKTEdSrpQVHIbs7iwwa+fPy44L2MIltd6wlCMFBuYpyKtmrnyyDxvE2yKooWmNGR7IX2mZqTxo1IlIwszaW6tuEOOLe8rqwiBnUD1c81SPCnEzplqqmFrWQHFrTRpq7YWwjwvSSXGNyC8XrJOxH9p/ny4CKaY+/IdG/XVReVCGPE79PPzJjXQ3dHo2sqOnTbpKEw6P5qMxXbQrwGWIfGKs7F+QJhyx1/d/bD6G67gkvcNUXBXkF90pquVI0aOkKhK/9xvNIf+yfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: eacab681-4114-4ce7-4a18-08dee8a51684
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:28:08.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cU9PiFQYexag+Ll/sV4DtwAsZRDJP+o3NuTB11ZOuJsPR7Z1WyKTuTcBfSx0zZdxNyBEDsZyafUzbBs5mwvOHcWGUyDOAPboriKK9sSVMG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9738
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 05:18:36PM +0100, Simon Horman wrote:

Simon,

Larysa already responded to Sashiko comments. Did you miss this?
Do you have a bot configured for that AI output forwarding?

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> https://sashiko.dev/#/patchset/20260715180042.1972010-2-anthony.l.nguyen@intel.com?part=14
> ---
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
> [Severity: High]
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
> > +	libie_ctlq_xn_shutdown(adapter->xnm);
> > +	ixd_trigger_reset(adapter);
> > +	ixd_deinit_dflt_mbx(adapter);
> 
> [Severity: High]
> Is it safe to trigger a hardware reset before cancelling the mailbox polling
> task? ixd_deinit_dflt_mbx() is responsible for cancelling the mbx_task, but
> calling ixd_trigger_reset() first means the polling task could run while the
> hardware is resetting.
> 
> During reset, MMIO reads or DMA ring memory might temporarily contain invalid
> states, and the still-running mbx_task might process corrupted descriptors.
> Should the polling task be cancelled before asserting the hardware reset here,
> as well as in ixd_remove() in ixd_main.c?
