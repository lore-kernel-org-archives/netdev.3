Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32344424D41;
	Thu, 24 Sep 2026 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234332; cv=none; b=jig3smC38UGHuljNVGhHbYudrHUBoR45V/GLuYxPQformoemRqg4Jxuv/gSUf7C4xsHy5fBsNp9QEcYFGGp6GHqh73wULdVIk93Y1y8GKeU5h3WnlJ7VxIs9zNW0tJhClRi9Brir87HSo2Xu4i3eIdwJmRQIIHCm6DAb7uT+V60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234332; c=relaxed/simple;
	bh=fioJb7wxBoSW63SsX7ZiPw2S/5owVJ2rA6inNzdM1r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh2W/aSV6Aj8vjKMKpJM79oAjW5gvweBqFOMuK5/fNm1ODXZp4LdAFz0W6Ks1BXGul00VtXdpdBoRVoataTAgQy2Mb5nabfchQsBXJdZ4aGLw9hhkb3X51s/znVl4QDreMwhb3mJk5F3jrpxd0S+p/xCtLfupqV4SfjdHSYLNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnlzH3Uw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnlzH3Uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790234325; x=1821770325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fioJb7wxBoSW63SsX7ZiPw2S/5owVJ2rA6inNzdM1r0=;
  b=HnlzH3UwzLw7hMDM/fv3euxDHgwkf7lYdRyzMF09kEznVBkzNYK7gol+
   QINfQiB9cu9KSbpWj2NR1emlpbcv6cLHW/yvvgZx+sMyPQG8b+hbB+0Q9
   S6nU0gzIi2s9C9syi990WYJZHKHDiIH5BavHD4wUZerBr7AlvJEnRmlGa
   sqbvurdvZtL8Pzu1M2Wk9yRHnXyXTDvX8S0vyMBZkOTC2s1wHwFss1/Lp
   nbaw1wlq5o9uuK4mnYVhwUiROg10384HP78yNJLri79mHXjnSapHkBmb7
   uZQ6o47uAz9EYueRzcOShB/jXDJ7ZKHFH9FKdvb8YMZzHvOfCvknVwDR6
   A==;
X-CSE-ConnectionGUID: fs1hCXFURtq9YFvSzYb1Gw==
X-CSE-MsgGUID: M6APcjqLRICGbFgt+WyTiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101573928"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101573928"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:18:42 -0700
X-CSE-ConnectionGUID: cF/J7uvVR9yCBEAl1lquFQ==
X-CSE-MsgGUID: km3dNwjkQlWgNuzF4KNv3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274123667"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Sep 2026 00:18:39 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9dj2-00000000IMI-3TOt;
	Thu, 24 Sep 2026 07:18:36 +0000
Date: Thu, 24 Sep 2026 15:18:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	Ratheesh Kannoth <rkannoth@marvell.com>
Subject: Re: [PATCH v2 net-next] octeontx2-af: pass devlink switch id and
 cache representor map
Message-ID: <202609241557.82GuIoAK-lkp@intel.com>
References: <20260923045826.1774338-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923045826.1774338-1-rkannoth@marvell.com>

