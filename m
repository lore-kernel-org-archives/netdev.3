Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576521;
	b=NLE0cYmolLdfmVA/PcReV5IxjTZNdegY0WlA0WLkmKc732k89gHyZSY0yHcM3ColVIrv
	 PjvdyGeVPBK6GGoPJXei/r8UVBOqd8jWObsHS0gx6fCRjSPRdCxoYy5puQ0R8Frv2f1Ya
	 CKLYvrZov2QHr8YC6TqINbP79igm+7F/gZL6djZ5a4MTHQ5MJLtyG20+vzuwrDdjyZHoM
	 54FdZW0kW8lGPTxXun4WcVRJ1hGEQ+s0r8hNQjFxcCN1pKsVytRfEGBhSc2vjcrDAQ769
	 pAEW7lY64DO6+ja4QxDPIYFoNwf7v5GWr059JHs/oahREOkYkAWvCjK+sL3HfPGZwtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LFUlowHkykBA07bzno9+ZZz7Tclr3AiMw/Mxprm1brE=;
	b=uT7mUzEqWVq6HklwH0bSpk3Pqjs9mHGAc8fMFO6bqOJgGUyX5cfrUNKtsIT3P6sKHd1D
	 HKTk1Sy2cs/eGLU9pgg3IghLpVOTSuZRaXFF/4Eo8VtWNx34W9dtzX6LWCfy2CVtUrqoG
	 GuUT+WHF/lyROMtRQyZt67gCYUAsKlCHBCrTpRwK6u1K7z4P/41PpRgX5+P4RLfxNxWmK
	 7bYSyL3+cR4zjEwtjfH5BeS/pZpPVviSVrzJYRjEQhNHih4xkr+8mrprHrtDFKELjrsW/
	 fiDzRUXwbjwmBTD/iWGlzcN3e65iBLVLf5WNvBNrudbYHA7/jIRJkie1kTx2otXL1ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=at2EBTEE;
	arc=none smtp.remote-ip=74.125.225.73
Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E560A3825
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74E560A3825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=at2EBTEE
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-490dad2342fso346563f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576519; x=1795181319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFUlowHkykBA07bzno9+ZZz7Tclr3AiMw/Mxprm1brE=;
        b=at2EBTEEMzyH/6EVKGx6axf1SSlg1oEcU96MepvJN9tGA5So6/YUcZruRljvk7jBOO
         2eDT9k8KRK8KCZw9LA1WtSdYbXpf0HEAKkgnEZhC76f/Gm+sKBTMCZrreKKbcOMzGvFA
         dsLb2k+92iTCAMtwMMjsyD17MfAS/2+r5Lfs9kPrtjRbbkk1HnFSbuz5kzjfpqWo7rG+
         lkaN/MqCU3NJqqFcCJc8UUwQePi18WE8GzyzMGdklP9qlcAeQTZz5KxfcrG6NWd9xcpQ
         9xb6Dw9zoexnzzMT1zj+Q7booJxbPc+NWm6lF+wAuyWZjEjJA1raqJDXIgwbmIeqxD6Q
         vuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576519; x=1795181319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFUlowHkykBA07bzno9+ZZz7Tclr3AiMw/Mxprm1brE=;
        b=Akc61kihDtgcQc+fPIGkOkbYvBtiSr8PiPpRU4CD0S4kTLlPuIlKhbWfabhqZ2Lkai
         4SsCJUQN/JhtguPV8c6MvBEbQE6HE4sgvRqG9KF/yBloNuFhVmHK+0C4HzoXNOvBtaw/
         GghMIB5/Yq9B5Xq2Q4ewlk4PBpEGBMXxV4AXHCx7eIGGwIwVJQowjLoh06PtIn2/KTCa
         mEhoLYpm1Xzhc0cLyGwfQkUPu//ewPCg8mxT28HE5bkc/0FEr8lctLDVTfjgCJp9J97p
         1HEVrFaDLFeHtYMmet0bBA5vnAl/s+VfIdrVuRlYRt5t0IvNnqrAMQ83pU7bbxMYFNdE
         xXXA==
X-Gm-Message-State: APuU4Z/A34l+j31W2BT8FYzWYcC0cGh3Vth+H0PjDhvaoLLKWf4evhDi
	Bj1VhMbCt0gIQ/d2LpOoWE8rmTSNiSCM7WEvtWPpBGvG8PAtYYVFiWQ6kPTQLSkiTp4=
