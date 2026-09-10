Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F152AD00;
	Thu, 10 Sep 2026 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003269; cv=none; b=rh+8Idi4u1aP1lLLVzq4X38QtHcylUhF7EelI+o8XMMBJrkH7LtghDBCuZMGp6t+kQSmmttRKps2jcqNg/p1snZTIa14KZkxq7MzDP3a81xJMhLAcd6Dl1wjEtjh3xU8rSZebc5MKcOEWCxCFnlG6Nd8mtfWBQazyeiE9fGyeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003269; c=relaxed/simple;
	bh=fTNFCJHJ005IVViAtFbt6/wjKMEGLqu7MimvVKqnDd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JrcRcbk+5CLONEJNw5tJYtyGX2HLhqNcJ3+RuoVRanE+i5ES4ORGGTI0xeAgnMxrMcOBknjwNJ8y29kI2GvSSP+hMDttbqWOxd24cEjDx5FH2j2VmezUixPKHSmOjMDyUGEZ1aWkf/5nY9mtSPHXkQYdpxwWmzG+SrCDVkkM+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2mWXrdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2mWXrdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D71F000FF;
	Thu, 10 Sep 2026 01:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003268;
	bh=gA//XVNxKMtUxSjuACKjsKnBUyfJNOVkYonAmw4lJ5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B2mWXrdGNK7cxvO0sZdk94ypPgP+umENFbS03qUsucGxtbTwwX6p3HF9bz9P/e66Z
	 jSni6NerkAXQk65W8YJxhQxoE/xo304wyxXEaWs77Mjwr56hfr2UZBjxnNHycPCkY0
	 iBvmVFjBaYNhN9QRX+Y9SqWiT4iHt9piMKITrAh0Kxv8UiJiB9HzsMtbI+JGp6MbVM
	 6rl+FhCEOgmrew7N/dInekR0HCd2ddYi9/zXtZU1ZkLKEBFEYjypms6qq466SYBYgH
	 DKz+NW6/ubN6KAnXGabbvcaYPSaNN4iDW0ZlP1FoNMrSj5Ls5xCHbGB68hpmfkswM1
	 RMgNcULbEsVxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5696B380CEC7;
	Thu, 10 Sep 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] netconsole: validate a target's IP
 address
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900320613.1138663.10012488255670628985.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:20:06 +0000
References: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
In-Reply-To: <20260903-netcons_ipv6-v4-0-bdd183c844d3@gmail.com>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: leitao@debian.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 03 Sep 2026 17:25:59 +0100 you wrote:
> This series adds two validations to the target configuration when the
> user tries to enable it: first whether remote_ip was set, and second
> whether local_ip and remote_ip address families match. Refuse to enable
> the target if any of those validations fail.
> 
> These validations are already done for the target passed on the
> command-line, so this aligns dynamic targets with the command-line
> behavior.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] netconsole: add an address family to struct inet_addr
    https://git.kernel.org/netdev/net-next/c/f6e96d72f64a
  - [net-next,v4,2/7] netconsole: use the address family instead of the ipv6 flag
    https://git.kernel.org/netdev/net-next/c/46b3f9e7e761
  - [net-next,v4,3/7] netconsole: reject enabling a target with no remote IP address
    https://git.kernel.org/netdev/net-next/c/2e949954908b
  - [net-next,v4,4/7] netconsole: reject a target mixing IPv4 and IPv6 addresses
    https://git.kernel.org/netdev/net-next/c/32535a1ea962
  - [net-next,v4,5/7] netconsole: show empty string for an unset IP address
    https://git.kernel.org/netdev/net-next/c/56ddc8d48e75
  - [net-next,v4,6/7] netconsole: move struct inet_addr into netconsole.c
    https://git.kernel.org/netdev/net-next/c/7be9bfb7689e
  - [net-next,v4,7/7] docs: netconsole: document local_ip auto-selection
    https://git.kernel.org/netdev/net-next/c/a4b9392ef046

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


