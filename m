Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590428;
	b=ggVVz7lSgiE+h+YNtkOnO554H+62MsLnuWllIw/Rx7F7y8Vaat0/rRiUU2YBHvY9kqiL
	 ula8hv6FHGjJKjAypjgSFB+ukb1IpjxkeB5hLs+6gzMKvUK2yrbxHsiFpT/uSOgGRJsML
	 NpKI43FTDmcOwEXXSUi1SXuZY3QMvfmBBhcnTrzhbcjYCdA+v7McKTfgoIcivBFV7RtiH
	 u0Nqo3Wjz89YsJTuvFoh+gS313J5LdlNI87PGo5fjt3Q2WCXdtHdljl/0d9zSR2IreTni
	 p/FM+T1zr9MlPytVlnSbw3JjitoLtlHT+haQ4pB34YUw1f5ceX3unfj82GUu88Qtx+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NSUQxko8Tfcm6XPL29du3h24csJ7ZCIrANnIj8sRtpc=;
	b=XxGTZg6FSkUdXcKFhXXiU/pW1fNBrFLaqFl8O3CUYmg0BEY/GzDSJO4ggzWQ/ZqgLAzh
	 QnT7AVGaEAa2rmGLQrvgU6HyBGaNd93mI/0rXgd8LqE5f8t7eGA2ARbT3By/eVtyg2rYy
	 DIU2y3smCr/sqJ1tQJzjufMIKRebR3G+P/tWUiLm/7A4jGoxxQ0gUyR+dEMKSICuARXWM
	 x3cq/ymIsjaJNjwQNa29INXrRURHOCLB2en0S02ivCYum0uyX/9g+JuLOJEWy8WK1TUUt
	 Q6wigAb3y0Qk6/0mNmTLmNWNqNfg1JCTxQTfQxvmJja0L1JwRQF5b7H3vt3foM4ei2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=m5CPgDQ+;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84474606A324
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84474606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=m5CPgDQ+
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c19fc50abso3882646d6.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590426; x=1793195226; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NSUQxko8Tfcm6XPL29du3h24csJ7ZCIrANnIj8sRtpc=;
        b=m5CPgDQ+uMdTTXJ1MoCsEzjiZVnV5Gx7K7iA1qGI7Yo12/ZEr1ITFBtESwQaLueL91
         SnsGzI+9VUif2T9avTOm034EL59VbmJl91Zo7JUIWJGI9ZH56OnP87t0opPk4UuFlvN/
         jycYu/lF/dO3DSwDUQ92umIaDz3S0Ix9StC0c7KDfbP7/AU6MR7cOZmKqnSynfuCz8sD
         XboIwlrK02dfvFkb4IaDJVLRSrXmyp8djFlOs12HahMKqBOZ0JbJSKwAkILyIeOnYswQ
         8KM1OVke3copj8akKIDrr7Uce+TSkRmwwpv8s0imHC0Ylz+bm9yDty86UPw5brxLHcgr
         xubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590426; x=1793195226;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NSUQxko8Tfcm6XPL29du3h24csJ7ZCIrANnIj8sRtpc=;
        b=I3Gvt56/ICl2P0wZU56Glaw9G4DS768+GNeX2/WYSjW4TKCgzkfCs4IzGhJL7gVKdk
         Il4w6KVSZnFCUP5h1fO5EVEZa0BjhE8YWUpkJJkitNOVXckCcHWIAfN9mjtAND5P79mH
         /y7fPoGie5t0+Is8bGSh1foWny3Qi47zNEX+FvqxXIgv1c7SjiqaiZr88gc6CO7Ilfv8
         mB+qsM/O+UVH19HroG/J0juOd6Bf3yJOloxtKY/QY2iCkuhKcWCbpkDmuQE5kyB44p+J
         tOmw7nkNVZAdsV5bUj46+9fBX5WqMauRvDdihxhVo5yoDBtxq6fXoy/Q4SlSPmdq5lA8
         g3PQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHpJ3oz0U3IiYPbeFTSG7q5U0DO1ni+nVsxKx0kxpj/rz8O84A++ENqur+G7AmveX3/5Mx668=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe4s2VpaqZWPrGoP1+MLQvv0q0M+z3YuK3z1dY2ZMP2B0NjJZG
	iUph/wgFwMo38djGQIhzWrr2fbPhXgrw9B9hYFBxYnRBjqJgkmZZHGtq8GrdNJ9GHYk=
