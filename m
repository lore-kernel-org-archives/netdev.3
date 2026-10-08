Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED834389F;
	Thu,  8 Oct 2026 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485409; cv=none; b=VCuHUWhM4ssa1ecHZh2pEiKvR1h0oyB3wpErLHdGrrfyLmaoQM7HylMaKEWSFRstEW+/SNmmORayxZtMqtEtf3a7wkMBUX3AnBkUiAoEF6O4RclKnVPy8uLND7EpS+gAnvyqqsvIdcKir38j1guc3YJvVjFGiJEgGvTb+t5wcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485409; c=relaxed/simple;
	bh=nVv78xK/BtYFDSecsTa7rfKs/L+W2CFQgb1A9wSBAAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LAZIsQnxekg4tWcMfk4HcPq/E6Ikl7xmnREvQgAikAFYFbWKL9je1Plj9FRs7qO+CMRGAAQaNc92UxCS5UbV1GN7RyuwR2V9HPG6SJNMDnbH46kn+LyARLqEAJ+TECZvIcui+gtwLApScvIBjHrqVQEvj51ablL/vIGm81DQr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE9yZVx/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE9yZVx/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8016F1F000FF;
	Thu,  8 Oct 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791485408;
	bh=Yo8qt1FRUgfJcEWLKRCJzBYDZWPuYXUM95tI3F9G+D8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cE9yZVx/O1aBiFQYBExsJKAGQgHQQjzCMKi4YEzT2/QwQofX6KSqPTonZ3KxagxuM
	 Y5/+T1lygl7xcdz4XNZvT+THqZBaZKGKTw1IdkwIy/XsUbjuSgDvU8KpFeSoA1GDYy
	 reSNkGbmRs8mJ344Ue/tJcBgHPQl0/Od1bS7QGUl6At3zfFIlx1RE2tBko4QKz2d3N
	 TatF0CwdC4rhRHYzmyr8fXnOiMg6QHivEb9Hvzu/M+mv28T9La4axdmbGc+qJEv6oy
	 HYoxJeEY5Y9CuTErDCyNWUiOogcUQGyc4T9EuJ9izYBKWItSnVgKK4FqvS4abMRSTb
	 1tbUIuCsXRYDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77378380CEC8;
	Thu,  8 Oct 2026 18:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] ipv4/ipv6: do not warn on route notification
 size
 races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148540727.391001.3522675420264250688.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:50:07 +0000
References: <cover.1791423190.git.4ncienth@gmail.com>
In-Reply-To: <cover.1791423190.git.4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 amcohen@nvidia.com, roopa@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Oct 2026 14:29:21 +0900 you wrote:
> A nexthop group can grow between route notification sizing and filling.
> Both IPv4 and IPv6 can then legitimately return -EMSGSIZE, so remove the
> stale warnings while preserving their existing error paths.
> 
> Patch 1 is unchanged from v1.  Patch 2 adds the IPv6 counterpart requested
> by Ido.  No new build or runtime test was run; both changes only delete the
> stale comment and WARN_ON().
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] ipv4: do not warn on route notification size race
    https://git.kernel.org/netdev/net/c/e02a5b658816
  - [net,v2,2/2] ipv6: do not warn on route notification size race
    https://git.kernel.org/netdev/net/c/c97426ec649d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


