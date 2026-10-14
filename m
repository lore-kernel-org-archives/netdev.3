Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667C4E2344
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971743; cv=none; b=bb39+OUhTKpV1sQpeMKAFy7XNNWrpdp2Un3alFiHnCy4gg/0EtESJL5n+TYebI3aF1Xef3I9fEZveixmHGM8ULW52ruYm1qZ3RgMPY51qAdA0xew8dmth+VPTsup8R+nZMX8TB7rwdBgLXB+yekUyZUpXEee7ZxQKLcvubimtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971743; c=relaxed/simple;
	bh=FzrMW41Ik6aaUus7vfg5n0tcth4UjN4Ng2jAlODng9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oFUM7fCGX4+K5/0kOzVqMgkAja2IsGUHEc09MPeDM2K6R9SV8SsAQJKoRMrleGsuRDyWxUkvq71IDrfRBrzXEFAeFt1qNeUhsFUzwpuKxq0bFCn+kRXwtIN+b0oLVsrcBRgAj+lnIdPLAxSPj0LEqi3wSZTvIPj23UkNumbt5sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=N1ZcPLTb; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="N1ZcPLTb"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e5f819884so14652485a.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791971741; x=1792576541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Tl8jhcy/Tz5PdUSPZNxGbL9+G5WZrnWW+i9/q1nR7g=;
        b=N1ZcPLTbC6nCh3jjHMcDrlEiPFAbxHoym8PyVk2MltER3zMFIZPP7eEkBhtp+JUBzZ
         yd06voh5Z+59CgO2eX+gj2LxOO8LzPUPCHS//hyQk/R6noCDhVLWXzYs9NJ5rbhg+3Fg
         /1G1NDnYb8XYW48wY99X/v1YRCJXFn4uWNId4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971741; x=1792576541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Tl8jhcy/Tz5PdUSPZNxGbL9+G5WZrnWW+i9/q1nR7g=;
        b=BJybYUIlOQ3S50F9nAwYQdYrJvckKyBcklxgZyDNXcRTIFEyNfsezQCPRkFiZn6AmM
         DMBUTLgNfsTBQcOoqqMJW2Sb18tLTr3PdWHtKDDDMYTALHMImn/HNHZNIbrbQaZkEOdr
         nECD7F06avCBK+rP1ErwwmbohU+1pTQ6PAjpaDEFGJoM8WHzEgoMe3eK0gDPJ0/uG9CJ
         AoGpyqIb7JRQCUmy6KZA2HmHeVILutI1aHyVTuMcsJsxjN2B2NWKZF7oHGlR1aErIiPR
         f1j9DlWHnnAol5H5EYcrm+TZ3hHUULX8nhvyb/DuycLgc5ufxYniW+Gu2tSpzuVBqAS/
         SoAA==
X-Gm-Message-State: AFq9FYIXff52IxqkfmNSSzT0FDIbByqlx3ggjJu4kD9W+1XHpVkApBp4
	HNtlEd9zKUG7NE28D3tNDo0SgkGdIztfFQ6syh0S/Eiq7qeWye0ViIJMaicZJ58J3roEO/C4zHj
	/BMc=
X-Gm-Gg: AYBFou2IMeLbx8wZgcyj1/hgqvM3qLlwQ6GvX5kdd8tnlcbZDJA1dOH2lWKRw0W+BtW
	TjZGrjzFSVt8qAD264uJOWRu7Swvyq58BtlS2pcACNkWfMNfob7KQdlgQouj7mtWYJKUs24V5LZ
	60jPpDXVHSUgjkBpMOPWbpFg0sqPyfxkhGRf82/i8gg2aYS3mF1INoW1q64ndlMGtqFYf9ylRDJ
	uozGwq25Cgz4/HfTYBjQiiP6Q9+H8wjHNX1q4rvxf8U0bFJqqr5llIGKFHM9m5wVJiNPLgYCjkd
	Oe5UGsnErbN3x783BEo5woUhxL5V3fHGupxndYOFAJg0b4kwkTfK4zYwp89quyDz0C3E659cYxZ
	n2G+ZKwVFVo3dBsP2yNdbfLibl6n2XscDd5mGKdez33A7FUzB9z2MB6g/fN1Yt6cbE26In1saDM
	nzEEcOXmOeov8S7pQ3x+y+ijk5o6n/heeJ8n7EyZkLPQLhCik0X63QdZ5bLw5FDixtAjzGbLKJS
	aeYjgkvl5ezADDD9JadeYxJGJSapsmDavM6Va6hvIl0MWL/xpdCCGNqsGCL
X-Received: by 2002:a05:620a:6496:b0:93e:c12c:9b6d with SMTP id af79cd13be357-93ec12c9ee5mr2462767785a.72.1791971741042;
        Wed, 14 Oct 2026 02:55:41 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5055eb3sm453074985a.33.2026.10.14.02.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:55:39 -0700 (PDT)
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
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v6 2/4] net/sched: cake: use a dedicated split-GSO list iterator
Date: Wed, 14 Oct 2026 05:55:30 -0400
Message-Id: <QDISC-BA27.v6.r0.20261014054826-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v6.r0.20261014054826@mojatatu.com>
References: <QDISC-BA27.v6.r0.20261014054826@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_list_walk_safe(segs, segs, nskb) reuses the list head as the walk
cursor, so segs no longer names the segment list once the walk finishes.
Use a separate seg cursor to keep the head and the walker distinct. No
behaviour change.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v5 -> v6: split out of the single v5 patch; no code change.
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

