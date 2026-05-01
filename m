Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28329B8D3;
	Fri,  1 May 2026 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598457; cv=none; b=RsCMKvL1vG9DADAzusZyzVUPgP4lR7TcuhV0ZCdCFLfpFzZqomjRgXKs3+TuXyVkiw9uUe+GdS/c8Cva5up0DBehRdhUEWbNpOij9Cl4Cvkn40Ec/2BJ1UyK1F4hwi3wVnx/rOxFQxlR82AozUP5MWCycArrzviX+/S9AUminLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598457; c=relaxed/simple;
	bh=2imGXa3N6r4xt4ck+HHMhGUCCLGMkAH4yajp0OQSZbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SdeGtXN08EDPok0HzFx8jB3bpADW6JeJOI9GhGKXUbUg/X4IOOadF0yti/7oI7ukWA1uXeHR4qkEWJJVAjSn/0+bR+J4komqZlaisKfvyhc34is7y92a1Zq6+/kwQpXLvSLT/pcxYF01iOsqyKhgC41Jg+oVIqVrhl9ob9Ptf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNn4ZCLs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNn4ZCLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD5CC2BCB3;
	Fri,  1 May 2026 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598457;
	bh=2imGXa3N6r4xt4ck+HHMhGUCCLGMkAH4yajp0OQSZbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aNn4ZCLsxJaJzTtg6/0rth724e9/5nMOufuufTl6QyyLp6UrqRHPtGjkp4i4kuQgZ
	 5ZBr+YIIrWsT2VeT+a3zuk3sHdSfSlZveyGhYvqT+1PIVdU7vefmcsrmOhNyJUPAYf
	 i8Jm1oH1O4dsFGJ4eqxMq+YIZvvy1YLWO4r3MSb1qEioMKqdNqQde2uIKJwCEgtnCa
	 U/4nYIw4/EqUtCi+tMIZsc5oI8CNSfPetJZsZHuw0QfMFt9nNGyqX4WiRXYztqGFsb
	 cyMczgdTiWppzTOv3vqmRb+iEaqqJDxDGFgIQgX0KoJ/VPM8eJaANppC+2+G3rBcH5
	 gnWbAq20GKssg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F09380A957;
	Fri,  1 May 2026 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: enetc: fix VSI mailbox timeout handling and
 DMA
 lifecycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759841130.3278779.8173593080640794446.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 01:20:11 +0000
References: <20260429081930.3259824-1-wei.fang@nxp.com>
In-Reply-To: <20260429081930.3259824-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 16:19:30 +0800 you wrote:
> In the current VSI mailbox implementation, the VSI allocates a DMA buffer
> to store the message sent to the PSI. When the PSI receives the message
> request from the VSI, the hardware copies the message data from this DMA
> buffer to PSI's DMA buffer for processing.
> 
> When enetc_msg_vsi_send() times out, two scenarios can occur:
> 
> [...]

Here is the summary with links:
  - [v3,net] net: enetc: fix VSI mailbox timeout handling and DMA lifecycle
    https://git.kernel.org/netdev/net/c/26ebd12e67bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


