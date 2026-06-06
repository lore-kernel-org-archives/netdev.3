Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8294305676;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780724569; cv=none; b=TqYe2HZnMrfUfTWLDFzWI9ly0FlmpIIF5ykBhwxjTtHpDecKSmGHojQ4gQQTjS+h1cxn1Waf8TLmvZFs1KNjUtI0jZp08xyuKAzWFlHt/XNetK5E6GDcOOfdTeztSDlmqAsIscUfNGZJx3UZ9TqPv+OS6aDmOORGuS5oK2AtfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780724569; c=relaxed/simple;
	bh=pZvTlPEHnVoq7eY/dHY7MDK1DnQZ3Ydm8xyowN1LaiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK78hi6cf7aEOQXD7oH+cnTOCwCzicZihcxfaoqTRgEkaQOYEoPFpQh5+4STuYTwsew9+JeoQbUffBfT1XqXL6tKahkhH3FLkqY5NsFkMCANMNlL0ZwGArCGYcDy3WoVV6GB1lt7fJhr7sfLp0UbngsZZOWyEjthtQyzm+HHUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I29lxOed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I29lxOed"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9EEDDC2BCFD;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780724569;
	bh=pZvTlPEHnVoq7eY/dHY7MDK1DnQZ3Ydm8xyowN1LaiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I29lxOedxsboQnhEI0SONS1bEEYZBrkNjQ90YqRMstupDQE5n3OgIN+2LpQmMKwBJ
	 OrXvj9ASj2AkNi1oQzASF46bF6VWnm7pl16m+QkwvZoFOjOZKkiFKvFGBN7yQjlK6E
	 iTRnZp0fxSCP7uaVUz8jMFAjqOmmoIowC5IBtPDCKTL4bzMe+UIX/2RKrkIZqjM0Qc
	 n+ktvTeOmO2Nj5k3y38E4CispczWJOSHTzmAOyTBhEZ8qSN3rnfgOOKqs47yK9NK4i
	 CiGl7ryykkGOQm6fylxlKmPsu889zcxs4VjnR6/QQrOLITg4j+GzowOfhJA3aj3hze
	 gdbPVBRwtzzKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E6CD8C90;
	Sat,  6 Jun 2026 05:42:49 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 05 Jun 2026 22:42:39 -0700
Subject: [PATCH net-next v4 08/16] net: ethernet: oa_tc6: Remove FCS size
 in RX frame
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-s2500-mac-phy-support-v4-8-de0fbc13c6d8@onsemi.com>
References: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
In-Reply-To: <20260605-s2500-mac-phy-support-v4-0-de0fbc13c6d8@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780724562; l=1396;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=Nwz8ph63R7fgKGIZDndf/9epwjHtj0F853lNYFbk53o=;
 b=EkPoE0N561Rn6mpFwlh2B8OkMCBA4T9JKP5di9atN9IusrrG4l799ud9ZyAEVXZYpc5C9VJS3
 +mSc/YXu2pyAT0kjQIiCQ85m8Tqggx1D5x6K486h+gwMsU2u0b79nSm
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

OA TC6 MAC-PHY appends FCS to the incoming frame.
It is removed from the frame before being passed to the stack.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 drivers/net/ethernet/oa_tc6/oa_tc6.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6.c b/drivers/net/ethernet/oa_tc6/oa_tc6.c
index 2f9ace655e81..26033373f16f 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6.c
@@ -782,12 +782,22 @@ static void oa_tc6_submit_rx_skb(struct oa_tc6 *tc6)
 {
 	oa_tc6_update_ts_in_rx_skb(tc6);
 
+	/* MAC-PHY delivers each frame with its Ethernet FCS attached.
+	 * Strip it before handing over to the stack, unless the user
+	 * has asked to keep it via NETIF_F_RXFCS. Keeping the FCS
+	 * in the frame is harmless for IP traffic, but is parsed as
+	 * a (malformed) suffix TLV by PTP, which makes ptp4l reject
+	 * every message with "bad message" error.
+	 */
+	if (!(tc6->netdev->features & NETIF_F_RXFCS) &&
+			tc6->rx_skb->len > ETH_FCS_LEN)
+		skb_trim(tc6->rx_skb, tc6->rx_skb->len - ETH_FCS_LEN);
+
 	tc6->rx_skb->protocol = eth_type_trans(tc6->rx_skb, tc6->netdev);
 	tc6->netdev->stats.rx_packets++;
 	tc6->netdev->stats.rx_bytes += tc6->rx_skb->len;
 
 	netif_rx(tc6->rx_skb);
-
 	tc6->rx_skb = NULL;
 }
 

-- 
2.43.0


