Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709500;
	b=lIct4s2zhTt4gYPI1QlPVGY0/dQ15oANX+xzpptje9TzBNNmR4LohwSy41OE3fqq/W2+
	 zsXFQhX1uqGLz/J/sy1985yIgcasDdyqsn3BzM99c6DJ9v635cF9CRNGnI4p6WBc0Mttw
	 Zn6aFJ8U7mI1VuLIATGhfK73B0V8yDe/Xy6tYT47Gmw8kjeT8+tKPrOpW2tB1aLPbp0y0
	 3FUPUsBoCoA09tiaXS4U2O4YkIrvDKnPLkKmGRh0rTuul74Xbss30gJPYZuHnTMaQtWxt
	 yQs6YeZNCV0drVqo5EK63oDWFQL/A0w0nfZKH3oj2LSftFHRVr76yyh/83D3MbqrOiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709500;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=8IDwP9IYS4XmHypL7MGOoMhHcjv7hew6VCrCCf2b2BA=;
	b=nA/MiWHlEt1X99fFMHWS73GuhebveySPY+k84ojqJSN0Wt9xAdsQLRurO2YeZVyaq8j7
	 qGrLyc3HmWzabgWJKlmJ1GuMgRj8B8AOrHR19VqPnrEPGadAw8FNVaLgsDJN4/UqaRI7Y
	 Ymz8hRffrcMT2tAawKt64HWnE9xMnID44Yay1E2lpX2klhyVIa53UTqRpshAsGpxkKA6k
	 7q319+FIFuLc2S7D9eYFYlbbZpvbMIiqsX5Id1Ft3xoIlu3eGVh9c84/mMgS7dQh2Ga7Y
	 GW/IpMxi6aunwxWBteuAmMAJHojGjytJwJ1UcWo0ysQ1n/bAULX7RbAYM+HR9/Whjbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KkY9dvpP;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EF606D827
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B15EF606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KkY9dvpP
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so3045507a91.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709499; x=1794314299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8IDwP9IYS4XmHypL7MGOoMhHcjv7hew6VCrCCf2b2BA=;
        b=0G0HQiRTq6PY8GnQwTv4sfbeL+Ne+IhoAx/VJOEDBsqr5ZUbvEsinIJnTKUbyMlRcA
         hL2SUE1WKfxcp9LjUvYntNEq8Injk7iVUjxeUd5Jy92/z1y4brQw2fwfHUHwvavdft+I
         6lq306eXDw7XhvJaYp19S+yWySlBuHWcBO4Ji+42VUNtRbQPJoGtDKOYAwFRqVAsh5uT
         3wDRti2lhxTBQC9uvFHp+WwqbBkz0vw0HS6UiCHMmh7z1JZ3YXat/K/GzXzvEbhJJDai
         1YGMPlcsfqKZIuLhOPogMIsuq45/p2gYUQFS557FUzeQsC6H8u4yfY8L8H493BU4aCv1
         T3lA==
X-Gm-Message-State: APuU4Z/RyW0oHesAH8EUBygY/gbd7yS8RGYn4T5hm4A/RG7B/8SNmX0V
	Ejb5/0kr620kROELx418FUxFr0yGNCJ2kQexioCJ1lnhhSuFi2l01LoaeOkhxUiMiQVpgg9xdW9
	4KEeZLBXq6M+3Bx/NVNEhNzwdW5aePa0TICOE/bRO6CY57IT4rIUcCJc8N7gfKzLTnd3Seov7uF
	r/G6z24YTHsxwx8OyfdEkfI+wkFGyZkLKuOOEcOCkwKfeB5ZDIuD7YWfgTKp2f98iU88TxrEBPd
	+TKW9q62g==
X-Gm-Gg: AYBFou2HmuFZp5s5mxOcwb7+mMlkuwuBjy8vhVhQMKdf+soqAZn0ZpF7LjRqO6Z2b+Z
	9VofFjFtOCrdSiZ0rQ7GZsGfnrzStNCFasXK6PdjxF+rOUIoIf3R0ER3o+kk1YdsO5/LP6LLBXu
	3g5EgzSif6+MnlN8War9SA1q2bGDw42mq2J+ZWy2kAPRr3DSs90aghjpIav7NLk0BlMVaJgBn2S
	82L3N3hC4kUqVyc2oZb4Hi7NKKdc12TWQL0YsJAhznTF8+8Lwrz8YsBDQCEVrjRXmV3YcMlsTHp
	1Z8k7vGRlxPSDay/NbW7gVPAy+DBAZa/e/mWruA7FTSowzUpBW9A/T9/yVvNdDYNQmNYgawtenN
	t5hXtCslaCEh1clHVI95s1B+rTwiSu/5MxE2nt08gb+LPe+81FJoHvE/4VPSu6BqXvt8Rh/3PW+
	9IgdEr7vMHz+dlDn9Vwzb/KafqU4ysoCV13g==
X-Received: by 2002:a17:90b:2803:b0:3a4:bd4e:6d15 with SMTP id 98e67ed59e1d1-3ae89763070mr10288065a91.34.1793709499011;
        Tue, 03 Nov 2026 04:38:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae88072814sm4058598a91.3.2026.11.03.04.38.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:38:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab7f1efe5dso5658658a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793709497; x=1794314297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8IDwP9IYS4XmHypL7MGOoMhHcjv7hew6VCrCCf2b2BA=;
        b=KkY9dvpPcK9+wgSxfYeaYFVao4E4EU+N4vmZukMJ57qbXgd3749jbW6LcHTlqoFG1r
         dAl7kYVAqLJ81IAHEN4bV4vWBbPOxgujRBgVckqI75QN0wXjQqj+M+b3Yha43PDpKS8C
         3XA5lH2hLPjjXwL4kF1YLpoG27YHgjioD72to=
