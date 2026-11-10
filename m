Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321662;
	b=STCPXXSPMX2rBYHVmi3vgZtCUFMT0MfhnV9vXKx9C9ltFqW/n94USRHqzRtdOqeDzUbs
	 klKVfSD/Wok/WTfTMzXY9xj1ijUszOkbpymwTBPQipZuvCa4vTLcm20bt0G+D4CiqKM/1
	 Ntan/mjjHvdHg6kFjyJvNYWKegzoonH4Ev0n8ZPYGM7xaZmt8dBOGyRdhB0fOm8OiX741
	 53Q8Dd0o25K/aqX5QgmQ9/lznQlPX42glEz6UGcSU1mhZNv08WiusXQ0yvZbuMMdQnOuP
	 zgeTXIcz1L6eT8Pf9pCYv1SijSd9+5L9iByRLrNMqAqLDU5XereERYmoJRZrpBABLLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=lapzqioR2DyXNwr/UOmzU98Sg+Q3DwIs7epQeYHrMyw=;
	b=D6gtXd2n1N4A5F4Vzk9Ymjq/QW43CIKwlkdefZXv1YRDHJavAKu07Kl8YXZh7cDMbLQJ
	 HOHsT+oaXjszzFIDwz3wgNfFX7VkTu0PtSYUHaVneAEBrP8jP+6LUtyfy7L5H+n6SBJzd
	 TCnGnuLX5bpWIjYy1RD+K+EEaeyzrAG027kPnoTQDEFJh2qsxQ72ookjyYAo6NVrN8qzQ
	 db9MOMr82+Sl5Jb6UoMapCWavQGs8RDVer68rgcrnwhhisRjXe4q7AqMGhOrGjGhn5mxq
	 7so1bQlrSIoV8EBdylqH1ed12qEWnpBYMUweGWXAqvXI55E6I7bMgaqlU1toXSy6ACg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="Tj/3hH64";
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE2606A337
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BCE2606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Tj/3hH64
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53512cd2f85so22211401cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794321661; x=1794926461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lapzqioR2DyXNwr/UOmzU98Sg+Q3DwIs7epQeYHrMyw=;
        b=Tj/3hH64kOT8oQ9Q39W0Ca5MZuPPw7VODxrWtIVENYOwdM5Qf1gCXn12/Z3exDB/La
         EuGW4nFOGXhGJGnLiwKclUdwDKFCJ2mHuNRvJbQsU5FtWbB4xuuNCww+fArdCT0V8FVe
         LhwiKHgZNGRygZadls86oAajtWxoD7Vt5VuKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321661; x=1794926461;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lapzqioR2DyXNwr/UOmzU98Sg+Q3DwIs7epQeYHrMyw=;
        b=ThFnBX9SyFEcwO9XCrKscyj8ZaQ6tJhe+6aEIm1HxLtMG3kpPs9qHa0WsSdlVafn9+
         Whlpr/VAfLryuPXajagGUL9hTYDL4zHt0ura1DBMtaAQSi8s3CZOCA+zsh6/c/W6tS6y
         FotcZL+2MLSS8aFQ+Xl0QiiAqJ6YYkwPOQElIRmWYMYp33ZXBZJvkiZ+SsOvz8DCa8/J
         Fg87bGdbfOO1QF4sTV0jhbE1OrBpW9q+048LJTlkhZf5p85vrNWp2ceAsHVk+s4H1Unj
         UXuplg2e5AjWsseNN67bh8LSZ1joaUwZRzKvBZvkcjuPjVVdo35JGcEd46Xb6qX1lP4v
         oYCA==
X-Gm-Message-State: APuU4Z/Aj60nfciqJHcptjsfNuCEA2sK0fgWRSROnrfm4EIxiqywK+a8
	P5HTmHBCxejWBrdZJ2ZQ6cZ1hAXulmFxgcemexBEZ0733TssmPrhe8jjMbmsQjiX0LlNWMhYM06
	c+8k=
