Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2C3A872B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805701; cv=none; b=rt/+WKuCA/fj877pB1dkSGXA2Y+lE6tCqBdaMFnfdpt0SbHknL3adnOwrdZ83fupVwou5rhxwnj1L8q/vi65n9B21mos0DjCjiNFOYKSMCsaYBcf9xDpo5MOGZahVLmmpghKugcB4xt9dyeJpIzt0jHL4rH5/5s35b9MkIa+VDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805701; c=relaxed/simple;
	bh=iOsuH1/c4v6IEBcn0NU6MJSCX8mH34dIQhgiAvmhdCI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KmK/zbz9TTsZvORZWp3QdTTMdqKugzw22l6dxSsOp8V4NbjuJNHg7BgQ7nGrfM2Ha0GXQU+abFjM3mDXeXB2Ol7A6Ns5OUtl3t89OMj49E9zq3qMgDp3cntCi1ZnbpTpAIVOb6HpLT3c1B4HcQiNjDxh71Lgi2Cdb7YEYMt6Bno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iihxKP0A; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iihxKP0A"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb48f41343aso109726a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790805699; x=1791410499; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lyfJow0PaL8KFG6SHLKrvSsgn1X1urCBZQieZuibTg=;
        b=iihxKP0ApHBBQHZ7S6f54zQvAyhxqQVc2ReXyjAYJpuirBkhbQMNLlLWrWot8frhOp
         nKf4qwWQ9u6qXVqYiY+FHJatFTfpVoxtRtEn5NWEFBPmiLmrNT15sEkcMYHZvDCIyWbG
         KCeF+5ldUbGuwdH0JHksncyrvQQgHz+/BRVi2VQ+CAwMBA0uQ7V8Vptl8mPlf4nyP+uM
         g3j3WkjIErIA44CMtKGRvG/iYcgxzgh9nH3TCUbbXLVEcw552j1fNRRB0efShAS8Q3U5
         m1FvC6X+/x0r8K80tW7r8ZIZax4bV58qpNaDBn+tT7gKEEQ3b+z6aAPP87hp85gfXNkT
         H0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790805699; x=1791410499;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8lyfJow0PaL8KFG6SHLKrvSsgn1X1urCBZQieZuibTg=;
        b=kmbe3pcsCQYJvyC+h/DUqCQtzMXxVHk8Il2g8reW75IjOPgLN5+g+5jXP1/1zfgE1A
         G7IYCMJ7StZl67aeGc9zl6hYx1SYmZpcWPLRexFqkJa/IoF5KGnvPJnQ/4qPlvrbvL7Y
         LeWkRmb5jhcEXNNwIbzbxD2LJ67TiwMyH57ZooYBDIDZhlwPh3ffT33aik53sKja9dMN
         QSokiBZHpu7HcvSnrjI82KbAM8ZhlRRAhHaEdA2o8xHWDvWDGYWCJ07fj4wWvs0lHs9A
         NP0rA32bS5qH+An7izSFB9ii3i4C2kqTjOALvW10LAfPT8vj/lzLHisiUNwuOxAv5Ly6
         2fMg==
X-Forwarded-Encrypted: i=1; AKwUvBwBXWa9m2I6s53p+3fhPaOlnuhO4PBx1CqPsGVSxHiQbId6lIhld8m+OY5AzGvhz1lhB9WweSk=@vger.kernel.org
X-Gm-Message-State: AFuF++kYwgiBq0Msq+zeQ3Hw1FCgGq60P7MVR8fPgJr7ETbXsR0uLP+m
	Jbs1+CnxiRa5uVU1FhSJfMgoQG+090digUqTJUML20JFc7tPF2xZ7nCVpb4zXWsXnyMIo/voo9t
	6L4QmFA==
