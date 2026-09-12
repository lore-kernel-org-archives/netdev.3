Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E42C032E
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789175481; cv=none; b=HAmFpEN9sMsk+JEfRMnSkpXn/F6NSljoajpN0oBg8q/HTffMJmnf7YhFdfA8iLNU6m/Sp+OYP5TSjZbG2a9J7F2fxoGbnw1ZL55+Y6xt6Xoc80PxH0U/6QANmK5iCGgsRt9ZzNk7IyCs6f+n+wUUDdeeQRr50AZBU68Uw672nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789175481; c=relaxed/simple;
	bh=eMB6tvT0hZZyGsnNThdI/TAeAqIFVfVoL7cYicGIp54=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HpGWyuSZX+TPOHtM+f74iescBn3whf6OzWaFhscylXE0XOD3MYOZG4z2TeKbjdRou1RlixuZqC555yo+COPhc94K7S86vigL/W3QYNRAazybh+We341c8vKOCQzcFdL4n1CamjToO3n/5UOMu2BElqwG4WO9ctmT4NYgjg4yGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utlUI72m; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utlUI72m"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f27c80a3so223877085a.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789175479; x=1789780279; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tj1falKDmwZv4EHgKITMnazbfSQ8aahAK4wcOUV9Ux4=;
        b=utlUI72mFHnxKAoepbO1dq9abyciRINtThNYU8EziifnOfEiDNcthZtfRZ2S3/O0/D
         Pa8nQitp2keQvMFQg2rmQF/i7Xx9YnG6h6OGpN8uQT7huNZANuudAvQtoADecvB1NWgE
         gYA9l15/7Ps/6D2ceWsIi/29d+PlSpR/4lFJ6nv2MPlM3rUuKg4o+HhotWCmI1vPilZV
         rNBSbDytJn5chstG44+wdQiitzQoZmsC6xvO5F3SdNQMMuLt181rhqySdSCTOrk+UL5u
         D68MXRK6hOSpdn+eXuxKsBi/6kU8a03VgGf/hD4ypA0iU8sgLz2IKs3YHsLGAHKOoXSQ
         7XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789175479; x=1789780279;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tj1falKDmwZv4EHgKITMnazbfSQ8aahAK4wcOUV9Ux4=;
        b=JtfyveBPe2jbgEoBizTAB9RSyTzJWEZvN/pSVb6KbH7MTfeVpk2P0p8LCvR1DVuZQj
         nVpf0aAlaILy5FabmHDacch4nNHq3iqrpUCYwEX9I1HEtZ7wjn2tYqOoU1P26QLcFSwn
         ZgxWNhqQBSWkURlbgc0soxPZY3+49tb02umRJJ2O5oTvQuF2za7xkMl5ZWAp7GcSwBmQ
         oj4aVvEjXQSaHQg0f1M0CzrGpHs9jxabpIVA5YdG4PzhXamKqRg3HRFStVnT2nwPiWtq
         +65nWHlPEdXKSCN4cohutYg2ZJAG6IdY7AUw0JJRG8eptbAAYH+dElw7anGiT61GjUwO
         ScEg==
X-Forwarded-Encrypted: i=1; AKwUvBw9pmaXnJZB5lsnCqoHd7dw/3aICWAfiHU9JRey+QxN8XaYAvj3YanJ1f6XHEGRZcvnExaD46A=@vger.kernel.org
X-Gm-Message-State: AFuF++mIEIVkrQWInvonH+oJQIzeXmmqbndsy4GYtoXkXyR2e8iffRSE
	GJX0ucIgNacAs6nQt9TZDzJpjRnQKE2cGHX6kKft22OzhNYLstRFG7IBZg3q/5327Rxlr7euc6m
	i9TaCsYg/pEIkLX/pQueSnQUMnQ==
X-Received: from qkbe26-n2.prod.google.com ([2002:a05:620a:a41a:20b0:93a:761:e75c])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4443:b0:936:eeab:307e with SMTP id af79cd13be357-93a0357e40fmr130193285a.9.1789175478663;
 Fri, 11 Sep 2026 18:11:18 -0700 (PDT)
Date: Sat, 12 Sep 2026 01:10:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260912011051.4092897-1-namangulati@google.com>
Subject: [PATCH net] netfilter: ctnetlink: fix suspicious RCU usage in expect_iter_name
From: Naman Gulati <namangulati@google.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, 
	syzbot+4bd730aede2791e40bdf@syzkaller.appspotmail.com, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"

expect_iter_name() is invoked by nf_ct_expect_iterate_net() under
spin_lock_bh(&nf_conntrack_expect_lock). It does not hold
rcu_read_lock().

When accessing exp->helper with rcu_dereference() in syzbot's report,
lockdep warns:

  =============================
  WARNING: suspicious RCU usage
  syzkaller #0 Not tainted
  -----------------------------
  net/netfilter/nf_conntrack_netlink.c:3393 suspicious rcu_dereference_check() usage!

  locks held by syz-executor381/5628: 2, last CPU#1:
   #0: ffffffff9aee42a0 (nfnl_subsys_ctnetlink_exp){+.+.}-{4:4},
       at: nfnetlink_rcv_msg+0xa69/0x12b0
   #1: ffffffff8ea74d58 (nf_conntrack_expect_lock){+...}-{3:3},
       at: nf_ct_expect_iterate_net+0x38/0x180

  Call Trace:
   <TASK>
   dump_stack_lvl+0xe8/0x150
   lockdep_rcu_suspicious+0x140/0x1d0
   expect_iter_name+0xfb/0x100
   nf_ct_expect_iterate_net+0xf2/0x180
   ctnetlink_del_expect+0x45d/0x640
   nfnetlink_rcv_msg+0xcc2/0x12b0
   netlink_rcv_skb+0x226/0x4a0
   nfnetlink_rcv+0x2b9/0x28c0
   netlink_unicast+0x7bd/0x940
   netlink_sendmsg+0x813/0xb40
   ____sys_sendmsg+0x54e/0x850
   ___sys_sendmsg+0x2a5/0x360
   __sys_sendmsg+0x2a5/0x360
   do_syscall_64+0x166/0x520
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Use rcu_dereference_protected() with lockdep_is_held() on
nf_conntrack_expect_lock instead, similar to expect_iter_me() in
nf_conntrack_helper.c.

Fixes: f01794106042 ("netfilter: nf_conntrack_expect: use expect->helper")
Reported-by: syzbot+4bd730aede2791e40bdf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6aa4a377.f81106d8.2ab401.0024.GAE@google.com/T/#u
Signed-off-by: Naman Gulati <namangulati@google.com>
---
 net/netfilter/nf_conntrack_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 579ada063b1b..4e5d7c701436 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3392,7 +3392,8 @@ static bool expect_iter_name(struct nf_conntrack_expect *exp, void *data)
 	struct nf_conntrack_helper *helper;
 	const char *name = data;
 
-	helper = rcu_dereference(exp->helper);
+	helper = rcu_dereference_protected(exp->helper,
+					   lockdep_is_held(&nf_conntrack_expect_lock));
 	if (!helper)
 		return false;
 
-- 
2.55.0.1007.g17ff1f9808-goog

