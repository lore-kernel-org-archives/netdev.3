Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8964F5DE7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484717; cv=fail; b=jxo015dyxM9FLj3AGjLEUEb5n7FkRt4hskq0gb4HQXSxffcbnxZMbOwc5kOlk42SShZ/xrS3k1FfmknYBCuiVxxsH/rmLF4PPLGNGzChrTINsTxvV483PVuwnXNzMsmLNwEJ/uU0lm1FQDA8M2TZpsE92lFQ4bTv1vvcEyyNV5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484717; c=relaxed/simple;
	bh=hH96RgC7cdLzKfoXLYA98AbocGuivC/gINu1OcI3h0g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SNU54Fz2THN8n/KutF3VWfQQ0BI4Gz3aHM7bEybWrYrGZ9LIA4ompsPV6p9H62iypadHHlQ0DKBHAJgo44Uw3KejY1l/7axuJJ6RYmFYFzyjkqicuTZB4GhC0FJckjcQIQcy87NrsDsw1d5EEM4nVye5ubgVgVxU91tJA3PnwJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRWsf7ay; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRWsf7ay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791484710; x=1823020710;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hH96RgC7cdLzKfoXLYA98AbocGuivC/gINu1OcI3h0g=;
  b=nRWsf7ay9L5WGb4yOrtQ8xyP0EuIkBvIWi/7+RX5+edDRfvOpopTAi4r
   6Dv9ZwlxMkiYiupVy6Rkgo32kpFzsJ6oI/YlzaVpeWVY9KA8K4Ucoe9A/
   WVNjQG3I/YszEEogHOsFpb2v6bWxpk+xnJWF8eJjiqdszy1hHftEG9Kwv
   nfngGdSw8kyhAg5ALFADNlCqMBfVIsDogS+tejbNRxa+YPnNX6hYSZg++
   EUEZGihn7LlFzQ8nLhsu9WQZ7zgRcMZRblmKa/tEDHQlGA0zhzTrymf0/
   uoQj8Lld6SxJPnEzNPqbgUq8f8uvEOXY2JyFJpyA5kYoe0AHzXAwKwYE7
   A==;
X-CSE-ConnectionGUID: np9CifYdRNO5Vymmo0LXnQ==
X-CSE-MsgGUID: dFyTJsQ+Rre25rQKaFfoQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="161985"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="161985"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 11:38:29 -0700
X-CSE-ConnectionGUID: IErGYWn5QJyOxTmK/1lYIw==
X-CSE-MsgGUID: N87q79KjQKCFPfObZGfPrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1872788"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 11:38:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 11:38:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 11:38:29 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 11:38:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPvc+CL++qHEyNTWhPWWDUIgsJmYLnjFM9p2QNev4why+mdFNWvioS4Dwt96wB1OHi4AyGm0G95dJ0JJw5nNDqZzb2Foy1W7uVk1QghYFCSYsODhAqpEmi075iv1jH0gcEVkf1W4Wr+oJXL+kiA+vCDUmskA8+Q1VsYUgut87P9WQwSWnVCqnkn1fr2t9Q9v1HWI7gIzStib/Qwzs2Pc++QQMxFWV3nSyQT4+eWVliaen1ZPisZ7sDK/K74/v+Xlu7GOQr/WSPjOUKeJnHfMf/lt/wLDlBuKnn4xsdcEZXLowqXcnJxBWXipjdrMKbao5BzQ/lFA41zv4laJ+CBbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyeuqCKJADpKtmnoGLak/yVX2WRt8mQV0SkViTvfMqc=;
 b=UGvfVyhVBRGkSMIf4AnR63otSGN+7Z1CpeVzsAYnqZgKnhgo0BYvnIlT7yIX6XFv0265Sjg1lD8Wvr3bZcW907ClnfKzjqRmn2C8Z9NaK7zYyzgbSlTLtZzDQBH9rj8hq27aBz5wBmh4O/VWeOi8HqBbIzRguScOgJ36NVjFOIsLG3jp0PWhaZLn8ed1vICpKhGXPpaRMFWUW4gkYb3Hbp6qUNXydyDOv0XNQoaRWKCyoBvZ85Vz73Krpvbe/BRMoSKtpvecdArFXTVj6f69ou3NNNzva9TKsRIPaBe54f2LBRIUFsCbr5pTsCOq+m6XNkv2nQL/QGsU2jlQrn4iCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 18:38:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 18:38:26 +0000