Hi Ratheesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on linus/master v7.3-rc4 next-20260922]
[cannot apply to linux-review/Ratheesh-Kannoth/octeontx2-af-Representor-devlink-id-and-port-mapping/20260918-103021 horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ratheesh-Kannoth/octeontx2-af-pass-devlink-switch-id-and-cache-representor-map/20260923-102826
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260923045826.1774338-1-rkannoth%40marvell.com
patch subject: [PATCH v2 net-next] octeontx2-af: pass devlink switch id and cache representor map
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260924/202609241557.82GuIoAK-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260924/202609241557.82GuIoAK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609241557.82GuIoAK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/nic/rep.c:663:8: error: call to undeclared function 'rvu_get_rep_cnt'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     663 |         err = rvu_get_rep_cnt(priv);
         |               ^
>> drivers/net/ethernet/marvell/octeontx2/nic/rep.c:744:12: warning: no previous prototype for function 'rvu_get_rep_cnt' [-Wmissing-prototypes]
     744 | static int rvu_get_rep_cnt(struct otx2_nic *priv)
         |            ^
   drivers/net/ethernet/marvell/octeontx2/nic/rep.c:744:8: note: declare 'static' if the function is not intended to be used outside of this translation unit
     744 | static int rvu_get_rep_cnt(struct otx2_nic *priv)
         |        ^
   1 warning and 1 error generated.


vim +/rvu_get_rep_cnt +663 drivers/net/ethernet/marvell/octeontx2/nic/rep.c

   654	
   655	int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
   656	{
   657		int rep_cnt = priv->rep_cnt;
   658		struct net_device *ndev;
   659		struct rep_dev *rep;
   660		int rep_id, err;
   661		u16 pcifunc;
   662	
 > 663		err = rvu_get_rep_cnt(priv);
   664		if (err)
   665			return err;
   666	
   667		err = rvu_rep_rsrc_init(priv);
   668		if (err)
   669			return -ENOMEM;
   670	
   671		priv->reps = kzalloc_objs(struct rep_dev *, rep_cnt);
   672		if (!priv->reps)
   673			return -ENOMEM;
   674	
   675		for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
   676			ndev = alloc_etherdev(sizeof(*rep));
   677			if (!ndev) {
   678				NL_SET_ERR_MSG_FMT_MOD(extack,
   679						       "PFVF representor:%d creation failed",
   680						       rep_id);
   681				err = -ENOMEM;
   682				goto exit;
   683			}
   684	
   685			rep = netdev_priv(ndev);
   686			priv->reps[rep_id] = rep;
   687			rep->mdev = priv;
   688			rep->netdev = ndev;
   689			rep->rep_id = rep_id;
   690	
   691			ndev->min_mtu = OTX2_MIN_MTU;
   692			ndev->max_mtu = priv->hw.max_mtu;
   693			ndev->netdev_ops = &rvu_rep_netdev_ops;
   694			pcifunc = priv->rep_pf_map[rep_id];
   695			rep->pcifunc = pcifunc;
   696	
   697			snprintf(ndev->name, sizeof(ndev->name), "Rpf%dvf%d",
   698				 rvu_get_pf(priv->pdev, pcifunc),
   699				 (pcifunc & RVU_PFVF_FUNC_MASK));
   700	
   701			ndev->hw_features = (NETIF_F_RXCSUM | NETIF_F_IP_CSUM |
   702				       NETIF_F_IPV6_CSUM | NETIF_F_RXHASH |
   703				       NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6);
   704	
   705			ndev->hw_features |= NETIF_F_HW_TC;
   706			ndev->features |= ndev->hw_features;
   707			eth_hw_addr_random(ndev);
   708			err = rvu_rep_devlink_port_register(rep);
   709			if (err) {
   710				free_netdev(ndev);
   711				goto exit;
   712			}
   713	
   714			SET_NETDEV_DEVLINK_PORT(ndev, &rep->dl_port);
   715			err = register_netdev(ndev);
   716			if (err) {
   717				NL_SET_ERR_MSG_MOD(extack,
   718						   "PFVF representor registration failed");
   719				rvu_rep_devlink_port_unregister(rep);
   720				free_netdev(ndev);
   721				goto exit;
   722			}
   723	
   724			INIT_DELAYED_WORK(&rep->stats_wrk, rvu_rep_get_stats);
   725		}
   726		err = rvu_rep_napi_init(priv, extack);
   727		if (err)
   728			goto exit;
   729	
   730		rvu_eswitch_config(priv, true);
   731		return 0;
   732	exit:
   733		while (--rep_id >= 0) {
   734			rep = priv->reps[rep_id];
   735			unregister_netdev(rep->netdev);
   736			rvu_rep_devlink_port_unregister(rep);
   737			free_netdev(rep->netdev);
   738		}
   739		kfree(priv->reps);
   740		rvu_rep_rsrc_free(priv);
   741		return err;
   742	}
   743	
 > 744	static int rvu_get_rep_cnt(struct otx2_nic *priv)
   745	{
   746		struct get_rep_cnt_rsp *rsp;
   747		struct mbox_msghdr *msghdr;
   748		struct msg_req *req;
   749		int err, rep;
   750	
   751		mutex_lock(&priv->mbox.lock);
   752		req = otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
   753		if (!req) {
   754			mutex_unlock(&priv->mbox.lock);
   755			return -ENOMEM;
   756		}
   757		err = otx2_sync_mbox_msg(&priv->mbox);
   758		if (err)
   759			goto exit;
   760	
   761		msghdr = otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
   762		if (IS_ERR(msghdr)) {
   763			err = PTR_ERR(msghdr);
   764			goto exit;
   765		}
   766	
   767		rsp = (struct get_rep_cnt_rsp *)msghdr;
   768		priv->hw.tx_queues = rsp->rep_cnt;
   769		priv->hw.rx_queues = rsp->rep_cnt;
   770		priv->rep_cnt = rsp->rep_cnt;
   771		for (rep = 0; rep < priv->rep_cnt; rep++)
   772			priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];
   773	
   774	exit:
   775		mutex_unlock(&priv->mbox.lock);
   776		return err;
   777	}
   778	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
