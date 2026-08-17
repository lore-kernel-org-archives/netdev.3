Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687F27AC57
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786930488; cv=none; b=TotoTg4eNVx/yihOkkrkhg5i9mWyWbQjzE06I5Yz4R9J6iWgh7VeqWeWgqsK/sdhntkQFdqD+AfvX2KPU/vdalXz2Kvoan/7imC99mEXk+Yo6YXiGaR5GpBJhL5G4jb62Ux7WaNyid/BeWtV8z/5e0l3d1Pu+0Y8+NcfZVMOx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786930488; c=relaxed/simple;
	bh=A62aL3mw75GYdaOmTKZuH0VFd+8F6dPcShduBmS3Wfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SE2pW+yiqfkrHmNBRVS9ut1D08Yg+J4C/L7zIwUkjPIDmBWfZShvOkKrG7F4omfv/FHQLXqkeazw1ZfhmgxgN4octL2y+R1CL8aLTZN/clr6f/Jeprs88gwg61hRHS1WfXFwtqdrKFsCB4XWG9D5WVlue67dqVusTl00AOpH8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JU9MNvhv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU9MNvhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786930483; x=1818466483;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A62aL3mw75GYdaOmTKZuH0VFd+8F6dPcShduBmS3Wfo=;
  b=JU9MNvhve336OJnoo1EpAV1Xs7eDoSXou3VoniXOScetfhKBCoHYLMPD
   WomNuevpNdH6zyU3PPUrZRhPUHhAdbe0qrgO6Ej2iAC2DWnozDY1OS+Gv
   +4HYFfWPaaHPEpJ6HIXIWXmIm2B17QMEd4WXNGs+csmJGPiCdBF4BZIBb
   +IQgxBHqA6UsDjlPKBFuOcWMDT4NOVn64v3xG0dBY1egQdAakEHyY0I0m
   +1mkdoAxqrWGMVGXTyenF94p7/n8d+KTeRJoCj5rIYh7DZbdunSz+53Ck
   B4l8Iqlytm0DJKxolDb5hwByLrePONzd8ZjA6oarYYRAGRg/a8UL+iosE
   A==;
X-CSE-ConnectionGUID: 38s3WewCTtieyrUTd4UEeg==
X-CSE-MsgGUID: JJOqNRFRSxGwVreZFkAm2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="97746099"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="97746099"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 18:34:42 -0700
X-CSE-ConnectionGUID: MN9HEZBUQvKhuCGAbqlHEA==
X-CSE-MsgGUID: f1KBJUkeS/ikHlFoRDlprg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="258559026"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2026 18:34:39 -0700
Date: Mon, 17 Aug 2026 09:34:36 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, netdev@vger.kernel.org,
	ltp@lists.linux.it, yi1.lai@intel.com
Subject: [linux-next:master] [tun/tap & vhost]  d00c7369ef: ltp.ioctl03.fail
Message-ID: <202608170325.fbd7c808-lkp@intel.com>
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

kernel test robot noticed "ltp.ioctl03.fail" on:

commit: d00c7369ef24ac8e0383de0fd8ef3384de20bcfa ("tun/tap & vhost-net: stop tail-drop when IFF_BACKPRESSURE is set") https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 4477a78374a57c3809b172ad30cceabda48c47c6]

in testcase: ltp
version: ltp-x86_64-0ad79e6fa-1_20260808 with following parameters:

	disk: 1SSD
	fs: btrfs
	test: syscalls-03



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608170325.fbd7c808-lkp@intel.com


PATH=/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/lkp/lkp/src/bin
2026-08-15 11:23:05 cd /lkp/benchmarks/ltp '/lib/modules/7.2.0-rc6+/build' -> '/usr/src/linux-modbuild-x86_64-rhel-9.4-ltp-d00c7369ef24ac8e0383de0fd8ef3384de20bcfa'
2026-08-15 11:23:05 make -j8 -C /lib/modules/7.2.0-rc6+/build M=/lkp/benchmarks/ltp/testcases/kernel/syscalls/delete_module KCFLAGS=-Wno-implicit-function-declaration -Wno-int-conversion
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-ltp-d00c7369ef24ac8e0383de0fd8ef3384de20bcfa'
make[1]: Entering directory '/opt/rootfs/tmp/keep-initrd/lkp/benchmarks/ltp/testcases/kernel/syscalls/delete_module'
warning: the compiler differs from the one used to build the kernel
  The kernel was built by: gcc-14 (Debian 14.2.0-19) 14.2.0
  You are using:           gcc (Debian 14.2.0-19) 14.2.0
