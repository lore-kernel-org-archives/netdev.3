Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021404;
	b=IBg7a0idAVYt5WjkJJYwWwoM6FRYvM3K8UFAsUEYMTJotgf+ZEl1bNT305RDR7RSl21o
	 pKGKzvqBLUe2gPtAMvpmmILyx1eJhub4Sg/RckXosaT3pmz/5/VWdmOri6rBATzSkHB/g
	 0aPmRA892dPsULzIAOrkamAs8jIhZBuqx8LROM1g/tHgMN8yQElwtFTtopoYigPzaeyCX
	 YGuppbietj0T6cJGpA5JAWQOFxdPS3QV3oNR1xRd//vlw3945MdBnXlkv9p1HvCvxkNt7
	 Mj72u2TUsJhba70wl3o1upGD2uZ8cTu0avbOdPgXt0L/w72ubUcHbBi/M7YN/GfZlMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:From:
	 Date:Subject;
	bh=AroYtUhqASfTUnT9LkHqmR5UFi102hUMi9Q27iG8Rfo=;
	b=pOYUkwelgOZH5NLXbfZRySXFPv3fOD88mZnwwv1q5IMFCD9cUz08DFQY1b26cldKZqtI
	 tNkvmWFp5o5326BYLrxSyE6I0Wxmz1jp+B93eQF3fl8JB+8EZ4/JAbfu7hn3Dv1hbXN8x
	 55AwDRJ98HeFKULUAnZFXs2ZS25m0TR/4ON/0YfwsFwZYjXMH4DnVyYt7fQ9Zorx6Pr4S
	 6dnn1heM7VzMuHUM/u3VP5LR9gnG1OsCnUS/3hxOZOWbX15fPxAE7iXu2he09zrcwzrjp
	 y3/NBZzPQ5cZ3wO8PWc4dtVZEfb2b2YLqmQt1U61v+Ic+ajTa0QB5iXraze7+tUw3hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChX+zQGI;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4E606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13B4E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ChX+zQGI
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1430eec0070so28851c88.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794021403; x=1794626203; darn=vger.kernel.org;
        h=subject:date:from:message-id:cc:to:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AroYtUhqASfTUnT9LkHqmR5UFi102hUMi9Q27iG8Rfo=;
        b=ChX+zQGIwrpPUQrPz0X/11gv+jGEpNci4BOgrhf/YjDBWV5eez6QJSPcUofdvVkBV/
         h9v/wevyGeGWsW2185OSLnwz1DccxYm2Ecp129jniYU4vZXr6N8wvmvlRIJbuiKx6roV
         eeqTYPyHnL6u5P7yBfSXH4QLPjw2bTWsuxt6iH5/m0zla1gJSaqSPzeSN1LfJ+DPx5To
         WzE1xwxoGsLUPkf5qPenfZTNepefSAIhwKaAEvypNkzCs2XQnhUdKPbRB9AsuHrNneBa
         86+fRTpRwXwUwqhCGwNDFmIx2w/4lUQKJJHv8A/LZntmongZqMGDOPvbKeWDrt5DQNzd
         YcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021403; x=1794626203;
        h=subject:date:from:message-id:cc:to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AroYtUhqASfTUnT9LkHqmR5UFi102hUMi9Q27iG8Rfo=;
        b=XFToFz7agpGGkpw8NL76Yq/1/k3kvBF5vllNO/C4WEJULb4ffLPJqeYnpQVt9jtmsb
         p4U4tbcDSTXwQWzswCOHcCzR3FYU6Ek5ZlnKPNnjDdBRz5ENFPg1xNk1Yh8bLNNsq39N
         O1ojbD4k7l0tC9pWiKoGeMYzX90U0c0e8al/kkmj8h2APGnmWLnngKsMoJUcQGMNcgsy
         FtPedB8ybReYY0D6LNPdQfLiqe5o4AoitF1wyUglByF99iC1M7A7NmWMXDyvmVn+vVa/
         /S2aGExFrLtG/TzRDw96EMwSJxxqDHIDp66Nd6xoXB+3OAx5zW3oOhXQ96HQeNiWWgl/
         zKrQ==
