Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792836734;
	b=R1pOIA8T0cK1NJGPZnc+7c6s/ukxEsj3p4yMRTvpFGCgQwB2a6Vp9lkgkRRNIdtNTfOS
	 6Hn2sqsS5412l/qPMHrk+M5C9VRmt29DZU3c0gu1XGDIP9pxL1O2QB9BsEr3jiJsuljXz
	 is+yrz7zHwVl9H6n7OZFaJoBETB9rr6qn6EdEB4hfHObVmGjKiWbEggEp8i4H+GH6I5Ub
	 a+OBzMjKj2ckia8KCsWbl0IyUs1g7rCKDhmZtWs3mJqLDFQODYcsoRjwYY9iSm7cW2HEm
	 uFH/yKDcM2hCEMjofdAu3LRdP7jOdd8gTAahCzzAD8y7VPwMwkyGMg5TnmBTyPLNoIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792836734;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5dDo2jQtU5YCwFaK037Js+A9XxUT5Bhl12dwg82ypVU=;
	b=Tc9wTfj/cqBX5zi1zMguJStc9J468j52+J6J/q5JJV4QnwNZ90tBtG+Hj/r1nc2pF9e+
	 sh691L6/KA5w/eelPYQDe1ptvglaRgfOUPENIKAlQklhrPlnF2KOKPvZibRZqgD1AwuK8
	 6CPuwqjUVwvQgVkeN0cbeUaTPYAgVdl8RW/yp8UUDVNvyg92Ij6sQxc66GW20yGIB/jPW
	 Jp8I1kr0kML7JO9tyj7MWws6yG70wYCfEjjT9mzzfXd8phMUPJlnraqXX14mkqsUzYILq
	 oQh5YWeoWKuFeY2NR1t4QEeO5btUcUYbpt5pj/iO/g71p8ht3DvLJWk5dGnTj6bLkIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxpIyPyJ;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF3606A31A;
	Sat, 24 Oct 2026 10:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBEF3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxpIyPyJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792836734; x=1824372734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bal+9D+8XcLLe75AoeOEIfT/sagOC17Rzw4JWqJmsYU=;
  b=dxpIyPyJlg0Lkyhqp2FAKDJMwQ5ZMERjLPOYAnvC2MbvSbvnxRAPBFEe
   8OocNnk06C7yl4WSn6IKHpEh7PDsH9XURbOd1oAkgiClD5c8GxuqpluIj
   3y8APK7hJWKepkuQ1BAN6U1tPDsfDEw0DRCOxbj91wm4c+imS+CEBNj1Z
   c0Mi3qeCKZCEyZt317RPPJGbRUSOyGYsXmXfusNQSLeKQ+Wc5mxP6dcWy
   d9OV5zBqsn1ZllWzUKVaSe046KtFJGL6FGeU7C9GM+IkKYP72zwqEll8c
   vmXUfdDrHR8Zi/QdxvmLg57WfTQbPr5+q31ZjEb15W8lgf32UdAA+6PKp
   g==;
X-CSE-ConnectionGUID: TXiTJD4uQ5q9sEb3T3Ee3w==
X-CSE-MsgGUID: PDcNd16gS5SC7Mj16f4aQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1468215"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1468215"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:12:13 -0700
X-CSE-ConnectionGUID: c19YS49JSKywUYxU7+lgvQ==
X-CSE-MsgGUID: Ywu+0ywoRM+SDJ6UcAMoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="4344600"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 24 Oct 2026 03:12:10 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKYjO-00000000TmI-2pwy;
	Sat, 24 Oct 2026 10:12:06 +0000
Date: Sat, 24 Oct 2026 18:11:39 +0800
From: kernel test robot <lkp@intel.com>
To: vmukunda <vmukunda@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	vmukunda <vmukunda@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Fix npc_delete_flow counter read for
 cn20k
Message-ID: <202610241814.S7V8CsQq-lkp@intel.com>
References: <20261023100112.3402726-1-vmukunda@marvell.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023100112.3402726-1-vmukunda@marvell.com>

