Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E03515CB
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789248975; cv=none; b=e0A26zsVn8npZ031sVkNIva7cGcBiWs8OwKUK9WU6BSToNuu+gkPFi0n5JreMIGj8JowdV1dMR5Z6IQOA8/LCXLeyqgHA/Sw8d3j5mOHqK0wpGyzOWdxR8uYT5gfOInVlaUWi3hzCM4RdaO/nqhUewPVn0KgTD8tDBDFKrD8BUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789248975; c=relaxed/simple;
	bh=t3Z5cYxxBEPQ64epRTp9x58qAFYm5G8zgWcwPt6GQcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbTLfFSrqTnkCnyPTuoCVypBGA6rZwEFagscbJaQ+sjePPtXn7sfr7R6WdJQiBHiCJPuMyG2tF2rV8xgcYMbJm6ec/xy2FU0xnPrfzMQRVyAwBNgMJSutrTk8+iGSr1jsS2atCLGVCI3eK+PlwlF8DzbhDMCSrYkw5HTCkFzJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w+oXppiy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w+oXppiy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 789911A030B;
	Sat, 12 Sep 2026 21:36:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E44CE60580;
	Sat, 12 Sep 2026 21:36:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C302611C7AFB3;
	Sat, 12 Sep 2026 23:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789248958; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=N/CbiDPrUOsN+7DAN3mxpptlWvTyBYiJ+JQCnLs+z18=;
	b=w+oXppiydFxBpp5BUd31WCr9pmxENm2EDF8f4NAQ9wHCCHuLUp9Bp4s0RTmbvquk0fVqGd
	RKl4I2hzWD+RAkVx4kbw+bZOlAWjOqqbKy9B/Ln7uPyWMYy//XqoN2NgDTTqCj0grpaBPm
	1o0pvbduZkdmAKCDvnhjKV8ZtGoEYGtgJsOf5PsH/+/WQEOYvW55k0q+SYmhi/8vJm5qOG
	VQp5zw7iXmh7gGc3TUPVuYs1AuWRM3ILC+DGQkw8j6pBcB0dqmWLmFHTFzSZH/5syzeq8Z
	JZKHe0RTg8AcD3SHzk9ei3k/LjlgbhxwDROAY1HpTJh81ElS0y14qC8uZObtug==
Message-ID: <7d72b99f-ca65-4ad4-954c-b3f9d07de523@bootlin.com>
Date: Sat, 12 Sep 2026 23:35:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: stmmac: remove software VLAN tag stripping
To: peilinhe2020@163.com, he.peilin@zte.com.cn
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jiang.kun2@zte.com.cn, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vbridgers2013@gmail.com,
 xu.xin16@zte.com.cn
References: <202609040845307827XHaxAT2PmgJc9jjPqfAP@zte.com.cn>
 <20260911141126.10592-1-peilinhe2020@163.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260911141126.10592-1-peilinhe2020@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/11/26 16:11, peilinhe2020@163.com wrote:
> From: Peilin He <he.peilin@zte.com.cn>

Eaxh patch should be an independent thread, not a reply to the previous
one.

> 
> The software VLAN stripping logic in stmmac_rx_vlan() was originally
> introduced in 2014 by commit b93819854d6e ("stmmac: Add vlan rx for
> better GRO performance.") as a workaround to improve GRO performance,
> since at that time GRO could not handle frames with VLAN tags. However,
> this limitation was resolved in 2015 by commit 66e5133f19e9 ("vlan: Add
> GRO support for non hardware accelerated vlan"), which added GRO support
> for non-hardware-accelerated VLAN frames. Keeping a software fallback
> path for VLAN stripping is no longer necessary and only adds complexity.
> 
> Fixes: b93819854d6e ("stmmac: Add vlan rx for better GRO performance.")
> Signed-off-by: Peilin He <he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Jiang Kun <jiang.kun2@zte.com.cn>

So this patch breaks all the stmmac selftests on some dwmac1000, e.g. on
dwmac-meson8b  :

# ethtool -t eth0

[trimming the output to tests that don't report -95, i.e. -EOPNOTSUPP]

The test result is FAIL
The test extra info:
 1. MAC Loopback                 -110
 2. MMC Counters                 -110
 3. EEE                          -110
 4. Hash Filter MC               -110
 8. Flow Control                 -110
28. Jumbo Frame                  -110

However I'd say this patch is still correct, what seems to be happening is :

As now we don't have the NETIF_F_HW_VLAN_[C|S]TAG_RX flags set anymore, the
platforms that don't support VLAN offloads end-up skipping this check in
stmmac_phylink_setup() :

         if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&                  
             !(priv->dev->features & NETIF_F_VLAN_FEATURES))                           
                 config->eee_rx_clk_stop_enable = true;    
 
So if we enter LPI during the selfests, PHY stops rxc, and notoriously on
stmmac if you don't have RXC, half the features don't work, and especially
the DMA RX path.

This is confirmed by running :

# ethtool --set-eee eth0 eee off
# ethtool -t eth0
The test result is PASS
The test extra info:
 1. MAC Loopback                 0
 2. MMC Counters                 0
 4. Hash Filter MC               0
 8. Flow Control                 0
28. Jumbo Frame                  0


A solution is to block RXC from being disabled in the selftests.

Can you add the following patch to your series, as patch number 1 so
that ethtool selftests still work during bisect ? I've tested it on
the board who'se selftest failed with this patch and it works :)

Thanks,

Maxime

--------------------8x------------------------------------------

From 9e4bea5f2292521997ef6b3814b586a9623993aa Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Sat, 12 Sep 2026 23:15:03 +0200
Subject: [PATCH] net: stmmac: selftests: Prevent RXC from being disabled in
 LPI

RXC is critical to the RX path and some register banks in stmmac, so
it is blocked from being disabled in LPI when we know we're going
to need that clock.

During selftests, we're in MAC loopback so the PHY may enter LPI and
stop its RXC. This will prevent the RX path from properly receiving
the looped-back packets, hence failing the selftests.

As the NETIF_F_VLAN_FEATURES may be empty on some platforms once the
software vlan stripping is removed, the phylink config attribute
'eee_rx_clk_stop_enable' may no longer be inconditionnally set to
true, hence allowing RXC to be disabled during LPI on platforms
that don't have any VLAN features.

Fixes: 091810dbded9 ("net: stmmac: Introduce selftests support")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index cd7dc99095a0..982c711a9700 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -2044,12 +2044,14 @@ void stmmac_selftest_run(struct net_device *dev,
 		return;
 	}
 
+	phylink_rx_clk_stop_block(priv->phylink);
 	for (i = 0; i < count; i++) {
 		ret = stmmac_selftests[i].fn(priv);
 		if (ret && (ret != -EOPNOTSUPP))
 			etest->flags |= ETH_TEST_FL_FAILED;
 		buf[i] = ret;
 	}
+	phylink_rx_clk_stop_unblock(priv->phylink);
 
 	stmmac_set_mac_loopback(priv, priv->ioaddr, false);
 }
-- 
2.55.0


