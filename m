Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7523939A5;
	Sun, 16 Aug 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786878831; cv=none; b=iFEME3LYHyeLoYKdpuBU66kvBk2d/rmJoGIUfqnDmbbQCLAhT4fYugP//suibiPZqnS3qnISNEbLhVy+kMt2fY1toeCAaidtQF5gxXP/chO8uWgcseNgTnMViJwH3cn0yM8shCrCOmYXWA25/MwWUK/mt7O7+qhs/h+a9/tHKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786878831; c=relaxed/simple;
	bh=90yihhOGUyrauzMhklE1nAOYqnEPs8ry9JwiGaH7Jd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVT9yp/kWtspAEqev8weFa8GviKuP3EYFf2yODsdHPupugPRpXQoR5uJyH4mcqRBh4ukdlE///YIakHDfTJkTApRgEMbC+7+12bUg+nTGop0jLdSnaSTliOKQ3iHFzska0ao/nw5qUl9s6vnQlcOL7t/NaZYfjRCzJx4dflrQcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NxWtecWA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NxWtecWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786878829; x=1818414829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=90yihhOGUyrauzMhklE1nAOYqnEPs8ry9JwiGaH7Jd8=;
  b=NxWtecWAiUw7Q+NhaAlALCY+wtrF6pW0XIV8iVfjJr80QU4fWHIgmMAk
   zUkNXqGM9wk7Lb9C3AzMWwP6QUcTGNYgBAdisBPsu1y8uaQyPxtpAn7Xr
   q5Zng3XmgRfgygMd3kw5ngpdDyPIGWX90QapamyhSiz0SefQV9d3oARmU
   h0rqNKokQlG2GC53lAkLoDS4H0CKHVa/aJx497g5kNIivqq2XicF1hQJp
   SYWWlQPwEMczuI/G1L1sk4kqqCWqwgKKFjnsNqivsJjkvinS9o7QTMJRO
   Nv+BpmMhT+ctRSwOLIulacP0HODNBKK+dxlZnez7qpGb6al42dGbc9MLC
   Q==;
X-CSE-ConnectionGUID: scyKuChZQvC13qfvtkrWAw==
X-CSE-MsgGUID: CgixAdv1Qj+aaR7e5+xjSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87507715"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="87507715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 04:13:48 -0700
X-CSE-ConnectionGUID: BD65+aCBQO6WqSIml+moGg==
X-CSE-MsgGUID: 195bUM0zSbS6Pz9hPtI/Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="294566699"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Aug 2026 04:13:46 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvYoA-00000000crm-44zD;
	Sun, 16 Aug 2026 11:13:42 +0000
Date: Sun, 16 Aug 2026 19:13:27 +0800
From: kernel test robot <lkp@intel.com>
To: zhang.enpei@zte.com.cn, chessman@tux.org
Cc: oe-kbuild-all@lists.linux.dev, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ethernet: tlan: Convert to use jiffies macro
Message-ID: <202608161916.ywuToiQt-lkp@intel.com>
References: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827155455583-PdvmDYA9SD3J37_XRza5@zte.com.cn>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhang-enpei-zte-com-cn/ethernet-tlan-Convert-to-use-jiffies-macro/20260813-185229
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827155455583-PdvmDYA9SD3J37_XRza5%40zte.com.cn
patch subject: [PATCH v3] ethernet: tlan: Convert to use jiffies macro
config: i386-randconfig-063-20260816 (https://download.01.org/0day-ci/archive/20260816/202608161916.ywuToiQt-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260816/202608161916.ywuToiQt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608161916.ywuToiQt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/ti/tlan.c:1833:29: sparse: sparse: incompatible types in comparison expression (different type sizes):
   drivers/net/ethernet/ti/tlan.c:1833:29: sparse:    unsigned long *
   drivers/net/ethernet/ti/tlan.c:1833:29: sparse:    unsigned int *

vim +1833 drivers/net/ethernet/ti/tlan.c

  1771	
  1772	
  1773	/***************************************************************
  1774	 *	tlan_timer
  1775	 *
  1776	 *	Returns:
  1777	 *		Nothing
  1778	 *	Parms:
  1779	 *		data	A value given to add timer when
  1780	 *			add_timer was called.
  1781	 *
  1782	 *	This function handles timed functionality for the
  1783	 *	TLAN driver.  The two current timer uses are for
  1784	 *	delaying for autonegotionation and driving the ACT LED.
  1785	 *	-	Autonegotiation requires being allowed about
  1786	 *		2 1/2 seconds before attempting to transmit a
  1787	 *		packet.  It would be a very bad thing to hang
  1788	 *		the kernel this long, so the driver doesn't
  1789	 *		allow transmission 'til after this time, for
  1790	 *		certain PHYs.  It would be much nicer if all
  1791	 *		PHYs were interrupt-capable like the internal
  1792	 *		PHY.
  1793	 *	-	The ACT LED, which shows adapter activity, is
  1794	 *		driven by the driver, and so must be left on
  1795	 *		for a short period to power up the LED so it
  1796	 *		can be seen.  This delay can be changed by
  1797	 *		changing the TLAN_TIMER_ACT_DELAY in tlan.h,
  1798	 *		if desired.  100 ms  produces a slightly
  1799	 *		sluggish response.
  1800	 *
  1801	 **************************************************************/
  1802	
  1803	static void tlan_timer(struct timer_list *t)
  1804	{
  1805		struct tlan_priv	*priv = timer_container_of(priv, t, timer);
  1806		struct net_device	*dev = priv->dev;
  1807		unsigned long	flags = 0;
  1808	
  1809		priv->timer.function = NULL;
  1810	
  1811		switch (priv->timer_type) {
  1812		case TLAN_TIMER_PHY_PDOWN:
  1813			tlan_phy_power_down(dev);
  1814			break;
  1815		case TLAN_TIMER_PHY_PUP:
  1816			tlan_phy_power_up(dev);
  1817			break;
  1818		case TLAN_TIMER_PHY_RESET:
  1819			tlan_phy_reset(dev);
  1820			break;
  1821		case TLAN_TIMER_PHY_START_LINK:
  1822			tlan_phy_start_link(dev);
  1823			break;
  1824		case TLAN_TIMER_PHY_FINISH_AN:
  1825			tlan_phy_finish_auto_neg(dev);
  1826			break;
  1827		case TLAN_TIMER_FINISH_RESET:
  1828			tlan_finish_reset(dev);
  1829			break;
  1830		case TLAN_TIMER_ACTIVITY:
  1831			spin_lock_irqsave(&priv->lock, flags);
  1832			if (priv->timer.function == NULL) {
> 1833				if (time_is_before_eq_jiffies(priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {
  1834					tlan_dio_write8(dev->base_addr,
  1835							TLAN_LED_REG, TLAN_LED_LINK);
  1836				} else  {
  1837					priv->timer.expires = priv->timer_set_at
  1838						+ TLAN_TIMER_ACT_DELAY;
  1839					spin_unlock_irqrestore(&priv->lock, flags);
  1840					add_timer(&priv->timer);
  1841					break;
  1842				}
  1843			}
  1844			spin_unlock_irqrestore(&priv->lock, flags);
  1845			break;
  1846		default:
  1847			break;
  1848		}
  1849	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
