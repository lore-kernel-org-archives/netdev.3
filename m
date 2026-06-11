Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264573AC0C0;
	Thu, 11 Jun 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176810; cv=none; b=AYDSZvfVv4OUkhQMe4WpktWckMNWPPvgUceQ+6GIb3L0S3y/7DYGEHICSxuQNp4ZOI2BaisVPZ5MlVqC8uHkLfzOBHuj+ZM0+HIaLHXm1jCzVVNZSoEHxehsdSqcKkzfOmH5uy/9oTV0i2nu11l4O+WRfReDoFAUGfgn6KqyTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176810; c=relaxed/simple;
	bh=g3JgkfXBMwpC18V6g6fDnwfCNtQ6vzyJMSGyqSOOr64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k/zEoUkd20NrAjJidRGK0KcQ5sMEukYzN4Keg6qFliZfglDy5xgDTMpf4xP0raG/l8hj7D0ZswUqL5S9z/tYoJ678PJJ/jrCgsdcMDx9mIsOPVkwFB9bUXI+Ck+m9S0S2Wroas6cUhy7qsZQcWWwVW0Jsrs2ignlSTFSwogjPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeHU5Lji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeHU5Lji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99A91F00893;
	Thu, 11 Jun 2026 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176808;
	bh=YoGEhcljlTisdlPc7HQjkmQ11dvcikGiFBdlVDn4BMM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oeHU5LjiLy9rRJ0e69xvgnMYM8BldE/6ipTIB/7zBnrYhEAkOFIaMZa+FjXypd0g2
	 9MMMI5ZjaVTgBbOA2j0GPrjJEweEv/lbisqSKCz6yAuAlng82OUw0K1kwnCE10QT66
	 HygrEXTIafSzPgwcN6GepPwgFR4RJcA5nSvnfRqA0bUy4wQ4HOk3gHNobN24cklR0Z
	 Eq8Tkl5It1/xwtCcuFGk3sJn48mkbY3uay2YXAtpEGJTjJjzAYmJDMOlRJEwcmHInc
	 6bQFkVXPAKJXR3ucGM1DX8k/hYbuveSzr6CIOvUU58a642yipTvAosrSUYlfMoO6hz
	 dgDGmjtpYnCNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569E93930E4C;
	Thu, 11 Jun 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix IP fragment flag corruption on
 custom
 KPU profile load
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178117680589.3906453.14413268313223181159.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 11:20:05 +0000
References: <20260608095455.1499203-1-nshettyj@marvell.com>
In-Reply-To: <20260608095455.1499203-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rkannoth@marvell.com, sumang@marvell.com, kirankumark@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 8 Jun 2026 15:24:55 +0530 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> npc_cn20k_apply_custom_kpu() overwrites KPU profile entries with custom
> firmware values and then calls npc_cn20k_update_action_entries_n_flags()
> over all entries.  Since the same function already ran during default
> profile initialisation, entries not overridden by the custom firmware
> get their flags translated twice, corrupting the CN20K-specific values.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix IP fragment flag corruption on custom KPU profile load
    https://git.kernel.org/netdev/net/c/7360b9609980

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


