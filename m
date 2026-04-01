Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D01DED63
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003933; cv=none; b=i7rX3wMgGxrrrLCu11XOfnTv3H6aAbQtT9zitg8g4H9jkaCFYuonXiT+OyB9h9cdgJViSnfgcNfxw3TeaYQbxpbQfUsC3NN3kctrr82+UkT3dks1owlp9gy3vk0BCFwdj6A6cZerfdkctq3kyqMtzvbtnnFCVQvL7wYYPjd08qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003933; c=relaxed/simple;
	bh=4pJnECj4tZ/2xt2dNt+IO5ACybP9g1nzyKC5qg7VLAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SbeZhq5cLjoXkuVMgNK4xpNiCfAf5ojgETZgRBA2FNyNuxRQLDbMP8MGuQcZgjabPkMP47ItmAaK9FtlCX3HI4PVkqTzo+uT1yWw6FRUh2zFArDfxO5FaMR7lUJDbpsW0TywJt/IURwMWQRhfb7awTvYHU47R1PvwCStpoHF954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MowRYZGV; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MowRYZGV"
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-64d5a7926cfso9434906d50.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003931; x=1775608731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94QS47puTSztp2rJkXie5yl9O8a/8r86kaWdVOjoH3A=;
        b=rzODQsUKR6N6vWCyH59wvma2QbU96Vjc+DvTyh0ynn6iu1NvmEqDQ4tx4GSlHE92V+
         OOHMkvIkMcqwekg9+KD1I9y7b5LO3AM+xmWbiy3YRfGYA9Zn1lZBNDCRdJJLHCop5fdR
         QUiPxjZjAnTk7q4C024UoMIvi+LJlUd8Wfb8K6P0CFJYPpzLM18NpVtrxKzQVgcWOJ5u
         paf511Wk7RgRDN78lZornZyXGcwHlDLr5m8ZdwCt+JWTOLJH+DGaDdRHGKN9iu6ZSAUY
         NAOTB+sJFij8fmI80VYYRam4FLTRlheyfs1NKCzEiAiRfjfNWUmSM6vWZ/bYSaujpqXS
         rJgA==
X-Gm-Message-State: AOJu0Ywm5T3LhZBZO1A6AO9rIijcPhXPJBPpzyPj71yaSavA81pZnZN3
	4j2kzVzs6LK9ibjZf8U8WP37Jgero/ouCLF9d5G1VwmV0QWeXkjupzGdCOoEti4COAq85gCscXD
	bPSLjWcr+9KU3P88CLwXp7m7NEwYY+Ol254Ebrv/OMDRosXp+0CaUPrC9yhjtEIruQm5laeEJ8J
	IpDN4WFmWEb1HWZB+K/qnOCXXdglAnxmZ4OmlkugwQ2wARxA2dhHlEuIPlp0tOI4tseGHQ8OnCQ
	QI2gnKc1g==
X-Gm-Gg: ATEYQzxKm+APvUWDsg3vFA/8wTBF+Id2hA7hxf0YvGxQmOQTOWIQUnJBSSvBtAzB8Qt
	WQdIOubSz0QbwOiRaBFOdIsiaUEzV/gBCu0GaLGUvYrzZQ8g3r8i6Zfk4Tu7ZG4AVdE4JDZXEI9
	FLvXuJptiVAHlhv4JTl5waqdc6pkxqvoObGmKqCtK/HPM1loqPnj7G5g4Kr9EzkqSD5/5Kk+DG9
	MMez/m4CekeDM1WOZmFiQd7jhWjpHHtkgu81Lyoc2meOKptRUPIwOYybLF13EAagDqLo6iAafFQ
	TG5bTmgw3djGEi3wtuOlIWfi6Jm23JJs2VHidAYR+bJFuxTDx9aqWlQy7WzOfE0bDHL+eP3dvqm
	9vktgVwVsF7Qu/L0TKqcsz9CCLTUAkfzqEz63eXKzVtfpI3QShBIyzCmNoCvCQNmTnjb0MegQ0d
	dmanN15EsHM9/Y3jOKl75bTR6Wy+6hNhGtfKFXgc/n1u3+f+ab/IxQZtc=
X-Received: by 2002:a53:eb85:0:b0:64e:e90c:5691 with SMTP id 956f58d0204a3-6502fe83061mr1069031d50.64.1775003930775;
        Tue, 31 Mar 2026 17:38:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6500921bdf0sm1415821d50.3.2026.03.31.17.38.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2026 17:38:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12721cd1a2aso4069691c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775003929; x=1775608729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94QS47puTSztp2rJkXie5yl9O8a/8r86kaWdVOjoH3A=;
        b=MowRYZGVazWaPz7xynSYeyrid5ovcirwsjdp8ppzzlbFY0j6sqirtWj8L2CYK5c870
         2HtlzrVrPn3qyPD7kNaSlYywkpLPnOgObUv/PJY/4mBJuvTFWKf+4XtT1shXGwFezay0
         pjYOFmfNqULmsg7Ic+bP7OpWHLS3llaim97Xg=
X-Received: by 2002:a05:7022:6707:b0:128:d714:3ca6 with SMTP id a92af1059eb24-12be6462064mr1073818c88.12.1775003929191;
        Tue, 31 Mar 2026 17:38:49 -0700 (PDT)
X-Received: by 2002:a05:7022:6707:b0:128:d714:3ca6 with SMTP id a92af1059eb24-12be6462064mr1073792c88.12.1775003928540;
        Tue, 31 Mar 2026 17:38:48 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm17663190c88.4.2026.03.31.17.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:38:48 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	nb@tipi-net.de,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v2 4/4] net: bcmgenet: relax the xmit ring full case
Date: Tue, 31 Mar 2026 17:38:40 -0700
Message-Id: <20260401003840.3112454-5-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401003840.3112454-1-justin.chen@broadcom.com>
References: <20260401003840.3112454-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

We have a queue size of 32. If a packet is multiple fragments we can
run through this queue really quickly. Currently we stop the xmit
queue at SKB_FRAG_SIZE which by default can take up half the queue.
Instead lets just look at the incoming packet and freeze the queue
if the incoming packet has more fragments than free_bds. This will
relieve some of the queue timeouts we have been seeing.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 54f71b1e85fc..a1aa1278842e 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2018,10 +2018,10 @@ static int bcmgenet_tx_poll(struct napi_struct *napi, int budget)
 
 	spin_lock(&ring->lock);
 	work_done = __bcmgenet_tx_reclaim(ring->priv->dev, ring);
-	if (ring->free_bds > (MAX_SKB_FRAGS + 1)) {
-		txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
+	txq = netdev_get_tx_queue(ring->priv->dev, ring->index);
+	if (netif_tx_queue_stopped(txq))
 		netif_tx_wake_queue(txq);
-	}
+
 	spin_unlock(&ring->lock);
 
 	if (work_done == 0) {
@@ -2224,9 +2224,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netdev_tx_sent_queue(txq, GENET_CB(skb)->bytes_sent);
 
-	if (ring->free_bds <= (MAX_SKB_FRAGS + 1))
-		netif_tx_stop_queue(txq);
-
 	if (!netdev_xmit_more() || netif_xmit_stopped(txq))
 		/* Packets are ready, update producer index */
 		bcmgenet_tdma_ring_writel(priv, ring->index,
-- 
2.34.1

