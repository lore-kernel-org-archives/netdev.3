Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794360607;
	b=WJ1nmZWOtRJ7K/XeSdRqBX5w2Fhwqz0wVgD03Ka1bdaOspjVlRSZeVT+pn0MV43qaEuz
	 U+MQusI6t42nz9wIZIogIOYvJEDpgb5pH1T+LYQKIUACd/a1uGmq9At+rKI18q6paL5OY
	 vmW150nIRv3VAphYycscdnXJit8RGAzg6sr0xP9eZ0G0+OP3aKSWe0UpDEbNwj1479ofJ
	 vtzTphy7uOJDnkeUV0UN0kLIp0lonaJ3NOWrZeI9YwSuVCYziB8kSOyNDw+IotmqlLeS6
	 czRzh7lTa9ZmsHj4vOfzkvIhriBeqXYl6vpdouFe0+GKyHqEghsx6gX5PqdAXuJdG1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794360607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=SPTNYPvwkrprqbuEPvtVawLHaH9MDFVszNUbyTC+uZA=;
	b=GudT6Q0aA/kNdtlpm/TFvqMz+RxHL4wFCobiPtv0tI5z5BV7JAbhvZ+kWihTz5EEpFk3
	 r7ztRXDAhgzHHDtOxTRhAphzFcyFyZUfc3yNixsZ6v6jLXXwkAUOrWc5Ts/3mOeBY/G3s
	 xf1gksmvPc86nKg0iPTExMjCd3nV1oUJg8nq2an3aXq6tkmMuGdrvw00DYlYQ4m4AplT6
	 AFALsUvu6iJ3mXgE51Q1cQtIpwidhkZqbQlOKrAry7tfbjkRwwwv2AuBiptbbmAIjsZfh
	 zWkI7tM17LWDgs/uE6YlcxyIbXJcL6krc4OCXBD2drjo74xRDa8ST/aIoVs0SYlSQEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmXnS+n3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DF2606A31C;
	Wed, 11 Nov 2026 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmXnS+n3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A891E1F0089F;
	Wed, 11 Nov 2026 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794360606;
	bh=SPTNYPvwkrprqbuEPvtVawLHaH9MDFVszNUbyTC+uZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NmXnS+n3IVDwNxKKJ5V9afdFDokjBHTG4CEvcTjqLjSPbmA16QbyM4qUqZJH4kWGx
	 wuuDIMHe10E2+kW15qyqHOq68ikQzKQU1BppCkx5QSoj7i/SOPHqu48J9uF9+CNvhk
	 BpXV2UPIq2LispUYGY0+Ded7XC6wjuGtzGawjC+7XEx56aGpI7Fp5HArpgAM9kPM7y
	 wMS6bW6bzMWxji5hV+hx3fEGnKwZxtbZp8ugExV3tUmZqCWaBZUJn0wZGhy4AH1Nzs
	 yqWslI8hLBKdfjBTqFAOu3VOSoLqml+q9yc0XDTnpQSR8nRhs47zFAd0RbM6QnEGl3
	 YuDvaW0fQfMXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B22C380CFE6;
	Wed, 11 Nov 2026 01:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: stmmac: dwmac-socfpga: Enable multi-IRQ
 when
 per-queue IRQs present
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179436060543.157602.5564991900162840266.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 01:30:05 +0000
References: 
 <20261105023245.4683-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To: 
 <20261105023245.4683-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Nazle@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Asmade@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Muhammad Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 dinguyen@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 18:32:45 -0800 you wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Agilex5 and other SoCFPGA platforms can wire per-DMA-channel TX/RX
> completion interrupts through the GIC as named platform IRQs. The common
> stmmac platform code already parses "tx-queue-N" / "rx-queue-N".
> 
> Follow the same approach as dwmac-s32: if all configured TX and RX queue
> IRQs are present, set STMMAC_FLAG_MULTI_MSI_EN so the existing multi-IRQ
> request path and INTM=1 programming are used. Otherwise keep the single
> macirq path.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwmac-socfpga: Enable multi-IRQ when per-queue IRQs present
    https://git.kernel.org/netdev/net-next/c/79ee9e676872

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


