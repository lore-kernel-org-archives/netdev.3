Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435124;
	b=MCY9InXTGpIhKLjQmEAYoFkZX1h0lk19hMi8beLTwiI+AUKUEt9ENLQs4RuPAOujm2UJ
	 Q0uysj5H8x6Fjs5S/hTk5Q0IWO1JXeQDDHxfnV0XYVHuf/gfzLS91ROQ7Bvd4P2aR/Q43
	 3wIQgbZmR3tNybjIqJLkXLKjayEssbtuCsQhyNCdzpKNU9s5aR1vAMualN+bi2zAoNqjJ
	 siqC9DA6777BoeLMTMfhoHUgm8yeOaudBCHe+PEvegN/Fr7qt4QtlrOkQ781KxbLXB93+
	 AWFvUn89h9DWGqnOeE8eeCdgvPgIf2aIFcJiIbQae9vxeozwnhZUQ4puORxhUHTVAzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YusQ8PlgAGqBdQdfglodyV3rGnWf6b61Lk1KvehKD9M=;
	b=If/xmEm5d59202eShsdevMq43tdd5LwNz/koz9kM3t+2fvDGNQXKxE5SwqFZqwj9hpzy
	 YLuj6iGH4M9VB85vQe3wd0Z+GGDH31mohx1nvOHQMTAsQsqd2Sdg9k2uAjQD3ftOwRj1x
	 h9SgQdrQdqsd14pFgo5XSG3ynS6enAV4A3YPg4y/e8K52LEgbdQY9WYPAhZOOQH25/6sF
	 H8OnX2kjkBCQMIb/Dhh0KOY8s9AlNkgler9JBVoc4XhjjJv3GlaqVI4CGJ3ztefP4rv0F
	 77YtIYHqFowwuJDQovXZPAMSLoMl+v8i4QuPKMC+2EEk38kht41vVCpkJ0c9rKgyHOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJEf4wzt;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9C606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C9C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJEf4wzt
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so2426804e0c.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435122; x=1795039922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YusQ8PlgAGqBdQdfglodyV3rGnWf6b61Lk1KvehKD9M=;
        b=OJEf4wztHUDi7BsM+plgvShXgiwGdHpEG1KE3uG7ykCHYPZL5IiAAVx6WqM5iCKL8U
         R5i11xbcLBqsKEhUFhL+OMGX3pHekqxWS3pUbMl2l/rv6BztG/W8kKaReZasPQQLhMDR
         ckJyLrtSwnh2T9/qp4XANIelY3ZQqsdcYGHnajZ+0aUvSoZ4rPXgwgy/nTjvgXY5378b
         7SCCFsStYL+nAhLdIsQj1TCaCtGSxpzllIPOKBiesqpT22x2XYYh+6nQiycyDSE/9e8j
         EdZZ87yii8NxbypcCI79bdxXEvLIwb1dSYPfAwmjSrqbdMlswsSuJU/hVXrBTrKypP1+
         8/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435122; x=1795039922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YusQ8PlgAGqBdQdfglodyV3rGnWf6b61Lk1KvehKD9M=;
        b=XWqPGtgRv2+7zwtIlkQqX3vybXlaKdQLsnQZ07DdmJCNNEUp+3T6Yt/4c29ebZO9j5
         neTMyorCkwg2oDFl6eBko4GKa4t0xm8e62wR3idUrOGwcb0bi8mu0POHNeAte7+B+RKA
         z/EK5mSryPxV4OCXLJl12rlH2nsNz9u7Z4z5a9eCyrVU8EKcgRKirnRweLbuDr7jprUP
         Fjg8RAtiGaP7Ml1r+5WU9vyDEP28vEMbPU7Z4Cu4HPFB+8635CcoR+YvI2IBY1VHT3un
         pUG1V0Y2IKG3lrnf7YOZESO3pV7Xj6APDcDACV1/h1Zr7z+MTJRnnAfsuKrgird0jFen
         Uc+Q==
X-Gm-Message-State: APuU4Z91/gHhtCYQSFV/3UwgdVUvJcWWNrdcci7KRJhJ1mQNyOAf/el2
	FRMm76TA3sHW7n+eLn8y/JFi+SNz4L3K6OlohWi5kuTijBmJMhQg+rvpChacVw==
