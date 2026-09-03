Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953583EDAA2;
	Thu,  3 Sep 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433266; cv=none; b=ArK92mWK7D6/NFv/8oZ3TXIBFHbaHcbo3qAI8yE7wgANcJRBMiNV6VdcEGmS2CapZdPLQbiPS5Jdfs7YsM9jCH9oXY91IoWwLC4DNED2+m4NrSGtGlk5wa3/VVN9+i93NjOxwcROfv+I7AVh9xa5sjJoRszV5uOEUWhh2nk/hX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433266; c=relaxed/simple;
	bh=AGyUYNUHBKHGxJr/sstyqj7xluipSKaOrFS0r5RfYek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ag0yWgMd1tcuKCFI5An9xpHMHUQoeDz+hV/tmKA4/YdDOad4T+7T9prFrwt6TF60G+4tfkbyU/6X2D+TqDKm6ncbllft7XFD1cAFwVleT98qHzWUbyU6Y4pVMCsQcDgwPHT1BWFEYbKPJw0XbFAbQ+bdA5EWeVKSrrA7yoXfNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUl3RCLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUl3RCLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A531F00A3E;
	Thu,  3 Sep 2026 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788433265;
	bh=DDHlJqEKaqRuTfW37YQeH1lxNgpmAiYAdBL43/Gnihs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PUl3RCLKWrzzLmhc/Ey0wuZONK3yi+FOCrBIQI8aVKcxcP9C4h7a+st/mB4fA+Myf
	 llsPbsPJmnqep/5NAusNJ0ZLmpswxmLkkAILfjPKTRCTsDBRF6h6qhTY90EsQOGGw1
	 IbrGdOYF/BJIyJhyP6VsQocZKAysfR2cV+PriZ6N7xj864fTHBg7V+6bioZr2vYkbA
	 thVLCB8hsggabKlNDuG2G0t1iafAyoIiQkvGWfjvDqMnMZDuBjFEux46Am4Oo4h2sg
	 BB0pdBTGVTa7S5F8veSs5/Vj8Rx7pip88vSeOCzWym5Qk5QTzI2yJ/iDyfrsW3h26C
	 n30lCl1GmgWTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09A63811968;
	Thu,  3 Sep 2026 11:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeon_ep: remove redundant memset in
 octep_setup_pfvf_mbox()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178843320639.3272461.3645695587995529877.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 11:00:06 +0000
References: <20260901110913.977745-1-ekffu200098@gmail.com>
In-Reply-To: <20260901110913.977745-1-ekffu200098@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: vburru@marvell.com, sedara@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Sep 2026 20:09:11 +0900 you wrote:
> vzalloc() returns zeroed memory, so the memset after the allocation is
> redundant.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeon_ep: remove redundant memset in octep_setup_pfvf_mbox()
    https://git.kernel.org/netdev/net-next/c/b35d3d2fae30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


