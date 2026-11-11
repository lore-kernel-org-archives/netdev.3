Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359406;
	b=G7la76txb5QnVQLPb7Wl+1uUbFY52gnBhtz+QM0tjp2HIIFFxCLEvyeDygXcXEMNFv5z
	 GTgqueDD6blR7NwmBFxbHR/HXjjGjl53iS7F5yLkLQ1WlCZL9uwLzR5CA2o6WazZj96vn
	 WWZiNYJVxeDmdIT1pTz1QJayrAi1+R9w8h+rnYPqFYJRwDZxd+Q1VJTJBAD84EG0BikXt
	 sTdz/fqH2EqRDw/stC8INs47v+9/xUS30P9ntWDt0IH6MWUtNka0bbpYPi9fnTPKEXN2/
	 eFIFyQuUKXtEuW2Ri4Awgapds1K6UzmZCRpMt3iLsCOtZIXEpAa8YBqeREk7sR4qrWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yjUwvrkv4SLMUIorZAyMYy8YP7lnL80NfAbtLuZyId4=;
	b=bZnijXd1wtBjHT80a5LZ8jS++AkG6ZiiqY+fM5KF5RRg4dkdlCY70imVi3kjm9zycwRl
	 RYWS6Bmc/5uxDB2VMgKoFtWBUpdxPO76Nt8Ee8l6Nyn+gqQ1Qveh5tpwbjyS7pdPvmvTc
	 ho0zt+i1H9sHi9cVXE7hhdsm/O/Gr3nlQhxLn/q5p5Mkf+P1jOMfRlCfXvB96kmPq3iXe
	 Xqrl/i0FMGVa5IjTLeKT+ze/XCQrPnZsKChYv1hSQSOZrNoZNm9i1zF/3jYSC+++6a5bT
	 8/UcF9l5ZZ2klY2ngPHf76biG9eI9Kn9tnGyyUn+a38F7HBvpSv9Mg2gKEEbN52ec5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th6w0rtY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF490606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th6w0rtY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C11F0089F;
	Wed, 11 Nov 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794359406;
	bh=yjUwvrkv4SLMUIorZAyMYy8YP7lnL80NfAbtLuZyId4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Th6w0rtY6/FNu2Fwn7SRNCAvZUAK9dAs1OjMGqfRplU0dknAznrZW/S1LZB3BQ0Mj
	 6k2xrAPJvNRXHO7YbbdWFTLLT61MlpAV4dRK+zaX4lXMUXP+iDAGWGlrOpnKAE0F4z
	 xPHBoub0rEXZG/2lRCWxvyDcrOxsgeiSPjPQsf9rwASl9uIxSN7R8czFFshLanvWZZ
	 30PkHMBzue0LNnJECQKTdzBrc5L9m2K3Ed2b+HN7nBjPBtb/stHsukFrBkjtuzMtBe
	 V8IBa2Bb37gpaieFtKB8w9tT3jdKPdxww0kvIP7YP85tVaO7JJQbCiT2iopyRDcC3t
	 usXAxT175OWBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20F71380CFE6;
	Wed, 11 Nov 2026 01:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net] net: stmmac: count XDP_PASS frames in rx_packets on
 the
 XSK zero-copy path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435940493.149955.7586683481024134656.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 01:10:04 +0000
References: 
 <PNYPR01MB11444552E41C2B17A992492C0FD762@PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: 
 <PNYPR01MB11444552E41C2B17A992492C0FD762@PNYPR01MB11444.INDPRD01.PROD.OUTLOOK.COM>
To: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, jszhang@kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Nov 2026 06:12:51 +0000 you wrote:
> In the AF_XDP zero-copy RX path, frames that the XDP program passes to
> the stack are handed over by stmmac_dispatch_skb_zc(). That function
> increments rx_pkt_n instead of rx_packets since
> commit 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where necessary").
> 
> stmmac_rx_zc() already adds every processed frame to rx_pkt_n, so each
> XDP_PASS frame is counted twice there, and rx_packets, which
> ndo_get_stats64() reports, never counts them: on a zero-copy queue
> rx_bytes grows with the passed frames while rx_packets stays still.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: count XDP_PASS frames in rx_packets on the XSK zero-copy path
    https://git.kernel.org/netdev/net/c/070411c1590c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


