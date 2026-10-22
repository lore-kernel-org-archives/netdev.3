Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640048;
	b=NCV6BtaBMsRoYmIlrVhW8DXGHCva3WnVAOubwZl6KAIP65n2C/0T6DIzbhXeZ0nZezd4
	 rPc2DufRwhvYQR8qk38MXGdkFjgNAKqKUXG6+JmvHtoDtG3WX4anh7L9VI2JDHL3dQ4lA
	 L0ErevuLrdCz3dZlGE9pYgWkGCqHJ72v5lFJ61JxUlT378cXmXAwFY0/VfXURNoWmv9YT
	 zFT1uy69kflE4UGqVwKsM168Z5h8wuu6o3TQxQZWC9/BmaKWaaiBYv1VhLJ8cznuAMsNE
	 xUWurll8dGLFPu/1pbewuN1uAr6W1CL4E4eCj/0CwvzvSvaoD7VEsKjWYnsyxdl3MWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640048;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SEGrhXgHJfgMBBg2vcUQnnN5b9aVBxoqnDNEUXIG1Fk=;
	b=K67Id/euOnjJnUYeyRImC7PWovx/nr4lsNS/0ZCGHb3q95Rl/A6WXFhUXPSGYbkQ0dRD
	 SPNiAKFDQlq6yT5xnw0Ndd+HBAzpLGnw9B7YX6GVk5nM6tuutXGxrhd+ThlMB0RPAK9nl
	 2c28ugrMKOUIKT5y4onvdckDLGX9FTI8QzV3pv/gwqlIcFXZhe+eDD9tsH1QctYal/UOd
	 lZEOKX31YA7pWIvaELjwrDu01UNdaFoKaOErp9ueSqhOtnctW3TyvVi++sOHk9F6M/E4R
	 sfCBJtt6p4k+b6k5mfxXeyBYNtAFvyEyWjlRCUkn8VuICvr7NftxkAeJVIJA+AwsR9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYyd79HP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16888606A319;
	Thu, 22 Oct 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYyd79HP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039C81F000C2;
	Thu, 22 Oct 2026 03:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640047;
	bh=SEGrhXgHJfgMBBg2vcUQnnN5b9aVBxoqnDNEUXIG1Fk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MYyd79HPlugYkAxFMWmbH2I5w5e3UrgAY3xPtHyAR+oX+9n/wwhb426Jthvx13bx6
	 qBjEJgbxeZGfrdWwWXtVtJBWu/1deZYNcdyaUpUu/uj0nlamsYoQSiS0DTwGA03m1V
	 ICd/nwXjYmezea0JebH1TbeN7Vm5TbEf2qN18ChG75qBDPrrJ7AyGpiiFYDQEeVAar
	 Gp6Syfx26MEB87rNkpaVHN/qFJhyrm7u4oehEiKdj/h+A8kO9xOZH6dcmSD7RseD7x
	 qGYA89RzD/YWxDwZDSU6CXIfLRd/bhyQ2oKJeSzZrGu+EbsmsMNlfiju8tY7PTRwEO
	 X6UsRgEKry4pA==
Subject: Re: [PATCH net v5 1/3] xfrm: run the receive callback before dropping
 the skb->dev reference
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 03:34:06 +0000
Message-ID: <179264004653.3135.12987803127398532748@kernel.org>
In-Reply-To: <20261019153247.89957-2-q.h.hack.winter@gmail.com>
References: <20261019153247.89957-2-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The tunnel-mode (decaps) success exit of xfrm_input() in
  net/xfrm/xfrm_input.c still runs `if (async) dev_put(dev);` before…

--

xfrm: run the receive callback before dropping the skb->dev reference

On the drop path of xfrm_input(), this commit moves xfrm_rcv_cb() so it
runs before the async skb->dev reference is released. It also changes
the early drop for a state that is no longer valid: instead of calling
dev_put() itself, that path now leaves the reference to the drop label.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 5ed87d51392a..94de4f698c33 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c

[ ... ]

> @@ -779,9 +779,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  drop_unlock:
>  	spin_unlock(&x->lock);
>  drop:
> +	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
>  	if (async)
>  		dev_put(dev);
> -	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
>  	kfree_skb(skb);
>  	return 0;
>  }

[Severity: High]
The commit message says the new order matches what "the success path
does". Is that true of the tunnel mode (decaps) exit of xfrm_input()?
That exit still drops the async reference before it passes the skb to
gro_cells_receive():

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
	if (decaps) {
		...
		if (async)
			dev_put(dev);
		gro_cells_receive(&gro_cells, skb);
		rcu_read_unlock();
		return 0;
    ...
}

gro_cells_receive() then dereferences skb->dev:

net/core/gro_cells.c:gro_cells_receive() {
	struct net_device *dev = skb->dev;
	...
	if (unlikely(!(dev->flags & IFF_UP)))
		goto drop;
	...
drop:
	dev_core_stats_rx_dropped_inc(dev);
	...
}

In plain policy-based ESP/AH tunnel mode, no xfrmi or vti callback
replaces skb->dev. So skb->dev is the same lower device whose reference
was just released.

Suppose an async crypto completion runs while the lower device is being
unregistered:

esp_input_done()
  xfrm_input_resume()
    xfrm_input(skb, nexthdr, 0, -1)

Can the device refcount reach 1 after this dev_put()?

netdev_wait_allrefs_any() in net/core/dev.c returns as soon as
netdev_refcnt_read(dev) == 1. netdev_run_todo() then frees the device
without waiting for a grace period, so the rcu_read_lock() held here
does not seem to keep the device alive.

If the device is going away, IFF_UP is already clear. In that case
gro_cells_receive() would take its drop branch and write the core stats
of a net_device that may already be freed.

This ordering came in with 1c428b038400, the commit named in the Fixes:
tag, and 8045c0df98d4 kept it. It also seems to survive the later commit
"xfrm: hold the tunnel device reference across the input path", which
only adds tdev handling around gro_cells_receive().

Since dev is already saved in a local variable, could the decaps branch
also move the if (async) dev_put(dev) below gro_cells_receive()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019153247.89957-1-q.h.hack.winter%40gmail.com
