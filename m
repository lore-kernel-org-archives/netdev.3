Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2882244694;
	Mon, 26 Jan 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442652; cv=none; b=gKSHLv8rMhZwbv05JsJIwP/zyRVIr86wTo0DmhGGzG850jT2UNRA5UEuTOqjyoxNeEz6Gh8AdWP+6JFO/WxOgQH5UBXXM7r+lmuliFA/h5hKI82N6ETC7RnIc5f23mOGQMjzL8FwdjpGLZJL/nENI0EMW+aJ6kMlGn0tUE+ZPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442652; c=relaxed/simple;
	bh=6kWoafS4t+BNCy3BJ1dQfqSVs0Vt7p6TcmeOglpgJpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlYf3ezAYV4coH36sKVY4BCiYzPD6jQWGbCh7LDc6Q6R0MYM3sy2TouA2Qc561qUDmQ6YdVAF3THUPCPpRZpbcKkxIu6iFTA+CLaC0i9la+xxyLPJhYvcnxfjgr8yuuW0gCmSx06HPogcLIqQjzGNI2EE+iz4l84jxsEzgPdMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8eeR+rO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8eeR+rO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16712C116C6;
	Mon, 26 Jan 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442651;
	bh=6kWoafS4t+BNCy3BJ1dQfqSVs0Vt7p6TcmeOglpgJpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8eeR+rOCodTSQfOm9iYpJMw3G+qcOGRFukdqwF//DI18j4dijYv+ADHnmK1ae2Gy
	 dE1d2dXHLjjrcTgcXPw4z8RJ3dknQOGp/AtGjYhmJO1QEWDk7puIx1EKRzGhvYDpRb
	 tomiCKWIKeXIlloLwniKcGdq3lAvvCwIW0aKEe9O41OS4Ln1EnZvBohfxwUiAaxOci
	 1BW/5Sbd9SI/Xbd+pjvgT7A8uzMGPXIB6/zbZJxn4chlNy72Nf/Qc58AQdp88x+ocK
	 5cw/PaaVHMS89vzAUtqbyXZoYxjeLau0Z7BnYeXLEpz3+zr08NCqK7QNSjGeEZiaO6
	 4yBXomH4TtxeQ==
From: Simon Horman <horms@kernel.org>
To: zilin@seu.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	kory.maincent@bootlin.com,
	marco.crivellari@suse.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [net,v2,1/2] net: liquidio: Fix off-by-one error in setup_nic_devices() cleanup
Date: Mon, 26 Jan 2026 15:50:39 +0000
Message-ID: <20260126155039.1391193-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124124205.102499-2-zilin@seu.edu.cn>
References: <20260124124205.102499-2-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: liquidio: Fix off-by-one error in setup_nic_devices() cleanup

This patch changes the cleanup loop from while(i--) to do{}while(i--)
to ensure that when a device fails to initialize, it gets cleaned up
along with all previously initialized devices.

> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 0732440eeacd..3ba2806f5d1e 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -3765,11 +3765,11 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
>
>  setup_nic_dev_free:
>
> -	while (i--) {
> +	do {
>  		dev_err(&octeon_dev->pci_dev->dev,
>  			"NIC ifidx:%d Setup failed\n", i);
>  		liquidio_destroy_nic_device(octeon_dev, i);
> -	}
> +	} while (i--);

In lio_main.c, setup_nic_devices() can also reach setup_nic_dev_free from
the devlink_alloc() failure path after the main for loop completes. At that
point i equals ifcount (the loop counter has been incremented past the last
valid device).

With the do-while change, the first iteration will call
liquidio_destroy_nic_device(octeon_dev, ifcount) for a device index that
was never initialized. The function has a guard for NULL netdev so it will
not crash, but it will print a spurious error message about a device that
never existed.

The fix works correctly for failures within the loop (which is the case
described in the commit message), but is there a way to handle the
post-loop devlink_alloc() failure case without printing the spurious
error message?

[ ... ]
-- 
pw-bot: cr
