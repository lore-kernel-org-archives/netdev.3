Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889244;
	b=ZWlDA5N1nrFK/aJiROGBGm9B1ybYWFnhop9ej9/Ir4zygrafpwZbM7aKUJcL09ixKkWz
	 /0gV5vf0h95FjwKygfNn/Z8Fjpe8+vGf0ckJFhcpCG7XnVbEqgUJc8tAfNdsr5uSSjcnj
	 C90o4htmuPr2HnUMrB6dflEck+f+f0nN4jkB3hq4i9GVbInFy+SXIRx81x4xRSx5/BoC7
	 n7EJjw0WhSYPClPGX3UH0dbv7pJeyGP2osOM9G7J6IOhKz3CYdjRNUMm3MmnUVfnrJ0AV
	 u9Wf2Rc8wkqiDenZpTNgoZusX9nTZE3Zz/zjzzP1KdTkcK/px6/BYTVBxFVnzK1smpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IhDYLVk74KLE+6uqmnSquzwjdzarIeNlcvxoecJwRDc=;
	b=Tct52mIvAXVyYeBb7wXuuMpT0sDHUhmQMqsl8Y+k2LorrR02zTxddKgOi5L+rYi2sNkd
	 EmXGzTddv+5VE1MIDC3fwrMny4iksO+uiDb09TBzbcjrfdIl6dwiNdHrao+Q+Aqw7YF+b
	 7uNXeAU9mj0DF3buXjJ2UJrq+uZY9LXZi5uc/RKYL835jOIwfkouwQBJNtcyg2Nq76hHU
	 b1dUOVRPWW1jUmWaPghghHHRlUBR0WSuC/PCSYUCNDkoK+f5vZ/2fmDBpPxn9LwpqbGS4
	 ZJC+u6E2vjgN/i6iHUzhnc8IA5K06B4a4Ay9EA+cqAIzD+3+rNq/wp8w1S5zITcIubQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fI7YdUxn;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E8D606A32F
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 14:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10E8D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=fI7YdUxn
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4697404c2bso19846466b.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 06:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793889242; x=1794494042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhDYLVk74KLE+6uqmnSquzwjdzarIeNlcvxoecJwRDc=;
        b=fI7YdUxn5VVBV4gj6rQ1cryJGapHcjKNUi4OfPse3RV0xiY58lbw36dK8j3VxJOmg+
         hf1pBxhWTSCnVZ65APXcKDbZ4kVyq8yqyH2D5tUHc1z5Erq4rRDvqS/4vXXOmkUmPlDc
         LPvkbhN2Y/z7uXHGXqinekWGW5Fkg/qgO7jfnWKcbjsKE2k2BPZXPnyj3AT7JRkO0dSk
         VD2oVvau6hzh9+X20J7oRzTomCYuA6oGgtgSHogRD5Q5w2bgvC3V4ZEfJpfAIDtWZ2OT
         TU4pnrSkVqebHisq1NuFFY5YaLnT1xXklB4Q7uaO0TUaWDiDUtbQaF7OOGyGTI0ltp7f
         68Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889242; x=1794494042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhDYLVk74KLE+6uqmnSquzwjdzarIeNlcvxoecJwRDc=;
        b=sSy3OtihsRaBlUfwkpfRB6aLODhazB/aYohlP3uvsuAQtvAe9L1yWpfXsSGVh4uAe/
         FZfiF2HahxJPVHHBemDcZr1fBoFsOXHCSh255Y/JSW12DIbU5UT4rQzu+7x8VKEobQCs
         5rUcDY1gL4dkl3z/Nf0WdixY8O7+VrafILen1GR0Ku6TtZD98etuHcJFHZh6mWugcDvx
         miIIwTBzkGlRHP51ogK494N30MSjrPijzculRk2dPKkQMtpOogCSomEHsqFf3nLlyMPL
         Il9BbDxqqSCPFvkiP//FeA17j/zD7y/nsXSQFY77Gls6kUBwbid9azfTkwEFBX2iQ5oZ
         yivg==
X-Gm-Message-State: APuU4Z+Y5ZCGaDHsDc4E1h6VsbO5HbElpNC/nbAyuz+JuZl7r36NLQA/
	9x8tU6c2uoSYVkOWzcx0cpiJ/TGKU6A8VYEwNOCAObIuncPrYjDiGPxDsnY+FJLKzWOOvhzgfrX
	1doHJhQFljQ==
