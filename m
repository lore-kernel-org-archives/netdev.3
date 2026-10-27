Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141838;
	b=GPQjeV/+Fjy9SoBun6EzsW5UbFgnhymNf/yp3S2d/W2v8OiofUehHoxiShOxRK5/jLa3
	 T4529+WcjoF5qmmiyo17IFRbGeqETefXpvoB6021CRUxL/yJ30c4BcSfPXTKD8WKCqEbU
	 WmIepMcIF0sek4wvgwLgBahHqW7PoSUR/MB2+24O6nRa3Pb2bqMjbTM05bmDkNtYe/GYi
	 ROZ02j2dGgeA76dTT9oycywqui6ZP04jGtwaSbmjrzuzBYPuEPjCMlolDdSLL4MEzu4ZU
	 c6YycerwXETCRgrhcFSSkqF1i+nlhCEIAXyTJog7c4NyzpqS0BS2P3jUHeR2LaamvaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x4Wb1nq3gFYdX6BA5R6X0Kbpi+TDs/uhIWeWQW5ffww=;
	b=n3WRTurZLg+RdQnsVL3IM3hQyL50UIDVHj98lBEqIxi24PBg7P9MLdl7JYW7pNo7ZJhF
	 vSKPrMYpuMIAax7eScgef316/mKrZbDM1u6NZ4WtqGS0QqGEB4IkxkdCnkj1tBTYoYJiJ
	 WKoMUE+uRBg5ryLZ9PiDMdEv9686lQebl2AIyeNoHIU8VLbfCCyw2oxnj8fysf+R6JQPV
	 zYqeYiDu1HWpTR2YbjpyFsnIpfD8W2iBHWU68bXhiIPkM3QJdwXza8ZtBJV19dKO6gNtO
	 beWXc6WyM2CUfCWPlxyNXrKQUOPy/Aqa6pn9N52qWbTQQEEDIjGQkBTgdc4bR3X/CKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgCH0ctU;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27242606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27242606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgCH0ctU
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso1683755ad.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793141837; x=1793746637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4Wb1nq3gFYdX6BA5R6X0Kbpi+TDs/uhIWeWQW5ffww=;
        b=wgCH0ctU69DCcoz3Ru9BWpJRF/qCvUOXZaq1XCXJ1mY+CrA71lhfiXobTbCAgjpBrk
         DyaxcIPqmt4+ye/6ixGQledSXjLCZRsPF5G8bzUZUp+e27MPNEmH65LnNlJLvMr2Et58
         9FQoB0qgzbGh45aAKAz1ywuxDNOmjfeeOIEF2KOld7xjB9gKcLc1Ur0b2fMUX5Lqj0+w
         Ra8L+RM/OPIkhQsMGjJL0fU8XfOeRal7e3+EFHTgd0ooyWqzBvQ82+5ozusU08AkL9Lg
         hYQSsUa9WPWkVUY0Hx0H0pInv+iykHsdHkYdpyLRUg1UA1Tqqg5VGBAuwDsbSna5P7GU
         dWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793141837; x=1793746637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4Wb1nq3gFYdX6BA5R6X0Kbpi+TDs/uhIWeWQW5ffww=;
        b=WVeTgueM2RzfZH6UYWyXRuTGxhUvfwkEtcV1qrTA/C92rkBg0DVajfpwIbaB/w9GaV
         34I2artxHDhiJveqPTwVsW4+GVOr39sufsrQxdVRgkxLh4/jBh24b08nW2QA5w3iORcz
         F6BmplM+YvNm9Cf4DbwL4z3V8Bv3HRUtmp3U4gIIOaB1hzuBKJnAmaqgxsNhImTzbtmI
         EuKG0f3zqHE0HnB84UPQQQLgCDA2sWF5d+nwDOHubl0chgL2Ezfk38Ayy7bZZY9NkhTD
         vVrt+hMFn9iE3c4R2lf8nCV0gE2g8nJdYTn3XU5mudYiPCO4y8/i8WzbGurYdQHIzvR5
         pt2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxLlPtSGcj6UHlK7Wy7eTaEi3kKKzRAvGJioCqpi6/TbaIo7xLBrq88SWznAkM9obhu3rCpXpc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKokpz0M54mf+c6SLGmjzEykKHVPEBcFFd9vEdUt+red/iJiU8z
	ggfCYo2mNTwzSG6Pbkrf1ALe+UYK6iGaLpfMpN07wFF0JTF1Ww/NRi/T
