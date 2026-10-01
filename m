Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8149BD6D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887680; cv=none; b=aBFbddFfn8d1BP5cJXJ/iik6djWSSdO/09DLYA4MDpwmTrqoyNm2F5/j3937Cqf3nu/8px3PF9v8vw46ii1zLw9DOuomMguSDaOiLBNXTzshIGcsfVrjEeatRvPyIWBYnDHUwcXnyuj0EfN5sJqZzTiMdr1N0XL1s3zZxVM5mLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887680; c=relaxed/simple;
	bh=3MnLl99XOmUTT/cYcbI9aX0v6hp5ASvwd+r39vpnN+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NSEI+D8j/sft1CIJva+MP62UU4ZReaCY0l/O5QIcc1XBzW+GROtDuUHNOJy0vGxzLDQkHQ9f7/WRvaNm9v7fvASdLMXUh9qOK0LLmqaF9dOnywhtaCDmhqgr4ppVUnRFF7VI7X5f+BWsvycPrSJm+LxJ0smz0WJ6hvtVy4j6QQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahQbRLl5; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahQbRLl5"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb92868263so4427214a12.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790887678; x=1791492478; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbqDt0HxRX15SjL96wUA42qv4QG9OeZKWE1IkyZE8O8=;
        b=ahQbRLl5Lm5b3SYM9WTXtDY5EYexq/2wfPemYOen0KYOwof8TAVQVykrZKcfnwz9QJ
         IaQXYJ1twik97IqjlY8taiNqyd4iugmRr4LOmNUxTpUGUqybvEkfvHk/PdFVbk1pdSCl
         o8McPvLN0bOe08M2/+HJD1F8sgKCsrJgPML04CliR6arFzim15F6j6/A8wzcW4qWSfP7
         wcER/OQaguhhL6YYUr2SNmMonfOjdqmgexrmUKZgTNlHAC/lP1Mm0uv5gSKuHlrfSh54
         DiLnU19WWPCAW5H2nutAt8X+0ryZ3KciDt9MfVRQ1j8bfN8ecOp3c1XjHF9E1Ciu52/c
         +9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887678; x=1791492478;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbqDt0HxRX15SjL96wUA42qv4QG9OeZKWE1IkyZE8O8=;
        b=l3BB7426zK0QOdnwPfgblJRa2KVt0y0Xe4CQAEGn/sTpNA/LzjBTguz9oTVT7aR2Fq
         Wx9xNJxg0NrNMdiS4GxtHGWTA/onoUrJKd7dIxWjzhQZc7ExrD6gukbqtBymnfnW3jZ3
         Nrg0YamTvq4WjErhtRVJGNlOsV3tiDE+gjyGgU0GB5m51lyoJAK9w6YWAzkTumtRuNkq
         GHiQbJJ0ew43IOxoq2d48p7BfSkgfOUnMj5C3BGyvZkdvuMsS2jXPoxkfq/CdQAq/obf
         eHlyvf3IM7THVk2+gI+vam3zwCTEzjlbng75cTvcLj5vP57wlwJszk+Q6L/BHdh917l2
         lL3w==
X-Forwarded-Encrypted: i=1; AKwUvByO0rThubr4YIyP5pwDNLZgw8IeG+kFUbW233JP/PD9Gb3VRbCL8KvjiTzS16pt1s9Wa57nTdA=@vger.kernel.org
X-Gm-Message-State: AFuF++lNAtYZxwhId/Cqq5C9RvyBK/PvqadupDDrBJQVyJ1+kfTXwNYL
	imRRCvtW8G7cmoA7+xiAtmgjL9hSf5eTrGYflC9GCRfhRQmr/qD6DyKxwOLYEU5iasDQDy3w0mn
	kCRzsCw==
X-Received: from pfbdn3.prod.google.com ([2002:a05:6a00:4983:b0:886:c063:eb7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c904:b0:3dd:a196:30a6
 with SMTP id adf61e73a8af0-3e0bd4c7d78mr568739637.86.1790887677757; Thu, 01
 Oct 2026 13:47:57 -0700 (PDT)
Date: Thu,  1 Oct 2026 20:47:14 +0000
In-Reply-To: <20261001204752.2572265-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001204752.2572265-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001204752.2572265-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 2/6] ipv4: Inline inet_blackhole_dev_init() to devinet_init().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 22600596b675 ("ipv4: give an IPv4 dev to blackhole_netdev")
started to allocate in_device for blackhole_netdev.

It used late_initcall() because blackhole_netdev was allocated
at device_initcall().

Now, it is allocated before inet_init(), and we no longer need
to use late_initcall().

Let's inline inet_blackhole_dev_init() to devinet_init().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/devinet.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index e84d3cf92247..2ed4c706ca9e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -340,18 +340,6 @@ static void inetdev_destroy(struct in_device *in_dev)
 	in_dev_put(in_dev);
 }
 
-static int __init inet_blackhole_dev_init(void)
-{
-	struct in_device *in_dev;
-
-	rtnl_lock();
-	in_dev = inetdev_init(blackhole_netdev);
-	rtnl_unlock();
-
-	return PTR_ERR_OR_ZERO(in_dev);
-}
-late_initcall(inet_blackhole_dev_init);
-
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
 {
 	const struct in_ifaddr *ifa;
@@ -2974,4 +2962,9 @@ void __init devinet_init(void)
 		panic("Unable to register inet_af_ops\n");
 
 	rtnl_register_many(devinet_rtnl_msg_handlers);
+
+	rtnl_lock();
+	if (IS_ERR(inetdev_init(blackhole_netdev)))
+		panic("IP: failed to allocate in_device for blackhole_netdev\n");
+	rtnl_unlock();
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

