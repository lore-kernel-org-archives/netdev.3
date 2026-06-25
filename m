Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAC3ECBEB
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404470; cv=none; b=cYVwRQYEcYYhbYHSiFkSbhCPSmNPa4tikSKzOBzLKcaGMpJknbf7WRy9vdnsv+n5ayBblj+bgwQBwPn/Lcrc2uAp7lHqbkksPTj7j0++XikLYAU3H9bsMsVEJjlUFqwcrA+wkHR8JwpJqyycr7hlrNI9DO7dYRpuH/kZRVAsQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404470; c=relaxed/simple;
	bh=vhWLZBmXfEY+lhFlsBh9pGMj2OEDDPCWIXd47Y9Bjok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f9NSOFrca1Pu3ObolR1Ts1aOSZgbJRXKPwe0tWXtg4r0e+jIN/CkXlnk7IIVIiU07q3XR4uNKMHar+rSMYgo6I+1nXl7JBv0owUGisM2R/jy8TJ6VEOIp9q3AtS53fvPpVh+9+PO9/BqustbWAkRidBXZCOZu78xzQGcMzY7F7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx6y+L8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx6y+L8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9371F000E9;
	Thu, 25 Jun 2026 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404469;
	bh=B7m3d0/w6tTD4LlHYQmeBsc7oVzqN4q7vurJk+wVhTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dx6y+L8s3gF+dM7H68CeY+BL4K/Scx/G5sGKp8bxdxh5UZBwL15PDxTNgm1TJkigm
	 XPz25M89YDUR3KLq5OtE5F4QuzNGvwjmbhgNiiKJdifyZSI1JusiPUpN9vz21wUR74
	 JMMpv/7qKsPekc2Au+Ylw/qh35VcLy1hmc6KltSzlWsFPq5BQogtphPw3wju0u5YDo
	 677sfxXYggfM0u3W4KocYtz00Lz6Z/VyYZ9YpXNjwhwFmb5+wBzsaZJw+Yf3E/p8TF
	 A4nt3mvPWZA+Jw8ytSR8JQOC0JNyXZ5xMVVObNTd5JtB2VbKzSAIhBmD8oKXZsyKKV
	 cGoP8QTJRMuLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568CA3AD449A;
	Thu, 25 Jun 2026 16:20:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] net: udp_tunnel: fix races and use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445700.3803792.9982436899049003201.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:57 +0000
References: <20260625065938.654652-1-edumazet@google.com>
In-Reply-To: <20260625065938.654652-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 samsun1006219@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 06:59:35 +0000 you wrote:
> Yue Sun reported a use-after-free and debugobjects warning in
> udp_tunnel_nic_device_sync_work() when concurrently creating and
> destroying netdevsim and geneve devices.
> 
> This series resolves the UAF and the underlying data races that
> make the fix vulnerable.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] net: udp_tunnel: prevent double queueing in udp_tunnel_nic_device_sync
    https://git.kernel.org/netdev/net/c/ecf69d4b4337
  - [v2,net,2/3] net: udp_tunnel: convert state flags to atomic bitops
    (no matching commit)
  - [v2,net,3/3] net: udp_tunnel: use atomic bitops for missed bitmap
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


