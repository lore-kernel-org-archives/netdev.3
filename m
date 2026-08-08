Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197202737F8
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786199032; cv=none; b=RCTvOodYZZ/TJVrWOAsib+ugWSG58SEVSS0ZxjcK73PhCd7qxhHzo+msTLKJA3/ICzeIifhub+xLW5k4lKtXFQ03UtDh1G8Mt/iiQ41rLtG0VwmoY4B8mPmBvE5P8hacs0NfJohKMRhXtANRccsYNPLHusYaBoJ6LNm1jfbrCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786199032; c=relaxed/simple;
	bh=vCUWFKfgmoSEJyYU1Sgce2foXImx7j2Q2oCrHM5nlnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJvJ2pfp8tVT+aHe/0IliKmIFkqvQvG0SvbvLv1CO2FkqI9NSc8p2t2x+g0Zya7c1E1qocYNbKkq+D7Vr5VP4tNyuW8c6CdePZZCZ8Ejd7s45jZpgdPGOK0uhy8IvrH0T8Eatmvx4hs2OrrT8e+wUwKC1i4Mihim4hZUtyG2yEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxnHUDwK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxnHUDwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786199030; x=1817735030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCUWFKfgmoSEJyYU1Sgce2foXImx7j2Q2oCrHM5nlnM=;
  b=gxnHUDwKoFmTVJE4qDmIa7dsWmLZXZ+gNEyHrnfqOl6jzGy7TSztBmsn
   t1E7a4Ztx0et9JyuPiEo5FKUEHsREUZRS4prh/dIp0jsAA0eKs5k1E31K
   nrJx9LpAq6WgDZ0cw12M482F1FhVWyk2EP65pSoASX5Mns2rWVQG5Xxdg
   YBgTGWy5m94cBBeDjibbJUt1S96srLBw1nuKwkDraGTPND2KKX2u5sIfc
   FvjYzM7CAzTNdrzBqWhFDL8rqi4UmgaR0P9yy3q1ubxeni7tLrHKyIWWo
   nxXwLAtWXy3z+2UyrnAF+j0wi/JAWB9F7+Fn6R8U65fSDvG1V2htaNTRc
   Q==;
X-CSE-ConnectionGUID: 3rjOOK9QQe+yvHAxnhQz0g==
X-CSE-MsgGUID: iSSjFTZNTVmHXioXIliuIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="90663108"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="90663108"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 07:23:50 -0700
X-CSE-ConnectionGUID: KhFbMEqIQf+nDbviQasnmw==
X-CSE-MsgGUID: D2EcDgSqSMCg7uGAHB0rmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="260027143"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2026 07:23:46 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wshxf-00000000KFR-0fRu;
	Sat, 08 Aug 2026 14:23:43 +0000
Date: Sat, 8 Aug 2026 22:23:03 +0800
From: kernel test robot <lkp@intel.com>
To: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
	dev@openvswitch.org, i.maximets@ovn.org
Cc: oe-kbuild-all@lists.linux.dev, aconole@redhat.com, echaudro@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: Re: [PATCH net v4 1/1] net: openvswitch: reallocate update replies
 for mismatched IDs
Message-ID: <202608082248.euvm5RXc-lkp@intel.com>
References: <3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz@nebusec.ai>

Hi Zhiling,

kernel test robot noticed the following build errors:

