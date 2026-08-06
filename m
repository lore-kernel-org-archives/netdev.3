Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D837FF41;
	Thu,  6 Aug 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035088; cv=none; b=LcujR3ptMTsXhF975ecelc8E+hiBtdtzw7XJT5TeSwRBSDzcqExVnOa9Tb0ggCplgL4UfZglsIrabYTcZuXPtXIWsosZnlAcGLWgtpITZtl9sAmvS1Cup62DoKFrurZd8v2cEmkzz8w3Jt3KLRFWqGp85pIrC96ZxP9ya22c1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035088; c=relaxed/simple;
	bh=46BIHVoqFzJQOMA28tW7wGzS6BMe6cdehwNM7VgIdUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZRhYd3saAK5NBZJHnfCAL0KboWw/vLydDBFZdFxi2il6cDkzo0JP5D8RKb5RA5eazQi4fKTRDeinLsqhTWT6MvhI/TNYVMyghH4IEvWz+EMv2n2kmKW13YC6GQlLrcM1LJUkWTVC71kMj1ImacnVNZ28loOJwMCx5riNK6LWUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOgLpgsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOgLpgsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2271F00ACA;
	Thu,  6 Aug 2026 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786035070;
	bh=W/bRh8moy1kxdIX3Zas3SghuIEWFKs0JxEd4NqqKUQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eOgLpgsA7loHIQYsA3JdfQ7Tf3LBRPj1tPnwIVnqssYi7bvVNbM1Yveq+ZMt+/p5N
	 /8/jddaVPbHYoEOkTNWkHHjH3s1A0LzZunyerSt++HbSZe61RqMQQ4T1Texbg6lLm8
	 CBFfNDJs/P0tVUJf+qfrggXiyEEyRdu/Vf88wcs07q4CDjKh5EPgYHoUOg3Dv9CQUk
	 NErasnCVdU9EumsAcF6QPrM3EZ0HU8Qs1poARp1eKoamo1jz2X2TGLUcGjCoCenZNl
	 9DjJHTOKv0dbW1GZJocjdRoVKpIH8xs9nbcmOQH4Ylot03oC3g20e3Z3Q3PqkWHz9A
	 sW5cGDBL4WNkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199BD380820D;
	Thu,  6 Aug 2026 16:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: Defer netdev KOBJ_ADD uevent until the device
 is
 published
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178603502963.1375455.13217677789461225888.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 16:50:29 +0000
References: <20260806080758.2039586-2-dtatulea@nvidia.com>
In-Reply-To: <20260806080758.2039586-2-dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 sdf@fomichev.me, tariqt@nvidia.com, shshitrit@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Aug 2026 11:07:58 +0300 you wrote:
> netdev_register_kobject() calls device_add(), which emits KOBJ_ADD and
> wakes udev, but register_netdevice() only makes the device findable by
> name later, in list_netdevice().  A udev worker that reacts to the uevent
> can therefore run against a device that no lookup can find yet.
> 
> This used to be harmless because the ethtool ioctl took the rtnl_lock
> when looking the device up, and register_netdevice() runs under rtnl, so
> the worker simply blocked until registration finished. The commit in the
> fixes tag moved the lookup out from under rtnl for ops-locked drivers.
> Now there is a short window in register_netdevice() between
> netdev_register_kobject() until list_netdevice() when the device is not
> findable by name.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: Defer netdev KOBJ_ADD uevent until the device is published
    https://git.kernel.org/netdev/net/c/8e63c9e6179a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


