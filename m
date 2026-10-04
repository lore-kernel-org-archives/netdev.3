Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED247ECF9;
	Sun,  4 Oct 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791137196; cv=none; b=E7cHt6caCSBfw3574K2OjHx/6r0OrOKrHRjoXGxwMg/qXQqoELnpJvRA/FI76dmol4KbvzcdksFS690I0iBYWQbAKWmzWN2W/N7UYPjEahr302CPt+lyNxPGNWdUxQhcpLgFgYDjsMrIh8miz6bRTievDiLinredfQlu4H2KW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791137196; c=relaxed/simple;
	bh=txKpiZj/vFaH3TyDauuUkNKayFxBlAtwL6eqxCEGI40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZED/LPl1l8HGaeLpG1yU43rH4V+hOaeZS/xQBHgZyx3FNMSuN66nn7PbBY5oWRCeQdl24P6xvRDOkBnOsj0uV3ptI7piyFVYFGul429pDdbbdmfEWL/bNokvtpWaCuYzQGbfpBh0dtuNPBjGTIC5P45PFvKaSJNnCRqj+hM4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2WnkAn6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2WnkAn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791137192; x=1822673192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=txKpiZj/vFaH3TyDauuUkNKayFxBlAtwL6eqxCEGI40=;
  b=I2WnkAn6XqMjJeolRDWcDRqCl31o9p7dy0C+2S/L0QOgNoEaAPODrHJo
   p9pcZGwbz+z4Flbavdghs95tFk2fwFr6WSQlNEvuwa3HLsWSHlKLdJJ5y
   fM5piT3Q2jz6KVrZCKaXziMpiQDvnZ3eCi4eaY/rHvo09VdCVjnHTd2J0
   pFUaWFC+cjX3MSHYJaX/xFjp/QrD+sQdVZ1yV4Bm7+smsrl3qg6Oy7qaI
   fHDmrlrtUPgHbhVZ0r6ltqFrEBTpuAX6JjrfpsYObXSsQK6pq/uaZL8jH
   VX2XPVafUwD9GTM4ESv8Yx7WAep5Ecac5J5CpD4n8CJpjNFoCxLWU8eWq
   Q==;
X-CSE-ConnectionGUID: uvkgnXerT/iSGXIy3X69ig==
X-CSE-MsgGUID: TtUvMQ4gROSQON3uN5S4Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90851607"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="90851607"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 11:06:31 -0700
X-CSE-ConnectionGUID: F/pVaMaBTWKDdKfLZr7Mmg==
X-CSE-MsgGUID: umG+elnYTu2Tf+LBMwQPlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="304601979"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Oct 2026 11:06:26 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDQbP-00000000Uxh-2gjf;
	Sun, 04 Oct 2026 18:06:23 +0000
Date: Mon, 5 Oct 2026 02:06:14 +0800
From: kernel test robot <lkp@intel.com>
To: Birger Koblitz <mail@birger-koblitz.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Eric Dumazet <edumazet@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	Jianhui Xu <neuromoments@gmail.com>,
	Birger Koblitz <mail@birger-koblitz.de>
Subject: Re: [PATCH net-next v16 04/13] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <202610050104.tjRXtbIC-lkp@intel.com>
References: <20261004-ax88179a-v16-4-2a9ae4e68f7b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-ax88179a-v16-4-2a9ae4e68f7b@birger-koblitz.de>

Hi Birger,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 071876fd50482a68603a9460d80dd6dd58827ee1]

