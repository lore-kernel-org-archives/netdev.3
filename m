Received: from mail-qv2-f35.google.com (mail-qv2-f35.google.com [74.125.230.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBF503BF3
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029581; cv=none; b=X+KP7VDj6qv7boJK834/sWMFP9mx+dttNZCrq7fMv8dHP1q5LWZQrEm+uLUbLJAovjDJCEGLUwT5ElZq9trGP42KSKQKLUwgFW/DQqhfdf82p9vPz2gQ/TbMIUlOSZdwKET3C1WgUE0TNZd7OZcavylp79eeFI9W5aCMPocCyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029581; c=relaxed/simple;
	bh=DX8yj9cUqJPYsyW/k1cW19oYVmdyVrBuwyuNc+gcFYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzmSllqdPCYJ9KIiC+rAmsHcYt1p42tL8GQvC6PylYj2+tcsrUTvBTrTW1KP96o5UfWoG3FByoOBgdKpyXN2Fismj56oD8PihIrhu+SRov1atOFAmwnwxd9mtJjg1/Oj7g4+iALoc/ZJ8rwW8bGeZZjW4MvZtI4fX+MvD9UGBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=RSOLsx5R; arc=none smtp.client-ip=74.125.230.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="RSOLsx5R"
Received: by mail-qv2-f35.google.com with SMTP id 6a1803df08f44-9104e54b1abso47507066d6.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790029578; x=1790634378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PL1Tak99Pu1xQGpynZZWO0p/5oT//nqz8fy3aEb6Qt8=;
        b=RSOLsx5RngbTZiOe/3ckCF1WQNNopShuJewPkjDYVIyAa57SLFgZe5OBYvFXtw6fWJ
         uEVsan62vsYzDiEu2HgCuRU6OtqtN1LoEY1qvxqUMbob2L68vuG0Z8/GtYM4d+6jDJUW
         XOBxXkhnXh6l6qdmtl5n3+I2Bwbz/pOyJ9Zpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790029578; x=1790634378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PL1Tak99Pu1xQGpynZZWO0p/5oT//nqz8fy3aEb6Qt8=;
        b=reBvFnqQaGlX06+FzvydCShhacIIEPR/Zhr2bV0mTLxcyy+S3CtQZ0qYjjT0Lcox+Y
         C3/UVu5EyzcwXDFjwVjmnGdP0XgXKVO7F3LfrIcJBwDx3iD1+4igf48qh2EvzpUtmWdd
         weuF/eZnOHglzhavJoFzWA73XaW3IwPtXZ7PMLov23UgG8ZMU5YiQzroqJU5cfnFu0/a
         zjCEXdzY3MahRo7vqqYxPIVp47ofkAarmj2LuYHLScV7yLXm2JPSDiEjWNs2TYhkDvip
         DoltjFyF1+hEG9l91/b+MeLn1zwNV3tbyknwt/ZGoMm1xapHlRR3vClah0Rdpcdotxcw
         I6Lg==
X-Gm-Message-State: AFuF++lWzNlBMg65/GltoE6SfgPERxB8ju3Kbfw4ssnmcag4vb33agVC
	G/GnF4OxDlZh6gQ0LDCh9xS2uPjba4M9NijmR6mC6a+iYwKoPZXq1l6MoiGwv4hTQyLW2x1t1m0
	4IGyK/BMffw==
X-Gm-Gg: AYBFou105mTLK+ZVrrsdXPqklCjDfP176hI+0V7tRurq+vBr7qoF7bHWJFjWYSqIDzK
	GCtkKcQdPib89Yg733w7wHwLOvFZ/KGAu2n6sl3ZrDLtXNIUHfy4YkOxModdNEfwq2+0v3We8P/
	D+lgo8U/Z2/L4qXxilFaZyotO7OvqtARc7vuJ8AEgc/JuyWW7Kjm19WR4gjXSMngDU/U8JW9hRf
	Z+IYc830UsSVlDT4WmR1lMvQYrE7QQPhptTSvwb1saPZGtIR/Zjowh9J3K5AmvIDg48P0BlQOSw
	O3Jlyi5jflyeb3vHnUMQ2ymnIPXo50YMowHhPaDWAuXV3C4KwcSsEktbvkrYg94o41F42Fcht/v
	jB9/9Ze3vbBd7OsPW8dk5bNBZZ49fLbn58hVanFnkmFe/INI24FI8i1o0R00i38sWE+JAO0RsyR
	FQ2qg8mEL/8lPurPkL6m/Ddo3fEk/n2kGiraXvoHWzpd6uPr1cYjYlJNiJgqTGqVqdNUfBfGMsf
	0dP0JBUVXM0j2G3S3eq/Vhq/x17cOUG1+zWkpnnUGDjOYuACrsamGKrGsb5ZeYMDIhlkqHM6zO5
	MaClxzhnfQ==
X-Received: by 2002:a05:620a:2b88:b0:939:4a34:621e with SMTP id af79cd13be357-93c15dd29camr264497785a.28.1790029577869;
        Mon, 21 Sep 2026 15:26:17 -0700 (PDT)
Received: from com-94485.corp.openai.org ([199.47.143.14])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19bc6f4bsm30675085a.44.2026.09.21.15.26.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 15:26:17 -0700 (PDT)
From: Jeff Jo <jeffjo@openai.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 1/2] tcp: refresh TS.Recent for accepted old ACKs
Date: Mon, 21 Sep 2026 15:26:11 -0700
Message-ID: <20260921222609.50824-5-jeffjo@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921222609.50824-4-jeffjo@openai.com>
References: <20260921222609.50824-4-jeffjo@openai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A TCP packet can carry new data while acknowledging traffic in the
opposite direction. With overlapping traffic in both directions, a
delayed packet's acknowledgment can be older than one Linux has already
accepted, even when that packet fills a gap in the received data.

Linux accepts the data, but tcp_ack() takes the old_ack path and skips
updating TS.Recent, the timestamp saved for outgoing acknowledgments.
The reply therefore echoes an older timestamp. If the sender uses this
echo to measure round-trip time after a long idle period, its estimate
includes the idle time and can reduce its sending rate.

Update TS.Recent in old_ack using tcp_replace_ts_recent(), before SACK
processing can trigger a transmission. This reuses the existing timestamp
and sequence checks, including PAWS protection against old duplicate
packets. Leave SYN_RECV unchanged because its caller rejects old ACKs;
established and closing connections accept them.

Echoing the timestamp of the packet that fills the receive gap follows
RFC 7323 section 4.3. In a socket reproduction with 300 seconds idle,
controlled reordering and retransmission to exercise timestamp-based RTT
sampling, the sender's smoothed round-trip time was 37.5 seconds without
the fix and 15.5 ms with it.

Fixes: 12fb3dd9dc3c ("tcp: call tcp_replace_ts_recent() from tcp_ack()")
Assisted-by: LLM sparse
Signed-off-by: Jeff Jo <jeffjo@openai.com>
---
 net/ipv4/tcp_input.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 92bc60716f33..f3f4c905ce00 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4465,6 +4465,13 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 old_ack:
+	/* Closing connections also accept old ACKs. SYN_RECV rejects them in
+	 * the caller, so leave its timestamp unchanged. Update before SACK
+	 * processing can trigger a retransmission.
+	 */
+	if (sk->sk_state != TCP_SYN_RECV && (flag & FLAG_UPDATE_TS_RECENT))
+		flag |= tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
+
 	/* If data was SACKed, tag it and see if we should send more data.
 	 * If data was DSACKed, see if we can undo a cwnd reduction.
 	 */
-- 
2.55.0

