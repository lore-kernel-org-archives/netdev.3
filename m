Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C249346FA7
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927749; cv=none; b=B8mstq9A4vtNHzNJxEdDocEAcLFBdEyTRo3D9vsjYRrg0vkjXbAGlX1Rc7LKddcGE3at6BQCb50sJ2gbVfvugxpl6EJj5UGAYxaIfrMu7p7LKfnU80yzcRndclg71maOpOsHpiYOTf+OwY5h94uMjoBWWNYPoMd1m9MSiB4veUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927749; c=relaxed/simple;
	bh=s0EAgvM3EckJgVkgwySwALr22oijvhhzdOCY8ic2YvM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h2FWP+aaNa4Riv29Onk5PmyZSmNzs+4G1ViaaIvI6DJFc1UgoWZauNhnzy2PZmAFWY7A66P/kkdHnobCNdyKKuVIpLQO9zROik9aL6IMGoWTQZcJ0wKybPmza00uCo4yitTLxtSgtaDRTgHqBs/nKwIW4FfseDnYp40fzlr4gnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nLrG5gYL; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLrG5gYL"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-890587d4e87so160988196d6.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768927746; x=1769532546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ptuvyZao7Ss1Jo8ZUaPMdH5mHX4osio1f0VA6b4OTkE=;
        b=nLrG5gYL5ocCw/dhBwZnheNHN0LNwFoLmCRBYzwa/KclkESXI45hw3nMIU9OoXTTBG
         ZrJYInTzEWW0co+/ksnAy5qdNU5eIXHtoJMixzDm83UbjTLgboXRwnvN9+19Xrl8+JM1
         ZoSkNu9tm+PMyQj78uGU/+bs5QFRkB8kJFZ6s3xuGyLCSmuyPONKCUXz9TSvF4DOTWEh
         apJYp4He/qNi6UaM1y9cyWictGOGJTODyIudEwFOsajWvz6fdy1UEUZRBYqH1PWhIU/T
         d0UEtffCUjkQ31JRWt5z3Cage7IcjTXldMjW55CnphTyjAAAK2taxdTEfYbOwKc2A11+
         dD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927746; x=1769532546;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptuvyZao7Ss1Jo8ZUaPMdH5mHX4osio1f0VA6b4OTkE=;
        b=j9gyn5jmUIAWKbRjG7CqQP9KQZFbxpOWqkx5tuPTQO1GJShcQ4bgDA3g3yQAyiWt1d
         2UI8rk6+kciSfcwzFsvHmCmeitbtZrNaA90EgnSb2LsSpYS3aNSw6WcJ4+8jQJGuPugc
         PE1uTm7cMdlNGol5puzSGr4anPmXHcwScu94eMrxCFgiMyDCTXzeNz6waDkMYxycwKHl
         Rx5Q8j0z0DMTcG0dY6M0uqgvBL3myDxsuBKQLPHRpo8Szqswu3XivoZFwRsdPlb3cc7u
         sTbP2/kaeceB9JREvGR+th1S+Br58qQCNx+RqI6aaEct2fGIkojDmOiWkONp8VKFnC67
         LMmw==
X-Forwarded-Encrypted: i=1; AJvYcCWnswGFxq6xLXZsl7a3WYU1suskDEax0WIjJPhtLO/vheANeL7nr17cf59SbzYQrrf9b7Q1yPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqYufuEj/EONTwg54ZE5EU9gKg0r9TgmfgxNQwt27t8EDE2Ygx
	fguvT3jI0/0Q6dQbhTr50P3IqXGC7lmSDNG/GgfPXD8S+A/mdccSAK7WcUuw515xKV4ANc7ZDlC
	Z8YkaCbpBXk6WQA==
X-Received: from qvbgc11.prod.google.com ([2002:a05:6214:230b:b0:888:db8:f9a7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:821a:10b0:894:6492:73da with SMTP id 6a1803df08f44-8946492741cmr26595696d6.2.1768927746027;
 Tue, 20 Jan 2026 08:49:06 -0800 (PST)
Date: Tue, 20 Jan 2026 16:49:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120164903.1912995-1-edumazet@google.com>
Subject: [PATCH v3 net-next 0/3] gro: inline tcp6_gro_{receive,complete}
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

On some platforms, GRO stack is too deep and causes cpu stalls.

Decreasing call depths by one shows a 1.5 % gain on Zen2 cpus.
(32 RX queues, 100Gbit NIC, RFS enabled, tcp_rr with 128 threads and 10,000 flows)

We can go further by inlining ipv6_gro_{receive,complete}
and take care of IPv4 if there is interest.

Note: two temporary __always_inline will be replaced with
      inline_for_performance when/if available.

v3: removed INDIRECT_CALLABLE_SCOPE on udp6_gro_receive()
    and udp6_gro_complete(), as gcc complained (Jakub)

v2: dealt with udp6_gro_receive()/udp6_gro_complete()
    missing declarations (kernel test robot <lkp@intel.com>)
    for CONFIG_MITIGATION_RETPOLINE=n

Cumulative size increase for this series (of 3):

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux.3
add/remove: 2/2 grow/shrink: 5/1 up/down: 1572/-471 (1101)
Function                                     old     new   delta
ipv6_gro_receive                            1069    1846    +777
ipv6_gro_complete                            433     733    +300
tcp6_check_fraglist_gro                        -     272    +272
tcp6_gro_complete                            227     306     +79
tcp4_gro_complete                            325     397     +72
ipv6_offload_init                            218     274     +56
__pfx_tcp6_check_fraglist_gro                  -      16     +16
__pfx___skb_incr_checksum_unnecessary         32       -     -32
__skb_incr_checksum_unnecessary              186       -    -186
tcp6_gro_receive                             959     706    -253
Total: Before=22592724, After=22593825, chg +0.00%

Eric Dumazet (3):
  net: always inline __skb_incr_checksum_unnecessary()
  gro: inline tcp6_gro_receive()
  gro: inline tcp6_gro_complete()

 include/linux/skbuff.h   |  2 +-
 include/net/gro.h        |  5 ++---
 include/net/tcp.h        |  2 --
 net/ipv6/Makefile        |  2 +-
 net/ipv6/ip6_offload.c   | 43 ++++++++++++++++++++--------------------
 net/ipv6/tcpv6_offload.c | 12 +++++------
 net/ipv6/udp_offload.c   |  3 +--
 7 files changed, 32 insertions(+), 37 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

