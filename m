Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0173264DA
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570670; cv=none; b=aom4x95Uzh/tqH2i3LCejZiie1Xm1aRYm7NgkOoEeRmZtvI7kaiWCnXdgI7CrRMUJRVQ2cTvero2GrvZvZA0b2J/Hy9xV2ZkfeU+8sahGXFX/rrPUXlZ0xi7B8y9oMiyrxIKiYoMyikjI/ZkdS+KwwFWLpt1Vqdok6dOpfchnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570670; c=relaxed/simple;
	bh=Spf5Pq3IWgkiNumuCa154L8g8iP84RS9nZb3sjSVVhs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hD9TeoHKxHvYPUjJ/JzFugNsMZgNu3W6CbWrZu4GFt2Bhg1rl/USxDDySKfCyc15Fq5VmBV5b9QdZeySMxWe5YDTdMJZcyZT6zHdxU6rO9uf4y+WDhNJHW7ar0hwSKnspEfCPYxMZgQW2FejRAGVzNaiFO/7/gq0Raqhr0jydgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAQShqtb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAQShqtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1831F00A3E;
	Sat,  5 Sep 2026 01:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788570669;
	bh=R0SG2O5gSAwoHUxJobwSFsmKiIzs0fR3ZrVOfDks5Ao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RAQShqtbxjNQLjfb3dyYPgN9pTwpj+x/21nbd7meeUJn6fGGN0vJZV3iMFYSbGU1x
	 fOu4G3pJVHC/47HsoEfMC64euVpwhVNUHi+mGiMDvqj259eV2l5lzU2S7Jfhoq0D1K
	 kbSTqaK+w8CMu9fIGu1l1LDPdPyEweS1Np26Jdewh/xDU0Mjew07+E7GP/obrjkkb9
	 +6RBWxsI2x0cSfeZf0z86sOXlPyLO7ZNgWAo1cQEqoqN6ln/Vc0FE0d8NYrPIdPUnG
	 NmPHbeS4gu8sCnSXl86lIqb1wZndH2e753wf+VXCHdGPWeRGO9UZnhw7Eo9k7xiG7y
	 2No30OCAE/lbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D092B3924FC0;
	Sat,  5 Sep 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/3] pds_core: fixes for the PCI reset path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178857060939.1044635.3045018102996907198.git-patchwork-notify@kernel.org>
Date: Sat, 05 Sep 2026 01:10:09 +0000
References: <20260901044219.1361466-1-nikhil.rao@amd.com>
In-Reply-To: <20260901044219.1361466-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 brett.creeley@amd.com, eric.joyner@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Sep 2026 04:42:16 +0000 you wrote:
> The v2 review raised several issues beyond the cmd_regs race, so v3 is a
> series rather than a single patch.
> 
> Patch 1 is the v2 patch with the pdsc_core_init() and
> pdsc_identify_ver() checks removed. Those checks are dead code. commit
> cd09971dcc1c ("pds_core: keep the health thread stopped during reset")
> disables health_work across the reset, so the health thread can no
> longer reach pdsc_setup() with the BARs unmapped. The only other callers
> are probe and pdsc_reset_done(), and both map the BARs earlier in the
> same call, so cmd_regs cannot be NULL by the time they get there.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/3] pds_core: fix cmd_regs access racing BAR unmap on reset
    https://git.kernel.org/netdev/net/c/7980325b2f71
  - [net,v3,2/3] pds_core: don't release PCI regions for VFs on reset
    https://git.kernel.org/netdev/net/c/73608de7e592
  - [net,v3,3/3] pds_core: check info_regs in the identity debugfs reader
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


