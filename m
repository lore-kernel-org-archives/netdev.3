Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101921;
	b=PQSzw4h0qgKECCU5JPpkYg7RfwshK8YX9NoyZbEc+CWFAM//QlIwsfK7aX8uTnBy82NW
	 d8AFeJ18eqCGXg/5U6i4snPd6QGdX8cxMKRwud447wfgprRAaEcXmSu68Pwbxskdh/i+r
	 +ec5stzqdF0+GYtQ2mWJuLd/aUCyt8qgltrZYLb07/mYZu0o2fDoHids+nMb0KuZ0cvzQ
	 VA+jgX3ZhLIHI/X82D9Md+TlX+NP+EOG0Am1zcDndbdoxTmvxtocTI70ttGP2/X8oe1D+
	 Dn9yWtntMEJBgCjC080q/VoOihhsaNZm0K7zfEaQDhqs1b52pgGBsyMofbl2pmZXJrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=/uSXhPx21SBnJci3H0+0ie5+kBgS6J31mI34WcLWCK0=;
	b=ck5QRD0GSV0qv8eu/b2pB0XeuqU2I+YV4xjVs4oRmtdgNOgZIV1n+UJqcHUNv5d8SUaX
	 dES5yvsF7bE5cYuyTJtW1sAjWgJKSg8Dci1+koVV9OgVDdJVqGca33w7nSIkP2jH90Gju
	 +DagVShnCq8FWUQi8wU60D+lr4zX/adiY3UHAzFB7oBYiWpThxo7UJ1RexV7D8ecChAa1
	 tGlnbBFNkfP+FCg4jNkJLIAUf6NSvnOI6B/RmXX/fIjqhzSMd1jfiJN78D3juj/MRwYOU
	 M1728OiSHBBHs41rVy8uxnsAN7Th47xZI6tsVgAkhz1NAdFG0hmTumk7pDVpVmXbHVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JAir+9iZ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE61606A330
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 01:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE61606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JAir+9iZ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36fa5673fccso141086eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 17:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794101920; x=1794706720; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uSXhPx21SBnJci3H0+0ie5+kBgS6J31mI34WcLWCK0=;
        b=JAir+9iZqT0mkGSlAiO+axrWeb4IN1pjE7KbLHG+uHYyfgfPfaWdD28zVELuudADPl
         c9qfhDy3KMpxEEdY+ED8UKN+A5mMkgJpRZPIPPXa4rncQpnmu3qJIZNKbVFXKt8RF6Nv
         hYJY719gE8AZye3SHIyMaarbqLqY90zFUKc0GQhItUut7/sVz6fic5fD2aUgra+Vbn7m
         khN/kRfbYsrPqF7r9/iyJSyjBNibjto7tRMG8j0ILScaW3EfulsHxyr2C5Ry9SZxC+0d
         Sjm3Md4YJfwQcckNbFkAVx/S2dwmewlH3+bl/KH5EHu02QOhR+Rqrnf06WCv8KM8w34l
         meAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101920; x=1794706720;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uSXhPx21SBnJci3H0+0ie5+kBgS6J31mI34WcLWCK0=;
        b=l+nv4myVZNzC3RQKQYRuEHfQvaUPgF+7d6okh/KQlPX7ojv/OfpDMin/ECjeg6WJGN
         jXMnGiebUtl2ZgzkxBy//VWCxTtAsf/Lf6mDLbZCK/Y+swziqbITZbyW1PFXZ7baTElT
         pmlZk2Sa37f92CydmUcUsaSK4xsplnEvnYWsL7u0ah1HqY440B4wbKHXeE4tg1OdWbWB
         TXrlBd8zYzZ+Qonu27FYNwnZHOOfrpSpr2dDLrOI/n2bI6Q5YHMC7drUqSK4aPLW7iLW
         G5slWGzlpKrIMWsam7A7qA+6MefU5w+M+apEFS/doMjh0PBOwRZTgzxGVEkUAu+AT+jR
         rRbA==
