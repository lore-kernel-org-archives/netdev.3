Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAA480DDA;
	Sun,  4 Oct 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791144757; cv=none; b=bKfsSZWsvggdRyNFdauGQMGBdSDlg5JZ9RmsHhy3eEHwWbLByi9V0z3lTDpguFxGk3f9VckC5gThh45phtBu4GwrFZ6UPyiVJfNF8+2UeQy5fz3wlDf+nuxkVFdG/6R2WK+js2plGNnv+Ofd1W09+9C5MyN7VIA5MlenILuDLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791144757; c=relaxed/simple;
	bh=6i3i7WsSNX6ARj4QoJw0wpV9iavfas580CAV2v7AKKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmlyVL3PmcohwljyX6OvJjGy5dcbZR49+6gOJt4NfqUCFB6N1KqonhoASFNgGL13EZFu6d8sEWRROmTf3+NdZ+Ad73uSRg3g3RT0V03rwl4pP8U2/cJqP6OeU8HZ3dPA6uDb+KlNp3+7GZA6PY6RGmnGz7JSGlOPILUJbSBweck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep8BLexM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep8BLexM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791144756; x=1822680756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6i3i7WsSNX6ARj4QoJw0wpV9iavfas580CAV2v7AKKY=;
  b=Ep8BLexMG0MLTFZAikPnrJYuErrJXXAKB0M85z7kyLGGz5wdoor2njc7
   QxCCxRb/qTVMImuIpZ5YYBvLmmww2AmMTQrsShZUuEBNtbuveZXAUFwnY
   XT5+w4lD9Smys48ZeLYY/pjYtJO1H0cJnF/B16XjVmR1hpqGdOb6IwEbe
   4D+vV1LOPyXXl6VQf20K0aQHg3bGy0z3mc5FCofdS4X6oJe0Wh2AiUyCj
   sMgrjy2ud0lObiTb8F7E3KTi1CZXNp6gkI9BIdP21VDqoBN4H/IeLOCaO
   /8QAK8ODl7SYDEa2vXWjerVKVLyPyia1Wv773dMx3alAf9HB+ezCOMadI
   g==;
X-CSE-ConnectionGUID: G2PN/LHmSJChbc2i2PCjMw==
X-CSE-MsgGUID: oPgHj6edSz25pqKmZfCXjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="94697104"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="94697104"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 13:12:36 -0700
X-CSE-ConnectionGUID: DRFD465VTQu+1j2b7Swpcg==
X-CSE-MsgGUID: 5q0Xphp/S2ionY8l3AbMXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="304614437"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Oct 2026 13:12:31 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDSZQ-00000000V2X-2RJA;
	Sun, 04 Oct 2026 20:12:28 +0000
Date: Mon, 5 Oct 2026 04:12:13 +0800
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
Message-ID: <202610050430.ZlYvvYse-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 071876fd50482a68603a9460d80dd6dd58827ee1]

url:    https://github.com/intel-lab-lkp/linux/commits/Birger-Koblitz/phylink-Add-phylink_mac_interrupt/20261004-073905
base:   071876fd50482a68603a9460d80dd6dd58827ee1
patch link:    https://lore.kernel.org/r/20261004-ax88179a-v16-4-2a9ae4e68f7b%40birger-koblitz.de
patch subject: [PATCH net-next v16 04/13] ax88179_178a: Add HW support for AX179A-based chips
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261005/202610050430.ZlYvvYse-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 5f609f950d2e80addf5566623013db68394334db)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261005/202610050430.ZlYvvYse-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610050430.ZlYvvYse-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/usb/ax88179a_devices.c:694:2: error: incompatible integer to pointer conversion passing 'u64' (aka 'unsigned long long') to parameter of type '__u64 *' (aka 'unsigned long long *'); take the address with & [-Wint-conversion]
     694 |         le64_to_cpus(rx_hdr);
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:111:22: note: expanded from macro 'le64_to_cpus'
     111 | #define le64_to_cpus __le64_to_cpus
         |                      ^
   include/uapi/linux/byteorder/big_endian.h:94:37: note: expanded from macro '__le64_to_cpus'
      94 | #define __le64_to_cpus(x) __swab64s((x))
         |                                     ^~~
   include/uapi/linux/swab.h:265:46: note: passing argument to parameter 'p' here
     265 | static __always_inline void __swab64s(__u64 *p)
         |                                              ^
   1 error generated.


