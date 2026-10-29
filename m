Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290808;
	b=jUu6jJK2yD5aXTqt1CBZTQ8whIfLrC3c2TBfuC3SS9rPH0OjGF2bvP6Q2cR1c2R0Qsca
	 t25e7DIryGcAHhuQlZnvUDJoOda0rM9a/Leu5xevLSMTj4BWgZN+hDu3hcMaeA3Doj3Kl
	 JSaVBHLefs3mLsnHECyDQ3h4wTzDrEsee3RB41XwA1TI7t3iwfWWK0EV4Gk6vVM46Hn3n
	 hAPtenfGIkK8xGGMS5rkC8D3kmQndoRVf9s7lBZQbj8OMlFFOtkgJKfDrA2E9y8xGHtR5
	 sqIiTfFX6bE2T9EcILu05x5xH71/1mvTL3QILq+BKjodB3PEysiS9eZBi1+xo/OMCbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Gbja22d6UKjm7krU3kGAv1el+OsHxzpOScOFCxLQ3s4=;
	b=uTomziT3Zc/e51pfvcpEpTS0hihD/EP30Jk1K7+wu5rFhv2ID4OrhHmp4D8IAO4OEtZg
	 cI0QkZthaoSPf0GBapoJYqJIWD6Me7Y1maIxgXnBcGPSM3Ww4qG2ky6FD6f7Mk5FABDx+
	 bbAYSN95m9q5nz2KH2pccI+EAKWa8KqIljrGWkFYeU/rnWURTyiTvBCa3ux7vE2cq7SOS
	 AON7KmvKcei6LdFoaZKJNiIjBqF1FXdOshL0RnJd3KaAMlWmgM4G7nivoU2E7+bxoedRt
	 TytN/RJVtg9vfgmdaq4u7GNa4iiN0ZwA268ODlXr93BUDOW75FJVV/0GjwweSua4nnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4jh6zj1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A22606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4jh6zj1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0A61F01816;
	Thu, 29 Oct 2026 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290807;
	bh=Gbja22d6UKjm7krU3kGAv1el+OsHxzpOScOFCxLQ3s4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d4jh6zj1rXRTMHApc1xnMvRRptoqvjS2aR3hWX2cGUlDYSFgx9fnD6Sa2zPQKy3mt
	 iujRcwxCmoy+HVy+M8KA8Ki9RXTyZpoj1AQ4nuQpY5ihwgjXiT6WUuTrPSflKL3VwR
	 OMAr+MywMB/rHH3LA4IwUK1SAkT5GcveBgm5x69DGwC4kWkCK82B/8arMtxWCX6A8i
	 b+VinVhATu42ftSHoDiWJ8y0tf5Au1zHZUAMvgJAjZxu9aSGWJJi4zBx9C6vHaeg5n
	 VVI0NMWoERcPBBJEz7Ca+OhTpD/ox2ghH4NS0qypZEb1AXShgeXhptC6LVzmO2Y3L5
	 2Uzxku6MscnJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 402973808221;
	Thu, 29 Oct 2026 16:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net] gro: do not GRO GSO packets with inconsistent payload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329080605.553408.4857757191980623326.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:20:06 +0000
References: <20261028171350.2205175-1-edumazet@kernel.org>
In-Reply-To: <20261028171350.2205175-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, kylebot@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 18:13:50 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> tcp_gro_receive() excludes empty non-GSO packets with the unsigned
> len - 1 check, but its GSO branch only checks that gso_size matches
> the held packet's MSS. A trusted TCP GSO skb can reach GRO again with
> no payload after TC pedit increases its TCP data offset.
> 
> [...]

Here is the summary with links:
  - [net] gro: do not GRO GSO packets with inconsistent payload
    https://git.kernel.org/netdev/net/c/de788d8a7032

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


