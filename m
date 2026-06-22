Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638E13A4F47
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123729; cv=none; b=dXMhqJH8rx80MgCRbxNQj2WMSHRP7N3Om86I/EYuyslgpSRQ4V+qBWrFkiDcFUYxW1q5Z4SSLAz4SB/N+zRiFEJJjN0nSSqXVJbtJUeTS9uJPPr1tpjU3SXWUkeootVuIiWOcXubBJLDqTyPtpl/3EIsav3XsdWIdqFt8hP2Cb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123729; c=relaxed/simple;
	bh=QQrqoemZBSwBbBDoZJ7dig3TdaDdXaXZu/93LrNIzM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RAuUCIGQ4IQBmst4xnymKULgOIavN05FPG/aml/HBO4xctzdJbwBrR4SWQOy8k+eSIWChF9/I4fpGpUI9gaoV3CRkhQF5UxxFmQd7mhwEK8kAvdPwNtcEUnXcf2KyBNeZ0LZMzz1d32vbCR9msya6OG2halIHCwu6dWoiH62Kx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uAnJKdrW; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uAnJKdrW"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260622102204euoutp0177742c442cadc54a045f4f1d79002887~7YBXZsU5S3013530135euoutp01k
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:22:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260622102204euoutp0177742c442cadc54a045f4f1d79002887~7YBXZsU5S3013530135euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782123724;
	bh=wTGU4PYcJFSizoiAA+sfvZ1GHlqgKJXY0eTT33QJEic=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uAnJKdrW4tkwC1QbUqRD0HCTpDV22ugmQOFvKkXnEuONbsNvicOfNwbUJV+f9GCJv
	 6OWcXdER/iNWU/UMXeRmg57azuE5f38jsuBDXDSAVKwZxTY+1rR3xzoYDcC5OjaAvT
	 cFax3G8sAp9Y5WKIthpgQafRMAGwBVia09XvQHt4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260622102204eucas1p24477664e86759577554c78f786740ff8~7YBXI5M8K0634806348eucas1p2u;
	Mon, 22 Jun 2026 10:22:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260622102203eusmtip1b99dae51a65f3fe67787c7f161d688ad~7YBWn5MTj2219322193eusmtip1Q;
	Mon, 22 Jun 2026 10:22:03 +0000 (GMT)
Message-ID: <f329c2d1-e0ab-4bf0-abb2-28c4c596f458@samsung.com>
Date: Mon, 22 Jun 2026 12:22:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 net] net: watchdog: fix refcount tracking races
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,
	syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CANn89i+GVoQxFS26=s5w5vUa-ytRUgD1NM6MDZQdtB7FtcXv-w@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260622102204eucas1p24477664e86759577554c78f786740ff8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd
X-EPHeader: CA
X-CMS-RootMailID: 20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd
References: <CGME20260617104823eucas1p2268fc45472e6acbcbe70ee7813b4e9dd@eucas1p2.samsung.com>
	<20260611152737.2580480-1-edumazet@google.com>
	<a443376e-5187-4268-93b3-58047ef113a8@samsung.com>
	<CANn89i+GVoQxFS26=s5w5vUa-ytRUgD1NM6MDZQdtB7FtcXv-w@mail.gmail.com>

