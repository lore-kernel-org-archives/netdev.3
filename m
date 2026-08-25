Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039B3F328D;
	Tue, 25 Aug 2026 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659994; cv=none; b=KWhfULVhO0QCKl8g0x8h2LKFjuRe8C4oRYQADGdKGF4Rg2302X+qMPjjVVVKPRycMNnH+cZkd3eyrJzbALvOsfLb291cE+bE7YiNoLBSFfYqH0ifrIovRCi1NUciLMqLaI+s0BI6G/RJv0vM0jpD2EK7fkN1zcbz51p71ZfZNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659994; c=relaxed/simple;
	bh=AoqPUTDsVI8g9jdDkZ9u/ed5G9TPM4HvIAXVyXE53XI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wd+is3GYK7DJ5J6zvmGvaWuWjIig1EIUtIOfVKbrWtkwjt1yn9/Qr2qKpbggTKEdKJnVS0t3t3kxpG0iIjiNID7F+AT+i4mT4Yt1nx/jl9m5/KmABXEMxgVA/q4FRv9larUEu2HYUlxqDViSvU6ArtkF4TE4xi+lsMYCH9WeuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EgtSdkgm; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EgtSdkgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787659986; bh=bFJLCsm6m11q9zEbzi89gz4MwjSk/6oztb1A0l7Mm4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EgtSdkgm4BQB9NgfEJC9d96RhYoJ9VbqWt88D0zQ2/DU3w9KyYN9xMRZTTEiOPr8J
	 JnA5S0UCKGbh8aV8v+1lFERf7Be8D6HYmKCmm9eGD5TCZ8pHRfD6sYlMaDJ4O6l8yM
	 BvQ6S7PY5SVDhlkzQw/jX9oEvNs4xOrircICusns=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 342312E2; Tue, 25 Aug 2026 20:13:02 +0800
X-QQ-mid: xmsmtpt1787659982ts7hqsovc
Message-ID: <tencent_FAEDEECDD478AE6DFC2DE96D389440E96A0A@qq.com>
X-QQ-XMAILINFO: Mi4XlWhocPm+XzcL2rNtpe4wesSamO95KFsQ2Eaf85sCPbaNqDXyGFkw4xHSqC
	 iHY7zYyLZjrshZXzu3s6yn9EZLCu0qcWprirtvCHaVmyE5Nkfjl52gOS/Ce9Vkrot63q/YuXu5in
	 lDj1Mdj7kD7lvOCdUOsGu/WD86s8rTFEt9ai4nMGH7BHYqMY3nw8gH8tx04qZV2lHMVd8A1Qrj7M
	 1QmkoVMkzgQnsqdfXFa1hyNrUFG2ex5URJfnxx+QR58VV1+vLfka2BvXMmteScNZCUA9IJ5lu5TK
	 tdqvCx0tzPWnqTYmtgMkf7FDZTjQePgpcYiMEaqBIKc754FsbAe4SIt39tj/k6fg+nDi22mhulh9
	 5En41BpeAvNNkD5lb5v9/PEmnsPE3RGxlArdqWgSOBHNzp6J3lNTjmXiyoeDiap5YWlkcfFlaBfM
	 9O8DDGhFe18/vmWCEG3J06Xnqmv0GceZtn+EKzeCYfcpEZ7NnpWUqYuwr+cgj7jK9TFaV6SV745O
	 fxBSmoj5vbeqQV1x2QvAhKJn9jMA/J9lh25dthJR3HdwblZVCJZNkF08Xdsbp6ApBpINkKWS5xbQ
	 tMTv80nci8zOqGDqCEEyMOQz86KYbJeU1tM38JY5mWAB4v8xnnQ0PG7uJKM745/5/OlOU7hjZeNt
	 +ukbf2QxAaM4HWlB3POuNdklJWa8XMW+0xHHIxD5YHtqEe+c85QfTL7TyOnXlYpafs24i/yV1sUX
	 QX2hRdx3YOda5lgbD55DUij6oagrHxPkqdeIr+AIjwQXMwAqi08dh/NHU/Bi38v91wFc/WTFH6xW
	 uAfptIeg8OWZScOrxzKzdBKZ8FlNy4UrV/Q/+FBtDABfYk9CYDzNrLLec5+ZNT79VRGrGzGuZVCC
	 C27YMVQf3wrUr6rY7R1eSLRE37SDJLkdZelpHPfmIAHwYY+VsPj0fvIYtWIhCP/F3ifvBL0nVsrY
	 4xKA0jkEbllGmiC12Wc0W9YWN2z9mWEcanEu5T5YuPvUsjNgCVZ6mA5zhnupvBGsIo7ws10u2Aad
	 iqZtWy8f5baRg5Kk5uhLCToJ6OoJiD43xB0LvwEoNYW98n/Im9AH7jtlv71gRk/kYkLGzByuX7Bb
	 LrU0PAtSQNKw4E+gnMB573d+xy69dxwhhBTO6/zo8JXTWdk4VXIIHaL/pFeosEADmcvzti
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: Po.Liu@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v3] net/sched: act_gate: Limit the max value for cycletime
Date: Tue, 25 Aug 2026 20:13:02 +0800
X-OQ-MSGID: <20260825121301.65315-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_9E794E6CE82D396E9894ECEBFAEDE6CE7C0A@qq.com>
References: <tencent_9E794E6CE82D396E9894ECEBFAEDE6CE7C0A@qq.com>
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

Modify the cycletime range in the policy to (0, S64_MAX), when parsing
cycletime, ensuring its value does not exceed S64_MAX guarantees that the
hrtimer can correctly calculate a valid expiry time.

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
v2 -> v3: using policy to limit cycletime range

 net/sched/act_gate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index fdbfcaa3e2ab..4c4a0f80dec1 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -166,13 +166,19 @@ static const struct nla_policy entry_policy[TCA_GATE_ENTRY_MAX + 1] = {
 	[TCA_GATE_ENTRY_MAX_OCTETS]	= { .type = NLA_S32 },
 };
 
+static const struct netlink_range_validation_signed gate_cycle_time_range = {
+	.min = 0,
+	.max = S64_MAX,
+};
+
 static const struct nla_policy gate_policy[TCA_GATE_MAX + 1] = {
 	[TCA_GATE_PARMS]		=
 		NLA_POLICY_EXACT_LEN(sizeof(struct tc_gate)),
 	[TCA_GATE_PRIORITY]		= { .type = NLA_S32 },
 	[TCA_GATE_ENTRY_LIST]		= { .type = NLA_NESTED },
 	[TCA_GATE_BASE_TIME]		= { .type = NLA_U64 },
-	[TCA_GATE_CYCLE_TIME]		= { .type = NLA_U64 },
+	[TCA_GATE_CYCLE_TIME]		=
+		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &gate_cycle_time_range),
 	[TCA_GATE_CYCLE_TIME_EXT]	= { .type = NLA_U64 },
 	[TCA_GATE_FLAGS]		= { .type = NLA_U32 },
 	[TCA_GATE_CLOCKID]		= { .type = NLA_S32 },
@@ -501,6 +507,7 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
 			cycle = ktime_add_ns(cycle, entry->interval);
 		cycletime = cycle;
 	}
+
 	p->tcfg_cycletime = cycletime;
 	p->tcfg_cycletime_ext = cycletime_ext;
 
-- 
2.43.0