X-Received: from pgte12.prod.google.com ([2002:a65:688c:0:b0:cc7:d698:697e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f86:b0:3dd:a196:ffd8
 with SMTP id adf61e73a8af0-3deacb82fd5mr610572637.40.1790805698958; Wed, 30
 Sep 2026 15:01:38 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:01:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930220137.843785-1-kuniyu@google.com>
Subject: [PATCH v1 net] ref_tracker: Don't use __GFP_NOFAIL for PF_MEMALLOC thread.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+f95c2f0a71a98cef50eb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot triggered a warning in __alloc_pages_slowpath(). [0]

ref_tracker_alloc() uses __GFP_NOFAIL if the passed gfp has
__GFP_DIRECT_RECLAIM.

However, cifs_demultiplex_thread() calls memalloc_noreclaim_save()
and its kthread has PF_MEMALLOC.

As commented in __alloc_pages_slowpath(), __GFP_NOFAIL should
not be used for PF_MEMALLOC thread.

	if (unlikely(nofail)) {
...
		/*
		 * PF_MEMALLOC request from this context is rather bizarre
		 * because we cannot reclaim anything and only can loop waiting
                 * for somebody to do a work for us.
		 */
		WARN_ON_ONCE(current->flags & PF_MEMALLOC);

Let's avoid using __GFP_NOFAIL for PF_MEMALLOC thread.

[0]:
current->flags & PF_MEMALLOC
WARNING: mm/page_alloc.c:4816 at __alloc_pages_slowpath mm/page_alloc.c:4816 [inline], CPU#0: cifsd/12032
WARNING: mm/page_alloc.c:4816 at __alloc_frozen_pages_noprof+0x1eac/0x3300 mm/page_alloc.c:5449, CPU#0: cifsd/12032
Modules linked in:
CPU: 0 UID: 0 PID: 12032 Comm: cifsd Tainted: G             L      syzkaller #0 PREEMPT(full)
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__alloc_pages_slowpath mm/page_alloc.c:4816 [inline]
RIP: 0010:__alloc_frozen_pages_noprof+0x1eac/0x3300 mm/page_alloc.c:5449
Code: 38 d0 7c 08 84 d2 0f 85 de 12 00 00 65 48 8b 05 e2 a7 1c 12 c7 84 24 94 00 00 00 00 80 00 00 f6 40 2d 08 0f 84 ba e7 ff ff 90 <0f> 0b 90 e9 b1 e7 ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03
RSP: 0000:ffffc90002e172d0 EFLAGS: 00010202
RAX: ffff888029380000 RBX: 0000000000000000 RCX: 1ffff1100fffad29
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88803fffd938
RBP: ffff88802938002c R08: 0000000000008000 R09: 0000000000000001
R10: 0000000000000002 R11: 0000000000000000 R12: 00000000000cac40
R13: ffff88803fffb900 R14: 0000000000000000 R15: 1ffff920005c2e74
FS:  0000000000000000(0000) GS:ffff888096955000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000008000a000 CR3: 00000000403b5000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 alloc_slab_page mm/slub.c:3347 [inline]
 allocate_slab mm/slub.c:3470 [inline]
 new_slab+0x1f6/0x6e0 mm/slub.c:3513
 refill_objects+0xe3/0x410 mm/slub.c:7417
 refill_sheaf mm/slub.c:2885 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4774
 alloc_from_pcs mm/slub.c:4850 [inline]
 slab_alloc_node mm/slub.c:4984 [inline]
 __kmalloc_cache_noprof+0x4f4/0x6d0 mm/slub.c:5559
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 ref_tracker_alloc+0x190/0x590 lib/ref_tracker.c:270
 __netns_tracker_alloc include/net/net_namespace.h:370 [inline]
 sk_alloc+0xcfc/0xe80 net/core/sock.c:2329
 inet_create net/ipv4/af_inet.c:333 [inline]
 inet_create+0x3a0/0x1060 net/ipv4/af_inet.c:259
 __sock_create+0x339/0x860 net/socket.c:1676
 generic_ip_connect+0x826/0x1810 fs/smb/client/connect.c:3377
 __cifs_reconnect+0x348/0xa80 fs/smb/client/connect.c:420
 _cifs_reconnect fs/smb/client/connect.c:596 [inline]
 cifs_reconnect fs/smb/client/connect.c:610 [inline]
 cifs_readv_from_socket+0x7c1/0xa30 fs/smb/client/connect.c:749
 cifs_read_from_socket+0xb8/0x100 fs/smb/client/connect.c:804
 cifs_demultiplex_thread+0x2db/0x2ea0 fs/smb/client/connect.c:1295
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: 4e66934eaadc ("lib: add reference counting tracking infrastructure")
Reported-by: syzbot+f95c2f0a71a98cef50eb@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6abd860c.9b478af7.e8d7a.0000.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 lib/ref_tracker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index 30c999d57b10..5f63206357b2 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -265,7 +265,7 @@ int ref_tracker_alloc(struct ref_tracker_dir *dir,
 		refcount_inc(&dir->no_tracker);
 		return 0;
 	}
-	if (gfp & __GFP_DIRECT_RECLAIM)
+	if ((gfp & __GFP_DIRECT_RECLAIM) && !(current->flags & PF_MEMALLOC))
 		gfp_mask |= __GFP_NOFAIL;
 	*trackerp = tracker = kzalloc_obj(*tracker, gfp_mask);
 	if (unlikely(!tracker)) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

