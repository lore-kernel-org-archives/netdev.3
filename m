Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB406332635;
	Thu,  3 Sep 2026 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399713; cv=none; b=CBamxSHMUfAK3yRXFCIaFJu0LvsWNszXuaV3g3Wu58d0K9py5wWOYrSydJYyxVAwaROEcdTNOFiV4/2Z9OXT80cam75kPcbnfh966GpICXr6DfH1QDl4nct7Yo3b8xfA44ZdWqxz2iNhmmj0GbVSFETarLhIf/JLjOMAG7RbeSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399713; c=relaxed/simple;
	bh=gij4BSu+5C7tKvtetyKwcGQY6sRP9WVlf5eB4fvDpM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CKrXM96M4i8LKhBKsCF5JPzREvsn+vv1Uix49qnI0cNFRJp2mp2F0yzpi6zrXYROFgVtthLZpaNacDIRmH2wpAynYtF05UewnsJFJRPwVAwJW6+fXm/v6uO9BFWvcw22Xr8wztPnG7/tPi/HxyT7DNJcCa4AcoIKBYjTMXUKQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACCB1mK6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACCB1mK6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AD51F00A3A;
	Thu,  3 Sep 2026 01:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788399712;
	bh=iDA0B+B6gg6C/I+MQ7WUKkQBaYJcaYVVA6YZ2R4rew8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ACCB1mK6lGcpEcyGXb0oP39cjUFfkqjV+x9o1jBkb0/9awfyadku2dVg+BkMBTdhu
	 CcADukR25/6plvpjXx2U5xnN1Zc5zQLNqYyESNDWa1KubgJV+tp0snajhwCmmQ9zZh
	 D8W75e71yXx4x9lVzXifRS2WJEP+svN2FyuNqT4pTYgA+Z/hOolPXbrP/z4/1A3e6P
	 /G3PTO4M5pGrJxmXnoZL+QbVXb+OIvZMUr2g+lIRVg8/Q0xgjhBQSgGWO13ATi66Vf
	 T01R6N0fsHtg5pb62ctb/HcFFjdfZufy6VEomqn2cC2sQ5p7Nlb0GztT2q4+2TropX
	 FE7xgbOaLv/eQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA53927054;
	Thu,  3 Sep 2026 01:40:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netdevsim: fix panic when NETIF_F_LOOPBACK is set
 on a
 VF port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178839965389.3035212.12987260351149513581.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 01:40:53 +0000
References: <20260901061851.61734-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260901061851.61734-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 petrm@nvidia.com, willemb@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 14:18:50 +0800 you wrote:
> A netdevsim VF port cannot process incoming data.  It never runs
> nsim_queue_init(), so ns->rq is NULL, and nsim_vf_netdev_ops has no
> ->ndo_open, so its NAPI is never set up either.
> 
> nsim_setup() offers NETIF_F_LOOPBACK to both PF and VF ports.  Turning
> it on for a VF makes nsim_start_xmit() take ns itself as peer_ns and
> dereference peer_ns->rq[], which panics.
> 
> [...]

Here is the summary with links:
  - [net,v2] netdevsim: fix panic when NETIF_F_LOOPBACK is set on a VF port
    https://git.kernel.org/netdev/net-next/c/5add7c8d59fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


