Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE36202997;
	Thu, 21 May 2026 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394354; cv=none; b=Mw9jp9yqwMd1PxJ6uK7ee7MVx0cuDKDIKwpDaXxYC0fgqIcDwohPne7NOaLMh4l7KOZsoy8NJ5EV1LHKDOUrP6XNmRUAh1cCcyp9mGoMu0vX/6c6df84WgspCtVG46AVDDhDccfmm+bBvh+v1C3me34XYbvkTO+wfNSKuD0rDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394354; c=relaxed/simple;
	bh=Cfj4pAEMUJXQ0LlOrL+bUWwL556VY9ZDnN4iJSVIhUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1oxYkBLzs4WTQZV2C7GpKK2dlLYBeE+PtfBuEkrI0TDGXgOcKVDzYLvFE6IlGy4PkSSEeDpWxA8neh6h/2abzd7/C3AwJ1rPvngtT8ZlXBvu+g20E7T7e8GJcPgqAbXgOQPtVH9PRfQ3EAfDREjxC8KPGiuA/63IQjI31CSyO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buyHC+V8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buyHC+V8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779394352; x=1810930352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cfj4pAEMUJXQ0LlOrL+bUWwL556VY9ZDnN4iJSVIhUk=;
  b=buyHC+V8sYY0VaKJlWQj0+8bmA4AKx0LjaNTTh74LjtMhUUaMojxgt6b
   7vX6iDI3igETKPI32DP9+XW/DkVg2l6J+jthxQ7YOo7GeyAuROM9367/9
   U9dGdfX4s3zzm3oRKvZMyLNlAS20zTegerrc1HAVtUy9EPl0JFF5Vr6ne
   /8k0AcI01x1lYAM2VhfHM6SC3mto26jMuZ+KSyft6DWMkv/U2TeD7Bv59
   X4WZS5GThcCnWf4/QIsuaQWfus0y1BlSUKqHs5UzlG63OmzqM/CQ1e4+v
   /EiRhafENbFWVK7qg0Oq+yy+WUFLW2ysp07TPc1Erkwru4g4KIihDmuWA
   w==;
X-CSE-ConnectionGUID: 3CWsu73jSKmBWytvx6Moww==
X-CSE-MsgGUID: rK5f8fQLRi+WIium+epHUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91793298"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="91793298"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 13:12:32 -0700
X-CSE-ConnectionGUID: K97JLA7+TfCzLu/0fxkLmA==
X-CSE-MsgGUID: HFoLqunTSUybqUnZVQXJuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="270989249"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 May 2026 13:12:29 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQ9ko-00000000169-0hCv;
	Thu, 21 May 2026 20:12:26 +0000
Date: Fri, 22 May 2026 04:12:05 +0800
From: kernel test robot <lkp@intel.com>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Chuang Wang <nashuiliang@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <202605220442.6N3NuEDL-lkp@intel.com>
References: <20260521133711.20725-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521133711.20725-1-nashuiliang@gmail.com>

Hi Chuang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuang-Wang/net-reduce-RFS-ARFS-flow-updates-by-checking-LLC-affinity/20260521-223039
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260521133711.20725-1-nashuiliang%40gmail.com
patch subject: [PATCH net-next v4] net: reduce RFS/ARFS flow updates by checking LLC affinity
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20260522/202605220442.6N3NuEDL-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260522/202605220442.6N3NuEDL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605220442.6N3NuEDL-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "sock_rps_record_flow_hash" [drivers/net/tun.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
