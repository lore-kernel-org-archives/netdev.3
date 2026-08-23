Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456603B71C9;
	Sun, 23 Aug 2026 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787458077; cv=none; b=N6vZCh6AuQsNuI7eN+c3GUniefjHBnHa1IczyN3Z7xfXC+0Z7Vr/wWOXNJBkdMMtG1xUc8ntwvE99/Il3gxQh40DukEOyiJjOhRaThZ04r/18MP5oeW6CA8ACaBAh8UFvHh4nz91KlZOgT26mjh8T40CVEmaxiyvF3Et3eOxlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787458077; c=relaxed/simple;
	bh=BrQEveSL5UGf2cnHAG6rE4fic0J3LlFbmr5lyKMTdNs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DkW2NjNN58QEOxTXgqM/Xz8NpcATvgvM0qqVkgYm5yUVTVEu62VMrR4OJ/RxPAvvgjMGlii361Y9KGCO0gbWA3R1zkadwZIjBuB8yoXlD3MG6w0SQjPxFgpOcDFU2J7bGfshPfz1w4+6HxgurrLFc/CWab5A+wq9n1a4F2EsrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qoXsqAOp; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qoXsqAOp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787458065; bh=owOPe+Eel1OvEICUFHLUZ4XvdNydpq1p+elPsbmbnZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qoXsqAOpPBBkP5x3WG/CGv6/6hn0Uo78MvnhiLI0l5YOJJfep1JUK2n4gfIMKhjMG
	 QxtPSBGQsLvrEOvWXigPqujUUlcXEiDJPBSM9Cv9Xl76Z7wd5z8SZJYg7X79Cv4e33
	 rXdObSACOTYvqs3PSCN3+kj+EhGngj0Ei8EzAbA4=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 1E889AA5; Sun, 23 Aug 2026 12:07:40 +0800
X-QQ-mid: xmsmtpt1787458060tzxc4hsh4
Message-ID: <tencent_4ED9536B0375C96183B2244CF7709768C605@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uxGeeVmXhc6av3QVLvHx95F5o9gxDzENCpO/Fu7lkjz8dJIUtew
	 Ghki1kYHhiNET4vnX/hs36uGWqkMX3YhAM3fC+cy8gMZW/vWpN6cOJm2sN+d4thi30UiPaGe6V1B
	 +o2O5ICJdy0c2HHu5FVmamqYwN2HIniodwajXYNICBu4Cw4GIAluxSC2jU6pyon4rLhp4dbqgVE+
	 fUhE7uW4JhJRnVgGwcp827g7tZdFzYYMQJNztcEM3/0S03on3JU3Wg4JdkGyAKf+u1bgsA063MBF
	 FmqfRZt3BLAs5UNcdSTUJB8dPoQmmK68Vo1B8sipzMo8Y3L71eC66DVw5df/RPZjlPx5K1TSv3m0
	 exOGVQniWAXj2IeH+PCa2EXtOOJMR+JGHP9V0hcb+PFTJ7MHVNfqDTOdx2BDvasSm0yJ9aNo90wW
	 OUqn+cugw1miYk9E6SsZf3fFUDE93uTwQ4OyxTmLfAHKnt/pDl0ykFK/y3RABGDb2UOfz8xme6lH
	 X2ukYG4klgOJpr7pRZvP13lNTWrQ7SstZ22PuHtmgjhDm8p7PIker1bYSai8iNqlCjddBAykyT82
	 jgE+jMkP1POuLnKNEv87mxQi2YGScaQmS80VW9aebBi479tA3QBZmr4bZBEuf+sKnL01juM0m/Oi
	 jc40aCGpvcv9U+bIuB0Oxb0sAfP/E/DZgkeO0qaM1lDx/ojytsSXtYoh6H17Pw/LKlQeYZOVCzx4
	 HelGRYb5TaoRRHfRUJxDbjrBmCDlxlEbhDqUJgjc/5RnYrQDezI7vB38P8PStt4bIdfjlqVSWmtK
	 6h93s/p7caJxjOIjVy0/jwZYV2sV/vVA5S5u5WGwiRT6qCUg5tXN1olCkdAof0DMUCz/ES5J3ulr
	 0hlOGDrFuyr/avk5sWMbz+fDx+MoUpqaoZSeI/qgdMgpUx7XZ7psnzH8ML9Mdg9Ri4mpvWV0leP0
	 6oeMYThcHimp5rO6EJkYMEGWfdCxvObC/fbMcdaPyYkLIVjGjJ2aRVi2YSnBz8+K/RM0x+7dzCAl
	 Vq36lMLj07+ltgGyP5WUkzoulH1wkIkLbBYE4O23nvpY4tZW35vR+Bi9p6/sBL5FqSkONRbw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Edward Adam Davis <eadavis@qq.com>
