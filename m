Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285E11A6839;
	Mon, 17 Aug 2026 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787007058; cv=none; b=VRgCZ0QaTQ9IE4VJInoCBiQp2VFGpgRvuOJIprDBiVLYo6ZShVzLyz3kKrlaeKHMMtgCVEZzL7IVIemDpR4mpCfZA1eYT3NDKaLhO9oRIcRf6l94Eys8ehiSXrWGpb6IQIFowBaxbw9hmdxPPmSu5WAyKvubXKRVv4mv0xafSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787007058; c=relaxed/simple;
	bh=j5vl0x9hDTAtAkNBSSmB47CNxzdCDbEr7SovrCgdMHM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q/DFRwYclBI7lHXxiqHDgU2y4tsk85o9PFb5ptjRAHB3YWCQkizes5OOGIVtx8486Zo8ym3ZYAdjOP1lulJ9eV/nW90LTE9o6CWI6sLkOEZMsJq/pGHWQQsg4VIHosZ/nZ19DghaE7RnfOZ1koAOTasWroVkuOlA92gljnpTgH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1H1Lnrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1H1Lnrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53231F000E9;
	Mon, 17 Aug 2026 22:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787007056;
	bh=yaIm0oXugQ4lGeC5WWrWXO9naNL5ck1LQjSa2nCLCf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H1H1LnrdwOOKAzSHr0K3Djrz0XZzTD7MsGqLikS4G1ulmvmfIp1ePgcZnkJFGDJyC
	 vvPgyhGwipfaiwPUp/hrnllJ4ahJCqu8OmsKvM+z8dkoq0gAMLBKJp8E/4F8Ermzv6
	 1i6QRCwZdvECHYpsRINb+AXCHAu1aiUymxVEfJITwg3Qi/r5u7sfbNI77aWSswGhGP
	 zRKRLB96/+mtOc2C8aSCl7D7W+okLlcJZHKjxbuIloz/vnVGuwzexxSNscyQZJgflI
	 d9qeLIR6BIyPETQM0wRfizMdspLj0X3U3RqWereom2GFsIgHL5Z1kBTOspJVBsT6rC
	 x+IusjgasouTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1986F3926274;
	Mon, 17 Aug 2026 22:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] net: ravb: fix PTP clock lifetime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178700700889.1778540.4257468001265740623.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 22:50:08 +0000
References: <20260811103733.62599-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260811103733.62599-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 niklas.soderlund@ragnatech.se, kuba@kernel.org, vadim.fedorenko@linux.dev,
 paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 masaru.nagai.vx@renesas.com, luoxuanqiang@kylinos.cn

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 18:37:31 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> This series fixes RAVB PTP clock lifetime handling. It reports a cached PHC
> index without accessing the clock pointer and drains PTP interrupts before
> unregistering the clock.
> 
> Patch 1 caches the PHC index and handles registration failures.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: ravb: avoid dereferencing an invalid PTP clock
    https://git.kernel.org/netdev/net/c/1f77af0aaf27
  - [net,v4,2/2] net: ravb: serialize PTP clock teardown
    https://git.kernel.org/netdev/net/c/1cb9663789c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


