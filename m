Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC583FAE09
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151194; cv=none; b=Tgkfb0HZ/Eo9sh9jKPMXH4Tkv2QU2Q/UezA9WwA2moLizoJvCP31PA7hKkM84zeMf+rc8XCE4AG7j5flVQQHR2ehTXhiQa0f4kkjyQuzuO9mlDNATkltSuX5Eutv+/vQguMUQBwpetj6f5oU2ztygixT6JfM3Nu52Ge0AaPMwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151194; c=relaxed/simple;
	bh=yvIRJ7HwTgClCkXWJUxAewXBtReAxRNZkSYyDKQmmfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHO9Mm+8I7FIqGsKEk9we7HCtUkAu3xqWJ8ApWn0CiaP6T5/PrFVnTDlGwPBcCXRxx4EV7jl5WLsKeL2aQKA+bSTEiXXDZ+AZfCsdjwoqais+Erq2Vd7XpP3YXOonQlECHUoLBJc72e8GqAgc7P5Uia7NhPkRqOLq/4qrx+kuCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwfVIDul; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwfVIDul"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4956869750eso19170115e9.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 04:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785151192; x=1785755992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lV+emuP//qkSL+L5zsgXUHGQwAyuTa7sxXfK/6iRlv0=;
        b=JwfVIDulMowAX6HB6GGPjLpYEHeKc54HMlRm46oFEPOLlGYfTp6A2yJhuLHnPF5gFM
         1/FCpBDtkCMIVE4BLhxXfSDgKJ1tOIszZJs3AMksrmW/MxjzmPzvu1GfJaJbqAUc4jkq
         awZa3DzgIFfhtjg7zfy3MU7hOXnW8/8wwLOV2f2Qd4mvqrF9LW1XrcC8IorZVDM34MOV
         oNNWua3Qz5vKQ9zVsmS0QGtreCeGUKstlMySyyiVI5xc77Z5ukQ8BJJ11ruzVr3J5Yd/
         Lqztn7E4p8FR0rfzviLleG6MupsEdPLK+WTkH/r9UYeE4cbgouFdcvGMQHgO4qr489XY
         dtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785151192; x=1785755992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lV+emuP//qkSL+L5zsgXUHGQwAyuTa7sxXfK/6iRlv0=;
        b=iI3lOXGBYulEz1hzVzRP0eOCsSDGQT2caCtSePjz8sk6byRXj1Z3EKrXs4173AkGkt
         HNZQHxP6j5laU+CQDCFVhX2CsubHfYRw/gq4sTtLTIoyMKb0emN/wb/KtAMsasVGpgU4
         QsPQ9iHGOoNKEYNbXKjVT+78YEIq4Mq1ZaxLMwPxmje16QbM890qWvf882IghnaDY6K/
         YwoCLB8CuSLnjhMwZCq3xrj1s5k/lOqTXA+aN9Iyas+E8J09oxGwzTJAM0AI3PfK7Yqa
         ydKy6QOW0bwiFfsQSJ9aB3W7Bb+3oqb4Hi99w3bb9NMH+RZeXzs6FLmqo1yZfaAxrxjN
         eBag==
X-Forwarded-Encrypted: i=1; AHgh+RoGpIvW7iOLnPeUJUKBJsmDYnyKZDHkDc0YubbXorcS7UkFGdtVle8mjdln2S6LbiVawVEpyU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXn3L8ZWM/udCtWxgrW7TY0p+p/xFaZ91A9Tqz2Mcotj7+1sv
	8QPwC+360wZhqLRhaJi+UawQEhG6WShELsrVMK20DUWMi3aBf+UsJtNZ
X-Gm-Gg: AR+sD11u2z2f4/LqZn9DVhDRp/8DTQtyTXn8HP186Znxl7D3BXeUmedexJnRRCscUe8
	e8zw8YKu/t4IsE9HlDfYiB48VE4gLhsnRLrVsIAiNDd8X7yHp9BJyEScuONZIzqC/W+paDWxSwk
	37tSnPWaah+rIzeFrfMoCmtK5gqeY4Cz36RDAQ4ddD1qNxK7JyNBLgTbUDSKHT+24gzSFu+Hr59
	nd4UXqJ+LEEQ1oOQsb6bneYJutKzBhuXEdtbNhgznAOBKaudYCvlS5n90ufMOeDDp7SnJnY5Nes
	Txcw6ydTmjN9dbfwiBKvBx60QO7DYNu8aos1ILOrPwtW7MKjUzzEqbT3qGiSCj+3PSNrfNFace+
	6VkoRUaQpQc4WfZGlhW1hmG4Uj1A2FlccJYRQCpWFgjT5YhNgN5k8Fe1wQe/26UuX41KBvI3VPF
	DzZaRi3OcXpbWHXVz9EnbQQ6yIAmh3BvU/XLRB9zaez8ddIUddmVzTThNX2mFjTvtd5GISQoY=
X-Received: by 2002:a05:600c:3153:b0:493:be13:98b with SMTP id 5b1f17b1804b1-496b571609emr111960295e9.23.1785151191423;
        Mon, 27 Jul 2026 04:19:51 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:4f63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9ae5c3sm312179115e9.3.2026.07.27.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:19:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net v2] net: devmem: prevent net-iov / page mixing
Date: Mon, 27 Jul 2026 12:19:37 +0100
Message-ID: <e3199788c4732545627a4721097ebb71ad737bab.1785150502.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should either have net_iov or page backed frags in a single skb,
otherwise it blows up down the stack. Don't allow mixing in
zerocopy_fill_skb_from_devmem().

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

v2: EEXIST -> EFAULT, as skb_zerocopy_iter_stream() doesn't handle
    the former + for consistency. 

 net/core/datagram.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465923..173b5d97bd40 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -712,6 +712,9 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
 	size_t virt_addr, size, off;
 	struct net_iov *niov;
 
+	if (i && skb_frags_readable(skb))
+		return -EFAULT;
+
 	/* Devmem filling works by taking an IOVEC from the user where the
 	 * iov_addrs are interpreted as an offset in bytes into the dma-buf to
 	 * send from. We do not support other iter types.
-- 
2.54.0

