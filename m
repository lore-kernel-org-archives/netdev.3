Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511212;
	b=F4vrFYtP663IYEk59fpc+jh/8pjMwbsb0A2wMbQN4DMaj7pxVW3nR7x2RUJ2kXKgtex4
	 7+Dc0ftB8RqXf3/ROJm0syO5lqCX7QbGswWSk1Za1jv7XKBx/kvlCSZzgkT0DGb+kDSzx
	 lh1/0s5yOkVDplRvn+XTQ2R1B5lzK6TWandXjGybzAodME3FFTtdVf60F8Sr/oTO/KJU/
	 5hvOWtmab48mgN42s+X6puWd4lmSEHEwqAAiFmqL03Lh9TV1ZAhaz1mwVZEF9pK5OLWYt
	 KsHT0dX21qzK5fQH8nxftQkHSzj/9xPuDPG/bpuXkCkDlSKAOotSiIv0BOwj6Mc59gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=0ouaQ9hAKiWg2XokYjCqBEUlB2PazxrQWltdmqz5y/k=;
	b=KqX+nnq+rrzRI/s+ApZD5fSl7+24yOHt0adtD1PVixeJSEUvOIsjwn5gWy2Rt4A7dk3f
	 AMliWHdVAAGHaPtpT0pjUYwEMyrJOXpPBg/c+83gGSK9nNgtJdStOkQGdwq3b7lMLcWFy
	 UwMd06TaoXEfEek614j4Auolw9Q2YxwXoH815bVNTju3L5JYiCi7pCIK5/R4EOv334DJF
	 J3vcoXOiOXPCvL+XzkQFIzZO21qoSDzSLnnC7xc/OBjxIfxf237ya5p5riEVYwH2snWLd
	 smDdRML5usIs4P8GPp4OSqLLskZRhNN+Me8rrRXHGInFkFDkCcNAA4ulukG2Q3N9dDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHC9ISVu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D8606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHC9ISVu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E6C1F000C4;
	Thu, 12 Nov 2026 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794511211;
	bh=0ouaQ9hAKiWg2XokYjCqBEUlB2PazxrQWltdmqz5y/k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dHC9ISVuuUNpDwXYKKmFWHjt044OGLhQKONMg2w3iVlwsv+3VvXYOLXTw2bSKXZ1V
	 up2aJVFTCc85druRrg7EU70w9ZHG81vFTpwfSt7GpODVlEotWPnzPdQK1TrlB+3Wix
	 eLD1mUN2wEHRKot8XdLNv1Syy3Dz7kRxRjdMi/GkOvAu82soorjqrI3urUqM/ZXhE3
	 3qMopwJTRe0E1izz2/nd0bKsyEt3uQauQOBzsruEwo7w83uCpb/R8bTlCplb95nSgm
	 nM7H/t4JY0d3mjowtQRzsutqfqc/xnvtikbN/SGJ36I3G5Bm2plQcFvdMeXTpp2dCH
	 HEQlTBXS93dAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774B2392624F;
	Thu, 12 Nov 2026 19:20:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next] mlxsw: Disable LAG collector when requested
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451121002.604801.11604496197822603809.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:20:10 +0000
References: <20261111170925.2809513-1-idosch@nvidia.com>
In-Reply-To: <20261111170925.2809513-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, andrew+netdev@lunn.ch,
 petrm@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 19:09:25 +0200 you wrote:
> mlxsw_reg_slcor_col_disable_pack() packs the "collector enabled" value
> instead of "collector disabled". As a result, once a LAG port is enabled
> for collection, it keeps receiving packets even after the LAG master
> disables it (e.g., when the port loses link or the LACP partner falls
> out of sync).
> 
> Fix by packing the correct value. Packets received on a disabled LAG
> port are now dropped, as they are in the bond's software datapath.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: Disable LAG collector when requested
    https://git.kernel.org/netdev/net-next/c/073d54dc3ccc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


