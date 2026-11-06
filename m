Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994034;
	b=V7PI2E7QQCKzMFdFF8LgOsq91VK+ZxtBjPd+SI9qFhRqADdknez4EN5jh3IGV7WfjEd3
	 2EhJM4GFoLwkj+Cyctbe7Y1FpN3MzYvULfLPRcFEt68y1qp2sGZ9dVfqbfmY477QrMRvJ
	 9TA9s9N5gstltM3c+9AUnsM44JQ76US3wf7d0BfcBG3f2Ex4WDUcbg9KnYEVuRmrs6AP5
	 y9+M7Ks83lWeuiGQhijohAzlOjz1EUowlWuLtDOiJbITScOWmrlYqe7D2TZ7E8G9jr2VF
	 cF5JVzycGS6cZjtb7Jr5bMEakqx13VeA5TLhlVEIJC+1dmhpKAoTmzfGQZmJ+gah22w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994034;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1eTDtyoHiYYBs4OCZlhWoSzJPh82uZZwMzSGxhZY8YQ=;
	b=KkVFflP/PmtSmV56GoYr5Sam/4DU4jK1MIufIt6tuEkpCELKACqDb6x4mF59tQEbjitz
	 ibF4ANHy+tX4dmxp0u0LcFRpdJCirxOd7N17yN3we85Ufu4BdlpgPhFKU7FzBBzP9tTgV
	 sx1faDeyUEJNmXPwyk+OBUNRKseJR3wQR9lx0igx8YG58W2mSG5FxSn2bki4uUBGG7EUw
	 pC9Vu4UEoh3nQwbQAftQAzAnVhCZGz+t/9KejhdNAobvdZgD1Q8yuJVUt/PxDJzNv4T3M
	 +0J1VfhfePe9BB4C6+9fXxVAfExV8xhbsYqkHBQvkM7x9LwlKDpsovcmtZaS8k9/phg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afK+48qE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D9606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afK+48qE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C041F0089F;
	Fri,  6 Nov 2026 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994033;
	bh=1eTDtyoHiYYBs4OCZlhWoSzJPh82uZZwMzSGxhZY8YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=afK+48qE/TFPZgfdGh1APN/F0jy8PbuGK8naexAzzn4TBp9VGQUzKiYXmnlz940BB
	 fLaemFN6RzzqJ0NhPz/B+7BzooPl9c9iGCsO0MxjI2zoOb91x2MA3Y0r0eRE5pbQkr
	 +OFTsN++tlvBKXc4uVP3FsP17ZeHN9sdtgBpOZgzxWCKNUTtm3gGRc59sYLk2GdP7b
	 G/Bx3mwch9bnsokgBs5ccL9hAUDp+RlMAUUBULBb82R36V1on49Ap7DvihY7p3an3b
	 gnfyPttt/ra8efcjzd+n4X+rNk3mY3QEiO0uoZKnNMZUnCOzIhX9L2ilhyvSrH38e9
	 rIedmPT1QWIkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 49F663A41031;
	Fri,  6 Nov 2026 19:40:33 +0000 (UTC)
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
Subject: Re: [PATCH v1 net-next] net: Shrink skc_reuse:4 to 2 bits.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179399403203.832353.10077874550498808839.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 19:40:32 +0000
References: <20261103044213.1336347-1-kuniyu@google.com>
In-Reply-To: <20261103044213.1336347-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 04:42:06 +0000 you wrote:
> skc_reuse now consumes 4 bits.
> 
> However, SK_NO_REUSE, SK_CAN_REUSE, and SK_FORCE_REUSE
> are mutually exclusive and fit in 2 bits.
> 
> Let's reclaim 2 bits.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: Shrink skc_reuse:4 to 2 bits.
    https://git.kernel.org/netdev/net-next/c/13df9cc6fc0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


