Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C60364927;
	Thu, 23 Jul 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800240; cv=none; b=VHI4IAm3gDdbf4ofanHZhS6un8zBFgmya30mle2phLM2KQmyQtLZ25Xk198EavQefkxbeUu8RgtwWu7FNgu6VhaSl1tGMalH4UBK39px+yJ1igDt+Zzvhy+GClXrz3cAni7OAsBOGeBhMDn6HvH46GeSt/2nn4c9bte6C1DKJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800240; c=relaxed/simple;
	bh=mannfsBhN/2zLuYCmB+VIxR499ywxmYZaaHU9OzJGWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hgqzusof7x0otvDaSaO9DXDmkZRfw/cRT7Vt5SmCK2pscp8S+rHsEw1EjFdKM4/tcGdaZj9Jp25sKo+4Am+L1P12pIqZqn5hGxKMWUxTnPNVanwodBey7qF0lKZY96gmWir3Te/V6EVdhvkZwgs3sbITav3igGARfg9svRP4VvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVc5oopb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVc5oopb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08C41F000E9;
	Thu, 23 Jul 2026 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784800238;
	bh=4K0rXGJhsM1RNTMyBffXpd79KeWMXbNzYjXoOLklgMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QVc5oopbFzQoU4VNnuBV3RxccRLf7p8yVSCGTm0eroun6bAIO3QpDwxy+l9odoLN3
	 +ESX40o7i4atV7b1MxBdcDcYwv8Ylwz5wfKoZNNyZDzQSZQIRbrKqtDSXwQB2aWvmA
	 CsPnTDoHsRaKrY8zRVShTIe7gbYSrDin1cVPbTclLWU7NZb9i2Lwvnnzj5ZzEQDwEE
	 AB8gtDwaWPzxmUhfJcOXDRB5v15jF57EjWIJccu6F74rgVh6XQyvD2nymVG+1GXJy6
	 c6yqznnpisMt/hrrOVQZN12vY4JemnD2Ci0fvctmiMEGIpP0jyozm4l0Bsnp9lU0i9
	 j8lwS4kiLgjpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B5380DBFA;
	Thu, 23 Jul 2026 09:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] tipc: fix u16 MTU truncation in media and bearer
 MTU
  validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178480020690.2219860.17170230635573024329.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 09:50:06 +0000
References: <20260714041541.307702-1-blbllhy@gmail.com>
In-Reply-To: <20260714041541.307702-1-blbllhy@gmail.com>
To: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, vadim.fedorenko@linux.dev,
 tung.quang.nguyen@est.tech, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 14 Jul 2026 00:15:41 -0400 you wrote:
> Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied
> MTU values but only enforce a minimum bound, not a maximum. When a user
> sets the MTU to a value exceeding U16_MAX (65535), it passes validation
> but is silently truncated when assigned to u16 fields l->mtu and
> l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
> truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
> which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
> values (e.g. 65537-131071) produce small incorrect MTU values, resulting
> in link malfunction behaviors.
> 
> [...]

Here is the summary with links:
  - [net,v5] tipc: fix u16 MTU truncation in media and bearer MTU validation
    https://git.kernel.org/netdev/net/c/9f29cd8a8e79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


