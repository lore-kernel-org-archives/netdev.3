Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851530FF30;
	Wed, 12 Aug 2026 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517664; cv=none; b=WLsPbN6t199kyshfwvOkZ2PMXa3Ymx6a3y2F1el8kssLClLZxS0PUQd+4ibViGZRIbW+0rSALORVOSaIH76Gb9K2fS8kyJsxsldPx3zkfLN+GcAoYrByNxjdxpJs1i7UxlfHRuVrTBlkxe7LxSTVFdvZFIsO3aVEnzhr0k6zGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517664; c=relaxed/simple;
	bh=Br+1iMHv61cnlmrwgJ8dZq/Cn/0HAW5MTceMDf0ZnT8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B8gD/1vDE7B+JHjCgW1OETCHf16IzHhh1ZFYKZcWpMghP2KMlWl2wuVzcm+p0ncvfMT4hWiNVvR4jOueVNm54dIog9e7XLYdqJwezx53ypmxbo6ObDc7mC1UB7r0nsQllEcmBItgbVukE9BDWMxRatIz+9vantu3l7icfMdQ9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EO52YzCv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EO52YzCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786517663; x=1818053663;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Br+1iMHv61cnlmrwgJ8dZq/Cn/0HAW5MTceMDf0ZnT8=;
  b=EO52YzCvQlKj7b85KJtZPF5YUABeDVyIWOr47SFp/GPacC4AHIeBFyJL
   SjcAO8w5wGbyBhEUTDogdwPfTY+ecs6/4xmHcJnY6wcUr9MeZKYNcNJdO
   k7+vRTbexRERJXf4ZhBRn1lTR4lXEFz0f4y/APTkIKBR4yGVPMxfZ7aHY
   HuIMXklhgLTIxfgYCXKylx11eSsitiWbhAgvgSEGwR2M84wBQJhBMHy/2
   /yErJ9oRVhwGnGIEBkgfr8DCjZsK6tzC1Vh6dw0deMSXV3nh1tJ93yw2x
   rDULH+TGs8UBRxsCdXMvfyORxwZBAh79rftsLIie3ctr11f35/UxSFp8E
   Q==;
X-CSE-ConnectionGUID: RgYgVCpJSKSWHJzf1MrXMg==
X-CSE-MsgGUID: vX9TD5wvRaWcfBxcx1pHfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87073593"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87073593"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 23:54:22 -0700
X-CSE-ConnectionGUID: feR7ym9vQRGdV++SySbjvw==
X-CSE-MsgGUID: svgbhTWYTQaAa5OeR6b3EQ==
X-ExtLoop1: 1
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 23:54:19 -0700
Date: Wed, 12 Aug 2026 14:54:16 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Shahar Shitrit <shshitrit@nvidia.com>, netdev@vger.kernel.org,
	ltp@lists.linux.it, yi1.lai@intel.com
Subject: [linus:master] [net]  8e63c9e617: ltp.uevent02.fail
Message-ID: <202608120846.30e0fb5b-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed "ltp.uevent02.fail" on:

commit: 8e63c9e6179ace3033dcd19991f95386e9d3130f ("net: Defer netdev KOBJ_ADD uevent until the device is published") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      06cf61899d6498b33e4b7c87d99d5bd471ccc375]
[test failed on linux-next/master 6b8c8af514d739d0335f5579b585e02babe8a727]

in testcase: ltp
version: 
with following parameters:

	test: uevent



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608120846.30e0fb5b-lkp@intel.com


PATH=/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/lkp/lkp/src/bin
2026-08-09 01:07:36 cd /lkp/benchmarks/ltp
2026-08-09 01:07:36 export LTP_RUNTIME_MUL=2
2026-08-09 01:07:36 export LTPROOT=/lkp/benchmarks/ltp
2026-08-09 01:07:36 kirk -f uevent
Host information
	Hostname:   igk-rpl-d01
	Python:     3.13.5 (main, Jun 13 2026, 14:18:01) [GCC 14.2.0]
	Directory:  /tmp/kirk.root/tmp53a0pl45

Connecting to SUT: default

Suite: uevent
─────────────
 [1;37muevent01:  [0m [1;32mpass [0m |  [1;33mtainted [0m  (0.137s)
 [1;37muevent02:  [0m [1;31mfail [0m |  [1;33mtainted [0m  (5.364s)
 [1;37muevent03:  [0m [1;32mpass [0m |  [1;33mtainted [0m  (0.035s)

Execution time: 5.592s

Disconnecting from SUT: default

Target information
──────────────────
Kernel:   Linux 7.2.0-rc5+ #1 SMP PREEMPT_DYNAMIC Sun Aug  9 02:47:33 CEST 2026
Cmdline:  ip=10.250.17.22::10.250.17.2:255.255.255.0:igk-rpl-d01::static
          root=/dev/ram0
          RESULT_ROOT=/result/ltp/uevent/igk-rpl-d01/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/8e63c9e6179ace3033dcd19991f95386e9d3130f/0
          BOOT_IMAGE=/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/8e63c9e6179ace3033dcd19991f95386e9d3130f/vmlinuz-7.2.0-rc5+
          branch=linux-devel/devel-hourly-20260807-211920
          job=/lkp/jobs/scheduled/igk-rpl-d01/ltp-uevent-debian-13-x86_64-20250902.cgz-8e63c9e6179a-20260809-232489-3exo8p-0.yaml
          user=lkp
          ARCH=x86_64
          kconfig=x86_64-rhel-9.4-ltp
          commit=8e63c9e6179ace3033dcd19991f95386e9d3130f
          intremap=posted_msi
          acpi_rsdp=0x3f88a014
          kho=off
          max_uptime=7200
          LKP_SERVER=internal-lkp-server
          nokaslr
          selinux=0
          debug
          apic=debug
          sysrq_always_enabled
          rcupdate.rcu_cpu_stall_timeout=100
          net.ifnames=0
          printk.devkmsg=on
          panic=-1
          softlockup_panic=1
          nmi_watchdog=panic
          oops=panic
          load_ramdisk=2
          prompt_ramdisk=0
          drbd.minor_count=8
          systemd.log_level=err
          ignore_loglevel
          console=tty0
          earlyprintk=ttyUSB0,115200
          console=ttyUSB0,115200
          vga=normal
          rw
          keep_initrds=/osimage/pkg/debian-13-x86_64-20250902.cgz/ltp-x86_64-0ad79e6fa-1_20260808.cgz
          acpi_rsdp=0x3f88a014
Machine:  unknown
Arch:     x86_64
RAM:      28236192 kB
Swap:     0 kB
Distro:   debian 13

────────────────────────
      TEST SUMMARY
────────────────────────
Suite:   uevent
Runtime: 5.536s
Runs:    3

Results:
    Passed:   9
    Failed:   1
    Broken:   0
    Skipped:  0
    Warnings: 0

 [1;31mFailures: [0m
    • uevent02

Session stopped
LTP test details
----------------
uevent02: uevent.h:173: TFAIL: Did not get all expected UEVENTS



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260812/202608120846.30e0fb5b-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

