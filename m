Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11213EBF02;
	Fri, 13 Feb 2026 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771019034; cv=none; b=FT+32a+Gr0lxDCdnf8ZSkb97Wv6u8uiu/M7kP5czsc1jC/2WgLIoE9rvVBqwaIuDBTY+vE+KxssSASunylziCQ/+u47honCB5eltPEZu/vtXD3lsh5EHafI6qnsp3FkFETc3lTSPSW6uumAJZW4c2DotM67A8Fe0kuAGb5T7mRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771019034; c=relaxed/simple;
	bh=VXgM+GQ0OlywxENAV3LyUK+Bsy+f552zytByCoHgY54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZXEiscZ0fCm5f/TeR4tXkmxy+GeS4aeVA3MCFwYIH+wZVJNiq36Rb7rRuVtBJl94ZxqsDcSh/Y/bJLKCLdCb26Znpu1oNwTn2KGfED7Y6YQXn6vDv4+RljVHMXH3yQ93GnRbAfDuQg2ETfboZhqkLBJPnnaTvAFj31OtfmnjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKXcJsQ3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKXcJsQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771019032; x=1802555032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VXgM+GQ0OlywxENAV3LyUK+Bsy+f552zytByCoHgY54=;
  b=hKXcJsQ39txPBx4HLcADRu7Ft6dl4vC3/bVE2VUnMxXa/C6Rcv/e9dtX
   04vivnFbXqGnVWW3pdFgpOSE3KCXa/E4iPkoFR77TsL9WlYU5EgwlC7Qp
   d98FJtUCAq3C3WzGNa3bV5+7ytS4kovWjacy1bTR4g7cvkCeR+hfr1CLR
   5JohQLz08OqmC6I3k+3prdsEeUCvp852uirMz6KfU/z9WD4W7c8KNqDRP
   vBFKuQw0PS+xVzFOaOvIGHwvVc06Q4kKC8CNq5Z8Zw+DoAqf1Yv50NPec
   FmlfILw9fFoZ94eDMKKdYkGVPd/AuNPI4MCGBDtGV4kBoNjtJ1vvP1lAi
   g==;
X-CSE-ConnectionGUID: mSlb665vRiCEGvTYWwAb9g==
X-CSE-MsgGUID: HOWBCm0STOWDJ9cOlPOPTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="82840609"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="82840609"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 13:43:51 -0800
X-CSE-ConnectionGUID: rPDd71cBQ7CHIuIuj+3WDg==
X-CSE-MsgGUID: yBlvjL9dSku9sKGyfQPS8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="218001593"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2026 13:43:47 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vr0wy-00000000vqS-2ejM;
	Fri, 13 Feb 2026 21:43:44 +0000
Date: Sat, 14 Feb 2026 05:43:30 +0800
From: kernel test robot <lkp@intel.com>
To: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Ziwei Xiao <ziweixiao@google.com>, John Fraker <jfraker@google.com>,
	Matt Olson <maolson@google.com>, Bailey Forrest <bcf@google.com>,
	Tim Hostetler <thostet@google.com>,
	Jordan Rhee <jordanrhee@google.com>, linux-kernel@vger.kernel.org,
	Max Yuan <maxyuan@google.com>
Subject: Re: [PATCH net-next 1/2] gve: Update QPL page registration logic
Message-ID: <202602140501.JzPUyrJP-lkp@intel.com>
References: <20260207011734.437205-2-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207011734.437205-2-joshwash@google.com>

Hi Joshua,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Washington/gve-Update-QPL-page-registration-logic/20260207-092137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260207011734.437205-2-joshwash%40google.com
patch subject: [PATCH net-next 1/2] gve: Update QPL page registration logic
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20260214/202602140501.JzPUyrJP-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602140501.JzPUyrJP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602140501.JzPUyrJP-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/google/gve/gve.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
