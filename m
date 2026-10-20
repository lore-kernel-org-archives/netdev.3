Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515458;
	b=EYwwsELVXgU6EGu3nCHPI506TnMGQQTmnEta6oX/+n9ZGAttkIvsOQnp3gO+Z77FQz3s
	 9xkOIdd1iTfTCCYLIm8N2+Y5Ia9AfL3Xn4zQUKdz99/9FHTZevkFrIIzBtixp6487EEaz
	 ZG2oHr4wH+WsVMMa85EScmexgHKjSUrQsoIvP+l23QEfHvGin5K50IHfRqo20mIClVXU4
	 pdjhyRShJdi/YO7KdZcXZPm4NGrZv3N8nEFsoYY861vjuooyA1f3eU9DjtRs5cCgIGwTb
	 D6PLYxa1m3CYqKgfMxWW/M+4VaOrQuBENdYt9bXWXXhDAr6YbFsp0S5wU3p2SIUKNEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=oiEarQC/3fEvRro+vt5Fbtv4PiJvM7a5NbeSJuclpMQ=;
	b=eUiJWYyuVVRa5CTvcyG9sDBPXzv9Ll2yPb5VFk+vUNsryYeDv9VNUOVTs1uzm1jPy5v2
	 oev/IZY0y1k+VtXjAww0e9Fb7AEEMNitZl/3xBqX7Y6xA6zBlZ6ZSIWXMuDfJAxeFYEIP
	 LjkyK7HILkZKOEOfhQfnU1Mlpe7Cwxjk4H62wCh714uGP/F8wBX0R9xcvrA5qrWEPGaGB
	 KjUyBR1VIw/Cy/0PrgPGglht9Vdr9UNiwnMDs3fqcywMAIxBvI/QGoK4BZ7OzvvnZLgdG
	 eFzUfh4NcTFaODRDroUi/tKLLQ2u3POYbPzNrSM3nEpb3cEjZMw+uYqmcU4jpdxZssg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="mCxvhGr/";
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39046606A329
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39046606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mCxvhGr/
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9196d8543cbso31804046d6.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792515457; x=1793120257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oiEarQC/3fEvRro+vt5Fbtv4PiJvM7a5NbeSJuclpMQ=;
        b=mCxvhGr/938gvaUECdZti4bCEWBol+UANFu07SOQLavfr9+j8GNq+EHq+L0uGO6N8T
         GzRfMcX3hJuh20eMiyKNv9tycUiPl+q1YoLE8xuvBCFMDCGNnTRPqshXnjzuS46Neu5N
         K30mXOU+fy6KGOgvNUDihATATIFk4M0S8HfE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515457; x=1793120257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiEarQC/3fEvRro+vt5Fbtv4PiJvM7a5NbeSJuclpMQ=;
        b=mPrZhIkNGwFkZSJ7wZO2FsBHT1APh6DxDcDqBZPvnN76ik2qm4own0IgmGCnJcipaB
         ds3cAfWYT/MQT+JTjoE5ZlSMuqIqyEXVp7rRnZhZn2Pe/P65x8dat2DIi74f8WulaCnC
         w4fLVuJoRQH/xIxgWxw7Z8HolGKA3dNB+Bjj8C1PFF5xV9LpnjI6zItzv/Hw9OUgTSnH
         9IM61P8JV6PO/UiyS4/6b53XpyWowKay4wlNlX3b+3yFaM5gjkbXrzuWFJT/izsBJavs
         lwXjNKGNnh3jmqhZ5cp2gz98LHUy5I2zcQXga44ecGTYrLkgDDvPeQD64Kcw5QsoV/XL
         sE5Q==
X-Gm-Message-State: AFq9FYIF2mwSLA5Of33Cm/CoZ31SX9pVBYbfRjF+QioZKOyzodA3rGlt
	fzvlBN93rFhjucXH29lhM0vShVvhj9BtmW07XSIELy5hEwBRScC60O4oqWwL4a9kvem0wa0Zgem
	M2EM=
X-Gm-Gg: AYBFou2AS2xibNUMvE8+ZqyBXcMqA6H+f3iMfYtdmnktF64fHoeaIPkGOdI4mOtwnVs
	OjnkIrTF3V59n7SJ16487Hj30NZWYKB4JMw37vq1hHGsCFXIJo1hop6CNQmqY7CghPjo/W4drYJ
	Tlh+ZkS0flNviui9dHfNLRNcbTDSxUyLnUq571mB+WEk9CSH5O/9p5Ks+/yGwS86xaoI6YjKcrA
	/HRkh/W9S4GuQJKQ/sO3q5Vs5NSMaAQJPH/Ac+zQvw+yihl9cuqWqKy1VpWnyNzIc1jTkEtoQcM
	pjjmO0qLDQ066DzjUdkU96JQeRlGQdr14oExvpQCXKtLe5uArgquvGNk+Wi+nG6RbmC+OPP020v
	CJHN9jIUO2a3PATpMXDKHk6w7ILD2DIIQspi3HyhV4UvdkwF25/gyKwvJXXWyuhmOp/lZS4Rmp7
	Bf122zqvH6h6okMW5tdAzwGaQxT+/cyerZZfQG/yiPOjILHM5SbrMWwZUvop0sKZTJ+044gDcl8
	BtfnyM5kpRCZmo2Epeu1hromDNLoU3rl6pofyoEXDYadWkY42ZNe+w=
X-Received: by 2002:a05:6214:43c7:b0:915:e85d:8831 with SMTP id 6a1803df08f44-91bde91dbeamr174802326d6.0.1792515457017;
        Tue, 20 Oct 2026 09:57:37 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a441acsm3034586d6.6.2026.10.20.09.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:57:36 -0700 (PDT)
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
Subject: [PATCH net-next v8 1/4] net/sched: cake: return the classifier result to the caller
Date: Tue, 20 Oct 2026 12:57:27 -0400
Message-Id: <QDISC-BA27.v8.r0.20261020063241-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com>
References: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com>
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

The Fix:
cake runs an optional external classifier from its enqueue path and then
computes the flow hash inside the helper. Have the helper return the
filter's overrides instead, so the caller owns the flow selection.

This is preparation for the accounting changes that follow. Packet
classification and flow selection are unchanged.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v7 -> v8: cake-only.  fq_codel_classify() is line-for-line the same as
fq_pie_classify() and fq_pie is not changed by this series, so fq_codel
keeps its original classify shape; the fq_codel backlog guard is placed
inline in sch_fq_codel.c in 0003 instead.  (Toke Høiland-Jørgensen, v7
review)
---
 net/sched/sch_cake.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..6432d10c992e 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1712,18 +1712,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 	return &qd->tins[tin];
 }
 
-static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
-			 struct sk_buff *skb, int flow_mode, int *qerr)
+/* Run the qdisc's optional external classifier. Returns true when a
+ * terminal TC action consumed the packet, with the reason in *qerr;
+ * otherwise *flow and *host hold the filter's overrides (0 if none).
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
@@ -1737,17 +1743,15 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
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
@@ -1758,20 +1762,25 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
+	/* Classify first: a terminal TC action consumes the packet. */
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

