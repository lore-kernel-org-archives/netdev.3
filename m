Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AD261B9C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781312419; cv=none; b=glv+mB5rGz2NuSJCm0BXMPPkaMKxeD1RjTYx8vMC1YLZGHHeZ/7s//l1NGykieaNrDLL8nkk3J0WCa39aRbK9CezjnbdHCjq9qAY9NoJNVJWhQ8HriLpeQOqaaYk64rq0/hcQkruZIa7Ed6R54BdXd4jzhJnp+dmgOuDDcL16ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781312419; c=relaxed/simple;
	bh=PWFkGI7L/8YFu9O4HYe+/oj4NlM1gDhja+ZAlGMz+jc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gASn7Z9xxPBfkGgt0OUFkC/UaCSePBrTQGyzCODZHrLv6ntWYVZaY1awBTpcagjZZz4iCB7rZd3P74FZdo5YB2JLh7uPizOqoHQlQHTEb1WzPJUFIRhbMMEAjMUI/lHX3D/ModP3LLNCcxgiSy4KcZBOehEfsyDIl4ReJ7ES34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX5UeNZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX5UeNZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF33A1F00A3A;
	Sat, 13 Jun 2026 01:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781312417;
	bh=Zp5+HYnmzAY3tecF9x+rV8jHXOZQyFIfnYkXXcKefps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DX5UeNZJgYaBt57lyZUy1EK3OUJwCEawJTO3ggGaq3rk+K2hoOsi5sRQUsPLzVBr9
	 EJDqDzL5fnyDDOyPkhJmAAs8rgcwOqcAoGfOoBlO+9zk/fvCFq5k/szeC0oe9AbK+w
	 +xayE6sFwjb+o6qwJyTbQrbmxJUw7I96fdTQyEtylmDdvWoj35UZqtzvnq262yhcXK
	 IhWmW/hooFM/lyMhJbayXl41/eEoNKkWFx4J/w8hpZRvSG3c5FHkGBRg85OqFhuqvq
	 k+r8vc5k267G5kamB78S7XfCCQcJrp1JR5yFE7+osDElWFCQdtHYPsWSso1ZKaJ6/4
	 HBYjMPiofrCxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939AB39E9607;
	Sat, 13 Jun 2026 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: mtk_wed: fix loading WO firmware for
 MT7986
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131241413.1315131.4770836958517180576.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:00:14 +0000
References: <20260611150051.586-1-hujy652@gmail.com>
In-Reply-To: <20260611150051.586-1-hujy652@gmail.com>
To: Zhi-Jun You <hujy652@gmail.com>
Cc: lorenzo@kernel.org, nbd@nbd.name, netdev@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 23:00:51 +0800 you wrote:
> MT7986 requires a different mask for second WO firmware.
> Without this, WO would timeout after loading FW.
> 
> The correct mask was removed when adding WED for MT7988.
> Add it back and add a WED version check to fix it.
> 
> This can be reproduced with a MT7986 + MT7916 board.
> 
> [...]

Here is the summary with links:
  - net: ethernet: mtk_wed: fix loading WO firmware for MT7986
    https://git.kernel.org/netdev/net/c/9192a18f6de2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


