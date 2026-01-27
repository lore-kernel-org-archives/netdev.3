Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468A2D7392
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769489084; cv=none; b=tzJ1EOE27Tcj/ib98h84kvWPMQ0amd9RKh2Pjy2caf16lGL3BTwy3AXElkrhmdn2vY2icUyrQtLrVYsUSntep5O58ulGDiPRuTeCWG/o7iiWZkJKJ8MFfoSHHYapsxmXHqH+m0yXryckToc3hjC/cns9HrT2xyoguxCSMbKQKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769489084; c=relaxed/simple;
	bh=zwGEzh3nBGeDi5CcneVNrEGNGOWiWoUzhcPWsXVwgIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkP88jSVMQW+z7LeI8OFGL3B3ZOiCvfM0MrdBNjxs7s9BJSjsZbbwUHlWiVqS/LxeZyeVJd9IrsY6FwAqgT92nkAklsmmbQ3b9tH3+p69L4b4Ic0eRpR6Sj+B+5zvqzeXCTCLb9Ppx/uMt/2kANnMe9n0Onz+0+kO3reMsJYegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btmIWnzJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btmIWnzJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0B7C116D0;
	Tue, 27 Jan 2026 04:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769489083;
	bh=zwGEzh3nBGeDi5CcneVNrEGNGOWiWoUzhcPWsXVwgIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=btmIWnzJWN7vO7usXFEux+H314KvRQ4QybgK12OA9ZhZfrnO0OLCoDNyidLgddr07
	 xroRF8T9/+09huNozvJNw5SZddaKo8X87utX+EsgwGMlEW3L8cVHwVp+/M6hsXdRsf
	 /0qR2n4Bfca102G1brNcIQCwvM6zg/ipCT0hJLJajBlaQCDxd2YQhVab30mmytFKj+
	 FPoJp/0T2wm907BvBNWm4sE7m8QkMtCvs2XiDaaTjR+Al9ImLNmlvQWowFVW41B0VO
	 F8tjVnTXcypBDPil3JaIYjct9e+jWmhHIfjOTvv8uFZ0qcwTfVxbr4EPifOwkbkNR7
	 Kwr0vXEb6KOhg==
Date: Mon, 26 Jan 2026 20:44:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, Philo Lu
 <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Vadim
 Fedorenko <vadim.fedorenko@linux.dev>, Dong Yibo <dong100@mucse.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Lukas Bulwahn
 <lukas.bulwahn@redhat.com>, Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v22 4/6] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20260126204442.4ae27de4@kernel.org>
In-Reply-To: <20260122120508.17452-5-xuanzhuo@linux.alibaba.com>
References: <20260122120508.17452-1-xuanzhuo@linux.alibaba.com>
	<20260122120508.17452-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 20:05:06 +0800 Xuan Zhuo wrote:
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> +{
> +	int err;
> +
> +	if (!netif_running(enet->netdev)) {
> +		enet->cfg = ctx->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(ctx);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_netdev_stop(enet->netdev);

[1]

> +	enet_bind_new_q_and_cfg(enet, ctx);
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err) {
> +		/* Although the notification to hardware or the initial IRQ
> +		 * setup has failed (which is, of course, a very low-probability
> +		 * event), we do not immediately free the queues resources here.
> +		 * Instead, we defer their release until the normal NIC cleanup,
> +		 * or until the user or hardware triggers a reset operation.
> +		 * Because that the dev is running.
> +		 */
> +		netdev_err(enet->netdev,
> +			   "eea reset: active new ring and irq failed. err %d\n",
> +			   err);
> +		return err;
> +	}
> +
> +	err = eea_start_rxtx(enet->netdev);
> +	if (err)
> +		netdev_err(enet->netdev,
> +			   "eea reset: start queue failed. err %d\n", err);

This looks questionable, eea_start_rxtx() can only fail if
netif_set_real_num_queues() failed, which in turn may fail 
for sysfs-related reasons. So we're not talking about "rare
HW fail" scenarios in this case. Memory pressure or name collision
would be enough. Seems like this is easy to address. 
Move netif_set_real_num_queues() out of eea_start_rxtx().
This way eea_start_rxtx() can start returning void (can't fail).
In this function you can move the netif_set_real_num_queues()
call where I placed the [1] marker, before any changes were
actually made to the adapter.

Looking closer eea_active_ring_and_irq() is also calling kernel
registration functions which may fail, like request_irq().
You should do all of that before you actually shut down the adapter.

> +	return err;
> +}
-- 
pw-bot: cr
