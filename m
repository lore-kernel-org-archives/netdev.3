Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A994183D4;
	Wed, 10 Jun 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106013; cv=none; b=LtnZwnu4yK2UGTJ8/t8Dw6wlxtsadMcLmy2Okl5oQnG0zx6yAwep77RjiO4uTueRnz008fsli8i3Lvjbk0OtW/U/LC0vtLFLvYwePNp37B41V4VdrFfYyUoPMqbx7/tUTYDs7SSp0UGWLmX3e7Z/7t1ib6r78iK5ylyErzzQdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106013; c=relaxed/simple;
	bh=g11rXWo764w7w2UnaSP4Mz0lA1sUdipOEZlDKPSqHF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=syJQtYWt1mDvBQeXGS0XRWlmqzoZRBpf9Tvbzn1K3o97eKnyoakT/mpFlswRDAWpInkmldgDsDfedjV0bRCuEVu7DZYbnADSBYwTG6jabnWcqTt8J+rTCt7U1Cor0ubgesl2fjIDv4s5AQLKJc08ErBTXoW6c0yErVEUwONTuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFd6dNeT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFd6dNeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B201F00899;
	Wed, 10 Jun 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781106012;
	bh=Ipi4H9dzi+Qs6ZDuhDxegFVgWSl8sNIvuN8B8FuopVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dFd6dNeTk8aS6NNKHMa58attu0SncQq8gmLQb+ELFjKomXLhIqjEBpHAgTMWWDAC5
	 ktyLh3R4QlgzghlTgz9rV3x94fg5m9xxv9XMFpj4+KJiH9Y7xC6yd645fe1I7bM4EN
	 3vq72cgGBcRnnLoUc5VmRov1LNQoyodgOD2uDtfcXD9OaMr8TPasIhPput6sWi/nmb
	 u6P+DRP7wNIwR2xmyWiaCxRDxR6NXEXOuODRcX0ii92f2l8herZrJeo1+jdncipp3W
	 513n0vql4gRi7BHLP/Zw1c6mw8U9Azwq1BHlMourdyMO/DQj01PYJJxeBr+z5vjPyJ
	 zkEMthVnC82hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938EE3930D7A;
	Wed, 10 Jun 2026 15:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: dsa: yt921x: Add ACL support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110601014.3101197.15607035605580497941.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:40:10 +0000
References: <20260606130011.307812-1-mmyangfl@gmail.com>
In-Reply-To: <20260606130011.307812-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 21:00:05 +0800 you wrote:
> v5: https://lore.kernel.org/r/20260602083755.79411-1-mmyangfl@gmail.com
>   - validate tcp flags
>   - fix TRAP action
>   - unconditionally discard rule on deletion
>   - trap traffic when hardware meters are exhausted
>   - avoid devm_*
> v4: https://lore.kernel.org/r/20260528193726.1893365-1-mmyangfl@gmail.com
>   - make use of software fallback
>   - guard duplicate POLICE and PRIORITY
> v3: https://lore.kernel.org/r/20260523020704.503966-1-mmyangfl@gmail.com
>   - handle ACL tag code
>   - fix the upper bound for FLOW_DISSECTOR_KEY_PORTS_RANGE
>   - extack messages when possible
>   - check the redirect target for FLOW_ACTION_REDIRECT
>   - fix candidates overrun
>   - fix the activation order for rule and action
> v2: https://lore.kernel.org/r/20260520022242.120640-1-mmyangfl@gmail.com
>   - v1 was mistakenly sent as v2
> v1: https://lore.kernel.org/r/20260514192140.3468543-1-mmyangfl@gmail.com
>   - fix issue reported by test robot
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: dsa: tag_yt921x: handle ACL tag code
    https://git.kernel.org/netdev/net-next/c/cf14ed49802e
  - [net-next,v6,2/2] net: dsa: yt921x: Add ACL support
    https://git.kernel.org/netdev/net-next/c/8eb9e7520b17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


