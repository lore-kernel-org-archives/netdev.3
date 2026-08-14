Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00A30CD85
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737885; cv=none; b=i27g9ELwBtDOSkyLAJjho2zqcej2Z3mYEHPiBkqrM/V+LC0JwP9fXZUS/cTyicLU8k+GiLtL2K7xxrxueBk0dYp0dV9Q/A1mZ4BrXBvlqRZNTwCPGELG2ft+Sf0jj+sWTIoJZH9aM96ihILqGDCtuhKB5Q5OmwHdOgx66nBJDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737885; c=relaxed/simple;
	bh=I39eUSU4Oni4XswmtFDamdQ7NPYHWBpj/mxXwoTI25M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyPeCrDNQK/lzHI9ndFqEy2/NSGSfDmyx78FZCzDJSZCrfqzlniD9Nj3c6gm4Caz2TQDyaqjklrlqzIyTv76J712tOHPqSC8YDMqQWsjnQtIn7MU9K5NYF1sCAqyvWz64GDf4J2xZWMlzkt17odOC7Prh+dWwodjUdRPM2vzUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAurLu64; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAurLu64"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso1619813e87.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 13:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786737882; x=1787342682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xMYYOVTN1PcETBlkhUguLuwDtR1xA+tGObC2ghibSw8=;
        b=AAurLu6415G7GDg59kLc2Wz/+y8TumczLuaLk6cI9LBQynqMVGuPvedL7y3jU6lqGp
         GADLiiMj+asr/w6nIXQTxSAeO57x9XXCrVgnfXx1Qzi6x7TD0KOUnw4cTwf+hBr7ghL8
         i0uriiq+oROxHCrmyKc2D7ZSYFn854/Ia9KBGEPk1kzwoJniAh0Fs7fYV1GrhKYlXOvw
         /ITuLzfFhb64NfE6ucPIwl7bKQsMt8shJZKK1CnnIR5dOk72QAu7QbrawivomyOYiDS6
         DdHTXMdX1sAnx0iIJaHjluwS0nPRngcnptWkusZ7dEs6JzC6Xh6L34aihqBlp1CV1Prz
         /rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786737882; x=1787342682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMYYOVTN1PcETBlkhUguLuwDtR1xA+tGObC2ghibSw8=;
        b=oqCJ6RsmSB3V4BvZd4xqJF7JY0ZkI/KHe/wzzw8aFdqcOVgj4/WVMOx06lfPRBkNcI
         /kbOkAediMjoDlby+8GgZqMuX39zas5/1iUn43pO1O/23IOn4A+jcNr9Mi6ENKAr5yx3
         YJpP04E46IYshfpmdtOEsOJW64T8nPA74WvNNEd8dA/uhw1XgCZTzbwQ12BLSghlY70M
         s8FizJmBD2sQxRcOpoexSALIuLLOHEmh4fvSCJnUyio+/j5G1qafGr8xBzwH4OojZaG+
         dK6uIe2Lj+geVatt1MSLzIGqzpgwbZpyXO8EdXA5kDdOPh5o+5kq63jDY4d8L0T2ISDA
         rppg==
X-Forwarded-Encrypted: i=1; AHgh+RrdmgNwNGEjEickP7dw/SLjm3hDGgkeEDv/DTwbE1CJhLkgUZbuLSaH2p3ITtlGRek7raChM44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyH9I5Z38PRDKtwzrHybaYPtDF2IuQyENIz+VbV/l4kkp1XwO
	2306vqhGHLIgO+FZNJWFY2oMYFk6zb1lBMcz1OvaPFzukT996qhx9X0c/vc4ac4=
X-Gm-Gg: AR+sD10P+US+khAPY1dAv6+C4q1ys7d2cnF+7UFsZSHrN72CrOn1mmC3K7SHzUPVRwG
	TRN0x903NEmpbR9/A4PZHLwT0VRMyw0YrHNlWEWQCS6zkOEiMkvEORbVpB0CrVttZNYWsL2AKQb
	2JxEyHW6wKp0lT/4frivbPATpZK2qaPx7dqMYfAcpXE4MB7UtZSi60CdZzfRQ1iQJFfNtIEkdx6
	P8R7y0s9zS7I00QmswICcornIRnWQSN88y/ma8FyoeT+xyL+UtXyfOJUFTducg7jWB6ab8/syBX
	8GXE+mzfDZyWMY0hYRdz3ot1yeqUGys7LOjb/CKD5sgu5HqYlH8ZjIxYashZ/MHcvifnCTnjMiQ
	PBTIL8XptZJi6/k/DqqFdQmWC9X2kV9TKFg78p8WZQ4eoyDJNPgZLfcrRY0m03uVHYdAdj1RFxv
	W0jkDi7ansZl0peNXZ3c/oaJ21fLG8M+jjGVCDQnDxsENIXAjpzJo=