Date: Thu, 8 Oct 2026 20:38:19 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<przemyslaw.kitszel@intel.com>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net] ice: keep the RSS hash function on
 indirection-only updates
Message-ID: <asfjGzjV7scRJpis@boxer>
References: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
 <20261008083412.23481894@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008083412.23481894@kernel.org>
X-ClientProxiedBy: VIVP296CA0106.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 050e69cc-71f7-435e-f2cb-08df256b5697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: OpWWA/kLBTwEG91jP57K5PSEwFUU3IhALJh6Jxca+hXhNqim5pyFMBYOsKPhLEGpHn99njrILtssgnbZTl2RO+W1CNh3mwW+dQpLje9SIhlbi455O9icC224XSxD/+YI1Qx0WpUHeUvjhludczqZjWE3ciuUv2cx/jBYMdnKYVL0Mfes4pH1PNB0ZKaK9kRSV1pKWtDa6P/if9LeyKanHtgkfaJHLVJulmMpIgwHu4wKLQ/DxRNTlDXrpyEPBmm2c4LEP0Xl7peMy53BR1I3r7LT0cnJKRvlGBClP5bziY1sYJ2ZltD/UPQooH0P8wQ9UEH1mTjCsr9ruEhDK2O/GlynQ5B3CEIiD+hfcY8sd+lXNXwMYyUEi2bXBk534rAvE1r+q4VOElaZbz10eW+VofF13UM8iZ4tDjAqGyXSu2CYmWeYMCpLGzIyN8vXLkxT6u1A6TWPKHDPtqjhMBQLnfMcWRcE1QOEfB5Th5NsPCJMuX1Vd6tIuOLCqjmrkhdL414OX1BStsEtvmKb7uMA+73rmFFrg+hfYxH4sV1tyY4XGYRU2cPAcwBbmy1FRALHRkBDrQRGuRrKP2tInwUvmjhrr5hI9thuli4DUkPmfAhb38y2G38/N02DAiDNiegX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+e9XVoqrzGd3JwBGoo7E/sqlZEZVwwIhiIMgFko8UeiY8AaV4b3gvX0D9mW?=
 =?us-ascii?Q?bx/xhoKTxoKAB5ybKlB5a4/dMeq+kb0yRc+AEc9b1q+jK/oOo4p9mZCzPfXu?=
 =?us-ascii?Q?68ubRkapeGLk07dl0lVhc/2sFb+vKh7uX7DzjbsYASr7y2Rxtb3rBb0Bt368?=
 =?us-ascii?Q?DlMB3s23rlcQcju7QqFM0Q9z5gd9BHoszwor9tapLHHcyC3092cGr6Kqw49V?=
 =?us-ascii?Q?t/9mYFmHSD6uECfjlbXjbZGltyTyXrDxtfopCKAZAibL0/4Tt6CIaxtrHQiP?=
 =?us-ascii?Q?joBX5dspgaa8u08aTtaidGF3eOVlqqxUm2ah+rHJ1oL5XBuBEIUYxvESZtGX?=
 =?us-ascii?Q?ZUqWS5PJVhuLi3F+296+6Q4xHbL3JOIO9rSunlmQ9PF779lehqSVhOlitbKm?=
 =?us-ascii?Q?+Cf+ooTuaQ2YNBHiUTc/7AmxWDQpe4R2OzNkef1/9uKaUn49FkaXxOxOWHSJ?=
 =?us-ascii?Q?fdc6gmWz15+8yFufJ3nGD9c8cJk+7T1vaXqyfWhUe7UufvpsomX0UY7szv0Z?=
 =?us-ascii?Q?tan71SGF+wtCZPSVd6HSUZpm2bfOJ2xeobkxkdSLFp29l2TLdRKc7ob0PvG4?=
 =?us-ascii?Q?9v7ma0Ko7I6Rb33xxfa5bzWtiAKjAHuwY4oivzkzn5odb9fIEvyAE5p8WOcV?=
 =?us-ascii?Q?BLlBuI3dk56FrW5szLh2fXm68OVOTkTOQ2xN4FBDry+W3t3I1jizJ9PRcfZE?=
 =?us-ascii?Q?ajnc7RoUvmFqw8omUhP29J7rtBDfH+jiFvqzZJCxEby5L6CE/zNpexxs5rZm?=
 =?us-ascii?Q?vwAcdU9kKCSHPhmWUP52a+svAlx0o7DjlN7EpXpe1mX+Ym/uCfUqrm+Ks2Cw?=
 =?us-ascii?Q?nKlsx9w/hnlzkQi1/tmZPVvybOh+VJYteLxa0XXn8ssJ2fW5r0infM+QzNOf?=
 =?us-ascii?Q?JhG2S3yJR6bKbeB1/8EpvZuNKBlY8t+jlmtI2k/pOmhCW/l9kghU+injBlK3?=
 =?us-ascii?Q?G2BhHqFI1SpwVNWZiOgEP77gDziOYaUzTItHhh0uN2O2wpwElfHFLT12wRCx?=
 =?us-ascii?Q?7i8nmt1kBHTRSXK95RgiaCsTIL1mWWtLJLVkHNL3gtskku9mANo4mTIH435L?=
 =?us-ascii?Q?dgjgtgT22gvstMlMR5P5o7aW9J9427lW68kX5NnBvn0TVwVvwQ5UdztmWUOy?=
 =?us-ascii?Q?FHS+/nPdNhCIAjKblEr+aGJLL4FFKvkWvtQ6i74Lp8QME4IGYDe2oxL1X7gS?=
 =?us-ascii?Q?Q0NWXemTM4+ffIlspj2rlCTUqVe2UEIGdGWA64WR+BoQao+XSEfReoAodMF2?=
 =?us-ascii?Q?QaIzeI7CBH3MI7K563JRvB9PvE++czCjhe8mjN1JCdTfKP2g4gWqOjCOQqDe?=
 =?us-ascii?Q?n5y6WUlOpmOqKo0Y7ASoEf5BcenFZZN07/lRWGXBtj8gX+eQaKk+Xyu0Nxrq?=
 =?us-ascii?Q?MQ0G6B3WZyrvwUO4xVeT1w31O+w1QO9Mrxtg5jPsQ1asGgzQ2FhBmAvSNCMo?=
 =?us-ascii?Q?2N3Yk2rtHsAHGGw1Cdiu9463XFGCpy2ORG1GV8MODcLzN11I90Zt4qBJo0Tm?=
 =?us-ascii?Q?qdP5xDGIpQadleKsl9B0k1JaoNCyeT+PaVNe4E8AXqBuPV1f263DWrsyTSCI?=
 =?us-ascii?Q?xnezOL679R0PeCA8IrWWwntlcIn7y2QCf4A6TbObmHoGewvk+P+T6HgckfNY?=
 =?us-ascii?Q?zPtFFiY5fBwxABxdH3/07IBbBujU8z2IMizCJxW5XZfjtWD/MGnJeYG/x+h8?=
 =?us-ascii?Q?AfS1JiMAIsHRK5Mhv3rmAQy5ykmKhDEpo+75OxXLWLR/hQZ+jPFZqkPISe4l?=
 =?us-ascii?Q?OwApECwWHSZoSJ+bgWShrxXuC1nxdE8=3D?=
