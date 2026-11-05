Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882154;
	b=VX5DM80kZkGPArIEZzkIYXHZRjx5rLsQve/FTYMxGCb+Oqn2SHOY3PCgnA1yFCPup/ck
	 ceG+9q/knxonPEotkkp/eBFe+roJ6pEFd06OsEv3yBpsk1i0iVU36WbtJ7tg0yOD+GJEI
	 j65BYn37xzFCXd7PzSRe7DBoluOXLetwCbpLeydZMzkzwEEuIAMqF4M/VV5DdD/fJGC6Q
	 eHxftEGf06q2r+lDcX69AhwofYJa99l4GobvSbGTinW+XsStWflUv7ezFqRNDQOlp9kqR
	 WLeWzNSAR5V4eeeVQVHnm/qSnBDDH0uiMfzomlyvzyVHx3Epb0W04irlyiw0f7nlKFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=C/jFN8eJhh5ybkPCJN1GH5EEF9QQtG/kp2iWAhig7A8=;
	b=dbtff/z5FCJUSkniVHHpaswb+pm3mwPDD3tAaX2Pm4dSOcvu50KFi18GpxaVWT7AcQbC
	 6pUp099zFZItalEhHDY6tV8teq3i5LGCtLA35xCAGeHblikhPj2HpBu86FJg4x+dEhJ5m
	 AMzd6GN1pShyE+E4TexHRgGJAT2H4Zeu44if35V4u9n/3IMM/h62Jk/wAd5nMD9cUGE93
	 zeceKGXwhOR56KD1G68da+Q3YCi6Dju2eWLfga9BqFese96yPI1S1xcxc3mrPBee7I7ZK
	 tBG6ywaFZtbDVCDIBiI/2KERnjVzxUY/BHteXZby5BOqfW9L9zqFzp8KzK7u0hROiwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxNeF09D;
	arc=none smtp.remote-ip=74.125.225.128
Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D6606A33D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC1D6606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxNeF09D
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-4a2d6bfe8d6so6354475e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793882152; x=1794486952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/jFN8eJhh5ybkPCJN1GH5EEF9QQtG/kp2iWAhig7A8=;
        b=dxNeF09Drx7SP+/EAEAAySXQDWD+PZ5Bs+gCemajEGb8/AqPnDNXfGIkUodmf0BQPv
         7PmPDF1I2XU79FVq8IXE3booYtLfQl9sGtuzPtkhpa0HVn4iZOeN7+u95wSPjMZwlWZ9
         Xzs7srFlcYWXThszNe2wDs/0kfSdBynxYErtbdEkU41Dp+IE/flGo2UzpRXSDv5LGSjN
         sWIcLOHi+8W845oloqgpSLcjIsKjzUzATme8gdez03xmriLdbGHRGcdBHfWrwXTgB5r4
         IgZsz3RM6qEolQbne6/IWafy2Sh9gXPoRyhVc5FI6COB5A21e5GjePyJcx2pM4ii44XT
         ni3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882152; x=1794486952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/jFN8eJhh5ybkPCJN1GH5EEF9QQtG/kp2iWAhig7A8=;
        b=Zs1jz9W2ClgjFLBmCQt40H5blLz5hK/QhnZpadR+ALTxyeAYOI7gejA82NYBP0WMov
         N9zNBTQnb1ZAIo/2xu/nablPO9ovGIJSx2IAsbhj10kZIKW4Iq81QGRc3X1bUZ/wI1u7
         uOlsl4+7TsohAelvHy2/4IEW+iYEF//o2a6MlT48P7zVDPFSY0Rld/o4gmuhSWfy55yE
         qJFnkQe5taFXq4lyXmT4NwwKsg6Wi3otFA6tTSGpkTmrsMTLDK2btFKwdrMOwxikMPYc
         zQOBSaHkRt27brawth6Y/bSeP1nyAMdu7WlTuGhvmmV6rmYiMFxgFwrqKaUPSUk022jV
         q5lQ==
