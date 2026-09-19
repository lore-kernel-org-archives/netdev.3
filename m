Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D1339B41
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851982; cv=none; b=n3EqCrwwLCd3aeEqMcl3kx9bXmNLkd35s9uaLah58fXovtjhxWSgabMXuoJBekfbF/1vjMxfa7R5mZRFpXZXekNpVujKTzLJxAsA1nq4T5ZXcM7bZlDlkwtCyLEQH11V+162uDw6I7Yl7meMY9frNF2lO+c895llDptxPq8N+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851982; c=relaxed/simple;
	bh=xTAsRBwQetmXiS0TM8pGaLbfvMYZLQyBOBoEh5Rb2p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQkO8E+4+8Ku1ftyorGkzMWGij023lu8J/XIKnQzLYGOBgne7GdjSm+Ze69mYK9cIiu5/VSjelm/NP8Yt1RGVNNxzPzbtWYSsAI8Ftdz4BM4YQKFalJ723fHzoW0/QsAlkMbJDGKL1+g2XfFpc5BepNnHTU74FwlCfQM5HDs2eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOxLWxer; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOxLWxer"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1500268a12.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851981; x=1790456781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VQo3syVkKE2lsVXDLjtQlNIZvvc+qy+7eQw8WhwcqWI=;
        b=kOxLWxerve2rnx55bTW89andJ0X5xgC0tVf53kSyocPSSx2hdADuBP4+w3ZfzL47Vr
         uh3XujmSZSvs+aua28f6gUI28tROfOECMjtt5SQQOf8280y4wN1hGQ1gjjICI0n40c8G
         oNbOiO1HiJpUwMwIk3789OjBD7ittCoM9lz/SSCUcm+Q+zFvGzWYxNaFIzYk97/rtaiw
         0iGtFj4vwmOFmVDbdP9hoXJaxkX+z9MP9HFM2djkwO4fp4bT102V+69MxFYUDAuNnLO1
         1KaiXsP+3k213sBwsBjWuDLSl/PcKiaTOF8KWU1VW/AkZwSyWDDYyVIUlvWj+yqqW637
         SiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851981; x=1790456781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VQo3syVkKE2lsVXDLjtQlNIZvvc+qy+7eQw8WhwcqWI=;
        b=OUZ3XQDA5tcXUnjFquIXcbXFxruJZ8bGwPqRfp30gau0/eMNSzVNzIUmxtZ+P0nPHE
         QUm0akWSpvwGq06ec+jKmMNPEakvuePTIV2YMjr1/JHzSLB6XPjCOxUJJDm33mk9UzBA
         /VJ7QaIGOva+8Mqf7N81MqPq1fsFBEHI73b5zTp9nE+EMVj2Z5vEn9HCuGRbHj4VKktd
         YY1zEWiuA7wCORJ4qYPxzwnrzmdA2AnF9r8WFL1hijO//oKjD5HPDcAp6W4QGsn5eygK
         Z4HeSOpKE3GHFv/c2/3Zd3jNqrOx8q0iu7WJUqyWv7E+8uuwGY2llgv/CabP1Hweh3nY
         CJ9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxAYZZ5ZVLyA4Zvpk9kdVsCcKveY5RZpC7dLpsUlFT6LunotqaWvSesM77+A1zXm5i5hCZBJCU=@vger.kernel.org
X-Gm-Message-State: AFuF++lHQkwmzuYXWrm26Bwi6qc5WHuRHyxwyu6AvNAGNySEwN89aQno
	kWKK15pk3khjFeZhfvTq6LArJQSLlUO9SNSaOHtBKp/fXKDe0UxuvFZx
