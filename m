Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A444781D
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247242; cv=none; b=cUJKI9T9B8avG3A9B25GMVS4RyNgwfMLofb5Mui1Zmh1Hh+mdEMWerND4Yxdyx9K0mrEklZy8gKAW2nV9yi3lnjLRjCI6wCVkg3qgVpe0UolRKwetHv78kQkI3vikqp77Q4iLKYfpSwwmCSHWJf0F17gil4RlpkJ5tNgS+JXOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247242; c=relaxed/simple;
	bh=yQ+T5Ig2umy2X6QmQLO7nNL1YJXLL5K5uevADyKtPQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bmj3BVKKnv5DNq/jrpk+Ja7C5HG9EefVZi03qAduRSUXR46rP3EItmVVFWBR2XPLtXGdo0oYvx0LvGsL/loCCOHtC7cQpyxLhUleW10Q5LLqafidQysxRjqTdJJHq8C6UcsEEuElk5CXkJeH6kLkH/liQqbOh28q43pO0/rVuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqQDcazg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqQDcazg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035E01F00AC4;
	Tue, 28 Jul 2026 14:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785247241;
	bh=G/GSzkl2Nxca7CIyFcabK5xtVIYKYECe6sj5eIIHwJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kqQDcazgaOOLR3VEAlLG6nz1zlIXJFUOB62R84OLjHT7shjH0WrTnmPu7DHksgWNx
	 MF6PjYpFXs4wOh79whWUo1YWkKchRiEuVTorf4AlaYDI2g2ZWnH6mxhWO+us3Ciqcc
	 WvRyLKDcSx/nrR56QnnQBPXbpTMaxB+rSeABuTlps2kscITGLALDAenzhIX/mTyiAi
	 GCJ6I1KMo3RIbGdWQBDpJmWq3UYmEOiYVt3MZKjrhxa0zUQyglrGEGuSbrXlSK2MSE
	 F1AFSvXQM5DUZ7mZVXSEzJugTnk5hWYDnFeYpl63BtQljFGO5Eq6iPSzmh1zRz17b6
	 e8uGgfHqXZtjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DC380DBDD;
	Tue, 28 Jul 2026 14:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: pass eth to
 mtk_handle_irq_rx in poll_controller
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178524720564.1742182.12718299327810762541.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 14:00:05 +0000
References: <20260723055735.885112-1-chenguang.zhao@linux.dev>
In-Reply-To: <20260723055735.885112-1-chenguang.zhao@linux.dev>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, zhaochenguang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Jul 2026 13:57:35 +0800 you wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> mtk_handle_irq_rx expects a struct mtk_eth * (matching the request_irq
> cookie), but mtk_poll_controller incorrectly passed the net_device *.
> Calling ndo_poll_controller with CONFIG_NET_POLL_CONTROLLER enabled
> would then crash.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller
    https://git.kernel.org/netdev/net/c/e095f249e220

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


