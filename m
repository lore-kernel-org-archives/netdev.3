Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E61B78F3;
	Sun, 22 Mar 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138762; cv=none; b=DvZECw8YYxxZEXys5tZu+ELvp2Xg6rpkj6Uy8/eHzUngO14v9H4/GnqmqSspq5hIjANqqAzfRgjPzdq18LiPVjJpZKaPBujvyyq9sQ63k+UEdI2xLPHgl+7FXEEAViop78UC2darGGCFU/aQmmq9+Quy/CIE9k7LflxG10ODVZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138762; c=relaxed/simple;
	bh=yGTMh/T2wls5jfEzB620tAzBxCxrKkPe+DadsKTqBEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkoEiYpWdPtYF8Oq9NSW5neCRsMrujFvMhcjNdxSCJXKClkAHarhe32RF+PuDp8krZR2HWcGfRErYSete5tKhwuJL3vLGUaA4D4V7Z8LHpBEG+ZixKwed3SWnGcRfDhKbkK7aQtHI5xrK5hZpR4mpykNCNTe5FT4/fcUTp5upnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w46XE-000000001Oe-1iEB;
	Sun, 22 Mar 2026 00:19:16 +0000
Date: Sun, 22 Mar 2026 00:19:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v6 3/4] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
Message-ID: <4c5305a1ac8ed58a1218f376612e8fb71d9b4d61.1774136876.git.daniel@makrotopia.org>
References: <cover.1774136876.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774136876.git.daniel@makrotopia.org>

The MxL862xx offloads bridge forwarding in hardware, so set
dsa_default_offload_fwd_mark() to avoid duplicate forwarding of
packets of (eg. flooded) frames arriving at the CPU port.

Link-local frames are directly trapped to the CPU port only, so don't
set dsa_default_offload_fwd_mark() on those.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v6: no changes
v5: move link-local check before dsa_strip_etype_header()
v4: no changes
v3: no changes
v2: don't set dsa_default_offload_fwd_mark() on link-local frames
---
 net/dsa/tag_mxl862xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
index 01f2158682718..8daefeb8d49df 100644
--- a/net/dsa/tag_mxl862xx.c
+++ b/net/dsa/tag_mxl862xx.c
@@ -86,6 +86,9 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
 		return NULL;
 	}
 
+	if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
+		dsa_default_offload_fwd_mark(skb);
+
 	/* remove the MxL862xx special tag between the MAC addresses and the
 	 * current ethertype field.
 	 */
-- 
2.53.0
