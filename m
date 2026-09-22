Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C373603DB;
	Tue, 22 Sep 2026 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038736; cv=none; b=kRO+w72X12EBLXaoCQAqZxhrabJVzXiTO3oLY0RFQMbKZgztBb5LzPR8d9cTz9xiJkKnQ/EQRcIGRp6JLDOSNXezElYFvoNFMOCn0wwnH3x7izI/Okejhb0C5zzpjBjj+KXp1VSlEYUvGJ/5p4d78k0TPkm6uuJftKjt/wqT2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038736; c=relaxed/simple;
	bh=l909XGm6eBBMzKUUBv6UpyGFHCHDdRMO5eOMGIbCwn8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DRmcz1tHKu6ol/T+rblpDYjPiaZRumH7wEnTTEO74dMvMVhOtRQNiAvel6tG5hJAhuB/IugRo1vWmjS1RPIa83+ceO18avpvIaLNv2uiqOvN2qa0JnYjjvmTb+FJnuJ0n2Iar0hA40/DrC+OzDplOzuBlv/OVM8HJt2KFOHV0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhDPnt54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhDPnt54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D308E1F00893;
	Tue, 22 Sep 2026 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038730;
	bh=5BAi9LtIieOM2oFzIIdZq9pwPlnS3Ex++aKIcJwrQ3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UhDPnt54OIumCf29R+TGIbiyfgr0j9uv1IEZ2fLD/YekjOVSONOE+7HEuBD9GrDWX
	 FXAQo8NIHh0Jy0nG5JPTlK5FAwbVP6gjNoqZJDqYCQPqe+j65/JDkQ7vFA3qOmGpeh
	 FkhXQmWLUzv35IWpImVesYi8PmHQ1gj6xD+MupengX/jkv4oWExi6WV3GRaoBew80m
	 7Bf2riJB+9yfkXSwqDTKuCXpGi8ReXK43XfB56pyCVuB8Mu7RlcNQr7bbPBRaY0Osk
	 QW/pTr4Z7glTUFAxx0S4LAS3ur5lXtkVgueF7BchgQGiIRPh3Qb5SjpIlKYYh9JaHI
	 +bOmFInn48V+Q==
Subject: Re: [PATCH net 4/8] net: bcmgenet: clean up RX NAPI on
 bcmgenet_init_rx_queues failure
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, cursoragent@cursor.com, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Tue, 22 Sep 2026 00:58:49 +0000
Message-ID: <179003872944.2160803.11801967410285161084@kernel.org>
In-Reply-To: <20260918000732.276506-5-florian.fainelli@broadcom.com>
References: <20260918000732.276506-5-florian.fainelli@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] New error path in bcmgenet_init_dma() calls
  bcmgenet_fini_rx_napi(priv) after bcmgenet_init_rx_queues() failed.
- [Medium] The commit message's premise is not reachable in any supported
  configuration: it claims that 'If bcmgenet_init_rx_queues() fails…
- [Low] The commit message trailer block contains a Gerrit-generated
  'Change-Id: I45982e0e198a44f3f56b1300f462870462b81108' line.

--

net: bcmgenet: clean up RX NAPI on bcmgenet_init_rx_queues failure

This adds a bcmgenet_fini_rx_napi(priv) call to the error path of
bcmgenet_init_dma() when bcmgenet_init_rx_queues() fails, with the goal of
removing NAPI instances that were already registered by earlier iterations
of the ring initialization loop.  A few questions below about the added
call and about the commit message.

> net: bcmgenet: clean up RX NAPI on bcmgenet_init_rx_queues failure
>
> bcmgenet_init_rx_ring() registers a NAPI instance for each RX ring via
> netif_napi_add(). If bcmgenet_init_rx_queues() fails while initializing
> subsequent rings, bcmgenet_init_dma() frees the RX buffers and page pools
> but fails to clean up already registered NAPI instances with
> bcmgenet_fini_rx_napi(). This leaves stale NAPI structs on the net_device
> napi_list.

