Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB6329E7C;
	Tue, 10 Feb 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735010; cv=none; b=FDZK+bgil7nIDWrR3ljTVjqLFZdozeCtkaPDv32dBhHwji6+/vHEYjKXMm7At9mo8t1HJ79qOtMWvE6za3/hYpb5BkXRBm1d2tt2ytrzCE56BIV8oskLZawXmIxZviSFUN/zclSEnpw40ktTVKLlZ4XuoZRPDxiXPm2lty3SM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735010; c=relaxed/simple;
	bh=S9sMl+pXFGT4PjtyUpMSEQ44zxWKdkrQgC0O2rcIhBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kdQ5b/iKDqiF5+DBb/kNYczwk3hlqGvUsIx0UfvSQ6Its+9MW9HZKo5q+a0p6NfC9oDQqG6OpCmgCMYqtciEIrRJ6DJbuFBpdo+g/oy0Qpz3tKQaUYeWmhQ+cv5vgVq7bZaRCr8Bqa7iTp5m75B46cLM5RZQ7YGvXeZQjHBS7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEwVTWFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEwVTWFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BAFC19421;
	Tue, 10 Feb 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770735010;
	bh=S9sMl+pXFGT4PjtyUpMSEQ44zxWKdkrQgC0O2rcIhBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UEwVTWFLKSt/WhE7OKA1H6UDvD9sAuQ0wZFTRpShCkt6kHPAdM9F9y/h/gI60yv6l
	 v5aL0ED3NwS9BQNNS5vJ8LaZ/F5cxcbRMz4LDNj3KqUOQ7wgJmoMSEZ1NnZPcvCHvZ
	 aeYqdUVX49nvrJ2AGh5qZMWx+KVjd4nhnoZicm/ILvVCC0vse05MJxHGSDf4o7nCJy
	 W+BEZapPZm/J++pcfRaNXhjzUwqCXHjIxikIzmqIIjnL8AJkWI/4NfKEbF7cdkzAAu
	 fqWgZIqh7UjR/qRx5BpIK2TkuuqjVi5ccCycgskBsMYW/x9oFbhaVVyNnpVPGl/1Dn
	 V5xUPDyN5ZJdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C24A639D267E;
	Tue, 10 Feb 2026 14:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v2] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in
 uhdlc_memclean()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073500558.3540157.14031494476028683223.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 14:50:05 +0000
References: <20260206085334.21195-2-fourier.thomas@gmail.com>
In-Reply-To: <20260206085334.21195-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: chleroy@kernel.org, stable@vger.kernel.org, qiang.zhao@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Feb 2026 09:53:33 +0100 you wrote:
> The priv->rx_buffer and priv->tx_buffer are alloc'd together as
> contiguous buffers in uhdlc_init() but freed as two buffers in
> uhdlc_memclean().
> 
> Change the cleanup to only call dma_free_coherent() once on the whole
> buffer.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()
    https://git.kernel.org/netdev/net/c/36bd7d5deef9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


