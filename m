Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5514E1DA57;
	Wed,  9 Sep 2026 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912067; cv=none; b=HJEO2J5gjYwRlenoX2ZCcQ+AoyWP2QyCr9GHbRb5G1rOZo0r+VhYAnyqEPn0vLEa1qg46E7egyZxGfbh9kRcpNxxjvcf8lnFznLqzyHAxsnFkzbNC9KtFbQLGu7jyYLwu9KNNz247ePRAlSJHo3JBuqcW37KnbCmLnE+WHZmh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912067; c=relaxed/simple;
	bh=HwY5YhcFBdtLoVKno9zLvoqbbLnoNw6zYKyxZtGZd8o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VQtrb5h2IQr62v1SZi1w51wD0JXvdwJn/9f2q/oxvAGhGuqIJbYYXQzEbqYGWEox87k59bK8adhBuEibJgg3d1zbnhBOmEOw03tmMzI2/kbKs18mRyBqJ7MS84slpIAVvs2a6Fxrq6op0yby1qi4csYtVs+cqvC/0d3lGfp9GNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5kJ9674; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5kJ9674"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8F21F00A3A;
	Wed,  9 Sep 2026 00:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912065;
	bh=SKyRPMGxBhZU9sMrN+qGSV4EIXXEDHgkSTG5S4UPUuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=K5kJ9674uURCrsuhlpa6HvhkM3ayuWCgOwmrbgTY9eJoWyqhT9ODkEihqZ9yAVJ1i
	 1RSYFdpY714ai9c3R0DEcp2f7bVpUeHLSB1B9hQKyFKCPdYsi0OftPOJqkrzIPwEXa
	 rF8KDKo1aibdPeMQsCXgB6457xSDSaSyvDwwvIAa7TETCZMfTzG3j+nxTthu0I8pX7
	 UhWDsxYsqVsiPDxvv4ubYD8i0SMOSL3N8obD53Jo1Yd43aJ2CVBuJKCfS+CxgKCeh0
	 YxZjW410Dst31wMWAvVVy81Db8oTzVb5AnWQGONPudyWfHXfo7SbmAXz47xNruj8mm
	 +4DLWkL9L8HVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 624A9380820D;
	Wed,  9 Sep 2026 00:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net] net: ll_temac: Return actual error from
 of_get_mac_address()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891200414.71040.17612268760920600379.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 00:00:04 +0000
References: <20260903213241.1040204-1-rosenp@gmail.com>
In-Reply-To: <20260903213241.1040204-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 14:32:41 -0700 you wrote:
> When of_get_mac_address() fails, return the actual error code (rc)
> instead of the hardcoded -ENODEV. This preserves the original error
> information, which may be more specific (e.g., -EINVAL, -EPROBE_DEFER)
> and helps callers handle the failure appropriately.
> 
> Use dev_err_probe() to avoid printing an extra error message in case of
> -EPROBE_DEFER.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,net] net: ll_temac: Return actual error from of_get_mac_address()
    https://git.kernel.org/netdev/net-next/c/3d80284b244e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


