Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8B309EF4;
	Tue, 29 Sep 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646011; cv=none; b=MuvZ8XoXHdHuRAbxQf20zU2IC1tcmrvpCf/W4JIoR7UqiQ8iGJwAvuO65ys4+AjSzzysPbsXrUXrAWTPNJz44MKj/qNw1jC7+MJUrOZhr2NUUcjhaftFSs5TZS/viK9gJgE/ecS0M96yydfojAREoOq8Ug6gQ//dhq2rVeoY4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646011; c=relaxed/simple;
	bh=hDSkpEBx5htAt0Jen5h4yV30B5Q6hgLsZJwNsek9G3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jZrz+tKPdvXKDsB9gww5l8Q7dnqtSv3Ot+jxdThN0EKrkj19UfyX4pjOlqiwfRPSE+Q0xQnTso4w/y9T3wsbpyEABcxHSrK3MIye85FFJzwRyKgWteFBwRJzefJfMhZZIMdodFqWd0ZIOqRJPkfrZ2PwBT+VU5viC6u9NPhGOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPwVbEFf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPwVbEFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC801F000FF;
	Tue, 29 Sep 2026 01:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790646009;
	bh=5VD14jCxKJ7vZIYo+tRGexic9zikLAGryfEKlPSvv+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SPwVbEFfPBg6JqGZq3yan8y+1cSSGHFJszCUBOCBCAo/EvPqBTcL8C+nVCqlA/pPH
	 b7haiuRgjkjz8BzwgZfSS2CeRCDwMDExg+ja+oNUobwb0CpDtMWJrY4vOlqaNqcDx2
	 fiVDxPvn4r6W2DVftWLEO894TPoMwerjYDd8Tk/hDFy0/059nxrvgm6qmwWPPAcfWl
	 lUD5DbbAg2Y05mRxnmJJVDYGSZeoKQP8R6+BYEZFRN/G0GsUWivuYpMc49NZGaLuAn
	 IUJV7YrGh1LX/kv9vaAaMyVpNp9BlnFMWUEYblWTod/rQU3mYfxk8PKEy+JgyzTXty
	 QUwQ2wgdDlYjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44FF3924FED;
	Tue, 29 Sep 2026 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: page_pool: fix use-after-free in
 page_pool_recycle_ring_bulk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064600827.210624.782407942985329924.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 01:40:08 +0000
References: <20260925144127.1445667-1-almasrymina@google.com>
In-Reply-To: <20260925144127.1445667-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: aleksander.lobakin@intel.com, kuba@kernel.org, toke@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kaifengw@google.com,
 dongchenchen2@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 14:41:11 +0000 you wrote:
> With CONFIG_PAGE_POOL_STATS=y, page_pool_recycle_ring_bulk() updates
> the recycle stats after dropping the producer lock. If it just recycled
> the last inflight netmems of a pool being destroyed, page_pool_release()
> can pass its producer-lock barrier and free the pool before
> recycle_stat_add() runs.
> 
> Commit fcc680a647ba7 ("page_pool: allow mixing PPs within one bulk")
> moved this stat update after the unlock. Commit 271683bb2cf32
> ("page_pool: Fix use-after-free in page_pool_recycle_in_ring") later
> added the barrier, but only fixed page_pool_recycle_in_ring(). Move
> the update back under the lock.
> 
> [...]

Here is the summary with links:
  - [net,v1] net: page_pool: fix use-after-free in page_pool_recycle_ring_bulk()
    https://git.kernel.org/netdev/net/c/bdea4980182e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


