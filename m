Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78B35F165;
	Thu, 21 May 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376807; cv=none; b=tElE6WL+UlUOp2b3V7/3SkPu33SaqmZtDgvSmL5vyjTaMslaOvaKe6vXWW2Nr6FG5XBxAXUPO10Hy6kPIzHUMu22PUXfVXvcjXGq+xLj2YsXNk4MSlKsi2e+Sw3X+Mi5MW9Cy4/WmWIpl4Jw6BMg4mB98QYNXVjj54vE/IfPHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376807; c=relaxed/simple;
	bh=2V14SoVMt/6oTcwUOvbDPpEbnH4r3r5k1iaUL6IKKAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pk8cdXI7c71CZAOv4Wjmp2rHz02dfurNuGMQQjBvPTaTj7XsAyocm3QpIajo7nCJfBE4GVJE/vVWwpAJSRhuuFzke5mijW4bVJqW71nuKn5g7x3z2Rmj7jVc+IoMLsm9y0SKl+c6EDOJxq/B77ggHpPYqBI3WBtiQ13+WylI6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScOHOzKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScOHOzKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0375C1F000E9;
	Thu, 21 May 2026 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376806;
	bh=HRBjW6CFMCjYBV6R40qGK/bxeBfgC2GSre/1fpUBVak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ScOHOzKo9I5J5wltmBUm/ttJugKeD+YB5NjuCu+SAyjrKVwt9uD4F+GZdoZZbz+UA
	 AQUwMjNSV/Jkrbhi05vjeFdn1jx7bNrnItsRNQzS92kS642BoYjW2aLL+OUv1r6XYF
	 xgRR2NbuCQllf+pWHy1f6EmWK/TfrM29Q9SUCjfVeYZFoMZfrg5vrnCNPWLAxY347E
	 MGocnNiz3J5qrhzKPWXrmfOf6keVy6rnCicb+VhMAreFZkf9G1xb3g7a2frN3WX6+p
	 vP4Ib8eGs0bkkv6ZyDzFkjTeijpkITF7myaocU7hUOT3tGpMAiC6ns1YEv7sQKSJZS
	 pSpZC77AGzCZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994A3930E00;
	Thu, 21 May 2026 15:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681563.379332.9342112117202162208.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:15 +0000
References: <20260520075736.3415676-3-bestswngs@gmail.com>
In-Reply-To: <20260520075736.3415676-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 cong.wang@bytedance.com, stable@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 00:57:38 -0700 you wrote:
> In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
> uninitialised on-stack struct sockaddr_storage to userspace via
> ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
> dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.
> 
> Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
> macvtap chardev returns kernel .text and direct-map pointers, defeating
> KASLR.
> 
> [...]

Here is the summary with links:
  - tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
    https://git.kernel.org/netdev/net/c/bddc09212c24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


