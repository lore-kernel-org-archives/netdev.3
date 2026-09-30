Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D584CA768
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766965; cv=none; b=K1cksj1bxicQB3sdTjsnvi0CetU1BtKHZzMd5I6/kfHZy5OcGg4ur7jyL+UynpOn0bcrShS6rFKZ3MlHd34BnQKsQ2oYbloOctgJTlLa6lZHs93SP5ETymFte8rQy66jusJH9yzRHD6A+2K2xeimc387S2M1M7apsXJaWWSdGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766965; c=relaxed/simple;
	bh=6P+7pSQdRX3AhXHRaY6FPWs6r3cq3BmdrDNSNBjuOiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmFPBxSMF/tSIy6g/OVslvrD/r3zXbbkCjnJybV1dNMPAGuwevq34QUOast4FbCSDbJ5pZPMWHTslYTJ1jhw0fXMbu465t8pTPQFaAe8Sko2wyPYx8rPm2R3VWCMhImKMiUN+Pt35WAK3EYYn/grfkdvsmDIIRnmDm4eZpK1X5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=IcKjvT0w; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="IcKjvT0w"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso7981488eec.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790766963; x=1791371763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HTAxMwfjTkhOsHLjEDb991ICsbjMLHPNzu5I3ZaW23s=;
        b=IcKjvT0wYV6jWTQXMPHgD0bHJpkJXXvuVwbTTdKY1ywNxfV5Nx+tOex4szh2a3/YbK
         tsm8uqA7q77U5DjS6LBFrywlohTXFRQXJskSjhlp4n7FW984haadxBF6Lmd9SYpvhpBZ
         dSIBA8LjH1QvnPRJH1QhfAHaRUGF0xn7v+RvZLWgaXbp1HegiOCubmBtd+bVRKoihPrL
         mIrEyVE8HFVisnfjPw04EdcMxD5hqowfbLIUmRgRtX41ebar0B5k/SzM8kEKWKxF73XW
         mzXFsKmlsZ+G4UTD7txgJsSQMw6VjMImkfc9yXb1nyF5WBjTozkzhMtw/o1MkJCks8zD
         FIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766963; x=1791371763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HTAxMwfjTkhOsHLjEDb991ICsbjMLHPNzu5I3ZaW23s=;
        b=FPFqaUSrVZTJEXAbZmgtSCgHUyQfM6fj/0mSbC7JaSf83+RYCPtv1uT2SA8+mzNgGc
         9DOQp+VJpvC7zu7543EKsTdl1kP+YWfYK0BKxabnNly32de8+0mO2qxwIY5uU2MKnRMY
         IgLbQP0Qnf8ZUHvpbFeUSWsXbxdKd6gdO2MFFe4SSJaLhKPzEwCKBIjmdLONT7F2O1KM
         iLY/3fYMyP+Q8CUJcY+H6GwhyT0wvHT2jflNJI7hNV/HqZpogqBAcIqTY57ONV2sk0Ae
         UuRDl81qEAx7cbbu1+Mn9zYZmoQztuVrJ46kjxovZpW6yUAOAJBEjLpvpyb/GXXtm0jb
         tfeg==
X-Gm-Message-State: AFq9FYLHI+HLryIUnX1TCj0LcYrC9hqRlowYPdlzq450DnM6+I4Uv6X6
	cEve6aJyUVD5rpfWkG4SScIY1afJE8a4XcUGn+3a3+Q2TujKQYn0Gu4jmm6DQmOF+cs6asJs7uE
	lZ4kKHLTw0NUOA2sr8x7j7bvArLwJLXscbD1bLwe/DupQO79xJvk0HsHyUaUjlECqw0Z2kg+x
X-Gm-Gg: AYBFou1GZt/y12sxWATJwohV43H8Ihgc+NU7m0nWi8Lbe+rpiHRPgmREzBvlVrvNQXg
	uKKpqAR6+ouvrCrDsIgUP1diaW8WudaaTIv3g1+li/NnHZLDhAt/CgCodKOzLNBDyMkgNUEINWd
	6N4sSt/odQRlDfiws5HmtdsSocUxRyinFkrmtQZsB/t9r/uR9YkhOptAcWrMsFJkVYclnAVZz6I
	SCqAQRYEKJj5M786vRQEqbi8C5dUwqcd9jxnHNtYmFNUhjV4efDboqgf7ChUHfvFk4FPo0Nm0Lz
	1HF/epLS4IrLzVX6LEgCwPMlE42RkgKx+j4rfeTXiX/q/ZeK/jGR782tOaPC6o2+Uy2tR8nehoY
	8ImVJwNlgEw9yf6UZifZKczthmoUSRvW0DgbFMmM96ejb8FJcDhxQi9oEUFf52HnF5XtYKHPbrM
	eI6pV7K+zTe9BRhy4Hcg8OeQmNVkBEnZgN2xHl4C1V/jNsJBarLz3O8x8zWNsw/S9bzS024HtCN
	zRPDNpY4U3u
X-Received: by 2002:a05:7301:8605:b0:33b:f206:845 with SMTP id 5a478bee46e88-34cdd2a0e8bmr1324911eec.32.1790766962577;
        Wed, 30 Sep 2026 04:16:02 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5a2c6f9sm3520320eec.21.2026.09.30.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:16:01 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v4 4/5] net: core: re-segment oversized TCP GSO skbs
