Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A293EBF1B;
	Fri, 23 Jan 2026 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194215; cv=none; b=JhlT1QDW1cfxRWac1bvNmHxiVUw+eEbBBLQQ7Kz+nskeoh/AyRdH/2TO2AwP6+SDnoKb/l/LaVcBwF8KikaOKA9tBY6XljoDL0cVthHZfMKNfybicg2h8HJC41AkKEmdUf/ezYLAn9qAbvV4hcCYWAHRCowA0FSGUF7peOho4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194215; c=relaxed/simple;
	bh=3UFVz6dKtMD/eizUvi3MNPfTjr2oKGfOKnxW8Wn9Nso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DETLAEJfyCQkKpwTAYWk155Wn5V5GNd7tnSBOs3jgB+c1IJzLT4AgFf0IPBttbtNrl4tTijF8LdJDvkexM92L6eLZ2spa7xRlNqQSuUAK+mTxYKQZC5U9lFXGc25Fz1KpvREge/Aa3/+5cBd+73ClrsyHV5oFMP/4kzx3xtS/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrNm4zg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrNm4zg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720D3C4CEF1;
	Fri, 23 Jan 2026 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194215;
	bh=3UFVz6dKtMD/eizUvi3MNPfTjr2oKGfOKnxW8Wn9Nso=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TrNm4zg4ZPjxtsOcKn8SPfcrydXEflXLKaSI4IwTU7wNMQuoDaQDiHTQ6cRtWBsYS
	 qaWWoW/hnEsWIJb/DiD9DjmEfqbUEZBKbdKEPyFuQRvxLHChNHQfEupaDtVMuTPfTX
	 PoUf5VjQFQ9HhbALlI8gklPAoFNaVN74qCC8JLR1nXylaQWmcLUN2wYpBIL9bgtuUy
	 +HqTqmfqLw/Gqx5aVnx1mH7st7A8YLpP7FCVzg7/YziSTCQLeHGeEEKIhlc/owl661
	 WqrZt6qKWncn6ykMEYaBG05SlRt6BjQYTqEU2v3NJyDXWlIdm2rtjXzQeub64L8n6J
	 K6yv8v9jbuViA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8B8963808200;
	Fri, 23 Jan 2026 18:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING
 DRIVERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176919421135.2677151.15510623660160848169.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jan 2026 18:50:11 +0000
References: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: enelsonmoore@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, lukas.bulwahn@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Jan 2026 08:46:09 +0100 you wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit d8f87aa5fa0a ("net: remove HIPPI support and RoadRunner HIPPI
> driver") removes the hippidevice header file, but misses that there is
> still a file entry in MAINTAINERS referring to it.
> 
> Remove the obsolete file entry in NETWORKING DRIVERS.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: remove obsolete file entry in NETWORKING DRIVERS
    https://git.kernel.org/netdev/net-next/c/339e7f598589

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


