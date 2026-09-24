Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2B345CCA;
	Thu, 24 Sep 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266878; cv=none; b=EKJb0nn41nntrvIdE/vLaxeoe2A29mnaUmnkqJFyoJs3zge/tWxlX7jZqECvbqT7qjMKFkneWsmg1Dc1OAvAhZwZiCg771mXBRA6wMBXbWDvqXo9AiY9ffXPLZY8zIkTO5H71XZ6HqN4gbvoNuGr5FgHw3pcVAdXO9cnGjTBlD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266878; c=relaxed/simple;
	bh=bS0gSLPQgnjRu+NChwzGwhkPcUhKIYynyUuCSdXm8MQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKYpZLDiGcOUG8kU/9TVhcu5OPTrFJyMjs3XznXr4VXRznsS/SUvBM9ctRGWoQgsaWMEEuVWbSCu8F1/FObVNlapQlnflUAH23F/UO4qFHOok1+0ghARS6QiKsYvwBtVCo7a+g9v0PR6eziNdSuEiKGgYCjcPJ6JWAQ+1Gu4aOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlVAKJYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlVAKJYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3C01F000FF;
	Thu, 24 Sep 2026 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790266877;
	bh=t267H+Xjy70DfN6XTLGNuJg/rzEU4tIA4A29SQzOONw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WlVAKJYUG2h2BEfgMlJvmLiLOXQULaKIAFv1ri2EAsxSqRkwzMrkypjDnGgKtaDdT
	 9eads90jWb6XOqr7Rt6VszN70xqoKPgdhLqs4EH7MV2J3ylXX1geSBfc/umwtqPfOs
	 F10Z8t+TIkFACe5weI3TTYGU5kpeNH5vUbM9MEgOXYAZ98ixZ+pVBKWGlZm3pLkqlf
	 CpOBNXHuPO84rKfj+nTuf5M0B0zfFfe9A4Q6ULM34yyelRjYXOWRypObeRoT0gVg91
	 KyMEzF9mpxC/D2G5CIqskRoeNAU5rI+r/4aGRDuB7sByBDileFaS3svttqPMcxRA8z
	 ptS/ABXK6R8CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692F3A566CE;
	Thu, 24 Sep 2026 16:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: dsa: mt7530: fix two crashes on driver
 unbind
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026680615.1636687.12670916217033906178.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:20:06 +0000
References: <20260918015020.2518315-1-f@lex.la>
In-Reply-To: <20260918015020.2518315-1-f@lex.la>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com, daniel@makrotopia.org,
 andrew@lunn.ch, olteanv@gmail.com, gerg@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Sep 2026 04:50:18 +0300 you wrote:
> Unbinding the MT7530 driver from an MT7531 dereferences NULL in
> regulator_disable(). On a Netcraze NC-1012 (MT7981B + MT7531, 6.18.44):
> 
>   # echo mdio-bus:1f > /sys/bus/mdio_bus/drivers/mt7530-mdio/unbind
> 
> oopses there, and the build it was found on sets CONFIG_PANIC_ON_OOPS, so
> the board goes down with it. Fix that and the same command gets as far as
> mt7530_remove_common(), which disposes interrupt mappings the switch's own
> regmap-irq chip still owns; the regmap-irq thread then faults in
> handle_nested_irq() later in the same teardown. rmmod reaches both, since
> mdio_module_driver() calls .remove on module exit.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: dsa: mt7530: fix NULL dereference on unbind of MT7531 and MT7621
    https://git.kernel.org/netdev/net/c/c2cdef41e0b4
  - [net,v2,2/2] net: dsa: mt7530: leave the MDIO IRQ mappings to regmap-irq
    https://git.kernel.org/netdev/net/c/0d80ba0a204c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


