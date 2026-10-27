Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069449;
	b=tk5s4Rm9kI4ptbzzOpguiJrGEnRMKmSHy+r1QvrnlPaKs82WFYSaOPVxJ8DCubF0XIn4
	 nOFvSBF3Pr+k568VBPJv4pLLZrNdm75/HvZh9Vft261WiYj+OngFshr6lq4E9msZ9qXd2
	 jDdeqAfsdYtaBgnc4C9zbLjwR3YNvUdltMcFTabg4Gq8zUxioe/giDY3/lV1ml+D9tqry
	 tZ1JDB6jXPB+yXCmbQoW8LgWcc+jYFghO/AH/7Kw+bEaZZBIpCnafSyv2mZ6ED0XPF9BX
	 yAuS1GukCprB8vP+gLSWxRaiB/SijFx1TGFn/ok+v8PjHj1XSaVG+3MJLY2PgVCKK+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:From:
	 Date:Subject;
	bh=nwvxhmnXB6t4sgo6hu9V2Jlf4bT2M5vvxO5O0RwI+MM=;
	b=noJpaLk081nvNWr6cBPIq4l0t+HwBFqx+M4VrjZO7551LqhC9fkh9KodNecAESyJcTjM
	 GO4wPzWweSMlWvTkcBaPV2lBMI6zEEY/pE3kju6iaa8zUridqkpWpBdDZBDTpDRQ1CtNJ
	 9313W3C5Ws8ueslJj1Vw3373Qa7EDdELYQtJPjovpRU2t7JV4cuPLSwZ5AFW8eR76oLg2
	 dzjUaafvocrBaZepT1BkDhlM3HMy05d1HF+Vph24dj3bSWyN3SMkWccV3iR3WL93wpoXb
	 h0xM3FaIV0bg33DD4jUHmo9YULZlwA1hEgHILUdYPHr1HC+QVMwLgMU260JJDCRIKZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bfTRANj6;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E8606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 391E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bfTRANj6
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e83d2cc8a2so5308155ad.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 19:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793069449; x=1793674249; darn=vger.kernel.org;
        h=subject:date:from:message-id:cc:to:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwvxhmnXB6t4sgo6hu9V2Jlf4bT2M5vvxO5O0RwI+MM=;
        b=bfTRANj6MbwQULdQ/ELfwUljfXfPF8SOj74o0/ikT58ngSyLiWLJCgpz36j17otTIb
         puw0wo5N/YLuHpBEMG4a9tq2+25ZSfzf4FapWuKNLJyYT3HUIVzZN1p986Fy+psduqwE
         GcX0KN7Se2+tqr6iK+Zv5VV1eUpVz1nCEmHYGA8wtCxN6GROdZIp9a6oL7kv6ZePjBIj
         j5eCeiDKAx2+15qcwGZjOjQEjRNYLy8IEKEJAAX9nrDG7UT/HhQfm/zQJSNPYUBsH1LJ
         HJ4n1uZ+9yedKykBVShDiJlJTr9e76nj9SanFVKQiY4BWfIk1MEW/13/545aNRJH95Kc
         zSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069449; x=1793674249;
        h=subject:date:from:message-id:cc:to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwvxhmnXB6t4sgo6hu9V2Jlf4bT2M5vvxO5O0RwI+MM=;
        b=AlnaVCV40IHHijyCFmZUO5dYm6opsQ4saWi0wwkT1TTwGoKQozVyL8irsiDB0F2L0A
         lt8ql79a95TPtjskDhcpEgqIsucAa0hsHW0QJd/GXb580H57CE3lIXUifA3boJuDnBf/
         W/fBJji2MHYWDeEUu/kdkofQsezdeDKDa6fHHIm+shM8QqkhU37mSBSXDL+eP4zZIiP5
         qcZhmq+3t8xzuJBxLuZmh5WVKPU9SkVlTccxYFRIH4ZPkxh8ylj/bCOPXZ0a3IinEFCF
         QorqyL/ctyEwdADGTfEEfp8G/MV9IJY1o29HaF3Fb6SqWFdufoNgubvhfRCdcc0CWMGh
         1XiA==
