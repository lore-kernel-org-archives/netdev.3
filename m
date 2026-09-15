Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815B4AA3F9;
	Tue, 15 Sep 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495956; cv=none; b=k2ZNh64Huw+ojz1NBi5kRDCiB/GgOIlz2xlTzZ6Tk2+EMBIldGyYf3vctc/S+7agcsxcKw1vWD+q4SnEHbNfO1AnbNbbxg6UCevVptLQ6N0+L2tD1+6VyHAYgl/Gy6tGtrtWyNsA/tGKHrthocbdzOPKDm0aQRXkhoSiJR/70nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495956; c=relaxed/simple;
	bh=RnCXiFbM1SzdFNCgrQuTjcDJhm67a4cNz7MJMWzIUgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3gAWCtA9mSVcfe+N7aXA7ldWbd2BlAr0PO8CEGBjUedPFyzBeamOuUXIRNmwcHI27wipVpIKgH/E8ryGMNM1zMybv8ot8RQyAjwfDNSl5/5sA+x/quTZ6NEypGdVZvJiht+rX8N9GZAGs+Y7G6vF5K9rLkLSw2LkThYd7OJKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIGdbwmP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIGdbwmP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8951F000FF;
	Tue, 15 Sep 2026 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789495955;
	bh=a7qVEHbdpDwDEc6vbWRx6TlbgYFck6ZMDFAc44J1FgI=;
	h=From:To:Cc:Subject:Date;
	b=aIGdbwmPoXxDzXMHFjsBlYMzGiKvMePyCVlFZNCCIV2u1VoZqRgrJeaHEQiFNb1dK
	 PVv4mb5l3UOjFk0X8pFHLvOL2LrVWBxcHC1DNbCRwVGpv1C/bSC9lp03dm55L3kGEc
	 INyFaul+at8pYMY434kfNzS6waFckedM2ppvIv2NeVOwdO+mf4fyCfug7QM5t2g2B0
	 hMGQjOzBe6rJgP8naEM9ArPsCQ1N9cumpsIugFQiKhO6Hx6NsBtNogXpEU59pJf9T+
	 YUsmu3UpujbOKnTGM600wiRRGLd8uUGtLdByXYDoPzyJRKFCHiFA06hwI/yvc/HknU
	 ITifVwzm/1cFQ==
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
	Joe Damato <joe@dama.to>
Subject: [PATCH net] eth: fbnic: Avoid rounding zero ring sizes
Date: Tue, 15 Sep 2026 20:12:27 +0200
Message-ID: <20260915181229.4159158-1-bjorn@kernel.org>
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

Validate the requested sizes before rounding them so zero is rejected
deterministically.

Fixes: 6cbf18a05c06 ("eth: fbnic: support ring size configuration")
Suggested-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 0e47088ec44b..8954fcd08cb3 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -334,11 +334,6 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 	struct fbnic_net *clone;
 	int err;
 
-	ring->rx_pending	= roundup_pow_of_two(ring->rx_pending);
-	ring->rx_mini_pending	= roundup_pow_of_two(ring->rx_mini_pending);
-	ring->rx_jumbo_pending	= roundup_pow_of_two(ring->rx_jumbo_pending);
-	ring->tx_pending	= roundup_pow_of_two(ring->tx_pending);
-
 	/* These are absolute minimums allowing the device and driver to operate
 	 * but not necessarily guarantee reasonable performance. Settings below
 	 * Rx queue size of 128 and BDQs smaller than 64 are likely suboptimal
@@ -368,6 +363,11 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	ring->rx_pending	= roundup_pow_of_two(ring->rx_pending);
+	ring->rx_mini_pending	= roundup_pow_of_two(ring->rx_mini_pending);
+	ring->rx_jumbo_pending	= roundup_pow_of_two(ring->rx_jumbo_pending);
+	ring->tx_pending	= roundup_pow_of_two(ring->tx_pending);
+
 	if (!netif_running(netdev)) {
 		fbnic_set_rings(fbn, ring, kernel_ring);
 		return 0;

base-commit: 18a6fe05fb6e18de29fa90d388bb34044114b3d8
-- 
2.55.0