X-Gm-Gg: AYBFou2jWLfNpu5EDycLGbPsTy18vLaCv6LaHu7mW+JGVeiyGiMTnRm/GeZpvPe34Ys
	0tu6yuxik+l7zTO/2yLNkgbADB/4IlTSSz941JhpfAvhu5fcfiB5aYZ/nE/EnfkURcWRL/eGBee
	MY65WPSLA1Ma+QigAV/JlFt64b9BjSjYTotQOrHKiJDEmZykgbNwyAu8U1qhqfv21ftNgUhHdTA
	nfScEk3GCUsR4h/FFBfmud513QniplJiTCyVV6mJRBt7er6SOHILVVHjgxwVR2mqVPCMlkF78V/
	xBg5Q/KQO+ttiMl5wq1VNzn6AokdOw7qSE1bifMDhZ620YeVEwT/Q1FaGp3/LdfxzyGMjci3Yw4
	vxjGCs6CllzC6CT9Likm8KacoZY4xM3rKHDqLgACw/S4KEFlIxQCil8jBU+TyfsqNYUy2bnu/q3
	7a0lxYRI/yjD7GIchz4G9ar+no/dh9nbPZIOif216RJRD6HYkvEuZGEjlnl5n93bIGCA0Eb9Wne
	mAf0h9ItY0W2U0So+63LZsumsj7AO5wSVRkfvSztq0mouzAlqrJzXo91yv3oJojf4h3MvoNHwIN
	j7gp6cKguNFYcGP8pw==
X-Received: by 2002:a05:6214:5684:b0:91b:925f:d0dd with SMTP id 6a1803df08f44-91c12ed41a6mr37332546d6.24.1792590426192;
        Wed, 21 Oct 2026 06:47:06 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b71043sm25068716d6.9.2026.10.21.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:05 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next v2 00/15] net: skbuff: follow-ups to the BUG_ON()
 removal
Date: Wed, 21 Oct 2026 13:46:44 +0000
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbC2GoC/32OzQ6CMBCEX8Xs2VVK8PfkexgO3XYrVWxJWxBje
 HcBvepxZmdnvhdEDpYjHBcvCNzZaL0bRb5cgKqkuzBaPWrIs3wrMrFFKjDeqDUGqb2gd2h8Xft
 H20SUWgipTb7fyALGgiawsf1cfgbHCR33CcrPJbZ0ZZWm7ilLMjJSkE5Vk1U3ayrWs/ljbXqqb
 Ew+PGf4TswzX87DP85OYIaF0MRmk9HB7E7J91Y10mm5Uv4O5TAMb/GmpXoaAQAA
X-Change-ID: 20261016-b4-skbuff-bug-on-followups-ad11adf285a4
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>, 
 Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590422; l=4828;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=MkdG+2v6TUl21fjtjrRq3//sPUH2f8XRlORQeByLWDY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO2vlJS71pMOkXvl8dcJMiw3/K0ESBPLJ0YBRx9eL5GrB+5fwCnrWBfCg1SGoHqd9H8+QO+i+vN
 43y042wwUbw4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

v1: https://lore.kernel.org/all/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com/

v1->v2:
- skb_segment(): check each frag_list member as the walk takes it,
  instead of an extra pass over the frag_list up front (Willem).
- KUnit test: braces around the suppressed skb_segment() call (Willem),
  and the comment update for the non-uniform case moved into the same
  patch (Mina).
- Picked up Willem's Reviewed-by and Mina's Acked-bys.

--- Original email (v1) ---

Hello,

Jakub applied v2 of my skbuff BUG_ON() series[1] before I got v3 out, so
this is what v3 would have changed, as fixes on top of what landed, plus
the skb_copy_and_csum_bits() patch I'd been sending to net on its own.

