Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD442A160;
	Wed, 22 Jul 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751070; cv=none; b=IWO1OzDrjmFxJOiTUt6JPweKy1EHp2lxMMXGsqsyaq2ij0Y5n5Uel+3MviCY9z6jnV3KcXygv5UKKVCKJylsG9KXKb62nvIuUUkI2KKdZq2rMNgpqxWpc+6qaAWEYqXmuHS/VjPyyCWYtSipOh6kMcSSKGVbz6qfG2wM/3q9sFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751070; c=relaxed/simple;
	bh=Nl62wsTbgAULxP6P0KI1ZXE7IAugb7xzVUjExqIZXfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ov/6r6l2Nu1jEOU8UqeIY2JE6BT/npc614nLhfWDfswQpi4oMib8+syHFKQUCVZsUOajgQK+K2El9BUtJ+rDnnyZ7GNxW4U5cN57ilQctYXPl8h6lrGYA1tZhl3Wd2joeDc6uInp0NRL8HuxcFbiBKmQhJKaotS6ryEGFEnrt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPRs3R4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPRs3R4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E851F000E9;
	Wed, 22 Jul 2026 20:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751069;
	bh=TXKi/O6yvT3TjVOfpUbchx35R4JMj2AQfiR+V10Slg4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CPRs3R4UkyJKVIdSr6w02ia6cnQ5u2ndEXlwgMXQ//Uqt1uQ2Zo04SLRp4vxqzKul
	 S+YYP0ZVdkmrKiZQ+saUwmqNi/j31565OcKWrw25NjPYxxpgGjKvudxNdXgpsylzjg
	 qpdgOg9exTKXfW/ug/rkOyUihFE9YpG1ze99nW8O9/+InCuVo/gdizJBvg1/0dIFWe
	 iLIx/2kkxsX0IHZzy1k5gIl8EX+gYkfZ+UiTnN9f2Iao2d1TO5u/YvI7+LIHRltsW7
	 o8mPk4d5agiyOP1qkUx64kHobXggCK4AP/vk3Q7YUhO74WeutEgsc66vjHB0Tbdxr2
	 hKpPnqiZVHzUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990F380CECF;
	Wed, 22 Jul 2026 20:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: dwmac4: mask interrupts when stopping
 DMA
 in suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475103764.2005094.13413137826625826430.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 20:10:37 +0000
References: <20260720111534.163416-1-luis.la@mail.de>
In-Reply-To: <20260720111534.163416-1-luis.la@mail.de>
To: luis.la@mail.de <luis.la@mail.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 o.rempel@pengutronix.de, ovidiu.panait.rb@renesas.com,
 rohan.g.thomas@altera.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Jul 2026 13:15:29 +0200 you wrote:
> Since commit 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU
> interrupts"), suspending causes an interrupt storm from the RPS
> interrupt.
> Fix this by adding a deinit_chan() op to stmmac_dma_ops, which
> masks all default dma channel interrupts. This is called from
> stmmac_stop_all_dma(), so interrupts don't trigger while suspending.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: dwmac4: mask interrupts when stopping DMA in suspend
    https://git.kernel.org/netdev/net/c/59a57128ae52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


