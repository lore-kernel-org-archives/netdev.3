Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B333A3E77
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427080; cv=none; b=Fw0JqoUtBNvGnkvjVOEao5p9+o5AfMraKZMNIUVoYZsUv2GfuSXuO9rYOgHVl6gWTiOrAGP1e8EX5M9Kj5nOqppxxewLrWtsyKtl1/EME4Pdd1PMySdHLigzi9U7vyxoa4li97h5F2zQq4/8941oZHCA5JaXhS7aZ5AFA8v06g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427080; c=relaxed/simple;
	bh=4oHClXt4WHSMwWOhlDP3Pv0jkkn/+y3MUybpSmRYXyo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LYSUZhIhmB776C+KVxmQSShf6CSOx9AjcxyranwmSflLbbqH6OG4cVQO8P3AXtufjor4JzcON67pmTlyI4dxdcByMRQ7FSt+Uum2+IyIsRHVW58aam+GNpqOq0Rn+dWFvLAxf5BcOmiAlP612ilTLY3EDvkqO5kqDfUGY/AuJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWxtUYOd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWxtUYOd"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso8703242a91.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780427078; x=1781031878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c+UQlkvo93TLdb5AGL7Qa4FBa6P4zv6brAzfEeFQmwM=;
        b=AWxtUYOd8qHwEBBg69QZxnvWn16RanK8ujSFtOf1LqrQJ72LNktKSNekMVGF+nmOfO
         8w+F2dwO+fmlLVu4QevNFakBM7wiC7qFyLHhc7WGmZw8kbO5vCEs0MHGLPB4QkoETDZk
         xyvKK7Z/cBAaH3xGhZ6BBaPpN+9sbIxxJ3rt4RMUBahC8Gaw1TccXMwYRmqlU5RGV7nn
         P9bcCo4YHbZLCmdrLl95jk7Qm8SNiQvBDaGF+I8SooNP0mblGur0JDFGk48IoyfqUUMz
         u7kXSODtMwU79XlBuE2m9nQRP+9XDO/eOJir8slzhBkWxRC0chWWsL4anRMmFnq5mjLL
         Pgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427078; x=1781031878;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c+UQlkvo93TLdb5AGL7Qa4FBa6P4zv6brAzfEeFQmwM=;
        b=sUv1afjsFq6joPHrAFXvfAEtMNhc7Xjbwe/fvs3/oCkp429PaHcY14nbVXOIrAAiQu
         KpsqBnsQgnisBrEnJ34OXfwxk4m4O7xfxGeL1rVwLafq43lQgNzw+wm1U+0OSQDZ34sm
         8+EM9Rh5Y0T7y78neRBSzXpHL+slnVpDp1ddOQhVISodBGzzL5kBUCHbD6LwsP85Qpxj
         Md4RtzGSw9Ac/m1nkm4W1SeE1Uze2MzODZeZhXwXuR3yfsxvfvs/AWv88bb4IlGlWwbT
         RF9LhBI8NB3qdKZRVPMf0iUILWEiJrI0ugGTeM+h/MWVMrqzc/tgGmC8m1ahMQrN1nwZ
         LF5w==
X-Forwarded-Encrypted: i=1; AFNElJ/p/fXuuRBR5ejTQgD4VdzM6jCZ7fmYBrlUtnsXj61oL59Q2gHJxggqswDJ+NpMFEL9M8REcAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZ7fqVb9w/GEv3EwsPHhActyG6wdpGpJEn6Nb9no9bgDm+35v
	nf2TBM67JSHG2buzLE4Oq/O9FCVQzDIh21caB1aQonVQ30I5fGt40laQbj7mSqBQ3qJp2sTCs7I
	JzXLoIw==
X-Received: from pjyw15.prod.google.com ([2002:a17:90a:ea0f:b0:36b:cb5d:d0e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:578d:b0:36b:9512:871b
 with SMTP id 98e67ed59e1d1-36e2fa98077mr167458a91.11.1780427078124; Tue, 02
 Jun 2026 12:04:38 -0700 (PDT)
Date: Tue,  2 Jun 2026 19:03:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602190436.139591-1-kuniyu@google.com>
Subject: [PATCH v5 net-next 0/5] geneve: Allow binding UDP socket to a
 specific address.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

By default, a GENEVE device bind()s its underlying UDP socket(s) to
the IPv4 or IPv6 wildcard address because there is no way to specify
a specific local IP address to bind() to.

This prevents deploying multiple GENEVE devices on a multi-homed host
where each device should be isolated and bound to a different local IP
address on the same UDP port.

This series introduces two options to specify local IPv4 or IPv6
addresses for a GENEVE device.

The corresponding iproute2 patch is here:
https://lore.kernel.org/netdev/20260602185711.129769-1-kuniyu@google.com/

Once this series and the iproute2 patch land upstream, I'll add
a small selftest.


Changes:
  v5:
    * Patch 5 : Allow changelink with the same address
              : Dump LOCAL/LOCAL6 only when configured

  v4: https://lore.kernel.org/netdev/20260528005658.1756248-1-kuniyu@google.com/
    * Patch 5 : Simplify validation in geneve_nl2info()
              : Add ynl spec

  v3: https://lore.kernel.org/netdev/20260526015152.2409183-1-kuniyu@google.com/
    * Patch 5 : Use NLA_POLICY_EXACT_LEN() for IFLA_GENEVE_LOCAL6.
                Mention source address in error messages in geneve_configure().

  v2: https://lore.kernel.org/netdev/20260525001745.1251640-1-kuniyu@google.com/
    * Patch 1 : Move addr_type to if-block for CONFIG_IPV6=n
    * Patch 4 : Don't set cfg->dualstack for IFLA_GENEVE_REMOTE6?
    * Patch 5 : Validate saddr in geneve_xmit_skb() and geneve6_xmit_skb().

  v1: https://lore.kernel.org/netdev/20260523061654.2767060-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
  geneve: Pass struct geneve_dev to geneve_create_sock().
  geneve: Pass struct geneve_dev to geneve_find_sock().
  geneve: Add dualstack flag to struct geneve_config.
  geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.

 Documentation/netlink/specs/rt-link.yaml |   9 +
 drivers/net/geneve.c                     | 254 +++++++++++++++++++----
 include/uapi/linux/if_link.h             |   2 +
 3 files changed, 219 insertions(+), 46 deletions(-)

-- 
2.54.0.1013.g208068f2d8-goog

