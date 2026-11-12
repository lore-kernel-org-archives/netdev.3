Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444008;
	b=Yxbb86dauopU8R5toHyT7IbcdKBQanpVrKNx5yCfxOW0VXdBiIJbVcYQpYKY4GJJ+dI1
	 cceXDJLBrJNwx3tBRSkk+oLwMiQy6UeRqbL5dXpwHIYq9H9WdzGFEq9mpS/vJMqm2W3c2
	 dmTiij7Pju/WfCS9RnOtvs4Qf5m7G7NaYlVa/ifeFix16W4l9YAzvtPJ31RT477sLZ1HH
	 uB/bASO+mOC/tWEkRp5vS0hUfQ3PFxFvJWjIkGnY/JmY4svxputKNgHM7OOrp+jnZBLIB
	 TKrTu/wHAJAWFreKIoeEXilqH8lI8cL4UGwKa5R79gLsGXOZbOeu6Wlas5Pi0jY7e5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Pulm5x7G4dTnPOGRPvkWjRQBu0sc7WIEs/VaZ0XqfGQ=;
	b=sCp5geYu8dNoerIE40CdHd1a06wuEdpEbjQRczLnsRF5ukZR2KHKeQ4/gI1WYTtSS2f/
	 uRxtAYhzfhD+ZPifqo2JMfArcmf1aEnsbIYNiEWrdJmN6eKE9BvVgbmPoBFyrCO3zqFxY
	 0mjcluqJsUhFewt5nOMZ07QoSqoY0gvQNqgjHqptM3Utv1NQFx4Qmi164aaLY3NOTbLep
	 4GddsXrRR8TT0ig0EJjrKfzO84CnY1QFJAMNZlAs0yCHEptjO4tP81V47BuKoIVfRMV9l
	 mfiszhh3d4BPtzpZ8qDnUfLJ8jfCxeBQRtcvKBZXrkEGUcvOOEYU0HvJo8Kc1zB1R4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5sDloga;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3681606A326;
	Thu, 12 Nov 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5sDloga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1331F00A05;
	Thu, 12 Nov 2026 00:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444008;
	bh=Pulm5x7G4dTnPOGRPvkWjRQBu0sc7WIEs/VaZ0XqfGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a5sDloga3by4UHoc0i01LyT1JanaR19dPLmAaL/0p+1sskYrJU7Tpc5rcNkCm0C/A
	 2m3el+NB+fEdMypU7JBJWFSklVBA6/RkMcmZRnooGbKbuQsyZkkKYXEo1MJfHJBgPA
	 DyB9bqAmyBdy93YbZuKKclRCjfKEMwTtcNlDuWw+RHAZfhVLTsit2u619V8af3HARN
	 EJzApFAHin0VecpHPP16+JmerZOAKRPA57kisVt/ybHN29BeAljDZ3T0cITv2JpzbV
	 bUsGblHe3FlDBU6vZEDU8KMVnIwGQ5aT7rKIF0591mbNTEa+1QsvpyPSq6ckRx0jAY
	 heMgLge6PqIqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 211BA391AFCA;
	Thu, 12 Nov 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH net-next v6 RESEND 0/4] net: stmmac: fix DMA descriptor
 ring
 cleanup issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179444400693.1731667.7461680068493203190.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 00:40:06 +0000
References: <20261106090507.1020751-1-dinghui1111@163.com>
In-Reply-To: <20261106090507.1020751-1-dinghui1111@163.com>
To: Ding Hui <dinghui1111@163.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dinghui@lixiang.com, xiasanbo@lixiang.com, yangchen11@lixiang.com,
 liuxuanjun@lixiang.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 17:05:02 +0800 you wrote:
> From: Ding Hui <dinghui@lixiang.com>
> 
> Hello,
> 
> This is a resend of v6, originally posted on October 24, 2026,
> when net-next was closed. The four patches are unchanged.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,RESEND,1/4] net: stmmac: guard against NULL pointers when freeing TX/RX buffers
    https://git.kernel.org/netdev/net-next/c/2bfa1143e190
  - [net-next,v6,RESEND,2/4] net: stmmac: clean up partially allocated DMA rings on error
    https://git.kernel.org/netdev/net-next/c/4d5e7a647e3e
  - [net-next,v6,RESEND,3/4] net: stmmac: release descriptor resources through priv->dma_conf on open failure
    (no matching commit)
  - [net-next,v6,RESEND,4/4] net: stmmac: hold RTNL when reading descriptor rings in descriptors_status
    https://git.kernel.org/netdev/net-next/c/241c2a868326

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


