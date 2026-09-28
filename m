Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7B35E1CE
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570505; cv=none; b=dSIYkBVeQZFcnCNTqq4Dzot61QuQkq7pXCOZUznX0K3TSfgpvEoBGHhw/irD7alg8ygBQVDbRianlBYtzRNG00UDPKGSv5KmOCQ+24SWkYQogXGWCJvy+861D9hXp8HX8l12vbeo/aHgOdtsuU6cgRQKxqVgMFVSSlcQqAQprWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570505; c=relaxed/simple;
	bh=vYSEEXJPxKnpKAztChhsGo89ySMXGDc95RYqoVIBCIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etc6AZCqaYBtADGB0vrz9KtHzFOz9wAE0MfEOP0BmGZJ4Zx8eHsym33SrI2wcgcOue7QgPfkp7pZMPKJL38ZL1jDGZGTjrdqpvPceSy1oMfOeH5eM2Lh6w1IfKNN3CRNr8zFQZDCw+gr7VWFjTKJSnbDs5LBg6fw51ApQK90YzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=hTWLqFYX; arc=none smtp.client-ip=74.125.229.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="hTWLqFYX"
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-342fb6e22e2so745627eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1790570502; x=1791175302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wDxmOiPgfBE3s9EMal1DKB5DcGzR2fGz06NvD2ZVnmk=;
        b=hTWLqFYXFQ3GMykp5XQ5I/BPLsWXg67oC6UYnk/Ph49Kfc16krW7sGUSdiv6VQC+Gd
         PCogmlZpeRA6BwILTHdyIRH89EFHyviYnY1ZrrQYQxKERUnKlOIFNT+nfxAkJYFwfZWz
         da4Vt1IJeaPMJOCk+Ra+pSMdX7VWnkZwX0RGStabozDIBa0ChGyqPZeSUUphk9APQ3dr
         gHlr/iKwYNPgyYg44L6lCsvBOKHAqHduSnsSdyvh6S+pOffb29HafSoVgvbB/hZ5lSWD
         OTQUbWegem5s6cKpmCisey09jAvJw3fGcjCAJGCAetvsktw1X4GbrTMc0T16B29L1VB9
         YaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570502; x=1791175302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wDxmOiPgfBE3s9EMal1DKB5DcGzR2fGz06NvD2ZVnmk=;
        b=GCWCDmJ9J4o86y4jZ9tsbHLq3WlbcHdvpoPcC8Z3695Ogr15/pQUOU6JyROU1bqJSb
         LWEoQXB5yKhFQ+6ozfQ3X+U0kpNGECZgwn2k9xQB7/5wYwPQhrDZBUmBG5QQVWsXYvH9
         xFjj/mE6GcqLK8nLCjg7hSs5L0JRdkowx2PHPFvZNmQJ5/DLCdayAePGXVAvBrH6XFgW
         wG2d+bSTCrZw6ayk3rfD5ThO3+Fq72M3KtIyv8gqmPlrHEARVGsfk14HfUZ+89QT4ENf
         ASVY6iLMO1td1ho24kQ/YwKD0HHpcoQtduNK82NUY0k2uOSHIrNU+zIkfmN28/i0mtVD
         flhA==
X-Gm-Message-State: AFq9FYLXB9oQFxnLxqtTSvh99qZBifLm64vjd6mKjOtxCjDBL2jASvIH
	nqEfCwIPd7/14/qxRE5vMHqloKML60bUO8rL1Rn2fUk6XLRkfOQQ+jGZ2nsfFv0oDNXE9ShuGFi
	HsSR8oc23g2ARBi7vjq0FWYp5Mv8xVWnp7i+gLhMTmW7EJdttU/HPHT0bmjw29I2tOv0POtbh89
	6gOA==
X-Gm-Gg: AYBFou0jfc/urw7EXnJ/f3BXzpESrkihmRzrwzg2dpJd/pxiVgChiXrl0NdsHoQ8GTO
	iIdM5Ft4t/ZMq5sNWEKbydUvp8M5qTbULpq8QTnLv4642iPx0MhofRnhKsdjdLCmo40uDKMhurC
	ertptFUBpJDcQobbeU97oyui/GY0GrunzSqCtKaM5O3cScOBHztv4nFDqEv0egVShtPMp6c+XbO
	jG7mUDUfcGQmTsRUu1ggtpoff6l0pNQbVxZbIjR34S5pEfuB9JxAEPF8G+2Ms+8JetfYD8ApOvT
	qHKs/N7LKdhWLuTv9ZhzTkBiSQOR72tj0W8DFp0JWu5to/wgEFQGNNGgQuwrItQiHI74CZvwd3d
	qCNPElABVE/XiNDgYHf79NsjG55M9wf9wdTo5uuDHSsUbhpYr712zg+BphzGwzKdWI/YLf6gzjv
	YMNrEePTZmgSIg9PPhLPLk8IGGVWiZM+BouQIpaN60nxOg01HPBxxO1xF4HTdpp0jFIBaVSxz6m
	Eb1Ro8WLKQ=
