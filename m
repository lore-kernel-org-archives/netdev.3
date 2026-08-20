Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4D2DB791;
	Thu, 20 Aug 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254287; cv=none; b=nxfDbNWr6ieXYJt0CKhcd66N9z+t883Yn5JCrIngCFY5Uxh+D95HTD6gbN/wjnUVcqhFrH+jwZO4kTe/x7LEKi6c6JCv2FBvWtSlLzLgmbLeM4sWLDgnWdMixOUn+bEtteLYGS+LJ8QDw52HpGTsldx+W7TM5PxKkV/zj8x3Zxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254287; c=relaxed/simple;
	bh=gGLpVWNhQcE8HfPGtaYrba1owKY1kBm7L0UJmKHdBSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j7uXf/t/eLzktBuuoVpLTwCs+JgRi2fu7LtSjfo2FVJd0ADNJRc6iSpmEWvCKwRWa6vX8v3BFXiklrUbjPhU2N6iP1bhyDOhIwVRiYpa8cujVzn+8lB73qxNQZF2QU0TJN56l2FwYYmRw6gk5rWP/4f6MynTQ3/C/8TyVm1oh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOvQi+sq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOvQi+sq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED4C1F000E9;
	Thu, 20 Aug 2026 19:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254283;
	bh=ql60yrMfHrZsuw18Pvk/QvscM1TKbnUNwvmTV1RFfpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MOvQi+sqX9WwgjaaSGTaTK0fRP919qGGzFnvCi/3iFyq3NWqY5SDKucUXeGvPd6ss
	 t3JB6YNr8ymVG9m83zsfn9CtQmUjB3BEP4ji6R7ejBNKh2uYhLh98lnw5wdYbUByY+
	 s9fpd5I8I/ZxJ6w0iKhZzykBlDmfFVnxceXU0LxLAMQGcgujjMKezKjX4tEGv8V/Zg
	 w+TDNk+c7UYPsLkcQO4ZBoK6x6wJyCIpgGAxTQtoE7vdpAaLS6hxDDxIrlScBZODD7
	 TwDQcmgLyhFEZJfOl59Blfoy+VCZRkEsl2pu0+tmB3XqvQvTsWKdKT72gidAO7L7my
	 OCAZxUfAkPQLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197FA3924459;
	Thu, 20 Aug 2026 19:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mctp: hold a reference to the route device in
 mctp_route_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725423364.446762.16328588855452508524.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:33 +0000
References: <20260813022102.2792032-1-qwe.aldo@gmail.com>
In-Reply-To: <20260813022102.2792032-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 23:21:02 -0300 you wrote:
> mctp_route_lookup() uses rt->dev without holding a reference on it.
> mctp_route_lookup_single() returns the route under RCU only, so the
> route's device can be torn down concurrently: mctp_dev_put() drops the
> last reference and synchronously kfree()s mdev->addrs.  mctp_dev_saddr()
> then reads rt->dev->addrs[0], giving a use-after-free reachable by an
> unprivileged local AF_MCTP user on the receive/forwarding path (no
> CAP_NET_RAW required):
> 
> [...]

Here is the summary with links:
  - net: mctp: hold a reference to the route device in mctp_route_lookup()
    https://git.kernel.org/netdev/net/c/408da1df1811

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


