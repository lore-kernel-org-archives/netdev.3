Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E23DA5DC;
	Fri, 21 Aug 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305362; cv=none; b=iw/1oy31elcvrFm3Ts7dS2udM9/kREogyseQpy6RvBVThv8UQdV9fSvibZc7o6X5v1YhNJMm8EaPlazK0lFXfZOQ2+EK49Sax/mgbFsWbEHoIe58vMhSSmau7Ee9mwcoeezdHoMXfazR1zyozQoLmiInJNlELTDuDjQblqOKOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305362; c=relaxed/simple;
	bh=JO5QFe2wQoESZjh0FkcnVu82NHIer0fa+ChwsfnRqos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQlY2mpQQlOmjTX7jFDciZH5EffmQ4bTG1Tzgx/iV3qyl5FoSMnGcv5G6LIND+lQUm4Tb8yoBj9cCpYxhv6dsKJDHLTzGVE22VmCrvdUNkgeLOpaGI6XEdvs9471jLkgPUDhJ+SiWGFojiGX1gMMJL9OOFcb1fPqGNX8IqDUvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8Ik3Pq5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8Ik3Pq5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787305355; x=1818841355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JO5QFe2wQoESZjh0FkcnVu82NHIer0fa+ChwsfnRqos=;
  b=h8Ik3Pq5NxyhGq/XHCvLum5vanmGDFC0BY9gyhIbtunyG0Ivo+D+0NlC
   c+uEl60kRjAkBa0zqQ3B1p7cggdFpSRqsf2Ygaz++NEPgMJBgcUJER3G9
   34HbSmdfKoLqi68ZIwqUNlgvTTUPbUlo0eBEoNT1Bca79ouIsml/Hekyr
   j+Eym8S5SBZR84zg5ftWkNxvpo/N0s+T4LpDdT/z7JKnu9giAX81Xec93
   9Bw3SNz8Ga3kX8r29kvusky5tHuXkLDQQtQRR5xE/6tlcZCHIMDsLnTuM
   oQCga19XLdY8LftVn2jwPo7ZyoM66Kv0SJm17+5e6PWUoPYqspwbj7qOv
   g==;
X-CSE-ConnectionGUID: oSdphr2sSjyB8HbTy7UYow==
X-CSE-MsgGUID: oYEp2J0eQ3qioWjwZJFTFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87621430"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="87621430"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 02:42:29 -0700
X-CSE-ConnectionGUID: 0YMZmJ6YR0WVtkjU/AjEAw==
X-CSE-MsgGUID: rNMgWl/HSUy923rouI6tiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="270113233"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Aug 2026 02:42:25 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wxLlV-00000000phh-2ll1;
	Fri, 21 Aug 2026 09:42:21 +0000
Date: Fri, 21 Aug 2026 17:41:25 +0800
From: kernel test robot <lkp@intel.com>
To: Yuqi Xu <xuyuqiabc@gmail.com>, Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Pravin B Shelar <pshelar@ovn.org>, Jakub Kicinski <kuba@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Yi-Hung Wei <yihung.wei@gmail.com>,
	netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Vega <vega@nebusec.ai>,
	Nan Li <tonanli66@gmail.com>, Ren Wei <enjou1224z@gmail.com>
Subject: Re: [PATCH net v8 1/1] openvswitch: Fix CT limit teardown
 use-after-free
Message-ID: <202608211727.eYRZFh9r-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20260821 (https://download.01.org/0day-ci/archive/20260821/202608211727.eYRZFh9r-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260821/202608211727.eYRZFh9r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608211727.eYRZFh9r-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/openvswitch/datapath.c:2777:36: error: no member named 'ct_exit_data' in 'struct ovs_net'
    2777 |         ovs_ct_exit_finish(dnet, ovs_net->ct_exit_data);
         |                                  ~~~~~~~  ^
   1 error generated.


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
