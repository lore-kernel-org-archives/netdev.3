Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599C368D45
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257891; cv=none; b=b0azP4lOeLQjM3gpriENAEQFYYPVlZrvh9lj+gioBIAR6LOYLBH2DvN2bTbAg1IyNU8Yni7PVc+6U7LjAFmvAcZv1bvcCr+Q4HVRL9IhGTO5MRHJyr0R3DhpGZ3cLLithRRtqXBqfqgSpd1/ENvsMZk2e0Mq/9z19Kx2XDASJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257891; c=relaxed/simple;
	bh=E3VPoo1WtR+rxs9hvZnwcoZIARqPXsbIxZpKFwhkGiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpDFxgXVd9SqVmUgaq+XX1I4C5cziLJYikcuAmoGkBbWuHwM9Qpgix2FvRyUPcsQP75wkgrfZ/Tz5us3SiuKnYHu68FDTZ0g3DJD5gYeZhVrfIEvnt+W5jzbRi7GxwJt8tKRvU/vfeH6U9r8yJCiqm2oW3D4IcNV/l6CcuxrKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNPvwAXk; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNPvwAXk"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccead2aecso9583825e9.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257887; x=1790862687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mH6UmZDnY2/1ICZZ8Pg7t2PX/T+Y1zVqUpSfOHvs/6Y=;
        b=oNPvwAXknd4OxoO7ypPHoMLV7rFgdZrSMSOGaoLcsuVZ+vqM3z4rWUO3ZUKIeJgS2E
         GHPyH8emeTegQ2R5oe3YSPf1+rZgShYjlOjKB9l32DULgx5DciEGllgx61GvipHQxgiK
         6C4clFW0Hc2I6+rPlrQa81F6+PFtZeB0jPoV4bg/Zxo/G2K2v3wVHGS8HpOOFWp4DyZu
         JnY9VkZl0Ri/xdEwtsC6xHmEdbjrrS26NL5DuYHa69gyKEYDb/GjlIt0D29S17spz6U6
         GS6b8ZrLGnCoelPW9DntPidBkMevIHU5MBdy+f5KbJM6fwWfxmIF4j/CYdZ7dpCAfFo1
         VQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257887; x=1790862687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mH6UmZDnY2/1ICZZ8Pg7t2PX/T+Y1zVqUpSfOHvs/6Y=;
        b=BReiYoBb9Gp7qrMBatzoygtEW2VOLTlWeaNXX/+OweKYxmnXpIsjusUhRHJLoBI1gx
         AnzXrMcwYw0mAsTV/mPMi0BStqjvv8NYlbWMR6S9vdpVvQsEjEPG4aBvKueo2/hlQKUO
         vl/NhQF6LS7+1m3kgp8zJRnyF+HiHbiSI3f1QOCTHEASQP/na1oK01wuO4gBGOjtbCtD
         g9Z+l2d9fbOJqqj0krbd0lpC79mdDawEs6tbTn8Y4bdjk2g+Bfx7WRyvs24uU1nmF85G
         Lnpqei8yQyPK3rZsraASDsxZe7C7SdOB5XASvkAJ2LFfQGPvBO3R1pkibMEu2JIsE01S
         bt7g==
X-Gm-Message-State: AFuF++l8S6vBToEu3df7nvxjAVVE03tnJhNC5f6Oahm/Wkui824wpCai
	iHE4LYe5ISB8kEFOAh06vHVrOt/wDr/QVU5GVVKUO/3lGxma8wc21uOF2/j3BhG3
X-Gm-Gg: AYBFou1bi3hLqT5/ffH+Rp835r91F2Hbwbx7x1mwUO07DWRYld+gKmhsvnuOdXhnZtt
	ZaOQNoZorzF4EOn4G9p9JJzvcienuwnGoh97VdIEca2/Ve/gfZaOPx0CyUPs1ifQH9XOD3Rt2f1
	Hdl8VqwPGzICiwm1Tld0cugsm7+wy8gg5i42TKQizzKvmwfocWaYajw/EmafoKIfAL3NlwW0VwP
	deI7mrKWInVuZLwTcZ2g/Rjwaa3evpkguTvFDYbvFFFSs914pjo+eMdr7DRabpPeKhmJfBnGBRP
	3Q9WWrVEGEHdPoa51+6KyWNrR2EQPzgrj0KPHiKf01FASlZPFqnyLKAo+8KypRrqYwn9MMwkEH8
	yERyXtF2jBsLNYSWs6V54+3DK/60k/IaCfZcCa8Np6+S/gXdZspjs5G1I6eUT/9fyAC95cy3wqp
	rwatSTFcVeZgHLZ+iFUFyScz3dhifOQdBukEHOLmu5QcstknTOq3F0kf9ol48WhobagJ8EtMPy6
	wcaQ5y10/391gxmHUWwMgPcn3Kq59jb5glaSSVHtxu82wL2kdI=
