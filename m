Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627809;
	b=xSbsrDjNX2VH5JbbmvICNW9qEjsb1VZBehwipqb+pPvGhXklY713GaHimvOErqn3C2iY
	 y2sz/wKxjEFMevH6UqtuG74PICGbOhahB3dn48HRIiHsuidaInu+y8a39qk4/djcBt9PE
	 uDz7InVAhuliyCl+XRVsybwSlhSCVx+BSu09HnHEYwLb22QN445WY1xx/xU44fnYb0eNx
	 MzoBydC1crLXtqobTPOz8Q74OWj7sVrqLLA5EdVXiOQ4XsgajBARM+w6JHoo8tiT4t4c5
	 08gsouBcZqB7OB6E9rc1BETrZtTGr+wzA8HIut8+UHhproHksxoFzVHGOGN2UbRbMXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dnyihWPEo2bF2vb9mxR/7VSP0rlZwsuun65P2lwCSHI=;
	b=FFjqO5J9gNLTvIAOAwq+s2vnT3GRSZK4Rp1A1r2hEqwCteNiNJYn9gGDooipQTW0vnie
	 XgwWIA+145HsIk/WhmrjzYQo4R2lo7tT1fsASH+T/VgHf0pPXX/LwW8m4HVd1p94O+++z
	 gbMfucDLhUvlxCEGm21MpXwlauObhyQNVUC96CHOl1zSUQs8pKB73giCslHsZB7kCobc6
	 CuSCQCVTwS9QiLlbu/FXUsWhp6zE/XAgh58blvCnG8GalHRV/q0J9DFoUWaoysuPkWrHk
	 hmDNMEO44OOpgAet3F5TSg9+rirPnveMLyy46iwkE0/c6tT4doQUiYvqAtKFRiE2sog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IdTWf00/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEC606A31A;
	Thu, 22 Oct 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IdTWf00/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834681F000C5;
	Thu, 22 Oct 2026 00:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792627808;
	bh=dnyihWPEo2bF2vb9mxR/7VSP0rlZwsuun65P2lwCSHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IdTWf00/atJNKRcZSkeSvxFPLdWHKjjmlg5CyJGAaFz9BO1cV7tJB+7JXuEcRWRZ6
	 +exu78ezLS7hR2iSuZxKMUMXMswgMHNywTY0So3Fi84HnSgv2POgS8CeHZykuXpCZt
	 2ziLEw0WGkuVDf+Ep6OEzinHrPgIpPTpdWWy/HTpb5OqfD5TNB3dTj/ZZuE7xhhwVT
	 2xZt9NQ4+CD2d/8Lbcx941hDg5SQ/tXU1t+L+o3cnEEB3JRLTxq3D1FrzV/D3CjJUE
	 aFbAiZuWZ8gE9RlZOW0V/PJ6uG1vOpFd9rsht5QmanOUWqHMsSckg5Cn9WFYQUinLQ
	 LcGqHhGpRNTfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7741D380A963;
	Thu, 22 Oct 2026 00:10:08 +0000 (UTC)
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
Subject: Re: [PATCH net-next v1 0/2] netmem: rename non-pp ref helpers to
 *_inc/dec_ref()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262780702.1374404.5723531737292804675.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:10:07 +0000
References: <20261021015558.4124825-1-almasrymina@google.com>
In-Reply-To: <20261021015558.4124825-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 john.fastabend@gmail.com, sd@queasysnail.net, ralf@mandelbit.com,
 sdf@fomichev.me, asml.silence@gmail.com, bobbyeshleman@meta.com,
 willemb@google.com, daniel@iogearbox.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 01:55:56 +0000 you wrote:
> Rename the net_iov and netmem non-page_pool reference helpers from
> get/put_net_iov(), net_devmem_get/put_net_iov(), and get/put_netmem() to
> net_iov_inc/dec_ref(), net_devmem_net_iov_inc/dec_ref(), and
> netmem_inc/dec_ref() to follow the object_action() naming convention.
> 
> Use *_inc_ref() and *_dec_ref() rather than netmem_ref() because
> netmem_ref is already the typedef for the generic network memory handle.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/2] netmem: rename get/put_net_iov() to net_iov_inc/dec_ref()
    https://git.kernel.org/netdev/net-next/c/bbee99902520
  - [net-next,v1,2/2] netmem: rename get/put_netmem() to netmem_inc/dec_ref()
    https://git.kernel.org/netdev/net-next/c/2620efb2cec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


