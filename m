Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8D3F6613;
	Wed,  5 Aug 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968951; cv=none; b=aVsuItkzAonRlp30wiDze9RDSnVxoerGbUJ5285pTEXXqUiX1W+om+5xcKSTf1IckRe23gytAeyCy7jJObfii/5J+BtLLP6FH4rIDu9gZXz0tk4aU9/gGXR1Wh/cyjg1DO7k/GzrOYDBFj1csdoFBB1yUZMDhS49tdYqYF7QLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968951; c=relaxed/simple;
	bh=p+tGgJjfDf+QExfIl3EY8iwwECUib4YEAIdONJSPpjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7GGz/i6EM58VqzsWuxCNKTHKn0C0YEQURmQGXWDMWQT4YFYi37L4jaUprBmxU2ElJ7Lm/HyMumpmpAfKnKXhcTxnupSCjdBzWNyXu+6GH/u198HtfaR2Ef4WgXGM1KI9jznMWVJEMeyn9xWduTYl8WSk1/Nr5GKH2Z2Tbjg2VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WL5bsVtS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WL5bsVtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785968948; x=1817504948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p+tGgJjfDf+QExfIl3EY8iwwECUib4YEAIdONJSPpjE=;
  b=WL5bsVtSl9bSxKln+O3ibQPXA/BzqK04A195qTZ1C6ulLESGi4+xH8kl
   GLSR49qXm9iSWlXcVdbJkqKNPBZw0KBVXb+zlaYSRKXUCeSdfIf+goj8v
   UyGBifFVYmKAHKi38YTDdBu3UYqk4lAl6GgSk/dxk64JCY7PLaW1EWe7L
   a+0Ax7sE+IBk35HCx3s0KEjQ2Pvc+SfIfLwVqukWMvGAQaQez4Tdwxa9W
   V4Jiidv3R50plI650G8VeKSVgu2REfhJQ3CUSLje9YLIh38qIrE7LUl4A
   jWyV+alJJ+T/SE/7GpjlFjg0gJJ14mThxDczWEhTLWJWaYs274JOsV8jc
   w==;
X-CSE-ConnectionGUID: 3ekwGT1iTVqNYD/J4JrZXA==
X-CSE-MsgGUID: +jy61pjJQK6VTxnI8uO1Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97713325"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="97713325"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 15:29:06 -0700
X-CSE-ConnectionGUID: NmwiC6myTPu6zWOTTx11KQ==
X-CSE-MsgGUID: BJGd6Ak0Rjqat4sLydi/YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="261989405"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Aug 2026 15:29:03 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrk6e-00000000Dan-209A;
	Wed, 05 Aug 2026 22:29:00 +0000
Date: Thu, 6 Aug 2026 06:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Switch <kyle.switch@motor-comm.com>, Frank.Sae@motor-comm.com,
	andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianmin.wang@motor-comm.com, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jie.han@motor-comm.com
Subject: Re: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Message-ID: <202608060635.338Kkf6r-lkp@intel.com>
References: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714111203.3852126-1-kyle.switch@motor-comm.com>

