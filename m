Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D941D104
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615625; cv=none; b=e3XLs6KhWgJElyd6EkKeBeZoXS5aqVXBcNkaCx/kYJKmWbRByrePbg/5Vs+cA2G1hO/K9gZapIqOdayALDiG+KRTyyOdzzqyUFCiVTMrYcuwlXxTv3d2hpylEsPf5BQ5dhlu9l3Finbbse05Pz38gY+ph0YP+pDQYmKA9bI1SFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615625; c=relaxed/simple;
	bh=8IIOLp8HmP/1FMc8TjQtm9EBJOp6xCL+BgDmTSDVmCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqUm8DVtAQF1nL43sZzBSDsRbm2sMtwgxNdPlsFfeeC0LTPbzFA80tP83kbRujY8zi1svb9+8SPufAiVCcnUgg0O8i7N4pCovWjB1eq15+3EUjzBQEPac2WvDuIhmESQhn0A/ZRw4+DYK+fWOhJqfDFNOQ8WphOgL5t2pYrsRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxBDCKNt; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxBDCKNt"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e515769d3so31987085a.3
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615614; x=1792220414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9KWMZeGSt6Sclu0APv7UoNRsk9ZWQDxjh7jcyuIeeac=;
        b=FxBDCKNtG+d5nOeEKLotnJmsxI9dAawd12hY50m0vgRR6xy7yToSgDPfcKikSE+SZv
         RBmjkEoLJAM1avD79b7D7HyI+WBpfWJR3kZQJTGTW1wEf5VreQB3uu6/qiw0fibUyl+U
         vWIhIdQlTfucgg1wjk9mXwbpKFr4h/oIUTHRG6q7JrXKtpJEq19nXstdPXfo/OTe2OJl
         4Q/IyICJWhTNzl03UsyFwzjW9i2qo/5esbiqH451mVNMXhGJWjhm+8LvhaHAD2sHJx8K
         yx57hNtUm+0C+slUDACJozV6kBYAEuLbraYXaVkmeI/Z27YdC8DB00RaMWNDYv4Q1Sa7
         O/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615614; x=1792220414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KWMZeGSt6Sclu0APv7UoNRsk9ZWQDxjh7jcyuIeeac=;
        b=G4pfQTVrBdXf657xj+ux1cONrqldwFUWJ+ba5IrOeMWFHm1SOMOkVMdbpIhI5kLHXA
         LlyVzp3yzvX/EI0mSPxVVOmR5Da32sietDbIC0WsW+X/mQAjQ0SXSbYwTqwyAxxLlDWZ
         yYQ2k9m6yvdX1WNz56ZgwKGNGWfsFA8DW1MKn6YuCFypOwMr8Z5wo3JkSrmAE8md8GKo
         ZZrTZG5fYmZGLl9jo6yxRTC8sEtjGyU7gYP6xctzIaeTBtzpu4u6pm4fq8gM2DjyxtSQ
         QDCLcejVn7ROodWM+hMI1p+RwNvLIejn8CHlbw5ij17sQUpg4fgNnOZao54HLHogsuOM
         Kdcg==
X-Gm-Message-State: AFq9FYJDTGNLHrkhD4nkpOyP/0gBgvtfLX0jn7gyfvWzFNsc3pDE6USk
	Kvm+SEuTOsoDVOmXiMmTCSpMxoCfjsPcoThcHt/zOp+x+x+tG4X2hHWRfLsxWrDy
