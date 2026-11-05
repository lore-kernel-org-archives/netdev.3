Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878808;
	b=VxSIO2U1bLZ9wy/m51JTRGxdo3Xfattdwdv3dIq5AGVAIx6tdS0sJNi1a1q74xg2h9P6
	 ZcqhdPxZoofS1LWCtej/f8yUF9lAngFFpxhISqbcxf0djv4D4UsXhp3O29NbzTnDKJcSW
	 ueZc41Df4g+E0eBKfKiKEgCkoJCaMj0cDp3gGHSrCeJZvM1H+IexyaS8eUq/1QDVLvz7v
	 QQiQPcJWvrOehUGWT8fNr2NcCThhDLj/kVOJg9Z4TCEGntCdSeLMoM5JWgsCQiYPbBdJB
	 H+cmF6xAV12x2uE0T2EQevFXk/bev9B2tav6shS1xecgR4o6f1ULAy6rqoZKsG4jLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Vcayyb9EFkal8CjZj4nz9NIHLgdhpYEhszDjS2ZVbAA=;
	b=gnDqIKU4tnhPBf1A3kj14zk9R1z8psFPpE45edmWrQmHNye+yFqBU/ZxF6/kjT8jecX5
	 dZ7ejJF56HFFJ5q6XnRMSfRsg5eng5JZGodgUJebUiy216nW0S6krCqYpnO4Dw14IjSx7
	 cZtNQJNT+4WHD7vYzxDcag2HrK4RQ/VmYiC8lR+MbRoPtQKtbdV9zaIdJRiBRbpHNUdxS
	 jvu7GalvGofPGswHopOXIzEDYqEHBgIE91o5h7llBEB1kvxB6pCU65TOX8+JE1keWph2z
	 SSRNtw6iMPwmskDwxyFnCNlcZTePjY7Tz1Rain9XJNMRhvewNUOIAFFcwdnzBgPN1/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3zXL5Tb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19827606A326;
	Thu,  5 Nov 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3zXL5Tb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C631F00919;
	Thu,  5 Nov 2026 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878807;
	bh=Vcayyb9EFkal8CjZj4nz9NIHLgdhpYEhszDjS2ZVbAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V3zXL5TbQiwfUwkhk5bjyDN81FtsekeXTjUXbLMWxt5xABTsqLSfze7xEE1VTaT9x
	 nFeZ5yfHUvcsI/lA91uF0tpKmfF2eVtizdKBIIWBKGSpmB7tGpcJ+3NwwKFWMqgcAC
	 uLPRtPFdaOv705Jjwv4iDs6vSZzlnKgSv1xnZm58E4Rl2bFvSOsQoKKzTHDuWGdKSb
	 C/VhpZXuiByea1AtjX+ogmkGhaOm5OgyAdMOCxTu4QM6FSiEkljc2tOjCJEDZ6X5kT
	 fsh0/H9w1esi1biGVdKNuFpsLD8bP1YV5L562ZJhu97EMFV/UepEunnFm5I8i4DkUO
	 MaS/rByKDYXcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA5BF391AFD6;
	Thu,  5 Nov 2026 11:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net] tcp: initialize send sequence numbers before
 deferring
 TFO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387880660.3620005.12268474303960159574.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 11:40:06 +0000
References: <20261102035943.9700-1-qingfang.deng@linux.dev>
In-Reply-To: <20261102035943.9700-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ycheng@google.com, weiwan@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Nov 2026 11:59:43 +0800 you wrote:
> TCP_FASTOPEN_CONNECT can return from connect() before tcp_connect_init()
> when a cached cookie or cookieless Fast Open allows deferring the SYN.
> At this point write_seq contains the initial sequence number, while
> snd_una and snd_nxt have not been initialized to that sequence number.
> 
> Consequently, inet_diag and /proc/net/tcp{,6} report the initial
> sequence number as the send queue length despite no SYN or payload being
> queued.
> 
> [...]

Here is the summary with links:
  - [net] tcp: initialize send sequence numbers before deferring TFO
    https://git.kernel.org/netdev/net/c/57889a8f6d49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


