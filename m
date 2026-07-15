Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FF381EB1;
	Wed, 15 Jul 2026 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126173; cv=none; b=F+ky4aqEVnpTIJ7cT0FUawMOD7IHv+zTmEsAJ4U4Jm42iAaJiEPBUSCOP1fyQIBxE9dglFEiscapZMeEqjtv5afTteFJNma/+dZDNnB860m4J3xs7ilo0hEIlvWZPjcyozE7OQAgvYOFucmCLc/sp4X8TC4O+P/Y/xF1rgcE66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126173; c=relaxed/simple;
	bh=QtZDZDVONdUZUtMj/Oeqj3zOMKZGrQ3+llUPARk9BSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETlYxzdNuaNvY1EAy8hRcIR4Ai+Jb5+K03Nnw/bdz2wMbxjNK4X5X6m5CwXyXz7r8vQ4yRNy/9ZENXR60usuuvwoE8rxirZ4Ron8h6ZDeoCpxDId551VdqShiRZQMnJ1onrPAlEfp+FKN7KDaK2AaCOiOZugLxDQCQFUeFtG+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=A2Jl5qrr; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="A2Jl5qrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1784125948;
	bh=hKJ6Qg2LWg5gq7q/ZPC3JQm9ffFjxx+05nF4JeAwcqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A2Jl5qrrddCcR+p2mk1pHk/z/FT4JJL21XVrsZZ0UN/wRXMp6U0CsjKJnMc2gYKkP
	 esPVyRoLI+s4+rcMlQYe8RIPqp6jLbMkjFCZNCWv5Y5xPcB+uAOAxXp3A9JbdNwOET
	 9dFxUSvXhZpQvoujnRh5pZRArIJkiwuDeq5dPrvg=
Received: from [129.217.186.229] ([129.217.186.229])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66FEWQm2000998
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 16:32:26 +0200 (CEST)
Message-ID: <1ecf0eb8-17ef-4f9c-ba87-da69d207e4d4@tu-dortmund.de>
Date: Wed, 15 Jul 2026 16:32:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Brett Sheffield <brett@librecast.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org
References: <202607151550.5d829a99-lkp@intel.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <202607151550.5d829a99-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/15/26 16:01, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.ioctl03.fail" on:

ioctl03.c does not know about IFF_BACKPRESSURE which is introduced here,
consequently it fails.
See [1] where it compares TUN features with known_flags.

Thanks.

[1] Link: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl03.c#L82

> 
> commit: 09154ff2072e36b86ba2d92d436b7f27df153ed1 ("[PATCH net v3] tun/tap & vhost-net: make qdisc backpressure opt-in via IFF_BACKPRESSURE")
> url: https://github.com/intel-lab-lkp/linux/commits/Simon-Schippers/tun-tap-vhost-net-make-qdisc-backpressure-opt-in-via-IFF_BACKPRESSURE/20260709-181234
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git fabb881df322da25442f98d23f5fa371e3c78ec4
> patch link: https://lore.kernel.org/all/20260709095511.168235-1-simon.schippers@tu-dortmund.de/
> patch subject: [PATCH net v3] tun/tap & vhost-net: make qdisc backpressure opt-in via IFF_BACKPRESSURE
> 
> in testcase: ltp
> version: 
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: syscalls-03
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202607151550.5d829a99-lkp@intel.com
> 
> 
> ....
> 
> [1;37mgetuid03: [0m[1;32mpass[0m  (0.028s)
> [1;37mioctl03: [0m[1;31mfail[0m  (0.047s)     <-----
> [1;37mioctl05: [0m[1;32mpass[0m  (0.471s)
> 
> ....
> 
> Execution time: 3m 35s
> 
> Disconnecting from SUT: default
> 
> Target information
> ──────────────────
> Kernel:   Linux 7.2.0-rc1+ #1 SMP PREEMPT_DYNAMIC Sun Jul 12 07:25:38 CST 2026
> Cmdline:  ip=::::lkp-ivb-d04::dhcp
>           root=/dev/ram0
>           RESULT_ROOT=/result/ltp/1HDD-ext4-syscalls-03/lkp-ivb-d04/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/09154ff2072e36b86ba2d92d436b7f27df153ed1/0
>           BOOT_IMAGE=/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/09154ff2072e36b86ba2d92d436b7f27df153ed1/vmlinuz-7.2.0-rc1+
>           branch=linux-devel/devel-hourly-20260709-190759
>           job=/lkp/jobs/scheduled/lkp-ivb-d04/ltp-1HDD-ext4-syscalls-03-debian-13-x86_64-20250902.cgz-09154ff2072e-20260712-19649-tc8bu6-0.yaml
>           user=lkp
>           ARCH=x86_64
>           kconfig=x86_64-rhel-9.4-ltp
>           commit=09154ff2072e36b86ba2d92d436b7f27df153ed1
>           intremap=posted_msi
>           max_uptime=7200
>           LKP_SERVER=internal-lkp-server
>           nokaslr
>           selinux=0
>           debug
>           apic=debug
>           sysrq_always_enabled
>           rcupdate.rcu_cpu_stall_timeout=100
>           net.ifnames=0
>           printk.devkmsg=on
>           panic=-1
>           softlockup_panic=1
>           nmi_watchdog=panic
>           oops=panic
>           load_ramdisk=2
>           prompt_ramdisk=0
>           drbd.minor_count=8
>           systemd.log_level=err
>           ignore_loglevel
>           console=tty0
>           earlyprintk=ttyS0,115200
>           console=ttyS0,115200
>           vga=normal
>           rw
>           keep_initrds=/osimage/pkg/debian-13-x86_64-20250902.cgz/ltp-x86_64-ed2758122-1_20260711.cgz
>           acpi_rsdp=0x000f0490
> Machine:  unknown
> Arch:     x86_64
> RAM:      6895596 kB
> Swap:     0 kB
> Distro:   debian 13
> 
> ────────────────────────
>       TEST SUMMARY
> ────────────────────────
> Suite:   syscalls-03
> Runtime: 3m 24s
> Runs:    183
> 
> Results:
>     Passed:   2144
>     Failed:   1
>     Broken:   0
>     Skipped:  222
>     Warnings: 0
> 
> [1;31mFailures:[0m
>     • ioctl03
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260715/202607151550.5d829a99-lkp@intel.com
> 
> 
> 
