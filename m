Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB363D8127
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940643; cv=none; b=PQ8QqeonHh8udRuTNAnpcjY3okgzTJ6e1fut0STIqShi57HYBox7Wx+WExW7f3+cyd2eX9kF+SxwHx1g0M+TK+HCDW7WxNJpLG7FQ57r7hFNTrLHMTAwM9vUSq52J3uaXI+OC3jM8bAH32TUCI/UuVw8mLxHS8QBImMjWYyOQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940643; c=relaxed/simple;
	bh=ziS13Sl0XePVb+8Irj5aKB2uXwjBR2AeCsUFpisyMOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dcadkv3DA5NP9rYzBwsQOUhrFPcznsdGnnKAfWVBB62fIuOB+uqzoD+QaAQwmcl+h5wTcoCQC5MJmI7oxnW8KfEhJegw/ny40fkThVghAuvuFzEg3K77jDQiQtKGgEBJnIWfJT5s5XTq4t256SBz+vh7ikbZBVaNapAkW31+evM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=MZRoQ10C; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="MZRoQ10C"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cfbdac7a1so2036325e9.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1788940640; x=1789545440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gukiW5oUha6xq8OwiRh6vFuhYnRARLZXiBZpgrxcnas=;
        b=MZRoQ10Ccji0GI9nMBYVmBRcNtJKGYFDoX6XYyNLw/riDYUXyjTaSHBtrxpdFtSKUw
         t71WXRy/Fo15ymG7IBNrAzh1YplVQfq34DAVQiuKvFp3ca8zwqqLfXxxJ7wAoygqwPYx
         /nrbW5s4rlgMtHWPYzX2+p5wE9+/2JZ6O5FOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940640; x=1789545440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gukiW5oUha6xq8OwiRh6vFuhYnRARLZXiBZpgrxcnas=;
        b=TA34LzQPFzxo8kxDBZuzBgrLdAogR7WWHT2KVxsDqgBD5Eqo8zvOGXBTOcU8TKtRc5
         Zmhugz4GeoWzmZmdcXHKN+J8xZ8J0e1pQO6xllhsrDbSjcQRF5qjYgB2reMAU3/VT7W1
         scacFBmB862iuV8uPphTdI+zO+82d8H88dvQiN0pdIAjFNUBVgu6LzeB7824KPvDRNOi
         T6MXdEQeuTV0e7aIdSh3jvvfSdMq6PVlMoGV5opOW/7c0q5uy9pXPcOXQ+zHlWPJijVH
         oRS9UFW9VmSDQZeQqOiTKpcWESLfIjxcy4Qs8K/rkfiqtAONQuK1ZBb3pHTmKzbP4Gqv
         uxpA==
X-Gm-Message-State: AFuF++lQRbMXR5/d2kSZDsZZPkIwBb8901f9JVG5Pwo3QEj1Ji8K3MUF
	zIUZeogBj+Cbd0xkQuz4qSvLvwC8dUUXa5ig85yw3vY/o1r2LRCPsq5qHaZERfeRwP3k/sxvdpV
	XrAj/pYI14MAMmxWXZy2mzBU8G7NwWQf8d2XKE/4Ni0zf88VYIKOvtRGJBy8i8NLr0OuCJ1eHPZ
	hsrzf1NF7w7W4j0WyEC+EiRL8OPxjP5OV8OdYMLMqx2v+AJj18s3EBkzDmDw==
X-Gm-Gg: AYBFou1jITgy3HqPxS57rjc2sFYYdsM56kQz3cl2sKIoU1fxfRu3h92SUTR6rf9Vzh5
	mQ69i0nZLkssjuHr08ru02p3d7WKW7wIdf4AwWyCu6TzdDY0A/pBET8/rxvAG3Q7yeidKAFXPz6
	rJbm91PLi/1CRKt4H0j3IRlpWaOPJIu80xzXpMr53aAp7IlilS3K5PA/QsiLunx1kErMXleI4No
	myPzgbu4DrSridNFNDF1C4cJzXSiWlpARu+yLMyBTYtkuIVeWsyr12FzTqBwUiwdqgqt9KJ38EI
	NxjDlNsYhrD5qE663z2HYHqo5mVjoTLh8kM7RDgpjVTaqRHDqSbVYmtVSQuYbNJMugg7Go3OKZU
	cdQifBeNPuv6HE0Nr8jr+OlM1bdmZuIpE/7F4hLUuBTU2dvhUj7zf0UdOSrKfxKfON/uud/9i5s
	BvvsxLCFPIn7c5UW0tNr5vHfueHREpb7wNswH3azw/mK8aE1esU0bCxfBi9HmSu/Gsh86yBpHyZ
	1Q16NCNb3TZyqR5Xt9+k4I9f8OsA2FqDxBe
X-Received: by 2002:a05:600c:3b25:b0:49b:910c:76fb with SMTP id 5b1f17b1804b1-49d01dd415bmr218970125e9.2.1788940639866;
        Wed, 09 Sep 2026 00:57:19 -0700 (PDT)
Received: from inbal-OptiPlex-Micro-7020.tailf3f5b8.ts.net ([2a06:c701:c272:d400::7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20db6e76sm45677255e9.3.2026.09.09.00.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:57:19 -0700 (PDT)
From: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>,
	Amit Klein <amit.klein@mail.huji.ac.il>,
	Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
Subject: [PATCH net v2 1/2] tcp: exclude old ACKs from tcp fast path
Date: Wed,  9 Sep 2026 10:56:43 +0300
Message-ID: <20260909075644.1408171-2-inbal.lipshtat@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909075644.1408171-1-inbal.lipshtat@mail.huji.ac.il>
References: <20260909075644.1408171-1-inbal.lipshtat@mail.huji.ac.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exclude old ACKs before SND.UNA from the tcp fast path
as well as ACKs after SND.NXT.

Such ACKs will fall through to the slow path, where tcp_ack()
performs the appropriate validation and challenge ACK handling
according to RFC5961 and Commit 3d501dd326fb1c7 ("tcp: do not
accept ACK of bytes we never sent").

This prevents old ACKs from being accepted
or modifying connection state as part of the fast path before
appropriate ACK validation is applied.

Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
Reported-by: Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
Reported-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d51342..57fec58a4f15 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6539,7 +6539,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 
 	if ((tcp_flag_word(th) & TCP_HP_BITS) == tp->pred_flags &&
 	    TCP_SKB_CB(skb)->seq == tp->rcv_nxt &&
-	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
+	    between(TCP_SKB_CB(skb)->ack_seq, tp->snd_una, tp->snd_nxt)) {
 		int tcp_header_len = tp->tcp_header_len;
 		s32 delta = 0;
 		int flag = 0;
-- 
2.43.0

