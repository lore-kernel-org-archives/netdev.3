Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8B30E84F;
	Thu, 16 Jul 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235701; cv=none; b=OVHLBD4s6SYFj0MVAOwNihvW7ofzd/B+tcO3EH/Ll09Stp9dOV3qHZYJPg3K/sDUBKZDEDaH8NF0hJZlyWJWwwYlBjuxfz5AZnQYExsk6TlYlXjNj2HgDg/8oxNbukq6lgzw5HCywAhnqMBV0UWdyYk2c6K2/WrvP4B79TgGtpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235701; c=relaxed/simple;
	bh=JqBxtipV9nCcLti9gGLdublE1c4tRouunvpT81RvG9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qp66HoQaPOdFWP1F9Gbuuy4+di5yvvkThQ8yYLfjVW4cSjYFdFFiXYqIsVAI4yYB/OE9kTNKZv1brIYnEEATPJgKkQKjvpamMlb9OlGKf1U8fhaUJo+zoQH9a8QJLP49j2cBa0TTntSa45qjDPDhSEbO6zm/HjhimRlMWJ+zsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=St5+GpZS; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="St5+GpZS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1784235698;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=4DQ9VPaSq78GhJMbvMtbs+WDO5JcO2vEYQLjBUA18os=;
  b=St5+GpZSWGYweWH2bZQFygiU2o3xJJPaGZYFzpQfQezoQve4WD/9x798
   6nm+uAaVQplMP3rzz7V4uKyaDg2xbJXjq5PAM9YTK9oDv0CJWaRtj3aUX
   e/7t1/0i4CkOMDoH+ccGsvX1vH20591Du+ZgRTsIuW6PUVZIymycXC06B
   mIENH5y+0SAxbWmveDK4tHvidDLWV23QUABlNtAqoZBDGvo84s9qhHQib
   3NPegPXbOWy6jEZRty5BnQmPRDnNe2qeVo3TFfS5pQT4ogWWeKl2FPpeV
   DCs4QP+o1MjUvMrAxDfKuqEG4GOCrd1LC9y5CYoHi31hAlFm0nt1UXkgp
   g==;
X-CSE-ConnectionGUID: RlLQaKWPQPCcHej6PzKgFA==
X-CSE-MsgGUID: 7EZ/1NOQRZSi9qa5HoGMuA==
X-IronPort-AV: E=Sophos;i="6.25,168,1779141600"; 
   d="scan'208";a="64414930"
Received: from mail.tu-berlin.de ([141.23.12.141])
  by mailrelay.tu-berlin.de with ESMTP; 16 Jul 2026 23:00:25 +0200
From: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Date: Thu, 16 Jul 2026 22:59:47 +0200
Subject: [PATCH net-next] net/sched: sch_cake: skip clearing unused tins
 during rate adjustment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260716-sch_cake-skip-clearing-tins-v1-1-d9787df20c28@tu-berlin.de>
X-B4-Tracking: v=1; b=H4sIAEJGWWoC/yXM0QrCMAxA0V8ZeTawFlaLvyIiNYtbnMTRdDIY+
 3erPl4unA2Ms7DBqdkg81tMXlrDHRqgMenAKH1t8K0P7dEFNBqvlCZGm2RGenLKogMWUcPYheh
 8FwP1DFWYM99l/elnUC6ovBa4/I8ttwdT+eKw7x8QnUUeiQAAAA==
X-Change-ID: 20260716-sch_cake-skip-clearing-tins-856812586cde
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <cake@lists.bufferbloat.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, =?utf-8?q?Jonas_K=C3=B6ppeler?=
	<j.koeppeler@tu-berlin.de>, Mike Pham <mikepham4321@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784235624; l=1759;
 i=j.koeppeler@tu-berlin.de; s=20260716; h=from:subject:message-id;
 bh=JqBxtipV9nCcLti9gGLdublE1c4tRouunvpT81RvG9Y=;
 b=5dm5ZXEjqLKU4ygiNJTjMo1lkIE4x3Wvw6cznsNK2Sf2FLWk/OMzYflOTxJonhxVFDT+Zpbwt
 lrmRMXrbpe2BSoyJpnv5amIEWA9Unmi7l6VKEdlEWF0uBvjuX0q5fZ4
X-Developer-Key: i=j.koeppeler@tu-berlin.de; a=ed25519;
 pk=gCux0rX5l27ZRzRDqTc0LtoO66uPAXTt/SX1DzcQoBk=

When cake_configure_rates() is called from the dequeue path with
rate_adjust=true, it only needs to update the rate parameters. The
loop that clears the unused tins is both unnecessary and harmful in
this path:

 - cake_clear_tin() overwrites q->cur_tin and q->cur_flow, which are
   actively used by cake_dequeue(), corrupting the dequeue state.
 - iterating over the unused tins and their internal queues to purge
   packets adds needless overhead to the hot path.

Skip the entire loop when rate_adjust is set, as neither
cake_clear_tin() nor the mtu_time update are needed when only the
rate changes.

Fixes: 15c2715a5264 ("net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv config")
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Tested-by: Mike Pham <mikepham4321@gmail.com>
---
 net/sched/sch_cake.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index f78f8e950776..845e1c017714 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2609,9 +2609,11 @@ static void cake_configure_rates(struct Qdisc *sch, u64 rate, bool rate_adjust)
 		break;
 	}
 
-	for (c = qd->tin_cnt; c < CAKE_MAX_TINS; c++) {
-		cake_clear_tin(sch, c);
-		qd->tins[c].cparams.mtu_time = qd->tins[ft].cparams.mtu_time;
+	if (!rate_adjust) {
+		for (c = qd->tin_cnt; c < CAKE_MAX_TINS; c++) {
+			cake_clear_tin(sch, c);
+			qd->tins[c].cparams.mtu_time = qd->tins[ft].cparams.mtu_time;
+		}
 	}
 
 	qd->rate_ns   = qd->tins[ft].tin_rate_ns;

---
base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
change-id: 20260716-sch_cake-skip-clearing-tins-856812586cde

Best regards,
--  
Jonas Köppeler <j.koeppeler@tu-berlin.de>

