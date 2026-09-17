Received: from mail-pz2-f20.google.com (mail-pz2-f20.google.com [74.125.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C84349B6
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627181; cv=none; b=QjdD+IfSzxXlyCTls4eMJHO1j3MPO5P8hWLrp8YGtevw506rWv9xR3HNl69iY7WptOCvdOOenegBDEjw3djl/AahakCpaAKGq69Y7mdK5hoobJRG12eLQgOrNU4dhnvQ41kxPF1AzjFzWs1S5ptiULvluI+lUgLP+iVmhPX1SUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627181; c=relaxed/simple;
	bh=PQ6RkUEtXfXG8UoYIqIc5mL6LIR05A5Lq5MUiyTS7uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI/QQIZhTHP6+GccORbQQZ+XVsEKTnMRtubJrZZ0CbRu6ctiZb9DIRnbXcW4zAkupSte8y5vPkRS/+xev+1SXRxc8zLhQ7CAZAj/58RKDBd91eoL9ineuXU17Y69FvX28mqH9NzfqvB5ouFnSQez2c3aINbGTyE6PAxZUu8A0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=rHfFkKNy; arc=none smtp.client-ip=74.125.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="rHfFkKNy"
Received: by mail-pz2-f20.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso369396a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789627179; x=1790231979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTC4eoOEFM+3zuwZ3TXqvMqqhwNjBUirFI+wbZjCUTU=;
        b=rHfFkKNyZk8LPtsJ7vK1CSwef1cP4OKwjofJEDgycqcrhxxDOi2yVWgIWhTpvanR9g
         Kl+rFo0ddrLO/xX3OtnYFqYoVhcPukGaaAN5KlsF8CT8Qwzq4tcj8VGCd6BiscYR6HLL
         6L1RPjrENlLCz1WPnVh5+5tgqcZty+OmUU/ZpLaKmWkZISIQ2LRSTSsKpMuNj4g+wegc
         1g9lBEUKpyh7lFoyPezBWRcYUkS1+oD0DFG19C/YJiuwZG+HkgqCTyIT/igL2QDo6iak
         7Gt9oZqLdEBBz1K/K3homismj6tgQcrKYEJrXxMRDkBgKNa/xAOHymELoYCTHB6yGIhZ
         qnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627179; x=1790231979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTC4eoOEFM+3zuwZ3TXqvMqqhwNjBUirFI+wbZjCUTU=;
        b=cW+pVTMcMlAGyn4NVHKDkjNWM9zps2ALRuJLEYnXWI+TMwgYhiV9AEPR85LXx0NjIZ
         4PTXd/u0im/XryYEpIEPsK1iMD9TFsPdNekkj9m7i9QLXyR6d+2q3qMAj8v7lOjtx11t
         vtu8ox+G0W23kfWOszGLjhMVyaKfF/c2H3oVusWzRf/uUk2aW25tqWmsIhcXzosoRMdu
         Ggtxm6Pe4FUu6+vuzgn+0T5veW+N8E1n8TUd8LbtjBSqx2J4RQzu1NcXxh2tnDC7JT/i
         Fa1VaAfaXC6B9kgkdoJWnaN8q+DCj2euTrfOg5Bs3qdBiCRIoHEOjVB6LXZhn9i5uO7Y
         wpGg==
X-Gm-Message-State: AFuF++mNk4nGSRy/KNx1wQ7sty6Y7y4WCWeEjM53OMPMGpz9f6DZM93h
	2WYpr5MCCBBDja24qdoct74Mmb2STCg9hzBovvUSh86ZGaGkWob/X6gAe9i4Mhu/Cp88SWckjFn
	6nPQaixxMrYVWdXkOqkn92hZybudcRoicGoM1sf5gL7cznWycR0Sw2BZJ6Ok1fIAI7uU=
X-Gm-Gg: AYBFou2K5QDOKtQyHt4O5dhYEEnZE32czjt4bUuzGgGMlHGEVCrsO/IvyDFOfc1kUgI
	ytrVZ1zfTP8OWqcZS7iOmMzNPDkZN8mjYre6NT29qNPtV6PS6nmR3Pk9Gq4i/XystfVNQbMZuEC
	SZ9naTEc+tO+QxD5QL8fQZjJzJGN5KNZeLy7/Gzxl/aTThWEdZLl9zvGq3u2+mRvWfeOyuLHbAm
	AZg+XhG9wozPPbxcMz3lZZ7e9Y++A9lUVW21yBFpbG3aFf2vFwvoNsWp6tTOMDpfqwzTJXqrKs+
	jC3LMVZEoTlg1pCrkiUKZAP+rmaE62vP7ir+iWx0ohlNdm5dr34KLdkaDORVVzQp9YCtxyZUuuN
	/qvRe6QLN9KCEHnHof3cpBSkaScZ40t7Gl58UoRwVRgEcX8QDUSD851JUQheeTulO0k1vuVcbrc
	9kM8XDpD3l6vrjt/I+hkZ1J4kQpyFp1Jn110xpbWIMwQVxfR/Q9KBaZtQPFIC0BqNQ9b38JX/7/
	11A0jR+wIoF
X-Received: by 2002:a17:90b:586f:b0:39e:28dc:3682 with SMTP id 98e67ed59e1d1-39e28dc380fmr15669229a91.21.1789627178728;
        Wed, 16 Sep 2026 23:39:38 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d76834sm10904606c88.14.2026.09.16.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:39:38 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next 3/4] net: core: resegment oversized TCP GSO skbs
Date: Thu, 17 Sep 2026 14:38:53 +0800
Message-ID: <20260917063854.2011613-4-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917063854.2011613-1-wang.zhan@smartx.com>
References: <20260917063854.2011613-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A GSO skb which exceeds an egress device limit loses its GSO feature mask
and is segmented into individual packets. This is unnecessarily expensive
when the device can still offload smaller TCP GSO skbs, which is easy to
hit once one hop of a BIG TCP path raises gso_max_size and the next one
does not.

For an unencapsulated TCP GSO skb which exceeds gso_max_size or
gso_max_segs, work out how many MSS segments each output skb may carry and
resegment the skb with that bound instead. Keep the features computed
without the GSO limit checks, which say whether the device offloads the
GSO type at all. Encapsulated and frag-list skbs, GSO types the device
cannot offload, and bounds below two segments keep the existing full
segmentation path. The result obeys the GSO feature and limit contract the
device already advertises, so apply it automatically, without extra device
state or a userspace control.

The check runs on the skb which is handed to the driver, after
validate_xmit_vlan() and sk_validate_xmit_skb(), and costs one extra
ndo_features_check() on the oversized path, against segmenting the skb
into individual packets. That position is also why the limit follows the
L3 protocol rather than skb->protocol: validate_xmit_vlan() replaces the
latter with the VLAN ethertype when it pushes the tag inside the skb.

Measured on a veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP
enabled on the veth endpoints and left off in the guest, so the skbs which
the veth hop accepts have to be segmented before the TAP device. A single
iperf3 TCP flow, six alternating runs per state (`-t 15 -O 5`, fixed CPU
affinity and port tuple). The middle column is the same tree with the
resegmentation disabled:

  protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
  TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
  TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps

Coefficient of variation for the two mixed columns was 0.48% and 0.82%
for IPv4 and 0.44% and 0.44% for IPv6. A BIG TCP hop which feeds a 64 KiB
hop loses 69% of the throughput of a path which never enables BIG TCP at
all; bounded resegmentation recovers it, 3.3x over the existing
segmentation path and within noise of the no BIG TCP baseline.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
---
 net/core/dev.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 428b5d057287c..ae551d524b877 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3834,18 +3834,24 @@ static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
 			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
 }
 
