Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814934;
	b=1r2qQ94jev7sq0Y265VkWi9d0iINKTYoBXg1p2yEm/38Vx/EJiVJkEIfsbsZdr7cUnlQ
	 tnCcBdMouNuWo02sRPdhGMsGdx+G1dzxmf5Bm6tLFX4WY7CTTWZElmbBQ7RYNmLSfYHPg
	 CUyRKYe5tIS3VMmMI9L1WpwRoi+7I2RsEjV2cGX6J1pJPPcFr7rbo9KzYQFZdHq5j84TD
	 pybP3AeOBNWgYHFoXwSNuwn3U6BJuAq6o1YFluWyIGPZT04VAns+xjOUYTY0E0AjIKrKp
	 oGa456KKW/Sa21cIzllcchlirCgDnrsagY2/zC/1TdAUk6pVGo7bJb55CtrnRF4//xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=004Mwgs4oRIrBA3c5/AHI4mXqprCX8WwDJXcGVBXHgo=;
	b=SR6S5KQA6DVOMPIKNmjkGEnDnb0Cq5zRW2KOlj2KGI7WC/xABAqam6CBei08hTgyX0nj
	 e81JIviyEP5zf1p3pHjHqFf+3TX/53HLG0ngvkjZ2a4ZiDkjL6uD2+UUkqvU7WSpQZRyR
	 Ug16kjtrFwc9vmsYpvxELQCLsR3C4Sui3oLBcFfVR5Cc8OlEhyebGw3uUkNQUrki+dEoN
	 QEyw8MgaFY1cF/KuqBXKGe43w061Rgzqe/6zBc9zklGE832raGX3/4l8lm++U3rWCMuan
	 sLjpBAHvlXX+CxlZ6pGksc3lcg6TqY/7P0yw4y0lCCxeNO0viNd+gETCfuzMWA03NUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tqP0RRMd;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3FA6078C19
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F3FA6078C19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tqP0RRMd
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36d6765756fso833615eec.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793814933; x=1794419733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=004Mwgs4oRIrBA3c5/AHI4mXqprCX8WwDJXcGVBXHgo=;
        b=tqP0RRMdDlfdtRKqZxHJxBPzn1FobVQ6akaPUUpGb1iZHN5C1dPVtAaYavjOHyItyI
         RXeULz0aSFCzGPgQLbGnnb53odCnBvtrJfKffRu6phF9ZcACkbl/feqCCm4DcV09jHn9
         zY75Lc91624GzOW8V6ZWGNNnyjZWhXuakMM2pIrRzcpECOACCGnd0DcSEdI1c27UXVEn
         qQrJ+QROewjWnVEviglaoJVAep8l21pm4qdUwFm/6sIplTwnNZQXw7gdaNhKSg9rqjUc
         knn70EIXLeLdswWLU7NqJ3ZMTlOLTsEe55KMnRJu3+kcpy7981fZecfApBP6giJhypc5
         jfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793814933; x=1794419733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=004Mwgs4oRIrBA3c5/AHI4mXqprCX8WwDJXcGVBXHgo=;
        b=ZI6wLRU93gnaIP09ZF0P5Upc5+VFAPODYDivxrOd/AjF1LzRCTZC66t+gRjKQ3YzdJ
         i7VToBCHBneAV5yMitO6xd7+s9RHMON8WK2LS/tPwP6GZchx7aKrjnBZqQBh39Fg7sWr
         R24TFWZo5/J/4r3gwQ6BPBQB5PY47sev2r4q1ve+HrzxESGWTbPsXuziYSk8i5R0z7x7
         /zKsJ2dt0432aKBX17efKnnlqPrjOf6Jw54rKj2R/fxd6yV5+w0Rbx7s6YF2eGy+iESm
         CDiR/0y8YzTd6XWno1puWMTXw6DnSrJOV5LTFBtPnCvEjTXozrxbaalReIkqhqfBE3AF
         EBsw==
X-Gm-Message-State: APuU4Z+X2ojTodqNalHJpSPk18YENoGK0jYrXTzEqDwYPgPfCXDFn8PU
	lM1kqYKmWyNMzzOvvBDOsl3TLS8V4dppujCB4/ciBLlRgaCvl2IZ2u7Uwii3TZFo