X-Gm-Message-State: APuU4Z9Y8uSF6qQJkE6HcFeLeCOm4w/BpUptd4iqkLnLz/jg0Oph2oah
	CVaewX+bowUwG/ifHj/nZbKL7qZ9r9DgLjxY9RB73uvb7xncFiGim8R8
X-Gm-Gg: AYBFou1xuIkBPO8hQi6Ay+3NI9dXcDUEjCnjKx/qIo35IiKTDq8tIou77ROPh5t94M4
	TO0pQvvysxWIK1i+Mk3HfRCjK4r67atxLMs2sINtyAzMkHcVVb2OrTTe4MVyJbFKjRGZlaNzDRB
	ch3X7EqYCWZ/HQrjrYinfyoy6Y+bLPBR2iGwVb+VxwiIj94qiKwSNAm6IzX9bSMDUmz3GYdsJ9U
	ZNa7LzwF2ThpdBgoPwm/zjkDZNKJiLbzDVr77wpUBzDbCEvhYm/slUfVNbV3UkjP75t08q9kOHT
	oG0YtdkgkbOqbCSrvYMK//inighqU41tWZX828Yxookb5mnNDOG1pLxdIb7fiB9aUROfpzYCTp4
	RXAc4IOhxxAjVRwYUNIUKxkvtLnqVFhabtSv10UJn9nuH0eKHFml+WudZVhzLNwWj5bjILUrgvg
	PH8BR2MHh07thnseLOQ8d524c4l7Wf0l9HkE+gUj2H4SAnd7SYrh3jGHgwihtenvfg1UdVQraGL
	jieYMZsh5/FbdjYaHL1VwVTC9gCNdy5do4DoXPnNwomZOYgYNxmFyUlOkLiEUBfhgg854LOsihM
	XTal5qBtfJhvijzUyIlXoV50UloLK5osH889wt7eXSNM3Ea7/Tya4NIjViJaVXNj2LMw3w==
X-Received: by 2002:a05:7022:1582:b0:17f:641e:7f6b with SMTP id a92af1059eb24-1b25d2d69f1mr9357869c88.1.1794021402939;
        Fri, 06 Nov 2026 19:16:42 -0800 (PST)
Received: from msg ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4b4aa7sm9615586c88.13.2026.11.06.19.16.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:16:42 -0800 (PST)
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
Message-ID: <20261107111617.21347-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Fri, 6 Nov 2026 09:57:58 +0800
Subject: [PATCH net v8 0/3] xfrm: fix vti tunnel device use-after-free across async crypto resumption
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
tunnel. A successful receive callback leaves the cached tunnel in
place; xfrm_input() releases the reference on every exit, including
after delivery and on drop paths. The error callback only updates the
error counters, so the common drop path releases the tunnel reference
after the skb has been freed. IPTFS, which can free or consume the
outer skb itself, releases the reference through xfrm_input_drop() or
xfrm_input_consume(). Patch 1 makes the two exits that still used
skb->dev after the async reference was dropped use it first. Patch 3
sets the address family before the early invalid-state drop, which now
has to release the cached tunnel.

Patch 2 is new. The IPTFS drop timer is cancelled when an in-progress
reassembly completes, although the same timer ages out the reorder
window. A window that is never drained holds its queued packets and,
with patch 3, the tunnel reference they carry, so the device could not
be unregistered. Patch 2 rearms the timer for the window's own deadline
once the reassembly is done, so that a later reassembly does not
inherit the earlier expiry.

Patch 2 is deliberately minimal. It only bounds the stale window, which
is what 3/3 needs so that the reference it adds cannot pin the device; a
wider rework of the IPTFS timer is orthogonal and can land on its own.

Rebased onto net main fafbc4051, which already carries the iptfs skb
leak fix on the payload error path. That fix moved the done label ahead
of the delivery loop, so the inner packets parsed before a validation
failure are now delivered. The drain that the previous revision added
to 3/3 is therefore gone.

