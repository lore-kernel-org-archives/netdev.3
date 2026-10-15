Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DDB37DAAE;
	Thu, 15 Oct 2026 23:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108481; cv=none; b=mFJp4/okgXUDEAfKSorPIucqRFy+nAaFt4O4bmlU2IITbGQBDHUAQORQKRODeUYtnvsCPbav/34U2OC7DHcNTDturXdWf+CagcLc+l0u4TkIOH44YZnCVd9spCmOnaKZSfRlHmP6A8I2XYimO2DlgeEWK/aDgMT0R67qoH031QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108481; c=relaxed/simple;
	bh=ouDtRhdbCfK09xk6bUcEME3uZdBpwWEidP2KjG9rU8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppHer9wV04K/wQrVe6zeZ+JOs+DJIl1lgaN6pkkiAoPdvK+icOuZBOnqGhtYJRZtc7jUOVmKzgmCm0c4vIB/h77x5HJYuqSNXYtlVROK+vvWPLiUUpRJ9zdktVIO0CESOg7XL8ovIOge0rFugJExA6cXlFJV2h2Po9J+DROB5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YN2sGrHJ; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YN2sGrHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792108479; x=1823644479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hLOHO5NgfvkLtx3RlkvuBJm8qZs+CyYSXl+8bBNiNX0=;
  b=YN2sGrHJD6TcNxADwmLAMAHwwlbH9A25mINgg2XMjv3kxBxkDFFWEeQp
   jWwkUdVaz8Rh0WM+9YxN4LXuu0iMU6glK7amslHrr71R4kONTknrOI4Uv
   f7fKC0cFDmOODZ04w1uvow200NY4WySTOXqC0C9m7SlaeLyNsWb3a3zGb
   ZqbkzP49R4jjxNbsIFN5qlvl8QXH2PZ+dZe6cPCDuzgJEdb1P5/rxKwVe
   cwp65srK1eGvgFdzaMfM/u3ufNwiJIxyHsZdAi4Vu/7+j3gv24eaXA4+5
   H+N4Ch+MqxA527TWo4nzgPD9+NIXbrMgCWon1WbZUkPlvLg0G3VnNG/b2
   A==;
X-CSE-ConnectionGUID: 8PAWLCTAQEqL8kR6q3f+jg==
X-CSE-MsgGUID: CwhOBg6YQ2qPdpRzNLsjZw==
X-IronPort-AV: E=Sophos;i="6.27,160,1787011200"; 
   d="scan'208";a="31380081"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 23:54:39 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:12044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.105:2525] with esmtp (Farcaster)
 id 854b2fed-5cec-4b9b-9ac7-b9eb111b3e48; Thu, 15 Oct 2026 23:54:39 +0000 (UTC)
X-Farcaster-Flow-ID: 854b2fed-5cec-4b9b-9ac7-b9eb111b3e48
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 15 Oct 2026 23:54:38 +0000
Received: from dev-dsk-dkeogh-ai2-36d3b9a7.us-west-2.amazon.com
 (172.19.55.127) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Thu, 15 Oct 2026
 23:54:38 +0000
From: David Keogh <dkeogh@amazon.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	<nh-open-source@amazon.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next 1/6] net: add tx_extra_headroom and LL_ALLOC_SPACE()
Date: Thu, 15 Oct 2026 23:53:30 +0000
Message-ID: <20261015235335.4162993-2-dkeogh@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261015235335.4162993-1-dkeogh@amazon.com>
References: <20261015235335.4162993-1-dkeogh@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Programs attached at TC egress commonly push additional headers onto a
packet, for example to encapsulate it. When the packet does not carry
enough headroom the BPF helpers reallocate the head, which costs an
allocation and a copy per packet.

Locally generated UDP, raw and AF_PACKET traffic is allocated with
exactly LL_RESERVED_SPACE() of headroom, which only covers the driver's
own requirement in needed_headroom. There is currently no way for an
administrator to ask for more headroom at allocation time without
changing the driver.

Add a tx_extra_headroom field to struct net_device for that purpose,
together with LL_ALLOC_SPACE() and LL_ALLOC_SPACE_EX(). These add the
extra reservation on top of LL_RESERVED_SPACE() while keeping the
link-layer header alignment unchanged.

The new macros are intended only for sites that allocate new packets.
LL_RESERVED_SPACE() keeps its current meaning and remains the threshold
used when checking whether an existing packet must be expanded, so the
extra reservation never forces a reallocation on its own: packets that
already have enough room for the headers being pushed, such as TCP
segments built with MAX_TCP_HEADER, are left alone.

