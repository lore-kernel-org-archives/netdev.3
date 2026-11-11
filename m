Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437412;
	b=3hALB1af4Qz/5uJ9hcv6QFIlizzXFGDzIgNL4hJzNv5CbTJqSXGC/KCodERfzAZidFLK
	 MH2YMTUFy4rRgXBtE6Y/KkR9J1myzi4l55FPv+mnaPsSJEUtffh9MF/RJ5oTyEFdI2sg8
	 3ngcE46RCvPUQVnnDzoOkBLDjmvVctLSQb6b9PN4kZBpeeUfE54Z1ziiwnpvaMd7nYXl3
	 KbxBFRTVbzIk6t5t2J2FdRe0HDyVerLLvpje5ONeOf6TqyRHwLd+wfv94E0ZfxnZBveWj
	 TXObixrz3E/sbXPsGddF+xa5oH+gb22zz9ijvpd6bkSSHx91RmC95ZaOfectDpNg0LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=nvydp4Q/QgwNXiJN83lOmNasAJMP0gCNtLvZMibASWI=;
	b=lAOk5MdMYoCd6abkcTC8ixAvH8jBwu8u4FgzLVKmUN57FtU7GlbpFSxACqc3EVmo70XR
	 JRCkUy7O71BGRqTj3KIqEfztDNm8XbvYvXHzof+/QLQlHG2FqM9ryUl8tmfnRFF5QZO7b
	 Gw/7JGoSGOVuYW4KPsP/729PUoAgqlo467tAno/1VpdxcRmsiu6XVl7iZuhANJMCcajyf
	 qhwhqfPluhKp97cEp2NpPa0lztrehaem1+ih5L+H2YerX1c6TR/ERPuT8+a1/70LI6YUB
	 hjhP16Z96cBqOWNfQr8knnLJy4zgN3LhZ8b13sX5S7VGOrW1SYEdypEdEzuMhm1NQgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QKp/6irh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A474606A89C;
	Wed, 11 Nov 2026 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QKp/6irh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D72F1F00A05;
	Wed, 11 Nov 2026 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437412;
	bh=nvydp4Q/QgwNXiJN83lOmNasAJMP0gCNtLvZMibASWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QKp/6irhs8y7INTGeefhD5IN0JdEi86b9Jjpz756MKSPvRR4LxCm2kFupPmWyd8EQ
	 FjjE5uJGZ1vX+KfM3XV7jNx8xyq5sAyN1juhWal2oZBcnE7NBqX7qeWs114bzyqvnd
	 //+9Iruwtcvz8E8C4ruUu+G5elNwp1S8eC9pQwOrjhW3jZAW3mOYFbvY6qlKk7UMN4
	 C3UFEPOGAIA9oN6DFFoTiB2py4SznYwYP90xvtm6TAPf7VtsLsXcxYITCZ+J4mRU8m
	 Fz3Fw5koGvivtSCfGxLserXEmtLUpdPKc0XgqJvZZaiHVEewV6BpuSDdnGQPZuyDzL
	 8UeOBCvMOeLoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FAF391AFC6;
	Wed, 11 Nov 2026 22:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: motorcomm: Reread port flags on bridge
 joining
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179443741067.1688116.14171083860500865899.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 22:50:10 +0000
References: <20261108210357.1633411-1-mmyangfl@gmail.com>
In-Reply-To: <20261108210357.1633411-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 05:03:54 +0800 you wrote:
> DSA replays neither BR_ISOLATED nor BR_HAIRPIN_MODE on join (e.g. a LAG
> member rejoining its bond), so the cached flags survive into the next
> bridge join and program stale hairpin and port isolation state. Sync
> them from the bridge port.
> 
> Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: motorcomm: Reread port flags on bridge joining
    https://git.kernel.org/netdev/net/c/7aadc87adbb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


