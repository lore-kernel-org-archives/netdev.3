Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613825;
	b=trLyZJtTXJo+lDA7Chn70EWDeeOGinSPdcLsEOAAnv+msgYqTlVio+AQ5KjJJ517O0WY
	 7YmTof3tY5qY1IiVi09yloVZIGZQAKOnjGZmBwam9JsilvSjf/bWooc+XXlFU5jOQTFlu
	 8pk5FT+xTnm1hOVCVA26BSiBNAPDdLGSFDKYlkeb9/0ZkA9QXhLMe6nVk5Vq3a1G51h/x
	 ASYlFdAk8zTkW6qBr06ugoIH0rk8JNoPWj9+2Mh1jY36DPgvGBLuN7H625O4xfBkuxFbf
	 wtDMBKTG4XhxcFpIXPbbj/RZ5c+601/6PYq4YyeXj+Ql1AbdA+iI2kn6wIbdtXOIkgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4HL/6fjzrUsWBibeS1duDHduZd1C6ZMH5RyDDt56/lU=;
	b=rGnis31zjQKBn2CQeUidxciPmVRDAKCS9F8YEITlMt9B9EjCxLQbi05WPATXe8uR7hf4
	 xU84EknxagMsUVJij/JBHFLT7CzXa5vGA4TagjHJAaRlmrxvsJoKiUqyQXzmjaM0HA6Ar
	 YwAePG68kFkGd9Hd471pnBjrTAjHDXvFAnDNXjRA2kMHU+tQPUu0bxLJGI+v/JygBCq56
	 AJF8PZ5NedERNjSftaw8FHSGSMFxuYZnCjg46OwrJMjF17LmjEhQCZ+xjblDZSQXYQH17
	 OhgGrQ4t0h5sgSPogYpZgB8eHW4I7tLOiLBVfvJ6kr0HuyJLEXLgAJ+rKMhAQxivxvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=bHQU3Plx;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E635606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 23:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E635606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=bHQU3Plx
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8256106635eso650098a34.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794613824; x=1795218624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4HL/6fjzrUsWBibeS1duDHduZd1C6ZMH5RyDDt56/lU=;
        b=bHQU3Plx6fdlleLg+CaZMIjjgEv5lRh9lWi9ZMj8aC21xF5P+1KPcEilrAPKD+MLcY
         DXEbN005ILLqpc7oTLMgbyCT4i/3L/Mzm6dy76ATMv12sQE3kqSwbMc32wDfYgNkoKDg
         7feIYX6DyB0poHjiWrASzm8BnyZeMH36U15cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613824; x=1795218624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4HL/6fjzrUsWBibeS1duDHduZd1C6ZMH5RyDDt56/lU=;
        b=eDgKg4L7gTIQNrJL3ZGwR67Pl0TpkEUe7zoEtP13GfXr+5ClmvuPNMvKuaZIb+tD1n
         eMky1sfra3bUv7C4OEC++DXxL9I66zt0J+dD+/KdFdGwRZtzL/4cx7EzB3o516aHBBI5
         lWjogkNkkPbLt+5Q916wzKPBkygDlQIUvN8JscGhCwU7UDmh7bwm5+kid7A0E+yK6GH0
         IIpGmu9qsUOfAt1aNR/JNmdrxP4bmS00evCq0pKeLRnkrO+yLZ/UeTjvn/OnW9mziRgR
         zCaBccWneLpsa0J7eqhLU9Ad3ahSVuUSEfk0NsO809XBw7C4RqDKOoO2vt/GarPOQSHV
         nxdg==
X-Gm-Message-State: APuU4Z8+PeySIW94Xe2KuawI56cZLaZkJe7z3UIsroHr1qmI8SPVXJlS
	gJrif4f0NQm5a8i5tDUGYLo/i2zVoq8WIEzqsMtekt/8mB3TwJsFgnxutxSFysKFanZ0lNqG9MZ
	qy2m+G08=
X-Gm-Gg: AYBFou1m27O9iSGhTGGOySb/+h9mAXyBbewhTcrwO7l9AeFhjkrFLrDr94qhL+noujY
	SHclg1RTN7OjdrCFBnD+Nva9DaCtt5pEH8AjQH6E2RAf71M8KbVke5/tpL6Tm6ZYIIAwhfdT2b+
	RXEtyWi9YkNH6QabIwaEZtJdt5Qms6zJK8JL42IWFWcmfXH2FUWABkov/vNwEpXpELgRDAi0uMm
	c0YHFyHQ8NnxgmmGs46wsA1nnj6G5aTmam4TRGExwZa+HBEQZbvwk8c6Bn2TRFtf76jl5Wg4aP3
	SStgwhC8xrxoONU1PKtVCu0aIBlsiaMp8r/bJHLQgSMxiETHc9RE7bv1w4lUVA/chqxnI1p1tVO
	KzQjHR5wF52asAgvxaxlCEDrgcdnp3tl6jBTjuXLWekop8YVGLW8Gy4lIexSThTHBarYQhhaXrF
	z7k3NesHIjASvXKsGHeAfQkvBTODcDWK+3wGhnFruWEaSbxLdDyGHFsvLek2n21VWSsaXSS3mhg
	NMNHXmIEEdN4TsdS83Or5suE7EYIdnFnzaSlTOi0gsMCpHMGDjBonHJMmTPfz5mHIVsADxA4frr
	vq+zdlEAQQ05mcfEt6W/DEKqEoob7nhHeRdoO8GBWxDVvQ5CjXXlxNGWhoEcfHAT6QVtgJR+2m2
	s5QVOHKD848Ju91kiR61OOoWKaOgRpWoKBtHnlOlyw2/a1fG9I4A=
