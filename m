Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E522F9DA1
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222073; cv=none; b=fbakBWbVbet/DInc+F9P0fhiCf6FaA3OyD+SFQqWSKNmjbLNxngSJyVH/h2tzsfGjSx2L/E23W8ruzpxROYZHyAO/+Xh8qBwJxB/SbyK6WMMoqy9pHHsas+TiixDcoKpzz1NGloMKcCtCSsOBgpkMc03qM0ttSk38SgFIWBjDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222073; c=relaxed/simple;
	bh=CnNJp48a7ECZf2y7qgFCyWIuEjBzq3fBCR9hZcJ6OJc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n1bHhgCnY2PZfCwHQ5/RgetW5X2ndkYWBusX+iaIHdp2ohmG710gS5yWeeXpjuJSvHbafXeUfpCkegokpOUvcEBmSIqwIkougwxlyP3/E3MvtfxWQtJJRnsy5U95uJ3baC31Y61xybzT1dM3Yj5jhVVOXRX2P1rFShNXNixzZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itSMjdze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itSMjdze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710561F000E9;
	Tue,  1 Sep 2026 00:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222071;
	bh=6bD9pjtuRl9hU9C5HPULWpXB9xdeI4tOkxBYaaThOYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=itSMjdzeLVU9wIpAKN8ugLqjY7/+glY+jcu8UsobxN5MylrXuYCy0VcO6ku9iKjX2
	 E9FW9R+gUUFttJZVJsITkrEcTfBYWVhUewDAT6oMTPkK5mo9dWamCFf2pCg1evpC8i
	 GUxYRlQqwtzmdexmVEHcFLf3jrtW0Elcx8wZlvRB+tq4FEUzjRRumV9vDophjhuL3g
	 Zc855y4daC4J8G30FkIQ7lKxY0w5UlsxgJemLuPrH67mkP1WmGsNpSnL+ZjaCGfpat
	 IXxgCNkG3PIpkZPpZ4wLaVfYtjeChKMCNuEDz3DeYnKNLjX0jk4mND75YX0lda3RD2
	 K3cmTzrqTZoUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93924392447E;
	Tue,  1 Sep 2026 00:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: stop DMA before freeing descriptors on open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178822201413.848040.18166339908544983659.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 00:20:14 +0000
References: 
 <32EB352EB66D74E7+20260827025415.2684733-1-zhaojinming@uniontech.com>
In-Reply-To: 
 <32EB352EB66D74E7+20260827025415.2684733-1-zhaojinming@uniontech.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, joabreu@synopsys.com,
 f.fainelli@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 10:54:15 +0800 you wrote:
> In __stmmac_open() and stmmac_xdp_open(), the DMA engine is started
> before stmmac_request_irq() is called.  If the IRQ request fails, the
> clean-up paths free the DMA descriptor rings via dma_free_coherent()
> without stopping the DMA engine first.
> 
> With the DMA engine still running, hardware may continue to access the
> descriptor ring memory after it has been freed.  Add stmmac_stop_all_dma()
> to both error paths, matching the teardown order in __stmmac_release().
> 
> [...]

Here is the summary with links:
  - net: stmmac: stop DMA before freeing descriptors on open
    https://git.kernel.org/netdev/net-next/c/25c1f6111034

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


