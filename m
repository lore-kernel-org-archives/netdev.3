Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789719;
	b=fTubaMIJtiDTeAgdaLaCBZQsFxpskohJ0e9ei2iPNnkTDGAO7KFWYgXVr/hxazrK7bng
	 z/2m95k0gX9x4BxYrukStD86DvqpfarmAn/d+xGwjmryYTlkIm8TNs8a1fndFWGIxfNQy
	 8/XPKy8XquhqSASyKyFMjNzkFaLorj3Rte7gbWP4wsGx58gxw4X2qvQ9sFuCmpWEF4LXI
	 NwPAgM39jeWFLbmRFTJnPjwMENQttxutV9CxPxndVLll5unQy9Y+HWkqTizp88fuqkVDr
	 anym1xa9hF3rw95MY1WEol7MSjO7l5q15YjoJQ6tC7lQJARXJEm2RetXiE3BCMkSKFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=svQ3K123JPnzXeQWDnbEp5nT6eUSmJWo2XdSJUKEnlw=;
	b=SCCnSbzZij+ZImRK+aghogVVx+35HUg6kqfB1g1T7HVzzgLv3/IDH8shGYzjN5Xfb01Q
	 5DMGPtuhbVu8aZuGqYye0XsSIW0CwR02dJz37iClm6fSV4MauL5aOBVrJoMSu8aWG+YmX
	 cLopGQJr26EqcsNZDkgOHgsUYYE9BRJPkzW05x59utisGB2PhDtwBcg1otqZlYFW3Pc+o
	 ieWn7VGcSgubc6ZMTIyB8OL4J8RQRlOnvHl0CrjjiSM77Gs0VYNcbKD3+44Va1eFnWxfE
	 rp3QQsiH7VUARc6ptvHYminbnLUt1CxL31dd2xRtIdiE18LmmImQAlb443IgTjd+dzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mylsWZY6;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6BA606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 10:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D6BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mylsWZY6
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so478697a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793789718; x=1794394518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=svQ3K123JPnzXeQWDnbEp5nT6eUSmJWo2XdSJUKEnlw=;
        b=mylsWZY6HwqPDKZlYnXLspPDOPGGWu1z3Ud+RdWElpdkudKz2bL7MGxoS1n9hHIvGi
         KgSSkDVJSOZlBlBEtDbwKSb+7MmPGIQzYLrjns7Ernl27whywuP1t41+mfEe11ierZxB
         vrQB7TSUZo+RjdfVwxyQiX+XerCfygih6K6mMLVaAP41RT+qnbaS9zolCTx+IVyl9De6
         XUuYCLXHQEhIYGTb5Lv6A1Wxy/fRH7ueKDqF1s1YuCrMBnarXExMMSz6WfcxMa7xWKue
         ffsYIZRQjk92yzjQRdPUzLadMm5KtgoiFHNyXH3f64E7fW4jWP962HFk81VdFJJZXYOl
         NapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789718; x=1794394518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=svQ3K123JPnzXeQWDnbEp5nT6eUSmJWo2XdSJUKEnlw=;
        b=zgf/39aelxainDgvT0bunYVHwS6/BEptNwDtEshIfdKbWACnAwLr9wj3mdgfmHVa4W
         JhDIGq58kdCDaT64XrKNDWlmvoNv0YWNjvkpj/7CXKh477q8SaMu4z/JNo3Uzz+TcI+l
         2KcukAFw4Fd2Mn3SZ+i+ejDZgyWqHiyFViFgbcfjuWUdCQVE1Z0IKvdkgD71QxRhObig
         IUrsaP8TMgSln7Pu4IUped4Qqj9uodt+8b8eVnsnT1txrwNFYD8mOZSu36IIJBjKAgT6
         zsTQ579GyeCNuQLvZK04u56Kat+aGA0edSiuPNFCOhH9HU0lY0EIRostb1xgGrbOip3c
         /DQQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2933KKn7UUw2vSKzSUhZUYXfh3Ve1cqnAiAQVU0A/IchNQKFeSu8/rkYMuafq/Ofwqly7654=@vger.kernel.org
