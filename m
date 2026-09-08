Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7484E8E07;
	Tue,  8 Sep 2026 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858677; cv=none; b=i7eXS+r8U3KwOJjzasehiBJnMzCI74s1akGcaxX4+JmnVzQxJL1QBvm5vLgnOBrYzqLAH57xx+v/RRZ4xweEy7JLAm1qcym8FVtmxit8pJqGufvrafDaigFVyyMXGhrGid+3bFcv1QF4N1I+nZnvw22/xcBTi4j0OYzaknc64wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858677; c=relaxed/simple;
	bh=+3btd5WgCHqoZO8DBBwZqOvoGiZ7crnxFvPRGwclc4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QzD6EFceKj50k17bOFecl+DCgOnQ7y4+jHHlu/BgHpxM98Co+iRqHr6AXt9JNPNZrCaJ2cIckWg3K5F6O1po+U75RjNzXFLKX9O+lIVF229VcT+DEx7iqQK/qrLoEL5azSJrN+W6qPuXsDd9lEmBYc1smqnGek9wY7ZkJFsgOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhLUgQrs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhLUgQrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177C21F00ACA;
	Tue,  8 Sep 2026 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788858676;
	bh=ndRdMcwnkFGikzpl5JS7//Vvr8AHHO3YvKyHpC5XDbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dhLUgQrsliKb82zwoq9MsPvO2lPVk1rgShQod1IsX8px6N5nO74KwLj8L2pUbiAaN
	 ixSgvl12sFmgbTcpx0H6bTtDH32aO/QLqnlQC4GL5O1TRpSkk0+eeDFRgm3NaJnuZS
	 gXNA8nqSohkdZHZnp6dh/UmOqbrVOTIGzj627DhsNuwbpcc3+k+QjUNQYT4Q1njJeM
	 MijGj1co7V4M17wnXFIv+/mCAwXvpTVX6hdu2RllKVS6mR9MA5pfQnZ9uJVp9TCrON
	 LAB6wU7ATi7/9CKz8JnTxMotrtAkgWbDJQv+OvoALd09nMOwmy1+v6CJsLGuKmLDrR
	 YdrYy4sPLp87A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B20D839E8A73;
	Tue,  8 Sep 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/6] Fix a variety of TPA bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178885860664.3400066.8895939059111187917.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 09:10:06 +0000
References: <20260902015652.2421609-1-joe@dama.to>
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com, colin.winegarden@broadcom.com,
 rukhsana.ansari@broadcom.com, linux-kernel@vger.kernel.org,
 raphaelcf@meta.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Sep 2026 18:56:43 -0700 you wrote:
> Greetings:
> 
> I am sending this series as an extension to my v4 [1] which was just 1 patch.
> 
> Note that patch 5 of this series can now cause the device to fail closed if
> memory is tight; bnxt_init_nic propagates an error that was previously
> swallowed and fails closed instead of succeeding in a degraded state. If the
> maintainers want the device to come up with a partially populated rx_tpa[],
> then patch 5 can be dropped and this series can still be applied
> and will otherwise work as intended.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/6] bnxt_en: Only restore LRO if the device supports TPA
    https://git.kernel.org/netdev/net/c/4e17b5007b66
  - [net,v5,2/6] bnxt_en: Don't free the live ring's TPA state on queue restart failure
    https://git.kernel.org/netdev/net/c/5ce7f36c334d
  - [net,v5,3/6] bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
    https://git.kernel.org/netdev/net/c/b814dfbfeb0a
  - [net,v5,4/6] bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
    https://git.kernel.org/netdev/net/c/961e2a17c5e3
  - [net,v5,5/6] bnxt_en: Propagate RX ring init failures in bnxt_init_nic()
    https://git.kernel.org/netdev/net/c/8e6a850c0746
  - [net,v5,6/6] bnxt_en: Bound SW TPA IDs to prevent crashes
    https://git.kernel.org/netdev/net/c/c0aceaf65b70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