X-Gm-Gg: AYBFou1DqyHAlBZpMH8OYX/uB5354K+MGUOC+WAWNlNjbRYu0Y6jUVae8T8viI60u9t
	nRmqVciLXya+LUyFgFBLJezMvvJS6x3fLK1/TPLMsqMV5IbwZwjiGxUSyPyrMfeQRaQbXUzFbOk
	azqY6iMLGXKcltBRRwor4p8PkdXQwm3ITuS33J/A3uRJ15EDqdDq6t8WY0r4EqFQ5uG7HwS2Cxw
	fkRKJvlG6ha3OcjU3KByqVQ0NhfCyxU6FDUM4QlXW4zUWpKEedUaSX0BvQPxWiAoUauQ0JAjfvS
	PU4PzDPmuVF3X+Cj40/PW4/hLVtc+qCHp1wI1toaRIgJmdDVKEJJYZny0UGeLp2DlvSXEfzPJs0
	H0zSKIpJZE6oW76zTlU+36W+kYXsok2Litoknso9hMoiHDZY8xKaJl78t7lWm9QgcAkrgTKfCJN
	iTtLOpFXx3sqZxqT/m0slAi1uy1vNHUfoaY+/MNZKyRyCdTvwJBxnf3mgGYzvnSk4ZKH5mb+cSr
	bgXXeGqUVLdEGC6ZpPkutJhJwmcoSsEx9SVdhduaaoqIkTXrTZyiiIi/rWv+UxOV1WINerI+reI
	bkSshavC2+TXA3nD3s/3AK+Wmi8TEpWroqLftBjSkwss
X-Received: by 2002:a17:902:fc87:b0:2e2:b7b8:abc5 with SMTP id d9443c01a7336-2eb0038e312mr6543085ad.32.1793141837445;
        Tue, 27 Oct 2026 15:57:17 -0700 (PDT)
Received: from localhost.localdomain (ip67.244-167-222.hkg.ten111.net. [222.167.244.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b76df7sm15602385ad.14.2026.10.27.15.57.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 15:57:17 -0700 (PDT)
From: Guoshuai Yang <yangguoshuai@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Guoshuai Yang <yangguoshuai@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4] xfrm: esp: reset outer TCP GSO metadata on espintcp input
Date: Wed, 28 Oct 2026 06:57:10 +0800
Message-ID: <20261027225710.51832-1-yangguoshuai@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ESP packets are received over TCP (RFC 8229 espintcp), strparser
slices individual length-prefixed ESP records from the outer TCP stream by
cloning the incoming TCP skb(s) in __strp_recv().

If the outer TCP skb was GRO-coalesced before reaching strparser, its
skb_shinfo carries the outer TCP stream's GSO metadata (gso_size, gso_segs,
and gso_type). When an ESP record spans two outer TCP segments, strparser
chains the spillover clone onto skb_shinfo(head)->frag_list.

Subsequently in esp_input() and esp6_input(), skb_cow_data() unshares the
head skb via pskb_expand_head() (preserving the outer TCP gso_size and
gso_type in the new private skb_shinfo) and calls skb_copy() on each cloned
frag_list member, which copies the outer TCP GSO fields via
skb_copy_header() onto a linear frag_list child skb allocated from slab
with head_frag == 0.

Furthermore, on kernels with TCP fraglist GRO support, if an outer TCP GRO
aggregate carrying SKB_GSO_FRAGLIST reaches the espintcp socket unsegmented
(for example, when rx-gro-list is enabled on a device in an outer netns
where tcp4/6_check_fraglist_gro() finds no local socket and the aggregate
is forwarded across a NETIF_F_GSO_FRAGLIST-capable veth device into the
netns hosting the espintcp socket) and is chained onto
skb_shinfo(head)->frag_list by __strp_recv(), skb_cow_data() invokes
skb_copy() / skb_copy_expand() on that frag_list member and hits
WARN_ON_ONCE(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST), failing with
-ENOMEM before decryption even begins. (On older stable trees without TCP
fraglist GRO, the pre-pass is a no-op.)