X-Gm-Gg: AYBFou3XRbDVj+nmpvimDt1t80aMZ1gnFGUKSlOiXWC/B5oKSZl2CGaegRgVTperzxw
	3QmQA2Il5uXGWVlnm+6wuZoGLWJA8LRqsWcUgmvT6AYtIa2ZCXrfDx7TA30Jj6lwrFtbp1mTxmB
	qoG4oiBjGSvTt1h31tcFV/x/LzzZQId7BdI4Phai8oKNyw+ksfxO4eljhwApvqKm/oq/+eaN+2F
	Nm5NuHHQ+xqNokTw4K9dck+5i2pBb7g0gTCRFVqAu3X3fTdDq44+1MS89Y5GrIzTJ/LmqwMHMT5
	1VeQiV4C6nniwuXC8gK389ytzymKtsRZEG6Q8CZefnhUl0tsuh3in0zpcGMuhTVMjlHmBrDEek+
	LiHI+qlICjXlXLGX0B4nxvAoWu/Oib9/cG3igjZY9rdbvryRw8fpQpusQGY/E82NXCuSeN57PN+
	ZwT8f0k/1s7+LAtOlmlpanonGV+CDml6PG2u+ks4tfamftUsxXfZZMSKWAUJPM8J4z/A13ygwpc
	TT3fwWpE6ExS+OtnA3RmYPkNSTrYqn61MOkvp8hqjcltXqctmzBqlJ57DuZ78dL6ZC8MXeO+YzW
	W42k3CqwiA==
X-Received: by 2002:a17:90a:c089:b0:39e:6c68:c78d with SMTP id 98e67ed59e1d1-39e6c68caf1mr3686758a91.67.1789851980666;
        Sat, 19 Sep 2026 14:06:20 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm6903246a91.2.2026.09.19.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:20 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfrm: input: fix 4-bit iph->ihl overflow and OOB read in xfrm4_remove_beet_encap()
Date: Sat, 19 Sep 2026 21:06:19 +0000
Message-ID: <20260919210619.3029202-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xfrm4_remove_beet_encap(), when the BEET pseudo-header is present
(XFRM_MODE_SKB_CB(skb)->protocol == IPPROTO_BEETPH), two validation
flaws exist in option decapsulation:

1. optlen is checked against `optlen > 250` instead of `MAX_IPOPTLEN`
   (40). Later, `iph->ihl += optlen / 4` adds up to 62 to the 4-bit
   `iph->ihl` field (which starts at 5), wrapping the 4-bit unsigned
   bitfield around 16 and producing a bogus IPv4 header length smaller
   than 20 bytes.
2. Only `pskb_may_pull(skb, phlen)` is checked before `__skb_pull(skb,
   phlen)` and `ip_fast_csum(skb_network_header(skb), iph->ihl)`. If the
   trailing `optlen` bytes reside in non-linear skb fragments (or beyond
   the packet), `ip_fast_csum()` reads `optlen` bytes past
   `skb_tail_pointer(skb)`.

Cap `optlen` at `MAX_IPOPTLEN` (40) and ensure `pskb_may_pull(skb, phlen
+ optlen)` succeeds before pulling `phlen`.

Fixes: 0a69452cb45a ("[XFRM]: BEET mode")
Fixes: 227620e29509 ("[IPSEC]: Separate inner/outer mode processing on input")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 5ed87d51392a..3ed5fb0c755c 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -197,12 +197,12 @@ static int xfrm4_remove_beet_encap(struct xfrm_state *x, struct sk_buff *skb)
 
 		phlen = sizeof(*ph) + ph->padlen;
 		optlen = ph->hdrlen * 8 + (IPV4_BEET_PHMAXLEN - phlen);
-		if (optlen < 0 || optlen & 3 || optlen > 250)
+		if (optlen < 0 || optlen & 3 || optlen > MAX_IPOPTLEN)
 			goto out;
 
 		XFRM_MODE_SKB_CB(skb)->protocol = ph->nexthdr;
 
-		if (!pskb_may_pull(skb, phlen))
+		if (!pskb_may_pull(skb, phlen + optlen))
 			goto out;
 		__skb_pull(skb, phlen);
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog

