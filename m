Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76240439F99
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827995; cv=none; b=NLgafzR8HWKxl0hrMbUefQAqXtlRl3EpyDjA5ZLAPlVAy0f90tVIgEvOekOPcJG+/MmCUTQz6q4z4IrTIKl+zT3B81OD2HaC95HHo35pOfofD1G+WzA1T7q4WIby8rwPjyDEdCslgr0PO+USLSfDcGfPy9lM3tWi5QvH4h7O4rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827995; c=relaxed/simple;
	bh=YRF2r0rKaryfZx8QXqVErQCGdXTX8M0NrVduNdFq8+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sssNuaeaf6rmktIT0tc7XuOHTGlzBZmM7qf1XVrXYDS7iPljn4xJGpD6e2FqbbA5YhGC1yzHNCMM4mnWrxDWXtaNv9ltttmFwl5p6M/ll0jRaXfri0/AY0uqzWXLCUKX5W8lmeNtryS4j82QSAzStK/JV4EH7yDpFaDORkqk3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2G+n7oc; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2G+n7oc"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6dd42533365so632774eaf.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790827983; x=1791432783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96cgtUmQY7pC2wD8g1aOKJCa2wlyYVy4lJ4KL8qZGNI=;
        b=C2G+n7oc6Z3cZ9N6ClgFV14bcc8h2pRgpjdclhtHYa4NwA1ZD2TeTq+hEVuPNBsGjn
         Or6V9ZLAe2zJSWtGlzIpcjI3eT9uIFMFx3tnD9BETjZqzOsKUAI+ervUH9ZDC372lRIL
         nuZ+7cCplqsMFTqDkiwt0SlZ+ibDPAcHg5mIEYh2qgxJgdcmVJ7P/+t/o5nsyCwC0rlB
         uvFLR6MX8nFByYDhMwIQ97V+ugkzEi2PMhAOB1gjoX7dRYR+0WLbQ157q+ImoqayOI6c
         ynNirA3ZSqit5i434m1WsaAjSImpPiaRJCMgv0fsg6GwlK7rLYNL4QrrFgW8i9yC6dKb
         QB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827983; x=1791432783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96cgtUmQY7pC2wD8g1aOKJCa2wlyYVy4lJ4KL8qZGNI=;
        b=TlTKRchqKNg9Pp+Lh17mxxIP5C/zNgGhuuqF33cx3bPLjtL+fKO5N9BhstqjEybKRc
         m/wdGi4ubFA1Nq3ZaK+cdYnOvLwhDyROVLzRCJqAUP9j17e1FKUUpS4u/iXgLn6EzX3+
         2EB8dLBsdG8FLF41pF2K5BCjRauJrreoMnBJWFYBtAgeI86LmKxEXocyLl5v293vut1z
         +QmsSTGZnP+2uJdrn1Yll9s7kcu4a1tIkZF6YWS1pw46+1zM3+LNZe4XDg75BPuClWu+
         YWVQV6ijnSX6YC9LhkTC89dZouMHfPoW17M3wPbBC/S3bUvHNoDbBSu2rhZFO1M1jUaU
         a4SA==
X-Gm-Message-State: AFuF++n9chV5ulzZqaldF/nSK9iaTe++6Z1IsxgAsNEc77PYtxqD+T0j
	CYLjcOKMAYukDieqjNMn3hkOP0v5u0aPyJ0JaOX12oeqg8zK/zvlSdS5