X-Received: by 2002:a17:90b:2d0c:b0:3a8:5cab:1009 with SMTP id 98e67ed59e1d1-3ae897ba3b2mr11093952a91.46.1793709497363;
        Tue, 03 Nov 2026 04:38:17 -0800 (PST)
X-Received: by 2002:a17:90b:2d0c:b0:3a8:5cab:1009 with SMTP id 98e67ed59e1d1-3ae897ba3b2mr11093923a91.46.1793709496882;
        Tue, 03 Nov 2026 04:38:16 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b08759344dsm2131567a91.13.2026.11.03.04.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:38:16 -0800 (PST)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v5 10/10] bnge: add cpu_rmap support for IRQ affinity
Date: Tue,  3 Nov 2026 18:06:50 +0530
Message-ID: <20261103123651.442893-11-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261103123651.442893-1-vikas.gupta@broadcom.com>
References: <20261103123651.442893-1-vikas.gupta@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When CONFIG_RFS_ACCEL is enabled, allocate and populate a cpu_rmap
for the RX IRQ vectors so that the kernel's aRFS infrastructure can
correctly map flows to the RX queues serviced by the nearest CPU.

This ensures that NTUPLE rules created by the kernel steer packets
to the optimal queue based on CPU/IRQ affinity.

Also, This is the patch that turns aRFS on. Before it dev->rx_cpu_rmap
was never set, so set_rps_cpu() took its early exit and
bnge_rx_flow_steer() from the previous patch was never called.
A failed rmap allocation does not fail the open; aRFS stays off.
If adding an IRQ to the rmap fails for one ring, aRFS is turned off
for all rings, because a later ring would otherwise take the free slot
and map to the wrong RX queue.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 835619604dc2..afdd00ff4944 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -18,6 +18,7 @@
 #include <net/ip.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
+#include <linux/cpu_rmap.h>
 
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -2460,10 +2461,23 @@ static int bnge_setup_interrupts(struct bnge_net *bn)
 {
 	struct net_device *dev = bn->netdev;
 	struct bnge_dev *bd = bn->bd;
+	int rc;
 
 	bnge_setup_msix(bn);
 
-	return netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+	rc = netif_set_real_num_queues(dev, bd->tx_nr_rings, bd->rx_nr_rings);
+	if (rc)
+		return rc;
+
+#ifdef CONFIG_RFS_ACCEL
+	if (bn->priv_flags & BNGE_NET_EN_NTUPLE) {
+		dev->rx_cpu_rmap = alloc_irq_cpu_rmap(bd->rx_nr_rings);
+		if (!dev->rx_cpu_rmap)
+			netdev_warn(dev, "Unable to allocate the CPU rmap, aRFS disabled\n");
+	}
+#endif
+
+	return rc;
 }
 
 static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
@@ -2473,12 +2487,35 @@ static void bnge_hwrm_resource_free(struct bnge_net *bn, bool close_path)
 	bnge_hwrm_stat_ctx_free(bn);
 }
 
+#ifdef CONFIG_RFS_ACCEL
+/* set_rps_cpu() reads rx_cpu_rmap under rcu_read_lock(). Hide the pointer and
+ * wait for readers that already loaded it before the rmap is freed.
+ */
+static void bnge_free_cpu_rmap(struct bnge_net *bn)
+{
+	struct cpu_rmap *rmap = bn->netdev->rx_cpu_rmap;
+
+	if (!rmap)
+		return;
+
+	WRITE_ONCE(bn->netdev->rx_cpu_rmap, NULL);
+	synchronize_net();
+	free_irq_cpu_rmap(rmap);
+}
+#else
+static inline void bnge_free_cpu_rmap(struct bnge_net *bn)
+{
+}
+#endif
+
 static void bnge_free_irq(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 	struct bnge_irq *irq;
 	int i;
 
+	bnge_free_cpu_rmap(bn);
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 
@@ -2498,6 +2535,7 @@ static void bnge_free_irq(struct bnge_net *bn)
 
 static int bnge_request_irq(struct bnge_net *bn)
 {
+	struct cpu_rmap *rmap = NULL;
 	struct bnge_dev *bd = bn->bd;
 	int i, rc;
 
@@ -2506,10 +2544,27 @@ static int bnge_request_irq(struct bnge_net *bn)
 		netdev_err(bn->netdev, "bnge_setup_interrupts err: %d\n", rc);
 		return rc;
 	}
+
+#ifdef CONFIG_RFS_ACCEL
+	rmap = bn->netdev->rx_cpu_rmap;
+#endif
+
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
 
+		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
+		    rmap && bn->bnapi[i]->rx_ring) {
+			rc = irq_cpu_rmap_add(rmap, irq->vector);
+			if (rc) {
+				netdev_warn(bn->netdev,
+					    "failed adding irq rmap for ring %d, disabling aRFS\n",
+					    i);
+				bnge_free_cpu_rmap(bn);
+				rmap = NULL;
+			}
+		}
+
 		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
 				 bn->bnapi[i]);
 		if (rc)
-- 
2.52.0

