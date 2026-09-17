Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6F556E07A
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 14:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654275; cv=none; b=ax+Utcxk9pPH7hj+9JMdi7PhPgtqFxGzRMgEpviyTNVCnHxZcWc09ZB9S3x1WPU31q0/TEje8ljyLWIGF2m9GghjHV9ck5rnBIteHRitsOdoHGbKwyUBecdRcozGYMDDHjohqDnCxxFdWW3ebiuHu/HrSs+/zCZD16jIOwqWgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654275; c=relaxed/simple;
	bh=f8GGQqUIs6poa9a+2WvqjTeZScS5vg4UHoDdOjTNkl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CARrKjejpqCGjGoAQhcppYrGW+tQVqSpV/lRUtTN1QpedL7OIkyXWFEZ6Z0zT35DEQkBqecE96XnOAxDFqXJD9NndwuiPOK2MICyLp1O8EFkVIK/+oWGhlaUrC2NlCb+aUHFMkbLIM1M+ZZxfhl/u/f+kVLpNlxNDDV8UMrt18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6cEfyNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6cEfyNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADA51F00899;
	Thu, 17 Sep 2026 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654270;
	bh=3hPSlW+5bPRNx90I8VWRlCGFBmOPXx4P3Ds52i9tSvw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q6cEfyNkmFQ5W58j64JC+5PJ9oEb0jo37vVqASvJTkRSftieAaJJt3+SiC1HHZkgi
	 3lC7SX8TstlpNmoouzvwUQmG/HuNt1C8t6E0mfzEL0AUCTDeGOfWNaUWBpEzqZ0YLh
	 R/XJh40PR5my20QhPuz6mQTJnYILfHbvzQDorQVmgBy9g3SFP36SDIX3nhAVjjdSCt
	 9Z6vJaYMXjqbW8I5Vokzqt3PXKtwus26Thya/46HOtXEp5xWiUMRARoWHzEFnhtwQH
	 nLKfE76G4JL5kWp0Ic/dlCViPQlbOlg44X9miHHp+zSSZpC1n1KcH2cMjM3FBP5wf+
	 m8gr4YuaTvNNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9394E3811963;
	Thu, 17 Sep 2026 14:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: skbuff: do not leave stale header offsets
 after
 pskb_carve()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178965420436.3666036.16664494711129043025.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 14:10:04 +0000
References: <20260915130423.3956471-1-edumazet@google.com>
In-Reply-To: <20260915130423.3956471-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+586af68eb819833c2d91@syzkaller.appspotmail.com,
 xuanqiang.luo@linux.dev, achender@kernel.org, rds-devel@oss.oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 15 Sep 2026 13:04:23 +0000 you wrote:
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() remove
> the first bytes of a packet and reallocate skb->head.
> 
> All the headers that were present before the operation are gone,
> but both functions call skb_headers_offset_update(skb, 0), which
> is a no-op : skb->mac_header, skb->network_header,
> skb->transport_header and skb->csum_start keep their old values and
> now describe bytes which are no longer there.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: skbuff: do not leave stale header offsets after pskb_carve()
    https://git.kernel.org/netdev/net/c/a5117e1eccac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


