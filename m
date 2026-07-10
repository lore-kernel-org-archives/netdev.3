Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51720C00C
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707201; cv=none; b=KRtxLkmXpnGH+nnYHBR8FpF0DwcQFy/+2rctWdX9V1j1pyewzBUQrNefCNx9F+cFdoNUGa7549Wm3AeRqrZJfMiQcaXdr3ErnyTvwR+RA1IuGfQ8yGbaDz0PkXEgp0d4R8/YvAZAfoIOVfNePQiSGBvJV/yjT3kRqnuhyVWIIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707201; c=relaxed/simple;
	bh=+Vx4GshpySG7fDZG3l7TaQ2Ns+/jv8WfL74syZASVlQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DA1dVXKKDJLXfVqEA8qaw3t92YyCY4Ra8YIAMToFu4+GP7uPvjh92qtNuPIEuuzO7jtCFiaFSGitljcS0LmuM8RY+EvT/wLj0lsD6kll9BFB3CvfO9GSt0CaHcnp8UausmHZjQEaeYePtoXdVZJE6C6/VZzhhvJnx7JPuF5+88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xj80A0yc; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj80A0yc"
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8f0f45415cfso16895256d6.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783707199; x=1784311999; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vs3MKxXVP0aq6vbYhNNah/NyPtH6K3InS8zr69gCZh8=;
        b=Xj80A0ycowHZTrvzu+YsU/Wa/7PfwJ9XFGG1dzth4ljLFN1tNjMBYL/FAL3CLA4CBu
         xFbmp590xjbI7Jtrfygklo6wO+ZpYmyKPLewaoPIa9WoIGJnN7ospEqUhDBUxbmk6rh/
         CDUroSx9YS1c+S2cZkf+XocRx5xWHp8Eulu9M611pE9ntbjwxs4LvLYrA+luPpVV8FU+
         SDwZOGtVkQslFy6w47N3F0zGJdL56FjnXskAH6GIgpFJKP91XzCoHUvXcC6vTteUphKC
         ESJowH6xvMAAec526CF8M3XK1ym7MGCh7oGIWIKEN6RfHsKZ3XtOgafHoxh7WYgY+mGS
         2rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707199; x=1784311999;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vs3MKxXVP0aq6vbYhNNah/NyPtH6K3InS8zr69gCZh8=;
        b=LCL+H0RcYcO4L81Ak1tT5raCgnYiCs/yiulmQmY+G4RYd0Vyst+8VR++bOcP17VtxO
         pZyXphQEcjlXDVbEEE9OQYqBv6hAdARBrvSBQ/dQ4n03SYi9wxORmGRvEuChejOAYccO
         eX05LGwuvR2WJ+cWzraV7HNZaBJJ7xHxKH+dRBJEYtHT+/3Ybsg7XSsSOYaMPJPfF2Oy
         kC683qIG36YCvu8BmxXaY4XyDCbg0+6paAMI/0Xh6nGkBgknDbHqF0dT3FFuz9u/MfWE
         SAnqCf8CP3foulz1AT/KBlHHijWE0qicWMaiQfj6DyNr1TApBlDE655YEggh3usYFy7B
         N3Vg==
X-Forwarded-Encrypted: i=1; AHgh+RrJQcWtdr8Y6A/FXKZx9Fd0jmAoTGwQ9s6lMOCrRU4YIT2w9SkepW7g4xfdEqMNb8BcfzPQxSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPEM1lfv6pXtxDINGyyms0w+aqZWqAbmSArfK6xFoDkgJIevJ
	JDvO4yzLV7NqWrLtbEq7gTe8tLuL3iXlACYluvvgOImZDXzQpCRD/fWVfu9wCu6fFoymXyY0ZHG
	+0fDXxBwdVwU1Qg==
X-Received: from qvwl5.prod.google.com ([2002:ad4:4bc5:0:b0:8fd:d395:b9fa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:458d:b0:8ee:f531:4de8 with SMTP id 6a1803df08f44-9040158d998mr1685206d6.40.1783707198814;
 Fri, 10 Jul 2026 11:13:18 -0700 (PDT)
Date: Fri, 10 Jul 2026 18:13:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710181317.4060230-1-edumazet@google.com>
Subject: [PATCH net] tcp: fix TIME_WAIT socket reference leak on PSP policy failure
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Release the TIME_WAIT socket reference and jump to discard_it
upon PSP policy failure in both IPv4 and IPv6 receive paths.
This prevents a memory leak of tcp_tw_bucket structures.

Fixes: 659a2899a57d ("tcp: add datapath logic for PSP with inline key exchange")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_ipv4.c | 6 ++++--
 net/ipv6/tcp_ipv6.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508fcc3974ae71d35dd66cba96b73d0..4a46da375043be26bcbb282a0b0c3ba85bfc5186 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2318,8 +2318,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 
 		drop_reason = psp_twsk_rx_policy_check(inet_twsk(sk), skb);
-		if (drop_reason)
-			break;
+		if (drop_reason) {
+			inet_twsk_put(inet_twsk(sk));
+			goto discard_it;
+		}
 	}
 		/* to ACK */
 		fallthrough;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ebe161d72fbd07a13d92812b45b5a3ce2464a015..522ba45ce9b759a6a76fd8603400097bc99c60c6 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1977,8 +1977,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		}
 
 		drop_reason = psp_twsk_rx_policy_check(inet_twsk(sk), skb);
-		if (drop_reason)
-			break;
+		if (drop_reason) {
+			inet_twsk_put(inet_twsk(sk));
+			goto discard_it;
+		}
 	}
 		/* to ACK */
 		fallthrough;
-- 
2.55.0.795.g602f6c329a-goog

