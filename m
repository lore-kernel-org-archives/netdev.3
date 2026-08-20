Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB793CC7D3
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219870; cv=none; b=akLpRNc4pqoM0/FcR4LT9I5B6njxcEUYd1zGVFMeW8+8KKLXZDoGuLREH1NVEXq8uJPrt1vrda6HG52JlBipM6c1pY2AAhOPNTfcSugfQgWp3QJhcFQoIb90QsvfWF+ChW+3PmlvDg6WjX3EZHgh9g7zpDsUGejrB+KvBfl3CUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219870; c=relaxed/simple;
	bh=U/wixShyu10A4AT9h30/voJvGjaqHe845FsoIYSl9ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QsTUCrTtZ8UXSU/3yF0HhWJHR7xS7Cm+0Ys2+fiiF5iYwQ/ESowu8aIPE+VJwxYtefRDEJXc2aPO5hwDGG6ClomI7SdqVaF3WKGVEhjdAa3Dt+eflX2sqEgR/vM4J0WiJfpJ/Buel9A2UXkyM22adkNaiX3MKSMdjQyg6B1l7PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZOru24Uz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZOru24Uz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c1372f84dso12901991cf.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787219866; x=1787824666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hsCp/I13XrlSV13nvixD/aFZtUTWYd+PouN++96+VBo=;
        b=ZOru24UzSVWvrxNzKwM9yNwv9uquDrWtTMmT9vQ04CMnXOZF98ZDNUTVNWn1Q4aRL1
         PSW++cY2kwX6dhDVnCsbuZdXcXfVP327hb1a59dM2lZgtJLvRpyNGw9oAMl2Jgm4Oain
         HxtQKdmK7hhls2vU5yLSRB7f76Rtk/G9PVJbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219866; x=1787824666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hsCp/I13XrlSV13nvixD/aFZtUTWYd+PouN++96+VBo=;
        b=bo8X0u8YQGg4EKutnEdyBx3ZrqGnIfkTlp99Mi6TbGnTr0MmNbFy/cuXwEUBS5ZOGk
         I1A+5Iqey5SDulHa8P9c/2+o7VPyDPB1OcS/LhXAmqdiYD9ZhO5UP1jcXfruTmeDzFZr
         NwLZjJ/kejWRGSUo5F1VTpG7BGeUY6A0CU4y0lUlTtZR61nbSmZs1hZboU0Z50jPcTWK
         IRO+DeRuLITfBbpkzI2RwmlortvBuQxupxV5NcOeDYNYyEKRcIDWvkmtbzozYV0zHPzQ
         C/Or5bBca+9y/TXiEJboif/buU7enPB+fWkvGhTjG/se2JGFtmL4xb3wyDgb4cD0EL6u
         TggQ==
X-Gm-Message-State: AOJu0YzsrjgBTd4WJMqnmlQiW1h78oR0ma+qgTXoxaJSZ2OFvIucsLzB
	TT2vZs4OFECa7bPv6DcEcG3vYd5HFAijLoYip7P6v9vR9t8IJMcsDt55OJ6O6IyVhUhUKbGR34G
	mIK8I0A==
X-Gm-Gg: AR+sD132TtqMd2Wq5fb0yJ3gMLQzjJQ+CnMp8UXqpEjEny9alPoqMS9O5+8x7BVfOEr
	APClQ8iKgwJTKmBo7FEO7rxqeWdAjzVYCSVexXwevNmw6c65yTa9Y0Iofy+TAyanLoexFCq7v/D
	KK72wdTvY+CzmfamWJmVa4WfOUIMqRiZ84iA9tIxZ1ycJVpi5CR2+JsaUgG7hPdV41tb5YQDQde
	Gcw5l7rQLqO/ea6f6UPzgFNCXcCwZu4/rFrDxvU9QoIydDIvP7vDGCBFozJ2/X2lQg+J/XMi6JG
	H5jOitJb2bU/uwT6Qd1Spfcqq97D0lr8lMKTsPapLIONhHoyTJRD/tTcPM/lOXHLcu0jTI1omIw
	YCOSCh//l3PhcdSq4oVIc+3FK8Ij92g3kIWjHptnKZANmt5D+AIGzFVfmRYJtfJVAwzEuOkQIPX
	GW1LQ+0dPG4pfVGt7MwfquDVPMOJjqeZxJ31h0mIMDSzqM61k96eZZaMwT54ZX/1GqwAsuuS9L3
	vu/DENHrc+Jt82JvlOqE8tzDJdhIfij9cDog0UE74RE6A==
