Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301713BED44
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887678; cv=none; b=cuqbOn/oOdJnBjBgxgDN60ma1nNrjIFp/s5EM+PjvfjMZ1KzujvFUfBK6aUmQ7TWCpaXVC+obeK0sr7ML3W8HVBCBVjfKfg+a8PpVirTtsud9MznM5OsfBRU+caKtoYCB9Fdzk8aMxmyFXKZA0WNWtaAxgCE4enWcAFg3TW+gwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887678; c=relaxed/simple;
	bh=Umtjh7rcAWgTNErg2gpl++5MfPi+HK8Cm3CGyRIQJ2s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aPl8S4iwqXBmyOTR/v1a/C5J0fAcpUqCcABRDPzdRf/aujc8UK8eA8ywDFmh4peXrXS8Hn2mG7DUvg6lLRzamVyBczHWTQ4/Vm6+1oJRzCCQC/U5RB51Una3M2UcQoIgte+rpQ8uGwo8yb9w+U7oLFjA2FVQ/Q7vBSSOiBxfHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZVgjuS+; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZVgjuS+"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86a880e91f0so9270686b3a.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 13:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790887676; x=1791492476; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3Ff3pRVW5gAqj44K77GOhq1HHKMBtl0ZoHHCIctxKw=;
        b=uZVgjuS+dpJURhFY/4MDBbz/rpaGauhUN4dCbbrcSibAaeZneu2Btl7axjbQGdvH7b
         HiHpiP+HhMjTkos3dbJKiFafhKF4p2sZqKx0OibEl2rmR8fvhYjQLK5L3nohYjgEfvhF
         SXVydj6qbAXUNsxWMLk7G7fLYCK/N9QFKwOOiUriKbCNY56LE4KWIv2b3mOLnHOrRYpa
         8U+c9aZCCat9RC0IyW4QlPsemTW6Ksb+tPHGWm3gXFe8HhMBsuCDzKvxDwdAD8sTaG2S
         yI91Vb06qYx1fxIbkihSakA1amHVVfmTGfQfwdc+xgswlVgBV3v90un50BevJCY+JqxD
         WU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790887676; x=1791492476;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3Ff3pRVW5gAqj44K77GOhq1HHKMBtl0ZoHHCIctxKw=;
        b=Bg7cobL5zHeCrF89Vb68eDVHBjwN8y9t4sH+7KZCEmond331uY3Z0D1WUv0v7JKxqd
         8EAK0RWwbQ5TWiasbmMloO3xp5Ghom2i83PpzplXEbVPzjHevSPudIloJl1EKC9MmoQB
         EqRz/VIht8PCWYgI8geNDGZm5jOAwFBh8Z6yYfwO93SSP+TWccaMhFdu5APDZpWNHEfO
         52S33NbN3F5Ek9OCUJlEHSlV/2q6gC50lfTbBKShCi0d4o1mAVDMIDJ8U9ByWn1KkMwQ
         SSU+PAqWYedEPj0ZyAdJgpw4Rer1Iz+COuhuYyzw+XcDoBxy/LK+cU7QpqC4BFQ93JgP
         7UEw==
X-Forwarded-Encrypted: i=1; AKwUvBy9SetPWtCimWCi5AC2WCQqsube+ChNxxhSRfzp7GnFR3BW63z91ODc4yjqKzftCwyIamVh2JM=@vger.kernel.org
X-Gm-Message-State: AFuF++k5F7V7FxjxTgiQZWRiBNY5/qUOOAHmPre3R7yuLu/SlvYdZR/O
	XQDk3s22cVMtjbN9KhFaYzDd9NRklcr/0/sHWw3hKN4KijEqmL6TiXrootT6j0HcHK3HYkrhaJu
	lsbKVQA==
X-Received: from pfkh29.prod.google.com ([2002:a05:6a00:1d:b0:883:f59:2478])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2887:b0:874:d464:d541
 with SMTP id d2e1a72fcca58-88af7aadf97mr617330b3a.28.1790887676177; Thu, 01
 Oct 2026 13:47:56 -0700 (PDT)
Date: Thu,  1 Oct 2026 20:47:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001204752.2572265-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 0/6] ip: Batch flushing uncached routes per
 batched device unregistration.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chris J Arges reported high RTNL contention during cleanup_net()
caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
over the global per-cpu uncached route lists for every netdev in
dying netns [0].

This series resolves the issue by batching the uncached route
cleanup after __rtnl_unlock() in netdev_run_todo()

[0]: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/


Changelog:
  v3:
    * Add patch 1 ~ 4
    * Patch 6
      * Unlink routes only when both devices are blackhole_netdev
      * Clarify netdev_run_todo() does not run before
        rt6_uncached_list is initialised
      * Fix CONFIG_IPV6=n build

  v2: https://lore.kernel.org/netdev/20260929201546.1533268-1-kuniyu@google.com/
    * Drop ->pre_exit_batch()
    * Do batching after setting NETDEV_UNREGISTERED in netdev_run_todo()

  v1: https://lore.kernel.org/netdev/20260927202429.2452589-1-kuniyu@google.com/


Kuniyuki Iwashima (6):
  net: Order blackhole_netdev_init(), inet_init(), and inet6_init().
  ipv4: Inline inet_blackhole_dev_init() to devinet_init().
  net: Rename dev_isalive() to netif_is_alive().
  xfrm: Check netif_is_alive() in xfrm_bundle_create() and
    xfrm_create_dummy_bundle().
  ipv4: Batch rt_flush_dev() in netdev_run_todo().
  ipv6: Batch rt6_uncached_list_flush_dev() in netdev_run_todo().

 drivers/net/loopback.c    |  2 +-
 include/linux/netdevice.h |  6 ++++++
 include/net/ip6_route.h   |  7 +++++++
 include/net/route.h       |  6 ++++++
 net/core/dev.c            |  7 +++++++
 net/core/dev.h            |  6 ------
 net/core/net-sysfs.c      | 16 ++++++++--------
 net/core/netdev_work.c    |  4 ++--
 net/core/rtnetlink.c      |  2 +-
 net/ipv4/devinet.c        | 17 +++++------------
 net/ipv4/route.c          | 11 +++++++++--
 net/ipv6/af_inet6.c       |  2 +-
 net/ipv6/route.c          | 24 ++++++++++++++++--------
 net/xfrm/xfrm_policy.c    |  4 ++--
 14 files changed, 71 insertions(+), 43 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