X-Gm-Gg: AYBFou085ERTjLiXhmJ7sS9FveaRh1NPn8+9wslVFQT/5tTAI1IbkPArKbtpbe2SdIt
	ZGRq/RItCnGwGLartFD5yUyjc8bG1rusxS2lrOF3tEs2OGZ+PL8K+aPitgAmTXOlCaGJUcHXW+Q
	8dWkk7K1ySf6jNYT7FPNr8MupqksM4RHE+SEaRPoxz3ls1dyfbAiTQwk6I9MWlla7Z0HWywYeNN
	uWCdSpPl/Pgv9UuJignhCQA/+o2NlaRfL7AFy+To//T2dfV19HaptoFy0kAFXa8gNXGykguBRdn
	Cl5wilr6zQSQfoKUvtH31ePi2gNrQ8n4VG52Qi7TtX3XMjpi/6pMW9AUti10Yiv0i9b2l17D+/p
	GfjY5t18QmZuyg+hZATwYfd45vQtj1TK2N3+LmuIuZ1wsAF3WdlXCwhUoTaMrxVYlPdLbEDrE9X
	bNkuHT8iS+Cv+srpl0x6/98Pj2oBI3qW5IJ6OzvjAGFuCFnbbslMx38L8PWSiZQarp9MwKQUU8K
	R1CSwDK8WFlpA49Uw9P7FApoS6S6QLcVosMu4b4C0GIalrLaR0iO23lAb5MhJSH/k/Ps8v8OyXR
	RjeCLprHEoJdfRh25ONaa198glfdSlNUGb1UGHyfLdBQL4Ub3Pg=
X-Received: by 2002:a05:693c:41d5:20b0:368:d0b6:b231 with SMTP id 5a478bee46e88-36a4239256emr23995781eec.10.1793814933199;
        Wed, 04 Nov 2026 09:55:33 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm12064024eec.25.2026.11.04.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:55:30 -0800 (PST)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net] net: reset transport_header for ndo_features_check
Date: Wed,  4 Nov 2026 12:55:17 -0500
Message-ID: <20261104175517.2395704-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
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

ndo_features_check() can see a transport_header that does not point at
the L4 header, while ndo_start_xmit() for the same skb sees the right
one.

