Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960743;
	b=W1CE7ARYQXOZuR9d04qPnqCz7RUcL4nXSgMkrqIxP+5a6bZeca4Q6aocdsTYCzvJm3rG
	 vSD4BqPsSNTdUsviYd6AkSqeaX618Qza14OakWyLtV0Ad6Y04p0Ekc+2XMF1x1rK5cOTq
	 tHCI7dV3D5ouwIzOHF6wSvw85tdJA9CA+NDQ8WrU9xNfOttF63yWbii3ZC/LDE2TANTd6
	 f5ueztPl2pmLq4CQNlh2iu+fqEqRhcv1jFvZFHo1vW9FNmQx8/38gM1hNown/GT4Y5JMu
	 HnyDvc3IrEo8En//It2BdqNbz54fUF7l7HWKSQsVkr03fRkRc44a7x8Iph0xbUA6/Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960743;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kvAbZ8POjyBo1albdL4gXt6R8mk+DEpx2PC9fIHpDgs=;
	b=cj4pIXGM/4gbcAwMPWcFvPKo1kpSjoFDzAN63DXwUDr1sVqjhjVAZGxvBe0ypWjAeshF
	 dEmduzwJK+r5asFwzmfAeNG8BCD0ppq+x2xgt+PMX8XGgpTzzKqKrCa83bv//71sFEQ3e
	 dBGzv+O5qjyLCWV0YUY1PnuG7KmSZUd5pmEx6tEB0KHAqf5GY2cPsP7IULGSDmH2SDfE8
	 RmgAr8ZHohxs3fWthjNDx8h7RBevjlVMm9PQ4d4MheDQEfiZ79hx/JvI6B3R68ChOvQVV
	 9BO0KzY7ufCaDWA9e3diLoQyGECiIYAaAaBiKyG0pgXS02hM38gK3F48nul1mO1nr7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=WVRp1t9x;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB02606A323;
	Sun, 25 Oct 2026 20:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB02606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=WVRp1t9x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792960736;
	bh=vhDR9J/1JpeYTHTbWM1VhL+Zm3goy3X52PJv5ZSpPPk=;
	h=From:Date:Subject:To:Cc:From;
	b=WVRp1t9xRrndhvdlCSAImgkd0S/E4HCeU2OaxLp/w1gkyzF1Nh+GIXSGOawevAncy
	 HnqG2jJ2k9oD41SdU9OBERegr/YaKDkOlRZUHdTKyXhXgqY+tvf7cBm7wRDdIzJ28N
	 vsowPBBcTEw+SaDLGUONMeVAouslVZaDAjfZeSmo=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id DB13B4046E;
	Sun, 25 Oct 2026 13:38:55 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Sun, 25 Oct 2026 13:38:50 -0700
Subject: [PATCH] net/sched: sch_cake: skip redundant cake_mq rate updates
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-net_sched_sch_cake-v1-1-5165c924a590@gentwo.org>
X-B4-Tracking: v=1; b=H4sIANlo3moC/x2MQQqAIBQFrxJ/nVBKQl0lIkSf9QksNCKQ7p61G
 ZjFTKaEyEg0VJkiLk68hyJtXZFdTVgg2BUn2UjdNrITAeec7Ar3cbZmg4DWnfJO9cppKuER4fn
 +p+P0PC9z1JQ+ZAAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792960735; l=2650;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=vhDR9J/1JpeYTHTbWM1VhL+Zm3goy3X52PJv5ZSpPPk=;
 b=uGvwwimQkYJhYoblrQwkCkNTuJKn/PRjkmo/ldLdraUPoHaoz7KLu1GS2Hw/fqT3QIAlZC7Uh
 U0jV7P0cxmFCr8aaWcJtM9DeewaWfIQwobGo7r1HaUaUA+MK4tW+5J+
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
---
 net/sched/sch_cake.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index aa4043d662c1cc18858d3f9c80f9d9b281f26f72..dd2539cb472087af9a96b74f2ac571eb8b0a8a27 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2052,7 +2052,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		if (num_active_qs > 1)
 			new_rate = div64_u64(new_rate, num_active_qs);
 
-		cake_configure_rates(sch, new_rate, true);
+		if (new_rate != READ_ONCE(q->tins[0].tin_rate_bps))
+			cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active = now;
 		WRITE_ONCE(q->active_queues, num_active_qs);
 	}

---
base-commit: a32e63a613aa80dfdb9acc0a09efab940e96054f
change-id: 20261025-net_sched_sch_cake-e6653fd393d6

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

