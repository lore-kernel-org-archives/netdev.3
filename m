Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792882450;
	b=SEYoxFPd4fAjmHQWlQnubP/LDxTlVWY9xqilViPWGyLSiGSGpKvpByVnogj623VUkJWN
	 sEBtX99KFDAFssNGBEHpbTfmn3ziRyx4ZP2vEdngkBD4NqpmxBLJBAE3B2U6d4Jj9mTEe
	 D0lEzaCyPSxJYGwXpPSoDdyqu93DfkF17k0bap39JUb2ECPhxSBXqTFnPLFNFQr4rDroq
	 vlOjWwWtaQz4iOv1UQSiVNfEty8PY4Qm9XHTvlmjYOHccb5vxMbkRCqhpjPhbiZ9SplRn
	 JpFUvW2Uvl97ZPAevcMtfaz+vkRFZED2+Px5aR6heuKkrkZBE8YOYCD0quthCgJJH6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792882450;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=W5BmndRmXZf5paZEukCObDUSI6tPr4czSuuuAPLFJm4=;
	b=C2xpSzdu+wnIosYGwiRBVONtBjKDOirxA/VS+6zd61cn2BI6t6UuJ372S2wHxjz8QAV2
	 /k0g24tc1uy6AhPOs9Pp4F3vXcX+wfim5Tpij6znjh0nb3ndeD9o/vSh1g/cm4ZhV+78G
	 huihBrk+rZi7XcEBxs+ORBfnN+Lg8aZwDRfuTo2JRyDf5vbkpH5F7UMmLyccUDyg4QAmq
	 8M350n8d8kNNHD4y6fVlhNss5Xsx1F05ZK3wbv38yt5lf7ciKfrZjW8cafPHV1AlqauMO
	 Ln6RP8rtMqVOuaQS01DEXX4Ec7+VGXT5QxGwrmk3rRANrMUDWzGHxXJ1eiFx6Pn6vMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4ZUHgKF;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8E606A31B;
	Sat, 24 Oct 2026 22:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC8E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4ZUHgKF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792882448; x=1824418448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I5OTWW9H2zxpLPefryyEieTL8dxF73wzUNnQxSoxb0Y=;
  b=k4ZUHgKFCr/oQNqNCV5fz/fRsBo5jW3RNo5JUOLsbKUYLcadWK6rIz4h
   EfnicqWY07zFziT7ZmCwdjk13zb/qP1D9b7oU7Z90ER7Zx9416gomvjTL
   iNeS4wybWXE2/HJhfPtON2dJ8B00PFg6Q9We3RwOOWzDfRLepmVR6DEDF
   H6ENfOD3PAwcXoiw1t9v2xjbLW+L/bE4cBlJf55pYH0a91yEi8io+bi3R
   Nxk/hbvZOQ4ym/DXbx4p6iEb6j6zh/1HsuOOl3+RADXfhgsB7l2IG4bO7
   c7XzDUmm8dOg2ULbukYbo5xEBXY+/gMTMs+c4yiuOwXLOTP/XLZjNMMZL
   w==;
X-CSE-ConnectionGUID: N4tbitHjT8GbPq8IlWLHyA==
X-CSE-MsgGUID: Lfy4VMznRQm+8o8GznY/bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11945"; a="1491600"
X-IronPort-AV: E=Sophos;i="6.27,177,1787036400"; 
   d="scan'208";a="1491600"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 15:54:07 -0700
X-CSE-ConnectionGUID: IdSSXPtMQuyILjx2JLe3dA==
X-CSE-MsgGUID: sAXXqd71RauxGo+BPWOntw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,177,1787036400"; 
   d="scan'208";a="3871068"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2026 15:54:05 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKkck-00000000UJi-08t3;
	Sat, 24 Oct 2026 22:54:02 +0000
Date: Sun, 25 Oct 2026 06:53:45 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: motorcomm: Isolate all ports during chip
 setup
