Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205335C181
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786896595; cv=none; b=DlBpMKHcl/GFvEDAIorwrxp56uraXBXqPBsFdHJKj07PNjOX0wm328toAno6Fr/V3hFO6KD89RBS4ZuSXs0g9FKHdXpCI3U9TVwU7oNhcyXYWZRv/elkSb1dqlAOnXhHobVNE6qDV9OYHCWvddNx+l/dFjZqZSUnLogsjEc/t6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786896595; c=relaxed/simple;
	bh=hoCDJ2hAg3RfHuN0KXZgPx5kawdzUUNMsecAPE7ip8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm6mAZ8IqNeFSTPMFiBNoAiaMateo0REw5GyXYpvz7bIcc84UOi/87yElfhXaahwcJZo8BIfUaWe8lKst94R3FGHpEE0YlvzJ9mUnBEKeZW3e0bPXDqJT8Msy5g5Jb2GSmXqfe+QS+Y8oInmJRYlguBIzzk7ELQ+7A/ZHHMwh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Y2Ga2sAD; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Y2Ga2sAD"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so2199151b3a.1
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786896591; x=1787501391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZQUDYZ3EZ/ZcO+RApW68fejxV3BeoLnSrEey2P5t5U=;
        b=Y2Ga2sADrOUAGykVX5I5cljSoS7zhwZhWyw9NLr9farmdOb5PmxbBSV9zCicUct213
         hV53lSN02wHRyk4FYxfl/FmUPh8nQuva9BBcWnxtM7n4oUGbvrpgUhnkTvnjHUXCuF9s
         QhnaiiMDOaVPyGeJus+DRY4+jvsn/faZSL3H2FoWF29LphQ/vTrj60L1UOERou778fQL
         dwt7XnQHYUQdCoLebkSw1ZGq7FcPOMt/LfkwfzZH/2SqpW+VAJzvmkVkuqhdFl8By30H
         h+j3Q7Xk3EGk3PePd4Z0c2RspWqX2711NNXM4sT038goE9xl7A7sVG4FIE5p8CYD29pw
         UcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786896591; x=1787501391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qZQUDYZ3EZ/ZcO+RApW68fejxV3BeoLnSrEey2P5t5U=;
        b=dyZSlgHR8ST7k7mgyefJ7UKhyVg5iDZ0QXnzEci96ij7cDWWFEGouzTFX2pkyLouNV
         CMMrT+DPmsFyIx2WV7EjS+0vKAb/vEZf4eHaFumQp0yyQrngsGwVUB/4cS5N+Hdx+2Dj
         44RG3q/hlkR0zVnFyq0kLEcY1FpDekCTvvuoRuah5l7fRvJWAbK2JBmg8aJrfgs5JGEc
         dRjE3lTBL61wHoSSDNmezVqd5+DP7BlyxxZbgYkXvCAddPXbFafsn/tdiHLUgFL+ZLz1
         D/RpksUUB9EgF1dEvbKdk/YS/NU1tTqb2YtLGk52Nqh4JCK7Mtm2WIrDbyowg3mKcQ7M
         glWA==
X-Gm-Message-State: AOJu0Yys0AY/7WLUf/Fd1JOwdqQJOGexECLcawEVf8ICuZMdU5igqmaI
	xuKyB7GTJSS3KyHlLfMdi+x6mqUncwpbLmiXYII6LAzSsv/Hm9QHwLWq85qm2bc0geleWBeBWpk
	tmmfiIVooqbyRqQ==
X-Gm-Gg: AR+sD10hvvVO3gxOT8Cw0DhTTA+vDDBXQ3JC6Rpzp3YNQEZacJwYW1mPNR0dRPiuqJ9
	/WQvb33PRRDwpWJP8MMxB+PY1gJIYgL3b6bJU8aAyJ22VjPlviUyubpI3auVdBFfyUg5Im1StOt
	uIODQzf2saQkiGpc7ye8ZuKGxWE+gJoE15EgtUAwVKFjTH1WFdmxBl06rFDAkz4cEkesjId+Bas
	1dpRWNfzv2CY+iFSqYk6ulA9i+a7dE6ZhiUWYi7EZsl5Z3+PRV3C4pjZ8wD4aMuuGxGiA4SSXzN
	ZK+AEHy43LXNYDypAgmqcldwG1bkhFg3Qows6A6Is3W7TszaiS8SCzqhKpwI+zb4d2+KRFNpk0Q
	Qaaxi90nTXyjxE9gSB7WIgIiJ1f43NXL4k4WWEomCOoOCCjj2PJyVsPt872q/xLdLqwtpzeXzOy
	5PFCKGBit8wndmZkYlONRwSzTfPn5+gX+nO0NKZe9yn4l3/9Zu4dZXsZEi/hogX8vAM5qoX07D3
	lVyvKI+aS9K10pHPQcGxypcxhvqM6qNYj0=
X-Received: by 2002:a05:6a00:808d:b0:847:e2c7:59b6 with SMTP id d2e1a72fcca58-84fde1ce5d1mr19589716b3a.11.1786896590996;
        Sun, 16 Aug 2026 09:09:50 -0700 (PDT)
Received: from Roxy.localdomain (n220246089185.netvigator.com. [220.246.89.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc095a47767sm2410245a12.30.2026.08.16.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 09:09:49 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	david.lebrun@uclouvain.be,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] seg6: reset IP6CB after IPv6 decapsulation
Date: Mon, 17 Aug 2026 00:09:29 +0800
Message-ID: <cb0b571546147162dd63bd3a93952144734b1503.1786896221.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786896221.git.zhilinz@nebusec.ai>
References: <cover.1786896221.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

decap_and_validate() pulls the outer SRv6 headers and makes the
inner packet the skb network header. The IPv6 control block still
contains values collected while parsing the outer packet, including
nhoff and extension-header flags.

End.DX6 and End.DT6 then route the inner IPv6 packet directly to
the IPv6 input path. If an outer extension header left a large
nhoff, ip6_protocol_deliver_rcu() reads
skb_network_header(skb)[nhoff] from the inner packet, which may be
beyond the skb head.

Clear IP6CB after IPv6 decapsulation, restore the incoming interface,
and initialize nhoff to the inner IPv6 base-header nexthdr field before
delivering the packet.

Fixes: d7a669dd2f8b ("ipv6: sr: add helper functions for seg6local")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv6/seg6_local.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd1..4df76fa85d6b4 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -253,6 +253,11 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 
 	skb_reset_network_header(skb);
 	skb_reset_transport_header(skb);
+	if (proto == IPPROTO_IPV6) {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = skb->skb_iif;
+		IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
+	}
 	if (iptunnel_pull_offloads(skb))
 		return false;
 
-- 
2.43.0

