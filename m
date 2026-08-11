Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996028469A;
	Tue, 11 Aug 2026 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407657; cv=none; b=cqfkizxEk5jHPWF0IDeccpwpyaEEhKjm6ORQSN7d4aosEe4qk2WiZwFfQcLuj2s0aQwwTlNEUhhWfbO/Tugl49/bbke+rT1witcu+lbeZv3Md8iXv9S14xF/C5q0XMOIBVNk9zaYVoSrirDEeuCcoROxDe6ByuseDvJ1TfKroTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407657; c=relaxed/simple;
	bh=1lJ600CrIoFiUsRapRY3FQ/wfcms4th9Q1qo2tR0dMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SUsT1rzUJaCU1N3JRVNaIQpMcRUY9tDa8ofxqqAG+vCFQ+rtNXpTIeN9owL3zpt4S8H+d9XOJxK+KTh8KMR1B3vV5XdCgMpMnfszaEen2hwb5o+0Ob9Pr9XQkWAnSgqnmbbgSm4NBHwrY8tDspSiUjab6CxlfSWka0oGiM3QO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxnhdAab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxnhdAab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B831F000E9;
	Tue, 11 Aug 2026 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407655;
	bh=CIXI1J17/KLPDvFRlOqW5gTml/anzgCmbgVLkl+tb/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oxnhdAabRprHgKgKxTTBYMTDpgPJhFbcWMCFM8y0+HhPVOJvH9scK8JRjB1UqxN0y
	 T5q/g1XKZR6uNTr8Ht+sC7pjXiwlOjtDDqlIJzgrRAnw4NVyFoBWuYwyKCDMX2EhVJ
	 wkp88zS9FedZGOzW7XvsI15BuKwrdtqXfMOAawz4qqQwo+qgR+iwpKGErnLMe0WXug
	 G6kRoYOa8xgqp3AKtreQ9qajGx/uxyiJ4nVLaXp9fgMKRl8QED62b7YHe/rLaIQUjX
	 Yi7HPi9760maCSbXxMxufYKwyKPGZc4ytD8oxJMEG7RHwIyrIOxdqxhLCA6mScGOdO
	 DIIKcLqSdchLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93886392626C;
	Tue, 11 Aug 2026 00:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sfp: fix hwmon_name memory leak on hwmon
 registration failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640761213.266182.11248058007964442666.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 00:20:12 +0000
References: <20260809064504.70579-1-krishanmohan298@gmail.com>
In-Reply-To: <20260809064504.70579-1-krishanmohan298@gmail.com>
To: Krishan Singh <krishanmohan298@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Aug 2026 12:15:04 +0530 you wrote:
> hwmon_sanitize_name() allocates sfp->hwmon_name before
> hwmon_device_register_with_info() is called. If the registration
> fails, sfp->hwmon_dev is left pointing to an error while
> sfp->hwmon_name remains allocated.
> 
> Later, when the SFP module is removed, sfp_hwmon_remove() only frees
> hwmon_name when hwmon_dev is valid. As a result, hwmon_name is leaked
> if hwmon_device_register_with_info() fails.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sfp: fix hwmon_name memory leak on hwmon registration failure
    https://git.kernel.org/netdev/net-next/c/20232e99e8bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


