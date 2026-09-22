Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77F541E75
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080045; cv=none; b=jdK9Jb08s/4nYNtJvsjBfYPMQFRWcD1Lvf4fi3WxQoPDmwk41KTFtxuQeENsR8dXHdxEmMsqRkvBlV0cmAeun5iJ4AY0kxpmY5r77en4OsVLgeM2Ai8bJlWL5fC0Nh/+ttdQRAf3kjc9VhWbqL+D6dbdOPaI3IiX6e3Zf6I7Y9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080045; c=relaxed/simple;
	bh=iE8dfLNcG8isWhV+X/yCgFVHLismpI0oj74WN5mLWrs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JXddJFx3hXVeryKQjDMjNESLLuC3A7ANbUjF77LLUjlGAwwiXJy/KQkZMu6ptysU+kAIrkjfvSheMny3YcBwBkalPTI5J2/TYOAgeEey64Mm5ml465lqC9RaW62pcrQfwPqsn6NBOZOPkng3Pyp7WKUhcVL+QeiOm5d47FNXF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMaX54/6; arc=none smtp.client-ip=209.85.222.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMaX54/6"
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93be1861d2dso608445085a.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790080043; x=1790684843; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gf0PVeKu3us2T4mPAXTmEo3n0dpwZ5CLPeitvDV6PZM=;
        b=vMaX54/60UNSsV6yWZspKc1AYdXuM5P32y7b6AALRNed22791jL+eySJI2JVK22be9
         vAdfWCPs6utf/OkEAWtwFqklJGQ0Z5f1QOF+DphYeRQH4qIfPZ2zpuCa5+f+xUDZtSz2
         2PJ6wgZo2ZRJItUQwnzhXBtYTl4fa/HO+TBlo9NKxFZAuY68gsJ94+wEQBuzobffb9E5
         VhD8YUxSgoeoQh7ZBLq3Km26c5nvKiMkYOpJhKwjSIwETeCybRh/Q1UEtD8PXQIMcFV/
         XrdPHP8NBWo+9mcGRStHHUl7romSNRBbA9FiGNMd/z7CRGu+QVr4j2Fzq2SgDA+m8Hlw
         YG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080043; x=1790684843;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gf0PVeKu3us2T4mPAXTmEo3n0dpwZ5CLPeitvDV6PZM=;
        b=Ssqrh4OQw3HIuN6BwnqF3Aef8dohr7ka4MJUugg/DRWKBiV9rZvkiNT5W4oifGyq4D
         +zqRlrx67+viFo0SXDCnfnHhV5ht4Zi9Y8bJrUppaPeUDVyUoUkPSMpcwDHVQxMPLjo4
         aBlwaJGGGN+Vq1RxWdl6piAMpVT435iHYTbMrC24cgB3Os8Qj2udl0JVP4H1o8CJlbws
         JkRFXBOIuzDD4mV1sMRVrK6H0N5rTtXz6Mdg5lkFEyX2xzinUPLHhlPZ/OM5fQBVr+KD
         kicAswW7lBS2D9k0UOp7rV7OwoyVlPUiSfBA03YPciiuezY6ZMV4wdYWE1f6FGO+e4sG
         FsJA==
X-Forwarded-Encrypted: i=1; AKwUvBxT0zhurlxprXIA4JSNb7FHPG5Z5g6HY/546fETZ0w6V+b9mgpMJ25RTqXAHsL00/5pTiPF6qY=@vger.kernel.org
X-Gm-Message-State: AFuF++lLkymgA2ggtln6SF/aLJ2DlAotHixJR2ajbJMomrzEfItauo6Z
	CxuTl68pPw67ZtwACHQQfIrRhOJdkawNjt37mCZE0dtK3Txx9dBFPVJ+9ceTeqb75KBFHHlntYe
	ZE5L8Lc8UX5h1Sg==
X-Received: from qkbg23.prod.google.com ([2002:a05:620a:a357:b0:93a:d5c:4ae2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:440d:b0:93b:d7a3:45ce with SMTP id af79cd13be357-93c15e8bf36mr527077585a.55.1790080042326;
 Tue, 22 Sep 2026 05:27:22 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:27:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922122721.3568295-1-edumazet@google.com>
Subject: [PATCH net-next 0/9] tcp: avoid struct socket cache line miss in tcp_check_space()
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
placed in the tcp_sock_write_txrx cache line group (fitting in an
existing 4-byte hole after pred_flags, so sizeof(struct tcp_sock) is
unchanged).  Both the transmit and receive fast paths already dirty
that cache line, making the fast-path test in tcp_check_space() free of
extra cache misses while keeping __tcp_check_space() authoritative on
SOCK_NOSPACE.

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
 include/linux/tcp.h                           |  4 ++
 include/net/sock.h                            |  2 +
 include/net/tcp.h                             | 23 ++++++++-
 net/ceph/messenger.c                          |  2 +-
 net/core/sock.c                               | 47 ++++++++++++++++++-
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
 23 files changed, 116 insertions(+), 37 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

