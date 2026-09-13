Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0539DBF5;
	Sun, 13 Sep 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295307; cv=none; b=mTypRJZTYF7CDgZsWJe6TwGae6YuA+rfLj9mdIhoe+HsOnUIvVXL4TQT3eh70YB939qf9RIe1z1EM6fDElN8odDr0TEIvS2NQ3IA3/8/0MyBJVj6cpjxlW0zcrjh4gY2Cqsv/HDHf6OHbnnOiNpRu6y/AHqEwUeWGvPlbaSx4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295307; c=relaxed/simple;
	bh=w7DxQbYHB4Ks41r9Cozp+WMw8cRef5vIhf8mK7mh86E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uNy9ZM7HD1JQUXh5/DAtBHfwdxQVmXP+2qLjBRx/QsTNec9iOKSfwTPMCuxQ4dyQb4arD3s8RmLEA+1aHTWOFKTMKEm7Xx0UW/G0y4LI4zuf70LZyUy+DlmRUg8m9LdH5CYprAs4o+yjMVb8vI9vO56Cvk/+6nF2w7bg0pWPZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP6UQOMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP6UQOMO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EC8AC2BCF6;
	Sun, 13 Sep 2026 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789295304;
	bh=w7DxQbYHB4Ks41r9Cozp+WMw8cRef5vIhf8mK7mh86E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=uP6UQOMORbhp15K49pTGDe5oL+OE7WiDjSltBYlzaUaS5bMN38UFFYtwNGIXUKFar
	 MdODW2Cvoa0ZAzeDA/+OucBX5/FmNdcd4ATli86OK2zxp2gtapkueB5WTEcA6umbRa
	 Dx6WFsgXXXgFFhakulLmbG84dX3R0i3Lda0rqxH5k/n61FlXZiJiEL+3gSyDxi/d8a
	 MOL2IDgd3+6JgmCdLW0pHtjqPBEkTZ00gw7qUYN8fI7qXnU5xTjlfl22ikUuYhzGNh
	 hEg1ar0y99ylWVZsG17puCD6mJv0EBB9mjEc7g2t/WZBibKkMaiCM4G3mM0bKYnl5F
	 HVy35ZypRUGnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1FFC88E5A;
	Sun, 13 Sep 2026 10:28:24 +0000 (UTC)
From: Mark Amirkan via B4 Relay <devnull+markdamirkan.gmail.com@kernel.org>
Date: Sun, 13 Sep 2026 10:28:08 +0000
Subject: [PATCH net] net/packet: clear RX owner on VNET header error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-b4-send-packet-vnet-v1-1-5545ffb528ae@gmail.com>
X-B4-Tracking: v=1; b=H4sIALh6pmoC/yWMwQqDMBBEf0Xm3AWNQbG/UnpI4tpuC6lkVQriv
 3fbXgbeMPN2KBdhxbnaUXgTlVc2aE4V0j3kG5OMxnC16+qhaSl6Us4jzSE9eaEtW7Qu+n7ofOj
 TBHvOhSd5/6wX2ADXf6lrfHBavj4cxwegs1g/fAAAAA==
X-Change-ID: 20260913-b4-send-packet-vnet-32b47964a7cf
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Jon Rosen <jrosen@cisco.com>, 
 Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789295303; l=1552;
 i=markdamirkan@gmail.com; s=pscsi-20260818; h=from:subject:message-id;
 bh=SpkUVWFs7UgiCwTRaWHfiD7eoNnej/IW1o2498FsgqQ=;
 b=PFXW4r/vjPDIxLlvD/wYPWPn7lQoJpU/6skFOK8D3zB9pvEu4uwHHa2q741VwUVdX3bjXuOuk
 FkLst3L+WbXCxAtAJx+ywUIIDKrdiyCjqbOFv6anzkZVNinY1hr8JZb
X-Developer-Key: i=markdamirkan@gmail.com; a=ed25519;
 pk=/wb49ibt4gZFDncmhFQBYtjPvzT1tfJtvK4Mqt1P2Wc=
X-Endpoint-Received: by B4 Relay for markdamirkan@gmail.com/pscsi-20260818
 with auth_id=961
X-Original-From: Mark Amirkan <markdamirkan@gmail.com>
Reply-To: markdamirkan@gmail.com

From: Mark Amirkan <markdamirkan@gmail.com>

Commit 61fad6816fc1 ("net/packet: tpacket_rcv: avoid a producer race
condition") added rx_owner_map and made tpacket_rcv() claim a V1 or V2
ring slot before converting the virtio-net header.  If the conversion
fails, the drop path leaves the slot claimed.

With a one-frame TPACKET_V2 ring, an unsupported UDP GSO packet leaves
the only slot unavailable, so the ring also drops the next valid packet.

Clear the ownership bit on this error path.  TPACKET_V3 already clears
its block state here.

Fixes: 61fad6816fc1 ("net/packet: tpacket_rcv: avoid a producer race condition")
Cc: stable@vger.kernel.org
Assisted-by: Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>
---
 net/packet/af_packet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 76bde7906d..50cae32ae2 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2384,7 +2384,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
 				    sizeof(struct virtio_net_hdr),
 				    vio_le(), true, 0)) {
-		if (po->tp_version == TPACKET_V3)
+		if (po->tp_version <= TPACKET_V2)
+			__clear_bit(slot_id, po->rx_ring.rx_owner_map);
+		else
 			prb_clear_blk_fill_status(&po->rx_ring);
 		goto drop_n_account;
 	}

---
base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
change-id: 20260913-b4-send-packet-vnet-32b47964a7cf

Best regards,
--  
Mark Amirkan <markdamirkan@gmail.com>


