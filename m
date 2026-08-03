Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ECB399CFC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763762; cv=none; b=hgF9JaiM6pswL7w4TrE/tB/TxKCgYp6CQhwGDea1+VpJE6yWGogxgZJHuoNSt7IsMqPoeGAyxRdxAGASYru0DhHQCsZ8em1IQibJavPTVbyqUJydJniz5zGMaJ/PXkBAztR8sW/RSxrFcZUt/vFy7NL3PRGulLelCyWgHyq4XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763762; c=relaxed/simple;
	bh=zlmxBN6AjVFU2JOlA+RvGaQWUI8WLACOKFwqGp1SNS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckwL0HDbQTp0lIHShtW0tr1Fm12OLpZzJBsLjB3irQ0t5YiKHQh3I16pRzVUVAgsXcICQaZ8PiT6FtHUE11kn29yGsTkCe95FrL0IU+JCwfLCfunTKbn5bSEEmppQBF2KUHBn9xJHqe9cnj3RJZXogXuBr2ZFC/6OJtfrSIxPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=KQiub+6N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="KQiub+6N"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cacb8416a1so33200515ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785763756; x=1786368556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z4YQi+JyaHbTbHUIotpQlDfIOIeCbf8h1dzmlzUAGOw=;
        b=KQiub+6Ns0eipk9qe/6wbOebTTrbVM4T0iQKDLctOE8J6rFct8ejamgWz5R3yKNyzR
         K02d5HCYCa4/wVktjLD6yNGF/Kx30c0wGI/vTVqRBlwgM+OuagB2/iDoCXf2eM9d4iQQ
         LDlfn2PqoC7mvQsPJy/c+fLJRy4UGovlOVEtFE/hKwWaURdmii56Obbv0gnWGsuLOLAw
         I+mqsL8kGkLVMdjhJmA5CPFAE8VISenFNAVGPSmMtFGiPtHlASAbVv5mMgZcAJchh+Mh
         kOiz/odLCviy3tNJnkB7AXNNp6VYQWA1lNZgIhFpveu+vKVV28Az4YpPzX/hE28Mlx9P
         7liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763756; x=1786368556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z4YQi+JyaHbTbHUIotpQlDfIOIeCbf8h1dzmlzUAGOw=;
        b=nrd5xf1wlnrJ/ZfUNt/iuMNzsK2MnE3hzYxM1y6KEbr3j6cFZMYxC1ar5vvixgTVM1
         NjSx6+6di85wynlWbVJzrFGu7bl0xG9BmBdKTwor8q6jkeN4iF7cNLPWa78eLPQ12xJ5
         11oQh7RfLy4P6KyOmWbBfBsw9S5RUA7UdzlrVZ8aW5Dp88lPTTa2/PlLAhlmhNBSXiLX
         Y6EnLbkyhQqJM9fJMiH+ST1g7gOmOStDFXRF+pNgR1mneNq889WjIfVWq4OFm/6fGDfP
         5IEiHDQ1uddDKEyIB8c5maNjphpOtZlA4n2LuEyjLIersG8vhhLNCYqKqRqauJUBazLN
         ZRzg==
X-Gm-Message-State: AOJu0Yxi+LnYTV2l7lOuBgJATGqyyKVfE26rmkoqDB9WUCarZNgGOA7m
	MRr9xEdDIAktlOY8XUeaOe8V46Oo386055rUTcUhHdV4gFCIhnXg/DhQkzIKRoxLc6WDWaRLDPA
	F4IoQCCwrlUzSvg==
X-Gm-Gg: AR+sD13KQNpe1eejh3JuQ9vgY2iGvs1rH0GWU8Vd0hs8XTbEIUuxelcfjirTTyYtBAJ
	AxJ/0SFO/o/RGb7+t9kaN0UD/+E0xfeU97bRsCDBjSsEpl/Jwy67z2Ej3Kh2kCBqtea1tVnTL/d
	JzI9sYHhZzkj30ZXtBj2Yhzdiwv/39iVWJMigsAFa/PIzuedyU18dAcRhZUP8B8qMySNq4u3dYe
	2U6sgPt/GA9yChNkqas9Hn3PCRD1O5jor8Fcw1ZgYcggUYFgbeja/gvCVe7aqOxOrfxwPaQ3SvY
	Eg+UHDQKvehcP6G5bgVCH+73YgjYikI9YSYVnzqZmZ9vYKlpR9CY7+nUogpQOANt98F6hAFW7GC
	bGQeS81Lji5olC8N65+8Zv8ok/AWOOChZTQtJKzbV00H6akyowkqLirauojiO+NzNuhudDUB0vT
	7aMsb5G+cPd2pOJ1XeZeHaVbk4mrX0f+N8Bw+Nc9I5yOgWtpw02hByhylmItwCPV5qY8tvT51V2
	qS1sxXtLXVa6+I=
X-Received: by 2002:a17:902:ebc3:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2d052188c55mr108930625ad.5.1785763755923;
        Mon, 03 Aug 2026 06:29:15 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1594b0sm37924575ad.71.2026.08.03.06.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 06:29:14 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] ipv6: xfrm: use full sockets in local error paths
Date: Mon,  3 Aug 2026 21:28:58 +0800
Message-ID: <b0a24c61d507fce6f881d95e233302e93227ad33.1785761237.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785761237.git.zhilinz@nebusec.ai>
References: <cover.1785761237.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xfrm6_local_rxpmtu() and xfrm6_local_error() dereference skb->sk as if it
always pointed at a full IPv6 socket.

That is not guaranteed. TCP SYN-ACK skbs can be owned by a
TCP_NEW_SYN_RECV request_sock while the output path itself is driven by the
full listener. If rerouting selects an IPv6 XFRM tunnel route with a lower
MTU, the local PMTU/error handling path can reach these callbacks with that
mini-socket still attached to the skb.

The callbacks then miscast the request socket as a full inet/IPv6 socket and
can read beyond the request_sock allocation when they access inet_sock or
ipv6_pinfo state.

Resolve the owner with skb_to_full_sk() in both callbacks and bail out when
no full socket is attached. This matches the surrounding XFRM IPv6 PMTU/error
logic, which already reasons about full sockets with skb_to_full_sk().

Fixes: dd767856a36e ("xfrm6: Don't call icmpv6_send on local error")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv6/xfrm6_output.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 512bdaf136997..44b221a09a0c8 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -19,7 +19,10 @@
 void xfrm6_local_rxpmtu(struct sk_buff *skb, u32 mtu)
 {
 	struct flowi6 fl6;
-	struct sock *sk = skb->sk;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	fl6.flowi6_oif = sk->sk_bound_dev_if;
 	fl6.daddr = ipv6_hdr(skb)->daddr;
@@ -31,7 +34,10 @@ void xfrm6_local_error(struct sk_buff *skb, u32 mtu)
 {
 	struct flowi6 fl6;
 	const struct ipv6hdr *hdr;
-	struct sock *sk = skb->sk;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	hdr = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
 	fl6.fl6_dport = inet_sk(sk)->inet_dport;
-- 
2.43.0

