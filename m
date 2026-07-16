Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB5B392C39;
	Thu, 16 Jul 2026 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194493; cv=none; b=j71ZDjYQ66N262+g+dxQgJE1KLOwxcfN2BXBcnviVRuvml9nKADEKNaOvjE4jAOipu1uuCb67e+JkiaYQzY8dtxi5ypFQigQTmEneIg+jDv2k0+kddM7OCzJCWyUS8oxNN4uw5prX2u4QUG8WXb5jlE8b6pLsL9rl4gjfxt/Chs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194493; c=relaxed/simple;
	bh=piGvS9odsFqceYHmKyj89Egg30SAmpFDNbFAimmJCfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+caOhfxIm/ff4+Zt20WIq/sKo9GHJ9n0yzamndotWiZik6IX8u7CAovudW1szmNapTBydKPbWUPksudkb/EWLOx2y0Ie9c2tRA42jHUEXYMaG8F8xH0eeFo9p+ACsZUgZhBkYw3tNYq81ll6LId74BT3PqBNsCTFngs6FHk3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btzwrW2W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btzwrW2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599081F00A3A;
	Thu, 16 Jul 2026 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784194476;
	bh=6TV8tl8agqKwLpgfHtmJHvY+8PG3WpGYxYzrYv+Oy+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=btzwrW2WHUhoHzOAas/Q8lx/bETANDijmUL3bYGTX3QlggJmQiTq8Tk5IhZ83nOcs
	 D5Qn5Ceu5eXEJHDnkLCHMibfsdWy8aJd3Ki1cNSeRXW/seJUuwo6hg8Os2ZKVekRQf
	 oqjT95fcO3utuaeudnh9VMPxS+YI08GfB6tSPKdQ3OoDuNqjUBYVwRiq5zJf5r37tD
	 0mh0xgYvlFN8ZYF83ji6FXT9yQTcnEH4DzXWrgwIKXMxs8DcO7W1ipm7jBFbIcuosl
	 isV3SQQCeZCjuGx5Ym1JZoDvn/j1VX82kRK7LJQF1U15+nqDnWZRX7DQu2IHPAb7eV
	 QmzRuHJiia5lQ==
From: Simon Horman <horms@kernel.org>
To: jackbb_wu@compal.com
Cc: Simon Horman <horms@kernel.org>,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	wen-zhi.huang@mediatek.com,
	shi-wei.yeh@mediatek.com,
	Minano.tseng@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 6/7] net: wwan: t9xx: Add AT & MBIM WWAN ports
Date: Thu, 16 Jul 2026 10:34:29 +0100
Message-ID: <20260716093429.231132-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709-t9xx_driver_v1-v4-6-a8c009d509c5@compal.com>
References: <20260709-t9xx_driver_v1-v4-6-a8c009d509c5@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [6]: [PATCH v4 6/7] net: wwan: t9xx: Add AT & MBIM WWAN ports ---
commit 1739a55610bf7a44ce24874819e01c07236d9442
Author: Jack Wu <jackbb_wu@compal.com>

net: wwan: t9xx: Add AT & MBIM WWAN ports

Add AT & MBIM ports to the port infrastructure.
The WWAN initialization method is responsible for creating the
corresponding ports using the WWAN framework infrastructure. The
implemented WWAN port operations are start, stop, tx, tx_blocking
and tx_poll.

> diff --git a/drivers/net/wwan/t9xx/mtk_port_io.c b/drivers/net/wwan/t9xx/mtk_port_io.c
> index e3a2de6d2f297..882254b74026f 100644
> --- a/drivers/net/wwan/t9xx/mtk_port_io.c
> +++ b/drivers/net/wwan/t9xx/mtk_port_io.c

[ ... ]

> @@ -234,6 +376,198 @@ static const struct port_ops port_internal_ops = {
>  	.recv = mtk_port_internal_recv,
>  };
>  
> +static int mtk_port_wwan_open(struct wwan_port *w_port)

[ ... ]

> +static int mtk_port_wwan_write(struct wwan_port *w_port, struct sk_buff *skb)
> +{
> +	struct mtk_port *port = wwan_port_get_drvdata(w_port);
> +	union user_buf user_buf;
> +	int ret;
> +
> +	if (unlikely(!skb->len)) {
> +		consume_skb(skb);
> +		return 0;
> +	}
> +
> +	port->info.flags &= ~PORT_F_BLOCKING;
> +	user_buf.kbuf = (void *)skb->data;
> +	ret = mtk_port_common_write(port, user_buf, skb->len, false);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
If mtk_port_common_write() successfully sends the first few fragments but
fails on subsequent ones, returning a positive partial write count, does
this code silently drop the remaining data?

The condition ret < 0 is false for partial writes, so the SKB is consumed
and 0 is returned to the caller, falsely reporting complete success to the
WWAN core.

> +
> +	consume_skb(skb);
> +	return 0;
> +}
> +
> +static int mtk_port_wwan_write_blocking(struct wwan_port *w_port, struct sk_buff *skb)
> +{
> +	struct mtk_port *port = wwan_port_get_drvdata(w_port);
> +	union user_buf user_buf;
> +	int ret;
> +
> +	if (unlikely(!skb->len)) {
> +		consume_skb(skb);
> +		return 0;
> +	}
> +
> +	port->info.flags |= PORT_F_BLOCKING;
> +	user_buf.kbuf = (void *)skb->data;
> +	ret = mtk_port_common_write(port, user_buf, skb->len, false);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
Can the same silent drop of partially written SKBs happen here?

> +
> +	consume_skb(skb);
> +	return 0;
> +}

[ ... ]

> +static void mtk_port_wwan_enable(struct mtk_port *port)
> +{
> +	struct mtk_port_mngr *port_mngr;
> +	int ret;
> +
> +	port_mngr = port->port_mngr;
> +
> +	if (test_bit(PORT_S_ENABLE, &port->status))
> +		return;
> +
> +	ret = mtk_port_ch_enable(port);
> +	if (ret && ret != -EBUSY)
> +		return;
> +
> +	port->w_priv.w_port = wwan_create_port(port_mngr->ctrl_blk->mdev->dev,
> +					       port->w_priv.w_type,
> +					       &wwan_ops, NULL, port);
> +	if (IS_ERR(port->w_priv.w_port)) {

[Severity: High]
Can a race condition occur here if wwan_create_port() fails and returns an
error pointer?

Once mtk_port_ch_enable() completes, hardware RX can start. If
wwan_create_port() fails, an ERR_PTR is stored in port->w_priv.w_port
without holding w_lock. Concurrently, the RX interrupt handler could call
mtk_port_wwan_recv():

	mutex_lock(&port->w_priv.w_lock);
	if (!port->w_priv.w_port) {
		mutex_unlock(&port->w_priv.w_lock);
		return -ENXIO;
	}
	wwan_port_rx(port->w_priv.w_port, skb);

Because an ERR_PTR is not NULL, mtk_port_wwan_recv() will pass it to
wwan_port_rx(), which will then dereference the error pointer.

> +		dev_warn(port_mngr->ctrl_blk->mdev->dev,
> +			 "Failed to create wwan port for (%s)\n", port->info.name);
> +		port->w_priv.w_port = NULL;
> +		mtk_port_ch_disable(port);
> +		return;
> +	}
> +
> +	set_bit(PORT_S_WR, &port->status);
> +	set_bit(PORT_S_ENABLE, &port->status);
> +}
> +
