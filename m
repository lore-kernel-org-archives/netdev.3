Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54253A8A3
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871869; cv=none; b=lPE3JKelr3he75yEevYxa4mBSMsXb+pQmjoGTmtUyLNJszc4fyhKmw9QlZOIhO3yubM6z0dxYet9WVyDGDC4YaUnC7apdPhB/bK2pQv/pdzYVaZYhcUErADHyIHV6PM1sYI1gnSjXO5ivcPBfzXNM7aacNFtCD0Esu+oi+vmr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871869; c=relaxed/simple;
	bh=ztpFAYv/JnsMR0UuaGECPHey9ZN3doj5HMFagWhQjZg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t/LeraYaxzrc/f4FyMECOsyAEiPEnYmquSl+ELkf3KS45nb/2AqlnMJ1Gw8hjDsTOqKJixQsgunjUj89xAjzQ57BC6GOtJtMT2oUneAD9RA7lZY5e7d5s1XAH7vDgGX6FMIimdx64kLLv9bF38XTNIAxupOCvQAtyM2wur1A9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax/JktLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax/JktLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75191F00A3D;
	Tue,  8 Sep 2026 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871867;
	bh=5Q6INhVxz0u5MMS3lCbMLCUbbhcP0zfv1N0CRMQyBGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ax/JktLXnDLHWc6Sxq1g8/f/J/N0QFqpzhfRSYEuTGZL14n/llraDPzP1xxGubI0H
	 uCJFR4aenapWrHR4an9/FjjUODxnSoWBzWoP1bFY3DShIoFhSid2bFEiFVQHDQkjRo
	 fxJohYK/7h8cf0sMnHfbKRHnbsSaCuTBQOvLtdJDu7n/2jJNBOar7nXWBzLY0LqrlL
	 6ioMMfHCqyQqy6dgObr5u0jkq2JFXa2LRFDnBAi5fZkDKkWWSeuiJm5jVPBrnlRpiJ
	 J2GxD/uf8SS/aKyZCRxwTXhOzuoW86YqUTD9K5KboiQzt6i3KMMnBpoxHteRqiTekt
	 L/7WAeVFdJAsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CEE4D39E961E;
	Tue,  8 Sep 2026 12:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: udp: Use ip6_sk_redirect() for tunnel
 sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178887180639.3511527.1640935140177520250.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 12:50:06 +0000
References: <20260907101358.596953-1-idosch@nvidia.com>
In-Reply-To: <20260907101358.596953-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, willemdebruijn.kernel@gmail.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Sep 2026 13:13:58 +0300 you wrote:
> After commit cd51b74bdd0b ("ipv6: Fix redirect exception creation for
> UDP/RAW sockets") the two redirect calls are now equivalent and there is
> no need to specifically call ip6_redirect() for tunnel sockets. Simplify
> and call ip6_sk_redirect() for both tunnel sockets and regular sockets.
> 
> Note that for ICMPv6 Redirect Message packets the VRF driver does not
> reset skb->dev to the VRF device, so skb->dev->ifindex is equivalent to
> inet6_iif(skb), even when the packet was received from a VRF port.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: udp: Use ip6_sk_redirect() for tunnel sockets
    https://git.kernel.org/netdev/net-next/c/4596be8a15db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


