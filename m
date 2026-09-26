Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF112750F2;
	Sat, 26 Sep 2026 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382082; cv=none; b=uEs/10Aj+0xJkzhy/y5t8V7ykql06wxne/fZkZJDRWz2Txe0/HICQ48RhSeKrwHevUtleoCuG/rYw6YgX3tKv+f+d66ZO8yc0SIj6CVZzOdMjg+bd5+c5Ozz9sZlmDTEk6+22sXrHFs2ypP9YIOSuNwkbkNah2bWR/M9vQrkG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382082; c=relaxed/simple;
	bh=4Dia/lNWtkxXs+meuKwoNzwt2RlyA/ZtSTIRA9Pr+Ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oxGAXl/t9tX3AMbTyzPJ4tLuwnpdr07UVoZa+S8gLHAZLaNH9c9MTUL413T9shmF8AibBM5GgqkKwZroClOfZnDkSXE7aUX6sw3THsQo5qBXSn7v2aCph8aA5KOq075ND2LIpnRLH4FL1FCvSIqK8Mf+5oM798Ke6huf6ZCCe14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0XJUoqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0XJUoqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E641F000FF;
	Sat, 26 Sep 2026 00:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790382080;
	bh=13uNuSjv5f/qBg9Qh+xrVuVXkYX8fPzZDY//XM8e+4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=m0XJUoqiIa2cWk5Sv9gfDWf5UMNJVR85JEDB4JkhFD1+ylvmC6tKN4bm5vWoCRYL/
	 fPhpq9ZjfQ/M2G+S12wnBk/4pH5nIf3+j6Q/gJoILDYcn8XWqajuUuZZHpWInvFVTO
	 vcdGR9NhpEdrunTvb4WoT24yvMuVPAuMkcaD+8Lv+jWP+hvY+Xe0xCXU/bs+NVb/P5
	 2asEeW0rg07JOQr+P1ye9AjDLpvrdE/9ejeqtxtI8oIGPVSptYRrsZOMzheA50NAIJ
	 n4qbd8ocfQi/F9uIvrgBwI+5P6tWFd2u+TLXIRMydV2opf6PdVG/SM8LkPr9JxekFb
	 R8FIS0CZKIexw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B2C3809A04;
	Sat, 26 Sep 2026 00:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/8] net: dsa: motorcomm: Add SerDes PCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038200814.3217464.2719386526229401334.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:20:08 +0000
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
In-Reply-To: <20260923021945.2203368-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Sep 2026 10:19:32 +0800 you wrote:
> Rework chip_info to tell SERDES ports from xMII ones, identify the port type
> at runtime from the pad configuration, and add a phylink PCS driver for the
> internal SerDes, so that the link of SERDES ports can be established through
> in-band negotiation instead of a fixed configuration.
> 
> v4:
>   - fix 1000basex
>   - YT921X_SPEED_NUM -> YT921X_SPEED_INVALID
>   - reword commit message
> v3: https://lore.kernel.org/r/20260917185010.3189199-1-mmyangfl@gmail.com
>   - fix build error
> v2: https://lore.kernel.org/r/20260916164310.3168269-1-mmyangfl@gmail.com
>   - Remove YT921X_PORT_MASK_* macros
>   - code style nits
>   - unconditionally write BMCR_ANRESTART
> v1: https://lore.kernel.org/r/20260909190541.466476-1-mmyangfl@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/8] net: dsa: motorcomm: Remove YT921X_PORT_MASK_* macros
    https://git.kernel.org/netdev/net-next/c/b6d2762919bc
  - [net-next,v4,2/8] net: dsa: motorcomm: Split xMII and SERDES port masks
    https://git.kernel.org/netdev/net-next/c/605597aff803
  - [net-next,v4,3/8] net: dsa: motorcomm: Identify port type at runtime
    https://git.kernel.org/netdev/net-next/c/07b60e1bf4a1
  - [net-next,v4,4/8] net: dsa: motorcomm: Fix register bit field names
    https://git.kernel.org/netdev/net-next/c/be5cdff08903
  - [net-next,v4,5/8] net: dsa: motorcomm: Introduce yt921x_speed
    https://git.kernel.org/netdev/net-next/c/5423f892f129
  - [net-next,v4,6/8] net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
    https://git.kernel.org/netdev/net-next/c/c9996cf718ec
  - [net-next,v4,7/8] net: dsa: motorcomm: Split MDIO bus module
    https://git.kernel.org/netdev/net-next/c/b9eca1c2be7f
  - [net-next,v4,8/8] net: dsa: motorcomm: Add SerDes PCS
    https://git.kernel.org/netdev/net-next/c/4b8fbb875a54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


