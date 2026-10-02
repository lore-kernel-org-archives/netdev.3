Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578E4D4886;
	Fri,  2 Oct 2026 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953412; cv=none; b=f6VyCiJt+MmYHEapzglMbZ0jXv9d3ht+SXHG9DQ/ZJtqFpJuOXyYIqx3pDjmeaaaLq5vVwTaTaMqPhMw7dY+mbzYGJYDYsIpW7oVI1EBCSMKJ6XGT7/+nSw/b920pgNB5GFD+N04hgHhhyIjM9ChiVfAMYGQ6LT+69xEy8tTLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953412; c=relaxed/simple;
	bh=IGjAr7kr+ku0xQBErhRzdvJ5BR5IA0bTA6Mxf14h1oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Km1PrH/zirch+wWuyO0MxUx7K/O/CZhK2cJQDquDVedMWWSz9hLwgcsnIGmJ9yNh2CsmwwTMatpMIWQ6iD8uTl2Y+AbcPAg++8BYmJdUZoHznoDuxaqHK0mGpRdPK0ub/co3JyvX7FIUvLzVRpX6OyIhabJNcfFfqFzR1Lvbauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=K307AMSa; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="K307AMSa"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1EF19A4B2C;
	Fri,  2 Oct 2026 17:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953408; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=roz8526YZ4DxzjiMuLU0NcSxB9Ej3WE4oWneq+Hbu30=;
	b=K307AMSahnctSqQrqHyJStz4t2/Bhod5A3deZNbLqxdeaK5uwv9QPVvSFdpGZVP68npDWy
	Kj5qLiRHYbqimdza2y8IwHVmV5PusFKt02Rq2li1VQkSnHCzTKLweu4suk63nYI2OfGy3p
	gwGYyfxQkIKEHJ6OZ+A/1stfV7EnQcSfDneWiXXvdJ//hh40f0EQP9TbT+kSUmJInKCVK0
	AViNoZTRTqkpkGaf5q30xRjtCqV9TSm6I/z+C1RL+/Onk44NOj3sWRQe+VSKZGq0X7hgu9
	1sic2L5LpSgR/owANgXGhVrq3Gr6X8Xaj3tHVRwKn9QCVlDXgdTDsphn2ouchQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 02 Oct 2026 17:03:20 +0200
Subject: [PATCH net-next 2/7] net: bcmgenet: allow a continuation
 descriptor without the alignment pad
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-nb-genet-mtu-nn-v2-v1-2-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

A frame longer than the packet ready threshold arrives in several
descriptors, each with its own status block. Only the first one also
carries the two alignment bytes. The length check assumes the pad is always
there, so a continuation holding a single byte looks two bytes too short
and the whole frame is dropped.

Account for the pad on the first descriptor only.

The MTU cannot produce a frame past the threshold yet, so nothing hits this
today. It is preparation for the larger MTU.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a82579879f4b..d89ae6599760 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2329,6 +2329,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		unsigned int rx_offset, rx_size;
 		struct status_64 *status;
 		struct page *rx_page;
+		unsigned int min_len;
 		void *hard_start;
 		__be16 rx_csum;
 
@@ -2365,8 +2366,12 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 			  __func__, p_index, ring->c_index,
 			  ring->read_ptr, dma_length_status);
 
+		/* Only the first descriptor carries the alignment pad */
+		min_len = dma_flag & DMA_SOP ? GENET_RSB_PAD
+					     : sizeof(struct status_64);
+
 		/* Reject lengths that would underflow the SKB build path. */
-		if (unlikely(len > RX_BUF_LENGTH || len < GENET_RSB_PAD)) {
+		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {
 			netif_err(priv, rx_status, dev,
 				  "invalid packet length %d\n", len);
 			BCMGENET_STATS64_INC(stats, length_errors);

-- 
2.53.0

