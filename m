Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792639595;
	b=14KtFhrmJF85ANMrOaRzBfmBpRqgkZZk1JJlOJobWqr1mno3oAdrbiW2JECeCK38wZPl
	 vhAwOMfVNiv8sZTH0g3LCblF5gg+WJljAl+/GZN4qhvxHTK4Fw78a5sGYqgBjBgn/1oVW
	 CUNOGDgDGSuXoKRugtWd4qb9Yx1VjFmKz8ptNNdu9piKkvp3bswUnIc6/aAzhZOV67KAb
	 hrk94LdKoLM65H0Zqvddh21BAJrCl2BmbJgpxNgK4KVBTvL3Rz5264f+xi/xItvmxm6lD
	 +STgHXYMDAEVZur4a2ooRSIBrOpxU9OuOt97EqmaflpBz4VJsbjFXDs4so8Oaxg9q6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792639595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:From:
	 Date:Subject;
	bh=lX4RNbICX972FW4OAVw5ym3fC/m53d8AENW5nEWlcJ8=;
	b=qmUlJU5+m96MMt1zihPiLRhtJ5Zgb90xj2aB2aepbVFo0vF/53g1L0VrJEj2uhb/rXua
	 AL7LxdILh/BZOxOg99H/RVcdLAVpjwrMNZYReJYNICSDgfzI0sBp2xJVnj4J3DhGmj+Df
	 U6eCNWK9NQDYbVB7MLb0xc2mFn27Zg/Z0l1Ylv7oupFK/l4lxJ1YSd7bEj9SttZrJVr1V
	 hIzD8vP34k0scWbY+OHlXGIXeDI9pgvKhQ/2fh/MMyVCJMS7X1Jc4vS49HAOw6vCPJoKQ
	 kgn3auc6rLCMmwnmZp38uJ+p7gw5D7LPB51FKSm+XcMTpCrgcXhT6RQBmSRQ94zjecA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QfvazkSJ;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD6606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 03:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CD6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QfvazkSJ
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ad0c2e71ebso148675a91.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792639594; x=1793244394; darn=vger.kernel.org;
        h=subject:date:from:message-id:cc:to:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lX4RNbICX972FW4OAVw5ym3fC/m53d8AENW5nEWlcJ8=;
        b=QfvazkSJWXw0qOJEJoelwgWwZpsp80Hd8HYYTcaIALRewjq/tp932zyup5X90PiHiD
         BxlZK8+qRBDnEzSwuArwEf8Z01K7McbTUOfpdKclRs8Z1vMmjStQSzMm6/qQhAow3RQi
         B3Bgu8Ryw3B9VUz0gFqVHRfR9YX41IoY9qM+P9KXpn6zp+O+ylh4hdgLLRKKtYa/qlE9
         JO3UqxP2jVD34CiOZmvERNs3VHy6MVrsi/asyDKcL5lKHInJyN0sf4owj0Pf4hGGCcwU
         VUqUP3R6V6OpNaJbTCd7bzLdCiVP1blX3/mipvHQWzAO1C6p32OIV3hjtWKkWaml+HUz
         W8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792639594; x=1793244394;
        h=subject:date:from:message-id:cc:to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lX4RNbICX972FW4OAVw5ym3fC/m53d8AENW5nEWlcJ8=;
        b=RxuFmq08p97AHegDHGls3PBzxM5Tv6kwaTJWLoheWkOhNU9P89ugfnzHENiGIFpYnb
         zgjscsqq3PoARmYVUDjze/wP/ez4R8EfVmEu2+z1cZo3UmtadkLsahLmV5aMNt8WUgC1
         pAZOpvRc/QhNrDed2lTmqjuIxFxIO6krjVIkdSjaFsElk1DkCJBUPj/fzy6APnllRWrV
         07VqWbe+rZUKvfLBKdG3T3U0tszX8HDhgujxycQ7oH+VaPWTUmXGiBb3FQ+wjb4v94WJ
         jdIHXGUzzW21PCEYB5EitQuMMEeTJD7lBPDXjJN9Z1In7EpQLE5ex4HJ1E/FULWnDGqZ
         yURQ==
X-Gm-Message-State: AFq9FYIuxCF2rPn5PMUaGt9BgAtRXM9mwir9Ouq1Akd0rPmF3kX1tFgE
	F/tTdGAOZrTE6LNx3Q6c0IceOd8yn9BTUNiQFhiP9gG52a4gS7nrzR2L
X-Gm-Gg: AYBFou3ZfGRy/qNI3kJO/T7goR4V0EEMqPZsny4G8QbXxxea+DRPwTp75fEPGcPERBm
	yKjH4vJUK1nqs49B19tMXaKklRVYDrau7Z7GN9Pocbyi9khwBXFHjUFuImheGwNoP6Ss2HY0PDQ
	OlaU9q4x2o5M/A9PLeOtRXnbbftd/MTyfoHBIKw4864zCWHTfXTHJGt9BrtR7Di3DBxMJAndGNW
	qOodncnMbCMwYP28bFjXTNkbJTjmpELLdJUIszcXVgHPDNfr6di9nHr0PsiTNiysbSkAaHyFJeA
	lA3RSw6oDvzWQhE0h8xIIbIwLvWJiU1BCGt6s5jQSJZSlEFx2WqtH58V+HIomRVBg/w1NbIjI8v
	hcezfF+C9PiYPuZkD5mRhmaDhzqa2vzQzVBCWta3xxvnTyAZz6+LRaRkbvd7JnC0ehpaD7zJYoT
	pqN1zkYOyn1R12mo3HNPXoBzBDB17tbWBHEaNfbSwWZQX2Joks/f6lqp8M+53FPgPBOpHHkGaKG
	sOFLpPuZZ6z9wCglN14yRMIbZ3+NjomDPqUmlJRLGWdapfPAYkMUtrY6tT5jXlWTdHHEk3wie/w
	PwCRemMKMRYL+0f+BAKY7g8=
