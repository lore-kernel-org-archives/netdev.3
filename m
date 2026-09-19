Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CEC34DCF3
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779078; cv=none; b=nAgz5e3msxDa5KRdtTIk6quTHrAshr0u1eKhO9gZVrQDJDx6lx+zhr3luVdaGT2Thsm45OkGjAyG9GfumKg3ngt6I14DNhN+yzY6JIeoWbI3fsOJwCgmKMoLaWjutMwW2fMtnFfMKSP3I7JxG0C6A/cUUHluuRqtUtI4VfYGSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779078; c=relaxed/simple;
	bh=GnHoQouOvKMTbjCRHCeTOAaL7sSvKR+hwVSWJC1isZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i1lCjykOFQysVMOqo/WoNMlSiVYHZtHkGRTQ9NfZ024E6e/a4U+CiPZT1m7c/CoEvZ0bE7KjrN1T18GMPOiCrw7uqxIh2WnRbbzcoe3/WMuofJMe8/w8FI39fQqoz48LMNo9P0oR/r8jMtLrHUM0BBITtY2pB0yJ5xfVj8Z4vpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXsk0L6x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXsk0L6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB741F000FF;
	Sat, 19 Sep 2026 00:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779074;
	bh=X/QdDfpU3vJpG9XQOeMpE+8D2F2aDi3Wd9qfYZLs3q8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FXsk0L6xx6M6zIBbOGwxdOY7OBHWTm+ZQIwzSqawWK9ivbqSIx7arczNnIXwo6NMS
	 /RXGO+Vb8GzxIwLzrV52zcXRol4RYq43e+se9dBDoXw+T4grTZUsp0tiAKC3P17OS6
	 LE/v+YdVx/aVOG5u3244zCyq7ypW9KC2lrW/1EmhJ2zq8fZg7gIo8RasVctpMksAvu
	 dv6cWAetfVehDHu4APgwtO3XqfXGcRmVMssquUdvPlSdwsp9CjHw/ZjbxxS16kyQXN
	 4ahhAeprWfufvHyGi1ZwRvo5WFI/TztAThxXxdWvNfCQ6tTA3OIHSfAr5mZkviQOPY
	 vN8TgmB5FTILw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B593811978;
	Sat, 19 Sep 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2 0/6] eth: fbnic: a collection of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977900764.1211687.7729513962292415375.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:50:07 +0000
References: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel-team@meta.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 14:09:48 -0700 you wrote:
> This series collects a handful of independent fbnic fixes for issues on
> released kernels, plus one core ethtool fix needed by the fbnic offline
> self test.
> 
> The first patch keeps rtnl_lock held on the ethtool ioctl path for the self
> test. Since the ioctl path became rtnl-optional for ops-locked drivers,
> fbnic's offline self test (which brings the interface down and up via
> netif_close()/netif_open()) runs holding only the instance lock, tripping a
> lockdep splat / ASSERT_RTNL and reconfiguring the device without the lock
> it requires. A similar issue was found with Broadcom drivers so we expanded
> the scope for v2 to just have the rtnl lock held for all selftest calls.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/6] net: ethtool: keep rtnl_lock for the ioctl self test
    https://git.kernel.org/netdev/net/c/1b82958f3f03
  - [net,v2,2/6] eth: fbnic: Handle maximum standalone channels
    https://git.kernel.org/netdev/net/c/1f4c73064a50
  - [net,v2,3/6] eth: fbnic: use the Rx queue napi pointer to find the napi vector
    https://git.kernel.org/netdev/net/c/b5d9e9d4d0c1
  - [net,v2,4/6] eth: fbnic: reset num_napi when the napi vectors are freed
    https://git.kernel.org/netdev/net/c/4bcc4a92c603
  - [net,v2,5/6] eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox
    https://git.kernel.org/netdev/net/c/8947f13e436a
  - [net,v2,6/6] eth: fbnic: Handle FW mailbox completions flagged with an error
    https://git.kernel.org/netdev/net/c/1b97a269a5bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


