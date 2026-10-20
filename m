Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462808;
	b=0QS/4E1tkpG52sIMYZ96DAOECTc9w7CEtt20WiTA2VOWOkW3uGdLNfkFWibfmXUCyr3f
	 PQTJ5ST2qkk83Vo2OJzKS4tjtjw0hbOpQRU/IWQ+RGjZx0C8SVFIKC12v5I3deZv82owd
	 cQrkWW5seRQdYqYa5aL5bdOSuY2aWv7bDtJC7FigJ4ResxjzQyoTes3ASzw0Xr4PuHIMm
	 LfRrNW4/sBihvgXUHqq1wqbg0nZdGzoZH96O/jaNzDW+/TlSmHsJMuX9yTVW9LXaGXsln
	 RgxeQarefKVGLCoGSdkSwcTp84IfalcaefaBtApP1bp5IqZfQBhWLIOMV1UeyW3Zh7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=g5bYbQ/yGOxA8yv59v0I5cj6dg4wwRzsxQIpkc/8d2g=;
	b=Lsj5KfpPkFneCf8Df4d4P2VYKdtUM8AkI9wzfXd11u20DemdQrw+6sqtb0MdMsOoBN0B
	 PHqZ54nBE11/NJtRTWcMbt6w7PZAzzis+uL15Xjz2Ibdzopu7dtDNB3JuYW+43LzKAT1n
	 rJOLhwr5zDmB1TTTneExnfcDGunUTpx51MoNjTs+YrLxLzw8uv6uwveBSre63TNLJgqzc
	 aWrnmHpVy1YrFtfS6JJ+plYlvkzcFELGig48uKKO0pbg141sHpOTyZLMCQPmGfrKiN6SA
	 uAmTiGG2r5bCGrH1yA5gA3T65x3GaduR4CWdBWYr+LKG/tSWLSxsoSt4D9UV5RXqVQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjmYPpMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E635606A31C
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjmYPpMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5A41F000C4;
	Tue, 20 Oct 2026 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462807;
	bh=g5bYbQ/yGOxA8yv59v0I5cj6dg4wwRzsxQIpkc/8d2g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HjmYPpMdP84qXgsbWnGyevWOd9F3k+cyoyruaflz4IE7W1AsZ4thKf/thiTA0Aold
	 eAK6MVc+7TGX6F312lCdrfMY1e8lsp2jU6j4u+vPdN0C/oHbtTYWwjyQXf1hYHHO8a
	 EEje8WyOMJJhAJ8iPPGGefdC78ncH5MOyLOhncy9NmL91roYkSbmiTNwbl2BCASszw
	 sbjEUPyYHhSrk0WUoAu+WzCxxJe+KviDmxawILmpXUkbR/RQz0ArzgYcV8WgNtPK0R
	 pjhshVTLL2Z+Mjx9oEhADHTFOxIgrBrFbhapM/ISxMNY3gSglPd9sHCNBiieGyCLs5
	 T2xKNOL+5NdxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43C13924A6F;
	Tue, 20 Oct 2026 02:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next 0/6] pull request: ovpn 2026-10-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179246280653.3441618.14893314533107061618.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 02:20:06 +0000
References: <20261012133809.2477063-1-antonio@openvpn.net>
In-Reply-To: <20261012133809.2477063-1-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, ralf@mandelbit.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Mon, 12 Oct 2026 15:37:57 +0200 you wrote:
> Hi all!
> 
> Here is v4 of the ovpn batch for net-next.
> 
> It is all cleanup and selftest work this time: no functional change to
> the driver. The selftests get TCP_NODELAY on ovpn-cli's TCP sockets and
> proper synchronization against the server-side key setup. Ralf is added
> to MAINTAINERS as ovpn reviewer.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] ovpn: Fix the return value in ovpn_bind_from_sockaddr() kernel-doc
    https://git.kernel.org/netdev/net-next/c/c73695b5c297
  - [net-next,2/6] ovpn: remove unused work field from struct ovpn_socket
    https://git.kernel.org/netdev/net-next/c/1926cf58b0a8
  - [net-next,3/6] ovpn: remove redundant peer NULL checks in crypto post functions
    https://git.kernel.org/netdev/net-next/c/fbe0f8413514
  - [net-next,4/6] selftests: ovpn: enable TCP_NODELAY on TCP sockets
    https://git.kernel.org/netdev/net-next/c/5a5c645415c2
  - [net-next,5/6] selftests: ovpn: wait for the TCP server key setup before traffic
    https://git.kernel.org/netdev/net-next/c/03b7050e67e2
  - [net-next,6/6] MAINTAINERS: ovpn: add Ralf Lici as reviewer
    https://git.kernel.org/netdev/net-next/c/b2ed202907d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


