Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F493DEAC6;
	Fri, 14 Aug 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677911; cv=none; b=MAsGzXYfyC4TbUVF1WZ4nJX9wGHC/Ndu9kuCsmwYbnm7330gKsrCciT8d2TeqQHTSaqkIzpmDdhH3cJGfbYk/396ApY3J8la+KZXWTF8rdPuzpmQpIrpcSsB7SrilMec7Hr25LAjB/RrmWDQ89c1jD4LBj/LoPezz19xOHrOLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677911; c=relaxed/simple;
	bh=YoCEG5oDHH2JT3FFYTGar9tJJiYeZdDFzW7BXPbdlu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a+78+Gy60ZlqzaDqPBq60q3KWO5w6hlrBW8233TTS8N7RHNCuC8P8PegvcR4x+fjiSW+O0f/HlYsDRIu4whahhS0FKZsdovwaE3AteTeJ+7pVgTZF7cztkh+w8u0FKWS6Cv6ZkKJBQSBdTAzFlLJfMLZn1vMXAS41rxbktzncGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGSR6aXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGSR6aXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B5E1F000E9;
	Fri, 14 Aug 2026 03:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677909;
	bh=y7mkYw3MhVvZznrtz4d6TGUxxwBotmFtBYc81IbTb0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RGSR6aXo1jDngPqEJfL+/IGOmZkLbTGR2b3y10vC9VhRt5s/VnrjSZubjyTwBSTaX
	 nNTXxzs5Zlg3LS3kfoMsSThNNG3ELVbnPSSpFR7L8/0Q6kfMFAaSUGlHDAueqn0MCy
	 BxraMzy7gXOauYYAnU/72DZVBKAIGuKA6jRpI2p8a9HEZwTTX1Mphey5yEGv2CXOoF
	 BuJ9AjmbWEmHEaqWiJeGarp8YR+bVimaf6ica02KscgUEZ8i5Ru1w+dg8yxDPml8ow
	 uW4yU4B9QPQkoM2apZ3ELwTNK2qWLCt4PjmF6ZYvtjK8noSZwPVQeAd7dMvHxlh1OH
	 rc01Puez3vihg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A613810900;
	Fri, 14 Aug 2026 03:24:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: intel: Add missing
 pci_free_irq_vectors() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667786389.3150297.7630316511132151539.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:24:23 +0000
References: 
 <20260810-flo-net-stmmac-default-affinity-core-v2-1-d2105780b8ca@siemens.com>
In-Reply-To: 
 <20260810-flo-net-stmmac-default-affinity-core-v2-1-d2105780b8ca@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, boon.leong.ong@intel.com,
 weifeng.voon@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Aug 2026 15:19:17 +0200 you wrote:
> The IRQ vectors allocated in stmmac_config_multi_msi() or
> stmmac_config_single_msi() where never explicitly cleaned up. As
> pcim_enable_device() is used, all sorts of other functions are switched
> to managed mode. The missing cleanup here isn't actually missing, it's
> buried in the depths of PCI code.
> 
> But: There are some ongoing activities to remove that cleanup magic.
> See the linked discussions below.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: intel: Add missing pci_free_irq_vectors() calls
    https://git.kernel.org/netdev/net-next/c/a7c44619c697

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


