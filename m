Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6792FD69E;
	Fri,  1 May 2026 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617175; cv=none; b=RifVZItf2aXqyDVB3rJWh6RthrhKuGA0c/9kKQS0gnleKKt25qVDA4Tw121WH78z/H7YByOE5K1w27ivhkUUyNPjfuMyAyiEc7Be5OsJ7NVousGFUjrWRxdeTcjNLUDoecOC6EqKk812UPzy0RL2d5zndpvlfCU7DPAwDJmI6G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617175; c=relaxed/simple;
	bh=LEfRwxPXqszdGmAcwFbZYAfj8/eMmVsN0t8giE59HVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aexzvn8tnxNkXWllMtEjhc6KtRkPReeaSqdNUb6dUF6eUC133V3U9wVvBb+ongFNyxKwmoO9jdLnxieU1jW6knZsJQH0UmsPtQf8gz/myyAFgoR6+i/4rWdZI/NLdcSx8uCfiopN5+XcgJojOrXI/Vq8OSfZiLyVckJ+rmnn1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=fO1pfL7c reason="key not found in DNS"; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="fO1pfL7c"
Received: from Kyren (unknown [49.207.224.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4g6LnV0LwPz2x9D;
	Fri, 01 May 2026 06:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1777617168;
	bh=ECBkfEoyAYFKvgkf5XccPkJZ00RujU8mtX5aGSijlSg=;
	h=From:To:Cc:Subject:Date:From;
	b=fO1pfL7cajuJmY5372FWg7LSKCXOeqaXa/4adMjBG0FkcEq+DvLdYIKANjSMqBNit
	 pavq2Mm9gdjcFgl+s170DbJAfeWlsJWoqBLJ9Gx8k78fqaBMx6AdNig4tsvKfJRM0j
	 /vNuTX4Ya7m0eHfNsAFFGBYOA9wexkWTCBU8WqKUQkf2ohlhO3K7XimS4oA0nPq9Vw
	 Vyu1B/V/y+yPxMPd+TM2Axhdie9tqLtdz1EwuocqMBpNOV357xfBoHCqbJzwdZl99f
	 ykwhURakCweoOK+bNG/BVRWv5wWM5bv3LEVZs2qSdiVB2BGKxCSLYojPFQw9BgFWOR
	 7DVcFNgdhjAyg==
From: HACKE-RC <rc@rexion.ai>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HACKE-RC <rc@rexion.ai>
Subject: [PATCH net] ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()
Date: Fri,  1 May 2026 12:02:42 +0530
Message-ID: <20260501063242.2523620-1-rc@rexion.ai>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai

ipv6_rpl_srh_decompress() computes:

    outhdr->hdrlen = (((n + 1) * sizeof(struct in6_addr)) >> 3);

hdrlen is __u8. For n >= 127 the result exceeds 255 and silently
truncates. With n=127 (cmpri=15, cmpre=15, pad=0, hdrlen=16):

    (128 * 16) >> 3 = 256, truncated to 0 as __u8

The caller in ipv6_rpl_srh_rcv() then places the compressed header
at buf + ((ohdr->hdrlen + 1) << 3). With hdrlen=0 this is buf + 8,
but the decompressed region occupies buf[0..2055] (8-byte header
plus 128 full addresses). The compressed header overlaps the
decompressed data, and ipv6_rpl_srh_compress() writes into this
overlap, corrupting the routing header of the forwarded packet.

The existing guard at exthdrs.c:546 checks (n + 1) > 255, which
prevents n+1 from overflowing unsigned char (the segments_left
field), but does not prevent the computed hdrlen from overflowing
__u8. n=127 passes because 128 <= 255, yet hdrlen=256 does not
fit.

Tighten the bound to (n + 1) > 127. This caps n at 126, giving
hdrlen = (127 * 16) >> 3 = 254, which fits in __u8. The compressed
header then lands at buf + ((254 + 1) << 3) = buf + 2040, exactly
past the decompressed region (buf[0..2039]). No overlap. 127
segments is well beyond any realistic RPL deployment.

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Signed-off-by: HACKE-RC <rc@rexion.ai>
---
 net/ipv6/exthdrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 95558fd6f..35a02584f 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -543,7 +543,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	 * unsigned char which is segments_left field. Should not be
 	 * higher than that.
 	 */
-	if (r || (n + 1) > 255) {
+	if (r || (n + 1) > 127) {
 		kfree_skb(skb);
 		return -1;
 	}
-- 
2.54.0

