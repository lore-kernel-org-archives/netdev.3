Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1A7404E
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771098401; cv=none; b=qL74Ktq+HFjjdnm+zoiTp+o0aqaQT/kEWLwe0wAO7XvgLg29vrCw4qjmRGm9kuqC0WtEjFo8OAluT1ccz8MrNWHLrQK5BruCE1twdN+rVYOFay5TcshGj4oYCNPIxfef4RGGH2jr973isIxrIZpRLu70GWdp95GUrMh5XQXuXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771098401; c=relaxed/simple;
	bh=SKYYQ//N15zwdoL9kLzGlNg53NWrdPo0WnHUwUjm7g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldlUjtG9YI3Z/F8p+K0PNbnMDc/k1P5Wkhl8FiuM53PD9KLu8VB4afhGi1BIs/iTatlBQ5zgLal9aDODJ+aQg1DlDkVQRfb6AM0HL9DjQm5ZzwRifLI0W460vkwN6Vvccdlj5KqP09ZI2//F9thQLA7+Q9KO1LoQlPv4hyc2wvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=I7pYEOQW; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="I7pYEOQW"
Received: from ms-a2 (211.4.31.150.dy.iij4u.or.jp [150.31.4.211])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61EJkckv078694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Feb 2026 04:46:38 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=dW14vW0bCAsIh8E1yS8gm9g3TbcmJP4FXwB0iz6Id9I=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:To:Subject:Date:Message-ID;
        s=rs20251215; t=1771098398; v=1;
        b=I7pYEOQWqHvgSx+cNQls6fJP+/R6yBzAd3ZiTF8Gw0SfdKmtaqIpJwIbbi03IeTM
         5fNNh0xdhhXKnjk7OVa5KPUZw3o9grkre9I8rvXhu2OOmbDaFOP3MMpEqKefduNV
         ko8r5+hIIudTfzQqQSTbNNxeCq1doo0oOsiANaNzApq9zC5HoR9J9yI3JC02ArCG
         64neej+NR/9ARwsrFocUqxN2MkY/sCUWe0UD4HKYl/JzBoybVBfwyCH7M+630uLp
         B0xU3k1J077f5L9nkBvhB7eqXivfS61Wf/5JkWU/JTiVU1Ou0ufccdpUTLjSRZ2M
         UNn7eSbQVACDbysEfkPVIw==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Sasha Neftin <sasha.neftin@intel.com>,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 iwl-net] igc: fix missing update of skb->tail in igc_xmit_frame()
Date: Sat, 14 Feb 2026 19:46:32 +0000
Message-ID: <20260214194636.295647-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igc_xmit_frame() misses updating skb->tail when the packet size is
shorter than the minimum one.
Use skb_put_padto() in alignment with other Intel Ethernet drivers.

Fixes: 0507ef8a0372 ("igc: Add transmit and receive fastpath and interrupt handlers")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1abbdbebf8a4..7ebeca5333b6 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1727,11 +1727,8 @@ static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
 	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
 	 * in order to meet this minimum size requirement.
 	 */
-	if (skb->len < 17) {
-		if (skb_padto(skb, 17))
-			return NETDEV_TX_OK;
-		skb->len = 17;
-	}
+	if (skb_put_padto(skb, 17))
+		return NETDEV_TX_OK;
 
 	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
 }
-- 
2.51.0

