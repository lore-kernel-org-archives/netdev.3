Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D83859E2;
	Mon, 24 Aug 2026 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596866; cv=none; b=PUSMAMUbXsbLU1MHK7g2SIFNfoFviLdrUi8EsDEREYzhNLlpJ6jZMoKInD0yCXeuX8C1Y1dX9hYOcrxNpcoXQygZgIMcY0fvfx6I5FIAh8ozzUALIQFlPpBNQAPxXKT/5Us9GhehD2P+jOyWIlxQW9jECX/2iI2JuTy5U+SppV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596866; c=relaxed/simple;
	bh=pNN8+q9bkCCV58EUYztS51q0wHNAkfidSqJN7VFZuFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AW7ow56acEF1E0AQ8pmGCjaFhhtMFzH94FuvbMq2gWwJvpnO1VXjWC5G9Qdqlcdu2jaN0oJheCjWHRya4rPcL/rZANIkZAxBTcybTCM8QVG5svAmSZwxwz9xK5yecjsfbJcjB39D72DeA+qU03oP9jzFXB5TQ8pCillyXKNfDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaSkgzaY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaSkgzaY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A1E1F00A3A;
	Mon, 24 Aug 2026 18:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787596864;
	bh=w/l92Qfyq45Bt+qkShdsJGQNeGVVqgaGFNcc5zv88e4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NaSkgzaYzzzxG5eRVoT0tkn5Uj8JpOzOYf5jIPxs+eNaCq9KmLD7de/Ul9/lgA4Ke
	 P4gpeeddv0wecYc8xatcDA+LPySUccBltQyD+MY6CJ+QTrlkeTWTuF/gD8hLa8JhTH
	 dnLcmxU3JIcBsIGJSLiKE6w35tHV+PiqllySBzQuCPAU6bh8VLyLRFzbl0SPBjjfaa
	 rK6hYfo3LwN/jqYa737hi4sHEOGWEl8wKTVzzGZ28Gy2gsx2QwH+gjDljaqehExKEz
	 nF8MY/t0WJx+/tc2pDCfLkI9rCBBejMhFijYDZuP/jICMNmIn+ZoTKol5N6dJTvVPb
	 nZ3NYx/rTxiCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1B3924A4C;
	Mon, 24 Aug 2026 18:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gtp: add synchronize_net() in gtp_newlink() error
 path
 to prevent use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178759681238.3058449.7011693802224058467.git-patchwork-notify@kernel.org>
Date: Mon, 24 Aug 2026 18:40:12 +0000
References: <20260820020735.59474-1-blbllhy@gmail.com>
In-Reply-To: <20260820020735.59474-1-blbllhy@gmail.com>
To: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 xmei5@asu.edu, tgopinath@linux.microsoft.com, kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Aug 2026 22:07:35 -0400 you wrote:
> gtp_newlink()'s error path frees tid_hash and addr_hash without
> waiting for an RCU grace period after clearing sk_user_data. A
> concurrent gtp_encap_recv() in softirq may still hold the gtp_dev
> pointer obtained via rcu_dereference_sk_user_data() and access the
> freed memory.
> 
>   BUG: KASAN: slab-use-after-free in gtp0_pdp_find+0x1f6/0x200 (gtp.c:152)
>   Call Trace:
>    <IRQ>
>    gtp0_pdp_find+0x1f6/0x200
>    gtp_encap_recv+0x527/0x24b0
>    udp_queue_rcv_one_skb+0x75f/0xc10
> 
> [...]

Here is the summary with links:
  - [net,v2] gtp: add synchronize_net() in gtp_newlink() error path to prevent use-after-free
    https://git.kernel.org/netdev/net/c/d989e22ae980

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