X-Gm-Message-State: APuU4Z9tD+THYul+DkVYyyghmnXMQIsQGUI3YPWG8MdHvsGOnaLou0wa
	zf+LPtQ1lPvdmfwIiRMKyaklGpgOnbB8VsRRxJqgsWi7fPnI1a2IDXVToDmcodBLWGg8y6jC/Um
	KDeS9OY3aSv/jNSq5y+qs9Iyysgrw48MFmbyY5OsZKPMFUbuqT2Kd6KjTgh+TaWAtJ3N3rAZffD
	qMm0Htr1Tg7YYVhbtYUotmRhcML0Jr1LShEAwok84IjS+keeUrVmtjYTk+yXkMpS8=
X-Received: from dybb6.prod.google.com ([2002:a05:693c:6086:b0:343:520f:7a80])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:8956:20b0:36d:8b1a:7faa with SMTP id 5a478bee46e88-3725d77d41bmr961521eec.7.1794101919564;
 Sat, 07 Nov 2026 17:38:39 -0800 (PST)
Date: Sun,  8 Nov 2026 01:38:36 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108013838.1454450-1-almasrymina@google.com>
Subject: [PATCH net-next v4 0/2] net: prevent mixing incompatible memory
 providers in skbs
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, linux-kernel@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"

Enforce that all fragments in a nonlinear skb come from compatible
memory providers (and for devmem, the exact same binding).

Patch 1 fixes skb->unreadable propagation in skb_split() and skb_shift().
Patch 2 adds skb_has_net_iovs(), skb_mem_provider_compat(), and
skb_frags_can_coalesce(), and enforces provider/binding compatibility
across TX, TCP, GRO, skb_shift(), and skb_try_coalesce().

v3 -> v4:
- Fold skb_shinfo(skb)->nr_frags into skb_has_net_iovs() and drop
  redundant nr_frags checks in skb_net_iov_provider() and
  net_devmem_skb_binding() (Stanislav Fomichev).
- Remove the empty-skb check and redundant !skb_has_net_iovs(skb1)
  branch from skb_mem_provider_compat(), and add a comment on the
  early skb_has_net_iovs() check (Stanislav Fomichev).
- Propagate skb->unreadable and compare skb_frag_netmem() directly in
  tcp_clone_payload() instead of rejecting unreadable skbs in
  tcp_can_coalesce_send_queue_head().
- v3: https://lore.kernel.org/netdev/20261104042521.3979880-1-almasrymina@google.com/

v2 -> v3:
- Drop patch 2 ('netmem: store memory provider private pointer directly
  in struct net_iov') and compare net_iov_owner(niov) (for devmem) /
  niov->desc.pp (for other net_iov providers) directly in
  skb_mem_provider_compat() (Stanislav Fomichev).
- Squash the skb_frags_can_coalesce() helper patch into its caller patch
  (Stanislav Fomichev).
- v2: https://lore.kernel.org/netdev/20261102231827.4088254-1-almasrymina@google.com/

v1 -> v2:
- Generalize the check across TX, TCP collapse, GRO, IP defrag,
  skb_shift(), and skb_try_coalesce() by storing mp_priv directly in
  struct net_iov and introducing skb_frags_can_coalesce().
- Fix skb->unreadable propagation in skb_split() and skb_shift().
- Add KUnit coverage for cross-provider and cross-binding rejection.
- v1: https://lore.kernel.org/netdev/20261008034027.1403188-1-almasrymina@google.com/

Mina Almasry (2):
  net: fix skb->unreadable propagation in skb_split() and skb_shift()
  net: prevent mixing frags from different memory providers or bindings

 include/linux/skbuff.h | 65 ++++++++++++++++++++++++++++++++++++++++++
 include/net/tcp.h      |  5 ++--
 net/core/datagram.c    |  4 +--
 net/core/dev.c         | 14 ++++-----
 net/core/devmem.h      | 22 ++++++++++++++
 net/core/gro.c         | 16 ++++-------
 net/core/net_test.c    | 42 +++++++++++++++++++++++----
 net/core/skbuff.c      | 32 ++++++++++-----------
 net/ipv4/tcp.c         |  2 +-
 net/ipv4/tcp_output.c  |  3 +-
 10 files changed, 157 insertions(+), 48 deletions(-)


base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
-- 
2.56.0.455.g6c5a503b38-goog

