Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504797;
	b=ZpXQogP/tld14YkHV6fyGCWISSWUamcGF5FxEGAVdgmeuiFFkJiL0B5jHOE7a5/p9lhk
	 NHGf0KqHadqdtrm+GPM6sRnhhhIR1NsueAVX+f1imrHSl8QfHQQBzqD+cmgtVd4RU2HYj
	 3f8Tcj6rMy3anQIX2Rvo4vQwWm0r6Cxqm4aUES2mtZlA/PNjUvudqeyOAb4vJRRLyqoeH
	 5O9wrNDmXBoVC6PAGShCWkdQqOUKiS2Nw++wIrbtptRjDd2KZISXMun+VI4F1v/UlnonA
	 QtiRfu/MoCgX7ZwDwuAuafjeWpKc6b3rZxSn2N5fF7fXM+YxumKviPBAVu7/UyK+pug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504797;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ggmLOcruT1G1b2ZukTwuMIVuiyxgrbAXSuX5T2fz/qE=;
	b=fg1i8VyBkz2beL96cKXm9tmV9wxHrURnPdKGJ2fsA/TYba16nCz7+qmizlPBWY2LeQke
	 wL8JgmfPGutALpmVsOvXJEA3NPTA0qu743J2U8wL6KuNUzTPsvChJVyMOFsQLiLatZgNc
	 ByrDNxaX/YIDeQcQQydo4XxeZXNxDy1DZCWbctifUSc0F0y/BF4PPx0efEM/fGKmhPdXv
	 l2W9/chqZmPTXl/mzhhOqdbcqEiKmqRP5wZuPm+7ZMtubZFM2+B5jL7+LzL+O0KtFgryn
	 8OXN4oBPsWc/mQOC/cX/9w/7ZITwUzZlaJfuXFTjKMN7/U843qQ3z2OoqH7Lkc3/q8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OweugKwy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338A606A8A5;
	Thu, 12 Nov 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OweugKwy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76661F000C5;
	Thu, 12 Nov 2026 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504797;
	bh=ggmLOcruT1G1b2ZukTwuMIVuiyxgrbAXSuX5T2fz/qE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OweugKwyvvDT8Lx3qpAUjfosSibH7Y0FQDgkg3Ldpv8GW+Sm31GzCy/B7jbTrilRz
	 haQ64yC9Y75BPLMPTux3hEO0nagkRSIV2DeyfXscg3tpYlGrGQ+yx1j05QGrzM4tyC
	 OqiNelVfHN8NxbxcGJw8rLnFwUgZyQOYQ+nvD5cjDhJXMbLKh0CXm0sWTKijGiqBNS
	 a7tyBQe75y3Jz19hS5jWjP/EeQ+PtVaxYIrymcAv/0CawAFLPAEdUlV27EOmOFPkbj
	 xTvEx6G7ayQ5rob8dWZl7ZS8xYa8hhVgcCid25re2lslt6cpN4u0ZfkyP+lgdimGbT
	 11NP+h+nP5xNg==
Subject: Re: [PATCH net-next v2 2/9] net: sparx5/lan969x: free the FDMA
 buffers on init errors and deinit
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robert.marko@sartura.hr,
 horatiu.vultur@microchip.com, jensemil.schulzostergaard@microchip.com
Date: Thu, 12 Nov 2026 17:33:16 +0000
Message-ID: <179450479633.2199510.4808333993834819818@kernel.org>
In-Reply-To: <20261111-sparx5-mtu-change-v2-2-59c91357e8f6@microchip.com>
References: <20261111-sparx5-mtu-change-v2-2-59c91357e8f6@microchip.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On lan969x, the ownership tracking for RX pages is still
  incomplete in the free_page error path of lan969x_fdma_rx_get_frame().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but both NAPI
  handlers ignore the return value of fdma_dcb_add() when they refill RX…

--

net: sparx5/lan969x: free the FDMA buffers on init errors and deinit

This patch adds sparx5_fdma_rx_free(), lan969x_fdma_rx_free() and
lan969x_fdma_tx_free(). They release the RX skbs/pages, the page_pool,
the TX buffer state and the in-flight TX buffers on init error paths and
on deinit. It also checks the return value of fdma_dcbs_init() for RX,
and stores the mapped TX length so it no longer reads skb->len.

> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> index 053d125eda658..8e0f1ddcbf2c4 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c

[ ... ]

> @@ -90,12 +90,29 @@ static void lan969x_fdma_free_pages(struct sparx5_rx *rx)
>  	struct fdma *fdma = &rx->fdma;
>  
>  	for (int i = 0; i < fdma->n_dcbs; ++i) {
> -		for (int j = 0; j < fdma->n_dbs; ++j)
> +		for (int j = 0; j < fdma->n_dbs; ++j) {
> +			if (!rx->page[i][j])
> +				continue;
> +
>  			page_pool_put_full_page(rx->page_pool,
>  						rx->page[i][j], false);
> +			rx->page[i][j] = NULL;
> +		}
>  	}
>  }

