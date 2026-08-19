Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007C3368A5
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165632; cv=none; b=KgEWtGR6zWQcLiMt2bzQs0u1bP+nbyAbibMfzgLq3H3DZhJYOsoQ9LeOYp25QS4Loxha2fDhJSWSsTQ8F47Tfm/RFultwO6mK93XGHn7B54FfU57usnwrWs8O039gXjX+ydhbIEHiplO90mmIHhhh93hsLGWHBpohVmN26+nKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165632; c=relaxed/simple;
	bh=njAdAUaZrfoqjco8JR98opQaVKhhlTN2+YS4XZCA5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Dzy7WF7QWKy0EVJn2Ig2rTT+Mn7zBcmqljUddinkIz19aEyJjZxDn8XMDX4Ru3f+aiGGIlP1By+oIdo+TjDmZL6fvvViwsGMbgp8W3dS2SIf5ty3eNky2r8RWy51a0TZMd1iVT84A1a1sUE9XnzOVxeryGpic2IeE146in2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gshoj++P; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gshoj++P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787165631; x=1818701631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njAdAUaZrfoqjco8JR98opQaVKhhlTN2+YS4XZCA5Cc=;
  b=gshoj++PVoFZhRK+Eqh1oxkmfr9mpCIZ0fLJzU073SdmylpbJ+d7KY+o
   qyWZyxc5MGloRxNNwBeV4xy7vn3V8s+rSQNeK7DRFpJVY7HsSNrDqStvI
   yPPa0RljcPMP9sXhaYOddlzXSQVJvssdur2UPVbNgl2qTlni1ecSmZykZ
   2+E62n7f9hEBkwKorxgtlhblV7U+wtFwMz/XuQcIBgWBEbqqfub6BQYhj
   0abEizlNdc8Z/Gks2RzYqLdHn8tw04utCZpuHKlWVL5ppeL8roZJux5l7
   4OS4rkBhXIEWfPIjADT9+XdLq1y0pCklexsz2sTtuU0JUIdDgUFTe1X9j
   Q==;
X-CSE-ConnectionGUID: uU6dHFViRhC6vKuExLlrwQ==
X-CSE-MsgGUID: rtNo+SpMRxWdYnGcW2oBbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="75223601"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="75223601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 11:53:50 -0700
X-CSE-ConnectionGUID: gjWbI4aMTAa/8ZJLkxROVQ==
X-CSE-MsgGUID: /Jk+kwP+Rh6USZ5712SUAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303846896"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 11:53:47 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wwlQ0-00000000g7l-36ph;
	Wed, 19 Aug 2026 18:53:44 +0000
Date: Thu, 20 Aug 2026 02:53:01 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	syzbot+6c98d6eb7aabb6b1ad39@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/atm: fix slab-out-of-bounds read in
 vcc_setsockopt()
Message-ID: <202608200206.vI8yz6EN-lkp@intel.com>
References: <20260804145806.2112004-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804145806.2112004-1-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on horms-ipvs/master]
[cannot apply to net/main net-next/main linus/master v7.2 next-20260818]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-atm-fix-slab-out-of-bounds-read-in-vcc_setsockopt/20260804-145806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
patch link:    https://lore.kernel.org/r/20260804145806.2112004-1-edumazet%40google.com
patch subject: [PATCH net] net/atm: fix slab-out-of-bounds read in vcc_setsockopt()
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260820/202608200206.vI8yz6EN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260820/202608200206.vI8yz6EN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608200206.vI8yz6EN-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/atm/common.c: In function 'vcc_setsockopt':
>> net/atm/common.c:763:25: error: implicit declaration of function 'copy_safe_from_sockptr'; did you mean 'copy_from_sockptr'? [-Wimplicit-function-declaration]
     763 |                 error = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         copy_from_sockptr


vim +763 net/atm/common.c

   746	
   747	int vcc_setsockopt(struct socket *sock, int level, int optname,
   748			   sockptr_t optval, unsigned int optlen)
   749	{
   750		struct atm_vcc *vcc;
   751		unsigned long value;
   752		int error;
   753	
   754		if (__SO_LEVEL_MATCH(optname, level) && optlen != __SO_SIZE(optname))
   755			return -EINVAL;
   756	
   757		vcc = ATM_SD(sock);
   758		switch (optname) {
   759		case SO_ATMQOS:
   760		{
   761			struct atm_qos qos;
   762	
 > 763			error = copy_safe_from_sockptr(&qos, sizeof(qos), optval, optlen);
   764			if (error)
   765				return error;
   766			error = check_qos(&qos);
   767			if (error)
   768				return error;
   769			if (sock->state == SS_CONNECTED)
   770				return atm_change_qos(vcc, &qos);
   771			if (sock->state != SS_UNCONNECTED)
   772				return -EBADFD;
   773			vcc->qos = qos;
   774			set_bit(ATM_VF_HASQOS, &vcc->flags);
   775			return 0;
   776		}
   777		case SO_SETCLP:
   778			error = copy_safe_from_sockptr(&value, sizeof(value), optval, optlen);
   779			if (error)
   780				return error;
   781			if (value)
   782				vcc->atm_options |= ATM_ATMOPT_CLP;
   783			else
   784				vcc->atm_options &= ~ATM_ATMOPT_CLP;
   785			return 0;
   786		default:
   787			return -EINVAL;
   788		}
   789	}
   790	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
