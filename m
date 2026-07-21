Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD34C97;
	Tue, 21 Jul 2026 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621436; cv=none; b=RMdWIiCwAZ1CxSPUfZye6YLmEvCtvW/K8zKgjpojoliwcRfK+6zODptfuA5xVwqZbjXO4erBIxfuem/Zgqdj762l4ox299KtV2J92/qpgynM7u85lh9D5DFR4vjYY1wPPUR1YUQcdKQGgQ/TCaQXcInKbrtnv5A9tFdMQ9Tite8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621436; c=relaxed/simple;
	bh=FKAZuZaLRSYZxrjDtk3ovLFHB5kJxedbiD2VxJKq0pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sc4xVnIhDezrPDYUZM1eGzJ7d6inNkR8EX7tzeS5MkJXcxR3EL/uq+ullfNM0NnFf8LKuoXRvTYxMHTzt7M/OkRztOFfrkU1U9KN2We4tvGqCWGzVpY4/dl8bPwsvg6tKkqtI12g4rIIMDqHNAJFaaN8ZmCTlKMxXQGp6ifVXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIQlFZzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIQlFZzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61D51F00A3A;
	Tue, 21 Jul 2026 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621435;
	bh=7o7uwFNCO2tDJrAQJgjB/tULGXjD64gbJfysYTaXg9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OIQlFZzGu6nXEeX7zUKxUmeixYUNwwBPBfLC3WUiXMDaIbPqUIoj7xxdtmgOnZFYw
	 XgHvGvHRcEg2cMV53r2NEhiQAr42byyOco43xB2xFo8XupTm2vJzItiTCojOeM7RwY
	 gR/tm47ss+RFAXVJ4bsLc5GHimx1GQcaEVpq6KEImk83JHYpm+itxOH5vLii+cg86c
	 xYHvNeZ6svvD/913PwuX3AoHU1WkhUYTaUi9Go48zOtDIu3AFqpQNBdh9D/9FY8gYh
	 iHcBjiktihSuSS8UuoSExGF/DdfnKI7K3VZXBNiUu5u6OVJbKkLi8HAHGlCRDI5XZ1
	 eCdL/+lbabH7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A473924A2B;
	Tue, 21 Jul 2026 08:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sparx5: configure TAS port link speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462140540.147087.2700463429502862758.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 08:10:05 +0000
References: <20260707170531.1129866-1-robert.marko@sartura.hr>
In-Reply-To: <20260707170531.1129866-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jul 2026 19:04:48 +0200 you wrote:
> On the TSN and RED variants of LAN969x and SparX-5i TAS (Time-Aware Shaper)
> is present in the silicon.
> 
> Currently, the driver does not use configure it at all, which means that
> the TAS_PROFILE_CONFIG.LINK_SPEED[1] value is left at the default of 3
> which means that its configured for 1 Gbps.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sparx5: configure TAS port link speed
    https://git.kernel.org/netdev/net-next/c/80d8e1d428e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


