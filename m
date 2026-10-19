Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425649;
	b=EJwA/Ip7AMHnfRKpc9MQbQSgyMQPHK79eoZaK6AYhlOnHzZhtw686WJOBz3y1GtvJVnt
	 Z+pgNMR49423tl0N5nrUGc0xgStbqXuCas4c976RNae10rsdwBHs4HGrmZeRVpLDWpxF8
	 7ySE+YvMB6wvkalP0Nr4BNfMNK4rjboDI1oR5ptSXi0ECFKNe5Cw4ocPg9DxQWAklpx5/
	 xY+3MVpamFPSZKvQ0aACSYw5S1CtjvBLalln53KihDVhHSzKSHDQgO6Qs+9y6kEYneL/V
	 xHnEgNLaJcXUvliyRegdP4bC3eAKfG3JAK/IyD6Kao+2IyLNFZt6DlnE/k3HJG6LX1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OLNQJwDVyvERst+Yg4jAyoV+SS5hTnZCgYBGqPPDnM8=;
	b=IPL0n0CuJ6TB6RT0KgBkVXlamiIVGxMt90FCbkRGqNLERK4gqRN+wOH1TScv8WSF1kcc
	 81uwZPstw8zoU6cRemvdZwHlaXmyE0Kx+eFEMhnw0O0MJnNLz8T7wyyLP52UmbH4rDk8I
	 CfZw8H9FzFw9kzeHZniI9mCsEejKRhAYftNpp/VN8JhEGyjfroaPqFSbdK4IlXCe9mHbx
	 hwY9YGFK4Rlm2HV3y7EOvKoyDdrHv6enJHI3n9TMVICiH4WObP8/QOmAOF2E+w2hA6KH/
	 6DWd9gbYjOHyC8YZLUsokD8DZ+oPkXXlJZB9l63qEtngkut/JodwqPdVlgatJA43L2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VbDaJ5lY;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC4606EFD7
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CCC4606EFD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=VbDaJ5lY
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-9196d8543cbso22011556d6.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792425648; x=1793030448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLNQJwDVyvERst+Yg4jAyoV+SS5hTnZCgYBGqPPDnM8=;
        b=VbDaJ5lYe5YkiRIRwzbM31JIz8fBPTm+CEP5zvYU1PrDOehVWJG9mc09ygz1T7EkA6
         rVIzXPfdXvxajhS2PDbjbqmYrKvaKNikZXMiInDXfqcVAXmbnnpb83t0UkvkY5DxcJnr
         5pyqdCkIMpvfxCQbped9mLd3AF4cmgPvdXi5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425648; x=1793030448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLNQJwDVyvERst+Yg4jAyoV+SS5hTnZCgYBGqPPDnM8=;
        b=fFKlYy65hsPCVjjCadRVQNzREMj1iJ54szZsv4IA4j0PPxuN+O8INhfQH5Y//yN2/N
         3F5lCIgNeVUPZACUFggESDYXrYLdh2AnhjolP/Tj2qCm8IFxbAropoZEOsy16ZSEPPBE
         FaDfw6jo1052Cql3MtsmM1eBLnRYMgQ7FQ3tFo/P0FkwvuA09oKnHG0Mr/oUgsPlK0wq
         /liANcNcrVuPK+186iyRxU5bEciBKlzSN2b7nZbPWId5pcWO0cLg5GklGEGDGK7660iZ
         XQ2sTzv77f5V7jjxt/WCFcR6WSxo2ltoOrDxDYBPM6tKkHRISz3G0m6IQVYKtb1h8Qe2
         hAMQ==
X-Gm-Message-State: AFq9FYIwI9UXgRZmu73+gxDqxp2LLlgG66TFT8yNx/RESXmL57QDsf9B
	y/OnuN4kcCvX/gcD6K9ILLf6f6HFBggrYo7U1+bUVD1fgTlIcJ8H6yR5VKJy7mcvmofdq4roIZd
	xYxc=
X-Gm-Gg: AYBFou1sslkJO7Lj6a/mQxT27YWjl8lcaSAUCXQBqKYO4iEhH8+mrzkNxPbFWIsxiGL
	0Ix5yxaXcFLWxuNSGY0v4mpytj97ANyPKpxsWHqjrw70rTcnCLvTn7WUkdeNDd4eFphFRFOdosh
	56X3QYYrCHpCc5WZBa/FbqViVlEVMulcoQ8YjFVZ964SsXxeqwRaasJ/Qg40SgUe5v4M8bdq+1b
	q8Jyon4mEy0Qk1OCX7cuu64bAD6yYw7k5RJFWImXr/MZi+SmwQxu28vNL8UZiXEE2m7BWHyCdmm
	BJkRPrUHQwGzn0CMYRig21OITDgpns/9VgwFvvaAyeIib8axXa+IzlWZBhCXIt2iYJta5gztDtE
	OkhytA3QTAa9HCskWupwc3HNCoUy9bszGg9Bb46HrHO1XlDrFKuSpMTuOB7RfsRy1OHhD2sfMlX
	oRvmK79IY0VUn3eTnnfdl+jVsTKlnEHENvRrPi1U43sx36w+G1BTpuY3izMraHIDnBDllQEhI4U
	b5CsBTrPC86lz7PIvu68+GJjs/c5+Qpf+xqfiJrmnGE
X-Received: by 2002:a05:6214:5193:b0:915:eacb:cb90 with SMTP id 6a1803df08f44-91bdec33e56mr132243606d6.5.1792425646912;
        Mon, 19 Oct 2026 09:00:46 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91be9d8acb5sm64846846d6.0.2026.10.19.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:00:46 -0700 (PDT)
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
Subject: [PATCH net-next v7 2/4] net/sched: cake: use a dedicated split-GSO list iterator
Date: Mon, 19 Oct 2026 12:00:33 -0400
Message-Id: <QDISC-BA27.v7.r0.20261019115505-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
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

