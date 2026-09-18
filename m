Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A123C1F36;
	Fri, 18 Sep 2026 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698078; cv=none; b=C5t4qeTbDz6uLpnSX8KeyTOmb4vChsmerHrt0iPE7KqxW9Y4Z0+50QNKjGM3dOymHhjqFvhrQkBXq405fEQNtfb4PD8edLcWZYGnpFR7aqTgrQFo3D2oRli7zNFmGcB+o+gg4iqFkIOQKzUuFpa39CcP4nChjhAF3feOnipFavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698078; c=relaxed/simple;
	bh=IWIE9ITQUbEX2rhLkNY4A1pPXvOhUe3mpLGYcjD3H+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vB77wkHaeWeaiEDlXqann7TlGZLNX/cx6ByytOT0J6irvOYnKIbl2aktzi+yy5JR+/GaS5nZ5WpMLLzgrDF7G1bIBBNIfttN9HpT0FXclzeJ+MNB06JZA1y3WVVptXoH/+k9RadGb7+0pgV0fRSVpclR6CNAV3AkI9eQIoO1Gko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPblNWnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPblNWnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039741F000FF;
	Fri, 18 Sep 2026 02:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789698071;
	bh=zdIHct5+CdWLZDz9NehcVJAXm+AdWNRl0nhETEl0jtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VPblNWnxyO3SB1orOv1DobTMs0C3Hgnl5J65hdP/3N28c9Q6ZzD/rnPIb03mYSeRw
	 wiSWAT9zEXKrgaEANYObj25HJn69kH719kjVk3iLHzyFtcz8AUKYJNgPeFE+yCxr40
	 vkZjHmL2jcwPg2fSadeyFbDFuIVDVKxD8TVpbDWQf5ZKlreZEcSEFHG5rPdbwen5I4
	 dG+dJVnevgqh5m8pZNYP7dPMW+ZL5rN3vthTB5mw6rZv4lNvnwuqsFVovdx6TnrVf+
	 VvYmnHdcpGvgnreYMfK48f4rp8syAnRLsrwB8wmhv8lSvZ1SdSb14RryUrmhBPEibO
	 V+VV05WCPDvvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93925380820D;
	Fri, 18 Sep 2026 02:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4: fib: fix data-race and stale genid check
 around
 nh->nh_saddr
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969800438.233063.10154141271443227227.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 02:20:04 +0000
References: <20260916125316.988044-1-xiaolinkui@126.com>
In-Reply-To: <20260916125316.988044-1-xiaolinkui@126.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 20:53:16 +0800 you wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> fib_select_multipath() compares nexthop_nh->nh_saddr against the flow
> source address with no lock held, while fib_info_update_nhc_saddr()
> stores a new value from another CPU as soon as the preferred source
> address of the egress device changes.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
    https://git.kernel.org/netdev/net/c/46bc52d13594

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


