Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907E4BE425;
	Thu, 15 Oct 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053007; cv=none; b=l1x2irfF9sUBUamybjBThzHU4pNo5Tr6D+5dzz5CrtJX3r3PW4ol2h6Cjs7Zq2SLTGrijnBOWP1vtqCypYb9g/ixZ/ojJptwULxuip2L6+L9hYBzuU8tkB7EvgolE12YIfuGMXzg99nC/F3eeZMoFL5Vnn0nmc/IPiX2V+q5utQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053007; c=relaxed/simple;
	bh=/yNCBjD6zEKGhapY7yyv3en/5N94RICa9BTGaxclrNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hwDHXcemotEYUa3qLX960b/KVkAD155kuTjUmXDM98Gq47FiSp/woZGRuWuGh14+AqhDSAH83qvz1dijbTK0grCNjpgh66bb6ES5ocHJufmlZie51KhwhCHWWhBrz22lPB/4KBcoWqXlCpe+SvmtU/jR55mAa6z+Af3+8MFWLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb0o7n8K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb0o7n8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B1E1F000C4;
	Thu, 15 Oct 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053006;
	bh=vWV7sVpCqRZVlc8/HSEKHdJAQHGfHfx+CIYPH7P4240=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Pb0o7n8KXTKw/72y3UFARE0fePaw1zxFIZ+mnAaYMOg5qpmh8YzqZmvFyVhMQA4Mx
	 BeU7o798jLFVjXI6A67K/NWr1+9X0mJdrY1MBypx84JNlW4J6P4ri0sGHWPAtzpdsF
	 jPcpiaH20C2Z5cUdr7Ahas/2VZvXqf5ZZuE7t1YFkP/VzaxF1u3JYYgwcVSUs0/Ix4
	 ifoBGee11wSf/AOJaGk5vG9+ztk44+/q6+AhAtL7xNNk5TjGrPDrd7VmibXtGV5VOv
	 NKMLOV7soax7qex4B5Px8YLlmrNmvUYwyhQRvK5p8W0a8WBdkCZapGsqJlZF6ufYhU
	 SERFjndawam1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1587392E9E3;
	Thu, 15 Oct 2026 08:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] veth: clear rx queue hint in veth_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179205300452.3274548.12341366462163041168.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 08:30:04 +0000
References: <20261009040412.14571-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261009040412.14571-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 toshiaki.makita1@gmail.com, john.fastabend@gmail.com, daniel@iogearbox.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  9 Oct 2026 12:04:11 +0800 you wrote:
> With more tx queues on one end of a veth pair than rx queues on the
> other, and RPS or generic XDP enabled on the receiving end, we get:
> 
>     veth1 received packet on queue 2, but number of RX queues is 2
>     WARNING: net/core/dev.c:5212 at get_rps_cpu+0x560/0x1360
>     Call Trace:
>      <TASK>
>      netif_rx_internal+0x1af/0x4c0
>      __netif_rx+0x99/0x350
>      veth_xmit+0x713/0xca0
>      dev_hard_start_xmit+0x166/0x5f0
>      __dev_queue_xmit+0x1797/0x42d0
>      ip_finish_output2+0xa34/0x1f40
>      __ip_finish_output+0x510/0x7e0
>      ip_finish_output+0x2f/0x320
>      ip_output+0x17a/0x3f0
>      ip_send_skb+0x1bc/0x220
>      ......
> 
> [...]

Here is the summary with links:
  - [net-next] veth: clear rx queue hint in veth_xmit
    https://git.kernel.org/netdev/net-next/c/1b1c0e87cfe7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


