Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB81C33D6D5;
	Sun, 16 Aug 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786840575; cv=none; b=rxthwreJkJ4z2fvYH92UcLYggx93qFPSKR+0o+L21rVdrBtWlQol0UmDpJmRsyB5L3W4aTkrojfILj0fTxOOlqeqkyX0DCXb5KSZxl6KfE1uV0Tx9NfQYErC/H9/AtaeWefZqXE1ifR8xUM6yajgpwCx3GPlBHOkqh/4IwSn+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786840575; c=relaxed/simple;
	bh=sLIRpgbeDqAtJvUvGCPYtBqldhnsPq1B8sRmOTCvQQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyTV0FgM0HarcZT70HcMvg7r4M5Bq7SmWKyLoJWFI5F/tdsBfYvdA9lx0lnnhvdRE/3uY+N9V87us5D4kbDnzX2DsIpboPHmM2x2EkR683YueVMycZqow1hjYMa/kxYW56rWNLiwWaOTYW8evhSAYYP6kY+xghsVp0fXhh3Fg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAx4R6pN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAx4R6pN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786840574; x=1818376574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLIRpgbeDqAtJvUvGCPYtBqldhnsPq1B8sRmOTCvQQ0=;
  b=NAx4R6pN018/2NVIxWIG/bmF+g8h9waAXPBhb4LjLS4W6Tg3sm/3y++1
   tDd6J5he+MaCiDzN3uoEv1LLQJOC3rXPq5vzf2eeFmvL/5l8NZmmYF8jf
   xNpLbIXQwDMW36h5u7dpZj8YHcJpP9giyHzPtY9Lj9aUsnN+iyKp6oL/X
   cv2wBekxoGV6CYWVW8w32JMLV6fpCOXSOPvz1VgXpD7V2e5iduE+fgpz4
   odE+dmRqe5z36C+deQvqfWhMiFok1zkb8D6u0yQ8iVQbcc5KLn6k2unpJ
   tzbn8/OXO8JuxxD0EzZCsQdwdOvNKlxx/HN5t9MDIR0L5a6jLQBT2gBwD
   Q==;
X-CSE-ConnectionGUID: L/DxX8JSQHij4NE0zq28Bg==
X-CSE-MsgGUID: Lc93J1fOS4azqVO/5LjXvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="112911324"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="112911324"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 17:36:13 -0700
X-CSE-ConnectionGUID: asGnTZ1zQOWgblt09WcbZQ==
X-CSE-MsgGUID: ZQxrs+FRSwWUbK+0WihHdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="269751916"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 15 Aug 2026 17:36:11 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvOrA-000000006WL-2DF1;
	Sun, 16 Aug 2026 00:36:08 +0000
Date: Sun, 16 Aug 2026 02:35:51 +0200
From: kernel test robot <lkp@intel.com>
To: zhang.enpei@zte.com.cn, chessman@tux.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ethernet: tlan: Convert to use jiffies macro
Message-ID: <202608160257.LKzb3DiV-lkp@intel.com>
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
[also build test WARNING on net/main linus/master v7.2-rc7 next-20260721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhang-enpei-zte-com-cn/ethernet-tlan-Convert-to-use-jiffies-macro/20260813-185229
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250827155455583-PdvmDYA9SD3J37_XRza5%40zte.com.cn
patch subject: [PATCH v3] ethernet: tlan: Convert to use jiffies macro
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260816/202608160257.LKzb3DiV-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260816/202608160257.LKzb3DiV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608160257.LKzb3DiV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/ti/tlan.c:1833:8: warning: comparison of distinct pointer types ('unsigned long *' and 'typeof (priv->timer_set_at + (250 / 10)) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
    1833 |                         if (time_is_before_eq_jiffies(priv->timer_set_at + TLAN_TIMER_ACT_DELAY)) {
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jiffies.h:288:38: note: expanded from macro 'time_is_before_eq_jiffies'
     288 | #define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/jiffies.h:145:3: note: expanded from macro 'time_after_eq'
     145 |          typecheck(unsigned long, b) && \
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/typecheck.h:12:18: note: expanded from macro 'typecheck'
      12 |         (void)(&__dummy == &__dummy2); \
         |                ~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/ti/tlan.c:2057:7: warning: variable 'def_tx' set but not used [-Wunused-but-set-variable]
    2057 |         u32             def_tx, crc, code;
         |                         ^
   2 warnings generated.


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
