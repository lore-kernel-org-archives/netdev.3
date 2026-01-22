Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36F2F1FE3
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089695; cv=none; b=XBAgFtu3PU3g3m3wJo4jmuYngD6uXkDTep2a5oJHkxS8q8m3AVo0pl+wXoodRY7xmMKBQNbnSzFiwYIJQDeEWnsN2C4nKo0U4iKCOi5EfjfGO15fs7VEk6NP8a639XVwnAjQBni2uGPzZ07cEOQJoa9eopLV14IO86xVgK8E5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089695; c=relaxed/simple;
	bh=g1uheCaK+e+djJ8vvFfgrhkSkZp2jNSheeP5GdJytCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5MQm+9VfqWomM8kvfeg/gvjxiqcQa+ue8OBcb8OHDtZ8E86x4rY9w5NCT/okKpTAPjZ7VWv7Zup5NifuYYOaVPWm+m0x3W/aMTvuOEDYBamgAZLrtplSG6cd04W4VLJZNBHylH5UF8CiKlJIGAcEZReFXNSeAMHBRPFpHWIn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Yoavn74e; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Yoavn74e"
Received: from ms-a2 (79.192.13.160.dy.iij4u.or.jp [160.13.192.79])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60MDmAkd061527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 22 Jan 2026 22:48:11 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=PPx7lBvZdRocqs9Ic7hyxz4MceYROtyFu1Q8VoDJ5rc=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1769089692; v=1;
        b=Yoavn74erfL56Hc73SWC+KaIwCdQtTUPmXZdvsuA+4jlffmNcncKDT2wPpgnvwJt
         5K7UieVXf1Bd9vnZt7t69lsAFiX6q17vsPRLYEqkjFVDVNs5m4IRnbyInGzY85K6
         p5mq38smUAhzkyQ7vHGjb8d8jUfhP0UZNr7cmwYrbkQ0RZF7A3mBe7Cs1Kxp0wP/
         k7wL60/KsW15YVoYL3GQAEzeUh04X6dbZ84dKrYAHE0tWDvg2PJFUzXhh9DlTRjn
         Kre8E0gz1mICF3Hhr2f22qgoU9rtXsJ4fQ4ZVj1T2ivLJlhklYiBrkw8en7nXSOv
         m8fwXhQuBy9Q3GuBV6vR1Q==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2 iwl-next] igb: set skb hash type from RSS_TYPE
Date: Thu, 22 Jan 2026 13:47:46 +0000
Message-ID: <20260122134809.7765-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igb always marks the RX hash as L3 regardless of RSS_TYPE in the
advanced descriptor, which may indicate L4 (TCP/UDP) hash. This can
trigger unnecessary SW hash recalculation and breaks toeplitz selftests.

Use RSS_TYPE from pkt_info to set the correct PKT_HASH_TYPE_*

Tested by toeplitz.py with the igb RSS key get/set patches applied as
they are required for toeplitz.py (see Link below).
 # ethtool -N $DEV rx-flow-hash udp4 sdfn
 # ethtool -N $DEV rx-flow-hash udp6 sdfn
 # python toeplitz.py | grep -E "^# Totals"

Without patch:
 # Totals: pass:0 fail:12 xfail:0 xpass:0 skip:0 error:0

With patch:
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

Link: https://lore.kernel.org/intel-wired-lan/20260119084511.95287-5-takkozu@amazon.com/
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
Changelog:
  v2:
    - Fix max-line-length by removing unnecessary comment
  v1: https://lore.kernel.org/intel-wired-lan/20260119175922.199950-1-kohei@enjuk.jp/
---
 drivers/net/ethernet/intel/igb/e1000_82575.h | 21 ++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c    | 18 +++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
index 63ec253ac788..9e696d55e512 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.h
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
@@ -87,6 +87,27 @@ union e1000_adv_rx_desc {
 	} wb;  /* writeback */
 };
 
+#define E1000_RSS_TYPE_NO_HASH		 0
+#define E1000_RSS_TYPE_HASH_TCP_IPV4	 1
+#define E1000_RSS_TYPE_HASH_IPV4	 2
+#define E1000_RSS_TYPE_HASH_TCP_IPV6	 3
+#define E1000_RSS_TYPE_HASH_IPV6_EX	 4
+#define E1000_RSS_TYPE_HASH_IPV6	 5
+#define E1000_RSS_TYPE_HASH_TCP_IPV6_EX	 6
+#define E1000_RSS_TYPE_HASH_UDP_IPV4	 7
+#define E1000_RSS_TYPE_HASH_UDP_IPV6	 8
+#define E1000_RSS_TYPE_HASH_UDP_IPV6_EX	 9
+
+#define E1000_RSS_TYPE_MASK		GENMASK(3, 0)
+
+#define E1000_RSS_L4_TYPES_MASK	\
+	(BIT(E1000_RSS_TYPE_HASH_TCP_IPV4)	| \
+	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6)	| \
+	 BIT(E1000_RSS_TYPE_HASH_TCP_IPV6_EX)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV4)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6)	| \
+	 BIT(E1000_RSS_TYPE_HASH_UDP_IPV6_EX))
+
 #define E1000_RXDADV_HDRBUFLEN_MASK      0x7FE0
 #define E1000_RXDADV_HDRBUFLEN_SHIFT     5
 #define E1000_RXDADV_STAT_TS             0x10000 /* Pkt was time stamped */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8dab133296ca..ef0cbf532716 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8824,10 +8824,20 @@ static inline void igb_rx_hash(struct igb_ring *ring,
 			       union e1000_adv_rx_desc *rx_desc,
 			       struct sk_buff *skb)
 {
-	if (ring->netdev->features & NETIF_F_RXHASH)
-		skb_set_hash(skb,
-			     le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
-			     PKT_HASH_TYPE_L3);
+	u16 rss_type;
+
+	if (!(ring->netdev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_type = le16_to_cpu(rx_desc->wb.lower.lo_dword.pkt_info) &
+		   E1000_RSS_TYPE_MASK;
+
+	if (!rss_type)
+		return;
+
+	skb_set_hash(skb, le32_to_cpu(rx_desc->wb.lower.hi_dword.rss),
+		     (E1000_RSS_L4_TYPES_MASK & BIT(rss_type)) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
 }
 
 /**
-- 
2.51.0