Hi Kyle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on linus/master v7.2-rc6 next-20260805]
[cannot apply to net-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Switch/net-phy-Add-driver-for-Motorcomm-Quad-2-5GbE-phy/20260805-175843
base:   net/main
patch link:    https://lore.kernel.org/r/20260714111203.3852126-1-kyle.switch%40motor-comm.com
patch subject: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
config: powerpc64-randconfig-002-20260806 (https://download.01.org/0day-ci/archive/20260806/202608060635.338Kkf6r-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608060635.338Kkf6r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608060635.338Kkf6r-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/motorcomm.c:3336:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    3336 |                 if (reg_space == YT8824_RSSR_UTP_SPACE) {
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:3353:44: note: uninitialized use occurs here
    3353 |         return phy_restore_page(phydev, old_page, ret);
         |                                                   ^~~
   drivers/net/phy/motorcomm.c:3336:3: note: remove the 'if' if its condition is always true
    3336 |                 if (reg_space == YT8824_RSSR_UTP_SPACE) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:3335:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    3335 |         if (old_page >= 0) {
         |             ^~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:3353:44: note: uninitialized use occurs here
    3353 |         return phy_restore_page(phydev, old_page, ret);
         |                                                   ^~~
   drivers/net/phy/motorcomm.c:3335:2: note: remove the 'if' if its condition is always true
    3335 |         if (old_page >= 0) {
         |         ^~~~~~~~~~~~~~~~~~
>> drivers/net/phy/motorcomm.c:3332:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    3332 |         if (old_page < 0)
         |             ^~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:3353:44: note: uninitialized use occurs here
    3353 |         return phy_restore_page(phydev, old_page, ret);
         |                                                   ^~~
   drivers/net/phy/motorcomm.c:3332:2: note: remove the 'if' if its condition is always false
    3332 |         if (old_page < 0)
         |         ^~~~~~~~~~~~~~~~~
    3333 |                 goto err_restore_page;
         |                 ~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:3329:9: note: initialize the variable 'ret' to silence this warning
    3329 |         int ret;
         |                ^
         |                 = 0
>> drivers/net/phy/motorcomm.c:3341:8: warning: variable 'port' is uninitialized when used here [-Wuninitialized]
    3341 |                         if (port == 0 || port == 2) {
         |                             ^~~~
   drivers/net/phy/motorcomm.c:3328:10: note: initialize the variable 'port' to silence this warning
    3328 |         int port;
         |                 ^
         |                  = 0
   drivers/net/phy/motorcomm.c:4464:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    4464 |         if (old_page < 0)
         |             ^~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:4477:44: note: uninitialized use occurs here
    4477 |         return phy_restore_page(phydev, old_page, ret);
         |                                                   ^~~
   drivers/net/phy/motorcomm.c:4464:2: note: remove the 'if' if its condition is always false
    4464 |         if (old_page < 0)
         |         ^~~~~~~~~~~~~~~~~
    4465 |                 goto err_restore_page;
         |                 ~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:4460:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    4460 |         if (old_page < 0)
         |             ^~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:4477:44: note: uninitialized use occurs here
    4477 |         return phy_restore_page(phydev, old_page, ret);
         |                                                   ^~~
   drivers/net/phy/motorcomm.c:4460:2: note: remove the 'if' if its condition is always false
    4460 |         if (old_page < 0)
         |         ^~~~~~~~~~~~~~~~~
    4461 |                 goto err_restore_page;
         |                 ~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:4457:9: note: initialize the variable 'ret' to silence this warning
    4457 |         int ret;
         |                ^
         |                 = 0
   drivers/net/phy/motorcomm.c:4641:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    4641 |         if (old_page < 0)
         |             ^~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:4660:44: note: uninitialized use occurs here
    4660 |         return phy_restore_page(phydev, old_page, ret);
         |                                                   ^~~
   drivers/net/phy/motorcomm.c:4641:2: note: remove the 'if' if its condition is always false
    4641 |         if (old_page < 0)
         |         ^~~~~~~~~~~~~~~~~
    4642 |                 goto err_restore_page;
         |                 ~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/motorcomm.c:4638:9: note: initialize the variable 'ret' to silence this warning
    4638 |         int ret;
         |                ^
         |                 = 0
   7 warnings generated.


vim +3336 drivers/net/phy/motorcomm.c

  3320	
  3321	/**
  3322	 * disable YT8824 template test mode.
  3323	 */
  3324	static int yt8824_soft_reset_step4_paged(struct phy_device *phydev,
  3325						 int reg_space)
  3326	{
  3327		int old_page;
  3328		int port;
  3329		int ret;
  3330	
  3331		old_page = phy_select_page(phydev, reg_space);
> 3332		if (old_page < 0)
  3333			goto err_restore_page;
  3334	
  3335		if (old_page >= 0) {
> 3336			if (reg_space == YT8824_RSSR_UTP_SPACE) {
  3337				/* normal mode */
  3338				ret = ytphy_write_mmd(phydev, 0x1, 0x0084, 0x0000);
  3339				if (ret < 0)
  3340					goto err_restore_page;
> 3341				if (port == 0 || port == 2) {
  3342					/* read the calibration val of band after power on,
  3343					 * * only for recording.
  3344					 */
  3345					ret = ytphy_read_ext(phydev, 0x043e);
  3346					if (ret < 0)
  3347						goto err_restore_page;
  3348				}
  3349			}
  3350		}
  3351	
  3352	err_restore_page:
  3353		return phy_restore_page(phydev, old_page, ret);
  3354	}
  3355	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
