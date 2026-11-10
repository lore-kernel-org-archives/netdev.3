Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794287582;
	b=U9Hbb8Lvg7T6Rgyq0y8FABmPVzfy3Q1ib763TTYifbOSAdeX3UuXxfc7Op/F6nGnPZdu
	 c19G1J5uQsemq5mmqgB0gVnDn7rGWkOQqWAsGk3G+prvz4tFA1HF5vMxljZPwe4cI++mX
	 pbXhmOctRpkf/DYqkhn/lhM/X1gl5V39Q4eCOX6yYmM6xQU6lYxaSh6EmDpDJezBHZ8BK
	 upoXWMV6evRVZFuoKrF9sKmB1eX7aZKItYdd/MP+mV3vcEI3zVUOjch8Yza/EDbg8Zmqb
	 VCmsvvSXT3HjOQGl1Fy4GiEylIXv6MfuYGx9dHQRYMDJVDV/4r13WrpRXIT709KWZ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CQzpgVc/oheunZLPAVoKj6i/IlJ4YnhoDZwgYdq5g1I=;
	b=LE0dH/KVXCMsYNGb0saUgqSL233ASjm60KZWNx0eSnPN0/gUXm8N1v/Ttlcbn6BTrXkO
	 LmrWMkMfr6TNmsrLRMvnaSb6W/Fsg5626MQE5hRk1IMNY9u4yxglu15hoPLDKvPHy5z7e
	 APkumLzUbQ9j+3Na5OVIXFrwr23qJor0Elwwb5MEBfGRmAxVlbxbbVcSqKYEOIfOgKpqb
	 wBOlnVfhDzmMHqmi279Zi4cgqaToV6XnzfxBtc3OW7ZljMWlyQmm4Nikrm3uyqa5RaGmz
	 7+Zu+dwK6MiuX+GKCgm1/iUxkClkHGVfnTMmpTkumiNMOMPrpfgCfytwT1cvTi1jDOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=BBM2jElv;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E311606A321
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 05:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E311606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=BBM2jElv
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-483c607ccb4so854098fac.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 21:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794287580; x=1794892380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CQzpgVc/oheunZLPAVoKj6i/IlJ4YnhoDZwgYdq5g1I=;
        b=BBM2jElvIB24gifQzUXiFY9ZSwjwEJzhwWpSMU9m4Vge7y2NrVDjW4RhQXFef3ZcTi
         E36Vzh2x/OoBVkyyyydONvq8xyo3mBRP7bt8ocAjMDt7qFvDoCvpsQwaEE/RcSuNWnyC
         6JtA21bNkGcMLPux11uEzKXLdi04qP8GETQSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794287580; x=1794892380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQzpgVc/oheunZLPAVoKj6i/IlJ4YnhoDZwgYdq5g1I=;
        b=VHajLNNf4HKNUQejUZ8rh87YpFdtuSP8s6m8N3b2Kmpz8k+YDHqPeRYhKWURPzExc4
         8IqxJPVMajAmKNn30E5x2mC7CL89ekkwnvnhuFsmoq1ABcEAcD3CcLx35fRn+UYxRRpG
         tk1/xPmoHIC/2pv4lrI8bx1N+AvNq8W+oPbS7LO4sFlGeCjeb5sNXTBDD/+YUBG7Z4BI
         YlbuYfKGXNg0D8eDoxTGZiXzjfK9MYUl0VVoiH1uFJ7pv1C3+i9GLorHi7+nTxcxA28n
         aweY6feEQOIPxnys//jXIlz5fZVrhQUlsOPHbaI5amh5NH5CPoIzmNCNhtQm9OIshgki
         USLw==
X-Gm-Message-State: APuU4Z8yp/lxA/2nglr0hXzhvqiS0k7N1+HWp2coyV029hI4S2Nm7PeF
	I7RvfL10GMjKvGDS3+VBW+VTJsIj8GjRpLMjyxuszsQgr63UMxYQScOJHifuV0oC6gYn2aUo+q4
	eQUO8b6w=