vim +694 drivers/net/usb/ax88179a_devices.c

   655	
   656	static int ax88179a_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
   657	{
   658		struct ax88179_data *ax179_data = dev->driver_priv;
   659		struct sk_buff *ax_skb;
   660		u32 hdr_off, pkt_end;
   661		u64 *pkt_desc_ptr;
   662		u16 vlan_tag;
   663		u16 pkt_cnt;
   664		u64 rx_hdr;
   665	
   666		/* SKB contents for AX179A-based chips:
   667		 *   <packet 1>
   668		 *   ...
   669		 *   <packet N>
   670		 *   <per-packet metadata entry 1>
   671		 *   ...
   672		 *   <per-packet metadata entry N>
   673		 *   <rx_hdr>
   674		 *
   675		 * where:
   676		 *   <packet N> contains pkt_len data bytes and padding:
   677		 *		2 bytes of IP alignment (optional, depends on AX_RX_CTL_IPE flag)
   678		 *		packet data received
   679		 *		optional padding to 8-bytes boundary
   680		 *   <per-packet metadata entry N> contains 8 bytes:
   681		 *		pkt_len and fields AX_RXHDR_*
   682		 *   <rx-hdr>	contains 8 bytes:
   683		 *		pkt_cnt and hdr_off (offset of <per-packet metadata entry 1>)
   684		 *
   685		 * pkt_cnt is number of entries in the per-packet metadata array.
   686		 */
   687	
   688		if (!skb || skb->len < sizeof(rx_hdr))
   689			goto err;
   690	
   691		/* RX Descriptor Header */
   692		skb_trim(skb, skb->len - sizeof(rx_hdr));
   693		rx_hdr = *(u64 *)skb_tail_pointer(skb);
 > 694		le64_to_cpus(rx_hdr);
   695	
   696		/* Check these packets */
   697		hdr_off = FIELD_GET(AX179A_RX_DH_DESC_OFFSET, rx_hdr);
   698		pkt_cnt = rx_hdr & AX179A_RX_DH_PKT_CNT_MASK;
   699	
   700		/* Consistency check header position */
   701		if (hdr_off != skb->len - (pkt_cnt * sizeof(rx_hdr)))
   702			goto err;
   703	
   704		/* Make sure that the bounds of the metadata array are inside the SKB
   705		 * (and in front of the counter at the end).
   706		 */
   707		if (pkt_cnt * 8 + hdr_off > skb->len)
   708			goto err;
   709	
   710		/* Packets must not overlap the metadata array */
   711		skb_trim(skb, hdr_off);
   712	
   713		if (!pkt_cnt)
   714			goto err;
   715	
   716		/* Get the first RX packet descriptor */
   717		pkt_desc_ptr = (u64 *)(skb->data + hdr_off);
   718	
   719		pkt_end = 0;
   720		while (pkt_cnt--) {
   721			u64 pkt_desc = le64_to_cpu(*pkt_desc_ptr);
   722			u32 pkt_len_plus_padd;
   723			u32 pkt_len;
   724	
   725			pkt_len = FIELD_GET(AX179A_RX_PD_LEN, pkt_desc);
   726			pkt_len -= (ax179_data->ip_align ? 2 : 0);
   727			pkt_len_plus_padd = ((pkt_len + 7 + (ax179_data->ip_align ? 2 : 0)) & 0x7FFF8);
   728	
   729			pkt_end += pkt_len_plus_padd;
   730			if (pkt_end > hdr_off || (pkt_cnt == 0 && pkt_end != hdr_off))
   731				goto err;
   732	
   733			if (pkt_desc & AX179A_RX_PD_DROP || !(pkt_desc & AX179A_RX_PD_RX_OK) ||
   734			    pkt_len > (dev->hard_mtu + AX179A_RX_HW_PAD) || pkt_len < 2 + ETH_HLEN) {
   735				skb_pull(skb, pkt_len_plus_padd);
   736	
   737				/* Next RX Packet Descriptor */
   738				pkt_desc_ptr++;
   739				continue;
   740			}
   741	
   742			ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
   743			if (!ax_skb)
   744				goto err;
   745	
   746			skb_put(ax_skb, pkt_len);
   747			memcpy(ax_skb->data, skb->data + (ax179_data->ip_align ? AX179A_RX_HW_PAD : 0),
   748			       pkt_len);
   749	
   750			if (ax179_data->rx_checksum)
   751				ax88179a_rx_checksum(ax_skb, pkt_desc);
   752	
   753			if (pkt_desc & AX179A_RX_PD_VLAN) {
   754				vlan_tag = pkt_desc >> AX179A_RX_PD_VLAN_SHIFT;
   755				__vlan_hwaccel_put_tag(ax_skb, htons(ETH_P_8021Q), vlan_tag);
   756			}
   757	
   758			usbnet_skb_return(dev, ax_skb);
   759			skb_pull(skb, pkt_len_plus_padd);
   760	
   761			/* Next RX Packet Header */
   762			pkt_desc_ptr++;
   763		}
   764	
   765		return 1;
   766	
   767	err:
   768		return 0;
   769	}
   770	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
