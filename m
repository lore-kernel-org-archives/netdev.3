Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C647F3BD;
	Sat, 17 Oct 2026 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792238380; cv=none; b=JWxWkbEE7uGuK706TF0X347p7KE7j38dVXlfQJ3dG9mTjjKI0uhr7FBBQ48nthU9A56iH621lMps+b3OFFp0jSQTJ0CJCX8gC2KX+bAfEJDviAauj/n4k0SJmxUVmx63SPvIU4WrX4VLIKWUGhAbKA/SU9TbETwRrZrYk7hcxds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792238380; c=relaxed/simple;
	bh=621YrIO8ylWQ9xQ5qO+Qhb/Agh6U5f2hxfAaL+zb2A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hob3J6AMbTPKRv70F4YspjX31c7niOCvz7Hr9RswA7tEoz7TjSZdTvt+2K2hWzGG4TuJP+zQW01CXbsXCO9h0nQ/qU9rlul8BK4HvTV8A4rnstOVaFBBY+nxJLtf7dzSZlV346SEH3c2qzGNKtLh4G/PYpB3qC4ZULm19yAtf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3Ff7PlQi; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3Ff7PlQi"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 405DBA158E;
	Sat, 17 Oct 2026 13:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792238375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y+LCyMncmHfORC/CmtCUyAxcZ6GqwLKg9jdJzxwFX48=;
	b=3Ff7PlQi8PWlcGCpTQD/E5cqDF0wicbvFRXiqLj/ePt11LTUsaguB1LBX2608k+3zndfaq
	xcF+evgzc8jiPQIRJKT7OvAwxba2A5m5nbxVcgqWVQEVGzqYtWlImyxTRE8RIsLB1/BQEL
	XrV1ri0OoY7gLOWrz1cF11mZ8Z4hycgWNlcw5gcfgRCa/YR8BjOIcDQTt2M+ADibsoi77q
	eKG9WT9d4m4wF5nsjvnflLaRNCA8hQuSsA19D5WKGWcZPJz6gx6AQBIsgZ4Cqb6jNXjHko
	8I+WfC1fyHUDS8WEI5vB2wcwrImLqgq9KAh5QmY1J/DrfmWIRftLn0HoegTVgQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 17 Oct 2026 13:59:27 +0200
Subject: [PATCH net 3/4] net: bcmgenet: let the interface be reopened after
 a failed resume
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-nb-genet-fini-dma-net-v1-3-47e7c57f6834@tipi-net.de>
References: <20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de>
In-Reply-To: <20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

bcmgenet_suspend() detaches the device and a resume that fails in
bcmgenet_init_dma() never attaches it again, so an ifdown and ifup cannot
bring the interface back:

  # ip link set eth0 up
  RTNETLINK answers: No such device

That resume also gates the clock and powers the block down before it
returns. Close and the next suspend_noirq then release a clock that is
already released, which the clock core warns about. Leave the hardware as
bcmgenet_resume_noirq() set it up, so the clock stays on while the
interface is up and close or suspend releases it once.

Attach again in close, where __dev_close_many() has already cleared
__LINK_STATE_START, so no queue is woken.

Fixes: b6e978e50444 ("net: bcmgenet: add suspend/resume callbacks")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index fe3338ba81980..cb9951d6036fb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3508,6 +3508,9 @@ static int bcmgenet_close(struct net_device *dev)
 	free_irq(priv->irq0, priv);
 	free_irq(priv->irq1, priv);
 
+	/* A failed resume left the device detached, __dev_open() refuses that */
+	netif_device_attach(dev);
+
 	if (priv->internal_phy)
 		ret = bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
 
@@ -4324,8 +4327,9 @@ static int bcmgenet_resume(struct device *d)
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv, false);
 	if (ret) {
+		/* Leave the block clocked, close and suspend tear it down */
 		netdev_err(dev, "failed to initialize DMA\n");
-		goto out_clk_disable;
+		return ret;
 	}
 
 	if (!device_may_wakeup(d))
@@ -4336,12 +4340,6 @@ static int bcmgenet_resume(struct device *d)
 	netif_device_attach(dev);
 
 	return 0;
-
-out_clk_disable:
-	if (priv->internal_phy)
-		bcmgenet_power_down(priv, GENET_POWER_PASSIVE);
-	clk_disable_unprepare(priv->clk);
-	return ret;
 }
 
 static int bcmgenet_suspend(struct device *d)

-- 
2.53.0

