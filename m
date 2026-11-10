Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331807;
	b=QtdLyeb744zq2TsfwGAubRhCBl3DqmJnho724rnTUimxcUEifLWSsz3ZrUYEsTnIpEAj
	 QHk+tUaB1JOOxq9YMqUiPiWctVT3S75r0ifpx5/g7lLP+n7yKRwbXKZPA43HBAtqGzGgY
	 Gqa0i9dJOUDADbF6jiFuBzALSBv9OHg9UoaOXK/SQWzjysv5wYmN8WcO3nTEG9aqP9tmi
	 ldkirO8fVNJ30Q3f7gQekDQA7G6/6oIlJ7ttAfvtCyFq8cFLw8MIF6H1tSmWzAeq3A9bw
	 QJ4G28Td39cSX4e4yRWjt7EjwNhqwK2C8gMvrkPI4Aw9pqDNovGA2hO6quOJ+2arykw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=LNX7mdKGtWA61r6xVH0doVlTszED6aBSocKUxCf6vnU=;
	b=IcXlLx4p9xI2hcPT5t42jeVXygehHidtLIchKVyZhOjJwet9Arqs3kE1WShwYeHaa9Pn
	 2A88YzUYuBl8cOX6FYC3sGblfja8I/dkECp8MK2Q0800ilhhLu3vyFrERnYhXJJPhrU5t
	 egMInK5dcanvWieRVojTi/yQ4Pf8kwes8+fg3ysMpLapKQ+I1VO56ixvwtUOlpkK+6evv
	 F+9GiC2PXyq7kfGvO3fEeb5ciZTOgATQbUxx04dPI4HdnDe9LTE+Z1z16TNgTgQMPd/Cc
	 wPgcmAfZe5VsDDc0CnsICDjIoggAiIKth7bCK0xi88HwKKPrFF1+x4uNnRS4ihX1k5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPeDXzrw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0273E606A332;
	Tue, 10 Nov 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPeDXzrw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC0C1F0089F;
	Tue, 10 Nov 2026 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331806;
	bh=LNX7mdKGtWA61r6xVH0doVlTszED6aBSocKUxCf6vnU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bPeDXzrwy648+qqNUwqTRNxhWJwDNrKdtvm9R4vzi4frTc2cd3fZzPFWK6UZmPgzS
	 rYXy+UUkEpuHKzmNSHkPo+C+DWBLGohR3riDT3yNFhLVHPXj0dwibG4O7zAAXeIwRp
	 r5Ylcw2ptXytDZ2Caaf/SqYMNRg5qsUTyslPH2r1F1u0W4vwq5Ipj/O3gCc7O/hn2j
	 e4gMbqmrIDZ9dhjneTSetYiRv0RrOp6H1OWcd2nss1/pGHmWA85rvW47xdKWat0NjR
	 PWzysJOFK3zrCKceygUq6pM/nwoV0vGFwvWTBpD0MwIe2IaB92z4TmmpCvQxR55cDr
	 rUytV/k1hpnOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2106939D6088;
	Tue, 10 Nov 2026 17:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: bgmac: stop advertising TX checksum offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433180493.4108107.5616677920393163021.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 17:30:04 +0000
References: <20261102215806.13723-1-rosenp@gmail.com>
In-Reply-To: <20261102215806.13723-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 13:58:06 -0800 you wrote:
> The driver advertises NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM, but
> bgmac_dma_tx_add() calls skb_checksum_help() on every CHECKSUM_PARTIAL
> skb, so the checksum is always computed in software anyway. The return
> value is ignored too, so if skb_checksum_help() fails the frame is sent
> with a bad checksum.
> 
> Remove the feature flags and the fallback. The stack then computes the
> checksum before handing the skb to the driver.
> 
> [...]

Here is the summary with links:
  - [net-next] net: bgmac: stop advertising TX checksum offload
    https://git.kernel.org/netdev/net-next/c/e65a0ec96f9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


