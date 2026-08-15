Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011283CF20A
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776641; cv=none; b=rsxi0kJCoOfQEIAKY0kbW5fSq4IF/xH/aQRho7Gee65J5hmLWjiF57JZRc1RsZ9NjNlQtDX3yXkKafAjI1lfwro/SEBDio1DwDjV2w10gaYvDcuA0PX3ekil5oNXL2+mZt00+EGs4E0ScfhwyJB5DJuEZ+VEcebVvv+JerOcMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776641; c=relaxed/simple;
	bh=bhG6QtrAnKep4lWjI6zq9th5Q4IPhbZ5kW6l/M3duc4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=V7qrD1P9y/Dw5VS6p92w4yPveAOewab9sF+qRFSiZPXziJCVuJ/PuEYJ7tuL/EuWICsmFTj83uSHsFfoF18GT9MYfXpyIz3r+HDCLHGostKLCD7I7soHmjsQB4InJJaS1qsrzygooAkTmDC88/SmhCPsOjVz19iyxyjJVD11HOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67F6oKYs020513;
	Sat, 15 Aug 2026 15:50:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67F6oKKC020503
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Aug 2026 15:50:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b06ce35d-e7bc-47a5-8e0a-e82be7e4dd08@I-love.SAKURA.ne.jp>
Date: Sat, 15 Aug 2026 15:50:13 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav103.rs.sakura.ne.jp

