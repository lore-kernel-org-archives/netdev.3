Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854974;
	b=VLhHkj/BHOkAf2U4suwYjJ8mawNHEdY/3UP0qkCaMn7H8IM7vYPmhoxLxPn8986dfGmH
	 YG+g6sp4+qnBwlJJur8wLlEPdAfr5Vhyrhb0jAJGNnHuFiwElSJiAwXYbE3OttjYArsyD
	 AqSQttlBTTIuUkyWRmJXK+53yctbuM90Eby0TP41cGI8xHcKpOA4A3BX3kVg0GhP0KrvK
	 MWG66dgvqZlSilW8y1KM220R3bc77pXtjhhRhXLbhWglWPIiq//a6du5w8xNzXnp9ymDF
	 seTV+mSSyiOsLMt1Iftqil7ekmegYcNJ3UGewnmy/7aj8TPVdrhVP9m1sNE07QWrZUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TF3dG/II9qrYEa2Qmqny+KjCxq+HEK6VEhmgidqtZ9g=;
	b=RAtM1qin91kQtBi/SfRH/840U7ULUf67TssBDSPrqE/+HKd7oJT0TW/k/zAqMmtZZFjK
	 hl7Nx85iJ2x/a3cS+hGg1CL0UhlJKXNtaC5mHJ/S+mvGQLKe40v9V1vIe/rCuQwgvDO7M
	 zeRaBmaxyBx7mCAzKBtLIim4bvSGAAJ6fXI6Eb4QsOQvM9jRJtSZQ5DGb3DerK5Ue/jtD
	 QHQFPD4OkpomynuKVVzrv4T7PDAP8Ro8pPOnJetcnFnXO2C1dOsvZcuy4tsQm+QqYh+EG
	 iOTrR0huTIZDVOBsCBYxZimpM7RZ2SVJP28p3eWLqXh4m+Rnd8ZdJgIOC+1r4Lxfo9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jvcXWPBo;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3552606D806
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3552606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jvcXWPBo
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so2537291c88.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793854973; x=1794459773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TF3dG/II9qrYEa2Qmqny+KjCxq+HEK6VEhmgidqtZ9g=;
        b=jvcXWPBo4oPsQGKrdvmfRGUxrtNptrfBHwHbDuBYiWoBP/PbA/e0/6vIGvZDg1o4KW
         xBy/ROcm1nDKrffPpwBo2MOmMNxacoz4XahOMl9+Q6QY18NzDS+UGvKiN4hB0MgpuyiE
         omok6Wmkl4sB+merjoI1ah8wVRDErhWLA4ULo4HvU6Z5CK+dhc9AANDHEbCKt9qX3Wnd
         aw76kTwCcRPuODRqwWbp61xLxId0Rc1feEQPMjIQl4uMbqvXTyFXwykSSrZdwBZA7T0x
         B0gkdP+VT2UfpWtb+2l2R34ZWlN+FTT8iDpHsAR53SfKFu1DeolJO+Y5JBjpv8a8PvzN
         +8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854973; x=1794459773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TF3dG/II9qrYEa2Qmqny+KjCxq+HEK6VEhmgidqtZ9g=;
        b=ZEfY6f417HERz0x824bfafW+gKrHj7l15eqjF02nmbFPpDvPJRHil3GPHFYnPq8Knx
         qkNRsOKOupUEgoTPi2QghdVrX+WChoBp+qpMCZipfiAVFMkk1ucyVkn+lf9xxUF5y78i
         53Wu6h0iFBiwZMQaEBI3Lhv/9CCqkeWkQEz5xvq7MpT6KazFlRN86RA0Nzmd6eGVW91o
         KctbOr38ReIrQlu8ZCwqsTZQvFYPamqLpNbeP5VbcUOXs1e259W60GeZNLxb3DRWCuvL
         wCnlG4YDStmSjXGDgEQyPSl6fxjtoYjTO/eigIL/CFsVUtA1nqhyMzVXUx5sHMI+mePH
         MANw==
