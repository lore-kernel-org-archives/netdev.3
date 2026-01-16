Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007433446AD;
	Fri, 16 Jan 2026 04:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768536253; cv=none; b=snpM5v/MFAY5AyTv916CGRpbBXuM+vCxh4LICMZpzqjahSbIVtJasbxhcWHbphqutaOQfoAdlleS4t3h9zzPcbdmOfS5RmCy7+o6jnbEZeWk8wbeq0Nq9nzfxvwHmuBukjwG/zAgeOzR2ovqj9oqVtfFBwoBMyKhl5vBaC/pVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768536253; c=relaxed/simple;
	bh=6j04D6Bfas7Iqnbk6Ue0emn6tbmUeJEMvJl7wNwwmz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gjYvatvTQgJ3QSo/Pc/33wwg/aDtr1J9AxpeiM0+ieJL4lHBgW2JotieE9wk9MOMD/+VtFqODuvpDHEHDOuQKkNWKitqsJ1TLZFeym/ZUxzpAFD0jS0u5SxE3nKUwny+ffjawG3MXvsp7m82CCzh1uJtJokU+68ULtMugLoPHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gou8Y0iY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gou8Y0iY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85B7C16AAE;
	Fri, 16 Jan 2026 04:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768536252;
	bh=6j04D6Bfas7Iqnbk6Ue0emn6tbmUeJEMvJl7wNwwmz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gou8Y0iYTYojcQFdkm49LxwKtiWgGPTYDiUThVTDOoxe3+g9pNHXuq6ZTh1wKSALE
	 /nfJ0S7GCdZ/cQQyYSefnEy1W6PzA7f9HX0xvqhJepg9FpC0hfbgJzc1RdPbzCXPJ9
	 YPxwohkEL+FuuenM/YbjGyp0FolgeTsNMajlhIH7kayrztnSGTxTGwBQlBNKJJpgGB
	 7262FGozelSNj4jhwxYg4qIHyNT0ZKhGsAYENWIbupnw2U7VOjQSebi/ZOjtpuKxce
	 V3E0k2FC27l+MnKHIIvaD2RAOw6CqIG+QBBI+oq0+0jesiDO/FwuwLPx0J28/DttFq
	 85iHzii5AMEbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F29E4380AA4C;
	Fri, 16 Jan 2026 04:00:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hinic3: add WQ_PERCPU to alloc_workqueue users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853604453.76642.15885305360661736174.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:00:44 +0000
References: <20260113151433.257320-1-marco.crivellari@suse.com>
In-Reply-To: <20260113151433.257320-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, gongfan1@huawei.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 16:14:33 +0100 you wrote:
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
> 
> [...]

Here is the summary with links:
  - hinic3: add WQ_PERCPU to alloc_workqueue users
    https://git.kernel.org/netdev/net-next/c/48b0126da665

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


