Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600FE4E73D3;
	Fri, 16 Oct 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165213; cv=none; b=sfe5b8hITSk4wDjgaon32UeCJvNLHMkhw8d3do07koIP9Tp9knSOeGSpwKMBDYWBmFAz+WH58EYOhRpz5l3d43TFuOne0h5TD9vfUd67CIsWsJjReVs2+w5Vsu61GaQY2eTiZuU1kOLBxa5ty+O3uG6OaQPzhrooIL7z0MBr1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165213; c=relaxed/simple;
	bh=kpnhysZohGz0b+ZHYDgrOP3fuFRSCFDtr38eFnrsG3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=atTBLcsu+ER1RCFIAMzA6CY+MsJOtgkeEZt0B4224OlE++ayEmRqmGNrqv2HJzz1BaUHVl1Bp12T3Nq81sxAAEW78NZgdbieBxFTTjaHWJDRywETDZp15dNJLj0DBrjXJ7oKc1gL5lAKGJW56R27ZjKWcg4wnwhUG24twi+lDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUPoKfLX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUPoKfLX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AA21F000C4;
	Fri, 16 Oct 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792165212;
	bh=DZtiGFqMh+o3ljit957qlfXy+ROtKb6EffqVfJk10dw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CUPoKfLXnxV2PxgvdtR1PC4qaR7xyRIsFiyUKvsXY4OCyuBSqNwRw1+yBsKCt+O/A
	 3s8M43zXI7mo7wrMOR15Bac8QrZgT6+j8yu1D5UJ9cAg95j4V7XPywD51BIKimVuN7
	 IzCu9E4MSG0GsPKVgbAcskLvK1ql3zSjw3hMGqwc8Jsi+s0Qt0A9Q5wbRDcnGG4uya
	 Tsa9LhpLQyLGorz0LPAHR+YR/S0hSvvdKGEMKXdbZvKgwN0/6lDCKMgO5lop7Rv2bR
	 Tf/bLo7QZBe4q511N+Wo10Bcmgj5uOxrrJuGeUwQ+/xt20MIErPU9A9qOsdGukuXAy
	 q+J6meNmc7wVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1616380A96A;
	Fri, 16 Oct 2026 15:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179216521051.826981.1505486150445247313.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 15:40:10 +0000
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
In-Reply-To: <20261004215937.302247-1-omermetekaya0@gmail.com>
To: =?utf-8?q?=C3=96mer_Mete_Kaya_=3Comermetekaya0=40gmail=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: netdev@vger.kernel.org, oneukum@suse.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.laight.linux@gmail.com,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 00:59:25 +0300 you wrote:
> tx_complete() calls this_cpu_ptr() before disabling preemption, which
> triggers a BUG when running with CONFIG_DEBUG_PREEMPT:
> 
>   BUG: using smp_processor_id() in preemptible code in tx_complete
> 
> Fix by using get_cpu_ptr()/put_cpu_ptr() which disable preemption and
> return the per-CPU pointer atomically. The usbnet_skb_return() hunk
> is a hardening change: that path runs in softirq context so no warning
> fires there, but the same fix is applied for consistency.
> 
> [...]

Here is the summary with links:
  - [net,v6] usbnet: fix smp_processor_id() use in preemptible context
    https://git.kernel.org/netdev/net-next/c/95a5c641fc7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