warning: pahole version differs from the one used to build the kernel
  The kernel was built with: 131
  You are using:             130
  CC [M]  dummy_del_mod.o
  CC [M]  dummy_del_mod_dep.o
dummy_del_mod.c:20:5: warning: no previous prototype for ‘dummy_func_test’ [-Wmissing-prototypes]
   20 | int dummy_func_test(void)
      |     ^~~~~~~~~~~~~~~
  MODPOST Module.symvers
WARNING: modpost: missing MODULE_DESCRIPTION() in dummy_del_mod.o
WARNING: modpost: missing MODULE_DESCRIPTION() in dummy_del_mod_dep.o
  CC [M]  dummy_del_mod.mod.o
  CC [M]  .module-common.o
  CC [M]  dummy_del_mod_dep.mod.o
  LD [M]  dummy_del_mod.ko
  LD [M]  dummy_del_mod_dep.ko
make[1]: Leaving directory '/opt/rootfs/tmp/keep-initrd/lkp/benchmarks/ltp/testcases/kernel/syscalls/delete_module'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-ltp-d00c7369ef24ac8e0383de0fd8ef3384de20bcfa'
2026-08-15 11:23:07 make -j8 -C /lib/modules/7.2.0-rc6+/build M=/lkp/benchmarks/ltp/testcases/kernel/syscalls/finit_module KCFLAGS=-Wno-implicit-function-declaration -Wno-int-conversion
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-ltp-d00c7369ef24ac8e0383de0fd8ef3384de20bcfa'
make[1]: Entering directory '/opt/rootfs/tmp/keep-initrd/lkp/benchmarks/ltp/testcases/kernel/syscalls/finit_module'
warning: the compiler differs from the one used to build the kernel
  The kernel was built by: gcc-14 (Debian 14.2.0-19) 14.2.0
  You are using:           gcc (Debian 14.2.0-19) 14.2.0
warning: pahole version differs from the one used to build the kernel
  The kernel was built with: 131
  You are using:             130
  CC [M]  finit_module.o
  MODPOST Module.symvers
WARNING: modpost: missing MODULE_DESCRIPTION() in finit_module.o
  CC [M]  finit_module.mod.o
  CC [M]  .module-common.o
  LD [M]  finit_module.ko
make[1]: Leaving directory '/opt/rootfs/tmp/keep-initrd/lkp/benchmarks/ltp/testcases/kernel/syscalls/finit_module'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-ltp-d00c7369ef24ac8e0383de0fd8ef3384de20bcfa'
2026-08-15 11:23:08 make -j8 -C /lib/modules/7.2.0-rc6+/build M=/lkp/benchmarks/ltp/testcases/kernel/syscalls/init_module KCFLAGS=-Wno-implicit-function-declaration -Wno-int-conversion
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-ltp-d00c7369ef24ac8e0383de0fd8ef3384de20bcfa'
make[1]: Entering directory '/opt/rootfs/tmp/keep-initrd/lkp/benchmarks/ltp/testcases/kernel/syscalls/init_module'
warning: the compiler differs from the one used to build the kernel
  The kernel was built by: gcc-14 (Debian 14.2.0-19) 14.2.0
  You are using:           gcc (Debian 14.2.0-19) 14.2.0
warning: pahole version differs from the one used to build the kernel
  The kernel was built with: 131
  You are using:             130
  CC [M]  init_module.o
  MODPOST Module.symvers
WARNING: modpost: missing MODULE_DESCRIPTION() in init_module.o
  CC [M]  init_module.mod.o
  CC [M]  .module-common.o
  LD [M]  init_module.ko
make[1]: Leaving directory '/opt/rootfs/tmp/keep-initrd/lkp/benchmarks/ltp/testcases/kernel/syscalls/init_module'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-ltp-d00c7369ef24ac8e0383de0fd8ef3384de20bcfa'
2026-08-15 11:23:10 export LTP_RUNTIME_MUL=2
2026-08-15 11:23:10 export LTPROOT=/lkp/benchmarks/ltp
2026-08-15 11:23:10 kirk -f syscalls-03 --tmp-dir /fs/nvme0n1p4/tmpdir Host information
	Hostname:   igk-skl-d01
	Python:     3.13.5 (main, Jun 13 2026, 14:18:01) [GCC 14.2.0]
	Directory:  /fs/nvme0n1p4/tmpdir/kirk.root/tmpy0gzbkzk

