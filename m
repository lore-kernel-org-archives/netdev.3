Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301807;
	b=CPi6mB8ztGbBziYdwIokaEDicN9Nc6CqbFUZSIWUJM71KwlgQruC0JGXAhl2K4Gt0axx
	 LTzJptSyzVY6C+H1CTfop0NWsc1ma6v4R+DjszAiX9wgOQMLFr0ngRniAK2lMokmp3VU6
	 fYOB/DBdVHM+2r7FxUc8QTxSRz+CPFZdNjBtLuRk7mgs2BLaT0SqAYW7yCxjm/dVGw32E
	 OL613s/6XOtBqRqUler1C+uAbxvW2P6q/oNap8jyzZ208RjABcsyZ9Q/PRvmtaqwZRKgb
	 2i6O+UxKUnk58ZSGZg6SOleKgOlUmB7vN2iXSphVUX+tJ5WKrtaJiymhzXtHfj+5zEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=V2sIc8s24cF7L0auPIZIKq2tXAdoDlboyvzI445LkEU=;
	b=a0ygNDCkYDUlukae5/tqN8BeMt2u39hn6g0hS0cbLECGab0jvdHyC3+DP4mphIhmvNBH
	 vgaiSSFaRweFbPodwb1tozpUJ/cKa7ToXXSKrRFyMpb/Zqfh8w0B4pRt1Md3dBzVrhHUZ
	 7kM+Jf0Odf9G0vi7uA37blAghoYET27Q+LqeM7VfyFaiKCrVvHCBgi3WUXSoZvQIH3KrN
	 CmXtih2qFht90OsbQAY32PHAEUZJnCGx6ufwIwaflycGXMhIg0wj4qC1eDMpx/9IXarTY
	 aM8i0DSWHnuI15//Ux8srs+PHmBYfo+qiXHdgo//yfKOn6cPHI3HQvgJjeacfvCNJ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jw8UVGKd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0D606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jw8UVGKd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ACF1F0089F;
	Tue, 10 Nov 2026 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301806;
	bh=V2sIc8s24cF7L0auPIZIKq2tXAdoDlboyvzI445LkEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jw8UVGKd2ONnalWKfVYtAwywVyoKLKaUq+OK3m7OJnIU0UYzo4bSapeF3ZgME3PUB
	 d0l+RG5IBD9qhuQu2ksHv81HAF57qKgEmcwgZ2Iy+lBnLVQT8Yuevsgufq/vNIQ4RA
	 zZH5axFlCdICDCamQrTL/eLOaLNX38UkAbPsh8RHvErlW6705bD2INe50NCXtHpqkY
	 5zBDFHq13od9o6zhn+NuljcT6VrbrDxHcru4sRIrj83WFDU1Kae0rqD+8OtKxsRUVK
	 nuC37B0DeBm89bm0ZlZMO8BTrbHO75FdR9YPH1YmaS2wKb/3l2Yi839Kh7faLl0NVk
	 OobF2voftON8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B102391B0A7;
	Tue, 10 Nov 2026 09:10:06 +0000 (UTC)
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
Subject: Re: [PATCH v2 net] inet: frags: bound the wmem charge of the socket
 completing a reassembly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179430180543.3797379.5984567968316678172.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 09:10:05 +0000
References: <20261104122927.1033747-1-edumazet@kernel.org>
In-Reply-To: <20261104122927.1033747-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org, fw@strlen.de,
 pablo@netfilter.org, phil@nwl.cc

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Nov 2026 13:29:27 +0100 you wrote:
> When a socket owned fragment completes a reassembly queue,
> inet_frag_reasm_prepare() and inet_frag_reasm_finish() charge the
> truesize of all other fragments to its sk_wmem_alloc. These fragments
> were orphaned when queued, and might have been sent by someone else,
> for instance padded TUN packets.
> 
> Commit 3ae20e4697eb ("inet: frags: limit the truesize of a reassembly
> queue") bounds this charge to INT_MAX / 2 per queue, but a socket can
> complete several queues while the reassembled skbs are still alive,
> for instance held in a qdisc. sk_wmem_alloc can then go past INT_MAX,
> refcount_add() saturates it with a WARN, and the socket is leaked.
> 
> [...]

Here is the summary with links:
  - [v2,net] inet: frags: bound the wmem charge of the socket completing a reassembly
    https://git.kernel.org/netdev/net/c/b71c101bbb98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


