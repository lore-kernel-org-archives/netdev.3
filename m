Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428A343882
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740635; cv=none; b=sNOJ0EOetHfSnpfjYcFCXKdl/VbhCdIntEKXNmCbJLIX4zSq68sOpAlnwtKjI6Tg/GXz4DuQ0Bp2BjDU1nLPNGzxse1CPLHpbf/tImGymWVd5/oJU6FE4ispyzwe92RYMzOFl+0xICdpl4xA/xalli7ERKT3iRtYLmilmlm9Ga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740635; c=relaxed/simple;
	bh=DXqELk6b9LwboemR6p99awGOv7dN71UB25M+u5BB9CY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dqd9qk1fAs2hPnlGmF8ZWfHKdmzQ8v3mNJvQFV1WzE3HC7A80i1DJbP9SPdlJARkMsGnYyqtluoRTqLxlZvcs17N8kvU1+CCG5EDEGHWeF0siujLoVE5rs6vPYLZqp+P32GzUmv9yzaHXiLyelviLDIE7VHKkwEbjFY9cwddUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peOfu3vo; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peOfu3vo"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930edb4362dso66809585a.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787740633; x=1788345433; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B3yWUOOTItMTIHqUQK3Pbv6zh3OMkE3X2u51hW4Uhog=;
        b=peOfu3vo81ZpVBDaL7W2hNSruF6AJAyMklVZH2FbV88o99dPmSjYhmRzUxusiap2av
         OcpT/IILytusFIpJs7eKyzAh9jNRpnqA0MUH7LmYHZpXSKL5oR/YseV0W4f9lxzbS74k
         YbQlbvc2Ya5Tno4+O8x7j/Bu+5sLie7ZI8AoLRxm8qLFp7sHlcA7WGwo8wm/z/EQmEYj
         j8GOhZQn73DRPUSwG46zqBP8i6QapV4jnZNEW225b3vGxGEjRZiqCYjyi6InTyrRLAHY
         Ixfs37621xDLbIQq6Me9o2DLTf7VRugr/F6VL+T+518e5ishtH+3INPLtRzFV2VpN+UW
         CfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740633; x=1788345433;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3yWUOOTItMTIHqUQK3Pbv6zh3OMkE3X2u51hW4Uhog=;
        b=WGx4YyVXgMvbmjMD69BN7J9cFrqKLJtaFDKIjvwGDm+BM3L0b2HfOvY1RmJqAQ0+M6
         +/KJbVJfeU4KGbYUBuV+kj7GM3czRnuxcFqYT8NuPrVUlkUpdS5vIP2w7L2lX/r1Vtcf
         /lcVMylJlHrApT0HLEOkHxmaP4yRiD9yyMMZ9jGsdqm4AHHlPL4Gc8lgMjECwsEuzf4p
         nZHIp6iOxwW+SfRA3Z3zbfXjpmT4Lb4bnHw8095u+kDQjFwrGy5w+4otSAFjAZ5jBNxI
         DexLBF7+WN1d8IRcGfJhSWs9dRbMCDhPe4UUBk+YHLXlEjjqlxgqcro0XIqmwixQl306
         AxVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp4SJjy/PLXXyV6BNMI0YRYGqp9EVqaFkAb/ukBKk8KUp6OYBd1YCBF3/CMmEm/yL5cBl2cgao=@vger.kernel.org
X-Gm-Message-State: AFuF++m9Q2+5ywXhKvoRhoMwiiWaEaOusCkQfOfq/AF3yBrvLtXeEXpP
	2OGUdNIBaYju8jskID7BSrjTziCLcrlDIZf2wGhDVOmRnwnDoBgicOtlQM06AzThd1Bn/17GuV9
	fTWPXjdLHpBpQNg==
X-Received: from qkbbk20.prod.google.com ([2002:a05:620a:1a14:b0:934:b7a5:7372])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ae9:e907:0:b0:925:56bc:b8bb with SMTP id af79cd13be357-93780107545mr413641785a.9.1787740632530;
 Wed, 26 Aug 2026 03:37:12 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:37:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826103711.3302915-1-edumazet@google.com>
Subject: [PATCH net 0/5] ipv6: mcast: RCU and timer fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses several RCU synchronization and timer calculation
issues identified in IPv6 multicast (MLD) handling within net/ipv6/mcast.c
while I was working on fixing a syzbot report in net/ipv4/icmp.c.

Patch 1 fixes an RCU reader diversion in ip6_mc_del1_src() where mutating
psf->sf_next to insert an unlinked source node into the tombstone list
diverted concurrent lockless readers (e.g. ipv6_chk_mcast_addr()) into
pmc->mca_tomb, causing them to miss remaining active sources.

Patch 2 converts ip6_mc_source() to use copy-on-write RCU updates.
Previously, source additions and deletions modified the socket's
psl->sl_addr array in-place, causing concurrent lockless readers in
inet6_mc_check() (UDP/RAW receive path) to observe torn 16-byte IPv6
addresses or duplicated/missed sources.

Patch 3 fixes delay calculation in igmp6_join_group() when canceling an
existing delayed work, preventing unsigned jiffies underflows when the
timer has already expired and clamping the delay to the unsolicited report
interval.

Patch 4 ensures rcu_assign_pointer() is consistently used for __rcu list
updates in __ipv6_dev_mc_dec(), ipv6_sock_mc_drop(), __ipv6_sock_mc_close(),
and related helpers.

Patch 5 switches igmp6_mc_seq_show() to use jiffies_delta_to_clock_t()
with a signed long delta, preventing underflows in /proc/net/igmp6 timer
duration reporting.

Eric Dumazet (5):
  ipv6: mcast: fix RCU list diversion in ip6_mc_del1_src()
  ipv6: mcast: use copy-on-write RCU updates in ip6_mc_source()
  ipv6: mcast: fix delay calculation in igmp6_join_group()
  ipv6: mcast: use rcu_assign_pointer() for __rcu list updates
  ipv6: mcast: use jiffies_delta_to_clock_t() in igmp6_mc_seq_show()

 include/net/if_inet6.h |   2 -
 net/ipv6/mcast.c       | 151 ++++++++++++++++++++++++-----------------
 2 files changed, 90 insertions(+), 63 deletions(-)

-- 
2.55.0.860.g4b6b3295ed-goog