X-Gm-Gg: AYBFou15bdOm6vUWoJfKMT2EBDhb1Pu8Th3jSPRpjx2ugynxFaWA0rxjMPFDB3Jk1zD
	75A6qYu6irXcDAugKPmR9FKm9kUpLXchbGmTAwMriKCnlHVtwmi7n2kS6bQThEm8vaWj69s+uFT
	5N3Omh3CEgFGafpd8ucf5NwnSeEDN8cCj4YsVWqGx766QBncTTZfJF7w5P6WX+sEE/tnX3QsbzH
	oKmxNpzNSFWisSfO/f5dZezROa750YL/Sb/y4pspxmuWwDXGIdwmgqAkNsXu83NXiROOZtTzVZE
	GAb8bq9ixTJAFEyOUXgRUQ/FE/VsODloeqDmMw04E9zueOiUSEwenCEjg93QE5n4fCTA1VU1bxF
	Yf2KJZz2r4ABZd/JWaXRlwcU8X5GuN3UtV1XeIWViWrybg/0Ut2v1vQvurTZBzNh+sVOhS7fFrJ
	t+6CcREqtLS5QiUuqX/pis12+b9MNhRxggJ0KqwpyGgbVNCbce66UvIBBHduWzkT2x1rrlJbzGu
	HiH4MKSUpVlUJdOHR7drAIB9usf2aesIfhmfh9Q/P1ZUr7wL40SDNTS+3nB5gG8/WBFQt2QZF7x
	NlXSPhNXTMQUK2kKQfpj8aqAi0fMgDl/AQsT6DgVoGEI4ntzCANrRSZW2rxdXq0W/du0qzj3Rwt
	eQBELcXwulb6j33bEOhAx
X-Received: by 2002:a05:622a:90f:b0:533:84a0:661e with SMTP id d75a77b69052e-555282fbb33mr42370761cf.27.1794321661233;
        Tue, 10 Nov 2026 06:41:01 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f00f6eb88sm1679276d6.39.2026.11.10.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:41:00 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v9 1/4] net/sched: cake: return the classifier result to the caller
Date: Tue, 10 Nov 2026 09:40:52 -0500
Message-Id: <QDISC-BA27.v9.r0.20261108195325-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
References: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
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
Content-Transfer-Encoding: 8bit

Preparation:
cake runs an optional external classifier from its enqueue path and then
computes the flow hash inside the helper. Have the helper return the
filter's overrides instead, so the caller owns the flow selection.

This is preparation for the accounting changes that follow. Packet
classification and flow selection are unchanged.

Link: https://lore.kernel.org/netdev/179269577009.3135.5221412623031392098@kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v8 -> v9: reword the opening heading: this patch is preparation, not a
fix; and the classifier helper's comments now say the caller must drop
the skb, since a terminal action does not take ownership of it.
(Sashiko nipa reviews of v7 and v8)
---
 net/sched/sch_cake.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index aa4043d662c1..67cb4cbda1c7 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1715,18 +1715,25 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 	return &qd->tins[tin];
 }
 
-static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
-			 struct sk_buff *skb, int flow_mode, int *qerr)
+/* Run the qdisc's optional external classifier. Returns true when a
+ * terminal TC action wants the packet dropped, with the reason in *qerr;
+ * the caller must drop the skb. Otherwise *flow and *host hold the
+ * filter's overrides (0 if none).
+ */
+static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
+			      u16 *flow, u16 *host, int *qerr)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct tcf_proto *filter;
 	struct tcf_result res;
-	u16 flow = 0, host = 0;
 	int result;
 
+	*flow = 0;
+	*host = 0;
+
 	filter = rcu_dereference_bh(q->filter_list);
 	if (!filter)
-		goto hash;
+		return false;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify_qdisc(skb, filter, &res, false);
@@ -1740,17 +1747,15 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
 		case TC_ACT_SHOT:
-			return 0;
+			return true;
 		}
 #endif
 		if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
-			flow = TC_H_MIN(res.classid);
+			*flow = TC_H_MIN(res.classid);
 		if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
-			host = TC_H_MAJ(res.classid) >> 16;
+			*host = TC_H_MAJ(res.classid) >> 16;
 	}
-hash:
-	*t = cake_select_tin(sch, skb);
-	return cake_hash(*t, skb, flow_mode, flow, host) + 1;
+	return false;
 }
 
 static void cake_reconfigure(struct Qdisc *sch);
@@ -1761,20 +1766,25 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
 	struct cake_sched_data *q = qdisc_priv(sch);
 	int len = qdisc_pkt_len(skb), ret;
+	u16 flow_override, host_override;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
 	bool same_flow = false;
 
-	/* choose flow to insert into */
-	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
-	if (idx == 0) {
+	/* Classify first: a terminal verdict means do not enqueue. */
+	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+
+	/* choose flow to insert into */
+	b = cake_select_tin(sch, skb);
+	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
+			host_override) + 1;
 	tin = (u32)(b - q->tins);
 	idx--;
 	flow = &b->flows[idx];
-- 
2.43.0

