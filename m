Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D572602
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791337808; cv=none; b=LPRENLPXcmAFq/aTfJuRoQZAmRDwEP/k7dbX6nergRD3HbJQx/2mCuXnb/Bozxf3CclzpDlc8f87p3CDJ1udPDdePFx9KAmHvHqUUm6X1mgsfaNJo0zVmJ7vAFprlDeuDhXzbMoNhAX4ond+xZ+SbtiOXuYUgJ20w3HjYj9WiD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791337808; c=relaxed/simple;
	bh=3oqClTsbLTQpCFmYDCapkKGSH8UqjsgecKKh4I0pbJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d4cOBiDUAIJ+s742Oa4s7yv7TrlSn2rxMcjuT6lBVT1mXrZkPWS0d0P0D6Ohq58oTeV2Shze6w6XePJ18cf4XhYXCn6KWXS2y0z7CNlI1RsYrTK5zl5yA4V2pQ9+ik1ViMQ2FNlPiNiXk2E26smKHRFL/OFTpxyaDlgL+Znz37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5a2qX6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5a2qX6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBE51F0089B;
	Wed,  7 Oct 2026 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791337807;
	bh=y601YrjcsW8gJ2/InPRMHcxzGu9BxJNLhNP79l8bHSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=P5a2qX6vLUNqTZ8p+utEQQH6THNaAgsBgJP60UDojiVu9bCXckX2PoB3lWOkwRM7A
	 UDU7YSuWQ1ujxWMA5pLXlHI+yjlzAFSo2yT2lQHmwBfVhuuQWBQZVkyCRmrM+8M935
	 cY67hUvPL7j4uFp7HP1uDDcL2OHAJJrK5Dtw1s7NRNvX+Z64X132n4to1jTUwQGJQ6
	 e49g85aP1K34VKoQqKSwXX5AKzbDqbG1rQH8cAIHz61ixo5dOcytvbDYDjITs9+ee0
	 +WmPvDcCDs0DNGgqSNoC09XTlYF/dIp8nNogzSxlBpkxS9mHCInDIfG0OcnHO2JVHM
	 5xes+awWbNEtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15F53806541;
	Wed,  7 Oct 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bcmgenet: if UMAC was suspended in SW_RESET,
 restore it to SW_RESET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133780553.2868218.10622066484644676462.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:50:05 +0000
References: <20260930230634.3132729-1-justin.chen@broadcom.com>
In-Reply-To: <20260930230634.3132729-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, nb@tipi-net.de,
 florian.fainelli@broadcom.com, opendmb@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 16:06:34 -0700 you wrote:
> When the revised suspend/resume sequence was introduced this led to an edge
> case where the TX is left disabled in the following sequence.
> 
> 1. phy link is down, so UMAC is held in reset and then network interface
>    is WoL enabled
> 2. Enter suspend, bcmgenet_wol_power_down_cfg() enables UMAC_RX since MAC
>    is in SW_RESET
> 4. Enter resume, UMAC_RX is left enabled. Since we only enable UMAC_TX
>    and UMAC_RX in SW_RESET. The UMAC_TX is never enabled again on link up.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET
    https://git.kernel.org/netdev/net/c/5857e5a196b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


