Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7A395AD3;
	Mon,  3 Aug 2026 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785799849; cv=none; b=lSIiSQNuC3Y3y1nPhbLMvzQIh+btakd+T6HT3KjNWd7mcwF+pJXsHdUKXXKe7grT2gFSOebeSfyDYaQGMB+u2Y5eXDtDeIdSriOXvT9xa0gXXaOqBB/7V1q5vGz7AlmwLR+hIjJHSBM65IZ13xATzwQOZQfWPoJ8XNtLfiwf8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785799849; c=relaxed/simple;
	bh=GaabUt4H619DxNVAoXM97+/9CY/8DNfWDUR5XVnnbGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L67dYfylwZCxp9+io2WBb4EVd6MK+31E+Cfojt/rH9rUu5cqBJVTRA5z7o3eRXAiT5xurnMbnfPiHYSAzglGhK5ttB64hVcaEZyFhm0a07cXvV3tgH8kOwBUuUaKM2cTq6E23JeO97Cyh4bxbh/y9ZwOJdok/+5SHiBpeHLuPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ColeSsvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ColeSsvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3801F000E9;
	Mon,  3 Aug 2026 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785799848;
	bh=LBXpDbwtGmfEkRYq/Cn8zLessazrNca9ZvISGqmzPJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ColeSsvK1qj3mqkg+U3Lz9oycNY6InW8iX0zC48sE3rS56RwKvJZTLetzqYBUmA8w
	 EJHCfEGDgi/OVc01/Ntu8Fk0/BXN9stb0l+iZZgoxKFgXPwjAUsLfpKsw8fQwlPCFu
	 tAVtEaj0cK4Ipk8/JoqmDBx5pZTxaMfplPzIwU7aL7sy2mgFfWhkgr7tK7fBDce6nS
	 AGXL89rV9CCD7ylR582R2IBJgCvAqSnZ2Ntj4rchC37zdrO7uzsrVB990X1HTIWMBQ
	 3G+AUXNWtMemI3LW22GCH410/HdIlLACUm7Rvf8Na4db0UEwFHf9P/RfBz5buS0xIL
	 +vvMxOKbYKBEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0F3924467;
	Mon,  3 Aug 2026 23:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] qlogic: fix and tidy notifier cleanup paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178579980913.2876283.149168107924184802.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 23:30:09 +0000
References: <20260728032046.121631-1-pengcan@kylinos.cn>
In-Reply-To: <20260728032046.121631-1-pengcan@kylinos.cn>
To: Can Peng <pengcan@kylinos.cn>
Cc: manishc@marvell.com, rahulv@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Jul 2026 11:20:44 +0800 you wrote:
> Hi,
> 
> This series fixes and tidies notifier cleanup in the qlogic Ethernet
> drivers.
> 
> Patch 1 fixes netxen by unregistering the netdevice and inetaddr
> notifiers if pci_register_driver() fails. Without this, module init can
> return an error while leaving callbacks registered for a module that did
> not load successfully.
> 
> [...]

Here is the summary with links:
  - [1/2] netxen: unregister notifiers if PCI registration fails
    https://git.kernel.org/netdev/net-next/c/e8aaf6ba33c7
  - [2/2] qlcnic: move notifier error cleanup under CONFIG_INET
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


