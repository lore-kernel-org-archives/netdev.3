Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E94AB1B9;
	Wed, 30 Sep 2026 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811611; cv=none; b=tixJ5VYFOLnFzcRrk+JT1AwNv3qe9rC7SK08XDfWUeFCs83yjjtAS92MFUncaKLh9XhFOLmeLXaECdbEHHq2B2Lv6SQo9vVXhKPwWMa9E4f+BWENfbvyFqrozh5Nzk5zIdPZON1vhTyESO8rQDachlMmbly8ddvnZL7uSEzrak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811611; c=relaxed/simple;
	bh=mjlaJMgKoE3kzHb/bIJtXCMq/TnB0eLVtEPb31PZutk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKQTEhBBnM35y1vIjlGl6QngAvXI8v6dWqh/Qg+HPWrUIcrbMWCc9nzujr2UVmPHbPpO3JK+PiPWGVkFZWmumnq0cvu7mOlObcBsWTvjAJGegnGWxfVMULdzlv+IoGGEs4J877XRP1PxjY12PFVfwBk0nuM+7DsAOhP1mFKCTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXK+0apI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXK+0apI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D521F00898;
	Wed, 30 Sep 2026 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790811609;
	bh=XwqCmB2Tixc86UB3HOa2cU342DYForgNyYmRRmWqLw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AXK+0apIAt8DNsb1dPOSIaocrD4X7pcSLwfE5zLcXdeffj8aJv0W63TtlDpDlc0wU
	 DhhLKJ7bLuIaAnbvtqczpdy2VQpo1hXQ03U+qMIvmkVPs1w2AVPT1VVyBjRD3lAxjm
	 KfbxvBu0HlIkjTeAiaPVpRM62E/CvEAegddI1uJ6lvJE44gyq3Ds6CMkRsHu4r1lQS
	 E1+JfTMJIroCjZtJvZxBSwdMBf2dJ9aZ+BwGB2CWRezXYjoBv1bXqR+onbv6VmU5zQ
	 eUwesGXkH4WwGwGklzMMCnK/rF9423BldgrHXQjYVp+WKzew2HIJs9/0+nwJLwFTr0
	 AM6FKJv7HnUxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A30339EAF51;
	Wed, 30 Sep 2026 23:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: ax88172a: improve MAC address read
 error
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081160773.2175258.4228970874307586963.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 23:40:07 +0000
References: <20260928044011.63926-1-xinsheng.zhu.ny@gmail.com>
In-Reply-To: <20260928044011.63926-1-xinsheng.zhu.ny@gmail.com>
To: Xinsheng Zhu <xinsheng.zhu.ny@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 00:40:11 -0400 you wrote:
> When retrieving the MAC address, ax88172a_bind() checks the return
> value of asix_read_cmd() against ETH_ALEN to detect short reads.
> Commit c28d9a285668 ("ax88172a: fix ax88172a_unbind() failures") added
> an -EIO assignment to ensure that this failure path returns a negative
> error code, even when asix_read_cmd() returns a non-negative short-read
> length.
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: ax88172a: improve MAC address read error handling
    https://git.kernel.org/netdev/net-next/c/b38dd3a0cf1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