Keep the extra reservation separate from needed_headroom so that driver
updates of their own requirement do not clobber it and so that it can
be cleared independently. Place the field in the padding that follows
needed_headroom, which keeps it in the TX read-mostly cacheline group.

The field is not set anywhere yet. A later patch exposes it through
rtnetlink.

Signed-off-by: David Keogh <dkeogh@amazon.com>
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     | 33 +++++++++++++++++++
 net/core/dev.c                                |  2 ++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 8eceaa80b..a7e311fb7 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -35,6 +35,7 @@ unsigned_short                      gflags
 unsigned_short                      hard_header_len             read_mostly         read_mostly         ip6_xmit(tx);gro_list_prepare(rx)
 unsigned_int                        mtu                         read_mostly                             ip_finish_output2
 unsigned_short                      needed_headroom             read_mostly                             LL_RESERVED_SPACE/ip_finish_output2
+unsigned_short                      tx_extra_headroom           read_mostly                             LL_ALLOC_SPACE/__ip_append_data
 unsigned_short                      needed_tailroom
 netdev_features_t                   features                    read_mostly         read_mostly         HARD_TX_LOCK,netif_skb_features,sk_setup_caps(tx);netif_elide_gro(rx)
 netdev_features_t                   hw_features
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8fbe3a5d8..9a2a12db1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -309,6 +309,24 @@ struct hh_cache {
 	((((dev)->hard_header_len + READ_ONCE((dev)->needed_headroom) + (extra)) \
 	  & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
 
+/*
+ * Headroom to reserve when allocating a locally generated packet for
+ * transmission through a device. On top of LL_RESERVED_SPACE() this adds
+ * the administrator-configured tx_extra_headroom, folded in before the
+ * alignment so that the link-layer header placement does not change.
+ *
+ * Only use this for new allocations. Code that checks whether an existing
+ * packet has enough headroom must keep using LL_RESERVED_SPACE(), so that
+ * the extra reservation can never force a reallocation by itself.
+ */
+#define LL_ALLOC_SPACE_EX(dev, hlen) \
+	LL_RESERVED_SPACE_EX(dev, (hlen) + READ_ONCE((dev)->tx_extra_headroom))
+#define LL_ALLOC_SPACE(dev) \
+	LL_ALLOC_SPACE_EX(dev, (dev)->hard_header_len)
+
+/* Upper bound for tx_extra_headroom, in bytes. */
+#define NETDEV_TX_EXTRA_HEADROOM_MAX	512
+
 struct header_ops {
 	int	(*create) (struct sk_buff *skb, struct net_device *dev,
 			   unsigned short type, const void *daddr,
@@ -1925,6 +1943,10 @@ enum netdev_reg_state {
  *
  *	@needed_headroom: Extra headroom the hardware may need, but not in all
  *			  cases can this be guaranteed
+ *	@tx_extra_headroom: Additional headroom reserved when allocating
+ *			    locally generated packets for transmission,
+ *			    configured by the administrator. Not a driver
+ *			    requirement; see LL_ALLOC_SPACE()
  *	@needed_tailroom: Extra tailroom the hardware may need, but not in all
  *			  cases can this be guaranteed. Some cases also use
  *			  LL_MAX_HEADER instead to allocate the skb
@@ -2187,6 +2209,7 @@ struct net_device {
 	 */
 	unsigned int		mtu;
 	unsigned short		needed_headroom;
+	unsigned short		tx_extra_headroom;
 	struct netdev_tc_txq	tc_to_txq[TC_MAX_QUEUE];
 #ifdef CONFIG_XPS
 	struct xps_dev_maps __rcu *xps_maps[XPS_MAPS_MAX];
@@ -2758,6 +2781,16 @@ struct netdev_queue *netdev_core_pick_tx(struct net_device *dev,
 					 struct sk_buff *skb,
 					 struct net_device *sb_dev);
 
+/* Same as LL_ALLOC_SPACE() without link-layer header and alignment, for
+ * callers that size the headroom themselves.
+ */
+static inline unsigned int
+netdev_tx_alloc_headroom(const struct net_device *dev)
+{
+	return READ_ONCE(dev->needed_headroom) +
+	       READ_ONCE(dev->tx_extra_headroom);
+}
+
 /* returns the headroom that the master device needs to take in account
  * when forwarding to this dev
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 8eb9bf1ff..a79f55b85 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -13501,6 +13501,8 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, num_tc);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, mtu);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, needed_headroom);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx,
+				      tx_extra_headroom);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, tc_to_txq);
 #ifdef CONFIG_XPS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_tx, xps_maps);
-- 
2.50.1