X-Received: by 2002:a05:7301:6906:b0:33c:20d5:b7e1 with SMTP id 5a478bee46e88-3427265d58bmr7875141eec.33.1790570501030;
        Sun, 27 Sep 2026 21:41:41 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm22772905eec.28.2026.09.27.21.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:41:40 -0700 (PDT)
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
Subject: [PATCH net-next v3 4/5] net: core: resegment oversized TCP GSO skbs
Date: Mon, 28 Sep 2026 12:41:01 +0800
Message-ID: <20260928044102.1004310-5-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928044102.1004310-1-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
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
resegment the skb with that max_segs bound instead.  Encapsulated and
frag-list skbs, GSO types the device cannot offload and bounds which leave
room for a single MSS keep today's segmentation.  The output obeys the GSO
feature and limit contract the device already advertises, so it applies
automatically, without extra device state or a userspace control.

The output is a plain GSO skb, so its whole length lands in the 16-bit L3
length field which inet_gso_segment() and ipv6_gso_segment() write.  An
egress limit above 64 KiB would give outputs whose length truncates, so
the size limit is also capped at what that field can express.

The helper runs on the skb which is handed to the driver, after
validate_xmit_vlan() and sk_validate_xmit_skb(), and only from the
netif_needs_gso() branch, so an skb which is not segmented pays nothing.
An over-limit skb pays one device limit test and one ndo_features_check()
for the bound, in exchange for keeping the output a GSO skb.

Measured on a veth -> bridge -> TAP -> guest virtio-net path, with BIG TCP
enabled on the veth endpoints and left off in the guest, so the skbs which
the veth hop accepts have to be segmented before the TAP device.  A single
iperf3 TCP flow, six alternating runs per state (`-t 15 -O 5`, fixed CPU
affinity and port tuple).  The middle column is the same tree with the
resegmentation disabled:

  protocol  no BIG TCP   mixed, no reseg  mixed, resegmented
  TCP/IPv4  51.550 Gbps  15.850 Gbps      52.617 Gbps
  TCP/IPv6  52.050 Gbps  15.783 Gbps      51.933 Gbps

Coefficient of variation for the two mixed columns was 0.48% and 0.82% for
IPv4 and 0.44% and 0.44% for IPv6.  A BIG TCP hop which feeds a 64 KiB hop
loses 69% of the throughput of a path which never enables BIG TCP at all;
bounded resegmentation recovers it, 3.3x over the existing segmentation
path and within noise of the no BIG TCP baseline.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v3:
- the L3 protocol change moved to patch 1
- fold skb_can_gso_resegment() into the helper, now skb_gso_output_max_segs()
- pass the caller's features on unchanged, the bound only shapes the output
- drop the scatter-gather and checksum tests skb_segment() applies itself
- saturate the size limit with min(), drop the sub-MSS guard
- cap the output size at GSO_LEGACY_MAX_SIZE, these outputs are not BIG TCP
v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/
---
 net/core/dev.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d66b667071837..728260772f349 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3933,6 +3933,63 @@ netdev_features_t netif_skb_features(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netif_skb_features);
 
+static unsigned int
+skb_gso_output_max_segs(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned int mss = skb_shinfo(skb)->gso_size;
+	unsigned int gso_max_size, hdr_len, max_segs;
+	netdev_features_t features;
+	struct tcphdr _tcph, *th;
+
+	/*
+	 * The TCP frag-list path segments through skb_segment_list(), which
+	 * does not carry max_segs, so bounded calls skip those skbs.
+	 */
+	if (!skb_is_gso(skb) || !skb_is_gso_tcp(skb) ||
+	    skb->encapsulation || skb_has_frag_list(skb) ||
+	    !skb_mac_header_was_set(skb) ||
+	    !skb_transport_header_was_set(skb))
+		return 0;
+
+	th = skb_header_pointer(skb, skb_transport_offset(skb), sizeof(_tcph),
+				&_tcph);
+	if (!th || th->doff < sizeof(*th) / 4)
+		return 0;
+
+	hdr_len = skb_transport_header(skb) - skb_mac_header(skb) +
+		  th->doff * 4;
+
+	/*
+	 * The output stays a GSO skb, so the device has to offload the GSO
+	 * type.  The caller's features cannot tell that: this skb is over
+	 * the device limits, so gso_features_check() has cleared their GSO
+	 * bits.  Compute the features again without the limit checks.
+	 */
+	features = __netif_skb_features(skb, false);
+	if (!net_gso_ok(features | NETIF_F_GSO_ROBUST,
+			skb_shinfo(skb)->gso_type))
+		return 0;
+
+	/*
+	 * The output is a plain GSO skb, so its whole length lands in the
+	 * 16-bit L3 length field: only a BIG TCP skb may exceed the legacy
+	 * GSO size, and this path does not emit one.
+	 */
+	gso_max_size = netif_get_gso_max_size(dev, vlan_get_protocol(skb));
+	gso_max_size = min(gso_max_size, GSO_LEGACY_MAX_SIZE);
+
+	/*
+	 * gso_within_dev_limits() accepts gso_segs == gso_max_segs but
+	 * rejects skb->len >= gso_max_size, so only the size bound needs - 1.
+	 * The min() keeps that subtraction from wrapping when the device
+	 * limit is smaller than the headers.
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
@@ -4097,9 +4154,13 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
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