Message-ID: <202610250645.V7tGJ85r-lkp@intel.com>
References: <20261024144023.1010237-1-mmyangfl@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024144023.1010237-1-mmyangfl@gmail.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/net-dsa-motorcomm-Isolate-all-ports-during-chip-setup/20261024-224021
base:   net/main
patch link:    https://lore.kernel.org/r/20261024144023.1010237-1-mmyangfl%40gmail.com
patch subject: [PATCH net] net: dsa: motorcomm: Isolate all ports during chip setup
config: arm64-randconfig-1000-20261025 (https://download.01.org/0day-ci/archive/20261025/202610250645.V7tGJ85r-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261025/202610250645.V7tGJ85r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610250645.V7tGJ85r-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/motorcomm/chip.c: In function 'yt921x_chip_setup_dsa':
>> drivers/net/dsa/motorcomm/chip.c:2262:6: warning: unused variable 'port' [-Wunused-variable]
     int port;
         ^~~~
>> drivers/net/dsa/motorcomm/chip.c:2259:16: warning: unused variable 'cpu_ports_mask' [-Wunused-variable]
     unsigned long cpu_ports_mask;
                   ^~~~~~~~~~~~~~


vim +/port +2262 drivers/net/dsa/motorcomm/chip.c

186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2255  
95e6bcab3c08e8 drivers/net/dsa/yt921x.c         David Yang 2026-01-31  2256  static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2257  {
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2258  	struct dsa_switch *ds = &priv->ds;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17 @2259  	unsigned long cpu_ports_mask;
9f8888984eb095 drivers/net/dsa/yt921x.c         David Yang 2026-04-30  2260  	u32 ctrls[2];
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2261  	u32 ctrl;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17 @2262  	int port;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2263  	int res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2264  
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2265  	/* Enable DSA */
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2266  	priv->cpu_ports_mask = dsa_cpu_ports(ds);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2267  
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2268  	ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2269  	       YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2270  	res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2271  	if (res)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2272  		return res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2273  
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2274  	/* Setup software switch */
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2275  	ctrl = YT921X_CPU_COPY_TO_EXT_CPU;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2276  	res = yt921x_reg_write(priv, YT921X_CPU_COPY, ctrl);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2277  	if (res)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2278  		return res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2279  
47373f4f561962 drivers/net/dsa/motorcomm/chip.c David Yang 2026-10-24  2280  	ctrl = GENMASK(10, 0) & ~priv->cpu_ports_mask;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2281  	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2282  	if (res)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2283  		return res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2284  	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2285  	if (res)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2286  		return res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2287  
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2288  	/* YT921x does not support native DSA port bridging, so we use port
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2289  	 * isolation to emulate it. However, be especially careful that port
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2290  	 * isolation takes _after_ FDB lookups, i.e. if an FDB entry (from
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2291  	 * another bridge) is matched and the destination port (in another
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2292  	 * bridge) is blocked, the packet will be dropped instead of flooding to
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2293  	 * the "bridged" ports, thus we need to trap and handle those packets by
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2294  	 * software.
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2295  	 *
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2296  	 * If there is no more than one bridge, we might be able to drop them
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2297  	 * directly given some conditions are met, but we trap them in all cases
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2298  	 * for now.
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2299  	 */
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2300  	ctrl = 0;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2301  	for (int i = 0; i < YT921X_PORT_NUM; i++)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2302  		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2303  	res = yt921x_reg_write(priv, YT921X_ACT_UNK_UCAST, ctrl);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2304  	if (res)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2305  		return res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2306  	res = yt921x_reg_write(priv, YT921X_ACT_UNK_MCAST, ctrl);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2307  	if (res)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2308  		return res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2309  
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2310  	/* Tagged VID 0 should be treated as untagged, which confuses the
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2311  	 * hardware a lot
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2312  	 */
9f8888984eb095 drivers/net/dsa/yt921x.c         David Yang 2026-04-30  2313  	ctrls[0] = YT921X_VLAN_CTRLa_LEARN_DIS | YT921X_VLAN_CTRLa_PORTS_M;
9f8888984eb095 drivers/net/dsa/yt921x.c         David Yang 2026-04-30  2314  	ctrls[1] = 0;
9f8888984eb095 drivers/net/dsa/yt921x.c         David Yang 2026-04-30  2315  	res = yt921x_reg64_write(priv, YT921X_VLANn_CTRL(0), ctrls);
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2316  	if (res)
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2317  		return res;
186623f4aa724c drivers/net/dsa/yt921x.c         David Yang 2025-10-17  2318  
95e6bcab3c08e8 drivers/net/dsa/yt921x.c         David Yang 2026-01-31  2319  	return 0;
95e6bcab3c08e8 drivers/net/dsa/yt921x.c         David Yang 2026-01-31  2320  }
95e6bcab3c08e8 drivers/net/dsa/yt921x.c         David Yang 2026-01-31  2321  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