X-Gm-Gg: AYBFou3MyMsCaC9N+8IF7+zDBQ8SrjZAo4R3qrLFttu1mdZMSQIxsImiyYDO+VZGNQe
	d0zCOfjvAEBHfdVlVmk7kBFFfr4Z3Cc4OKkHYgw7jcV4YNMZtX8rQMY//D3nOs495+3qd7KQ6/P
	MhDBCGBgpXDVXi7O/szY4jegXC0tEHgfH3NQm5oXnklRjjEQPaTj6VRlr5PlvCtVZnscLntDXu3
	sAPB4Z5//ffyNxIUIkRsKyvEWcT4UOlqYwQfmID/sHmNqNslk7peJXXNsvcfbnLoYfQK21+JR4K
	gAzgVABkNzEMhmdVQdi/s8DTZ2ka/Zu4fUqOydc890yof5CKsLrnfQN2gbOMledKb1mCOukhidY
	O9ZtZstS5quPrm68t/ZpEEBrmLCId3ANzTzJt8URpiN+2kzOJJiWqJXI61/Ovjj6b3E1zafVcK0
	gkbHAlmEV56jcjjbMsQBasBepuMWQlpQ8hJHS5wtqHmNJLUKSVmcKZdrHjNQvZYZ7Xs9m8V7KGN
	Ez6/FZ+g9f9miY0JCdObfjl1oXDD0gn5+tjeH5i7I492+KD8aIXIiYCSB5j+uqew6leJJXqY0ad
	7KFSjivo5GvrJ48KFhh5c43iJ69MYRFdZJOaTp77BlE2eC/pEglGIGHtdJgvqEdG4ift2NlC9Tg
	RYUTwjnFpyDdDVCRuExICOP3+b7nivpM=
X-Received: by 2002:a05:6820:2911:b0:6d9:277d:79d2 with SMTP id 006d021491bc7-6dcf4c5ff47mr3589808eaf.41.1790827983279;
        Wed, 30 Sep 2026 21:13:03 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8212af3c1ecsm1708657a34.21.2026.09.30.21.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:13:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 30 Sep 2026 22:12:52 -0600
Subject: [PATCH net-next v4 4/4] net: stmmac: restore EST before starting
 DMA on open and resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-stmmac-est-reapply-after-open-v4-4-9d4366587b73@gmail.com>
References: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
In-Reply-To: <20260930-stmmac-est-reapply-after-open-v4-0-9d4366587b73@gmail.com>
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Jose Abreu <Jose.Abreu@synopsys.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Serge Semin <fancer.lancer@gmail.com>, Simon Horman <horms@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

The core reset clears the MTL_EST registers while the cached TAPRIO
schedule remains installed. Reapply that schedule after timestamp
initialization in open and resume, advancing its base time by whole
cycles through the shared replay helper.

Move DMA start out of hardware setup and into its callers after EST
replay succeeds. An EST setup failure must not expose an active
datapath without its installed gate schedule.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e93f3238be1f..2104eaef8806 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -48,6 +48,7 @@
 #include "stmmac_ptp.h"
 #include "stmmac_fpe.h"
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_pcs.h"
 #include "stmmac_xdp.h"
 #include <linux/reset.h>
@@ -3779,8 +3780,6 @@ static int stmmac_hw_setup(struct net_device *dev)
 	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
 	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
 
-	/* Start the ball rolling... */
-	stmmac_start_all_dma(priv);
 
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_hw_vlan_mode(priv, priv->hw);
@@ -4200,12 +4199,22 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret)
 		goto ptp_error;
 
+	/* The core soft reset in stmmac_hw_setup() clears the MTL_EST
+	 * registers, so re-apply the taprio offload after PTP is up.
+	 */
+	ret = stmmac_setup_est(priv);
+	if (ret < 0)
+		goto est_error;
+
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
 
 	stmmac_vlan_restore(priv);
 
+	/* Restore the installed schedule before starting DMA. */
+	stmmac_start_all_dma(priv);
+
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;
@@ -4224,6 +4233,7 @@ static int __stmmac_open(struct net_device *dev,
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
+est_error:
 	stmmac_release_ptp(priv);
 ptp_error:
 	stmmac_stop_all_dma(priv);
@@ -8420,6 +8430,10 @@ int stmmac_resume(struct device *dev)
 	}
 
 init_coalesce:
+	ret = stmmac_setup_est(priv);
+	if (ret < 0)
+		goto error_stop_dma;
+
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_rx_mode(ndev);
@@ -8427,6 +8441,9 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_vlan_restore(priv);
 
+	/* Restore the installed schedule before starting DMA. */
+	stmmac_start_all_dma(priv);
+
 	stmmac_enable_all_queues(priv);
 	stmmac_enable_all_dma_irq(priv);
 

-- 
2.53.0

