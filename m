Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273374;
	b=YY4tP/d9pTl4r2s9XiW/nhqlurK3x+9CJXnIW6j9OEJkcQEriTZ+AviUtx1fUMUaAN9z
	 aBDNekkx3BXiCwR/+oMQ6rqEN4DeVFVdMkBrRhb0uaIxYfLVMTMilOIXOTvtENqYzMgQz
	 WTUvexCvoqHDQ4rHYR3tLyK3gGV/4LppUhKZQpy6KFJEgykxa8wHdFfHnMk6DQYWdRn+o
	 c+oDvU39HB4qfrWV55x5hOXq/gu7NYLkS41SYEzFEBqK2wob+J+kDmnZgztnk2ve66V8v
	 IpCLzYzis7eQ7UZ9ZZXEVlvXMq1MHfbghNmhlguYDmzuS3AHTwBzfp0UlYSd+klfhTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iLc81dlIMgk2M36hvoTrJto1aOwZcteM9MGtiO2fY2M=;
	b=wl8oS8i5jT44bow4D6mjRN91iTC4TutKMOdkJJQrk2MozZcJ69+X2JvNqdGIWeA3yPvZ
	 Wrei7JTlhwn7ESdkLUeF0ycGEUae1SJBE7Ul6u3etdQpQvBHJynuVpMUbuc2DLCq6i8km
	 nshubMouViDUGWUvz7srN0FU+QiJ45i5HAQYvpRiIzOYT4d20nzjiztgvRS92z+xxQxnb
	 vhtNg/t/p0Y9crILFRdXzjlFPNy0tL/IAKepi9p+NTJXU+yRF/QDYf5atR05epiEwBOL0
	 htr4UTnizzxiZ/Tidoo7eBZCXFurT/MjjZO8B5iYXbankL2HMH9ro1AStjEQBFFWlQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlYCuXP5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04824606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlYCuXP5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D9D1F008A1;
	Tue, 10 Nov 2026 01:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273373;
	bh=iLc81dlIMgk2M36hvoTrJto1aOwZcteM9MGtiO2fY2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UlYCuXP5qUbNGVuXojiiiMM/LZU5CtEReERVS6T/FE14g2XvIU8dxGcA4pjkCn8Jc
	 391xfNoQN4G9IUko709333YrENN3H6WWN87UCDLBwD26Me4leFURGXEgLNh7VHa4Sy
	 7tRfacETls+qGTwDJ0MtOveNzEtgFvXoOryTOkOh1KPP1MFe2Iyc9aq1fLtxAtP6yn
	 w/1vpYKIaDKZO+UhfMUGpNRkslGHSmK6Mmbrb57TzN8gVJKh29TB5v7i2HsCkwKu/W
	 RgcoKPVNmc8XOnjNy8/ISRf23flRaR5+dydAqVP1Tkf94QTStV7db+lCMp0QF0GtZe
	 GJNK8m9cVc0og==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	ulli.kroll@googlemail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	mirq-linux@rere.qmqm.pl,
	mhun512@gmail.com,
	edumazet@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 01/15] net: ethernet: cortina: Keep shared free queue parent-owned
Date: Mon,  9 Nov 2026 17:16:11 -0800
Message-ID: <20261110011611.1733276-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-1-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-1-c4b5ff8a65d8@kernel.org>
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -2683,6 +2686,8 @@ static void gemini_ethernet_remove(struct platform_device *pdev)
>  {
>  	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
>  
> +	devm_of_platform_depopulate(&pdev->dev);
> +	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
>  	geth_cleanup_freeq(geth);
>  	geth->initialized = false;
>  }
>

[Severity: High]
devm_of_platform_depopulate() unbinds both port devices synchronously,
and gemini_port_remove() ends with clk_disable_unprepare(port->pclk).
By the time we get here both GMAC gate clocks are therefore off. That
includes this writel() to GLOBAL_INTERRUPT_ENABLE_4_REG and the
readw()/writew()/writel() of GLOBAL_SWFQ_RWPTR_REG and
GLOBAL_SW_FREEQ_BASE_SIZE_REG in geth_cleanup_freeq(). All of them
access geth->base while the block is unclocked.

The parent cortina,gemini-ethernet device does not hold a clock of its
own, and the global registers need at least one port clocked. On ARM
that means one of two things. The writes may be silently lost, which
leaves SWFQ_EMPTY_INT_BIT enabled and the old free queue base
programmed. Or the access takes an external abort on unbind or module
unload.

The child path has a similar window. The clock is gated in .remove,
but devres frees the devm threaded IRQ (gemini_port_irq() and
gemini_port_irq_thread()) only after .remove returns.
SWFQ_EMPTY_INT_BIT is still enabled at that point. The thread can
therefore still run geth_fill_freeq() and rewrite
GLOBAL_INTERRUPT_ENABLE_4_REG on an unclocked block.

Could the free queue interrupt be masked, and the queue torn down,
while at least one port clock is still running? Another option is for
the parent to hold its own enable on a port clock across remove. Which
ordering did you have in mind, given that port 1 owns the refill IRQ?
-- 
pw-bot: cr
