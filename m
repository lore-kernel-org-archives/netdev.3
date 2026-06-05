Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954543B4EBB
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622423; cv=none; b=E/wRFqlHZX3o22BHyzicBul/NWR5UuHmjbG9ljHyxRD3BhDL3fZILahOuoUcxPyhuYKCOBNQTtN3htkemAHt6AWetuYGIizjpR/Bi4j/rXuYxBj7mG1cPRSr6m0bca+AUV0qvJQPAar/ZL33B5D0SXizwprkxaJrrTox21YMmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622423; c=relaxed/simple;
	bh=l/r40VBOQDnOqZgdgyKpgvvV2c7x5HBfWSjTDu+dX3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aKOfiOsThnjlSDoIjrERFqsTpBXL9OEV6fwEbVOKB1MkLMTKW4WAQM0fHKUNfQNo74etxDCaZEk99PCD7Iar3yBgt7mifDo2SpzOauVeflc0JrTWVEEAm5y6OmGamBh5W9cVP1COZZxvXdAzAiKFgPgmOyLsHcqGzmYTRrQNiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHVJ9wgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHVJ9wgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6041F0089A;
	Fri,  5 Jun 2026 01:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622417;
	bh=ekDCFzXsFkRGi0GgX/tAP2jZ+LijT86BaWK9QE9YGXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GHVJ9wgoY6Mi0gIj8tnQZ1Hl2FLY8x8UFf0KRYeR6Cek/heXF4+S5jDfWe6wHUBe+
	 POYMu8zKLrm2/R3CNYgoJjfEu3IJxry59PGdoTkVx9DwlN+6bLJ9x/Wa2LUOkug+me
	 rGsHDJd1jQ63RiJeWHhwKvCVvYQz/Z60iqZQoQ0IhjKJBT21evMw6SSVtj5dQ4C3ku
	 iVDQ8ZG1xkUZbqLlFUF2ZmCux6MxxVC0gKbIE3HOQsSCxj77LCmhXC8Vt2gxyrhIFU
	 mXydskyFMLjt2SDhnocevq3FcDQiv35aFVpSwbMF3kA37eDd0RQMDuOmiYgOR8y5L8
	 6nyAOaLH0TCLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1B3930A8A;
	Fri,  5 Jun 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bridge: mcast: Synchronously shutdown port
 multicast
 timers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062241739.3090676.1203878185997865685.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:20:17 +0000
References: <20260603103522.622411-1-idosch@nvidia.com>
In-Reply-To: <20260603103522.622411-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 razor@blackwall.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 13:35:22 +0300 you wrote:
> Currently, while four timers are set up during port multicast context
> initialization, only two are synchronously deleted when the context is
> de-initialized, just before being deleted.
> 
> This is fine because the structure containing the multicast context
> (either a bridge port or a VLAN) is only deleted after an RCU grace
> period and it will not pass as long as the timers are executing. These
> timers are also not supposed to do any work at this stage. They acquire
> the bridge multicast lock, see that the multicast context was disabled
> and exit.
> 
> [...]

Here is the summary with links:
  - [net-next] bridge: mcast: Synchronously shutdown port multicast timers
    https://git.kernel.org/netdev/net-next/c/7a188fcc18d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


