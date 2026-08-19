Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6426A1AC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 05:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115646; cv=none; b=YILEAKTLlTMzaK2mLTuExwBhBB1eUMsBuEXMycjZOM6Xz+8rD4Ao7AOHDQY4RImoLtNa3xhyW9s5rrtzx5trHzuHqhBgsN2ZlkiELRos/mKH2NLVakOrF3aRYSJ2MpDaEgbJE+JJhHoEqEvKcawJIiPpq3dySFk+decCBnJ9FLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115646; c=relaxed/simple;
	bh=oYXiS9FaK1OvuFYKVJThsj1YU55cH8Ln0SqDR+ONfFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqOFzRVhtHaeNqoKon7HGH8FfUPYa2BYAo9rFDK5K3MFBCOCyWZe/r88d2rALgJKnJEk6Dckdk6XW/vkbP9uOjYuG74P0RroSJkfpzt/TIHPL3dHj9ORz8hVon42ztukQbnLhcYDXQcC7exLIMLnihfYRU2q0Y81EQdBCEQ162k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1c7msUQ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1c7msUQ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90a6b298889so5935546d6.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 22:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787115644; x=1787720444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SC0i4Lg6k/dnZmYD88qiv579EkxNdGPFnYXp1dk34PA=;
        b=Q1c7msUQbek9Jg6W/bVTfsSK9EnpvknoZ4Ey6TNChEQxC0GuL+52zZ4dflzmkAP+x5
         mkou69TnOmcBhkTs+HdHluvNmWWnMgsKVg2Wb6YrxLgIS7QCJGnn/N+LBb6BZXgL8Ksh
         c3vVz8eZ64Tgv24Y59NXtcpLv/cZB/k9MFCFstf/P+tbRgsTadrvxK+swp9/GwlLUChH
         9qdzidf9RGHluUCAsHB06Zf2XD1RVsR61HIBzqfLqZj3I5F4sumJKB1vpv4/x/m20+Dy
         Ed4RPCMJzkIN5Ls9hHY9prhvY52lI1/MrjvcvDb+g0tveVkWpZAj6nL64PiYxEaZQAK5
         MaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787115644; x=1787720444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SC0i4Lg6k/dnZmYD88qiv579EkxNdGPFnYXp1dk34PA=;
        b=ImcRlGRywQ3j5v71mshIsmNhF8ZVQAbpRfcVsxtG9Q1grYWp+77CyZiDzrDZJQie08
         z723al2mjKUs+s8YUyMn+IGAzdZLe08121pNiierA1L1FpTsZu6bacG8kLrsZaLzvbPm
         mVC0Eu2SNW4f74F2MjfeARPlStP1KvS2XB1eZe+8Dj1IQGYTN4d7snh4ouJrHnfrVYxU
         3phsPyTxTmrThicxKNIzW7WZPIDW8wzux7TyHGp3sMwIi0Xq14znd9X6LC8hOc6v9vzG
         q3+BEehu8LMO0Tbopr8su3uQW33tsRvg8Kr2gsxtohN+Vedjp4Jf3rID+cFOkISEIXky
         +pZg==
X-Forwarded-Encrypted: i=1; AHgh+Ro57m/hbmmlvNcNgKW0nkNNPQcFTIMH1flhXRCMkUVw2cFAPHBqY+n2rx/K+Y6MaozOiU3++8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoJdZdM3VlPZTRFfVRCx8Rnk75j/eEPd2kNJwRi2ZRYzT5wzP
	zBwXFP9GbnNLqZjPiytM16k+txhpTpYjjSGapMwIbofYswch5M/fXuJH
X-Gm-Gg: AR+sD11XQ/FEvM0nuCGfhZzwJhnoY6dtBj+o33FRI3tQ1TWI/HEQN+7NYQmvcGxQtfT
	FEqdP6O+unTGI26Xkeue/j4gRZ5zXgjCwuxMAHHqEo1YbPljkQZWNT8E/pyIXzqBftfWTFDySwY
	gvXOBNrkeqCJBE2Y6vLWerZlot2k+Zz5BQ/oGTRSIftw/rg3vAI3vCWxMrN93OijQhSWO3gThTk
	kjpvBvZVhaVWOArx48cC3ibdyQeJKOfoQ/ZwzhXkvZZfILnW0C5RkZ7r2WGxM7WTwfOKG0paysq
	2UbL93Y6ki6b7QGKJ54h1Pld2PhOY3jnex+Dub9qxGw7evHEMpZ7G9cc76NHiftyUTbZt/0At5u
	+1RUDYn431v+SfxPNUce7I2/cm+rB6lh3HbdUefTvZZW32TvFQBGj6viK89Um1bjhdPESL7I58Y
	ETLR6r1bJE9HOIwfV4KLWxBblt3OQtBGyQqidlsjhHf6b6oTq0zucrG1bzUg6zbIZc5OQY/+FBp
	u55DoNVo9tXnlGknA==
