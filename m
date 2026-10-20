Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515460;
	b=WxVK3KhonvXxXYStQzNDqo2I+4vKelhcJb2XLO9nobp58vQC2Lo9L+PyGJnYJ9Kcl+1l
	 Ua3SXI4GxUKtk+7mW4wa6odYERDYUAIURegk2e8fN9UqYU/lBn+8ejO/2fPwl1nmM/o7p
	 28jdXygsYEw6lm1y98uq96E9YKsMGYQULkEuwbSsENoLlf++b6s6g+jpDhrQnnLuafWuw
	 rYaXA5T8DNFUboretakZ2Jbt5oFO6+TLqoNxzAAT3qn4ZWej0svGgBySNDX3G7Kr259GF
	 SAbK6h6sCsi6KnWCkhZ/VdwNG003qVV40mTES7uGf0rzoiSrr02FNWL855fM/6i5zVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OLNQJwDVyvERst+Yg4jAyoV+SS5hTnZCgYBGqPPDnM8=;
	b=Gnyz+Wmq7LHK6IEn7WUMzfHPcYGebS/HIfheGUG1RCDvRC5gVhxx8QMM+0xOOZn8o7dL
	 0KWZA3/EDeTsQ1QtJpov0P5bFldNLuKFHB8Urrw4CtJhcRm11/E68ocYod5Uz758/LWHJ
	 0eW8f1mK0+Lr6mxZPLUTnKpFQ7vHDvDweiPkLOnFylQGcDuTHNr873/ouhkvZfCipjBok
	 u7uHmelo+9fvAU5IeYHHON1e+gTYX7qOKAvocWd3sDK0logdNvqzMdXcwCG6DE9gPpUU0
	 tqMEzRvQQOqUhbhzIxtgGkOq7mscA9+Kw4DiYhIA0RqE5V9wk/7jUnZkFnlmtNj9dIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ozPOG1j6;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D5606A337
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C99D5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ozPOG1j6
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917b78dfe30so51116966d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792515459; x=1793120259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLNQJwDVyvERst+Yg4jAyoV+SS5hTnZCgYBGqPPDnM8=;
        b=ozPOG1j6sEBDt7UJ80aDj0sQoLlC4qUY0VAytGrgpUvIgcYPGdx4LYSQa3meqgs1Wz
         DX7CSsMRoqtROgLiQbtfsqCNfF1toYxVuG+NaVthm+hHdiVR2hf3uTZG3vzlaPmwOYgL
         dXoc3rRdvjEIuk5oepyiNO9tvl2al6gMftbR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515459; x=1793120259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLNQJwDVyvERst+Yg4jAyoV+SS5hTnZCgYBGqPPDnM8=;
        b=HcP9HEnNNQHjUpsoKDwLkGExdusP2CXmoXKvLog+C4shNjU2USLXH5jtHczitgTafg
         oRrgqmlV/8JYxy12QIiREWKA650ED0LOpj657fh0Zp6ZFhqltJvaCOSh6lIToi4kh8Jy
         pyLsYK1KaZl06gqvaPHn1QKu4CBfMyW5KswyhL7BelYoydCVBOMo6RQ8a0vnfQ0z2mM3
         NoBf+AwEMuqGSKQ3RNxW17ELtfP7ry6cidVHVnEmPYz6eoNg9STUK/xgrJLrBRaoF4ZA
         N8+ZyD8D8ClPtTRTp5c890xozvDPKWRDS8x6mp2SjhWRsxRs6N+5HETo2Fo5MiiPaNmn
         cMdw==
X-Gm-Message-State: AFq9FYLxnEHUwiCSZ+1JwXU2F4USg5U2cutFDYi1//vbOmN68gi6QpQb
	giAx19wchzeUWmGD80n+jGXaJ9EBtCJ2jmHZrbNgpAImeytl1wVW33RenifihxAIhykQxAAJkc1
	keIM=
