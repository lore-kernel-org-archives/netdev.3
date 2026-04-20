Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B4274FD0;
	Mon, 20 Apr 2026 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722423; cv=none; b=l2D/0Quo9og/SMJsUjw+Xr0PxA1aasSCGKU8K8e8NA6bpDiWZIL4tjM+MJ/SpP+TXqFGjgxE+kNGdsopj8OD0oM9LFMz6YdSSrj1aLdRo5Gjl/b+KjZfPXfaj3IXfvdWxPiDRXD+P6uHxfquWXPlxDlUvs2M/CDXLGfZ+dNN7ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722423; c=relaxed/simple;
	bh=06k+L69MGxQpyUnpeTop53TZeyKH6tZudEvym3TXPfM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XfT6wWVC04Vm736M2e4eqvmzS1QIxJ9N5sfcqCbI1mzlSDftNJ48+nfDazgYBpqR76ADKkdftjoQwkav8aUwLQGFP5D0amnaIl0dAmxqkhcPdpX4IcChRI7knIfyLYmREV8SSQ4vm5iks4gpSXuy20v4wxrhi/8bjfULuGEbnQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loyV55JY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loyV55JY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C69C2BCB0;
	Mon, 20 Apr 2026 22:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776722423;
	bh=06k+L69MGxQpyUnpeTop53TZeyKH6tZudEvym3TXPfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=loyV55JY+upSRkNglfQQ/PStacCmDmuCY//ffr0qQiq03WwS+2pft9XwIvMbP+fEf
	 X6JbocgAPod78PFI3yuHm+hIqinzZHvRaCR7tcErthJhpcoF9nTi2sYeqUpJ5DOxe7
	 6XU0YVjv9TEQdpIrtqtKTjfRCUWTGgoRTyzU/9FKBDNDYvAt27cn25Q/IZLZSmjXl4
	 eh27z2Eeye6wQ3s0x6CIPtZyHH4TxM/omyf6wrTPHJLMl7S6dBj0MXlfIbO0OZgNKA
	 dwKy/BS8HSERCceVi+UGOdh3WiEsS+R5/Q3gPn0Ry6xLTLNvm9QcXi3IkjOk+z9eFS
	 QfY6fBkquommg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9541C3930022;
	Mon, 20 Apr 2026 21:59:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177672238729.1802062.5676745432497911101.git-patchwork-notify@kernel.org>
Date: Mon, 20 Apr 2026 21:59:47 +0000
References: <20260417055408.4667-1-devnexen@gmail.com>
In-Reply-To: <20260417055408.4667-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bestswngs@gmail.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Apr 2026 06:54:08 +0100 you wrote:
> gtp_genl_send_echo_req() runs as a generic netlink doit handler in
> process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
> which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
> on softnet_data.xmit.recursion to track the tunnel xmit recursion level.
> 
> Without local_bh_disable(), the task may migrate between
> dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
> per-CPU counter pairing. The result is stale or negative recursion
> levels that can later produce false-positive
> SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.
> 
> [...]

Here is the summary with links:
  - gtp: disable BH before calling udp_tunnel_xmit_skb()
    https://git.kernel.org/netdev/net/c/5638504a2aa9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


