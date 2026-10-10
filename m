Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2497284662
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613541; cv=none; b=lVpYvp4WFaSgDha7wTrQvH+McqFTss1dJ/9Z3hJvL4gJjwwaoIncvtS1KIFZshOkGL0ydkIQdTPd/+zNRhTmDmDvfuAqXZ4VgWC8W1fEO47k8VxpVjzVO2TEIkTS7/r4t7L9QuTaNJvWrB5fFM0KbqwLaOsDU1516Otcwv4Cb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613541; c=relaxed/simple;
	bh=E2pEVjkj8CR9/b/Hho0EqTpVcswquHmw9P1UAJ24dYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSelmGZzT9RM49UekCRq1M2Ucia9hEa30jUYswZjb4WNvCtka04+CfojemcbwYLLXs5Cxr/NH1jB/vjbgFdmeXSRxZ8Gq/LU6DaSxn/aGoTIoc6h3HviPQlCTMXTbQveoozf75MCpPzmn3LjV/Z12jiYlTPNKuutAKq/FFVO2VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=lgLWQvZt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="lgLWQvZt"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b52ba422cso6453246d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791613539; x=1792218339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vr9OuNPezMn8n+osd38yLy95NtCwmdopCIatDLtfz14=;
        b=lgLWQvZt5h7ez1zpUp8Ai3ZAzEOcDoKkDJhqjEoIjsk/613lrXi1Lrw94fZQJ45ivF
         t0bXd3r/T1xJE+DkXIYHBaDkpj+3IU5EELTfbxHem7v2i40ghHpgHlqoPRHvfYODvUHC
         2eeI4+tQDwfoceQJUUEObXW16e5ApcVHr50XdQlNfdJm9aX2L3cQ3sypNV1UnBUqWsLd
         X03C8n7tUY5tYmErdGIJQG/eKe5P+3dXe4pL6nPL0iBKFT/pzIHOrABotaiIX+6JjBh9
         NgiUhcPJz8SMLYOdyfXPYR/noVGa4CDw5XnSZO9GVe7Pwbd8tLnofwexeJf5DpmUKPWB
         v9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791613539; x=1792218339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vr9OuNPezMn8n+osd38yLy95NtCwmdopCIatDLtfz14=;
        b=ZR9oN5XZEF5J1Eh6EZ2jA7pQZxqVEmjL8/aHZuot0I8IPSYuFIVOl2vYEUcb0qeMb+
         cMNA9qzvFOlg26OsGyZR5TqvXSLTs6+9BaKxYE/Wgnut3XL8Xfc9uOugn003Cr3X3DoU
         FDcviOpndG4h7kwf+Dp7fCVpwTEVpKx0Z7Plk4uISoYX8C7nHRi0Nd5iwNyqgoo8GJGd
         rvINsMTjHHVgsI4+MJqleR3RPsPFU4urosMq7NCzroHTjyVPbZqoOuSvq2u8c6EMNzWn
         dlEfoNArhFOmnGfPTeCB9xuARGIRTnsIK0FgIjUZWfRl+1j6F6Tzxn99dHV2M9A747UO
         /mqg==
X-Gm-Message-State: AFq9FYKdFARqVQepzMVpMKAYJwDzmEhNML12VZmgprOwKd/nlLN5T0eq
	D25fC9D3N9jhrWpUuafWheN3fcAraoufvzbGRUw0r0AqpTvbVtzhapl/gr0BEzY+hv7R+8xqnXQ
	5oZ7Bn8G1
