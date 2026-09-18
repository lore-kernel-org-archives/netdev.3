Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1510247F773;
	Fri, 18 Sep 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732009; cv=none; b=pow6wdrTnn9HtFKCNiYFGQKO8x3wbAgC4iNSYjfRQZOVRva8w3qMMfgtwkqIyaSn7qWXp8I3mDE8Spx4enatBjQ2iNxJqkHzgXytjGCykCoLK+2k5VSmBU3keGyPoFZMdtzA9yjVjkrJkxBIdSrG4soNbpT4YzhBf8nXyEWNtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732009; c=relaxed/simple;
	bh=4fNFn0YowNP4blKp/blpgTKLm+N4CBvNFKOZrmlshlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RsDX3AdqnHGenstp5xvkNNV4rWsaJAVTxEADQgTyyIsE9rolz19HLIMkR0gV6OmepxcbK1M9DNO/WB+ZLrES3kHSXjUSBIs3HG5HZPe2fHX2AtX62ieIH2sac626zts0pHwShmG1i+7MtOC4pwcGQoDq4vdvgbfOyaOFiV4ShyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWiK8Ajv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWiK8Ajv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D83C1F000FF;
	Fri, 18 Sep 2026 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789732008;
	bh=RbEroX0HQceBPXeoDoSmvNQSdewP03xlcwRxzJgqntc=;
	h=From:To:Cc:Subject:Date;
	b=YWiK8Ajvp89GxX+KApT8Ehen/7e7ZpmhtDU25O+x68pywCRJCxuxxrnueqAsDC799
	 n+UqolDQu1EfJTTesu6d3XHtKWMwfmOzOfnJefOZaIYhzkFXbRYDmH6pOJo5/TDqdc
	 A72ehcg084ODKVh7gr94Pp/JqagV0/wLachB8DbGtFqC376Gdhf6CtyOgR2Qdgf6qB
	 M0w1GoZ21FERWEUReYL5uCyyWkdIObfMrZJEOXR+IrnnpQuOi07G762142oev++1a5
	 8FeMcS4wBzURDAob49+DXS2KZLFZfRZMvngyYQmDOU0EceFAqMTmF80yOAeDpXBhwI
	 PkoqhfBUPXXTg==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Joe Damato <joe@dama.to>,
	Sashiko <netdev-bot+sashiko@kernel.org>
Subject: [PATCH net v2] eth: fbnic: Avoid rounding zero ring sizes
Date: Fri, 18 Sep 2026 13:46:40 +0200
Message-ID: <20260918114641.1281172-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

roundup_pow_of_two() is undefined for zero. ethtool permits a zero ring
size to reach the driver, where the minimum-size check should reject it.

Leave zero unchanged while rounding nonzero ring sizes. The minimum-size
check then rejects zero deterministically without changing the established
behavior for other values.

Fixes: 6cbf18a05c06 ("eth: fbnic: support ring size configuration")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Link: https://lore.kernel.org/netdev/178971206933.22033.236948278674126701@kernel.org/
Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Björn Töpel <bjorn@kernel.org>

---
v2:
- Preserve rounding before minimum-size validation for nonzero values;
  Sashiko found that v1 rejected values which previously rounded up to a
  valid size.
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 0e47088ec44b..f68936e5558b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -313,6 +313,11 @@ fbnic_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	kernel_ring->hds_thresh = fbn->hds_thresh;
 }
 
+static u32 fbnic_ring_size_pow2(u32 size)
+{
+	return size ? roundup_pow_of_two(size) : 0;
+}
+
 static void fbnic_set_rings(struct fbnic_net *fbn,
 			    struct ethtool_ringparam *ring,
 			    struct kernel_ethtool_ringparam *kernel_ring)
@@ -334,10 +339,10 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	struct fbnic_net *clone;
 	int err;
 
-	ring->rx_pending	= roundup_pow_of_two(ring->rx_pending);
-	ring->rx_mini_pending	= roundup_pow_of_two(ring->rx_mini_pending);
-	ring->rx_jumbo_pending	= roundup_pow_of_two(ring->rx_jumbo_pending);
-	ring->tx_pending	= roundup_pow_of_two(ring->tx_pending);
+	ring->rx_pending	= fbnic_ring_size_pow2(ring->rx_pending);
+	ring->rx_mini_pending	= fbnic_ring_size_pow2(ring->rx_mini_pending);
+	ring->rx_jumbo_pending	= fbnic_ring_size_pow2(ring->rx_jumbo_pending);
+	ring->tx_pending	= fbnic_ring_size_pow2(ring->tx_pending);
 
 	/* These are absolute minimums allowing the device and driver to operate
 	 * but not necessarily guarantee reasonable performance. Settings below

base-commit: 46bc52d13594848023e681860df8700c8db14354
-- 
2.55.0

