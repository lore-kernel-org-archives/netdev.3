Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629CA2B9BA
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780778931; cv=none; b=GPcxva5yqO7o79rLWBhUWu0HDDj4zqQlKQf4ORCJ7TcmWMIWHT880d/cUaiJgTWzNg/eHgFs/NPL0DvDHq1skVqxT5R9bfp3K31Sx8yIDV+m3w16c4+xjPJejruvQasns5WzDWNKr+hHwHiYX9NXV+kycZ2CDbohPRRu4UAnL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780778931; c=relaxed/simple;
	bh=oQ0GMYpzLA0ExoHEEVjvS7y2GApzRxeda1nTkzMkPe4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sKNXBrQ9dZwv8cVyIP2jTpAeyM1fkKBxfMphKdPzfQ/o5B20LFBL+CadaaPZXoJpp688elIS6buL8EIs28U3RR+sxxnETtLU7UPZM5GXac2UtTJKtD8UmBJvFUw9iZh9duIuNU4G2E6mTcmo+sSyWd4jnL315aeYzuD3XNk1nc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BfkIR/JI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfkIR/JI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf30576aa3so20650545ad.3
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780778930; x=1781383730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ICwtIk1WTVsl9deJp7rsqib5Y+9mGMqCg0Kkl+P2DeA=;
        b=BfkIR/JIi/TWkxXHDomYpedwl8ouzWk9y62JQ4ZnXIuwULZv6gPZEa67Pcg5coPQEP
         ugZU0mRqSkmzktCegS5mNWaIc4csi7RzeiBJbCIiahWblkhcjYcwn+LWVlf7N9uplf5S
         wgTReLY73vqrqp1cxIv83UsPWCiLVpa1c/qkrjZFvwX/ZrhaU+0zj2rXup+4k9n8gvcz
         UuVoJlXF2gQDdt3Ry6DVJI4zFLpmhICzKkpvWnY58DRf5uIDTXEBbw6JJf6/37Fs4RQG
         VtYl8N8QpcmQ2PPHl50BDKsMFSl7EhOUD40aTIESyvOubKn8hXpXGPbXSO9OTqM/HgbX
         U0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780778930; x=1781383730;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICwtIk1WTVsl9deJp7rsqib5Y+9mGMqCg0Kkl+P2DeA=;
        b=kDEl+pLVUydXxTmJLAKO+n8rlSlxzn6/6Cju3MKivemqokuZg8f82qjgc/tCdo0GMK
         rOeP6GfDhzLFrFlSvlslkABx+Z6AmEIluFUq1J82TbnGhEFaBTRf1DYwdBhxwH/sk7W1
         ntR3iTSQow9TzIo68jqAkS5pHjSq4EC5q+its2iZnIyWmEV770+cwv8xcurKpudKX8tC
         HXu/vusBkmObZ2cT3kQwTje21pDWjgcLPkd1YMXlfy1Rjegj1IGAnHV115QH8c6ZcOqc
         M/Qdzmry0Ctsyvp9wRj5BZAi/SsoSoCOivv3R5lOmCVWzyWlqp8vWXxQQz9hEVNsw3uB
         GEHg==
X-Forwarded-Encrypted: i=1; AFNElJ8TAHz5mIYhIhJl6DXZ/7yeCp950i8yVqabrs3/eppkpIw4iWd2arVfSRV4RJqt3MkN9Mo4rHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wymiZiMSobPEm5D+UbzJ4fjGxWUOZ+UzBcLYZSOJCjCFqnIK
	BML5uMwU8pp+vE1GlAdU4IqfH/49D8CpoA+QtjWNV/o/l7gRXg7PekkY6xonaKNvDOnKVJmTzGG
	5Cb19uw==
X-Received: from plbmt6.prod.google.com ([2002:a17:903:b06:b0:2bf:1803:8eec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b84:b0:2bf:23c3:34ba
 with SMTP id d9443c01a7336-2c1e833c207mr101294465ad.28.1780778929490; Sat, 06
 Jun 2026 13:48:49 -0700 (PDT)
Date: Sat,  6 Jun 2026 20:48:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260606204848.1987046-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] geneve: Move udp_conf.local_ip6 under CONFIG_IPV6
 in geneve_create_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Unlike struct ip_tunnel_key, struct udp_port_cfg does not always
define IPv6 address fields.

  >> drivers/net/geneve.c:778:12: error: no member named 'local_ip6' in 'struct udp_port_cfg'
       778 |                 udp_conf.local_ip6 = info->key.u.ipv6.src;
           |                 ~~~~~~~~ ^

Let's add CONFIG_IPV6 guard in geneve_create_sock().

Fixes: afabbb56a726 ("geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606070019.yx2LhZPU-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index a60e16bbb2c9..23b42466a7c9 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -771,12 +771,15 @@ static struct sock *geneve_create_sock(struct net *net,
 
 	memset(&udp_conf, 0, sizeof(udp_conf));
 
+#if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
 		udp_conf.use_udp6_rx_checksums = geneve->cfg.use_udp6_rx_checksums;
 		udp_conf.local_ip6 = info->key.u.ipv6.src;
-	} else {
+	} else
+#endif
+	{
 		udp_conf.family = AF_INET;
 		udp_conf.local_ip.s_addr = info->key.u.ipv4.src;
 	}
-- 
2.54.0.1032.g2f8565e1d1-goog

