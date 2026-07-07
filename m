Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E21F03DE;
	Tue,  7 Jul 2026 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414227; cv=none; b=J2/n6o5imZHbMzViHgbTgIgrAvtUmTQHbs3C1zxB0RGwVfU8UhWEw6cbAM3DpH1RxfaXxNwgRA812IH5RAngCDJZ1ZdMfDnbsTZopQNfjAfj7gmn0Jjf4eG3Hqb/JSlkmTTRdZuedubGhSQ8ZB/rkU478NdRYcj8fDHOiNaiS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414227; c=relaxed/simple;
	bh=FKb4BsfVC/tL0N20qyQjzjSyMflTkq0w0aHFpPZvibQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iIS6SbkQpksGZ535UHpwSttnVk7uMiWRz+uDT5EKDeTrnR8OfoSPitrcEzJuf8UPW8QTI5v+tlDq3uoSf9TpBEQU5XyS8Md3Bt1tuBTQrV1zwDdAlyBUZDVln3fGEsLUcHsVT7AymIHLhx/8FxeTenkg0rSaNqYbDnvuJHD9Y9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfXVLzF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfXVLzF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20F01F000E9;
	Tue,  7 Jul 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414225;
	bh=/1R95VBdcBCmYMzN5VKoe0X1xPdMKaWfCCLMc+LU/Wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EfXVLzF1Erq9EsHcVwZXDRTxfYDzi+wBEWAJiCB8HKG6c0JfcB8VPaLMto3SCoxQn
	 wuqDI2llyasAfbOdIi5ZsWcY6slkMqbl1iI4X+Ed+PD86zphKoxe0ZNbjKBniSr11r
	 gpz1VJx3N7iOBTQ5rkHkPJfNjge+sDe7CYaAes+KIIlw0Q+0OwyWwYpyWA6l9IMI+g
	 V7zLgP8VpVaytNPbPLUfbhVCUAvfJlDpXDrlXQBzU0Vi5WwIfVGegC/a8RJYwhm6+j
	 kXZcl2QLtRcBZFY77cvzvAtsBBrTb+v5S0NSro+TbtJC9H33CdG+rNhQ1BeALuJfZr
	 zLlBcWH2XtD1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198683925466;
	Tue,  7 Jul 2026 08:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/1] net: rnpgbe: fix mailbox endianness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341420564.1435352.6528576427497470929.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 08:50:05 +0000
References: <20260701032208.1843156-1-dong100@mucse.com>
In-Reply-To: <20260701032208.1843156-1-dong100@mucse.com>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yaojun@mucse.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 11:22:07 +0800 you wrote:
> The rnpgbe mailbox exchanges data through 32-bit MMIO registers in
> little-endian wire format.  The original code had two problems:
> 
>  1. FW structs with __le16/__le32 fields were cast to (u32 *) before
>     reaching the transport, hiding the endian annotations from sparse.
> 
>  2. No cpu_to_le32()/le32_to_cpu() conversion was performed between
>     the CPU-endian MMIO values and the little-endian payload, causing
>     data corruption on big-endian systems.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: rnpgbe: fix mailbox endianness and remove pointer casts
    https://git.kernel.org/netdev/net/c/d9d6d67f4c08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


