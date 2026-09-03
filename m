Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D1305693;
	Thu,  3 Sep 2026 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406274; cv=none; b=RrZepkKzOsDOB7aInB4S84du0tZ4+QLKn9m2ZRnq7qVPq0Z8TKhYa2+ujl76OEgdHgki3IximUDAv98l8qn5LonDtJl4Rtywp166ASU3eNMiD4pAH0FanQ4FWRzi0QWnHTUc16MfY9YnLYJzrB2kOJpi1nc7XozgG05OiU8cXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406274; c=relaxed/simple;
	bh=Ya3PcIfbrCKZPqwxMjzvPSvOUKEktdy/4yOrCRSvo2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FUrowp9NFeZbDLdUsFRc0uQ9MZ3cmEw9zPYYcKFe9HayZG9IO2cVzsBnqRH2agbHaGJt/nm4WtRQs0oe3EQaBZewJ7YeQ/9DEjKOWfmNr4/z2m9nQNFNvFeeTLeD8GMWYfOr4CSdjzehrZn+WgZtoVxGd0yv580kfe5XEQNUJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJStVjH9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJStVjH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFEF1F000E9;
	Thu,  3 Sep 2026 03:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788406272;
	bh=15D7ziCqyOLDogPczVEc95HI709Ep4DKrGi2eP/m4eI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AJStVjH9/z7F8Meeek8k4DaXWLWyl2/B3AXacmT2xxF+vdyF1jvuw7Qy5GPFaiizJ
	 YGzACivA/a491pu0xcr+RuEK8QjeKrQyWz1tf/meWyuv6duLhuWFXVuM/FKcL/ccvR
	 4H/lVp6Q2lu9eiuLGFKTsBL6x+UVYhElphKQaX7amR92e9jmiKdvuU3EKKppYDnCMF
	 +RSz1uhpY4coE0Ixxi0GlMdxzXum1jGy7xGhcHRL7s+4B71gPzTJZJjqVKWPCgCpm9
	 J2Q1QcOd+YGaG3bf81SB6ZZ8YhriD08bdMtSvwr2hJj88J5v/+UbZwCuFEKgFsSytC
	 MKxpI/NJA/nKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C0D392705C;
	Thu,  3 Sep 2026 03:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 0/5] net: dsa: motorcomm: Add LED support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178840621439.3072235.8474333977107368724.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 03:30:14 +0000
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
In-Reply-To: <20260831044818.4103477-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 12:38:53 +0800 you wrote:
> LEDs can be described in the device tree using the standard LED node
> notation. Currently, only parallel mode and strict 1:1 mapping (i.e. the
> HW default) are supported.
> 
> v10: https://lore.kernel.org/r/20260816193905.218112-1-mmyangfl@gmail.com
>   - new patch to fix lock status check
>   - LED control block redesigned
> v9: https://lore.kernel.org/r/20260726162731.1005803-1-mmyangfl@gmail.com
>   - LED initialization sequence adjusted
>   - add DT description
> v8: https://lore.kernel.org/r/20260725045008.858692-1-mmyangfl@gmail.com
>   - limit the led port number
> v7: https://lore.kernel.org/r/20260723195335.806002-1-mmyangfl@gmail.com
>   - rebase
> v6: https://lore.kernel.org/r/20260709014812.1158178-1-mmyangfl@gmail.com
>   - per-port initialization support
> v5: https://lore.kernel.org/r/20260707064752.1030345-1-mmyangfl@gmail.com
>   - improve trigger selection
> v4: https://lore.kernel.org/r/20260703165241.542195-1-mmyangfl@gmail.com
>   - fix some reg op typos
> v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
>   - fix null pointer dereference
>   - support polarity auto-configuration
> v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
>   - allocate LED structures only
>   - eliminate double locking
> v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
>   - set up polarity correctly
>   - do not set up .brightness_get() to prevent dead lo
> 
> [...]

Here is the summary with links:
  - [net-next,v11,1/5] net: dsa: yt921x: Check lock status with lockdep_assert_held_once()
    https://git.kernel.org/netdev/net-next/c/b1950d0426aa
  - [net-next,v11,2/5] net: dsa: motorcomm: Move to subdirectory
    https://git.kernel.org/netdev/net-next/c/9c472a0d7c38
  - [net-next,v11,3/5] net: dsa: motorcomm: Split SMI module
    https://git.kernel.org/netdev/net-next/c/e9423a64d382
  - [net-next,v11,4/5] net: dsa: motorcomm: Add LED support
    https://git.kernel.org/netdev/net-next/c/9af9a8168213
  - [net-next,v11,5/5] dt-bindings: net: dsa: yt921x: Add LEDs definition example
    https://git.kernel.org/netdev/net-next/c/5f28f63c5d19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


