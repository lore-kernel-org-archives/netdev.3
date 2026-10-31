Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793490877;
	b=sWND3ttHibqpKy4AMju8lnOE/ev1yuVD5++atR+cUms3InR7Zyz8xK2UlOoN/BNDG9+w
	 mE1VLXD7VoczL04fQJNd1hiVdWZyFLXBduVlmF3Bvtsw5zlLIMjZkaM2dLnDBnkkhmgWL
	 4tgBqVLSjM46nLoYjzR1cGOS4aiFEwS5KuOTJ2BY+8qeQLNQUwaGfFTeYoHBJ0FuWA/9X
	 E65Omlzzvy6756xY/yAYIOYW2bxR9XsLOSkoMIUHzg2FO/RZMn3BF1bqcIv7vU1d0E0+u
	 8KXKMaiHqMqZBymZzZsFoqg53g1mMZYkyyfqTlHproFVZuYlFORWz6PtqToie1Xgeag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793490877;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/O1QuS7+tRKjJCe36mLJ5Gs9QsE8OnsKMAzsZ8ju5JA=;
	b=jGBvnFmwEkVI04bQRcvCiILzC+P52mRWxN1ql//cNkFJ5DSwIk1eEmv/3/Jlx1v8i4jF
	 iBobuqk2Njke0qm3tesTLEIXP51T7xnFqIVkKi12OHiLOUqzJw6ZIpe0cwUBtdx+gK2Np
	 XDdTWdsEyQ/6cX6c/Ixl+mNxeocQwY/PIz1QQMJK0xOdYG5mew4Zx3vCs7tJi+H8jLnuB
	 dsrDzE8K6nHVtJ0No+m2IYQJIjA1YRgDpt/NlN5bMUlyryDGayAkX95j9yn2H4SqzYAFz
	 OJ0LkT9mPK19YBpapV0/l+VP39c+09CMgnEAx0xB/giBbL7tBuei9nGzuWw8HI4DDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eTom9iFn;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED0606A31A;
	Sat, 31 Oct 2026 23:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EED0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eTom9iFn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793490875; x=1825026875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=onCPx45jawKu9ge3zeP6P/yMp8qkq874YfzuNRUh1dE=;
  b=eTom9iFnz2ns+8WlvHLW97FS3h32Kz49d3YGXAlmGS10WvlgOm3fphZi
   y2R6umxjS3aL0j4Yfcr+4FVTzr5lXJ8EFpo/FyJzDvWuq5UMib48KZ2TR
   M0vC2PkdBdmAaZMWaZOQ/xana45ieNsk55rWElMDsY1pcOpnFbP0OPPXv
   h3uTug49/4CnqucSph33IWWaX6zH6B+cTH88suQxzJEH6tXlJeW9+tXFc
   OPCDlD42Fn/I+hpBdr3+COVFeBHvrCzwsCUMcSRT+T0OdywaT6d/+ZZmj
   Srd1Ek1tJ/AfTWYbqNgrlYd/GfmFW6jX3yyDY1Uj5Z3aFhT6jr66832P0
   g==;
X-CSE-ConnectionGUID: /FCaWxYKSMmeduEKc8Tdxw==
X-CSE-MsgGUID: fUhshoPWQSyixsMlsg+w5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2220647"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2220647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 16:54:34 -0700
X-CSE-ConnectionGUID: V2rALCjrSseDfEOys8L50Q==
X-CSE-MsgGUID: OZonhpcURWKtmmbCBaLWUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="6079165"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 31 Oct 2026 16:54:29 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNIu2-00000000dH6-35cm;
	Sat, 31 Oct 2026 23:54:26 +0000
Date: Sun, 1 Nov 2026 07:53:27 +0800
From: kernel test robot <lkp@intel.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	Taniya Das <taniya.das@oss.qualcomm.com>
Subject: Re: [PATCH v2 03/12] clk: qcom: Add a driver for PDM GP_MN
 fractional clock divider
Message-ID: <202611010752.aU8NDTD1-lkp@intel.com>
References: <20261026-b4-pdm_clk_gp_mnd_v2-v2-3-ff8e4bc8d567@oss.qualcomm.com>
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
In-Reply-To: <20261026-b4-pdm_clk_gp_mnd_v2-v2-3-ff8e4bc8d567@oss.qualcomm.com>

Hi Taniya,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4eb2586bd40db27d77cc5b724ca9386ed0c71d53]

url:    https://github.com/intel-lab-lkp/linux/commits/Taniya-Das/dt-bindings-clock-qcom-Add-bindings-for-PDM-GP_MN-clock-divider/20261026-165927
base:   4eb2586bd40db27d77cc5b724ca9386ed0c71d53
patch link:    https://lore.kernel.org/r/20261026-b4-pdm_clk_gp_mnd_v2-v2-3-ff8e4bc8d567%40oss.qualcomm.com
patch subject: [PATCH v2 03/12] clk: qcom: Add a driver for PDM GP_MN fractional clock divider
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20261101/202611010752.aU8NDTD1-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261101/202611010752.aU8NDTD1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611010752.aU8NDTD1-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/clk/qcom/clk-gp-mnd.ko: symbol '__udivdi3' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
