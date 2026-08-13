Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DC3368B1
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786586755; cv=none; b=C5PHQ3XjTuVihNII1VL1eNHyKytJj+VlWQ3WdjYFo39uKf7NmQIuvc/QLcQKSznZmdOqGzXwWuUP5GOW0MqU+Z4+SHigpGoo6+Eulaa14t0V5PSEFc0yBahtKA1C4fzfcmx7hbKYJ+SHEKrSRCdPAPoJPS7vQs5wNV5ZHZpvsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786586755; c=relaxed/simple;
	bh=hg/r4G9juFK7QZVwVcTQM8qFAi0igIxUQ6KJBINRpw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=perrDHP5S3KYU2NKDiqTyB4I6l4q853Nml9z13B1nRZoIuEAbg/wbTgQRxvNeGewlcv3Z5z1z2COpzx181q+LeA0j9/3AVbjlApku73avF5R9bwpHBXdTE0ysdJgq+fJU7lQXyjnbiNolsbLv4yxyZz9AZpXMJsUebgwryonxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuOn6D4V; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuOn6D4V"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664b05d408bso1623172d50.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786586752; x=1787191552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1ZxhX9+8AzTSZZXqAGOyZ2kfj/c02Sa8vaF0dDcJhU=;
        b=SuOn6D4VAoe+H01/gc8iojukjDNYHg6YqqOIgGojLLDUqMlm0mZIpNp6ic7ndxVDoD
         he/jP8c83YCJ/Vj4CAErWWNNPNTKMRaxdzid9AJfXR+CH0zllLmpSyzBEU78KmxoMDHZ
         1UgxZobgIP9jYyzkL0nb5ed63gLZttN/29a6D0jCcEHL5ZrTjaJfUpega+AYZq1wyoN7
         aRJe5X/inwIqeWakdo0aOteNwRBkMOiGESwWILxIFAPOmD+m875DwMOZyjXSbiFenXPZ
         2CfBm9aKVY1iPgSAtXCAxpGs/OUaAeRP+6EnAQFbaMOtWvR+z7KrOCCPL7SYiIyw3xJp
         Py9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786586752; x=1787191552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S1ZxhX9+8AzTSZZXqAGOyZ2kfj/c02Sa8vaF0dDcJhU=;
        b=dmWtB/E0gMI0Jmtr+H8o3Ae1Bu6iRq7UZO1UmN2aNNXcBnyi73g3jNj9uLMQgYjikM
         kZ4WSZPFbSCbXhODMsSF9rVmg6Q6JY3VAb1LEyQFReIa8imTbKgefJFAHog9MMPVXGUN
         hiiV/LqGRsOsB+TYl1cMOjVc/LTNZBJfNcPGLLdAO2YKD5ZEUYFl/Vkse0bYpAm07AFl
         6ylHmpnFIr+PgtTNfMv1/z6rRTIqb7dz/TnKzqVpyJkl8NmMb+uJ9ZYhcK86EeS2br9C
         Sgxe4uoM9fyb46jmF2lFlAOf6RMdzzaa3Fh+YR393tLeKPoOFgTvy9WbzA7c/cJchyxg
         2Ieg==
X-Gm-Message-State: AOJu0YwZ/OOSJaKm7AVQGs9jT90ntos5OqJOJrGebMuaj26HJBVAoS/S
	ugqA7ChHrnJ6Nvo27wh89zT3OSrwZGEb4DdPE9lMD1oqvQ7c93GLge5exlNIyQ==
X-Gm-Gg: AR+sD13zNtjl8tLD7q7EtZIzpECcbtxqyBbvq5CD9xdyeh8qPXyee54mnZ2I+4n90+F
	HAINFVGTw3TMJC2wOz3F6MQMk2imagSWUEHQ69Kv1PDOBmRkSaDb+V/YZE5QX+05wWtsU1X99Mh
	Ly/wQjVWB6wUMNZ+5mZ1JZxzeIFrV7VwC2kdltvJPy/YD3eJVK5N7s9Sz6AVGbelN/bM5datzYP
	a857LX0a5c7GLrEML3e58LF5QLPSbdF+wIsQIcCsllNU6bLrvKIWShH65lnZ/komig96fFv+CaM
	YVf6tViQsO8QiCuuwk8k+xLJQUQO3SCzdVrpQwsJsi8/oWqL8kvAhHHNGIzyWnyZM2TD/QSLM+Q
	ue7oq+Np2FHaAACOEcbeGEu17hlD7FRa4USrjPc0pyCbjl97KqDwhJMu7XCRsdIjYRRy6n3NmGs
	ae9c1aakCycDbK0uCXdZeuPEID2CjXx9rghHCpFpC3PAAmH4nhDRyiIDF5Cn4khFNWRFNC01ber
	+xdrrPPmKcpJ9/Uoh+B54WEVF96D/4OyIx+yBcNJ4WV9PKms0OELGxGQuHD0FCcfszCyw==
