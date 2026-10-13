Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527051AFD4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897419; cv=none; b=HhctQV3HAhN5LVGEtS9hSB7oTnf1G9nVMFm2nBJ6CNN6WqNdX2ISsEzlPB/vmLCsWv5Tk3ztrFPJXBZZ9vp8CaRZ43PxWdDWlDP7gxn7zrCYF00I5KlHOlImVOdaGe6bkSzOCfUJslsQLNXrrUeem7YE2p0DxZkuwglCU8jLXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897419; c=relaxed/simple;
	bh=Lj4HaogCSbrmG1eVb9OwvFIRS92jSROtoImp0Ifbs7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQzFNj5V9vd3hpTbhyMQkWv6UHe5EIbPhk19kuxIQoQdV6I4pssaDJQiPc1ONxWWzXLivuZfAEAbUDtFHiLre5YZPKqWzqDcJ5fMeAKj2m5e32EVsRuWkaKL7krdAf7zrJGeis6C1FEmOWmbrmpbjhGjgx7TBNwEmu8p02+ZolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZSl3l2LS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZSl3l2LS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C0605C653ED;
	Tue, 13 Oct 2026 13:17:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3CFF560362;
	Tue, 13 Oct 2026 13:16:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A27B11D713E2;
	Tue, 13 Oct 2026 15:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791897413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jirAU7SfjsoxERJ8F/71yDpIgGLAO187DNBquktolsU=;
	b=ZSl3l2LS5K+nrjMIh74BbIYUi+a2Fgjn6ISDI/sl4Bzc8gpQgKpJ4pbSw6I0AaHLq95Muy
	/Y5WN91IGpksWItruTaBii9P1F92MGkjSWC2yqjTfdDHkipWGt8t5F/Oiik+1YbqZmA8WQ
	LXIUHiJcZYH6g/QxoKUyZMz5C8FwSdK7Pb36QAgSAU14A8LEuk1wzoO25IH672+MIKkX14
	2SZ0XcY+LK8E4T5w0+gMstoOVy0mnbAVxCqeZnNRoo4PFy/yVfa3U3FVfZppnzTsVRdlzW
	uFbiezU612cwksemHJNIB/C+dKPJmY4SRo6OL+eGGz1FbT/OEqKgAGytOJM00g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 13 Oct 2026 15:16:39 +0200
Subject: [PATCH net-next v11 1/9] net: macb: close race between NAPI polls
 & ndo_stop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-macb-context-v11-1-b27785167566@bootlin.com>
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 stable+noautosel@kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

In ndo_close, we call napi_disable() then free the ring buffers
queue->rx_ring|tx_ring. In the NAPI poll functions, after
napi_complete_done() we might enable interrupts and might re-check the
next ring buffer slot.

This is a use-after-free race on our ring buffers because napi_disable()
only waits for napi_complete_done() to return, it does not wait for
NAPI poll functions to finish.

The poll function sequence must stay as-is, see commit 0bf476fc3624
("net: macb: Fix lost RX packet wakeup race in NAPI receive") which
explains why the sequence must be napi_complete_done() -> arm IRQs
-> re-check ring slot.

Fix by waiting for full end of NAPI poll functions using
synchronize_net() in our ndo_close implementation.

This bug has never been reproduced and was reported by Sashiko. The
chances of facing it in practice sound tiny: it needs a system without
any phylink attached, running PREEMPT_RT and with a kernel preemption
on the NAPI poll at the right instant.

We fix it here before introducing context swapping, which is another
place where the race could appear (and Sashiko complains on this
series).

Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
Fixes: 1900e30d0ef7 ("net: macb: simplify/cleanup NAPI reschedule checking")
Cc: stable+noautosel@kernel.org  # too unlikely and never reported by users
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-macb-context-v10-0-beb541bbb7df%40bootlin.com?part=7
Link: https://lore.kernel.org/all/179115680572.434549.1016291990685937691@kernel.org/
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 020a47353d01..d414d00d93ce 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2059,6 +2059,12 @@ static void macb_quiesce_start(struct macb *bp)
 		napi_disable(&queue->napi_tx);
 	}
 
+	/* NAPI instances still access Rx/Tx rings after their
+	 * napi_complete_done() calls! Callers to macb_quiesce_start()
+	 * free rings, so wait for all NAPI handlers to be done.
+	 */
+	synchronize_net();
+
 	/* Must be done after napi_tx is disabled: its completion re-arms
 	 * the LPI timer.
 	 */

-- 
2.56.0

