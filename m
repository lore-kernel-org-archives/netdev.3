Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981700;
	b=SUA/Im9zqiPRPq6elW5Oius6z/bAwizy+C+5MyFZpM9GAooOztM1ehgwxLNJ02vMJZZd
	 JJ9O7SKsWcC1lYspcUf9hIn/Xms4L3h7qbFYdgOPpUP7DoL9yvihaROmSYK7HWDeuGxsO
	 3/TMj76YtgnM5SgqG493cYzNATYHVZrER6qrCMcfMAt1BOUph1yGM0QKTK+p04vs5KsHo
	 IsrauLWV6tYJ3QbkBLg9u7Q4gZ9bUsEypc/JHM/iB+/oLOTOY+ZG7V45RVTdo005xr7Bg
	 dFah2Ya4+Bh1bFSg2eflqp3TDxjk75QTC5ATrSm2VbV5gaPz3N29OxxkvVmdlYZtsUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j/0V4Bpa8SfSCP/aORDBa/+z1pHL0wVfhYdUCFM9fC4=;
	b=TmkWbW+H0rTegniEUwoVO3IfGf93q0x1KZZd9pkkR6y6GXVd2vWUJX+VTDdla9I555Dt
	 r6zDIgVHm6j0duOKev9lFRIRHg9YDvOhOhGvk4smeZXqD1T9r+jcFUVthfXYLQ/tG/uDw
	 ZANrMvwk1KbnVdk8nmFJU1hKttzFUFxdMCjw8rZH/UDlCau1rxzdjECem8u9sFkMWHgFG
	 gF1uqAHGb/nUYjckruDfyC7puN3pTlbCxo67MRKA0qt+gjSInGB/5HEHGSwVH0rJQrRhh
	 OH1NGZ4X/1UlZy8zmIub7iXBUW1Dv6DQ7CT1DIOqnh3faN1G5P8r486CvrL5Wjqcd/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W51Ti/cR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EB8606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W51Ti/cR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045531F0089F;
	Fri,  6 Nov 2026 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793981699;
	bh=j/0V4Bpa8SfSCP/aORDBa/+z1pHL0wVfhYdUCFM9fC4=;
	h=From:To:Cc:Subject:Date;
	b=W51Ti/cR/Zv8DOCZzsPt6zuzERFE78N6xrbHJnE5Fa3yyRU0lgi+nRRDXEj4RgtKv
	 OF/dVPBefFv+bAmB0e5f17SqKMLsTdkP5gn7Nd1PBnFqT0Smwiok5NJBqzWr8jHp/5
	 eJYU/QfOzNfuoFnw0mqGYsn1mYyelZ0dCdGIIyKhCLqPZUmb59XIe6lSIavXjNOmmN
	 xdtMZT9u8ZCBhxWzpMQo1K0dt4bMDpuQig5txpixo6lY1YCpoaUoPNTg31iG/qw7OZ
	 3M95TS6v7Di+amkgT+VQsyM7jD9vEbLL7apPpKpyYb4S3McO/UN0/jb5Y0khbkBMCX
	 xd106gfYgcXOw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net] net/sched: hold the tree lock while resetting a qdisc being destroyed
Date: Fri,  6 Nov 2026 17:14:55 +0100
Message-ID: <20261106161455.2412769-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 47e8dbb6e763 ("net/sched: do not reset queues in graft
operations"), qdisc_graft() and mq_graft() no longer reset the qdisc
they remove, so it can still hold packets when qdisc_put() destroys it.

__qdisc_destroy() then calls qdisc_reset() without any lock, while
qdisc timers keep running until ops->destroy() stops them.
For instance sfq_perturbation() can rehash the SFQ queues under the
sleeping root lock, while sfq_reset() dequeues and frees the same
packets, corrupting skb lists.

__qdisc_destroy() has called qdisc_reset() without the lock its comment
requires since commit 4909daba3784 ("net_sched: use qdisc_reset() in
qdisc_destroy()"), relying on dev_deactivate() having already purged
the queue under the lock. Commit 47e8dbb6e763 ("net/sched: do not
reset queues in graft operations") removed that purge for graft
operations.

Take sch_tree_lock() around qdisc_reset() in __qdisc_destroy().
This is the lock these timers take, and the lock every other
qdisc_reset() caller holds. __qdisc_destroy() runs under RTNL and in
process context, since ops->destroy() can sleep.

Also update the qdisc_reset() comment, which named qdisc_lock(qdisc)
while most callers hold the root lock.

Fixes: 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
The issue was discovered by an AI code review agent. It was confirmed
on a KASAN kernel, without kernel modifications, by running this loop
on four dummy devices in parallel ("fill" is a small sendmmsg() program
queuing 40000 UDP packets to 1024 different ports):

  tc qdisc replace dev $d root handle 1: tbf rate 100kbit burst 4k \
     limit 100m
  tc qdisc add dev $d parent 1:1 sfq perturb 1 flows 1024 divisor 1024 \
     depth 127 limit 100000
  ./fill $peer 40000
  sleep 0.$((RANDOM % 10))
  tc qdisc del dev $d root

It triggered within seconds a slab-use-after-free in sfq_dequeue()
called from sfq_reset(), and a general protection fault in sfq_rehash()
called from sfq_perturbation().

With this patch, 150 iterations on four devices completed without any
KASAN or lockdep report. The tc-testing qdisc selftests also pass on
a KASAN + lockdep kernel without any report.

 net/sched/sch_generic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index d2e0d20f3ba1cddb82987a559d49f6685a756cc1..e39745d58bfcd2c35cbc9b510b48062ba50ddda3 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1106,7 +1106,7 @@ struct Qdisc *qdisc_create_dflt(struct netdev_queue *dev_queue,
 }
 EXPORT_SYMBOL(qdisc_create_dflt);
 
-/* Under qdisc_lock(qdisc) and BH! */
+/* Under sch_tree_lock(qdisc) and BH! */
 
 void qdisc_reset(struct Qdisc *qdisc)
 {
@@ -1154,8 +1154,13 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 #endif
 	gen_kill_estimator(&qdisc->rate_est);
 
+	/* A detached qdisc can still hold packets, and its timers
+	 * (sfq_perturbation(), ...) may run until ops->destroy() stops
+	 * them. They hold the sleeping root lock, take it here as well.
+	 */
+	sch_tree_lock(qdisc);
 	qdisc_reset(qdisc);
-
+	sch_tree_unlock(qdisc);
 
 	if (ops->destroy)
 		ops->destroy(qdisc);
-- 
2.53.0

