Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D92C21E8;
	Thu,  2 Jul 2026 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980448; cv=none; b=mra1ZCNEWFUlhqxlFUmqCfBAg8azvSvHa6Al8qvU8v5TSyCmWPe0s9w7F8nnwny3RzH/mzpjmPQm8T0evfXhVx1+8BW54TqsUoD7NwOAttTXnUOGnhK3BBhG9z4lxGEHhKJUTs1r/SkvZYcp71TerSw4TVV7aGXmkBjEzAiuO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980448; c=relaxed/simple;
	bh=yDvw98/8GopwCa56MQDQl3AokEFX4GmszEqJtDBNyGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BydZhczKcL9s5U8R6UAJHeymPtQph+F8cn01Bau3lxtN+lO7byXV0CYa39ExN9KjCTFFEKluL+UljyFUuQZImO5CtN/aeecEsv49SQdP/4IK0nId2lnoRnopfqnKN4nDCadQGnaRk6G32sQJTHP4BMuOxCoPLTXU4uzcHLMswSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLHzQyWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLHzQyWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588F51F000E9;
	Thu,  2 Jul 2026 08:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980447;
	bh=Tr9cXC0OCwfJzYHZUk1OPi/rA+dVy0Z7JJiTxU+68ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jLHzQyWqKPybHSvUztisKZbEsvRDJp6AEZPGC0Rr5TvNANY+LRsWTfrSoDye31QYN
	 v8eF9GtOa9YX+qmyrn/IUJFcNngdfs5sZZjG/CDSvtHLfE/fkZvsvmzeVtYlE4csUK
	 PRxIOd0M9e3IxbeyZlkwab7LjLeBvsavnVOD4dUWnqEhkCGE2dwyUSgxBkthGClH3O
	 rLkhyQYMVLAwZ7WzWjYd6aKRICr1Ce+cbk8ZokYg7NdfZhNGPKbncPu7XUGGCEudTM
	 RWy3+uZaObeepovRLNMPc5gVA57byEJ8L80jRfvzzmYYmpDtelFGAR1fz8JuZEG0yu
	 bioo2HmcfyFRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B283926655;
	Thu,  2 Jul 2026 08:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: Drop references to the .validate()
 method in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298043013.1512795.2607486084440200164.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:20:30 +0000
References: <20260630083700.2041915-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260630083700.2041915-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 10:37:00 +0200 you wrote:
> The phylink_mac_ops '.validate()' has been removed in:
> 
> commit da5f6b80ad64 ("net: phylink: remove .validate() method")
> 
> There are still a few comments around in phylink that references that,
> related to the ports fields as well as the Pause configuration. Let's
> drop these references and update the comments related to Pause handling.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: Drop references to the .validate() method in comments
    https://git.kernel.org/netdev/net-next/c/7693eadcbb8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


