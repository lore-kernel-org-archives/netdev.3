Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785780;
	b=OtWhVK94s4YX0ggDZG3ssto/ExSQRTmFaV1iYMxgzlvqCUe6ed7YsrTMqlowDBowpmIM
	 vfTsI0WkWyONSyCjPionh0S3dVd04RCeqoGdnJTvavj+OBTe49jnbp6Hi2El31DBsfafX
	 wgJAu7yOEFYOxHgX9KuCL1xSOCvbQrjUdLNWSmPTr5iYygBPfsvXlIIeU5GdVaDFCL638
	 nNNyXl6H7SAFgqs1vabqbSEWrTFjqfmgzWabcZ71+FaA4AUg+FEugcJpE7RUfHy7kTIH2
	 AZL2+kuom/+Ql3PpE2s44ihGbAYmjo0BugrH/u9Ya9YCj1zN/OCd2h7/qnf/bxkkZpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Unsent:Content-Transfer-Encoding;
	bh=+P6I8duspVIkphkurSdUiF8nhaxikLYjgPI/qnOpQ90=;
	b=3kMywn4Fb4RDELnDLCF0g+g5IwM0ci5kUAmrzowh0ppoqkwGHd9Hs1gdvJtRTBnBIW+E
	 3lfbI3CVeFClPrZuDdBfMt5L6nr6fM4eYPqf/1Ouvns86rc11qgthQjTCvLabKkN+P8lg
	 0VhIzA64coGYmYHxviWwtDPRM4t02Cs6Ufm+Fd5cFTU5xRpuzJ8PZtBV6FnPHl68PGcbk
	 FusLoc7JH7Aldndw3Z0b2CEDzdarWPdZAUKoTt2fYVMCSnR53aC1wa4k7JjEQI69y+SD8
	 eomY9GliUhQvhQc0TWaupV9Q6l4ax1VXfpJ2E6hUlNni1/Hep687wGq9Isver/OBxTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TmAJ8pR8;
	arc=none smtp.remote-ip=74.125.230.201
Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B682606A322
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 20:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B682606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=TmAJ8pR8
Received: by mail-qk2-f9.google.com with SMTP id af79cd13be357-934956d1044so115899185a.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792785778; x=1793390578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+P6I8duspVIkphkurSdUiF8nhaxikLYjgPI/qnOpQ90=;
        b=TmAJ8pR8TcAnppZdDpMb6ouB4qgQBqJNWeQiamMrAcvfqW2akgRerpYovKNNnDP4lT
         On9QZjdzxznvO5K7okBJa3EIy+0dQT2GfXngT4Qnswc+amzxrKq+I5elTm4ClIa9pAZX
         aI7Fpin4aBft/DyyZ+G/zXDPPyZUYCVt2w/VIxDczlpHDn97M+Nz9Ui9uEYz98ArctQg
         ggFd0/230bB5kJ9zM76FEx8ql1O0Csv+w0C/dAGK5KfqhVqyMba6AtR/d582JgdmpZOH
         pKhD9hesP2t0/rL1e+zP2kyOKsz8s7PYeWNu6xB796ehbATkbBMPljRGNhdngYNLHwoY
         268w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785778; x=1793390578;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+P6I8duspVIkphkurSdUiF8nhaxikLYjgPI/qnOpQ90=;
        b=Ikq4uqF2Z3RGbbE9PFmNtNaCK+8KCQH05LLX+HH5XuXYwABV1HymTRPyEJAxkyXvy2
         3ewGa/FRJqC51LsMH2+Sk3TYqj7aH5Thdf1zbSBHgfiz2GbzhopjG3a2hTkV7GHziwCl
         52vPyaksxrN6FpgsQKlgER8QO4IsyAFhtrHnYJgFZCpt/6x4W3ktrNDTkM/KCx78MAyS
         H2z4/v/1YR/GZIPhziTeEHgUiBPOrSnp407l1HL5fJS9FlNhy35sAoRvmV+N5StKm0Ct
         qGh/WdtvzBl9xiCTEbiKPeHsHYG0nuQnekwVpEhC1oykFj0rm7hfjELFniPWhr2i422I
         4YeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzaTxQS3Pg62j2Yrfo3AUXyiI5hx2Qg2UL1uyMaajeWy9k8lhZmPnV6o3tE3kxuTpCraJSRqu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0iQgvfCGbvjYgmIbaCoN2tm0+mY878y89+N1ldXaD5dMSKygN
	7J/ZOTEqtDa1GeqeTITaNXBlRKxtveggLTJ96G1a7l9Wq/g/mz0yRienOGbR+vb0PZ0=
