Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794512407;
	b=OxbQCnuqlPfXMDsDGCTrqwfO9YHIU/eEfvD+Vfnpy4YiMp254NlfXdJByUzBRZFVhU5x
	 K0xS/zbFxxsUxt4nYnnAzmoM579wyha/U2CzX5ReiEBCbUZxIeSbF5Y7hhRTwTH8OzzEr
	 xmMwlDddVxTk4/iWa/z1Z5MbOZLDkS6hqPlxM7XE2kCzYzZ6xF2pe2X2xAzsih8kjOL/F
	 1vBQE7xpLwq0u1ZjpGVyVoYR8dN6KfjLscSoeYbWkNNoBSBg4CdUPHKE5aRgfgFYUZwQW
	 GcU4Tmzzylbeegue3fys9XCP5wueVneXiKmZfEK275h1SLvp2oAbZKQYVm9atAxIhhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794512407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9NFb7p3i3GgUmJfOoqq2SxUCQIjj/b8d0iNid7bIPNM=;
	b=1KwvbW10Db8UvQpgIX8pYRl0NUS8cFAMpkpEglr1qKZDWIf3zzguu1m1j4IYul7005m8
	 38X6i+QKuaVYk0DWm9IQMMaXOuuhhFgiwuFXjlWWZVZOT8A9x6rhzRLr7F1f7ccOsrxSo
	 tcYl/PYzNlKekp94PE++ea63ndvG7ElvRoGppxv5/K5KvzFeysyk8BnQIxdl6gigYq0oY
	 jRy48jMeRDNxJTaH8wH4Jha/lj5HSDI5m+i7uM9sRf2yrhIMf0AiQe8UNruubLfqXf2S6
	 Yj1VZDp77OJ2P/glLjGueVNJ+CiMlsG3tdnJGSyc+1lLYmDhqbGtq3l5/aGy9K7rbtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQj0uHNd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC28606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQj0uHNd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0770E1F000C4;
	Thu, 12 Nov 2026 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794512407;
	bh=9NFb7p3i3GgUmJfOoqq2SxUCQIjj/b8d0iNid7bIPNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cQj0uHNdIZtnJ6dxxpbHwg9R8aoeDCKcnDHTxFKGDJs4oqbkkQkNEMDJKlEQNl/cx
	 6uyqOD5JWXOTygYc6rf6/rg1p3keHfNjqU7UYSWyFLJnaF0cpjrM2EMZwY9QhB+Xa9
	 KeUEgDNVmEKUb5HwMHKem6ZiB+8GZuOggPcWxu/nw4rrXc0s1l3wcb3ysM+3v30yVu
	 3bLPzz16iywoqwiUfpYJVjGp6ZvhDVQoyam5go4y4/w8TdQTUnXAmk5jUnJ0pHsdsz
	 fspHcFCVIEcYUDHwdghyMqcmali7L8DXTQ0NAJ9cug4XHi81Z/8cDvYZbzQ+qV3+RI
	 6NGuFZH0xnMVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15463926259;
	Thu, 12 Nov 2026 19:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] nsh: limit recursion in nsh_gso_segment()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451240578.614223.5418531856983381502.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:40:05 +0000
References: <20261112102001.3744643-1-edumazet@kernel.org>
In-Reply-To: <20261112102001.3744643-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Nov 2026 11:19:59 +0100 you wrote:
> Sashiko found that nsh_gso_segment() can call itself, through
> skb_mac_gso_segment(), once per stacked NSH header. Nothing limits the
> depth, and a 64KB GSO packet made of 8-byte NSH headers overflows the
> kernel stack. It was reported while reviewing an unrelated virtio
> series [1].
> 
> Such a packet can be sent with a packet socket using PACKET_VNET_HDR,
> when the nsh module is loaded.
> 
> [...]

Here is the summary with links:
  - [net,1/2] nsh: limit recursion in nsh_gso_segment()
    https://git.kernel.org/netdev/net/c/3921fb102d78
  - [net,2/2] selftests: net: add a test for NSH GSO
    https://git.kernel.org/netdev/net/c/53e7352d65f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


