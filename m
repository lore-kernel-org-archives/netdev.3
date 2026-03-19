Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D23B895F;
	Thu, 19 Mar 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773911847; cv=none; b=AgLJjS80vxGBKTYGEQkLZuee40Z9iAEyQZUl6Ek3PgrRU4WQVbVd3v/KP+nDjT7zP+VFjBshnTWyasuXmhTAXK1mHOtzn+KEIHaKBMAIBSdkUzj2YWdMv89VWYWkRbNPJmWBrol7FgCX5CjCodoYKqrB0v21vVkcdmSKOtPZhiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773911847; c=relaxed/simple;
	bh=DIU/PzVumUQH6MdAZ2KxRAqnEWB7buh0Ki3HJWJvQNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggLhSOsgPARokTYAOXLMN20q5HspgAor1U6934RZ3Zu5tiUKws1HgIzJYah+rBYuy89Mp+GljxBSC7RdmleKjdECghEWxexTAWGtsYHk3PtZ7EABH1T8m62zbwnwb/K321rB43wWlYC88nf3ifIau41Yp0htsTgHgDmHtyvLiiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J5Xir0of; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5Xir0of"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773911846; x=1805447846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIU/PzVumUQH6MdAZ2KxRAqnEWB7buh0Ki3HJWJvQNk=;
  b=J5Xir0ofhFLV7yZcL1OMoKKPXVkYcIjWH2r8OewNyyjINvG3eXmlI9b2
   WESU4NSH1+hhDbuAfpfjj2rqXnOHk04CzbRqr5gqyckVTUR9YMGop4cf+
   xlTV4RHQZPreVwEnrkFlJeMGOdeimUJhbAJfl2FOTFuf7yaBTxOMp1mXI
   uEeAZDsquaL/kutCSVZAwvXeQoKzK/A5F+rNZvWW/kcRlUmvZNKFvpg7H
   ttt5H266GtUJkdORacWbFO1q4urwtR2io8ieDwyHv7c1HDQPyarWgeHow
   icjUaCF8H4b8ioDl6A0YDfz2hF/4C9V9KhgbfsSGjV+z0+x0aJxsV4UWp
   w==;
X-CSE-ConnectionGUID: adnmLJldTHyaXSzf0SkxiQ==
X-CSE-MsgGUID: bNGrEno3Q/eOyXWgyewhWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74863216"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74863216"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:17:25 -0700
X-CSE-ConnectionGUID: u5dIcVMPSsylgEdsrZ54dg==
X-CSE-MsgGUID: ojN/sDYrTkmXLdF+vh6iSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227848554"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 02:17:18 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w39VE-000000004o5-13CR;
	Thu, 19 Mar 2026 09:17:16 +0000
Date: Thu, 19 Mar 2026 10:16:33 +0100
From: kernel test robot <lkp@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
	alexanderduyck@fb.com, kernel-team@meta.com,
	johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
	dtatulea@nvidia.com, sdf@fomichev.me, mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com, willemb@google.com, skhawaja@google.com,
	bestswngs@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use
 __rtnl_unlock in nl80211_pre_doit
Message-ID: <202603191008.66uOsWyh-lkp@intel.com>
References: <20260318150305.123900-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318150305.123900-3-sdf@fomichev.me>

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/net-add-address-list-snapshot-and-reconciliation-infrastructure/20260319-122535
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260318150305.123900-3-sdf%40fomichev.me
patch subject: [Intel-wired-lan] [PATCH net-next v2 02/13] wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260319/202603191008.66uOsWyh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260319/202603191008.66uOsWyh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603191008.66uOsWyh-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__rtnl_unlock" [net/wireless/cfg80211.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
