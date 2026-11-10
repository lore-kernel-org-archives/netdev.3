Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349807;
	b=4oJMj4ZDdMtNox3Rk41m0KynxJn5//B0x7jossgJexc5RXyV7nthAh58Fun6XArSPFEg
	 hIFAZAkWg7N//cL88rjxzTQXLJzXoY4yyDUxTXiXQfQxk50JCKrknaclf1p2saBVjubPa
	 Vb7WIhlmvzfwdK5fLmOpuqJN4/F+mMe4P96MjocgbWXVFBuL5fC+Q1a1CEEKebXlQI1wK
	 Q+o1A/B0JmHs9oaxknPzttWh0Mtv3AB8HGIiglVDp9I2PNBXyTGtDv9wCtqVCZmpdXQT1
	 q6GLX595yQJvyE/91qkbWiFSanoAlErIl7nWsoYAdtuemfpqZjQNtIkMjLMhx+k5UMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OcvdW4c/Q+UyJmSfwnJS7XuOZhFjoXktZT+/B4vAk+I=;
	b=mgirfJuwCENjEucZztfIltP7TAXiyDzaA441ABIWEsv/S2DRNSn0tkABtW6aLgo/cirA
	 jvTiGVW7gKRnlBSFzf6/sfEWeTf8kgdlR9KH3o8uMm3+ZwgY2IerxBUHbHkxq+r71KFAU
	 SUeuCC98OcIChBqMLn7I0xzqnvd0QajNsQ4koefc8zcbSHRxe3uSbNN4ezzBZ+ORA5+zn
	 r9aibFh71eYDTtLBvLkDhhMInX9LfLDay9D6/KJkuyxO5QlbwXU89bU4KUXwx3Ao+pDhF
	 GOx2sfhwz6oX59bwBzF8CeFEvunjwHbcTBr5iy4Qa9QLlSQfqG4i6Ns3KX8lmGWIM7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3fCx+Zs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE6606A331
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3fCx+Zs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E692F1F008A2;
	Tue, 10 Nov 2026 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349807;
	bh=OcvdW4c/Q+UyJmSfwnJS7XuOZhFjoXktZT+/B4vAk+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K3fCx+Zs0yfmCVrJiuJCJqjS8nt2Z5gmuPFIOEd6c3JGyCMwGB6dpBjvL4lussjOL
	 VFojnYNnOL7byFf4yANAwsePXRXD2jLi4Nf8jdoIEc9jsBRLgGGp+pCYA45DyMjSEl
	 xz6yqdUBSlsDjZ9OlPrfJPP8UsDFrrdvZQQQjT/XQGvacg1qWKLgKKxQn2evI+UZ2F
	 N5xK7fgXvNCtmlMsd+EnIsTMaYHClT+T26dmZC0rKXj0SFH8YFzhBjdcpZsBVZt9xO
	 YzWvRclm4w0/7DvuU9YOaZptnzZy4C2l9+7U8zmAxyE1HNKie0cSyR+2O1tv5EPjX+
	 tqCCoWyqoSdAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D829039E8A40;
	Tue, 10 Nov 2026 22:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net v5] seg6: validate state in netfilter continuations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179434980568.92301.4463264315328540233.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 22:30:05 +0000
References: 
 <8574739acd6f5d9eb0a5640e893122619e9f79ef.1793726355.git.petalzu987@gmail.com>
In-Reply-To: 
 <8574739acd6f5d9eb0a5640e893122619e9f79ef.1793726355.git.petalzu987@gmail.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, andrea.mayer@uniroma2.it, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 contact@proelbtn.com, pablo@netfilter.org, vega@nebusec.ai,
 sashiko-bot@kernel.org, petalzu987@gmail.com, liuhangbin@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Nov 2026 11:30:19 +0800 you wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> When nf_hooks_lwtunnel is enabled, End.DX4 sends decapsulated packets
> through NF_INET_PRE_ROUTING. If DNAT changes the inner destination,
> nf_nat_ipv4_pre_routing() drops skb_dst(), and the continuation then
> dereferences the missing dst's lwtstate. This causes a KASAN NULL
> pointer dereference and fatal exception panic.
> 
> [...]

Here is the summary with links:
  - [net,v5] seg6: validate state in netfilter continuations
    https://git.kernel.org/netdev/net/c/549484dd3e80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