X-Gm-Gg: AYBFou1D+aLaaLgT2JZAfM3VLchL9sZ33LXGez/e/m7foPuN8Vr99oV3FDnWx3Dyhw+
	wfhF8kxVv1KWD0KLWCkHuIKp01zeYBKeNZxlmFMCgVqLoGCHsZmfLQxNovzotjVD+tVo82LzanB
	KlZ3t0mLIXqhmzLwIaWtqV5tHfPVYjK2zWr0E5aGjM09cN35TVNoafm/l7G14o+Sww0z7bkGHHq
	f70tTRv25EMmSVv7FNocEkQl7nDCRqEk5YJiVWqdJudoyLNbrjnc2mQ5598qLsXqNEuhotWckqh
	iIWb3QBQk+gIBPTX+k+128zKZho1eQvCnXqlmmgZUMGvT4vdx0MjyPnnYaXSnoEJ8iS04iARojQ
	PkVeNrhSfIi4esW6Z/9p2hNyRGkSpfLXsYkipJg34KVjYm9SpI1FiQN/+UQNoNBWdMCAo+KLqZX
	0ajiFxcxqiIsCBzZqSDRbcrVVHn8lMW1b1disCBlMGckT+hZKsAiyum0cUt8ixxlnm7BffL+AcY
	YcoBMh01/eaQQo1s/n52B1h85GJaFnLmUYfN4vEKN8+c8boLlgmOKGGCzHGVRALFPjVLS5+voVs
	H0jb65q9RHbuQpRGLJ2M98SuKSxRq12Y6lhiZRVQ0VsNVBZ2
X-Received: by 2002:a05:620a:4689:b0:93c:70da:e45e with SMTP id af79cd13be357-93ebd223c74mr676339985a.36.1791615614335;
        Sat, 10 Oct 2026 00:00:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550447fcsm37923866d6.21.2026.10.10.00.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 00:00:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jon Mason <jon.mason@broadcom.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Joey Zhong <zhongx@broadcom.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bgmac: enable interrupts only after NAPI is ready
Date: Sat, 10 Oct 2026 00:00:11 -0700
Message-ID: <20261010070011.60403-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bgmac_open() calls bgmac_chip_init(), which unmasks the interrupts and
enables the MAC receiver, before request_irq() and napi_enable().
bgmac_enet_resume() also enables NAPI only after bgmac_chip_init().

When frames arrive in that window, the first RX interrupt masks all
interrupts in bgmac_interrupt() and calls napi_schedule() on a NAPI
instance that is still disabled, so nothing is scheduled. Nothing
unmasks the interrupts again, the RX ring fills up and the interface
stays deaf until it is brought down and up without traffic.

On an Asus RT-N16 (BCM4716) a single "ip link set eth0 down/up" while
a host sends UDP to the router left INT_MASK at 0, INT_STATUS with RX
pending and the RX DMA idle on a full ring, with the RX packet and
interrupt counters no longer moving. With this change, 10 of 10 such
cycles recovered on their own.

Request the IRQ and enable NAPI before the chip is initialized.

Fixes: dd4544f05469 ("bgmac: driver for GBit MAC core on BCMA bus")
Fixes: f3537b3494c0 ("net: ethernet: bgmac: driver power manangement")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 427a096e5ad4..20df9c8ab055 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1183,9 +1183,6 @@ static int bgmac_open(struct net_device *net_dev)
 	if (err)
 		return err;
 
-	/* Specs say about reclaiming rings here, but we do that in DMA init */
-	bgmac_chip_init(bgmac);
-
 	err = request_irq(bgmac->irq, bgmac_interrupt, IRQF_SHARED,
 			  net_dev->name, net_dev);
 	if (err < 0) {
@@ -1195,6 +1192,9 @@ static int bgmac_open(struct net_device *net_dev)
 	}
 	napi_enable(&bgmac->napi);
 
+	/* Specs say about reclaiming rings here, but we do that in DMA init */
+	bgmac_chip_init(bgmac);
+
 	phy_start(net_dev->phydev);
 
 	netif_start_queue(net_dev);
@@ -1608,10 +1608,10 @@ int bgmac_enet_resume(struct bgmac *bgmac)
 	if (rc)
 		return rc;
 
-	bgmac_chip_init(bgmac);
-
 	napi_enable(&bgmac->napi);
 
+	bgmac_chip_init(bgmac);
+
 	netif_tx_lock(bgmac->net_dev);
 	netif_device_attach(bgmac->net_dev);
 	netif_tx_unlock(bgmac->net_dev);
-- 
2.56.0