After ESP decryption and header removal, the resulting single inner packet
still has skb_is_gso(skb) == true with the stale outer TCP gso_size, while
skb_headlen(head_skb) is now smaller than that gso_size due to stripping
the outer framing and ESP header. When this packet passes through
gro_cells_receive() (which flushes frag_list packets via GRO_NORMAL
without resetting gso_size) and is forwarded, validate_xmit_skb() invokes
tcp_gso_segment() -> skb_segment(). Because head_skb is shorter than the
stale gso_size and SKB_GSO_DODGY is not set, skb_segment() attempts to map
the slab-backed frag_list member as a scatter-gather page fragment where
list_skb->head_frag == 0. On current mainline kernels, skb_segment()
triggers DEBUG_NET_WARN_ON_ONCE(1) and fails with -EINVAL, causing
validate_xmit_skb() to drop all multi-segment espintcp packets. On stable
kernels prior to the removal of BUG_ON(!list_skb->head_frag) in
skb_segment() (such as 6.12.94 where this trace was captured), it crashes
the kernel:

  Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
  PC is at skb_segment+0x574/0xd20
  LR is at skb_segment+0x884/0xd20
  Call trace:
   skb_segment from tcp_gso_segment
   tcp_gso_segment from inet_gso_segment
   inet_gso_segment from skb_mac_gso_segment
   skb_mac_gso_segment from __skb_gso_segment
   __skb_gso_segment from validate_xmit_skb
   validate_xmit_skb from __dev_queue_xmit
   __dev_queue_xmit from ip_finish_output2
   ip_finish_output2 from ip_output
   ip_output from ip_sublist_rcv_finish
   ip_sublist_rcv_finish from ip_sublist_rcv
   ip_list_rcv from __netif_receive_skb_list_core
   __netif_receive_skb_list_core from __netif_receive_skb_list
   __netif_receive_skb_list from gro_normal_list
   gro_normal_list from gro_cell_poll

Similarly, if a decrypted inner packet with a frag_list later takes the
ip_do_fragment() frag_list fast path, each detached frag_list member is
transmitted as a standalone IP fragment and would still carry the stale
outer TCP GSO state when reaching validate_xmit_skb(). And even when an
ESP record does not have a frag_list, leaving the stale outer TCP gso_size
on the decrypted inner skb prevents dev_gro_receive() from initializing
gso_size to the inner packet's skb_gro_len().

We cannot reset GSO state earlier in espintcp_rcv() / handle_esp() because
the skb may still be a clone sharing skb_shinfo with the outer TCP skb held
by strparser. Instead, in esp_input() and esp6_input():
1. Prior to skb_cow_data(), unshare/unclone and reset GSO metadata on any
   frag_list member carrying SKB_GSO_FRAGLIST (unsharing any shared
   predecessor frag_list members along the walk) so skb_copy() /
   skb_copy_expand() inside skb_cow_data() does not hit WARN_ON_ONCE() and
   drop the packet.
2. At skip_cow, where the head skb and all frag_list members are guaranteed
   to be uncloned with private skb_shinfo, call skb_gso_reset() on both the
   head skb and each skb_walk_frags() member.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Cc: stable@vger.kernel.org
Signed-off-by: Guoshuai Yang <yangguoshuai@gmail.com>
---
v4:
  - In esp_reset_espintcp_fraglist_gso(), unshare any shared frag_list
    member before checking SKB_GSO_FRAGLIST so *fragp = frag never writes
    through a shared predecessor's ->next pointer.
  - Clarify in the commit message that on current mainline kernels
    skb_segment() triggers DEBUG_NET_WARN_ON_ONCE(1) and returns -EINVAL
    (dropping the packet in validate_xmit_skb()), whereas the BUG_ON()
    oops trace was captured on 6.12.94 LTS.
  - Clarify the cross-netns veth forwarding topology required for TCP
    fraglist GRO (SKB_GSO_FRAGLIST) aggregates to reach esp_input()
    unsegmented.
  - Link to v3: https://lore.kernel.org/netdev/20261023065311.65031-1-yangguoshuai@gmail.com/
