Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1899635E94F;
	Tue,  4 Aug 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807658; cv=none; b=dFIdkCe38JX1YRYU86ijL7yb/9I/BsZeP2j/nhhUeXExUT1Isa4bUTc9io/2D8X6tRR4++hlncxqGqOya5WIGMX/xp6AOgkXbh+1vwbQnTH5LT4VgSbeU8PZZfZOeItsNQ5xaZWCVQO7QbRLx9mdwhcZKD1tNFOSZE2FKf0O+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807658; c=relaxed/simple;
	bh=RPDGnuBA/utVTXBha7ko4uFM/b2sLCzbs7pLi/XeYdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OoAUYSbZV4H5TkDWAYADVMdNYJJNT5vMuwBSgzznGGPh0G2B6h6YyIDdhS96ZKX/jqplkAjHlXVxW+/hl6ObodQzjxVe+bGFYqrq79P9JlDGfyNXCBviX0ReKbwZUwpqCsurAbyvTUbMoEdI8w3LrZQnNeSJeskk+qLmBieSkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxGrEo88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxGrEo88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F181F000E9;
	Tue,  4 Aug 2026 01:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785807653;
	bh=/bxBBUjsq4BjfZI7ybjLT01hZNjjFgoxQXCbo++9ejo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UxGrEo88V4eldYk9Vc0BHAoPA7vx3v1XdUfL64HT9K/eao57ZAMv8zrGi6LfKKuKe
	 lpXizd4mCWkiMZCiKK9sI/0YWIalSNt9qwLKQxFVF+OcLnuzZldKoU85oPCL1fu+Ig
	 AcfW67fiMghOBsR7dGGjsLJFumhP7tSLov3MuEvZwsunxcIhY7OQ5+27AUJ3bkWJPq
	 WHMJEy32UsWUwQQHA6QwU82GadGs7y6WpmnO41Wafq/Xuy9LRitMXyHRusWNFLsor2
	 iwaa0wNbLT+ZJdox8W/VnR8G1UZWdbP1jJXlyRNt0JlLch9Pn7LesuCJG9EpAkCaE4
	 dTzOEcknQBMkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1986C3924467;
	Tue,  4 Aug 2026 01:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] udp: fix potential use-after-free in tunnel
 segmentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178580761363.2910544.1396255785067576567.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 01:40:13 +0000
References: <20260730093554.68127-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260730093554.68127-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tom@herbertland.com,
 aduyck@mirantis.com, linux-kernel@vger.kernel.org, luoxuanqiang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 17:35:54 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> __skb_udp_tunnel_segment() gets the UDP header before ensuring the
> tunnel header is in the skb head. If the pull reallocates skb->head,
> the saved UDP header pointer is no longer valid.
> 
> Get the UDP header after the pull to avoid a potential use-after-free.
> 
> [...]

Here is the summary with links:
  - [net,v1] udp: fix potential use-after-free in tunnel segmentation
    https://git.kernel.org/netdev/net/c/d0f86fb36eb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


