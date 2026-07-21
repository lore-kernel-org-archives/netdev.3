Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106863655D1;
	Tue, 21 Jul 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632838; cv=none; b=OibU8IyOH0s82DbON9UAxr3cxXOBTD7jN9mrgZnXZNhIgyMluuQoKr8l55r2OXO8pTnnYyN/z6ZWuYO6RtujmtENKcNvjGKRds+gIzY+iRc/q9IXKBgh7HhjWxuKL+t6TL+jbWkf5QXMgnJ4z5mQi9UGOqbprySKErpIatXBtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632838; c=relaxed/simple;
	bh=S/wevzEoJQvqGIkm2P0X8RL4VLSkcr/3udiT2Zo3tJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k8AcddRYwL8a3NxpHg3IMZyWCL0ck6gLAjOc+AmKNdDpahdETKyzfc3GY0Y5YmD+5PFSvO4BVjns+EbuDsy0GjOPXtH/4xXl8CmKaAjtgTa++2kw0lWn9cmxPjp21s3iJd5zxB4YowoROctTe8JWTRMnxHIZh7CKnYbxLRJD0lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHmieMaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHmieMaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DAD1F000E9;
	Tue, 21 Jul 2026 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784632836;
	bh=Wh+HJb9GM14tFokmmCpbW6n5bKMmv4CN3/o1nkQ0M78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lHmieMaFW/U9TxVbfBLGlatR1bCuYEYMLGosOumbL6fYinNqpMqCfwYr6GILsFkLt
	 x4Ydh2fwoJ+6lxOMpYLkUBWMGJRYMMWnElPOhXtVb18zldykE3qVw3/ZLFsQMrApRZ
	 tjcVY24DVC/ovu2xAUtxfjh3e2EYoUNTa3X5nwebxBRBs6A82PRGUNu02fdyO8HJL5
	 Nys481HF9je7hNIvEj1ClHNDdQBDlDtEo7KOlnA6F/mfwglaGPYEKikxgR60rRskRC
	 H4rfkHVdHyiP302edm9zyW1zXce1jAlzsaMYQL/hCdiNke/puuxg2YgNsOhRIoP/76
	 PpFoUwugnmi1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8C8873924FC0;
	Tue, 21 Jul 2026 11:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wan: wanxl: Only reset hardware after BAR mapping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178463280640.237147.335286475786801784.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 11:20:06 +0000
References: <20260708143415.3169358-1-ruoyuw560@gmail.com>
In-Reply-To: <20260708143415.3169358-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Jul 2026 22:34:15 +0800 you wrote:
> wanxl_pci_init_one() stores the freshly allocated card in driver data
> before the PLX BAR is mapped.  Several early probe failures then unwind
> through wanxl_pci_remove_one(), including failure to allocate the coherent
> status area or to restore the DMA mask.
> 
> wanxl_pci_remove_one() unconditionally calls wanxl_reset(), and
> wanxl_reset() dereferences card->plx.  On those early failures card->plx
> is still NULL, so the error path can dereference a NULL MMIO pointer.
> 
> [...]

Here is the summary with links:
  - [net] wan: wanxl: Only reset hardware after BAR mapping
    https://git.kernel.org/netdev/net/c/91957b89da99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


