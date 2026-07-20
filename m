Received: from mailrelay.tu-berlin.de (mailrelay.tu-berlin.de [130.149.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F22236EB;
	Mon, 20 Jul 2026 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.149.7.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582124; cv=none; b=tCJaxo8VdL6Unf9goZoCvlzzv0sUGIgwc/lWYG+GWzWGqLrsvy008hUIpGb01e6paN6o7/MfJFf8O9yTSUbTREjlq3kkvz0ofDfidMRHpyR+vg9bVVOeNSmVRcjwccL3e8kngBhV9C0Pyn/Ydwdu8YCb5hdvQRfwHqR6g0on6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582124; c=relaxed/simple;
	bh=WxVqK7f0WnYM6l2XP/pR4xbyWlHe9CYvhfQ6aAn+dxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=cqgoqqG5ehWUWhciEOK4TSEvxsavFuvh/5g7JZu8HJ2chxkoPaouoXy+X1ruAc+iVIPiNMey3RHZonPDHqlDjP8xJnZyggLdFScjA7PM1cn9QSBFqV8KAVioqLHO3yrL7q2XQjcD8nLKW/DKvICe8WAr9oScU3vLfwkLdtV5gQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de; spf=pass smtp.mailfrom=tu-berlin.de; dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b=F4vrfrWb; arc=none smtp.client-ip=130.149.7.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-berlin.de header.i=@tu-berlin.de header.b="F4vrfrWb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/relaxed;
  d=tu-berlin.de; s=dkim-tub26; t=1784582120;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=jFz0rBRtd/CDluc+DiH0LYmRaRHZbo1Ob2zqF50rhyQ=;
  b=F4vrfrWbgtf+tRQzDhywP9s7NR+ku7hI5mf/HqEJCAOjoEx48yYjHJ4a
   4Q+DEtsxJ3HhPd4xvDObm+F8tuDDogxEo8dyAYruz25fC3mjRPbaSxI3V
   OpMyiyqD/RXan0g/bCemtQGZS7AeyvpEwxCJaoe7h1hMh7QpttTNwYK2x
   pOceB2b9AxuhosEhsX66tLbWYRYRagwkuW1D0YXDn5bWclus6OSErcOKr
   a597HiUmwp+6UiPlzYqHthV3SB2ua3CN/cBqmwqKjt3enPyGVmbaEOo6Q
   h/HSBuV0+i816VPwD7B1mjCCGfBZQTvqpEarQ87k9LKHkLJxJGAtwkb2z
   w==;
X-CSE-ConnectionGUID: IDiMJWlSRlmWvFyGo81f1w==
X-CSE-MsgGUID: /xtZ2LA5SuyA681WUypZ+Q==
X-IronPort-AV: E=Sophos;i="6.25,175,1779141600"; 
   d="scan'208";a="64541735"
Received: from bulkmail.tu-berlin.de (HELO mail.tu-berlin.de) ([141.23.12.143])
  by mailrelay.tu-berlin.de with ESMTP; 20 Jul 2026 23:15:11 +0200
From: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>
Date: Mon, 20 Jul 2026 23:14:52 +0200
Subject: [PATCH net-next v2] net/sched: sch_cake: skip clearing unused tins
 during rate adjustment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260720-sch_cake-skip-clearing-tins-v2-1-e6a8b0275c73@tu-berlin.de>
X-B4-Tracking: v=1; b=H4sIAMyPXmoC/42OUQqDMBBEryL73S0moKb96j2KFE1W3SpRkigW8
 e6N9gL9HGbmzWzgyTF5uCcbOFrY82ijkJcEdFfZlpBN1CBTmaeFyNHr7qWrntD3PKEeqHJsWwx
 sPaosV0JmKteGIBImRw2vJ/0JlgJaWgOUP8fP9Zt0OOBHtmMfRvc5jyzibPy1uQgUaG6FKkwjU
 y3VI8xYkxvYXuOLct/3L+X15TjlAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784582110; l=3363;
 i=j.koeppeler@tu-berlin.de; s=20260716; h=from:subject:message-id;
 bh=WxVqK7f0WnYM6l2XP/pR4xbyWlHe9CYvhfQ6aAn+dxM=;
 b=D4Wu0aS+EItsdywRf35Vq65lBwdex0RcjmDd+inNHw6Gqsfd2759xtQQZBBnKypAeYZ0wT4TP
 FwxL2XvIyQeB/1rBLgjgtpqi6ypcmVaNZYrJFuN/lI5QIe2n3O5w8P8
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

The clearing loop runs on every rate adjustment from the dequeue path,
clearing (max_tins - cur_tins) tins each time, so the cost grows the
fewer tins the configured mode actually uses. Testing cake_mq over veth
(8 rx/tx queues, 2 Gbit limit) with flent's [1] rrul and tcp_nup tests and
32 TCP upstreams shows a large drop in loaded latency and a throughput
gain, restoring behaviour to pre-15c2715a5264 levels:

  +------------+------+------+-------+-------+---------+
  | kernel     | mode | test |  base |  load |    tput |
  |            |      |      |  (ms) |  (ms) |  (Mbit) |
  +------------+------+------+-------+-------+---------+
  | net-next   | be   | rrul | 0.810 | 11.78 | 1469.67 |
  | net-next   | be   | nup  | 0.637 | 85.71 | 1243.15 |
  | net-next   | ds3  | rrul | 0.397 | 15.28 | 1770.06 |
  | net-next   | ds3  | nup  | 0.351 | 15.98 | 1799.39 |
  +------------+------+------+-------+-------+---------+
  | patched    | be   | rrul | 0.092 |  0.56 | 1873.40 |
  | patched    | be   | nup  | 0.109 |  1.82 | 1869.12 |
  | patched    | ds3  | rrul | 0.097 |  0.98 | 1866.10 |
  | patched    | ds3  | nup  | 0.101 |  0.51 | 1861.79 |
  +------------+------+------+-------+-------+---------+

The same trend holds on real hardware (IPQ8074A, 4 rx/tx queues,
OpenWrt): in besteffort mode the tcp_nup loaded latency drops from
~470 ms to ~4 ms.

[1] https://flent.org

Fixes: 15c2715a5264 ("net/sched: sch_cake: fixup cake_mq rate adjustment for diffserv config")
Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Tested-by: Mike Pham <mikepham4321@gmail.com>
---
Changes in v2:
- added performance data to commit message, no code changes
- Link to v1: https://patch.msgid.link/20260716-sch_cake-skip-clearing-tins-v1-1-d9787df20c28@tu-berlin.de
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

