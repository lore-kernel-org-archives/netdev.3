Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958E346A07
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734824; cv=none; b=RUqknw0+cEYnVDQXYo+0YzKF0Nhb7I/3QjAfLzHR7LuVJ1HnAF3dQC4DEDOY3Ox1JKRQVHVrtW5EyxqOYBebjbJ/69VS5fyUZeWi+QepdK+3AoWrshKg0Os4u0n46UyyCkmI2lNr2Yo0g+Ygi4JMSi83CCGW2UurH4jKU7e0Y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734824; c=relaxed/simple;
	bh=5p4vDcOFaP8EVLCmru+xfFEOSu3zZ/sBd3hEC2MTLIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hX68GCxFWZclZtB/ALgN9AgiwcUfHWwf1N0doUHqVB710LEkgfE7TfKTnPP+tZ3wShHz+pQRQKuNypAtnK+yLB/jdJrJsJkK7Vl+LeqMPh6r3qbitk0CsagUzO6OA8x/e3aHVeUEnHJqwIWWM6/vREAUnuZ0chmFs0KUFQGLAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrFDSgrU; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrFDSgrU"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbef7b172easo2720761a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786734818; x=1787339618; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wy8ZG+hsJyjx1JOOYY1/2Ksno+/B24t+7EIU7vbc/rY=;
        b=RrFDSgrUBQM8aDzzPxRlmUJAPze1tclVWSzNDCqGECcKNYaBqTLIUuUShj/t545fRn
         0kzpupOd6PgO7FALeYGKMRhFYqiMnqPCsTWW9xN0zQUqUxIy6BGTeh3lG+KYqiR5wg1H
         aQ/TxECKQ9d/Q/XmbNd/9IjkG/uVzXzGfeQ9nQoggRXX9E964OMv4B63kyP8vdEL/b5F
         99ecmfDcd9j3GprzDsnBilhMsg6rdFzWxVRJt0xM4rljM8pzUoYfHTwpkqzXVt8W6E2/
         yuu3M6i6jTubYMbq9YwzIfaTjYpuDQwENKM1z7Fvsp/jN0vF9xxBbjVwSF6O0+LvjJ2l
         CzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734818; x=1787339618;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wy8ZG+hsJyjx1JOOYY1/2Ksno+/B24t+7EIU7vbc/rY=;
        b=A+517/rjPfhkyaQajsPH18rNTmYDMnf1IhJU63rvGLoqefS6DAKxK+mxCXeACRFDNm
         s/HYjgx9C0zp8GXqAMfd6wT4t0gPG9l9tN8tfn67QZA4SspFQuESrIVY845xj1M16NDJ
         OamyHOanUlYE+Hbl8fi2eGuqfzusyKfTZivdfAwqbNgOcoyC3fn8lOf/NqbndVt6KcHm
         Y92zJyINSEqTB368pL8UcDRHx5Jgc2yGtVc7iX+I3F5mjZR1F5k0LJbNL9eNIOGIM68v
         rRF/ltmTk0I7O01+uc6ucAq8WM22IzFmteBaOSUyfMExe0sF78r1926+Iz9VKSmSUq/z
         TIAw==
X-Forwarded-Encrypted: i=1; AHgh+RrbHzQYyaBMbagC8W6qaIoFFHFAb1D3OzuP48s1JEs+/K0oQbW6MeWcoiH5icpBtX7v4+kXy78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeXhptM5GBWGX0+CwxaauLR43/VnOErenAnjRlPWZk2j0eXBf
	a4cguRA/kIFfn39r+oWsJgowEUycLkkbg8QHUsp3JhOTqhaXKf4XBSlC1F3AbePY0XzeWqXyjlH
	czTiLwm3Hb/LnvJdiDm8W9Gn2rw==
X-Received: from dygg11.prod.google.com ([2002:a05:693c:80cb:b0:311:6294:c296])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a125:b0:3c0:e6c3:224a with SMTP id adf61e73a8af0-3cc71dce94dmr8654667637.37.1786734818491;
 Fri, 14 Aug 2026 12:13:38 -0700 (PDT)
Date: Fri, 14 Aug 2026 19:13:31 +0000
In-Reply-To: <20260814191336.187243-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814191336.187243-1-almasrymina@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814191336.187243-2-almasrymina@google.com>
Subject: [PATCH net v4 2/2] net: tcp: block mixing readable and unreadable frags
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, 
	Mina Almasry <almasrymina@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dev@openvswitch.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

Protect tcp_sendmsg_locked() from mistakenly mixing readable and
unreadable page fragments in the same SKB.

Check that the devmem binding matches the existing SKB's readability.
If a mismatch is detected, avoid collapsing and create a new segment.

Fixes: bd61848900bff ("net: devmem: Implement TX path")
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
v4:
- Adopt Eric's suggestion to check 'binding' against SKB readability
  alongside tcp_skb_can_collapse_to().
- Drop pre-existing Reviewed-by tags due to significant implementation changes.
v3: https://lore.kernel.org/r/20260811195405.3979177-2-almasrymina@google.com
v2: https://lore.kernel.org/r/20260810180956.2348280-2-almasrymina@google.com
v1: https://lore.kernel.org/r/20260801125308.1342897-3-almasrymina@google.com
---
 net/ipv4/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 455441f1b6949..b4237d0e994d6 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1240,7 +1240,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 		trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
 
-		if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
+		if (copy <= 0 || !tcp_skb_can_collapse_to(skb) ||
+		    unlikely(skb_frags_readable(skb) != !binding)) {
 			bool first_skb;
 
 new_segment:
-- 
2.55.0.691.gc56d675ccc-goog