X-Gm-Gg: AYBFou0jItnd91QTO90QhGpBNZpodis9BslX5mqLUpD8dWQlal5OAIraQjd5fm/ln6h
	n6+YaoCaccROa/psXOpbCMDzX/QAy+ge+ZYvmr96h6VHa9aAwetDbCeW8gzYqIqbPxlvKumHWOh
	uiU73s4bSjRvFfw2BOnIA+vgj5H/yeGhqsJaOLc5zQiQKGzk5uNleP+c0xMO3xHUPdo0RsCePZb
	F11grWszITCazMQloJCBuV1w6WhwDZAL/3vOFO35lxT7FYqOeWyPmEoFLWURsbJphUMYdLgqORg
	ACJWg1ka0fZCPIh+ubuZzL8QPQ6ToUri2Dbd7rz9nNATDnZ3b4PFXh6A6mFsz/6xW2ZSFJ2I+ud
	xk3Zp9fMKemFrRXEpke385AhB9Ay2qtKb/HmW1mdypGcO45U5W9NzBvOgtAfUl6cRE94iMvX3hd
	1ocJHkQl60COqlFbjbwtupujDKMx0W8AItJBZhIh/0hGvJhWXOov92+YX2Dn1Vql6LqkZ4K7iNR
	T+lRJwgfKBpSKWAaFltGu/i77a+lGwdCYwSjLD2kVPD98ThaOV/S9D9vIfcuBMbDQ32zQ4yt5Qa
	y9l2T0wS49w9H2O32qcchDw9ItXNPDheQ1igG5oytOO4ONmelN3XZwuEcyHSrZ0Z6hGp
X-Received: by 2002:a17:907:a890:b0:c46:9ca9:f522 with SMTP id a640c23a62f3a-c4ca7a69782mr1644438966b.26.1793889242456;
        Thu, 05 Nov 2026 06:34:02 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e466be0sm178671066b.54.2026.11.05.06.34.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 06:34:02 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	jiayuan.chen@linux.dev,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 2/3] veth: link RX queues to their NAPI instances
Date: Thu,  5 Nov 2026 14:33:55 +0000
Message-ID: <20261105143356.17062-3-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105143356.17062-1-tianyi@cloudflare.com>
References: <20261105143356.17062-1-tianyi@cloudflare.com>
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

veth does not link its RX queues to their NAPI instances. queue-get
therefore reports no napi-id for them. napi-get lists the NAPI instances
of a veth, and their thread PIDs when NAPI is threaded. It does not show
which RX queue each instance polls. Userspace cannot tell which NAPI
thread to pin for a given queue, or which NAPI to change with napi-set.

There is also no way to busy poll an AF_XDP socket bound to a veth
queue. Since commit b95ed5517354 ("xsk: Bring back busy polling support
in XDP_COPY"), xsk_bind() takes the NAPI ID of a copy-mode socket from
rxq->napi. veth never sets rxq->napi, so the socket gets no NAPI ID.

Call netif_queue_set_napi() after napi_enable(), which assigns the NAPI
ID. Call it again with NULL before napi_disable(). veth is not ops
locked, so netif_queue_set_napi() requires RTNL. veth enables and
disables NAPI only in ndo_open, ndo_stop, ndo_bpf, ndo_set_features and
ethtool's set_channels. All of them are called under RTNL.

Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3570547ee99..c00ebc5b96c7 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1062,6 +1062,8 @@ static int veth_napi_enable_range(struct net_device *dev, int start, int end)
 		netif_napi_add(dev, &rq->xdp_napi, veth_poll);
 		rcu_assign_pointer(rq->xdp_prog, priv->_xdp_prog);
 		napi_enable(&rq->xdp_napi);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX,
+				     &rq->xdp_napi);
 		rcu_assign_pointer(priv->rq[i].napi, &priv->rq[i].xdp_napi);
 	}
 
@@ -1094,6 +1096,7 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		struct veth_rq *rq = &priv->rq[i];
 
 		rcu_assign_pointer(priv->rq[i].napi, NULL);
+		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
 		napi_disable(&rq->xdp_napi);
 		rcu_assign_pointer(rq->xdp_prog, NULL);
 		__netif_napi_del(&rq->xdp_napi);
-- 
2.56.0