On 22.06.2026 10:59, Eric Dumazet wrote:
> On Wed, Jun 17, 2026 at 3:48 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 11.06.2026 17:27, Eric Dumazet wrote:
>>> Blamed commit converted the untracked dev_hold()/dev_put() calls
>>> in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
>>> (which were later renamed/interfaced to netdev_hold() and netdev_put()).
>>>
>>> By introducing dev->watchdog_dev_tracker to store the
>>> reference tracking information without adding synchronization
>>> between netdev_watchdog_up() and dev_watchdog(), it enabled the
>>> race condition where this pointer could be overwritten or freed
>>> concurrently, leading to the list corruption crash syzbot reported:
>>>
>>> list_del corruption, ffff888114a18c00->next is NULL
>>>  kernel BUG at lib/list_debug.c:52 !
>>> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
>>> CPU: 1 UID: 0 PID: 91 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(lazy)
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
>>> Workqueue: events_unbound linkwatch_event
>>>  RIP: 0010:__list_del_entry_valid_or_report.cold+0x22/0x2a lib/list_debug.c:52
>>> Call Trace:
>>>  <TASK>
>>>   __list_del_entry_valid include/linux/list.h:132 [inline]
>>>   __list_del_entry include/linux/list.h:246 [inline]
>>>   list_move_tail include/linux/list.h:341 [inline]
>>>   ref_tracker_free+0x1a7/0x6c0 lib/ref_tracker.c:329
>>>   netdev_tracker_free include/linux/netdevice.h:4491 [inline]
>>>   netdev_put include/linux/netdevice.h:4508 [inline]
>>>   netdev_put include/linux/netdevice.h:4504 [inline]
>>>   netdev_watchdog_down net/sched/sch_generic.c:600 [inline]
>>>   dev_deactivate_many+0x28c/0xfe0 net/sched/sch_generic.c:1363
>>>   dev_deactivate+0x109/0x1d0 net/sched/sch_generic.c:1397
>>>   linkwatch_do_dev net/core/link_watch.c:184 [inline]
>>>   linkwatch_do_dev+0xd3/0x120 net/core/link_watch.c:166
>>>   __linkwatch_run_queue+0x3a5/0x810 net/core/link_watch.c:240
>>>   linkwatch_event+0x8f/0xc0 net/core/link_watch.c:314
>>>   process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
>>>   process_scheduled_works kernel/workqueue.c:3397 [inline]
>>>   worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
>>>   kthread+0x370/0x450 kernel/kthread.c:436
>>>   ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>
>>> This patch has three coordinated parts:
>>>
>>> 1) Add dev->watchdog_lock and dev->watchdog_ref_held to serialize watchdog operations.
>>>
>>> 2) Remove netdev_watchdog_up() call from netif_carrier_on():
>>>    This ensures netdev_watchdog_up() is only called from process/BH context
>>>    (via linkwatch workqueue dev_activate()), allowing us to use
>>>    spin_lock_bh() for synchronization.
>>>
>>> 3) Synchronize watchdog up and watchdog timer:
>>>    Protect netdev_watchdog_up() with tx_global_lock and watchdog_lock.
>>>    Only allocate a new tracker in netdev_watchdog_up() if one is
>>>    not already present.
>>>    In dev_watchdog(), ensure we don't release the tracker if the
>>>    timer was rescheduled either by dev_watchdog() itself or concurrently
>>>    by netdev_watchdog_up().
>>>
>>> Fixes: f12bf6f3f942 ("net: watchdog: add net device refcount tracker")
>>> Reported-by: syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/netdev/6a26b751.c25708ab.1b19ef.0013.GAE@google.com/T/#u
>>> Tested-by: syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>> This patch landed recently in linux-next as commit 8eed5519e496 ("net: watchdog:
>> fix refcount tracking races"). In my tests I found that it causes the following
>> deadlock during system suspend/resume on QEmu's ARM64bit 'virt' machine:
>>
>> root@target:~# time rtcwake -s10 -mmem
>> rtcwake: assuming RTC uses UTC ...
>> rtcwake: wakeup from "mem" using /dev/rtc0 at Wed Jun 17 10:46:12 2026
>> PM: suspend entry (s2idle)
>> Filesystems sync: 0.055 seconds
>> Freezing user space processes
>> Freezing user space processes completed (elapsed 0.006 seconds)
>> OOM killer disabled.
>> Freezing remaining freezable tasks
>> Freezing remaining freezable tasks completed (elapsed 0.003 seconds)
>>
>> ============================================
>> WARNING: possible recursive locking detected
>> 7.1.0-rc7+ #13003 Not tainted
>> --------------------------------------------
>> rtcwake/254 is trying to acquire lock:
>> ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netdev_watchdog_up+0x40/0x108
>>
>> but task is already holding lock:
>> ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netif_tx_lock+0x1c/0x34
>>
>> other info that might help us debug this:
>>  Possible unsafe locking scenario:
>>
>>        CPU0
>>        ----
>>   lock(&dev->tx_global_lock);
>>   lock(&dev->tx_global_lock);
>>
>>  *** DEADLOCK ***
>>
>>  May be due to missing lock nesting notation
>>
>> 6 locks held by rtcwake/254:
>>  #0: ffff0000071ab3e8 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x1ec/0x35c
>>  #1: ffff00000d22c480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xf0/0x1c4
>>  #2: ffff0000049162c8 (kn->active#61){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1c4
>>  #3: ffffaa79533c03b0 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0x98/0x608
>>  #4: ffff000005e3a138 (&dev->mutex){....}-{4:4}, at: device_resume+0xb4/0x254
>>  #5: ffff000006de64e8 (&dev->tx_global_lock){+.-.}-{3:3}, at: netif_tx_lock+0x1c/0x34
>>
>> stack backtrace:
>> CPU: 1 UID: 0 PID: 254 Comm: rtcwake Not tainted 7.1.0-rc7+ #13003 PREEMPT
>> Hardware name: linux,dummy-virt (DT)
>> Call trace:
>>  show_stack+0x18/0x24 (C)
>>  dump_stack_lvl+0x90/0xd0
>>  dump_stack+0x18/0x24
>>  print_deadlock_bug+0x260/0x350
>>  __lock_acquire+0x11b8/0x225c
>>  lock_acquire+0x1c4/0x3f0
>>  _raw_spin_lock_bh+0x50/0x68
>>  netdev_watchdog_up+0x40/0x108
>>  netif_device_attach+0x9c/0xb0
>>  virtnet_restore+0x100/0x21c
>>  virtio_device_restore_priv+0x11c/0x1d0
>>  virtio_device_restore+0x14/0x20
>>  virtio_mmio_restore+0x34/0x40
>>  platform_pm_resume+0x2c/0x68
>>  dpm_run_callback+0xa0/0x240
>>  device_resume+0x120/0x254
>>  dpm_resume+0x1f8/0x2ec
>>  dpm_resume_end+0x18/0x34
>>  suspend_devices_and_enter+0x1d0/0x990
>>  pm_suspend+0x1ec/0x608
>>  state_store+0x8c/0x110
>>  kobj_attr_store+0x18/0x2c
>>  sysfs_kf_write+0x50/0x7c
>>  kernfs_fop_write_iter+0x130/0x1c4
>>  vfs_write+0x2b8/0x35c
>>  ksys_write+0x6c/0x104
>>  __arm64_sys_write+0x1c/0x28
>>  invoke_syscall+0x54/0x110
>>  el0_svc_common.constprop.0+0x40/0xe8
>>  do_el0_svc+0x20/0x2c
>>  el0_svc+0x54/0x338
>>  el0t_64_sync_handler+0xa0/0xe4
>>  el0t_64_sync+0x198/0x19c
>>
>>
>> Reverting $subject on top of linux-next fixes this issue.
> Thanks for the report Marek!
>
> Acquiring tx_global_lock in netdev_watchdog_up() appears unnecessary anyway
> because the critical state (timer and refcount tracker) is already
> protected by dev->watchdog_lock.
>
> Could you try this patch?

This fixes the observed issue. Thanks! Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 3f1c510df850dbdbaf10d483547c7b1f3a5d5482..ef2b4bf51564173751c74fefe17e3913ed2fa056
> 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -594,9 +594,8 @@ void netdev_watchdog_up(struct net_device *dev)
>                 return;
>         if (dev->watchdog_timeo <= 0)
>                 dev->watchdog_timeo = 5*HZ;
> -       spin_lock_bh(&dev->tx_global_lock);
>
> -       spin_lock(&dev->watchdog_lock);
> +       spin_lock_bh(&dev->watchdog_lock);
>         if (!mod_timer(&dev->watchdog_timer,
>                        round_jiffies(jiffies + dev->watchdog_timeo))) {
>                 if (!dev->watchdog_ref_held) {
> @@ -605,9 +604,7 @@ void netdev_watchdog_up(struct net_device *dev)
>                         dev->watchdog_ref_held = true;
>                 }
>         }
> -       spin_unlock(&dev->watchdog_lock);
> -
> -       spin_unlock_bh(&dev->tx_global_lock);
> +       spin_unlock_bh(&dev->watchdog_lock);
>  }
>  EXPORT_SYMBOL_GPL(netdev_watchdog_up);
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