X-Gm-Message-State: APuU4Z8j2j177c8hc+J76s/tLuV9i/17U8m62tzQBbSrRq675YMoZ3Hi
	ojQI6bbMFG43L+hnIksVF5RtOfs8QrC+dbQJxEbdIzZ9m7yIrpBEidq8
X-Gm-Gg: AYBFou1O+nWbanFNKigOu4bHMEHr77H4bh+JpDdpWmcqAl58wUSWJPvCoX3idnCWXle
	0ayQ8f9Rxm9H40Qy9b4ve4X1o/qBbhSP/1j297VtmXVW2NChCbj19E79awzzzi7zkAZxlTYPzde
	dj6/UT8nIEBulGfu7Zre+5XMKjp5FlauXm5CrchjrivO3ZWLyDOngyolGHypuhraccAHrEOy3uq
	0mH+ikxeYlE+S2xWvr8xcnJEQq3MBEHai5NZWWNnLUJrkt3C6Ds9Fw/SRQSRQz9ZYSCZROpr21q
	LAhEdPm2Us50wgU66izlP0x23CgYzQFKQdDREGOnPN1IW0elwcZuinM+11feXXi3qqqetbbBPfo
	XlgUdC8LhjlsOho1eGZXtMi+khZXseJkhBMkogvvwH8/fAu6TvIH2oXqu6E+dpXcDM3GgJtsUGV
	hCnpKyVENFukVT+jOPP4xrXNx/GREOSyz/yRk6fuzTnLTqj6q74b6PlGhrVVI4lkJHaIjRADHsJ
	X03DIKa1Sxn1HYw8+FQfqnfpV4HWuWOrXeeiTSe483OdruVlFffHazhRLUPwI3qhPjp4XvcNoj5
	qH8+AdchIEwiMbYMsOLzpxS4v+/f1ucB0tP/Y++7BaRcGqvJCy//IbUH1fN4XWmEc6H0Rehxgaf
	/XrTVG7hbMV8US6u0Y9AfMCQQq73OoEWnFA==
X-Received: by 2002:a17:90b:4cd2:b0:3a7:3474:b1ee with SMTP id 98e67ed59e1d1-3ae897f8a0dmr14154983a91.60.1793789718149;
        Wed, 04 Nov 2026 02:55:18 -0800 (PST)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094d572e7sm1739595a91.1.2026.11.04.02.55.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 02:55:17 -0800 (PST)
From: Jun Yang <juny24602@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] sctp: preserve stream scheduler across outq teardown
Date: Wed,  4 Nov 2026 18:55:05 +0800
Message-ID: <20261104105507.62743-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
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

From: Jun Yang <junvyyang@tencent.com>

sctp_outq_teardown() reinitializes a live outqueue with sctp_outq_init(),
which clears q->sched before calling sctp_sched_set_sched(). This makes
sctp_sched_set_sched() skip sctp_sched_free_sched(), although the
association's streams still retain their scheduler-private state. If the
socket's default scheduler differs from the installed one, the new
scheduler interprets that stale state through the shared union in
struct sctp_stream_out_ext.

Preserve q->sched across the reset so sctp_sched_set_sched() can free the
old scheduler's per-stream state and clear the union before installing
a different scheduler.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/sctp/outqueue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index e92fb9da4647..6cb4b4339d8b 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -190,9 +190,13 @@ static inline int sctp_cacc_skip(struct sctp_transport *primary,
  */
 void sctp_outq_init(struct sctp_association *asoc, struct sctp_outq *q)
 {
+	const struct sctp_sched_ops *sched = q->sched;
+
 	memset(q, 0, sizeof(struct sctp_outq));
 
 	q->asoc = asoc;
+	/* Retain the scheduler to allow freeing its per-stream state. */
+	q->sched = sched;
 	INIT_LIST_HEAD(&q->out_chunk_list);
 	INIT_LIST_HEAD(&q->control_chunk_list);
 	INIT_LIST_HEAD(&q->retransmit);
-- 
2.54.0 (Apple Git-157)