url:    https://github.com/intel-lab-lkp/linux/commits/Birger-Koblitz/phylink-Add-phylink_mac_interrupt/20261004-073905
base:   071876fd50482a68603a9460d80dd6dd58827ee1
patch link:    https://lore.kernel.org/r/20261004-ax88179a-v16-4-2a9ae4e68f7b%40birger-koblitz.de
patch subject: [PATCH net-next v16 04/13] ax88179_178a: Add HW support for AX179A-based chips
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261005/202610050104.tjRXtbIC-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 5f609f950d2e80addf5566623013db68394334db)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261005/202610050104.tjRXtbIC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610050104.tjRXtbIC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/usb/ax88179a_devices.c:783:24: warning: shift count >= width of type [-Wshift-count-overflow]
     783 |         tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
         |                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/ax88179_lib.h:251:29: note: expanded from macro 'AX179A_TX_DESC_MSS'
     251 | #define AX179A_TX_DESC_MSS              GENMASK(46, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:702:22: note: expanded from macro 'compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:690:23: note: expanded from macro '_compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:682:9: note: expanded from macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/usb/ax88179a_devices.c:783:24: warning: shift count >= width of type [-Wshift-count-overflow]
     783 |         tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
         |                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/ax88179_lib.h:251:29: note: expanded from macro 'AX179A_TX_DESC_MSS'
     251 | #define AX179A_TX_DESC_MSS              GENMASK(46, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:702:22: note: expanded from macro 'compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:690:23: note: expanded from macro '_compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:682:9: note: expanded from macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/usb/ax88179a_devices.c:783:24: warning: shift count >= width of type [-Wshift-count-overflow]
     783 |         tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
         |                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/ax88179_lib.h:251:29: note: expanded from macro 'AX179A_TX_DESC_MSS'
     251 | #define AX179A_TX_DESC_MSS              GENMASK(46, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:702:22: note: expanded from macro 'compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:690:23: note: expanded from macro '_compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:682:9: note: expanded from macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/usb/ax88179a_devices.c:783:24: warning: shift count >= width of type [-Wshift-count-overflow]
     783 |         tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
         |                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/ax88179_lib.h:251:29: note: expanded from macro 'AX179A_TX_DESC_MSS'
     251 | #define AX179A_TX_DESC_MSS              GENMASK(46, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:702:22: note: expanded from macro 'compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:690:23: note: expanded from macro '_compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:682:9: note: expanded from macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/usb/ax88179a_devices.c:783:24: warning: shift count >= width of type [-Wshift-count-overflow]
     783 |         tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
         |                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/ax88179_lib.h:251:29: note: expanded from macro 'AX179A_TX_DESC_MSS'
     251 | #define AX179A_TX_DESC_MSS              GENMASK(46, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:48:20: note: expanded from macro 'GENMASK_TYPE'
      48 |              (type_max(t) << (l) &                              \
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:702:22: note: expanded from macro 'compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:690:23: note: expanded from macro '_compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:682:9: note: expanded from macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> drivers/net/usb/ax88179a_devices.c:783:24: warning: shift count >= width of type [-Wshift-count-overflow]
     783 |         tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
         |                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/usb/ax88179_lib.h:251:29: note: expanded from macro 'AX179A_TX_DESC_MSS'
     251 | #define AX179A_TX_DESC_MSS              GENMASK(46, 32)
         |                                         ^
   include/linux/bits.h:51:24: note: expanded from macro 'GENMASK'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^
   include/linux/bits.h:49:20: note: expanded from macro 'GENMASK_TYPE'
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:702:22: note: expanded from macro 'compiletime_assert'
     702 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:690:23: note: expanded from macro '_compiletime_assert'
     690 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:682:9: note: expanded from macro '__compiletime_assert'
     682 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   6 warnings generated.


vim +783 drivers/net/usb/ax88179a_devices.c

   770	
   771	static struct sk_buff *ax88179a_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
   772	{
   773		u64 tx_desc = skb->len & AX179A_TX_DESC_LEN_MASK;
   774		int frame_size = dev->maxpacket;
   775		struct sk_buff *ax_skb;
   776		u64 *tx_desc_ptr;
   777		int padding_size;
   778		int headroom;
   779		int tailroom;
   780		u16 tci = 0;
   781	
   782		/* TSO MSS */
 > 783		tx_desc |= FIELD_PREP(AX179A_TX_DESC_MSS, (u64)skb_shinfo(skb)->gso_size);
   784	
   785		headroom = (skb->len + sizeof(tx_desc)) % 8;
   786		padding_size = headroom ? 8 - headroom : 0;
   787	
   788		if (((skb->len + sizeof(tx_desc) + padding_size) % frame_size) == 0) {
   789			padding_size += 8;
   790			tx_desc |= AX179A_TX_DESC_DROP_PADD;
   791		}
   792	
   793		if ((dev->net->features & NETIF_F_HW_VLAN_CTAG_TX) && (vlan_get_tag(skb, &tci) >= 0)) {
   794			tx_desc |= AX179A_TX_DESC_VLAN;
   795			tx_desc |= FIELD_PREP(AX179A_TX_DESC_VLAN_ID, (u64)tci);
   796		}
   797	
   798		if (!dev->can_dma_sg && (dev->net->features & NETIF_F_SG) && skb_linearize(skb)) {
   799			dev_kfree_skb_any(skb);
   800			return NULL;
   801		}
   802	
   803		headroom = skb_headroom(skb);
   804		tailroom = skb_tailroom(skb);
   805	
   806		if (!(headroom >= sizeof(tx_desc) && tailroom >= padding_size)) {
   807			ax_skb = skb_copy_expand(skb, sizeof(tx_desc), padding_size, flags);
   808			dev_kfree_skb_any(skb);
   809			skb = ax_skb;
   810			if (!skb)
   811				return NULL;
   812		}
   813		if (padding_size != 0)
   814			skb_put_zero(skb, padding_size);
   815		/* Copy TX header */
   816		tx_desc_ptr = skb_push(skb, sizeof(tx_desc));
   817		put_unaligned_le64(tx_desc, tx_desc_ptr);
   818	
   819		usbnet_set_skb_tx_stats(skb, 1, 0);
   820	
   821		return skb;
   822	}
   823	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