X-Received: by 2002:a05:6512:8394:b0:5b0:c95:cdb9 with SMTP id 2adb3069b0e04-5b4591733e2mr944583e87.23.1786737881689;
        Fri, 14 Aug 2026 13:04:41 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458bfe395sm705371e87.57.2026.08.14.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:04:40 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: yield the CPU on every exit of the threaded NAPI poll loop
Date: Fri, 14 Aug 2026 23:04:27 +0100
Message-ID: <20260814220427.623427-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_threaded_poll_loop() only reaches cond_resched() when it is about to
iterate again. When __napi_poll() clears repoll the loop breaks first, so
the last iteration returns without any voluntary preemption point.

Control then goes back to napi_threaded_poll(), which calls
napi_thread_wait(). If work is already pending that helper returns without
ever calling schedule(). Under a receive load that keeps arriving at least
as fast as it is drained, this repeats indefinitely and the kthread holds
its CPU without a single reschedule. On CONFIG_PREEMPT_NONE nothing else
on that CPU gets to run.

Everything that waits for deferred work on that CPU then blocks: RCU grace
periods, per-CPU work items and RCU callbacks. Deleting a network device
hits all three - synchronize_net(), flush_all_backlogs() -> flush_work()
and rcu_barrier() from netdev_run_todo() - which is how this was found.
The backlog kthread runs the same loop via run_backlog_napi(), so it can
be held off in the same way.

rcu_softirq_qs_periodic() does not help here. It reports a quiescent state
but does not schedule, so the work items and the callbacks still wait, and
it is skipped on the exit path anyway.

Yield on both exits. rcu_softirq_qs_periodic() keeps its place on the
iterating path, where the RCU annotation is what is needed.

Measured on a Nokia XG-040G-MF (Airoha AN7583, dual core Cortex-A53,
CONFIG_PREEMPT_NONE, HZ=100, airoha_eth with threaded NAPI) while the
board terminates a 985 Mbit/s TCP receive load. 60 minute runs, timing
"ip link del" of a dummy interface:

                    before        after
  mean               1.22 s       0.10 s
  worst             60.32 s       0.16 s
  over 1 s        7 of 172      0 of 179
  RCU stalls             2            0
  receive       985 Mbit/s   984 Mbit/s
  packet rate   82094 p/s    82027 p/s

The packet rate is the control: the same work is done in both runs, so
the difference is not a lighter load.

The test kernel was 6.18, where this loop has no busy_poll_last_qs
parameter. With that pointer NULL the two versions of the loop are the
same code - the initialiser falls back to jiffies, the gro_flush_normal()
call and the write-back are skipped, and the tail condition reduces to
"if (repoll)" - so the change under test is this one. The busy-poll path
is not covered by these runs; this patch does not alter it, as
cond_resched() was already reached there.

An earlier variant that only moved the quiescent-state report, without
changing where the CPU is yielded, was not enough: the delay simply
migrated from synchronize_net() to flush_work() and rcu_barrier().

Without the patch the kernel reports the thread holding the CPU:

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu:  0-....: (5999 ticks this GP) ... (t=6001 jiffies g=50657 q=400)
  CPU: 0 UID: 0 PID: 241 Comm: napi/qdma_eth-0 Tainted: G W O 6.18.41 #0
  Tainted: [W]=WARN, [O]=OOT_MODULE
  Hardware name: Nokia XG-040G-MF (DT)
  pc : gro_receive_skb+0x0/0x1b8
  lr : gro_cell_poll+0x58/0xc0

Reproducing it needs the loop to be re-entered tens of thousands of times
a second, so it depends on the driver and on the shape of the load. It
did not reproduce on mtk_eth_soc, whose net_dim moderation coalesces the
same packet rate into far fewer interrupts, nor at loads where the queue
drains completely on each poll and the thread sleeps.

The taint is an out-of-tree GPIO button module and an earlier PHY warning,
both unrelated to the networking path above.

Fixes: 29863d41bb6e ("net: implement threaded-able napi poll loop support")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 net/core/dev.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ece6700536d9..884aa2dcadbe 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7876,11 +7876,14 @@ static void napi_threaded_poll_loop(struct napi_struct *napi,
 			gro_flush_normal(&napi->gro, HZ >= 1000);
 		local_bh_enable();
 
-		/* Call cond_resched here to avoid watchdog warnings. */
-		if (repoll || busy_poll_last_qs) {
+		if (repoll || busy_poll_last_qs)
 			rcu_softirq_qs_periodic(last_qs);
-			cond_resched();
-		}
+
+		/* Yield on every exit from the loop, not only when it iterates:
+		 * napi_thread_wait() can return without scheduling, so a thread
+		 * that keeps finding work would never give up the CPU.
+		 */
+		cond_resched();
 
 		if (!repoll)
 			break;
-- 
2.55.0

