Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255B481A82;
	Thu, 24 Sep 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256166; cv=none; b=AlejZkJhWzEmWzf3qivZPWbdJosy/tnH3vABRSd5Y2Cp4UzwTHAPrJ+3sKb3GS7iRQEYuNV0L09MJE0nAvQv7v9vhdhlmWcNi+3NR77ai/VFju7NUlqQYqiu53FU8LHSK9Y9SeW4XslRMrUCg5/kDN2aPAvzphUAqtjMQaNO4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256166; c=relaxed/simple;
	bh=dkEL60393E0ZzazZywJe+lyi+Vltu1yXMdwDBDgjVxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cq6ty1ojz6NCSkYwc5ICYKWfm8b5fJDl9ULBrv/CpNp5ERz/IDf7VQ9udeUp3jkKvB1sLZzyc/VBe+HFLZCI1SE1FkzzNduwceeu0dWF1f8fJV5eI0XdsXkSJMwNdmB5eVivYkwKwR4MPs0TIGw+g8MR89/nOcFukj5AWyZkm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZfOETb2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZfOETb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A1A1F000FF;
	Thu, 24 Sep 2026 13:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256156;
	bh=SHpt2jVFN/qdekEkmimqeG5JdQHSbSzkpyGv9+E8uoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oZfOETb2gikgLRADb/1hCwIv8Sw+6KPFrA+zR/m5QqwF1CXsEm4OyrLqRrrCeoW0o
	 9K23ZF8k0QpGsb++Tuv0wG8ypJjxzXcCcOp2sbj3b9mER1w0ChpB++ELUW0nvBjGpN
	 rcppKT30mVfPcTJ5OmBC2jcsRebxt3dO6aWQ8XgvcqmYWf/moury2qeERbtmvg+sOh
	 3Lh1B8IkqejW96lKbwtaQbW2wj1TNm2d9P6OfqhuR5AJ7xmUabOXfTbQqDGRusAyM1
	 /FTxLEWUE0tTn4F9otgO6Q3+9YHID1Nht1YJnSoh03kBidHuyr7rdMce+7AFkLiDTA
	 FHH/4dGltq/hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A839F38C4;
	Thu, 24 Sep 2026 13:21:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] macsec: initialize SecY before registering the
 netdevice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179025608572.1542893.3122720267052051951.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 13:21:25 +0000
References: <20260921-fix-macsec-net-v3-1-accf94f93f5e@gmail.com>
In-Reply-To: <20260921-fix-macsec-net-v3-1-accf94f93f5e@gmail.com>
To: Haseeb Malik <haseebulhaq55@gmail.com>
Cc: sd@queasysnail.net, netdev@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, andrew+netdev@lunn.ch, hangbin.liu@linux.dev,
 pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 felix.walter@cloudandheat.com,
 syzbot+f2f6312ad1b5a0bfe316@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Sep 2026 16:40:30 -0400 you wrote:
> From: Haseeb Malik <haseebulhaq55@gmail.com>
> 
> Creating a MACsec device with MAC offload over an LRO-capable lower
> device triggers a warning in rtmsg_ifinfo_build_skb() when IPv4
> forwarding is enabled by default.
> 
> register_netdevice() invokes inetdev_init(), which disables LRO and emits
> a NETDEV_FEAT_CHANGE notification. This reaches macsec_fill_info() before
> macsec_add_dev() initializes the SecY. key_len is still zero, so
> macsec_fill_info() returns -EMSGSIZE and trips the WARN_ON in
> rtmsg_ifinfo_build_skb(), even though the skb has enough space.
> 
> [...]

Here is the summary with links:
  - [net,v3] macsec: initialize SecY before registering the netdevice
    https://git.kernel.org/netdev/net/c/c2de369c5c5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


