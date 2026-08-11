Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23825358387;
	Tue, 11 Aug 2026 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444681; cv=none; b=otgLPdTV2f0c+QvUdPYBMJ2C14OEA4TEiQoKf+ZGUa+woC+FxISGKLm9ou+cUKxuu3cKo8iXsNGsLSYIWQ4mJr+U0vfd8q3lgwhJUxCYVjnWzuar3LD58gwxQ2ALdIwJMOABT2f+UCcESseBYbdd0TW1ddTaDDM9sJXJAWowaT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444681; c=relaxed/simple;
	bh=zfyx7i/6iWrgpAX12hKTJqYnXFJPiCqXydJpgUthu2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnXlw7SpZydNwKS29CE4T4vvb5njtozdmM6BYbtiHTSRKGQh1Q3DQC8sxYdJ8CF9QmWzYuFBzAZouUIBRy+UDdIN6NgWues+e/fFZitsMsy09ncZhR5b/rIxDkUmM7FXQiU3iBdNPn4o5GjaDOaAmPJgxIfpU50PzepTP9fGqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzNKufLO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzNKufLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786444679; x=1817980679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zfyx7i/6iWrgpAX12hKTJqYnXFJPiCqXydJpgUthu2s=;
  b=RzNKufLOS+6tVkfaLM3lsM2KRlg3SJTm5m2RfJzUB6oCSs+jgA9iBwKe
   wdPDPeZSHWFGnbADchg/tgavF3UkGewrt+GdZhxnX7UBovCesoy99kA6b
   IzDswDWaL+7T9D/1CGqSH7arX62lVgLzJTaMDPVH9pE+lnpU6/L7Eewkv
   8H79NeVeptNid04Y0o0OP/2ue/0GYbgcVtObkjfjEGvrcO3NsNAB6Zse+
   29DmOe9xISqAUzh4aobddeneat9PUaUlxkJBwqjCfkFwJ4CM7yVqEAjMl
   8Gx0ytWVBCBD5mEcQk1CCHCe7FqVBwPuSFXHRAtMYIC3rfqGvoXynGZt7
   g==;
X-CSE-ConnectionGUID: EdIpu4QjT8abW7Y96CzqTg==
X-CSE-MsgGUID: jpHJAu1cQhe1qSUURlqkIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="109761318"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="109761318"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:37:58 -0700
X-CSE-ConnectionGUID: OQC+Q5nsQzKwxrwp/4Sn4Q==
X-CSE-MsgGUID: f/6fwpzcQ7GM6CbzmwFDwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="293244378"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Aug 2026 03:37:57 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wtjrm-00000000OZO-0OFn;
	Tue, 11 Aug 2026 10:37:54 +0000
Date: Tue, 11 Aug 2026 18:36:39 +0800
From: kernel test robot <lkp@intel.com>
To: Colin Foster <colin.foster@in-advantage.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Colin Foster <colin.foster@in-advantage.com>
Subject: Re: [PATCH v1] smsc911x: add second read of EEPROM mac when possible
 corruption seen
Message-ID: <202608111832.kjA1WwgS-lkp@intel.com>
References: <20250828214452.11683-1-colin.foster@in-advantage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828214452.11683-1-colin.foster@in-advantage.com>

Hi Colin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on horms-ipvs/master]
[cannot apply to linus/master v7.2-rc7 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Foster/smsc911x-add-second-read-of-EEPROM-mac-when-possible-corruption-seen/20260810-123819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
patch link:    https://lore.kernel.org/r/20250828214452.11683-1-colin.foster%40in-advantage.com
patch subject: [PATCH v1] smsc911x: add second read of EEPROM mac when possible corruption seen
config: hexagon-randconfig-001-20260811 (https://download.01.org/0day-ci/archive/20260811/202608111832.kjA1WwgS-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260811/202608111832.kjA1WwgS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608111832.kjA1WwgS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/smsc/smsc911x.c:25:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/smsc/smsc911x.c:25:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/smsc/smsc911x.c:25:
   In file included from include/linux/etherdevice.h:20:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/net/ethernet/smsc/smsc911x.c:2179:5: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
    2179 |         u8 addr[ETH_ALEN];
         |            ^
   7 warnings generated.


vim +2179 drivers/net/ethernet/smsc/smsc911x.c

631b7568c7d8f02 drivers/net/smsc911x.c               Steve Glendinning 2008-12-25  2160  
31f4574774e98aa drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2161  /* copies the current mac address from hardware to dev->dev_addr */
8489ec1f9700649 drivers/net/ethernet/smsc/smsc911x.c Bill Pemberton    2012-12-03  2162  static void smsc911x_read_mac_address(struct net_device *dev)
31f4574774e98aa drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2163  {
31f4574774e98aa drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2164  	struct smsc911x_data *pdata = netdev_priv(dev);
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2165  	u32 mac_high16, mac_low32;
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2166  
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2167  	mac_high16 = smsc911x_mac_read(pdata, ADDRH);
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2168  	mac_low32 = smsc911x_mac_read(pdata, ADDRL);
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2169  
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2170  	/*
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2171  	 * The first mac_read always returns 0. Re-read it to get the
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2172  	 * full MAC
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2173  	 */
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2174  	if (mac_high16 == 0) {
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2175  		SMSC_TRACE(pdata, probe, "Re-read MAC ADDRH\n");
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2176  		mac_high16 = smsc911x_mac_read(pdata, ADDRH);
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2177  	}
8b1e595e2e78004 drivers/net/ethernet/smsc/smsc911x.c Colin Foster      2025-08-28  2178  
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18 @2179  	u8 addr[ETH_ALEN];
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2180  
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2181  	addr[0] = (u8)(mac_low32);
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2182  	addr[1] = (u8)(mac_low32 >> 8);
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2183  	addr[2] = (u8)(mac_low32 >> 16);
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2184  	addr[3] = (u8)(mac_low32 >> 24);
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2185  	addr[4] = (u8)(mac_high16);
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2186  	addr[5] = (u8)(mac_high16 >> 8);
f15fef4c0675d41 drivers/net/ethernet/smsc/smsc911x.c Jakub Kicinski    2021-10-18  2187  	eth_hw_addr_set(dev, addr);
31f4574774e98aa drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2188  }
31f4574774e98aa drivers/net/smsc911x.c               Steve Glendinning 2009-01-27  2189  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