Hi vmukunda,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/vmukunda/octeontx2-af-Fix-npc_delete_flow-counter-read-for-cn20k/20261023-100112
base:   net/main
patch link:    https://lore.kernel.org/r/20261023100112.3402726-1-vmukunda%40marvell.com
patch subject: [PATCH net] octeontx2-af: Fix npc_delete_flow counter read for cn20k
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20261024/202610241814.S7V8CsQq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610241814.S7V8CsQq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610241814.S7V8CsQq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/marvell/octeontx2/af/rvu.h:13,
                    from drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c:11:
   drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: In function 'rvu_mbox_handler_npc_delete_flow':
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c:1962:58: error: 'rvu_pdev' undeclared (first use in this function)
    1962 |                                 if (blkaddr && !is_cn20k(rvu_pdev))
         |                                                          ^~~~~~~~
   include/linux/soc/marvell/silicons.h:22:41: note: in definition of macro 'is_cn20k'
      22 | #define is_cn20k(pdev)          ((void)(pdev), 0)
         |                                         ^~~~
   drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c:1962:58: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/soc/marvell/silicons.h:22:41: note: in definition of macro 'is_cn20k'
      22 | #define is_cn20k(pdev)          ((void)(pdev), 0)
         |                                         ^~~~
   include/linux/soc/marvell/silicons.h:22:46: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      22 | #define is_cn20k(pdev)          ((void)(pdev), 0)
         |                                              ^
   drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c:1962:49: note: in expansion of macro 'is_cn20k'
    1962 |                                 if (blkaddr && !is_cn20k(rvu_pdev))
         |                                                 ^~~~~~~~


vim +/rvu_pdev +1962 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c

  1932	
  1933	int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
  1934					     struct npc_delete_flow_req *req,
  1935					     struct npc_delete_flow_rsp *rsp)
  1936	{
  1937		struct npc_mcam *mcam = &rvu->hw->mcam;
  1938		struct rvu_npc_mcam_rule *iter, *tmp;
  1939		u16 pcifunc = req->hdr.pcifunc;
  1940		struct list_head del_list;
  1941		int blkaddr;
  1942	
  1943		req->entry = npc_cn20k_vidx2idx(req->entry);
  1944		req->start = npc_cn20k_vidx2idx(req->start);
  1945		req->end = npc_cn20k_vidx2idx(req->end);
  1946	
  1947		INIT_LIST_HEAD(&del_list);
  1948	
  1949		mutex_lock(&mcam->lock);
  1950		list_for_each_entry_safe(iter, tmp, &mcam->mcam_rules, list) {
  1951			if (iter->owner == pcifunc) {
  1952				/* All rules */
  1953				if (req->all) {
  1954					list_move_tail(&iter->list, &del_list);
  1955				/* Range of rules */
  1956				} else if (req->end && iter->entry >= req->start &&
  1957					   iter->entry <= req->end) {
  1958					list_move_tail(&iter->list, &del_list);
  1959				/* single rule */
  1960				} else if (req->entry == iter->entry) {
  1961					blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> 1962					if (blkaddr && !is_cn20k(rvu_pdev))
  1963						rsp->cntr_val = rvu_read64(rvu, blkaddr,
  1964									   NPC_AF_MATCH_STATX(iter->cntr));
  1965					list_move_tail(&iter->list, &del_list);
  1966					break;
  1967				}
  1968			}
  1969		}
  1970		mutex_unlock(&mcam->lock);
  1971	
  1972		list_for_each_entry_safe(iter, tmp, &del_list, list) {
  1973			u16 entry = iter->entry;
  1974	
  1975			/* clear the mcam entry target pcifunc */
  1976			mcam->entry2target_pffunc[entry] = 0x0;
  1977			if (npc_delete_flow(rvu, iter, pcifunc))
  1978				dev_err(rvu->dev, "rule deletion failed for entry:%u",
  1979					entry);
  1980		}
  1981	
  1982		return 0;
  1983	}
  1984	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
