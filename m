Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4292F617D
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313218; cv=none; b=QeyyTl1ZE1DN135HevLYZoFvRAa9G0zN4oYyoraJs7SZxaQ/oY8fGrzt7VfZfy5FVMw9I8fAd8mLYVwWDwUUTXBVDLDeKsHM6LkK+ZJgU4xoXh55NqsW06A0ybK0uja8kOu2rwAZ3ilAt7CFqBTvyFUVCOwa8g95bKtKEGVnC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313218; c=relaxed/simple;
	bh=7aFm1eK0YYRkoLZDxrqek6Opv9B928YytcKCVOeRoWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WeYsy8XFs+fsYY0ADtC1mQbBLH7dDBCRUIc+waGtFsX0RCAczPRe9ieBQr+lYONDG2cSjMTsPPRULUJp5nswKtzdY0LlAb7NUKMhhlFOtPYGVBcWu/ncbUFxqiSoGJXWOHArGD6Y4cR7kS5FI4oTK9b41HP5RABtOvyS3YJ4unw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeQZBXp7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeQZBXp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1A2C116D0;
	Thu,  5 Feb 2026 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770313218;
	bh=7aFm1eK0YYRkoLZDxrqek6Opv9B928YytcKCVOeRoWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UeQZBXp7OO+0DNNMzbpU3z4xaCDfTKXtdjY0m+XwlwMtJEL2kMjvpyCz6tGS/irXY
	 /UhWXXrMs7o/QgCR4TniFscsP3ZWZoRKyyzDH0RKWrm+YqXw1rtyFJlOsxbLrXOJfm
	 6Z/lLdrbFOYWfUL8SLO1yMiqou7yGjYc2IIbDaWBLu8T9tMllppesc2F/Nzz+1Jhpz
	 pryazmAcSEX+befkH/5oNcMflLOFOujmGbQA6kOc+hSpWJfQt9oInmGzCL2UnklRSz
	 YZNRz9XOAM/69NupahC+lW9Bde1Bc48tBJKWCc0o+gxaj3Dxv8BNpclc5lCkfsCpsg
	 2+7+InvHrasJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AF263808200;
	Thu,  5 Feb 2026 17:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: change inet6_sk_rebuild_header() to use
 inet->cork.fl.u.ip6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031321557.505259.15887697398596098259.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 17:40:15 +0000
References: <20260204163035.4123817-1-edumazet@google.com>
In-Reply-To: <20260204163035.4123817-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, matttbe@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Feb 2026 16:30:34 +0000 you wrote:
> TCP v6 spends a good amount of time rebuilding a fresh fl6 at each
> transmit in inet6_csk_xmit()/inet6_csk_route_socket().
> 
> TCP v4 caches the information in inet->cork.fl.u.ip4 instead.
> 
> This patch is a first step converting IPv6 to the same strategy:
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: change inet6_sk_rebuild_header() to use inet->cork.fl.u.ip6
    https://git.kernel.org/netdev/net-next/c/85d05e281712

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


