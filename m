Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0D385D9F;
	Mon, 24 Aug 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596867; cv=none; b=YhaMuC5/T5V0OunuKwEl81xLIPGiJAKM6Vz8RBJeVOcyM476+Moh2/FH+2NdxWQkE3M11wuCd/BSPQypdXMen30M+lrx5IpQljqhH0EpP5DSXhQB9lBTC0gVZvocckqtkinW87HhRFZRiLpx7U56tbfyBjYxUs9WbG8yNq1jgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596867; c=relaxed/simple;
	bh=p4uppfEPcEb1LK4JxkzadlPcpupKjTRHqLj/YYh+f9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GRKZw/T4bHtfW0Zn6Z4/F5whe13eAgtVExQiLSxrSDpIYCOCG86fS+N48OpLMi5HARRffhuVNGCa2NyxhUOMgHOyCUNMXG3nrpi3ZSy+m/dx7dUpJPmbiZJQAXbYIK2kZ/YWD9hmx/v1eYo9vCfLHlL8nCXm7SRBjmpgMofpSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZMD7Kdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZMD7Kdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D231F000E9;
	Mon, 24 Aug 2026 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787596866;
	bh=z/LG2deLzxzHcDYCUhyfFYeuLmcr7OVJPDKNuo1iELM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HZMD7KdjOf576spEhCgCV0k/ha3gT5+GfLXdmRvLSdENfvENILf3OxM3xNiLl1fUR
	 WM0mL6n1fWTO9haMFcY8hRpL5PJjUuUP1zquSdYngvh7cKI7MZvpYkCo+yjAEir+YV
	 YUcsMvtU/lwFmgVl2EJNzxJrOHZZ+efEe3uT7D2yKFuJGTMD2Vu9ONrfh/9bDEFTmd
	 VYWfC7CV5VFDJtv/TADtoBb9fcmbhRyhuEMHOiLFdEQokG3RVamIQfNZ1epXnSazpJ
	 xfevaPNXDVi+QWSg05T4Q8jrEu03ySluxw9DQYQ68NKrS3WNW4eDrmMJeR9CEUi8A5
	 YfZCrzXw29BXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199603924A4C;
	Mon, 24 Aug 2026 18:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-vf: fix workqueue and netdev race in
 probe/remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759681363.3058449.10090275770353172716.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:40:13 +0000
References: <20260820083634.1641740-1-nshettyj@marvell.com>
In-Reply-To: <20260820083634.1641740-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, agaur@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com, Sunil.Goutham@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 14:06:34 +0530 you wrote:
> From: Anshumali Gaur <agaur@marvell.com>
> 
> Initialize the VF workqueue before register_netdev() so ndo_set_rx_mode
> does not queue work on a NULL workqueue. Unregister the netdev before
> destroying the workqueue, and add proper probe error cleanup.
> 
> Fixes: cbc100aa2205 ("octeontx2-nicvf: add ndo_set_rx_mode support for multicast & promisc")
> Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-vf: fix workqueue and netdev race in probe/remove
    https://git.kernel.org/netdev/net/c/3ba97ff4f873

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


