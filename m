Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C448664A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054869; cv=none; b=oMJIqX0eh1i9V2SGv87/2nTyjEe3UJMR4IX/1zTTbGdMH0HvJQ62hMxzRvfUyo7xcA0r4xq3GqulDAq1IUL8qx2ksqfPjwQYy9M03RcnX/2/RtvclIWiTW5QOaYu2yLwVtwY9vF4Y0TwyHLjb+DMOMwWpXrZimaqNRNca1o1ZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054869; c=relaxed/simple;
	bh=SWVygpAToW6QP3p7ii5LswHN802F1rcn7UsedAa8/eQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sQ1ViX+rJbkz8OafraD/OUVDBMdTPC82U9Ceb32PMWBuUjtDvVf9zoZ6GHhkRNN83HGcFT4+oqqJmtyBn3JU7ADSE14lMEtBe1FG+YWTZDSC9EjBVdmW7YtGaMBadZ6GUS0+w2F2ctbRQfaEzWu8mhCnWuM3sqmTygVTNmFy6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DovwmqI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DovwmqI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AE01F000FF;
	Thu, 10 Sep 2026 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054867;
	bh=djiO85oS8pp5OwgcWxxA+1nEL+n9+Dqo+t+O+D/6AZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DovwmqI8gHCvbNpzUvvyH/y7BW/NuQXPK6xwohKCPqPQhTZawA2C5Vb8Wcr4LfJv/
	 Jeb7zVVwe2Z4greXVBAaZ/ifjDd9wBwiMB5Z8gjpadV5sQ1JLoogRIHDPmIX2T7wmq
	 P4saumim85AkOUgPC3hXikziyvq/qAG5kM8AGgWjFV+3gZHroECcmRt0p+sPTHDGye
	 84rX1LgDFOusE/cv/QROrFsW0Gyco/oIeRo2/HX2UrOXUN4l4fhh28+80fp10YZMCK
	 EE/5zjpDZAICAHwK4zF87BeAEZSCARrC0/uPfsEHAinpD1lrsNYxat2nlGF/6aoCsJ
	 lyxo8DinB1WGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B40380CEF9;
	Thu, 10 Sep 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: fix TX descriptor availability check for
 TSO traffic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178905480513.1504082.12531935982183581.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:40:05 +0000
References: 
 <20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb@oss.qualcomm.com>
In-Reply-To: 
 <20260907-stmmac-fix-tso-nfrags-check-v1-1-328459906cdb@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 peppe.cavallaro@st.com, alexandre.torgue@st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 07 Sep 2026 23:46:45 +0200 you wrote:
> stmmac_tso_xmit() estimates the number of free TX descriptors required by
> a TSO skb as:
> 
> 	(skb->len - proto_hdr_len) / TSO_MAX_BUFF_SIZE + 1
> 
> which assumes the payload is split into TSO_MAX_BUFF_SIZE chunks. This
> underestimates the descriptors actually consumed by stmmac_tso_allocator(),
> since each fragment is mapped individually and so it needs at least one
> descriptor regardless of its size. Moreover, one descriptor is used for
> the L2/L3/L4 headers and, when the MSS changes, one more is consumed for
> the MSS context descriptor.
> For a highly fragmented TSO skb the check can therefore pass even when the
> ring has too few free slots. stmmac_tso_allocator() then writes past the
> available descriptors, overwriting descriptors still owned by the DMA
> engine, corrupting the TX ring.
> Add stmmac_tso_get_num_desc() to compute the exact number of descriptors
> needed for the header, the linear payload and each fragment, plus the MSS
> context descriptor when required, and use it in the availability check.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: fix TX descriptor availability check for TSO traffic
    https://git.kernel.org/netdev/net/c/5e38d732ec67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