X-Gm-Message-State: APuU4Z92O8kqobln83qbkKXyFUBiUtBqrewm0HJoQm/ycRkKMmv1IHZR
	UVxcp6jJml9ssr5eEE/e3Wj7DnN83aisVTMz+epDS0KnFyd8PrI0UENiF4nZHBBE5n0=
X-Gm-Gg: AYBFou3EW4ZTJL8Cgx2GiLYb/UbWIssKo/HiPcw2dpa+f2683ChLnGZoGOlVEBZWU9a
	wjyC2Sbj9EklalHw6qw+ao2dFO7DDIU/x/lwyo73+hHlRToYpa+AJ6bnH0ql9hqxJ2nBou0xnCq
	CdzCbbHX2dHeOEMAM1ndrccbOjOZT1j5rb8yZIAZB2jjZLQtZnTqgn+mgGZq9KLA7wlXl5JMXUx
	fWILWBcUplWqORznOnS7HBYRUttkPoaqVqnusytdbHobgvQi4Af7k9T+uu27eJgHRx3R+xuT03N
	CVCxo69rx5HyqdsT4MjVMSS4V/cmZX6pGUwZScooyEfaD6NKy8ql0l+TIirU8890BpIY6tHhLly
	0KmtDf4RXWAYjtgNbeTRfC9r8bjYBQIL9vm1kZYLAMh/eN6oU4RcAFcmNikzsoPtPRvmP07kdVN
	dobEOjEw1CuLUuykUwcSJ4tUxqm39ksGK4PgzX0jse9bj4SzfHaiei548R9uRdTgAhWAvB2m89G
	P8pWD8AjoYAY4/7iqhIu8h7+rtFKdzleCiLQR395CHU272sqWaMuIKFcufxCjdYXuEXPite03qi
	G6o6gWNX18w9PLTtMtsCwlU0xMHGEBJCcfkFUooEFYycz9QbJ0mKek/2oN7FQKQRKdz2v3WOpCU
	=
X-Received: by 2002:a05:7022:3b88:b0:143:54c6:6a5 with SMTP id a92af1059eb24-1ac5c8379a3mr26747424c88.37.1793854973017;
        Wed, 04 Nov 2026 21:02:53 -0800 (PST)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm13626735c88.4.2026.11.04.21.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:02:52 -0800 (PST)
From: Tim Budding <tim.budding@gmail.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Budding <tim.budding@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/4] sctp: fix I-FORWARD-TSN handling of fragments on other streams
Date: Wed,  4 Nov 2026 21:02:24 -0800
Message-Id: <20261105050225.49292-4-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105050225.49292-1-tim.budding@gmail.com>
References: <20261105050225.49292-1-tim.budding@gmail.com>
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

sctp_report_iftsn() incorrectly frees queued I-DATA fragments in two
cases. First, it drops any queued fragments with TSN less than or equal
to the New Cumulative TSN. This prevents reconstruction of messages
still being received on other streams and can fully block an ordered
stream. Second, it calls sctp_intl_abort_pd() if the New Cumulative TSN
equals the highest TSN seen. This check exists for association resets
but can be inadvertently triggered by any I-FORWARD-TSN that arrives
before data with a higher TSN, causing data loss and, if a partial
delivery is in progress on an ordered stream, an aborted association.

Fix the first by freeing fragments from sctp_intl_skip() based on
stream, U bit, and MID instead of TSN. Fix the second by moving the call
to sctp_intl_abort_pd() from sctp_report_iftsn() to the corresponding
reset handlers.

Observed in real use as unexpected message loss. Reproduced on an
unmodified kernel with the sctp_ifwdtsn.sh selftest added later in this
series, which passes with this fix. Reproduction and fix done with AI
assistance.

