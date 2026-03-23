Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F932D0DC
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293032; cv=none; b=ZnvFKeU6TjTSlJNJbK3GCUDvhXWIbD1bDA8vs0Qqrp0SIN2M15esPnxzL5UQx1aqT6RTTRDqxF/BklTZjSX6nlPCKARqTPlIjOYFY4BvUZt9w2hCsGwRQZEtR2EAwvsjBM1xoiL3lJB3b2X+rXmqH5qvOUhY83eCsUKqjQFq460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293032; c=relaxed/simple;
	bh=Ggsi8u/ozWUrsjZF/5D/PvjiyCYWG8sktgFWsTalXeA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tSawnj3/3uiS6QerXz3WQ4aMl9uMdR60ppO2HA9arQV+YTMJlgQffOsL0IClr2qzCIcZ6o1KKRQfROy9O7vIpxTnT4x9COOVhGbmYbndAHa3d0ndX8en7DDqmH+LNparRj+KzyBuHpmstRsV+yplAPvPjd7IabnN/8+mzdxzS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N31wquxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N31wquxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665D6C4CEF7;
	Mon, 23 Mar 2026 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774293031;
	bh=Ggsi8u/ozWUrsjZF/5D/PvjiyCYWG8sktgFWsTalXeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N31wquxuzChNtkfxe97XGU1yqLpivv5dlQHj3//lend0sRyxR0eLrgQ/qLmrCnF1V
	 4yDLhVf7EZpzunJhtemdsYk+XiNrygTK6OPp2ryrxS1GC46rCT8eBbw7IuFODLu7mq
	 MaOsGRvxCYRkfUyH+k2Cg97/w46kJE+EewBlwGB+dIYGgz1gCSiGcFYw8ArYVYDasu
	 V8bMn5GjE51/iuQd0ZT8+OuYVKckYAyqRZox6ZmxnhMWy1UkcpUHH4p0Jvkd7Fz7lN
	 UdhtUMW4VpfaYtCUK8aZsT3uldxGUaebik5xyRUKeCyhZDC7pFc8SMVPt4yaQG/FU5
	 SGjm67RVodApQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E393808200;
	Mon, 23 Mar 2026 19:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] Fix index calculation in RTTPT2C register dump
 loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177429301954.275706.6715122288074694459.git-patchwork-notify@kernel.org>
Date: Mon, 23 Mar 2026 19:10:19 +0000
References: <20260318083515.375498-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260318083515.375498-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, mkubecek@suse.cz,
 alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 18 Mar 2026 01:35:06 -0700 you wrote:
> Correct regs_buff indexing in ixgbe_dump_regs for RTTPT2C loop to use
> regs_buff[865 + i] instead of regs_buff[865]
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  ixgbe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [ethtool] Fix index calculation in RTTPT2C register dump loop
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=8bb78214bdd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


