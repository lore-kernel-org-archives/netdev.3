Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0383093CB
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308223; cv=none; b=BOde51HTYzROkbvE7LR7hZGfQ7JmeqnzenPV7xGVcQj4QlsQP+HGDCvABc7Rk4fqPpN2M3be84aXW1DWvvpOiTiBEWxwh+E7X2ZTu0X5rH4WEsSYKQS1Vzxbe7BQ61ql1ak6LEUw9uvoDhxJfguuvtF/0bK8iLUMgHnuA7aNLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308223; c=relaxed/simple;
	bh=IVVdF5BLLHLKIc+d8GS4Jfg8YQxG6sYa1gbVYCuBL5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ERqvAie8T54ry8VMnbQjws0ca5iFa/J9Qb+t47n07nmAeeW1LpXCegvJIsfDjcKumb2Ew9aAsNrUhhlAyF+SNrgp7Lx+x8Yh+RN3ytDHoTRG6MwchKBNydEz1SQfVSi2BgSOAB7ReWy/HtI5CiZKGXMH61PyQld1Bia9iBbn3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6SmHyOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6SmHyOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB241F000E9;
	Fri, 12 Jun 2026 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308222;
	bh=3id+KPUKhUfmISRd7HeWxNof57eI55DCfhscIDSDd6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H6SmHyOLf+4KZKha9m60uNr4+fLI5TtY8QYpGmmlcyC6YsqJqJHD6l0Nvsl7HySRI
	 WVKGDeyeN2Y/454x0OuUijmAl19v33q3w/h1RKSa/zI5HrpblowmCo3b00Fi2eBTvt
	 fozi6nclqyJGsMG64s0DqPkf7wsw+8zJbzu18mNOTKbtWLn01sHMghGenyc9/488o9
	 Mykp7Qv9tHIsF4Lqw6CJas8dwAexFB0eFTYYWBEJThQYy976W4LuL7s7Pq/Q1VrbHt
	 I4pgmSQfx21sreJF73lv0LEgo+d7u9QNFHFudvvUYBsR/YnQDhgorKZ79lRLdpX2Ws
	 erEiCOv3tk+BQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196A739E9602;
	Fri, 12 Jun 2026 23:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130821863.1294761.18239678273101914313.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:50:18 +0000
References: <20260611200355.2020663-1-kuba@kernel.org>
In-Reply-To: <20260611200355.2020663-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 gal@nvidia.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 kory.maincent@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 13:03:55 -0700 you wrote:
> mlx5 throws ASSERT_RTNL() warnings on timestamp config, because
> it tries to update features. mlx5e_hwtstamp_set() calls
> netdev_update_features().
> 
> I missed this while grepping the drivers because tsconfig goes
> through ndo_hwtstamp_set/get, not ethtool ops, even tho the new
> uAPI is in ethtool Netlink. We could add a dedicated opt out bit
> for mlx5, but NDOs were not supposed to be part of the ethtool locking
> conversion in the first place.
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: tsconfig: always take rtnl_lock
    https://git.kernel.org/netdev/net-next/c/f48cd5b47bfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