X-Gm-Message-State: APuU4Z92unnZlb9F7GzGazYHigt0DdCPDoxf5c6YympfZjdkKzZfKCaB
	edRUpC0W6u/2UzeM2g/WiUUo5EGmFG9hA/4DeZdp7rWHTBxDc4KkU2EswLMAJF+uHcc=
X-Gm-Gg: AYBFou1ZSihMavUUJ6Bj7PqOkXnd+/3AP9IIaekMcKc9Ju/FPQPntVOKMyR29XTgyTq
	v9pX5AyXGubEicH8AlTttYwdenmQ/lASK+fgkdkgfc9Ejq7BPsYU6kvvPYtrGLoLTZzeLF1T7XE
	rRqnuQwxaksiMnWyfMIyM4xVBePeYQL5fj0Quh6J9AmL+iUOo7y3rfXeKeWWlKaLQG1ZAwzRs3P
	OkUKu5pgyjlDcyI+KWPz4N33cYA939K4auglSoH+FiTI2RHXyrAtEd1Hn1QKrxlQTr9h6nI1pdr
	IdpXFkohevjdYE7RWSwxpeXvW7zjZWyJzRUJPPBSMpZEmHRUzEMwjgO1g2bbRfCwGB4fcgFvAuF
	wWfNM6Ya+0E0EWkiLLAYDNF6d4dwo+iB5w72Ud7Zcj3jEIUz4GDUHEiHGifExHUunSCW6tQ+u+q
	q3cL3Zsg+79Ey9jPWEzLJSQQpmsrFc51oUHfRCk+arB8roYx3Le8q+AUW8j+0SmEmoRFrybSdiO
	MK46VHwzI/S66GPGgSFqmlE8SBMOBziyqHrtEq7RTjYusOPxnQK7mTpZVBQzsD8cLbYfKfTw1NN
	Sr7/DX1mYKb9wJP546Ez4NsJXhcQMapcH69e
X-Received: by 2002:a05:600c:3547:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4ac1889d442mr421740485e9.22.1793882152080;
        Thu, 05 Nov 2026 04:35:52 -0800 (PST)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm114419535e9.3.2026.11.05.04.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:35:51 -0800 (PST)
From: Ali Tariq <alitariq45892@gmail.com>
To: netdev@vger.kernel.org
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Tomas Hlavacek <tmshlvck@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and emac_suspend()
Date: Thu,  5 Nov 2026 17:34:37 +0500
Message-Id: <20261105123441.2524171-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The emac_resume() calls the emac_open() and emac_suspend() calls
emac_stop() functions directly without holding the lock through
rtnl_lock(). These functions rely on phy_disconnect() which reads pointer
with rtnl_dereference(). But since no lock is being held,
rtnl_dereference throws a suspicious RCU usage on
Orange Pi RV2 (SpacemiT K1) warning when lockdep is enabled.

WARNING: suspicious RCU usage
drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() usage!
Call Trace:
phy_detach_internal+0x490/0x5f2
phy_disconnect+0x90/0xc0
emac_stop+0x114/0x626
emac_suspend+0xac/0x126
platform_pm_suspend+0x72/0xe4

Hold RTNL lock before emac_open() and emac_stop() with rtnl_lock() and
release the lock when functions return with rtnl_unlock().

Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
Warning Log: https://kernelci.cloud-v.co/scheduler/job/549#L2168
Fixed Log: https://kernelci.cloud-v.co/scheduler/job/557
---
 drivers/net/ethernet/spacemit/k1_emac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
index 71a80838bffd..aca25a9e1e9e 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -2033,7 +2033,10 @@ static int emac_resume(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
+	rtnl_lock();
 	ret = emac_open(ndev);
+	rtnl_unlock();
+
 	if (ret) {
 		clk_disable_unprepare(priv->bus_clk);
 		return ret;
@@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
 		return 0;
 	}
 
+	rtnl_lock();
 	emac_stop(ndev);
+	rtnl_unlock();
 
 	clk_disable_unprepare(priv->bus_clk);
 	netif_device_detach(ndev);
-- 
2.34.1

