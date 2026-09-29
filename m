Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5310F0;
	Tue, 29 Sep 2026 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640692; cv=none; b=LZnwd7MmXYnv8LGpmdzrtiFLRiGKbMvogHSemPeeW5C3aJvpUsHVtuT8zJQ/z1UWvU8CGe4YXZCZNIsNBcXB2k5XfLu695yRhLp5KcpXaESDcvoVaxc3B0kxEHFNZbF6R2MQhh7rQps6NWigxmDguhifVuYu0mDrU0/pD+nnXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640692; c=relaxed/simple;
	bh=diEc9FOLb0XHlGuO+5vL0HqR9s4A1iMqSNLsJwziIog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sHRVGxAVp4BUJ4aoSynM88qSOicVoiN7KNSqECqhgTFIqHp0O+S4YJ7G4oZRMJw5uGffw+uHuDQSESzWzNvAnc1/AHJ8bCJ+R3WpaVA9LUWj0Mz8I7yg5bX0FQ6u31ELdLY/fOqATTQCibeg9Mpq8pDMqMSSZwpfx+0s7nmZiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnvPAcES; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnvPAcES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A191F000FF;
	Tue, 29 Sep 2026 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790640691;
	bh=S43LTuATi4b8UkbY0wYWz1almwZxDBGqSjw01HbKm+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NnvPAcES+4H6IcDN2oQ0/YiLT+2AJVLV6x8LCv2FieBuPDSpDAG3NZbPZra+bts63
	 NOVphvBbqJrai5GH+Xouqp3KgaYScUhqJK6xiuWjkBXSL/lGyeOXmagQIKUOOSqh8w
	 rbiqAX77+1SFGyHtVd2lgMtdOHeZDxKRxWWeF2m/N6SdCm/qdl+rG4j94SIopUw+Ms
	 kmozTEx7g2saSEiuJsqdm+5RYZjwVHKiVFIq89M0TSI5SDGeQDoCY7s3TKp7SVYVQb
	 z7uZoXZtPttlg7jlEH/nEQRKpUosjz323vdzWGCa1yPxir1yRp4eS4lOAxdU/HzXip
	 9O7FBzs+m+KVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1989F3924FE4;
	Tue, 29 Sep 2026 00:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/10] net: systemport: Collection of fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064061593.185826.12040985332486922807.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 00:10:15 +0000
References: <20260922232440.598918-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260922232440.598918-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 16:24:30 -0700 you wrote:
> Changes in v2:
> 
> - dropped patch 4 and target it at net-next
> - dropped patch 11 which needs more thinking as to what is the
>   appropriate DMA teardown sequence wrt. topctrl_flush
> - addressed Nicolai's feedback
> - added Nicolai's Reviewed-by tags where provided
> 
> [...]

Here is the summary with links:
  - [net,v2,01/10] net: systemport: Fix buffer overflow in bcm_sysport_get_stats()
    https://git.kernel.org/netdev/net/c/eb7b84af0ec5
  - [net,v2,02/10] net: systemport: Fix invalid dev_id argument in bcm_sysport_poll_controller()
    (no matching commit)
  - [net,v2,03/10] net: systemport: Fix NULL pointer dereference in bcm_sysport_fini_rx_ring()
    (no matching commit)
  - [net,v2,04/10] net: systemport: Fix Wake-on-LAN RXCHK filter enable loop
    (no matching commit)
  - [net,v2,05/10] net: systemport: Fix RUNT MIB counter register offset calculation
    https://git.kernel.org/netdev/net/c/242935adfeb0
  - [net,v2,06/10] net: systemport: Fix potential packet length underflow in bcm_sysport_desc_rx()
    (no matching commit)
  - [net,v2,07/10] net: systemport: Fix out-of-bounds array accesses in DSA queue mapping
    (no matching commit)
  - [net,v2,08/10] net: systemport: Fix inverted error messages in bcm_sysport_stop()
    (no matching commit)
  - [net,v2,09/10] net: systemport: Fix unbalanced Wake-on-LAN clock disable in resume
    (no matching commit)
  - [net,v2,10/10] net: systemport: Update TDMA queue mapping dynamically on changeupper
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


