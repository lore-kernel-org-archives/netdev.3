Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F083B27FF
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522895; cv=none; b=rYFVTX201kGHSUpPene/0FkjMtNZXKDYi/LgbzsPqwXq2bGh7mJCD3oQ/UVxNG0H8Hl87giButjZ/bDUz8Up02jCPcGSPi8s03L7Jpo4w+GNZ0H5hjCl4fZ+HZsIFfbM3zNxC8Ll3fyYjRIt1mpKc09nDo3jqRr2wOSkv8cD6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522895; c=relaxed/simple;
	bh=BCTPfbxEcmhyLWUGHF3gvXi25/d3SRJ8ZKkLq+xuCyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QF31VvN45bqGU9+yVggldVNoaITZBLArpKLwhoa2lM4lfGVXAtWYjUORNKhwpsU4dAEZuqaNh8DGUjHm7+w6NZP7b02+nRcYGeV55UuBEBUa2eijOFXsV2+h5o8eTbOS/zLlnQ5DLEt4UIPvKQCpUMBR5QNUVwqE5GzMjjabRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdqBBr+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdqBBr+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F81F000FF;
	Wed, 16 Sep 2026 01:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522870;
	bh=VbjMS8Ne6mpuUeH6m6IA3igIpuxTJmLYypQ89AF2BsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mdqBBr+JRXi9IJ3Ib4XtXu5S4WACPR7xwsjfIG03a8F5EBo8J+VTmhnkjtlVt9Zaa
	 vMsRIE5xfBOjfFM/85EPV2+ih6SRCus/geT5BX58InbwVU5rrOlTt9RLo+SBki2Ns+
	 Mg/I4dv1VcZcEIH+j5hk10L4cSEFlVd48DAJXLZm+7UamB0dhGdGMXdQLJ6uANg8rq
	 6GY1DTMEDHDcXjbrbEIUDOzHekpvTJ0CdF/POwpxTFGT9sI5kBnoWulPidFgXbp7+7
	 9hhWojIfP3V2xppP241W+IIYiDhzLPGnNQEe6l3vb4xGY+dypS9ay9SX2YXtmh4sN+
	 jI3LZClC+ie/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197E53927075;
	Wed, 16 Sep 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: do not overwrite phc_index when no
 PTP
 clock is registered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178952280488.2353777.12003404021238471731.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 01:40:04 +0000
References: <20260914-stmmac-fix-phc_index-v2-1-bf3d90373fe4@oss.qualcomm.com>
In-Reply-To: 
 <20260914-stmmac-fix-phc_index-v2-1-bf3d90373fe4@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, gal@nvidia.com,
 rrameshbabu@nvidia.com, cjubran@nvidia.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Sep 2026 09:41:07 +0200 you wrote:
> stmmac_get_ts_info() reports phc_index as 0 when hardware timestamping
> is supported but no PTP clock has been registered yet (e.g. while the
> interface is down). Zero is a valid PHC index and would make userspace
> resolve the wrong clock; the absence of a clock should be reported as
> -1.
> 
> The ethtool core already initializes phc_index to -1 before invoking
> the get_ts_info callback (ethtool_init_tsinfo()), so just drop the
> erroneous assignment.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: do not overwrite phc_index when no PTP clock is registered
    https://git.kernel.org/netdev/net/c/f0ef4b1eaed0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