X-Received: by 2002:a05:6214:20e3:b0:907:5c68:54d1 with SMTP id 6a1803df08f44-90c5eb75e01mr17604316d6.18.1787115643593;
        Tue, 18 Aug 2026 22:00:43 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2a386fsm6042596d6.33.2026.08.18.22.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 22:00:43 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] NFC: slab-use-after-free in _raw_spin_lock_irqsave
Date: Wed, 19 Aug 2026 01:00:29 -0400
Message-ID: <20260819050031.2725592-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in _raw_spin_lock_irqsave

on commit: 3aa1dcaa4f6f5ae08936491e08bd456f331f2d40 (2026-08-13)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/f7dab4725e2a2d57b1d302714c93c549

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   46.711115][    T9] ==================================================================
[   46.711848][    T9] BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:1300 ./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:166)
[   46.712620][    T9] Write of size 4 at addr ffff88811da9cb94 by task kworker/0:0/9
[   46.713329][    T9]
[   46.713560][    T9] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   46.713563][    T9] Workqueue: events nfc_llcp_tx_work
[   46.713570][    T9] Call Trace:
[   46.713573][    T9]  <TASK>
[   46.713574][    T9]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   46.713580][    T9]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   46.713598][    T9]  kasan_report (mm/kasan/report.c:595)
[   46.713606][    T9]  kasan_check_range (mm/kasan/generic.c:? mm/kasan/generic.c:200)
[   46.713609][    T9]  _raw_spin_lock_irqsave (./include/linux/instrumented.h:112 ./include/linux/atomic/atomic-instrumented.h:1300 ./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:166)
[   46.713621][    T9]  skb_queue_tail (net/core/skbuff.c:4114)
[   46.713627][    T9]  nfc_llcp_tx_work (net/nfc/llcp_core.c:848)
[   46.713631][    T9]  process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
[   46.713637][    T9]  worker_thread (kernel/workqueue.c:3486)
[   46.713642][    T9]  kthread (kernel/kthread.c:436)
[   46.713654][    T9]  ret_from_fork (archkernel/process.c:158)
[   46.713669][    T9]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[   46.713673][    T9]  </TASK>
[   46.713675][    T9]
[   46.728016][    T9] Allocated by task 8236 on cpu 0 at 46.562534s:
[   46.728599][    T9]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   46.729032][    T9]  __kasan_kmalloc (mm/kasan/common.c:398 mm/kasan/common.c:415)
[   46.729460][    T9]  __kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5334 mm/slub.c:5359)
[   46.729908][    T9]  sk_prot_alloc (./include/linux/slab.h:992 net/core/sock.c:2251)
[   46.730337][    T9]  sk_alloc (net/core/sock.c:2307)
[   46.730711][    T9]  llcp_sock_create (net/nfc/llcp_sock.c:1004 net/nfc/llcp_sock.c:1069)
[   46.731154][    T9]  nfc_sock_create (net/nfc/af_nfc.c:31)
[   46.731587][    T9]  __sock_create (net/socket.c:1651)
[   46.732010][    T9]  __sys_socket (net/socket.c:1709 net/socket.c:1746 net/socket.c:1793)
[   46.732424][    T9]  __x64_sys_socket (net/socket.c:1807 net/socket.c:1805 net/socket.c:1805)
[   46.732853][    T9]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   46.733274][    T9]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   46.733815][    T9]
[   46.734038][    T9] Freed by task 8236 on cpu 0 at 46.686415s:
[   46.734594][    T9]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   46.735024][    T9]  kasan_save_free_info (mm/kasan/generic.c:584)
[   46.735493][    T9]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   46.735945][    T9]  kfree (./include/linux/kasan.h:235 mm/slub.c:2677 mm/slub.c:6377 mm/slub.c:6692)
[   46.736307][    T9]  __sk_destruct (net/core/sock.c:2290 net/core/sock.c:2390)
[   46.736732][    T9]  llcp_sock_release (.net/sock.h:2020 net/nfc/llcp_sock.c:664)
[   46.737189][    T9]  sock_close (net/socket.c:710 net/socket.c:1501)
[   46.737580][    T9]  __fput (fs/file_table.c:512)
[   46.737946][    T9]  fput_close_sync (fs/file_table.c:617)
[   46.738388][    T9]  __x64_sys_close (fs/open.c:1511 fs/open.c:1496 fs/open.c:1496)
[   46.738811][    T9]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   46.739230][    T9]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   46.739771][    T9]
[   46.739991][    T9] The buggy address belongs to the object at ffff88811da9c800
[   46.739991][    T9]  which belongs to the cache kmalloc-1k of size 1024
[   46.741271][    T9] The buggy address is located 916 bytes inside of
[   46.741271][    T9]  freed 1024-byte region [ffff88811da9c800, ffff88811da9cc00)
[   46.742518][    T9]
[   46.742742][    T9] The buggy address belongs to the physical page:

Best,
Shuangpeng
