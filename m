Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412284;
	b=1SnHf4oQXa5Z7+Kkx6WGDEIiBNiY40BfM81Oo4ibLWUASJZdr9xQoL2Rmi4jUDKIB4Ut
	 hQo3xAsOe1fNmZHSKSdlIoMEwj0s0WpgmxcWm3Yg2rNuQIQLKCyLChdA1wxP3cwZYUDs0
	 rHyjTvgc0Vqyf9Jg6C28C2KcD0XSVTBQrvwkUWsVPtGHehO2bSGKJNJgiUA1STXWbaZc6
	 WPveKQNOynM1hGhufLrBqPImoNkmd10ZMlPiyTMoFekRvyeJ6W7yDDW4e8ygWMccBrLQ4
	 Fay0NbEp9L9xGJ2QJ121ZK9mY8oYhFDalSNEP+WGv/c7484zoAynKypf3XeYzFaJ4dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412284;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lQUW5snm4BubDrPXwBB6vcUDU9jpmRBo2GS+Q9VFm1c=;
	b=z7ZS+yNk6TxFs1A8H0Ev87/tu0JBHBnTdxOb/1TxqD7CTJ5dvYi8GBs5AhG7yLWTzZ+4
	 Io9PMOFDpiIuwwR/CwXV00DKIY4QwdjIYahQQ/vchkEPdK+2U2x5+cxHYLZkyV59gYUG7
	 evFaEy2GUsA8NG+tydJ24C93QBUbAL948EbBsY0a8zw0S0CHOmKX3wiPB0OcijU/WW+k9
	 2qyu0VwTPUFQttV3ODR9ydn8KYyQ6AsMaZXtZZ9RobwD9s5w7KaDLMFrXHI/zvhtNfcoa
	 EMgdXWjuCfArQ33IvqcXpobPkv2cXIYMPGrug0UCVWZw65wNm+TEVR2hNwurPE9Vo6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XdnNg4Xv;
	arc=none smtp.remote-ip=95.215.58.118
Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41212606A886
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 15:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41212606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XdnNg4Xv
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s1VwpcP/dz4nq03uPjecpk7ZarelKymnfAfgC0pwpXE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794412281; v=1; x=1795017081;
 b=XdnNg4XvczP+MUYL6fBRk/qG+WJcMe8D2B1rWZvl8ZeHST00FcC4MH/pboCrGW4Fkbz/BMOm
 IIFLXw+m7jYP6T5N0iVuLiu63BxUeYoMnMh231nH9LDfUP9YLA5Dnf748fb3B7fmBQ+2eYUyvyN
 2mjvYTrHaNGjo1b3PNR0YhSA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4c398bc68f558887;
	Wed, 11 Nov 2026 15:51:21 +0000
X-Mizu-Trace-ID: 4c398bc68f558887
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Tristan Madani <tristan@talencesecurity.com>,
	Taegu Ha <hataegu0826@gmail.com>,
	Norbert Szetei <norbert@doyensec.com>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sashiko <netdev-bot+sashiko@kernel.org>
Subject: [PATCH net] ppp: restore uncompressed fallback during CCP negotiation
Date: Wed, 11 Nov 2026 23:51:11 +0800
Message-Id: <20261111155112.149204-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ppp_ccp_peek() enables SC_COMP_RUN when sending a CCP Configure-Ack,
before userspace sets SC_CCP_UP. Data traffic during this window can
reach pad_compress_skb() while CCP is still negotiating. If compression
succeeds, len is positive, but the SC_CCP_UP check fails and the packet
falls through to the error path instead of being sent uncompressed.

Deflate and BSD-Compress have already advanced their compression state
by then. Dropping the packet can desynchronize with the peer's state,
causing decompression errors.

Restore the uncompressed fallback for non-MPPE compressors when len is
positive but CCP is not up. Sending the original packet lets the peer
update its decompression state. Continue to drop packets on negative
compressor returns, and preserve the existing behavior for CI_MPPE so
that encrypted data cannot fall back to plaintext during negotiation.

Fixes: b3f9b92a6ec1 ("[PPP]: add PPP MPPE encryption module")
Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://lore.kernel.org/netdev/179339596607.3131.10030375792154782283@kernel.org/
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
Reproduced on a WSL2 host running 6.18.58 with an async channel and
Deflate configured: the frame sent in the negotiation window was dropped
(tx_errors went from 0 to 1), and with this applied it leaves as an
uncompressed PPP_IP frame and tx_errors stays unchanged. The frame sent
after SC_CCP_UP is set is compressed with sequence number 1, which is
what a peer that fed the uncompressed frame to incomp() expects.

Diagnosis, implementation and local reproduction are assisted by Codex.
---
 drivers/net/ppp/ppp_generic.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 29847dc4bb45..d3e551a3c80b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1747,18 +1747,15 @@ pad_compress_skb(struct ppp *ppp, struct sk_buff *skb)
 		skb = new_skb;
 		skb_put(skb, len);
 		skb_pull(skb, 2);	/* pull off A/C bytes */
-	} else if (len == 0) {
+	} else if (len == 0 ||
+		   (len > 0 && ppp->xcomp->compress_proto != CI_MPPE)) {
 		/* didn't compress, or CCP not up yet */
 		consume_skb(new_skb);
 		new_skb = skb;
 	} else {
-		/*
-		 * (len < 0)
-		 * MPPE requires that we do not send unencrypted
-		 * frames.  The compressor will return -1 if we
-		 * should drop the frame.  We cannot simply test
-		 * the compress_proto because MPPE and MPPC share
-		 * the same number.
+		/* A negative return means the original packet must not be sent.
+		 * Also prevent MPPE/MPPC from falling back to plaintext while
+		 * CCP is not up.
 		 */
 		if (net_ratelimit())
 			netdev_err(dev, "ppp: compressor dropped pkt\n");
-- 
2.34.1

