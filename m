Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357531716D;
	Thu,  3 Sep 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444182; cv=none; b=oUIWWwx+apn6CB837F7/4c5GePGO0UhEONqbnM/X/l482jqCNwPakZ3yfBVjcnQt+eTfzquV0v9KKxGW6o5O0DoWvBY/AualCZfcJu8VAtJbFxWf3Vf7S8I/nwhCjMlpjKxm4InTAcv/e1KCB1S7nnYss+Qo+5/tfcMfIy0wjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444182; c=relaxed/simple;
	bh=hIcl5o7Ira9qzxp/5zL0DAYmfSYbKzPxXoCZUyyLSpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsLYIUafRq70zOiWYANKEbr3mnsVhDverl0O+49Kc3muasJ8Y7WyKfJL2RO7fIDTOEBF4RAEXbbOsZt2j0pR8U/FeQZMY3j9Roxlmlj+4u+I1tiFsZECaoQkzDSMSNeLnGzKwmrJvT/vYkYWjhdSdL2Bnuknf9iO3YB/io95COI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRKesSy/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRKesSy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788444175; x=1819980175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hIcl5o7Ira9qzxp/5zL0DAYmfSYbKzPxXoCZUyyLSpw=;
  b=kRKesSy/SA/eINPn7AIt579Q8DqUzkjehYwiZwmUtRbxbwr2wPAnVqTS
   fxNhM9JacVlHYnHozJ5FUlLaTuKFHgGmTJqAXURF81YBpy7SshgxOeaig
   62lQZHG76DMllMKK97GLyDaqQfocx4PzzlUrasB4x5hu2Ugq7bMUcb54m
   b2LOeEPTGc7aq2GvJmT11HP2VnqmzKNZy/YydvTzBeQfhRNH/ZBV3CBUC
   5VVbXmIW1iv1aLhiQ5YC+3gZ5cLxYUXBTmhhwj43GAnyT05b4SBeALnZt
   DrAsB1ViTZ1MYv9IvUNB/9HM6vh8/pj5JEWTDBH1zjl1RNswPIqfAJZIi
   A==;
X-CSE-ConnectionGUID: YpQBuSnXTbe6CoChSGsUvw==
X-CSE-MsgGUID: p6VvE/e0SkayK8ja0/eGpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88951185"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88951185"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 07:02:48 -0700
X-CSE-ConnectionGUID: UhWqvqaeSwSjNBIJklvgNg==
X-CSE-MsgGUID: F1ys3m5BRnK/OyVkga8VdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="299603472"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Sep 2026 07:02:45 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x281a-000000004tK-0tHD;
	Thu, 03 Sep 2026 14:02:42 +0000
Date: Thu, 3 Sep 2026 22:01:42 +0800
From: kernel test robot <lkp@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Elad Nachman <enachman@marvell.com>
Cc: oe-kbuild-all@lists.linux.dev, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: prestera: avoid overreading a short firmware tail
Message-ID: <202609032140.39rhcpus-lkp@intel.com>
References: <20260830142404.37663-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830142404.37663-1-pengpeng@iscas.ac.cn>

Hi Pengpeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72]

url:    https://github.com/intel-lab-lkp/linux/commits/Pengpeng-Hou/net-prestera-avoid-overreading-a-short-firmware-tail/20260830-222403
base:   08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
patch link:    https://lore.kernel.org/r/20260830142404.37663-1-pengpeng%40iscas.ac.cn
patch subject: [PATCH] net: prestera: avoid overreading a short firmware tail
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20260903/202609032140.39rhcpus-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260903/202609032140.39rhcpus-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609032140.39rhcpus-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/io.h:12,
                    from include/linux/iopoll.h:14,
                    from drivers/net/ethernet/marvell/prestera/prestera_pci.c:8:
   drivers/net/ethernet/marvell/prestera/prestera_pci.c: In function 'prestera_ldr_send':
>> drivers/net/ethernet/marvell/prestera/prestera_pci.c:603:32: error: implicit declaration of function 'get_unaligned'; did you mean 'get_cmdline'? [-Wimplicit-function-declaration]
     603 |                 writel_relaxed(get_unaligned((u32 *)(buf + i)),
         |                                ^~~~~~~~~~~~~
   arch/x86/include/asm/io.h:88:39: note: in definition of macro 'writel_relaxed'
      88 | #define writel_relaxed(v, a) __writel(v, a)
         |                                       ^


vim +603 drivers/net/ethernet/marvell/prestera/prestera_pci.c

   589	
   590	static int prestera_ldr_send(struct prestera_fw *fw, const u8 *buf, size_t len)
   591	{
   592		size_t write_len = ALIGN(len, sizeof(u32));
   593		size_t i;
   594		int err;
   595	
   596		err = prestera_ldr_wait_buf(fw, write_len);
   597		if (err) {
   598			dev_err(fw->dev.dev, "failed wait for sending firmware\n");
   599			return err;
   600		}
   601	
   602		for (i = 0; i + sizeof(u32) <= len; i += sizeof(u32)) {
 > 603			writel_relaxed(get_unaligned((u32 *)(buf + i)),
   604				       prestera_ldr_wr_ptr(fw));
   605			prestera_ldr_wr_idx_move(fw, 4);
   606		}
   607		if (i < len) {
   608			u32 last = 0;
   609	
   610			memcpy(&last, buf + i, len - i);
   611			writel_relaxed(last, prestera_ldr_wr_ptr(fw));
   612			prestera_ldr_wr_idx_move(fw, 4);
   613		}
   614	
   615		prestera_ldr_wr_idx_commit(fw);
   616		return 0;
   617	}
   618	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
