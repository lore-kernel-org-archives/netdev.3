Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529412;
	b=ljmUZlAULYsQ24Kl/2vofPMyw0R8n+GBIQkxHuO1M23MK6aZzbrJiJFFQQTkv8tIgmWF
	 OxTe29Ox83idUbekOQDKBRnj7atsVV1yYX3C/5sBnX71EtO1ZANUw0WD6icHt6bvukcR0
	 fLZKtEQbukq37+xTN6t90vY3nHx89Q2HtgCbTmHWNoyobDBa5Acc0w4An+R0naajrsIRh
	 qMzy7BxdvN7YjCmO7DB/Mpmy+gDw5uQkzsWnMcuDeoGxbTmIasrMLBVPSKZwSvc8DrswZ
	 VhSwlclof1TUsiP/ZQR2LTKxAA/WyuooMQb+VHRSSSw4mtb2rd7tBaDn5l2EJeQT1tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4kBeYw1QN9RLpUkse88tUQ3URyvYGAihH6x26tvte7s=;
	b=fSn6SdQnue+cd8q6n9EO7IuqGk93EwfGmOasywFR45dCFlZvlCiLPCCRpyZM7Lh/thR4
	 gEOH8VA39dgyVF+MBzD7LFtmz1yySNnV41sO/XJp+u2ok9Hbcylz+qQ4+HF9wMjW1sL8p
	 t9ZTjTKEwnSdBxNr3hbFMm+Pbpq+ho8OfA862jRjQOkiLrcN3FpbdlOf4cThMQIehgkpB
	 fjNHhgWkybvQ7q6qhWqe28tCHVsdew1dgzdngMQYcxc+vVG86fbulxB7gJYiXmk4rtd3R
	 14+2ci++0EdR787/pllJQvh9O4SAJfPGw1yG9znGOXmY5BhmJdADX0Dt8jKBGRhXrYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wsyos3W6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED74B606A323;
	Tue, 20 Oct 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wsyos3W6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39431F000CE;
	Tue, 20 Oct 2026 20:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792529411;
	bh=4kBeYw1QN9RLpUkse88tUQ3URyvYGAihH6x26tvte7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Wsyos3W6vCyeubB6c2YWrKr4wfiTG3RJqLkIPj+G3WrVMFGCyooyplR86mxQqqqVt
	 PU/kfFwK3u3Fkdig6SNbSJhM+DVxdzDlNC0J9k/Z3yxXlgg6MPI5gF+RVZI9HF9Fit
	 lQ/6PVRKeHiI349prrgERWlYCZYJ/yAbKtcCKfQIjLNlrH8flsgLfbfkYg3mLVqhw9
	 Fqn7kP6OxzdosCWtIgSq6p2+vKY3nTbTQ5gobA4f2mpt8dz2tRzbhw7Z3JiPQN4bn1
	 0/ZO/9tZsrXkPc4E5c9WZsKkid/RIdqgD8Mo8q/EFepDSWG/i1+T+gk295A0aaBb9A
	 4aKI1vwszk8Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B49033809A09;
	Tue, 20 Oct 2026 20:50:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: axienet: release every RX buffer in
 axienet_dma_bd_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252941027.202014.1920735438863244312.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:50:10 +0000
References: <20261015084743.1798326-1-maimon.sagi@gmail.com>
In-Reply-To: <20261015084743.1798326-1-maimon.sagi@gmail.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: netdev@vger.kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, andre.przywara@arm.com,
 robert.hancock@calian.com, horms@kernel.org, joe@dama.to,
 suraj.gupta2@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 11:47:43 +0300 you wrote:
> The RX walk in axienet_dma_bd_release() stops at the first descriptor
> without an skb, assuming that such a slot and all after it were never
> filled.  That holds on the axienet_dma_bd_init() error path, but not once
> the ring has been running: when axienet_rx_poll() fails to allocate or
> map a replacement buffer it leaves the slot it emptied with a NULL skb,
> in the middle of a populated ring, until a later poll refills it.
> Closing the interface before then leaks the skb and the streaming DMA
> mapping of every descriptor after that slot, which can be most of the
> ring, and is most likely under memory pressure.
> 
> [...]

Here is the summary with links:
  - [net-next] net: axienet: release every RX buffer in axienet_dma_bd_release()
    https://git.kernel.org/netdev/net-next/c/b59787892d04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


