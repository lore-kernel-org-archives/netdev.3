Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F003D170E;
	Thu, 10 Sep 2026 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045868; cv=none; b=b/D2NePv8zusRR8mNJZK+mjQuOrE5oEAeVy2yc/LvaiMRBtyQwt0M7PhrhAGjFqfp8nzmws52MQXLkjd588nfmqweHBM5wACgqfzQuV9Rs6oO+y0xuITwh51edwK2AbUTi6RZ4sGIbTowzkdULTHiLnKoAvhneNIziQy093MGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045868; c=relaxed/simple;
	bh=ptSGf0EUtsfrMZTPGWMfTo6lCx4wCQ/8IAvvrStwIMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oXSSiAQmp7bs0SDzk8aeKkpKp4H9vF7nsFa4IKOL6KSXalT2wi1/hq4T6MeoRDcrtELBtYbLVnP91SaDSBvL9+VgmOSbIZPTm7bqejYzrHkW1cWS/ZH7vJagf0jls3mF+F3MV4Vsda0YD/hgpvkI1KhSa0XYCqgTsiN7++xOuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGU1uwJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGU1uwJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41641F000FF;
	Thu, 10 Sep 2026 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045866;
	bh=HaGfmYDszDSLRdVM6Y2Wg5A2EzV5xTQOnEP5vweaA6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DGU1uwJG4cQcOk3wRgbnME93seAi2Qa5pAXiEypYhSC/PZkwYl6ydB0tGDBSX754d
	 FYQurFVo1UyjJglxTk7zl+BaXVaqNWdbYA0QK2UOlgqQfaDx5tAy+4V+CCJV94BVSq
	 KVyJ5vzHCk1waqnVFOUyVUR/SvYZRj3UKNdFvtpehnemqQ9rACdRObztE4IdoSsgUF
	 8uZpohbreGMHWHMGg4xZ+3l/HENCaG2BvCgKs+TVQ/8VuX2Jdlu+cc8JVdA1b/siHJ
	 HZ2T2ymuxKCjJdHgx/HYRiPeUTkHVpwCT+tdPcXLnH6tAwj9lnHyboltbJQsa/qwZD
	 JtDrgFG9LVzVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B15380CFEE;
	Thu, 10 Sep 2026 13:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Octeontx2-af: Add WQ_PERCPU to alloc_workqueue
 users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178904580439.1422676.5412022463759175920.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 13:10:04 +0000
References: <20260907094822.121457-1-marco.crivellari@suse.com>
In-Reply-To: <20260907094822.121457-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Sep 2026 11:48:22 +0200 you wrote:
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
>     commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>     commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
> 
> [...]

Here is the summary with links:
  - [net-next] Octeontx2-af: Add WQ_PERCPU to alloc_workqueue users
    https://git.kernel.org/netdev/net-next/c/ae768e41c03e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


