Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B9282F20;
	Wed, 30 Sep 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728208; cv=none; b=sIeFZTQMFYtQZgRVW74UtKRsv1rLU/GAtuNaqtvRBOxJ63/au5O7/PBqMVBsIVsu21nq2/hallEjWJSHKrVyCQXbkb78t2RbUgOzghEEI/GvkZT4CrbrHrpcKOG1HBlsxSRtz+gDbK2q+dK7pvRHE2DVd32QZeOvoLbHdEsF408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728208; c=relaxed/simple;
	bh=vNW8LuCKhtSIPOsqEAKz0G1ppn4MvMsYJk6CVvdhQtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AryubeAE+BOpJ+wjZfNT0F+nvY8m9amkwhPug264tDoDl/P15He+68RCNyXyR4OAc5zuH/2RycOgBqpjwqVegGJcde+7Nqm1ZnTPcisgDc7yh6IgF+cYjXUiO0PC9DwornhNshzUfkRFU3Uc89WZjhMyWmh9OjE2eIO//FazDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLX9YqJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLX9YqJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3931F000FF;
	Wed, 30 Sep 2026 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728206;
	bh=nzrw1DJAxJrrbMgCNrigmRVtMubjrWWM9LSdykWzn54=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SLX9YqJ20OOE1gTlypIfyEyf/i5KOEzOgbLR6kk9PWApnvxrpZ+1U9Qcoch9idgs8
	 BTqQckV9aQwbZK/SpCRiZXp8mXNTan3vdIWo/I0NP17vMSlbZyxJd97Tc/0rNiVbA8
	 QKrT4v7SpEkNvlgADMO3yC0XGATWglQqUywaF2XvqClcKs+qD9jmor8Ynaof6t5E1J
	 jTd8iKjsx4sS+inLvBgMyUDX+7rn9hs9SnLHVsJKjWQ3q4JPH/MIxDn2RfisVPTjAK
	 qV/b8bCDnZffce0l3HitpoZkyuiJQzfLDtxOPtBm6TOLMQPmvz/WyLiuosUktdSpaN
	 mqTqi0gAm0mKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43C93924FEA;
	Wed, 30 Sep 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: pcs: rzn1-miic: Clear MIIC protection state
 before unprotect sequence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179072820554.1181068.4496571892719089196.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 00:30:05 +0000
References: 
 <TYCPR01MB74815955A10817B64BD6FB93A4812@TYCPR01MB7481.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB74815955A10817B64BD6FB93A4812@TYCPR01MB7481.jpnprd01.prod.outlook.com>
To: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 10:36:57 +0000 you wrote:
> On RZ/T2H and RZ/N1D MIIC, writing 0x0000 to the MIIC protection
> register clears the protection state machine.
> 
> The initial protection state cannot be assumed to be constant,
> as it may be influenced by previous activity before the driver
> takes ownership of the hardware.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: pcs: rzn1-miic: Clear MIIC protection state before unprotect sequence
    https://git.kernel.org/netdev/net/c/8b9993437429

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


