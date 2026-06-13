Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762521638D;
	Sat, 13 Jun 2026 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310632; cv=none; b=joFa1hpTgRZIwNAUuX0SbSIGHAueZRUtZb9yXj5NOh+CIwnazCC1K4KErSYWBoKxw5KkL1FEqvACWy6he0DALwsYqxtGIR6jaD7WOi6pgbDnmeMq4lk7VnfqdoqWI7AkJAv+7Gok0fnLBR5fgDbwJfBe1RPIk+OGRZWWGl542BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310632; c=relaxed/simple;
	bh=3JkWfIxR7KSgm+S+QDEOfKI2b4F0bUFZNrhL4sJTNEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSbVAqVzB/eRm+1WWYmirkKa7wZpr3SFtuc34KEANMvLPb6peX+Wsm4U2KxGN8YseiieqQW21qVripHGZ2vWQNxkZ1NCfRo83V/nBu+qUX2iD/9QSEbnfjjuJIq69TnsP7o7gVwZp0nWanXwRBdDXV4mer9Encd/QQGWEVfdZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGvaQ1DT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGvaQ1DT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803C71F000E9;
	Sat, 13 Jun 2026 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781310631;
	bh=WMGDE+I1ANpYvbTXCg8Hr3B2oWJc9M49fb5XBbAPXJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RGvaQ1DTBZ3qkQV/1IGM3aWJS2mYSoL0aXS69+4b4x+CIDZBWqovigHcuCg+t5of1
	 W4dYyChbZcSIeAQEksIL5s+BVn4U54EdeqXZ1/meHqMH24HJyJ+fqRylm4PeUaPD5C
	 hEqUwUX58TGIMyv9xWULbFP1FBQXLfwQbS73PwmeLcj0QgmmwGcg+g9MSIAVbgMsrP
	 wm/QMIAqmF0xLW7innrWqjpfG8Z3cf+xv3Lr9W/5n4rMaJVY+dpDb7aTvRVg4i6riy
	 Y2Gsz/zPFeA4dCLD9bOtOItP26JQcnWcm+bkKW55Yle2zb8+ejdC6Iumnbtj/RjzmZ
	 7LDCJ2oPXXuZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698139E9607;
	Sat, 13 Jun 2026 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] ipv6: mcast: annotate data races in
 /proc/net/igmp6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131062788.1306549.10543327145544730405.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:30:27 +0000
References: <20260609081113.7613-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260609081113.7613-1-sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 17:11:11 +0900 you wrote:
> /proc/net/igmp6 walks IPv6 multicast memberships under RCU without
> holding idev->mc_lock, taking a lockless snapshot of two fields that
> writers update under the lock: mca_flags and mca_work.timer.expires.
> 
> Patch 1 adds WRITE_ONCE() to all mca_flags update sites and READ_ONCE()
> to the procfs reader.  Patch 2 does the same for the timer.expires read
> in the procfs path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] ipv6: mcast: annotate data-races around mca_flags
    https://git.kernel.org/netdev/net-next/c/d0dc208808a2
  - [net-next,v2,2/2] ipv6: mcast: annotate igmp6 timer expiry race
    https://git.kernel.org/netdev/net-next/c/1ea2f885a76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


