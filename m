Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789224;
	b=Av6sM+8uUfvHds1gMMTGf3BsabhqWmgWMKwQvwbBkFcLpDMALMZeC1MmH2yv4Vew2cKl
	 AwfQN44e6+9r7R5ZSmLhlwi7Sy0lZuZLcZyXZXJBqczEzzJdlXLWzioeDwFFLj4EDs5e7
	 s0n3OZDDJzvlzmoQjKUVpIEzcamKMiSRFoo0PMg0fRw563P2VWGDeFjShXfV07V0B2ppv
	 YgR7fgWN1FsHdRybhNYOWtEj6W4lYebR8x2CVdBe3eFJ2305rjRSRkR3SqLpGB52hVo5I
	 gLVOSWecHdOLvCns0rlyXrrak378ulvHB+vdfwNw+Y62MR+bPRUOWN3t8t+WopsNdmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789224;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=o7nH0Y526ovdbMYjYOuS2cc9y1ur4eOXOL5barl5Nn8=;
	b=n/dPV2BCXV9arG5812mzkFShS7SrScWLJjlUlCeWM6tS9rXtXqs60ZCKWoNsZoNYCLUn
	 1TLAB6dp7PvwiPpDW4/UZSwljse6VgM4DXbri02ZEbBwnLUbZd8nAbs/gueMWg4vagUIP
	 zo3gAbeLGZMFGDXZr/8gjQDNY9W7/zXBLq03kXV38EDWuS/Gdg2NFVmmTuHqJREzuqHHw
	 pmkzP3ADiwbxQYW+C3MCaeqG18avy1WK0xd/v0lugaNC89HchxBWkDHMaDG/avMOsLpTO
	 gd4AXYkbgdcuLTRp5rV5tqyPkS6NELTVPPqSKvnKO044s7pfKUV0ypsjKroPMxCm3vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4ubuYkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F781606A330;
	Fri, 23 Oct 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4ubuYkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117CC1F01828;
	Fri, 23 Oct 2026 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789224;
	bh=o7nH0Y526ovdbMYjYOuS2cc9y1ur4eOXOL5barl5Nn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L4ubuYkECll+Y0SwOTbBfudrUoVKQ8r1xCLjjLSMNhwksEUBl6a2dSxPMs/aITQjJ
	 aC1R7TTdGKZgLmPMqIWspPtm3snEQfMr7I9oY12b4v03xXyVmbb0Y5JYiebT3poKgj
	 +AbSsRCKO75OzHSBU/KOlMXDO+tePBjmeenScCVxOSK2SfxrswbgGxVjqcnnRtAzua
	 tJTqEMGHgyeAMSrPM4rVesL1SN8pfQlHG5OEUrzBZB+XwiNUuDOkeye2TydYUO10OQ
	 xzDu+1/xjaLGYhmU8VAgec2Fc/N8NoeSyHXLO5lPUwFzwnn/XI+klP6FlHUrjw/Bf0
	 YEtxcgwO3ZhzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0748B391B157;
	Fri, 23 Oct 2026 21:00:24 +0000 (UTC)
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
Subject: Re: [PATCH net] eth: fbnic: Correct packet header prefetch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278922256.1268720.4517362239739055956.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:22 +0000
References: <20261020172706.1090951-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20261020172706.1090951-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, alexanderduyck@fb.com, kuba@kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org,
 mohsin.bashr@gmail.com, bobbyeshleman@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daskald@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 10:27:06 -0700 you wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> The existing call to net_prefetch() fetched a stale address. The data
> pointer is not initialized until after the call to xdp_prepare_buff().
> Thus, making the prefetch ineffective.
> 
> Open code the address calcuation to give the prefetch as much time
> as possible.
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: Correct packet header prefetch
    https://git.kernel.org/netdev/net/c/286154ae6998

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


