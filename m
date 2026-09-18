Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A42E22B5
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721263; cv=none; b=gI6C4uOsBBVTGJa2NB1gLI4V1q3jlLtw+dbNuoXFuR4gCIAfFJ45Z9l/lMMpqVY65q1FoN4xJWa9fcXu3ebOpyd48gf+GH6GChNKPd2PhfQ4uIoIR+uiEbaNeaXB4qIzAK724p7eWxV4rxplTqzolFgEpTxNiNPf9riIr/osBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721263; c=relaxed/simple;
	bh=8se4cz8HEr30ZSCgsotGN7NG7c4BF0Uz+EKTq60NG0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmqbSBSE/AHHEA7pIEbSDZKrLwvn1rFwQYwq3CTzNjGFhiMVgK+a8lZZpABv7f1jq22ooz2dT5xS70VaphTch1iQL9DIddw5L6uXeYaderV/jJunfj7IbjR+zJ9su2RjO7wqPGtwRDr95FDJXOot9l/c/sUlinc5oGUBd87EKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=0UrX7fde; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="0UrX7fde"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so4168065ad.0
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1789721261; x=1790326061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hh34hFjRZKMngovmPa9gxbWAntDJaNJPxvVNZhvGF8U=;
        b=0UrX7fdeSLxVRReoIxI1zP92+C2ylWXccTKPYGRaai8+bFdWKgSZ7WHFU1d+M2VdKq
         QAPZFP8JweC7LZJW8SvUdKtjAaO4JpvZiZ+bfBulxms5cPYSGjmvUm7+Y88a+txV/Mh3
         RMti4ja5y5Cu8lTi6OGVLCOqtUB8lDVVvwZ2mdr2/blKrBNwZLIGgY7PFVGs6UlH6pTn
         l+0x2PjPbE6+he/8pTEZL6o9n2nyvoSGZsOg4jTLG5gYuMTjdDffnZC9waeaPIovlxyi
         cdncBcXxjsYPZUziRjmxPrl/diWa5oAj+S+eM91SHtG0CY/fbvIMKC6AIMiaRP7cTmtd
         eVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721261; x=1790326061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hh34hFjRZKMngovmPa9gxbWAntDJaNJPxvVNZhvGF8U=;
        b=t1j5ukQcrXlkKoHvR1R3vNPNa4x6oz7rXKIBdoO94NCuJtOLkWZp2l6jG+ZJLaSoTi
         My9ueFNfL8vpJjgNWEWolnKCDnPFahvM5f6YJxFpQjeCY0lrInS7aZyPaAZ7fTnDuPJt
         Oj+v3IlIUecO1Z/WqTRXCTdl/u5cMvVlHtV2XIcWllwlMXGmuee3SnJDBN2gzTqiyBN9
         Ougu47eGlwsHH3qv/lOEE3jSd9MHBS3x2aMRq4fmsUWA5y2qlLeKng/npPeUf5vEkLyQ
         kdx3ItSjrFtYp0aQKLEViZXi5X+PsRwFVr2ocQ+bsBnxVOQgyVfUGvX5rxLqe9VYlyOT
         E24Q==
X-Gm-Message-State: AFuF++nrQOM/tYACxcY62fIeQ27Q79TmmtcJt/CVTGRLYZ5i82sY5CYR
	rGg0AlOPec1mZS9wtBC3vMUBY0EPuhZypguAoBcn2O0LXk1/z8khG6oCK7ySF4R6XPR3sbPWgly
	Il9AckuzNd8ea6ChtE6+tMSiwDIkQjafOMx3u/3a+LbTeMS6vCZaOkiRkB/CvC97Orpv+9HCL4p
	iBDw==
X-Gm-Gg: AYBFou28Ri/ZNv1IwaIzqNMd3Jcrt/0P3PrKsdBWyNo/mGOGG7x/9tIYXDdvduAt6gY
	mJY8vVt4+YUsHxlJ9cZMacR+/0339BI2sWnVbZ4ygTNBl54s77Ayl39jEK8/0ZIAknnUPzImlnQ
	Ly9yb5mDbxBEYsd6okB1YkCOEr4RxXWF0ZL7z2wngT9scO5iGVRgJ4k5kXpWyhER+H5A5HmOAxM
	SwanzvbFtNfXGQZG6tbLJB1OF5glQ//cUVJ5X/O8DdgwqyRKcaGCz8JwvO1PvV438UbSMz4kfap
	9qwi/KvUx4nGU6Tno3DZCFqy3Igpuv+YRWkDkMD6GIU5Vy1DskHKNv1x7UKZWYsp8h30N8iE2a/
	kyn3RRRgfVfyIvV+SO3nGMgLoLI9KM5x72TyDC5ESXue0c0weft8+MXzV0p9VUymnGFUdAjZ5Ft
	mD/H+eJ/TSXugP013I9IWLePzP1VaRvqEtjkNVPZJUKPmSD9GKnCKFErPp/ljpDRfXSYqKsdz2x
	3kcEt5WbWs=
X-Received: by 2002:a17:903:3d06:b0:2dd:ad73:5b73 with SMTP id d9443c01a7336-2ddb1d5bd18mr37097395ad.35.1789721260907;
        Fri, 18 Sep 2026 01:47:40 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c287aab5fsm2578095eec.22.2026.09.18.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:47:40 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Wang <jasowangio@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v2 3/4] net: core: resegment oversized TCP GSO skbs
Date: Fri, 18 Sep 2026 16:46:50 +0800
Message-ID: <20260918084651.3022878-4-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918084651.3022878-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
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
index 16685888b2812..548db4d4e874c 100644
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