[auto build test ERROR on horms-ipvs/master]
[also build test ERROR on v7.2-rc6]
[cannot apply to net/main net-next/main linus/master next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhiling-Zou/net-openvswitch-reallocate-update-replies-for-mismatched-IDs/20260808-205431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
patch link:    https://lore.kernel.org/r/3b76cbe50252a5650c3b69c789ed36481d0bbee4.1785583308.git.zhilinz%40nebusec.ai
patch subject: [PATCH net v4 1/1] net: openvswitch: reallocate update replies for mismatched IDs
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260808/202608082248.euvm5RXc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608082248.euvm5RXc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608082248.euvm5RXc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/alpha/include/generated/asm/current.h:1,
                    from arch/alpha/include/asm/spinlock.h:6,
                    from include/linux/spinlock.h:94,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/openvswitch/datapath.c:9:
   net/openvswitch/datapath.c: In function 'ovs_flow_cmd_new':
>> include/asm-generic/current.h:7:45: error: expected ')' before '->' token
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   net/openvswitch/datapath.c:1100:32: note: in expansion of macro 'current'
    1100 |                         size_t current, desired;
         |                                ^~~~~~~
>> net/openvswitch/datapath.c:1102:33: error: assignment to 'struct task_struct *' from 'size_t' {aka 'long unsigned int'} makes pointer from integer without a cast [-Wint-conversion]
    1102 |                         current = ovs_flow_cmd_msg_size(acts, &new_flow->id,
         |                                 ^
>> net/openvswitch/datapath.c:1104:25: error: 'desired' undeclared (first use in this function)
    1104 |                         desired = ovs_flow_cmd_msg_size(acts, &flow->id,
         |                         ^~~~~~~
   net/openvswitch/datapath.c:1104:25: note: each undeclared identifier is reported only once for each function it appears in


vim +1102 net/openvswitch/datapath.c

   966	
   967	static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
   968	{
   969		struct net *net = sock_net(skb->sk);
   970		struct nlattr **a = info->attrs;
   971		struct ovs_header *ovs_header = info->userhdr;
   972		struct sw_flow *flow = NULL, *new_flow;
   973		struct sw_flow_mask mask;
   974		struct sk_buff *reply;
   975		struct datapath *dp;
   976		struct sw_flow_key *key;
   977		struct sw_flow_actions *acts;
   978		struct sw_flow_match match;
   979		u32 ufid_flags = ovs_nla_get_ufid_flags(a[OVS_FLOW_ATTR_UFID_FLAGS]);
   980		int error;
   981		bool log = !a[OVS_FLOW_ATTR_PROBE];
   982	
   983		/* Must have key and actions. */
   984		error = -EINVAL;
   985		if (!a[OVS_FLOW_ATTR_KEY]) {
   986			OVS_NLERR(log, "Flow key attr not present in new flow.");
   987			goto error;
   988		}
   989		if (!a[OVS_FLOW_ATTR_ACTIONS]) {
   990			OVS_NLERR(log, "Flow actions attr not present in new flow.");
   991			goto error;
   992		}
   993	
   994		/* Most of the time we need to allocate a new flow, do it before
   995		 * locking.
   996		 */
   997		new_flow = ovs_flow_alloc();
   998		if (IS_ERR(new_flow)) {
   999			error = PTR_ERR(new_flow);
  1000			goto error;
  1001		}
  1002	
  1003		/* Extract key. */
  1004		key = kzalloc(sizeof(*key), GFP_KERNEL);
  1005		if (!key) {
  1006			error = -ENOMEM;
  1007			goto err_kfree_flow;
  1008		}
  1009	
  1010		ovs_match_init(&match, key, false, &mask);
  1011		error = ovs_nla_get_match(net, &match, a[OVS_FLOW_ATTR_KEY],
  1012					  a[OVS_FLOW_ATTR_MASK], log);
  1013		if (error)
  1014			goto err_kfree_key;
  1015	
  1016		ovs_flow_mask_key(&new_flow->key, key, true, &mask);
  1017	
  1018		/* Extract flow identifier. */
  1019		error = ovs_nla_get_identifier(&new_flow->id, a[OVS_FLOW_ATTR_UFID],
  1020					       key, log);
  1021		if (error)
  1022			goto err_kfree_key;
  1023	
  1024		/* Validate actions. */
  1025		error = ovs_nla_copy_actions(net, a[OVS_FLOW_ATTR_ACTIONS],
  1026					     &new_flow->key, &acts, log);
  1027		if (error) {
  1028			OVS_NLERR(log, "Flow actions may not be safe on all matching packets.");
  1029			goto err_kfree_key;
  1030		}
  1031	
  1032		reply = ovs_flow_cmd_alloc_info(acts, &new_flow->id, info, false,
  1033						ufid_flags);
  1034		if (IS_ERR(reply)) {
  1035			error = PTR_ERR(reply);
  1036			goto err_kfree_acts;
  1037		}
  1038	
  1039		ovs_lock();
  1040		dp = get_dp(net, ovs_header->dp_ifindex);
  1041		if (unlikely(!dp)) {
  1042			error = -ENODEV;
  1043			goto err_unlock_ovs;
  1044		}
  1045	
  1046		/* Check if this is a duplicate flow */
  1047		if (ovs_identifier_is_ufid(&new_flow->id))
  1048			flow = ovs_flow_tbl_lookup_ufid(&dp->table, &new_flow->id);
  1049		if (!flow)
  1050			flow = ovs_flow_tbl_lookup(&dp->table, key);
  1051		if (likely(!flow)) {
  1052			rcu_assign_pointer(new_flow->sf_acts, acts);
  1053	
  1054			/* Put flow in bucket. */
  1055			error = ovs_flow_tbl_insert(&dp->table, new_flow, &mask);
  1056			if (unlikely(error)) {
  1057				acts = NULL;
  1058				goto err_unlock_ovs;
  1059			}
  1060	
  1061			if (unlikely(reply)) {
  1062				error = ovs_flow_cmd_fill_info(new_flow,
  1063							       ovs_header->dp_ifindex,
  1064							       reply, info->snd_portid,
  1065							       info->snd_seq, 0,
  1066							       OVS_FLOW_CMD_NEW,
  1067							       ufid_flags);
  1068				BUG_ON(error < 0);
  1069			}
  1070			ovs_unlock();
  1071		} else {
  1072			struct sw_flow_actions *old_acts;
  1073	
  1074			/* Bail out if we're not allowed to modify an existing flow.
  1075			 * We accept NLM_F_CREATE in place of the intended NLM_F_EXCL
  1076			 * because Generic Netlink treats the latter as a dump
  1077			 * request.  We also accept NLM_F_EXCL in case that bug ever
  1078			 * gets fixed.
  1079			 */
  1080			if (unlikely(info->nlhdr->nlmsg_flags & (NLM_F_CREATE
  1081								 | NLM_F_EXCL))) {
  1082				error = -EEXIST;
  1083				goto err_unlock_ovs;
  1084			}
  1085	
  1086			/* Look for any overlapping flow. */
  1087			if (unlikely(!ovs_flow_cmp(flow, &match))) {
  1088				if (ovs_identifier_is_key(&flow->id))
  1089					flow = ovs_flow_tbl_lookup_exact(&dp->table,
  1090									 &match);
  1091				else /* UFID matches but key is different */
  1092					flow = NULL;
  1093				if (!flow) {
  1094					error = -ENOENT;
  1095					goto err_unlock_ovs;
  1096				}
  1097			}
  1098	
  1099			if (unlikely(reply)) {
> 1100				size_t current, desired;
  1101	
> 1102				current = ovs_flow_cmd_msg_size(acts, &new_flow->id,
  1103								ufid_flags);
> 1104				desired = ovs_flow_cmd_msg_size(acts, &flow->id,
  1105								ufid_flags);
  1106				if (current < desired) {
  1107					struct sk_buff *resized;
  1108	
  1109					resized = ovs_flow_cmd_alloc_info(acts, &flow->id,
  1110									  info, false,
  1111									  ufid_flags);
  1112					if (IS_ERR(resized)) {
  1113						error = PTR_ERR(resized);
  1114						goto err_unlock_ovs;
  1115					}
  1116					kfree_skb(reply);
  1117					reply = resized;
  1118				}
  1119			}
  1120	
  1121			/* Update actions. */
  1122			old_acts = ovsl_dereference(flow->sf_acts);
  1123			rcu_assign_pointer(flow->sf_acts, acts);
  1124	
  1125			if (unlikely(reply)) {
  1126				error = ovs_flow_cmd_fill_info(flow,
  1127							       ovs_header->dp_ifindex,
  1128							       reply, info->snd_portid,
  1129							       info->snd_seq, 0,
  1130							       OVS_FLOW_CMD_NEW,
  1131							       ufid_flags);
  1132				BUG_ON(error < 0);
  1133			}
  1134			ovs_unlock();
  1135	
  1136			ovs_nla_free_flow_actions_rcu(old_acts);
  1137			ovs_flow_free(new_flow, false);
  1138		}
  1139	
  1140		if (reply)
  1141			ovs_notify(&dp_flow_genl_family, reply, info);
  1142	
  1143		kfree(key);
  1144		return 0;
  1145	
  1146	err_unlock_ovs:
  1147		ovs_unlock();
  1148		kfree_skb(reply);
  1149	err_kfree_acts:
  1150		ovs_nla_free_flow_actions(acts);
  1151	err_kfree_key:
  1152		kfree(key);
  1153	err_kfree_flow:
  1154		ovs_flow_free(new_flow, false);
  1155	error:
  1156		return error;
  1157	}
  1158	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
