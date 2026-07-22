Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1321D4606;
	Wed, 22 Jul 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732442; cv=none; b=TORqdnsPX4Z0ENAT6dK+3MIcJcc1drj0QHD2C7qRlLKaPVH1vhaLNrfngKRjp3leV0V2WmLRNABKaks8t74YozL5AthAtW9JUWVI6tQ79N2Sej+oefsHMJ+tVNb6+Ae0FOBUfEV7qTtJ0XOqqbEsB+bFbm7FQjXJL++m+diwYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732442; c=relaxed/simple;
	bh=ygft8y5ljAL8ge/tCWBqHmwU1ffmTk2bGZU2Mn23G1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ShBC2kTobhwra+6gfgQlnfe47np88/Mmd/8I5vmh6eFQyGfwYmU8EGIL88ecdv2nQ0/wF22YuI9HBhSr8nZTBHtcUuQizYMqEnFYgT9EFnv8RNoXwtiTvoSd6P75LZnI0C7iawhwRlBD/cNnEq2on/BDzjpNttsu3ZbqfynEX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUSil3Mw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUSil3Mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F2A1F000E9;
	Wed, 22 Jul 2026 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732441;
	bh=a8lJwMmRtGpKEZCP8tJIqS7uWjpj3t0gonsSrwYvF+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GUSil3Mw6L5ieBkQ1esNzpUVlgmVWOgIUJuaR02M//VP9cIqfNqb43G482rv1vlO+
	 86aCBqc7RSS3pOm/vWPYBXTg5iJYXt0m6K3ZzFTymHm6Nc7jsWt9HOjooJdouw2Svg
	 1NBocFZTHIM159pYgPCnp8Qx4LAsdFdMqDnq9B6gQTSr2EjNYwKLdwBkdw+3X2YOdc
	 J2H2KfSm6PWTdEa9quDd+W7sew+clkHf8+CqBXU/ZW3plk1xRpkbhgqxe+VrGcwW2I
	 uKJWgeTia2VuECf+iZguc5yDWy5hTXbyHEwHe57GIpNK/9w4Ma60+6MyHSTUtttESA
	 01JtcjdBkBiVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AEF380AA5D;
	Wed, 22 Jul 2026 15:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] amt: fix use-after-free of the skb head across
 pulls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178473241013.1446136.631671515968339139.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 15:00:10 +0000
References: <20260711151934.2955226-1-michael.bommarito@gmail.com>
In-Reply-To: <20260711151934.2955226-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 11 Jul 2026 11:19:32 -0400 you wrote:
> Several AMT receive and transmit paths cache a pointer into the skb head
> and then call a helper that can reallocate that head before the cached
> pointer is used again, so the later access reads or writes freed memory.
> 
> Patch 1 walks every AMT path and, for each pointer used after a
> reallocating call, either snapshots the value before the first pull or
> re-derives the pointer after the last one.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] amt: re-read skb header pointers after every pull
    https://git.kernel.org/netdev/net/c/3656a79f94c4
  - [net,v5,2/2] amt: make the head writable before rewriting the L2 header
    https://git.kernel.org/netdev/net/c/53969d704fa5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


