Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC523D3339;
	Wed,  5 Aug 2026 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951812; cv=none; b=Pj7uTgGm63/b59LRXGfHZdlmLi4li+AZDzu5RAS/5x/bIJMtzKix/FN2zDl4IlLMklPh7ZyjtWw30ChMFiDpPQ/+lmQa0PabZyyYkLrI4bSDUoUpzmt/Ix8aQjpLRvYtbTTVhEj/2fPSbHne9HJucOt946RUByThspU/4Z+z56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951812; c=relaxed/simple;
	bh=Zj8ljX2iP4cV10Q/+qiv29C4kXrtslw6skNOnU5A4zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOv86GeTB2h26Cb7ZCcTPvPluUA5MASZ9gL8zd2f9mVb7HCpNBl6GukDup7n5CTOTsh5jOjdl3d2EbRwG9qTyOayOKpDryJxVEyTvSg7Yn7Mi96cz4HD8c+kbQnAMfHrqYnhNBJzMnnvyK5VFq7uJJjjDqPynsUrp3agNvAYCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O9329UVW; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O9329UVW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CD6AA1A1443;
	Wed,  5 Aug 2026 17:43:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A18A5602AB;
	Wed,  5 Aug 2026 17:43:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC4A611C3507F;
	Wed,  5 Aug 2026 19:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785951804; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T4UQOD2lvOpEjM3yH3RxEruIPXtMmVbNk2g8lQpYEao=;
	b=O9329UVWqQ2wpI2eE/MAIKpEs+GSA8uK3O/yGhZ5F44mPN7JJvUaE53UP6s1Lko4RORTFZ
	IkH1z5w5LaRPHC3ud6MgAu/bDf7PX7q/Qv5mM9QgCgEtMcdDTdW0kuXmA/mYTFIYJaCA5D
	EQNQEtmiNepruIMDLMN0iGNEwqes0qekBEW+GuYtJ5PEF2yHTRkdqRoqY8jQ+EVms7bnre
	hUB7825CXieYkOlHoBP0T9tCMmY75ZvwqbrkO1hSga1YKVVZjva2Lm356GRecnZ1ixGahK
	nxx9mGERrlzSO6kpw76bY2ProBFb1DVA90A7EdrR1UaSExtKTAVkhdjzkViYlw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 05 Aug 2026 19:42:36 +0200
Subject: [PATCH net-next v8 07/17] net: macb: refuse set_ringparam on EMAC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-macb-context-v8-7-bc302ffd1174@bootlin.com>
References: <20260805-macb-context-v8-0-bc302ffd1174@bootlin.com>
In-Reply-To: <20260805-macb-context-v8-0-bc302ffd1174@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

EMAC has never supported changing ring sizes: RX is hardcoded to 9 and
TX is the tiniest ring buffer you can imagine.

Make sure the operation fails early rather than silently succeed and
storing values in bp->configured_{rx,tx}_ring_size that are never read
in the EMAC case.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index af351d30adab..1476bce77f34 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3687,6 +3687,9 @@ static int macb_set_ringparam(struct net_device *netdev,
 	u32 new_rx_size, new_tx_size;
 	unsigned int reset = 0;
 
+	if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
+		return -EOPNOTSUPP;
+
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 

-- 
2.55.0