The issue was found by source audit of the VTI input path (LLM-assisted
review): the tunnel pointer cached in the skb control buffer is
dereferenced by the receive callback, which with async crypto can run
after the device has been torn down, and nothing keeps the device alive
across that window.  It was confirmed with a KASAN reproducer on arm64
(async ESP; deleting the VTI device inside the crypto window gives
"slab-use-after-free in vti_rcv_cb").

Changes since v7:
- rebased onto net main fafbc4051.  The drain of @sublist added in v5 is
  dropped: "xfrm: iptfs: fix skb leak on error in
  __input_process_payload()" is in net now and delivers those packets.
- new patch 2: hand the IPTFS drop timer back to the reorder window when a
  reassembly completes, so a stalled window cannot pin the state (and the
  tunnel reference added by patch 3) forever; reported by the AI review
  of v7.
- the former 2/3 (address family before the invalid-state check) is
  folded into 3/3, because the early drop path in 3/3 needs the family
  to release the cached tunnel. This gives a clean bisect: no
  intermediate commit sets the family without using it.
- the sentence in 3/3 that claimed the parked skbs are always released by
  the drop timer is gone; patch 2 is what makes that true.

Changes since v6:
- patch 1 also drops the skb->dev reference that is held across an async
  resumption only after gro_cells_receive() in the decaps success exit;
  that exit still used skb->dev after the reference was dropped (found
  by the netdev AI review).

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
  reference is released and the device is removed; with patch 3
  reverted, xfrm_input_take_tunnel_dev() warns and
  unregister_netdevice() waits for vti0.
- IPTFS outer-skb free: RTM_DELLINK completes; with the
  !first_skb xfrm_input_drop() reverted to kfree_skb(), the reference
  leaks and unregister_netdevice() waits for vti0.

The IPTFS drop-timer/reorder/state-teardown paths, including the
window-pin sequence behind patch 2, are covered by code audit, not by
dedicated runtime triggers.

v8 was build-tested on fafbc4051: the arm64 objects touched by the
series (xfrm, xfrm_iptfs, ip_vti, ip6_vti, xfrm6_input) compile with
XFRM, IPTFS, VTI and ESP enabled.

Tooling: the source audit, the patch text and parts of these messages
were produced with an AI coding assistant under my direction. I reviewed
the result and stand behind every line of it; the build and runtime
results above were obtained from earlier revisions of these changes.

Previous versions:
  https://lore.kernel.org/netdev/20261027105031.19928-1-q.h.hack.winter@gmail.com/ (v7)
  https://lore.kernel.org/netdev/20261022032129.16118-1-q.h.hack.winter@gmail.com/ (v6)
  https://lore.kernel.org/netdev/20261019153247.89957-1-q.h.hack.winter@gmail.com/ (v5)
  https://lore.kernel.org/netdev/20261018090638.55686-1-q.h.hack.winter@gmail.com/ (v4)
  https://lore.kernel.org/netdev/20261013074610.17808-1-q.h.hack.winter@gmail.com/ (v2)
  https://lore.kernel.org/netdev/20260930090813.73901-1-q.h.hack.winter@gmail.com/ (v1)

Qihang (3):
  xfrm: use skb->dev before dropping the reference held across async
  xfrm: iptfs: hand the drop timer back to the reorder window
  xfrm: hold the tunnel device reference across the input path

 net/ipv4/ip_vti.c      |  3 ++
 net/ipv6/ip6_vti.c     |  2 ++
 net/ipv6/xfrm6_input.c |  3 ++
 net/xfrm/xfrm_inout.h  |  4 +++
 net/xfrm/xfrm_input.c  | 69 +++++++++++++++++++++++++++++++++++++++---
 net/xfrm/xfrm_iptfs.c  | 40 +++++++++++++++---------
 6 files changed, 103 insertions(+), 18 deletions(-)

-- 
2.54.0 (Apple Git-157)


