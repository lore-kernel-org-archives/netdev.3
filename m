Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254213;
	b=DlvaB3wP/nNeSvq2ZkdtR7xvVcFQrR8JC01jC7iHC/4CljwKwjsowh8Ou7Uu33JEMfnQ
	 4KD4+RDbfA4X6sGK6a9eeqpVeQpjw1G9Ow/WxAcZiQmRFnsYX7SN2SAD24y2wAx6GYJt9
	 v9J0xGeOrrAzkOHm4+Ol1bFcHfYYR06R2Z4g0PcTotNXzDcGNI+Pgty5fLCChkFGs+IQA
	 19HPAHJS0sWFdi2Rl9U1BQ2ml83FITP033BwHOkAiARdygwajNEu9lS8av/7k9u8xsTjp
	 TW3ekUQfO83ceiV5u9WVOzaVMx6R4LV23RG7Uql/aUHWmWwI6WKuxd1A8KyFzK2nlFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254213;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AulTc+7aMDrCASo72l0rDbdbs0JFBylHHohbdkBGPUU=;
	b=dmgkKWH1ClEscNaUEjQ5PhDfZh7o6JSh3ImDYcK+7lY8tpk0g+K2mVF8ZeLpLnLgA5vM
	 G/8TjsFWaO3qytT/sxzBhcU3wo7idfu5XE5UETzg/3uc9eWqy24rS+H5hKsMTmLa6Z+Zn
	 h5gmoCWFar522zLYo8xiBzNL0jMt/GmOzi8cI/AhG40fvsOmKNJLxWCL9kvZgFt6Sm2Nt
	 20oN22a9pLvYha9U35RVH2aHEQZ3Kpd5+lsL41yIxS5PJ9B09wYJtMWvMIjOUVF8cB5/w
	 WkeC5RuXcTec60DEv98bib7eTYAkndCfuiK3DGInX4RaYmWz54uLqW6BG0mg4QvUKEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=pIm4igkS;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CF606A325;
	Mon,  9 Nov 2026 19:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184CF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=pIm4igkS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1794254211;
	bh=bpr7UtPwjBcvbcojcp8LkbSViju1iljgbkaWoE/iLtc=;
	h=From:Date:Subject:To:Cc:From;
	b=pIm4igkSIcvJOA/M+ksCtBgqpE+I+SRacOOeDOnBDpe69UTVqwXqOlfv4WkYQob27
	 0o4XcWFRDeIZnAYUlPEFCfstBioy4SxOIOSRL4VLLbOTmc2eSX+eVOL8V3Oy3bOEop
	 i6HRGZnx0Cc95/oqxrtbSkc+in+7rcKDifbWWpdI=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 0961F402BC;
	Mon, 09 Nov 2026 11:56:51 -0800 (PST)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Mon, 09 Nov 2026 11:56:03 -0800
Subject: [PATCH v3] net/sched: sch_cake: skip redundant cake_mq rate
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
Message-Id: <20261109-cake-sch-cake-v3-v3-1-249ced20a1d4@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAFMl8moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNL3eTE7FTd4uQMCKPMWDct1dw40SApycLSKFkJqK2gKDUtswJsZHR
 sbS0AeRmqXWIAAAA=
X-Change-ID: 20261109-cake-sch-cake-v3-fe73a0bb892c
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794254210; l=2855;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=bpr7UtPwjBcvbcojcp8LkbSViju1iljgbkaWoE/iLtc=;
 b=RATTLGkvkOqitjgxCS6fSZ+BFCz6+Ijz5uutioz6eTknCGYDsVZYBjC2XPPXOJXqQjMa+ssLa
 RplpbfNqMAXCCGLVX2A9cCYefHuGQZPbEVTcIxNByTGjsI/vSuDnddJ
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

Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Tested on an 80-core SMP, non-SMT Ampere Altra system:-

The test used a 32-TX-queue veth pair, with cake_mq bandwidth 2gbit
on the transmit side and the peer in a network namespace. The workload
was:

  iperf3 -c 198.18.0.2 -P 32 -t 30

Against mainline commit a32e63a613aa80, the patched kernel reduced
cake_configure_rates() calls by 99.99% (2,477,627 to 206) and aggregate
helper time by 99.986% (3.477 s to 0.498 ms), while retaining
approximately 1.91 Gbit/s aggregate throughput (baseline:
1.91-1.92 Gbit/s). A separate per-child trace observed no
same-effective-rate calls on the patched kernel (@unchanged: 0).
Changing cake_mq bandwidth from 2Gbit to 1Gbit and back invoked
cake_configure_rates() 64 times, matching all 32 child CAKE qdiscs
updated for each of the two control-plane changes.

Changes in v3:
- Rebased onto current net-next
- Drop the Fixes tag, as this is an optimization rather than a
  regression fix.
- Add Toke Høiland-Jørgensen's Acked-by tag.

Link to v2:
https://lore.kernel.org/r/20261026-net_sched_sch_cake-v2-1-cb1d4e6ed990@gentwo.org
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
base-commit: fa5196392691051963726787944db872420dfa75
change-id: 20261109-cake-sch-cake-v3-fe73a0bb892c

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