X-Received: by 2002:a05:622a:191c:b0:51b:f640:2a4f with SMTP id d75a77b69052e-52dd57bc618mr109829491cf.4.1787219866550;
        Thu, 20 Aug 2026 02:57:46 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b8164sm34565336d6.48.2026.08.20.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:57:46 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	"Victor Nogueira" <victor@mojatatu.com>
Subject: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account to memcg
Date: Thu, 20 Aug 2026 05:57:41 -0400
Message-Id: <20260820095742.68511-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pfifo_fast_init() and pfifo_fast_change_tx_queue_len() allocate skb
ring arrays sized by dev->tx_queue_len with GFP_KERNEL and no upper
bound. An unprivileged user (via unshare -Urn) can set a huge
tx_queue_len and attach many pfifo_fast qdiscs to exhaust global
memory, causing a system-wide OOM.

Cap the ring size to 65535 (default tx_queue_len is 1000) and use
GFP_KERNEL_ACCOUNT so the allocations are charged to the allocating
process's memory cgroup. A pr_warn_ratelimited is emitted when the
ring size is capped so the user is not silently clamped.

Conditions to recreate the bug:
- CONFIG_NET_SCHED=y, CONFIG_VETH=y, CONFIG_USER_NS=y, CONFIG_NET_NS=y.
- Unprivileged user in a fresh user+net namespace (unshare -Urn).
- Create a veth pair, set tx_queue_len to a huge value (e.g. 500000)
  while the devices are down.
- Attach mq at root, then replace each child queue with pfifo_fast:
    tc qdisc replace dev veth0 root handle 1: mq
    tc qdisc replace dev veth0 parent 1:1 pfifo_fast
    tc qdisc replace dev veth0 parent 1:2 pfifo_fast ...
- Repeat across many veth pairs. Each pfifo_fast allocates 3 skb_array
  rings of tx_queue_len entries (~12MB per qdisc at QLEN=500000).
- On the unfixed kernel this exhausts global memory in ~28 iterations
  on a 2GB guest -> OOM panic. On the fixed kernel the ring is capped
  to 65535 entries (~1.5MB per qdisc) and charged to the memcg.

Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_generic.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf51564..e98fd236afa0 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -910,11 +910,17 @@ static int pfifo_fast_init(struct Qdisc *qdisc, struct nlattr *opt,
 	if (!qlen)
 		return -EINVAL;
 
+	if (qlen > 65535) {
+		pr_warn_ratelimited("pfifo_fast: capping ring size %u to 65535 for dev %s\n",
+				    qlen, qdisc_dev(qdisc)->name);
+		qlen = 65535;
+	}
+
 	for (prio = 0; prio < PFIFO_FAST_BANDS; prio++) {
 		struct skb_array *q = band2list(priv, prio);
 		int err;
 
-		err = skb_array_init(q, qlen, GFP_KERNEL);
+		err = skb_array_init(q, qlen, GFP_KERNEL_ACCOUNT);
 		if (err)
 			return -ENOMEM;
 	}
@@ -957,8 +963,14 @@ static int pfifo_fast_change_tx_queue_len(struct Qdisc *sch,
 		bands[prio] = q;
 	}
 
+	if (new_len > 65535) {
+		pr_warn_ratelimited("pfifo_fast: capping ring size %u to 65535 for dev %s\n",
+				    new_len, qdisc_dev(sch)->name);
+		new_len = 65535;
+	}
+
 	return skb_array_resize_multiple_bh(bands, PFIFO_FAST_BANDS, new_len,
-					    GFP_KERNEL);
+					    GFP_KERNEL_ACCOUNT);
 }
 
 struct Qdisc_ops pfifo_fast_ops __read_mostly = {
-- 
2.43.0

