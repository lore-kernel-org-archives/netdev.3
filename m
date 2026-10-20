Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525217;
	b=Vw7j1tPaoDkHx4ouxGE/4fME/3DaYaoPjoElcTAbuWd5NnVVfroCwaThIds2fEdr50ZE
	 5szX9APLs5NBCH43wiL5dVvcA4yCztAuh/7xwqXhYDoEX50CJSH2cp+oHeJF3X+3eEq1m
	 WIVD6DjLVU9Mb6TErAIhYcWdTEQ/NSMM4FoiZop3R+ytFJEvhWEWSinrdX+xBo1EO5wGY
	 1O4K2/D0hJbADTLxagUY1VI/UIsLMv1Ll9D4BktNymtkd6F1jHozGqb8IYYDydSxIn5eX
	 6sZnuCxn5Korb5oPNMaZVI8rW4485OknkpMKwjFydOV7JuaLAfwI3kJjKmAF2TwtUYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525217;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2lvqCqMBxgWzFE2VQX/8QsaiiTqSkwkqy28rpZSbCSM=;
	b=bTeChVsT2f9wFoC/x7MnfXmd23iXTG36WOAizD2U9tOlHJ2cSMBpO5DgIqOm+1in7kL7
	 k5644d4fROw83cimWOHbXWTZ/8V9uftRusDy1W8A/ntWa851CJndh4N2aa5SfcNyzoPOF
	 SZuRNvfvPUdzIU3NTBtxqm7LcLhx936N5yqNRiD+jtabyjA8yaV4Tam1qH8hMd0J6VLYO
	 +eo6jY8BX/aYLH//0VHOPuY9KfESnCEu1GnnEA2dHhq9OOdZOSdBR2n5mmKmZZRXU/fJL
	 r8Bj2j2k56lt+3ycsCaMEmgXfcQJeNCrpA0wFptRdab0u0mRf3nlOiqpJzfQVK8NusQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A90M9pwn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BC606A31D;
	Tue, 20 Oct 2026 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A90M9pwn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CA61F000CA;
	Tue, 20 Oct 2026 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792525217;
	bh=2lvqCqMBxgWzFE2VQX/8QsaiiTqSkwkqy28rpZSbCSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A90M9pwns8xiFGNXOBf2tBPGPLWtcrgAZz3JrJhUgRBZrbiMUDURRlOp+4ivNkb8N
	 3iVjuUc1OOyrlGDcKrczl/NhDvuE0MCI2EUT2f34CiMGSY5g2PxPxZ7RspjEPR288d
	 acwGvp/m35EIdbiI3iX4M8BdBx4/rYQooNpeRlZRNdnpAT/ORHFqoRV35EZxmJQQ9C
	 91jnzkdZYTGg+QuhfVZMvZx2UiTvb0F2Vgx5Qlt4qWBhOxq8nhq4SckAf87V9cdBlX
	 iD4l1+AbLI4+73EMx9KoYWmq0i7TXtljBeTIVZuoA+lD08AgBt7epcmQVk+2aiG9qp
	 +ePDGbbrWLhZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F17BD3809A09;
	Tue, 20 Oct 2026 19:40:16 +0000 (UTC)
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
Subject: Re: [PATCH net v4 0/4] ipv6: fix address publication races with
 addrconf_ifdown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252521578.176933.2936110107894868867.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:40:15 +0000
References: <20261015050651.1841557-1-4ncienth@gmail.com>
In-Reply-To: <20261015050651.1841557-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hannes@stressinduktion.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 14:06:47 +0900 you wrote:
> The first patch removes each non-kept ifaddr from the address hash during
> the per-device list cleanup. This prevents addrconf_ifdown() from freeing
> a captured object that a late publisher left linked in the hash.
> 
> The second patch serializes hash and device-list publication with dead
> device teardown. The cleanup patch is now first, so the newly atomic
> publisher cannot create a captured-but-still-hashed intermediate state.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/4] ipv6: remove ifaddr from hash during ifdown list cleanup
    https://git.kernel.org/netdev/net/c/6ace56ed7b13
  - [net,v4,2/4] ipv6: serialize address publication with device teardown
    https://git.kernel.org/netdev/net/c/06227034e2d9
  - [net,v4,3/4] ipv6: initialize temporary ifaddr before publication
    https://git.kernel.org/netdev/net/c/ed7f278812e5
  - [net,v4,4/4] ipv6: do not restart DAD for a dead ifaddr
    https://git.kernel.org/netdev/net/c/ffb668669ce4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