X-Exchange-RoutingPolicyChecked: 0ZcmS6jprVnqUa6DxOHCqjD7Uxl+JKqDm1ZSQvAVJBaOcc4iJJxqLLc2TKF3XVJaigbd5SjJcIFa8iOXEtZdzqXpNmWyLczUjn+hoR19fiaGhnKYo8qWGR/pdWAO6DyiTF6n+/1MEL0zuGIptZ9m5TjoUMSF74zb8QQdNJGC8S2W9G/o/+e8XjihqAYVSLlnOoN8j16qk9nmabEZBlKcESYORv29X2nG1wuFNpc9XaRYMbI59CebBXdhvS09fttV21vuYXMtlDQe4Qj8m3IQY9AYhv+ICLhXbUBrwQ1G9ZmeGwMmrrzX5cQbfO0QuHXKvMpAk3Y9hSXym/xSGjGq8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 050e69cc-71f7-435e-f2cb-08df256b5697
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 18:38:25.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGriigASWm1hZpK2wngGVQ3H9J1X6UwJC8mF47e0OAqD/KxpfZp907TNtIXeYj6gtnOzviUcKGaFD0X5gXDFXq4c0TAnGepDiwW7jZk3G08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 08:34:12AM -0700, Jakub Kicinski wrote:
> On Wed,  7 Oct 2026 22:03:11 +0200 Maciej Fijalkowski wrote:
> > The ethtool core passes RXH_XFRM_NO_CHANGE (0xff) in input_xfrm when a
> > request does not touch the input transformation, e.g. when it only
> > rewrites the RSS indirection table. ice_set_rxfh() tests input_xfrm only
> > for RXH_XFRM_SYM_XOR, which 0xff has set, so such an update switches the
> > VSI to symmetric Toeplitz hashing behind the user's back.
> > 
> > Once symmetric-xor is reported, the core requires all hashed flow types
> > to be symmetric for any following RSS set. The GTP flow types hash on
> > the TEID, so every later netlink RSS update fails with "hash field config
> > is not symmetric", including the one that would put the indirection
> > table back.
> > 
> > Keep the current hash function when input_xfrm is RXH_XFRM_NO_CHANGE.
> > ice_set_rss_hfunc() then returns early and leaves the VSI as it is.
> > 
> > This has been encountered while trying to run xskxceiver within drv-net
> > tests where one of the setup steps was queue pull out of RSS indirection
> > table.
> > 
> > Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Hm, not seeing it on the list now but I thought I submitted this 
> a while back:

Hi! This comes from your response where you asked Aleksandr to pull out
this fix out of -next changes and send to -net separately:

https://lore.kernel.org/netdev/20260626152636.1e48330f@kernel.org/

> 
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -3681,10 +3681,10 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>              struct netlink_ext_ack *extack)
>  {
>         struct ice_netdev_priv *np = netdev_priv(netdev);
> -       u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>         struct ice_vsi *vsi = np->vsi;
>         struct ice_pf *pf = vsi->back;
>         struct device *dev;
> +       u8 hfunc;
>         int err;
>  
>         dev = ice_pf_to_dev(pf);
> @@ -3703,9 +3703,12 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
>                 return -EOPNOTSUPP;
>         }
>  
> -       /* Update the VSI's hash function */
> -       if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
> +       if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
> +               hfunc = vsi->rss_hfunc;
> +       else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
>                 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
> +       else /* input_xfrm == 0; core rejects any other value */
> +               hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
>  
>         err = ice_set_rss_hfunc(vsi, hfunc);
>         if (err)
> 
> Could you double check if we need the trailing else as well? 
> Not 100% sure now if I added it just in case or it mattered :S

else part seems to be just a move from hfunc being initialized to
ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ.

