Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D037F33C;
	Sat, 15 Aug 2026 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786834453; cv=none; b=CGAIK3grMLLVK69CmuqGF1QbmAf2RyYJMCwq7Gcizt0aIaNjpi+X27Ptg9N/wLa0XFh6+dvI3UkfODC/jWSNC0T+b1DZphrjSBHACJilo6et6Y6OXbDOEdI2cNQ4thlPnnQWwXdtsg9AXuDbZvUueCP62mY8HBYSJQBU4vIMLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786834453; c=relaxed/simple;
	bh=46MagpPgc7+72ubN2uRXXArgdMJ8e1WdukG4842XJA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siKeH0Mwb2nSmjxugoOyj3OcexmN5kfT5z/GDg0FV+SmBw0g8L85ygwAjwH4Q0GXbjbKUj9X/Y66OdSzaAzBUgpcVlf7m62Gm4AQegcDmlzLS1FzmuBYin87V/uS7tRGbyfIhM9pPiox6wHZHvTUQk5hbQ7tSivmmrQLJYHwjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yk5Tm/oe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yk5Tm/oe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786834451; x=1818370451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=46MagpPgc7+72ubN2uRXXArgdMJ8e1WdukG4842XJA0=;
  b=Yk5Tm/oeiiiAnDkKLS8kF63bIVsC/aJleykR7+kNwndvOtxx3eJgteCr
   XOB3lDfqjGjVNCxb/zdWWye5Nyk9lknHFVN/vIXJ/TKYpaE+gJSpncxCV
   nYoL73SgrFqfbY1F7UoIJ/rw6kndAHsvQjIc8q+tYmv4CJOO3XXRtFm4H
   /3uXcg1HTzFtotr2pquvi6SbPAS/3GUxpk31UcwFCpDbddNHSiACvEWIh
   kz8gZ7eYDuTfARsNN3YOGqxHEITiY+VCAbAUltduZJrVGy67HbtT7qgUZ
   4iP7CJf3jBKYRYdHiDQwpSjWNl9VL3pVQuBIkaq9b9rNGdSbEKkJ5mQS4
   g==;
X-CSE-ConnectionGUID: GjHLQIhFQkWvcbiPl/txDg==
X-CSE-MsgGUID: hrAJ0I6xT/eO0nCcl6nVvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="89882233"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="89882233"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 15:54:10 -0700
X-CSE-ConnectionGUID: zLC6DnfFSC6gmqXW0eAt4g==
X-CSE-MsgGUID: BBgyLqU8SrGLrwta3FT9Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="269740300"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 15 Aug 2026 15:54:07 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvNGP-000000006Un-39Za;
	Sat, 15 Aug 2026 22:54:05 +0000
Date: Sun, 16 Aug 2026 00:53:21 +0200
From: kernel test robot <lkp@intel.com>
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Message-ID: <202608160048.0KcqzO98-lkp@intel.com>
References: <20260723143908.4019-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143908.4019-1-maimon.sagi@gmail.com>

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/ptp-ocp-add-CPLD-ISP-support-for-ADVA-TimeCard-X1/20260813-075719
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260723143908.4019-1-maimon.sagi%40gmail.com
patch subject: [PATCH v6] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260816/202608160048.0KcqzO98-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608160048.0KcqzO98-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
   WARNING: /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
   Documentation/ABI/testing/sysfs-timecard:14: ERROR: Unexpected indentation. [docutils]
>> Documentation/ABI/testing/sysfs-timecard:14: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/ABI/testing/sysfs-timecard:14: ERROR: Unexpected indentation. [docutils]
   WARNING: ./block/blk-map.c:366 Excess function parameter 'op' description in 'bio_copy_kern'
   Documentation/driver-api/basics:42: ./kernel/time/time.c:370: WARNING: Duplicate C declaration, also defined at driver-api/basics:436.
   Declaration is '.. c:function:: unsigned int jiffies_to_msecs (const unsigned long j)'. [duplicate_declaration.c]
   Documentation/driver-api/basics:42: ./kernel/time/time.c:393: WARNING: Duplicate C declaration, also defined at driver-api/basics:453.


vim +14 Documentation/ABI/testing/sysfs-timecard

  > 14	What:		/sys/class/timecard/ocpN/cpld_i2c_xfer
    15	Date:		July 2026
    16	Contact:	Sagi Maimon <sagi.maimon@adva.com>
    17	Description:	(RW) Binary sysfs attribute providing a raw I2C passthrough to
    18			the CPLD and I2C mux on ADVA x1 TAP boards.  Only present on
    19			that board variant.
    20	
    21			Each write initiates one I2C transaction.  The write payload
    22			must be exactly four header bytes followed by the write data:
    23	
    24			  Byte 0: slave address (only 0x40 and 0x74 are permitted)
    25			  Byte 1: number of bytes to write (0..67)
    26			  Byte 2: number of bytes to read back (0..20)
    27			  Byte 3: flags
    28			            bit 0 - suppress the repeated START before the
    29			                    read segment (I2C_M_NOSTART); only valid
    30			                    when both write and read lengths are
    31			                    non-zero
    32			  Bytes 4..: write data (write_len bytes)
    33	
    34			A subsequent read() returns:
    35	
    36			  Byte 0: status (0 = success, positive errno on error)
    37			  Bytes 1..: read data (read_len bytes), present only when
    38			             status is 0 and read_len > 0
    39	
    40			The write and read portions of the sysfs file share a single
    41			per-device response buffer protected by a mutex; a single
    42			open() / write() / read() sequence must be used to avoid
    43			data races between concurrent users.
    44	
    45			Only slave addresses 0x40 (Lattice CPLD) and 0x74 (PCA9548
    46			I2C mux) are accepted; all others return EPERM.
    47	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
