Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D7214A97;
	Tue,  3 Feb 2026 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081022; cv=none; b=MmtUKokIDbdZITX23Fm7ryvQyoDG/DCnh9J3ZcW7zoGeEqsn+0HxOzE6YHSgyyj4AISoqY7lQZAvhy+gOqlWAKSS3jMYJs6yW4VvW1XJT/ryRJIUS54JBHrZco9seqX7opUGPolsA3rKh0loMISk2cgkLHZKmD6mM+abFutFGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081022; c=relaxed/simple;
	bh=eWx6elQkFDo3h1d42/U2wvpsYOLwbGMYG2305haSK8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B88hnmrP6GgjOHKutRPhbbR/9Ph8oOzBUwN5s7h1Kh8RBEBK1Wj2rMK6hrK8leOGQEUY5VZhiqDJRftwsjNVsxd/Cxq7x0W+r8ZZJdkraKofwHdRYGjCbnYbJ0o5mIIey2ngIIG95zBqGkadYapqID+kXWyM6id4wuRPYfixcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkVZXB5y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkVZXB5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BDFC116C6;
	Tue,  3 Feb 2026 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081022;
	bh=eWx6elQkFDo3h1d42/U2wvpsYOLwbGMYG2305haSK8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZkVZXB5yFXFqISJIsYksqNedMwDcbttbG2nUkv1WSuiZCJH4sgxQxTYGumeURLQMI
	 t6DyvZfs/7FNpQaforRjkUKUZTIR7cju/EEEAJQbIh0i+DapFTQkqqwsUsqjIsiA0i
	 XaBtKTZ+Km7y0kh6IUh7+lazb+7LwOWohpWadnYrbelN7DjMnXBfZssF+bfhexGvd7
	 uns5GWoPEWTHQUZg5wuYA5zrX/zMHFehdVxUvtzGfeir5f9ApF2WnosUR5o2oOiOPF
	 pDC9YUgclS8QxiDdrz2x05ZWaRMAuMEn1Po+2gZOGZqgFOrODaLQVOYYY2NsJ9xU9o
	 kZlB0PcZJr5sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16DE03808200;
	Tue,  3 Feb 2026 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net: spacemit: display phy driver information
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008101862.1258089.4006150419249084980.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:10:18 +0000
References: <20260201100001.33102-1-amadeus@jmu.edu.cn>
In-Reply-To: <20260201100001.33102-1-amadeus@jmu.edu.cn>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: wangruikang@iscas.ac.cn, dlan@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Feb 2026 18:00:01 +0800 you wrote:
> Print the PHY driver used and interrupt status after connection.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
> Changes in v2:
> - Simplify using phy_attached_info()
> - Link to v1: https://lore.kernel.org/lkml/20260122080001.73921-1-amadeus@jmu.edu.cn/
> 
> [...]

Here is the summary with links:
  - [v2,1/1] net: spacemit: display phy driver information
    https://git.kernel.org/netdev/net-next/c/fd102acfd362

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