Fixes: 47b20a88566f ("sctp: implement report_ftsn for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream.c            |  2 ++
 net/sctp/stream_interleave.c | 32 +++++++++++---------------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index e4354d58f20b..d5e71a2027f5 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -749,6 +749,7 @@ struct sctp_chunk *sctp_process_strreset_tsnreq(
 	 */
 	max_tsn_seen = sctp_tsnmap_get_max_tsn_seen(&asoc->peer.tsn_map);
 	asoc->stream.si->report_ftsn(&asoc->ulpq, max_tsn_seen);
+	asoc->stream.si->abort_pd(&asoc->ulpq, GFP_ATOMIC);
 
 	/* G1: Compute an appropriate value for the Receiver's Next TSN -- the
 	 *     TSN that the peer should use to send the next DATA chunk.  The
@@ -1028,6 +1029,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
 			LIST_HEAD(temp);
 
 			asoc->stream.si->report_ftsn(&asoc->ulpq, mtsn);
+			asoc->stream.si->abort_pd(&asoc->ulpq, GFP_ATOMIC);
 
 			sctp_tsnmap_init(&asoc->peer.tsn_map,
 					 SCTP_TSN_MAP_INITIAL,
diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index e239da686f68..1113b3455369 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1203,28 +1203,21 @@ static void sctp_report_fwdtsn(struct sctp_ulpq *ulpq, __u32 ftsn)
 	sctp_ulpq_abort_pd(ulpq, GFP_ATOMIC);
 }
 
-static void sctp_intl_reasm_flushtsn(struct sctp_ulpq *ulpq, __u32 ftsn)
+static void sctp_intl_reasm_flush_mid(struct sk_buff_head *reasm, __u16 sid,
+				      __u32 mid)
 {
 	struct sk_buff *pos, *tmp;
 
-	skb_queue_walk_safe(&ulpq->reasm, pos, tmp) {
+	skb_queue_walk_safe(reasm, pos, tmp) {
 		struct sctp_ulpevent *event = sctp_skb2event(pos);
-		__u32 tsn = event->tsn;
 
-		if (TSN_lte(tsn, ftsn)) {
-			__skb_unlink(pos, &ulpq->reasm);
-			sctp_ulpevent_free(event);
-		}
-	}
-
-	skb_queue_walk_safe(&ulpq->reasm_uo, pos, tmp) {
-		struct sctp_ulpevent *event = sctp_skb2event(pos);
-		__u32 tsn = event->tsn;
+		if (event->stream < sid)
+			continue;
+		if (event->stream > sid || MID_lt(mid, event->mid))
+			break;
 
-		if (TSN_lte(tsn, ftsn)) {
-			__skb_unlink(pos, &ulpq->reasm_uo);
-			sctp_ulpevent_free(event);
-		}
+		__skb_unlink(pos, reasm);
+		sctp_ulpevent_free(event);
 	}
 }
 
@@ -1232,11 +1225,6 @@ static void sctp_report_iftsn(struct sctp_ulpq *ulpq, __u32 ftsn)
 {
 	/* Move the Cumulattive TSN Ack ahead. */
 	sctp_tsnmap_skip(&ulpq->asoc->peer.tsn_map, ftsn);
-	/* purge the fragmentation queue */
-	sctp_intl_reasm_flushtsn(ulpq, ftsn);
-	/* abort only when it's for all data */
-	if (ftsn == sctp_tsnmap_get_max_tsn_seen(&ulpq->asoc->peer.tsn_map))
-		sctp_intl_abort_pd(ulpq, GFP_ATOMIC);
 }
 
 static void sctp_handle_fwdtsn(struct sctp_ulpq *ulpq, struct sctp_chunk *chunk)
@@ -1260,6 +1248,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 			sctp_intl_stream_abort_pd(ulpq, sid, sin->mid_uo, 0x1,
 						  GFP_ATOMIC);
 		}
+		sctp_intl_reasm_flush_mid(&ulpq->reasm_uo, sid, mid);
 		return;
 	}
 
@@ -1271,6 +1260,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 		sctp_intl_stream_abort_pd(ulpq, sid, sin->mid, 0x0, GFP_ATOMIC);
 	}
 
+	sctp_intl_reasm_flush_mid(&ulpq->reasm, sid, mid);
 	sctp_mid_skip(stream, in, sid, mid);
 
 	sctp_intl_reap_ordered(ulpq, sid);
-- 
2.34.1

