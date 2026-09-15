Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902184BEE58;
	Tue, 15 Sep 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439470; cv=none; b=rir1ylLCFjKV1avevioFAhv8kAgYCJm+lLMm4vnupBT7zO7zKnZOEGGIYths8emc2DqwSuComo6aCHhlvbmaeD8keUD1JdTcQnlkdk8IJ59XISx+nvUe4mFqk3KmIbqNrl7sPTqUbRYSiEJzahP0hAFwWVijsAjLBIOrW2d+Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439470; c=relaxed/simple;
	bh=zFND42HEiSFkMuPzbTMZQRJP2AeJRtWlekxB52noHe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rw1c7mzT22NaHoUE8UqFQz+302DDF4He3wjfGSrlZLYY2llqwuT/7fWt1OIrBZXNOodQVNqWAJKjvumWQ9+gdFRN8tzCxV0rxHs5zsEG4AfHOu6O5V66F2jH30+t+ogyNhJjxt7KB3amv77sNIt4Rzb0c6+dqs8c8l7Kg7Jgkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6BVmp05; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6BVmp05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375661F000FF;
	Tue, 15 Sep 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439469;
	bh=gv5LBlaojcS+9Yw3CljDaM6/vinyztrz0NN70y6VBlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S6BVmp05ab0zUmAhhWNCB2hiHTv2m3/7+dhoaRoTz9h2ubLsTl47dW52EI97R6Rd1
	 bCne4xX0DH3CkYJ4Eolq9vi+Uq9dw3Bne1y8iIOpFz9vRKXKmPA+aU+fcmjd11wWeW
	 +AIazJpdIEsupC3iOFxz8emLWp2L1MyEXiPKbl3c/+8HkCbZckoPjjxVprSAReoaR9
	 GxV1fKqFqQ/ua6Y+dcg2Ix0V2l19DGD8LnImPOA2OYcmjMiinYXqD1LNaSk84jmcpT
	 ZDPBaCMWFJ0L0vh8pJVSw94Z1n0xnp4bv3vzQMUEd6aUjoQDXKcZu3ZvUf1DqEAwhZ
	 H/C7sjLWr7fqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B23924FFE;
	Tue, 15 Sep 2026 02:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: restore the hardware filters on open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943940413.1322157.6253547859106825351.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:30:04 +0000
References: <20260913190052.939955-1-nb@tipi-net.de>
In-Reply-To: <20260913190052.939955-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, opendmb@gmail.com, florian.fainelli@broadcom.com,
 justin.chen@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 21:00:52 +0200 you wrote:
> bcmgenet_hfb_init() runs INIT_LIST_HEAD() on priv->rxnfc_list, which drops
> every rule off the list, and bcmgenet_open() calls it on each ifup. Every
> rule the user configured is silently lost:
> 
>   # ethtool -N eth0 flow-type ether dst $MAC action 0
>   Added rule with ID 0
>   # ethtool -n eth0 | grep -c Filter:
>   1
>   # ip link set eth0 down && ip link set eth0 up
>   # ethtool -n eth0 | grep -c Filter:
>   0
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: restore the hardware filters on open
    https://git.kernel.org/netdev/net/c/23ca4ddc4fce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


