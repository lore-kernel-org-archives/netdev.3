Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84B381B07
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456053; cv=none; b=vDW4J1fenMqwmN9IA+4qD1rZa8n820LqoAmVmfMc2LIM0qXFTYYwRg7BTsha7g+E8f4+oONe7jz5htyZ4u7hBPxsHOQi3PtbE3d5WfUTx4rzVPcAupo5jZhupZ3WoXfgEj7y0Gx3foWC90MTq4E6yUYklf/qlBJvAYJk5GOTpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456053; c=relaxed/simple;
	bh=EcDBYNd0ZULYG7prSXj3sNcfiVeGcgRLGn+eTco8HdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oRtXHzoddv2I1xVK0gR9K5RniyJsjWOZlsUWKuVO5D4w31xp1DjM9W+7mPAsOv43eJdBYmo9v0WFlMTJg4NRHoPqEqUFC7C0EUYOBc/wayVKiWsXFCwW844duNtBgrPfEWDNX0wQYNUPfi98y6PeGXY6HvdEwjnqmV0rE5hVh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GckipXmn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GckipXmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8919D1F000E9;
	Fri, 31 Jul 2026 00:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785456051;
	bh=f+PPpMcPmnPAy+fGlhLAWqXwZG/aZYkPEBFb39Wih7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GckipXmnLwbC+G+9HKoGiOJM0kLi6zCD9pcd1sHTagZJU1JgkpzJFggg+RbvRNu6k
	 sorlKYJnQSijIYBJEQjQpxFIb2ZyF3tIvAsWUCw4G30zRxtWQelryavuu5hDkTZmuH
	 B2eHCyb4+tsmZQKklu83yhJQIxCgnHNLXsLpQjSTIDnV+qS0Q4AMXK44UoQrdep57E
	 d2dpGuvF5VAdF+J+m0VrEYXtYMNZtPkhcHKv0Hmtjsnhv99k1cHREmAPSIGs8BjG3A
	 UbV8rzIn46StdW55S5n2rzyiy2eSJ67EO7SbLw9JWRm71DixJVYLs4KI0Uutk/AD5k
	 mHnE7Gr3x9OUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197773924472;
	Fri, 31 Jul 2026 00:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: cancel pending PCI reset work on AER
 recovery
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178545601463.49120.79236621919940222.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 00:00:14 +0000
References: <20260727170030.361116-1-nikhil.rao@amd.com>
In-Reply-To: <20260727170030.361116-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 17:00:30 +0000 you wrote:
> pdsc_check_pci_health() queues pci_reset_work when it sees a broken PCI
> connection, and nothing cancels it. When the PCI core starts AER
> recovery, pdsc_pci_error_detected() runs pdsc_reset_prepare() and
> recovers the device, but a pci_reset_work queued just before is left
> pending. If it runs after recovery released the device lock, it resets a
> device the driver now considers healthy, bouncing the link for no reason.
> 
> [...]

Here is the summary with links:
  - [net] pds_core: cancel pending PCI reset work on AER recovery
    https://git.kernel.org/netdev/net/c/57d635329d79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