To: kuba@kernel.org
Cc: Po.Liu@nxp.com,
	davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] net/sched: act_gate: Limit the max value for cycletime
Date: Sun, 23 Aug 2026 12:07:41 +0800
X-OQ-MSGID: <20260823040740.109924-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822202012.2229309-1-kuba@kernel.org>
References: <20260822202012.2229309-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user passes a cycletime value of 0xFFFFFFFFFFFFFFFFULL,
an overflow occurs during the assignment of cycle in gate_timer_func():

cycle = p->tcfg_cycletime; // overflow, cycle = -1

Since the local variable cycle is declared as ktime_t (i.e., s64),
the assignment overflows.

This leads to an incorrect calculation of the close_time value.
Ultimately, the new hrtimer expiry time becomes less than now, causing
__hrtimer_run_queues() to execute the "timer callback" for an excessively
long period, which triggers a soft lockup. [1]

Another factor is that the passed interval value is 1; while this accelerates
the problematic progression of close_time, it is not the decisive factor in
the issue described in [1].

When initializing cycletime, ensuring its value does not exceed INT_MAX
guarantees that the hrtimer can correctly calculate a valid expiry time.

[1]
watchdog: BUG: soft lockup - CPU#1 stuck for 3s! [syz-executor291:5020]
pc : seqcount_lockdep_reader_access+0xd8/0xf8 include/linux/seqlock.h:76
Call trace:
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 seqcount_lockdep_reader_access+0xd8/0xf8 include/linux/seqlock.h:75 (P)
 ktime_get+0x68/0x218 kernel/time/timekeeping.c:971
 gate_get_time+0x1c/0xa4 net/sched/act_gate.c:23
 gate_timer_func+0x1a8/0x390 net/sched/act_gate.c:101
 __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
 __hrtimer_run_queues+0x314/0xbe0 kernel/time/hrtimer.c:2096
 hrtimer_run_softirq+0x15c/0x21c kernel/time/hrtimer.c:2113
 handle_softirqs+0x2ec/0xd98 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:78
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:885
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:83
 invoke_softirq kernel/softirq.c:503 [inline]
 __irq_exit_rcu+0x1ac/0x428 kernel/softirq.c:735
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:752
 __el1_irq arch/arm64/kernel/entry-common.c:531 [inline]
 el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:543
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:548
 el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:586
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P)
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
 __local_bh_enable_ip+0x1f0/0x35c kernel/softirq.c:455 (P)
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 __alloc_skb+0x1c8/0x610 net/core/skbuff.c:699
 alloc_skb include/linux/skbuff.h:1384 [inline]
 alloc_skb_with_frags+0xb8/0x690 net/core/skbuff.c:6775
 sock_alloc_send_pskb+0x740/0x850 net/core/sock.c:3012
 unix_dgram_sendmsg+0x434/0x1078 net/unix/af_unix.c:2137
 sock_sendmsg_nosec net/socket.c:775 [inline]

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Reported-by: syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0054fed3dc9085390f51
Tested-by: syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: return -EINVAL with NL_SET_BAD_ATTR

 net/sched/act_gate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index fdbfcaa3e2ab..30bcf173274c 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -501,6 +501,14 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 			cycle = ktime_add_ns(cycle, entry->interval);
 		cycletime = cycle;
 	}
+
+	if (cycletime < 0 || cycletime > INT_MAX) {
+		NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
+		err = -EINVAL;
+		spin_unlock_bh(&gact->tcf_lock);
+		goto err_free;
+	}
+
 	p->tcfg_cycletime = cycletime;
 	p->tcfg_cycletime_ext = cycletime_ext;
 
-- 
2.43.0