X-Gm-Gg: AYBFou1c31Fw8ZHdgvySUNpCZI/wETaDukCIC8VYJQPrwuYiJAPoDxOQyYCHAnzUixe
	EJucZO6DvEsPfWwWehm9jIN1vMeS/0lYTq9ekf6OecjlMIM9r2TpzFuYTKXaXBTHX7n/6K0r0Eq
	mKJiDEV1AoT8cHQpMUbAxX5O2yE60mJrgQ6OEzk3luO16HdCb9dYK16CmWKyi/GuaoKfW8v8C/+
	ircqGWIVDOL5a+aiP17891/mWRPNZ+0Qw5aPMGHYRrdJC266iPo9MghZiQi8rAKAOGVZEIrfODi
	rbSsktI5aAVGLxtrgc7ChfJgojx23tzgWPU6Ul/nLqwdWrHfEkC5CqjjZz/nrvS8bI3Mb97m3Ve
	JVIZm2TVyDjfWK9QCeS+7y7ZrWAyNkYsHBvAMwg06Ivt5b5fmfU3HYRUnSzbQmtEW5j3gAxn+FO
	sErR19quiYOBTtuOLRK+W3CYvP9sAkkY4XDqs1CKtB9EWFS3TEx0Ttmy3s1gtTnvxJl+eL/a9gQ
	qt1jWH15yv2Wf+pcpo=
X-Received: by 2002:ad4:5744:0:b0:91b:5d39:e13d with SMTP id 6a1803df08f44-91b5d39e91fmr61182496d6.50.1791613538497;
        Fri, 09 Oct 2026 23:25:38 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550e177csm37378836d6.47.2026.10.09.23.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:25:37 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v2 0/1] devlink: fix reload error on netns teardown
Date: Sat, 10 Oct 2026 14:25:30 +0800
Message-ID: <cover.1791555658.git.petalzu987@gmail.com>
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

We found an issue in net/devlink/core.c.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11365

When a supported driver's reload_down callback fails,
devlink_pernet_pre_exit() warns and leaves the registered devlink in the
namespace being destroyed. devlink->_net is a non-refcounted possible_net_t
pointer, so cleanup_net() can free that namespace while the devlink remains
registered. A later device-removal notification reaches
genl_has_listeners(), which calls netlink_has_listeners(), and dereferences
the stale namespace context. The issue can also make the devlink appear to
belong to a newly created namespace if slab reuse occurs. The reproducer
uses netdevsim and requires root in the initial namespace.

Changes since v1:

- Move the fallback transition into devlink_pernet_pre_exit(), where the
  teardown context is explicit, instead of checking is_dying in the generic
  devlink_reload() path.
- Perform the fallback only if the devlink still belongs to the exiting
  namespace, avoiding a duplicate transition if reload_up() fails after the
  regular path has already moved the instance.
- Preserve the original reload error and warning behavior.
- No check_net() test is needed: this callback identifies teardown, while
  check_net() tests whether the namespace reference is still live.
- v1 Link: https://lore.kernel.org/r/cover.1791019703.git.petalzu987@gmail.com

Reproducer:

Run the enclosed script as root in the QEMU guest. It creates a netdevsim
device, moves it to a network namespace, makes reload_down() fail during
teardown, then removes the device to trigger a later devlink notification.
We use a 2 vCPU, 2 GB RAM x86 QEMU guest.

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

Validation on the latest net tree (base commit
af32da41b0327b9c6a37856ba82b6760d6c8d10e, kernel 7.3.0-rc6):

- The clean kernel reproduced a KASAN null-ptr-deref in
  netlink_has_listeners() during netdevsim device removal, followed by a
  fatal exception panic. The effective command line used
  panic_on_warn=0 oops=continue panic_on_oom=0, so this was not a
  panic_on_warn escalation.
- With this patch, the same PoC completed three times in one guest, each
  using a fresh network namespace. All three commands exited 0; the guest
  remained reachable and its serial log and dmesg had no KASAN, Oops, or
  panic signature. These were three triggers in one guest, not three boots.

The complete clean crash log below is from an earlier v1 run on 7.3.0-rc5.
The latest v2 clean and patched serial logs are retained in the task
validation artifacts.

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
  net: devlink: fix reload error on netns teardown

 net/devlink/core.c          | 2 ++
 net/devlink/dev.c           | 6 +++---
 net/devlink/devl_internal.h | 3 +++
 3 files changed, 8 insertions(+), 3 deletions(-)

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e

--
2.34.1
