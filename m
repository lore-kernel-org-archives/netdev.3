Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741492FE582;
	Thu,  2 Apr 2026 03:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100039; cv=none; b=tdsq7MPimopNXrJIH7nl9+gRarTGy60eO8TpgUuOHX7QT+emL7WVFNxJsObIRAc40g2cZVaW/gU30REn+/XTchMn4tTZOYJE56VTpQWW+z4SYK8vs1c6j+It20cUM8jND34I/O4tvtXU3ybV1a8WVPJfN30azbhR1ZA4ZSNQrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100039; c=relaxed/simple;
	bh=U1drkp4VsQOM4eyxEQYrmbwNYuTKar6oepiZmYI2kEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oHQv6Fi2MyAFpNO7Cw7KTHEeC/XkEYD8pt/3xH4yeF7Bn8jyQwYEe/62Rm9YhoNnzsg0bzb88R/izrmZz7CCjXCyAicW7vDBzmSlaaVLRG5EW+hrsY5FqxcgOLt7+YdjwV6++XNqMNTWtzJ4TaXrd5GBCz/sm56ZV4UdKEF8R88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYfjzlYI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYfjzlYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A98C4CEF7;
	Thu,  2 Apr 2026 03:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100039;
	bh=U1drkp4VsQOM4eyxEQYrmbwNYuTKar6oepiZmYI2kEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rYfjzlYIre3sRJjzuexCejIwBzHWln0V1pu4+OK66WlUKRdBxvvE88hTUoqcWLJWv
	 kBCWqhVgJ1qS3ys4mY3NuY9rUQwtCaMJJyb9MP4QbXGRNbChDbe4IF1oxJRLlPfTXa
	 vgZsUVg/4J6iNCJ6toGFbkkWkHHPl21DvAJDe+t/Ck/6UrILGJiTQ+d/E9JfwwSF8R
	 iB573WdvHYSQaYkUBp+yazra+uEui/S+bYUiTCsqma85pCCoyqN1mfenTlM63SD8u8
	 rqc85gIE+zhY212w4yZB9Q2PjgMpTM9REoc8esbycnF16dTX4UzgjpYyZDEnTskUhF
	 2PJQXMx399Ydw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0310E3808203;
	Thu,  2 Apr 2026 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Octeontx2-af: add WQ_PERCPU to alloc_workqueue
 users
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177510002178.3972881.5176782520959749296.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:20:21 +0000
References: <20260330095405.116990-1-marco.crivellari@suse.com>
In-Reply-To: <20260330095405.116990-1-marco.crivellari@suse.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tj@kernel.org,
 jiangshanlai@gmail.com, frederic@kernel.org, bigeasy@linutronix.de,
 mhocko@suse.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 11:54:05 +0200 you wrote:
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
  - [net-next] Octeontx2-af: add WQ_PERCPU to alloc_workqueue users
    https://git.kernel.org/netdev/net-next/c/a77fb1ace44e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