X-Gm-Gg: AYBFou1cL8Y+36t2Mp5HYUgVc2Qj5XyhrZeYhEQNcsXRZP8xJswGpCLXwCw54yTJbjT
	XRIein64hmx3DRZNimjSIeNFVoUsg1KfI9HZTkOIsBSAik6qNuW94UCqKYziKQOrVrZu0EkzD1L
	lp5bKphLTPr2qTeE+1pRhuMt26/Xv7jT8vo6lu5ScB6jjyBwZN783AuY7Qej+9vRRurJZfThlzT
	HF9uTYydUTDbuWlD7M6OITEI97Qhod7G20qlWN1KTM69eaS/7CEgT0Wf+mmmOIdx6Ng0CtdkD0R
	xcnJGrgUO+HwuTeJ+U1Lol3PBQOlg1bw6pBG5Po5OrZJWNjRG7ZYSF2+F45pHzr7UfyCxofafdc
	fUifkn6G1dog+FbqTlvi9HFS65p+OAMzYjuUQSi7NKY2QcUZcGo8t9znhZMC2f3k6os3p7ZJrFq
	21K8JUgBbQp/C5QSusBl133O37YI4ZXV+AtH9d/sVG2XqY9bS3kWcxLbprgtIAjwb5NYsHN0CrO
	vU6S34Q+dKS3CeLYkPzhu6vRbiPO0nzIQU1v6XikmWmCowMLn2SsySLgeUm95GCze8gzf9jPkUO
	YBOp6JOqU3NC0y1ABnqgLf5SGFXM6rxFgRoezkeE0ULgJRo+txvnM2Qpd0BH3F3Qrv8Nxsb9H1R
	hBBknZVoftLcMVXVnXQ8Upe3BLoAEHg==
X-Received: by 2002:a05:6870:701f:b0:4a2:4e0c:593d with SMTP id 586e51a60fabf-4ae2274babcmr813526fac.31.1794287580407;
        Mon, 09 Nov 2026 21:13:00 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae2308e3ccsm881504fac.15.2026.11.09.21.12.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 21:13:00 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: preserve skb header offsets during headroom changes
Date: Mon,  9 Nov 2026 21:12:58 -0800
Message-ID: <20261110051258.64350-1-kylebot@openai.com>
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

Large device headroom can make aligned skb expansion wrap the u16
network, transport or checksum-start offsets. An MPLS LWT/netkit
reproducer reaches an out-of-bounds Ethernet-header write when
neighbour output converts the wrapped network offset into an unsigned
pull length. Bounding skb->data alone misses the later offsets.

Reject unsafe growth in pskb_expand_head() and skb_copy_expand() before
the offsets change, preserving the transport-header sentinel. Also
bound native MPLS's initial label pop, LWT's inner-header reset, and
the TC/Open vSwitch MPLS-pop helper, which can wrap without expanding
the allocation.

The issue was found by an LLM.

Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
Changes in v2:
- Validate native MPLS headroom before the first label pop/reset.
- Check the actual shared expansion before network, live transport or
  partial-checksum offsets can wrap; retain unset-header semantics.
- Cover TC/Open vSwitch MPLS pop as well.

v1: https://lists.openwall.net/netdev/2026/10/30/51
Review: https://lkml.rescloud.iu.edu/hypermail/linux/kernel/2611.0/05339.html

I have a reproducer for this issue and can share via DM

 net/core/skbuff.c        | 27 +++++++++++++++++++++++++++
 net/mpls/af_mpls.c       |  3 +++
 net/mpls/mpls_iptunnel.c |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8da53d5b76fc..6e0205f923f3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2118,6 +2118,22 @@ struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
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
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    nhead > U16_MAX - skb->csum_start)
+		return false;
+	return true;
+}
+
 void skb_headers_offset_update(struct sk_buff *skb, int off)
 {
 	/* Only adjust this if it actually is csum_start rather than csum */
@@ -2305,6 +2321,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		return -EINVAL;
 	}
 
+	if (unlikely(!skb_header_offsets_fit(skb, nhead)))
+		return -EINVAL;
+
 	if (unlikely(skb_shared(skb))) {
 		DEBUG_NET_WARN_ON_ONCE(1);
 		return -EINVAL;
@@ -2523,6 +2542,11 @@ struct sk_buff *skb_copy_expand(const struct sk_buff *skb,
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
@@ -6771,6 +6795,9 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 	if (unlikely(!eth_p_mpls(skb->protocol)))
 		return 0;
 
+	if (unlikely(skb->network_header > U16_MAX - MPLS_HLEN))
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
index 1a1a0eb5b787..4eccbd911fe1 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -109,6 +109,10 @@ static int mpls_xmit(struct sk_buff *skb)
 	if (skb_cow_head(skb, hh_len + new_header_size))
 		goto drop;
 
+	/* The aligned expansion must still fit the u16 header offsets. */
+	if (unlikely(skb_headroom(skb) > U16_MAX))
+		goto drop;
+
 	skb_set_inner_protocol(skb, skb->protocol);
 	skb_reset_inner_network_header(skb);
 

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.55.0.openai.911.g06873a30d2f3

