Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDFA29A31C
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257653; cv=none; b=DHxR0Tx1PeQN8WK0mWHuOKkJ817qaljUrb9OqeUk9/2zfIBgOP9i5Shp2BFto+ti4+OhOEAQ1t8Ae3GdYHeMcbEBTXavGqE8DQ4N9hi+lbeOFl1QU4vU/t6YtPJCLufE5eLDQD3kZ6m1/7ScQJH9/XJapwKyzZmMitYHZQSX5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257653; c=relaxed/simple;
	bh=9tTjST5I/hIrG5Zx7XcjAfakBS9AHITcZKft9ozaFsc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IhU3QV9djLxyIfk1FlcklQj+YBCMX1bCTi6WNPAB4QcDHQ2cI31icO45Qgti4wYaqFud6r3RuAvQ1bQEFDCwb+BBuW2chRbRtA6G1pznhRDMLXxUP6fxLUPqBsuRCFWCAzGH9CH2WfCAb3rTbgZqtoG4ab6dX6CcbGeUUVCpSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyQmqnGn; arc=none smtp.client-ip=209.85.222.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyQmqnGn"
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a082c014aso192540285a.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790257651; x=1790862451; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLuNEL0GJk1WsBYHatMB25r7iEXfrSGesHozKIlwDaA=;
        b=uyQmqnGn0iPuEr5b4vTYWxRg7jP3kXY6VYi8fz2Bi80DSjuYlCOMWhjiRQnZO5LfLY
         0RPt4/Mb+mYNl9ZA3JejAN12WyV+IS0zUauO0OhhuyHr7RVa9+B2QvU46V8ylSp7Ppg/
         y8BtU4dQt50B/JYOr0v5Iu07lGlei/sMm5IveUIFIqKjA+Nm2f9ZbnTy0yaeihltq9M/
         XmqEi/BgotQHg4NJAx4whxVSIh+ebahpzQqDqJF0nlh0+fyym9eI6m/6BK5tp3DLv34A
         i1PNJNyBx/cgRqlA9FjU7T016efK95MU2OxCTkn32yLMgBBNGyknya9YlQ83Q2VmNIb5
         LBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257651; x=1790862451;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BLuNEL0GJk1WsBYHatMB25r7iEXfrSGesHozKIlwDaA=;
        b=CsKKmLwaEX7kOOwnmzLQGwX7IYAMDYryxkmwWRjkyOn8JBU3jWKdW5EoXiNwkttMb2
         hLKjDmeWFIbqHDJHl5Pwn5tYz3XFdsFO4MIMh1J1Np0Lgb5o2E2RHDhZkI/H/c1mVRl/
         vvDZlm78UdIOzpmzCoyMrlvie4/W/lRglyHsTjBFu+BRaIMhIQxdx2D8rLdWrqGs0K9D
         aa0crRKjJfbCU10UGJMU6j07lFQ9d5oYNHDLNECv7DiWRvXOW/HrO1qoP/F4ESe7gQn8
         Xm0u23fd7nBsQBltLLjSAz/3C7f4zcNub3GBsDQczTO5vDU1QZFkQ7s+C79ofR9xsne1
         NhKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxAhg6VOB66GYEtH25C4whmtVw+MiCwvs3SKY+c1P5rBQX7AG3joJGQ53x0P2+dmKNdopVtHAs=@vger.kernel.org
X-Gm-Message-State: AFuF++nanTfLERkZXfdT6QGSEK3+U3OCYLIHqM64bXFWUiaIK9wRzTFR
	b8EHeicNfnIhaAFG2vKfXjEf+yF+KPT6EkenKgR9KEK0gqbVt1n2zWeu3Wn6fQQJUBIy6Q+s/q9
	i1jOWWoOHlnxCNQ==
X-Received: from qkg31.prod.google.com ([2002:a05:620a:951f:b0:93c:2de2:ac56])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46a4:b0:939:6de7:238d with SMTP id af79cd13be357-93c36719cd7mr259470285a.23.1790257650650;
 Thu, 24 Sep 2026 06:47:30 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:47:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924134729.2047213-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/9] tcp: avoid struct socket cache line miss in tcp_check_space()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_check_space() is called on every incoming ACK and every transmitted