Commit 663ead3bb8d5 ("[NET]: Use csum_start offset instead of
skb_transport_header") made csum_start authoritative because receive
processing overwrites transport_header, and resets it from csum_start
"just before we push a packet with partial checksums off into the device
driver". That reset, which now sets inner_transport_header instead for
encapsulated skbs, sits in validate_xmit_skb(), on the non-GSO path
only, after netif_skb_features() has called ndo_features_check().

So the hook sees a wrong transport_header for a CHECKSUM_PARTIAL skb
(after GRO, or from a container or VM) when no stacked device (VLAN,
bond, tunnel) ran validate_xmit_skb() first and something earlier
pointed the header elsewhere:

* IPv6 forwarding with a destination options or routing header:
  ip6_rcv_core() sets it just past the fixed header, and only hop-by-hop
  options are stepped over before forwarding.
* br_nf_pre_routing_ipv6() does the same for bridged IPv6.
* seg6 inline, rpl and ioam6 point it at the header they insert.

A hook that bounds header lengths with transport_header can then leave
offloads enabled that the hardware cannot handle. For example,
i40e_features_check() limits IPLEN using skb_network_header_len(),
which returns 40, while i40e_tx_enable_csum() writes the real length
into the 7-bit IPLEN field, so more than 468 bytes of extension headers
overflow into L4_FC_LEN. Rather than make every driver measure from
csum_start, give the hook the headers the transmit path gets.

Move the reset above netif_skb_features(). Skbs that skip
skb_gso_segment() reach ndo_start_xmit() with the same values as
before, since VLAN insertion, the TLS device fallback (whose tcp_hdr()
now sees the reset header) and linearization keep csum_start and the
header offsets in step. Software segmentation parses the headers
itself, except for SCTP over UDP, where inner_transport_header already
equals csum_start. Encapsulated SKB_GSO_DODGY skbs that the device
segments now reach the driver with inner_transport_header at csum_start,
which TCP or UDP checked, rather than a value bpf_skb_adjust_room() or
bpf_lwt_push_ip_encap() may have copied from a stale transport_header.

Fixes: 5f35227ea34b ("net: Generalize ndo_gso_check to ndo_features_check")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
If this is considered too expensive, I'll make a documentation patch
instead and the drivers can fix the holes as they please. Either way,
the core-driver contract needs improvement.

Drivers exposed, by reading the code (none tested on hardware):

Every stale source above involves IPv6 extension headers. Since commit
5f0764cb1c81 ("net: extend IPv6 exthdr detection of tunneled packets"),
the core keeps IPV6_CSUM, TSO6 and GSO_UDP_L4 off such skbs by reading
nexthdr, so on net only HW_CSUM devices are exposed:

- i40e: as described above.
- ice in GCS mode (E830): the same IPLEN check, and ice_tx_csum() also
  writes the real length unmasked into the 7-bit IPLEN field. GCS mode
  has no TSO.
- gve DQO: gve_can_send_tso() counts buffers per segment from
  skb_tcp_all_headers(), which has to match the header length that
  gve_prep_tso() programs from the reset header. Device effect unknown.
- hns3 with HW Tx checksum: removes offloads when the transport offset
  plus 60 exceeds its 480-byte header limit, which a stale offset can
  hide. Device effect unknown.

Outside drivers, the TLS device fallback reads tcp_hdr()->seq between
the two points, for TLS offload traffic over an SRv6 inline, rpl or
ioam6 route that falls back to software.

Not exposed: drivers that measure from csum_start (igb, igc, ixgbe,
fbnic and others), and on net the IPV6_CSUM drivers (r8169, stmmac,
iavf and others).

For stable: i40e is HW_CSUM since v5.19, hns3's HW Tx checksum since
v5.11, gve's check since v6.8 and ice GCS since v6.15. 6.1.y (as of
6.1.191) has commit 864e3396976e ("net: gso: Forbid IPv6 TSO with
extensions on devices with only IPV6_CSUM") but not 5f0764cb1c81, and
that guard reads transport_header. A stale header lets a TSO6 skb with
extension headers past it, and validate_xmit_skb() then WARNs and drops
the skb on any IPV6_CSUM device with TSO6. This patch fixes that as
well, though a backport of 5f0764cb1c81 is the targeted fix.

In QEMU, a kprobe on ndo_features_check() found transport_header
differing from csum_start in 18425 of 18427 skbs of a routed IPv6 TCP
flow with destination options, and in all 23300 of a TCP flow over an
SRv6 inline route. With this patch, it found none.

This surfaced while working on a new ndo_features_check()
implementation [1].

[1] https://lore.kernel.org/all/20261028170239.28606-1-tactii@gmail.com/
---
 net/core/dev.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index df1a840b03343..155be1f51494c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4207,6 +4207,15 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 	if (unlikely(!skb))
 		goto out_null;
 
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (skb->encapsulation)
+			skb_set_inner_transport_header(skb,
+						       skb_checksum_start_offset(skb));
+		else
+			skb_set_transport_header(skb,
+						 skb_checksum_start_offset(skb));
+	}
+
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
 	if (unlikely(!skb))
@@ -4239,16 +4248,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 		 * support checksumming for this protocol, complete
 		 * checksumming here.
 		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			if (skb->encapsulation)
-				skb_set_inner_transport_header(skb,
-							       skb_checksum_start_offset(skb));
-			else
-				skb_set_transport_header(skb,
-							 skb_checksum_start_offset(skb));
-			if (skb_csum_hwoffload_help(skb, features))
-				goto out_kfree_skb;
-		}
+		if (skb->ip_summed == CHECKSUM_PARTIAL &&
+		    skb_csum_hwoffload_help(skb, features))
+			goto out_kfree_skb;
 	}
 
 	skb = validate_xmit_xfrm(skb, features, again);

base-commit: 03897066069fd47caf2908183edf3b22b822ea73
-- 
2.43.0