X-Gm-Gg: AYBFou26wnfxcdIHMzcrOgKZtG4WcD8o16WlvwjBCQOotZLwk+OHZXrPxiUcvWOfa8e
	wgc7ZU3+eqfU0o9JNX/4P3+0eApXCdXXWInx1OU3ADUzyvILiRUYYBC2AOd+HyM0Xnhdw1PsaZY
	zAx1dN5aq5EvV4M2JuM0T7KK4JomBZ/axGhTMw3MXSLSmVwkQgiR0DW61pRdW7AvciM0lW8i2/J
	CmdMXqNwFG5nbkitns3umyImCWnTLS3bFGq04RTClGbwfM/9+npfM2ezi9QAtDEmjJM2va4ZfJt
	esUfNZA0Kf2MRTJad6JqkoIvgTjONphEfpw/xuUPe865Az1eCCXcJK8ZSOq52dwAZMsZYjZ6kQX
	X7laYILyMaaDyEj7P76cglc0ytpw2MS3NtliwuRiu9oPThMoHSg6i3hd3tO7pjQIqTJr33KWYrM
	8Inu4KrYOMr7OD4YK5tac+MLkq3Ef2S9X3eRC1jL5Jtd6p8HhOzDhtF5TeyAJZ9GzIKZcaFNKv6
	M7TzYTw/lRTq72bkzwrNIqYeWWtKJp8fZCWxZtWnhS8pM6z53zrQ5WUxfyNjGBc4i7mA2rezE0L
	i1gpSrH4NEAxYErIs1/Fch4wKBqKEGgCLOlJeSaMoonb8+N35x/UGU8=
X-Received: by 2002:adf:e18f:0:b0:491:895b:4c02 with SMTP id ffacd0b85a97d-49c713ae4d2mr5232726f8f.23.1794576519158;
        Fri, 13 Nov 2026 05:28:39 -0800 (PST)
Received: from workstation.. ([45.249.9.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fe370f8sm4802673f8f.27.2026.11.13.05.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:28:36 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Ali Tariq <alitariq45892@gmail.com>,
	Tomas Hlavacek <tmshlvck@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	leitao@debian.org
Subject: [PATCH net v2 1/2] net: spacemit: Fix TX timeout work deadlocking on itself
Date: Fri, 13 Nov 2026 18:24:34 +0500
Message-Id: <20261113132435.434615-2-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113132435.434615-1-alitariq45892@gmail.com>
References: <20261113132435.434615-1-alitariq45892@gmail.com>
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

emac_tx_timeout_task() takes RTNL and calls dev_close(), which ends up
waiting for the work itself. The function call hierarchy is as follows

emac_tx_timeout_task()
    dev_close()
      emac_stop()
        emac_down()
          cancel_work_sync(&priv->tx_timeout_task)

The work never finishes and keeps RTNL held, so after a TX timeout
everything that needs RTNL hangs.

Remove cancel_work_sync() from emac_down(). Disable the work in
emac_suspend() instead, and enable it again in emac_resume(). emac_remove()
runs before the devm-managed unregister_netdev(), so use
disable_work_sync() there to stop the work from being queued again.

Found by code inspection. Not reproduced on hardware. Tested on Orange
Pi RV2 (SpacemiT K1) with suspend/resume cycles and kselftest, with
lockdep enabled.

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Reported-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Closes: https://lore.kernel.org/all/DMO74K2MG3D7.15UUOU1O66K6N@linux.spacemit.com/
Suggested-by: Vivian Wang <wangruikang@iscas.ac.cn>
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
 drivers/net/ethernet/spacemit/k1_emac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 71a80838bffd..51edc95f54c8 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -1732,7 +1732,6 @@ static int emac_down(struct emac_priv *priv)
 	napi_disable(&priv->napi);
 
 	timer_delete_sync(&priv->txtimer);
-	cancel_work_sync(&priv->tx_timeout_task);
 
 	timer_delete_sync(&priv->stats_timer);
 
@@ -2010,8 +2009,9 @@ static void emac_remove(struct platform_device *pdev)
 {
 	struct emac_priv *priv = platform_get_drvdata(pdev);
 
+	disable_work_sync(&priv->tx_timeout_task);
+
 	timer_shutdown_sync(&priv->txtimer);
-	cancel_work_sync(&priv->tx_timeout_task);
 
 	timer_shutdown_sync(&priv->stats_timer);
 
@@ -2024,6 +2024,8 @@ static int emac_resume(struct device *dev)
 	struct net_device *ndev = priv->ndev;
 	int ret;
 
+	enable_work(&priv->tx_timeout_task);
+
 	ret = clk_prepare_enable(priv->bus_clk);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable bus clock: %d\n", ret);
@@ -2051,6 +2053,8 @@ static int emac_suspend(struct device *dev)
 	struct emac_priv *priv = dev_get_drvdata(dev);
 	struct net_device *ndev = priv->ndev;
 
+	disable_work_sync(&priv->tx_timeout_task);
+
 	if (!ndev || !netif_running(ndev)) {
 		clk_disable_unprepare(priv->bus_clk);
 		return 0;
-- 
2.34.1

