Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847F1CAA7D
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865235; cv=none; b=bM6CJzsTJ+RlUMzwV9vqn4oov6Txw+QXCpNrs6He6aEi5dUU95Keb9p+8pJZFOFi4bGfDSZkcSDvGKXiZmil3Oxue8IQsjvq31S5HL8L4FX5LSzFoLrLZhfoD2JRE5Iq3TXrLJnqDubmINN+4s8+KjcYAaUMDBON/rbAR8iUXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865235; c=relaxed/simple;
	bh=lXwJVfboG13WrDn2SUCesqqIcWwUA/r+mE25SODpWBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVn1k03mgAzfZTbc9J9mHR0wYDNfpbSOMDnHy7TbUEHZDoN0BOaU3K1a2WUXy/ftpRredaxcQ2zIy+Pijf7EH8tSgEu22i1S+NVRlz7JC2cjKDlgiGneasgDw6Pgdx5Q4q9zWuSKHIqrwB80l8143ZH3woIIC3Zqw8F0/1Gr5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVXBY30W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVXBY30W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF421F000E9;
	Wed,  1 Jul 2026 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865234;
	bh=fFH1f1zljQGut6nXy3zxBffRmqvy/56HlL61A3NE7UQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LVXBY30W2A9+wfP4Oh8/scbuvljX7VxEuoEnmeqzEOgfEW6Rd9h8FucJlKeDvuSlM
	 5+kZdBi1/D0qw/AQVzHt9CNrrKSirr5dx/gDssT2DoeAnhY91HVX/nWCKQxH8dZfK4
	 1ha40pU66werxx6tl2LtkbaBXol2Ri9mGQb8tTm5R3Dg6ce3YmzgodaoeAlT4E75Fw
	 TFjKQm6w62B3rIxbl3qAPYaUhYHJzE2AySxDidLv3v6bPhCfInhmprQ4tTs5CZJ4Yf
	 ptnukHK5wLxepXEJAdtIO6fNS80jMvOcnaB39o5Rm3L8lDg+gqLEhY8JggcJ0JbaXc
	 S03fHbWJ4hDtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9392A393A963;
	Wed,  1 Jul 2026 00:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] bonding: no longer rely on RTNL in
 bond_fill_info()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286521813.349616.3126953661731602268.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:20:18 +0000
References: <20260629173200.469953-1-edumazet@google.com>
In-Reply-To: <20260629173200.469953-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 17:32:00 +0000 you wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations on port->is_enabled.
> While this field is written under bond->mode_lock protection,
> is is read without this lock being held.
> 
> Change bond_fill_info() to acquire RCU and use READ_ONCE()
> to read bond->params fields that can be updated concurrently
> from sysfs/procfs/rtnetlink.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] bonding: no longer rely on RTNL in bond_fill_info()
    https://git.kernel.org/netdev/net-next/c/317cefdcaacc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


