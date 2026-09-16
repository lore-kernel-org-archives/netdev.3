Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D738F253;
	Wed, 16 Sep 2026 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521674; cv=none; b=hNWCUPx4JoC7KiXs9NdfZQQ1Ns1EQlTO66gVcO2phzkxDWakStwjEO3M0tX3AHsEizHoe70HciVsXGG4kI/YMhRrG6tjyYZboOfCKED1gUKtPkZj1+fn48Z3PH65V6GnSsKmPk8jUcKSkTowFxjo+YXbrQoH6dj7qN24Zumk2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521674; c=relaxed/simple;
	bh=DHLMQOYC8C4G8KEDugaGMVZg2k45mWxlXS9FzgigAtE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OcWuih6nVmxgbt51cWSp1mFHrTYKI6wyE6pCyqjx3AgM3viDKgEDNbOvm/iHZrTkWxnk41MNczS9ge/+/LpGgCOUBnUDSUKz1IXZZb/tSRp/v10Sd094ajRDDGvlrducPVXmGWCGuYz8qClFoQ0qUs1GcH0kYPfbCp32lrzBVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuIRieq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuIRieq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2AF1F00893;
	Wed, 16 Sep 2026 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521673;
	bh=qFu+XMRGsq0vqlI36YH0NwpY2enQgcyoZNkpFXENMyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AuIRieq2mB3oy5C3YgHYq64JbtB3IG5yK0N5QSAwvKmmQhyMY89sRrfEcNKeOBYuZ
	 QlB1wi8vhoUxDYFQWKd/BU02sOkROGNbbam7T8GtVIiM618oUxZ7yKwYbaIlk2/RnV
	 +cc/es9RHZldS3tBDDEMKjtC5gMtaFo4yedWT4qhtUSIe1mbZCi3AfHjszwdnl8bm5
	 0yDPJnVXf8MH2xeqM+UGxuGgt1G3CpbUC09LlIEbMBsyuthGig7neA8wLzyTwtIfa5
	 kL2fi0SYezQYrYYOsTqvwBLQEffe8HxXjG6YItADzJY1EbG3DDvRS+3gK6cRf6Dbr1
	 Cu/SM2Ze0vekA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8D3927075;
	Wed, 16 Sep 2026 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: free the fixed-rate clock on cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178952160739.2349576.12830147384050698573.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 01:20:07 +0000
References: <20260911155318.88857-1-mhun512@gmail.com>
In-Reply-To: <20260911155318.88857-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ae878000@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Sep 2026 11:53:18 -0400 you wrote:
> The fixed-rate clock is registered with clk_register_fixed_rate(), but
> its error and removal paths use clk_unregister(). That unregisters the
> clock without freeing the fixed-rate provider allocation.
> 
> Use clk_unregister_fixed_rate() on lookup creation failure, later PHY
> initialization failure and removal to release the provider allocation as
> well. Keep the existing clock registration and lookup cleanup ordering.
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: free the fixed-rate clock on cleanup
    https://git.kernel.org/netdev/net-next/c/87b80c2f6b05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


