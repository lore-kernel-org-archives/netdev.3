Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AE18FC97;
	Sat, 11 Apr 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775905298; cv=none; b=M0ZPPVBN81rtdvAskROO6CKBVCQw1KKPjXCdNhw+0zFfi54T0FsSaAsEvdCmtexAVfp2gb9fAIx2hQqnRvIb5kRpVBdY9YlCn6Rfx753PRs8qD6hVAzaXrZtD/1EsthjqzExSu6lPMkLf/A2NAFrcSXjjWFaL7XMIHxlXIPzV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775905298; c=relaxed/simple;
	bh=KN0AElghClonVn/O/t5fhjTuq5WifeatC0AGEHwvdYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9odGQdVGR77s4fCWcF8qM1YD+gz6C4QiyhlmruKfrEjNLJuYJx7jzZG2SLTM5FrKg98OCuZsbgxgAL8b9cEoL9wW73sVY+I/Sk2LvUmIoRxcBpztu3W7FyU0og0HBk01Pw3gW9He81xQQ5lq/p/aBnTendhr32dc9PRQyiYYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a9U8RxbD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a9U8RxbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDAFC4CEF7;
	Sat, 11 Apr 2026 11:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775905298;
	bh=KN0AElghClonVn/O/t5fhjTuq5WifeatC0AGEHwvdYI=;
	h=From:To:Cc:Subject:Date:From;
	b=a9U8RxbDm4dRV8/D48n69etgi2b9a3qqtKm0GA24QEjbP0S7CsohXbhLPR5zIRZSV
	 iMjj8mmTLJzTXGtAQUoIieukzxXw07dKFqZQF/rJX93h0JMva8/RGd33CRib3zwJsT
	 p+uEcq35FOIpijPoTkrTo2CxXbP84Q0F3od4pWew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
Date: Sat, 11 Apr 2026 13:01:35 +0200
Message-ID: <2026041134-dreamboat-buddhism-d1ec@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=KN0AElghClonVn/O/t5fhjTuq5WifeatC0AGEHwvdYI=; b=owGbwMvMwCRo6H6F97bub03G02pJDJm3tPh+qGdFfbjz886GxNW9y3VnC13X/7quq8ByokPy0 jaZa6nHOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi/+UY5mlYK3PabP6Vvca3 6El3rP4U2xuXJjHMM7seIa8kGMMazVjp/j5axL2c5bs4AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

A malicious USB device claiming to be a CDC Phonet modem can overflow
the skb_shared_info->frags[] array by sending an unbounded sequence of
full-page bulk transfers.

Drop the skb and increment the length error when the frag limit is
reached.  This matches the same fix that commit f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path") did for the
t7xx driver.

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc-phonet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc-phonet.c b/drivers/net/usb/cdc-phonet.c
index ad5121e9cf5d..165650ecef64 100644
--- a/drivers/net/usb/cdc-phonet.c
+++ b/drivers/net/usb/cdc-phonet.c
@@ -157,11 +157,16 @@ static void rx_complete(struct urb *req)
 						PAGE_SIZE);
 				page = NULL;
 			}
-		} else {
+		} else if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					page, 0, req->actual_length,
 					PAGE_SIZE);
 			page = NULL;
+		} else {
+			dev_kfree_skb_any(skb);
+			pnd->rx_skb = NULL;
+			skb = NULL;
+			dev->stats.rx_length_errors++;
 		}
 		if (req->actual_length < PAGE_SIZE)
 			pnd->rx_skb = NULL; /* Last fragment */
-- 
2.53.0

