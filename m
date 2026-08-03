Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024363B3888;
	Mon,  3 Aug 2026 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793246; cv=none; b=U2g37CFvyNYzjdOYJcCVOZe/ICbtzQvl2ERm/HPlOPnJjJKMhItBJMlEmL6czZz1pJAozt13LoR/RZVQWKbyBqWj2Bo/A1dpm29TLlZLWNopOhzDev89JotHwcGLf0ZjwPSR5xxMiBMg0wdaaEYFRmECdjB8VnyaFFyH5CQnlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793246; c=relaxed/simple;
	bh=R1UJlNCXmgj6Kn83+BDs/Nv0vt5RlDaO3S8ooA8NauY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LQZf2XmOHEb+Lml5vHMbYoVfcvFB+xAZQBWLKVTRAfeF0TpmaTOe62zBnhlpbD+Wu/iyuVxRR/JqImg4eju1/fnYF/mzQmOEeuLkVWgUkAOHHlXpmjlPPo6SEgc3nDaFoe+V6F4LMOATXiWxOTJ2U/cBaQ3ogAphVHVQPEUZoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UemVQq+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UemVQq+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B41F000E9;
	Mon,  3 Aug 2026 21:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785793244;
	bh=m8uxRKGw40uuU+VS1Z63FbIVnRMi4foANmU++suDNYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UemVQq+cwcFbNpGCrFV8lRRE6WoeG8jKOKLEJC+8R9Xvzcng1iYDvOQNbduCufze8
	 5fAcTZ2JmoRTE8mdQaWSsDsGEaal3stw8FHbx60SVmJzQQqsOlH9nb7CaGNa2sW82p
	 qVSU5b2n8zyFEvujEcWVQNsusGPPdZimKNT4wg12F7zS6H/mKD8jqwB40jEqg6HL9e
	 p+MQ6CRGnd82w1x7SZP4AS4Fipxk0UlBqpufl9G7jrFMhTyw1V5EgcoTcthpowzVgO
	 nrgvuz4+KAqQ8my2IgsfK2Uww4CR4Lu4thf1gy4r14ZRl+yrfjio30SkXme6y5LWqW
	 cPdKBUAurc63Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BB3924461;
	Mon,  3 Aug 2026 21:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bnxt: fix memory leak in bnxt_queue_mem_alloc
 error
 cases
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178579320564.2843613.14322317790285758887.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 21:40:05 +0000
References: <20260729220132.1256924-1-will.chen.tty@gmail.com>
In-Reply-To: <20260729220132.1256924-1-will.chen.tty@gmail.com>
To: Will Chen <will.chen.tty@gmail.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dw@davidwei.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, joe@dama.to

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jul 2026 15:01:31 -0700 you wrote:
> There is a small memory leak in bnxt_queue_mem_alloc:
> when bnxt_alloc_rx_agg_bmap() succeeds
> but bnxt_alloc_one_tpa_info() later fails,
> the rx_agg_bmap allocated by bnxt_alloc_rx_agg_bmap()
> is not freed in the fallthrough cleanup cases.
> 
> Free the rx_agg_bmap in the err_free_rx_agg_ring case
> and initialize clone->rx_agg_bmap = NULL earlier in the function
> to allow for safe fallthrough.
> 
> [...]

Here is the summary with links:
  - [net,v2] bnxt: fix memory leak in bnxt_queue_mem_alloc error cases
    https://git.kernel.org/netdev/net/c/d1000fd7995e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


