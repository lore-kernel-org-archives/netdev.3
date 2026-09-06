Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668118B0A;
	Sun,  6 Sep 2026 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788654068; cv=none; b=aNzCO5nUzaayW14jh94xeF1ORloN7S3xPlgR8AZeJFhcb4Bc/g3YdSXKnKqdjsaCl/VabdOCIfjp2719vedNxO1C4XRRACMt/ZyaYg5xyaM1nMIjzZDawSv93N+/3VZAasyff69ob2YXfuNYhH2NsvP7ksQCbZSqOFW0U2PLQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788654068; c=relaxed/simple;
	bh=955emJTfXHroZhu6atdLGAyIK3laY6kxsCgRWhe6Syg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UX+3z6M9lIB0MTBAJqOFkrr7JUxkuP26hvuaBJk48Okbu9pFkmbgXP/GSKPItPvq48U4r1079zMM0lRWKkPTApIfEC/YlBlmsd4KD7n8OiDGeqWEaAGgLqfXnzhTyu9fRg91RbJfNGuzHUFLVHq/yQePzBIfGYrOLMykkhojInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/6kjSUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/6kjSUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C6B1F00A3A;
	Sun,  6 Sep 2026 00:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788654066;
	bh=rcwhg/AZAos+9wOTo0kL6LUtmvfW6LFdgMLURHiE/3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F/6kjSUAXTKRAGa07wYMfqTtziSaA5LEPGfGyuk6HMviVNCVCJlB3vrSklKbR5IVQ
	 d0NWJNjCdk5jhFzRjD7k/2mbngOY/jgFf8MsKCQN11pqiPuu52P+XWSgPd+jrxVODw
	 D0ItfJEbR3VSXKzKMdJy0rGLvFgA5UGtN+AUZdm0oQ9FHJEoJ3gNAZ03AGu+EQDI4x
	 9m2ReJWbbpo0ThQveMvZ1zjRpzxw85TrKeO05grwgB1RegPU/CER+DdMwz+Uf0jGXf
	 8O+lir1JHQWm2FzbEsIMdvjrNYXhD4BEafd1s0Jzb7RoBoE5BSMHyIEUf8Bhgtsd24
	 g4A0SZSf/E+sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994D39253C3;
	Sun,  6 Sep 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: fix NULL pointer dereference on unbind
 with
 fixed-link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178865400689.1390792.2279242920046320730.git-patchwork-notify@kernel.org>
Date: Sun, 06 Sep 2026 00:20:06 +0000
References: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20260902102836.2019355-1-vineeth.karumanchi@amd.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 2 Sep 2026 15:58:36 +0530 you wrote:
> When the device tree describes a fixed-link and has no "mdio" child
> node, macb_mii_init() returns early without allocating the MDIO bus,
> leaving bp->mii_bus as NULL.
> 
> Two cleanup paths then dereference this NULL bus:
> 
> 1. On driver unbind, macb_remove() unconditionally calls
>    mdiobus_unregister(bp->mii_bus), which oopses:
> 
> [...]

Here is the summary with links:
  - [net] net: macb: fix NULL pointer dereference on unbind with fixed-link
    https://git.kernel.org/netdev/net/c/38b6be101006

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


