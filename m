Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2A7472549
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663443; cv=none; b=fgJq/+IcH6dHJmH50+dN62uVWk3XXbDx268qB0w7ZQJo7xZXB303cL9e/cwuqjbz2kTMrkLxc/OFSjUl7gREREn5FsPSxEYfeTg6gDqupYKtPilhcuuwYBECmGPzJ0OIoWk9Ge36bcIl8MtaWcGYrFE1XdNTNk6wOo1AkOQ/AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663443; c=relaxed/simple;
	bh=t9y5Iyah7KyqLGoOpoYeC9v/4vfhJE/jyrZJ9axDA8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q/StjnpN6Qm2ZSwbSkxss9lPQlaFZlVS6a023BOTyNwKIy3Wbo21ntukAHTqmowoHuasHnoqgkQX6hrcFHHpNqy/5ud3EBgRLY1BpcLg1SXm+XdamDDoYSepQFGdanZGyywRkbRQomfgOOEcYs2rdARNWSsSLrP8YiGnwBZIPfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeVAmZnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeVAmZnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFBB1F00A3A;
	Tue, 21 Jul 2026 19:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663441;
	bh=EMjlS0W+QDXhm7fAJW4dERnh4dU/APvaQ4mwuKjha7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AeVAmZnjlRAZzbafDITsoYb6ZeXpW99awHhTRYNWsAwIcvVPULc4zuJ1vhupuOM8R
	 XQvj2HpzcoF50qMNFZbdIrB0F4UtNu7APLSRDLCGaZdwuETz+DuEg7Rre/5LbsKKR9
	 Mv24uvac0XUVZCHu43KDjyqgdfn5JoeO791EbDjlAjF8o9AKX2MTIFY18oKrqLauu/
	 hkIc1a/M6KR3Vqg2kUJgmUcnKx0GpDalllMoDGlo7K4k/30BXVDc+XSCscsTmHf+0q
	 UugvsHNIxOwSvcCPJucBxzHPK5F+cxb2G54S8Qo9t+brCPo+nTQfOAyclVwqNZLlWH
	 qENRdx5fAc1UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B153926242;
	Tue, 21 Jul 2026 19:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] pds_core: fix use-after-free on workqueue
 during
 remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466341108.1010442.10182852519605385895.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:50:11 +0000
References: <20260714180223.1642792-1-nikhil.rao@amd.com>
In-Reply-To: <20260714180223.1642792-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 18:02:21 +0000 you wrote:
> This series fixes a use-after-free on the workqueue during driver remove.
> 
> Patch 1 fixes a pre-existing deadlock between the PCI reset worker and
> pdsc_remove() that was identified during review of v1.
> 
> Patch 2 is the reworked UAF fix that moves destroy_workqueue() after
> pdsc_teardown() and adds proper work synchronization.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] pds_core: fix deadlock between reset thread and remove
    https://git.kernel.org/netdev/net/c/ab0eec0ff0a4
  - [net,v3,2/2] pds_core: fix use-after-free on workqueue during remove
    https://git.kernel.org/netdev/net/c/0ad134881508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