X-Received: by 2002:a05:600c:1d19:b0:49c:fc6c:be00 with SMTP id 5b1f17b1804b1-49fe66fbe9cmr45951715e9.23.1790257886830;
        Thu, 24 Sep 2026 06:51:26 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889376sm12060660f8f.33.2026.09.24.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:51:26 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	daniel@iogearbox.net,
	andybnac@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v2 3/4] net: axienet: quiesce the TX queue across a DMA error reset
Date: Thu, 24 Sep 2026 16:51:15 +0300
Message-ID: <20260924135116.185161-4-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260924135116.185161-1-maimon.sagi@gmail.com>
References: <20260924135116.185161-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_dma_err_handler() resets the DMA engine, frees every TX
descriptor's skb and mapping, and rewinds lp->tx_bd_ci and
lp->tx_bd_tail to 0.  It has two problems with the transmit path.

First, nothing excludes axienet_start_xmit() while it does so.
napi_disable() only stops axienet_tx_poll(), and the handler takes no
transmit lock.  A transmit running concurrently can publish an skb into
a descriptor that the handler then frees, and dereference it afterwards
in netdev_sent_queue(), or program a descriptor whose mapping the
handler has just released and kick XAXIDMA_TX_TDESC with a tail pointer
the handler is about to rewind.

Second, the handler never restarts the queue.  If the ring was full when
the error hit, axienet_start_xmit() had stopped the queue with
netif_stop_queue(), and that __QUEUE_STATE_DRV_XOFF survives the reset:
netdev_reset_queue() clears only __QUEUE_STATE_STACK_XOFF, and nothing
at all without CONFIG_BQL.  The wake in axienet_tx_poll() is reached
only when axienet_free_tx_chain() reclaims packets, which cannot happen
once the handler has cleared every status word, so the interface stops
transmitting until it is brought down and up again.

Quiesce the transmit path with netif_tx_disable() once TX NAPI is
disabled, so that no transmit is in progress or can start while the ring
is torn down, and wake the queue once the reset is complete.  Because
the handler now owns the queue state for its whole duration, the wake
cannot be lost to a concurrent netif_stop_queue().

Skip the wake if the interface is being stopped or the device has been
detached for suspend, or it would undo the stop that
netif_device_detach() installed; axienet_stop() and axienet_open() own
the queue state then.  A detach racing with the check is covered by
axienet_stop() quiescing the queue again before it tears anything down.

Both problems were reported by the Sashiko AI review bot.

Tested on an AXI Ethernet MAC behind a PCIe endpoint: traffic passes,
including across ten down/up cycles made with traffic running, with this
series applied.  The DMA error path itself was not exercised.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 6d448d0b523d..f16dbfc7dc93 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2724,6 +2724,11 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
 
+	/* With TX NAPI disabled nothing else can wake the queue.  Stop it and
+	 * wait out any transmit in progress, so the ring can be torn down.
+	 */
+	netif_tx_disable(ndev);
+
 	axienet_setoptions(ndev, lp->options &
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
@@ -2791,6 +2796,13 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	napi_enable(&lp->napi_rx);
 	napi_enable(&lp->napi_tx);
 	axienet_setoptions(ndev, lp->options);
+
+	/* Leave the queue stopped if the interface is going down or the
+	 * device was detached for suspend: axienet_stop() and axienet_open()
+	 * own the queue state then.
+	 */
+	if (!READ_ONCE(lp->stopping) && netif_device_present(ndev))
+		netif_wake_queue(ndev);
 }
 
 /**
-- 
2.47.0

