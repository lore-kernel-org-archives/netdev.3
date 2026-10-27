Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793076128;
	b=wgWi+aRKIq1sjpWtuCov3qF69YT0/B82vx/ewflQJRB5rJSJ+FNe80abcvs4RZHKpUFr
	 nosfzmUzsEagIKal6EviTuVW7EWiSb4BonGokq8+GgoxQiih+DvWKqLo0/fb8e8tEZo+h
	 hjdTp8rm3j8DCLOajCjx4EjHuzC8VCwF+jp2cYU1xOMQNxgnXkv63/0WKp5YYkqjuHkxJ
	 EbemQJ9kKIzYsZ6xpOpjBdzc5zPk2+WZLv4UIFix5hs0is+VXgEZBad/ECtF8hy2Hr8Ry
	 9RJlu3QjADNovCsGdgSDOLg7kvFYgQnKlxr6EFUe530ijBGxFm/6+F6ctGApEt/kRXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793076128;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UqKyYrrqVaVWvuABCfIICIVMu/pS61TObzLyZy4KWf0=;
	b=eAOdP42/LgyUyqwzkns7FHDCPunUr5+fxmAeMFuZDTNUVN5omeuAs1GcsANvc7wnQxRt
	 TUxGc0+EiyoNLitkAsiX30SsjLCKYXkoXVY9zxkRRMQ0A+cFIQloplxRqU5baXp56i8YQ
	 gHVy454Vx9LFZjChvVRADhikWQhUfVEi2GpzWjvt4kkpQEdQ32qMelYAtr67iPTYjmQ9W
	 tYBwe4fMmcInTQ+AUIWWBfZlX7hXk/s27EsjIc+CgKZSyMtmAv3bvIWQ1uvGYQSvKi4C9
	 9uPwc9FxzzdLyB2U8uynW7nw0s4yUlCc9nW3ZddKHK4sFU1PQ6CsNwmJrRTZMld+Z0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=BrGIB0Iu;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A6606A31A;
	Tue, 27 Oct 2026 04:42:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C36A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=BrGIB0Iu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1793075568;
	bh=TI6xN8cNHM+PNcaHI3msiigLEKk+1ylQ2+6euVaaNGs=;
	h=From:Date:Subject:To:Cc:From;
	b=BrGIB0IuR3sEm1Df1dXGTMXMm0RJeiE0e2W7KZvAmKVdSnKUMUVlDCB69kEyTCDf4
	 VdZixOD09cp6V70zwLHkBuebZcyI9fZDODNA2OGKrvb2KbLx0gX3pXEgA0gyNxtrkE
	 eafpYABqtSHUKkTWPV6LIGZy1SSDWQS4DWwhUlPw=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 4DF21401B0;
	Mon, 26 Oct 2026 21:32:48 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Mon, 26 Oct 2026 21:32:41 -0700
Subject: [PATCH v2] net/sched: sch_cake: skip redundant cake_mq rate
 updates
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAGgp4GoC/32NWwrDIBREtxLudy0+qmC/uo8QQtAblYIWlbQlu
 PeaLKA/A2dgzuxQMAcscB92yLiFElLswC8DGL9EhyTYzsApV4xySSLWuRiP9sjZLE8kqJQUqxV
 aWAV9+Mq4hs8pHafOPpSa8vf82NjR/tVtjDAimZJG89siNX04jPWdrik7mFprP/L1f9W1AAAA
X-Change-ID: 20261025-net_sched_sch_cake-e6653fd393d6
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793075568; l=2810;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=TI6xN8cNHM+PNcaHI3msiigLEKk+1ylQ2+6euVaaNGs=;
 b=f2wK0okAfLnGSZj7kZ8rNc1SnN0ZQkwxBdtrVNAsLv9k8f/PrNDlLHejBHXW4nlmhXC27eDzo
 fQUVbtzXpotBwqCGHZ97zDrAvjFCTYoi0lx4va4H862EV7a9ivWuhIT
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

cake_mq periodically counts active child qdiscs in cake_dequeue() and
derives an effective per-child shaper rate. cake_dequeue() currently
reconfigures every tin after each scan, even when that effective rate
is unchanged.

The dequeue-time call chain is:

  cake_dequeue()
    -> cake_configure_rates(..., true)
      -> cake_config_*()
        -> cake_set_rate()

With rate_adjust=true, cake_set_rate() only refreshes rate-derived
state. Tin 0 records the unscaled rate argument in every supported
CAKE tin mode, so its installed rate identifies whether this call chain
would change any state.

Skip the reconfiguration when the effective rate is already installed,
while continuing to update the activity-sampling timestamp and
active-queue statistic.

Fixes: 1bddd758bac2 ("net/sched: sch_cake: share shaper state across sub-instances of cake_mq")
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Tested on an 80-core SMP, non-SMT Ampere Altra system (aarch64)
The test used a 32-TX-queue veth pair, with cake_mq
bandwidth 2gbit on the transmit side and the peer in a network
namespace. The workload was:

  iperf3 -c 198.18.0.2 -P 32 -t 30

Validation against mainline commit a32e63a613aa80, the patched kernel
reduced cake_configure_rates() calls by 99.99% (2,477,627 to 206) and
aggregate helper time by 99.986% (3.477 s to 0.498 ms), while retaining
approximately 1.91 Gbit/s aggregate throughput (baseline:
1.91-1.92 Gbit/s). A separate per-child trace observed no
same-effective-rate calls on the patched kernel (@unchanged: 0).
Changing cake_mq bandwidth from 2Gbit to 1Gbit and back invoked
cake_configure_rates() 64 times, matching all 32 child CAKE qdiscs
updated for each of the two control-plane changes.

Changes in v2:
  - Drop READ_ONCE() as suggested by Jonas Köppeler.

Link to v1: https://lore.kernel.org/r/20261025-net_sched_sch_cake-v1-1-5165c924a590@gentwo.org
---
 net/sched/sch_cake.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index aa4043d662c1cc18858d3f9c80f9d9b281f26f72..3faccdbc03f765164e9695a42e4658467183294b 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2052,7 +2052,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		if (num_active_qs > 1)
 			new_rate = div64_u64(new_rate, num_active_qs);
 
-		cake_configure_rates(sch, new_rate, true);
+		if (new_rate != q->tins[0].tin_rate_bps)
+			cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active = now;
 		WRITE_ONCE(q->active_queues, num_active_qs);
 	}

---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261025-net_sched_sch_cake-e6653fd393d6

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

