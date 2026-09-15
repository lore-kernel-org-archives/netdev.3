Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7BF2EEE7C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437072; cv=none; b=pZ7/PC1ZR9EIvBdqjkTr9ryH49pto4QM4oUM8pL6y/r1qLUVFpDe77qP2FvEQ8d2UD+fX2WXuzpZWVGQHV/WncN3R6b0kJVKMrEbt9qUKO2PlhGSClaHg5eK6ShZaIyQjTash1SXLXTPVuju53imh6rNhWi0pNkaePwYokj9GZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437072; c=relaxed/simple;
	bh=Id5ZJLLNBg3qWfuSSgEqiYLnT6EqmbRondKOy7erAIQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qm3m8HnmSJiUjkwjBna4OZ+2hi2pcigRW6/XnSARs7ffehNAv9v5Qe+DlYylsBFQ1WxacoWlsVdM4f8425y12vBeS0MzO6Y26P5glGtQwWQZ4n7lefF9wj/hKV0UUYNOBFtqljpkwmlJSdZ6jZmOZyfXuFa78Xs2ohqGcTg/GFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKbMVAmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKbMVAmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE78B1F000FF;
	Tue, 15 Sep 2026 01:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789437070;
	bh=M8FTGQx4Sie/OvYVgwOPnGh4zBytWrU0tN6gULFHTZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RKbMVAmMy8Hh05XOgk+L42P1xOWRoCM8GHFtKOOACi/CplrfDScTDD7vuNjfm6pVL
	 0rcrUk7XDYWwxqo9y/0ov2sq4LYGPF5HN08JVZsQIRmMjWHYA4DKDZ5sXe22h9aTxi
	 fgq3m7pPZyQXPSywKK4FuUUkP67phD93gDLL3Pikeoshz7ksEtTnNfTi57rqQy2CKh
	 L3jerFeVBceVHxUc/quEa15CQpFRvFKJPygDj8JS0dNrXjxJg97myxkNvHDX09FZm9
	 f6DdXdwGleqzOf3gouSEENYP89+GOJyaoWuABE+XUoEQoxK5sz1oI8AR/bx0hr4zNg
	 vQF3OWW7/l0hA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0E173924FFE;
	Tue, 15 Sep 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] ice: expose TSPLL state on
 E825
 through dpll subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943700563.1306524.4935395370055728466.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 01:50:05 +0000
References: <20260908222428.872254-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260908222428.872254-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 grzegorz.nitka@intel.com, arkadiusz.kubalewski@intel.com,
 przemyslaw.korba@intel.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  8 Sep 2026 15:24:23 -0700 you wrote:
> Grzegorz Nitka says:
> 
> On E825 devices that own the source timer, the TSPLL can lose lock when
> the TCXO or TIME_REF signal is disrupted. This series adds monitoring
> and recovery for that condition, then surfaces the lock status and clock
> source selection through the dpll subsystem. It also fixes the clock_id
> generation for E825 generic DPLL devices so userspace can unambiguously
> map each DPLL device to its owning interface.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] ice: monitor TSPLL lock from PTP periodic worker
    https://git.kernel.org/netdev/net-next/c/e72d09173c12
  - [net-next,2/3] ice: add TSPLL DPLL device and TIME_REF pin for E825
    https://git.kernel.org/netdev/net-next/c/41dfc378867f
  - [net-next,3/3] ice: use per-interface clock_id for E825 generic DPLLs
    https://git.kernel.org/netdev/net-next/c/97bd063c08a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


