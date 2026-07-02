Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33959306774;
	Thu,  2 Jul 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986153; cv=none; b=GRR6LSvOtjzRWF1gpN8mR06ilxqRelyG1VcilKsYReAWI2jsA+ZuZthYZiAg9vNiZJ6uOiot9HYSOnoU4ZPODGdZsfvk5cHxJlT4XiXrw+lv1LLg7p57Autj0yXL2BplXZGxpC3g4P9ROfgK7tQUWA4y3f8IgWaTSftVYadro3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986153; c=relaxed/simple;
	bh=LkPKsNHLNAk3OonmvKB/37riFnoioX1QRlvpiDkTdNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLrxdrl95SpfZTOYz6v68wW/j/cNLNBcrSVDUzBqbmJ+u94/LZ7D1RUPMHzXg7+IHKKuv3GuC+ijNUpUOEesIck/3PnDXeb/JFqbAM0qsfzqG3q4rLhXP+o2rP3eDATqOS5EdhjiFrsPwOcBubr6kVbiwwlJkHoLGNA708s0pZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYQIAX3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYQIAX3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BA61F000E9;
	Thu,  2 Jul 2026 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782986151;
	bh=uUdjGp7QoA3bBrGaEIwO676+RcvWSHNkGcSq4/Q1CSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VYQIAX3PkXoVLwQ0oF5YNQj/oVSIRrq9/e6AuXOJYLiRxUC3Nkl4mh7Dr3PafYXvQ
	 G523j43TRDGExmdZaBV3IaZFR6VnzXIdB3nQPRz79G/30Ya8xV0fzFh9yAFH+MNlu5
	 ucb/yvquayukyvvZe1jsfonGS5SXmrsa+dcpfIEzeotfO8jbQ2bRRvcAXscHmDj3Bn
	 ECq8SoJyzdspNK6MF1c5G52R/+0lc0oaBoncDQ4Fe9qhAVt1FRA8YG9F8Xb9AWZCto
	 F0KW3lAhez2EcLF5rfQ6k1E0/Ng8mqHQbT0JBg8J0xfb2ScCaRAvuU2C5KFzXKVP3t
	 m6eOqCtzz2Oig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197C1392667E;
	Thu,  2 Jul 2026 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-pf: link RQ page pools to netdev for
 Netlink stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298580564.1558982.16502683619127005176.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 09:50:05 +0000
References: <20260630013814.3657831-1-rkannoth@marvell.com>
In-Reply-To: <20260630013814.3657831-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 07:08:14 +0530 you wrote:
> page_pool_create() only registers pools with the netdev Netlink
> interface when pp_params.netdev is set. Set netdev in page pool
> params.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c       | 1 +
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] octeontx2-pf: link RQ page pools to netdev for Netlink stats
    https://git.kernel.org/netdev/net-next/c/49c5ad3cd518

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