packet, and tests SOCK_NOSPACE in sk->sk_socket->flags.  Because struct
socket lives in its own cache line and the TCP fast paths do not touch
it for anything else, that test pulls in an extra cache line that is
cold when the working set of active sockets is large.

This series mirrors SOCK_NOSPACE into a new u8 field, tp->tcp_nospace,
placed right after tp->chrono_type in the tcp_sock_write_tx cache line
group (fitting in an existing 3-byte hole before chrono_start, so no
other field moves and sizeof(struct tcp_sock) is unchanged).  Both the
transmit and ACK fast paths already touch that cache line, making the
fast-path test in tcp_check_space() free of extra cache misses while
keeping __tcp_check_space() authoritative on SOCK_NOSPACE.

To maintain the invariant (SOCK_NOSPACE set => tp->tcp_nospace set) from
a single choke point:

 - Patch 1 fixes a long-standing bug in dlm where SOCKWQ_ASYNC_NOSPACE
   was tested and cleared on con->sock->flags instead of SOCK_NOSPACE.
 - Patch 2 introduces sk_set_nospace() and sk_clear_nospace() and
   converts the core networking callers.
 - Patches 3-8 convert the remaining in-kernel callers (sunrpc, rds,
   dlm, drbd, nvme-tcp, libceph) so that no open-coded set_bit() or
   clear_bit() of SOCK_NOSPACE remains in the tree.
 - Patch 9 adds tp->tcp_nospace, wires it into sk_set_nospace() and
   sk_clear_nospace(), and switches tcp_check_space() to test it.

v2:
 - Order set_bit(SOCK_NOSPACE) before tp->tcp_nospace = 1 in
   sk_set_nospace() and tp->tcp_nospace = 0 before
   clear_bit(SOCK_NOSPACE) in sk_clear_nospace() so a concurrent
   lockless tcp_poll() cannot leave SOCK_NOSPACE set with
   tp->tcp_nospace cleared (Sashiko)
 - Move tp->tcp_nospace to the 3-byte hole after tp->chrono_type so no
   field in struct tcp_sock shifts after the AccECN bitfield additions
   (Sashiko)
 - Clarify comment and Patch 2 changelog wording (Sashiko)
 - Link to v1: https://lore.kernel.org/netdev/20260922122721.3568295-1-edumazet@google.com/

Eric Dumazet (9):
  dlm: fix send buffer backpressure handling
  net: add sk_set_nospace() and sk_clear_nospace()
  sunrpc: use sk_set_nospace() and sk_clear_nospace()
  rds: use sk_set_nospace()
  dlm: use sk_set_nospace() and sk_clear_nospace()
  drbd: use sk_set_nospace()
  nvme-tcp: use sk_clear_nospace()
  libceph: use sk_clear_nospace()
  tcp: add tp->tcp_nospace

 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 drivers/block/drbd/drbd_worker.c              |  3 +-
 drivers/nvme/host/tcp.c                       |  2 +-
 drivers/nvme/target/tcp.c                     |  2 +-
 fs/dlm/lowcomms.c                             | 10 ++--
 include/linux/tcp.h                           |  3 ++
 include/net/sock.h                            |  2 +
 include/net/tcp.h                             | 30 +++++++++++-
 net/ceph/messenger.c                          |  2 +-
 net/core/sock.c                               | 46 ++++++++++++++++++-
 net/core/stream.c                             |  6 +--
 net/ipv4/tcp.c                                |  5 +-
 net/ipv4/tcp_bpf.c                            |  2 +-
 net/ipv4/tcp_input.c                          |  8 +++-
 net/kcm/kcmsock.c                             |  4 +-
 net/mptcp/protocol.c                          |  4 +-
 net/mptcp/subflow.c                           |  5 ++
 net/rds/tcp_send.c                            |  5 +-
 net/smc/af_smc.c                              |  2 +-
 net/smc/smc_tx.c                              |  6 +--
 net/sunrpc/svcsock.c                          |  4 +-
 net/sunrpc/xprtsock.c                         |  4 +-
 net/tls/tls_sw.c                              |  2 +-
 23 files changed, 121 insertions(+), 37 deletions(-)

-- 
2.56.0.rc1.310.g51773c2048-goog

