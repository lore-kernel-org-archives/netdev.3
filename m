Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62A36A031
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 03:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767977; cv=none; b=jsrgWZeib04UE2DBiWz//UG1WuSxf5fN03w8tpzXyoHdwoRT0CDXQZngc8IHpGf7k8oDF51c9WSxm1qmTAsjRUvAtU1XfosXBkOU5sftn8xcxFQZlC/BhQhew+A5rUfjJAM8poKQ8HIo30goxewlRRatoLr5swEAL6Yiv9lxdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767977; c=relaxed/simple;
	bh=dHeHma9AiWF1RiaOUAgdoIsbggNG2YQxNrnoSZiH8cA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hJ0SxcpvyT3w1TQ58I50u1MtxROdGddzByD6i3zXmty49osPFQRkSthp85vjDvFSz2w/dzuOxwT1iHe+F+bYUh6gXwOinFnbMGZ2FY4PDvomQttMxcTbSF5KXIEPCih+KBhIt4N+/kbfzWeMFVpvrHWROpExFX8d6gnRVVj0hLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMGGkGu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMGGkGu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05F8C19423;
	Fri,  6 Mar 2026 03:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772767976;
	bh=dHeHma9AiWF1RiaOUAgdoIsbggNG2YQxNrnoSZiH8cA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vMGGkGu0tSCBjE3psm8TVkzP/xK8u9zutqEo5acgnrgMLV03DcSlrz8mKYh1PLjc7
	 /WN2XdGFoN3sBhQMDJ8FN8ATC8qonD777pR4QyPnz6bfbYU5TgsCrs2TLZg+0zXypO
	 fQseQXN3eBWFSvgOEMxmpGnK8wT2UnWAW4enshurKdKX0g1BuXdtKiJfKsoIEpKTlO
	 G77MCqPDMuoO1loe0l9+6DQ3auvwWyPrRcsxXk1lmdbooqM+33p+kE3IHT/X4KV3bi
	 MAdiwlZRjDI8/uXyAvkc8j0Ass5CkjJ1rvEMXLf2MbPYzc/bRCyGUpoHdTROIisjiA
	 u/mZXWt97GICA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F823808200;
	Fri,  6 Mar 2026 03:32:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Rely __field_prep for non-constant
 masks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177276797654.3348267.16106814160751955991.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 03:32:56 +0000
References: <20260304-airoha-__field_prep-v1-1-b185facc4e2f@kernel.org>
In-Reply-To: <20260304-airoha-__field_prep-v1-1-b185facc4e2f@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Mar 2026 11:56:47 +0100 you wrote:
> Rely on __field_prep macros for non-constant masks preparing the values
> for register updates instead of open-coding.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Rely __field_prep for non-constant masks
    https://git.kernel.org/netdev/net-next/c/7600fb3b41dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


