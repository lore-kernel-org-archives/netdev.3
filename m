Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84528367291
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178224; cv=none; b=ESiGHjBa3mtqI0wtXkqx72BSQ4MHxJd6hb0kjJ69Audjy+h8ESlN7XA8fRrUe5++g8YOwlkjuuKPykAq1snQUH2qOvRqWhPg4iaGaa0g0yYV77IGPG12ErGQW2DoTN/JcCzyZelWJce3xie0ar45XvsWgIpchTUiRzVB8CsljW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178224; c=relaxed/simple;
	bh=2j9+SDYjUWCMQ3WA0hukGYSdWQQGvJKE9wM/UKFPZmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AQ+uByN9KoR5BX1K0ACVtSin4RJGQhRZdLvC1y/LJ7ONWKceLzA6SEivkvkQbJlRzQLFAVQ4cYg8Ln+QBdRgGTQhuYQieatm8p0W8hk6FWv4R9sUBWAhL0vvw+Z7qN4oke5i2v9o+iIUhT13FETgFt5Bl8csLGA63Qx0q8IrlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc20cLSx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc20cLSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C731F000E9;
	Tue, 23 Jun 2026 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782178223;
	bh=qHdhSdX4B2wc7LUtgc2dBygUee7ufGmPo/4CRtH3UXI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pc20cLSxLvdB6GCwxMGcmpEVc5Xukef1Hllpy+hddVmzUrOQFMJigmqzJlhplBe6l
	 n/Bcr51c/Ips55PmYOSKrMpAK67O1VESqEbIcCAJbaXz5B8MmETmZwsMdrUjuhEpF/
	 BEl6JanYS9b50xp7vqEdc/upIAf/vRXIjg0vc678PtrW1r0PSXiu1+TrO/H9p9Zf1X
	 1JTXBpb6v9KinyvKLUQIuDbvvoFW5yY7o993cK68gSKiVMuRp3Tz17Wd4S/flkn0C5
	 +zP8f8QLwuAZ5tLPEa3qlcOPJV/EZdb/K5dt5zbNPasOijnk9/lW/4B3IbFl+3hVDF
	 uktwxtPmjGE5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D123E393098F;
	Tue, 23 Jun 2026 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217821357.1493333.11557327325386713201.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:30:13 +0000
References: <20260619045334.2427073-1-xmei5@asu.edu>
In-Reply-To: <20260619045334.2427073-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 horms@kernel.org, bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 21:53:34 -0700 you wrote:
> From: Xiang Mei <xmei5@asu.edu>
> 
> fib6_nh_mtu_change() re-fetches idev via __in6_dev_get(arg->dev) and
> dereferences idev->cnf.mtu6 without a NULL check. addrconf_ifdown()
> clears dev->ip6_ptr with RCU_INIT_POINTER() after rt6_disable_ip() has
> released tb6_lock, so the RA-driven MTU walk can observe a NULL idev and
> oops. The caller rt6_mtu_change_route() guards its own __in6_dev_get(),
> but this re-fetch is unguarded; nexthop-backed routes survive
> addrconf_ifdown()'s flush, so the walk still reaches it after ip6_ptr is
> nulled.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Fix null-ptr-deref in fib6_nh_mtu_change().
    https://git.kernel.org/netdev/net/c/46c3b8191aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