X-Gm-Gg: AYBFou3ZLmWOwQoLqQa7TI6jKcSwgwm2fjHBWUe7BO/O35OcwKcl3Z5/cOfq+gKkM7g
	rP+WcUBceuzK9tF5iCzO436+pFInqYTEr/8QETMa+5oFu+VSLqo8W+K1xBuyHuxBU+M3u4s4jya
	oijWML5uJplR+RRdtZe5eWRUrOagZLpw8eLrOBblTLpFmRGnI7Nn2YQC8RZG3AKNC6DYn0VN9Pz
	y9D9BMhqeEeueB0gjxC2Gw6cGWgDRUNW7GbZGBsbM4A+OK92TD3B+sQqh3ajQAs+KyWqWT5FSKw
	v+F/oO5WknlVsjVwZgPOS8+7X4d+ry4Bx1Vb8VJ7SH5D9hOfnNpLefbYGIs8EtXOel2aG69ys7a
	WXSJL32Fah1z2clQ0f3ARy23RLBrgyBKfz7+sMTrECJXhIDakPlmOSEDeGWhnY0rcSuQMLYMx04
	wNu91/mlNmVB2Cx0LpeTIsjV8RaF3CA8TvuuGrvOQIFqpJr92IYgulVMhucq0rgrBP7GVrgBdoM
	dHfen811N2i+vJI5DbCECiF0CGccBBVfRWA9ToT5WZfYQ7PP4+KGlpaAYM7WX1oFO4I9BbfY2yr
	YfzSomvjaNIoBSgp8b6LC/32/Csc1KKZuoSOLjWKGA==
X-Received: by 2002:a05:620a:4592:b0:93f:38c7:70f9 with SMTP id af79cd13be357-940ef901c2emr18967485a.14.1792785778344;
        Fri, 23 Oct 2026 13:02:58 -0700 (PDT)
Received: from localhost ([2600:4040:2047:3600:ecc7:9b1d:4307:d6a])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9402ee285c0sm102122885a.1.2026.10.23.13.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 13:02:58 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Lee <david.lee@trailofbits.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: sched: prevent scheduling deactivated qdiscs
Date: Fri, 23 Oct 2026 16:02:56 -0400
Message-ID: <20261023194712.package1-20-v2-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Unsent: 1
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

TAPRIO can schedule a deactivated qdisc after some_qdisc_is_busy() has
reported it idle.

Commit 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
made graft deactivation skip queue reset, leaving TAPRIO's timer armed.

A late callback schedules NET_TX softirq work, whose dequeue path can
race the unlocked child-queue reset in taprio_reset(). The same skb can
be queued for deferred freeing by RTNL and dequeued for transmission.
In the reproducer, the TAP reader frees it before __rtnl_unlock() reads
its next pointer. KASAN reports a slab-use-after-free in
__rtnl_unlock+0xa3/0xd0, with a read of size 8 from the freed skb.

Reject deactivated qdiscs in __netif_schedule(). Callers' RCU protection
lets the existing grace period join earlier scheduling calls before the
busy check. Restart nonempty transmit queues on reactivation so suppressed
scheduling does not strand packets.

Fixes: 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/netdev/20260805102514.740834-1-david.lee@trailofbits.com/
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.
Trail of Bits has a reproducer that triggers a KASAN use-after-free
and can share it if needed.


Changes in v2:
- Move the deactivation guard from TAPRIO into __netif_schedule().
- Correct Fixes to 47e8dbb6e763 and narrow the stable range to 7.1+.
- Retest with KASAN and check packet flow and temporary reactivation.

v1: https://lore.kernel.org/netdev/20260805102514.740834-1-david.lee@trailofbits.com/

 net/core/dev.c          | 3 +++
 net/sched/sch_generic.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e7869..bcd2d5197 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3478,6 +3478,9 @@ static void __netif_reschedule(struct Qdisc *q)
 
 void __netif_schedule(struct Qdisc *q)
 {
+	if (unlikely(test_bit(__QDISC_STATE_DEACTIVATED, &q->state)))
+		return;
+
 	/* If q->defer_list is not empty, at least one thread is
 	 * in __dev_xmit_skb() before llist_del_all(&q->defer_list).
 	 * This thread will attempt to run the queue.
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5..bff425a14 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1280,6 +1280,10 @@ static void transition_one_qdisc(struct net_device *dev,
 	if (need_watchdog_p) {
 		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
+
+		/* Resume backlog left by a suppressed schedule while deactivated. */
+		if (!qdisc_is_empty(new_qdisc))
+			netif_schedule_queue(dev_queue);
 	}
 }
 
