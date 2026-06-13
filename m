Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621ED1A4F2F
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310616; cv=none; b=YyFl9bdbROci+Zp7BLwkDcAKcd3ODVLCfTxfR7wzx8QyQpAh8uZskL2vYF8MPminLs94PHld6PwyrxG5QS8ICeV8sZz+Y2uqC8cNWIVAOp6ruqkIO76+nUHbqVuZxGZDdVdkUF9hf8DtLqHmMKh0C4iV3beptqjS2I37LOYEJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310616; c=relaxed/simple;
	bh=HocRj9BP97CVRe+akO0HmhDSKet9YHxE/MFa8S9bIQY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FBUHO+hlFEMq6YWH0QHJHW4vjTKLhEhWTfcCxVRNQ89vzJW57zmhPmW00zAcfW+yUn8ZMIyrOlFzBBQeZQEqvqZHngGqBoreEOIoHkMibPEgZ6ge+UtrVL2GokeL7kg6hPnbNwLn6MDDYxcv6y8TwEHeBvMCCa810NYaP7VXrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db2przDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db2przDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AA41F000E9;
	Sat, 13 Jun 2026 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310615;
	bh=yutcQ84uAQv/SA13tcZeL6VzdiuI3G2zwMIpkziCw74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Db2przDlQAXJFgWcoMW/oRczInpyATZXXPwMq+4msEyNOr0kOyGwXJgVVyW0izjT4
	 E1swEXxnDmejtQOJjSCyEJ9wwH6tkxnDOMQfSZDmDpIQvO+IcXWlbzPiz4kMoPzhY9
	 PyFcJuW78949xT4oLB5kByhwvIrvgvyccWxHkGCqKJZndueqRF5UiUyhesXgu/gwps
	 lht+lzAUicIVNuk9pA+IlLfufWe6mM4gwL1lTGgrazCGQA0KfNMubYjaxMqu/Oaemn
	 oMs4MDcjYKhb5vaAlgpx5uVY9u5fFBUnpbduzSifwqlyFrM7cMIvi2+HKS3GTTHqDq
	 yJ3L/YJE/SovQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09A539E9607;
	Sat, 13 Jun 2026 00:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] Avoid mistaken parent class deactivation during
 peek
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131061139.1306549.5056558403294785324.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:30:11 +0000
References: <20260610192855.3121513-1-victor@mojatatu.com>
In-Reply-To: <20260610192855.3121513-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, anirudhrudr@gmail.com, pctammela@mojatatu.com,
 ij@kernel.org, henrist@henrist.net, chia-yu.chang@nokia-bell-labs.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 16:28:51 -0300 you wrote:
> Several qdiscs (fq_codel, codel and dualpi2) may drop packets while
> peeking at their queue. When that happens they call
> qdisc_tree_reduce_backlog() to notify the parent of the backlog/qlen
> change. The problem is that they do so *before* reincrementing the qlen
> that peek had temporarily decremented.
> 
> If the qlen momentarily drops to zero while peek still has an skb to
> return, qdisc_tree_reduce_backlog() ends up invoking the parent's
> qlen_notify() callback even though the child is not actually empty. The
> parent then deactivates the class, while the child still holds a packet.
> For parents such as QFQ this desync corrupts the active class list and
> leads to wild memory accesses and NULL pointer dereferences (see the
> per-patch splats). For HFSC it might lead to stalls [1].
> 
> [...]

Here is the summary with links:
  - [net,1/4] net/sched: sch_fq_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
    https://git.kernel.org/netdev/net/c/097f6fc7b1ae
  - [net,2/4] net/sched: sch_codel: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
    https://git.kernel.org/netdev/net/c/52f1da34c9f4
  - [net,3/4] net/sched: sch_dualpi2: Do not call qdisc_tree_reduce_backlog during peek before restoring qlen
    https://git.kernel.org/netdev/net/c/15cd0c93bf4f
  - [net,4/4] selftests/tc-testing: Verify child qdisc will not mistakenly deactivate QFQ parent
    https://git.kernel.org/netdev/net/c/101f1047c2f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


