Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04933FE09;
	Mon, 26 Jan 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442591; cv=none; b=IOxOwRMZqGpjkE7d5FUD8dKdmc2hseh9Shq7pArWGBxm3MqyMZSIMRKghy/xVGYJY/+OX15kz6tmM+3xkbtEdBrSkEuMO8rOCfTgQtxBHThOqI5KfqdwomYm/VymgwSsx0QhC2BLs88PPvP0LJn7fh10XrIn4Xe9TaLBoKO9wPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442591; c=relaxed/simple;
	bh=v3a15doasnpvbxOQ+dTGNYVqdb80kx+mxeqSmJnrgUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnYwdd54OQZ/M4JJ6zJlIOiHRIIdCz1L/flcvuLYj73Yl/j/CemXMZO65Q5d3qZDDW+IGZ+NXsNjtH4x18Ub166g0rvKwqWt/mvRN+9vWIg0xR3bW/TGMGzlIQ657F0tw9PQKK4oD20XoOoz/dJl2W0ynIfFBwIzDZb2N1TY4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhmEolgA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhmEolgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A3C116C6;
	Mon, 26 Jan 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442591;
	bh=v3a15doasnpvbxOQ+dTGNYVqdb80kx+mxeqSmJnrgUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhmEolgAGDqHNCYEJLjkhMfrFvqiuOp++nrzh3I1+xKQPqP1fBj9+8PcbUUg+Gukh
	 0PJAoo2J/ptGqO3hQ0Ce1LGfM2n5oCkXsZVfZWHDmK4uTdZgajGH6RpPA2hGDlbeG+
	 gnMMf2vCmDNfzDUc8CsW3HyDqRTxbdSMvMrvX3uFtmQTtfHXSjtTCKoS88TIr9NFZD
	 fbAJWlcotUteyEJi0japkidVPLEg1VKGq1qTOdlMTtio8b4jScSDiQWKpv98J13hM1
	 qU7LQgBkxVO1zz4Vc25zkWv1zZChC41PETMddmNEn6fXHnU5hLkI1O2fhsbRQStliA
	 ZcVtC9g1twvuA==
From: Simon Horman <horms@kernel.org>
To: zilin@seu.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kory.maincent@bootlin.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	pabeni@redhat.com,
	marco.crivellari@suse.com
Subject: Re: [net,v2,2/2] net: liquidio: Initialize netdev pointer before queue setup
Date: Mon, 26 Jan 2026 15:49:41 +0000
Message-ID: <20260126154941.1391119-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124124205.102499-3-zilin@seu.edu.cn>
References: <20260124124205.102499-3-zilin@seu.edu.cn>
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
net: liquidio: Initialize netdev pointer before queue setup

This patch moves the initialization of lio and props structures earlier
in setup_nic_devices() so that props->netdev is set before calling
netif_set_real_num_rx_queues() and netif_set_real_num_tx_queues(). The
intent is to fix a memory leak where the allocated netdev would not be
freed if queue setup fails.

> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index 3ba2806f5d1e..2383f0173a54 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -3505,6 +3505,16 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
>  		 */
>  		netdev->netdev_ops = &lionetdevops;
>
> +		lio = GET_LIO(netdev);
> +
> +		memset(lio, 0, sizeof(struct lio));
> +
> +		lio->ifidx = ifidx_or_pfnum;
> +
> +		props = &octeon_dev->props[i];
> +		props->gmxport = resp->cfg_info.linfo.gmxport;
> +		props->netdev = netdev;

Moving this initialization earlier fixes the memory leak, but now if
netif_set_real_num_rx_queues() or netif_set_real_num_tx_queues() fails
below, the cleanup path in liquidio_destroy_nic_device() will proceed
further than before since props->netdev is no longer NULL.

Previously, when queue setup failed, liquidio_destroy_nic_device() would
return early at the "if (!netdev)" check. Now it continues and calls
cleanup_rx_oom_poll_fn().

In cleanup_rx_oom_poll_fn() (lio_core.c), the code does:

    struct lio *lio = GET_LIO(netdev);
    struct octeon_device *oct = lio->oct_dev;
    ...
    for (q_no = 0; q_no < oct->num_oqs; q_no++) {

Since lio->oct_dev is not assigned until much later in setup_nic_devices()
(around line 3602), it will be NULL after the memset above. Would this
cause a NULL pointer dereference when cleanup_rx_oom_poll_fn() tries to
access oct->num_oqs?

> +
>  		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
>  		if (retval) {
>  			dev_err(&octeon_dev->pci_dev->dev,

[ ... ]
-- 
pw-bot: cr
