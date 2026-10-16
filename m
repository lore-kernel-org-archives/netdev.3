Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B229B200
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114808; cv=none; b=JaBV2+LkR8SeVz51JdQb3DyyVi8A3BZRMsXaeEMMstlxL+HXcbkE6lMx9YtazGI+tX4+ZpFtRjhfQHhyAwV/eBD7Nu7d9oriXZTCgAVFWagopkIf1DVqm8RIrxpzOD6ILezkBXI1bUz6lcdCblSGzrCHhtlxnWbxmU2SoxFUIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114808; c=relaxed/simple;
	bh=UsY+/cNDtgHofNwj9+2Sv3qwn4VvkjwmCQiKYCvl/KM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0qaHHfCpzInczVl0uQfG7q7bNtM3rXAt6wTbm232NwTSZ4HVf5Z17qIZVj+II9cdXEO5vqSdlnE53V4TjRa8a2+0Uh+Na6VQX2qI2ttPm5usZ2sxZseeYTm5vLnNTUL16ve9uivzI6/fS1O8tw3tkG1Vqj8KjU4k28m3TL1Jlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngktDdXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngktDdXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3C31F000C4;
	Fri, 16 Oct 2026 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114806;
	bh=lU1bIODEeRaYa1+yoevpqRdNjBBa4yCUTRQ1Huw9pHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ngktDdXAWU1hgLwjRqkRphxSTQZm28O4L3e+Xub+G0pokuc7Lbp/YtVKETJ8Wq008
	 UYgElSWEgIE+DuBvqcycy5J4cXVgQ0j/TE/x2cDrZCBi3bCRBy5dycIvQsLqmfvw9r
	 nNmJZ7HxmnPFjfXp9cdtjo2uMKrJyfUA+YCZu4MZPGE9/jvLiFpKjEVkVn0G0dsSGE
	 g6AzC+ngQkA4zjusOp21RANa3RbATBQRTcMtB81jyem9+1yusW87bidEbgBG+8pQXO
	 4JUbE8D6baLSUoiSVjkuuvqdGpTRDt67+aQOxTezk9HE2PSrbs9QLMXBoBvTsH3Z6b
	 +W19CTwFC/Kgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45073808209;
	Fri, 16 Oct 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 0/2] net: fix sk_mc_loop() with request and
 timewait
 sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211480552.6630.9459936176443030721.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:40:05 +0000
References: <20261012101029.927296-1-edumazet@kernel.org>
In-Reply-To: <20261012101029.927296-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, ncardwell@google.com, idosch@nvidia.com,
 theodorlarionov@gmail.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Oct 2026 12:10:27 +0200 you wrote:
> Patch 1 fixes an out-of-bounds read in sk_mc_loop() when skb->sk is
> a request or a timewait socket, by using the full socket.
> 
> Patch 2 fixes the route lookup of cookie_v4_check() when the ACK
> carries a source route option, found while looking at the above.
> 
> Refusing to send TCP packets to broadcast or multicast destinations
> is left for net-next.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/2] net: use the full socket in sk_mc_loop()
    https://git.kernel.org/netdev/net/c/31b564f70d88
  - [v3,net,2/2] tcp: use the echoed source route in cookie_v4_check()
    https://git.kernel.org/netdev/net/c/54d574d4afd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


