Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA836F434;
	Wed, 23 Sep 2026 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129485; cv=none; b=C1gsBziKmAwhh4pdVK0iHUozDsXtdQkczsLzmdM1obIveFxyhpeswIM0hwvX3T7ljbQhZw8Hv1j4XDJbVVMcj0APM1AwQYJ01KRxfB/wOVDgI41fd9UIMHKwU3aWaUk/a9j+lKXJaCiVVpHKcmzNvhLjzr2xowp1Kd7QplV+JEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129485; c=relaxed/simple;
	bh=8+oQaHngDapMXc0OALqHQ5u2rTsxDKcIhI/R9LjROec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uh0jnA03TM6U462DlfmcmvqUdsujmyQ+w90cXRi1gC8wbLQEDitalgJW0cUST7RtsMmAVNHpCzg+tRLDfDtrm0SJxQFeJ4/87RH7/FeTr8X3NsSu8NUiBJ+CF+DX3bWfuKv3p0k6chTMoxl/0pQVGGjzcNvJME/5MXbbFxWob3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx1iIDIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx1iIDIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838341F000FF;
	Wed, 23 Sep 2026 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129483;
	bh=NQkTQeI6x2G5cd3VqYqdH+u2bT6qJTctYvzUkw3D0A8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lx1iIDIeZbYAyyOZePHIGnq0vG56mo3tNDL2vdUDqgEOMUOBe90m2hNYoYUaToqFE
	 p6AzJON/1U6fH75fUDzQYYjQximfEM+6L0gqZ1Ip5+fZ6mbFyC8zkh/bkWOVe2EAun
	 OTK0AEYcUdfJDjS/uW0aTkVpkFfKAi5Lr68G6snjuCzsxkOwdzmty6EW2Dn9XzPQ8X
	 51NbhpnOOVJ/o9gMnq9FEz+UZSYWxKu5UTakqqKcNrvOVNL9x74TLv62zmZh7qMZ1o
	 apmB+PibUYiuWNpRFVGTaNSfegvhKlyMhcI1J/YlIx2JT+PAsv84VJ5go8AH8lHGT/
	 S5wtXhHAyaM/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569983924472;
	Wed, 23 Sep 2026 02:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: publish the OF module
 alias
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012941389.177114.16361197546318394143.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 02:10:13 +0000
References: <20260922005049.7647-1-hppiscas@163.com>
In-Reply-To: <20260922005049.7647-1-hppiscas@163.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linusw@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 08:50:49 +0800 you wrote:
> The MDIO driver matches marvell,mv88e6060 through its OF table, but the
> table is not exported. The existing platform alias does not supply the
> OF modalias used for this MDIO-enumerated device.
> 
> Export the existing table so modular OF-based configurations can load
> the switch driver automatically.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: mv88e6060: publish the OF module alias
    https://git.kernel.org/netdev/net-next/c/776b5abf3fa3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


