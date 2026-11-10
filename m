Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348854;
	b=U2+rDcwR4aY627YC7u+zryCxRk3UPuXFQQ/BOA91n0o+mzKKCzNjzy9rT8hif0qaWB/x
	 OASaxt7TUyMjAZ72c7KYb46nT79g6hq1r0fnncTDsGAdTFvEea9QXNkMY5D9wWhqfGaPy
	 RQXgnURed3H42aRbJ1S986fLea64ECJxx+owd3ZvQV4X9ajW7GKW4zOIx6xOuoc1EAmtJ
	 q4FjBfieq9dyfYVyQPrfnw8Y5ukaA2gNhh0ibZWPcge0MSaJLDq3RxdJ8h/3zvcKAqidY
	 pvGzI9kiMkh9P0EZmJbycRjRYPNoV4wtbRJWQD3g/nkbxlchUKu0vJFHNTRrxH1pa7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348854;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ipOVGl3yLVo1UiASl3+4WMedgv0UE7c6VM/RwbbR3cI=;
	b=mxf5+7phn6i0ed4VXZVAUZt5/RXh0vLZ/t+ddQaWbjott9czkhkKbYfT4togmhoPKZr8
	 6vnC7+mRH7ON6CthM0dv6mez+HFtWREZAlMw01ibISkH6fk/hO5MkFNP1iBs8+iHelSmp
	 3+WrH0+prj9BMxMUHvxkTcmMumGjuc2593e9qCnWHsMus9AgGJotl6OvBeMsOaE/xO1p7
	 mknA89fI/0a5v0WX6Cv0HDtgOtuTmBICMdqj36+XQZEY9yjsqjkmQpXggo6HjsUJ4JILR
	 BfiQHIqagAF7yTpnDaiasYDmetKjgYggzfvEGK8WjlBkUb9v6B3gTQD8SqYOqjrKZtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mNt/+IB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B7606A335
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNt/+IB/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CEE1F008BD;
	Tue, 10 Nov 2026 22:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348854;
	bh=ipOVGl3yLVo1UiASl3+4WMedgv0UE7c6VM/RwbbR3cI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mNt/+IB/dYFgx8QgdhUMkDr2USAFi5l0+rEiTbHHxBfjNjI/ojnSyARwKlG4wDBRC
	 xlWFX6EKGuyUEkqgpSycWf6Z+7GhaQZCL1CvTS3gzPHE9QvAggTJ0WZIa0LMQIDFLW
	 MtcH1bWvc+kEZHlT+402V/p1xRXDvgi8efvGmUbeFTBEVb5+w0+mXSBkv1cLsMj45n
	 UBe2EZKj6dIRCBTpud32I883us+xzPKbns2QWJugykxboJHRG19Y8VOLzDO5aFxlyo
	 6tWeVELCsug3eNmSIV5GzxQqTwkzt3F7dA5HSaC46tvylu5HhRSxTlSmNsB22J7SbT
	 RNyUAL0nUXNXQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:33 +0100
Subject: [PATCH net-next v7 18/18] net: ethernet: cortina: Fix ethtool
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-18-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
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
index 1007fd54cb05..b586205a7e20 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2478,6 +2478,7 @@ static void gmac_get_ethtool_stats(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned int start;
+	u64 tx_hw_csummed;
 	u64 *p;
 	int i;
 
@@ -2490,6 +2491,7 @@ static void gmac_get_ethtool_stats(struct net_device *netdev,
 
 		for (i = 0; i < RX_STATS_NUM; i++)
 			*p++ = port->hw_stats[i];
+		tx_hw_csummed = port->tx_hw_csummed;
 
 	} while (u64_stats_fetch_retry(&port->ir_stats_syncp, start));
 	values = p;
@@ -2513,12 +2515,10 @@ static void gmac_get_ethtool_stats(struct net_device *netdev,
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

