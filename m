Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791009;
	b=Z3CP+6Ba7fifQSmhs2VMNoCqk6XJXCymcSjA00HnY2ejUvdV7kTiXQMXj03Yi9G99L/q
	 7eu8zOR6UD6rYBSsb6Hlev9q7MdV8VaZ7rxsgLRRAdzWg0QSk408/WDlaKsKYQlSP2zGE
	 qtbcn/W6mCVEgWuoiVozG9GCh2w4ec8fbg0aLjMHZ1AuXOzkzpDR/hmohTGRZbmHAaVrE
	 nTEC+Zm2+JZjVB2JdSFnxSVd6gx2VeGJNi+eLpzkygZye7D8NGP/iliF3XkQSsING50Dc
	 JD4AfQBw86yMNJBwwwVBqstHKqGHWjsTNVLBKTVyxGJQwLPhcyoXcbXVQmzrCZPjemw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FCCNnkSFJzCUFxVHVBz0sLlLXrsTUod3JwOo/W9q0lM=;
	b=3qTHOFNVYlF5S98PFBb3b+7T1EyhE8qJmgD46HBf0kOIKy7yuJsV1cOVvvFiVrf89cq0
	 /E9Lf4XwFJNkWFYqRvPeZlUI0Y7QknW54g6WNcrWPFqUWi5Azm3ktWEaiYU1iuW+gSVi7
	 E0Jta7TNZqkx3WZ/TfhSYlO+pow7RFZMyxVewdCGe59SaZL+InmIaO9e56ePLEQZ78epO
	 uy1uIl8ODSsXR0mn9rfpt2oFYeWfLPCKkFfx/Jya1ewgQA+aHBz1UURaoEELHulCSHUEJ
	 EvtY8Yjh97bppjOJvVg4+UV8JnszG3f5glSdSL+DgBWyO7HCK1l006G5xjD0AYHtglQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EokFwy9j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B52606A328;
	Fri, 23 Oct 2026 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EokFwy9j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD721F01825;
	Fri, 23 Oct 2026 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792791008;
	bh=FCCNnkSFJzCUFxVHVBz0sLlLXrsTUod3JwOo/W9q0lM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EokFwy9jJWUxHj67PG35vdZYmXAmnyqKw2qFViffB8hnyOUUTAl28lgZST44nskCm
	 XxgvUZVEMp9Sls9IGcSLIcLSEuEIzzhRsx/hitXxqoYFPLaPgomOmDhPanHyjdBAJ4
	 EURKc+W1RYb5AwsUsooWuvfGLZKL0qsLl7fwU24XO7fc5wQ+YE9ujjrY0WdW0zajTW
	 gcU/kPTFhypbe74JPqvKFwue3OWgLwh6lrvOXiXYfMnudQCG497dEEtE49EtUx3qrT
	 RfV9WxaTHWQBtYmuueWCRy+xCOPwRjc8ZuHcd7j1HxycZZ64+zpBQsY7mqE7EB1SzH
	 qiiGOPGYtNUlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 813F6391B157;
	Fri, 23 Oct 2026 21:30:08 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: usb: aqc111: fix set_mac_address return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179279100707.1280672.5074637732696737518.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:30:07 +0000
References: <20261016124858.1939743-1-hanson.wang@ugreen.com>
In-Reply-To: <20261016124858.1939743-1-hanson.wang@ugreen.com>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, oneukum@suse.com,
 kuba@kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 20:48:58 +0800 you wrote:
> aqc111_set_mac_addr() returns the result of aqc111_write_cmd() on
> success. That function wraps usb_control_msg(), which returns the
> number of bytes transferred (6 for ETH_ALEN) rather than zero.
> 
> Callers such as netif_set_mac_address() and bonding treat any
> non-zero return value as failure when setting the MAC address.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: aqc111: fix set_mac_address return value
    https://git.kernel.org/netdev/net/c/c3a1ddd5e116

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


