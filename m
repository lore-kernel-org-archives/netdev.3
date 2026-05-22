Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634F36165F;
	Fri, 22 May 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470400; cv=none; b=nWkZohjKNcjHSYNyHYXbdrJMC4dH2bnhlzmCqmJjPi+xDj2jpjX4qEfj12bpG44edqj4hziX7IMypLN2rEpKUkAqaBO7fdQI7gF0pG3usXxivxHNnBl7iHJ+fhaSjxy9uk7IJKAzP51vnV+JJHG+xjUi43VC4+aRH8oOq3YjD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470400; c=relaxed/simple;
	bh=GE/9EKra6pE+Z93gdqJYdNy4gKLJecWZpPkswf/xKjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h4KwcQ85qJMD7DeMu5h9kIUCr1TI2vXh2iTTPWK65agk/QRTl6gsIy4g4VUitKCkVtu4qLn8DbPWUnZKCvdNyVdKWT2+vp6r4R/CNwka9FO0PWImVTi2tAwBjzPYNz5qjsM3a2eoOjZa00+YHyx6pNunBoN8FEnHHXKMJ1AhmyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDZvrOsT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDZvrOsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE311F000E9;
	Fri, 22 May 2026 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470399;
	bh=bGO17ps392voexLvcoLP6YI7nu5dUM30VHFuZu0uaeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mDZvrOsTRdXS2VvKcRj/YWko3soTQ1eyGISngGT5dSjtY8i1lr1fsBrFzmww0ACrT
	 VRKR7So0EbwJptySgL10zLfK9xYNQi0Bmu44k+L//i2IMGga8PNqLtVEtZGj3d87LA
	 JYV6lpkbC8QFTSCAiaEwNy4CMkJZewTDHpKaQU81JdoIzNuYuxnghQVmwFdPeQcGdA
	 Kgcnoqngu44IQ40wvA/qKuUQvowXA7kqNV+Q88RW93lnrfA7IssoNXoV568QeFqh/H
	 v4TJcXBbOs2Pksr1k03eox66IQGM07i4wT9CK21cjVe/SgWNWE2eYOaC1ywUqPDIn6
	 kWHa0MVmX5tcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697B3930FAE;
	Fri, 22 May 2026 17:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tap: free page on error paths in tap_get_user_xdp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177947040789.1299893.10534056017366227838.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 17:20:07 +0000
References: <20260521163230.1478627-2-bestswngs@gmail.com>
In-Reply-To: <20260521163230.1478627-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 dongli.zhang@oracle.com, xmei5@asu.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 09:32:31 -0700 you wrote:
> tap_get_user_xdp() rejects a frame shorter than ETH_HLEN with -EINVAL,
> and returns -ENOMEM when build_skb() fails. Both paths jump to the err
> label without freeing the page that vhost_net_build_xdp() allocated for
> the frame. tap_sendmsg() discards the per-buffer return value and always
> returns 0, so vhost_tx_batch() takes the success path and never frees
> the page; each rejected frame in a batch leaks one page-frag chunk.
> 
> [...]

Here is the summary with links:
  - [net] tap: free page on error paths in tap_get_user_xdp()
    https://git.kernel.org/netdev/net/c/3bcf7aec6a9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


