Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B08248B;
	Thu, 10 Sep 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004469; cv=none; b=kEY+Li4fzexr2Bl+CvqzyKGTrODCrpUnGWJQcENQm6rB+Lxf2Pe9Tzhx2dmVbmjcmj7lEQs1bsq0uuMOwFAzznHqDI0QXDnQkpTLkB82AW6do+cJFJclvRknt9L7qoI0DJ37g4OApzHicUtFLZvm48+hKl9yTVynpw+lUS/DHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004469; c=relaxed/simple;
	bh=SD36AJKQ2kXQ27aSo6+QGauH45nJDFY+rUiIoJPnDTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LESINZhzhhEYANl7uHzLh4/xZvY7GsIw3naP6CcayqFvyGRyTQRXlFVIcyRyLAl9kN7qFqZ43+wLpN9AAGQ81KUKpbPlGoE6NDbH6QgDlhWGUensTtamztWMq5qJlwqZwP1/j3iOyv6+NFHgju3EB/E1kuhG00kdLvskq7d0V0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKEI13SF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKEI13SF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C091F00893;
	Thu, 10 Sep 2026 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789004468;
	bh=ORl74KFKK10yRdVOB/HqlIDDDUYbO6nTnqeN1m/Jxu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EKEI13SFdZF5Anby9N8kR3FXi4ajRPjp85NRSR7EVEKr/ZXA5+zfKd6lPpKZ1rcaS
	 bXzFhuAffcKF2U7hDuX3vDvw94tz558VDoOtELM5JBk/J8tXm+OZJS0VntgluHw+Rr
	 ZnNCfpPXv5mxspM8YQkNwpOWsPpYbW5AOnS9gHUlgtv3bnHrEBNHqsz4/B/VtDM4GA
	 JBi1xC5EPLv7Z2IZzZadTBfgkNWuJ97RGxiSQPVKNrs9qi46vhGPCIyUApGcl89bl0
	 oFyDETPNCe2q0+KyeXSh16Hn28oBQeAtcN5s7PCrK6BXONeHzAmFDKCwpjr6oQ4Bsg
	 TWTRBEJklLpAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197BB380CEC7;
	Thu, 10 Sep 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net] octeontx2-pf: reset HTB scheduler topology before
 freeing queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900440563.1145188.13874593084927115417.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:40:05 +0000
References: <20260903020533.3068041-1-rkannoth@marvell.com>
In-Reply-To: <20260903020533.3068041-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, hkelam@marvell.com, linux-kernel@vger.kernel.org,
 naveenm@marvell.com, netdev@vger.kernel.org, sgoutham@marvell.com,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Sep 2026 07:35:33 +0530 you wrote:
> HTB offload programs NIX_AF_TLxX_TOPOLOGY on QoS-allocated scheduler
> queues via otx2_qos_txschq_set_parent_topology(), but teardown freed
> those queues without clearing TOPOLOGY.  The AF only restores PARENT and
> SCHEDULE on free, so PRIO_ANCHOR/RR_PRIO settings can survive in the
> shared scheduler pool and affect later allocations.
> 
> Add otx2_qos_reset_schq_topology() and otx2_qos_free_hw_schq() to zero
> TL4 through TL2 TOPOLOGY before each schq is returned to the AF during
> hierarchy teardown and cfg rollback.  Skip the aggregation level (TL1):
> it is a per-tx-link queue shared by the PF, default Tx hierarchy and VFs,
> and is not freed back to the AF by nix_txschq_free_one().
> 
> [...]

Here is the summary with links:
  - [v4,net] octeontx2-pf: reset HTB scheduler topology before freeing queues
    https://git.kernel.org/netdev/net/c/ef39fca85085

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


