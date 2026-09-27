Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F23B9931
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540680; cv=none; b=IIpJrAhXKdRbEUt+wT/JOPb/uiDzFgKF748f2RklnVHiZ9Pax8koF8knopfZDrB+2vwW/l3IX2bDTa2tJB3Ywx+oILGLYmWxVUZyvqLfgN7x1N5zF7ZuEdT6VGSD2cgQ65DKMAsHctTtaUp7fv8XLIM4CLuhyb0XTvheosl3xgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540680; c=relaxed/simple;
	bh=wLUBs0A8itNcGdti3IUPyEODuBYrymXh8zeFR4KWy9g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RPHcYney03erYmu+zouy5opp3QDF72LKHunB9ACZIlCo+dIxwMw16QhQRQ67Qy9AiBo+YYkwliYWkh9WKlrxXGGDHoTHWMP33PNbXeXIYMIYfQAKMgPVO8whNNSI74yOaeHyK0vJnIhenVzPudAHghHNg+FzCCmEeGzKXTbgLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjAf8DhA; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjAf8DhA"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3d832827so28247795ad.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790540678; x=1791145478; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XruO3a6VrQQwo5UI0pQL443i8DhMiUULwGs+G266TsA=;
        b=WjAf8DhAir3yFZREzA7j8ZlrAhjbSkZioxxlkP8zHnzVTVu+b537RGNyJoEO29fEc8
         MYESxii8YdSJDhLXzkj9T4yciBAq4sU7nMZHHb+gcCSXgx0vVdrMXNwX3xQeS0NbQDyr
         Pd43K/6gxcWkqHwiK/B5um+Bj0Ba/0oVhS50fPYI6wIO5Hv0aIQR5dyauItmTgtn3oy/
         JdIizicNdgCB4OTRAHUI1vcWzqqRVDDK5RoSt+nGAPVShLA6Ia3yqlZiNFtTbiJQrtqh
         6VfdEclDzDgG97VEyWMbt3MqyXve9RifBpIa8dZVLXigmq3lhARRTZj/aD1QGRBi5T0L
         EhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540678; x=1791145478;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XruO3a6VrQQwo5UI0pQL443i8DhMiUULwGs+G266TsA=;
        b=Cfxj6sQRoqppVLhqZksFTBomEQcYOq9R8IO7MuUzhGhl24UWHS4nd9MB70nMdjYbA9
         N5yWcKC31kjx9tyhHJmHZyetemNdvHsz9/ZdosUSL4fn2zDFLAi36aAWOJTfNVeidkU4
         WIu3IAJjklAlrDRSOflwo5YS369+zhqhx4M1wsM14OVliyvhgaequxCRCVWgsKGxY6+w
         2MDOPUycsmcUjy/A7DtiUToSysMFXOw2u2CH3YErAjM569o7nc5KeXln1eSiOG1OZhXU
         titFD1MLCjwCT6h75v85Y2UoryqPNOX7xhqdaYUGX0bT47C4Je/HeaBxMXA2JQB4hpMX
         bVXA==
X-Forwarded-Encrypted: i=1; AKwUvBwJThes0QWPL6b7DvekM9swSC8f+CFLQBj0InV3RthlDd9YZ2AoZ2Fq3XAhkG7GazgnHXmEaII=@vger.kernel.org
X-Gm-Message-State: AFuF++msHjJ+9cCAHXj1NaHpmE5xyR/rmhRMBZmei+IoLKcK34iQ7xl6
	0fehfbGPxtriSsceOssxz3NNol+SFxvSNsAaG7mUxDQzfq2YtgJORzkr1h0cbUPdO76Hyy0RfAb
	P0z7Inw==
X-Received: from pgbbm24.prod.google.com ([2002:a65:6e98:0:b0:cc7:85ef:361e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d82:b0:3d7:b90:acba
 with SMTP id adf61e73a8af0-3de0e703d77mr10383962637.6.1790540677845; Sun, 27
 Sep 2026 13:24:37 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:23:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927202429.2452589-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/5] ip: Batch flushing uncached routes for dying netns.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chris J Arges reported high RTNL contention during cleanup_net()
caused by rt_flush_dev() and rt6_uncached_list_flush_dev() iterating
over the global per-cpu uncached route lists for every netdev in
dying netns [0].

This series resolves the issue by introducing a new ->pre_exit_batch()
hook in struct pernet_operations and batching the uncached route
cleanup once per cleanup_net() without holding RTNL.

[0]: https://lore.kernel.org/netdev/20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com/


Kuniyuki Iwashima (5):
  net: Remove net->is_dying.
  net: Add ->pre_exit_batch() to struct pernet_operations.
  net: Track state in ops_undo_list().
  ipv4: Batch rt_flush_dev() for dying netns.
  ipv6: Batch rt6_uncached_list_flush_dev() for dying netns.

 include/net/net_namespace.h | 11 +++++++-
 net/core/net_namespace.c    | 13 +++++++--
 net/ipv4/fib_frontend.c     |  6 +++++
 net/ipv4/route.c            | 28 +++++++++++++++----
 net/ipv6/route.c            | 54 ++++++++++++++++++++++++++-----------
 5 files changed, 89 insertions(+), 23 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

