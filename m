Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462669;
	b=xN+4dDLf0G0zcPOa5CICn2o2LhabZVqjqx/0IEpCz9A06FE9gER/1zUbJJtRoM2k0RP8
	 UveI8jMGgD7OmI0NJru8B4VG2GzjEiLu1GizZ+ItCs7gUBIDXd7NUNok69V9pNf+tkyXK
	 fiCddDyBm0A+i4pSUpnGLE7MdgXzaKrasn9maObpbNnOW+k0pSTqlpcq9x7ECqtHKndNy
	 FMh9vvwOdWtZtfgUQYMz4QohbCN1vGvDf6Xx6e8xfWWiocPDqGiDhViWSjZ99d2tvwlOQ
	 hdsMyq+3HAXsCEazQFPzEpFGwRMXAJwsYI+xxWXsvPdfrgdt/OTGRultqMe7B7bdTQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462669;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9JTgDpDDwMXEKUT4yd6AOrd7DzQF1sh+HtTOxj0mdTc=;
	b=36FyVacEhYaOSxQ+Y49uuv7nS4zuGhlu3IrHhvGu59CP5C8DUfytv3p4OhkA3vYrp7sz
	 R2Rnn6R3AG5MSQ56zwo6Ln6/pwGNpbrw7LF44Kri+kam9pP/YaS8paloG0DUf2XiczfRR
	 KlivF1dwOf0GmlavLOP42IqOYN5H/A3gi3qTY6qpdTGb2nwS7JPVdfqLtG+gcTkVcXdCC
	 N9GXjEOL/JAyM5aHj2DBseSDddGd3o5SRkWBHud8eB5C9Vv5wxo2h84AkiABmTrbkzlFI
	 YmB9vGWbCCVIR89gzDGaNDPRbuxzRXFwxzfRKuSRNUldkDerH8c8+YUquTbM5CmeJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W1A9vmgR;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE6606A31A;
	Tue, 20 Oct 2026 02:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DE6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W1A9vmgR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792462669; x=1823998669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oGm1k1Fx6NgBJcx5I2zgIIB14FL1PA/x50knBnXj7kc=;
  b=W1A9vmgRkHq42CKk4zz2op9kY7WWZrjvbdwNpspSYTox5Mw/YQHoiMgM
   bSP8sbJxyfBpZTMb1XgvaMWEkeYgOc3kLFyueJx0QaCzNpnvzK/vf/Wqc
   YoPOewUaNhc7NvI1XwiP34LkURLrH5na0xb2zq6jAEocW0e0vSpsXCLZX
   awma6BhrWXDMN3zAW1Xx+AygvOJpyGUIqY6KJT9/ftlg59Xik9Vr+YL1A
   iKvZgRoONits/3vdizCHu4xQHIX/oRFFl2uxWT6WJoL72aOdZDcMb5ffz
   LQSiNRcaDjJSC7bmjAWwEiqlXPC7kGRpTeN+BQ+F5ihmoDc21KtmvfXvS
   Q==;
X-CSE-ConnectionGUID: dzEReZ4TR7SUVThSXPI0uQ==
X-CSE-MsgGUID: +Ei5Uwz5SHWROYcNO38dUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1162285"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1162285"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 19:17:48 -0700
X-CSE-ConnectionGUID: f/pxMlMvSTKi/qRoZOOMkQ==
X-CSE-MsgGUID: VKslVvdaRkyzj1W+tnmR6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2704000"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 Oct 2026 19:17:42 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIzQ3-00000000Ml8-28S5;
	Tue, 20 Oct 2026 02:17:39 +0000
Date: Tue, 20 Oct 2026 10:17:37 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Switch <kyle.switch@motor-comm.com>, andrew@lunn.ch,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v15 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
Message-ID: <202610200942.aPmEAZ8C-lkp@intel.com>
References: <20261019110543.2999419-6-kyle.switch@motor-comm.com>
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
In-Reply-To: <20261019110543.2999419-6-kyle.switch@motor-comm.com>

Hi Kyle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Switch/net-dsa-motorcomm-initialize-dsa_switch-based-on-chipid/20261019-190539
base:   net-next/main
patch link:    https://lore.kernel.org/r/20261019110543.2999419-6-kyle.switch%40motor-comm.com
patch subject: [PATCH net-next v15 5/5] net: dsa: motorcomm: Add support for Motorcomm YT922x
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20261020/202610200942.aPmEAZ8C-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 6719b9e31d6a93099612c474eec76d9f41d0275a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261020/202610200942.aPmEAZ8C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610200942.aPmEAZ8C-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/motorcomm/chip.c:2755:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    2755 |         default:
         |         ^
   drivers/net/dsa/motorcomm/chip.c:2755:2: note: insert '__attribute__((fallthrough));' to silence this warning
    2755 |         default:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/net/dsa/motorcomm/chip.c:2755:2: note: insert 'break;' to avoid fall-through
    2755 |         default:
         |         ^
         |         break; 
   1 warning generated.


vim +2755 drivers/net/dsa/motorcomm/chip.c

  2730	
  2731	static int
  2732	yt922x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
  2733			   phy_interface_t interface)
  2734	{
  2735		struct device *dev = yt921x_priv_to_device(priv);
  2736		const struct yt921x_info *info = priv->info;
  2737		struct yt921x_port *pp = &priv->ports[port];
  2738	
  2739		if (BIT(port) & info->internal_mask) {
  2740			if (interface != PHY_INTERFACE_MODE_INTERNAL)
  2741				goto err;
  2742			return 0;
  2743		}
  2744	
  2745		switch (interface) {
  2746		/* SERDES */
  2747		case PHY_INTERFACE_MODE_SGMII:
  2748		case PHY_INTERFACE_MODE_100BASEX:
  2749		case PHY_INTERFACE_MODE_1000BASEX:
  2750		case PHY_INTERFACE_MODE_2500BASEX:
  2751		case PHY_INTERFACE_MODE_USXGMII:
  2752			if (!(BIT(port) & info->serdes_mask))
  2753				goto err;
  2754			pp->serdes = true;
> 2755		default:
  2756			goto err;
  2757		}
  2758	
  2759		return 0;
  2760	
  2761	err:
  2762		dev_err(dev, "Wrong mode %d on port %d\n", interface, port);
  2763		return -EINVAL;
  2764	}
  2765	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
