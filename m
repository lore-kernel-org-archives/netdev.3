Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F742392C57
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143400; cv=none; b=HEiVq5I2veVvES8WMm5AMjLvbMU95nPBffGwnRv84D8dx2LhxQdH5Nq/XFW0ohmlSgsl8KTY1SKNJ9rHAb8jMXTIcIguHreQdn7IpPxrWGGfVU5m8E4j3gEeo9QE4VC39E6SFrdcj11RQL1vSCtpzyqW+02yLyT9sUxDWt4xSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143400; c=relaxed/simple;
	bh=/YJ5ZlLhsjx3W/bnw+G9mm567SkVlYapVpFQo7O6bmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W3aIR14qtkQIQGdTrOpVlg3Z0RqzPTpTnLj/025l4QCpAcvGM9P/Wu1LOZ7jaKWwmcLJX4gVeG19uzTuGuxdYaZSn1lvt2oyOM07ok+vruKS2yb+jK9+gTPS4pwFvWOHgwQvHxSig6ecz9T72/1oX7rMc/3KGhWLynzT1WfwXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxxr2ZIA; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxxr2ZIA"
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-9012b756f76so131707685a.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778143390; x=1778748190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldNX4hjnqPv+69PJqK5nA8PHBAP3lHPK+0x1ATXTw+I=;
        b=pxxr2ZIAX+Cca+9wLbzAHbFdcA9TOFs0vM5gqgE3Z85aZE+2N1wcrUJq1lA1uq+NNy
         dWge4noSvd2gL71ZBHMY6UMx+sY6+uD3BR/G9leaE7MFDI4Vs8lVVD9RtD8qzlBsNpD1
         uYYdhnF4aSy34imrXO/JJdwmNCiuq3iy6GiFCuYhRULYreLz45KZRrgN9iRKmQrx3VD6
         SRYjhPEobYGMI59othK5Affjb7eJS3eiSlQRnRGYUnuW5oRIdsuoymC/C/lb4bKH4RPm
         yRkQXxqEVYgyVNn6kr5318OQqty1whu1JjuxYT8nhhMz2yRS3qyIf3zePMxqJtz6PWWw
         3oUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778143390; x=1778748190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldNX4hjnqPv+69PJqK5nA8PHBAP3lHPK+0x1ATXTw+I=;
        b=bewa2WWXBMDBd6Iv5kJpXEi+9oFoFYzbAMU7GC9doK3fXCdmq4vk80k7v958ZJznrS
         oRYpHJkZATXeWUl1dMjN0a5E+DJ8pe/LF/urny8JCa9+Z1zxiNL+53pCXtgmxSP1ig/4
         C3cqOzDvZrrEna+9N1xKDKwaqC7u/yTi4+YsCR6iasmYkHjqrh2XwPDfj9rZ5Ef8kMFn
         9IoymLku2n4Mi+v+mkyfsfWhLHrHWLLMAnaStxTpXWCNbNXlgUWzotV9V6E7B4t2JZwS
         RtzRVDacGUMqJ+ItbgIIuSf5RtDPthW0B7IrKOaZosjo1Yw0mYPMdxtdX+RTxm16yeVt
         9SrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/oqqurZH56KE1EHZrnhZ1mHHFsKOmSf2p1N5XT3xIHRlHtwHhvT7DkK5vBFq+laRIjacG7EAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19gUDh//DbcxlGbT0GxcY6wRTkw8CXvbdRDlQDz/H2g1Mv1Eq
	5lM6rdhQv2wQatjsAhprIlw9GR07tX3CbPBPxRLsZSvU3wknNXhMOaEsF6EpkMj96JYWPEEloCL
	v2V48R1mU8ErScA==
X-Received: from qknto14.prod.google.com ([2002:a05:620a:4c8e:b0:8eb:29c3:b17b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2905:b0:8dc:218b:db92 with SMTP id af79cd13be357-904d5ff953bmr1015226185a.40.1778143390242;
 Thu, 07 May 2026 01:43:10 -0700 (PDT)
Date: Thu,  7 May 2026 08:43:04 +0000
In-Reply-To: <20260507084305.2506115-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507084305.2506115-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507084305.2506115-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: use SKB_DROP_REASON_IP_OUTNOROUTES in tcp_v6_send_response()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
and provide IP_OUTNOROUTES drop reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/tcp_ipv6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2c3f7a739709d7b89f376f79b71173e5f2d8e64e..3574b2c28a55182d46657cfcca528a0ac0de99b7 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -980,7 +980,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 		return;
 	}
 
-	kfree_skb(buff);
+	sk_skb_reason_drop(sk, buff, SKB_DROP_REASON_IP_OUTNOROUTES);
 }
 
 static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
-- 
2.54.0.563.g4f69b47b94-goog

