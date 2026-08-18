Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFB336B061
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049867; cv=none; b=b4PgvYHe7S8b68nIkuliqp55GdZLumzBBFvR2IB6/kl/NxukOiYSBn9iUdBDvyg3Grm+PWbGRH9ZB+iug2z4A9I4l1w6z8B6eAZgyNHZNuNmpX3CCX6NeetLgywyMTPippom58RwLmRSSZ84K/PingkkdnpVe2X2lrfRsjnJezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049867; c=relaxed/simple;
	bh=C4azgkpMhb14+aLX0G7hA3csUgEyrPpz3MSWKxwfRag=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ptbUm++1cxzHj+b7gE3XhF3oK5RYcUuCQOdWI9pPxTZ/IBu4effeEAMFMC6iJc5A3/sI29q5YEQP3v30AsOSvcFLmKy5FT7tAxi9DWF7HW9vlN1oJ9YjM25+xI8mDJf2knvM2KbtmPDwDrTJkp9ff68RUZ7wJZzGbuszP6ySfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=scOinwen; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="scOinwen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787049854; bh=mUFNUvmvEY8shZegmS30gayvl8uNU3nmLQUm5g73Yss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=scOinwenFcPLHix/KNR5PHCPCrmub7xVV4FoXSlQtruPXnMjF6alDXx1SYSKvkp4l
	 2h0MR3n8bvVa5LO/LsTjDCvdjzXYQ2MrNBSnH9Q0hL07F0dT5/vH8EJEUvSI7HyKj+
	 vvB95k8Jqizi8SN4xGxrpWa8l5KjixGdxHlMhcAg=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B0A2F061; Tue, 18 Aug 2026 18:44:10 +0800
X-QQ-mid: xmsmtpt1787049850txp9onfv4
Message-ID: <tencent_19FD76F366C43D4737EE9682371A4BF87409@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0C2/MKSkpuk4ksvEQrKF05dBVKRafA+X8iXHBhXx+1FwxgWUofZ6
	 nMeQaLgKRDjumBKHN9m0cvZFzlUzd8rt/OZE+Cz2g2hu9v6JpeYFpchsVqsp+UfV6w5NkdKNdw8/
	 Bt7eJlSpUjwA5SzTRKXqOIAn1jmSuyuAEsIIYB7R9x8ZVUo67iwOypnvsXb7gbdwzMnujM0/NJRL
	 egV1UkgtBeHVyigc8Fw3s9hY/zkzCbhk41OUTV4UoQW5xJnfkTidraO6AcHJGjKZ6IEi1CaseGFM
	 KQ9JWEGmZ5icT90reRH5iIBwFNOuJA70MDZxOIZrt1JzdQ3SS7xfXPyEK9ba1RueJciZ0dQlvE48
	 2nuS/QVozCaPYGhtQrDnmwJxrk7cnAD4ZUZlzWcihpAWbH4PLzQktY4/jHoBGxO2dstssKKsGbWg
	 79yarOYB4qoPOHeZ29A0KsTdjG1M6TBXwvZKFV6KwrtH2az+WA0PZ9kTr+1FtqDvVM15OvPVqrFp
	 fkvaWrafq+IM3Xzj6SAlX50D80yU2UTiIHdqYlQC51sntDIhpl0uBdD7sr0Qk/yWPy9J4imrtl+a
	 zZ1yVcqtGldnVKJkHyl7PNMM1Mik02IbnyJ8RAoTuu/T80sVLv11g0kSxEGzgQAD8JSZ4lL5VYvu
	 1AxZliR4sFctOyGwhjeqeTpZQgkpZcABmwVC6s8LAP8zSscc0aSW8QO9a00u5Uoyx+zdrj1LoXaT
	 pa/3z4Cw6j9Gb0tqiIW3MqAeyK8XzpSyt2TTHKtebAR+6Sd/eUrNGhpZPsCovIfLgBNP7UPy+LTI
	 2qTji5MkTAa3zcJin9mzkDr25MMartfuKQPQjxDdFZo/gcFw20TUiUX8wpNDx+96MV5Sg7gdxRMR
	 x7wV6FRPCRWrYRLOyUJvcTGxnL9bKsYwHZYHX0tFsAi5/eOqJGqw+Tp7sm/z7tAheEvzvqmgMugd
	 FizRRQuGrzt1Dqz12BVPIRAO6vhaen5S0Ok4DcHZuGbvkhs89J8+a5WhzFcbzQ8skbUjZ0JhstQ3
	 GRb2D+xYm649mKFNa+vXJHx/SYsr9xJdJgzKSzCho9MossEdGLZfHrVt2QFpk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Po.Liu@nxp.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net/sched: act_gate: Limit the max value for cycletime
Date: Tue, 18 Aug 2026 18:44:10 +0800
X-OQ-MSGID: <20260818104409.420153-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a83310d.dbb3a75c.20434b.0069.GAE@google.com>
References: <6a83310d.dbb3a75c.20434b.0069.GAE@google.com>
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

When initializing cycletime, ensuring its value does not exceed S64_MAX
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
 net/sched/act_gate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index fdbfcaa3e2ab..ad5a6d75bbda 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -501,6 +501,8 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 			cycle = ktime_add_ns(cycle, entry->interval);
 		cycletime = cycle;
 	}
+	if (cycletime > S64_MAX)
+		cycletime = S64_MAX;
 	p->tcfg_cycletime = cycletime;
 	p->tcfg_cycletime_ext = cycletime_ext;
 
-- 
2.43.0