sashiko is reporting that trying to read /sys/kernel/debug/ref_tracker/*
causes use-afer-free crash when either alloc_percpu() or dev_addr_init()
in alloc_netdev_mqs() failed, for commit 4d92b95ff2f9 ("net: add net device
refcount tracker infrastructure") added ref_tracker_dir_exit() to only
free_netdev() path.

Reported-by: sashiko.dev (no mail address)
Closes: https://sashiko.dev/#/patchset/56c707e7-1fb0-43ec-b8fb-cf6f451e513e%40I-love.SAKURA.ne.jp
Fixes: 4d92b95ff2f9 ("net: add net device refcount tracker infrastructure")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Steps to reproduce:

(1) Build with fault injection diff shown below.

  --- a/net/core/dev.c
  +++ b/net/core/dev.c
  @@ -12073,6 +12073,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
   	refcount_set(&dev->dev_refcnt, 1);
   #endif
   
  +	if (!strcmp(current->comm, "unshare"))
  +		goto free_pcpu;
   	if (dev_addr_init(dev))
   		goto free_pcpu;
   

(2) Run the following commands.

  unshare -n /bin/true; while :; do cat /sys/kernel/debug/ref_tracker/* > /dev/null; sleep 1; done

Example output:

  BUG: unable to handle page fault for address: ffffffffaa615a40
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 15d07f067 P4D 15d07f067 PUD 15d080063 PMD 0
  Oops: Oops: 0000 [#1] SMP PTI
  CPU: 6 UID: 0 PID: 1446 Comm: cat Not tainted 7.2.0-rc7+ #345 PREEMPT_{RT,(full)}
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
  RIP: 0010:__lock_acquire+0x635/0xc40
  Code: 30 4c 8b 64 24 38 4c 8b 6c 24 40 4c 8b 74 24 48 4c 8b 7c 24 50 31 c9 48 8b 5c 24 28 89 c8 48 83 c4 58 c3 cc cc cc cc 4d 63 f6 <4c> 0f a3 35 c3 f3 45 04 0f 82 5f fd ff ff e8 28 bf 8f 00 89 c1 85
  RSP: 0018:ffffcec444a73950 EFLAGS: 00010046
  RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
  RDX: 0000000000000100 RSI: ffff89081597c448 RDI: ffff89081597b400
  RBP: 0000000000000003 R08: ffff89081597c448 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000400000 R12: ffff89081597b400
  R13: ffff89081597c448 R14: ffffffff9666420d R15: 0000000000000001
  FS:  00007fba8981f740(0000) GS:ffff8908fec6d000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffaa615a40 CR3: 0000000121820003 CR4: 0000000000370ef0
  Call Trace:
   <TASK>
   ? find_held_lock+0x2b/0x80
   lock_acquire.part.0+0x7c/0x1d0
   ? ref_tracker_debugfs_show+0x66/0x120
   rt_spin_lock+0x48/0x1e0
   ? ref_tracker_debugfs_show+0x66/0x120
   ref_tracker_debugfs_show+0x66/0x120
   seq_read_iter+0x13d/0x4e0
   ? lock_release.part.0+0x1c/0x50
   seq_read+0x12f/0x1d0
   full_proxy_read+0x78/0xd0
   vfs_read+0xe3/0x4b0
   ? rcu_read_lock_any_held.part.0+0x11/0x70
   ? validate_chain+0x2b0/0x870
   ? find_held_lock+0x2b/0x80
   ksys_read+0x84/0x120
   do_syscall_64+0xf4/0x660
   ? mark_held_locks+0x40/0x70
   ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
   ? trace_hardirqs_on+0x18/0xf0
   ? find_held_lock+0x2b/0x80
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? lock_release.part.0+0x1c/0x50
   ? mark_usage+0x61/0x170
   ? do_anonymous_page+0xc9/0x4e0
   ? __lock_acquire+0x517/0xc40
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? count_memcg_events+0x1c7/0x290
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? rcu_read_unlock+0x1c/0x60
   ? lock_release.part.0+0x1c/0x50
   ? do_user_addr_fault+0x4fd/0x850
   ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
   ? trace_hardirqs_on+0x18/0xf0
   ? do_syscall_64+0xab/0x660
   ? exc_page_fault+0x141/0x2b0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fba8989154e
  Code: 4d 89 d8 e8 b4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
  RSP: 002b:00007ffc9c6fea10 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
  RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007fba8989154e
  RDX: 0000000000040000 RSI: 00007fba8950a000 RDI: 0000000000000003
  RBP: 00007ffc9c6fea20 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
  R13: 00007fba8950a000 R14: 0000000000040000 R15: 0000000000000000
   </TASK>
  Modules linked in: vmw_balloon intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_pmc_pwrm_telemetry intel_vsec rapl pcspkr i2c_piix4 i2c_smbus joydev sunrpc dm_multipath vmw_vsock_vmci_transport vmw_vmci xfs usbhid nvme nvme_core nvme_keyring nvme_auth ata_generic pata_acpi serio_raw fuse scsi_dh_alua scsi_dh_rdac scsi_dh_emc
  CR2: ffffffffaa615a40
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:__lock_acquire+0x635/0xc40
  Code: 30 4c 8b 64 24 38 4c 8b 6c 24 40 4c 8b 74 24 48 4c 8b 7c 24 50 31 c9 48 8b 5c 24 28 89 c8 48 83 c4 58 c3 cc cc cc cc 4d 63 f6 <4c> 0f a3 35 c3 f3 45 04 0f 82 5f fd ff ff e8 28 bf 8f 00 89 c1 85
  RSP: 0018:ffffcec444a73950 EFLAGS: 00010046
  RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
  RDX: 0000000000000100 RSI: ffff89081597c448 RDI: ffff89081597b400
  RBP: 0000000000000003 R08: ffff89081597c448 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000400000 R12: ffff89081597b400
  R13: ffff89081597c448 R14: ffffffff9666420d R15: 0000000000000001
  FS:  00007fba8981f740(0000) GS:ffff8908fec6d000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffaa615a40 CR3: 0000000121820003 CR4: 0000000000370ef0
  note: cat[1446] exited with irqs disabled



By the way, even with this patch applied, there still seems to be a race
window where concurrently running

  while :; do cat /sys/kernel/debug/ref_tracker/*; done > /dev/null

and

  while :; do unshare -n /bin/true; done

(with fault injection diff shown above applied) causes below crash.

  INFO: trying to register non-static key.
  The code is fine but needs lockdep annotation, or maybe
  you didn't initialize this object before use?
  turning off the locking correctness validator.
  CPU: 0 UID: 0 PID: 1958 Comm: cat Not tainted 7.2.0-rc7+ #347 PREEMPT_{RT,(full)}
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6e/0xa0
   register_lock_class+0x61b/0x630
   ? mark_usage+0x61/0x170
   ? lock_is_held_type+0xb0/0x180
   __lock_acquire+0x597/0xc40
   lock_acquire.part.0+0x7c/0x1d0
   ? ref_tracker_debugfs_show+0x66/0x120
   rt_spin_lock+0x48/0x1e0
   ? ref_tracker_debugfs_show+0x66/0x120
   ref_tracker_debugfs_show+0x66/0x120
   seq_read_iter+0x13d/0x4e0
   ? atomic_dec_and_mutex_lock+0x6d/0x70
   ? validate_chain+0x2b0/0x870
   seq_read+0x12f/0x1d0
   full_proxy_read+0x78/0xd0
   vfs_read+0xe3/0x4b0
   ? __lock_acquire+0x517/0xc40
   ? perf_trace_contended_release+0xa8/0x100
   ksys_read+0x84/0x120
   do_syscall_64+0xf4/0x660
   ? trace_hardirqs_on+0x18/0xf0
   ? find_held_lock+0x2b/0x80
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? lock_release.part.0+0x1c/0x50
   ? mark_usage+0x61/0x170
   ? do_anonymous_page+0xc9/0x4e0
   ? __lock_acquire+0x517/0xc40
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? count_memcg_events+0x1c7/0x290
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? rcu_read_unlock+0x1c/0x60
   ? lock_release.part.0+0x1c/0x50
   ? do_user_addr_fault+0x4fd/0x850
   ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
   ? trace_hardirqs_on+0x18/0xf0
   ? do_syscall_64+0xab/0x660
   ? exc_page_fault+0x141/0x2b0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fe5b771854e
  Code: 4d 89 d8 e8 b4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
  RSP: 002b:00007fff6c77bdd0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
  RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007fe5b771854e
  RDX: 0000000000040000 RSI: 00007fe5b7391000 RDI: 0000000000000003
  RBP: 00007fff6c77bde0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
  R13: 00007fe5b7391000 R14: 0000000000040000 R15: 0000000000000000
   </TASK>
  BUG: kernel NULL pointer dereference, address: 0000000000000014
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP PTI
  CPU: 0 UID: 0 PID: 1958 Comm: cat Not tainted 7.2.0-rc7+ #347 PREEMPT_{RT,(full)}
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
  RIP: 0010:ref_tracker_get_stats+0x48/0xe0
  Code: e8 ad ba 98 ff 48 85 c0 0f 84 a2 00 00 00 4c 8b 85 90 00 00 00 4c 8d 95 90 00 00 00 48 c7 00 00 00 00 00 4d 39 c2 74 64 31 f6 <41> 8b 78 14 41 b9 01 00 00 00 85 f6 7e 43 48 8d 48 08 31 d2 eb 0d
  RSP: 0018:ffffd47dc5b67a68 EFLAGS: 00010246
  RAX: ffff8f0b41bfca80 RBX: 0000000000000010 RCX: 0000000000002800
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8f0b41bfca80
  RBP: ffff8f0b4fee2d40 R08: 0000000000000000 R09: 0000000000000001
  R10: ffff8f0b4fee2dd0 R11: 0000000000000000 R12: ffffd47dc5b67b98
  R13: 0000000000040000 R14: ffff8f0b4fee2d40 R15: ffffd47dc5b67ac0
  FS:  00007fe5b76a6740(0000) GS:ffff8f0c5c96d000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000014 CR3: 0000000109fc2002 CR4: 0000000000370ef0
  Call Trace:
   <TASK>
   __ref_tracker_dir_pr_ostream.part.0+0x1e/0x190
   ? lock_release+0xee/0x110
   ref_tracker_debugfs_show+0xc4/0x120
   ? __pfx_pr_ostream_seq+0x10/0x10
   seq_read_iter+0x13d/0x4e0
   ? atomic_dec_and_mutex_lock+0x6d/0x70
   ? validate_chain+0x2b0/0x870
   seq_read+0x12f/0x1d0
   full_proxy_read+0x78/0xd0
   vfs_read+0xe3/0x4b0
   ? __lock_acquire+0x517/0xc40
   ? perf_trace_contended_release+0xa8/0x100
   ksys_read+0x84/0x120
   do_syscall_64+0xf4/0x660
   ? trace_hardirqs_on+0x18/0xf0
   ? find_held_lock+0x2b/0x80
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? lock_release.part.0+0x1c/0x50
   ? mark_usage+0x61/0x170
   ? do_anonymous_page+0xc9/0x4e0
   ? __lock_acquire+0x517/0xc40
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? count_memcg_events+0x1c7/0x290
   ? find_held_lock+0x2b/0x80
   ? __lock_release.isra.0+0x6b/0x1a0
   ? rcu_read_unlock+0x1c/0x60
   ? lock_release.part.0+0x1c/0x50
   ? do_user_addr_fault+0x4fd/0x850
   ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
   ? trace_hardirqs_on+0x18/0xf0
   ? do_syscall_64+0xab/0x660
   ? exc_page_fault+0x141/0x2b0
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7fe5b771854e
  Code: 4d 89 d8 e8 b4 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
  RSP: 002b:00007fff6c77bdd0 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
  RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007fe5b771854e
  RDX: 0000000000040000 RSI: 00007fe5b7391000 RDI: 0000000000000003
  RBP: 00007fff6c77bde0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
  R13: 00007fe5b7391000 R14: 0000000000040000 R15: 0000000000000000
   </TASK>
  Modules linked in: intel_rapl_msr intel_rapl_common vmw_balloon intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_pmc_pwrm_telemetry intel_vsec rapl pcspkr i2c_piix4 i2c_smbus joydev sunrpc dm_multipath vmw_vsock_vmci_transport vmw_vmci xfs usbhid nvme nvme_core nvme_keyring nvme_auth ata_generic pata_acpi serio_raw fuse scsi_dh_rdac scsi_dh_emc scsi_dh_alua
  CR2: 0000000000000014
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:ref_tracker_get_stats+0x48/0xe0
  Code: e8 ad ba 98 ff 48 85 c0 0f 84 a2 00 00 00 4c 8b 85 90 00 00 00 4c 8d 95 90 00 00 00 48 c7 00 00 00 00 00 4d 39 c2 74 64 31 f6 <41> 8b 78 14 41 b9 01 00 00 00 85 f6 7e 43 48 8d 48 08 31 d2 eb 0d
  RSP: 0018:ffffd47dc5b67a68 EFLAGS: 00010246
  RAX: ffff8f0b41bfca80 RBX: 0000000000000010 RCX: 0000000000002800
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8f0b41bfca80
  RBP: ffff8f0b4fee2d40 R08: 0000000000000000 R09: 0000000000000001
  R10: ffff8f0b4fee2dd0 R11: 0000000000000000 R12: ffffd47dc5b67b98
  R13: 0000000000040000 R14: ffff8f0b4fee2d40 R15: ffffd47dc5b67ac0
  FS:  00007fe5b76a6740(0000) GS:ffff8f0c5c96d000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000014 CR3: 0000000109fc2002 CR4: 0000000000370ef0
  note: cat[1958] exited with irqs disabled

Something is still buggy with ref_tracker ?



 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ece6700536d9..c1b168b0571e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12164,6 +12164,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	free_percpu(dev->pcpu_refcnt);
 free_dev:
 #endif
+	ref_tracker_dir_exit(&dev->refcnt_tracker);
 	kvfree(dev);
 	return NULL;
 }
-- 
2.55.0