X-Gm-Gg: AYBFou0GvGdWsVWl/oxXSHp5A9b3R0k4+LX6LWGrKu0G9E0kPk/YK/FJXI69fvGjZ1v
	99sUBPV4WjThvYGnJYaz9Eacl/ZB/fdrBxHZqiLB9mQ8Tr9zBgOAds9BTIkuTiJ7/CzhwhomPMK
	zPuTLAOYO/XmuAkMTHs9chRSySsOhS21fMmwMw7wzK/eHiEVk+7+pY4OuVnNTnwM55ta2n7dW6X
	+0NThTE8MnnNkK5i0QtURiWAzgjEbMuDiAQ9q4lMtzRurbnnQVtnv2EhczRGFw/n+tcaz6LRDVR
	CoaiBc72fA1XSp5fcFZBhuAy7gnigw8pN4QrVR1oslJMITJ987oaRDJq17OO9oJYG8ikMs1SEuh
	NGxg3/gzUjRNhT5VevTAdJIOLzSvNIQyXrHzEWBoOqSAntf3OAiE3olKYh8ZCYvzLBanNGIofnW
	WRjRse+EiRbPW1YZ/HNBZrLbQC+cx7ZBrwaCAoxWt4HGpaauqmEsA8p4PFyoqAb8u+HrGoEABG3
	aRMx/sj2lg/lQrJ0VTkVyvy60soD5A9WJRILP1Hfd0q
X-Received: by 2002:a05:620a:288a:b0:93e:5ef8:c794 with SMTP id af79cd13be357-93f29d1d050mr1971032285a.38.1792515458660;
        Tue, 20 Oct 2026 09:57:38 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a441acsm3034586d6.6.2026.10.20.09.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:57:38 -0700 (PDT)
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
Subject: [PATCH net-next v8 2/4] net/sched: cake: use a dedicated split-GSO list iterator
Date: Tue, 20 Oct 2026 12:57:28 -0400
Message-Id: <QDISC-BA27.v8.r0.20261020063241-2@mojatatu.com>
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
Content-Transfer-Encoding: 8bit

skb_list_walk_safe(segs, segs, nskb) reuses the list head as the walk
cursor, so segs no longer names the segment list once the walk finishes.
Use a separate seg cursor to keep the head and the walker distinct. No
behaviour change.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_cake.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 6432d10c992e..0d13c4b0bfe3 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1810,7 +1810,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		WRITE_ONCE(b->max_skblen, len);
 
 	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-		struct sk_buff *segs, *nskb;
+		struct sk_buff *segs, *nskb, *seg;
 		netdev_features_t features = netif_skb_features(skb);
 		unsigned int slen = 0, numsegs = 0;
 
@@ -1818,19 +1818,19 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (IS_ERR_OR_NULL(segs))
 			return qdisc_drop(skb, sch, to_free);
 
-		skb_list_walk_safe(segs, segs, nskb) {
-			skb_mark_not_on_list(segs);
-			qdisc_skb_cb(segs)->pkt_len = segs->len;
-			qdisc_skb_cb(segs)->pkt_segs = 1;
-			cobalt_set_enqueue_time(segs, now);
-			get_cobalt_cb(segs)->adjusted_len = cake_overhead(q,
-									  segs);
-			flow_queue_add(flow, segs);
+		skb_list_walk_safe(segs, seg, nskb) {
+			skb_mark_not_on_list(seg);
+			qdisc_skb_cb(seg)->pkt_len = seg->len;
+			qdisc_skb_cb(seg)->pkt_segs = 1;
+			cobalt_set_enqueue_time(seg, now);
+			get_cobalt_cb(seg)->adjusted_len = cake_overhead(q,
+									 seg);
+			flow_queue_add(flow, seg);
 
 			qdisc_qlen_inc(sch);
 			numsegs++;
-			slen += segs->len;
-			q->buffer_used += segs->truesize;
+			q->buffer_used += seg->truesize;
+			slen += seg->len;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
-- 
2.43.0

