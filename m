Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D030E82E
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971010; cv=none; b=lJe8lxkZ/liSygZS5Knk71c6fyPUgxRJdweMEW4rWumyJCSIy7Tf2eu+ZsphtzDP2E1EQPGgiybTUse2qpAzo/+PPbi2hoWSdnHWfMv5yVy2IvBz6ua6DK3Xs0ogaX/L9plrBwyO+jNpcQnS6Jv1OvkzoF0Cs/VDnr9sDMgMZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971010; c=relaxed/simple;
	bh=RD00bSu1DRBvmwv2nvCFsgK4H6HmJsJrSmryOX/XrBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TfJI6IP8xHQTV87GYJcMo1m7dB5eLEhIC2NeyY0OyVmuUEcUylq6LEYLpb3Ad92fiSqwVKBSoRKEd7YPEYAqvF5QW+XFKFG19BB0pokiJhH6/DC38v+DU4UAYB8E0aOF+9OCvK/+I0Llpc2Xa5bSbAfYMK+a822zVSk2vdpHaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpekD2cN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpekD2cN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA4A1F00893;
	Tue,  9 Jun 2026 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780971009;
	bh=k8Hyk9bHNnvJ7oBV5W820xGgpz2J1CBfZ36WWehZKmo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dpekD2cN8fvEUglNnWc3YYzQlDSO5vy98sgP4nywDKYU3PM9In+MyR+VEWc3TmhdY
	 5Al5aFBUeTgzs1co77XmtFDip5jgE9a5FHmDc8HRFsk0bu5FdQFEk1AK9ce++gHHUg
	 u4RocYSWyB2P4XlJTyiMT+EAXwyiUUswQngJYcMgFzW9xdTegvu/8F4uG76jlxSeUC
	 I7tLKWlWPOnfOc1ow+7O1+yWEJ0T2XEfNV+AGuqQs/tPqUZiK9fQy7Vmp61DzCFLbc
	 kDWEPROHYcua8J7a18BYVHmjerNSgIFsYsJO1bkz4xudBMmgM80J7GYlT4oXkeU4Fd
	 6fpeARkUsKRWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EB3822D43;
	Tue,  9 Jun 2026 02:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv6: sit: reload inner IPv6 header after GSO offloads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178097100739.1755698.9370562920903571836.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 02:10:07 +0000
References: <20260605073448.6524-1-kylebot@openai.com>
In-Reply-To: <20260605073448.6524-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 00:34:48 -0700 you wrote:
> ipip6_tunnel_xmit() caches the inner IPv6 header pointer at function
> entry and continues using it after iptunnel_handle_offloads().
> 
> For GSO skbs, iptunnel_handle_offloads() calls skb_header_unclone().
> When the skb header is cloned, skb_header_unclone() can call
> pskb_expand_head(), which may move the skb head. The pskb_expand_head()
> contract requires pointers into the skb header to be reloaded after the
> call.
> 
> [...]

Here is the summary with links:
  - ipv6: sit: reload inner IPv6 header after GSO offloads
    https://git.kernel.org/netdev/net/c/f0e42f0c4337

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