X-Received: by 2002:a05:690e:d0d:b0:668:8e5c:ff98 with SMTP id 956f58d0204a3-66c51539ca2mr1174218d50.23.1786586749415;
        Wed, 12 Aug 2026 19:05:49 -0700 (PDT)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c56e74870sm226899d50.6.2026.08.12.19.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:05:48 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 2/6] net_sched: sch_fq: clear past skb->tstamp if offloading pacing
Date: Wed, 12 Aug 2026 22:03:57 -0400
Message-ID: <20260813020529.3506539-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
In-Reply-To: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
References: <20260813020529.3506539-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

When hardware offload is enabled, FQ will forward packets to the
netdevice for pacing. The device has to test that skb->tstamp is
in the future.

Avoid this cost for packets whose txtime has already passed, by
clearing skb->tstamp.

Also clear slightly into the future, for EDT timestamps that are
so close to now that they fall within a reasonable normal Tx
latency. This slack is set to 400 nsec.

Also disable timer drift logic when offload is enabled, because
time_next_packet can exceed now causing a negative value.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v5 -> v6
    - switch to skb_set_delivery_time to also clear SKB_CLOCK_REALTIME
    - add fq_offload_slack_ns
  v3 -> v4
    - also reset tstamp_type
    - minor: initialize time_next_packet for more obvious correctness

Sashiko, ignore pre-existing issues. In particular, effects on
non-EDT packets and when queue or sk rate limit is set.

Sashiko, pacing offload is an optimization. Ignore that some packets
may not get offloaded, e.g., when txtime is a few usec in the future.

Claude suggests to only clear delivery time in one location
in fq_dequeue. Unfortunately the separate fastpath location is needed
as that avoids computing now in fq_dequeue for these fastpath packets.
---
 net/sched/sch_fq.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index e0f2cd99e3b7..e7730fb04264 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -159,6 +159,9 @@ struct fq_sched_data {
 	u64		stat_allocation_errors;
 };
 
+/* EDT timestamps to clear beyond now. */
+static const int fq_offload_slack_ns = 400;
+
 /* return the i-th 2-bit value ("crumb") */
 static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
 {
@@ -399,6 +402,11 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 		    READ_ONCE(sk->sk_pacing_status) != SK_PACING_FQ)
 			smp_store_release(&sk->sk_pacing_status,
 					  SK_PACING_FQ);
+
+		if (q->offload_horizon &&
+		    fq_skb_cb(skb)->time_to_send <= now + fq_offload_slack_ns)
+			skb_set_delivery_time(skb, 0, 0);
+
 		return &q->internal;
 	}
 
@@ -707,6 +715,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	struct fq_sched_data *q = qdisc_priv(sch);
 	struct fq_perband_flows *pband;
 	struct fq_flow_head *head;
+	u64 time_next_packet = 0;
 	struct sk_buff *skb;
 	struct fq_flow *f;
 	unsigned long rate;
@@ -721,7 +730,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	if (skb) {
 		q->internal.qlen--;
 		fq_dequeue_skb(sch, &q->internal, skb);
-		goto out;
+		return skb;
 	}
 
 	now = ktime_get_ns();
@@ -758,8 +767,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 
 	skb = fq_peek(f);
 	if (skb) {
-		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
-					     f->time_next_packet);
+		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
+					 f->time_next_packet);
 
 		if (now + q->offload_horizon < time_next_packet) {
 			head->first = f->next;
@@ -828,11 +837,16 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		 * f->time_next_packet was set when prior packet was sent,
 		 * and current time (@now) can be too late by tens of us.
 		 */
-		if (f->time_next_packet)
+		if (f->time_next_packet && f->time_next_packet < now)
 			len -= min(len/2, now - f->time_next_packet);
 		f->time_next_packet = now + len;
 	}
+
 out:
+	if (q->offload_horizon &&
+	    time_next_packet && time_next_packet <= now + fq_offload_slack_ns)
+		skb_set_delivery_time(skb, 0, 0);
+
 	return skb;
 }
 
-- 
2.55.0.691.gc56d675ccc-goog