[Severity: High]
Is a non-NULL slot here always a page that the driver still owns?

lan969x_fdma_rx_get_frame() takes its free_page error path when
WARN_ON(!port) fires or build_skb() fails:

free_page:
	page_pool_recycle_direct(rx->page_pool, page);

	return NULL;

That returns the page to the pool, but
rx->page[fdma->dcb_index][fdma->db_index] still points at it.
lan969x_fdma_napi_poll() then breaks out of the loop without advancing
or refilling that DB:

		skb = lan969x_fdma_rx_get_frame(sparx5, rx);
		if (!skb)
			break;

On a later teardown through
lan969x_fdma_deinit()->lan969x_fdma_rx_free()->lan969x_fdma_free_pages(),
wouldn't page_pool_put_full_page() run on that stale slot a second time?

A page in the pool cache still has pp_ref_count == 1. So
page_pool_unref_netmem() takes the second put as the last reference and
recycles the page again, this time into the ptr_ring, while it also
sits in the alloc cache. page_pool_destroy() would then DMA-unmap the
page twice and call put_page() on it twice.

The commit message says:

  "To know which RX buffers are still owned by the driver, clear the RX
  buffer slot once the buffer has been passed to the stack on Sparx5, and
  make lan969x_fdma_free_pages() skip and clear the empty slots of the
  ring."

However, lan969x does not clear any slot at this commit. A later patch
in the series, "net: sparx5/lan969x: add support for resizing the FDMA
buffers", fixes the success path: it sets rx->page[...] = NULL before
returning the skb. The free_page path still leaves the slot set there.

That later patch also adds lan969x_fdma_resize(), which calls
lan969x_fdma_rx_free() on an MTU change. After it, the double put can
happen without an unbind.

Separately, and this part predates the patch: the stuck DB stays DONE,
so the next poll processes the same, already recycled page again. If
build_skb() succeeds that time, the stack gets an skb on a page that
the refill can hand straight back to the hardware.

Would it work to set rx->page[fdma->dcb_index][fdma->db_index] = NULL
after page_pool_recycle_direct()? The poll loop would also need to
consume or refill that DB, or reuse the page in place, instead of
recycling the page while the DB still references it.

[ ... ]

> @@ -169,14 +186,18 @@ static int lan969x_fdma_rx_alloc(struct sparx5 *sparx5)
>  		return PTR_ERR(rx->page_pool);
>  
>  	err = fdma_alloc_coherent(sparx5->dev, fdma);
> -	if (err)
> +	if (err) {
> +		page_pool_destroy(rx->page_pool);
>  		return err;
> +	}
>  
> -	fdma_dcbs_init(fdma,
> -		       FDMA_DCB_INFO_DATAL(fdma->db_size),
> -		       FDMA_DCB_STATUS_INTR);
> +	err = fdma_dcbs_init(fdma,
> +			     FDMA_DCB_INFO_DATAL(fdma->db_size),
> +			     FDMA_DCB_STATUS_INTR);
> +	if (err)
> +		lan969x_fdma_rx_free(sparx5);
>  
> -	return 0;
> +	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but the same allocation
failure is still unchecked when the RX DCBs are refilled at runtime. The
patch only adds the check at init time.

lan969x_fdma_napi_poll() ignores the return value of fdma_dcb_add():

		fdma_dcb_add(fdma,
			     old_dcb,
			     FDMA_DCB_INFO_DATAL(fdma->db_size),
			     FDMA_DCB_STATUS_INTR);

So does sparx5_fdma_napi_callback() in sparx5_fdma.c:

		fdma_dcb_add(fdma, fdma->dcb_index,
			     FDMA_DCB_INFO_DATAL(fdma->db_size),
			     FDMA_DCB_STATUS_INTR);

__fdma_db_add() in fdma_api.c writes the status, with DONE cleared,
before it calls the dataptr callback:

	db->status = cpu_to_le64(status);

	err = cb(fdma, dcb_idx, db_idx, &dataptr);
	if (unlikely(err))
		return err;

Suppose page_pool_dev_alloc_pages() in lan969x_fdma_rx_dataptr_cb() or
the GFP_ATOMIC __netdev_alloc_skb() in sparx5_fdma_rx_dataptr_cb()
fails. __fdma_dcb_add() then returns before it links the DCB or updates
fdma->last_dcb. The next successful add links around that DCB, so the
hardware skips it.

Once dcb_index wraps around to that DCB, fdma_has_frames() and
fdma_db_is_done() return false. Would both NAPI handlers then stop at
that DCB on every poll? The hardware would fill the remaining DCBs, but
nothing would consume or refill them, and CPU RX would stay stalled
until the driver is rebound.

This code is unchanged through the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-sparx5-mtu-change-v2-0-59c91357e8f6%40microchip.com
