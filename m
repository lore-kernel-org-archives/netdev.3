Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314A3C76BB
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771887; cv=none; b=IY/AUDXnhK0pEaWjTOkDpu7OJgvqvkx+WnyzQPmvskOzLahtpbckF9msx87xtPAUswSAKWK3nAw+PbvACx6K2YWjiduJkYbYq+uP9YsiJKq5fyxTG4UzN/HmJGKvJS470P7FCcxCQFftB4C51JNmQk0SDHOcJCwP1cOX9NHHp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771887; c=relaxed/simple;
	bh=5U3VhDSyNCRGdWBkK4ot63/4GsqgaddGL2JRYelk8NY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T5lGP1cY61RMZSkusmhLSHxs43vS8NoK5Tlagcf7YkzYs8A9DF9di2+gZSBnr8M7WcpPqz5vAW3upgvIcAAyUiRICrZ4Fgm8S0OPGG78i1nnk3w8VeUTRLoCf+vjtdXktkCeM0ZFGGsK4xWZj8MDBsiLRYRslcG6T2Vo+kXWWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfhN51vO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfhN51vO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239591F00898;
	Fri, 18 Sep 2026 22:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789771886;
	bh=MJbZDu9WddoilXHi1Wq8jyruShYslGFx/mthwkI4NX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lfhN51vOpUN7tIjY9RUGj47PlcpLBrZ64qEN+HsmzqbV/xu7nhQVZnFwpmOfG637U
	 bRyPbT1u0XttV/n7DH1DeDdnyT/a49/LO6q6PPMvcFh1hCOkFPoqsxtXUxfZkRKzwT
	 d90YwxksqZ8Dj6lcBLpAz5pt/XgucTPVAoCaj6E+f8aRwdkzMwq68Q6Q/GsXd/cZUS
	 h2e5QyBCr0jC8W0ijXvLjz3kpEQMuXic7m2u+HGu63PuBJWts5jlqCP72FZbgGdFDl
	 ZJHHSMW4wGe3csoAUX4p4rA1dy6dFJj+29nw/FXb/Olo8rcA1hPrkW66jgD0AdsEA9
	 mLO/yHQedY80w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568BD381196A;
	Fri, 18 Sep 2026 22:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: rmnet: lockless rmnet_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977181889.1178488.9390844258869623264.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 22:50:18 +0000
References: <20260916132231.1780091-1-edumazet@google.com>
In-Reply-To: <20260916132231.1780091-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 13:22:28 +0000 you wrote:
> rmnet_fill_info() currently relies on RTNL being held, because it
> uses rmnet_get_port_rtnl() to reach the rmnet_port attached to the
> underlying real device.
> 
> While auditing the fields exposed there, it appears that both
> priv->mux_id and port->data_format are written under RTNL but read
> from the data path without any lock. Note that rmnet_newlink() can
> update port->data_format of an already active port, and that
> rmnet_changelink() can change both fields while traffic is flowing.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: rmnet: annotate data-races around port->data_format
    https://git.kernel.org/netdev/net-next/c/c863bf6a7d7d
  - [net-next,2/3] net: rmnet: annotate data-races around mux_id
    https://git.kernel.org/netdev/net-next/c/0067187dbe15
  - [net-next,3/3] net: rmnet: no longer rely on RTNL in rmnet_fill_info()
    https://git.kernel.org/netdev/net-next/c/d7c9ba103b06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