v3:
  - Unshare/unclone and reset GSO metadata on any frag_list member carrying
    SKB_GSO_FRAGLIST before skb_cow_data() so skb_copy() / skb_copy_expand()
    does not hit WARN_ON_ONCE(SKB_GSO_FRAGLIST) and return -ENOMEM.
  - Move the shared espintcp GSO reset helpers into include/net/esp.h.
  - Link to v2: https://lore.kernel.org/netdev/20261020030450.7170-1-yangguoshuai@gmail.com/
v2:
  - Also call skb_gso_reset() on each skb_walk_frags() member at skip_cow
    in esp_input() and esp6_input() so detached frag_list members on the
    ip_do_fragment() fast path do not retain stale outer TCP GSO state.
  - Specify target tree 'net' in subject prefix.
  - Link to v1: https://lore.kernel.org/netdev/20261018005218.53267-1-yangguoshuai@gmail.com/
 include/net/esp.h | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/esp4.c   |  9 +++++++++
 net/ipv6/esp6.c   |  9 +++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/net/esp.h b/include/net/esp.h
index 3229507..83c75ef 100644
--- a/include/net/esp.h
+++ b/include/net/esp.h
@@ -28,6 +28,57 @@ static inline void esp_output_fill_trailer(u8 *tail, int tfclen, int plen, __u8
 	tail[plen - 1] = proto;
 }
 
+static inline int esp_reset_espintcp_fraglist_gso(struct sk_buff *skb)
+{
+	struct sk_buff **fragp;
+	struct sk_buff *frag;
+
+	skb_walk_frags(skb, frag) {
+		if (skb_shinfo(frag)->gso_type & SKB_GSO_FRAGLIST)
+			break;
+	}
+	if (!frag)
+		return 0;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
+		return -ENOMEM;
+
+	for (fragp = &skb_shinfo(skb)->frag_list; (frag = *fragp);
+	     fragp = &frag->next) {
+		if (skb_shared(frag)) {
+			struct sk_buff *nfrag;
+
+			nfrag = skb_clone(frag, GFP_ATOMIC);
+			if (!nfrag)
+				return -ENOMEM;
+
+			nfrag->next = frag->next;
+			consume_skb(frag);
+			frag = nfrag;
+			*fragp = frag;
+		}
+
+		if (!(skb_shinfo(frag)->gso_type & SKB_GSO_FRAGLIST))
+			continue;
+
+		if (skb_unclone(frag, GFP_ATOMIC))
+			return -ENOMEM;
+
+		skb_gso_reset(frag);
+	}
+
+	return 0;
+}
+
+static inline void esp_reset_espintcp_gso(struct sk_buff *skb)
+{
+	struct sk_buff *iter;
+
+	skb_gso_reset(skb);
+	skb_walk_frags(skb, iter)
+		skb_gso_reset(iter);
+}
+
 struct esp_info {
 	struct	ip_esp_hdr *esph;
 	__be64	seqno;
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e76db58..92980cd 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -893,6 +893,12 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 		}
 	}
 
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+		err = esp_reset_espintcp_fraglist_gso(skb);
+		if (err)
+			goto out;
+	}
+
 	err = skb_cow_data(skb, 0, &trailer);
 	if (err < 0)
 		goto out;
@@ -900,6 +906,9 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 	nfrags = err;
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
+		esp_reset_espintcp_gso(skb);
+
 	err = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index b1c9b36..65470d3 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -936,6 +936,12 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 		}
 	}
 
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP) {
+		ret = esp_reset_espintcp_fraglist_gso(skb);
+		if (ret)
+			goto out;
+	}
+
 	nfrags = skb_cow_data(skb, 0, &trailer);
 	if (nfrags < 0) {
 		ret = -EINVAL;
@@ -943,6 +949,9 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 	}
 
 skip_cow:
+	if (x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
+		esp_reset_espintcp_gso(skb);
+
 	ret = -ENOMEM;
 	tmp = esp_alloc_tmp(aead, nfrags, seqhilen);
 	if (!tmp)
-- 
2.54.0 (Apple Git-157)

