Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A753F6BC;
	Tue, 22 Sep 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084474; cv=none; b=uwBus5CuCSR4G4EZ7TnIxQsBuua1a0/xNSFT54QB5vv08YLYmO9406/KOXWEtVo4fsuH4b4OFuFfDtMh3p7r95SVUlKBWWlf8j/3bbE2t1GV2k4HnHAU4lWclPqO/0mua9bKVH27iG4zE3yHylWDBZ/LH4S5BAVgyZAk++5dhGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084474; c=relaxed/simple;
	bh=98TqBGsRC70EYLk8/Qp5FVK3r4PzSvJrjwQoWJGURUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QFwYsRhETd47qjRdR5ddha9QWrobnWPcJ9gK/EjrTq89jGTRVUux4Kr49hR6FGq4/ScNM6xiksggtwx69P7ed1cHssyrLOcupVIbuJyjg39iFm8urKDLp6k/jPrwcwomqYrfyejyfHx1Zvo/2l0x9GCjk3gC7ockWlY62z4SbHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNqrWYgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNqrWYgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E2A1F000FF;
	Tue, 22 Sep 2026 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084473;
	bh=usMwdHqMi3Elovqlq4HzudlUjNePhc6xTk1n+SjgzM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WNqrWYgvpaLCRFtl8UF8L/VY0AXhXraNhBoww2sUOhLMibSTGydjbCUe+ja2Sf6aX
	 AG22ApnWP4eYybo5CJ+ynaaQ0zO00rkrymLjCCRvoG7jBC2Yk+5Mxy5afXQLIQI/xf
	 xniVEl2vmV+gtqZZ+hr4WSfg/swLHMgrkNM1g2KkIDbI56rxcxhaxuQqM2MmCXkaVS
	 CE4+k8yF4zYNzJNbVidCfkHYQCVpCRF8pmcrl35of9Uj+r77mw/Xt1vO+KNlvSxg+Q
	 WkdHNyAs3H7SiWWvHhrXvJkFwvteI7mTdi4Gm3fBtpy9Y66kxwmjWJETJNty6Bm+CZ
	 HbNVPnileMUlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6038119F8;
	Tue, 22 Sep 2026 13:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pcs: xpcs: fix clock reference leak on
 xpcs_init_clks failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179008440440.4087209.62210510053743916.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 13:40:04 +0000
References: <20260919172021.2336748-1-coiaprant@gmail.com>
In-Reply-To: <20260919172021.2336748-1-coiaprant@gmail.com>
To: Coia Prant <coiaprant@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 20 Sep 2026 01:20:21 +0800 you wrote:
> xpcs_init_clks() takes references with clk_bulk_get_optional() and then
> enables them with clk_bulk_prepare_enable(). If the enable step fails,
> the function returns without dropping the references.
> 
> xpcs_create() handles the failure through out_free_data, which calls
> xpcs_free_data() but never xpcs_clear_clks(), so the clk references are
> leaked.
> 
> [...]

Here is the summary with links:
  - [net] net: pcs: xpcs: fix clock reference leak on xpcs_init_clks failure
    https://git.kernel.org/netdev/net/c/9892d71cf0ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


