Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF43BD22F;
	Wed,  5 Aug 2026 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895258; cv=none; b=nqx5fwgObpBOu79EWH4lVo8vo7s0V1pWuvMmz/A2E1WwK6G8nJOP5dQrkHnTZzp5WzFhsUlDaAgZwHKersVgh2W8JAD5oBN9lUhCuwmyKix6cLCZQ2kDD671hJzm3HhCiYwNFWFMNUYyqLAukD8Dh1ZiiLiVdmtbvbzH1WDuU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895258; c=relaxed/simple;
	bh=8XpGkTEsFL0QoGP98NP4iDko5SEqvbqL8efo0yj70hQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NUxsiJBHADWY+dZnM5ezNvFW3UnGvSB+g7bmUOeaCvRUjvPtdUInK/yyBCWgFowrNBHV+929huqO2aViX9nQ3yxGPS/C/PpTaXmbILNMZ9KKk3jFwwDR8Sl0BZtPkfrE835QeKVyt9I4V6QtTq6KYMdJY6wkYyOaemGzgNBrF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqFjuhBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqFjuhBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936981F00A3A;
	Wed,  5 Aug 2026 02:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895257;
	bh=+ehGm+danQ6qBm+NiFQ9ip3o2d9LDViQXX5lHkH69aY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NqFjuhBc5x3vYjLFz/XLQd0HBkpdgMJY48bYSQha99VHxzeUQ29GzbpmOjfbWVqni
	 3O0Tj/rKJk9qqGr+pWqdGrvNoZR8My7LsS052biVJGNYD2lq62Zvi+NC3UFscAEjak
	 Vmd7REBdlMTZ52MDpo+xYm+9ye6qqOo4wFT5gqwoFfl3MwgQXCsdvHCS1iB/ldciXD
	 +CigLU9PUllgYYgjqkm2vp1gEUY5MJJ2/BdgaodF6iVfAg+GAUWAcsk3J6ewc0Qzym
	 n6bb3mazsgLW4qdJ3WXzd6P2D4ZYbJ7+V/yVwkqzglBZCZIBu43BtHDY4Ysv2kFUA3
	 A669fKXRYpPjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AD3926667;
	Wed,  5 Aug 2026 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: team: check register_netdevice_notifier() error
 in
 team_module_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589521763.3873994.11914480099441709531.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 02:00:17 +0000
References: <20260803085943.142261-1-heminhong@kylinos.cn>
In-Reply-To: <20260803085943.142261-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 16:59:43 +0800 you wrote:
> team_module_init() ignores register_netdevice_notifier() errors and
> continues module initialization, which can leave the team module loaded
> without its netdev notifier registered.
> 
> Check the error and fail module initialization early.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net] net: team: check register_netdevice_notifier() error in team_module_init()
    https://git.kernel.org/netdev/net-next/c/c1293e4a34e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


