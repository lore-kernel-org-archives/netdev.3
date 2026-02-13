Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA11A9F91;
	Fri, 13 Feb 2026 03:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770952216; cv=none; b=g9MDk0d/BDDrjna6hUrWZ+Ws3vehpdyb1okn1Oa6DNsNFS0vX2mPnf3d9vHEdVy3ZPcq2jR3WpX4RI2OI0w7dR2YsfdL2dooarUEFQUqJxbqP1RCVIwVeBuHX1vUkw6ys5RWHBUuZeaQc39ejR3chavPp6pYKzCz987y4/mzEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770952216; c=relaxed/simple;
	bh=SaYAiSTeda0ott75Qw/mkaQ0eig9Sx4NgiZBMmqTLJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lURsM540Y02OwKM4UAFLdZ7zJnTXuaqY3pvb1rP/i+AYKExo2xkRMHl/DEIw0O+v2uRhFvS0jyU6r9uZp+RQf743CbhHhAfnAEDjTiSLWWeEdkvo78VshG+qk3OZsPEAknA5b7rdazrwtu5RsdY979p0H+MceHuazLI+XlioJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ3ZIBY7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ3ZIBY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016B5C4CEF7;
	Fri, 13 Feb 2026 03:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770952216;
	bh=SaYAiSTeda0ott75Qw/mkaQ0eig9Sx4NgiZBMmqTLJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQ3ZIBY7kwRlay/f9mzgwK9Itz+fs6pasAFohKdK0zoK805HlYzcZ6No36FGfBYR1
	 7pDl2Hq93v8isMtMBL1dqg4cMfDoF55jci28YvsoUh0rUuhdPcrQbbRZDamUL1jjAV
	 tUfuwn0CNyey7KCLoeWt6/oWZseOlzwQcDGZjAcpWAOqAVpvNhYIYTHV1+OewOZBmC
	 JOKtcg2RfLVyEEjvJqirWnIZWY4hPSgp4CB3lY1/2u5KdzeuDxxh6MreKctcW7gFea
	 bDZnL/VedniXmQsHRalVGT2dNo/TCF7UzyLItxJlLJRrl6Q+x1Mx6iyAhbzoST2QpC
	 JLqe5Bjt7GD7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 481483931093;
	Fri, 13 Feb 2026 03:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5/lan969x: fix DWRR cost max to match
 hardware register width
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095220983.1827286.14396517672847717184.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 03:10:09 +0000
References: 
 <20260210-sparx5-fix-dwrr-cost-max-v1-1-58fbdbc25652@microchip.com>
In-Reply-To: 
 <20260210-sparx5-fix-dwrr-cost-max-v1-1-58fbdbc25652@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Feb 2026 14:44:01 +0100 you wrote:
> DWRR (Deficit Weighted Round Robin) scheduling distributes bandwidth
> across traffic classes based on per-queue cost values, where lower cost
> means higher bandwidth share.
> 
> The SPX5_DWRR_COST_MAX constant is 63 (6 bits) but the hardware
> register field HSCH_DWRR_ENTRY_DWRR_COST is GENMASK(24, 20), only
> 5 bits wide (max 31). This causes sparx5_weight_to_hw_cost() to
> compute cost values that silently overflow via FIELD_PREP, resulting
> in incorrect scheduling weights.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5/lan969x: fix DWRR cost max to match hardware register width
    https://git.kernel.org/netdev/net/c/6c28aa8dfdf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