X-Received: by 2002:a05:6830:2b10:b0:861:5c3d:4a97 with SMTP id 46e09a7af769-8628989da76mr3407103a34.19.1794613824291;
        Fri, 13 Nov 2026 15:50:24 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628818de94sm3562068a34.23.2026.11.13.15.50.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:50:23 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: preserve skb header offsets during headroom changes
Date: Fri, 13 Nov 2026 15:50:19 -0800
Message-ID: <20261113235019.74384-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

An MPLS LWT route over a netkit device configured with large headroom
can make aligned skb expansion wrap the 16-bit network_header.
Neighbour output interprets the resulting negative skb_network_offset()
as a large unsigned pull length, causing eth_header() to write outside
the skb allocation.

Reject growth that cannot preserve the network, set MAC and transport,
recorded inner-network, or partial-checksum offsets. Do not relocate a
set MAC or transport header onto its unset value. Check the actual
post-pop positions in skb_mpls_pop(), bound the native MPLS label pop,
and reject excessive LWT headroom before reading the IP header.

The issue was found by an LLM.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v3:
- Check the actual post-pop MAC/network positions and reject the MAC
  unset value in skb_mpls_pop().
- Check a set outer MAC header and a recorded inner network header
  during positive relocation.
- Move the MPLS LWT entry check before reading the IP header.

v2: https://lore.kernel.org/netdev/20261110051258.64350-1-kylebot@openai.com/
v1: https://lore.kernel.org/netdev/20261030042246.74144-1-kylebot@openai.com/

I have a reproducer for this issue and can share via DM.

 net/core/skbuff.c        | 35 +++++++++++++++++++++++++++++++++++
 net/mpls/af_mpls.c       |  3 +++
 net/mpls/mpls_iptunnel.c |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1ac1e327ac4c..bc836adafecd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2130,6 +2130,28 @@ struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(skb_clone);
 
+static bool skb_header_offsets_fit(const struct sk_buff *skb,
+				   unsigned int nhead)
+{
+	if (!nhead)
+		return true;
+	if (nhead > U16_MAX - skb->network_header)
+		return false;
+	if (skb_transport_header_was_set(skb) &&
+	    nhead >= U16_MAX - skb->transport_header)
+		return false;
+	if (skb_mac_header_was_set(skb) &&
+	    nhead >= U16_MAX - skb->mac_header)
+		return false;
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    nhead > U16_MAX - skb->csum_start)
+		return false;
+	if (skb_inner_network_header_was_set(skb) &&
+	    nhead > U16_MAX - skb->inner_network_header)
+		return false;
+	return true;
+}
+
 void skb_headers_offset_update(struct sk_buff *skb, int off)
 {
 	/* Only adjust this if it actually is csum_start rather than csum */
@@ -2317,6 +2339,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		return -EINVAL;
 	}
 
+	if (unlikely(!skb_header_offsets_fit(skb, nhead)))
+		return -EINVAL;
+
 	if (unlikely(skb_shared(skb))) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		return -EINVAL;
@@ -2535,6 +2560,11 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
 		return NULL;
 
 	oldheadroom = skb_headroom(skb);
+	if (unlikely(newheadroom > oldheadroom &&
+		     !skb_header_offsets_fit(skb, (unsigned int)newheadroom -
+						  oldheadroom)))
+		return NULL;
+
 	n = __alloc_skb(newheadroom + skb->len + newtailroom,
 			gfp_mask, skb_alloc_rx_flag(skb),
 			NUMA_NO_NODE);
@@ -6804,11 +6834,16 @@ EXPORT_SYMBOL_GPL(skb_mpls_push);
 int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 		 bool ethernet)
 {
+	unsigned int headroom = skb_headroom(skb);
 	int err;
 
 	if (unlikely(!eth_p_mpls(skb->protocol)))
 		return 0;
 
+	if (unlikely(headroom >= U16_MAX - MPLS_HLEN ||
+		     (unsigned int)mac_len > U16_MAX - MPLS_HLEN - headroom))
+		return -EINVAL;
+
 	err = skb_ensure_writable(skb, mac_len + MPLS_HLEN);
 	if (unlikely(err))
 		return err;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ad4ad6f2001a..18c9654a6b36 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -419,6 +419,9 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	if (!nh)
 		goto err;
 
+	if (unlikely(skb_headroom(skb) > U16_MAX - sizeof(*hdr)))
+		goto err;
+
 	/* Pop the label */
 	skb_pull(skb, sizeof(*hdr));
 	skb_reset_network_header(skb);
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 1a1a0eb5b787..5123394234cc 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -59,6 +59,9 @@ static int mpls_xmit(struct sk_buff *skb)
 	    !dst->lwtstate || skb_warn_if_lro(skb))
 		goto drop;
 
+	if (unlikely(skb_headroom(skb) > U16_MAX))
+		goto drop;
+
 	skb_forward_csum(skb);
 
 	tun_encap_info = mpls_lwtunnel_encap(dst->lwtstate);

base-commit: 2800868f63227c8237d70c41e70d441c919620d6
-- 
2.55.0.openai.911.g06873a30d2f3