X-Gm-Gg: AYBFou2XsWiMqf2kltNfWANEC0oEn01hxTtU1Gtv3wtQylZVpNw5nh6YB+z4okx94eC
	ZykV7tcdbXiEl1JY99ayANFU9ZHD92H4Wk6kPHETFlzRPu4nHspkhUnCOK1y2EGpV+sXsZGu9hx
	FleE8ddtqH04eBnVqTy1aCXbRhrPjg2Y6oOaGRbXNX03bSfVtkyiCpzQyM00YCJ858JMO5LLnpD
	GqbuIqvTn1/zj/d4oWlpGk6mdkW4UubSxUBhI/8v/xQiXu3IzyF6N2aqw4vGpUzRh3wH0/uboUK
	Cqcw5rrCRJ85Y+BEkPMusXOddYSWJluxY852k9A3WDooFk57BYSQvWa/Ypq8iG57MwCydiJ7E7u
	QlEa7w+YuJcP2zIK2CexGxfepIA1cjEfHLmX6PH2wzmVlZx7zba+Alvewl8ub4/71qOCHlS5DaW
	cyzcZQ3bPwkwMgSIZgWkmdlE7vETMm26n+lltJU9eOcdzWUyGCQjHCeZq+jU5n696/oLYUhph99
	mEZzC6qh8CyukLn6kZNoKFVZXKwidf1nGop34LN6nVvublldOjfGOG/oQ6tcWY2QvNo4ZjqY0na
	TRpzJ7sjL82otdovnnE9gjMDEbGpuuuxAhEtmSip73dPMuW9NZ/pDrcgqM2Q9R/2KRKBpI4V553
	TBgcHg5riz7TV7fNaL6V9FGvDPuoCU60YY+zw9fzGrnvo2Duhn1vGYUGQ615onBP+uyIxnnq2h9
	XZ+fqwGeQNogg=
X-Received: by 2002:a05:6122:62e6:b0:5ea:c11b:431a with SMTP id 71dfb90a1353d-5ee1c408083mr1682066e0c.9.1794435122563;
        Wed, 11 Nov 2026 14:12:02 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee27570155sm436357e0c.12.2026.11.11.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:12:02 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	Hassan Sultan <hassansultan@google.com>
Subject: [PATCH net] net: gso: fall back to skb_segment when fraglist cannot satisfy checksum
Date: Wed, 11 Nov 2026 17:10:33 -0500
Message-ID: <20261111221129.829218-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

From: Willem de Bruijn <willemb@google.com>

skb_segment_list() keeps the original transport headers and checksum
state of its frag_list members. It ignores the checksum bits in features
and does not initialize the SKB_GSO_CB() checksum state. This breaks in
two cases:

1. Outer tunnel checksums. __skb_udp_tunnel_segment() and
   gre_gso_segment() compute them with gso_make_checksum(), which
   reads SKB_GSO_CB() fields that hold stale skb->cb contents. The
   outer checksum also needs the inner payload sum, which
   skb_segment_list() does not compute.

2. CHECKSUM_PARTIAL packets, for example from veth or tun, sent to a
   device that cannot checksum them. skb_segment_list() does not fix
   this up, unlike skb_segment().

Fall back to more generic skb_segment() in these cases, as already done
for modified geometry and SKB_GSO_DODGY. Expand to when

- skb->encapsulation is set (IPIP, ESP)
- skb_tnl_header_len() is non-zero (UDP, GRE and MPLS tunnels)
- the features cannot checksum a CHECKSUM_PARTIAL packet.

skb_segment is a strict superset of skb_segment_list functionality.
This is always safe.

This also moves encapsulated packets that were handled correctly, such
as those in tunnels without outer checksums, to the slower
skb_segment() path. Fraglist GRO is off by default.

Discovered through analysis by an LLM. Reproduced on an unmodified
kernel and verified with LLM-generated reproducers in virtme-ng.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
Cc: stable@vger.kernel.org
Reported-by: Hassan Sultan <hassansultan@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/tcp_offload.c   | 5 ++++-
 net/ipv4/udp_offload.c   | 7 ++++++-
 net/ipv6/tcpv6_offload.c | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b84fcd07c723..127035ba4faa 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -108,7 +108,10 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 		struct tcphdr *th = tcp_hdr(skb);
 
 		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
-		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) &&
+		    !skb->encapsulation && !skb_tnl_header_len(skb) &&
+		    (skb->ip_summed != CHECKSUM_PARTIAL ||
+		     can_checksum_protocol(features, htons(ETH_P_IP))))
 			return __tcp4_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cd9d7426b227..8e9610d35083 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -516,7 +516,12 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
 		 /* Detect modified geometry and pass those to skb_segment. */
 		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
-		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
+		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY) &&
+		    !gso_skb->encapsulation && !skb_tnl_header_len(gso_skb) &&
+		    (gso_skb->ip_summed != CHECKSUM_PARTIAL ||
+		     can_checksum_protocol(features,
+					   is_ipv6 ? htons(ETH_P_IPV6) :
+						     htons(ETH_P_IP))))
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
 		ret = __skb_linearize(gso_skb);
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index eec3778855eb..5b830d244660 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h>
 #include <net/inet6_hashtables.h>
 #include <net/gro.h>
+#include <net/gso.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/ip6_checksum.h>
@@ -180,7 +181,10 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 		struct tcphdr *th = tcp_hdr(skb);
 
 		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
-		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) &&
+		    !skb->encapsulation && !skb_tnl_header_len(skb) &&
+		    (skb->ip_summed != CHECKSUM_PARTIAL ||
+		     can_checksum_protocol(features, htons(ETH_P_IPV6))))
 			return __tcp6_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
-- 
2.56.0.567.gdb80ae8cd5-goog

