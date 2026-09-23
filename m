Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489B3E1CE8
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152911; cv=none; b=OKMFWBQl/vxwETm7ppwAKw3S2cCeS0zzJDVjYiUrXKxZ/vTD71lkD39O+p50mdiHrW3a6s32fy3Nwl1/3uO7ou3mWgiN8fRHvX+Qd7qP2bDOQH99NlcGja3qRFb47UTC7M4sFhz8OXuKc/qMojLnD7mNacNcQ0Q6izUoQUfKHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152911; c=relaxed/simple;
	bh=JBKcOwAEdetIft+G0VLRRMdAb2fsp/mThSWcE/BMWbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAbWyDhD5tuWx2bu2btt7mNqqr28LHO1RrOS2QK1pMA24iET66n8I9gFq1gdXYfPuZnCiT1jbjNGH7NOD6xWq5dMEzHjl8AzH9DE+Hid2QUtbQI5J+RXq/TA0DGKapd6A/vSBw1cf44Hs1lBJcM5Q6t1Ph48jyf03asp66NZnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctNm/6WQ; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctNm/6WQ"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39e57ee1cb0so100190a91.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790152900; x=1790757700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IK/9xof0M9dykI6mXJx5UlIoLyJfcd62zRK29ZUyL44=;
        b=ctNm/6WQ3r37hgjFuQ5izGgfpgFhKMFAIZ3Sk/0ug36W+9UluMXblRAMYNryESnd0N
         GjulXDrlZ8x9C8FUyMNL7u+yB7HFTeLQCLnMxSzMWBKbkHYSKGv7y2Sf9mbG6kfj7uw7
         Jk5a9nANU8cN/5OxsKNHZWnZFjatDYx9IbWHhRYYfcI8KYIyw7vaWUVOtpEpUscYB6+i
         M0VdAgEW1r4AogS6FzDzBVgHa7109npJQp7iYfLFHWuud17Dh4pqcE8ciNPwSsclVzzh
         zeueFIUpom2kSFGbYj7MXUM07P7gBTeV8UJZQVzIFk1C7TJrI7DFvvqY6TTAoJ0yZkPX
         mIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152900; x=1790757700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IK/9xof0M9dykI6mXJx5UlIoLyJfcd62zRK29ZUyL44=;
        b=CrRDQH4jetuXgnrOgEWoNv7Tkj4CSVUYApvnZj2L/ani5DOSRbLS1zbbWcac1Hyl5o
         JaBL7QdOUjCaNKAA9dVGBvwNoSc7MtA51H+d3IAnAuk0QX9i+ICq/djRVlIHj7fmM1fH
         CJCbtnYOj/jLeShxGxaFl2XYmJRSwDU4uUevkdeiuqKojuO0DSkdCcnY3BbPTFg0Z4tq
         /vEeXOPSYPfeeONrxokNyj7rAh1DPf9BNdpvI1ZOz/P4QAImlXm/4xFHKXMUaOh7pAJL
         w2ARHusJlNgDOZkod8DU5cEwIb6z4maD2DJ9dn4JLdty8Bx2OMY3YeMTLlZM9qLSycF6
         DiiQ==
X-Gm-Message-State: AFuF++kndd9h0pn9kBevjlfjC87RxYSLKsfTUdpJPWvnmBf6Xo7+3G7d
	cn5+tcisTR57lkpsCiw4oIlWG67FMYFQ4Js0qHEX+KWNPZP7gLQpp74L0Fbo5HVb
X-Gm-Gg: AYBFou3fYfOLciuWx5NqT05fJjh30idH04pMVzRi0nsv248FkhIiFoU229QI6Y80vQ3
	TCrbgTUESgk6GuJu7IcF0ZdRjDsa14rVrgYTRhHFFf1UBqps9tyz7UmtKk7t5I6CzTtJRFuKYoD
	T9AV6vsm5/vckO8p7R4nZcEbjCb77Uftq5aRtBmreoHOb4pqUZ38Vp3CXC6hMwB7uBcP59eMDNj
	xfjZGGc0grq34qZEsgBL9T/IZ5DPqqciMvznznDZB2r+89CKzNbYdddai01qf0C3vSjo4kO/km/
	3qcNnRYju4bFhI5aVI+g2nlV9FCa8f+U9A7/tWcu3zPjIU2J7LQJ31M7ENMQ+wzKHlYMtFWS0VV
	6vyiP5XIEKVLnPWF5tF4RafDCtfTQBV29idwoVbglq6Tq75fu/1Ng/GR1URf4nhmaT0nOz0CxLM
	Jl+OmHWz+77ivxfuOil3ZpP9/oyKThPzljswBE2VID0qzp67uK4JoRn7Xw1j3oRd9NBCBTMAMMF
	9vroIzGBt4zK3mKSyaUppAI24wc0aYLTvMH82mi82Pb2Nup/sDB8i/0lMyc7Q==
X-Received: by 2002:a17:90b:2b45:b0:39e:2344:da1 with SMTP id 98e67ed59e1d1-3a07e74759bmr2686964a91.4.1790152900163;
        Wed, 23 Sep 2026 01:41:40 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de50cbdsm3861002a91.15.2026.09.23.01.41.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 01:41:39 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org
Subject: [PATCH net v4] xfrm: interface: validate the IP header on xmit
Date: Wed, 23 Sep 2026 16:41:23 +0800
Message-ID: <20260923084123.10734-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach the xfrm output path without IP header validation, but
xfrm4_transport_output() uses iph->ihl for __skb_pull() and memmove()
and expects the header to be valid.

vti_tunnel_xmit() already calls pskb_inet_may_pull() before handing
packets to the xfrm output path.  Do the same in xfrmi_xmit() and
perform the header checks ip_rcv_core()/ip6_rcv_core() do on entry
to the IP stack: reject wrong IP versions and malformed IPv4 header
lengths.

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
Changes since v3: also check the IP version of both families, like
ip_rcv_core()/ip6_rcv_core() do (Herbert Xu).

 net/xfrm/xfrm_interface_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 688306bf62c5..9835fbe63ccb 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -531,8 +531,13 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	memset(&fl, 0, sizeof(fl));
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
+		if (ipv6_hdr(skb)->version != 6)
+			goto tx_err;
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
 		if (!dst) {
@@ -548,6 +553,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
+		if (ip_hdr(skb)->version != 4 || ip_hdr(skb)->ihl < 5 ||
+		    !pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
+			goto tx_err;
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		if (!dst) {
-- 
2.46.0
