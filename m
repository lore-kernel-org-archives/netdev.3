Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5120B80B;
	Tue,  6 Oct 2026 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326144; cv=none; b=kx0IBvGSx+XqsRRe1xxT9rBWpTLTubuGAT7sfw7bTpEM9HaeS1yJKWdrYtCL0KfF6JiQSWsQLSkzCeUk0BWzEhHPMGaIQCq02ub+3lQQdnowV54Dj6selFRhalBQ89zc6t3/AC+Uwy7ijzJ2FOeq/dJFNd9eR4YCY0Nldw0lmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326144; c=relaxed/simple;
	bh=XjGxIEExuhJQGEjuLPjHP1TujX1Z4bzMvtz9FuKuSoQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUYITAzKhLCM4t4hhVTWKjZd9Qx68EQCw2/C+JtqBQSOnTsXLDYngC6zp8CJJpu3L+8ASPNmzD4OLcLgbMgIRALsscSm1F4og7GeIi7kdzF295beN6svQ8Hwh2tT9FghYa7MmPd3FTauEMK9Yc/wCrDdgr/SzHbXI2kshXt3jXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEUpKuLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEUpKuLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8AB1F0089B;
	Tue,  6 Oct 2026 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326142;
	bh=Ft96ifXF9GC+FD/wP8b+OMx8w6TpCihQ5+rc3xDFTKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SEUpKuLmqfShpOI1gt3IQ4UQh9OkNy0Gx6pzphrXc12XVO5RAn+b0QImA9Q1Ta+FQ
	 6jmH0lwtRVBUDn3MW/pLpETiEFz2MVxKuNO2IkQcb6vf6JhO1y9M+ZiXFZjgNq/e3n
	 tigWCyLRAAVvYJTkfwr7IaoUGArYE0US5e6OgLM8hJeoodptzf7/9lnvjsPYOFRZnN
	 +V8vLc+CgCSXVpXHAn5LAbao2f74YEffr9tfNsRbUYbj5Ox+mQ8mjLmsvkP3FdOHjs
	 V5JEfwreObePxoNyAqB6tCyYW09u3XFRxDNAg/UuhnpIb8Og5az4V/7oS0M2M1St2A
	 CgjoEAkig5yyg==
Subject: Re: [PATCH net-next v2 4/7] net: bcmgenet: derive the receive buffer
 length from the MTU
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Tue, 06 Oct 2026 22:35:41 +0000
Message-ID: <179132614173.434549.15814997167610844687@kernel.org>
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-4-c4be21151912@tipi-net.de>
References: <20261006-nb-genet-mtu-nn-v2-v2-4-c4be21151912@tipi-net.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch also changes what bcmgenet_init_tx_ring() writes into
  each transmit ring's DMA_RING_BUF_SIZE register, and the commit…

--

net: bcmgenet: derive the receive buffer length from the MTU

This patch replaces the fixed 2048 byte RX_BUF_LENGTH with
priv->rx_buf_len. That value comes from an RBUF packet ready threshold
computed from the MTU, plus the 64 byte status block. It also programs
the RBUF and TBUF packet ready threshold registers. The TBUF threshold
is set to its maximum.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 641d918577d4d..75d1006a35c55 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2623,6 +2641,44 @@ static void bcmgenet_link_intr_enable(struct bcmgenet_priv *priv)

[ ... ]

> +/* A buffer has to hold everything the threshold lets the hardware deliver */
> +static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
> +{
> +	return sizeof(struct status_64) +
> +	       bcmgenet_pkt_rdy_thld(mtu) * ENET_THLD_UNIT;
> +}

[ ... ]

> @@ -2755,7 +2811,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
>  				  TDMA_FLOW_PERIOD);
>  	bcmgenet_tdma_ring_writel(priv, index,
>  				  ((size << DMA_RING_SIZE_SHIFT) |
> -				   RX_BUF_LENGTH), DMA_RING_BUF_SIZE);
> +				   priv->rx_buf_len), DMA_RING_BUF_SIZE);

[Severity: Low]
Is this change to the transmit ring intended? The commit message only
talks about the receive buffer and the RBUF/TBUF thresholds. It doesn't
mention that bcmgenet_init_tx_ring() now writes a different value into
each TDMA ring's DMA_RING_BUF_SIZE register.

Before the patch, the TX rings got the constant 2048. With this patch
they get priv->rx_buf_len, which bcmgenet_rx_buf_len() computes as:

    sizeof(struct status_64) + bcmgenet_pkt_rdy_thld(mtu) * 16

That is 64 + 2048 = 2112 at the default MTU. The new value includes the
64 byte RX status block, which only the receive side writes.

This sentence in the commit message reads as if it describes the RX
page pool buffer only:

    "the buffer only grows by the status block the hardware already
    wrote."

The TX ring already took its value from an RX-named constant, so this
coupling is not new. What is new is that it now follows the MTU.

With the later "net: bcmgenet: allow the MTU to be changed" patch in
this series, every RX buffer resize would also reprogram the TX rings.
That reaches 3648 on 4K pages and 3904 on 64K pages.

Each TX descriptor carries its own length in len_stat, so this may have
no functional effect. Should the TX ring keep its own value here? If
the change is intended, could the commit message say so?

>  
>  	/* Set start and end address, read and write pointers */
>  	bcmgenet_tdma_ring_writel(priv, index, start_ptr * words_per_bd,

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> index 501dd12566936..6444bac168c38 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h

[ ... ]

> @@ -612,6 +615,7 @@ struct bcmgenet_priv {
>  	void __iomem *rx_bds;
>  	struct enet_cb *rx_cbs;
>  	unsigned int num_rx_bds;
> +	unsigned int rx_buf_len;

This field is declared with the receive variables, but
bcmgenet_init_tx_ring() above also uses it to configure the transmit
rings.

>  	struct bcmgenet_rxnfc_rule rxnfc_rules[MAX_NUM_OF_FS_RULES];
>  	struct list_head rxnfc_list;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912%40tipi-net.de
