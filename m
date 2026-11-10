Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321664;
	b=m0vrgujte4wzoWR9io1ndh0aTDx4SPTiNoD3EAE0k/yBQbbngwO1IYXvMGK7GJtcFJol
	 +hMEezD0A0ECr87u64bmtrzzCAsf94EjlQLtRQE18HANSrgokEHtynLJquiZsFK42psHW
	 EW+21k7vedxD8XBRC2Bw7fwZcqCYIbQRVBKhALtBPP2qDgpj0bbLK2IIJ40rcrP3YKDvf
	 BTjpGxXaSQHURfBGCVwFT/ZZHdB0LTTn7V7WjXLv4m9e2BHl3xMNuPLbmaRfjORxoq4tB
	 zI0ejM3Adldyb59LhHqverwPvzB3SeaL88w/QIuFLTnypJsV4yswJ7wxgLQF/0nHXeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NKBjJJqfxuTkAi5ii3nEvA/ElY96XwOguRE44CgIv24=;
	b=sY5+LfLW+EHFLOaLg/N2Nww6QzmHLMra1yyYI8fYFNFm+uqe+xTiMQHZIwCSRmuMmTxk
	 2vCfg8qOSiQL8Ln55MTxVGMnZSF83KAVb4/HqLKoL3hmhJI4ffyWWdeUyYWGax0SU1NSW
	 EF+h4CU7b4Y/rAUIG8TZrGjcq5IgNNaELcr2tPOk616r3FRCU4FaZZzSgMTEEe72adN6A
	 NiRH5u5l/P6kXY2iJxFMCmMXCQ6PqZPoXwAL//i0kxDHMpOMY/N5ipSyN38XZh+b0Sndt
	 p2tKZuG3iVy9Un6R7RGZIoUDA9muCaHRgAqBjcrHvl6XuWEXqK2/XkXSIlywXt3CiKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=hgVkil1G;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DA60A2605
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 416DA60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=hgVkil1G
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93e503815adso166533585a.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794321663; x=1794926463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKBjJJqfxuTkAi5ii3nEvA/ElY96XwOguRE44CgIv24=;
        b=hgVkil1GhyquA7V2MYGenPoh013N6ot7sWh2jvHPuOrlAup2qCWzSVarrA69sXWpeQ
         5NYbowmn+Qjgsn+0lzDPQPYvppoMsRpSSFKW5DufV4K/YXD1/8uvxZYiYm8Fo/VQJbU2
         VYm6wx/LS8BOkKp2QimOoScgm9A2Te8uwvQaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321663; x=1794926463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKBjJJqfxuTkAi5ii3nEvA/ElY96XwOguRE44CgIv24=;
        b=MdWOgNVtWgqyjbZdHIyUq/gaxqaTGDFvHFDLxcULQ9kqpvSS3J9Bhh9+wen+IIzvh1
         PrsIbTjywWyaVc3mW2wfs62hzJs3mfDL0ftsQFMhCVIku9aJvX55zdL1UKQrYJcnDJtb
         CkuPj4imtBmLoGUcr59mHWXNNk9fQWPRobrqZB67u2Nu2LmUAaUSLzugnZIncyflRaPL
         8xGyGtAgSKGp/0lF4sVW+QdKytexkxuybizX5ygkZNHY+CHmXKmubo0BFTtuuBoSg2xN
         AUI+ZBrV8XCdIrU0WmNVVgHOj2zMduAnwO2xjVsKCu1wWDu2eTvOWBASJDcqS2cdHUAu
         9HQQ==
X-Gm-Message-State: APuU4Z8xsexa1GDPLO+J+UL05zg8HCfj/bGumZoF+K/yU/1LQA8mviEi
	o+kQqijhwON4DzeosyF51awoLobapn0asNCG3EO756QF5vvfqji4VXTxcAEzIp8nVM4qy12NhbG
	TdOw=
X-Gm-Gg: AYBFou2/OOR4Te92h0M/akfV+X6AhKfaVbzkTW/2vpN95L1bAr/bsgx+VuJBT+UGb0u
	UivePQFlo/T0jthIdIkcj6QrhD3HujmAHhgWpSDNBA9u1VzMJ6bzSnSlh+zyFLvcCjbOI6ZoZ5m
	LkRuOmjo2BwbgeK5FAo2guh4/AgrTk8eWXvVWN2huQmvXtEnQKr17rYd98IHrWIEOucqiP80sp5
	39iNfguOb50Sd0W4ee7wVtsbU1CITazqnMNsTbMjsv1fTX13h+OBLOnGmvcliESusyjZyWOx3Qq
	LYevLZGEmhR2uc8Fum2yS5TL+VuPwrTbL48VroS3JGb25/GHZePRtB8pADnaa+YtpIBjDXeeSv3
	xK0VVDXTzt9yrHLKAMz2fvQdxUQoRczIctL3YSqxSFEL8u58TnrV0WIWcWGgJIQ/e9sEUbZ7Xl6
	vELDPChOaCkKmqGYIsB9Tyxx9CWKi1or3YwfmPPIP2GodhdXVCUD8xS27o9hSM3NJQAmjkNuZmO
	LIdHiJSC/RXPSVVC3NMG2SQt4rnBie97vIgGyb6lhxvkt7Ex4vW3yGQvzy1QQXqInveglhE3LiN
	5YIA14JtS6QjT5+Xbj27+EFgZVVxUSBYgGvNqNuGEc4MstY0U+fBX/A6rHX6QoK356o0vRdQfOg
	=
X-Received: by 2002:a05:620a:7019:b0:93f:6fd6:fbf9 with SMTP id af79cd13be357-9479f31ea1amr450200385a.66.1794321663051;
        Tue, 10 Nov 2026 06:41:03 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f00f6eb88sm1679276d6.39.2026.11.10.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:41:02 -0800 (PST)
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
Subject: [PATCH net-next v9 2/4] net/sched: cake: use a dedicated split-GSO list iterator
Date: Tue, 10 Nov 2026 09:40:53 -0500
Message-Id: <QDISC-BA27.v9.r0.20261108195325-2@mojatatu.com>
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
index 67cb4cbda1c7..dfc187f48a2f 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1814,7 +1814,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		WRITE_ONCE(b->max_skblen, len);
 
 	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-		struct sk_buff *segs, *nskb;
+		struct sk_buff *segs, *nskb, *seg;
 		netdev_features_t features = netif_skb_features(skb);
 		unsigned int slen = 0, numsegs = 0;
 
@@ -1822,19 +1822,19 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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