Date: Wed, 30 Sep 2026 19:15:25 +0800
Message-ID: <20260930111526.2183107-5-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930111526.2183107-1-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A GSO skb which exceeds an egress device limit loses its GSO feature mask
and is segmented into individual packets.  This is unnecessarily expensive
when the device can still offload smaller TCP GSO skbs, which is easy to
hit once one hop of a BIG TCP path raises gso_max_size and the next one
does not.

For an unencapsulated TCP GSO skb which exceeds gso_max_size or
gso_max_segs, work out how many MSS segments each output skb may carry and
re-segment the skb with that max_segs instead.  The bound is measured from
the transport header, so an skb whose transport header is unset or stale
keeps today's segmentation.

An encapsulated or frag-list skb, a GSO type the device cannot offload and
a max_segs which leaves room for a single MSS all keep today's segmentation
as well.  The GSO type test runs on the features without the limit checks,
because gso_features_check() has already cleared the GSO bits of an skb
which exceeds them.

This path emits a plain GSO skb, not a BIG TCP one: inet_gso_segment() and
ipv6_gso_segment() write the whole length of each output into the 16-bit L3
length field.  An egress limit above 64 KiB would give outputs whose length
truncates, so the size limit is also capped at what that field can express.

The helper runs on the skb which is handed to the driver, after
validate_xmit_vlan() and sk_validate_xmit_skb(), and only from the
netif_needs_gso() branch: an skb which the device takes as it is pays
nothing.  A skb which reaches that branch pays one device limit test, and
an over-limit one pays the TCP header read and the features recomputation
for max_segs, in exchange for keeping the output a GSO skb.

Measured on a veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP
enabled on the veth endpoints and left off in the guest, so the skbs which
the veth hop accepts have to be segmented before the TAP device.  A single
iperf3 TCP flow, six alternating runs per state (`-t 15 -O 5`, fixed CPU
affinity and port tuple).  The middle column is the same tree with the
re-segmentation disabled:

  protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
  TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
  TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps

Coefficient of variation for the two mixed columns was 0.48% and 0.82% for
IPv4 and 0.44% and 0.44% for IPv6.  A BIG TCP hop which feeds a 64 KiB hop
loses 69% of the throughput of a path which never enables BIG TCP at all;
re-segmentation recovers it, 3.3x over the existing segmentation path and
within noise of the no BIG TCP baseline.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4:
- drop the comment above the frag_list check
- drop the mac header test, it is always set on this path
- take the TCP header from the checksum start the GSO engine uses
- test the transport header first, skb_transport_header() warns when unset
- shorten the comment above the features lookup
v3: https://lore.kernel.org/20260928044102.1004310-5-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/
---
 net/core/dev.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a6213c9ed5e721..ff9bce2506f670 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3977,6 +3977,53 @@ __netif_skb_features(struct sk_buff *skb, bool check_gso_limits)
 }
 EXPORT_SYMBOL(__netif_skb_features);
 
+static unsigned int
+skb_gso_output_max_segs(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned int mss = skb_shinfo(skb)->gso_size;
+	unsigned int gso_max_size, hdr_len, max_segs;
+	netdev_features_t features;
+	struct tcphdr _tcph, *th;
+
+	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
+	    skb->encapsulation || skb_has_frag_list(skb))
+		return 0;
+
+	/*
+	 * The transport offset can be unset or stale, so hdr_len is only taken
+	 * from a header at the checksum start.
+	 */
+	if (!skb_transport_header_was_set(skb) ||
+	    skb_checksum_start(skb) != skb_transport_header(skb))
+		return 0;
+
+	th = skb_header_pointer(skb, skb_transport_offset(skb), sizeof(_tcph),
+				&_tcph);
+	if (!th || __tcp_hdrlen(th) < sizeof(*th))
+		return 0;
+
+	hdr_len = skb_transport_header(skb) - skb_mac_header(skb) +
+		  __tcp_hdrlen(th);
+
+	/* The output is still a GSO skb: recheck without the limit checks */
+	features = __netif_skb_features(skb, false) | NETIF_F_GSO_ROBUST;
+	if (!net_gso_ok(features, skb_shinfo(skb)->gso_type))
+		return 0;
+
+	gso_max_size = netif_get_gso_max_size(dev, skb);
+	gso_max_size = min(gso_max_size, GSO_LEGACY_MAX_SIZE);
+
+	/*
+	 * gso_within_dev_limits() accepts gso_segs == gso_max_segs but
+	 * rejects skb->len >= gso_max_size, so only the size limit needs the
+	 * - 1; the inner min() keeps that subtraction from wrapping.
+	 */
+	max_segs = (gso_max_size - min(gso_max_size, hdr_len + 1)) / mss;
+	max_segs = min(max_segs, READ_ONCE(dev->gso_max_segs));
+
+	return max_segs;
+}
+
 static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 		    struct netdev_queue *txq, bool more)
 {
@@ -4141,9 +4188,13 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 		goto out_null;
 
 	if (netif_needs_gso(skb, features)) {
+		unsigned int max_segs = 0;
 		struct sk_buff *segs;
 
-		segs = skb_gso_segment(skb, features);
+		if (unlikely(!gso_within_dev_limits(skb, dev)))
+			max_segs = skb_gso_output_max_segs(skb, dev);
+
+		segs = __skb_gso_segment(skb, features, true, max_segs);
 		if (IS_ERR(segs)) {
 			goto out_kfree_skb;
 		} else if (segs) {
-- 
2.47.3