Patch 1 is that patch[2], moved to net-next as Mina suggested, with his
Reviewed-by.  It makes skb_copy_and_csum_bits() report failure, and the
rest of the series builds on it.  Please drop the net version.

Patches 2 through 6 deal with skb_checksum() and skb_crc32c().  My v2
had them return 0 when they run out of skb, and that turned out not to
be safe: 0 is a valid checksum, and it can make a packet that was never
fully checksummed pass verification.  So they get versions that report
failure, skb_checksum_full() and skb_crc32c_full(), and the core users
switch to them: checksum validation now rejects a packet it can't
checksum, skb_segment() and pskb_trim_rcsum() fail instead of using a
bad sum, and skb_crc32c_csum_help() drops the packet.  skb_checksum()
and skb_crc32c() stay as wrappers that behave as before, and I'll
convert the rest of their callers per subsystem in later series.

Patches 7 through 10 fix problems Sashiko and an LLM review found in
what was applied.  skb_zerocopy() refuses a zero-length copy that Open
vSwitch can trigger from a user namespace, skb_try_coalesce() and
skb_copy_and_csum_bits() can be handed a negative length, and
skb_headlen() can underflow in skb_copy_and_csum_dev().

Patches 11 and 12 make skb_segment() refuse a nested frag_list, which
could still oops on a NULL list_skb, and add KUnit cases for the layouts
it refuses.  Patches 13 and 14 get rid of the same BUG_ON()s in
xen-netfront's bounce_skb() and tls's __skb_nsg(), and patch 15 updates
comments that still describe the old BUG_ON()s.

I tested this with the net_core KUnit tests, a test module that drives
each of these paths under KASAN and fault injection, an Open vSwitch
reproducer for patch 7, and a stress run over veth with netem.  Thanks,

Josef

[1] https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
[2] https://lore.kernel.org/all/20261013-b4-skb-segment-nosg-unreadable-v2-1-6c28d8ffa51e@toxicpanda.com/

---
Changes in v2:
- Link to v1: https://patch.msgid.link/20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com

---
Josef Bacik (15):
      net: skbuff: make skb_copy_and_csum_bits() report unreadable frags
      net: skbuff: add skb_checksum_full() that reports failure
      net: skbuff: fail checksum validation when the skb can't be checksummed
      net: skbuff: fail segmentation when a segment can't be checksummed
      net: skbuff: fail pskb_trim_rcsum() when it can't checksum the tail
      net: skbuff: add skb_crc32c_full() that reports failure
      net: skbuff: let skb_zerocopy() copy a short skb without head_frag
      net: skbuff: make skb_try_coalesce()'s len unsigned
      net: skbuff: check csum_start against len in skb_copy_and_csum_dev()
      net: skbuff: reject a negative length in skb_copy_and_csum_bits()
      net: skbuff: refuse to segment a nested frag_list
      net: test the frag_list layouts skb_segment() refuses
      xen-netfront: don't BUG() when skb_copy_bits() fails in bounce_skb()
      net/tls: don't BUG() on leftover length in __skb_nsg()
      net: update comments that still describe the skb BUG_ON()s

 drivers/net/ethernet/sun/sunvnet_common.c |  10 +-
 drivers/net/xen-netfront.c                |   7 +-
 include/linux/skbuff.h                    |   8 +-
 net/core/dev.c                            |   7 +-
 net/core/filter.c                         |   6 +-
 net/core/net_test.c                       |  53 +++++-
 net/core/skbuff.c                         | 275 +++++++++++++++++++++++-------
 net/ipv4/icmp.c                           |   9 +-
 net/ipv4/ip_output.c                      |  11 +-
 net/ipv6/icmp.c                           |   7 +-
 net/ipv6/ip6_output.c                     |  11 +-
 net/sunrpc/socklib.c                      |   9 +-
 net/tls/tls_sw.c                          |   5 +-
 13 files changed, 327 insertions(+), 91 deletions(-)
---
base-commit: 6b3e73774815910a39d8ca75b9ad7df963f61d50
change-id: 20261016-b4-skbuff-bug-on-followups-ad11adf285a4

