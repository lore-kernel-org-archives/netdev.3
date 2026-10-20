Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531810;
	b=jp/wT8fcXGjY97E8mcWbwpGjW1cTV3650IqDZMRxCLUaymRqh+15BFi7I4JigJojEjtU
	 Zxw4pAe1iLHAJHh4sdFhbRX9xc+iRs3RNEs/Fdwd0vUSN0OT3vwRzRisJNZLEIyiCMPUe
	 +/19lXgwxbfO29G620T7p5yCxRdJaS3N3De0/IFWEIjA5TgYWFnAVPyIx2yzLsE5m/1Jx
	 nvSCIpo//XFfmU7GXlKgJAfIUY7iqjqXcdA5slJWN74iwxeImEsCqp5ImGNaZmgtJNN/F
	 GfDOBsmqNNiOIG10x3wRDQqH0SJMnSZJS/ueR2L3yqcvDVe25qGphjFlY383v1/gUuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0MYo00akXtoBZhMUG+d4YDzZnNAVRklf3K/GEVbaW9s=;
	b=ZAz/WhA48cddbtm2epJDUbVKagLLexKcLlKWPlqq2gT+lpvhbkLFxrAPTjb/LmdTsJXa
	 VXeVo6iD693oObtcynSvwKI/rC7dcGvmy9+4riqeSyX4kTIfl9gwuzEpiMfno434UeWra
	 CcCiGa82+IwrqDs0BYko+UnUlRo98Q6IxW18N/9V6QofTrRAunW0a6yXacQEh9+2XcLD8
	 KhevoEWI6rzL0gsUmFZ9/b+k5+MKhZov3uUtPNPJASy6Kqr0mKllIqpIadKfpHp4TgtHS
	 p71CTRSStszDkn2oKX8bwrWAOFXfiiH9XRzOh+ZBBMK8Ca2Lry8NV1ksEkkM4KSAWyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d3Ew/jq+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF90606A324
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3Ew/jq+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A911F000CA;
	Tue, 20 Oct 2026 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531809;
	bh=0MYo00akXtoBZhMUG+d4YDzZnNAVRklf3K/GEVbaW9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d3Ew/jq+K/5LL7nyh0lmG9qz1jJ+B0aS5xT6E627svmVP/LVHTJVhTh1p7atbfSdk
	 72MxMI7V0LVdPS1oDdPsDEjbIHWJwUXCoQtXL5sqw2+08QegVrmKpfhWx1r7Pt6I5B
	 pM99XH90XlfmU7pvHteFdN+zQto03UVfI+akxK2Nikk6vIFsTdVMrd6400ue+bZHXx
	 MC2zLmWPq+6zCR7lzU4xl8M5rXPuZPdGnz7R1xKoLqam3OzCtY177OSRqHG9O3U1kr
	 mQvShkNwqXdeM9XlGLjeXwg7swdwrGUsDii78+oVYoPZilJo2V2NIHO+gbMLrr1OKb
	 P1iheYJHKfWrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43F13809A09;
	Tue, 20 Oct 2026 21:30:09 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] ipv6: Fix suspicious RCU usage in route hardware
 flags notification
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253180827.220085.5504005327866544536.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:30:08 +0000
References: <20261019140337.2886875-1-idosch@nvidia.com>
In-Reply-To: <20261019140337.2886875-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org,
 andrew+netdev@lunn.ch, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 17:03:35 +0300 you wrote:
> fib6_info_hw_flags_set() is called by drivers to update the hardware
> flags of an IPv6 route and to emit a notification when
> fib_notify_on_flag_change is set. Drivers call it from process context
> without RTNL or RCU, so when the route uses a nexthop object, building
> the notification triggers suspicious RCU usage splats.
> 
> Patch #1 fixes the problem by holding RCU while building the
> notification.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipv6: Hold RCU when emitting route hardware flags notification
    https://git.kernel.org/netdev/net/c/7c9cb1edaf8f
  - [net,2/2] selftests: netdevsim: Add FIB notification tests for nexthop objects
    https://git.kernel.org/netdev/net/c/b5dc3fde8b92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