+/*
+ * Does @skb fit the GSO limits of @dev?  The size limit depends on the L3
+ * protocol, which validate_xmit_vlan() replaces with the VLAN ethertype when
+ * it pushes the tag inside the skb, so look behind the tag.
+ */
 static bool gso_within_device_limits(const struct sk_buff *skb,
 				     const struct net_device *dev)
 {
 	return skb_shinfo(skb)->gso_segs <= READ_ONCE(dev->gso_max_segs) &&
-	       skb->len < netif_get_gso_max_size(dev, skb->protocol);
+	       skb->len < netif_get_gso_max_size(dev, vlan_get_protocol(skb));
 }
 
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
 					    struct net_device *dev,
-					    netdev_features_t features)
+					    netdev_features_t features,
+					    bool check_limits)
 {
-	if (!gso_within_device_limits(skb, dev))
+	if (check_limits && !gso_within_device_limits(skb, dev))
 		return features & ~NETIF_F_GSO_MASK;
 
 	if (!skb_shinfo(skb)->gso_type) {
@@ -3894,13 +3900,15 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	return features;
 }
 
-netdev_features_t netif_skb_features(struct sk_buff *skb)
+static netdev_features_t __netif_skb_features(struct sk_buff *skb,
+					      bool check_gso_limits)
 {
 	struct net_device *dev = skb->dev;
 	netdev_features_t features = dev->features;
 
 	if (skb_is_gso(skb))
-		features = gso_features_check(skb, dev, features);
+		features = gso_features_check(skb, dev, features,
+					      check_gso_limits);
 
 	/* If encapsulation offload request, verify we are testing
 	 * hardware encapsulation features instead of standard
@@ -3923,8 +3931,79 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
 
 	return harmonize_features(skb, features);
 }
+
+netdev_features_t netif_skb_features(struct sk_buff *skb)
+{
+	return __netif_skb_features(skb, true);
+}
 EXPORT_SYMBOL(netif_skb_features);
 
+static bool skb_can_gso_resegment(struct sk_buff *skb,
+				  netdev_features_t features)
+{
+	__be16 protocol;
+
+	if (!net_gso_ok(features | NETIF_F_GSO_ROBUST,
+			skb_shinfo(skb)->gso_type))
+		return false;
+
+	if (!(features & NETIF_F_SG))
+		return false;
+
+	protocol = skb_network_protocol(skb, NULL);
+	if (!protocol || !can_checksum_protocol(features, protocol))
+		return false;
+
+	/*
+	 * The TCP frag-list path does not carry the bounded segment
+	 * limit through skb_segment_list(). Keep bounded resegmentation
+	 * on the regular skb path until that support is added.
+	 */
+	if (skb_has_frag_list(skb))
+		return false;
+
+	return true;
+}
+
+static unsigned int
+skb_gso_resegment_max_segs(struct sk_buff *skb, struct net_device *dev,
+			   netdev_features_t features)
+{
+	unsigned int mss = skb_shinfo(skb)->gso_size;
+	unsigned int hdr_len, max_segs;
+	unsigned int gso_max_size;
+	struct tcphdr _tcph, *th;
+
+	gso_max_size = netif_get_gso_max_size(dev, vlan_get_protocol(skb));
+
+	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
+	    skb->encapsulation || mss == GSO_BY_FRAGS ||
+	    !skb_mac_header_was_set(skb) ||
+	    !skb_transport_header_was_set(skb) ||
+	    !skb_can_gso_resegment(skb, features))
+		return 0;
+
+	th = skb_header_pointer(skb, skb_transport_offset(skb), sizeof(_tcph),
+				&_tcph);
+	if (!th || th->doff < sizeof(*th) / 4)
+		return 0;
+
+	hdr_len = skb_transport_header(skb) - skb_mac_header(skb) +
+		  th->doff * 4;
+	if (gso_max_size <= hdr_len + mss)
+		return 0;
+
+	/*
+	 * gso_within_device_limits() accepts gso_segs == gso_max_segs but
+	 * rejects skb->len >= gso_max_size, so only the size bound needs - 1.
+	 */
+	max_segs = (gso_max_size - hdr_len - 1) / mss;
+	max_segs = min_t(unsigned int, max_segs,
+			 READ_ONCE(dev->gso_max_segs));
+
+	return max_segs > 1 ? max_segs : 0;
+}
+
 static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 		    struct netdev_queue *txq, bool more)
 {
@@ -4073,6 +4152,7 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
  */
 static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
+	unsigned int resegment_max_segs = 0;
 	netdev_features_t features;
 
 	skb = validate_xmit_unreadable_skb(skb, dev);
@@ -4088,10 +4168,29 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 	if (unlikely(!skb))
 		goto out_null;
 
-	if (netif_needs_gso(skb, features)) {
+	/*
+	 * An oversized skb loses its GSO feature bits and is segmented
+	 * down to MSS sized skbs below.  A TCP skb can instead be split
+	 * into GSO skbs which do fit the device, so keep the bits and
+	 * bound the resegmentation.  The features computed without the
+	 * limit checks say whether the device offloads the GSO type at
+	 * all.
+	 */
+	if (skb_is_gso(skb) && skb_is_gso_tcp(skb) && !skb->encapsulation &&
+	    !gso_within_device_limits(skb, dev)) {
+		netdev_features_t offload = __netif_skb_features(skb, false);
+
+		resegment_max_segs =
+			skb_gso_resegment_max_segs(skb, dev, offload);
+		if (resegment_max_segs)
+			features = offload;
+	}
+
+	if (resegment_max_segs || netif_needs_gso(skb, features)) {
 		struct sk_buff *segs;
 
-		segs = skb_gso_segment(skb, features);
+		segs = __skb_gso_segment(skb, features, true,
+					 resegment_max_segs);
 		if (IS_ERR(segs)) {
 			goto out_kfree_skb;
 		} else if (segs) {
-- 
2.47.3

