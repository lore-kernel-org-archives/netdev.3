Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2B38AC7D;
	Fri, 21 Aug 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314848; cv=none; b=Hg+9psM5EXn3wrld09zNsGohY0vpzT6Kth31IlZa2fjnhHranMKAIbum5mdz2ConAk82xHhyCJkVOagGIl9f/wAa5NMFj9Sg8jUs9H9JDqLusbbnZdLvjbWtih1zB7a7Ycoq3uGFatcS8VkqYBU3hyoSGysl80vGjhzmZYkYSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314848; c=relaxed/simple;
	bh=F0Qz1FXuUeQ+aebSZ7J5KkIaNqhtePxQYjvAzCh7LAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqj5AuEUBttRJuhxTyvkQnMVGbOeym5Zog3fj6GUeMdKzNrT426tJBBK5I4XXow1kTDD6599rWvWr2+WrK9N5E+qy22ZI24QK03jO1WLrf0fG+V3MMJtrFC7Gsn8vX1WQEn9GvQl/bLggdULoLRBrzKZiJe4iE1AY+TDaAJ4gXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erinMlbs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erinMlbs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787314845; x=1818850845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F0Qz1FXuUeQ+aebSZ7J5KkIaNqhtePxQYjvAzCh7LAM=;
  b=erinMlbs4ohlQDdTFnfJFBcAuCbVV4bzlRFYOZ4UD1feY3quJwCvTRcl
   xXb02lrBKO+IQXZvft+8VNB3Eo8MRMJ5UFoWMO3UsrjJ5RtNrUvzoSznR
   BY9fQTJeqzK2/Qg1KHbueMe91AsinzYsSr/S+NcMRa4fqG/2FF/yRbi/f
   OAUYoMM1g6NqTOGr7awiQZ90SF1AUe/P6IARI0PdyvvlRCGUoyQ0lBkA4
   8M/GojRVOQZl6hajqeRygX/6AIJUGQVHirp8vsBd0SPNhuZf2JAQYJU20
   PxiH2GVFW12o7ZpCARnH0hEwZQFxpEjpdS5Xmfk3Km5vy2sDJ1Qps/c7J
   g==;
X-CSE-ConnectionGUID: +Rork/erSgi34Xecs1ygjg==
X-CSE-MsgGUID: PE/Mtj7lSOa89x6NouCMUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113400359"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="113400359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 05:20:42 -0700
X-CSE-ConnectionGUID: BAErVvaTTly8sDJbpLbS+g==
X-CSE-MsgGUID: Ql+Yk3eLS/ahDBj0EYKPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="269811701"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 21 Aug 2026 05:20:38 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxOEd-00000000pth-1vhi;
	Fri, 21 Aug 2026 12:20:35 +0000
Date: Fri, 21 Aug 2026 20:20:01 +0800
From: kernel test robot <lkp@intel.com>
To: Yuqi Xu <xuyuqiabc@gmail.com>, Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Pravin B Shelar <pshelar@ovn.org>, Jakub Kicinski <kuba@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Yi-Hung Wei <yihung.wei@gmail.com>, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kernel@vger.kernel.org,
	Vega <vega@nebusec.ai>, Nan Li <tonanli66@gmail.com>,
	Ren Wei <enjou1224z@gmail.com>
Subject: Re: [PATCH net v8 1/1] openvswitch: Fix CT limit teardown
 use-after-free
Message-ID: <202608212044.UwsWD6wL-lkp@intel.com>
References: <d9687780533d0b257e01ab792c8206a69beb281e.1787129643.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9687780533d0b257e01ab792c8206a69beb281e.1787129643.git.xuyuqiabc@gmail.com>

Hi Yuqi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 564973a259ec76f2dad0853420e7034cc43994c4]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuqi-Xu/openvswitch-Fix-CT-limit-teardown-use-after-free/20260819-172433
base:   564973a259ec76f2dad0853420e7034cc43994c4
patch link:    https://lore.kernel.org/r/d9687780533d0b257e01ab792c8206a69beb281e.1787129643.git.xuyuqiabc%40gmail.com
patch subject: [PATCH net v8 1/1] openvswitch: Fix CT limit teardown use-after-free
config: i386-randconfig-011-20260821 (https://download.01.org/0day-ci/archive/20260821/202608212044.UwsWD6wL-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260821/202608212044.UwsWD6wL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608212044.UwsWD6wL-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/openvswitch/datapath.c: In function 'ovs_exit_net':
>> net/openvswitch/datapath.c:2777:41: error: 'struct ovs_net' has no member named 'ct_exit_data'
    2777 |         ovs_ct_exit_finish(dnet, ovs_net->ct_exit_data);
         |                                         ^~


vim +2777 net/openvswitch/datapath.c

  2766	
  2767	static void __net_exit ovs_exit_net(struct net *dnet)
  2768	{
  2769		struct ovs_net *ovs_net = net_generic(dnet, ovs_net_id);
  2770		struct vport *vport, *vport_next;
  2771		struct datapath *dp, *dp_next;
  2772		struct net *net;
  2773		LIST_HEAD(head);
  2774	
  2775		ovs_lock();
  2776	
> 2777		ovs_ct_exit_finish(dnet, ovs_net->ct_exit_data);
  2778	
  2779		list_for_each_entry_safe(dp, dp_next, &ovs_net->dps, list_node)
  2780			__dp_destroy(dp);
  2781	
  2782		down_read(&net_rwsem);
  2783		for_each_net(net)
  2784			list_vports_from_net(net, dnet, &head);
  2785		up_read(&net_rwsem);
  2786	
  2787		/* Detach all vports from given namespace. */
  2788		list_for_each_entry_safe(vport, vport_next, &head, detach_list) {
  2789			list_del(&vport->detach_list);
  2790			ovs_dp_detach_port(vport);
  2791		}
  2792	
  2793		ovs_unlock();
  2794	
  2795		cancel_delayed_work_sync(&ovs_net->masks_rebalance);
  2796		cancel_work_sync(&ovs_net->dp_notify_work);
  2797	}
  2798	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
