Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661509;
	b=OjTJeo1Bnh+PgBDj9zzHzavPMp4MTFwRTfMKgZqDA8TH2GpktSsSSyQcaFUzTI4muC+R
	 Ar1DN3LrTbRqAEcYEQOQLzVpQrmIrmZdOcrUpprHdCiA15NNijhxeQunzXoMIi3cYpWrV
	 v4bM10uFuzjs847BQyohJr/nnAlWvWxMCX5A5iUwuAV1hYnNBliigbxu70vhWAL0CwkrX
	 SYhznQ77NxunXQQpuvlRZHfB2MNqhreBTPVgj/cUOohzih+66tgvj9JYYmJuuRYJhSEjc
	 vhhIiWxaflT6SlzKoy4FOJZEl3T0YPrAxSFbqhPTd0ZzT+IAJeGySaRrQKgd7BrY63g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=LFVGfhguVIcON2Iuwy9nGTiu+m3FyzEBTJ2yKEsx2aE=;
	b=FnqO7ri73woZMenqqkjOR6dactlal/OBEKFJ5/2e/gvC8ZlQFL0B8cX2xu4EbsfUuTTK
	 LzvgFtLmy8e9MImhsewZyOvRCQxaJq/8ylhFXPhMS/GS+smMC57hmz4VMyyQUZAT+eedS
	 mmek4oa4Z8QLgVpuvhpATQ+1Oq52qbwLjolKXjzdLOYwqjpJU3qvc26Sf6agIgWOElYzE
	 J8nZhHUa+fG34IYS3YoV5qgt6MvR5JQbsTe+LUedEQ48wttcxt3yAwHQapzzzojB/IfTf
	 8Hb2v8IKVi9Q8qnjIjkM24L9LV8nWsis4x4DxGNJsESAMFPbAF24wyprvinSIolu4eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pCYadnoz;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A153606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A153606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pCYadnoz
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so8114716eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 15:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793661509; x=1794266309; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFVGfhguVIcON2Iuwy9nGTiu+m3FyzEBTJ2yKEsx2aE=;
        b=pCYadnozmdLxobjsf82tM+pHX/5Hd2Hmqw2sgSQ5JJyF9VJtTZy6XVBZK8/NcUIRoZ
         21UITC+Ev6adiFx47WwZAhEzNhaYCtITCVmC330dWihRl/LMEHOqHjGieQTGOANF0VwW
         Lj5I+5taQI9rda7oJ1jO1JwpA/Gmz1P2j3LK7RrA2LoaeRQHtgUZ1wzhe3xFCSGMKfWy
         R+CBTrURncK75W4aMC0m9R2TWmRHBG7BpoFdNkCAWmwal+NFMycOQEcr7UEPGlGmW4Zg
         p+a9GJ04PaGoIQZNK0bAKXddZKaRRjDLWLXgRFf7zv9hR7IMurhXtZGAMhcK8NQ1iIkv
         0leQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793661509; x=1794266309;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LFVGfhguVIcON2Iuwy9nGTiu+m3FyzEBTJ2yKEsx2aE=;
        b=1Zv/ti/yIvzFcj/00rXvVBPHMsvOGe/2u2RrZWWVnt/wszp6azMV1vltShvIfogd/b
         IZdpjKwy2xLNUXDLMkULluXnmiiV175y61a7mN/pNVEc+5+2gopRz2zNggh30LElIk9e
         YBdTxlB/YSJhEGljsMCFHCVQrEPGsKiPZbf8+TsE4J3lDprFhLHSblta+WlnV2gM/LIx
         2y+UGY6PlhVhCVB1fLKCtmIrhy82/FCLbaACDqwbyDKko2Y1Mtytm5aHoidPOpnorGmw
         oH+6VtbXqpo3ui7B5JjUgLiVDdP/ut1LzQhnjZ9KN5m9WZxAXimNrjzWulMcNLHFMJjv
         mApw==
X-Gm-Message-State: APuU4Z9/RcpFyaP2oeuwwes4uEt/tKJvJY4zJE3lUIl03/UNE9Og5q40
	B/WihVmERKaPTwxzIB/Ks3EXAzBGj7vOe0Z1vRfOWSQBHU10RY5/wtBqZZ1EPhE5fd5xAhAEHgc
	lFvopmU+ZU5KaG4/9sWrdtryOUA+4fnAdp0G6QoJqapMa8644Tpg6IcAQ3f2R0ql3vVX395931K
	cA8TCXKxw/HdM0x7TA44gb+UtrlnfQSGHp8qz3wT9o6uj7jRktHCJ4V2+5crb99qY=
X-Received: from dylq31.prod.google.com ([2002:a05:7300:599f:b0:369:dee2:2b2b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1886:b0:35e:6eae:c01a with SMTP id 5a478bee46e88-36a4237d9d5mr17726681eec.19.1793661507989;
 Mon, 02 Nov 2026 15:18:27 -0800 (PST)
Date: Mon,  2 Nov 2026 23:18:23 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102231827.4088254-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/4] net: prevent mixing incompatible memory
 providers in skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, io-uring@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Enforce that all fragments in a nonlinear skb come from compatible
memory providers (and for devmem, the exact same binding).

Patch 1 fixes skb->unreadable propagation in skb_split() and skb_shift().
Patch 2 stores mp_priv directly inside struct net_iov.
Patch 3 adds skb_has_net_iovs(), skb_mem_provider_compat(), and
skb_frags_can_coalesce().
Patch 4 enforces provider/binding compatibility across TX, TCP, GRO,
IP defrag, skb_shift(), and skb_try_coalesce().

v1 -> v2:
- Generalize the check across TX, TCP collapse, GRO, IP defrag,
  skb_shift(), and skb_try_coalesce() by storing mp_priv directly in
  struct net_iov and introducing skb_frags_can_coalesce().
- Fix skb->unreadable propagation in skb_split() and skb_shift().
- Add KUnit coverage for cross-provider and cross-binding rejection.
- v1: https://lore.kernel.org/netdev/20261008034027.1403188-1-almasrymina@google.com/


Mina Almasry (4):
  net: fix skb->unreadable propagation in skb_split() and skb_shift()
  netmem: store memory provider private pointer directly in struct
    net_iov
  net: add skb_frags_can_coalesce() helper
  net: prevent mixing frags from different memory providers or bindings

 include/linux/skbuff.h   | 58 ++++++++++++++++++++++++++++++++++++++++
 include/net/netmem.h     | 15 +++++++++--
 include/net/tcp.h        |  5 ++--
 io_uring/zcrx.c          |  2 +-
 net/core/datagram.c      |  4 +--
 net/core/dev.c           | 14 +++-------
 net/core/devmem.c        |  3 ++-
 net/core/devmem.h        | 25 +++++++++++++++--
 net/core/gro.c           | 16 +++++------
 net/core/net_test.c      | 34 +++++++++++++++++------
 net/core/skbuff.c        | 34 ++++++++++++-----------
 net/ipv4/inet_fragment.c |  3 +++
 net/ipv4/tcp.c           |  2 +-
 net/ipv4/tcp_output.c    |  3 +++
 14 files changed, 163 insertions(+), 55 deletions(-)


base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
-- 
2.56.0.385.gac671c819a-goog

