Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2218B47D
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276394; cv=none; b=kjKyoCvqpTwZam1C4lUxCM1qWtpDRqnyBZg6r4N0pONeeiDFDRsEyE9Y/Y+FjYF+8soXl2i6KblA5BoeUhoB/5jA/XjLAUz6RVZJrPXUrV9fsweSFdO2lku0U8Zv6buIL439h1xD8JBwaPW32fTOALJjent7HKXRZIzQiQmF0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276394; c=relaxed/simple;
	bh=A10kEuFwU0GPNg8ZAIh03cG/f2oh5tGyY4CqrzzrAiA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FfVFL9htsx0yW6jKKBPHnbETIIoKMzaDAvSfsR3mXVYofnMliJ3aXBwlG9B64A296YVUXYVKdufElVCiylJDaiwne1luZ7TwWfZMSqxuj3R7j2k7m8R6bE2yNUQGCfWj/I7tmXuv+sGYRxlGYa9VjrCFXXYJMM1S2TCA5XFKT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDN3lhMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDN3lhMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E06C4CEE9;
	Mon, 26 May 2025 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748276394;
	bh=A10kEuFwU0GPNg8ZAIh03cG/f2oh5tGyY4CqrzzrAiA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uDN3lhMb1q6NmeVQNLSx+5HMHQHqEJU00sUyy+ytlOETSMvuJ674wMko1SKxZ110Q
	 h80PVwRtdCOKuxSPydWl8jZ350F4fahX0FMDwc+NFawlHz2TR/b0hPZ6TqAj6UfV9U
	 l7GFis0EIeeU44kAiMSI/fJn3jHPmoQO0Y9QcIUfYtTFbwvW7embPKDhWvzbyzMyWj
	 6ExngEjSd/AfmtQ/apvWUPD4/ipgk62tSJF54+B+avsUtPeu/VHsj/0pRPloA7erGg
	 rm1O/G4RgLRDI0bkDwNZTMZaP1BiY0joaqoljCHTY1vEOQoqsQG8XfKUNYDZFcSwt3
	 +uDvvIwdCnRKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECA3805D8E;
	Mon, 26 May 2025 16:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v3] octeontx2-af: Send Link events one by one
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827642875.972633.11067086787935870247.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 16:20:28 +0000
References: <1747823443-404-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1747823443-404-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.swiatkowski@linux.intel.com, gakula@marvell.com, hkelam@marvell.com,
 sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
 jerinj@marvell.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 16:00:43 +0530 you wrote:
> Send link events one after another otherwise new message
> is overwriting the message which is being processed by PF.
> 
> Fixes: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> ---
> v3:
>  Modifid to wait for response at other places mcs_notify_pfvf
>  and rvu_rep_up_notify as suggested by Simon Hormon and Michal Swiatkowski.
> v2:
>  No changes. Added subject prefix net.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-af: Send Link events one by one
    https://git.kernel.org/netdev/net/c/ba5cb47b56e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


