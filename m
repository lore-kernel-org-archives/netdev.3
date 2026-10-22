Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792629027;
	b=VnaOjEzo7321Wk40+KlG+Uzv3TaV+dQiVh9jbN+Zb8+xTHqrwVVrLAcobdlr+Ekdr8HM
	 +Cac4nCn4a4xRlgApdSRj0Jthhg5eXX4ruZ8Wvlt2adNJKVjaP816bXs7eWVUSevmzUpi
	 idH8ZF/bGiJQXvUdFXjK9tsVvvoEggvnxGugqFFgXtzOWCgF/wZypEFg6QME5YQfxWl3k
	 FXMgWK7xlMeSJ8ZJl44EX98+8LfDWIXX/8aZnMmXqcqTsGLtYZ/e8MkqhsOqKVkVjDfay
	 diylxPu0wJTZlpT8OwvbEUCShoK61xOjSWyqoZNCjO6RsM5uocm6AuqbVZFnICTNitA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792629027;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ydO0eraG8WZOqDtntjgt0/RZkDKkzqBP3kzZ637E/uM=;
	b=5f92wwcFz+mnmdAmelH3SAqTWMXPOTrJxW+7E8SvxG/hNbhuTYM5E9QOeBQdLgbjtXoF
	 duxZczVbH0W5qJIfKF8bKbSKlshvweWCrsZ7TOSwT6R9FmkrPckDTNcWw8IcljhzrAPcd
	 y2j74pGIkfEKPAZNxNtoAU3RdrBavG1pfzgEDn85G+PHnExLG4SRJ4JAI103s2P/NCJZt
	 mFeb0D/CN7dx6DuHlbTGy0w/6ekBGNxc5UFbM0oOobsdpcaGHNw8LZsP2BGqOFy/bm8jm
	 f4CFsjFY/h38ibsYhCXvhotB3FzqZn7j4zeWwldOH6CxgY09axymcoMaYWmZH9V9/Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bybPJTrc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A2606A31B;
	Thu, 22 Oct 2026 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bybPJTrc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6D61F000C2;
	Thu, 22 Oct 2026 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792629026;
	bh=ydO0eraG8WZOqDtntjgt0/RZkDKkzqBP3kzZ637E/uM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bybPJTrcaRjvtcBX5J2JDrzVGmjeNy9U4LuVcwNJ28AOYdawmjm+PBTSe7V4wd340
	 GVnDFHryU3k2UUjmodK3UiWsWVxisu1g51LXmOyVfopvkPszfCbQuVobzfIUUwqZdb
	 fCvABp09JxBJSJqTHEYnaoeu7DEsMlUUa/7f9NeafaLXP4HoMpTM69gt/6zYO3XwTy
	 FG2fKX0DzgjqerdreAH6DBT4JIhP66hIeNg3DY8FDBALk1LrzakmrIUFudy+2QvZev
	 PUIV8FqP3PiUVUOyEI6EHNKbx1Gu4g2svCADb5FNOQ+MvLExrik165/bNBQxRBCoRm
	 LL3OuaZVXIZcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B42ED380A963;
	Thu, 22 Oct 2026 00:30:26 +0000 (UTC)
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
Subject: Re: [PATCH net] net: sparx5/lan969x: do not clobber the PSFP cycle
 timer update period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179262902520.1378903.18369274366620935912.git-patchwork-notify@kernel.org>
Date: Thu, 22 Oct 2026 00:30:25 +0000
References: <20261020-sparx5-psfp-cycle-timer-v1-1-00f2908f096a@microchip.com>
In-Reply-To: 
 <20261020-sparx5-psfp-cycle-timer-v1-1-00f2908f096a@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 10:58:58 +0200 you wrote:
> sparx5_psfp_init() enables the periodic stream gate cycle timer update,
> which keeps the cycle start time of each stream gate within one cycle
> time of the current time. SG_CT_CLKS sets the update period, in system
> clock cycles.
> 
> Before this patch, the update is enabled with a full register write of
> SG_CT_UPDATE_ENA only, which also sets SG_CT_CLKS to zero. That is below
> the documented minimum, the number of stream gates (1024 on sparx5 and
> 256 on lan969x).
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5/lan969x: do not clobber the PSFP cycle timer update period
    https://git.kernel.org/netdev/net-next/c/5a3dcad8e101

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