Connecting to SUT: default

Suite: syscalls-03
──────────────────
 [1;37maccept03:  [0m [1;32mpass [0m  (0.033s)
 [1;37madd_key01:  [0m [1;32mpass [0m  (0.014s)
 [1;37malarm07:  [0m [1;32mpass [0m  (3.013s)
 [1;37march_prctl01:  [0m [1;32mpass [0m  (0.010s)
 [1;37mbpf_map01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mbpf_prog02:  [0m [1;32mpass [0m  (0.011s)
 [1;37mbrk02:  [0m [1;32mpass [0m  (0.012s)
 [1;37mcapget02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mcapset03:  [0m [1;32mpass [0m  (0.010s)
 [1;37mchmod08:  [0m [1;32mpass [0m  (0.011s)
 [1;37mchown02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mchown04:  [0m [1;32mpass [0m  (0.011s)
 [1;37mclock_nanosleep04:  [0m [1;32mpass [0m  (0.051s)
 [1;37mclone304:  [0m [1;32mpass [0m  (0.025s)
 [1;37mclose02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mcreat03:  [0m [1;32mpass [0m  (0.010s)
 [1;37mcreat05:  [0m [1;32mpass [0m  (0.071s)
 [1;37mcreat09:  [0m [1;32mpass [0m  (1.522s)
 [1;37mepoll_ctl03:  [0m [1;32mpass [0m  (0.011s)
 [1;37mepoll_ctl05:  [0m [1;32mpass [0m  (0.010s)
 [1;37mepoll_ctl06:  [0m [1;32mpass [0m  (0.019s)
 [1;37mepoll_wait04:  [0m [1;32mpass [0m  (0.012s)
 [1;37mepoll_wait16:  [0m [1;32mpass [0m  (0.014s)
 [1;37meventfd01:  [0m [1;32mpass [0m  (0.015s)
 [1;37meventfd06:  [0m [1;32mpass [0m  (0.039s)
 [1;37mexecve02:  [0m [1;32mpass [0m  (0.016s)
 [1;37mexecveat03:  [0m [1;32mpass [0m  (0.346s)
 [1;37mexit_group01:  [0m [1;32mpass [0m  (0.112s)
 [1;37mfaccessat202:  [0m [1;32mpass [0m  (0.011s)
 [1;37mfallocate01:  [0m [1;32mpass [0m  (0.004s)
 [1;37mfallocate02:  [0m [1;32mpass [0m  (0.004s)
 [1;37mfallocate04:  [0m [1;36mskip [0m  (11.895s)
 [1;37mposix_fadvise03_64:  [0m [1;32mpass [0m  (0.010s)
 [1;37mposix_fadvise04:  [0m [1;32mpass [0m  (0.010s)
 [1;37mfchmodat02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mfchmodat2_02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mfchown01_16:  [0m [1;36mskip [0m  (0.011s)
 [1;37mfchown02_16:  [0m [1;36mskip [0m  (0.011s)
 [1;37mfcntl02:  [0m [1;32mpass [0m  (0.011s)
 [1;37mfcntl03_64:  [0m [1;32mpass [0m  (0.012s)
 [1;37mfcntl04:  [0m [1;32mpass [0m  (0.011s)
 [1;37mfcntl08:  [0m [1;32mpass [0m  (0.011s)
 [1;37mfcntl13:  [0m [1;32mpass [0m  (0.010s)
 [1;37mfcntl15:  [0m [1;32mpass [0m  (0.014s)
 [1;37mfcntl17_64:  [0m [1;32mpass [0m  (0.007s)
 [1;37mfcntl19:  [0m [1;32mpass [0m  (0.005s)
 [1;37mfcntl20:  [0m [1;32mpass [0m  (0.005s)
 [1;37mfcntl20_64:  [0m [1;32mpass [0m  (0.005s)
 [1;37mfcntl26:  [0m [1;36mskip [0m  (0.003s)
 [1;37mfcntl31:  [0m [1;32mpass [0m  (0.008s)
 [1;37mfcntl34_64:  [0m [1;32mpass [0m  (0.079s)
 [1;37mfcntl37:  [0m [1;32mpass [0m  (0.010s)
 [1;37mfcntl40:  [0m [1;32mpass [0m  (0.010s)
 [1;37mfgetxattr01:  [0m [1;36mskip [0m  (11.913s)
 [1;37mfgetxattr02:  [0m [1;32mpass [0m  (0.014s)
 [1;37mfork03:  [0m [1;32mpass [0m  (0.012s)
 [1;37mfork14:  [0m [1;32mpass [0m  (5.028s)
 [1;37mfpathconf01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mgetegid02:  [0m [1;32mpass [0m  (0.011s)
 [1;37mgethostbyname_r01:  [0m [1;32mpass [0m  (0.010s)
 [1;37mgetpgid01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mgetppid01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mgetpriority01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mgetresgid01:  [0m [1;32mpass [0m  (0.005s)
 [1;37mgetresgid01_16:  [0m [1;36mskip [0m  (0.003s)
 [1;37mgetresgid02:  [0m [1;32mpass [0m  (0.003s)
 [1;37mgetresuid01_16:  [0m [1;36mskip [0m  (0.004s)
 [1;37mgetrusage03:  [0m [1;32mpass [0m  (0.208s)
 [1;37mgetsockopt01:  [0m [1;32mpass [0m  (0.010s)
 [1;37mgetuid03:  [0m [1;32mpass [0m  (0.010s)
 [1;37mioctl03:  [0m [1;31mfail [0m  (0.022s)
 [1;37mioctl05:  [0m [1;32mpass [0m  (0.330s)
 [1;37mioctl09:  [0m [1;32mpass [0m  (0.342s)
 [1;37mioctl_loop04:  [0m [1;32mpass [0m  (0.126s)
 [1;37mioctl_ns07:  [0m [1;32mpass [0m  (0.010s)
 [1;37minotify02:  [0m [1;32mpass [0m  (0.014s)
 [1;37minotify05:  [0m [1;32mpass [0m  (0.227s)
 [1;37mfanotify04:  [0m [1;32mpass [0m  (0.014s)
 [1;37mfanotify13:  [0m [1;36mskip [0m  (58.703s)
 [1;37mio_getevents02:  [0m [1;32mpass [0m  (0.015s)
 [1;37mkeyctl01:  [0m [1;32mpass [0m  (0.010s)
 [1;37mkeyctl09:  [0m [1;32mpass [0m  (0.017s)
 [1;37mkcmp02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mkcmp03:  [0m [1;32mpass [0m  (0.014s)
 [1;37mlandlock09:  [0m [1;36mskip [0m  (0.013s)
 [1;37mlistmount03:  [0m [1;32mpass [0m  (0.012s)
 [1;37mllistxattr03:  [0m [1;32mpass [0m  (0.012s)
 [1;37mlremovexattr01:  [0m [1;36mskip [0m  (11.847s)
 [1;37mlseek01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mlseek07:  [0m [1;32mpass [0m  (0.011s)
 [1;37mlsm_get_self_attr03:  [0m [1;36mskip [0m  (0.011s)
 [1;37mlstat03_64:  [0m [1;32mpass [0m  (1.809s)
 [1;37mmallinfo02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mmallopt01:  [0m [1;32mpass [0m  (0.012s)
 [1;37mmlockall02:  [0m [1;32mpass [0m  (0.003s)
 [1;37mmkdir02:  [0m [1;32mpass [0m  (0.011s)
 [1;37mmkdir04:  [0m [1;32mpass [0m  (0.011s)
 [1;37mmknodat01:  [0m [1;32mpass [0m  (0.003s)
 [1;37mmlock02:  [0m [1;32mpass [0m  (0.011s)
 [1;37mmlock04:  [0m [1;32mpass [0m  (0.015s)
 [1;37mmmap04:  [0m [1;32mpass [0m  (0.012s)
 [1;37mmmap05:  [0m [1;32mpass [0m  (0.011s)
 [1;37mmmap12:  [0m [1;32mpass [0m  (0.018s)
 [1;37mmmap13:  [0m [1;32mpass [0m  (0.010s)
 [1;37mmmap21_01:  [0m [1;32mpass [0m  (0.012s)
 [1;37mmprotect04:  [0m [1;32mpass [0m  (0.004s)
 [1;37mmremap05:  [0m [1;32mpass [0m  (0.003s)
 [1;37mmsgctl03:  [0m [1;32mpass [0m  (0.012s)
 [1;37mmsgrcv06:  [0m [1;32mpass [0m  (0.015s)
 [1;37mmsync02:  [0m [1;32mpass [0m  (0.003s)
 [1;37mmsync04:  [0m [1;32mpass [0m  (11.660s)
 [1;37mmunmap04:  [0m [1;32mpass [0m  (2.015s)
 [1;37mnice01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mmadvise10:  [0m [1;32mpass [0m  (0.016s)
 [1;37mpause01:  [0m [1;32mpass [0m  (0.019s)
 [1;37mpersonality01:  [0m [1;32mpass [0m  (0.031s)
 [1;37mpipe01:  [0m [1;32mpass [0m  (0.010s)
 [1;37mpoll01:  [0m [1;32mpass [0m  (0.010s)
 [1;37mpreadv202_64:  [0m [1;32mpass [0m  (0.012s)
 [1;37mprocess_vm_writev02:  [0m [1;32mpass [0m  (0.013s)
 [1;37mpselect03:  [0m [1;32mpass [0m  (0.010s)
 [1;37mptrace07:  [0m [1;32mpass [0m  (0.804s)
 [1;37mquotactl07:  [0m [1;32mpass [0m  (0.388s)
 [1;37mrealpath01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mrecvmsg03:  [0m [1;36mskip [0m  (0.016s)
 [1;37mrename03:  [0m [1;32mpass [0m  (11.830s)
 [1;37mrename11:  [0m [1;32mpass [0m  (0.300s)
 [1;37mrequest_key04:  [0m [1;32mpass [0m  (0.010s)
 [1;37msched_get_priority_min02:  [0m [1;32mpass [0m  (0.011s)
 [1;37msched_getparam03:  [0m [1;32mpass [0m  (0.013s)
 [1;37msched_setparam05:  [0m [1;32mpass [0m  (0.015s)
 [1;37msched_setscheduler01:  [0m [1;32mpass [0m  (0.011s)
 [1;37mselect04:  [0m [1;36mskip [0m  (0.104s)
 [1;37msemctl02:  [0m [1;32mpass [0m  (0.010s)
 [1;37msemop01:  [0m [1;32mpass [0m  (0.013s)
 [1;37msendfile05_64:  [0m [1;32mpass [0m  (0.011s)
 [1;37msendfile06:  [0m [1;32mpass [0m  (0.011s)
 [1;37msendmmsg02:  [0m [1;32mpass [0m  (0.013s)
 [1;37msendto01:  [0m [1;32mpass [0m  (0.004s)
 [1;37msetdomainname03:  [0m [1;32mpass [0m  (0.012s)
 [1;37msetfsuid03:  [0m [1;32mpass [0m  (0.012s)
 [1;37msetgid01:  [0m [1;32mpass [0m  (0.010s)
 [1;37msetegid01:  [0m [1;32mpass [0m  (0.010s)
 [1;37msetgroups01:  [0m [1;32mpass [0m  (0.010s)
 [1;37msetgroups02:  [0m [1;32mpass [0m  (0.010s)
 [1;37msethostname02:  [0m [1;32mpass [0m  (0.012s)
 [1;37msetpgid02:  [0m [1;32mpass [0m  (0.011s)
 [1;37msetregid03:  [0m [1;32mpass [0m  (0.012s)
 [1;37msetresgid01_16:  [0m [1;36mskip [0m  (0.010s)
 [1;37msetresuid01_16:  [0m [1;36mskip [0m  (0.011s)
 [1;37msetreuid05:  [0m [1;32mpass [0m  (0.013s)
 [1;37msetrlimit03:  [0m [1;32mpass [0m  (0.011s)
 [1;37msetrlimit05:  [0m [1;32mpass [0m  (0.011s)
 [1;37msetrlimit06:  [0m [1;32mpass [0m  (4.023s)
 [1;37msetsockopt04:  [0m [1;32mpass [0m  (0.011s)
 [1;37msetuid03_16:  [0m [1;36mskip [0m  (0.011s)
 [1;37mshmctl03:  [0m [1;32mpass [0m  (0.011s)
 [1;37mshmget06:  [0m [1;32mpass [0m  (0.017s)
 [1;37msignal06:  [0m [1;32mpass [0m  (2.174s)
 [1;37msigtimedwait01:  [0m [1;32mpass [0m  (1.321s)
 [1;37msigwait01:  [0m [1;32mpass [0m  (0.114s)
 [1;37msocket01:  [0m [1;32mpass [0m  (0.046s)
 [1;37msplice07:  [0m [1;32mpass [0m  (0.053s)
 [1;37mstat01:  [0m [1;32mpass [0m  (0.012s)
 [1;37mstatfs03_64:  [0m [1;32mpass [0m  (0.012s)
 [1;37mtgkill03:  [0m [1;32mpass [0m  (0.012s)
 [1;37mtimerfd02:  [0m [1;32mpass [0m  (0.010s)
 [1;37mtimer_create02:  [0m [1;32mpass [0m  (0.016s)
 [1;37mtruncate02_64:  [0m [1;32mpass [0m  (0.010s)
 [1;37munlink10:  [0m [1;32mpass [0m  (0.011s)
 [1;37munshare01:  [0m [1;32mpass [0m  (0.014s)
 [1;37mumount02:  [0m [1;32mpass [0m  (0.311s)
 [1;37muserfaultfd02:  [0m [1;32mpass [0m  (0.011s)
 [1;37muserfaultfd06:  [0m [1;32mpass [0m  (0.012s)
 [1;37mutime06:  [0m [1;32mpass [0m  (0.012s)
 [1;37mwait401:  [0m [1;32mpass [0m  (0.011s)
 [1;37mwaitpid10:  [0m [1;32mpass [0m  (2.016s)
 [1;37mwaitid05:  [0m [1;32mpass [0m  (0.012s)
 [1;37mwritev06:  [0m [1;32mpass [0m  (0.003s)
 [1;37mperf_event_open01:  [0m [1;32mpass [0m  (0.126s)
 [1;37mfutex_cmp_requeue03:  [0m [1;32mpass [0m  (0.010s)
 [1;37mfutex_wait05:  [0m [1;32mpass [0m  (8.352s)
 [1;37mfutex_waitv02:  [0m [1;32mpass [0m  (0.012s)
 [1;37mfutex_wake03:  [0m [1;32mpass [0m  (0.040s)
 [1;37mmemfd_create03:  [0m [1;32mpass [0m  (4.609s)
 [1;37mcopy_file_range01:  [0m [1;36mskip [0m  (23.943s)

Execution time: 3m 9s

Disconnecting from SUT: default

Target information
──────────────────
Kernel:   Linux 7.2.0-rc6+ #1 SMP PREEMPT_DYNAMIC Sat Aug 15 12:50:15 CEST 2026
Cmdline:  ip=10.211.93.100::10.211.93.1:255.255.255.0:igk-skl-d01::static
          root=/dev/ram0
          RESULT_ROOT=/result/ltp/1SSD-btrfs-syscalls-03/igk-skl-d01/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/d00c7369ef24ac8e0383de0fd8ef3384de20bcfa/0
          BOOT_IMAGE=/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/d00c7369ef24ac8e0383de0fd8ef3384de20bcfa/vmlinuz-7.2.0-rc6+
          branch=internal-devel/devel-hourly-20260814-060637
          job=/lkp/jobs/scheduled/igk-skl-d01/ltp-1SSD-btrfs-syscalls-03-debian-13-x86_64-20250902.cgz-d00c7369ef24-20260815-81720-qgtq63-0.yaml
          user=lkp
          ARCH=x86_64
          kconfig=x86_64-rhel-9.4-ltp
          commit=d00c7369ef24ac8e0383de0fd8ef3384de20bcfa
          intremap=posted_msi
          acpi_rsdp=0xa79ea000
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
          acpi_rsdp=0xa79ea000
Machine:  unknown
Arch:     x86_64
RAM:      13907268 kB
Swap:     0 kB
Distro:   debian 13

────────────────────────
      TEST SUMMARY
────────────────────────
Suite:   syscalls-03
Runtime: 3m 4s
Runs:    186

Results:
    Passed:   2174
    Failed:   1
    Broken:   0
    Skipped:  222
    Warnings: 0

 [1;31mFailures: [0m
    • ioctl03

Session stopped
/tmp/kirk.root/latest is not found



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260817/202608170325.fbd7c808-lkp@intel.com



--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


