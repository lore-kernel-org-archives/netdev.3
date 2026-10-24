Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800258;
	b=MSZMLxHe0svOvbOxjkAAqeAKiYlHW9ux7u5AYG0gRtCo2Cmuw8uH92RBTJED8yY1XLGJ
	 5Np6NqK9AB2Y3nW6i91TpVnbbM8aA/4ZMF8AMAE185MEIbdqp5LKpB1TIzD41BP2kgDkt
	 QzCzHOFvtHpEWpamf4aeBVw/XgBlTYBrXpDSnltcrkeddlXSYYgFaIpMqMd3Ogb34jJ+J
	 FePTEGoNCtlms0y6V3PZyAa9BCgHbV2sEI3Ytw95YtkdFXoc+mkGKHNTcuABLCaSf4ypX
	 d5Ms+rV/7NFOk+Ce7rvmJAX1Yskz/Pk4VnmInVs7QcaNAVXAuRRobc0ds42IoE4CbWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800258;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IP4SXJLolNGj8GM5COqEi+6FqjwpuNDCYi1PHZX7pR4=;
	b=AjwkbgGuN0yKyH8ARliceH0M1M3xQoJEm0Siic0FO/MHmkxehJFRWyZyKCg1Tj9J5szU
	 k6C/1w//ixvNCnzD+tlyLq4FzknA5STltG+SzPL6LuXu715JcIUevCpB81mZr5CBsM+yA
	 g79zq4HE2m8g98zpunsu2+DBNZGxa+leP2ONfRsp2OXkTOIswC28X0XN/57HS1et0u7zE
	 TeQJA3vhVN2ZSNuqWyKiHK/aCc25BOebISLzETDSE8TY0pL+LuJ/TLEcrZDTA5FMfzq21
	 IVjnAczQOvnno4Urm1LGrxDxpxRQQq2j1yTCpOIbKcZZ9Tn/p58UpzIM5ghvy43Ukxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9UE2ZKL;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F2606A31A;
	Sat, 24 Oct 2026 00:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b9UE2ZKL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792800258; x=1824336258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P+WfGzR35UbRfWugdtCWwaOpsuK0iCs7ZWA1C8vDcZw=;
  b=b9UE2ZKLsYrtwp2obzTh15E2r5wsgQWmZbXOmppAL/HiB55/dD+mBUfm
   x/3M/Rj5QcikYCCspt5LlHCEtvmXIG8ivgCmwRTTkQYiLVpNxPcITmNuR
   w12vStUWVQTDOlMypskoD8f5+m4msr1Opq7Y8BktyI2KJ2wjg2YMw9xSi
   kicfdU92Eo1dXDawSiQbDGvUTTYhrDxuMgtGdZRCgRA4qKub1aGowti6x
   rZgUGp5VzYTywAVXYL7vYxru/YBCTIttOZSvYtY1KOmIsBGWMDZ32Y1gU
   MxZWyzySHNRsQwAxCdv3duyAalXvfaxVuV0rTVBM2t0axfEhiW5n84+/5
   w==;
X-CSE-ConnectionGUID: Yd90rh63TIaP1NisxHL0DA==
X-CSE-MsgGUID: JQWvlJSWRqiniBqG5ET6pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1571221"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1571221"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 17:04:17 -0700
X-CSE-ConnectionGUID: 8ZKO3aQSQUqN2JunwYUlEg==
X-CSE-MsgGUID: mcR2cGJBRrelzRwbxZT/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="5612886"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 23 Oct 2026 17:04:14 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKPF4-00000000TNy-3Gst;
	Sat, 24 Oct 2026 00:04:10 +0000
Date: Sat, 24 Oct 2026 08:03:31 +0800
From: kernel test robot <lkp@intel.com>
To: vmukunda <vmukunda@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sunil Goutham <sgoutham@marvell.com>,
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
Message-ID: <202610240701.QMuYCXhI-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261024/202610240701.QMuYCXhI-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 186e70f4e6a1521991d2340d3d49b23b1beff11f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610240701.QMuYCXhI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610240701.QMuYCXhI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c:1962:30: error: use of undeclared identifier 'rvu_pdev'
    1962 |                                 if (blkaddr && !is_cn20k(rvu_pdev))
         |                                                          ^~~~~~~~
   1 error generated.


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
