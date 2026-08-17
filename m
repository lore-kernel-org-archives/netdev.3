Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C03BE630;
	Mon, 17 Aug 2026 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999263; cv=none; b=gpMiEpU2mn2/8Wk2tprYcK6tGR8Yqdp55yTv2qgaWjyX/zNBhQ3vqcDZt59Hdm5y0GT3C02RG+PLaiQvUB7ocrrQgfCRrnmU/gtQ/Ei8AwkueZEvhpqwAcrYfZY9VJ0woI9Gzz/GPHHJPtzvKwFDg8luBFX5kHpggdhV89YA6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999263; c=relaxed/simple;
	bh=7aqa5TB9Es2ZS/kC5l+0bQaAG39f7AMw70CsLK75Gxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qVlfDNdc/E1EcrJgxubFOV+9FfnMNur90dKkcX2r0AhWIZhcdD9mSA7qDk3tGZ2pVO2hyStpZjHUrjF6e8baZ44P0J6h6O/nwZDNTzORbMFNphO/54wPtAvvVHC2gM7qlmVtqxmE/NLi1BaJFy53PCcc+ZC5OOvuj11DdSWt5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0QmN5sH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0QmN5sH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA851F000E9;
	Mon, 17 Aug 2026 20:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999262;
	bh=0QULPgZVjejYdAEGFIgq9y6FZmyn1ifluOJlFIU/j8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U0QmN5sHqlmWOWN5HTseC3nzlh3dlEsUPBEYBKpHab62xylMC5ltAhyiqx429bG29
	 Xw2Skzkf9npmLoPAVxR5JILlwm6Gs/V/XlUOlePtayJgX6HVc9xKqPSZBRq0LeLSw+
	 cqECni1Zf0+uo5HvM4C2SLC7s5QlsmXW21iPRtr9CaFIUDI1iFuk4ghlNf4uUSKk2S
	 6Uxr3ATIzmtLikZVAl5RdszBbhveEvcRny8vCj+CSdTklWQbpDAJ8JHxyOjrnbPfuM
	 FlqqAbkReMe6OTOqhPEUqy1kUptIhYLoFibwcE6+Msu0hyYFRsgZIF4+vQ4EGdqRLe
	 GQq7sebe7pT8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AEE3926265;
	Mon, 17 Aug 2026 20:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] dpll: fix NULL deref in dpll_device_ops() during
 teardown race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699921389.1728655.16194826179389072857.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:40:13 +0000
References: <20260813140817.1051388-1-poros@redhat.com>
In-Reply-To: <20260813140817.1051388-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, michal.michalik@intel.com,
 milena.olech@intel.com, linux-kernel@vger.kernel.org, ivecera@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Aug 2026 16:08:17 +0200 you wrote:
> When the last owner of a dpll device unregisters while a foreign driver
> still holds a pin on it via dpll_pin_on_pin_register(), the dpll object
> stays alive with an empty registration list. A pin notification queued
> before the unregister (e.g. ice reacting to zl3073x_i2c removal) then
> walks pin->dpll_refs into dpll_device_ops(), which trips the WARN_ON and
> dereferences the missing registration. dpll_lock cannot help because the
> notification work was queued before the unregistering driver took the
> lock.
> 
> [...]

Here is the summary with links:
  - [net,v2] dpll: fix NULL deref in dpll_device_ops() during teardown race
    https://git.kernel.org/netdev/net/c/33f016b23a21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


