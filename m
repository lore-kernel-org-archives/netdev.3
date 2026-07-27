Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F79444713
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174270; cv=none; b=DZ3uH+Ggpzzqd/RL8Lpy7a4gfwoLlBxhYUYI4HTCNNIoKzGp4Hasj/zsGKgW9dTpEMTVzUfsotfe3JTRTPUzc2VYQqShTTef9SxjXHeVng3Ls+UdWVw+3ou+Ahi6h2SxDjqxsmhlsYk9STtACsc/QcwIBgVfb+0ZxPps7BK6Whw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174270; c=relaxed/simple;
	bh=RnO4B8xofzwuruJYAiYfTzYDvPzdtY4pBL7uTpyUvnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eys+F/YZfsCXh1HMHCYnVN93r0ENe50eA2rUubEL4tIAQ1bFOBjCQs4CRo891S0aaC2M0ZC/+9C8ZwZyoP+tkFu1SmECWS7OrNaAyOE21fUYhHCWY/02gJghidwHLPDJ450MZKd3GKjpPL0HZvAfxvz4T9RzArz8eDk+wvn++Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoxFPYYO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoxFPYYO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso2572175ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785174258; x=1785779058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=de7n0/7zMe2pzFIP6XqOlbz/5tk43nFIdezy+QX/xbQ=;
        b=ZoxFPYYOiur12gw3/ULJd//Q/XNPvmPt5ZLmdqwENq824OwRgDqmx7mRSA2FrdI4V7
         dZOYGp6y9Kr0AI0Bfnymr2LOTxL1AegMSpRq0ZoVp02uwJe+uv1hoBrvump15kQ2ClMi
         tztfRj9zWafgNdOsALuIr7HoccQz4jeXhQpTCFa95TdjcR7PP0TwIN1h2tVhqZf4v1rl
         MpGMZaqnLWQrIVx2Hm9zp44oidSTTUgA2TrWflCTrBVMItsH1M3B0kRlKQEA4KdNiVNb
         lt97hW1K/ygS4wf+UtxkRM54I+QzY5Ie8g1aT5VpNNLGPyriTS0E4VHAHy5ws0OPD/r+
         GwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785174258; x=1785779058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=de7n0/7zMe2pzFIP6XqOlbz/5tk43nFIdezy+QX/xbQ=;
        b=PQantpky+uPH4SfnkKWZnqbGLd2diWbHfiS0O6XPAavSjkDd/LlZjd3NtQgIzB6H/5
         IaV5JCyXdG3irUsQjKIwf52LYnnIsYu3YpfRtj2WOvra+E3qoQhDRBcBwo/4ZeG9OesB
         Qy6X8ITG0YV2DU/YIvRWNJUozwpbzg72o4yuwsxLDo6/1w8HRTfHBpfkZ9ZU73e3TgfD
         64+7jCIuaGkQJDUCJLZtA/YnIHXLl3R7qxCCzxDQH5KSJDgE9AkHHrC3jiPnoW9TOPdU
         nxXSVaviM2llwT2tovKfK8KvBAFHkHoBZD2+9sCcQb0cnno1ABCZoL7IRLKrqdYXN5Rl
         w6mw==
X-Gm-Message-State: AOJu0YzcFtmQRYHxjuDG9EnLhCIlDYXhChhz7eEYzowphR1ReQoeLwgz
	hSx5pPXPNOTiXD6Xll+y+QTbJRyZn9gcDk/e0UcZXHW1ueNE9w1n6hwCj9VOcX7CZCI=
X-Gm-Gg: AR+sD13WNb+LPmSWv8POZJkeHXfXTPAjQ6FPjzO5hs+INwQ0s39g8NHLmMaVCBqGIup
	w+1sp1RfKRdClXng0wU7Z6VAZidtKhTXyaXPRbxv6tnyThVPXQHJYNoktp4s9M0qNn5AnGUinS+
	ayYjGa5uiMcXIQV9hODa/PLWsvbXO08ikZKUbv8gS80pYTHE+KYM0kvM0IQvA1OVzSZCSX6uYrH
	b1mnM2xPh7TcpEVmFZ+B680l2y8dRSQKcISPSvD2TBrl1zUUUbCa59t4ASWRwlMRHn1f70DGUpB
	vk9PEKsN1yL1uhSUKFddU9X8LlFt8AAQoXBSFa/5G7ACsrTuq+BZDzqm9MMQR3czfIGHBhgp+CC
	HqyStxLYzvGCVkghMEiA+VgOy/5x65miOB5kfl++Src/PiJYqCGfnplJYq0q3oougpiJ0v4dSmT
	adm3RmQP8AM2tBBIWPtjP2
X-Received: by 2002:a17:902:ce8c:b0:2cc:a08a:7743 with SMTP id d9443c01a7336-2d00e7e42aamr3894605ad.20.1785174258437;
        Mon, 27 Jul 2026 10:44:18 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([219.141.235.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d00599b631sm9896855ad.42.2026.07.27.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 10:44:18 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] xfrm: hold input state around secpath resets
Date: Tue, 28 Jul 2026 01:44:10 +0800
Message-ID: <89be67de93958a00193c8c4bd668733c976e2aa9.1785135576.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785135576.git.zhilinz@nebusec.ai>
References: <cover.1785135576.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

xfrm_input() keeps the current state reference through the skb secpath
while it performs final transport processing.  Some input paths can reset
the secpath before xfrm_input() is done dereferencing that state.

Receive callback users such as VTI and XFRM interfaces can scrub packets
that cross network namespaces by resetting the secpath.  The
XFRM_MAX_DEPTH error path can also reset the secpath before the final drop
callback reads the current state's type.  If that drops the last state
reference and the state is concurrently deleted, xfrm_input() can still
dereference the freed state.

Take a temporary state reference before invoking the receive callback and
before resetting the secpath on the max-depth error path.  Release it after
xfrm_input() no longer dereferences the state.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/xfrm/xfrm_input.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index eecab337bd0a7..f4deca8b4aab2 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -479,6 +479,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	int async = 0;
 	bool xfrm_gro = false;
 	bool crypto_done = false;
+	bool x_held = false;
 	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct sec_path *sp;
 
@@ -585,6 +586,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		sp = skb_sec_path(skb);
 
 		if (sp->len == XFRM_MAX_DEPTH) {
+			if (x) {
+				xfrm_state_hold(x);
+				x_held = true;
+			}
 			secpath_reset(skb);
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
 			goto drop;
@@ -727,6 +732,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		crypto_done = false;
 	} while (!err);
 
+	xfrm_state_hold(x);
+	x_held = true;
+
 	rcu_read_lock();
 	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
 	if (err) {
@@ -746,6 +754,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			dev_put(dev);
 		gro_cells_receive(&gro_cells, skb);
 		rcu_read_unlock();
+		xfrm_state_put(x);
 		return 0;
 	} else {
 		xo = xfrm_offload(skb);
@@ -768,6 +777,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		if (async)
 			dev_put(dev);
 		rcu_read_unlock();
+		xfrm_state_put(x);
 		return err;
 	}
 
@@ -777,6 +787,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (async)
 		dev_put(dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
+	if (x_held)
+		xfrm_state_put(x);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.43.0