X-Received: by 2002:a17:90a:fd8f:b0:3ad:a84b:df1e with SMTP id 98e67ed59e1d1-3ada84bdf58mr1132570a91.1.1792639594449;
        Wed, 21 Oct 2026 20:26:34 -0700 (PDT)
Received: from msg ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada488550esm2116014a91.3.2026.10.21.20.26.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 20:26:34 -0700 (PDT)
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Message-ID: <20261022032129.16118-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Mon, 19 Oct 2026 23:22:48 +0800
Subject: [PATCH net v6 0/3] xfrm: fix vti tunnel device use-after-free across async crypto resumption
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

This replaces the earlier vti/vti6 series and the reference-transfer
rework.

vti_input() and vti6_input_proto() cache the tunnel pointer in the skb
control buffer without taking a reference. With async crypto, the
receive callback runs from crypto completion and may run after the
tunnel device has been torn down, causing a use-after-free when the
callback dereferences the cached tunnel.

The input hook takes a reference on the tunnel device when caching the
tunnel. A successful receive callback leaves the cached tunnel in place;
xfrm_input() releases the reference on every exit, including after
delivery and on drop paths. The error callback only updates the error
counters, so the common drop path releases the tunnel reference after
the skb has been freed. IPTFS, which can free or consume the outer skb
itself, releases the reference through xfrm_input_drop() or
xfrm_input_consume().

Patch 3 relies on the first two patches: the receive callback must run
before the async skb->dev reference is dropped, and the address family
must be available on the early invalid-state drop path.

The issue was found by source audit of the VTI input path (LLM-assisted
review): the tunnel pointer cached in the skb control buffer is
dereferenced by the receive callback, which with async crypto can run
after the device has been torn down, and nothing keeps the device alive
across that window.  It was confirmed with a KASAN reproducer on arm64
(async ESP; deleting the VTI device inside the crypto window gives
"slab-use-after-free in vti_rcv_cb").

Changes since v5:
- cover letter only: record how the issue was found.

Changes since v4:
- IPTFS: when an inner packet fails validation, __input_process_payload()
  can reach the drop path before the inner packets queued for delivery
  are sent. Drop those queued packets as well so the outer skb's tunnel
  device reference is not leaked (found by the Sashiko review of v4 3/3).

Changes since v3:
- the cached pointer is always a tunnel; the address family selects its
  type, and a non-NULL tunnel slot denotes one held device reference
- xfrm_input() takes the tunnel device out of the skb before
  gro_cells_receive()/transport_finish(), which may consume the skb
- the device reference is dropped only after the skb has been freed,
  including on error paths
- IPTFS passes the state's address family explicitly instead of
  inferring it from the secpath; consumed skbs keep consume_skb()
  semantics and drop paths keep their skb drop reason
- drop the xfrmi changes: it re-looks up the interface and does not
  participate in the reference transfer
- merge the reference and IPTFS changes into one patch so the series
  remains bisectable
- the gro_cells NAPI window is pre-existing and is documented, not
  changed

Runtime testing (aarch64 QEMU; KASAN for UAF detection):
- VTI async success and error: RTM_DELLINK completes without a KASAN
  report; the unfixed tree reports slab-use-after-free in vti_rcv_cb.
- Async resume with the SA deleted during the crypto window: the
  reference is released and the device is removed; with patch 2
  reverted, xfrm_input_take_tunnel_dev() warns and
  unregister_netdevice() waits for vti0.
- IPTFS outer-skb free: RTM_DELLINK completes; with the
  !first_skb xfrm_input_drop() reverted to kfree_skb(), the reference
  leaks and unregister_netdevice() waits for vti0.
- IPTFS aggregated payload with a valid first inner packet followed by
  an inner packet with an invalid IPv4 header length: RTM_DELLINK
  completes; without the sublist drain, the tunnel device reference
  leaks and unregister_netdevice() waits for vti0 (Usage count = 2).

The IPTFS timer/reorder/state-teardown paths are covered by code audit,
not by dedicated runtime triggers.

Previous versions:
  https://lore.kernel.org/netdev/20261019153247.89957-1-q.h.hack.winter@gmail.com/ (v5)
  https://lore.kernel.org/netdev/20261018090638.55686-1-q.h.hack.winter@gmail.com/ (v4)
  https://lore.kernel.org/netdev/20261013074610.17808-1-q.h.hack.winter@gmail.com/ (v2)
  https://lore.kernel.org/netdev/20260930090813.73901-1-q.h.hack.winter@gmail.com/ (v1)


Qihang (3):
  xfrm: run the receive callback before dropping the skb->dev reference
  xfrm: set the address family before the early invalid-state drop
  xfrm: hold the tunnel device reference across the input path

 net/ipv4/ip_vti.c      |  3 ++
 net/ipv6/ip6_vti.c     |  2 ++
 net/ipv6/xfrm6_input.c |  3 ++
 net/xfrm/xfrm_inout.h  |  4 +++
 net/xfrm/xfrm_input.c  | 63 +++++++++++++++++++++++++++++++++++++++++-
 net/xfrm/xfrm_iptfs.c  | 42 ++++++++++++++++++----------
 6 files changed, 105 insertions(+), 19 deletions(-)

-- 
2.54.0 (Apple Git-157)


