Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C88E2D73B8;
	Wed,  9 Sep 2026 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918068; cv=none; b=j0tHv2SVLWa5G6EyBethDRlfwjqW1AeL4LUidrG+L1cAJIpAeTgYEQrqjbE6291xR70Jj/a+jzYQSXdUI4eOubkTfXG+fngmugUG+aoKVurYaOlYYcWJ7gd+iNY333XXdeo4rZQar8O9iz6uIJSPb1kzkYxCVsWRWGpr1BWGTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918068; c=relaxed/simple;
	bh=yvS1B9jaUrssVYt9A2YIOyduChty+KIz9RgRb0gd4/8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KTnnuuv6w2NJftLhOlD3VZ1NSGknoJPA4G4IW7nTRfDlHOc5qOOp24SEOBJzjQhKS4kaVpr+MY+guqAqNYNOpryk6Ztd7b6QoZYT2ynqP90F/eYjVPM0z6p5qXsgEzu/uSwHVR/nCrEA8MEi68eer5FOkaUpTNSXLF6Toa+Tw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYqX8TJj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYqX8TJj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F161F00A3A;
	Wed,  9 Sep 2026 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918067;
	bh=/HT7p1o2AJKupA2SruM4lB4IcKjOH72WTzcoSAa74DE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SYqX8TJjbMVlRkGJkS5PpYiT4wcjiV7Xd8DlD7c6iMG+g4l/tWzeLLR4vUkAINjvw
	 in3/vdj4UsOvoJApOVrJRYgCn3jg03wTgBNJjThdVUujgcG8N6wCI6vPNk6606oShR
	 Bcdkjf+AnkK20fjBYcSpWKK/8IJi5IvAhNw/H4nSfmEI6pACeOjtR7Xe/1aZuKdSMP
	 9wZPr5E/fcC8SNfOHkIh6Cc5RB6lU/bjjdx9LM93aZ9fMyRQANP8U0lbrKc9oeCkSo
	 T2QjZQ7Z1a5ingqXu+AyGaYRCFmNmXnpFs3VF3Pwqst7/nKx2SU6GL5+ExNizgRV+9
	 jCARtIsC/ZC7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938AC380820D;
	Wed,  9 Sep 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: macb: fix two probe path leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891800539.103980.5397686662404338366.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 01:40:05 +0000
References: <20260907210856.1673589-1-nb@tipi-net.de>
In-Reply-To: <20260907210856.1673589-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 atenart@kernel.org, o.rempel@pengutronix.de, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 23:08:54 +0200 you wrote:
> Two independent leaks on macb probe paths, both noticed while reviewing
> the fixed-link unbind crash fix [1].
> 
> Patch 1 destroys the phylink instance when probe fails after
> macb_mii_init() has succeeded. Patch 2 drops the "mdio" child node
> reference on the success path of macb_mii_init().
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: macb: destroy the phylink instance on the probe error path
    https://git.kernel.org/netdev/net/c/7d059f390750
  - [net,2/2] net: macb: put the "mdio" child node reference on success
    https://git.kernel.org/netdev/net/c/382a373d9ea7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


