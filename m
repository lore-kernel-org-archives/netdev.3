Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490272;
	b=QUsI846pGKSKeL4yapTOkQQq0e7PLlvx/4HPAxtA/XNXLPiBhmz0xzw2aDsXj4KIeX/i
	 x8X6xNVdPEXVsB1/sEoZlWh9P+cZDiQ+Zr7Hbjm3n5Iyk+Y5gcCykXXOWfCEzzld3ImG7
	 GEFVbxo8GasYS00hN55lNsFR9jTyxG+jgikAacYSoPSzi4SwDHxc7a23vo/Ybo/whm9rm
	 X1UqALjmx2paIYvLI/NL1ovJ4DligG5tPjNyaFsbg/HUCprBauZ0VdxGMNUHgG8EJuXfo
	 xYTxFa0Vnw8CB5lgGE1DblW+SzxA+t9tnMCpJGvoCtdMybZbxSWf+NilN+bNAVtr+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490272;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Quk0axz0DyzTLssacbmtoRijw1rjeQJxqK9DvxXLGmU=;
	b=qGDhNUhMbRxYQlfkuydwE/x3Ssbwb+OIq/wEZ5eq6+5ZV350p+TfuITFwgCTzC6197ly
	 OdzAQt5qDkMtqYEHtu/8GqDMu84Y7OQpaGyqM+oGfmQwW01Zhgey0npvCbjYfqiiPyQs3
	 jIOdd2R9LwxV8BM1vfgUVF3Q4o7QzdFTKLDlhNcEyFnY4EDa59nYvZgxso9212Iu6fFH6
	 bFtaf82plAMHjjk2imyTcGGjS4Bub0vbJCLMNbfxmas5t55xSBWMeN8H2phBSDCYf0zCl
	 kRiyKzYbvSERrJ/jN/9vKYRy78umSGMtgAXIY+ngaNBLQhAYJt1yLbHZca/4CJdstkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+1gTzbq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C55606A899
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+1gTzbq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA461F00A05;
	Thu, 12 Nov 2026 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490272;
	bh=Quk0axz0DyzTLssacbmtoRijw1rjeQJxqK9DvxXLGmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V+1gTzbq23byFyTF+wMsp1xEwlSgVcncgyvXNc0YxQLlGWMv3uzGBL/aC/A8+rxL5
	 LWGNZdyfHzcYhFIQAE0xNaKVKH/YTPpWeBGMJ7YC4doKQvCns6aAJe9i4/jB3vsHuy
	 0EFEv6tB2WQ0TacAZnx4buuq1knM42xstr9dgztL61apWTYYnyJOyj7/RbGf3Ur5+8
	 5NCdavCSU4le0i4qWFMs2I5HIyRKW0bzK9a0tVl93o4lh3d8QIu//Zw+tttsqOWzoG
	 QKGWxLBjKk5aFVX/H9IfsI/tbYJjAobZgNwPF6KCEZkvrR4nhEMcDXzwF1IYypxdyy
	 eksFAhjByPhkg==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:34 +0100
Subject: [PATCH net-next v8 19/19] net: ethernet: cortina: Fix ethtool
 statistics reads
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-19-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The TX statistics reader resets p on a seqcount retry but writes through
values instead. A retry on 32-bit systems therefore writes another 18
counters past the end of the ethtool statistics array. ETHTOOL_GSTATS
does not require privileges.

Write through p so each retry overwrites the same output slots. Stop
clearing the fragment counters from the reader, which races with TX
updates and resets the counters on each read. Snapshot tx_hw_csummed
under ir_stats_syncp, matching its writer, and retain its output position.

Found during Sashiko review and checked with an extracted-reader host
harness that forces seqcount retries. The old reader overwrote guard
entries and cleared counters; the fixed reader stays within the output
array and preserves counters.

Tested on the D-Link DIR-685 with intense transfers and ping storms,
reading out stats with ethtool at the same time.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 899d96420b1b..d4aa283ccb7b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2520,6 +2520,7 @@ static void gmac_get_ethtool_stats(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned int start;
+	u64 tx_hw_csummed;
 	u64 *p;
 	int i;
 
@@ -2532,6 +2533,7 @@ static void gmac_get_ethtool_stats(struct net_device *netdev,
 
 		for (i = 0; i < RX_STATS_NUM; i++)
 			*p++ = port->hw_stats[i];
+		tx_hw_csummed = port->tx_hw_csummed;
 
 	} while (u64_stats_fetch_retry(&port->ir_stats_syncp, start));
 	values = p;
@@ -2555,12 +2557,10 @@ static void gmac_get_ethtool_stats(struct net_device *netdev,
 		p = values;
 		start = u64_stats_fetch_begin(&port->tx_stats_syncp);
 
-		for (i = 0; i < TX_MAX_FRAGS; i++) {
-			*values++ = port->tx_frag_stats[i];
-			port->tx_frag_stats[i] = 0;
-		}
-		*values++ = port->tx_frags_linearized;
-		*values++ = port->tx_hw_csummed;
+		for (i = 0; i < TX_MAX_FRAGS; i++)
+			*p++ = port->tx_frag_stats[i];
+		*p++ = port->tx_frags_linearized;
+		*p++ = tx_hw_csummed;
 
 	} while (u64_stats_fetch_retry(&port->tx_stats_syncp, start));
 }

-- 
2.56.0