X-Gm-Message-State: AFq9FYLdbocMcEneSu0tu9SdypvB8sU6YIgshLzDSUnlNmrn0JLQ3mZ3
	lS2HQA3oGrCkBLKkikZlA38DjbBQcY08gC14z4Ht/ORYuLkca2xVKHKv
X-Gm-Gg: AYBFou1BXs/rucMEE/xoLIdclEYTkI/C+ldJl4mDRHPWlapDUJCNQDjiv+kk11oOFfU
	Q+PmDEFAuMnoi+MzIHh45yAmXR8SI+kJc1+ocHWC6+YysB/ix4pugIZSFo7mG520AHjyEuuUZ0v
	o9ENvLCdpfGseUCj0bRdVzCxDOUnVL7djmBZhdk11yxwtjVxhrcNfzQbm9iOovCyDiYhqKtx8bi
	LOaiznkg/BTZJy08Zywr7M/0/b/3QT67XJkMuQRDenoSDCg0Zfkp+9YxqpD930LZWLsDdwk9W/v
	AxwyjdI8wHsTENQzH1c2xEVMVoZVNJZLoMXHHqE7JChfwPCejCG/oeVEGuSnwY7KPHnbxGmozME
	5sbaeLY7q297YnlEjgRVgDA0uYZpKgMDn9oRtVTwI+DHHH7fI5MWXrOhrVi/g3yvi1khUciJgIz
	d3R6keFsa57hwI7X9OXBW6i7pOW+AqoSkgq4FoJ/DPZfZB1xdZWrKLqa7RVaE+AefDeDri/jbhy
	s7JEA3g99d5lMMDxI2LPuVe4gWQXx+LAyvoy40Qlgeu1XDSfm3WcT3onAC8rqQzzxA0cG9vT5hl
	HEgDV++JW7YEc5D4ukPWges=
X-Received: by 2002:a17:903:3248:b0:2e9:5714:607a with SMTP id d9443c01a7336-2ea9c59c232mr115870105ad.2.1793069448537;
        Mon, 26 Oct 2026 19:50:48 -0700 (PDT)
Received: from msg ([188.253.120.77])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ca09casm2243615ad.67.2026.10.26.19.50.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 19:50:47 -0700 (PDT)
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
Message-ID: <20261027105031.19928-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Tue, 27 Oct 2026 10:08:47 +0800
Subject: [PATCH net v7 0/3] xfrm: fix vti tunnel device use-after-free across async crypto resumption
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

Changes since v6:
- patch 1 also drops the skb->dev reference that is held across an async
  resumption only after gro_cells_receive() in the decaps success exit;
  that exit still used skb->dev after the reference was dropped (found
  by the netdev AI review).
- patch 3 now carries a Fixes: tag for the pre-existing IPTFS leak that
  the queued-skb drop also fixes, and the description mentions it.

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
  https://lore.kernel.org/netdev/20261022032129.16118-1-q.h.hack.winter@gmail.com/ (v6)
  https://lore.kernel.org/netdev/20261019153247.89957-1-q.h.hack.winter@gmail.com/ (v5)
  https://lore.kernel.org/netdev/20261018090638.55686-1-q.h.hack.winter@gmail.com/ (v4)
  https://lore.kernel.org/netdev/20261013074610.17808-1-q.h.hack.winter@gmail.com/ (v2)
  https://lore.kernel.org/netdev/20260930090813.73901-1-q.h.hack.winter@gmail.com/ (v1)


Qihang (3):
  xfrm: use skb->dev before dropping the reference held across async
  xfrm: set the address family before the early invalid-state drop
  xfrm: hold the tunnel device reference across the input path

 net/ipv4/ip_vti.c      |  3 ++
 net/ipv6/ip6_vti.c     |  2 ++
 net/ipv6/xfrm6_input.c |  3 ++
 net/xfrm/xfrm_inout.h  |  4 +++
 net/xfrm/xfrm_input.c  | 72 +++++++++++++++++++++++++++++++++++++++----
 net/xfrm/xfrm_iptfs.c  | 42 ++++++++++++++++++++++--------
 6 files changed, 106 insertions(+), 20 deletions(-)

-- 
2.54.0 (Apple Git-157)


