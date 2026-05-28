Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE635949;
	Thu, 28 May 2026 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779934606; cv=none; b=BonLUeC0aSpz9VHi64TGRGrix0hNzsDo6/QMKMsTrGT/iGaClPQZ87cTfMNmB/5WTahYh1w7ypnhQigtxESQJqUY8OuscY4VbWMp5yjk0X45whgNbUVDGqtFynq/uz9sUefK6HJ2W4QIr0i9/daiG3uFEAxRfbMxtCFZcRMCNNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779934606; c=relaxed/simple;
	bh=IFA4n4NLxQTVJh1fNUypLvf+igLULdkLZrE7pdAGJ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa9J0hQYDR4MRD1NPbFenRuJMF+Bo5uVjXda0PAwFINgS3lUrV+5oFyY8z/LBaTbtRyBOgwl0fnoFXMO5gnwZ5xZnf6+2TxUkFE2EokI0JsLMtugulFI7WMrgaUFqjZtRD56313DlGjmCCff8qsvimlRPXEKKRV85hbjOgCGfEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZ4S2wMj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZ4S2wMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779934605; x=1811470605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IFA4n4NLxQTVJh1fNUypLvf+igLULdkLZrE7pdAGJ6c=;
  b=UZ4S2wMjp/dpf5zV4G/tsI4cAdAGqFUehw1RC3LuyY4I8f1tQqqg1E5o
   M23vMu2mKh3Rqg3++DTqDYvH735QA3dos2OSWyiXzJf9RaUJdJO17r+UV
   ucDgsfhc3L/dxamOfjUh8vplAJkMoEzlqYGwKIDoYtIf9dNbpm9lXV2yk
   Mr/x5+Ohy7EFeUCgGth8yCB6YiAE1AUPqQAy+VkCDDuIegXVKwiaUUy/C
   gT5GW9yuBDDdlOI7NL/aV+lReOMVSGh/w/cHP7m8W/EznWoVswvtQExwv
   CYulyHS048r3H8QDxmufHPiOBM6cLQRYC92q6vR4GE4mmfSRuFQsEvmR0
   w==;
X-CSE-ConnectionGUID: +iNkxKFzTUaKF7WExDrHzw==
X-CSE-MsgGUID: CStnZJhiT1KFBx35Z4Mq6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="68307255"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="68307255"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 19:16:45 -0700
X-CSE-ConnectionGUID: lGqoO3zKRL+CcXT5DuOc7Q==
X-CSE-MsgGUID: zZuSP/VGRJC9qUdm09MiIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="272749359"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 May 2026 19:16:42 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSQIY-000000005RC-3NgD;
	Thu, 28 May 2026 02:16:38 +0000
Date: Thu, 28 May 2026 10:16:14 +0800
From: kernel test robot <lkp@intel.com>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Chuang Wang <nashuiliang@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <202605281038.YLl0IgeD-lkp@intel.com>
References: <20260525025854.13982-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525025854.13982-1-nashuiliang@gmail.com>

Hi Chuang,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuang-Wang/net-reduce-RFS-ARFS-flow-updates-by-checking-LLC-affinity/20260525-110036
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260525025854.13982-1-nashuiliang%40gmail.com
patch subject: [PATCH net-next v5] net: reduce RFS/ARFS flow updates by checking LLC affinity
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260528/202605281038.YLl0IgeD-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605281038.YLl0IgeD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605281038.YLl0IgeD-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "sock_rps_record_flow_hash" [drivers/net/tun.ko] undefined!
>> ERROR: modpost: "sock_rps_record_flow" [net/sctp/sctp.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
