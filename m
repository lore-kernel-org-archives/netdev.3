Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15E37DAA5
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593259; cv=none; b=e2lPTAYYFXJqhJQzYNZ4tsUIwH5gcMfOQ1X853lH4HMOjjN+k4gdl9uK4iXWEsyhXN02hm1dMDnkXTb7l76xt/bPj+moZDwFx2UInzPo/DXekWpVs/qFUvwOvNyFoG41OpWkkkFbTj+g0srDjEDfoCvvAjyjGoL709cWReJ1kMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593259; c=relaxed/simple;
	bh=987bjNRCrI3/Zujt7W+zUe5CBFskLwI/W/PALNXXSqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MYO8Xoeal3KLRtuvP0uErxWudCR1urB8WIBWRh7c5U7Ijoh3Bhyjieg0UidZ4NyVpIxCa/gPLcLG8zJ34/p6JNxDeODtk31CwjXCsbhBbChxga7UUaWJjo82+OSI1RoLNOzVNfb/0hE/AMCcKpjwbrT+OF1eXOuZpNSl0N/dmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyeOW3z7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyeOW3z7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C34C2BCB0;
	Tue, 12 May 2026 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778593259;
	bh=987bjNRCrI3/Zujt7W+zUe5CBFskLwI/W/PALNXXSqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyeOW3z7uGUygE6nQcN80o59NMPBXWRoSgeYa/rjIA6rp/ls22MdtWVxo3QyP0j4+
	 HwTsJUHCO58j6elVE4tAKeVOtfYQMBQkc3tOXFCSuGoWjL4jNKlMjT4WoWnj0iPsVG
	 3b511Km4HzqLUGABYPOaJB6R4ZEjIoFSNgzF/URqpS91nMdzcMf2BzKxSMndRK+hY1
	 bYbs9GshuTHIy64ZING6s95TSF6r8C700OmseF+4AiGyfHfTsnWv5odQX22r+7FdPl
	 Svd2Nl8U1dTKuakWqgTkIUTGVIzoMKFNGZmgefN3d/LQeepRy4yBJ71qLWXk4Bzfh+
	 9H02qASO5gxBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E9B3811A57;
	Tue, 12 May 2026 13:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS
 reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177859320580.2872735.6530995193637920675.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 13:40:05 +0000
References: <20260509023732.42256-1-enelsonmoore@gmail.com>
In-Reply-To: <20260509023732.42256-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux@armlinux.org.uk, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  8 May 2026 19:37:28 -0700 you wrote:
> The legacy ARM board file for MACH_MX31ADS was removed in commit
> c93197b0041d ("ARM: imx: Remove i.MX31 board files"), but a reference
> to it remained in the cs89x0 driver. Drop this unused code.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
> I found this issue while working on updating arch/arm/tools/mach-types
> to remove entries for board files that are not in the kernel - this
> reference caused my script to consider MACH_MX31ADS to be present in
> the kernel.
> 
> [...]

Here is the summary with links:
  - net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference
    https://git.kernel.org/netdev/net/c/36a8d04a8293

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


