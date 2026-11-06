Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970929;
	b=POlx+yzyLE9rfVjWeTMdq3PEdeI4rCkyYh+azT5j/V15nCjTFOosF6sNSJ7ljYyeKhKK
	 ccb2RyELEi8FRrALmP3sItUjIigfjK7Q2jPTIOslQoFmGcJxDlP4gNLuUtjk65euI0aE2
	 nllW0hiiVNGdLoCj6pFIAif+GBdkDW/+u7yJ10rWpBj6rM6jx9eum8zUmj3B8klWpTHqv
	 HB8GAMoDEuEEkCBPgdVjnhr1X/w71I3mYVP5h5P2HoF8cRXWX+uSPPR+dX7PgzLiPD8vB
	 6ZW9FAq75rayw4D91vjP7SToqJNaBxQGKkETnS5v76V9WiOXOqIwFw8tkyJDiRbqO9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970929;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=km8r+cnmKuYMdZesKgiekckeUOq5ezdJQc7tNLQIf/k=;
	b=CBJaIk0RDwy3S/XTwkRW8I8tU870cdgM4SVrpG4CDkzlmWT0Lcb2tV3jLFd8RG1zU/qR
	 fksFa3LQ+64slv3k7Dx0loq+1Wqp97u/s60hn+ujvPIKSH/KVa8OgoDEPtoWIZmmbOyG8
	 yiBzOmRfDNsSlAy9l8lxg1LVi5MICCCYAgri75/7lwGa+rYFLlh6OI6QQmWHhbo4FqrCw
	 6VoRsH8abE3JiYTpLRD2Zs3yG7HGIbDm6YXG+C/ioKfpeOTHaVrrGXvbnEFmo/YSssj31
	 GglA3+cWbVbxnafruRC+jFyiyfZmj1Jq3WUlDRQimP1uQbwrUfSf2o7eGA6hD2z7S6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eiITEbj/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671C606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiITEbj/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470B91F008A1;
	Fri,  6 Nov 2026 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793970928;
	bh=km8r+cnmKuYMdZesKgiekckeUOq5ezdJQc7tNLQIf/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eiITEbj/pelEWOFMjBBfJH32kcPrZ3AHgkjq5pbGBYGacgfzbq61bR5p3ffkE1mKG
	 fh0cF9PFYOjtQ4nj93+WDvn3zd+XYR2sTEI49KGh09macLRm30e30CPwH7AGmSlJjf
	 2m+pthN9F+U2muHZZjKKWGHPP8daTxdaiheudszF4OzF5N8QJs3D8elodYoEGWpGd0
	 5lhl79URBJ9zwZQwIUgg6b/uRTFy0jC/upHXw3wWxZRjQFDEFoh2HDqJB2BXdM+Im5
	 GKC64sBqMlx/Uq+Ey2GSu87lCgbbpCaHxdb5k9dbE0BMY9FMXgVMmpXAMBQPOu1cff
	 mVNVdSXWzd39Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2106D3930E6B;
	Fri,  6 Nov 2026 12:00:21 +0000 (UTC)
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
Subject: Re: [PATCH v1 net-next 0/2] tcp: Let non-PSP and PSP share mtu and
 advmss.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179396641976.575356.9858593759192464397.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 12:00:19 +0000
References: <20261103000712.658501-1-kuniyu@google.com>
In-Reply-To: <20261103000712.658501-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, daniel.zahka@gmail.com,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 thaisonphan@google.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Nov 2026 00:06:01 +0000 you wrote:
> Since psp_sk_overhead() is added to icsk->icsk_ext_hdr_len,
> which is subtracted after clamping in __tcp_mtu_to_mss(),
> it is impossible to configure a route that both PSP and
> non-PSP achieve 4K MSS for TCP_ZEROCOPY_RECEIVE.
> 
>   mtu 4220 advmss 4108
>   -> non-PSP gets 4K MSS, but PSP gets 4056, breaking
>      TCP_ZEROCOPY_RECEIVE
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] psp: Check pas->tx.spi in psp_sk_overhead().
    https://git.kernel.org/netdev/net-next/c/7020a2766440
  - [v1,net-next,2/2] tcp: Subtract psp_sk_overhead() in __tcp_mtu_to_mss() and tcp_mss_to_mtu().
    https://git.kernel.org/netdev/net-next/c/3c6e29760c13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


