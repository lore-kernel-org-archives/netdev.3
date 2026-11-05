Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874618;
	b=iTdtkTwOTqutCFqX/TCFlS7kGTOrqCRUgaMJugKgMdFY/DrH1dn7I2/08Z+CODZQFge9
	 ED7VfDdsfhDKZXTXzQi9CT1ftoKjQbP2iyqfbO8DBYcr6xlkshZb0UaYfboNRf7yJeBlF
	 7RMlJX3Fz8j0s2vzEtUTjHvdz3stiGR+H1RlSNiYGD2pVHu2h8zIXnIOegZRqD4eK5mVb
	 XcZ6ngTxyFrI6V81W+USE6smNi5SPrWVSXIYUVpVOs9UcYYCQyJc26KcxgKDqHsH735l5
	 ceK9gUfKg5MkH8Bgoa0EjGnjLrtVo7eBD1RyfFykNsb9wlfcNDv4x6LHpS0FecNNPIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874618;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rvXZkXBoSc01BuQMaMY6YsC+L/a/HGpLrROmj8tbDpo=;
	b=lBOEYVAz4RoIcOSDUEmVLhuxuJ4Kc4PxKn1zOmk95l0mGOEeGhFNMjRpm/kAaVRYIs9t
	 jQy47fCrkNenlG4cdY8vzL28UIREXVk5BYETzBz0FUiIL42S7ZAooNDOxYzSPm9e8s6z6
	 TlqC4Gjl3Lecvfm9DIHUraRFuEgZV5jarZnWPUMBvXKe9Ix3maqhXBSH0Vvhpq23bnoXU
	 uih/9ffxviQWrO4YS8zap9hildeIibY/XQlul6qRgF//0shfLKL1SkIYkGs+X6hU7SX2q
	 Np07zA395b0RvJKCH45Izvq0pUBldQUjN4qsNFx09xyN5+csIgjctTWRRHu0Dzv/bdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H23MBZqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F597606A31B;
	Thu,  5 Nov 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H23MBZqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20AF1F000C1;
	Thu,  5 Nov 2026 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874617;
	bh=rvXZkXBoSc01BuQMaMY6YsC+L/a/HGpLrROmj8tbDpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H23MBZqPCzDGaE9SmlHmA2NIjBigrGFV2rEr44FssRO9HAJkV+SUusWDq+Z4wkil7
	 KqPdfrJeAjEBtO77HLF6/tDtmYwe14BtPR1km9CvKGHsd6kS8hEjqt2+AriQCFtqG1
	 +HCcRRM0YVNU5LXsSGy4Ixt1GdWgMiDk+AvqDPXjN9osxJc30W+goUi93NrDdfP8DR
	 1wpL7UYzw7XUwQE5VwKXKRL6Qh6c5yGb5CozS9JQ8opPW4Khdd5jXm1O/0frUGLwf/
	 RsiBjlIXS9QrfIb4IDmIkLOYm1GQCA+P5mYh83BVwyy90iXiMGMkLsUoeTe/wf7UOU
	 5QS7mLPzhZXvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3A1391AFB4;
	Thu,  5 Nov 2026 10:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: 3ad: don't set BOND_LINK_FAIL on a slave
 that is
 not up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387461633.3576987.4987081538840722192.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 10:30:16 +0000
References: <20261101145653.63648-1-timur.stukan.linux@gmail.com>
In-Reply-To: <20261101145653.63648-1-timur.stukan.linux@gmail.com>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, hangbin.liu@linux.dev, razor@blackwall.org,
 fmancera@suse.de, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jarod@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Nov 2026 16:56:53 +0200 you wrote:
> In 802.3ad mode, when bond_update_speed_duplex() fails on NETDEV_UP or
> NETDEV_CHANGE, bond_slave_netdev_event() sets the slave link to FAIL if
> the slave has ever been up (last_link_up != 0), and to DOWN otherwise,
> so that miimon can set it right once speed/duplex are valid.
> 
> last_link_up is never cleared, so a slave that is currently DOWN but
> was up before is set to FAIL as well. miimon then treats it as a slave
> that is still in use and takes it through the full down path again:
> the link failure count is incremented, "link status definitely down"
> is logged and the 802.3ad port is disabled a second time, although the
> slave has not been up since it went down.
> 
> [...]

Here is the summary with links:
  - [net] bonding: 3ad: don't set BOND_LINK_FAIL on a slave that is not up
    https://git.kernel.org/netdev/net/c/9a65b9c2a975

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