[Severity: Medium]
Is the scenario quoted above reachable on any supported hardware?  All four
hardware parameter tables (bcmgenet_hw_params_v1 through
bcmgenet_hw_params_v4) set:

	.rx_queues = 0,
	.rx_bds_per_q = 0,

and bcmgenet_set_hw_params() only ever selects one of those constant
tables, so the loop in bcmgenet_init_rx_queues():

	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
		ret = bcmgenet_init_rx_ring(priv, i, end - start, start, end);
		if (ret)
			return ret;

runs exactly once, for i == 0.  With only one RX ring there is no
"subsequent rings" case, and both failure returns in
bcmgenet_init_rx_ring() happen before netif_napi_add() runs, so no NAPI
instance is registered when the single ring fails.

Given that, should the Fixes: 1c1008c793fa tag be dropped so this is not
backported to stable as a fix for a leak that cannot happen, and the change
described as preparation for multiple RX rings instead?  Or is there a
configuration where rx_queues is non-zero that I am missing?

> Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> Assisted-by: LLM
> Co-authored-by: Cursor <cursoragent@cursor.com>
> Change-Id: I45982e0e198a44f3f56b1300f462870462b81108

[Severity: Low]
The Gerrit Change-Id trailer should be removed before submitting upstream;
scripts/checkpatch.pl flags it as an error.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index bfb74dca55d6f..ef155a170fa62 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3167,6 +3167,7 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
>  	ret = bcmgenet_init_rx_queues(priv->dev);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to initialize Rx queues\n");
> +		bcmgenet_fini_rx_napi(priv);

[Severity: High]
Can this dereference a NULL net_device on the first open after probe?

bcmgenet_fini_rx_napi() deletes every ring's NAPI unconditionally, with no
check that netif_napi_add() ever ran for that ring:

	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
		ring = &priv->rx_rings[i];
		netif_napi_del(&ring->napi);
	}

In bcmgenet_init_rx_ring(), both failure returns are taken before the NAPI
instance is registered:

	ret = bcmgenet_rx_ring_create_pool(priv, ring);
	if (ret)
		return ret;

	ret = bcmgenet_alloc_rx_buffers(priv, ring);
	if (ret) {
		...
		return ret;
	}
	...
	/* Initialize Rx NAPI */
	netif_napi_add(priv->dev, &ring->napi, bcmgenet_rx_poll);

priv->rx_rings[] lives inside the zeroed netdev_priv() area, so on the first
bcmgenet_open() ring->napi.dev is still NULL for a ring that failed.
netif_napi_del() does not tolerate that, because the netdev lock is taken
through napi->dev before the NAPI_STATE_LISTED check can bail out:

include/linux/netdevice.h:__netif_napi_del() {
	netdev_lock(napi->dev);
	__netif_napi_del_locked(napi);
	netdev_unlock(napi->dev);
}

net/core/dev.c:__netif_napi_del_locked() {
	netdev_assert_locked(napi->dev);

	if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
		return;
	...
}

So an -ENOMEM from page_pool_create() or bcmgenet_alloc_rx_buffers() on
ring 0 during "ip link set eth0 up" would reach
netif_napi_del(&priv->rx_rings[0].napi) with napi.dev == NULL and fault
inside mutex_lock().

>  		bcmgenet_free_rx_buffers(priv);
>  		bcmgenet_destroy_rx_page_pools(priv);
>  		kfree(priv->rx_cbs);

As a side effect of the above, would the rest of this cleanup
(bcmgenet_free_rx_buffers(), bcmgenet_destroy_rx_page_pools(),
kfree(priv->rx_cbs), kfree(priv->tx_cbs)) also be skipped, since the oops
happens before they run?

Would it work better to unwind only the NAPI instances that were actually
registered, for example by deleting indices below the failing one inside
bcmgenet_init_rx_queues(), or by skipping rings where ring->napi.dev is
NULL?

This call is still present at the tip of the series, so it does not look
like a later patch changes it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918000732.276506-1-florian.fainelli%40broadcom.com
