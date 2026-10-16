Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECD3264C4;
	Fri, 16 Oct 2026 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114208; cv=none; b=ncGmoU2G5PTeyCCfhL6vhJW0MKjB2MV080xswPGRFxzXLqVSwTPQIFwcswzMl4aR+ksFsdDS44E+vQMt+jzoBBBgdWMODHq0DaaWNHEkXlL+/cFjrp58MYJJGe2DsWnedW2o0nG6pDDZ2DRQgzHRNgdM95r07RHDeZLAQ3CqwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114208; c=relaxed/simple;
	bh=dMNkIuBcU09M1d7Edk7n27WUNKfu8sKQjYBMa9ZMmQA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=amYsig0RRtSI2tq+WovFs7NJsJ8nLl9Bb7JLXsTYI7nQUt5F9jushwOHQkNX7Y4bz3lZj8BpAI+kEArquOROr5AegzdJJPvuw68Fa61qBncWK7BrU2Dmg0yN6J4FDjs2apw8cWcoMR0PaW1pdgvzuk1de6Ehh9F9cRGl+BPSADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUoJbxrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUoJbxrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB231F000C4;
	Fri, 16 Oct 2026 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792114206;
	bh=FZabkp5Van1dQcYHcrl+3YxqHHvXZd9OvWgF//k43mk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oUoJbxrl/jpl7KiM/sxNi0CaGnm86qf+N8LpsEWykUnd6fct5DsP1z3U9UUWYLdRZ
	 EfJyi/ivGFFcEMZ/pTwirlkJA4HIP2q32rkH9bSyVpHZdkaeMOrjR0r8Tu7ou346cY
	 U1meHtc88DIrZu/1YGVbw3VmBufWvBxvxnltaAHOzOzsGtW6tDOdniXLdpDlzKJC68
	 5KLDzxv31YweQeTRJJO61Q5r+ekpftTNnqBPSv6qdZ3DU6Y/QCmrgw6iKFh+fcTrMk
	 Jdg5w8ynvu9dbqJM76x+iTvw7rP8jRbxXkA+na9MlH/iv9paxXmYSp/Ndx2gOOZ64K
	 R7XZpPqDtCnVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773773808209;
	Fri, 16 Oct 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnx2x: fix header length calculation for encapsulated
 TSO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211420527.3903.387764569014048252.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 01:30:05 +0000
References: <20261009-bnx2x-tso-fix-v1-1-1ebea422422d@gmelikov.ru>
In-Reply-To: <20261009-bnx2x-tso-fix-v1-1-1ebea422422d@gmelikov.ru>
To: George Melikov <mail@gmelikov.ru>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ecree.xilinx@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 09 Oct 2026 20:30:18 +0300 you wrote:
> From: George Melikov <mail@gmelikov.ru>
> 
> Commit 80bfab79b835 ("net: adopt skb_network_offset() and similar helpers")
> replaced the difference between the inner transport header and the outer
> network header with skb_inner_transport_offset().
> The helper is relative to skb->data, so the new calculation incorrectly
> includes the outer Ethernet header in fw_ip_hdr_to_payload_w.
> 
> [...]

Here is the summary with links:
  - [net] bnx2x: fix header length calculation for encapsulated TSO
    https://git.kernel.org/netdev/net/c/4fc1d5bb448d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


