Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3E3DD521
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454057; cv=none; b=E1bcE9WVxcigLph+/Ip7vJwUcdw36rSkFCWWd5azb6VQ7ML9L5sQTAaor8WD7KQGqc7Yy5Mr59CmaL7kHQV/zH6/RgWuHTYksFOtWzRrJEDEnPMVEG6L97P1WyFlw355s2ZlCZq/wApATXKWM1ulbkIVfkf00qTOlDm/AQ3ROuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454057; c=relaxed/simple;
	bh=qJ9b7GkvFbbokSunWoLa7nCmsYXsHW+s9zqouGfx1SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0TgZmeLSldaI97+Z2dyG7Ec3IbzfFtcGMK4Dud5YQ2T7fhHlKYCA9eOhgcTJMu6mgL6oVhoueAaaIBApyNuY2y6qpAToqCYjHEF2CqVnD+t+GeVCFlA95GViay+6Szy4LuqSGiA+vl///0vR5jtG39Z0w9hnwDtyJ5jxADG3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=gnXjYWak; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="gnXjYWak"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1517bda04a0so1714164c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791454055; x=1792058855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEKNDdevf4Oms/cgophobP8DH8D3HnXemSuGbh+G/qs=;
        b=gnXjYWakffbTl3pmf0swCdB1MHwFUAOktQXyQRG7Xn8hxEnbnT08rsk5ok/KsmIR4v
         jb51dEY26JDwbH2EXPrxpR91bYuoW54osfxuYaOOqMEfrTd2TFP00OAfo/htztm5wxuj
         F/8/xCC3rsCyJr6l4KAZJlQ9WoemvNQ2p4zXqe+yv45KE4SiwME6D4bAD+9Wrszos5eR
         cpxru0ez9Sj0VrpnSQMJ9zzR3XBquJDae+pdjYrmqiNKeIuIYABLLTMQnbTIH+2dugKT
         GrVL8yY2zGOXg2TCD9Bi5wlz4Ehb0V7uU3vampb9TSsBrTO+9scu6/MOsm6AxHLcTTZB
         qifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454055; x=1792058855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEKNDdevf4Oms/cgophobP8DH8D3HnXemSuGbh+G/qs=;
        b=ai6jtsloaS9SSXzZXBGwsK7eDfc20FdJ3JbYKcdzsqBn1nCIIZr6291xlNSTh09Lh/
         X20pp0dk2YPD+0jaAx13yiGTswUd9iBMrE1uspDmHlntepZ72aL6m72wE5lZGbA6YC4Y
         Tj79+CHQsm+M5yITuXFLWDH47kMoYb4V6y/IAWAwlv6uABrvEEtwEeXsMqY2Noqdu6vd
         CP8HGJbvuExi2nO3bG+yD9MKE+Od3wyOD0hcCAWqxMZviShrkCYtF5DLpIn1bzfXg23F
         PeT6z3bo0vZZPuVQB7K7Hobf///U96Esy5uK0PSxHVpVzYOm3C2s+w1kUWO/CW2NBl6p
         GK8w==
X-Gm-Message-State: AFuF++lfZDWUshZloJYjyToBRXU+EdhN14FxGZ89MGXN+KTkEfaW2rJW
	jk3gL7osVEVcfIBE76gE7Nv45BcP0DqloRT56Ta0V1BsNVfJGbBcjlJieewinmwKaIuBrcmLt01
	Pq7KfuTfp7AE0kVNXvSF26JqqxsgJS5hSx79QItKioIszWMv1XREPwlbbevHAd4gNr4A8h7Ly
X-Gm-Gg: AYBFou1U7HcINOJQ6HIIPfJIysUM/bnaGy9hc+EC+M5N4DYXTZtNrMQBAcKoj0pG9v+
	bWEKZYI24CyG/V4DVgCOAaytqeUwap/YJuGkMxTLxxQNbzQEE7pKubena6PiWE8l1p5pPjgGDcp
	JcfL0GNPzW4msiWh46+GgPDdMjg6F6BCcYZuTpCcVRAUy8YKiACU6dJDdB4pXJt/YjsfxqJ+DC1
	R2K7iR4XA7XtYyLKA+d1R9koRoHoTpsLBbrUdD0u50v0smPyG/C+G/bispkxh1vK9oAK4HxBm+Q
	Gqwrts8CdEIsOUVO5FCDt4RHXa5IpkuvB+noWt75A7O++ioGP89qXESLedoELjxyFd+BDJEbHmW
	NoD2JopFHO1VK3LAnOC+XjQeE0BZOXM0fs7US1FH44Pwzu6VAzXIa2FLjPPSvB6mKmIrIowtpJs
	Ku6RD6KyGvGCnhYEDF9lNG5K4IuHlaG95Vb6mrpB9fvdvYMjK1uRolQDZAH1cux8b+7FG/Zgbbt
	u4Qp2QzPAs=
X-Received: by 2002:a05:7022:130a:b0:128:d4be:7428 with SMTP id a92af1059eb24-1620551125fmr4874832c88.19.1791454054199;
        Thu, 08 Oct 2026 03:07:34 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm14200933c88.12.2026.10.08.03.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:07:33 -0700 (PDT)
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
	Wang Zhan <wang.zhan@smartx.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v5 5/6] net: core: re-segment oversized TCP GSO skbs
Date: Thu,  8 Oct 2026 18:06:50 +0800
Message-ID: <20261008100651.2534957-6-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008100651.2534957-1-wang.zhan@smartx.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An skb which exceeds an egress device limit loses its GSO feature mask and
is segmented into individual packets, although the device can still offload
smaller TCP GSO skbs.  A BIG TCP hop which feeds a non-BIG TCP one pays
that on every flow.

An unencapsulated TCP GSO skb which exceeds gso_max_size or gso_max_segs is
re-segmented with a max_segs which keeps each output inside that limit.  An
encapsulated or frag-list skb, a GSO type the device cannot offload, a
max_segs which leaves room for a single MSS and an skb whose transport header
is unset or stale all keep today's segmentation.

This path emits a plain GSO skb, not a BIG TCP one: inet_gso_segment() and
ipv6_gso_segment() write each output's whole length into the 16-bit L3
length field, so the size limit is also capped at what that field can
express.

The helper runs on the skb handed to the driver and only from the
netif_needs_gso() branch: an skb the device takes as it is pays nothing, and
an over-limit one pays the TCP header read and the features recomputation.

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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v4: https://lore.kernel.org/20260930111526.2183107-5-wang.zhan@smartx.com/
v3: https://lore.kernel.org/20260928044102.1004310-5-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-4-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-4-wang.zhan@smartx.com/
---
 net/core/dev.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d6e39df55cd8cf..ef64834520949f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3996,6 +3996,53 @@ __netif_skb_features(struct sk_buff *skb, bool check_gso_limits)
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
@@ -4159,9 +4206,13 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
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

