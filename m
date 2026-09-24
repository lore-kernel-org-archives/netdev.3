Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C2331EAB
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257884; cv=none; b=EalpDEfBeCLYDwsMzFhGjPbJ22yfTo/A8qj3EMvoyeXR0xxJ47Eo2mzb1EOXV6OSUJLgT7Jd18TlboGg+PJTjegYv8YoCNGR8bK573VjNanZEMLs8ycjLpW4fkQV2/9QJY1coLOY5bw+XVudIqH54FUFoloyvYmZU/LNI34p45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257884; c=relaxed/simple;
	bh=pbAwQ4xmPANEX/RcHRl4bqLAeVojJa4y6MnPaK5ridk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PT65LT/I52bPleLZDhgOtndlPHlC/qvo5vSGEgvXjha7cpK0RbgbRIhzm1IFGejHA/Feit9AdwAaTcNfw94WANoZGxd2jAzaPYEI5swK6wOhnMPvwxDk8NO+IDbZfpFfhb7fC6PdRhiqXdmQHFXcLWzC/zggeyHUxhWWFml9Xj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA1lSJr+; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA1lSJr+"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-486e1a044c5so1707037f8f.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257881; x=1790862681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eGFtAxjPebUuQk9r7/DMkX7jS2v/ihsU7t718jAGybQ=;
        b=ZA1lSJr+0JLW1BJBdEFd7wkwuBLdSs5LKUuMB6SJKEeOh3DX5EE/7Sni5abstoqw6Z
         3Npu5jnQEXvOHsbNOhOCkBEET0SX3bkO0dCjPXH5rH/Q2yUTJEwKFLU1qZLUPvrgJAlG
         225u0OsAXabZkzuSPT8UWvXCKltka8eDPcMtvKjQeGPi9Xj6rQjGbmLu82rI+8k4M+GT
         5v4CUqgq0nQs+tvJbIEJWM4ZCdnu3qyzvCO6lGt+Cr87JWNHf7bKkexQiIezuSGs1yeZ
         zv8Kx52Z1g0Q9elc5js9YUuEe/rPqHHgzhSGjqxhup1isl+BZLUTBJGVd0MnQr7PDYDm
         sIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257881; x=1790862681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGFtAxjPebUuQk9r7/DMkX7jS2v/ihsU7t718jAGybQ=;
        b=ZK9uK0mq3LM4fRQhK3QRJ6PxTnT2aduOH1omHIaFqluV1Zriy88eubNeQSvWbOzNdM
         bFIayY1LhQ6CGTnrT56TI1s7m5mx9j/Ike0nQZD6ctpSxdf7h/IXAfXY64eJ50S4afsL
         X5YB3SOxR/lfQAAFIxWNZGTkI7oO02w0c3u7JjP/ela2ipCumSa4FJVXfN3lDy/GInsG
         YlwraniAVaRfC4JbKcbG921wTApknQ+kx+fFvGHQvSd63AWDZXDCWZTZ2rwqHnFt3mVe
         FeUplmTV6CmNNYaYDTPANzpRnb1BJMW2b2lQenSkGrgRJdl7as/9fZgjzFBHiZ0n317a
         h8Iw==
X-Gm-Message-State: AFuF++kdUFSCzWERmGDAKIMqTKEeExavy8FlTWS4A8rChd8tfzXENgtK
	tifdJzFBPVmfjsvaCMQZI0ZdaTm4eJzpa2IKCIx07qiK740dKovn6zbMvNQklNaB
X-Gm-Gg: AYBFou1TlC1ZmvZIc7swqZ1C4v7Lr1ymdhiX1SVuOvBjVVBc463emyo0//ljUsaPbVK
	ffsRB7ewPC5bB8QCFcNCr07gO4Nlfcx95tv7dto4vGZ3ak9rJwyFF9VQiKDHUCfCTNmqxsvw8va
	TNhO+GUsA0eQ8ZkvmNoNMSNUYPrXIMTIMoNQ1EBDJzKUw2+3UB70LaI+4CstGaps/wsp6nKSin7
	OgFlwDnSB4Vic+zrtZBvt4sYXIlBYDdCElIUuK7zswVDqi/xvKTlgQkOWi5ybILqVAOjNyZH1Vc
	4kUPG0JzXzKK6hwE8vIsuPbES46qKKXWPFpHoDkm8BrGEb+kj/fXYbl/6dwDjCgsb7Q9oWe5YtU
	8iSjPUJLV+C2uyNdT7NCvNIfZpQckvIm/2MimYC1bI9+xOlD3JoYcpnSEzfXnjkQjy+ie62Gu5S
	NWvFS/lrc9fAT/69/HrWD4YUbIO67H+T7L7bJOoAd7CmB/A3zo5lXcC3Qwq1zovebA8hQHqEg3C
	lIvhJUtHfXOlGtXV9bGAxZczv0QvDazeL8YqBCc
X-Received: by 2002:a05:6000:29c2:b0:488:7927:9c99 with SMTP id ffacd0b85a97d-48879279e34mr247722f8f.4.1790257881136;
        Thu, 24 Sep 2026 06:51:21 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889376sm12060660f8f.33.2026.09.24.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:51:20 -0700 (PDT)
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
Subject: [PATCH net v2 0/4] net: axienet: fix TX queue handling around a DMA error reset
Date: Thu, 24 Sep 2026 16:51:12 +0300
Message-ID: <20260924135116.185161-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_dma_err_handler() resets the DMA engine together with the MAC
and rebuilds the TX ring, but it does not coordinate with the transmit
path, and it does not leave the MAC configured the way it found it.

v1 was a single patch that woke the queue at the end of the handler.
The Sashiko review showed that this wake could be lost to a concurrent
transmit and could undo the stop that suspend installs, and it pointed
out two older problems: the handler races axienet_start_xmit() while it
tears down the ring, and the reset loses the negotiated link speed and
pause settings.

This version:

1/4 starts the TX queue in axienet_open().  Nothing does today, so a
    queue stopped at close stays stopped.  2/4 depends on it.
2/4 quiesces the TX path in axienet_stop() before the ring is freed,
    which the suspend path otherwise leaves racing.
3/4 quiesces the TX queue across the whole error reset and wakes it at
    the end, unless the interface is stopping or detached.
4/4 has phylink reprogram the link settings after the reset.

v1 also called netif_trans_update() and said this stopped the watchdog
from refiring.  No .ndo_tx_timeout is installed in this tree, so the
call and the claim are both gone.

Tested on an AXI Ethernet MAC behind a PCIe endpoint with the series
applied: traffic passes, and resumes after each of ten down/up cycles
and five module reloads, all made with traffic running, with nothing
logged.  Suspend, a down/up cycle with the queue stopped by a full ring,
and the DMA error path were not exercised.

v1 omitted the Assisted-by: tag; v2 adds it.

v1: https://lore.kernel.org/netdev/20260917121306.23499-1-maimon.sagi@gmail.com/

Sagi Maimon (4):
  net: axienet: start the TX queue in axienet_open()
  net: axienet: quiesce the TX path before axienet_stop() tears it down
  net: axienet: quiesce the TX queue across a DMA error reset
  net: axienet: reprogram the link settings after a DMA error reset

 .../net/ethernet/xilinx/xilinx_axienet_main.c | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)


base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
-- 
2.47.0

