Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF0318EC5
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792438; cv=none; b=L1y03PPSCPkZmKTLJrCtlxdYDncA9XQ8y9c4EDUiETuMhcBQ5s97LWU/ZXDD3hwKjJ0WK7bScayy3aIelewBNAT6Kjk4KpZe2GdxmeBbl+Ee9HqzHVBMRswYPloVUYArOKpPIQjE/1WCKievK7OuPKBJC8pBBv7wMO0V/IzfZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792438; c=relaxed/simple;
	bh=43ON8pCnlkxBAfvfMAWo7SvB3NGbG+ht/WSaeQ5L5tM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BV1uNCSi4/76olbPk5YQGefWGL2R7e4qhy6DUZUKlrDtZLcnz5m3R+yDoGr9KNXcjvn1VuuYRLNNca1DWG0VdBac2JyRPOrYUw7xoSFZt/P0ouSSGNjKSyf6JRw6XwLurH8wm8Has9J2pOuBYsdSnZpmjDTD0WnErugmQL8qbcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV3Nq1l9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV3Nq1l9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D25CC19421;
	Fri, 10 Apr 2026 03:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792438;
	bh=43ON8pCnlkxBAfvfMAWo7SvB3NGbG+ht/WSaeQ5L5tM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LV3Nq1l9pgac5Tb7A44a26a4wB4eB3OfMYZj4CRxjAxzGn89WzXOFF15+LTXQjBp7
	 XWqO4m4lW9CHqUg7ogx0/7t618rL8W+PdKaKprC5HdaXhtBIzxEQ5JjhF+cFevPAnN
	 HhZcvQKIQUiVS1EdY6+l6r4h+Fnl2oGm1N5CcRPR4dbJDWvjH9gDwenIs0qE9Y5XGg
	 pPrpkEmQ5haqYQcygv/k1Y4LCyDSmvrm+NxX73YvRIuXuU5h7q5ieLeLAf7hkvAP3J
	 W43BoWcZUilG7sV9tuhbVw926/lH8Cd8zFzfPI3BC9eLraWzvJUspWEAi6btl5OqZm
	 RCbKRsZSVsaOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E383809A22;
	Fri, 10 Apr 2026 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] net: bcmgenet: fix queue lock up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579241354.1854480.4016027802423644177.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:13 +0000
References: <20260406175756.134567-1-justin.chen@broadcom.com>
In-Reply-To: <20260406175756.134567-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 opendmb@gmail.com, nb@tipi-net.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 10:57:53 -0700 you wrote:
> We have been seeing reports of logs like this.
> # [   39.713199] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 7991 ms
> [   41.761198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 10039 ms
> [   43.745198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 12023 ms
> [   45.729198] bcmgenet 1001300000.ethernet eth0: NETDEV WATCHDOG: CPU: 0: transmit queue 2 timed out 14007 ms
> 
> We have two issues. The persistent queue timeouts and the eventual lock up of the entire transmit.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] net: bcmgenet: fix off-by-one in bcmgenet_put_txcb
    https://git.kernel.org/netdev/net/c/57f3f53d2c9c
  - [net,v3,2/3] net: bcmgenet: fix leaking free_bds
    https://git.kernel.org/netdev/net/c/3f3168300efb
  - [net,v3,3/3] net: bcmgenet: fix racing timeout handler
    https://git.kernel.org/netdev/net/c/5393b2b5bee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


