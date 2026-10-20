Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531213;
	b=o4WAp01x8KPpnMF8F3EYf3giaXWgAsoZUk7aKph9rFTDI8SuSnYGzH1thBj5sVeJPm3A
	 saT+XTKg0DXfDY1auJ7Pj0JP4KeDeF3lat9mlCYX07fieo4u97AWp759E9AxI1wzw/sML
	 tpyox2v2sjG/WBkggYjfH5aHU7MxcLpBWxQr1SSzPYvFuYWvFdqW9K+zT6Uy+ezopAzXS
	 8P9/6rEJhf4/uUfu/uiVkb+NTUFvyU4p/qOSYVG23U7JnvmoWK5nAlFw/jQtRcFYHyF6J
	 2FTblk1DDpOKPCqrGTuQ6QkToNzwZpxJ1iEIlxE+A9NgLrcMs2qO8BZCht1FnYEt+pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531213;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ucNKDkCAgw6e5UqZvf8d/LyJaK9DQ8c+wrKSdAKm0wA=;
	b=F64/UCC4gYxjga7YEnNuc6oQKX4RLbbFdgi0rAUCeFwjuMaA8v/UIwLHNWabAaesRK1n
	 KyW9ysGlYUbL4TsrlZ1r3xfBXSpmei/GbqYYaaKuArBM8S5IwoS5PBEnmrF0kIuoq8Ttd
	 pGxGIS1U2MytZtWyzAuCch191Hn0ugFxhnR2Zxco+PTT/jrdB4319d5RckZwMLk0fYG9/
	 LiK0Bj5mZcXvAMXeYrZtAWRBplRXOH53CUuu+gRqmWjfi+D4zsAgwQsD1nNUwjRaMtTHw
	 gscxh+fslCaGN1H8jOfXUH1jrnFit9V7BrLdcEAcRFzHVVqQIIdjiNpGI3Qxg0CadvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euvcJAur;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC0606A320;
	Tue, 20 Oct 2026 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=euvcJAur
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9E91F000CB;
	Tue, 20 Oct 2026 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531211;
	bh=ucNKDkCAgw6e5UqZvf8d/LyJaK9DQ8c+wrKSdAKm0wA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=euvcJAur0j6GScUbxndIkodhU/Pn70BvAs6oL/rGa2EjEu2BD01tzon7xFd7txdQx
	 OHqNpWne9zpraPM7z8Q7VnBU22Nnk9DImHymtBQFPAeWW8lAGi3+tcs+RctJbawB4P
	 Jp6MI6epkRf1ebFfgBybny3uPuTcIBcZFZYaX+LYsAdrmm/0mh+2hhWDQS5U/JcaFQ
	 WLoQT71MhP5bqRCuuhxRWJ1fgcTZhwseVZ6ojskdQiPEFlnRGdKFxc1oJjjuufZTI6
	 Hq4x+nYDdAlrtbGkzpzc8b0Nf3BsK2xdoskQ+qlmAstGuGDGQyR7QuxuMrFziSg1Nj
	 oGCkrNY6oN0Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B45B83809A09;
	Tue, 20 Oct 2026 21:20:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: dsa: realtek: use <module>-y in Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253121027.216428.10990552984336332525.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:20:10 +0000
References: <20261019-realtek_mkf-v1-1-3246a77d5782@gmail.com>
In-Reply-To: <20261019-realtek_mkf-v1-1-3246a77d5782@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linusw@kernel.org, alvin.sipraga@analog.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 01:26:27 -0300 you wrote:
> Switch from <module>-objs to <module>-y to eliminate ifdefs and simplify
> conditional object list construction. Drop the obsolete trailing
> comment.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
>  drivers/net/dsa/realtek/Makefile | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: realtek: use <module>-y in Makefile
    https://git.kernel.org/netdev/net-next/c/56c7aa17f0f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


