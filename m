Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B13391826
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774850433; cv=none; b=QoMAZr6lQsqIocoaVyTr96Yc+4Fd++9aaqwJOhlUwPFwP2HwHHZh6dm0nf6ZP240+WmXoA2VwFMkcJpP92n3Etw2VMpwlXpBRrXsFMrGkSrSjzTJXy9JPELGdVwN3ZQWq3dL0WPBDCNqlFxUbQNIUFR7uMPmV98wYlxW5qbCKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774850433; c=relaxed/simple;
	bh=MtA7daWwhSx1HAEKj0tFdWyfwEFe4uO0E13RPKrKK7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z/E83/Q4shNR0i593eDSjK9OstOcIwmwiC9+J5qx7I5jcSxHpAKKVgqqx2cFSESvC5USvf7ODuSESc9cCYXL5aGLRmt5DoD8STCGv+iFm2fOsDYsnMu72pLwXZOOlD/gkSuj2SHuPRydwnTpYPy2z0OB9BA8YqJUSi+v2BqF7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjhY0RdT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjhY0RdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36EBC4CEF7;
	Mon, 30 Mar 2026 06:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774850432;
	bh=MtA7daWwhSx1HAEKj0tFdWyfwEFe4uO0E13RPKrKK7Y=;
	h=From:Date:Subject:To:Cc:From;
	b=OjhY0RdTwTvuePNbdDFzhk1G/jRqkif/pIizSXYqQ7ElK4XQk5FXWwY2IAIvht6tX
	 24vhCXP6Rhi2Scz9hDwK7H1Ct16X0JGMUWGnHP5KgY2fPyJEUHpajvxJYGFcvJ0gz8
	 l9CXYNU7yfMfTs20SaTidM81dArhPx4PpFJcoB+aC2/zYxCh1pUoDF/KVAzRQYfG5+
	 q1/Tzb/SnXMe+gny0ki3sbR+B1lSJSQPTkll4bJF0Yc1BsLsXMqrje+rKJLeH/CZNF
	 3lf85msSpnKF6/YT45VISMknysxjRFtKbrJFFXUy23ijVJ6L7YEmDgUeI3DizwjLA6
	 lEBl7W5vFt1+g==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 30 Mar 2026 08:00:29 +0200
Subject: [PATCH net] net: ethernet: cortina: Fix SKB leak
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-gemini-ethernet-fix-v1-1-18783a45d13a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAwEvyI5G6itivgV8VDqqjlYpRURxL8bP
 M4yOw9lJEGmvngo4ZIse1SoyoLC6uMClkmZrLGtcc7wgk2iMM4VKeLkWW5uTR1sFxo3+Yr0eST
 o/FcHUonG9/0AqHSZoGoAAAA=
X-Change-ID: 20260330-gemini-ethernet-fix-604c28c53da1
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, 
 Andreas Haarmann-Thiemann <eitschman@nebelreich.de>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

From: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>

Under sustained RX load (e.g. large file transfers over the network), the
device freezes completely and requires a hard power cycle. No kernel panic
or oops is produced; the system simply stops responding.

In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
gmac_get_queue_page() returns NULL for the second page of a multi-page
fragment, the driver logs an error and continues — but does not free the
in-progress skb that was already being assembled via napi_build_skb() /
napi_get_frags():

    gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
    if (!gpage) {
        dev_err(geth->dev, "could not find mapping\n");
        /* BUG: skb leaked here */
        port->stats.rx_dropped++;
       continue;
    }

This path is distinct from the similar block in gmac_cleanup_rxq(), which
correctly only logs "could not find page" without an skb in flight.

Each occurrence of this error path leaks one skb. Under sustained traffic
the leak exhausts kernel memory, causing the observed lockup.

Free the in-progress skb via napi_free_frags() before continuing, matching
the pattern already used elsewhere in the driver.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 4824232f4890..723d90d5fdf3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1491,6 +1491,10 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
+			if (skb) {
+				napi_free_frags(&port->napi);
+				skb = NULL;
+			}
 			continue;
 		}
 		page = gpage->page;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260330-gemini-ethernet-fix-604c28c53da1

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

