Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CD26CE2D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984804; cv=none; b=EpRDQMa28Wltf6AplVe+CzeY2muzW1+lfXvp7cXZYm4scTbqzh1+DemBodWaQlLoktn/1cgit0dLdN2G1sc5/YBm0O1tNfkUT/ur4x2DcagyDs8XoQvK8F9L3Qw+YnZpCTuio1fFXxyNq5mXbthqMdnMHypymsdJHy+Paaytb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984804; c=relaxed/simple;
	bh=MyLtIdn8VCk/fyAONKqnORLsrelqf1aEtEvvKTLpatk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kic05+pe0tHRqNc/Tk9ljloQZGuxGRst0kLglh4gLByz3ZdLWjPyaYsSrXkBI/smeoafiks31nieSS1zQyw8S1IyF2fOS9hZ7eC0+Z2J8Uvmnl+C8s7B8vn6ie/2UIN2PZS00h0cIDzGQ1CmalA2HWjXdciXNhakh0tZLrLSUoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTxEw8kZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTxEw8kZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A32C19424;
	Wed, 25 Feb 2026 02:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984804;
	bh=MyLtIdn8VCk/fyAONKqnORLsrelqf1aEtEvvKTLpatk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gTxEw8kZAlw+tizUNvNlX1CDfnipluNE37dv4Ns6M8qXgBMnm6ON09zwhJulw/IU/
	 ADZAReMplGZ9ZUpIr0IVH9ymHHYDgCQguTKsaoYJnp5h4VdP9W0Hq0BYkslVsOUdIn
	 l3gB/FBfNizL9MyzfTj6+1oAjF56bYDoImNl3iRwLJohueFoVq5LDqrqLotyLDbUDO
	 8Xs5xdgQNYoVh0AMgkha1UfxaakAkcQSfut+CZ8hcB1NEfu37ZFnkhizFHRl2sklPm
	 pYEm0m6jzYxqWxxia+yr6o/uvHunyhD3VI8ZRDSiq3PejiK5DPXcVK9DVFHUDB8GMb
	 4TmJfAjiwVw5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0A93808203;
	Wed, 25 Feb 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move inet6_csk_update_pmtu() to tcp_ipv6.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177198480929.34120.6867804511303886587.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 02:00:09 +0000
References: <20260223153047.886683-1-edumazet@google.com>
In-Reply-To: <20260223153047.886683-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 15:30:47 +0000 you wrote:
> This function is only called from tcp_v6_mtu_reduced() and can be
> (auto)inlined by the compiler.
> 
> Note that inet6_csk_route_socket() is no longer (auto)inlined,
> which is a good thing as it is slow path.
> 
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move inet6_csk_update_pmtu() to tcp_ipv6.c
    https://git.kernel.org/netdev/net-next/c/539a6cf0844d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


