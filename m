Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844803876B5
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392106; cv=none; b=HLw/uy/Ckd5rdmbDut6AYdBHIIEaSuPOTbHW3vAJrScgc1JOzoOzIDNJHq6amenLjOtU33wy5mjvLomp3H6rIiIyjXlAqKa0c8GvnCL2NY3OdGb28ruC8zUpdGJ9lDoBxWYC4fZjBk6ZqydLBeB+QroE6OswgpKrL54jv1fm/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392106; c=relaxed/simple;
	bh=P1gph1y22smAKag+ZQAZAHXDF0jpAebgD6RXmSfuNUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgXUlPpuRKmrDSsqXhJspDCjulBvgYpfbW40+rHGQgb/fCbDiElmv9m+9lBm8aijTWvt9TKJdKj0QIY8MpG/1KYkmUv1V/mW0Anex5ikBJf+bXW1Z2jenxsc+Xil4/TcoBRlO+0fa5Z6sa4ciPo7U8mZISMqhPKDflZ/zJiYF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVSpq1LQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVSpq1LQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9151F00893;
	Tue,  2 Jun 2026 09:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780392105;
	bh=obMdtfq8yyD+RDfcY5uRCDLbGcKdITdA1JJXlKjuEGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AVSpq1LQRepemHfmkyFioF6JpRG4mvHRmAL7gjJOpxJDYv+QqlPPCXsgv8nAKfcWX
	 nd/Oh8nUT6mvSZ8Htm6cRdov5GDWZpJOhawiRmJgKEroe4aGYSwKdKpwC4UNj/y+mb
	 Z+Btyc/KSqveIkFm6nXkC4y2m2EQG1mAJw9wIX8RdCemmEsAz12uhrnUrip0YVonjp
	 B2LRiFCEuupz3NM7+ui+I4uZwT18cZPeDvGhvh0tAgBRhNPNM9gBQU1mw/SzPvYfHy
	 W6V6WKrF+hdkQc4eICsaz8Ha2p+F9iZ+ZQvlY9C+5ZW7dI/ROostQQndH0fUdYdemM
	 CjwMsh3m1Wj8w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 02 Jun 2026 11:21:05 +0200
Subject: [PATCH net 2/2] net: ethernet: mtk_eth_soc: Fix use-after-free in
 metadata dst teardown
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-airoha-mtk-metadata-uaf-fix-v1-2-3aaa99d83351@kernel.org>
References: <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
In-Reply-To: <20260602-airoha-mtk-metadata-uaf-fix-v1-0-3aaa99d83351@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Florian Westphal <fw@strlen.de>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

mtk_free_dev() calls metadata_dst_free() which frees the metadata_dst
with kfree() immediately, bypassing the RCU grace period.
In the RX path, skb_dst_set_noref() sets a non-refcounted pointer from
the skb to the metadata_dst. This function requires RCU read-side
protection and the dst must remain valid until all RCU readers complete.
Since metadata_dst_free() calls kfree() directly, a use-after-free can
occur if any skb still holds a noref pointer to the dst when the driver
tears it down.
Replace metadata_dst_free() with dst_release() which properly goes
through the refcount path: when the refcount drops to zero, it schedules
the actual free via call_rcu_hurry(), ensuring all RCU readers have
completed before the memory is freed.

Fixes: 2d7605a72906 ("net: ethernet: mtk_eth_soc: enable hardware DSA untagging")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8d225bc9f063..7d771168b990 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4491,7 +4491,7 @@ static int mtk_free_dev(struct mtk_eth *eth)
 	for (i = 0; i < ARRAY_SIZE(eth->dsa_meta); i++) {
 		if (!eth->dsa_meta[i])
 			break;
-		metadata_dst_free(eth->dsa_meta[i]);
+		dst_release(&eth->dsa_meta[i]->dst);
 	}
 
 	return 0;

-- 
2.54.0

