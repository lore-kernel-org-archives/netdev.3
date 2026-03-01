Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8E2F549F;
	Sun,  1 Mar 2026 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329689; cv=none; b=M6XaerqIhrGNnIE50Z4WoR1Ysg/Bl/8vS2DH4W3S3fOuy4BNe1ypb7VjT5WwjXSAO5GG7rPMZgk9rqyY+2kYDVljTw5dLuMgeTUV0GsFOEkciCIcJjKZ+sBbX2d+PHxPKmFXpcbfQ2dnztSnAj3AVUKec1VaaqYV841GGl7zo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329689; c=relaxed/simple;
	bh=f4jMzkn35S8ypOlWfRvPJitDqG0CLUQmUsyEOLXuJkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZDg0AVC1vs5+afj+RZCQOcDIEwUgEc2bZj0nTUCE6pZQEpFLj75aXuaQ9M980KJzDEehnnQ5az+A8HKQqUrk9KQ2iZ7/Z9ULJLDC9/Nxr9ZyIx8D/n0suUUREgvRcREvuSaOX/8zb2NOJSlKWJUb4HdgpLfaBxo+8Thtbp5Mrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt7egDti; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt7egDti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88565C19421;
	Sun,  1 Mar 2026 01:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329689;
	bh=f4jMzkn35S8ypOlWfRvPJitDqG0CLUQmUsyEOLXuJkg=;
	h=From:To:Cc:Subject:Date:From;
	b=Vt7egDti+kzT5EP63buKhlyDwWuuBCm710aUmO9SI8oeJ7r6BGkaCzo6CrkwaVqdG
	 aaJsd9Nh+oFZkLOfDvxyM/n859tbbJkC28ybaEOlWYDokq2sT45LgEQLggM7Rl3hBP
	 xlAZpS639kWBIE6kp3uEdjAolwvFz8Q+nDGpxozFb9NHC2r2ESunI0mOqnvJ5unDfF
	 aLcXOr2A0itH9GBeGqM6zgPsncRjroFF7pFY8Ea3vxnrO3/cSNTknVnJfU/9HuFx55
	 m33kzqrjp1pDrem+0jarZaW6NahdiENexZMdlG/2RTRfe+FV4VB/H1mWwJOJGmqm/q
	 Xe89h9qCNhCGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:48:07 -0500
Message-ID: <20260301014807.1712192-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ffe68c3766997d82e9ccaf1cdbd47eba269c4aa2 Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Fri, 13 Feb 2026 17:43:39 +0100
Subject: [PATCH] net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle

dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
the dma handle. This would lead to improper unmapping of the buffer.

Change the dma handle to priv->rx_buf.alloc_phys.

Fixes: 6af55ff52b02 ("Driver for Beckhoff CX5020 EtherCAT master module.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260213164340.77272-2-fourier.thomas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ec_bhf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index 67275aa4f65b2..0c86cbb0313c3 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -423,7 +423,7 @@ static int ec_bhf_open(struct net_device *net_dev)
 
 error_rx_free:
 	dma_free_coherent(dev, priv->rx_buf.alloc_len, priv->rx_buf.alloc,
-			  priv->rx_buf.alloc_len);
+			  priv->rx_buf.alloc_phys);
 out:
 	return err;
 }
-- 
2.51.0




