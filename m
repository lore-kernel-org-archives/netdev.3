Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5D3D88E0;
	Thu, 15 Oct 2026 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053882; cv=none; b=ThoBJz3kMsDYhdnuWAoIy1isyU33uP1Y/q57tvrQ57LfD5cI/ZSOUvz8dIM+CgBTFUqNAiI8iy4u3fZwmjuQRPZJIPp+iBRu3n3RMbi7qlML0/yIoJUvltTmKPm0s3mHpmkh63fjInq1wZ9Nqi/FEr8jMrtjvAF+S+DzR9EURVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053882; c=relaxed/simple;
	bh=bZkLoYIQQjVUK4XHgnMXsLjSW9f51PKOjGdxmTBIdGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjC4hiW5ZDcaUVjYId0phz4kAwrWkb4ThbtwF8Fu5eiGnXy1vflqs4fKkCNXHmS4YfeO6jjtJsQcoqbu7ph8oFRstrCz3ypoWZqS1kUj65Xq/zXv1MXgXlJqlBA5/oAVOY74NWFg+BkqwgeKdEFU6901CSR46uifzPBdAqdaAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QseqCGbK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QseqCGbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792053880; x=1823589880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bZkLoYIQQjVUK4XHgnMXsLjSW9f51PKOjGdxmTBIdGc=;
  b=QseqCGbKZZpSazTWS/JX92E31oTTW/uaSRB/KgyYE++FKmVJqq/iZEHj
   Qm3qIcOqlTUcFp2Ah6DaRWLiTjc+jKCzJumsns6CrUfSDogyn7RykuUFd
   nh9UHzyWdlGmyf8x2GhAEzeELVKUXaS7zw0Zz6XSh0dr98Qh1BTJcea7t
   TY8Ce5U8HEQqNFbmA4lthTX8jFczI/mSm1qjgykRSkINR9+jhnfCphOK1
   5A6Jdw9ZX2YFaMs5mJ0jdWnrXP+Z0rcCFRp/IWrfBD1nnHSLtxGtrXYZO
   9oxFj1m7PvB3v7/QRRjIIN6dqbltDlkQqetPR3jzwYDWmC5nenvm+Ta8Y
   Q==;
X-CSE-ConnectionGUID: p1kljdykSYiDpK8FSkPk3g==
X-CSE-MsgGUID: XDaxo7u1RlujshuYjclr6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="848210"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="848210"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 01:44:40 -0700
X-CSE-ConnectionGUID: wGs0T18cRx2rtVYfmexHUA==
X-CSE-MsgGUID: +Cukhbh6TOyI157YdPCwvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1576023"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 Oct 2026 01:44:36 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHH4j-00000000G7W-2o18;
	Thu, 15 Oct 2026 08:44:33 +0000
Date: Thu, 15 Oct 2026 16:43:40 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, s32@nxp.com,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Russell King <linux@armlinux.org.uk>, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
Message-ID: <202610151650.UHqL0Sb7-lkp@intel.com>
References: <d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil@nxp.com>

Hi Claudiu,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudiu-Manoil/net-enetc-Add-pseudo-MAC-support-for-ENETCv4-Ports-via-a-fixed-link-node/20261013-201245
base:   net-next/main
patch link:    https://lore.kernel.org/r/d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil%40nxp.com
patch subject: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link node
config: x86_64-buildonly-randconfig-1004-20261015 (https://download.01.org/0day-ci/archive/20261015/202610151650.UHqL0Sb7-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610151650.UHqL0Sb7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610151650.UHqL0Sb7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:963:2: error: call to undeclared function 'of_changeset_revert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     963 |         of_changeset_revert(priv->ppm_ocs);
         |         ^
>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:964:2: error: call to undeclared function 'of_changeset_destroy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     964 |         of_changeset_destroy(priv->ppm_ocs);
         |         ^
>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:992:2: error: call to undeclared function 'of_changeset_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     992 |         of_changeset_init(ocs);
         |         ^
>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:994:15: error: call to undeclared function 'of_changeset_create_node'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     994 |         fixed_link = of_changeset_create_node(ocs, np, "fixed-link");
         |                      ^
>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:994:13: error: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
     994 |         fixed_link = of_changeset_create_node(ocs, np, "fixed-link");
         |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1000:8: error: call to undeclared function 'of_changeset_add_prop_u32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1000 |         err = of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);
         |               ^
>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1004:8: error: call to undeclared function 'of_changeset_add_prop_bool'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1004 |         err = of_changeset_add_prop_bool(ocs, fixed_link, "full-duplex");
         |               ^
>> drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1008:8: error: call to undeclared function 'of_changeset_apply'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1008 |         err = of_changeset_apply(ocs);
         |               ^
   drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1020:2: error: call to undeclared function 'of_changeset_destroy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1020 |         of_changeset_destroy(ocs);
         |         ^
   9 errors generated.


vim +/of_changeset_revert +963 drivers/net/ethernet/freescale/enetc/enetc4_pf.c

   957	
   958	static void enetc4_put_ppm_fixed_link(struct enetc_ndev_priv *priv)
   959	{
   960		if (!priv->ppm_ocs)
   961			return;
   962	
 > 963		of_changeset_revert(priv->ppm_ocs);
 > 964		of_changeset_destroy(priv->ppm_ocs);
   965		kfree(priv->ppm_ocs);
   966		priv->ppm_ocs = NULL;
   967	}
   968	
   969	/* Pseudo-MAC ports have no real PHY; the link is fixed, with the operating
   970	 * speed set at probe time from PCR[PSPEED]. Describe this with a fixed-link
   971	 * subnode synthesized at runtime onto the port's own OF node, so phylink
   972	 * picks it up through dev_fwnode() exactly as if it came from static DT.
   973	 */
   974	static int enetc4_add_ppm_fixed_link(struct enetc_ndev_priv *priv)
   975	{
   976		struct device_node *np = dev_of_node(priv->dev);
   977		struct device_node *fixed_link;
   978		struct of_changeset *ocs;
   979		int speed, err;
   980	
   981		if (!np)
   982			return dev_err_probe(priv->dev, -ENODEV,
   983					     "Missing of_node for Pseudo-MAC port\n");
   984	
   985		enetc4_get_pcr_speed(&priv->si->hw, &speed);
   986		speed = enetc_phylink_match_pseudo_mac_speed(speed);
   987	
   988		ocs = kzalloc_obj(*ocs);
   989		if (!ocs)
   990			return -ENOMEM;
   991	
 > 992		of_changeset_init(ocs);
   993	
 > 994		fixed_link = of_changeset_create_node(ocs, np, "fixed-link");
   995		if (!fixed_link) {
   996			err = -ENOMEM;
   997			goto err_destroy;
   998		}
   999	
> 1000		err = of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);
  1001		if (err)
  1002			goto err_put_node;
  1003	
> 1004		err = of_changeset_add_prop_bool(ocs, fixed_link, "full-duplex");
  1005		if (err)
  1006			goto err_put_node;
  1007	
> 1008		err = of_changeset_apply(ocs);
  1009		if (err)
  1010			goto err_put_node;
  1011	
  1012		of_node_put(fixed_link);
  1013		priv->ppm_ocs = ocs;
  1014	
  1015		return 0;
  1016	
  1017	err_put_node:
  1018		of_node_put(fixed_link);
  1019	err_destroy:
  1020		of_changeset_destroy(ocs);
  1021		kfree(ocs);
  1022	
  1023		return dev_err_probe(priv->dev, err,
  1024				     "Failed to add fixed-link node\n");
  1025	}
  1026	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
